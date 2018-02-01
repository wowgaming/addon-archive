
local myfaction = UnitFactionGroup("player")
local L = TOURGUIDE_LOCALE
TOURGUIDE_LOCALE = nil

TourGuide = DongleStub("Dongle-1.0"):New("TourGuide")
if tekDebug then TourGuide:EnableDebug(10, tekDebug:GetFrame("TourGuide")) end
TourGuide.guides = {}
TourGuide.guidelist = {}
TourGuide.nextzones = {}
TourGuide.Locale = L


TourGuide.icons = setmetatable({
	ACCEPT = "Interface\\GossipFrame\\AvailableQuestIcon",
	COMPLETE = "Interface\\Icons\\Ability_DualWield",
	TURNIN = "Interface\\GossipFrame\\ActiveQuestIcon",
	KILL = "Interface\\Icons\\Ability_Creature_Cursed_02",
	RUN = "Interface\\Icons\\Ability_Tracking",
	MAP = "Interface\\Icons\\Ability_Spy",
	FLY = "Interface\\Icons\\Ability_Druid_FlightForm",
	SETHEARTH = "Interface\\AddOns\\TourGuide\\resting.tga",
	HEARTH = "Interface\\Icons\\INV_Misc_Rune_01",
	NOTE = "Interface\\Icons\\INV_Misc_Note_01",
	USE = "Interface\\Icons\\INV_Misc_Bag_08",
	BUY = "Interface\\Icons\\INV_Misc_Coin_01",
	BOAT = "Interface\\Icons\\Spell_Frost_SummonWaterElemental",
	GETFLIGHTPOINT = "Interface\\Icons\\Ability_Hunter_EagleEye",
}, {__index = function() return "Interface\\Icons\\INV_Misc_QuestionMark" end})


function TourGuide:Initialize()
	self.db = self:InitializeDB("TourGuideAlphaDB", {
		char = {
			hearth = "Unknown",
			turnedin = {},
			turnins = {},
			cachedturnins = {},
			trackquests = true,
			completion = {},
			currentguide = "No Guide",
			mapquestgivers = true,
			mapnotecoords = true,
			alwaysmapnotecoords = false,
			showstatusframe = true,
			showuseitem = true,
			showuseitemcomplete = true,
			rafmode = false,
		},
	})
	if self.db.char.turnedin then self.db.char.turnedin = nil end -- Purge old table if present
	self.cachedturnins = self.db.char.cachedturnins


	LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("TourGuide", {
		type = "launcher",
		icon = "Interface\\Icons\\Ability_Rogue_Sprint",
		OnClick = function() InterfaceOptionsFrame_OpenToCategory(TourGuide.configpanel) end,
	})
end


function TourGuide:Enable()
	self.Enable = nil -- Dongle likes to call Enable multiple times if we bug LightHeaded... so we need to nil out to ensure we are only called once
	if TomTom and TomTom.version ~= "SVN" and (tonumber(TomTom.version) or 0) < 120 then self:Print("Your version of TomTom is out of date.  TourGuide waypoints may not work correctly.") end

	if self.db.char.currentguide == "No Guide" and UnitLevel("player") == 1 and UnitXP("player") == 0 then
		local startguides = {BloodElf = "Eversong Woods (1-13)", Orc = "Durotar (1-12)", Troll = "Durotar (1-12)", Tauren = "Mulgore (1-12)", Undead = "Tirisfal Glades (1-12)",
			Dwarf = "Dun Morogh (1-11)", Gnome = "Dun Morogh (1-11)", Dreanei = "Azuremyst Isle (1-12)", Human = "Elwynn Forest (1-12)", NightElf = "Teldrassil (1-12)"}
		self.db.char.currentguide = startguides[select(2, UnitRace("player"))] or self.guidelist[1]
	end

	self.db.char.currentguide = self.db.char.currentguide or self.guidelist[1]
	if self.guides[self.db.char.currentguide] then
		self:LoadGuide(self.db.char.currentguide)
	else
		local guidenotloaded = self.db.char.currentguide

		function self:Disable(...)
			if not self.db.char.currentguide then self.db.char.currentguide = guidenotloaded end
		end

		function self:ADDON_LOADED()
			if not self.guides[guidenotloaded] then return end
			self:LoadGuide(guidenotloaded)
			self:UpdateStatusFrame()
			self:UpdateGuidesPanel()
			self:UnregisterEvent("ADDON_LOADED")
			self.ADDON_LOADED = nil
			self.Disable = orig
		end
		self:RegisterEvent("ADDON_LOADED")

		self:LoadGuide(self.guidelist[1])
	end
	self:PositionStatusFrame()
	self:PositionItemFrame()

	for _,event in pairs(self.TrackEvents) do self:RegisterEvent(event) end
	self:RegisterEvent("QUEST_COMPLETE", "UpdateStatusFrame")
	self:RegisterEvent("QUEST_DETAIL", "UpdateStatusFrame")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "CommCurrentObjective")
	self.TrackEvents = nil
	self:QuestID_QUEST_LOG_UPDATE()
	GetQuestsCompleted(TourGuide.turnedinquests)
	self:UpdateStatusFrame()
	self:RegisterEvent("QUEST_QUERY_COMPLETE")
	if IsLoggedIn() then QueryQuestsCompleted()
	else
		self:RegisterEvent("PLAYER_LOGIN")
		function self:PLAYER_LOGIN()
			QueryQuestsCompleted()
			self:UnregisterEvent("PLAYER_LOGIN")
			self.PLAYER_LOGIN = nil
		end
	end
end


function TourGuide:RegisterGuide(name, nextzone, faction, sequencefunc)
	if faction and faction ~= myfaction then return end
	self.guides[name] = sequencefunc
	self.nextzones[name] = nextzone
	table.insert(self.guidelist, name)
end


function TourGuide:LoadNextGuide()
	self:LoadGuide(self.nextzones[self.db.char.currentguide] or "No Guide", true)
	self:UpdateGuidesPanel()
	return true
end


local firstcall = true
function TourGuide:GetQuestLogIndexByName(name)
	name = name or self.quests[self.current]
	name = name:gsub(L.PART_GSUB, "")
	for i=1,GetNumQuestLogEntries() do
		local title, _, _, _, isHeader = GetQuestLogTitle(i)
		if firstcall and not isHeader then
			firstcall = nil
			if string.sub(title, 1, 1) == "[" then self:Print("Another addon, most likely a \"Quest Level\" addon, is preventing TourGuide's quest detection from working correctly.") end
		end
		if not isHeader and title == name then return i end
	end
end


function TourGuide:GetQuestLogIndexByQID(qid)
	for i=1,GetNumQuestLogEntries() do
		local link = GetQuestLink(i)
		local thisqid = link and self.QIDmemo[link]
		if thisqid and qid == thisqid then return i end
	end
end


function TourGuide:GetQuestDetails(name, qid, qo)
	if not name then return end

	local i = qid and self:GetQuestLogIndexByQID(qid) or self:GetQuestLogIndexByName(name)
	local complete = i and (qo and self:IsQuestObjectiveComplete(i, qo) or select(7, GetQuestLogTitle(i)) == 1)
	return i, complete
end


function TourGuide:FindBagSlot(itemid)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			local item = GetContainerItemLink(bag, slot)
			if item and string.find(item, "item:"..itemid) then return bag, slot end
		end
	end
end


function TourGuide:GetObjectiveInfo(i)
	i = i or self.current
	if not self.actions[i] then return end

	return self.actions[i], self.quests[i]:gsub("@.*@", ""), self.quests[i] -- Action, display name, full name
end


function TourGuide:GetObjectiveStatus(i)
	i = i or self.current
	if not self.actions[i] then return end

	local qid = self:GetObjectiveTag("QID", i)
	local qo = self:GetObjectiveTag("QO", i)

	local logi, complete = self:GetQuestDetails(self.quests[i], qid, qo)
	return qo and complete or qid and self.turnedinquests[qid] or self.turnedin[self.quests[i]], logi, complete
end


local qidactions = {ACCEPT = true, COMPLETE = true, TURNIN = true}
function TourGuide:SetTurnedIn(i, value, noupdate)
	if not i then
		i = self.current
		value = true
	end

	if value then value = true else value = nil end -- Cleanup to minimize savedvar data

	local qid = self:GetObjectiveTag("QID", i)
	if qid and qidactions[self:GetObjectiveInfo(i)] then self.turnedinquests[qid] = value
	else self.turnedin[self.quests[i]] = value end
	self:DebugF(1, "Set turned in %q = %s", self.quests[i], tostring(value))
	if not noupdate then self:UpdateStatusFrame()
	else self.updatedelay = i end
end


function TourGuide:CompleteQuest(name)
	if not self.current then
		self:DebugF(1, "Cannot complete %q, no guide loaded", name)
		return
	end

	local i = self.current
	local action, quest
	repeat
		action, quest = self:GetObjectiveInfo(i)
		if action == "TURNIN" and not self:GetObjectiveStatus(i) and name == quest:gsub(L.PART_GSUB, "") then
			self:DebugF(1, "Saving quest turnin %q", quest)
			return self:SetTurnedIn(i, true, true)
		end
		i = i + 1
	until not action
	self:DebugF(1, "Quest %q not found!", name)
end


---------------------------------
--      Utility Functions      --
---------------------------------

function TourGuide.ColorGradient(perc)
	if perc >= 1 then return 0,1,0
	elseif perc <= 0 then return 1,0,0 end

	local segment, relperc = math.modf(perc*2)
	local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, 1,0,0, 1,0.82,0, 0,1,0)
	return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end


function TourGuide:DumpLoc()
	if IsShiftKeyDown() then
		if not self.db.global.savedpoints then self:Print("No saved points")
		else for t in string.gmatch(self.db.global.savedpoints, "([^\n]+)") do self:Print(t) end end
	elseif IsControlKeyDown() then
		self.db.global.savedpoints = nil
		self:Print("Saved points cleared")
	else
		local _, _, x, y = DongleStub("Astrolabe-0.4"):GetCurrentPlayerPosition()
		local s = string.format("%s, %s, (%.2f, %.2f) -- %s %s", GetZoneText(), GetSubZoneText(), x*100, y*100, self:GetObjectiveInfo())
		self.db.global.savedpoints = (self.db.global.savedpoints or "") .. s .. "\n"
		self:Print(s)
	end
end
