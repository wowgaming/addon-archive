-- **************************************************************************
-- * Titan Gold Tracker.lua - VERSION 2.3.2
-- **************************************************************************
-- * by Poena @ Area 52
-- * This mod will display all the gold held by toons in the same faction on 
-- * on the same server.  I have also incorporated the Titan Money functionality
-- * of displaying money session stats.
-- *
-- * Credits: The inspiration came from  Lozareth's Total Gold
-- *          Many thanks to:
-- *          Cladhaire @ Silent Transcendence who helped
-- *               clarify some muddy .lua programming routines early on.
-- *          Malreth @ Silver Hand and Zanek @ Malfurion who assisted me
-- *               in clarifying the sort routines.
-- * Updates for the new TitanPanel: Titan Development Team        
-- *               (HonorGoG, jaketodd422, joejanko, Lothayer, Tristanian)
-- **************************************************************************

-- ******************************** Versions ********************************
-- v2.3.2 Nov 13, 2007 - Fixed error with versioning text.
-- v2.3.1 Nov 13, 2007 - Updated TOC to 20300. Changed versioning so that the first two digits represent Blizz's current release.
-- v2.3 Sept 25, 2007 - Updated TOC to 20200.
-- v2.2 May 22, 2007 - Updated TOC to 20100.
-- v2.1 Apr 13, 2007 - Fixed bug the occured when the program tried to update values for a toon not yet in the database
-- v2.0 Apr 12, 2007 - Added option to hide a toon from Gold Tracker.  Just log into the toon and choose "hide toon"
-- v1.9 Jan  9, 2007 - Updated TOC to 20003.
-- v1.8 Jan  4, 2007 - Added French localization - thanks Wilf - Les Chevaliers Pourpres - Vol'Jin!
-- v1.7 Dec 20, 2006 - Fixed German Localization & added the ability to hide the gold/hour display.
-- v1.6 Dec 18, 2006 - Added German localization - thanks Omegasnow!
--                   - added functionality where the mod will remember your settings even after clearing the database
-- v1.5 Dec 18, 2006 - Fixed a bug that caused the mod to forget what your sort preference was between sessions
--                   - added functionality where the mod will remember your settings even after clearing the database
-- v1.4 Dec 16, 2006 - Fixed spacing on button between coins - smaller now.
-- v1.3 Dec 13, 2006 - Added the ability to sort the display table by name or by gold amount.
-- v1.2 Dec 11, 2006 - Removed Dependancy on Titan Panel [Money].
-- v1.1 Dec 10, 2006 - Fixed bug that showed "money lost" text even when you earned money.


-- ******************************** Constants *******************************
local TITAN_GOLDTRACKER_ID = "GoldTracker";
local TITAN_GOLDTRACKER_COUNT_FORMAT = "%d";
local TITAN_GOLDTRACKER_VERSION = TITAN_VERSION;
local TITAN_GOLDTRACKER_SPACERBAR = "--------------------";
local TITAN_GOLDTRACKER_BLUE = {r=0.4,b=1,g=0.4};
local TITAN_GOLDTRACKER_RED = {r=1,b=0,g=0};
local TITAN_GOLDTRACKER_GREEN = {r=0,b=0,g=1};
local updateTable = {TITAN_GOLDTRACKER_ID, TITAN_PANEL_UPDATE_TOOLTIP };
-- ******************************** Variables *******************************
local GOLDTRACKER_INITIALIZED = false;
local GOLDTRACKER_VARIABLES_LOADED = false;
local GOLDTRACKER_ENTERINGWORLD = false;
local GOLDTRACKER_INDEX = "";
local GOLDTRACKER_COLOR;
local GOLDTRACKER_SESS_STATUS;
local GOLDTRACKER_PERHOUR_STATUS;
local GOLDTRACKER_STARTINGGOLD;
local GOLDTRACKER_SESSIONSTART;
local REMEMBER_VIEWALL;
local REMEMBER_SORTBYNAME;
local REMEMBER_SHOWGPH;
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local LB = LibStub("AceLocale-3.0"):GetLocale("Titan_GoldTracker", true)
local TitanGoldTracker = LibStub("AceAddon-3.0"):NewAddon("TitanGoldTracker", "AceHook-3.0", "AceTimer-3.0")
local GoldTrackerTimer = nil;
local _G = getfenv(0);
-- ******************************** Functions *******************************

-- **************************************************************************
-- NAME : TitanPanelGoldTrackerButton_OnLoad()
-- DESC : Registers the add on upon it loading
-- **************************************************************************
function TitanPanelGoldTrackerButton_OnLoad(self)
     self.registry = { 
          id = TITAN_GOLDTRACKER_ID,
 --         builtIn = 1,
			category = "Built-ins",
          version = TITAN_GOLDTRACKER_VERSION,
          menuText = LB["TITAN_GOLDTRACKER_MENU_TEXT"], 
          tooltipTitle = LB["TITAN_GOLDTRACKER_TOOLTIP"],
          tooltipTextFunction = "TitanPanelGoldTrackerButton_GetTooltipText",
          buttonTextFunction = "TitanPanelGoldTrackerButton_GetButtonText",
     };

     self:RegisterEvent("PLAYER_ENTERING_WORLD");
     self:RegisterEvent("PLAYER_MONEY");
     self:RegisterEvent("VARIABLES_LOADED");
     self:RegisterEvent("UNIT_NAME_UPDATE");
     
     -- support for picking up money     
     TitanGoldTracker:SecureHook("OpenCoinPickupFrame",TitanGoldTracker_OpenCoinPickupFrame);     
     
     if (not GoldArray) then 
          GoldArray={};
          GoldArray["VIEWALL"] = true
          GoldArray["DISPLAYGPH"] = true
     end
     
end


-- **************************************************************************
-- NAME : TitanPanelGoldTrackerButton_OnShow()
-- DESC : Create repeating timer when plugin is visible
-- **************************************************************************
function TitanPanelGoldTrackerButton_OnShow()
	if not GoldTrackerTimer and GoldArray and GoldArray["DISPLAYGPH"] then		
		GoldTrackerTimer = TitanGoldTracker:ScheduleRepeatingTimer(TitanPanelPluginHandle_OnUpdate, 1, updateTable)
	end
end

-- **************************************************************************
-- NAME : TitanPanelGoldTrackerButton_OnHide()
-- DESC : Destroy repeating timer when plugin is hidden
-- **************************************************************************
function TitanPanelGoldTrackerButton_OnHide()	
	TitanGoldTracker:CancelTimer(GoldTrackerTimer, true)
	GoldTrackerTimer = nil;     
end

-- **************************************************************************
-- NAME : TitanGoldTracker_OnEvent()
-- DESC : This section will grab the events registered to the add on and act on them
-- **************************************************************************
function TitanGoldTracker_OnEvent(self, event, ...)

     if (event == "VARIABLES_LOADED") then
          GOLDTRACKER_VARIABLES_LOADED = true;
          if (GOLDTRACKER_ENTERINGWORLD) then
               TitanPanelGoldTrackerButton_Initialize_Array(self);
          end
          return;
     end

     if ( event == "PLAYER_ENTERING_WORLD" ) then
          GOLDTRACKER_ENTERINGWORLD = true;
          if (GOLDTRACKER_VARIABLES_LOADED) then          		
               TitanPanelGoldTrackerButton_Initialize_Array(self);
          end
          return;
     end

     if (event == "PLAYER_MONEY") then
          if (GOLDTRACKER_INITIALIZED) then
               GoldArray[GOLDTRACKER_INDEX] = TitanPanelGoldTracker_ParseArray(GoldArray[GOLDTRACKER_INDEX]);
               MoneyFrame_Update("TitanPanelGoldTrackerButton", TitanPanelGoldTrackerButton_FindGold());
          end
          return;
     end
end
 
-- *******************************************************************************************
-- NAME: TitanPanelGoldTrackerButton_GetTooltipText()
-- DESC: Gets our tool-tip text, what appears when we hover over our item on the Titan bar.
-- *******************************************************************************************
function TitanPanelGoldTrackerButton_GetTooltipText()
     -- the following code will parse the database and then display all members from the same faction/server
     -- to the user
          
     local server = GetCVar("realmName").."::"..UnitFactionGroup("Player");
     GoldArray[GOLDTRACKER_INDEX] = TitanPanelGoldTracker_ParseArray(GoldArray[GOLDTRACKER_INDEX]);
    local currentMoneyRichText = ""; -- initialize the variable to hold the array

     -- This next section will sort the array based on user preference 
     -- either by name, or by gold amount decending.

     local GoldArraySorted = {};
     for index, money in pairs(GoldArray) do
          local character, charserver = string.match(index, '(.*)_(.*)');
          if (character) then
               if (charserver == server) then
                    table.insert(GoldArraySorted, index); -- insert all keys from hash into the array
               end
          end
     end
     
     if (GoldArray["SORTBYNAME"]) then
          table.sort(GoldArraySorted);
     else
          table.sort(GoldArraySorted, function (key1, key2) return GoldArray[key1] > GoldArray[key2] end) 
     end
     
     for i = 1, getn(GoldArraySorted) do 
          local character, charserver = string.match(GoldArraySorted[i], '(.*)_(.*)');
          if (character) then
               if (charserver == server) then
                    if (mod(GoldArray[GoldArraySorted[i]],10) == 0) then
                         currentMoneyRichText = currentMoneyRichText.."\n"..character.."\t"..TitanUtils_GetHighlightText(format(L["TITAN_MONEY_FORMAT"], TitanPanelGoldTracker_BreakMoney(floor(GoldArray[GoldArraySorted[i]]/10))));                    
                    end
               end
          end
     end

     currentMoneyRichText = currentMoneyRichText.."\n"..TITAN_GOLDTRACKER_SPACERBAR.."\n"..LB["TITAN_GOLDTRACKER_TTL_GOLD"].."\t"..TitanUtils_GetHighlightText(format(L["TITAN_MONEY_FORMAT"], TitanPanelGoldTracker_BreakMoney(TitanPanelGoldTrackerButton_TotalGold())));

     -- find session earnings and earning per hour
     local sesstotal = GetMoney("player") - GOLDTRACKER_STARTINGGOLD;
     local negative = false;
     if (sesstotal < 0) then
          sesstotal = math.abs(sesstotal);
          negative = true;
     end

     local sesslength = GetTime() - GOLDTRACKER_SESSIONSTART;
     local perhour = math.floor(sesstotal / sesslength * 3600);

     local sessionMoneyRichText = "\n\n"..TitanUtils_GetHighlightText(LB["TITAN_GOLDTRACKER_STATS_TITLE"]).."\n"..LB["TITAN_GOLDTRACKER_START_GOLD"].."\t"..TitanUtils_GetColoredText(format(L["TITAN_MONEY_FORMAT"], TitanPanelGoldTracker_BreakMoney(GOLDTRACKER_STARTINGGOLD)),TITAN_GOLDTRACKER_BLUE).."\n";

     if (negative) then
          GOLDTRACKER_COLOR = TITAN_GOLDTRACKER_RED;
          GOLDTRACKER_SESS_STATUS = LB["TITAN_GOLDTRACKER_SESS_LOST"];
          GOLDTRACKER_PERHOUR_STATUS = LB["TITAN_GOLDTRACKER_PERHOUR_LOST"];
     else
          GOLDTRACKER_COLOR = TITAN_GOLDTRACKER_GREEN;
          GOLDTRACKER_SESS_STATUS = LB["TITAN_GOLDTRACKER_SESS_EARNED"];
          GOLDTRACKER_PERHOUR_STATUS = LB["TITAN_GOLDTRACKER_PERHOUR_EARNED"];
     end     

          sessionMoneyRichText = sessionMoneyRichText..GOLDTRACKER_SESS_STATUS.."\t"..TitanUtils_GetColoredText(format(L["TITAN_MONEY_FORMAT"], TitanPanelGoldTracker_BreakMoney(sesstotal)),GOLDTRACKER_COLOR).."\n";
          
          if (GoldArray["DISPLAYGPH"]) then
               sessionMoneyRichText = sessionMoneyRichText..GOLDTRACKER_PERHOUR_STATUS.."\t"..TitanUtils_GetColoredText(format(L["TITAN_MONEY_FORMAT"], TitanPanelGoldTracker_BreakMoney(perhour)),GOLDTRACKER_COLOR);
          end
     
     
     local final_tooltip = LB["TITAN_GOLDTRACKER_TOOLTIPTEXT"].." : "..GetCVar("realmName").." : "..select(2,UnitFactionGroup("Player"));
     if (UnitFactionGroup("Player")=="Alliance") then
          GOLDTRACKER_COLOR = TITAN_GOLDTRACKER_GREEN;
     else
          GOLDTRACKER_COLOR = TITAN_GOLDTRACKER_RED;
     end     

     return ""..TitanUtils_GetColoredText(final_tooltip,GOLDTRACKER_COLOR)..currentMoneyRichText..sessionMoneyRichText;     
end


-- *******************************************************************************************
-- NAME: TitanPanelGoldTrackerButton_FindGold()
-- DESC: This routines determines which gold total the ui wants (server or player) then calls it and returns it
-- *******************************************************************************************
function TitanPanelGoldTrackerButton_FindGold()
     
     local server = GetCVar("realmName").."::"..UnitFactionGroup("Player");

     GoldArray[GOLDTRACKER_INDEX] = TitanPanelGoldTracker_ParseArray(GoldArray[GOLDTRACKER_INDEX]);
     
    local ttlgold = 0;
     
     if (GoldArray["VIEWALL"]) then
          for index, money in pairs(GoldArray) do
               local character, charserver = string.match(index, '(.*)_(.*)');
               if (character) then
                    if (charserver == server) then
                         if (mod(money,10)==0) then
                              ttlgold = ttlgold + floor(money / 10);
                         end
                    end
               end
          end
     else
          ttlgold = GetMoney("player");
     end     

     return ttlgold;
end

-- *******************************************************************************************
-- NAME: TitanPanelGoldTrackerButton_TotalGold()
-- DESC: Calculates total gold for display
-- *******************************************************************************************
function TitanPanelGoldTrackerButton_TotalGold()
     
     local server = GetCVar("realmName").."::"..UnitFactionGroup("Player");
     GoldArray[GOLDTRACKER_INDEX] = TitanPanelGoldTracker_ParseArray(GoldArray[GOLDTRACKER_INDEX]);
    local ttlgold = 0;
     
     for index, money in pairs(GoldArray) do
          local character, charserver = string.match(index, '(.*)_(.*)');
          if (character) then
               if (charserver == server) then
                    if (mod(money,10)==0) then
                         ttlgold = ttlgold + floor(money / 10);
                    end
               end
          end
     end

     return ttlgold;
end


-- *******************************************************************************************
-- NAME: TitanPanelRightClickMenu_PrepareGoldTrackerMenu
-- DESC: Builds the right click config menu
-- *******************************************************************************************
function TitanPanelRightClickMenu_PrepareGoldTrackerMenu()
	if UIDROPDOWNMENU_MENU_LEVEL == 1 then
     -- Menu title
     TitanPanelRightClickMenu_AddTitle(LB["TITAN_GOLDTRACKER_ITEMNAME"]);     

     -- Function to toggle button gold view
     if (GoldArray["VIEWALL"]) then
          TitanPanelRightClickMenu_AddCommand(LB["TITAN_GOLDTRACKER_TOGGLE_PLAYER_TEXT"], TITAN_GOLDTRACKER_ID,"TitanPanelGoldTrackerButton_Toggle");
     else
          TitanPanelRightClickMenu_AddCommand(LB["TITAN_GOLDTRACKER_TOGGLE_ALL_TEXT"], TITAN_GOLDTRACKER_ID,"TitanPanelGoldTrackerButton_Toggle");
     end
          
     -- Function to toggle display sort
     if (GoldArray["SORTBYNAME"]) then
          TitanPanelRightClickMenu_AddCommand(LB["TITAN_GOLDTRACKER_TOGGLE_SORT_GOLD"], TITAN_GOLDTRACKER_ID,"TitanPanelGoldTrackerSort_Toggle");
     else
          TitanPanelRightClickMenu_AddCommand(LB["TITAN_GOLDTRACKER_TOGGLE_SORT_NAME"], TITAN_GOLDTRACKER_ID,"TitanPanelGoldTrackerSort_Toggle");
     end

     -- Function to toggle gold per hour sort
     if (GoldArray["DISPLAYGPH"]) then
          TitanPanelRightClickMenu_AddCommand(LB["TITAN_GOLDTRACKER_TOGGLE_GPH_HIDE"], TITAN_GOLDTRACKER_ID,"TitanPanelGoldTrackerGPH_Toggle");
     else
          TitanPanelRightClickMenu_AddCommand(LB["TITAN_GOLDTRACKER_TOGGLE_GPH_SHOW"], TITAN_GOLDTRACKER_ID,"TitanPanelGoldTrackerGPH_Toggle");
     end
          
     -- A blank line in the menu
     TitanPanelRightClickMenu_AddSpacer();

     -- Function to toggle whether or not they want this toon visible in GoldTracker
     if (GoldArray[GOLDTRACKER_INDEX] ~= nil) then
          local toontoggle = GoldArray[GOLDTRACKER_INDEX];
          if (mod(toontoggle,10) == 0) then
               TitanPanelRightClickMenu_AddCommand(LB["TITAN_GOLDTRACKER_TOGGLE_PLAYER_HIDE"], TITAN_GOLDTRACKER_ID,"TitanPanelGoldTrackerShowToon_Toggle");
          else
               TitanPanelRightClickMenu_AddCommand(LB["TITAN_GOLDTRACKER_TOGGLE_PLAYER_SHOW"], TITAN_GOLDTRACKER_ID,"TitanPanelGoldTrackerShowToon_Toggle");
          end
     end
		
		-- Delete toon
		local info = {};
		info.text = LB["TITAN_GOLDTRACKER_DELETE_PLAYER"];
		info.value = "ToonDelete";
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info);		
		
     -- A blank line in the menu
     TitanPanelRightClickMenu_AddSpacer();
     
     -- Function to clear the enter database     
     local info = {};
     info.text = LB["TITAN_GOLDTRACKER_CLEAR_DATA_TEXT"];
     info.func = TitanGoldTracker_ClearDB;
     UIDropDownMenu_AddButton(info);
     
     TitanPanelRightClickMenu_AddCommand(LB["TITAN_GOLDTRACKER_RESET_SESS_TEXT"], TITAN_GOLDTRACKER_ID, "TitanPanelGoldTrackerButton_ResetSession");
     
     -- A blank line in the menu
     TitanPanelRightClickMenu_AddSpacer();
     
     -- Generic function to toggle and hide
     TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_GOLDTRACKER_ID, TITAN_PANEL_MENU_FUNC_HIDE);
     
  end
     
     if UIDROPDOWNMENU_MENU_LEVEL == 2 and UIDROPDOWNMENU_MENU_VALUE == "ToonDelete" then
			local info = {};
			info.text = LB["TITAN_GOLDTRACKER_FACTION_PLAYER_ALLY"];
			info.value = "Alliance";
			info.hasArrow = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
						
			info.text = LB["TITAN_GOLDTRACKER_FACTION_PLAYER_HORDE"];
			info.value = "Horde";
			info.hasArrow = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		 end
		
		if UIDROPDOWNMENU_MENU_LEVEL == 3 and UIDROPDOWNMENU_MENU_VALUE == "Alliance" then
			local info = {};
			local name = GetUnitName("player");
			local server = GetRealmName();
				for index, money in pairs(GoldArray) do
      		local character, charserver = string.match(index, "(.*)_(.*)::Alliance");
      			if character then
							info.text = character.." - "..charserver;
							info.value = character;
							info.func = function()
								local rementry = character.."_"..charserver.."::Alliance";
								GoldArray[rementry] = nil;
								MoneyFrame_Update("TitanPanelGoldTrackerButton", TitanPanelGoldTrackerButton_FindGold())								
							end
							-- cannot delete current character							
							if name == character and server == charserver then
								info.disabled = 1;
							else
								info.disabled = nil;
							end
							UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
						end						
				end												
		elseif UIDROPDOWNMENU_MENU_LEVEL == 3 and UIDROPDOWNMENU_MENU_VALUE == "Horde" then
			local info = {};
			local name = GetUnitName("player");
			local server = GetRealmName();
				for index, money in pairs(GoldArray) do
      		local character, charserver = string.match(index, "(.*)_(.*)::Horde");
      			if character then
							info.text = character.." - "..charserver;
							info.value = character;
							info.func = function()
								local rementry = character.."_"..charserver.."::Horde";
								GoldArray[rementry] = nil;
								MoneyFrame_Update("TitanPanelGoldTrackerButton", TitanPanelGoldTrackerButton_FindGold())								
							end
							if name == character and server == charserver then
								info.disabled = 1;
							else
								info.disabled = nil;
							end
							UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
						end
				end		
		end     
end

-- **************************************************************************
-- NAME : TitanPanelGoldTrackerButton_ClearData()
-- DESC : This will allow the user to clear all the data and rebuild the array
-- **************************************************************************
function TitanPanelGoldTrackerButton_ClearData(self)
     GOLDTRACKER_INITIALIZED = false;
     
     REMEMBER_VIEWALL =      GoldArray["VIEWALL"];
     REMEMBER_SORTBYNAME = GoldArray["SORTBYNAME"];
     REMEMBER_SHOWGPH = GoldArray["DISPLAYGPH"];
     
     GoldArray = {};
     TitanPanelGoldTrackerButton_Initialize_Array(self);

     GoldArray["VIEWALL"] = REMEMBER_VIEWALL;
     GoldArray["SORTBYNAME"] = REMEMBER_SORTBYNAME;
     GoldArray["DISPLAYGPH"] = REMEMBER_SHOWGPH;
          
     DEFAULT_CHAT_FRAME:AddMessage(LB["TITAN_GOLDTRACKER_DB_CLEARED"], 1.0, 0.0, 1.0 );
end

-- **************************************************************************
-- NAME : TitanPanelGoldTrackerButton_Initialize_Array()
-- DESC : Build the gold array for the server/faction
-- **************************************************************************
function TitanPanelGoldTrackerButton_Initialize_Array(self)
     if (GOLDTRACKER_INITIALIZED) then return; end          

     self:UnregisterEvent("VARIABLES_LOADED");
     self:UnregisterEvent("PLAYER_ENTERING_WORLD");
     self:UnregisterEvent("UNIT_NAME_UPDATE");

     if (not GoldArray["INITIALIZED"]) then
          GoldArray = {};
          GoldArray["INITIALIZED"] = true;
          GoldArray["VIEWALL"] = true;
          GoldArray["DISPLAYGPH"] = true;
          GoldArray["SORTBYNAME"] = true;
          GoldArray["VERSION2"] = true;
     end

     if (GoldArray["SORTBYNAME"] == nil) then
          GoldArray["SORTBYNAME"] = true;
     end

     if (GoldArray["DISPLAYGPH"] == nil) then
          GoldArray["DISPLAYGPH"] = true;
     end

     if (GoldArray["VERSION2"] == nil) then
          GoldArray["VERSION2"] = true;
          for index, money in pairs(GoldArray) do
               local character, charserver = string.match(index, '(.*)_(.*)');
               if (character) then
                         money = money * 10;
                         GoldArray[index] = money;
               end
          end
     end
     
     GOLDTRACKER_INDEX = UnitName("player").."_"..GetCVar("realmName").."::"..UnitFactionGroup("Player");
     
     if (GoldArray[GOLDTRACKER_INDEX] == nil) then
          GoldArray[GOLDTRACKER_INDEX] = GetMoney("player")*10;
     end
     
     GoldArray[GOLDTRACKER_INDEX] = TitanPanelGoldTracker_ParseArray(GoldArray[GOLDTRACKER_INDEX]);

     GOLDTRACKER_STARTINGGOLD = GetMoney("player");
     GOLDTRACKER_SESSIONSTART = GetTime();

     MoneyFrame_Update("TitanPanelGoldTrackerButton", TitanPanelGoldTrackerButton_FindGold());

     GOLDTRACKER_INITIALIZED = true;
end

-- *******************************************************************************************
-- NAME: TitanPanelGoldTrackerButton_Toggle()
-- DESC: This toggles whether or not the player wants to view total gold on the button, or player gold.
-- *******************************************************************************************
function TitanPanelGoldTrackerButton_Toggle()
     GoldArray["VIEWALL"] = not GoldArray["VIEWALL"];

     MoneyFrame_Update("TitanPanelGoldTrackerButton", TitanPanelGoldTrackerButton_FindGold());
end

-- *******************************************************************************************
-- NAME: TitanPanelGoldTrackerSort_Toggle()
-- DESC: This toggles how the player wants the display to be sorted - by name or gold amount
-- *******************************************************************************************
function TitanPanelGoldTrackerSort_Toggle()
     GoldArray["SORTBYNAME"] = not GoldArray["SORTBYNAME"];
end

-- *******************************************************************************************
-- NAME: TitanPanelGoldTrackerGPH_Toggle()
-- DESC: This toggles if the player wants to see the gold/hour stats
-- *******************************************************************************************
function TitanPanelGoldTrackerGPH_Toggle()
     GoldArray["DISPLAYGPH"] = not GoldArray["DISPLAYGPH"];
     if not GoldTrackerTimer and GoldArray["DISPLAYGPH"] then
			GoldTrackerTimer = TitanGoldTracker:ScheduleRepeatingTimer(TitanPanelPluginHandle_OnUpdate, 1, updateTable)
		 elseif GoldTrackerTimer and not GoldArray["DISPLAYGPH"] then
		 	TitanGoldTracker:CancelTimer(GoldTrackerTimer, true)
			GoldTrackerTimer = nil;     
		end
end

-- *******************************************************************************************
-- NAME: TitanPanelGoldTrackerButton_ResetSession()
-- DESC: Resets the current session
-- *******************************************************************************************
function TitanPanelGoldTrackerButton_ResetSession()
     GOLDTRACKER_STARTINGGOLD = GetMoney("player");
     GOLDTRACKER_SESSIONSTART = GetTime();
     
     DEFAULT_CHAT_FRAME:AddMessage(LB["TITAN_GOLDTRACKER_SESSION_RESET"], 1.0, 0.0, 1.0 );
end
     
-- *******************************************************************************************
-- NAME: TitanPanelGoldTracker_BreakMoney(money)
-- DESC: This routine was borrowed from TitanPanel [Money] - breaks down gold into denominations
-- *******************************************************************************************
function TitanPanelGoldTracker_BreakMoney(money)
     -- Non-negative money only
     if (money >= 0) then
          local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
          local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
          local copper = mod(money, COPPER_PER_SILVER);
          return gold, silver, copper;
     end
end     

-- *******************************************************************************************
-- NAME: TitanPanelGoldTracker_ParseArray(tooninfo)
-- DESC: This routine will parse the value of the array in order to remember if the toon should
--       be shown/included or not, while also updating the toon's gold information
-- *******************************************************************************************
function TitanPanelGoldTracker_ParseArray(tooninfo)
     TitanGoldTracker_ShowToon = mod(tooninfo,10);
     local finalvalue = (GetMoney("player") * 10) + TitanGoldTracker_ShowToon;
     return finalvalue;
end

-- *******************************************************************************************
-- NAME: TitanPanelGoldTrackerShowToon_Toggle()
-- DESC: This routine will toggle a toon's status from visible to hidden
-- *******************************************************************************************
function TitanPanelGoldTrackerShowToon_Toggle()
     if (mod(GoldArray[GOLDTRACKER_INDEX],10)==0) then
          local newvalue = (floor(GoldArray[GOLDTRACKER_INDEX],10)*10)+1;
          GoldArray[GOLDTRACKER_INDEX] = newvalue;
          local character, charserver = string.match(GOLDTRACKER_INDEX, '(.*)_(.*)');
          DEFAULT_CHAT_FRAME:AddMessage("Titan Gold Tracker: "..character.." "..LB["TITAN_GOLDTRACKER_STATUS_PLAYER_HIDE"], 1.0, 0.0, 1.0 );
     else
          local newvalue = floor(GoldArray[GOLDTRACKER_INDEX],10)*10;
          GoldArray[GOLDTRACKER_INDEX] = newvalue;
          local character, charserver = string.match(GOLDTRACKER_INDEX, '(.*)_(.*)');
          DEFAULT_CHAT_FRAME:AddMessage("Titan Gold Tracker: "..character.." "..LB["TITAN_GOLDTRACKER_STATUS_PLAYER_SHOW"], 1.0, 0.0, 1.0 );
     end

     MoneyFrame_Update("TitanPanelGoldTrackerButton", TitanPanelGoldTrackerButton_FindGold());
end     

-- support for picking up money
-- extra functions

-- *******************************************************************************************
-- NAME: TitanPanelGoldTrackerCopperButton_OnClick(button)
-- DESC: Create pickup frame for copper
-- VARS: button = value of action
-- *******************************************************************************************
function TitanPanelGoldTrackerCopperButton_OnClick(self, button)
     if (button == "LeftButton") then
          local parent = self:GetParent();
          OpenCoinPickupFrame(1, MoneyTypeInfo[parent.moneyType].UpdateFunc(), parent);
          parent.hasPickup = 1;
     end
end

-- *******************************************************************************************
-- NAME: TitanPanelGoldTrackerSilverButton_OnClick(button)
-- DESC: Create pickup frame for silver
-- VARS: button = value of action
-- *******************************************************************************************
function TitanPanelGoldTrackerSilverButton_OnClick(self, button)
     if (button == "LeftButton") then
          local parent = self:GetParent();
          OpenCoinPickupFrame(COPPER_PER_SILVER, MoneyTypeInfo[parent.moneyType].UpdateFunc(), parent);
          parent.hasPickup = 1;
     end
end

-- *******************************************************************************************
-- NAME: TitanPanelGoldTrackerGoldButton_OnClick(button)
-- DESC: Create pickup frame for gold
-- VARS: button = value of action
-- *******************************************************************************************
function TitanPanelGoldTrackerGoldButton_OnClick(self, button)
     if (button == "LeftButton") then
          local parent = self:GetParent();
          OpenCoinPickupFrame(COPPER_PER_GOLD, MoneyTypeInfo[parent.moneyType].UpdateFunc(), parent);
          parent.hasPickup = 1;
     end
end

-- *******************************************************************************************
-- NAME: TitanGoldTracker_OpenCoinPickupFrame(multiplier, maxMoney, parent)
-- DESC: Create pickup frame and deliver money
-- VARS: multiplier = money type, maxMoney = amount available, parent = parent function
-- *******************************************************************************************
function TitanGoldTracker_OpenCoinPickupFrame(multiplier, maxMoney, parent)    
     CoinPickupFrame:Hide();
     
     position = TitanUtils_GetRealPosition(TITAN_GOLDTRACKER_ID);


     local scale = TitanPanelGetVar("Scale");
     if scale == nil then scale = 1; end

     if (parent:GetName() == "TitanPanelGoldTrackerButton") then
          if (position == TITAN_PANEL_PLACE_TOP) then 
			--local panelYOffset = TitanMovable_GetPanelYOffset(TITAN_PANEL_PLACE_TOP, TitanPanelGetVar("BothBars"));
               CoinPickupFrame:ClearAllPoints();
               CoinPickupFrame:SetPoint("TOPLEFT", parent:GetName(), "BOTTOMLEFT", -10, -4 * scale);
               CoinPickupFrame:SetFrameStrata("FULLSCREEN");               
          else
               CoinPickupFrame:ClearAllPoints();
               CoinPickupFrame:SetPoint("BOTTOMLEFT", parent:GetName(), "TOPLEFT", -10, 0);
               CoinPickupFrame:SetFrameStrata("FULLSCREEN");
          end          
     else
          CoinPickupFrame:ClearAllPoints();
          CoinPickupFrame:SetPoint("BOTTOMRIGHT", parent:GetName(), "TOPRIGHT", 0, 0);
     end
     CoinPickupFrame:Show();
     --PlaySound("igBackPackCoinSelect");
end

function TitanGoldTracker_ClearDB()
	StaticPopupDialogs["TITANGOLDTRACKER_CLEAR_DATABASE"] = {
	text = TitanUtils_GetNormalText(L["TITAN_PANEL_MENU_TITLE"].." "..LB["TITAN_GOLDTRACKER_MENU_TEXT"]).."\n\n"..LB["TITAN_GOLDTRACKER_CLEAR_DATA_WARNING"],
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
	local frame = _G["TitanPanelGoldTrackerButton"]
  TitanPanelGoldTrackerButton_ClearData(frame)
	end,	
	showAlert = 1,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
	};
	StaticPopup_Show("TITANGOLDTRACKER_CLEAR_DATABASE");
end