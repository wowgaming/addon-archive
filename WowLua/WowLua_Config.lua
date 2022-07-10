local addon = ...

local L = WowLuaLocals
local frame = CreateFrame("Frame", addon .. "ConfigFrame", InterfaceOptionsFramePanelContainer)
frame.name = addon
frame:Hide()
frame:SetScript("OnShow", function(frame)
    local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(L.CONFIG_TITLE:format(addon))

    local subtitle = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    subtitle:SetHeight(35)
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    subtitle:SetPoint("RIGHT", frame, -32, 0)
    subtitle:SetNonSpaceWrap(true)
    subtitle:SetJustifyH("LEFT")
    subtitle:SetJustifyV("TOP")
    subtitle:SetText(L.CONFIG_SUBTITLE)

    local slider = CreateFrame("Slider", addon .. "ConfigFontSlider", frame, "OptionsSliderTemplate")
    slider:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -15)
    slider:SetMinMaxValues(5, 30)
    slider:SetValueStep(1)
    slider.text = _G[slider:GetName() .. "Text"]
    slider.low = _G[slider:GetName() .. "Low"]
    slider.high = _G[slider:GetName() .. "High"]
   
    slider.text:SetText(L.CONFIG_LABEL_FONTSIZE)
    slider.low:SetText("Small")
    slider.high:SetText("Large")
    slider.tooltipText = L.CONFIG_FONTSIZE_TOOLTIP

    slider:SetScript("OnValueChanged", function(self, value)
        local file, height, flags = WowLuaMonoFont:GetFont()
        WowLuaMonoFont:SetFont(file, value, flags)
        WowLua_DB.fontSize = value
    end)

    local Refresh;
    function Refresh()
        if not frame:IsVisible() then return end
        local file, height, flags = WowLuaMonoFont:GetFont()
        slider:SetValue(height)
    end

    frame:SetScript("OnShow", Refresh) 
    Refresh()
end)

InterfaceOptions_AddCategory(frame)
