local NORMAL_FONT_COLOR = NORMAL_FONT_COLOR
local Talented = Talented

local branches = Talented.Pool:new()

local function NewBranch(parent)
	local t = parent:CreateTexture(nil, "BORDER")
	t:SetTexture("Interface\\Addons\\Talented\\Textures\\branches-normal")
	t:SetSize(32, 32)
	t:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)

	branches:push(t)

	return t
end

function Talented:MakeBranch(parent)
	local branch = branches:next()
	if branch then
		branch:SetParent(parent)
	else
		branch = NewBranch(parent)
	end
	return branch
end
