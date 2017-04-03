local HungerForBlood = IceCore_CreateClass(IceUnitBar)

local hfbEndTime = 0
local hfbDuration = 0
local hfbBuffCount = 0
local oldhfbBonusPerBuff = 5
local hfbBonusPerBuff = 15

-- Constructor --
function HungerForBlood.prototype:init()
	HungerForBlood.super.prototype.init(self, "HungerForBlood", "player")

	self.moduleSettings = {}
	self.moduleSettings.desiredLerpTime = 0
	self.moduleSettings.shouldAnimate = false

	self:SetDefaultColor("HungerForBlood", 0.75, 1, 0.2)
	self:SetDefaultColor("HungerForBloodMax", 1, 1, 1)
end

-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function HungerForBlood.prototype:Enable(core)
	HungerForBlood.super.prototype.Enable(self, core)

	if IceHUD.WowVer >= 30000 then
		self:RegisterEvent("UNIT_AURA", "UpdateHungerForBlood")
	else
		self:RegisterEvent("PLAYER_AURAS_CHANGED", "UpdateHungerForBlood")
	end

	self:Show(true)

	self:SetBottomText1("")
	self:SetBottomText2("")
end

function HungerForBlood.prototype:TargetChanged()
	self:UpdateHungerForBlood()
end

function HungerForBlood.prototype:Disable(core)
	HungerForBlood.super.prototype.Disable(self, core)
end

-- OVERRIDE
function HungerForBlood.prototype:GetDefaultSettings()
    local settings = HungerForBlood.super.prototype.GetDefaultSettings(self)

    settings["enabled"] = false
    settings["shouldAnimate"] = false
    settings["desiredLerpTime"] = 0
    settings["lowThreshold"] = 0
    settings["side"] = IceCore.Side.Right
    settings["offset"] = 8
    settings["upperText"]="HfB:"
    settings["usesDogTagStrings"] = false
    settings["allowMouseInteraction"] = true
    settings["lockLowerFontAlpha"] = false
    settings["lowerTextString"] = ""
    settings["lowerTextVisible"] = false

    return settings
end

-- OVERRIDE
function HungerForBlood.prototype:GetOptions()
    local opts = HungerForBlood.super.prototype.GetOptions(self)

    opts["textSettings"].args["upperTextString"]["desc"] = "The text to display under this bar. # will be replaced with the number of Slice and Dice seconds remaining."

	opts["allowClickCast"] = {
		type = 'toggle',
		name = 'Allow click casting',
		desc = 'Whether or not to allow click casting of Hunger For Blood',
		get = function()
			return self.moduleSettings.allowMouseInteraction
		end,
		set = function(info, v)
			self.moduleSettings.allowMouseInteraction = v
			self:CreateFrame()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end
	}

    return opts
end

function HungerForBlood.prototype:CreateFrame()
	HungerForBlood.super.prototype.CreateFrame(self)

	if not self.frame.button then
		self.frame.button = CreateFrame("Button", "IceHUD_HungerForBloodClickFrame", self.frame, "SecureActionButtonTemplate")
	end

	self.frame.button:ClearAllPoints()

	if self:GetMyBarTexture() == "HiBar" then
		self.frame.button:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", 0, 0)
		self.frame.button:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMRIGHT", -1 * self.frame:GetWidth(), 0)
	else
		if self.moduleSettings.side == IceCore.Side.Left then
			self.frame.button:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -6, 0)
			self.frame.button:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMRIGHT", -1 * self.frame:GetWidth() / 3, 0)
		else
			self.frame.button:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 6, 0)
			self.frame.button:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -1 * self.frame:GetWidth() / 1.5, 0)
		end
	end

	self:EnableClickCasting(self.moduleSettings.allowMouseInteraction)
end

function HungerForBlood.prototype:EnableClickCasting(bEnable)
	if bEnable then
		self.frame.button:EnableMouse(true)
		self.frame.button:RegisterForClicks("LeftButtonUp")
		self.frame.button:SetAttribute("type1", "spell")
		local hfbSpellName = GetSpellInfo(51662)
		self.frame.button:SetAttribute("spell1",hfbSpellName)
	else
		self.frame.button:EnableMouse(false)
		self.frame.button:RegisterForClicks()
	end
end

-- 'Protected' methods --------------------------------------------------------

function HungerForBlood.prototype:GetBuffDuration(unitName, buffName)
    local i = 1
    local buff, rank, texture, count, type, duration, endTime, remaining
    if IceHUD.WowVer >= 30000 then
        buff, rank, texture, count, type, duration, endTime = UnitBuff(unitName, i)
    else
        buff, rank, texture, count, duration, remaining = UnitBuff(unitName, i)
    end

    while buff do
        if (texture and string.match(texture, buffName)) then
            if endTime and not remaining then
                remaining = endTime - GetTime()
            end
            return duration, remaining, count
        end

        i = i + 1;

        if IceHUD.WowVer >= 30000 then
            buff, rank, texture, count, type, duration, endTime = UnitBuff(unitName, i)
        else
            buff, rank, texture, count, duration, remaining = UnitBuff(unitName, i)
        end
    end

    return nil, nil, nil
end

function HungerForBlood.prototype:UpdateHungerForBlood(event, unit, fromUpdate)
    if unit and unit ~= self.unit then
        return
    end

    local now = GetTime()
    local remaining = nil

    if not fromUpdate or IceHUD.WowVer < 30000 then
        hfbDuration, remaining, hfbBuffCount = self:GetBuffDuration(self.unit, "Ability_Rogue_HungerforBlood")

	if not remaining then
            hfbEndTime = 0
			hfbBuffCount = 0
	else
            hfbEndTime = remaining + now
        end
    end

    if hfbEndTime and hfbEndTime >= now then
        if not fromUpdate then
            self.frame:SetScript("OnUpdate", function() self:UpdateHungerForBlood(nil, self.unit, true) end)
        end

--        self:Show(true)
        if not remaining then
            remaining = hfbEndTime - now
        end
		if (hfbBuffCount ~= nil and hfbBuffCount > 2) then
			self:UpdateBar(hfbDuration ~= 0 and remaining / hfbDuration or 0, "HungerForBloodMax")
		else
			self:UpdateBar(hfbDuration ~= 0 and remaining / hfbDuration or 0, "HungerForBlood")
		end

        formatString = self.moduleSettings.upperText or ''
    else
		self:UpdateBar(0, "HungerForBlood")
-- Parnic: removing this. frames can't be dynamically shown/hidden in combat unless they're tied directly to a unit
--		self:Show(false)
    end

    -- somewhat redundant, but we also need to check potential remaining time
    if (remaining ~= nil) then
	self:SetBottomText1(self.moduleSettings.upperText .. tostring(floor(remaining or 0)) .. "s")
	if (hfbBuffCount ~= nil) then
		-- pre-emptive fix for v3.1. HfB only stacks once at 15% instead of thrice at 5%
		if IceHUD.WowVer < 30100 then
			self:SetBottomText2("+" .. (hfbBuffCount * oldhfbBonusPerBuff) .. "% dmg")
		else
			self:SetBottomText2("+" .. (hfbBuffCount * hfbBonusPerBuff) .. "% dmg")
		end
	else
		self:SetBottomText2("")
	end
    else
		hfbBuffCount = 0
		self:SetBottomText1("")
		self:SetBottomText2("")
    end
end

function HungerForBlood.prototype:OutCombat()
	HungerForBlood.super.prototype.OutCombat(self)

	self:UpdateHungerForBlood()
end

local _, unitClass = UnitClass("player")
-- Load us up
if unitClass == "ROGUE" and IceHUD.WowVer < 40000 then
    IceHUD.HungerForBlood = HungerForBlood:new()
end
