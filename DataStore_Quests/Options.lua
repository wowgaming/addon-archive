if not DataStore then return end

local addonName = "DataStore_Quests"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	DataStore:AddOptionCategory(DataStoreQuestsOptions, addonName, "DataStore")

	-- localize options
	DataStoreQuestsOptions_TrackTurnInsText:SetText(L["Track Quest Turn-ins"])
	DataStoreQuestsOptions_AutoUpdateHistoryText:SetText(L["Auto-update History"])
	
	DataStore:SetCheckBoxTooltip(DataStoreQuestsOptions_TrackTurnIns, L["TRACK_TURNINS_TITLE"], L["TRACK_TURNINS_ENABLED"], L["TRACK_TURNINS_DISABLED"])
	DataStore:SetCheckBoxTooltip(DataStoreQuestsOptions_AutoUpdateHistory, L["AUTO_UPDATE_TITLE"], L["AUTO_UPDATE_ENABLED"], L["AUTO_UPDATE_DISABLED"])
	
	-- restore saved options to gui
	DataStoreQuestsOptions_TrackTurnIns:SetChecked(DataStore:GetOption(addonName, "TrackTurnIns"))
	DataStoreQuestsOptions_AutoUpdateHistory:SetChecked(DataStore:GetOption(addonName, "AutoUpdateHistory"))
end
