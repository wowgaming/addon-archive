
-----------------------------------------------------------------
--   LibDataBrokerToTitan, a "bridge" module to ensure proper
--   registration and communication of LDB plugins with
--   Titan Panel (work in progress)
--
--   By Titan Dev team
--   Originally by Tristanian aka "TristTitan" as a Titan member
--   Created and initially commited on : July 29th, 2008
-----------------------------------------------------------------

local xcategories = {
-- Titan categories mapping to match addon metadata information
	["Combat"] = "Combat",
	["General"] = "General",
	["Information"] = "Information",
	["Interface"] = "Interface",
	["Profession"] = "Profession",
-- Ace2 table mapping to Titan categories in order to match addon metadata information
	["Action Bars"] = "Interface",
	["Auction"] = "Information",
	["Audio"] = "Interface",
	["Battlegrounds/PvP"] = "Information",
	["Buffs"] = "Information",
	["Chat/Communication"] = "Interface",
	["Druid"] = "Information",
	["Hunter"] = "Information",
	["Mage"] = "Information",
	["Paladin"] = "Information",
	["Priest"] = "Information",
	["Rogue"] = "Information",
	["Shaman"] = "Information",
	["Warlock"] = "Information",
	["Warrior"] = "Information",
	["Healer"] = "Information",
	["Tank"] = "Information",
	["Caster"] = "Information",
--	["Combat"] = "Combat",
	["Compilations"] = "General",
	["Data Export"] = "General",
	["Development Tools "] = "General",
	["Guild"] = "Information",
	["Frame Modification"] = "Interface",
	["Interface Enhancements"] = "Interface",
	["Inventory"] = "Information",
	["Library"] = "General",
	["Map"] = "Interface",
	["Mail"] = "Information",
	["Miscellaneous"] = "General",
	["Misc"] = "General",
	["Quest"] = "Information",
	["Raid"] = "Information",
	["Tradeskill"] = "Profession",
	["UnitFrame"] = "Interface",
}

-- Unsupported Data Object types table
-- August 19th: Added all the "garbage" dataobject types created by Tweetcraft
local UnsupportedDOTypes = { "cork", "IncomingTweet", "Reply", "OutgoingTweet", "AutoTweetCategory", "AutoTweetAddOn"}

local _G = getfenv(0);
local InCombatLockdown	= _G.InCombatLockdown;
local LDBToTitan = CreateFrame("Frame", "LDBTitan")
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local Tablet, LibQTip = nil, nil
local media = LibStub("LibSharedMedia-3.0")
local LDBAttrs = {};
local AceTimer = LibStub("AceTimer-3.0")
local iconTitanDefault = "Interface\\PVPFrame\\\PVP-ArenaPoints-Icon"; -- generic icon in case the DO does not provide one

LDBToTitan:RegisterEvent("PLAYER_LOGIN")
LDBToTitan:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Couple of functions to properly anchor tooltips for Titan (LDB) objects with a generic frame and function as args

function LDBToTitan:TitanLDBSetOwnerPosition(parent, anchorPoint, relativeToFrame, relativePoint, xOffset, yOffset, frame)

	if frame:GetName() == "GameTooltip" then
		frame:SetOwner(parent, "ANCHOR_NONE");
		-- set alpha (transparency) for the Game Tooltip
		local red, green, blue = GameTooltip:GetBackdropColor();
		local red2, green2, blue2 = GameTooltip:GetBackdropBorderColor();
		frame:SetBackdropColor(red,green,blue,TitanPanelGetVar("TooltipTrans"));
		frame:SetBackdropBorderColor(red2,green2,blue2,TitanPanelGetVar("TooltipTrans"));

		-- set font size for the Game Tooltip
		if not TitanPanelGetVar("DisableTooltipFont") then
			if TitanTooltipScaleSet < 1 then
				TitanTooltipOrigScale = GameTooltip:GetScale();
				TitanTooltipScaleSet = TitanTooltipScaleSet + 1;
			end
			frame:SetScale(TitanPanelGetVar("TooltipFont"));
		end

	end
	frame:ClearAllPoints();
	frame:SetPoint(anchorPoint, relativeToFrame, relativePoint, xOffset, yOffset);
end

function LDBToTitan:TitanLDBSetTooltip(name, frame, func)
-- Check to see if we allow tooltips to be shown
  if not TitanPanelGetVar("ToolTipsShown") or (TitanPanelGetVar("HideTipsInCombat") and InCombatLockdown()) then return end
	-- Set custom DO tooltip
	local button = TitanUtils_GetButton(name);
	local position = TitanPanelGetVar("Position");
	local scale = TitanPanelGetVar("Scale");	
	local offscreenX, offscreenY;
	local i = TitanPanel_GetButtonNumber(name);

	if (TitanPanelSettings.Location[i] == "Bar") then 
		if position == TITAN_PANEL_PLACE_TOP then
			self:TitanLDBSetOwnerPosition(button, "TOPLEFT", button:GetName(), "BOTTOMLEFT", -10, -4 * scale, frame);
			
			-- Adjust frame position if it's off the screen
			offscreenX, offscreenY = TitanUtils_GetOffscreen(frame);
			if ( offscreenX == -1 ) then
				self:TitanLDBSetOwnerPosition(button, "TOPLEFT", "TitanPanelBarButton", "BOTTOMLEFT", 0, 0, frame);
			elseif ( offscreenX == 1 ) then
				self:TitanLDBSetOwnerPosition(button, "TOPRIGHT", "TitanPanelBarButton", "BOTTOMRIGHT", 0, 0, frame);
			end
				
		else
			self:TitanLDBSetOwnerPosition(button, "BOTTOMLEFT", button:GetName(), "TOPLEFT", -10, 4 * scale, frame);	
			-- Adjust frame position if it's off the screen
			offscreenX, offscreenY = TitanUtils_GetOffscreen(frame);
			if ( offscreenX == -1 ) then
				self:TitanLDBSetOwnerPosition(button, "BOTTOMLEFT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "TOPLEFT", 0, 0, frame);
			elseif ( offscreenX == 1 ) then
				self:TitanLDBSetOwnerPosition(button, "BOTTOMRIGHT", "TitanPanel" .. TitanPanelSettings.Location[i] .."Button", "TOPRIGHT", 0, 0, frame);
			end
		end
	else
		self:TitanLDBSetOwnerPosition(button, "BOTTOMLEFT", button:GetName(), "TOPLEFT", -10, 4 * scale, frame);
		-- Adjust frame position if it's off the screen
		offscreenX, offscreenY = TitanUtils_GetOffscreen(frame);
		if ( offscreenX == -1 ) then
			self:TitanLDBSetOwnerPosition(button, "BOTTOMLEFT", "TitanPanelAuxBarButton", "TOPLEFT", 0, 0, frame);
		elseif ( offscreenX == 1 ) then
			self:TitanLDBSetOwnerPosition(button, "BOTTOMRIGHT", "TitanPanelAuxBarButton", "TOPRIGHT", 0, 0, frame);
		end
	end
	
	if func then func(frame) end;
	frame:Show();
end


-- Script Handler goes here
function LDBToTitan:TitanLDBHandleScripts(event, name, _, func, obj)
	--DEFAULT_CHAT_FRAME:AddMessage("LDB:"..name..".".. event.. " is fired.")
	local TitanPluginframe = _G["TitanPanel".."LDBT_"..name.."Button"];
	
	-- This implementation will work fine for a static tooltip
	-- but may have implications for dynamic ones
	-- so for now, we'll only set it once (no callback) and see what happens
	
	if event:find("tooltip") and not event:find("OnTooltipShow") then		
		local pluginframe = _G[obj.tooltip] or obj.tooltip
		if pluginframe then
			TitanPluginframe:SetScript("OnEnter", function(self)
				TitanPanelButton_OnEnter(self);
				--if obj.OnEnter then
				--obj.OnEnter(self)
				--end
				LDBToTitan:TitanLDBSetTooltip("LDBT_"..name, pluginframe, nil)
				end
			)

			TitanPluginframe:SetScript("OnMouseDown", function(self)
				pluginframe:Hide();			 		
				end
			)	

			if pluginframe:GetScript("OnLeave") then
				-- do nothing
			else
				TitanPluginframe:SetScript("OnLeave", function(self)
					if obj.OnLeave then
					obj.OnLeave(self)
					end
					pluginframe:Hide();
					TitanPanelButton_OnLeave(self);
					end
				)
			end

			if pluginframe:GetName()~="GameTooltip" then
				if pluginframe:GetScript("OnShow") then
					-- do nothing
				else
					pluginframe:SetScript("OnShow", function(self)
						LDBToTitan:TitanLDBSetTooltip("LDBT_"..name, pluginframe, nil)
						end
					)
				end
			end			 		       			        			 	
		end

	elseif event:find("OnTooltipShow") then
		TitanPluginframe:SetScript("OnEnter", function(self)
			if TITAN_PANEL_MOVING == 0 and func then				
				LDBToTitan:TitanLDBSetTooltip("LDBT_"..name, GameTooltip, func);
			end
				TitanPanelButton_OnEnter(self);
			end
		)
		TitanPluginframe:SetScript("OnLeave", function(self) 
			GameTooltip:Hide();
			TitanPanelButton_OnLeave(self);
			end
		)

	elseif event:find("OnDoubleClick") and not event:find("OnClick") then
		TitanPluginframe:SetScript("OnDoubleClick", function(self, button)
			if TITAN_PANEL_MOVING == 0 then
				func(self, button) 
			end	  	
			end
		)	
		
	elseif event:find("OnClick") then
		TitanPluginframe:SetScript("OnClick", function(self, button)
			if TITAN_PANEL_MOVING == 0 then
				func(self, button) 
			end
			-- implement a safeguard, since the DO may actually use Blizzy dropdowns !
			if not TitanPanelRightClickMenu_IsVisible() then
				TitanPanelButton_OnClick(self, button);
			else
				TitanUtils_CloseAllControlFrames();
			end
			end
		)	  
	else
	
		TitanPluginframe:SetScript("OnEnter", function(self)
			-- Check for tooltip libs without embedding them 
			if AceLibrary and AceLibrary:HasInstance("Tablet-2.0") then Tablet = AceLibrary("Tablet-2.0") end
			LibQTip = LibStub("LibQTip-1.0", true)
			-- Check to see if we allow tooltips to be shown
			if not TitanPanelGetVar("ToolTipsShown") or (TitanPanelGetVar("HideTipsInCombat") and InCombatLockdown()) then
				-- if a plugin is using tablet, then detach and close the tooltip
				if Tablet and Tablet:IsRegistered(TitanPluginframe) and Tablet:IsAttached(TitanPluginframe) then
					Tablet:Detach(TitanPluginframe);
					Tablet:Close(TitanPluginframe);
				end
				return;
			else			
				-- if a plugin is using tablet, then re-attach the tooltip (it will auto-open on mouseover)
				if Tablet and Tablet:IsRegistered(TitanPluginframe) and not Tablet:IsAttached(TitanPluginframe) then
					Tablet:Attach(TitanPluginframe);
				end
			end
			-- if a plugin is using tablet then set its transparency and font size accordingly
			if Tablet and Tablet:IsRegistered(TitanPluginframe) then
				Tablet:SetTransparency(TitanPluginframe, TitanPanelGetVar("TooltipTrans"))
				if not TitanPanelGetVar("DisableTooltipFont") then
					Tablet:SetFontSizePercent(TitanPluginframe, TitanPanelGetVar("TooltipFont"))
				elseif TitanPanelGetVar("DisableTooltipFont") and Tablet:GetFontSizePercent(TitanPluginframe)~=1 then
					Tablet:SetFontSizePercent(TitanPluginframe, 1)
				end				
			end
			-- set original tooltip scale for GameTooltip
			if not TitanPanelGetVar("DisableTooltipFont") then
				TitanTooltipOrigScale = GameTooltip:GetScale();
			end
			-- call OnEnter on LDB Object
			if TITAN_PANEL_MOVING == 0 and func then
				func(self)
			end
			TitanPanelButton_OnEnter(self);			
			-- LibQTip-1.0 support code
			if LibQTip then
				local tt = nil
				local key, tip
				for key, tip in LibQTip:IterateTooltips() do
					if tip then
						local _, relativeTo = tip:GetPoint()
						if relativeTo and relativeTo:GetName() == TitanPluginframe:GetName() then
							tt = tip
							break
						end
					end
				end
				if tt then
					-- set transparency
					local red, green, blue, _ = tt:GetBackdropColor()
					local red2, green2, blue2, _ = tt:GetBackdropBorderColor()
					tt:SetBackdropColor(red,green,blue,TitanPanelGetVar("TooltipTrans"))
					tt:SetBackdropBorderColor(red2,green2,blue2,TitanPanelGetVar("TooltipTrans"))				
				end
			end
			-- /LibQTip-1.0 support code
			end
		)
		
		TitanPluginframe:SetScript("OnLeave", function(self)
			if obj.OnLeave then 
			obj.OnLeave(self) 
			end
			TitanPanelButton_OnLeave(self);
			end
		)
	end
end

-- Text Update Handlers go here
function LDBToTitan:TitanLDBTextUpdate(_, name,  attr, value, dataobj)
	-- just in case the LDB is active before Titan can register it...
	if not Titan__InitializedPEW then
		return
	end
	-- This check is overkill but just in case...
	if not LDBAttrs[name] then
--	DEFAULT_CHAT_FRAME:AddMessage("LDB: '"..name.."' was not registered")
		return
	end
--[[
	if attr and value then
	DEFAULT_CHAT_FRAME:AddMessage("LDB: '"..name.."'.".. attr.. " was changed to '".. tostring(value).."'")
	end
--]]
	if attr == "value" then
		LDBAttrs[name].value = value;
	end
	if attr == "suffix" then
		LDBAttrs[name].suffix = value;
	end
	if attr == "text" then
		LDBAttrs[name].text = value;
	end
	if attr == "label" then
		LDBAttrs[name].label = value;
	end
	TitanPanelButton_UpdateButton("LDBT_"..name)
end

function TitanLDBRefreshButton()
			-- Ensure all the LDB buttons are updated 
			-- This is called once x seconds after PEW. This helps close the gap where LDB
			-- addons set their text on their PEW event
			for name, obj in ldb:DataObjectIterator() do
--[[
TitanDebug("TitanLDBRefreshButton "
				.."'"..name.."'"
				..": '"..(obj.text or "?").."'"
				..": '"..(obj.icon or iconTitanDefault).."'"
				)
--]]
				if LDBAttrs[name] then
					LDBToTitan:TitanLDBTextUpdate(_, name, "text", (obj.text or ""), obj)
					LDBToTitan:TitanLDBIconUpdate(_, name, "icon", (obj.icon or iconTitanDefault), obj)
				else
--	DEFAULT_CHAT_FRAME:AddMessage("LDB: '"..name.."' no refresh")
				end
			end
end

function TitanLDBShowText(name)
	-- Set 'label1' and 'value1' for the Titan button display
	local nametrim = string.gsub (name, "LDBT_", "");
	local fontstring = _G["TitanPanelLDBT_"..nametrim.."ButtonText"];
	local displayValue, displaySuffix, displayText = "", "", ""
	local separator = ": "
	local lab1, val1 = "", ""

	-- Check for display text
	if TitanGetVar(name, "ShowRegularText") then
		if LDBAttrs[nametrim].value then displayValue = LDBAttrs[nametrim].value end
		if LDBAttrs[nametrim].suffix then displaySuffix = LDBAttrs[nametrim].suffix end
		if LDBAttrs[nametrim].text then displayText = LDBAttrs[nametrim].text end
	else
		separator = ""
	end
  
	-- Fix color text issues
	if TitanGetVar(name, "ShowColoredText") then
		fontstring:SetTextColor(0,255,0); -- Green
	else
		fontstring:SetTextColor(255,255,255); -- Highlight
	end
  
	if LDBAttrs[nametrim].suffix and LDBAttrs[nametrim].suffix ~="" then   	
		val1 = displayValue.." "..displaySuffix
		val1 = TitanGetVar(name, "ShowColoredText") and TitanUtils_GetGreenText(val1) or TitanUtils_GetHighlightText(val1)
		lab1 = ""
		if LDBAttrs[nametrim].label and LDBAttrs[nametrim].label~="" then
			lab1 = TitanUtils_GetNormalText(LDBAttrs[nametrim].label)..separator
		end
	elseif LDBAttrs[nametrim].label == LDBAttrs[nametrim].text then
		val1 = ""
		lab1 = displayText
		lab1 = TitanGetVar(name, "ShowColoredText") and TitanUtils_GetGreenText(lab1) or TitanUtils_GetHighlightText(lab1)
   else    
		val1 = displayText
		val1 = TitanGetVar(name, "ShowColoredText") and TitanUtils_GetGreenText(val1) or TitanUtils_GetHighlightText(val1)
		lab1 = ""
		if LDBAttrs[nametrim].label and LDBAttrs[nametrim].label~="" then
			lab1 = TitanUtils_GetNormalText(LDBAttrs[nametrim].label)..separator
		end
	end
	
	return lab1, val1
end

-- Icon Handler goes here
function LDBToTitan:TitanLDBIconUpdate(_, name,  attr, value, dataobj)
	-- just in case the LDB is active before Titan can register it...
	if not Titan__InitializedPEW then
		return
	end
	-- This check is overkill but just in case...
	if not LDBAttrs[name] then
--	DEFAULT_CHAT_FRAME:AddMessage("LDB: '"..name.."' was not registered")
		return
	end

	if attr == "icon" then
--[[
TitanDebug("TitanLDBIconUpdate "
				.."'"..name.."'"
				..": '"..(attr or "?").."'"
				..": '"..(value or "?").."'"
				)
--]]
		TitanPlugins["LDBT_"..name].icon = value;
		TitanPanelButton_SetButtonIcon("LDBT_"..name);
	end

	-- support for iconCoords, iconR, iconG, iconB attributes
	if attr == "iconCoords" then
		TitanPanelButton_SetButtonIcon("LDBT_"..name, value);
	end

	if attr == "iconR" or attr == "iconB" or attr == "iconG" then 
		TitanPanelButton_SetButtonIcon("LDBT_"..name, nil, dataobj.iconR, dataobj.iconG, dataobj.iconB);
	end
end

-- New DO gets created here
function LDBToTitan:TitanLDBCreateObject(_, name, obj)
   -- phear the custom obj.type !
   -- Regular DO's should be fine 
   -- Launchers are being treated as a DO but may change behavior from within Titan core 
	--(right-side plugins with only an icon and a tooltip/Click)

   --DEFAULT_CHAT_FRAME:AddMessage("Attempting to register "..name..".");
   
   -- Unsupported Data Object types
	for idx in ipairs(UnsupportedDOTypes) do
		if obj.type and obj.type == UnsupportedDOTypes[idx] then
--[[
			DEFAULT_CHAT_FRAME:AddMessage("LDBToTitan: '"..(name or "LDB?").."' "
				.."failed to register - "
				.."Unsupported LDB type '"..UnsupportedDOTypes[idx].."'");
--]]
			local plugin = 
				{
				self = nil,
				button = nil,
				isChild = nil,
				name = (name or "?"),
				issue = "Unsupported LDB type", 
				status = TITAN_REGISTER_FAILED,
				category = nil,
				plugin_type = obj.type,
				}
			TitanUtils_PluginFail(plugin) -- let the developer / user know
			return 
		end
	end
	-- End Unsupported Data Object types
		
	LDBAttrs[name] = {};
	LDBAttrs[name].name = name;

--[[
			DEFAULT_CHAT_FRAME:AddMessage("LDBToTitan: '"..(name or "LDB?").."' "
				.."to register - "
				)
--]]
	-- Handle the attributes of the DO and register the appropriate callbacks (where applicable)
	--
	if obj.type then
		LDBAttrs[name].type = obj.type;
	end

	if obj.label and obj.label~="" then
		LDBAttrs[name].label = obj.label;
	else
		LDBAttrs[name].label = "";
	end

	-- Handle the case when the label changes
	ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_label", "TitanLDBTextUpdate")

	-- Build the elements of the text to display on the button
	if obj.suffix then
		LDBAttrs[name].suffix = obj.suffix;
		LDBAttrs[name].value = obj.value or "?";
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_value", "TitanLDBTextUpdate")
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_suffix", "TitanLDBTextUpdate")
	elseif obj.text then
		LDBAttrs[name].text = obj.text;       	       	
		-- detect launchers that use the text attribute, but no separate label *sigh*
		if obj.type == "launcher" and not obj.label then
			LDBAttrs[name].label = obj.text
		end

		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_text", "TitanLDBTextUpdate")
	else
		-- this is kind of a "hack" to avoid using a badly formatted addon name as text (needs testing)
		if obj.type == "launcher" and obj.label then 
			LDBAttrs[name].text = obj.label;
		-- detect launchers with no label and no text attribute
		elseif obj.type == "launcher" and not obj.label then 
			LDBAttrs[name].text = name;
			LDBAttrs[name].label = name;
		else
			LDBAttrs[name].text = name;
		end
		-- register the callback anyway in case a plugin changes text via a timed update
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_text", "TitanLDBTextUpdate") 
	end

	ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_icon", "TitanLDBIconUpdate")

	-- support for iconCoords, iconR, iconG, iconB attributes
	-- Due to the callbacks being fired these can easily affect performance, BEWARE when using them !
	if obj.iconCoords then
		self:TitanLDBIconUpdate(nil, name, "iconCoords", obj.iconCoords, obj)
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconCoords", "TitanLDBIconUpdate")
	end

	if obj.iconR and obj.iconG and obj.iconB then
		self:TitanLDBIconUpdate(nil, name, "iconR", obj.iconR, obj)
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconR", "TitanLDBIconUpdate")
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconG", "TitanLDBIconUpdate")
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_iconB", "TitanLDBIconUpdate")
	end

	--
	-- Create the Titan plugin for this LDB plugin
	--
	
	local idTitan, menuTextTitan, iconTitan, categoryTitan;

	idTitan = "LDBT_"..name;

	menuTextTitan = obj.label or name; -- per 1-1 spec if .label use it else use data object's name

	-- Handle the icon
	if obj.icon then
		iconTitan = obj.icon;
	else
		iconTitan = iconTitanDefault
	end
	-- Set the plugin category, if it exists else default to "General"
	-- We check for a tocname attrib first, if found we use it, if not...
	-- ..we assume that the DO "name" attribute is the same with the actual
	-- addon name, which might not always be the case.
	-- Even if it isn't though, Titan defaults again to "General"
	-- via a check in the menu implementation, later on.
	local addoncategory, addonversion;
	local tempname = obj.tocname or name;

	if IsAddOnLoaded(tempname) then
		addoncategory = GetAddOnMetadata(tempname, "X-Category");
		addonversion = GetAddOnMetadata(tempname, "Version");
	end

	if xcategories[addoncategory] then
		categoryTitan = xcategories[addoncategory];
	end
--[[
TitanDebug("TitanLDBCreateObject "
				.."tempname: '"..(tempname or "?").."'"
				.."X-Cat: '"..(addoncategory or "?").."'"
				.."cat: '"..(categoryTitan or "?").."'"
				)
--]]

   -- Compile the appropriate Titan registry for the DO
   local ldbtype = tostring(obj.type);
   
   -- Apparently some launchers are using a malformed spec by setting a "launcher" attribute to true
   -- so...(sigh) we need to compensate for this by...guessing that it MAY happen
   if obj.launcher and obj.type~="data source" and (obj.launcher == true or obj.launcher == yes or obj.launcher == "yes") then
   	ldbtype = "launcher";
   end
   
	local registry = {
		id = idTitan,
		ldb = ldbtype,
		menuText = menuTextTitan,
		buttonTextFunction = "TitanLDBShowText", 
		icon = iconTitan,     
		iconWidth = 16,          
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowRegularText = false,
			ShowColoredText = true,
			DisplayOnRightSide = true
		},
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowRegularText = 1,
			ShowColoredText = false,
			DisplayOnRightSide = false
		},
	};

--[[
TitanDebug("TitanLDBCreateObject "
				.."registry.id: '"..(registry.id or "?").."'"
				.."registry.ldb: '"..(registry.ldb or "?").."'"
				)
--]]
	if categoryTitan~="" then
		registry["category"]= categoryTitan;
	end

	if addonversion ~="" then
		registry["version"]= addonversion;
	end
	
	if ldbtype == "launcher" then
		registry["savedVariables"].DisplayOnRightSide = 1;
		-- one interpretation of the LDB spec is launchers hould always have an icon.
		registry["controlVariables"].ShowIcon = false;
	end
 
	if ldbtype == "data source" then
		registry["controlVariables"].ShowRegularText = true;
	end
 
	-- Create the Titan Frame as a Combo (for now)
	-- This will call the Titan _OnLoad to schedule the plugin to be registered
	local newTitanFrame = CreateFrame("Button","TitanPanel".."LDBT_"..name.."Button", UIParent, "TitanPanelComboTemplate")  
	newTitanFrame.registry = registry
	newTitanFrame:SetFrameStrata("FULLSCREEN");
	newTitanFrame:SetToplevel(true);
	newTitanFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp");

	-- Use the routines given by the DO in this precedence order tooltip > OnEnter > OnTooltipShow > 
	-- or register a callback in case it is created later.
	if obj.tooltip then       
		self:TitanLDBHandleScripts("tooltip", name, nil, obj.tooltip, obj)
		--ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_tooltip", "TitanLDBHandleScripts")
	elseif obj.OnEnter then       
		self:TitanLDBHandleScripts("OnEnter", name, nil, obj.OnEnter, obj)
	elseif obj.OnTooltipShow then
		self:TitanLDBHandleScripts("OnTooltipShow", name, nil, obj.OnTooltipShow, obj)
	else
		self:TitanLDBHandleScripts("OnEnter", name, nil, nil, obj)
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_OnEnter", "TitanLDBHandleScripts")
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_OnTooltipShow", "TitanLDBHandleScripts")
	end

	-- Use the OnClick given by the DO or register a callback in case it is created later.
	if obj.OnClick then
		self:TitanLDBHandleScripts("OnClick", name, nil, obj.OnClick)
	else
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_OnClick", "TitanLDBHandleScripts")
	end

	-- Use the OnDoubleClick given by the Do or register a callback in case it is created later.
	if obj.OnDoubleClick then
		self:TitanLDBHandleScripts("OnDoubleClick", name, nil, obj.OnDoubleClick)
	else
		ldb.RegisterCallback(self, "LibDataBroker_AttributeChanged_"..name.."_OnDoubleClick", "TitanLDBHandleScripts")
	end

	-- Creating the frame will schedule the plugin to be registered 
--	TitanPanelButton_OnLoad(newTitanFrame);
   
	-- if plugins have already been loaded then get this one loaded
	if Titan__InitializedPEW then
--		TitanDebug ("Register single LDB plugin: '"..(name or "LDB?").."'. See Attempts for results")
		
--==================
		-- Could be wasteful but we need to register this LDB plugin
		-- This should be a separate routine in Utils
		if TitanPluginToBeRegisteredNum > 0 then
			for index, value in ipairs(TitanPluginToBeRegistered) do
				if TitanPluginToBeRegistered[index] then
					TitanUtils_RegisterPlugin(TitanPluginToBeRegistered[index])
				end
			end
		end
		-- update the config (options)
		TitanUpdateConfigAddons()
		TitanUpdateAddonAttempts()
--==================

		-- Syncronize Plugins that were created after PLAYER_LOGIN
		if TitanPluginSettings then    
			TitanVariables_SyncPluginSettings();
			-- set plugin font
			local newfont, index, id;
			newfont = media:Fetch("font", TitanPanelGetVar("FontName"))					
			local button = TitanUtils_GetButton(idTitan);
			local buttonText = _G[button:GetName().."Text"];
			if buttonText then
				buttonText:SetFont(newfont, TitanPanelGetVar("FontSize"));
			end
			-- set plugin strata
			button:SetFrameStrata(TitanVariables_GetPanelStrata(TitanPanelGetVar("FrameStrata")))

			-- Add plugins created after PLAYER_ENTERING_WORLD to the bar (if they were shown on last logout)
			for i,_ in pairs(TitanPanelSettings.Buttons) do
				if TitanPanelSettings.Buttons[i] == idTitan then
					TITAN_PANEL_MOVE_ADDON = 1 -- dummy value to avoid unnecessary function calls in button init function
					TitanPanel_InitPanelButtons()
					TITAN_PANEL_MOVE_ADDON = nil
					break
				end
			end
		end
	end
end

LDBToTitan:SetScript("OnEvent", function(self, event, ...)
		if (event == "PLAYER_LOGIN") then	 
--			self:SetScript("OnEvent", nil) 
			self:UnregisterEvent("PLAYER_LOGIN")
			-- In case a LDB plugin is created later...
			ldb.RegisterCallback(self, "LibDataBroker_DataObjectCreated", "TitanLDBCreateObject")
			
			-- Register the LDB plugins that have been created 
			for name, obj in ldb:DataObjectIterator() do
				self:TitanLDBCreateObject(nil, name, obj)
				--DEFAULT_CHAT_FRAME:AddMessage("Registered "..name..".");
			end
		end
		if (event == "PLAYER_ENTERING_WORLD") then	 
			AceTimer.ScheduleTimer("LDBToTitanSetText", TitanLDBRefreshButton, 2);
		end
	end
)