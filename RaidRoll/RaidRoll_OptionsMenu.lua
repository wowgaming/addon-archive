
-- Create the frame for the options panel
function Setup_RR_Panel()
 RaidRoll_Panel = {};
 RaidRoll_Panel.panel = CreateFrame( "Frame", "Raid Roll Panel", UIParent );
 -- Register in the Interface Addon Options GUI
 -- Set the name for the Category for the Options Panel
 RaidRoll_Panel.panel.name = "Raid Roll";
 -- Add the panel to the Interface Options
 InterfaceOptions_AddCategory(RaidRoll_Panel.panel);
 
 
  RaidRoll_PriorityPanel = {};
  RaidRoll_PriorityPanel = CreateFrame( "Frame", "Raid Roll Loot Panel", UIParent );
 -- Register in the Interface Addon Options GUI
 -- Set the name for the Category for the Options Panel
 RaidRoll_PriorityPanel.name = "Priority";
 RaidRoll_PriorityPanel.parent = "Raid Roll"
 -- Add the panel to the Interface Options
 InterfaceOptions_AddCategory(RaidRoll_PriorityPanel);
 
 
 if RaidRoll_LootTrackerLoaded==true then
	  RaidRoll_LootPanel = {};
	  RaidRoll_LootPanel = CreateFrame( "Frame", "Raid Roll Loot Panel", UIParent );
	 -- Register in the Interface Addon Options GUI
	 -- Set the name for the Category for the Options Panel
	 RaidRoll_LootPanel.name = "Loot Window";
	 RaidRoll_LootPanel.parent = "Raid Roll"
	 -- Add the panel to the Interface Options
	 InterfaceOptions_AddCategory(RaidRoll_LootPanel);
 end
 
 local x,y = 30,-120
 
 
 
 RaidRoll_Panel.panel:SetScript("OnShow", 	function()
												RR_GuildRankUpdate()
												RR_GetEPGPGuildData()
												if RaidRoll_LootTrackerLoaded==true then
													Raid_Roll_SetMsg3_EditBox:SetCursorPosition(0)
													Raid_Roll_SetMsg2_EditBox:SetCursorPosition(0)
													Raid_Roll_SetMsg1_EditBox:SetCursorPosition(0)
												end
											end)
 

 
 
-- Options menu
	Raid_Roll_PanelName_String =  RaidRoll_Panel.panel:CreateFontString("Raid_Roll_PanelName_String" ,"ARTWORK","GameFontNormal");
	Raid_Roll_PanelName_String:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft", 20, -10)
	Raid_Roll_PanelName_String:SetJustifyH("LEFT")
	
	Raid_Roll_PanelName_String:SetText("|cFFC41F3B" .. RAIDROLL_LOCALE["OPTIONSTITLE"])
	if (GetLocale() ~= "zhTW") then
		Raid_Roll_PanelName_String:SetFont("Fonts\\FRIZQT__.TTF", 16)
	end
	if (GetLocale() == "zhCN") then
		Raid_Roll_PanelName_String:SetFont("Fonts\\ZYKai_T.TTF", 20)
	end
	
-- General_Settings
	Raid_Roll_PanelName_String =  RaidRoll_Panel.panel:CreateFontString("Raid_Roll_PanelName_String" ,"ARTWORK","GameFontNormal");
	Raid_Roll_PanelName_String:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft", 20, -40)
	Raid_Roll_PanelName_String:SetJustifyH("LEFT")
	
	Raid_Roll_PanelName_String:SetText("|cFF2459FF" .. RAIDROLL_LOCALE["General_Settings"])
	if (GetLocale() ~= "zhTW") then
		Raid_Roll_PanelName_String:SetFont("Fonts\\FRIZQT__.TTF", 16)
	end
	if (GetLocale() == "zhCN") then
		Raid_Roll_PanelName_String:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
 
-- [ ] Catch Unannounced Rolls
  	RR_RollCheckBox_Unannounced_panel = CreateFrame("CheckButton", "RR_RollCheckBox_Unannounced_panel", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_Unannounced_panel:SetWidth(20)
	RR_RollCheckBox_Unannounced_panel:SetHeight(20)
	RR_RollCheckBox_Unannounced_panel:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  30, -60)
	_G["RR_RollCheckBox_Unannounced_panel".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Catch_Unannounced_Rolls"])
	if (GetLocale() ~= "zhTW")  then
		_G["RR_RollCheckBox_Unannounced_panel".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_Unannounced_panel".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_Unannounced_panel:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_Unannounced_panel:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_Unannounced_panel:SetScript("OnLeave", function() GameTooltip:Hide()	end)

-- [ ] Allow all rolls (e.g. 1-50)
	RR_RollCheckBox_AllRolls_panel = CreateFrame("CheckButton", "RR_RollCheckBox_AllRolls_panel", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_AllRolls_panel:SetWidth(20)
	RR_RollCheckBox_AllRolls_panel:SetHeight(20)
	RR_RollCheckBox_AllRolls_panel:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  30, -80)
	_G["RR_RollCheckBox_AllRolls_panel".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Allow_all_rolls"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_AllRolls_panel".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_AllRolls_panel".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_AllRolls_panel:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
 	RR_RollCheckBox_AllRolls_panel:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_AllRolls_panel:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
-- [ ] Allow Extra Rolls
 	RR_RollCheckBox_ExtraRolls_panel = CreateFrame("CheckButton", "RaidRollCheckBox_ExtraRolls_panel", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_ExtraRolls_panel:SetWidth(20)
	RR_RollCheckBox_ExtraRolls_panel:SetHeight(20)
	RR_RollCheckBox_ExtraRolls_panel:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  30, -100)
	_G["RaidRollCheckBox_ExtraRolls_panel".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Allow_Extra_Rolls"])
	if (GetLocale() ~= "zhTW") then
		_G["RaidRollCheckBox_ExtraRolls_panel".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RaidRollCheckBox_ExtraRolls_panel".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_ExtraRolls_panel:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_ExtraRolls_panel:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_ExtraRolls_panel:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
-- [ ] Announce winner to guild
	RR_RollCheckBox_GuildAnnounce = CreateFrame("CheckButton", "RR_RollCheckBox_GuildAnnounce", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_GuildAnnounce:SetWidth(20)
	RR_RollCheckBox_GuildAnnounce:SetHeight(20)
	RR_RollCheckBox_GuildAnnounce:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  30, -120)
	_G["RR_RollCheckBox_GuildAnnounce".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Announce_winner_to_guild"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_GuildAnnounce".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_GuildAnnounce".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_GuildAnnounce:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_GuildAnnounce:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_GuildAnnounce:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
-- [ ] Use officer channel
	RR_RollCheckBox_GuildAnnounce_Officer = CreateFrame("CheckButton", "RR_RollCheckBox_GuildAnnounce_Officer", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_GuildAnnounce_Officer:SetWidth(15)
	RR_RollCheckBox_GuildAnnounce_Officer:SetHeight(15)
	RR_RollCheckBox_GuildAnnounce_Officer:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  40, -135)
	_G["RR_RollCheckBox_GuildAnnounce_Officer".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Use_officer_channel"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_GuildAnnounce_Officer".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 10)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_GuildAnnounce_Officer".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 14)
	end
	RR_RollCheckBox_GuildAnnounce_Officer:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_GuildAnnounce_Officer:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_GuildAnnounce_Officer:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
-- [ ] Auto Announce Countdown
 	RR_RollCheckBox_Auto_Announce = CreateFrame("CheckButton", "RR_RollCheckBox_Auto_Announce", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_Auto_Announce:SetWidth(20)
	RR_RollCheckBox_Auto_Announce:SetHeight(20)
	RR_RollCheckBox_Auto_Announce:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  240, -60)
	_G["RR_RollCheckBox_Auto_Announce".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Auto_Announce_Count"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_Auto_Announce".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_Auto_Announce".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_Auto_Announce:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_Auto_Announce:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_Auto_Announce:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
-- [ ] Auto Close Window
 	RR_RollCheckBox_Auto_Close = CreateFrame("CheckButton", "RR_RollCheckBox_Auto_Close", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_Auto_Close:SetWidth(20)
	RR_RollCheckBox_Auto_Close:SetHeight(20)
	RR_RollCheckBox_Auto_Close:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  240, -80)
	_G["RR_RollCheckBox_Auto_Close".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Auto_Close_Window"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_Auto_Close".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_Auto_Close".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_Auto_Close:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_Auto_Close:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_Auto_Close:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
-- [ ] No countdown
 	RR_RollCheckBox_No_countdown = CreateFrame("CheckButton", "RR_RollCheckBox_No_countdown", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_No_countdown:SetWidth(20)
	RR_RollCheckBox_No_countdown:SetHeight(20)
	RR_RollCheckBox_No_countdown:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  240, -100)
	_G["RR_RollCheckBox_No_countdown".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["No_countdown"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_No_countdown".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_No_countdown".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_No_countdown:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_No_countdown:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_No_countdown:SetScript("OnLeave", function() GameTooltip:Hide()	end)

-- [ ] No countdown
 	RR_RollCheckBox_Multi_Rollers = CreateFrame("CheckButton", "RR_RollCheckBox_Multi_Rollers", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_Multi_Rollers:SetWidth(20)
	RR_RollCheckBox_Multi_Rollers:SetHeight(20)
	RR_RollCheckBox_Multi_Rollers:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  240, -120)
	_G["RR_RollCheckBox_Multi_Rollers".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Multi_Rollers"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_Multi_Rollers".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_Multi_Rollers".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_Multi_Rollers:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_Multi_Rollers:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_Multi_Rollers:SetScript("OnLeave", function() GameTooltip:Hide()	end)

-- Display Settings
	Raid_Roll_Display_Settings =  RaidRoll_Panel.panel:CreateFontString("Raid_Roll_Display_Settings" ,"ARTWORK","GameFontNormal");
	Raid_Roll_Display_Settings:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft", 20, -160)
	Raid_Roll_Display_Settings:SetJustifyH("LEFT")
	
	Raid_Roll_Display_Settings:SetText("|cFF2459FF" .. RAIDROLL_LOCALE["Raid_Roll_Display_Settings"])
	if (GetLocale() ~= "zhTW") then
		Raid_Roll_Display_Settings:SetFont("Fonts\\FRIZQT__.TTF", 16)
	end
	if (GetLocale() == "zhCN") then
		Raid_Roll_Display_Settings:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	
-- [ ] Show Rank Beside Name
	RR_RollCheckBox_ShowRanks_panel = CreateFrame("CheckButton", "RaidRollCheckBox_ShowRanks_panel", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_ShowRanks_panel:SetWidth(20)
	RR_RollCheckBox_ShowRanks_panel:SetHeight(20)
	RR_RollCheckBox_ShowRanks_panel:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  30, -180)
	_G["RaidRollCheckBox_ShowRanks_panel".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Show_Rank_Beside_Name"])
	if (GetLocale() ~= "zhTW") then
		_G["RaidRollCheckBox_ShowRanks_panel".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RaidRollCheckBox_ShowRanks_panel".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_ShowRanks_panel:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_ShowRanks_panel:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_ShowRanks_panel:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
-- [ ] Show Group Number Beside Name
	RR_RollCheckBox_ShowGroupNumber_panel = CreateFrame("CheckButton", "RR_RollCheckBox_ShowGroupNumber_panel", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_ShowGroupNumber_panel:SetWidth(20)
	RR_RollCheckBox_ShowGroupNumber_panel:SetHeight(20)
	RR_RollCheckBox_ShowGroupNumber_panel:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  30, -200)
	_G["RR_RollCheckBox_ShowGroupNumber_panel".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Show_Group_Beside_Name"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_ShowGroupNumber_panel".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_ShowGroupNumber_panel".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_ShowGroupNumber_panel:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_ShowGroupNumber_panel:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_ShowGroupNumber_panel:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
-- [ ] Show Class Colors
	RR_RollCheckBox_ShowClassColors_panel = CreateFrame("CheckButton", "RR_RollCheckBox_ShowClassColors_panel", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_ShowClassColors_panel:SetWidth(20)
	RR_RollCheckBox_ShowClassColors_panel:SetHeight(20)
	RR_RollCheckBox_ShowClassColors_panel:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  240, -180)
	_G["RR_RollCheckBox_ShowClassColors_panel".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Show_Class_Colors"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_ShowClassColors_panel".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_ShowClassColors_panel".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_ShowClassColors_panel:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_ShowClassColors_panel:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_ShowClassColors_panel:SetScript("OnLeave", function() GameTooltip:Hide()	end)

	
-- EPGP Settings
	Raid_Roll_EPGP_Settings =  RaidRoll_Panel.panel:CreateFontString("Raid_Roll_EPGP_Settings" ,"ARTWORK","GameFontNormal");
	Raid_Roll_EPGP_Settings:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft", 20, -230)
	Raid_Roll_EPGP_Settings:SetJustifyH("LEFT")
	
	Raid_Roll_EPGP_Settings:SetText("|cFF2459FF" .. RAIDROLL_LOCALE["Raid_Roll_EPGP_Settings"])
	if (GetLocale() ~= "zhTW") then
		Raid_Roll_EPGP_Settings:SetFont("Fonts\\FRIZQT__.TTF", 16)
	end
	if (GetLocale() == "zhCN") then
		Raid_Roll_EPGP_Settings:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	
-- [ ] Enable EPGP mode
	RR_RollCheckBox_EPGPMode_panel = CreateFrame("CheckButton", "RR_RollCheckBox_EPGPMode_panel", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_EPGPMode_panel:SetWidth(20)
	RR_RollCheckBox_EPGPMode_panel:SetHeight(20)
	RR_RollCheckBox_EPGPMode_panel:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  30, -250)
	_G["RR_RollCheckBox_EPGPMode_panel".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Enable_EPGP_mode"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_EPGPMode_panel".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_EPGPMode_panel".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_EPGPMode_panel:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_EPGPMode_panel:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_EPGPMode_panel:SetScript("OnLeave", function() GameTooltip:Hide()	end)

-- [ ] Enable threshold levels
	RR_RollCheckBox_EPGPThreshold_panel = CreateFrame("CheckButton", "RR_RollCheckBox_EPGPThreshold_panel", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_EPGPThreshold_panel:SetWidth(15)
	RR_RollCheckBox_EPGPThreshold_panel:SetHeight(15)
	RR_RollCheckBox_EPGPThreshold_panel:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  40, -265)
	_G["RR_RollCheckBox_EPGPThreshold_panel".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Enable_threshold_levels"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_EPGPThreshold_panel".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 10)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_EPGPThreshold_panel".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 14)
	end
	RR_RollCheckBox_EPGPThreshold_panel:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_EPGPThreshold_panel:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_EPGPThreshold_panel:SetScript("OnLeave", function() GameTooltip:Hide()	end)

-- [ ] Enable Alt Mode
	RR_RollCheckBox_Enable_Alt_Mode = CreateFrame("CheckButton", "RR_RollCheckBox_Enable_Alt_Mode", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_Enable_Alt_Mode:SetWidth(15)
	RR_RollCheckBox_Enable_Alt_Mode:SetHeight(15)
	RR_RollCheckBox_Enable_Alt_Mode:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  40, -280)
	_G["RR_RollCheckBox_Enable_Alt_Mode".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Enable_Alt_Mode"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_Enable_Alt_Mode".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 10)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_Enable_Alt_Mode".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 14)
	end
	RR_RollCheckBox_Enable_Alt_Mode:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_Enable_Alt_Mode:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_Enable_Alt_Mode:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
	
	
	

	
-- MiscSettings
	Raid_Roll_Misc_Settings =  RaidRoll_Panel.panel:CreateFontString("Raid_Roll_Misc_Settings" ,"ARTWORK","GameFontNormal");
	Raid_Roll_Misc_Settings:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft", 240, -230)
	Raid_Roll_Misc_Settings:SetJustifyH("LEFT")
	
	Raid_Roll_Misc_Settings:SetText("|cFF2459FF" .. RAIDROLL_LOCALE["Raid_Roll_Misc_Settings"])
	if (GetLocale() ~= "zhTW") then
		Raid_Roll_Misc_Settings:SetFont("Fonts\\FRIZQT__.TTF", 16)
	end
	if (GetLocale() == "zhCN") then
		Raid_Roll_Misc_Settings:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
-- [ ] Track !bid
	RR_RollCheckBox_Track_Bids = CreateFrame("CheckButton", "RR_RollCheckBox_Track_Bids", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_Track_Bids:SetWidth(20)
	RR_RollCheckBox_Track_Bids:SetHeight(20)
	RR_RollCheckBox_Track_Bids:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  250, -250)
	_G["RR_RollCheckBox_Track_Bids".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Track_Bids"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_Track_Bids".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_Track_Bids".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_Track_Bids:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_Track_Bids:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_Track_Bids:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
-- [ ] Number not required
	RR_RollCheckBox_Num_Not_Req = CreateFrame("CheckButton", "RR_RollCheckBox_Num_Not_Req", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_Num_Not_Req:SetWidth(15);
	RR_RollCheckBox_Num_Not_Req:SetHeight(15);
	RR_RollCheckBox_Num_Not_Req:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  260, -265)
	_G["RR_RollCheckBox_Num_Not_Req".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Number not required"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_Num_Not_Req".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 10)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_Num_Not_Req".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 14)
	end
	RR_RollCheckBox_Num_Not_Req:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_Num_Not_Req:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_Num_Not_Req:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
-- [ ] Track !epgp
	RR_RollCheckBox_Track_EPGPSays = CreateFrame("CheckButton", "RR_RollCheckBox_Track_EPGPSays", RaidRoll_Panel.panel, "UICheckButtonTemplate")
	RR_RollCheckBox_Track_EPGPSays:SetWidth(20)
	RR_RollCheckBox_Track_EPGPSays:SetHeight(20)
	RR_RollCheckBox_Track_EPGPSays:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopLeft",  250, -280)
	_G["RR_RollCheckBox_Track_EPGPSays".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Track_EPGPSays"])
	if (GetLocale() ~= "zhTW") then
		_G["RR_RollCheckBox_Track_EPGPSays".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RR_RollCheckBox_Track_EPGPSays".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_Track_EPGPSays:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	RR_RollCheckBox_Track_EPGPSays:SetScript("OnEnter",function(self) RR_MouseOverTooltip(self:GetName())	end)
	RR_RollCheckBox_Track_EPGPSays:SetScript("OnLeave", function() GameTooltip:Hide()	end)
	
	
	
	
	
	--[[
-- Give Extra Priority to:
	Raid_Roll_PanelName_String =  RaidRoll_Panel.panel:CreateFontString("Raid_Roll_PanelName_String" ,"ARTWORK","GameFontNormal");
	Raid_Roll_PanelName_String:SetPoint("TopLeft", RaidRoll_Panel.panel, "TopRight", -210, -50)
	Raid_Roll_PanelName_String:SetJustifyH("LEFT")
	
	Raid_Roll_PanelName_String:SetText("|cFF2459FF" .. RAIDROLL_LOCALE["Priorities"])
	Raid_Roll_PanelName_String:SetFont("Fonts\\FRIZQT__.TTF", 16)
	]]

	
	
	

	
 
 --------------------SLIDER BAR 1 : Scale--------------------------------

 -- Set Scale
	Raid_Roll_ScalePanelName_String =  RaidRoll_Panel.panel:CreateFontString("Raid_Roll_ScalePanelName_String" ,"ARTWORK","GameFontNormal");
	Raid_Roll_ScalePanelName_String:SetPoint("TopLeft", RaidRoll_Panel.panel, "TOPLEFT", 10, -310)
	Raid_Roll_ScalePanelName_String:SetJustifyH("LEFT")
	
	Raid_Roll_ScalePanelName_String:SetText("|cFF69CCF0" .. RAIDROLL_LOCALE["Set_Scale"])
	if (GetLocale() ~= "zhTW") then
		Raid_Roll_ScalePanelName_String:SetFont("Fonts\\FRIZQT__.TTF", 14)
	end
	if (GetLocale() == "zhCN") then
		Raid_Roll_ScalePanelName_String:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
		
 RaidRoll_Scale_Slider = CreateFrame("Slider", "RaidRoll_Scale_Slider", RaidRoll_Panel.panel, "OptionsSliderTemplate")
 RaidRoll_Scale_Slider:SetWidth(300)
 RaidRoll_Scale_Slider:SetHeight( 20 )
 RaidRoll_Scale_Slider:SetPoint('TOPLEFT', 20, -335)
 RaidRoll_Scale_Slider:SetOrientation('HORIZONTAL')
 

	if RaidRoll_DB["Scale"] == nil then RaidRoll_DB["Scale"] = 100 end
 
 RaidRoll_Scale_Slider:SetMinMaxValues(1, 200)
 RaidRoll_Scale_Slider:SetValueStep(1)
 RaidRoll_Scale_Slider:SetValue(RaidRoll_DB["Scale"])
 
 
 
	_G[RaidRoll_Scale_Slider:GetName() .. 'Low']:SetText('1%');
	_G[RaidRoll_Scale_Slider:GetName() .. 'High']:SetText('200%'); 	
	_G[RaidRoll_Scale_Slider:GetName() .. 'Text']:SetText(RaidRoll_Scale_Slider:GetValue() .. "%");
	
	
 RaidRoll_Scale_Slider:Show()
 
 RR_RollFrame:SetScale(RaidRoll_Scale_Slider:GetValue()/100);
 
 
  RaidRoll_Scale_Slider:SetScript("OnValueChanged",function()
	RR_RollFrame:SetScale(RaidRoll_Scale_Slider:GetValue()/100);
	_G[RaidRoll_Scale_Slider:GetName() .. 'Text']:SetText(RaidRoll_Scale_Slider:GetValue() .. "%");
	RaidRoll_DB["Scale"] = RaidRoll_Scale_Slider:GetValue()
  end)
 ----------------------------------------------------
 
 
 
 
 --------------------SLIDER BAR 2 : Extra Rank Width--------------------------------

 -- Set Extra Rank Width
	Raid_Roll_PanelName_String =  RaidRoll_Panel.panel:CreateFontString("Raid_Roll_PanelName_String" ,"ARTWORK","GameFontNormal");
	Raid_Roll_PanelName_String:SetPoint("TopLeft", RaidRoll_Panel.panel, "TOPLEFT", 10, -365)
	Raid_Roll_PanelName_String:SetJustifyH("LEFT")
	
	Raid_Roll_PanelName_String:SetText("|cFF69CCF0" .. RAIDROLL_LOCALE["Set_Extra_Rank_Width"])
	if (GetLocale() ~= "zhTW") then
		Raid_Roll_PanelName_String:SetFont("Fonts\\FRIZQT__.TTF", 14)
	end
	if (GetLocale() == "zhCN") then
		Raid_Roll_PanelName_String:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
		
 RaidRoll_ExtraWidth_Slider = CreateFrame("Slider", "RaidRoll_ExtraWidth_Slider", RaidRoll_Panel.panel, "OptionsSliderTemplate")
 RaidRoll_ExtraWidth_Slider:SetWidth(200)
 RaidRoll_ExtraWidth_Slider:SetHeight( 20 )
 RaidRoll_ExtraWidth_Slider:SetPoint('TOPLEFT', 20, -390)
 RaidRoll_ExtraWidth_Slider:SetOrientation('HORIZONTAL')
 

	if RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"] = 0 end
 
 RaidRoll_ExtraWidth_Slider:SetMinMaxValues(0, 200)
 RaidRoll_ExtraWidth_Slider:SetValueStep(1)
 RaidRoll_ExtraWidth_Slider:SetValue(RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"])
 
 
 
	_G[RaidRoll_ExtraWidth_Slider:GetName() .. 'Low']:SetText('0');
	_G[RaidRoll_ExtraWidth_Slider:GetName() .. 'High']:SetText('200'); 	
	_G[RaidRoll_ExtraWidth_Slider:GetName() .. 'Text']:SetText(RaidRoll_ExtraWidth_Slider:GetValue());


 RaidRoll_ExtraWidth_Slider:Show()
 
 
 
  RaidRoll_ExtraWidth_Slider:SetScript("OnValueChanged",function()
	RaidRoll_CheckButton_Update_Panel()
	_G[RaidRoll_ExtraWidth_Slider:GetName() .. 'Text']:SetText(RaidRoll_ExtraWidth_Slider:GetValue());
	RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"] = RaidRoll_ExtraWidth_Slider:GetValue()
  end)
 ----------------------------------------------------
 
 
 --------------------SLIDER BAR 3: Extra Time--------------------------------

 -- Set Extra Rank Width
	Raid_Roll_PanelName_String =  RaidRoll_Panel.panel:CreateFontString("Raid_Roll_PanelName_String" ,"ARTWORK","GameFontNormal");
	Raid_Roll_PanelName_String:SetPoint("TopLeft", RaidRoll_Panel.panel, "TOPLEFT", 220, -365)
	Raid_Roll_PanelName_String:SetJustifyH("LEFT")
	
	Raid_Roll_PanelName_String:SetText("|cFF69CCF0" .. RAIDROLL_LOCALE["Set_Rolling_Time"])
	if (GetLocale() ~= "zhTW") then
		Raid_Roll_PanelName_String:SetFont("Fonts\\FRIZQT__.TTF", 14)
	end
	if (GetLocale() == "zhCN") then
		Raid_Roll_PanelName_String:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	
 RaidRoll_Rolling_Time_Slider = CreateFrame("Slider", "RaidRoll_Rolling_Time_Slider", RaidRoll_Panel.panel, "OptionsSliderTemplate")
 RaidRoll_Rolling_Time_Slider:SetWidth(130)
 RaidRoll_Rolling_Time_Slider:SetHeight( 20 )
 RaidRoll_Rolling_Time_Slider:SetPoint('TOPLEFT', 230, -390)
 RaidRoll_Rolling_Time_Slider:SetOrientation('HORIZONTAL')
 

	if RaidRoll_DBPC[UnitName("player")]["Time_Offset"] == nil then RaidRoll_DBPC[UnitName("player")]["Time_Offset"] = 0 end
 
 RaidRoll_Rolling_Time_Slider:SetMinMaxValues(-55, 60)
 RaidRoll_Rolling_Time_Slider:SetValueStep(1)
 RaidRoll_Rolling_Time_Slider:SetValue(RaidRoll_DBPC[UnitName("player")]["Time_Offset"])
 
 
 
	_G[RaidRoll_Rolling_Time_Slider:GetName() .. 'Low']:SetText('5');
	_G[RaidRoll_Rolling_Time_Slider:GetName() .. 'High']:SetText('120'); 	
	_G[RaidRoll_Rolling_Time_Slider:GetName() .. 'Text']:SetText(RaidRoll_Rolling_Time_Slider:GetValue() + 60);


 RaidRoll_Rolling_Time_Slider:Show()
 
 
 
  RaidRoll_Rolling_Time_Slider:SetScript("OnValueChanged",function()
	RaidRoll_CheckButton_Update_Panel()
	_G[RaidRoll_Rolling_Time_Slider:GetName() .. 'Text']:SetText(RaidRoll_Rolling_Time_Slider:GetValue() + 60);
	RaidRoll_DBPC[UnitName("player")]["Time_Offset"] = RaidRoll_Rolling_Time_Slider:GetValue()
  end)
 ----------------------------------------------------RaidRoll_DBPC[UnitName("player")]["Time_Offset"]
 
 
 
 
	RR_Panel_GuildRankFrame = CreateFrame("Frame","RR_Panel_GuildRankFrame",RaidRoll_PriorityPanel)
	
	local backdrop = {
	  bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",  -- path to the background texture
	  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",  -- path to the border texture
	  
	  tile = true,    -- true to repeat the background texture to fill the frame, false to scale it
	  tileSize = 32,  -- size (width or height) of the square repeating background tiles (in pixels)
	  edgeSize = 20,  -- thickness of edge segments and square size of edge corners (in pixels)
	  insets = {    -- distance from the edges of the frame to those of the background texture (in pixels)
	    left = 4,
	    right = 4,
	    top = 4,
	    bottom = 4
	  }
	}


	RR_Panel_GuildRankFrame:SetBackdrop(backdrop)

	RR_Panel_GuildRankFrame:SetWidth(190) -- Set these to whatever height/width is needed 
	RR_Panel_GuildRankFrame:SetHeight(225) -- for your Texture
	RR_Panel_GuildRankFrame:SetPoint("TopRight",RaidRoll_PriorityPanel,"TopRight",-20,-45);
	
-- [  ] Give Higher Ranks Priority
	RR_RollCheckBox_RankPrio_panel = CreateFrame("CheckButton", "RaidRollCheckBox_RankPrio_panel", RR_Panel_GuildRankFrame, "UICheckButtonTemplate")
	RR_RollCheckBox_RankPrio_panel:SetWidth(20)
	RR_RollCheckBox_RankPrio_panel:SetHeight(20)
	RR_RollCheckBox_RankPrio_panel:SetPoint("TopLeft", RR_Panel_GuildRankFrame, "TopLeft", 8, -7)
	_G["RaidRollCheckBox_RankPrio_panel".."Text"]:SetText("|cFFFFFFFF" .. RAIDROLL_LOCALE["Give_Higher_Ranks_Priority"])
	if (GetLocale() ~= "zhTW") then
		_G["RaidRollCheckBox_RankPrio_panel".."Text"]:SetFont("Fonts\\FRIZQT__.TTF", 12)
	end
	if (GetLocale() == "zhCN") then
		_G["RaidRollCheckBox_RankPrio_panel".."Text"]:SetFont("Fonts\\ZYKai_T.TTF", 15)
	end
	RR_RollCheckBox_RankPrio_panel:SetScript("OnClick",RaidRoll_CheckButton_Update_Panel)
	
	
-- Create a list of the 10 Guild Ranks, the title "guild ranks" and a "not in guild" rank
	Raid_Roll_GuildRank_String = RR_Panel_GuildRankFrame:CreateFontString("Raid_Roll_GuildRank_String"..0 ,"ARTWORK","GameFontNormal");
	Raid_Roll_GuildRank_String:SetPoint("TOPLEFT",RR_Panel_GuildRankFrame,5, -8-25);
	Raid_Roll_GuildRank_String:SetJustifyH("LEFT")
	Raid_Roll_GuildRank_String:SetWidth(200); 
	Raid_Roll_GuildRank_String:SetHeight(11); 
	
	Raid_Roll_GuildRank_String:SetText(RAIDROLL_LOCALE["Guild_Rank"])
	
	
	for i=1,11 do
		Raid_Roll_GuildRank_String_i = RR_Panel_GuildRankFrame:CreateFontString("Raid_Roll_GuildRank_String"..i ,"ARTWORK","GameFontNormal");
		Raid_Roll_GuildRank_String_i:SetPoint("TOPLEFT",_G["Raid_Roll_GuildRank_String"..i-1],0, -15);
		Raid_Roll_GuildRank_String_i:SetJustifyH("LEFT")
		Raid_Roll_GuildRank_String_i:SetWidth(200); 
		Raid_Roll_GuildRank_String_i:SetHeight(11); 
		
		
		--Raid_Roll_GuildRank_String_i:SetText("# " .. i .. " : " .. GuildControlGetRankName(i))
		
		--if i == 10 then _G["Raid_Roll_GuildRank_String"..i]:SetText("#" .. i .. ": " .. GuildControlGetRankName(i)) end
		
		
		--	/run RR_Test(GetGuildInfoText())
		
		--if i == 11 then Raid_Roll_GuildRank_String_i:SetText("Not in Guild") end
	end
	
	

	
-- Create 11  priority indexes and the name "priorities"
	Raid_Roll_GuildPriority_String = RR_Panel_GuildRankFrame:CreateFontString("Raid_Roll_GuildPriority"..0 ,"ARTWORK","GameFontNormal");
	Raid_Roll_GuildPriority_String:SetPoint("TOPRIGHT",RR_Panel_GuildRankFrame,-8, -8-25);
	Raid_Roll_GuildPriority_String:SetJustifyH("RIGHT")
	Raid_Roll_GuildPriority_String:SetWidth(200); 
	Raid_Roll_GuildPriority_String:SetHeight(11); 
	
	Raid_Roll_GuildPriority_String:SetText(RAIDROLL_LOCALE["Priority"])
	
	for i=1,12 do
		if i ~= 12 then 
			Raid_Roll_GuildPriority_i = CreateFrame("Button", "Raid_Roll_GuildPriority"..i, RR_Panel_GuildRankFrame, "UIPanelButtonTemplate")
			Raid_Roll_GuildPriority_i:SetWidth(16)
			Raid_Roll_GuildPriority_i:SetHeight(16)
			Raid_Roll_GuildPriority_i:SetPoint("TOPRIGHT",_G["Raid_Roll_GuildPriority"..i-1],0, -15);
			
			Raid_Roll_GuildPriority_i:SetScript("OnClick",	function()
															RR_Priority_Modify(i)
															end)
		end
		
		
		if RaidRoll_DB["Rank Priority"]    == nil then RaidRoll_DB["Rank Priority"]    = {} end
		if RaidRoll_DB["Rank Priority"][i] == nil then RaidRoll_DB["Rank Priority"][i] = 11-i  end
		
		if i ~= 12 then Raid_Roll_GuildPriority_i:SetText(RaidRoll_DB["Rank Priority"][i]) end
	end
	
	RR_GuildRankUpdate()
	
	if RaidRoll_LootTrackerLoaded==true then
		RaidRoll_LootPanel_Setup()
	end
end


function RR_GuildRankUpdate()
	if IsInGuild() then
		RR_GetEPGPGuildData()
		if _G["Raid_Roll_GuildRank_String"..1] ~= nil then
			for i=1,11 do
				_G["Raid_Roll_GuildRank_String"..i]:SetText("# " .. i .. " : " .. GuildControlGetRankName(i))
				
				if i == 10 then _G["Raid_Roll_GuildRank_String"..i]:SetText("#" .. i .. ": " .. GuildControlGetRankName(i)) end
				
				
				--	/run RR_Test(GetGuildInfoText())
				
				if i == 11 then _G["Raid_Roll_GuildRank_String"..i]:SetText(RAIDROLL_LOCALE["Not_in_Guild"]) end
			end
		end
	end
end
	
function RR_Priority_Modify(Priority_Index)

	if RaidRoll_DB["debug"] == true then RR_Test("Priority_Index" .. Priority_Index) end

	RaidRoll_DB["Rank Priority"][Priority_Index] = RaidRoll_DB["Rank Priority"][Priority_Index] + 1

	if RaidRoll_DB["Rank Priority"][Priority_Index] >= 11 then RaidRoll_DB["Rank Priority"][Priority_Index] = 0 end

	_G["Raid_Roll_GuildPriority"..Priority_Index]:SetText(RaidRoll_DB["Rank Priority"][Priority_Index])

	rr_RollSort(rr_CurrentRollID)
	RR_Display(rr_CurrentRollID)
end

-- Called to update the options panel checkboxes
function RaidRoll_CheckButton_Update_Panel()

	if  RR_RollCheckBox_Num_Not_Req:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Num_Not_Req"] =  true
		RR_RollCheckBox_Num_Not_Req:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Num_Not_Req"] =  false
		RR_RollCheckBox_Num_Not_Req:SetChecked(false)
	end

	if  RR_RollCheckBox_Multi_Rollers:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Multi_Rollers"] =  true
		RR_RollCheckBox_Multi_Rollers:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Multi_Rollers"] =  false
		RR_RollCheckBox_Multi_Rollers:SetChecked(false)
	end
	
	if  RR_RollCheckBox_Track_EPGPSays:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_EPGPSays"] =  true
		RR_RollCheckBox_Track_EPGPSays:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_EPGPSays"] =  false
		RR_RollCheckBox_Track_EPGPSays:SetChecked(false)
	end

	if  RR_RollCheckBox_Track_Bids:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_Bids"] =  true
		RR_RollCheckBox_Track_Bids:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_Bids"] =  false
		RR_RollCheckBox_Track_Bids:SetChecked(false)
	end

	if  RR_RollCheckBox_GuildAnnounce:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_GuildAnnounce"] =  true
		RR_RollCheckBox_GuildAnnounce:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_GuildAnnounce"] =  false
		RR_RollCheckBox_GuildAnnounce:SetChecked(false)
	end

	if  RR_RollCheckBox_GuildAnnounce_Officer:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_GuildAnnounce_Officer"] =  true
		RR_RollCheckBox_GuildAnnounce_Officer:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_GuildAnnounce_Officer"] =  false
		RR_RollCheckBox_GuildAnnounce_Officer:SetChecked(false)
	end
	

	if  RR_RollCheckBox_No_countdown:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_No_countdown"] =  true
		RR_RollCheckBox_No_countdown:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_No_countdown"] =  false
		RR_RollCheckBox_No_countdown:SetChecked(false)
	end


	if  RR_RollCheckBox_Auto_Close:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Close"] =  true
		RR_RollCheckBox_Auto_Close:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Close"] =  false
		RR_RollCheckBox_Auto_Close:SetChecked(false)
	end

	if RaidRoll_LootTrackerLoaded==true then
		if  RR_ReceiveGuildMessages:GetChecked() then
			RaidRoll_DBPC[UnitName("player")]["RR_ReceiveGuildMessages"] =  true
			RR_ReceiveGuildMessages:SetChecked(true)
		else
			RaidRoll_DBPC[UnitName("player")]["RR_ReceiveGuildMessages"] =  false
			RR_ReceiveGuildMessages:SetChecked(false)
		end
		
		if  RR_Frame_WotLK_Dung_Only:GetChecked() then
			RaidRoll_DBPC[UnitName("player")]["RR_Frame_WotLK_Dung_Only"] =  true
			RR_Frame_WotLK_Dung_Only:SetChecked(true)
		else
			RaidRoll_DBPC[UnitName("player")]["RR_Frame_WotLK_Dung_Only"] =  false
			RR_Frame_WotLK_Dung_Only:SetChecked(false)
		end
		
		
		if  RR_Enable3Messages:GetChecked() then
			RaidRoll_DBPC[UnitName("player")]["RR_Enable3Messages"] =  true
			RR_Enable3Messages:SetChecked(true)
			for i=1,4 do
				_G["RR_Loot_Announce_1_Button_"..i]:SetWidth(33)
				_G["RR_Loot_Announce_2_Button_"..i]:SetWidth(33)
				_G["RR_Loot_Announce_3_Button_"..i]:Show()
				RR_Loot_Display_Refresh()
			end
		else
			RaidRoll_DBPC[UnitName("player")]["RR_Enable3Messages"] =  false
			RR_Enable3Messages:SetChecked(false)
			for i=1,4 do
				_G["RR_Loot_Announce_1_Button_"..i]:SetWidth(50)
				_G["RR_Loot_Announce_2_Button_"..i]:SetWidth(50)
				_G["RR_Loot_Announce_3_Button_"..i]:Hide()
				RR_Loot_Display_Refresh()
			end
		end
		
		if  RR_AutoOpenLootWindow:GetChecked() then
			RaidRoll_DBPC[UnitName("player")]["RR_AutoOpenLootWindow"] =  true
			RR_AutoOpenLootWindow:SetChecked(true)
		else
			RaidRoll_DBPC[UnitName("player")]["RR_AutoOpenLootWindow"] =  false
			RR_AutoOpenLootWindow:SetChecked(false)
		end
	end


--RaidRoll_Allow_All:SetChecked(true);
	if  RR_RollCheckBox_Unannounced_panel:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] =  true
		RaidRoll_Catch_All:SetChecked(true)
		RR_RollCheckBox_Unannounced_panel:SetChecked(true)
		--RR_Test("Raid Roll: Auto-Tracking Rolls Enabled")
	else
		RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] =  false
		RaidRoll_Catch_All:SetChecked(false)
		RR_RollCheckBox_Unannounced_panel:SetChecked(false)
		--RR_Test("Raid Roll: Auto-Tracking Rolls Disabled")
	end
	
	
	if  RR_RollCheckBox_Auto_Announce:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Announce"] =  true
		RR_RollCheckBox_Auto_Announce:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Announce"] =  false
		RR_RollCheckBox_Auto_Announce:SetChecked(false)
	end
	

	if  RR_RollCheckBox_AllRolls_panel:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] =  true
		RaidRoll_Allow_All:SetChecked(true)
		RR_RollCheckBox_AllRolls_panel:SetChecked(true)
		--RR_Test("Raid Roll: All rolls accepted")
	else
		RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] =  false
		RaidRoll_Allow_All:SetChecked(false)
		RR_RollCheckBox_AllRolls_panel:SetChecked(false)
		--RR_Test("Raid Roll: Only 1-100 rolls accepted")
	end
	
	if RR_RollCheckBox_ExtraRolls_panel:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] =  true
		RR_RollCheckBox_ExtraRolls:SetChecked(true)
		RR_RollCheckBox_ExtraRolls_panel:SetChecked(true)
		--RR_Test("Raid Roll: All rolls accepted")
	else
		RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] =  false
		RR_RollCheckBox_ExtraRolls:SetChecked(false)
		RR_RollCheckBox_ExtraRolls_panel:SetChecked(false)
		--RR_Test("Raid Roll: Only 1-100 rolls accepted")
	end

	
	
	
	
	
	if  RR_RollCheckBox_ShowRanks_panel:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_Show_Ranks"] =  true
		--RR_RollCheckBox_ShowRanks:SetChecked(true)
		RR_RollCheckBox_ShowRanks_panel:SetChecked(true)
		for i=1,6 do
			_G["Raid_Roll_Rank_String"..i-1]:Show()
		end
		RR_RollFrame:SetWidth(265+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"])
		_G["RR_Rolled"]:ClearAllPoints()
		_G["RR_Rolled"]:SetPoint("TOPLEFT", _G["RR_RollFrame"], "TOPLEFT",170+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"],-30)
		
		_G["RR_Group0"]:ClearAllPoints()
		_G["RR_Group0"]:SetPoint("TOPLEFT", _G["RR_RollFrame"], "TOPLEFT",220+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"],-30)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_Show_Ranks"] =  false
		--RR_RollCheckBox_ShowRanks:SetChecked(false)
		RR_RollCheckBox_ShowRanks_panel:SetChecked(false)
		for i=1,6 do
			
			_G["Raid_Roll_Rank_String"..i-1]:Hide()
		end
		RR_RollFrame:SetWidth(215+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"])
		_G["RR_Rolled"]:ClearAllPoints()
		_G["RR_Rolled"]:SetPoint("TOPLEFT", _G["RR_RollFrame"], "TOPLEFT",120+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"],-30)
		
		_G["RR_Group0"]:ClearAllPoints()
		_G["RR_Group0"]:SetPoint("TOPLEFT", _G["RR_RollFrame"], "TOPLEFT",170+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"],-30)
		
	end
	
	if RR_RollCheckBox_ShowGroupNumber_panel:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_ShowGroupNumber"] =  true
		RR_RollCheckBox_ShowGroupNumber_panel:SetChecked(true)
		
		for i=1,6 do
			_G["RR_Group"..i-1]:Show()
		end
		
		--RR_RollFrame:SetWidth(215+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"])
	else
		RaidRoll_DBPC[UnitName("player")]["RR_ShowGroupNumber"] =  false
		RR_RollCheckBox_ShowGroupNumber_panel:SetChecked(false)
		
		for i=1,6 do
			_G["RR_Group"..i-1]:Hide()
		end
		
		RR_RollFrame:SetWidth(RR_RollFrame:GetWidth() - 30)
	end
	
	if RR_RollCheckBox_ShowClassColors_panel:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_ShowClassColors"] =  true
		RR_RollCheckBox_ShowClassColors_panel:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_ShowClassColors"] =  false
		RR_RollCheckBox_ShowClassColors_panel:SetChecked(false)
	end
	
	
	if RR_RollCheckBox_RankPrio_panel:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_RankPriority"] =  true
		--RR_RollCheckBox_RankPrio:SetChecked(true)
		RR_RollCheckBox_RankPrio_panel:SetChecked(true)
		--RR_Test("Raid Roll: All rolls accepted")
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RankPriority"] =  false
		--RR_RollCheckBox_RankPrio:SetChecked(false)
		RR_RollCheckBox_RankPrio_panel:SetChecked(false)
		--RR_Test("Raid Roll: Only 1-100 rolls accepted")
	end
	
	
	if RR_RollCheckBox_EPGPMode_panel:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] =  true
		RR_RollCheckBox_EPGPMode_panel:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] =  false
		RR_RollCheckBox_EPGPMode_panel:SetChecked(false)
	end
	
	if RR_RollCheckBox_EPGPThreshold_panel:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Priority"] =  true
		RR_RollCheckBox_EPGPThreshold_panel:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Priority"] =  false
		RR_RollCheckBox_EPGPThreshold_panel:SetChecked(false)
	end
	
	if RR_RollCheckBox_Enable_Alt_Mode:GetChecked() then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Enable_Alt_Mode"] =  true
		RR_RollCheckBox_Enable_Alt_Mode:SetChecked(true)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Enable_Alt_Mode"] =  false
		RR_RollCheckBox_Enable_Alt_Mode:SetChecked(false)
	end

	
	rr_RollSort(rr_CurrentRollID)
	
	if RR_HasDisplayedAlready ~= nil then
		RR_Display(rr_CurrentRollID)
	end
	
	for i=1,5 do
		_G["Raid_Roll_Rank_String"..i]:SetWidth(65+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"]); 
	end
end
