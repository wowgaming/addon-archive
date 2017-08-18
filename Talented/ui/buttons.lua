local CreateFrame = CreateFrame
local Talented = Talented

local function CreateTexture(base, layer, path, blend)
	local t = base:CreateTexture(nil, layer)
	if path then t:SetTexture(path) end
	if blend then t:SetBlendMode(blend)	end
	return t
end

local buttons = Talented.Pool:new()

local function Button_OnEnter (self)
	local parent = self:GetParent()
	parent.view:SetTooltipInfo(self, parent.tab, self.id)
end

local function Button_OnLeave (self)
	Talented:HideTooltipInfo()
end

local function Button_OnClick (self, button, down)
	local parent = self:GetParent()
	parent.view:OnTalentClick(button, parent.tab, self.id)
end

local function MakeRankFrame(button, anchor)
	local t = CreateTexture(button, "OVERLAY", "Interface\\Addons\\Talented\\Textures\\border")
	t:SetSize(32, 32)
	t:SetPoint("CENTER", button, anchor)
	local fs = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	fs.texture = t
	fs:SetPoint("CENTER", t)
	return fs
end

local function NewButton(parent)
	local button = CreateFrame("Button", nil, parent.child or parent)
	-- ItemButtonTemplate (minus Count and Slot)
	button:SetSize(37, 37)
	local t = CreateTexture(button, "BORDER")
	t:SetSize(64, 64)
	t:SetAllPoints(button)
	button.texture = t
	t = CreateTexture(button, nil, "Interface\\Buttons\\UI-Quickslot2")
	t:SetSize(64, 64)
	t:SetPoint("CENTER", 0, -1)
	button:SetNormalTexture(t)
	t = CreateTexture(button, nil, "Interface\\Buttons\\UI-Quickslot-Depress")
	t:SetSize(36, 36)
	t:SetPoint("CENTER")
	button:SetPushedTexture(t)
	t = CreateTexture(button, nil, "Interface\\Buttons\\ButtonHilight-Square", "ADD")
	t:SetSize(36, 36)
	t:SetPoint("CENTER")
	button:SetHighlightTexture(t)
	-- TalentButtonTemplate
	local texture = CreateTexture(button, "BACKGROUND", "Interface\\Buttons\\UI-EmptySlot-White")
	texture:SetSize(64, 64)
	texture:SetPoint("CENTER", 0, -1)
	button.slot = texture

	button.rank = MakeRankFrame(button, "BOTTOMRIGHT")

	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	button:SetScript("OnEnter", Button_OnEnter)
	button:SetScript("OnLeave", Button_OnLeave)
	button:SetScript("OnClick", Button_OnClick)

	buttons:push(button)
	return button
end

function Talented:MakeButton(parent)
	local button = buttons:next()
	if button then
		button:SetParent(parent)
	else
		button = NewButton(parent)
	end
	return button
end

function Talented:GetButtonTarget(button)
	local target = button.target
	if not target then
		target = MakeRankFrame(button, "TOPRIGHT")
		button.target = target
	end
	return target
end
