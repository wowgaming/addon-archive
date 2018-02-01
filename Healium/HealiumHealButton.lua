function Healium_HealButton_OnLoad(self)
	self.TimeSinceLastUpdate = 0
	self:RegisterEvent("SPELL_UPDATE_USABLE")
	self:RegisterForDrag("LeftButton")
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
end

function Healium_HealButton_OnUpdate(self, elapsed)
--	if ( (not HealiumActive) or (not Healium.DoRangeChecks) ) then return 0 end 
	if ( not Healium.DoRangeChecks ) then return 0 end 	
	self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed 	

	if (self.TimeSinceLastUpdate > Healium.RangeCheckPeriod) then
		Healium_RangeCheckButton(self)
		self.TimeSinceLastUpdate = 0
	end
end

function Healium_HealButton_OnEnter(frame, motion)
    GameTooltip:SetOwner(frame, "ANCHOR_RIGHT", -30, 5)
    if (frame.id) then
		if (not Healium.ShowToolTips) then return end	
		GameTooltip_SetDefaultAnchor(GameTooltip, frame)
		GameTooltip:SetSpell(frame.id, SpellBookFrame.bookType)
		local unit = frame:GetParent().TargetUnit
		if not UnitExists(unit) then return end
		local Name = UnitName(unit)
		if (not Name) then Name = "-" end
        GameTooltip:AddLine("Target: |cFF00FF00"..Name,1,1,1)

--		if (Debug) then 
--			local texture = frame.icon:GetTexture() or "(nil)"
--			GameTooltip:AddLine("ID= ".. frame.id .. "|nTexture=" .. texture) 
--		end
--        GameTooltip:AddLine(Healium_AddonColor.. "---- " .. Healium_AddonName .. " button ----",1,1,1)		  
		GameTooltip:Show()		
	else
		-- Safely Handle Empty Buttons	
		GameTooltip:SetText("|cFFFFFFFFNo Spell|n|cFF00FF00You may drag-and-drop a spell from your|nspellbook onto this button, or you may go|nto Interface, Addons, " ..Healium_AddonName .. " and|nselect your spells from the list.")
		GameTooltip:Show()		
    end
end

function Healium_HealButton_OnLeave()
	GameTooltip:Hide()
end

function Healium_HealButton_OnEvent(self, event)
	if (not self.id) then return 0 end   
	
	if event == "SPELL_UPDATE_USABLE" then
		Healium_RangeCheckButton(self)
	end
end

local function Drag(self)
	if CursorHasSpell() then
		local infoType, info1, info2 = GetCursorInfo()
		if infoType == "spell" then 
			if InCombatLockdown() then
				Healium_Warn("Can't update button while in combat")
				return
			end
			
			if (self.index > 0) and (self.index <= Healium_MaxButtons) then
				local spellName = GetSpellName(info1, BOOKTYPE_SPELL )		
				if IsPassiveSpell(info1, BOOKTYPE_SPELL) then
					local link = GetSpellLink(info1, BOOKTYPE_SPELL)
					Healium_Warn(link .. " is a passive spell and cannot be used in " .. Healium_AddonName)
					return
				end
				local name, rank, icon = GetSpellInfo(spellName)
				local Profile = Healium_GetProfile()
				local OldSpellName = Profile.SpellNames[self.index]
				Profile.SpellNames[self.index] = name
				Profile.SpellIcons[self.index] = icon
				UIDropDownMenu_SetText(HealiumDropDown[self.index], Profile.SpellNames[self.index])
				
				Healium_UpdateButtonSpells()
				Healium_UpdateButtonIcons()				
				Healium_UpdateButtonCooldownsByColumn(self.index)	
				
				ClearCursor()

				-- if shift is held down put old spell on cursor
				if IsShiftKeyDown() and (OldSpellName ~= nil) then
					PickupSpell(OldSpellName)
				end
			end
		else
			Healium_DebugPrint("CursorHasSpell() returned true but infoType was not a spell")		
		end
	else
		Healium_DebugPrint("Button received a drag but did not have a spell")
	end
end 
-- drag stop
function Healium_HealButton_OnReceiveDrag(self)
	Healium_DebugPrint("Healium_HealButton_OnReceiveDrag() called")
	Drag(self, nil)
end

-- drag start
function Healium_HealButton_OnDragStart(self)
	-- starting drag requires shift to be pressed
	if IsShiftKeyDown() == nil then return end
	
	local Profile = Healium_GetProfile()
	
	if (self.index > 0) and (self.index <= Healium_MaxButtons) then	
		PickupSpell(Profile.SpellNames[self.index])
	end
end

function Healium_HealButton_PreClick(self)
	Healium_DebugPrint("Healium_HealButton_PreClick() called")

	if CursorHasSpell() then
		local info, spellid = GetCursorInfo()
		self.dragspellid = spellid
	else
		self.dragspellid = nil
	end
end

function Healium_HealButton_PostClick(self)
	Healium_DebugPrint("Healium_HealButton_PostClick() called")

	if self.dragspellid then
		PickupSpell(self.dragspellid, BOOKTYPE_SPELL)
		Drag(self)
		self.dragspellid = nil
	end
end
