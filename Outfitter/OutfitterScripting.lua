----------------------------------------
-- Modular scripting
----------------------------------------
--[[
	Script modules:
		* Druid: Shapeshift
		* Death Knight: Presence
		* Hunter: Aspect
		* Mage: Invisble
		* Mage: Evocate
		* Paladin: Aura
		* Priest: Shadowform
		* Rogue/Druid: Stealth
		* Shaman: Ghost wolf
		* Warrior: Stance
		* Warlock: Metamorphosis
		
		* Tooltip has text/color
		* Minimap tracking mode
		
		* In combat
		* PvP flagged
		* Health below/above
		* Mana below/above
		* Has buff
		* Has debuff
		* Five-second rule
		* Boss yell/emote
		* Player whisper/say/yell
		
		* In party/raid/battleground
		* In zone/city
		* Resting
		
		* Mounted
		* Falling
		* Swimming
		* Fishing
		* Eating/drinking

	A script module consists of the source code fragments for each block of the script.  The header
	fragment will be inserted above the current script and the footer below.  This allows the script
	to exit early, exit late, or enclose the current script in a block, which provides the flexibility
	of controlling the operation of the script without knowing the contents of the current source.
	
	Scripts can support equip/unequip or disable or both.
]]

----------------------------------------
Outfitter.ScriptModules = {}
----------------------------------------

function Outfitter:GenerateEquipModule(pModule, pSettings, pExistingScript)
	local vScript = pExistingScript or ""
	
	if pModule.GetEquipHeader then
		vScript = pModule:GetEquipHeader(pSettings).."\n"..vScript
	end
	
	if pModule.EquipHeader then
		vScript = pModule.EquipHeader.."\n"..vScript
	end
	
	if pModule.GetEquipFooter then
		vScript = vScript.."\n"..pModule:GetEquipFooter(pSettings)
	end
	
	if pModule.EquipFooter then
		vScript = vScript.."\n"..pModule.EquipFooter
	end
	
	return vScript
end

function Outfitter:GenerateDisableModule(pModule, pSettings, pExistingScript)
	local vScript = pExistingScript or ""
	
	if pModule.GetDisableHeader then
		vScript = pModule:GetDisableHeader(pSettings)..vScript
	end
	
	if pModule.GetDisableFooter then
		vScript = vScript..pModule:GetDisableFooter(pSettings)
	end
	
	return vScript
end

----------------------------------------
Outfitter.ScriptModules.DruidShapeshift = {}
----------------------------------------

Outfitter.ScriptModules.DruidShapeshift.ModuleName = "Druid: Shapeshift"
Outfitter.ScriptModules.DruidShapeshift.Classes = {"DRUID"}
Outfitter.ScriptModules.DruidShapeshift.Settings =
{
	{id = "Caster", type = "boolean", label = "Caster form"},
	{id = "Bear", type = "boolean", label = "Bear form"},
	{id = "Cat", type = "boolean", label = "Cat form"},
	{id = "Aquatic", type = "boolean", label = "Aquatic form"},
	{id = "Travel", type = "boolean", label = "Travel form"},
	{id = "Flight", type = "boolean", label = "Flight form"},
	{id = "Moonkin", type = "boolean", label = "Moonkin form"},
	{id = "Tree", type = "boolean", label = "Tree form"},
}

Outfitter.ScriptModules.DruidShapeshift.Events =
{
	Caster = "CASTER_FORM",
	Bear = "BEAR_FORM",
	Cat = "CAT_FORM",
	Aquatic = "AQUATIC_FORM",
	Travel = "TRAVEL_FORM",
	Flight = "FLIGHT_FORM",
	Moonkin = "MOONKIN_FORM",
	Tree = "TREE_FORM",
}

function Outfitter.ScriptModules.DruidShapeshift:GetEquipHeader(pSettings)
	local vResult = ""
	
	for vSetting, vValue in pairs(pSettings) do
		if vValue then
			local vEvent = self.Events[vSetting]
			
			vResult = vResult..
[[-- $EVENTS ]]..vEvent.." NOT_"..vEvent..[[

if event == "]]..vEvent..[[" then
	equip = true
elseif event == "NOT_]]..vEvent..[[" then
	equip = false
end
]]
		end
	end
	
	return vResult
end

function Outfitter.ScriptModules.DruidShapeshift:GetDisableHeader(pSettings)
	local vResult = ""
	
	for vSetting, vValue in pairs(pSettings) do
		if vValue then
			vResult = vResult..
[[if self.SpecialState.]]..vSetting..[[ then return end
]]
		end
	end
	
	return vResult
end

----------------------------------------
Outfitter.ScriptModules.RogueStealth = {}
----------------------------------------

Outfitter.ScriptModules.RogueStealth.ModuleName = Outfitter.cRogueStealth
Outfitter.ScriptModules.RogueStealth.Classes = {"ROGUE"}

Outfitter.ScriptModules.RogueStealth.EquipHeader =
[[
-- $EVENTS STEALTH NOT_STEALTH
-- Equip on stealth, unequip when leaving stealth

if event == "STEALTH" then
    equip = true
elseif event == "NOT_STEALTH" then
    equip = false
end
]]

Outfitter.ScriptModules.RogueStealth.DisableHeader =
[[
-- Disable while stealthed

if Outfitter.SpecialState.Stealth then
    return
end
]]

----------------------------------------
Outfitter.ScriptModules.AutoLootOnEquip =
----------------------------------------
{
	ModuleName = "Auto Loot",
	
	EquipFooter =
[[
-- $EVENTS OUTFIT_EQUIPPED OUTFIT_UNEQUIPPED
-- $SETTING EnableAutoLoot={type="boolean", label="Enable auto loot while equipped"}

-- Enable auto-loot while equipped

if event == "OUTFIT_EQUIPPED" then
    if setting.EnableAutoLoot then
        setting.savedAutoLoot = GetCVar("autoLootDefault")
        SetCVar("autoLootDefault", "1")
        setting.didSetAutoLoot = true
    end
    
-- Turn auto looting back off if the outfit is being unequipped and we turned it on

elseif event == "OUTFIT_UNEQUIPPED" then
   if setting.EnableAutoLoot and setting.didSetAutoLoot then
       SetCVar("autoLootDefault", setting.savedAutoLoot)
       setting.didSetAutoLoot = nil
       setting.savedAutoLoot = nil
   end
end
]]
}
----------------------------------------
--
----------------------------------------

Outfitter.ScriptContexts = {}
Outfitter.OutfitScriptEvents = {}

function Outfitter:GenerateScriptHeader(pEventIDs, pDescription)
	local vDescription
	
	if pDescription then
		vDescription = '-- $DESC '..pDescription..'\n'
	else
		vDescription = ''
	end
	
	if type(pEventIDs) == "table" then
		pEventIDs = table.concat(pEventIDs, " ")
	end
	
	return '-- $EVENTS '..pEventIDs..'\n'..vDescription..'\n'
end

function Outfitter:GenerateSimpleScript(pEventID, pDescription)
	return
		self:GenerateScriptHeader(pEventID.." NOT_"..pEventID, pDescription)..
[[
-- If the activation event fires, equip the outfit

if event == "]]..pEventID..[[" then
    equip = true

-- Otherwise it must be the deactivation event so unequip it

else
    equip = false
end
]]
end

function Outfitter:GenerateSmartUnequipScript(pEventID, pDescription, pUnequipDelay)
	local vScript
	
	vScript = self:GenerateScriptHeader(pEventID.." NOT_"..pEventID, pDescription)..
[[
-- If the activation event fires, equip the outfit

if event == "]]..pEventID..[[" then
    equip = true

-- Otherwise it must be the deactivation event so unequip
-- the outfit.

-- Note that if you manually equipped the outfit the script
-- will not unequip it for you.  This allows you to avoid excess
-- outfit changes, for example when entering and exiting
-- battlegrounds repeatedly. Remove the didEquip condition
-- to change the behavior to always unequip.

elseif didEquip then
    equip = false
    ]]..((pUnequipDelay and ("delay = "..pUnequipDelay)) or "")..[[
end
]]
	
	return vScript
end

function Outfitter:GenerateShapeshiftScript(pEventID, pDescription, pAllowCompleteUnequip)
	return
		self:GenerateScriptHeader({pEventID, 'NOT_'..pEventID, "OUTFIT_EQUIPPED"}, pDescription)..
[[
-- $SETTING DisableBG={type="boolean", label="Disable in Battlegrounds", default=false}
-- $SETTING DisablePVP={type="boolean", label="Disable while PvP flagged", default=false}
-- $SETTING UnequipComplete={type="boolean", label="Allow Complete outfits to unequip", default=false}

-- Just return if they're PvP'ing and don't want the outfit changing

if (setting.DisableBG and Outfitter:InBattlegroundZone())
or (setting.DisablePVP and UnitIsPVP("player")) then
    return
end

-- Return if the user isn't in full control

if not Outfitter.IsDead and not HasFullControl() then
    return
end

-- If the outfit is being equipped then let Outfitter know
-- which layer it's representing

if event == "OUTFIT_EQUIPPED" then
    layer = "shapeshift"

-- Equip and set the layer if entering the stance

elseif event == "]]..pEventID..[[" then
    equip = true
    layer = "shapeshift"

-- Just unequip if leaving the stance

elseif setting.UnequipComplete
or outfit.CategoryID ~= "Complete" then
    equip = false
end
]]
end

function Outfitter:GenerateDruidShapeshiftScript(pEventID, pDescription)
	return
		self:GenerateScriptHeader({pEventID, 'NOT_'..pEventID, 'OUTFIT_EQUIPPED'}, pDescription)..
[[
-- $SETTING DisableBG={type="boolean", label="Don't equip in Battlegrounds", default=false}
-- $SETTING DisablePVP={type="boolean", label="Don't equip while PvP flagged", default=false}
-- $SETTING UnequipComplete={type="boolean", label="Allow Complete outfits to unequip", default=false}

-- Just return if they're PvP'ing and don't want the outfit changing

if (setting.DisableBG and Outfitter:InBattlegroundZone())
or (setting.DisablePVP and UnitIsPVP("player")) then
    return
end

-- Return if the user isn't in full control

if not Outfitter.IsDead and not HasFullControl() then
    return
end

-- If the user is manually equipping the outfit, let
-- Outfitter know which layer it's representing

if event == "OUTFIT_EQUIPPED" then
    layer = "shapeshift"

-- Equip and set the layer if entering the form

elseif event == "]]..pEventID..[[" then
    equip = true
    layer = "shapeshift"

-- Unequip if leaving the form.  If they're in combat also
-- add a 2 second delay so they have time to start casting
-- a heal on themselves without triggering the global cooldown

elseif event == "NOT_]]..pEventID..[[" then
    if setting.UnequipComplete
	or outfit.CategoryID ~= "Complete" then
        equip = false
		
		if Outfitter.InCombat then
			delay = 2
		end
    end
end
]]
end

function Outfitter:GenerateGatheringScript(pTooltipGatherMessage, pDescription)
	return
[[
-- $EVENTS GAMETOOLTIP_SHOW GAMETOOLTIP_HIDE
-- $DESC ]]..(pDescription or "")..[[

-- If the tooltip is being shown see if the outfit should be equipped

if event == "GAMETOOLTIP_SHOW" then

	-- Check the tooltip for an orange or red tradeskill message
	-- and equip the outfit if there is one

	local hasText, isDifficult = Outfitter:TooltipContainsLine(GameTooltip, ]]..pTooltipGatherMessage..[[)

	if hasText and isDifficult then
		equip=true
	end

	-- The tooltip isn't being shown so it's being hidden.
	-- A one second delay is used so that the outfit doesn't
	-- unequip if the user momentarily moves the cursor off
	-- the node

elseif didEquip then
	equip=false; delay=1
end
]]
end

function Outfitter:GenerateLockpickingScript(pDescription)
	return [[
-- $EVENTS GAMETOOLTIP_SHOW GAMETOOLTIP_HIDE
-- $DESC ]]..(pDescription or "")..[[

-- If the tooltip is being shown see if the outfit should be equipped

if event == "GAMETOOLTIP_SHOW" or event == "TIMER" then
	if event == "GAMETOOLTIP_SHOW" then
		self:RegisterEvent("TIMER")
	end

	if not SpellIsTargeting() then
		return
	end

	-- Check the tooltip for an orange or red tradeskill message
	-- and equip the outfit if there is one

	local hasText, isDifficult = Outfitter:TooltipContainsLine(GameTooltip, Outfitter.cRequiresLockpicking)

	if hasText and isDifficult then
		equip=true
	end

	-- The tooltip isn't being shown so it's being hidden.
	-- A one second delay is used so that the outfit doesn't
	-- unequip if the user momentarily moves the cursor off
	-- the node

else
	self:UnregisterEvent("TIMER")
	if didEquip then -- GAME_TOOLTIP_HIDE
		equip=false; delay=1
	end
end
]]
end

Outfitter.PresetScripts =
{
	{
		Name = Outfitter.cHerbalismOutfit,
		ID = "HERBALISM",
		Category = "TRADE",
		Script = Outfitter:GenerateGatheringScript("UNIT_SKINNABLE_HERB", Outfitter.cHerbalismDescription),
	},
	{
		Name = Outfitter.cMiningOutfit,
		ID = "MINING",
		Category = "TRADE",
		Script = Outfitter:GenerateGatheringScript("UNIT_SKINNABLE_ROCK", Outfitter.cMiningDescription),
	},
	{
		Name = Outfitter.cSkinningOutfit,
		ID = "SKINNING",
		Category = "TRADE",
		Script = Outfitter:GenerateGatheringScript("UNIT_SKINNABLE_LEATHER", Outfitter.cSkinningDescription),
	},
	{
		Name = Outfitter.cLockpickingOutfit,
		ID = "LOCKPICKING",
		Category = "TRADE",
		Class = "ROGUE",
		Script = Outfitter:GenerateLockpickingScript(Outfitter.cLockpickingDescription),
	},
	{
		Name = Outfitter.cPvPFlaggedOutfit,
		ID = "PVP_FLAGGED",
		Category = "PVP",
		Script =
[[
-- $EVENTS PLAYER_FLAGS_CHANGED PLAYER_ENTERING_WORLD
-- $DESC ]]..Outfitter.cPvPFlaggedDescription..[[

local isPvP = UnitIsPVP("player")

if isPvP == outfit.wasPvP then
	return
end

outfit.wasPvP = isPvP

if isPvP then
	equip = true
else
	equip = false
end
]],
	},
	{
		Name = Outfitter.cInDungeonOutfit,
		ID = "IN_DUNGEON",
		Category = "GENERAL",
		Script =
[[
-- $EVENTS PLAYER_ENTERING_WORLD
-- $DESC ]]..Outfitter.cInDungeonDescription..[[

-- $SETTING Enable5Man ={type="boolean", label="Equip in 5-man instances", default=true}
-- $SETTING EnableRaid={type="boolean", label="Equip in Raid instances", default=false}
-- $SETTING EnableBG={type="boolean", label="Equip in Battleground instances", default=false}
 
local inInstance, instanceType = IsInInstance()
 
if inInstance
and ((setting.Enable5Man and instanceType == "party")
    or (setting.EnableRaid and instanceType == "raid")
    or (setting.EnableBG and instanceType == "battleground")) then
        equip = true
else
    equip = false
end
]],
	},
	{
		Name = "Trinket Queue",
		ID = "TRINKET_QUEUE",
		Category = "GENERAL",
		Script =
[[
-- $EVENTS TIMER
-- $DESC The highest trinket in the list that isn't on cooldown will automatically be equipped for you

-- $SETTING Trinkets={label="Upper slot", type="stringtable"}
-- $SETTING Trinkets2={label="Lower slot", type="stringtable"}

if outfit.StoredInEM then
    Outfitter:ErrorMessage("Can't use the Trinket Queue script on the outfit %s because that outfit is stored in the Equipment Manager", tostring(outfit.Name))
    Outfitter:SetScriptEnable(outfit, false)
    return
end

if not isEquipped then
   return
end

local itemInfo0, itemInfo1

if setting.Trinkets and #setting.Trinkets > 0 then
    itemInfo0 = Outfitter:FindNextCooldownItem(setting.Trinkets, true)
end
if setting.Trinkets2 and #setting.Trinkets2 > 0 then
    itemInfo1 = Outfitter:FindNextCooldownItem(setting.Trinkets2, true)
end

if itemInfo0
and (Outfitter:GetInventoryCache():ItemsAreSame(itemInfo0, outfit.Items.Trinket0Slot)
 or Outfitter:InventoryItemIsActive("Trinket0Slot")) then
	itemInfo0 = nil
end

if itemInfo1
and (Outfitter:GetInventoryCache():ItemsAreSame(itemInfo1, outfit.Items.Trinket1Slot)
 or Outfitter:InventoryItemIsActive("Trinket1Slot")) then
	itemInfo1 = nil
end

if itemInfo0 or itemInfo1 then
    Outfitter:BeginEquipmentUpdate()
    if itemInfo0 then
        outfit:SetItem("Trinket0Slot", itemInfo0)
	end
    if itemInfo1 then
        outfit:SetItem("Trinket1Slot", itemInfo1)
    end
    Outfitter.EquippedNeedsUpdate = true
    Outfitter:EndEquipmentUpdate()
end
]],
	},
	{
		Name = "Rocket Boots",
		ID = "FEET_QUEUE",
		Category = "GENERAL",
		Script =
[[
-- $EVENTS TIMER
-- $DESC The boots in the list with the earliest availability will automatically be equipped

-- $SETTING Boots={label="Boots", type="stringtable"}

if not isEquipped then
   return
end

local itemInfo = Outfitter:FindNextCooldownItem(setting.Boots)

if itemInfo
and not Outfitter:GetInventoryCache():ItemsAreSame(itemInfo, outfit.Items.FeetSlot) then
    Outfitter:BeginEquipmentUpdate()
    outfit:SetItem("FeetSlot", itemInfo)
    Outfitter.EquippedNeedsUpdate = true
    Outfitter:EndEquipmentUpdate()
end
]],
	},
	{
		Name = Outfitter.cInZonesOutfit,
		ID = "IN_ZONES",
		Category = "GENERAL",
		Script = Outfitter:GenerateScriptHeader("ZONE_CHANGED_INDOORS ZONE_CHANGED ZONE_CHANGED_NEW_AREA", Outfitter.cInZonesOutfitDescription)..
[[
-- $SETTING zoneList={type="zonelist", label="Zones"}
-- $SETTING minimapZoneList={type="zonelist", zonetype="MinimapZone", label="Minimap zones"}

local currentZone = GetZoneText()

for _, zoneName in ipairs(setting.zoneList) do
   if zoneName == currentZone then
       equip = true
       break
   end
end

if not equip then
   currentZone = GetMinimapZoneText()
   for _, zoneName in ipairs(setting.minimapZoneList) do
       if zoneName == currentZone then
           equip = true
           break
       end
   end
end

if didEquip and equip == nil then
   equip = false
end
]],
	},
	{
		Name = Outfitter.cArgentDawnOutfit,
		ID = "ArgentDawn",
		Category = "QUEST",
		Script = Outfitter:GenerateScriptHeader("ARGENT_DAWN NOT_ARGENT_DAWN", Outfitter.cArgentDawnOutfitDescription)..
[[
if event == "ARGENT_DAWN" then
    equip = true
elseif didEquip then
    equip = false
end
]],
	},
	{
		Name = TALENT_SPEC_PRIMARY or "Primary Talents",
		ID = "Talent1",
		Category = "GENERAL",
		Script = Outfitter:GenerateScriptHeader("ACTIVE_TALENT_GROUP_CHANGED", "Equips the outfit when you activate your primary talents")..
[[
equip = GetActiveTalentGroup() == 1
]],
	},
	{
		Name = TALENT_SPEC_SECONDARY or "Secondary Talents",
		ID = "Talent2",
		Category = "GENERAL",
		Script = Outfitter:GenerateScriptHeader("ACTIVE_TALENT_GROUP_CHANGED", "Equips the outfit when you activate your secondary talents")..
[[
equip = GetActiveTalentGroup() == 2
]],
	},
	{
		Name = Outfitter.cRidingOutfit,
		ID = "Riding",
		Category = "TRADE",
		Script = Outfitter:GenerateScriptHeader("MOUNTED NOT_MOUNTED", Outfitter.cRidingOutfitDescription)..
[[
-- $SETTING DisableBG={type="boolean", label="Don't equip in Battlegrounds", default=true}
-- $SETTING DisableInstance={type="boolean", label="Don't equip in dungeons", default=true}
-- $SETTING DisablePVP={type="boolean", label="Don't equip while PvP flagged", default=false}
-- $SETTING StayEquippedWhileFalling={type="boolean", label="Leave equipped while falling", default=false}
-- $SETTING UnequipDelay={type="number", label="Wait", suffix="seconds before unequipping", default=0}

-- Equip on mount unless it's disabled

if event == "MOUNTED" then
	-- The disable options are only checked inside the mounting handler.  This way
	-- the outfit won't equip automatically, but if the player chooses to
	-- manually equip it after mounting, then Outfitter will still unequip
	-- it for them when they dismount

	local inInstance, instanceType = IsInInstance()

	if (setting.DisableInstance and inInstance and (instanceType == "raid" or instanceType == "party"))
	or (setting.DisableBG and Outfitter:InBattlegroundZone())
	or (setting.DisablePVP and UnitIsPVP("player")) then
		return
	end

	equip = true

-- Unequip on dismount

elseif event == "NOT_MOUNTED" then
	if not setting.StayEquippedWhileFalling then
		equip = false
	else
		self.UnequipWhenNotFalling = true
		self.DismountTime = GetTime()
		self:RegisterEvent("TIMER")
	end

	if setting.UnequipDelay then
		delay = setting.UnequipDelay
	end

-- Check to see if the player is no longer falling

elseif event == "TIMER" then

	-- Unequip if the player was falling when dismounted and has now landed

	if self.UnequipWhenNotFalling
	and GetTime() >= self.DismountTime + 1
	and not IsFalling() then
		equip = false
		self.UnequipWhenNotFalling = nil
	end

	if not self.UnequipWhenNotFalling then
		self:UnregisterEvent("TIMER")
	end
end
]],
	},
	{
		Name = Outfitter.cSwimmingOutfit,
		ID = "Swimming",
		Category = "TRADE",
		Script = Outfitter:GenerateScriptHeader("SWIMMING NOT_SWIMMING", Outfitter.cSwimmingOutfitDescription)..
[[
-- $SETTING DisableInstance={type="boolean", label="Don't equip in dungeons", default=false}
-- $SETTING DisableBG={type="boolean", label="Don't equip in Battlegrounds", default=false}
-- $SETTING DisablePVP={type="boolean", label="Don't equip while PvP flagged", default=false}

-- Just return if they're PvP'ing and don't want the outfit changing

local inInstance, instanceType = IsInInstance()

if (setting.DisableInstance and inInstance and (instanceType == "raid" or instanceType == "party"))
or (setting.DisableBG and Outfitter:InBattlegroundZone())
or (setting.DisablePVP and UnitIsPVP("player")) then
	return
end

if event == "SWIMMING" then
	equip = true
elseif didEquip then
	equip = false
	delay = 2.5 -- Use a delay since hitting spacebar temporarily makes the player not swimming
end
]],
	},
	{
		Name = Outfitter.cFishingOutfit,
		ID = "Fishing",
		Category = "TRADE",
		Script = Outfitter:GenerateScriptHeader("OUTFIT_EQUIPPED OUTFIT_UNEQUIPPED PLAYER_REGEN_DISABLED PLAYER_REGEN_ENABLED PLAYER_ENTERING_WORLD", Outfitter.cFishingOutfitDescription)..
[[
-- $SETTING EnableFishTracking={type="boolean", label="Select Track Fish while equipped", default=true}
-- $SETTING EnableAutoLoot={type="boolean", label="Enable auto loot while equipped"}

-- Enable auto looting if the outfit is being equipped and EnableAutoLoot is on

if event == "OUTFIT_EQUIPPED" then
    if setting.EnableAutoLoot then
        setting.savedAutoLoot = GetCVar("autoLootDefault")
        SetCVar("autoLootDefault", "1")
        setting.didSetAutoLoot = true
    end
    
    if setting.EnableFishTracking then
        setting.savedTracking = Outfitter:GetCurrentTracking()
        Outfitter:SetTrackingByTexture("Interface\\Icons\\INV_Misc_Fish_02")
        setting.didSetTracking = true
    end
    
-- Turn auto looting back off if the outfit is being unequipped and we turned it on

elseif event == "OUTFIT_UNEQUIPPED" then
   if setting.EnableAutoLoot and setting.didSetAutoLoot then
       SetCVar("autoLootDefault", setting.savedAutoLoot)
       setting.didSetAutoLoot = nil
       setting.savedAutoLoot = nil
   end
 
   if setting.EnableFishTracking and setting.didSetTracking then
       Outfitter:SetTrackingByName(setting.savedTracking)
       setting.didSetTracking = nil
       setting.savedTracking = nil
   end
   
-- If the player is entering combat then unequip the outfit

elseif isEquipped and event == "PLAYER_REGEN_DISABLED" then
    equip = false
    immediate = true
    outfit.didCombatUnequip = true

-- If the outfit was unequipped because of combat
-- then put it back on when combat is over
 
elseif outfit.didCombatUnequip and (event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_ENTERING_WORLD") then
    equip = true
    outfit.didCombatUnequip = nil
end
]],
	},
	{
		Name = Outfitter.cDiningOutfit,
		ID = "Dining",
		Category = "TRADE",
		Script = Outfitter:GenerateSmartUnequipScript("DINING", Outfitter.cDiningOutfitDescription),
	},
	{
		Name = Outfitter.cCityOutfit,
		ID = "City",
		Category = "ENTERTAIN",
		Script = Outfitter:GenerateSimpleScript("CITY", Outfitter.cCityOutfitDescription),
	},
	{
		Name = Outfitter.cBattlegroundOutfit,
		ID = "Battleground",
		Category = "PVP",
		Script = Outfitter:GenerateSmartUnequipScript("BATTLEGROUND", Outfitter.cBattlegroundOutfitDescription),
	},
	{
		Name = Outfitter.cABOutfit,
		ID = "AB",
		Category = "PVP",
		Script = Outfitter:GenerateSmartUnequipScript("BATTLEGROUND_AB", Outfitter.cArathiBasinOutfitDescription),
	},
	{
		Name = Outfitter.cAVOutfit,
		ID = "AV",
		Category = "PVP",
		Script = Outfitter:GenerateSmartUnequipScript("BATTLEGROUND_AV", Outfitter.cAlteracValleyOutfitDescription),
	},
	{
		Name = Outfitter.cWSGOutfit,
		ID = "WSG",
		Category = "PVP",
		Script = Outfitter:GenerateSmartUnequipScript("BATTLEGROUND_WSG", Outfitter.cWarsongGulchOutfitDescription),
	},
	{
		Name = Outfitter.cEotSOutfit,
		ID = "EotS",
		Category = "PVP",
		Script = Outfitter:GenerateSmartUnequipScript("BATTLEGROUND_EOTS", Outfitter.cEotSOutfitDescription),
	},
	{
		Name = Outfitter.cSotAOutfit,
		ID = "SotA",
		Category = "PVP",
		Script = Outfitter:GenerateSmartUnequipScript("BATTLEGROUND_SOTA", Outfitter.cSotAOutfitDescription),
	},
	{
		Name = Outfitter.cIoCOutfit,
		ID = "IoC",
		Category = "PVP",
		Script = Outfitter:GenerateSmartUnequipScript("BATTLEGROUND_IOC", Outfitter.cIoCOutfitDescription),
	},
	{
		Name = Outfitter.cArenaOutfit,
		ID = "Arena",
		Category = "PVP",
		Script = Outfitter:GenerateSmartUnequipScript("BATTLEGROUND_ARENA", Outfitter.cArenaOutfitDescription),
	},
	{
		Name = "Spirit Regen",
		ID = "Spirit",
		Category = "GENERAL",
		Script = Outfitter:GenerateSmartUnequipScript("SPIRIT_REGEN", Outfitter.SpiritRegenOutfitDescription, 0.5),
	},
	{
		Name = Outfitter.cWarriorBattleStance,
		ID = "Battle",
		Class = "WARRIOR",
		Script = Outfitter:GenerateShapeshiftScript("BATTLE_STANCE", Outfitter.cWarriorBattleStanceDescription),
	},
	{
		Name = Outfitter.cWarriorDefensiveStance,
		ID = "Defensive",
		Class = "WARRIOR",
		Script = Outfitter:GenerateShapeshiftScript("DEFENSIVE_STANCE", Outfitter.cWarriorDefensiveStanceDescription),
	},
	{
		Name = Outfitter.cWarriorBerserkerStance,
		ID = "Berserker",
		Class = "WARRIOR",
		Script = Outfitter:GenerateShapeshiftScript("BERSERKER_STANCE", Outfitter.cWarriorBerserkerStanceDescription),
	},
	{
		Name = Outfitter.cDruidCasterForm,
		ID = "Caster",
		Class = "DRUID",
		Script = Outfitter:GenerateScriptHeader("CASTER_FORM NOT_CASTER_FORM OUTFIT_EQUIPPED", Outfitter.cDruidCasterFormDescription)..
[[
-- $SETTING DisableInstance={type="boolean", label="Don't equip in dungeons", default=false}
-- $SETTING DisableBG={type="boolean", label="Don't equip in Battlegrounds", default=false}
-- $SETTING DisablePVP={type="boolean", label="Don't equip while PvP flagged", default=false}

-- Just return if they're PvP'ing and don't want the outfit changing

local inInstance, instanceType = IsInInstance()

if (setting.DisableInstance and inInstance and (instanceType == "raid" or instanceType == "party"))
or (setting.DisableBG and Outfitter:InBattlegroundZone())
or (setting.DisablePVP and UnitIsPVP("player")) then
    return
end

-- Return if the user isn't in full control

if not Outfitter.IsDead and not HasFullControl() then
    return
end

-- If the user is manually equipping the outfit, let
-- Outfitter know which layer it's representing

if event == "OUTFIT_EQUIPPED" then
    layer = "shapeshift"

-- Equip and set the layer if entering caster form.  When
-- shifting directly between forms, WoW temporarily puts
-- the druid in caster form.  To avoid having the caster
-- outfit equip during those changes, a small delay is
-- added to equipping so it can be canceled when the form
-- shift completes.

elseif event == "CASTER_FORM" then
    equip = true
    layer = "shapeshift"
    delay = 0.1

-- Unequip if leaving caster form

elseif event == "NOT_CASTER_FORM" then
    if outfit.CategoryID ~= "Complete" then
        equip = false
    end
end
]],
	},
	{
		Name = Outfitter.cDruidBearForm,
		ID = "Bear",
		Class = "DRUID",
		Script = Outfitter:GenerateDruidShapeshiftScript("BEAR_FORM", "This outfit will be worn whenever you're in Bear or Dire Bear Form"),
	},
	{
		Name = Outfitter.cDruidCatForm,
		ID = "Cat",
		Class = "DRUID",
		Script = Outfitter:GenerateDruidShapeshiftScript("CAT_FORM", "This outfit will be worn whenever you're in Cat Form"),
	},
	{
		Name = Outfitter.cDruidAquaticForm,
		ID = "Aquatic",
		Class = "DRUID",
		Script = Outfitter:GenerateDruidShapeshiftScript("AQUATIC_FORM", "This outfit will be worn whenever you're in Aquatic Form"),
	},
	{
		Name = Outfitter.cDruidFlightForm,
		ID = "Flight",
		Class = "DRUID",
		Script = Outfitter:GenerateDruidShapeshiftScript("FLIGHT_FORM", "This outfit will be worn whenever you're in Flight or Swift Flight Form"),
	},
	{
		Name = Outfitter.cDruidTravelForm,
		ID = "Travel",
		Class = "DRUID",
		Script = Outfitter:GenerateDruidShapeshiftScript("TRAVEL_FORM", "This outfit will be worn whenever you're in Travel Form"),
	},
	{
		Name = Outfitter.cDruidMoonkinForm,
		ID = "Moonkin",
		Class = "DRUID",
		Script = Outfitter:GenerateDruidShapeshiftScript("MOONKIN_FORM", "This outfit will be worn whenever you're in Moonkin Form"),
	},
	{
		Name = Outfitter.cDruidTreeOfLifeForm,
		ID = "Tree",
		Class = "DRUID",
		Script = Outfitter:GenerateDruidShapeshiftScript("TREE_FORM", "This outfit will be worn whenever you're in Tree Form"),
	},
	{
		Name = Outfitter.cDruidProwl,
		ID = "Prowl",
		Class = "DRUID",
		Script = Outfitter:GenerateSimpleScript("STEALTH", "This outfit will be worn whenever you're prowling"),
	},
	{
		Name = Outfitter.cRogueStealth,
		ID = "Stealth",
		Class = "ROGUE",
		Script = Outfitter:GenerateEquipModule(Outfitter.ScriptModules.AutoLootOnEquip, pSettings,
		         Outfitter:GenerateEquipModule(Outfitter.ScriptModules.RogueStealth, pSettings,
		         "-- $DESC This outfit will be worn whenever you're stealthed"))
	},
	{
		Name = Outfitter.cPriestShadowform,
		ID = "Shadowform",
		Class = "PRIEST",
		Script = Outfitter:GenerateShapeshiftScript("SHADOWFORM", Outfitter.cPriestShadowformDescription, true),
	},
	{
		Name = Outfitter.cShamanGhostWolf,
		ID = "GhostWolf",
		Class = "SHAMAN",
		Script = Outfitter:GenerateSimpleScript("GHOST_WOLF", Outfitter.cShamanGhostWolfDescription),
	},
	{
		Name = Outfitter.cHunterMonkey,
		ID = "Monkey",
		Class = "HUNTER",
		Script = Outfitter:GenerateShapeshiftScript("MONKEY_ASPECT", Outfitter.cHunterMonkeyDescription),
	},
	{
		Name = Outfitter.cHunterHawk,
		ID = "Hawk",
		Class = "HUNTER",
		Script = Outfitter:GenerateShapeshiftScript("HAWK_ASPECT", Outfitter.cHunterHawkDescription),
	},
	{
		Name = Outfitter.cHunterCheetah,
		ID = "Cheetah",
		Class = "HUNTER",
		Script = Outfitter:GenerateShapeshiftScript("CHEETAH_ASPECT", Outfitter.cHunterCheetahDescription),
	},
	{
		Name = Outfitter.cHunterPack,
		ID = "Pack",
		Class = "HUNTER",
		Script = Outfitter:GenerateShapeshiftScript("PACK_ASPECT", Outfitter.cHunterPackDescription),
	},
	{
		Name = Outfitter.cHunterBeast,
		ID = "Beast",
		Class = "HUNTER",
		Script = Outfitter:GenerateShapeshiftScript("BEAST_ASPECT", Outfitter.cHunterBeastDescription),
	},
	{
		Name = Outfitter.cHunterWild,
		ID = "Wild",
		Class = "HUNTER",
		Script = Outfitter:GenerateShapeshiftScript("WILD_ASPECT", Outfitter.cHunterWildDescription),
	},
	{
		Name = Outfitter.cHunterViper,
		ID = "Viper",
		Class = "HUNTER",
		Script = Outfitter:GenerateShapeshiftScript("VIPER_ASPECT", Outfitter.cHunterViperDescription),
	},
	{
		Name = Outfitter.cHunterDragonhawk,
		ID = "Dragonhawk",
		Class = "HUNTER",
		Script = Outfitter:GenerateShapeshiftScript("DRAGONHAWK_ASPECT", Outfitter.cHunterDragonhawkDescription),
	},
	{
		Name = Outfitter.cHunterFeignDeath,
		ID = "Feigning",
		Class = "HUNTER",
		Script = Outfitter:GenerateSimpleScript("FEIGN_DEATH", Outfitter.cHunterFeignDeathDescription),
	},
	{
		Name = Outfitter.cMageEvocate,
		ID = "Evocate",
		Class = "MAGE",
		Script = Outfitter:GenerateSimpleScript("EVOCATE", Outfitter.cMageEvocateDescription),
	},
	{
		Name = Outfitter.cDeathknightBlood,
		ID = "Blood",
		Class = "DEATHKNIGHT",
		Script = Outfitter:GenerateSimpleScript("BLOOD", Outfitter.cDeathknightBloodDescription),
	},
	{
		Name = Outfitter.cDeathknightFrost,
		ID = "Frost",
		Class = "DEATHKNIGHT",
		Script = Outfitter:GenerateSimpleScript("FROST", Outfitter.cDeathknightFrostDescription),
	},
	{
		Name = Outfitter.cDeathknightUnholy,
		ID = "Unholy",
		Class = "DEATHKNIGHT",
		Script = Outfitter:GenerateSimpleScript("UNHOLY", Outfitter.cDeathknightUnholyDescription),
	},
	{
		Name = Outfitter.cSoloOutfit,
		ID = "SOLO",
		Category = "GENERAL",
		Script = Outfitter:GenerateScriptHeader("PLAYER_ENTERING_WORLD RAID_ROSTER_UPDATE PARTY_MEMBERS_CHANGED", Outfitter.cSoloOutfitDescription)..
[[
-- $SETTING EquipSolo={label="Equip when solo", type="boolean"}
-- $SETTING EquipGroup={label="Equip when in a party", type="boolean"}
-- $SETTING EquipRaid={label="Equip when in a raid", type="boolean"}

if setting.EquipSolo
and GetNumRaidMembers() == 0
and GetNumPartyMembers() == 0 then
    equip = true
elseif setting.EquipGroup
and GetNumRaidMembers() == 0
and GetNumPartyMembers() ~= 0 then
    equip = true
elseif setting.EquipRaid
and GetNumRaidMembers() ~= 0 then
    equip = true
elseif didEquip then
    equip = false
end
]],
	},
	{
		Name = Outfitter.cLowHealthOutfit,
		ID = "LOW_HEALTH",
		Category = "GENERAL",
		Script = Outfitter:GenerateScriptHeader("UNIT_HEALTH UNIT_MANA", Outfitter.cLowHealthDescription)..
[[
-- $SETTING Health="number"
-- $SETTING Mana="number"

if select(1, ...) == "player"
and (UnitHealth("player") < setting.Health
 or (UnitPowerType("player") == 0 and UnitPower("player") < setting.Mana)) then
   equip = true
elseif didEquip then
   equip = false
end
]],
	},
	{
		Name = Outfitter.cHasBuffOutfit,
		ID = "HAS_BUFF",
		Category = "GENERAL",
		Script = Outfitter:GenerateScriptHeader("UNIT_AURA PLAYER_ENTERING_WORLD", Outfitter.cHasBuffDescription)..
[[
-- $SETTING buffName = {type="string", label="Buff name"}
-- $SETTING DisableInstance={type="boolean", label="Don't equip in dungeons", default=false}
-- $SETTING DisableBG={type="boolean", label="Don't equip in Battlegrounds", default=false}
-- $SETTING DisablePVP={type="boolean", label="Don't equip while PvP flagged", default=false}

if select(1, ...) ~= "player" then return end

if UnitBuff("player", setting.buffName) then
    equip = true
end

-- Just return if they're PvP'ing and don't want the outfit changing

if equip then
	local inInstance, instanceType = IsInInstance()
    
	if (setting.DisableInstance and inInstance and (instanceType == "raid" or instanceType == "party"))
	or (setting.DisableBG and Outfitter:InBattlegroundZone())
	or (setting.DisablePVP and UnitIsPVP("player")) then
		return
	end
end

if equip == nil and didEquip then equip = false end
]],
	},
	{
		Name = Outfitter.cHasDebuffOutfit,
		ID = "HAS_DEBUFF",
		Category = "GENERAL",
		Script = Outfitter:GenerateScriptHeader("UNIT_AURA PLAYER_ENTERING_WORLD", Outfitter.cHasDebuffDescription)..
[[
-- $SETTING debuffName = {type="string", label="Debuff name"}
-- $SETTING DisableInstance={type="boolean", label="Don't equip in dungeons", default=false}
-- $SETTING DisableBG={type="boolean", label="Don't equip in Battlegrounds", default=false}
-- $SETTING DisablePVP={type="boolean", label="Don't equip while PvP flagged", default=false}

if select(1, ...) ~= "player" then return end

if UnitDebuff("player", setting.debuffName) then
    equip = true
end

-- Just return if they're PvP'ing and don't want the outfit changing

if equip then
	local inInstance, instanceType = IsInInstance()
    
	if (setting.DisableInstance and inInstance and (instanceType == "raid" or instanceType == "party"))
	or (setting.DisableBG and Outfitter:InBattlegroundZone())
	or (setting.DisablePVP and UnitIsPVP("player")) then
		return
	end
end

if equip == nil and didEquip then equip = false end
]],
	},
	{
		Name = "Equip on target",
		ID = "EQUIP_ON_TARGET",
		Category = "GENERAL",
		Script = Outfitter:GenerateScriptHeader("PLAYER_TARGET_CHANGED", "Equips the outfit when your target changes to the specified name")..
[[
-- $SETTING targetName = {type="string", label="Target name"}

-- Equip if it's the specified target
if UnitName("target"):lower() == setting.targetName:lower() then
    equip = true
end
]],
	},
	{
		Name = Outfitter.cFallingOutfit,
		ID = "FALLING",
		Category = "TRADE",
		Script = Outfitter:GenerateScriptHeader("TIMER", Outfitter.cFallingOutfitDescription)..
[[
if IsFalling() then
    equip = true
    delay = 5
elseif didEquip then
    equip = false
end
]],
	},
	{
		Name = Outfitter.cRestingOutfit,
		ID = "RESTING",
		CATEGORY = "TRADE",
		Script = Outfitter:GenerateScriptHeader("PLAYER_UPDATE_RESTING", Outfitter.cRestingOutfitDescription)..
[[
if IsResting() then
    equip = true
else
    equip = false
end
]]
	},
	{
		Name = Outfitter.cArgentTournamentOutfit,
		ID = "ARGENT_TOURNY",
		Category = "QUEST",
		Script = Outfitter:GenerateScriptHeader("GAMETOOLTIP_SHOW GAMETOOLTIP_HIDE UNIT_ENTERED_VEHICLE UNIT_EXITED_VEHICLE", Outfitter.cArgentTournamentOutfit)..
[[
if event == "GAMETOOLTIP_SHOW" then
	local unitGUID = UnitGUID("mouseover")
	
	if not unitGUID then
		return
	end
	
	local unitType = unitGUID:sub(5, 5)
	
	if unitType ~= "3" and unitType ~= "5" then
        return
    end
	
	local npcID = tonumber(unitGUID:sub(9, 12), 16)
	
	if not self.MountIDs then
		if UnitFactionGroup("player") == "Alliance" then
			self.MountIDs =
			{
				[33790] = "Stabled Exodar Elekk",
				[33793] = "Stabled Gnomeregan Mechanostrider",
				[33794] = "Stabled Darnassian Nightsaber",
				[33795] = "Stabled Ironforge Ram",
				[33800] = "Stabled Stormwind Steed",
				[33843] = "Stabled Quel'dorei Steed",
				[36557] = "Argent Warhorse"
			}
		else
			self.MountIDs =
			{
				[33791] = "Stabled Silvermoon Hawkstrider",
				[33792] = "Stabled Thunder Bluff Kodo",
				[33796] = "Stabled Darkspear Raptor",
				[33798] = "Stabled Forsaken Warhorse",
				[33799] = "Stabled Orgrimmar Wolf",
				[33842] = "Stabled Sunreaver Hawkstrider",
				[36558] = "Argent Battleworg"
			}
		end
		
		self.MountIDs[33870] = "Stabled Argent Warhorse"
		self.MountIDs[34125] = "Stabled Campaign Warhorse"
	end
	
	if self.MountIDs[npcID] then
        equip = true
    end
elseif event == "GAMETOOLTIP_HIDE"
and didEquip
and not UnitInVehicle("player") then
    equip = false
    self.unequipTime = time
    delay = 1 -- The tooltip disappears briefly when you click a mount, so wait a sec before unequipping
elseif event == "UNIT_ENTERED_VEHICLE"
and didUnequip
and self.unequipTime
and time - self.unequipTime < 3 then
    equip = true -- Cancel the unequip
elseif event == "UNIT_EXITED_VEHICLE"
and didEquip
and not UnitInVehicle("player") then
    equip = false
end
]],
	},
	{
		Name = Outfitter.cFlameLeviathanOutfit,
		ID = "FLAME_LEVIATHAN",
		Category = "QUEST",
		Script = Outfitter:GenerateScriptHeader("GAMETOOLTIP_SHOW GAMETOOLTIP_HIDE UNIT_ENTERED_VEHICLE UNIT_EXITED_VEHICLE PLAYER_REGEN_ENABLED", Outfitter.cFlameLeviathanOutfitDescription)..
[[
if event == "GAMETOOLTIP_SHOW" then
	local unitGUID = UnitGUID("mouseover")
	
	if not unitGUID
	or unitGUID:sub(5, 5) ~= "5" then
        return
    end
	
	local npcID = tonumber(unitGUID:sub(9, 12), 16)
	
	if not self.MountIDs then
		self.MountIDs =
		{
			[33060] = "Salvaged Siege Engine",
			[33109] = "Salvaged Demolisher",
			[33062] = "Salvaged Chopper",
		}
	end
	
	if self.MountIDs[npcID] then
        equip = true
    end
elseif event == "GAMETOOLTIP_HIDE"
and didEquip
and not UnitInVehicle("player") then
    equip = false
    self.unequipTime = time
    delay = 1 -- The tooltip disappears briefly when you click a mount, so wait a sec before unequipping
elseif event == "UNIT_ENTERED_VEHICLE"
and didUnequip
and self.unequipTime
and time - self.unequipTime < 3 then
    equip = true -- Cancel the unequip
elseif event == "UNIT_EXITED_VEHICLE"
and didEquip
and not Outfitter.InCombat then
    equip = false
elseif event == "PLAYER_REGEN_ENABLED"
and didEquip
and not UnitInVehicle("player") then
    equip = false
end
]],
	},
	{
		Name = Outfitter.cMultiphaseSurveyOutfit,
		ID = "MULTI_SURVEY",
		Category = "QUEST",
		Script =
[[
-- $EVENTS QUEST_LOG_UPDATE ZONE_CHANGED ZONE_CHANGED_NEW_AREA ZONE_CHANGED_INDOORS
-- $DESC Equips the outfit when you're on the Multiphase Survey quest and enter Nagrand, unequips when you complete the quest or leave Nagrand

if GetZoneText() == Outfitter.LZ["Nagrand"] then
	local vOnQuest, vCompleted = Outfitter:PlayerIsOnQuestID(11880)
	
    if vOnQuest and not vCompleted then
        equip = true
        delay = 5
    else
        equip = false -- Not on the quest or it's completed
    end
else
    equip = false -- Not in Nagrand
end
]],
	},
	{
		Name = Outfitter.cSpellcastOutfit,
		ID = "SPELLCAST",
		Category = "TRADE",
		Script =
[[
-- $EVENTS UNIT_SPELLCAST_START
-- $DESC Equips when you start casting the specified spell, unequips when you cast something else
-- $SETTING spell = {type = "string", label = "Spell"}
-- $SETTING dontWait = {type = "boolean", label = "Don't wait for spellcast to end"}

if select(1, ...) ~= "player" then return end

if strlower(select(2, ...)) == strlower(setting.spell) then
    equip = true
    if setting.dontWait then
        interrupt = true
    end
else
    equip = false
end
]],
	},
	{
		Name = "Dance on equip",
		ID = "DANCE",
		Category = "ENTERTAIN",
		Script =
[[
-- $EVENTS OUTFIT_EQUIPPED
-- $DESC Makes you dance when you equip the outfit

if event == "OUTFIT_EQUIPPED" then DoEmote("DANCE") end 
]],
	},
	{
		Name = "Summon pet on equip",
		ID = "COMPANION",
		Category = "ENTERTAIN",
		Script =
[[
-- $EVENTS OUTFIT_EQUIPPED
-- $DESC Summons a companion pet 2 seconds after the outfit is equipped
-- $SETTING pet = {type = "string", label = "Pet name"}

if not Outfitter:SummonCompanionByName(setting.pet, 2) then
    Outfitter:ErrorMessage("Couldn't find a pet named %s", setting.pet)
end
]],
	},
	{
		Name = Outfitter.LBI.Cooking,
		ID = "COOKING",
		Category = "TRADE",
		Script =
[[
-- $DESC Equips the outfit whenever your Cooking window is open
-- $EVENTS TRADE_SKILL_SHOW TRADE_SKILL_CLOSE

if event == "TRADE_SKILL_SHOW" then
    if GetTradeSkillLine() == Outfitter.LBI.Cooking then
        equip = true
    end
elseif event == "TRADE_SKILL_CLOSE" then
    if didEquip then
        equip = false
    end
elseif event == "TRADE_SKILL_UPDATE" then
    if GetTradeSkillLine() == Outfitter.LBI.Cooking then
        equip = true
    elseif didEquip then
        equip = false
    end
end
]],
	},
	{
		Name = "Championing",
		ID = "CHAMP",
		Category = "QUEST",
		Script =
[[
-- $EVENTS PLAYER_ENTERING_WORLD
-- $DESC Equips the outfit when you're in a 5 player level 80 instance

local name, type, difficulty, difficultyName = GetInstanceInfo()

if type == "party"
and (name == Outfitter.LZ["Trial of the Champion"]
or name == Outfitter.LZ["The Culling of Stratholme"]
or name == Outfitter.LZ["Halls of Lightning"]
or name == Outfitter.LZ["The Oculus"]
or name == Outfitter.LZ["Utgarde Pinnacle"]
or name == Outfitter.LZ["The Forge of Souls"]
or name == Outfitter.LZ["Pit of Saron"]
or name == Outfitter.LZ["Halls of Reflection"]
or (difficulty == 2
    and (name == Outfitter.LZ["Ahn'kahet: The Old Kingdom"]
      or name == Outfitter.LZ["Azjol-Nerub"]
      or name == Outfitter.LZ["Drak'Tharon Keep"]
      or name == Outfitter.LZ["Gundrak"]
      or name == Outfitter.LZ["Halls of Stone"]
      or name == Outfitter.LZ["The Nexus"]
      or name == Outfitter.LZ["Utgarde Keep"]
      or name == Outfitter.LZ["Violet Hold"]))) then
    equip = true
else
    equip = false
end 
]],
	},
}

Outfitter.cScriptCategoryOrder =
{
	GENERAL = 0,
	TRADE = 1,
	PVP = 2,
	QUEST = 3,
	ENTERTAIN = 4,
	CLASS = 5,
}

table.sort(
		Outfitter.PresetScripts,
		function (pItem1, pItem2)
			local vCategory1 = pItem1.Category or (pItem1.Class and "CLASS") or "GENERAL"
			local vCategory2 = pItem2.Category or (pItem2.Class and "CLASS") or "GENERAL"
			
			if vCategory1 ~= vCategory2 then
				if not vCategory1 then
					return true
				elseif not vCategory2 then
					return false
				else
					return Outfitter.cScriptCategoryOrder[vCategory1] < Outfitter.cScriptCategoryOrder[vCategory2]
				end
			elseif not pItem2.Name then
				return false
			elseif not pItem1.Name then
				return true
			else
				return pItem1.Name < pItem2.Name
			end
		end)

Outfitter.cScriptPrefix = [[
	return function (self, event, ...)
		local outfit = self.Outfit
		if outfit.Disabled or (outfit.CombatDisabled and (Outfitter.InCombat or Outfitter.MaybeInCombat)) then return end
		local equip, immediate, layer, delay, interrupt
		local didEquip, didUnequip, isEquipped = outfit.didEquip, outfit.didUnequip, Outfitter:WearingOutfit(outfit)
		local time, setting = GetTime(), outfit.ScriptSettings
		local run = Outfitter.Run
		if true then
]]

Outfitter.cScriptPrefixNumLines = string.gsub(Outfitter.cScriptPrefix, "[^\n]+", ""):len()

-- User's script will be inserted here

Outfitter.cScriptSuffix = [[
		end -- This 'if true then end' just makes for clearer error messages
		self:PostProcess(equip, immediate, layer, delay, interrupt, time)
	end
]]

Outfitter.cInputPrefix = "return {"
Outfitter.cInputSuffix = "}"

function Outfitter:ParseScriptFields(pScript)
	local vSettings = {}
	local vMessage
	
	for vSetting, vValue in string.gmatch(pScript, "--%s*$([%w_]+)([^\r\n]*)") do
		vSetting = string.upper(vSetting)
		
		if vSetting == "EVENTS" then
			if not vSettings.Events then
				vSettings.Events = vValue
			else
				vSettings.Events = vSettings.Events.." "..vValue
			end
			
		elseif vSetting == "DESC" then
			vSettings.Description = vValue
		
		elseif vSetting == "SETTING" then
			local vScript = Outfitter.cInputPrefix..vValue..Outfitter.cInputSuffix
			
			local vScriptInputs, vMessage = loadstring(vScript, vValue)
			
			if not vScriptInputs then
				return nil, vMessage
			end
			
			vScriptInputs = vScriptInputs()
			
			if not vSettings.Inputs then
				vSettings.Inputs = {}
			end
			
			for vKey, vValue in pairs(vScriptInputs) do
				if type(vValue) == "string" then
					vValue = {Type = vValue:lower(), Label = vKey}
					
					if vValue.Type ~= "boolean" then
						vValue.Label = vValue.Label..":"
					end
				elseif type(vValue) == "table" then
					vValue.Type = (vValue.Type or vValue.type):lower()
					vValue.Label = vValue.Label or vValue.label
					vValue.Default = vValue.Default or vValue.default
					vValue.ZoneType = vValue.ZoneType or vValue.zonetype
				end
				
				vValue.Field = vKey
				table.insert(vSettings.Inputs, vValue)
			end
		end
	end
	
	return vSettings
end

function Outfitter:ActivateScript(pOutfit)
	pOutfit.LastScriptTime = nil
	pOutfit.ScriptLockupCount = 0
	
	local vScript = Outfitter:GetScript(pOutfit)
	
	if self.Settings.Options.DisableAutoSwitch
	or pOutfit.Disabled
	or not vScript then
		return
	end
	
	local vScriptFields = Outfitter:ParseScriptFields(vScript)
	local vScriptSettings = {}
	
	if not vScriptFields then
		return
	end
	
	if not vScriptFields.Events then
		Outfitter:ErrorMessage("The script for %s does not specify any events", pOutfit:GetName())
		return
	end
	
	-- Initialize the settings to their defaults
	
	if not pOutfit.ScriptSettings then
		pOutfit.ScriptSettings = {}
	end
	
	if vScriptFields.Inputs then
		for _, vDescriptor in ipairs(vScriptFields.Inputs) do
			local vDefault = vDescriptor.Default
			
			if vDefault == nil then
				local vType = vDescriptor.Type:lower()
				local vTypeInfo = Outfitter.SettingTypeInfo[vType]
				
				if not vTypeInfo then
					Outfitter:ErrorMessage("Script for outfit %s has an unknown $SETTING type (%s)", pOutfit:GetName(), vDescriptor.Type or "nil")
					return
				end
				
				vDefault = vTypeInfo.Default -- Override the built-in default if the $SETTING specifies its own default
			end
			
			-- Set to the default if the value is missing or if
			-- it's the wrong type
			
			if pOutfit.ScriptSettings[vDescriptor.Field] == nil
			or type(pOutfit.ScriptSettings[vDescriptor.Field]) ~= type(vDefault) then	
				pOutfit.ScriptSettings[vDescriptor.Field] = vDefault
			end
		end
	end
	
	local vScriptContext, vErrorMessage = Outfitter._ScriptContext:NewContext(pOutfit, vScript)
	
	if not vScriptContext then
		Outfitter:ErrorMessage("Couldn't activate script for %s", pOutfit:GetName())
		Outfitter:ErrorMessage(vErrorMessage)
		return
	end
	
	Outfitter.ScriptContexts[pOutfit] = vScriptContext
	
	for vEventID in string.gmatch(vScriptFields.Events, "([%w%d_]+)") do
		vScriptContext:RegisterEvent(vEventID)
	end
	
	self:DispatchOutfitEvent("INITIALIZE", pOutfit:GetName(), pOutfit)
end

function Outfitter:DeactivateScript(pOutfit)
	self:DispatchOutfitEvent("TERMINATE", pOutfit:GetName(), pOutfit)
	
	if Outfitter.ScriptContexts[pOutfit] then
		Outfitter.ScriptContexts[pOutfit]:UnregisterAllEvents()
		Outfitter.ScriptContexts[pOutfit] = nil
	end
end

function Outfitter:OutfitHasScript(pOutfit)
	return  pOutfit.ScriptID ~= nil or pOutfit.Script ~= nil
end

function Outfitter:GetScriptDescription(pScript)
	if not pScript then
		return
	end
	
	local vScriptFields = Outfitter:ParseScriptFields(pScript)
	
	if not vScriptFields then
		return
	end
	
	return vScriptFields.Description
end

function Outfitter:ScriptHasSettings(pScript)
	if not pScript then
		return
	end
	
	local vScriptFields = Outfitter:ParseScriptFields(pScript)
	
	if not vScriptFields then
		return
	end
	
	return vScriptFields.Inputs ~= nil and #vScriptFields.Inputs ~= 0
end

function Outfitter:ActivateAllScripts()
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vOutfitIndex, vOutfit in ipairs(vOutfits) do
			self:ActivateScript(vOutfit)
		end
	end
end

function Outfitter:DeactivateAllScripts()
	for vCategoryID, vOutfits in pairs(self.Settings.Outfits) do
		for vOutfitIndex, vOutfit in ipairs(vOutfits) do
			self:DeactivateScript(vOutfit)
		end
	end
end

function Outfitter:GetPresetScriptByID(pID)
	for _, vPresetScript in ipairs(Outfitter.PresetScripts) do
		if vPresetScript.ID == pID then
			return vPresetScript
		end
	end
end

function Outfitter:FindMatchingPresetScriptID(pScript)
	for _, vPresetScript in ipairs(Outfitter.PresetScripts) do
		if vPresetScript.Script == pScript then
			return vPresetScript.ID
		end
	end
end

----------------------------------------
Outfitter._ScriptContext = {}
----------------------------------------

function Outfitter._ScriptContext:NewContext(pOutfit, pScript)
	local vFunction, vMessage = loadstring(Outfitter.cScriptPrefix..pScript..Outfitter.cScriptSuffix, "Outfit Script")
	
	if not vFunction then
		return nil, vMessage
	end
	
	vFunction = vFunction()
	
	return Outfitter:New(self, pOutfit, vFunction)
end

function Outfitter._ScriptContext:Construct(pOutfit, pFunction)
	self.Outfit = pOutfit
	self.Function = pFunction
	
	if not pFunction then
		Outfitter:ErrorMessage("Internal error: Attempting to create a script context with a nil function")
	end
end

function Outfitter._ScriptContext:RegisterEvent(pEventID)
	if pEventID == "OUTFIT_EQUIPPED"
	or pEventID == "OUTFIT_UNEQUIPPED" then
		if not Outfitter.OutfitScriptEvents[pEventID] then
			Outfitter.OutfitScriptEvents[pEventID] = {}
		end
		
		Outfitter.OutfitScriptEvents[pEventID][self.Outfit] = self
	else
		Outfitter.EventLib:RegisterEvent(pEventID, self.Function, self)
	end
end

function Outfitter._ScriptContext:UnregisterEvent(pEventID)
	if pEventID == "OUTFIT_EQUIPPED"
	or pEventID == "OUTFIT_UNEQUIPPED" then
		Outfitter.OutfitScriptEvents[pEventID][self.Outfit] = nil
	else
		Outfitter.EventLib:UnregisterEvent(pEventID, self.Function, self)
	end
end

function Outfitter._ScriptContext:UnregisterAllEvents(pEventID)
	for vEventID, vOutfits in pairs(Outfitter.OutfitScriptEvents) do
		vOutfits[self.Outfit] = nil
	end
	
	Outfitter.EventLib:UnregisterAllEvents(self.Function, self)
end

function Outfitter._ScriptContext:Debug(pFormat, ...)
	Outfitter:NoteMessage("["..self.Outfit:GetName().."] "..pFormat, ...)
end

function Outfitter._ScriptContext:PostProcess(pEquip, pImmediate, pLayer, pDelay, pInterrupt, pStartTime)
	-- If the script took a long time to run and it hasn't been very long since
	-- the last time we'll increment a counter.  If that counters gets too high
	-- we can assume the script is misbehaving and shut it down
	
	local vTime = GetTime()
	
	if vTime - pStartTime > 0.1
	and self.Outfit.LastScriptTime
	and pStartTime - self.LastScriptTime < 0.5 then
		if not self.ScriptLockupCount then
			self.ScriptLockupCount = 1
		else
			self.ScriptLockupCount = self.ScriptLockupCount + 1
			
			if self.ScriptLockupCount > 20 then
				Outfitter:ErrorMessage("Excessive CPU time in script for %s, script deactivated.", self.Outfit:GetName() or "<unnamed>")
				Outfitter:DeactivateScript(self.Outfit)
			end
		end
	else
		self.ScriptLockupCount = 0
	end
	
	self.LastScriptTime = pStartTime
	
	--
	
	if pEquip ~= nil then
		local vChanged
		
		Outfitter:BeginEquipmentUpdate()
		
		if pEquip then
			if not Outfitter:WearingOutfit(self.Outfit)
			or self.Outfit.CategoryID == "Complete" then -- Always equip Completes so that the stack clears
				Outfitter:WearOutfit(self.Outfit, pLayer, true)
				vChanged = true
			end
		else
			if Outfitter:WearingOutfit(self.Outfit) then
				Outfitter:RemoveOutfit(self.Outfit, true)
				vChanged = true
			end
		end
		
		-- Allow casting to be interrupted if requested
		
		if pInterrupt then
			Outfitter.InterruptCasting = true
		end
		
		-- Adjust the last equipped time to cause a delay if requested
		
		if vChanged and pDelay then
			Outfitter:SetUpdateDelay(pStartTime, pDelay)
		end
		
		Outfitter:EndEquipmentUpdate(nil, pImmediate)
	elseif pLayer then
		Outfitter:TagOutfitLayer(self.Outfit, pLayer)
	end
end
