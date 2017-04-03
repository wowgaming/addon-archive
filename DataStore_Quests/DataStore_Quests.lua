--[[	*** DataStore_Quests ***
Written by : Thaoky, EU-Marécages de Zangar
July 8th, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Quests"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Options = {
			TrackTurnIns = 1,					-- by default, save the ids of completed quests in the history
			AutoUpdateHistory = 1,			-- if history has been queried at least once, auto update it at logon (fast operation - already in the game's cache)
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				Quests = {},
				QuestLinks = {},
				Rewards = {},
				History = {},		-- a list of completed quests, hash table ( [questID] = true )
				HistoryBuild = nil,	-- build version under which the history has been saved
				HistorySize = 0,
				HistoryLastUpdate = nil,
			}
		}
	}
}

-- *** Utility functions ***
local function GetOption(option)
	return addon.db.global.Options[option]
end

local function GetQuestLogIndexByName(name)
	-- helper function taken from QuestGuru
	for i = 1, GetNumQuestLogEntries() do
		local title = GetQuestLogTitle(i);
		if title == strtrim(name) then
			return i
		end
	end
end

-- *** Scanning functions ***
local headersState = {}

local function SaveHeaders()
	local headerCount = 0		-- use a counter to avoid being bound to header names, which might not be unique.
	
	for i = GetNumQuestLogEntries(), 1, -1 do		-- 1st pass, expand all categories
		local _, _, _, _, isHeader, isCollapsed = GetQuestLogTitle(i)
		if isHeader then
			headerCount = headerCount + 1
			if isCollapsed then
				ExpandQuestHeader(i)
				headersState[headerCount] = true
			end
		end
	end
end

local function RestoreHeaders()
	local headerCount = 0
	for i = GetNumQuestLogEntries(), 1, -1 do
		local _, _, _, _, isHeader = GetQuestLogTitle(i)
		if isHeader then
			headerCount = headerCount + 1
			if headersState[headerCount] then
				CollapseQuestHeader(i)
			end
		end
	end
	wipe(headersState)
end

local REWARD_TYPE_CHOICE = "c"
local REWARD_TYPE_REWARD = "r"
local REWARD_TYPE_SPELL = "s"

local function ScanQuests()
	local char = addon.ThisCharacter
	local quests = char.Quests
	local links = char.QuestLinks
	local rewards = char.Rewards
	
	wipe(quests)
	wipe(links)
	wipe(rewards)

	local currentSelection = GetQuestLogSelection()		-- save the currently selected quest
	SaveHeaders()

	local RewardsCache = {}
	for i = 1, GetNumQuestLogEntries() do
		local title, _, questTag, groupSize, isHeader, _, isComplete = GetQuestLogTitle(i);
		
		if isHeader then
			quests[i] = "0|" .. (title or "")
		else
			SelectQuestLogEntry(i)
			local money = GetQuestLogRewardMoney()
			quests[i] = format("1|%s|%d|%d|%d", questTag or "", groupSize, money, isComplete or 0)
			links[i] = GetQuestLink(i)
			
			wipe(RewardsCache)
			local num = GetNumQuestLogChoices()		-- these are the actual item choices proposed to the player
			if num > 0 then
				for i = 1, num do
					local _, _, numItems, _, isUsable = GetQuestLogChoiceInfo(i)
					local link = GetQuestLogItemLink("choice", i)
					if link then
						local id = tonumber(link:match("item:(%d+)"))
						if id then
							table.insert(RewardsCache, REWARD_TYPE_CHOICE .."|"..id.."|"..numItems.."|"..(isUsable or 0))
						end
					end
				end
			end
			
			num = GetNumQuestLogRewards()				-- these are the rewards given anyway
			if num > 0 then
				for i = 1, num do
					local _, _, numItems, _, isUsable = GetQuestLogRewardInfo(i)
					local link = GetQuestLogItemLink("reward", i)
					if link then
						local id = tonumber(link:match("item:(%d+)"))
						if id then
							table.insert(RewardsCache, REWARD_TYPE_REWARD .. "|"..id.."|"..numItems.."|"..(isUsable or 0))
						end
					end
				end
			end

			if GetQuestLogRewardSpell() then		-- apparently, there is only one spell as reward
				local _, _, isTradeskillSpell, isSpellLearned = GetQuestLogRewardSpell()
				if isTradeskillSpell or isSpellLearned then
					local link = GetQuestLogSpellLink()
					if link then
						local id = tonumber(link:match("spell:(%d+)")) 
						if id then
							table.insert(RewardsCache, REWARD_TYPE_SPELL .. "|"..id)
						end
					end
				end
			end

			if #RewardsCache > 0 then
				rewards[i] = table.concat(RewardsCache, ",")
			end
		end
	end
	
	RestoreHeaders()
	SelectQuestLogEntry(currentSelection)		-- restore the selection to match the cursor, must be properly set if a user abandons a quest
	
	addon.ThisCharacter.lastUpdate = time()
end

local function RefreshQuestHistory()
	-- called 5 seconds after login, if the current character already has an history, one that was saved in the same build, then it's safe to refresh it automatically
	local thisChar = addon.ThisCharacter
	if not thisChar.HistoryLastUpdate then return end	-- never scanned the history before ? exit
	
	local _, version = GetBuildInfo()
	if version and thisChar.HistoryBuild and version == thisChar.HistoryBuild then	-- proceed if version is the same as the one saved in the db
		QueryQuestsCompleted()
	end
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanQuests()
end

local function OnQuestLogUpdate()
	addon:UnregisterEvent("QUEST_LOG_UPDATE")		-- .. and unregister it right away, since we only want it to be processed once (and it's triggered way too often otherwise)
	ScanQuests()
end

local function OnUnitQuestLogChanged()			-- triggered when accepting/validating a quest .. but too soon to refresh data
	addon:RegisterEvent("QUEST_LOG_UPDATE", OnQuestLogUpdate)		-- so register for this one ..
end

local lastCompleteQuestLink

local function OnQuestComplete()
	if GetOption("TrackTurnIns") ~= 1 then return end
	
	-- "QUEST_COMPLETE" is triggered when the UI reaches the page where a player can click on the "Complete" Button.
	-- At this point, only detect which quest we're dealing with, and save its link
	local num = GetQuestLogIndexByName(GetTitleText());
	if num then
		lastCompleteQuestLink = GetQuestLink(num)		-- or save quest id
	end
end

local queryVerbose

local function OnQuestQueryComplete()
	local thisChar = addon.ThisCharacter
	local history = thisChar.History
	local quests = {}
	GetQuestsCompleted(quests)
	
	local count = 0
	for questID in pairs(quests) do
		history[questID] = true
		count = count + 1
	end
	
	local _, version = GetBuildInfo()				-- save the current build, to know if we can requery and expect immediate execution
	thisChar.HistoryBuild = version
	thisChar.HistorySize = count
	thisChar.HistoryLastUpdate = time()
	
	if queryVerbose then
		addon:Print("Quest history successfully retrieved!")
		queryVerbose = nil
	end
end

-- ** Mixins **
local function _GetQuestLogSize(character)
	return #character.Quests
end

local function _GetQuestLogInfo(character, index)
	local quest = character.Quests[index]
	local link = character.QuestLinks[index]
	local isHeader, questTag, groupSize, money, isComplete = strsplit("|", quest)
	
	if isHeader == "0" then
		return true, questTag	-- questTag contains the title in a header line
	end
	
	isComplete = tonumber(isComplete)
	return nil, link, questTag, tonumber(groupSize), tonumber(money), tonumber(isComplete)
end

local function _GetQuestLogNumRewards(character, index)
	local reward = character.Rewards[index]
	if reward then
		return select(2, gsub(reward, ",", ",")) + 1		-- returns the number of rewards (=count of ^ +1)
	end
	return 0
end

local function _GetQuestLogRewardInfo(character, index, rewardIndex)
	local reward = character.Rewards[index]
	if not reward then return end
	
	local i = 1
	for v in reward:gmatch("([^,]+)") do
		if rewardIndex == i then
			local rewardType, id, numItems, isUsable = strsplit("|", v)
			
			numItems = tonumber(numItems) or 0
			isUsable = (isUsable and isUsable == 1) and true or nil
						
			return rewardType, tonumber(id), numItems, isUsable
		end	
		i = i + 1
	end
end
	
local function _GetQuestInfo(link)
	assert(type(link) == "string")
	
	local questID, questLevel = link:match("quest:(%d+):(-?%d+)")
	local questName = link:match("%[(.+)%]")
	
	return questName, tonumber(questID), tonumber(questLevel)
end

local function _QueryQuestHistory()
	QueryQuestsCompleted()		-- this call triggers "QUEST_QUERY_COMPLETE"
	queryVerbose = true
end

local function _GetQuestHistory(character)
	return character.History
end

local function _GetQuestHistoryInfo(character)
	-- return the size of the history, the timestamp, and the build under which it was saved
	return character.HistorySize, character.HistoryLastUpdate, character.HistoryBuild
end

local function _IsQuestCompletedBy(character, questID)
	return character.History[questID]		-- nil = not completed (not in the table), true = completed
end

local PublicMethods = {
	GetQuestLogSize = _GetQuestLogSize,
	GetQuestLogInfo = _GetQuestLogInfo,
	GetQuestLogNumRewards = _GetQuestLogNumRewards,
	GetQuestLogRewardInfo = _GetQuestLogRewardInfo,
	GetQuestInfo = _GetQuestInfo,
	QueryQuestHistory = _QueryQuestHistory,
	GetQuestHistory = _GetQuestHistory,
	GetQuestHistoryInfo = _GetQuestHistoryInfo,
	IsQuestCompletedBy = _IsQuestCompletedBy,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetQuestLogSize")
	DataStore:SetCharacterBasedMethod("GetQuestLogInfo")
	DataStore:SetCharacterBasedMethod("GetQuestLogNumRewards")
	DataStore:SetCharacterBasedMethod("GetQuestLogRewardInfo")
	DataStore:SetCharacterBasedMethod("GetQuestHistory")
	DataStore:SetCharacterBasedMethod("GetQuestHistoryInfo")
	DataStore:SetCharacterBasedMethod("IsQuestCompletedBy")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("UNIT_QUEST_LOG_CHANGED", OnUnitQuestLogChanged)
	addon:RegisterEvent("QUEST_COMPLETE", OnQuestComplete)
	addon:RegisterEvent("QUEST_QUERY_COMPLETE", OnQuestQueryComplete)
	
	addon:SetupOptions()
	
	if GetOption("AutoUpdateHistory") == 1 then		-- if history has been queried at least once, auto update it at logon (fast operation - already in the game's cache)
		addon:ScheduleTimer(RefreshQuestHistory, 5)	-- refresh quest history 5 seconds later, to decrease the load at startup
	end
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("UNIT_QUEST_LOG_CHANGED")
	addon:UnregisterEvent("QUEST_QUERY_COMPLETE")
end

-- *** Hooks ***

local Orig_QuestRewardCompleteButton_OnClick = QuestRewardCompleteButton_OnClick;

function QuestRewardCompleteButton_OnClick()
	if lastCompleteQuestLink then			-- if there's a valid link
		local questID = lastCompleteQuestLink:match("quest:(%d+):")
		questID = tonumber(questID)
		if questID then
			addon.ThisCharacter.History[questID] = true		-- mark the current quest ID as completed
			addon:SendMessage("DATASTORE_QUEST_TURNED_IN", questID)		-- trigger the DS event
		end
		lastCompleteQuestLink = nil
	end
	Orig_QuestRewardCompleteButton_OnClick();
end

QuestFrameCompleteQuestButton:SetScript("OnClick", QuestRewardCompleteButton_OnClick);
