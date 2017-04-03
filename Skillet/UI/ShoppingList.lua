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

--[[
#
# Deals with building and maintaining a shopping list. This is the list
# of items that are required for queued receipes but are not currently
# in the inventory
#
]]--

SKILLET_SHOPPING_LIST_HEIGHT = 16

local L = AceLibrary("AceLocale-2.2"):new("Skillet")

-- Stolen from the Waterfall Ace2 addon.
local ControlBackdrop  = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}
local FrameBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 30, bottom = 3 }
}

-- Creates and sets up the shopping list window
local function createShoppingListFrame(self)
	local frame = SkilletShoppingList
	if not frame then
		return nil
	end

	frame:SetBackdrop(FrameBackdrop);
	frame:SetBackdropColor(0.1, 0.1, 0.1)

	-- A title bar stolen from the Ace2 Waterfall window.
	local r,g,b = 0, 0.7, 0; -- dark green
	local titlebar = frame:CreateTexture(nil,"BACKGROUND")
	local titlebar2 = frame:CreateTexture(nil,"BACKGROUND")

	titlebar:SetPoint("TOPLEFT",frame,"TOPLEFT",3,-4)
	titlebar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",-3,-4)
	titlebar:SetHeight(13)

	titlebar2:SetPoint("TOPLEFT",titlebar,"BOTTOMLEFT",0,0)
	titlebar2:SetPoint("TOPRIGHT",titlebar,"BOTTOMRIGHT",0,0)
	titlebar2:SetHeight(13)

	titlebar:SetGradientAlpha("VERTICAL",r*0.6,g*0.6,b*0.6,1,r,g,b,1)
	titlebar:SetTexture(r,g,b,1)
	titlebar2:SetGradientAlpha("VERTICAL",r*0.9,g*0.9,b*0.9,1,r*0.6,g*0.6,b*0.6,1)
	titlebar2:SetTexture(r,g,b,1)

	local title = CreateFrame("Frame",nil,frame)
	title:SetPoint("TOPLEFT",titlebar,"TOPLEFT",0,0)
	title:SetPoint("BOTTOMRIGHT",titlebar2,"BOTTOMRIGHT",0,0)

	local titletext = title:CreateFontString("SkilletShoppingListTitleText", "OVERLAY", "GameFontNormalLarge")
	titletext:SetPoint("TOPLEFT",title,"TOPLEFT",0,0)
	titletext:SetPoint("TOPRIGHT",title,"TOPRIGHT",0,0)
	titletext:SetHeight(26)
	titletext:SetShadowColor(0,0,0)
	titletext:SetShadowOffset(1,-1)
	titletext:SetTextColor(1,1,1)
	titletext:SetText("Skillet: " .. L["Shopping List"])

	SkilletShowQueuesFromAllAltsText:SetText(L["Include alts"])
	SkilletShowQueuesFromAllAlts:SetChecked(Skillet.db.char.include_alts)

	-- The frame enclosing the scroll list needs a border and a background .....
	local backdrop = SkilletShoppingListParent
	backdrop:SetBackdrop(ControlBackdrop)
	backdrop:SetBackdropBorderColor(0.6, 0.6, 0.6)
	backdrop:SetBackdropColor(0.05, 0.05, 0.05)
	backdrop:SetResizable(true)

	-- Button to retrieve items needed from the bank
	SkilletShoppingListRetrieveButton:SetText(L["Retrieve"])

	-- Ace Window manager library, allows the window position (and size)
	-- to be automatically saved
	local windowManger = AceLibrary("Window-1.0")
	local tradeSkillLocation = {
		prefix = "shoppingListLocation_"
	}
	windowManger:RegisterConfig(frame, self.db.char, shoppingListLocation)
	windowManger:RestorePosition(frame)  -- restores scale also
	windowManger:MakeDraggable(frame)

	-- lets play the resize me game!
	Skillet:EnableResize(frame, 300, 165, Skillet.UpdateShoppingListWindow)

	-- so hitting [ESC] will close the window
	tinsert(UISpecialFrames, frame:GetName())
	return frame
end

function Skillet:ShoppingListButton_OnEnter(button)
	local name, link, quality = self:GetItemInfo(button.id)

	GameTooltip:SetOwner(button, "ANCHOR_TOPLEFT")
	GameTooltip:SetHyperlink(link)
	GameTooltip:Show()

	if EnhTooltip and EnhTooltip.TooltipCall then
		quantity = button.count

		EnhTooltip.TooltipCall(GameTooltip, name, link, quality, quantity)
	end

	CursorUpdate()
end

function Skillet:GetShoppingList(player, includeBank)
	local list = {}
	local playerList

	if player then
		playerList = { player }
	else
		playerList = {}

		for player,queue in pairs(self.db.server.reagentsInQueue) do
			table.insert(playerList, player)
		end
	end

--DebugSpam("shopping list for: "..(player or "all players"))

	for i=1,#playerList,1 do
		local player = playerList[i]
		local reagentsInQueue = self.db.server.reagentsInQueue[player]

--DebugSpam("player: "..player)

		if reagentsInQueue then
			for id,count in pairs(reagentsInQueue) do
--DebugSpam("reagent: "..id.." x "..count)

				local defecit = count

				local numInBags, _, numInBank = self:GetInventory(player, id)

				if player ~= self.currentPlayer then
					local numInBagsCurrent, _, numInBankCurrent = self:GetInventory(self.currentPlayer, id)

					if includeBank then
						defecit = defecit + numInBank + numInBankCurrent
					else
						defecit = defecit + numInBags + numInBagsCurrent
					end
				else
					if includeBank then
						defecit = defecit + numInBank
					else
						defecit = defecit + numInBags
					end
				end

				if defecit < 0 then
--					local _, link = GetItemInfo("item:"..id)


					if LSW and LSW.GetItemCost then
						local value, source = LSW:GetItemCost(id)
						local entry = { ["id"] = id, ["count"] = -defecit, ["player"] = player, ["value"] = (value or 0), ["source"] = source }

						table.insert(list, entry)
					else
						local entry = { ["id"] = id, ["count"] = -defecit, ["player"] = player, ["value"] = 0, ["source"] = "?" }

						table.insert(list, entry)
					end
				end
			end
		end
	end

	return list
end


local function cache_list(self)
	local name = nil
	if not Skillet.db.char.include_alts then
		name = UnitName("player")
	end
	self.cachedShoppingList = self:GetShoppingList(name)
end

-- Called when the bank frame is opened
function Skillet:BANKFRAME_OPENED()
	if event == "BANKFRAME_OPENED" then
		if not self.db.profile.display_shopping_list_at_bank then
			return
		end
	else
		if not self.db.profile.display_shopping_list_at_guildbank then
			return
		end
	end

	cache_list(self)
	if #self.cachedShoppingList == 0 then
		return
	end

	self:DisplayShoppingList(true) -- true -> at bank
end

-- Called when the bank frame is closed
function Skillet:BANKFRAME_CLOSED()
	self:HideShoppingList()
end

-- Called when the auction frame is opened
function Skillet:AUCTION_HOUSE_SHOW()
	if not self.db.profile.display_shopping_list_at_auction then
		return
	end

	cache_list(self)
	if #self.cachedShoppingList == 0 then
		return
	end

	self:DisplayShoppingList(false) -- false -> not at a bank
end

-- Called when the auction frame is closed
function Skillet:AUCTION_HOUSE_CLOSED()
	self:HideShoppingList()
end

local bank
local function indexBank()
	bank = {}

	local container = BANK_CONTAINER

	-- The main bank uses a bag ID of -1, just to make my life difficult.
	for i = 1, GetContainerNumSlots(container), 1 do
		local item = GetContainerItemLink(container, i)
		if item then
			local _,count = GetContainerItemInfo(container, i)
			table.insert(bank, {
				["bag"]   = container,
				["slot"]  = i,
				["id"]  = Skillet:GetItemIDFromLink(item),
				["count"] = count,
			})
		end
	end

	-- the bag that you can purchase in the bank are numbers 5 to 11
	for container = 5, 11, 1 do
		for i = 1, GetContainerNumSlots(container), 1 do
			local item = GetContainerItemLink(container, i)
			if item then
				local _,count = GetContainerItemInfo(container, i)
				table.insert(bank, {
					["bag"]   = container,
					["slot"]  = i,
					["id"]  = Skillet:GetItemIDFromLink(item),
					["count"] = count,
				})
			end
		end
	end
end

-- checks to see if this is a normal bag (not ammo, herb, enchanting, etc)
-- I borrowed this code from ClosetGnome.
local function isNormalBag(bagId)
	-- backpack and bank are always normal
	if bagId == 0 or bagId == -1 then return true end

	local link = GetInventoryItemLink("player", ContainerIDToInventoryID(bagId))
	if not link then return false end

	local id = Skillet:GetItemIDFromLink(link)
	if not id then return false end

	local bagType = select(7, GetItemInfo(id))
	-- INVTYPE_BAG is defined by Blizzard
	if bagType and bagType == INVTYPE_BAG then return true end

	return false
end

-- Returns a bag that the item can be placed in.
local function findBagForItem(itemID, count)
	if not itemID then return nil end

	local _, _, _, _, _, _, _, itemStackCount = GetItemInfo(itemID)
--	local id = Skillet:GetItemIDFromLink(item)

	for container = 0, 4, 1 do
		if isNormalBag(container) then
			local bag_size = GetContainerNumSlots(container) -- 0 if there is no bag
			for slot = 1, bag_size, 1 do
				local bagitem = GetContainerItemLink(container, slot)
				if bagitem then
					if id == Skillet:GetItemIDFromLink(bagitem) then
						-- found some of the same, it is a full stack or locked?
						local _, num_in_bag, locked  = GetContainerItemInfo(container, slot)
						local space_available = itemStackCount - num_in_bag
						if space_available >= count and not locked then
							return container
						end
					end
				else
					-- no item there, this looks like a good place to put something.
					return container
				end
			end
		end
	end

	return nil
end

local function getItemFromBank(itemID, bag, slot, count)
	ClearCursor()
	local _, available = GetContainerItemInfo(bag, slot)
	local link = GetContainerItemLink(bag, slot)
	local num_moved = 0

	if available == 1 or count >= available then
		PickupContainerItem(bag, slot)
		num_moved = available
	else
		SplitContainerItem(bag, slot, count)
		num_moved = count
	end

	local bag = findBagForItem(itemID, num_moved)

	if not bag then
		Skillet:Print(L["Could not find bag space for"] .. ": " .. link)
		return 0
	end

	if bag == 0 then
		PutItemInBackpack()
	else
		PutItemInBag(ContainerIDToInventoryID(bag))
	end

	return num_moved
end

-- Gets all the reagents possible for queued recipies from the bank
function Skillet:GetReagentsFromBank()
	local list = self.cachedShoppingList

	indexBank()

	for _,v in pairs(list) do
		local id = v.id
		for _,item in pairs(bank) do
			if item.id == id and item.count > 0 then
				-- taking stuff from the bank should cause a bag update event
				-- to be fired, which will in turn cause Skillet:UpdateShoppingListWindow()
				-- to be called. I hope.
				local moved = getItemFromBank(id, item.bag, item.slot, v.count)
				if moved > 0 then
					v.count = v.count - moved
				end
			end
		end
	end

	-- no need to keep the memory for bank items anymore
	bank = nil
end

function Skillet:ShoppingListToggleShowAlts()
	Skillet.db.char.include_alts = not Skillet.db.char.include_alts
end

local num_buttons = 0
local function get_button(i)
	local button = getglobal("SkilletShoppingListButton"..i)
	if not button then
		button = CreateFrame("Button", "SkilletShoppingListButton"..i, SkilletShoppingListParent, "SkilletShoppingListItemButtonTemplate")
		button:SetParent(SkilletShoppingList)
		button:SetPoint("TOPLEFT", "SkilletShoppingListButton"..(i-1), "BOTTOMLEFT")

	end

	if not button.valueText then
		button.valueText = button:CreateFontString(nil, nil, "GameFontNormal")

		button.valueText:SetPoint("LEFT",button,"RIGHT",0,0)
		button.valueText:SetText("00 00")
		button.valueText:SetWidth(60)
		button.valueText:SetHeight(button:GetHeight())
	end
	return button
end

-- Called to update the shopping list window
function Skillet:UpdateShoppingListWindow(use_cached_recipes)
	if not self.shoppingList or not self.shoppingList:IsVisible() then
		return
	end

	if not use_cached_recipes then
		cache_list(self)
	end

	local numItems = #self.cachedShoppingList

	if numItems == 0 then
		SkilletShoppingListRetrieveButton:Disable()
	else
		SkilletShoppingListRetrieveButton:Enable()
	end

	local button_count = SkilletShoppingListList:GetHeight() / SKILLET_SHOPPING_LIST_HEIGHT
	button_count = math.floor(button_count)

	-- Update the scroll frame
	FauxScrollFrame_Update(SkilletShoppingListList,         -- frame
						   numItems,                        -- num items
						   button_count,                    -- num to display
						   SKILLET_SHOPPING_LIST_HEIGHT)    -- value step (item height)

	-- Where in the list of items to start counting.
	local itemOffset = FauxScrollFrame_GetOffset(SkilletShoppingListList)

	local width = SkilletShoppingListList:GetWidth()
	local totalPrice = 0

	if LSW then
		width = width - 60
	end


	for i=1, button_count, 1 do
		num_buttons = math.max(num_buttons, i)

		local itemIndex = i + itemOffset

		local button = get_button(i)
		local count  = getglobal(button:GetName() .. "CountText")
		local name   = getglobal(button:GetName() .. "NameText")
		local player = getglobal(button:GetName() .. "PlayerText")

		button:SetWidth(width)

		local button_width = width - 5
		local count_width  = math.max(button_width * 0.1, 30)
		local player_width = math.max(button_width * 0.3, 100)
		local name_width   = math.max(button_width - count_width - player_width, 125)

		count:SetWidth(count_width)
		name:SetWidth(name_width)
		name:SetPoint("LEFT", count:GetName(), "RIGHT", 4)
		player:SetWidth(player_width)
		player:SetPoint("LEFT", name:GetName(), "RIGHT", 4)

		if itemIndex <= numItems then
			count:SetText(self.cachedShoppingList[itemIndex].count)
			name:SetText(GetItemInfo(self.cachedShoppingList[itemIndex].id) or id)
			player:SetText(self.cachedShoppingList[itemIndex].player)

			if LSW then
				button.valueText:SetText(LSW:FormatMoney(self.cachedShoppingList[itemIndex].value * self.cachedShoppingList[itemIndex].count, true)..self.cachedShoppingList[itemIndex].source)
				totalPrice = totalPrice + self.cachedShoppingList[itemIndex].value * self.cachedShoppingList[itemIndex].count
			end

			button.id  = self.cachedShoppingList[itemIndex].id
			button.count = self.cachedShoppingList[itemIndex].count

			button:Show()
			name:Show()
			count:Show()
			player:Show()
		else
			button.id = nil
			button:Hide()
			name:Hide()
			count:Hide()
			player:Hide()
		end
	end
--DEFAULT_CHAT_FRAME:AddMessage("total price for shopping list "..LSW_formatMoney(totalPrice, true))

	if LSW then
		local totalPriceReport = getglobal("SkilletShoppingListTotalPrice")

		if not totalPriceReport then
			totalPriceReport = SkilletShoppingList:CreateFontString("SkilletShoppingListTotalPrice",nil, "GameFontNormal")
			totalPriceReport:SetPoint("BOTTOMLEFT", SkilletShoppingList, "BOTTOMLEFT", 10, 10)

			totalPriceReport:SetText("shopping list cost: 00 00")
			totalPriceReport:SetWidth(200)
			totalPriceReport:SetHeight(20)
		end

		totalPriceReport:SetText("shopping list cost: "..LSW:FormatMoney(totalPrice,true))
	end
	-- Hide any of the buttons that we created, but don't need right now
	for i = button_count+1, num_buttons, 1 do
	   local button = get_button(i)
	   button:Hide()
	end
end

-- Called when the list of reagents is scrolled
function Skillet:ShoppingList_OnScroll()
	Skillet:UpdateShoppingListWindow(true) -- true == use the cached list of recipes
end

-- Fills out and displays the shopping list frame
function Skillet:internal_DisplayShoppingList(atBank)
DebugSpam("internal_DisplayShoppingList")
	if not self.shoppingList then
		self.shoppingList = createShoppingListFrame(self)
	end
	local frame = self.shoppingList

	if not atBank then
		SkilletShoppingListRetrieveButton:Hide()
	else
		SkilletShoppingListRetrieveButton:Show()
	end

	cache_list(self)

	if not frame:IsVisible() then
DebugSpam("wants to show shopping list")
--        ShowUIPanel(frame)
		frame:Show()
	end

	-- true == use cached recipes, we just loaded them after all
	self:UpdateShoppingListWindow(true)
DebugSpam("internal_DisplayShoppingList complete")
end

-- Hides the shopping list window
function Skillet:internal_HideShoppingList()
	if self.shoppingList then
--        HideUIPanel(self.shoppingList)
		self.shoppingList:Hide()
	end
	self.cachedShoppingList = nil
end

