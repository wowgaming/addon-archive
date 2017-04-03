
---------------
-- Range Widget
---------------


local DebuffWatcher = CreateFrame("Frame")
local CombatEvents = {}

function CombatEvents.SPELL_AURA_APPLIED(...)
	local sourceGUID,sourceName,sourceFlags,destGUID,destName,destFlags = ...
	print("SPELL_AURA_APPLIED", destName)
end

function CombatEvents.SPELL_AURA_REFRESH(...)
	local sourceGUID,sourceName,sourceFlags,destGUID,destName,destFlags = ...
	print("SPELL_AURA_REFRESH", destName)
end

function CombatEvents.SPELL_AURA_APPLIED_DOSE(...)
	local sourceGUID,sourceName,sourceFlags,destGUID,destName,destFlags = ...
	print("SPELL_AURA_APPLIED_DOSE", destName)
end
function CombatEvents.SPELL_AURA_REMOVED(...)
	local sourceGUID,sourceName,sourceFlags,destGUID,destName,destFlags = ...
	print("SPELL_AURA_REMOVED", destName)
end

local function CheckDebuffs(frame, event, timestamp, combatEvent, ...)
	if CombatEvents[combatEvent] then CombatEvents[combatEvent](...) end
end

local usingDebuffWidget = false
local function ActivateDebuffWidget()
	--[[
	if usingDebuffWidget then 
		if (UnitInRaid("player") or UnitInParty("player")) then 
			DebuffWatcher:SetScript("OnEvent", CheckDebuffs)
		else DebuffWatcher:SetScript("OnEvent", nil) end	
	end
	--]]
end

--DebuffWatcher:SetScript("OnEvent", CheckDebuffs)

DebuffWatcher:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

--DebuffWatcher:RegisterEvent("UNIT_AURA")
--DebuffWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
--DebuffWatcher:RegisterEvent("RAID_ROSTER_UPDATE")
--DebuffWatcher:RegisterEvent("PARTY_MEMBERS_CHANGED")
--DebuffWatcher:RegisterEvent("PARTY_CONVERTED_TO_RAID")

-- Offset 10px vertical for centering on Neon

-- Use for prototype
local art = {
	FIRE = "Interface\\Addons\\TidyPlates\\Widgets\\BossDebuffWidget\\Fire",
	ICE = "Interface\\Addons\\TidyPlates\\Widgets\\BossDebuffWidget\\Ice",
	GREEN = "Interface\\Addons\\TidyPlates\\Widgets\\BossDebuffWidget\\Green",
	BOMB = "Interface\\Addons\\TidyPlates\\Widgets\\BossDebuffWidget\\Bomb",
	SKULLS = "Interface\\Addons\\TidyPlates\\Widgets\\BossDebuffWidget\\Skulls",
}

local function UpdateBossDebuffWidget(self, unit)
			self.Texture:SetTexture(art.FIRE)
			self:Show()
	--[[
		if unit.reaction == "FRIENDLY" then --and unit.type == "PLAYER" then 
			self.Texture:SetTexture(art.FIRE)
			self:Show()
		else self:Hide() end
	--]]
		
end



local function CreateBossDebuffWidget(parent)
	if not usingDebuffWidget then usingDebuffWidget = true; ActivateDebuffWidget() end
	
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(16); frame:SetHeight(16)
	-- Image
	frame.Texture = frame:CreateTexture(nil, "OVERLAY")
	frame.Texture:SetPoint("CENTER")
	frame.Texture:SetWidth(150)
	frame.Texture:SetHeight(150)
	-- Vars and Mech
	frame:Hide()
	frame.Update = UpdateBossDebuffWidget
	return frame
end

TidyPlatesWidgets.CreateBossDebuffWidget = CreateBossDebuffWidget