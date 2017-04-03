----------------------------------------
Outfitter._ButtonBar = {}
----------------------------------------

function Outfitter._ButtonBar:Construct(pName, pNumColumns, pNumRows, pButtonMethods, pButtonTemplate)
	self.Name = pName
	self.NumColumns = 0
	self.NumRows = 0
	self.Buttons = {}
	self.BackgroundTextures = {}
	self.ButtonMethods = pButtonMethods
	self.ButtonTemplate = pButtonTemplate or "ItemButtonTemplate"
	
	self:SetFrameStrata("DIALOG")
	Outfitter.SetFrameLevel(self, 1)
	self:EnableMouse(true)
	
	self:SetDimensions(pNumColumns, pNumRows)
	self:SetParent(UIParent)
end

function Outfitter._ButtonBar:SetDimensions(pNumColumns, pNumRows)
	self.NumColumns = pNumColumns
	self.NumRows = pNumRows
	
	-- Allocate additional buttons if needed
	
	local vTotalButtons = pNumColumns * pNumRows
	
	for vIndex = #self.Buttons, vTotalButtons do
		local vButtonName = self.Name.."Button"..vIndex
		local vButton = CreateFrame("CheckButton", vButtonName, self, self.ButtonTemplate)
		
		Outfitter.InitializeFrame(vButton, self.ButtonMethods)
		vButton:Construct()
		
		--Outfitter.SetFrameLevel(vButton, self:GetFrameLevel() + 1)
		
		table.insert(self.Buttons, vButton)
	end
	
	-- Allocate additional textures if needed
	
	local vNumTexRows = self.NumRows + 1
	local vNumTexColumns = self.NumColumns + 1
	local vTotalTextures = vNumTexRows * vNumTexColumns
	
	for vIndex = #self.BackgroundTextures, vTotalTextures do
		local vTexture = self:CreateTexture(nil, "BACKGROUND")
		
		vTexture:SetTexture("Interface\\Addons\\Outfitter\\Textures\\QuickSlotsBackground")
		vTexture:SetHeight(Outfitter.Style.ButtonBar.BackgroundHeight)
		vTexture:Hide()
		
		table.insert(self.BackgroundTextures, vTexture)
	end
	
	self.NumTextures = vTotalTextures
	
	-- Link the buttons together
	
	local vButtonFrameLevel = self:GetFrameLevel() + 1
	
	local vButtonIndex = 1
	local vPrevRowFirstButton
	local vRowFirstButton
	
	for vRow = 1, self.NumRows do
		local vPrevButton
		local vRowFirstButton = self.Buttons[vButtonIndex]
		
		for vColumn = 1, self.NumColumns do
			local vButton = self.Buttons[vButtonIndex]
			
			vButton:ClearAllPoints()
			
			if vPrevButton then
				vButton:SetPoint("LEFT", vPrevButton, "LEFT", Outfitter.Style.ButtonBar.BackgroundWidth, 0)
			elseif vPrevRowFirstButton then
				vButton:SetPoint("TOP", vPrevRowFirstButton, "TOP", 0, -Outfitter.Style.ButtonBar.BackgroundHeight)
			else
				vButton:SetPoint("TOPLEFT", self, "TOPLEFT", 7, -6)
			end
			
			vButton:EnableMouse(true)
			--vButton:SetFrameLevel(vButtonFrameLevel)
			vButton:Enable()
			
			vButton:Show()
			
			vPrevButton = vButton
			vButtonIndex = vButtonIndex + 1
		end
		
		vPrevRowFirstButton = vRowFirstButton
	end
	
	-- Hide unused buttons
	
	for vIndex = vButtonIndex, #self.Buttons do
		local vButton = self.Buttons[vIndex]
		
		vButton.Outfit = nil
		
		vButton:EnableMouse(false)
		vButton:Disable()
		vButton:Hide()
	end
	
	-- Set the textures and link them together
	
	local vTextureIndex = 1
	local vPrevRowFirstTexture
	local vRowFirstTexture
	
	local vTexVertCoord1 = Outfitter.Style.ButtonBar.BackgroundHeight0 / Outfitter.Style.ButtonBar.BackgroundTextureHeight
	local vTexVertCoord2 = (Outfitter.Style.ButtonBar.BackgroundHeight0 + Outfitter.Style.ButtonBar.BackgroundHeight) / Outfitter.Style.ButtonBar.BackgroundTextureHeight
	local vTexVertCoord3 = (Outfitter.Style.ButtonBar.BackgroundHeight0 + Outfitter.Style.ButtonBar.BackgroundHeight + Outfitter.Style.ButtonBar.BackgroundHeightN) / Outfitter.Style.ButtonBar.BackgroundTextureHeight
	
	local vTexHorizCoord1 = Outfitter.Style.ButtonBar.BackgroundWidth0 / Outfitter.Style.ButtonBar.BackgroundTextureWidth
	local vTexHorizCoord2 = (Outfitter.Style.ButtonBar.BackgroundWidth0 + Outfitter.Style.ButtonBar.BackgroundWidth) / Outfitter.Style.ButtonBar.BackgroundTextureWidth
	local vTexHorizCoord3 = (Outfitter.Style.ButtonBar.BackgroundWidth0 + Outfitter.Style.ButtonBar.BackgroundWidth + Outfitter.Style.ButtonBar.BackgroundWidthN) / Outfitter.Style.ButtonBar.BackgroundTextureWidth
	
	for vRow = 1, vNumTexRows do
		local vPrevTexture
		local vRowFirstTexture = self.BackgroundTextures[vTextureIndex]
		local vHeight, vTexTop, vTexBottom
		
		if vRow == 1 then
			vHeight = Outfitter.Style.ButtonBar.BackgroundHeight0
			vTexTop = 0
			vTexBottom = vTexVertCoord1
		elseif vRow == vNumTexRows then
			vHeight = Outfitter.Style.ButtonBar.BackgroundHeightN
			vTexTop = vTexVertCoord2
			vTexBottom = vTexVertCoord3
		else
			vHeight = Outfitter.Style.ButtonBar.BackgroundHeight
			vTexTop = vTexVertCoord1
			vTexBottom = vTexVertCoord2
		end
		
		for vColumn = 1, vNumTexColumns do
			local vTexture = self.BackgroundTextures[vTextureIndex]
			local vWidth, vTexLeft, vTexRight
			
			if vColumn == 1 then
				vWidth = Outfitter.Style.ButtonBar.BackgroundWidth0
				vTexLeft = 0
				vTexRight = vTexHorizCoord1
			elseif vColumn == vNumTexColumns then
				vWidth = Outfitter.Style.ButtonBar.BackgroundWidthN
				vTexLeft = vTexHorizCoord2
				vTexRight = vTexHorizCoord3
			else
				vWidth = Outfitter.Style.ButtonBar.BackgroundWidth
				vTexLeft = vTexHorizCoord1
				vTexRight = vTexHorizCoord2
			end
			
			vTexture:SetTexCoord(vTexLeft, vTexRight, vTexTop, vTexBottom)
			vTexture:SetHeight(vHeight)
			vTexture:SetWidth(vWidth)
			vTexture:ClearAllPoints()
			
			if vPrevTexture then
				vTexture:SetPoint("LEFT", vPrevTexture, "RIGHT")
			elseif vPrevRowFirstTexture then
				vTexture:SetPoint("TOP", vPrevRowFirstTexture, "BOTTOM")
			else
				vTexture:SetPoint("TOPLEFT", self, "TOPLEFT")
			end
			
			if not self.HideBackground then
				vTexture:Show()
			end
			
			vPrevTexture = vTexture
			vTextureIndex = vTextureIndex + 1
		end
		
		vPrevRowFirstTexture = vRowFirstTexture
	end
	
	-- Hide unused textures
	
	for vIndex = vTextureIndex, #self.BackgroundTextures do
		local vTexture = self.BackgroundTextures[vIndex]
		
		vTexture:ClearAllPoints()
		vTexture:Hide()
	end
	
	-- Resize the bar
	
	self:SetWidth(Outfitter.Style.ButtonBar.BackgroundWidth * (pNumColumns - 1) + Outfitter.Style.ButtonBar.BackgroundWidth0 + Outfitter.Style.ButtonBar.BackgroundWidthN)
	self:SetHeight(Outfitter.Style.ButtonBar.BackgroundHeight * (pNumRows - 1) + Outfitter.Style.ButtonBar.BackgroundHeight0 + Outfitter.Style.ButtonBar.BackgroundHeightN)
end

function Outfitter._ButtonBar:GetIndexedButton(pButtonIndex)
	local vNumButtons = self.NumColumns * self.NumRows
	
	if not pButtonIndex or pButtonIndex < 1 or pButtonIndex > vNumButtons then
		return
	end
	
	return self.Buttons[pButtonIndex]
end

function Outfitter._ButtonBar:ShowBackground(pShow)
	self.HideBackground = not pShow
	
	if self.HideBackground then
		for vIndex, vTexture in ipairs(self.BackgroundTextures) do
			if vIndex > self.NumTextures then
				break
			end
			
			vTexture:Hide()
		end
	else
		for vIndex, vTexture in ipairs(self.BackgroundTextures) do
			if vIndex > self.NumTextures then
				break
			end
			
			vTexture:Show()
		end
	end
end

----------------------------------------
Outfitter._SidebarWindowFrame = {}
----------------------------------------

function Outfitter._SidebarWindowFrame:Construct()
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
	
	self.Background.ShadowFrame = CreateFrame("Frame", nil, self)
	self.Background.ShadowFrame:SetWidth(16)
	self.Background.ShadowFrame:SetPoint("TOPLEFT", self, "TOPLEFT")
	self.Background.ShadowFrame:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT")
	self.Background.ShadowFrame:SetFrameLevel(self:GetFrameLevel() + 20)
	
	self.Background.Shadow = self.Background.ShadowFrame:CreateTexture(nil, "OVERLAY")
	self.Background.Shadow:SetAllPoints()
	self.Background.Shadow:SetTexture(0, 0, 0, 1)
	self.Background.Shadow:SetGradientAlpha(
			"HORIZONTAL",
			1, 1, 1, 1,
			1, 1, 1, 0)
end

----------------------------------------
Outfitter._PortraitWindowFrame = {}
----------------------------------------

function Outfitter._PortraitWindowFrame:Construct()
	-- Create the textures
	
	self.TopHeight = 80
	self.LeftWidth = 80
	self.BottomHeight = 183
	self.RightWidth = 94
	
	self.TopMargin = 13
	self.LeftMargin = 12
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
	
	-- Create the four corners first
	
	self.Background.TopLeft = self:CreateTexture(nil, "BORDER")
	self.Background.TopLeft:SetWidth(self.LeftWidth)
	self.Background.TopLeft:SetHeight(self.TopHeight)
	self.Background.TopLeft:SetPoint("TOPLEFT", self, "TOPLEFT", -self.LeftMargin, self.TopMargin)
	self.Background.TopLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft")
	self.Background.TopLeft:SetTexCoord(0, self.TexCoordX1, 0, self.TexCoordY1)
	
	self.Background.TopRight = self:CreateTexture(nil, "BORDER")
	self.Background.TopRight:SetWidth(self.RightWidth)
	self.Background.TopRight:SetHeight(self.TopHeight)
	self.Background.TopRight:SetPoint("TOPRIGHT", self, "TOPRIGHT", self.RightMargin, self.TopMargin)
	self.Background.TopRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight")
	self.Background.TopRight:SetTexCoord(self.TexCoordX2, self.TexCoordX3, 0, self.TexCoordY1)
	
	self.Background.BottomLeft = self:CreateTexture(nil, "BORDER")
	self.Background.BottomLeft:SetWidth(self.LeftWidth)
	self.Background.BottomLeft:SetHeight(self.BottomHeight)
	self.Background.BottomLeft:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", -self.LeftMargin, -self.BottomMargin)
	self.Background.BottomLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomLeft")
	self.Background.BottomLeft:SetTexCoord(0, self.TexCoordX1, self.TexCoordY2, self.TexCoordY3)
	
	self.Background.BottomRight = self:CreateTexture(nil, "BORDER")
	self.Background.BottomRight:SetWidth(self.RightWidth)
	self.Background.BottomRight:SetHeight(self.BottomHeight)
	self.Background.BottomRight:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", self.RightMargin, -self.BottomMargin)
	self.Background.BottomRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomRight")
	self.Background.BottomRight:SetTexCoord(self.TexCoordX2, self.TexCoordX3, self.TexCoordY2, self.TexCoordY3)
	
	self.Background.TopMiddle = self:CreateTexture(nil, "BORDER")
	self.Background.TopMiddle:SetHeight(self.TopHeight)
	self.Background.TopMiddle:SetPoint("TOPLEFT", self.Background.TopLeft, "TOPRIGHT")
	self.Background.TopMiddle:SetPoint("TOPRIGHT", self.Background.TopRight, "TOPLEFT")
	self.Background.TopMiddle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft")
	self.Background.TopMiddle:SetTexCoord(self.TexCoordX1, 1, 0, self.TexCoordY1)
	
	self.Background.BottomMiddle = self:CreateTexture(nil, "BORDER")
	self.Background.BottomMiddle:SetHeight(self.BottomHeight)
	self.Background.BottomMiddle:SetPoint("TOPLEFT", self.Background.BottomLeft, "TOPRIGHT")
	self.Background.BottomMiddle:SetPoint("TOPRIGHT", self.Background.BottomRight, "TOPLEFT")
	self.Background.BottomMiddle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomLeft")
	self.Background.BottomMiddle:SetTexCoord(self.TexCoordX1, 1, self.TexCoordY2, self.TexCoordY3)
	
	self.Background.LeftMiddle = self:CreateTexture(nil, "BORDER")
	self.Background.LeftMiddle:SetWidth(self.LeftWidth)
	self.Background.LeftMiddle:SetPoint("TOPLEFT", self.Background.TopLeft, "BOTTOMLEFT")
	self.Background.LeftMiddle:SetPoint("BOTTOMLEFT", self.Background.BottomLeft, "TOPLEFT")
	self.Background.LeftMiddle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft")
	self.Background.LeftMiddle:SetTexCoord(0, self.TexCoordX1, self.TexCoordY1, 1)
	
	self.Background.RightMiddle = self:CreateTexture(nil, "BORDER")
	self.Background.RightMiddle:SetWidth(self.RightWidth)
	self.Background.RightMiddle:SetPoint("TOPRIGHT", self.Background.TopRight, "BOTTOMRIGHT")
	self.Background.RightMiddle:SetPoint("BOTTOMRIGHT", self.Background.BottomRight, "TOPRIGHT")
	self.Background.RightMiddle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight")
	self.Background.RightMiddle:SetTexCoord(self.TexCoordX2, self.TexCoordX3, self.TexCoordY1, 1)
	
	self.Background.Middle = self:CreateTexture(nil, "BORDER")
	self.Background.Middle:SetPoint("TOPLEFT", self.Background.TopLeft, "BOTTOMRIGHT")
	self.Background.Middle:SetPoint("TOPRIGHT", self.Background.TopRight, "BOTTOMLEFT")
	self.Background.Middle:SetPoint("BOTTOMLEFT", self.Background.BottomLeft, "TOPRIGHT")
	self.Background.Middle:SetPoint("BOTTOMRIGHT", self.Background.BottomRight, "TOPLEFT")
	self.Background.Middle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft")
	self.Background.Middle:SetTexCoord(self.TexCoordX1, 1, self.TexCoordY1, 1)
	
	self.CloseButton = Outfitter:NewCloseButton(self)
	self.CloseButton:SetPoint("TOPRIGHT", self, "TOPRIGHT", -3, -3)
end

function Outfitter:NewCloseButton(pParent)
	local vButton = CreateFrame("Button", nil, pParent)
	local vTexture
	
	vButton:SetWidth(17)
	vButton:SetHeight(17)
	
	local vTexture
	
	vButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
	vTexture = vButton:GetNormalTexture()
	vTexture:SetTexCoord(0.1875, 0.78125, 0.21875, 0.78125)
	
	vButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
	vTexture = vButton:GetPushedTexture()
	vTexture:SetTexCoord(0.1875, 0.78125, 0.21875, 0.78125)
	
	vButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
	vTexture = vButton:GetHighlightTexture()
	vTexture:SetTexCoord(0.1875, 0.78125, 0.21875, 0.78125)
	vTexture:SetBlendMode("ADD")
	
	return vButton
end

function Outfitter.CursorInFrame(pFrame)
	local vCursorX, vCursorY = GetCursorPosition()
	
	return Outfitter.PointInFrame(pFrame, vCursorX, vCursorY)
end

function Outfitter.PointInFrame(pFrame, pPointX, pPointY)
	local vLeft, vRight, vTop, vBottom = Outfitter.GetFrameEffectiveBounds(pFrame)
	
	return pPointX >= vLeft
	   and pPointX < vRight
	   and pPointY <= vTop
	   and pPointY > vBottom
end

function Outfitter.GetFrameEffectiveBounds(pFrame)
	local vEffectiveScale = pFrame:GetEffectiveScale()
	
	return pFrame:GetLeft() * vEffectiveScale,
	       pFrame:GetRight() * vEffectiveScale,
	       pFrame:GetTop() * vEffectiveScale,
	       pFrame:GetBottom() * vEffectiveScale
end

function Outfitter:BeginMenu(pMenu)
	table.insert(UIMenus, pMenu:GetName())
end

function Outfitter:EndMenu(pMenu)
	local vName = pMenu:GetName()
	
	for vIndex = #UIMenus, 1, -1 do
		if vName == UIMenus[vIndex] then
			table.remove(UIMenus, vIndex)
			break
		end
	end
end

function Outfitter:FrameMouseDown(pFrame)
	-- Note the position in case the user decides to drag
	
	if not pFrame.DraggingInfo then
		pFrame.DraggingInfo = {}
	end
	
	pFrame.DraggingInfo.CursorStartX, pFrame.DraggingInfo.CursorStartY = GetCursorPosition()
end
	
function Outfitter:StartMovingFrame(pFrame)
	if not pFrame.DraggingInfo then
		return
	end
	
	pFrame.DraggingInfo.StartX = pFrame:GetLeft() * pFrame:GetEffectiveScale()
	pFrame.DraggingInfo.StartY = pFrame:GetTop() * pFrame:GetEffectiveScale() - UIParent:GetTop() * UIParent:GetEffectiveScale()

	Outfitter.SchedulerLib:ScheduleRepeatingTask(0, self.UpdateMovingFrame, pFrame)
end

function Outfitter.UpdateMovingFrame(pFrame) -- Note this is not a method, just a function
	if not pFrame.DraggingInfo then
		Outfitter:FrameStopDragging(pFrame)
		return
	end
	
	-- Move the frame being dragged
	
	local vCursorX, vCursorY = GetCursorPosition()
	
	local vCursorDeltaX = vCursorX - pFrame.DraggingInfo.CursorStartX
	local vCursorDeltaY = vCursorY - pFrame.DraggingInfo.CursorStartY
	
	--
	
	local vPositionX = pFrame.DraggingInfo.StartX + vCursorDeltaX
	local vPositionY = pFrame.DraggingInfo.StartY + vCursorDeltaY
	
	if pFrame.DraggingInfo.PositionX ~= vPositionX
	or pFrame.DraggingInfo.PositionY ~= vPositionY then
		
		pFrame.DraggingInfo.PositionX = vPositionX
		pFrame.DraggingInfo.PositionY = vPositionY
		
		pFrame:ClearAllPoints()
		pFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", vPositionX / pFrame:GetEffectiveScale(), vPositionY / pFrame:GetEffectiveScale())
	end
end

function Outfitter:StopMovingFrame(pFrame)
	Outfitter.SchedulerLib:UnscheduleTask(self.UpdateMovingFrame, pFrame)
end

function Outfitter.SetFrameLevel(pFrame, pLevel)
	pFrame:SetFrameLevel(pLevel)
	
	local	vChildren = {pFrame:GetChildren()}
	
	for _, vChildFrame in pairs(vChildren) do
		Outfitter.SetFrameLevel(vChildFrame, pLevel + 1)
	end
end

function Outfitter.SetFrameStrata(pFrame, pStrata)
	pFrame:SetFrameStrata(pStrata)
	
	local vChildren = {pFrame:GetChildren()}
	
	for _, vChildFrame in pairs(vChildren) do
		Outfitter.SetFrameStrata(vChildFrame, pStrata)
	end
end

