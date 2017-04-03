----------------------------------------------------------------------------------------
-- WoWEquip file for the Equip Frame

local WoWEquip = LibStub("AceAddon-3.0"):GetAddon("WoWEquip")
local L = LibStub("AceLocale-3.0"):GetLocale("WoWEquip", false)
local LGII = LibStub("AceLocale-3.0"):GetLocale("WoWEquipLGII", false)


----------------------------------------------------------------------------------------
-- Constants

local tremove, strfind, strlower = tremove, strfind, strlower
local GetItemInfo, GetItemQualityColor = GetItemInfo, GetItemQualityColor
local WOWEQUIP_EQUIPLOC = {
	-- List of possible itemEquipLoc returns and their corresponding equipSlotID
	--INVTYPE_AMMO = 0,
	INVTYPE_HEAD = 1,
	INVTYPE_NECK = 2,
	INVTYPE_SHOULDER = 3,
	INVTYPE_BODY = 4,
	INVTYPE_CHEST = 5,
	INVTYPE_ROBE = 5,
	INVTYPE_WAIST = 6,
	INVTYPE_LEGS = 7,
	INVTYPE_FEET = 8,
	INVTYPE_WRIST = 9,
	INVTYPE_HAND = 10,
	INVTYPE_FINGER = 11,
	INVTYPE_TRINKET = 13,
	INVTYPE_CLOAK = 15,
	INVTYPE_WEAPON = 16,
	INVTYPE_SHIELD = 17,
	INVTYPE_2HWEAPON = 16,
	INVTYPE_WEAPONMAINHAND = 16,
	INVTYPE_WEAPONOFFHAND = 17,
	INVTYPE_HOLDABLE = 17,
	INVTYPE_RANGED = 18,
	INVTYPE_THROWN = 18,
	INVTYPE_RANGEDRIGHT = 18,
	INVTYPE_RELIC = 18,
	INVTYPE_TABARD = 19,
	--INVTYPE_BAG = 20,	  -- 21, 22, 23
}
local WOWEQUIP_EQUIPLOC2 = {
	-- Additional itemEquipLoc wearable slotnumbers
	INVTYPE_TRINKET = 14,
	INVTYPE_FINGER = 12,
	INVTYPE_WEAPON = 17,
	-- Titan's Grip exceptions are coded in WoWEquip:FilterFunc3()
}
local WOWEQUIP_FILTERS = { -- Used for menu display
	-- 1-4 and 18-26 must use LGII[] because it is also used to match itemSubType in WoWEquip:FilterFunc1()
	LGII["Cloth"], -- 1
	LGII["Leather"], -- 2
	LGII["Mail"], -- 3
	LGII["Plate"], -- 4
	LGII["Daggers"].." ("..INVTYPE_WEAPON..")", -- 5
	LGII["Fist Weapons"].." ("..INVTYPE_WEAPON..")", -- 6
	LGII["One-Handed Axes"].." ("..INVTYPE_WEAPON..")", -- 7
	LGII["One-Handed Maces"].." ("..INVTYPE_WEAPON..")", -- 8
	LGII["One-Handed Swords"].." ("..INVTYPE_WEAPON..")", -- 9
	LGII["Fishing Poles"], -- 10
	LGII["Polearms"], -- 11
	LGII["Staves"], -- 12
	LGII["Two-Handed Axes"], -- 13
	LGII["Two-Handed Maces"], -- 14
	LGII["Two-Handed Swords"], -- 15
	LGII["Shields"], -- 16
	INVTYPE_HOLDABLE, -- 17
	LGII["Bows"], -- 18
	LGII["Crossbows"], -- 19
	LGII["Guns"], -- 20
	LGII["Thrown"], -- 21
	LGII["Wands"], -- 22
	LGII["Idols"], -- 23
	LGII["Librams"], -- 24
	LGII["Totems"], -- 25
	LGII["Sigils"], -- 26
	LGII["Miscellaneous"], -- 27
	LGII["Daggers"].." ("..INVTYPE_WEAPONMAINHAND..")", -- 28
	LGII["Fist Weapons"].." ("..INVTYPE_WEAPONMAINHAND..")", -- 29
	LGII["One-Handed Axes"].." ("..INVTYPE_WEAPONMAINHAND..")", -- 30
	LGII["One-Handed Maces"].." ("..INVTYPE_WEAPONMAINHAND..")", -- 31
	LGII["One-Handed Swords"].." ("..INVTYPE_WEAPONMAINHAND..")", -- 32
	LGII["Daggers"].." ("..INVTYPE_WEAPONOFFHAND..")", -- 33
	LGII["Fist Weapons"].." ("..INVTYPE_WEAPONOFFHAND..")", -- 34
	LGII["One-Handed Axes"].." ("..INVTYPE_WEAPONOFFHAND..")", -- 35
	LGII["One-Handed Maces"].." ("..INVTYPE_WEAPONOFFHAND..")", -- 36
	LGII["One-Handed Swords"].." ("..INVTYPE_WEAPONOFFHAND..")", -- 37
}
local WOWEQUIP_FILTER = {
	INVTYPE_WEAPON = {
		[LGII["Weapon"]] = {
			[LGII["Daggers"]] = 5,
			[LGII["Fist Weapons"]] = 6,
			[LGII["One-Handed Axes"]] = 7,
			[LGII["One-Handed Maces"]] = 8,
			[LGII["One-Handed Swords"]] = 9,
		},
	},
	INVTYPE_2HWEAPON = {
		[LGII["Weapon"]] = {
			[LGII["Fishing Poles"]] = 10,
			[LGII["Polearms"]] = 11,
			[LGII["Staves"]] = 12,
			[LGII["Two-Handed Axes"]] = 13,
			[LGII["Two-Handed Maces"]] = 14,
			[LGII["Two-Handed Swords"]] = 15,
		},
	},
	INVTYPE_WEAPONMAINHAND = {
		[LGII["Weapon"]] = {
			[LGII["Daggers"]] = 28,
			[LGII["Fist Weapons"]] = 29,
			[LGII["One-Handed Axes"]] = 30,
			[LGII["One-Handed Maces"]] = 31,
			[LGII["One-Handed Swords"]] = 32,
		},
	},
	INVTYPE_SHIELD = {
		[LGII["Armor"]] = {
			[LGII["Shields"]] = 16,
		},
	},
	INVTYPE_HOLDABLE = {
		[LGII["Armor"]] = {
			[LGII["Miscellaneous"]] = 17,
		},
	},
	INVTYPE_WEAPONOFFHAND = {
		[LGII["Weapon"]] = {
			[LGII["Daggers"]] = 33,
			[LGII["Fist Weapons"]] = 34,
			[LGII["One-Handed Axes"]] = 35,
			[LGII["One-Handed Maces"]] = 36,
			[LGII["One-Handed Swords"]] = 37,
		},
	},
}
local TITAN_GRIP_EXCEPTIONS = {
	[16] = { -- Can equip offhand-only axes/maces/swords in the mainhand
		[LGII["Weapon"]] = {
			[LGII["One-Handed Axes"]] = 35,
			[LGII["One-Handed Maces"]] = 36,
			[LGII["One-Handed Swords"]] = 37,
		},
	},
	[17] = { -- Can equip 2handed axes/maces/swords and 1handed mainhand axes/maces/swords in offhand
		[LGII["Weapon"]] = {
			[LGII["Two-Handed Axes"]] = 13,
			[LGII["Two-Handed Maces"]] = 14,
			[LGII["Two-Handed Swords"]] = 15,
			[LGII["One-Handed Axes"]] = 35,
			[LGII["One-Handed Maces"]] = 36,
			[LGII["One-Handed Swords"]] = 37,
		},
	},
}
do
	local a = {__index = function(t, k) t[k] = 27 return 27 end}
	local b = {__index = function(t, k) t[k] = setmetatable({}, a) return t[k] end}
	for k, v in pairs(WOWEQUIP_FILTER) do
		setmetatable(v, b)
		for k2, v2 in pairs(v) do
			setmetatable(v2, a)
		end
	end
	local q = {__index = function(t, k) t[k] = {} return t[k] end}
	for k, v in pairs(TITAN_GRIP_EXCEPTIONS) do
		setmetatable(v, q)
	end
end
local WOWEQUIP_SORTTABLE = { -- 1 == Rarity, 2 == ItemLevel, 3 == Name
	{2, 3, 1},	-- 1, ilvl > name > rarity
	{2, 1, 3},	-- 2, ilvl > rarity > name
	{3, 2, 1},	-- 3, name > ilvl > rarity
	{3, 1, 2},	-- 4, name > rarity > ilvl
	{1, 2, 3},	-- 5, rarity > ilvl > name
	{1, 3, 2},	-- 6, rarity > name > ilvl
}
local WOWEQUIP_SORTOPTIONS = {
	L["by ItemLevel > Name > Rarity"],
	L["by ItemLevel > Rarity > Name"],
	L["by Name > ItemLevel > Rarity"],
	L["by Name > Rarity > ItemLevel"],
	L["by Rarity > ItemLevel > Name"],
	L["by Rarity > Name > ItemLevel"],
}
local WOWEQUIP_DISP_WIDTH = 194
local WOWEQUIP_DISP_HEIGHT = 13
local WOWEQUIP_ITEMS_SHOWN = 18
local WOWEQUIP_MAXITEMID = 55000


----------------------------------------------------------------------------------------
-- Local Variables

local selectedItemID = nil
local selectedSlotNum = nil
local WoWEquip_DispResults = {}
local filter, filter2 = {}, {}
local _, sort1, sort2, sort3
local sortA, sortB = {}, {}


----------------------------------------------------------------------------------------
-- Local Widget Functions

local function WoWEquip_ItemButton_OnClick(self, button)
	if button == "LeftButton" then
		local itemName, itemLink = GetItemInfo(self:GetID())
		if HandleModifiedItemClick(itemLink) then
			return
		else
			-- Set current button/item as selected
			selectedItemID = self:GetID()
			WoWEquip_ListScrollFrame:Update()
			WoWEquip.EquipFrame.EquipButton:Enable()
		end
	end
end

local function WoWEquip_ItemButton_OnEnter(self)
	local itemName, itemLink = GetItemInfo(self:GetID())
	GameTooltip:SetOwner(self, self:GetRight() >= GetScreenWidth()*3/4 and "ANCHOR_LEFT" or "ANCHOR_RIGHT")
	GameTooltip:SetHyperlink(itemLink)
	self.string:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
end

local function WoWEquip_ItemButton_OnLeave(self)
	local itemID = self:GetID()
	local itemName, itemLink, itemRarity = GetItemInfo(itemID)
	if itemID ~= selectedItemID then
		local r, g, b = GetItemQualityColor(itemRarity)
		self.string:SetTextColor(r, g, b)
	end
	WoWEquip.Generic_OnLeave()
end

local function WoWEquip_ListScrollFrame_Update(self)
	local numResults = #WoWEquip_DispResults
	local t = WoWEquip.EquipFrame.ItemButtonAr
	self.highlight:Hide()

	FauxScrollFrame_Update(self, numResults, WOWEQUIP_ITEMS_SHOWN, WOWEQUIP_DISP_HEIGHT, nil, nil, nil, self.highlight, WOWEQUIP_DISP_WIDTH, WOWEQUIP_DISP_WIDTH + 16)
	for i = 1, WOWEQUIP_ITEMS_SHOWN do
		local itemIndex = i + FauxScrollFrame_GetOffset(self)
		local button = t[i]
		if itemIndex <= numResults then
			local itemID = WoWEquip_DispResults[itemIndex]
			local itemName, itemLink, itemRarity = GetItemInfo(itemID)
			local r, g, b = GetItemQualityColor(itemRarity)
			button:SetText(itemName)
			button:SetID(itemID)
			if itemID == selectedItemID then
				button.string:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
				self.highlight:Show()
				self.highlight:SetPoint("TOPLEFT", button)
				self.highlight:SetVertexColor(r, g, b)
			else
				button.string:SetTextColor(r, g, b)
			end
			button:Show()
		else
			button:Hide()
		end
	end

	if numResults > WOWEQUIP_ITEMS_SHOWN then
		-- Reduce width
		for i = 1, WOWEQUIP_ITEMS_SHOWN do
			t[i]:SetWidth(WOWEQUIP_DISP_WIDTH)
			t[i].string:SetWidth(WOWEQUIP_DISP_WIDTH)
		end
	else
		-- Increase width
		for i = 1, WOWEQUIP_ITEMS_SHOWN do
			t[i]:SetWidth(WOWEQUIP_DISP_WIDTH + 16)
			t[i].string:SetWidth(WOWEQUIP_DISP_WIDTH + 16)
		end
	end
end

-- Changes to this function should also be changed to the DressUpItemLink hook at the end of this file
local function WoWEquip_EquipButton_OnClick(self, button, down)
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(selectedItemID)
	local eq = WoWEquip.curProfile.eq
	local slotname = WoWEquip.EquipFrame.pointer.slotname

	-- Adjust for Bind on Account items
	if itemRarity == 7 and itemLevel == 1 and itemMinLevel == 0 then
		itemMinLevel = 1
	end

	if WoWEquip.db.global.PreserveEnchant and eq[slotname] then
		-- Find if the oldEnchantID is usable on the new item
		local oldEnchantID = strmatch(eq[slotname], "item:%d+:(%d+):")
		local t = WoWEquip.EnchantData[itemEquipLoc]
		if itemSubType == LGII["Fishing Poles"] then
			t = WoWEquip.EnchantData["FishingEnchants"]
		elseif itemType == LGII["Weapon"] and itemSubType == LGII["Miscellaneous"] then
			t = WoWEquip.EnchantData["NoEnchants"]
		elseif itemEquipLoc == "INVTYPE_RANGEDRIGHT" and itemSubType ~= LGII["Crossbows"] and itemSubType ~= LGII["Guns"] then
			t = WoWEquip.EnchantData["NoEnchants"]
		end
		local isUsable = WoWEquip:IsEnchantUsable(t, tonumber(oldEnchantID), itemLevel, itemMinLevel)
		oldEnchantID = isUsable and oldEnchantID or "0"
		itemLink = itemLink:gsub("(item:%d+):(%d+):", "%1:"..oldEnchantID..":")
	end

	itemLink = WoWEquip:ChangeItemLinkLevel(itemLink, WoWEquip.curProfile.level)
	WoWEquip:UpdateSlot(slotname, itemLink)
	WoWEquip.EquipFrame.InputBox:ClearFocus()
	WoWEquip.EquipFrame.InputBox:HighlightText(0, 0)
	CloseDropDownMenus()
end


----------------------------------------------------------------------------------------
-- Equip Frame Functions

function WoWEquip.SetFilterOptions(dropdownbutton, arg1, arg2, checked)
	WoWEquip.db.global.EquipFilters[arg1] = checked
	local inputBox = WoWEquip.EquipFrame.InputBox
	inputBox:SetScript("OnUpdate", inputBox.OnUpdate)
	inputBox.time = GetTime()
end

function WoWEquip.SetFilterOptionsSelectAll(dropdownbutton, arg1, arg2, checked)
	-- arg1 is whether to select all or unselect all
	local i, j = string.match(dropdownbutton:GetName(), "DropDownList(%d+)Button(%d+)")
	_G[dropdownbutton:GetName().."Check"]:Hide()
	dropdownbutton.checked = false
	for k = 2, j-(arg1 and 1 or 2) do
		if arg1 then
			_G["DropDownList"..i.."Button"..k.."Check"]:Show()
		else
			_G["DropDownList"..i.."Button"..k.."Check"]:Hide()
		end
		local b = _G["DropDownList"..i.."Button"..k]
		b.checked = arg1
		WoWEquip.db.global.EquipFilters[b.arg1] = arg1
	end
	local inputBox = WoWEquip.EquipFrame.InputBox
	inputBox:SetScript("OnUpdate", inputBox.OnUpdate)
	inputBox.time = GetTime()
end

local function AddEquipFilterMenuItem(info, level, i)
	info.text = WOWEQUIP_FILTERS[i]
	info.arg1 = i
	info.func = WoWEquip.SetFilterOptions
	info.checked = WoWEquip.db.global.EquipFilters[i]
	UIDropDownMenu_AddButton(info, level)
end

function WoWEquip.EquipFilterMenu(self, level)
	if not level then return end
	local info = self.info
	wipe(info)
	if level == 1 then
		info.isTitle = 1
		info.text = L["Filter Options"]
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		info.notCheckable = nil
		info.disabled = nil
		info.isTitle = nil
		info.keepShownOnClick = 1

		if selectedSlotNum == 1 or selectedSlotNum == 3 or (selectedSlotNum >= 5 and selectedSlotNum <= 10) then -- Armor
			for i = 1, 4 do
				AddEquipFilterMenuItem(info, level, i)
			end
		elseif selectedSlotNum == 16 then -- MainHand
			for i = 5, 15 do
				AddEquipFilterMenuItem(info, level, i)
			end
			for i = 28, 32 do
				AddEquipFilterMenuItem(info, level, i)
			end
			for i = 35, 37 do
				AddEquipFilterMenuItem(info, level, i)
			end
		elseif selectedSlotNum == 17 then -- OffHand
			for i = 5, 9 do
				AddEquipFilterMenuItem(info, level, i)
			end
			for i = 13, 17 do
				AddEquipFilterMenuItem(info, level, i)
			end
			for i = 30, 37 do
				AddEquipFilterMenuItem(info, level, i)
			end
		elseif selectedSlotNum == 18 then -- Ranged
			for i = 18, 26 do
				AddEquipFilterMenuItem(info, level, i)
			end
		end
		AddEquipFilterMenuItem(info, level, 27) -- Miscellaneous

		info.checked = nil
		info.notCheckable = 1

		-- Select All menu item
		info.text = L["Select All"]
		info.arg1 = true
		info.func = WoWEquip.SetFilterOptionsSelectAll
		UIDropDownMenu_AddButton(info, level)

		-- Unselect All menu item
		info.text = L["Unselect All"]
		info.arg1 = false
		info.func = WoWEquip.SetFilterOptionsSelectAll
		UIDropDownMenu_AddButton(info, level)

		-- Close menu item
		info.keepShownOnClick = nil
		info.text = CLOSE
		info.func = self.HideMenu
		UIDropDownMenu_AddButton(info, level)
	end
end

function WoWEquip.SortDispList(a, b)
	sortA[3], _, sortA[1], sortA[2] = GetItemInfo(a)
	sortB[3], _, sortB[1], sortB[2] = GetItemInfo(b)

	-- Negate the itemRarity and itemLevel values so that a "better" item is a "smaller" integer
	sortA[1], sortA[2] = -sortA[1], -sortA[2]
	sortB[1], sortB[2] = -sortB[1], -sortB[2]

	if sortA[sort1] ~= sortB[sort1] then
		return sortA[sort1] < sortB[sort1]
	elseif sortA[sort2] ~= sortB[sort2] then
		return sortA[sort2] < sortB[sort2]
	else
		return sortA[sort3] < sortB[sort3]
	end
end

function WoWEquip.SetSortOption(dropdownbutton, arg1, arg2, checked)
	WoWEquip.db.global.SortOption = arg1
	sort1, sort2, sort3 = unpack(WOWEQUIP_SORTTABLE[arg1])
	sort(WoWEquip_DispResults, WoWEquip.SortDispList)
	WoWEquip_ListScrollFrame:Update()
end

function WoWEquip.EquipSortMenu(self, level)
	if not level then return end
	local info = self.info
	wipe(info)
	if level == 1 then
		info.isTitle = 1
		info.text = L["Sort Options"]
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		info.notCheckable = nil
		info.disabled = nil
		info.isTitle = nil

		for i = 1, #WOWEQUIP_SORTOPTIONS do
			info.text = WOWEQUIP_SORTOPTIONS[i]
			info.arg1 = i
			info.func = WoWEquip.SetSortOption
			info.checked = WoWEquip.db.global.SortOption == i
			UIDropDownMenu_AddButton(info, level)
		end

		-- Close menu item
		info.notCheckable = 1
		info.checked = nil
		info.text = CLOSE
		info.func = self.HideMenu
		UIDropDownMenu_AddButton(info, level)
	end
end

-- Internal function for WoWEquip:GenerateDispList(refreshMethod)
function WoWEquip:SetupFilter(slotnum)
	selectedItemID = nil
	selectedSlotNum = slotnum
	self.EquipFrame.FilterButton:Enable()

	-- Setup base filters based on slots
	-- filter[] is used for filtering items from the cache
	-- based on what is equippable in the selected slot
	wipe(filter)
	for k, v in pairs(WOWEQUIP_EQUIPLOC) do
		if v == slotnum then filter[k] = true end
	end
	for k, v in pairs(WOWEQUIP_EQUIPLOC2) do
		if v == slotnum then filter[k] = true end
	end

	-- Setup additional filters and filter functions based on slots
	-- filter2[] is used for user-based filters (which user-selected
	-- item types to show/hide) in WoWEquip:FilterFunc1()
	wipe(filter2)
	if slotnum == 1 or slotnum == 3 or (slotnum >= 5 and slotnum <= 10) then -- Armor
		for i = 1, 4 do
			filter2[WOWEQUIP_FILTERS[i]] = i
		end
		self.FilterFunc = self.FilterFunc1
	elseif slotnum == 16 or slotnum == 17 then -- MainHand, OffHand
		self.FilterFunc = self.FilterFunc3
	elseif slotnum == 18 then -- Ranged
		for i = 18, 26 do
			filter2[WOWEQUIP_FILTERS[i]] = i
		end
		self.FilterFunc = self.FilterFunc1
	else -- Neck, Shirt, Finger, Trinket, Cloak, Tabard
		self.EquipFrame.FilterButton:Disable()
		self.FilterFunc = self.FilterFunc2
	end
end

-- Function to filter Armor
function WoWEquip:FilterFunc1(findText)
	wipe(WoWEquip_DispResults)
	local search = findText == ""
	local dbfilter = self.db.global.EquipFilters
	local found = 0
	for k = WOWEQUIP_MAXITEMID, 1, -1 do
		-- Scan backwards since the epics usually have larger itemIDs (gives a list that is already better sorted)
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(k)
		if itemName and filter[itemEquipLoc] and dbfilter[filter2[itemSubType] or 27] and (search or strfind(strlower(itemName), findText, 1, true)) then
			found = found + 1
			WoWEquip_DispResults[found] = k
			if selectedItemID == k then
				self.EquipFrame.EquipButton:Enable()
			end
		end
	end
end

-- Function to filter Neck, Shirt, Finger, Trinket, Cloak, Tabard
function WoWEquip:FilterFunc2(findText)
	wipe(WoWEquip_DispResults)
	local search = findText == ""
	local found = 0
	for k = WOWEQUIP_MAXITEMID, 1, -1 do
		-- Scan backwards since the epics usually have larger itemIDs (gives a list that is already better sorted)
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(k)
		if itemName and filter[itemEquipLoc] and (search or strfind(strlower(itemName), findText, 1, true)) then
			found = found + 1
			WoWEquip_DispResults[found] = k
			if selectedItemID == k then
				self.EquipFrame.EquipButton:Enable()
			end
		end
	end
end

-- Function to filter MainHand and OffHand
function WoWEquip:FilterFunc3(findText)
	wipe(WoWEquip_DispResults)
	local search = findText == ""
	local tg = TITAN_GRIP_EXCEPTIONS[selectedSlotNum]
	local dbfilter = self.db.global.EquipFilters
	local found = 0
	for k = WOWEQUIP_MAXITEMID, 1, -1 do
		-- Scan backwards since the epics usually have larger itemIDs (gives a list that is already better sorted)
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(k)
		if itemName and (filter[itemEquipLoc] or tg[itemType][itemSubType]) and
		dbfilter[WOWEQUIP_FILTER[itemEquipLoc][itemType][itemSubType]] and
		(search or strfind(strlower(itemName), findText, 1, true)) then
			found = found + 1
			WoWEquip_DispResults[found] = k
			if selectedItemID == k then
				self.EquipFrame.EquipButton:Enable()
			end
		end
	end
end

function WoWEquip:GenerateDispList(refreshMethod)
	local equipFrame = self.EquipFrame
	local findText = strlower(equipFrame.InputBox:GetText())

	if refreshMethod == 1 then
		-- This refresh method builds an brand new list by scanning the entire local cache
		wipe(WoWEquip_DispResults)
		self:FilterFunc(findText)
		sort(WoWEquip_DispResults, self.SortDispList)

	elseif refreshMethod == 2 then
		-- This refresh method uses the existing list and prunes it for high speed on-the-fly search. Since the list is already sorted, it doesn't need to be sorted either.
		for k = #WoWEquip_DispResults, 1, -1 do
			local itemID = WoWEquip_DispResults[k]
			local itemName = GetItemInfo(itemID)
			if not strfind(strlower(itemName), findText, 1, true) then
				tremove(WoWEquip_DispResults, k)
				if selectedItemID == itemID then
					equipFrame.EquipButton:Disable()
				end
			end
		end
	end

	local b = equipFrame.pointer
	if b then
		equipFrame.SearchText:SetFormattedText(L["Selected Slot: %s (%d)"], _G[b.slotname], #WoWEquip_DispResults)
		WoWEquip_ListScrollFrame:Update()
	end
end


----------------------------------------------------------------------------------------
-- Create the frames used by the Equip Frame window

do
	-- Create the main Equip frame
	local WoWEquip_EquipFrame = CreateFrame("Frame", "WoWEquip_EquipFrame", WoWEquip.frame)
	WoWEquip_EquipFrame:Hide()
	WoWEquip_EquipFrame:SetWidth(260)
	WoWEquip_EquipFrame:SetHeight(345+70+17)
	--WoWEquip_EquipFrame:SetBackdrop(WoWEquip.WOWEQUIP_MAIN_BACKDROP)
	WoWEquip_EquipFrame:SetBackdropColor(0, 0, 0, 0.75)
	WoWEquip_EquipFrame:EnableMouse(true)
	WoWEquip_EquipFrame:SetToplevel(true)
	WoWEquip_EquipFrame:SetClampedToScreen(true)
	WoWEquip_EquipFrame:SetMovable(true)
	WoWEquip_EquipFrame:SetScript("OnShow", function(self)
		AnimatedShine_Start(WoWEquip_PaperDoll1)
		WoWEquip.PaperDoll1Shine:Show()
	end)
	WoWEquip_EquipFrame:SetScript("OnHide", function(self)
		AnimatedShine_Stop(WoWEquip_PaperDoll1)
		WoWEquip.PaperDoll1Shine:Hide()
	end)
	WoWEquip.EquipFrame = WoWEquip_EquipFrame
	local f = WoWEquip_EquipFrame

	-- Textures
	local temp = f:CreateTexture(nil, "BACKGROUND")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Title-Background]])
	temp:SetPoint("TOPLEFT", 9, -6)
	temp:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", -28, -24)
	f.titlebg = temp

	temp = f:CreateTexture(nil, "BACKGROUND")
	temp:SetTexture([[Interface\Buttons\WHITE8X8]])
	temp:SetPoint("TOPLEFT", 8, -24)
	temp:SetPoint("BOTTOMRIGHT", -6, 8)
	temp:SetVertexColor(0, 0, 0, .75)
	f.bg = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetHeight(64)
	temp:SetPoint("TOPLEFT")
	temp:SetTexCoord(0.501953125, 0.625, 0, 1)
	f.topleft = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetHeight(64)
	temp:SetPoint("TOPRIGHT")
	temp:SetTexCoord(0.625, 0.75, 0, 1)
	f.topright = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetHeight(64)
	temp:SetPoint("TOPLEFT", f.topleft, "TOPRIGHT")
	temp:SetPoint("TOPRIGHT", f.topright, "TOPLEFT")
	temp:SetTexCoord(0.25, 0.369140625, 0, 1)
	f.top = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetHeight(64)
	temp:SetPoint("BOTTOMLEFT")
	temp:SetTexCoord(0.751953125, 0.875, 0, 1)
	f.bottomleft = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetHeight(64)
	temp:SetPoint("BOTTOMRIGHT")
	temp:SetTexCoord(0.875, 1, 0, 1)
	f.bottomright = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetHeight(64)
	temp:SetPoint("BOTTOMLEFT", f.bottomleft, "BOTTOMRIGHT")
	temp:SetPoint("BOTTOMRIGHT", f.bottomright, "BOTTOMLEFT")
	temp:SetTexCoord(0.376953125, 0.498046875, 0, 1)
	f.bottom = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetPoint("TOPLEFT", f.topleft, "BOTTOMLEFT")
	temp:SetPoint("BOTTOMLEFT", f.bottomleft, "TOPLEFT")
	temp:SetTexCoord(0.001953125, 0.125, 0, 1)
	f.left = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetPoint("TOPRIGHT", f.topright, "BOTTOMRIGHT")
	temp:SetPoint("BOTTOMRIGHT", f.bottomright, "TOPRIGHT")
	temp:SetTexCoord(0.1171875, 0.2421875, 0, 1)
	f.right = temp

	-- This creates the title text and texture
	temp = f:CreateFontString(nil, "ARTWORK")
	temp:SetFontObject(GameFontNormal)
	temp:SetPoint("TOPLEFT", 12, -8)
	temp:SetPoint("TOPRIGHT", -32, -8)
	temp:SetText(L["Search Equipment"])
	f.titleText = temp

	-- This creates a transparent textureless draggable frame to move WoWEquip_EquipFrame
	-- It overlaps the above title text and texture (more or less) exactly.
	temp = CreateFrame("Frame", nil, f)
	temp:SetPoint("TOPLEFT", f.titlebg)
	temp:SetPoint("BOTTOMRIGHT", f.titlebg)
	temp:EnableMouse(true)
	temp:RegisterForDrag("LeftButton")
	temp:SetScript("OnDragStart", WoWEquip.Generic_StartMoving)
	temp:SetScript("OnDragStop", WoWEquip.Generic_StopMovingOrSizing)
	f.dragFrame = temp

	-- Create the Close button
	temp = CreateFrame("Button", nil, WoWEquip_EquipFrame, "UIPanelCloseButton")
	temp:SetPoint("TOPRIGHT", 2, 1)
	temp:SetHitRectInsets(5, 5, 5, 5)
	temp:SetScript("OnClick", WoWEquip.Generic_Hide)
	WoWEquip_EquipFrame.CloseButton = temp

	-- Create and position the Search Text string below the Item Bonus Summary frame
	temp = WoWEquip_EquipFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp:SetPoint("TOPLEFT", 25, -32)
	temp:SetFormattedText(L["Selected Slot: %s (%d)"], "-", 0)
	WoWEquip_EquipFrame.SearchText = temp

	-- Create the Search Input Box and position it below the text
	local WoWEquip_InputBox = CreateFrame("EditBox", nil, WoWEquip_EquipFrame)
	WoWEquip_InputBox:SetWidth(WOWEQUIP_DISP_WIDTH - 15)
	WoWEquip_InputBox:SetHeight(16)
	WoWEquip_InputBox:SetMaxLetters(100)
	WoWEquip_InputBox:SetNumeric(false)
	WoWEquip_InputBox:SetAutoFocus(false)
	WoWEquip_InputBox:SetFontObject("GameFontHighlightSmall")
	WoWEquip_InputBox.text = WoWEquip_InputBox:GetText()
	WoWEquip_InputBox.len = #WoWEquip_InputBox:GetText()
	WoWEquip_InputBox.time = GetTime()
	temp = WoWEquip_InputBox:CreateTexture(nil, "BACKGROUND")
	temp:SetTexture("Interface\\Common\\Common-Input-Border")
	temp:SetWidth(8)
	temp:SetHeight(16)
	temp:SetPoint("TOPLEFT", -5, 0)
	temp:SetTexCoord(0, 0.0625, 0, 0.625)
	local temp2 = WoWEquip_InputBox:CreateTexture(nil, "BACKGROUND")
	temp2:SetTexture("Interface\\Common\\Common-Input-Border")
	temp2:SetWidth(8)
	temp2:SetHeight(16)
	temp2:SetPoint("RIGHT")
	temp2:SetTexCoord(0.9375, 1, 0, 0.625)
	local temp3 = WoWEquip_InputBox:CreateTexture(nil, "BACKGROUND")
	temp3:SetTexture("Interface\\Common\\Common-Input-Border")
	temp3:SetWidth(10)
	temp3:SetHeight(16)
	temp3:SetPoint("LEFT", temp, "RIGHT")
	temp3:SetPoint("RIGHT", temp2, "LEFT")
	temp3:SetTexCoord(0.0625, 0.9375, 0, 0.625)
	WoWEquip_InputBox:SetPoint("TOPLEFT", WoWEquip_EquipFrame.SearchText, "BOTTOMLEFT", 2, -2)
	function WoWEquip_InputBox:OnUpdate()
		if GetTime() - self.time >= 0.5 then
			self:SetScript("OnUpdate", nil)
			WoWEquip:GenerateDispList(1)
			self.text = self:GetText()
			self.len = #self:GetText()
			self.time = GetTime()
		end
	end
	function WoWEquip_InputBox:OnEditFocusGained()
		self:HighlightText()
		self.text = self:GetText()
		self.len = #self:GetText()
	end
	function WoWEquip_InputBox:OnEditFocusLost()
		self:HighlightText(0, 0)
	end
	function WoWEquip_InputBox:OnTextChanged()
		if #self:GetText() == self.len + 1 then
			if strfind(self:GetText(), self.text, 1, true) then
				WoWEquip:GenerateDispList(2)
				self.text = self:GetText()
				self.len = #self:GetText()
			end
		else
			self:SetScript("OnUpdate", self.OnUpdate)
		end
		self.time = GetTime()
	end
	WoWEquip_InputBox:SetScript("OnEnterPressed", WoWEquip_InputBox.ClearFocus)
	WoWEquip_InputBox:SetScript("OnEscapePressed", WoWEquip_InputBox.ClearFocus)
	WoWEquip_InputBox:SetScript("OnEditFocusGained", WoWEquip_InputBox.OnEditFocusGained)
	WoWEquip_InputBox:SetScript("OnEditFocusLost", WoWEquip_InputBox.OnEditFocusLost)
	WoWEquip_InputBox:SetScript("OnTextChanged", WoWEquip_InputBox.OnTextChanged)
	WoWEquip_InputBox:SetScript("OnTabPressed", function(self)
		WoWEquip_EquipFrame.ItemIDInputBox:SetFocus()
	end)
	WoWEquip_EquipFrame.InputBox = WoWEquip_InputBox

	-- Create the Filter button
	temp = CreateFrame("Button", nil, WoWEquip_EquipFrame, "OptionsButtonTemplate")
	temp:SetWidth(16)
	temp:SetHeight(16)
	temp:SetPoint("LEFT", WoWEquip_InputBox, "RIGHT", 0, 0)
	temp:SetText(L["WOW_EQUIP_FILTER_LETTER"])
	temp:Disable()
	temp:SetScript("OnClick", WoWEquip_DropDownMenu.OnClick)
	temp:SetScript("OnHide", WoWEquip_DropDownMenu.HideMenu)
	temp.initMenuFunc = WoWEquip.EquipFilterMenu
	WoWEquip_EquipFrame.FilterButton = temp

	-- Create the Sort button
	temp = CreateFrame("Button", nil, WoWEquip_EquipFrame, "OptionsButtonTemplate")
	temp:SetWidth(16)
	temp:SetHeight(16)
	temp:SetPoint("LEFT", WoWEquip_EquipFrame.FilterButton, "RIGHT", 0, 0)
	temp:SetText(L["WOW_EQUIP_SORT_LETTER"])
	temp:SetScript("OnClick", WoWEquip_DropDownMenu.OnClick)
	temp:SetScript("OnHide", WoWEquip_DropDownMenu.HideMenu)
	temp.initMenuFunc = WoWEquip.EquipSortMenu
	WoWEquip_EquipFrame.SortButton = temp

	-- Create the Search Result frame
	temp = CreateFrame("Frame", nil, WoWEquip_EquipFrame)
	temp:SetBackdrop(WoWEquip.WOWEQUIP_BOX_BACKDROP)
	temp:SetWidth(WOWEQUIP_DISP_WIDTH + 26)
	temp:SetHeight(WOWEQUIP_DISP_HEIGHT * WOWEQUIP_ITEMS_SHOWN + 10)
	temp:SetPoint("TOPLEFT", WoWEquip_InputBox, "BOTTOMLEFT", -7, 1)
	WoWEquip_EquipFrame.SearchResultFrame = temp

	-- Create the Search Results scrollframe
	local WoWEquip_ListScrollFrame = CreateFrame("ScrollFrame", "WoWEquip_ListScrollFrame", WoWEquip_EquipFrame.SearchResultFrame, "FauxScrollFrameTemplate")
	WoWEquip_ListScrollFrame:SetPoint("TOPLEFT", 2, -5)
	WoWEquip_ListScrollFrame:SetWidth(WOWEQUIP_DISP_WIDTH - 3)
	WoWEquip_ListScrollFrame:SetHeight(WOWEQUIP_DISP_HEIGHT * WOWEQUIP_ITEMS_SHOWN)
	WoWEquip_ListScrollFrame:SetScript("OnVerticalScroll", function(self, offset)
		FauxScrollFrame_OnVerticalScroll(self, offset, WOWEQUIP_DISP_HEIGHT, WoWEquip_ListScrollFrame_Update)
	end)
	WoWEquip_ListScrollFrame.Update = WoWEquip_ListScrollFrame_Update
	FauxScrollFrame_Update(WoWEquip_ListScrollFrame, 0, WOWEQUIP_ITEMS_SHOWN, WOWEQUIP_DISP_HEIGHT)
	WoWEquip_EquipFrame.ListScrollFrame = WoWEquip_ListScrollFrame

	-- Create the highlight overlay
	WoWEquip_ListScrollFrame.highlight = temp:CreateTexture(nil, "ARTWORK")
	WoWEquip_ListScrollFrame.highlight:SetTexture("Interface\\Buttons\\UI-Listbox-Highlight2")
	WoWEquip_ListScrollFrame.highlight:SetVertexColor(1.0, 0.82, 0)
	WoWEquip_ListScrollFrame.highlight:SetWidth(WOWEQUIP_DISP_WIDTH)
	WoWEquip_ListScrollFrame.highlight:SetHeight(WOWEQUIP_DISP_HEIGHT)

	-- Create the Search Result item buttons and position them. All the buttons are stored in WoWEquip_EquipFrame.ItemButtonAr[]
	WoWEquip_EquipFrame.ItemButtonAr = {}
	for v = 1, WOWEQUIP_ITEMS_SHOWN do
		temp = CreateFrame("Button", nil, WoWEquip_EquipFrame.SearchResultFrame)
		temp:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		temp:SetScript("OnClick", WoWEquip_ItemButton_OnClick)
		temp:SetScript("OnEnter", WoWEquip_ItemButton_OnEnter)
		temp:SetScript("OnLeave", WoWEquip_ItemButton_OnLeave)
		temp:SetWidth(WOWEQUIP_DISP_WIDTH)
		temp:SetHeight(WOWEQUIP_DISP_HEIGHT)
		temp:Hide()
		RaiseFrameLevel(temp)
		temp.string = temp:CreateFontString()
		temp.string:SetWidth(WOWEQUIP_DISP_WIDTH)
		temp.string:SetHeight(10)
		temp.string:SetJustifyH("LEFT")
		temp:SetFontString(temp.string)
		temp:SetNormalFontObject("GameFontNormalSmall")
		temp:SetHighlightFontObject("GameFontHighlightSmall")
		temp:SetDisabledFontObject("GameFontDisableSmall")
		if v == 1 then
			temp:SetPoint("TOPLEFT", 5, -5)
		else
			temp:SetPoint("TOPLEFT", WoWEquip_EquipFrame.ItemButtonAr[v-1], "BOTTOMLEFT", 0, 0)
		end
		WoWEquip_EquipFrame.ItemButtonAr[v] = temp
	end

	-- Create the Equip button
	temp = CreateFrame("Button", nil, WoWEquip_EquipFrame, "OptionsButtonTemplate")
	temp:SetWidth(110)
	temp:SetHeight(22)
	temp:SetPoint("TOPRIGHT", WoWEquip_EquipFrame.SearchResultFrame, "BOTTOMRIGHT", 0, 0)
	temp:SetText(L["Equip"])
	temp:Disable()
	temp:SetScript("OnClick", WoWEquip_EquipButton_OnClick)
	WoWEquip_EquipFrame.EquipButton = temp

	-- Create the Close button
	temp = CreateFrame("Button", nil, WoWEquip_EquipFrame, "OptionsButtonTemplate")
	temp:SetWidth(110)
	temp:SetHeight(22)
	temp:SetPoint("RIGHT", WoWEquip_EquipFrame.EquipButton, "LEFT", 0, 0)
	temp:SetText(CLOSE)
	temp:SetScript("OnClick", WoWEquip.Generic_Hide)
	WoWEquip_EquipFrame.CloseButton2 = temp

	-- Create and position the Query text string.
	temp = WoWEquip_EquipFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp:SetPoint("BOTTOMLEFT", WoWEquip_EquipFrame, "BOTTOMLEFT", 25, 20)
	temp:SetText(L["Query server for itemID:"])
	WoWEquip_EquipFrame.QueryText = temp

	-- Create the itemID Input Box and position it next to the text
	temp = CreateFrame("Frame", nil, WoWEquip_EquipFrame)
	temp:SetWidth(50)
	temp:SetHeight(20)
	temp:SetBackdrop(WoWEquip.WOWEQUIP_BOX_BACKDROP2)
	temp:SetPoint("LEFT", WoWEquip_EquipFrame.QueryText, "RIGHT", 0, -1)
	WoWEquip_EquipFrame.ItemIDInputFrame = temp
	temp = CreateFrame("EditBox", nil, temp)
	temp:SetWidth(40)
	temp:SetHeight(20)
	temp:SetMaxLetters(5)
	temp:SetNumeric(true)
	temp:SetAutoFocus(false)
	temp:SetFontObject("GameFontHighlightSmall")
	temp:SetPoint("TOPLEFT", 5, 1)
	temp:SetScript("OnEscapePressed", temp.ClearFocus)
	temp:SetScript("OnEnterPressed", function(self)
		WoWEquip_EquipFrame.QueryButton:Click()
		self:HighlightText(0, 0)
		self:ClearFocus()
	end)
	temp:SetScript("OnTabPressed", function(self)
		WoWEquip_EquipFrame.InputBox:SetFocus()
	end)
	temp:SetScript("OnEditFocusGained", WoWEquip_InputBox.OnEditFocusGained)
	temp:SetScript("OnEditFocusLost", WoWEquip_InputBox.OnEditFocusLost)
	WoWEquip_EquipFrame.ItemIDInputBox = temp

	-- Create the Query button
	temp = CreateFrame("Button", nil, WoWEquip_EquipFrame, "OptionsButtonTemplate")
	temp:SetPoint("TOPLEFT", WoWEquip_EquipFrame.ItemIDInputFrame, "TOPRIGHT", 0, 0)
	temp:SetPoint("BOTTOMRIGHT", -23, 16)
	temp:SetNormalFontObject("GameFontNormalSmall")
	temp:SetHighlightFontObject("GameFontHighlightSmall")
	temp:SetDisabledFontObject("GameFontDisableSmall")
	temp:SetText(L["Query"])
	local function disableOneSecond(self, elapsed)
		self.elapsed = self.elapsed + elapsed
		if self.elapsed >= 1 then
			self:SetScript("OnUpdate", nil)
			self:Enable()
			WoWEquip:GenerateDispList(1)
		end
	end
	temp:SetScript("OnClick", function(self, button, down)
		GameTooltip:SetHyperlink("item:"..WoWEquip_EquipFrame.ItemIDInputBox:GetText())
		self:Disable()
		self.elapsed = 0
		self:SetScript("OnUpdate", disableOneSecond)
	end)
	WoWEquip_EquipFrame.QueryButton = temp

	-- Create and position the info string
	temp = WoWEquip_EquipFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp:SetPoint("TOPRIGHT", WoWEquip_EquipFrame.EquipButton, "BOTTOMRIGHT", 0, 5)
	temp:SetPoint("BOTTOMLEFT", WoWEquip_EquipFrame.QueryText, "TOPLEFT", 0, 5)
	temp:SetJustifyV("MIDDLE")
	temp:SetJustifyH("CENTER")
	temp:SetText(L["WOW_EQUIP_SEARCH_INFO"])
	WoWEquip_EquipFrame.SearchInfoText = temp

	-- Hooks any item that is sent to the Dressing Room to also equip in WoWEquip if the WoWEquip frame is open
	hooksecurefunc("DressUpItemLink", function(link)
		if not link then return end
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(link)
		if not WoWEquip_Frame:IsShown() or not itemName then return end

		-- Only do something if it is an equippable gear (slot 1-19). Can't use IsEquippableItem(itemLink)
		-- because it will also return true for ammo (slot 0) and bags (slot 20-23).
		if WOWEQUIP_EQUIPLOC[itemEquipLoc] then
			for slotname, button in pairs(WoWEquip.PaperDoll) do
				if button.slotnum == WOWEQUIP_EQUIPLOC[itemEquipLoc] then
					local eq = WoWEquip.curProfile.eq

					-- Adjust for Bind on Account items
					if itemRarity == 7 and itemLevel == 1 and itemMinLevel == 0 then
						itemMinLevel = 1
					end

					if WoWEquip.db.global.PreserveEnchant and eq[slotname] then
						-- Find if the oldEnchantID is usable on the new item
						local oldEnchantID = strmatch(eq[slotname], "item:%d+:(%d+):")
						local t = WoWEquip.EnchantData[itemEquipLoc]
						if itemSubType == LGII["Fishing Poles"] then
							t = WoWEquip.EnchantData["FishingEnchants"]
						elseif itemType == LGII["Weapon"] and itemSubType == LGII["Miscellaneous"] then
							t = WoWEquip.EnchantData["NoEnchants"]
						elseif itemEquipLoc == "INVTYPE_RANGEDRIGHT" and itemSubType ~= LGII["Crossbows"] and itemSubType ~= LGII["Guns"] then
							t = WoWEquip.EnchantData["NoEnchants"]
						end
						local isUsable = WoWEquip:IsEnchantUsable(t, tonumber(oldEnchantID), itemLevel, itemMinLevel)
						oldEnchantID = isUsable and oldEnchantID or "0"
						itemLink = itemLink:gsub("(item:%d+):(%d+):", "%1:"..oldEnchantID..":")
					end

					itemLink = WoWEquip:ChangeItemLinkLevel(itemLink, WoWEquip.curProfile.level)
					WoWEquip:UpdateSlot(slotname, itemLink)
					CloseDropDownMenus()
					return
				end
			end
		end
	end)
end

-- vim: ts=4 noexpandtab
