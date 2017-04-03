if not DataStore then return end

local addonName = "DataStore_Auctions"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	DataStore:AddOptionCategory(DataStoreAuctionsOptions, addonName, "DataStore")

	-- localize options
	DataStoreAuctionsOptions_AutoClearExpiredItemsText:SetText(L["Automatically clear expired auctions and bids"])
	DataStore:SetCheckBoxTooltip(DataStoreAuctionsOptions_AutoClearExpiredItems, L["CLEAR_ITEMS_TITLE"], L["CLEAR_ITEMS_ENABLED"], L["CLEAR_ITEMS_DISABLED"])
	
	-- restore saved options to gui
	DataStoreAuctionsOptions_AutoClearExpiredItems:SetChecked(DataStore:GetOption(addonName, "AutoClearExpiredItems"))
end
