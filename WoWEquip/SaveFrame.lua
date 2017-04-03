----------------------------------------------------------------------------------------
-- WoWEquip file for the Save/Load/Send/Compare Frame

local WoWEquip = LibStub("AceAddon-3.0"):GetAddon("WoWEquip")
local L = LibStub("AceLocale-3.0"):GetLocale("WoWEquip", false)


----------------------------------------------------------------------------------------
-- Constants

local WOWEQUIP_PROFILES_SHOWN = 10
local WOWEQUIP_PROFILES_DISP_WIDTH = 300 - 26
local WOWEQUIP_PROFILES_DISP_HEIGHT = 13
local VALID_VERSIONS = {
	v1 = true,
}


----------------------------------------------------------------------------------------
-- Local Variables

local profiles = {}
local inputName = ""
local rightClickProfileName
local lastSendName = ""


----------------------------------------------------------------------------------------
-- Local Widget Functions

local function WoWEquip_ProfilesScrollFrame_Update(self)
	local numProfiles = #profiles
	local t = WoWEquip_SaveFrame.ProfileButtonAr
	self.highlight:Hide()

	FauxScrollFrame_Update(self, numProfiles, WOWEQUIP_PROFILES_SHOWN, WOWEQUIP_PROFILES_DISP_HEIGHT, nil, nil, nil, self.highlight, WOWEQUIP_PROFILES_DISP_WIDTH, WOWEQUIP_PROFILES_DISP_WIDTH + 16)
	for i = 1, WOWEQUIP_PROFILES_SHOWN do
		local profileIndex = i + FauxScrollFrame_GetOffset(self)
		local button = t[i]
		
		if profileIndex <= numProfiles then
			local name = profiles[profileIndex].name
			button:SetText(name)
			button:SetID(profileIndex)

			if name == inputName then
				self.highlight:Show()
				self.highlight:SetPoint("TOPLEFT", button)
			end
			button:Show()
		else
			button:Hide()
		end
	end

	if numProfiles > WOWEQUIP_PROFILES_SHOWN then
		-- Reduce width
		for i = 1, WOWEQUIP_PROFILES_SHOWN do
			t[i]:SetWidth(WOWEQUIP_PROFILES_DISP_WIDTH)
			t[i].string:SetWidth(WOWEQUIP_PROFILES_DISP_WIDTH)
		end
	else
		-- Increase width
		for i = 1, WOWEQUIP_PROFILES_SHOWN do
			t[i]:SetWidth(WOWEQUIP_PROFILES_DISP_WIDTH + 16)
			t[i].string:SetWidth(WOWEQUIP_PROFILES_DISP_WIDTH + 16)
		end
	end
end

local function WoWEquip_ProfilesButton_OnClick(self, button, down)
	if button == "LeftButton" then
		-- Set current button/profile as selected
		inputName = profiles[self:GetID()].name
		if WoWEquip_SaveFrame.mode ~= "send" then
			-- Note that this will trigger WoWEquip_SaveFrame.NameInputBox:OnTextChanged() to run...
			WoWEquip_SaveFrame.NameInputBox:SetText(profiles[self:GetID()].name)
		end
		-- ... unless it is hidden because the dialog is in load/compare mode
		if not WoWEquip_SaveFrame.NameInputBox:IsVisible() or WoWEquip_SaveFrame.mode == "send" then
			WoWEquip:UpdateProfilesList(true)
		end
	elseif button == "RightButton" then
		if self:GetRight() >= GetScreenWidth() * 3/4 then
			WoWEquip_DropDownMenu.point = "TOPRIGHT"
			WoWEquip_DropDownMenu.relativePoint = "TOPLEFT"
		else
			WoWEquip_DropDownMenu.relativePoint = "TOPRIGHT"
		end
		WoWEquip_DropDownMenu.OnClick(self, button, down)
		WoWEquip_DropDownMenu.point = nil
		WoWEquip_DropDownMenu.relativePoint = nil
	end
end

local function WoWEquip_ProfilesButton_OnEnter(self)
	local desc = profiles[self:GetID()].desc
	if self:GetRight() >= GetScreenWidth() * 3/4 then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	if desc and desc ~= "" then
		GameTooltip:SetText(L["Description/Notes:"])
		GameTooltip:AddLine(desc, 1, 1, 1, 1)
	else
		GameTooltip:SetText(L["(No description)"])
	end
	GameTooltip:Show()
end


----------------------------------------------------------------------------------------
-- Save Frame Functions

function WoWEquip:UpdateSaveFrameMode(mode)
	local WoWEquip_SaveFrame = WoWEquip_SaveFrame
	WoWEquip_SaveFrame.mode = mode
	WoWEquip_SaveFrame.SaveButton:SetScript("OnClick", WoWEquip_SaveFrame.SaveButton[mode])
	if mode == "save" then
		WoWEquip_SaveFrame.titleText:SetText(L["Save Profile"])
		WoWEquip_SaveFrame.SaveButton:SetText(L["Save"])
		WoWEquip_SaveFrame.NameInputBox:SetText(self.curProfile.name)
		WoWEquip_SaveFrame.DescInputBox:SetText(self.curProfile.desc)
		WoWEquip_SaveFrame.NameText:Show()
		WoWEquip_SaveFrame.NameInputFrame:Show()
		WoWEquip_SaveFrame.DescText:Show()
		WoWEquip_SaveFrame.DescFrame:Show()
		WoWEquip_SaveFrame.ProfilesText:SetPoint("TOPLEFT", WoWEquip_SaveFrame.DescFrame, "BOTTOMLEFT", 0, 0)
		WoWEquip_SaveFrame:SetHeight(354)
	elseif mode == "load" then
		WoWEquip_SaveFrame.titleText:SetText(L["Load Profile"])
		WoWEquip_SaveFrame.SaveButton:SetText(L["Load"])
		WoWEquip_SaveFrame.NameText:Hide()
		WoWEquip_SaveFrame.NameInputFrame:Hide()
		WoWEquip_SaveFrame.DescText:Hide()
		WoWEquip_SaveFrame.DescFrame:Hide()
		WoWEquip_SaveFrame.ProfilesText:SetPoint("TOPLEFT", 25, -32)
		WoWEquip_SaveFrame:SetHeight(232)
	elseif mode == "compare" then
		WoWEquip_SaveFrame.titleText:SetText(L["Compare Profile"])
		WoWEquip_SaveFrame.SaveButton:SetText(L["Compare"])
		WoWEquip_SaveFrame.NameText:Hide()
		WoWEquip_SaveFrame.NameInputFrame:Hide()
		WoWEquip_SaveFrame.DescText:Hide()
		WoWEquip_SaveFrame.DescFrame:Hide()
		WoWEquip_SaveFrame.ProfilesText:SetPoint("TOPLEFT", 25, -32)
		WoWEquip_SaveFrame:SetHeight(232)
	elseif mode == "send" then
		WoWEquip_SaveFrame.titleText:SetText(L["Send Profile"])
		WoWEquip_SaveFrame.SaveButton:SetText(L["Send"])
		WoWEquip_SaveFrame.NameText:Show()
		WoWEquip_SaveFrame.NameInputFrame:Show()
		WoWEquip_SaveFrame.DescText:Hide()
		WoWEquip_SaveFrame.DescFrame:Hide()
		WoWEquip_SaveFrame.ProfilesText:SetPoint("TOPLEFT", WoWEquip_SaveFrame.NameInputFrame, "BOTTOMLEFT", 0, 0)
		WoWEquip_SaveFrame:SetHeight(266)
		WoWEquip_SaveFrame.NameInputBox:SetText(lastSendName)
		
	end
	self:UpdateProfilesList()
end

function WoWEquip.SortProfileList(a, b)
	return a.name < b.name
end

function WoWEquip:UpdateProfilesList(skipRegenerate)
	if not skipRegenerate then
		local count = 0
		wipe(profiles)
		for k, v in pairs(self.db.global.profiles) do
			count = count + 1
			profiles[count] = v
		end
		sort(profiles, self.SortProfileList)
	end

	-- Disable the Save/Load/Send/Compare button first, except for Save mode which is enabled
	if WoWEquip_SaveFrame.mode == "save" and #inputName:trim() > 0 then
		WoWEquip_SaveFrame.SaveButton:Enable()
	else
		WoWEquip_SaveFrame.SaveButton:Disable()
	end

	-- Check if the Load/Send/Compare button should be enabled
	for i = 1, #profiles do
		if profiles[i].name == inputName then
			if WoWEquip_SaveFrame.mode ~= "send" or #WoWEquip_SaveFrame.NameInputBox:GetText():trim() > 0 then
				WoWEquip_SaveFrame.SaveButton:Enable()
			end
			break
		end
	end

	WoWEquip_ProfilesScrollFrame_Update(WoWEquip_ProfilesScrollFrame)
end

function WoWEquip:DeleteProfile(name)
	self.db.global.profiles[name] = nil
end

function WoWEquip:RenameProfile(oldname, newname)
	assert(newname ~= "", "Cannot use an empty string for profile name.")
	local t = self.db.global.profiles
	local old = t[oldname]
	local new = t[newname]
	if new then
		self:Print(L["Rename unsuccessful. A profile of that name already exists."])
	elseif old then
		t[newname] = old
		t[newname].name = newname
		t[oldname] = nil
	end
end

function WoWEquip:LoadProfile(name)
	local loadTable = self.db.global.profiles[name]
	if not loadTable then return end
	local t = self.curProfile

	t.name = loadTable.name
	t.desc = loadTable.desc
	t.class = loadTable.class
	t.race = loadTable.race
	t.level = loadTable.level
	for slotname, button in pairs(self.PaperDoll) do
		self:UpdateSlot(slotname, loadTable.eq[slotname], true)
	end
	self.frame.BonusFrame.LevelInputBox:SetText(loadTable.level)
	--WoWEquip_ClassButton:SetText(WoWEquip_ClassOptions[currentProfileClass].t)
	--WoWEquip_RaceButton:SetText(WoWEquip_RaceOptions[currentProfileRace].t2)
	self:UpdateBonusFrame()
	self:UpdateDressUpModel()
	CloseDropDownMenus()
end

function WoWEquip:SaveProfile(name, desc)
	assert(name ~= "", "Cannot use an empty string for profile name.")
	local db = self.db.global
	db.profiles[name] = db.profiles[name] or {}
	local saveTable = db.profiles[name]
	local t = self.curProfile

	saveTable.name = name
	saveTable.desc = desc
	saveTable.class = t.class
	saveTable.race = t.race
	saveTable.level = t.level
	saveTable.eq = saveTable.eq or {}
	for slotname, button in pairs(self.PaperDoll) do
		saveTable.eq[slotname] = t.eq[slotname]
	end

	-- Load edited name and desc
	t.name = name
	t.desc = desc
	CloseDropDownMenus()

	if name == db.CompareProfile then
		self:UpdateBonusFrame()
	end
end

function WoWEquip:SendProfile(name, target)
	local version = "v1"
	local t = self.db.global.profiles[name]
	if t then
		self:SendCommMessage("WoWEquipProfile", self:Serialize(version, t), "WHISPER", target)
		self:Print(format(L["Profile \34%s\34 sent to %s."], name, target))
	end
end

function WoWEquip:OnProfileReceive(prefix, message, distribution, sender)
	if prefix ~= "WoWEquipProfile" then return end
	local db = self.db.global.profiles
	local success, version, t = self:Deserialize(message)
	if not success then return end

	-- Verify data received
	if not VALID_VERSIONS[version] then return end -- Only accept "v1" data
	if type(t) ~= "table" then return end
	if type(t.name) ~= "string" then return end
	if type(t.desc) ~= "string" then return end
	if type(t.class) ~= "string" then return end
	if type(t.race) ~= "string" then return end
	if type(t.level) ~= "number" then return end
	if type(t.eq) ~= "table" then return end
	for k, v in pairs(t.eq) do
		-- Check k is a valid slot and v is a valid link
		if not self.PaperDoll[k] or not strfind(v, "^|c%x+|Hitem:%d+:%d+:%d+:%d+:%d+:%d+:[-]?%d+:[-]?%d+:%d+|h%[.-%]|h|r$") then
			return
		end
	end

	-- Save the received profile, using a different name if necessary by appending a number
	if not db[t.name] then
		db[t.name] = t
	else
		local i = 1
		while db[t.name.."-"..i] do 
			i = i + 1
		end
		t.name = t.name.."-"..i
		db[t.name] = t
	end
	self:Print(format(L["Profile \34%s\34 received successfully from %s"], t.name, sender))
end

function WoWEquip.RenameProfileWarn(dropdownbutton, arg1, arg2, checked)
	if WoWEquip.db.global.profiles[arg1] then
		rightClickProfileName = arg1
		StaticPopup_Hide("WOWEQUIP_CONFIRM_OVERWRITE")
		StaticPopup_Hide("WOWEQUIP_CONFIRM_DELETE")
		StaticPopup_Show("WOWEQUIP_CONFIRM_RENAME", arg1)
	end
end

function WoWEquip.DeleteProfileWarn(dropdownbutton, arg1, arg2, checked)
	if WoWEquip.db.global.profiles[arg1] then
		rightClickProfileName = arg1
		StaticPopup_Hide("WOWEQUIP_CONFIRM_OVERWRITE")
		StaticPopup_Hide("WOWEQUIP_CONFIRM_RENAME")
		StaticPopup_Show("WOWEQUIP_CONFIRM_DELETE", arg1)
	end
end

function WoWEquip.ProfileOptionsMenu(self, level)
	if not level then return end
	local info = self.info
	wipe(info)
	local name = profiles[self.owner:GetID()].name
	if level == 1 then
		info.isTitle = 1
		info.notCheckable = 1
		info.text = name
		UIDropDownMenu_AddButton(info, level)

		info.disabled = nil
		info.isTitle = nil

		-- Rename profile menu item
		info.text = L["Rename"]
		info.arg1 = name
		info.func = WoWEquip.RenameProfileWarn
		UIDropDownMenu_AddButton(info, level)

		-- Delete profile menu item
		info.text = L["Delete"]
		info.arg1 = name
		info.func = WoWEquip.DeleteProfileWarn
		UIDropDownMenu_AddButton(info, level)

		-- Close menu item
		info.text = CLOSE
		info.func = self.HideMenu
		UIDropDownMenu_AddButton(info, level)
	end
end


-------------------------------------------------
-- StaticPopups for Deleting/Overwriting profiles

StaticPopupDialogs.WOWEQUIP_CONFIRM_OVERWRITE = {
	text = L["Overwrite the following profile?\n%s"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		local name = strtrim(inputName)
		local desc = strtrim(WoWEquip_SaveFrame.DescInputBox:GetText())
		WoWEquip:SaveProfile(name, desc)
		WoWEquip_SaveFrame:Hide()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
}
StaticPopupDialogs.WOWEQUIP_CONFIRM_DELETE = {
	text = L["Delete the following profile?\n%s"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		if WoWEquip.db.global.profiles[rightClickProfileName] then
			WoWEquip:DeleteProfile(rightClickProfileName)
			WoWEquip:UpdateProfilesList()
			WoWEquip:VerifyCompareProfile()
		end
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
}
StaticPopupDialogs.WOWEQUIP_CONFIRM_RENAME = {
	text = L["Rename the following profile?\n%s"],
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	maxLetters = 100,
	hasWideEditBox = 1,
	OnAccept = function(self)
		local newname = strtrim(self.wideEditBox:GetText())
		if newname ~= "" then
			WoWEquip:RenameProfile(rightClickProfileName, newname)
			WoWEquip:UpdateProfilesList()
			WoWEquip:VerifyCompareProfile()
		else
			WoWEquip:Print(L["Rename unsuccessful. Cannot rename to nothing."])
		end
	end,
	OnShow = function(self)
		self.wideEditBox:SetText(rightClickProfileName)
		self.wideEditBox:SetFocus()
	end,
	OnHide = function(self)
		local activeWindow = ChatEdit_GetActiveWindow and ChatEdit_GetActiveWindow() or ChatFrameEditBox -- For pre-3.3.5 compat
		if activeWindow and activeWindow:IsShown() then
			activeWindow:SetFocus()
		end
		self.wideEditBox:SetText("")
	end,
	EditBoxOnEnterPressed = function(self)
		local parent = self:GetParent()
		local newname = strtrim(parent.wideEditBox:GetText())
		if newname ~= "" then
			WoWEquip:RenameProfile(rightClickProfileName, newname)
			WoWEquip:UpdateProfilesList()
			WoWEquip:VerifyCompareProfile()
		else
			WoWEquip:Print(L["Rename unsuccessful. Cannot rename to nothing."])
		end
		parent:Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
}


----------------------------------------------------------------------------------------
-- Create the frames used by the Save Frame window

do
	-- Create the main Save/Load frame
	local WoWEquip_SaveFrame = CreateFrame("Frame", "WoWEquip_SaveFrame", WoWEquip_Frame)
	WoWEquip_SaveFrame:Hide()
	WoWEquip_SaveFrame:SetWidth(350)
	WoWEquip_SaveFrame:SetHeight(354)
	WoWEquip_SaveFrame:EnableMouse(true)
	WoWEquip_SaveFrame:SetToplevel(true)
	WoWEquip_SaveFrame:SetClampedToScreen(true)
	WoWEquip_SaveFrame:SetMovable(true)
	local f = WoWEquip_SaveFrame

	-- Textures
	local temp = f:CreateTexture(nil, "BACKGROUND")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Title-Background]])
	temp:SetPoint("TOPLEFT", 9, -6)
	temp:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", -28, -24)
	f.titlebg = temp

	temp = f:CreateTexture(nil, "BACKGROUND")
	temp:SetTexture([[Interface\Buttons\WHITE8X8]])
	temp:SetPoint("TOPLEFT", 8, -24)
	temp:SetPoint("BOTTOMRIGHT", -6, 8)
	temp:SetVertexColor(0, 0, 0, .75)
	f.bg = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetHeight(64)
	temp:SetPoint("TOPLEFT")
	temp:SetTexCoord(0.501953125, 0.625, 0, 1)
	f.topleft = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetHeight(64)
	temp:SetPoint("TOPRIGHT")
	temp:SetTexCoord(0.625, 0.75, 0, 1)
	f.topright = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetHeight(64)
	temp:SetPoint("TOPLEFT", f.topleft, "TOPRIGHT")
	temp:SetPoint("TOPRIGHT", f.topright, "TOPLEFT")
	temp:SetTexCoord(0.25, 0.369140625, 0, 1)
	f.top = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetHeight(64)
	temp:SetPoint("BOTTOMLEFT")
	temp:SetTexCoord(0.751953125, 0.875, 0, 1)
	f.bottomleft = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetHeight(64)
	temp:SetPoint("BOTTOMRIGHT")
	temp:SetTexCoord(0.875, 1, 0, 1)
	f.bottomright = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetHeight(64)
	temp:SetPoint("BOTTOMLEFT", f.bottomleft, "BOTTOMRIGHT")
	temp:SetPoint("BOTTOMRIGHT", f.bottomright, "BOTTOMLEFT")
	temp:SetTexCoord(0.376953125, 0.498046875, 0, 1)
	f.bottom = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetPoint("TOPLEFT", f.topleft, "BOTTOMLEFT")
	temp:SetPoint("BOTTOMLEFT", f.bottomleft, "TOPLEFT")
	temp:SetTexCoord(0.001953125, 0.125, 0, 1)
	f.left = temp

	temp = f:CreateTexture(nil, "BORDER")
	temp:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-Border]])
	temp:SetWidth(64)
	temp:SetPoint("TOPRIGHT", f.topright, "BOTTOMRIGHT")
	temp:SetPoint("BOTTOMRIGHT", f.bottomright, "TOPRIGHT")
	temp:SetTexCoord(0.1171875, 0.2421875, 0, 1)
	f.right = temp

	temp = f:CreateFontString(nil, "ARTWORK")
	temp:SetFontObject(GameFontNormal)
	temp:SetPoint("TOPLEFT", 12, -8)
	temp:SetPoint("TOPRIGHT", -32, -8)
	f.titleText = temp

	WoWEquip_SaveFrame:SetScript("OnHide", function(self)
		StaticPopup_Hide("WOWEQUIP_CONFIRM_OVERWRITE")
		StaticPopup_Hide("WOWEQUIP_CONFIRM_DELETE")
		StaticPopup_Hide("WOWEQUIP_CONFIRM_RENAME")
	end)
	WoWEquip.SaveFrame = WoWEquip_SaveFrame

	-- This creates a transparent textureless draggable frame to move WoWEquip_SaveFrame
	-- It overlaps the above title text and texture (more or less) exactly.
	temp = CreateFrame("Button", nil, f)
	temp:SetPoint("TOPLEFT", f.titlebg)
	temp:SetPoint("BOTTOMRIGHT", f.titlebg)
	temp:EnableMouse(true)
	temp:RegisterForDrag("LeftButton")
	temp:SetScript("OnDragStart", WoWEquip.Generic_StartMoving)
	temp:SetScript("OnDragStop", WoWEquip.Generic_StopMovingOrSizing)
	f.dragFrame = temp

	-- Create the Close button
	temp = CreateFrame("Button", nil, f, "UIPanelCloseButton")
	temp:SetPoint("TOPRIGHT", 2, 1)
	temp:SetScript("OnClick", WoWEquip.Generic_Hide)
	temp:SetHitRectInsets(5, 5, 5, 5)
	f.CloseButton = temp

	-- Create and position the Name text string
	WoWEquip_SaveFrame.NameText = WoWEquip_SaveFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	WoWEquip_SaveFrame.NameText:SetPoint("TOPLEFT", 25, -32)
	WoWEquip_SaveFrame.NameText:SetText(L["Name:"])

	-- Create the Search Input Box and position it below the text
	temp = CreateFrame("Frame", nil, WoWEquip_SaveFrame)
	temp:SetWidth(300)
	temp:SetHeight(24)
	temp:SetBackdrop(WoWEquip.WOWEQUIP_BOX_BACKDROP2)
	temp:SetPoint("TOPLEFT", WoWEquip_SaveFrame.NameText, "BOTTOMLEFT", 0, 0)
	WoWEquip_SaveFrame.NameInputFrame = temp
	temp = CreateFrame("EditBox", nil, temp)
	temp:SetWidth(290)
	temp:SetHeight(24)
	temp:SetMaxLetters(100)
	temp:SetNumeric(false)
	temp:SetAutoFocus(false)
	temp:SetFontObject("GameFontHighlightSmall")
	temp:SetPoint("TOPLEFT", 5, 1)
	temp:SetScript("OnShow", temp.SetFocus)
	temp:SetScript("OnEscapePressed", temp.ClearFocus)
	temp:SetScript("OnTextChanged", function(self)
		if WoWEquip_SaveFrame.mode ~= "send" then
			inputName = self:GetText()
		else
			lastSendName = self:GetText()
		end
		WoWEquip:UpdateProfilesList(true)
	end)
	WoWEquip_SaveFrame.NameInputBox = temp

	-- Create and position the Description text string
	WoWEquip_SaveFrame.DescText = WoWEquip_SaveFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	WoWEquip_SaveFrame.DescText:SetPoint("TOPLEFT", WoWEquip_SaveFrame.NameInputFrame, "BOTTOMLEFT", 0, 0)
	WoWEquip_SaveFrame.DescText:SetText(L["Description/Notes:"])

	-- Create the ScrollFrame for the Description Edit Box
	temp = CreateFrame("Frame", nil, WoWEquip_SaveFrame)
	temp:SetWidth(300)
	temp:SetHeight(78)
	temp:SetBackdrop(WoWEquip.WOWEQUIP_BOX_BACKDROP2)
	temp:SetPoint("TOPLEFT", WoWEquip_SaveFrame.DescText, "BOTTOMLEFT", 0, 0)
	WoWEquip_SaveFrame.DescFrame = temp
	local WoWEquip_DescEditScrollFrame = CreateFrame("ScrollFrame", "WoWEquip_DescEditScrollFrame", temp, "UIPanelScrollFrameTemplate")
	WoWEquip_DescEditScrollFrame:SetWidth(269)
	WoWEquip_DescEditScrollFrame:SetHeight(70)
	WoWEquip_DescEditScrollFrame:SetPoint("TOPLEFT", 5, -4)
	WoWEquip_SaveFrame.DescEditScrollFrame = WoWEquip_DescEditScrollFrame

	-- Create the Description Input Box and position it below the text
	temp = CreateFrame("EditBox", nil, WoWEquip_SaveFrame)
	temp:SetWidth(269)
	temp:SetHeight(70)
	temp:SetMaxLetters(512)
	temp:SetNumeric(false)
	temp:SetAutoFocus(false)
	temp:SetFontObject("GameFontHighlightSmall")
	temp:SetMultiLine(true)
	temp:SetScript("OnTextChanged", ScrollingEdit_OnTextChanged)
	temp:SetScript("OnEscapePressed", temp.ClearFocus)
	temp:SetScript("OnCursorChanged", ScrollingEdit_OnCursorChanged)
	WoWEquip_SaveFrame.DescInputBox = temp

	-- Attach the ScrollChild to the ScrollFrame
	WoWEquip_DescEditScrollFrame:SetScrollChild(temp)
	WoWEquip_DescEditScrollFrame:UpdateScrollChildRect()

	-- Let the 2 editboxes tab to each other
	local function WoWEquip_SaveFrame_NameInputBox_OnTabEnterPressed()
		WoWEquip_SaveFrame.DescInputBox:SetFocus()
	end
	WoWEquip_SaveFrame.NameInputBox:SetScript("OnTabPressed", WoWEquip_SaveFrame_NameInputBox_OnTabEnterPressed)
	WoWEquip_SaveFrame.NameInputBox:SetScript("OnEnterPressed", WoWEquip_SaveFrame_NameInputBox_OnTabEnterPressed)
	WoWEquip_SaveFrame.DescInputBox:SetScript("OnTabPressed", function() WoWEquip_SaveFrame.NameInputBox:SetFocus() end)

	-- Create and position the List of saved profiles text string
	WoWEquip_SaveFrame.ProfilesText = WoWEquip_SaveFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	WoWEquip_SaveFrame.ProfilesText:SetPoint("TOPLEFT", WoWEquip_SaveFrame.DescFrame, "BOTTOMLEFT", 0, 0)
	WoWEquip_SaveFrame.ProfilesText:SetText(L["List of saved profiles:"])

	-- Create the ScrollFrame for the Saved Profiles scrollframe
	WoWEquip_SaveFrame.ProfilesFrame = CreateFrame("Frame", nil, WoWEquip_SaveFrame)
	WoWEquip_SaveFrame.ProfilesFrame:SetWidth(300)
	WoWEquip_SaveFrame.ProfilesFrame:SetHeight(WOWEQUIP_PROFILES_DISP_HEIGHT * WOWEQUIP_PROFILES_SHOWN + 10)
	WoWEquip_SaveFrame.ProfilesFrame:SetBackdrop(WoWEquip.WOWEQUIP_BOX_BACKDROP2)
	WoWEquip_SaveFrame.ProfilesFrame:SetPoint("TOPLEFT", WoWEquip_SaveFrame.ProfilesText, "BOTTOMLEFT", 0, 0)

	local WoWEquip_ProfilesScrollFrame = CreateFrame("ScrollFrame", "WoWEquip_ProfilesScrollFrame", WoWEquip_SaveFrame.ProfilesFrame, "FauxScrollFrameTemplate")
	WoWEquip_ProfilesScrollFrame:SetPoint("TOPLEFT", 2, -5)
	WoWEquip_ProfilesScrollFrame:SetWidth(WOWEQUIP_PROFILES_DISP_WIDTH - 3)
	WoWEquip_ProfilesScrollFrame:SetHeight(WOWEQUIP_PROFILES_DISP_HEIGHT * WOWEQUIP_PROFILES_SHOWN)
	WoWEquip_ProfilesScrollFrame:SetScript("OnVerticalScroll", function(self, offset)
		FauxScrollFrame_OnVerticalScroll(self, offset, WOWEQUIP_PROFILES_DISP_HEIGHT, WoWEquip_ProfilesScrollFrame_Update)
	end)
	FauxScrollFrame_Update(WoWEquip_ProfilesScrollFrame, 0, WOWEQUIP_PROFILES_SHOWN, WOWEQUIP_PROFILES_DISP_HEIGHT)

	-- Create the highlight overlay
	WoWEquip_ProfilesScrollFrame.highlight = WoWEquip_SaveFrame.ProfilesFrame:CreateTexture(nil, "ARTWORK")
	WoWEquip_ProfilesScrollFrame.highlight:SetTexture("Interface\\Buttons\\UI-Listbox-Highlight2")
	WoWEquip_ProfilesScrollFrame.highlight:SetVertexColor(1.0, 0.82, 0)
	WoWEquip_ProfilesScrollFrame.highlight:SetWidth(WOWEQUIP_PROFILES_DISP_WIDTH)
	WoWEquip_ProfilesScrollFrame.highlight:SetHeight(WOWEQUIP_PROFILES_DISP_HEIGHT)

	-- Create the Profiles scrolllist buttons and position them. All the buttons are stored in WoWEquip_SaveFrame.ProfileButtonAr[]
	WoWEquip_SaveFrame.ProfileButtonAr = {}
	for v = 1, WOWEQUIP_PROFILES_SHOWN do
		temp = CreateFrame("Button", nil, WoWEquip_SaveFrame.ProfilesFrame)
		temp:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		temp:SetScript("OnClick", WoWEquip_ProfilesButton_OnClick)
		temp:SetScript("OnEnter", WoWEquip_ProfilesButton_OnEnter)
		temp:SetScript("OnLeave", WoWEquip.Generic_OnLeave)
		temp:SetScript("OnHide", WoWEquip_DropDownMenu.HideMenu)
		temp.initMenuFunc = WoWEquip.ProfileOptionsMenu
		temp:SetWidth(WOWEQUIP_PROFILES_DISP_WIDTH)
		temp:SetHeight(WOWEQUIP_PROFILES_DISP_HEIGHT)
		temp:Hide()
		RaiseFrameLevel(temp)
		temp.string = temp:CreateFontString()
		temp.string:SetWidth(WOWEQUIP_PROFILES_DISP_WIDTH)
		temp.string:SetHeight(10)
		temp.string:SetJustifyH("LEFT")
		temp:SetFontString(temp.string)
		temp:SetNormalFontObject("GameFontNormalSmall")
		temp:SetHighlightFontObject("GameFontHighlightSmall")
		temp:SetDisabledFontObject("GameFontDisableSmall")
		if v == 1 then
			temp:SetPoint("TOPLEFT", 5, -5)
		else
			temp:SetPoint("TOPLEFT", WoWEquip_SaveFrame.ProfileButtonAr[v-1], "BOTTOMLEFT")
		end
		WoWEquip_SaveFrame.ProfileButtonAr[v] = temp
	end

	-- Create the Cancel button
	WoWEquip_SaveFrame.CancelButton = CreateFrame("Button", nil, WoWEquip_SaveFrame, "OptionsButtonTemplate")
	WoWEquip_SaveFrame.CancelButton:SetWidth(150)
	WoWEquip_SaveFrame.CancelButton:SetHeight(22)
	WoWEquip_SaveFrame.CancelButton:SetPoint("TOPLEFT", WoWEquip_SaveFrame.ProfilesFrame, "BOTTOMLEFT", 0, -1)
	WoWEquip_SaveFrame.CancelButton:SetText(CANCEL)
	WoWEquip_SaveFrame.CancelButton:SetScript("OnClick", WoWEquip_SaveFrame.CloseButton:GetScript("OnClick"))

	-- Create the Save/Load/Send/Compare button
	WoWEquip_SaveFrame.SaveButton = CreateFrame("Button", nil, WoWEquip_SaveFrame, "OptionsButtonTemplate")
	WoWEquip_SaveFrame.SaveButton:SetWidth(150)
	WoWEquip_SaveFrame.SaveButton:SetHeight(22)
	WoWEquip_SaveFrame.SaveButton:SetPoint("LEFT", WoWEquip_SaveFrame.CancelButton, "RIGHT", 0, 0)
	WoWEquip_SaveFrame.SaveButton.load = function(self, button, down)
		WoWEquip:LoadProfile(inputName)
		WoWEquip_SaveFrame:Hide()
	end
	WoWEquip_SaveFrame.SaveButton.save = function(self, button, down)
		local name = strtrim(inputName)
		local desc = strtrim(WoWEquip_SaveFrame.DescInputBox:GetText())
		if WoWEquip.db.global.profiles[name] then
			StaticPopup_Hide("WOWEQUIP_CONFIRM_DELETE")
			StaticPopup_Hide("WOWEQUIP_CONFIRM_RENAME")
			StaticPopup_Show("WOWEQUIP_CONFIRM_OVERWRITE", name)
		else
			WoWEquip:SaveProfile(name, desc)
			WoWEquip_SaveFrame:Hide()
		end
	end
	WoWEquip_SaveFrame.SaveButton.send = function(self, button, down)
		WoWEquip:SendProfile(inputName, lastSendName)
		WoWEquip_SaveFrame:Hide()
	end
	WoWEquip_SaveFrame.SaveButton.compare = function(self, button, down)
		WoWEquip:SetCompareProfile(inputName)
		WoWEquip_SaveFrame:Hide()
	end

	-- Create and position the info string
	WoWEquip_SaveFrame.InfoText = WoWEquip_SaveFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	WoWEquip_SaveFrame.InfoText:SetWidth(300)
	WoWEquip_SaveFrame.InfoText:SetPoint("TOP", WoWEquip_SaveFrame.CancelButton, "BOTTOMRIGHT", 0, -2)
	WoWEquip_SaveFrame.InfoText:SetJustifyV("MIDDLE")
	WoWEquip_SaveFrame.InfoText:SetJustifyH("CENTER")
	WoWEquip_SaveFrame.InfoText:SetText(L["Right-Click profiles for more options."])
end

-- vim: ts=4 noexpandtab
