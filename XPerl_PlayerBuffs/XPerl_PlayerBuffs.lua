-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

local conf, pconf
XPerl_RequestConfig(function(new) conf = new pconf = new.player end, "$Revision: 387 $")

local ev = CreateFrame("Frame")
local buffAlpha = 1
local buffFadingOut
local buffsUpdateFlag

-- FlashExpiringBuffs
local function FlashExpiringBuffs(self, elapsed)
	local now = GetTime()

	if (buffFadingOut) then
		buffAlpha = buffAlpha - elapsed
		if (buffAlpha <= 0.3) then
			buffAlpha = 0.3
			buffFadingOut = nil
		end
	else
		buffAlpha = buffAlpha + elapsed
		if (buffAlpha >= 1) then
			buffAlpha = 1
			buffFadingOut = true
		end
	end

	for i,buff in pairs(self.buffFrame.tempEnchant) do
		if (buff.expireTime and buff.expireTime <= now + 30) then
			buff:SetAlpha(buffAlpha)
		else
			buff:SetAlpha(1)
		end
	end
	for i,buff in pairs(self.buffFrame.buff) do
		if (buff.expireTime and buff.expireTime <= now + 30) then
			buff:SetAlpha(buffAlpha)
		else
			buff:SetAlpha(1)
		end
	end
	for i,buff in pairs(self.buffFrame.debuff) do
		if (buff.expireTime and buff.expireTime <= now + 30) then
			buff:SetAlpha(buffAlpha)
		else
			buff:SetAlpha(1)
		end
	end
end

-- UpdateBuffsTimeLeft
local function UpdateBuffsTimeLeft(self)
	self.firstExpire = nil
	if (pconf.buffs.enable and pconf.buffs.flash) then
		local time = GetTime()
		local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();

		local function CheckOneBuff(button, timeRemaining)
			if (timeRemaining > 0) then
				button.expireTime = time + timeRemaining
				if (not self.firstExpire or button.expireTime < self.firstExpire) then
					self.firstExpire = button.expireTime
					return true
				end
			else
				button.expireTime = nil
			end
		end

		if (mainHandExpiration) then
			CheckOneBuff(self.buffFrame.tempEnchant[1], mainHandExpiration / 1000)
		end
		if (offHandExpiration) then
			CheckOneBuff(self.buffFrame.tempEnchant[2], offHandExpiration / 1000)
		end

		for i = 1,40 do
			local button = self.buffFrame.buff[i]
			if (button) then
				local name, rank, buff, count, _, duration, endTime, myCast = UnitBuff(self.partyid, i)
				if (name and myCast) then
					CheckOneBuff(button, endTime - duration)
				else
					button.expireTime = nil
				end
			end

			button = self.buffFrame.debuff[i]
			if (button) then
				local name, rank, buff, count, _, duration, endTime, myCast = UnitDebuff(self.partyid, i)
				if (name) then
					CheckOneBuff(button, endTime - duration)
				else
					button.expireTime = nil
				end
			end
		end
	end
end

-- XPerl_PlayerBuffs_OnUpdate
function XPerl_PlayerBuffs_OnUpdate(self, elapsed)
	if (buffsUpdateFlag) then
		buffsUpdateFlag = nil

		-- The PLAYER_AURAS_CHANGED event is not given if an own buff is refreshed, hence we don't get expire times updated
		-- So we intercept UNIT_AURA for this, but will still have to catch PLAYER_AURAS_CHANGED because there's some
		-- latency between a buff expiring (according to UNIT_BUFF), and the aura fading (according to PLAYER_AURAS_CHANGED).
		if (pconf.buffs.enable) then
			local a = conf.buffs.cooldown
			conf.buffs.cooldown = pconf.buffs.cooldown
			if (pconf.buffs.wrap) then
				XPerl_Unit_UpdateBuffs(XPerl_Player, nil, nil, 0, 0)
			else
				XPerl_Unit_UpdateBuffs(XPerl_Player, pconf.buffs.count, pconf.buffs.count, 0, 0)
			end
			XPerl_Player_Buffs_Position(XPerl_Player)
			conf.buffs.cooldown = a

			XPerl_Player_TempEnchantUpdate(XPerl_Player)

			UpdateBuffsTimeLeft(XPerl_Player)
		end
	end

	if (XPerl_Player.firstExpire) then
		local now = GetTime()
		if (XPerl_Player.firstExpire <= now + 30) then
			FlashExpiringBuffs(XPerl_Player, elapsed)
		end
	end
end

-- XPerl_Player_Buffs_Position
function XPerl_Player_Buffs_Position(self)
	if (self.buffFrame) then
		self.buffFrame:ClearAllPoints()
		if (pconf.buffs.above) then
			self.buffFrame:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 3, 0)
		else
			if (self.runes and self.runes:IsShown() and not pconf.hideRunes) then
				self.buffFrame:SetPoint("TOPLEFT", self.runes, "BOTTOMLEFT", 3, 0)
			elseif (pconf.buffs.wrap and ((pconf.xpBar or pconf.repBar) and not pconf.extendPortrait)) then
				self.buffFrame:SetPoint("TOPLEFT", self.statsFrame, "BOTTOMLEFT", 3, 0)
			else
				self.buffFrame:SetPoint("TOPLEFT", self.portraitFrame, "BOTTOMLEFT", 3, 0)
			end
		end

		--if (not self.conf.buffs.wrap and self.buffFrame.buff and self.buffFrame.buff[1] and self.buffFrame.debuff and self.buffFrame.debuff[1]) then
		--	self.buffFrame.buff[1]:ClearAllPoints()
		--	self.buffFrame.debuff[1]:ClearAllPoints()
		--	if (pconf.buffs.above) then
		--		self.buffFrame.buff[1]:SetPoint("BOTTOMLEFT", 0, 0)
		--		self.buffFrame.debuff[1]:SetPoint("BOTTOMLEFT", self.buffFrame.buff[1], "TOPLEFT", 0, 2)
		--	else
		--		self.buffFrame.buff[1]:SetPoint("TOPLEFT", 0, 0)
		--		self.buffFrame.debuff[1]:SetPoint("TOPLEFT", self.buffFrame.buff[1], "BOTTOMLEFT", 0, -2)
		--	end
		--end

		XPerl_Unit_BuffPositions(self, self.buffFrame.buff, self.buffFrame.debuff, pconf.buffs.size, pconf.debuffs.size)
	end
end

-- XPerl_Player_BuffSetup
function XPerl_Player_BuffSetup(self)
	if (not pconf.buffs.enable) then
		self.firstExpire = nil
		if (self.buffFrame) then
			self.buffFrame:Hide()
			ev:UnregisterAllEvents()

			BuffFrame:Show()
			BuffFrame:RegisterEvent("UNIT_AURA")
			TemporaryEnchantFrame:Show()

			BuffFrame_Update()
		end
		return
	end

	if (not self.buffFrame) then
		self.buffFrame = CreateFrame("Frame", self:GetName().."buffFrame", self)
		self.buffFrame:SetScript("OnUpdate", XPerl_PlayerBuffs_OnUpdate)
		self.buffFrame:SetWidth(200)
		self.buffFrame:SetHeight(32)
		self.buffFrame.buff = {}
		self.buffFrame.debuff = {}

		self.debuffFrame = CreateFrame("Frame", self:GetName().."debuffFrame", self.buffFrame)
		self.tempEnchantFrame = CreateFrame("Frame", self:GetName().."tempEnchantFrame", self.buffFrame)

		XPerl_GetBuffButton(self, 1, 1, true)
		XPerl_GetBuffButton(self, 2, 1, true)
		self.buffFrame.tempEnchant = self.buffFrame.debuff
		self.buffFrame.debuff = {}

		self.buffFrame.tempEnchant[1]:SetParent(self.tempEnchantFrame)
		self.buffFrame.tempEnchant[2]:SetParent(self.tempEnchantFrame)

		local function SetupEnchantButton(self)
			self:SetScript("OnEnter",
				function(self)
					if (conf.tooltip.enableBuffs and XPerl_TooltipModiferPressed(true)) then
						if (not conf.tooltip.hideInCombat or not InCombatLockdown()) then
							GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
							GameTooltip:SetInventoryItem("player", self:GetID())
						end
					end
				end
			)

			self.UpdateTooltip = nil

			self:SetScript("OnClick",
				function(self, button)
					if (button == "RightButton") then
						if (self:GetID() == 16) then
							CancelItemTempEnchantment(1)
						elseif (self:GetID() == 17) then
							CancelItemTempEnchantment(2)
						end
					end
				end
			)
		end

		local te = self.buffFrame.tempEnchant
		SetupEnchantButton(te[1])
		SetupEnchantButton(te[2])

		XPerl_GetBuffButton(self, 1, 0, true)		-- Need at least 1 buff and debuff icon to anchor debuffs
		XPerl_GetBuffButton(self, 1, 1, true)
	end

	XPerl_SetBuffSize(self)
  
	if (pconf.buffs.hideBlizzard) then
		BuffFrame:UnregisterEvent("UNIT_AURA")
		BuffFrame:Hide()
		TemporaryEnchantFrame:Hide()
	else
		BuffFrame:Show()
		BuffFrame:RegisterEvent("UNIT_AURA")
		TemporaryEnchantFrame:Show()
	end

	ev:RegisterEvent("UNIT_AURA")
	ev:RegisterEvent("UNIT_INVENTORY_CHANGED")
	ev:RegisterEvent("UNIT_ENTERED_VEHICLE")
	ev:RegisterEvent("UNIT_EXITED_VEHICLE")
	self.buffFrame:Show()

	local a = conf.buffs.cooldown
	conf.buffs.cooldown = pconf.buffs.cooldown
	if (pconf.buffs.wrap) then
		XPerl_Unit_UpdateBuffs(XPerl_Player, nil, nil, 0, 0)
	else
		XPerl_Unit_UpdateBuffs(XPerl_Player, pconf.buffs.count, pconf.buffs.count, 0, 0)
	end
	conf.buffs.cooldown = a

	self.buffOptMix = nil
	XPerl_Player_Buffs_Position(self)

	XPerl_Player_TempEnchantUpdate(XPerl_Player)
	UpdateBuffsTimeLeft(XPerl_Player)
end

-- XPerl_Player_TempEnchantUpdate
function XPerl_Player_TempEnchantUpdate(self)

	if (not self.buffFrame) then
		return
	end
  
  -- check to see if the player is a shaman and sets the fullDuration to 30 minutes. Shaman weapon enchants are only 30 minutes.
  local playerClass, playerClass1 = UnitClass("player");
	local time = GetTime()
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();

	local te = self.buffFrame.tempEnchant
	local on1 = te and te[1]:IsVisible()
	local on2 = te and te[2]:IsVisible()
	local anyOn = (on1 and on2)

	-- No enchants, kick out early
	if (not hasMainHandEnchant and not hasOffHandEnchant) then
		if (te) then
			te[1]:Hide()
			te[2]:Hide()
		end
		if (self.buffFrame.buff and self.buffFrame.buff[1]) then
			if (pconf.buffs.above) then
				self.buffFrame.buff[1]:SetPoint("BOTTOMLEFT", 0, 0)
			else
				self.buffFrame.buff[1]:SetPoint("TOPLEFT", 0, 0)
			end
		end
		return anyOn
	end

	local function DoEnchant(index, slotID, hasEnchant, expire, charges)
	local button = te[index]
	if (hasEnchant) then
                -- Fix to check to see if the player is a shaman and sets the fullDuration to 30 minutes. Shaman weapon enchants are only 30 minutes.
                if (playerClass1 == "SHAMAN") then
                        if ((expire / 1000) > 30 * 60) then
                                buff.fullDuration = 60 * 60
                        else         
                                button.fullDuration = 30 * 60
                        end
                end
                if (not button.fullDuration) then
                        button.fullDuration = expire - time
                        if (button.fullDuration > 1 * 60) then
                                button.fullDuration = 60 * 60
                        end
                end
        
			button:Show()
			
			local textureName = GetInventoryItemTexture("player", slotID)	-- Weapon Icon
			button:SetID(slotID)
			button.icon:SetTexture(textureName)
			button:SetAlpha(1)
			button.border:SetVertexColor(0.7, 0, 0.7)

			-- Handle cooldowns
			if (button.cooldown) then
				if (expire and conf.buffs.cooldown and pconf.buffs.cooldown) then
					local timeEnd = time + (expire / 1000)
					local timeStart = timeEnd - button.fullDuration		--          (30 * 60)

					XPerl_CooldownFrame_SetTimer(button.cooldown, timeStart, button.fullDuration, 1)
				else
					button.cooldown:Hide()
				end
			end

			if (index > 1) then
				button:SetPoint("TOPLEFT", te[index - 1], "TOPRIGHT", 0, 0)
			else
				button:ClearAllPoints()
				if (pconf.buffs.above) then
					button:SetPoint("BOTTOMLEFT", self.buffFrame, "BOTTOMLEFT", 0, 0)
				else
					button:SetPoint("TOPLEFT", self.buffFrame, "TOPLEFT", 0, 0)
				end
			end

			return 1
		else
			button.fullDuration = nil
			button:Hide()
			return 0
		end
	end

	local i = 0
	i = i + DoEnchant(i + 1, 16, hasMainHandEnchant, mainHandExpiration, mainHandCharges)
	i = i + DoEnchant(i + 1, 17, hasOffHandEnchant, offHandExpiration, offHandCharges)

	self.buffFrame.buff[1]:SetPoint("TOPLEFT", self.buffFrame.tempEnchant[i], "TOPRIGHT", 0, 0)

	i = i + 1
	while i < 3 do
		local button = te[i]
		button:Hide()
		i = i + 1
	end

	if (te[1]:IsVisible() and not on1) then
		return true
	elseif (te[2]:IsVisible() and not on2) then
		return true
	end

	return
end

-- XPerl_Player_SetBuffTooltip
function XPerl_Player_SetBuffTooltip(self)
	if (conf.tooltip.enableBuffs and XPerl_TooltipModiferPressed(true)) then
		if (not conf.tooltip.hideInCombat or not InCombatLockdown()) then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:SetUnitBuff(XPerl_Player.partyid, self:GetID())
		end
	end
end

-- XPerl_Player_SetDeBuffTooltip
function XPerl_Player_SetDeBuffTooltip(self)
	if (conf.tooltip.enableBuffs and XPerl_TooltipModiferPressed(true)) then
		if (not conf.tooltip.hideInCombat or not InCombatLockdown()) then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:SetUnitDebuff(XPerl_Player.partyid, self:GetID())
		end
	end
end

-- PlayerBuffsInit
local function PlayerBuffsInit(self)
	local BuffOnUpdate, DebuffOnUpdate, BuffUpdateTooltip, DebuffUpdateTooltip
	BuffUpdateTooltip = XPerl_Player_SetBuffTooltip
	DebuffUpdateTooltip = XPerl_Player_SetDeBuffTooltip

	XPerl_Player.buffSetup = {
		buffScripts = {
			OnEnter = XPerl_Player_SetBuffTooltip,
			OnUpdate = BuffOnUpdate,
			OnLeave = XPerl_PlayerTipHide,
			OnClick = function(self, button)
				if (button == "RightButton") then
					local name, rank, buff, count, _, duration, endTime, myCast = UnitBuff("player", self:GetID())
					if (name) then
						CancelUnitBuff("player", name)
					end
				end
			end,
		},
		debuffScripts = {
			OnEnter = XPerl_Player_SetDeBuffTooltip,
			OnUpdate = DebuffOnUpdate,
			OnLeave = XPerl_PlayerTipHide,
			OnClick = function(self, button)
				-- Can cancel a few debuffs (Mind Vision for example)
				if (button == "RightButton") then
					local name, rank, buff, count, _, duration, endTime, myCast = UnitDebuff("player", self:GetID())
					if (name) then
						CancelUnitBuff("player", name)
					end
				end
			end,
		},
		updateTooltipBuff = BuffUpdateTooltip,
		updateTooltipDebuff = DebuffUpdateTooltip,
		debuffParent = true,
		buffSizeOpt = "PlayerBuffSize",
		debuffSizeMod = 0.2,
		rightClickable = true,
		buffAnchor1 = function(self, b)
			if (pconf.buffs.above) then
				self.buffFrame:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 3, 0)
			else
				--if ((self.statsFrame.repBar and self.statsFrame.repBar:IsShown()) or (self.statsFrame.xpBar and self.statsFrame.xpBar:IsShown()) or (self.statsFrame.druidBar and self.statsFrame.druidBar:IsShown())) then
				--	self.buffFrame:SetPoint("TOPLEFT", self.statsFrame, "BOTTOMLEFT", 3, 0)
				--else
					self.buffFrame:SetPoint("TOPLEFT", self.portraitFrame, "BOTTOMLEFT", 3, 0)
				--end
			end

			b:ClearAllPoints()
			if (pconf.buffs.above) then
				b:SetPoint("BOTTOMLEFT", 0, 0)
			else
				b:SetPoint("TOPLEFT", 0, 0)
			end
			self.buffSetup.buffAchor1 = nil
		end,
		debuffAnchor1 = function(self, b)
			b:ClearAllPoints()
			if (pconf.buffs.above) then
				b:SetPoint("BOTTOMLEFT", self.buffFrame.buff[1], "TOPLEFT", 0, 0)
			else
				b:SetPoint("TOPLEFT", self.buffFrame.buff[1], "BOTTOMLEFT", 0, 0)
			end
			self.buffSetup.debuffAchor1 = nil
		end,
	}

	XPerl_RegisterOptionChanger(function()
			XPerl_Player.buffOptMix = nil
			XPerl_Player_BuffSetup(XPerl_Player)
		end
	)

	XPerl_Player.GetBuffSpacing = function(self)
		local w = self.statsFrame:GetWidth()
		if (pconf.portrait) then
			w = w - 2 + self.portraitFrame:GetWidth()
		end
		if (not self.buffSpacing) then
			self.buffSpacing = XPerl_GetReusableTable()
		end
		self.buffSpacing.rowWidth = w

		local srs = 0
		if ((not self.runes or pconf.hideRunes) and not self.conf.buffs.above and pconf.portrait and not pconf.extendPortrait) then
			if (self.statsFrame.xpBar and self.statsFrame.xpBar:IsShown()) then
				srs = 10
			end
			if (self.statsFrame.repBar and self.statsFrame.repBar:IsShown()) then
				srs = srs + 10
			end
			if (self.statsFrame.druidBar and self.statsFrame.druidBar:IsShown()) then
				srs = srs + 10
			end
		end
                
		if (srs > 0 and pconf.portrait) then
			self.buffSpacing.smallRowHeight = srs
			self.buffSpacing.smallRowWidth = self.portraitFrame:GetWidth() - 2
		else
			self.buffSpacing.smallRowHeight = 0
			self.buffSpacing.smallRowWidth = w
		end
	end

	XPerl_Player_BuffSetup(XPerl_Player)

	PlayerBuffsInit = nil
end

local function PlayerBuffsOnEvent(self, event, unit)
--XPerl_ShowMessage("PlayerBuffs")

	if (event == "UNIT_AURA" and (unit == "player" or unit == "vehicle")) then
		-- The PLAYER_AURAS_CHANGED event is not given if an own buff is refreshed, hence we don't get expire times updated
		-- So we intercept UNIT_AURA for this, but will still have to catch PLAYER_AURAS_CHANGED because there's some
		-- latency between a buff expiring (according to UNIT_BUFF), and the aura fading (according to PLAYER_AURAS_CHANGED).

		-- So, instead of doing double work we'll set a flag and do it during the OnUpdate
		if (pconf.buffs.enable) then
			buffsUpdateFlag = true
		end

	elseif (event == "UNIT_INVENTORY_CHANGED") then
		-- Fired when (among other things) a weapon enchant changes
		-- This event fires a lot, which is aweful. But less awful than re-working the icons from
		-- scratch for every single frame like the Blizzard code does (Who writes that code???)
		if (unit == "player" and self.partyid == "player" and pconf.buffs.enable) then
			buffsUpdateFlag = true
		end

	elseif (event == "PLAYER_ENTERING_WORLD") then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		PlayerBuffsInit(self)

	elseif (event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE") then
		-- We want to insure that and update to buffs happen uppone entering a Vehicle
		if (pconf.buffs.enable) then
			buffsUpdateFlag = true
		end
	end
end

ev:RegisterEvent("PLAYER_ENTERING_WORLD")
ev:SetScript("OnEvent", PlayerBuffsOnEvent)
ev:Show()
