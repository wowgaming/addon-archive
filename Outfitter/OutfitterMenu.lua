----------------------------------------
Outfitter._MenuManager = {}
----------------------------------------

function Outfitter._MenuManager:Construct()
	self.DropDownList = Outfitter:New(Outfitter._DropDownList, nil, 1)
end

function Outfitter._MenuManager:Test()
	local vItemList2 =
	{
		{text = "Submenu item 1", value = 1, checked = true},
		{text = "and item 2", value = 2, checked = false},
		{text = "Item 3", value = 3, checked = false},
		{text = "Item 4", value = 4, checked = true},
	}
	
	local vItemList =
	{
		{text = "Short item", value = 1, checked = true},
		{text = "A much longer item", value = 2, checked = false},
		{text = "Submenu", value = 3, hasArrow = true, menuList = vItemList2},
		{text = "Title", isTitle = true, notCheckable = true},
		{text = "Checked item", value = 4, checked = true},
		{text = "Disabled item", value = 3, disabled = true},
	}
	
	self.DropDownList:ShowList("CENTER", UIParent, "CENTER", 0, 0, vItemList)
end

----------------------------------------
Outfitter._DropDownMenu = {}
----------------------------------------

function Outfitter._DropDownMenu:Construct()
	self.MINBUTTONS = 8
	self.MAXBUTTONS = 8
	self.MAXLEVELS = 2
	self.OPEN_MENU = nil -- The current open menu
	self.INIT_MENU = nil -- The current menu being initialized
	self.MENU_LEVEL = 1 -- Current level shown of the open menu
	self.MENU_VALUE = nil -- Current value of the open menu
	self.SHOW_TIME = 2 -- Time to wait to hide the menu
	self.DEFAULT_TEXT_HEIGHT = nil -- Default dropdown text height
	self.OPEN_DROPDOWNMENUS = {} -- List of open menus

	self.ButtonInfo = {}

	self.DropDownList = {}
	table.insert(self.DropDownList, self:CreateMenu(1))
	
	local vFontName, vFontHeight, vFontFlags = getglobal("OutfitterDropDownList1Button1NormalText"):GetFont()
	self.DEFAULT_TEXT_HEIGHT = vFontHeight
end

function Outfitter._DropDownMenu:CreateMenu(pLevel)
	vDropDownList = CreateFrame("Button", "OutfitterDropDownList"..pLevel, nil, "UIDropDownListTemplate")
	vDropDownList:SetID(pLevel)
	vDropDownList:SetFrameStrata("FULLSCREEN_DIALOG")
	vDropDownList:SetTopLevel(true)
	vDropDownList:SetWidth(180)
	vDropDownList:SetHeight(10)
	vDropDownList:SetScript("OnHide", function (pFrame) self:OnHide(pFrame) end)
	vDropDownList:Hide()
	
	return vDropDownList
end

function Outfitter._DropDownMenu:Initialize(pFrame, pInitFunction, pDisplayMode, pLevel, pMenuList)
	local vFrameName = pFrame:GetName()
	
	pFrame.menuList = pMenuList;

	if vFrameName ~= self.OPEN_MENU then
		self.MENU_LEVEL = 1
	end

	-- Set the frame that's being intialized
	
	self.INIT_MENU = vFrameName

	-- Hide all the buttons
	
	local vButton
	
	for vIndex, vDropDownList in ipairs(self.DropDownList) do
		if vIndex >= self.MENU_LEVEL or vFrameName ~= self.OPEN_MENU then
			vDropDownList.numButtons = 0;
			vDropDownList.maxWidth = 0;
			
			for vIndex2 = 1, self.MAXBUTTONS do
				local vButton = getglobal("OutfitterDropDownList"..vIndex.."Button"..vIndex2)
				vButton:Hide()
			end
			
			vDropDownList:Hide()
		end
	end
	
	pFrame:SetHeight(Outfitter._DropDownListItem.BUTTON_HEIGHT * 2)
	
	-- Set the initialize function and call it.  The initFunction populates the dropdown list.
	
	if pInitFunction then
		pFrame.initialize = pInitFunction;
		pInitFunction(pLevel, pFrame.menuList)
	end
	
	-- Change appearance based on the displayMode
	
	if pDisplayMode == "MENU" then
		getglobal(vFrameName.."Left"):Hide()
		getglobal(vFrameName.."Middle"):Hide()
		getglobal(vFrameName.."Right"):Hide()
		getglobal(vFrameName.."ButtonNormalTexture"):SetTexture("")
		getglobal(vFrameName.."ButtonDisabledTexture"):SetTexture("")
		getglobal(vFrameName.."ButtonPushedTexture"):SetTexture("")
		getglobal(vFrameName.."ButtonHighlightTexture"):SetTexture("")
		getglobal(vFrameName.."Button"):ClearAllPoints()
		getglobal(vFrameName.."Button"):SetPoint("LEFT", vFrameName.."Text", "LEFT", -9, 0)
		getglobal(vFrameName.."Button"):SetPoint("RIGHT", vFrameName.."Text", "RIGHT", 6, 0)
		pFrame.displayMode = "MENU"
	end
end

function Outfitter._DropDownMenu:SetSelectedName(pFrame, pName, pUseValue)
	pFrame.selectedName = pName
	pFrame.selectedID = nil
	pFrame.selectedValue = nil
	
	self:Refresh(pFrame, pUseValue)
end

function Outfitter._DropDownMenu:SetSelectedValue(pFrame, pValue, pUseValue)
	-- pUseValue will set the value as the text, not the name
	
	pFrame.selectedName = nil
	pFrame.selectedID = nil
	pFrame.selectedValue = pValue
	
	self:Refresh(pFrame, pUseValue)
end

function Outfitter._DropDownMenu:SetSelectedID(pFrame, pID, pUseValue)
	pFrame.selectedID = pID
	pFrame.selectedName = nil
	pFrame.selectedValue = nil
	
	self:Refresh(pFrame, pUseValue)
end

function Outfitter._DropDownMenu:GetSelectedName(pFrame)
	return pFrame.selectedName;
end

function Outfitter._DropDownMenu:GetSelectedID(pFrame)
	if pFrame.selectedID then
		return pFrame.selectedID
	end
	
	-- If no explicit selectedID then try to send the id of a selected value or name
	
	local vButton
	
	for vIndex = 1, self.MAXBUTTONS do
		vButton = getglobal("OutfitterDropDownList"..self.MENU_LEVEL.."Button"..vIndex)
		
		-- See if checked or not
		
		if self:GetSelectedName(pFrame) then
			if vButton:GetText() == self:GetSelectedName(pFrame) then
				return vIndex
			end
		
		elseif self:GetSelectedValue(pFrame) then
			if vButton.value == self:GetSelectedValue(pFrame) then
				return vIndex
			end
		end
	end
end

function Outfitter._DropDownMenu:GetSelectedValue(pFrame)
	return pFrame.selectedValue;
end

function Outfitter._DropDownMenu:HideDropDownMenu(pLevel)
	self.DropDownList[pLevel]:Hide()
end

function Outfitter._DropDownMenu:ToggleDropDownMenu(pLevel, pValue, pDropDownFrame, pAnchorName, pXOffset, pYOffset, pMenuList)
	if not pLevel then
		pLevel = 1
	end
	
	self:CreateFrames(pLevel, 0)
	
	self.MENU_LEVEL = pLevel
	self.MENU_VALUE = pValue
	
	local vListFrame = self.DropDownList[pLevel]
	local vListFrameName = vListFrame:GetName()
	local vTempFrame
	local vPoint, vRelativePoint, vRelativeTo
	
	if not pDropDownFrame then
		vTempFrame = self:GetParent()
	else
		vTempFrame = pDropDownFrame
	end
	
	if vListFrame:IsShown() and self.OPEN_MENU == vTempFrame:GetName() then
		vListFrame:Hide()
	else
		-- Set the dropdownframe scale
		
		local vUIScale
		local vUIParentScale = UIParent:GetScale()
		
		if vTempFrame ~= WorldMapContinentDropDown and vTempFrame ~= WorldMapZoneDropDown then
			if GetCVar("useUIScale") == "1" then
				vUIScale = tonumber(GetCVar("uiscale"))
				if vUIParentScale < vUIScale then
					vUIScale = vUIParentScale
				end
			else
				vUIScale = vUIParentScale
			end
		else
			vUIScale = 1
		end
		
		vListFrame:SetScale(vUIScale)
		
		-- Hide the listframe anyways since it is redrawn OnShow() 
		
		vListFrame:Hide()
		
		-- Frame to anchor the dropdown menu to
		
		local vAnchorFrame;

		-- Display stuff
		
		-- Level specific stuff
		
		if pLevel == 1 then
			if not pDropDownFrame then
				pDropDownFrame = self:GetParent()
			end
			
			self.OPEN_MENU = pDropDownFrame:GetName()
			
			vListFrame:ClearAllPoints()
			
			-- If there's no specified anchorName then use left side of the dropdown menu
			
			if not pAnchorName then
				-- See if the anchor was set manually using setanchor
				
				if pDropDownFrame.xOffset then
					pXOffset = pDropDownFrame.xOffset
				end
				
				if pDropDownFrame.yOffset then
					pYOffset = pDropDownFrame.yOffset
				end
				
				if pDropDownFrame.point then
					vPoint = pDropDownFrame.point
				end
				
				if pDropDownFrame.relativeTo then
					vRelativeTo = pDropDownFrame.relativeTo
				else
					vRelativeTo = self.OPEN_MENU.."Left"
				end
				
				if pDropDownFrame.relativePoint then
					vRelativePoint = pDropDownFrame.relativePoint
				end
			elseif pAnchorName == "cursor" then
				local vCursorX, vCursorY = GetCursorPosition()
				
				vCursorX = vCursorX / vUIScale
				vCursorY =  vCursorY / vUIScale

				vRelativeTo = nil
				
				if not pXOffset then
					pXOffset = 0
				end
				
				if not pYOffset then
					pYOffset = 0
				end
				
				pXOffset = vCursorX + pXOffset
				pYOffset = vCursorY + pYOffset
			else
				vRelativeTo = pAnchorName
			end
			
			if not pXOffset or not pYOffset then
				pXOffset = 8
				pYOffset = 22
			end
			
			if not vPoint then
				vPoint = "TOPLEFT"
			end
			
			if not vRelativePoint then
				vRelativePoint = "BOTTOMLEFT"
			end
			
			vListFrame:SetPoint(vPoint, vRelativeTo, vRelativePoint, pXOffset, pYOffset)
		else -- Level > 1
			if not pDropDownFrame then
				pDropDownFrame = getglobal(self.OPEN_MENU);
			end
			
			vListFrame:ClearAllPoints()
			
			-- If this is a dropdown button, not the arrow anchor it to itself
			
			if strsub(this:GetParent():GetName(), 0, 21) == "OutfitterDropDownList" and strlen(this:GetParent():GetName()) == 22 then
				vAnchorFrame = this
			else
				vAnchorFrame = this:GetParent()
			end
			
			vPoint = "TOPLEFT"
			vRelativePoint = "TOPRIGHT"
			
			vListFrame:SetPoint(vPoint, vAnchorFrame, vRelativePoint, 0, 0)
		end
		
		-- Change list box appearance depending on display mode
		
		if pDropDownFrame.displayMode == "MENU" then
			getglobal(vListFrameName.."Backdrop"):Hide()
			getglobal(vListFrameName.."MenuBackdrop"):Show()
		else
			getglobal(vListFrameName.."Backdrop"):Show()
			getglobal(vListFrameName.."MenuBackdrop"):Hide()
		end
		
		pDropDownFrame.menuList = pMenuList
		
		self:Initialize(pDropDownFrame, pDropDownFrame.initialize, nil, pLevel, pMenuList)
		
		-- If no items in the drop down don't show it
		
		if vListFrame.numButtons == 0 then
			return
		end

		-- Check to see if the dropdownlist is off the screen, if it is anchor it to the top of the dropdown button
		
		vListFrame:Show();
		
		-- Hack since GetCenter() is returning coords relative to 1024x768
		
		local x, y = vListFrame:GetCenter()
		
		-- Hack will fix this in next revision of dropdowns
		
		if not x or not y then
			vListFrame:Hide()
			return
		end
		
		-- Determine whether the menu is off the screen or not
		
		local vOffscreenY, vOffscreenX
		
		if (y - vListFrame:GetHeight() / 2) < 0 then
			vOffscreenY = 1
		end
		
		if vListFrame:GetRight() > GetScreenWidth() then
			vOffscreenX = 1
		end
		
		--  If level 1 can only go off the bottom of the screen
		
		if pLevel == 1 then
			if vOffscreenY and vOffscreenX then
				vPoint = gsub(vPoint, "TOP(.*)", "BOTTOM%1")
				vPoint = gsub(vPoint, "(.*)LEFT", "%1RIGHT")
				vRelativePoint = gsub(vRelativePoint, "TOP(.*)", "BOTTOM%1")
				vRelativePoint = gsub(vRelativePoint, "(.*)RIGHT", "%1LEFT")
			elseif vOffscreenY then
				vPoint = gsub(point, "TOP(.*)", "BOTTOM%1")
				vRelativePoint = gsub(vRelativePoint, "(.*)RIGHT", "%1LEFT")
			elseif vOffscreenX then
				vPoint = gsub(point, "(.*)LEFT", "%1RIGHT");
				vRelativePoint = gsub(vRelativePoint, "(.*)RIGHT", "%1LEFT");
			end
			
			vListFrame:ClearAllPoints()
			
			if pAnchorName == "cursor" then
				vListFrame:SetPoint(vPoint, vRelativeTo, "BOTTOMLEFT", vXOffset, vYOffset)
			else
				vListFrame:SetPoint(vPoint, vRelativeTo, vRelativePoint, vXOffset, vYOffset)
			end
		else
			if vOffscreenY and vOffscreenX then
				vPoint = gsub(vPoint, "TOP(.*)", "BOTTOM%1")
				vPoint = gsub(vPoint, "(.*)LEFT", "%1RIGHT")
				vRelativePoint = gsub(vRelativePoint, "TOP(.*)", "BOTTOM%1")
				vRelativePoint = gsub(vRelativePoint, "(.*)RIGHT", "%1LEFT")
				vXOffset = -11
				vYOffset = -14
			elseif vOffscreenY then
				vPoint = gsub(point, "TOP(.*)", "BOTTOM%1")
				vRelativePoint = gsub(vRelativePoint, "TOP(.*)", "BOTTOM%1")
				vXOffset = 0
				vYOffset = -14
			elseif vOffscreenX then
				vPoint = gsub(vPoint, "(.*)LEFT", "%1RIGHT")
				vRelativePoint = gsub(vRelativePoint, "(.*)RIGHT", "%1LEFT")
				vXOffset = -11
				vYOffset = 14
			else
				vXOffset = 0
				vYOffset = 14
			end
			
			vListFrame:ClearAllPoints()
			vListFrame:SetPoint(vPoint, vAnchorFrame, vRelativePoint, vXOffset, vYOffset)
		end
	end
end

function Outfitter._DropDownMenu:CloseDropDownMenus(pLevel)
	if not pLevel then
		pLevel = 1
	end
	
	for vIndex = pLevel, self.self.MAXLEVELS do
		self.DropDownList[vIndex]:Hide()
	end
end

function Outfitter._DropDownMenu:SetWidth(pWidth, pFrame)
	if not pFrame then
		frame = this
	end
	
	getglobal(pFrame:GetName().."Middle"):SetWidth(pWidth)
	pFrame:SetWidth(pWidth + 25 + 25)
	getglobal(pFrame:GetName().."Text"):SetWidth(pWidth - 25)
	pFrame.noResize = 1
end

function Outfitter._DropDownMenu:SetButtonWidth(pWidth, pFrame)
	if not pFrame then
		pFrame = this
	end
	
	if pWidth == "TEXT" then
		pWidth = getglobal(pFrame:GetName().."Text"):GetWidth();
	end
	
	getglobal(pFrame:GetName().."Button"):SetWidth(pWidth)
	pFrame.noResize = 1
end

function Outfitter._DropDownMenu:SetText(pText, pFrame)
	if not pFrame then
		pFrame = this
	end
	
	local vFilterText = getglobal(pFrame:GetName().."Text")
	
	vFilterText:SetText(pText)
end

function Outfitter._DropDownMenu:GetText(pFrame)
	if not pFrame then
		pFrame = this
	end
	
	local vFilterText = getglobal(pFrame:GetName().."Text")
	
	return vFilterText:GetText()
end

function Outfitter._DropDownMenu:ClearAll(pFrame)
	-- Previous code refreshed the menu quite often and was a performance bottleneck
	
	pFrame.selectedID = nil
	pFrame.selectedName = nil
	pFrame.selectedValue = nil
	self:SetText("", pFrame)
	
	local vButton, vCheckImage
	
	for vIndex = 1, self.MAXBUTTONS do
		vButton = getglobal("OutfitterDropDownList"..self.MENU_LEVEL.."Button"..vIndex)
		vButton:UnlockHighlight()

		vCheckImage = getglobal("OutfitterDropDownList"..self.MENU_LEVEL.."Button"..vIndex.."Check")
		
		vCheckImage:Hide()
	end
end

function Outfitter._DropDownMenu:JustifyText(pJustification, pFrame)
	if not pFrame then
		pFrame = this
	end
	
	local vText = getglobal(pFrame:GetName().."Text")
	
	vText:ClearAllPoints()
	
	if pJustification == "LEFT" then
		vText:SetPoint("LEFT", pFrame:GetName().."Left", "LEFT", 27, 2)
		vText:SetJustifyH("LEFT")
	
	elseif pJustification == "RIGHT" then
		vText:SetPoint("RIGHT", pFrame:GetName().."Right", "RIGHT", -43, 2)
		vText:SetJustifyH("RIGHT")
	
	elseif justification == "CENTER" then
		vText:SetPoint("CENTER", pFrame:GetName().."Middle", "CENTER", -5, 2)
		vText:SetJustifyH("CENTER")
	end
end

function Outfitter._DropDownMenu:SetAnchor(pXOffset, pYOffset, pDropdown, pPoint, pRelativeTo, pRelativePoint)
	if not pDropdown then
		pDropdown = this
	end
	
	pDropdown.xOffset = pXOffset
	pDropdown.yOffset = pYOffset
	pDropdown.point = pPoint;
	pDropdown.relativeTo = pRelativeTo;
	pDropdown.relativePoint = pRelativePoint;
end

function Outfitter._DropDownMenu:GetCurrentDropDown()
	if self.OPEN_MENU then
		return getglobal(self.OPEN_MENU)
	end
	
	-- If no dropdown then use this
	
	return this
end

function Outfitter._DropDownMenu:Button_GetChecked()
	return getglobal(this:GetName().."Check"):IsShown()
end

function Outfitter._DropDownMenu:Button_GetName()
	return getglobal(this:GetName().."NormalText"):GetText()
end

function Outfitter._DropDownMenu:Button_OpenColorPicker(pButton)
end

function Outfitter._DropDownMenu:DisableButton(pLevel, pID)
	getglobal("OutfitterDropDownList"..pLevel.."Button"..pID):Disable()
end

function Outfitter._DropDownMenu:EnableButton(pLevel, pID)
	getglobal("OutfitterDropDownList"..pLevel.."Button"..pID):Enable()
end

function Outfitter._DropDownMenu:SetButtonText(pLevel, pID, pText, pRed, pGreen, pBlue)
	local vButton = getglobal("OutfitterDropDownList"..pLevel.."Button"..pID)
	
	vButton:SetText(pText)
	
	if pRed then
		vButton:SetTextColor(pRed, pGreen, pBlue)
		vButton:SetHighlightTextColor(pRed, pGreen, pBlue)
	end
end

function Outfitter._DropDownMenu:DisableDropDown(pDropDown)
	local vLabel = getglobal(pDropDown:GetName().."Label")
	
	if vLabel then
		vLabel:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
	end
	
	getglobal(pDropDown:GetName().."Text"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
	getglobal(pDropDown:GetName().."Button"):Disable()
	
	pDropDown.isDisabled = 1
end

function Outfitter._DropDownMenu:EnableDropDown(pDropDown)
	local vLabel = getglobal(pDropDown:GetName().."Label")
	
	if vLabel then
		vLabel:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
	end
	
	getglobal(pDropDown:GetName().."Text"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	getglobal(pDropDown:GetName().."Button"):Enable()
	
	pDropDown.isDisabled = nil
end

function Outfitter._DropDownMenu:IsEnabled(pDropDown)
	return not pDropDown.isDisabled
end

function Outfitter._DropDownMenu:GetValue(pID)
	--Only works if the dropdown has just been initialized, lame, I know =(
	
	local vButton = getglobal("OutfitterDropDownList1Button"..pID)
	
	if vButton then
		return getglobal("OutfitterDropDownList1Button"..pID).value
	else
		return nil
	end
end

----------------------------------------
Outfitter._DropDownList = {}
----------------------------------------

Outfitter._DropDownList.SHOW_TIME = 2

--[[
List of item attributes
======================================================
info.text = [STRING]  --  The text of the button
info.value = [ANYTHING]  --  The value that MENU_VALUE is set to when the button is clicked
info.func = [function()]  --  The function that is called when you click the button
info.checked = [nil, true, function]  --  Check the button if true or function returns true
info.isTitle = [nil, true]  --  If it's a title the button is disabled and the font color is set to yellow
info.disabled = [nil, true]  --  Disable the button and show an invisible button that still traps the mouseover event so menu doesn't time out
info.hasArrow = [nil, true]  --  Show the expand arrow for multilevel menus
info.hasColorSwatch = [nil, true]  --  Show color swatch or not, for color selection
info.r = [1 - 255]  --  Red color value of the color swatch
info.g = [1 - 255]  --  Green color value of the color swatch
info.b = [1 - 255]  --  Blue color value of the color swatch
info.textR = [1 - 255]  --  Red color value of the button text
info.textG = [1 - 255]  --  Green color value of the button text
info.textB = [1 - 255]  --  Blue color value of the button text
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
info.textHeight = [NUMBER] -- font height for button text
info.menuTable = [TABLE] -- This contains an array of info tables to be displayed as a child menu
]]

function Outfitter._DropDownList:New(pParentList, pLevel)
	return CreateFrame("Button", nil, tern(pParentList ~= nil, pParentList, UIParent))
end

function Outfitter._DropDownList:Construct(pParentList, pLevel)
	self.parent = pParentList
	self.level = pLevel
	
	self:Hide()
	self:SetFrameStrata("FULLSCREEN_DIALOG")
	self:EnableMouse(true)
	self:SetID(pLevel)
	self:SetToplevel(true)
	self:SetWidth(180)
	self:SetHeight(10)
	
	self.Backdrop = CreateFrame("Frame", nil, self)
	self.Backdrop:SetAllPoints()
	self.Backdrop:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true, tileSize = 32, edgeSize= 32,
		insets = {left = 11, right = 12, top = 12, bottom = 11}})
	self:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
	
	self.MenuBackdrop = CreateFrame("Frame", nil, self)
	self.MenuBackdrop:SetAllPoints()
	self.MenuBackdrop:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize= 16,
		insets = {left = 5, right = 5, top = 5, bottom = 5}})
	self:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
	
	self.Items = {}
	
	self:SetScript("OnClick", self.OnClick)
	self:SetScript("OnEnter", self.OnEnter)
	self:SetScript("OnLeave", self.OnLeave)
	self:SetScript("OnUpdate", self.OnUpdate)
	self:SetScript("OnShow", self.OnShow)
	self:SetScript("OnHide", self.OnHide)
end

function Outfitter._DropDownList:ShowList(pPoint, pRelativeTo, pRelativePoint, pXOffset, pYOffset, pItemList)
	-- Change list box appearance depending on display mode
	
	if pDisplayMode == "MENU" then
		self.Backdrop:Hide()
		self.MenuBackdrop:Show()
	else
		self.Backdrop:Show()
		self.MenuBackdrop:Hide()
	end
	
	-- Populate the list
	
	self:ClearItems()
	
	if pItemList then
		self:SetMaxItems(#pItemList)
		
		for _, vInfo in ipairs(pItemList) do
			self:AddItem(vInfo)
		end
	end
	
	-- Anchor the list
	
	self:ClearAllPoints()
	self:SetPoint(pPoint, pRelativeTo, pRelativePoint, pXOffset, pYOffset)
	
	self:Refresh()
	
	self:Show()
end

function Outfitter._DropDownList:ShowChildList(pPoint, pRelativeTo, pRelativePoint, pXOffset, pYOffset, pItemList)
	if not self.child then
		self.child = Outfitter:New(Outfitter._DropDownList, self, self.level + 1)
	end
	
	self.child:ShowList(pPoint, pRelativeTo, pRelativePoint, pXOffset, pYOffset, pItemList)
end

function Outfitter._DropDownList:OnClick()
	self:Hide()
end

function Outfitter._DropDownList:OnEnter()
	self:StopCounting()
end

function Outfitter._DropDownList:OnLeave()
	self:StartCounting()
end

function Outfitter._DropDownList:OnUpdate(pElapsed)
	if not self.showTimer
	or not self.isCounting then
		return
	end
	
	if self.showTimer < 0 then
		self:Hide()
		self.showTimer = nil
		self.isCounting = nil
	else
		self.showTimer = self.showTimer - pElapsed
	end
end

function Outfitter._DropDownList:OnShow()
	if not self.noResize then
		for vIndex, vItem in ipairs(self.Items) do
			vItem:SetWidth(self.maxWidth)
		end
		
		self:SetWidth(self.maxWidth + 25)
	end
	
	self.showTime = nil
end

function Outfitter._DropDownList:OnHide()
	self:CloseChildren()
end

function Outfitter._DropDownList:CloseChildren()
	if not self.child then
		return
	end
	
	self.child:Hide()
end

function Outfitter._DropDownList:StartCounting()
	if self.parent then
		self.parent:StartCounting()
	else
		self.showTimer = self.SHOW_TIME
		self.isCounting = true
	end
end

function Outfitter._DropDownList:StopCounting()
	if self.parent then
		self.parent:StopCounting()
	else
		self.isCounting = nil
	end
end

function Outfitter._DropDownList:ClearItems()
	for _, vItem in ipairs(self.Items) do
		vItem:Hide()
	end
	
	self.numItems = 0
	self.maxWidth = 0
end

function Outfitter._DropDownList:AddItem(pInfo)
	local vIndex = self.numItems + 1
	local vWidth

	self:SetMaxItems(vIndex)
	
	self.numItems = vIndex
	
	local vItem = self.Items[vIndex]
	
	vItem:SetItem(pInfo)
	
	self:SetHeight((vIndex * Outfitter._DropDownListItem.BUTTON_HEIGHT) + (Outfitter._DropDownListItem.BORDER_HEIGHT * 2))
	
	vItem:Show()
end

function Outfitter._DropDownList:SetMaxItems(pMaxItems)
	while pMaxItems > #self.Items do
		local vItem = Outfitter:New(Outfitter._DropDownListItem, self)
		table.insert(self.Items, vItem)
		vItem:SetID(#self.Items)
	end
end

function Outfitter._DropDownList:Refresh(pUseValue)
	local vButton, vChecked, vCheckImage, vNormalText, vWidth
	local vMaxWidth = 0
	
	for vIndex, vItem in ipairs(self.Items) do
		local vWidth = vItem:Refresh(pUseValue)
		
		if vWidth > vMaxWidth then
			vMaxWidth = vWidth
		end
	end
	
	for vIndex, vItem in ipairs(self.Items) do
		vItem:SetWidth(vMaxWidth)
	end
	
	self:SetWidth(vMaxWidth + 15)
end

----------------------------------------
Outfitter._DropDownListItem = {}
----------------------------------------

Outfitter._DropDownListItem.BUTTON_HEIGHT = 16
Outfitter._DropDownListItem.BORDER_HEIGHT = 15

function Outfitter._DropDownListItem:New(pList, ...)
	return CreateFrame("Button", nil, pList)
end

function Outfitter._DropDownListItem:Construct(...)
	self:SetWidth(100)
	self:SetHeight(16)
	
	self.Highlight = self:CreateTexture(nil, "BACKGROUND")
	self.Highlight:SetAllPoints()
	self.Highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	self.Highlight:SetBlendMode("ADD")
	self.Highlight:Hide()

	self.Check = self:CreateTexture(nil, "ARTWORK")
	self.Check:SetWidth(18)
	self.Check:SetHeight(18)
	self.Check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
	self.Check:SetPoint("LEFT", self, "LEFT", 0, 0)
	
	self.Icon = self:CreateTexture(nil, "ARTWORK")
	self.Icon:SetWidth(16)
	self.Icon:SetHeight(16)
	self.Icon:SetPoint("RIGHT", self, "RIGHT", 0, 0)
	
	self.ColorSwatch = Outfitter:New(Outfitter._DropDownListItemColorSwatch, self)
	self.ExpandArrow = Outfitter:New(Outfitter._DropDownListItemExpandArrow, self)
	self.InvisibleButton = Outfitter:New(Outfitter._DropDownListItemInvisibleButton, self)
	
	self:SetScript("OnClick", self.OnClick)
	self:SetScript("OnEnter", self.OnEnter)
	self:SetScript("OnLeave", self.OnLeave)
	
	self.NormalText = self:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	self.NormalText:SetPoint("LEFT", self, "LEFT", -5, 0)
	self.NormalText:SetJustifyH("LEFT")
	self:SetFontString(self.NormalText)
	
	self:SetTextFontObject(GameFontHighlightSmall)
	self:SetHighlightFontObject(GameFontHighlightSmall)
	self:SetDisabledFontObject(GameFontDisableSmall)

	local vFontName, vFontHeight, vFontFlags = self.NormalText:GetFont()
	
	self.DEFAULT_TEXT_HEIGHT = vFontHeight
end

function Outfitter._DropDownListItem:OnClick(...)
	local vMenu = self:GetParent()
	local vChecked = self.checked
	
	if type(vChecked) == "function" then
		vChecked = vChecked()
	end

	if self.keepShownOnClick then
		if vChecked then
			self.Check:Hide()
			vChecked = false
		else
			self.Check:Show()
			vChecked = true
		end
	else
		vMenu:Hide()
	end

	if type(self.checked) ~= "function" then 
		self.checked = vChecked
	end

	local vFunc = self.func
	
	if not vFunc then
		return
	end
	
	vFunc(self.arg1, self.arg2, vChecked)
	
	PlaySound("UChatScrollButton")
end

function Outfitter._DropDownListItem:OnEnter(...)
	local vList = self:GetParent()
	
	if self.hasArrow then
		vList:ShowChildList("TOPLEFT", self, "TOPRIGHT", 0, 0, self.menuList)
	else
		vList:CloseChildren()
	end
	
	self.Highlight:Show()
	vList:StopCounting()
	
	if self.tooltipTitle then
		Outfitter.AddNewbieTip(self, self.tooltipTitle, 1.0, 1.0, 1.0, self.tooltipText, 1)
	end
end

function Outfitter._DropDownListItem:OnLeave(...)
	local vList = self:GetParent()
	
	self.Highlight:Hide()
	vList:StartCounting()

	if self.tooltipTitle then
		GameTooltip:Hide()
	end
end

function Outfitter._DropDownListItem:SetItem(pInfo)
	self.info = pInfo
	
	-- Default settings
	
	self:SetDisabledTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
	self.InvisibleButton:Hide()
	self:Enable()
	
	-- Configure button
	
	if pInfo.text then
		self:SetText(pInfo.text)
		
		if pInfo.textHeight then
			self:SetFont(STANDARD_TEXT_FONT, pInfo.textHeight)
		else
			self:SetFont(STANDARD_TEXT_FONT, self.DEFAULT_TEXT_HEIGHT)
		end
		
		-- Determine the width of the button
		
		vWidth = self.NormalText:GetWidth() + 40
		
		-- Add padding if has and expand arrow or color swatch
		
		if pInfo.hasArrow or pInfo.hasColorSwatch then
			vWidth = vWidth + 10
		end
		
		if pInfo.notCheckable then
			vWidth = vWidth - 30
		end
		
		-- Set icon
		
		if pInfo.icon then
			self.Icon:SetTexture(pInfo.icon)
			
			if pInfo.tCoordLeft then
				self.Icon:SetTexCoord(pInfo.tCoordLeft, pInfo.tCoordRight, pInfo.tCoordTop, pInfo.tCoordBottom)
			else
				self.Icon:SetTexCoord(0, 1, 0, 1)
			end
			
			self.Icon:Show()
			
			-- Add padding for the icon
			
			vWidth = vWidth + 10
		else
			self.Icon:Hide()
		end
		
		-- Set maximum button width
		
		if vWidth > self:GetParent().maxWidth then
			self:GetParent().maxWidth = vWidth
		end
		
		-- If a textR is set then set the vertex color of the button text
		
		if pInfo.textR then
			self:SetTextColor(pInfo.textR, pInfo.textG, pInfo.textB)
			self:SetHighlightTextColor(pInfo.textR, pInfo.textG, pInfo.textB)
		else
			self:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
			self:SetHighlightTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		end
	else
		self:SetText("")
		self.Icon:Hide()
	end

	-- Pass through attributes
	
	self.func = pInfo.func
	self.owner = pInfo.owner
	self.hasOpacity = pInfo.hasOpacity
	self.opacity = pInfo.opacity
	self.opacityFunc = pInfo.opacityFunc
	self.cancelFunc = pInfo.cancelFunc
	self.swatchFunc = pInfo.swatchFunc
	self.keepShownOnClick = pInfo.keepShownOnClick
	self.tooltipTitle = pInfo.tooltipTitle
	self.tooltipText = pInfo.tooltipText
	self.arg1 = pInfo.arg1
	self.arg2 = pInfo.arg2
	self.hasArrow = pInfo.hasArrow
	self.hasColorSwatch = pInfo.hasColorSwatch
	self.notCheckable = pInfo.notCheckable
	self.menuList = pInfo.menuList

	if pInfo.value then
		self.value = pInfo.value
	elseif pInfo.text then
		self.value = pInfo.text
	else
		self.value = nil
	end
	
	-- Show the expand arrow if it has one
	
	if pInfo.hasArrow then
		self.ExpandArrow:Show()
	else
		self.ExpandArrow:Hide()
	end
	
	self.hasArrow = pInfo.hasArrow
	
	-- If not checkable move everything over to the left to fill in the gap where the check would be
	
	local vXPos = 5
	local vYPos = -((self:GetID() - 1) * self.BUTTON_HEIGHT) - self.BORDER_HEIGHT
	
	self.NormalText:ClearAllPoints()
	
	if pInfo.notCheckable then
		if pInfo.justifyH and pInfo.justifyH == "CENTER" then
			self.NormalText:SetPoint("CENTER", self, "CENTER", -7, 0)
		else
			self.NormalText:SetPoint("LEFT", self, "LEFT", 0, 0)
		end
		
		vXPos = vXPos + 10
	else
		vXPos = vXPos + 12
		self.NormalText:SetPoint("LEFT", self, "LEFT", 20, 0)
	end

	-- Adjust offset if not checkable
	
	if not pInfo.notCheckable then
		vXPos = vXPos - 6
	end
	
	self:SetPoint("TOPLEFT", self:GetParent(), "TOPLEFT", vXPos, vYPos)
	
	-- Checked can be a function
	
	self.checked = pInfo.checked

	local vChecked = self.checked
	
	if type(vChecked) == "function" then
		vChecked = vChecked()
	end

	-- Show the check if checked
	
	if vChecked then
		self:LockHighlight()
		self.Check:Show()
	else
		self:UnlockHighlight()
		self.Check:Hide()
	end
	
	-- If has a colorswatch, show it and vertex color it
	
	if pInfo.hasColorSwatch then
		self.ColorSwatch:SetNormalTexture(pInfo.r, pInfo.g, pInfo.b)
		self.r = pInfo.r
		self.g = pInfo.g
		self.b = pInfo.b
		self.ColorSwatch:Show()
	else
		self.ColorSwatch:Hide()
	end
	
	-- If not clickable then disable the button and set it white
	
	if pInfo.notClickable then
		pInfo.disabled = 1
		self:SetDisabledTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	end

	-- Set the text color and disable it if it's a title
	
	if pInfo.isTitle then
		pInfo.disabled = 1
		self:SetDisabledTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
	end
	
	-- Disable the button if disabled
	
	if pInfo.disabled then
		self:Disable()
		self.InvisibleButton:Show()
	end
end

function Outfitter._DropDownListItem:Refresh(pUseValue)
	if not self:IsShown() then
		return 0
	end
	
	local vChecked = self.checked
	
	if type(vChecked) == "function" then
		vChecked = vChecked()
	end
	
	if vChecked then
		self:LockHighlight()
		self.Check:Show()
	else
		self:UnlockHighlight()
		self.Check:Hide()
	end
	
	-- Determine the maximum width of a button
	
	local vWidth = self.NormalText:GetWidth() + 40
	
	-- Add padding if has and expand arrow or color swatch
	
	if self.hasArrow or self.hasColorSwatch then
		vWidth = vWidth + 10
	end
	
	if self.notCheckable then
		vWidth = vWidth - 30
	end
	
	return vWidth
end

function Outfitter._DropDownListItem:OpenColorPicker()
	Outfitter.DropDownMenu:CloseMenus()
	
	Outfitter.DropDownMenu.MENU_VALUE = self.value
	
	ColorPickerFrame.func = self.info.swatchFunc
	ColorPickerFrame.hasOpacity = self.info.hasOpacity
	ColorPickerFrame.opacityFunc = self.info.opacityFunc
	ColorPickerFrame.opacity = self.info.opacity
	ColorPickerFrame.previousValues = {r = self.info.r, g = self.info.g, b = self.info.b, opacity = self.info.opacity}
	ColorPickerFrame.cancelFunc = self.info.cancelFunc
	ColorPickerFrame.extraInfo = self.info.extraInfo
	
	-- This must come last, since it triggers a call to ColorPickerFrame.func()
	
	ColorPickerFrame:SetColorRGB(self.info.r, self.info.g, self.info.b)
	ShowUIPanel(ColorPickerFrame)
end

----------------------------------------
Outfitter._DropDownListItemColorSwatch = {}
----------------------------------------

function Outfitter._DropDownListItemColorSwatch:New(pListItem)
	return CreateFrame("Button", nil, pListItem)
end

function Outfitter._DropDownListItemColorSwatch:Construct(pListItem)
	self:Hide()
	self:SetWidth(16)
	self:SetHeight(16)
	self:SetPoint("RIGHT", pListItem, "RIGHT", -6, 0)
	
	self:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")

	self.SwatchBg = self:CreateTexture(nil, "BACKGROUND")
	self.SwatchBg:SetWidth(14)
	self.SwatchBg:SetHeight(14)
	self.SwatchBg:SetPoint("CENTER", self, "CENTER", 0, 0)
	self.SwatchBg:SetTexture(1, 1, 1, 1)
	
	self:SetScript("OnClick", self.OnClick)
	self:SetScript("OnEnter", self.OnEnter)
	self:SetScript("OnLeave", self.OnLeave)
end

function Outfitter._DropDownListItemColorSwatch:OnClick(...)
	self:GetParent():OpenColorPicker()
end

function Outfitter._DropDownListItemColorSwatch:OnEnter()
	local vMenuItem = self:GetParent()
	local vMenu = vMenuItem:GetParent()
	
	Outfitter.DropDownMenu:CloseMenus(vMenu:GetID() + 1)
	
	self.SwatchBg:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
	
	vMenu:StopCounting(vMenu)
end

function Outfitter._DropDownListItemColorSwatch:OnEnter()
	local vMenuItem = self:GetParent()
	local vMenu = vMenuItem:GetParent()
	
	self.SwatchBg:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	
	vMenu:StartCounting(vMenu)
end

----------------------------------------
Outfitter._DropDownListItemExpandArrow = {}
----------------------------------------

function Outfitter._DropDownListItemExpandArrow:New(pListItem)
	return CreateFrame("Button", nil, pListItem)
end

function Outfitter._DropDownListItemExpandArrow:Construct(pListItem)
	self:Hide()
	self:SetWidth(16)
	self:SetHeight(16)
	self:SetPoint("RIGHT", pListItem, "RIGHT", 0, 0)
	
	self:SetNormalTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
	
	self:SetScript("OnClick", self.OnClick)
	self:SetScript("OnEnter", self.OnEnter)
	self:SetScript("OnLeave", self.OnLeave)
end

function Outfitter._DropDownListItemExpandArrow:OnClick()
	local vListItem = self:GetParent()
	local vList = vListItem:GetParent()
	
	vList:ShowChildList("TOPLEFT", self, "TOPRIGHT", 0, 0, vListItem.menuList)
end

function Outfitter._DropDownListItemExpandArrow:OnEnter()
	local vListItem = self:GetParent()
	local vList = vListItem:GetParent()
	
	vList:ShowChildList("TOPLEFT", self, "TOPRIGHT", 0, 0, vListItem.menuList)
	
	vList:StopCounting()
end

function Outfitter._DropDownListItemExpandArrow:OnLeave()
	local vListItem = self:GetParent()
	local vList = vListItem:GetParent()
	
	vList:StartCounting()
end

----------------------------------------
Outfitter._DropDownListItemInvisibleButton = {}
----------------------------------------

function Outfitter._DropDownListItemInvisibleButton:New(pListItem, pColorSwatch)
	return CreateFrame("Button", nil, pListItem)
end

function Outfitter._DropDownListItemInvisibleButton:Construct(pListItem, pColorSwatch)
	self:Hide()
	self:SetPoint("TOPLEFT", pListItem, "TOPLEFT", 0, 0)
	self:SetPoint("BOTTOMLEFT", pListItem, "BOTTOMLEFT", 0, 0)
	self:SetPoint("RIGHT", pColorSwatch, "LEFT", 0, 0)
	
	self:SetScript("OnEnter", self.OnEnter)
	self:SetScript("OnLeave", self.OnLeave)
end

function Outfitter._DropDownListItemInvisibleButton:OnEnter()
	local vMenuItem = self:GetParent()
	local vMenu = vMenuItem:GetParent()
	
	vMenu:StopCounting(vMenu)
	vMenu:CloseChildren()
end

function Outfitter._DropDownListItemInvisibleButton:OnLeave()
	local vMenuItem = self:GetParent()
	local vMenu = vMenuItem:GetParent()
	
	vMenu:StartCounting(vMenu)
end
