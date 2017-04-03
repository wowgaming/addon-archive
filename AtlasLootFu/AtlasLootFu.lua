--[[
Name        : AtlasLootFu
Version     : 1.1
Author      : Daviesh (oma_daviesh@hotmail.com)
Website     : http://www.atlasloot.net
Description : Adds AtlasLoot to FuBar.
]]

--Invoke libraries
local tablet = AceLibrary("Tablet-2.0");

--Define the plugin
AtlasLootFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0");
AtlasLootFu.title = "AtlasLootFu";
AtlasLootFu.hasIcon = "Interface\\Icons\\INV_Box_01";
AtlasLootFu.defaultPosition = "LEFT";
AtlasLootFu.defaultMinimapPosition = 180;
AtlasLootFu.cannotDetachTooltip = true;

-- Activate menu options to hide icon/text (no point in having the colour option)
AtlasLootFu.hasNoColor = true;
AtlasLootFu:RegisterDB("AtlasLootFuDB");

--Make sure the plugin is the rightt format when activated
function AtlasLootFu:OnEnable()
    self:Update();
end

--Define text to display when the cursor mouses over the plugin
function AtlasLootFu:OnTooltipUpdate()
	local cat = tablet:AddCategory()
		cat:AddLine(
			"text", ATLASLOOTFU_LEFTCLICK
		)
		cat:AddLine(
			"text", ATLASLOOTFU_SHIFTCLICK
		)
        cat:AddLine(
			"text", ATLASLOOTFU_LEFTDRAG
		)
end

--Define what to do when the plugin is clicked
function AtlasLootFu:OnClick(button)
    --Left click -> open loot browser
    --Shift Left Click -> show options menu
    --Right click -> standard FuBar options
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
