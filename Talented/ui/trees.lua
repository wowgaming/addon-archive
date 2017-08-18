local CreateFrame = CreateFrame
local GameTooltip = GameTooltip
local Talented = Talented

local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

local function CreateTexture(base, layer, path, blend)
	local t = base:CreateTexture(nil, layer)
	if path then t:SetTexture(path) end
	if blend then t:SetBlendMode(blend)	end
	return t
end

local trees = Talented.Pool:new()

local function Layout(frame, width, height)
	local texture_height = height / (256+75)
	local texture_width = width / (256+44)

	frame:SetSize(width, height)

	local wl, wr, ht, hb =
		texture_width * 256, texture_width * 64,
		texture_height * 256, texture_height * 128

	frame.topleft:SetSize(wl, ht)
	frame.topright:SetSize(wr, ht)
	frame.bottomleft:SetSize(wl, hb)
	frame.bottomright:SetSize(wr, hb)

	frame.name:SetWidth(width)
end

local function ClearBranchButton_OnClick (self)
	local parent = self:GetParent()
	if parent.view then
		parent.view:ClearTalentTab(parent.tab)
	else
		Talented:ClearTalentTab(self:GetParent().tab)
	end
end

local function NewTalentFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetPoint("TOPLEFT")

	local t = CreateTexture(frame, "BACKGROUND")
	t:SetPoint("TOPLEFT")
	frame.topleft = t

	t = CreateTexture(frame, "BACKGROUND")
	t:SetPoint("TOPLEFT", frame.topleft, "TOPRIGHT")
	frame.topright = t

	t = CreateTexture(frame, "BACKGROUND")
	t:SetPoint("TOPLEFT", frame.topleft, "BOTTOMLEFT")
	frame.bottomleft = t

	t = CreateTexture(frame, "BACKGROUND")
	t:SetPoint("TOPLEFT", frame.topleft, "BOTTOMRIGHT")
	frame.bottomright = t

	local fs = frame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	fs:SetPoint("TOP", 0, -4)
	fs:SetJustifyH("CENTER")
	frame.name = fs

	local overlay = CreateFrame("Frame", nil, frame)
	overlay:SetAllPoints(frame)

	frame.overlay = overlay

	local clear = CreateFrame("Button", nil, frame)
	frame.clear = clear

	local makeTexture = function (path, blend)
		local t = CreateTexture(clear, nil, path, blend)
		t:SetAllPoints(clear)
		return t
	end

	clear:SetNormalTexture(makeTexture("Interface\\Buttons\\CancelButton-Up"))
	clear:SetPushedTexture(makeTexture("Interface\\Buttons\\CancelButton-Down"))
	clear:SetHighlightTexture(makeTexture("Interface\\Buttons\\CancelButton-Highlight", "ADD"))

	clear:SetScript("OnClick", ClearBranchButton_OnClick)
	clear:SetScript("OnEnter", Talented.base.editname:GetScript("OnEnter"))
	clear:SetScript("OnLeave", Talented.base.editname:GetScript("OnLeave"))
	clear.tooltip = L["Remove all talent points from this tree."]
	clear:SetSize(32, 32)
	clear:ClearAllPoints()
	clear:SetPoint("TOPRIGHT", -4, -4)

	trees:push(frame)

	return frame
end

function Talented:MakeTalentFrame(parent, width, height)
	local tree = trees:next()
	if tree then
		tree:SetParent(parent)
	else
		tree = NewTalentFrame(parent)
	end
	Layout(tree, width, height)
	return tree
end
