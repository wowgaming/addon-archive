--[[
	Auctioneer - EasyBuyout Utility Module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: EasyBuyout.lua 4432 2009-08-29 14:55:35Z dinesh $
	URL: http://auctioneeraddon.com/

	This Auctioneer module allows for the ability to purchase items from
	the Browse tab with a single click.  It also allows for canceling your
	own auctions from the Auctions tab with a single click.

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

local libType, libName = "Util", "EasyBuyout"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()
local addShift;
local CompactUImode = false
local orig_AB_OC;
local ebModifier = false

function lib.GetName()
	return libName
end

function lib.Processor(callbackType, ...)
    if (callbackType == "listupdate") then
		private.EasyCancelMain()
        private.EasyBuyout()
	elseif (callbackType == "auctionui") then
		private.AHLoaded()
		private.EasyBuyout()
		private.EasyCancelMain()
	elseif (callbackType == "config") then
		private.SetupConfigGui(...)
	elseif (callbackType == "configchanged") then
		private.EasyBuyout()
		private.EasyCancelMain()
	end
end

function lib.OnLoad()
	print("AucAdvanced: {{"..libType..":"..libName.."}} loaded!")

	-- EasyBuyout Default Settings
	AucAdvanced.Settings.SetDefault("util.EasyBuyout.active", false)
	AucAdvanced.Settings.SetDefault("util.EasyBuyout.modifier.active", true)
	AucAdvanced.Settings.SetDefault("util.EasyBuyout.modifier.select", 0)

	-- EasyCancel Default Settings
	AucAdvanced.Settings.SetDefault("util.EasyBuyout.EC.active", false)
	AucAdvanced.Settings.SetDefault("util.EasyBuyout.EC.modifier.active", true)
	AucAdvanced.Settings.SetDefault("util.EasyBuyout.EC.modifier.select", 0)

	-- EasyBid Default Settings
	AucAdvanced.Settings.SetDefault("util.EasyBuyout.EBid.active", false)

	-- EasyGoldLimit Default Settings
	AucAdvanced.Settings.SetDefault("util.EasyBuyout.EGL.EBuy.active", true)
	AucAdvanced.Settings.SetDefault("util.EasyBuyout.EGL.EBuy.limit", 100000)
	AucAdvanced.Settings.SetDefault("util.EasyBuyout.EGL.EBid.active", true)
	AucAdvanced.Settings.SetDefault("util.EasyBuyout.EGL.EBid.limit", 50000)

end

--[[ Local functions ]]--

function private.AHLoaded()
	if AucAdvanced.Modules.Util.CompactUI and AucAdvanced.Modules.Util.CompactUI.Private.ButtonClick and get("util.compactui.activated") then
		orig_AB_OC = AucAdvanced.Modules.Util.CompactUI.Private.ButtonClick
		AucAdvanced.Modules.Util.CompactUI.Private.ButtonClick = private.BrowseButton_OnClick
		CompactUImode = true
	else
		assert(BrowseButton_OnClick, "BrowseButton_OnClick doesn't exist yet")
		orig_AB_OC = BrowseButton_OnClick
		BrowseButton_OnClick = private.BrowseButton_OnClick
		CompactUImode = false
	end
end

function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local id = gui:AddTab(libName)
	gui:MakeScrollable(id)

	-- EasyBuyout
	gui:AddControl(id, "Header",     0,    "EasyBuyout Options")
	gui:AddControl(id, "Subhead",          0,    "Simply right-click an auction to buy it out with no confirmation box.")
    gui:AddControl(id, "Checkbox",   0, 1, "util.EasyBuyout.active", "Enable EasyBuyout")
    gui:AddTip(id, "Ticking this box will enable or disable EasyBuyout")
    gui:AddControl(id, "Checkbox",   0, 1, "util.EasyBuyout.modifier.active", "Enable key modifier")
	gui:AddTip (id, "Ticking this box will add a key modifier to EasyBuyout")
    gui:AddControl(id, "Selectbox",  0, 1, {
		{0, "Shift"},
		{1, "Alt"},
		{2, "Shift+Alt"}
	}, "util.EasyBuyout.modifier.select", "testing here")
    gui:AddTip(id, "Select your key modifier for EasyBuyout")

 	-- EasyCancel
	gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
	gui:AddControl(id, "Header",		0,		"EasyCancel Options")
	gui:AddControl(id, "Subhead",		   0,   "Simply right-click an auction to cancel it out with no confirmation box.")
	gui:AddControl(id, "Checkbox",   0, 1, "util.EasyBuyout.EC.active", "Enable EasyCancel")
	gui:AddTip(id, "Ticking this box will enable or disable EasyCancel")
	gui:AddControl(id, "Checkbox",   0, 1, "util.EasyBuyout.EC.modifier.active", "Enable key modifier")
	gui:AddTip (id, "Ticking this box will add a key modifier to EasyCancel")
    gui:AddControl(id, "Selectbox",  0, 1, {
		{0, "Shift"},
		{1, "Alt"},
		{2, "Shift+Alt"}
	}, "util.EasyBuyout.EC.modifier.select", "testing here")
    gui:AddTip(id, "Select your key modifier for EasyCancel")

	-- EasyBid
	gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
	gui:AddControl(id, "Header",		0,		"EasyBid Options")
	gui:AddControl(id, "Subhead",		   0,   "Simply double-click an auction to bid minimum on it.")
	gui:AddControl(id, "Checkbox",   0, 1, "util.EasyBuyout.EBid.active", "Enable EasyBid")
	gui:AddTip(id, "Toggle this box to enable or disable EasyBid")

	-- EasyGoldLimit
	gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
	gui:AddControl(id, "Header", 0, "EasyGoldLimit Options")
	gui:AddControl(id, "Subhead", 0, "Set a limit on EasyBid & EasyBuyout to prevent accidental purchases of expensive auctions.")
	gui:AddControl(id, "Checkbox", 0,1, "util.EasyBuyout.EGL.EBuy.active", "Enable EasyGoldLimit for EasyBuyout")
	gui:AddTip(id, "Ticking this box will enable or disable EasyGoldLimit for EasyBuyout")
	gui:AddControl(id, "MoneyFramePinned", 0, 1, "util.EasyBuyout.EGL.EBuy.limit", 0, 999999999, "Set EasyBuyout Limit")
	gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
	gui:AddControl(id, "Checkbox", 0,1, "util.EasyBuyout.EGL.EBid.active", "Enable EasyGoldLimit for EasyBid")
	gui:AddTip(id, "Ticking this box will enable or disable EasyGoldLimit for EasyBid")
	gui:AddControl(id, "MoneyFramePinned", 0, 1, "util.EasyBuyout.EGL.EBid.limit", 0, 999999999, "Set EasyBid Limit")

	-- help sections
    gui:AddHelp(id, "What is EasyBuyout?",
        "What is EasyBuyout?",
        "EasyBuyout makes it easier to buy auctions in mass, faster! You simply right-click (or 'modifier'+right-click depending on your options) to buyout an auction with no confirmation box")

	gui:AddHelp(id, "What is EasyCancel?",
		"What is EasyCancel?",
		"Take what EasyBuyout does and apply it to canceling auctions! All you do is right-click (or 'modifier'+right-click) to cancel an auction you have posted up with no conformation box")

	gui:AddHelp(id, "What is EasyBid?",
		"What is EasyBid?",
		"This part of the EasyBuyout utility does what the name implies, it allows you to double click (or 'modifier'+double-click) to bid minimal on an auction! !!NOTE!! EasyBid can not use key modifiers because of the use of \"left-click\". It conflicts with other parts of Auctioneer.")

	gui:AddHelp(id, "What is EasyGoldLimit?",
		"What is EasyGoldLimit",
		"This does exactly what the name implies, it places a limit on the amount of gold that will be allowed to be used when bidding or buying an auction. It helps prevent spending more than intended on an auction.")
end

function private.BrowseButton_OnClick(...)

    -- check for EB enabled
    if not get("util.EasyBuyout.active") then
        return orig_AB_OC(...)
    end

     -- check and assign modifier
    if get("util.EasyBuyout.modifier.active") then
        if (get("util.EasyBuyout.modifier.select") == 0) and IsShiftKeyDown() then
            ebModifier = true;
        elseif (get("util.EasyBuyout.modifier.select") == 1) and IsAltKeyDown() then
            ebModifier = true;
        elseif (get("util.EasyBuyout.modifier.select") == 2) and IsShiftKeyDown() and IsAltKeyDown() then
            ebModifier = true;
        else
            return orig_AB_OC(...)
        end
    end

    if (arg1 == "RightButton") then
        local button = select(1, ...) or this

		local id
		if CompactUImode then
			id = button.id
		else
			id = button:GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame)
		end
		local link = GetAuctionItemLink("list", id)
		if link then
            local _,_,count = GetAuctionItemInfo("list", id)
            ChatFrame1:AddMessage("Rightclick - buying auction of " .. (count or "?") .. "x" .. link)
        else
            ChatFrame1:AddMessage("Rightclick - not finding anything to buy. If you are mass clicking - try going from the bottom up!")
            return
        end
        SetSelectedAuctionItem("list", id);
		private.EasyBuyoutAuction();
    else
        return orig_AB_OC(...)
    end
end

function private.EasyBuyout()
	if not AuctionFrame then return end

    if get("util.EasyBuyout.shift.active") then
        addShift = true;
    else
        addShift = false;
    end

    if (get("util.EasyBuyout.active") or get("util.EasyBuyout.EBid.active")) then
       for i=1,50 do
            local button = _G["BrowseButton"..i]
            if not button then break end
            button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
            _G["BrowseButton"..i]:RegisterForClicks("LeftButtonUp", "RightButtonUp")
			button:SetScript("ondoubleclick", private.NewOnDoubleClick)
        end
    else
		return;
    end
end


function private.EasyBuyoutAuction()
    local EasyBuyoutIndex = GetSelectedAuctionItem("list");
    local EasyBuyoutPrice = select(9, GetAuctionItemInfo("list", EasyBuyoutIndex))

	-- Easy Gold Limit for EasyBuyout
	if get("util.EasyBuyout.EGL.EBuy.active") then
		if EasyBuyoutPrice > get("util.EasyBuyout.EGL.EBuy.limit") then
			ChatFrame1:AddMessage("|cffCC1100EasyGoldLimit - Auction is over your set limit for EasyBuyout!")
			return;
		end
	end

    PlaceAuctionBid("list", EasyBuyoutIndex, EasyBuyoutPrice)
    CloseAuctionStaticPopups();
end


--[[ EasyCancel Function - Easy Auction Cancel is a lot simpler to incorporate everything in it's own section
	 rather than incorporating it into everything else coded before this comment. EasyCancel does not need to be
	 hooked like EasyBuyout does with compactUI
--]]

local function OrigAuctionOnClick(...)
	if ( IsModifiedClick() ) then
		HandleModifiedItemClick(GetAuctionItemLink("owner", this:GetParent():GetID() + FauxScrollFrame_GetOffset(AuctionsScrollFrame)));
	else
		AuctionsButton_OnClick(...);
	end
end
-- handler for modifiers
local function NewOnClick(self, button)
	local active = get("util.EasyBuyout.EC.active")
	local modified = get("util.EasyBuyout.EC.modifier.active")
	local modselect = get("util.EasyBuyout.EC.modifier.select")

	if active and button=="RightButton" and
			(
			(not modified)
			or (modified and modselect == 0 and IsShiftKeyDown())
			or (modified and modselect == 1 and IsAltKeyDown())
			or (modified and modselect == 2 and IsAltKeyDown() and IsShiftKeyDown())
			)	then
		private.EasyCancel(self, button)
	else
		OrigAuctionOnClick(self, button)
	end

end

function private.EasyCancelMain()

	for i=1,199 do
		local button = _G["AuctionsButton"..i]
		if not button then break end
		button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		_G["AuctionsButton"..i.."Item"]:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		button:SetScript("onclick", NewOnClick)
	end
end

function private.EasyCancel(self, button)

	local link = GetAuctionItemLink("owner", self:GetID() + FauxScrollFrame_GetOffset(AuctionsScrollFrame))
	if link then
		local _,_,count = GetAuctionItemInfo("owner", self:GetID() + FauxScrollFrame_GetOffset(AuctionsScrollFrame))
		ChatFrame1:AddMessage("Rightclick - cancelling auction of " .. (count or "?") .. "x" .. link)
	else
		return ChatFrame1:AddMessage("Rightclick - not finding anything to cancel. If you are mass clicking - try going from the bottom up!")
	end

	SetSelectedAuctionItem("owner", self:GetID() + FauxScrollFrame_GetOffset(AuctionsScrollFrame));
	CancelAuction(GetSelectedAuctionItem("owner"))
	CloseAuctionStaticPopups();
	AuctionFrameBid_Update();
end

-- EasyBid Function - This section listed below is for EasyBid: the utility that allows users to easily bid on an item simply by double clicking on it.


function private.NewOnDoubleClick(self, button)
	-- check for EBid enabled
    if not get("util.EasyBuyout.EBid.active") then
        return
    end

	local id
	if CompactUImode then
		id = self.id
	else
		id = self:GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame)
	end
	local link = GetAuctionItemLink("list", id)
	if button == 'LeftButton' then
		if (select(11, GetAuctionItemInfo("list", id))) then
			ChatFrame1:AddMessage("You are already the highest bidder on this item!")
			return
		end
		if link then
			local _,_,count = GetAuctionItemInfo("list", id)
			ChatFrame1:AddMessage("Doubleclick - bidding on auction of " .. (count or "?") .. "x" .. link)
		else
			ChatFrame1:AddMessage("Doubleclick - not finding anything to bid on. If you are mass clicking - try going from the bottom up!")
			return
		end
	SetSelectedAuctionItem("list", self:GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame));
	private.EasyBidAuction(id);
	CloseAuctionStaticPopups();
	end
end

function private.EasyBidAuction(getID)
    local EasyBidPrice = select(10, GetAuctionItemInfo("list", getID)) + select(8, GetAuctionItemInfo("list", getID))
	if EasyBidPrice == 0 then
		EasyBidPrice = EasyBidPrice + select(7, GetAuctionItemInfo("list", getID))
	end

	-- Easy Gold Limit for EasyBid
	if get("util.EasyBuyout.EGL.EBid.active") then
		if EasyBidPrice > get("util.EasyBuyout.EGL.EBid.limit") then
			ChatFrame1:AddMessage("|cffCC1100EasyGoldLimit - Auction is over your set limit for EasyBid!")
			return;
		end
	end

	PlaceAuctionBid("list", getID, EasyBidPrice)
    CloseAuctionStaticPopups();
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-EasyBuyout/EasyBuyout.lua $", "$Rev: 4432 $")
