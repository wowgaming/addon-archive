local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LTL = LibStub("LibTradeLinks-1.0")

local THIS_ACCOUNT = "Default"
local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local RED		= "|cFFFF0000"
local TEAL		= "|cFF00FF9A"
local YELLOW	= "|cFFFFFF00"

local DS

addon.Search = {}

local ns = addon.Search		-- ns = namespace

function ns:Init()
	DS = DataStore
	
	local _, build = GetBuildInfo()			-- ex: "10314"	string
	local LTLBuild = LTL:GetBuildVersion()	-- ex: 10314		number
	
	if tonumber(build) ~= LTLBuild then		-- invalidate LTL if version is outdated, prevents scanning guild members' professions
		LTL = nil
	end
end

local updateHandler

function ns:Update()
	ns[updateHandler](ns)
end

function ns:SetUpdateHandler(h)
	updateHandler = h
end

local PLAYER_ITEM_LINE = 1
local GUILD_ITEM_LINE = 2
local PLAYER_CRAFT_LINE = 3
local GUILD_CRAFT_LINE = 4

local function Realm_UpdateEx(self, offset, entry, desc)
	local line, LineDesc

	for i=1, desc.NumLines do
		line = i + offset
		local result = ns:GetResult(line)
		if result then
			LineDesc = desc.Lines[result.linetype]
			
			local owner, color = LineDesc:GetCharacter(result)
			_G[ entry..i.."Stat1" ]:SetText(color .. owner)
			
			local realm, account, faction = LineDesc:GetRealm(result)
			local location = addon:GetFactionColour(faction) .. realm
			if account ~= THIS_ACCOUNT then
				location = location .. "\n" ..WHITE.. L["Account"] .. ": " ..GREEN.. account
			end
			_G[ entry..i.."Stat2" ]:SetText(location)
			
			local itemRarity
			local hex = WHITE
			local itemButton = _G[ entry..i.."Item" ]
			
			addon:CreateButtonBorder(itemButton)
			itemButton.border:Hide()
			
			if result.id then
				_, _, itemRarity = GetItemInfo(result.id)
				if itemRarity then
					local r, g, b
					r, g, b, hex = GetItemQualityColor(itemRarity)
					if itemRarity >= 2 then
						itemButton.border:SetVertexColor(r, g, b, 0.5)
						itemButton.border:Show()
					end
				end
			end
			
			local name, source, sourceID = LineDesc:GetItemData(result, line)

			_G[ entry..i.."Name" ]:SetText(hex .. name)
			_G[ entry..i.."SourceNormalText" ]:SetText(source)
			_G[ entry..i.."Source" ]:SetID(sourceID)
			_G[ entry..i.."ItemIconTexture" ]:SetTexture(LineDesc:GetItemTexture(result));				
			
			-- draw count
			if result.count and result.count > 1 then
				_G[ entry..i.."ItemCount" ]:SetText(result.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end
			
			local id = LineDesc:GetItemID(result)
			_G[ entry..i.."Item" ]:SetID(id or 0)
			_G[ entry..i ]:Show()
		end
	end

	local numResults = desc:GetSize()
	if (offset+desc.NumLines) <= numResults then
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. (offset+desc.NumLines) .. ")")
	else
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. numResults .. ")")
	end
	
	if not AltoholicFrameSearch:IsVisible() then
		AltoholicFrameSearch:Show()
	end
end

-- The principle behind ScrollFrame description is the following:
-- FauxScrollframes follow a roughly similar pattern, and are usually displaying different types of lines
-- so the idea is to standardize data collection from the raw tables that are used to populate the scrollframe
-- that way, a function called GetXXX can be used to display this info regardless of the line type, but can also be reused by sort functions

local RealmScrollFrame_Desc = {
	NumLines = 7,
	LineHeight = 41,
	Frame = "AltoholicFrameSearch",
	GetSize = function() return ns:GetNumResults() end,
	Update = Realm_UpdateEx,
	Lines = {
		[PLAYER_ITEM_LINE] = {
			GetItemData = function(self, result)		-- GetItemData..just to avoid calling it GetItemInfo
					-- return name, source, sourceID
					return GetItemInfo(result.id), TEAL .. result.location, 0 
				end,
			GetItemTexture = function(self, result)
					return (result.id) and GetItemIcon(result.id) or "Interface\\Icons\\Trade_Engraving"
				end,
			GetCharacter = function(self, result)
					local character = result.source
					return DS:GetCharacterName(character), DS:GetClassColor(character)
				end,
			GetRealm = function(self, result)
					local character = result.source
					local account, realm = strsplit(".", character)
					return realm, account, DS:GetCharacterFaction(character)
				end,
			GetItemID = function(self, result)
					return result.id
				end,
		},
		[GUILD_ITEM_LINE] = {
			GetItemData = function(self, result)		-- GetItemData..just to avoid calling it GetItemInfo
					-- return name, source, sourceID
					return GetItemInfo(result.id), TEAL .. result.location, 0 
				end,
			GetItemTexture = function(self, result)
					return (result.id) and GetItemIcon(result.id) or "Interface\\Icons\\Trade_Engraving"
				end,
			GetCharacter = function(self, result)
					local _, _, guildName = strsplit(".", result.source)
					return guildName, GREEN
				end,
			GetRealm = function(self, result)
					local account, realm, name = strsplit(".", result.source)
					local guild = DS:GetGuild(name, realm, account)
					
					return realm, account, DS:GetGuildBankFaction(guild)
				end,
			GetItemID = function(self, result)
					return result.id
				end,
		},
		[PLAYER_CRAFT_LINE] = {
			GetItemData = function(self, result, line)
					-- return name, source, sourceID
					local _, _, spellID = DS:GetCraftLineInfo(result.profession, result.craftIndex)
					local source = addon.TradeSkills.Recipes:GetLink(spellID, result.professionName)
					
					return GetSpellInfo(spellID), source, line
				end,
			GetItemTexture = function(self, result)
					local _, _, spellID = DS:GetCraftLineInfo(result.profession, result.craftIndex)
					local itemID = DS:GetCraftInfo(spellID)
			
					return (itemID) and GetItemIcon(itemID) or "Interface\\Icons\\Trade_Engraving"
				end,
			GetCharacter = function(self, result)
					local character = result.char
					local _, _, name = strsplit(".", character)
					
					-- name, color
					return name, DS:GetClassColor(character)
				end,
			GetRealm = function(self, result)
					local character = result.char
					local account, realm, name = strsplit(".", character)
		
					return realm, account, DS:GetCharacterFaction(character)
				end,
			GetItemID = function(self, result)
					local _, _, spellID = DS:GetCraftLineInfo(result.profession, result.craftIndex)
					local itemID = DS:GetCraftInfo(spellID)
			
					return itemID
				end,
		},
		[GUILD_CRAFT_LINE] = {
			GetItemData = function(self, result, line)
					-- return name, source, sourceID
					local profession = LTL:GetSkillName(result.skillID)
					local source = addon.TradeSkills.Recipes:GetLink(result.spellID, profession)
					
					return GetSpellInfo(result.spellID), source, line
				end,
			GetItemTexture = function(self, result)
					local itemID = DS:GetCraftInfo(result.spellID)
					if itemID then		-- if the craft is known, return its icon, else return the profession icon
						return GetItemIcon(itemID)	
					end
			
					local profession = LTL:GetSkillName(result.skillID)
					return addon:GetSpellIcon(addon.ProfessionSpellID[profession])
				end,
			GetCharacter = function(self, result)
					local _, _, _, _, _, _, _, _, _, _, englishClass = DataStore:GetGuildMemberInfo(result.char)
					return result.char, addon:GetClassColor(englishClass)
				end,
			GetRealm = function(self, result)
					return GetRealmName(), THIS_ACCOUNT, UnitFactionGroup("player")
				end,
			GetItemID = function(self, result)
					return DS:GetCraftInfo(result.spellID)
				end,
		},
	}
}

function ns:Realm_Update()
	addon:ScrollFrameUpdate(RealmScrollFrame_Desc)
end

function ns:Loots_Update()
	local VisibleLines = 7
	local frame = "AltoholicFrameSearch"
	local entry = frame.."Entry"
	
	local numResults = ns:GetNumResults()
	
	if numResults == 0 then
		addon:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
		return
	end

	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		local result = ns:GetResult(line)
		if result then
			local itemID = result.id
			
			local itemButton = _G[ entry..i.."Item" ]
			addon:CreateButtonBorder(itemButton)
			itemButton.border:Hide()
			
			local itemName, _, itemRarity, itemLevel = GetItemInfo(itemID)
			local r, g, b, hex = GetItemQualityColor(itemRarity)
			
			if itemRarity >= 2 then
				itemButton.border:SetVertexColor(r, g, b, 0.5)
				itemButton.border:Show()
			end
			
			_G[ entry..i.."ItemIconTexture" ]:SetTexture(GetItemIcon(itemID));

			_G[ entry..i.."Stat2" ]:SetText(YELLOW .. itemLevel)
			_G[ entry..i.."Name" ]:SetText(hex .. itemName)
			_G[ entry..i.."Source" ]:SetText(TEAL .. result.dropLocation)
			_G[ entry..i.."Source" ]:SetID(0)
			
			_G[ entry..i.."Stat1" ]:SetText(GREEN .. result.bossName)
			
			if (result.count ~= nil) and (result.count > 1) then
				_G[ entry..i.."ItemCount" ]:SetText(result.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end

			_G[ entry..i.."Item" ]:SetID(itemID)
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	if (offset+VisibleLines) <= numResults then
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. (offset+VisibleLines) .. ")")
	else
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. numResults .. ")")
	end
	
	if numResults < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], numResults, VisibleLines, 41);
	end
	
	if not AltoholicFrameSearch:IsVisible() then
		AltoholicFrameSearch:Show()
	end
end

function ns:Upgrade_Update()
	local VisibleLines = 7
	local frame = "AltoholicFrameSearch"
	local entry = frame.."Entry"
	
	local numResults = ns:GetNumResults()
	
	if numResults == 0 then
		addon:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
		return
	end

	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		local result = ns:GetResult(line)
		if result then
			local itemID = result.id
			
			local itemButton = _G[ entry..i.."Item" ]
			addon:CreateButtonBorder(itemButton)
			itemButton.border:Hide()
			
			local itemName, _, itemRarity, itemLevel = GetItemInfo(itemID)
			local r, g, b, hex = GetItemQualityColor(itemRarity)
			
			if itemRarity >= 2 then
				itemButton.border:SetVertexColor(r, g, b, 0.5)
				itemButton.border:Show()
			end
			
			_G[ entry..i.."ItemIconTexture" ]:SetTexture(GetItemIcon(itemID));

			_G[ entry..i.."Name" ]:SetText(hex .. itemName)
			_G[ entry..i.."Source" ]:SetText(TEAL .. result.dropLocation)
			_G[ entry..i.."Source" ]:SetID(0)
		
			for j=1, 6 do
				if result["stat"..j] ~= nil then
					local statValue, diff = strsplit("|", result["stat"..j])
					local color
					diff = tonumber(diff)
					
					if diff < 0 then
						color = RED
					elseif diff > 0 then 
						color = GREEN
					else
						color = WHITE
					end
					
					_G[ entry..i.."Stat"..j ]:SetText(color .. statValue)
					_G[ entry..i.."Stat"..j ]:Show()
				else
					_G[ entry..i.."Stat"..j ]:Hide()
				end
			end

			_G[ entry..i.."ILvl" ]:SetText(YELLOW .. itemLevel)
			_G[ entry..i.."ILvl" ]:Show()
			
			if (result.count ~= nil) and (result.count > 1) then
				_G[ entry..i.."ItemCount" ]:SetText(result.count)
				_G[ entry..i.."ItemCount" ]:Show()
			else
				_G[ entry..i.."ItemCount" ]:Hide()
			end

			_G[ entry..i.."Item" ]:SetID(itemID)
			_G[ entry..i ]:SetID(line)
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end

	if (offset+VisibleLines) <= numResults then
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. (offset+VisibleLines) .. ")")
	else
		AltoholicTabSearchStatus:SetText(numResults .. L[" results found (Showing "] .. (offset+1) .. "-" .. numResults .. ")")
	end
	
	if numResults < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], numResults, VisibleLines, 41);
	end
	
	if not AltoholicFrameSearch:IsVisible() then
		AltoholicFrameSearch:Show()
	end
end

-- ** Sort functions **
local function GetCraftName(char, profession, num)
	-- this is a helper function to quickly retrieve the name of a craft based on a character, profession and line number
	
	local c = addon:GetCharacterTableByLine(char)
	local _, _, spellID = strsplit("^", c.recipes[profession].list[num])
	return GetSpellInfo(tonumber(spellID))
end

local function SortByItemName(a, b, ascending)
	local nameA, nameB
	if a.id then
		nameA = GetItemInfo(a.id)
	else		-- some crafts do not have an item ID, since no item is created (ex: enchanting)
		nameA = GetCraftName(a.char, a.location, a.craftNum)
	end

	if b.id then
		nameB = GetItemInfo(b.id)
	else
		nameB = GetCraftName(b.char, b.location, b.craftNum)
	end
	
	if ascending then
		return nameA < nameB
	else
		return nameA > nameB
	end
end

local function SortByName(a, b, ascending)
	local desc = RealmScrollFrame_Desc			-- get the line description for the 2 items
	local LineDescA = desc.Lines[a.linetype]
	local LineDescB = desc.Lines[b.linetype]

	local nameA = LineDescA:GetItemData(a)			-- retrieve the name ..
	local nameB = LineDescB:GetItemData(b)
	
	if ascending then
		return nameA < nameB
	else
		return nameA > nameB
	end
end

local function SortByChar(a, b, ascending)
	local desc = RealmScrollFrame_Desc			-- get the line description for the 2 items
	local LineDescA = desc.Lines[a.linetype]
	local LineDescB = desc.Lines[b.linetype]

	local nameA = LineDescA:GetCharacter(a)			-- retrieve the name ..
	local nameB = LineDescB:GetCharacter(b)

	if nameA == nameB then								-- if it's the same character name ..
		return SortByName(a, b, ascending)			-- .. then sort by item name
	elseif ascending then
		return nameA < nameB
	else
		return nameA > nameB
	end
end

local function SortByRealm(a, b, ascending)
	local desc = RealmScrollFrame_Desc			-- get the line description for the 2 items
	local LineDescA = desc.Lines[a.linetype]
	local LineDescB = desc.Lines[b.linetype]

	local nameA = LineDescA:GetRealm(a)					-- retrieve the name ..
	local nameB = LineDescB:GetRealm(b)	
	
	if nameA == nameB then								-- if it's the same realm ..
		return SortByChar(a, b, ascending)	-- .. then sort by character name
	elseif ascending then
		return nameA < nameB
	else
		return nameA > nameB
	end
end

local function SortByStat(a, b, field, ascending)
	local statA = strsplit("|", a[field])
	local statB = strsplit("|", b[field])
	
	statA = tonumber(statA)
	statB = tonumber(statB)
	
	if ascending then
		return statA < statB
	else
		return statA > statB
	end
end

local function SortByField(a, b, field, ascending)
	if ascending then
		return a[field] < b[field]
	else
		return a[field] > b[field]
	end
end

-- ** Results **
local results

function ns:ClearResults()
	results = results or {}
	wipe(results)
end

function ns:AddResult(t)
	table.insert(results, t)
end

function ns:GetNumResults()
	return #results or 0
end

function ns:GetResult(n)
	if n then
		return results[n]
	end
end

function ns:SortResults(frame, field)
	if ns:GetNumResults() == 0 then return end

	local id = frame:GetID()
	local ascending = frame.ascendingSort
		
	if field == "name" then
		table.sort(results, function(a, b) return SortByName(a, b, ascending) end)
	elseif field == "item" then
		table.sort(results, function(a, b) return SortByItemName(a, b, ascending) end)
	elseif field == "char" then
		table.sort(results, function(a, b) return SortByChar(a, b, ascending) end)
	elseif field == "realm" then
		table.sort(results, function(a, b) return SortByRealm(a, b, ascending) end)
	elseif field == "stat" then
		table.sort(results, function(a, b) return SortByStat(a, b, "stat" .. id-1, ascending) end)
	else
		table.sort(results, function(a, b) return SortByField(a, b, field, ascending) end)
	end
	
	ns:Update()
end

local SEARCH_THISCHAR = 1
local SEARCH_THISREALM_THISFACTION = 2
local SEARCH_THISREALM_BOTHFACTIONS = 3
local SEARCH_ALLREALMS = 4
local SEARCH_ALLACCOUNTS = 5
local SEARCH_LOOTS = 6

local filters = addon.ItemFilters

-- ** Search attributes **
local currentValue				-- the value being searched (entered in the edit box)

local currentResultType			-- type of result currently being searched (eg: PLAYER_ITEM_LINE or GUILD_ITEM_LINE)
local currentResultKey			-- key defining who is being searched (eg: a datastore character or guild key)
local currentResultLocation	-- what is actually being searched (bags, bank, equipment, mail, etc..)

local function VerifyItem(item, itemCount)
	if type(item) == "string" then		-- convert a link to its item id, only data saved
		item = tonumber(item:match("item:(%d+)"))
	end
	
	filters:SetSearchedItem(item)
	if filters:ItemPassesFilters() then			-- All conditions ok ? save it
		ns:AddResult( {
			linetype = currentResultType,			-- PLAYER_ITEM_LINE or GUILD_ITEM_LINE 
			id = item,
			source = currentResultKey,				-- character or guild key in DataStore
			count = itemCount,
			location = currentResultLocation
		} )
	end
end

local function CraftMatchFound(spellID, value)
	local name = GetSpellInfo(spellID)
	if name and string.find(strlower(name), value, 1, true) then
		return true
	end
end

local function BrowseCharacter(character)

	currentResultType = PLAYER_ITEM_LINE	
	currentResultKey = character
	
	local itemID, itemLink, itemCount
	local containers = DS:GetContainers(character)
	if containers then
		for containerName, container in pairs(containers) do
			if (containerName == "Bag100") then
				currentResultLocation = L["Bank"]
			elseif (containerName == "Bag-2") then
				currentResultLocation = KEYRING
			else
				local bagNum = tonumber(string.sub(containerName, 4))
				if (bagNum >= 0) and (bagNum <= 4) then
					currentResultLocation = L["Bags"]
				else
					currentResultLocation = L["Bank"]
				end			
			end
		
			for slotID = 1, container.size do
				itemID, itemLink, itemCount = DS:GetSlotInfo(container, slotID)
				
				-- use the link before the id if there's one
				if itemID then
					VerifyItem(itemLink or itemID, itemCount)
				end
			end
		end
	end
	
	currentResultLocation = L["Equipped"]

	local inventory = DS:GetInventory(character)
	if inventory then
		for _, v in pairs(inventory) do
			VerifyItem(v, 1)
		end
	end
	
	if addon.Options:Get("IncludeMailbox") == 1 then			-- check mail ?
		currentResultLocation = L["Mail"]
		local num = DS:GetNumMails(character) or 0
		for i = 1, num do
			local _, count, link = DS:GetMailInfo(character, i)
			if link then
				VerifyItem(link, count)
			end
		end
	end
	
	if addon.Options:Get("IncludeRecipes") == 1					-- check known recipes ?
		and (filters:GetFilterValue("itemType") == nil) 
		and (filters:GetFilterValue("itemRarity") == 0)
		and (filters:GetFilterValue("itemSlot") == 0) then
		
		local isHeader, spellID, itemID
		local professions = DS:GetProfessions(character)
		if professions then
			for professionName, profession in pairs(professions) do
				for index = 1, DS:GetNumCraftLines(profession) do
					isHeader, _, spellID = DS:GetCraftLineInfo(profession, index)
					
					if not isHeader then
						if CraftMatchFound(spellID, currentValue) then
							ns:AddResult(	{
								linetype = PLAYER_CRAFT_LINE,
								char = currentResultKey,
								professionName = professionName,
								profession = profession,
								craftIndex = index,
							} )
						end
					end
				end
			end
		end
	end
	
	currentResultType = nil
	currentResultKey = nil
	currentResultLocation = nil
end

local function BrowseRealm(realm, account, bothFactions)
	for characterName, character in pairs(DS:GetCharacters(realm, account)) do
		if bothFactions or DS:GetCharacterFaction(character) == UnitFactionGroup("player") then
			BrowseCharacter(character)
		end
	end
	
	if addon.Options:Get("IncludeGuildBank") == 1 then	-- Check guild bank(s) ?
		currentResultType = GUILD_ITEM_LINE

		for guildName, guild in pairs(DS:GetGuilds(realm, account)) do
			if bothFactions or DS:GetGuildBankFaction(guild) == UnitFactionGroup("player") then
				currentResultKey = format("%s.%s.%s", account, realm, guildName)
				
				for tabID = 1, 6 do
					local tab = DS:GetGuildBankTab(guild, tabID)
					if tab.name then
						for slotID = 1, 98 do
							currentResultLocation = format("%s (%s - slot %d)", GUILD_BANK, tab.name, slotID)
							local id, link, count = DS:GetSlotInfo(tab, slotID)
							if id then
								link = link or id
								VerifyItem(link, count)
							end
						end
					end
				end
				
				currentResultKey = nil
			end
		end	-- end guild
		currentResultType = nil
		currentResultLocation = nil
	end
	
	if addon.Options:Get("IncludeGuildSkills") == 1 and string.len(currentValue) > 1 then	-- Check guild professions ?
		local guild = addon:GetGuild()
		if guild and LTL then	-- LTL won't be valid if there's a version mismatch (see :Init() )
			ns.GuildMembers = {}
			
			for member, _ in pairs(addon:GetGuildMembers(guild)) do			-- add all known members into a table
				table.insert(ns.GuildMembers, member)
			end
			addon.Tasks:Add("BrowseGuildProfessions", 0, ns.BrowseGuildProfessions, ns)
		end
	end
end

local ongoingSearch

function ns:FindItem(searchType, searchSubType)
	if ongoingSearch then
		return		-- if a search is already happening .. then exit
	end
	
	local value = AltoholicFrame_SearchEditBox:GetText()
	
	if not searchType and not searchSubType then		-- if no type & subtype, it's not a menu search, so value may not be empty
		if not value or strlen(value) == 0 then		-- .. if empty, exit
			return
		end
	end
	
	ongoingSearch = true
	currentValue = strlower(value)
	
	-- Set Filters
	local itemMinLevel = AltoholicTabSearch_MinLevel:GetNumber()
	local itemMaxLevel = AltoholicTabSearch_MaxLevel:GetNumber()	
	local itemSlot = UIDropDownMenu_GetSelectedValue(AltoholicTabSearch_SelectSlot)
	
	filters:SetFilterValue("itemName", currentValue)
	filters:SetFilterValue("itemType", searchType)
	filters:SetFilterValue("itemSubType", searchSubType)
	filters:SetFilterValue("itemRarity", UIDropDownMenu_GetSelectedValue(AltoholicTabSearch_SelectRarity))
	filters:SetFilterValue("itemMinLevel", itemMinLevel)
	filters:SetFilterValue("itemMaxLevel", itemMaxLevel)
	filters:SetFilterValue("itemSlot", itemSlot)

	filters:EnableFilter("Existence")
	filters:EnableFilter("Type")
	filters:EnableFilter("SubType")
	filters:EnableFilter("Rarity")
	filters:EnableFilter("MinLevel")

	if itemMaxLevel ~= 0 then			-- enable the filter only if a max level has been set
		filters:EnableFilter("Maxlevel")
	end
	
	if itemSlot ~= 0 then	-- don't apply filter if = 0, it means we take them all
		filters:EnableFilter("EquipmentSlot")
	end
	filters:EnableFilter("Name")
	
	-- Start the search
	local searchLocation = UIDropDownMenu_GetSelectedValue(AltoholicTabSearch_SelectLocation)
	
	ns:ClearResults()
	
	local SearchLoots
	if searchLocation == SEARCH_THISCHAR then
		BrowseCharacter(DS:GetCharacter())
	elseif searchLocation == SEARCH_THISREALM_THISFACTION or	searchLocation == SEARCH_THISREALM_BOTHFACTIONS then
		BrowseRealm(GetRealmName(), THIS_ACCOUNT, (searchLocation == SEARCH_THISREALM_BOTHFACTIONS))
	elseif searchLocation == SEARCH_ALLREALMS then
		for realm in pairs(DS:GetRealms()) do
			BrowseRealm(realm, THIS_ACCOUNT, true)
		end
	elseif searchLocation == SEARCH_ALLACCOUNTS then
		-- this account first ..
		for realm in pairs(DS:GetRealms()) do
			BrowseRealm(realm, THIS_ACCOUNT, true)
		end
		
		-- .. then all other accounts
		for account in pairs(DS:GetAccounts()) do
			if account ~= THIS_ACCOUNT then
				for realm in pairs(DS:GetRealms(account)) do
					BrowseRealm(realm, account, true)
				end
			end
		end
	else	-- search loot tables
		SearchLoots = true -- this value will be tested in ns:Update() to resize columns properly
		addon.Loots:Find()
	end
	
	filters:ClearFilters()
	
	if not AltoholicTabSearch:IsVisible() then
		addon.Tabs:OnClick(3)
	end
	
	if ns:GetNumResults() == 0 then
		if currentValue == "" then 
			AltoholicTabSearchStatus:SetText(L["No match found!"])
		else
			AltoholicTabSearchStatus:SetText(value .. L[" not found!"])
		end
	end
	ongoingSearch = nil 	-- search done
	
	-- currentValue = nil				-- don't nil it, it may be required by the task checking guild professions
	
	if SearchLoots then
		addon.Tabs.Search:SetMode("loots")
		if addon.Options:Get("SortDescending") == 1 then 		-- descending sort ?
			AltoholicTabSearch_Sort3.ascendingSort = true		-- say it's ascending now, it will be toggled
			ns:SortResults(AltoholicTabSearch_Sort3, "iLvl")
		else
			AltoholicTabSearch_Sort3.ascendingSort = nil
			ns:SortResults(AltoholicTabSearch_Sort3, "iLvl")
		end
	else
		addon.Tabs.Search:SetMode("realm")
	end

	ns:Update()
	collectgarbage()
end

function ns:BrowseGuildProfessions()
	if #ns.GuildMembers == 0 then	-- no more members ? kill the task
		ns.GuildMembers = nil
		ns:Update()
		return
	end
	
	-- The professions of 1 guild member will be scanned in each pass
	local guild = addon:GetGuild()
	local member = ns.GuildMembers[#ns.GuildMembers]	-- get the last item in the table
	local t = {}
	local skillID
	
	for _, v in pairs(guild.members[member]) do		-- browse all links ..
		if type(v) == "string" and v:match("trade:") then							-- .. assuming they're valid of course
			t, skillID = LTL:Decode(v)
			if t then
				for spellID, _ in pairs(t) do
					local name = GetSpellInfo(spellID)
					if string.find(strlower(name), currentValue, 1, true) then
						ns:AddResult(	{
							linetype = GUILD_CRAFT_LINE,
							spellID = spellID,
							char = member,
							skillID = skillID,
						} )

					end
				end
			end
		end
	end
	
	table.remove(ns.GuildMembers)	-- kill the last item
	addon.Tasks:Reschedule("BrowseGuildProfessions", 0.005)
	return true
end

local currentClass				-- the current character class
local currentItemID				-- itemID of the item for which we're searching for an upgrade

function ns:SetClass(class)
	currentClass = class
end

function ns:GetClass()
	return currentClass
end

function ns:SetCurrentItem(itemID)
	currentItemID = itemID
end

function ns:GetRealmsLineDesc(line)
	return RealmScrollFrame_Desc.Lines[line]
end

function ns:FindEquipmentUpgrade()
	local upgradeType = self.value

	ns:ClearResults()
	
	-- Set Filters
	local _, itemLink, _, itemLevel, _, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(currentItemID)
	local itemSlot = addon.Equipment:GetInventoryTypeIndex(itemEquipLoc)
	
	filters:SetFilterValue("itemLevel", itemLevel)
	filters:SetFilterValue("itemType", itemType)
	filters:SetFilterValue("itemSubType", itemSubType)

	filters:EnableFilter("Existence")
	filters:EnableFilter("ItemLevel")
	filters:EnableFilter("Type")
	filters:EnableFilter("SubType")
	
	if itemSlot ~= 0 then	-- don't apply filter if = 0, it means we take them all
		filters:SetFilterValue("itemSlot", itemSlot)
		filters:EnableFilter("EquipmentSlot")
	end
	
	-- Start the search
	if upgradeType ~= -1 then	-- not an item level upgrade
		ns:SetClass(upgradeType)
		addon.Loots:FindUpgradeByStats( currentItemID, upgradeType)

	else	-- simple search, point to simple VerifyUpgrade method
		addon.Loots:FindUpgrade()
		AltoholicSearchOptionsLootInfo:SetText( GREEN .. addon.Options:Get("TotalLoots") .. "|r " .. L["Loots"] .. " / "
				.. GREEN .. addon.Options:Get("UnknownLoots") .. "|r " .. L["Unknown"])
	end
	
	filters:ClearFilters()
	currentItemID = nil

	AltoTooltip:Hide();	-- mandatory hide after processing	
	
	if not AltoholicTabSearch:IsVisible() then
		addon.Tabs:OnClick(3)
	end
	
	if upgradeType ~= -1 then	-- not an item level upgrade
		addon.Tabs.Search:SetMode("upgrade")
	else
		addon.Tabs.Search:SetMode("loots")
	end
	
	if addon.Options:Get("SortDescending") == 1 then 		-- descending sort ?
		AltoholicTabSearch_Sort8.ascendingSort = true		-- say it's ascending now, it will be toggled
		ns:SortResults(AltoholicTabSearch_Sort8, "iLvl")
	else
		AltoholicTabSearch_Sort8.ascendingSort = nil
		ns:SortResults(AltoholicTabSearch_Sort8, "iLvl")
	end

	ns:Update()
end
