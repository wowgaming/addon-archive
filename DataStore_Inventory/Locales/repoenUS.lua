local L = LibStub("AceLocale-3.0"):NewLocale("DataStore_Inventory", "enUS", true, true)

if not L then return end

L["CLEAR_INVENTORY_TEXT"] = "Automatically clear guild members' equipment"
L["CLEAR_INVENTORY_DISABLED"] = "Your guild mates' equipment remains in the database, and is visible even if they are offline."
L["CLEAR_INVENTORY_ENABLED"] = "To save memory, local guild members' inventories are cleared every time you login."
L["CLEAR_INVENTORY_TITLE"] = "Clear guild members' equipment"
L["BROADCAST_AIL_TEXT"] = "Broadcast my average item level to guild at logon"
L["BROADCAST_AIL_DISABLED"] = "Nothing will be sent at all."
L["BROADCAST_AIL_ENABLED"] = "Your alts' average item level will be sent on the guild channel at logon."
L["BROADCAST_AIL_TITLE"] = "Broadcast average item level"
L["EQUIP_REQ_TEXT"] = "Be notified when someone inspects one of my alts' equipment."
L["EQUIP_REQ_DISABLED"] = "Nothing will be displayed at all."
L["EQUIP_REQ_ENABLED"] = "A chat message will inform you about which guild member is inspecting which alt."
L["EQUIP_REQ_TITLE"] = "Equipment Request Notification"
L["%s is inspecting %s"] = true
L["Heroic"] = true
L["Trash Mobs"] = true
