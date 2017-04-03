-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

XPerl_SetModuleRevision("$Revision: 386 $")

function XPerl_OptionsFrame_DisableSlider(slider)
	local name = slider:GetName();
	getmetatable(slider).__index.Disable(slider);
	_G[name.."Text"]:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	_G[name.."Low"]:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	_G[name.."High"]:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function XPerl_OptionsFrame_EnableSlider(slider)
	local name = slider:GetName();
	getmetatable(slider).__index.Enable(slider);
	_G[name.."Text"]:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
	_G[name.."Low"]:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	_G[name.."High"]:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
end


function XPerl_Options_SetupFunc(self)
	XPerl_DoGradient(self, true)
	self:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
	self:SetBackdropColor(0, 0, 0, 1)
end

-- XPerl_OptionsFrame_SelectFrame
function XPerl_OptionsFrame_SelectFrame(frame)
	XPerl_Options:Show()

	if (frame == "player") then
		XPerl_Options_Player:Show()
		XPerl_Options_Party:Hide()
		XPerl_Options_Raid:Hide()

	elseif (frame == "party") then
		XPerl_Options_Player:Hide()
		XPerl_Options_Party:Show()
		XPerl_Options_Raid:Hide()

	elseif (frame == "raid") then
		XPerl_Options_Player:Hide()
		XPerl_Options_Party:Hide()
		XPerl_Options_Raid:Show()
	end
end

-- XPerl_OptionsSetMyText
function XPerl_OptionsSetMyText(f, str, keep)

	if (f and str) then
		local textFrame = _G[f:GetName().."Text"]

		if (not keep and not strfind(str, "^XPERL")) then
			ChatFrame1:AddMessage("WARNING: Not keeping '"..str.."'")
		end

		if (textFrame) then
			textFrame:SetText(_G[str])
			f.tooltipText = _G[str.."_DESC"]

			if ((f.GetFrameType or f.GetObjectType)(f) == "CheckButton") then
				f:SetHitRectInsets(0, -(textFrame:GetStringWidth()), 0, 0)
			end

		elseif ((f.GetFrameType or f.GetObjectType)(f) == "Button") then
			f:SetText(_G[str])
			f.tooltipText = _G[str.."_DESC"]
		end

		if (not keep) then
			setglobal(str, nil)
			setglobal(str.."_DESC", nil)
		end
	end
end

-- XPerl_Options_CheckButton_OnEnter
function XPerl_Options_CheckButton_OnEnter(self)
	if (self.flashFrame and not InCombatLockdown()) then
		local array
		if (table.getn(self.flashFrame) == 0) then
			array = {self.flashFrame}
		else
			array = self.flashFrame
		end

		for i,f in pairs(array) do
			if (f and f.GetName) then
				if (f:IsShown()) then
					XPerl_FrameFlash(f)
				end
			end
		end
	end
	if ( self.tooltipText ) then
		local p = _G[self:GetName().."Text"]
		local title = p and p:GetText()
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if (title) then
			GameTooltip:SetText(title, 1, 1, 1)
			GameTooltip:AddLine(self.tooltipText, nil, nil, nil, 1)
		else
			GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
		end
		GameTooltip:Show()
	end

	_G[self:GetName().."Text"]:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
end

-- XPerl_GetCheck
function XPerl_GetCheck(f)
	if (f:GetChecked()) then
	        return 1
	else
	        return 0
	end
end

-- XPerl_Options_GetSibling(sibling,self)
function XPerl_Options_GetSibling(sibling,self)
	return _G[self:GetParent():GetName().."_"..sibling]
end

-- XPerl_Options_EnableSibling
function XPerl_Options_EnableSibling(self,sibling, check2nd, check3rd)

	local siblingName = self:GetParent():GetName().."_"..sibling
	local siblingFrame = _G[siblingName]
	local second = true
	local condition = "and"

	if (type(check2nd) == "string" and (check2nd == "or" or check2nd == "and")) then
		condition = check2nd
		check2nd = check3rd
	end
	if (check2nd) then
		if (type(check2nd) == "table") then
			second = check2nd:GetChecked()
		elseif (type(check2nd) == "string") then
			local sib2 = self:GetParent():GetName().."_"..check2nd
			local sibf2 = _G[sib2]
			if (sibf2) then
				second = sibf2:GetChecked()
			else
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000X-Perl|r - No 2nd sibling called '"..sib2.."'")
			end
		else
			second = check2nd
		end
	end

	local result
	if (condition == "and") then
		result = (self:GetChecked() and second)
	elseif (condition == "or") then
		result = (self:GetChecked() or second)
	end

	if (siblingFrame) then
		if ((siblingFrame.GetFrameType or siblingFrame.GetObjectType)(siblingFrame) == "Button") then
			if (result) then
				siblingFrame:Enable()
			else
				siblingFrame:Disable()
			end
		elseif ((siblingFrame.GetFrameType or siblingFrame.GetObjectType)(siblingFrame) == "CheckButton") then
			XPerl_Options_EnableCheck(siblingFrame, result)

		elseif ((siblingFrame.GetFrameType or siblingFrame.GetObjectType)(siblingFrame) == "Slider") then
			if (result) then
				siblingFrame:EnableSlider()
			else
				siblingFrame:DisableSlider()
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000X-Perl|r - No code to disable '"..siblingFrame:GetName().."' type: "..(siblingFrame.GetFrameType or siblingFrame.GetObjectType)(siblingFrame))
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000X-Perl|r - No sibling found called '"..siblingName.."'")
	end
end

-- XPerl_Options_EnableCheck
function XPerl_Options_EnableCheck(self, on)
	local textFrame = _G[self:GetName().."Text"]
	if (on) then
		self:Enable()
		textFrame:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
	else
		self:Disable()
		textFrame:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
	end

	if ((self.GetFrameType or self.GetObjectType)(self) == "Button") then
		local normalTexture = _G[self:GetName().."NormalTexture"]
		local icon = _G[self:GetName().."Icon"]
		if (normalTexture and icon) then
			if (on) then
				icon:SetVertexColor(1, 1, 1)
				normalTexture:SetVertexColor(1, 1, 1)
			else
				icon:SetVertexColor(0.5, 0.5, 0.5)
				normalTexture:SetVertexColor(0.5, 0.5, 0.5)
			end
		end
	end
end

-- XPerl_Options_IncrementSibling
function XPerl_Options_IncrementSibling(self,sibling)
	local siblingName = self:GetParent():GetName().."_"..sibling
	local siblingFrame = _G[siblingName]

	if (siblingFrame and (siblingFrame.GetFrameType or siblingFrame.GetObjectType)(siblingFrame) == "EditBox") then
        	local n = tonumber(siblingFrame:GetText())
		n = n + 1
		siblingFrame:SetText(n)
		return n
	end
end

-- XPerl_Options_DecrementSibling
function XPerl_Options_DecrementSibling(self,sibling)
	local siblingName = self:GetParent():GetName().."_"..sibling
	local siblingFrame = _G[siblingName]

	if (siblingFrame and (siblingFrame.GetFrameType or siblingFrame.GetObjectType)(siblingFrame) == "EditBox") then
        	local n = tonumber(siblingFrame:GetText())
		n = n - 1
		siblingFrame:SetText(n)
		return n
	end
end

-- XPerl_Options_CheckRadio
function XPerl_Options_CheckRadio(self,buttons)
	local prefix = self:GetParent():GetName().."_"
	
	for i,name in pairs(buttons) do
		if (prefix..name == self:GetName()) then
			_G[prefix..name]:SetChecked(true)
		else
			_G[prefix..name]:SetChecked(false)
		end
	end
end

-- XPerl_Options_GetSiblingChecked
function XPerl_Options_GetSiblingChecked(name,self)
	local prefix = self:GetParent():GetName().."_"
	return _G[prefix..name]:GetChecked()
end

-- XPerl_Raid_OptionActions
function XPerl_Raid_OptionActions()
	if (XPerl_Raid_Position) then
        	XPerl_Raid_Position()
		XPerl_Raid_Set_Bits(XPerl_Raid_Frame)
		XPerl_Raid_UpdateDisplayAll()
		if (XPerl_RaidPets_OptionActions) then
			XPerl_RaidPets_OptionActions()
		end
	end
end

-- XPerl_Options_OnUpdate
function XPerl_Options_OnUpdate(self,arg1)
	
	if (self.Fading) then
	        local alpha = self:GetAlpha()
	        if (self.Fading == "in") then
	                alpha = alpha + (arg1 * 2)		-- elapsed * 2 == fade in/out in 1/2 second
	                if (alpha > 1) then
	                        alpha = 1
	                end
	        elseif (self.Fading == "out") then
	                alpha = alpha - (arg1 * 2)
	                if (alpha < 0) then
	                        alpha = 0
	                end
	        end
	        self:SetAlpha(alpha)
	        if (alpha == 0) then
	                self.Fading = nil
	                self:Hide()
	        elseif (alpha == 1) then
	                self.Fading = nil
	        end
	else
		local f = GetMouseFocus()
		if (f) then
			local n = f:GetName()
			if (n) then
				if (strfind(n, "XPerl_Player") or strfind(n, "XPerl_Target") or strfind(n, "XPerl_Focus")) then
					XPerl_OptionsFrame_SelectFrame("player")
				elseif (strfind(strlower(n), "xperl_party")) then
					XPerl_OptionsFrame_SelectFrame("party")
				elseif (strfind(n, "XPerl_Raid")) then
					XPerl_OptionsFrame_SelectFrame("raid")
				end
			end
		end
	end
end

-- XPerl_Options_MaxScaleSet
local Sliders = {}
function XPerl_Options_MaxScaleSet()

	for i,slider in pairs(Sliders) do
        	local old = slider:GetValue()
		local min = slider.min or 50
		local max = slider.max or floor(XPerlDB.maximumScale * 100 + 0.5)

        	slider:SetMinMaxValues(min, max)

        	_G[slider:GetName().."Low"]:SetFormattedText("%d"..PERCENT_SYMBOL, min)
        	_G[slider:GetName().."High"]:SetFormattedText("%d"..PERCENT_SYMBOL, max)

		if (old > max) then
			slider:SetValue(max)
		elseif (old < min) then
			slider:SetValue(min)
		end
	end
end

-- XPerl_SliderSetup(self)
function XPerl_SliderSetup(self, percent)
	self.xperlSliderEnabled = true
	self.IsEnabled = function(self)
	        return self.xperlSliderEnabled
	end
	self.DisableSlider = function(self)
	        self.xperlSliderEnabled = false
	        XPerl_OptionsFrame_DisableSlider(self)
	        _G[self:GetName().."Current"]:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
		self:EnableMouse(false)
		self:EnableMouseWheel(false)
	end
	self.EnableSlider = function(self)
	        self.xperlSliderEnabled = true
	        XPerl_OptionsFrame_EnableSlider(self)
	        _G[self:GetName().."Current"]:SetVertexColor(0.4, 0.4, 0.80)
		self:EnableMouse(true)
		self:EnableMouseWheel(true)
	end

	local low = _G[self:GetName().."Low"]
	if (not tonumber(low:GetText())) then
		local min, max = self:GetMinMaxValues()
		if (min and max) then
			if (percent) then
				min = format("%d"..PERCENT_SYMBOL, min)
				max = format("%d"..PERCENT_SYMBOL, max)
			end
			low:SetText(min)
			_G[self:GetName().."High"]:SetText(max)
		end
	end

	self:SetScript("OnLoad", nil)
end

function XPerl_EditBoxSetup(self)
	self.xperlEditEnabled = true
	self.IsEnabled = function(self)
		return self.xperlEditEnabled
	end
	self.Enable = function(self)
		self.xperlEditEnabled = true
		self:EnableMouse(true)
	end
	self.Disable = function(self)
		self.xperlEditEnabled = false
		self:EnableMouse(false)
	end

	self:SetScript("OnLoad", nil)
end

-- GetTable(self)
local function GetTable(self)
	if (self.configIndex == nil) then
		error("No index for configBase in "..self:GetName())
	end

	local table = RunScript("XPerlTemp = "..self.configBase)
	local val = XPerlTemp
	XPerlTemp = nil

	if (type(val) == "table") then
		return val
	end
	--error(self:GetName().." needs to return a table from self.configBase")
end

-- XPerl_Options_GetIndex(self)
function XPerl_Options_GetIndex(self)
	if (type(self.configBase) == "string") then
		local val = GetTable(self)
		if (val) then
			return val[self.configIndex]
		end

	elseif (type(self.configBase) == "table") then
		if (self.configIndex == nil) then
			error("No index for configBase in "..self:GetName())
		end

		return self.configBase[self.configIndex]
	end
end

-- XPerl_Options_SetIndex
function XPerl_Options_SetIndex(self, new)
	if (type(self.configBase) == "string") then
		local val = GetTable(self)
		val[self.configIndex] = new

	elseif (type(self.configBase) == "table") then
		if (self.configIndex == nil) then
			error("No index for configBase in "..self:GetName())
		end
		self.configBase[self.configIndex] = new
	end
end

-- scalingOnShow
local function scalingOnShow(self)
	local i = XPerl_Options_GetIndex(self)
	if (i) then
		self:SetValue(floor(100 * i + 0.5))
	end
end

-- scalingOnValueChanged
local function scalingOnValueChanged(self, value)
	local i = XPerl_Options_GetIndex(self)

	if (i) then
		if (floor(100 * i + 0.5) ~= value) then
			XPerl_Options_SetIndex(self, value / 100)
			if (self.configClick) then
				self.configClick()
			end
		end
		_G[self:GetName().."Current"]:SetText(floor(value + 0.5).."%")
	end
end

-- XPerl_Options_RegisterScalingSlider
function XPerl_Options_RegisterScalingSlider(self, min, max)

	XPerl_Options_RegisterProtected(self)

	Sliders[self:GetName()] = self

	if (min) then
		self.min = min
	else
		min = 50
	end
	if (max) then
		self.max = max
	else
		max = floor(((XPerlDB and XPerlDB.maximumScale) or 1.5) * 100 + 0.5)
	end

        _G[self:GetName().."Low"]:SetFormattedText("%d"..PERCENT_SYMBOL, min)
        _G[self:GetName().."High"]:SetFormattedText("%d"..PERCENT_SYMBOL, max)

        self:SetMinMaxValues(min, max)
        self:SetValueStep(1)

	if (self.configBase) then
		self:SetScript("OnShow", scalingOnShow)
		self:SetScript("OnValueChanged", scalingOnValueChanged)
	end
end

-- XPerl_Popup
function XPerl_Popup(question, onAccept)
	XPerl_OptionsQuestionDialogText:SetText(question)
	XPerl_OptionsQuestionDialog.onAccept = onAccept
	XPerl_OptionsQuestionDialog:SetScale(1.5)
	XPerl_OptionsQuestionDialog:Show()

	XPerl_OptionsQuestionDialog:SetPoint("CENTER", 0, 0)

	local w = XPerl_OptionsQuestionDialogText:GetStringWidth() + 20

	if (w > 320) then
		XPerl_OptionsQuestionDialog:SetWidth(320)
		XPerl_OptionsQuestionDialog:SetHeight(100)
	else
		XPerl_OptionsQuestionDialog:SetWidth(w)
		XPerl_OptionsQuestionDialog:SetHeight(80)
	end

	if (XPerl_Options:IsShown()) then
		XPerl_OptionsQuestionDialog.hideMask = true
		XPerl_Options_Mask:Show()
	else
		XPerl_OptionsQuestionDialog.hideMask = nil
	end
end

-- Load settings menu
local MyIndex = 0
local function GetPlayerList()
	local ret = {}
	if (XPerlConfigNew) then
		local me = GetRealmName().." / "..UnitName("player")
		for realmName, realmConfig in pairs(XPerlConfigNew) do
			if (type(realmConfig) == "table" and realmName ~= "global" and realmName ~= "savedPositions") then
				for playerName, settings in pairs(realmConfig) do
					local entry = realmName.." / "..playerName

					tinsert(ret, {name = entry, config = settings})

					if (entry == me) then
						MyIndex = #ret
					end
				end
			end
		end
	end
	return ret
end

-- XPerl_Options_LoadSettings_OnLoad
function XPerl_Options_LoadSettings_OnLoad(self)
	self.displayMode = "MENU"
	UIDropDownMenu_Initialize(self, XPerl_Options_LoadSettings_Initialize)
	UIDropDownMenu_SetWidth(self, 140)
	if (MyIndex == 0) then
		XPerl_Options_DropDown_LoadSettingsText:SetText("")
	else
		UIDropDownMenu_SetSelectedID(self, MyIndex, 1)
	end
end

-- XPerl_Options_LoadSettings_Initialize
function XPerl_Options_LoadSettings_Initialize()
	local list = GetPlayerList()

	for i,entry in pairs(list) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = entry.name
		info.func = XPerl_Options_LoadSettings_OnClick
		UIDropDownMenu_AddButton(info)
	end
end

-- XPerl_Options_Anchor_OnLoad
function XPerl_Options_Anchor_OnLoad(self)
	self.displayMode = "MENU"
	UIDropDownMenu_Initialize(self, XPerl_Options_Anchor_Initialize)
	UIDropDownMenu_SetSelectedID(self, MyIndex, 1)
	UIDropDownMenu_SetWidth(self, 100)
end

-- XPerl_Options_Anchor_OnLoad
function XPerl_Options_Anchor_Initialize()
	local info
	local current = XPerl_Options_Party_Anchor.varGet() or "TOP"

	for k,v in pairs(XPerl_AnchorList) do
		info = {}
		info.text = v
		info.func = XPerl_Options_Anchor_OnClick

		if (current == v) then
			MyIndex = k
		end

		UIDropDownMenu_AddButton(info)
	end
end

-- XPerl_Options_Anchor_OnClick
function XPerl_Options_Anchor_OnClick(self)
	local obj = UIDROPDOWNMENU_OPEN_MENU

	obj.varSet(XPerl_AnchorList[self:GetID()])
	MyIndex = self:GetID()
	UIDropDownMenu_SetSelectedID(obj, MyIndex, 1)

	XPerl_ProtectedCall(obj.setFunc)

	if (XPerl_Party_Virtual) then
		XPerl_Party_Virtual(true)
	end

	if (XPerl_RaidTitles) then
		XPerl_RaidTitles()
	end
end

-- CopySelectedSettings
local CopyFrom
local function CopySelectedSettings()
	--ChatFrame7:AddMessage("Copying settings from "..CopyFrom)
	--UIDropDownMenu_SetSelectedID(XPerl_Options_DropDown_LoadSettings, self:GetID(), 1)

	XPerlDB = XPerl_CopyTable(CopyFrom.config)

	if (XPerlConfigSavePerCharacter) then
		if (not XPerlConfigNew[GetRealmName()]) then
			XPerlConfigNew[GetRealmName()] = {}
		end

		XPerlConfigNew[GetRealmName()][UnitName("player")] = XPerlDB
	else
		XPerlConfigNew[GetRealmName()].global = XPerlDB
	end

	XPerl_GiveConfig()

	XPerl_StartupSpellRange()			-- Re-validate the spell range stuff

	XPerl_Options:Hide()
	XPerl_Options:Show()

	XPerl_OptionActions()
end

-- XPerl_Options_LoadSettings_OnClick
function XPerl_Options_LoadSettings_OnClick(self)

	local list = GetPlayerList()

	if (self:GetID() ~= MyIndex) then
		local entry = list[self:GetID()]

		if (entry) then
			CopyFrom = entry
			XPerl_Popup(format("Copy settings from %s?", entry.name), CopySelectedSettings)
		end
	end
end

-- XPerl_Options_TextureSelect_Onload
function XPerl_Options_TextureSelect_Onload(self)

	self.Setup = XPerl_Options_SetupFunc
	self.scrollBar = _G[self:GetName().."scrollBar"]
	self.list = XPerl_AllBarTextures()
	self.Selection = 1
	if (self.list) then
		self.scrollBar.bar:SetValue(max(0, min(self.Selection - 5, #self.list - 8)))
	else
		self.scrollBar.bar:SetValue(1)
	end

	self.UpdateFunction = function(self)
		self:GetParent():SetBarColours()
	end

	self.SetBarColours = function(self)
		local offset = self.scrollBar.bar:GetValue()
		for i = 0,9 do
			local r, g, b
			if (self.Selection - offset - 1 == i) then
				r, g, b = 0, 1, 0
			else
				r, g, b = 0.5, 0.5, 0.5
			end
			local f = _G[self:GetName()..i]
			if (f) then
				if (i + offset + 1 > #self.list) then
					f:Hide()
				else
					f:Show()
					f.name:SetText(self.list[i + offset + 1][1])
					f.tex:SetTexture(self.list[i + offset + 1][2])
					f.tex:SetVertexColor(r, g, b, 1)
				end
			end
		end

		if (FauxScrollFrame_Update(self.scrollBar, #self.list, 10, 1)) then
			self.scrollBar:Show()
		else
			self.scrollBar:Hide()
		end
	end

	XPerl_Options_TextureSelect_Onload = nil
end

-- XPerl_Options_SetTabColor
function XPerl_Options_SetTabColor(self, color)
	for i,y in pairs({"Enabled", "Disabled"}) do
		for j,z in pairs({"Left", "Right", "Middle"}) do
			local f = _G[self:GetName()..y..z]
			--if (XPerlDB and XPerlDB.colour.gradient.enable) then
				local c = XPerlDB.colour.gradient.s
				f:SetVertexColor(c.r, c.g, c.b, c.a)
			--else
			--	f:SetVertexColor(0.8, 0.8, 0.8, 1)
			--end
		end
	end
end

-- XPerl_Options_EnableTab
function XPerl_Options_EnableTab(self, enable)
	for i,y in pairs({"Enabled", "Disabled"}) do
		for j,z in pairs({"Left", "Right", "Middle"}) do
			local f = _G[self:GetName()..y..z]

			if ((i == 1 and enable) or (i == 2 and not enable)) then
				f:Show()
			else
				f:Hide()
			end
		end
	end
end

local protected = {}

-- XPerl_Options_InCombatChange
function XPerl_Options_InCombatChange(inCombat)

	for k,v in pairs(protected) do
		if ((k.GetFrameType or k.GetObjectType)(k) == "CheckButton") then
			local textFrame = _G[k:GetName().."Text"]

			if (inCombat) then
				k.wasChecked = k:GetChecked()
				k.combatIcon:Show()
				protected[k] = k:IsEnabled()
				k:SetChecked(false)
				k:Disable()
				k:EnableMouse(false)
				textFrame:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
			else
				k:EnableMouse(true)
				k.combatIcon:Hide()

				if (v) then
					k:Enable()
					textFrame:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				else
					k:Disable()
					textFrame:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
				end

				if (k.wasChecked) then
					k:SetChecked(true)
				end
			end

		elseif ((k.GetFrameType or k.GetObjectType)(k) == "Slider") then
			if (inCombat) then
				k.combatIcon:Show()
				k:DisableSlider()
			else
				k.combatIcon:Hide()

				if (v) then
					k:EnableSlider()
				else
					k:DisableSlider()
				end
			end

		elseif ((k.GetFrameType or k.GetObjectType)(k) == "Button") then
			if (inCombat) then
				k.combatIcon:Show()
				k:Disable()
			else
				k.combatIcon:Hide()

				if (v) then
					k:Enable()
				else
					k:Disable()
				end
			end

		elseif ((k.GetFrameType or k.GetObjectType)(k) == "EditBox") then
			if (inCombat) then
				k.combatIcon:Show()
				k:Disable()
			else
				k.combatIcon:Hide()

				if (v) then
					k:Enable()
				else
					k:Disable()
				end
			end

		end
	end
end

-- XPerl_Options_RegisterProtected
function XPerl_Options_RegisterProtected(self)

	if ((self.GetFrameType or self.GetObjectType)(self) == "Slider") then
		XPerl_SliderSetup(self)
	elseif ((self.GetFrameType or self.GetObjectType)(self) == "EditBox") then
		XPerl_EditBoxSetup(self)
	end

	protected[self] = self:IsEnabled()

	local icon = self:CreateTexture(self:GetName().."CombatIcon", "OVERLAY")
	self.combatIcon = icon

	icon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
	icon:SetTexCoord(0.5, 1.0, 0.0, 0.5)

	icon:SetWidth(32)
	icon:SetHeight(32)
	icon:SetPoint("CENTER", 0, 0)
	icon:Show()

	self:SetScript("OnLoad", nil)
end

-- GetSpell
local function GetSpell()
	return XPerlDB and XPerlDB.rangeFinder[XPerl_Options.optRange].spell
end

-- GetItem
local function GetItem()
	return XPerlDB and XPerlDB.rangeFinder[XPerl_Options.optRange].item
end

-- XPerl_Options_GetRangeTexture
function XPerl_Options_GetRangeTexture(self)
	local spell = GetSpell()
	if (spell) then
		local tex = GetSpellTexture(spell)
		return tex, spell
	end

	local item = GetItem()
	if (item) then
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, invTexture = GetItemInfo(item)
		if (itemName) then
			return invTexture, itemName
		end
	end

	return ""
end

-- XPerl_Options_DoRangeTooltip
function XPerl_Options_DoRangeTooltip(self)

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -15, 0)

	local spell = GetSpell()
	if (spell) then
		local link = GetSpellLink(spell)
		if (link) then
			GameTooltip:SetHyperlink(link)
		else
			GameTooltip:SetText(spell or UNKNOWN, 1, 1, 1)
		end

		GameTooltip:AddLine(" ")
		if (XPerlDB.rangeFinder[XPerl_Options.optRange].spell) then
			GameTooltip:AddLine(XPERL_CONF_CUSTOMSPELL_DESC, 0.5, 1, 0.5)
		else
			GameTooltip:AddLine(XPERL_CONF_CUSTOMSPELL_DESC2, 0.5, 1, 0.5)
		end
		GameTooltip:Show()
		return
	end

	local item = GetItem()
	if (item) then
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, invTexture = GetItemInfo(item)
		if (itemName) then
			local itemId = strmatch(itemLink, "item:(%d+):");
   			if (itemId) then
				local newLink = format("item:%d:0:0:0", itemId)
				GameTooltip:SetHyperlink(newLink)

				GameTooltip:AddLine(" ")
				if (XPerlDB.rangeFinder[XPerl_Options.optRange].CustomRangeItem) then
					GameTooltip:AddLine(XPERL_CONF_CUSTOMSPELL_DESC, 0.5, 1, 0.5)
				else
					GameTooltip:AddLine(XPERL_CONF_CUSTOMSPELL_DESC2, 0.5, 1, 0.5)
				end
				GameTooltip:Show()
			end
		end
	end
end

-- DefaultRaidClasses
local function DefaultRaidClasses()
	return {
		{enable = true, name = "WARRIOR"},
		{enable = true, name = "DEATHKNIGHT"},
		{enable = true, name = "ROGUE"},
		{enable = true, name = "HUNTER"},
		{enable = true, name = "MAGE"},
		{enable = true, name = "WARLOCK"},
		{enable = true, name = "PRIEST"},
		{enable = true, name = "DRUID"},
		{enable = true, name = "SHAMAN"},
		{enable = true, name = "PALADIN"},
	}
end

-- ValidateClassNames
local function ValidateClassNames(part)
	-- This should never happen, but I'm sure someone will find a way to break it

	local list = {WARRIOR = false, MAGE = false, ROGUE = false, DRUID = false,
			HUNTER = false, SHAMAN = false, PRIEST = false,	WARLOCK = false, PALADIN = false, DEATHKNIGHT = false}

	local valid
	if (part.class) then
		local classCount = 0
		for i,info in pairs(part.class) do
			if (type(info) == "table" and info.name) then
				classCount = classCount + 1
			end
		end
		if (classCount == 10) then
			valid = true
		end

		if (valid) then
			for i = 1,10 do
				if (part.class[i]) then
					list[part.class[i].name] = true
				end
			end
		end
	end

	if (valid) then
		for k,v in pairs(list) do
			if (not v) then
				valid = nil
			end
		end
	end

	if (not valid) then
		part.class = DefaultRaidClasses(true)
	end
end

-- SetClassNames
local function SetClassNames(self)
	ValidateClassNames(XPerlDB.raid)

	local prefix = self:GetParent():GetParent():GetName().."_"
	for i = 1,10 do
		local f = _G[prefix.."ClassSel"..i.."_EnableText"]
		if (f) then
			local class = XPerlDB.raid.class[i].name
			f:SetText(LOCALIZED_CLASS_NAMES_MALE[class])
		end
	end
end


-- XPerl_Options_MoveRaidClassUp
function XPerl_Options_MoveRaidClassUp(self)
	local i = self:GetID()

	ValidateClassNames(XPerlDB.raid)

	local save = XPerlDB.raid.class[i].name
	XPerlDB.raid.class[i].name = XPerlDB.raid.class[i - 1].name
	XPerlDB.raid.class[i - 1].name = save

	SetClassNames(self)
end

-- XPerl_Options_MoveRaidClassDown
function XPerl_Options_MoveRaidClassDown(self)
	local i = self:GetID()

	ValidateClassNames(XPerlDB.raid)

	local save = XPerlDB.raid.class[i]
	XPerlDB.raid.class[i] = XPerlDB.raid.class[i + 1]
	XPerlDB.raid.class[i + 1] = save

	SetClassNames(self)
end

-- XPerl_Options_RaidSelectAll
function XPerl_Options_RaidSelectAll(self, enable)

	local val
	local prefix = self:GetParent():GetName().."_"

	for i = 1,10 do
		local f = _G[prefix.."Grp"..i]
		if (f) then
			f:SetChecked(enable)
			XPerlDB.raid.group[i] = enable
		end

		f = _G[prefix.."ClassSel"..i.."_Enable"]
		if (f) then
			f:SetChecked(enable)
			XPerlDB.raid.class[i].enable = enable
		end
	end

	XPerl_Raid_ChangeAttributes()
	XPerl_Raid_OptionActions()
end

-- XPerl_Options_SetupStatsFrames
function XPerl_Options_SetupStatsFrames()

	if (XPerl_Player) then
		XPerl_StatsFrameSetup(XPerl_Player, {XPerl_Player.statsFrame.druidBar, XPerl_Player.statsFrame.xpBar, XPerl_Player.statsFrame.repBar})
	end
	if (XPerl_Player_Pet) then
		XPerl_StatsFrameSetup(XPerl_Player_Pet, {XPerl_Player_Pet.statsFrame.xpBar}, 2)
	end
	XPerl_StatsFrameSetup(XPerl_Target)
	XPerl_StatsFrameSetup(XPerl_Focus)
	XPerl_StatsFrameSetup(XPerl_TargetTarget)
	XPerl_StatsFrameSetup(XPerl_TargetTargetTarget)
	XPerl_StatsFrameSetup(XPerl_FocusTarget)
	XPerl_StatsFrameSetup(XPerl_PetTarget)

	for i = 1,4 do
		XPerl_StatsFrameSetup(_G["XPerl_party"..i])
		XPerl_StatsFrameSetup(_G["XPerl_partypet"..i], nil, 2)
	end
end




-- XPerl_Player_Reset()
function XPerl_Player_Reset()
	if (XPerl_Player) then
		XPerl_Player_Set_Bits(XPerl_Player)
		XPerl_Player_UpdateDisplay(XPerl_Player)
		if (XPerl_Player_BuffSetup) then
			XPerl_Player.buffOptMix = nil
			XPerl_Player_BuffSetup(XPerl_Player)
		end
	end
end

-- XPerl_Player_Pet_Reset
function XPerl_Player_Pet_Reset()
	if (XPerl_Player_Pet) then
		XPerl_Player_Pet_Set_Bits(XPerl_Player_Pet)
		XPerl_Player_Pet_UpdateDisplay(XPerl_Player_Pet)
	end
end

-- XPerl_Target_Reset()
function XPerl_Target_Reset()
	if (XPerl_Target) then
		XPerl_Target_Set_Bits(XPerl_Target)
		XPerl_Target_UpdateDisplay(XPerl_Target)
	end

	if (XPerl_Focus) then
		XPerl_Target_Set_Bits(XPerl_Focus)
		XPerl_Target_UpdateDisplay(XPerl_Focus)
	end
end

-- XPerl_TargetTarget_Reset()
function XPerl_TargetTarget_Reset()
	if (XPerl_TargetTarget_Set_Bits) then
		XPerl_TargetTarget_Set_Bits()

		XPerl_TargetTarget_UpdateDisplay(XPerl_TargetTarget)
		if (XPerl_TargetTargetTarget) then
			XPerl_TargetTarget_UpdateDisplay(XPerl_TargetTargetTarget)
		end
		if (XPerl_FocusTarget) then
			XPerl_TargetTarget_UpdateDisplay(XPerl_FocusTarget)
		end
		if (XPerl_PetTarget) then
			XPerl_TargetTarget_UpdateDisplay(XPerl_PetTarget)
		end
	end
end

-- XPerl_Party_Reset()
function XPerl_Party_Reset()
	if (XPerl_Party_Set_Bits) then
		XPerl_Party_Set_Bits()
		XPerl_Party_UpdateDisplayAll()
	end
end

-- XPerl_PartyPet_Reset()
function XPerl_PartyPet_Reset()
	if (XPerl_Party_Pet_Set_Bits) then
		XPerl_Party_Pet_Set_Bits()
		XPerl_Party_Pet_UpdateDisplayAll()
	end
end




-- Moving stuff
function XPerl_Player_GetGap()
	if (XPerl_Player and XPerl_Target) then
		local pr = XPerl_Player.statsFrame:GetRight()
		local ps = XPerl_Player:GetEffectiveScale()
		if (pr and ps) then
			local playerLeft = pr * ps
			local tl = XPerl_Target:GetLeft()
			local ts = XPerl_Target:GetEffectiveScale()
			if (tl and ts) then
				local targetLeft = tl * ts
				local a = targetLeft - playerLeft
				return floor(floor((a + 0.01) * 100) / 100 + 4)
			end
		end
	end
	return 0
end

-- XPerl_Player_SetGap
function XPerl_Player_SetGap(newGap)
	if (type(newGap) == "number") then
		newGap = newGap - 4

		local function SetChildGap(self, other)
			if (self and other) then
				local top = other:GetTop()
				local left

				if (self == XPerl_Player) then
					left = ((self.statsFrame:GetRight() * self:GetEffectiveScale()) + newGap) / other:GetEffectiveScale()
				else
					left = ((self:GetRight() * self:GetEffectiveScale()) + newGap) / other:GetEffectiveScale()
				end

				if (self == XPerl_Target or self == XPerl_TargetTarget or self == XPerl_Focus) then
					if (self.levelFrame and self.levelFrame:IsShown()) then
						left = left + self.levelFrame:GetWidth()
					end
				end

				other:ClearAllPoints()
				other:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
				other:SetUserPlaced(true)
				XPerl_SavePosition(other)
			end
		end

		SetChildGap(XPerl_Player, XPerl_Target)
		SetChildGap(XPerl_Target, XPerl_TargetTarget)
		SetChildGap(XPerl_TargetTarget, XPerl_TargetTargetTarget)
		SetChildGap(XPerl_Focus, XPerl_FocusTarget)
		SetChildGap(XPerl_Player_Pet, XPerl_PetTarget)

		if (XPerl_Player) then
			XPerl_SavePosition(XPerl_Player)
		end
	end
end

-- XPerl_Player_AlignTop
function XPerl_Player_AlignTop()

	-- We set this for 1 reason, so that all the related frames scale in the same direction should the user do that...
	if (XPerl_Player) then
		XPerl_Player:ClearAllPoints()
		XPerl_Player:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", XPerl_Player:GetLeft() or 5, XPerl_Player:GetTop() or 948)
		XPerl_Player:SetUserPlaced(true)
	end

	local function AlignChildTop(self, other)
		if (self and other) then
			local top = self:GetTop() * self:GetEffectiveScale()
			local otherLeft = other:GetLeft() or 220
			local selfLeft = self:GetLeft() or 5

			if (otherLeft == nil) then
				otherLeft = selfLeft + 200
			end

			other:ClearAllPoints()
			local newTop = top / other:GetEffectiveScale()
			other:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", otherLeft, newTop)
			other:SetUserPlaced(true)
		end
	end

	AlignChildTop(XPerl_Player, XPerl_Target)
	AlignChildTop(XPerl_Target, XPerl_TargetTarget)
	AlignChildTop(XPerl_TargetTarget, XPerl_TargetTargetTarget)
	AlignChildTop(XPerl_Focus, XPerl_FocusTarget)
	AlignChildTop(XPerl_Player_Pet, XPerl_PetTarget)
end

-- Moving stuff
function XPerl_Raid_GetGap()
	if (XPerl_Raid_Grp2) then
		if (XPerlDB.raid.anchor == "TOP" or XPerlDB.raid.anchor == "BOTTOM") then
			return floor((floor(((XPerl_Raid_Grp2:GetLeft() or 0) - (XPerl_Raid_Grp1:GetRight() or XPerl_Raid_Grp2:GetLeft() or 80) + 0.01) * 100) / 100))
		else
			return floor((floor(((XPerl_Raid_Grp1:GetTop() or XPerl_Raid_Grp2:GetTop() or 200) - (XPerl_Raid_Grp2:GetBottom() or 200) + 0.01) * 100) / 100) - 46)
		end
	end
	return (0)
end

-- InterestingFrames
local function InterestingFrames()
	local interest = XPerl_Options.raidAlign
	local ret = {}

	if (interest == "all") then
		for i = 1,10 do
			tinsert(ret, _G["XPerl_Raid_Title"..i])
		end
	elseif (interest == "odd") then
		for i = 1,10,2 do
			tinsert(ret, _G["XPerl_Raid_Title"..i])
		end
	elseif (interest == "even") then
		for i = 2,10,2 do
			tinsert(ret, _G["XPerl_Raid_Title"..i])
		end
	elseif (interest == "first4") then
		for i = 1,4 do
			tinsert(ret, _G["XPerl_Raid_Title"..i])
		end
	elseif (interest == "last4") then
		for i = 5,9 do
			tinsert(ret, _G["XPerl_Raid_Title"..i])
		end
	end
	return ret
end

-- XPerl_Raid_SetGap
function XPerl_Raid_SetGap(newGap)
	if (type(newGap) == "number") then
		local frames = InterestingFrames()

		if (XPerlDB.raid.anchor == "TOP" or XPerlDB.raid.anchor == "BOTTOM") then
			local framePrev

			for i,frame in pairs(frames) do
				if (framePrev and frame) then
					local right = framePrev:GetRight()
					local top = frame:GetTop()

					frame:ClearAllPoints()
					frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", right + newGap, top)
					frame:SetUserPlaced(true)
					XPerl_SavePosition(frame)
				end

				framePrev = frame
			end
		else
			local framePrev

			for i,frame in pairs(frames) do
				if (framePrev and frame) then
					local bottom = framePrev:GetBottom()
					local left = frame:GetLeft()

					frame:ClearAllPoints()
					frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, bottom + newGap - 26)
					frame:SetUserPlaced(true)
					XPerl_SavePosition(frame)
				end

				framePrev = frame
			end
		end
	end
end

-- XPerl_Raid_AlignTop
function XPerl_Raid_AlignTop()
	if (not XPerl_Raid_Grp1) then
		return
	end

	local frames = InterestingFrames()

	local top = frames[1]:GetTop()

	for i,frame in pairs(frames) do
		local left = frame:GetLeft()

		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
		frame:SetUserPlaced(true)
		XPerl_SavePosition(frame)
	end
end

-- XPerl_Raid_AlignLeft
function XPerl_Raid_AlignLeft()
	if (not XPerl_Raid_Grp1) then
		return
	end

	local frames = InterestingFrames()

	local left = frames[1]:GetLeft()

	for i,frame in pairs(frames) do
		local top = frame:GetTop()

		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
		frame:SetUserPlaced(true)
		XPerl_SavePosition(frame)
	end
end

--------------------------------------------------------------------
-------------------------- LAYOUT STUFF ----------------------------
--------------------------------------------------------------------

-- XPerl_Options_LayoutGetList
function XPerl_Options_LayoutGetList(self)
	local list = {}

	if (XPerlConfigNew.savedPositions) then
		for realmName,realmList in pairs(XPerlConfigNew.savedPositions) do
			for playerName,frames in pairs(realmList) do
				if (realmName == "saved") then
					tinsert(list, playerName)
				else
					tinsert(list, format("%s(%s)", realmName, playerName))
				end
			end
		end

		sort(list)
	end

	return list
end

-- XPerl_Options_GetLayout
function XPerl_Options_GetLayout(self, name)
	if (XPerlConfigNew.savedPositions) then
		for realmName,realmList in pairs(XPerlConfigNew.savedPositions) do
			for playerName,frames in pairs(realmList) do
				local find
				if (realmName == "saved") then
					find = playerName
				else
					find = format("%s(%s)", realmName, playerName)
				end

				if (name == find) then
					return frames
				end
			end
		end
	end
end


-- XPerl_Options_SaveFrameLayout
function XPerl_Options_SaveFrameLayout(name)
	if (not XPerlConfigNew.savedPositions) then
		XPerlConfigNew.savedPositions = {}
	end
	if (not XPerlConfigNew.savedPositions.saved) then
		XPerlConfigNew.savedPositions.saved = {}
	end
	XPerlConfigNew.savedPositions.saved[name] = XPerl_CopyTable(XPerl_GetSavePositionTable())
end

-- XPerl_Options_LoadFrameLayout
function XPerl_Options_LoadFrameLayout(name)
	local layout = XPerl_Options_GetLayout(self, name)

	if (layout) then
		local name = UnitName("player")
		local realm = GetRealmName()

		if (not XPerlConfigNew.savedPositions) then
			if (not create) then
				return
			end
			XPerlConfigNew.savedPositions = {}
		end
		local c = XPerlConfigNew.savedPositions
		if (not c[realm]) then
			if (not create) then
				return
			end
			c[realm] = {}
		end
		if (not c[realm][name]) then
			if (not create) then
				return
			end
			c[realm][name] = {}
		end

		c[realm][name] = XPerl_CopyTable(layout)

		--XPerlConfigNew.savedPositions.current = XPerl_CopyTable(layout)

		XPerl_RestoreAllPositions()
	end
end

-- XPerl_Options_DeleteFrameLayout
function XPerl_Options_DeleteFrameLayout(name)
	local me = format("%s(%s)", GetRealmName(), UnitName("player"))

	if (XPerlConfigNew.savedPositions) then
		for realmName,realmList in pairs(XPerlConfigNew.savedPositions) do
			for playerName,frames in pairs(realmList) do
				local find
				if (realmName == "saved") then
					find = playerName
				else
					find = format("%s(%s)", realmName, playerName)
				end

				if (name ~= me and name == find) then
					realmList[playerName] = nil
					return true
				end
			end
		end
	end
end

-- XPerl_Options_LayoutFill
function XPerl_Options_LayoutFill(self, setName)
	local list = XPerl_Options_LayoutGetList(self)

	self.start = self.scrollBar.bar:GetValue() + 1

	if (self.selection) then
		if (self.selection < 1) then
			self.selection = 1
		elseif (self.selection > #list) then
			self.selection = #list
		end
	end

	for i = 1,#self.line do
		self.line[i]:SetText("")
		self.line[i]:UnlockHighlight()
		self.line[i]:Hide()
	end

	local newName
	local line = 1
	for i = self.start,self.start+#self.line-1 do
		if (i > #list) then
			break
		end

		self.line[line].raw = list[i]

		if (strsub(list[i], strlen(list[i])) == ")") then
			self.line[line]:SetText("|cFF6060A0"..list[i])
		else
			self.line[line]:SetText(list[i])
		end

		self.line[line]:Show()

		if (i == self.selection) then
			self.line[line]:LockHighlight()

			if (setName) then
				newName = list[i]
			end
		end

		line = line + 1
	end

	if (setName) then
		if (newName) then
			XPerl_Options_Layout_Name:SetText(newName)
		else
			XPerl_Options_Layout_Name:SetText("")
		end
	end

	local offset = self.scrollBar.bar:GetValue()
	
	--frame, numItems, numToDisplay, valueStep, button, smallWidth, bigWidth, highlightFrame, smallHighlightWidth, bigHighlightWidth, alwaysShowScrollBar )

	if (FauxScrollFrame_Update(self.scrollBar, #list, 16, 1)) then
		self.scrollBar:Show()
	else
		self.scrollBar:Hide()
	end
end

---------------------------------------------------------------------
-------------------------- CONFIG IMPORT ----------------------------
---------------------------------------------------------------------
if (XPerlConfig or XPerlConfig_Global) then

-- Convert		-- Convert old options (we have 1 or nil now instead of 1 or 0)
local function Convert(opt)
	if (opt == 0) then
		return nil
	end
	return opt
end

-- XPerl_Options_ImportOldConfig
function XPerl_Options_ImportOldConfig(old)

	if (not old) then
		return
	end

	local new = {
		showTutorials		= old.ShowTutorials,
		tutorialFlags		= old.TutorialFlags,
		bar = {
			texture		= old.BarTexture,
			background	= Convert(old.BackgroundTextures),
			fading		= Convert(old.FadingBars),				-- 1.8.9
			fadeTime	= old.FadingBarsTime			or 0.5,		-- 1.9.1
			fat		= Convert(old.FatHealthBars),
			inverse		= Convert(old.InverseBars),				-- 1.8.6
		},
		transparency = {
			frame		= old.Transparency			or 1,
			text		= old.TextTransparency			or 1,
		},
		colour = {
			frame			= old.BackColour		or {r = 0, g = 0, b = 0, a = 1},
			border			= old.BorderColour		or {r = 0.5, g = 0.5, b = 0.5, a = 1},
			class			= Convert(old.ClassColouredNames),
			guildList		= Convert(old.ApplyToGuildList),		-- 1.8.9
			classic			= Convert(old.ClassicHealthBar),
			bar = {
				healthEmpty	= old.ColourHealthEmpty		or {r = 1, g = 0, b = 0},
				healthFull	= old.ColourHealthFull		or {r = 0, g = 1, b = 0},
				mana		= old.ColourMana		or {r = 0, g = 0, b = 1},
				energy		= old.ColourEnergy		or {r = 1, g = 1, b = 0},
				rage		= old.ColourRage		or {r = 1, g = 0, b = 0},
				focus		= old.ColourFocus		or {r = 1, g = 0.5, b = 0.25},
				runic_power	= {r = PowerBarColor and PowerBarColor["RUNIC_POWER"].r or 1, g = PowerBarColor and PowerBarColor["RUNIC_POWER"].g or 1, b = PowerBarColor and PowerBarColor["RUNIC_POWER"].b or 1},
			},
			reaction = {
				enemy		= old.ColourReactionEnemy	or {r = 1, g = 0, b = 0},
				neutral		= old.ColourReactionNeutral	or {r = 1, g = 1, b = 0},
				unfriendly	= old.ColourReactionUnfriendly	or {r = 1, g = 0.5, b = 0},
				friend		= old.ColourReactionFriend	or {r = 0, g = 1, b = 0},
				none		= old.ColourReactionNone	or {r = 0.5, g = 0.5, b = 1},
				tapped		= old.ColourTapped		or {r = 0.5, g = 0.5, b = 0.5},
			},
			gradient = XPerl_DefaultGradientColours(),
		},
		highlightSelection	= Convert(old.HighlightSelection),
		minimap = {
			enable		= Convert(old.MinimapButtonShown),
			pos		= old.MinimapButtonPosition	or 186,
		},
		combatFlash		= Convert(old.PerlCombatFlash),
		highlightDebuffs = {
			enable		= Convert(old.HighlightDebuffs),
			border		= 1,
			frame		= 1,
			class		= Convert(old.HighlightDebuffsClass),
		},
		buffHelper = {
			enable		= Convert(old.BuffTooltipHelper),
			sort		= old.BuffTooltipHelperSort	or "group",		-- 2.2.5
			visible		= Convert(old.BuffTooltipHelperVisible or 1),		-- 2.2.9
		},
		tooltip = {
			enable		= Convert(old.UnitTooltips),				-- 2.0.5
			enableBuffs	= 1,							-- 2.3.4a
			fading		= Convert(old.FadingTooltip),				-- 1.8.3
			xperlInfo	= Convert(old.XPerlTooltipInfo),			-- 1.8.6
			modifier	= old.UnitTooltipsModifiers	or "all",		-- 2.0.6
		},
		maximumScale		= old.MaximumScale		or 1.5,
		optionsColour		= old.OptionsColour		or {r = 0.7, g = 0.2, b = 0.2},	-- 1.8.3
		showAFK			= Convert(old.ShowAFK),					-- 2.2.4
		buffs = {
			cooldown	= Convert(old.BuffCooldown),				-- 2.2.3
			countdown	= Convert(old.BuffCountdown),				-- 2.2.2
			countdownStart	= old.BuffCountdownStart	or 20,			-- 2.2.2
		},
		rangeFinder = old.RangeFinder or XPerl_DefaultRangeFinder(),
		highlight = {
			enable			= Convert(old.RaidHighlights),
			HOT			= Convert(old.RaidHighlightHoTs),
			SHIELD			= Convert(old.RaidHighlightShields),
			AGGRO			= Convert(old.RaidHighlightAggro),
			MISSING			= Convert(old.RaidHighlightMissing),
			all			= Convert(old.RaidHighlightMissingAll),
		},
		player = {
			enable			= 1,
			castBar = {
				enable		= Convert(old.ArcaneBarPlayer),
				original	= Convert(old.OldCastBar),
				castTime	= Convert(old.CastTime),
			},
			portrait		= Convert(old.ShowPlayerPortrait),
			portrait3D		= Convert(old.ShowPlayerPortrait3D),
			hitIndicator	= Convert(old.CombatHitIndicator),
			level			= Convert(old.ShowPlayerLevel),
			classIcon		= Convert(old.ShowPlayerClassIcon),
			xpBar			= Convert(old.ShowPlayerXPBar),
			repBar			= Convert(old.ShowPlayerRepBar),
			pvpIcon			= Convert(old.ShowPlayerPVP),
			values			= Convert(old.ShowPlayerValues),
			percent			= Convert(old.ShowPlayerPercent),
			scale			= old.Scale_PlayerFrame		or 0.8,
			partyNumber		= Convert(old.ShowPartyNumber),
			withName		= Convert(old.ShowPartyNumberWithName),
			energyTicker	= Convert(old.EnergyTicker),
			showRunes		= 1,
			dockRunes		= 1,


			fullScreen = {
				enable		= Convert(old.FullScreenStatus),
				lowHP		= old.FullScreenStatusWarn	or 30,
				highHP		= old.FullScreenStatusOK	or 40,
			},

			healerMode = {
				enable		= Convert(old.HealerModePlayer),
				type		= old.HealerModePlayerType	or 1,
			},

			buffs = {
				enable		= Convert(old.PlayerBuffs),
				above		= Convert(old.PlayerBuffsAbove),
				size		= old.PlayerBuffSize		or 15,
				hideBlizzard	= Convert(old.HideBlizzardBuffBar),
				count		= old.PlayerBuffMaxDisplay	or 40,
				cooldown	= Convert(old.PlayerBuffsCooldown),
				flash		= Convert(old.PlayerBuffsFlash),
				wrap		= 1,			-- 2.3.5
				rows		= 2,			-- 2.3.5
			},
			debuffs = {
				enable		= Convert(old.PlayerBuffs),
				size		= old.PlayerBuffSize		or 19,
			},
			size = {
				width		= old.PlayerWidthBonus		or 0,
			},
		},
		pet = {
			enable			= 1,
			castBar = {
				enable		= Convert(old.ArcaneBarPlayer),
			},
			portrait		= Convert(old.ShowPlayerPetPortrait),
			portrait3D		= Convert(old.ShowPlayerPetPortrait3D),
			hitIndicator		= Convert(old.PetCombatHitIndicator),
			happiness = {
				enabled		= Convert(old.PetHappiness),
				onlyWhenSad	= Convert(old.PetHappinessSad),
				flashWhenSad	= Convert(old.PetFlashWhenSad),
			},
			level			= Convert(old.ShowPetLevel),
			scale			= old.Scale_PetFrame		or 0.8,
			xpBar			= Convert(old.ShowPetXP),
			name			= Convert(old.ShowPlayerPetName),
			buffs = {
				enable		= 1,
				size		= old.PlayerPetBuffSize		or 15,
				wrap		= 1,			-- 2.3.5
			},
			debuffs = {
				enable		= 1,
				size		= old.PlayerPetBuffSize		or 19,
			},
			healerMode = {
--				enable		= nil,
				type		= 1,
			},
			values			= Convert(old.ShowPlayerPetValues),
			size = {
				width		= old.PetWidthBonus		or 0,
			},
		},
		target = {
			enable			= 1,
			portrait		= Convert(old.ShowTargetPortrait),
			portrait3D		= Convert(old.ShowTargetPortrait3D),
			castBar = {
				enable		= Convert(old.ArcaneBarTarget),
			},
			hitIndicator		= Convert(old.TargetCombatHitIndicator),			-- 2.1.7
			classIcon		= Convert(old.ShowTargetClassIcon),
			classText		= Convert(old.ShowTargetClassText),			-- 2.0.6
			mobType			= Convert(old.ShowTargetMobType),
			level			= Convert(old.ShowTargetLevel),
			elite			= Convert(ceil((old.ShowTargetElite or 1) / 2)),
			eliteGfx		= Convert(floor((old.ShowTargetElite or 1) / 2)),
			mana			= Convert(old.ShowTargetMana),
			percent			= Convert(old.ShowTargetPercent),
			values			= Convert(old.ShowTargetValues),
			combo = {
				enable		= Convert(old.UseCPMeter),
				blizzard	= Convert(old.BlizzardCPMeter),
				pos		= old.BlizzardCPPosition	or "top",
			},
			pvpIcon			= Convert(old.ShowTargetPVP),			-- 1.8.3
			scale			= old.Scale_TargetFrame		or 0.8,
			raidIconAlternate	= Convert(old.AlternateRaidIcon),
			buffs = {
				enable		= 1,
				wrap		= 1,
				above		= Convert(old.TargetBuffsAbove),
				size		= old.TargetBuffSize		or 15,
				rows		= old.TargetBuffRows		or 3,
				castable	= old.TargetCastableBuffs	or 0,
			},
			debuffs = {
				enable		= 1,
				curable		= old.TargetCurableDebuffs	or 0,
				size		= old.TargetBuffSize		or 19,
				big		= 1,						-- 2.3.6
			},
			reactionHighlight	= Convert(old.TargetReactionHighlight),			-- 1.8.6
			healerMode = {
				enable		= Convert(old.HealerModeTarget),		-- 1.9.1
				type		= old.HealerModeTargetType	or 1,		-- 1.9.1
			},
			defer			= Convert(old.TargetChangeDefer),			-- 1.9.5
			highlightDebuffs = {
				enable		= Convert(old.TargetDebuffHighlight),
				who		= old.TargetDebuffHighlightWho	or 1			-- 2.2.0
			},
			size = {
				width		= old.TargetWidthBonus		or 0,
			},
			sound			= Convert(old.TargetSounds or 1),		-- 2.2.6
		},
		focus = {
			enable			= Convert(old.ShowFocus),
			portrait		= Convert(old.ShowFocusPortrait),
			portrait3D		= Convert(old.ShowFocusPortrait3D),
			castBar = {
				enable		= Convert(old.ArcaneBarFocus),
			},
			hitIndicator		= Convert(old.FocusCombatHitIndicator),			-- 2.1.7
			classIcon		= Convert(old.ShowFocusClassIcon),
			classText		= Convert(old.ShowFocusClassText),			-- 2.0.6
			mobType			= Convert(old.ShowFocusMobType),
			level			= Convert(old.ShowFocusLevel),
			elite			= Convert(ceil((old.ShowFocusElite or 1) / 2)),
			eliteGfx		= Convert(floor((old.ShowFocusElite or 1) / 2)),
			mana			= Convert(old.ShowFocusMana),
			percent			= Convert(old.ShowFocusPercent),
			values			= Convert(old.ShowFocusValues),
			pvpIcon			= Convert(old.ShowFocusPVP),			-- 1.8.3
			scale			= old.Scale_FocusFrame		or 0.8,
			raidIconAlternate	= Convert(old.AlternateRaidIcon),
			buffs = {
				enable		= 1,
				wrap		= 1,
				above		= Convert(old.FocusBuffsAbove),
				size		= old.FocusBuffSize		or 15,
				rows		= old.FocusBuffRows		or 3,
				castable	= old.FocusCastableBuffs	or 0,
				curable		= old.FocusCurableDebuffs	or 0,
			},
			debuffs = {
				enable		= 1,
				size		= old.FocusBuffSize		or 19,
				curable		= old.TargetCurableDebuffs	or 0,
			},
			reactionHighlight	= Convert(old.FocusReactionHighlight),			-- 1.8.6
			healerMode = {
				enable		= Convert(old.HealerModeFocus),				-- 1.9.1
				type		= old.HealerModeFocusType	or 1,			-- 1.9.1
			},
			defer			= Convert(old.TargetChangeDefer),			-- 1.9.5
			highlightDebuffs = {
				enable		= Convert(old.FocusDebuffHighlight),
				who		= old.FocusDebuffHighlightWho	or 1,			-- 2.2.0
			},
			size = {
				width		= old.FocusWidthBonus		or 0,
			},
		},
		targettarget = {
			enable			= Convert(old.ShowTargetTarget),
			buffs = {
				enable		= Convert(old.TargetTargetBuffs),
				above		= Convert(old.TargetTargetBuffsAbove),
				size		= old.FocusBuffSize		or 15,
				rows		= old.FocusBuffRows		or 3,
				castable	= old.TargetCastableBuffs	or 0,
				curable		= old.TargetCurableDebuffs	or 0,
				wrap		= 1,			-- 2.3.5
			},
			debuffs = {
				enable		= Convert(old.TargetTargetBuffs),
				size		= old.FocusBuffSize		or 19,
			},
			scale			= old.Scale_TargetTargetFrame	or 0.8,
			percent			= Convert(old.ShowTargetTargetPercent),
			values			= Convert(old.ShowTargetTargetValues),
			level			= Convert(old.ShowTargetTargetLevel),
			mana			= Convert(old.ShowTargetTargetMana),
			size = {
				width		= old.TargetTargetWidthBonus	or 0,
			},
		},
		targettargettarget = {
			enable			= Convert(old.ShowTargetTargetTarget),
			buffs = {
				enable		= Convert(old.TargetTargetTargetBuffs),
				above		= Convert(old.TargetTargetBuffsAbove),
				size		= old.FocusBuffSize		or 15,
				rows		= old.FocusBuffRows		or 3,
				castable	= old.TargetCastableBuffs	or 0,
				curable		= old.TargetCurableDebuffs	or 0,
			},
			debuffs = {
				enable		= Convert(old.TargetTargetBuffs),
				size		= old.FocusBuffSize		or 19,
			},
			scale			= old.Scale_TargetTargetFrame	or 0.8,
			percent			= Convert(old.ShowTargetTargetPercent),
			values			= Convert(old.ShowTargetTargetValues),
			level			= Convert(old.ShowTargetTargetLevel),
			mana			= Convert(old.ShowTargetTargetMana),
			size = {
				width		= old.TargetTargetWidthBonus	or 0,
			},
		},
		focustarget = {
			enable			= Convert(old.ShowFocusTarget),
			buffs = {
				enable		= Convert(old.FocusTargetBuffs),
				above		= Convert(old.FocusTargetBuffsAbove),
				size		= old.FocusBuffSize		or 15,
				rows		= old.FocusBuffRows		or 3,
				castable	= old.TargetCastableBuffs	or 0,
				curable		= old.TargetCurableDebuffs	or 0,
				wrap		= 1,			-- 2.3.5
			},
			debuffs = {
				enable		= Convert(old.TargetTargetBuffs),
				size		= old.FocusBuffSize		or 19,
			},
			scale			= old.Scale_FocusTargetFrame	or 0.8,
			percent			= Convert(old.ShowFocusTargetPercent),
			values			= Convert(old.ShowFocusTargetValues),
			level			= Convert(old.ShowFocusTargetLevel),
			mana			= Convert(old.ShowFocusTargetMana),
			size = {
				width		= old.FocusTargetWidthBonus	or 0,
			},
		},
		pettarget = {
			enable			= Convert(old.ShowPetTarget),
			buffs = {
				enable		= Convert(old.PlayerPetTargetBuffs),
				above		= Convert(old.PlayerPetTargetBuffsAbove),
				size		= old.TargetBuffSize		or 15,
				rows		= old.TargetBuffRows		or 3,
				castable	= old.TargetCastableBuffs	or 0,
				curable		= old.TargetCurableDebuffs	or 0,
				wrap		= 1,			-- 2.3.5
			},
			debuffs = {
				enable		= Convert(old.TargetTargetBuffs),
				size		= old.TargetBuffSize		or 19,
			},
			scale			= old.Scale_PlayerPetTargetFrame or 0.8,
			percent			= Convert(old.ShowPlayerPetTargetPercent),
			values			= Convert(old.ShowPlayerPetTargetValues),
			level			= Convert(old.ShowPlayerPetTargetLevel),
			mana			= Convert(old.ShowPlayerPetTargetMana),
			size = {
				width		= old.FocusTargetWidthBonus	or 0,
			},
		},
		party = {
			enable			= 1,
			castBar = {
				enable		= Convert(old.ArcaneBarParty),
				castTime	= Convert(old.CastTime),
			},
			spacing			= old.PartySpacing		or 23,
			anchor			= old.PartyAnchor		or "TOP",
			portrait		= Convert(old.ShowPartyPortrait),
			portrait3D		= Convert(old.ShowPartyPortrait3D),
			target = {
				enable		= Convert(old.ShowPartyTarget),
				large		= Convert(old.PartyTargetLarge),
				size		= old.PartyTargetSize		or 120,			-- 2.0.9
			},
			level			= Convert(old.ShowPartyLevel),
			name			= Convert(old.ShowPartyNames),
			values			= Convert(old.ShowPartyValues),
			percent			= Convert(old.ShowPartyPercent),
			classIcon		= Convert(old.ShowPartyClassIcon),
			pvpIcon			= Convert(old.ShowPartyPVP),			-- 1.8.3
			inRaid			= Convert(old.ShowPartyRaid),
			buffs = {
				wrap		= 1,
				enable		= Convert(old.PartyBuffs),
				size		= old.PartyBuffSize		or 22,
				castable	= old.PartyCastableBuffs	or 0,
				rows		= 2,
			},
			debuffs = {
				enable		= Convert(old.PartyDebuffs),
				size		= old.PartyBuffSize		or 32,
				curable		= old.PartyCurableDebuffs	or 0,
				halfSize	= Convert(old.PartyDebuffsHalfSize),			-- 2.2.6
				below		= Convert(old.PartyDebuffsBelow),
			},
			scale			= old.Scale_PartyFrame		or 0.8,
			healerMode = {
				enable		= Convert(old.HealerModeParty),			-- 1.9.1
				type		= old.HealerModePartyType	or 1,			-- 1.9.1
			},
			hitIndicator		= Convert(old.PartyCombatHitIndicator),			-- 2.1.7
			size = {
				width		= old.PartyWidthBonus		or 0,
			},
			flip			= Convert(old.PartyFlip),			-- 2.2.7
		},
		partypet = {
			enable			= Convert(old.ShowPartyPets),
			scale			= old.Scale_PartyPets		or 0.7,
			name			= Convert(old.ShowPartyPetName),
			buffs = {
				enable		= Convert(old.ShowPartyPetBuffs),
				castable	= old.PartyCastableBuffs	or 0,
				size		= 12,
			},
			debuffs = {
				enable		= Convert(old.ShowPartyPetBuffs),
				curable		= old.PartyCurableDebuffs	or 0,
			},
			healerMode = {
--				enable		= nil,
				type		= 1,
			},
			mana			= Convert(old.ShowPartyPetMana),			-- 1.9.1
			level			= Convert(old.ShowPartyPetLevel),			-- 1.9.1
		},
		raid = {
			enable			= Convert(old.ShowRaid),
			sortByClass		= Convert(old.SortRaidByClass),
			sortAlpha		= Convert(old.SortRaidAlpha),
			group = {
				Convert(old.ShowGroup1),
				Convert(old.ShowGroup2),
				Convert(old.ShowGroup3),
				Convert(old.ShowGroup4),
				Convert(old.ShowGroup5),
				Convert(old.ShowGroup6),
				Convert(old.ShowGroup7),
				Convert(old.ShowGroup8),
				Convert(old.ShowGroup9),
			},
			class = {
				{enable = Convert(old.RaidClass1Enable), name = old.RaidClass1 or "WARRIOR"},
				{enable = Convert(old.RaidClass2Enable), name = old.RaidClass2 or "ROGUE"},
				{enable = Convert(old.RaidClass3Enable), name = old.RaidClass3 or "HUNTER"},
				{enable = Convert(old.RaidClass4Enable), name = old.RaidClass4 or "MAGE"},
				{enable = Convert(old.RaidClass5Enable), name = old.RaidClass5 or "WARLOCK"},
				{enable = Convert(old.RaidClass6Enable), name = old.RaidClass6 or "PRIEST"},
				{enable = Convert(old.RaidClass7Enable), name = old.RaidClass7 or "DRUID"},
				{enable = Convert(old.RaidClass8Enable), name = old.RaidClass8 or "SHAMAN"},
				{enable = Convert(old.RaidClass9Enable), name = old.RaidClass9 or "PALADIN"},
				{enable = true, name = "DEATHKNIGHT"},
			},
			titles			= Convert(old.ShowRaidTitles),
			percent			= Convert(old.ShowRaidPercents),
			scale			= old.Scale_Raid		or 0.8,
			buffs = {
				enable		= Convert(old.RaidBuffs),
				castable	= old.BuffsCastableCurable	or 0,
				right		= Convert(old.RaidBuffsRight),
				inside		= Convert(old.RaidBuffsInside),
				untilDebuffed	= Convert(old.RaidBuffsUntilDebuffed),			-- 2.1.3
			},
			debuffs = {
				enable		= old.RaidDebuffs		or 0,
			},
			mana			= Convert(old.RaidMana),
			healerMode = {
				enable		= Convert(old.HealerModeRaid),
				type		= old.HealerModeRaidType	or 1,
			},
			spacing			= old.RaidVerticalSpacing	or 0,
			anchor			= old.RaidAnchor		or "TOP",
		},
		raidpet = {
			enable			= Convert(old.ShowRaidPets),				-- 2.1.3
			hunter			= Convert(old.ShowRaidPetsHunter),			-- 2.1.3
			warlock			= Convert(old.ShowRaidPetsWarlock),			-- 2.1.3
		},
		savedPositions = XPerl_CopyTable(old.SavedPositions),
	}

	return new
end

end




-------------------------------------------------------------------------------------
---------------------------------- DEFAULT CONFIGS ----------------------------------
-------------------------------------------------------------------------------------

local defaultConfig = {}


-- XPerl_RegisterConfigDefault
local function XPerl_RegisterConfigDefault(configFunc, configSection)
	tinsert(defaultConfig, {func = configFunc, section = configSection})
end

local function XPerl_MakeDefaultConfig(new)
	for k,v in pairs(defaultConfig) do
		v.func(new, v.section)
	end
end

-- XPerl_Options_Defaults()
function XPerl_Options_Defaults(new)
	XPerl_MakeDefaultConfig(new)
end


-- XPerl_Global_ConfigDefault
local function XPerl_Global_ConfigDefault(default)
	-- Defaults for global options

	if (not default) then
		error("Usage: XPerl_Global_ConfigDefault(<table>)")
		return
	end

	default.transparency = {
		frame		= 1,
		text		= 1,
	}

	default.highlightSelection	= 1
	default.combatFlash	= 1
	default.maximumScale	= 1.5
	default.optionsColour	= {r = 0.7, g = 0.2, b = 0.2}	-- 1.8.3
	default.showAFK		= 1				-- 2.2.4

	default.minimap = {
		pos		= 186,
		enable		= 1,
	}

	default.highlightDebuffs = {
		enable		= 1,
		border		= 1,
		frame		= 1,
		class		= 1,
	}

	default.buffHelper = {
		enable		= 1,
		sort		= "group",		-- 2.2.5
		visible		= 1,			-- 2.2.9
	}

	default.buffs = {
		cooldown	= 1,			-- 2.2.3
		countdown	= 1,			-- 2.2.2
		countdownStart	= 20,			-- 2.2.2
	}

	default.rangeFinder = XPerl_DefaultRangeFinder()

	default.tooltip = {
		enable		= 1,			-- 2.0.5
		enableBuffs	= 1,			-- 2.3.4a
--		fading		= nil,			-- 1.8.3
--		xperlInfo	= nil,			-- 1.8.6
		modifier	= "all",		-- 2.0.6
	}

	default.colour = {
		border		= {r = 0.5, g = 0.5, b = 0.5, a = 1},
		frame		= {r = 0, g = 0, b = 0, a = 1},
		class		= 1,
		guildList	= 1,		-- 1.8.9
		classic		= 1,
		bar		= XPerl_DefaultBarColours(),
		reaction	= XPerl_DefaultReactionColours(),
		gradient	= XPerl_DefaultGradientColours(),
	}

	default.bar = {
		texture		= {"Perl v2", "Interface\\Addons\\XPerl\\Images\\XPerl_StatusBar"},
		background	= 1,
--		fading		= nil,		-- 1.8.9
		fadeTime	= 0.5,		-- 1.9.1
		fat		= 1,
--		inverse		= nil,		-- 1.8.6
	}

	default.highlight = {
		enable			= 1,
		HOT			= 1,
		SHIELD			= 1,
		AGGRO			= 1,
--		MISSING			= nil,
--		all			= nil,
	}

end

-- XPerl_Target_ConfigDefault
local function XPerl_Target_ConfigDefault(default, section)
	local defaultHD
	local class = select(2, UnitClass("player"))
	if (section == "target" and class == "ROGUE") then
		defaultHD = 1
		defaultHDwho = 3
	else
		defaultHDwho = 2
	end
	default[section] = {
		enable			= 1,
		portrait		= 1,
		portrait3D		= 1,
		castBar = {
			enable		= 1,
		},
		hitIndicator	= 1,			-- 2.1.7
		threat			= 1,
		threatMode		= "portraitFrame",
		classIcon		= 1,
--		classText		= nil,			-- 2.0.6
		mobType			= 1,
		level			= 1,
		elite			= 1,
--		eliteGfx		= nil,
		mana			= 1,
		percent			= 1,
		values			= 1,
		combo = {
			enable		= 1,
			blizzard	= 1,
			pos		= "top",
		},
		pvpIcon			= 1,			-- 1.8.3
		scale			= 0.8,
		raidIconAlternate	= 1,
		buffs = {
			enable		= 1,
			wrap		= 1,
--			above		= nil,
			size		= 22,
			rows		= 3,
			castable	= 0,
		},
		debuffs = {
			enable		= 1,
			size		= 29,
			curable		= 0,
			big		= 1,			-- 2.3.6
		},
--		reactionHighlight	= nil,			-- 1.8.6
		healerMode = {
--			enable		= nil,			-- 1.9.1
			type		= 1,			-- 1.9.1
		},
--		defer			= nil,			-- 1.9.5
		highlightDebuffs = {
			enable		= defaultHD,
			who		= defaultHDwho		-- 2.2.0
		},
		size = {
			width		= 0,
		},
		sound			= 1,			-- 2.2.6
	}
end

-- XPerl_Party_ConfigDefault
local function XPerl_Party_ConfigDefault(default)
	default.party = {
		castBar = {
			enable		= 1,
			castTime	= 1,
		},
		spacing			= 23,
		anchor			= "TOP",
		portrait		= 1,
		portrait3D		= 1,
		hitIndicator	= 1,			-- 2.1.7
		threat			= 1,
		threatMode		= "portraitFrame",
		target = {
			enable		= 1,
			large		= 1,
			size		= 120,			-- 2.0.9
		},
		level			= 1,
		name			= 1,
		values			= 1,
		percent			= 1,
		classIcon		= 1,
		pvpIcon			= 1,			-- 1.8.3
		inRaid			= 1,
		buffs = {
			enable		= 1,
			wrap		= 1,			-- 2.3.5
			size		= 22,
			castable	= 0,
			rows		= 2,
		},
		debuffs = {
			enable		= 1,
			size		= 32,
			curable		= 0,
			halfSize	= 1,			-- 2.2.6
			below		= 1,
		},
		scale			= 0.8,
		healerMode = {
--			enable		= nil,			-- 1.9.1
			type		= 1,			-- 1.9.1
		},
		size = {
			width		= 0,
		},
--		flip			= nil,			-- 2.2.7
	}
end

-- XPerl_PartyPet_ConfigDefault
local function XPerl_PartyPet_ConfigDefault(default)
	default.partypet = {
		enable			= 1,
		scale			= 0.7,
		name			= 1,
		buffs = {
			enable		= 1,
			castable	= 0,
			size		= 12,
		},
		debuffs = {
			enable		= 1,
			curable		= 0,
		},
		healerMode = {
--			enable		= nil,
			type		= 1,
		},
--		mana			= nil,			-- 1.9.1
--		level			= nil,			-- 1.9.1
	}
end

-- XPerl_Player_ConfigDefault
local function XPerl_Player_ConfigDefault(default)
	default.player = {
		castBar = {
			enable		= 1,
--			original	= nil,
--			castTime	= nil,
		},
		portrait		= 1,
		portrait3D		= 1,
		hitIndicator	= 1,
		threat			= 1,
		threatMode		= "portraitFrame",
		level			= 1,
		classIcon		= 1,
--		xpBar			= nil,
--		repBar			= nil,
		pvpIcon			= 1,
		values			= 1,
		percent			= 1,
		scale			= 0.9,
		partyNumber		= 1,
--		withName		= nil,
		energyTicker	= 1,
		showRunes		= 1,
		dockRunes		= 1,

		fullScreen = {
			enable		= 1,
			lowHP		= 30,
			highHP		= 40,
		},

		healerMode = {
--			enable		= nil,
			type		= 1,
		},

		buffs = {
			enable		= 1,
--			above		= nil,
			size		= 25,
			wrap		= 1,			-- 2.3.5
			rows		= 2,			-- 2.3.5
			hideBlizzard	= 1,
			count		= 40,
			cooldown	= 1,
			flash		= 1,
		},
		debuffs = {
			enable		= 1,
			size		= 25,
		},
		size = {
			width		= 0,
		},
	}
end

-- XPerl_Pet_ConfigDefault
local function XPerl_Pet_ConfigDefault(default)
	default.pet = {
		castBar = {
			enable		= 1,
		},
		portrait		= 1,
		portrait3D		= 1,
		hitIndicator	= 1,
		threat			= 1,
		threatMode		= "portraitFrame",
		happiness = {
			enabled		= 1,
			onlyWhenSad	= 1,
			flashWhenSad	= 1,
		},
		level			= 1,
		scale			= 0.7,
--		xpBar			= nil,
		name			= 1,
		buffs = {
			enable		= 1,
			size		= 18,
		},
		values			= 1,
		healerMode = {
--			enable		= nil,
			type		= 1,
		},
		size = {
			enable		= 1,
			width		= 0,
			size		= 20,
		},
	}
end

-- XPerl_TargetTarget_ConfigDefault
local function XPerl_TargetTarget_ConfigDefault(default, section)
	local e
	if (section ~= "targettargettarget") then
		e = 1
	end

	default[section] = {
		enable			= e,
		buffs = {
			enable		= 1,
--			above		= nil,
			size		= 22,
			rows		= 3,
			castable	= 0,
			wrap		= 1,			-- 2.3.5
		},
		debuffs = {
			size		= 29,
			enable		= 1,
			curable		= 0,
		},
		scale			= 0.7,
		pvpIcon			= 1,
		percent			= 1,
		values			= 1,
--		level			= nil,
		mana			= 1,
		size = {
			width		= 0,
		},
		healerMode = {
--			enable		= nil,			-- 1.9.1
			type		= 1,			-- 1.9.1
		},
	}
end

-- XPerl_Raid_ConfigDefault
local function XPerl_Raid_ConfigDefault(default)
	default.raid = {
		enable			= 1,
--		sortByClass		= nil,
--		sortAlpha		= nil,
		group = {1, 1, 1, 1, 1, 1, 1, 1, 1},
		class = {
			{enable = 1, name = "WARRIOR"},
			{enable = 1, name = "ROGUE"},
			{enable = 1, name = "HUNTER"},
			{enable = 1, name = "MAGE"},
			{enable = 1, name = "WARLOCK"},
			{enable = 1, name = "PRIEST"},
			{enable = 1, name = "DRUID"},
			{enable = 1, name = "SHAMAN"},
			{enable = 1, name = "PALADIN"},
			{enable = 1, name = "DEATHKNIGHT"},
		},
		titles			= 1,
		percent			= 1,
		scale			= 0.8,
		spacing			= 0,
		buffs = {
--			enable		= nil,
			castable	= 0,
			right		= 1,
			inside		= 1,
--			untilDebuffed	= nil,			-- 2.1.3
		},
		debuffs = {
			enable		= 1,
		},
--		mana			= nil,
		healerMode = {
--			enable		= nil,
			type		= 1,
		},
		anchor			= "TOP",
	}
end

-- XPerl_RaidPet_ConfigDefault
local function XPerl_RaidPet_ConfigDefault(default, section)
	default.raidpet = {
		enable			= 1,			-- 2.1.3
		hunter			= 1,			-- 2.1.3
		warlock			= 1,			-- 2.1.3
	}
end

XPerl_RegisterConfigDefault(XPerl_Global_ConfigDefault)
XPerl_RegisterConfigDefault(XPerl_Target_ConfigDefault, "target")
XPerl_RegisterConfigDefault(XPerl_Target_ConfigDefault, "focus")
XPerl_RegisterConfigDefault(XPerl_Party_ConfigDefault)
XPerl_RegisterConfigDefault(XPerl_PartyPet_ConfigDefault)
XPerl_RegisterConfigDefault(XPerl_Player_ConfigDefault)
XPerl_RegisterConfigDefault(XPerl_Pet_ConfigDefault)
XPerl_RegisterConfigDefault(XPerl_TargetTarget_ConfigDefault, "targettargettarget")
XPerl_RegisterConfigDefault(XPerl_TargetTarget_ConfigDefault, "targettarget")
XPerl_RegisterConfigDefault(XPerl_TargetTarget_ConfigDefault, "focustarget")
XPerl_RegisterConfigDefault(XPerl_TargetTarget_ConfigDefault, "pettarget")
XPerl_RegisterConfigDefault(XPerl_Raid_ConfigDefault)
XPerl_RegisterConfigDefault(XPerl_RaidPet_ConfigDefault)


-- XPerl_DefaultGradientColours
function XPerl_DefaultGradientColours()
	return {
		enable		= 1,
--		horizontal	= nil,
		s		= {r = 0.25, g = 0.25, b = 0.25, a = 1},
		e		= {r = 0.1, g = 0.1, b = 0.1, a = 0}
	}
end

-- XPerl_DefaultReactionColours
function XPerl_DefaultReactionColours()
	return {
		enemy		= {r = 1, g = 0, b = 0},
		neutral		= {r = 1, g = 1, b = 0},
		unfriendly	= {r = 1, g = 0.5, b = 0},
		friend		= {r = 0, g = 1, b = 0},
		none		= {r = 0.5, g = 0.5, b = 1},
		tapped		= {r = 0.5, g = 0.5, b = 0.5},
	}
end

-- XPerl_DefaultBarColours
function XPerl_DefaultBarColours()
	return {
		healthEmpty	= {r = 1, g = 0, b = 0},
		healthFull	= {r = 0, g = 1, b = 0},
		mana		= {r = 0, g = 0, b = 1},
		energy		= {r = 1, g = 1, b = 0},
		rage		= {r = 1, g = 0, b = 0},
		focus		= {r = 1, g = 0.5, b = 0.25},
		runic_power	= {r = 0, g = 0.82, b = 1},
	}
end

-- XPerl_DefaultFrameAppearance
function XPerl_DefaultFrameAppearance()
	XPerlDB.transparency.frame	= 1
	XPerlDB.transparency.text	= 1
	XPerlDB.colour.border		= {r = 0.5, g = 0.5, b = 0.5, a = 1}
	XPerlDB.colour.frame		= {r = 0, g = 0, b = 0, a = 1}
end

-- XPerl_DefaultRangeFinder
function XPerl_DefaultRangeFinder()
	return {						-- 2.1.7
--		enabled		= e,	-- 2.3.4a Defaulting to OFF now, because of so many confused users complaining about faded frames. RTFM... (TODO: Write a manual)
		Main		= {enabled = true, FadeAmount = 0.5, HealthLowPoint = 0.85},		-- PlusHealth = false,
		NameFrame	= {FadeAmount = 0.5, HealthLowPoint = 0.85},
		StatsFrame	= {FadeAmount = 0.5, HealthLowPoint = 0.85},
	}
end

-- XPerl_Custom_Config_OnShow
function XPerl_Custom_Config_OnShow(self)
	if (not XPerlDB.custom) then
		XPerlDB.custom = {
			enable = true,
			alpha = 0.5,
			blend = "ADD"
		}
	end
	if (not XPerlDB.custom.zones) then
		if (not XPerl_Custom) then
			LoadAddOn("XPerl_CustomHighlight")
		end
		if (XPerl_Custom) then
			XPerl_Custom:SetDefaultZoneData()
		end
	end

	self:SetScale(1.1)
	XPerl_Custom_ConfigNew:Hide()
	self:Setup()
	XPerl_Options_Mask:Show()
	XPerl_Options_Custom_StartIconDB(self)
end

-- XPerl_Options_Custom_FillList
function XPerl_Options_Custom_FillList(self)
	if (not XPerlDB) then
		return
	end

	self.start = self.scrollBar.bar:GetValue() + 1

	local typ = self.type
	local list, source
	if (typ == "zone") then
		source = XPerlDB.custom and XPerlDB.custom.zones
	elseif (typ == "debuff") then
		local zone = XPerl_Options_Custom_SelectedZone(XPerl_Custom_Config)
		if (zone) then
			source = XPerlDB.custom and XPerlDB.custom.zones and XPerlDB.custom.zones[zone]
		end
	end

	if (source) then
		for name,key in pairs(source) do
			if (not list) then
				list = {}
			end
			tinsert(list, name)
		end
		if (list) then
			if (typ == "zone") then
				sort(list)
			elseif (typ == "debuff") then
				sort(list,
					function(a, b)
						local nameA = GetSpellInfo(a)
						local nameB = GetSpellInfo(b)
						return nameA < nameB
					end)
			end
		end
	end
	
	if (not self.selection or not list) then
		self.selection = 1
	else
		if (self.selection < 1) then
			self.selection = 1
		elseif (self.selection > #list) then
			self.selection = #list
		end
	end

	for i = 1,#self.line do
		local row = self.line[i]
		row:SetText("")
		row:UnlockHighlight()
		row:Hide()
		row.spellid = nil
	end

	local db = XPerl_Custom_Config.iconDB
	if (list) then
		local newName
		local line = 1
		for i = self.start,self.start+#self.line-1 do
			if (i > #list) then
				break
			end
			local row = self.line[line]

			if (typ == "debuff") then
				local spellid = list[i]
				local name, rank, icon = GetSpellInfo(spellid)
				if (name and icon) then
					row:SetText(format("|T%s:0|t%s", icon, name))
					row.spellid = spellid
				end
			else
				row:SetText(list[i])
			end
			row:Show()

			if (i == self.selection) then
				self.line[line]:LockHighlight()

				if (setName) then
					newName = list[i]
				end
			end

			line = line + 1
		end

		local offset = self.scrollBar.bar:GetValue()
		if (FauxScrollFrame_Update(self.scrollBar, #list, 12, 1)) then
			self.scrollBar:Show()
		else
			self.scrollBar:Hide()
		end
	else
		self.scrollBar:Hide()
	end
end

-- XPerl_Options_Custom_OnClick
function XPerl_Options_Custom_OnClick(self, line)
	if (self.type == "zone") then
		XPerl_Options_Custom_FillList(XPerl_Custom_Configdebuffs)
		if (XPerl_Custom_ConfigNew:IsShown()) then
			local zone = XPerl_Options_Custom_SelectedZone(XPerl_Custom_Config)
			if (zone) then
				XPerl_Custom_ConfigNew_Zone:SetText(zone)
			end
		end

	elseif (self.type == "debuff") then
		XPerl_Options_Custom_SetIcon()
	end

	XPerl_Options_Custom_Buttons(XPerl_Custom_Config)
end

-- XPerl_Options_Custom_SetIcon
function XPerl_Options_Custom_SetIcon()
	self = XPerl_Custom_Config
	local name = XPerl_Custom_Configdebuffs.debuff
	local db = self.iconDB
	if (db and name) then
		local spellid = db and db[name]
		if (spellid) then
			local spellname, rank, icon = GetSpellInfo(spellid)
			if (icon) then
				XPerl_Custom_Config.icon:SetTexture(icon)
				XPerl_Custom_Config.icon:Show()
				return
			end
		end
	end
end

-- XPerl_Options_Custom_InitList
function XPerl_Options_Custom_InitList(self, type)
	self:GetParent()["list"..type] = self
	self.type = type
	self.start = 1
	self.selection = 1
	self.scrollBar = _G[self:GetName().."scrollBar"]
	self.scrollBar.bar = _G[self:GetName().."scrollBarScrollBar"]
	self.FillList = XPerl_Options_Custom_FillList
	self.OnClick = XPerl_Options_Custom_OnClick
	self:FillList()
	
	if (type == "debuff") then
		self.debuff = nil
		if (self.line[1]:IsShown()) then
			self.debuff = self.line[1]:GetText()
			XPerl_Options_Custom_SetIcon()
		end
	end
end

-- customOnUpdate
local ICON_STEP_SIZE	= 500
local ICON_STOP_SCAN	= 80000
local function customOnUpdate(self, elspsed)
	local db = self.iconDB
	local ind = self.iconIndex
	for i = ind,ind + ICON_STEP_SIZE - 1 do
		if (GetSpellLink(i)) then									-- Filter out talents
			local name, rank, icon = GetSpellInfo(i)
			if (name and icon ~= "Interface\\Icons\\Temp") then		-- Filter out silly test ones
				name = strlower(name)
				local old = db[name]
				if (old) then										-- Only keep highest of ranked spells
					local name2, rank2, icon2 = GetSpellInfo(old)
					local num1 = strmatch("(%d+)", rank) or 0
					local num2 = strmatch("(%d+)", rank2) or 0
					num1 = num1 == "" and 0 or num1+0
					num2 = num2 == "" and 0 or num2+0
					if (num2 > num1) then
						db[name] = i
					end
				else
					db[name] = i
				end
			end
		end
	end

	self.iconIndex = self.iconIndex + ICON_STEP_SIZE
	self.progress:SetValue(self.iconIndex)
	if (self.iconIndex > ICON_STOP_SCAN) then
		self:SetScript("OnUpdate", nil)
		self.progress:SetValue(0)
		XPerl_Options_Custom_FillList(XPerl_Custom_Configdebuffs)
	end

	local search = XPerl_Custom_ConfigNew_Search:GetText()
	if (search and strlen(search) > 2) then
		XPerl_Options_Custom_ScanForIcons(XPerl_Custom_Config)
	end
end

-- XPerl_Options_Custom_StartIconDB
function XPerl_Options_Custom_StartIconDB(self)
	self:SetScript("OnUpdate", customOnUpdate)
	local db = XPerl_GetReusableTable()
	self.iconDB = db
	self.iconIndex = 0
	self.progress:SetMinMaxValues(0, ICON_STOP_SCAN)
	self.progress:SetValue(0)
end

-- XPerl_Options_Custom_CleanupIconDB
function XPerl_Options_Custom_CleanupIconDB(self)
	XPerl_FreeTable(self.iconDB, true)
end

-- XPerl_Options_Custom_StartIconDB
function XPerl_Options_Custom_ScanForIcons(self)
	local search = XPerl_Custom_ConfigNew_Search:GetText()
	if (search and strlen(search) > 2) then
		search = strlower(search)
		local dbname = self.iconDB and self.iconDB
		if (dbname) then
			local list = XPerl_GetReusableTable()
			for name,id in pairs(dbname) do
				local success, ret = pcall(strfind, name, search)
				if (success and ret) then
					tinsert(list, id)
					if (#list > 50) then
						break
					end
				end
			end

			if (not self.icons.icon) then
				self.icons.icon = {}
			end

			local count = min(#list, 18)
			local iconNum = 1
			for i,spellid in ipairs(list) do
				local spellid = list[i]
				local icon = self.icons.icon[iconNum]
				if (not icon) then
					icon = CreateFrame("Button", "XPerlOptionsCustomIcon"..iconNum, XPerl_Custom_ConfigNew_Icons, "ActionButtonTemplate")
					self.icons.icon[iconNum] = icon
					icon.tex = _G[icon:GetName().."Icon"]

					icon:SetScript("OnClick",
						function(self)
							if (IsModifiedClick("CHATLINK")) then
								local link = GetSpellLink(self.spellid)
								if (link) then
									ChatEdit_InsertLink(link)
								end
							else
								local zone = XPerl_Custom_ConfigNew_Zone:GetText()
								if (zone and zone ~= "") then
									local zones = XPerlDB.custom.zones
									if (not zones[zone]) then
										zones[zone] = {}
									end
									zones[zone][self.spellid] = true
									XPerl_Custom_ConfigNew:Hide()
									XPerl_Custom_Config.listzone:FillList()
									XPerl_Custom_Config.listdebuff:FillList()

									if (XPerl_Custom) then
										XPerl_Custom:PLAYER_ENTERING_WORLD()
									end
								end
							end
						end)
					icon:SetScript("OnEnter",
						function(self)
							GameTooltip:SetOwner(self, "ANCHOR_TOP")
							local link = GetSpellLink(self.spellid)
							local name, rank, icon = GetSpellInfo(self.spellid)
							if (link) then
								GameTooltip:SetHyperlink(link)
							else
								GameTooltip:SetText(name, 1, 1, 1)
							end

							if (rank and rank ~= "") then
								GameTooltipTextRight1:SetText(rank)
								GameTooltipTextRight1:SetTextColor(0.5, 0.5, 0.5)
								GameTooltipTextRight1:Show()
								GameTooltip:Show()
							end
						end)
					icon:SetScript("OnLeave",
						function(self)
							GameTooltip:Hide()
						end)

					if (iconNum == 1) then
						icon:SetPoint("TOPLEFT")
					elseif (iconNum == 10) then
						icon:SetPoint("TOPLEFT", self.icons.icon[1], "BOTTOMLEFT", 0, -9)
					else
						icon:SetPoint("TOPLEFT", self.icons.icon[iconNum - 1], "TOPRIGHT", 9, 0)
					end
				end

				local name, rank, tex = GetSpellInfo(spellid)
				if (tex) then
					icon.spellid = spellid
					icon.tex:SetTexture(tex)
					icon:Show()
					if (GameTooltip:IsOwned(icon)) then
						icon:GetScript("OnEnter")(icon)
					end
					iconNum = iconNum + 1
				end

				if (iconNum > 18) then
					break
				end
			end

			for i = #list + 1,18 do
				local icon = self.icons.icon[i]
				if (icon) then
					icon:Hide()
				end
			end

			self.icons:Show()

			XPerl_FreeTable(list)
			return
		end
	end

	self.icons:Hide()
end

-- XPerl_Options_Custom_OnDelete
function XPerl_Options_Custom_OnDelete(self)
	local zone = XPerl_Options_Custom_SelectedZone(self)
	local spellid = XPerl_Options_Custom_SelectedDebuff(self)
	if (zone and spellid) then
		zones = XPerlDB.custom.zones
		if (zones and zones[zone]) then
			zones[zone][spellid] = nil

			if (not next(zones[zone])) then
				zones[zone] = nil
			end

			XPerl_Custom_Config.listzone:FillList()
			XPerl_Custom_Config.listdebuff:FillList()

			XPerl_Options_Custom_Buttons(XPerl_Custom_Config)
		end
	end
end

-- XPerl_Options_Custom_SelectedZone
function XPerl_Options_Custom_SelectedZone(self)
	local sel = self.listzone.selection
	if (sel) then
		local row = self.listzone.line[sel]
		if (row) then
			return row:GetText()
		end
	end
end

-- XPerl_Options_Custom_SelectedDebuff
function XPerl_Options_Custom_SelectedDebuff(self)
	if (XPerl_Options_Custom_SelectedZone(self)) then
		local sel = self.listdebuff.selection
		if (sel) then
			local row = self.listdebuff.line[sel]
			if (row) then
				return row.spellid
			end
		end
	end
end

-- XPerl_Options_Custom_Buttons
function XPerl_Options_Custom_Buttons(self)
	local zone = XPerl_Options_Custom_SelectedZone(self)
	local spellid = XPerl_Options_Custom_SelectedDebuff(self)
	if (zone and spellid) then
		XPerl_Custom_ConfigEdit_Delete:Enable()
	else
		XPerl_Custom_ConfigEdit_Delete:Disable()
	end
end


----------------------------------------------
-------------- UPGRADE SETTINGS --------------
----------------------------------------------

if (XPerl_UpgradeSettings) then
	local flist = {"player", "pet", "target", "targettarget", "pettarget", "focus", "focustarget", "targettargettarget", "party", "partypet"}
	-- UpgradeSettings
	-- For future upgrade of settings from old versions
	local function UpgradeSettings(old, oldVersion)
		if (not old.pet) then
			old.pet = {}
			XPerl_Pet_ConfigDefault(old)
		elseif (not old.pet.castBar) then
			old.pet.castBar = {enable = 1}
		end

		local playerClass = select(2, UnitClass("player"))

		if (type(oldVersion) == "string") then
			for k,v in pairs(flist) do
				if (old[v]) then
					if (not old[v].buffs) then
						old[v].buffs = {enable = 1, size = 20, bigpet = 1, wrap = 1}
					elseif (not old[v].buffs.size) then
						old[v].buffs.size = 20
					end
					if (not old[v].debuffs) then
						old[v].debuffs = {enable = 1, size = 20, bigpet = 1, wrap = 1}
					elseif (not old[v].debuffs.size) then
						old[v].debuffs.size = 20
					end
				end
			end

			if (not old.colour.bar.runic_power or old.colour.bar.runic_power[1]) then
				if (PowerBarColor) then
					old.colour.bar.runic_power	= {r = PowerBarColor["RUNIC_POWER"].r, g = PowerBarColor["RUNIC_POWER"].g, b = PowerBarColor["RUNIC_POWER"].b}
				else
					old.colour.bar.runic_power	= {r = 1, g = 0.25, b = 1}
				end
			end

			ValidateClassNames(old.raid)

			if (old.bar and old.bar.texture and old.bar.texture[1] == "X-Perl 2") then
				old.bar.texture[1] = "BantoBar"
			end

			if (oldVersion < "3.0.3b") then
				old.buffs.names = true
			end

			if (oldVersion < "3.0.3a") then
				old.target.buffs.bigpet = 1
				old.targettarget.buffs.bigpet = 1
				old.targettargettarget.buffs.bigpet = 1
				old.focus.buffs.bigpet = 1
				old.focustarget.buffs.bigpet = 1
				old.pet.buffs.bigpet = 1
				old.pettarget.buffs.bigpet = 1
				old.party.buffs.bigpet = 1
			end

			if (oldVersion < "3.0.2") then
				old.focus.threat = old.target.threat
				old.focus.threatMode = old.focus.portrait and old.target.threatMode or "nameFrame"
				old.party.threat = old.target.threat
				old.party.threatMode = old.party.portait and old.target.threatMode or "nameFrame"
			end

			if (oldVersion < "3.0.0c") then
				old.target.threat = 1
				old.target.threatMode = "portraitFrame"
				old.focus.threat = 1
				old.focus.threatMode = "portraitFrame"
				old.party.threat = 1
				old.party.threatMode = "portraitFrame"
				old.pet.threat = 1
				old.pet.threatMode = "portraitFrame"
			end

			if (oldVersion < "3.0.0") then
				old.player.showRunes = 1
				old.player.dockRunes = 1
			end

			if (oldVersion < "2.4.2c") then
				old.highlight.sparkles = 1
				old.highlight.POM = old.highlight.HOT
			end

			if (oldVersion <= "2.4.2") then
				if (old.custom) then
					old.custom.alpha = 0.5
					old.custom.blend = "ADD"
				end
			end

			if (not old.custom) then
				old.custom = {
					enable = true,
					alpha = 0.5,
					blend = "ADD"
				}
			end

			if (oldVersion <= "2.4.0c") then
				old.target.ownDamageOnly = true
				old.focus.ownDamageOnly = true
			end

			if (oldVersion <= "2.3.9a") then
				old.player.debuffs.enable = old.player.buffs.enable
			end

			if (oldVersion <= "2.3.9") then
				old.showReadyCheck = 1
			end

			if (oldVersion <= "2.3.6a") then
				old.target.buffs.wrap = 1
				old.targettarget.buffs.wrap = 1
				old.targettargettarget.buffs.wrap = 1
				old.pettarget.buffs.wrap = 1
				old.focus.buffs.wrap = 1
				old.focustarget.buffs.wrap = 1
				old.party.buffs.wrap = 1

				-- These should have been defaulted to OFF, oops
				old.targettarget.debuffs.big = nil
				old.targettargettarget.debuffs.big = nil
				old.focustarget.debuffs.big = nil
				old.pettarget.debuffs.big = nil
			end
			if (oldVersion <= "2.3.6") then
				old.target.debuffs.big = 1
				old.focus.debuffs.big = 1
				old.player.buffs.rows = 2
				old.party.buffs.rows = 2
			end

			if (oldVersion < "2.3.5") then
				old.target.range30yard	= nil
				old.focus.range30yard	= nil
				old.party.range30yard	= nil
				old.raid.manaPercent = 1

				old.highlight.MISSING = nil
				if (playerClass == "PRIEST" or playerClass == "DRUID" or playerClass == "PALADIN" or playerClass == "SHAMAN") then
					old.highlight.HOTCOUNT = 1
				end
			end

			if (oldVersion < "2.3.4a") then
				old.tooltip.enableBuffs = 1
			end
		end
	end

	-- XPerl_Options_UpgradeSettings()
	function XPerl_Options_UpgradeSettings()
		local oldVersion = XPerlConfigNew.ConfigVersion

		-- Global config upgrade checks here:
		if (type(oldVersion) == "string" and oldVersion < "2.3.2d") then
			if (XPerlConfigNew.savedPositions and XPerlConfigNew.savedPositions.current) then
				for name,settings in pairs(XPerlConfigNew.savedPositions) do
					if (name ~= "saved" and name ~= "current") then
						if (not XPerlConfigNew.savedPositions.saved) then
							XPerlConfigNew.savedPositions.saved = {}
						end
						XPerlConfigNew.savedPositions.saved[name] = settings
						XPerlConfigNew.savedPositions[name] = nil
					end
				end

				local realm, name = GetRealmName(), UnitName("player")
				if (not XPerlConfigNew.savedPositions[realm]) then
					XPerlConfigNew.savedPositions[realm] = {}
				end
				XPerlConfigNew.savedPositions[realm][name] = XPerlConfigNew.savedPositions.current
				XPerlConfigNew.savedPositions.current = nil
			end
		end

		for realmName,realmList in pairs(XPerlConfigNew) do
			if (type(realmList) == "table" and realmName ~= "global" and realmName ~= "savedPositions") then
				for playerName,settings in pairs(realmList) do
					if (playerName == "global") then
						-- Fix global settings being put in with realms
						if (not XPerlConfigNew.global) then
							XPerlConfigNew.global = settings
							UpgradeSettings(settings, oldVersion)
						end
						realmList.global = nil
					else
						UpgradeSettings(settings, oldVersion)
					end
				end
			end
		end

		UpgradeSettings = nil
		XPerl_Options_UpgradeSettings = nil
		flist = nil
	end
end
