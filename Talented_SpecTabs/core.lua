local Talented = Talented
local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

local specs = {
	["spec1"] = {
		talentGroup = 1,
		tooltip = TALENT_SPEC_PRIMARY,
		cache = {},
	},
	["spec2"] = {
		talentGroup = 2,
		tooltip = TALENT_SPEC_SECONDARY,
		cache = {},
	},
	["petspec1"] = {
		pet = true,
		tooltip = TALENT_SPEC_PET_PRIMARY,
		cache = {},
	},
};

local function UpdateSpecInfo(info)
	local pet, talentGroup = info.pet, info.talentGroup
	local tabs = GetNumTalentTabs(nil, pet)
	if tabs == 0 then return end

	local imax, min, max, total = 0, 0, 0, 0
	for i = 1, tabs do
		local cache = info.cache[i]
		if not cache then
			cache = {}
			info.cache[i] = cache
		end
		local name, icon, points = GetTalentTabInfo(i, nil, pet, talentGroup)
		cache.name, cache.icon, cache.points = name, icon, points
		if points < min then
			min = points
		end
		if points > max then
			imax, max = i, points
		end
		total = total + points
	end
	info.primary = nil
	if tabs > 2 then
		local middle = total - min - max
		if 3 * (middle - min) < 2 * (max - min) then
			info.primary = imax
		end
	end
	return info
end

local function TabFrame_OnEnter(self)
	local info = specs[self.type]
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:AddLine(info.tooltip)
	for index, cache in ipairs(info.cache) do
		local color = info.primary == index and GREEN_FONT_COLOR or HIGHLIGHT_FONT_COLOR
		GameTooltip:AddDoubleLine(cache.name, cache.points,
			HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b,
			color.r, color.g, color.b, 1)
	end
	if not info.pet and not self:GetChecked() then
		GameTooltip:AddLine(L["Right-click to activate this spec"], GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b, 1)
	end
	GameTooltip:Show()
end

local function TabFrame_OnLeave(self)
	GameTooltip:Hide()
end

local function Tabs_UpdateCheck(self, template)
	if not template or not Talented.alternates then return end
	self.petspec1:SetChecked(template == Talented.pet_current)
	self.spec1:SetChecked(template == Talented.alternates[1])
	self.spec2:SetChecked(template == Talented.alternates[2])
end

local function TabFrame_OnClick(self, button)
	local info = specs[self.type]
	if button == "RightButton" then
		if not info.pet and not InCombatLockdown() then
			SetActiveTalentGroup(info.talentGroup)
			Tabs_UpdateCheck(self:GetParent(), Talented.alternates[info.talentGroup])
		end
	else
		local template
		if info.pet then
			template = Talented.pet_current
		else
			template = Talented.alternates[info.talentGroup]
		end
		if template then Talented:OpenTemplate(template) end
		Tabs_UpdateCheck(self:GetParent(), template)
	end
end

local function TabFrame_Update(self)
	local info = UpdateSpecInfo(specs[self.type])
	if info then
		self.texture:SetTexture(info.cache[info.primary or 1].icon)
	end
end

local function MakeTab(parent, type)
	local tab = CreateFrame("CheckButton", nil, parent)
	tab:SetSize(32, 32)
	local t = tab:CreateTexture(nil, "BACKGROUND")
	t:SetTexture"Interface\\SpellBook\\SpellBook-SkillLineTab"
	t:SetSize(64, 64)
	t:SetPoint("TOPLEFT", -3, 11)

	t = tab:CreateTexture()
	t:SetTexture"Interface\\Buttons\\ButtonHilight-Square"
	t:SetBlendMode"ADD"
	t:SetAllPoints()
	tab:SetHighlightTexture(t)
	t = tab:CreateTexture()
	t:SetTexture"Interface\\Buttons\\CheckButtonHilight"
	t:SetBlendMode"ADD"
	t:SetAllPoints()
	tab:SetCheckedTexture(t)
	t = tab:CreateTexture()
	t:SetAllPoints()
	tab:SetNormalTexture(t)
	tab.texture = t

	tab.type = type
	tab.Update = TabFrame_Update

	tab:SetScript("OnEnter", TabFrame_OnEnter)
	tab:SetScript("OnLeave", TabFrame_OnLeave)

	tab:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	tab:SetScript("OnClick", TabFrame_OnClick)

	return tab
end

local function Tabs_Update(self)
	local anchor = self.spec1
	anchor:SetPoint"TOPLEFT"
	anchor:Update()

	if GetNumTalentGroups() > 1 then
		local spec2 = self.spec2
		spec2:Show()
		spec2:SetPoint("TOP", anchor, "BOTTOM", 0, -20)
		spec2:Update()
		anchor = spec2
	else
		self.spec2:Hide()
	end
	-- local _, pet = HasPetUI()
	local pet = UnitExists"pet"
	if pet then
		local petspec1 = self.petspec1
		petspec1:Show()
		petspec1:Update()
		petspec1:SetPoint("TOP", anchor, "BOTTOM", 0, -20)
	else
		self.petspec1:Hide()
	end
end

local function Tabs_OnEvent(self, event, ...)
	if event ~= "UNIT_PET" or (...) == "player" then
		Tabs_Update(self)
	end
end

local function MakeTabs(parent)
	local f = CreateFrame("Frame", nil, parent)

	f.spec1 = MakeTab(f, "spec1")
	f.spec2 = MakeTab(f, "spec2")
	f.petspec1 = MakeTab(f, "petspec1")

	f:SetPoint("TOPLEFT", parent, "TOPRIGHT", -2, -40)
	f:SetSize(32, 150)

	f:SetScript("OnEvent", Tabs_OnEvent)

	f:RegisterEvent"UNIT_PET"
	f:RegisterEvent"PLAYER_LEVEL_UP"
	f:RegisterEvent"PLAYER_TALENT_UPDATE"
	f:RegisterEvent"PET_TALENT_UPDATE"
	f:RegisterEvent"ACTIVE_TALENT_GROUP_CHANGED"

	f.Update = Tabs_Update
	f.UpdateCheck = Tabs_UpdateCheck
	Talented.tabs = f
	f:Update()

	local baseView = parent.view
	local prev = baseView.SetTemplate
	baseView.SetTemplate = function (self, template, ...)
		Talented.tabs:UpdateCheck(template)
		return prev (self, template, ...)
	end
	f:UpdateCheck(baseView.template)
	MakeTabs = nil
	return f
end

if Talented.base then
	MakeTabs(Talented.base)
else
	local prev = Talented.CreateBaseFrame
	Talented.CreateBaseFrame = function (self)
		local base = prev(self)
		MakeTabs(base)
		return base
	end
end
