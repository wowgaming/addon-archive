local buttonMap = setmetatable({
    [1] = "LeftButton",
    [2] = "RightButton",
    [3] = "MiddleButton",
}, {
    __index = function(t, k)
        return "Button" .. k
    end
})

function Clique:GetModifierText()
    local modifier = ""
    
	if IsShiftKeyDown() then
		modifier = "Shift-"..modifier
	end
	if IsControlKeyDown() then
		modifier = "Ctrl-"..modifier
	end
	if IsAltKeyDown() then
		modifier = "Alt-"..modifier
	end
    
    return modifier
end

function Clique:GetButtonNumber(button)
    return SecureButton_GetButtonSuffix(button)
end

function Clique:GetButtonText(num)
    if not num then return "" end
	if type(num) == "string" then
		num = num:gsub("helpbutton", "")
		num = num:gsub("harmbutton", "")
	end
	num = tonumber(num) and tonumber(num) or num
    return buttonMap[num] or ""
end

function Clique:CheckBinding(key)
    for k,v in pairs(self.editSet) do
        if k == key then 
            return v
        end
    end
end
