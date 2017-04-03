--[[

Skillet: A tradeskill window replacement.
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

-- Localization
local L = AceLibrary("AceLocale-2.2"):new("Skillet")

local merchant_inventory = {}

-- Get the name for the item in the specified merchant slot. Can
-- only be called when the merchant window is open
local function get_merchant_item_name(slot)
	local link = GetMerchantItemLink(slot);
	if link then
    	local _,_,name = string.find(link, "^.*%[(.*)%].*$");
    	return name;
 	else
    	return nil;
    end
end

-- Checks to see if the cached list of items for this merchant
-- included anything we need to buy.
local function does_merchant_sell_required_items(list)
	for i=1,#list,1 do
		local id  = list[i].id

		if merchant_inventory[id] then
			return true
		end
	end

	return false
end

-- Scans everything the merchant has and adds it to a table
-- that we can refer to when looking for items to buy.
local function update_merchant_inventory()
	if MerchantFrame and MerchantFrame:IsVisible() then
		local count = GetMerchantNumItems()
		
		if count == 148 then				-- ??
			count = 0
		end
		for i=1, count, 1 do
			local link = GetMerchantItemLink(i)
		
			if link then
				local name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(i)
				if numAvailable == -1  then
					local id = Skillet:GetItemIDFromLink(link)
					merchant_inventory[id] = {}										-- TODO: record this info if PT doesn't already have it
					merchant_inventory[id].price = price
					merchant_inventory[id].stack = quantity
				end
			end
		end
	end
end

-- Inserts/updates a button in the merchant frame that allows
-- you to automatically buy reagents.
local function update_merchant_buy_button()
	Skillet:InventoryScan()
    local list = Skillet:GetShoppingList(UnitName("player"), false)

	if not list or #list == 0 then
        SkilletMerchantBuyFrame:Hide()
		return
	elseif does_merchant_sell_required_items(list) == false then
        SkilletMerchantBuyFrame:Hide()
		return
	end

    if SkilletMerchantBuyFrame:IsVisible() then
        -- already inserted the button
        return
    end

	SkilletMerchantBuyFrameTopText:SetText(L["This merchant sells reagents you need!"]);
	SkilletMerchantBuyFrameButton:SetText(L["Buy Reagents"]);

	SkilletMerchantBuyFrame:SetPoint("TOPLEFT", "MerchantFrame", "TOPLEFT" , 60, -28);
	SkilletMerchantBuyFrame:SetFrameStrata("HIGH");
	SkilletMerchantBuyFrame:Show();
end

-- Removes the merchant buy button
local function remove_merchant_buy_button()
	SkilletMerchantBuyFrame:Hide()
end

-- Updates the merchant frame, it is it visible, this method can be called
-- many times
function Skillet:UpdateMerchantFrame()
    Skillet:MERCHANT_SHOW()
end

-- Merchant window opened. This method can be called multiple
-- times if needed, and it can be called even if a merchant window
-- is not open.
function Skillet:MERCHANT_SHOW()
 	if MerchantFrame and not MerchantFrame:IsVisible() then
        -- called when the merchant frame is not visible, this is a no-op
        return
    end
	
	merchant_inventory = {}

	if Skillet.db.profile.vendor_buy_button or Skillet.db.profile.vendor_auto_buy then
		update_merchant_inventory()
	end

	if Skillet.db.profile.vendor_auto_buy then
		if not self.autoPurchaseComplete then
			self.autoPurchaseComplete = true				-- annoying lag causes multiple purchases because merchant frame shows again before our bags update
			self:BuyRequiredReagents()
		else
			update_merchant_buy_button()
		end
	elseif Skillet.db.profile.vendor_buy_button then
		update_merchant_buy_button()
	end
end

-- Merchant window updated
function Skillet:MERCHANT_UPDATE()
	if Skillet.db.profile.vendor_buy_button or Skillet.db.profile.vendor_auto_buy then
		update_merchant_inventory()
	end
	self:InventoryScan()						-- prolly not needed
end

-- Merchant window closed
function Skillet:MERCHANT_CLOSED()
	remove_merchant_buy_button()
	merchant_inventory = {}
	self.autoPurchaseComplete = nil
	self:InventoryScan()						-- prolly not needed
end

-- If at a vendor with the window open, buy anything that they
-- sell that is required by any queued reciped.
function Skillet:BuyRequiredReagents()
	local list = Skillet:GetShoppingList(UnitName("player"), false)

	if #list == 0 then
		return
	elseif does_merchant_sell_required_items(list) == false then
		return
	elseif not MerchantFrame or MerchantFrame:IsVisible() == false then
		return
	end

	local totalspent = 0;
	local abacus = AceLibrary("Abacus-2.0")

	local items_purchased = 0;

	-- for each item they sell, see if we need it
	-- ... if we do, buy the hell out of it.
	local count = GetMerchantNumItems()
	if count == 148 then
		count = 0
	end
	for i=1, count, 1 do
		local link = GetMerchantItemLink(i)
		if link then
			local name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(i)
			if numAvailable == -1 then
				local id = self:GetItemIDFromLink(link)
				-- OK, lets see if we need it.
				local count = 0;

				for j=1,#list,1 do
					if list[j].id == id then
						count = list[j].count
						break
					end
				end

				if count > 0 then
					local name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(i);
					local sName, sLink, iQuality, iLevel, iMinLevel, sType, sSubType, stackSize = GetItemInfo(GetMerchantItemLink(i));
					local itemstobuy = math.ceil(count/quantity);

					if(stackSize == nil) then
						for l=1, count, 1 do
							-- XXX: need some error checking here in case the
							-- poor user runs out of money.
							BuyMerchantItem(i,1)
						end
					else
						local fullstackstobuy    = math.floor(count/stackSize);
						local fullstackitemcount = math.floor(stackSize/quantity);
						local resttobuy          = math.ceil((count-(fullstackstobuy*stackSize))/quantity);
						if fullstackstobuy > 0 then
							for l=1,fullstackstobuy,1 do
								-- XXX: need some error checking here in case the
								-- poor user runs out of money.
								BuyMerchantItem(i,fullstackitemcount);
							end
						end
						if resttobuy > 0 then
							-- XXX: need some error checking here in case the
							-- poor user runs out of money.
							BuyMerchantItem(i,resttobuy);
						end
					end

					items_purchased = items_purchased + 1
					local itemspent = price * itemstobuy -- spent on this type of item
					totalspent = totalspent + itemspent  -- spent on all items from this merchant
					local message = L["Purchased"]
					local cash = abacus:FormatMoneyFull(itemspent, true);
					message = message .. ": " .. (itemstobuy*quantity) .. " x "..GetMerchantItemLink(i).." (" .. cash .. ")";
					self:Print(message);
				end
			end
		end
	end

	if totalspent > 0 and items_purchased > 1 then
		local message = L["Total spent"]
		local cash = abacus:FormatMoneyFull(totalspent, true)
		message = message .. ": " .. cash
		self:Print(message)
	end

	self:InventoryScan()
	update_merchant_buy_button()
end



function Skillet:MerchantBuyButton_OnEnter(button)
	local abacus = AceLibrary("Abacus-2.0")
	
	GameTooltip:SetOwner(button, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:ClearLines()
	GameTooltip:AddLine(L["Buy Reagents"])
	
	local needList = Skillet:GetShoppingList(UnitName("player"), false)
	local totalCost = 0
	
	for i=1,#needList,1 do
		local itemID = needList[i].id
		
		if merchant_inventory[itemID] then
			local cost = merchant_inventory[itemID].price * math.ceil(needList[i].count/merchant_inventory[itemID].stack)
			
			totalCost = totalCost + cost
			GameTooltip:AddDoubleLine((GetItemInfo(itemID)).." x "..needList[i].count, abacus:FormatMoneyFull(cost, true),1,1,0)
		end
	end
	
	if #needList > 1 then
		GameTooltip:AddDoubleLine("Total Cost:", abacus:FormatMoneyFull(totalCost, true),0,1,0)
	end
		
	GameTooltip:Show()
end


function Skillet:MerchantBuyButton_OnLeave(button)
	GameTooltip:Hide()
end

