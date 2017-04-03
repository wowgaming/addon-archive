--imports
local WIM = WIM;
local _G = _G;
local Notes = WIM.Notifications;
local NoteIndex = 1;

--set namespace
setfenv(1, WIM);

local LDB = CreateModule("LDB", true);

local isLdbLoaded = false;
local icon = "Interface\\Addons\\"..addonTocName.."\\Skins\\Default\\minimap";
local iconNew = "Interface\\Addons\\"..addonTocName.."\\Skins\\Default\\minimap_new";
local data = {
    type = "data source",
    text = "", --L["No New Messages"],
    icon = icon,
    OnClick = function(frame, button)
	if(button == "LeftButton") then
            Menu:ClearAllPoints();
            if(Menu:IsShown()) then
                Menu:Hide();
            else
                Menu:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 0);
                Menu:Show();
            end
        else
            if(db.minimap.rightClickNew) then
                if(_G.IsShiftKeyDown()) then
                    -- display tools menu
                    PopContextMenu("MENU_MINIMAP", frame:GetName());
                else
                    ShowAllUnreadWindows();
                end
            else
                if(_G.IsShiftKeyDown()) then
                    ShowAllUnreadWindows();
                else
                    -- display tools menu
                    PopContextMenu("MENU_MINIMAP", frame:GetName());
                end
            end
        end
    end,
    OnTooltipShow = function(tooltip)
	tooltip:AddLine("WIM |cff00ff00(v"..version..")|r");
        for i=1, #Notes do
            tooltip:AddDoubleLine("|cff"..Notes[i].color..Notes[i].tag..":|r", "|cffffffff"..Notes[i].text.."|r");
        end
    end,
};

LDB:RegisterEvent("ADDON_LOADED");

local function setText(text)
    if(data.text ~= text) then
        data.text = text;
        return true;
    end
end

local updateFrame = _G.CreateFrame("Frame");
updateFrame.timer = 0;
updateFrame.icon = true;
updateFrame:SetScript("OnUpdate", function(self, elapsed)
    if(isLdbLoaded) then
        self.timer = self.timer + elapsed;
        while(self.timer >= 1) do
            if(#Notes > 0) then
                if(Notes[NoteIndex]) then
                    setText(Notes[NoteIndex].tag..": "..Notes[NoteIndex].text);
                else
                    NoteIndex = 0;
                end
                self.icon = not self.icon;
                if(self.icon) then
                    -- show icon
                    data.icon = icon;
                else
                    -- show variant
                    data.icon = iconNew;
                end
            else
                self.icon = true;
                if(setText(L["No New Messages"])) then
                    -- set normal icon
                    data.icon = icon;
                end
                NoteIndex = 0;
            end
            NoteIndex = NoteIndex + 1;
            self.timer = 0;
        end
    end
end);


local function loadLDB()
    -- if data source is not registered yet and ldb exists, register it.
    if(not isLdbLoaded and _G.LibStub:GetLibrary("LibDataBroker-1.1", true)) then
        _G.LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("WIM", data);
        isLdbLoaded = true;
    end
end

function LDB:OnEnable()
    loadLDB();
end

function LDB:ADDON_LOADED(...)
    -- see if LDB is loaded
    loadLDB();
end

-- There really isn't a reason as to why you would want this disabled.
LDB.canDisable = false;
LDB:Enable();