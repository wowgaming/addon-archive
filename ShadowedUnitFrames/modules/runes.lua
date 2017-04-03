local Runes = {}
local RUNE_MAP = {[1] = 1, [2] = 2, [3] = 5, [4] = 6, [5] = 3, [6] = 4}
local runeColors = {{r = 1, g = 0, b = 0.4}, {r = 0, g = 1, b = 0.4}, {r = 0, g = 0.4, b = 1}, {r = 0.7, g = 0.5, b = 1}}
ShadowUF:RegisterModule(Runes, "runeBar", ShadowUF.L["Rune bar"], true, "DEATHKNIGHT")

function Runes:OnEnable(frame)
	if( not frame.runeBar ) then
		frame.runeBar = CreateFrame("StatusBar", nil, frame)
		frame.runeBar:SetMinMaxValues(0, 1)
		frame.runeBar:SetValue(0)
		frame.runeBar.runes = {}
		
		for id=1, 6 do
			local rune = ShadowUF.Units:CreateBar(frame)
			rune:SetFrameLevel(1)
			
			if( id > 1 ) then
				rune:SetPoint("TOPLEFT", frame.runeBar.runes[RUNE_MAP[id - 1]], "TOPRIGHT", 1, 0)
			else
				rune:SetPoint("TOPLEFT", frame.runeBar, "TOPLEFT", 0, 0)
			end
			
			frame.runeBar.runes[RUNE_MAP[id]] = rune
		end
	end
	
	frame:RegisterNormalEvent("RUNE_POWER_UPDATE", self, "UpdateUsable")
	frame:RegisterNormalEvent("RUNE_TYPE_UPDATE", self, "Update")
	frame:RegisterUpdateFunc(self, "Update")
	frame:RegisterUpdateFunc(self, "UpdateUsable")
end

function Runes:OnDisable(frame)
	frame:UnregisterAll(self)
end

function Runes:OnLayoutApplied(frame)
	if( frame.visibility.runeBar ) then
		local barWidth = (frame.runeBar:GetWidth() - 5) / 6
		
		for id, rune in pairs(frame.runeBar.runes) do
			if( ShadowUF.db.profile.units[frame.unitType].runeBar.background ) then
				rune.background:Show()
			else
				rune.background:Hide()
			end
			
			rune.background:SetTexture(ShadowUF.Layout.mediaPath.statusbar)
			rune.background:SetHorizTile(false)
			rune:SetStatusBarTexture(ShadowUF.Layout.mediaPath.statusbar)
			rune:GetStatusBarTexture():SetHorizTile(false)
			rune:SetHeight(frame.runeBar:GetHeight())
			rune:SetWidth(barWidth)
		end
	end
end

local function runeMonitor(self, elapsed)
	local time = GetTime()
	self:SetValue(time)
	
	if( time >= self.endTime ) then
		self:SetValue(self.endTime)
		self:SetAlpha(1.0)
		self:SetScript("OnUpdate", nil)
	end
end

-- Updates the timers on runes
function Runes:UpdateUsable(frame, event, id, usable)
	if( not id ) then
		self:UpdateColors(frame)
		return
	elseif( not frame.runeBar.runes[id] ) then
		return
	end
	
	local rune = frame.runeBar.runes[id]
	local startTime, cooldown, cooled = GetRuneCooldown(id)
	if( not cooled ) then
		rune.endTime = GetTime() + cooldown
		rune:SetMinMaxValues(startTime, rune.endTime)
		rune:SetValue(GetTime())
		rune:SetAlpha(0.40)
		rune:SetScript("OnUpdate", runeMonitor)
	else
		rune:SetMinMaxValues(0, 1)
		rune:SetValue(1)
		rune:SetAlpha(1.0)
		rune:SetScript("OnUpdate", nil)
	end
end

function Runes:UpdateColors(frame)
	for id, rune in pairs(frame.runeBar.runes) do
		local color = runeColors[GetRuneType(id)]
		if( color ) then
			rune:SetStatusBarColor(color.r, color.g, color.b)

			color = ShadowUF.db.profile.bars.backgroundColor or ShadowUF.db.profile.units[frame.unitType].runeBar.backgroundColor or color
			rune.background:SetVertexColor(color.r, color.g, color.b, ShadowUF.db.profile.bars.backgroundAlpha)
		end
	end
end

-- No rune is passed for full update (Login), a single rune is passed when a single rune type changes, such as Blood Tap
function Runes:Update(frame, event, id)
	if( id ) then
		local color = runeColors[GetRuneType(id)]
		frame.runeBar.runes[id]:SetStatusBarColor(color.r, color.g, color.b)

		color = ShadowUF.db.profile.bars.backgroundColor or ShadowUF.db.profile.units[frame.unitType].runeBar.backgroundColor or color
		frame.runeBar.runes[id].background:SetVertexColor(color.r, color.g, color.b, ShadowUF.db.profile.bars.backgroundAlpha)
	end
end
