-- A quick replacement for what RosterLib-2.1 used to do for us.

local revision = tonumber(string.sub("$Revision: 1123 $", 12, -3))
local Recount = _G.Recount
if Recount.Version < revision then Recount.Version = revision end

local GetNumRaidMembers = GetNumRaidMembers
local GetNumPartyMembers = GetNumPartyMembers
local UnitAffectingCombat = UnitAffectingCombat
local UnitExists = UnitExists
local UnitName = UnitName
local UnitGUID = UnitGUID

function Recount:CheckPartyCombatWithPets()

	if GetNumRaidMembers() > 0 then
		for i = 1, GetNumRaidMembers() , 1 do -- GetNumRaidMembers() per arrowmaster, raid40 can be set even if there are fewer than 40 people in raid. <- Tested this and this is incorrect.
			if UnitAffectingCombat("raid"..i) then
				return true
			end
			if UnitAffectingCombat("raidpet"..i) then
				return true
			end
		end
	end
	
	for i = 1, GetNumPartyMembers(), 1 do -- If arrow is correct this is not the case and we are good to use GetNumPartyMembers()

		if UnitAffectingCombat("party"..i) then
			return true
		end
		if UnitAffectingCombat("partypet"..i) then
			return true
		end
	end
	
	if UnitAffectingCombat("player") then
		return true
	end

	return false
end

function Recount:GetUnitIDFromName(name)

	local realm = name:match("-(.-)")
	if realm then
--		Recount:DPrint("Found cross-realm: " ..name .. " on realm ".. name:match("-(.-)"))
		name = name:match("(.-)-") -- strip the realm part for this function
	end
	if UnitExists(name) then -- Elsia: Speed boost, yay.
		--Recount:Print(name)
		return name
	else
		--Recount:Print(name:lower():sub(1,3))
		local lname = name:lower()
		--Recount:Print(lname)
		if lname:sub(1,3)=="pet" or lname:sub(1,4)=="raid" or lname:sub(1,5)=="party" or lname:sub(1,6)=="player" or lname:sub(1,6)=="target" then
			return Recount:GetPetPrefixUnit(name, realm)
		end
		return nil
	end
end

-- This is a bandaid for Blizz' playername pet* bug for unitids.

function Recount:GetPetPrefixUnit(name, realm)

	if Recount.PlayerName==name and not realm then
		return "player"
	end

	if GetNumRaidMembers() > 0 then
		for i = 1, GetNumRaidMembers(), 1 do -- GetNumRaidMembers() per arrowmaster, raid40 can be set even if there are fewer than 40 people in raid.
			local unitname, unitrealm = UnitName("raid"..i)
			if unitname == name and unitrealm == realm then
				return "raid"..i
			end
		end
	elseif GetNumPartyMembers() > 0 then
		for i = 1, GetNumPartyMembers(), 1 do -- GetNumRaidMembers() per arrowmaster, raid40 can be set even if there are fewer than 40 people in raid.
			local unitname, unitrealm = UnitName("party"..i)
			if unitname == name and unitrealm == realm then
				return "party"..i
			end
		end
	end
	return nil
end

function Recount:FindTargetedUnit(name)
	--Let take the early out here (not everywhere that was using this function called the other function and it should be combined)
	if UnitExists(name) then
		return name
	end

	for i = 1, GetNumRaidMembers(), 1 do -- GetNumRaidMembers()
		if UnitName("raid"..i) ~= nil and name==UnitName("raid"..i.."target") then
			return "raid"..i.."target"
		elseif UnitName("raidpet"..i.."target") ~= nil and name==UnitName("raidpet"..i.."target") then
			return "raidpet"..i.."target"
		end
	end
	for i = 1, GetNumPartyMembers(), 1 do -- If arrow is correct this is not the case and we are good to use GetNumPartyMembers()
		if UnitName("party"..i) ~= nil and name==UnitName("party"..i.."target") then
			return "party"..i.."target"
		elseif UnitName("partypet"..i) ~= nil and name==UnitName("partypet"..i.."target") then
			return "partypet"..i.."target"
		end
	end
	
	if name==UnitName("playertarget") then
		return "playertarget"
	elseif name==UnitName("focus") then
		return "focus"
	end
end

function Recount:FindOwnerPetFromGUID(petName,petGUID)
	local ownerName
	local ownerGUID
	local ownerRealm

	for i = 1, GetNumRaidMembers(), 1 do 
		if petGUID == UnitGUID("raidpet"..i) then
			ownerName, ownerRealm = UnitName("raid"..i)
			if ownerRealm then
				ownerName = ownerName .. "-" .. ownerRealm
			end
			ownerGUID = UnitGUID("raid"..i)
			return ownerName, ownerGUID
		end
	end
	for i = 1, GetNumPartyMembers(), 1 do 
		if petGUID == UnitGUID("partypet"..i) then
			ownerName, ownerRealm = UnitName("party"..i)
			if ownerRealm then
				ownerName = ownerName .. "-" .. ownerRealm
			end
			ownerGUID = UnitGUID("party"..i)
			return ownerName, ownerGUID
		end
	end

	if petGUID==UnitGUID("pet") then
			ownerName = UnitName("player")
			ownerGUID = UnitGUID("player")
		return ownerName, ownerGUID
	end
	
	return nil, nil
end
