if not DataStore then return end

local addonName = "DataStore_Crafts"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	DataStore:AddOptionCategory(DataStoreCraftsOptions, addonName, "DataStore")

	-- localize options
	DataStoreCraftsOptions_BroadcastProfsText:SetText(L["Broadcast my profession links to guild at logon"])
	DataStore:SetCheckBoxTooltip(DataStoreCraftsOptions_BroadcastProfs, L["BROADCAST_PROFS_TITLE"], L["BROADCAST_PROFS_ENABLED"], L["BROADCAST_PROFS_DISABLED"])
	
	-- restore saved options to gui
	DataStoreCraftsOptions_BroadcastProfs:SetChecked(DataStore:GetOption(addonName, "BroadcastProfs"))
end
