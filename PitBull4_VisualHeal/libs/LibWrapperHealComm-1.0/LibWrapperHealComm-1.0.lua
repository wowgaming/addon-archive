local major = "LibWrapperHealComm-1.0"
local minor = 8
assert(LibStub, string.format("%s requires LibStub.", major))

local CommWrapper = LibStub:NewLibrary(major, minor)
if( not CommWrapper ) then return end

local HealComm40 = LibStub:GetLibrary("LibHealComm-4.0", true)
assert(HealComm40, string.format("%s-%d requires LibHealComm-4.0 to run.", major, minor))

local playerName = UnitName("player")
local playerGUID, distribution

CommWrapper.blacklisted = CommWrapper.blacklisted or {}
CommWrapper.alreadySaw = CommWrapper.alreadySaw or {}
CommWrapper.lastCast = CommWrapper.lastCast or {}

-- Not 100% since it doesn't do specific rank conversion, but good enough. Map of LHC-3.0 supported heals -> their ID
CommWrapper.spellNameToID = CommWrapper.spellNameToID or {
	[GetSpellInfo(5185)] = 5185,
	[GetSpellInfo(8936)] = 8936,
	[GetSpellInfo(50464)] = 50464,
	[GetSpellInfo(635)] = 635,
	[GetSpellInfo(19750)] = 19750,
	[GetSpellInfo(596)] = 596,
	[GetSpellInfo(32546)] = 32546,
	[GetSpellInfo(2061)] = 2061,
	[GetSpellInfo(2060)] = 2060,
	[GetSpellInfo(2054)] = 2054,
	[GetSpellInfo(2050)] = 2050,
	[GetSpellInfo(1064)] = 1064,
	[GetSpellInfo(331)] = 331,
	[GetSpellInfo(8004)] = 8004,
}

-- Only public API there is for this, nice and easy
function CommWrapper:DisableSendingData(flag)
	self.disableSending30 = flag
	self:Update()
end

local function sendMessage(msg)
	if( distribution ) then
		SendAddonMessage("HealComm", msg, distribution)
	end
end

-- If the player has HC3.0 then any sending options are automatically overriden, easier to let LHC-3.0 rather than trying to disable LHC-3.0
function CommWrapper:ADDON_LOADED(addon)
	if( not self.playerHasHC and LibStub:GetLibrary("LibHealComm-3.0", true) ) then
		self.playerHasHC = true
		self.frame:UnregisterEvent("ADDON_LOADED")
		self:Update()
	end
end

-- Handles registering and unregistering the callbacks to support sending heals in LHC-3.0 format
function CommWrapper:Update()
	playerGUID = UnitGUID("player")
	HealComm40.UnregisterAllCallbacks(CommWrapper)
	
	if( not self.disableSending30 and not self.playerHasHC and self.groupHasHC30 ) then
		HealComm40.RegisterCallback(CommWrapper, "HealComm_HealStarted")
		HealComm40.RegisterCallback(CommWrapper, "HealComm_HealStopped")
	end
end

-- Send heals to HC
local function getName(unit)
	if( not unit ) then return nil end
	
	local name, server = UnitName(unit)
	if( distribution == "BATTLEGROUND" and server and server ~= "" ) then
		return string.format("%s-%s", name, server)
	end

	return name
end

local PrayerofHealing = GetSpellInfo(596)
local BindingHeal = GetSpellInfo(32546)
function CommWrapper:HealComm_HealStarted(event, casterGUID, spellID, healType, endTime, ...)
	if( healType ~= HealComm40.DIRECT_HEALS or casterGUID ~= playerGUID ) then return end
	
	local spellName = GetSpellInfo(spellID)
	if( spellName == PrayerofHealing ) then
		local targetList
		for i=1, select("#", ...) do
			local unit = HealComm40.guidToUnit[select(i, ...)]
			if( unit ) then
				if( targetList ) then
					targetList = targetList .. ":" .. getName(unit)
				else
					targetList = getName(unit)
				end
			end
		end
				
		-- Grab the first heal amount it finds
		local healAmount = HealComm40.pendingHeals[casterGUID][spellName][2]
		if( targetList and healAmount ) then
			sendMessage(string.format("003%05d%s", healAmount, targetList))
		end
	elseif( spellName == BindingHeal ) then
		-- Grab the first heal amount it finds
		local healAmount = HealComm40.pendingHeals[casterGUID][spellName][2]
		local target = getName(HealComm40.guidToUnit[select(1, ...)])
		
		if( healAmount and target ) then
			sendMessage(string.format("002%05d%s", healAmount, target))
		end
	else
		-- Grab the first heal amount it finds
		local healAmount = HealComm40.pendingHeals[casterGUID][spellName][2]
		local target = getName(HealComm40.guidToUnit[select(1, ...)])
		
		if( healAmount and target ) then
			sendMessage(string.format("000%05d%s", healAmount, target))
		end
	end
end

function CommWrapper:HealComm_HealStopped(event, casterGUID, spellID, healType, endTime, ...)
	if( healType ~= HealComm40.DIRECT_HEALS or casterGUID ~= playerGUID ) then return end
	sendMessage("001S")
end

-- When we leave a group need to deactive HC support regardless
local function updateDistribution()
	local instanceType = select(2, IsInInstance())
	
	if( instanceType == "pvp" or instanceType == "arena" ) then
		distribution = "BATTLEGROUND"
	elseif( GetNumRaidMembers() > 0 ) then
		distribution = "RAID"
	elseif( GetNumPartyMembers() > 0 ) then
		distribution = "PARTY"
	else
		distribution = nil
	end
end

local isGrouped
function CommWrapper:PARTY_MEMBERS_CHANGED()
	if( GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0 ) then
		self.groupHasHC30 = nil
		self:Update()
		
		isGrouped = nil
		
		-- Release to GC
		self.lastCast = {}
		self.alreadySaw = {}

		updateDistribution()
	-- Need to get the initial versions from players so we know if the compatibility is necsesary
	elseif( not self.playerHasSC and not isGrouped and ( GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0 ) ) then
		updateDistribution()
		isGrouped = true

		sendMessage("999888888")
	end
end

CommWrapper.RAID_ROSTER_UPDATE = CommWrapper.PARTY_MEMBERS_CHANGED

-- Yoinked from LHC-3
local function extractRealm(fullName)
	return select(2, string.split('-', fullName, 2))
end

-- Convert a remotely generated fully qualified name to a local fully qualified name.
local playerRealm = GetRealmName()

local function convertRealm(fullName, remoteRealm)
	if( not remoteRealm ) then return fullName end

	local name, realm = string.split('-', fullName, 2)
	if( not realm ) then
		-- Apply remote realm if there is no realm on the target
		return fullName.."-"..remoteRealm
	elseif(realm == playerRealm) then
		-- Strip realm if it is equal to the local realm
		return name
	end
	
	-- Sender and target realms are both different from local realm
	return fullName
end

local function loadPlayers(sender, ...)
	local players
	local senderRealm = extractRealm(sender)
	for i=1, select("#", ...) do
		local guid = UnitGUID(convertRealm(select(i, ...), senderRealm))
		if( guid ) then
			if( players ) then
				players = players .. "," .. HealComm40.compressGUID[guid]
			else
				players = HealComm40.compressGUID[guid]
			end
		end
	end
	
	return players
end

-- Handle parsing all the fun stuff
function CommWrapper:CHAT_MSG_ADDON(prefix, message, channel, sender)
	if( sender == playerName ) then return end
	
	-- Alright, we got HealComm data let us do fun parsing stuff
	if( prefix == "HealComm" and not self.blacklisted[sender] and message ~= "999888888" ) then
		local commType = tonumber(string.sub(message, 1, 3))

		-- Got a HC-3.0 message so we know someone is using it
		if( not self.groupHasHC30 ) then
			self.groupHasHC30 = true
			self:Update()
		end
		
		-- This will ignore the absolute first heal message by someone per session, this isn't a perfect solution
		-- but it's meant to reduce any bugouts by someone using LHC-4.0 and LHC-3.0 together 
		if( commType <= 3 ) then
			if( not self.alreadySaw[sender] ) then
				self.alreadySaw[sender] = true
				return
			end
		end
				
		local casterGUID = UnitGUID(sender)
		if( not casterGUID ) then return end

		-- Heal start
		if( commType == 0 ) then
			local heal = tonumber(string.sub(message, 4, 8))
			local target = string.sub(message, 9, -1)
			local spellName = UnitCastingInfo(sender)
			local guid = UnitGUID(convertRealm(target, extractRealm(sender)))
			
			if( heal and target and guid and spellName ) then
				self.lastCast[casterGUID] = spellName
				
				--table.insert(TestLog, {"Heal started", message, casterGUID, spellName, heal, target, guid, HealComm40.compressGUID[guid]})
				HealComm40.parseDirectHeal(casterGUID, CommWrapper.spellNameToID[spellName] or 0, heal, HealComm40.compressGUID[guid])
			end
			
		-- Multi target heal started
		elseif( commType == 2 or commType == 3 ) then
			local heal = tonumber(string.sub(message, 4, 8))
			local targets = string.sub(message, 9, -1)
			local spellName = UnitCastingInfo(sender)

			if( heal and targets and spellName ) then
				local players = loadPlayers(sender, string.split(":", targets))
				if( not players ) then return end

				self.lastCast[casterGUID] = spellName

				--table.insert(TestLog, {"Heal started", message, casterGUID, spellName, heal, targets, players})
				HealComm40.parseDirectHeal(casterGUID, self.spellNameToID[spellName] or 0, heal, players)
			end
		-- Heal stopped
		elseif( commType == 1 and self.lastCast[casterGUID] ) then
			--table.insert(TestLog, {"Heal stopped", message, casterGUID, self.lastCast[casterGUID]})
			HealComm40.parseHealEnd(casterGUID, nil, "name", self.spellNameToID[self.lastCast[casterGUID]] or 0, string.sub(message, 4, 4) ~= "S")
		end
		
	-- If we see any message from LHC-4.0, automatically blacklist that user and ignore any data they sent from HC
	elseif( prefix == "LHC40" ) then
		self.blacklisted[sender] = true
	end
end

local function OnEvent(self, event, ...)
	CommWrapper[event](CommWrapper, ...)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("RAID_ROSTER_UPDATE")
frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:SetScript("OnEvent", OnEvent)

CommWrapper.frame = frame
