-------------------------------------------------------------------------------
-- Localized globals
-------------------------------------------------------------------------------
local _G = getfenv(0)

local table = _G.table

local pairs = _G.pairs

-------------------------------------------------------------------------------
-- Localized Blizzard API
-------------------------------------------------------------------------------
local GetSpellInfo = _G.GetSpellInfo

-------------------------------------------------------------------------------
-- AddOn namespace
-------------------------------------------------------------------------------
local ADDON_NAME, common = ...

local LibStub = _G.LibStub
local LDB = LibStub:GetLibrary("LibDataBroker-1.1")
local ARL = LibStub("AceAddon-3.0"):GetAddon("Ackis Recipe List")

if not ARL then
	error("Ackis Recipe List is required.")
	return
end

local QuickScan = CreateFrame("Frame", "ARL_QuickScan", UIParent)
QuickScan:SetScript("OnEvent",
		    function(self, event, ...)
			    if self[event] then
				    return self[event] (self, event, ...)
			    end
		    end)
QuickScan:RegisterEvent("ADDON_LOADED")

local DropDown = CreateFrame("Frame", "ARL_QuickScan_DropDown")
DropDown.displayMode = "MENU"
DropDown.info = {}
DropDown.levelAdjust = 0

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Variables.
-------------------------------------------------------------------------------
local known_professions = {
	[GetSpellInfo(2259)]	= false, -- Alchemy
	[GetSpellInfo(2018)]	= false, -- Blacksmithing
	[GetSpellInfo(2550)]	= false, -- Cooking
	[GetSpellInfo(7411)]	= false, -- Enchanting
	[GetSpellInfo(4036)]	= false, -- Engineering
	[GetSpellInfo(746)]	= false, -- First Aid
	[GetSpellInfo(2108)]	= false, -- Leatherworking
	[GetSpellInfo(61422)]	= false, -- Smelting
	[GetSpellInfo(3908)]	= false, -- Tailoring
	[GetSpellInfo(25229)]	= false, -- Jewelcrafting
	[GetSpellInfo(45357)]	= false, -- Inscription
	[GetSpellInfo(53428)]	= false, -- Runeforging
}

-------------------------------------------------------------------------------
-- Main functions
-------------------------------------------------------------------------------
local function ARL_Scan(self, profession)
	CastSpellByName(profession)

	local _, prof_level = GetTradeSkillLine()

	QuickScan.data_obj.text = string.format("%s: %d", profession, prof_level)

	if ARL.Frame and ARL.Frame:IsVisible() then
		ARL.Frame:Hide()
	else
		ARL:Scan()
	end
end

function QuickScan.MakeMenu(self, level)
	if not level then
		return
	end
	local info = DropDown.info

	table.wipe(info)

	if level == 1 then
		info.isTitle = true
		info.notCheckable = true
		info.text = _G.TRADE_SKILLS
		UIDropDownMenu_AddButton(info, level)

		-- Blank space in menu
		table.wipe(info)
		info.disabled = true
		UIDropDownMenu_AddButton(info, level)

		info.disabled = nil

		for profession in pairs(known_professions) do
			if known_professions[profession] then
				local _, _, icon = GetSpellInfo(profession)

				info.arg1 = profession
				info.text = "|T"..icon..":24:24|t".." "..profession
				info.func = ARL_Scan
				info.notCheckable = true
				info.keepShownOnClick = true
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end
end

local function GetAnchor(frame)
	if not frame then
		return "CENTER", UIParent, 0, 0
	end

	local x,y = frame:GetCenter()

	if not x or not y then
		return "TOPLEFT", "BOTTOMLEFT"
	end

	local hhalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or (x < UIParent:GetWidth()/3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"

	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end

-------------------------------------------------------------------------------
-- Event functions
-------------------------------------------------------------------------------
function QuickScan:ADDON_LOADED(event, addon)
	if addon ~= "AckisRecipeList_QuickScan" then
		return
	end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	if IsLoggedIn() then
		self:PLAYER_LOGIN()
	else
		self:RegisterEvent("PLAYER_LOGIN")
	end
end

function QuickScan:PLAYER_LOGIN()
	local data_obj = {
		type	= "data source",
		label	= "ARL_QuickScan",
		text	= _G.TRADESKILLS,
		icon	= "Interface\\Icons\\INV_Misc_Note_05",
		OnEnter	= function(display, motion)
				  -- Reset the table - they may have unlearnt a profession
				  for i in pairs(known_professions) do
					  known_professions[i] = false
				  end

				  -- Grab names from the spell book
				  for index = 1, 25, 1 do
					  local spell_name = GetSpellName(index, BOOKTYPE_SPELL)

					  if not spell_name or (index == 25) then
						  break
					  end

					  if known_professions[spell_name] == false then
						  known_professions[spell_name] = true
					  end
				  end

				  if DropDown.initialize ~= self.MakeMenu then
					  CloseDropDownMenus()
					  DropDown.initialize = self.MakeMenu
				  end
				  local point, relativeTo, relativePoint = GetAnchor(display)

				  DropDown.point = point
				  DropDown.relativeTo = relativeTo
				  DropDown.relativePoint = relativePoint

				  -- Only toggle the menu if it isn't already showing.
				  local list_frame = _G["DropDownList1"]

				  if not list_frame:IsShown() then
					  ToggleDropDownMenu(1, nil, DropDown, self:GetName(), 0, 0)
				  end
			  end,
		-- OnLeave is an empty function because some LDB displays refuse to display a plugin that has an OnEnter but no OnLeave.
		OnLeave	= function()
			  end,
		OnClick = function(display, button)
				  if button == "LeftButton" then
					  local options_frame = _G.InterfaceOptionsFrame

					  if options_frame:IsVisible() then
						  options_frame:Hide()
					  else
						  _G.InterfaceOptionsFrame_OpenToCategory("Ackis Recipe List")
					  end
				  end
		 	  end,
	}
	self.data_obj = LDB:NewDataObject(ADDON_NAME, data_obj)

	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end
