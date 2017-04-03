local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local GREEN		= "|cFF00FF00"

local THISREALM_THISACCOUNT = 1
local THISREALM_ALLACCOUNTS = 2
local ALLREALMS_THISACCOUNT = 3
local ALLREALMS_ALLACCOUNTS = 4

local currentMode

local childrenFrames = {
	"Summary",
	"BagUsage",
	"Skills",
	"Activity",
	"GuildMembers",
	"GuildProfessions",
	"GuildBankTabs",
	"Calendar",
}

local childrenObjects		-- these are the tables that actually contain the BuildView & Update methods. Not really OOP, but enough for our needs

addon.Tabs.Summary = {}

local ns = addon.Tabs.Summary		-- ns = namespace

local locationLabels = {
	[THISREALM_THISACCOUNT] = format("%s %s(%s)", L["This realm"], GREEN, L["This account"]),
	[THISREALM_ALLACCOUNTS] = format("%s %s(%s)", L["This realm"], GREEN, L["All accounts"]),
	[ALLREALMS_THISACCOUNT] = format("%s %s(%s)", L["All realms"], GREEN, L["This account"]),
	[ALLREALMS_ALLACCOUNTS] = format("%s %s(%s)", L["All realms"], GREEN, L["All accounts"]),
}

local function OnRealmFilterChange(self)
	UIDropDownMenu_SetSelectedValue(AltoholicTabSummary_SelectLocation, self.value);
	
	addon.Options:Set("TabSummaryMode", self.value)
	addon.Characters:BuildList()
	addon.Characters:BuildView()
	ns:Refresh()
end

local function DropDownLocation_Initialize()
	local info = UIDropDownMenu_CreateInfo();
	
	info.text = locationLabels[THISREALM_THISACCOUNT]
	info.value = THISREALM_THISACCOUNT
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	info.text = locationLabels[THISREALM_ALLACCOUNTS]
	info.value = THISREALM_ALLACCOUNTS
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	info.text = locationLabels[ALLREALMS_THISACCOUNT]
	info.value = ALLREALMS_THISACCOUNT
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	

	info.text = locationLabels[ALLREALMS_ALLACCOUNTS]
	info.value = ALLREALMS_ALLACCOUNTS
	info.func = OnRealmFilterChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
end

function ns:Init()
	childrenObjects = {
		addon.Summary,
		addon.BagUsage,
		addon.TradeSkills,
		addon.Activity,
		addon.Guild.Members,
		addon.Guild.Professions,
		addon.Guild.BankTabs,
		addon.Calendar,
	}
	
	local f = AltoholicTabSummary_SelectLocation
	UIDropDownMenu_SetSelectedValue(f, addon.Options:Get("TabSummaryMode"))
	UIDropDownMenu_SetText(f, select(addon.Options:Get("TabSummaryMode"), locationLabels[THISREALM_THISACCOUNT], locationLabels[THISREALM_ALLACCOUNTS], locationLabels[ALLREALMS_THISACCOUNT], locationLabels[ALLREALMS_ALLACCOUNTS]))
	UIDropDownMenu_Initialize(f, DropDownLocation_Initialize)
	
	addon.Calendar:Init()
end

function ns:MenuItem_OnClick(id)
	for _, v in pairs(childrenFrames) do			-- hide all frames
		_G[ "AltoholicFrame" .. v]:Hide()
	end

	ns:SetMode(id)
	
	if id == 5 then				-- specific treatment per frame goes here
		if IsInGuild() then
			GuildRoster()
		end
	end
	
	local f = _G[ "AltoholicFrame" .. childrenFrames[id]]
	local o = childrenObjects[id]
	
	if o.BuildView then
		o:BuildView()
	end
	f:Show()
	o:Update()
	
	for i=1, 8 do 
		_G[ "AltoholicTabSummaryMenuItem"..i ]:UnlockHighlight();
	end
	_G[ "AltoholicTabSummaryMenuItem"..id ]:LockHighlight();
end

function ns:SetMode(mode)
	currentMode = mode
	
	AltoholicTabSummaryStatus:SetText("")
	AltoholicTabSummaryToggleView:Show()
	AltoholicTabSummary_SelectLocation:Show()
	AltoholicTabSummary_RequestSharing:Show()
	AltoholicTabSummary_Options:Show()
	AltoholicTabSummary_OptionsDataStore:Show()
	
	local Columns = addon.Tabs.Columns
	Columns:Init()
	
	local title

	if currentMode == 1 then
		Columns:Add(NAME, 100, function(self) addon.Characters:Sort(self, "GetCharacterName") end)
		Columns:Add(LEVEL, 60, function(self) addon.Characters:Sort(self, "GetCharacterLevel")	end)
		Columns:Add(MONEY, 115, function(self)	addon.Characters:Sort(self, "GetMoney") end)
		Columns:Add(PLAYED, 105, function(self) addon.Characters:Sort(self, "GetPlayTime") end)
		Columns:Add(XP, 55, function(self) addon.Characters:Sort(self, "GetXPRate") end)
		Columns:Add(TUTORIAL_TITLE26, 70, function(self) addon.Characters:Sort(self, "GetRestXPRate") end)
		Columns:Add("AiL", 55, function(self) addon.Characters:Sort(self, "GetAverageItemLevel")	end)
	
	elseif currentMode == 2 then
		Columns:Add(NAME, 100, function(self) addon.Characters:Sort(self, "GetCharacterName") end)
		Columns:Add(LEVEL, 60, function(self) addon.Characters:Sort(self, "GetCharacterLevel") end)
		Columns:Add(L["Bags"], 120, function(self) addon.Characters:Sort(self, "GetNumBagSlots") end)
		Columns:Add(L["free"], 50, function(self) addon.Characters:Sort(self, "GetNumFreeBagSlots") end)
		Columns:Add(L["Bank"], 190, function(self) addon.Characters:Sort(self, "GetNumBankSlots") end)
		Columns:Add(L["free"], 50, function(self)	addon.Characters:Sort(self, "GetNumFreeBankSlots")	end)
		
	elseif currentMode == 3 then
		Columns:Add(NAME, 100, function(self) addon.Characters:Sort(self, "GetCharacterName") end)
		Columns:Add(LEVEL, 60, function(self) addon.Characters:Sort(self, "GetCharacterLevel") end)
		Columns:Add(L["Prof. 1"], 65, function(self) addon.Characters:Sort(self, "skillName1") end)
		Columns:Add(L["Prof. 2"], 65, function(self) addon.Characters:Sort(self, "skillName2") end)
		title = GetSpellInfo(2550)		-- cooking
		Columns:Add(title, 65, function(self) addon.Characters:Sort(self, "GetCookingRank") end)
		title = GetSpellInfo(3273)		-- First Aid
		Columns:Add(title, 65, function(self) addon.Characters:Sort(self, "GetFirstAidRank") end)
		title = GetSpellInfo(24303)	-- Fishing
		Columns:Add(title, 65, function(self) addon.Characters:Sort(self, "GetFishingRank") end)
		Columns:Add(L["Riding"], 65, function(self) addon.Characters:Sort(self, "GetRidingRank") end)
		
	elseif currentMode == 4 then
		Columns:Add(NAME, 100, function(self) addon.Characters:Sort(self, "GetCharacterName") end)
		Columns:Add(LEVEL, 60, function(self) addon.Characters:Sort(self, "GetCharacterLevel") end)
		Columns:Add(L["Mails"], 60, function(self) addon.Characters:Sort(self, "GetNumMails") end)
		Columns:Add(L["Visited"], 60, function(self) addon.Characters:Sort(self, "GetMailboxLastVisit") end)
		Columns:Add(AUCTIONS, 70, function(self) addon.Characters:Sort(self, "GetNumAuctions") end)
		Columns:Add(BIDS, 60, function(self) addon.Characters:Sort(self, "GetNumBids") end)
		Columns:Add(L["Visited"], 60, function(self) addon.Characters:Sort(self, "GetAuctionHouseLastVisit") end)
		Columns:Add(LASTONLINE, 90, function(self) addon.Characters:Sort(self, "GetLastLogout") end)

	elseif currentMode == 5 then
		Columns:Add(NAME, 100, function(self) addon.Guild.Members:Sort(self, "name") end)
		Columns:Add(LEVEL, 60, function(self) addon.Guild.Members:Sort(self, "level") end)
		Columns:Add("AiL", 65, function(self) addon.Guild.Members:Sort(self, "averageItemLvl") end)
		Columns:Add(GAME_VERSION_LABEL, 80, function(self) addon.Guild.Members:Sort(self, "version") end)
		Columns:Add(CLASS, 100, function(self) addon.Guild.Members:Sort(self, "englishClass") end)

	elseif currentMode == 6 then
		Columns:Add(NAME, 60, function(self) addon.Guild.Professions:Sort(self, "name") end)
		Columns:Add(LEVEL, 60, function(self) addon.Guild.Professions:Sort(self, "level") end)
		Columns:Add(CLASS, 120, function(self) addon.Guild.Professions:Sort(self, "englishClass") end)
		Columns:Add(L["Prof. 1"], 110, function(self) addon.Guild.Professions:Sort(self, "profLink", 1) end)
		Columns:Add(L["Prof. 2"], 110, function(self) addon.Guild.Professions:Sort(self, "profLink", 2) end)
		title = GetSpellInfo(2550)		-- cooking
		Columns:Add(title, 110, function(self) addon.Guild.Professions:Sort(self, "profLink", 3) end)
		
	elseif currentMode == 7 then
		Columns:Add(NAME, 100, nil)
		Columns:Add(TIMEMANAGER_TOOLTIP_LOCALTIME, 120,  nil)
		Columns:Add(TIMEMANAGER_TOOLTIP_REALMTIME, 120,  nil)
	elseif currentMode == 8 then
		AltoholicTabSummaryToggleView:Hide()
		AltoholicTabSummary_SelectLocation:Hide()
		AltoholicTabSummary_RequestSharing:Hide()
		AltoholicTabSummary_Options:Hide()
		AltoholicTabSummary_OptionsDataStore:Hide()
	end
end

function ns:Refresh()
	if AltoholicFrameSummary:IsVisible() then
		addon.Summary:Update()
	elseif AltoholicFrameBagUsage:IsVisible() then
		addon.BagUsage:Update()
	elseif AltoholicFrameSkills:IsVisible() then
		addon.TradeSkills:Update()
	elseif AltoholicFrameActivity:IsVisible() then
		addon.Activity:Update()
	elseif AltoholicFrameGuildMembers:IsVisible() then
		addon.Guild.Members:Update()
	elseif AltoholicFrameGuildProfessions:IsVisible() then
		addon.Guild.Professions:Update()
	elseif AltoholicFrameGuildBankTabs:IsVisible() then
		addon.Guild.BankTabs:Update()
	elseif AltoholicFrameCalendar:IsVisible() then
		addon.Calendar.Events:BuildList()
		addon.Calendar:Update()
	end
end

function ns:ToggleView(frame)
	if not frame.isCollapsed then
		frame.isCollapsed = true
		AltoholicTabSummaryToggleView:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	else
		frame.isCollapsed = nil
		AltoholicTabSummaryToggleView:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
	end

	if (currentMode >= 1) and (currentMode <= 4) then
		addon.Characters:ToggleView(frame)
		ns:Refresh()
	elseif currentMode == 5 then
		addon.Guild.Members:ToggleView(frame)
	elseif currentMode == 6 then
		addon.Guild.Professions:ToggleView(frame)
	elseif currentMode == 7 then
		addon.Guild.BankTabs:ToggleView(frame)
	end
end

function ns:AccountSharingButton_OnEnter(self)
	AltoTooltip:SetOwner(self, "ANCHOR_RIGHT")
	AltoTooltip:ClearLines()
	AltoTooltip:SetText(L["Account Sharing Request"])
	AltoTooltip:AddLine(L["Click this button to ask a player\nto share his entire Altoholic Database\nand add it to your own"],1,1,1)
	AltoTooltip:Show()
end

function ns:AccountSharingButton_OnClick()
	if addon.Options:Get("AccSharingHandlerEnabled") == 0 then
		addon:Print(L["Both parties must enable account sharing\nbefore using this feature (see options)"])
		return
	end
	addon:ToggleUI()
	
	if AltoAccountSharing_SendButton.requestMode then
		addon.Comm.Sharing:SetMode(2)
	else
		addon.Comm.Sharing:SetMode(1)
	end
	AltoAccountSharing:Show()
end
