
local function CreateBasePanel( Name, Title )  
	local panel = PanelHelpers:CreatePanelFrame( Name.."_InterfaceOptionsPanel", Title )
	panel:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = 2, right = 2, top = 2, bottom = 2 },})
	panel:SetBackdropColor(0.05, 0.05, 0.05, .7)

	--[[
	panel.TankModeButton = CreateFrame("Button", Name.."_TankModeButton", panel, "UIPanelButtonTemplate2")
	panel.TankModeButton:SetPoint("TOPLEFT", 16, -52)
	panel.TankModeButton:SetText("Configure Tank Mode")
	panel.TankModeButton:SetWidth(280)
	--panel.TankModeButton:SetScript("OnClick", function() InterfaceOptionsFrame_OpenToCategory("Tidy Plates: Neon/Tank") end)
	
	panel.DPSModeButton = CreateFrame("Button", Name.."_DPSModeButton", panel, "UIPanelButtonTemplate2")
	panel.DPSModeButton:SetPoint("TOPLEFT", panel.TankModeButton, "BOTTOMLEFT", 0, -16 )
	panel.DPSModeButton:SetText("Configure DPS Mode")
	panel.DPSModeButton:SetWidth(280)
	--panel.DPSModeButton:SetScript("OnClick", function() InterfaceOptionsFrame_OpenToCategory("Tidy Plates: Neon/DPS") end)
	--]]
	
	panel:SetScript("OnEvent", function() InterfaceOptions_AddCategory(panel) end )
	panel:RegisterEvent("PLAYER_LOGIN")

	return panel
end

local BasePanel = CreateBasePanel( "TidyPlatesProfiles", "Tidy Plates: Profiles", nil ) 

