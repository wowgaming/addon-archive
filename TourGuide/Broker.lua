
local TourGuide = TourGuide
local dataobj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("TourGuide", {type = "data source", text = "Bah!", icon = TourGuide.icons.KILL})
local lastmapped, lastmappedaction


function TourGuide:UpdateStatusFrame()
	self:Debug(1, "UpdateStatusFrame", self.current)

	if self.updatedelay then
		local _, logi = self:GetObjectiveStatus(self.updatedelay)
		self:Debug(1, "Delayed update", self.updatedelay, logi)
		if logi then return end
	end

	local nextstep
	self.updatedelay = nil

	for i in ipairs(self.actions) do
		local turnedin, logi, complete = self:GetObjectiveStatus(i)
		if not turnedin and not nextstep then
			local action, name, quest = self:GetObjectiveInfo(i)
			local note, useitem, optional, prereq, lootitem, lootqty = self:GetObjectiveTag("N", i), self:GetObjectiveTag("U", i), self:GetObjectiveTag("O", i), self:GetObjectiveTag("PRE", i), self:GetObjectiveTag("L", i)
			self:Debug(11, "UpdateStatusFrame", i, action, name, note, logi, complete, turnedin, quest, useitem, optional, lootitem, lootqty, lootitem and GetItemCount(lootitem) or 0)
			local hasuseitem = useitem and self:FindBagSlot(useitem)
			local haslootitem = lootitem and GetItemCount(lootitem) >= lootqty
			local prereqturnedin = prereq and self.turnedin[prereq]

			-- Test for completed objectives and mark them done
			if action == "SETHEARTH" and self.db.char.hearth == name then return self:SetTurnedIn(i, true) end

			local zonetext, subzonetext, subzonetag = GetZoneText(), string.trim(GetSubZoneText()), self:GetObjectiveTag("SZ")
			if (action == "RUN" or action == "FLY" or action == "HEARTH" or action == "BOAT") and (subzonetext == name or subzonetext == subzonetag or zonetext == name or zonetext == subzonetag) then return self:SetTurnedIn(i, true) end

			if action == "KILL" or action == "NOTE" then
				if not optional and haslootitem then return self:SetTurnedIn(i, true) end

				local quest, questtext = self:GetObjectiveTag("Q", i), self:GetObjectiveTag("QO", i)
				if quest and questtext then
					local qi = self:GetQuestLogIndexByName(quest)
					for lbi=1,GetNumQuestLeaderBoards(qi) do
						self:Debug(1, quest, questtext, qi, GetQuestLogLeaderBoard(lbi, qi))
						if GetQuestLogLeaderBoard(lbi, qi) == questtext then return self:SetTurnedIn(i, true) end
					end
				end
			end

			local incomplete
			if action == "ACCEPT" then incomplete = (not optional or hasuseitem or haslootitem or prereqturnedin) and not logi
			elseif action == "TURNIN" then incomplete = not optional or logi
			elseif action == "COMPLETE" then incomplete = not complete and (not optional or logi)
			elseif action == "NOTE" or action == "KILL" then incomplete = not optional or haslootitem
			else incomplete = not logi end

			if incomplete then nextstep = i end

			local thisaction = action
			if nextstep and self.db.char.trackquests then
				for j=1,GetNumQuestWatches() do
					local logj = GetQuestIndexForWatch(i)
					RemoveQuestWatch(logj)
				end

				if (action == "COMPLETE" or action == "TURNIN") and logi then
					local j = i
					repeat
						action = self:GetObjectiveInfo(j)
						turnedin, logi, complete = self:GetObjectiveStatus(j)
						if action == thisaction and logi then AddQuestWatch(logi) end -- Watch quests when we can
						j = j + 1
					until action ~= thisaction
				end
			end
		end
	end
	QuestLog_Update()
	WatchFrame_Update()

	if not nextstep and self:LoadNextGuide() then return self:UpdateStatusFrame() end
	if not nextstep then return end

	self.current = nextstep
	local action, quest, fullquest = self:GetObjectiveInfo(nextstep)
	local turnedin, logi, complete = self:GetObjectiveStatus(nextstep)
	local note, useitem, optional = self:GetObjectiveTag("N", nextstep), self:GetObjectiveTag("U", nextstep), self:GetObjectiveTag("O", nextstep)

	dataobj.text, dataobj.icon = (quest or"???")..(note and " [?]" or ""), self.icons[action]
	TourGuide:CommCurrentObjective()

	self:DebugF(1, "Progressing to objective \"%s %s\"", action, quest)

	-- Mapping
	if (TomTom or Cartographer_Waypoints) and (lastmapped ~= quest or lastmappedaction ~= action) then
		lastmappedaction, lastmapped = action, quest
		self:ParseAndMapCoords(action, quest, self:GetObjectiveTag("Z", nextstep) or self.zonename, note, self:GetObjectiveTag("QID", nextstep), logi)
	end

	if self.db.char.showuseitem and action == "COMPLETE" and self.db.char.showuseitemcomplete then
		local useitem2 = GetQuestLogSpecialItemInfo(logi or 0)
		if useitem2 then useitem2 = tonumber(useitem2:match("item:(%d+):")) end
		self:SetUseItem(useitem2 or useitem)
	elseif self.db.char.showuseitem and action ~= "COMPLETE" then
		self:SetUseItem(useitem)
	else
		self:SetUseItem()
	end

	self:UpdateOHPanel()
	self:UpdateGuidesPanel()
end


function TourGuide:CommCurrentObjective()
	local action, quest, fullquest = self:GetObjectiveInfo()
	local qid = self:GetObjectiveTag("QID")
	SendAddonMessage("TGuide", action.." "..(quest or "???"), "PARTY")
	if qid then SendAddonMessage("TGuideQID", qid, "PARTY") end
end


local function GetQuadrant(frame)
	local x,y = frame:GetCenter()
	if not x or not y then return "BOTTOMLEFT", "BOTTOM", "LEFT" end
	local hhalf = (x > UIParent:GetWidth()/2) and "RIGHT" or "LEFT"
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, vhalf, hhalf
end


function dataobj.OnClick(self, btn)
	if TourGuide.db.char.currentguide == "No Guide" then InterfaceOptionsFrame_OpenToCategory(TourGuide.guidespanel)
	else
		if btn == "RightButton" then
			if TourGuide.objectiveframe:IsVisible() then
				HideUIPanel(TourGuide.objectiveframe)
			else
				local quad, vhalf, hhalf = GetQuadrant(self)
				local anchpoint = (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
				TourGuide.objectiveframe:ClearAllPoints()
				TourGuide.objectiveframe:SetPoint(quad, self, anchpoint)
				ShowUIPanel(TourGuide.objectiveframe)
			end
		else
			if IsShiftKeyDown() then TourGuide:SetTurnedIn()
			else
				local i = TourGuide:GetQuestLogIndexByQID(TourGuide:GetObjectiveTag("QID", TourGuide.current))
				if i then SelectQuestLogEntry(i) end
				ShowUIPanel(QuestLogFrame)
			end
		end
	end
end


function dataobj.OnLeave() GameTooltip:Hide() end
function dataobj.OnEnter(self)
	local tip = TourGuide:GetObjectiveTag("N")
	if not tip then return end

 	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	local quad, vhalf, hhalf = GetQuadrant(self)
	local anchpoint = (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
	TourGuide:Debug(11, "Setting tooltip anchor", anchpoint, quad, hhalf, vhalf)
	GameTooltip:SetPoint(quad, self, anchpoint)
	GameTooltip:SetText(tip, nil, nil, nil, nil, true)
end
