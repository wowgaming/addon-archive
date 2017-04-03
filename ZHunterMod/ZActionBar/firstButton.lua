local function savePosition(self)
	local x, y = self:GetCenter()
	x = floor(x)
	y = floor(y)
	self:ClearAllPoints()
	self:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y)
	local frame = getglobal(self:GetParent():GetName():sub(1, -7))
	local saved = getglobal(frame.savedName)[frame.name]
	saved.x, saved.y = x, y
end

local function onMouseUp(self)
	if self.isMoving then
		self:StopMovingOrSizing()
		self.isMoving = false
		savePosition(self)
	end
end

local function onDragStart(self)
	if IsAltKeyDown() then
		self:StartMoving()
		self.isMoving = true
	end
end

local function onDragStop(self)
	self:StopMovingOrSizing()
	self.isMoving = false
	savePosition(self)
end

function ZActionBar_SetupFirstButton(button)
	local saved = getglobal(button.parent.savedName)[button.parent.name]
	button:SetClampedToScreen(true)


	button:ClearAllPoints()
	button:SetPoint("CENTER", UIParent, "BOTTOMLEFT", saved.x, saved.y)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:SetMovable(true)
	button:RegisterForDrag("LeftButton")
	button:SetScript("OnMouseUp", onMouseUp)
	button:SetScript("OnDragStart", onDragStart)
	button:SetScript("OnDragStop", onDragStop)
end