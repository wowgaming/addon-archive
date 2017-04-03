local TITAN_AUTOHIDE_ID = "AutoHide";
local TITAN_AUXAUTOHIDE_ID = "AuxAutoHide";
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)

function TitanPanelAutoHideButton_OnLoad(self)
	self.registry = {
		id = TITAN_AUTOHIDE_ID,
--		builtIn = 1,
		category = "Built-ins",
		version = TITAN_VERSION,
		menuText = L["TITAN_AUTOHIDE_MENU_TEXT"],
		tooltipTitle = L["TITAN_AUTOHIDE_TOOLTIP"],
		savedVariables = {
			DisplayOnRightSide = 1,
			ForceBar = "Bar",
		}
	};
end

function TitanPanelAutoHideButton_OnShow()
	TitanPanelAutoHideButton_SetIcon();
end

function TitanPanelAutoHideButton_OnClick(self, button)
	if (button == "LeftButton") then
		TitanPanelBarButton_ToggleAutoHide();
	end
end

function TitanPanelAutoHideButton_SetIcon()
	local icon = TitanPanelAutoHideButtonIcon;
	if (TitanPanelGetVar("AutoHide")) then
		icon:SetTexture("Interface\\AddOns\\Titan\\Artwork\\TitanPanelPushpinOut");
	else
		icon:SetTexture("Interface\\AddOns\\Titan\\Artwork\\TitanPanelPushpinIn");
	end	
end

function TitanPanelRightClickMenu_PrepareAutoHideMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_AUTOHIDE_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_AUTOHIDE_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end


function TitanPanelAuxAutoHideButton_OnLoad(self)
	self.registry = {
		id = TITAN_AUXAUTOHIDE_ID,
--		builtIn = 1,
		category = "Built-ins",
		version = TITAN_VERSION,
		menuText = L["TITAN_AUTOHIDE_MENU_TEXT"].." Aux",
		tooltipTitle = L["TITAN_AUTOHIDE_TOOLTIP"],
		savedVariables = {
			DisplayOnRightSide = 1,
			ForceBar = "AuxBar",
		}
	};
end

function TitanPanelAuxAutoHideButton_OnShow()
	TitanPanelAuxAutoHideButton_SetIcon();
end

function TitanPanelAuxAutoHideButton_OnClick(self, button)
	if (button == "LeftButton") then
		TitanPanelBarButton_ToggleAuxAutoHide();
	end
end

function TitanPanelAuxAutoHideButton_SetIcon()
	local icon = TitanPanelAuxAutoHideButtonIcon;
	if (TitanPanelGetVar("AuxAutoHide")) then
		icon:SetTexture("Interface\\AddOns\\Titan\\Artwork\\TitanPanelPushpinOut");
	else
		icon:SetTexture("Interface\\AddOns\\Titan\\Artwork\\TitanPanelPushpinIn");
	end	
end

function TitanPanelRightClickMenu_PrepareAuxAutoHideMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_AUXAUTOHIDE_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_AUXAUTOHIDE_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end