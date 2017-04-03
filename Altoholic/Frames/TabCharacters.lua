local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local THIS_ACCOUNT = "Default"
local WHITE		= "|cFFFFFFFF"
local TEAL		= "|cFF00FF9A"
local ORANGE	= "|cFFFF7F00"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

-- These match the id's of the buttons in TabCharacters.xml
local VIEW_BAGS = 1
local VIEW_TALENTS = 2
local VIEW_MAILS = 3
local VIEW_QUESTS = 4
local VIEW_AUCTIONS = 5
local VIEW_BIDS = 6
local VIEW_COMPANIONS = 7
local VIEW_MOUNTS = 8
local VIEW_REP = 9
local VIEW_EQUIP = 10
local VIEW_TOKENS = 11

local ICON_VIEW_BAGS = "Interface\\Buttons\\Button-Backpack-Up"
local ICON_VIEW_MAILS = "Interface\\Icons\\INV_Misc_Note_01"
local ICON_VIEW_QUESTS = "Interface\\Icons\\INV_Misc_Book_07"
local ICON_VIEW_AUCTIONS = "Interface\\Icons\\INV_Misc_Coin_01"
local ICON_VIEW_BIDS = "Interface\\Icons\\INV_Misc_Coin_03"
local ICON_VIEW_COMPANIONS = "Interface\\Icons\\INV_Box_Birdcage_01"
local ICON_VIEW_MOUNTS = "Interface\\Icons\\Ability_Mount_RidingHorse"
local ICON_VIEW_REP = "Interface\\Icons\\INV_BannerPVP_02"
local ICON_VIEW_EQUIP = "Interface\\Icons\\INV_Chest_Plate04"
local ICON_VIEW_TALENTS = "Interface\\Icons\\Spell_Nature_NatureGuardian"
local ICON_VIEW_TOKENS = "Interface\\Icons\\Spell_Holy_SummonChampion"

local CharInfoButtons = {
	"AltoholicTabCharacters_Bags",
	"AltoholicTabCharacters_Talents",
	"AltoholicTabCharacters_Mails",
	"AltoholicTabCharacters_Quests",
	"AltoholicTabCharacters_Auctions",
	"AltoholicTabCharacters_Bids",
	"AltoholicTabCharacters_Pets",
	"AltoholicTabCharacters_Mounts",
	"AltoholicTabCharacters_Factions",
	"AltoholicTabCharacters_Equipment",
	"AltoholicTabCharacters_Tokens",
}

local lastButton

local function StartAutoCastShine(button)
	local item = button:GetName()
	AutoCastShine_AutoCastStart(_G[ item .. "Shine" ]);
	lastButton = item
end

local function StopAutoCastShine()
	-- stop autocast shine on the last button that was clicked
	if lastButton then
		AutoCastShine_AutoCastStop(_G[ lastButton .. "Shine" ]);
	end
end

local function HideAll()
	AltoholicFrameContainers:Hide()
	AltoholicFrameTalents:Hide()
	AltoholicFrameMail:Hide()
	AltoholicFrameQuests:Hide()
	AltoholicFrameAuctions:Hide()
	AltoholicFramePets:Hide()
	AltoholicFrameRecipes:Hide()
	AltoholicFrameReputations:Hide()
	AltoholicFrameEquipment:Hide()
	AltoholicFrameCurrencies:Hide()
	AltoholicFrameClasses:Hide()
end

addon.Tabs.Characters = {}

local ns = addon.Tabs.Characters		-- ns = namespace

function ns:OnShow()
	if AltoholicFrameReputations:IsVisible() or 
		AltoholicFrameEquipment:IsVisible() or 
		AltoholicFrameCurrencies:IsVisible() or 
		AltoholicFramePetsAllInOne:IsVisible() then
		AltoholicFrameClasses:Show()
	end
	
	if not ns.InfoType then
		StartAutoCastShine(AltoholicTabCharacters_Bags)
		ns:ViewCharInfo(1)
	end
	
	ns:UpdateViewIcons()
end

function ns:UpdateViewIcons()
	
	local DS = DataStore
	local character = ns:GetCurrent()
	
	if not character then
		for k, v in pairs(CharInfoButtons) do
			_G[v]:Hide()
		end
		AltoholicTabCharacters_Cooking:Hide()
		AltoholicTabCharacters_FirstAid:Hide()
		AltoholicTabCharacters_Prof1:Hide()
		AltoholicTabCharacters_Prof2:Hide()
		return
	end
	
	local size = 30
	
	-- ** Bags / Equipment / Quests **
	addon:SetItemButtonTexture("AltoholicTabCharacters_Bags", ICON_VIEW_BAGS, size, size)
	AltoholicTabCharacters_Bags.text = L["Containers"]
	AltoholicTabCharacters_Bags:Show()
	
	addon:SetItemButtonTexture("AltoholicTabCharacters_Equipment", ICON_VIEW_EQUIP, size, size)
	AltoholicTabCharacters_Equipment.text = L["Equipment"]
	AltoholicTabCharacters_Equipment:Show()
	
	addon:SetItemButtonTexture("AltoholicTabCharacters_Quests", ICON_VIEW_QUESTS, size, size)
	AltoholicTabCharacters_Quests.text = L["Quests"]
	AltoholicTabCharacters_Quests:Show()
	
	addon:SetItemButtonTexture("AltoholicTabCharacters_Talents", ICON_VIEW_TALENTS, size, size)
	AltoholicTabCharacters_Talents.text = TALENTS .. " & " .. GLYPHS
	AltoholicTabCharacters_Talents:Show()
	
	-- ** Auctions / Bids / Mails **
	addon:SetItemButtonTexture("AltoholicTabCharacters_Auctions", ICON_VIEW_AUCTIONS, size, size)
	local num = DS:GetNumAuctions(character) or 0
	if num > 0 then
		AltoholicTabCharacters_AuctionsCount:SetText(num)
		AltoholicTabCharacters_AuctionsCount:Show()
	else
		AltoholicTabCharacters_AuctionsCount:Hide()
	end
	AltoholicTabCharacters_Auctions.text = format(L["Auctions %s(%d)"], GREEN, num)
	AltoholicTabCharacters_Auctions:Show()
	
	addon:SetItemButtonTexture("AltoholicTabCharacters_Bids", ICON_VIEW_BIDS, size, size)
	num = DS:GetNumBids(character) or 0
	if num > 0 then
		AltoholicTabCharacters_BidsCount:SetText(num)
		AltoholicTabCharacters_BidsCount:Show()
	else
		AltoholicTabCharacters_BidsCount:Hide()
	end
	AltoholicTabCharacters_Bids.text = format(L["Bids %s(%d)"], GREEN, num)
	AltoholicTabCharacters_Bids:Show()
	
	addon:SetItemButtonTexture("AltoholicTabCharacters_Mails", ICON_VIEW_MAILS, size, size)
	num = DS:GetNumMails(character) or 0
	if num > 0 then
		AltoholicTabCharacters_MailsCount:SetText(num)
		AltoholicTabCharacters_MailsCount:Show()
	else
		AltoholicTabCharacters_MailsCount:Hide()
	end
	AltoholicTabCharacters_Mails.text = format(L["Mails %s(%d)"], GREEN, num)
	AltoholicTabCharacters_Mails:Show()
	
	-- ** Pets / Mounts / Reputations **
	local pets = DS:GetPets(character, "CRITTER")
	num = DS:GetNumPets(pets) or 0

	addon:SetItemButtonTexture("AltoholicTabCharacters_Pets", ICON_VIEW_COMPANIONS, size, size)
	if num > 0 then
		AltoholicTabCharacters_PetsCount:SetText(num)
		AltoholicTabCharacters_PetsCount:Show()
	else
		AltoholicTabCharacters_PetsCount:Hide()
	end
	AltoholicTabCharacters_Pets.text = format(COMPANIONS .. " %s(%d)", GREEN, num)
	AltoholicTabCharacters_Pets:Show()

	pets = DS:GetPets(character, "MOUNT")
	num = DS:GetNumPets(pets) or 0

	addon:SetItemButtonTexture("AltoholicTabCharacters_Mounts", ICON_VIEW_MOUNTS, size, size)
	if num > 0 then
		AltoholicTabCharacters_MountsCount:SetText(num)
		AltoholicTabCharacters_MountsCount:Show()
	else
		AltoholicTabCharacters_MountsCount:Hide()
	end
	AltoholicTabCharacters_Mounts.text = format(MOUNTS .. " %s(%d)", GREEN, num)
	AltoholicTabCharacters_Mounts:Show()
	
	addon:SetItemButtonTexture("AltoholicTabCharacters_Factions", ICON_VIEW_REP, size, size)
	AltoholicTabCharacters_Factions.text = L["Reputations"]
	AltoholicTabCharacters_Factions:Show()
	
	addon:SetItemButtonTexture("AltoholicTabCharacters_Tokens", ICON_VIEW_TOKENS, size, size)
	AltoholicTabCharacters_Tokens.text = CURRENCY
	AltoholicTabCharacters_Tokens:Show()	
	
	-- ** Professions **
	local professionName = GetSpellInfo(2550)		-- cooking
	addon:SetItemButtonTexture("AltoholicTabCharacters_Cooking", addon:GetSpellIcon(DataStore:GetProfessionSpellID(professionName)), size, size)
	AltoholicTabCharacters_Cooking.text = professionName
	AltoholicTabCharacters_Cooking:Show()
	
	professionName = GetSpellInfo(3273)		-- First Aid
	addon:SetItemButtonTexture("AltoholicTabCharacters_FirstAid", addon:GetSpellIcon(DataStore:GetProfessionSpellID(professionName)), size, size)
	AltoholicTabCharacters_FirstAid.text = professionName
	AltoholicTabCharacters_FirstAid:Show()
	
	local i = 1
	for skillName, skill in pairs(DS:GetPrimaryProfessions(character)) do
		local itemName = "AltoholicTabCharacters_Prof" .. i
		local item = _G[itemName]
		local spellID = DataStore:GetProfessionSpellID(skillName)
	
		if spellID then
			addon:SetItemButtonTexture(itemName, addon:GetSpellIcon(spellID), size, size)
			item.text = skillName
			item:Show()
		else
			item.text = nil
			item:Hide()		
		end
		i = i + 1
	end
end

function ns:MenuItem_OnClick(frame, button)
	StopAutoCastShine()
	StartAutoCastShine(frame)
	
	local id = frame:GetID()
	if id > 0 then
		ns:ViewCharInfo(id, true)
		return
	end
	
	if frame.text then		-- profession button
		ns:ViewRecipes(frame.text)
	end
end

-- ** realm selection **
local function OnRealmChange(self, account, realm)
	local OldAccount = addon:GetCurrentAccount()
	local OldRealm = addon:GetCurrentRealm()

	addon:SetCurrentAccount(account)
	addon:SetCurrentRealm(realm)
	
	UIDropDownMenu_ClearAll(AltoholicTabCharacters_SelectRealm);
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectRealm, account .."|".. realm)
	UIDropDownMenu_SetText(AltoholicTabCharacters_SelectRealm, GREEN .. account .. ": " .. WHITE.. realm)
	
	if OldRealm and OldAccount then	-- clear the "select char" drop down if realm or account has changed
		if (OldRealm ~= realm) or (OldAccount ~= account) then
			UIDropDownMenu_ClearAll(AltoholicTabCharacters_SelectChar);
			AltoholicTabCharactersStatus:SetText("")
			addon:SetCurrentCharacter(nil)
			addon.TradeSkills.CurrentProfession = nil
			
			HideAll()
			StopAutoCastShine()
			-- AltoholicFrameAchievements:Hide()
			ns:UpdateViewIcons()
		end
	end
end

local function AddRealm(realm, account)
	local info = UIDropDownMenu_CreateInfo(); 

	info.text = format("%s: %s", GREEN..account, WHITE..realm)
	info.value = format("%s|%s", account, realm)
	info.checked = nil
	info.func = OnRealmChange
	info.arg1 = account
	info.arg2 = realm
	UIDropDownMenu_AddButton(info, 1); 
end

function ns:DropDownRealm_Initialize()
	if not addon:GetCurrentAccount() or not addon:GetCurrentRealm() then return end

	-- this account first ..
	for realm in pairs(DataStore:GetRealms()) do
		AddRealm(realm, THIS_ACCOUNT)
	end

	-- .. then all other accounts
	for account in pairs(DataStore:GetAccounts()) do
		if account ~= THIS_ACCOUNT then
			for realm in pairs(DataStore:GetRealms(account)) do
				AddRealm(realm, account)
			end
		end
	end
end

-- ** alt selection **
local function OnAltChange(self)
	local OldAlt = addon:GetCurrentCharacter()
	local _, _, NewAlt = strsplit(".", self.value)
	
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, self.value);
	addon:SetCurrentCharacter(NewAlt)
	
	ns:UpdateViewIcons()
	if (not OldAlt) or (OldAlt == NewAlt) then return end

	if (type(ns.InfoType) == "string") or
		((type(ns.InfoType) == "number") and (ns.InfoType > VIEW_MOUNTS)) then		-- true if we're dealing with a profession
		addon.TradeSkills.CurrentProfession = nil
		HideAll()
		StopAutoCastShine()
	else
		ns:ShowCharInfo(ns.InfoType)		-- this will show the same info from another alt (ex: containers/mail/ ..)
	end
end

function ns:DropDownChar_Initialize()
	if not addon:GetCurrentAccount() or 
		not addon:GetCurrentRealm() then return end
	
	local info = UIDropDownMenu_CreateInfo(); 
	local realm, account = addon:GetCurrentRealm()
	
	for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
		info.text = characterName
		info.value = character
		info.func = OnAltChange
		info.checked = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end

function ns:SetCurrent(name, realm, account)
	-- this function sets both drop down menu to the right values
	ns:DropDownRealm_Initialize()
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectRealm, account .."|".. realm)

	ns:DropDownChar_Initialize()
	
	local character = DataStore:GetCharacter(name, realm, account)
	UIDropDownMenu_SetSelectedValue(AltoholicTabCharacters_SelectChar, character)
end

function ns:GetCurrent()
	-- the right character key is in this widget, use it to avoid querying DataStore all the time
	return UIDropDownMenu_GetSelectedValue(AltoholicTabCharacters_SelectChar)
end

function ns:ViewCharInfo(index, autoCastDone)
	index = index or self.value
	
	if not autoCastDone then
		StopAutoCastShine()
		StartAutoCastShine(_G[ CharInfoButtons[index] ] )
	end
	
	ns.InfoType = index
	HideAll()
	ns:SetMode(index)
	ns:ShowCharInfo(index)
end

function ns:ViewRecipes(profession)
	local ts = addon.TradeSkills
	ts.CurrentProfession = profession
	
	ns.InfoType = profession
	HideAll()
	ns:SetMode()
	
	ts.Recipes:ResetDropDownMenus()
	AltoholicFrameRecipes:Show()
	ts.Recipes:BuildView()
	ts.Recipes:Update()
end

function ns:ShowCharInfo(infoType)
	if infoType == VIEW_BAGS then
		addon:ClearScrollFrame(_G[ "AltoholicFrameContainersScrollFrame" ], "AltoholicFrameContainersEntry", 7, 41)
		
		addon.Containers:SetView(addon.Options:Get("lastContainerView"))
		AltoholicFrameContainers:Show()
		addon.Containers:Update()
		
	elseif infoType == VIEW_TALENTS then
		AltoholicFrameTalents:Show()
		addon.Talents:Update();
		
	elseif infoType == VIEW_MAILS then
		AltoholicFrameMail:Show()
		addon.Mail:BuildView()
		addon.Mail:Update()
	elseif infoType == VIEW_QUESTS then
		AltoholicFrameQuests:Show()
		addon.Quests:InvalidateView()
		addon.Quests:Update();
	elseif infoType == VIEW_AUCTIONS then
		addon.AuctionHouse:SetListType("Auctions")
		AltoholicFrameAuctions:Show()
		addon.AuctionHouse:Update();
	elseif infoType == VIEW_BIDS then
		addon.AuctionHouse:SetListType("Bids")
		AltoholicFrameAuctions:Show()
		addon.AuctionHouse:Update();
	elseif infoType == VIEW_COMPANIONS then
		UIDropDownMenu_SetSelectedValue(AltoholicFramePets_SelectPetView, 1);
		UIDropDownMenu_SetText(AltoholicFramePets_SelectPetView, COMPANIONS)
		addon.Pets:SetType("CRITTER")
		AltoholicFramePetsNormal:Show()
		AltoholicFramePetsAllInOne:Hide()
		AltoholicFramePets:Show()
	elseif infoType == VIEW_MOUNTS then
		UIDropDownMenu_SetSelectedValue(AltoholicFramePets_SelectPetView, 3);
		UIDropDownMenu_SetText(AltoholicFramePets_SelectPetView, MOUNTS)
		addon.Pets:SetType("MOUNT")
		AltoholicFramePetsNormal:Show()
		AltoholicFramePetsAllInOne:Hide()
		AltoholicFramePets:Show()
	elseif infoType == VIEW_REP then
		AltoholicFrameClasses:Show()
		AltoholicFrameReputations:Show()
		addon.Reputations:Update();	
	elseif infoType == VIEW_EQUIP then
		AltoholicFrameClasses:Show()
		AltoholicFrameEquipment:Show()
		addon.Equipment:Update()	
	elseif infoType == VIEW_TOKENS then
		AltoholicFrameClasses:Show()
		AltoholicFrameCurrencies:Show()
		addon.Currencies:Update()	
	end
end

function ns:SetMode(mode)
	local Columns = addon.Tabs.Columns
	Columns:Init()
	
	if not mode then return end		-- called without parameter for professions

	if mode == VIEW_MAILS then
		Columns:Add(MAIL_SUBJECT_LABEL, 220, function(self) addon.Mail:Sort(self, "name") end)
		Columns:Add(FROM, 140, function(self) addon.Mail:Sort(self, "from") end)
		Columns:Add(L["Expiry:"], 200, function(self) addon.Mail:Sort(self, "expiry") end)

	elseif mode == VIEW_AUCTIONS then
		Columns:Add(HELPFRAME_ITEM_TITLE, 220, function(self) addon.AuctionHouse:Sort(self, "name", "Auctions") end)
		Columns:Add(HIGH_BIDDER, 160, function(self) addon.AuctionHouse:Sort(self, "highBidder", "Auctions") end)
		Columns:Add(CURRENT_BID, 170, function(self) addon.AuctionHouse:Sort(self, "buyoutPrice", "Auctions") end)
	
	elseif mode == VIEW_BIDS then
		Columns:Add(HELPFRAME_ITEM_TITLE, 220, function(self) addon.AuctionHouse:Sort(self, "name", "Bids") end)
		Columns:Add(NAME, 160, function(self) addon.AuctionHouse:Sort(self, "owner", "Bids") end)
		Columns:Add(CURRENT_BID, 170, function(self) addon.AuctionHouse:Sort(self, "buyoutPrice", "Bids") end)
	end
end
