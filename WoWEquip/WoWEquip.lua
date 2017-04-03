--[[
****************************************************************************************
WoWEquip 1.2
9 Dec 2009
(Written for live servers v3.3.0.10958)

Author: Xinhuan @ US Blackrock Alliance & Xaroz @ EU Emerald Dream Alliance
****************************************************************************************
Description:
	Try on different gear and see their total stats and their differences.
	In short, an ingame CT-Profiles-like addon.

	Users of WoWEquip are encouraged to use the addon RatingBuster written by
	Whitetooth@Cenarius.

Notes:
	In the process of coding WoWEquip and favouring to add more new features,
	there are currently no "validity checks" coded in to ensure that impossible
	combinations of gear/gems/enchants and talents/race/class do not occur. The
	user is expected to perform such checks himself.

	Note that ONLY the statistics and bonuses gained from the gear is calculated.
	Base character stats such as Agi, Str, Sta and base derived stats such as
	parry, dodge and block are not included. This is to allow comparison from a
	pure equipment-gain-only point of view.

Quirks:
	When the Dressing Room gets dragged offscreen, the model gets "flattened" (lol).

Known Issues:
    Dodge calculation isn't correct for any level/class but the player's (StatLogic).
    Counterweights can be placed on anything rather than just 2h swords, maces, axes
	  and polearms (WoWEquip).

What I need:
	You can help to translate WoWEquip into your language here:
	http://www.wowace.com/projects/wowequip/localization/

Bug Reporting/Suggestions:
	Report any bugs or suggestions you may have at the forum thread:
	http://forums.wowace.com/showthread.php?t=7879

Download:
	The latest version of WoWEquip can be obtained and downloaded from
	http://www.wowace.com/projects/wowequip/

Credits:
	Ideas from CT-Profiles and Danya's WoWEquip standalone application at
	http://wowequip.tehbox.org/

****************************************************************************************
]]


----------------------------------------------------------------------------------------
-- Addon and Library Declarations
local WoWEquip = LibStub("AceAddon-3.0"):NewAddon("WoWEquip", "AceEvent-3.0", "AceSerializer-3.0", "AceComm-3.0")
WoWEquip.version = GetAddOnMetadata("WoWEquip", "Version")
WoWEquip.versionstring = "WoWEquip "..GetAddOnMetadata("WoWEquip", "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("WoWEquip", false)
local LE = LibStub("AceLocale-3.0"):GetLocale("WoWEquipLE", false)
local LGII = LibStub("AceLocale-3.0"):GetLocale("WoWEquipLGII", false)
_G["WoWEquip"] = WoWEquip


----------------------------------------------------------------------------------------
-- Keybindings

BINDING_HEADER_WOWEQUIP = WoWEquip.versionstring
BINDING_NAME_WOWEQUIP_TOGGLE = L["Show/Hide WoWEquip"]
BINDING_NAME_WOWEQUIP_INSPECT = L["Inspect & Copy Target"]


----------------------------------------------------------------------------------------
-- Local constants

local _G = getfenv(0)
local tremove, strfind, strlower = tremove, strfind, strlower
local GetItemInfo, GetItemQualityColor = GetItemInfo, GetItemQualityColor
local db
local defaults = {
	global = {
		pos = {
			WoWEquip_Frame = {
				point = "CENTER",
				relpoint = "CENTER",
				offsetx = 0,
				offsety = 0,
			},
			WoWEquip_EquipFrame = {
				point = "CENTER",
				relpoint = "CENTER",
				offsetx = 0,
				offsety = 0,
			},
			WoWEquip_SaveFrame = {
				point = "CENTER",
				relpoint = "CENTER",
				offsetx = 0,
				offsety = 0,
			},
			WoWEquip_ImportFrame = {
				point = "CENTER",
				relpoint = "CENTER",
				offsetx = 0,
				offsety = 0,
			},
		},
		EquipFilters = { -- See WOWEQUIP_FILTERS[] in EquipFrame.lua
			true, true, true, true, true,
			true, true, true, true, true,
			true, true, true, true, true,
			true, true, true, true, true,
			true, true, true, true, true,
			true, true,
			true, true, true, true, true,
			true, true, true, true, true,
		},
		SortOption = 5,
		ShowCloak = true,
		ShowHelm = true,
		PreserveEnchant = true,
		LockWindow = false,
		Scale = 100,
		Transparency = 100,
		r = 0,
		g = 0,
		b = 0,
		a = 0.75,
		--[[ -- Border color is no longer used
		br = 1,
		bg = 1,
		bb = 1,
		ba = 1,
		]]
		AddWidth = 20,
		DRScale = 100,
		profiles = {},
		CompareOption = 2,
		ShowRating = true,
		CompareProfile = "",
		favorites = {},
	},
}
local WOWEQUIP_SLOTS = {
	-- List of itemSlots with corresponding IDs
	"HEADSLOT",
	"NECKSLOT",
	"SHOULDERSLOT",
	"SHIRTSLOT",
	"CHESTSLOT",
	"WAISTSLOT",
	"LEGSSLOT",
	"FEETSLOT",
	"WRISTSLOT",
	"HANDSSLOT",
	"FINGER0SLOT",
	"FINGER1SLOT",
	"TRINKET0SLOT",
	"TRINKET1SLOT",
	"BACKSLOT",
	"MAINHANDSLOT",
	"SECONDARYHANDSLOT",
	"RANGEDSLOT",
	"TABARDSLOT",
}
WoWEquip.SLOTS = WOWEQUIP_SLOTS
local WOWEQUIP_SOCKET_ICONPATH = {
	[EMPTY_SOCKET_BLUE] = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Blue",
	[EMPTY_SOCKET_META] = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Meta",
	[EMPTY_SOCKET_RED] = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Red",
	[EMPTY_SOCKET_YELLOW] = "Interface\\ItemSocketingFrame\\UI-EmptySocket-Yellow",
	[EMPTY_SOCKET_NO_COLOR] = "Interface\\ItemSocketingFrame\\UI-EmptySocket",
}

local WOWEQUIP_SOCKET_COLOR = {
	[EMPTY_SOCKET_BLUE] = { 0, 0.44, 0.87},
	[EMPTY_SOCKET_META] = { 0.9, 0.9, 0.9},
	[EMPTY_SOCKET_NO_COLOR] = { 0.9, 0.9, 0.9},
	[EMPTY_SOCKET_RED] = {1, 0.17, 0.17},
	[EMPTY_SOCKET_YELLOW] = {0.97, 0.82, 0.29}
}

----------------------------------------------------------------------------------------
-- Common constants

WoWEquip.WOWEQUIP_MAIN_BACKDROP = {
	bgFile = "Interface\\Buttons\\WHITE8X8",
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tile = true, tileSize = 32, edgeSize = 32,
 	insets = { left = 11, right = 12, top = 12, bottom = 11 },
}
WoWEquip.WOWEQUIP_BOX_BACKDROP = {
	bgFile = nil,
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
 	insets = { left = 5, right = 5, top = 5, bottom = 5 },
}
WoWEquip.WOWEQUIP_BOX_BACKDROP2 = {
	bgFile = nil,
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}


----------------------------------------------------------------------------------------
-- Local variables

local sockets = {}
WoWEquip.curProfile = {
	eq = {},
	name = "",
	desc = "",
	class = "",
	race = "",
	level = 80,
}


----------------------------------------------------------------------------------------
-- Use a common frame and setup some common functions for the WoWEquip dropdown menus

local WoWEquip_DropDownMenu = CreateFrame("Frame", "WoWEquip_DropDownMenu")
WoWEquip_DropDownMenu.displayMode = "MENU"
WoWEquip_DropDownMenu.info = {}
WoWEquip_DropDownMenu.data = {}
WoWEquip_DropDownMenu.UncheckHack = function(dropdownbutton, arg1, arg2, checked)
	_G[dropdownbutton:GetName().."Check"]:Hide()
end
WoWEquip_DropDownMenu.HideMenu = function()
	if UIDROPDOWNMENU_OPEN_MENU == WoWEquip_DropDownMenu then
		CloseDropDownMenus()
	end
end
WoWEquip_DropDownMenu.CloseDropDownMenus = function(dropdownbutton, arg1, arg2, checked)
	CloseDropDownMenus(arg1)
end
WoWEquip_DropDownMenu.OnClick = function(frame, button, down)
	if WoWEquip_DropDownMenu.initialize ~= frame.initMenuFunc or WoWEquip_DropDownMenu.owner ~= frame then
		CloseDropDownMenus()
		WoWEquip_DropDownMenu.initialize = frame.initMenuFunc
		WoWEquip_DropDownMenu.owner = frame
	end
	ToggleDropDownMenu(1, nil, WoWEquip_DropDownMenu, frame, 0, 0)
end


------------------------------------------------------
-- The hidden tooltip for parsing sockets and set data

local WoWEquip_Tooltip = CreateFrame("GameTooltip")
WoWEquip_Tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
WoWEquip_Tooltip.left = {}
WoWEquip_Tooltip.right = {}
for i = 1, 30 do
	local left, right = WoWEquip_Tooltip:CreateFontString(), WoWEquip_Tooltip:CreateFontString()
	left:SetFontObject(GameFontNormal)
	right:SetFontObject(GameFontNormal)
	WoWEquip_Tooltip:AddFontStrings(left, right)
	WoWEquip_Tooltip.left[i] = left
	WoWEquip_Tooltip.right[i] = right
end
WoWEquip.tooltip = WoWEquip_Tooltip


----------------------------------------------------------------------------------------
-- Make certain components of WoWEquip generated on demand

getmetatable(WoWEquip).__index = function(self, key)
	if key == "EnchantData" then
		self[key] = WoWEquip:GenerateEnchantDataTables()
		WoWEquip.GenerateEnchantDataTables = nil
		WoWEquip:CollapseFavoritesData(self[key])
		return self[key]
	elseif key == "GemData" or key == "GemColorData" then
		self.GemData, self.GemColorData = WoWEquip:GenerateGemDataTables()
		WoWEquip.GenerateGemDataTables = nil
		WoWEquip:CollapseFavoritesData(self[key])
		return self[key]
	end
end


----------------------------------------------------------------------------------------
-- Common functions

-- Generic function for leaving a frame to hide the GTT and reset the cursor
function WoWEquip.Generic_OnLeave()
	GameTooltip:Hide()
	ResetCursor()
end

-- Generic function to hide a button's parent
function WoWEquip.Generic_Hide(self)
	self:GetParent():Hide()
end

-- Generic function to start moving a frame's parent
function WoWEquip.Generic_StartMoving(self)
	if not db.LockWindow then self:GetParent():StartMoving() end
end

-- Generic function to stop moving a frame's parent and save its position
function WoWEquip.Generic_StopMovingOrSizing(self)
	local f = self:GetParent()
	local t = db.pos[f:GetName()]
	local _
	f:StopMovingOrSizing()
	f:SetUserPlaced(nil)
	t.point, _, t.relpoint, t.offsetx, t.offsety = f:GetPoint()
end


----------------------------------------------------------------------------------------
-- Specific Widget functions

local function WoWEquip_Frame_OnShow(self)
	if not self.init then
		-- Load the current equipped items and data into the buttons and into curProfile[]
		local curProfile = WoWEquip.curProfile
		for slotname, button in pairs(WoWEquip.PaperDoll) do
			local itemLink = GetInventoryItemLink("player", button.slotnum)
			if itemLink then WoWEquip:UpdateSlot(slotname, itemLink, true) end
		end
		local _, race = UnitRace("player")
		local guildname, guildrank = GetGuildInfo("player")
		if not guildname then
			guildname = NONE
		else
			guildname = "<"..guildname..">, "..guildrank
		end
		local faction, class
		if race == "Orc" or race == "Scourge" or race == "Troll" or race == "Tauren" or race == "BloodElf" then
			faction = FACTION_HORDE
		else
			faction = FACTION_ALLIANCE
		end
		class, curProfile.class = UnitClass("player")
		curProfile.name = format("%s (%d): %s (%s)", class, UnitLevel("player"), UnitName("player"), L["Equipped Gear"])
		curProfile.desc = L["%s's equipped gear.\nGuild: %s\nServer: %s, %s\nDate: %s"]:format(UnitName("player"), guildname, GetRealmName(), faction, date("%m/%d/%y %H:%M:%S"))
		curProfile.race = race
		curProfile.level = UnitLevel("player")

		WoWEquip.frame.BonusFrame.LevelInputBox:SetText(UnitLevel("player"))
		WoWEquip.frame.BonusFrame.ClassButton:SetText(class)

		-- This is just to initialize the frame attributes or the later part will not work to reposition the DressUpFrame
		DressUpFrame:SetAttribute("UIPanelLayout-defined", true)
		for name, value in pairs(UIPanelWindows["DressUpFrame"]) do
			DressUpFrame:SetAttribute("UIPanelLayout-"..name, value)
		end
		DressUpModel:SetUnit("player")

		self.init = true
	end

	self.ShowCloakCheckbox:SetChecked(db.ShowCloak)
	self.ShowHelmCheckbox:SetChecked(db.ShowHelm)
	self.ShowHelmCheckbox:Show()
	self.ShowCloakCheckbox:Show()

	-- Reanchor the DressUpFrame to WoWEquip
	local flag = DressUpFrame:IsShown()
	self.oldDressUpFrameScale = DressUpFrame:GetScale()
	if flag then HideUIPanel(DressUpFrame) end
	DressUpFrame:SetAttribute("UIPanelLayout-enabled", nil)
	DressUpFrame:ClearAllPoints()
	DressUpFrame:SetPoint("TOPRIGHT", WoWEquip_Frame, "TOPLEFT", 30, 14.5)
	DressUpFrame:SetScale(db.DRScale / 100)
	if flag then ShowUIPanel(DressUpFrame) end

	WoWEquip:UpdateBonusFrame()
	WoWEquip:UpdateDressUpModel()

	PlaySound("igCharacterInfoOpen")
	if db.CompareOption == 2 then
		WoWEquip:RegisterEvent("UNIT_INVENTORY_CHANGED")
	end
end

local function WoWEquip_Frame_OnHide(self)
	-- Restore the DressUpFrame
	local flag = DressUpFrame:IsShown()
	HideUIPanel(DressUpFrame)
	DressUpFrame:ClearAllPoints()
	DressUpFrame:SetAttribute("UIPanelLayout-enabled", true)
	DressUpFrame:SetScale(self.oldDressUpFrameScale)
	if flag then ShowUIPanel(DressUpFrame) end

	-- make sure to hide the helm/cloak buttons
	WoWEquip.frame.ShowCloakCheckbox:Hide()
	WoWEquip.frame.ShowHelmCheckbox:Hide()

	WoWEquip.SaveFrame:Hide()
	WoWEquip.ImportFrame:Hide()
	PlaySound("igCharacterInfoClose")
	WoWEquip:UnregisterEvent("UNIT_INVENTORY_CHANGED")
end

local function WoWEquip_PaperDollButton_OnClick(self, button, down)
	local eq = WoWEquip.curProfile.eq
	if button == "LeftButton" then
		if HandleModifiedItemClick(eq[self.slotname]) then
			return
		else
			if not WoWEquip.EquipFrame then
				WoWEquip:CreateEquipFrames()
				WoWEquip.CreateEquipFrames = nil
			end
			if WoWEquip.EquipFrame.pointer ~= self then
				WoWEquip.EquipFrame.pointer = self
				CloseDropDownMenus()
				WoWEquip:SetupFilter(self.slotnum)
				WoWEquip.EquipFrame.EquipButton:Disable()
				WoWEquip.EquipFrame.InputBox:SetText("")
				WoWEquip.PaperDoll1Shine:SetPoint("CENTER", self)
				WoWEquip:GenerateDispList(1)
			end
			AnimatedShine_Start(WoWEquip_PaperDoll1, GetItemQualityColor(select(3, GetItemInfo(eq[self.slotname] or "")) or -1))
			WoWEquip.PaperDoll1Shine:Show()
			WoWEquip.EquipFrame:Show()
		end
	elseif button == "RightButton" then
		if eq[self.slotname] then
			WoWEquip_DropDownMenu.relativePoint = "BOTTOMRIGHT"
			WoWEquip_DropDownMenu.OnClick(self, button, down)
			WoWEquip_DropDownMenu.relativePoint = nil
		end
	end
end

local function WoWEquip_PaperDollButton_OnEnter(self)
	local itemLink = WoWEquip.curProfile.eq[self.slotname]
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	if itemLink then
		if not GetItemInfo(itemLink) or (self.needupdate and (GetTime() - self.needupdate < 1.0)) then
			-- If itemLink isn't in local cache, or it has not been 1.0 secs since querying the server for it
			local itemcolor, itemid, itemname = strmatch(itemLink, "(|c.*)|Hitem:(%d+):.*|h%[(.*)%]|h|r")
			GameTooltip:ClearLines()
			GameTooltip:SetText(L["Unsafe Item"])
			GameTooltip:AddLine(L["Name:"].." "..itemcolor..itemname.."|r")
			GameTooltip:AddLine(L["ItemID:"].." "..itemid)
			GameTooltip:AddLine(L["This item is unsafe. To view this item without the risk of disconnection, you need to have first seen it in the game world since the last patch. This is a restriction enforced by Blizzard since Patch 1.10."], 1, 1, 1, 1)
			GameTooltip:AddLine(L["You can right-click to attempt to query the server. You may be disconnected."], nil, nil, nil, 1)
			GameTooltip:Show()
		else
			GameTooltip:SetHyperlink(itemLink)
			if self.needupdate then
				WoWEquip:UpdateSlot(self.slotname, itemLink)
				CloseDropDownMenus()
				self.needupdate = nil
			end
		end
	else
		GameTooltip:SetText(_G[self.slotname])
	end
	GameTooltip:Show()
end

local function WoWEquip_CopyTargetButton_OnClick(self)
	if CanInspect("target") then
		if not UnitIsUnit("target", "player") then
			NotifyInspect("target") -- If this isn't called, GetInventoryItemLink() sometimes returns all nils
		end
		local curProfile = WoWEquip.curProfile
		for slotname, button in pairs(WoWEquip.PaperDoll) do
			WoWEquip:UpdateSlot(slotname, GetInventoryItemLink("target", button.slotnum), true)
		end
		local _, race = UnitRace("target")
		local guildname, guildrank = GetGuildInfo("target")
		if not guildname then
			guildname = NONE
		else
			guildname = "<"..guildname..">, "..guildrank
		end
		local faction, class
		if race == "Orc" or race == "Scourge" or race == "Troll" or race == "Tauren" or race == "BloodElf" then
			faction = FACTION_HORDE
		else
			faction = FACTION_ALLIANCE
		end
		local name, realm = UnitName("target")
		if not realm then realm = GetRealmName() end
		class, curProfile.class = UnitClass("target")
		curProfile.name = format("%s (%d): %s (%s)", class, UnitLevel("target"), name, L["Equipped Gear"])
		curProfile.desc = L["%s's equipped gear.\nGuild: %s\nServer: %s, %s\nDate: %s"]:format(name, guildname, realm, faction, date("%m/%d/%y %H:%M:%S"))
		curProfile.race = race
		curProfile.level = UnitLevel("target")

		WoWEquip.frame.BonusFrame.LevelInputBox:SetText(UnitLevel("target"))
		WoWEquip.frame.BonusFrame.ClassButton:SetText(class)

		DressUpModel:SetUnit("target")
		WoWEquip:UpdateBonusFrame()
		WoWEquip:UpdateDressUpModel()
		CloseDropDownMenus()
	end
end

function WoWEquip.ProfileButton_OnClick(self, button, down)
	local WoWEquip_SaveFrame = WoWEquip.SaveFrame
	if WoWEquip_SaveFrame:IsShown() and WoWEquip_SaveFrame.mode == self.mode then
		WoWEquip_SaveFrame:Hide()
	else
		WoWEquip:UpdateSaveFrameMode(self.mode)
		WoWEquip_SaveFrame:Show()
	end
end

local function WoWEquip_GemButton_OnClick(self, button, down)
	if button == "LeftButton" then
		local itemName, itemLink = GetItemInfo(self.info)
		HandleModifiedItemClick(itemLink)
	elseif button == "RightButton" then
		local itemLink = WoWEquip.curProfile.eq[self.slotname]
		local _, _, _, itemLevel, itemMinLevel, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
		local itemId = itemLink:match("item:(%d+):")
		WoWEquip:ScanSockets(itemId, itemEquipLoc, itemLevel, itemMinLevel)

		local frame = self
		if WoWEquip_DropDownMenu.initialize ~= frame.initMenuFunc or WoWEquip_DropDownMenu.owner ~= frame then
			CloseDropDownMenus()
			WoWEquip_DropDownMenu.initialize = frame.initMenuFunc
			WoWEquip_DropDownMenu.owner = frame
		end
		UIDROPDOWNMENU_OPEN_MENU = WoWEquip_DropDownMenu
		ToggleDropDownMenu(2, self.gem, WoWEquip_DropDownMenu, frame, nil, nil, nil, self.socket_texture)
	end
end

local function WoWEquip_GemButton_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	if type(self.info) == "number" then
		GameTooltip:SetHyperlink("item:"..self.info)
		GameTooltip:AddLine(self.color)
	else
		GameTooltip:ClearLines()
		GameTooltip:SetText(self.color)
	end
	local slot = self.slotname
	if (slot == "WRISTSLOT" or slot == "HANDSSLOT") and self.color == _G["EMPTY_SOCKET_NO_COLOR"] then
		GameTooltip:AddLine(SOCKET_ITEM_MIN_SKILL:format(L["Blacksmithing"], 400))
	end
	GameTooltip:Show()
end


----------------------------------------------------------------------------------------
-- Core WoWEquip functions

-- Called by AceAddon-3.0 during ADDON_LOADED with arg1 == "WoWEquip"
function WoWEquip:OnInitialize()
	-- Create savedvariables
	self.db = LibStub("AceDB-3.0"):New("WoWEquipDB", defaults)
	db = self.db.global

	-- Housekeeping
	self:VerifyCompareProfile()
	self.SetSortOption(nil, db.SortOption)

	-- Create the Inspect button if necessary
	if InspectFrame_Show or Examiner then
		self:CreateInspectButton()
		self.CreateInspectButton = nil
		self.ADDON_LOADED = nil
	else
		self:RegisterEvent("ADDON_LOADED")
	end

	-- Apply saved settings
	local t = db.pos.WoWEquip_Frame
	self.frame:SetPoint(t.point, UIParent, t.relpoint, t.offsetx, t.offsety)
	self.frame:SetScale(db.Scale / 100)
	self.frame:SetAlpha(db.Transparency / 100)
	local t = db.pos.WoWEquip_EquipFrame
	self.EquipFrame:SetPoint(t.point, UIParent, t.relpoint, t.offsetx, t.offsety)
	local t = db.pos.WoWEquip_SaveFrame
	self.SaveFrame:SetPoint(t.point, UIParent, t.relpoint, t.offsetx, t.offsety)
	local t = db.pos.WoWEquip_ImportFrame
	self.ImportFrame:SetPoint(t.point, UIParent, t.relpoint, t.offsetx, t.offsety)
	self:SetBackgroundColor(db.r, db.g, db.b, db.a)
	--self:SetBackdropBorderColor(db.br, db.bg, db.bb, db.ba)
	self:SetExtraWidth(db.AddWidth)

	-- Register for comms
	self:RegisterComm("WoWEquipProfile", "OnProfileReceive")
	
	-- Add the /wowequip slash command
	_G.SlashCmdList.WOWEQUIP = self.Show
	_G.SLASH_WOWEQUIP1 = "/wowequip"

	-- Makes WoW close WoWEquip when the Escape key is pressed
	tinsert(_G.UISpecialFrames, "WoWEquip_Frame")

	-- Reclaim some memory
	self.WOWEQUIP_MAIN_BACKDROP = nil
	self.WOWEQUIP_BOX_BACKDROP = nil
	self.WOWEQUIP_BOX_BACKDROP2 = nil

	-- To fix Blizzard's bug caused by the new "self:SetFrameLevel(2);"
	hooksecurefunc("UIDropDownMenu_CreateFrames", WoWEquip.FixMenuFrameLevels)
end

-- Called by AceAddon-3.0 during PLAYER_LOGIN
function WoWEquip:OnEnable()

end

function WoWEquip:Show()
	-- Don't use "self", because the UI slash command doesn't pass self
	WoWEquip.frame:Show()
end

function WoWEquip:Hide()
	WoWEquip.frame:Hide()
end

function WoWEquip:Toggle()
	if WoWEquip.frame:IsShown() then
		WoWEquip.frame:Hide()
	else
		WoWEquip.frame:Show()
	end
end

function WoWEquip:Print(...)
	local text = "|cff33ff99WoWEquip|r:"
	for i = 1, select("#", ...) do
		text = text.." "..tostring(select(i, ...))
	end
	print(text)
end

function WoWEquip:SetExtraWidth(width)
	assert(width >= 0, "Width must not be negative")
	self.frame:SetWidth(336 + width)
	if width > 0 then
		self.frame.bottomTexture:SetWidth(width)
		self.frame.bottomTexture:SetTexCoord(0,width/128,0,1)
		self.frame.bottomTexture:Show()

		self.frame.topTexture:SetWidth(width)
		self.frame.topTexture:SetTexCoord(0,width/128,0,1)
		self.frame.topTexture:Show()
	else 
		self.frame.topTexture:Hide()
		self.frame.bottomTexture:Hide()
	end
	local third_width = width / 3
	self.frame.LoadButton:SetWidth(57 + third_width)
	self.frame.SaveButton:SetWidth(57 + third_width)
	self.frame.SendButton:SetWidth(57 + third_width)

	self.frame.DoneButton:SetWidth(57 + third_width)
	self.frame.CopyTargetButton:SetWidth(114 + 2*third_width)

	self.frame.dragFrame:SetWidth(220 + width)
	self.frame.BonusFrame:SetWidth(222 + width)

	local INITIAL_WIDTH = 188
	local new_width = INITIAL_WIDTH + width
	self.frame.BonusFrame.CompareText:SetWidth(new_width + 10)
	WoWEquip_BonusScrollFrame:SetWidth(new_width)
	local sc = WoWEquip_BonusScrollFrame.ScrollChild
	sc:SetWidth(new_width)
	sc.eqstring:SetWidth(new_width)
	sc.BonusTextL:SetWidth(new_width)
	sc.BonusTextR:SetWidth(new_width)
	sc.dsstring:SetWidth(new_width)
	sc.notestring:SetWidth(new_width)
	sc.BonusTextL2:SetWidth(new_width)
	sc.BonusTextR2:SetWidth(new_width)
	sc.betatext:SetWidth(new_width)
end

function WoWEquip:SetBackgroundColor(r, g, b, a)
	self.frame:SetBackdropColor(r, g, b, a)
	self.EquipFrame.bg:SetVertexColor(r, g, b, a)
	self.ImportFrame.bg:SetVertexColor(r, g, b, a)
	self.SaveFrame.bg:SetVertexColor(r, g, b, a)
	self.OptionFrame.BGColorButton:GetNormalTexture():SetVertexColor(r, g, b)
	db.r = r
	db.g = g
	db.b = b
	db.a = a
end

--[[
function WoWEquip:SetBackdropBorderColor(r, g, b, a)
	self.OptionFrame.BBGColorButton:GetNormalTexture():SetVertexColor(r, g, b)
	db.br = r
	db.bg = g
	db.bb = b
	db.ba = a
end
]]

-- Creates the button to copy inspected target from Blizzard Inspect UI to WoWEquip
function WoWEquip:CreateInspectButton()
	-- if we have examiner, inject a button on the frame.
	local button
	if Examiner then
		button = CreateFrame("Button", nil, Examiner, "OptionsButtonTemplate")
		button:SetWidth(22)
		button:SetHeight(20)
		button:SetText("W")
		button:SetPoint("TOPRIGHT", -36, -32)
		button:SetScript("OnClick", function(self)
			if not WoWEquip.frame:IsShown() then
				-- Do this before CopyTarget because of initialisation code inside OnShow
				WoWEquip.frame:Show()
			end

			if type(Examiner.info.Items) ~= "table" then return end

			local info = Examiner.info
			-- Clear out the current paperdoll
			for i=1, #WOWEQUIP_SLOTS do -- we dont care for ammo
				WoWEquip:UpdateSlot(WOWEQUIP_SLOTS[i], nil, true)
			end

			for slot, itemString in pairs(info.Items) do
				local _, itemLink = GetItemInfo(itemString) -- if the item isn't in the local cache, this will return nil
				WoWEquip:UpdateSlot(slot:upper(), itemLink, true)
			end

			local race = info.raceFixed
			local faction
			if race == "Orc" or race == "Scourge" or race == "Troll" or race == "Tauren" or race == "BloodElf" then
				faction = FACTION_HORDE
			else
				faction = FACTION_ALLIANCE
			end

			local curProfile = WoWEquip.curProfile
			curProfile.name = format("%s (%d): %s (%s)", info.class, info.level, info.name, L["Equipped Gear"])
			curProfile.desc = L["%s's equipped gear.\nGuild: %s\nServer: %s, %s\nDate: %s"]:format(info.name, info.guild or NONE, GetRealmName(), faction, date("%m/%d/%y %H:%M:%S", info.time))
			curProfile.race = race
			curProfile.level = info.level
			curProfile.class = info.classFixed

			WoWEquip.frame.BonusFrame.LevelInputBox:SetText(info.level or UnitLevel("player"))
			WoWEquip.frame.BonusFrame.ClassButton:SetText(info.class)
			WoWEquip:UpdateBonusFrame()
			WoWEquip:UpdateDressUpModel()
			CloseDropDownMenus()
		end)
	else
		button = CreateFrame("Button", nil, InspectPaperDollFrame, "OptionsButtonTemplate")
		button:SetWidth(98)
		button:SetHeight(22)
		button:SetText("WoWEquip")
		button:SetPoint("BOTTOMRIGHT", -40, 84)
		button:SetScript("OnClick", function(self)
			if not WoWEquip.frame:IsShown() then
				if CanInspect("target") then
					-- Do this before CopyTarget because of initialisation code inside OnShow
					WoWEquip:Show()
					WoWEquip.frame.CopyTargetButton:Click()
				end
			else
				WoWEquip:Hide()
			end
		end)
	end
	self.InspectButton = button
end

function WoWEquip:UNIT_INVENTORY_CHANGED(event, unit)
	if unit == "player" and db.CompareOption == 2 then
		-- No need to check if WoWEquip_Frame:IsVisible() because we register/unregister it on show/hide
		self:UpdateBonusFrame()
	end
end

function WoWEquip:ADDON_LOADED(event, addon)
	if addon == "Blizzard_InspectUI" then
		self:CreateInspectButton()
		self.CreateInspectButton = nil
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
	end
end

function WoWEquip:UpdateDressUpModel()
	if DressUpFrame:IsShown() then
		DressUpModel:RefreshUnit()
		DressUpModel:Undress()
		local eq = self.curProfile.eq
		for i = #WOWEQUIP_SLOTS, 1, -1 do
			local k = WOWEQUIP_SLOTS[i]
			local v = eq[k]
			if v and GetItemInfo(v) then -- Trying on an uncached item counts as requesting the link
				if (k ~= "BACKSLOT" and k ~= "HEADSLOT") or (k == "BACKSLOT" and db.ShowCloak) or (k == "HEADSLOT" and db.ShowHelm) then
					DressUpModel:TryOn(v)
				end
			end
		end
	end
end

-- Updates the internal table with itemLink in the slot slotname. Also updates
-- the button visually. The skipUpdate flag allows the caller to skip updating
-- the dressing room and bonus frame for bulk calls.
local gemsockets = {}
function WoWEquip:UpdateSlot(slotname, itemLink, skipUpdate)
	local oldLink = self.curProfile.eq[slotname]
	self.curProfile.eq[slotname] = itemLink
	local button = self.PaperDoll[slotname]
	local _, itemRarity, itemLevel, itemMinLevel, itemEquipLoc, itemTexture
	local r, g, b, h = GetItemQualityColor(-1)
	for k = 1, 3 do
		button[k]:Hide()
	end
	if itemLink then
		-- Update the button
		_, _, itemRarity, itemLevel, itemMinLevel, _, _, _, itemEquipLoc, itemTexture = GetItemInfo(itemLink)
		itemTexture = itemTexture or "Interface\\Icons\\INV_Misc_QuestionMark"
		if itemRarity then
			r, g, b = GetItemQualityColor(itemRarity)
		else
			for i = 6, -1, -1 do
				r, g, b, h = GetItemQualityColor(i)
				if strfind(itemLink, h) then break end
			end
		end
		button.border:SetVertexColor(r, g, b, 1)
		button.border:Show()

		-- Now update the sockets
		if itemRarity then
			local itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, levelId = strmatch(itemLink, "item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+):(%d+)")
			WoWEquip:ScanSockets(itemId, itemEquipLoc, itemLevel, itemMinLevel)
			wipe(gemsockets)
			gemsockets[1], gemsockets[2], gemsockets[3] = tonumber(jewelId1), tonumber(jewelId2), tonumber(jewelId3)
			for k = 1, 3 do
				local socket = sockets[k]
				if socket then
					local gemLink = select(2, GetItemGem(itemLink, k))
					if gemLink then
						gemsockets[k] = tonumber(gemLink:match("item:(%d+):"))
					else
						-- Either there's no gem, or the gem is not in the cache
						if gemsockets[k] ~= 0 then
							gemsockets[k] = self:FindGemItemID(self.GemData[EMPTY_SOCKET_BLUE], gemsockets[k]) or self:FindGemItemID(self.GemData[EMPTY_SOCKET_META], gemsockets[k])
						end
					end
					if gemsockets[k] and gemsockets[k] ~= 0 then
						button[k].socket_texture:Hide()
						button[k].gem_texture:SetTexture(select(10, GetItemInfo(gemsockets[k])) or "Interface\\Icons\\INV_Misc_QuestionMark")
						button[k].gem_texture:Show()
						local slot_color = WOWEQUIP_SOCKET_COLOR[socket]
						button[k].overlay_texture:SetVertexColor( slot_color[1], slot_color[2], slot_color[3] )
						button[k].overlay_texture:Show()

						button[k].info = gemsockets[k]
					else
						button[k].socket_texture:SetTexture(WOWEQUIP_SOCKET_ICONPATH[socket])
						button[k].socket_texture:Show()
						button[k].gem_texture:Hide()
						button[k].overlay_texture:Hide()
						button[k].info = nil
					end
					button[k].color = socket
					button[k]:Show()
				end
			end
		end
	else
		_, itemTexture = GetInventorySlotInfo(slotname)
		button.border:Hide()
	end
	SetItemButtonTexture(button, itemTexture)
	if self.EquipFrame:IsVisible() and self.EquipFrame.pointer.slotname == slotname then
		AnimatedShine_Start(WoWEquip_PaperDoll1, r, g, b)
	end

	if not skipUpdate then
		self:UpdateBonusFrame()
		if DressUpFrame:IsShown() then
			if itemRarity then -- Trying on an uncached item counts as requesting the link
				if (slotname ~= "BACKSLOT" and slotname ~= "HEADSLOT") or
				   (slotname == "BACKSLOT" and db.ShowCloak) or
				   (slotname == "HEADSLOT" and db.ShowHelm) then
					DressUpModel:TryOn(itemLink)
				end
			elseif oldLink ~= nil then -- Uncached item and previous link isn't nil
				-- Full update necessary to undress an item
				self:UpdateDressUpModel()
			end
		end
	end
end

-- Given a table t from WoWEquip.EnchantData["itemEquipLoc"], find out if enchantID
-- exists for that itemEquipLoc and is usable on an item
function WoWEquip:IsEnchantUsable(t, enchantID, itemLevel, itemMinLevel)
	if type(t) ~= "table" or enchantID == 0 then return false end
	for i = 1, #t do
		local v = t[i]
		if type(v[1]) == "number" then
			if v[1] == enchantID then -- EnchantID found
				if v[3] and itemMinLevel > 0 and v[3] > itemMinLevel then
					return false -- Doesn't meet itemMinLevel requirement
				elseif v[3] and v[3] < 0 and -v[3] > itemLevel then
					return false -- Doesn't meet itemLevel requirement
				else
					return true
				end
			end
		else
			if self:IsEnchantUsable(v, enchantID, itemLevel, itemMinLevel) then return true end
		end
	end
	return false
end

-- Given a table t from WoWEquip.GemData and an enchantID, find the gemID
function WoWEquip:FindGemItemID(t, enchantID)
	if type(t) ~= "table" or enchantID == 0 then return 0 end
	for i = 1, #t do
		local v = t[i]
		if type(v[1]) == "number" then
			if v[1] == enchantID then -- EnchantID found
				return v[2]
			end
		else
			local g = self:FindGemItemID(v, enchantID)
			if g then return g end
		end
	end
end

-- Given a table t from WoWEquip.GemData and an gemID, find the enchantID
function WoWEquip:FindGemEnchantID(t, gemID)
	if type(t) ~= "table" or gemID == 0 then return 0 end
	for i = 1, #t do
		local v = t[i]
		if type(v[1]) == "number" then
			if v[2] == gemID then -- gemID found
				return v[1]
			end
		else
			local g = self:FindGemEnchantID(v, gemID)
			if g then return g end
		end
	end
end

local ITEM_SOCKET_BONUS_R = ITEM_SOCKET_BONUS:gsub("%%s", "(.*)")
function WoWEquip:ScanSockets(itemId, itemEquipLoc, itemLevel, itemMinLevel)
	local count = 0
	wipe(sockets)
	WoWEquip_Tooltip:ClearLines()
	WoWEquip_Tooltip:SetHyperlink("item:"..itemId)

	for i = 2, WoWEquip_Tooltip:NumLines() do
		local text = WoWEquip_Tooltip.left[i]:GetText()
		for k in pairs(self.GemData) do
			if strfind(text, k, 1, true) then
				count = count + 1
				sockets[count] = text
				break
			end
		end
		if strfind(text, ITEM_SOCKET_BONUS_R) then break end
	end

	-- For the blacksmith sockets and belt buckles
	if itemLevel >= 65 or itemMinLevel >= 60 then
		if itemEquipLoc == "INVTYPE_HAND" or itemEquipLoc == "INVTYPE_WRIST" or itemEquipLoc == "INVTYPE_WAIST" then
			count = count + 1
			sockets[count] = EMPTY_SOCKET_NO_COLOR
		end
	end
end

function WoWEquip:ChangeItemLinkLevel(itemLink, level)
	-- Change levelId
	return itemLink:gsub("(item:%d+:%d+:%d+:%d+:%d+:%d+:[-]?%d+:[-]?%d+):(%d+)|", "%1:"..level.."|")
end

function WoWEquip:ChangeAllItemLinkLevels(level)
	local eq = self.curProfile.eq
	for slotname, itemLink in pairs(eq) do
		eq[slotname] = self:ChangeItemLinkLevel(itemLink, level)
	end
	self:UpdateBonusFrame()
end


----------------------------------------------------------------------------------------
-- WoWEquip Paper Doll menu functions

function WoWEquip.ClearSlot(dropdownbutton, arg1, arg2, checked)
	WoWEquip:UpdateSlot(arg1, nil, true)
	WoWEquip:UpdateBonusFrame()
	WoWEquip:UpdateDressUpModel()
end

function WoWEquip.QueryServer(dropdownbutton, arg1, arg2, checked)
	WoWEquip.PaperDoll[arg1].needupdate = GetTime()
	GameTooltip:SetHyperlink(WoWEquip.curProfile.eq[arg1])
end

local function FavMenuSortFunc(a, b)
	return LE[a[2]] < LE[b[2]] -- arrange by name
end

function WoWEquip.ApplyEnchant(dropdownbutton, arg1, arg2, checked)
	local slotname = WoWEquip_DropDownMenu.owner.slotname
	local itemLink = WoWEquip.curProfile.eq[slotname]
	local id = arg2[1]
	local itemLinkPart = arg1.itemLinkPart
	if itemLinkPart == 0 then -- Replace enchantId
		itemLink = itemLink:gsub("(item:%d+):(%d+):", "%1:"..id..":")
	elseif itemLinkPart == 1 then -- Replace jewelId1
		itemLink = itemLink:gsub("(item:%d+:%d+):(%d+):", "%1:"..id..":")
	elseif itemLinkPart == 2 then -- Replace jewelId2
		itemLink = itemLink:gsub("(item:%d+:%d+:%d+):(%d+):", "%1:"..id..":")
	elseif itemLinkPart == 3 then -- Replace jewelId3
		itemLink = itemLink:gsub("(item:%d+:%d+:%d+:%d+):(%d+):", "%1:"..id..":")
	elseif itemLinkPart == 4 then -- Replace jewelId4
		itemLink = itemLink:gsub("(item:%d+:%d+:%d+:%d+:%d+):(%d+):", "%1:"..id..":")
	end

	if IsShiftKeyDown() then
		if WoWEquip.curProfile.eq[slotname] == itemLink then
			_G[dropdownbutton:GetName().."Check"]:Show()
		else
			_G[dropdownbutton:GetName().."Check"]:Hide()
		end
		local activeWindow = ChatEdit_GetActiveWindow and ChatEdit_GetActiveWindow() or ChatFrameEditBox -- For pre-3.3.5 compat
		if activeWindow and activeWindow:IsVisible() then
			if arg2[2] > 0 then
				local _, itemLink = GetItemInfo(arg2[2])
				activeWindow:Insert(" "..itemLink)
			elseif arg2[2] < 0 then
				activeWindow:Insert(" "..GetSpellLink(-arg2[2]))
			end
		elseif BrowseName and BrowseName:IsVisible() then  -- AH search editbox
			if arg2[2] > 0 then
				BrowseName:SetText(GetItemInfo(arg2[2]) or "")
			elseif arg2[2] < 0 then
				-- Extract out the enchant name
				BrowseName:SetText(strmatch(LE[arg2[2]], "%((.-)%)") or "")
			end
		end
		return
	end

	if IsControlKeyDown() then
		if WoWEquip.curProfile.eq[slotname] == itemLink then
			_G[dropdownbutton:GetName().."Check"]:Show()
		else
			_G[dropdownbutton:GetName().."Check"]:Hide()
		end
		if id ~= 0 then
			db.favorites[arg1.menuID] = db.favorites[arg1.menuID] or {}
			local fav = db.favorites[arg1.menuID]
			if tContains(fav, arg2) then -- tContains() and tDeleteItem() are defined in UIParent.lua
				tDeleteItem(fav, arg2)
				if #fav == 0 then db.favorites[arg1.menuID] = nil end
				WoWEquip:Print(format(L["\34%s\34 removed from Favorites."], LE[arg2[2]]))
			else
				tinsert(fav, arg2)
				sort(fav, FavMenuSortFunc)
				WoWEquip:Print(format(L["\34%s\34 added to Favorites."], LE[arg2[2]]))
			end
		end
		return
	end

	if itemLinkPart > 0 and itemLinkPart <= 3 then -- Just 1 item ingame with 4 sockets (27497) -- suck it :P
		local b = WoWEquip.PaperDoll[slotname][itemLinkPart]
		if arg2[2] > 0 then
			b.socket_texture:Hide()
			b.gem_texture:SetTexture(select(10, GetItemInfo(arg2[2])) or "Interface\\Icons\\INV_Misc_QuestionMark")
			b.gem_texture:Show()
			local slot_color = WOWEQUIP_SOCKET_COLOR[arg1.menuID]
			b.overlay_texture:SetVertexColor( slot_color[1], slot_color[2], slot_color[3] )
			b.overlay_texture:Show()
			b.info = arg2[2]
		else
			b.socket_texture:SetTexture(WOWEQUIP_SOCKET_ICONPATH[arg1.menuID])
			b.socket_texture:Show()
			b.gem_texture:Hide()
			b.overlay_texture:Hide()
			b.info = nil
		end
	end
	WoWEquip.curProfile.eq[slotname] = itemLink
	WoWEquip:UpdateBonusFrame()
	if DressUpFrame:IsShown() then
		if (slotname ~= "BACKSLOT" and slotname ~= "HEADSLOT") or (slotname == "BACKSLOT" and db.ShowCloak) or (slotname == "HEADSLOT" and db.ShowHelm) then
			DressUpModel:TryOn(itemLink)
		end
	end
	CloseDropDownMenus(2)
end

function WoWEquip.ItemSlotMenu(self, level)
	if not level then return end
	local slotname = self.owner.slotname
	local link = WoWEquip.curProfile.eq[slotname]
	local info = self.info
	wipe(info)

	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(link)
	-- Adjust for Bind on Account items
	if itemRarity == 7 and itemLevel == 1 and itemMinLevel == 0 then
		itemMinLevel = 1
	end

	if level == 1 then
		info.isTitle = 1
		info.text = itemName or strmatch(link, "|c.*|Hitem:.*|h%[(.*)%]|h|r")
		info.notCheckable = 1
		info.icon = itemTexture or "Interface\\Icons\\INV_Misc_QuestionMark"
		UIDropDownMenu_AddButton(info, level)

		info.disabled = nil
		info.isTitle = nil
		info.icon = nil

		if itemName then
			-- Menu for item that is in local cache
			info.hasArrow = 1
			info.func = self.UncheckHack
			info.keepShownOnClick = 1

			-- If the item is enchantable, create the Enchant menu item
			-- Submenu receives a string to indicate which enchant menu to use
			if WoWEquip.EnchantData[itemEquipLoc] then
				-- If its a ranged item, exclude anything not a crossbow/gun (such as wands and Egan's Blaster)
				if itemEquipLoc ~= "INVTYPE_RANGEDRIGHT" or (itemSubType == LGII["Crossbows"] or itemSubType == LGII["Guns"]) then
					info.text = ENSCRIBE
					if itemSubType == LGII["Fishing Poles"] then
						info.value = "FishingEnchants"
					elseif itemType == LGII["Weapon"] and itemSubType == LGII["Staves"] then
						info.value = "StaffEnchants"
					elseif itemType == LGII["Weapon"] and itemSubType == LGII["Miscellaneous"] then
						info.value = "NoEnchants"
					else
						info.value = itemEquipLoc
					end
					UIDropDownMenu_AddButton(info, level)
				end
			end

			-- If the item has sockets, create a menu item for each socket
			-- Submenu receives a number to indicate which gem slot it is
			local itemId = strmatch(itemLink, "item:(%d+):")
			WoWEquip:ScanSockets(itemId, itemEquipLoc, itemLevel, itemMinLevel)
			for k = 1, #sockets do
				info.text = sockets[k]
				info.value = k
				UIDropDownMenu_AddButton(info, level)
			end
		else
			-- Menu for item that is not in local cache
			-- Query Server menu item
			info.text = L["Query server for this item"]
			info.func = WoWEquip.QueryServer
			info.arg1 = slotname
			UIDropDownMenu_AddButton(info, level)
		end

		-- Clear Slot menu item
		info.notCheckable = 1
		info.hasArrow = nil
		info.checked = nil
		info.text = L["Unequip this slot"]
		info.func = WoWEquip.ClearSlot
		info.arg1 = slotname
		UIDropDownMenu_AddButton(info, level)

		-- Close menu item
		info.arg1 = nil
		info.text = CLOSE
		info.func = self.HideMenu
		UIDropDownMenu_AddButton(info, level)

	else
		-- Title of menu
		info.isTitle = 1
		info.notCheckable = 1
		if level == 2 then
			local itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, levelId = strmatch(link, "item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+):(%d+)")
			if type(UIDROPDOWNMENU_MENU_VALUE) == "number" then
				-- Gems submenu
				local socket = sockets[UIDROPDOWNMENU_MENU_VALUE]
				info.text = socket
				info.icon = WOWEQUIP_SOCKET_ICONPATH[socket]

				-- Pass some data down
				wipe(self.data)
				self.data.itemLinkPart = UIDROPDOWNMENU_MENU_VALUE
				self.data.enchantID = tonumber((select(UIDROPDOWNMENU_MENU_VALUE, jewelId1, jewelId2, jewelId3, jewelId4)))
				self.data.menuID = socket

				UIDROPDOWNMENU_MENU_VALUE = WoWEquip.GemData[socket]
			else
				-- Enchants submenu
				info.text = ENSCRIBE

				-- Pass some data down
				wipe(self.data)
				self.data.itemLinkPart = 0
				self.data.enchantID = tonumber(enchantId)
				self.data.menuID = UIDROPDOWNMENU_MENU_VALUE

				UIDROPDOWNMENU_MENU_VALUE = WoWEquip.EnchantData[UIDROPDOWNMENU_MENU_VALUE]
			end
		elseif level == 3 and UIDROPDOWNMENU_MENU_VALUE == "Favorites" then
			-- Redirect our menu to the stored favorites
			info.text = L["Favorites"]
			if WoWEquip.db.global.favorites[self.data.menuID] then
				UIDROPDOWNMENU_MENU_VALUE = WoWEquip.db.global.favorites[self.data.menuID]
			else
				UIDROPDOWNMENU_MENU_VALUE = WoWEquip.EnchantData["NoEnchants"]
			end
		else
			info.text = UIDROPDOWNMENU_MENU_VALUE.t
		end
		UIDropDownMenu_AddButton(info, level)

		-- Wrapper to genarate dynamic submenu creation from data tables, as many sublevels as defined.
		local flag = true
		for i = 1, #UIDROPDOWNMENU_MENU_VALUE do
			local v = UIDROPDOWNMENU_MENU_VALUE[i]
			wipe(info)
			info.keepShownOnClick = 1
			if v.t then -- Parent node
				info.notCheckable = 1
				info.hasArrow = 1
				info.func = self.UncheckHack
				info.text = v.t
				info.value = v
				flag = false
			else -- Leaf node
				info.text = gsub(LE[v[2]], "(%(.-%))", "|cFF00FF00%1|r") -- Makes all brackets green
				info.text = gsub(info.text, "|cFF00FF00", "|cFFFFD200", 1) -- Makes the first bracket yellow
				if v[3] then info.text = info.text.." |cFF00FF00"..L["(Lvl %d+)"]:format(v[3]) end
				info.arg1 = self.data
				info.arg2 = v
				info.func = WoWEquip.ApplyEnchant
				if v[2] > 0 then
					info.icon = GetItemIcon(v[2])
					info.tooltipTitle = "WoWEquipShowTooltip"
					info.tooltipText = v[2]
				elseif v[2] < 0 then
					info.icon = select(3, GetSpellInfo(-v[2]))
					info.tooltipTitle = "WoWEquipShowTooltip"
					info.tooltipText = v[2]
				end
				info.disabled = (v[1] == -1) -- Unknown enchantID
					or (v[3] and itemMinLevel > 0 and v[3] > itemMinLevel) -- itemMinLevel requirement
					or (v[3] and v[3] < 0 and -v[3] > itemLevel) -- itemLevel requirement
				info.checked = v[1] == self.data.enchantID
			end
			UIDropDownMenu_AddButton(info, level)
		end

		-- Add None menu item for leaf nodes
		if flag then
			wipe(info)
			info.keepShownOnClick = 1
			info.text = NONE
			info.arg1 = self.data
			info.arg2 = WoWEquip.EnchantData["NoEnchants2"]
			info.checked = self.data.enchantID == 0
			info.func = WoWEquip.ApplyEnchant
			UIDropDownMenu_AddButton(info, level)
		end

		-- Add Favorites menu for Level 2 menus
		if level == 2 and self.data.menuID ~= "NoEnchants" then
			wipe(info)
			info.notCheckable = 1
			info.hasArrow = 1
			info.func = self.UncheckHack
			info.text = L["Favorites"]
			info.value = "Favorites"
			UIDropDownMenu_AddButton(info, level)
		end
	end
end

-- To fix Blizzard's bug caused by the new "self:SetFrameLevel(2);"
local function FixFrameLevel(level, ...)
	for i = 1, select("#", ...) do
		local button = select(i, ...)
		button:SetFrameLevel(level)
	end
end
function WoWEquip.FixMenuFrameLevels()
	local f = DropDownList1
	local i = 1
	while f do
		FixFrameLevel(f:GetFrameLevel() + 2, f:GetChildren())
		i = i + 1
		f = _G["DropDownList"..i]
	end
end


----------------------------------------------------------------------------------------
-- Create the frames used by the core WoWEquip window

do
	-- Create the main WoWEquip frame
	local WoWEquip_Frame = CreateFrame("Frame", "WoWEquip_Frame", UIParent)
	WoWEquip_Frame:Hide()
	WoWEquip_Frame:SetWidth(336)
	WoWEquip_Frame:SetHeight(422)
	WoWEquip_Frame:SetBackdrop({
		bgFile = [[Interface\Buttons\WHITE8X8]],
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	WoWEquip_Frame:EnableMouse(true)
	WoWEquip_Frame:SetToplevel(true)
	WoWEquip_Frame:SetClampedToScreen(true)
	WoWEquip_Frame:SetMovable(true)
	WoWEquip_Frame:SetUserPlaced(nil)
	WoWEquip_Frame:SetScript("OnShow", WoWEquip_Frame_OnShow)
	WoWEquip_Frame:SetScript("OnHide", WoWEquip_Frame_OnHide)
	WoWEquip.frame = WoWEquip_Frame

	-- This creates the WoWEquip title text
	temp = WoWEquip_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	temp:SetPoint("TOP", 35, -3)
	temp:SetText(WoWEquip.versionstring)
	WoWEquip_Frame.titleText = temp

	-- This creates a transparent textureless draggable frame to move WoWEquip, and saves the
	-- position after a drag. It overlaps the above title text and texture (more or less) exactly.
	temp = CreateFrame("Frame", nil, WoWEquip_Frame)
	temp:SetWidth(220)
	temp:SetHeight(20)
	temp:SetPoint("TOPRIGHT", -25, 0)
	temp:EnableMouse(true)
	temp:RegisterForDrag("LeftButton")
	temp:SetScript("OnDragStart", WoWEquip.Generic_StartMoving)
	temp:SetScript("OnDragStop", WoWEquip.Generic_StopMovingOrSizing)
	WoWEquip_Frame.dragFrame = temp

	-- Apply textures
	local temp = WoWEquip_Frame:CreateTexture( nil, "ARTWORK" )
	temp:SetTexture( [[Interface\AddOns\WoWEquip\Artwork\WoWEquip-TopLeft]] )
	temp:SetWidth(256)
	temp:SetHeight(256)
	temp:SetPoint("TOPLEFT", -13, 14)
	WoWEquip_Frame.topLeftTexture = temp

	temp = WoWEquip_Frame:CreateTexture( nil, "ARTWORK" )
	temp:SetTexture( [[Interface\AddOns\WoWEquip\Artwork\WoWEquip-TopRight]] )
	temp:SetWidth(128)
	temp:SetHeight(256)
	temp:SetPoint("TOPRIGHT", 35, 14)
	WoWEquip_Frame.topRightTexture = temp

	temp = WoWEquip_Frame:CreateTexture( nil, "ARTWORK" )
	temp:SetTexture( [[Interface\AddOns\WoWEquip\Artwork\WoWEquip-BottomLeft]] )
	temp:SetWidth(256)
	temp:SetHeight(256)
	temp:SetPoint("TOPLEFT", -13, 14-256)
	WoWEquip_Frame.bottomLeftTexture = temp

	temp = WoWEquip_Frame:CreateTexture( nil, "ARTWORK" )
	temp:SetTexture( [[Interface\AddOns\WoWEquip\Artwork\WoWEquip-BottomRight]] )
	temp:SetWidth(128)
	temp:SetHeight(256)
	temp:SetPoint("TOPRIGHT", 35, 14-256)
	WoWEquip_Frame.bottomRightTexture = temp

	-- 2 textures used to fill while stretching the frame
	temp = WoWEquip_Frame:CreateTexture( nil, "ARTWORK" )
	temp:SetTexture( [[Interface\AddOns\WoWEquip\Artwork\WoWEquip-Top]] )
	temp:SetWidth(1)
	temp:SetHeight(256)
	temp:SetPoint("TOPRIGHT", -93, 14)
	temp:Hide()
	WoWEquip_Frame.topTexture = temp

	temp = WoWEquip_Frame:CreateTexture( nil, "ARTWORK" )
	temp:SetTexture( [[Interface\AddOns\WoWEquip\Artwork\WoWEquip-Bottom]] )
	temp:SetWidth(1)
	temp:SetHeight(256)
	temp:SetPoint("TOPRIGHT", -93, 14-256)
	temp:Hide()
	WoWEquip_Frame.bottomTexture = temp

	-- Create the Close button
	temp = CreateFrame("Button", nil, WoWEquip_Frame, "UIPanelCloseButton")
	temp:SetPoint("TOPRIGHT", 5, 6)
	temp:SetHitRectInsets(5, 5, 5, 5)
	temp:SetScript("OnClick", WoWEquip.Generic_Hide)
	WoWEquip_Frame.CloseButton = temp

	-- Create the Done button
	temp = CreateFrame("Button", nil, WoWEquip_Frame, "OptionsButtonTemplate")
	temp:SetWidth(57)
	temp:SetHeight(22)
	temp:SetPoint("BOTTOMRIGHT", -4, 4)
	temp:SetText(DONE)
	temp:SetScript("OnClick", WoWEquip.Generic_Hide)
	WoWEquip_Frame.DoneButton = temp

	-- Create the 19 Paper Doll buttons
	WoWEquip.PaperDoll = {}
	for i = 1, #WOWEQUIP_SLOTS do
		local slotname = WOWEQUIP_SLOTS[i]
		local texture
		temp = CreateFrame("Button", "WoWEquip_PaperDoll"..i, WoWEquip_Frame, "ItemButtonTemplate")
		temp:SetHeight(37)
		temp:SetWidth(37)
		temp:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		temp:SetScript("OnClick", WoWEquip_PaperDollButton_OnClick)
		temp:SetScript("OnEnter", WoWEquip_PaperDollButton_OnEnter)
		temp:SetScript("OnLeave", WoWEquip.Generic_OnLeave)
		temp:SetScript("OnHide", WoWEquip_DropDownMenu.HideMenu)
		temp.initMenuFunc = WoWEquip.ItemSlotMenu
		temp.border = temp:CreateTexture(nil, "OVERLAY")
		temp.border:Hide()
		temp.border:SetTexture("Interface\\AddOns\\WoWEquip\\Artwork\\WoWEquip-QualityOverlay" )
		temp.border:SetWidth(70)
		temp.border:SetHeight(70)
		temp.border:SetAlpha(0.8)
		temp.border:SetPoint("CENTER", temp)
		temp.border:SetBlendMode("ADD")
		temp.slotname = slotname
		temp.slotnum, texture = GetInventorySlotInfo(slotname)
		SetItemButtonTexture(temp, texture)
		WoWEquip.PaperDoll[slotname] = temp
		-- And the 3 gem buttons next to them
		for j = 1, 3 do
			local b = CreateFrame("Button", "WoWEquip_PaperDoll"..i.."GemButton"..j, temp)
			b:SetWidth(13)
			b:SetHeight(13)

			b.gem_texture = b:CreateTexture(nil, "ARTWORK")
			b.gem_texture:SetWidth(9)
			b.gem_texture:SetHeight(9)
			--                       (   6/64,   58/64,    6/64,   58/64)
			b.gem_texture:SetTexCoord(0.09375, 0.90625, 0.09375, 0.90625)
			b.gem_texture:SetPoint("CENTER", b, "CENTER")

			b.socket_texture = b:CreateTexture(nil, "BACKGROUND")
			b.socket_texture:SetWidth(15)
			b.socket_texture:SetHeight(15)
			b.socket_texture:SetPoint("CENTER", b, "CENTER")

			b.overlay_texture = b:CreateTexture(nil, "OVERLAY")
			b.overlay_texture:SetTexture( [[Interface\AddOns\WoWEquip\Artwork\WoWEquip-SocketOverlay]] )
			b.overlay_texture:SetWidth(14)
			b.overlay_texture:SetHeight(14)
			b.overlay_texture:SetPoint("CENTER", b, "CENTER")

			b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
			b:SetScript("OnClick", WoWEquip_GemButton_OnClick)
			b:SetScript("OnEnter", WoWEquip_GemButton_OnEnter)
			b:SetScript("OnLeave", WoWEquip.Generic_OnLeave)
			b:SetScript("OnHide", WoWEquip_DropDownMenu.HideMenu)
			b:Hide()
			b.initMenuFunc = WoWEquip.ItemSlotMenu
			b.gem = j
			b.slotname = slotname
			temp[j] = b
		end
		temp[1]:SetPoint("TOPLEFT", temp, "TOPRIGHT", 1, 0)
		temp[2]:SetPoint("TOPLEFT", temp[1], "BOTTOMLEFT", 0, 0)
		temp[3]:SetPoint("TOPLEFT", temp[2], "BOTTOMLEFT", 0, 0)
	end
	temp = WoWEquip.PaperDoll
	temp.HEADSLOT:SetPoint("TOPLEFT", WoWEquip_Frame, "TOPLEFT", 5, -51)
	temp.NECKSLOT:SetPoint("TOPLEFT", temp.HEADSLOT, "BOTTOMLEFT", 0, -4)
	temp.SHOULDERSLOT:SetPoint("TOPLEFT", temp.NECKSLOT, "BOTTOMLEFT", 0, -4)
	temp.BACKSLOT:SetPoint("TOPLEFT", temp.SHOULDERSLOT, "BOTTOMLEFT", 0, -4)
	temp.CHESTSLOT:SetPoint("TOPLEFT", temp.BACKSLOT, "BOTTOMLEFT", 0, -4)
	temp.SHIRTSLOT:SetPoint("TOPLEFT", temp.CHESTSLOT, "BOTTOMLEFT", 0, -4)
	temp.TABARDSLOT:SetPoint("TOPLEFT", temp.SHIRTSLOT, "BOTTOMLEFT", 0, -4)
	temp.WRISTSLOT:SetPoint("TOPLEFT", temp.TABARDSLOT, "BOTTOMLEFT", 0, -4)
	temp.HANDSSLOT:SetPoint("TOPLEFT", temp.HEADSLOT, "TOPRIGHT", 17, 0)
	temp.WAISTSLOT:SetPoint("TOPLEFT", temp.HANDSSLOT, "BOTTOMLEFT", 0, -4)
	temp.LEGSSLOT:SetPoint("TOPLEFT", temp.WAISTSLOT, "BOTTOMLEFT", 0, -4)
	temp.FEETSLOT:SetPoint("TOPLEFT", temp.LEGSSLOT, "BOTTOMLEFT", 0, -4)
	temp.FINGER0SLOT:SetPoint("TOPLEFT", temp.FEETSLOT, "BOTTOMLEFT", 0, -4)
	temp.FINGER1SLOT:SetPoint("TOPLEFT", temp.FINGER0SLOT, "BOTTOMLEFT", 0, -4)
	temp.TRINKET0SLOT:SetPoint("TOPLEFT", temp.FINGER1SLOT, "BOTTOMLEFT", 0, -4)
	temp.TRINKET1SLOT:SetPoint("TOPLEFT", temp.TRINKET0SLOT, "BOTTOMLEFT", 0, -4)
	temp.MAINHANDSLOT:SetPoint("TOPLEFT", temp.WRISTSLOT, "BOTTOMLEFT", 0, -4)
	temp.SECONDARYHANDSLOT:SetPoint("TOPLEFT", temp.MAINHANDSLOT, "TOPRIGHT", 17, 0)
	temp.RANGEDSLOT:SetPoint("TOPLEFT", temp.SECONDARYHANDSLOT, "TOPRIGHT", 17, 0)

	-- Create the Shine
	temp = CreateFrame("Frame", "WoWEquip_PaperDoll1Shine", WoWEquip_Frame, "AnimatedShineTemplate")
	temp:Hide()
	RaiseFrameLevel(temp)
	WoWEquip.PaperDoll1Shine = temp

	-- Create the Copy Target button
	temp = CreateFrame("Button", nil, WoWEquip_Frame, "OptionsButtonTemplate")
	temp:SetWidth(114)
	temp:SetHeight(22)
	temp:SetPoint("RIGHT", WoWEquip_Frame.DoneButton, "LEFT", 3, 0)
	temp:SetText(L["Copy Target"])
	temp:SetScript("OnUpdate", function(self, elapsed)
		if CanInspect("target") then self:Enable() else self:Disable() end
	end)
	temp:SetScript("OnClick", WoWEquip_CopyTargetButton_OnClick)
	WoWEquip_Frame.CopyTargetButton = temp

	-- Create the Toggle Dressing Room button
	temp = CreateFrame("Button", nil, WoWEquip_Frame)
	temp:SetWidth(24)
	temp:SetHeight(23)
	temp:SetPoint("TOPLEFT", -1, 2)
	temp:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
	temp:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
	temp:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")
	temp:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	temp:SetScript("OnClick", function(self)
		if DressUpFrame:IsShown() then
			HideUIPanel(DressUpFrame)
		else
			ShowUIPanel(DressUpFrame)
			DressUpFrame:SetScale(db.DRScale / 100)
			WoWEquip:UpdateDressUpModel()
		end
	end)
	WoWEquip_Frame.ToggleDressingRoomButton = temp
	hooksecurefunc(DressUpFrame, "Show", function(self)
		local t = WoWEquip_Frame.ToggleDressingRoomButton
		t:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
		t:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
		t:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
	end)
	hooksecurefunc(DressUpFrame, "Hide", function(self)
		local t = WoWEquip_Frame.ToggleDressingRoomButton
		t:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
		t:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
		t:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")
	end)

	-- Create the Send button
	temp = CreateFrame("Button", nil, WoWEquip_Frame, "OptionsButtonTemplate")
	temp:SetWidth(57)
	temp:SetHeight(22)
	temp:SetPoint("BOTTOMRIGHT", WoWEquip_Frame, "BOTTOMRIGHT", -4, 25)
	temp:SetText(L["Send"].."...")
	temp:SetScript("OnClick", WoWEquip.ProfileButton_OnClick)
	temp.mode = "send"
	WoWEquip_Frame.SendButton = temp

	-- Create the Save button
	temp = CreateFrame("Button", nil, WoWEquip_Frame, "OptionsButtonTemplate")
	temp:SetWidth(57)
	temp:SetHeight(22)
	temp:SetPoint("RIGHT", WoWEquip_Frame.SendButton, "LEFT", 2, 0)
	temp:SetText(L["Save"].."...")
	temp:SetScript("OnClick", WoWEquip.ProfileButton_OnClick)
	temp.mode = "save"
	WoWEquip_Frame.SaveButton = temp

	-- Create the Load button
	temp = CreateFrame("Button", nil, WoWEquip_Frame, "OptionsButtonTemplate")
	temp:SetWidth(57)
	temp:SetHeight(22)
	temp:SetPoint("RIGHT", WoWEquip_Frame.SaveButton, "LEFT", 2, 0)
	temp:SetText(L["Load"].."...")
	temp:SetScript("OnClick", WoWEquip.ProfileButton_OnClick)
	temp.mode = "load"
	WoWEquip_Frame.LoadButton = temp

	-- Create the Options button
	temp = CreateFrame("Button", nil, WoWEquip_Frame, "OptionsButtonTemplate")
	temp:SetWidth(69)
	temp:SetHeight(19)
	temp:SetPoint("TOPLEFT", 20, 0)
	temp:SetNormalFontObject("GameFontNormalSmall")
	temp:SetHighlightFontObject("GameFontHighlightSmall")
	temp:SetDisabledFontObject("GameFontDisableSmall")
	temp:SetText(L["Options..."])
	temp:SetScript("OnClick", function(self, button, down)
		-- Will this "hack" to scroll to the bottommost item taint anything important?
		-- Because calling InterfaceOptionsFrame_OpenToCategory(panel or panelName) already
		-- calls InterfaceOptionsFrame_Show() anyway in this tainted execution path
		InterfaceOptionsFrame_Show() -- Force an update first for addon LoD option frames to be created
		local count = 0 -- Now count the number of panels to be displayed
		for i = 1, #INTERFACEOPTIONS_ADDONCATEGORIES do
			if not INTERFACEOPTIONS_ADDONCATEGORIES[i].hidden then
				count = count + 1
			end
		end
		local offset = count - #InterfaceOptionsFrameAddOns.buttons
		if offset <= 0 then offset = 0 end
		FauxScrollFrame_SetOffset(InterfaceOptionsFrameAddOnsList, offset) -- Set the offset to scroll to the bottom
		InterfaceOptionsFrameAddOnsListScrollBar:SetValue(offset * InterfaceOptionsFrameAddOns.buttons[1]:GetHeight())
		InterfaceAddOnsList_Update() -- Force another update to update InterfaceOptionsFrameAddOns.buttons
		InterfaceOptionsFrame_OpenToCategory(WoWEquip_OptionFrame) -- Finally open to our frame
	end)
	WoWEquip_Frame.OptionsButton = temp

	-- Create the Show Cloak checkbox
	temp = CreateFrame("CheckButton", nil, DressUpFrame, "UICheckButtonTemplate")
	temp:SetWidth(24)
	temp:SetHeight(24)
	temp:SetPoint("BOTTOMLEFT", 23, 103)
	temp.string = temp:CreateFontString()
	temp.string:SetPoint("LEFT", 21, 1)
	temp.string:SetJustifyH("LEFT")
	temp:SetFontString(temp.string)
	temp:SetNormalFontObject("GameFontNormalSmall")
	temp:SetHighlightFontObject("GameFontHighlightSmall")
	temp:SetDisabledFontObject("GameFontDisableSmall")
	temp:SetText(L["Show Cloak"])
	temp:SetHitRectInsets(0, -temp.string:GetStringWidth(), 0, 0)
	temp:SetPushedTextOffset(0, 0)
	temp:SetScript("OnClick", function(self, button, down)
		db.ShowCloak = not db.ShowCloak
		self:SetChecked(db.ShowCloak)
		WoWEquip:UpdateDressUpModel()
	end)
	temp:Hide()
	RaiseFrameLevel(temp)
	WoWEquip_Frame.ShowCloakCheckbox = temp

	-- Create the Show Helm checkbox
	temp = CreateFrame("CheckButton", nil, DressUpFrame, "UICheckButtonTemplate")
	temp:SetWidth(24)
	temp:SetHeight(24)
	temp:SetPoint("BOTTOMLEFT", WoWEquip_Frame.ShowCloakCheckbox, "TOPLEFT", 0, -8)
	temp.string = temp:CreateFontString()
	temp.string:SetPoint("LEFT", 21, 1)
	temp.string:SetJustifyH("LEFT")
	temp:SetFontString(temp.string)
	temp:SetNormalFontObject("GameFontNormalSmall")
	temp:SetHighlightFontObject("GameFontHighlightSmall")
	temp:SetDisabledFontObject("GameFontDisableSmall")
	temp:SetText(L["Show Helm"])
	temp:SetHitRectInsets(0, -temp.string:GetStringWidth(), 0, 0)
	temp:SetPushedTextOffset(0, 0)
	temp:SetScript("OnClick", function(self, button, down)
		db.ShowHelm = not db.ShowHelm
		self:SetChecked(db.ShowHelm)
		WoWEquip:UpdateDressUpModel()
	end)
	temp:Hide()
	RaiseFrameLevel(temp)
	WoWEquip_Frame.ShowHelmCheckbox = temp

	-- Create the WoWEquip toggle button in the Dressing Room
	local temp = CreateFrame("Button", nil, DressUpFrame, "UIPanelButtonTemplate")
	temp:SetWidth(120)
	temp:SetHeight(22)
	temp:SetPoint("BOTTOMLEFT", DressUpFrame, "TOPLEFT", 18, -433)
	temp:SetText("WoWEquip")
	temp:SetScript("OnClick", WoWEquip.Toggle)
	WoWEquip.OpenButton = temp

	-- Hook the tooltips on UIDropDownMenu
	hooksecurefunc("GameTooltip_AddNewbieTip", function(frame, normalText, r, g, b, newbieText, noNormalText)
		if normalText == "WoWEquipShowTooltip" then
			GameTooltip_SetDefaultAnchor(GameTooltip, frame)
			if newbieText > 0 then
				GameTooltip:SetHyperlink("item:"..newbieText)
			elseif newbieText < 0 then
				GameTooltip:SetHyperlink("enchant:"..-newbieText)
			end
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L["|cffeda55fCtrl-Click|r to add to/remove from Favorites"], 0, 1, 0)
			GameTooltip:AddLine(L["|cffeda55fShift-Click|r to link to chat"], 0, 1, 0)
			GameTooltip:Show()
		end
	end)
end


----------------------------------------------------------------------------------------
-- For Debugging

--Check for globals set by WoWEquip that aren't frames:
--/run for k, v in pairs(_G) do local a, b = issecurevariable(_G, k) if b == "WoWEquip" and (type(v) ~= "table" or not v.SetWidth) then print(k) end end

-- vim: ts=4 noexpandtab
