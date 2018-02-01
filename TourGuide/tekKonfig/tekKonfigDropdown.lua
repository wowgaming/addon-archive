
local lib, oldminor = LibStub:NewLibrary("tekKonfig-Dropdown", 3)
if not lib then return end
oldminor = oldminor or 0


local GameTooltip = GameTooltip
local function HideTooltip() GameTooltip:Hide() end
local function ShowTooltip(self)
	if self.frame.tiptext then
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
		GameTooltip:SetText(self.frame.tiptext, nil, nil, nil, nil, true)
	end
end
local function ShowTooltip2(self) ShowTooltip(self.container) end


local function OnClick(self)
	ToggleDropDownMenu(nil, nil, self:GetParent())
	PlaySound("igMainMenuOptionCheckBoxOn")
end

local function OnHide() CloseDropDownMenus() end


-- Create a dropdown.
-- All args optional, parent recommended
function lib.new(parent, label, ...)
	local container = CreateFrame("Button", nil, parent)
	container:SetWidth(149+13) container:SetHeight(32+24)
	container:SetScript("OnEnter", ShowTooltip)
	container:SetScript("OnLeave", HideTooltip)
	if select("#", ...) > 0 then container:SetPoint(...) end

	local name = "tekKonfigDropdown"..GetTime()  -- Sadly, some of these frames must be named
	local f = CreateFrame("Frame", name, parent)
	f:SetWidth(149) f:SetHeight(32)
	f:SetPoint("TOPLEFT", container, -13, -24)
	f:EnableMouse(true)
	f:SetScript("OnHide", OnHide)
	container.frame = f

	local ltex = f:CreateTexture(name.."Left", "ARTWORK")
	ltex:SetWidth(25) ltex:SetHeight(64)
	ltex:SetPoint("TOPLEFT", 0, 17)
	ltex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	ltex:SetTexCoord(0, 0.1953125, 0, 1)

	local rtex = f:CreateTexture(nil, "ARTWORK")
	rtex:SetWidth(25) rtex:SetHeight(64)
	rtex:SetPoint("RIGHT")
	rtex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	rtex:SetTexCoord(0.8046875, 1, 0, 1)

	local mtex = f:CreateTexture(nil, "ARTWORK")
	mtex:SetWidth(115) mtex:SetHeight(64)
	mtex:SetPoint("LEFT", ltex, "RIGHT")
	mtex:SetPoint("RIGHT", rtex, "LEFT")
	mtex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	mtex:SetTexCoord(0.1953125, 0.8046875, 0, 1)

	local text = f:CreateFontString(name.."Text", "ARTWORK", "GameFontHighlightSmall")
	text:SetWidth(0) text:SetHeight(10)
	text:SetPoint("RIGHT", rtex, -43, 2)
	text:SetJustifyH("RIGHT")

	local button = CreateFrame("Button", nil, f)
	button:SetWidth(24) button:SetHeight(24)
	button:SetPoint("TOPRIGHT", rtex, -16, -18)
	button:SetScript("OnClick", OnClick)
	button:SetScript("OnEnter", ShowTooltip2)
	button.container = container

	button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
	button:GetHighlightTexture():SetBlendMode("ADD")

	local labeltext = f:CreateFontString(nil, "BACKGROUND", "GameFontNormal")--GameFontHighlight
	labeltext:SetPoint("BOTTOMLEFT", container, "TOPLEFT", 16-13, 3-24)
	labeltext:SetText(label)

	return f, text, container, labeltext
end

