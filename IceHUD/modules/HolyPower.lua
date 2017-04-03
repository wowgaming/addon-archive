local HolyPower = IceCore_CreateClass(IceClassPowerCounter)

function HolyPower.prototype:init()
	HolyPower.super.prototype.init(self, "HolyPower")

	self:SetDefaultColor("HolyPowerNumeric", 218, 231, 31)

	-- pulled from PaladinPowerBar.xml in Blizzard's UI source
	self.runeCoords =
	{
		{0.00390625, 0.14453125, 0.64843750, 0.82031250},
		{0.00390625, 0.12500000, 0.83593750, 0.96875000},
		{0.15234375, 0.25781250, 0.64843750, 0.81250000},
	}
	self.numericColor = "HolyPowerNumeric"
	self.unitPower = SPELL_POWER_HOLY_POWER
end

function HolyPower.prototype:GetOptions()
	local opts = HolyPower.super.prototype.GetOptions(self)

	opts.hideBlizz.desc = "Hides Blizzard Holy Power frame and disables all events related to it.\n\nNOTE: Blizzard attaches the holy power UI to the player's unitframe, so if you have that hidden in PlayerHealth, then this won't do anything."

	return opts
end

function HolyPower.prototype:GetRuneTexture(rune)
	if not rune or rune ~= tonumber(rune) then
		return
	end
	--return "Paladin-Rune0"..rune..".png"
	return "Interface\\PlayerFrame\\PaladinPowerTextures"
end

function HolyPower.prototype:ShowBlizz()
	PaladinPowerBar:Show()

	PaladinPowerBar:GetScript("OnLoad")(PaladinPowerBar)
end

function HolyPower.prototype:HideBlizz()
	PaladinPowerBar:Hide()

	PaladinPowerBar:UnregisterAllEvents()
end

-- Load us up
local _, unitClass = UnitClass("player")
if (unitClass == "PALADIN" and IceHUD.WowVer >= 40000) then
	IceHUD.HolyPower = HolyPower:new()
end
