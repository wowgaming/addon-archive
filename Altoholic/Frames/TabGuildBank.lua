local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local TEAL		= "|cFF00FF9A"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

local THIS_ACCOUNT = "Default"

addon.Tabs.GuildBank = {}

local ns = addon.Tabs.GuildBank		-- ns = namespace

local function OnGuildChange(self, account, realm)
	local _, _, guildname = strsplit("|", self.value)

	UIDropDownMenu_ClearAll(AltoholicTabGuildBank_SelectGuild);
	ns:LoadGuild(account, realm, guildname)
end

local function DropDownGuild_Initialize()
	if not addon.db then return end

	local DS = DataStore
	
	for account in pairs(DS:GetAccounts()) do
		for realm in pairs(DS:GetRealms(account)) do
			for guildName, guild in pairs(DS:GetGuilds(realm, account)) do
				local money = DS:GetGuildBankMoney(guild)
				if money then
					local info = UIDropDownMenu_CreateInfo(); 
					
					info.text = format("%s %s(%s / %s%s)", GREEN..guildName, WHITE, realm, YELLOW..account, WHITE)
					info.value = format("%s|%s|%s", account, realm, guildName)
					info.checked = nil; 
					info.func = OnGuildChange
					info.arg1 = account
					info.arg2 = realm
					UIDropDownMenu_AddButton(info, 1); 
				end
			end
		end
	end
end

local initRequired = true

function ns:OnShow()
	if initRequired then
		local currentRealm = GetRealmName()
		local currentGuild = GetGuildInfo("player")
		
		-- if the player is not in a guild, set the drop down to the first available guild on this realm, if any.
		if not currentGuild then
			for guildName, guild in pairs(DataStore:GetGuilds(currentRealm, THIS_ACCOUNT)) do
				local money = DataStore:GetGuildBankMoney(guild)
				if money then		-- if money is not nil, the guild bank has been populated
					currentGuild = guildName
					break	-- if there's at least one guild, let's set the right value and break immediately
				end
			end
		end
		
		-- if the current guild or at least a guild on this realm was found..set the right values
		if currentGuild then
			ns:LoadGuild(THIS_ACCOUNT, currentRealm, currentGuild)
		end	
		
		UIDropDownMenu_Initialize(AltoholicTabGuildBank_SelectGuild, DropDownGuild_Initialize)
		initRequired = nil
	end

	addon.GuildBank:DrawTab()
end

function ns:LoadGuild(account, realm, name)
	
	local guild	= DataStore:GetGuild(name, realm, account)
	local money = DataStore:GetGuildBankMoney(guild)
	if money then	
		UIDropDownMenu_SetSelectedValue(AltoholicTabGuildBank_SelectGuild, format("%s|%s|%s", account, realm, name))
		UIDropDownMenu_SetText(AltoholicTabGuildBank_SelectGuild, format("%s%s %s(%s)", GREEN, name, WHITE, realm))
	end
	
	AltoGuildBank:Hide()
	for i = 1, 6 do
		_G[ "AltoholicTabGuildBankMenuItem"..i ]:UnlockHighlight();
		
		local name = DataStore:GetGuildBankTabName(guild, i)
		_G[ "AltoholicTabGuildBankMenuItem" .. i ]:SetText(name and (WHITE..name) or (YELLOW..L["N/A"]))
		_G[ "AltoholicTabGuildBankMenuItem" .. i ]:Show()
	end
	
	local altoGuild = addon:GetGuild(name, realm, account)
	AltoholicTabGuildBank_HideInTooltip:SetChecked(altoGuild.hideInTooltip)
	AltoholicTabGuildBankMoney:SetText(MONEY .. ": " .. addon:GetMoneyString(money or 0, WHITE))
end

function ns:HideGuild(self)

	local value = UIDropDownMenu_GetSelectedValue(AltoholicTabGuildBank_SelectGuild)
	if not value then return end
	
	local account, realm, name = strsplit("|", value)
	local guild = addon:GetGuild(name, realm, account)
	
	if self:GetChecked() then 
		guild.hideInTooltip = true
	else
		guild.hideInTooltip = nil
	end
end

local function DeleteGuild_MsgBox_Handler(self, button, guildKey)
	if not button then return end
	
	local account, realm, guildName = strsplit("|", guildKey)
	local guild = addon:GetGuild(guildName, realm, account)
	wipe(guild)
	
	for i=1, 6 do
		_G[ "AltoholicTabGuildBankMenuItem"..i ]:Hide()
	end
	
	AltoholicTabGuildBankInfo1:SetText("")
	AltoholicTabGuildBankInfo2:SetText("")
	AltoholicTabGuildBankMoney:SetText("")
	
	AltoGuildBank:Hide()
	
	DataStore:DeleteGuild(guildName, realm, account)
	
	UIDropDownMenu_ClearAll(AltoholicTabGuildBank_SelectGuild);
	
	addon:Print(format( L["Guild %s successfully deleted"], guildName))
end

function ns:DeleteGuild()

	local guildKey = UIDropDownMenu_GetSelectedValue(AltoholicTabGuildBank_SelectGuild)
	if not guildKey then return end
	
	addon:SetMsgBoxHandler(DeleteGuild_MsgBox_Handler, guildKey)
	
	local _, realm, guildName = strsplit("|", guildKey)
	
	AltoMsgBox_Text:SetText(L["Delete Guild Bank?"] .. "\n" .. GREEN .. guildName .. WHITE .. " (" .. realm .. ")")
	AltoMsgBox_Text:SetText(format("%s\n%s%s %s(%s)", L["Delete Guild Bank?"], GREEN, guildName, WHITE, realm ))
	AltoMsgBox:Show()
end
