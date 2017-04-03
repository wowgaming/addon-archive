local BS = LibStub("LibBabble-Spell-3.0"):GetLookupTable()

function ZAutoShot_Start(self, arg2)
	local spd, min, max = UnitRangedDamage("player")
	min = GetTime()
	if arg2 == BS["Feign Death"] then
		spd = ZAutoShot_GetUnmodifiedSpeed() or spd
	end
	max = min + spd
	spd = format("%0.1f", spd)
	self.text:SetText(spd)
	self:SetMinMaxValues(min, max)
	self:SetValue(min)
	if self.casting then
		self:Show()
	end
end

function ZAutoShot_OnEvent(self, event, arg1, arg2)
	if event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" then
		if not ZHunterMod_Saved["ZAutoShot"]["on"] then return end
		if arg2 == BS["Auto Shot"] or arg2 == BS["Feign Death"] then
			ZAutoShot_Start(self, arg2)
		end
	elseif event == "START_AUTOREPEAT_SPELL" then
		if not ZHunterMod_Saved["ZAutoShot"]["on"] then return end
		self:Show()
		self.casting = true
	elseif event == "STOP_AUTOREPEAT_SPELL" or event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGIN" then
		self:Hide()
		self.casting = false
	end
end

function ZAutoShot_OnLoad(self)
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("START_AUTOREPEAT_SPELL")
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL")
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetMinMaxValues(0,1)
	self:SetValue(1)
	self.spark = ZAutoShotBarSpark
	self.text = ZAutoShotBarTextRight
	ZAutoShotBarTextLeft:SetText(BS["Auto Shot"])
end

function ZAutoShot_OnUpdate(self)
	local min, max = self:GetMinMaxValues()
	local val = GetTime()
	if val > max then
		val = max
	end
	self:SetValue(val)
	local pos = ((val - min) / (max - min)) * 195
	self.spark:SetPoint("CENTER", ZAutoShotBar, "LEFT", pos, 0)
	val = max - val
	val = format("%0.1f", val)
	self.text:SetText(val)
end

function ZAutoShot_GetUnmodifiedSpeed()
	local text, _, spd
	ZAutoShotTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	ZAutoShotTooltip:SetInventoryItem("player", 18)
	for i=1, 10 do
		local text = getglobal("ZAutoShotTooltipTextRight"..i)
		if text and text:IsVisible() then
			_, _, spd = string.find(text:GetText(), "([%,%.%d]+)")
			if spd then
				spd = string.gsub(spd, "%,", "%.")
				spd = tonumber(spd)
				break
			end
		end
	end
	return spd
end

SLASH_ZAutoShot1 = "/ZAutoShot"
SlashCmdList["ZAutoShot"] = function(msg)
	if ZAutoShotMove:IsVisible() then
		ZAutoShotMove:Hide()
		ZAutoShotBar:Hide()
	else
		ZAutoShotMove:Show()
		ZAutoShotBar:Show()
		ZAutoShotBar:SetAlpha(1)
	end
end