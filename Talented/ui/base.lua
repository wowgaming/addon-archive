local max = math.max
local CreateFrame = CreateFrame
local GREEN_FONT_COLOR = GREEN_FONT_COLOR
local PlaySound = PlaySound
local Talented = Talented
local GameTooltip = GameTooltip

local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

Talented.uielements = {}

-- All this exists so that a UIPanelButtonTemplate2 like button correctly works
-- with :SetButtonState(). This is because the state is only updated after
-- :OnMouse{Up|Down}().

local BUTTON_TEXTURES = {
	NORMAL = "Interface\\Buttons\\UI-Panel-Button-Up",
	PUSHED = "Interface\\Buttons\\UI-Panel-Button-Down",
	DISABLED = "Interface\\Buttons\\UI-Panel-Button-Disabled",
	PUSHED_DISABLED = "Interface\\Buttons\\UI-Panel-Button-Disabled-Down",
}
local DefaultButton_Enable = GameMenuButtonOptions.Enable
local DefaultButton_Disable = GameMenuButtonOptions.Disable
local DefaultButton_SetButtonState = GameMenuButtonOptions.SetButtonState
local function Button_SetState(self, state)
	if not state then
		if self:IsEnabled() == 0 then
			state = "DISABLED"
		else
			state = self:GetButtonState()
		end
	end
	if state == "DISABLED" and self.locked_state == "PUSHED" then
		state = "PUSHED_DISABLED"
	end
	local texture = BUTTON_TEXTURES[state]
	self.left:SetTexture(texture)
	self.middle:SetTexture(texture)
	self.right:SetTexture(texture)
end

local function Button_SetButtonState(self, state, locked)
	self.locked_state = locked and state
	if self:IsEnabled() ~= 0 then
		DefaultButton_SetButtonState(self, state, locked)
	end
	Button_SetState(self)
end

local function Button_OnMouseDown(self)
	Button_SetState(self, self:IsEnabled() == 0 and "DISABLED" or "PUSHED")
end

local function Button_OnMouseUp(self)
	Button_SetState(self, self:IsEnabled() == 0 and "DISABLED" or "NORMAL")
end

local function Button_Enable(self)
	DefaultButton_Enable(self)
	if self.locked_state then
		Button_SetButtonState(self, self.locked_state, true)
	else
		Button_SetState(self)
	end
end

local function Button_Disable(self)
	DefaultButton_Disable(self)
	Button_SetState(self)
end

local function MakeButton(parent)
	local button = CreateFrame("Button", nil, parent)
	button:SetNormalFontObject(GameFontNormal)
	button:SetHighlightFontObject(GameFontHighlight)
	button:SetDisabledFontObject(GameFontDisable)

	local texture = button:CreateTexture()
	texture:SetTexCoord(0, 0.09375, 0, 0.6875)
	texture:SetPoint"LEFT"
	texture:SetSize(12, 22)
	button.left = texture

	texture = button:CreateTexture()
	texture:SetTexCoord(0.53125, 0.625, 0, 0.6875)
	texture:SetPoint"RIGHT"
	texture:SetSize(12, 22)
	button.right = texture

	texture = button:CreateTexture()
	texture:SetTexCoord(0.09375, 0.53125, 0, 0.6875)
	texture:SetPoint("LEFT", button.left, "RIGHT")
	texture:SetPoint("RIGHT", button.right, "LEFT")
	texture:SetHeight(22)
	button.middle = texture

	texture = button:CreateTexture()
	texture:SetTexture"Interface\\Buttons\\UI-Panel-Button-Highlight"
	texture:SetBlendMode"ADD"
	texture:SetTexCoord(0, 0.625, 0, 0.6875)
	texture:SetAllPoints(button)
	button:SetHighlightTexture(texture)

	button:SetScript("OnMouseDown", Button_OnMouseDown)
	button:SetScript("OnMouseUp", Button_OnMouseUp)
	button:SetScript("OnShow", Button_SetState)
	button.Enable = Button_Enable
	button.Disable = Button_Disable
	button.SetButtonState = Button_SetButtonState

	table.insert(Talented.uielements, button)
	return button
end

local function CreateBaseButtons(parent)
	local function Frame_OnEnter(self)
		if self.tooltip then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:SetText(self.tooltip, nil, nil, nil, nil, 1)
		end
	end

	local function Frame_OnLeave(self)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide()
		end
	end

	local b = MakeButton(parent)
	parent.bactions = b

	b:SetText(L["Actions"])
	b:SetSize(max(110, b:GetTextWidth() + 22), 22)
	b:SetScript("OnClick", function (self)
		Talented:OpenActionMenu(self)
	end)
	b:SetPoint("TOPLEFT", 14, -4)

	b = MakeButton(parent)
	parent.bmode = b

	b:SetText(L["Templates"])
	b:SetSize(max(110, b:GetTextWidth() + 22), 22)
	b:SetScript("OnClick", function (self)
		Talented:OpenTemplateMenu(self)
	end)
	b:SetPoint("LEFT", parent.bactions, "RIGHT", 14, 0)

	local b = MakeButton(parent)
	parent.bglyphs = b

	b:SetText(GLYPHS)
	b:SetSize(max(110, b:GetTextWidth() + 22), 22)
	b:SetScript("OnClick", function (self)
		Talented:ToggleGlyphFrame()
	end)
	b:SetPoint("LEFT", parent.bmode, "RIGHT", 14, 0)

	local e = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
	parent.editname = e
	e:SetFontObject(ChatFontNormal)
	e:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
	e:SetSize(200, 13)
	e:SetAutoFocus(false)

	e:SetScript("OnEscapePressed", function (this)
			this:ClearFocus()
		end)
	e:SetScript("OnEditFocusLost", function (this)
			this:SetText(Talented.template.name)
		end)
	e:SetScript("OnEnterPressed",  function (this)
			Talented:UpdateTemplateName(Talented.template, this:GetText())
			Talented:UpdateView()
			this:ClearFocus()
		end)
	e:SetScript("OnEnter", Frame_OnEnter)
	e:SetScript("OnLeave", Frame_OnLeave)
	e:SetPoint("LEFT", parent.bglyphs, "RIGHT", 14, 1)
	e.tooltip = L["You can edit the name of the template here. You must press the Enter key to save your changes."]

	local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	fs:SetJustifyH("LEFT")
	fs:SetSize(200, 13)
	fs:SetPoint("LEFT", parent.bglyphs, "RIGHT", 14, 0)
	parent.targetname = fs

	do
		local f = CreateFrame("Frame", nil, parent)
		local fs = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		fs:SetJustifyH("RIGHT")
		fs:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -14, 8)
		f:SetPoint("BOTTOMRIGHT")
		f:SetFrameLevel(parent:GetFrameLevel()+2)
		f.text = fs
		parent.pointsleft = f
	end

	local cb = CreateFrame("Checkbutton", nil, parent)
	parent.checkbox = cb

	local makeTexture = function (path, blend)
		local t = cb:CreateTexture()
		t:SetTexture(path)
		t:SetAllPoints(cb)
		if blend then
			t:SetBlendMode(blend)
		end
		return t
	end

	cb:SetSize(20, 20)

	local fs = cb:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	cb.label = fs
	fs:SetJustifyH("LEFT")
	fs:SetSize(400, 20)
	fs:SetPoint("LEFT", cb, "RIGHT", 1, 1)
	cb:SetNormalTexture(makeTexture("Interface\\Buttons\\UI-CheckBox-Up"))
	cb:SetPushedTexture(makeTexture("Interface\\Buttons\\UI-CheckBox-Down"))
	cb:SetDisabledTexture(makeTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled"))
	cb:SetCheckedTexture(makeTexture("Interface\\Buttons\\UI-CheckBox-Check"))
	cb:SetHighlightTexture(makeTexture("Interface\\Buttons\\UI-CheckBox-Highlight", "ADD"))
	cb:SetScript("OnClick", function ()
		if Talented.mode == "edit" then
			Talented:SetMode("view")
		else
			Talented:SetMode("edit")
		end
	end)
	cb:SetScript("OnEnter", Frame_OnEnter)
	cb:SetScript("OnLeave", Frame_OnLeave)
	cb:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 14, 8)
	cb:SetFrameLevel(parent:GetFrameLevel() + 2)

	local points = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	parent.points = points
	points:SetJustifyH("RIGHT")
	points:SetSize(80, 14)
	points:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -40, -6)

	local b = MakeButton(parent)
	parent.bactivate = b

	b:SetText(TALENT_SPEC_ACTIVATE)
	b:SetSize(b:GetTextWidth() + 40, 22)
	b:SetScript("OnClick", function (self)
		if self.talentGroup then
			SetActiveTalentGroup(self.talentGroup)
		end
	end)
	b:SetPoint("BOTTOM", 0, 6)
	b:SetFrameLevel(parent:GetFrameLevel() + 2)
end

local function BaseFrame_SetTabSize(self, tabs)
	local tabs = tabs or 3
	local bglyphs, editname, targetname, points = self.bglyphs, self.editname, self.targetname, self.points
	bglyphs:ClearAllPoints()
	editname:ClearAllPoints()
	targetname:ClearAllPoints()
	points:ClearAllPoints()
	if tabs == 1 then
		bglyphs:SetPoint("TOPLEFT", self.bactions, "BOTTOMLEFT", 0, -5)
		editname:SetPoint("TOPLEFT", bglyphs, "BOTTOMLEFT", 0, -4)
		targetname:SetPoint("TOPLEFT", bglyphs, "BOTTOMLEFT", 0, -5)
		points:SetPoint("TOPRIGHT", self, "TOPRIGHT", -8, -56)
	elseif tabs == 2 then
		bglyphs:SetPoint("LEFT", self.bmode, "RIGHT", 14, 0)
		editname:SetPoint("TOPLEFT", bglyphs, "BOTTOMLEFT", 0, -4)
		targetname:SetPoint("TOPLEFT", bglyphs, "BOTTOMLEFT", 0, -5)
		points:SetPoint("TOPRIGHT", self, "TOPRIGHT", -8, -31)
	elseif tabs == 3 then
		bglyphs:SetPoint("LEFT", self.bmode, "RIGHT", 14, 0)
		editname:SetPoint("LEFT", bglyphs, "RIGHT", 14, 1)
		targetname:SetPoint("LEFT", bglyphs, "RIGHT", 14, 0)
		points:SetPoint("TOPRIGHT", self, "TOPRIGHT", -40, -6)
	end
end

local function CloseButton_OnClick(self, button)
	if button == "LeftButton" then
		if self.OnClick then
			self:OnClick(button)
		else
			self:GetParent():Hide()
		end
	else
		Talented:OpenLockMenu(self, self:GetParent())
	end
end

function Talented:CreateCloseButton(parent, OnClickHandler)
	local close = CreateFrame("Button", nil, parent)

	local makeTexture = function (path, blend)
		local t = close:CreateTexture()
		t:SetAllPoints(close)
		t:SetTexture(path)
		if blend then
			t:SetBlendMode(blend)
		end
		return t
	end

	close:SetNormalTexture(makeTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up"))
	close:SetPushedTexture(makeTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down"))
	close:SetHighlightTexture(makeTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight", "ADD"))
	close:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	close:SetScript("OnClick", CloseButton_OnClick)
	close.OnClick = OnClickHandler

	close:SetSize(32, 32)
	close:SetPoint("TOPRIGHT", 1, 0)

	return close
end

function Talented:CreateBaseFrame()
	local frame = TalentedFrame or CreateFrame("Frame", "TalentedFrame", UIParent)
	frame:Hide()

	frame:SetFrameStrata("DIALOG")
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	frame:SetSize(50, 50)
	frame:SetBackdrop({
		bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		edgeSize = 16,
		tileSize = 32,
		insets = {
			left = 5,
			right = 5,
			top = 5,
			bottom = 5
		}
	})


	local close = self:CreateCloseButton(frame, function (self)
		HideUIPanel(self:GetParent())
	end)
	frame.close = close
	table.insert(Talented.uielements, close)

	CreateBaseButtons(frame)

	UISpecialFrames[#UISpecialFrames + 1] = "TalentedFrame"

	frame:SetScript("OnShow", function ()
		Talented:RegisterEvent"MODIFIER_STATE_CHANGED"
		SetButtonPulse(TalentMicroButton, 0, 1)
		PlaySound"TalentScreenOpen"
		Talented:UpdateMicroButtons()
	end)
	frame:SetScript("OnHide", function()
		PlaySound"TalentScreenClose"
		if Talented.mode == "apply" then
			Talented:SetMode(Talented:GetDefaultMode())
			Talented:Print(L["Error! Talented window has been closed during template application. Please reapply later."])
			Talented:EnableUI(true)
		end
		Talented:CloseMenu()
		Talented:UpdateMicroButtons()
		Talented:UnregisterEvent"MODIFIER_STATE_CHANGED"
	end)
	frame.SetTabSize = BaseFrame_SetTabSize
	frame.view = self.TalentView:new(frame, "base")
	self:LoadFramePosition(frame)
	self:SetFrameLock(frame)

	self.base = frame
	self.CreateBaseFrame = function (self) return self.base end
	return frame
end

function Talented:EnableUI(enable)
	if enable then
		for _, element in ipairs(self.uielements) do
			element:Enable()
		end
	else
		for _, element in ipairs(self.uielements) do
			element:Disable()
		end
	end
end

function Talented:MakeAlternateView()
	local frame = CreateFrame("Frame", "TalentedAltFrame", UIParent)

	frame:SetFrameStrata("DIALOG")
	if TalentedFrame then
		frame:SetFrameLevel(TalentedFrame:GetFrameLevel() + 5)
	end
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	frame:SetSize(50, 50)
	frame:SetBackdrop({
		bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		edgeSize = 16,
		tileSize = 32,
		insets = {
			left = 5,
			right = 5,
			top = 5,
			bottom = 5
		}
	})

	frame.close = self:CreateCloseButton(frame)
	frame.view = self.TalentView:new(frame, "alt")
	self:LoadFramePosition(frame)
	self:SetFrameLock(frame)

	self.altView = frame
	self.MakeAlternateView = function (self) return self.altView end
	return frame
end
