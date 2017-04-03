local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local templates = {}
addon.templates = templates


do	-- config frame
	local function createTitle(frame)
		local title = frame:CreateFontString(nil, nil, "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetPoint("RIGHT", -16, 0)
		title:SetJustifyH("LEFT")
		title:SetJustifyV("TOP")
		title:SetText(frame.name)
		frame.title = title
	end

	local function createDesc(frame)
		local desc = frame:CreateFontString(nil, nil, "GameFontHighlightSmall")
		desc:SetHeight(32)
		desc:SetPoint("TOPLEFT", frame.title, "BOTTOMLEFT", 0, -8)
		desc:SetPoint("RIGHT", -32, 0)
		desc:SetJustifyH("LEFT")
		desc:SetJustifyV("TOP")
		desc:SetNonSpaceWrap(true)
		frame.desc = desc
	end
	
	function templates:CreateConfigFrame(name, parent, addTitle, addDesc)
		local frame = CreateFrame("Frame")
		frame.name = name
		frame.parent = parent
		if addTitle then
			createTitle(frame)
			if addDesc then
				createDesc(frame)
			end
		end
		InterfaceOptions_AddCategory(frame)
		return frame
	end
end


do	-- click button
	local textures = {"l", "r", "m"}
	
	local function setTexture(self, texture)
		for _, v in ipairs(textures) do
			self[v]:SetTexture(texture)
		end
	end
	
	local function onMouseDown(self)
		if self:IsEnabled() == 1 then
			setTexture(self, "Interface\\Buttons\\UI-Panel-Button-Down")
		end
	end
	
	local function onMouseUp(self)
		if self:IsEnabled() == 1 then
			setTexture(self, "Interface\\Buttons\\UI-Panel-Button-Up")
		end
	end
	
	local function onDisable(self)
		setTexture(self, "Interface\\Buttons\\UI-Panel-Button-Disabled")
	end
	
	local function onEnable(self)
		setTexture(self, "Interface\\Buttons\\UI-Panel-Button-Up")
	end
	
	function templates:CreateButton(parent)
		local btn = CreateFrame("Button", nil, parent)
		btn:SetNormalFontObject("GameFontNormal")
		btn:SetHighlightFontObject("GameFontHighlight")
		btn:SetDisabledFontObject("GameFontDisable")
		btn:SetScript("OnMouseDown", onMouseDown)
		btn:SetScript("OnMouseUp", onMouseUp)
		btn:SetScript("OnDisable", onDisable)
		btn:SetScript("OnEnable", onEnable)
		
		local highlight = btn:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture")
		btn:SetHighlightTexture(highlight)
		
		local l = btn:CreateTexture(nil, "BACKGROUND")
		l:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
		l:SetTexCoord(0, 0.09375, 0, 0.6875)
		l:SetWidth(12)
		l:SetPoint("TOPLEFT")
		l:SetPoint("BOTTOMLEFT")
		btn.l = l
		
		local r = btn:CreateTexture(nil, "BACKGROUND")
		r:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
		r:SetTexCoord(0.53125, 0.625, 0, 0.6875)
		r:SetWidth(12)
		r:SetPoint("TOPRIGHT")
		r:SetPoint("BOTTOMRIGHT")
		btn.r = r
		
		local m = btn:CreateTexture(nil, "BACKGROUND")
		m:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
		m:SetTexCoord(0.09375, 0.53125, 0, 0.6875)
		m:SetPoint("TOPLEFT", l, "TOPRIGHT")
		m:SetPoint("BOTTOMRIGHT", r, "BOTTOMLEFT")
		btn.m = m
		
		return btn
	end
end


do	-- check button
	local function onClick(self)
		local checked = self:GetChecked()
		
		if checked then
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
		
		self.module[self.db].profile[self.setting] = checked and true or false
		
		if self.func then
			self:func()
		end
		
		addon:Debug(self.setting..(checked and " on" or " off"))
	end
	
	local function loadSetting(self)
		self:SetChecked(self.module[self.db].profile[self.setting])
		if self.func then
			self:func()
		end
	end

	function templates:CreateCheckButton(parent, data)
		local btn = CreateFrame("CheckButton", nil, parent, "OptionsBaseCheckButtonTemplate")
		btn:SetPushedTextOffset(0, 0)
		btn:SetScript("OnClick", onClick)
		
		btn.LoadSetting = loadSetting
		
		local text = btn:CreateFontString(nil, nil, "GameFontHighlight")
		text:SetPoint("LEFT", btn, "RIGHT", 0, 1)
		btn:SetFontString(text)
		
		if data then
			btn:SetText(data.text)
			data.text = nil
			data.db = data.perchar and "percharDB" or "db"
			data.perchar = nil
			for k, v in pairs(data) do
				btn[k] = v
			end
		end

		return btn
	end
end


do	-- slider template
	local backdrop = {
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = {left = 3, right = 3, top = 6, bottom = 6}
	}
	
	local function onEnter(self)
		if self:IsEnabled() then
			if self.tooltipText then
				GameTooltip:SetOwner(self, self.tooltipOwnerPoint or "ANCHOR_RIGHT")
				GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
			end
		end
	end
	
	function templates:CreateSlider(parent, data)
		local slider = CreateFrame("Slider", nil, parent)
		slider:EnableMouse(true)
		slider:SetSize(144, 17)
		slider:SetOrientation("HORIZONTAL")
		slider:SetHitRectInsets(0, 0, -10, -10)
		slider:SetBackdrop(backdrop)
		slider:SetScript("OnEnter", onEnter)
		slider:SetScript("OnLeave", GameTooltip_Hide)
		
		local text = slider:CreateFontString(nil, nil, "GameFontNormal")
		text:SetPoint("BOTTOM", slider, "TOP")
		slider.text = text
		
		local min = slider:CreateFontString(nil, nil, "GameFontHighlightSmall")
		min:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", -4, 3)
		slider.min = min
		
		local max = slider:CreateFontString(nil, nil, "GameFontHighlightSmall")
		max:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 4, 3)
		slider.max = max
		
		if data then
			slider:SetMinMaxValues(data.minValue, data.maxValue)
			slider:SetValueStep(data.valueStep)
			slider:SetScript("OnValueChanged", data.func)
			text:SetText(data.text)
			min:SetText(data.minText or data.minValue)
			max:SetText(data.maxText or data.maxValue)
			slider.tooltipText = data.tooltipText
		end
		
		-- font string for current value
		local value = slider:CreateFontString(nil, "BACKGROUND", "GameFontHighlightSmall")
		value:SetPoint("CENTER", 0, -15)
		slider.value = value
		
		local thumb = slider:CreateTexture()
		thumb:SetTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
		thumb:SetSize(32, 32)
		slider:SetThumbTexture(thumb)
		
		return slider
	end
end


do	-- swatch button template
	local function setColor(self)
		local r, g, b = ColorPickerFrame:GetColorRGB()
		self.swatch:SetVertexColor(r, g, b)
		local color = self.color
		color.r = r
		color.g = g
		color.b = b
	end

	local function cancel(self, prev)
		local r, g, b = prev.r, prev.g, prev.b
		self.swatch:SetVertexColor(r, g, b)
		local color = self.color
		color.r = r
		color.g = g
		color.b = b
	end
	
	local function onClick(self)
		local info = UIDropDownMenu_CreateInfo()
		local color = self.color
		info.r, info.g, info.b = color.r, color.g, color.b
		info.swatchFunc = function() setColor(self) end
		info.cancelFunc = function(c) cancel(self, c) end
		OpenColorPicker(info)
	end
	
	local function onEnter(self)
		self.bg:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		if self.tooltipText then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
		end
	end
	
	local function onLeave(self)
		self.bg:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		GameTooltip:Hide()
	end

	function templates:CreateColorButton(parent)
		local btn = CreateFrame("Button", nil, parent)
		btn:SetSize(16, 16)
		btn:SetPushedTextOffset(0, 0)
		
		btn:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
		btn.swatch = btn:GetNormalTexture()
		
		local bg = btn:CreateTexture(nil, "BACKGROUND")
		bg:SetTexture(1.0, 1.0, 1.0)
		bg:SetSize(14, 14)
		bg:SetPoint("CENTER")
		btn.bg = bg
		
		local text = btn:CreateFontString(nil, nil, "GameFontHighlight")
		text:SetPoint("LEFT", btn, "RIGHT", 5, 1)
		text:SetJustifyH("LEFT")
		btn:SetFontString(text)
		
		btn:SetScript("OnClick", onClick)
		btn:SetScript("OnEnter", onEnter)
		btn:SetScript("OnLeave", onLeave)
		
		return btn
	end
end


do	-- editbox
	function templates:CreateEditBox(parent)
		local editbox = CreateFrame("EditBox", nil, parent)
		editbox:SetHeight(20)
		editbox:SetFontObject("ChatFontNormal")
		editbox:SetTextInsets(5, 0, 0, 0)

		local left = editbox:CreateTexture("BACKGROUND")
		left:SetTexture("Interface\\Common\\Common-Input-Border")
		left:SetTexCoord(0, 0.0625, 0, 0.625)
		left:SetWidth(8)
		left:SetPoint("TOPLEFT")
		left:SetPoint("BOTTOMLEFT")

		local right = editbox:CreateTexture("BACKGROUND")
		right:SetTexture("Interface\\Common\\Common-Input-Border")
		right:SetTexCoord(0.9375, 1, 0, 0.625)
		right:SetWidth(8)
		right:SetPoint("TOPRIGHT")
		right:SetPoint("BOTTOMRIGHT")

		local mid = editbox:CreateTexture("BACKGROUND")
		mid:SetTexture("Interface\\Common\\Common-Input-Border")
		mid:SetTexCoord(0.0625, 0.9375, 0, 0.625)
		mid:SetPoint("TOPLEFT", left, "TOPRIGHT")
		mid:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT")
		
		return editbox
	end
end


do	-- dropdown menu frame
	local function setSelectedValue(self, value)
		UIDropDownMenu_SetSelectedValue(self, value)
		UIDropDownMenu_SetText(self, self.menu[value] or value)
	end
	
	local function getSelectedValue(self)
		return self.selectedValue
	end
	
	local function setDisabled(self, disable)
		if disable then
			self:Disable()
		else
			self:Enable()
		end
	end
	
	local function initialize(self)
		local onClick = self.menu.onClick
		for _, v in ipairs(self.menu) do
			local info = UIDropDownMenu_CreateInfo()
			info.text = v.text
			info.value = v.value
			info.func = onClick or v.func
			info.owner = self
			UIDropDownMenu_AddButton(info)
		end
	end
	
	function templates:CreateDropDownMenu(name, parent, menu, initFunc, valueLookup)
		local frame = CreateFrame("Frame", name, parent, "UIDropDownMenuTemplate")
		
		frame.SetFrameWidth = UIDropDownMenu_SetWidth
		frame.SetSelectedValue = setSelectedValue
		frame.GetSelectedValue = getSelectedValue
		frame.Enable = UIDropDownMenu_EnableDropDown
		frame.Disable = UIDropDownMenu_DisableDropDown
		frame.SetDisabled = setDisabled
		
		if menu then
			for _, v in ipairs(menu) do
				menu[v.value] = v.text
			end
		end
		frame.menu = menu or valueLookup
		
		frame.initialize = initFunc or initialize
		
		local label = frame:CreateFontString(name.."Label", "BACKGROUND", "GameFontNormalSmall")
		label:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 16, 3)
		frame.label = label
		
		return frame
	end
end


do	-- used in Reset and Announce
	local MAXSPELLBUTTONS = 14
	local ITEMHEIGHT = 22
	
	local spells = {}

	local function update(self)
		local selectedTree = self.tree:GetSelectedValue()
		
		wipe(spells)
		
		for i, v in ipairs(addon.percharDB.profile.spells[selectedTree]) do
			if v.normal or v.crit then
				spells[#spells + 1] = {
					spellName = v.spellName,
					isPeriodic = v.isPeriodic,
					normal = v.normal,
					crit = v.crit,
					pos = i,
				}
			end
		end
		
		local size = #spells
		
		FauxScrollFrame_Update(self.scrollFrame, size, MAXSPELLBUTTONS, ITEMHEIGHT)
		
		local offset = FauxScrollFrame_GetOffset(self.scrollFrame)
		
		for line = 1, MAXSPELLBUTTONS do
			local button = self.buttons[line]
			local lineplusoffset = line + offset
			if lineplusoffset <= size then
				local data = spells[lineplusoffset]
				button.spell = data.spellName
				button.isPeriodic = data.isPeriodic
				local normal = data.normal and data.normal.amount
				local crit = data.crit and data.crit.amount
				button:SetText(addon:GetFullSpellName(selectedTree, data.spellName, data.isPeriodic))
				button.record:SetFormattedText("%d/%d", (normal or 0), (crit or 0))
				button:SetChecked(self.selectedSpells[data.pos])
				button:Show()
			else
				button:Hide()
			end
		end
	end

	-- this is used for creating the scroll frames for the Reset and Announce frames
	function templates:CreateList(name, title)
		local frame = templates:CreateConfigFrame(title, addonName)
		
		frame.selectedSpells = {}

		frame.Update = update
		local function update()
			frame:Update()
		end
		
		addon.RegisterCallback(frame, "PerCharSettingsLoaded", "Update")
		addon.RegisterCallback(frame, "RecordsChanged", "Update")
		
		local scrollFrame = CreateFrame("ScrollFrame", name.."ScrollFrame", frame, "FauxScrollFrameTemplate")
		scrollFrame:SetSize(300, (MAXSPELLBUTTONS * ITEMHEIGHT + 4))
		scrollFrame:SetPoint("TOP", 0, -24)
		scrollFrame:SetScript("OnVerticalScroll", function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset, ITEMHEIGHT, update) end)
		frame.scrollFrame = scrollFrame
		
		-- onClick for check buttons
		local function onClick(self)
			local _, pos = addon:GetSpellInfo(frame.tree.selectedValue, self.spell, self.isPeriodic)
			local selectedSpells = frame.selectedSpells
			if self:GetChecked() then
				PlaySound("igMainMenuOptionCheckBoxOn")
				selectedSpells[pos] = true
			else
				PlaySound("igMainMenuOptionCheckBoxOff")
				selectedSpells[pos] = nil
			end
			if next(selectedSpells) then
				frame.button:Enable()
			else
				frame.button:Disable()
			end
		end
		
		-- create list of check buttons
		local buttons = {}
		for i = 1, MAXSPELLBUTTONS do
			local btn = CreateFrame("CheckButton", nil, frame, "OptionsBaseCheckButtonTemplate")
			if i == 1 then
				btn:SetPoint("TOPLEFT", scrollFrame)
			else
				btn:SetPoint("TOP", buttons[i - 1], "BOTTOM", 0, 4)
			end
			btn:SetPushedTextOffset(0, 0)
			btn:SetScript("OnClick", onClick)
			
			-- set default font string for the check button (will contain the spell name)
			local text = btn:CreateFontString(nil, nil, "GameFontHighlight")
			text:SetPoint("LEFT", btn, "RIGHT", 0, 1)
			text:SetJustifyH("LEFT")
			btn:SetFontString(text)
			
			-- font string for record amounts
			local record = btn:CreateFontString(nil, nil, "GameFontHighlight")
			record:SetPoint("CENTER", text)
			record:SetPoint("RIGHT", scrollFrame)
			record:SetJustifyH("RIGHT")
			btn.record = record
			
			buttons[i] = btn
		end
		frame.buttons = buttons
		
		do
			local menu = {
				onClick = function(self)
					self.owner:SetSelectedValue(self.value)
					wipe(frame.selectedSpells)
					StaticPopup_Hide("CRITLINE_RESET_ALL")
					FauxScrollFrame_SetOffset(scrollFrame, 0)
					_G[scrollFrame:GetName().."ScrollBar"]:SetValue(0)
					frame:Update()
					frame.button:Disable()
				end,
				{text = L["Damage"],	value = "dmg"},
				{text = L["Healing"],	value = "heal"},
				{text = L["Pet"],		value = "pet"},
			}
			
			local tree = templates:CreateDropDownMenu(name.."Tree", frame, menu)
			tree:SetPoint("TOPLEFT", scrollFrame, "BOTTOMLEFT", -16, -4)
			tree:SetFrameWidth(120)
			tree:SetSelectedValue("dmg")
			
			frame.tree = tree
		end
		
		-- reset/announce button
		local btn = templates:CreateButton(frame)
		btn:SetPoint("TOPRIGHT", scrollFrame, "BOTTOMRIGHT", 0, -7)
		btn:SetSize(100, 22)
		btn:Disable()
		btn:SetText(title)
		frame.button = btn
		
		return frame
	end
end