--[[
	Auctioneer - AutoMagic Utility module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: ConfirmSellUI.lua 4678 2010-02-27 00:53:37Z Nechckn $
	URL: http://auctioneeraddon.com/

	AutoMagic is an Auctioneer module which automates mundane tasks for you.

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
--]]
if not AucAdvanced then return end

local lib = AucAdvanced.Modules.Util.AutoMagic
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()
local GetPrice = AucAdvanced.Modules.Util.Appraiser.GetPrice

local _, selected, selecteditem, selectedvendor, selectedappraiser, selectedwhy, selectedignored
local selecteddata = {}


function lib.ASCPrompt()
	if next(lib.vendorlist) then
		lib.confirmsellui:Show()
	end
	lib.ASCRefreshSheet() --Always refresh the sheet or it can appear we have items left in GUI after the autosell function
end

---------------------------------------------------------
-- Button Functions
---------------------------------------------------------
-- lib.vendorlist[key] = { link, sig, count, bag, slot, reason }
function lib.ASCConfirmContinue()
	lib.confirmsellui:Hide() --hide gui before selling so our bag update events are not registered
	local count = 0
	for key, itemdata in pairs(lib.vendorlist) do
		count = count +1
		--if stop after 12 then recheck whats left to vendor and re-prompt for a new round. 
		if get("util.automagic.autostopafter12") and count > 12 then --stop after 12 sells so use can buy back a accidental sale
			lib.vendorAction()
			return
		end
		
		local _, iID = decode( itemdata[1] ) --check if item is to be ignored
		if not get("util.automagic.vidignored"..iID) then --will be nil if not on ignore list
			
			if (get("util.automagic.chatspam")) then
				print("AutoMagic is selling:", itemdata[1], "reason:", itemdata[6])
			end
			
			UseContainerItem(itemdata[4], itemdata[5])
		end
		lib.vendorlist[key] = nil
	end
end

function lib.ASCRemoveItem()
	if selecteditem then
		for key, itemdata in pairs(lib.vendorlist) do
			if selecteditem ==  itemdata[1] then
				lib.vendorlist[key] = nil
				break
			end
		end
	end
	lib.ASCRefreshSheet()
end

function lib.ASCIgnoreItem()
	if selecteditem then
		local _, iID = decode(selecteditem)
		set("util.automagic.vidignored"..iID, true)
	end
	
	lib.ASCRefreshSheet()
end

function lib.ASCUnIgnoreItem()
	if selecteditem then
		local _, iID = decode(selecteditem)
		set("util.automagic.vidignored"..iID, nil)
	end
	
	lib.ASCRefreshSheet()
end

---------------------------------------------------------
-- ScrollSheet Functions
---------------------------------------------------------
-- lib.vendorlist[key] = { link, sig, count, bag, slot, reason }
-- ASCtempstorage[index] = { link, vendorPrice, AppraiserPrice, reason, vendorIgnoreDisplay }
function lib.ASCRefreshSheet()
	local ASCtempstorage, style = {}, {}
	local GetPrice = AucAdvanced.Modules.Util.Appraiser.GetPrice
	for k, v in pairs(lib.vendorlist) do
		local itemLink, itemSig, count, bag, slot, reason = unpack(v)
		local _, iID = decode(itemLink)
		local vendor = GetSellValue and GetSellValue(iID) or 0
		local abuy, abid = GetPrice(itemLink, nil, true)
		local vendorignored = "YES"
		local styleColor = {0,1,0}
		if get("util.automagic.vidignored"..iID) == true then
			vendorignored = "NO"
			styleColor = {1,0,0}
		end
		table.insert(ASCtempstorage,{
		itemLink, --link form for mouseover tooltips to work
		vendor,
		tonumber(abuy) or tonumber(abid),
		reason,
		vendorignored,
		})
		style[#ASCtempstorage] = {}
		style[#ASCtempstorage][5] = {["textColor"] = styleColor}
	end
	
	lib.confirmsellui.resultlist.sheet:SetData(ASCtempstorage, style) --Set the GUI scrollsheet
end

function lib.ASCOnEnter(button, row, index)
	if lib.confirmsellui.resultlist.sheet.rows[row][index]:IsShown()then --Hide tooltip for hidden cells
		local link
		link = lib.confirmsellui.resultlist.sheet.rows[row][index]:GetText()
		if link and link:find("\124Hitem:%d") then
			GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
			-- ccox - this was using count (undefined variable), but all similar code in Auc-Util-AutoMagic.lua uses a count of 1
			AucAdvanced.ShowItemLink(GameTooltip, link, 1)
			end
		end
	end


function lib.ASCOnClick()
	--print("CLICK")
end

function lib.ASCSelect()
	if lib.confirmsellui.resultlist.sheet.selected then
		selected = lib.confirmsellui.resultlist.sheet.selected
		selecteddata = lib.confirmsellui.resultlist.sheet:GetSelection()
		selecteditem = selecteddata[1]
		selectedvendor = selecteddata[2]
		selectedappraiser = selecteddata[3]
		selectedwhy = selecteddata[4]
		selectedignored = selecteddata[5]
		
		lib.confirmsellui.ignoreButton:Enable()
		lib.confirmsellui.removeButton:Enable()
		lib.confirmsellui.unignoreButton:Enable()
	else
		selected, selecteditem, selectedvendor, selectedappraiser, selectedwhy, selectedignored = nil, nil, nil, nil, nil, nil
		lib.confirmsellui.ignoreButton:Disable()
		lib.confirmsellui.removeButton:Disable()
		lib.confirmsellui.unignoreButton:Disable()
	end
end
---------------------------------------------------------
-- Confirm AutoSell Interface
---------------------------------------------------------

local SelectBox = LibStub:GetLibrary("SelectBox")
local ScrollSheet = LibStub:GetLibrary("ScrollSheet")

lib.confirmsellui = CreateFrame("Frame", "confirmsellui", UIParent); lib.confirmsellui:Hide()
function lib.makeconfirmsellui()
	lib.confirmsellui:ClearAllPoints()
	lib.confirmsellui:SetPoint("CENTER", UIParent, "CENTER", 1,1)
	lib.confirmsellui:SetFrameStrata("DIALOG")
	lib.confirmsellui:SetHeight(220)
	lib.confirmsellui:SetWidth(550)
	lib.confirmsellui:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 9, right = 9, top = 9, bottom = 9 }
	})
	lib.confirmsellui:SetBackdropColor(0,0,0, 0.8)
	lib.confirmsellui:EnableMouse(true)
	lib.confirmsellui:SetMovable(true)
	lib.confirmsellui:SetClampedToScreen(true)
	-- Make highlightable drag bar
	lib.confirmsellui.Drag = CreateFrame("Button", "", lib.confirmsellui)
	lib.confirmsellui.Drag:SetPoint("TOPLEFT", lib.confirmsellui, "TOPLEFT", 10,-5)
	lib.confirmsellui.Drag:SetPoint("TOPRIGHT", lib.confirmsellui, "TOPRIGHT", -10,-5)
	lib.confirmsellui.Drag:SetHeight(6)
	lib.confirmsellui.Drag:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
	lib.confirmsellui.Drag:SetScript("OnMouseDown", function() lib.confirmsellui:StartMoving() end)
	lib.confirmsellui.Drag:SetScript("OnMouseUp", function() lib.confirmsellui:StopMovingOrSizing() end)
	lib.confirmsellui.Drag:SetScript("OnEnter", function() lib.buttonTooltips( lib.confirmsellui.Drag, "Click and drag to reposition window") end)
	lib.confirmsellui.Drag:SetScript("OnLeave", function() GameTooltip:Hide() end)

	-- Text Header
	lib.confirmsellheader = lib.confirmsellui:CreateFontString(one, "OVERLAY", "NumberFontNormalYellow")
	lib.confirmsellheader:SetText("AutoMagic: Confirm Pending Sales")
	lib.confirmsellheader:SetJustifyH("CENTER")
	lib.confirmsellheader:SetWidth(200)
	lib.confirmsellheader:SetHeight(10)
	lib.confirmsellheader:SetPoint("TOPLEFT",  lib.confirmsellui, "TOPLEFT", 0, -10)
	lib.confirmsellheader:SetPoint("TOPRIGHT", lib.confirmsellui, "TOPRIGHT", 0, 0)
	lib.confirmsellui.confirmsellheader = lib.confirmsellheader

	-- [name of frame]:SetPoint("[relative to point on my frame]","[frame we want to be relative to]","[point on relative frame]",-left/+right, -down/+up)

	--Create the autosell list results frame
	lib.confirmsellui.resultlist = CreateFrame("Frame", nil, lib.confirmsellui)
	lib.confirmsellui.resultlist:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})

	lib.confirmsellui.resultlist:SetBackdropColor(0, 0, 0.0, 0.5)
	lib.confirmsellui.resultlist:SetPoint("TOPLEFT", lib.confirmsellui, "TOPLEFT", 10, -25)
	lib.confirmsellui.resultlist:SetPoint("TOPRIGHT", lib.confirmsellui, "TOPRIGHT", -10, -10)
	lib.confirmsellui.resultlist:SetPoint("BOTTOM", lib.confirmsellui, "BOTTOM", 0, 30)

	lib.confirmsellui.resultlist.sheet = ScrollSheet:Create(lib.confirmsellui.resultlist, {
		{ ('Item:'), "TOOLTIP", 170, { DESCENDING=false, DEFAULT=true }  },
		{ "Vendor", "COIN", 70 },
		{ "Appraiser", "COIN", 70 },
		{ "Selling for", "TEXT", 70 },
		{ "Will be Sold", "TEXT", 100},
	})
	lib.confirmsellui.resultlist.sheet:EnableVerticalScrollReset(false)
	lib.confirmsellui.resultlist.sheet:EnableSelect(true)
	
	--After we have finished creating the scrollsheet and all saved settings have been applied set our event processor
	function lib.confirmsellui.resultlist.sheet.Processor(callback, self, button, column, row, order, curDir, ...)
		if (callback == "OnEnterCell")  then
			lib.ASCOnEnter(button, row, column)
		elseif (callback == "OnLeaveCell") then
			GameTooltip:Hide()
		elseif (callback == "OnClickCell") then
			lib.ASCOnClick(button, row, column)
		elseif (callback == "OnMouseDownCell") then
			lib.ASCSelect()
		end
	end
	--use our custom sort method not scrollsheets
	lib.confirmsellui.resultlist.sheet.CustomSort = lib.CustomSort
	
	-- Continue with sales button
	lib.confirmsellui.continueButton = CreateFrame("Button", nil, lib.confirmsellui, "OptionsButtonTemplate")
	lib.confirmsellui.continueButton:SetPoint("BOTTOMRIGHT", lib.confirmsellui, "BOTTOMRIGHT", -18, 10)
	lib.confirmsellui.continueButton:SetText(("Continue"))
	lib.confirmsellui.continueButton:SetScript("OnClick",  lib.ASCConfirmContinue)
	lib.confirmsellui.continueButton:SetScript("OnEnter", function() lib.buttonTooltips( lib.confirmsellui.continueButton, "Click to sell all listed items to vendor.") end)
	lib.confirmsellui.continueButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

	--Remove item from sales button
	lib.confirmsellui.removeButton = CreateFrame("Button", nil, lib.confirmsellui, "OptionsButtonTemplate")
	lib.confirmsellui.removeButton:SetPoint("BOTTOMRIGHT", lib.confirmsellui.continueButton, "BOTTOMLEFT", -18, 0)
	lib.confirmsellui.removeButton:SetText(("Remove"))
	lib.confirmsellui.removeButton:SetScript("OnClick",  lib.ASCRemoveItem)
	lib.confirmsellui.removeButton:Disable()

	-- Ignore item from future sales
	lib.confirmsellui.ignoreButton = CreateFrame("Button", nil, lib.confirmsellui, "OptionsButtonTemplate")
	lib.confirmsellui.ignoreButton:SetPoint("BOTTOMRIGHT", lib.confirmsellui.removeButton, "BOTTOMLEFT", -18, 0)
	lib.confirmsellui.ignoreButton:SetText(("Ignore"))
	lib.confirmsellui.ignoreButton:SetScript("OnClick",  lib.ASCIgnoreItem)
	lib.confirmsellui.ignoreButton:Disable()

	-- Un-Ignore item from future sales
	lib.confirmsellui.unignoreButton = CreateFrame("Button", nil, lib.confirmsellui, "OptionsButtonTemplate")
	lib.confirmsellui.unignoreButton:SetPoint("BOTTOMRIGHT", lib.confirmsellui.ignoreButton, "BOTTOMLEFT", -18, 0)
	lib.confirmsellui.unignoreButton:SetText(("Un-Ignore"))
	lib.confirmsellui.unignoreButton:SetScript("OnClick",  lib.ASCUnIgnoreItem)
	lib.confirmsellui.unignoreButton:Disable()
	
	--Hide sales window
	lib.confirmsellui.closeButton = CreateFrame("Button", nil, lib.confirmsellui, "UIPanelCloseButton")
	lib.confirmsellui.closeButton:SetScript("OnClick", function() lib.confirmsellui:Hide() end)
	lib.confirmsellui.closeButton:SetPoint("TOPRIGHT", lib.confirmsellui, "TOPRIGHT", 0,0)
end

lib.makeconfirmsellui()
AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-AutoMagic/ConfirmSellUI.lua $", "$Rev: 4678 $")
