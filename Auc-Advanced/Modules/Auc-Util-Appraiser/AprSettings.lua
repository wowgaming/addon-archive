--[[
	Auctioneer - Appraisals and Auction Posting
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: AprSettings.lua 4484 2009-10-01 00:19:25Z kandoko $
	URL: http://auctioneeraddon.com/

	This is an addon for World of Warcraft that adds an appraisals tab to the AH for
	easy posting of your auctionables when you are at the auction house.

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

local lib = AucAdvanced.Modules.Util.Appraiser
local private = lib.Private
local print,_,_,_,_,_,get,set,default,_,fill, _TRANS = AucAdvanced.GetModuleLocals()
local coins = AucAdvanced.Coins

function private.GetPriceModels(itemLink)
	if not private.scanValueNames then private.scanValueNames = {} end
	for i = 1, #private.scanValueNames do
		private.scanValueNames[i] = nil
	end

	table.insert(private.scanValueNames,{"market", _TRANS("UCUT_Interface_MarketValue")})--Market value (reusing Undercut's translation)
	local algoList = AucAdvanced.API.GetAlgorithms(itemLink)
	for pos, name in ipairs(algoList) do
		if (name ~= lib.libName) then
			table.insert(private.scanValueNames,{name, _TRANS('APPR_Interface_Stats').." "..name})--Stats:
		end
	end
	return private.scanValueNames
end

function private.GetExtraPriceModels(itemLink)
	local vals = private.GetPriceModels(itemLink)
	table.insert(vals, {"fixed", _TRANS('APPR_Interface_FixedPrice') })--Fixed price
	table.insert(vals, {"default", _TRANS('APPR_Interface_Default') })--Default
	return vals
end

private.durations = {
	{ 720, _TRANS('APPR_Interface_12Hours')  },--12 hours
	{ 1440, _TRANS('APPR_Interface_24Hours')  },--24 hours
	{ 2880, _TRANS('APPR_Interface_48Hours')  },--48 hours
}

--[[ The items are stored as:
----   id, name, texture, quality
--]]
function private.sortItems(a,b)
	if (not a.ignore)~=(not b.ignore) then return (a.ignore and 1 or 0) < (b.ignore and 1 or 0) end
	if a[4] ~= b[4] then return a[4] > b[4] end
	if a[2] ~= b[2] then return a[2] < b[2] end
	if (not a.auction)~=(not b.auction) then return (a.auction and 1 or 0) < (b.auction and 1 or 0) end	-- sort an auction AFTER its corresponding inventory entry to drag-to-select picks the inventory item
	return a[1] < b[1]
end

function private.updateRoundExample()
	local method = AucAdvanced.Settings.GetSetting("util.appraiser.round.method") or "unit"
	local pos = tonumber(AucAdvanced.Settings.GetSetting("util.appraiser.round.position"))
	local mag = tonumber(AucAdvanced.Settings.GetSetting("util.appraiser.round.magstep"))
	local sub = tonumber(AucAdvanced.Settings.GetSetting("util.appraiser.round.subtract"))
	if pos == nil then pos = 0.10 end
	if mag == nil then mag = 5 end
	if sub == nil then sub = 1 end
	pos = math.floor(pos * 100)

	local roundname
	local output = {}
	local example = "  %s -> %s"

    local a,b, c,d, e,f
	if method == "unit" then
		roundname = _TRANS('APPR_Interface_StopValue')
	elseif method == "div" then
		roundname = _TRANS('APPR_Interface_Divisions')
	else
		AucAdvanced.Settings.SetSetting("util.appraiser.round.method", nil) -- saved setting was invalid, so clear it.
		roundname = _TRANS('APPR_Interface_StopValue')
	end

	tinsert(output, _TRANS('APPR_Interface_Examples'):format(roundname))
	local limit = 12

	local l, i, v, p = 0, 0, 1, 0
	while i < limit do
		local r = private.roundValue(v)
		if r ~= p then
			tinsert(output, example:format(coins(v,1), coins(r,1)))
			p = r
			v = math.max(p, v)
			i = i + 1
		end
		v = v + 1
		l = l + 1
		if i == limit - 5 and v < mag*100 then
			tinsert(output, "  ...")
			v = (mag * 10000 - pos) + 1
			i = i + 1
		end
		if l > 100000 then i = 8 end
	end
	private.roundNote:SetText(strjoin("\n", unpack(output)))
end

local round = {}
function round.div(value, pos, mag)
	local scale
	if value > mag * 1000000 then scale = 1000000 -- Round at the gold level
	elseif value > mag * 10000 then scale = 10000 -- Round at the silver level
	else scale = 100 end -- Round at the copper level

	local base = math.floor(value / scale) * scale -- This is the major amount that will stay
	local part = value - base -- This is the bit that's left over, we need to round this "up"
	                          -- to the next "division"
	local step = pos * scale / 100 -- This is how much the division steps up
	local divs = math.min(math.ceil(part / step) * step, scale) -- The new rounded up integral divisions
	return base + divs
end
function round.unit(value, pos, mag)
	local scale
	if value > mag * 1000000 then scale = 1000000 -- Round at the gold level
	elseif value > mag * 10000 then scale = 10000 -- Round at the silver level
	else scale = 100 end -- Round at the copper level

	local base = math.floor(value / scale) * scale -- This is the major amount that will stay
	local part = value - base -- This is the bit that's left over, we need to round this "up"
	                          -- to the next "division"
	local stop = pos * scale / 100 -- This is how much the division steps up
	local divs = stop
	if part > stop then
		divs = stop + scale
	end
	return base + divs
end

-- Function to round a value according to the current rounding method
function private.roundValue(value)
	local method = AucAdvanced.Settings.GetSetting("util.appraiser.round.method") or "unit"
	local pos = tonumber(AucAdvanced.Settings.GetSetting("util.appraiser.round.position"))
	local mag = tonumber(AucAdvanced.Settings.GetSetting("util.appraiser.round.magstep"))
	local sub = tonumber(AucAdvanced.Settings.GetSetting("util.appraiser.round.subtract"))
	if pos == nil then pos = 0.10 end
	if mag == nil then mag = 5 end
	if sub == nil then sub = 1 end
	pos = math.floor(pos * 100)

	local new
	if round[method] then new = round[method](value, pos, mag) end
	return math.floor(tonumber(new) or tonumber(value) or 1) - sub
end

function lib.RoundBid(value)
	if AucAdvanced.Settings.GetSetting("util.appraiser.round.bid") then
		return private.roundValue(value)
	else
		return math.floor(value + 0.5) --We CANNOT allow Decimal values to be passed to hooked modules such as beancounter, even if AH will not throw an error
	end
end

function lib.RoundBuy(value)
	if value ~= 0 and AucAdvanced.Settings.GetSetting("util.appraiser.round.buy") then
		return private.roundValue(value)
	else
		return math.floor(value + 0.5) --We CANNOT allow Decimal values to be passed to hooked modules such as beancounter, even if AH will not throw an error
	end
end

local scrollItems = {}
function lib.UpdateList()
	local n = #scrollItems
	for i = 1, n do
		scrollItems[i] = nil
	end
	local filter = AucAdvanced.Settings.GetSetting('util.appraiser.filter') or ""
	private.currentfilter = filter
	filter = filter:lower()
	if (filter == "") then filter = nil end

	local d = AucAdvancedData.UtilAppraiser
	if not d then
		AucAdvancedData.UtilAppraiser = {}
		d = AucAdvancedData.UtilAppraiser
	end
	if not d.items then
		d.items = {}
	end

	local data
	for i = 1, #(d.items) do
		data = d.items[i]
		if AucAdvanced.Settings.GetSetting("util.appraiser.item."..data[1]..".model") then
			if not filter or data[2]:find(filter, 1, true) then
				table.insert(scrollItems, data)
			end
		end
	end
	table.sort(scrollItems, private.sortItems)

	local pos = 0
	n = #scrollItems
	if (n <= 8) then
		private.scroller:Hide()
		private.scroller:SetValue(0)
	else
		private.scroller:Show()
		private.scroller:SetMinMaxValues(0, n-7)
		-- Find the current item
		for i = 1, n do
			if scrollItems[i][1] == private.selected then
				pos = i
				break
			end
		end
	end
	private.scroller:SetValue(math.max(0, math.min(n-7, pos-4)))
	private:SetScroll()
end

function private:SetScroll()
	local pos = private.scroller:GetValue()
	for i = 0, 7 do
		local item = scrollItems[pos+i]
		local button = private.items[i+1]
		if item then
			button.icon:SetTexture(item[3])
			local _,_,_, hex = GetItemQualityColor(item[4])
			button.name:SetText(hex.."["..item[2].."]|r")
			button:Show()
			if (item[1] == private.selected) then
				button.bg:Show()
			else
				button.bg:Hide()
			end
		else
			button:Hide()
		end
	end
end

function private:SelectItem(...)
	private.selected = self.id
	private:SetScroll()
	private:SetVisibility()
end

function private:SetVisibility()
	if private.selected and private.selected ~= "" then
		private.itemModel.setting = "util.appraiser.item."..private.selected..".model"
		private.itemStack.setting = "util.appraiser.item."..private.selected..".stack"
		private.itemFixBid.setting = "util.appraiser.item."..private.selected..".fixed.bid"
		private.itemFixBuy.setting = "util.appraiser.item."..private.selected..".fixed.buy"
		private.gui:Refresh()

		private.itemModel:Show()
		private.itemStack:Show()
		private.itemStack.textEl:Show()
		if AucAdvanced.Settings.GetSetting("util.appraiser.item."..private.selected..".model") == "fixed" then
			private.itemFixBid:Show()
			private.itemFixBid.textEl:Show()
			private.itemFixBuy:Show()
			private.itemFixBuy.textEl:Show()
		else
			private.itemFixBid:Hide()
			private.itemFixBid.textEl:Hide()
			private.itemFixBuy:Hide()
			private.itemFixBuy.textEl:Hide()
		end
	else
		private.itemModel:Hide()
		private.itemStack:Hide()
		private.itemStack.textEl:Hide()
		private.itemFixBid:Hide()
		private.itemFixBid.textEl:Hide()
		private.itemFixBuy:Hide()
		private.itemFixBuy.textEl:Hide()
	end
end

function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local id = gui:AddTab(lib.libName, lib.libType.." Modules")
	gui:MakeScrollable(id)

	gui:AddHelp(id, "what appraiser",
		_TRANS('APPR_Help_WhatAppraiser') ,--What is Appraiser?
		_TRANS('APPR_Help_WhatAppraiserAnswer') )--Appraiser is a tool to allow you to rapidly post auctions, and remembers your last posting prices automatically. The Appraiser interface attaches to your Auction House window as an extra tab at the bottom of the window. When you first select the Appraiser window, it will display all your auctionable items on the left side of your window. When you select an item from the left, you will see the control window at the top and the current auctions list at the bottom. The control window allows you to specify the posting stack size, for posting stack-splitted auctions, and the number of stacks to post by sliding the two sliders left and right.

	function private.addTooltipControls(id)
		gui:AddControl(id, "Header",     0,    _TRANS('APPR_Interface_AppraiserOptions') )--Appraiser options
		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
		gui:AddControl(id, "Checkbox",   0, 1, "util.appraiser.enable", _TRANS('APPR_Interface_ShowAppraisalTooltips') )--Show appraisal in the tooltips?
		gui:AddTip(id, _TRANS('APPR_HelpTooltip_ShowAppraisalTooltips') )--This option will cause the current Appraiser pricing model and calculated sale price in your tooltips when you mouseover the given item
		gui:AddControl(id, "Checkbox",   0, 4, "util.appraiser.bidtooltip", _TRANS('APPR_Interface_AlsoShowBid') )--Also show starting bid
		gui:AddTip(id, _TRANS('APPR_HelpTooltip_AlsoShowBid') )--This option will cause Appraiser to also show the starting bid price in the tooltip
		gui:AddControl(id, "Checkbox",   0, 4, "util.appraiser.ownauctions", _TRANS('APPR_Interface_ShowOwnAuctionsTooltips') )--Show own Auctions in the tooltips?
		gui:AddTip(id, _TRANS('APPR_HelpTooltip_ShowOwnAuctionsTooltips') )--This option will cause your current auctions to be displayed in your tooltips when you mouseover the given item
		gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
	end
	--This is the Tooltip tab provided by aucadvanced so all tooltip configuration is in one place
	local tooltipID = AucAdvanced.Settings.Gui.tooltipID
	
	--now we create a duplicate of these in the tooltip frame
	private.addTooltipControls(id)
	if tooltipID then private.addTooltipControls(tooltipID) end
	
	gui:AddControl(id, "Checkbox",     0, 1, "util.appraiser.displayauctiontab", _TRANS('APPR_Interface_ShowAppraiserTab') )--Show Appraiser tab at the Auction House
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_ShowAppraiserTab') )--Shows the appraiser tab on the auction house
	
	gui:AddControl(id, "Subhead",      0,    _TRANS('APPR_Interface_AppraiserFrameColoration') ) --Appraiser frame coloration
	gui:AddControl(id, "Checkbox",   0, 1, "util.appraiser.color", _TRANS('APPR_Interface_ColorAppraiserPriceLevel') )--Color Appraiser items by their PriceLevel data
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_ColorAppraiserPriceLevel') )--This option will use information from PriceLevel to tint the current auction valuations by how far above/below the current priceing model's mean in shades from red to blue.
	gui:AddControl(id, "Selectbox",  0, 3, {
		{"LEFT", _TRANS('APPR_Interface_Left') },--Left
		{"RIGHT", _TRANS('APPR_Interface_Right') },--Right
		{"TOP", _TRANS('APPR_Interface_Top') },--Top
		{"BOTTOM", _TRANS('APPR_Interface_Bottom') },--Bottom
		{"OFF", _TRANS('APPR_Interface_Off') },--Off
	}, "util.appraiser.colordirection", _TRANS('APPR_Interface_PickGradientDirection') )--Pick the gradient direction
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_PickGradientDirection') )--This determines the direction that the above gradient is drawn in for the Appraiser Browse window (if enabled).

	gui:AddControl(id, "Checkbox",  0, 1, "util.appraiser.manifest.color", _TRANS('APPR_Interface_ColorManifestByPriceLevel') )--Color bid and buy prices in the manifest frame by their PriceLevel data
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_ColorManifestByPriceLevel') )--This option will use information from PriceLevel to tint the per-stack prices of your bid and buyout lines in the right-side pop-out manifest frame
	gui:AddControl(id, "Checkbox",  0, 1, "util.appraiser.tint.color", _TRANS('APPR_Interface_TintBidBuyBoxesPriceLevel') )--Tint bid and buy input boxes by their PriceLevel data
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_TintBidBuyBoxesPriceLevel') )--This option will use information from PriceLevel to tint the bid and buyout input boxes
--	gui:AddControl(id, "Checkbox",   0, 1, "util.appraiser.clickhook", "Allow alt-clicking inventory items to load them into Appraiser")
--	gui:AddTip(id, "This option will enable the use of alt-clicking inventory items to select and post (in addition to being able to drag them into the Appraiser window).\nAlt-shift-click automatically posts the (stack of) item(s) clicked. Only active while the Appraiser tab is open.")
	gui:AddControl(id, "Checkbox",   0, 1, "util.appraiser.clickhookany", _TRANS('APPR_Interface_AltClickingAppraiserSetting') )--Allow alt-clicking items to change Appraiser settings for any item
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_AltClickingAppraiserSetting') )--This option will enable the use of alt-clicking items to bring up the Appraiser settings for the item so that they can be adjusted.\nOnly active while the Appraiser tab is open.
	gui:AddControl(id, "Checkbox",   0, 1, "util.appraiser.reselect", _TRANS('APPR_Interface_SelectNextItem') )--Select next item after posting
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_SelectNextItem') )--This option will enable Appraiser to select the next item from the list when you post.
	gui:AddControl(id, "Checkbox",   0, 1, "util.appraiser.buttontips", _TRANS('APPR_Interface_ShowTooltipControls') )--Show tooltip help over controls
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_ShowTooltipControls') )--This option will enable help tooltips for the Appraiser controls.

	gui:AddControl(id, "Subhead",    0,    _TRANS('APPR_Interface_DefaultPricingModel') )--Default pricing model
	gui:AddControl(id, "Selectbox",  0, 1, private.GetPriceModels, "util.appraiser.model", _TRANS('APPR_Interface_DefaultModelAppraisals') )--Default pricing model to use for appraisals
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_DefaultModelAppraisals') )--You may select a default and alternate pricing model for items that do not have a specific model set.
	gui:AddControl(id, "Subhead",    0,    _TRANS('APPR_Interface_AlternatePricingModel') )--Alternate pricing model
	gui:AddControl(id, "Selectbox",  0, 1, private.GetPriceModels, "util.appraiser.altModel", _TRANS('APPR_Interface_AlternatePricingModelSelectBox') )--Alternate pricing model to use for appraisals
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_AlternatePricingModelSelectBox') )--You may select a default and alternate pricing model for items that do not have a specific model set.
	gui:AddControl(id, "Subhead",    0,    _TRANS('APPR_Interface_UseMatchingDefault') )--Use Matching by Default
	gui:AddControl(id, "Checkbox",   0, 1, "util.appraiser.match", _TRANS('APPR_Interface_UseMatchingDefault') )--Use Matching by Default
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_UseMatchingDefault') )--This option determines whether to default to checking or unchecking the match competition checkbox.
	gui:AddControl(id, "Subhead",    0,   _TRANS('APPR_Interface_DefaultListingTime') )--Default Listing Time
	gui:AddControl(id, "Selectbox",  0, 1, private.durations, "util.appraiser.duration", _TRANS('APPR_Interface_DefaultListingDuration') )--Default listing duration
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_DefaultListingDuration') )--You may set a default auction listing duration for items that do not have a specific duration set.
	gui:AddControl(id, "Subhead",    0,    _TRANS('APPR_Interface_DefaultStackSize') )--Default Stack Size
	gui:AddControl(id, "Text",       0, 1, "util.appraiser.stack")
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_DefaultStackSize') )--Input number or 'max' to set the default size for stacks
	gui:AddControl(id, "Subhead",    0,    _TRANS('APPR_Interface_DefaultNumberStacks') )--Default Number of Stacks
	gui:AddControl(id, "Text",       0, 1, "util.appraiser.number")
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_DefaultNumberStacks') )--Input number, 'maxfull', or 'maxplus' to set the default number of stacks.  'maxfull' sets to all full stacks, while 'maxplus' sets to all stacks, including any incomplete stack

	gui:AddHelp(id, "what is clickhook",
		_TRANS('APPR_Help_WhatClickHooks') ,--What are the click-hooks?
		_TRANS('APPR_Help_WhatClickHooksAnswer') )--The click-hooks let you select an item by alt-clicking on it, or post it by alt-shift-clicking on it.
	gui:AddHelp(id, "what is model",
		_TRANS('APPR_Help_WhatDefaultPricing') ,--What is the default pricing model used for?
		_TRANS('APPR_Help_WhatDefaultPricingAnswer') )--When Appraiser calculates the price to list an item for, it will use either a market price, which is an average of certain other pricing models, or a price returned by a specific AuctioneerAdvanced statistics module. You may select the model that is used for items that have not had a particular model selected.

	gui:AddControl(id, "Subhead",    0,    _TRANS('APPR_Interface_StartingBidCalculation') )--Starting bid calculation
	gui:AddControl(id, "WideSlider", 0, 1, "util.appraiser.bid.markdown", 0, 100, 0.1, _TRANS('APPR_Interface_MarkdownBy').." %0.1f%%" )--Markdown by:
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_MarkdownBy') )--The markdown amount is a percentage amount that an item's calculated value will be reduced by to produce the bid value.
	gui:AddControl(id, "MoneyFramePinned", 0, 1, "util.appraiser.bid.subtract", 0, 9999999, _TRANS('APPR_Interface_SubtractAmount') )--Subtract amount:
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_SubtractAmount') )--The subtract amount is a fixed amount that an item's calculated value will have subtracted to produce the bid value.
	gui:AddControl(id, "Checkbox",   0, 1, "util.appraiser.bid.deposit", _TRANS('APPR_Interface_SubtractDepositCost') )--Subtract deposit cost
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_SubtractDepositCost') )--This option will cause the item's calculated value to be reduced by the value of the deposit rate to produce the bid value.
	gui:AddControl(id, "Checkbox", 0, 1, "util.appraiser.bid.vendor", _TRANS('APPR_Interface_VendorPriceMinimum') )--Vendor price as minimum
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_VendorPriceMinimum') )--This option will cause the item's bid to never fall below the vendor price of the item, taking into account the Auction House's cut.

	gui:AddHelp(id, "what is bid",
		_TRANS('APPR_Help_WhatStartingBid') ,--What is the starting bid?
		_TRANS('APPR_Help_WhatStartingBidAnswer') )--The starting bid is also known as the minimum bid. It is the price that the first bidder must match or exceed in order to place the bid. From there, the next bids must go up in bid increments based off the current bid.

	gui:AddHelp(id, "how bid calculated?",
		_TRANS('APPR_Help_HowBidPriceCalculated') ,--How does the bid price get calculated?
		_TRANS('APPR_Help_HowBidPriceCalculatedAnswer'):format("|cffffff00","|r", "|cffffff00", "|r", " |cffffff00", "|r" ) )--Except for fixed price items, the starting bid price is calculated based off the original buyout price. The bid price calculation options allow you to specify how the bid price is reduced, and the options are cumulative, so if you set both a markdown percent, and subtract the deposit cost, then the bid value will be calculated as:  (%s Buyout %s-%s Markdown %s-%s Deposit %s).

	gui:AddHelp(id, "how markdown calculated",
		_TRANS('APPR_Help_HowMarkdownPctCalculated') ,--How is the markdown percentage calculated?
		_TRANS('APPR_Help_HowMarkdownPctCalculatedAnswer') )--The amount is calculated by multiplying the calculated value by the percentage amount which is specified in the options. This amount is then subtracted from the calculated value (along with the fixed subtract amount and/or the deposit amount if specified) to produce the starting bid price.

	gui:AddControl(id, "Subhead",    0,    "".._TRANS('APPR_Interface_ValueRounding'))--Value rounding
	gui:AddControl(id, "Checkbox",   0, 1, "util.appraiser.round.bid", _TRANS('APPR_Interface_RoundStartingBid') )--Round starting bid
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_RoundStartingBid') )--This option causes the starting bid for any stacks posted to be rounded according to the following rules
	gui:AddControl(id, "Checkbox",   0, 1, "util.appraiser.round.buy", _TRANS('APPR_Interface_RoundBuyoutValue') )--Round buyout value
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_RoundBuyoutValue') )--This option causes the buyout amount for any stacks posted to be rounded according to the following rules
	gui:AddControl(id, "Selectbox",  0, 1, {
				{"unit",_TRANS('APPR_Interface_StopValue') },--Stop value
				{"div",_TRANS('APPR_Interface_Divisions') }--Divisions
				}, "util.appraiser.round.method", _TRANS('APPR_Interface_RoundingMethodUse') )--Rounding method to use
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_RoundingMethodUse') )--You select the rounding algorithm to use for rounding the selected stack prices.
	gui:AddControl(id, "WideSlider", 0, 1, "util.appraiser.round.position", 0.01, 1.00, 0.01, _TRANS('APPR_Interface_Rounding').." %0.02f" )--Rounding at:
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_Rounding') )--This slider allows you to select the position that the rounding algorithm will use to round at
	gui:AddControl(id, "WideSlider", 0, 1, "util.appraiser.round.magstep", 1, 100, 1, _TRANS('APPR_Interface_StepMagnitude').." %d" )--Step magnitude at:
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_StepMagnitude'):format("|cffffff00") )--This slider allows you to select the point at which the rounding will step up to the next unit place %s( copper->silver->gold ).
	gui:AddControl(id, "WideSlider", 0, 1, "util.appraiser.round.subtract", -99, 99, 1, _TRANS('APPR_Interface_RoundSubtract').." %d" )--Subtract fixed amount:
	gui:AddTip(id, _TRANS('APPR_HelpTooltip_RoundSubtract'))--This slider allows you to subtract a fixed value from the rounded number to roughen it up (eg: put 1 here to make your "round" 1g25s into 1g24s99c.

	private.roundNote = gui:AddControl(id, "Note",       0, 2, 500, 200, "")
	local fontFile = private.roundNote:GetFont()
	private.roundNote:SetFont(fontFile, 15)
	private.updateRoundExample()

	gui:AddHelp(id, "what is rounding",
		_TRANS('APPR_Interface_WhatValueRounding') ,--What is value rounding?
		_TRANS('APPR_HelpTooltip_WhatValueRounding') )--Value rounding is used to cause the auction prices of all listings where the prices are calculated (ie: not fixed price auctions) to be rounded out to neat units. An example of this is if you wanted to always round 1g 42s 15c up to 1g 42s 95c. By using this feature, you can make sure all your auctions will have their prices rounded out.

	gui:AddHelp(id, "which method",
		"".._TRANS('APPR_Interface_WhichMethod'),--Which method do I use?
		_TRANS('APPR_HelpTooltip_WhichMethod') )--The method that you use depends on how you want your values rounded. Appraiser currently supports 2 methods of rounding which round in different ways. The 'Stop value' method will always round up to the next occurunce of the selected rounding position. An example of this is if your stack price is 1g 42s 15c and your rounding position is 0.95, the next occurance would be at 1g 42s 95c. The 'Divisions' method will always round up to the next multiple of the selected rounding position for the selected unit (copper, silver, copper). An example of this is if your stack price is 1g 42s 32c and your rounding position is 0.25, the next occurance would be at 1g 42s 50c.

	gui:AddHelp(id, "what is position",
		_TRANS('APPR_Interface_WhatRoundingPosition') ,--'What is the rounding position?
		_TRANS('APPR_HelpTooltip_WhatRoundingPosition') )--The rounding position ('Rounding at' value in the settings) used by the rounding methods to determine the point at which they are going to round to. Perhaps the easiest way to see how this works is to open up the Auction House and select an item, then play with the sliders, and watch what happens to the stack prices that are listed on the right side of the auction window.

	gui:AddHelp(id, "what is magnitude",
		_TRANS('APPR_Interface_WhatStepMagnitude') ,--What is the step magnitude?
		_TRANS('APPR_HelpTooltip_WhatStepMagnitude'):format(" |cffffff00", "|r") )--The step magnitude specifies the point at which the algorithm decides to move up to the next unit place (%s copper->silver->gold %s). For example, if the step magnitude was set to 5, then an amount of 1g 45s 12c would round at the copper place, but an amount of 5g 45s 12c would round at the silver place.

	gui:AddHelp(id, "what is playerignore",
		_TRANS('APPR_Interface_HowIgnoreSeller') ,--How to ignore a seller's auctions?
		_TRANS('APPR_HelpTooltip_HowIgnoreSeller') )--ALT click on the seller you wish to ignore and select yes in the pop up window. The seller's name will be marked in red and placed in the BASIC FILTER module's ignored list.
	gui:AddHelp(id, "what is playerunignore",
		_TRANS('APPR_Interface_HowUnIgnoreSeller') ,--How to un-ignore a seller's auctions?
		_TRANS('APPR_HelpTooltip_HowUnIgnoreSeller') )--ALT click on the seller you wish to remove from ignore and select yes in the pop up window. The seller's name will be removed from the BASIC FILTER module's ignored list.

	--[[
	gui:AddControl(id, "Subhead",    0,    "Item pricing models")

	local last = gui:GetLast(id)

	gui.scalewidth = 0.4
	local content = gui.tabs[id][3]

	local box = CreateFrame("Frame", nil, content)

	local filter = gui:AddControl(id, "Text", 0.01, 1, "util.appraiser.filter", "");
	filter.textEl:Hide()
	filter.textEl:SetHeight(0)
	filter:SetBackdropColor(0, 0, 0.6, 0.8)
	filter:SetTextInsets(50,0,0,0)
	filter.clearance = -5
	filter.text = filter:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	filter.text:SetPoint("LEFT", filter, "LEFT", 3,0)
	filter.text:SetText("Filter:")
	AucAdvanced.Settings.SetSetting('util.appraiser.filter', "")

	private.items = {}
	for i=1, 8 do
		local frame = CreateFrame("Button", "AucApraiserItem"..i, box)
		private.items[i] = frame
		frame:SetHeight(20)
		frame:SetScript("OnClick", private.SelectItem)
		frame.id = i

		frame.icon = frame:CreateTexture(nil, "OVERLAY")
		frame.icon:SetHeight(20)
		frame.icon:SetWidth(20)
		frame.icon:SetPoint("LEFT", frame, "LEFT", 0,0)
		frame.icon:SetTexture("Interface\\InventoryItems\\WoWUnknownItem01")

		frame.name = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		frame.name:SetJustifyH("LEFT")
		frame.name:SetJustifyV("BOTTOM")
		frame.name:SetPoint("LEFT", frame.icon, "RIGHT", 3,0)
		frame.name:SetText("[None]")

		frame.bg = frame:CreateTexture(nil, "ARTWORK")
		frame.bg:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
		frame.bg:SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
		frame.bg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0,0)
		frame.bg:SetAlpha(0.6)
		frame.bg:SetBlendMode("ADD")

		frame:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")

		frame.clearance = -3
		gui:AddControl(id, "Custom", 0, 1, frame)
	end
	gui.scalewidth = nil

	box:SetPoint("TOP", filter, "TOP", 0, 5)
	box:SetPoint("LEFT", private.items[8], "LEFT", -5, 0)
	box:SetPoint("BOTTOMRIGHT", private.items[8], "BOTTOMRIGHT", 25, -5)
	box:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	box:SetBackdropColor(0, 0, 0, 0.8)

	local scroller = CreateFrame("Slider", "AucApraiserItemScroll", content);
	scroller:SetPoint("TOPLEFT", private.items[1], "TOPRIGHT", 0,0)
	scroller:SetPoint("BOTTOMLEFT", private.items[8], "BOTTOMRIGHT", 0,0)
	scroller:SetWidth(20)
	scroller:SetOrientation("VERTICAL")
	scroller:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	scroller:SetMinMaxValues(1, 30)
	scroller:SetValue(1)
	scroller:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	scroller:SetBackdropColor(0, 0, 0, 0.8)
	scroller:SetScript("OnValueChanged", private.SetScroll)
	private.scroller = scroller

	local continue = gui:GetLast(id)

	gui:SetLast(id, last)

	private.itemModel = gui:AddControl(id, "Selectbox", 0.5, 1, private.GetExtraPriceModels, "util.appraiser.item.0.model", "Pricing model to use for this item")
	private.itemStack = gui:AddControl(id, "Slider", 0.5, 1, "util.appraiser.item.0.stack", 0, 20, 1, "Stack size: %s")
	private.itemFixBid = gui:AddControl(id, "MoneyFramePinned", 0.5, 1, "util.appraiser.item.0.fixed.bid", 0, 99999999, "Fixed bid:")
	private.itemFixBuy = gui:AddControl(id, "MoneyFramePinned", 0.5, 1, "util.appraiser.item.0.fixed.buy", 0, 99999999, "Fixed buyout:")

	gui:SetLast(id, continue)

	lib.UpdateList()
]]

	private.gui = gui
	private.guiId = id
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-Appraiser/AprSettings.lua $", "$Rev: 4484 $")
