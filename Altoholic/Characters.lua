local addonName = ...
local addon = _G[addonName]

local WHITE		= "|cFFFFFFFF"

local THIS_ACCOUNT = "Default"
local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

local THISREALM_THISACCOUNT = 1
local THISREALM_ALLACCOUNTS = 2
local ALLREALMS_THISACCOUNT = 3
local ALLREALMS_ALLACCOUNTS = 4


addon.Characters = {}

local ns = addon.Characters		-- ns = namespace

local characterList
local view

local function ProcessRealms(func)
	local mode = addon.Options:Get("TabSummaryMode")
	local thisRealm = GetRealmName()
	
	-- this account only
	if mode == THISREALM_THISACCOUNT then
		func(THIS_ACCOUNT, thisRealm)
		
	elseif mode == ALLREALMS_THISACCOUNT then	
		for realm in pairs(DataStore:GetRealms()) do
			func(THIS_ACCOUNT, realm)
		end

	-- all accounts
	elseif mode == THISREALM_ALLACCOUNTS then
		for account in pairs(DataStore:GetAccounts()) do
			for realm in pairs(DataStore:GetRealms(account)) do
				if realm == thisRealm then
					func(account, realm)
				end
			end
		end
		
	elseif mode == ALLREALMS_ALLACCOUNTS then
		for account in pairs(DataStore:GetAccounts()) do
			for realm in pairs(DataStore:GetRealms(account)) do
				func(account, realm)
			end
		end
	end
end

local totalMoney
local totalPlayed
local totalLevels
local realmCount

local function AddRealm(AccountName, RealmName)

	local comm = Altoholic.Comm.Sharing
	if comm.SharingInProgress then
		if comm.account == AccountName and RealmName == GetRealmName() then
			-- if we're trying to add the account+realm we're currently copying, then don't add it now.
			return
		end
	end

	local realmMoney = 0
	local realmPlayed = 0
	local realmLevels = 0
	local realmBagSlots = 0
	local realmFreeBagSlots = 0
	local realmBankSlots = 0
	local realmFreeBankSlots = 0
	
	local SkillsCache = { {name = "", rank = 0}, {name = "", rank = 0} }

	-- 1) Add the realm name
	table.insert(characterList, { linetype = INFO_REALM_LINE + (realmCount*3),
		isCollapsed = false,
		account = AccountName,
		realm = RealmName
	} )
	
	-- 2) Add the characters
	for characterName, character in pairs(DataStore:GetCharacters(RealmName, AccountName)) do
		SkillsCache[1].name = ""
		SkillsCache[1].rank = 0
		SkillsCache[1].spellID = nil
		SkillsCache[2].name = ""
		SkillsCache[2].rank = 0
		SkillsCache[2].spellID = nil

		local i = 1
		local professions = DataStore:GetPrimaryProfessions(character)
		if professions then
			for SkillName, s in pairs(professions) do
				SkillsCache[i].name = SkillName
				SkillsCache[i].rank = DataStore:GetSkillInfo(character, SkillName)
				SkillsCache[i].spellID = DataStore:GetProfessionSpellID(SkillName)
				i = i + 1
				
				if i > 2 then		-- it seems that under certain conditions, the loop continues after 2 professions.., so break
					break
				end
			end
		end
		
		table.insert(characterList, { linetype = INFO_CHARACTER_LINE + (realmCount*3),
			key = character,
			skillName1 = SkillsCache[1].name,
			skillRank1 = SkillsCache[1].rank,
			spellID1 = SkillsCache[1].spellID,
			skillName2 = SkillsCache[2].name,
			skillRank2 = SkillsCache[2].rank,
			spellID2 = SkillsCache[2].spellID,
			cooking = DataStore:GetCookingRank(character),
			firstaid = DataStore:GetFirstAidRank(character),
			fishing = DataStore:GetFishingRank(character),
			riding = DataStore:GetRidingRank(character),
		} )

		realmLevels = realmLevels + (DataStore:GetCharacterLevel(character) or 0)
		realmMoney = realmMoney + (DataStore:GetMoney(character) or 0)
		realmPlayed = realmPlayed + (DataStore:GetPlayTime(character) or 0)
		
		realmBagSlots = realmBagSlots + (DataStore:GetNumBagSlots(character) or 0)
		realmFreeBagSlots = realmFreeBagSlots + (DataStore:GetNumFreeBagSlots(character) or 0)
		realmBankSlots = realmBankSlots + (DataStore:GetNumBankSlots(character) or 0)
		realmFreeBankSlots = realmFreeBankSlots + (DataStore:GetNumFreeBankSlots(character) or 0)
	end		-- end char

	-- 3) Add the totals
	table.insert(characterList, { linetype = INFO_TOTAL_LINE + (realmCount*3),
		level = WHITE .. realmLevels,
		money = realmMoney,
		played = Altoholic:GetTimeString(realmPlayed),
		bagSlots = realmBagSlots,
		freeBagSlots = realmFreeBagSlots,
		bankSlots = realmBankSlots,
		freeBankSlots = realmFreeBankSlots
	} )

	totalMoney = totalMoney + realmMoney
	totalPlayed = totalPlayed + realmPlayed
	totalLevels = totalLevels + realmLevels
	realmCount = realmCount + 1
end

function ns:BuildList()
	characterList = characterList or {}
	wipe(characterList)
	
	totalMoney = 0
	totalPlayed = 0
	totalLevels = 0
	realmCount = 0 -- will be required for sorting purposes
	ProcessRealms(AddRealm)
	
	AltoholicFrameTotalLv:SetText(format("%s |rLv", WHITE .. totalLevels))
	AltoholicFrameTotalGold:SetText(format(GOLD_AMOUNT_TEXTURE, floor( totalMoney / 10000 ), 13, 13))
	AltoholicFrameTotalPlayed:SetText(floor(totalPlayed / 86400) .. "|cFFFFD700d")
end

local function AddRealmView(AccountName, RealmName)
	for index, line in pairs(characterList) do
		if mod(line.linetype, 3) == INFO_REALM_LINE then
			if (line.account == AccountName) and (line.realm == RealmName) then
				-- insert index to current line (INFO_REALM_LINE)
				table.insert(view, index)
				index = index + 1

				-- insert index to the rest of the realm 
				local linetype = mod(characterList[index].linetype, 3)
				while (linetype ~= INFO_REALM_LINE) do
					table.insert(view, index)
					index = index + 1
					if index > #characterList then
						return
					end
					linetype = mod(characterList[index].linetype, 3)
				end
				return
			end
		end
	end
end

function ns:BuildView()
	-- The character info index is a small table that basically indexes character info
	-- ex: character info contains data for 4 realms on two accounts, but the index only cares about the summary tab filter,
	-- and indexes just one realm, or one account
	view = view or {}
	wipe(view)
	
	ProcessRealms(AddRealmView)
end

local function SortByPrimarySkill(a, b, skillName, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by field xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end

		local skillA = DataStore:GetSkillInfo(a.key, a[skillName])
		local skillB = DataStore:GetSkillInfo(b.key, b[skillName])
		
		if ascending then
			return skillA < skillB
		else
			return skillA > skillB
		end
	end
end

local function SortByFunction(a, b, func, ascending)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by func xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end

		local retA = DataStore[func](self, a.key) or 0		-- set to zero if a return value is nil, so that they can be compared
		local retB = DataStore[func](self, b.key) or 0
		
		if ascending then
			return retA < retB
		else
			return retA > retB
		end
	end
end

function ns:Sort(frame, field)
	local ascending = frame.ascendingSort

	-- Primary Skill
	if (field == "skillName1") or (field == "skillName2") then
		table.sort(characterList, function(a, b) return SortByPrimarySkill(a, b, field, ascending)
			end)
	else
		table.sort(characterList, function(a, b) return SortByFunction(a, b, field, ascending) end)
	end

	addon.Tabs.Summary:Refresh()
end

function ns:Get(index)
	return characterList[index]
end

function ns:GetView()
	return view
end

function ns:GetNum()
	return #characterList or 0
end

function ns:GetInfo(index)
	-- with the line number in the characterList table, return the name, realm & account of a char.
	local lineType = ns:GetLineType(index)
	
	if lineType == INFO_REALM_LINE then
		local line = characterList[index]
		return _, line.realm, line.account
	elseif lineType == INFO_CHARACTER_LINE then
		local account, realm, name = strsplit(".", characterList[index].key)
		return name, realm, account
	end
end

function ns:GetLineType(index)
	return mod(characterList[index].linetype, 3)
end

function ns:GetField(index, field)
	local character = characterList[index]
	if character then
		return character[field]
	end
end

function ns:ToggleView(frame)
	for _, line in pairs(characterList) do
		if mod(line.linetype, 3) == INFO_REALM_LINE then
			line.isCollapsed = (frame.isCollapsed) or false
		end
	end
end

function ns:ToggleHeader(frame)
	local line = frame:GetParent():GetID()
	if line == 0 then return end
	
	local header = characterList[line]

	if header.isCollapsed ~= nil then
		if header.isCollapsed == true then
			header.isCollapsed = false
		else
			header.isCollapsed = true
		end
	end
end
