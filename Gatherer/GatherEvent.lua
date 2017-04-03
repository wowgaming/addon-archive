--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GatherEvent.lua 869 2009-08-05 19:54:12Z Esamynn $

	License:
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program(see GPL.txt); if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Event handling routines
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherEvent.lua $", "$Rev: 869 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

function Gatherer.Event.RegisterEvents( frame )
	frame:RegisterEvent("WORLD_MAP_UPDATE")
	frame:RegisterEvent("CLOSE_WORLD_MAP"); -- never triggered apparently
	frame:RegisterEvent("LEARNED_SPELL_IN_TAB"); -- follow current skills
	frame:RegisterEvent("SPELLS_CHANGED"); -- follow current skills
	frame:RegisterEvent("SKILL_LINES_CHANGED"); -- follow current skills
	frame:RegisterEvent("UI_ERROR_MESSAGE"); -- track failed gathering
	frame:RegisterEvent("ZONE_CHANGED_NEW_AREA") -- for updating the minimap when we change zones
	frame:RegisterEvent("MINIMAP_UPDATE_TRACKING") -- for updating minimap when tracking changes

	-- Events for off world non processing
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("PLAYER_LEAVING_WORLD")

	-- Addon Loaded and player login/logout events
	frame:RegisterEvent("ADDON_LOADED")
	frame:RegisterEvent("PLAYER_LOGIN")
	frame:RegisterEvent("PLAYER_LOGOUT")

	-- Communications
	frame:RegisterEvent("CHAT_MSG_ADDON")
end

function Gatherer.Event.OnLoad()
	Gatherer_Manifest.Validate()
	
	Gatherer.SpecialCases.ProcessSpecialCases()
	
	local hookFunc = function( ... ) Gatherer.Event.OnSwag(...) end
	LibSwag.RegisterHook("Gatherer", hookFunc, hookFunc)
	LibSwag.Init()
	
	Gatherer.Config.Load()
	Gatherer.DropRates.Load()
	Gatherer.Var.Loaded = true
	
	Gatherer.MapNotes.Update()
	Gatherer.MiniNotes.Show()
	
	Gatherer.MiniIcon.Reposition()
	Gatherer.MiniIcon.Update()
	
	--Gatherer.Plugins.LoadPluginData()
	
	if ( Gatherer.Config.GetSetting("about.loaded") ) then
		Gatherer.Util.ChatPrint("Gatherer v"..Gatherer.Var.Version.." -- Loaded!")
	end
end

function Gatherer.Event.OnEvent( event, ... )
	if (event == "PLAYER_ENTERING_WORLD" ) then
		Gatherer.MiniNotes.Show()

	elseif (event == "PLAYER_LEAVING_WORLD" ) then
		Gatherer.MiniNotes.Hide()

	elseif (event == "WORLD_MAP_UPDATE") then
		Gatherer.MapNotes.MapDraw()
	
	elseif ( event == "CLOSE_WORLD_MAP") then
		Gatherer.MapNotes.MapDraw()

	elseif( event == "ADDON_LOADED" ) then
		local addon = select(1, ...)
		if (addon and string.lower(addon) == "gatherer") then
			Gatherer.Event.OnLoad()
		end
	
	elseif ( event == "PLAYER_LOGIN" ) then
		Gatherer.Util.StartClientItemCacheRefresh()
		Gatherer.Util.GetSkills()
		Gatherer.Plugins.LoadPluginData() -- * FIX for borked LoadAddOn *
	
	elseif ( event == "PLAYER_LOGOUT" ) then
		Gatherer.Config.Save()
		Gatherer.DropRates.Save()
	
	elseif ( event == "LEARNED_SPELL_IN_TAB" ) then
		Gatherer.Util.GetSkills()
	
	elseif ( event == "SPELLS_CHANGED" ) then
		Gatherer.Util.GetSkills()
	
	elseif ( event == "SKILL_LINES_CHANGED" ) then
		Gatherer.Util.GetSkills()
	
	elseif ( event == "MINIMAP_UPDATE_TRACKING" ) then
		Gatherer.MiniNotes.ForceUpdate()
	
	elseif ( event == "CHAT_MSG_ADDON" ) then
		local prefix, msg, how, who = select(1, ...)
		if ( prefix == "GathX" ) then
			Gatherer.Comm.Receive( msg, how, who )
		elseif ( prefix == "Gatherer" ) then
			Gatherer.Comm.General(msg, how, who)
		end
		
	elseif ( event == "ZONE_CHANGED_NEW_AREA" ) then
		Gatherer.MiniNotes.Show()
	
	elseif ( event == "UI_ERROR_MESSAGE" ) then
		local msg =  select(1, ...)
		local skill = Gatherer.Util.ParseFormattedMessage(ERR_USE_LOCKED_WITH_ITEM_S, msg)
		if not ( skill ) then
			skill = Gatherer.Util.ParseFormattedMessage(ERR_USE_LOCKED_WITH_SPELL_KNOWN_SI, msg)
		end

		-- Check if there was a skill mentioned, then check to see if we're moused over a valid object
		if ( skill ) then
			LibSwag.SetTooltip()
			local tooltip = LibSwag.GetLastTip()
			if not ( tooltip ) then return end
			local tip = tooltip.tip

			local objId = Gatherer.Nodes.Names[tip]
			if ( objId ) then
				-- We have a mouseover on a valid object that's just fired off
				-- a "Requires" message.
				local gType = Gatherer.Nodes.Objects[objId]
				Gatherer.Api.AddGather(objId, gType, tip, "REQUIRE", 0, {}, false)
			end
		end
	
	elseif ( event ) then
		Gatherer.Util.Debug("Gatherer Unknown event: "..event)
	end
end

function Gatherer.Event.OnSwag(lootType, lootTable, coinAmount, extraData)
	Gatherer.Util.Debug("Gatherer.Event.OnSwag", lootType)
	if (lootType ~= "KILL") then
		local node = "Unknown"
		if (extraData and extraData.tip) then node = extraData.tip end
		
		local object = Gatherer.Nodes.Names[node]
		if (not object) then return end
		
		local objectType = Gatherer.Nodes.Objects[object]
		if (objectType ~= lootType) then return end
		
		-- increments only if both lootTable and coinAmount are non-nil
		Gatherer.Api.AddGather(object, lootType, storagetip, nil, coinAmount, lootTable, (lootTable and coinAmount))
	end
end
