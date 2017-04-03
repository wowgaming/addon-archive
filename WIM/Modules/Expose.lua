--imports
local WIM = WIM;
local _G = _G;
local table = table;
local unpack = unpack;
local string = string;
local pairs = pairs;

--set namespace
setfenv(1, WIM);

db_defaults.expose = {
    combat = true,
    groupOnly = false,
    border = false,
    borderSize = 20,
    direction = 1,
    protect = 1,
};

local Expose = WIM.CreateModule("Expose", true);

local inCombat = false;

local isWaiting = false;

function Expose:VARIABLES_LOADED()
    -- add menu option inside of Minimap's menu.
    local minimapMenu = GetContextMenu("MENU_MINIMAP");
    local info = _G.UIDropDownMenu_CreateInfo();
    info.text = (db.expose.combat and L["Disable"] or L["Enable"]).." Expose";
    info.func = function()
        db.expose.combat = not db.expose.combat;
        GetContextMenu("ENABLE_DISABLE_EXPOSE").text = db.expose.combat and L["Disable"].." Expose" or L["Enable"].." Expose";
    end
    info.notCheckable = true;
    minimapMenu:AddSubItem(AddContextMenu("ENABLE_DISABLE_EXPOSE", info));
end

function Expose:OnStateChange(state, combatFlag)
    --if(1) then return; end -- not ready for release.
    if(db and db.expose and db.expose.combat) then
        if(db.expose.groupOnly) then
            -- check if in group, if not, return.
            if(not _G.IsInInstance()) then
                return;
            end
        end
	isWaiting = false;
        if(combatFlag) then
            --entered combat
	    if(db.expose.protect) then
		if(EditBoxInFocus and EditBoxInFocus:GetText() ~= "") then
		    isWaiting = true;
		    return;
		end
	    end
            HideContainer(db and db.winAnimation);
            inCombat = true;
            DisplayTutorial(L["Expose"].."?!", L["Your conversations have been hidden in order to clear your screen while in combat. To disable this feature type"].." |cff69ccf0/wim|r");
        elseif(inCombat) then
            --left combat
            ShowContainer(db and db.winAnimation);
        end
    end
end


local exposeFrame = _G.CreateFrame("Frame", "WIM_UIParent_Expose", _G.UIParent);
exposeFrame:SetFrameStrata("BACKGROUND");
exposeFrame:SetAllPoints();
exposeFrame.top = exposeFrame:CreateTexture("BACKGROUND");
exposeFrame.top:SetTexture(0, 0, 0, .5);
exposeFrame.bottom = exposeFrame:CreateTexture("BACKGROUND");
exposeFrame.bottom:SetTexture(0, 0, 0, .5);
exposeFrame.left = exposeFrame:CreateTexture("BACKGROUND");
exposeFrame.left:SetTexture(0, 0, 0, .5);
exposeFrame.right = exposeFrame:CreateTexture("BACKGROUND");
exposeFrame.right:SetTexture(0, 0, 0, .5);
exposeFrame:SetAlpha(0);

local function AnimAlpha(self, fraction)
    return fraction;
end

local AnimTable = {
	totalTime = 0.3,
	updateFunc = "SetAlpha",
	getPosFunc = AnimAlpha,
	}

function Expose:OnContainerShow()
    if(db.expose.border) then
        exposeFrame:Show();
        WIM.SetUpAnimation(exposeFrame, AnimTable, function(self) self:SetAlpha(0); end, true);
    else
        exposeFrame:Hide();
    end
end

function Expose:OnContainerHide()
    if(db.expose.border) then
        exposeFrame:Show();
        exposeFrame.top:SetPoint("TOPLEFT", exposeFrame, "TOPLEFT", 0, 0);
        exposeFrame.top:SetPoint("BOTTOMRIGHT", exposeFrame, "TOPRIGHT", 0, -(db.expose.borderSize));
        exposeFrame.bottom:SetPoint("BOTTOMLEFT", exposeFrame, "BOTTOMLEFT", 0, 0);
        exposeFrame.bottom:SetPoint("TOPRIGHT", exposeFrame, "BOTTOMRIGHT", 0, db.expose.borderSize);
        exposeFrame.left:SetPoint("TOPLEFT", exposeFrame.top, "BOTTOMLEFT", 0, 0);
        exposeFrame.left:SetPoint("BOTTOMRIGHT", exposeFrame.bottom, "TOPLEFT", db.expose.borderSize, 0);
        exposeFrame.right:SetPoint("TOPRIGHT", exposeFrame.top, "TOPRIGHT", 0, 0);
        exposeFrame.right:SetPoint("BOTTOMLEFT", exposeFrame.bottom, "TOPRIGHT", -(db.expose.borderSize), 0);
    
        WIM.SetUpAnimation(exposeFrame, AnimTable, function(self) self:SetAlpha(1); end, false);
    else
        exposeFrame:Hide();
    end
end


-- delay expose if currently typing

-- no longer typing, trigger expose.
RegisterWidgetTrigger("msg_box", "whisper,chat,w2w", "OnEditFocusLost", function(self)
    if(isWaiting) then
	WIM:PLAYER_ENTERING_WORLD(); -- hack to refresh states.
    end
end);


-- This module will always remain running.
Expose.canDisable = false;
Expose:Enable();
