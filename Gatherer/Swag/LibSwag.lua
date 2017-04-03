--[[

	LibSwag - A library to help you keep track of all your swag.

	Revision: $Id: LibSwag.lua 730 2008-05-19 23:09:27Z Esamynn $

	License:
		This library is free software; you can redistribute it and/or
		modify it under the terms of the GNU Lesser General Public
		License as published by the Free Software Foundation; either
		version 2.1 of the License, or (at your option) any later version.

		This library is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
		Lesser General Public License for more details.

		You should have received a copy of the GNU Lesser General Public
		License along with this library; if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

-----------------------------------------------------------------------------------

USAGE:

  * Add LibSwagData to your addons .toc file as a SavedVariable
  * Call LibSwag.Init() when your addon is fully loaded (ie your SV's are loaded)
  * Call LibSwag.RegisterHook( <<yourLootFunction>>, <<yourCastFunction>> ) to recieve swag data.

yourCastFunction will be called at the start of any cast-based gather (other than fishing)
yourLootFunction will be called when the lootbox pops up at the end of gathers.
They will both be called with the following parameters:
  yourFunction(lootType, lootTable, coinAmount, extraData)
    * lootType is a string and will be one of:
    	KILL, FISH, SKIN, MINE, HERB or OPEN
    * lootTable is an array of tables with the following format:
    	{ { link = "...", name = "...", count = ... }, ... }
		(this value will always be nil for yourCastFunction)
    * coinAmount is the amount of coinage in the loot (in copper)
		(this value will always be nil for yourCastFunction)
    * extraData is a table whose contents is dependant on the lootType:
    	For SKIN, MINE, HERB and OPEN: { tip = "...", time = "..." }
  		For KILL: { unit = "...", level = ... }
  		Everything else: nil

]]

-- Note, you should add this to your addon's SavedVariables
LibSwagData = {}
local myVersion = 0109

-- Check versioning to see if we need to upgrade the existing library
local create = false
local update = false
if (not LibSwag) then
	create = true
elseif (LibSwag.version < myVersion) then
	update = true
end

local log

-- If there's something for us to do, then build the library functions
if (create or update) then
	local myLib = {}
	myLib.version = myVersion;

	-- Event handler functions
	function myLib.OnEvent(event, ...)
		if (event == "LOOT_OPENED") then
			LibSwag.Loot()
		elseif ((event == "UNIT_SPELLCAST_SUCCEEDED") or
				(event == "UNIT_SPELLCAST_FAILED") or
				(event == "UNIT_SPELLCAST_INTERRUPTED") or
				(event == "UNIT_SPELLCAST_SENT")) then
			LibSwag.Spell(event, ...)
		elseif (event == "UPDATE_MOUSEOVER_UNIT") or (event == "CURSOR_UPDATE") then
			LibSwag.SetTooltip()
		end
	end

	-- Spell names and types
	do
		local GetSpellInfo = function( ... ) return GetSpellInfo(...) or "" end -- prevent nil key errors (just being paranoid)
		myLib.lootSpells = {
			[GetSpellInfo(2366)] =   "HERB", -- Herb Gathering(Apprentice)
			[GetSpellInfo(2575)] =   "MINE", -- Mining(Apprentice)
			[GetSpellInfo(7620)] =   "FISH", -- Fishing(Apprentice)
			[GetSpellInfo(8613)] =   "SKIN", -- Skinning(Apprentice)
			[GetSpellInfo(1804)] =   "OPEN", -- Pick Lock()
			[GetSpellInfo(3365)] =   "OPEN", -- Opening()
			[GetSpellInfo(3366)] =   "OPEN", -- Opening()
			[GetSpellInfo(6247)] =   "OPEN", -- Opening()
			[GetSpellInfo(6249)] =   "OPEN", -- Opening()
			[GetSpellInfo(6477)] =   "OPEN", -- Opening()
			[GetSpellInfo(6478)] =   "OPEN", -- Opening()
			[GetSpellInfo(6509)] =   "OPEN", -- Opening()
			[GetSpellInfo(6658)] =   "OPEN", -- Opening()
			[GetSpellInfo(6802)] =   "OPEN", -- Opening()
			[GetSpellInfo(8917)] =   "OPEN", -- Opening()
			[GetSpellInfo(21248)] =  "OPEN", -- Opening()
			[GetSpellInfo(21288)] =  "OPEN", -- Opening()
			[GetSpellInfo(21651)] =  "OPEN", -- Opening()
			[GetSpellInfo(24390)] =  "OPEN", -- Opening()
			[GetSpellInfo(24391)] =  "OPEN", -- Opening()
			[GetSpellInfo(26868)] =  "OPEN", -- Opening()
			[GetSpellInfo(39220)] =  "OPEN", -- Opening()
			[GetSpellInfo(39264)] =  "OPEN", -- Opening()
			[GetSpellInfo(45137)] =  "OPEN", -- Opening()
			[GetSpellInfo(22810)] =  "OPEN", -- Opening - No Text()
		}
		myLib.lootSpells[""] = nil -- clear out any useless entries
	end

	-- Basic items (note, the list grows when we find new items)
	myLib.items = {
		["MINE"] = {
			["Copper Ore"] = 2770,
			["Tin Ore"] = 2771,
			["Iron Ore"] = 2772,
			["Silver Ore"] = 2775,
			["Gold Ore"] = 2776,
			["Mithril Ore"] = 3858,
			["Truesilver Ore"] = 7911,
			["Thorium Ore"] = 10620,
			["Dark Iron Ore"] = 11370,
		},
		["HERB"] = {
			["Silverleaf"] = 765,
			["Mageroyal"] = 785,
			["Peacebloom"] = 2447,
			["Earthroot"] = 2449,
			["Briarthorn"] = 2450,
			["Swiftthistle"] = 2452,
			["Bruiseweed"] = 2453,
			["Wild Steelbloom"] = 3355,
			["Kingsblood"] = 3356,
			["Liferoot"] = 3357,
			["Khadgar's Whisker"] = 3358,
			["Grave Moss"] = 3369,
			["Fadeleaf"] = 3818,
			["Wintersbite"] = 3819,
			["Stranglekelp"] = 3820,
			["Goldthorn"] = 3821,
			["Firebloom"] = 4625,
			["Wildvine"] = 8153,
			["Purple Lotus"] = 8831,
			["Arthas' Tears"] = 8836,
			["Sungrass"] = 8838,
			["Blindweed"] = 8839,
			["Ghost Mushroom"] = 8845,
			["Gromsblood"] = 8846,
			["Dreamfoil"] = 13463,
			["Golden Sansam"] = 13464,
			["Mountain Silversage"] = 13465,
			["Plaguebloom"] = 13466,
			["Icecap"] = 13467,
			["Black Lotus"] = 13468,
		},
	}

	-- Tracks spell events to determine loot sequences
	local isCasting = false
	function myLib.Spell(event, caster, spell, rank, target)
		if (not LibSwag.tracker) then LibSwag.tracker = {} end

		if (event == "UNIT_SPELLCAST_SENT") then
			if ( myLib.lootSpells[spell] ) then
				LibSwag.SetTooltip()
				LibSwag.tracker.spell = spell or "Opening"
				LibSwag.tracker.start = GetTime()
				LibSwag.tracker.tooltip = target and {tip=target, time=GetTime()} or LibSwag.GetLastTip()
				isCasting = true
			end
		elseif (event == "UNIT_SPELLCAST_SUCCEEDED") then
			if (LibSwag.tracker.spell == spell) then
				LibSwag.tracker.ended = GetTime()
			end
			isCasting = false
		elseif ((event == "UNIT_SPELLCAST_INTERRUPTED") or (event == "UNIT_SPELLCAST_FAILED")) then
			if ( isCasting ) then
				local ltype = LibSwag.lootSpells[LibSwag.tracker.spell]
				if (not ltype and LibSwagData.spells) then
					ltype = LibSwagData.spells[LibSwag.tracker.spell]
				end
				if (ltype) then
					for i, callback in pairs(LibSwag.callbacks) do
						if (callback.castHook) then
							callback.castHook(ltype, nil, nil, LibSwag.tracker.tooltip)
						end
					end
				end
			end
			isCasting = false
			-- Spell failed, cancel the tracking
			LibSwag.tracker.spell = nil
			LibSwag.tracker.tooltip = nil
		end
	end

	-- Records the loot that just happened and calls the hooked callbacks
	function myLib.RecordLoot(ltype, method)
		local loot = {}
		local coin = 0
		local count = GetNumLootItems()
		for i = 1, count do
			local lIcon, lName, lQuantity, lQuality = GetLootSlotInfo(i)
			local lLink = GetLootSlotLink(i)
			if (not lLink and LootSlotIsCoin(i)) then
				local i,j,val
				i,j, val = string.find(lName, COPPER_AMOUNT:gsub("%%d", "(%%d+)", 1))
				if (i) then coin = coin + val end
				i,j, val = string.find(lName, SILVER_AMOUNT:gsub("%%d", "(%%d+)", 1))
				if (i) then coin = coin + (val*100) end
				i,j, val = string.find(lName, GOLD_AMOUNT:gsub("%%d", "(%%d+)", 1))
				if (i) then coin = coin + (val*10000) end
			else
				table.insert(loot, { link = lLink, name = lName, count = lQuantity })
			end
		end

		for i, callback in pairs(LibSwag.callbacks) do
			if (callback.lootHook) then
				callback.lootHook(ltype, loot, coin, method)
			end
		end
	end

	-- Allows dependant addons to hook into the loot sequence
	function myLib.RegisterHook(name, lootHook, castHook)
		table.insert(LibSwag.callbacks, { name = name, lootHook = lootHook, castHook = castHook })
	end

	-- Processes the lootbox for data
	function myLib.Loot()
		local spell
		if (LibSwag.tracker and LibSwag.tracker.spell and
			LibSwag.tracker.ended and GetTime() - LibSwag.tracker.ended < 1) then
			local lastSpell = LibSwag.tracker.spell
			spell = LibSwag.lootSpells[lastSpell]
			if (not spell and LibSwagData.spells) then
				spell = LibSwagData.spells[lastSpell]
			end

			if (not spell) then
				local primary = GetLootSlotLink(1)
				if (primary) then
					primary = primary:match("item:(%d+)")
					if (primary) then
						if (not LibSwagData.ai) then LibSwagData.ai = {} end
						if (not LibSwagData.ai[lastSpell]) then LibSwagData.ai[lastSpell] = {} end
						for stype, count in pairs(LibSwagData.ai[lastSpell]) do
							if count > 1 then
								LibSwagData.ai[lastSpell][stype] = count - 1
							else
								LibSwagData.ai[lastSpell][stype] = nil
							end
						end
						if (not LibSwagData.items) then LibSwagData.items = {} end
						if (not LibSwagData.spells) then LibSwagData.spells = {} end
						if (LibSwagData.items[primary]) then
							local primeType = LibSwagData.items[primary]
							local count = LibSwagData.ai[lastSpell][primeType] or -1
							count = count + 2
							LibSwagData.ai[lastSpell][primeType] = count
							if (count >= 3) then
								LibSwagData.spells[lastSpell] = primeType
							end
						end
					end
				end
			end
		end
		if (IsFishingLoot()) then
			return myLib.RecordLoot("FISH")
		elseif (spell) then
			return myLib.RecordLoot(spell, LibSwag.tracker.tooltip)
		elseif (CheckInteractDistance("target", 3) and UnitIsDead("target")) then
			-- Most likely to be loot from kill
			return myLib.RecordLoot("KILL", { unit = UnitName("target"), level = UnitLevel("target") })
		end

	end

	-- Registers the library to recieve an event (if it does not already do so)
	function myLib.RegEvent(ev)
		if not LibSwagFrame["REG_"..ev] then
			LibSwagFrame:RegisterEvent(ev)
			LibSwagFrame["REG_"..ev] = true
		end
	end

	-- Adds a predefined item to your saved data
	function myLib.AddItem(cat, enName, id)
		local name = GetItemInfo(id)
		if (not LibSwagData.items) then LibSwagData.items = {} end
		if (not LibSwagData.cats) then LibSwagData.cats = {} end
		if (not LibSwagData.cats[cat]) then LibSwagData.cats[cat] = {} end
		if (not LibSwagData.spells) then LibSwagData.spells = {} end
		if (not LibSwagData.ai) then LibSwagData.ai = {} end
		if (not name) then name = enName end
		LibSwagData.items[id] = { cat = cat, name = name }
		LibSwagData.cats[cat][name] = id
	end

	-- Call this function in the OnLoad function of your addon
	function myLib.Init()
		for cat, data in pairs(LibSwag.items) do
			if (not LibSwagData[cat]) then LibSwagData[cat] = {} end
			for name, itemid in pairs(data) do
				LibSwag.AddItem(cat, name, itemid)
			end
		end
	end

	-- Function to store the last set tooltip text
	function myLib.SetTooltip(line, newtext, r,g,b,a)
		if (not line) then
			local gtext
			local lines = GameTooltip:NumLines()
			for i=1, lines do
				gtext = (getglobal("GameTooltipTextLeft"..i):GetText() or "")
				local rTip = getglobal("GameTooltipTextRight"..i)
				if (rTip:IsVisible()) then
					gtext = gtext.." / "..(rTip:GetText() or "")
				end
				--log("SetTooltip", N_INFO, "Set Tooltip Line", "Setting tooltip line", i, "=", gtext)
				LibSwag.SetTooltip(i, gtext)
			end
			return
		end
		if (line > 1) then return end
		local now = GetTime()

	    -- Get the original text from the tooltip
		local text = GameTooltipTextLeft1:GetText()
		if (not text) then text = newtext end

		-- Check to see if we have just recorded this tip
		if (LibSwag.lastTipTime and text ~= LibSwag.lastTipText) then
			local delta = now - LibSwag.lastTipTime
			if (delta < 0.8) then
				--log("SetTooltip", N_INFO, "Discard Tooltip", "Discarding tooltip because we have one that's only ", delta, "seconds old")
				return
			end
		end

		-- We're not interested in unit tooltips or any interface tips
		local mouseover = UnitName("mouseover")
		if ((not mouseover or mouseover:find(UNKNOWN)) and GetMouseFocus() == WorldFrame) then
			LibSwag.lastTipText = text
			LibSwag.lastTipTime = GetTime()
			--log("SetTooltip", N_INFO, "Tooltup Text + Time", "Found usable tooltip text =", text, " and time =", LibSwag.lastTipTime)
		else
			--log("SetTooltip", N_INFO, "Not interested", "Current mouseover is not a doodad. UnitName =", UnitName("mouseover"), " and focus =", (GetMouseFocus() and GetMouseFocus():GetName() or "nil"))
		end
	end
	-- Getter for the above function
	function myLib.GetLastTip()
		-- Loot boxes should pop up pretty quickly.. if the tooltip was last
		-- set more than 10 seconds ago, then discard it.
		local delta = 0
		if (LibSwag.lastTipTime) then delta = GetTime() - LibSwag.lastTipTime end
		if (not LibSwag.lastTipTime or delta > 10) then
			--log("GetLastTip", N_INFO, "Remove Last Tooltip", "Removing ancient tooltip data: text = ", LibSwag.lastTipText, "age =", delta)
			LibSwag.lastTipTime = nil
			LibSwag.lastTipText = nil
			return nil
		end
		--log("GetLastTip", N_INFO, "Get Last Tooltip", "Return last text =", LibSwag.lastTipText, "and time =", LibSwag.lastTipTime)
		return {
			tip = LibSwag.lastTipText,
			time = LibSwag.lastTipTime
		}
	end

    -- Replace the existing function definitions with this versions' functions somehow
	if (create) then
		LibSwag = myLib
	elseif (update) then
		for item, _ in myLib do
			LibSwag[item] = myLib[item]
			myLib[item] = nil
		end
	end

	-- Create a version independant frame if it doesn't exist
	if (not LibSwagFrame) then
		-- Setup a event handler stub (which won't change between versions)
		LibSwagFrame = CreateFrame("Frame", "LibSwagFrame")
		function LibSwagFrame.OnEvent(frame, event, ...) LibSwag.OnEvent(event, ...) end

		-- Hook into the SetText of GameTooltip to catch the original setting of the tooltip
		LibSwagFrame.ttLine = 0
		-- Hook GameTooltipTextLeft1:SetText()
		function LibSwagFrame.GameTooltipSetTextLeft1(this, ...)
			LibSwag.SetTooltip(1, ...)
			LibSwagFrame.OldGameTooltipSetTextLeft1(this, ...)
		end
		LibSwagFrame.OldGameTooltipSetTextLeft1 = GameTooltipTextLeft1.SetText
		GameTooltipTextLeft1.SetText = LibSwagFrame.GameTooltipSetTextLeft1
		-- Hook GameTooltip:SetText() and keep track of the current line
		function LibSwagFrame.GameTooltipSetText(this, ...)
			local line = LibSwagFrame.ttLine + 1
			LibSwagFrame.ttLine = line
			LibSwag.SetTooltip(line, ...)
			LibSwagFrame.OldGameTooltipSetText(this, ...)
		end
		LibSwagFrame.OldGameTooltipSetText = GameTooltip.SetText
		GameTooltip.SetText = LibSwagFrame.GameTooltipSetText
		-- Hook GameTooltip:ClearLines to reset the line number
		function LibSwagFrame.GameTooltipClearLines(this)
			LibSwagFrame.ttLine = 0
			LibSwagFrame.OldGameTooltipClearLines(this)
		end
		LibSwagFrame.OldGameTooltipClearLines = GameTooltip.ClearLines
		GameTooltip.ClearLines = LibSwagFrame.GameTooltipClearLines

		-- Display the frame and set the event callback function
		LibSwagFrame:Show()
		LibSwagFrame:SetScript("OnEvent",  LibSwagFrame.OnEvent)
	end

	-- Initialize the callback table if it doesn't exist
	if (not LibSwag.callbacks) then
		LibSwag.callbacks = {}
	end

	-- Get the library to register for the relevant events
	LibSwag.RegEvent("LOOT_OPENED")
	LibSwag.RegEvent("UNIT_SPELLCAST_SENT")
	LibSwag.RegEvent("UNIT_SPELLCAST_SUCCEEDED")
	LibSwag.RegEvent("UNIT_SPELLCAST_INTERRUPTED")
	LibSwag.RegEvent("UNIT_SPELLCAST_FAILED")
	LibSwag.RegEvent("UPDATE_MOUSEOVER_UNIT")
	LibSwag.RegEvent("CURSOR_UPDATE")
end


if (nLog) then
	log = function(ltype, level, title, ...) nLog.AddMessage("Swag", ltype, level, title, ...) end
else log = function() end end

