
local TourGuide = TourGuide
local L = TourGuide.Locale


function TourGuide:IsQuestAcceptable(name)
	for i,v in pairs(self.actions) do
		if (v == "ACCEPT" or v == "COMPLETE") and self.quests[i]:gsub(L.PART_GSUB, "") == name then return true end
	end
end


local notlisted = CreateFrame("Frame", nil, QuestFrame)
notlisted:SetFrameStrata("DIALOG")
notlisted:SetWidth(32)
notlisted:SetHeight(32)
notlisted:SetPoint("TOPLEFT", 70, -45)
notlisted:Hide()

notlisted:RegisterEvent("QUEST_DETAIL")
notlisted:RegisterEvent("QUEST_COMPLETE")
notlisted:RegisterEvent("QUEST_FINISHED")
notlisted:SetScript("OnEvent", function(self, event)
	if event ~= "QUEST_DETAIL" then return self:Hide() end
	local quest = GetTitleText()
	if quest and TourGuide:IsQuestAcceptable(quest) then self:Hide()
	else self:Show() end
end)


local nltex = notlisted:CreateTexture()
nltex:SetAllPoints()
nltex:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

local text = notlisted:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetPoint("TOPLEFT", notlisted, "TOPRIGHT")
text:SetPoint("BOTTOMLEFT", notlisted, "BOTTOMRIGHT")
text:SetPoint("RIGHT", notlisted, "RIGHT", 200, 0)
text:SetText(L["|cffff4500This quest is not listed in your current guide"])
