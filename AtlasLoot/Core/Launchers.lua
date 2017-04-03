--[[
Name        : AtlasLootFu
Version     : 2.0
Author      : Daviesh (oma_daviesh@hotmail.com)
Website     : http://www.atlasloot.net
Description : Adds AtlasLoot to FuBar.
]]

--Invoke libraries
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

--Make an LDB object
LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("AtlasLoot", {
    type = "launcher",
    icon = "Interface\\Icons\\INV_Box_01",
    OnClick = function()
        if IsShiftKeyDown() then
            AtlasLootOptions_Toggle();
        else
            if AtlasLootDefaultFrame:IsVisible() then
                AtlasLootDefaultFrame:Hide();
            else
                AtlasLootDefaultFrame:Show();
            end
        end
    end,
})

function AtlasLoot_OnBarButtonClick(button)
    if IsShiftKeyDown() then
        AtlasLootOptions_Toggle();
    else
        if AtlasLootDefaultFrame:IsVisible() then
            AtlasLootDefaultFrame:Hide();
        else
            AtlasLootDefaultFrame:Show();
        end
    end
end

--[[function AtlasLoot_MinimapButtonInit()
    if AtlasLootMinimapButtonFrame then
	    if IsAddOnLoaded("FuBar") then
            AtlasLootMinimapButtonFrame:SetPoint("CENTER", "UIParent", "CENTER");
            AtlasLootMinimapButtonFrame:Hide();
        elseif(AtlasLoot.db.profile.MinimapButton == true) then
            AtlasLootMinimapButtonFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",54 - (78 * cos(AtlasLoot.db.profile.MinimapButtonAngle)),(78 * sin(AtlasLoot.db.profile.MinimapButtonAngle)) - 55);
		    AtlasLootMinimapButtonFrame:Show();
	    else
		    AtlasLootMinimapButtonFrame:SetPoint("CENTER", "UIParent", "CENTER");
            AtlasLootMinimapButtonFrame:Hide();
	    end
    end
end

function AtlasLoot_MinimapButtonOnEnter()
    GameTooltip:SetOwner(this, "ANCHOR_LEFT");
    GameTooltip:SetText(string.sub(ATLASLOOT_VERSION, 11, 28));
    GameTooltip:AddLine(AL["|cff1eff00Left-Click|r Browse Loot Tables"]);
    GameTooltip:AddLine(AL["|cffff0000Shift-Click|r View Options"]);
    GameTooltip:AddLine(AL["|cffccccccRight-Click + Drag|r Move Minimap Button"]);
    GameTooltip:Show();
end

-- Thanks to Yatlas and Atlas for this code
function AtlasLoot_MinimapButtonBeingDragged()
    -- Thanks to Gello and Dan Gilbert for this code
    local xpos,ypos = GetCursorPosition() 
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom() 

    xpos = xmin-xpos/UIParent:GetScale()+70 
    ypos = ypos/UIParent:GetScale()-ymin-70 

    AtlasLoot_MinimapButtonSetPosition(math.deg(math.atan2(ypos,xpos)));
end

function AtlasLoot_MinimapButtonSetPosition(v)
    if(v < 0) then
        v = v + 360;
    end

    AtlasLoot.db.profile.MinimapButtonAngle = v;
    AtlasLoot_MinimapButtonUpdatePosition();
end

function AtlasLoot_MinimapButtonUpdatePosition()
	local radius = AtlasLoot.db.profile.MinimapButtonRadius;
    AtlasLootMinimapButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (radius * cos(AtlasLoot.db.profile.MinimapButtonAngle)),
		(radius * sin(AtlasLoot.db.profile.MinimapButtonAngle)) - 55
	);
    if(AtlasLoot.db.profile.MinimapButton == true) then
        AtlasLootMinimapButtonFrame:Show();
    else
        AtlasLootMinimapButtonFrame:Hide();
    end
end]]

--[[if IsAddOnLoaded("FuBar") then
    if AtlasLootMinimapButtonFrame then
        AtlasLootMinimapButtonFrame:SetPoint("CENTER", "UIParent", "CENTER");
        AtlasLootMinimapButtonFrame:Hide();
    end
    
    AtlasLootFu = LibStub("AceAddon-3.0"):NewAddon("AtlasLootFu");

    AceDB = LibStub("AceDB-3.0");

    AtlasLootFu.db = AceDB:New("AtlasLootFuDB");

    LibStub("AceAddon-3.0"):EmbedLibrary(AtlasLootFu, "LibFuBarPlugin-Mod-3.0", true);

    AtlasLootFu:SetFuBarOption("tooltipType", "GameTooltip");
    --AtlasLootFu:SetFuBarOption("configType", "Dewdrop-2.0");
    AtlasLootFu:SetFuBarOption("iconPath", "Interface\\Icons\\INV_Box_01");
    --AtlasLootFu:SetFuBarOption("defaultMinimapPosition", 220);
    AtlasLootFu:SetFuBarOption("cannotDetachTooltip", true);
    AtlasLootFu:SetFuBarOption("hasNoColor", true);

    --Make sure the plugin is the rightt format when activated
    function AtlasLootFu:OnEnable()
        self:UpdateFuBarPlugin();
    end

    --Define text to display when the cursor mouses over the plugin
    function AtlasLootFu:OnUpdateFuBarTooltip()
        GameTooltip:AddLine(AL["|cff1eff00Left-Click|r Browse Loot Tables"]);
        GameTooltip:AddLine(AL["|cffff0000Shift-Click|r View Options"]);
        GameTooltip:AddLine(AL["|cffccccccLeft-Click + Drag|r Move Minimap Button"]);
    end

    --Define what to do when the plugin is clicked
    function AtlasLootFu:OnFuBarClick(button)
        --Left click -> open loot browser
        --Shift Left Click -> show options menu
        --Right click -> standard FuBar options
        AtlasLoot_OnBarButtonClick(button);
    end
    
    function AtlasLootFu:OpenMenu()
        AtlasLootOptions_Toggle();
    end
    
end]]
