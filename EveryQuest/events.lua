local addon = LibStub("AceAddon-3.0"):GetAddon("EveryQuest")
local L = LibStub("AceLocale-3.0"):GetLocale("EveryQuest")
local Quixote = LibStub("LibQuixote-2.0")
local zoneid, zonegroup
local sfmt = string.format
local db, dbpc
local recentcompleted, recentcategory

function addon:EventsEnable()
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("QUEST_PROGRESS")
	self:RegisterEvent("QUEST_COMPLETE")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	
	Quixote.RegisterCallback(self, "Quest_Abandoned", "Abandon")
	Quixote.RegisterCallback(self, "Quest_Gained", "Gained")
	Quixote.RegisterCallback(self, "Quest_Complete", "Complete")
	Quixote.RegisterCallback(self, "Quest_Failed", "Failed")
	addon:SecureHook("GetQuestReward")
	db = EveryQuest.db.profile
	dbpc = EveryQuest.dbpc.profile
end

function addon:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self:ZONE_CHANGED_NEW_AREA()
	local str = self:GetReleaseString()
	if str ~= nil then
		self:Print(str)
	end
end

function addon:QUEST_PROGRESS()
	self:Debug("QUEST_PROGRESS - " .. GetTitleText())
	recentquest = Quixote:GetQuest(GetTitleText())
	local _, _, title, _, _, _, completed, _, _, category = Quixote:GetQuestByUid(recentquest)
	recentcompleted = completed
	recentcategory = category
	recenttitle = title
end

function addon:QUEST_COMPLETE()
	self:Debug("QUEST_COMPLETE - " .. GetTitleText())
	recentquest = Quixote:GetQuest(GetTitleText())
	local _, _, title, _, _, _, completed, _, _, category = Quixote:GetQuestByUid(recentquest)
	recentcompleted = completed
	recentcategory = category
	recenttitle = title
end

function addon:ZONE_CHANGED_NEW_AREA()
	--self:Debug("ZONE_CHANGED_NEW_AREA - " .. GetRealZoneText())
	if db.track then
		local continent = nil
		if not WorldMapFrame:IsShown() then
			continent = GetCurrentMapContinent()
		end
		z, g = self:GetZoneId(GetRealZoneText(), continent)
		if z ~= nil then
			zoneid = z
		end
		if g ~= nil then
			zonegroup = g
		end
		self:Debug("Zone Changed ("..GetRealZoneText()..") - zoneid = " .. tostring(zoneid) .. " zonegroup = " .. tostring(zonegroup))
		addon.listsorted = false
		self:UpdateFrame(zoneid, zonegroup)
	end
end

function addon:Abandon(event, title, uid)
	self:Debug("Abandon - " .. tostring(uid))
	local _, _, title, _, _, _, completed, _, _, category = Quixote:GetQuestByUid(uid)
	local zone = self:AddQuest(uid, category, completed)
	if zone ~= false and zone ~= nil then
		self:Debug("QUEST_ABANDON - questid:"..tostring(uid).." zoneid:"..tostring(zone))
		dbpc.history[zone][uid].status = -1
		dbpc.history[zone][uid].abandoned = time()
		dbpc.history[zone][uid]["imported"] = nil
		self:UpdateFrame()
	else
		self:AddUnknown(uid, category, title)
		self:Error( sfmt(L["Abandon Quest: %s"], -- Abandon quest Error message, %s = localized db error message
												L["Unable to get Quest Information from DB"]) ) -- localized db error message
	end
	
end

function addon:Gained(event, title, uid)
	self:Debug("Gained - " .. tostring(uid))
	local _, _, title, _, _, _, completed, _, _, category = Quixote:GetQuestByUid(uid)
	local zone = self:AddQuest(uid, category, completed)
	self:Debug("Quixote_Quest_Gained - questid:"..tostring(uid).." zoneid:"..tostring(zone))
	if zone ~= false and zone ~= nil then
		dbpc.history[zone][uid]["imported"] = nil
		self:UpdateFrame()
	else
		self:AddUnknown(uid, category, title)
		self:Error( sfmt(L["Obtained Quest: %s"], -- Obtained quest Error message, %s = localized db error message
													L["Unable to get Quest Information from DB"]) ) -- localized db error message
	end
end

function addon:Complete(event, title, uid)
	-- Complete as in completed all the objectives
	
	local _, _, title, _, _, _, completed, _, _, category = Quixote:GetQuestByUid(uid)
	local zone = self:AddQuest(uid, category, completed)
	
	if zone ~= false and zone ~= nil then
		--if dbpc.history[zone] then
			self:Debug("Complete - " .. tostring(uid) .. " zoneid:"..tostring(zone))
		--end
		dbpc.history[zone][uid].status = 1
		dbpc.history[zone][uid]["imported"] = nil
		dbpc.history[zone][uid].abandoned = nil
		dbpc.history[zone][uid].failed = nil
		self:Debug("Quixote_Quest_Complete - questid:"..tostring(uid).." zoneid:"..tostring(zone))
		self:UpdateFrame()
	else
		self:AddUnknown(uid, category, title)
		self:Error( sfmt(L["Complete Quest: %s"], -- Complete quest Error message, %s = localized db error message
												L["Unable to get Quest Information from DB"]) ) -- localized db error message
	end
end

function addon:Failed(event, title, uid)
	self:Debug("Failed - " .. tostring(uid))
	local _, _, title, _, _, _, completed, _, _, category = Quixote:GetQuestByUid(uid)
	local zone = self:AddQuest(uid, category, completed)
	if zone ~= false and zone ~= nil then
		dbpc.history[zone][uid].status = -1
		dbpc.history[zone][uid].failed = time()
		self:Debug("Quixote_Quest_Failed - questid:"..tostring(uid).." zoneid:"..tostring(zone))
		dbpc.history[zone][uid]["imported"] = nil
		self:UpdateFrame()
	else
		self:AddUnknown(uid, category, title)
		self:Error( sfmt(L["Failed Quest: %s"], -- Failed quest Error message, %s = localized db error message
												L["Unable to get Quest Information from DB"]) ) -- localized db error message
	end
end

function addon:GetQuestReward(...)
	addon:Debug("Hooked GetQuestReward")
	addon:TurnedIn(recentquest, recentcompleted, recentcategory, recenttitle)
end

function addon:TurnedIn(uid, completed, category, title)
	--uid = Quixote:GetQuest(title)
	self:Debug("TurnedIn - " .. tostring(uid))
	--local _, _, title, _, _, _, completed, _, _, category = Quixote:GetQuestByUid(uid)
	local zone, daily, weekly = self:AddQuest(uid, category, completed)
	if zone ~= false and zone ~= nil then
		self:Debug("QuestTurnedIn - questid:"..tostring(uid).." zoneid:"..tostring(zone))
		dbpc.history[zone][uid].status = 2
		dbpc.history[zone][uid].completed = time()
		if daily or weekly then
			if dbpc.history[zone][uid].count ~= nil then
				dbpc.history[zone][uid].count = dbpc.history[zone][uid].count +1
			else
				dbpc.history[zone][uid].count = 1
			end
		end
		dbpc.history[zone][uid]["imported"] = nil
		dbpc.history[zone][uid].abandoned = nil
		dbpc.history[zone][uid].failed = nil
		self:UpdateFrame()
	else
		self:AddUnknown(uid, category, title)
		self:Error( sfmt(L["Turn In Quest: %s"], -- Turn In quest Error message, %s = localized db error message
												L["Unable to get Quest Information from DB"]) ) -- localized db error message
	end
end