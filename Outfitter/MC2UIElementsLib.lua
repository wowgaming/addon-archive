local _, Addon = ...

Addon.UIElementsLib =
{
	Version = 1,
	Addon = Addon,
}

if not MC2UIElementsLib then
	MC2UIElementsLib = {}
end

if not Addon.UIElementsLibTexturePath then
	Addon.UIElementsLibTexturePath = Addon.AddonPath
end

----------------------------------------
-- Escape key handling for dialogs
----------------------------------------

function Addon.UIElementsLib:BeginDialog(pDialog)
	if not self.OpenDialogs then
		self.OpenDialogs = {}
		
		self.OrigStaticPopup_EscapePressed = StaticPopup_EscapePressed
		StaticPopup_EscapePressed = function (...) return self:StaticPopup_EscapePressed(...) end
	end
	
	table.insert(self.OpenDialogs, pDialog)
end

function Addon.UIElementsLib:EndDialog(pDialog)
	for vIndex, vDialog in ipairs(self.OpenDialogs) do
		if vDialog == pDialog then
			table.remove(self.OpenDialogs, vIndex)
			return
		end
	end
	
	Addon:ErrorMessage("DialogClosed called on an unknown dialog: %s", tostring(pDialog:GetName()))
end

function Addon.UIElementsLib:StaticPopup_EscapePressed(...)
	local vClosed = self.OrigStaticPopup_EscapePressed(...)
	local vNumDialogs = #self.OpenDialogs
	
	for vIndex = 1, vNumDialogs do
		local vDialog = self.OpenDialogs[1]
		vDialog:Cancel()
		vClosed = 1
	end
	
	return vClosed
end


----------------------------------------
Addon.UIElementsLib._StretchTextures = {}
----------------------------------------

function Addon.UIElementsLib._StretchTextures:Construct(pTextureInfo, pFrame, pLayer)
	for vName, vInfo in pairs(pTextureInfo) do
		local vTexture = pFrame:CreateTexture(nil, pLayer)
		
		if vInfo.Width then
			vTexture:SetWidth(vInfo.Width)
		end
		
		if vInfo.Height then
			vTexture:SetHeight(vInfo.Height)
		end
		
		vTexture:SetTexture(vInfo.Path)
		vTexture:SetTexCoord(vInfo.Coords.Left, vInfo.Coords.Right, vInfo.Coords.Top, vInfo.Coords.Bottom)
		
		self[vName] = vTexture
	end
	
	self.TopLeft:SetPoint("TOPLEFT", pFrame, "TOPLEFT")
	self.TopRight:SetPoint("TOPRIGHT", pFrame, "TOPRIGHT")
	self.BottomLeft:SetPoint("BOTTOMLEFT", pFrame, "BOTTOMLEFT")
	self.BottomRight:SetPoint("BOTTOMRIGHT", pFrame, "BOTTOMRIGHT")
	
	self.TopCenter:SetPoint("TOPLEFT", self.TopLeft, "TOPRIGHT")
	self.TopCenter:SetPoint("TOPRIGHT", self.TopRight, "TOPLEFT")
	
	self.MiddleLeft:SetPoint("TOPLEFT", self.TopLeft, "BOTTOMLEFT")
	self.MiddleLeft:SetPoint("BOTTOMLEFT", self.BottomLeft, "TOPLEFT")
	
	self.MiddleRight:SetPoint("TOPRIGHT", self.TopRight, "BOTTOMRIGHT")
	self.MiddleRight:SetPoint("BOTTOMRIGHT", self.BottomRight, "TOPRIGHT")
	
	self.BottomCenter:SetPoint("BOTTOMLEFT", self.BottomLeft, "BOTTOMRIGHT")
	self.BottomCenter:SetPoint("BOTTOMRIGHT", self.BottomRight, "BOTTOMLEFT")
	
	self.MiddleCenter:SetPoint("TOPLEFT", self.TopLeft, "BOTTOMRIGHT")
	self.MiddleCenter:SetPoint("BOTTOMLEFT", self.BottomLeft, "TOPRIGHT")
	self.MiddleCenter:SetPoint("TOPRIGHT", self.TopRight, "BOTTOMLEFT")
	self.MiddleCenter:SetPoint("BOTTOMRIGHT", self.BottomRight, "TOPLEFT")
end

----------------------------------------
if Addon.UIElementsLibTexturePath then
Addon.UIElementsLib._PortaitWindow = {}
----------------------------------------

Addon.UIElementsLib._PortaitWindow.BackgroundTextureInfo =
{
	TopLeft      = {Width = 100, Height = 100, Path = "Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft", Coords = {Left = 0, Right = 0.390625, Top = 0, Bottom = 0.390625}},
	TopCenter    = {Width = 156, Height = 100, Path = "Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft", Coords = {Left = 0.390625, Right = 1, Top = 0, Bottom = 0.390625}},
	TopRight     = {Width =  93, Height = 100, Path = "Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight", Coords = {Left = 0, Right = 0.7265625, Top = 0, Bottom = 0.390625}},
	MiddleLeft   = {Width = 100, Height = 156, Path = "Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft", Coords = {Left = 0, Right = 0.390625, Top = 0.390625, Bottom = 1}},
	MiddleCenter = {Width = 156, Height = 156, Path = "Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft", Coords = {Left = 0.390625, Right = 1, Top = 0.390625, Bottom = 1}},
	MiddleRight  = {Width =  93, Height = 156, Path = "Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight", Coords = {Left = 0, Right = 0.7265625, Top = 0.390625, Bottom = 1}},
	BottomLeft   = {Width = 100, Height = 120, Path = Addon.UIElementsLibTexturePath.."Textures\\CalendarFrame-BottomLeft", Coords = {Left = 0, Right = 0.390625, Top = 0, Bottom = 0.9375}},
	BottomCenter = {Width = 156, Height = 120, Path = Addon.UIElementsLibTexturePath.."Textures\\CalendarFrame-BottomLeft", Coords = {Left = 0.390625, Right = 1, Top = 0, Bottom = 0.9375}},
	BottomRight  = {Width =  93, Height = 120, Path = Addon.UIElementsLibTexturePath.."Textures\\CalendarFrame-BottomRight", Coords = {Left = 0, Right = 0.7265625, Top = 0, Bottom = 0.9375}},
}

function Addon.UIElementsLib._PortaitWindow:New(pTitle, pWidth, pHeight, pName)
	return CreateFrame("Frame", pName, UIParent)
end

function Addon.UIElementsLib._PortaitWindow:Construct(pTitle, pWidth, pHeight, pName)
	self:EnableMouse(true)
	self:SetMovable(true)
	self:SetWidth(pWidth)
	self:SetHeight(pHeight)
	
	self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, -104)
	
	self.BackgroundTextures = Addon:New(Addon.UIElementsLib._StretchTextures, self.BackgroundTextureInfo, self, "BORDER")
	
	self:SetScript("OnDragStart", function (self, pButton) self:StartMoving() end)
	self:SetScript("OnDragStop", function (self) self:StopMovingOrSizing() end)

	self.TitleText = self:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	self.TitleText:SetPoint("TOP", self, "TOP", 17, -18)
	self.TitleText:SetText(pTitle)
	
	self.CloseButton = CreateFrame("Button", nil, self, "UIPanelCloseButton")
	self.CloseButton:SetPoint("TOPRIGHT", self, "TOPRIGHT", 5, -8)
end

----------------------------------------
Addon.UIElementsLib._PanelSectionBackgroundInfo =
----------------------------------------
{
	TopLeft      = {Width = 4, Height = 4, Path = Addon.UIElementsLibTexturePath.."Textures\\PanelSectionBackground", Coords = {Left = 0, Right = 0.015625, Top = 0, Bottom = 0.0625}},
	TopCenter    = {Width = 248, Height = 4, Path = Addon.UIElementsLibTexturePath.."Textures\\PanelSectionBackground", Coords = {Left = 0.015625, Right = 0.984375, Top = 0, Bottom = 0.0625}},
	TopRight     = {Width =  4, Height = 4, Path = Addon.UIElementsLibTexturePath.."Textures\\PanelSectionBackground", Coords = {Left = 0.984375, Right = 1, Top = 0, Bottom = 0.0625}},
	MiddleLeft   = {Width = 4, Height = 56, Path = Addon.UIElementsLibTexturePath.."Textures\\PanelSectionBackground", Coords = {Left = 0, Right = 0.015625, Top = 0.0625, Bottom = 0.9375}},
	MiddleCenter = {Width = 248, Height = 56, Path = Addon.UIElementsLibTexturePath.."Textures\\PanelSectionBackground", Coords = {Left = 0.015625, Right = 0.984375, Top = 0.0625, Bottom = 0.9375}},
	MiddleRight  = {Width =  4, Height = 56, Path = Addon.UIElementsLibTexturePath.."Textures\\PanelSectionBackground", Coords = {Left = 0.984375, Right = 1, Top = 0.0625, Bottom = 0.9375}},
	BottomLeft   = {Width = 4, Height = 4, Path = Addon.UIElementsLibTexturePath.."Textures\\PanelSectionBackground", Coords = {Left = 0, Right = 0.015625, Top = 0.9375, Bottom = 1}},
	BottomCenter = {Width = 248, Height = 4, Path = Addon.UIElementsLibTexturePath.."Textures\\PanelSectionBackground", Coords = {Left = 0.015625, Right = 0.984375, Top = 0.9375, Bottom = 1}},
	BottomRight  = {Width =  4, Height = 4, Path = Addon.UIElementsLibTexturePath.."Textures\\PanelSectionBackground", Coords = {Left = 0.984375, Right = 1, Top = 0.9375, Bottom = 1}},
}

end -- if UIElementsLibTexturePath

----------------------------------------
function Addon.UIElementsLib:SetDialogBackdrop(pFrame)
----------------------------------------
	pFrame:SetBackdrop(
	{
		bgFile = "Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 512,
		edgeSize = 32,
		insets = {left = 11, right = 11, top = 11, bottom = 10}
	})
	
	pFrame:SetBackdropBorderColor(1, 1, 1)
	pFrame:SetBackdropColor(0.8, 0.8, 0.8, 1)
end

----------------------------------------
Addon.UIElementsLib._ModalDialogFrame = {}
----------------------------------------

function Addon.UIElementsLib._ModalDialogFrame:New(pParent, pTitle, pWidth, pHeight)
	return CreateFrame("Frame", nil, pParent)
end

function Addon.UIElementsLib._ModalDialogFrame:Construct(pParent, pTitle, pWidth, pHeight)
	Addon.UIElementsLib:SetDialogBackdrop(self)
	
	self:SetWidth(pWidth)
	self:SetHeight(pHeight)

	self.Title = self:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	self.Title:SetPoint("TOP", self, "TOP", 0, 0)
	self.Title:SetText(pTitle)
	
	self.TitleBackground = self:CreateTexture(nil, "ARTWORK")
	self.TitleBackground:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
	self.TitleBackground:SetTexCoord(0.234375, 0.7578125, 0, 0.625)
	self.TitleBackground:SetHeight(40)
	self.TitleBackground:SetPoint("LEFT", self.Title, "LEFT", -20, 0)
	self.TitleBackground:SetPoint("RIGHT", self.Title, "RIGHT", 20, 0)
	
	self.CancelButton = Addon:New(Addon.UIElementsLib._PushButton, self, CANCEL, 80)
	self.CancelButton:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -15, 20)
	self.CancelButton:SetScript("OnClick", function ()
		PlaySound("igMainMenuOptionCheckBoxOn")
		self:Cancel()
	end)
	
	self.DoneButton = Addon:New(Addon.UIElementsLib._PushButton, self, OKAY, 80)
	self.DoneButton:SetPoint("RIGHT", self.CancelButton, "LEFT", -7, 0)
	self.DoneButton:SetScript("OnClick", function ()
		PlaySound("igMainMenuOptionCheckBoxOn")
		self:Done()
	end)
end

----------------------------------------
Addon.UIElementsLib._SidebarWindowFrame = {}
----------------------------------------

function Addon.UIElementsLib._SidebarWindowFrame:New(pParent)
	return CreateFrame("Frame", nil, pParent or UIParent)
end

function Addon.UIElementsLib._SidebarWindowFrame:Construct()
	self:EnableMouse(true)
	
	self.CloseButton = CreateFrame("Button", nil, self, "UIPanelCloseButton")
	self.CloseButton:SetPoint("TOPRIGHT", self, "TOPRIGHT", 5, 5)
	
	self.Title = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	self.Title:SetPoint("CENTER", self, "TOP", 0, -10)
	
	-- Create the textures
	
	self.TopHeight = 80
	self.LeftWidth = 80
	self.BottomHeight = 183
	self.RightWidth = 94
	
	self.TopMargin = 13
	self.LeftMargin = 0
	self.BottomMargin = 3
	self.RightMargin = 1
	
	self.TextureWidth1 = 256
	self.TextureWidth2 = 128
	self.TextureUsedWidth2 = 94
	
	self.TextureHeight1 = 256
	self.TextureHeight2 = 256
	self.TextureUsedHeight2 = 183
	
	self.MiddleWidth1 = self.TextureWidth1 - self.LeftWidth
	self.MiddleWidth2 = 60
	
	self.TexCoordX1 = self.LeftWidth / self.TextureWidth1
	self.TexCoordX2 = (self.TextureUsedWidth2 - self.RightWidth) / self.TextureWidth2
	self.TexCoordX3 = self.TextureUsedWidth2 / self.TextureWidth2
	
	self.TexCoordY1 = self.TopHeight / self.TextureHeight1
	self.TexCoordY2 = (self.TextureUsedHeight2 - self.BottomHeight) / self.TextureHeight2
	self.TexCoordY3 = self.TextureUsedHeight2 / self.TextureHeight2
	
	self.Background = {}
	
	self.Background.TopRight = self:CreateTexture(nil, "BORDER")
	self.Background.TopRight:SetWidth(self.RightWidth)
	self.Background.TopRight:SetHeight(self.TopHeight)
	self.Background.TopRight:SetPoint("TOPRIGHT", self, "TOPRIGHT", self.RightMargin, self.TopMargin)
	self.Background.TopRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight")
	self.Background.TopRight:SetTexCoord(self.TexCoordX2, self.TexCoordX3, 0, self.TexCoordY1)
	
	self.Background.TopLeft = self:CreateTexture(nil, "BORDER")
	self.Background.TopLeft:SetHeight(self.TopHeight)
	self.Background.TopLeft:SetPoint("TOPLEFT", self, "TOPLEFT", -self.LeftMargin, self.TopMargin)
	self.Background.TopLeft:SetPoint("TOPRIGHT", self.Background.TopRight, "TOPLEFT")
	self.Background.TopLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft")
	self.Background.TopLeft:SetTexCoord(self.TexCoordX1, 1, 0, self.TexCoordY1)
	
	self.Background.BottomRight = self:CreateTexture(nil, "BORDER")
	self.Background.BottomRight:SetWidth(self.RightWidth)
	self.Background.BottomRight:SetHeight(self.BottomHeight)
	self.Background.BottomRight:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", self.RightMargin, -self.BottomMargin)
	self.Background.BottomRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomRight")
	self.Background.BottomRight:SetTexCoord(self.TexCoordX2, self.TexCoordX3, self.TexCoordY2, self.TexCoordY3)
	
	self.Background.BottomLeft = self:CreateTexture(nil, "BORDER")
	self.Background.BottomLeft:SetHeight(self.BottomHeight)
	self.Background.BottomLeft:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", -self.LeftMargin, -self.BottomMargin)
	self.Background.BottomLeft:SetPoint("BOTTOMRIGHT", self.Background.BottomRight, "BOTTOMLEFT")
	self.Background.BottomLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomLeft")
	self.Background.BottomLeft:SetTexCoord(self.TexCoordX1, 1, self.TexCoordY2, self.TexCoordY3)
	
	self.Background.RightMiddle = self:CreateTexture(nil, "BORDER")
	self.Background.RightMiddle:SetWidth(self.RightWidth)
	self.Background.RightMiddle:SetPoint("TOPRIGHT", self.Background.TopRight, "BOTTOMRIGHT")
	self.Background.RightMiddle:SetPoint("BOTTOMRIGHT", self.Background.BottomRight, "TOPRIGHT")
	self.Background.RightMiddle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight")
	self.Background.RightMiddle:SetTexCoord(self.TexCoordX2, self.TexCoordX3, self.TexCoordY1, 1)
	
	self.Background.LeftMiddle = self:CreateTexture(nil, "BORDER")
	self.Background.LeftMiddle:SetPoint("TOPLEFT", self.Background.TopLeft, "BOTTOMLEFT")
	self.Background.LeftMiddle:SetPoint("BOTTOMLEFT", self.Background.BottomLeft, "TOPLEFT")
	self.Background.LeftMiddle:SetPoint("TOPRIGHT", self.Background.TopRight, "BOTTOMLEFT")
	self.Background.LeftMiddle:SetPoint("BOTTOMRIGHT", self.Background.BottomRight, "TOPLEFT")
	self.Background.LeftMiddle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft")
	self.Background.LeftMiddle:SetTexCoord(self.TexCoordX1, 1, self.TexCoordY1, 1)
	
	self.Foreground = CreateFrame("Frame", nil, self)
	self.Foreground:SetAllPoints()
	self.Foreground:SetFrameLevel(self:GetFrameLevel() + 20)
	
	self.Foreground.Shadow = self.Foreground:CreateTexture(nil, "OVERLAY")
	self.Foreground.Shadow:SetWidth(18)
	self.Foreground.Shadow:SetPoint("TOPLEFT", self.Foreground, "TOPLEFT")
	self.Foreground.Shadow:SetPoint("BOTTOMLEFT", self.Foreground, "BOTTOMLEFT")
	self.Foreground.Shadow:SetTexture("Interface\\AchievementFrame\\UI-Achievement-HorizontalShadow")
	self.Foreground.Shadow:SetVertexColor(0, 0, 0)
end

----------------------------------------
Addon.UIElementsLib._Tabs = {}
----------------------------------------

if not MC2UIElementsLib.TabNameIndex then
	MC2UIElementsLib.TabNameIndex = 1
end

function Addon.UIElementsLib._Tabs:Construct(pFrame, pXOffset, pYOffset)
	self.ParentFrame = pFrame
	self.Tabs = {}
	self.SelectedTab = nil
	
	self.XOffset = (pXOffset or 0) + 18
	self.YOffset = (pYOffset or 0) + 3
end

function Addon.UIElementsLib._Tabs:NewTab(pTitle, pValue)
	local vTabName = "MC2UIElementsLibTab"..MC2UIElementsLib.TabNameIndex
	
	MC2UIElementsLib.TabNameIndex = MC2UIElementsLib.TabNameIndex + 1
	
	local vTab = CreateFrame("Button", vTabName, self.ParentFrame, "CharacterFrameTabButtonTemplate")
	
	vTab:SetText(pTitle)
	vTab.Value = pValue
	vTab:SetScript("OnClick", function(...) self:Tab_OnClick(...) end)
	
	PanelTemplates_DeselectTab(vTab)
	
	table.insert(self.Tabs, vTab)
	
	self:UpdateTabs()
end

function Addon.UIElementsLib._Tabs:UpdateTabs()
	local vPreviousTab
	
	for _, vTab in ipairs(self.Tabs) do
		if not vTab.Hidden then
			if not vPreviousTab then
				vTab:SetPoint("TOPLEFT", self.ParentFrame, "TOPLEFT", self.XOffset, self.YOffset)
			else
				vTab:SetPoint("TOPLEFT", vPreviousTab, "TOPRIGHT", -14, 0)
			end
			
			vPreviousTab = vTab
		end
	end
end

function Addon.UIElementsLib._Tabs:SelectTabByValue(pValue)
	self:SelectTab(self:GetTabByValue(pValue))
end

function Addon.UIElementsLib._Tabs:ShowTabByValue(pValue)
	self:ShowTab(self:GetTabByValue(pValue))
end

function Addon.UIElementsLib._Tabs:HideTabByValue(pValue)
	self:HideTab(self:GetTabByValue(pValue))
end

function Addon.UIElementsLib._Tabs:SelectTab(pTab)
	if pTab == self.SelectedTab then
		return
	end
	
	if self.SelectedTab then
		PanelTemplates_DeselectTab(self.SelectedTab)
		
		if self.OnDeselect then
			self:OnSelect(self.SelectedTab)
		end
	end
	
	self.SelectedTab = pTab
	
	if self.SelectedTab then
		PanelTemplates_SelectTab(self.SelectedTab)
		
		if self.OnSelect then
			self:OnSelect(self.SelectedTab)
		end
	end
end

function Addon.UIElementsLib._Tabs:ShowTab(pTab)
	if not pTab.Hidden then
		return
	end
	
	pTab.Hidden = false
	pTab:Show()
	self:UpdateTabs()
end

function Addon.UIElementsLib._Tabs:HideTab(pTab)
	if pTab.Hidden then
		return
	end
	
	pTab.Hidden = true
	pTab:Hide()
	self:UpdateTabs()
end

function Addon.UIElementsLib._Tabs:GetTabByValue(pValue)
	for vIndex, vTab in ipairs(self.Tabs) do
		if vTab.Value == pValue then
			return vTab, vIndex
		end
	end
end

function Addon.UIElementsLib._Tabs:Tab_OnClick(pTab, pButton)
	PlaySound("igMainMenuOpen")
	self:SelectTabByValue(pTab.Value)
end

----------------------------------------
Addon.UIElementsLib._TabbedView = {}
----------------------------------------

function Addon.UIElementsLib._TabbedView:New(pParent, pXOffset, pYOffset)
	return CreateFrame("Frame", nil, pParent or UIParent)
end

function Addon.UIElementsLib._TabbedView:Construct(pParent, pXOffset, pYOffset)
	self.Views = {}
	self.CurrentFrame = nil
	
	self:SetWidth(1)
	self:SetHeight(1)
	
	self:SetPoint("TOPLEFT", pParent, "BOTTOMLEFT", pXOffset, pYOffset)
	
	self.Tabs = Addon:New(Addon.UIElementsLib._Tabs, self)
	self.Tabs.OnSelect = function (tabs, tab) self:SelectView(tab.Value) end
end

function Addon.UIElementsLib._TabbedView:AddView(pFrame, pTitle)
	local vView =
	{
		Title = pTitle,
		Frame = pFrame,
		Tab = self.Tabs:NewTab(pTitle, pFrame),
	}
	
	pFrame:Hide()
	
	table.insert(self.Views, vView)
	
	return vView
end

function Addon.UIElementsLib._TabbedView:SelectView(pFrame)
	if self.CurrentFrame == pFrame then
		return
	end
	
	if self.CurrentFrame then
		self:DeactivateView(self.CurrentFrame)
		self.CurrentFrame:Hide()
	end
	
	self.CurrentFrame = pFrame
	
	if self.CurrentFrame then
		self.CurrentFrame:Show()
		self:ActivateView(self.CurrentFrame)
	end
	
	self.Tabs:SelectTabByValue(self.CurrentFrame)
end

function Addon.UIElementsLib._TabbedView:GetViewByFrame(pFrame)
	for _, vView in ipairs(self.Views) do
		if vView.Frame == pFrame then
			return vView
		end
	end
end

function Addon.UIElementsLib._TabbedView:ShowView(pFrame)
	self.Tabs:ShowTabByValue(pFrame)
end

function Addon.UIElementsLib._TabbedView:HideView(pFrame)
	self.Tabs:HideTabByValue(pFrame)
end

function Addon.UIElementsLib._TabbedView:ActivateView(pView)
	if pView.ViewActivated then
		pView:ViewActivated()
	end
end

function Addon.UIElementsLib._TabbedView:DeactivateView(pView)
	if pView.ViewDeactivated then
		pView:ViewDeactivated()
	end
end

----------------------------------------
if Addon.UIElementsLibTexturePath then
Addon.UIElementsLib._ScrollbarTrench = {}
----------------------------------------

function Addon.UIElementsLib._ScrollbarTrench:New(pParent)
	return CreateFrame("Frame", nil, pParent)
end

function Addon.UIElementsLib._ScrollbarTrench:Construct(pParent)
	self:SetWidth(27)
	
	self.TopTexture = self:CreateTexture(nil, "OVERLAY")
	self.TopTexture:SetHeight(26)
	self.TopTexture:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 2)
	self.TopTexture:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 2)
	self.TopTexture:SetTexture(Addon.UIElementsLibTexturePath.."Textures\\ScrollbarTrench")
	self.TopTexture:SetTexCoord(0, 0.84375, 0, 0.1015625)
	
	self.BottomTexture = self:CreateTexture(nil, "OVERLAY")
	self.BottomTexture:SetHeight(26)
	self.BottomTexture:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, -1)
	self.BottomTexture:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, -1)
	self.BottomTexture:SetTexture(Addon.UIElementsLibTexturePath.."Textures\\ScrollbarTrench")
	self.BottomTexture:SetTexCoord(0, 0.84375, 0.90234375, 1)
	
	self.MiddleTexture = self:CreateTexture(nil, "OVERLAY")
	self.MiddleTexture:SetPoint("TOPLEFT", self.TopTexture, "BOTTOMLEFT")
	self.MiddleTexture:SetPoint("BOTTOMRIGHT", self.BottomTexture, "TOPRIGHT")
	self.MiddleTexture:SetTexture(Addon.UIElementsLibTexturePath.."Textures\\ScrollbarTrench")
	self.MiddleTexture:SetTexCoord(0, 0.84375, 0.1015625, 0.90234375)
end

----------------------------------------
Addon.UIElementsLib._Scrollbar = {}
----------------------------------------

function Addon.UIElementsLib._Scrollbar:New(pParent)
	return CreateFrame("Slider", nil, pParent)
end

function Addon.UIElementsLib._Scrollbar:Construct(pParent)
	self:SetWidth(16)
	
	self.UpButton = CreateFrame("Button", nil, self)
	self.UpButton:SetWidth(16)
	self.UpButton:SetHeight(16)
	self.UpButton:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up")
	self.UpButton:GetNormalTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	self.UpButton:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Down")
	self.UpButton:GetPushedTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	self.UpButton:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Disabled")
	self.UpButton:GetDisabledTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	self.UpButton:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Highlight")
	self.UpButton:GetHighlightTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	self.UpButton:GetHighlightTexture():SetBlendMode("ADD")
	self.UpButton:SetPoint("BOTTOM", self, "TOP")
	self.UpButton:SetScript("OnClick", function (pButtonFrame, pButton)
		self:SetValue(self:GetValue() - self:GetHeight() * 0.5)
		PlaySound("UChatScrollButton")
	end)
	
	self.DownButton = CreateFrame("Button", nil, self)
	self.DownButton:SetWidth(16)
	self.DownButton:SetHeight(16)
	self.DownButton:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up")
	self.DownButton:GetNormalTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	self.DownButton:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Down")
	self.DownButton:GetPushedTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	self.DownButton:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Disabled")
	self.DownButton:GetDisabledTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	self.DownButton:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Highlight")
	self.DownButton:GetHighlightTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	self.DownButton:GetHighlightTexture():SetBlendMode("ADD")
	self.DownButton:SetPoint("TOP", self, "BOTTOM")
	self.DownButton:SetScript("OnClick", function (pButtonFrame, pButton)
		self:SetValue(self:GetValue() + self:GetHeight() * 0.5)
		PlaySound("UChatScrollButton")
	end)
	
	local vThumbTexture = self:CreateTexture(nil, "OVERLAY")
	
	vThumbTexture:SetTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	vThumbTexture:SetWidth(16)
	vThumbTexture:SetHeight(24)
	vThumbTexture:SetTexCoord(0.25, 0.75, 0.125, 0.875)
	
	self:SetThumbTexture(vThumbTexture)
end

function Addon.UIElementsLib._Scrollbar:SetValue(...)
	self.Inherited.SetValue(self, ...)
	self:AdjustButtons()
end
	
function Addon.UIElementsLib._Scrollbar:SetMinMaxValues(...)
	self.Inherited.SetMinMaxValues(self, ...)
	self:AdjustButtons()
end

function Addon.UIElementsLib._Scrollbar:AdjustButtons()
	local vMin, vMax = self:GetMinMaxValues()
	local vValue = self:GetValue()
	
	if math.floor(vValue) <= vMin then
		self.UpButton:Disable()
	else
		self.UpButton:Enable()
	end
	
	if math.ceil(vValue) >= vMax then
		self.DownButton:Disable()
	else
		self.DownButton:Enable()
	end
end

----------------------------------------
Addon.UIElementsLib._ScrollingList = {}
----------------------------------------

if not MC2UIElementsLib.ScrollFrameIndex then
	MC2UIElementsLib.ScrollFrameIndex = 1
end

function Addon.UIElementsLib._ScrollingList:New(pParent, pItemHeight)
	return CreateFrame("Frame", nil, pParent)
end

function Addon.UIElementsLib._ScrollingList:Construct(pParent, pItemHeight)
	self.ItemHeight = pItemHeight or 27
	
	self.ScrollbarTrench = Addon:New(Addon.UIElementsLib._ScrollbarTrench, self)
	self.ScrollbarTrench:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
	self.ScrollbarTrench:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
	
	local vScrollFrameName = "MC2UIElementsLibScrollFrame"..MC2UIElementsLib.ScrollFrameIndex
	MC2UIElementsLib.ScrollFrameIndex = MC2UIElementsLib.ScrollFrameIndex + 1
	
	self.ScrollFrame = CreateFrame("ScrollFrame", vScrollFrameName, self, "FauxScrollFrameTemplate")
	self.ScrollFrame:SetPoint("TOPLEFT", self, "TOPLEFT")
	self.ScrollFrame:SetPoint("BOTTOMRIGHT", self.ScrollbarTrench, "BOTTOMLEFT", 0, 0)
	self.ScrollFrame:SetScript("OnVerticalScroll", function (frame, offset)
		FauxScrollFrame_OnVerticalScroll(frame, offset, self.ItemHeight, function ()
			if self.DrawingFunc then
				self:DrawingFunc()
			end
		end)
	end)
	
	self.ScrollFrame:SetFrameLevel(self:GetFrameLevel() + 1) -- Ensure it's above the parent
	self.ScrollFrame:Show() -- Ensure it's visible
end

function Addon.UIElementsLib._ScrollingList:GetOffset()
	return FauxScrollFrame_GetOffset(self.ScrollFrame)
end

function Addon.UIElementsLib._ScrollingList:GetNumVisibleItems()
	local vHeight = self:GetHeight() or 0
	return math.floor(vHeight / self.ItemHeight)
end

function Addon.UIElementsLib._ScrollingList:SetNumItems(pNumItems)
	local vWidth, vHeight = self:GetWidth(), self:GetHeight()
	local vNumVisibleItems = self:GetNumVisibleItems()
	
	FauxScrollFrame_Update(
			self.ScrollFrame,
			pNumItems,
			vNumVisibleItems,
			self.ItemHeight,
			nil,
			nil,
			nil,
			nil,
			vWidth, vHeight)
end

----------------------------------------
Addon.UIElementsLib._ScrollingItemList = {}
----------------------------------------

function Addon.UIElementsLib._ScrollingItemList:New(pParent, pItemMethods, pItemHeight)
	return Addon:New(Addon.UIElementsLib._ScrollingList, pParent, pItemHeight)
end

function Addon.UIElementsLib._ScrollingItemList:Construct(pParent, pItemMethods, pItemHeight)
	self.ItemMethods = pItemMethods
	self.ItemFrames = {}
end

function Addon.UIElementsLib._ScrollingItemList:GetNumVisibleItems()
	local vNumVisibleItems = self.Inherited.GetNumVisibleItems(self)
	
	while #self.ItemFrames < vNumVisibleItems do
		local vListItem = Addon:New(self.ItemMethods, self)
		
		if #self.ItemFrames == 0 then
			vListItem:SetPoint("TOPLEFT", self.ScrollFrame, "TOPLEFT")
			vListItem:SetPoint("TOPRIGHT", self.ScrollFrame, "TOPRIGHT")
		else
			local vPreviousListItem = self.ItemFrames[#self.ItemFrames]
			
			vListItem:SetPoint("TOPLEFT", vPreviousListItem, "BOTTOMLEFT")
			vListItem:SetPoint("TOPRIGHT", vPreviousListItem, "BOTTOMRIGHT")
		end
		
		table.insert(self.ItemFrames, vListItem)
	end
	
	return vNumVisibleItems
end

function Addon.UIElementsLib._ScrollingItemList:SetNumItems(pNumItems)
	self.Inherited.SetNumItems(self, pNumItems)
	
	-- Adjust visibility
	
	local vNumVisibleItems = self:GetNumVisibleItems() -- This will allocate the item frames
	
	if pNumItems < vNumVisibleItems then
		vNumVisibleItems = pNumItems
	end
	
	for vItemIndex = 1, vNumVisibleItems do
		self.ItemFrames[vItemIndex]:Show()
	end
	
	for vItemIndex = vNumVisibleItems + 1, #self.ItemFrames do
		self.ItemFrames[vItemIndex]:Hide()
	end
end

end -- if Addon.UIElementsLibTexturePath then

----------------------------------------
Addon.UIElementsLib._CheckButton = {}
----------------------------------------

function Addon.UIElementsLib._CheckButton:New(pParent, pTitle, pSmall)
	return CreateFrame("CheckButton", nil, pParent)
end

function Addon.UIElementsLib._CheckButton:Construct(pParent, pTitle, pSmall)
	self.Enabled = true
	
	self.Small = pSmall
	
	self:SetWidth(self.Small and 18 or 23)
	self:SetHeight(self.Small and 16 or 21)
	
	self.Title = self:CreateFontString(nil, "ARTWORK", self.Small and "GameFontNormalSmall" or "GameFontNormal")
	self.Title:SetPoint("LEFT", self, "RIGHT", 2, 0)
	self.Title:SetJustifyH("LEFT")
	self.Title:SetText(pTitle or "")
	
	--self:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	--self:GetDisabledCheckedTexture():SetTexCoord(0.125, 0.84375, 0.15625, 0.8125)
	
	self:SetDisplayMode("CHECKBOX")
end

function Addon.UIElementsLib._CheckButton:SetEnabled(pEnabled)
	self.Enabled = pEnabled
	
	if pEnabled then
		self:Enable()
	else
		self:Disable()
	end
	
	self:SetAlpha(pEnabled and 1 or 0.5)
end

function Addon.UIElementsLib._CheckButton:SetAnchorMode(pMode)
	self.Title:ClearAllPoints()
	self:ClearAllPoints()
	
	if pMode == "TITLE" then
		self:SetPoint("RIGHT", self.Title, "LEFT", -2, 0)
	else
		self.Title:SetPoint("LEFT", self, "RIGHT", 2, 0)
	end
end

function Addon.UIElementsLib._CheckButton:SetDisplayMode(pMode)
	self.DisplayMode = pMode
	
	if pMode == "LEADER"
	or pMode == "ASSIST" then
		self:UpdateLeaderModeTexture()
		
		self:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
		self:GetHighlightTexture():SetTexCoord(0, 1, 0, 1)
		self:GetHighlightTexture():SetBlendMode("ADD")
		
		if self.DisplayMode == "ASSIST" then
			self:SetNormalTexture("Interface\\GroupFrame\\UI-Group-AssistantIcon")
			self:SetPushedTexture("Interface\\GroupFrame\\UI-Group-AssistantIcon")
			self:SetCheckedTexture("Interface\\GroupFrame\\UI-Group-AssistantIcon")
		else
			self:SetNormalTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")
			self:SetCheckedTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")
			self:SetPushedTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")
		end
		
		if self.MultiSelect then
			self:GetCheckedTexture():SetDesaturated(true)
			self:GetCheckedTexture():SetVertexColor(1, 1, 1, 0.6)
		else
			self:GetCheckedTexture():SetDesaturated(false)
			self:GetCheckedTexture():SetVertexColor(1, 1, 1, 1)
		end
		
		local vNormalTexture = self:GetNormalTexture()
		
		vNormalTexture:SetDesaturated(true)
		vNormalTexture:SetVertexColor(1, 1, 1, 0.33)
		
	elseif pMode == "EXPAND" then
		self:UpdateExpandModeTexture()
		
		self:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
		self:GetHighlightTexture():SetTexCoord(0, 1, 0, 1)
		self:GetHighlightTexture():SetBlendMode("ADD")
		
		self:SetCheckedTexture("")
	else
		if pMode == "BUSY" then
			self:SetNormalTexture(Addon.UIElementsLibTexturePath.."Textures\\Gear")
			self:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
			self:SetCheckedTexture("")
		else -- CHECKBOX
			self:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
			self:GetNormalTexture():SetTexCoord(0.125, 0.84375, 0.15625, 0.8125)
			
			if self.MultiSelect then
				self:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
			else
				self:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
			end
			
			self:GetCheckedTexture():SetTexCoord(0.125, 0.84375, 0.15625, 0.8125)
		end
		
		self:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
		self:GetPushedTexture():SetTexCoord(0.125, 0.84375, 0.15625, 0.8125)
		
		self:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
		self:GetHighlightTexture():SetTexCoord(0.125, 0.84375, 0.15625, 0.8125)
		self:GetHighlightTexture():SetBlendMode("ADD")
	end
end

function Addon.UIElementsLib._CheckButton:SetChecked(pChecked)
	self.Inherited.SetChecked(self, pChecked)
	
	if self.DisplayMode == "LEADER"
	or self.DisplayMode == "ASSIST" then
		self:UpdateLeaderModeTexture()
	elseif self.DisplayMode == "EXPAND" then
		self:UpdateExpandModeTexture()
	end
end

function Addon.UIElementsLib._CheckButton:UpdateExpandModeTexture()
	if self:GetChecked() then
		self:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
		self:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
		
		self:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down")
		self:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
	else
		self:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
		self:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
		
		self:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
		self:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
	end
end

function Addon.UIElementsLib._CheckButton:UpdateLeaderModeTexture()
end

function Addon.UIElementsLib._CheckButton:SetTitle(pTitle)
	self.Title:SetText(pTitle)
end

function Addon.UIElementsLib._CheckButton:SetMultiSelect(pMultiSelect)
	self.MultiSelect = pMultiSelect
	self:SetDisplayMode(self.DisplayMode)
end

----------------------------------------
Addon.UIElementsLib._ExpandAllButton = {}
----------------------------------------

function Addon.UIElementsLib._ExpandAllButton:New(pParent)
	return Addon:New(Addon.UIElementsLib._CheckButton, pParent, ALL)
end

function Addon.UIElementsLib._ExpandAllButton:Construct(pParent)
	self:SetWidth(20)
	self:SetHeight(20)
	
	self.TabLeft = self:CreateTexture(nil, "BACKGROUND")
	self.TabLeft:SetWidth(8)
	self.TabLeft:SetHeight(32)
	self.TabLeft:SetPoint("RIGHT", self, "LEFT", 3, 3)
	self.TabLeft:SetTexture("Interface\\QuestFrame\\UI-QuestLogSortTab-Left")
	
	self.TabMiddle = self:CreateTexture(nil, "BACKGROUND")
	self.TabMiddle:SetHeight(32)
	self.TabMiddle:SetPoint("LEFT", self.TabLeft, "RIGHT")
	self.TabMiddle:SetPoint("RIGHT", self.Title, "RIGHT", 5, 0)
	self.TabMiddle:SetTexture("Interface\\QuestFrame\\UI-QuestLogSortTab-Middle")
	
	self.TabRight = self:CreateTexture(nil, "BACKGROUND")
	self.TabRight:SetWidth(8)
	self.TabRight:SetHeight(32)
	self.TabRight:SetPoint("LEFT", self.TabMiddle, "RIGHT")
	self.TabRight:SetTexture("Interface\\QuestFrame\\UI-QuestLogSortTab-Right")
	
	self:SetDisplayMode("EXPAND")
end

----------------------------------------
Addon.UIElementsLib._Window = {}
----------------------------------------

function Addon.UIElementsLib._Window:New()
	return CreateFrame("Frame", nil, UIParent)
end

function Addon.UIElementsLib._Window:Construct()
	self:SetMovable(true)
	self:SetScript("OnDragStart", self.OnDragStart)
	self:SetScript("OnDragStop", self.OnDragStop)
end

function Addon.UIElementsLib._Window:OnDragStart()
	self:StartMoving()
end

function Addon.UIElementsLib._Window:OnDragStop()
	self:StopMovingOrSizing()
end

function Addon.UIElementsLib._Window:Close()
	self:Hide()
end

----------------------------------------
Addon.UIElementsLib._FloatingWindow = {}
----------------------------------------

function Addon.UIElementsLib._FloatingWindow:New()
	return Addon:New(Addon.UIElementsLib._Window)
end

function Addon.UIElementsLib._FloatingWindow:Construct()
	self.ContentFrame = Addon:New(Addon.UIElementsLib._PlainBorderedFrame, self)
	self.ContentFrame:SetAllPoints()
	
	self.TitleBar = Addon:New(Addon.UIElementsLib._FadingTitleBar, self)
end

function Addon.UIElementsLib._FloatingWindow:SetTitle(pTitle)
	self.TitleBar:SetTitle(pTitle)
end

function Addon.UIElementsLib._FloatingWindow:OnDragStart()
	self.Inherited.OnDragStart(self)
	self.TitleBar:SetForceFullBar(true)
end

function Addon.UIElementsLib._FloatingWindow:OnDragStop()
	self.Inherited.OnDragStop(self)
	self.TitleBar:SetForceFullBar(false)
end

----------------------------------------
Addon.UIElementsLib._PlainBorderedFrame = {}
----------------------------------------

function Addon.UIElementsLib._PlainBorderedFrame:New(pParent)
	return CreateFrame("Frame", nil, pParent)
end

function Addon.UIElementsLib._PlainBorderedFrame:Construct(pParent)
	self:SetBackdrop(
	{
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	})
	
	self:SetBackdropBorderColor(0.75, 0.75, 0.75)
	self:SetBackdropColor(0.15, 0.15, 0.15)
	self:SetAlpha(1.0)
end

----------------------------------------
Addon.UIElementsLib._CloseButton = {}
----------------------------------------

function Addon.UIElementsLib._CloseButton:New(pParent)
	return CreateFrame("Button", nil, pParent)
end

function Addon.UIElementsLib._CloseButton:Construct(pParent)
	local vTexture
	
	self:SetWidth(16)
	self:SetHeight(15)
	
	local vTexture = self:CreateTexture(nil, "ARTWORK")
	
	self:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
	vTexture = self:GetNormalTexture()
	vTexture:SetTexCoord(0.1875, 0.78125, 0.21875, 0.78125)
	
	self:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
	vTexture = self:GetPushedTexture()
	vTexture:SetTexCoord(0.1875, 0.78125, 0.21875, 0.78125)
	
	self:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
	vTexture = self:GetHighlightTexture()
	vTexture:SetTexCoord(0.1875, 0.78125, 0.21875, 0.78125)
	vTexture:SetBlendMode("ADD")
end

----------------------------------------
Addon.UIElementsLib._FadingTitleBar = {}
----------------------------------------

function Addon.UIElementsLib._FadingTitleBar:New(pParent)
	return CreateFrame("Button", nil, pParent)
end

function Addon.UIElementsLib._FadingTitleBar:Construct(pParent)
	self:SetHeight(15)
	self:SetPoint("BOTTOMLEFT", self:GetParent(), "TOPLEFT", 0, 0)
	self:SetPoint("BOTTOMRIGHT", self:GetParent(), "TOPRIGHT", 0, 0)
	
	self.FullBar = CreateFrame("Frame", nil, self)
	self.FullBar:SetAllPoints()
	
	self.FullBar.BarLeft = self.FullBar:CreateTexture(nil, "BACKGROUND")
	self.FullBar.BarLeft:SetWidth(12)
	self.FullBar.BarLeft:SetHeight(22)
	self.FullBar.BarLeft:SetPoint("TOPLEFT", self, "TOPLEFT")
	self.FullBar.BarLeft:SetTexture("Interface\\Addons\\ForgeWay\\Textures\\GroupTitleBar")
	self.FullBar.BarLeft:SetTexCoord(0, 0.09375, 0.3125, 1)

	self.FullBar.BarRight = self.FullBar:CreateTexture(nil, "BACKGROUND")
	self.FullBar.BarRight:SetWidth(32)
	self.FullBar.BarRight:SetHeight(22)
	self.FullBar.BarRight:SetPoint("TOPRIGHT", self, "TOPRIGHT", 1, 0)
	self.FullBar.BarRight:SetTexture("Interface\\Addons\\ForgeWay\\Textures\\GroupTitleBar")
	self.FullBar.BarRight:SetTexCoord(0.75, 1, 0.3125, 1)

	self.FullBar.BarMiddle = self.FullBar:CreateTexture(nil, "BACKGROUND")
	self.FullBar.BarMiddle:SetHeight(22)
	self.FullBar.BarMiddle:SetPoint("TOPLEFT", self.FullBar.BarLeft, "TOPRIGHT")
	self.FullBar.BarMiddle:SetPoint("TOPRIGHT", self.FullBar.BarRight, "TOPLEFT")
	self.FullBar.BarMiddle:SetTexture("Interface\\Addons\\ForgeWay\\Textures\\GroupTitleBar")
	self.FullBar.BarMiddle:SetTexCoord(0.09375, 0.75, 0.3125, 1)
	
	self.FullBar.Title = self.FullBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	self.FullBar.Title:SetPoint("LEFT", self.FullBar.BarLeft, "RIGHT", -4, 2)
	self.FullBar.Title:SetPoint("RIGHT", self.FullBar.BarRight, "LEFT", 0, 2)
	
	self.FullBar.CloseButton = Addon:New(Addon.UIElementsLib._CloseButton, self.FullBar)
	self.FullBar.CloseButton:SetPoint("RIGHT", self.FullBar.BarRight, "RIGHT", -5, 1)
	self.FullBar.CloseButton:SetScript("OnEnter", function (self) self:GetParent():GetParent():ShowFullBar(true) end)
	self.FullBar.CloseButton:SetScript("OnLeave", function (self) self:GetParent():GetParent():ShowFullBar(false) end)
	self.FullBar.CloseButton:Hide()
	
	-- Create the compact version (shown when the mouse isn't over the bar)
	
	self.CompactBar = CreateFrame("Frame", nil, self)
	self.CompactBar:SetAllPoints()
	
	self.CompactBar.Title = self.CompactBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	self.CompactBar.Title:SetPoint("LEFT", self.CompactBar, "LEFT", 0, -1)
	self.CompactBar.Title:SetPoint("RIGHT", self.CompactBar, "RIGHT", 0, -1)
	
	self:SetScript("OnEnter", function (self) self:ShowFullBar(true) end)
	self:SetScript("OnLeave", function (self) self:ShowFullBar(false) end)
	self:SetScript("OnMouseDown", function (self) self:GetParent():OnDragStart() end)
	self:SetScript("OnMouseUp", function (self) self:GetParent():OnDragStop() end)
	
	-- Start out with the full bar hidden
	
	self.FullBar:SetAlpha(0)
	self.CompactBar:SetAlpha(1)
	
	self.FullBarShown = false
	self.FullBarForced = false
	
	--
	
	self:RegisterForDrag("LeftButton")
	self:RegisterForClicks("RightButtonUp")
end

function Addon.UIElementsLib._FadingTitleBar:SetForceFullBar(pForce)
	if self.FullBarForced == pForce then
		return
	end
	
	self.FullBarForced = pForce
	self:UpdateFullBarVisibility()
end

function Addon.UIElementsLib._FadingTitleBar:ShowFullBar(pShow)
	if self.FullBarShown == pShow then
		return
	end
	
	self.FullBarShown = pShow
	self:UpdateFullBarVisibility()
end

function Addon.UIElementsLib._FadingTitleBar:UpdateFullBarVisibility()
	if self.FullBarShown or self.FullBarForced then
		UIFrameFadeRemoveFrame(self.FullBar)
		UIFrameFadeRemoveFrame(self.CompactBar)
		
		self.FullBar:SetAlpha(1)
		self.CompactBar:SetAlpha(0)
	else
		if pForceState then
			UIFrameFadeRemoveFrame(self.FullBar)
			UIFrameFadeRemoveFrame(self.CompactBar)
			self.FullBar:SetAlpha(0)
			self.CompactBar:SetAlpha(1)
		else
			UIFrameFadeOut(self.FullBar, 0.5, 1, 0)
			UIFrameFadeIn(self.CompactBar, 0.5, 0, 1)
		end
	end
end

function Addon.UIElementsLib._FadingTitleBar:SetTitle(pTitle)
	self.FullBar.Title:SetText(pTitle)
	self.CompactBar.Title:SetText(pTitle)
end

function Addon.UIElementsLib._FadingTitleBar:SetCloseFunc(pCloseFunc)
	self.FullBar.CloseButton:SetScript("OnClick", pCloseFunc)
	self.FullBar.CloseButton:Show()
end

----------------------------------------
Addon.UIElementsLib._ExpandButton = {}
----------------------------------------

function Addon.UIElementsLib._ExpandButton:New(pParent)
	return CreateFrame("Button", nil, pParent)
end

function Addon.UIElementsLib._ExpandButton:Construct(pParent)
	self:SetWidth(16)
	self:SetHeight(16)
	
	self:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP")
	
	local vHighlight = self:CreateTexture(nil, "HIGHLIGHT")
	vHighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
	vHighlight:SetBlendMode("ADD")
	vHighlight:SetAllPoints()
	
	self:SetHighlightTexture(vHighlight)
end

function Addon.UIElementsLib._ExpandButton:SetExpanded(pExpanded)
	if pExpanded then
		self:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP")
	else
		self:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP")
	end
end

----------------------------------------
Addon.UIElementsLib._DropDownMenuButton = {}
----------------------------------------

if not MC2UIElementsLib_Globals then
	MC2UIElementsLib_Globals =
	{
		NumDropDownMenuButtons = 0,
	}
end

function Addon.UIElementsLib._DropDownMenuButton:New(pParent, pMenuFunc, pWidth)
	MC2UIElementsLib_Globals.NumDropDownMenuButtons = MC2UIElementsLib_Globals.NumDropDownMenuButtons + 1
	
	local vName = "MC2UIElementsLib_DropDownMenuButton"..MC2UIElementsLib_Globals.NumDropDownMenuButtons
	
	return CreateFrame("Frame", vName, pParent)
end

function Addon.UIElementsLib._DropDownMenuButton:Construct(pParent, pMenuFunc, pWidth)
	local vButtonSize = 24
	
	if not pWidth then pWidth = vButtonSize end
	
	if pWidth < vButtonSize then
		vButtonSize = pWidth
	end
	
	self:SetWidth(pWidth)
	self:SetHeight(vButtonSize)
	
	self.Button = CreateFrame("Button", nil, self)
	self.Button:SetWidth(vButtonSize)
	self.Button:SetHeight(vButtonSize)
	self.Button:SetPoint("RIGHT", self, "RIGHT", 1, 0)
	self.Button:SetScript("OnClick", function (frame, button) self:ToggleMenu() end)
	self.Button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	self.Button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
	self.Button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
	
	self.Button.HighlightTexture = self.Button:CreateTexture(nil, "HIGHLIGHT")
	self.Button.HighlightTexture:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	self.Button.HighlightTexture:SetBlendMode("ADD")
	self.Button.HighlightTexture:SetAllPoints()
	
	self.MenuFunc = pMenuFunc
	self.OrigHeight = self:GetHeight()
	UIDropDownMenu_Initialize(self, self.WoWMenuInitFunction)
	self:SetHeight(self.OrigHeight)
end

function Addon.UIElementsLib._DropDownMenuButton:SetMenuFunc(pMenuFunc)
end

function Addon.UIElementsLib._DropDownMenuButton:ToggleMenu()
	PlaySound("igMainMenuOptionCheckBoxOn")
	
	self.relativeTo = self
	self.point = "TOPRIGHT"
	self.relativePoint = "BOTTOMRIGHT"
	self.xOffset = 0
	self.yOffset = 9
	
	ToggleDropDownMenu(nil, nil, self)
end

--[[
info.text = [STRING]  --  The text of the button
info.value = [ANYTHING]  --  The value that UIDROPDOWNMENU_MENU_VALUE is set to when the button is clicked
info.func = [function()]  --  The function that is called when you click the button
info.checked = [nil, true, function]  --  Check the button if true or function returns true
info.isTitle = [nil, true]  --  If it's a title the button is disabled and the font color is set to yellow
info.disabled = [nil, true]  --  Disable the button and show an invisible button that still traps the mouseover event so menu doesn't time out
info.hasArrow = [nil, true]  --  Show the expand arrow for multilevel menus
info.hasColorSwatch = [nil, true]  --  Show color swatch or not, for color selection
info.r = [1 - 255]  --  Red color value of the color swatch
info.g = [1 - 255]  --  Green color value of the color swatch
info.b = [1 - 255]  --  Blue color value of the color swatch
info.colorCode = [STRING] -- "|cAARRGGBB" embedded hex value of the button text color. Only used when button is enabled
info.swatchFunc = [function()]  --  Function called by the color picker on color change
info.hasOpacity = [nil, 1]  --  Show the opacity slider on the colorpicker frame
info.opacity = [0.0 - 1.0]  --  Percentatge of the opacity, 1.0 is fully shown, 0 is transparent
info.opacityFunc = [function()]  --  Function called by the opacity slider when you change its value
info.cancelFunc = [function(previousValues)] -- Function called by the colorpicker when you click the cancel button (it takes the previous values as its argument)
info.notClickable = [nil, 1]  --  Disable the button and color the font white
info.notCheckable = [nil, 1]  --  Shrink the size of the buttons and don't display a check box
info.owner = [Frame]  --  Dropdown frame that "owns" the current dropdownlist
info.keepShownOnClick = [nil, 1]  --  Don't hide the dropdownlist after a button is clicked
info.tooltipTitle = [nil, STRING] -- Title of the tooltip shown on mouseover
info.tooltipText = [nil, STRING] -- Text of the tooltip shown on mouseover
info.justifyH = [nil, "CENTER"] -- Justify button text
info.arg1 = [ANYTHING] -- This is the first argument used by info.func
info.arg2 = [ANYTHING] -- This is the second argument used by info.func
info.fontObject = [FONT] -- font object replacement for Normal and Highlight
info.menuTable = [TABLE] -- This contains an array of info tables to be displayed as a child menu
]]

function Addon.UIElementsLib._DropDownMenuButton:AddNormalItem(pText, pID, pIcon, pChecked, pDisabled)
	local vInfo = UIDropDownMenu_CreateInfo()
	
	vInfo.text = pText
	vInfo.value = pID
	vInfo.func = function (item, ...) self:ItemClicked(...) end
	vInfo.arg1 = pID
	vInfo.colorCode = NORMAL_FONT_COLOR_CODE
	vInfo.icon = pIcon
	vInfo.checked = pChecked
	vInfo.disabled = pDisabled
	
	UIDropDownMenu_AddButton(vInfo, UIDROPDOWNMENU_MENU_LEVEL)
end

function Addon.UIElementsLib._DropDownMenuButton:AddCategoryItem(pText)
	local vInfo = UIDropDownMenu_CreateInfo()
	
	vInfo.text = pText
	vInfo.notClickable = true
	vInfo.notCheckable = true
	vInfo.colorCode = HIGHLIGHT_FONT_COLOR_CODE
	
	UIDropDownMenu_AddButton(vInfo, UIDROPDOWNMENU_MENU_LEVEL)
end

function Addon.UIElementsLib._DropDownMenuButton:AddChildMenu(pText, pID)
	local vInfo = UIDropDownMenu_CreateInfo()
	
	vInfo.text = pText
	vInfo.value = pID
	vInfo.hasArrow = true
	vInfo.colorCode = NORMAL_FONT_COLOR_CODE
	
	UIDropDownMenu_AddButton(vInfo, UIDROPDOWNMENU_MENU_LEVEL)
end

function Addon.UIElementsLib._DropDownMenuButton:AddDivider()
	local vInfo = UIDropDownMenu_CreateInfo()
	
	vInfo.text = " "
	vInfo.notCheckable = true
	vInfo.notClickable = true
	
	UIDropDownMenu_AddButton(vInfo, UIDROPDOWNMENU_MENU_LEVEL)
end

function Addon.UIElementsLib._DropDownMenuButton:ItemClicked(pValue)
	self:SetSelectedValue(pValue)
	
	if self.ItemClickedFunc then
		self:ItemClickedFunc(pValue)
	end
end

function Addon.UIElementsLib._DropDownMenuButton:SetSelectedValue(pValue)
	-- Not applicable for a menu button
end

function Addon.UIElementsLib._DropDownMenuButton:GetSelectedValue()
	return self.selectedValue
end

function Addon.UIElementsLib._DropDownMenuButton:SetCurrentValueText(pText)
	-- Not applicable for a menu button
end

function Addon.UIElementsLib._DropDownMenuButton:SetEnabled(pEnabled)
	if pEnabled then
		self.Button:Enable()
		self:SetAlpha(1)
	else
		self.Button:Disable()
		self:SetAlpha(0.5)
	end
end

function Addon.UIElementsLib._DropDownMenuButton:WoWMenuInitFunction(pLevel, pMenuList)
	if not pLevel or pLevel == 1 then
		self:MenuFunc()
	else
		self:MenuFunc(UIDROPDOWNMENU_MENU_VALUE)
	end
	
	self:SetHeight(self.OrigHeight)
end

----------------------------------------
Addon.UIElementsLib._Section = {}
----------------------------------------

function Addon.UIElementsLib._Section:New(pParent, pTitle)
	return CreateFrame("Frame", nil, pParent)
end

function Addon.UIElementsLib._Section:Construct(pParent, pTitle)
	self:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 3, right = 3, top = 3, bottom = 3}})
	
	self:SetBackdropColor(1, 1, 1, 0.2)
	
	self.Title = self:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	self.Title:SetPoint("TOPLEFT", self, "TOPLEFT", 10, -7)
	self.Title:SetText(pTitle)
end

----------------------------------------
Addon.UIElementsLib._DropDownMenu = {}
----------------------------------------

for vName, vFunction in pairs(Addon.UIElementsLib._DropDownMenuButton) do
	Addon.UIElementsLib._DropDownMenu[vName] = vFunction
end

function Addon.UIElementsLib._DropDownMenu:Construct(pParent, pMenuFunc, pWidth)
	Addon.UIElementsLib._DropDownMenuButton.Construct(self, pParent, pMenuFunc, pWidth or 150)
	
	self.LeftTexture = self:CreateTexture(nil, "ARTWORK")
	self.LeftTexture:SetWidth(25)
	self.LeftTexture:SetHeight(64)
	self.LeftTexture:SetPoint("TOPRIGHT", self, "TOPLEFT", 1, 19)
	self.LeftTexture:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	self.LeftTexture:SetTexCoord(0, 0.1953125, 0, 1)
	
	self.RightTexture = self:CreateTexture(nil, "ARTWORK")
	self.RightTexture:SetWidth(25)
	self.RightTexture:SetHeight(64)
	self.RightTexture:SetPoint("TOP", self.LeftTexture, "TOP")
	self.RightTexture:SetPoint("LEFT", self, "RIGHT", -9, 0)
	self.RightTexture:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	self.RightTexture:SetTexCoord(0.8046875, 1, 0, 1)
	
	self.MiddleTexture = self:CreateTexture(nil, "ARTWORK")
	self.MiddleTexture:SetPoint("TOPLEFT", self.LeftTexture, "TOPRIGHT")
	self.MiddleTexture:SetPoint("BOTTOMRIGHT", self.RightTexture, "BOTTOMLEFT")
	self.MiddleTexture:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	self.MiddleTexture:SetTexCoord(0.1953125, 0.8046875, 0, 1)
	
	self.Text = self:CreateFontString(self:GetName().."Text", "ARTWORK", "GameFontHighlightSmall")
	self.Text:SetJustifyH("RIGHT")
	self.Text:SetHeight(18)
	self.Text:SetPoint("RIGHT", self.MiddleTexture, "RIGHT", -18, 1)
	self.Text:SetPoint("LEFT", self.MiddleTexture, "LEFT", 0, 1)
	
	self.Title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	self.Title:SetPoint("RIGHT", self.MiddleTexture, "LEFT", -11, 1)
end

function Addon.UIElementsLib._DropDownMenu:SetTitle(pTitle)
	self.Title:SetText(pTitle)
end

function Addon.UIElementsLib._DropDownMenu:SetCurrentValueText(pText)
	self.Text:SetText(pText)
end

function Addon.UIElementsLib._DropDownMenu:SetSelectedValue(pValue)
	if self.selectedValue == pValue then
		return
	end
	
	--
	
	self:SetCurrentValueText("") -- Set to empty in case the selected value isn't there
	
	UIDROPDOWNMENU_OPEN_MENU = nil
	UIDropDownMenu_Initialize(self, self.initialize, nil, 1)
	UIDropDownMenu_SetSelectedValue(self, pValue)
	
	-- All done if the item text got set successfully
	
	local vItemText = self.Text:GetText()
	
	if vItemText and vItemText ~= "" then
		return
	end
	
	-- Scan for submenus
	
	local vRootListFrameName = "DropDownList1"
	local vRootListFrame = _G[vRootListFrameName]
	local vRootNumItems = vRootListFrame.numButtons
	
	for vRootItemIndex = 1, vRootNumItems do
		local vItem = _G[vRootListFrameName.."Button"..vRootItemIndex]
		
		if vItem.hasArrow then
			local vSubMenuFrame = DropDownList2
			
			UIDROPDOWNMENU_OPEN_MENU = self
			UIDROPDOWNMENU_MENU_VALUE = vItem.value
			UIDROPDOWNMENU_MENU_LEVEL = 2
			
			UIDropDownMenu_Initialize(self, self.initialize, nil, 2)
			UIDropDownMenu_SetSelectedValue(self, pValue)
			
			-- All done if the item text got set successfully
			
			local vItemText = self.Text:GetText()
			
			if vItemText and vItemText ~= "" then
				return
			end
			
			-- Switch back to the root menu
			
			UIDROPDOWNMENU_OPEN_MENU = nil
			UIDropDownMenu_Initialize(self, self.initialize, nil, 1)
		end
	end
end

----------------------------------------
Addon.UIElementsLib._ContextMenu = {}
----------------------------------------

function Addon.UIElementsLib._ContextMenu:New(pParent)
	return CreateFrame("Frame", nil, pParent)
end

function Addon.UIElementsLib._ContextMenu:Construct(pParent)
	UIDropDownMenu_Initialize(self, self.InitMenu)
end

function Addon.UIElementsLib._ContextMenu:ToggleMenu(pFrame)
	PlaySound("igMainMenuOptionCheckBoxOn")
	
	self.displayMode = "MENU"
	
	ToggleDropDownMenu(nil, nil, self, "cursor", 5, -5)
end

function Addon.UIElementsLib._ContextMenu:InitMenu(pLevel, pMenuList)
	self:AddNormalItem("Test 1", "TEST1")
	self:AddNormalItem("Test 2", "TEST2")
	self:AddNormalItem("Test 3", "TEST3")
end

function Addon.UIElementsLib._ContextMenu:AddNormalItem(pText, pID, pIcon, pChecked, pDisabled)
	local vInfo = UIDropDownMenu_CreateInfo()
	
	vInfo.text = pText
	vInfo.value = pID
	vInfo.func = function (item, ...) self:ItemClicked(...) end
	vInfo.arg1 = pID
	vInfo.colorCode = NORMAL_FONT_COLOR_CODE
	vInfo.icon = pIcon
	vInfo.checked = pChecked
	vInfo.disabled = pDisabled
	
	UIDropDownMenu_AddButton(vInfo, UIDROPDOWNMENU_MENU_LEVEL)
end

function Addon.UIElementsLib._ContextMenu:AddCategoryItem(pText)
	local vInfo = UIDropDownMenu_CreateInfo()
	
	vInfo.text = pText
	vInfo.notClickable = true
	vInfo.notCheckable = true
	vInfo.colorCode = HIGHLIGHT_FONT_COLOR_CODE
	
	UIDropDownMenu_AddButton(vInfo, UIDROPDOWNMENU_MENU_LEVEL)
end

function Addon.UIElementsLib._ContextMenu:AddChildMenu(pText, pID)
	local vInfo = UIDropDownMenu_CreateInfo()
	
	vInfo.text = pText
	vInfo.value = pID
	vInfo.hasArrow = true
	vInfo.colorCode = NORMAL_FONT_COLOR_CODE
	
	UIDropDownMenu_AddButton(vInfo, UIDROPDOWNMENU_MENU_LEVEL)
end

function Addon.UIElementsLib._ContextMenu:AddDivider()
	local vInfo = UIDropDownMenu_CreateInfo()
	
	vInfo.text = " "
	vInfo.notCheckable = true
	vInfo.notClickable = true
	
	UIDropDownMenu_AddButton(vInfo, UIDROPDOWNMENU_MENU_LEVEL)
end

----------------------------------------
Addon.UIElementsLib._EditBox = {}
----------------------------------------

function Addon.UIElementsLib._EditBox:New(pParent, pLabel, pMaxLetters, pWidth, pPlain)
	return CreateFrame("EditBox", nil, pParent)
end

function Addon.UIElementsLib._EditBox:Construct(pParent, pLabel, pMaxLetters, pWidth, pPlain)
	self.Enabled = true
	
	self.cursorOffset = 0
	self.cursorHeight = 0
	
	self:SetWidth(pWidth or 150)
	self:SetHeight(25)
	
	self:SetFontObject(ChatFontNormal)
	
	self:SetMultiLine(false)
	self:EnableMouse(true)
	self:SetAutoFocus(false)
	self:SetMaxLetters(pMaxLetters or 200)
	
	if not pPlain then
		self.LeftTexture = self:CreateTexture(nil, "BACKGROUND")
		self.LeftTexture:SetTexture("Interface\\Common\\Common-Input-Border")
		self.LeftTexture:SetWidth(8)
		self.LeftTexture:SetHeight(20)
		self.LeftTexture:SetPoint("LEFT", self, "LEFT", -5, 0)
		self.LeftTexture:SetTexCoord(0, 0.0625, 0, 0.625)
		
		self.RightTexture = self:CreateTexture(nil, "BACKGROUND")
		self.RightTexture:SetTexture("Interface\\Common\\Common-Input-Border")
		self.RightTexture:SetWidth(8)
		self.RightTexture:SetHeight(20)
		self.RightTexture:SetPoint("RIGHT", self, "RIGHT", 0, 0)
		self.RightTexture:SetTexCoord(0.9375, 1, 0, 0.625)
		
		self.MiddleTexture = self:CreateTexture(nil, "BACKGROUND")
		self.MiddleTexture:SetHeight(20)
		self.MiddleTexture:SetTexture("Interface\\Common\\Common-Input-Border")
		self.MiddleTexture:SetPoint("LEFT", self.LeftTexture, "RIGHT")
		self.MiddleTexture:SetPoint("RIGHT", self.RightTexture, "LEFT")
		self.MiddleTexture:SetTexCoord(0.0625, 0.9375, 0, 0.625)
		
		self.Title = self:CreateFontString(nil, "BACKGROUND", "GameFontNormalSmall")
		self.Title:SetJustifyH("RIGHT")
		self.Title:SetPoint("RIGHT", self, "TOPLEFT", -10, -13)
		self.Title:SetText(pLabel or "")
	end
	
	self:SetScript("OnEscapePressed", function (self) self:ClearFocus() end)
	self:SetScript("OnEditFocusLost", self.EditFocusLost)
	self:SetScript("OnEditFocusGained", self.EditFocusGained)
	self:SetScript("OnTabPressed", self.OnTabPressed)
	self:SetScript("OnChar", self.OnChar)
	self:SetScript("OnCharComposition", self.OnCharComposition)
	self:SetScript("OnTextChanged", self.OnTextChanged)
	
	self:LinkIntoTabChain(pParent)
end

function Addon.UIElementsLib._EditBox:SetEnabled(pEnabled)
	self.Enabled = pEnabled
	
	if not pEnabled then
		self:ClearFocus()
	end
	
	self:EnableMouse(pEnabled)
	self:SetAlpha(pEnabled and 1.0 or 0.5)
end

function Addon.UIElementsLib._EditBox:SetAnchorMode(pMode)
	self.Title:ClearAllPoints()
	self:ClearAllPoints()
	
	if pMode == "TITLE" then
		self:SetPoint("TOPLEFT", self.Title, "RIGHT", 10, 12)
	else
		self.Title:SetPoint("RIGHT", self, "TOPLEFT", -10, -13)
	end
end

function Addon.UIElementsLib._EditBox:EditFocusLost()
	self.HaveKeyboardFocus = nil
	self.TextHasChanged = nil
	self:HighlightText(0, 0)
end

function Addon.UIElementsLib._EditBox:EditFocusGained()
	self.HaveKeyboardFocus = true
	self.TextHasChanged = nil
	self:HighlightText()
end

function Addon.UIElementsLib._EditBox:SetAutoCompleteFunc(pFunction)
	self.AutoCompleteFunc = pFunction
end

function Addon.UIElementsLib._EditBox:OnChar()
	if not self:IsInIMECompositionMode() then
		self:OnCharComposition()
	end
	self.TextHasChanged = self:GetText() ~= self.OrigText
end

function Addon.UIElementsLib._EditBox:OnCharComposition()
	if self.AutoCompleteFunc then
		self:AutoCompleteFunc()
	end
	self.TextHasChanged = self:GetText() ~= self.OrigText
end

function Addon.UIElementsLib._EditBox:SetText(pText, ...)
	self.TextHasChanged = nil
	self.OrigText = tostring(pText)
	
	self.Inherited.SetText(self, pText, ...)
end

function Addon.UIElementsLib._EditBox:OnTextChanged()
	local vText = self:GetText()
	
	self.TextHasChanged = vText ~= self.OrigText
	
	if self.EmptyText then
		if string.trim(vText) == "" then
			self.EmptyText:Show()
		else
			self.EmptyText:Hide()
		end
	end
end

function Addon.UIElementsLib._EditBox:LinkIntoTabChain(pParent)
	local vTabParent = pParent
	
	while vTabParent.TabParent do
		vTabParent = vTabParent.TabParent
	end
	
	self.NextEditBox = vTabParent.FirstEditBox
	self.PrevEditBox = vTabParent.LastEditBox
	
	if vTabParent.LastEditBox then
		vTabParent.LastEditBox.NextEditBox = self
	end
	
	vTabParent.LastEditBox = self
	
	if vTabParent.FirstEditBox then
		vTabParent.FirstEditBox.PrevEditBox = self
	else
		vTabParent.FirstEditBox = self
	end
end

function Addon.UIElementsLib._EditBox:OnTabPressed()
	local vReverse = IsShiftKeyDown()
	local vEditBox = self
	
	for vIndex = 1, 50 do
		local vNextEditBox
			
		if vReverse then
			vNextEditBox = vEditBox.PrevEditBox
		else
			vNextEditBox = vEditBox.NextEditBox
		end
		
		if not vNextEditBox then
			self:SetFocus()
			return
		end
		
		if vNextEditBox:IsVisible()
		and not vNextEditBox.isDisabled then
			vNextEditBox:SetFocus()
			return
		end
		
		vEditBox = vNextEditBox
	end
end

function Addon.UIElementsLib._EditBox:SetVertexColor(pRed, pGreen, pBlue, pAlpha)
	self.LeftTexture:SetVertexColor(pRed, pGreen, pBlue, pAlpha)
	self.MiddleTexture:SetVertexColor(pRed, pGreen, pBlue, pAlpha)
	self.RightTexture:SetVertexColor(pRed, pGreen, pBlue, pAlpha)
end

function Addon.UIElementsLib._EditBox:SetEmptyText(pText)
	if not self.EmptyText then
		self.EmptyText = self:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		self.EmptyText:SetPoint("LEFT", self, "LEFT")
		self.EmptyText:SetPoint("RIGHT", self, "RIGHT")
		self.EmptyText:SetJustifyH("LEFT")
		self.EmptyText:SetTextColor(1, 1, 1, 0.5)
	end
	
	self.EmptyText:SetText(pText)
end

----------------------------------------
Addon.UIElementsLib._DatePicker = {}
----------------------------------------

function Addon.UIElementsLib._DatePicker:New(pParent, pTitle)
	return CreateFrame("Frame", nil, pParent)
end

function Addon.UIElementsLib._DatePicker:Construct(pParent, pLabel)
	self.Enabled = true
	
	self.MonthMenu = Addon:New(Addon.UIElementsLib._DropDownMenu, self, function (...) self:MonthMenuFunc(...) end)
	self.MonthMenu:SetWidth(120)
	self.MonthMenu.ItemClickedFunc = function (pMenu, pValue)
		self:ValidateDay()
		self:DateValueChanged()
	end
	
	self.YearMenu = Addon:New(Addon.UIElementsLib._DropDownMenu, self, function (...) self:YearMenuFunc(...) end)
	self.YearMenu:SetWidth(75)
	self.YearMenu.ItemClickedFunc = function (pMenu, pValue)
		self:ValidateDay()
		self:DateValueChanged()
	end
	
	-- Create day last since it depends on month and year to populate itself
	
	self.DayMenu = Addon:New(Addon.UIElementsLib._DropDownMenu, self, function (...) self:DayMenuFunc(...) end)
	self.DayMenu:SetWidth(55)
	self.DayMenu.ItemClickedFunc = function (pMenu, pValue)
		self:DateValueChanged()
	end
	
	-- Layout the menus based on locale
	
	if string.sub(GetLocale(), -2) == "US" then
		self.MonthMenu:SetPoint("LEFT", self, "LEFT")
		self.DayMenu:SetPoint("LEFT", self.MonthMenu, "RIGHT", 8, 0)
		self.YearMenu:SetPoint("LEFT", self.DayMenu, "RIGHT", 8, 0)
		
		self.LeftMenu = self.MonthMenu
	else
		self.DayMenu:SetPoint("LEFT", self, "LEFT")
		self.MonthMenu:SetPoint("LEFT", self.DayMenu, "RIGHT", 8, 0)
		self.YearMenu:SetPoint("LEFT", self.MonthMenu, "RIGHT", 8, 0)
		
		self.LeftMenu = self.DayMenu
	end
	
	self:SetWidth(self.MonthMenu:GetWidth() + self.DayMenu:GetWidth() + self.YearMenu:GetWidth() + 16)
	self:SetHeight(self.MonthMenu:GetHeight())
	
	--
	
	self:SetLabel(pLabel or "")
end

function Addon.UIElementsLib._DatePicker:SetEnabled(pEnabled)
	self.Enabled = pEnabled
	
	self.MonthMenu:SetEnabled(pEnabled)
	self.DayMenu:SetEnabled(pEnabled)
	self.YearMenu:SetEnabled(pEnabled)
end

function Addon.UIElementsLib._DatePicker:SetDate(pMonth, pDay, pYear)
	if not pMonth then
		self.YearMenu:SetSelectedValue(nil)
		self.MonthMenu:SetSelectedValue(nil)
		self.DayMenu:SetSelectedValue(nil)
		
		return
	end
	
	-- Set DayMenu last so that month and year will be available for calculating
	-- the number of days in the month
	
	self.YearMenu:SetSelectedValue(pYear)
	self.MonthMenu:SetSelectedValue(pMonth)
	self.DayMenu:SetSelectedValue(pDay)
end

function Addon.UIElementsLib._DatePicker:DateValueChanged()
	if self.ValueChangedFunc then
		self:ValueChangedFunc()
	end
end

function Addon.UIElementsLib._DatePicker:ValidateDay()
	local vNumDays = Addon.DateLib:GetDaysInMonth(self.MonthMenu:GetSelectedValue(), self.YearMenu:GetSelectedValue())
	
	if self.DayMenu:GetSelectedValue() > vNumDays then
		self.DayMenu:SetSelectedValue(vNumDays)
	end
end

function Addon.UIElementsLib._DatePicker:GetDate()
	return self.MonthMenu:GetSelectedValue(), self.DayMenu:GetSelectedValue(), self.YearMenu:GetSelectedValue()
end

function Addon.UIElementsLib._DatePicker:MonthMenuFunc(pMenu)
	for vMonth = 1, 12 do
		pMenu:AddNormalItem(Addon.CALENDAR_MONTH_NAMES[vMonth], vMonth)
	end
end

function Addon.UIElementsLib._DatePicker:DayMenuFunc(pMenu)
	local vNumDays = Addon.DateLib:GetDaysInMonth(self.MonthMenu:GetSelectedValue(), self.YearMenu:GetSelectedValue())
	
	if not vNumDays then
		return
	end
	
	for vDay = 1, vNumDays do
		pMenu:AddNormalItem(vDay, vDay)
	end
end

function Addon.UIElementsLib._DatePicker:YearMenuFunc(pMenu)
	local _, _, _, vYear = CalendarGetDate()
	
	pMenu:AddNormalItem(vYear, vYear)
	pMenu:AddNormalItem(vYear + 1, vYear + 1)
end

function Addon.UIElementsLib._DatePicker:SetLabel(pLabel)
	self.LeftMenu:SetTitle(pLabel)
end

----------------------------------------
Addon.UIElementsLib._TimePicker = {}
----------------------------------------

function Addon.UIElementsLib._TimePicker:New(pParent, pTitle)
	return CreateFrame("Frame", nil, pParent)
end

function Addon.UIElementsLib._TimePicker:Construct(pParent, pLabel)
	self.Enabled = true
	
	self:SetWidth(185)
	self:SetHeight(24)
	
	self.HourMenu = Addon:New(Addon.UIElementsLib._DropDownMenu, self, function (...) self:HourMenuFunc(...) end)
	self.HourMenu:SetWidth(55)
	self.HourMenu:SetPoint("LEFT", self, "LEFT")
	self.HourMenu.ItemClickedFunc = function (pMenu, pValue)
		self:TimeValueChanged()
	end
	
	self.MinuteMenu = Addon:New(Addon.UIElementsLib._DropDownMenu, self, function (...) self:MinuteMenuFunc(...) end)
	self.MinuteMenu:SetWidth(55)
	self.MinuteMenu:SetPoint("LEFT", self.HourMenu, "RIGHT", 8, 0)
	self.MinuteMenu.ItemClickedFunc = function (pMenu, pValue)
		self:TimeValueChanged()
	end
	
	self.AMPMMenu = Addon:New(Addon.UIElementsLib._DropDownMenu, self, function (...) self:AMPMMenuFunc(...) end)
	self.AMPMMenu:SetWidth(55)
	self.AMPMMenu:SetPoint("LEFT", self.MinuteMenu, "RIGHT", 8, 0)
	self.AMPMMenu.ItemClickedFunc = function (pMenu, pValue)
		self:TimeValueChanged()
	end
	
	self:SetLabel(pLabel or "")
end

function Addon.UIElementsLib._TimePicker:SetEnabled(pEnabled)
	self.Enabled = pEnabled
	
	self.HourMenu:SetEnabled(pEnabled)
	self.MinuteMenu:SetEnabled(pEnabled)
	self.AMPMMenu:SetEnabled(pEnabled)
end

function Addon.UIElementsLib._TimePicker:SetTime(pHour, pMinute)
	local vHour
	
	if not pHour then
		self.HourMenu:SetSelectedValue(nil)
		self.MinuteMenu:SetSelectedValue(nil)
		self.AMPMMenu:SetSelectedValue(nil)
		
		return
	end
	
	if GetCVarBool("timeMgrUseMilitaryTime") then
		vHour = pHour
		self.AMPMMenu:Hide()
		
		self.Use24HTime = true
	else
		local vAMPM = "AM"
		
		if pHour == 0 then
			vHour = 12
		elseif pHour == 12 then
			vHour = pHour
			vAMPM = "PM"
		elseif pHour > 12 then
			vHour = pHour - 12
			vAMPM = "PM"
		else
			vHour = pHour
		end
		
		if vAMPM == "PM" and vHour > 12 then
			vHour = vHour - 12
		end
		
		if vHour == 0 then
			vHour = 12
		end
		
		self.AMPMMenu:SetSelectedValue(vAMPM)
		self.AMPMMenu:Show()
		
		self.Use24HTime = false
	end
	
	self.HourMenu:SetSelectedValue(vHour)
	self.MinuteMenu:SetSelectedValue(pMinute)
end

function Addon.UIElementsLib._TimePicker:TimeValueChanged()
	if self.ValueChangedFunc then
		self:ValueChangedFunc()
	end
end

function Addon.UIElementsLib._TimePicker:GetTime()
	local vHour, vMinute
	
	vHour = self.HourMenu:GetSelectedValue()
	vMinute = self.MinuteMenu:GetSelectedValue()
	
	
	if not vHour or not vMinute then
		return
	end
	
	if not self.Use24HTime then
		if self.AMPMMenu:GetSelectedValue() == "AM" then
			if vHour == 12 then
				vHour = 0
			end
		else
			if vHour ~= 12 then
				vHour = vHour + 12
			end
		end
	end
	
	return vHour, vMinute
end

function Addon.UIElementsLib._TimePicker:HourMenuFunc(pMenu)
	if self.Use24HTime then
		for vHour = 0, 23 do
			pMenu:AddNormalItem(vHour, vHour)
		end
	else
		for vHour = 1, 12 do
			pMenu:AddNormalItem(vHour, vHour)
		end
	end
end

function Addon.UIElementsLib._TimePicker:MinuteMenuFunc(pMenu)
	for vMinute = 0, 59, 5 do
		pMenu:AddNormalItem(string.format("%02d", vMinute), vMinute)
	end
end

function Addon.UIElementsLib._TimePicker:AMPMMenuFunc(pMenu)
	pMenu:AddNormalItem("AM", "AM")
	pMenu:AddNormalItem("PM", "PM")
end

function Addon.UIElementsLib._TimePicker:SetLabel(pLabel)
	self.HourMenu:SetTitle(pLabel)
end

----------------------------------------
Addon.UIElementsLib._LevelRangePicker = {}
----------------------------------------

function Addon.UIElementsLib._LevelRangePicker:New(pParent, pLabel)
	return CreateFrame("Frame", nil, pParent)
end

function Addon.UIElementsLib._LevelRangePicker:Construct(pParent, pLabel)
	self.Enabled = true
	
	self.TabParent = pParent
	
	self:SetWidth(80)
	self:SetHeight(24)
	
	self.MinLevel = Addon:New(Addon.UIElementsLib._EditBox, self, pLabel, 2)
	self.MinLevel:SetWidth(30)
	self.MinLevel:SetPoint("LEFT", self, "LEFT")
	
	self.MaxLevel = Addon:New(Addon.UIElementsLib._EditBox, self, Addon.cLevelRangeSeparator, 2)
	self.MaxLevel:SetWidth(30)
	self.MaxLevel:SetAnchorMode("TITLE")
	self.MaxLevel.Title:SetPoint("LEFT", self.MinLevel, "RIGHT", 5, 0)
end

function Addon.UIElementsLib._LevelRangePicker:SetEnabled(pEnabled)
	self.Enabled = pEnabled
	
	self.MinLevel:SetEnabled(pEnabled)
	self.MaxLevel:SetEnabled(pEnabled)
end

function Addon.UIElementsLib._LevelRangePicker:SetLabel(pLabel)
	self.MinLevel:SetTitle(pLabel)
end

function Addon.UIElementsLib._LevelRangePicker:SetLevelRange(pMinLevel, pMaxLevel)
	self.MinLevel:SetText(pMinLevel or "")
	self.MaxLevel:SetText(pMaxLevel or "")
end

function Addon.UIElementsLib._LevelRangePicker:GetLevelRange()
	return tonumber(self.MinLevel:GetText()), tonumber(self.MaxLevel:GetText())
end

function Addon.UIElementsLib._LevelRangePicker:ClearFocus()
	self.MinLevel:ClearFocus()
	self.MaxLevel:ClearFocus()
end

----------------------------------------
Addon.UIElementsLib._PushButton = {}
----------------------------------------

function Addon.UIElementsLib._PushButton:New(pParent, pTitle, pWidth)
	return CreateFrame("Button", nil, pParent)
end

function Addon.UIElementsLib._PushButton:Construct(pParent, pTitle, pWidth)
	self:SetWidth(pWidth or 100)
	self:SetHeight(22)
	
	self.Text = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	self.Text:SetPoint("LEFT", self, "LEFT")
	self.Text:SetPoint("RIGHT", self, "RIGHT")
	self.Text:SetHeight(20)
	self.Text:SetText(pTitle)
	
	self.LeftTexture = self:CreateTexture(nil, "BACKGROUND")
	self.LeftTexture:SetWidth(12)
	self.LeftTexture:SetPoint("TOPLEFT", self, "TOPLEFT")
	self.LeftTexture:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT")
	self.LeftTexture:SetTexCoord(0, 0.09375, 0, 0.6875)
	
	self.RightTexture = self:CreateTexture(nil, "BACKGROUND")
	self.RightTexture:SetWidth(12)
	self.RightTexture:SetPoint("TOPRIGHT", self, "TOPRIGHT")
	self.RightTexture:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
	self.RightTexture:SetTexCoord(0.53125, 0.625, 0, 0.6875)
	
	self.MiddleTexture = self:CreateTexture(nil, "BACKGROUND")
	self.MiddleTexture:SetPoint("TOPLEFT", self.LeftTexture, "TOPRIGHT")
	self.MiddleTexture:SetPoint("BOTTOMLEFT", self.LeftTexture, "BOTTOMRIGHT")
	self.MiddleTexture:SetPoint("TOPRIGHT", self.RightTexture, "TOPLEFT")
	self.MiddleTexture:SetPoint("BOTTOMRIGHT", self.RightTexture, "BOTTOMLEFT")
	self.MiddleTexture:SetTexCoord(0.09375, 0.53125, 0, 0.6875)
	
	self.HighlightTexture = self:CreateTexture(nil, "HIGHLIGHT")
	self.HighlightTexture:SetAllPoints()
	self.HighlightTexture:SetTexCoord(0, 0.625, 0, 0.6875)
	self.HighlightTexture:SetBlendMode("ADD")
	
	self.Down = false
	self:UpdateButtonTexture()
	
	self:SetScript("OnMouseDown", function ()
		self.Down = true
		self:UpdateButtonTexture()
	end)
	
	self:SetScript("OnMouseUp", function ()
		self.Down = false
		self:UpdateButtonTexture()
	end)
end

function Addon.UIElementsLib._PushButton:SetEnabled(pEnabled)
	if pEnabled == self:IsEnabled() then
		return
	end
	
	if pEnabled then
		self:Enable()
	else
		self:Disable()
	end
end

function Addon.UIElementsLib._PushButton:SetTitle(pTitle)
	self.Text:SetText(pTitle)
end

function Addon.UIElementsLib._PushButton:Enable()
	self.Inherited.Enable(self)
	self:UpdateButtonTexture()
end

function Addon.UIElementsLib._PushButton:Disable()
	self.Inherited.Disable(self)
	self:UpdateButtonTexture()
end

function Addon.UIElementsLib._PushButton:IsEnabled()
	return self.Inherited.IsEnabled(self) == 1
end

function Addon.UIElementsLib._PushButton:UpdateButtonTexture()
	if self:IsEnabled() then
		self:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		self.HighlightTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
		
		if self.Down then
			self.LeftTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
			self.MiddleTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
			self.RightTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
		else
			self.LeftTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
			self.MiddleTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
			self.RightTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
		end
	else
		self:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
		self.HighlightTexture:SetTexture()
		
		if self.Down then
			self.LeftTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Disabled-Down")
			self.MiddleTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Disabled-Down")
			self.RightTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Disabled-Down")
		else
			self.LeftTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Disabled")
			self.MiddleTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Disabled")
			self.RightTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Disabled")
		end
	end
end

function Addon.UIElementsLib._PushButton:SetTextColor(pRed, pGreen, pBlue, pAlpha)
	self.Text:SetTextColor(pRed, pGreen, pBlue, pAlpha)
end

----------------------------------------
Addon.UIElementsLib._ScrollingEditBox = {}
----------------------------------------

function Addon.UIElementsLib._ScrollingEditBox:New(pParent, pLabel, pMaxLetters, pWidth, pHeight)
	return CreateFrame("Frame", nil, pParent)
end

Addon.UIElementsLib._ScrollingEditBox.InputFieldTextureInfo =
{
	TopLeft      = {Width =   5, Height =   5, Path = "Interface\\Common\\Common-Input-Border", Coords = {Left = 0, Right = 0.0390625, Top = 0, Bottom = 0.15625}},
	TopCenter    = {Width = 118, Height =   5, Path = "Interface\\Common\\Common-Input-Border", Coords = {Left = 0.0390625, Right = 0.9609375, Top = 0, Bottom = 0.15625}},
	TopRight     = {Width =   5, Height =   5, Path = "Interface\\Common\\Common-Input-Border", Coords = {Left = 0.9609375, Right = 1, Top = 0, Bottom = 0.15625}},
	MiddleLeft   = {Width =   5, Height =  10, Path = "Interface\\Common\\Common-Input-Border", Coords = {Left = 0, Right = 0.0390625, Top = 0.15625, Bottom = 0.46875}},
	MiddleCenter = {Width = 118, Height =  10, Path = "Interface\\Common\\Common-Input-Border", Coords = {Left = 0.0390625, Right = 0.9609375, Top = 0.15625, Bottom = 0.46875}},
	MiddleRight  = {Width =   5, Height =  10, Path = "Interface\\Common\\Common-Input-Border", Coords = {Left = 0.9609375, Right = 1, Top = 0.15625, Bottom = 0.46875}},
	BottomLeft   = {Width =   5, Height =   5, Path = "Interface\\Common\\Common-Input-Border", Coords = {Left = 0, Right = 0.0390625, Top = 0.46875, Bottom = 0.625}},
	BottomCenter = {Width = 118, Height =   5, Path = "Interface\\Common\\Common-Input-Border", Coords = {Left = 0.0390625, Right = 0.9609375, Top = 0.46875, Bottom = 0.625}},
	BottomRight  = {Width =   5, Height =   5, Path = "Interface\\Common\\Common-Input-Border", Coords = {Left = 0.9609375, Right = 1, Top = 0.46875, Bottom = 0.625}},
}

function Addon.UIElementsLib._ScrollingEditBox:Construct(pParent, pLabel, pMaxLetters, pWidth, pHeight)
	self.Enabled = true
	
	self:SetWidth(pWidth or 150)
	self:SetHeight(pHeight or 60)
	
	self.Title = self:CreateFontString(nil, "BACKGROUND", "GameFontNormalSmall")
	self.Title:SetJustifyH("RIGHT")
	self.Title:SetPoint("RIGHT", self, "TOPLEFT", -10, -9)
	self.Title:SetText(pLabel or "")
	
	self.BackgroundTextures = CreateFrame("Frame", nil, self)
	self.BackgroundTextures:SetPoint("TOPLEFT", self, "TOPLEFT", -4, 4)
	self.BackgroundTextures:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, -4)
	Addon.Inherit(self.BackgroundTextures, Addon.UIElementsLib._StretchTextures, self.InputFieldTextureInfo, self.BackgroundTextures, "BORDER")
	
	self.ScrollbarTrench = Addon:New(Addon.UIElementsLib._ScrollbarTrench, self)
	self.ScrollbarTrench:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 1)
	self.ScrollbarTrench:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, -2)
	
	self.Scrollbar = Addon:New(Addon.UIElementsLib._Scrollbar, self)
	self.Scrollbar:SetPoint("TOP", self.ScrollbarTrench, "TOP", 0, -19)
	self.Scrollbar:SetPoint("BOTTOM", self.ScrollbarTrench, "BOTTOM", 0, 17)
	self.Scrollbar:SetFrameLevel(self.ScrollbarTrench:GetFrameLevel() + 1)
	self.Scrollbar:SetScript("OnValueChanged", function (pScrollbar, pValue)
		self.ScrollFrame:SetVerticalScroll(pValue)
	end)
	
	--
	
	local vScrollFrameName = "MC2UIElementsLibScrollFrame"..MC2UIElementsLib.ScrollFrameIndex
	MC2UIElementsLib.ScrollFrameIndex = MC2UIElementsLib.ScrollFrameIndex + 1
	
	self.ScrollFrame = CreateFrame("ScrollFrame", vScrollFrameName, self)
	self.ScrollFrame:SetWidth(self:GetWidth() - self.ScrollbarTrench:GetWidth())
	self.ScrollFrame:SetHeight(self:GetHeight())
	self.ScrollFrame:SetPoint("TOPLEFT", self, "TOPLEFT")
	self.ScrollFrame:EnableMouseWheel(1)
	self.ScrollFrame:SetScript("OnVerticalScroll", function (pScrollFrame, pOffset)
		self.Scrollbar:SetValue(pOffset)
	end)
	self.ScrollFrame:SetScript("OnScrollRangeChanged", function (pScrollFrame, pHorizRange, pVertRange)
		if not pVertRange then
			pVertRange = self:GetVerticalScrollRange()
		end
		
		self.Scrollbar:SetMinMaxValues(0, pVertRange)

		local vValue = self.Scrollbar:GetValue()
		
		if vValue > pVertRange then
			vValue = pVertRange
			self.Scrollbar:SetValue(vValue)
		end
	end)
	self.ScrollFrame:SetScript("OnMouseWheel", function (pScrollFrame, pDelta)
		local vDistance = pScrollFrame:GetHeight() * 0.5
		local vValue = self.Scrollbar:GetValue()
		
		if pDelta > 0 then -- Scroll up
			self.Scrollbar:SetValue(vValue - vDistance)
		else
			self.Scrollbar:SetValue(vValue + vDistance)
		end
	end)
	
	--
	
	self.ScrollChildFrame = CreateFrame("Frame", nil, self.ScrollFrame)
	self.ScrollChildFrame:SetWidth(self.ScrollFrame:GetWidth())
	self.ScrollChildFrame:SetHeight(self.ScrollFrame:GetHeight())
	self.ScrollChildFrame:SetPoint("TOPLEFT", self.ScrollFrame, "TOPLEFT")
	self.ScrollChildFrame.TabParent = pParent
	
	self.EditBox = Addon:New(Addon.UIElementsLib._EditBox, self.ScrollChildFrame, nil, pMaxLetters or 200, self.ScrollChildFrame:GetWidth(), true)
	self.EditBox:SetHeight(self.ScrollChildFrame:GetHeight())
	self.EditBox:SetPoint("TOPLEFT", self.ScrollChildFrame, "TOPLEFT", 0, 0)
	self.EditBox:SetPoint("TOPRIGHT", self.ScrollChildFrame, "TOPRIGHT", 0, 0)
	self.EditBox:SetFontObject(ChatFontNormal)
	self.EditBox:SetMultiLine(true)
	self.EditBox:EnableMouse(true)
	self.EditBox:SetAutoFocus(false)
	Addon:HookScript(self.EditBox, "OnTextChanged", function (pEditBox)
		self:UpdateLimitText()
		ScrollingEdit_OnTextChanged(pEditBox, self.ScrollFrame)
	end)
	Addon:HookScript(self.EditBox, "OnCursorChanged", function (pEditBox, pCol, pRow, pWidth, pHeight)
		ScrollingEdit_OnCursorChanged(pEditBox, pCol, pRow - 10, pWidth, pHeight)
	end)
	Addon:HookScript(self.EditBox, "OnUpdate", function (pEditBox, pElapsed)
		ScrollingEdit_OnUpdate(pEditBox, pElapsed, self.ScrollFrame)
	end)

	self.ScrollFrame:SetScrollChild(self.ScrollChildFrame)
	
	self:EnableMouse(true)
	self:SetScript("OnMouseDown", function () if self.EditBox.Enabled then self.EditBox:SetFocus() end end)
end

function Addon.UIElementsLib._ScrollingEditBox:SetEnabled(pEnabled)
	self.Enabled = pEnabled
	self.EditBox:SetEnabled(pEnabled)
	
	self:SetAlpha(pEnabled and 1 or 0.5)
end

function Addon.UIElementsLib._ScrollingEditBox:GetText()
	return self.EditBox:GetText()
end

function Addon.UIElementsLib._ScrollingEditBox:SetText(pText)
	self.EditBox:SetText(pText)
end

function Addon.UIElementsLib._ScrollingEditBox:ShowLimitText()
	if self.LimitText then
		return
	end
	
	self.LimitText = self:CreateFontString(nil, "BACKGROUND", "GameFontNormalSmall")
	self.LimitText:SetJustifyH("RIGHT")
	self.LimitText:SetPoint("TOPRIGHT", self.Title, "BOTTOMRIGHT")
	
	self:UpdateLimitText()
end

function Addon.UIElementsLib._ScrollingEditBox:UpdateLimitText()
	if not self.LimitText then
		return
	end
	
	local vCurLength = self:GetText():len()
	local vMaxLength = self.EditBox:GetMaxLetters()
	
	self.LimitText:SetText(vCurLength.."/"..vMaxLength)

	-- Figure out the amount used in the description and color progress based on percentage
	
	local vPercentUsed = vCurLength / vMaxLength
	
	if vPercentUsed <= 0.75 then
		self.LimitText:SetVertexColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
	elseif vCurLength < vMaxLength then
		self.LimitText:SetVertexColor(0.9, 0.9, 0.05) -- Yellow
	else
		self.LimitText:SetVertexColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
	end
end

function Addon.UIElementsLib._ScrollingEditBox:ClearFocus()
	self.EditBox:ClearFocus()
end

----------------------------------------
Addon.UIElementsLib._ProgressBar = {}
----------------------------------------

function Addon.UIElementsLib._ProgressBar:New(pParent)
	return CreateFrame("StatusBar", nil, pParent)
end

function Addon.UIElementsLib._ProgressBar:Construct()
	self:SetHeight(20)
	
	self.LabelText = self:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	self.LabelText:SetPoint("TOPLEFT", self, "TOPLEFT")
	self.LabelText:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
	self.LabelText:SetJustifyH("LEFT")
	self.LabelText:SetJustifyV("MIDDLE")
	
	self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	self:SetStatusBarColor(1, 0.7, 0)
	
	self:SetMinMaxValues(0, 1)
	self:SetValue(0)
end

function Addon.UIElementsLib._ProgressBar:SetText(pText)
	self.LabelText:SetText(pText)
end

function Addon.UIElementsLib._ProgressBar:SetProgress(pProgress)
	if pProgress then
		self:SetValue(pProgress)
	else
		self:SetValue(0)
	end
end
