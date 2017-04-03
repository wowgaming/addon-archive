--[[
	Auctioneer - BasicFilter
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: BasicFilter.lua 4432 2009-08-29 14:55:35Z dinesh $
	URL: http://auctioneeraddon.com/

	This is an addon for World of Warcraft that adds statistical history to the auction data that is collected
	when the auction is scanned, so that you can easily determine what price
	you will be able to sell an item for at auction or at a vendor whenever you
	mouse-over an item in the game

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]
if not AucAdvanced then return end

local libType, libName = "Filter", "Basic"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill, _TRANS = AucAdvanced.GetModuleLocals()

if not AucAdvancedFilterBasic then AucAdvancedFilterBasic = {} end
if not AucAdvancedFilterBasic_IgnoreList then AucAdvancedFilterBasic_IgnoreList = {} end

local IgnoreList = {}

function lib.Processor(callbackType, ...)
	if callbackType == "config" then
		private.SetupConfigGui(...)
	end
end

function lib.AuctionFilter(operation, itemData)
	local active = get("filter.basic.activated")
	if not active or active ~= true then return end
	local retval = false
	-- Get the signature of this item and find it's stats.
	local quality = AucAdvanced.GetLinkQuality(itemData.link)
	local level = tonumber(itemData.itemLevel) or 0
	--This needs to have the case conversions done because the data is stored in the SV the same way, and LUA is case-sensitive
	local seller = itemData.sellerName:sub(1,1):upper()..itemData.sellerName:sub(2):lower()
	local ignoreself = get("filter.basic.ignoreself")
	local minquality = tonumber(get("filter.basic.min.quality")) or 1
	local minlevel = tonumber(get("filter.basic.min.level")) or 0
	if (quality < minquality) then retval = true end
	if (level < minlevel) then retval = true end
	if (ignoreself and seller == UnitName("player")) then retval = true end
	if (IgnoreList[seller]) then retval = true end

	if nLog and retval then
		nLog.AddMessage("auc-"..libType.."-"..libName, "AuctionFilter", N_INFO, "Filtered Data", "Auction Filter Removed Data for ",
			itemData.itemName, " from ", (itemData.sellerName or "UNKNOWN"), ", quality ", tostring(quality or 0), ", item level ", tostring(itemData.itemLevel or 0))
	end
	return retval
end

function lib.OnLoad(addon)
	AucAdvanced.Settings.SetDefault("filter.basic.activated", true)
	AucAdvanced.Settings.SetDefault("filter.basic.min.quality", 1)
	AucAdvanced.Settings.SetDefault("filter.basic.min.level", 0)
	AucAdvanced.Settings.SetDefault("filter.basic.ignoreself", false)
	BF_IgnoreList_Load()
	private.DataLoaded()
	BasicFilter_IgnoreListFrame:RegisterEvent("PLAYER_LOGOUT")
end

function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local id, last

	id = gui:AddTab(libName, libType.." Modules")
	gui:AddHelp(id, "what basic filter",
		_TRANS('BASC_Help_WhatBasicFilter') ,--What is the Basic Filter?
		_TRANS('BASC_Help_WhatBasicFilterAnswer') )--This filter allows you to specify certain minimums for an item to be entered into the data stream, such as the minimum item level, and the minimum quality (Junk, Common, Uncommon, Rare, etc). It also allows you to specify items from a certain seller to not be recorded.  One use of this is if a particular seller posts all of his items well over or under the market price, you can ignore all of his/her items

	gui:AddControl(id, "Header", 0, _TRANS('BASC_Interface_BasicFilterOptions') )--Basic filter options
	last = gui:GetLast(id)

	gui:AddControl(id, "Note",		0, 1, nil, nil, " ")
	gui:AddControl(id, "Checkbox",	0, 1,"filter.basic.activated",  _TRANS('BASC_Interface_EnableBasicFilter') )--Enable use of the Basic filter
	gui:AddTip(id, _TRANS('BASC_HelpTooltip_EnableBasicFilterAnswer') )--Ticking this box will enable the basic filter to perform filtering of your auction scans

	gui:AddControl(id, "Note",		0, 1, nil, nil, " ")
	gui:AddControl(id, "Checkbox",	0, 1, "filter.basic.ignoreself", _TRANS('BASC_Interface_IgnoreOwnAuctions') )--Ignore own auctions
	gui:AddTip(id, _TRANS('BASC_Help_IgnoreOwnAuctionsAnswer') )--Ticking this box will disable adding auctions that you posted yourself to the snapshot.

	gui:AddControl(id, "Subhead",	0, _TRANS('BASC_Interface_FilterQuality') )--Filter by Quality
	gui:AddControl(id, "Slider",	0, 1, "filter.basic.min.quality", 0, 4, 1, _TRANS('BASC_Interface_MinimumQuality') )--Minimum Quality: %d
	gui:AddTip(id, _TRANS('BASC_HelpTooltip_MinimumQuality').."\n"..--Use this slider to choose the minimum quality to go into storage.
		"\n"..
		"0 = (|cff9d9d9d ".._TRANS('BASC_HelpTooltip_MinimumQualityJunk').."|r),\n"..--Junk
		"1 = (|cffffffff ".._TRANS('BASC_HelpTooltip_MinimumQualityCommon').."|r),\n"..--Common
		"2 = (|cff1eff00 ".._TRANS('BASC_HelpTooltip_MinimumQualityUncommon').."|r),\n"..--Uncommon
		"3 = (|cff0070dd".._TRANS('BASC_HelpTooltip_MinimumQualityRare').."|r),\n"..--Rare
		"4 = (|cffa335ee ".._TRANS('BASC_HelpTooltip_MinimumQualityEpic').."|r)")--Epic

	gui:AddControl(id, "Subhead",	0, _TRANS('BASC_Interface_FilterItemLevel') )--Filter by Item Level
	gui:AddControl(id, "NumberBox",	0, 1, "filter.basic.min.level", 0, 9, _TRANS('BASC_Interface_MinimumItemLevel') )--Minimum item level
	gui:AddTip(id, _TRANS('BASC_HelpTooltip_MinimumItemLevel') )--Enter the minimum item level to go into storage.

	gui:SetLast(id, last)
	gui:AddControl(id, "Subhead",	0.55,    _TRANS('BASC_Interface_IgnoreList') )--Ignore List
	gui:AddControl(id, "Custom", 	0.55, 0, BasicFilter_IgnoreListFrame); BasicFilter_IgnoreListFrame:SetParent(gui.tabs[id][3])

end

--[[ Local functions ]]--
function private.DataLoaded()
	-- This function gets called when the data is first loaded. You may do any required maintenence
	-- here before the data gets used.
end

--**************************************
-- Ignore List Frame Functionality
--**************************************

local numIgnoreButtons = 18
SelectedIgnore = 1
LastIgnoredPlayer = nil

function lib.IgnoreList_IsPlayerIgnored( name )
	if ( IgnoreList[name] ) then
		return true
	else
		return false
	end
end

function BF_IgnoreList_Update()
	local numIgnores = #IgnoreList
	local nameText;
	local name;
	local ignoreButton;
	if ( numIgnores > 0 ) then
		if ( SelectedIgnore == 0 ) then
			SelectedIgnore = 1
		end
		BasicFilter_IgnoreList_StopIgnoreButton:Enable();
	else
		BasicFilter_IgnoreList_StopIgnoreButton:Disable();
	end

	local ignoreOffset = FauxScrollFrame_GetOffset(BasicFilter_IgnoreList_ScrollFrame);
	local ignoreIndex;
	for i=1, numIgnoreButtons, 1 do
		ignoreIndex = i + ignoreOffset;
		ignoreButton = getglobal("BasicFilter_IgnoreList_IgnoreButton"..i);
		ignoreButton:SetText(IgnoreList[ignoreIndex] or "");
		ignoreButton:SetID(ignoreIndex);
		-- Update the highlight
		if ( ignoreIndex == SelectedIgnore ) then
			ignoreButton:LockHighlight();
		else
			ignoreButton:UnlockHighlight();
		end

		if ( ignoreIndex > numIgnores ) then
			ignoreButton:Hide();
		else
			ignoreButton:Show();
		end
	end

	-- ScrollFrame stuff
	FauxScrollFrame_Update(BasicFilter_IgnoreList_ScrollFrame, numIgnores, numIgnoreButtons, 16);

end

function BF_IgnoreList_IgnoreButton_OnClick( button )
	SelectedIgnore = button:GetID()
	BF_IgnoreList_Update()
end

function BF_IgnoreList_UnignoreButton_OnClick( button )
	local name = IgnoreList[SelectedIgnore]
	BF_IgnoreList_Remove(name)
end

function BF_IgnoreList_Load()
	local realm = GetRealmName()
	local faction = UnitFactionGroup("player")

	--If the realm doesn't exist in the SV, create it
	if not AucAdvancedFilterBasic_IgnoreList[realm] then
		AucAdvancedFilterBasic_IgnoreList[realm] = {}
	end

	--If the faction doesn't exist in the SV, create it under the realm
	if not AucAdvancedFilterBasic_IgnoreList[realm][faction] then
		AucAdvancedFilterBasic_IgnoreList[realm][faction] = {}
	end

	--Get the ignore list for the current realm and faction
	IgnoreList = AucAdvancedFilterBasic_IgnoreList[realm][faction]
	lib.IgnoreList = IgnoreList --make current ignore list global for other addons

	for i, name in ipairs(IgnoreList) do
		IgnoreList[name] = i
	end
	BF_IgnoreList_Update()
end

function BF_IgnoreList_OnEvent()
	if event == "PLAYER_LOGOUT" then
		for key in pairs(IgnoreList) do
			if type(key) == "number" then
				AucAdvancedFilterBasic_IgnoreList[realm][faction][key] = IgnoreList[key]
			end
		end
	end
end

function BF_IgnoreList_Add( name )
	-- name validity checks
	if ( (not name) or name == "" ) then return end
	if ( #name < 2 ) then return end
	--This is stored in the SV with the first letter capitalized and the rest lowercased
	--so that it appears that way in the config
	name = name:sub(1,1):upper()..name:sub(2):lower()
	local currentSelection = IgnoreList[SelectedIgnore]

	if not ( IgnoreList[name] ) then
		table.insert(IgnoreList, name)
		LastIgnoredPlayer = name
	end
	table.sort(IgnoreList)
	for i, name in ipairs(IgnoreList) do
		IgnoreList[name] = i
	end
	SelectedIgnore = IgnoreList[currentSelection] or 1
	BF_IgnoreList_Update()
end

function BF_IgnoreList_Remove( name )
	if ( IgnoreList[name] ) then
		IgnoreList[name] = nil
		for i, ignoreName in ipairs(IgnoreList) do
			if ( ignoreName == name ) then
				table.remove(IgnoreList, i)
			end
		end
		SelectedIgnore = 1
	end
	table.sort(IgnoreList)
	for i, name in ipairs(IgnoreList) do
		IgnoreList[name] = i
	end
	BF_IgnoreList_Update()
end

StaticPopupDialogs["BASICFILTER_ADD_IGNORE"] = {
	text = ADD_IGNORE_LABEL,
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	maxLetters = 12,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		BF_IgnoreList_Add(editBox:GetText());
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsShown() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local name = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		this:GetParent():Hide();
		BF_IgnoreList_Add(name);
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Filter-Basic/BasicFilter.lua $", "$Rev: 4432 $")
