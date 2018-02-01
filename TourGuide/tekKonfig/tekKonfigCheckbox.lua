
local lib, oldminor = LibStub:NewLibrary("tekKonfig-Checkbox", 1)
if not lib then return end


local GameTooltip = GameTooltip
local function HideTooltip() GameTooltip:Hide() end
local function ShowTooltip(self)
	if self.tiptext then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
	end
end
local function OnClick(self) PlaySound(self:GetChecked() and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff") end


-- Creates a checkbox.
-- All args optional but parent is highly recommended
function lib.new(parent, size, label, ...)
	local check = CreateFrame("CheckButton", nil, parent)
	check:SetWidth(size or 26)
	check:SetHeight(size or 26)
	if select(1, ...) then check:SetPoint(...) end

	check:SetHitRectInsets(0, -100, 0, 0)

	check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

	-- Tooltip bits
	check:SetScript("OnEnter", ShowTooltip)
	check:SetScript("OnLeave", HideTooltip)

	-- Sound
	check:SetScript("OnClick", OnClick)

	-- Label
	local fs = check:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	fs:SetPoint("LEFT", check, "RIGHT", 0, 1)
	fs:SetText(label)

	return check, fs
end
