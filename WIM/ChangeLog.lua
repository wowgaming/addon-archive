--[[
    This change log was meant to be viewed in game.
    You may do so by typing: /wim changelog
]]
local currentRevision = tonumber(("$Revision: 271 $"):match("(%d+)"));
local log = {};
local beta_log = {};
local t_insert = table.insert;

local function addEntry(version, rdate, description, transmitted)
    t_insert(log, {v = version, r = rdate, d = description, t=transmitted and true});
end

local function addBetaEntry(version, rdate, description, transmitted)
    t_insert(log, {v = version, r = rdate, d = description, t=transmitted and true});
end

-- ChangeLog Entries.
addEntry("3.3.7", "07/13/2010", [[
    *Fixed linking of all blizzard items.
    *Changed tooltip to read 'Character' instead of 'Toon Name'.
    *Per request, ldb module changed from launcher to data source.
    *Update zhTW translations. Thank you Junxian.
    *Tweaked real id tooltip to not show bank info if info not provided.
]]);

addEntry("3.3.6", "06/24/2010", [[
    *Fixed issue when receiving messages from realID users.
    +Invite & Ignore now work for realID messages from users on the same realm.
    *Fixed bug where items were not linking into WIM windows.
    *Added extra check for realID class colors.
    *Fixed bug with intercepting whisper slash commands.
]]);

addEntry("3.3.5", "06/23/2010", [[
    *Updated for WoW version 3.3.5
    +Added initial BattleNet whisper support.
    +Added history recording for Party Leader (Thanks Stewart).
]]);

addEntry("3.3.4", "05/06/2010", [[
    +Added Wowhead profile link.
    *Fixed error some encountered with db and Expose on load.
    +Added 'Enable/Disable Expose' to Minimap Icon's context menu.
    *Changed window clamp to screen defaulted to on instead of off.
    +Added Raid announcements/warnings to raid chat.
    *Updated libChatHandler-1.0 to catch mal-formed filter functions.
    +Added option to group chat windows with whisper windows.
]]);

addEntry("3.3.3", "02/23/2010", [[
    *Animation system now part of WIM namespace preventing local/global confusion.
    *libChatHandler-1.0 no longer hooks the Default ChatFrame reducing tainted objects.
    *Created API to handle custom SetItemRef calls - Eliminated large cause of taint plaguing.
    *Includes a revised version of libWho-2.0. Eliminates tainting of FriendsFrame.
]]);

addEntry("3.3.2", "02/16/2010", [[
    *OnWindowLeaveScreen is only fired when Clamp to Screen is disabled.
    *Off screen detection did not account for effective scale.
]]);

addEntry("3.3.1", "02/16/2010", [[
    *Updated TOC to 3.3
    +Added party event handling for new CHAT_MSG_PARTY_LEADER.
    *Updated WIM to work with the new tutorial system.
    +Added 'Windows Settings' option 'Clamp window to screen'.
    +Added new WIM Module API Events (OnWindowLeaveScreen, OnWindowEnterScreen).
    +Added new Module - Track windows when dragged off the screen.
]]);

addEntry("3.2.2", "10/27/2009", [[
    *Fixed bug which caused arithmetic error in ClickControl.lua.
    +Added scroll bars to WIM's sound option menus (More adaptations to come).
]]);

addEntry("3.2.1", "10/19/2009", [[
    *Updated French translations. (Thank you vibé)
    *Updated various libraries.
    +Added option '<Tab> to advance tell target.' (Thank you Nathan)
    +Added WIM API RegisterPreSendFilterText(function).
    +Added option to World & Custom channels to disable sounds.
    *Fixed bug in History Viewer when viewing blocked users.
    +Added class selection to level filter.
    +Added option to Expose to delay if currently typing.
    +Added World Frame Click Detection. You can now click out of a WIM window.
    *Fixed bug when editing filters. Changes saved even though user clicked 'Cancel'.
    *Fixed bug -- Wasn't updating args from message event filters.
    +Added Name/Class colorizing to names in chat.
    +Added Message Format option 'Bracket names.'.
    -Removed isPrivateServer restriction from W2W (/wim addon_messages)
    *Modified replyTellTarget hook's behavior (Thank you Stewart)
    *Updated Russian translations (Thank you Stingersoft)
]]);


addEntry("3.1.3", "08/24/2009", [[
    *Pushing update to force new LibWho-2.0
]]);

addEntry("3.1.2", "08/13/2009", [[
    *Updated TOC for 3.2
    +Added HTML history view/export.
    *Optimized Negotiation Module to significantly reduce addon spam.
    *Channel counts weren't updating propperly.
    *Fixed bug in history viewer. Messages from some realms couldn't be deleted.
    *Pushed update to update outdated libraries.
]]);

addEntry("3.1.1", "04/15/2009", [[
    *Rearranged WIM's options. Sounds & History are now in category Whispers.
    *Revised BBCode export to avoid nested color tags. Thank you Stewart.
    +Added credits menu to options. A lot of people deserve a big thanks.
    *Updated LDB Module to behave the same as the minimap icon.
    *Emoticons are no longer parsed in BBCode History View.
    +New Chat Engine! Disabled by default. See WIM's Options (/wim).
]]);

addEntry("3.0.10", "04/02/2009", [[
    *Fixed some resizing issues.
    *Fixed bug when seperating tabs.
    *Fixed bug with W2W tooltip - version information.
    *When sending messages, priorities are now set to ALERT in ChatThrottleLib.
    *Fixed db indexing errors occurring on load.
    *Revised the UI for Window Behaviors.
    *Updated isPrivateServer check to account for battle.net accounts.
    -Removed April Fools Joke.
]]);

addEntry("3.0.9", "03/24/2009", [[
    *Windows no longer close when zoning or opening world map.
    +Added option to only activate expose while inside of an instance.
    +Added version to w2w tooltip.
    *Expose respects window animation setting.
    +Added option to enable/disable Expose border (defaulted off).
    *Changed the order of some items in the Minimap Dropdown Menu.
    *Fixed bug where Expose wouldn't place windows correctly.
    +Added Up, Down, Left, Right animation directions for Expose.
    *Fixed animation when window is in TOPRIGHT and BOTTOMRIGHT corners.
]]);

addEntry("3.0.8", "03/19/2009", [[
    +Added section for WIM in Blizzard's keybinding interface.
    +Added 'Expose' feature as well as options (combat & visual).
    *Fixed they way modules were being handled when WIM enabled is toggled.
    +Added Enable/Disable WIM to Minimap right-click menu.
    -Removed <GM> tag from GM's names & fixed error when whispering a GM.
    *Fixed bug when splitting long messages. Thanks blazeflack.
    *Options & History window now toggle on and off if called more than once.
    *Fixed various bugs in the Socket & Compression Sources.
    +View changelog before you upgrade WIM. Changelog shared with friends.
    +Added Profile links (example: wowarmory). Right Click location button.
    +Updated translations for ruRU, zhCN, zhTW.
    +Added BBCode formatting to history.
    *Fixed possible bug with message event filters.
]]);

addEntry("3.0.7", "03/12/2009", [[
    +Added context menu management system.
    +Added minimap icon right mouse click menu.
    *Modules were getting loaded on startup regardless of their settings.
    *Fixed a bug where tabs would be updated incorrectly.
    *Fixed freeze/lockup bug when switching tabs.
    +Added <Right-Click> drop down menu to window's text box.
    +Added emoticons to the drop down menu.
    +Added recently sent messages to drop down menu.
    +Added koKR translation. (thank you BlueNyx).
]]);

addEntry("3.0.6", "03/10/2009", [[
    *Fixed: Error when receiving whisper while minimizing.
    *Fixed: Negotiating with guild members would cause addon msg spam.
    *Changed outbound whispers priority from NORMAL to ALERT.
    *Fix for 3.0.8/9 patch. GM's should no longer receive addon messages.
    +Tabs now flash when it contains an unread message.
    *Fixed error when closing tabs.
    +Added LibChatHandler-1.0 for chat management. I will post documentation for this.
    *Fixed Level lookup.
    *LibBabbel-TalentTree is no longer packaged with WIM.
    +Added compatibility for PTR ChatEventFilters.
    +Added Change Log Viewer (/wim changelog).
    *Set cache timeout of 60 seconds for filter level lookups.
    *Fixed error that would sometimes occur when right mouse clicking the minimap icon.
    *Fixed bug which caused tabbed windows to pop regardless of selected rules.
    *Level filtering wasn't recording stats.
    +Added option to filters to send alert chat frame when a message is blocked.
    -Depricated WIM:EventHandler() to avoid conflict with old WIM event hooks.
    *Revised the module calls made when WIM is enabled/disabled.
    *Fixed bug in history viewer when using Prat formatting.
    +Addon messages are never sent if on a private server.
    *Fixed inconsistant pop rules.
    +<TAB> and <Shift>+<Tab> can be used to navigate through a tab group
    *Tabstrip updates to show selected tab when window is popped/shown.
    +Moving the minimap icon now requires you to hold <Shift> while dragging.
    +Added option to unlock Minimap Icon from the Minimap (Free Moving).
]]);
addEntry("3.0.5", "12/02/2008", [[
    *Fixed: Who lookups wouldn't update if already cached.
    *Fixed: Default Spamfilter wasn't working as intended.
    *Loading of skins also updates character info as well.
    *Fixed the history viewer. For real this time? (Thanks Stewart)
    *History text view loads correctly now on first click. (Thanks Stewart)
    *History text views are stripped of all colors and emoticons.
    +Added Russian translations. (Thanks Stingersoft)
    *Fixed: System message of user coming online wasn't being handled correctly.
    +Added libraries to optional dependencies to allow for disembedded addons.
    *Moved Window Alpha option from Window Settings to Display Settings.
    +Added Window Strata option to Window Settings.
    *Fixed: History viewer wasn't loading for entire realm.
    *Fixed: Tabs now honor focus as intended. (Thanks Stewart)
]]);
addEntry("3.0.4", "11/12/2008", [[
    *History frame was named incorrectly. 'WIM3_HistoryFrame' is its new name.
    *Socket only compresses large transmissions to minimize resource usage.
    *Optimized tabs.
    *Tabs scroll correctly now.
    *Location button on shortcut uses special W2W tooltip if applicable.
    *History viewer wasn't displaying realms which had non-alphanumeric characters in it.
    *Fixed bug where alerts where referencing minimap icon even though it hasn't been loaded.
    +WIM now comes packaged with LibBabble-TalentTree-3.0 and further defines class information.
    +Added W2W Talent Spec sharing.
    *Lowered options frame strata from DIALOG to MEDIUM.
    *Fixed animation crash (Caused by blizzards ScrollingMessageFrame).
    +WIM's widget API now calls UpdateSkin method of widget if available upon skin loading.
    *Long messages are now split correclty without breaking links.
    *LastTellTarget is not set correctly when receiving AFK & DND responses.
    +WIM now uses LibWho-2.0. WhoLib-1.0 is now considered depricated.
    -Removed dependencies(libs) of all Ace2 addons including Deformat.
]]);
addEntry("3.0.3", "10/23/2008", [[
    +Added Tab Management module. (Auto grouping of windows.)
    *Avoid any chances of dividing by 0 in window animation.
    *Changed window behavior priorities to: Arena, Combat, PvP, Raid, Party, Resting Other.
    *Fixed bug when running WIM on WOTLK.
    +W2W Typing notification is triggered from the default chat frame now too.
    -W2W will no longer notify user as typing if user is typing a slash command.
    *Fixed a resizing bug when using tabs. Entire tab group inherits size until removed.
    +Added ChangeLog.lua (contains release information to be used later.)
    *Corrected shaman class color.
    *Focus gain also respects Blizzard's ChatEditFrame.
    *Filters are no longer trimmed.
    +Added deDE localizations.
    +Added sound options.
    +Added some stock sound files.
]]);


local function entryExists(version)
    for i=1, #log do
        if(log[i].v == version) then
            return true;
        end
    end
    return false;
end

local freshLoad = true;
local function formatEntry(txt)
    local out = "";
    for line in txt:gmatch("([^\n]+)\n") do
        line = line:gsub("^%s*(%+)", " |cff69ccf0+ ");
        line = line:gsub("^%s*(%*)", " |cffc79c6e* ");
        line = line:gsub("^%s*(%-)", " |cffc41f3b- ");
        out = out..line.."|r\n";
    end
    return out;
end


local function getEntryText(index)
    local entry = log[index];
    if(not entry) then return ""; end
    local revision = entry.v == WIM.version and " - Revision "..WIM.GetRevision() or "";
    revision = entry.t and " - |cffff0000"..WIM.L["Available For Download!"].."|r" or revision;
    local txt = "Version "..entry.v.."  ("..entry.r..")"..revision.."\n";
    txt = txt..formatEntry(entry.d);
    
    freshLoad = false;
    return txt.."\n\n";
end

local function logSort(a, b)
    if(WIM.CompareVersion(a.v, b.v) > 0) then
        return true;
    else
        return false;
    end
end

local changeLogWindow;
local function createChangeLogWindow()
    -- create frame object
    local win = CreateFrame("Frame", "WIM3_ChangeLog", _G.UIParent);
    win:Hide(); -- hide initially, scripts aren't loaded yet.
    table.insert(UISpecialFrames, "WIM3_ChangeLog");
    
    -- set size and position
    win:SetWidth(700);
    win:SetHeight(500);
    win:SetPoint("CENTER");
    
    -- set backdrop
    win:SetBackdrop({bgFile = "Interface\\AddOns\\"..WIM.addonTocName.."\\Sources\\Options\\Textures\\Frame_Background", 
        edgeFile = "Interface\\AddOns\\"..WIM.addonTocName.."\\Sources\\Options\\Textures\\Frame", 
        tile = true, tileSize = 64, edgeSize = 64, 
        insets = { left = 64, right = 64, top = 64, bottom = 64 }});

    -- set basic frame properties
    win:SetClampedToScreen(true);
    win:SetFrameStrata("DIALOG");
    win:SetMovable(true);
    win:SetToplevel(true);
    win:EnableMouse(true);
    win:RegisterForDrag("LeftButton");

    -- set script events
    win:SetScript("OnShow", function(self) _G.PlaySound("igMainMenuOpen"); self:update();  end);
    win:SetScript("OnHide", function(self) _G.PlaySound("igMainMenuClose");  end);
    win:SetScript("OnDragStart", function(self) self:StartMoving(); end);
    win:SetScript("OnDragStop", function(self) self:StopMovingOrSizing(); end);
    
    -- create and set title bar text
    win.title = win:CreateFontString(win:GetName().."Title", "OVERLAY", "ChatFontNormal");
    win.title:SetPoint("TOPLEFT", 50 , -20);
    local font = win.title:GetFont();
    win.title:SetFont(font, 16, "");
    win.title:SetText(WIM.L["WIM (WoW Instant Messenger)"].." v"..WIM.version.."   -  "..WIM.L["Change Log"]);
    
    -- create close button
    win.close = CreateFrame("Button", win:GetName().."Close", win);
    win.close:SetWidth(18); win.close:SetHeight(18);
    win.close:SetPoint("TOPRIGHT", -24, -20);
    win.close:SetNormalTexture("Interface\\AddOns\\"..WIM.addonTocName.."\\Sources\\Options\\Textures\\blipRed");
    win.close:SetHighlightTexture("Interface\\AddOns\\"..WIM.addonTocName.."\\Sources\\Options\\Textures\\close", "BLEND");
    win.close:SetScript("OnClick", function(self)
            self:GetParent():Hide();
        end);
    
    win.textFrame = CreateFrame("ScrollFrame", "WIM3_ChangeLogTextFrame", win, "UIPanelScrollFrameTemplate");
    win.textFrame:SetPoint("TOPLEFT", 25, -50);
    win.textFrame:SetPoint("BOTTOMRIGHT", -42, 20);
    
    win.textFrame.text = CreateFrame("SimpleHTML", "WIM3_ChangeLogTextFrameText", win.textFrame);
    win.textFrame.text:SetWidth(win.textFrame:GetWidth());
    win.textFrame.text:SetHeight(200);
    win.textFrame:SetScrollChild(win.textFrame.text);
    
    win.update = function(self)
        local tmp = "";
        freshLoad = true;
        table.sort(log, logSort);
        for i=1, #beta_log do
            tmp = tmp..getEntryText(i);
        end
        for i=1, #log do
            tmp = tmp..getEntryText(i);
        end
        self.textFrame.text:SetFontObject(ChatFontNormal);
        self.textFrame.text:SetText(tmp);
        self.textFrame:UpdateScrollChildRect();
    end
    
    return win;
end

local function getEntryString(index)
    local entry = log[index];
    if(entry) then
        local out = entry.v.."\003\003"..entry.r.."\003\003"..entry.d;
        return out;
    else
        return;
    end
end

WIM.RegisterAddonMessageHandler("CHANGELOG", function(from, data)
        local v, r, d = string.match(data, "^(.+)\003\003(.+)\003\003(.+)$");
        WIM.AddChangeLogEntry(v, r, d);
    end);

WIM.RegisterAddonMessageHandler("GETCHANGELOG", function(from, data)
        for i=1, #log do
            if(WIM.CompareVersion(log[i].v, data) > 0) then
                local vd = getEntryString(i);
                if(vd) then
                    --DEFAULT_CHAT_FRAME:AddMessage(vd);
                    WIM.SendData("WHISPER", from, "CHANGELOG", vd);
                end
            end
        end
    end);

WIM.RegisterAddonMessageHandler("NEGOTIATE", function(from, data)
        local v, isBeta = string.match(data, "^(.+):(%d)");
        local diff = WIM.CompareVersion(v);
        if(diff > 0 and tonumber(isBeta) == 0 and not entryExists(v)) then
            WIM.SendData("WHISPER", from, "GETCHANGELOG", WIM.version);
        end
    end);


function WIM.ShowChangeLog()
    changeLogWindow = changeLogWindow or createChangeLogWindow();
    changeLogWindow:Show();
end

function WIM.GetRevision()
    return currentRevision;
end

local transmissionReceived = false;
function WIM.AddChangeLogEntry(version, releaseDate, desc)
    if(type(version) == "string" and type(releaseDate) == "string" and type(desc) == "string" and not entryExists(version)) then
        addEntry(version, releaseDate, desc, true);
        transmissionReceived = true;
        if(changeLogWindow and changeLogWindow:IsShown()) then
            changeLogWindow:update();
        end
    end
end

function WIM.ChangeLogUpdated()
    return transmissionReceived;
end

WIM.RegisterSlashCommand("changelog", WIM.ShowChangeLog, WIM.L["View WIM's change log."]);
