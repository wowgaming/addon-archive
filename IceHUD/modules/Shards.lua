local ShardCounter = IceCore_CreateClass(IceClassPowerCounter)

function ShardCounter.prototype:init()
	ShardCounter.super.prototype.init(self, "ShardCounter")

	self:SetDefaultColor("ShardCounterNumeric", 218, 231, 31)

	-- pulled from PaladinPowerBar.xml in Blizzard's UI source
	self.runeCoords =
	{
		{0.01562500, 0.28125000, 0.00781250, 0.13281250},
		{0.01562500, 0.28125000, 0.00781250, 0.13281250},
		{0.01562500, 0.28125000, 0.00781250, 0.13281250},
	}
	self.numericColor = "ShardCounterNumeric"
	self.unitPower = SPELL_POWER_SOUL_SHARDS
	self.runeHeight = 23
	self.runeWidth = 26
end

function ShardCounter.prototype:GetOptions()
	local opts = ShardCounter.super.prototype.GetOptions(self)

	opts.hideBlizz.desc = "Hides Blizzard shard frame and disables all events related to it.\n\nNOTE: Blizzard attaches the shard UI to the player's unitframe, so if you have that hidden in PlayerHealth, then this won't do anything."

	return opts
end

function ShardCounter.prototype:GetRuneTexture(rune)
	if not rune or rune ~= tonumber(rune) then
		return
	end

	return "Interface\\PlayerFrame\\UI-WarlockShard"
end

function ShardCounter.prototype:ShowBlizz()
	ShardBarFrame:Show()

	ShardBarFrame:GetScript("OnLoad")(ShardBarFrame)
end

function ShardCounter.prototype:HideBlizz()
	ShardBarFrame:Hide()

	ShardBarFrame:UnregisterAllEvents()
end

-- Load us up
local _, unitClass = UnitClass("player")
if (unitClass == "WARLOCK" and IceHUD.WowVer >= 40000) then
	IceHUD.ShardCounter = ShardCounter:new()
end
