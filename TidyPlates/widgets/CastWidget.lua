
---------------------------------------------------------------------
-- Event Watcher
---------------------------------------------------------------------

local function SpellCastWatcherEvents(self, event, unit, other)
	print("Spell Event", self, event, unit, other)
	if unit == "target" then TidyPlates:ForceUpdate() end
end

local SpellCastWatcher = CreateFrame("Frame")
SpellCastWatcher:RegisterEvent("UNIT_SPELLCAST_START")
SpellCastWatcher:RegisterEvent("UNIT_SPELLCAST_STOP")
--SpellCastWatcher:SetScript("OnEvent", SpellCastWatcherEvents)

---------------------------------------------------------------------
-- Spell Cast Widget
---------------------------------------------------------------------
local function UpdateCastWidget(self, unit)
	if unit.isTarget then
		local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo("target") 
		if spell then --and unit.type == "PLAYER" then 
			self.Text:SetText(spell)
			self:Show()
		else self:Hide() end
	else self:Hide() end

end

local function CreateCastWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(16); frame:SetHeight(16)
	-- Image
	frame.Texture = frame:CreateTexture(nil, "OVERLAY")
	frame.Texture:SetPoint("CENTER")
	frame.Texture:SetWidth(256)
	frame.Texture:SetHeight(64)
	frame.Texture:SetTexture(art)
	
	
	-- Target Text
	frame.Text = frame:CreateFontString(nil, "OVERLAY")
	frame.Text:SetFont(notefont, 14, "None")

	frame.Text:SetPoint("CENTER", 0, 7)
	frame.Text:SetShadowOffset(1, -1)
	frame.Text:SetShadowColor(0,0,0,1)
	frame.Text:SetWidth(260)
	frame.Text:SetHeight(40)
	--frame.Text:SetText("|cFFFFC600Priority Kill |n |cFF80491C High Damage Caster")
		
		
		
	-- Vars and Mech
	frame:Hide()
	frame.Update = UpdateCastWidget
	return frame
end

TidyPlatesWidgets.UpdateCastWidget = UpdateCastWidget






--[[


NOTES:


UNIT_SPELLCAST_CHANNEL_START	Fires when a unit starts channeling a spell
UNIT_SPELLCAST_CHANNEL_STOP	Fires when a unit stops or cancels a channeled spell
UNIT_SPELLCAST_CHANNEL_UPDATE	Fires when a unit's channeled spell is interrupted or delayed
UNIT_SPELLCAST_DELAYED	Fires when a unit's spell cast is delayed
UNIT_SPELLCAST_FAILED	Fires when a unit's spell cast fails
UNIT_SPELLCAST_FAILED_QUIET	Fires when a unit's spell cast fails and no error message should be displayed
UNIT_SPELLCAST_INTERRUPTED	Fires when a unit's spell cast is interrupted
UNIT_SPELLCAST_INTERRUPTIBLE	Fires when a unit's spell cast becomes interruptible again
UNIT_SPELLCAST_NOT_INTERRUPTIBLE	Fires when a unit's spell cast becomes uninterruptible
UNIT_SPELLCAST_SENT	Fires when a request to cast a spell (on behalf of the player or a unit controlled by the player) is sent to the server
UNIT_SPELLCAST_START	Fires when a unit begins casting a spell
UNIT_SPELLCAST_STOP	Fires when a unit stops or cancels casting a spell
UNIT_SPELLCAST_SUCCEEDED

TidyPlates:Update()

* NEW spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo("unit") 
* NEW spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo("unit") 

Event Watcher only needs to watch for events that happen to the current target, for the moment.

--]]






