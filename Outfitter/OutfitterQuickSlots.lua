Outfitter._QuickSlots = {}
Outfitter._QuickSlotButton = {}

Outfitter.cIgnoredQuickslotItems = 
{
	[2901] = "Mining Pick",
	[5956] = "Blacksmith hammer",
	[6219] = "Arclight Spanner",
	[7005] = "Skinning Knife",
}

function Outfitter.InitializeQuickSlots()
	local vName = "OutfitterQuickSlots"
	
	Outfitter.QuickSlots = CreateFrame("Frame", vName, PaperDollFrame)

	Outfitter.InitializeFrame(Outfitter.QuickSlots, Outfitter._ButtonBar, Outfitter._QuickSlots)
	Outfitter.QuickSlots:Construct(vName, 1, 1, Outfitter._QuickSlotButton, "OutfitterQuickSlotItemTemplate")
end

function Outfitter._QuickSlots:Construct(...)
	self:Hide()
	
	Outfitter._ButtonBar.Construct(self, ...)
	
	self:HookPaperDollFrame()
	self:EnableMouse(true)
	
	self:SetFrameStrata("DIALOG")
	--Outfitter.SetFrameLevel(self, PaperDollFrame:GetFrameLevel() + 10)
	
	self:SetScript("OnShow", function (self) self:OnShow() end)
	self:SetScript("OnHide", function (self) self:OnHide() end)
	
end

function Outfitter._QuickSlots:HookPaperDollFrame()
	for _, vSlotName in ipairs(Outfitter.cSlotNames) do
		local vSlotButton = getglobal("Character"..vSlotName)
		if vSlotButton then
			Outfitter:HookScript(vSlotButton, "PreClick", Outfitter.PaperDollItemSlotButton_PreClick)
			Outfitter:HookScript(vSlotButton, "PostClick", Outfitter.PaperDollItemSlotButton_PostClick)
			Outfitter:HookScript(vSlotButton, "OnDragStart", Outfitter.PaperDollItemSlotButton_OnDragStart)
			Outfitter:HookScript(vSlotButton, "OnDragStop", Outfitter.PaperDollItemSlotButton_OnDragStop)
			Outfitter:HookScript(vSlotButton, "OnEnter", Outfitter.PaperDollItemSlotButton_OnEnter)
			Outfitter:HookScript(vSlotButton, "OnLeave", Outfitter.PaperDollItemSlotButton_OnLeave)
		end
	end
end

function Outfitter._QuickSlots:Open(pSlotName, pHoveringOpen)
	local	vPaperDollSlotName = "Character"..pSlotName
	
	-- Hide the tooltip so that it isn't in the way
	
	GameTooltip:Hide()
	
	-- Position the window
	
	if pSlotName == "MainHandSlot"
	or pSlotName == "SecondaryHandSlot"
	or pSlotName == "RangedSlot"
	or pSlotName == "AmmoSlot" then
		self:SetPoint("TOPLEFT", vPaperDollSlotName, "BOTTOMLEFT", 0, 0)
	else
		self:SetPoint("TOPLEFT", vPaperDollSlotName, "TOPRIGHT", 5, 6)
	end
	
	self.SlotName = pSlotName
	
	-- Populate the items
	
	local vItems = Outfitter:FindItemsInBagsForSlot(pSlotName)
	local vNumButtons = 0
	local vEmptyBagSlotInfo
	
	if vItems then
		for vIndex, vItemInfo in ipairs(vItems) do
			if not Outfitter.cIgnoredQuickslotItems[vItemInfo.Code] then
				vNumButtons = vNumButtons + 1
			end
		end
	end
	
	if not Outfitter:InventorySlotIsEmpty(pSlotName) then
		vEmptyBagSlotInfo = Outfitter:GetEmptyBagSlot()
		
		if vEmptyBagSlotInfo then
			vNumButtons = vNumButtons + 1
		end
	end
	
	self:SetDimensions(vNumButtons, 1)
	
	if vItems then
		local vButtonIndex = 1
		
		for _, vItemInfo in ipairs(vItems) do
			if not Outfitter.cIgnoredQuickslotItems[vItemInfo.Code] then
				self:SetSlotToBag(vButtonIndex, vItemInfo.Location.BagIndex, vItemInfo.Location.BagSlotIndex)
				vButtonIndex = vButtonIndex + 1
			end
		end
	end
	
	if vEmptyBagSlotInfo then
		self:SetSlotToBag(vNumButtons, vEmptyBagSlotInfo.BagIndex, vEmptyBagSlotInfo.BagSlotIndex)
	end
	
	if vNumButtons == 0 then
		self:Hide()
	else
		self:Show()
		self.HoveringOpen = pHoveringOpen
	end
end

function Outfitter._QuickSlots:Close()
	self:Hide()
end

function Outfitter._QuickSlots:InventoryChanged(pOnlyAmmoChanged)
	if self.SlotName == "AmmoSlot"
	or pOnlyAmmoChanged then
		return
	end
	
	self:Close()
end
		
function Outfitter._QuickSlots:OnShow()
	Outfitter:BeginMenu(self)
	Outfitter.SetFrameLevel(self, PaperDollFrame:GetFrameLevel() + 10)
end

function Outfitter._QuickSlots:OnHide()
	Outfitter:EndMenu(self)
end

function Outfitter._QuickSlots:SetSlotToBag(pQuickSlotIndex, pBagIndex, pBagSlotIndex)
	local vButton = self:GetIndexedButton(pQuickSlotIndex)
	
	vButton:SetID(pBagIndex)
	vButton.ItemButton:SetID(pBagSlotIndex)
	
	ContainerFrame_Update(vButton)
end

function Outfitter.QuickSlotItem_OnShow(self)
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("BAG_UPDATE_COOLDOWN")
	self:RegisterEvent("ITEM_LOCK_CHANGED")
	self:RegisterEvent("UPDATE_INVENTORY_ALERTS")
end

function Outfitter.QuickSlotItem_OnHide(self)
	self:UnregisterEvent("BAG_UPDATE")
	self:UnregisterEvent("BAG_UPDATE_COOLDOWN")
	self:UnregisterEvent("ITEM_LOCK_CHANGED")
	self:UnregisterEvent("UPDATE_INVENTORY_ALERTS")
end

function Outfitter.QuickSlotItemButton_OnEnter(pButton)
	GameTooltip:SetOwner(pButton, "ANCHOR_RIGHT")
	
	local	vBagIndex = pButton:GetParent():GetID()
	local	vBagSlotIndex = pButton:GetID()
	
	local	vHasItem, vHasCooldown, vRepairCost
	
	if vBagIndex == -1 then
		vHasItem, vHasCooldown, vRepairCost = GameTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(vBagSlotIndex))
	else
		vHasCooldown, vRepairCost = GameTooltip:SetBagItem(vBagIndex, vBagSlotIndex)
	end
	
	if InRepairMode() and vRepairCost and vRepairCost > 0 then
		GameTooltip:AddLine(TEXT(REPAIR_COST), "", 1, 1, 1)
		SetTooltipMoney(GameTooltip, vRepairCost)
		GameTooltip:Show()
	elseif pButton.readable or (IsControlKeyDown() and pButton.hasItem) then
		ShowInspectCursor()
	elseif MerchantFrame:IsVisible() and MerchantFrame.selectedTab == 1 then
		ShowContainerSellCursor(pButton:GetParent():GetID(), pButton:GetID())
	else
		ResetCursor()
	end
	
	if IsModifiedClick("COMPAREITEMS") then
		GameTooltip_ShowCompareItem(nil, 1)
	end
end

function Outfitter:QuickSlotItemButton_OnUpdate()
end

----------------------------------------
-- Outfitter._QuickSlotButton
----------------------------------------

function Outfitter._QuickSlotButton:Construct()
	self.size = 1
	self.ItemButton = getglobal(self:GetName().."Item1")
	
	Outfitter.SetFrameLevel(self, Outfitter.QuickSlots:GetFrameLevel() + 1)
end

function Outfitter._QuickSlotButton:OnShow()
end

function Outfitter._QuickSlotButton:OnHide()
end

----------------------------------------
-- Outfitter.PaperDollItemSlotButton
----------------------------------------

function Outfitter.PaperDollItemSlotButton_PreClick(self, pButton, pDown)
	Outfitter.SchedulerLib:UnscheduleTask(Outfitter.PaperDollItemSlotButton_HoverOpen)
	Outfitter.SchedulerLib:UnscheduleTask(Outfitter.PaperDollItemSlotButton_HoverClose)
	
	Outfitter.QuickSlots.CurrentInventorySlot = Outfitter.cSlotIDToInventorySlot[self:GetID()]
	Outfitter.QuickSlots.CurrentSlotIsEmpty = GetInventoryItemLink("player", self:GetID()) == nil
end

function Outfitter.PaperDollItemSlotButton_PostClick(self, pButton, pDown)
	-- If there's an item on the cursor then open the slots otherwise
	-- make sure they're closed
	
	if (not Outfitter.QuickSlots:IsVisible() or Outfitter.QuickSlots.HoveringOpen)
	and (CursorHasItem() or Outfitter.QuickSlots.CurrentSlotIsEmpty) then
		-- Hide the tooltip so that it isn't in the way
		
		GameTooltip:Hide()
		
		-- Open QuickSlots
		
		Outfitter.QuickSlots:Open(Outfitter.QuickSlots.CurrentInventorySlot)
	else
		Outfitter.QuickSlots:Close()
	end
end

function Outfitter.PaperDollItemSlotButton_OnDragStart(self)
	Outfitter.SchedulerLib:UnscheduleTask(Outfitter.PaperDollItemSlotButton_HoverOpen)
	Outfitter.SchedulerLib:UnscheduleTask(Outfitter.PaperDollItemSlotButton_HoverClose)
	
	Outfitter.QuickSlots.CurrentInventorySlot = Outfitter.cSlotIDToInventorySlot[self:GetID()]
	Outfitter.QuickSlots.CurrentSlotIsEmpty = false
	
	-- Open the QuickSlots
	
	Outfitter.QuickSlots:Open(Outfitter.QuickSlots.CurrentInventorySlot)
end

function Outfitter.PaperDollItemSlotButton_OnDragStop(self)
	Outfitter.QuickSlots:Close()
end

function Outfitter.PaperDollItemSlotButton_OnEnter(self)
	if true then
		return
	end
	
	Outfitter:DebugMessage("OnEnter")
	
	local vInventorySlot = Outfitter.cSlotIDToInventorySlot[self:GetID()]
	
	Outfitter.SchedulerLib:UnscheduleTask(Outfitter.PaperDollItemSlotButton_HoverOpen)
	Outfitter.SchedulerLib:UnscheduleTask(Outfitter.PaperDollItemSlotButton_HoverClose)
	
	if Outfitter.QuickSlots:IsVisible() then
		if not Outfitter.QuickSlots.HoveringOpen
		or Outfitter.QuickSlots.CurrentInventorySlot == vInventorySlot then
			Outfitter:DebugMessage("OnEnter: Same slot, exiting")
			return
		end
		
		Outfitter:DebugMessage("OnEnter: Slot changed")
		Outfitter.QuickSlots:Close()
	end
	
	Outfitter:DebugMessage("OnEnter: Scheduling open")
	
	Outfitter.QuickSlots.CurrentInventorySlot = vInventorySlot
	Outfitter.QuickSlots.CurrentSlotIsEmpty = GetInventoryItemLink("player", self:GetID()) == nil
	Outfitter.QuickSlots.HoverItemSlotButton = self
	
	Outfitter.SchedulerLib:ScheduleUniqueTask(0.5, Outfitter.PaperDollItemSlotButton_HoverOpen)
end

function Outfitter.PaperDollItemSlotButton_OnLeave(self)
	Outfitter.SchedulerLib:UnscheduleTask(Outfitter.PaperDollItemSlotButton_HoverOpen)
	
	if Outfitter.QuickSlots.HoveringOpen then
		Outfitter:DebugMessage("OnLeave: Scheduling close")
		Outfitter.SchedulerLib:ScheduleUniqueTask(0.5, Outfitter.PaperDollItemSlotButton_HoverClose)
	end
end

function Outfitter.PaperDollItemSlotButton_HoverOpen()
	if Outfitter.QuickSlots:IsVisible() then
		return
	end
	
	Outfitter:DebugMessage("HoverOpen")
	
	Outfitter.QuickSlots:Open(Outfitter.QuickSlots.CurrentInventorySlot, true)
end

function Outfitter.PaperDollItemSlotButton_HoverClose(self)
	if Outfitter.CursorInFrame(Outfitter.QuickSlots.HoverItemSlotButton)
	or Outfitter.CursorInFrame(Outfitter.QuickSlots) then
		Outfitter.SchedulerLib:ScheduleUniqueTask(0.5, Outfitter.PaperDollItemSlotButton_HoverClose)
		return
	end
	
	Outfitter:DebugMessage("HoverClose")
	
	Outfitter.QuickSlots:Close()
end

Outfitter:RegisterOutfitEvent("OUTFITTER_INIT", function () Outfitter.InitializeQuickSlots() end)
