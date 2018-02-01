

local TourGuide = TourGuide
local L = TourGuide.Locale
local hadquest


TourGuide.TrackEvents = {"UI_INFO_MESSAGE", "CHAT_MSG_LOOT", "CHAT_MSG_SYSTEM", "QUEST_LOG_UPDATE", "ZONE_CHANGED", "ZONE_CHANGED_INDOORS",
	"MINIMAP_ZONE_CHANGED", "ZONE_CHANGED_NEW_AREA"}


function TourGuide:ZONE_CHANGED(...)
	local zonetext, subzonetext, subzonetag, action, quest = GetZoneText(), string.trim(GetSubZoneText()), self:GetObjectiveTag("SZ"), self:GetObjectiveInfo()
	if (action == "RUN" or action == "FLY" or action == "HEARTH" or action == "BOAT") and (subzonetext == quest or subzonetext == subzonetag or zonetext == quest or zonetext == subzonetag) then
		self:DebugF(1, "Detected zone change %q - %q", action, quest)
		self:SetTurnedIn()
	end
end
TourGuide.ZONE_CHANGED_INDOORS = TourGuide.ZONE_CHANGED
TourGuide.MINIMAP_ZONE_CHANGED = TourGuide.ZONE_CHANGED
TourGuide.ZONE_CHANGED_NEW_AREA = TourGuide.ZONE_CHANGED


function TourGuide:CHAT_MSG_SYSTEM(event, msg)
	local action, quest = self:GetObjectiveInfo()

	local _, _, loc = msg:find(L["(.*) is now your home."])
	if loc then
		self:DebugF(1, "Detected setting hearth to %q", loc)
		self.db.char.hearth = loc
		return action == "SETHEARTH" and loc == quest and self:SetTurnedIn()
	end

	if action == "ACCEPT" then
		local _, _, text = msg:find(L["Quest accepted: (.*)"])
		if text and quest:gsub(L.PART_GSUB, "") == text then
			self:DebugF(1, "Detected quest accept %q", quest)
			return self:UpdateStatusFrame()
		end
	end
end


function TourGuide:QUEST_LOG_UPDATE(event)
	self:QuestID_QUEST_LOG_UPDATE()

	local action, _, logi, complete = self:GetObjectiveInfo(), self:GetObjectiveStatus()
	self:Debug(10, "QUEST_LOG_UPDATE", action, logi, complete)

	if (self.updatedelay and not logi) or action == "ACCEPT" or action == "COMPLETE" and complete then self:UpdateStatusFrame() end

	if action == "KILL" or action == "NOTE" then
		if complete then self:UpdateStatusFrame() end
		if self:GetObjectiveTag("QID") then return end

		local quest, questtext = self:GetObjectiveTag("Q"), self:GetObjectiveTag("QO")
		if not quest or not questtext then return end

		local qi = self:GetQuestLogIndexByName(quest)
		if qi and questtext and self:IsQuestObjectiveComplete(qi, questtext) then self:SetTurnedIn() end
	end
end


function TourGuide:IsQuestObjectiveComplete(qi, questtext)
	for i=1,GetNumQuestLeaderBoards(qi) do if GetQuestLogLeaderBoard(i, qi) == questtext then return true end end
end


function TourGuide:CHAT_MSG_LOOT(event, msg)
	local action, quest = self:GetObjectiveInfo()
	local lootitem, lootqty = self:GetObjectiveTag("L")
	local _, _, itemid, name = msg:find(L["^You .*Hitem:(%d+).*(%[.+%])"])
	self:Debug(10, event, action, quest, lootitem, lootqty, itemid, name)

	if action == "BUY" and name and name == quest
	or (action == "BUY" or action == "KILL" or action == "NOTE") and lootitem and itemid == lootitem and (GetItemCount(lootitem) + 1) >= lootqty then
		return self:SetTurnedIn()
	end
end


function TourGuide:UI_INFO_MESSAGE(event, msg)
	if msg == ERR_NEWTAXIPATH and self:GetObjectiveInfo() == "GETFLIGHTPOINT" then
		self:Debug(1, "Discovered flight point")
		self:SetTurnedIn()
	end
end


local orig = GetQuestReward
GetQuestReward = function(...)
	local quest = GetTitleText()
	TourGuide:Debug(10, "GetQuestReward", quest)
	TourGuide:CompleteQuest(quest, true)

	return orig(...)
end
