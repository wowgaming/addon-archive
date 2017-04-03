if not DataStore then return end

local addonName = "DataStore_Inventory"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	DataStore:AddOptionCategory(DataStoreInventoryOptions, addonName, "DataStore")

	-- localize options
	DataStoreInventoryOptions_AutoClearGuildInventoryText:SetText(L["CLEAR_INVENTORY_TEXT"])
	DataStoreInventoryOptions_BroadcastAiLText:SetText(L["BROADCAST_AIL_TEXT"])
	DataStoreInventoryOptions_EquipmentRequestNotificationText:SetText(L["EQUIP_REQ_TEXT"])
	
	DataStore:SetCheckBoxTooltip(DataStoreInventoryOptions_AutoClearGuildInventory, L["CLEAR_INVENTORY_TITLE"], L["CLEAR_INVENTORY_ENABLED"], L["CLEAR_INVENTORY_DISABLED"])
	DataStore:SetCheckBoxTooltip(DataStoreInventoryOptions_BroadcastAiL, L["BROADCAST_AIL_TITLE"], L["BROADCAST_AIL_ENABLED"], L["BROADCAST_AIL_DISABLED"])
	DataStore:SetCheckBoxTooltip(DataStoreInventoryOptions_EquipmentRequestNotification, L["EQUIP_REQ_TITLE"], L["EQUIP_REQ_ENABLED"], L["EQUIP_REQ_DISABLED"])
	
	-- restore saved options to gui
	DataStoreInventoryOptions_AutoClearGuildInventory:SetChecked(DataStore:GetOption(addonName, "AutoClearGuildInventory"))
	DataStoreInventoryOptions_BroadcastAiL:SetChecked(DataStore:GetOption(addonName, "BroadcastAiL"))
	DataStoreInventoryOptions_EquipmentRequestNotification:SetChecked(DataStore:GetOption(addonName, "EquipmentRequestNotification"))
end
