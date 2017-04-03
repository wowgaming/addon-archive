local Icon = {}
local Icon_scripts = {}

function Icon:SetTexture(path)
	self.texture:SetTexture(path)
end

function Icon:SetTexCoord(c1, c2, c3, c4)
	self.texture:SetTexCoord(c1, c2, c3, c4)
end

PitBull4.Controls.MakeNewControlType("Icon", "Button", function(control)
	-- onCreate
	control:EnableMouse(false)
	
	local texture = PitBull4.Controls.MakeTexture(control, "ARTWORK")
	control.texture = texture
	texture:SetAllPoints(control)
	
	for k,v in pairs(Icon) do
		control[k] = v
	end
	for k,v in pairs(Icon_scripts) do
		control:SetScript(k, v)
	end
end, function(control)
	-- onRetrieve
end, function(control)
	-- onDelete
end)