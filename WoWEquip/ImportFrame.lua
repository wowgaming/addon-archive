----------------------------------------------------------------------------------------
-- WoWEquip file for the Import Frame

local WoWEquip = LibStub("AceAddon-3.0"):GetAddon("WoWEquip")
local L = LibStub("AceLocale-3.0"):GetLocale("WoWEquip", false)


----------------------------------------------------------------------------------------
-- Constants

local IMPORT_TYPES = {
	L["WoW Armory"],
	L["Rawr"],
}
local IMPORT_DESC = {
	L["Paste the entire XML/XSLT source of the WoW Armory character page (View Source). Only works in IE6 and Firefox2 or newer."],
	L["Paste the entire contents of a Rawr (v2.2.4 or later) XML saved character file."],
}
local WOWEQUIP_SLOTS = WoWEquip.SLOTS
local ARMORY_RACES = {
	["1"] = "Human",
	["2"] = "Orc",
	["3"] = "Dwarf",
	["4"] = "NightElf", -- "Night Elf"
	["5"] = "Scourge", --"Undead",
	["6"] = "Tauren",
	["7"] = "Gnome",
	["8"] = "Troll",
	["10"] = "BloodElf", -- "Blood Elf"
	["11"] = "Draenei",
}
local ARMORY_CLASSES = {
	["1"] = "WARRIOR",
	["2"] = "PALADIN",
	["3"] = "HUNTER",
	["4"] = "ROGUE",
	["5"] = "PRIEST",
	["6"] = "DEATHKNIGHT",
	["7"] = "SHAMAN",
	["8"] = "MAGE",
	["9"] = "WARLOCK",
	["11"] = "DRUID", -- yes *REALLY* 11 :D
}
local ARMORY_FIELDS = {
	'id',
	'permanentenchant',
	'gem0Id',
	'gem1Id',
	'gem2Id',
	'gem3Id', -- non existant! bad blizz
	'randomPropertiesId',
	'seed',
}
local RAWR_FIELDS = {
	"Head",
	"Neck",
	"Shoulders",
	"Shirt",
	"Chest",
	"Waist",
	"Legs",
	"Feet",
	"Wrist",
	"Hands",
	"Finger1",
	"Finger2",
	"Trinket1",
	"Trinket2",
	"Back",
	"MainHand",
	"OffHand",
	"Ranged",
	"Tabard"
}


----------------------------------------------------------------------------------------
-- Local Variables

local selectedSource = 1


----------------------------------------------------------------------------------------
-- Local Widget Functions

local function WoWEquip_ParseButton_OnClick(self)
	local f = WoWEquip.ImportFrame

	-- No data!
	if #f.DataInputBox:GetText():trim() == 0 then return end

	local input = f.DataInputBox:GetText()

	-- Clear out the current paperdoll
	for i=1, #WOWEQUIP_SLOTS do -- we dont care for ammo
		WoWEquip:UpdateSlot(WOWEQUIP_SLOTS[i], nil, true)
	end
	local curProfile = WoWEquip.curProfile
	local race = UNKNOWN
	local guildname = NONE
	local faction = UNKNOWN
	local class = UNKNOWN
	local name = L["Anonymous Import"]
	local level = MAX_PLAYER_LEVEL
	local realm = UNKNOWN
	local import_date = date("%m/%d/%y %H:%M:%S")
	local import_type
	local classID

	if selectedSource == 1 then -- WoW Armory
		-- Extract player information
		local char_data = input:match( "<character%s.->" )

		if char_data then
			-- faction
			if "0" == char_data:match( 'factionId="([^"]*)"' ) then
				faction = FACTION_ALLIANCE
			else
				faction = FACTION_HORDE
			end

			classID = ARMORY_CLASSES[ char_data:match( 'classId="([^"]*)"') ]
			race = ARMORY_RACES[ char_data:match( 'raceId="([^"]*)"' ) ] or race

			class = char_data:match( 'class="([^"]*)"') or class
			guildname = char_data:match( 'guildName="([^"]*)"' ) or guildname
			name = char_data:match( 'name="([^"]*)"') or name
			realm = char_data:match( 'realm="([^"]*)"') or realm
			level = tonumber( char_data:match( 'level="([^"]*)"') ) or level
			import_date = char_data:match( 'lastModified="([^"]*)"' ) or import_date
		end
		import_type = L["Armory Import"]

		-- Extract item information
		local t = {}
		for item in input:gmatch("<item%s.-/>") do
			for i, s in ipairs(ARMORY_FIELDS) do
				t[i] = item:match( s..'="([^"]*)"' ) or 0
				if i >= 3 and i <= 6 then
					local tmp = tonumber( t[i] )
					tmp = WoWEquip:FindGemEnchantID(WoWEquip.GemData[EMPTY_SOCKET_BLUE], tmp) or WoWEquip:FindGemEnchantID(WoWEquip.GemData[EMPTY_SOCKET_META], tmp)
					t[i] = tostring(tmp)
				end
			end
			local slot = item:match( 'slot="([^"]*)"' ) + 1
			t[9] = level
			local itemString = 'item:' ..  table.concat(t, ":")
			local _, itemLink = GetItemInfo(itemString) -- if the item isn't in the local cache, this will return nil
			WoWEquip:UpdateSlot(WOWEQUIP_SLOTS[slot], itemLink, true)
		end

	elseif selectedSource == 2 then -- Rawr
		import_type = L["Rawr Import"]

		race = input:match( '<Race>([^<]*)</Race>')
		if race == 'Undead' then race = ARMORY_RACES["5"] end

		-- faction
		if race == "Orc" or race == "Scourge" or race == "Troll" or race == "Tauren" or race == "BloodElf" then
			faction = FACTION_HORDE
		else
			faction = FACTION_ALLIANCE
		end

		classID = input:match( '<Class>([^<]*)</Class>')
		if classID then
			classID = classID:upper()
			class = WoWEquip.CLASSES[ classID ]
		end

		name = input:match( '<Name>([^<]*)</Name>') or name
		realm = input:match( '<Realm>([^<]*)</Realm>') or realm
		local region = input:match( '<Region>([^<]*)</Region>')
		if region then realm = realm .. '.' .. region end
		level = 80

		-- Extract item information
		local gem = {}
		for i, s in ipairs(RAWR_FIELDS) do
			local item_id, enchant_id
			item_id, gem[1], gem[2], gem[3], enchant_id = input:match( '<'..s..'>(%d+)%.(%d+)%.(%d+)%.(%d+)%.(%d+)</'..s..'>' )
			for i=1, #gem do
				local tmp = tonumber( gem[i] )
				gem[i] = WoWEquip:FindGemEnchantID(WoWEquip.GemData[EMPTY_SOCKET_BLUE], tmp) or WoWEquip:FindGemEnchantID(WoWEquip.GemData[EMPTY_SOCKET_META], tmp)
			end
			if item_id then
				local itemString = format(
					"item:%d:%d:%d:%d:%d:%d:%d:%d:%d",
					item_id,
					enchant_id or 0,
					gem[1] or 0,
					gem[2] or 0,
					gem[3] or 0,
					0, -- gem[4],
					0, -- suffix_id
					0, -- unique_id
					level
				)
				local _, itemLink = GetItemInfo(itemString) -- if the item isn't in the local cache, this will return nil
				WoWEquip:UpdateSlot(WOWEQUIP_SLOTS[i], itemLink, true)
			end
		end
	end

	curProfile.name = format("%s (%d): %s (%s)", class, level, name, import_type)
	curProfile.desc = L["%s's imported gear.\nGuild: %s\nServer: %s, %s\nDate: %s"]:format(name, guildname or NONE, realm, faction, import_date)
	curProfile.race = race
	curProfile.level = level
	curProfile.class = classID

	WoWEquip.frame.BonusFrame.LevelInputBox:SetText(level or UnitLevel("player"))
	WoWEquip.frame.BonusFrame.ClassButton:SetText(class)
	WoWEquip:UpdateBonusFrame()
	WoWEquip:UpdateDressUpModel()
	CloseDropDownMenus()

	f:Hide()
end

function WoWEquip.SetImportOption(dropdownbutton, arg1, arg2, checked)
	selectedSource = arg1
	WoWEquip.ImportFrame.TypeFrame.TypeText:SetText(IMPORT_TYPES[arg1])
	WoWEquip.ImportFrame.ImportTypeDesc:SetText(IMPORT_DESC[arg1])
end

function WoWEquip.ImportMenu(self, level)
	if not level then return end
	local info = self.info
	wipe(info)
	if level == 1 then
		info.isTitle = 1
		info.text = L["Select Import Source"]
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		info.notCheckable = nil
		info.disabled = nil
		info.isTitle = nil

		for k = 1, #IMPORT_TYPES do
			info.text = IMPORT_TYPES[k]
			info.arg1 = k
			info.func = WoWEquip.SetImportOption
			info.checked = selectedSource == k
			UIDropDownMenu_AddButton(info)
		end

		-- Close menu item
		info.notCheckable = 1
		info.checked = nil
		info.text = CLOSE
		info.func = self.HideMenu
		UIDropDownMenu_AddButton(info, level)
	end
end


----------------------------------------------------------------------------------------
-- Create the frames used by the Import Frame window

do
	-- Create the main Equip frame
	local f = CreateFrame("Frame", "WoWEquip_ImportFrame", WoWEquip_Frame)
	f:Hide()
	f:SetWidth(350)
	f:SetHeight(300)
	f:SetBackdropColor(0, 0, 0, 0.75)
	f:EnableMouse(true)
	f:SetToplevel(true)
	f:SetClampedToScreen(true)
	f:SetMovable(true)
	f:SetPoint("CENTER", -500, 0 )
	WoWEquip.ImportFrame = f

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

	-- This creates the title text and texture
	temp = f:CreateFontString(nil, "ARTWORK")
	temp:SetFontObject(GameFontNormal)
	temp:SetPoint("TOPLEFT", 12, -8)
	temp:SetPoint("TOPRIGHT", -32, -8)
	temp:SetText(L["Import Profile"])
	f.titleText = temp

	-- This creates a transparent textureless draggable frame to move WoWEquip_ImportFrame
	-- It overlaps the above title text and texture (more or less) exactly.
	temp = CreateFrame("Frame", nil, f)
	temp:SetPoint("TOPLEFT", f.titlebg)
	temp:SetPoint("BOTTOMRIGHT", f.titlebg)
	temp:EnableMouse(true)
	temp:RegisterForDrag("LeftButton")
	temp:SetScript("OnDragStart", WoWEquip.Generic_StartMoving)
	temp:SetScript("OnDragStop", WoWEquip.Generic_StopMovingOrSizing)
	f.dragFrame = temp

	-- Create the Close button
	temp = CreateFrame("Button", nil, WoWEquip_ImportFrame, "UIPanelCloseButton")
	temp:SetPoint("TOPRIGHT", 2, 1)
	temp:SetHitRectInsets(5, 5, 5, 5)
	temp:SetScript("OnClick", WoWEquip.Generic_Hide)
	WoWEquip_ImportFrame.CloseButton = temp

	-- Create and position the Type text string
	temp = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp:SetPoint("TOPLEFT", 25, -32)
	temp:SetText(L["Type:"])
	f.TypeText = temp

	-- Create the Type Dropdown and position it below the text
	temp = CreateFrame("Frame", nil, f)
	temp:SetWidth(100)
	temp:SetHeight(24)
	temp:SetBackdrop(WoWEquip.WOWEQUIP_BOX_BACKDROP2)
	temp:SetPoint("TOPLEFT", f.TypeText, "BOTTOMLEFT", 0, 0)
	f.TypeFrame = temp
	temp.TypeText = temp:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp.TypeText:SetPoint("LEFT", temp, "LEFT", 7, 1)
	temp.TypeText:SetText(IMPORT_TYPES[selectedSource])
	temp.TypeText:SetFontObject("GameFontHighlightSmall")
	-- Now the dropdown button
	temp.button = CreateFrame("Button", nil, temp)
	temp.button:SetWidth(24)
	temp.button:SetHeight(24)
	temp.button:SetPoint("RIGHT", temp, "RIGHT", 0, 0)
	temp.button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	temp.button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	temp.button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
	temp.button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
	temp.button:SetScript("OnClick", WoWEquip_DropDownMenu.OnClick)
	temp.button:SetScript("OnHide", WoWEquip_DropDownMenu.HideMenu)
	temp.button.initMenuFunc = WoWEquip.ImportMenu

	-- Create the import instruction description string
	temp = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp:SetPoint("TOPRIGHT", -25, -30)
	temp:SetPoint("BOTTOMLEFT", f.TypeFrame, "BOTTOMRIGHT", 8, -7)
	temp:SetJustifyH("LEFT")
	temp:SetText(IMPORT_DESC[selectedSource])
	f.ImportTypeDesc = temp

	-- Create and position the Data text string
	temp = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	temp:SetPoint("TOPLEFT", f.TypeFrame, "BOTTOMLEFT", 0, -3)
	temp:SetText(L["Data:"])
	f.DataText = temp

	-- Create the ScrollFrame for the Description Edit Box
	temp = CreateFrame("Frame", nil, f)
	temp:SetWidth(300)
	temp:SetHeight(175)
	temp:SetBackdrop(WoWEquip.WOWEQUIP_BOX_BACKDROP2)
	temp:SetPoint("TOPLEFT", f.DataText, "BOTTOMLEFT", 0, 0)
	f.DataFrame = temp

	-- Scroll parent template
	temp = CreateFrame("ScrollFrame", "WoWEquip_ImportScrollFrame", temp, "UIPanelScrollFrameTemplate")
	temp:SetWidth(269)
	temp:SetHeight(167)
	temp:SetPoint("TOPLEFT", 5, -4)
	f.DataScrollFrame = temp

	-- Create the Description Input Box and position it below the text
	temp = CreateFrame("EditBox", nil, f.DataFrame)
	temp:SetWidth(269)
	temp:SetHeight(167)
	temp:SetNumeric(false)
	temp:SetAutoFocus(false)
	temp:SetFontObject("GameFontHighlightSmall")
	temp:SetMultiLine(true)
	temp:SetScript("OnTextChanged", function(self, ...)
		if #self:GetText():trim() == 0 then
			f.ParseButton:Disable()
		else
			f.ParseButton:Enable()
		end
		ScrollingEdit_OnTextChanged(self, ...)
	end)
	temp:SetScript("OnEscapePressed", temp.ClearFocus)
	temp:SetScript("OnCursorChanged", ScrollingEdit_OnCursorChanged)
	temp:SetScript("OnUpdate", ScrollingEdit_OnUpdate)
	f.DataInputBox = temp

	-- Attach the ScrollChild to the ScrollFrame
	f.DataScrollFrame:SetScrollChild(temp)

	-- Create the Cancel button
	temp = CreateFrame("Button", nil, f, "OptionsButtonTemplate")
	temp:SetWidth(150)
	temp:SetHeight(22)
	temp:SetPoint("TOPLEFT", f.DataFrame, "BOTTOMLEFT", 0, -1)
	temp:SetText(CANCEL)
	temp:SetScript("OnClick", WoWEquip.Generic_Hide)
	f.CancelButton = temp

	-- Create the Parse button
	temp = CreateFrame("Button", nil, f, "OptionsButtonTemplate")
	temp:SetWidth(150)
	temp:SetHeight(22)
	temp:SetPoint("LEFT", f.CancelButton, "RIGHT", 0, 0)
	temp:SetText(L["Import"])
	temp:SetScript("OnClick", WoWEquip_ParseButton_OnClick)
	temp:Disable()
	f.ParseButton = temp
end

-- vim: ts=4 noexpandtab
