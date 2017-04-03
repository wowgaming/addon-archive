local L = LibStub("AceLocale-3.0"):NewLocale("DataStore_Auctions", "enUS", true, true)

if not L then return end

L["Automatically clear expired auctions and bids"] = true
L["CLEAR_ITEMS_TITLE"] = "Clear Auction House items"
L["CLEAR_ITEMS_ENABLED"] = "Expired items are automatically deleted from the database."
L["CLEAR_ITEMS_DISABLED"] = "Expired items remain in the database until the player next visits the auction house."
	