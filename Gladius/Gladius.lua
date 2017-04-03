Gladius = LibStub("AceAddon-3.0"):NewAddon("Gladius", "AceEvent-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Gladius", true)
local LSM = LibStub("LibSharedMedia-3.0")
local arenaUnits = {}
local arenaGUID = {}
local arenaSpecs = {}

local petClasses = { ["WARLOCK"] = true, ["DEATHKNIGHT"] = true, ["MAGE"] = true, ["PRIEST"] = true, ["HUNTER"] = true, }
local instanceType, db, GladiusAuraList

-- diminishing return
local DRTIME = 17

function Gladius:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("GladiusDB", self:getDefaults())
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	db = self.db.profile
	
	self.buttons = {}
	self.currentBracket = nil

	-- Populate the arenaUnits table
	for i=1, 5 do
		arenaUnits["arena" .. i] = "playerUnit"
		arenaUnits["arenapet" .. i] = "arena" .. i
	end
	
	-- Add support for the addon Clique
	if ( db.cliqueSupport and IsAddOnLoaded("Clique") ) then
		for i=1, 6 do
			self.buttons["arena" .. i] = self:CreateButton(i)
			self.buttons["arenapet" .. i] = self.buttons["arena" .. i].pet
		end
		
		ClickCastFrames = ClickCastFrames or {}
		ClickCastFrames[GladiusButton1] = true
		ClickCastFrames[GladiusButton2] = true
		ClickCastFrames[GladiusButton3] = true
		ClickCastFrames[GladiusButton4] = true
		ClickCastFrames[GladiusButton5] = true
	end
	
	-- Set the text in the keybinding interface.
	BINDING_HEADER_GLADIUS 				= L["Gladius"]
	BINDING_NAME_GLADIUSTARGET1_LEFT 	= L["Left click enemy #1"]
	BINDING_NAME_GLADIUSTARGET2_LEFT 	= L["Left click enemy #2"]
	BINDING_NAME_GLADIUSTARGET3_LEFT 	= L["Left click enemy #3"]
	BINDING_NAME_GLADIUSTARGET4_LEFT 	= L["Left click enemy #4"]
	BINDING_NAME_GLADIUSTARGET5_LEFT 	= L["Left click enemy #5"]
	BINDING_NAME_GLADIUSTARGET1_RIGHT 	= L["Right click enemy #1"]
	BINDING_NAME_GLADIUSTARGET2_RIGHT 	= L["Right click enemy #2"]
	BINDING_NAME_GLADIUSTARGET3_RIGHT 	= L["Right click enemy #3"]
	BINDING_NAME_GLADIUSTARGET4_RIGHT	= L["Right click enemy #4"]
	BINDING_NAME_GLADIUSTARGET5_RIGHT 	= L["Right click enemy #5"]

	-- Add spec-detection abilities
	self.specBuffs = self:GetSpecBuffList()
	self.specSpells = self:GetSpecSpellList()
	
	-- Get Cooldown Spells
	self.cooldownSpells = self:GetCooldownList()
	self.cooldownSpellIds = {}
	self.spellTextures = {}
	
	for class, t in pairs(self.cooldownSpells) do
      for k,v in pairs(t) do
         local spellName, _, texture = GetSpellInfo(k)
         self.cooldownSpellIds[spellName] = k
         self.spellTextures[k] = texture
      end
	end
	
	-- Get Diminishing Return Spells
	self.drSpells = self:GetDRList()
	self.drSpellIds = {}
	self.drSpellTextures = {}
	for spellId, spellType in pairs(self.drSpells) do
      local spellName, _, texture = GetSpellInfo(spellId)
      self.drSpellIds[spellName] = spellType
      self.drSpellTextures[spellName] = texture
	end
	self.drTime = { "50%", "25%", L["immune"] }
	
	self:SetupOptions()
end

function Gladius:OnEnable()
	-- Register the appropriate events that fires when you enter an arena
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA")
	
	-- Incase the frame isn't locked and hasn't been moved, print out a little welcome message
	if (not db.locked and db.x == 0 and db.y == 0) then
		self:ToggleFrame(5)
		self:Print(L["Welcome to Gladius!"])
		self:Print(L["First run has been detected, displaying test frame."])
		self:Print(L["Valid slash commands are:"])
		self:Print(L["/gladius ui"])
		self:Print(L["/gladius test1-5"])
		self:Print(L["/gladius hide"])
		self:Print(L["If this is not your first run please lock or move the frame to prevent this from happening."])
	end
	
	-- Check if we are in an arena in case of postponed loading (AddonLoader support)
	if IsLoggedIn() then
		Gladius:ZONE_CHANGED_NEW_AREA()
	end
end

function Gladius:OnProfileChanged(event, database, newProfileKey)
   db = self.db.profile
   	
	-- display a test frame
	self:HideFrame()
	self:ToggleFrame(5)
end

function Gladius:ZONE_CHANGED_NEW_AREA()
	local type = select(2, IsInInstance())
	
	-- Check if we are entering or leaving an arena and call the functions	
	if (type == "arena") then
		self:JoinedArena()
	elseif (type ~= "arena" and instanceType == "arena") then
		self:LeftArena()
	end
	
	instanceType = type
end

-- Iterates through and resets all units (only resets the necessary things, like trinket status)
function Gladius:ClearAllUnits()
	for k, v in pairs(self.buttons) do
		if ( arenaUnits[k] == "playerUnit" ) then
			-- Stop the trinket cooldown counting
			if ( v.trinketFrame ) then
				v.trinketFrame:SetScript("OnUpdate", nil)
			end
			
			-- Resets so the announcement works again
			v.enemyAnnounced = false
			v.lastAuraName = nil
			
			-- diminishing return
         v.diminishingReturn = {}
			
			-- reset cooldown tracker
			for i=1, 14 do
            local icon = v.spellCooldownFrame["icon" .. i]
            icon.spellId = nil
            icon:Hide()
			end
			
			-- Reset all the cooldown spirals
			CooldownFrame_SetTimer(v.cooldownFrame, 1, 1, 1)
			
			-- Turn grid trinket icon green again
			v.gridTrinket:SetBackdropColor(0,1,0,1)
			
			-- Reset the trinket "text" to avoid issues with the embedded trinket icon
			v.trinket:SetText("")
		end
			
		-- Hide the button
		v:SetAlpha(0)
		v:Hide()
	end
	
	-- Reset guid table
	arenaGUID = {}
	
	-- Reset spec listing
	for i=1,5 do arenaSpecs["arena" .. i] = nil end
end

-- We joined an arena: clear units, register events, create buttons and show frames
function Gladius:JoinedArena()
	-- Clear all the buttons in case the frame has been in test mode.
	self:ClearAllUnits()
	
	-- Enemy events
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("UNIT_MANA", "UNIT_POWER")
	self:RegisterEvent("UNIT_RAGE", "UNIT_POWER")
	self:RegisterEvent("UNIT_ENERGY", "UNIT_POWER")
	self:RegisterEvent("UNIT_FOCUS", "UNIT_POWER")
	self:RegisterEvent("UNIT_RUNIC_POWER", "UNIT_POWER")
	self:RegisterEvent("UNIT_DISPLAYPOWER")
	self:RegisterEvent("UNIT_TARGET")
	self:RegisterEvent("UNIT_NAME_UPDATE")
	self:RegisterEvent("UNIT_PET")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	-- Spellcasting events
	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_DELAYED")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "UNIT_SPELLCAST_DELAYED")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UNIT_SPELLCAST_STOP")
	
	-- Player events
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("PLAYER_FOCUS_CHANGED")
	
	-- Special arena event
	self:RegisterEvent("ARENA_OPPONENT_UPDATE")
	
	-- Find out the current bracket size
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, _, _, _, _, teamSize = GetBattlefieldStatus(i)
		if (status == "active" and teamSize > 0) then
			Gladius.currentBracket = teamSize
			break
		end
	end
	
	-- Create the frame and the correct amount of buttons.
	-- It creates one extra button incase the arena unit ids bug out
	for i=1, Gladius.currentBracket+1 do
		local unit = "arena" .. i
		local pet = "arenapet" .. i
		local button = self.buttons[unit]
		
		if (not button) then
			button = self:CreateButton(i)
			self.buttons[unit] = button
			self.buttons[pet] = button.pet
		end
		
		button:Show()
		if ( not db.showPets ) then
         button.pet:Hide()
      else
         button.pet:Show()
      end
		button.powerType = 0
	end
	
	-- Update the frame, buttons, bindings and show the frame
	self.frame.testing = false
	self:UpdateFrame()
	self.UpdateUnits()
	self:UpdateBindings()
	self.frame:Show()
end

--We left an arena, unregister all events, register zoning events and clear+hide the frame and buttons
function Gladius:LeftArena()
	self:ClearAllUnits()	
	self:UnregisterAllEvents()
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA")
	self.frame:Hide()
end

--Update units health
function Gladius:UNIT_HEALTH(event, unit)
	if (arenaUnits[unit]) then
		local button = self.buttons[unit]
		if(not button) then return end
		
		-- show the button
		if (arenaUnits[unit] == "playerUnit" or (arenaUnits[unit] ~= "playerUnit" and db.showPets)) then
         if (not button:IsShown()) then button:Show() end
         if (button:GetAlpha() < 1) then button:SetAlpha(1) end         
      end
		
		if(not UnitIsDeadOrGhost(unit)) then
			local currentHealth, maxHealth = UnitHealth(unit), UnitHealthMax(unit)
			local healthPercent = math.floor((currentHealth / maxHealth) * 100)
			local healthText
			
			if ( db.healthActual ) then
				healthText = db.shortHpMana and currentHealth > 9999 and string.format("%.1fk", (currentHealth / 1000)) or currentHealth  
			end
			
			if ( db.healthMax ) then
				local text = db.shortHpMana and maxHealth > 9999 and string.format("%.1fk", (maxHealth / 1000)) or maxHealth
				if ( healthText ) then
					healthText = string.format("%s/%s", healthText, text)
				else
					healthText = text
				end
			end
			
			if ( db.healthPercentage) then
				if ( healthText ) then
					healthText = string.format("%s (%d%%)", healthText, healthPercent)
				else
					healthText = string.format("%d%%", healthPercent)
				end		
			end
		
			button.healthText:SetText(healthText)
			button.health:SetValue(healthPercent)
			
			-- display low health announcement
			if ( db.lowHealthAnnounce and healthPercent <= db.lowHealthPercentage and not button.lowHealth and (not button.healthThrottle or GetTime() > button.healthThrottle) and button.name ) then
				local text = string.format(L["LOW HEALTH: %s"], button.name)
				Gladius:SendAnnouncement(text, RAID_CLASS_COLORS[button.class])
				button.lowHealth = true
				button.healthThrottle = GetTime() + 5
			end
			
			-- reset the lowHealth announcement
			if ( button.lowHealth and healthPercent > db.lowHealthPercentage ) then
				button.lowHealth = false
			end
		else
			button.healthText:SetText("DEAD")
			button.health:SetValue(0)
			button:SetAlpha(0.5)
		end

	end
end

--Update units mana/rage/energy
function Gladius:UNIT_POWER(event, unit)
	if ( arenaUnits[unit] == "playerUnit" and not UnitIsDeadOrGhost(unit) ) then
		local button = self.buttons[unit]		
		if(not button) then return end
		
		local currentMana, maxMana = UnitMana(unit), UnitManaMax(unit)
		local manaPercent = math.floor((currentMana/maxMana) * 100)
		local manaText
		
		if ( db.manaActual ) then
			manaText = db.shortHpMana and currentMana > 9999 and string.format("%.1fk", (currentMana / 1000)) or currentMana  
		end
		
		if ( db.manaMax ) then
			local text = db.shortHpMana and maxMana > 9999 and string.format("%.1fk", (maxMana / 1000)) or maxMana
			if ( manaText ) then
				manaText = string.format("%s/%s", manaText, text)
			else
				manaText = text
			end
		end
		
		if ( db.manaPercentage ) then
			if ( manaText ) then
				manaText = string.format("%s (%d%%)", manaText, manaPercent)
			else
				manaText = string.format("%d%%", manaPercent)
			end		
		end
		
		button.manaText:SetText(manaText)
		button.mana:SetValue(manaPercent)
	end
end

--Update units powertypes
function Gladius:UNIT_DISPLAYPOWER(event, unit)
	if (arenaUnits[unit] == "playerUnit") then
		local button = self.buttons[unit]		
		if(not button) then return end
		
		button.powerType = UnitPowerType(unit)
		if (button.powerType == 0 and not db.manaDefault) then
			button.mana:SetStatusBarColor(db.manaColor.r, db.manaColor.g, db.manaColor.b, db.manaColor.a)
		elseif (button.powerType == 1 and not db.rageDefault) then
			button.mana:SetStatusBarColor(db.rageColor.r, db.rageColor.g, db.rageColor.b, db.rageColor.a)
		elseif (button.powerType == 3 and not db.energyDefault) then
			button.mana:SetStatusBarColor(db.energyColor.r, db.energyColor.g, db.energyColor.b, db.energyColor.a)
		elseif (button.powerType == 6 and not db.rpDefault) then
			button.mana:SetStatusBarColor(db.rpColor.r, db.rpColor.g, db.rpColor.b, db.rpColor.a)
		else
			button.mana:SetStatusBarColor(PowerBarColor[button.powerType].r, PowerBarColor[button.powerType].g, PowerBarColor[button.powerType].b)
		end
	end
end

-- Aura event
local DRINK_SPELL = GetSpellInfo(57073)
local WYVERN_SPELL = GetSpellInfo(49012)
function Gladius:UNIT_AURA(event, unit)
	if ( arenaUnits[unit] == "playerUnit" ) then	
		local button = self.buttons[unit]		
		if(not button) then return end
		
		-- show the button
		if (arenaUnits[unit] == "playerUnit" or (arenaUnits[unit] ~= "playerUnit" and db.showPets)) then
         if (not button:IsShown()) then button:Show() end
         if (button:GetAlpha() < 1) then button:SetAlpha(1) end         
      end
		
		local aura = button.auraFrame
		local index = 1
		local priority = 0
		local auraName, auraIcon, auraExpTime
		
		--Buffs
		while ( true ) do
			local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, "HELPFUL")
			if ( not name ) then break end
			
			if ( (GladiusAuraList[name] and GladiusAuraList[name] >= priority) or ( name == "Berserk" and UnitClass(unit) == "Druid" ) ) then
				priority = GladiusAuraList[name] and GladiusAuraList[name] or 3
				auraName = name
				auraIcon = icon
				auraExpTime = expirationTime
				
				-- announce aura gain
            if((db.auraAnnounce or (db.auraAnnounceList[auraName] and db.auraAnnounceList[auraName] ~= "disabled")) and (not button.lastAuraName or auraName ~= button.lastAuraName)) then
               self:SendAnnouncement(string.format(L["AURA GAIN: %s (%s) - %s for %s seconds"], UnitName(unit), UnitClass(unit), auraName, ceil(auraExpTime - GetTime())), RAID_CLASS_COLORS[select(2, UnitClass(unit))], db.auraAnnounceList[auraName] and db.auraAnnounceList[auraName] or db.announceType)
               button.lastAuraName = auraName
            end
			end	
			
			-- Spec detection
			self:DetectSpec(unitCaster, self.specBuffs[name])
			
			-- If the unit is drinking, show an announcement if it's turned on
			if ( name == DRINK_SPELL and db.drinkAnnounce and ( not button.drinkThrottle or GetTime() > button.drinkThrottle )) then
				Gladius:SendAnnouncement(string.format(L["DRINKING: %s (%s)"], button.name, button.classLoc), RAID_CLASS_COLORS[button.class])
				button.drinkThrottle = GetTime() + 3 -- limit the spamming of announcements
			end
			
			index = index+1
		end
		
		index = 1 -- reset the index so we can start over with our aura scan
		
		--Debuffs 
		while ( true ) do
			local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, "HARMFUL")
			if ( not name ) then break end
			
			-- Here we implement a fix for wyvern sting to have it not display the DoT
			if ( GladiusAuraList[name] and GladiusAuraList[name] >= priority and ( not button.wyvernDot or name ~= WYVERN_SPELL )) then
				priority = GladiusAuraList[name]
				auraName = name
				auraIcon = icon
				auraExpTime = expirationTime
			end
			
			index = index+1	
		end	
		
		if ( auraName ) then -- Aura found?
			Gladius:AuraGain(unit, auraName, auraIcon, auraExpTime, priority) -- Display it!
		elseif ( not auraName and aura.auraActive ) then -- No aura found and one is active?
			Gladius:AuraFades(aura) -- Have it fade.
		end
		
		-- Debuff tracker, couldn't think of a better way to do this
		if(db.enableDebuffs) then
			for k, debuff in pairs(db.debuffs) do
				if(debuff.name == "") then return end
				local frame = button.debuffFrame["icon"..k]
				local _,_,_,_,_,duration,expirationTime,_,_ = UnitDebuff(unit,debuff.name)
				if(duration) then
					Gladius:DebuffGain(unit,k,expirationTime,duration)
				elseif(not duration and frame.active) then
					Gladius:DebuffFades(frame)
				end
			end
		end
	end
end

function Gladius:AuraGain(unit, name, icon, expirationTime, priority)
	if (not db.displayAuras or not db.classIcon or db.trinketDisplay == "overrideIcon") then return end
	local aura = self.buttons[unit].auraFrame
	aura.name = name
	aura.priority = priority
	aura.timeLeft = (expirationTime - GetTime())
	aura.icon:SetTexture(icon)
	aura.auraActive = true
end

function Gladius:AuraFades(frame)
	frame.name = nil
	frame.priority = nil
	frame.text:SetText("")
	frame.icon:SetTexture("")
	frame.auraActive = nil
end

function Gladius:DebuffGain(unit, num, expirationTime, duration)
	local frame = self.buttons[unit].debuffFrame["icon"..num]
	frame.active = true
	frame.timeLeft = (expirationTime - GetTime())
	frame.cooldown:SetCooldown(expirationTime - duration, duration)
	
	if(db.debuffHiddenStyle == "desat") then
		frame.texture:SetDesaturated(0)
	else 
		frame:SetAlpha(1)
	end
	
	frame:SetScript("OnUpdate", function(self, elapsed)
		self.timeLeft = self.timeLeft - elapsed
		if ( self.timeLeft <= 0 ) then
			Gladius:DebuffFades(frame)
		end	
		if ( self.timeLeft < 10 ) then
			self.cooldown.text:SetFormattedText("%.1f", self.timeLeft)
		else
			self.cooldown.text:SetFormattedText("%.0f", self.timeLeft)
		end
	end)
end

function Gladius:DebuffFades(frame)
	frame.active = false
	frame.cooldown:Hide()
	frame.cooldown.text:SetText("")
	frame:SetScript("OnUpdate", nil)

	if(db.debuffHiddenStyle == "desat") then
		frame.texture:SetDesaturated(1)
	else
		local alpha = db.debuffHiddenStyle == "alpha" and 0.25 or 0
		frame:SetAlpha(alpha)
	end
end

-- converts the aura list to the old format I was using since I'm too lazy to update the aura functions (old format: ["Spell Name"] = 1 (prio))
function Gladius:ConvertAuraList()
	GladiusAuraList = {}
	for _, aura in pairs(self.db.profile.auras) do
		if ( not aura.deleted ) then
			GladiusAuraList[aura.name] = aura.priority
		end
	end
end

--Spell casts
local RESURRECTION_SPELLS = {
	[GetSpellInfo(48950)] = true,
	[GetSpellInfo(48171)] = true,
	[GetSpellInfo(49277)] = true,
	[GetSpellInfo(50763)] = true
}
function Gladius:UNIT_SPELLCAST_START(event, unit)
	local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo(unit)
	if (arenaUnits[unit] == "playerUnit" and spell) then
		local button = self.buttons[unit]	
		if(not button) then return end
	
		local castBar = button.castBar
		castBar.isCasting = true
		castBar.value = (GetTime() - (startTime / 1000))
		castBar.maxValue = (endTime - startTime) / 1000
		castBar:SetMinMaxValues(0, castBar.maxValue)
		castBar:SetValue(castBar.value)
		castBar.timeText:SetText(maxValue)
		castBar.icon:SetTexture(icon)
		
		if( rank ~= "" ) then
			castBar.spellText:SetFormattedText("%s (%s)", spell, rank)
		else
			castBar.spellText:SetText(spell)
		end
		
		-- Spec detection
		self:DetectSpec(unit, self.specSpells[spell])
		
		-- Resurrection alert
		if(RESURRECTION_SPELLS[spell] and db.resAnnounce) then
			Gladius:SendAnnouncement(string.format(L["RESURRECTING: %s (%s)"], UnitName(unit), UnitClass(unit)), RAID_CLASS_COLORS[button.class])
		end
	end
end

function Gladius:UNIT_SPELLCAST_CHANNEL_START(event, unit)
	local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo(unit)	
	if (arenaUnits[unit] == "playerUnit" and spell) then
		local button = self.buttons[unit]	
		if(not button) then return end
		
		local castBar = self.buttons[unit].castBar
		castBar.isChanneling = true
		castBar.value = ((endTime / 1000) - GetTime())
		castBar.maxValue = (endTime - startTime) / 1000
		castBar:SetMinMaxValues(0, castBar.maxValue)
		castBar:SetValue(castBar.value)
		castBar.timeText:SetText(maxValue)
		castBar.icon:SetTexture(icon)

		if( rank ~= "" ) then
			castBar.spellText:SetFormattedText("%s (%s)", spell, rank)
		else
			castBar.spellText:SetText(spell)
		end
		
		-- Cooldown detection
		local unitClass = select(2, UnitClass(unit))
		local spellId = self.cooldownSpellIds[spell]
		if ( unitClass and self.cooldownSpells[unitClass][spellId] ) then
         self:CooldownUsed(unit, unitClass, spellId, spell)
		end
	end	
end

function Gladius:UNIT_SPELLCAST_STOP(event, unit)
	if (arenaUnits[unit] == "playerUnit") then
		local button = self.buttons[unit]	
		if(not button) then return end
		
		self:CastEnd(button.castBar)
	end
end

function Gladius:UNIT_SPELLCAST_DELAYED(event, unit)
	if (arenaUnits[unit] == "playerUnit") then
		local spell, rank, displayName, icon, startTime, endTime, isTradeSkill
		if (event == "UNIT_SPELLCAST_DELAYED") then
			spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo(unit)
		else
			spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo(unit)
		end
		
		if startTime == nil then return end
		
		local bar = self.buttons[unit].castBar
		bar.value = (GetTime() - (startTime / 1000))
		bar.maxValue = (endTime - startTime) / 1000
		bar:SetMinMaxValues(0, bar.maxValue)
	end
end

function Gladius:CastEnd(bar)
	bar.isCasting = nil
	bar.isChanneling = nil
	bar.timeText:SetText("")
	bar.spellText:SetText("")
	bar.icon:SetTexture("")
	bar:SetValue(0)
end

-- Talent spec detection handler
-- kremonted: Your old code was duplicating the logic twice, don't really need to check if
-- they are a valid unit/have no spec and then check again in here. - Shadowed
function Gladius:DetectSpec(unit, spec)
	if( not spec or arenaSpecs[unit] or arenaUnits[unit] ~= "playerUnit" ) then return end
	arenaSpecs[unit] = spec
	
	-- update cooldown tracker
	if (db.cooldown) then
      local class = select(2, UnitClass(unit))
      for k,v in pairs(self.cooldownSpells[class]) do
         if (db.cooldownList[k] ~= false and db.cooldownList[class] ~= false) then      
            if (type(v) == "table" and ((v.spec ~= nil and v.spec == spec) or (v.notSpec ~= nil and v.notSpec ~= spec))) then
               local button = self.buttons[unit]
               
               local sharedCD = false
               if (type(v) == "table" and v.sharedCD ~= nil and v.sharedCD.cd == nil) then
                  for spellId, _ in pairs(v.sharedCD) do
                     for i=1, button.lastCooldownSpell do
                        local icon = button.spellCooldownFrame["icon" .. i]
                        if (icon.spellId == spellId) then 
                           sharedCD = true 
                        end
                     end
                  end
               end
               if sharedCD then return end
               
               local icon = button.spellCooldownFrame["icon" .. button.lastCooldownSpell]
               icon:Show()
               icon.texture:SetTexture(self.spellTextures[k])
               
               button.lastCooldownSpell = button.lastCooldownSpell + 1            
            end
         end
      end
   end
	
	if( db.specAnnounce ) then
		self:SendAnnouncement(string.format(L["SPEC DETECTED: %s - %s %s"], UnitName(unit), spec, UnitClass(unit)), RAID_CLASS_COLORS[select(2,UnitClass(unit))])
	end
	
	-- update cooldown tracker

	-- Have to do a unit update too so it becomes visible
	if( db.specText ) then
		local button = self.buttons[unit]
		if(not button) then return end
		if (button.classText:GetText()) then
			button.classText:SetFormattedText("%s %s", arenaSpecs[unit], button.classText:GetText())
		else
			button.classText:SetText(arenaSpecs[unit])
		end
	end
end

--Update the highlight and frame border for current target
function Gladius:PLAYER_TARGET_CHANGED(event)
	local target = UnitGUID("target")
	for _, button in pairs(self.buttons) do
		if( button.GUID == target ) then
			if (db.highlight) then
				button.highlight:Show()
			end
			if (db.selectedBorder) then
				button.selected:Show()
			end
		else
			button.highlight:Hide()
			button.selected:Hide()
		end
	end		
end

function Gladius:PLAYER_FOCUS_CHANGED(event)
	local focus = UnitGUID("focus")
	for _, button in pairs(self.buttons) do
		if( button.GUID == focus ) then
			if (db.focusBorder) then
				button.focusBorder:Show()
			end
		else
			button.focusBorder:Hide()
		end
	end
end

--Update target of arena enemies and assist border
function Gladius:UNIT_TARGET(event, unit)
	if (arenaUnits[unit] == "playerUnit" and db.targetIcon) then
      local button = self.buttons[unit]
		local targetIcon = button.targetIcon
		local targetClass = select(2, UnitClass(unit.."target"))
		if (targetClass ~= nil) then
			targetIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
			targetIcon:SetTexCoord(unpack(CLASS_BUTTONS[targetClass]))
			targetIcon:SetAlpha(1)
		else
			targetIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
			targetIcon:SetTexCoord(0,0,0,1,1,0,1,1)
			targetIcon:SetAlpha(0.33)
		end
   elseif (GetRealNumRaidMembers() > 0 and (unit:find("raid") ~= nil or unit:find("party") ~= nil) and unit:find("pet") == nil) then
      if (GetPartyAssignment("MAINASSIST", unit) == 1) then
         local assist = UnitGUID(unit .. "target")
         for _, button in pairs(self.buttons) do
            if( button.GUID == assist ) then
               if (db.assistBorder) then
                  button.assistBorder:Show()
               end
            else
               button.assistBorder:Hide()
            end
         end
      end
	end
end

function Gladius:DRGain(unit, spellType)
   local button = self.buttons[unit]
   if not button then return end
   
   -- don't continue if its a pet or the spellType is deactivated
   if (arenaUnits[unit] ~= "playerUnit" or (db.drList[spellType] ~= nil and not db.drList[spellType])) then return end
   
   -- save the diminishing return value
   if (not button.diminishingReturn) then button.diminishingReturn = {} end
   
   if (not button.diminishingReturn[spellType]) then 
      button.diminishingReturn[spellType] = 0
   end
   
   button.diminishingReturn[spellType] = button.diminishingReturn[spellType] + 1
end

function Gladius:DRFades(unit, spellName)
   local button = self.buttons[unit]
   if not button then return end

   if (not button.diminishingReturn) then button.diminishingReturn = {} end
   
   -- get the diminishing return type
   if (not db.drCooldown) then return end
   local spellType = self.drSpellIds[spellName] 
   
   -- don't continue if its a pet or the spellType is deactivated
   if (arenaUnits[unit] ~= "playerUnit" or (db.drList[spellType] ~= nil and db.drList[spellType] == false)) then return end
   
   -- immune to spells
   if (button.diminishingReturn[spellType] ~= nil and button.diminishingReturn[spellType] >= 4) then return end
   
   -- set the cooldown
   for i=1, 16 do
      local frame = button.drCooldownFrame["icon" .. i]
      if (not frame.active or (frame.type ~= nil and frame.type == spellType)) then
         frame.active = true
         frame.type = spellType
         frame.timeLeft = DRTIME
         frame.cooldown:SetCooldown(GetTime(), DRTIME)
         frame.texture:SetTexture(self.drSpellTextures[spellName])
         
         if (db.drText) then
            frame.text:SetText(self.drTime[button.diminishingReturn[spellType]])
         end
         
         -- position the icons
         self:DRPositionIcons()
         
         -- show icon
         frame:Show()
         frame:SetAlpha(1)         
                  
         frame:SetScript("OnUpdate", function(self, elapsed)
            self.timeLeft = self.timeLeft - elapsed
            if ( self.timeLeft <= 0 ) then
               frame.active = false
               frame.type = nil
               frame.cooldown:Hide()
               frame:SetScript("OnUpdate", nil)
               frame:Hide()
               frame.text:SetText("")
               frame:SetAlpha(0)
               
               -- reset diminishing return
               button.diminishingReturn[spellType] = 0
               
               -- position icons
               Gladius:DRPositionIcons(unit)
            end	
         end)
         
         break
      end
   end
end

function Gladius:DRPositionIcons(unit)
   local button = self.buttons[unit]
   if not button then return end
   
   local lastFrame = nil
   local anchor = db.drCooldownAnchor == "CENTER" and "" or db.drCooldownAnchor
   
   for i=1, 16 do 
      local frame = button.drCooldownFrame["icon" .. i]
      if (frame.active) then
         frame:ClearAllPoints()
            
         if (db.drCooldownPos == "RIGHT") then
            if (lastFrame == nil) then
               frame:SetPoint(anchor.."LEFT",button.drCooldownFrame)
            else
               frame:SetPoint("LEFT",lastFrame,"RIGHT",db.drMargin-5,0)
            end
         else
            if (lastFrame == nil) then
               frame:SetPoint(anchor.."RIGHT",button.drCooldownFrame)
            else
               frame:SetPoint("RIGHT",lastFrame,"LEFT",-db.drMargin+5,0)
            end
         end	
         
         lastFrame = frame
      end
   end   
end

--Scan combatlog for enemy deaths and aura fading
function Gladius:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
	-- enemy death
	if (eventType == "PARTY_KILL" and bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE) then
		self:UnitDeath(destGUID)
	
	elseif ( eventType == "SPELL_AURA_APPLIED" ) then
		local spellID, spellName = ...
		if ( arenaGUID[destGUID] and ( spellID == 49010 or spellID == 49009 or spellID == 27069 or spellID == 24135 or spellID == 24134 or spellID == 24131 ) ) then
			self.buttons[arenaGUID[destGUID]].wyvernDot = true	
      elseif (arenaGUID[destGUID] and self.drSpellIds[spellName]) then
         self:DRGain(arenaGUID[destGUID], self.drSpellIds[spellName])
		end
	
	elseif (eventType == "SPELL_AURA_REMOVED" or eventType == "SPELL_PERIODIC_AURA_REMOVED" or eventType == "SPELL_AURA_REMOVED_DOSE" or eventType == "SPELL_PERIODIC_AURA_REMOVED_DOSE") then
		local spellID, spellName = ...		
		if ( arenaGUID[destGUID] and ( spellID == 49010 or spellID == 49009 or spellID == 27069 or spellID == 24135 or spellID == 24134 or spellID == 24131 ) ) then
			self.buttons[arenaGUID[destGUID]].wyvernDot = false
      elseif (arenaGUID[destGUID] and self.drSpellIds[spellName]) then
         self:DRFades(arenaGUID[destGUID], spellName)
		end
   
   elseif (eventType == "SPELL_AURA_REFRESH") then
      local spellID, spellName = ...		
      if (arenaGUID[destGUID] and self.drSpellIds[spellName]) then
         self:DRFades(arenaGUID[destGUID], spellName)
         self:DRGain(arenaGUID[destGUID], self.drSpellIds[spellName])
      end
	
	elseif ( eventType == "SPELL_CAST_SUCCESS" ) then
		local spellID, spellName = ...
		-- Trying out UNIT_SPELLCAST_SUCCEEDED because relying on the combat log for important things sucks due to it breaking constantly.
		--[[							
		if( arenaGUID[sourceGUID] ) then
			-- Spec detection for instant cast spells
			-- GetSpellInfo(spellID) and spellName are the same, results don't differ.
			self:DetectSpec(arenaGUID[sourceGUID], self.specSpells[spellName])
			
			-- enemy trinket usage
			if( ( spellID == 59752 or spellID == 42292 ) and db.trinketStatus ) then
				self:TrinketUsed(arenaGUID[sourceGUID], 120)
			end
			
			--wotf
			if ( spellID == 7744 and db.trinketStatus ) then	
				self:TrinketUsed(arenaGUID[sourceGUID], 45)
			end
		end
		--]]
	end
	
end

-- New little experiment, hopefully this won't break just as often as the combat log (lol)
function Gladius:UNIT_SPELLCAST_SUCCEEDED(event, unit, spell, rank)
	if ( arenaUnits[unit] == "playerUnit" or ( self.frame.testing and unit == "player" )) then
		if ( unit == "player" ) then unit = "arena1" end
		
		-- Spec detection for instant cast spells
		self:DetectSpec(unit, self.specSpells[spell])
		
		-- Cooldown detection		
      local unitClass = select(2, UnitClass(unit))
      local spellId = self.cooldownSpellIds[spell]
      if ( unitClass and self.cooldownSpells[unitClass][spellId] ) then
         self:CooldownUsed(unit, unitClass, spellId, spell)
      end     
		
		-- pvp trinket
		if ( ( spell == GetSpellInfo(59752) or spell == GetSpellInfo(42292) ) and db.trinketStatus ) then
			self:TrinketUsed(unit, 120)
		end

		-- wotf
		if ( spell == GetSpellInfo(7744) and db.trinketStatus ) then	
			self:TrinketUsed(unit, 45)
		end
	end
end

function Gladius:CooldownUsed(unit, unitClass, spellId, spellName)
   local button = self.buttons[unit]
   if not button then return end   
   if (db.cooldownList[spellId] == false) then return end
   
   local cooldown = self.cooldownSpells[unitClass][spellId]
   local cd = cooldown
   if (type(cooldown) == "table") then
      -- return if the spec doesn't have a cooldown for this spell
      if (arenaSpecs[unit] ~= nil and cooldown.notSpec ~= nil and arenaSpecs[unit] == cooldown.notSpec) then return end 
      
      -- check if we need to reset other cooldowns because of this spell
      if (cooldown.resetCD ~= nil) then
         for k,v in pairs(cooldown.resetCD) do
            self:CooldownReady(button, k, false)
         end
      end
      
      -- check if there is a special cooldown for the units spec
      if (arenaSpecs[unit] ~= nil and cooldown[arenaSpecs[unit]] ~= nil) then
         cd = cooldown[arenaSpecs[unit]]
      else
         cd = cooldown.cd
      end     
      
      -- check if there is a shared cooldown with an other spell
      if (cooldown.sharedCD ~= nil) then
         local sharedCD = cooldown.sharedCD.cd and cooldown.sharedCD.cd or cd
      
         for k,v in pairs(cooldown.sharedCD) do
            if (k ~= "cd") then            
               self:CooldownStart(button, k, sharedCD)
            end
         end
      end
   end  

   if (db.cooldown) then     
      -- start cooldown
      self:CooldownStart(button, spellId, cd)
   end
   
   -- announcement
   if (db.cooldownAnnounce or db.cooldownAnnounceList[spellId] or db.cooldownAnnounceList[unitClass]) then   
      self:SendAnnouncement(string.format(L["COOLDOWN USED: %s (%s) used %s - %s sec. cooldown"], UnitName(unit), UnitClass(unit), spellName, cd), RAID_CLASS_COLORS[UnitClass(unit)], db.cooldownAnnounceList[spellId] and db.cooldownAnnounceList[spellId] or db.announceType)
   end
   
   -- sound file
   if (db.cooldownSoundList[spellId] ~= nil and db.cooldownSoundList[spellId] ~= "disabled") then
      PlaySoundFile(LSM:Fetch(LSM.MediaType.SOUND, db.cooldownSoundList[spellId]))
   end  
end

function Gladius:CooldownStart(button, spellId, duration)
   if not duration or duration == nil or type(duration) ~= "number" then return end

   for i=1, button.lastCooldownSpell do
      if (button.spellCooldownFrame["icon" .. i].spellId == spellId) then
         local frame = button.spellCooldownFrame["icon" .. i]
         frame.active = true
         frame.timeLeft = duration
         frame.cooldown:SetCooldown(GetTime(), duration)
                  
         frame:SetScript("OnUpdate", function(self, elapsed)
            self.timeLeft = self.timeLeft - elapsed
            if ( self.timeLeft <= 0 ) then
               Gladius:CooldownReady(button, spellId, frame)
            end	
         end)
      end
   end
end

function Gladius:CooldownReady(button, spellId, frame)
   if (frame == false) then
      for i=1, button.lastCooldownSpell do
         frame = button.spellCooldownFrame["icon" .. i]
         
         if (frame.spellId == spellId) then  
            frame.active = false
            frame.cooldown:Hide()
            frame:SetScript("OnUpdate", nil)
         end
      end
   else
      frame.active = false
      frame.cooldown:Hide()
      frame:SetScript("OnUpdate", nil)
   end
end

function Gladius:GetTrinketIcon(unit)
	local trinketIcon
	
	-- Use the appropiate icon for the level/faction of the enemy (thank you Shadowed for letting me "borrow" this one!)
	if( UnitFactionGroup(unit) == "Horde" ) then
		trinketIcon = UnitLevel(unit) == 80 and "Interface\\Icons\\INV_Jewelry_Necklace_38" or "Interface\\Icons\\INV_Jewelry_TrinketPVP_02"
	else
		trinketIcon = UnitLevel(unit) == 80 and "Interface\\Icons\\INV_Jewelry_Necklace_37" or "Interface\\Icons\\INV_Jewelry_TrinketPVP_01"
	end
	
	if ( db.trinketDisplay == "nameIcon" ) then
		trinketIcon = string.format("|T%s:%d:%d:10:0|t", trinketIcon, db.healthFontSize*2, db.healthFontSize*2)
	end
	
	return trinketIcon
end

-- Trinket updating function
local function TrinketUpdate(self, elapsed)
	if ( self.endTime < GetTime() ) then	
		local button = Gladius.buttons[self.unit]
		local display = db.trinketDisplay

		-- Display nametext/nameicon again
		if ( display == "nameText" or display == "nameIcon" ) then
			button.trinket:SetText(display == "nameText" and " (t)" or trinketIcon)
			button.trinket:SetAlpha(display == "nameText" and 1 or 0.5)
		elseif ( display == "gridIcon" ) then
			button.gridTrinket:SetBackdropColor(0,1,0,1)
		end
		
		-- Announce trinket ready
		if ( db.trinketUpAnnounce ) then
			Gladius:SendAnnouncement(string.format(L["TRINKET READY: %s (%s)"], button.name, button.classLoc), RAID_CLASS_COLORS[button.class])
		end
		
		-- Set OnUpdate script to nothing so it won't continue updating	
		self:SetScript("OnUpdate", nil)
		
	end
	
end	

--Trinket used
function Gladius:TrinketUsed(unit, time)
	local button = self.buttons[unit]
	
	if ( not button or ( button.trinketFrame and button.trinketFrame.endTime > (GetTime()+time)) ) then return end
	
	local display = db.trinketDisplay
	local trinketIcon = self:GetTrinketIcon(unit)

	-- If the updating frame doesn't exist, create it
	if ( not button.trinketFrame ) then
		button.trinketFrame = CreateFrame("Frame", nil, button)
	end

	button.trinketFrame:SetScript("OnUpdate", TrinketUpdate)
	button.trinketFrame.endTime = GetTime() + time
	button.trinketFrame.unit = unit
	
	-- Hide name-text/icon or change color of gridtrinket frame
	if ( display == "nameText" or display == "nameIcon" ) then
		button.trinket:SetText("")
	elseif ( display == "gridIcon" ) then
		button.gridTrinket:SetBackdropColor(1,0,0,1)
	end
	
	-- Set the cooldown timer
	if ( display == "overrideIcon" or display == "bigIcon" or display == "smallIcon" or display == "gridIcon" ) then 
		CooldownFrame_SetTimer(button.cooldownFrame, GetTime(), time, 1)
	end

	-- Announce that the trinket has been used
	if ( db.trinketUsedAnnounce ) then
		if (time == 120) then
			Gladius:SendAnnouncement(string.format(L["TRINKET USED: %s (%s)"], button.name, button.classLoc), RAID_CLASS_COLORS[button.class])
		else
			Gladius:SendAnnouncement(string.format("WOTF USED: %s (%s)", button.name, button.classLoc), RAID_CLASS_COLORS[button.class])
		end
	end
end

--Enemy has died
function Gladius:UnitDeath(GUID)
	local unit = arenaGUID[GUID]
	if (arenaUnits[unit] == "playerUnit") then
		local button = self.buttons[unit]		
		if(not button) then return end
		
		button.health:SetValue(0)
		button.healthText:SetText("DEAD")
		button.mana:SetValue(0)
		button.manaText:SetText("0%")
		button.classIcon:SetAlpha(0.33)
		button.targetIcon:SetAlpha(0.33)
		button.targetIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		button.targetIcon:SetTexCoord(0,0,0,1,1,0,1,1)
		button.trinket:SetText("")
		button.spellCooldownFrame:Hide()
		button.drCooldownFrame:Hide()
		Gladius:AuraFades(button.auraFrame)
	end
end

--Send an announcement message
function Gladius:SendAnnouncement(text, color, dest)
	local color = color or { r = 0, g = 1, b = 0 }
	local dest = dest or db.announceType
	
	if (dest == "self") then
      DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99Gladius|r: " .. text)
   end
	
	if( dest == "rw" and not IsRaidLeader() and not IsRaidOfficer() and GetRealNumRaidMembers() > 0 ) then
		dest = "party"
	end
	
	-- party chat
	if ( dest == "party" and (GetRealNumPartyMembers() > 0 or GetRealNumRaidMembers() > 0) ) then
		SendChatMessage(text, "PARTY")
	
	-- say
	elseif ( dest == "say" ) then
		SendChatMessage(text, "SAY")
		
	-- raid warning
	elseif ( dest == "rw" ) then
		SendChatMessage(text, "RAID_WARNING")
		
	-- floating combat text
	elseif ( dest == "fct" and IsAddOnLoaded("Blizzard_CombatText") ) then
		CombatText_AddMessage(text, COMBAT_TEXT_SCROLL_FUNCTION, color.r, color.g, color.b)
		
	-- MikScrollingBattleText	
	elseif ( dest == "msbt" and IsAddOnLoaded("MikScrollingBattleText") ) then 
		MikSBT.DisplayMessage(text, MikSBT.DISPLAYTYPE_NOTIFICATION, false, color.r * 255, color.g * 255, color.b * 255)
		
	-- Scrolling Combat Text
	elseif ( dest == "sct" and IsAddOnLoaded("sct") ) then
		SCT:DisplayText(text, color, nil, "event", 1)
	
	-- Parrot
	elseif ( dest == "parrot" and IsAddOnLoaded("parrot") ) then
      Parrot:ShowMessage(text, "Notification", false, color.r, color.g, color.b)
	end
end


--Update single unit button
function Gladius:UpdateUnit(unit)	
	local button = self.buttons[unit]	
	if (not button) then return end
	
	--check if unit exists
	if (UnitExists(unit)) then
      if (arenaUnits[unit] == "playerUnit" or (arenaUnits[unit] ~= "playerUnit" and db.showPets)) then
         if (not button:IsShown()) then button:Show() end
         if (button:GetAlpha() < 1) then button:SetAlpha(1) end  
      end

		arenaGUID[UnitGUID(unit)] = unit
		local name, server = UnitName(unit)
		local classLoc, class = UnitClass(unit)
		local raceLoc, race = UnitRace(unit)
				
		button.name = name
		button.class = class
		button.classLoc = classLoc
		button.GUID = UnitGUID(unit)
		button.text:SetText(name)
		
		--Announce the enemy if enabled and a name exists.
		if ( db.enemyAnnounce and not button.enemyAnnounced and name ~= "Unknown" ) then
			Gladius:SendAnnouncement(name .. " - " .. classLoc, RAID_CLASS_COLORS[class])
			button.enemyAnnounced = true
		end
		
		button.diminishingReturn = {}
					
		--setup the trinket status
		if (not db.trinketStatus or (db.trinketDisplay ~= "nameText" and db.trinketDisplay ~= "nameIcon")) then
			button.trinket:SetText("")
		else
			local text = db.trinketDisplay == "nameText" and " (t)" or Gladius:GetTrinketIcon(unit, true)
			local alpha = db.trinketDisplay == "nameText" and 1 or 0.5
			button.trinket:SetText(text)
			button.trinket:SetAlpha(alpha)
		end
		
		if (db.trinketDisplay == "bigIcon" and db.trinketStatus) then
			button.bigTrinket:SetTexture(Gladius:GetTrinketIcon(unit, false))
		elseif (db.trinketDisplay == "smallIcon" and db.trinketStatus) then
			button.smallTrinket:SetTexture(Gladius:GetTrinketIcon(unit, false))
		elseif (db.trinketDisplay == "overrideIcon" and db.trinketStatus) then
			button.overrideTrinket:SetTexture(Gladius:GetTrinketIcon(unit, false))
		end
			
		-- handle the class/race/spec text
		button.classText:SetText("")
		if (db.classText) then
			button.classText:SetText(classLoc)
		end
		
		if (db.raceText) then
			if (button.classText:GetText()) then
				button.classText:SetFormattedText("%s %s", raceLoc, button.classText:GetText())
			else
				button.classText:SetText(raceLoc)
			end
		end
		
		if (db.specText and arenaSpecs[unit]) then
			if (button.classText:GetText()) then
				button.classText:SetFormattedText("%s %s", arenaSpecs[unit], button.classText:GetText())
			else
				button.classText:SetText(arenaSpecs[unit])
			end
		end
		
		if (not db.classText and not db.raceText and not db.specText) then
			button.classText:Hide()
		end
					
		--health bar class color
		button.health:SetStatusBarColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b, 1)
		
		--class icon
		button.classIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
		button.classIcon:SetTexCoord(unpack(CLASS_BUTTONS[class]))
		button.classIcon:SetAlpha(1)
		
		-- update cooldown tracker
		button.lastCooldownSpell = 1
		if (db.cooldown) then         
         for k,v in pairs(self.cooldownSpells[class]) do
            if (db.cooldownList[k] ~= false and db.cooldownList[class] ~= false) then         
               if (type(v) ~= "table" or (type(v) == "table" and v.spec == nil and v.notSpec == nil)) then
                  -- see if we have shared cooldowns without a cooldown defined
                  -- e.g. hunter traps have shared cooldowns, so only display one trap instead all of them
                  local sharedCD = false
                  if (type(v) == "table" and v.sharedCD ~= nil and v.sharedCD.cd == nil) then
                     for spellId, _ in pairs(v.sharedCD) do
                        for i=1, button.lastCooldownSpell do
                           local icon = button.spellCooldownFrame["icon" .. i]
                           if (icon.spellId == spellId) then 
                              sharedCD = true 
                           end
                        end
                     end
                  end
                  
                  if (not sharedCD) then                              
                     local icon = button.spellCooldownFrame["icon" .. button.lastCooldownSpell]
                     icon:Show()
                     icon.spellId = k
                     icon.texture:SetTexture(self.spellTextures[k])
                     
                     button.lastCooldownSpell = button.lastCooldownSpell + 1  
                  end          
               end
            end
         end
		end
		
		--Check if it's a pet class and in that case update the frame to fit
		button.isPetClass = petClasses[class] and true or false
		if ( db.showPets and not button.isPetClass and not InCombatLockdown() and ( not button.resizeThrottle or GetTime() > button.resizeThrottle )) then
			Gladius:NewNonPetUnit(unit)
			button.resizeThrottle = GetTime()+5
		end
		
		-- Update everything
		self:UNIT_HEALTH(nil, unit)
		self:UNIT_POWER(nil, unit)
		self:UNIT_DISPLAYPOWER(nil, unit)
		self:UNIT_AURA(nil, unit)
		self:UNIT_TARGET(nil, unit)
		self:UNIT_PET(nil, unit)
		self:PLAYER_TARGET_CHANGED(nil)
		self:PLAYER_FOCUS_CHANGED(nil)
		self:CastEnd(button.castBar)		
	else
		button:SetAlpha(0)
	end		
end

function Gladius:UNIT_PET(event, unit)
	if ( arenaUnits[unit] or ( self.frame.testing and unit == "player" )) then
		if ( unit == "player" ) then unit = "arena1" end
		for k, v in pairs(arenaUnits) do
			if ( v == unit ) then
				Gladius:UpdatePet(k)
				break
			end
		end
	end
end

-- Update a single pet button
function Gladius:UpdatePet(unit)
	local button = self.buttons[unit]	
	if ( not button ) then return end
	
	if ( self.frame.testing and unit == "arenapet1" ) then unit = "pet" end
	
	--check if unit exists
	if (UnitExists(unit)) then
		button.name = UnitName(unit)
		button.family = UnitCreatureFamily(unit) or UnitName(unit)
		button.nameText:SetText(button.family)
		button.GUID = UnitGUID(unit)
		arenaGUID[button.GUID] = unit
		button:SetAlpha(1)
		self:PLAYER_TARGET_CHANGED(nil)
		self:PLAYER_FOCUS_CHANGED(nil)
		self:UNIT_HEALTH(nil, unit)
	else
		button:SetAlpha(0)
	end
	
end

--Update all buttons that are used in current arena
function Gladius:UpdateUnits()
	for i=1, Gladius.currentBracket do
		Gladius:UpdateUnit("arena" .. i)
	end
end

--Update the button bindings
function Gladius:UpdateBindings()
	for k, v in pairs(self.buttons) do
		local keyLeft = GetBindingKey("GLADIUSTARGET"..v.id.."_LEFT")
		local keyRight = GetBindingKey("GLADIUSTARGET"..v.id.."_RIGHT")
		
		-- Have to clear the override binding first, because if they bind left then bind right
		-- and unbind left the left binding won't be cleared until arenas end (if they use different keys)
		-- although, given the base UI allows them to set both left and right bindings at the same time
		-- it probably should just let them do both? I'm sure Proditor will see this and say something.
		ClearOverrideBindings(v.secure)
		
		if (keyLeft) then
			SetOverrideBindingClick(v.secure, false, keyLeft, v.secure:GetName(), "LeftButton")
		elseif (keyRight) then
			SetOverrideBindingClick(v.secure, false, keyRight, v.secure:GetName(), "RightButton")		
		end		
	end
end

--Update attribute
function Gladius:UpdateAttribute(unit, key, mod, action, spellName)
	local button = self.buttons[unit]
	local test = self.frame.testing
	
	if (test and unit == "arena1") then
		button.secure:SetAttribute("unit", "player")
	elseif (test and unit == "arenapet1") then
		button.secure:SetAttribute("unit", "pet")
	else
		button.secure:SetAttribute("unit", unit)
	end
	
	if (arenaUnits[unit] == "playerUnit") then
      button.secureTarget:SetAttribute("unit", unit .. "target") 
      button.secureTarget:SetAttribute("type1", "target")
   end       

	if ( action == "target" or action == "focus" ) then
		button.secure:SetAttribute(mod .. "type" .. key, action)
	elseif ( action == "macro" and spellName ~= "" ) then
		local macro = string.gsub(spellName, "*unit", unit)
		button.secure:SetAttribute(mod .. "type" .. key, "macro")
		button.secure:SetAttribute(mod .. "macrotext" .. key, macro)
	elseif ( action == "spell" and spellName ~= "" ) then
		button.secure:SetAttribute(mod .. "type" .. key, "spell")
		button.secure:SetAttribute(mod .. "spell" .. key, spellName)
	end
end

--Update all attributes for a specific unit
function Gladius:UpdateAttributes(unit)
	for _, click in pairs(self.db.profile.attributes) do
		self:UpdateAttribute(unit, click.button, click.modifier, click.action, click.spell)
	end
end

--Arena unit update
function Gladius:ARENA_OPPONENT_UPDATE(event, unit, type)
	if(arenaUnits[unit] == "playerUnit") then
		if(type == "seen") then
			Gladius:UpdateUnit(unit)
		elseif(type == "unseen") then
			Gladius.buttons[unit]:SetAlpha(0.25)
		elseif(type == "destroyed") then
			Gladius.buttons[unit]:SetAlpha(0)
		end
	end
end

function Gladius:UNIT_NAME_UPDATE(event, unit)
	if ( self.frame.testing and unit == "pet" ) then unit = "arenapet1" end
	if ( arenaUnits[unit] == "playerUnit" ) then
		Gladius:UpdateUnit(unit)
	elseif ( arenaUnits[unit] and arenaUnits[unit] ~= "playerUnit" ) then
		Gladius:UpdatePet(unit)
	end
end

--Create test buttons
function Gladius:Test()
	for i=1, Gladius.currentBracket do
		local unit = "arena" .. i
		local pet = "arenapet" .. i
		if (not self.buttons[unit]) then
			local button = self:CreateButton(i)
			self.buttons[unit] = button
			self.buttons[pet] = button.pet
		end
	end
	
	for i=1, Gladius.currentBracket do
		local unit = "arena" .. i
		local pet = "arenapet" .. i
		local button = self.buttons[unit]
		
		local class, race, sex, classLoc, raceLoc, health, mana, manaMax, manaPercentage, healthMax, healthActual
		if (i == 1) then
		
			arenaGUID[UnitGUID("player")] = "arena1"
			if ( UnitGUID("pet") ) then
				arenaGUID[UnitGUID("pet")] = "arenapet1"
				button.pet.GUID = UnitGUID("pet")
				button.pet:Show()
				Gladius:UNIT_PET(nil, "player")
			end
			
			classLoc, class = UnitClass("player")
			raceLoc, race = UnitRace("player")
			sex = UnitSex("player")
			button.GUID = UnitGUID("player")
			button.name = UnitName("player")
			button.powerType = UnitPowerType("player")
			button.classLoc = classLoc
			button.class = class
			button.raceLoc = raceLoc
			self:UpdateAttributes("arena1")
			health = math.floor((UnitHealth("player")/UnitHealthMax("player")) * 100)
			healthMax = UnitHealthMax("player")
			healthActual = UnitHealth("player")
			manaMax = UnitManaMax("player")
			mana = UnitMana("player")
			manaPercentage = math.floor((UnitMana("player")/UnitManaMax("player")) * 100)
		else
			class, race, sex = "DRUID", "TAUREN", 2
			classLoc, raceLoc = "Druid", "Tauren"	
			button.name = L["Arena "] .. i
			button.GUID = "testframe"
			button.pet.GUID = "pet"
			button.powerType = i-2
			button.classLoc = classLoc
			button.class = class
			button.raceLoc = raceLoc
			manaMax = 13000
			health, mana = 100-(i^2), manaMax-(i^5)
			healthMax = 20000
			healthActual = healthMax * health/100
			manaPercentage = math.floor((mana/manaMax) * 100)
		end
		
		if ( db.enemyAnnounce ) then
			Gladius:SendAnnouncement(button.name .. " - " .. classLoc, RAID_CLASS_COLORS[class])
		end
		
		button.manaMax = manaMax
		button.manaActual = mana
		button.manaPercentage = manaPercentage
		
		button.healthPercentage = health
		button.healthActual = healthActual
		button.healthMax = healthMax
		
		button.castBar:SetMinMaxValues(0,i)
		button.castBar:SetValue(i-0.5)
		button.castBar.spellText:SetText("Example Spell (Rank 1)")
		button.castBar.timeText:SetText(i-0.5)
		button.castBar.icon:SetTexture(select(3, GetSpellInfo(1)))
		
		Gladius:AuraGain("arena1", "Ice Block", select(3, GetSpellInfo(45438)), GetTime()+10, 3)
		
		button.text:SetText(button.name)
		button.health:SetValue(health)
		button.mana:SetValue(manaPercentage)
		
		if (not db.classText and not db.specText) then
			button.classText:Hide()
		end
		
		if (not db.manaText) then
			button.manaText:Hide()
		end
		
		--Check if it's a pet class and in that case update the frame to fit
		button.isPetClass = petClasses[class] and true or false
		
		if (button.powerType == 0 and not db.manaDefault) then
			button.mana:SetStatusBarColor(db.manaColor.r, db.manaColor.g, db.manaColor.b, db.manaColor.a)
		elseif (button.powerType == 1 and not db.rageDefault) then
			button.mana:SetStatusBarColor(db.rageColor.r, db.rageColor.g, db.rageColor.b, db.rageColor.a)
		elseif (button.powerType == 3 and not db.energyDefault) then
			button.mana:SetStatusBarColor(db.energyColor.r, db.energyColor.g, db.energyColor.b, db.energyColor.a)
		elseif (button.powerType == 6 and not db.rpDefault) then
			button.mana:SetStatusBarColor(db.rpColor.r, db.rpColor.g, db.rpColor.b, db.rpColor.a)
		else
			button.mana:SetStatusBarColor(PowerBarColor[button.powerType].r, PowerBarColor[button.powerType].g, PowerBarColor[button.powerType].b)
		end
		
		button.health:SetStatusBarColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b, 1.0)
		
		local classes = { [0] = "WARRIOR", [1] = "PRIEST", [2] = "DRUID", [3] = "MAGE", [4] = "SHAMAN"}
		local i = math.random(4)
		local targetClass = classes[i]
		button.targetIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
		button.targetIcon:SetTexCoord(unpack(CLASS_BUTTONS[targetClass]))
		      
		button.classIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
		button.classIcon:SetTexCoord(unpack(CLASS_BUTTONS[class]))
		button.classIcon:SetAlpha(1)
		button:SetAlpha(1)
		button:Show()
	end
	
end
