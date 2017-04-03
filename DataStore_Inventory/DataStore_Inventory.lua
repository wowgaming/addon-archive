--[[	*** DataStore_Inventory ***
Written by : Thaoky, EU-Marécages de Zangar
July 13th, 2009
--]]
if not DataStore then return end

local addonName = "DataStore_Inventory"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0")

local addon = _G[addonName]

local THIS_ACCOUNT = "Default"
local commPrefix = "DS_Inv"		-- let's keep it a bit shorter than the addon name, this goes on a comm channel, a byte is a byte ffs :p
local L = LibStub("AceLocale-3.0"):GetLocale("DataStore_Inventory")

-- Message types
local MSG_SEND_AIL								= 1	-- Send AIL at login
local MSG_AIL_REPLY								= 2	-- reply
local MSG_EQUIPMENT_REQUEST					= 3	-- request equipment ..
local MSG_EQUIPMENT_TRANSFER					= 4	-- .. and send the data

local AddonDB_Defaults = {
	global = {
		Options = {
			AutoClearGuildInventory = 0,		-- Automatically clear guild members' inventory at login
			BroadcastAiL = 1,						-- Broadcast professions at login or not
			EquipmentRequestNotification = 0,	-- Get a warning when someone requests my equipment
		},
		Guilds = {
			['*'] = {			-- ["Account.Realm.Name"] 
				Members = {
					['*'] = {				-- ["MemberName"] 
						lastUpdate = nil,
						averageItemLvl = 0,
						Inventory = {},		-- 19 inventory slots, a simple table containing item id's or full item string if enchanted
					}
				}
			},
		},
		Characters = {
			['*'] = {				-- ["Account.Realm.Name"] 
				lastUpdate = nil,
				averageItemLvl = 0,
				Inventory = {},		-- 19 inventory slots, a simple table containing item id's or full item string if enchanted
			}
		}
	}
}

-- *** Utility functions ***
local function GetOption(option)
	return addon.db.global.Options[option]
end

local function IsEnchanted(link)
	if not link then return end
	
	if not string.find(link, "0:0:0:0:0:0:0") then
		-- enchants/jewels store values instead of zeroes in the link, if this string can't be found, there's at least one enchant/jewel
		return true
	end
end

local function GetThisGuild()
	local guild = GetGuildInfo("player")
	if guild then 
		local key = format("%s.%s.%s", THIS_ACCOUNT, GetRealmName(), guild)
		return addon.db.global.Guilds[key]
	end
end

local function GetMemberKey(guild, member)
	-- returns the appropriate key to address a guild member. 
	--	Either it's a known alt ==> point to the characters table
	--	Or it's a guild member ==> point to the guild table
	local main = DataStore:GetNameOfMain(member)
	if main and main == UnitName("player") then
		local key = format("%s.%s.%s", THIS_ACCOUNT, GetRealmName(), member)
		return addon.db.global.Characters[key]
	end
	return guild.Members[member]
end

local function GetAIL(alts)
	-- alts = list of alts in the same guild, same realm, same account, pipe-delimited : "alt1|alt2|alt3..."
	--	usually provided by the main datastore module, but can also be built manually
	local out = {}
	
	local character = DataStore:GetCharacter()	-- this character
	local ail = DataStore:GetAverageItemLevel(character)
	table.insert(out, format("%s:%d", UnitName("player"), ail))

	if strlen(alts) > 0 then
		for _, name in pairs( { strsplit("|", alts) }) do	-- then all his alts
			character = DataStore:GetCharacter(name)
			if character then
				ail = DataStore:GetAverageItemLevel(character)
				if ail then
					table.insert(out, format("%s:%d", name, ail))
				end
			end
		end
	end
	return table.concat(out, "|")
end

local function SaveAIL(sender, ailList)
	local thisGuild = GetThisGuild()
	if not thisGuild then return end
	
	for _, ailChar in pairs( { strsplit("|", ailList) }) do	-- "char:ail | char:ail | ..."
		local name, ail = strsplit(":", ailChar)
		if name and ail then
			thisGuild.Members[name].averageItemLvl = tonumber(ail)
		end
	end
end

local function GuildBroadcast(messageType, ...)
	local serializedData = addon:Serialize(messageType, ...)
	addon:SendCommMessage(commPrefix, serializedData, "GUILD")
end

local function GuildWhisper(player, messageType, ...)
	if DataStore:IsGuildMemberOnline(player) then
		local serializedData = addon:Serialize(messageType, ...)
		addon:SendCommMessage(commPrefix, serializedData, "WHISPER", player)
	end
end

local function ClearGuildInventories()
	local thisGuild = GetThisGuild()
	if thisGuild then
		wipe(thisGuild.Members)
	end
end

-- *** Scanning functions ***
local NUM_EQUIPMENT_SLOTS = 19

function ScanInventory()
	local totalItemLevel = 0
	local itemCount = 0	
	
	local inventory = addon.ThisCharacter.Inventory
	wipe(inventory)
	
	for i = 1, NUM_EQUIPMENT_SLOTS do
		local link = GetInventoryItemLink("player", i)
		if link then 
			if IsEnchanted(link) then		-- if there's an enchant, save the full link
				inventory[i] = link
			else 									-- .. otherwise, only save the id
				inventory[i] = tonumber(link:match("item:(%d+)"))
			end		
			
			if (i ~= 4) and (i ~= 19) then		-- InventorySlotId 4 = shirt, 19 = tabard, skip them
				itemCount = itemCount + 1
				totalItemLevel = totalItemLevel + tonumber(((select(4, GetItemInfo(link))) or 0))
			end
		end
	end
	
	addon.ThisCharacter.averageItemLvl = totalItemLevel / itemCount
	addon.ThisCharacter.lastUpdate = time()
end

-- *** Event Handlers ***
local function OnPlayerAlive()
	ScanInventory()
end

local function OnUnitInventoryChanged()
	ScanInventory()
end

-- ** Mixins **
local function _GetInventory(character)
	return character.Inventory
end

local function _GetInventoryItem(character, slotID)
	return character.Inventory[slotID]
end

local function _GetInventoryItemCount(character, searchedID)
	local count = 0
	for _, item in pairs(character.Inventory) do
		if type(item) == "number" then		-- saved as a number ? this is the itemID
			if (item == searchedID) then
				count = count + 1
			end
		elseif tonumber(item:match("item:(%d+)")) == searchedID then		-- otherwise it's the item link
			count = count + 1
		end
	end
	return count
end
	
local function _GetAverageItemLevel(character)
	return character.averageItemLvl
end

local sentRequests		-- recently sent requests

local function _RequestGuildMemberEquipment(member)
	-- requests the equipment of a given character (alt or main)
	local player = UnitName("player")
	local main = DataStore:GetNameOfMain(member)
	if not main then 		-- player is offline, check if his equipment is in the DB
		local thisGuild = GetThisGuild()
		if thisGuild and thisGuild.Members[member] then		-- player found
			if thisGuild.Members[member].Inventory then		-- equipment found
				addon:SendMessage("DATASTORE_PLAYER_EQUIPMENT_RECEIVED", player, member)
				return
			end
		end
	end
	
	if main == player then	-- if player requests the equipment of one of own alts, process the request locally, using the network works fine, but let's save the traffic.
		-- trigger the same event, _GetGuildMemberInventoryItem will take care of picking the data in the right place
		addon:SendMessage("DATASTORE_PLAYER_EQUIPMENT_RECEIVED", player, member)
		return
	end
	
	-- prevent spamming remote players with too many requests
	sentRequests = sentRequests or {}
	
	if sentRequests[main] and ((time() - sentRequests[main]) < 5) then		-- if there's a known timestamp , and it was sent less than 5 seconds ago .. exit
		return
	end
	
	sentRequests[main] = time()		-- timestamp of the last request sent to this player
	GuildWhisper(main, MSG_EQUIPMENT_REQUEST, member)
end

local function _GetGuildMemberInventoryItem(guild, member, slotID)
	local character = GetMemberKey(guild, member)
	
	if character then
		return character.Inventory[slotID]
	end
end

local function _GetGuildMemberAverageItemLevel(guild, member)
	local character = GetMemberKey(guild, member)

	if character then
		return character.averageItemLvl
	end
end

local PublicMethods = {
	GetInventory = _GetInventory,
	GetInventoryItem = _GetInventoryItem,
	GetInventoryItemCount = _GetInventoryItemCount,
	GetAverageItemLevel = _GetAverageItemLevel,
	RequestGuildMemberEquipment = _RequestGuildMemberEquipment,
	GetGuildMemberInventoryItem = _GetGuildMemberInventoryItem,
	GetGuildMemberAverageItemLevel = _GetGuildMemberAverageItemLevel,
}

-- *** Guild Comm ***
local function OnGuildAltsReceived(self, sender, alts)
	if sender == UnitName("player") and GetOption("BroadcastAiL") == 1 then				-- if I receive my own list of alts in the same guild, same realm, same account..
		GuildBroadcast(MSG_SEND_AIL, GetAIL(alts))	-- ..then broacast AIL
	end
end

local GuildCommCallbacks = {
	[MSG_SEND_AIL] = function(sender, ail)
			local player = UnitName("player")
			if sender ~= player then						-- don't send back to self
				local alts = DataStore:GetGuildMemberAlts(player)			-- get my own alts
				if alts and GetOption("BroadcastAiL") == 1 then
					GuildWhisper(sender, MSG_AIL_REPLY, GetAIL(alts))		-- .. and send them back
				end
			end
			SaveAIL(sender, ail)
		end,
	[MSG_AIL_REPLY] = function(sender, ail)
			SaveAIL(sender, ail)
		end,
	[MSG_EQUIPMENT_REQUEST] = function(sender, character)
			if GetOption("EquipmentRequestNotification") == 1 then
				addon:Print(format(L["%s is inspecting %s"], sender, character))
			end
	
			local key = DataStore:GetCharacter(character)	-- this realm, this account
			if key then
				GuildWhisper(sender, MSG_EQUIPMENT_TRANSFER, character, DataStore:GetInventory(key))
			end
		end,
	[MSG_EQUIPMENT_TRANSFER] = function(sender, character, equipment)
			local thisGuild = GetThisGuild()
			if thisGuild then
				thisGuild.Members[character].Inventory = equipment
				thisGuild.Members[character].lastUpdate = time()
				addon:SendMessage("DATASTORE_PLAYER_EQUIPMENT_RECEIVED", sender, character)
			end
		end,
}

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)

	DataStore:RegisterModule(addonName, addon, PublicMethods)
	DataStore:SetGuildCommCallbacks(commPrefix, GuildCommCallbacks)
	
	DataStore:SetCharacterBasedMethod("GetInventory")
	DataStore:SetCharacterBasedMethod("GetInventoryItem")
	DataStore:SetCharacterBasedMethod("GetInventoryItemCount")
	DataStore:SetCharacterBasedMethod("GetAverageItemLevel")
	DataStore:SetGuildBasedMethod("GetGuildMemberInventoryItem")
	DataStore:SetGuildBasedMethod("GetGuildMemberAverageItemLevel")
	
	addon:RegisterMessage("DATASTORE_GUILD_ALTS_RECEIVED", OnGuildAltsReceived)
	addon:RegisterComm(commPrefix, DataStore:GetGuildCommHandler())
end

function addon:OnEnable()
	addon:RegisterEvent("PLAYER_ALIVE", OnPlayerAlive)
	addon:RegisterEvent("UNIT_INVENTORY_CHANGED", OnUnitInventoryChanged)
	addon:SetupOptions()
	
	if GetOption("AutoClearGuildInventory") == 1 then
		ClearGuildInventories()
	end
end

function addon:OnDisable()
	addon:UnregisterEvent("PLAYER_ALIVE")
	addon:UnregisterEvent("UNIT_INVENTORY_CHANGED")
end


local PT = LibStub("LibPeriodicTable-3.1")
local BZ = LibStub("LibBabble-Zone-3.0"):GetUnstrictLookupTable()
local BB = LibStub("LibBabble-Boss-3.0"):GetUnstrictLookupTable()

local DataSources = {
	"InstanceLoot",
	"InstanceLootHeroic",
	"CurrencyItems",
}

-- stays out of public methods for now
function addon:GetSource(searchedID)
	local info, source
	for _, v in pairs(DataSources) do
		info, source = PT:ItemInSet(searchedID, v)
		if source then
			local _, instance, boss = strsplit(".", source)		-- ex: "InstanceLoot.Gnomeregan.Techbot"
			
			instance = BZ[instance] or instance
			if v == "InstanceLootHeroic" then
				instance = format("%s (%s)", instance, L["Heroic"])
			elseif v == "CurrencyItems" then
				-- for currency items, there will be no "boss" value, let's return the quantity instead
				boss = info.."x"
			end
			
			if boss == "Trash Mobs" then 
				boss = L["Trash Mobs"]
			else
				boss = BB[boss] or boss
			end
			
			return instance, boss
		end
	end
end
