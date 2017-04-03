--[[
Name: LibQuixote-2.0
Revision: $Revision: 86 $
Author(s): David Lynch (kemayo@gmail.com)
Website: http://www.wowace.com/wiki/LibQuixote-2.0
Documentation: http://www.wowace.com/wiki/LibQuixote-2.0
SVN: http://svn.wowace.com/wowace/trunk/LibQuixote-2.0/
Description: Abstracts out questlog handling.
License: LGPL v2.1
]]

local MAJOR_VERSION = "LibQuixote-2.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 86 $"):match("%d+")) or 0

-- #AUTODOC_NAMESPACE lib

local lib, oldMinor = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

-- localization issues:
local DUNGEON = LFG_TYPE_DUNGEON
local HEROIC = DUNGEON_DIFFICULTY2
local shorttags = {
	[ELITE] = '+',
	[GROUP] = 'g',
	[PVP] = 'p',
	[RAID] = 'r',
	[DUNGEON] = 'd',
	[HEROIC] = 'd+',
	[DAILY] = "\226\128\162", -- adorable little circle
}
lib.shorttags = shorttags
local tagWeight = {
	[ELITE] = 1,
	[GROUP] = 2,
	[PVP] = 3,
	[RAID] = 4,
	[DUNGEON] = 5,
	[HEROIC] = 6,
	[DAILY] = 7,
}
lib.tags = {
	ELITE = ELITE,
	GROUP = GROUP,
	PVP = PVP,
	RAID = RAID,
	DUNGEON = DUNGEON,
	HEROIC = HEROIC,
	DAILY = DAILY,
}

local playerName = UnitName("player")

local _G = _G
local GetQuestLink = _G.GetQuestLink
local GetQuestLogTitle = _G.GetQuestLogTitle
local GetQuestLogSelection = _G.GetQuestLogSelection
local GetNumQuestLogEntries = _G.GetNumQuestLogEntries
local GetQuestLogQuestText = _G.GetQuestLogQuestText
local GetNumQuestLeaderBoards = _G.GetNumQuestLeaderBoards

local new, del, deepDel, doAll
do
	local list = setmetatable({}, {__mode='k'})
	function new(...)
		local t = next(list)
		if t then
			list[t] = nil
			for i = 1, select('#', ...) do
				t[i] = select(i, ...)
			end
			return t
		else
			return { ... }
		end
	end
	function del(t)
		setmetatable(t, nil)
		table.wipe(t)
		list[t] = true
		return nil
	end
	function deepDel(t)
		if type(t) ~= "table" then
			return nil
		end
		for k,v in pairs(t) do
			t[k] = deepDel(v)
		end
		return del(t)
	end
	function doAll(func, ...)
		for i=1, select('#', ...) do
			func(select(i, ...))
		end
	end
end

local frame
if lib.frame then
	frame = lib.frame
	frame:UnregisterAllEvents()
	frame:SetScript("OnEvent", nil)
	frame:SetScript("OnUpdate", nil)
else
	frame = CreateFrame("Frame", MAJOR_VERSION .. "_Frame")
	lib.frame = frame
end

frame:RegisterEvent("QUEST_LOG_UPDATE")
frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
frame:RegisterEvent("CHAT_MSG_ADDON")

frame:SetScript("OnEvent", function(this, event, ...)
	this[event](lib, ...)
end)

-- this is just a throttler for QUEST_LOG_UPDATE
local timeSoFar = 0
frame:SetScript("OnUpdate", function(this, timeSinceLast)
	timeSoFar = timeSoFar + timeSinceLast
	if timeSoFar > 0.1 then
		timeSoFar = 0
		frame:Hide()
		frame:QUEST_LOG_UPDATE()
	end
end)

if lib.callbacks then
	lib:UnregisterAll(lib) -- unregisters all callbacks that quixote is doing on itself (comms stuff, mostly)
	lib:UnhookDialogs()
else
	lib.callbacks = LibStub("CallbackHandler-1.0"):New(lib, nil, nil, "UnregisterAll")
end

do
	local tooltip = lib.tooltip
	local function tooltip_line(link, line)
		if not tooltip then
			tooltip = CreateFrame("GameTooltip", MAJOR_VERSION.."_Tooltip", nil, "GameTooltipTemplate")
			tooltip:SetOwner(UIParent, "ANCHOR_NONE")
			lib.tooltip = tooltip
		end
		tooltip:ClearLines()
		tooltip:SetHyperlink(link)
		
		if tooltip:NumLines() < line then return false end
		return _G[MAJOR_VERSION.."_TooltipTextLeft"..line]:GetText()
	end
	lib.UID_to_name = setmetatable(lib.UID_to_name or {}, {__index = function(self, key)
		local link = (type(key) == 'string') and key or ('quest:'..key)
		local uid = string.match(link, '%d+')
		local name = tooltip_line(link, 1)
		if name then
			self[uid] = name
			return name
		end
		return false
	end,})
end

-- Sorts a table of quests by level, with quests of the same level ordered
-- by elite, dungeon or raid tags, i.e. normal < elite < dungeon < raid.
-- Quests of the same level and tag are sorted alphabetically by title.
local questSort = function(a,b)
	local q = lib.quests
	local aa = (q[a].level*4) + (q[a].tag and tagWeight[q[a].tag] or 0)
	local bb = (q[b].level*4) + (q[b].tag and tagWeight[q[b].tag] or 0)
	if aa == bb then
		return q[a].title < q[b].title
	end
	return aa < bb
end

-- Various data tables:
lib.quests = lib.quests or new()
lib.quests_complete = lib.quests_complete or 0
lib.quest_ids = lib.quest_ids or new()
lib.quest_zones = lib.quest_zones or new()
lib.zones = lib.zones or new()
lib.quest_objectives = lib.quest_objectives or new()
lib.quest_mobs = lib.quest_mobs or new()
lib.quest_items = lib.quest_items or new()

do
	local orig_abandon_onaccept, orig_abandon_items_onaccept, abandon_onaccept, abandon_items_onaccept
	local orig_AcceptQuest = AcceptQuest
	function AcceptQuest()
		lib.npc = UnitName("npc")
		lib.npc_is_player = UnitIsPlayer("npc")
		return orig_AcceptQuest()
	end

	function lib:UnhookDialogs()
		StaticPopupDialogs["ABANDON_QUEST"].OnAccept = orig_abandon_onaccept
		StaticPopupDialogs["ABANDON_QUEST_WITH_ITEMS"].OnAccept = orig_abandon_items_onaccept
	end
	function abandon_onaccept()
		local name = GetAbandonQuestName()
		local uid = lib:GetQuest(name)
		orig_abandon_onaccept()
		lib.callbacks:Fire("Quest_Abandoned", name, uid)
	end
	function abandon_items_onaccept()
		local name = GetAbandonQuestName()
		local uid = lib:GetQuest(name)
		orig_abandon_items_onaccept()
		lib.callbacks:Fire("Quest_Abandoned", name, uid)
	end
	orig_abandon_onaccept = StaticPopupDialogs["ABANDON_QUEST"].OnAccept
	orig_abandon_items_onaccept = StaticPopupDialogs["ABANDON_QUEST_WITH_ITEMS"].OnAccept
	StaticPopupDialogs["ABANDON_QUEST"].OnAccept = abandon_onaccept
	StaticPopupDialogs["ABANDON_QUEST_WITH_ITEMS"].OnAccept = abandon_items_onaccept
end

local objects_pattern = '^' .. QUEST_OBJECTS_FOUND:gsub('(%%%d?$?.)', '(.+)') .. '$' --QUEST_OBJECTS_FOUND = "%s: %d/%d"
local monsters_pattern = '^' .. QUEST_MONSTERS_KILLED:gsub('(%%%d?$?.)', '(.+)') .. '$' --QUEST_MONSTERS_KILLED = "%s slain: %d/%d"
local faction_pattern = '^' .. QUEST_FACTION_NEEDED:gsub('(%%%d?$?.)', '(.+)') .. '$' --QUEST_FACTION_NEEDED = "%s: %s / %s"
local player_pattern = '^' .. QUEST_PLAYERS_KILLED:gsub('(%%%d?$?.)', '(.+)') .. '$' --QUEST_PLAYERS_KILLED = "Players slain: %d/%d"

local update_is_running
function frame:QUEST_LOG_UPDATE()
	if update_is_running then
		return frame:Show()
	end
	update_is_running = true
	
	doAll(deepDel, lib.quest_ids, lib.quest_zones, lib.quest_mobs, lib.quest_items, lib.zones)
	
	local quests, old_quests = new(), lib.quests
	local quest_objectives, old_quest_objectives = new(), lib.quest_objectives
	local quest_zones, quest_ids, zones, quest_mobs, quest_items = new(), new(), new(), new(), new()
	
	-- The quest log is scanned:
	local selectionId = GetQuestLogSelection()
	local numEntries, numQuests = GetNumQuestLogEntries()
	local numQuestsComplete = 0
	local zone
	
	if numEntries > 0 then
		for id = 1, numEntries do
			SelectQuestLogEntry(id)
			local name, level, tag, group, header, collapsed, complete, daily = GetQuestLogTitle(id)
			if header then
				zone = name
				table.insert(zones, zone)
				quest_zones[zone] = new()
			else
				local q = new()
				local unique_id = tonumber(string.match(GetQuestLink(id), 'quest:(%d+)'))
				
				q.unique_id = unique_id
				q.id = id
				q.title = name
				q.level = level
				q.tag = tag
				q.group = group
				q.daily = daily
				if daily and not tag then
					q.tag = DAILY
				end
				q.complete = complete -- 1, -1, nil
				q.zone = zone
				
				if complete == 1 then
					numQuestsComplete = numQuestsComplete + 1
				end
				
				local numObjectives = GetNumQuestLeaderBoards(id)
				if numObjectives and numObjectives > 0 then
					local objectives = new()
					for o = 1, numObjectives do
						local desc, qtype, done = GetQuestLogLeaderBoard(o, id)
						local numNeeded, numItems, mobName
						
						if qtype == 'item' or qtype == 'object' then --'object' for the leaderboard in Dousing the Flames of Protection; maybe others.
							desc, numItems, numNeeded = desc:match(objects_pattern)
							numItems = tonumber(numItems)
							numNeeded = tonumber(numNeeded)
							quest_items[desc] = unique_id
						elseif qtype == 'monster' then
							mobName, numItems, numNeeded = desc:match(monsters_pattern)
							if mobName == nil or numItems == nil or numNeeded == nil then
								--Sometimes we get objectives like "Find Mankrik's Wife: 0/1", which are listed as "monster".
								mobName, numItems, numNeeded = desc:match(objects_pattern)
							end
							numItems = tonumber(numItems)
							numNeeded = tonumber(numNeeded)
							desc = mobName
							
							if quest_mobs[desc] then
								--Another quest also wants this mob!  Convert quest_mobs[desc] to a table.
								if type(quest_mobs[desc]) ~= 'table' then
									quest_mobs[desc] = new(quest_mobs[desc])
								end
								table.insert(quest_mobs[desc], unique_id)
							else
								quest_mobs[desc] = unique_id
							end
						elseif qtype == 'reputation' then
							desc, numItems, numNeeded = desc:match(faction_pattern)
						elseif (qtype == 'event') or (qtype == 'log') then
							numNeeded = 1
							numItems = done and 1 or 0
						elseif qtype == 'player' then
							numItems, numNeeded = desc:match(player_pattern)
							desc = COMBATLOG_FILTER_STRING_HOSTILE_PLAYERS -- "Enemy Players"
						end
						if (not desc) or strtrim(desc) == "" then
							desc = ""
							frame:Show() -- schedules a rescan in 0.1 seconds
						end
						objectives[desc] = new(numItems, numNeeded, qtype)
					end
					quest_objectives[unique_id] = objectives
				else
					quest_objectives[unique_id] = false
				end
				quests[unique_id] = q
				table.insert(quest_ids, unique_id)
				table.insert(quest_zones[zone], unique_id)
			end
		end
		SelectQuestLogEntry(selectionId)
	end
	
	lib.quests = quests
	lib.quest_ids = quest_ids
	lib.quest_zones = quest_zones
	lib.zones = zones
	lib.quest_objectives = quest_objectives
	lib.quest_items = quest_items
	lib.quest_mobs = quest_mobs
	lib.quests_complete = numQuestsComplete
	
	table.sort(zones)
	table.sort(quests, questSort)
	table.sort(quest_ids, questSort)
	for _, zquests in pairs(quest_zones) do
		table.sort(zquests, questSort)
	end
	
	-- Event firing
	local changed = false
	if lib.firstDone then
		for uid, quest in pairs(quests) do
			if not old_quests[uid] then
				-- Gained a quest
				lib.callbacks:Fire("Quest_Gained", quest.title, uid, GetNumQuestLeaderBoards(quest.id), quest.zone, lib.npc, lib.npc_is_player)
				changed = true
			else
				local oldquest = old_quests[uid]
				-- Any objectives changed?
				if quest_objectives[uid] then
					for desc, goal in pairs(quest_objectives[uid]) do
						-- goal: {got, needed, type}
						if (old_quest_objectives[uid]) then
							local oldgoal = old_quest_objectives[uid][desc]
							if (goal[1] ~= 0) and (oldgoal and oldgoal[1] ~= goal[1]) then
								-- An objective has advanced
								lib.callbacks:Fire("Objective_Update", quest.title, uid, desc, oldgoal and oldgoal[1] or 0, goal[1], goal[2], goal[3])
								changed = true
							end
						end
					end
					if old_quest_objectives[uid] and old_quest_objectives[uid][""] and not quest_objectives[uid][""] then
						-- An objective was previously uncached and has now been filled in.
						changed = true
					end
				end
				--Completed?
				if oldquest.complete ~= quest.complete then
					if quest.complete == 1 then
						lib.callbacks:Fire("Quest_Complete", quest.title, uid)
					elseif quest.complete == -1 then
						lib.callbacks:Fire("Quest_Failed", quest.title, uid)
					end
					changed = true
				end
			end
		end
		for uid, oldquest in pairs(old_quests) do
			-- Lost a quest?
			if not quests[uid] then
				lib.callbacks:Fire("Quest_Lost", oldquest.title, uid, oldquest.zone)
				changed = true
			end
		end
	else
		changed = true
		lib.firstDone = true
		frame:PARTY_MEMBERS_CHANGED()

		lib.callbacks:Fire("Ready")
	end
	
	if changed then
		lib.callbacks:Fire("Update")
	end
	
	-- clean up junk tables
	
	doAll(deepDel, old_quests, old_quest_objectives)
	
	update_is_running = false
end

-- Comms:
-- Someone joins party -> version info exchanged -> quest data shared

local last_incompatible_version = 0

lib.party = lib.party or {}
lib.party_quests = lib.party_quests or {}

local ChatThrottleLib = ChatThrottleLib
function lib:SendAddonMessage(contents, distribution, target, priority)
	if ChatThrottleLib and not lib.disable_comms then
		ChatThrottleLib:SendAddonMessage(priority or "NORMAL", "Quixote2", contents, distribution or "PARTY", target);
	end
end

--/dump LibStub("LibQuixote-2.0").party_quests
function frame:PARTY_MEMBERS_CHANGED()
	if(#lib.quest_ids == 0) then return end
	local p = new()
	local sent
	for i=1, GetNumPartyMembers() do
		local name, realm = UnitName('party'..i)
		p[name] = true
		if lib.party[name] == nil and name ~= UNKNOWN and not realm then
			lib:SendAddonMessage("v"..MINOR_VERSION, "WHISPER", name)
			lib.party[name] = false -- to prevent spamming with pointless version data
			lib.party_quests[name] = new()
			lib.party_quests[name].waiting = true
		end
	end
	for known in pairs(lib.party) do
		if not p[known] then
			lib.party[known] = deepDel(lib.party[known])
			lib.party_quests[known] = deepDel(lib.party_quests[known])
		end
	end
	del(p)
end

local commhandlers = {
	--version
	--  implicit sync request; 'v' is never broadcast to the party, only to unknown party members
	--  upon receiving 'v', begin a sync to the sender
	v = function(msg, distribution, sender)
		local version = tonumber(msg)
		if version <= last_incompatible_version then
			lib.callbacks:Fire("Incompatible_Version", sender, version)
		end
		if version > MINOR_VERSION then
			lib.callbacks:Fire("New_Version", sender, version)
		end
		lib.worth_sending = true
		
		lib.party[sender] = version
		--And sync:
		for _, uid in pairs(lib.quest_ids) do
			lib:SendAddonMessage("q"..uid, "WHISPER", sender, "BULK")
			if lib.quest_objectives[uid] then
				for desc, o in pairs(lib.quest_objectives[uid]) do
					local isrep = o[3] == "reputation"
					local got = isrep and lib:GetReactionLevel(o[1]) or o[1] or '1'
					local need = isrep and lib:GetReactionLevel(o[2]) or o[2] or '1'
					lib:SendAddonMessage("o"..uid.."~"..desc.."~"..(isrep and "r" or "")..got.."/"..need, "WHISPER", sender, "BULK")
				end
			end
			lib:SendAddonMessage("r"..uid, "WHISPER", sender, "BULK")
		end
		lib:SendAddonMessage("d", "WHISPER", sender, "BULK")
	end,
	--quest gained
	q = function(msg, distribution, sender)
		local uid = tonumber(msg)
		if not lib.party_quests[sender] then return end
		local name = lib.UID_to_name[uid] -- Forces the tooltip request.
		lib.party_quests[sender][uid] = lib.party_quests[sender][uid] or new()
	end,
	--objective update
	o = function(msg, distribution, sender)
		local uid, objective, isrep, got, need = msg:match("^(.-)~(.-)~(r?)(%d-)/(%d-)$")
		uid = tonumber(uid)
		if not (lib.party_quests[sender] and lib.party_quests[sender][uid]) then return end
		local o = lib.party_quests[sender][uid][objective]
		isrep = isrep == 'r'
		got = isrep and lib:GetReactionName(tonumber(got)) or tonumber(got)
		need = isrep and lib:GetReactionName(tonumber(need)) or tonumber(need)
		if o then
			o[1] = got
			o[2] = need
			o[3] = isrep
			if not lib.party_quests[sender].waiting then
				lib.callbacks:Fire("Party_Objective_Update", sender, uid, lib.UID_to_name[uid], objective, got, need, isrep)
				lib.callbacks:Fire("Party_Update", sender, uid)
			end
		else
			lib.party_quests[sender][uid][objective] = new(got, need, isrep)
		end
	end,
	--sending a quest is complete
	r = function(msg, distribution, sender)
		local uid = tonumber(msg)
		if not (lib.party_quests[sender] and lib.party_quests[sender][uid]) then return end
		if not lib.party_quests[sender].waiting then
			lib.callbacks:Fire("Party_Quest_Gained", sender, uid, lib.UID_to_name[uid])
			lib.callbacks:Fire("Party_Update", sender, uid)
		end
	end,
	--quest finished
	c = function(msg, distribution, sender)
		local uid = tonumber(msg)
		lib.callbacks:Fire("Party_Quest_Complete", sender, uid, lib.UID_to_name[uid])
		lib.callbacks:Fire("Party_Update", sender, uid)
	end,
	--quest failed
	f = function(msg, distribution, sender)
		local uid = tonumber(msg)
		lib.callbacks:Fire("Party_Quest_Failed", sender, uid, lib.UID_to_name[uid])
		lib.callbacks:Fire("Party_Update", sender, uid)
	end,
	--quest lost
	l = function(msg, distribution, sender)
		local uid = tonumber(msg)
		if not (lib.party_quests[sender] and lib.party_quests[sender][uid]) then return end
		lib.callbacks:Fire("Party_Quest_Lost", sender, uid, lib.UID_to_name[uid])
		lib.callbacks:Fire("Party_Update", sender, uid)
		lib.party_quests[sender][uid] = deepDel(lib.party_quests[sender][uid])
	end,
	--sync done
	d = function(msg, distribution, sender)
		if not lib.party_quests[sender] then return end
		lib.party_quests[sender].waiting = nil
		lib.callbacks:Fire("Sync_Finished", sender)
		lib.callbacks:Fire("Party_Update", sender)
	end,
}
function frame:CHAT_MSG_ADDON(prefix, msg, distribution, sender)
	if prefix ~= "Quixote2" or sender == playerName or lib.disable_comms then return end
	--LibStub("AceConsole-2.0"):PrintLiteral(msg, distribution, sender)
	
	local commtype, remainder = msg:match("^(%a)(.*)")
	if (not commtype) or (not commhandlers[commtype]) then return end
	
	--/dump LibStub("LibQuixote-2.0").party_quests.Alibank
	commhandlers[commtype](remainder, distribution, sender)
end
lib:RegisterCallback("Quest_Gained", function(event, title, uid, objectives)
	if not lib.worth_sending or GetNumPartyMembers() == 0 then return end
	lib:SendAddonMessage("q"..uid)
	if objectives > 0 then
		for objective, got, need, t in lib:IterateObjectivesForQuest(uid) do
			lib:SendAddonMessage("o"..uid.."~"..objective.."~"..(t=="reputation" and "r" or "")..got.."/"..need)
		end
	end
	lib:SendAddonMessage("r"..uid)
end)
lib:RegisterCallback("Quest_Lost", function(event, title, uid)
	if not lib.worth_sending or GetNumPartyMembers() == 0 then return end
	lib:SendAddonMessage("l"..uid)
end)
lib:RegisterCallback("Quest_Complete", function(event, title, uid)
	if not lib.worth_sending or GetNumPartyMembers() == 0 then return end
	lib:SendAddonMessage("c"..uid)
end)
lib:RegisterCallback("Quest_Failed", function(event, title, uid)
	if not lib.worth_sending or GetNumPartyMembers() == 0 then return end
	lib:SendAddonMessage("f"..uid)
end)
lib:RegisterCallback("Objective_Update", function(event, title, uid, objective, had, got, need, t)
	if not lib.worth_sending or GetNumPartyMembers() == 0 then return end
	lib:SendAddonMessage("o"..uid.."~"..objective.."~"..(t=="reputation" and ("r"..lib:GetReactionLevel(got).."/"..lib:GetReactionLevel(need)) or (got.."/"..need)))
end)

-- Public API:

local function zoneIter(t, i)
	if not t then return end
	local i, v = next(t, i)
	if i then
		return i, v, #lib.quest_zones[v]
	end
end
function lib:IterateZones()
	return zoneIter, self.zones, nil
end

local function zoneQuestIter(t, i)
	if not t then return end
	local i, v = next(t, i)
	if i then
		return i, lib:GetQuestByUid(v)
	end
end
function lib:IterateQuestsInZone(zone)
	return zoneQuestIter, self.quest_zones[zone], nil
end

function lib:IterateQuestsByLevel()
	return zoneQuestIter, self.quest_ids, nil
end

local function objIter(t, k)
	if not t then return end
	local k, v = next(t, k)
	if k then
		return k, unpack(v)
	end
end
function lib:IterateObjectivesForQuest(uid)
	return objIter, self.quest_objectives[uid], nil
end

function lib:GetNumQuests()
	return #self.quest_ids, self.quests_complete
end

function lib:GetQuest(id)
	if type(id) == 'string' then
		for uid, q in pairs(lib.quests) do
			if q.title == id then
				id = uid
				break
			end
		end
	end
	return self:GetQuestByUid(id)
end

function lib:GetQuestByUid(uid)
	local q = self.quests[uid]
	if not q then return end
	return q.unique_id, q.id, q.title, q.level, q.tag, GetNumQuestLeaderBoards(q.id), q.complete, q.group, q.daily, q.zone
end

function lib:GetQuestById(id)
	--By quest log id.
	for uid, quest in pairs(self.quests) do
		if quest.id == id then
			return self:GetQuestByUid(uid)
		end
	end
end

function lib:GetQuestObjective(uid, desc)
	local q = self.quest_objectives[uid]
	if q and q[desc] then
		return desc, unpack(q[desc])
	end
end

function lib:GetNumQuestObjectives(uid)
	local q = self.quest_objectives[uid]
	if not q then return end
	
	local c = 0
	for desc,o in pairs(q) do
		if o[1] == o[2] then
			c = c + 1
		end
	end
	return GetNumQuestLeaderBoards(self.quests[uid].id), c
end

function lib:GetQuestText(uid)
	local q = self.quests[uid]
	if not q then return end
	
	local selectionId = GetQuestLogSelection()
	SelectQuestLogEntry(q.id)
	local description, objectives = GetQuestLogQuestText(q.id)
	SelectQuestLogEntry(selectionId)
	return description, objectives
end

function lib:IsQuestMob(mobname)
	return self.quest_mobs[mobname] and true
end

local function mobIter(mobList, i)
	-- This iterator is lightly special-cased to allow mobList to either be a list or a string.
	if type(mobList) == 'table' then
		i = next(mobList, i)
		return i, mobList[i]
	else
		return i==nil and 1 or nil, mobList
	end
end
function lib:IterateQuestsForMob(mobname)
	if self.quest_mobs[mobname] then
		return mobIter, self.quest_mobs[mobname], nil
	end
end

function lib:IsQuestItem(itemname)
	local uid = self.quest_items[itemname]
	if uid then
		return uid, itemname, unpack(self.quest_objectives[uid][itemname])
	end
end

-- Party:

local function realname(name)
	if type(name) == 'number' then
		return UnitName("party"..name), "party"..name
	end
	if name:match("^party%d$") then
		return UnitName(name), name
	end
	return name
end

function lib:PartyMemberHasQuixote(name)
	name = realname(name)
	return self.party[name]
end

-- TODO: Can this be turned into tooltip-scanning in 2.4?
function lib:PartyMemberHasQuest(name, uid)
	local name, unit = realname(name)
	if self.party_quests[name] then
		return self.party_quests[name][uid]
	elseif self.quests[uid] then
		--They don't have quixote, but we *do* have the quest, so IsUnitOnQuest can be fallen back on.
		local id = self.quests[uid].id
		if not unit then
			for i=1, GetNumPartyMembers() do
				local u = "party"..i
				if name == UnitName(u) then
					unit = u
					break
				end
			end
		end
		if unit then
			return IsUnitOnQuest(id, unit)
		end
	end
end

function lib:GetNumPartyMembersWithQuest(uid)
	local count = 0
	for i=1, GetNumPartyMembers() do
		if self:PartyMemberHasQuest(i, uid) then
			count = count + 1
		end
	end
	return count
end

local function partySort(a, b)
	-- pure alphabetical sorting
	return lib.UID_to_name[a] < lib.UID_to_name[b]
end
local function partyIter(t, k)
	k = next(t, k)
	if t[k] then
		return k, t[k]
	else
		del(t)
	end
end
function lib:IteratePartyMemberQuests(name)
	name = realname(name)
	if not self.party_quests[name] then
		return partyIter
	end
	local tmp = new()
	for uid in pairs(self.party_quests[name]) do
		table.insert(tmp, uid)
	end
	table.sort(tmp, partySort)
	return partyIter, tmp, nil
end

function lib:GetPartyQuestObjective(name, uid, objective)
	name = realname(name)
	if self.party_quests[name] and self.party_quests[name][uid] and self.party_quests[name][uid][objective] then
		return unpack(self.party_quests[name][uid][objective])
	end
end

function lib:GetPartyQuestNumObjectives(name, uid)
	name = realname(name)
	local objectives = self.party_quests[name] and self.party_quests[name][uid]
	if objectives then
		local total, complete = 0, 0
		for desc, status in pairs(objectives) do
			total = total + 1
			if status[1] == status[2] then
				complete = complete + 1
			end
		end
		return total, complete
	end
end

-- Utility:

function lib:IsQuestWatchedByUid(uid)
	local quid = self.quests[uid] and self.quests[uid].id
	if qid then
		return IsQuestWatched(qid)
	end
end

function lib:AddQuestWatchByUid(uid, watchTime)
	local qid = self.quests[uid] and self.quests[uid].id
	if qid then
		AddQuestWatch(qid, watchTime)
		return qid
	end
end

function lib:RemoveQuestWatchByUid(uid, watchTime)
	local qid = self.quests[uid] and self.quests[uid].id
	if qid then
		RemoveQuestWatch(qid, watchTime)
		return qid
	end
end

function lib:ShareQuestByUid(uid)
	-- Share the quest with nearby party members.
	local qid = self.quests[uid] and self.quests[uid].id
	if qid then
		local wasSelected = GetQuestLogSelection()
		SelectQuestLogEntry(qid)
		if GetQuestLogPushable() and GetNumPartyMembers() > 0 then
			QuestLogPushQuest()
		end
		SelectQuestLogEntry(wasSelected)
	end
end

function lib:ShowQuestLog(uid)
	local id = self.quests[uid] and self.quests[uid].id
	if id then
		QuestLog_SetSelection(id)
	else
		ShowUIPanel(QuestLogFrame)
	end
end

function lib:GetShortTagForQuest(uid)
	local q = self.quests[uid]
	if q.shorttag then return q.shorttag end
	if q and q.tag and shorttags[q.tag] then
		local tag = shorttags[q.tag]
		if q.tag == GROUP then
			tag = tag .. q.group
		end
		if q.daily and tag ~= shorttags[DAILY] then
			tag = tag .. shorttags[DAILY]
		end
		q.shorttag = tag
		return tag
	end
	return ''
end

function lib:GetTaggedQuestName(uid)
	-- It's such a common pattern
	local q = self.quests[uid]
	if q then
		return '['..q.level..self:GetShortTagForQuest(uid)..'] '..q.title
	end
	return ''
end

-- Get a numeric equivalent to a reaction level, from Hated=1 to Exalted=8.
do
	local reactions = {
		[FACTION_STANDING_LABEL1] = 1,
		[FACTION_STANDING_LABEL1_FEMALE] = 1,
		[FACTION_STANDING_LABEL2] = 2,
		[FACTION_STANDING_LABEL2_FEMALE] = 2,
		[FACTION_STANDING_LABEL3] = 3,
		[FACTION_STANDING_LABEL3_FEMALE] = 3,
		[FACTION_STANDING_LABEL4] = 4,
		[FACTION_STANDING_LABEL4_FEMALE] = 4,
		[FACTION_STANDING_LABEL5] = 5,
		[FACTION_STANDING_LABEL5_FEMALE] = 5,
		[FACTION_STANDING_LABEL6] = 6,
		[FACTION_STANDING_LABEL6_FEMALE] = 6,
		[FACTION_STANDING_LABEL7] = 7,
		[FACTION_STANDING_LABEL7_FEMALE] = 7,
		[FACTION_STANDING_LABEL8] = 8,
		[FACTION_STANDING_LABEL8_FEMALE] = 8,
	}
	--------------------------------------------
	-- Arguments:
	-- string - faction standing text
	--
	-- Notes:
	-- Returns a numeric-equivalent for faction standings.
	--
	-- Returns:
	-- * number - number from 1 to 8 or -1 if invalid
	--------------------------------------------
	function lib:GetReactionLevel(leveltext)
		return leveltext and reactions[leveltext] or -1
	end
	
	function lib:GetReactionName(level)
		for react, index in pairs(reactions) do
			if index == level then
				return react
			end
		end
	end
end
