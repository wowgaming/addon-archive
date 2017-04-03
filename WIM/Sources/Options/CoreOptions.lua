--imports
local WIM = WIM;
local _G = _G;
local table = table;
local CreateFrame = CreateFrame;
local unpack = unpack;
local UnitName = UnitName;
local pairs = pairs;

--set namespace
setfenv(1, WIM);

db_defaults.stats = {
    whispers = 0,
    mostConvos = 0,
    versions = 1,
    startDate = "",
}

local credits = {
    "Pazza <Bronzebeard-US>",
    "Stewarta <Emerald Dream - EU>\n\nAstaldo <Bronzebeard - EU>\nZeke <Coilfang - US>\nMorphieus <Spinebreaker>\nNachonut <Bronzebeard - US>\n\nChiaki <Frostwolf - EU> - deDE\n"..
    "BlueNyx <bluenyx@gmail.com> - koKR\nStingerSoft <stingersoft@iti.lt> - ruRU\nJunxian <junxian1121@hotmail.com> - zhCN & zhTW\n"
};

local states = {"arena", "combat", "pvp", "raid", "party", "resting", "other"};

local filterListCount = 9;

local function General_Main()
    local frame = options.CreateOptionsFrame()
    frame.welcome = frame:CreateSection(L["Welcome!"], L["_Description"]);
    frame.welcome.nextOffSetY = -10;
    frame.welcome.cb1 = frame.welcome:CreateCheckButton(L["Enable WIM"], WIM.db, "enabled", nil, function(self, button) SetEnabled(self:GetChecked()); end);
    frame.welcome.nextOffSetY = -30;
    frame.welcome.cb2 = frame.welcome:CreateCheckButton(L["Display Minimap Icon"], WIM.modules.MinimapIcon, "enabled", nil, function(self, button) EnableModule("MinimapIcon", self:GetChecked()); end);
    frame.welcome.cb2:CreateCheckButton(L["Unlock from Minimap"], db.minimap, "free", nil, function(self, button) modules.MinimapIcon:OnEnable() end);
    frame.welcome.cb2:CreateCheckButton(L["<Right-Click> to show unread messages."], db.minimap, "rightClickNew");
    frame.welcome.nextOffSetY = -75;
    frame.welcome.tabFun = frame.welcome:CreateCheckButton(L["Press <Tab> to advance to next tell target."], WIM.db, "tabAdvance");
    
    local sensitivity = {};
    table.insert(sensitivity, {
            text = L["Sensitivity"],
            isTitle = true,
            justifyH = "LEFT",
        });
    for i=1,10 do
        table.insert(sensitivity, {
            text = i,
            value = i*.05,
            justifyH = "LEFT",
        });
    end
    frame.welcome.sensitivity = frame.welcome:CreateCheckButtonMenu(L["Enable WorldFrame Click Detection."], WIM.modules.ClickControl, "enabled", nil, function(self, button) EnableModule("ClickControl", self:GetChecked()); end, sensitivity, db.ClickControl, "clickSensitivity");
    frame.welcome.nextOffSetY = -45;
    
    
    
    frame.welcome.cb3 = frame.welcome:CreateCheckButton(L["Display Tutorials"], WIM.modules.Tutorials, "enabled", nil, function(self, button) EnableModule("Tutorials", self:GetChecked()); end);
    frame.welcome.reset = frame.welcome:CreateButton(L["Reset Tutorials"], function() db.shownTutorials = {}; end);
    frame.welcome.reset:ClearAllPoints();
    frame.welcome.reset:SetPoint("LEFT", frame.welcome.cb3, "RIGHT", frame.welcome.cb2.text:GetStringWidth()+30, 0);
    frame.welcome.lastObj = frame.welcome.cb3;
    return frame;
end


local function General_MessageFormatting()
    local Preview = {
        {"CHAT_MSG_WHISPER_INFORM", L["This is a long message which contains both emoticons and urls 8). WIM's home is www.WIMAddon.com."], UnitName("player")},
    };

    local frame = options.CreateOptionsFrame();
    local f = frame:CreateSection(L["Message Formatting"], L["Manipulate how WIM displays messages."]);
    f.nextOffSetY = -15;
    local itemList = {};
    local formats = GetMessageFormattingList();
    f.default = {};
    f.updateOptions = function()
        for _, obj in pairs(f.default) do
            if(db.messageFormat == L["Default"]) then
                obj:Enable();
            else
                obj:Disable();
            end
        end
    end
    for i=1, #formats do
        table.insert(itemList, {
            text = formats[i],
            value = formats[i],
            justifyH = "LEFT",
            func = function(self)
                f.prev:Hide();
                f.prev:Show();
                f.updateOptions();
            end,
        });
    end
    db.messageFormat = isInTable(formats, db.messageFormat) and db.messageFormat or formats[1];
    f.mf = f:CreateDropDownMenu(db, "messageFormat", itemList);
    f.prevTitle = f:CreateText(nil, 12);
    f.prevTitle:SetFullSize();
    f.prevTitle:SetText(L["Preview"]);
    f.prevTitle:SetJustifyH("LEFT");
    f.nextOffSetY = -10
    f.prevFrame = f:CreateSection();
    options.AddFramedBackdrop(f.prevFrame);
    f.prev = CreateFrame("ScrollingMessageFrame", f:GetName().."PrevScrollingMessageFrame");
    f.prev:SetScript("OnShow", function(self)
            local color = db.displayColors.wispIn;
            local font, height, flags;
            if(_G[db.skin.font]) then
                font, height, flags = _G[db.skin.font]:GetFont();
            else
                font = libs.SML.MediaTable.font[db.skin.font] or _G["ChatFontNormal"]:GetFont();
            end
            self:SetFont(font, 14, db.skin.font_outline);
            self:Clear();
            for i=1, #Preview do
                self:AddMessage(applyStringModifiers(applyMessageFormatting(self, unpack(Preview[i])), self), color.r, color.g, color.b);
            end
            self:SetIndentedWordWrap(db.wordwrap_indent);
        end);
    f.prev:SetFading(false);
    f.prev:SetMaxLines(5);
    f.prev:SetJustifyH("LEFT");
    
    f.prevFrame:SetHeight(60);
    f.prevFrame:SetScript("OnShow", nil); -- we don't want this to trigger
    f.prevFrame:ImportCustomObject(f.prev):SetFullSize();
    f.prev:ClearAllPoints();
    f.prev:SetPoint("TOPLEFT", 5, -5); f.prev:SetPoint("BOTTOMRIGHT", -5, 5);
    f.nextOffSetY = -10
    formats = GetTimeStampFormats();
    tsList = {};
    for i=1, #formats do
        table.insert(tsList, {
            text = _G.date(formats[i]),
            value = formats[i],
            justifyH = "LEFT",
            func = function() f.prev:Hide(); f.prev:Show(); end,
        });
    end
    -- format non-related options.
    f:CreateCheckButtonMenu(L["Display Time Stamps"], modules.TimeStamps, "enabled", nil, function(self, button) EnableModule("TimeStamps", self:GetChecked()); f.prev:Hide(); f.prev:Show(); end, tsList, db, "timeStampFormat", function(self, button) f.prev:Hide(); f.prev:Show(); end);
    f:CreateCheckButton(L["Display Emoticons"], modules.Emoticons, "enabled", nil, function(self, button) EnableModule("Emoticons", self:GetChecked()); f.prev:Hide(); f.prev:Show(); end);
    f:CreateCheckButton(L["Display URLs as Links"], modules.URLHandler, "enabled", nil, function(self, button) EnableModule("URLHandler", self:GetChecked()); f.prev:Hide(); f.prev:Show(); end);
    f:CreateCheckButton(L["Indent long messages."], db, "wordwrap_indent", nil, function(self, button) UpdateAllWindowProps(); f.prev:Hide(); f.prev:Show(); end);
    -- options specific to WIM's formatting.
    f.default.color = f:CreateCheckButton(L["Colorize names."], db, "coloredNames", nil, function(self, button) UpdateAllWindowProps(); f.prev:Hide(); f.prev:Show(); end);
    fList = {};
    for i=1, #lists.bracketing do
        table.insert(fList, {
            text = lists.bracketing[i][1].." "..lists.bracketing[i][2],
            value = i,
            justifyH = "LEFT",
            func = function() f.prev:Hide(); f.prev:Show(); end,
        });
    end
    f.default.bracket = f:CreateCheckButtonMenu(L["Bracket names."], db.formatting.bracketing, "enabled", nil, function(self, button) f.prev:Hide(); f.prev:Show(); end, fList, db.formatting.bracketing, "type");
    
    return frame;
end


local function createPopRuleFrame(winType)
    local frame = options.CreateOptionsFrame();
    frame.type = winType;
    frame.main = frame:CreateSection((winType == "chat" and _G.CHAT..": " or "")..L["Window Behavior"], L["You can control how windows behave while you are in different situations."]);
    frame.main.nextOffSetY = -20;
    frame.main.intercept = frame.main:CreateCheckButton(L["Intercept Slash Commands"], db.pop_rules[frame.type], "intercept");
    frame.main.nextOffSetY = -20;
    frame.main.alwaysOther = frame.main:CreateCheckButton(L["Use the same rules for all states."], db.pop_rules[frame.type], "alwaysOther", nil, function(self)
            if(self:GetChecked()) then
                frame.main.selectedState = "other";
                frame.main.tabs.buttons[#frame.main.tabs.buttons]:Click();
            end
            frame:Hide();
            frame:Show();
        end);
    frame.main.nextOffSetY = -80;
    frame.main.selectedState = "other";

    frame.main.options = frame.main:CreateSection();
    options.AddFramedBackdrop(frame.main.options);
    frame.main.options.getDBTree = function() return db.pop_rules[frame.type][frame.main.selectedState]; end;
    frame.main.options:CreateCheckButton(L["Pop-Up window when message is sent."], frame.main.options.getDBTree, "onSend");
    frame.main.options:CreateCheckButton(L["Pop-Up window when message is received."], frame.main.options.getDBTree, "onReceive");
    frame.main.options:CreateCheckButton(L["Auto focus a window when it is shown."], frame.main.options.getDBTree, "autofocus");
    frame.main.options:CreateCheckButton(L["Keep focus on window after sending a message."], frame.main.options.getDBTree, "keepfocus");
    frame.main.options:CreateCheckButton(L["Suppress messages from the default chat frame."], frame.main.options.getDBTree, "supress");
    
    frame.main.tabs = CreateFrame("Frame", nil, frame.main);
    frame.main.tabs:SetPoint("BOTTOMLEFT", frame.main.options, "TOPLEFT", 0, 1);
    frame.main.tabs:SetPoint("BOTTOMRIGHT", frame.main.options, "TOPRIGHT", 1 , 1);
    frame.main.tabs:SetHeight(20);
    frame.main.tabs.title = frame.main.tabs:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    frame.main.tabs.title:SetPoint("BOTTOMLEFT", frame.main.tabs, "TOPLEFT", 0, 10);
    frame.main.tabs.title:SetText(L["Behaviors per current state"]..":");
    frame.main.tabs.buttons = {};
    local function createButton(tg)
            local state = states[#tg.buttons+1];
            local button = CreateFrame("Button", nil, tg);
            button.text = button:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
            button.text:SetAllPoints();
            button.text:SetText(_G[_G.string.upper(state)] or L["state_resting"]);
            button.state = state;
            if(#tg.buttons == 0) then
                button:SetPoint("BOTTOMLEFT");
            else
                button:SetPoint("BOTTOMLEFT", tg.buttons[#tg.buttons], "BOTTOMRIGHT", 2, 0);
            end
            button:SetHeight(tg:GetHeight());
            button:SetWidth(55);
            button.bg = button:CreateTexture(nil, "BACKGROUND");
            button.bg:SetAllPoints();
            button.bg:SetTexture(1,1,1,.25);
            button:SetScript("OnClick", function(self)
                    frame.main.selectedState = self.state;
                    frame.main.options:Hide();
                    frame.main.options:Show();
                    for _,button in pairs(frame.main.tabs.buttons) do
                        if(self.state == button.state) then
                            button:SetAlpha(1);
                        else
                            button:SetAlpha(.35);
                        end
                    end
            end);
            table.insert(tg.buttons, button);
            if(#tg.buttons == #states) then
                button:Click();
            end
    end
    for i=1,#states do
        createButton(frame.main.tabs);
    end    
    
    
    frame:SetScript("OnShow", function(self)
            if(self.main.alwaysOther:GetChecked()) then
                for i=1, #frame.main.tabs.buttons-1 do
                    frame.main.tabs.buttons[i]:Hide();
                end
                frame.main.tabs.title:Hide();
            else
                for i=1, #frame.main.tabs.buttons-1 do
                    frame.main.tabs.buttons[i]:Show();
                end
                frame.main.tabs.title:Show();
            end
        end);
    
    return frame;
end


local function WhisperPopRules()
    return createPopRuleFrame("whisper");
end


local function General_WindowSettings()
    local frame = options.CreateOptionsFrame();
    frame.menu = frame:CreateSection(L["Window Settings"], L["Some settings may be limited by certain skins."]);
    frame.menu.nextOffSetY = -35;
    frame.menu.width = frame.menu:CreateSlider(L["Default Width"], "150", "800", 150, 800, 1, db.winSize, "width", function(self) UpdateAllWindowProps(); end);
    frame.menu.nextOffSetY = -45;
    frame.menu.height = frame.menu:CreateSlider(L["Default Height"], "150", "600", 150, 600, 1, db.winSize, "height", function(self) UpdateAllWindowProps(); end);
    frame.menu.nextOffSetY = -45;
    frame.menu.scale = frame.menu:CreateSlider(L["Window Scale"], "10", "400", 10, 400, 1, db.winSize, "scale", function(self) UpdateAllWindowProps(); end);
    frame.menu.nextOffSetY = -25;
    
    -- window strata
    local stratas = {"BACKGROUND", "LOW", "MEDIUM", "HIGH", "DIALOG", "TOOLTIP"};
    local strataList = {};
    frame.menu.strataText = frame.menu:CreateText();
    frame.menu.strataText:SetText(L["Window Strata:"]);
    for i=1, #stratas do
        table.insert(strataList, {
            text = stratas[i],
            value = stratas[i],
            justifyH = "LEFT",
            func = function(self)
                UpdateAllWindowProps();
            end,
        });
    end
    frame.menu.strataList = frame.menu:CreateDropDownMenu(db.winSize, "strata", strataList, 150);
    frame.menu.strataList:ClearAllPoints();
    frame.menu.strataList:SetPoint("LEFT", frame.menu.strataText, "LEFT", frame.menu.strataText:GetStringWidth(), 0);
    frame.menu.lastObj = frame.menu.strataText;
    frame.menu.nextOffSetY = -5;
    frame.menu.clamp = frame.menu:CreateCheckButton(L["Clamp window to screen."], db, "clampToScreen", nil, function(self) UpdateAllWindowProps(); end);
    frame.menu.nextOffSetY = -10;
    frame.menu:CreateButton(L["Set Window Spawn Location"], ShowDemoWindow);
    frame.menu.nextOffSetY = -10;
    frame.menu.sub = frame.menu:CreateSection();
    options.AddFramedBackdrop(frame.menu.sub);
    local cascade = {L["Up"], L["Down"], L["Left"], L["Right"], L["Up"].." & "..L["Left"], L["Up"].." & "..L["Right"], L["Down"].." & "..L["Left"], L["Down"].." & "..L["Right"]};
    local tsList = {};
    for i=1, #cascade do
        table.insert(tsList, {
            text = cascade[i],
            value = i,
            justifyH = "LEFT",
        });
    end
    frame.menu.sub:CreateCheckButtonMenu(L["Cascade overlapping windows."], db.winCascade, "enabled", nil, nil, tsList, db.winCascade, "direction", nil);
    frame.menu.sub:CreateCheckButton(L["Ignore arrow keys in message box."], db, "ignoreArrowKeys", nil, function(self) UpdateAllWindowProps(); end);
    frame.menu.sub:CreateCheckButton(L["Allow <ESC> to hide windows."], db, "escapeToHide", L["Windows will also be hidden when frames such as the world map are shown."], function(self) UpdateAllWindowProps(); end);
    return frame;
end

local function General_VisualSettings()
    local frame = options.CreateOptionsFrame();
    frame.menu = frame:CreateSection(L["Display Settings"], L["Configure general window display settings."]);
    frame.menu.nextOffSetY = -20;
    frame.menu.skinText = frame.menu:CreateText();
    frame.menu.skinText:SetText(L["Window Skin:"]);
    frame.menu.skinTooltipText = function(theSkin)
            local text, skin  = "", GetSkinTable(theSkin);
            if(skin.version) then text = text.."\n"..L["Version"]..": |cffffffff"..skin.version.."|r"; end
            if(skin.author) then text = text.."\n"..skin.author; end
            if(skin.website) then text = text.."\n"..skin.website; end
            return text;
        end
    local skins = GetRegisteredSkins();
    local skinList = {};
    for i=1, #skins do
        table.insert(skinList, {
            text = skins[i],
            value = skins[i],
            tooltipTitle = skins[i],
            tooltipText = frame.menu.skinTooltipText(skins[i]),
            justifyH = "LEFT",
            func = function(self)
                LoadSkin(self.value);
            end,
        });
    end
    frame.menu.skinList = frame.menu:CreateDropDownMenu(db.skin, "selected", skinList, 150);
    frame.menu.skinList:ClearAllPoints();
    frame.menu.skinList:SetPoint("LEFT", frame.menu.skinText, "LEFT", frame.menu.skinText:GetStringWidth(), 0);
    frame.menu.lastObj = frame.menu.skinText;
    
    frame.menu.nextOffSetY = -15;
    frame.menu:CreateColorPicker(L["Color: System Messages"], db.displayColors, "sysMsg");
    frame.menu:CreateColorPicker(L["Color: Error Messages"], db.displayColors, "errorMsg");
    frame.menu:CreateColorPicker(L["Color: URL - Web Addresses"], db.displayColors, "webAddress");
    frame.menu.nextOffSetY = -10;
    frame.menu:CreateColorPicker(L["Color: History Messages Sent"], db.displayColors, "historyOut");
    frame.menu:CreateColorPicker(L["Color: History Messages Received"], db.displayColors, "historyIn");
    frame.menu.nextOffSetY = -10;
    frame.menu:CreateCheckButton(L["Use colors suggested by skin."], db.displayColors, "useSkin");
    frame.menu.nextOffSetY = -30;
    frame.menu.alpha = frame.menu:CreateSlider(L["Window Alpha"], "1", "100", 1, 100, 1, db, "windowAlpha", function(self) UpdateAllWindowProps(); end);
    frame.menu.nextOffSetY = -35;
    frame.menu.sub = frame.menu:CreateSection();
    options.AddFramedBackdrop(frame.menu.sub);
    frame.menu.sub:CreateCheckButton(L["Enable window fading effects."], db, "winFade");
    frame.menu.sub:CreateCheckButton(L["Enable window animation effects."], db, "winAnimation");
    frame.menu.sub:CreateCheckButton(L["Display item links when hovering over them."], db, "hoverLinks");
    
    return frame;
end

local function General_Fonts()
    local frame = options.CreateOptionsFrame();
    frame.menu = frame:CreateSection(L["Fonts"], L["Configure the fonts used in WIM's message windows."]);
    frame.menu.nextOffSetY = -30;
    
    
    frame.list = frame.menu:ImportCustomObject(CreateFrame("Frame"));
    options.frame.filterList = frame.list;
    options.AddFramedBackdrop(frame.list);
    frame.list:SetFullSize();
    frame.list:SetHeight(4 * 24);
    frame.list.scroll = CreateFrame("ScrollFrame", frame.menu:GetName().."FilterScroll", frame.list, "FauxScrollFrameTemplate");
    frame.list.scroll:SetPoint("TOPLEFT", 0, -1);
    frame.list.scroll:SetPoint("BOTTOMRIGHT", -23, 0);
    frame.list.scroll.update = function(self)
            self = self or _G.this;
            self.flist = self.flist or {};
            for key, _ in pairs(self.flist) do self.flist[key] = nil; end
            local sml = libs.SML.MediaTable.font;
            for font, _ in pairs(sml) do
                table.insert(self.flist, font);
            end
            table.sort(self.flist);
            local offset = _G.FauxScrollFrame_GetOffset(self);
            for i=1, #frame.list.buttons do
                local index = i+offset;
                if(index <= #self.flist) then
                    frame.list.buttons[i]:SetFontItem(self.flist[index]);
                    frame.list.buttons[i]:Show();
                    if(db.skin.font == self.flist[index]) then
                        frame.list.buttons[i]:LockHighlight();
                    else
                        frame.list.buttons[i]:UnlockHighlight();
                    end
                else
                    frame.list.buttons[i]:Hide();
                end
            end
            _G.FauxScrollFrame_Update(self, #self.flist, #frame.list.buttons, 24);
        end
    frame.list.scroll:SetScript("OnVerticalScroll", function(self, offset)
            _G.FauxScrollFrame_OnVerticalScroll(self, offset, 24, frame.list.scroll.update);
        end);
    frame.list:SetScript("OnShow", function(self)
            self.scroll:update();
        end);
    frame.list.createButton = function(self)
            self.buttons = self.buttons or {};
            local button = CreateFrame("Button", nil, self);
            button:SetHeight(24);
            button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD");
            button.title = button:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
            button.title:SetAllPoints();
            button.title:SetJustifyH("LEFT")
            local font, height, flags = button.title:GetFont();
            button.title:SetFont(font, 18, flags);
            button.title:SetTextColor(_G.GameFontNormal:GetTextColor());
            button.title:SetText("Test");
            
            button.SetFontItem = function(self, theFont)
                self.font = theFont;
                self.title:SetText("    "..theFont);
                self.title:SetFont(libs.SML.MediaTable.font[theFont], 18, "");
            end
            
            button:SetScript("OnClick", function(self)
                    _G.PlaySound("igMainMenuOptionCheckBoxOn");
                    db.skin.font = self.font;
                    LoadSkin(db.skin.selected);
                    frame.list:Hide(); frame.list:Show();
                end);
            
            if(#self.buttons == 0) then
                button:SetPoint("TOPLEFT");
                button:SetPoint("TOPRIGHT", -25, 0);
            else
                button:SetPoint("TOPLEFT", self.buttons[#self.buttons], "BOTTOMLEFT");
                button:SetPoint("TOPRIGHT", self.buttons[#self.buttons], "BOTTOMRIGHT");
            end
            
            table.insert(self.buttons, button);
        end
    for i=1, 4 do
        frame.list:createButton();
    end
    
    frame.menu.nextOffSetY = -20;
    frame.menu.outlineText = frame.menu:CreateText();
    frame.menu.outlineText:SetText(L["Font Outline"]..":");
    local outlineList = {
            {text = L["None"],
            value = "",
            justifyH = "LEFT",
            func = function(self)
                LoadSkin(db.skin.selected);
            end},
            {text = L["Thin"],
            value = "OUTLINE",
            justifyH = "LEFT",
            func = function(self)
                LoadSkin(db.skin.selected);
            end},
            {text = L["Thick"],
            value = "THICKOUTLINE",
            justifyH = "LEFT",
            func = function(self)
                LoadSkin(db.skin.selected);
            end},
    };
    frame.menu.outlineList = frame.menu:CreateDropDownMenu(db.skin, "font_outline", outlineList, 150);
    frame.menu.outlineList:ClearAllPoints();
    frame.menu.outlineList:SetPoint("LEFT", frame.menu.outlineText, "LEFT", frame.menu.outlineText:GetStringWidth(), 0);
    frame.menu.lastObj = frame.menu.outlineText;
    
    frame.menu.nextOffSetY = -20;
    frame.menu:CreateCheckButton(L["Use font suggested by skin."], db.skin, "suggest", nil, function(self) LoadSkin(db.skin.selected); end);
    
    frame.menu.nextOffSetY = -60;
    frame.menu:CreateSlider(L["Chat Font Size"], "8", "50", 8, 50, 1, db, "fontSize", function(self) UpdateAllWindowProps(); end);
    
    return frame;
end

local function Whispers_DisplaySettings()
    local frame = options.CreateOptionsFrame();
    frame.menu = frame:CreateSection(L["Display Settings"], L["Configure general display settings when dealing with whispers."]);
    frame.menu.nextOffSetY = -10;
    
    frame.menu:CreateColorPicker(L["Color: Messages Sent"], db.displayColors, "wispOut");
    frame.menu:CreateColorPicker(L["Color: Messages Received"], db.displayColors, "wispIn");
    frame.menu.nextOffSetY = -10;
    frame.menu:CreateColorPicker(L["Color: BNet Messages Sent"], db.displayColors, "BNwispOut");
    frame.menu:CreateColorPicker(L["Color: BNet Messages Received"], db.displayColors, "BNwispIn");
    
    frame.menu.nextOffSetY = -20;
    frame.menu:CreateCheckButton(L["Use colors suggested by skin."], db.displayColors, "useSkin");
    
    frame.menu.nextOffSetY = -20;
    frame.menu:CreateCheckButton(L["Display user class icons and details."], db, "whoLookups", L["Requires who lookups."]);
    frame.menu:CreateCheckButton(L["Display Shortcut Bar"], WIM.modules.ShortcutBar, "enabled", nil, function(self, button) EnableModule("ShortcutBar", self:GetChecked()); end);
    return frame;
end

local function Whispers_Filters(isChat)
    local filterTypes = {L["Pattern"], L["User Type"], L["User Level"]};
    local filterActions = {L["Allow"], L["Ignore"], L["Block"]}
    local frame = options.CreateOptionsFrame();
    local filters = isChat and chatFilters or filters;
    frame.sub = frame:CreateSection((isChat and _G.CHAT..": " or "")..L["Filtering"], L["Filtering allows you to control which messages are handled as well as how they are handlef by WIM."]);
    frame.sub.nextOffSetY = -10;
    frame.sub:CreateCheckButton(L["Enable Filtering"], isChat and WIM.modules.ChatFilters or WIM.modules.Filters, "enabled", nil, function(self, button) EnableModule(isChat and "ChatFilters" or "Filters", self:GetChecked()); end);
    frame.sub.nextOffSetY = -15;
    frame.list = frame.sub:ImportCustomObject(CreateFrame("Frame"));
    if(isChat) then
        options.frame.chatFilterList = frame.list;
    else
        options.frame.filterList = frame.list;
    end
    options.AddFramedBackdrop(frame.list);
    frame.list:SetFullSize();
    frame.list:SetHeight(filterListCount * 32);
    frame.list.scroll = CreateFrame("ScrollFrame", frame.sub:GetName().."FilterScroll", frame.list, "FauxScrollFrameTemplate");
    frame.list.scroll:SetPoint("TOPLEFT", 0, -1);
    frame.list.scroll:SetPoint("BOTTOMRIGHT", -23, 0);
    frame.list.scroll.update = function(self)
            self = self or _G.this;
            local offset = _G.FauxScrollFrame_GetOffset(self);
            for i=1, #frame.list.buttons do
                local index = i+offset;
                if(index <= #filters) then
                    frame.list.buttons[i]:SetFilterIndex(index);
                    frame.list.buttons[i]:Show();
                    if(frame.list.selected == frame.list.buttons[i].index) then
                        frame.list.buttons[i]:LockHighlight();
                    else
                        frame.list.buttons[i]:UnlockHighlight();
                    end
                else
                    frame.list.buttons[i]:Hide();
                end
            end
            _G.FauxScrollFrame_Update(self, #filters, #frame.list.buttons, 32);
            if(not frame.list.selected) then
                frame.edit:Disable();
                frame.delete:Disable();
            else
                frame.edit:Enable();
                if(frame.list.selected and filters[frame.list.selected] and filters[frame.list.selected].protected) then
                    frame.delete:Disable();
                else
                    frame.delete:Enable();
                end
            end
        end
    frame.list.scroll:SetScript("OnVerticalScroll", function(self, offset)
            _G.FauxScrollFrame_OnVerticalScroll(self, offset, 32, frame.list.scroll.update);
        end);
    frame.list:SetScript("OnShow", function(self)
            self.scroll:update();
        end);
    frame.list.createButton = function(self)
            self.buttons = self.buttons or {};
            local button = CreateFrame("Button", nil, self);
            button:SetHeight(32);
            button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD");
            button.cb = CreateFrame("CheckButton", nil, button, "UICheckButtonTemplate");
            button.cb:SetPoint("TOPLEFT");
            button.cb:SetScale(.75);
            button.cb:SetScript("OnClick", function(self)
                    self:GetParent().filter.enabled = self:GetChecked() and true or false;
                    frame.list:Hide(); frame.list:Show();
                end);
            button.title = button:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
            button.title:SetPoint("TOPLEFT", button.cb, "TOPRIGHT", 0, -4);
            button.title:SetPoint("RIGHT");
            button.title:SetJustifyH("LEFT")
            button.title:SetTextColor(_G.GameFontNormal:GetTextColor());
            button.title:SetText("Test Filter |cffffffff- User Type|r");
            button.action = button:CreateFontString(nil, "OVERLAY", "ChatFontSmall");
            button.action:SetPoint("TOPLEFT", button.title, "BOTTOMLEFT", 0, 0);
            button.action:SetText("Action: Ignore");
            button.stats = button:CreateFontString(nil, "OVERLAY", "ChatFontSmall");
            button.stats:SetPoint("TOPLEFT", button.action, "TOPRIGHT");
            button.stats:SetPoint("RIGHT");
            button.stats:SetJustifyH("RIGHT");
            button.stats:SetText("Total Filtered: 100");
            button.down = CreateFrame("Button", nil, button);
            button.down:SetWidth(14); button.down:SetHeight(14);
            button.down:SetPoint("TOPRIGHT", 0, 0);
            button.down:SetNormalTexture("Interface\\AddOns\\"..addonTocName.."\\Sources\\Options\\Textures\\down");
            button.down:SetHighlightTexture("Interface\\AddOns\\"..addonTocName.."\\Sources\\Options\\Textures\\down", "ADD");
            button.down:SetScript("OnClick", function(self)
                    local index = self:GetParent().index;
                    filters[index], filters[index+1] = filters[index+1], filters[index];
                    if(frame.list.selected == index) then frame.list.selected = frame.list.selected + 1; end
                    frame.list:Hide(); frame.list:Show();
                end);
            button.up = CreateFrame("Button", nil, button);
            button.up:SetWidth(14); button.up:SetHeight(14);
            button.up:SetPoint("RIGHT", button.down, "LEFT", -5, 0);
            button.up:SetNormalTexture("Interface\\AddOns\\"..addonTocName.."\\Sources\\Options\\Textures\\up");
            button.up:SetHighlightTexture("Interface\\AddOns\\"..addonTocName.."\\Sources\\Options\\Textures\\up", "ADD");
            button.up:SetScript("OnClick", function(self)
                    local index = self:GetParent().index;
                    filters[index], filters[index-1] = filters[index-1], filters[index];
                    if(frame.list.selected == index) then frame.list.selected = frame.list.selected - 1; end
                    frame.list:Hide(); frame.list:Show();
                end);
            
            button.SetFilterIndex = function(self, index)
                self.index = index;
                self.filter = filters[index];
                local alpha = self.filter.enabled and 1 or .65;
                self.title:SetText(self.filter.name.."|cffffffff - "..filterTypes[self.filter.type]..(self.filter.protected and " ("..L["Protected"]..")" or "").."|r");
                self.title:SetAlpha(alpha);
                self.action:SetText(L["Action:"].." "..filterActions[self.filter.action]);
                self.action:SetAlpha(alpha);
                self.cb:SetChecked(self.filter.enabled);
                self.stats:SetText(L["Occurrences:"].." "..(self.filter.stats or "0"));
                self.stats:SetAlpha(alpha);
                if(index == 1) then self.up:Hide(); else self.up:Show(); end
                if(index == #filters) then self.down:Hide(); else self.down:Show(); end
            end
            
            button:SetScript("OnClick", function(self)
                    _G.PlaySound("igMainMenuOptionCheckBoxOn");
                    frame.list.selected = self.index;
                    frame.list:Hide(); frame.list:Show();
                end);
            
            if(#self.buttons == 0) then
                button:SetPoint("TOPLEFT");
                button:SetPoint("TOPRIGHT", -25, 0);
            else
                button:SetPoint("TOPLEFT", self.buttons[#self.buttons], "BOTTOMLEFT");
                button:SetPoint("TOPRIGHT", self.buttons[#self.buttons], "BOTTOMRIGHT");
            end
            
            table.insert(self.buttons, button);
        end
    for i=1, filterListCount do
        frame.list:createButton();
    end
    frame.nextOffSetY = -5;
    frame.add = frame:CreateButton(L["Add Filter"], function(self) ShowFilterFrame(nil, nil, isChat); end);
    frame.edit = frame:CreateButton(L["Edit Filter"], function(self) ShowFilterFrame(filters[frame.list.selected], frame.list.selected, isChat); end);
    frame.edit:ClearAllPoints();
    frame.edit:SetPoint("LEFT", frame.add, "RIGHT", 0, 0);
    frame.delete = frame:CreateButton(L["Delete Filter"], function(self)
            table.remove(filters, frame.list.selected);
            if(frame.list.selected == 1) then
                if(#filters > 0) then frame.list.selected = 1 else frame.list.selected = nil; end
            else
                frame.list.selected = frame.list.selected - 1;
            end
            frame.list:Hide(); frame.list:Show();
        end);
    frame.delete:ClearAllPoints();
    frame.delete:SetPoint("TOP", frame.edit, "TOP");
    frame.delete:SetPoint("RIGHT", 0, 0);
    return frame;
end

local function General_History(isChat)
    local historyDB = isChat and db.history.chat or db.history;
    local f = options.CreateOptionsFrame();
    f.sub = f:CreateSection((isChat and _G.CHAT..": " or "")..L["History"], L["WIM can store conversations to be viewed at a later time."]);
    f.sub.nextOffSetY = -10;
    f.sub:CreateCheckButton(L["Enable History"], isChat and WIM.modules.HistoryChat or WIM.modules.History, "enabled", nil, function(self, button) EnableModule(isChat and "HistoryChat" or "History", self:GetChecked()); end);
    f.sub.nextOffSetY = -15;
    local tsList = {};
    for i=1, 10 do
        table.insert(tsList, {
            text = (i*5).." "..L["Messages"],
            value = (i*5),
            justifyH = "LEFT",
        });
    end
    f.sub:CreateCheckButtonMenu(L["Preview history inside message windows."], historyDB, "preview", nil, nil, tsList, historyDB, "previewCount");
    f.sub.nextOffSetY = -15;

    if(not isChat) then
        f.sub:CreateCheckButton(L["Record Friends"], historyDB.whispers, "friends");
        f.sub:CreateCheckButton(L["Record Guild"], historyDB.whispers, "guild");
        f.sub:CreateCheckButton(L["Record Everyone"], historyDB.whispers, "all");
    else
        f.sub.col1 = f.sub:CreateCheckButton(_G.GUILD, historyDB, "guild");
        f.sub:CreateCheckButton(_G.GUILD_RANK1_DESC, historyDB, "officer");
        f.sub:CreateCheckButton(_G.PARTY, historyDB, "party");
        f.sub:CreateCheckButton(_G.RAID, historyDB, "raid");
        
        f.sub.col2 = f.sub:CreateCheckButton(_G.SAY, historyDB, "say");
        f.sub.col2:ClearAllPoints();
        f.sub.col2:SetPoint("TOPLEFT", f.sub.col1, 200, 0);
        f.sub:CreateCheckButton(_G.BATTLEGROUND, historyDB, "battleground");
        f.sub:CreateCheckButton(L["World Chat"], historyDB, "world");
        f.sub:CreateCheckButton(L["Custom Chat"], historyDB, "custom");
    end
    --[[f.sub.chat = f.sub:CreateCheckButton(L["Record Chat"], db.history.chat, "enabled");
    f.sub.chat:ClearAllPoints();
    f.sub.chat:SetPoint("TOPLEFT", f.sub.whispers, 200, 0);
    f.sub.chat:CreateCheckButton(L["Record Friends"], db.history.chat, "friends");
    f.sub.chat:CreateCheckButton(L["Record Guild"], db.history.chat, "guild");
    f.sub.chat:CreateCheckButton(L["Record Everyone"], db.history.chat, "all");
    f.sub.chat:Disable();
    f.sub.lastObj = f.sub.whispers;]]
    
    f.maint = f:CreateSection(L["Maintenance"], L["Allowing your history logs to grow too large will affect the game's performance, therefore it is reccomended that you use the following options."]);
    f.maint:ClearAllPoints();
    f.maint:SetFullSize();
    f.maint:SetPoint("BOTTOM", 0, 10);
    local countList = {100, 200, 500, 1000};
    tsList = {};
    for i=1, #countList do
        table.insert(tsList, {
            text = countList[i].." "..L["Messages"],
            value = countList[i],
            justifyH = "LEFT",
        });
    end
    f.maint.nextOffSetY = -10;
    f.maint:CreateCheckButtonMenu(L["Save a maximum number of messages per person."], historyDB, "maxPer", nil, nil, tsList, db.history, "maxCount");
    --f.maint.nextOffSetY = -10;
    local tsList2 = {};
    for i=1, 5 do
        table.insert(tsList2, {
            text = _G.format(L["%d |4Week:Weeks;"], i),
            value = 60*60*24*7*i,
            justifyH = "LEFT",
        });
    end
    f.maint:CreateCheckButtonMenu(L["Automatically delete old messages."], historyDB, "ageLimit", nil, nil, tsList2, db.history, "maxAge");
    return f;
end


local function W2W_Main()
    local f = options.CreateOptionsFrame();
    f.sub = f:CreateSection("WIM-2-WIM (W2W)", L["WIM-2-WIM is a feature which allows users with WIM to interact in ways that normal whispering can not."]);
    f.sub.nextOffSetY = -10;
    f.sub:CreateCheckButton(L["Enable WIM-2-WIM"], WIM.modules.W2W, "enabled", nil, function(self, button) EnableModule("W2W", self:GetChecked()); end);
    f.sub.nextOffSetY = -15;
    return f;
end

local function W2W_Privacy()
    local f = options.CreateOptionsFrame();
    f.sub = f:CreateSection(L["Privacy"], L["Restrict the data that is shared."]);
    f.sub.nextOffSetY = -10;
    f.sub:CreateCheckButton(L["Allow others to see me typing."], db.w2w, "shareTyping", nil, function(self, button) UpdateAllServices(); end);
    f.sub:CreateCheckButton(L["Allow others to see my location."], db.w2w, "shareCoordinates", nil, function(self, button) UpdateAllServices(); end);
    f.sub:CreateCheckButton(L["Allow others to see my talent spec."], db.w2w, "shareTalentSpec", nil, function(self, button) UpdateAllServices(); end);
    f.sub.nextOffSetY = -15;
    return f;
end

local function General_Tabs()
    local f = options.CreateOptionsFrame();
    f.sub = f:CreateSection(L["Tab Management"], L["Automatically manage your open windows and place them into appropriate tab groups."]);
    f.sub.nextOffSetY = -20;
    
    f.sub.sortText = f.sub:CreateText();
    f.sub.sortText:SetText(L["Sort tabs by:"]);
    local sorts = {L["Window Created"], L["Last Activity"], L["Alphabetical"]};
    local sortList = {};
    for i=1, #sorts do
        table.insert(sortList, {
            text = sorts[i],
            value = i,
            justifyH = "LEFT",
            func = function(self)
                UpdateAllTabs();
            end,
        });
    end
    f.sub.sortList = f.sub:CreateDropDownMenu(db.tabs, "sortBy", sortList, 150);
    f.sub.sortList:ClearAllPoints();
    f.sub.sortList:SetPoint("LEFT", f.sub.sortText, "LEFT", f.sub.sortText:GetStringWidth(), 0);
    f.sub.lastObj = f.sub.sortText;
    
    f.sub.nextOffSetY = -30;
    f.sub.whispers = f.sub:CreateCheckButton(L["Automatically group whispers."], db.tabs.whispers, "enabled", L["Does not apply to windows already opened."]);
    f.sub.whispers:CreateCheckButton(L["Place friends in their own group."], db.tabs.whispers, "friends", L["Does not apply to windows already opened."]);
    f.sub.whispers:CreateCheckButton(L["Place guild members in their own group."], db.tabs.whispers, "guild", L["Does not apply to windows already opened."]);
    f.sub.nextOffSetY = -80;
    f.sub.chat = f.sub:CreateCheckButton(L["Automatically group chat windows."], db.tabs.chat, "enabled", L["Does not apply to windows already opened."]);
    f.sub.chat:CreateCheckButton(L["Group with whisper windows."], db.tabs.chat, "aswhisper", L["Does not apply to windows already opened."]);
    return f;
end


local function General_Sounds(isChat)
    local f = options.CreateOptionsFrame();
    f.sub = f:CreateSection((isChat and _G.CHAT..": " or "")..L["Sounds"], L["Configure various sound events and how they are triggered."]);
    f.sub.nextOffSetY = -20;
    local soundList = {};

    local whisperCount = 5;
    local chatCount = 11;

    for i = 1, (isChat and chatCount or whisperCount) do
        soundList[i] = {};
        for sound, _ in pairs(libs.SML.MediaTable.sound) do
            table.insert(soundList[i], {
                text = sound,
                value = sound,
                justifyH = "LEFT",
                func = function(self)
                    _G.PlaySoundFile(libs.SML:Fetch(libs.SML.MediaType.SOUND, self.value));
                end
            });
        end
    end
    if(isChat) then
        f.sub.chat = f.sub:CreateCheckButtonMenu(L["Play sound when a message is received."], db.sounds.chat, "msgin", nil, nil, soundList[1], db.sounds.chat, "msgin_sml");
        f.sub.chat:CreateCheckButtonMenu(L["Play special sound for %s."]:format(_G.GUILD), db.sounds.chat, "guild", nil, nil, soundList[2], db.sounds.chat, "guild_sml");
        f.sub.chat:CreateCheckButtonMenu(L["Play special sound for %s."]:format(_G.GUILD_RANK1_DESC), db.sounds.chat, "officer", nil, nil, soundList[3], db.sounds.chat, "officer_sml");
        f.sub.chat:CreateCheckButtonMenu(L["Play special sound for %s."]:format(_G.PARTY), db.sounds.chat, "party", nil, nil, soundList[4], db.sounds.chat, "party_sml");
        f.sub.chat:CreateCheckButtonMenu(L["Play special sound for %s."]:format(_G.RAID), db.sounds.chat, "raid", nil, nil, soundList[5], db.sounds.chat, "raid_sml");
        f.sub.chat:CreateCheckButtonMenu(L["Play special sound for %s."]:format(_G.RAID_LEADER), db.sounds.chat, "raidleader", nil, nil, soundList[6], db.sounds.chat, "raidleader_sml");
        f.sub.chat:CreateCheckButtonMenu(L["Play special sound for %s."]:format(_G.BATTLEGROUND), db.sounds.chat, "battleground", nil, nil, soundList[5], db.sounds.chat, "battleground_sml");
        f.sub.chat:CreateCheckButtonMenu(L["Play special sound for %s."]:format(_G.BATTLEGROUND_LEADER), db.sounds.chat, "battlegroundleader", nil, nil, soundList[6], db.sounds.chat, "battleground_sml");
        f.sub.chat:CreateCheckButtonMenu(L["Play special sound for %s."]:format(_G.SAY), db.sounds.chat, "say", nil, nil, soundList[7], db.sounds.chat, "say_sml");
        f.sub.chat:CreateCheckButtonMenu(L["Play special sound for %s."]:format(L["World Chat"]), db.sounds.chat, "world", nil, nil, soundList[8], db.sounds.chat, "world_sml");
        f.sub.chat:CreateCheckButtonMenu(L["Play special sound for %s."]:format(L["Custom Chat"]), db.sounds.chat, "custom", nil, nil, soundList[9], db.sounds.chat, "custom_sml");
        f.sub.nextOffSetY = -300;
        f.sub:CreateCheckButtonMenu(L["Play sound when a message is sent."], db.sounds.chat, "msgout", nil, nil, soundList[10], db.sounds.chat, "msgout_sml");
    else
        f.sub.whispers = f.sub:CreateCheckButtonMenu(L["Play sound when a whisper is received."], db.sounds.whispers, "msgin", nil, nil, soundList[1], db.sounds.whispers, "msgin_sml");
        f.sub.whispers:CreateCheckButtonMenu(L["Play special sound for battle.net friends."], db.sounds.whispers, "bnet", nil, nil, soundList[5], db.sounds.whispers, "bnet_sml");
        f.sub.whispers:CreateCheckButtonMenu(L["Play special sound for friends."], db.sounds.whispers, "friend", nil, nil, soundList[2], db.sounds.whispers, "friend_sml");
        f.sub.whispers:CreateCheckButtonMenu(L["Play special sound for guild members."], db.sounds.whispers, "guild", nil, nil, soundList[3], db.sounds.whispers, "guild_sml");
        f.sub.nextOffSetY = -90;
        f.sub:CreateCheckButtonMenu(L["Play sound when a whisper is sent."], db.sounds.whispers, "msgout", nil, nil, soundList[4], db.sounds.whispers, "msgout_sml");
    end
    return f;
end

local function General_Expose()
    local frame = options.CreateOptionsFrame();
    frame.menu = frame:CreateSection(L["Expose"], L["Expose is a Mac OS X inspired feature which enables you to quickly clear your screen of windows and then restore them back to their original position."]);
    frame.menu.nextOffSetY = -20;
    
    local cb1 = frame.menu:CreateCheckButton(L["Auto hide/restore windows during combat."], db.expose, "combat");
    cb1:CreateCheckButton(L["Delay if I am typing a message."], db.expose, "protect");
    cb1:CreateCheckButton(L["Only while in an instance."], db.expose, "groupOnly");
    frame.menu.nextOffSetY = -90;
    
    local direction = {L["Up"], L["Down"], L["Left"], L["Right"]};
    local tsList = {};
    for i=1, #direction do
        table.insert(tsList, {
            text = direction[i],
            value = i,
            justifyH = "LEFT",
        });
    end
    frame.menu.directionText = frame.menu:CreateText();
    frame.menu.directionText:SetText(L["Animation Direction:"]);
    frame.menu.direction = frame.menu:CreateDropDownMenu(db.expose, "direction", tsList, 100);
    frame.menu.direction:ClearAllPoints();
    frame.menu.direction:SetPoint("LEFT", frame.menu.directionText, "LEFT", frame.menu.directionText:GetStringWidth(), 0);
    frame.menu.lastObj = frame.menu.directionText;
    frame.menu.nextOffSetY = -40;
    frame.menu:CreateCheckButton(L["Show Border"], db.expose, "border");
    frame.menu.nextOffSetY = -20;
    frame.menu.size = frame.menu:CreateSlider(L["Border Size"], "1", "200", 1, 200, 1, db.expose, "borderSize");
    return frame;
end

local function General_Credits()
    local frame = options.CreateOptionsFrame();
    frame.menu = frame:CreateSection(L["Credits"]);
    frame.menu.nextOffSetY = -20;
    
    frame.menu.createdBy = frame.menu:CreateSection("|cff69ccf0"..L["Created By:"].."|r", credits[1]);
    frame.menu.nextOffSetY = -20;
    
    frame.menu.createdBy = frame.menu:CreateSection("|cff69ccf0"..L["Special Thanks:"].."|r", credits[2]);
    
    return frame;
end

local function ChatPopRules()
    return createPopRuleFrame("chat");
end

RegisterOptionFrame(L["General"], L["Main"], General_Main);
RegisterOptionFrame(L["General"], L["Window Settings"], General_WindowSettings);
RegisterOptionFrame(L["General"], L["Display Settings"], General_VisualSettings);
RegisterOptionFrame(L["General"], L["Fonts"], General_Fonts);
RegisterOptionFrame(L["General"], L["Message Formatting"], General_MessageFormatting);
RegisterOptionFrame(L["General"], L["Tab Management"], General_Tabs);
RegisterOptionFrame(L["General"], L["Expose"], General_Expose);
RegisterOptionFrame(L["General"]);
RegisterOptionFrame(L["General"], L["Credits"], General_Credits);

RegisterOptionFrame(L["Whispers"], L["Display Settings"], Whispers_DisplaySettings);
RegisterOptionFrame(L["Whispers"], L["History"], General_History);
RegisterOptionFrame(L["Whispers"], L["Filtering"], Whispers_Filters);
RegisterOptionFrame(L["Whispers"], L["Sounds"], General_Sounds);
RegisterOptionFrame(L["Whispers"], L["Window Behavior"], WhisperPopRules);

RegisterOptionFrame(L["Chat"], L["History"], function() return General_History(true); end);
RegisterOptionFrame(L["Chat"], L["Filtering"], function() return Whispers_Filters(true); end);
RegisterOptionFrame(L["Chat"], L["Sounds"], function() return General_Sounds(true); end);
RegisterOptionFrame(L["Chat"], L["Window Behavior"], ChatPopRules);
RegisterOptionFrame(L["Chat"]); -- breaker

RegisterOptionFrame("WIM-2-WIM", L["General"], W2W_Main);
RegisterOptionFrame("WIM-2-WIM", L["Privacy"], W2W_Privacy);
