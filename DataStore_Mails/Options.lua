if not DataStore then return end

local addonName = "DataStore_Mails"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	DataStore:AddOptionCategory(DataStoreMailOptions, addonName, "DataStore")

	-- localize options
	DataStoreMailOptions_SliderMailExpiry.tooltipText = L["Warn when mail expires in less days than this value"]; 
	DataStoreMailOptions_SliderMailExpiryLow:SetText("1");
	DataStoreMailOptions_SliderMailExpiryHigh:SetText("15"); 
	DataStoreMailOptions_CheckMailExpiryText:SetText(L["Mail Expiry Warning"])
	DataStoreMailOptions_ScanMailBodyText:SetText(L["Scan mail body (marks it as read)"])
	DataStoreMailOptions_CheckMailExpiryAllAccountsText:SetText(L["Check mail expiries on all known accounts"])
	DataStoreMailOptions_CheckMailExpiryAllRealmsText:SetText(L["Check mail expiries on all known realms"])
	
	DataStore:SetCheckBoxTooltip(DataStoreMailOptions_CheckMailExpiry, L["EXPIRY_CHECK_TITLE"], L["EXPIRY_CHECK_ENABLED"], L["EXPIRY_CHECK_DISABLED"])
	DataStore:SetCheckBoxTooltip(DataStoreMailOptions_ScanMailBody, L["SCAN_MAIL_BODY_TITLE"], L["SCAN_MAIL_BODY_ENABLED"], L["SCAN_MAIL_BODY_DISABLED"])
	DataStore:SetCheckBoxTooltip(DataStoreMailOptions_CheckMailExpiryAllAccounts, L["EXPIRY_ALL_ACCOUNTS_TITLE"], L["EXPIRY_ALL_ACCOUNTS_ENABLED"], L["EXPIRY_ALL_ACCOUNTS_DISABLED"])
	DataStore:SetCheckBoxTooltip(DataStoreMailOptions_CheckMailExpiryAllRealms, L["EXPIRY_ALL_REALMS_TITLE"], L["EXPIRY_ALL_REALMS_ENABLED"], L["EXPIRY_ALL_REALMS_DISABLED"])
	
	-- restore saved options to gui
	DataStoreMailOptions_SliderMailExpiry:SetValue(DataStore:GetOption(addonName, "MailWarningThreshold"))
	DataStoreMailOptions_SliderMailExpiryText:SetText(format("%s (%s)", L["Mail Expiry Warning"], DataStoreMailOptions_SliderMailExpiry:GetValue()))
	DataStoreMailOptions_CheckMailExpiry:SetChecked(DataStore:GetOption(addonName, "CheckMailExpiry"))
	DataStoreMailOptions_ScanMailBody:SetChecked(DataStore:GetOption(addonName, "ScanMailBody"))
	DataStoreMailOptions_CheckMailExpiryAllAccounts:SetChecked(DataStore:GetOption(addonName, "CheckMailExpiryAllAccounts"))
	DataStoreMailOptions_CheckMailExpiryAllRealms:SetChecked(DataStore:GetOption(addonName, "CheckMailExpiryAllRealms"))
end
