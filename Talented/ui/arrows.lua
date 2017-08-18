local NORMAL_FONT_COLOR = NORMAL_FONT_COLOR
local Talented = Talented

local arrows = Talented.Pool:new()

local function NewArrow(parent)
	local t = parent:CreateTexture(nil, "OVERLAY")
	t:SetTexture("Interface\\Addons\\Talented\\Textures\\arrows-normal")
	t:SetSize(32, 32)
	t:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)

	arrows:push(t)

	return t
end

function Talented:MakeArrow(parent)
	local arrow = arrows:next()
	if arrow then
		arrow:SetParent(parent.overlay)
	else
		arrow = NewArrow(parent.overlay)
	end
	return arrow
end
