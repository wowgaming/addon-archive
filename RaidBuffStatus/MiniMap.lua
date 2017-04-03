-- RBS Minimap Button
-- Based on the Bongos minimap button

local RBSMinimapButton = CreateFrame('Button', 'RBSMinimapButton', Minimap)

function RBSMinimapButton:Load()
	self:SetWidth(31); self:SetHeight(31)
	self:SetFrameLevel(8)
	self:RegisterForClicks('anyUp')
	self:RegisterForDrag('LeftButton')
	self:SetHighlightTexture('Interface/Minimap/UI-Minimap-ZoomButton-Highlight')

	local overlay = self:CreateTexture(nil, 'OVERLAY')
	overlay:SetWidth(53); overlay:SetHeight(53)
	overlay:SetTexture('Interface/Minimap/MiniMap-TrackingBorder')
	overlay:SetPoint('TOPLEFT')

	local icon = self:CreateTexture(nil, 'BACKGROUND')
	icon:SetWidth(20); icon:SetHeight(20)
	icon:SetTexture('Interface/Icons/Ability_Hunter_MasterMarksman')
	icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	icon:SetPoint('TOPLEFT', 7, -5)
	self.icon = icon
	self:SetScript('OnDragStart', self.OnDragStart)
	self:SetScript('OnDragStop', self.OnDragStop)
	self:SetScript('OnMouseDown', self.OnMouseDown)
	self:SetScript('OnMouseUp', self.OnMouseUp)
	self:SetScript('OnEnter', self.OnEnter)
	self:SetScript('OnLeave', self.OnLeave)
	self:SetScript('OnClick', self.OnClick)
	self:Show()
	-- For Titan etc
	LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("RaidBuffStatus", {
		type = "launcher",
		text = "RaidBuffStatus",
		icon = "Interface/Icons/Ability_Hunter_MasterMarksman",
		OnTooltipShow = function(tooltip)
			RBSMinimapButton:OnTooltipShow(tooltip)
		end,
		OnClick = RBSMinimapButton.OnClick,
	})
end



function RBSMinimapButton:OnClick(button)
	if button == 'LeftButton' then
		if RaidBuffStatus.frame then
			if RaidBuffStatus.frame:IsVisible() then
				RaidBuffStatus:HideReportFrame()
			else
				RaidBuffStatus:DoReport()
				RaidBuffStatus:ShowReportFrame()
			end
		end
	elseif button == 'RightButton' then
		RaidBuffStatus:OpenBlizzAddonOptions()
	end
end




function RBSMinimapButton:OnEnter()
	if not self.dragging then
		GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMRIGHT')
		RBSMinimapButton:OnTooltipShow(GameTooltip)
		GameTooltip:Show()
	end
end

function RBSMinimapButton:OnTooltipShow(tooltip)
	tooltip:AddLine(RaidBuffStatus.L["Click to toggle the RBS dashboard"])
	tooltip:AddLine(RaidBuffStatus.L["Right-click to open the addons options menu"])
end

function RBSMinimapButton:OnLeave()
	GameTooltip:Hide()
end

function RBSMinimapButton:OnMouseDown()
	self.icon:SetTexCoord(0, 1, 0, 1)
end

function RBSMinimapButton:OnMouseUp()
	self.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
end

function RBSMinimapButton:OnDragStart()
	self.dragging = true
	self:LockHighlight()
	self.icon:SetTexCoord(0, 1, 0, 1)
	self:SetScript('OnUpdate', self.OnUpdate)
	GameTooltip:Hide()
end

function RBSMinimapButton:OnDragStop()
	self.dragging = nil
	self:SetScript('OnUpdate', nil)
	self.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	self:UnlockHighlight()
end


function RBSMinimapButton:OnUpdate()
	local mx, my = Minimap:GetCenter()
	local px, py = GetCursorPosition()
	local scale = Minimap:GetEffectiveScale()
	px, py = px / scale, py / scale
	RaidBuffStatus.db.profile.MiniMapAngle = math.deg(math.atan2(py - my, px - mx)) % 360
	self:UpdatePosition()
end


function RBSMinimapButton:UpdatePosition()
	local angle = math.rad(RaidBuffStatus.db.profile.MiniMapAngle)
	local cos = math.cos(angle)
	local sin = math.sin(angle)
	local minimapShape = GetMinimapShape and GetMinimapShape() or 'ROUND'

	local round = false
	if minimapShape == 'ROUND' then
		round = true
	elseif minimapShape == 'SQUARE' then
		round = false
	elseif minimapShape == 'CORNER-TOPRIGHT' then
		round = not(cos < 0 or sin < 0)
	elseif minimapShape == 'CORNER-TOPLEFT' then
		round = not(cos > 0 or sin < 0)
	elseif minimapShape == 'CORNER-BOTTOMRIGHT' then
		round = not(cos < 0 or sin > 0)
	elseif minimapShape == 'CORNER-BOTTOMLEFT' then
		round = not(cos > 0 or sin > 0)
	elseif minimapShape == 'SIDE-LEFT' then
		round = cos <= 0
	elseif minimapShape == 'SIDE-RIGHT' then
		round = cos >= 0
	elseif minimapShape == 'SIDE-TOP' then
		round = sin <= 0
	elseif minimapShape == 'SIDE-BOTTOM' then
		round = sin >= 0
	elseif minimapShape == 'TRICORNER-TOPRIGHT' then
		round = not(cos < 0 and sin > 0)
	elseif minimapShape == 'TRICORNER-TOPLEFT' then
		round = not(cos > 0 and sin > 0)
	elseif minimapShape == 'TRICORNER-BOTTOMRIGHT' then
		round = not(cos < 0 and sin < 0)
	elseif minimapShape == 'TRICORNER-BOTTOMLEFT' then
		round = not(cos > 0 and sin < 0)
	end

	local x, y
	if round then
		x = cos*80
		y = sin*80
	else
		x = math.max(-82, math.min(110*cos, 84))
		y = math.max(-86, math.min(110*sin, 82))
	end

	self:SetPoint('CENTER', x, y)
end

RBSMinimapButton:Load()
