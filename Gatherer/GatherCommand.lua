--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GatherCommand.lua 754 2008-10-14 04:43:39Z Esamynn $

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

	Command parsing and processing
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherCommand.lua $", "$Rev: 754 $")

SLASH_GATHERER1 = "/gather"
SLASH_GATHERER2 = "/gatherer"
SlashCmdList["GATHERER"] = function( msg )
	Gatherer.Command.Process(msg)
end

local function PrintUsageLine( cmd, curSetting, description )
	if ( curSetting ) then
		Gatherer.Util.ChatPrint(format("  |cffffffff/gatherer %s|r |cff2040ff[%s]|r - %s", cmd, curSetting, description))
	else
		Gatherer.Util.ChatPrint(format("  |cffffffff/gatherer %s|r - %s", cmd, description))
	end
end

local function parseOnOff( str )
	if ( str == "on" or str == "true" or str == "1" ) then
		return true
	elseif ( str == "off" or str == "false" or str == "0" ) then
		return false
	else
		return nil
	end
end

local function parseGatherType( str )
	if ( str == "treasure" ) then
		return "open"
	elseif ( str == "herbs" ) then
		return "herb"
	elseif ( str == "ore" ) then
		return "mine"
	end
end

function Gatherer.Command.Process( command )
	local Config = Gatherer.Config
	command = command:trim():gsub("%s+", " ")
	if ( command == "" or command == "options" ) then
		Config.MakeGuiConfig()
		Config.Gui:Show()
	else
		local cmd, p1, p2, p3, p4 = string.split(" ", command:lower())
		local GetSetting = Config.GetSetting
		local Print = Gatherer.Util.ChatPrint
		
		if ( cmd == "help" ) then
			local useMinimap = GetSetting("minimap.enable") and "on" or "off"
			local useMainmap = GetSetting("mainmap.enable") and "on" or "off"
			local showHerbs = GetSetting("show.minimap.herb") and "on" or "off"
			local showOre = GetSetting("show.minimap.mine") and "on" or "off"
			local showTresure = GetSetting("show.minimap.open") and "on" or "off"
			
			Print("Usage:")
			PrintUsageLine("minimap (on|off|toggle)", useMinimap, "turns the gather minimap display on and off")
			PrintUsageLine("mainmap (on|off|toggle)", useMainmap, "turns the gather mainmap display on and off")
			PrintUsageLine("dist <n>", GetSetting("minimap.distance"), "sets the maximum search distance for display ([100, 5000], default=800)")
			PrintUsageLine("num <n>", GetSetting("minimap.count"), "sets the maximum number of items to display (default=20, up to 50)")
		--	PrintUsageLine("fdist <n>", SETTINGS.fadeDist, "sets a fade distance (in units) for the icons to fade out by (default = 20)")
		--	PrintUsageLine("fperc <n>", SETTINGS.fadePerc, "sets the percentage for fade at max fade distance (default = 80 [=80% faded])")
		--	PrintUsageLine("theme <name>", SETTINGS.iconSet, "sets the icon theme: original, shaded (default), iconic or iconshade")
		--	PrintUsageLine("idist <n>", SETTINGS.miniIconDist, "sets the minimap distance at which the gather icon will become iconic (0 = off, 1-60 = pixel radius on minimap, default = 40)")
			PrintUsageLine("herbs (on|off|toggle)", showHerbs, "select whether to show herb data on the minimap")
			PrintUsageLine("ore (on|off|toggle)", showOre, "select whether to show mining data on the minimap")
			PrintUsageLine("treasure (on|off|toggle)", showTresure, "select whether to show treasure data on the minimap")
			PrintUsageLine("options", nil, "show/hide UI Options dialog.")
		--	PrintUsageLine("report", nil, "show/hide report dialog.")
		--	PrintUsageLine("search", nil, "show/hide search dialog.")
		--	PrintUsageLine("loginfo (on|off)", nil, "show/hide logon information.")
		--	PrintUsageLine("filterrec (herbs|mining|treasure)", nil, "link display filter to recording for selected gathering type")
		
		elseif ( cmd == "minimap" ) then
			local enabled = parseOnOff(p1)
			if ( enabled == true ) then
				Config.SetSetting("minimap.enable", true)
				Print("Turned Gatherer minimap display on")
			
			elseif ( enabled == false ) then
				Config.SetSetting("minimap.enable", false)
				Print("Turned Gatherer minimap display off (still collecting)")
			
			elseif ( p1 == "toggle" ) then
				if ( Config.GetSetting("minimap.enable") ) then
					Gatherer.Command.Process( "minimap off" )
				else
					Gatherer.Command.Process( "minimap on" )
				end
			
			else
				
			
			end
		
		elseif (cmd == "mainmap") then
			local enabled = parseOnOff(p1)
			if ( enabled == true ) then
				Config.SetSetting("mainmap.enable", true)
				Print("Displaying notes in main map")
			
			elseif ( enabled == false ) then
				Config.SetSetting("mainmap.enable", false)
				Print("Not displaying notes in main map")
			
			elseif ( p1 == "toggle" ) then
				if ( Config.GetSetting("mainmap.enable") ) then
					Gatherer.Command.Process( "mainmap off" )
				else
					Gatherer.Command.Process( "mainmap on" )
				end
			
			else
				
			
			end
		
		elseif ( (cmd == "dist") or (cmd == "distance") ) then
			local newDist = tonumber(p1)
			if ( newDist and 100 <= newDist and newDist <= 5000 ) then
				newDist = newDist - newDist % 50
				Config.SetSetting("minimap.distance", newDist)
				Print("Setting maximum note distance to "..newDist)
			end
		
		elseif ( (cmd == "num") or (cmd == "number") ) then
			local newCount = tonumber(p1)
			if ( newCount and 1 <= newCount and newCount <= 50 ) then
				newCount = floor(newCount)
				Config.SetSetting("minimap.count", newCount)
				Print("Displaying up to "..newCount.." notes at once")
			end
		
		elseif ( (cmd == "herbs") or (cmd == "ore") or (cmd == "treasure") ) then
			local gatherType = parseGatherType(cmd)
			if ( gatherType ) then
				local enabled = parseOnOff(p1)
				if ( enabled == true ) then
					local cmd = (cmd == "herbs") and "herb" or cmd
					Config.SetSetting("show.minimap."..gatherType, true)
					Print("Displaying "..cmd.." notes on minimap")
				
				elseif ( enabled == false ) then
					local cmd = (cmd == "herbs") and "herb" or cmd
					Config.SetSetting("show.minimap."..gatherType, false)
					Print("Not displaying "..cmd.." notes in minimap")
				
				elseif ( p1 == "toggle" ) then
					if ( Config.GetSetting("show.minimap."..gatherType) ) then
						Gatherer.Command.Process( cmd.." off" )
					else
						Gatherer.Command.Process( cmd.." on" )
					end
				
				else
					
				
				end
			end
		end
	end
end
