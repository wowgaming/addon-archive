--[[
Name: SkilletStitch-1.1
Revision: $Rev: 142 $
Author(s): Nymbia (nymbia@gmail.com)
Website: http://www.wowace.com/wiki/Stitch-1.1
Documentation: http://www.wowace.com/wiki/Stitch-1.1
SVN: http://svn.wowace.com/wowace/trunk/Stitch-1.1/Stitch-1.1/
Description: Library for tradeskill information access and queueing.
Dependencies: AceLibrary, AceEvent-2.0
License: LGPL v2.1
Copyright (C) 2006-2007 Nymbia

  This version has been modified by nogudik@gmail.com for use in
  the Skillet mod and is no longer the identical to the version
  originally written by Nymbia.

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
]]
local MAJOR_VERSION = "SkilletStitch-1.1"
local MINOR_VERSION = "$Rev: 142 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end
if not AceLibrary:HasInstance("AceEvent-2.0") then error(MAJOR_VERSION .. " requires AceEvent-2.0") end
local AceEvent = AceLibrary("AceEvent-2.0")
local PT
if AceLibrary:HasInstance("LibPeriodicTable-3.1") then
	PT = AceLibrary("LibPeriodicTable-3.1")
end
local ENCHANTING_STRING
do
    local locale = GetLocale()
    if locale == "enUS" then
        ENCHANTING_STRING = "Enchanting"
    elseif locale == "frFR" then
        ENCHANTING_STRING = "Enchantement"
    elseif locale == "deDE" then
        ENCHANTING_STRING = "Verzauberkunst"
    elseif locale == "koKR" then
        ENCHANTING_STRING = "마법부여"
    elseif locale == "zhCN" then
        ENCHANTING_STRING = "附魔"
    elseif locale == "zhTW" then
        ENCHANTING_STRING = "附魔"
    elseif locale == "esES" then
        ENCHANTING_STRING = "Encantamiento"
    elseif locale == "ruRU" then
        ENCHANTING_STRING = "Наложение чар"
    end
end
local SkilletStitch = {}
SkilletStitch.hooks = {}
-- Use to get item counts from alts. Requires compatible inventory mod/library.
local alt_lookup_function = nil
local difficultyt = {
	o = "optimal",
	m = "medium",
	e = "easy",
	t = "trivial",
}
local difficultyr = {
	optimal = "o",
	medium = "m",
	easy = "e",
	trivial = "t",
}
local function squishlink(link)
	-- in:  |cffffffff|Hitem:13928:0:0:0:0:0:0:0|h[Grilled Squid]|h|r
	-- out: ffffff|13928|Grilled Squid
	local color, id, name = link:match("^|cff(......)|Hitem:(%d+):[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+|h%[([^%]]+)%]|h|r$")
	if id then
		return color.."|"..id.."|"..name
	else
		-- in:  |cffffffff|Henchant:7421|h[Runed Copper Rod]|h|r
		-- out: |-7421|Runed Copper Rod
		id, name = link:match("^|cffffd000|Henchant:(%d+)|h%[([^%]]+)%]|h|r$")
		return "|-"..id.."|"..name
	end
end
local function unsquishlink(link)
	-- in:  ffffff|13928|Grilled Squid
	-- out: |cffffffff|Hitem:13928:0:0:0:0:0:0:0|h[Grilled Squid]|h|r  ,false
	local color, id, name = link:match("^([^|].....)|(%d+)|(.+)$")
	if id then
		return "|cff"..color.."|Hitem:"..id..":0:0:0:0:0:0:0:0|h["..name.."]|h|r", false
	else
		-- in:  |-7421|Runed Copper Rod
		-- out: |cffffffff|Henchant:7421|h[Runed Copper Rod]|h|r ,true
		id, name = link:match("^|%-(%d+)|(.+)$")
		if id then
			return "|cffffd000|Henchant:"..id.."|h["..name.."]|h|r",true
		else
			return link
		end
	end
end

local reserved_reagents = nil

-- Returns the count of reagents of type 'link' that have
-- already been reserved
local function get_reserved_reagent_count(link)
    local count = 0

    if reserved_reagents then
        for i=#reserved_reagents, 1, -1 do
            if reserved_reagents[i].link == link then
                count = reserved_reagents[i].count
                break
            end
        end
    end

    return count
end

local itemmeta = {
	__index = function(self,key)
		if key == "numcraftable" then
			local num = 1000
			for _,v in ipairs(self) do
				if v.vendor == false then
					local max = math.floor(v.num/v.needed)*self.nummade
					if max < num then
						num = max
					end
				end
			end
			if num == 1000 then
				for _,v in ipairs(self) do
					local max = math.floor(v.num/v.needed)*self.nummade
					if max < num then
						num = max
					end
				end
			end
			return num
		elseif key == "numcraftablewbank" then
			local num = 1000
			for _,v in ipairs(self) do
				if v.vendor == false then
					local max = math.floor(v.numwbank/v.needed)*self.nummade
					if max < num then
						num = max
					end
				end
			end
			if num == 1000 then
				for _,v in ipairs(self) do
					local max = math.floor(v.numwbank/v.needed)*self.nummade
					if max < num then
						num = max
					end
				end
			end
			return num
		elseif key == "numcraftablewalts" and alt_lookup_function then
			local num = 1000
			for _,v in ipairs(self) do
				if v.vendor == false then
					local max = math.floor(v.numwalts/v.needed)*self.nummade
					if max < num then
						num = max
					end
				end
			end
			if num == 1000 then
				for _,v in ipairs(self) do
					local max = math.floor(v.numwalts/v.needed)*self.nummade
					if max < num then
						num = max
					end
				end
			end
			return num
		end
	end
}
local reagentmeta = {
	__index = function(self,key)
        local count = 0
        local reserved = get_reserved_reagent_count(self.link)

		if key == "num" then
			count = GetItemCount(self.link)
		elseif key == "numwbank" then
			count = GetItemCount(self.link,true)
		elseif key == "numwalts" and alt_lookup_function ~= nil then
			count = alt_lookup_function(self.link) or 0
		end

        return math.max(0, count - reserved)
	end
}
local cache = setmetatable({},{
	__index = function(self,prof)
		if prof == "UNKNOWN" then
			return
		end
		self[prof] = setmetatable({},{
			__mode = 'v',
			__index = function(self,key)
                local l = AceLibrary("SkilletStitch-1.1")
                if not l.data then
                    l.data = {}
                end
                if not l.data[prof] then
                    l.data[prof] = {}
                end
				local datastring = l.data[prof][key]
				if not datastring then
					return
				end

                self[key] = l:DecodeRecipe(datastring)
                -- this is used to work down the list of reagents when recursively crafting items
                self[key].index = key

				return self[key]
			end
		})
		return self[prof]
	end
})

-- API
function SkilletStitch:DecodeRecipe(datastring)
    if not datastring then
        return
    end

    local itemchunk, reagentchunk = datastring:match("^([^;]-;[^;]-;[^;]-;[^;]-;)(.-)$")
    local nameoverride, link, difficultychar, numcrafted, tools = itemchunk:match("^([^;]-);([^;]+);(%a)(%d+);([^;]-);$")
    local isenchant

    link,isenchant = unsquishlink(link)
    if nameoverride:len() == 0 then
        nameoverride = link:match("%|h%[([^%]]+)%]%|h")
    end
    if tools:len() == 0 then
        tools = nil
    end
    local texture
    if isenchant then
        texture = "Interface\\Icons\\Spell_Holy_GreaterHeal"
    else
        texture = select(10,GetItemInfo(link))
    end

    local s = setmetatable({
        name = nameoverride,
        difficulty = difficultyt[difficultychar],
        nummade = tonumber(numcrafted),
        link = link,
        tools = tools,
        texture = texture,
        profession = prof,
        index = key,
    },itemmeta)
    for reagentnum, reagentlink in reagentchunk:gmatch("([^;]+);([^;]+);") do
        reagentlink = unsquishlink(reagentlink)
        local texture = select(10, GetItemInfo(reagentlink))
        local vendor = false
        if PT then
            vendor = PT:ItemInSet(reagentlink,"Tradeskill.Mat.BySource.Vendor")
            if not vendor then vendor = false end

            -- Workaround for missing items in the Periodic table library that
            local _,_,id = string.find(reagentlink, "|Hitem:(%d+):")
            id = tonumber(id)
            if id == 30817 or id == 4539 then
                -- 30817 == simple flour
                -- 4539 == Goldenbark Apple
                vendor = true
            end
        end

        table.insert(s,setmetatable({
            name = reagentlink:match("%|h%[([^%]]+)%]%|h"),
            link = reagentlink,
            needed = tonumber(reagentnum),
            texture = texture,
            vendor = vendor,
        },reagentmeta))
    end

    return s
end

function SkilletStitch:IsSupportedCraft(craft)
    return craft == ENCHANTING_STRING
end

function SkilletStitch:GetNumSkills(prof)
    if not self.data then
        return nil
    elseif not self.data[prof] then
        return nil
    else
        return #self.data[prof]
    end
end

--
-- Tells the Stitch library that the provided list of reagents
-- have already be reserved/spoken for and cannot be included
-- when computing the craftable item counts.
function SkilletStitch:SetReservedReagentsList(reagents)
    reserved_reagents = reagents
end

function SkilletStitch:EnableDataGathering(addon)
	assert(tostring(addon),"Usage: EnableDataGathering('addon')")
	self.datagatheraddons[addon] = true
	self:RegisterEvent("TRADE_SKILL_SHOW")
	self:RegisterEvent("CRAFT_SHOW")
	self:RegisterEvent("CHAT_MSG_SKILL")
	if not self.data then
		self.data = {}
	end
end

function SkilletStitch:DisableDataGathering(addon)
	if not addon then
		self.data = nil
		self.datagatheraddons = {}
		return
	end
	assert(tostring(addon),"Usage: DisableDataGathering(['addon'])")
	self.datagatheraddons[addon] = false
	if next(self.datagatheraddons) then
		return
	end
	self:UnregisterEvent("TRADE_SKILL_SHOW")
	self:UnregisterEvent("CRAFT_SHOW")
	self:UnregisterEvent("CHAT_MSG_SKILL")
	self.data = nil
end
function SkilletStitch:EnableQueue(addon)
	assert(tostring(addon),"Usage: EnableDataGathering('addon')")
	self.queueaddons[addon] = true
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED",   "StopCastCheckUnit")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED",      "StopCastCheckUnit")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "StopCastCheckUnit")
	if not self.queue then
		self.queue = {}
	end
	self.queueenabled = true
end
function SkilletStitch:DisableQueue(addon)
	if not addon then
		self.queue = nil
		self.queueaddons = {}
		self.queueenabled = false
		return
	end
	assert(tostring(addon),"Usage: DisableDataGathering(['addon'])")
	self.queueaddons[addon] = false
	if next(self.queueaddons) then
		return
	end
	self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:UnregisterEvent("UNIT_SPELLCAST_FAILED")
	self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
	self.queueenabled = false
	self.queue = nil
end

function SkilletStitch:GetItemDataByIndex(profession, index)
	assert(tonumber(index) and profession,"Usage: GetItemDataByIndex('profession', index)")
	return cache[profession][index]
end

function SkilletStitch:GetItemDataByName(name,prof)
	assert(tostring(name) ,"Usage: GetItemDataByName('name')")
	for k,v in pairs(cache) do
		if not prof or k==prof then
			for l,w in pairs(v) do
				if w.name == name then
					return cache[k][l]
				end
			end
		end
	end
	name = string.gsub(name, "([%.%(%)%%%+%-%*%?%[%]%^%$])", "%%%1")
	for k,v in pairs(self.data) do
		if not prof or k==prof then
			for l,w in pairs(v) do
				-- protection against old manufac savedvars, remove eventually
				if type(w) ~= "string" then
					ManufacPerCharDB = nil
					error('Invalid DB, try reloading your ui.')
				end
				local chunk = w:match("^([^;]-;[^;]-;)")
				if chunk:match("^"..name) or chunk:match("|"..name..";") then
					return cache[k][l]
				end
			end
		end
	end
end

local result = {}
function SkilletStitch:GetItemDataByPartialName(name)
	for k,_ in pairs(result) do
		result[k] = nil
	end
	assert(tostring(name),"Usage: GetItemDataByPartialName('name')")
	name = name:gsub("([%.%(%)%%%+%-%*%?%[%]%^%$])", "%%%1")
	for k,v in pairs(self.data) do
		for l,w in pairs(v) do
			local chunk = w:match("([^;]-;[^;]-;)")
			if chunk:match("^"..name) or chunk:match("%|h%["..name.."%]%|h") then
				table.insert(result,cache[k][l])
			end
		end
	end
	if #result == 0 then
		return
	else
		return result
	end
end

function SkilletStitch:GetQueueInfo()
	return self.queue
end

function SkilletStitch:GetQueueItemInfo(index)
    return cache[self.queue[index]["profession"]][self.queue[index]["index"]]
end

function SkilletStitch:RemoveFromQueue(index)
	table.remove(self.queue, index)
	if #self.queue == 0 then
		self:ClearQueue()
	end
end
function SkilletStitch:ClearQueue()
	self.queue = {}
	AceEvent:TriggerEvent("SkilletStitch_Queue_Complete")
end
function SkilletStitch:ProcessQueue()
	local tradeskill = GetTradeSkillLine()
	if self.queue[1] and type(self.queue[1]) == "table" and tradeskill == self.queue[1]["profession"] then
		self.queuecasting = true
        return DoTradeSkill(self.queue[1]["index"], self.queue[1]["numcasts"])
	else
		self.queue = {}
		AceEvent:TriggerEvent("SkilletStitch_Queue_Complete")
	end
end
-- Internal
function SkilletStitch:SkilletStitch_AutoRescan()
	if InCombatLockdown() then
		return
	end

    if AceEvent:IsEventScheduled("SkilletStitch_AutoRescan") then
        AceEvent:CancelScheduledEvent("SkilletStitch_AutoRescan")
    end

    if self.recentcraft == ENCHANTING_STRING then
      self:ScanCraft()
    else
      self:ScanTrade()
    end
end
function SkilletStitch:TRADE_SKILL_SHOW()
	self.recenttrade = GetTradeSkillLine()
	if self.queue[1] and type(self.queue[1]) == "table" and self.recenttrade ~= self.queue[1]["profession"] then
		self:ClearQueue()
	end
	self:ScanTrade()
	if self.data.UNKNOWN then
		self.data.UNKNOWN = nil
	end
end
function SkilletStitch:CRAFT_SHOW()
	self.recentcraft = GetCraftName()
	self:ScanCraft()
	if self.data.UNKNOWN then
		self.data.UNKNOWN = nil
	end
end
function SkilletStitch:CHAT_MSG_SKILL()
	self:SkilletStitch_AutoRescan()
end
function SkilletStitch:StopCastCheckUnit(unit)
	if unit == "player" then
		self:StopCast()
	end
end
function SkilletStitch:StopCast()
	if self.queuecasting then
		if event ~= "UNIT_SPELLCAST_SUCCEEDED" then
			AceEvent:TriggerEvent("SkilletStitch_Queue_Continue", #self.queue)
			self.queuecasting = false
			return
		end

		if not self.queue[1] then
			self.queue = {}
			AceEvent:TriggerEvent("SkilletStitch_Queue_Complete")
			return
		end

		self.queue[1].numcasts = self.queue[1].numcasts - 1

		if self.queue[1].numcasts < 1 then
			self:RemoveFromQueue(1)
			if table.getn(self.queue) > 0 then
				AceEvent:TriggerEvent("SkilletStitch_Queue_Continue", #self.queue)
			else
				AceEvent:TriggerEvent("SkilletStitch_Queue_Complete")
			end
			self.queuecasting = false
		else
			AceEvent:TriggerEvent("SkilletStitch_Queue_Continue", #self.queue)
		end
	end
end

-- Stop a trade skill currently in prograess. We cannot cancel the current
-- item as that requires a "SpellStopCasting" call which can only be
-- made from secure code. All this does is stop repeating after the current item
function SkilletStitch:CancelCast()
    StopTradeSkillRepeat()
end
--------------------
-- Internal Stuff --
--------------------
function SkilletStitch:GetIDFromLink(link)
	local id = string.match(link, "item:(%d+)")
	return tonumber(id)
end

function SkilletStitch:AddToQueue(index, times)
	if self.queue[1] and self.queue[1]["profession"] ~= self.recenttrade then
		self:ClearQueue()
	end
	if not times then
		times = 1
	end

    local found = false

    -- check to see if the item is already in the queue. If it is,
    -- then just increase the count
    for _,s in pairs(self.queue) do
        if s.profession == self.recenttrade and s.index == index then
            found = true
            s.numcasts = s.numcasts + times
            break
        end
    end

    if not found then
        table.insert(self.queue, {
            ["profession"] = self.recenttrade,
            ["index"] = index,
            ["numcasts"] = times,
            ["recipe"] = self.data[self.recenttrade][index]
        })
    end

	AceEvent:TriggerEvent("SkilletStitch_Queue_Add")
end

-- Returns the number of items (of the current index in the current tradeskill)
-- are queued
function SkilletStitch:GetNumQueuedItems(index)
    local count = 0

    for k,v in pairs(self.queue) do
        if v["index"] == index then
            count = count + tonumber(v["numcasts"])
        end
    end

    return count
end

function SkilletStitch:ScanCraft()
	local prof = GetCraftName()
	if prof~=ENCHANTING_STRING then
		return
	end
	if not self.data[prof] then
		self.data[prof] = {}
	end
	cache[prof] = nil
	local shred = false
	for i=1,GetNumCrafts() do
		local skillname, _, skilltype = GetCraftInfo(i)
		if skilltype~="header" and skillname then
			local newstr
			local link = GetCraftItemLink(i)
			if not link then
				shred = true
			else
				local v1, _, v2, _, v3, _, v4 = GetCraftSpellFocus(i)
				if v4 then
					v1 = v1..", "..v2..", "..v3..", "..v4
				elseif v3 then
					v1 = v1..", "..v2..", "..v3
				elseif v2 then
					v1 = v1..", "..v2
				elseif v1 then
					v1 = v1
				end
				local linkname = link:match("%|h%[([^%]]+)%]%|h")
				link = squishlink(link)

                local minMade,maxMade = GetCraftNumMade(i)

				if linkname == skillname then
					newstr = ";"..link..";"..difficultyr[skilltype]..maxMade..";"..(v1 or "")..";"
				else
					newstr = skillname..";"..link..";"..difficultyr[skilltype]..maxMade..";"..(v1 or "")..";"
				end
				for j=1,GetCraftNumReagents(i) do
					local _, _, rcount, _ = GetCraftReagentInfo(i,j)
					local link = GetCraftReagentItemLink(i,j)
					if not link then
						shred = true
					else
						link = squishlink(link)
						newstr = newstr..rcount..";"..link..";"
					end
				end
			end
			self.data[prof][i] = newstr
		else
			self.data[prof][i] = nil
		end
	end
	if shred then
		for k,v in pairs(self.data[prof]) do
			self.data[prof][k] = nil
		end
		if not AceEvent:IsEventScheduled("SkilletStitch_AutoRescan") then
			AceEvent:ScheduleEvent("SkilletStitch_AutoRescan", self.SkilletStitch_AutoRescan, 3,self)
		end
    else
        AceEvent:TriggerEvent("SkilletStitch_Scan_Complete", prof)
	end

end
function SkilletStitch:ScanTrade()
	local prof = GetTradeSkillLine()
	if prof == "UNKNOWN" then
		self.data[prof] = nil
	end
	if not self.data[prof] then
		self.data[prof] = {}
	end

	cache[prof] = nil
	local shred = false
	for i=1,GetNumTradeSkills() do
		local skillname, skilltype = GetTradeSkillInfo(i)
		if skilltype~="header" and skillname then
			local newstr
			local link = GetTradeSkillItemLink(i)
			if not link then
				shred = true
			else
				local v1, _, v2, _, v3, _, v4 = GetTradeSkillTools(i)
				if v4 then
					v1 = v1..", "..v2..", "..v3..", "..v4
				elseif v3 then
					v1 = v1..", "..v2..", "..v3
				elseif v2 then
					v1 = v1..", "..v2
				elseif v1 then
					v1 = v1
				end
				local linkname = link:match("%|h%[([^%]]+)%]%|h")
				link = squishlink(link)

                local minmade, maxmade = GetTradeSkillNumMade(i)

				if linkname == skillname then
					newstr = ";"..link..";"..difficultyr[skilltype].. maxmade ..";"..(v1 or "")..";"
				else
					newstr = skillname..";"..link..";"..difficultyr[skilltype].. maxmade .. ";"..(v1 or "")..";"
				end
				for j=1,GetTradeSkillNumReagents(i) do
					local _, _, rcount, _ = GetTradeSkillReagentInfo(i,j)
					local link = GetTradeSkillReagentItemLink(i,j)
					if not link then
						shred = true
					else
						link = squishlink(link)
						newstr = newstr..rcount..";"..link..";"
					end
				end
			end
			self.data[prof][i] = newstr
		else
			self.data[prof][i] = nil
		end
	end
	if shred then
		for k,v in pairs(self.data[prof]) do
			self.data[prof][k] = nil
		end
		if not AceEvent:IsEventScheduled("SkilletStitch_AutoRescan") then
            AceEvent:ScheduleEvent("SkilletStitch_AutoRescan", self.SkilletStitch_AutoRescan, 3,self)
        end
    else
        AceEvent:TriggerEvent("SkilletStitch_Scan_Complete", prof)
    end

end

-- @function         SetAltCharacterItemLookupFunction
-- @brief            Sets the fucntion to be used when looking up reagent counts
--                   from alternate characters. If not set, then no cross-character
--                   item counts are done and the corresponding fields are set to
--                   nil (not zero) to indicate that the data is not available.
-- @param func       The function to be used. The function should take an
--                   item link and return a count across all characters including
--                   the current one.
function SkilletStitch:SetAltCharacterItemLookupFunction(func)
	if func then
		alt_lookup_function = func
	end
end

----------------------
-- AceLibrary Stuff --
----------------------
local function activate(self, oldLib, oldDeactivate)
	if oldLib then
		self.data = oldLib.data
		self.datagatheraddons = oldLib.datagatheraddons
		self.queueaddons = oldLib.queueaddons
		self.queue = oldLib.queue
		self.queuecasting = oldLib.queuecasting
		self.hooks = oldLib.hooks
		self.queueenabled = oldLib.queueenabled
	end
	if not self.data then
		self.data = {}
	end
	if not self.queueenabled then
		self.queueenabled = false
	end
	if not self.queueaddons then
		self.queueaddons = {}
	end
	if not self.datagatheraddons then
		self.datagatheraddons = {}
	end
	if not self.queue then
		self.queue = {}
	end
	if not self.queuecasting then
		self.queuecasting = false
	end
	if oldDeactivate then
		oldDeactivate(oldLib)
	end
end
local function external(self, major, instance)
	if major == "AceEvent-2.0" then
		AceEvent = instance
		AceEvent:embed(self)
		self:UnregisterAllEvents()
		self:CancelAllScheduledEvents()
	end
end
AceLibrary:Register(SkilletStitch, MAJOR_VERSION, MINOR_VERSION, activate, nil, external)
SkilletStitch = nil
--[[
self.data = {
	professionname = {

		--if name is the same as link

		[1] = ";link;diffnumcrafted;tools;reagent1num;reagent1link;reagent2num;reagent2link;",

		--if name is different from link

		[2] = "name;link;diffnummcrafted;tools;reagent1num;reagent1link;reagent2num;reagent2link;",

		--store difficulty as one letter
		--'o' = optimal
		--'m' = medium
		--'e' = easy
		--'t' = trivial

		index = {
			["name"] = itemname,
			["difficulty"] = "optimal",
			["nummade"] = nummade,
			["link"] = link,
			["tools"] = "tools",
			["texture"] = "texture",
			["numcraftable"] = number,
			["numcraftablewbank"] = number,
			["numcraftablewalts"] = number or nil if not available
			[reagentindex] = {
				["name"] = name,
				["link"] = link,
				["needed"] = num,
				["texture"] = texture,
				["num"] = number,
				["numwbank"] = number,
				["numwalts"] = number or nil if not available
				['vendor'] = bool,
			},

			--nuking..
			["numreagents"] = num,
			["index"] = index,
			["profession"] = profession,

		}
	}
}
]]
