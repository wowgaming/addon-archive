-- Globals
TITAN_PANEL_SELECTED = "Bar";
TITAN_PANEL_BUTTONS_INIT_FLAG = nil;
TITAN_PANEL_MOVE_ADDON = nil;
TITAN_PANEL_DROPOFF_ADDON = nil;
TITAN_PANEL_MOVING = 0;

-- Locals
local TITAN_PANEL_ICON_SPACING = 4;
local TITAN_PANEL_FROM_TOP = -25;
local TITAN_PANEL_FROM_BOTTOM = 25;
local TITAN_PANEL_FROM_BOTTOM_MAIN = 1;
local TITAN_PANEL_FROM_TOP_MAIN = 1;
local TITAN_PANEL_BUTTONS_ALIGN_LEFT = 1;
local TITAN_PANEL_BUTTONS_ALIGN_CENTER = 2;
local TITAN_PANEL_BARS_SINGLE = 1;
local TITAN_PANEL_BARS_DOUBLE = 2;

local _G = getfenv(0);
local InCombatLockdown	= _G.InCombatLockdown;
local TitanKillAutoHidetimer = false;
local TitanSkinToRemove = "None";
local TitanSkinName, TitanSkinPath = "", "";
local newButtons = {};
local newLocations = {};
local IsTitanPanelReset = nil;
local numOfTextures = 0;
local numOfTexturesHider = 0;

-- Library references
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local AceTimer = LibStub("AceTimer-3.0")
local media = LibStub("LibSharedMedia-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local Dewdrop = nil
if AceLibrary and AceLibrary:HasInstance("Dewdrop-2.0") then Dewdrop = AceLibrary("Dewdrop-2.0") end


-- Titan local helper funcs
local function TitanPanel_GetTitle()
	return GetAddOnMetadata("Titan", "Title") or L["TITAN_NA"];
end

local function TitanPanel_GetAuthor()
	return GetAddOnMetadata("Titan", "Author") or L["TITAN_NA"];
end

local function TitanPanel_GetCredits()
	return GetAddOnMetadata("Titan", "X-Credits") or L["TITAN_NA"];
end

local function TitanPanel_GetCategory()
	return GetAddOnMetadata("Titan", "X-Category") or L["TITAN_NA"];
end

local function TitanPanel_GetEmail()
	return GetAddOnMetadata("Titan", "X-Email") or L["TITAN_NA"];
end

local function TitanPanel_GetWebsite()
	return GetAddOnMetadata("Titan", "X-Website") or L["TITAN_NA"];
end

local function TitanPanel_GetVersion()
	return tostring(GetAddOnMetadata("Titan", "Version")) or L["TITAN_NA"];
end

local function TitanPanel_GetLicense()
	return GetAddOnMetadata("Titan", "X-License") or L["TITAN_NA"];
end

local function TitanAdjustBottomFrames()
	TitanMovableFrame_CheckFrames(2);
	TitanMovableFrame_MoveFrames(2, TitanPanelGetVar("AuxScreenAdjust"));
	TitanMovableFrame_AdjustBlizzardFrames();
end

local function TitanAdjustPanelScale(scale)		
	Titan_AdjustScale()		

	-- Adjust frame positions								
	TitanMovableFrame_CheckFrames(1);
	TitanMovableFrame_MoveFrames(1, TitanPanelGetVar("ScreenAdjust"));
	TitanMovableFrame_CheckFrames(2);
	TitanMovableFrame_MoveFrames(2, TitanPanelGetVar("AuxScreenAdjust"));
	TitanMovableFrame_AdjustBlizzardFrames();
	AceTimer.CancelAllTimers("TitanPanelScale");
end

local function TitanSetPanelFont(fontname, fontsize)
	-- a couple of arg checks to avoid unpleasant things...
	if not fontname then fontname = "Friz Quadrata TT" end
	if not fontsize then fontsize = 10 end
	local index,id;
	local newfont = media:Fetch("font", fontname)
	for index, id in pairs(TitanPluginsIndex) do
		local button = TitanUtils_GetButton(id);
		local buttonText = _G[button:GetName().."Text"];
			if buttonText then
				buttonText:SetFont(newfont, fontsize);
			end
			-- account for plugins with child buttons
			local childbuttons = {button:GetChildren()};
			for _, child in ipairs(childbuttons) do
				if child then
					local childbuttonText = _G[child:GetName().."Text"];
						if childbuttonText then
							childbuttonText:SetFont(newfont, fontsize);
						end
				end
			end
	end
	TitanPanel_RefreshPanelButtons();
end

local function TitanAdjustDisplayOnTop()
	TitanPanelBarButton_TogglePosition()
	
	-- because we can not disable buttons via ACE
	-- check if both bars were requested and cleanup
	if TitanPanelGetVar("BothBars") then
		TitanPanelBarButton_ToggleBarsShown()
	end
end

-- Titan AceConfigDialog-3.0 init tables
-- in-line creation of the tables needed by Ace for the Blizzard options
local optionsControl = {
	name = "Titan Panel",
	type = "group",
	args = {
		confgendesc = {
			order = 1,
			type = "description",
			name = L["TITAN_PANEL_CONFIG_MAIN_LABEL"].."\n\n",
			cmdHidden = true
		},
		confinfodesc = {
			name = "About",
			type = "group", inline = true,
			args = {
				confversiondesc = {
				order = 1,
				type = "description",			
				name = "|cffffd700".."Version"..": ".._G["GREEN_FONT_COLOR_CODE"]..TitanPanel_GetVersion(),
				cmdHidden = true
				},
				confauthordesc = {
					order = 2,
					type = "description",
					name = "|cffffd700".."Author"..": ".."|cffff8c00"..TitanPanel_GetAuthor(),
					cmdHidden = true
				},
				confcreditsdesc = {
					order = 3,
					type = "description",
					name = "|cffffd700".."Credits"..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..TitanPanel_GetCredits(),
					cmdHidden = true
				},
				confcatdesc = {
					order = 4,
					type = "description",
					name = "|cffffd700".."Category"..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..TitanPanel_GetCategory(),
					cmdHidden = true
				},
				confemaildesc = {
					order = 5,
					type = "description",
					name = "|cffffd700".."Email"..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..TitanPanel_GetEmail(),
					cmdHidden = true
				},
				confwebsitedesc = {
					order = 6,
					type = "description",
					name = "|cffffd700".."Website"..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..TitanPanel_GetWebsite(),
					cmdHidden = true
				},
				conflicensedesc = {
					order = 7,
					type = "description",
					name = "|cffffd700".."License"..": ".._G["HIGHLIGHT_FONT_COLOR_CODE"]..TitanPanel_GetLicense(),
					cmdHidden = true
				},
			}
		}
	}
}

local optionsTrans = {
name = "Titan "..L["TITAN_TRANS_MENU_TEXT_SHORT"],
	type = "group",
	args = {
		confdesc = {
				order = 1,
				type = "description",
				name = L["TITAN_TRANS_MENU_DESC"].."\n",
				cmdHidden = true
			},
		bartrans = {
			name = L["TITAN_TRANS_MAIN_CONTROL_TITLE"],
			desc = L["TITAN_TRANS_MAIN_BAR_DESC"],
			order = 2, type = "range", width = "full",
			min = 0, max = 1, step = 0.01,
			get = function() return TitanPanelGetVar("Transparency") end,
			set = function(_, a)
				TitanPanelBarButton:SetAlpha(a);
				TitanPanelSetVar("Transparency", a);
			end,
		},
		auxbartrans = {
			name = L["TITAN_TRANS_AUX_CONTROL_TITLE"],
			desc = L["TITAN_TRANS_AUX_BAR_DESC"],
			order = 3, type = "range", width = "full",
			min = 0, max = 1, step = 0.01,
			get = function() return TitanPanelGetVar("AuxTransparency") end,
			set = function(_, a)
			  TitanPanelAuxBarButton:SetAlpha(a);
				TitanPanelSetVar("AuxTransparency", a);
			end,
		},
		tooltiptrans = {
			name = L["TITAN_TRANS_CONTROL_TITLE_TOOLTIP"],
			desc = L["TITAN_TRANS_TOOLTIP_DESC"],
			order = 3, type = "range", width = "full",
			min = 0, max = 1, step = 0.01,
			get = function() return TitanPanelGetVar("TooltipTrans") end,
			set = function(_, a)
				TitanPanelSetVar("TooltipTrans", a);
			end,
		},
   }
 }
 
local optionsSkins = {
name = "Titan "..L["TITAN_PANEL_MENU_TEXTURE_SETTINGS"],
	type = "group",
	args = {
	confdesc = {
		order = 1,
		type = "description",
		name = L["TITAN_SKINS_MAIN_DESC"].."\n",
		cmdHidden = true
		},
		setskinhdear = {
		order = 2,
		type = "header",
		name = L["TITAN_SKINS_SET_HEADER"],
		},
		setskinlist = {
			order = 3, type = "select",
			name = L["TITAN_SKINS_LIST_TITLE"],
			desc = L["TITAN_SKINS_SET_DESC"],
			get = function() return TitanPanelGetVar("TexturePath") end,
			set = function(_,v)
				TitanPanel_SetCustomTexture(v)
				if TitanSkinToRemove == TitanPanelGetVar("TexturePath") then
					TitanSkinToRemove = "None"
				end
			end,
			values = function()
			local Skinlist = {}
			local v;
				for _,v in pairs (TitanSkins) do
					if v.path ~= TitanPanelGetVar("TexturePath") then
						Skinlist[v.path] = "|cff19ff19"..v.name.."|r"
					else
						Skinlist[v.path] = "|cffffff9a"..v.name.."|r"
					end
				end
				table.sort(Skinlist, function(a, b)
					return string.lower(TitanSkins[a].name) < string.lower(TitanSkins[b].name)
				end)
					return Skinlist
			end,
		},
		defaultskins = {
		order = 4,
		name = L["TITAN_SKINS_RESET_DEFAULTS_TITLE"], type = "execute",
		desc = L["TITAN_SKINS_RESET_DEFAULTS_DESC"],
		func = function()
		TitanSkins = {};
		TitanSkins = {
				{ name = "Titan Default", path = "Interface\\AddOns\\Titan\\Artwork\\"},
				{ name = "Christmas", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Christmas Skin\\"},
				{ name = "Charcoal Metal", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Charcoal Metal\\"},
				{ name = "Crusader", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Crusader Skin\\"},
				{ name = "Cursed Orange", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Cursed Orange Skin\\"},
				{ name = "Dark Wood", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Dark Wood Skin\\"},
				{ name = "Deep Cave", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Deep Cave Skin\\"},
				{ name = "Elfwood", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Elfwood Skin\\"},
				{ name = "Engineer", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Engineer Skin\\"},
				{ name = "Frozen Metal", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Frozen Metal Skin\\"},
				{ name = "Graphic", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Graphic Skin\\"},
				{ name = "Graveyard", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Graveyard Skin\\"},
				{ name = "Hidden Leaf", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Hidden Leaf Skin\\"},
				{ name = "Holy Warrior", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Holy Warrior Skin\\"},
				{ name = "Nightlife", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Nightlife Skin\\"},
				{ name = "Orgrimmar", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Orgrimmar Skin\\"},
				{ name = "Plate", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Plate Skin\\"},
				{ name = "Tribal", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Tribal Skin\\"},
				{ name = "X-Perl", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\X-Perl\\"},
				};
		end,
		},
		nulloption1 = {
			order = 5,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		addskinheader = {
		order = 6,
		type = "header",
		name = L["TITAN_SKINS_NEW_HEADER"],
		},
		newskinname = {
		order = 7,
		name = L["TITAN_SKINS_NAME_TITLE"],
		desc = L["TITAN_SKINS_NAME_DESC"],
		type = "input", width = "full",
		get = function() return TitanSkinName end,
			set = function(_,v) TitanSkinName = v end,
		},
		newskinnamedesc = {
		order = 8,
		type = "description",
		name = L["TITAN_SKINS_NAME_EXAMPLE"].."\n",
		cmdHidden = true
		},
		newskinpath = {
		order = 9,
		name = L["TITAN_SKINS_PATH_TITLE"],
		desc = L["TITAN_SKINS_PATH_DESC"],
		type = "input", width = "full",
		get = function() return TitanSkinPath end,
			set = function(_,v) TitanSkinPath = v end,
		},
		newskinpathdesc = {
		order = 10,
		type = "description",
		name = L["TITAN_SKINS_PATH_EXAMPLE"].."\n",
		cmdHidden = true
		},
		addnewskin = {
		order = 11,
		name = L["TITAN_SKINS_ADD_HEADER"], type = "execute",
		desc = L["TITAN_SKINS_ADD_DESC"],
		func = function()
			if TitanSkinName ~= "" and TitanSkinPath ~= "" then				
				TitanPanel_AddNewSkin(TitanSkinName, TitanSkinPath)
				TitanSkinName = ""
				TitanSkinPath = ""
			end
		end,
		},
		nulloption2 = {
		order = 12,
		type = "description",
		name = "   ",
		cmdHidden = true
		},
		notes = {
		order = 13,
		type = "description",
		name = L["TITAN_SKINS_NOTES"],
		cmdHidden = true
		},
		nulloption3 = {
		order = 14,
		type = "description",
		name = "   ",
		cmdHidden = true
		},
		removeskinheader = {
		order = 15,
		type = "header",
		name = L["TITAN_SKINS_REMOVE_HEADER"],
		},
		removeskinlist = {
			order = 16, type = "select",
			name = L["TITAN_SKINS_LIST_TITLE"],
			desc = L["TITAN_SKINS_REMOVE_DESC"],
			get = function() return TitanSkinToRemove end,
			set = function(_,v)
				TitanSkinToRemove = v
			end,
			values = function()
			local Skinlist = {}
			local v;
				for _,v in pairs (TitanSkins) do
				-- You may not remove the currently used skin or the default one
					if v.path ~= TitanPanelGetVar("TexturePath") and v.path ~= "Interface\\AddOns\\Titan\\Artwork\\" then
						Skinlist[v.path] = "|cff19ff19"..v.name.."|r"
					end
					if v.path == TitanSkinToRemove then
						Skinlist[v.path] = "|cffffff9a"..v.name.."|r"
					end
				end
				if TitanSkinToRemove ~= "None" then
					Skinlist["None"] = "|cff19ff19"..L["TITAN_NONE"].."|r"
				else
					Skinlist["None"] = "|cffffff9a"..L["TITAN_NONE"].."|r"
				end
				table.sort(Skinlist, function(a, b)
					return string.lower(TitanSkins[a].name) < string.lower(TitanSkins[b].name)
				end)
					return Skinlist
			end,
		},
		removeskin = {
			order = 17, type = "execute",
			name = L["TITAN_SKINS_REMOVE_BUTTON"],
			desc = L["TITAN_SKINS_REMOVE_BUTTON_DESC"],
			func = function()
			if TitanSkinToRemove == "None" then return end
			local k, v;
				for k, v in pairs (TitanSkins) do
					if v.path == TitanSkinToRemove then
						table.remove(TitanSkins, k)
						TitanSkinToRemove = "None"
						break
					end
				end
			end,
		},
		nulloption4 = {
		order = 18,
		type = "description",
		name = "   ",
		cmdHidden = true
		},		
	}
}
 
local optionsUIScale = {
name = "Titan "..L["TITAN_UISCALE_MENU_TEXT"],
	type = "group",
	args = {
		confdesc = {
				order = 1,
				type = "description",
				name = L["TITAN_UISCALE_MENU_DESC"].."\n",
				cmdHidden = true
			},
		uiscale = {
			name = L["TITAN_UISCALE_CONTROL_TITLE_UI"],
			desc = L["TITAN_UISCALE_SLIDER_DESC"],
			order = 2, type = "range", width = "full",
			min = 0.64, max = 1, step = 0.01,		
			get = function() return UIParent:GetScale() end,
			set = function(_, a)
				SetCVar("useUiScale", 1);
				SetCVar("uiScale", a, "uiScale");								
			end,
		},
		panelscale = {
			name = L["TITAN_UISCALE_CONTROL_TITLE_PANEL"],
			desc = L["TITAN_UISCALE_PANEL_SLIDER_DESC"],
			order = 3, type = "range", width = "full",
			min = 0.75, max = 1.25, step = 0.01,
			get = function() return TitanPanelGetVar("Scale") end,
			set = function(_, a)
				if not InCombatLockdown() then 
				TitanPanelSetVar("Scale", a);									
					AceTimer.CancelAllTimers("TitanPanelScale");
					TitanUIScaleTimer = AceTimer.ScheduleTimer("TitanPanelScale", TitanAdjustPanelScale, 1, a);
				end
			end,
			disabled = function()
				if InCombatLockdown() then
					return true
				end
				return false
			end,
		},
		buttonspacing = {
			name = L["TITAN_UISCALE_CONTROL_TITLE_BUTTON"],
			desc = L["TITAN_UISCALE_BUTTON_SLIDER_DESC"],
			order = 4, type = "range", width = "full",
			min = 5, max = 80, step = 1,
			get = function() return TitanPanelGetVar("ButtonSpacing") end,
			set = function(_, a)
				TitanPanelSetVar("ButtonSpacing", a);
				TitanPanel_InitPanelButtons();
			end,
		},
		tooltipfont = {
			name = L["TITAN_UISCALE_CONTROL_TOOLTIP_TOOLTIPFONT"],
			desc = L["TITAN_UISCALE_TOOLTIP_SLIDER_DESC"],
			order = 5, type = "range", width = "full",
			min = 0.5, max = 1.3, step = 0.01,
			get = function() return TitanPanelGetVar("TooltipFont") end,
			set = function(_, a)
				TitanPanelSetVar("TooltipFont", a);
			end,
		},
		tooltipfontdisable = {
			name = L["TITAN_UISCALE_TOOLTIP_DISABLE_TEXT"],
			desc = L["TITAN_UISCALE_DISABLE_TOOLTIP_DESC"],
			order = 6, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("DisableTooltipFont") end,
			set = function()
				TitanPanelToggleVar("DisableTooltipFont");
			end,
		},
		fontselection = {
			name = L["TITAN_PANEL_MENU_LSM_FONTS"],
			desc = L["TITAN_PANEL_MENU_LSM_FONTS_DESC"],
			order = 7, type = "select",
			dialogControl = "LSM30_Font",
			get = function()
				return TitanPanelGetVar("FontName")
			end,
			set = function(_, v)
				TitanPanelSetVar("FontName", v)
				TitanSetPanelFont(v, TitanPanelGetVar("FontSize"))
			end,
			values = AceGUIWidgetLSMlists.font,
		},
		fontsize = {
			name = L["TITAN_PANEL_MENU_FONT_SIZE"],
			desc = L["TITAN_PANEL_MENU_FONT_SIZE_DESC"],
			order = 8, type = "range",
			min = 7, max = 15, step = 1,
			get = function() return TitanPanelGetVar("FontSize") end,
			set = function(_, v)
				TitanPanelSetVar("FontSize", v);
				TitanSetPanelFont(TitanPanelGetVar("FontName"), v)
			end,
		},
		panelstrata = {
			name = L["TITAN_PANEL_MENU_FRAME_STRATA"],
			desc = L["TITAN_PANEL_MENU_FRAME_STRATA_DESC"],
			order = 9, type = "select",
			get = function()								
				return TitanPanelGetVar("FrameStrata")
			end,
			set = function(_, v)
				TitanPanelSetVar("FrameStrata", v)
				TitanVariables_SetPanelStrata(v)
			end,
			values = {
			["BACKGROUND"] = "BACKGROUND",
			["LOW"] = "LOW",
			["MEDIUM"] = "MEDIUM",
			["HIGH"] = "HIGH",
			["DIALOG"] = "DIALOG",
			["FULLSCREEN"] = "FULLSCREEN",
			},
		},
   }
 }

local optionsBars = {
name = "Titan "..L["TITAN_PANEL_MENU_OPTIONS_BARS"],
	type = "group",
	args = {
		confdesc1 = {
			order = 100,
			type = "header",
			name = L["TITAN_TRANS_MAIN_CONTROL_TITLE"],
		},
--[
		optiontop = {
			name = L["TITAN_PANEL_MENU_DISPLAY_ONTOP"],
			desc = L["TITAN_PANEL_MENU_DISPLAY_ONTOP"],
			order = 101, type = "toggle", width = "full",
			get = function() return (TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP) end,
--			set = function() TitanPanelBarButton_TogglePosition(); end,
			set = function() TitanAdjustDisplayOnTop(); end,
		},
--]]
		optiontopdouble = {
			name = L["TITAN_PANEL_MENU_DOUBLE_BAR"],
			desc = L["TITAN_PANEL_MENU_DOUBLE_BAR"],
			order = 102, type = "toggle", width = "full",
			get = function() return (TitanPanelGetVar("DoubleBar") == TITAN_PANEL_BARS_DOUBLE) end,
			set = function() TitanPanelBarButton_ToggleDoubleBar(); end,
		},
		optiontophide = {
			name = L["TITAN_PANEL_MENU_AUTOHIDE"],
			desc = L["TITAN_PANEL_MENU_AUTOHIDE"],
			order = 103, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("AutoHide") end,
			set = function() TitanPanelBarButton_ToggleAutoHide(); end,
		},
		optiontopcenter = {
			name = L["TITAN_PANEL_MENU_CENTER_TEXT"],
			desc = L["TITAN_PANEL_MENU_CENTER_TEXT"],
			order = 104, type = "toggle", width = "full",
			get = function() return (TitanPanelGetVar("ButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER) end,
			set = function() TitanPanelBarButton_ToggleAlign(); end,
		},
		optiontopscreen = {
			name = L["TITAN_PANEL_MENU_DISABLE_PUSH"],
			desc = L["TITAN_PANEL_MENU_DISABLE_PUSH"],
			order = 105, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("ScreenAdjust") end,
			set = function() TitanPanelBarButton_ToggleScreenAdjust(); end,
		},
		confdesc2 = {
				order = 200,
				type = "header",
				name = L["TITAN_TRANS_AUX_CONTROL_TITLE"],
		},
		optionbottom = {
			name = L["TITAN_PANEL_MENU_DISPLAY_BOTH"],
			desc = L["TITAN_PANEL_MENU_DISPLAY_BOTH"],
			order = 201, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("BothBars") end,
			set = function() TitanPanelBarButton_ToggleBarsShown(); end,
		},
		optionbottomdouble = {
			name = L["TITAN_PANEL_MENU_DOUBLE_BAR"],
			desc = L["TITAN_PANEL_MENU_DOUBLE_BAR"],
			order = 202, type = "toggle", width = "full",
			get = function() return (TitanPanelGetVar("AuxDoubleBar") == TITAN_PANEL_BARS_DOUBLE) end,
			set = function() TitanPanelBarButton_ToggleAuxDoubleBar(); end,
		},
		optionbottomhide = {
			name = L["TITAN_PANEL_MENU_AUTOHIDE"],
			desc = L["TITAN_PANEL_MENU_AUTOHIDE"],
			order = 203, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("AuxAutoHide") end,
			set = function() TitanPanelBarButton_ToggleAuxAutoHide(); end,
		},
		optionbottomcenter = {
			name = L["TITAN_PANEL_MENU_CENTER_TEXT"],
			desc = L["TITAN_PANEL_MENU_CENTER_TEXT"],
			order = 204, type = "toggle", width = "full",
			get = function() return (TitanPanelGetVar("AuxButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER) end,
			set = function() TitanPanelBarButton_ToggleAuxAlign(); end,
		},
		optionbottomscreen = {
			name = L["TITAN_PANEL_MENU_DISABLE_PUSH"],
			desc = L["TITAN_PANEL_MENU_DISABLE_PUSH"],
			order = 205, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("AuxScreenAdjust") end,
			set = function() TitanPanelBarButton_ToggleAuxScreenAdjust(); end,
		},
		confdesc3 = {
			order = 300,
			type = "header",
			name = L["TITAN_PANEL_MENU_OPTIONS"],
		},
		optionminimap = {
			name = L["TITAN_PANEL_MENU_DISABLE_MINIMAP_PUSH"],
			desc = L["TITAN_PANEL_MENU_DISABLE_MINIMAP_PUSH"],
			order = 302, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("MinimapAdjust") end,
			set = function() TitanPanelToggleVar("MinimapAdjust"); end,
		},
		optionlog = {
			name = L["TITAN_PANEL_MENU_DISABLE_LOGS"],
			desc = L["TITAN_PANEL_MENU_DISABLE_LOGS"],
			order = 303, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("LogAdjust") end,
			set = function() TitanPanelToggleVar("LogAdjust"); end,
		},
		optionbags = {
			name = L["TITAN_PANEL_MENU_DISABLE_BAGS"],
			desc = L["TITAN_PANEL_MENU_DISABLE_BAGS"],
			order = 304, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("BagAdjust") end,
			set = function() TitanPanelToggleVar("BagAdjust"); end,
		},
		optiontickets = {
			name = L["TITAN_PANEL_MENU_DISABLE_TICKET"].." ".._G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_RELOADUI"],
			desc = L["TITAN_PANEL_MENU_DISABLE_TICKET"].." ".._G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_RELOADUI"],
			order = 305, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("TicketAdjust"); end,
			set = function() TitanPanel_TicketReload() end,
		},
	}
 }

local optionsFrames = {
name = "Titan "..L["TITAN_PANEL_MENU_OPTIONS"],
	type = "group",
	args = {
		confdesc2 = {
			order = 200,
			type = "header",
			name = L["TITAN_PANEL_MENU_OPTIONS_TOOLTIPS"],
		},
		optiontooltip = {
			name = L["TITAN_PANEL_MENU_TOOLTIPS_SHOWN"],
--			desc = L["TITAN_PANEL_MENU_TOOLTIPS_SHOWN"],
			order = 201, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("ToolTipsShown") end,
			set = function() TitanPanelToggleVar("ToolTipsShown"); end,
		},
		optiontooltipcombat = {
			name = L["TITAN_PANEL_MENU_TOOLTIPS_SHOWN_IN_COMBAT"],
--			desc = L["TITAN_PANEL_MENU_TOOLTIPS_SHOWN_IN_COMBAT"],
			order = 201, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("HideTipsInCombat") end,
			set = function() TitanPanelToggleVar("HideTipsInCombat"); end,
		},
		confdesc = {
			order = 300,
			type = "header",
			name = L["TITAN_PANEL_MENU_OPTIONS_FRAMES"],
		},
		optionlock = {
			name = L["TITAN_PANEL_MENU_LOCK_BUTTONS"],
			desc = L["TITAN_PANEL_MENU_LOCK_BUTTONS"],
			order = 301, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("LockButtons") end,
			set = function() TitanPanelToggleVar("LockButtons") end,
		},
		optionversions = {
			name = L["TITAN_PANEL_MENU_VERSION_SHOWN"],
--			desc = L["TITAN_PANEL_MENU_VERSION_SHOWN"],
			order = 302, type = "toggle", width = "full",
			get = function() return TitanPanelGetVar("VersionShown") end,
			set = function() TitanPanelToggleVar("VersionShown") end,
		},
		space_400_1 =
			{
				order = 400,
				type = "description",
				name = "  ",
				cmdHidden = true,
			},
		optionlaunchers = {
			name = L["TITAN_PANEL_MENU_LDB_FORCE_LAUNCHER"],
			order = 401, type = "execute", width = "full",
			func = function() TitanPanelBarButton_ForceLDBLaunchersRight() end,
		},
		space_500_1 =
			{
				order = 500,
				type = "description",
				name = "  ",
				cmdHidden = true,
			},
		pluginreset = {
			name = L["TITAN_PANEL_MENU_PLUGIN_RESET"],
			desc = L["TITAN_PANEL_MENU_PLUGIN_RESET_DESC"],
			order = 501, type = "execute", width = "full",
			func = function() TitanPanel_InitPanelButtons() end,
		},
		space_600_1 =
			{
				order = 600,
				type = "description",
				name = "  ",
				cmdHidden = true,
			},
		optionreset = {
			name = L["TITAN_PANEL_MENU_RESET"].." ".._G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_RELOADUI"],
--			desc = L["TITAN_PANEL_MENU_RESET"].." ".._G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_RELOADUI"],
			order = 601, type = "execute", width = "full",
			func = function() TitanPanel_ResetToDefault() end,
		}
		
		
	}
 }

TXT_XYZ =  optionsAddons
TXT_XYZ1 =  {}
TXT_XYZ2 =  {}
TXT_XYZ_info =  {}
TXT_XYZ_arg1 =  {}
local function TXT_XYZ_info_copy(info)
	TXT_XYZ_info = {}
	TXT_XYZ_info.info1 = (info[1] or "nyl")
	TXT_XYZ_info.info2 = (info[2] or "nyl")
	TXT_XYZ_info.info3 = (info[3] or "nyl")
	TXT_XYZ_info.info_ = (info[#info] or "nyl")
	TXT_XYZ_info.arg = (info.arg or "nyl")
end

local optionsAddonAttempts = {
	name = "Titan ".."Attempts", --L["TITAN_PANEL_MENU_OPTIONS_BARS"],
	type = "group",
	args = {}
 }
function TitanUpdateAddonAttempts()
	local args = optionsAddonAttempts.args
	local plug_in = nil
	local attempts = ""
    
	wipe(args)

	attempts = "The plugins below requested to be registered with Titan.".."\n\n"
		..TitanUtils_GetGoldText("Successful").." or "..TitanUtils_GetRedText("Failed")
	
	args["desc"] = 
	{
		order = 0,
		type = "description",
		name = attempts.."\n",
		cmdHidden = true
	}
	for idx, value in pairs(TitanPluginToBeRegistered) do
		if TitanPluginToBeRegistered[idx] 
		then
			local num = tostring(idx)
			local button = TitanPluginToBeRegistered[idx].button
			local name = (TitanPluginToBeRegistered[idx].name or "?")
			local reason = TitanPluginToBeRegistered[idx].status
			local issue = TitanPluginToBeRegistered[idx].issue
			local category = TitanPluginToBeRegistered[idx].category
			local ptype = TitanPluginToBeRegistered[idx].plugin_type
--[[
			if TitanPluginToBeRegistered[idx].button then
				local reg_but = TitanPluginToBeRegistered[idx].button
				if _G[reg_but].registry then
					child = (_G[reg_but].registry.ldb or "false")
					TitanDebug("TitanUpdateAddonAttempts "
						.."name '"..(name or "?").."'"
						.."type '"..(_G[reg_but].registry.ldb or "?").."'"
					)
				else
					TitanDebug("TitanUpdateAddonAttempts "
						.."name '"..(name or "?").."'"
						.." no registry found... "
					)
				end
			end
--]]
			local title = num.." "..TitanPluginToBeRegistered[idx].name
			if reason ~= TITAN_REGISTERED then
				title = TitanUtils_GetRedText(num)
				issue = TitanUtils_GetRedText(issue)
			end
			args[num] = 
--			args = 
			{
				type = "group",
				name = title,
				order = idx,
				args = 
				{
					name =
					{
						type = "description",
						name = TitanUtils_GetGoldText("")..name,
						cmdHidden = true,
						order = 1,
					},
					reason =
					{
						type = "description",
						name = TitanUtils_GetGoldText("Status: ")..reason,
						cmdHidden = true,
						order = 2,
					},
					issue =
					{
						type = "description",
						name = TitanUtils_GetGoldText("Issue: \n")..issue,
						cmdHidden = true,
						order = 3,
					},
					sp_1 =
					{
						type = "description",
						name = "",
						cmdHidden = true,
						order = 4,
					},
					category =
					{
						type = "description",
						name = TitanUtils_GetGoldText("Category: ")..category,
						cmdHidden = true,
						order = 10,
					},
					ptype =
					{
						type = "description",
						name = TitanUtils_GetGoldText("Type: ")..ptype,
						cmdHidden = true,
						order = 11,
					},
					button =
					{
						type = "description",
						name = TitanUtils_GetGoldText("Button Name: \n")..button,
						cmdHidden = true,
						order = 12,
					},
				}
			}
		end
   end
    
    -- Config Tables changed!
    AceConfigRegistry:NotifyChange(L["TITAN_PANEL"])
end

local optionsExtras = {
	name = "Titan "..L["TITAN_PANEL_EXTRAS"],
	type = "group",
	args = {}
 }
local function TitanRefreshExtras()
    -- Config Tables changed!
    AceConfigRegistry:NotifyChange("Titan Panel Addon Extras")
end
local function TitanUpdateExtras()
	local args = optionsExtras.args
	local plug_in = nil

	wipe(args)

	args["desc"] = 
	{
		order = 1,
		type = "description",
		name = L["TITAN_PANEL_EXTRAS_DESC"].."\n",
		cmdHidden = true
	}
	for idx, value in pairs(TitanPluginExtras) do
		if TitanPluginExtras[idx] then
			local num = TitanPluginExtras[idx].num
			local name = TitanPluginExtras[idx].id
			args[name] = 
			{
				type = "group",
				name = TitanUtils_GetGoldText(tostring(num)..": "..(name or "?")),
				order = idx,
				args = 
				{
					name =
					{
						type = "description",
						name = TitanUtils_GetGoldText(name or "?"),
						cmdHidden = true,
						order = 10,
					},
					optionreset = {
						name = L["TITAN_PANEL_EXTRAS_DELETE_BUTTON"],
						order = 15, type = "execute", width = "full",
						func = function(info, v) 
							TitanPluginSettings[info[1]] = nil -- delete the config entry
							DEFAULT_CHAT_FRAME:AddMessage(
								TitanUtils_GetGoldText(L["TITAN_PANEL"])
								.." '"..info[1].."' "..L["TITAN_PANEL_EXTRAS_DELETE_MSG"]
								);
							TitanRefreshExtras()
						end,
					},
				}
			}
		end
   end
end

local optionsChars = {
	name = "Titan "..L["TITAN_PANEL_CHARS"],
	type = "group",
	args = {}
 }
local function TitanUpdateChars()
	local args = optionsChars.args
	local plug_in = nil

	wipe(args)

	args["desc"] = 
	{
		order = 1,
		type = "description",
		name = L["TITAN_PANEL_CHARS_DESC"].."\n",
		cmdHidden = true
	}
	for idx, value in pairs(TitanSettings.Players) do
		if TitanSettings.Players[idx] and not (TitanSettings.Players[idx] == TitanSettings.Player)then
			local name = (idx or "?")
			args[name] = 
--			args = 
			{
				type = "group",
				name = TitanUtils_GetGoldText((name or "?")),
				order = 1,
				args = 
				{
					name =
					{
						type = "description",
						name = TitanUtils_GetGoldText(name or "?"),
						cmdHidden = true,
						order = 10,
					},
					optionreset = {
						name = L["TITAN_PANEL_CHARS_DELETE_BUTTON"],
						order = 15, type = "execute", width = "full",
						func = function(info, v) 
							TitanSettings.Players[info[1]] = nil -- delete the config entry
							DEFAULT_CHAT_FRAME:AddMessage(
								TitanUtils_GetGoldText(L["TITAN_PANEL"])
								.." '"..info[1].."' "..L["TITAN_PANEL_CHARS_DELETE_MSG"]
								);
						end,
					},
--[[
--]]
				}
			}
		end
   end
    
    -- Config Tables changed!
    AceConfigRegistry:NotifyChange("Titan Panel Addon Chars")
end

local optionsAddons = {
	name = "Titan "..L["TITAN_PANEL_MENU_PLUGINS"],
	type = "group",
	args = {}
 }
function TitanUpdateConfigAddons()
	local args = optionsAddons.args
	local plug_in = nil
	local pre = "        "
    
    wipe(args)

    for idx, value in pairs(TitanPluginsIndex) do
		plug_in = TitanUtils_GetPlugin(TitanPluginsIndex[idx])
		if plug_in then
			args[plug_in.id] = 
			{
				type = "group",
				name = plug_in.menuText,
				order = idx,
				args = 
				{
					name =
					{
						type = "header", -- name / id
						name = plug_in.menuText,
						order = 1,
					},
--[[
					category =
					{
						type = "header", -- category
						name = (plug_in.category or "Unknown"),
						order = 2,
					},
--]]
					show =
					{
						type = "toggle",
						name = L["TITAN_PANEL_MENU_SHOW"],
						order = 3,
						get = function(info) return (TitanPanel_IsPluginShown(info[1])) end,
						set = function(info, v) 
							local name = info[1]
							if v then -- Show / add
								local bar = (TitanGetVar(name, "ForceBar") or "Bar")
								TitanUtils_AddButtonOnBar(bar, name)
							else -- Hide / remove
								TitanPanel_RemoveButton(name)
							end
							-- AceConfigRegistry:NotifyChange(L["TITAN_PANEL"]) -- does not work
							end,
					},
				}
			}
			
			--ShowIcon
			if plug_in.controlVariables and plug_in.controlVariables.ShowIcon then
				args[plug_in.id].args.icon =
					{
						type = "toggle",
						name = L["TITAN_PANEL_MENU_SHOW_ICON"],
						order = 4,
						get = function(info) return (TitanGetVar(info[1], "ShowIcon")) end,
						set = function(info, v) 
							TitanToggleVar(info[1], "ShowIcon");
							TitanPanelButton_UpdateButton(info[1])
							end,
					}
			end

			--ShowLabel
			if plug_in.controlVariables and plug_in.controlVariables.ShowLabelText then
				args[plug_in.id].args.label =
					{
						type = "toggle",
						name = L["TITAN_PANEL_MENU_SHOW_LABEL_TEXT"],
						order = 5,
						get = function(info) return (TitanGetVar(info[1], "ShowLabelText")) end,
						set = function(info, v) 
							TitanToggleVar(info[1], "ShowLabelText");
							TitanPanelButton_UpdateButton(info[1])
							end,
					}
			end
			
			--ShowRegularText (LDB data sources only atm)
			if plug_in.controlVariables and plug_in.controlVariables.ShowRegularText then
				args[plug_in.id].args.regular_text =
					{
						type = "toggle",
						name = L["TITAN_PANEL_MENU_SHOW_PLUGIN_TEXT"],
						order = 7,
						get = function(info) return (TitanGetVar(info[1], "ShowRegularText")) end,
						set = function(info, v) 
							TitanToggleVar(info[1], "ShowRegularText");
							TitanPanelButton_UpdateButton(info[1])
							end,
					}
			end
			
			--ShowColoredText
			if plug_in.controlVariables and plug_in.controlVariables.ShowColoredText then
				args[plug_in.id].args.color_text =
					{
						type = "toggle",
						name = L["TITAN_PANEL_MENU_SHOW_COLORED_TEXT"],
						order = 6,
						get = function(info) return (TitanGetVar(info[1], "ShowColoredText")) end,
						set = function(info, v) 
							TitanToggleVar(info[1], "ShowColoredText");
							TitanPanelButton_UpdateButton(info[1])
							end,
					}
			end

			-- Right-side plugin
			if plug_in.controlVariables and plug_in.controlVariables.DisplayOnRightSide then
				args[plug_in.id].args.right_side =
					{
						type = "toggle",
						name = L["TITAN_PANEL_MENU_LDB_SIDE"],
						order = 8,
						get = function(info) return (TitanGetVar(info[1], "DisplayOnRightSide")) end,
						set = function(info, v) 
							TitanToggleVar(info[1], "DisplayOnRightSide");
							TitanPanel_RemoveButton(info[1]);
							TitanUtils_AddButtonOnBar(TitanUtils_GetWhichBar(info[1]), info[1]);     
							TitanPanelButton_UpdateButton(info[1])
							end,
					}
			end
--[[
---------------------------
--]]
			args[plug_in.id].args.plugin_position =
				{
					order = 50,
					type = "header",
					name = L["TITAN_PANEL_MENU_POSITION"],
				}
			args[plug_in.id].args.shift_left =
			{
				type = "execute",
				name = "< "..L["TITAN_PANEL_SHIFT_LEFT"].."  ",
				order = 51,
				func = function(info, arg1)
					name = info[1]
					if TitanPanel_IsPluginShown(name) then
						TitanUtils_ShiftButtonOnBarLeft(name)
					end
				end,
			}
			args[plug_in.id].args.shift_right =
			{
				type = "execute",
				name = "> "..L["TITAN_PANEL_SHIFT_RIGHT"],
				order = 52,
				func = function(info, arg1)
					name = info[1]
					if TitanPanel_IsPluginShown(info[1]) then
						TitanUtils_ShiftButtonOnBarRight(name)
					end
				end,
			}
			args[plug_in.id].args.space_50_1 =
			{
				order = 53,
				type = "description",
				name = "  ",
				cmdHidden = true,
			}
			if not TitanVarExists(plug_in.id, "ForceBar") then
				args[plug_in.id].args.top_bottom =
				{
					order = 54, type = "select",
					name = L["TITAN_PANEL_MENU_BAR"],
					desc = L["TITAN_PANEL_MENU_DISPLAY_ON_BAR"],
					get = function(info) 
						return TitanUtils_GetWhichBar(info[1]) end,
					set = function(info,v)
						local name = info[1]
						if TitanPanel_IsPluginShown(name) then
							TitanUtils_SetWhichBar(name,v)
						end
					end,
					values = function()
						local Locationlist = {}
						local v;
						for _,v in pairs (TitanPluginLocation) do
							Locationlist[v] = v
						end
						return Locationlist
					end,
				}
			else
				args[plug_in.id].args.top_bottom =
				{
					order = 54,
					type = "description",
					name = TitanUtils_GetGoldText("Always "..TitanGetVar(plug_in.id, "ForceBar")),
					cmdHidden = true,
				}
			end
		end
    end
    
    -- Config Tables changed!
    AceConfigRegistry:NotifyChange(L["TITAN_PANEL"])
end

 -- Set script handlers for frames
TitanPanelBarButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
TitanPanelAuxBarButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
TitanPanelBarButtonHider:SetScript("OnLeave", function(self) TitanPanelBarButtonHider_OnLeave(self:GetName()) end)
TitanPanelAuxBarButtonHider:SetScript("OnLeave", function(self) TitanPanelAuxBarButtonHider_OnLeave(self:GetName()) end)
TitanPanelBarButton:SetScript("OnEnter", function(self) TitanPanelBarButtonHider_OnEnter(self:GetName()) end)
TitanPanelBarButton:SetScript("OnLeave", function(self) TitanPanelBarButton_OnLeave(self:GetName()) end)
TitanPanelBarButton:SetScript("OnClick", function(self, button) TitanPanelBarButton_OnClick(self, button) end)
TitanPanelAuxBarButton:SetScript("OnEnter", function(self) TitanPanelBarButtonHider_OnEnter(self:GetName()) end)
TitanPanelAuxBarButton:SetScript("OnLeave", function(self) TitanPanelAuxBarButton_OnLeave(self:GetName()) end)
TitanPanelAuxBarButton:SetScript("OnClick", function(self, button) TitanPanelBarButton_OnClick(self, button) end)

-- Event registration
TitanPanelBarButton:RegisterEvent("ADDON_LOADED");
TitanPanelBarButton:RegisterEvent("PLAYER_ENTERING_WORLD");
TitanPanelBarButton:RegisterEvent("PLAYER_REGEN_DISABLED");
TitanPanelBarButton:RegisterEvent("PLAYER_REGEN_ENABLED");
TitanPanelBarButton:RegisterEvent("CVAR_UPDATE");
TitanPanelBarButton:RegisterEvent("PLAYER_LOGOUT");
TitanPanelBarButton:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
TitanPanelBarButton:SetScript("OnEvent", function(_, event, ...)
	TitanPanelBarButton[event](TitanPanelBarButton, ...)
end)
	
-- Add Blizzard Configuration Panel
AceConfig:RegisterOptionsTable("Titan Panel Main", optionsControl)
AceConfig:RegisterOptionsTable("Titan Panel Options", optionsBars)
AceConfig:RegisterOptionsTable("Titan Panel Frames", optionsFrames)
AceConfig:RegisterOptionsTable("Titan Panel Transparency Control", optionsTrans)
AceConfig:RegisterOptionsTable("Titan Panel Panel Control", optionsUIScale)
AceConfig:RegisterOptionsTable("Titan Panel Skin Control", optionsSkins)
AceConfig:RegisterOptionsTable("Titan Panel Addon Control", optionsAddons)
AceConfig:RegisterOptionsTable("Titan Panel Addon Attempts", optionsAddonAttempts)
AceConfig:RegisterOptionsTable("Titan Panel Addon Extras", optionsExtras)
AceConfig:RegisterOptionsTable("Titan Panel Addon Chars", optionsChars)
AceConfigDialog:AddToBlizOptions("Titan Panel Main", L["TITAN_PANEL"])
AceConfigDialog:AddToBlizOptions("Titan Panel Options", L["TITAN_PANEL_MENU_OPTIONS_BARS"], L["TITAN_PANEL"])
AceConfigDialog:AddToBlizOptions("Titan Panel Panel Control", L["TITAN_UISCALE_MENU_TEXT"], L["TITAN_PANEL"])
AceConfigDialog:AddToBlizOptions("Titan Panel Transparency Control", L["TITAN_TRANS_MENU_TEXT_SHORT"], L["TITAN_PANEL"])
AceConfigDialog:AddToBlizOptions("Titan Panel Skin Control", L["TITAN_PANEL_MENU_TEXTURE_SETTINGS"], L["TITAN_PANEL"])
AceConfigDialog:AddToBlizOptions("Titan Panel Frames", L["TITAN_PANEL_MENU_OPTIONS"], L["TITAN_PANEL"])
AceConfigDialog:AddToBlizOptions("Titan Panel Addon Control", L["TITAN_PANEL_MENU_PLUGINS"], L["TITAN_PANEL"])
AceConfigDialog:AddToBlizOptions("Titan Panel Addon Attempts", L["TITAN_PANEL_ATTEMPTS"], L["TITAN_PANEL"])
AceConfigDialog:AddToBlizOptions("Titan Panel Addon Extras", L["TITAN_PANEL_EXTRAS"], L["TITAN_PANEL"])
AceConfigDialog:AddToBlizOptions("Titan Panel Addon Chars", L["TITAN_PANEL_CHARS"], L["TITAN_PANEL"])

-- Event handlers
function TitanPanelBarButton:ADDON_LOADED(addon)
	if addon == "Titan" then
		-- Init Profile/Saved Vars
		TitanVariables_InitTitanSettings();			
		local VERSION = TitanPanel_GetVersion();
		local POS = strfind(VERSION," - ");
		VERSION = strsub(VERSION,1,POS-1);
		DEFAULT_CHAT_FRAME:AddMessage(
			TitanUtils_GetGoldText(L["TITAN_PANEL"].." (")
			..TitanUtils_GetGreenText(VERSION)
			..TitanUtils_GetGoldText(")"..L["TITAN_PANEL_VERSION_INFO"])
			);

		if not ServerTimeOffsets then
			ServerTimeOffsets = {};
		end
		if not ServerHourFormat then
			ServerHourFormat = {};
		end
		-- set registered skins
		if not TitanSkins then
			TitanSkins = {
			  { name = "Titan Default", path = "Interface\\AddOns\\Titan\\Artwork\\"},
			  { name = "Christmas", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Christmas Skin\\"},
			  { name = "Charcoal Metal", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Charcoal Metal\\"},
			  { name = "Crusader", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Crusader Skin\\"},
			  { name = "Cursed Orange", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Cursed Orange Skin\\"},
			  { name = "Dark Wood", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Dark Wood Skin\\"},
			  { name = "Deep Cave", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Deep Cave Skin\\"},
			  { name = "Elfwood", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Elfwood Skin\\"},
			  { name = "Engineer", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Engineer Skin\\"},
			  { name = "Frozen Metal", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Frozen Metal Skin\\"},
			  { name = "Graphic", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Graphic Skin\\"},
			  { name = "Graveyard", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Graveyard Skin\\"},
			  { name = "Hidden Leaf", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Hidden Leaf Skin\\"},
			  { name = "Holy Warrior", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Holy Warrior Skin\\"},
			  { name = "Nightlife", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Nightlife Skin\\"},
			  { name = "Orgrimmar", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Orgrimmar Skin\\"},
			  { name = "Plate", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Plate Skin\\"},
			  { name = "Tribal", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\Tribal Skin\\"},
			  { name = "X-Perl", path = "Interface\\AddOns\\Titan\\Artwork\\Custom\\X-Perl\\"},
			  };
		end
	end
	self:UnregisterEvent("ADDON_LOADED");
	self.ADDON_LOADED = nil
end

function TitanPanelBarButton:PLAYER_ENTERING_WORLD()
	if not Titan__InitializedPEW then
		-- only do this sort of initialization on the first PEW event
		
		-- register plugins here!!
		TitanUtils_RegisterPluginList()
		-- Init detailed settings only after plugins are registered!
		TitanVariables_InitDetailedSettings()

		-- all addons are loaded so update the config (options)
		TitanUpdateConfigAddons()
		TitanUpdateAddonAttempts()
		Titan__InitializedPEW = true
		TitanUpdateExtras()
		TitanUpdateChars()

		local realmName = GetCVar("realmName")

		if ServerTimeOffsets[realmName] then
			TitanSetVar(TITAN_CLOCK_ID, "OffsetHour", ServerTimeOffsets[realmName])
		elseif TitanGetVar(TITAN_CLOCK_ID, "OffsetHour") then
			ServerTimeOffsets[realmName] = TitanGetVar(TITAN_CLOCK_ID, "OffsetHour")
		end
	
		if ServerHourFormat[realmName] then
			TitanSetVar(TITAN_CLOCK_ID, "Format", ServerHourFormat[realmName])
		elseif TitanGetVar(TITAN_CLOCK_ID, "Format") then
			ServerHourFormat[realmName] = TitanGetVar(TITAN_CLOCK_ID, "Format")
		end
	
		-- Init panel font
		local isfontvalid = media:IsValid("font", TitanPanelGetVar("FontName"))
		if isfontvalid then
			TitanSetPanelFont(TitanPanelGetVar("FontName"), TitanPanelGetVar("FontSize"))
		else
		-- if the selected font is not valid, revert to default (Friz Quadrata TT)
			TitanPanelSetVar("FontName", "Friz Quadrata TT");
			TitanSetPanelFont("Friz Quadrata TT", TitanPanelGetVar("FontSize"))
		end
	
		-- Init panel frame strata
		TitanVariables_SetPanelStrata(TitanPanelGetVar("FrameStrata"))
		
		
	end
	
	-- Move frames
	TitanPanelFrame_ScreenAdjust();
	
	-- Init panel buttons
	TitanPanel_InitPanelBarButton();
	TitanPanel_InitPanelButtons();

	-- Adjust initial frame position
	TitanPanel_SetTransparent("TitanPanelBarButtonHider", TitanPanelGetVar("Position"));
	
	-- Secondary failsafe check for bottom frame adjustment
	if (TitanPanelGetVar("BothBars") and not TitanPanelGetVar("AuxScreenAdjust")) 
	or (TitanPanelGetVar("Position") == 2 and not TitanPanelGetVar("ScreenAdjust")) then
		AceTimer.ScheduleTimer("TitanPanelAdjustBottomFrames", TitanAdjustBottomFrames, 5);
	end
end

function TitanPanelBarButton:CVAR_UPDATE(cvarname, cvarvalue)
	if cvarname == "USE_UISCALE" or cvarname == "WINDOWED_MODE" or cvarname == "uiScale" then
		if TitanPlayerSettings and TitanPanelGetVar("Scale") then
			Titan_AdjustScale()
			-- Adjust frame positions
			TitanPanelFrame_ScreenAdjust();
		end
	end
end

function TitanPanelBarButton:PLAYER_LOGOUT()
-- save bars settings on logout to avoid "garbage" in savedvars buttons table
	if not IsTitanPanelReset then
		TitanPanelSettings.Buttons = newButtons;
		TitanPanelSettings.Location = newLocations;
	end
end

function TitanPanelBarButton:PLAYER_REGEN_DISABLED()
-- If in combat close all control frames and menus
	TitanUtils_CloseAllControlFrames();
	TitanUtils_CloseRightClickMenu();
end

function TitanPanelBarButton:PLAYER_REGEN_ENABLED()
-- Outside combat check to see if frames need correction
	TitanMovableFrame_CheckFrames(1);
	TitanMovableFrame_MoveFrames(1, TitanPanelGetVar("ScreenAdjust"));
	Titan_ManageFramesNew();
	Titan_FCF_UpdateCombatLogPosition();
end

function TitanPanelBarButton:ACTIVE_TALENT_GROUP_CHANGED()
	AceTimer.ScheduleTimer("TitanPanelAdjustBottomDualSpec", Titan_ManageFramesNew, 3)
end

-- Slash command handler
function TitanPanel_RegisterSlashCmd(cmd)
	--
	--	reset routines
	--
	if (string.lower(cmd) == "reset") then
		TitanPanel_ResetToDefault();
		return;
	end
	if (string.lower(cmd) == "reset tipfont") then
		TitanPanelSetVar("TooltipFont", 1);
		GameTooltip:SetScale(TitanPanelGetVar("TooltipFont"));
		DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_RESP1"]);
		return;
	end
	if (string.lower(cmd) == "reset tipalpha") then
		TitanPanelSetVar("TooltipTrans", 1);
		local red, green, blue, _ = GameTooltip:GetBackdropColor();
		local red2, green2, blue2, _ = GameTooltip:GetBackdropBorderColor();
		GameTooltip:SetBackdropColor(red,green,blue,TitanPanelGetVar("TooltipTrans"));
		GameTooltip:SetBackdropBorderColor(red2,green2,blue2,TitanPanelGetVar("TooltipTrans"));
		DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_RESP2"]);
		return;
	end
	if (string.lower(cmd) == "reset panelscale") then
		if not InCombatLockdown() then
			TitanPanelSetVar("Scale", 1);

			-- Adjust panel scale
			Titan_AdjustScale()

			-- Adjust frame positions
			TitanMovableFrame_CheckFrames(1);
			TitanMovableFrame_MoveFrames(1, TitanPanelGetVar("ScreenAdjust"));
			TitanMovableFrame_CheckFrames(2);
			TitanMovableFrame_MoveFrames(2, TitanPanelGetVar("AuxScreenAdjust"));
			TitanMovableFrame_AdjustBlizzardFrames();		

			DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_RESP3"]);
		else
			DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL"].._G["FONT_COLOR_CODE_CLOSE"]..": "..L["TITAN_PANEL_MENU_IN_COMBAT_LOCKDOWN"]);
		end
		return;
	end
	if (string.lower(cmd) == "reset spacing") then
		TitanPanelSetVar("ButtonSpacing", 20);
		TitanPanel_InitPanelButtons();
		DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_RESP4"]);
		return;
	end
	
	--
	--	GUI routines
	--
	if (string.lower(cmd) == "gui control") then
		AceConfigDialog:SetDefaultSize("Titan Panel Panel Control", 450, 450)	
		AceConfigDialog:Open("Titan Panel Panel Control")
		return;
	end
	if (string.lower(cmd) == "gui trans") then
		AceConfigDialog:SetDefaultSize("Titan Panel Transparency Control", 450, 450)	
		AceConfigDialog:Open("Titan Panel Transparency Control")
		return;
	end
	if (string.lower(cmd) == "gui skin") then
		AceConfigDialog:SetDefaultSize("Titan Panel Skin Control", 450, 450)	
		AceConfigDialog:Open("Titan Panel Skin Control")
		return;
	end

	--
	--	Give the user the general help if we can not figure out what they want
	--
   DEFAULT_CHAT_FRAME:AddMessage(_G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["TITAN_PANEL"].." ".._G["GREEN_FONT_COLOR_CODE"]..TitanPanel_GetVersion().._G["LIGHTYELLOW_FONT_COLOR_CODE"]..L["TITAN_PANEL_VERSION_INFO"]);
   DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_STRING2"]);
   DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_STRING3"]);
   DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_STRING4"]);
   DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_STRING5"]);
   DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_STRING6"]);
   DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_STRING7"]);
   DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_STRING8"]);
   DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_STRING9"]);
   DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_STRING10"]);
   DEFAULT_CHAT_FRAME:AddMessage(L["TITAN_PANEL_SLASH_STRING11"]);
end

-- Register slash commands for Titan Panel
SlashCmdList["TitanPanel"] = TitanPanel_RegisterSlashCmd;
SLASH_TitanPanel1 = "/titanpanel";
SLASH_TitanPanel2 = "/titan";

function TitanPanel_AddNewSkin(skinname, skinpath)
	if not skinname or not skinpath then return end -- name and path must be provided
	if skinname == "" or skinname == L["TITAN_NONE"] or skinpath == "" then return end -- name cannot be empty or "None", path cannot be empty	
	local found
	for _,i in pairs(TitanSkins) do
		if i.name == skinname or i.path == skinpath then
			found = true			
			break
		end
	end
	
	if not found then table.insert(TitanSkins, {name = skinname, path = skinpath }) end
end

function TitanPanel_ClearAllBarTextures()
-- Clear textures if they already exist
	for i = 0, numOfTexturesHider do
		if _G["TitanPanelBackground"..i] then
			_G["TitanPanelBackground"..i]:SetTexture()
		end
		if _G["TitanPanelBackgroundAux"..i] then
			_G["TitanPanelBackgroundAux"..i]:SetTexture()
		end
	end
end

function TitanPanel_CreateBarTextures()
	-- Create the basic Titan bars (textures)
	local i, titanTexture		
	local screenWidth = (TitanPanelBarButton:GetWidth() or GetScreenWidth()) + 1
	numOfTextures = floor(screenWidth / 256)
	numOfTexturesHider = (numOfTextures * 2) + 1
	local lastTextureWidth = screenWidth - (numOfTextures * 256)
	
	-- Handle TitanPanelBarButton Textures
	for i = 0, numOfTextures do
		-- Create textures if they don't exist
		if not _G["TitanPanelBackground"..i] then
			titanTexture = TitanPanelBarButton:CreateTexture("TitanPanelBackground"..i, "BACKGROUND")
		else
			titanTexture = _G["TitanPanelBackground"..i]
		end
		titanTexture:SetHeight(32)
		if i == numOfTextures then
			titanTexture:SetWidth(lastTextureWidth)
		else
		  titanTexture:SetWidth(256)
		end
		titanTexture:ClearAllPoints()
		if i == 0 then
			titanTexture:SetPoint("TOPLEFT", "TitanPanelBarButton", "TOPLEFT", -1, 1)
		else
			titanTexture:SetPoint("TOPLEFT", "TitanPanelBackground"..i-1, "TOPRIGHT")
		end
	end
	
	-- Create 1st texture of 2nd bar if it doesn't exist
	if not _G["TitanPanelBackground"..numOfTextures + 1] then
		titanTexture = TitanPanelBarButton:CreateTexture("TitanPanelBackground"..numOfTextures + 1, "BACKGROUND")
	else
		titanTexture = _G["TitanPanelBackground"..numOfTextures + 1]
	end
	titanTexture:SetHeight(30)
	titanTexture:SetWidth(256)
	--titanTexture:SetPoint("TOPLEFT", "TitanPanelBackground0", "TOPRIGHT", 0, -25)
	
	-- Handle TitanPanelBarButtonHider Textures
	for i = numOfTextures + 2, numOfTexturesHider do
		if not _G["TitanPanelBackground"..i] then
			titanTexture = TitanPanelBarButton:CreateTexture("TitanPanelBackground"..i, "BACKGROUND")
		else
			titanTexture = _G["TitanPanelBackground"..i]
		end
		titanTexture:SetHeight(30)
		if i == numOfTexturesHider then
			titanTexture:SetWidth(lastTextureWidth)
		else
			titanTexture:SetWidth(256)
		end
		titanTexture:ClearAllPoints()
		titanTexture:SetPoint("TOPLEFT", "TitanPanelBackground"..i-1, "TOPRIGHT")
	end
	
	-- Handle TitanPanelAuxBarButton Textures
	for i = 0, numOfTextures do
		-- Create textures if they don't exist
		if not _G["TitanPanelBackgroundAux"..i] then
			titanTexture = TitanPanelAuxBarButton:CreateTexture("TitanPanelBackgroundAux"..i, "BACKGROUND")				
		else
			titanTexture = _G["TitanPanelBackgroundAux"..i]
		end
		titanTexture:SetHeight(32)
		if i == numOfTextures then
			titanTexture:SetWidth(lastTextureWidth)
		else
		  titanTexture:SetWidth(256)
		end
		titanTexture:ClearAllPoints()
		if i == 0 then
			titanTexture:SetPoint("TOPLEFT", "TitanPanelAuxBarButton", "TOPLEFT", -1, 1)
		else
			titanTexture:SetPoint("TOPLEFT", "TitanPanelBackgroundAux"..i-1, "TOPRIGHT")
		end
	end
	
	-- Create 1st texture of 2nd bar if it doesn't exist
	if not _G["TitanPanelBackgroundAux"..numOfTextures + 1] then
		titanTexture = TitanPanelAuxBarButton:CreateTexture("TitanPanelBackgroundAux"..numOfTextures + 1, "BACKGROUND")
	else
		titanTexture = _G["TitanPanelBackgroundAux"..numOfTextures + 1]
	end
	titanTexture:SetHeight(30)
	titanTexture:SetWidth(256)
	titanTexture:ClearAllPoints()
	titanTexture:SetPoint("TOPLEFT", "TitanPanelBackgroundAux0", "TOPLEFT", 0, 23)
	
	-- Handle TitanPanelAuxBarButtonHider Textures
	for i = numOfTextures + 2, numOfTexturesHider do
		if not _G["TitanPanelBackgroundAux"..i] then
			titanTexture = TitanPanelAuxBarButton:CreateTexture("TitanPanelBackgroundAux"..i, "BACKGROUND")
		else
			titanTexture = _G["TitanPanelBackgroundAux"..i]
		end
		titanTexture:SetHeight(30)
		if i == numOfTexturesHider then
			titanTexture:SetWidth(lastTextureWidth)
		else
			titanTexture:SetWidth(256)
		end
		titanTexture:ClearAllPoints()
		titanTexture:SetPoint("TOPLEFT", "TitanPanelBackgroundAux"..i-1, "TOPRIGHT")
	end
end

function TitanPanelFrame_ScreenAdjust()
	if not InCombatLockdown() then
		TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
		TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"),  TitanPanelGetVar("ScreenAdjust"));
		TitanMovableFrame_CheckFrames(TITAN_PANEL_PLACE_BOTTOM);
		TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_BOTTOM, TitanPanelGetVar("AuxScreenAdjust"));
		TitanMovableFrame_AdjustBlizzardFrames();
	end
end

function TitanPanelBarButton_OnClick(self, button)
	-- ensure that the right-click menu will not appear on "hidden" bottom bar(s)
	local bar = self:GetName();
	if bar == "TitanPanelAuxBarButtonHider" and not TitanPanelGetVar("BothBars") then
		return 
	end
	
	if (button == "LeftButton") then
		TitanUtils_CloseAllControlFrames();
		TitanUtils_CloseRightClickMenu();	
	elseif (button == "RightButton") then
		TitanUtils_CloseAllControlFrames();			
		-- Show RightClickMenu anyway
		if (TitanPanelRightClickMenu_IsVisible()) then
			TitanPanelRightClickMenu_Close();
		end
		-- Initialize the DropDown Menu if not already initialized
		if not self.TitanMenuInit and self:GetName() then
			local initframe = bar;
			if bar == "TitanPanelBarButtonHider" then initframe = "TitanPanelBarButton" end
			if bar == "TitanPanelAuxBarButtonHider" then initframe = "TitanPanelAuxBarButton" end
			TitanRightClickMenu_OnLoad(_G[initframe.."RightClickMenu"])
			self.TitanMenuInit = true
		end
		TitanPanelRightClickMenu_Toggle(self);		
	end
end

function Handle_OnUpdateAutoHide()

	if TitanPanelRightClickMenu_IsVisible() or (Tablet20Frame and Tablet20Frame:IsVisible()) or (Dewdrop and Dewdrop:IsOpen())then
		return
	end
	
	if  (TitanPanelBarButton.hide == nil) and (TitanPanelGetVar("AutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
		TitanKillAutoHidetimer = true;
	elseif (TitanPanelBarButton.hide == nil) and (not TitanPanelGetVar("AutoHide")) then
		TitanKillAutoHidetimer = true;
	end

	if (TitanPanelAuxBarButton.hide == nil) and (TitanPanelGetVar("AuxAutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
		TitanKillAutoHidetimer = true;
	elseif (TitanPanelAuxBarButton.hide == nil) and (not TitanPanelGetVar("AuxAutoHide")) then
		TitanKillAutoHidetimer = true;
	end

  if (TitanPanelBarButton.hide == 1) and (TitanPanelAuxBarButton.hide == 1) then
  TitanKillAutoHidetimer = true;
	end
	
	if TitanKillAutoHidetimer == true then
		AceTimer.CancelAllTimers("TitanAutoHider")		 
		TitanKillAutoHidetimer = false;
	end
	
end

function TitanPanelAuxBarButton_OnLeave(frame)
	if (TitanPanelGetVar("AuxAutoHide")) then
		AceTimer.ScheduleRepeatingTimer("TitanAutoHider", Handle_OnUpdateAutoHide, 0.5)
	end
end

function TitanPanelAuxBarButtonHider_OnLeave(frame)
	if (TitanPanelGetVar("AuxAutoHide")) then
		AceTimer.ScheduleRepeatingTimer("TitanAutoHider", Handle_OnUpdateAutoHide, 0.5)
	end
end

function TitanPanelBarButtonHider_OnLeave(frame)
	if (TitanPanelGetVar("AutoHide")) then
		AceTimer.ScheduleRepeatingTimer("TitanAutoHider", Handle_OnUpdateAutoHide, 0.5)
	end
end

function TitanPanelBarButton_OnLeave(frame)
	if (TitanPanelGetVar("AutoHide")) then
		AceTimer.ScheduleRepeatingTimer("TitanAutoHider", Handle_OnUpdateAutoHide, 0.5)
	end
end

function TitanPanelBarButtonHider_OnEnter(frame)
      
		 AceTimer.CancelAllTimers("TitanAutoHider")

	if (TitanPanelGetVar("AutoHide") or TitanPanelGetVar("AuxAutoHide")) then
		local frname = _G[frame]
		
		
		if (frame == "TitanPanelBarButton" and TitanPanelBarButton.hide == 1) then
			if (TitanPanelBarButton.hide) then
				TitanPanelBarButton_Show("TitanPanelBarButton", TitanPanelGetVar("Position"));
			end
		else
			if (frame == "TitanPanelAuxBarButton" and TitanPanelAuxBarButton.hide == 1) then
				if (TitanPanelAuxBarButton.hide) then
					TitanPanelBarButton_Show("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
				end
			end
		end

		if (frame == "TitanPanelBarButtonHider" and TitanPanelBarButton.hide == 1) then
			if (TitanPanelBarButton.hide) then
				TitanPanelBarButton_Show("TitanPanelBarButton", TitanPanelGetVar("Position"));
			end
		else
			if (frame == "TitanPanelAuxBarButtonHider" and TitanPanelAuxBarButton.hide and TitanPanelAuxBarButton.hide == 1) then
				if TitanPanelGetVar("BothBars") then
					TitanPanelBarButton_Show("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
				end
			end
		end
	end
end

function TitanPanelRightClickMenu_BarOnClick(checked, value)	
	 if checked then
		TitanPanel_RemoveButton(value);		
	else
		TitanPanel_AddButton(value);
	end
end

function TitanPanelBarButton_ToggleAlign()
	if ( TitanPanelGetVar("ButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER ) then
		TitanPanelSetVar("ButtonAlign", TITAN_PANEL_BUTTONS_ALIGN_LEFT);
	else
		TitanPanelSetVar("ButtonAlign", TITAN_PANEL_BUTTONS_ALIGN_CENTER);
	end
	
	-- Justify button position
	TitanPanelButton_Justify();
end

function TitanPanelBarButton_ToggleAuxAlign()
	if ( TitanPanelGetVar("AuxButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER ) then
		TitanPanelSetVar("AuxButtonAlign", TITAN_PANEL_BUTTONS_ALIGN_LEFT);
	else
		TitanPanelSetVar("AuxButtonAlign", TITAN_PANEL_BUTTONS_ALIGN_CENTER);
	end
	
	-- Justify button position
	TitanPanelButton_Justify();
end

function TitanPanelBarButton_ToggleDoubleBar()
	if ( TitanPanelGetVar("DoubleBar") == TITAN_PANEL_BARS_SINGLE ) then
		TitanPanelSetVar("DoubleBar", TITAN_PANEL_BARS_DOUBLE);
		TitanPanelBarButtonHider:SetHeight(48);
	else
		TitanPanelSetVar("DoubleBar", TITAN_PANEL_BARS_SINGLE);
		TitanPanelBarButtonHider:SetHeight(24);
	end
	
	TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
	TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"), TitanPanelGetVar("DoubleBar"));
	TitanMovableFrame_AdjustBlizzardFrames();
	TitanPanel_InitPanelBarButton();
	TitanPanel_InitPanelButtons();		
	TitanPanel_SetTransparent("TitanPanelBarButtonHider", TitanPanelGetVar("Position"));

	if (TitanPanelGetVar("AutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	end
	if (TitanPanelGetVar("AuxAutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	end		

end

function TitanPanelBarButton_ToggleAuxDoubleBar()
	if ( TitanPanelGetVar("AuxDoubleBar") == TITAN_PANEL_BARS_SINGLE ) then
		TitanPanelSetVar("AuxDoubleBar", TITAN_PANEL_BARS_DOUBLE);
		TitanPanelAuxBarButtonHider:SetHeight(48);
	else
		TitanPanelSetVar("AuxDoubleBar", TITAN_PANEL_BARS_SINGLE);
		TitanPanelAuxBarButtonHider:SetHeight(24);
	end
	TitanMovableFrame_CheckFrames(TITAN_PANEL_PLACE_BOTTOM);
	TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_BOTTOM, 1);
	TitanMovableFrame_AdjustBlizzardFrames();
	TitanPanel_InitPanelBarButton();
	TitanPanel_InitPanelButtons();		
	TitanPanel_SetTransparent("TitanPanelAuxBarButtonHider", TITAN_PANEL_PLACE_BOTTOM);

	if (TitanPanelGetVar("AutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	end
	if (TitanPanelGetVar("AuxAutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TitanPanelGetVar("Position"));
	end		

end

function TitanPanelBarButton_ToggleAutoHide()
	TitanPanelToggleVar("AutoHide");
	if (TitanPanelGetVar("AutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	else
		TitanPanelBarButton_Show("TitanPanelBarButton", TitanPanelGetVar("Position"));
	end
	TitanPanelAutoHideButton_SetIcon();
	
	if (TitanPanelGetVar("BothBars")) then
	 if TitanPanelGetVar("AuxAutoHide") then
	   TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	 end
	 if TitanPanelGetVar("AutoHide") then
	   TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	 end
	else
	 if TitanPanelGetVar("AuxAutoHide") then
	   TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	 end
	 if TitanPanelGetVar("AutoHide") then
	   TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	 end
	end
end

function TitanPanelBarButton_ToggleAuxAutoHide()
	TitanPanelToggleVar("AuxAutoHide");
	if (TitanPanelGetVar("AuxAutoHide")) then
		if TitanPanelGetVar("BothBars") then
			TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
		end
	else
		if TitanPanelGetVar("BothBars") then
			TitanPanelBarButton_Show("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
		end
	end
	--Needs changing!
	TitanPanelAuxAutoHideButton_SetIcon();
end

function TitanPanelBarButton_ToggleScreenAdjust()
	TitanPanelToggleVar("ScreenAdjust");
	TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
	TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"), TitanPanelGetVar("ScreenAdjust"));
	TitanMovableFrame_AdjustBlizzardFrames();
end

function TitanPanelBarButton_ToggleAuxScreenAdjust()
	TitanPanelToggleVar("AuxScreenAdjust");
	TitanMovableFrame_CheckFrames(TITAN_PANEL_PLACE_BOTTOM);
	TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_BOTTOM, TitanPanelGetVar("AuxScreenAdjust"));
	TitanMovableFrame_AdjustBlizzardFrames();
end

function TitanPanelBarButton_TogglePosition()
	if (TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP) then
		TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
		TitanPanelSetVar("Position", TITAN_PANEL_PLACE_BOTTOM);
		TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"), TitanPanelGetVar("ScreenAdjust"));		
	else
		TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
		TitanPanelSetVar("Position", TITAN_PANEL_PLACE_TOP);
		TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"), TitanPanelGetVar("ScreenAdjust"));
	end
	
	-- Set panel position and texture
	TitanPanel_SetPosition("TitanPanelBarButton", TitanPanelGetVar("Position"));
	TitanPanel_SetTexture("TitanPanelBarButton", TitanPanelGetVar("Position"));
	TitanPanel_SetTransparent("TitanPanelBarButtonHider", TitanPanelGetVar("Position"));
	
	-- Adjust frame positions
	TitanMovableFrame_CheckFrames(TitanPanelGetVar("Position"));
	TitanMovableFrame_MoveFrames(TitanPanelGetVar("Position"), TitanPanelGetVar("ScreenAdjust"));
	TitanMovableFrame_AdjustBlizzardFrames();
	TitanPanelButton_Justify();

end

function TitanPanelBarButton_ToggleBarsShown()
	TitanPanelToggleVar("BothBars");
	TitanPanelBarButton_DisplayBarsWanted();
	TitanPanelRightClickMenu_Close();
	-- routine to handle autohide
	-- new	
	 if TitanPanelGetVar("AuxAutoHide") then
	   TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	 end
	 if TitanPanelGetVar("AutoHide") then
	   TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	 end	
end

function TitanPanelBarButton_ForceLDBLaunchersRight()
	local plugin, index, id;
	for index, id in pairs(TitanPluginsIndex) do
		plugin = TitanUtils_GetPlugin(id);
		if plugin.ldb == "launcher" and not TitanGetVar(id, "DisplayOnRightSide") then
			TitanToggleVar(id, "DisplayOnRightSide");
			local button = TitanUtils_GetButton(id);
			local buttonText = _G[button:GetName().."Text"];
			if not TitanGetVar(id, "ShowIcon") then
				TitanToggleVar(id, "ShowIcon");	
			end
			TitanPanelButton_UpdateButton(id);
			if buttonText then
				buttonText:SetText("")
				button:SetWidth(16);
				TitanPlugins[id].buttonTextFunction = nil;
				_G["TitanPanel"..id.."ButtonText"] = nil;
				if button:IsVisible() then
					TitanPanel_RemoveButton(id);
					TitanPanel_AddButton(id);
				end
			end
		end
	end
end
	
function TitanPanelBarButton_DisplayBarsWanted()
	--Need to handle top & bottom
	if (TitanPanelGetVar("BothBars")) then
		if (TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_BOTTOM) then
			TitanPanelBarButton_TogglePosition();
		end

		TitanMovableFrame_CheckFrames(TITAN_PANEL_PLACE_TOP);
		TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_TOP, TitanPanelGetVar("ScreenAdjust"));

		-- Set panel position and texture
		TitanPanel_SetPosition("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
		TitanPanel_SetTexture("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	
		-- Adjust frame positions
		TitanMovableFrame_CheckFrames(TITAN_PANEL_PLACE_BOTTOM);
		TitanMovableFrame_MoveFrames(TITAN_PANEL_PLACE_BOTTOM, TitanPanelGetVar("AuxScreenAdjust"));
		TitanMovableFrame_AdjustBlizzardFrames();
		-- Show TitanPanelAuxBarButtonHider frame
		TitanPanelAuxBarButtonHider:Show()
		TitanPanel_SetTransparent("TitanPanelAuxBarButtonHider", TITAN_PANEL_PLACE_BOTTOM);
	else
		TitanPanelBarButton_TogglePosition();
		TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM)
		TitanPanelBarButton_TogglePosition();
		-- Hide TitanPanelAuxBarButtonHider frame to avoid interaction problem at the bottom of the screen
		TitanPanelAuxBarButtonHider:Hide()
	end
end

function TitanPanelBarButton_Show(frame, position)
	local frName = _G[frame];
	local barnumber = TitanUtils_GetDoubleBar(TitanPanelGetVar("BothBars"), position);

	if (position == TITAN_PANEL_PLACE_TOP) then
		frName:ClearAllPoints();	
		frName:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 0, 0);
		frName:SetPoint("BOTTOMRIGHT", "UIParent", "TOPRIGHT", 0, -24); 
	else
		frName:ClearAllPoints();
		frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 24); 
	end
	
	frName.hide = nil;
end

function TitanPanelBarButton_Hide(frame, position)
if TITAN_PANEL_MOVING == 1 then return end
	local frName = _G[frame];
	local barnumber = TitanUtils_GetDoubleBar(TitanPanelGetVar("BothBars"), position);

	if frName ~= nil then

		if (position == TITAN_PANEL_PLACE_TOP) then
			frName:ClearAllPoints();
			frName:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 0, (35*barnumber)); 
			frName:SetPoint("BOTTOMRIGHT", "UIParent", "TOPRIGHT", 0, -3);
			
		elseif  (position == TITAN_PANEL_PLACE_BOTTOM) and frame == "TitanPanelBarButton" then
			frName:ClearAllPoints();
			frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, (-35*barnumber)); 
			frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, -35);
		
		else
			if TitanPanelGetVar("BothBars") == nil and frame == "TitanPanelAuxBarButton" then
				frName:ClearAllPoints();
				frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, (-35*barnumber)); 
				frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, -35);
			else
				frName:ClearAllPoints();
				frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, (-35*barnumber)); 
				frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, -35);
			end
		end
	
		frName.hide = 1;
	end
end

function TitanPanel_InitPanelBarButton()
	-- Set initial Panel Scale
	TitanPanel_SetScale();
	-- Create textures for the first time
	if numOfTextures == 0 then TitanPanel_CreateBarTextures() end

	-- Set Titan Panel position/textures
	TitanPanel_SetPosition("TitanPanelBarButton", TitanPanelGetVar("Position"));
	TitanPanel_SetTexture("TitanPanelBarButton", TitanPanelGetVar("Position"));
	-- Reposition textures if needed
	TitanPanel_CreateBarTextures()
	
	-- Set initial Panel Transparency
	TitanPanelBarButton:SetAlpha(TitanPanelGetVar("Transparency"));		
	TitanPanelAuxBarButton:SetAlpha(TitanPanelGetVar("AuxTransparency"));		
end

function TitanPanel_SetPosition(frame, position)
	local frName = _G[frame];
	if (position == TITAN_PANEL_PLACE_TOP) then
		if frame == "TitanPanelBarButton" then			
			local titanTexture = _G["TitanPanelBackground"..numOfTextures + 1]			
			titanTexture:ClearAllPoints();
			titanTexture:SetPoint("BOTTOMLEFT", "TitanPanelBackground0", "BOTTOMLEFT", 0, -24);
		end
		frName:ClearAllPoints();
		frName:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 0, 0);
		frName:SetPoint("BOTTOMRIGHT", "UIParent", "TOPRIGHT", 0, -24);	
	else
		if frame == "TitanPanelBarButton" then
			local titanTexture = _G["TitanPanelBackground"..numOfTextures + 1]			
			titanTexture:ClearAllPoints();
			titanTexture:SetPoint("BOTTOMLEFT", "TitanPanelBackground0", "BOTTOMLEFT", 0, 24);
		end
		frName:ClearAllPoints();
		frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 24); 
	end
end

function TitanPanel_SetTransparent(frame, position)
	local frName = _G[frame];
	local topBars = TitanUtils_GetDoubleBar(TitanPanelGetVar("BothBars"), TITAN_PANEL_PLACE_TOP);
	local bottomBars = TitanUtils_GetDoubleBar(TitanPanelGetVar("BothBars"), TITAN_PANEL_PLACE_BOTTOM);
	
	if (position == TITAN_PANEL_PLACE_TOP) then
		frName:ClearAllPoints();
		frName:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 0, 0);
		frName:SetPoint("BOTTOMRIGHT", "UIParent", "TOPRIGHT", 0, -24 * topBars);
		TitanPanelAuxBarButtonHider:ClearAllPoints();
		TitanPanelAuxBarButtonHider:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		TitanPanelAuxBarButtonHider:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 24 * bottomBars); 
	elseif position == TITAN_PANEL_PLACE_BOTTOM and frame == "TitanPanelBarButtonHider" then
		frName:ClearAllPoints();
		frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 24 * bottomBars); 
		TitanPanelAuxBarButtonHider:ClearAllPoints();
		TitanPanelAuxBarButtonHider:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		TitanPanelAuxBarButtonHider:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 0); 
	else
		frName:ClearAllPoints();
		frName:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0); 
		frName:SetPoint("TOPRIGHT", "UIParent", "BOTTOMRIGHT", 0, 24 * bottomBars); 
	end
end

function TitanPanel_SetTexture(frame, position)
	local frName = _G[frame];
	local barnumber = TitanUtils_GetDoubleBar(TitanPanelGetVar("BothBars"), position);
	
	if frame == "TitanPanelBarButton" then
		local pos = TitanUtils_Ternary(position == TITAN_PANEL_PLACE_TOP, "Top", "Bottom");
		for i = 0, numOfTextures do
			_G["TitanPanelBackground"..i]:SetTexture(TitanPanelGetVar("TexturePath").."TitanPanelBackground"..pos..math.fmod(i, 2));			
		end
		for i = numOfTextures + 1, numOfTexturesHider do
			if barnumber == 2 then
				TitanPanelBarButtonHider:SetHeight(48);
				_G["TitanPanelBackground"..i]:SetTexture(TitanPanelGetVar("TexturePath").."TitanPanelBackground"..pos..math.fmod(i, 2));				
			else
				TitanPanelBarButtonHider:SetHeight(24);
				_G["TitanPanelBackground"..i]:SetTexture();				
			end
		end
	else
		local pos = TitanUtils_Ternary(position == TITAN_PANEL_PLACE_BOTTOM, "Top", "Bottom");		
		for i = 0, numOfTextures do
			_G["TitanPanelBackgroundAux"..i]:SetTexture(TitanPanelGetVar("TexturePath").."TitanPanelBackground".."Bottom"..math.fmod(i, 2));
		end		
		for i = numOfTextures + 1, numOfTexturesHider do
			if barnumber == 2 then
				TitanPanelAuxBarButtonHider:SetHeight(48);
				_G["TitanPanelBackgroundAux"..i]:SetTexture(TitanPanelGetVar("TexturePath").."TitanPanelBackground".."Bottom"..math.fmod(i, 2));
			else
				TitanPanelAuxBarButtonHider:SetHeight(24);
				_G["TitanPanelBackgroundAux"..i]:SetTexture();
			end
		end
	end
end

local function TitanPanel_ToRight(id)
-- See if the plugin is to be on the right.
-- There are 3 methods to place a plugin on the right:
-- 1) DisplayOnRightSide saved variable logic (preferred)
-- 2) Create a plugin button using the TitanPanelIconTemplate
-- 3) Place a plugin in TITAN_PANEL_NONMOVABLE_PLUGINS (NOT preferred)
--
	local found = nil
	for index, _ in ipairs(TITAN_PANEL_NONMOVABLE_PLUGINS) do
		if id == TITAN_PANEL_NONMOVABLE_PLUGINS[index] then
			found = true;
		end
	end

	if TitanGetVar(id, "DisplayOnRightSide")
	or TitanPanelButton_IsIcon(id) 
	then
		found = true
	end
	
	return found
end

function TitanPanel_InitPanelButtons()
	local button, leftButton, rightButton, leftAuxButton, rightAuxButton, 
		leftDoubleButton, rightDoubleButton, leftAuxDoubleButton, rightAuxDoubleButton;
	local r_y_offset, r_button_name, r_rel_anchor, r_x_offset, r_prior, r_right
	local nextLeft, nextAuxLeft
	local leftside, auxleftside;	
	local scale = TitanPanelGetVar("Scale");
	local isClockOnRightSide;
	newButtons = {};
	newLocations = {};
	
	if not TITAN_PANEL_MOVE_ADDON then
		TitanPanelBarButton_DisplayBarsWanted();
	end
	-- routine to handle autohide in case that was changed
	if TitanPanelGetVar("AuxAutoHide") then
		TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	end
	if TitanPanelGetVar("AutoHide") then
		TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	end

	-- Position all the buttons 
	for i = 1, table.maxn(TitanPanelSettings.Buttons) do 
	
		local id = TitanPanelSettings.Buttons[i];
		if ( TitanUtils_IsPluginRegistered(id) ) then
			local i = TitanPanel_GetButtonNumber(id);
			button = TitanUtils_GetButton(id);

			-- If the button has asked to be on the right
			if TitanPanel_ToRight(id) then	
				-- This helps ensure both bars are treated the same wrt right side plugins.
				--
				-- set the 'prior' button based on the bar that the current plugin is located.
				if ( TitanPanelSettings.Location[i] == "AuxBar" ) then
					r_prior = rightAuxButton
				else
					r_prior = rightButton
				end
				-- =========================
				-- This section determines all the anchor points and offests so the plugin can be positioned correctly.
				if r_prior then -- anchor frame
					-- relative to the prior plugin
					r_button_name = r_prior:GetName()
-- trying to figure out why a singel L side plugin puts the R side plugin on the L...
--r_right = r_prior:GetRight()
				else
					-- relative to self
					r_button_name = "TitanPanel" .. TitanPanelSettings.Location[i] .."Button"
--r_right = r_button_name:GetRight()
				end
				-- Ternary: if rightAuxButton then prior button else first button
				r_rel_anchor = TitanUtils_Ternary(r_prior,
									"LEFT",   -- left of the prior plugin
									"RIGHT")  -- reference itself
				r_x_offset = TitanUtils_Ternary(r_prior,
									(-TITAN_PANEL_ICON_SPACING * scale),  -- space between plugins
									(-(TitanPanelGetVar("ButtonSpacing")) / 2 * scale)) -- give some space from the right edge
				r_y_offset = TitanUtils_Ternary(r_prior,
									0, -- use offset of prior button
									1) -- first button - offset to bar
				-- =========================
				-- position the plugin
				button:ClearAllPoints();
				button:SetPoint("RIGHT", r_button_name, r_rel_anchor, r_x_offset, r_y_offset); 

--[[
TitanDebug("InitButtons: "
.."| id:'"..(id or "?").."' "
.."| button:'"..(button:GetName() or "?").."' "
.."| r:'"..(button:GetRight() or "?").."' "
.."| R:'"..(TitanGetVar(id, "DisplayOnRightSide") and "true" or "false").."' "
.."| icon:'"..(TitanPanelButton_IsIcon(id) and "true" or "false").."' "
.."| anch:'"..(r_rel_anchor or "false").."' "
.."| x:'"..(r_x_offset or "false").."' "
.."| y:'"..(r_y_offset or "false").."' "
.."| r_button:'"..(r_button_name or "?").."' "
.."| r:'"..(r_right or "?").."' "
.."| top:'"..(TITAN_PANEL_FROM_TOP_MAIN or "?").."' "
.."| bot:'"..(TITAN_PANEL_FROM_BOTTOM_MAIN or "?").."' "
)
--]]
				-- capture the button for the next right side button
				if TitanPanelSettings.Location[i] == "AuxBar" then
					rightAuxButton = button
				else
					rightButton = button
				end
			else
--[[
TitanDebug("InitButtons: "
.."| id:'"..(id or "?").."'"
.."| L side:'"..(not (TitanGetVar(id, "DisplayOnRightSide")) and "true" or "false").."'"
.."| icon:'"..(TitanPanelButton_IsIcon(id) and "true" or "false").."'"
)
--]]
				--  handle buttons on the left side of the bar
				--
				-- Aux bar
				if ( TitanPanelSettings.Location[i] == "AuxBar" ) then
					if (nextAuxLeft == "Double") then
						button:ClearAllPoints();
						button:SetPoint("LEFT", leftAuxDoubleButton:GetName(), "RIGHT", (TitanPanelGetVar("ButtonSpacing")) * scale, 0);
						nextAuxLeft = "Main"
						leftAuxDoubleButton = button;
					elseif (nextAuxLeft == "DoubleFirst") then
						button:ClearAllPoints();
						button:SetPoint("LEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", 
							"LEFT", (TitanPanelGetVar("ButtonSpacing")) / 2 * scale, TITAN_PANEL_FROM_BOTTOM);
						nextAuxLeft = "Main"
						leftAuxDoubleButton = button;
					elseif (nextAuxLeft == "Main") then
						button:ClearAllPoints();
						button:SetPoint("LEFT", leftAuxButton:GetName(), "RIGHT", (TitanPanelGetVar("ButtonSpacing")) * scale, 0);
						nextAuxLeft = TitanPanel_Nextbar("AuxDoubleBar");
						leftAuxButton = button;
					else
						button:ClearAllPoints();
						button:SetPoint("LEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", 
							"LEFT", (TitanPanelGetVar("ButtonSpacing")) / 2 * scale, TITAN_PANEL_FROM_BOTTOM_MAIN);
						nextAuxLeft = TitanPanel_Nextbar("AuxDoubleBar");
						if nextAuxLeft == "Double" then
							nextAuxLeft = "DoubleFirst";
						end
						leftAuxButton = button;
					end
				else -- Main bar
					if (nextLeft == "Double") then
						button:ClearAllPoints();
						button:SetPoint("LEFT", leftDoubleButton:GetName(), "RIGHT", (TitanPanelGetVar("ButtonSpacing")) * scale, 0);
						nextLeft = "Main"
						leftDoubleButton = button;
					elseif (nextLeft == "DoubleFirst") then
						button:ClearAllPoints();
						if TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP then
							button:SetPoint("LEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", 
								"LEFT", (TitanPanelGetVar("ButtonSpacing")) / 2 * scale, TITAN_PANEL_FROM_TOP);
						else
							button:SetPoint("LEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", 
								"LEFT", (TitanPanelGetVar("ButtonSpacing")) / 2 * scale, TITAN_PANEL_FROM_BOTTOM);
						end
						nextLeft = "Main"
						leftDoubleButton = button;
					elseif (nextLeft == "Main") then
						button:ClearAllPoints();
						button:SetPoint("LEFT", leftButton:GetName(), "RIGHT", (TitanPanelGetVar("ButtonSpacing")) * scale, 0);
						nextLeft = TitanPanel_Nextbar("DoubleBar");
						leftButton = button;
					else
						button:ClearAllPoints();
						button:SetPoint("LEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", 
							"LEFT", (TitanPanelGetVar("ButtonSpacing")) / 2 * scale, TITAN_PANEL_FROM_TOP_MAIN);
						nextLeft = TitanPanel_Nextbar("DoubleBar");
						if nextLeft == "Double" then
							nextLeft = "DoubleFirst";
						end
						leftButton = button;
					end
				end

			end
			table.insert(newButtons, id);
			table.insert(newLocations, TitanPanelSettings.Location[i]);
			button:Show();
		end
	end
	
	-- Set panel button init flag
	TITAN_PANEL_BUTTONS_INIT_FLAG = 1;
	TitanPanelButton_Justify();
end

function TitanPanel_Nextbar(var)
	if TitanPanelGetVar(var) == TITAN_PANEL_BARS_DOUBLE then
		return "Double";
	else
		return "Main";
	end
end

function TitanPanel_RemoveButton(id)
	if ( not TitanPanelSettings ) then
		return;
	end 

	local i = TitanPanel_GetButtonNumber(id)
	local currentButton = TitanUtils_GetButton(id);
	--currentButton:Hide();	
	
	-- safeguard to destroy any active plugin timers based on a fixed naming convention : TitanPanel..id, eg. "TitanPanelClock"
	-- this prevents "rogue" timers being left behind by lack of an OnHide check		
	if id then AceTimer.CancelAllTimers("TitanPanel"..id) end

	TitanPanel_ReOrder(i);
	table.remove(TitanPanelSettings.Buttons, TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons, id));
	--table.remove(TitanPanelSettings.Location, i);
	currentButton:Hide();
	TitanPanel_InitPanelButtons();
end

function TitanPanel_AddButton(id)
	TitanUtils_AddButtonOnBar(TITAN_PANEL_SELECTED, id)
end

function TitanPanel_ReOrder(index)
	for i = index, table.getn(TitanPanelSettings.Buttons) do		
		TitanPanelSettings.Location[i] = TitanPanelSettings.Location[i+1]
	end
end

function TitanPanel_GetButtonNumber(id)
	if (TitanPanelSettings) then
		for i = 1, table.getn(TitanPanelSettings.Buttons) do		
			if(TitanPanelSettings.Buttons[i] == id) then
				return i;
			end	
		end
		return table.getn(TitanPanelSettings.Buttons)+1;
	else
		return 0;
	end
end

function TitanPanel_RefreshPanelButtons()
	if (TitanPanelSettings) then
		for i = 1, table.getn(TitanPanelSettings.Buttons) do		
			TitanPanelButton_UpdateButton(TitanPanelSettings.Buttons[i], 1);		
		end
	end
end

function TitanPanelButton_Justify()	
	if ( not TITAN_PANEL_BUTTONS_INIT_FLAG or not TitanPanelSettings ) then
		return;
	end

	local firstLeftButton = TitanUtils_GetButton(TitanPanelSettings.Buttons[TitanUtils_GetFirstButtonOnBar ("Bar", "Left")]) 
	-- TitanUtils_GetFirstButton(TitanPanelSettings.Buttons, 1, nil, nil);
	local secondLeftButton;
	local scale = TitanPanelGetVar("Scale");
	local leftWidth = 0;
	local rightWidth = 0;
	local leftDoubleWidth = 0;
	local rightDoubleWidth = 0;
	local counter = 0;
	local triggered = 0;
	if ( firstLeftButton ) then
		if ( TitanPanelGetVar("ButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_LEFT ) then
			counter = 0;
			triggered = 0;
			for index, id in pairs(TitanPanelSettings.Buttons) do
				local button = TitanUtils_GetButton(id);
					if button and button:GetWidth() then	
						
						if TitanUtils_GetWhichBar(id) == "Bar" then
							if TitanPanelGetVar("DoubleBar") == 2 and mod(counter,2) == 1 and not TitanPanelButton_IsIcon(id) then
								if triggered == 0 then
									secondLeftButton = button;
									triggered = 1;
								end
							end
							if ( TitanPanelButton_IsIcon(id) or (TitanGetVar(id, "DisplayOnRightSide")) ) then
								-- Do nothing
							else
								counter = counter + 1;
							end
						end
					end
			end

			firstLeftButton:ClearAllPoints();
			firstLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "LEFT", (TitanPanelGetVar("ButtonSpacing")) / 2 * scale, TITAN_PANEL_FROM_TOP_MAIN); 
			if triggered == 1 then
				secondLeftButton:ClearAllPoints();
				if TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP then
					secondLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "LEFT", (TitanPanelGetVar("ButtonSpacing")) / 2 * scale, TITAN_PANEL_FROM_TOP);
				else
					secondLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "LEFT", (TitanPanelGetVar("ButtonSpacing")) / 2 * scale, TITAN_PANEL_FROM_BOTTOM);
				end
			end

		elseif ( TitanPanelGetVar("ButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER ) then
			leftWidth = 0;
			rightWidth = 0;
			leftDoubleWidth = 0;
			rightDoubleWidth = 0;
			counter = 0;
			triggered = 0;
			for index, id in pairs(TitanPanelSettings.Buttons) do
				local button = TitanUtils_GetButton(id);
					if button and button:GetWidth() then
					
						if TitanUtils_GetWhichBar(id) == "Bar" then
							if TitanPanelGetVar("DoubleBar") == 2 and mod(counter,2) == 1 and not TitanPanelButton_IsIcon(id) then
								if triggered == 0 then
									secondLeftButton = button;
									triggered = 1;
								end
								if ( TitanPanelButton_IsIcon(id) or (TitanGetVar(id, "DisplayOnRightSide")) ) then
									rightDoubleWidth = rightDoubleWidth + TITAN_PANEL_ICON_SPACING + button:GetWidth();
								else
									counter = counter + 1;
									leftDoubleWidth = leftDoubleWidth + (TitanPanelGetVar("ButtonSpacing")) + button:GetWidth();
								end
							else
								if ( TitanPanelButton_IsIcon(id) or (TitanGetVar(id, "DisplayOnRightSide")) ) then
									rightWidth = rightWidth + TITAN_PANEL_ICON_SPACING + button:GetWidth();
								else
									counter = counter + 1;
									leftWidth = leftWidth + (TitanPanelGetVar("ButtonSpacing")) + button:GetWidth();
								end
							end
						end
					end
			end

			firstLeftButton:ClearAllPoints();
			firstLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "CENTER", 0 - leftWidth / 2, TITAN_PANEL_FROM_TOP_MAIN); 
			if triggered == 1 then
				secondLeftButton:ClearAllPoints();
				if TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP then
					secondLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "CENTER", 0 - leftDoubleWidth / 2, TITAN_PANEL_FROM_TOP);
				else
					secondLeftButton:SetPoint("LEFT", "TitanPanelBarButton", "CENTER", 0 - leftDoubleWidth / 2, TITAN_PANEL_FROM_BOTTOM);
				end
			end
		end
	end

	local firstLeftButton = TitanUtils_GetButton(TitanPanelSettings.Buttons[TitanUtils_GetFirstButtonOnBar ("AuxBar", "Left")]) 
	-- TitanUtils_GetFirstAuxButton(TitanPanelSettings.Buttons, 1, nil, nil);
	secondLeftButton = nil;
	if ( firstLeftButton ) then
		if ( TitanPanelGetVar("AuxButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_LEFT ) then
			triggered = 0;
			counter = 0;
			for index, id in pairs(TitanPanelSettings.Buttons) do
				local button = TitanUtils_GetButton(id);
					if button and button:GetWidth() then
						
						if TitanUtils_GetWhichBar(id) == "AuxBar" then
							if TitanPanelGetVar("AuxDoubleBar") == 2 and mod(counter,2) == 1 and not TitanPanelButton_IsIcon(id) then
								if triggered == 0 then
									secondLeftButton = button;
									triggered = 1;
								end
							end
							if ( TitanPanelButton_IsIcon(id) or (TitanGetVar(id, "DisplayOnRightSide")) ) then
								-- Do nothing
							else
								counter = counter + 1;
							end
						end
					end
			end

			firstLeftButton:ClearAllPoints();
			firstLeftButton:SetPoint("LEFT", "TitanPanelAuxBarButton", "LEFT", (TitanPanelGetVar("ButtonSpacing")) / 2 * scale, TITAN_PANEL_FROM_BOTTOM_MAIN); 
			if triggered == 1 then
				secondLeftButton:ClearAllPoints();
				secondLeftButton:SetPoint("LEFT", "TitanPanelAuxBarButton", "LEFT", (TitanPanelGetVar("ButtonSpacing")) / 2 * scale, TITAN_PANEL_FROM_BOTTOM);
			end
		elseif ( TitanPanelGetVar("AuxButtonAlign") == TITAN_PANEL_BUTTONS_ALIGN_CENTER ) then
			leftWidth = 0;
			rightWidth = 0;
			leftDoubleWidth = 0;
			rightDoubleWidth = 0;
			counter = 0;
			triggered = 0;
			for index, id in pairs(TitanPanelSettings.Buttons) do
				local button = TitanUtils_GetButton(id);
					if button and button:GetWidth() then
						
						if TitanUtils_GetWhichBar(id) == "AuxBar" then
							if TitanPanelGetVar("AuxDoubleBar") == 2 and mod(counter,2) == 1 and not TitanPanelButton_IsIcon(id) then
								if triggered == 0 then
									secondLeftButton = button;
									triggered = 1;
								end
								if ( TitanPanelButton_IsIcon(id) or (TitanGetVar(id, "DisplayOnRightSide")) ) then
									rightDoubleWidth = rightDoubleWidth + TITAN_PANEL_ICON_SPACING + button:GetWidth();
								else
									counter = counter + 1;
									leftDoubleWidth = leftDoubleWidth + (TitanPanelGetVar("ButtonSpacing")) + button:GetWidth();
								end
							else
								if ( TitanPanelButton_IsIcon(id) or (TitanGetVar(id, "DisplayOnRightSide")) ) then
									rightWidth = rightWidth + TITAN_PANEL_ICON_SPACING + button:GetWidth();
								else
									counter = counter + 1;
									leftWidth = leftWidth + (TitanPanelGetVar("ButtonSpacing")) + button:GetWidth();
								end
							end
						end
					end
			end

			firstLeftButton:ClearAllPoints();
			firstLeftButton:SetPoint("LEFT", "TitanPanelAuxBarButton", "CENTER", 0 - leftWidth / 2, TITAN_PANEL_FROM_BOTTOM_MAIN); 
			if triggered == 1 then
				secondLeftButton:ClearAllPoints();
				secondLeftButton:SetPoint("LEFT", "TitanPanelAuxBarButton", "CENTER", 0 - leftDoubleWidth / 2, TITAN_PANEL_FROM_BOTTOM);
			end
		end
	end

end

function TitanPanel_SetScale()
	local scale = TitanPanelGetVar("Scale");
	TitanPanelBarButton:SetScale(scale);
	TitanPanelAuxBarButton:SetScale(scale);

	for index, value in pairs(TitanPlugins) do
		if index then
			TitanUtils_GetButton(index):SetScale(scale);
		end
	end
end

function TitanPanel_LoadError(ErrorMsg) 
	StaticPopupDialogs["LOADING_ERROR"] = {
		text = ErrorMsg,
		button1 = TEXT(OKAY),
		showAlert = 1,
		timeout = 0,
	};
	StaticPopup_Show("LOADING_ERROR");
end

function TitanPanel_ResetToDefault()
	StaticPopupDialogs["TITAN_RESET_BAR"] = {
	text = TitanUtils_GetNormalText(L["TITAN_PANEL_MENU_TITLE"]).."\n\n"..L["TITAN_PANEL_RESET_WARNING"],
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		TitanPanel_ResetBar();
		end,	
	showAlert = 1,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
	};
	StaticPopup_Show("TITAN_RESET_BAR");
end

function TitanPanel_TicketReload()
	StaticPopupDialogs["TITAN_RELOAD"] = {
		text = TitanUtils_GetNormalText(L["TITAN_PANEL_MENU_TITLE"]).."\n\n"..L["TITAN_PANEL_RELOAD"],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = function(self)
			TitanPanelToggleVar("TicketAdjust");
			ReloadUI();
			end,	
		showAlert = 1,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1
	};
	StaticPopup_Show("TITAN_RELOAD");
end

function TitanPanel_SaveCustomProfile()

StaticPopupDialogs["TITAN_RELOADUI"] = {
		text = TitanUtils_GetNormalText(L["TITAN_PANEL_MENU_TITLE"]).."\n\n"..L["TITAN_PANEL_MENU_PROFILE_RELOADUI"],
		button1 = TEXT(OKAY),
		OnAccept = function(self)
		ReloadUI();
		end,
		showAlert = 1,
		whileDead = 1,
		timeout = 0,
	};
	
StaticPopupDialogs["TITAN_OVERWRITE_CUSTOM_PROFILE"] = {
	text = TitanUtils_GetNormalText(L["TITAN_PANEL_MENU_TITLE"]).."\n\n"..L["TITAN_PANEL_MENU_PROFILE_ALREADY_EXISTS"],
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self, data)
		local playerName = UnitName("player");
		local serverName = GetCVar("realmName");
		local currentprofilevalue = playerName.."@"..serverName;
		local profileName = data.."@".."TitanCustomProfile";
		TitanPanelSettings.Buttons = newButtons;
		TitanPanelSettings.Location = newLocations;
		TitanSettings.Players[profileName] = TitanSettings.Players[currentprofilevalue];
		DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_TITLE"].._G["FONT_COLOR_CODE_CLOSE"]..": "..L["TITAN_PANEL_MENU_PROFILE_SAVE_PENDING"].."|cffff8c00"..data.."|r");
		self:Hide();
		StaticPopup_Show("TITAN_RELOADUI");
	end,
	showAlert = 1,
	whileDead = 1,
	timeout = 0,
	hideOnEscape = 1
};
	
	StaticPopupDialogs["TITAN_SAVE_CUSTOM_PROFILE"] = {
	text = TitanUtils_GetNormalText(L["TITAN_PANEL_MENU_TITLE"]).."\n\n"..L["TITAN_PANEL_MENU_PROFILE_SAVE_CUSTOM_TITLE"],
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	maxLetters = 20,
	OnAccept = function(self)
	  local rawprofileName = self.editBox:GetText();
	  local conc2profileName = string.gsub( rawprofileName, " ", "" );
	  if conc2profileName == "" then return; end
	  local concprofileName = string.gsub( conc2profileName, "@", "-" );
	  local profileName = concprofileName.."@".."TitanCustomProfile";
		if TitanSettings.Players[profileName] then			
			local dialogFrame = StaticPopup_Show("TITAN_OVERWRITE_CUSTOM_PROFILE", concprofileName);
				if dialogFrame then
					dialogFrame.data = concprofileName;
				end
			return;
		else
			local playerName = UnitName("player");
			local serverName = GetCVar("realmName");
			local currentprofilevalue = playerName.."@"..serverName;
			TitanPanelSettings.Buttons = newButtons;
			TitanPanelSettings.Location = newLocations;
			TitanSettings.Players[profileName] = TitanSettings.Players[currentprofilevalue];
			DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_TITLE"].._G["FONT_COLOR_CODE_CLOSE"]..": "..L["TITAN_PANEL_MENU_PROFILE_SAVE_PENDING"].."|cffff8c00"..concprofileName.."|r");
			self:Hide();
			StaticPopup_Show("TITAN_RELOADUI");
		end
	end,
	OnShow = function(self)
		self.editBox:SetFocus();
	end,
	OnHide = function(self)
--		if ( ChatFrame1EditBox:IsShown() ) then
--			ChatFrame1EditBox:SetFocus();
--		end
		self.editBox:SetText("");
	end,
	EditBoxOnEnterPressed = function(self)
		local parent = self:GetParent();
		local rawprofileName = parent.editBox:GetText();		
		local conc2profileName = string.gsub( rawprofileName, " ", "" );
		if conc2profileName == "" then return; end
	  local concprofileName = string.gsub( conc2profileName, "@", "-" );
	  local profileName = concprofileName.."@".."TitanCustomProfile";
		if TitanSettings.Players[profileName] then			
			local dialogFrame = StaticPopup_Show("TITAN_OVERWRITE_CUSTOM_PROFILE", concprofileName);
				if dialogFrame then
					dialogFrame.data = concprofileName;
				end
			parent:Hide();
			return;
		else
			local playerName = UnitName("player");
			local serverName = GetCVar("realmName");
			local currentprofilevalue = playerName.."@"..serverName;
			TitanPanelSettings.Buttons = newButtons;
			TitanPanelSettings.Location = newLocations;
			TitanSettings.Players[profileName] = TitanSettings.Players[currentprofilevalue];
			DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_TITLE"].._G["FONT_COLOR_CODE_CLOSE"]..": "..L["TITAN_PANEL_MENU_PROFILE_SAVE_PENDING"].."|cffff8c00"..concprofileName.."|r");			
		end
		parent:Hide();
		StaticPopup_Show("TITAN_RELOADUI");
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

	StaticPopup_Show("TITAN_SAVE_CUSTOM_PROFILE");
end

function TitanPanel_SetCustomTexture(path)
	if path ~= TitanPanelGetVar("TexturePath") then
		TitanPanelSetVar("TexturePath", path);
		TitanPanel_SetTexture("TitanPanelBarButton", TITAN_PANEL_PLACE_TOP);
		TitanPanel_SetTexture("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	end
end

function TitanPanelRightClickMenu_PrepareBarMenu(self)		
	-- Level 2
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
--		TitanPanel_BuildPluginsMenu();
		TitanPanel_BuildOtherPluginsMenu();
		TitanPanel_ServerSettingsMenu();
		return;
	end
	
	-- Level 3
	if ( UIDROPDOWNMENU_MENU_LEVEL == 3 ) then
		TitanPanel_PlayerSettingsMenu();
		return;
	end
	
	-- Level 4
	if ( UIDROPDOWNMENU_MENU_LEVEL == 4 ) then
		TitanPanel_SettingsSelectionMenu();
		return;
	end

	-- Level 1
	TitanPanel_MainMenu(self)
end

function TitanPanel_MainMenu(self)	
	local info = {};
	local TITAN_PANEL_BUTTONS_PLUGIN_CATEGORY = {"Built-ins", "General","Combat","Information","Interface","Profession"}
	local checked, plugin;
	local frame = self:GetParent():GetName();

	TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_MENU_TITLE"]);
	TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
	
	TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_MENU_PLUGINS"]);

	-- Plugin Categories
	for index, id in pairs(L["TITAN_PANEL_MENU_CATEGORIES"]) do
		info = {};
		info.text = L["TITAN_PANEL_MENU_CATEGORIES"][index];
		info.value = "Addons_" .. TITAN_PANEL_BUTTONS_PLUGIN_CATEGORY[index];
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info);
	end

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_MENU_CONFIGURATION"]);
	-- Plugins
 	info = {};
	info.text = L["TITAN_PANEL_MENU_PLUGINS"]
	info.value = "Plugins";	
	info.func = function() InterfaceOptionsFrame_OpenToCategory(L["TITAN_PANEL_MENU_PLUGINS"]) end
	UIDropDownMenu_AddButton(info);

	-- Options
 	info = {};
	info.text = L["TITAN_PANEL_MENU_OPTIONS_BARS"];
	info.value = "Bars";	
	info.func = function() InterfaceOptionsFrame_OpenToCategory(L["TITAN_PANEL_MENU_OPTIONS_BARS"]) end
	UIDropDownMenu_AddButton(info);
 	info = {};
	info.text = L["TITAN_PANEL_MENU_OPTIONS"];
	info.value = "Options";	
	info.func = function() InterfaceOptionsFrame_OpenToCategory(L["TITAN_PANEL_MENU_OPTIONS"]) end
	UIDropDownMenu_AddButton(info);

	-- panel control menu
	info = {};
	info.text = L["TITAN_UISCALE_MENU_TEXT"];
	info.value = "PanelControl";	
	info.func = function() InterfaceOptionsFrame_OpenToCategory(L["TITAN_UISCALE_MENU_TEXT"]) end
	UIDropDownMenu_AddButton(info);
	
	-- transparency menu
	info = {};
	info.text = L["TITAN_TRANS_MENU_TEXT_SHORT"];
	info.value = "Transparency";
	info.func = function() InterfaceOptionsFrame_OpenToCategory(L["TITAN_TRANS_MENU_TEXT_SHORT"]) end
	UIDropDownMenu_AddButton(info);
	
	-- texture settings option menu
	info = {};
	info.text = L["TITAN_PANEL_MENU_TEXTURE_SETTINGS"];
	info.value = "SkinSettings";
	info.func = function() InterfaceOptionsFrame_OpenToCategory(L["TITAN_PANEL_MENU_TEXTURE_SETTINGS"]) end
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_MENU_PROFILES"]);
	
	-- Load/Delete
	info = {};
	info.text = L["TITAN_PANEL_MENU_MANAGE_SETTINGS"];
	info.value = "Settings";
	info.hasArrow = 1;
	-- lock this menu in combat
	if InCombatLockdown() then
		info.disabled = 1;
		info.hasArrow = nil;
		info.text = info.text.." ".._G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_IN_COMBAT_LOCKDOWN"];
		end
	UIDropDownMenu_AddButton(info);
	
	-- Save
	info = {};
	info.text = L["TITAN_PANEL_MENU_SAVE_SETTINGS"];
	info.value = "SettingsCustom";
	info.func = TitanPanel_SaveCustomProfile;
	-- lock this menu in combat
	if InCombatLockdown() then
		info.disabled = 1;
		info.text = info.text.." ".._G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_IN_COMBAT_LOCKDOWN"];
		end
	UIDropDownMenu_AddButton(info);
end

function TitanPanel_ServerSettingsMenu()
	local info = {};
	local servers = {};
	local player = nil;
	local server = nil;
	local s, e, ident;
	local setonce = 0;

	if ( UIDROPDOWNMENU_MENU_VALUE == "Settings" ) then
	TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_MENU_PROFILE_SERVERS"], UIDROPDOWNMENU_MENU_LEVEL);
		for index, id in pairs(TitanSettings.Players) do
			s, e, ident = string.find(index, "@");
			if s ~= nil then
				server = string.sub(index, s+1);
				player = string.sub(index, 1, s-1);
			else
				server = "Unknown";
				player = "Unknown";
			end
			
			if TitanUtils_GetCurrentIndex(servers, server) == nil then
			  -- regular profile
				if server ~= "TitanCustomProfile" then
				table.insert(servers, server);	
				info = {};
				info.text = server;
				info.value = server;
				info.hasArrow = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end
						
			for index, id in pairs(TitanSettings.Players) do
			s, e, ident = string.find(index, "@");
			if s ~= nil then
				server = string.sub(index, s+1);
				player = string.sub(index, 1, s-1);
			else
				server = "Unknown";
				player = "Unknown";
			end
			
			if TitanUtils_GetCurrentIndex(servers, server) == nil then
			  -- custom profile
				if server == "TitanCustomProfile" then
				if setonce and setonce == 0 then
					TitanPanelRightClickMenu_AddTitle("", UIDROPDOWNMENU_MENU_LEVEL);
					TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_MENU_PROFILE_CUSTOM"], UIDROPDOWNMENU_MENU_LEVEL);
				setonce = 1;
				end
				info = {};
				info.text = player;
				info.value = player;
				info.hasArrow = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
			end
				
	end
end

function TitanPanel_PlayerSettingsMenu()
	-- there are 2 level 3 menus possible
	-- 1) Under profiles, then value could be the server of a saved toon
	-- 2) Under plugins value could be the options of a plugin
	--
	local info = {};
	local player = nil;
	local server = nil;
	local s, e, ident;
	local plugin;
	local setonce = 0;

	-- 
	-- Handle the profiles
	--
	for index, id in pairs(TitanSettings.Players) do
		s, e, ident = string.find(index, "@");
		if s ~= nil then
			server = string.sub(index, s+1);
			player = string.sub(index, 1, s-1);
		else
			server = "Unknown";
			player = "Unknown";
		end
		
		-- handle custom profiles here
		if server == "TitanCustomProfile" and player == UIDROPDOWNMENU_MENU_VALUE then
			info = {};
			info.text = L["TITAN_PANEL_MENU_LOAD_SETTINGS"];
			info.value = index;
			info.func = function() TitanVariables_UseSettings(index)
			TitanPanelSettings.Buttons = newButtons;
			TitanPanelSettings.Location = newLocations;
			end
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			
			info = {};
			info.text = L["TITAN_PANEL_MENU_DELETE_SETTINGS"];
			info.value = index;
			info.func = function()			  
				if TitanSettings.Players[info.value] then
					TitanSettings.Players[info.value] = nil;
					local tempstring = string.find (index, "@");
					local profname =  string.sub(index, 1, tempstring-1);
					DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_TITLE"].._G["FONT_COLOR_CODE_CLOSE"]..": "..L["TITAN_PANEL_MENU_PROFILE"].."|cffff8c00"..profname.."|r"..L["TITAN_PANEL_MENU_PROFILE_DELETED"]);
					if (TitanPanelRightClickMenu_IsVisible()) then
							TitanPanelRightClickMenu_Close();
					end
				end
			end
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		
		-- handle regular profiles here
		if server == UIDROPDOWNMENU_MENU_VALUE then
		 -- Set the label once
		  if setonce and setonce == 0 then
			TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_MENU_PROFILE_CHARS"], UIDROPDOWNMENU_MENU_LEVEL);
			setonce = 1;
			end
			info = {};
			info.text = player;
			info.value = index;
			info.hasArrow = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end		
	end
	
	-- 
	-- Handle the plugins
	--
	for index, id in pairs(TitanPluginsIndex) do
		plugin = TitanUtils_GetPlugin(id);
		if plugin.id and plugin.id == UIDROPDOWNMENU_MENU_VALUE then
			--title
			info = {};
			info.text = TitanPlugins[plugin.id].menuText;
			info.notClickable = 1;
			info.isTitle = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			--ShowIcon
			if plugin.controlVariables.ShowIcon then
				info = {};
				info.text = L["TITAN_PANEL_MENU_SHOW_ICON"];
				info.value = {id, "ShowIcon", nil};
				info.func = function()
					TitanPanelRightClickMenu_ToggleVar({id, "ShowIcon", nil})
					end
				info.keepShownOnClick = 1;
				info.checked = TitanGetVar(id, "ShowIcon");
				info.disabled = nil;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
			
			--ShowLabel
			if plugin.controlVariables.ShowLabelText then
				info = {};
				info.text = L["TITAN_PANEL_MENU_SHOW_LABEL_TEXT"];
				info.value = {id, "ShowLabelText", nil};
				info.func = function()
					TitanPanelRightClickMenu_ToggleVar({id, "ShowLabelText", nil})
					end
				info.keepShownOnClick = 1;
				info.checked = TitanGetVar(id, "ShowLabelText");
				info.disabled = nil;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
			
			--ShowRegularText (LDB data sources only atm)
			if plugin.controlVariables.ShowRegularText then
				info = {};
				info.text = L["TITAN_PANEL_MENU_SHOW_PLUGIN_TEXT"]
				info.value = {id, "ShowRegularText", nil};
				info.func = function()
					TitanPanelRightClickMenu_ToggleVar({id, "ShowRegularText", nil})
					end
				info.keepShownOnClick = 1;
				info.checked = TitanGetVar(id, "ShowRegularText");
				info.disabled = nil;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
			
			--ShowColoredText
			if plugin.controlVariables.ShowColoredText then
				info = {};
				info.text = L["TITAN_PANEL_MENU_SHOW_COLORED_TEXT"];
				info.value = {id, "ShowColoredText", nil};
				info.func = function()
					TitanPanelRightClickMenu_ToggleVar({id, "ShowColoredText", nil})
					end
				info.keepShownOnClick = 1;
				info.checked = TitanGetVar(id, "ShowColoredText");
				info.disabled = nil;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end

			-- Right-side plugin
			if plugin.controlVariables.DisplayOnRightSide then
				info = {};
				info.text = L["TITAN_PANEL_MENU_LDB_SIDE"];
				info.func = function () 
					TitanToggleVar(id, "DisplayOnRightSide");		
					TitanPanel_RemoveButton(id);
					TitanUtils_AddButtonOnBar(TitanUtils_GetWhichBar(id), id);     
					end
				info.checked = TitanGetVar(id, "DisplayOnRightSide");
				info.disabled = nil;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end				
	end	
end

function TitanPanel_SettingsSelectionMenu()
	local info = {};
	
	info = {};
	info.text = L["TITAN_PANEL_MENU_LOAD_SETTINGS"];
	info.value = UIDROPDOWNMENU_MENU_VALUE;
	info.func = function() 
		TitanVariables_UseSettings(UIDROPDOWNMENU_MENU_VALUE)
		TitanPanelSettings.Buttons = newButtons;
		TitanPanelSettings.Location = newLocations;
		end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = {};
	info.text = L["TITAN_PANEL_MENU_DELETE_SETTINGS"];
	info.value = UIDROPDOWNMENU_MENU_VALUE;
	info.func = function()
		-- do not delete if current profile
		local playerName = UnitName("player");
		local serverName = GetCVar("realmName");
		local profilevalue = playerName.."@"..serverName
		if info.value == profilevalue then
			DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_TITLE"]
				.._G["FONT_COLOR_CODE_CLOSE"]..": "..L["TITAN_PANEL_ERROR_PROF_DELCURRENT"]);
			if (TitanPanelRightClickMenu_IsVisible()) then
				TitanPanelRightClickMenu_Close();
			end
			return;
		end

		if TitanSettings.Players[info.value] then
			TitanSettings.Players[info.value] = nil;
			DEFAULT_CHAT_FRAME:AddMessage(_G["GREEN_FONT_COLOR_CODE"]..L["TITAN_PANEL_MENU_TITLE"]
				.._G["FONT_COLOR_CODE_CLOSE"]..": "..L["TITAN_PANEL_MENU_PROFILE"]
				.."|cffff8c00"..info.value.."|r"..L["TITAN_PANEL_MENU_PROFILE_DELETED"]);
			if (TitanPanelRightClickMenu_IsVisible()) then
				TitanPanelRightClickMenu_Close();
			end
		end
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function TitanPanel_BuildOtherPluginsMenu()
	local info = {};
	local checked;
	local plugin;

	for index, id in pairs(TitanPluginsIndex) do
		plugin = TitanUtils_GetPlugin(id);
		if not plugin.category then
			plugin.category = "General";
		end
			
		if ( UIDROPDOWNMENU_MENU_VALUE == "Addons_" .. plugin.category ) then
			if not TitanGetVar(id, "ForceBar") 
				or (TitanGetVar(id, "ForceBar") == TITAN_PANEL_SELECTED)  then
				checked = nil;
				if ( TitanPanel_IsPluginShown(id) ) then
					checked = true;				
				end
				info = {};
				if plugin.version ~= nil and TitanPanelGetVar("VersionShown") then
					info.text = plugin.menuText .. TitanUtils_GetGreenText(" (v" .. plugin.version .. ")");
				else
					info.text = plugin.menuText;
				end
				if plugin.controlVariables then
					info.hasArrow = 1;
				end
				info.value = id;				
				info.func = function() 
				local checked = TitanPanel_IsPluginShown(id) or nil;
				TitanPanelRightClickMenu_BarOnClick(checked, id) end;
				info.checked = checked;
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	end
end

--[[
function TitanPanel_BuildPluginsMenu()
	local info = {};
	local checked;
	local plugin;

	if ( UIDROPDOWNMENU_MENU_VALUE == "Builtins" ) then
		TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_MENU_LEFT_SIDE"], UIDROPDOWNMENU_MENU_LEVEL);
		
		for index, id in pairs(TitanPluginsIndex) do
			plugin = TitanUtils_GetPlugin(id);
			if ( plugin.builtIn and ( TitanPanel_GetPluginSide(id) == "Left") ) then
				info = {};
				if plugin.menuText ~= nil and plugin.version ~= nil and TitanPanelGetVar("VersionShown") then
					info.text = plugin.menuText .. TitanUtils_GetGreenText(" (v" .. plugin.version .. ")");
				elseif plugin.menuText ~= nil then
					info.text = plugin.menuText;
				else
					info.text = plugin.id;
				end
				info.value = id;				
				info.func = function() 
					local checked = TitanPanel_IsPluginShown(id) or nil;
					TitanPanelRightClickMenu_BarOnClick(checked, id) 
					end;				
				info.checked = TitanPanel_IsPluginShown(id) or nil --checked;
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
		
		TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
		TitanPanelRightClickMenu_AddTitle(L["TITAN_PANEL_MENU_RIGHT_SIDE"], UIDROPDOWNMENU_MENU_LEVEL);

		for index, id in pairs(TitanPluginsIndex) do
			plugin = TitanUtils_GetPlugin(id);
			if ( plugin.builtIn and ( TitanPanel_GetPluginSide(id) == "Right") ) then
				if not TitanGetVar(id, "ForceBar") 
				or (TitanGetVar(id, "ForceBar") == TITAN_PANEL_SELECTED)  then

					info = {};
					if plugin.version ~= nil and TitanPanelGetVar("VersionShown") then
						info.text = plugin.menuText .. TitanUtils_GetGreenText(" (v" .. plugin.version .. ")");
					else
						info.text = plugin.menuText;
					end
					info.value = id;					
					info.func = function() 
						local checked = TitanPanel_IsPluginShown(id) or nil;
						TitanPanelRightClickMenu_BarOnClick(checked, id) 
						end;					
					info.checked = TitanPanel_IsPluginShown(id) or nil --checked;
					info.keepShownOnClick = 1;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end
	end
end
--]]

function TitanPanel_IsPluginShown(id)
	if ( id and TitanPanelSettings ) then
		return TitanUtils_TableContainsValue(TitanPanelSettings.Buttons, id);
	end
end

function TitanPanel_GetPluginSide(id)
	if ( TitanGetVar(id, "DisplayOnRightSide") ) then
		return "Right";
	elseif ( TitanPanelButton_IsIcon(id) ) then
		return "Right";
	else
		return "Left";
	end
end

function TitanPanel_ResetBar()
	local playerName = UnitName("player");
	local serverName = GetCVar("realmName");

	TitanCopyPlayerSettings = TitanSettings.Players[playerName.."@"..serverName];
	TitanCopyPluginSettings = TitanCopyPlayerSettings["Plugins"];

	for index, id in pairs (TitanPanelSettings["Buttons"]) do
		local currentButton = TitanUtils_GetButton(TitanPanelSettings["Buttons"][index]);
		-- safeguard
		if currentButton then
			currentButton:Hide();
		end					
	end

	TitanSettings.Players[playerName.."@"..serverName] = {}
	TitanSettings.Players[playerName.."@"..serverName].Plugins = {}
	TitanSettings.Players[playerName.."@"..serverName].Panel = {}
	TitanSettings.Players[playerName.."@"..serverName].Panel.Buttons = {"Coords", "XP", "GoldTracker", "Clock", "Volume", "AutoHide", "Bag", "AuxAutoHide", "Repair"}
	TitanSettings.Players[playerName.."@"..serverName].Panel.Locations = {"Bar", "Bar", "Bar", "Bar", "Bar", "Bar", "Bar", "AuxBar", "Bar"}
	

	-- Set global variables
	TitanPlayerSettings = TitanSettings.Players[playerName.."@"..serverName];
	TitanPluginSettings = TitanPlayerSettings["Plugins"];
	TitanPanelSettings = TitanPlayerSettings["Panel"];	
	IsTitanPanelReset = true;
	ReloadUI()
end
