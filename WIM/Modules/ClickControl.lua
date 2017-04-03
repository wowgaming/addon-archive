--imports
local WIM = WIM;
local _G = _G;
local pairs = pairs;
local GetTime = GetTime;


--set namespace
setfenv(1, WIM);


------------------------------------------
-- Module: ClickControl (Experimental)	--
------------------------------------------


local ClickControl = WIM.CreateModule("ClickControl", true);

local isInitialized = false;
local buttons = {};
local frame;

db_defaults.ClickControl = {
    clickSensitivity = .2;  
};


local function getButtonDownCount()
    local count = 0;
    for button, tbl in pairs(buttons) do
        if(tbl.mouseDown) then
            count = count + 1;
        end
    end
    return count;
end

local function getButtonTable(button)
    if(buttons[_G.tostring(button)]) then
	return buttons[button];
    else
	buttons[_G.tostring(button)] = {};
	return getButtonTable(button);
    end
end

local function cleanButtonTable(button)
    local tbl = getButtonTable(button);
    for t, _ in pairs(tbl) do
        tbl[t] = nil;
    end
end

local function worldFrameClicked(button)
    dPrint("WorldFrame -> Clicked["..button.."]");
    WIM.CallModuleFunction("OnWorldFrameClick", button);
end


function ClickControl:OnEnable()
    if(not isInitialized) then
    
        _G.WorldFrame:HookScript("OnMouseDown", function(self, button)
            if(ClickControl.enabled) then
                local p = getButtonTable(button);
                p.mouseDown = true;
                p.clickStart = GetTime();
            end
        end);
    
        _G.WorldFrame:HookScript("OnMouseUp", function(self, button)
            if(ClickControl.enabled) then
                local buttonCount = getButtonDownCount(); -- we need to know this cause we don't want to count moving.
                local p = getButtonTable(button);
                p.mouseDown = false;
                p.clickStop = GetTime();
                if(((p.clickStop or 999999999) - (p.clickStart or 0)) < db.ClickControl.clickSensitivity and buttonCount < 2 and not p.move) then
                    worldFrameClicked(button);
                end
                cleanButtonTable(button);
            end
	end);
        
	-- we only want to add hook once.
	isInitialized = true;
    end
end

function ClickControl:OnDisable()
    if(isInitialized) then
    -- alert to reload UI.
        _G.StaticPopupDialogs["WIM_CLICKCONTROL_DISABLE"] = {
            text = L["The UI must be reloaded in order to disable this module fully. Reload UI now?"],
            button1 = _G.TEXT(_G.YES),
            button2 = _G.TEXT(_G.NO),
            OnShow = function(self) end,
            OnHide = function() end,
            OnAccept = function() _G.ReloadUI(); end,
            OnCancel = function() end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };        
        _G.StaticPopup_Show ("WIM_CLICKCONTROL_DISABLE", theLink);
    end
end



------------------------------------------
--  Sub Functionality, Editbox Focus    --
------------------------------------------

function ClickControl:OnWorldFrameClick(button)
    if(EditBoxInFocus) then
        local editBox = EditBoxInFocus;
        editBox:Hide();
        editBox:Show();
    end
end
