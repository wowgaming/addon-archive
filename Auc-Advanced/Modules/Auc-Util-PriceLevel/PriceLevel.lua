--[[
	Auctioneer - Price Level Utility module
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: PriceLevel.lua 4206 2009-05-08 17:28:52Z brykrys $
	URL: http://auctioneeraddon.com/

	This is an addon for World of Warcraft that adds a price level indicator
	to auctions when browsing the Auction House, so that you may readily see
	which items are bargains or overpriced at a glance.

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

local libType, libName = "Util", "PriceLevel"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill = AucAdvanced.GetModuleLocals()

local data

function lib.Processor(callbackType, ...)
	if (callbackType == "tooltip") then
		lib.ProcessTooltip(...)
	elseif (callbackType == "config") then
		private.SetupConfigGui(...)
	elseif (callbackType == "listupdate") then
		private.ListUpdate(...)
	elseif (callbackType == "configchanged") then
		if (AuctionFrameBrowse_Update) then
			AuctionFrameBrowse_Update()
		end
	end
end

function lib.ProcessTooltip(tooltip, name, hyperlink, quality, quantity, cost, additional)
	-- In this function, you are afforded the opportunity to add data to the tooltip should you so
	-- desire. You are passed a hyperlink, and it's up to you to determine whether or what you should
	-- display in the tooltip.
	if not  get("util.pricelevel.single") then return end

	if not additional or not additional.buyoutPrice or not additional.minBid then return end

	local priceLevel, perItem, r,g,b = lib.CalcLevel(hyperlink, quantity, additional.minBid, additional.buyoutPrice)
	if (not priceLevel) then return end

	tooltip:AddLine(("Price Level: %d%%"):format(priceLevel), perItem, r,g,b)
end

function lib.OnLoad()
	default("util.pricelevel.colorize", false)
	default("util.pricelevel.single", true)
	default("util.pricelevel.model", "market")
	default("util.pricelevel.basis", "try")
	default("util.pricelevel.blue", 0)
	default("util.pricelevel.green", 50)
	default("util.pricelevel.yellow", 80)
	default("util.pricelevel.orange", 110)
	default("util.pricelevel.red", 135)
	default("util.pricelevel.opacity", 30)
	default("util.pricelevel.gradient", true)
	default("util.pricelevel.direction", "LEFT")

	set("util.pricelevel.blue", nil) -- blue is a fake slider for display only - always 0

end

--[[ Local functions ]]--

function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local id = gui:AddTab(libName, libType.." Modules")

	gui:AddHelp(id, "what is pricelevel",
		"What is PriceLevel?",
		"PriceLevel is an Auctioneer module that analyses the current market position with regard to the calculated value of the item.\n"..
		"PriceLevel is all about determining if what Auctioneer thinks is what the rest of the market currently thinks. It's also about determining if the rest of the market is selling their stuff for crazy prices.\n"..
		"What it all comes down to is the color... PriceLevel breaks the current market down into 5 categories: |cff3296ffWay underpriced|r, |cff19ff19Fairly underpriced|r, |cffffff00Just underpriced|r, |cffff9619Reasonable|r, and |cffff0000Overpriced|r. It also has options for adding the calculated level to the tooltip and in the browse window of the Auction House.")

	gui:AddControl(id, "Header",     0,    libName.." Options")
	gui:AddControl(id, "Checkbox",   0, 1, "util.pricelevel.single", "Show the PriceLevel and unit price in the tooltips")
	gui:AddTip(id, "Enable this to display the PriceLevel information in the tooltip when you mouse over an item in your inventory")

	gui:AddHelp(id, "what is ahcolor",
		"What does changing the Auction House items' colors do?",
		"This will change the background of the items at the Auction House so that you can more easily identify bargains or overpriced items as you are browsing.")

	gui:AddControl(id, "Checkbox",   0, 1, "util.pricelevel.colorize", "Change the color of items in the Auction House")
	gui:AddTip(id, "This option changes the color of the items lines in the Auction House so that you may more easily determine whether they are over or under priced prior to purchase")
	gui:AddControl(id, "Slider",     0, 2, "util.pricelevel.opacity", 1, 100, 1, "Opacity level: %d%%")
	gui:AddTip(id, "This controls the level of opacity for the colored bars in the Auction Browse window. (if enabled)")
	gui:AddControl(id, "Checkbox",   0, 2, "util.pricelevel.gradient", "Use a gradient:")
	gui:AddTip(id, "This causes the colored bars in the Auction Browse window to be drawn with a gradient instead of a solid color (if enabled).")
	gui:AddControl(id, "Selectbox",  0, 3, {
		{"LEFT", "Left"},
		{"RIGHT", "Right"},
		{"TOP", "Top"},
		{"BOTTOM", "Bottom"},
	}, "util.pricelevel.direction", "Pick the gradient direction")
	gui:AddTip(id, "This determines the direction that the above gradient is drawn in for the Auction Browse window (if enabled).")
	gui:AddControl(id, "Subhead",    0,    "Price valuation method:")
	gui:AddControl(id, "Selectbox",  0, 1, parent.selectorPriceModels, "util.pricelevel.model", "Pricing model to use for the valuation")
	gui:AddTip(id, "The pricing model that is used to work out the calculated value of items at the Auction House.")
	gui:AddControl(id, "Subhead",    0,    "Price level basis:")
	gui:AddControl(id, "Selectbox",  0, 1, {
		{"cur", "Next bid price"},
		{"buy", "Buyout only"},
		{"try", "Buyout or bid"},
	}, "util.pricelevel.basis", "Which price to use for the PriceLevel")
	gui:AddTip(id, "Selects which price to base the PriceLevel calculation off of.")

	gui:AddHelp(id, "what is basis",
		"What is the PriceLevel basis?",
		"The Auction House has both bids and buyout values to calculate from. You can select to price the item based off either exclusively the buyout or bid, or first the buyout if it exists, and then the bid")

	gui:AddControl(id, "Subhead",    0,    "Pricing points:")
	gui:AddControl(id, "WideSlider", 0, 1, "util.pricelevel.red",    0, 500, 5, "|cffff0000Red|r price level > %d%%")
	gui:AddTip(id, "This determines the minimum level for an item to be counted as a red item.")
	gui:AddControl(id, "WideSlider", 0, 1, "util.pricelevel.orange", 0, 500, 5, "|cffff9619Orange|r price level > %d%%")
	gui:AddTip(id, "This determines the minimum level for an item to be counted as a orange item.")
	gui:AddControl(id, "WideSlider", 0, 1, "util.pricelevel.yellow", 0, 500, 5, "|cffffff00Yellow|r price level > %d%%")
	gui:AddTip(id, "This determines the minimum level for an item to be counted as a yellow item.")
	gui:AddControl(id, "WideSlider", 0, 1, "util.pricelevel.green", 0, 500, 5, "|cff19ff19Green|r price level > %d%%")
	gui:AddTip(id, "This determines the minimum level for an item to be counted as a green item.")
	gui:AddControl(id, "WideSlider", 0, 1, "util.pricelevel.blue", 0, 0, 1, "|cff3296ffBlue|r price level > %d%%")
	gui:AddTip(id, "This slider does nothing and is just here for completeness to show that blue is under green.")

	gui:AddHelp(id, "what is points",
		"What are the pricing points for?",
		"The pricing points determine the ranges for the various PriceLevel colored bands.\n"..
		"As an item's price moves up through the bands, it will change to the next color.")

	gui:AddHelp(id, "wtf blue stuck qq",
		"Why is the blue slider stuck at zero?",
		"Something has to start at zero, and blue's the one that does it. If you moved blue off zero, then what would we color stuff under blue?")

	gui:AddHelp(id, "wtf blue stuck l2code",
		"Ok, so why did you put the blue slider in then?",
		"To appease my wife... Deal. :)")

end

function lib.ResetBars()
	local tex
	for i=1, NUM_BROWSE_TO_DISPLAY do
		tex = getglobal("BrowseButton"..i.."PriceLevel")
		if (tex) then tex:Hide() end
	end
end

function lib.SetBar(i, r,g,b, pct)
	local tex
	local button = getglobal("BrowseButton"..i)
	local colorize = AucAdvanced.Settings.GetSetting("util.pricelevel.colorize")

	if (button.AddTexture) then
		tex = button.AddTexture
		if (button.Value) then
			if (pct) then
				if pct > 999 then
					button.Value:SetText(">999%")
				else
					button.Value:SetText(("%d%%"):format(pct))
				end
				if colorize then
					button.Value:SetTextColor(1,1,1)
				else
					button.Value:SetTextColor(r,g,b)
				end
			else
				button.Value:SetText("")
				button.Value:SetTextColor(1,1,1)
			end
		end
		if not colorize then
			tex:Hide()
		end
	else
		tex = getglobal("BrowseButton"..i.."PriceLevel")
	end
	if not colorize then return end

	if not tex then
		tex = button:CreateTexture("BrowseButton"..i.."PriceLevel")
		tex:SetPoint("TOPLEFT")
		tex:SetPoint("BOTTOMRIGHT", 0, 5)
	end

	if (r and g and b) then
		local opacity = AucAdvanced.Settings.GetSetting("util.pricelevel.opacity")
		opacity = math.floor(tonumber(opacity) or 50) / 100
		if (opacity < 0) then opacity = 0.01
		elseif (opacity > 1) then opacity = 1 end

		local gradient = AucAdvanced.Settings.GetSetting("util.pricelevel.gradient")
		tex:SetTexture(1,1,1)
		if (gradient) then
			local direction = AucAdvanced.Settings.GetSetting("util.pricelevel.direction")
			if (direction == "LEFT") then
				tex:SetGradientAlpha("Horizontal", r,g,b, 0, r,g,b, opacity)
			elseif (direction == "RIGHT") then
				tex:SetGradientAlpha("Horizontal", r,g,b, opacity, r,g,b, 0)
			elseif (direction == "BOTTOM") then
				tex:SetGradientAlpha("Vertical", r,g,b, 0, r,g,b, opacity)
			elseif (direction == "TOP") then
				tex:SetGradientAlpha("Vertical", r,g,b, opacity, r,g,b, 0)
			end
		else
			tex:SetGradientAlpha("Vertical", r,g,b, opacity, r,g,b, opacity)
		end
		tex:Show()
	else
		tex:Hide()
	end
end

function private.ListUpdate()
	lib.ResetBars()
	local index, link, quantity, minBid, minInc, buyPrice, bidPrice, priceLevel, perItem, r,g,b, _
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)

	for i=1, NUM_BROWSE_TO_DISPLAY do
		index = offset + i + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page);
		if (index <= numBatchAuctions + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page)) then
			if AucAdvanced.Modules.Util.CompactUI
			and AucAdvanced.Modules.Util.CompactUI.inUse then
				_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
				priceLevel,_,r,g,b = AucAdvanced.Modules.Util.CompactUI.GetContents(offset+i)
				lib.SetBar(i, r,g,b, priceLevel)
			else
				link =  GetAuctionItemLink("list", offset + i)
				if link then
					_,_, quantity, _,_,_, minBid, minInc, buyPrice, bidPrice =  GetAuctionItemInfo("list", offset + i)
					if bidPrice>0 then bidPrice = bidPrice + minInc
					else bidPrice = minBid end
					priceLevel, perItem, r,g,b = lib.CalcLevel(link, quantity, bidPrice, buyPrice)
					lib.SetBar(i, r,g,b, priceLevel)
				end
			end
		end
	end
end

function lib.CalcLevel(link, quantity, bidPrice, buyPrice, itemWorth)
	if not quantity or quantity < 1 then quantity = 1 end

	local priceModel = AucAdvanced.Settings.GetSetting("util.pricelevel.model")
	local priceBasis = AucAdvanced.Settings.GetSetting("util.pricelevel.basis")

	local stackPrice
	if (priceBasis == "cur") then
		stackPrice = bidPrice
	elseif (priceBasis == "buy") then
		if not buyPrice or buyPrice <= 0 then return end
		stackPrice = buyPrice
	elseif (priceBasis == "try") then
		stackPrice = buyPrice or 0
		if stackPrice <= 0 then
			stackPrice = bidPrice
		end
	end
	if not stackPrice then return end

	if not itemWorth then
		if (priceModel == "market") then
			itemWorth = AucAdvanced.API.GetMarketValue(link)
		else
			itemWorth = AucAdvanced.API.GetAlgorithmValue(priceModel, link)
		end
		if not itemWorth then return end
	end

	local perItem = stackPrice / quantity
	local priceLevel = perItem / itemWorth * 100

	local r, g, b, lvl

	r,g,b,lvl = 0.2,0.6,1.0, "blue"
	if priceLevel > AucAdvanced.Settings.GetSetting("util.pricelevel.red") then
		r,g,b,lvl = 1.0,0.0,0.0, "red"
	elseif priceLevel > AucAdvanced.Settings.GetSetting("util.pricelevel.orange") then
		r,g,b,lvl = 1.0,0.6,0.1, "orange"
	elseif priceLevel > AucAdvanced.Settings.GetSetting("util.pricelevel.yellow") then
		r,g,b,lvl = 1.0,1.0,0.0, "yellow"
	elseif priceLevel > AucAdvanced.Settings.GetSetting("util.pricelevel.green") then
		r,g,b,lvl = 0.1,1.0,0.1, "green"
	end

	return priceLevel, perItem, r,g,b, lvl, itemWorth
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Util-PriceLevel/PriceLevel.lua $", "$Rev: 4206 $")
