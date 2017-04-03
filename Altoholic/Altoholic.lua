--[[	*** Altoholic ***
Written by : Thaoky, EU-Marécages de Zangar
--]]

local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local DS

local WHITE		= "|cFFFFFFFF"
local RED		= "|cFFFF0000"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local ORANGE	= "|cFFFF7F00"
local TEAL		= "|cFF00FF9A"
local GOLD		= "|cFFFFD700"

local THIS_ACCOUNT = "Default"

Altoholic.ClassInfo = {
	["MAGE"] = "|cFF69CCF0",
	["WARRIOR"] = "|cFFC79C6E",
	["HUNTER"] = "|cFFABD473",
	["ROGUE"] = "|cFFFFF569",
	["WARLOCK"] = "|cFF9482CA", 
	["DRUID"] = "|cFFFF7D0A", 
	["SHAMAN"] = "|cFF2459FF",
	["PALADIN"] = "|cFFF58CBA", 
	["PRIEST"] = WHITE,
	["DEATHKNIGHT"] = "|cFFC41F3B"
}

local function InitLocalization()
	-- this function's purpose is to initialize the text attribute of widgets created in XML.
	-- in versions prior to 3.1.003, they were initialized through global constants named XML_ALTO_???
	-- the strings stayed in memory for no reason, and could not be included in the automated localization offered by curse, hence the change of approach.
	
	AltoholicMinimapButton.tooltip = format("%s\n%s\n%s",	addonName, WHITE..L["Left-click to |cFF00FF00open"], WHITE..L["Right-click to |cFF00FF00drag"] )
	
	AltoAccountSharing_InfoButton.tooltip = format("%s|r\n%s\n%s\n\n%s",
		WHITE..L["Account Name"], 
		L["Enter an account name that will be\nused for |cFF00FF00display|r purposes only."],
		L["This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name."],
		L["This field |cFF00FF00cannot|r be left empty."])
	
	AltoholicTabSummary_Options.tooltip = format("%s:|r %s", WHITE..GAMEOPTIONS_MENU, addonName)
	AltoholicTabSummary_OptionsDataStore.tooltip = format("%s:|r %s", WHITE..GAMEOPTIONS_MENU, "DataStore")
	
	AltoholicFrameTab1:SetText(L["Summary"])
	AltoholicFrameTab2:SetText(L["Characters"])
	AltoholicTabSummaryMenuItem1:SetText(L["Account Summary"])
	AltoholicTabSummaryMenuItem2:SetText(L["Bag Usage"])
	AltoholicTabSummaryMenuItem4:SetText(L["Activity"])
	AltoholicTabSummaryMenuItem5:SetText(L["Guild Members"])
	AltoholicTabSummaryMenuItem6:SetText(L["Guild Skills"])
	AltoholicTabSummaryMenuItem7:SetText(L["Guild Bank Tabs"])
	AltoholicTabSummaryMenuItem8:SetText(L["Calendar"])
	AltoholicTabSummary_RequestSharing:SetText(L["Account Sharing"])
	
	AltoholicTabCharactersText1:SetText(L["Realm"])
	AltoholicTabCharactersText2:SetText(L["Character"])
	
	AltoholicTabSearch_Sort1:SetText(L["Item / Location"])
	AltoholicTabSearch_Sort2:SetText(L["Character"])
	AltoholicTabSearch_Sort3:SetText(L["Realm"])
	AltoholicTabSearchSlot:SetText(L["Equipment Slot"])
	AltoholicTabSearchLocation:SetText(L["Location"])
	
	AltoholicFramePetsText1:SetText(L["View"])
	AltoholicFrameReputationsText1:SetText(L["View"])
	AltoholicFrameCurrenciesText1:SetText(L["View"])
	
	AltoholicTabGuildBank_HideInTooltipText:SetText(L["Hide this guild in the tooltip"])
	
	AltoAccountSharingName:SetText(L["Account Name"])
	AltoAccountSharingText1:SetText(L["Send account sharing request to:"])
	AltoAccountSharingText2:SetText(ORANGE.."Available Content")
	AltoAccountSharingText3:SetText(ORANGE.."Size")
	AltoAccountSharingText4:SetText(ORANGE.."Date")
	AltoAccountSharing_UseNameText:SetText(L["Character"])
	
	AltoholicFrameTotals:SetText(L["Totals"])
	AltoholicFrameSearchLabel:SetText(L["Search Containers"])
	AltoholicFrame_ResetButton:SetText(L["Reset"])
	
	-- nil strings to save memory, since they are not used later on.
	L["Summary"] = nil
	L["Characters"] = nil
	L["Account Summary"] = nil
	L["Bag Usage"] = nil
	L["Activity"] = nil
	L["Guild Skills"] = nil
	L["Guild Bank Tabs"] = nil

	L["View"] = nil
	L["Hide this guild in the tooltip"] = nil
	L["Search Containers"] = nil
	L["Equipment Slot"] = nil
	L["Location"] = nil
	L["Reset"] = nil
	L["Send account sharing request to:"] = nil
	L["Left-click to |cFF00FF00open"] = nil
	L["Right-click to |cFF00FF00drag"] = nil
	L["Enter an account name that will be\nused for |cFF00FF00display|r purposes only."] = nil
	L["This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name."] = nil
	L["This field |cFF00FF00cannot|r be left empty."] = nil

	if GetLocale() == "deDE" then
		-- This is a global string from wow, for some reason the original is causing problem. DO NOT copy this line in localization files
		ITEM_MOD_SPELL_POWER = "Erh\195\182ht die Zaubermacht um %d."; 
	end
end

local function BuildUnsafeItemList()
	-- This method will clean the unsafe item list currently in the DB. 
	-- In the previous game session, the list has been populated with items id's that were originally unsafe and for which a query was sent to the server.
	-- In this session, a getiteminfo on these id's will keep returning a nil if the item is really unsafe, so this method will get rid of the id's that are now valid.
	local TmpUnsafe = {}		-- create a temporary table with confirmed unsafe id's
	local unsafeItems = Altoholic.db.global.unsafeItems
	
	for _, itemID in pairs(unsafeItems) do
		local itemName = GetItemInfo(itemID)
		if not itemName then							-- if the item is really unsafe .. save it
			table.insert(TmpUnsafe, itemID)
		end
	end
	
	wipe(unsafeItems)	-- clear the DB table
	
	for _, itemID in pairs(TmpUnsafe) do
		table.insert(unsafeItems, itemID)	-- save the confirmed unsafe ids back in the db
	end
end

-- *** DB functions ***
local currentAlt
local currentRealm
local currentAccount

function addon:GetCharacterTable(name, realm, account)
	-- Usage: 
	-- 	local c = addon:GetCharacterTable(char, realm, account)
	--	all 3 parameters default to current player, realm or account
	-- use this for features that have to work regardless of an alt's location (any realm, any account)
	local key = format("%s.%s.%s", account or currentAccount, realm or currentRealm, name or currentAlt)
	return addon.db.global.Characters[key]
end

function addon:GetCharacterTableByLine(line)
	-- shortcut to get the right character table based on the line number in the info table.
	return addon:GetCharacterTable( addon.Characters:GetInfo(line) )
end

function addon:GetCurrentCharacter()
	return currentAlt, currentRealm, currentAccount
end

function addon:SetCurrentCharacter(name, realm, account)
	currentAlt = name
	if realm then
		addon:SetCurrentRealm(realm)
	end
	if account then
		addon:SetCurrentAccount(account)
	end
end

function addon:GetCurrentRealm()
	return currentRealm, currentAccount
end

function addon:SetCurrentRealm(name)
	currentRealm = name
end

function addon:GetCurrentAccount()
	return currentAccount
end

function addon:SetCurrentAccount(name)
	currentAccount = name
end

function addon:GetGuild(name, realm, account)
	name = name or GetGuildInfo("player")
	if not name then return end
	
	realm = realm or GetRealmName()
	account = account or THIS_ACCOUNT
	
	local key = format("%s.%s.%s", account, realm, name)
	return addon.db.global.Guilds[key]
end

function Altoholic:GetGuildMembers(guild)
	assert(type(guild) == "table")
	return guild.members
end

function Altoholic:SetLastAccountSharingInfo(name, realm, account)
	local sharing = Altoholic.db.global.Sharing.Domains[format("%s.%s", account, realm)]
	sharing.lastSharingTimestamp = time()
	sharing.lastUpdatedWith = name
end

function Altoholic:GetLastAccountSharingInfo(realm, account)
	local sharing = Altoholic.db.global.Sharing.Domains[format("%s.%s", account, realm)]
	
	if sharing then
		return date("%m/%d/%Y %H:%M", sharing.lastSharingTimestamp), sharing.lastUpdatedWith
	end
end


-- *** Scanning functions ***
local function ScanFriends()
	local c = addon.ThisCharacter
	wipe(c.Friends)
	
	for i = 1, GetNumFriends() do
	   local name = GetFriendInfo(i);
	   table.insert(c.Friends, name)
	end
end

local function ScanSavedInstances()	
	local c = addon.ThisCharacter
	
	wipe(c.SavedInstance)
	
	for i=1, GetNumSavedInstances() do
		local instanceName, instanceID, instanceReset, difficulty, _, extended, _, isRaid, maxPlayers, difficultyName = GetSavedInstanceInfo(i)

		if instanceReset > 0 then		-- in 3.2, instances with reset = 0 are also listed (to support raid extensions)
			extended = extended and 0 or 1
			isRaid = isRaid and 0 or 1
			
			if difficulty > 1 then
				instanceName = format("%s %s", instanceName, difficultyName)
			end

			local key = instanceName.. "|" .. instanceID
			c.SavedInstance[key] = format("%s|%s|%s|%s", instanceReset, time(), extended, isRaid )
		end
	end
end


-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanFriends()
end

local function OnPlayerLogout()
	local t = {}
	for i = 1, 10 do
	   t[i] = strchar(64 + random(26))
	end

	local y = (tonumber(date("%Y")) - 2000) + 64
	local m = tonumber(date("%m")) + 64
	local d = date("%d")
	local h = tonumber(date("%H")) + 64
	local M = date("%M")
	local S = date("%S")
	local x = t[1]..S..t[3]..t[4]..strchar(m)..t[7]..M..t[2]..t[6]..t[8]..d..t[9]..strchar(h)..t[5]..t[1]..strchar(y)..t[4]
	
	addon.Options:Set("Lola", x)
end

local function OnRaidInstanceWelcome()
	RequestRaidInfo()
end

local function OnChatMsgSystem(event, arg)
	if arg then
		if tostring(arg1) == INSTANCE_SAVED then
			RequestRaidInfo()
		end
	end
end

local trackedItems = {
	[39878] = 590400, -- Mysterious Egg, 6 days 20 hours
	[44717] = 590400, -- Disgusting Jar, 6 days 20 hours
}

local lootMsg = gsub(LOOT_ITEM_SELF, "%%s", "(.+)")

local function OnChatMsgLoot(event, arg)
	local _, _, link = strfind(arg, lootMsg)
	if not link then return end
		
	local id = addon:GetIDFromLink(link)
	id = tonumber(id)
	if not id then return end
	
	for itemID, duration in pairs(trackedItems) do
		if itemID == id then
			local name = GetItemInfo(itemID)
			if name then
				local c = addon.ThisCharacter
				table.insert(c.Timers, name .."|" .. time() .. "|" .. duration)
				addon.Calendar.Events:BuildList()
				addon.Tabs.Summary:Refresh()
			end
		end
	end
end



function addon:OnEnable()
	DS = DataStore

	InitLocalization()
	addon.Options:Init()
	addon.Tasks:Init()
	addon.Profiler:Init()
	addon:InitTooltip()
	
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("PLAYER_LOGOUT", OnPlayerLogout)
	addon:RegisterEvent("UPDATE_INSTANCE_INFO", ScanSavedInstances)
	addon:RegisterEvent("RAID_INSTANCE_WELCOME", OnRaidInstanceWelcome)

	addon:RegisterEvent("AUCTION_HOUSE_SHOW", addon.AuctionHouse.OnShow)
	addon:RegisterEvent("PLAYER_TALENT_UPDATE", addon.Talents.OnUpdate);
	
	AltoholicFrameName:SetText("Altoholic |cFFFFFFFF".. addon.Version .. " by |cFF69CCF0Thaoky")

	local realm = GetRealmName()
	local player = UnitName("player")
	local key = format("%s.%s.%s", THIS_ACCOUNT, realm, player)
	addon.ThisCharacter = addon.db.global.Characters[key]
	
	addon:SetCurrentCharacter(player, realm, THIS_ACCOUNT)

	addon.Tabs.Summary:Init()
	addon.Containers:Init()
	addon.Search:Init()
	addon.Currencies:Init()
	
	-- do not move this one into the frame's OnLoad
	UIDropDownMenu_Initialize(AltoholicFrameEquipmentRightClickMenu, Equipment_RightClickMenu_OnLoad, "MENU");
	
	_G["AltoholicFrameClassesItem10"]:SetPoint("BOTTOMRIGHT", "AltoholicFrameClasses", "BOTTOMRIGHT", -15, 0);
	for j=9, 1, -1 do
		_G["AltoholicFrameClassesItem" .. j]:SetPoint("BOTTOMRIGHT", "AltoholicFrameClassesItem" .. (j + 1), "BOTTOMLEFT", -5, 0);
	end

	addon.Options:RestoreToUI()

	if Altoholic.Options:Get("ShowMinimap") == 1 then
		addon:MoveMinimapIcon()
		AltoholicMinimapButton:Show();
	else
		AltoholicMinimapButton:Hide();
	end
	
	addon:RegisterEvent("BAG_UPDATE", addon.Containers.OnBagUpdate)
	addon:RegisterEvent("FRIENDLIST_UPDATE", ScanFriends);
	addon:RegisterEvent("CHAT_MSG_SYSTEM", OnChatMsgSystem);
	addon:RegisterEvent("CHAT_MSG_LOOT", OnChatMsgLoot)
	addon:RegisterEvent("UNIT_PET", addon.Pets.OnChange);
	
	if IsInGuild() then
		addon:RegisterEvent("GUILD_ROSTER_UPDATE", addon.Guild.Members.OnRosterUpdate);
	end
	
	BuildUnsafeItemList()
	
	-- create an empty frame to manage the timer via its Onupdate
	addon.TimerFrame = CreateFrame("Frame", "AltoholicTimerFrame", UIParent)
	local f = addon.TimerFrame
	
	f:SetWidth(1)
	f:SetHeight(1)
	f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 1, 1)
	f:SetScript("OnUpdate", function(addon, elapsed) Altoholic.Tasks:OnUpdate(elapsed) end)
	f:Show()
end

function addon:OnDisable()
end

function addon:ToggleUI()
	if (AltoholicFrame:IsVisible()) then
		AltoholicFrame:Hide();
	else
		AltoholicFrame:Show();
	end
end

function addon:OnShow()
	SetPortraitTexture(AltoholicFramePortrait, "player");	

	addon.Characters:BuildList()
	addon.Characters:BuildView()
	
	if not addon.Tabs.current then
		addon.Tabs.current = 1
		addon.Tabs.Summary:MenuItem_OnClick(1)
	elseif addon.Tabs.current == 1 then
		addon.Tabs.Summary:Refresh()
	end
end


-- *** Utility functions ***
function Altoholic:ScrollFrameUpdate(desc)
	assert(type(desc) == "table")		-- desc is the table that contains a standardized description of the scrollframe
	
	local frame = desc.Frame
	local entry = frame.."Entry"

	-- hide all lines and set their id to 0, the update function is responsible for showing and setting id's of valid lines	
	for i = 1, desc.NumLines do
		_G[ entry..i ]:SetID(0)
		_G[ entry..i ]:Hide()
	end
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] )
	-- call the update handler
	desc:Update(offset, entry, desc)
	
	local last = (desc:GetSize() < desc.NumLines) and desc.NumLines or desc:GetSize()
	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], last, desc.NumLines, desc.LineHeight);
end

function Altoholic:ClearScrollFrame(name, entry, lines, height)
	for i=1, lines do					-- Hides all entries of the scrollframe, and updates it accordingly
		_G[ entry..i ]:Hide()
	end
	FauxScrollFrame_Update( name, lines, lines, height);
end

function addon:Item_OnEnter(frame)
	if not frame.id then return end
	
	GameTooltip:SetOwner(frame, "ANCHOR_LEFT");
	frame.link = frame.link or select(2, GetItemInfo(frame.id) )
	
	if frame.link then
		GameTooltip:SetHyperlink(frame.link);
	else
		-- GameTooltip:AddLine(L["Unknown link, please relog this character"],1,1,1);
		GameTooltip:SetHyperlink("item:"..frame.id..":0:0:0:0:0:0:0")	-- this line queries the server for an unknown id
		GameTooltip:ClearLines(); -- don't leave residual info in the tooltip after the server query
	end
	GameTooltip:Show();
end

function addon:Item_OnClick(frame, button)
	if not frame.id then return end
	
	if not frame.link then
		frame.link = select(2, GetItemInfo(frame.id) )
	end
	if not frame.link then return end		-- still not valid ? exit
	
	if ( button == "LeftButton" ) and ( IsControlKeyDown() ) then
		DressUpItemLink(frame.link);
	elseif ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		local chat = ChatEdit_GetLastActiveWindow()
	
		if chat:IsShown() then
			chat:Insert(frame.link);
		else
			AltoholicFrame_SearchEditBox:SetText(GetItemInfo(frame.link))
		end
	end
end

function addon:SetItemButtonTexture(button, texture, width, height)
	-- wrapper for SetItemButtonTexture from ItemButtonTemplate.lua
	width = width or 36
	height = height or 36

	local itemTexture = _G[button.."IconTexture"]
	
	itemTexture:SetWidth(width);
	itemTexture:SetHeight(height);
	itemTexture:SetAllPoints(_G[button]);
	
	SetItemButtonTexture(_G[button], texture)
end

function addon:TextureToFontstring(name, width, height)
	return format("|T%s:%s:%s|t", name, width, height)
end

function addon:GetSpellIcon(spellID)
	return select(3, GetSpellInfo(spellID))
end

function addon:GetIDFromLink(link)
	if link then
		return tonumber(link:match("item:(%d+)"))
	end
end

function addon:GetSpellIDFromRecipeLink(link)
	-- returns nil if recipe id is not in the DB, returns the spellID otherwise
	local recipeID = addon:GetIDFromLink(link)
	return addon.RecipeDB[recipeID]
end

function addon:GetMoneyString(copper, color, noTexture)
	color = color or "|cFFFFD700"

	local gold = floor( copper / 10000 );
	copper = mod(copper, 10000)
	local silver = floor( copper / 100 );
	copper = mod(copper, 100)
	
	if noTexture then				-- use noTexture for places where the texture does not fit too well,  ex: tooltips
		copper = format("%s%s%s%s", color, copper, "|cFFEDA55F", COPPER_AMOUNT_SYMBOL)
		silver = format("%s%s%s%s", color, silver, "|cFFC7C7CF", SILVER_AMOUNT_SYMBOL)
		gold = format("%s%s%s%s", color, gold, "|cFFFFD700", GOLD_AMOUNT_SYMBOL)
	else
		copper = color..format(COPPER_AMOUNT_TEXTURE, copper, 13, 13)
		silver = color..format(SILVER_AMOUNT_TEXTURE, silver, 13, 13)
		gold = color..format(GOLD_AMOUNT_TEXTURE, gold, 13, 13)
	end
	return format("%s %s %s", gold, silver, copper)
end

function addon:GetTimeString(seconds)
	local days = floor(seconds / 86400);				-- TotalTime is expressed in seconds
	seconds = mod(seconds, 86400)
	local hours = floor(seconds / 3600);
	seconds = mod(seconds, 3600)
	local minutes = floor(seconds / 60);
	seconds = mod(seconds, 60)

	return format("%s|rd %s|rh %s|rm", WHITE..days, WHITE..hours, WHITE..minutes)
end

function addon:GetFactionColour(faction)
	if faction == "Alliance" then
		return "|cFF2459FF"
	else
		return RED
	end
end

function Altoholic:GetClassColor(class)
	return Altoholic.ClassInfo[class] or WHITE
end

function addon:GetDelayInDays(delay)
	return floor((time() - delay) / 86400)
end

function Altoholic:FormatDelay(timeStamp)
	-- timeStamp = value when time() was last called for a given variable (ex: last time the mailbox was checked)
	if not timeStamp then
		return YELLOW .. NEVER
	end
	
	if timeStamp == 0 then
		return YELLOW .. "N/A"
	end
	
	local seconds = (time() - timeStamp)
	
	-- 86400 seconds per day
	-- assuming 30 days / month = 2.592.000 seconds
	-- assuming 365 days / year = 31.536.000 seconds
	-- in the absence of possibility to track real dates, these approximations will have to do the trick, as it's not possible at this point to determine the number of days in a month, or in a year.

	local year = floor(seconds / 31536000);
	seconds = mod(seconds, 31536000)

	local month = floor(seconds / 2592000);
	seconds = mod(seconds, 2592000)

	local day = floor(seconds / 86400);
	seconds = mod(seconds, 86400)

	local hour = floor(seconds / 3600);
	seconds = mod(seconds, 3600)

	-- note: RecentTimeDate is not a direct API function, it's in UIParent.lua
	return RecentTimeDate(year, month, day, hour)
end

function addon:GetRestedXP(character)
	local rate = DS:GetRestXPRate(character)

	local coeff = 1
	if addon.Options:Get("RestXPMode") == 1 then
		coeff = 1.5
	end
	rate = rate * coeff
	
	-- second return value = the actual percentage of rest xp, as a numeric value (1 to 100, not 150)
	local color = GREEN
	if rate >= (100 * coeff) then 
		rate = 100 * coeff
	else
		if rate < (30 * coeff) then
			color = RED
		elseif rate < (60 * coeff) then
			color = YELLOW
		end
	end
	return format("%s%d", color, rate).."%", rate
end

function addon:GetSuggestion(index, level)
	if addon.Suggestions[index] then 
		for _, v in pairs( addon.Suggestions[index] ) do
			if level < v[1] then		-- the suggestions are sorted by level, so whenever we're below, return the text
				return v[2]
			end
		end
	end
end

function Altoholic:UpdateSlider(name, text, field)
	local s = _G[name]
	_G[name .. "Text"]:SetText(text .. " (" .. s:GetValue() ..")");

	if not Altoholic.db then return end
	local a = Altoholic.db.global
	if a == nil then return	end
	
	a.options[field] = s:GetValue()
	self:MoveMinimapIcon()
end

function Altoholic:ShowWidgetTooltip(frame)
	if not frame.tooltip then return end
	
	AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddLine(frame.tooltip)
	AltoTooltip:Show(); 
end

function Altoholic:ShowClassIcons()
	local entry = "AltoholicFrameClassesItem"
	local i = 1
	
	local realm, account = Altoholic:GetCurrentRealm()
	for characterName, character in pairs(DS:GetCharacters(realm, account)) do
		local itemName = entry .. i;
		local itemButton = _G[itemName];
		itemButton:SetScript("OnEnter", function(self) 
				Altoholic:DrawCharacterTooltip(self, self.CharName)
			end)
		itemButton:SetScript("OnLeave", function(self) 
				AltoTooltip:Hide()
			end)
		
		local _, class = DS:GetCharacterClass(character)
		local tc = CLASS_ICON_TCOORDS[class]
		local itemTexture = _G[itemName .. "IconTexture"]
		itemTexture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
		itemTexture:SetTexCoord(tc[1], tc[2], tc[3], tc[4]);
		itemTexture:SetWidth(36);
		itemTexture:SetHeight(36);
		itemTexture:SetAllPoints(itemButton);
		
		Altoholic:CreateButtonBorder(itemButton)

		if DS:GetCharacterFaction(character) == "Alliance" then
			itemButton.border:SetVertexColor(0.1, 0.25, 1, 0.5)
		else
			itemButton.border:SetVertexColor(1, 0, 0, 0.5)
		end
		itemButton.border:Show()
		
		itemButton.CharName = characterName
		itemButton:Show()
		
		i = i + 1
		if i > 10 then 	-- users of Symbolic Links might have more than 10 columns, prevent it
			break
		end
	end
	
	while i <= 10 do
		_G[ entry .. i ]:Hide()
		_G[ entry .. i ].CharName = nil
		i = i + 1
	end
end

function addon:CreateButtonBorder(frame)
	if frame.border then return end

	local border = frame:CreateTexture(nil, "OVERLAY")
	border:SetWidth(67);
	border:SetHeight(67)
	border:SetPoint("CENTER", frame)
	border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
	border:SetBlendMode("ADD")
	border:Hide()
	
	frame.border = border
end

function Altoholic:DrawCharacterTooltip(self, charName)
	local realm, account = Altoholic:GetCurrentRealm()
	local character = DS:GetCharacter(charName, realm, account)	
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddDoubleLine(DS:GetColoredCharacterName(character), DS:GetColoredCharacterFaction(character))

	AltoTooltip:AddLine(format("%s %s |r%s %s", L["Level"], 
		GREEN..DS:GetCharacterLevel(character), DS:GetCharacterRace(character),	DS:GetCharacterClass(character)),1,1,1)

	local zone, subZone = DS:GetLocation(character)
	AltoTooltip:AddLine(format("%s: %s |r(%s|r)", L["Zone"], GOLD..zone, GOLD..subZone),1,1,1)
	
	local restXP = DS:GetRestXP(character)
	if restXP and restXP > 0 then
		AltoTooltip:AddLine(format("%s: %s", L["Rest XP"], GREEN..restXP),1,1,1)
	end
	
	AltoTooltip:AddLine("Average iLevel: " .. GREEN .. format("%.1f", DS:GetAverageItemLevel(character)),1,1,1);	

	if IsAddOnLoaded("DataStore_Achievements") then
		if DS:GetNumCompletedAchievements(character) > 0 then
			AltoTooltip:AddLine(ACHIEVEMENTS_COMPLETED ..": " .. GREEN .. DS:GetNumCompletedAchievements(character) .. "/"..DS:GetNumAchievements(character))
			AltoTooltip:AddLine(ACHIEVEMENT_TITLE ..": " .. GREEN .. DS:GetNumAchievementPoints(character))
		end
	end
	
	AltoTooltip:Show();
end

function addon:SetMsgBoxHandler(func, arg1, arg2)
	local msg = AltoMsgBox
	
	msg.ButtonHandler = func
	msg.arg1 = arg1
	msg.arg2 = arg2
end

function addon:MsgBox_OnClick(button)
	-- until I have time to check all the places where msgbox is used, keep "button" as 1 for yes, and nil for no
	-- also, change the handler to work with ...
	local msg = AltoMsgBox

	if msg.ButtonHandler then
		msg:ButtonHandler(button, msg.arg1, msg.arg2)
		msg.ButtonHandler = nil		-- prevent subsequent calls from coming back here
		msg.arg1 = nil
		msg.arg2 = nil
	else
		addon:Print("MessageBox Handler not defined")
	end
	msg:Hide();
	msg:SetHeight(100)
	AltoMsgBox_Text:SetHeight(28)
end

-- ** Unsafe Items **
function addon:SaveUnsafeItem(itemID)
	if not addon:IsItemUnsafe(itemID) then			-- if the item is not a known unsafe item, save it in the db
		table.insert(Altoholic.db.global.unsafeItems, itemID)
	end
end

function addon:IsItemUnsafe(itemID)
	for _, v in pairs(Altoholic.db.global.unsafeItems) do 	-- browse current realm's unsafe item list
		if v == itemID then		-- if the itemID passed as parameter is a known unsafe item .. return true to skip it
			return true
		end
	end
end


-- *** Hooks ***
local Orig_ChatEdit_InsertLink = ChatEdit_InsertLink

function ChatEdit_InsertLink(text, ...)
	if text and AltoholicFrame_SearchEditBox:IsVisible() then
		if not DataStore_Crafts:IsTradeSkillWindowOpen() then
			AltoholicFrame_SearchEditBox:Insert(GetItemInfo(text))
			return true
		end
	end
	return Orig_ChatEdit_InsertLink(text, ...)
end
