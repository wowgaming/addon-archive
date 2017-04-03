--[[
Options.lua
Functions:
AtlasLoot_OptionsPanelOnLoad(panel)
AtlasLootOptions_Init()
AtlasLootOptions_OnLoad()
AtlasLootOptions_SafeLinksToggle()
AtlasLootOptions_AllLinksToggle()
AtlasLootOptions_DefaultTTToggle()
AtlasLootOptions_LootlinkTTToggle()
AtlasLootOptions_ItemSyncTTToggle()
AtlasLootOptions_EquipCompareToggle()
AtlasLootOptions_OpaqueToggle()
AtlasLootOptions_ItemIDToggle()
AtlasLootOptions_ItemSpam()
AtlasLootOptions_MinimapToggle()
AtlasLootOptions_LoDSpam()
AtlasLootOptions_LoDStartup()
AtlasLoot_SetupLootBrowserSlider(frame, mymin, mymax, step)
AtlasLoot_UpdateLootBrowserSlider(frame)
AtlasLoot_DisplayHelp();
AtlasLoot_CreateOptionsInfoTooltips()
]]

local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

--Invoke libraries
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

function AtlasLoot_OptionsPanelOnLoad(panel)
    panel.name=AL["AtlasLoot"];
    InterfaceOptions_AddCategory(panel);
end

function AtlasLootOptions_Init()
    --Initialise all the check boxes on the options frame
    AtlasLootOptionsFrameSafeLinks:SetChecked(AtlasLoot.db.profile.SafeLinks);
	AtlasLootOptionsFrameDefaultTT:SetChecked(AtlasLoot.db.profile.DefaultTT);
	AtlasLootOptionsFrameLootlinkTT:SetChecked(AtlasLoot.db.profile.LootlinkTT);
	AtlasLootOptionsFrameItemSyncTT:SetChecked(AtlasLoot.db.profile.ItemSyncTT);
    AtlasLootOptionsFrameEquipCompare:SetChecked(AtlasLoot.db.profile.EquipCompare);
    AtlasLootOptionsFrameOpaque:SetChecked(AtlasLoot.db.profile.Opaque);
    AtlasLootOptionsFrameItemID:SetChecked(AtlasLoot.db.profile.ItemIDs);
    AtlasLootOptionsFrameItemSpam:SetChecked(AtlasLoot.db.profile.ItemSpam);
    AtlasLootOptionsFrameLoDStartup:SetChecked(AtlasLoot.db.profile.LoadAllLoDStartup);
    AtlasLootOptionsFrameHidePanel:SetChecked(AtlasLoot.db.profile.HidePanel);
    AtlasLootOptionsFrameLootBrowserScale:SetValue(AtlasLoot.db.profile.LootBrowserScale);
end

function AtlasLootOptions_OnLoad()
    --Disable checkboxes of missing addons
    if( not LootLink_SetTooltip ) then
        AtlasLootOptionsFrameLootlinkTT:Disable();
        AtlasLootOptionsFrameLootlinkTTText:SetText(AL["|cff9d9d9dLootlink Tooltips|r"]);
    end
    if( not ItemSync ) then
        AtlasLootOptionsFrameItemSyncTT:Disable();
        AtlasLootOptionsFrameItemSyncTTText:SetText(AL["|cff9d9d9dItemSync Tooltips|r"]);
    end
    AtlasLootOptions_Init();
    temp=AtlasLoot.db.profile.SafeLinks;
end

function AtlasLootOptions_SafeLinksToggle()
	if(AtlasLoot.db.profile.SafeLinks) then
		AtlasLoot.db.profile.SafeLinks = false;
        AtlasLoot.db.profile.AllLinks = true;
	else
		AtlasLoot.db.profile.SafeLinks = true;
        AtlasLoot.db.profile.AllLinks = false;
	end
	AtlasLootOptions_Init();
end

function AtlasLootOptions_DefaultTTToggle()
	AtlasLoot.db.profile.DefaultTT = true;
    AtlasLoot.db.profile.LootlinkTT = false;
    AtlasLoot.db.profile.ItemSyncTT = false;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_LootlinkTTToggle()
	AtlasLoot.db.profile.DefaultTT = false;
    AtlasLoot.db.profile.LootlinkTT = true;
    AtlasLoot.db.profile.ItemSyncTT = false;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_ItemSyncTTToggle()
    AtlasLoot.db.profile.DefaultTT = false;
    AtlasLoot.db.profile.LootlinkTT = false;
    AtlasLoot.db.profile.ItemSyncTT = true;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_OpaqueToggle()
    AtlasLoot.db.profile.Opaque=AtlasLootOptionsFrameOpaque:GetChecked();
    if (AtlasLoot.db.profile.Opaque) then
        AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 1);
    else
        AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0.65);
    end
    AtlasLootOptions_Init();
end

function AtlasLootOptions_ItemSpam()
    if (AtlasLoot.db.profile.ItemSpam) then
        AtlasLoot.db.profile.ItemSpam = false;
    else
        AtlasLoot.db.profile.ItemSpam = true;
    end
    AtlasLootOptions_Init();
end

function AtlasLootOptions_LoDStartup()
    if (AtlasLoot.db.profile.LoadAllLoDStartup) then
        AtlasLoot.db.profile.LoadAllLoDStartup = false;
    else
        AtlasLoot.db.profile.LoadAllLoDStartup = true;
    end
    AtlasLootOptions_Init();
end

function AtlasLootOptions_ItemIDToggle()
    AtlasLoot.db.profile.ItemIDs=AtlasLootOptionsFrameItemID:GetChecked();
    AtlasLootOptions_Init();
end

function AtlasLoot_SetupLootBrowserSlider(frame, mymin, mymax, step)
    getglobal(frame:GetName().."Text"):SetText(AL["Loot Browser Scale: "].." ("..frame:GetValue()..")");
	frame:SetMinMaxValues(mymin, mymax);
	getglobal(frame:GetName().."Low"):SetText(mymin);
	getglobal(frame:GetName().."High"):SetText(mymax);
	frame:SetValueStep(step);
end

--Borrowed from Atlas, thanks Dan!
local function round(num, idp)
   local mult = 10 ^ (idp or 0);
   return math.floor(num * mult + 0.5) / mult;
end

function AtlasLoot_UpdateLootBrowserSlider(frame)
    getglobal(frame:GetName().."Text"):SetText(AL["Loot Browser Scale: "].." ("..round(frame:GetValue(),2)..")");
end

function AtlasLoot_UpdateLootBrowserScale()
	AtlasLootDefaultFrame:SetScale(AtlasLoot.db.profile.LootBrowserScale);
end

function AtlasLoot_DisplayHelp()
	if not getglobal("AtlasLootHelpFrame_HelpText") then
		local framewidht = InterfaceOptionsFramePanelContainer:GetWidth()
		local panel3 = CreateFrame("ScrollFrame", "AtlasLootHelpFrame_HelpTextFrameScroll", AtlasLootHelpFrame, "UIPanelScrollFrameTemplate")
		local scc = CreateFrame("Frame", "AtlasLootHelpFrame_HelpTextFrame", panel3)
			panel3:SetScrollChild(scc)
			panel3:SetPoint("TOPLEFT", AtlasLootHelpFrame, "TOPLEFT", 10, -25)
			scc:SetPoint("TOPLEFT", panel3, "TOPLEFT", 0, 0)
			panel3:SetWidth(framewidht-45)  
			panel3:SetHeight(400) 
			scc:SetWidth(framewidht-45)  
			scc:SetHeight(400)  
			panel3:SetHorizontalScroll(-50)
			panel3:SetVerticalScroll(50)
			panel3:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }})
			panel3:SetScript("OnVerticalScroll", function()  end)
			panel3:EnableMouse(true)
			panel3:SetVerticalScroll(0)
			panel3:SetHorizontalScroll(0)
		local Text = scc:CreateFontString("AtlasLootHelpFrame_HelpText","OVERLAY","GameFontNormal")
			Text:SetPoint("TOPLEFT", scc, "TOPLEFT", 0, 0)
			Text:SetText(
            ORANGE..AL["How to open the standalone Loot Browser:"].."\n"..
            WHITE..AL["If you have AtlasLootFu enabled, click the minimap button, or alternatively a button generated by a mod like Titan or FuBar.  Finally, you can type '/al' in the chat window."].."\n\n"..
            ORANGE..AL["How to link an item to someone else:"].."\n"..
            WHITE..AL["Shift+Left Click the item like you would for any other in-game item"].."\n\n"..
            ORANGE..AL["How to view an 'unsafe' item:"].."\n"..
            WHITE..AL["Unsafe items have a red border around the icon and are marked because you have not seen the item since the last patch or server restart. Right-click the item, then move your mouse back over the item or click the 'Query Server' button at the bottom of the loot page."].."\n\n"..
            ORANGE..AL["How to view an item in the Dressing Room:"].."\n"..
            WHITE..AL["Simply Ctrl+Left Click on the item.  Sometimes the dressing room window is hidden behind the Atlas or AtlasLoot windows, so if nothing seems to happen move your Atlas or AtlasLoot windows and see if anything is hidden."].."\n\n"..
            ORANGE..AL["How to add an item to the wishlist:"].."\n"..
            WHITE..AL["Alt+Left Click any item to add it to the wishlist."].."\n\n"..
            ORANGE..AL["How to delete an item from the wishlist:"].."\n"..
            WHITE..AL["While on the wishlist screen, just Alt+Left Click on an item to delete it."].."\n\n"..
            ORANGE..AL["What else does the wishlist do?"].."\n"..
            WHITE..AL["If you Left Click any item on the wishlist, you can jump to the loot page the item comes from.  Also, on a loot page any item already in your wishlist is marked with a yellow star."].."\n\n"..
            ORANGE..AL["HELP!! I have broken the mod somehow!"].."\n"..
            WHITE..AL["Use the reset buttons available in the options menu, or type '/al reset' in your chat window."].."\n\n"..
            GREY..AL["For further help, see our website and forums: "]..GREEN.."http://www.atlasloot.net"
            );
			Text:SetWidth(framewidht-80)
			Text:SetJustifyH("LEFT")
			Text:SetJustifyV("TOP")
	end
end

--[[
AtlasLoot_CreateOptionsInfoTooltips()
Adds explanatory tooltips to Atlasloot options
]]
function AtlasLoot_CreateOptionsInfoTooltips()
   local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
      AtlasLoot_AddTooltip("AtlasLootOptionsFrameDefaultTT", nil) -- AL["Default Tooltips"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrameLootlinkTT", nil) -- AL["Lootlink Tooltips"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrameItemSyncTT", nil) -- AL["ItemSync Tooltips"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrameOpaque", nil) -- AL["Make Loot Table Opaque"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrameItemID", nil) -- AL["Show itemIDs at all times"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrameSafeLinks", nil) -- AL["Safe Chat Links |cff1eff00(recommended)|r"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrameEquipCompare", nil) -- AL["Show Comparison Tooltips"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrameHidePanel", nil) -- AL["Hide AtlasLoot Panel"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrameItemSpam", nil) -- AL["Suppress Item Query Text"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrameLoDSpam", nil) -- AL["Notify on LoD Module Load"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrameLootBrowserScale", nil) -- Scale SLIDER
      AtlasLoot_AddTooltip("AtlasLootOptionsFrame_ResetAtlasLoot", nil) -- AL["Reset Frames"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrame_ResetWishlist", nil) -- AL["Reset Wishlist"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrame_ResetQuicklooks", nil) -- AL["Reset Quicklooks"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrame_FuBarShow", nil) -- AL["Show FuBar Plugin"]
      AtlasLoot_AddTooltip("AtlasLootOptionsFrame_FuBarHide", nil) -- AL["Hide FuBar Plugin"]
      AtlasLoot_AddTooltip("AtlasLoot_SelectLootBrowserStyle", nil) 
end

function AtlasLoot_OptionsOnShow()
    AtlasLoot_SelectLootBrowserStyle_Label:SetText(AL["Loot Browser Style:"]);
    UIDropDownMenu_Initialize(AtlasLoot_SelectLootBrowserStyle, AtlasLoot_SelectLootBrowserStyle_Initialize);
	UIDropDownMenu_SetSelectedID(AtlasLoot_SelectLootBrowserStyle, AtlasLoot.db.profile.LootBrowserStyle);
	UIDropDownMenu_SetWidth(AtlasLoot_SelectLootBrowserStyle, 150);
    AtlasLoot_CraftingLink_Label:SetText(AL["Treat Crafted Items:"]);
    UIDropDownMenu_Initialize(AtlasLoot_CraftingLink, AtlasLoot_CraftingLink_Initialize);
	UIDropDownMenu_SetSelectedID(AtlasLoot_CraftingLink, AtlasLoot.db.profile.CraftingLink);
	UIDropDownMenu_SetWidth(AtlasLoot_CraftingLink, 150);
end

function AtlasLoot_SelectLootBrowserStyle_Initialize()
	local info;
	info = {
        text = AL["New Style"];
        func = AtlasLoot_SelectLootBrowserStyle_OnClick;
    };
	UIDropDownMenu_AddButton(info);
    info = {
        text = AL["Classic Style"];
        func = AtlasLoot_SelectLootBrowserStyle_OnClick;
    };
	UIDropDownMenu_AddButton(info);
end

function AtlasLoot_SelectLootBrowserStyle_OnClick()
    local thisID = this:GetID();
	UIDropDownMenu_SetSelectedID(AtlasLoot_SelectLootBrowserStyle, thisID);
    AtlasLoot.db.profile.LootBrowserStyle = thisID;
    if( AtlasLoot.db.profile.LootBrowserStyle == 1 ) then
        AtlasLoot_SetNewStyle("new");
    else
        AtlasLoot_SetNewStyle("old");
    end
    AtlasLoot_OptionsOnShow();
end

function AtlasLoot_CraftingLink_Initialize()
	local info;
	info = {
        text = AL["As Crafting Spells"];
        func = AtlasLoot_CraftingLink_OnClick;
    };
	UIDropDownMenu_AddButton(info);
    info = {
        text = AL["As Items"];
        func = AtlasLoot_CraftingLink_OnClick;
    };
	UIDropDownMenu_AddButton(info);
end

function AtlasLoot_CraftingLink_OnClick()
    local thisID = this:GetID();
	UIDropDownMenu_SetSelectedID(AtlasLoot_CraftingLink, thisID);
    AtlasLoot.db.profile.CraftingLink = thisID;
    if AtlasLootItemsFrame:IsVisible() and AtlasLootItemsFrame.refresh then
        AtlasLoot_ShowItemsFrame(AtlasLootItemsFrame.refresh[1], AtlasLootItemsFrame.refresh[2], AtlasLootItemsFrame.refresh[3], AtlasLootItemsFrame.refresh[4]);
    end
    AtlasLoot_OptionsOnShow();
end

local Authors = {
	["Calî"] = "Arthas",
	["Lâg"] = "Arthas",
	--["Daviesh"] = "Thaurissan",
	["Hegarol"] = "Dun Morogh",
	
}

function AtlasLoot_UnitTarget()
	local name = GameTooltip:GetUnit()
	if UnitName("mouseover") == name then 
		local _, realm = UnitName("mouseover")
		if not realm then 
			realm = GetRealmName()
		end; 
		if name and Authors[name] then
			if Authors[name] == realm then
				GameTooltip:AddLine("AtlasLoot Author |TInterface\\AddOns\\AtlasLoot\\Images\\gold:0|t", 0, 1, 0 )
			end
		end
	end
end
GameTooltip:HookScript("OnTooltipSetUnit", AtlasLoot_UnitTarget)