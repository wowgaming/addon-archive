-- **************************************************************************
-- * TitanAmmo.lua
-- *
-- * By: TitanMod, Dark Imakuni, Adsertor and the Titan Development Team
-- *     (HonorGoG, jaketodd422, joejanko, Lothayer, Tristanian)
-- **************************************************************************

-- ******************************** Constants *******************************
local TITAN_AMMO_ID = "Ammo";
local TITAN_AMMO_THRESHOLD_TABLE = {
     Values = { 150, 400 },
     Colors = { RED_FONT_COLOR, NORMAL_FONT_COLOR, GREEN_FONT_COLOR },
}

-- ******************************** Variables *******************************
local class = select(2, UnitClass("player"))
local ammoSlotID = GetInventorySlotInfo("AmmoSlot")
local rangedSlotID = GetInventorySlotInfo("RangedSlot")
local count = 0;
local isThrown = nil;
local isAmmo = nil;
local currentlink = "";
local AmmoName = "";
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
-- ******************************** Functions *******************************

-- **************************************************************************
-- NAME : TitanPanelAmmoButton_OnLoad()
-- DESC : Registers the plugin upon it loading
-- **************************************************************************
function TitanPanelAmmoButton_OnLoad(self)
     self.registry = {
          id = TITAN_AMMO_ID,
--          builtIn = 1,
		category = "Built-ins",
          version = TITAN_VERSION,
          menuText = L["TITAN_AMMO_MENU_TEXT"],
          buttonTextFunction = "TitanPanelAmmoButton_GetButtonText", 
          tooltipTitle = L["TITAN_AMMO_TOOLTIP"],
          icon = "Interface\\AddOns\\TitanAmmo\\TitanThrown",
          iconWidth = 16,
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowRegularText = false,
			ShowColoredText = true,
			DisplayOnRightSide = false
		},
          savedVariables = {
               ShowIcon = 1,
               ShowLabelText = 1,
               ShowColoredText = 1,
               ShowAmmoName = false,
          }
     };     

self:SetScript("OnEvent",  function(_, event, arg1, ...)
				
		if event == "PLAYER_LOGIN" then
			TitanPanelAmmoButton_PLAYER_LOGIN()
		elseif event == "UNIT_INVENTORY_CHANGED" then
			TitanPanelAmmoButton_UNIT_INVENTORY_CHANGED(arg1, ...)
		elseif event == "UPDATE_INVENTORY_DURABILITY" then
			TitanPanelAmmoButton_UPDATE_INVENTORY_DURABILITY()
		elseif event == "MERCHANT_CLOSED" or event == "PLAYER_ENTERING_WORLD" then
			TitanPanelAmmoButton_MERCHANT_CLOSED()
		elseif event == "ACTIONBAR_HIDEGRID" then
			TitanPanelAmmoButton_ACTIONBAR_HIDEGRID()
		end
				
end)
	TitanPanelAmmoButton:RegisterEvent("PLAYER_LOGIN")
end


function TitanPanelAmmoButton_PLAYER_LOGIN()
-- Class check
if class ~= "ROGUE" and class ~= "WARRIOR" and class ~= "HUNTER" then
	TitanPanelAmmoButton_PLAYER_LOGIN = nil
	return
end

	local itemlink = GetInventoryItemLink("player", rangedSlotID)
	currentlink = itemlink;
	local loc = "";
		if itemlink then
			loc = select(9, GetItemInfo(itemlink))
		end
		if loc == "INVTYPE_THROWN" then
			TitanPanelAmmoButton:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
			isThrown = true;
			isAmmo = nil;			
		else
			TitanPanelAmmoButton:RegisterEvent("ACTIONBAR_HIDEGRID")			
			isAmmo = true;
			isThrown = nil;
		end
		TitanPanelAmmoButton:RegisterEvent("UNIT_INVENTORY_CHANGED")
		TitanPanelAmmoButton:RegisterEvent("MERCHANT_CLOSED")
		TitanPanelAmmoButton:RegisterEvent("PLAYER_ENTERING_WORLD") 
		TitanPanelAmmoButton_PLAYER_LOGIN = nil	
end


function TitanPanelAmmoButton_UNIT_INVENTORY_CHANGED(arg1, ...)
 if arg1 == "player" then
 	TitanPanelAmmoUpdateDisplay(); 	
 	if isAmmo then
  		if GetInventoryItemLink("player", ammoSlotID) then
				count = GetInventoryItemCount("player", ammoSlotID) or count
				AmmoName = GetItemInfo(GetInventoryItemLink("player", ammoSlotID)) or _G["UNKNOWN"]
			else
				count = 0;
				AmmoName = "";
			end
 		TitanPanelButton_UpdateButton(TITAN_AMMO_ID);
	end
 end
end

function TitanPanelAmmoButton_UPDATE_INVENTORY_DURABILITY()
	count = GetInventoryItemDurability(rangedSlotID) or count
	TitanPanelButton_UpdateButton(TITAN_AMMO_ID);
end

function TitanPanelAmmoButton_MERCHANT_CLOSED() 
 if isThrown then
 	count = GetInventoryItemDurability(rangedSlotID) or count
 elseif isAmmo and GetInventoryItemLink("player", ammoSlotID) then
	count = GetInventoryItemCount("player", ammoSlotID) or count
	AmmoName = GetItemInfo(GetInventoryItemLink("player", ammoSlotID)) or _G["UNKNOWN"]
 else
 --isThrown = nil;
 	count = 0;
 	AmmoName = "";
 end
	TitanPanelButton_UpdateButton(TITAN_AMMO_ID);
end


function TitanPanelAmmoButton_ACTIONBAR_HIDEGRID()
	local prev = 0
	TitanPanelAmmoButton:SetScript("OnUpdate", function(_, e)
		prev = prev + e
		if prev > 2 then
			TitanPanelAmmoButton:SetScript("OnUpdate", nil)
			if GetInventoryItemLink("player", ammoSlotID) then
				count = GetInventoryItemCount("player", ammoSlotID) or count
			else
				count = 0;
			end
			TitanPanelButton_UpdateButton(TITAN_AMMO_ID);
		end
	end)
end


function TitanPanelAmmoUpdateDisplay()
-- Manual Display update in case the rangedSlot it switched
local itemlink = GetInventoryItemLink("player", rangedSlotID)
local loc = "";

if itemlink == currentlink then
	return
else
	currentlink = itemlink
end

		if itemlink then
			loc = select(9, GetItemInfo(itemlink))
		end		
		if loc == "INVTYPE_THROWN" then
		
		  if TitanPanelAmmoButton:IsEventRegistered("ACTIONBAR_HIDEGRID") then
		  	TitanPanelAmmoButton:UnregisterEvent("ACTIONBAR_HIDEGRID")
		  	TitanPanelAmmoButton:SetScript("OnUpdate", nil)				
		  end
		  
		  if not TitanPanelAmmoButton:IsEventRegistered("UPDATE_INVENTORY_DURABILITY") then
				TitanPanelAmmoButton:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
			end						
			
			isThrown = true;
			isAmmo = nil;
			count = GetInventoryItemDurability(rangedSlotID);
			
		else
	
			if TitanPanelAmmoButton:IsEventRegistered("UPDATE_INVENTORY_DURABILITY") then			
				TitanPanelAmmoButton:UnregisterEvent("UPDATE_INVENTORY_DURABILITY")
			end
		
			if not TitanPanelAmmoButton:IsEventRegistered("ACTIONBAR_HIDEGRID") then					
				TitanPanelAmmoButton:RegisterEvent("ACTIONBAR_HIDEGRID")				
			end
			
			isAmmo = true;
			isThrown = nil;
			if GetInventoryItemLink("player", ammoSlotID) then
				count = GetInventoryItemCount("player", ammoSlotID)
			else
				count = 0;
			end
			
		end		
		
TitanPanelButton_UpdateButton(TITAN_AMMO_ID);
end


-- **************************************************************************
-- NAME : TitanPanelAmmoButton_GetButtonText(id)
-- DESC : Calculate ammo/thrown logic then display data on button
-- VARS : id = button ID
-- **************************************************************************
function TitanPanelAmmoButton_GetButtonText(id)
     
     local labelText, ammoText, ammoRichText, color;
     
     -- safeguard to prevent malformed labels
     if not count then count = 0 end
     
     if (isThrown) then		          
          labelText = L["TITAN_AMMO_BUTTON_LABEL_THROWN"];
          ammoText = format(L["TITAN_AMMO_FORMAT"], count);
     elseif (isAmmo) then          
          labelText = L["TITAN_AMMO_BUTTON_LABEL_AMMO"];
          ammoText = format(L["TITAN_AMMO_FORMAT"], count);
          if TitanGetVar(TITAN_AMMO_ID, "ShowAmmoName") and AmmoName ~= "" then
          	ammoText = ammoText.."|cffffff9a".." ("..AmmoName..")".."|r"
          end
     else
          count = 0;
          labelText = L["TITAN_AMMO_BUTTON_LABEL_AMMO_THROWN"];
          ammoText = L["TITAN_AMMO_BUTTON_NOAMMO"];
     end
     
     
     if (TitanGetVar(TITAN_AMMO_ID, "ShowColoredText")) then     
          color = TitanUtils_GetThresholdColor(TITAN_AMMO_THRESHOLD_TABLE, count);
          ammoRichText = TitanUtils_GetColoredText(ammoText, color);
     else
          ammoRichText = TitanUtils_GetHighlightText(ammoText);
     end

     return labelText, ammoRichText;
end

-- **************************************************************************
-- NAME : TitanPanelRightClickMenu_PrepareAmmoMenu()
-- DESC : Display rightclick menu options
-- **************************************************************************
function TitanPanelRightClickMenu_PrepareAmmoMenu()
		 local info = {};
     TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_AMMO_ID].menuText);
     TitanPanelRightClickMenu_AddToggleIcon(TITAN_AMMO_ID);
     TitanPanelRightClickMenu_AddToggleLabelText(TITAN_AMMO_ID);
     TitanPanelRightClickMenu_AddToggleColoredText(TITAN_AMMO_ID);
     
     info.text = L["TITAN_AMMO_BULLET_NAME"];
     info.func = function() TitanPanelRightClickMenu_ToggleVar({TITAN_AMMO_ID, "ShowAmmoName"})
     TitanPanelButton_UpdateButton(TITAN_AMMO_ID);
     end
     info.checked = TitanUtils_Ternary(TitanGetVar(TITAN_AMMO_ID, "ShowAmmoName"), 1, nil);
     UIDropDownMenu_AddButton(info);
     
     
     TitanPanelRightClickMenu_AddSpacer();
     TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_AMMO_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end