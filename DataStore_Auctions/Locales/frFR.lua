local L = LibStub("AceLocale-3.0"):NewLocale( "DataStore_Auctions", "frFR" )

if not L then return end

L["Automatically clear expired auctions and bids"] = "Effacer automatiquement les enchères et les offres"
L["CLEAR_ITEMS_DISABLED"] = "Les objets expirés restent dans la base de données jusqu'à la prochaine visite du joueur à l'hôtel des ventes."
L["CLEAR_ITEMS_ENABLED"] = "Les objets expirés sont automatiquement effacés de la base de données."
L["CLEAR_ITEMS_TITLE"] = "Effacer les objets de l'hôtel des ventes"

