local frame = CreateFrame("frame")
frame.timer = 10
frame:Hide()

frame:RegisterEvent("PLAYER_ENTERING_COMBAT")
frame:RegisterEvent("PLAYER_LEAVING_COMBAT")

frame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_COMBAT" then
		self.timer = 10
		self:Show()
	elseif event == "PLAYER_LEAVING_COMBAT" then
		self:Hide()
	end
end)

frame:SetScript("OnUpdate", function (self, elapsed)
	timer = timer - elapsed
	if UnitDebuff("target", "Serpent Sting", true) then

	end
end)