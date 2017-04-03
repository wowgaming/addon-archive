-- handles slash commands for clearing various data such as history and filters.

local L = WIM.L;
local CommandListRaw = {"history", "filters"};

local function clearFun(sub)
    sub = string.trim(string.lower(sub));
    if(sub == "history") then
        StaticPopupDialogs["WIM_CLEAR_HISTORY"] = {
            text = L["You are about to clear all of WIM's history!"].."\n"..L["This action will reload your user interface."].."\n"..L["Do you want to continue?"],
            button1 = _G.YES,
            button2 = _G.NO,
            OnAccept = function()
                WIM3_History = nil;
                ReloadUI();
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
        StaticPopup_Show ("WIM_CLEAR_HISTORY");
    elseif(sub == "filters") then
        StaticPopupDialogs["WIM_CLEAR_FILTERS"] = {
            text = L["You are about to restore WIM's filters to it's default settings!"].."\n"..L["This action will reload your user interface."].."\n"..L["Do you want to continue?"],
            button1 = _G.YES,
            button2 = _G.NO,
            OnAccept = function()
                WIM3_Filters = nil;
                ReloadUI();
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
        StaticPopup_Show ("WIM_CLEAR_FILTERS");
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cff69ccf0"..L["Usage"]..":|r  ".."/wim clear {"..string.lower(table.concat(CommandListRaw, " | ")).."}");
    end
end

WIM.RegisterSlashCommand("clear", clearFun, L["Clear various WIM data."])