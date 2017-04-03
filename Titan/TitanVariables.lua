-- Global variables 
TitanSettings = nil;
TitanPlayerSettings = nil;
TitanPluginSettings = nil;
TitanPanelSettings = nil;

TitanPluginToBeRegistered = {}
TitanPluginToBeRegisteredNum = 0

TitanPluginRegisteredNum = 0

TitanPluginAttempted = {}
TitanPluginAttemptedNum = 0

TitanPluginExtras = {}
TitanPluginExtrasNum = 0

TitanPluginLocation = {"Bar", "AuxBar"}
TitanPluginSide = {"Left", "Right"}

local _G = getfenv(0);
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local media = LibStub("LibSharedMedia-3.0")
-- Titan Panel Default SavedVars Table
local TITAN_PANEL_SAVED_VARIABLES = {
	Buttons = {"Coords", "XP", "GoldTracker", "Clock", "Volume", "AutoHide", "Bag", "AuxAutoHide", "Repair"},
	Location = {"Bar", "Bar", "Bar", "Bar", "Bar", "Bar", "Bar", "AuxBar", "Bar"},
	TexturePath = "Interface\\AddOns\\Titan\\Artwork\\",
	Transparency = 0.7,
	AuxTransparency = 0.7,
	Scale = 1,
	ButtonSpacing = 20,
	TooltipTrans = 1,
	TooltipFont = 1,
	DisableTooltipFont = 1,
	FontName = "Friz Quadrata TT",
	FrameStrata = "DIALOG",
	FontSize = 10,
	ScreenAdjust = false,
	LogAdjust = false,
	MinimapAdjust = false,
	BagAdjust = 1,
	TicketAdjust = 1,
	AutoHide = false,
	Position = 1,
	DoubleBar = 1,
	ButtonAlign = 1,
	BothBars = false,
	AuxScreenAdjust = false,
	AuxAutoHide = false,
	AuxDoubleBar = 1,
	AuxButtonAlign = 1,
	LockButtons = false,
	VersionShown = 1,
	ToolTipsShown = 1,
	HideTipsInCombat = false
};
-- Set Titan Version var for backwards compatibility
TITAN_VERSION = GetAddOnMetadata("Titan", "Version") or L["TITAN_NA"]
-- trim version if exists
local fullversion = GetAddOnMetadata("Titan", "Version")
if fullversion then
	local pos = string.find(fullversion, " -", 1, true);
	if pos then
		TITAN_VERSION = string.sub(fullversion,1,pos-1);
	end
end

function TitanVariables_InitTitanSettings()
	if (not TitanSettings) then
		TitanSettings = {};
	end
	
	TitanSettings.Version = TITAN_VERSION;
	TITAN_PANEL_SELECTED = "Bar";
end

function TitanVariables_InitDetailedSettings()
	if (not TitanPlayerSettings) then
		TitanVariables_InitPlayerSettings();
		if (TitanPlayerSettings) then
						
			-- Syncronize Plugins/Panel settings
			TitanVariables_SyncPluginSettings();
			TitanVariables_SyncPanelSettings();
			TitanVariables_ExtraPluginSettings()
--			TitanVariables_HandleLDB();
		end					
	end	
end

--[[
function TitanVariables_HandleLDB()
	-- Handle LDB
	local plugin, index, id;
	for index, id in pairs(TitanPluginsIndex) do
		plugin = TitanUtils_GetPlugin(id);		 			
		if plugin.ldb == "launcher" and TitanGetVar(id, "DisplayOnRightSide") then
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
				local found = nil;
				for index, _ in ipairs(TITAN_PANEL_NONMOVABLE_PLUGINS) do
					if id == TITAN_PANEL_NONMOVABLE_PLUGINS[index] then
						found = true;
					end
				end
				if not found then table.insert(TITAN_PANEL_NONMOVABLE_PLUGINS, id); end
				if button:IsVisible() then
					TitanPanel_RemoveButton(id);
					TitanPanel_AddButton(id);
				end
			end
		elseif plugin.ldb == "launcher" and not TitanGetVar(id, "DisplayOnRightSide") then
			local button = TitanUtils_GetButton(id);
			local buttonText = _G[button:GetName().."Text"];
			if not buttonText then
				TitanPlugins[id].buttonTextFunction = "TitanLDBShowText";
				button:CreateFontString("TitanPanel"..id.."ButtonText", "OVERLAY", "GameFontNormalSmall")
				buttonText = _G[button:GetName().."Text"];
				buttonText:SetJustifyH("LEFT");
				-- set font for the fontstring
				local currentfont = media:Fetch("font", TitanPanelGetVar("FontName"))
				buttonText:SetFont(currentfont, TitanPanelGetVar("FontSize"));
				local index;
				local found = nil;
				for index, _ in ipairs(TITAN_PANEL_NONMOVABLE_PLUGINS) do
					if id == TITAN_PANEL_NONMOVABLE_PLUGINS[index] then
						found = index;
					end
				end
				if found then 
					table.remove(TITAN_PANEL_NONMOVABLE_PLUGINS, found); 
				end
				if button:IsVisible() then
					TitanPanel_RemoveButton(id);
					TitanPanel_AddButton(id);
				end
			end
		end
	end
	-- /Handle LDB
end
--]]

function TitanVariables_InitPlayerSettings() 
	-- Titan should not be nil
	if (not TitanSettings) then
		return;
	end
	
	-- Init TitanSettings.Players
	if (not TitanSettings.Players ) then
		TitanSettings.Players = {};
	end
	
	local playerName = UnitName("player");
	local serverName = GetCVar("realmName");
	-- Do nothing if player name is not available
	if (playerName == nil or playerName == UNKNOWNOBJECT or playerName == UKNOWNBEING) then
		return;
	end

	if (TitanSettings.Players[playerName] and not TitanSettings[playerName .. "@" .. serverName]) then
		TitanSettings.Players[playerName.."@"..serverName] = TitanSettings.Players[playerName];
		TitanSettings.Players[playerName]=nil;
	end
	
	-- Init TitanPlayerSettings
	if (not TitanSettings.Players[playerName.."@"..serverName]) then
		TitanSettings.Players[playerName.."@"..serverName] = {};
		TitanSettings.Players[playerName.."@"..serverName].Plugins = {};
		TitanSettings.Players[playerName.."@"..serverName].Panel = {};
	end	
	
	-- Set global variables
	TitanPlayerSettings = TitanSettings.Players[playerName.."@"..serverName];
	TitanPluginSettings = TitanPlayerSettings["Plugins"];
	TitanPanelSettings = TitanPlayerSettings["Panel"];	
	
	TitanSettings.Player = playerName.."@"..serverName
end

function TitanVariables_SyncPluginSettings()
	-- Init each and every plugin
	for id, plugin in pairs(TitanPlugins) do
		if (plugin and plugin.savedVariables) then
			-- Init savedVariables table
			if (not TitanPluginSettings[id]) then
				TitanPluginSettings[id] = {};
			end					
			
			-- Synchronize registered and saved variables
			TitanVariables_SyncRegisterSavedVariables(plugin.savedVariables, TitanPluginSettings[id]);			
		else
			-- Remove plugin savedVariables table if there's one
			if (TitanPluginSettings[id]) then
				TitanPluginSettings[id] = nil;
			end								
		end
	end
end

local function TitanRegisterExtra(id) 
		TitanPluginExtrasNum = TitanPluginExtrasNum + 1
		TitanPluginExtras[TitanPluginExtrasNum] = 
			{num=TitanPluginExtrasNum, 
			id     = (id or "?"), 
			}
end

function TitanVariables_ExtraPluginSettings()
	-- Get the saved plugins that are not loaded
	for id, plugin in pairs(TitanPluginSettings) do
		if (id and TitanUtils_IsPluginRegistered(id)) then
		else
			TitanRegisterExtra(id)								
		end
	end
end

function TitanVariables_SyncPanelSettings() 
	-- Synchronize registered and saved variables
	TitanVariables_SyncRegisterSavedVariables(TITAN_PANEL_SAVED_VARIABLES, TitanPanelSettings);			
end

function TitanVariables_SyncRegisterSavedVariables(registeredVariables, savedVariables)
	if (registeredVariables and savedVariables) then
		-- Init registeredVariables
		for index, value in pairs(registeredVariables) do
			if (not TitanUtils_TableContainsIndex(savedVariables, index)) then
				savedVariables[index] = value;
			end
		end
					
		-- Remove out-of-date savedVariables
		for index, value in pairs(savedVariables) do
			if (not TitanUtils_TableContainsIndex(registeredVariables, index)) then
				savedVariables[index] = nil;
			end
		end
	end
end

function TitanGetVar(id, var)
	if (id and var and TitanPluginSettings and TitanPluginSettings[id]) then		
		-- compatibility check
		if TitanPluginSettings[id][var] == "Titan Nil" then TitanPluginSettings[id][var] = false end
		return TitanUtils_Ternary(TitanPluginSettings[id][var] == false, nil, TitanPluginSettings[id][var]);
	end
end

function TitanVarExists(id, var)
	-- We need to check for existance not true!
	-- If the value is nil then it will not exist...
	if (id and var and TitanPluginSettings and TitanPluginSettings[id] 
	and (TitanPluginSettings[id][var] or TitanPluginSettings[id][var] == false) ) then
		return true
	else
		return false
	end
end

function TitanSetVar(id, var, value)
	if (id and var and TitanPluginSettings and TitanPluginSettings[id]) then		
		TitanPluginSettings[id][var] = TitanUtils_Ternary(value, value, false);		
	end
end

function TitanGetVarTable(id, var, position)
	if (id and var and TitanPluginSettings and TitanPluginSettings[id]) then		
		-- compatibility check
		if TitanPluginSettings[id][var][position] == "Titan Nil" then TitanPluginSettings[id][var][position] = false end
		return TitanUtils_Ternary(TitanPluginSettings[id][var][position] == false, nil, TitanPluginSettings[id][var][position]);
	end
end

function TitanSetVarTable(id, var, position, value)
	if (id and var and TitanPluginSettings and TitanPluginSettings[id]) then		
		TitanPluginSettings[id][var][position] = TitanUtils_Ternary(value, value, false);
	end
end

function TitanToggleVar(id, var)
	if (id and var and TitanPluginSettings and TitanPluginSettings[id]) then
		TitanSetVar(id, var, TitanUtils_Toggle(TitanGetVar(id, var)));
	end
end

function TitanPanelGetVar(var)
	if (var and TitanPanelSettings) then		
		if TitanPanelSettings[var] == "Titan Nil" then TitanPanelSettings[var] = false end		
		return TitanUtils_Ternary(TitanPanelSettings[var] == false, nil, TitanPanelSettings[var]);
	end
end

function TitanPanelSetVar(var, value)
	if (var and TitanPanelSettings) then		
		TitanPanelSettings[var] = TitanUtils_Ternary(value, value, false);
	end
end

function TitanPanelToggleVar(var)
	if (var and TitanPanelSettings) then
		TitanPanelSetVar(var, TitanUtils_Toggle(TitanPanelGetVar(var)));
	end
end

--[[
function TitanVariables_AppendNonMovableButtons(buttons)
	if ( buttons and type(buttons) == "table" ) then		
		for index, id in TITAN_PANEL_NONMOVABLE_PLUGINS do
			if ( not TitanUtils_TableContainsValue(buttons, id) ) then
				table.insert(buttons, id);
			end
		end
	end
	return buttons;
end
--]]

function TitanVariables_GetPanelStrata(value)
	-- obligatory check
	if not value then value = "DIALOG" end

	local index, id;
	local indexpos = 5 -- DIALOG
	local StrataTypes = {"BACKGROUND", "LOW", "MEDIUM", "HIGH", "DIALOG", "FULLSCREEN", "FULLSCREEN_DIALOG"}
	TitanPanelBarButton:SetFrameStrata(value)
	TitanPanelAuxBarButton:SetFrameStrata(value)

	for index in ipairs(StrataTypes) do
		if value == StrataTypes[index] then
			indexpos = index
			break
		end
	end
	
	-- return the string value
	return StrataTypes[indexpos + 1]
end

function TitanVariables_SetPanelStrata(value)
	strata = TitanVariables_GetPanelStrata(value)
	for index, id in pairs(TitanPluginsIndex) do
		local button = TitanUtils_GetButton(id);
		button:SetFrameStrata(strata)
	end
end

function TitanVariables_UseSettings(value)
	if not value then return end

	local i,k,pos;
	local TitanCopyPlayerSettings = nil;
	local TitanCopyPluginSettings = nil;
	local TitanCopyPanelSettings = nil;

	TitanCopyPlayerSettings = TitanSettings.Players[value];
	TitanCopyPluginSettings = TitanCopyPlayerSettings["Plugins"];
	TitanCopyPanelSettings = TitanCopyPlayerSettings["Panel"];

	for index, id in pairs(TitanPanelSettings["Buttons"]) do
		local currentButton = TitanUtils_GetButton(TitanPanelSettings["Buttons"][index]);
		-- safeguard
		if currentButton then
		currentButton:Hide();
		end	
	end

	for index, id in pairs(TitanCopyPanelSettings) do
  	TitanPanelSetVar(index, TitanCopyPanelSettings[index]);		
	end
	
	
	for index, id in pairs(TitanCopyPluginSettings) do
		for var, id in pairs(TitanCopyPluginSettings[index]) do		
			TitanSetVar(index, var, TitanCopyPluginSettings[index][var])
		end
	end

	TitanPanel_InitPanelBarButton();
	TitanPanel_InitPanelButtons();
	
	-- Set panel font
	local isfontvalid, newfont, index, id;
	isfontvalid = media:IsValid("font", TitanPanelGetVar("FontName"))
	if isfontvalid then
		newfont = media:Fetch("font", TitanPanelGetVar("FontName"))
		for index, id in pairs(TitanPluginsIndex) do
			local button = TitanUtils_GetButton(id);
			local buttonText = _G[button:GetName().."Text"];
			if buttonText then
				buttonText:SetFont(newfont, TitanPanelGetVar("FontSize"));
			end
			-- account for plugins with child buttons
			local childbuttons = {button:GetChildren()};
			for _, child in ipairs(childbuttons) do
				if child then
					local childbuttonText = _G[child:GetName().."Text"];
					if childbuttonText then
						childbuttonText:SetFont(newfont, TitanPanelGetVar("FontSize"));
					end
				end
			end
		end
		TitanPanel_RefreshPanelButtons();				
	end

	TitanVariables_SetPanelStrata(TitanPanelGetVar("FrameStrata"))

	if (TitanPanelGetVar("AutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
	end
	if (TitanPanelGetVar("AuxAutoHide")) then
		TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
	end		
	TitanPanelRightClickMenu_Close();
end
