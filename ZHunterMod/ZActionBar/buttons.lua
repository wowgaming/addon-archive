local pairs = pairs

local funcs = {}

funcs.SetSpell = function(button, spellId)
	local spellName = GetSpellInfo(spellId)
	local texture = GetSpellTexture(spellName)
	if texture then
		button:SetTexture(texture)
		button:SetAttribute("spell", spellName)
		button.isUsed = 1
		button.spellId = spellId
		button.spellName = spellName
		ZActionBar_EnableButton(button)
		return 1
	end
	button.isUsed = nil
end

funcs.SetTexture = function(button, texture)
	if not texture then return end
	button.lastTexture = texture
	if button.parent.roundButton then
		SetPortraitToTexture(button.icon, texture)
	else
		button.icon:SetTexture(texture)
	end
end

local function OnEnter(self)
	if not self.isUsed or not self.spellName then return end
	if not self.parent.tooltip then return end
	local index = 1
	local found = false
	if GetSpellName(self.lookupStart, BOOKTYPE_SPELL) == self.spellName then
		index = self.lookupStart + 1
		found = true
	end
	while true do
		local spellName = GetSpellName(index, BOOKTYPE_SPELL)
		if not spellName then
			break
		elseif spellName == self.spellName then
			found = true
		elseif found then
			self.lookupStart = index - 1
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetSpell(self.lookupStart, BOOKTYPE_SPELL)
			if self:GetID() == 1 then
				GameTooltip:AddLine("Hold ALT to drag this button.", 0, 1, 1)
				GameTooltip:Show()
			end
			break
		end
		index = index + 1
	end
end

local function OnLeave()
	GameTooltip:Hide()
end

local function OnEvent(self, event)
	if not self.isUsed then return end
	local start, duration, enable = GetSpellCooldown(self.spellName)
	if type(start) == "number" and type(duration) == "number" and type(enable) == "number" then
		CooldownFrame_SetTimer(self.cooldown, start, duration, enable)
	end
end

function ZActionBar_AddButton(bar)
	local id = bar.numButtons + 1
	local buttonName = bar.name .. id
	local button = CreateFrame("Button", buttonName, bar.header, "ZActionBarButtonTemplate")
	button:SetID(id)
	button.parent = bar
	if id == 1 then
		ZActionBar_SetupFirstButton(button)
	end
	bar.button[id] = button
	bar.numButtons = id
	ZActionBar_LinkButton(bar, button)
	ZActionBar_AddButtonOptions(bar, id)
	return button
end

function ZActionBar_Button_OnLoad(button)
	local buttonName = button:GetName()
	button.icon = getglobal(buttonName.."Icon")
	button.background = getglobal(buttonName.."Background")
	button.cooldown = getglobal(buttonName.."Cooldown")
	button.UpdateTooltip = OnEnter
	button:SetScript("OnEnter", OnEnter)
	button:SetScript("OnLeave", OnLeave)
	button:SetScript("OnEvent", OnEvent)
	button:SetAttribute("*type1", "spell")
	button:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	for i, v in pairs(funcs) do
		button[i] = v
	end
	button.lookupStart = 1
end