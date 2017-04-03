--[[
	Auctioneer - AutoMagic Utility module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: Mail-GUI.lua 4556 2009-12-03 22:20:32Z Kandoko $
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
local AppraiserValue, DisenchantValue, ProspectValue, VendorValue, bestmethod, bestvalue, runstop, _

---------------------------------------------------------
-- Mail Interface
---------------------------------------------------------
lib.ammailgui = CreateFrame("Frame", "", UIParent); lib.ammailgui:Hide()
function lib.makeMailGUI()
	-- Set frame visuals
	-- [name of frame]:SetPoint("[relative to point on my frame]","[frame we want to be relative to]","[point on relative frame]",-left/+right, -down/+up)
	lib.ammailgui:ClearAllPoints()
	lib.ammailgui:SetPoint("CENTER", UIParent, "BOTTOMLEFT", get("util.automagic.ammailguix"), get("util.automagic.ammailguiy"))
	
	--Don't need to recreate duplicate frames on each mail box open.
	if lib.ammailgui.Drag then return end 
	
	lib.ammailgui:SetFrameStrata("DIALOG")
	lib.ammailgui:SetHeight(75)
	lib.ammailgui:SetWidth(320)
	lib.ammailgui:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 9, right = 9, top = 9, bottom = 9 }
	})
	lib.ammailgui:SetBackdropColor(0,0,0, 0.8)
	lib.ammailgui:EnableMouse(true)
	lib.ammailgui:SetMovable(true)
	lib.ammailgui:SetClampedToScreen(true)

	-- Make highlightable drag bar
	lib.ammailgui.Drag = CreateFrame("Button", "", lib.ammailgui)
	lib.ammailgui.Drag:SetPoint("TOPLEFT", lib.ammailgui, "TOPLEFT", 10,-5)
	lib.ammailgui.Drag:SetPoint("TOPRIGHT", lib.ammailgui, "TOPRIGHT", -10,-5)
	lib.ammailgui.Drag:SetHeight(6)
	lib.ammailgui.Drag:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
	lib.ammailgui.Drag:SetScript("OnMouseDown", function() lib.ammailgui:StartMoving() end)
	lib.ammailgui.Drag:SetScript("OnMouseUp", function() lib.ammailgui:StopMovingOrSizing() end)
	lib.ammailgui.Drag:SetScript("OnEnter", function() lib.buttonTooltips( lib.ammailgui.Drag, "Click and drag to reposition window.") end)
	lib.ammailgui.Drag:SetScript("OnLeave", function() GameTooltip:Hide() end)

	-- Text Header
	lib.mguiheader = lib.ammailgui:CreateFontString(one, "OVERLAY", "NumberFontNormalYellow")
	lib.mguiheader:SetText("AutoMagic: Mail Loader")
	lib.mguiheader:SetJustifyH("CENTER")
	lib.mguiheader:SetWidth(200)
	lib.mguiheader:SetHeight(10)
	lib.mguiheader:SetPoint("TOPLEFT",  lib.ammailgui, "TOPLEFT", 0, 0)
	lib.mguiheader:SetPoint("TOPRIGHT", lib.ammailgui, "TOPRIGHT", 0, 0)
	lib.ammailgui.mguiheader = lib.mguiheader
	
	
	--Hide mail window
	lib.ammailgui.closeButton = CreateFrame("Button", nil, lib.ammailgui, "UIPanelCloseButton")
	lib.ammailgui.closeButton:SetScript("OnClick", function() lib.ammailgui:Hide() end)
	lib.ammailgui.closeButton:SetPoint("TOPRIGHT", lib.ammailgui, "TOPRIGHT", 0,0)

	-- [name of frame]:SetPoint("[relative to point on my frame]","[frame we want to be relative to]","[point on relative frame]",-left/+right, -down/+up)


	lib.mguibtmrules = lib.ammailgui:CreateFontString(two, "OVERLAY", "NumberFontNormalYellow")
	lib.mguibtmrules:SetText("SUI/IS Rule:")
	lib.mguibtmrules:SetJustifyH("LEFT")
	lib.mguibtmrules:SetWidth(101)
	lib.mguibtmrules:SetHeight(10)
	lib.mguibtmrules:SetPoint("TOPLEFT",  lib.ammailgui, "TOPLEFT", 8, -16)
	lib.ammailgui.mguibtmrules = lib.mguibtmrules

	lib.ammailgui.loadde = CreateFrame("Button", "", lib.ammailgui, "OptionsButtonTemplate")
	lib.ammailgui.loadde:SetText(("Disenchant"))
	lib.ammailgui.loadde:SetPoint("TOPLEFT", lib.mguibtmrules, "BOTTOMLEFT", 0, 1)
	lib.ammailgui.loadde:SetScript("OnClick", lib.disenchantAction)
	lib.ammailgui.loadde:SetScript("OnEnter", function() lib.buttonTooltips( lib.ammailgui.loadde, "Add all items tagged \nfor DE to the mail.") end)
	lib.ammailgui.loadde:SetScript("OnLeave", function() GameTooltip:Hide() end)

--[[	lib.ammailgui.mailto = CreateFrame("EditBox", "", lib.ammailgui, "InputBoxTemplate")
	lib.ammailgui.mailto:SetPoint("TOPLEFT", lib.ammailgui.loaddemats, "BOTTOMRIGHT", 0, -12)
	lib.ammailgui.mailto:SetAutoFocus(false)
	lib.ammailgui.mailto:SetHeight(15)
	lib.ammailgui.mailto:SetWidth(100)
	lib.ammailgui.mailto:SetMaxLetters(12)
	--lib.ammailgui.loaddemailto:SetScript("OnEnterPressed", silvertocopper)
	--lib.ammailgui.loaddemailto:SetScript("OnTabPressed", silvertocopper)

	lib.mguimailtotxt = lib.ammailgui:CreateFontString(four, "OVERLAY", "NumberFontNormalYellow")
	lib.mguimailtotxt:SetText("Set Recipient to:")
	lib.mguimailtotxt:SetJustifyH("LEFT")
	lib.mguimailtotxt:SetWidth(101)
	lib.mguimailtotxt:SetHeight(10)
	lib.mguimailtotxt:SetPoint("TOPRIGHT",  lib.ammailgui.mailto, "TOPLEFT", 0, -25)
	--lib.mguimailfor:SetPoint("TOPRIGHT", lib.ammailgui.loadprospect, "BOTTOMRIGHT", 0, 0)
	lib.ammailgui.mguimailtotxt = lib.mguimailtotxt]]

	lib.ammailgui.loadprospect = CreateFrame("Button", "", lib.ammailgui, "OptionsButtonTemplate")
	lib.ammailgui.loadprospect:SetText(("Prospect"))
	lib.ammailgui.loadprospect:SetPoint("TOPLEFT", lib.ammailgui.loadde, "BOTTOMLEFT", 0, 0)
	lib.ammailgui.loadprospect:SetScript("OnClick", lib.prospectAction)
	lib.ammailgui.loadprospect:SetScript("OnEnter", function() lib.buttonTooltips( lib.ammailgui.loadprospect, "Add all items tagged \nfor Prospect to the mail.") end)
	lib.ammailgui.loadprospect:SetScript("OnLeave", function() GameTooltip:Hide() end)

	lib.mguimailfor = lib.ammailgui:CreateFontString(three, "OVERLAY", "NumberFontNormalYellow")
	lib.mguimailfor:SetText("Misc:")
	lib.mguimailfor:SetJustifyH("LEFT")
	lib.mguimailfor:SetWidth(101)
	lib.mguimailfor:SetHeight(10)
	lib.mguimailfor:SetPoint("TOPLEFT",  lib.mguibtmrules, "TOPRIGHT", 25, 0)
	--lib.mguimailfor:SetPoint("TOPRIGHT", lib.ammailgui.loadprospect, "BOTTOMRIGHT", 0, 0)
	lib.ammailgui.mguimailfor = lib.mguimailfor

	lib.ammailgui.loadgems = CreateFrame("Button", "", lib.ammailgui, "OptionsButtonTemplate")
	lib.ammailgui.loadgems:SetText(("Gems"))
	lib.ammailgui.loadgems:SetPoint("TOPLEFT", lib.mguimailfor, "BOTTOMLEFT", 0, 0)
	lib.ammailgui.loadgems:SetScript("OnClick", lib.gemAction)
	lib.ammailgui.loadgems:SetScript("OnEnter", function() lib.buttonTooltips( lib.ammailgui.loadgems, "Add all Gems to the mail.") end)
	lib.ammailgui.loadgems:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	lib.ammailgui.loadherb = CreateFrame("Button", "", lib.ammailgui, "OptionsButtonTemplate")
	lib.ammailgui.loadherb:SetText(("Herbs"))
	lib.ammailgui.loadherb:SetPoint("LEFT", lib.ammailgui.loadgems, "RIGHT", 0, 0)
	lib.ammailgui.loadherb:SetScript("OnClick", lib.herbAction)
	lib.ammailgui.loadherb:SetScript("OnEnter", function() lib.buttonTooltips( lib.ammailgui.loadherb, "Add all items classified \nas herbs to the mail.") end)
	lib.ammailgui.loadherb:SetScript("OnLeave", function() GameTooltip:Hide() end)
		
	lib.ammailgui.loaddemats = CreateFrame("Button", "", lib.ammailgui, "OptionsButtonTemplate")
	lib.ammailgui.loaddemats:SetText(("Chant Mats"))
	lib.ammailgui.loaddemats:SetPoint("TOPLEFT", lib.ammailgui.loadgems, "BOTTOMLEFT", 0, 0)
	lib.ammailgui.loaddemats:SetScript("OnClick", lib.dematAction)
	lib.ammailgui.loaddemats:SetScript("OnEnter", function() lib.buttonTooltips( lib.ammailgui.loaddemats, "Add all Enchanting mats \nto the mail.") end)
	lib.ammailgui.loaddemats:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	lib.ammailgui.loadpigment = CreateFrame("Button", "", lib.ammailgui, "OptionsButtonTemplate")
	lib.ammailgui.loadpigment:SetText(("Pigments"))
	lib.ammailgui.loadpigment:SetPoint("LEFT", lib.ammailgui.loaddemats, "RIGHT", 0, 0)
	lib.ammailgui.loadpigment:SetScript("OnClick", lib.pigmentAction)
	lib.ammailgui.loadpigment:SetScript("OnEnter", function() lib.buttonTooltips( lib.ammailgui.loadpigment, "Add all Pigments \nto the mail.") end)
	lib.ammailgui.loadpigment:SetScript("OnLeave", function() GameTooltip:Hide() end)
end
AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-AutoMagic/Mail-GUI.lua $", "$Rev: 4556 $")
