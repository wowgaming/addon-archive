--[[	*** DataStore ***
Written by : Thaoky, EU-Marécages de Zangar
July 15th, 2009

This is the main DataStore module, its purpose is to be a single point of contact for common operations between client addons and other DataStore modules.
For instance, it prevents client addons from calling a different :GetCharacter() in each module, as the value returned by the main module can be passed to the other ones.

Other services offered by DataStore:
	- DataStore Events ; possibility to trigger and respond to DataStore's own events (see the respective modules for details)
	- Tracks guild members status in a slightly more accurate way than with GUILD_ROSTER_UPDATE alone.
	- Guild member info can be requested by character name (DataStore:GetGuildMemberInfo(member)) rather than by index (GetGuildRosterInfo)
	- Tracks online guild members' alts, used mostly by other DataStore modules, but can also be used by client addons.
		Note: a "main" is the currently connected player, "alts" are all his other characters in the same guild. The notions of "main" & "alts" are thus only valid for live data, nothing else.
--]]
DataStore = LibStub("AceAddon-3.0"):NewAddon("DataStore", "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0")

local addon = DataStore
addon.Version = "v3.3.001"

local THIS_ACCOUNT = "Default"
local commPrefix = "DataStore"
local Characters, Guilds			-- pointers to the parts of the DB that contain character, guild data

local RegisteredModules = {}
local RegisteredMethods = {}

local guildMembersIndexes = {} 	-- hash table containing guild member info
local onlineMembers = {}			-- simple hash table to track online members:		["member"] = true (or nil)
local onlineMembersAlts = {}		-- simple hash table to track online members' alts:	["member"] = "alt1|alt2|alt3..."

-- Message types
local MSG_ANNOUNCELOGIN				= 1	-- broacast at login
local MSG_LOGINREPLY					= 2	-- reply to MSG_ANNOUNCELOGIN

local AddonDB_Defaults = {
	global = {
		Guilds = {
			['*'] = {				-- ["Account.Realm.Name"] 
				faction = nil,
			}
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				faction = nil,
				guildName = nil,		-- nil = not in a guild, as returned by GetGuildInfo("player")
			}
		},
		SharedContent = {			-- lists the shared content
			--	["Account.Realm.Name"]  = true means the char is shared,
			--	["Account.Realm.Name.Module"]  = true means the module is shared for that char
		},
	}
}

local function GetKey(name, realm, account)
	-- default values
	name = name or UnitName("player")
	realm = realm or GetRealmName()
	account = account or THIS_ACCOUNT
	
	return format("%s.%s.%s", account, realm, name)
end

local function GetDBVersion()
	return addon.db.global.Version or 0
end

local function SetDBVersion(version)
	addon.db.global.Version = version
end

local DBUpdaters = {
	-- Table of functions, each one updates to its index's version
	--	ex: [3] = the function that upgrades from v2 to v3
	[1] = function(self)
			-- This function moves character keys from the "global" level to the "Characters" sub-table
			-- keys are also changed from a simple boolean (previously set to true) to a table. Only faction & guildname are tracked (for later use)
			for k, v in pairs(addon.db.global) do
				if type(v) == "boolean" then
					if not addon.db.global.Characters[k].faction then		-- for characters other than the current one ..
						addon.db.global.Characters[k].faction = "" -- set the faction field to create the table.
					end
					addon.db.global[k] = nil	-- kill the key at the old location
				end
			end
		end,
}

local function UpdateDB()
	local version = GetDBVersion()
	
	for i = (version+1), #DBUpdaters do		-- start from latest version +1 to the very last
		DBUpdaters[i]()
		SetDBVersion(i)
	end
	
	DBUpdaters = nil
	GetDBVersion = nil
	SetDBVersion = nil
end

local function GetAlts(guild)
	-- returns a | delimited string containing the list of alts in the same guild
	guild = guild or GetGuildInfo("player")
	if not guild then	return end
		
	local out = {}
	for k, v in pairs(Characters) do
		local accountKey, realmKey, charKey = strsplit(".", k)
		
		if accountKey and accountKey == THIS_ACCOUNT then			-- same account
			if realmKey and realmKey == GetRealmName() then			-- same realm
				if charKey and charKey ~= UnitName("player") then	-- skip current char
					if v.guildName and v.guildName == guild then		-- same guild (to send only guilded alts, privacy concern, do not change this)
						table.insert(out, charKey)
					end
				end
			end
		end
	end
	
	return table.concat(out, "|")
end

local function SaveAlts(sender, alts)
	if alts then
		if strlen(alts) > 0 then	-- sender has no alts
			onlineMembersAlts[sender] = alts				-- "alt1|alt2|alt3..."
		end
		addon:SendMessage("DATASTORE_GUILD_ALTS_RECEIVED", sender, alts)
	end
end

local function GuildBroadcast(messageType, ...)
	local serializedData = addon:Serialize(messageType, ...)
	addon:SendCommMessage(commPrefix, serializedData, "GUILD")
end

local function GuildWhisper(player, messageType, ...)
	if addon:IsGuildMemberOnline(player) then
		local serializedData = addon:Serialize(messageType, ...)
		addon:SendCommMessage(commPrefix, serializedData, "WHISPER", player)
	end
end

local function CopyTable(src, dest)
	for k, v in pairs (src) do
		if type(v) == "table" then
			dest[k] = {}
			CopyTable(v, dest[k])
		else
			dest[k] = v
		end
	end
end

-- *** Event Handlers ***
local currentGuildName

local function OnPlayerGuildUpdate()
	-- at login this event is called between OnEnable and PLAYER_ALIVE, where GetGuildInfo returns a wrong value
	-- however, the value returned here is correct
	if IsInGuild() and not currentGuildName then		-- the event may be triggered multiple times, and GetGuildInfo may return incoherent values in subsequent calls, so only save if we have no value.
		currentGuildName = GetGuildInfo("player")
		if currentGuildName then	
			Guilds[GetKey(currentGuildName)].faction = UnitFactionGroup("player")
			-- the first time a valid value is found, broadcast to guild, it must happen here for a standard login, but won't work here after a reloadui since this event is not triggered
			GuildBroadcast(MSG_ANNOUNCELOGIN, GetAlts(currentGuildName))
			addon:SendMessage("DATASTORE_ANNOUNCELOGIN", currentGuildName)
		end
	end
	Characters[GetKey()].guildName = currentGuildName
end

local function OnPlayerAlive()
	Characters[GetKey()].faction = UnitFactionGroup("player")
	OnPlayerGuildUpdate()
end

local function OnGuildRosterUpdate()
	wipe(guildMembersIndexes)
	for i=1, GetNumGuildMembers(true) do		-- browse all players (online & offline)
		local name, _, _, _, _, _, _, _, onlineStatus = GetGuildRosterInfo(i)
		if name then
			guildMembersIndexes[name] = i
			
			if onlineMembers[name] and not onlineStatus then	-- if a player was online but has now gone offline, trigger a message
				addon:SendMessage("DATASTORE_GUILD_MEMBER_OFFLINE", name)
			end
			onlineMembers[name] = onlineStatus
		end
	end
end

local msgOffline = gsub(ERR_FRIEND_OFFLINE_S, "%%s", "(.+)")		-- this turns "%s has gone offline." into "(.+) has gone offline."

local function OnChatMsgSystem(event, arg)
	if arg then
		local member = arg:match(msgOffline)
		if member then
			-- guild roster update can be triggered every 10 secs max, so if a players logs in & out right after, sending him message will result in "No player named xx"
			-- marking him as offline prevents this
			onlineMembers[member] = nil
			onlineMembersAlts[member] = nil
			addon:SendMessage("DATASTORE_GUILD_MEMBER_OFFLINE", member)
		end
	end
end

-- *** Guild Comm ***
local GuildCommCallbacks = {
	[commPrefix] = {
		[MSG_ANNOUNCELOGIN] = function(sender, alts)
				onlineMembers[sender] = true									-- sender is obviously online
				if sender ~= UnitName("player") then						-- don't send back to self
					GuildWhisper(sender, MSG_LOGINREPLY, GetAlts())		-- reply by sending my own alts ..
				end
				SaveAlts(sender, alts)											-- .. and save received data
			end,
		[MSG_LOGINREPLY] = function(sender, alts)
				SaveAlts(sender, alts)
			end,
	},
}

local function GuildCommHandler(prefix, message, distribution, sender)
	-- This handler will be used by other modules as well
	local success, msgType, arg1, arg2, arg3 = addon:Deserialize(message)
	
	if success and msgType and GuildCommCallbacks[prefix] then
		local func = GuildCommCallbacks[prefix][msgType]
		
		if func then
			func(sender, arg1, arg2, arg3)
		end
	end
end

-- Explanation of this piece of code
-- Whenever DataStore:MethodXXX(arg1, arg2, etc..) is called, this attempts to find the method in the registered list
-- If this method is character related, we intercept the string (ex: ["Default.RealmZZZ.CharYYY") and get the associated character table in the module that owns these data
-- since we actually pass a table to registered methods, the "conversion" is done here.

--[[	*** Sample code ***
	local character = DataStore:GetCharacter()

	-- while the implementation of GetNumSpells in DataStore_Spells expects a table as first parameter, the string value returned by GetCharacter is converted on the fly
	-- this service prevents having to maintain a separate pointer to each character table in the respective DataStore_* modules.
	local n = DataStore:GetNumSpells(character, "Fire")	
	print(n)
--]]

local lookupMethods = { __index = function(self, key)
	return function(self, arg1, ...)
		if not RegisteredMethods[key] then
--			print(format("DataStore : method <%s> is missing.", key))			-- enable this in Debug only, there's a risk that this function gets called unexpectedly
			return
		end
	
		if RegisteredMethods[key].isCharBased then		-- if this method is character related, the first expected parameter is the character
			local owner = RegisteredMethods[key].owner
			arg1 = owner.Characters[arg1]						-- turns a "string" parameter into a table, fully intended.
			if not arg1.lastUpdate then return end			-- lastUpdate must be present in the Character part of a db, if not, data is unavailable
			
		elseif RegisteredMethods[key].isGuildBased then	-- if this method is guild related, the first expected parameter is the guild
			local owner = RegisteredMethods[key].owner
			arg1 = owner.Guilds[arg1]							-- turns a "string" parameter into a table, fully intended.
			if not arg1 then return end
			
		end
		return RegisteredMethods[key].func(arg1, ...)
	end
end }

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New("DataStoreDB", AddonDB_Defaults)
	
	Characters = addon.db.global.Characters
	Guilds = addon.db.global.Guilds
	UpdateDB()
	
	setmetatable(addon, lookupMethods)
	
	addon:SetupOptions()		-- See Options.lua
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("PLAYER_GUILD_UPDATE", OnPlayerGuildUpdate)				-- for gkick, gquit, etc..
	
	if IsInGuild() then
		addon:RegisterEvent("GUILD_ROSTER_UPDATE", OnGuildRosterUpdate)
		-- we only care about "%s has come online" or "%s has gone offline", so register only if player is in a guild
		addon:RegisterEvent("CHAT_MSG_SYSTEM", OnChatMsgSystem)
		addon:RegisterComm(commPrefix, GuildCommHandler)
		
		local guild = GetGuildInfo("player")		-- will be nil in a standard login (called too soon), but ok for a reloadui.
		if guild then
			GuildBroadcast(MSG_ANNOUNCELOGIN, GetAlts(guild))
			addon:SendMessage("DATASTORE_ANNOUNCELOGIN", guild)
		end
	end
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("PLAYER_GUILD_UPDATE")
	addon:UnregisterEvent("GUILD_ROSTER_UPDATE")
	addon:UnregisterEvent("CHAT_MSG_SYSTEM")
end

-- *** DB functions ***
function addon:RegisterModule(moduleName, module, publicMethods)
	assert(type(moduleName) == "string")
	assert(type(module) == "table")
	
	if not RegisteredModules[moduleName] then		-- add the module's database address (addon.db.global) to the list of known modules
		RegisteredModules[moduleName] = module
		local db = module.db.global

		-- simplifies the life of child modules, and prepares a few pointers for them
		module.ThisCharacter = db.Characters[GetKey()]
		module.Characters = db.Characters
		module.Guilds = db.Guilds

		-- register module's public method
		for methodName, method in pairs(publicMethods) do
			if RegisteredMethods[methodName] then
				print(format("DataStore:RegisterMethod() : adding method for module <%s> failed.", moduleName))
				print(format("DataStore:RegisterMethod() : method <%s> already exists !", methodName))
				return 
			end
			
			RegisteredMethods[methodName] = {
				func = method,
				owner = module, 			-- module that owns this method & associated data
			}
		end
	end
end

function addon:SetCharacterBasedMethod(methodName)
	-- flags a given method as character based
	if RegisteredMethods[methodName] then
		-- this will take care of error checking before calling the registered method, and pass the appropriate character table as argument
		RegisteredMethods[methodName].isCharBased = true
	end
end

function addon:SetGuildBasedMethod(methodName)
	if RegisteredMethods[methodName] then
		RegisteredMethods[methodName].isGuildBased = true		-- same as above for guilds
	end
end

function addon:GetGuildCommHandler()
	return GuildCommHandler
end

function addon:SetGuildCommCallbacks(prefix, callbacks)
	GuildCommCallbacks[prefix] = callbacks		-- no need to create a new table, it exists already as a local table in the calling module
end

function addon:IsModuleEnabled(name)
	assert(type(name) == "string")
	
	if RegisteredModules[name] then
		return true
	end
end

function addon:GetCharacter(name, realm, account)
	local key = GetKey(name, realm, account)
	if Characters[key] then		-- if the key is known, return it to caller, it can be passed to other modules 
		return key
	end
end

function addon:GetCharacters(realm, account)
	-- get a list of characters on a given realm/account
	realm = realm or GetRealmName()
	account = account or THIS_ACCOUNT
	
	local out = {}
	local accountKey, realmKey, charKey
	for k, v in pairs(Characters) do
		if v.faction and v.faction == "" then		-- this is an integrity check, may happen after a failed account sync.
			Characters[k] = nil							-- kill the key, don't add it to the list.
		else
			accountKey, realmKey, charKey = strsplit(".", k)
			
			if accountKey and realmKey then
				if accountKey == account and realmKey == realm then
					out[charKey] = k	
					-- allows this kind of iteration:
						-- for characterName, character in pairs(DS:GetCharacters(realm, account)) do
							-- do stuff with characterName only
							-- or do stuff with the "character" key to pass to other DataStore functions
						-- end
				end
			end
		end
	end
	
	return out
end

function addon:DeleteCharacter(name, realm, account)
	local key = GetKey(name, realm, account)
	if not Characters[key] then return end
	
	-- delete the character in all modules
	for moduleName, moduleDB in pairs(RegisteredModules) do
		if moduleDB.Characters then
			moduleDB.Characters[key] = nil
		end
	end
	
	-- delete the key in DataStore
	Characters[key] = nil
end

function addon:GetNumCharactersInDB()
	-- a simple count of the number of character entries in the db
	
	local count = 0
	for _, _ in pairs(Characters) do
		count = count + 1
	end
	return count
end

function addon:GetGuild(name, realm, account)
	name = name or GetGuildInfo("player")
	local key = GetKey(name, realm, account)
	
	if Guilds[key] then		-- if the key is known, return it to caller, it can be passed to other modules 
		return key
	end
end

function addon:GetGuilds(realm, account)
	-- get a list of guilds on a given realm/account
	realm = realm or GetRealmName()
	account = account or THIS_ACCOUNT
	
	local out = {}
	local accountKey, realmKey, guildKey
	for k, _ in pairs(Guilds) do
		accountKey, realmKey, guildKey = strsplit(".", k)
		
		if accountKey and realmKey then
			if accountKey == account and realmKey == realm then
				out[guildKey] = k	
				-- this allows to iterate with this kind of loop:
					-- for guildName, guild in pairs(DS:GetGuilds(realm, account)) do
						-- do stuff with guildName only
						-- or do stuff with the "guild" key to pass to other DataStore functions
					-- end
			end
		end
	end
	
	return out
end

function addon:DeleteRealm(realm, account)
	for name, _ in pairs(addon:GetCharacters(realm, account)) do
		addon:DeleteCharacter(name, realm, account)
	end
end

function addon:GetRealms(account)
	account = account or THIS_ACCOUNT
	
	local out = {}
	local accountKey, realmKey
	for k, _ in pairs(Characters) do
		accountKey, realmKey = strsplit(".", k)
		
		if accountKey and realmKey then
			if accountKey == account then
				out[realmKey] = true
				-- allows this kind of iteration:
					-- for realmName in pairs(DS:GetRealms( account)) do
					-- end
			end
		end
	end
	return out
end

function addon:GetAccounts()
	local out = {}
	local accountKey
	for k, _ in pairs(Characters) do
		accountKey = strsplit(".", k)
		
		if accountKey then
			out[accountKey] = true
				-- allows this kind of iteration:
					-- for accountName in pairs(DS:GetAccounts()) do
					-- end
		end
	end
	return out
end

function addon:GetModules()
	return RegisteredModules
		-- for moduleName, module in pairs(DS:GetModules()) do
		-- end
end

function addon:GetCharacterTable(module, name, realm, account)
	-- module can be either the module name (string) or the module table
	-- ex: DS:GetCharacterTable("DataStore_Containers", ...) or DS:GetCharacterTable(DataStore_Containers, ...)
	if type(module) == "string" then
		module = RegisteredModules[module]
	end
	
	assert(type(module) == "table")
	return module.Characters[GetKey(name, realm, account)]
end

function addon:GetModuleLastUpdate(module, name, realm, account)
	-- module can be either the module name (string) or the module table
	-- ex: DS:GetModuleLastUpdate("DataStore_Containers", ...) or DS:GetModuleLastUpdate(DataStore_Containers, ...)
	if type(module) == "string" then
		module = RegisteredModules[module]
	end
	
	assert(type(module) == "table")
	
	local key = GetKey(name, realm, account)
	
	return module.Characters[key].lastUpdate
end

function addon:ImportData(module, data, name, realm, account)
	-- module can be either the module name (string) or the module table
	-- ex: DS:ImportData("DataStore_Containers", ...) or DS:ImportData(DataStore_Containers, ...)
	if type(module) == "string" then
		module = RegisteredModules[module]
	end
	
	assert(type(module) == "table")
	-- change this, it shoudl be a COPYTABLE instead of an assignation, otherwise, ace DB wildcards are not applied
	-- module.Characters[GetKey(name, realm, account)] = data
	CopyTable(data, module.Characters[GetKey(name, realm, account)])
	
end

function addon:ImportCharacter(key, faction, guild)
	-- after data has been imported, add a player entry to the DB, so that it becomes "visible" to the outside world.
	-- in other words, the correct sequence of operations should be something like:
	--	DataStore:ImportData(DataStore_Talents)
	--	DataStore:ImportData(DataStore_Spells)
	--	DataStore:ImportCharacter(key, faction, guild)
	
	Characters[key].faction = faction
	Characters[key].guildName = guild
end

function addon:SetOption(module, option, value)
	-- module can be either the module name (string) or the module table
	-- ex: DS:SetOption("DataStore_Containers", ...) or DS:SetOption(DataStore_Containers, ...)
	if type(module) == "string" then
		module = RegisteredModules[module]
	end
	
	if type(module) == "table" then
		if module.db.global.Options then
			module.db.global.Options[option] = value
		end
	end
end

function addon:GetOption(module, option)
	-- module can be either the module name (string) or the module table
	-- ex: DS:GetOption("DataStore_Containers", ...) or DS:GetOption(DataStore_Containers, ...)
	if type(module) == "string" then
		module = RegisteredModules[module]
	end
	
	if type(module) == "table" then
		if module.db.global.Options then
			return module.db.global.Options[option]
		end
	end
end

-- *** Guild stuff ***
function addon:GetGuildMemberInfo(member)
	-- returns the same info as the genuine GetGuildRosterInfo(), but it can be called by character name instead of by index.
	local index = guildMembersIndexes[member]
	if index then
		-- name, rank, rankIndex, level, class, zone, note, officernote, online, status, englishClass = GetGuildRosterInfo(index)
		return GetGuildRosterInfo(index)
	end
end

function addon:GetGuildMemberAlts(member)
	local index = onlineMembersAlts[member]
	if index then
		return onlineMembersAlts[member]
	end
end

function addon:GetOnlineGuildMembers()
	return onlineMembers
end

function addon:IsGuildMemberOnline(member)
	if member == UnitName("player") then		-- if self, always return true, may happen if login broadcast hasn't come back yet
		return true
	end
	return onlineMembers[member]
end

function addon:GetNameOfMain(player)
	-- returns the name of the guild mate to whom an alt belongs
	
	-- ex, player x has alts a, b, c	
	if onlineMembers[player] then			-- if x is passed ..it's the main
		return player							-- return it
	end
	
	for member, alts in pairs(onlineMembersAlts) do		--if b is passed, browse all online players who sent their alts
		for _, alt in pairs( { strsplit("|", alts) }) do	-- browse the list of alts
			if alt == player then								-- alt found ?
				return member										-- return the name of his main (currently connected)
			end
		end	
	end
end
