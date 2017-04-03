--[[	*** DataStore_Achievements ***
Written by : Thaoky, EU-Marécages de Zangar
June 21st, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Achievements"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"

local AddonDB_Defaults = {
	global = {
		Characters = {
			['*'] = {					-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				numAchievements = 0,
				numCompletedAchievements = 0,
				numAchievementPoints = 0,
				guid = nil,
				Achievements = {},
				CompletionDates = {},
			}
		}
	}
}

-- *** Scanning functions ***
local CriteriaCache = {}

local function ScanSingleAchievement(id, isCompleted, month, day, year)
	addon.ThisCharacter.lastUpdate = time()
	local Achievements = addon.ThisCharacter.Achievements
	
	-- a given entry can have 3 types of values:
	--	nil	= the achievement has not been started, not even a single criteria
	--	true = the achievement has been completed, so implicitly, all criterias have been completed too
	--	string	= the achievement is partially complete, so a string of values describes the state of completion
	
	if isCompleted then
		Achievements[id] = true		-- true when completed, all criterias are completed thus
		addon.ThisCharacter.CompletionDates[id] = format("%d:%d:%d", month, day, year)
		return
	end

	wipe(CriteriaCache)
	for j = 1, GetAchievementNumCriteria(id) do
		-- ** calling GetAchievementCriteriaInfo in this loop is what costs the most in terms of cpu time **
		local _, _, critCompleted, quantity, reqQuantity = GetAchievementCriteriaInfo(id, j);
	   local currentCrit
	   
	   if critCompleted then 
	      table.insert(CriteriaCache, tostring(j))
	   else                  
	      if reqQuantity > 1 then
	         table.insert(CriteriaCache, j .. ":" .. quantity)
	      end
	   end
	end
	
	if #CriteriaCache > 0 then		-- if at least one criteria completed, save the entry, do nothing otherwise
		Achievements[id] = table.concat(CriteriaCache, ",")
	end
end

local function ScanAllAchievements()
	wipe(addon.ThisCharacter.Achievements)
	
	local cats = GetCategoryList()
	local achievementID, achCompleted
	local prevID
	
	for _, categoryID in ipairs(cats) do
		for i = 1, GetCategoryNumAchievements(categoryID) do
			achievementID, _, _, achCompleted, month, day, year = GetAchievementInfo(categoryID, i);
			ScanSingleAchievement(achievementID, achCompleted, month, day, year)
			
			-- track previous steps of a progressive achievements
			prevID = GetPreviousAchievement(achievementID)
			
			while type(prevID) ~= "nil" do
				achievementID, _, _, achCompleted, month, day, year = GetAchievementInfo(prevID);
				ScanSingleAchievement(achievementID, achCompleted, month, day, year)
				prevID = GetPreviousAchievement(achievementID)
			end
		end
	end	
end

local function ScanProgress()
	local char = addon.ThisCharacter
	local total, completed = GetNumCompletedAchievements()
	
	char.numAchievements = total
	char.numCompletedAchievements = completed
	char.numAchievementPoints = GetTotalAchievementPoints()
end


-- ** Mixins **
local function _GetAchievementInfo(character, achievementID)
	local achievement = character.Achievements[achievementID]
	
	if achievement then						-- if there's a value ..
		local isStarted = true				-- .. the achievement has been worked on
		local isComplete
		if achievement == true then		-- ..and might even have been completed
			isComplete = true
		end
		return isStarted, isComplete
	end
	-- implicit return of nil, nil otherwise
end
	
local function _GetCriteriaInfo(character, achievementID, criteriaIndex)
	local achievement = character.Achievements[achievementID]
	
	if type(achievement) == "string" then	-- only return criteria info if the DB value is a string

		for v in achievement:gmatch("([^,]+)") do
			local index, qty = strsplit(":", v)
			
			index = tonumber(index)
			qty = tonumber(qty)
			
			if criteriaIndex == index then
				local isStarted = true				-- .. the criteria has been worked on
				local isComplete
				if not qty then						-- ..and might even have been completed (no qty means complete)
					isComplete = true
				end
				
				-- this will return :
					-- true, true, nil		if the criteria is 100% completed
					-- true, nil, value		if the criteria is partially complete
				return isStarted, isComplete, qty
			end
		end
	end
	-- implicit return of nil, nil , nil 	(not started, not complete)
end
	
local function _GetNumAchievements(character)
	return character.numAchievements
end
	
local function _GetNumCompletedAchievements(character)
	return character.numCompletedAchievements
end
	
local function _GetNumAchievementPoints(character)
	return character.numAchievementPoints
end

local function _GetAchievementLink(character, achievementID)
	-- information sources : 
		-- http://www.wowwiki.com/AchievementLink
		-- http://www.wowwiki.com/AchievementString
	if not character.guid then return end
		
	local achievement = character.Achievements[achievementID]
	if not achievement then return end				-- exit if there's no value ..

	local link
	local completion		-- will contain: finished (0 or 1), month, day, year
	local criterias
	
	if achievement == true then	-- totally completed
		local completionDate = character.CompletionDates[achievementID]
		if not completionDate then return end		-- if there's no data yet for this achievement, the link can't be created, return nil
		
		completion = format("1:%s", completionDate)							-- ex: 1:12:19:8		1 = finished, on 12/19/2008
		criterias = "4294967295:4294967295:4294967295:4294967295"		-- 4294967295 = the highest 32-bit value = 32 bits set to 1
	else									-- partially completed
		completion = "0:0:0:-1"
		
		local bitset = { 0, 0, 0, 0 }		-- a simple array that will contain the 4 values to store into "criterias"
		local isComplete
		local numCriteria = GetAchievementNumCriteria(achievementID)
		
		for criteriaIndex = 1, numCriteria do			-- browse all criterias
			local index = ceil(criteriaIndex / 32)		-- store in bitset[1], [2] ..
			
			_, isComplete = _GetCriteriaInfo(character, achievementID, criteriaIndex)
			if isComplete then
				local pos = mod(criteriaIndex, 32)		-- pos must be within [1 .. 32]
				pos = (pos == 0) and 32 or pos			-- if the modulo leads to 0, change it to 32
				bitset[index] = bitset[index] + (2^(pos-1))		-- I'll change this to use bit functions later on, for the time being, this works fine.
			end
		end
		
		criterias = table.concat(bitset, ":")
	end
	
	local _, name = GetAchievementInfo(achievementID)
	
	return format("|cffffff00|Hachievement:%s:%s:%s:%s|h\[%s\]|h|r", achievementID, character.guid, completion, criterias, name)
end

local PublicMethods = {
	GetAchievementInfo = _GetAchievementInfo,
	GetCriteriaInfo = _GetCriteriaInfo,
	GetNumAchievements = _GetNumAchievements,
	GetNumCompletedAchievements = _GetNumCompletedAchievements,
	GetNumAchievementPoints = _GetNumAchievementPoints,
	GetAchievementLink = _GetAchievementLink,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
	
	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetCharacterBasedMethod("GetAchievementInfo")
	DataStore:SetCharacterBasedMethod("GetCriteriaInfo")
	DataStore:SetCharacterBasedMethod("GetNumAchievements")
	DataStore:SetCharacterBasedMethod("GetNumCompletedAchievements")
	DataStore:SetCharacterBasedMethod("GetNumAchievementPoints")
	DataStore:SetCharacterBasedMethod("GetAchievementLink")
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE")
	addon:RegisterEvent("ACHIEVEMENT_EARNED")
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("ACHIEVEMENT_EARNED")
end


-- *** EVENT HANDLERS ***
function addon:PLAYER_ALIVE()
	ScanAllAchievements()
	ScanProgress()
	addon.ThisCharacter.guid = strsub(UnitGUID("player"), 3)	-- get rid at the 0x at the beginning of the string
end

function addon:ACHIEVEMENT_EARNED(self, id)
	if id then
		local _, _, _, achCompleted, month, day, year = GetAchievementInfo(id)
		ScanSingleAchievement(id, true, month, day, year)
		ScanProgress()
	end
end
