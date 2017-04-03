local _G = getfenv(0)

function XLoot:TooltipCreate()
	local tt = CreateFrame("GameTooltip", "XLootTooltip", UIParent, "GameTooltipTemplate")
	self.tooltip = tt
end

function XLoot:GetBindOn(item)
	if not self.tooltip then self:TooltipCreate() end
	local tt = self.tooltip
	tt:SetOwner(UIParent, "ANCHOR_NONE")
	tt:SetHyperlink(item)
	if XLootTooltip:NumLines() > 1  and XLootTooltipTextLeft2:GetText() then
		local t = XLootTooltipTextLeft2:GetText()
		tt:Hide()
		if t == ITEM_BIND_ON_PICKUP then
			return "pickup"
		elseif t == ITEM_BIND_ON_EQUIP then
			return "equip"
		elseif t == ITEM_BIND_ON_USE then
			return "use"
		end
	end
	tt:Hide()
	return nil
end