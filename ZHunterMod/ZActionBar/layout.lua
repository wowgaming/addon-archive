local min = math.min

local reverse = {TOP = "BOTTOM", BOTTOM = "TOP", LEFT = "RIGHT", RIGHT = "LEFT"}
local backgroundTexture = "Interface\\Icons\\Spell_Holy_WordFortitude"

local function updateLayout(bar)
	local last = 1
	local counter = 1
	for i = 2, bar.numButtons do
		bar.button[i]:ClearAllPoints()
		if counter >= bar.perRow then
			bar.button[i]:SetPoint(reverse[bar.stack], bar.button[last], bar.stack, 0, 0)
			last = i
			counter = 1
		else
			bar.button[i]:SetPoint(reverse[bar.expand], bar.button[i-1], bar.expand, 0, 0)
			counter = counter + 1
		end
	end
end

function ZActionBar_SetupLayout(bar)
	updateLayout(bar)
end

function ZActionBar_SetSpecial(bar, value)
	if type(value) == "boolean" then
		bar.special = value
	end
	if bar.special then
		if not bar.button[1] then
			ZActionBar_AddButton(bar)
		end
		bar.button[1]:SetAttribute("*type1", "macro")
		bar.button[1].isUsed = 1
	elseif bar.button[1] then
		bar.button[1]:SetAttribute("*type1", "spell")
	end
	ZActionBar_UpdateBar(bar)
	bar:OnEvent("SPECIAL_TOGGLED", bar.special)
end

local afterSetTrigger = [[
	if trigger == "AlwaysOn" then
		control:ChildUpdate("show")
	else
		control:ChildUpdate("hide")
	end
]]

function ZActionBar_SetTrigger(bar, value)
	bar.trigger = value or bar.trigger or "OnMouseOver"
	bar.header:Execute("trigger = '" .. bar.trigger .. "'")
	bar.header:Execute(afterSetTrigger)
end

function ZActionBar_SetCount(bar, value)
	bar.count = value or bar.count or 99
	local isAlwaysOn = bar.trigger == "AlwaysOn"
	local numUsed = min(bar.count, bar.using)
	for i = 2, bar.numButtons do
		if i > numUsed then
			ZActionBar_DisableButton(bar.button[i])
		else
			ZActionBar_EnableButton(bar.button[i], isAlwaysOn)
		end
	end
	if bar.using > 0 then
		local button = bar.button[1]
		if numUsed == 0 then
			button:Hide()
		elseif button.isUsed then
			button:Show()
		end
	end
end

function ZActionBar_SetSize(bar, value)
	bar.size = value or bar.size or 30
	for i = 1, bar.numButtons do
		bar.button[i]:SetWidth(bar.size)
		bar.button[i]:SetHeight(bar.size)
	end
end

function ZActionBar_SetRoundButton(bar, value)
	if type(value) == "boolean" then
		bar.roundButton = value
	end
	if bar.roundButton then
		for i = 1, bar.numButtons do
			SetPortraitToTexture(bar.button[i].background, backgroundTexture)
			SetPortraitToTexture(bar.button[i].icon, bar.button[i].lastTexture)
		end
	else
		for i = 1, bar.numButtons do
			bar.button[i].background:SetTexture(backgroundTexture)
			bar.button[i].icon:SetTexture(bar.button[i].lastTexture)
		end
	end
end

function ZActionBar_SetCooldownDisplay(bar, value)

end

function ZActionBar_SetBackgroundColor(bar, value)
	bar.backgroundColor.r = value and value.r or bar.backgroundColor.r or 0.5
	bar.backgroundColor.g = value and value.g or bar.backgroundColor.g or 0.4
	bar.backgroundColor.b = value and value.b or bar.backgroundColor.b or 0.2
	for i = 1, bar.numButtons do
		bar.button[i].background:SetVertexColor(bar.backgroundColor.r, bar.backgroundColor.g, bar.backgroundColor.b)
	end
end

function ZActionBar_SetExpand(bar, value)
	bar.expand = value or bar.expand or "RIGHT"
	updateLayout(bar)
end

function ZActionBar_SetStack(bar, value)
	bar.stack = value or bar.stack or "BOTTOM"
	updateLayout(bar)
end

function ZActionBar_SetPerRow(bar, value)
	bar.perRow = value or bar.perRow or 99
	updateLayout(bar)
end

function ZActionBar_SetTooltip(bar, value)
	if type(value) == "boolean" then
		bar.tooltip = value
	end
end