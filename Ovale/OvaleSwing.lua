--[[
	Copyright (C) 2006-2007 Nymbia

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License along
	with this program; if not, write to the Free Software Foundation, Inc.,
	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
	
	Modifed for Ovale
]]

--[[ Not useful anymore 

local autoshotname = GetSpellInfo(75)
local resetspells = {
	[GetSpellInfo(845)] = true, -- Cleave
	[GetSpellInfo(78)] = true, -- Heroic Strike
	[GetSpellInfo(6807)] = true, -- Maul
	[GetSpellInfo(2973)] = true, -- Raptor Strike
}
local delayspells = {
	[GetSpellInfo(1464)] = true, -- Slam
}
local resetautoshotspells = {
}
local _, playerclass = UnitClass('player')
local unpack = unpack
local math_abs = math.abs
local GetTime = GetTime

OvaleSwing = LibStub("AceAddon-3.0"):NewAddon("OvaleSwing", "AceEvent-3.0")

OvaleSwing.swingmode=nil -- nil is none, 0 is meleeing, 1 is autoshooting
OvaleSwing.starttime=0
OvaleSwing.duration=0
OvaleSwing.startdelay=0

local BOOKTYPE_SPELL = BOOKTYPE_SPELL

function OvaleSwing:OnEnable()
	-- fired when autoattack is enabled/disabled.
	self:RegisterEvent("PLAYER_ENTER_COMBAT")
	self:RegisterEvent("PLAYER_LEAVE_COMBAT")
	-- fired when autoshot (or autowand) is enabled/disabled
	self:RegisterEvent("START_AUTOREPEAT_SPELL")
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL")
	
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	
	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_INTERRUPTED")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
	
	self:RegisterEvent("UNIT_ATTACK")
end

function OvaleSwing:OnDisable()
end

function OvaleSwing:PLAYER_ENTER_COMBAT()
	local _,_,offhandlow, offhandhigh = UnitDamage('player')
	if math_abs(offhandlow - offhandhigh) <= 0.1 or playerclass == "DRUID" then
		self.swingmode = 0 -- shouldn't be dual-wielding
	end
end

function OvaleSwing:PLAYER_LEAVE_COMBAT()
	if not self.swingmode or self.swingmode == 0 then
		self.swingmode = nil
	end
end

function OvaleSwing:START_AUTOREPEAT_SPELL()
	self.swingmode = 1
end

function OvaleSwing:STOP_AUTOREPEAT_SPELL()
	if not self.swingmode or self.swingmode == 1 then
		self.swingmode = nil
	end
end

-- blizzard screws that global up, double usage in CombatLog.lua and GlobalStrings.lua, so we create it ourselves
local COMBATLOG_FILTER_ME = bit.bor(
				COMBATLOG_OBJECT_AFFILIATION_MINE or 0x00000001,
				COMBATLOG_OBJECT_REACTION_FRIENDLY or 0x00000010,
				COMBATLOG_OBJECT_CONTROL_PLAYER or 0x00000100,
				COMBATLOG_OBJECT_TYPE_PLAYER or 0x00000400
				)

do
	local swordspecproc = false
	function OvaleSwing:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, srcGUID, srcName, srcFlags, dstName, dstGUID, dstFlags, ...)
		if (event == "SPELL_EXTRA_ATTACKS") and (select(2, ...) == "Sword Specialization") 
				and (bit.band(srcFlags, COMBATLOG_FILTER_ME) == COMBATLOG_FILTER_ME) then
			swordspecproc = true
		elseif (event == "SWING_DAMAGE" or event == "SWING_MISSED") 
				and (bit.band(srcFlags, COMBATLOG_FILTER_ME) == COMBATLOG_FILTER_ME) 
				and self.swingmode == 0 then
			if (swordspecproc) then
				swordspecproc = false
			else
				self:MeleeSwing()
			end
		end
	end
end

function OvaleSwing:UNIT_SPELLCAST_START(unit, spell)
	if self.swingmode == 0 then
		if delayspells[spell] then
			self.startdelay = GetTime()
		end
	end
end

function OvaleSwing:UNIT_SPELLCAST_INTERRUPTED(unit, spell)
	if self.swingmode == 0 then
		if delayspells[spell] then
			self.duration = self.duration + GetTime() - self.startdelay
		end
	end
end

function OvaleSwing:UNIT_SPELLCAST_SUCCEEDED(unit, spell)
	if self.swingmode == 0 then
		if resetspells[spell] then
			self:MeleeSwing()
		end
		if delayspells[spell] then
			self.duration = self.duration + 
		end
	elseif self.swingmode == 1 then
		if spell == autoshotname then
			self:Shoot()
		end
	end
	if resetautoshotspells[spell] then
		self.swingmode = 1
		self:Shoot()
	end
end

function OvaleSwing:UNIT_ATTACK(unit)
	if unit == 'player' then
		if not self.swingmode then
			return
		elseif self.swingmode == 0 then
			self.duration = UnitAttackSpeed('player')
		else
			self.duration = UnitRangedDamage('player')
		end
	end
end

function OvaleSwing:MeleeSwing()
	self.duration = UnitAttackSpeed('player')
	self.starttime = GetTime()
end

function OvaleSwing:Shoot()
	self.duration = UnitRangedDamage('player')
	self.starttime = GetTime()
end
]]
