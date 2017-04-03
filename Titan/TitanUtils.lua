Titan__InitializedPEW = nil
TITAN_PANEL_NONMOVABLE_PLUGINS = {};
TITAN_PANEL_MENU_FUNC_HIDE = "TitanPanelRightClickMenu_Hide";
TitanPlugins = {};
TitanPluginsIndex = {};
TITAN_NOT_REGISTERED = _G["RED_FONT_COLOR_CODE"].."Not_Registered_Yet".._G["FONT_COLOR_CODE_CLOSE"]
TITAN_REGISTERED = _G["GREEN_FONT_COLOR_CODE"].."Registered".._G["FONT_COLOR_CODE_CLOSE"]
TITAN_REGISTER_FAILED = _G["RED_FONT_COLOR_CODE"].."Failed_to_Register".._G["FONT_COLOR_CODE_CLOSE"]

local _G = getfenv(0);
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local media = LibStub("LibSharedMedia-3.0")

function TitanDebug(debug_message)
	_G["DEFAULT_CHAT_FRAME"]:AddMessage(
		TitanUtils_GetGoldText(L["TITAN_DEBUG"]) .. " " 
		.. TitanUtils_GetGreenText(debug_message)
	);
end

--
-- This section for Titan Panel ONLY: Plugin registration routines
--
function TitanUtils_PluginToRegister(self, isChildButton) 
	-- NOTE: registry is off of 'self' but for LDB buttons it is set
	-- AFTER this routine. Any read of the registry must assume 
	-- it may not exist. Also assume the registry could be updated after this routine.
	--
	-- This is called when a Titan button frame is created.
	-- Normally these are held until the player 'enters world' then the
	-- plugin is registered.
	-- Sometimes plugin frames are created after this process. Right
	-- now only LDB plugs are handled. If someone where to start creating 
	-- Titan frames after the registration process were complete then
	-- it would fail to be registered...
	TitanPluginToBeRegisteredNum = TitanPluginToBeRegisteredNum + 1
	local cat = ""
	if self and self.registry then
		cat = (self.registry.category or "")
	end
	-- Some of the fields in this record are displayed in the "Attempts"
	-- so they are defaulted here.
	TitanPluginToBeRegistered[TitanPluginToBeRegisteredNum] = 
		{
		self = self,
		button = ((self and self:GetName() or "Nyl".."_"..TitanPluginToBeRegisteredNum)),
		isChild = (isChildButton and true or false),
		-- fields below are updated when registered
		name = "?",
		issue = "", 
		status = TITAN_NOT_REGISTERED,
		category = cat,
		plugin_type = "",
		}
--[[
	-- NOTE: This did not handle LDB because the 'registry' is attached to the frame 
	-- AFTER the frame is created...
	--
	-- This will handle plugins that are initialized after Titan registration has run.
	-- Such as 'load on demand' or just bad timing
	if Titan__InitializedPEW then
		local plugin = TitanPluginToBeRegistered[TitanPluginToBeRegisteredNum]
		TitanUtils_RegisterPlugin(plugin)
		-- Assume errors will be printed out when registering.
		TitanDebug("register single plugin "
			.."'"..(plugin.name or "?").."'"
			.." : "..(plugin.status or "?")
			)
	end
--]]
end

function TitanUtils_PluginFail(plugin) 
	-- This is called when a plugin is unsupported.
	-- It is intended mainly for developers. It is a place to put relevant info
	-- for debug and so users can supply troubleshooting info.
	-- The key is set the status to 'fail' so there is no attempt to register
	-- the plugin.
	--
	-- plugin is to hold as much info as possible...
	TitanPluginToBeRegisteredNum = TitanPluginToBeRegisteredNum + 1
	TitanPluginToBeRegistered[TitanPluginToBeRegisteredNum] = 
		{
		self = plugin.self,
--		button = (plugin.button and plugin.button:GetName() or "Nyl".."_"..TitanPluginToBeRegisteredNum),
		button = (plugin.button and plugin.button:GetName() or ""),
		isChild = (plugin.isChild and true or false),
		name = (plugin.name or "?"),
		issue = (plugin.issue or "?"), 
		status = (plugin.status or TITAN_REGISTER_FAILED),
		category = (plugin.category or ""),
		plugin_type = (plugin.plugin_type or ""),
		}
end

local function TitanUtils_RegisterPluginProtected(plugin)
	local result = nil
	local issue = nil
	local id = nil
	local cat = nil
	
	local self = plugin.self
	local isChildButton = (plugin.isChild and true or false)
	
	if self and self:GetName() then
--[[
TitanDebug("RegisterPluginProtected: "
			.."name: '"..self:GetName().."' "
			.."child: '"..(isChildButton and "true" or "false").."' "
			)
--]]
		if (isChildButton) then
			self:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp");
			self:RegisterForDrag("LeftButton")
			TitanPanelDetectPluginMethod(self:GetName(), true);
			result = TITAN_REGISTERED
			id = "<child>" -- give some indication that this is valid...
		else 
			if (self.registry and self.registry.id) then
				id = self.registry.id
				if TitanUtils_IsPluginRegistered(id) then
					-- We have already registered this plugin we have an issue!
--					TitanPanel_LoadError("Plugin " .. id .. L["TITAN_PANEL_ERROR_DUP_PLUGIN"]);
					-- Give a reason to the user
					issue =  "Plugin already loaded."
				else
					if (not TitanUtils_TableContainsValue(TitanPluginsIndex, id)) then
						-- Assign and Sort the list of plugins
						TitanPlugins[id] = self.registry;
						table.insert(TitanPluginsIndex, self.registry.id);
						table.sort(TitanPluginsIndex, 
							function(a, b)
							  if TitanPlugins[a].menuText == nil then
								TitanPlugins[a].menuText = TitanPlugins[a].id;
							  end
							  if TitanPlugins[b].menuText == nil then
								TitanPlugins[b].menuText = TitanPlugins[b].id;
							  end
								return string.lower(TitanPlugins[a].menuText) < string.lower(TitanPlugins[b].menuText);
							end
						);
					end
				end
				if issue then
					result = TITAN_REGISTER_FAILED
				else
					local pluginID = TitanUtils_GetButtonID(self:GetName());
					local plugin_id = TitanUtils_GetPlugin(pluginID);
					if (plugin_id) then
						self:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp");
						self:RegisterForDrag("LeftButton")
						if (plugin_id.id) then
							TitanPanelDetectPluginMethod(plugin_id.id);
						end
					end
					result = TITAN_REGISTERED
					-- determine the plugin category
					cat = (self.registry.category or nil)
					ptype = "Titan" -- Assume it is created for Titan
					if self.registry.ldb then
						ptype = "LDB: '"..self.registry.ldb.."'" -- Override with the LDB type
					end
				end
			else
				result = TITAN_REGISTER_FAILED
				if (not self.registry) then
					issue = "Can not find registry for plugin (self.registry)"
				end
				if (self.registry and not self.registry.id) then
					issue = "Can not determine plugin name (self.registry.id)"
				end
			end
		end
	else
		-- if not then attempt to give a reason to the user
		result = TITAN_REGISTER_FAILED
		issue = "Can not determine plugin button name"
	end
	
	local ret_val = {}
	ret_val.issue = (issue or "")
	ret_val.result = (result or TITAN_REGISTER_FAILED)
	ret_val.id = (id or "")
	ret_val.cat = (cat or "General")
	ret_val.ptype = ptype
	return ret_val
end

function TitanUtils_RegisterPlugin(plugin)
	local call_success, ret_val
	-- lets be paranoid here...
	-- Registering plugins that do not play nice can cause real headaches.
	if plugin and plugin.status == TITAN_NOT_REGISTERED then
		-- See if the request to register was done right
		if plugin.self then
			-- Just in case, catch any errors
			call_success, -- needed for pcall
			ret_val =  -- actual return values
				pcall (TitanUtils_RegisterPluginProtected, plugin)
--[[
TitanDebug("_RegisterPlugin: "
			.."call_success: '"..(call_success and "true" or "false").."' "
			.."ret_val.result: '"..(ret_val.result or "?").."' "
			)
--]]
			if call_success then
				-- all is good
				plugin.status = ret_val.result
				plugin.issue = ret_val.issue
				plugin.name = ret_val.id
				plugin.category = ret_val.cat
				plugin.plugin_type = ret_val.ptype
			else
				plugin.status = TITAN_REGISTER_FAILED
				plugin.issue = (ret_val.issue or "Unknown error")
				plugin.name = "?"
			end
		else
			plugin.status = TITAN_REGISTER_FAILED
			plugin.issue = "Can not determine plugin button name"
			plugin.name = "?"
		end
		-- Tell the user there was some issue.
		if not plugin.issue == "" 
		or plugin.status ~= TITAN_REGISTERED then
			TitanDebug(TitanUtils_GetRedText("Error Registering Plugin")
				..TitanUtils_GetGreenText(
					": "
					.."name: '"..(plugin.name or "?_").."' "
					.."issue: '"..(plugin.issue or "?_").."' "
					.."button: '"..plugin.button.."' "
					)
				)
		end
	end
end

function TitanUtils_RegisterPluginList()
	local result = ""
	local issue = ""
	local id
	if TitanPluginToBeRegisteredNum > 0 then
		TitanDebug(L["TITAN_PANEL_REGISTER_START"])
		for index, value in ipairs(TitanPluginToBeRegistered) do
			if TitanPluginToBeRegistered[index] then
				TitanUtils_RegisterPlugin(TitanPluginToBeRegistered[index])
			end
		end
		TitanDebug(L["TITAN_PANEL_REGISTER_END"])
	end
end

function TitanUtils_IsPluginRegistered(id)
	if (id and TitanPlugins[id]) then
		return true;
	else
		return false;
	end
end

--
-- Plugin button search & manipulation routines
--
function TitanUtils_GetNextButtonOnBar(bar, id, side)
	-- find the next button that is on the same bar and is on the same side
	-- return nil if not found
	local index = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons, id);
	
	for i, id in pairs(TitanPanelSettings.Buttons) do
		if TitanUtils_GetWhichBar(id) == bar and i > index and TitanPanel_GetPluginSide(id) == side then
			return i;
		end
	end
end

function TitanUtils_GetFirstButtonOnBar(bar, side)
	-- find the first button that is on the same bar and is on the same side
	-- return nil if not found
	local index = 0
	
	for i, id in pairs(TitanPanelSettings.Buttons) do
		if TitanUtils_GetWhichBar(id) == bar and i > index and TitanPanel_GetPluginSide(id) == side then
			return i;
		end
	end
end

function TitanUtils_GetPrevButtonOnBar(bar, id, side)
	-- find the prev button that is on the same bar and is on the same side
	-- return nil if not found
	local index = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons, id);
	local prev_idx = nil
	
	for i, id in pairs(TitanPanelSettings.Buttons) do
		if TitanUtils_GetWhichBar(id) == bar and i < index and TitanPanel_GetPluginSide(id) == side then
			prev_idx = i; -- this might be the previous button
		end
		if i == index then
			return prev_idx;
		end
	end
end

function TitanUtils_ShiftButtonOnBarLeft(name)
	-- Find the button to the left. If there is one, swap it in the array
	local from_idx = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons,name)
	local side = TitanPanel_GetPluginSide(name)
	local bar = TitanUtils_GetWhichBar(name)
	
	-- This is needed because buttons on Left are placed L to R; 
	-- buttons on Right are placed R to L
	if side and side == "Left" then
		to_idx = TitanUtils_GetPrevButtonOnBar (TitanUtils_GetWhichBar(name), name, side)
	elseif side and side == "Right" then
		to_idx = TitanUtils_GetNextButtonOnBar (TitanUtils_GetWhichBar(name), name, side)
	end
	
	if to_idx then
		TitanUtils_SwapButtonOnBar(from_idx, to_idx);
	else
		return
	end
end

function TitanUtils_ShiftButtonOnBarRight(name)
	-- Find the button to the right. If there is one, swap it in the array
	local from_idx = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons,name)
	local to_idx = nil
	local side = TitanPanel_GetPluginSide(name)
	local bar = TitanUtils_GetWhichBar(name)
	
	-- this is needed because buttons on Left are placed L to R; 
	-- buttons on Right are placed R to L
	if side and side == "Left" then
		to_idx = TitanUtils_GetNextButtonOnBar (bar, name, side)
	elseif side and side == "Right" then
		to_idx = TitanUtils_GetPrevButtonOnBar (bar, name, side)
	end
	
	if to_idx then
		TitanUtils_SwapButtonOnBar(from_idx, to_idx);
	else
		return
	end
end

function TitanUtils_SwapButtonOnBar(from_id, to_id)
	-- Used as part of the shift L / R to swap the buttons
	local button = TitanPanelSettings.Buttons[from_id]
	local locale = TitanPanelSettings.Location[from_id]
	
	TitanPanelSettings.Buttons[from_id] = TitanPanelSettings.Buttons[to_id]
	TitanPanelSettings.Location[from_id] = TitanPanelSettings.Location[to_id]
	TitanPanelSettings.Buttons[to_id] = button
	TitanPanelSettings.Location[to_id] = locale
	TitanPanel_InitPanelButtons();
end

function TitanUtils_AddButtonOnBar(bar, id)
	-- Add the button to the requested bar - main / aux
	if (not TitanPanelSettings) then
		return;
	end 
	
	local i = TitanPanel_GetButtonNumber(id)
	TitanPanelSettings.Location[i] = (bar or "Bar") -- just case there is nothing stated
		
	table.insert(TitanPanelSettings.Buttons, id);	
	--table.insert(TitanPanelSettings.Location, TITAN_PANEL_SELECTED);
	TitanPanel_InitPanelButtons();
end

function TitanUtils_GetRealPosition(id)
	local i = TitanPanel_GetButtonNumber(id);
	if TitanPanelSettings.Location[i] == "Bar" and TitanPanelGetVar("BothBars") then
		return TITAN_PANEL_PLACE_TOP;
	elseif TitanPanelSettings.Location[i] == "Bar" then
		return TitanPanelGetVar("Position");
	else
		return TITAN_PANEL_PLACE_BOTTOM;
	end
end

function TitanUtils_GetWhichBar(id)
	local i = TitanPanel_GetButtonNumber(id);
	if TitanPanelSettings.Location[i] == nil then
		return
	else
		return TitanPanelSettings.Location[i];
	end
end

function TitanUtils_SetWhichBar(id, bar)
	local i = TitanPanel_GetButtonNumber(id);
	if TitanPanelSettings.Location[i] == nil then
		return
	else
		TitanPanelSettings.Location[i] = bar;
	end
	TitanPanel_InitPanelButtons();
end

function TitanUtils_GetDoubleBar(bothbars, framePosition)
	if framePosition == TITAN_PANEL_PLACE_TOP then
		return TitanPanelGetVar("DoubleBar")
	elseif framePosition == TITAN_PANEL_PLACE_BOTTOM and bothbars == nil then
		return TitanPanelGetVar("DoubleBar")
	elseif framePosition == TITAN_PANEL_PLACE_BOTTOM and bothbars == 1 then
		return TitanPanelGetVar("AuxDoubleBar")
	end
end

function TitanUtils_GetButton(id)
	if (id) then
		return _G["TitanPanel"..id.."Button"], id;
	else
		return nil, nil;
	end
end

function TitanUtils_GetButtonID(name)
	if name then
		local s, e, id = string.find(name, "TitanPanel(.*)Button");
		return id;
	else
		return nil;
	end
end

function TitanUtils_GetParentButtonID(name)
	local frame = TitanUtils_Ternary(name, _G[name], nil);

	if ( frame and frame:GetParent() ) then
		return TitanUtils_GetButtonID(frame:GetParent():GetName());
	end
end

function TitanUtils_GetButtonIDFromMenu(self)
	if self and self:GetParent() then
		if self:GetParent():GetName() == "TitanPanelBarButton" or self:GetParent():GetName() == "TitanPanelAuxBarButton" then
			return "Bar";
		elseif self:GetParent():GetParent():GetName() then  
			-- TitanPanelChildButton     			
			return TitanUtils_GetButtonID(self:GetParent():GetParent():GetName());		
		else		
			-- TitanPanelButton
			return TitanUtils_GetButtonID(self:GetParent():GetName());		
		end	
	end
end

function TitanUtils_GetPlugin(id)
	if (id) then
		return TitanPlugins[id];
	else
		return nil;
	end
end

function TitanUtils_GetFirstButton(array, isSameType, isIcon, ignoreClock)	
	local firstButton, isFirstIcon;
	local size = table.getn(array);
	local index = 1;
	
	if ( isSameType ) then
		-- Get the first button with the same type
		while ( index <= size ) do
			firstButton = TitanUtils_GetButton(array[index]);
			isFirstIcon = TitanPanelButton_IsIcon(array[index]);

			if ( ( isIcon and isFirstIcon ) or ( not isIcon and not isFirstIcon ) ) then
				if TitanUtils_GetWhichBar(array[index]) == "AuxBar" then
					-- Do nothing wrong bar
				else
					return firstButton;
				end
			end
			
			index = index + 1;
		end
	else
		-- Simply get the first button
		if ( size > 0 ) then
			return TitanUtils_GetButton(array[1]);
		end		
	end
end

function TitanUtils_GetFirstAuxButton(array, isSameType, isIcon, ignoreClock)	
	local firstButton, isFirstIcon;
	local size = table.getn(array);
	local index = 1;
	
	if ( isSameType ) then
		-- Get the first button with the same type
		while ( index <= size ) do
			firstButton = TitanUtils_GetButton(array[index]);
			isFirstIcon = TitanPanelButton_IsIcon(array[index]);

			if ( ( isIcon and isFirstIcon ) or ( not isIcon and not isFirstIcon ) ) then
				if TitanUtils_GetWhichBar(array[index]) == "Bar" then
					-- Do nothing wrong bar
				else
					return firstButton;
				end
			end
						
			index = index + 1;
		end
	else
		-- Simply get the first button
		if ( size > 0 ) then
			return TitanUtils_GetButton(array[1]);
		end		
	end
end

--
-- Frame check & manipulation routines
--
function TitanUtils_CheckFrameCounting(frame, elapsed)
	if (frame:IsVisible()) then
		if (not frame.frameTimer or not frame.isCounting) then
			return;
		elseif ( frame.frameTimer < 0 ) then
			frame:Hide();
			frame.frameTimer = nil;
			frame.isCounting = nil;
		else
			frame.frameTimer = frame.frameTimer - elapsed;
		end
	end
end

function TitanUtils_StartFrameCounting(frame, frameShowTime)
	frame.frameTimer = frameShowTime;
	frame.isCounting = 1;
end

function TitanUtils_StopFrameCounting(frame)
	frame.isCounting = nil;
end

function TitanUtils_CloseAllControlFrames()
	for index, value in pairs(TitanPlugins) do
		local frame = _G["TitanPanel"..index.."ControlFrame"];
		if (frame and frame:IsVisible()) then
			frame:Hide();
		end
	end
end

function TitanUtils_IsAnyControlFrameVisible()
	for index, value in TitanPlugins do
		local frame = _G["TitanPanel"..index.."ControlFrame"];
		if (frame:IsVisible()) then
			return true;
		end
	end
	return false;
end

function TitanUtils_GetOffscreen(frame)
	local offscreenX, offscreenY;

	if ( frame and frame:GetLeft() and frame:GetLeft() * frame:GetEffectiveScale() < UIParent:GetLeft() * UIParent:GetEffectiveScale() ) then
		offscreenX = -1;
	elseif ( frame and frame:GetRight() and frame:GetRight() * frame:GetEffectiveScale() > UIParent:GetRight() * UIParent:GetEffectiveScale() ) then
		offscreenX = 1;
	else
		offscreenX = 0;
	end

	if ( frame and frame:GetTop() and frame:GetTop() * frame:GetEffectiveScale() > UIParent:GetTop() * UIParent:GetEffectiveScale() ) then
		offscreenY = -1;
	elseif ( frame and frame:GetBottom() and frame:GetBottom() * frame:GetEffectiveScale() < UIParent:GetBottom() * UIParent:GetEffectiveScale() ) then
		offscreenY = 1;
	else
		offscreenY = 0;
	end
	
	--[[
	TitanDebug(frame:GetName());
	TitanDebug("frame:GetScale() = "..frame:GetScale());	
	TitanDebug("frame:GetLeft() = "..frame:GetLeft());	
	TitanDebug("frame:GetRight() = "..frame:GetRight());	
	TitanDebug("frame:GetTop() = "..frame:GetTop());	
	TitanDebug("frame:GetBottom() = "..frame:GetBottom());	
	TitanDebug("UIParent:GetScale() = "..UIParent:GetScale());	
	TitanDebug("UIParent:GetLeft() = "..UIParent:GetLeft());	
	TitanDebug("UIParent:GetRight() = "..UIParent:GetRight());	
	TitanDebug("UIParent:GetTop() = "..UIParent:GetTop());	
	TitanDebug("UIParent:GetBottom() = "..UIParent:GetBottom());	
	TitanDebug("offscreenX = "..offscreenX.." | offscreenY = "..offscreenY);
	]]--
	return offscreenX, offscreenY;
end

--
-- General util routines
--
function TitanUtils_Ternary(a, b, c)
	if (a) then
		return b;
	else
		return c;
	end
end

function TitanUtils_Toggle(value)
	if (value == 1 or value == true) then
		return nil;
	else
		return 1;
	end
end

function TitanUtils_Min(a, b)
	if (a and b) then
--		return ( a < b ) and a or b
		return TitanUtils_Ternary((a < b), a, b);
	end
end

function TitanUtils_Max(a, b)
	if (a and b) then
		return TitanUtils_Ternary((a > b), a, b);
---		return ( a > b ) and a or b
	end
end

function TitanUtils_GetEstTimeText(s)
	if not s then return L["TITAN_NA"] end
	if (s < 0) then
		return L["TITAN_NA"];
	elseif (s < 60) then
		return format("%d "..L["TITAN_SECONDS"], s);
	elseif (s < 60*60) then
		return format("%.1f "..L["TITAN_MINUTES"], s/60);
	elseif (s < 24*60*60) then
		return format("%.1f "..L["TITAN_HOURS"], s/60/60);
	else
		return format("%.1f "..L["TITAN_DAYS"], s/24/60/60);
	end
end

function TitanUtils_GetFullTimeText(s)
if not s then return L["TITAN_NA"] end

	if (s < 0) then
		return L["TITAN_NA"];
	end
	
	local days = floor(s/24/60/60); s = mod(s, 24*60*60);
	local hours = floor(s/60/60); s = mod(s, 60*60);
	local minutes = floor(s/60); s = mod(s, 60);
	local seconds = s;
	
	return format("%d"..L["TITAN_DAYS_ABBR"]..", %2d"..L["TITAN_HOURS_ABBR"]..", %2d"..L["TITAN_MINUTES_ABBR"]..", %2d"..L["TITAN_SECONDS_ABBR"],
				days, hours, minutes, seconds);
end

function TitanUtils_GetAbbrTimeText(s)
	if not s then return L["TITAN_NA"] end

	if (s < 0) then
		return L["TITAN_NA"];
	end
	
	local days = floor(s/24/60/60); s = mod(s, 24*60*60);
	local hours = floor(s/60/60); s = mod(s, 60*60);
	local minutes = floor(s/60); s = mod(s, 60);
	local seconds = s;
	
	local timeText = "";
	if (days ~= 0) then
		timeText = timeText..format("%d"..L["TITAN_DAYS_ABBR"].." ", days);
	end
	if (days ~= 0 or hours ~= 0) then
		timeText = timeText..format("%d"..L["TITAN_HOURS_ABBR"].." ", hours);
	end
	if (days ~= 0 or hours ~= 0 or minutes ~= 0) then
		timeText = timeText..format("%d"..L["TITAN_MINUTES_ABBR"].." ", minutes);
	end	
	timeText = timeText..format("%d"..L["TITAN_SECONDS_ABBR"], seconds);
	
	return timeText;
end

function TitanUtils_GetControlFrame(id)
	if (id) then
		return _G["TitanPanel"..id.."ControlFrame"];
	else
		return nil;
	end
end

function TitanUtils_TableContainsValue(table, value)
	if (table and value) then
		for i, v in pairs(table) do
			if (v == value) then
				return i;
			end
		end
	end
end

function TitanUtils_TableContainsIndex(table, index)
	if (table and index) then
		for i, v in pairs(table) do
			if (i == index) then
				return i;
			end
		end
	end
end

function TitanUtils_GetCurrentIndex(table, value)
	return TitanUtils_TableContainsValue(table, value);
end

function TitanUtils_PrintArray(array) 
	if (not array) then
		TitanDebug("array is nil");
	else
		TitanDebug("{");
		for i, v in array do
			TitanDebug("array[" .. tostring(i) .. "] = " .. tostring(v));
		end
		TitanDebug("}");
	end
	
end

function TitanUtils_GetRedText(text)
	if (text) then
		return _G["RED_FONT_COLOR_CODE"]..text.._G["FONT_COLOR_CODE_CLOSE"];
	end
end

function TitanUtils_GetGoldText(text)
	if (text) then
		return "|cffffd700"..text.._G["FONT_COLOR_CODE_CLOSE"];
	end
end

function TitanUtils_GetGreenText(text)
	if (text) then
		return _G["GREEN_FONT_COLOR_CODE"]..text.._G["FONT_COLOR_CODE_CLOSE"];
	end
end

function TitanUtils_GetBlueText(text)
	if (text) then
		return "|cff0000ff"..text.._G["FONT_COLOR_CODE_CLOSE"];
	end
end

function TitanUtils_GetNormalText(text)
	if (text) then
		return _G["NORMAL_FONT_COLOR_CODE"]..text.._G["FONT_COLOR_CODE_CLOSE"];
	end
end

function TitanUtils_GetHighlightText(text)
	if (text) then
		return _G["HIGHLIGHT_FONT_COLOR_CODE"]..text.._G["FONT_COLOR_CODE_CLOSE"];
	end
end

function TitanUtils_GetColoredText(text, color)
	if (text and color) then
		local redColorCode = format("%02x", color.r * 255);		
		local greenColorCode = format("%02x", color.g * 255);
		local blueColorCode = format("%02x", color.b * 255);		
		local colorCode = "|cff"..redColorCode..greenColorCode..blueColorCode;
		return colorCode..text.._G["FONT_COLOR_CODE_CLOSE"];
	end
end

function TitanUtils_GetThresholdColor(ThresholdTable, value)
	if ( not tonumber(value) or type(ThresholdTable) ~= "table" or
			ThresholdTable.Values == nil or ThresholdTable.Colors == nil or
			table.getn(ThresholdTable.Values) >= table.getn(ThresholdTable.Colors) ) then
		return _G["GRAY_FONT_COLOR"];
	end

	local n = table.getn(ThresholdTable.Values) + 1;
	for i = 1, n do 
		local low = TitanUtils_Ternary(i == 1, nil, ThresholdTable.Values[i-1]);
		local high = TitanUtils_Ternary(i == n, nil, ThresholdTable.Values[i]);
		
		if ( not low and not high ) then
			-- No threshold values
			return ThresholdTable.Colors[i];
			
		elseif ( not low and high ) then
			-- Value is smaller than the first threshold			
			if ( value < high ) then return ThresholdTable.Colors[i] end
			
		elseif ( low and not high ) then
			-- Value is larger than the last threshold
			if ( low <= value ) then return ThresholdTable.Colors[i] end
			
		else
			-- Value is in between 2 adjacent thresholds
			if ( low <= value and value < high ) then return ThresholdTable.Colors[i] end
		end
	end
	
	-- Should never reach here
	return _G["GRAY_FONT_COLOR"];
end

function TitanUtils_ToString(text) 
	return TitanUtils_Ternary(text, text, "");
end

--
-- Right click menu routines
--
function TitanUtils_CloseRightClickMenu()
	if (DropDownList1:IsVisible()) then
		DropDownList1:Hide();
	end
end

function TitanRightClickMenu_OnLoad(self)
	local id = TitanUtils_GetButtonIDFromMenu(self);
	if id then
		local prepareFunction = _G["TitanPanelRightClickMenu_Prepare"..id.."Menu"];
		if prepareFunction and type(prepareFunction) == "function" then
			-- Nasty "hack", load Blizzard_Calendar if not loaded, for it to secure init 24 dropdown menu buttons, to avoid action blocked by tainting
			if (self:GetName() == "TitanPanelBarButtonRightClickMenu" or self:GetName() == "TitanPanelAuxBarButtonRightClickMenu") and not IsAddOnLoaded("Blizzard_Calendar") then LoadAddOn("Blizzard_Calendar") end
		 	UIDropDownMenu_Initialize(self, prepareFunction, "MENU");
		end
	end
end

function TitanPanelRightClickMenu_Toggle(self, isChildButton)
	local position = TitanPanelGetVar("Position");
	local x, y = GetCursorPosition(UIParent);
	
	TITAN_PANEL_SELECTED = TitanUtils_GetButtonID(self:GetName())
	-- Toggle menu
	if isChildButton then
		local parent = self:GetParent():GetName();
		TITAN_PANEL_SELECTED = TitanUtils_GetButtonID(parent)
	end

	local i = TitanPanel_GetButtonNumber(TITAN_PANEL_SELECTED)
	
	if TITAN_PANEL_SELECTED ~= "Bar" and TITAN_PANEL_SELECTED ~= "AuxBar" then
		if TitanPanelSettings.Location[i] ~= nil then
			TITAN_PANEL_SELECTED = TitanPanelSettings.Location[i]
		else
	  		TitanPanelSettings.Location[i] = "Bar"
  	 		TITAN_PANEL_SELECTED = "Bar"
		end
	end
	-- fix for Right-Click menu on the DoubleBar	
	local menu;	
   if self:GetName() == "TitanPanelBarButtonHider" then
   	menu = _G["TitanPanelBarButtonRightClickMenu"]
   elseif self:GetName() == "TitanPanelAuxBarButtonHider" then
   	menu = _G["TitanPanelAuxBarButtonRightClickMenu"]
   else
	 	menu = _G[self:GetName().."RightClickMenu"];
	 end
	 
	if TITAN_PANEL_SELECTED == "Bar" and position == TITAN_PANEL_PLACE_TOP then
		menu.point = "TOPLEFT";
		menu.relativePoint = "BOTTOMLEFT";
	else 
		menu.point = "BOTTOMLEFT";
		menu.relativePoint = "TOPLEFT";
	end
	
	-- take UI Scale into consideration
	local listFrame = _G["DropDownList1"];
	local listframeScale = listFrame:GetScale();
	
				local uiScale;
				local uiParentScale = UIParent:GetScale();
				
				if ( GetCVar("useUIScale") == "1" ) then
						uiScale = tonumber(GetCVar("uiscale"));
						if ( uiParentScale < uiScale ) then
									uiScale = uiParentScale;
						end
				else
						uiScale = uiParentScale;
				end
				
				x = x/uiScale;
				y = y/uiScale;

	listFrame:SetScale(uiScale);
	
	ToggleDropDownMenu(1, nil, menu, "TitanPanel" .. TITAN_PANEL_SELECTED .. "Button", TitanUtils_Max(x - 40, 0), 0, nil, self);
	
	local listFrame = _G["DropDownList"..UIDROPDOWNMENU_MENU_LEVEL];
	local offscreenX, offscreenY = TitanUtils_GetOffscreen(listFrame);

	if offscreenX == 1 then
		if TITAN_PANEL_SELECTED == "Bar" and position == TITAN_PANEL_PLACE_TOP then 
			listFrame:ClearAllPoints();
			listFrame:SetPoint("TOPRIGHT", "TitanPanel" .. TITAN_PANEL_SELECTED .. "Button", "BOTTOMLEFT", x, 0);
		else
			listFrame:ClearAllPoints();
			listFrame:SetPoint("BOTTOMRIGHT", "TitanPanel" .. TITAN_PANEL_SELECTED .. "Button", "TOPLEFT", x, 0);
		end	
	end
end

function TitanPanelRightClickMenu_IsVisible()
	return _G["DropDownList1"]:IsVisible();
end

function TitanPanelRightClickMenu_Close()
	_G["DropDownList1"]:Hide();
end

function TitanPanelRightClickMenu_AddTitle(title, level)
	if (title) then
		local info = {};
		info.text = title;
		info.notClickable = 1;
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info, level);
	end
end

function TitanPanelRightClickMenu_AddCommand(text, value, functionName, level)
	local info = {};
	info.text = text;
	info.value = value;
	info.func = function()
	local callback = _G[functionName];
-- callback must be a function else do nothing (spank developer)
		if callback and type(callback)== "function" then 
			callback(value)
		end
	end
	UIDropDownMenu_AddButton(info, level);
end

function TitanPanelRightClickMenu_AddSpacer(level)
	local info = {};
	info.disabled = 1;
	UIDropDownMenu_AddButton(info, level);
end

function TitanPanelRightClickMenu_Hide(value) 
	TitanPanel_RemoveButton(value);
end

function TitanPanelRightClickMenu_AddToggleVar(text, id, var, toggleTable)
	local info = {};
	info.text = text;
	info.value = {id, var, toggleTable};
	info.func = function()
		TitanPanelRightClickMenu_ToggleVar({id, var, toggleTable})
	end
	info.checked = TitanGetVar(id, var);
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
end

function TitanPanelRightClickMenu_AddToggleIcon(id)
	TitanPanelRightClickMenu_AddToggleVar(L["TITAN_PANEL_MENU_SHOW_ICON"], id, "ShowIcon");
end

function TitanPanelRightClickMenu_AddToggleLabelText(id)
	TitanPanelRightClickMenu_AddToggleVar(L["TITAN_PANEL_MENU_SHOW_LABEL_TEXT"], id, "ShowLabelText");
end

function TitanPanelRightClickMenu_AddToggleColoredText(id)
	TitanPanelRightClickMenu_AddToggleVar(L["TITAN_PANEL_MENU_SHOW_COLORED_TEXT"], id, "ShowColoredText");
end

function TitanPanelRightClickMenu_ToggleVar(value)
local id,var, toggleTable = nil;
	
  -- table expected else do nothing  
	if type(value)~="table" then return end
	
	if value and value[1] then id = value[1] end
	if value and value[2] then var = value[2] end
	if value and value[3] then toggleTable = value[3] end

	-- Toggle var
	TitanToggleVar(id, var);
	
	if ( TitanPanelRightClickMenu_AllVarNil(id, toggleTable) ) then
		-- Undo if all vars in toggle table nil
		TitanToggleVar(id, var);
	else
		-- Otherwise continue and update the button
		TitanPanelButton_UpdateButton(id, 1);
	end
	
end

function TitanPanelRightClickMenu_AllVarNil(id, toggleTable)
	if ( toggleTable ) and type(toggleTable)== "table" then
		for i, v in toggleTable do
			if ( TitanGetVar(id, v) ) then
				return;
			end
		end	
		return 1;
	end	
end

function TitanPanelRightClickMenu_ToggleColoredText(value)
	TitanToggleVar(value, "ShowColoredText");
	TitanPanelButton_UpdateButton(value, 1);
end

--
-- Deprecated routines
--
--[[
function TitanUtils_GetPreviousButton(table, id, isSameType, ignoreClock)	
	local index = TitanUtils_GetCurrentIndex(table, id);
	local isIcon = TitanPanelButton_IsIcon(id);	
	local previousButton, isPreviousIcon;
	
	if ( isSameType ) then
		-- Get the previous button with the same type
		while ( index > 1 ) do
			previousButton = TitanUtils_GetButton(table[index - 1]);
			isPreviousIcon = TitanPanelButton_IsIcon(table[index - 1]);
			
			if ( ( isIcon and isPreviousIcon ) or ( not isIcon and not isPreviousIcon ) ) then
				if ( ( table[index - 1] == TITAN_CLOCK_ID ) and ignoreClock ) then
					-- Do nothing, ignore Clock button
				else
					return previousButton;
				end
			end
			
			index = index - 1;
		end
	else
		-- Simply get the previous button
		if ( index > 1 ) then
			return TitanUtils_GetButton(table[index - 1]);
		end		
	end
end
--]]
--[[
function TitanUtils_GetNextButton(table, id, isSameType, ignoreClock)	
	local index = TitanUtils_GetCurrentIndex(table, id);
	local isIcon = TitanPanelButton_IsIcon(id);	
	local nextButton, isNextIcon;
	
	if ( isSameType ) then
		-- Get the next button with the same type
		while ( table[index + 1] ) do
			nextButton = TitanUtils_GetButton(table[index + 1]);
			isNextIcon = TitanPanelButton_IsIcon(table[index + 1]);
			
			if ( ( isIcon and isNextIcon ) or ( not isIcon and not isNextIcon ) ) then
				if ( ( table[index + 1] == TITAN_CLOCK_ID ) and ignoreClock ) then
					-- Do nothing, ignore Clock button
				else
					return nextButton;
				end
			end
			
			index = index + 1;
		end
	else
		-- Simply get the next button
		if ( table[index + 1] ) then
			return TitanUtils_GetButton(table[index + 1]);
		end		
	end
end
--]]
--[[
function TitanUtils_GetLastButton(array, isSameType, isIcon, ignoreClock)	
	local lastButton, isLastIcon;
	local size = table.getn(array);
	local index = size;
	
	if ( isSameType ) then
		-- Get the last button with the same type
		while ( index > 0 ) do
			lastButton = TitanUtils_GetButton(array[index]);
			isLastIcon = TitanPanelButton_IsIcon(array[index]);

			if ( ( isIcon and isLastIcon ) or ( not isIcon and not isLastIcon ) ) then
				if ( ( array[index] == TITAN_CLOCK_ID ) and ignoreClock ) then
					-- Do nothing, ignore Clock button
				else
					return lastButton;
				end
			end
			
			index = index - 1;
		end
	else
		-- Simply get the last button
		if ( size > 0 ) then
			return TitanUtils_GetButton(array[size]);
		end		
	end
end
--]]
--[[
function TitanUtils_GetCPNIndexInArray(array, value)
	if (not array) then
		return;
	end
	
	local currentIndex, previousIndex, nextIndex;
	for i, v in array do
		if (v == value) then
			currentIndex = i;
		end
	end
	
	if (currentIndex > 1) then
		previousIndex = currentIndex - 1;
	end
	
	if (array[currentIndex + 1]) then
		nextIndex = currentIndex + 1;
	end
	
	return currentIndex, previousIndex, nextIndex;
end
--]]
--[[
function TitanUtils_FindInventoryItemWithText(name, description)
	local bagNum;
	
	TitanPanelTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	for bagNum = 0, 4 do
		local itemInBagNum;
		for itemInBagNum = 1, GetContainerNumSlots(bagNum) do
			local i;
			local text = TitanUtils_GetItemName(bagNum, itemInBagNum);
			--Loop through tooltip
			for i = 1, 15, 1 do
				local field = _G["TitanPanelTooltipTextLeft" .. i];
				if (field ~= nil) then
					local text = field:GetText();
					if (i == 1) then
						if ((name ~= nil) and (text ~= name)) then
							break;
						else
							if (description == nil) then
								return bagNum, itemInBagNum;
							end
						end
					else
						if text ~=nil then
							if (string.find(text,description)) then
								return bagNum, itemInBagNum;
							end
						end
					end
				end
			end
		end
	end
	return nil;
end
--]]
--[[
-- **************************************************************************
-- NAME : TitanUtils_FindInventoryItemWithTextAndSlot(name, description, slotnum)
-- DESC : <research>
-- VARS : <research>
-- **************************************************************************
function TitanUtils_FindInventoryItemWithTextAndSlot(name, description, slotnum)
     local bagNum;
     
     TitanPanelTooltip:SetOwner(UIParent, "ANCHOR_NONE");
     for bagNum = 0, 4 do
          local itemInBagNum;
          for itemInBagNum = 1, GetContainerNumSlots(bagNum) do
               local i;
               local text = TitanUtils_GetItemName(bagNum, itemInBagNum);
               --Loop through tooltip
               for i = 1, 15, 1 do
                    local field = _G["TitanPanelTooltipTextLeft" .. i];
                    if (field ~= nil) then
                         local text = field:GetText();
                         if ((i == 1) and (slotnum > 2)) then
                              if (text ~= name) then
                                   break;
                              else
                                   return bagNum, itemInBagNum;
                              end
                         else
                              if text ~=nil then
                                   if (string.find(text,description)) then
                                        return bagNum, itemInBagNum;
                                   end
                              end
                         end
                    end
               end
          end
     end
     return nil;
end
--]]
--[[
function TitanUtils_GetItemName(bag, slot)
	local bagNumber = bag;
	local name = "";
	if ( type(bagNumber) ~= "number" ) then
		bagNumber = tonumber(bag);
	end
	TitanPanelTooltip:SetBagItem(bag, slot);
	name = TitanPanelTooltipTextLeft1:GetText();
	if name == nil then
		name = "";
	end
	return name;
end
--]]
