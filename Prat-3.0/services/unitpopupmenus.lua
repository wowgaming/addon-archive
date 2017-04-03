

local registry = { }

function Prat:RegisterDropdownButton(name, callback)
    registry[name] = callback or true
end




function showMenu(dropdownMenu, which, unit, name, userData, ...)
    local f
	for i=1, UIDROPDOWNMENU_MAXBUTTONS do
		button = getglobal("DropDownList"..UIDROPDOWNMENU_MENU_LEVEL.."Button"..i);

        f = registry[button.value]
		-- Patch our handler function back in
		if f then
		    button.func = UnitPopupButtons[button.value].func
            if type(f) == "function" then
                f(dropdownMenu, button)
            end
		end
	end
end

hooksecurefunc("UnitPopup_ShowMenu", showMenu)