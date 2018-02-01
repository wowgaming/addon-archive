local LBCT = LibStub("LibBabble-CreatureType-3.0"):GetLookupTable()

local runeType = 
{
	blood = 1,
	unholy = 2,
	frost = 3,
	death = 4
}	

local totemType =
{
	fire = 1,
	earth = 2,
	water = 3,
	air = 4
}

local fearSpellIdList = 
{
	5782, -- Fear
	5484, -- Howl of terror
	5246, -- Intimidating Shout 
	8122, -- Psychic scream
}
local fearSpellList = nil

local stunSpellIdList =
{
	5211, -- Bash
	44415, -- Blackout
	6409, -- Cheap Shot
	22427, -- Concussion Blow
	853, -- Hammer of Justice
	408, -- Kidney Shot
	12798, -- Revenge Stun
	46968, -- Shockwave
}
local stunSpellList = nil

local incapacitateSpellIdList =
{
	6770, -- Sap
	12540, -- Gouge
	20066, -- Repentance
}
local incapacitateSpellList = nil

local rootSpellIdList =
{
	23694, -- Improved Hamstring
	339, -- Entangling Roots
	122, -- Frost Nova
	47168, -- Improved Wing Clip
}
local rootSpellList = nil

local function buildRootSpellList()
	if (rootSpellList) then
		return
	end
	rootSpellList = {}
	for k, v in pairs(rootSpellIdList) do
		rootSpellList[Ovale:GetSpellInfoOrNil(v)] = true
	end
end

local function buildStunSpellList()
	if (stunSpellList) then
		return
	end
	stunSpellList = {}
	for k, v in pairs(stunSpellIdList) do
		stunListList[Ovale:GetSpellInfoOrNil(v)] = true
	end
end

local function buildIncapacitateSpellList()
	if (incapacitateSpellList) then
		return
	end
	incapacitateSpellList = {}
	for k, v in pairs(incapacitateSpellIdList) do
		incapacitateSpellList[Ovale:GetSpellInfoOrNil(v)] = true
	end
end

local function buildFearSpellList()
	if (fearSpellList) then
		return
	end
	fearSpellList = {}
	for k, v in pairs(fearSpellIdList) do
		fearSpellList[Ovale:GetSpellInfoOrNil(v)] = true
	end
end

local function isDebuffInList(list)
	local i=1;
	while (true) do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable =  UnitDebuff("player", i);
		if (not name) then
			break
		end
		if (list[name]) then
			return true
		end
		i = i +1
	end
	return false
end

local function avecHate(temps, hate)
	if not temps then
		temps = 0
	end
	if (not hate) then
		return temps
	elseif (hate == "spell") then
		return temps/(1+Ovale.spellHaste/100)
	elseif (hate == "melee") then
		return temps/(1+Ovale.meleeHaste/100)
	else
		return temps
	end
end

local function compare(a, comparison, b)
	if (comparison == "more") then
		if (not b or (a~=nil and a>b)) then
			return 0
		else
			return nil
		end
	else 
		if (not a or (b~=nil and a<b)) then
			return 0
		else
			return nil
		end
	end
end

local function testbool(a, condition)
	if (condition == "yes" or not condition) then
		if (a) then
			return 0
		else
			return nil
		end
	else
		if (not a) then
			return 0
		else
			return nil
		end
	end
end

local function getTarget(condition)
	if (not condition) then
		return "target"
	else
		return condition
	end
end

local function addTime(time1, duration)
	if not time1 then
		return nil
	else
		return time1 + duration
	end
end

local function addOrSubTime(time1, operator, duration)
	if operator == "more" then
		return addTime(time1, -duration)
	else
		return addTime(time1, duration)
	end
end

local function nilstring(text)
	if text == nil then
		return "nil"
	else
		return text
	end
end

local lastEnergyValue = nil
local lastEnergyTime

local function GetManaTime(mana, withBerserker)
	local _,className = UnitClass("player")
	if (className == "ROGUE" or (className == "DRUID" and GetShapeshiftForm(true) == 3)) then
		local current = Ovale.state.mana
		if current~=lastEnergyValue then
			lastEnergyValue = current
			lastEnergyTime = Ovale.currentTime
		end
		local rate= 10
		if (className == "ROGUE") then
			local rush = Ovale:GetSpellInfoOrNil(13750)
			if UnitBuff("player", rush) then
				rate = rate * 2
			end
		elseif withBerserker then
			local berserk = Ovale:GetSpellInfoOrNil(50334)
			if UnitBuff("player", berserk) then
				mana = mana/2
			end
		end
		local limit = math.ceil((mana - lastEnergyValue) / rate + lastEnergyTime)
		return limit
	else
		if Ovale.state.mana>=mana then
			return Ovale.currentTime-1
		else
			return nil
		end
	end
end


-- Recherche un aura sur la cible et récupère sa durée et le nombre de stacks
-- return start, ending, stacks
local function GetTargetAura(condition, filter, target)
	if (not target) then
		target=condition.target
		if (not target) then
			target="target"
		end
	end
	local stacks = condition.stacks
	if not stacks then
		stacks = 1
	end
	local spellId = condition[1]
	local aura = Ovale:GetAura(target, filter, spellId)
	if Ovale.trace then
		Ovale:Print("GetTargetAura = start = ".. nilstring(aura.start) .. " end = "..nilstring(aura.ending).." stacks = " ..nilstring(aura.stacks).."/"..stacks)
	end
	
	if (not condition.mine or aura.mine) and aura.stacks>=stacks then
		local ending
		if condition.forceduration then
			if Ovale.spellInfo[name] and Ovale.spellInfo[name].duration then
				ending = aura.start + Ovale.spellInfo[name].duration
			else
				ending = aura.start + condition.forceduration
			end
		else
			ending = aura.ending
		end
		return aura.start, ending
	else
		return 0,0
	end
end

--[[	local auraName, auraRank, auraIcon = Ovale:GetSpellInfoOrNil(spellId)
	local i=1;
	local startTime = nil
	local endTime = nil
	local stacksLeft = nil
	while (true) do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable =  UnitAura(target, i, filter);
		if (not name) then
			break
		end
		if (not condition.mine or unitCaster=="player") then
			if (name == auraName and icon == auraIcon) then
				startTime = expirationTime - duration
				endTime = expirationTime - Ovale.maintenant
				stacksLeft = count
				break
			end
		end
		i = i + 1;
	end
	
	if spellId then
		for k=1,Ovale.spellStack.length do
			local newSpell = Ovale.spellStack[k]
			if (newSpell.info and newSpell.info[target] and newSpell.info[target][filter] and newSpell.info[target][filter][spellId]) then
				local duration = newSpell.info[target][filter][spellId]
				if duration>0 then
					if (not endTime or endTime < newSpell.attenteFinCast) then
						stacksLeft = 1
					else
						stacksLeft = stacksLeft + 1
					end
					endTime = duration + newSpell.attenteFinCast
				else
					endTime = nil
				end
			end
		end
	end
	return endTime, stacksLeft
end]]

local lastSaved
local savedHealth
local targetGUID
local lastSPD=0.0001

local function getTargetDead()
	local second = math.floor(Ovale.maintenant)
	if targetGUID~=UnitGUID("target") then
		lastSaved = nil
		targetGUID = UnitGUID("target")
		savedHealth = {}
	end
	local newHealth = UnitHealth("target")
	if UnitHealthMax("target")==1 then
		return Ovale.maintenant + 10000
	end
	if second~=lastSaved and targetGUID then
		lastSaved = second
		local mod10 = second % 10
		local prevHealth = savedHealth[mod10]
		savedHealth[mod10] = newHealth
		if prevHealth and prevHealth>newHealth then
			lastSPD = 10/(prevHealth-newHealth)
--			print("dps = " .. (1/lastSPD))
		end
	end
	-- Rough estimation
	return Ovale.maintenant + newHealth * lastSPD
end

Ovale.conditions=
{
	-- Test if a white hit just occured
	-- 1 : maximum time after a white hit
	-- Not useful anymore. No widely used spell reset swing timer anyway
	--[[AfterWhiteHit = function(condition)
		local debut = OvaleSwing.starttime
		local fin = OvaleSwing.duration + debut
		local maintenant = GetTime()
		if (maintenant-debut<condition[1]) then
			return 0
		elseif (maintenant<fin-0.1) then
			return fin-maintenant
		else 
			return 0.1
		end 
	end,]]
	-- Test how many armor set parts are equiped by the player
	-- 1 : set number
	-- 2 : "more" or "less"
	-- 3 : limit 
	ArmorSetParts = function(condition)
		local nombre = 0
		if (OvaleEquipement.nombre[condition[1]]) then
			nombre = OvaleEquipement.nombre[condition[1]]
		end
		return compare(nombre, condition[2], condition[3])
	end,
	BuffDuration = function(condition)
		local name, rank, icon, count, debuffType, duration = UnitBuff("player", Ovale:GetSpellInfoOrNil(condition[1]))
		if not name then
			return nil
		end
		return compare(duration, condition[2], condition[3])
	end,
	-- Test if a buff will expire on the player after a given time
	-- 1 : buff spell id
	-- 2 : expiration time 
	BuffExpires = function(condition)
		local start, ending = GetTargetAura(condition, "HELPFUL", "player")
		local timeBefore = avecHate(condition[2], condition.haste)
		if Ovale.trace then
			Ovale:Print("timeBefore = " .. timeBefore)
			Ovale:Print("start = " .. ending)
		end
		return addTime(ending, -timeBefore)
	end,
	-- Test if a time has elapsed since the last buff gain
	-- 1 : buff spell id
	-- 2 : time since the buff gain
	BuffGain = function(condition)
		local spell, rank, icon = Ovale:GetSpellInfoOrNil(condition[1])
		if (spell) then
			if (not Ovale.buff[spell]) then
				return 0
			end
			local timeGain = Ovale.buff[spell].gain
			if (not timeGain or Ovale.buff[spell].icon~=icon) then
				timeGain = 0
			end
			
			return timeGain + condition[2]
		end
		return 0
	end,
	-- Test if a buff is active
	-- 1 : the buff spell id
	-- stacks : minimum number of stacks
	BuffPresent = function(condition)
		local start, ending = GetTargetAura(condition, "HELPFUL", "player")
		local timeBefore = avecHate(condition[2], condition.haste)
		return start, addTime(ending, -timeBefore)
	end,
	Casting = function(condition)
		local spell, rank, name, icon, start, ending = UnitCastingInfo("player")
		if (not spell) then
			return nil
		end
		if Ovale:GetSpellInfoOrNil(condition[1])==spell then
			return start/1000, ending/1000
		else
			return nil
		end
	end,
	CastTime = function(condition)
		local name, rank, icon, cost, isFunnel, powerType, castTime = Ovale:GetSpellInfoOrNil(condition[1])
		if Ovale.trace then
			Ovale:Print("castTime/1000 = " .. (castTime/1000) .. " " .. condition[2] .. " " .. condition[3])
		end
		return compare(castTime/1000, condition[2], condition[3])
	end,
	-- Test if a list of checkboxes is off
	-- 1,... : the checkboxes names
	CheckBoxOff = function(condition)
		for k,v in pairs(condition) do
			if (Ovale:IsChecked(v)) then
				return nil
			end
		end
		return 0
	end,
	-- Test if a list of checkboxes is on
	-- 1,... : the checkboxes names
	CheckBoxOn = function(condition)
		for k,v in pairs(condition) do
			if (not Ovale:IsChecked(v)) then
				return nil
			end
		end
		return 0
	end,
	-- Test how many combo points a feral druid or a rogue has
	-- 1 : "less" or "more"
	-- 2 : the limit
	ComboPoints = function(condition)
		local points = Ovale.state.combo
		return compare(points, condition[1], condition[2])
	end,
	Counter = function(condition)
		return compare(Ovale.counter[condition[1]], condition[2], condition[3])
	end,
	DebuffExpires = function(condition)
		local start, ending = GetTargetAura(condition, "HARMFUL", "player")
		local tempsMax = avecHate(condition[2], condition.haste)
		return addTime(ending, -tempsMax)
	end,
	DebuffPresent = function(condition)
		local start, ending = GetTargetAura(condition, "HARMFUL", "player")
		local timeBefore = avecHate(condition[2], condition.haste)
		return start, addTime(ending, -timeBefore)
	end,
	EffectiveMana = function(condition)
		local limit = GetManaTime(condition[2], true)
		if condition[1]=="more" then
			return limit, nil
		else
			return 0,limit
		end
	end,
	EndCastTime = function(condition)
		local name, rank, icon, cost, isFunnel, powerType, castTime = Ovale:GetSpellInfoOrNil(condition[1])
		local actionCooldownStart, actionCooldownDuration, actionEnable = Ovale:GetComputedSpellCD(name)
		local startCast = actionCooldownStart + actionCooldownDuration
		if startCast<Ovale.currentTime then
			startCast = Ovale.currentTime
		end
		return startCast + castTime/1000
	end,
	Glyph = function(condition)
		local present = false
		for i = 1, GetNumGlyphSockets() do
			local enalbled, glypType, glyphSpellID = GetGlyphSocketInfo(i)
			if (glyphSpellID == condition[1]) then
				present = true
				break
			end
		end
		return testbool(present, condition[2])
	end,
	HasFullControl = function(condition)
		return testbool(HasFullControl(), condition[1])
	end,
	HasShield = function(condition)
		local _,_,id = string.find(GetInventoryItemLink("player",GetInventorySlotInfo("SecondaryHandSlot")) or "","(item:%d+:%d+:%d+:%d+)")
		if (not id) then
			return testbool(false, condition[1])
		end
		
		local _,_,_,_,_,_,_,_,itemLoc = GetItemInfo(id)
		return testbool(itemLoc=="INVTYPE_SHIELD", condition[1])
	end,
	InCombat = function(condition)
		return testbool(Ovale.enCombat, condition[1])
	end,
	ItemCount = function(condition)
		return compare(GetItemCount(condition[1]), condition[2], condition[3])
	end,
	IsFeared = function(condition)
		buildFearSpellList()
		return testbool(not HasFullControl() and isDebuffInList(fearSpellList), condition[1])
	end,
	IsIncapacitated = function(condition)
		buildIncapacitateSpellList()
		return testbool(not HasFullControl() and isDebuffInList(incapacitateSpellList), condition[1])
	end,
	IsRooted = function(condition)
		buildRootSpellList()
		return testbool(isDebuffInList(rootSpellList), condition[1])
	end,
	IsStunned = function(condition)
		buildStunSpellList()
		return testbool(not HasFullControl() and isDebuffInList(stunSpellList), condition[1])
	end,
	-- Compare with the player level
	-- 1 : "less" or "more"
	-- 2 : the limit
	Level = function(condition)
		return compare(UnitLevel("player"), condition[1], condition[2])
	end,
	-- Test if the player life is bellow/above a given value in percent
	-- 1 : "less" or "more"
	-- 2 : the limit, in percent
	LifePercent = function(condition)
		return compare(UnitHealth("player")/UnitHealthMax("player"), condition[1], condition[2]/100)
	end,
	-- Test if a list item is selected
	-- 1 : the list name
	-- 2 : the item name
	List = function(condition)
		if (condition[1]) then
			if (Ovale:GetListValue(condition[1]) == condition[2]) then
				return 0
			end
		end
		return nil
	end,
	-- Test if the player mana is above/bellow a given value
	-- 1 : "less" or "more"
	-- 2 : the mana/energy/rage... limit
	Mana = function(condition)
		local limit = GetManaTime(condition[2], false)
		if condition[1]=="more" then
			return limit, nil
		else
			return 0,limit
		end
	end,
	ManaPercent = function(condition)
		return compare(UnitPower("player")/UnitPowerMax("player"), condition[1], condition[2]/100)
	end,
	OtherDebuffExpires = function(condition)
		Ovale:EnableOtherDebuffs()
		local otherDebuff = Ovale.otherDebuffs[GetSpellInfo(condition[1])]
		if otherDebuff then
			local timeBefore = condition[2] or 0
			local maxTime = condition[3] or 10
			local minTime
			for k,v in pairs(otherDebuff) do
				local diff = v
				if Ovale.maintenant-maxTime>diff then
					-- Ovale:Print("enlève obsolète sur "..k)
					otherDebuff[k] = nil
				elseif k~=UnitGUID("target") and (not minTime or diff<minTime) then
					minTime = diff
				end
			end
			if not minTime then
				return nil
			end
			minTime = minTime - timeBefore
			return minTime
		end
		return nil
	end,
	OtherDebuffPresent = function(condition)
		Ovale:EnableOtherDebuffs()
		local otherDebuff = Ovale.otherDebuffs[GetSpellInfo(condition[1])]
		if otherDebuff then
		--	print("otherDebuff")
			local maxTime = 0
			local suppTime = condition[3] or 10
			for target,expireTime in pairs(otherDebuff) do
		--		print("target "..target.. " "..expireTime)
				if target~=UnitGUID("target") then
					if Ovale.maintenant - suppTime > expireTime then
						otherDebuff[target] = nil
					elseif expireTime > maxTime then
						maxTime = expireTime
					end
				end
			end
		--	print("maxTime final "..maxTime)
			if maxTime>0 then
				local timeBefore = condition[2] or 0
				return 0, addTime(maxTime, -timeBefore)
			else
				return nil
			end
		end
		return nil
	end,
	-- Test if any player pet is present (or not)
	-- 1 : "yes" or "no"
	PetPresent = function(condition)
		local present = UnitExists("pet") and not UnitIsDead("pet")
		return testbool(present, condition[1])
	end,
	Runes = function(condition)
		local type = runeType[condition[1]]
		local nombre = 0
		local nombreCD = 0
		local maxCD = nil
		local minCD = nil
		for i=1,6 do
			local rune = Ovale.state.rune[i]
			if rune.type == type or (rune.type == 4 and not condition.nodeath) then
				if (rune.cd == 0) then
					nombre = nombre + 1
				else
					nombreCD = nombreCD + 1
					if (maxCD == nil or rune.cd>maxCD) then
						maxCD = rune.cd
					end
					if (minCD == nil or rune.cd<minCD) then
						minCD = rune.cd
					end
				end
			end
		end
		local wanted = condition[2]
		if (nombre >= wanted) then
			return 0
		elseif (nombre + nombreCD < wanted) then
			return nil
		elseif (wanted == nombre + 1) then
			return minCD
		else
			-- Il ne peut y avoir que deux runes sur CD de toute façon
			return maxCD
		end
	end,
	Speed = function(condition)
		return compare(GetUnitSpeed("player")*100/7, condition[1], condition[2])
	end,
	-- Test if the player is in a given stance
	-- 1 : the stance
	Stance = function(condition)
		if (GetShapeshiftForm(true) == condition[1]) then
			return 0
		else
			return nil
		end
	end,
	Stealthed = function(condition)
		return testbool(IsStealthed(), condition[1])
	end,
	-- Test how many talent points has been spent in a talent
	-- 1 : the talent identifier (use /script print(Ovale.talentNameToId["Talent name"]) to retreive)
	-- 2 : "more" or "less"
	-- 3 : the limit
	TalentPoints = function(condition)
		if (not Ovale.listeTalentsRemplie) then
			Ovale:RemplirListeTalents()
			return nil
		end
		return compare(Ovale.pointsTalent[condition[1]], condition[2], condition[3])
	end,
	TargetDispellableBuffPresent = function(condition)
		
		return nil
	end,
	-- Test if a buff is present on the target
	-- 1 : buff spell id
	-- stacks : how many stacks
	TargetBuffPresent = function(condition)
		local start, ending = GetTargetAura(condition, "HELPFUL")
		local tempsMin = avecHate(condition[2], condition.haste)
		return start, addTime(ending, -tempsMin)
	end,
	TargetClass = function(condition)
		local loc, noloc = UnitClass("target")
		return testbool(noloc == condition[1], condition[2])
	end,
	-- Test the target classification
	-- 1 : normal, elite, or worldboss
	TargetClassification = function(condition)
		local classification = UnitClassification("target");
		if (classification == "rareelite") then
			classification = "elite"
		elseif (classification == "rare") then
			classification = "normal"
		end

		if (condition[1]==classification) then
			return 0
		else
			return nil
		end
	end,
	TargetCreatureType = function(condition)
		for _,v in pairs(condition) do
			if (UnitCreatureType("target") == LBCT[v]) then
				return 0
			end
		end
		return nil
	end,
	TargetDeadIn = function(condition)
		local deadAt = getTargetDead()
		if condition[1] == "more" then
			return 0, addTime(deadAt, -condition[2])
		else
			return addTime(deadAt, -condition[2]), nil
		end
	end,
	-- Test if a debuff will expire on the target after a given time, or if there is less than the
	-- given number of stacks (if stackable)
	-- 1 : buff spell id
	-- 2 : expiration time 
	-- stacks : how many stacks
	-- mine : 1 means that if the debuff is not ours, the debuff is ignored
	TargetDebuffExpires = function(condition)
		local start, ending = GetTargetAura(condition, "HARMFUL")
		local tempsMax = avecHate(condition[2], condition.haste)
		return addTime(ending, -tempsMax)
	end,
	-- Test if a debuff is present on the target
	-- 1 : debuff spell id
	-- stacks : how many stacks
	-- mine : 1 means that the debuff must be yours
	TargetDebuffPresent = function(condition)
		local start, ending = GetTargetAura(condition, "HARMFUL")
		local tempsMin = avecHate(condition[2], condition.haste)
		return start, addTime(ending, -tempsMin)
	end,
	TargetInRange = function(condition)
		return testbool(IsSpellInRange(Ovale:GetSpellInfoOrNil(condition[1]),getTarget(condition.target))==1,condition[2])
	end,
	TargetIsCasting = function(condition)
		return testbool(UnitCastingInfo(getTarget(condition.target)), condition[1])
	end,
	TargetLife = function(condition)
		local target = getTarget(condition.target)
		return compare(UnitHealth(target), condition[1], condition[2])
	end,
	-- Test if the target life is bellow/above a given value in percent
	-- 1 : "less" or "more"
	-- 2 : the limit, in percents
	TargetLifePercent = function(condition)
		local target = getTarget(condition.target)
		return compare(UnitHealth(target)/UnitHealthMax(target), condition[1], condition[2]/100)
	end,
	TargetMana = function(condition)
		local target = getTarget(condition.target)
		return compare(UnitPower(target), condition[1], condition[2])
	end,
	-- Test the target level difference with the player
	-- 1 : "less" or "more"
	-- 2 : [target level]-[player level] limit
	TargetRelativeLevel = function(condition)
		local difference
		if (UnitLevel("target") == -1) then
			difference = 3
		else
			difference = UnitLevel("target") - UnitLevel("player")
		end

		return compare(difference, condition[1], condition[2])
	end,
	-- Test if the target's target is the player (or is not)
	-- 1 : "yes" (it should be the player) or "no"
	TargetTargetIsPlayer = function(condition)
		return testbool(UnitIsUnit("player","targettarget"), condition[1])
	end,
	Threat = function(condition)
		local isTanking, status, threatpct = UnitDetailedThreatSituation("player", getTarget(condition.target))
		return compare(threatpct, condition[1], condition[2])
	end,
	TimeInCombat = function(condition)
		if condition[1] == "more" then
			return Ovale.combatStartTime + condition[2]
		else
			return 0, Ovale.combatStartTime + condition[2]
		end
	end,
	TotemExpires = function(condition)
		local haveTotem, totemName, startTime, duration = GetTotemInfo(totemType[condition[1]])
		if not startTime then
			return 0
		end
		if (condition.totem and Ovale:GetSpellInfoOrNil(condition.totem)~=totemName) then
			return 0
		end
		return addTime(startTime + duration, -(condition[2] or 0))
	end,
	Tracking = function(condition)
		local what = Ovale:GetSpellInfoOrNil(condition[1])
		local numTrackingTypes = GetNumTrackingTypes()
		local present = false
		for i=1,numTrackingTypes do
			local name, texture, active = GetTrackingInfo(i)
			if name == what then
				present = (active == 1)
				break
			end
		end
		return testbool(present, condition[2])
	end,
	WeaponEnchantExpires = function(condition)
		local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
		if (condition[1] == "mainhand") then
			if (not hasMainHandEnchant) then
				return 0
			end
			mainHandExpiration = mainHandExpiration/1000
			if ((condition[2] or 0) >= mainHandExpiration) then
				return 0
			else
				return Ovale.maintenant + mainHandExpiration - condition[2]
			end
		else
			if (not hasOffHandEnchant) then
				return 0
			end
			offHandExpiration = offHandExpiration/1000
			if ((condition[2] or 0) >= offHandExpiration) then
				return 0
			else
				return Ovale.maintenant + offHandExpiration - condition[2]
			end
		end
	end,
}