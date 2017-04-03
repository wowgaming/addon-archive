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
# Deals with building and maintaining a the email attach list. It makes use of the shopping list to
#  keep track of the mail flow. This method works for the most part, but there are issues. Need to 
#  convert it to have it's own Queue tracking log, over changing the shopping list directly.
#
]]--

SKILLET_ATTACH_LIST_HEIGHT = 18

local L = AceLibrary("AceLocale-2.2"):new("Skillet")

local ERROR_NOITEM = "ItemId is empty"
local ERROR_NOLOCAL = "Item is unknown"
local ERROR_NOBLANK = "No blank spaces available"
local ERROR_MAXSIZE = "Item cannot stack that big"
local ERROR_AHCLOSED = "AH is not open"
local ERROR_NOTFOUND = "Item was not found in inventory"
local ERROR_NOTENOUGH = "Not enough of item available"
local ERROR_FAILRETRY = "Failed too many times"
Skillet.Const = {
	ERROR_NOITEM = ERROR_NOITEM,
	ERROR_NOLOCAL = ERROR_NOLOCAL,
	ERROR_NOBLANK = ERROR_NOBLANK,
	ERROR_MAXSIZE = ERROR_MAXSIZE,
	ERROR_AHCLOSED = ERROR_AHCLOSED,
	ERROR_NOTFOUND = ERROR_NOTFOUND,
	ERROR_NOTENOUGH = ERROR_NOTENOUGH,
	ERROR_FAILRETRY = ERROR_FAILRETRY,
}
local attachRequests={}
local attachItemsMail={}
Skillet.AttachRequests=attachRequests
Skillet.AttachItemsMail  =attachItemsMail

local num_buttons = 0


-- ===========================================================================================
--      ReagentQueue Data functions
-- ===========================================================================================

--
-- Generates a table with the current Queued Items that alts have and returns the list
-- @return	 list[  ]  {id, count, numInBags, player)
--
local entry={}
function Skillet:GetAttachLists(player, includeBank)
	local list = {}
	local playerList = {}
	local CurPlayer=UnitName("player")
	for player,queue in pairs(self.db.server.reagentsInQueue) do
		if player~=CurPlayer then
			table.insert(playerList, player)
			DebugSpam(player)
		end
	end
	
	
	for i=1,#playerList,1 do
		local player = playerList[i]
		local reagentsInQueue = self.db.server.reagentsInQueue[player]
		if reagentsInQueue then

			for id,count in pairs(reagentsInQueue) do
				local numInBags, _, numInBank = self:GetInventory(CurPlayer, id)
				local numAltInBags, _, numAltInBank = self:GetInventory(player, id)
				local deficit=-(count+numAltInBank)
				if numInBags>0 and deficit>0 then
					
					entry={["id"]=id,["count"] = deficit, ["numInBags"] = numInBags or 0,["player"]=player}
					table.insert(list, entry)
				end
			end
		end
	end
	
	
	return list
end

-- Creates the cached list of Queued Items

local function cache_list(self)
	local name = nil
	self.cachedAttachList = self:GetAttachLists()
end

-- ===========================================================================================
--      Inventory Data  and Management functions
-- ===========================================================================================

-- Used for timing
Skillet.moveWait = {}

local function findBagForItem(mItemId)

--Stolen from Auctioneer
	local matches = {}
	local blankBag, blankSlot
	local specialBlank = false
	local isLocked = true
	local foundLink
	local total = 0
	
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag,slot)
				if link then
					local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag,slot)
					if (locked) then
						isLocked = true
					end
					local itemID = Skillet:GetItemIDFromLink(link)
					if mItemId==itemID then
						if not itemCount or itemCount < 0 then itemCount = 1 end
						table.insert(matches, {bag or -1, slot or -1, itemCount or -1})
						total = total + itemCount
						foundLink = link
					end
				else
				if not blankBag then
							blankBag = bag
							blankSlot = slot
				end
			end
		end
		
	end

	return matches, total, blankBag, blankSlot, foundLink, isLocked
end


-- 
-- Used to search your bags for an Item. 
-- It's idea is to find the item of a certain size, and returns the bag and slot location of said itemid
-- Size cannot be bigger than the MaxStackSize. It is needed to call multiple times with a pcall function
-- and prefrably in a timer.
-- Code mainly from auctioneer

function Skillet.useItemInBag(SearchItemID,size)
	if Skillet.moveWait[1] then
		local bag, slot, prev, wait = unpack(Skillet.moveWait)
		if GetTime() < wait then
			local _, count = GetContainerItemInfo(bag,slot)
			if count == prev then
				return 
			end
		end
		Skillet.moveWait[1] = nil
	end
	local _,link,_,_,_,_,_, maxSize = GetItemInfo(SearchItemID)
	if size > maxSize then
		return error(ERROR_MAXSIZE)
	end
	
	local matches, total, blankBag, blankSlot = findBagForItem(SearchItemID)
	
	if #matches == 0 then
		return error(ERROR_NOTFOUND)
	end
	
	if total < size then
	    return error(ERROR_NOTENOUGH)
	end
	
	for i=1, #matches do
		local match = matches[i]
		if match[3] == size then
			return match[1], match[2]
		end
	end
	
		-- We will have to wait for the current process to complete
	if (CursorHasItem() or SpellIsTargeting()) then
		return 
	end
	
	table.sort(matches, function (a,b) return a[3] < b[3] end)
	if (matches[1][3] > size) then
		-- Our smallest stack is bigger than what we need
		-- We will need to split it
		if not blankBag then
			-- Dang, no slots to split stuff into
			return error(ERROR_NOBLANK)
		end

		SplitContainerItem(matches[1][1], matches[1][2], size)
		PickupContainerItem(blankBag, blankSlot)
	elseif (matches[1][3] + matches[2][3] > size) then
		-- The smallest stack + next smallest is > than our needs, do a partial combine
		SplitContainerItem(matches[2][1], matches[2][2], size - matches[1][3])
		PickupContainerItem(matches[1][1], matches[1][2])
	else
		-- Combine the 2 smallest stacks
		PickupContainerItem(matches[1][1], matches[1][2])
		PickupContainerItem(matches[2][1], matches[2][2])
	end
	
	Skillet.moveWait[1] = matches[1][1]
	Skillet.moveWait[2] = matches[1][2]
	Skillet.moveWait[3] = matches[1][3]
	Skillet.moveWait[4] = GetTime() + 5
end	

-- ===========================================================================================
--    Window creation and update methods
-- ===========================================================================================
local function get_button(i)
	local button = getglobal("SkilletAttachListButton"..i)
	if not button then
		button = CreateFrame("Button", "SkilletAttachListButton"..i, SkilletAttachListParent, "SkilletAttachListItemButtonTemplate")
		button:SetParent(SkilletAttachListParent)
		button:SetPoint("TOPLEFT", "SkilletAttachListButton"..(i-1), "BOTTOMLEFT")
		button:SetFrameLevel(SkilletAttachListParent:GetFrameLevel() + 1)
	end
	return button
end

-- Stolen from the Waterfall Ace2 addon.  Used for the backdrop of the scrollframe
local ControlBackdrop  = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

-- Additional things to used to modify the XML created frame
function createAttachListFrame (self)
	DebugSpam("createAttachListFrame")
	local frame = Skillet_AttachListMain
	if not frame then
		return nil
	end
	
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
	titletext:SetText("Skillet: Auto Mails")
	--return frame
	
	-- The frame enclosing the scroll list needs a border and a background .....
	local backdrop = SkilletAttachListParent
	backdrop:SetBackdrop(ControlBackdrop)
	backdrop:SetBackdropBorderColor(0.6, 0.6, 0.6)
	backdrop:SetBackdropColor(0.05, 0.05, 0.05)
	backdrop:SetResizable(true)
	
	local windowManger = AceLibrary("Window-1.0")
	local AttachListLocation = {
		prefix = "AttachListLocation_"
	}
	windowManger:RegisterConfig(frame, self.db.char, AttachListLocation)
	windowManger:RestorePosition(frame)  -- restores scale also
	windowManger:MakeDraggable(frame)
	

	-- lets play the resize me game!
	Skillet:EnableResize(frame, 180,150, Skillet.UpdateAttachListWindow)
	
	return frame
end

-- Called to update the attach list window
--@param  recache_recipes  True forces a recache of the recipes
--@param  reenable   Enable all disabled buttons
--
function Skillet:UpdateAttachListWindow(recache_recipes,reenable)
	
	DebugSpam("UpdateAttachListWindow")
	
	if recache_recipes or not self.cachedAttachList then
		DebugSpam("Generate Cache List")
		cache_list(self)
	end
	
	local numItems = #self.cachedAttachList
    
	if SkilletAttachMailButton:IsVisible() then
		DebugSpam("Update Button")
		SkilletAttachMailButton:SetText(numItems)
		
	end 


	if not self.attachList or not self.attachList:IsVisible() then
	    DebugSpam("No attachList not visible so return")
		return
	end

	
	
	local button_count = SkilletAttachListList:GetHeight() / SKILLET_ATTACH_LIST_HEIGHT
	button_count = math.floor(button_count)

	-- Update the scroll frame
	FauxScrollFrame_Update(SkilletAttachListList,         -- frame
						   numItems,                        -- num items
						   button_count,                    -- num to display
						   SKILLET_SHOPPING_LIST_HEIGHT)    -- value step (item height)

	-- Where in the list of items to start counting.
	local itemOffset = FauxScrollFrame_GetOffset(SkilletAttachListList,reenable)

	local width = SkilletAttachListParent:GetWidth()

	for i=1, button_count, 1 do
		num_buttons = math.max(num_buttons, i)

		local itemIndex = i + itemOffset

		local button = get_button(i)
		local player = getglobal(button:GetName() .. "Player")
		local playerText = getglobal(button:GetName() .. "PlayerText")
		local pname = getglobal(button:GetName() .. "Name")
		local pnameText = getglobal(button:GetName() .. "NameText")
		local attachButton = getglobal(button:GetName() .. "AttachButton")
		button:SetWidth(width)

		
		local fixed_width = attachButton:GetWidth()
		fixed_width = width - fixed_width - 20 -- 10 for the padding between items

		player:SetWidth(fixed_width * 0.3-10) 
		playerText:SetWidth(fixed_width * 0.3-10)
		pname:SetWidth(fixed_width * 0.7-10) 
		pnameText:SetWidth(fixed_width * 0.7-10) 
		

		if itemIndex <= numItems then
			attachButton:SetID(itemIndex)
		
			playerText:SetText(self.cachedAttachList[itemIndex]["player"])
			pnameText:SetText(self.cachedAttachList[itemIndex]["numInBags"].."/"..self.cachedAttachList[itemIndex]["count"].." : "..(GetItemInfo(self.cachedAttachList[itemIndex]["id"]) or id))
	
			button.id=itemIndex
			
			if (reenable) then
				attachButton:Enable()
			end
			button:Show()
			player:Show()
			pname:Show()
			attachButton:Show()
		else
			button.id = nil
			button:Hide()
			player:Hide()
			attachButton:Hide()
			
		end
	end


	-- Hide any of the buttons that we created, but don't need right now
	for i = button_count+1, num_buttons, 1 do
	   local button = get_button(i)
	   button:Hide()
	end
end

--
-- Internal functions to show and hide the Attachlist
-- Calling functions can be found in ThirdPartyHooks.lua
--

function Skillet:internal_DisplayAttachList()
	DebugSpam("internal_DisplayAttachList")

	if not self.attachList then
		self.attachList = createAttachListFrame(self)
	end
	local frame = self.attachList

	cache_list(self)

	if not frame:IsVisible() then
		DebugSpam("wants to show Attach list")
    	frame:Show()
	end

	-- false == use cached recipes, we just loaded them after all
	-- true == re-enable the disabled buttons
	self:UpdateAttachListWindow(false,true)
	DebugSpam("internal_DisplayAttachList complete")
end

-- Hides the shopping list window
function Skillet:internal_HideAttachList()
	if self.attachList then
		self.attachList:Hide()
	end
	self.cachedAttachList = nil
end

--
-- Causes the button on the mail frame to toggle between showing and hiding
--
function Skillet:ToggleMailAttachVisible() 
	if not self.attachList or not self.attachList:IsVisible() then
		self:DisplayAttachList()
	else
		self:HideAttachList()
	end
end

--
-- Updates the scrollbar when a scroll event happens
--
function Skillet:AttachList_OnScroll()
	Skillet:UpdateAttachListWindow(false,false) -- false == use the cached list of recipes
end

--
-- Attaches Items to a mail for you when the attach button is clicked
-- It mainly works by putting items in a Processing Queue, which is then Processed on a timer
-- The reason for this is that we need to get correct stack sizes, and with Blizzes servers don't like doing it all in one go.
-- @param   AttachID   Which button was clicked
function Skillet:AttachItems (AttachID)
	
	if not SendMailFrame:IsVisible() then
		MailFrameTab_OnClick(2)
	end
	
	if  (SendMailNameEditBox:GetText()=="") then
		SendMailNameEditBox:SetText(self.cachedAttachList[AttachID]["player"])
	end
	
	--checks to make sure that your attaching the email to the right alt   
	if  (SendMailNameEditBox:GetText()~=self.cachedAttachList[AttachID]["player"]) then
		message("This needs to be sent to "..self.cachedAttachList[AttachID]["player"])
		return
	end
	
	if (SendMailSubjectEditBox:GetText()=="") then
		SendMailSubjectEditBox:SetText("Skillet: Shoppinglist items")
	end
	
	local amount=0
	if self.cachedAttachList[AttachID]["numInBags"] > self.cachedAttachList[AttachID]["count"] then
		amount=self.cachedAttachList[AttachID]["count"]
	else
	   amount=self.cachedAttachList[AttachID]["numInBags"]
	end
	local itemid=self.cachedAttachList[AttachID]["id"]
	local size=5
	
	
	local _,link,_,_,_,_,_, maxSize = GetItemInfo(itemid)
	local matches, total, blankBag, blankSlot = findBagForItem(itemid)

	-- Creates the amount of stacks that need to be attached to the mail.
	local majorstacks=math.floor(amount/maxSize)
	local minorstacks=(amount % maxSize)
	
	--Add Items to the queue
	--First the Major Stacks, size=maxSize. 1 Process Queue per stack
	local size=maxSize
	local postIds={}
	for i=1,majorstacks,1 do
		local postId = (Skillet.lastPostId or 0) + 1
		Skillet.lastPostId = postId
		table.insert(Skillet.AttachRequests, { [0]=postId, itemid, size})
		table.insert(postIds, postId)
	end
	
	-- Add the remainder of items
	size=minorstacks
	if (size>0) then
		local postId = (Skillet.lastPostId or 0) + 1
		Skillet.lastPostId = postId
		table.insert(Skillet.AttachRequests, { [0]=postId, itemid, size})
		table.insert(postIds, postId)
	end
	Skillet.AttachTimer=-1
	
	local button=getglobal("SkilletAttachListButton"..AttachID.."AttachButton")
	--Disable the button
	--pplocal button = get_button(AttachID)
	button:Disable()
end





-- ===========================================================================================
--      ProcessQueue and Timer functions
-- ===========================================================================================


-- Start timer and timer delay 
Skillet.AttachTimer=-5
Skillet.AttachTimer_Delay=0.1

--
-- Runs through all the items that have been added to the process queue.
-- If there are any it restacks your bags if needed and then attaches the final item to the open mail
-- Uses a simple push/pop queue (FIFO)
-- Code mainly from Auctioneer

local function processQueue()
	if #Skillet.AttachRequests <=0 then
		Skillet.AttachTimer=-5
		return
	end
	
	local request=Skillet.AttachRequests[1]
	
	itemid=request[1]
	size=request[2]
	
	-- Sees if there's an items of the correct size else it restacks it
	
	local success, bag, slot = pcall(Skillet.useItemInBag,itemid,size)
	-- If the last action was not nat succesful, check if error, else return so that it can process again
	if not success then
		local err = bag:match(": (.*)")
				-- Remove the item from the queue if there was an error
				if err == ERROR_NOITEM         -- ItemId is empty
				or err == ERROR_NOLOCAL        -- Item is unknown
				or err == ERROR_NOBLANK        -- No blank spaces available
				or err == ERROR_MAXSIZE        -- Item cannot stack that big
				or err == ERROR_AHCLOSED       -- AH is not open
				or err == ERROR_NOTFOUND       -- Item was not found in inventory
				or err == ERROR_NOTENOUGH then -- Not enough of item available
					DebugSpam("Aborting request: {{"..err.."}} "..#Skillet.AttachRequests)
					message(err)
					table.remove(Skillet.AttachRequests, 1)
					Skillet.AttachTimer=-0.5
				else
					Skillet.AttachTimer=-1
				end
				return
	end
			
	if (CursorHasItem() or SpellIsTargeting()) then return end
	
	-- There was success, so we can now move attach the item 
	if slot and slot>0 then
		DebugSpam("Slot")
		
		-- Allow for lag, so that we can try to attach the item a bit later
		local _,_, lag = GetNetStats()
		lag = 2.5 * lag / 1000
		
		if (request[3]) then
		  if GetTime() > request[3] then
		    DebugSpam("LAG")
			return
		  end
		end
		local expire = GetTime() + lag
		Skillet.AttachRequests[1][3] = expire 
	
		local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag,slot)
		if not locked then
			Skillet.AttachTimer=-1
			UseContainerItem(bag,slot)
			-- Success, the Item has been attached, so we can remove the item from the queue
			table.remove(Skillet.AttachRequests, 1)
		end 
	end
	Skillet.AttachTimer=-1
end



-- A simple timer that runs on each OnUpdate
function Skillet:AttachOnUpdate()
	Skillet.AttachTimer=Skillet.AttachTimer+Skillet.AttachTimer_Delay
	if (Skillet.AttachTimer>0) then
	    Skillet.AttachTimer=-1
		processQueue()
	end
end

-- ===========================================================================================
--      OnEvent functions 
-- ===========================================================================================

-- Called when the mail frame is opened
function Skillet:MAIL_SHOW()
	 
    local attachList=self:GetAttachLists();

	cache_list(self)
	
	local numItems = #self.cachedAttachList
	if numItems>0 then
		self:DisplayAttachList()
	end
	

	return
end
--
-- Called when mails are sent successfully. 
-- It's main function is to re-update the Queues with any items that might have been sent to an alt
--
function Skillet:MAIL_SEND_SUCCESS()
	DebugSpam("Mail Success")
	--remove the items that where sent from the Reagents Queue
	local AttachedItems=#Skillet.AttachItemsMail
	DebugSpam(AttachedItems)
	
	-- Run through the items that were attached, and adjust the queue if needed
	for i=1,AttachedItems,1 do
		local id,player,count = unpack (Skillet.AttachItemsMail[i])
		local reagentsInQueue = self.db.server.reagentsInQueue[player]
		if reagentsInQueue[id] then
			--Adjust the Invetories... for now, I'm going to just adjust it as if those items belong to the person it was sent to (As if it's in his bags)
			--The only problem is that, if that other Char logs in, and doesn't remove the items from the mailbox, a rescan will just incorrectly re-adjust the numbers again.
			-- Correct way would be to monitor what's going on in the Mailbox, and keep track of it - then  use those figures as well.
							
			--Adjust for Alt char
			local numAltInBags, _, numAltInBank = self:GetInventory(player, id)
			Skillet:SetInventory(player, id, numAltInBags+count, numAltInBank+count)
			
		end
	 end
	 
	 -- Update the listbox if there were any items attached in the mail
	 if AttachedItems>0 then
		self:UpdateAttachListWindow(false,true)
		Skillet.AttachItemsMail={}
	end
end
--
-- Called when any items are being attached or removed to an email
-- Used to build an attachlist
--
function Skillet:MAIL_SEND_INFO_UPDATE()
	--Need to check which items a person is attaching and to whom it's being sent.
	-- If it's sent to an alt with items in the queue then the queue needs to be updated on a succesful send
	local playername=""
	local CurPlayer=UnitName("player")
	local found=false
	local mailPlayer=string.gsub(SendMailNameEditBox:GetText()," ","")
	
	-- Checks if the current recipient of the email is in the Queue
	for player,queue in pairs(self.db.server.reagentsInQueue) do
		if player~=CurPlayer then
			if  (mailPlayer:upper()==player:upper()) then
				DebugSpam("Found Player in Q")
				found=true
				playername=player
				break
			end
		end
	end

	if not found then return end
	
	-- Build attach list - only if a player is in the current queue will the items be added
	-- I just cleared the list, and build in from scratch each time an item is added
	Skillet.AttachItemsMail={}
    
	for i=1,12,1 do
		Name, Texture, Count, Quality = GetSendMailItem(i)
		if Name then
		local _, link, _, _, _, _, _, _ = GetItemInfo(Name)
		local id = Skillet:GetItemIDFromLink(link)
		local entry={id,playername,Count}
		table.insert(Skillet.AttachItemsMail, entry)
		DebugSpam(i.." "..Name.." "..id.." "..playername)
		
		if self.db.server.reagentsInQueue[playername][id] then
			DebugSpam(self.db.server.reagentsInQueue[playername][id])
		end
		end
	end
	
end
--
-- Called when the bank frame is closed
--
function Skillet:MAIL_CLOSED()
	--Need to rebuild the Reagent Queue after all that mail handling
	-- under some conditions recipeList doesn't exist, and needs to be reinitialized.
	if not self.data.recipeList then
		self.data.recipeList = {}
	end
	
	--DebugSpam("Rescaning Reagents"..self.currentPlayer)
	Skillet:ScanQueuedReagents()
	
	--Clear and hide all unused items
	Skillet.AttachItemsMail={}
	Skillet.AttachRequests={}
	self:HideAttachList()
	DebugSpam("close Mail")
end


self:RegisterEvent("MAIL_SHOW")
    self:RegisterEvent("MAIL_CLOSED")
	self:RegisterEvent("MAIL_SEND_SUCCESS")
	self:RegisterEvent("MAIL_SEND_INFO_UPDATE")





