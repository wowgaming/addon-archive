
local fraction, range, value, barsize
local function UpdateBar(self)
	range = self.MaxVal - self.MinVal 
	value = self.Value - self.MinVal
	barsize = self.Dim or 1

	if range > 0 and value > 0 and range >= value then
		fraction = value / range
	else fraction = .01 end

	if self.Orientation == "VERTICAL" then 
		self.Bar:SetHeight(barsize * fraction)
		self.Bar:SetTexCoord(0, 1, 1-fraction, 1)
	else 
		self.Bar:SetWidth(barsize * fraction) 
		self.Bar:SetTexCoord(0, fraction, 0, 1)
	end

end

local function UpdateSize(self)
	if self.Orientation == "VERTICAL" then self.Dim = self:GetHeight()
	else self.Dim = self:GetWidth() end
	UpdateBar(self)
end

local function SetValue(self, value) 
	if value >= self.MinVal and value <= self.MaxVal then self.Value = value end; 
	UpdateBar(self) 
end
	
local function SetStatusBarTexture(self, texture) self.Bar:SetTexture(texture) end
local function SetStatusBarColor(self, r, g, b, a) self.Bar:SetVertexColor(r,g,b,a) end

local function SetOrientation(self, orientation) 
	if orientation == "VERTICAL" then
		self.Orientation = orientation
		self.Bar:ClearAllPoints()
		self.Bar:SetPoint("BOTTOMLEFT")
		self.Bar:SetPoint("BOTTOMRIGHT")
	else
		self.Orientation = "HORIZONTAL"
		self.Bar:ClearAllPoints()
		self.Bar:SetPoint("TOPLEFT")
		self.Bar:SetPoint("BOTTOMLEFT")
	end
	UpdateSize(self)
end

local function SetMinMaxValues(self, minval, maxval)
	if not (minval or maxval) then return end
	
	if maxval > minval then
		self.MinVal = minval
		self.MaxVal = maxval
	else 
		self.MinVal = 0
		self.MaxVal = 1
	end
	
	if self.Value > self.MaxVal then self.Value = self.MaxVal
	elseif self.Value < self.MinVal then self.Value = self.MinVal end
	
	UpdateBar(self) 
end

function CreateTidyPlatesStatusbar(parent)
	local frame = CreateFrame("Frame", nil, parent)
	--frame.Dim = 1
	frame:SetHeight(1)
	frame:SetWidth(1)
	frame.Value, frame.MinVal, frame.MaxVal, frame.Orientation = 1, 0, 1, "HORIZONTAL"
	frame.Bar = frame:CreateTexture(nil, "BACKGROUND")
	
	frame.SetValue = SetValue
	frame.SetMinMaxValues = SetMinMaxValues
	frame.SetOrientation = SetOrientation
	frame.SetStatusBarColor = SetStatusBarColor
	frame.SetStatusBarTexture = SetStatusBarTexture
	
	frame:SetScript("OnSizeChanged", UpdateSize)
	UpdateSize(frame)
	return frame
end
