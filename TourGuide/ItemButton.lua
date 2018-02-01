
local TourGuide = TourGuide
local texture, item


local frame = CreateFrame("Button", "TourGuideItemFrame", UIParent, "SecureActionButtonTemplate")
frame:SetFrameStrata("LOW")
frame:SetHeight(36)
frame:SetWidth(36)
frame:SetPoint("BOTTOMRIGHT", MinimapCluster, "BOTTOMRIGHT", -192-62, -192+20)
frame:Hide()

local cooldown = CreateFrame("Cooldown", nil, frame)
cooldown:SetAllPoints(frame)
cooldown:Hide()

local function RefreshCooldown()
	if not item or not frame:IsVisible() then return end
	local start, duration, enabled = GetItemCooldown(item)
	if enabled then
		cooldown:Show()
		cooldown:SetCooldown(start, duration)
	else cooldown:Hide() end
end
cooldown:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
cooldown:SetScript("OnEvent", RefreshCooldown)
frame:SetScript("OnShow", RefreshCooldown)


local itemicon = frame:CreateTexture(nil, "ARTWORK")
itemicon:SetWidth(24) itemicon:SetHeight(24)
itemicon:SetTexture("Interface\\Icons\\INV_Misc_Bag_08")
itemicon:SetAllPoints(frame)


frame:RegisterForClicks("anyUp")
frame:HookScript("OnClick", function() if TourGuide:GetObjectiveInfo() == "USE" then TourGuide:SetTurnedIn() end end)


local function PLAYER_REGEN_ENABLED(self)
	if texture then
		itemicon:SetTexture(texture)
		frame:SetAttribute("type1", "item")
		frame:SetAttribute("item1", "item:"..item)
		frame:Show()
		texture = nil

		local macroid = GetMacroIndexByName("TourGuide")
		if macroid then EditMacro(macroid, name, 1, "#showtooltip\n/use item:"..item, 1) end

	else
		frame:SetAttribute("item1", nil)
		frame:Hide()
	end
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
end
frame:SetScript("OnEvent", PLAYER_REGEN_ENABLED)


function TourGuide:SetUseItem(useitem)
	item, texture = useitem, useitem and GetItemIcon(useitem)
	if InCombatLockdown() then frame:RegisterEvent("PLAYER_REGEN_ENABLED") else PLAYER_REGEN_ENABLED(frame) end
end


frame:RegisterForDrag("LeftButton")
frame:SetMovable(true)
frame:SetClampedToScreen(true)
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", function(frame)
	frame:StopMovingOrSizing()
	TourGuide.db.profile.itemframepoint, TourGuide.db.profile.itemframex, TourGuide.db.profile.itemframey = TourGuide.GetUIParentAnchor(frame)
	TourGuide:Debug(1, "Item frame moved", TourGuide.db.profile.itemframepoint, TourGuide.db.profile.itemframex, TourGuide.db.profile.itemframey)
end)


function TourGuide:PositionItemFrame()
	frame:ClearAllPoints()
	local pt, x, y = self.db.profile.itemframepoint, self.db.profile.itemframex, self.db.profile.itemframey
	frame:SetPoint(pt or "BOTTOMRIGHT", pt and UIParent or MinimapCluster, pt or "BOTTOMRIGHT", x or -254, y or -172)
end
