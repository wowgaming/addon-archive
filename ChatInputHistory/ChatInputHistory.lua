local frame = CreateFrame("Frame")

local function EnableArrowHistory()
    -- Enable plain Up/Down arrow key history on the primary chat edit box
    if ChatFrame1EditBox then
        ChatFrame1EditBox:SetAltArrowKeyMode(false)
    end
end

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, ...)
    EnableArrowHistory()
end)
