
local F = CreateFrame("Frame")
F:Hide()
F:SetScript("OnEvent", function(self, event, msg)
	local action, quest = TourGuide:GetObjectiveInfo()

	if action == "TURNIN" then
		local _, _, text = msg:find("^(.-) completed%.$")

		if type(text) == 'string' and quest == text then
			TourGuide:CompleteQuest(text)
			TourGuide:UpdateStatusFrame()
		end
	end
end)

F:RegisterEvent("CHAT_MSG_SYSTEM")
