local executeScript = [[
	trigger = "OnMouseOver"
	counter = 0
	toggledOn = false
	children = newtable()
]]

local OnClickScript = [[
	if trigger == "AlwaysOn" then
		return
	elseif trigger == "OnRightClick" then
		if button == "RightButton" then
			if toggledOn then
				control:ChildUpdate("hide")
				toggledOn = false
			else
				control:ChildUpdate("show")
				toggledOn = true
			end
		end
	elseif button == "LeftButton" then
		control:ChildUpdate("hide")
		toggledOn = false
	end
]]

local OnEnterScript = [[
	if trigger == "OnMouseOver" then
		control:ChildUpdate("show")
		toggledOn = true
	end
]]

local OnLeaveScript = [[
	if trigger == "OnMouseOver" then
		control:ChildUpdate("hide")
		toggledOn = false
	end
]]

local OnUpdateScript = [[
	counter = counter + elapsed
	if self:IsUnderMouse(true) then
		counter = 0
	elseif counter > 0.4 then
		counter = 0
		control:ChildUpdate("hide")
		toggledOn = false
	end
]]

local OnShowScript = "self:Show()"
local OnHideScript = "self:Hide()"

function ZActionBar_SetHeader(bar)
	local header = CreateFrame("Frame", bar:GetName().."Header", UIParent, "SecureHandlerBaseTemplate")
	header:Execute(executeScript)
	bar.header = header
end

function ZActionBar_LinkButton(bar, button)
	bar.header:WrapScript(button, "OnClick", OnClickScript)
	bar.header:WrapScript(button, "OnEnter", OnEnterScript)
	bar.header:WrapScript(button, "OnLeave", OnLeaveScript)
	if button:GetID() > 1 then
		button:SetAttribute("_childupdate-hide", OnHideScript)
	end
end

function ZActionBar_EnableButton(button, isAlwaysOn)
	button:SetAttribute("_childupdate-show", OnShowScript)
	if isAlwaysOn or button:GetID() == 1 then
		button:Show()
	end
end

function ZActionBar_DisableButton(button)
	button:SetAttribute("_childupdate-show", nil)
	button:Hide()
end