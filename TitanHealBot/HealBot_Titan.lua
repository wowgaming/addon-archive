TITAN_HEALBOT_ID="HealBot"

HealBot_Spells = {}
local returnText = ""
local dimColour_r=0.52;
local dimColour_g=0.52;
local dimColour_b=0.52;
local thb_ver=nil
local thb_tt=nil
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)

function TitanPanelHealBotButton_OnLoad(self)
	thb_ver = HealBot_RetVersion()
	thb_tt = "HealBot Options"
    self.registry = {
      id = TITAN_HEALBOT_ID,
      menuText = TITAN_HEALBOT_ID,
      version = thb_ver,
      buttonTextFunction = "HealBot_Titan_GetButtonText",
      category = "Interface",
      tooltipTitle = thb_tt,
      tooltipTextFunction = "HealBot_Titan_GetTooltipText",
  	  icon = "Interface\\AddOns\\TitanHealBot\\Images\\HealBot",
      iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
	  	}
    };
    
    HealBot_Titan_Installed(TITAN_HEALBOT_ID)
end

function HealBot_Titan_GetTooltipText()
    return HEALBOT_TITAN_TOOLTIP;
end

local castingTarget, healValue
function HealBot_Titan_GetButtonText()
    returnText = ""
    dimColour_r=0.52;
	dimColour_g=0.52;
	dimColour_b=0.52;
	if not HealBot_PlayerName then return TitanUtils_GetNormalText("HealBot"); end
    
    if (TitanGetVar(TITAN_HEALBOT_ID, "ShowColoredText")) then 
      if HealBot_Config.DisableHealBot==1 then
        if (TitanGetVar(TITAN_HEALBOT_ID, "ShowLabelText")) then 
          returnText=TitanUtils_GetNormalText("HealBot: ");
          return returnText..TitanUtils_GetNormalText("Disabled");
        else
          return TitanUtils_GetNormalText("Disabled");
        end
      else
        castingTarget, healValue=TitanPanel_GetCastingInfo()
        if castingTarget then
          if (TitanGetVar(TITAN_HEALBOT_ID, "ShowLabelText")) then 
            returnText=TitanUtils_GetNormalText("HealBot: ");
          end
          returnText=returnText..TitanUtils_GetHighlightText(castingTarget.." +")
          returnText=returnText..TitanUtils_GetGreenText(healValue)
          return returnText;
        end
      end
    else
      if HealBot_Config.DisableHealBot==1 then
        if (TitanGetVar(TITAN_HEALBOT_ID, "ShowLabelText")) then 
          returnText=TitanUtils_GetNormalText("HealBot: ");
          return returnText..TitanUtils_GetNormalText("Disabled", dimColour_r,dimColour_g,dimColour_b);
        else
          return TitanUtils_GetNormalText("Disabled", dimColour_r,dimColour_g,dimColour_b);
        end
      else
        castingTarget, healValue=TitanPanel_GetCastingInfo()
        if castingTarget then
          if (TitanGetVar(TITAN_HEALBOT_ID, "ShowLabelText")) then 
            returnText=TitanUtils_GetNormalText("HealBot: ");
          end
          returnText=returnText..TitanUtils_GetNormalText(castingTarget.." +")
          returnText=returnText..TitanUtils_GetNormalText(healValue)
          return returnText;
        end
      end
    end

    if (TitanGetVar(TITAN_HEALBOT_ID, "ShowLabelText")) then 
      return "HealBot";
    else
      return nil
    end
end

local cTarget, hValue
function TitanPanel_GetCastingInfo()
  cTarget, hValue=HealBot_Titan_Check()
  return cTarget, hValue
end

local info = {}
local currentLevel=0
local HealBot_Titan_Bars_List = {}
local HealBot_Titan_EmergencyFilter_List = {}
local HealBot_Titan_ExtraSort_List = {}
local skinName = nil
function TitanPanelRightClickMenu_PrepareHealBotMenu()
 if HealBot_PlayerName then
  HealBot_Titan_Bars_List = {
      HEALBOT_OPTIONS_SELFHEALS,
      HEALBOT_OPTIONS_GROUPHEALS,
      HEALBOT_OPTIONS_TANKHEALS,
      HEALBOT_OPTIONS_EMERGENCYHEALS,
      HEALBOT_OPTIONS_PETHEALS,
      HEALBOT_OPTIONS_MYTARGET,
      HEALBOT_FOCUS,
      HEALBOT_VEHICLE,
      }
  
  HealBot_Titan_EmergencyFilter_List = {
      HEALBOT_CLASSES_ALL,
      HEALBOT_DEATHKNIGHT,
      HEALBOT_DRUID,
      HEALBOT_HUNTER,
      HEALBOT_MAGE,
      HEALBOT_PALADIN,
      HEALBOT_PRIEST,
      HEALBOT_ROGUE,
      HEALBOT_SHAMAN,
      HEALBOT_WARLOCK,
      HEALBOT_WARRIOR,
      HEALBOT_CLASSES_MELEE,
      HEALBOT_CLASSES_RANGES,
      HEALBOT_CLASSES_HEALERS,
      HEALBOT_CLASSES_CUSTOM,
      }

  HealBot_Titan_ExtraSort_List = {
      HEALBOT_SORTBY_NAME,
      HEALBOT_SORTBY_CLASS,
      HEALBOT_SORTBY_GROUP,
      HEALBOT_SORTBY_MAXHEALTH,
      }
  
  if UIDROPDOWNMENU_MENU_LEVEL == 1 then
    TitanPanelRightClickMenu_AddTitle(TITAN_HEALBOT_ID.." "..thb_ver) --TitanPlugins[TITAN_HEALBOT_ID].menuText)
    TitanPanelRightClickMenu_AddSpacer();
        
    for x,_ in pairs(info) do
      info[x]=nil
    end
	info.text = HEALBOT_TITAN_SMARTCAST
	info.func = HealBot_Titan_ToggleSmartCast;
	info.checked = HealBot_Options_EnableSmartCast:GetChecked();
    info.value = HealBot_Config.SmartCast;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

    for x,_ in pairs(info) do
      info[x]=nil
    end
	info.text = HEALBOT_TITAN_MONITORBUFFS
	info.func = HealBot_Titan_ToggleMonitorBuffs;
	info.checked = HealBot_Options_MonitorBuffs:GetChecked();
    info.value = HealBot_Config.BuffWatch;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    for x,_ in pairs(info) do
      info[x]=nil
    end
	info.text = HEALBOT_TITAN_MONITORDEBUFFS
	info.func = HealBot_Titan_ToggleMonitorDebuffs;
	info.checked = HealBot_Options_MonitorDebuffs:GetChecked();
    info.value = HealBot_Config.DebuffWatch;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    TitanPanelRightClickMenu_AddSpacer();

    for x,_ in pairs(info) do
      info[x]=nil
    end
	info.text = HEALBOT_OPTIONS_TAB_SKIN;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    for x,_ in pairs(info) do
      info[x]=nil
    end
	info.text = HEALBOT_OPTIONS_ALERTLEVEL;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    for x,_ in pairs(info) do
      info[x]=nil
    end
	info.text = HEALBOT_TITAN_SHOWBARS;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
    for x,_ in pairs(info) do
      info[x]=nil
    end
	info.text = HEALBOT_TITAN_EXTRABARS;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
	TitanPanelRightClickMenu_AddSpacer()	

	TitanPanelRightClickMenu_AddToggleIcon(TITAN_HEALBOT_ID)
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_HEALBOT_ID)
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_HEALBOT_ID)

    TitanPanelRightClickMenu_AddSpacer()	
        
    for x,_ in pairs(info) do
      info[x]=nil
    end
	info.text = HEALBOT_OPTIONS_DISABLEHEALBOT;
	info.func = HealBot_Titan_ToggleDisable;
	info.checked = HealBot_Options_DisableHealBot:GetChecked();
    info.value = HealBot_Config.DisableHealBot;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
	TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_HEALBOT_ID, TITAN_PANEL_MENU_FUNC_HIDE)
    
    x=HealBot_Comms_ReportVer()
    if x then
        TitanPanelRightClickMenu_AddSpacer()	
        TitanPanelRightClickMenu_AddTitle("Version "..x)
        TitanPanelRightClickMenu_AddTitle("is available at")
        TitanPanelRightClickMenu_AddTitle("healbot.alturl.com")
    end
    
  elseif UIDROPDOWNMENU_MENU_LEVEL == 2 then
    if UIDROPDOWNMENU_MENU_VALUE == HEALBOT_OPTIONS_TAB_SKIN then
        TitanPanelRightClickMenu_AddTitle(HEALBOT_OPTIONS_TAB_SKIN, UIDROPDOWNMENU_MENU_LEVEL);
        for i in pairs (Healbot_Config_Skins.Skins) do
            for x,_ in pairs(info) do
                info[x]=nil
            end
            info.text = Healbot_Config_Skins.Skins[i];
            info.func = HealBot_Titan_SkinUpdate;
            info.value = Healbot_Config_Skins.Skins[i];
            if Healbot_Config_Skins.Skins[i]==Healbot_Config_Skins.Current_Skin then info.checked=true; end
            UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
        end
    elseif UIDROPDOWNMENU_MENU_VALUE == HEALBOT_OPTIONS_ALERTLEVEL then
      TitanPanelRightClickMenu_AddTitle(HEALBOT_OPTIONS_ALERTLEVEL, UIDROPDOWNMENU_MENU_LEVEL);
      
      currentLevel=ceil((Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Current_Skin]*100)/5)*5
      if currentLevel>100 then currentLevel=100; end
      if currentLevel<5 then currentLevel=5; end

      for i=100, 5, -5 do
        for x,_ in pairs(info) do
          info[x]=nil
        end
        info.text = i;
        info.func = HealBot_Titan_AlertLevelUpdate;
        info.value = i;
        if i==currentLevel then info.checked=true; end
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      end

    elseif UIDROPDOWNMENU_MENU_VALUE == HEALBOT_TITAN_SHOWBARS then
      TitanPanelRightClickMenu_AddTitle(HEALBOT_TITAN_SHOWBARS, UIDROPDOWNMENU_MENU_LEVEL);
    
      for i=1, getn(HealBot_Titan_Bars_List), 1 do
        for x,_ in pairs(info) do
          info[x]=nil
        end
        info.text = HealBot_Titan_Bars_List[i];
        info.func = HealBot_Titan_BarsUpdate;
        info.checked = HealBot_Titan_BarsChecked(i)
        info.value = HealBot_Titan_Bars_List[i];
        info.keepShownOnClick = 1;
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      end

    elseif UIDROPDOWNMENU_MENU_VALUE == HEALBOT_TITAN_EXTRABARS then
      TitanPanelRightClickMenu_AddTitle(HEALBOT_TITAN_EXTRABARS, UIDROPDOWNMENU_MENU_LEVEL);

      for x,_ in pairs(info) do
        info[x]=nil
      end
	  info.text = HEALBOT_OPTIONS_EMERGFILTER;
	  info.hasArrow = 1;
	  UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
      for x,_ in pairs(info) do
        info[x]=nil
      end
	  info.text = HEALBOT_OPTIONS_EMERGFILTERGROUPS;
	  info.hasArrow = 1;
	  UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    
      for x,_ in pairs(info) do
        info[x]=nil
      end
	  info.text = HEALBOT_OPTIONS_EXTRASORT;
	  info.hasArrow = 1;
      UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
    end
  elseif UIDROPDOWNMENU_MENU_LEVEL == 3 then
    if UIDROPDOWNMENU_MENU_VALUE == HEALBOT_OPTIONS_EMERGFILTER then
      TitanPanelRightClickMenu_AddTitle(HEALBOT_OPTIONS_EMERGFILTER, UIDROPDOWNMENU_MENU_LEVEL);
    

      
      for i=1, getn(HealBot_Titan_EmergencyFilter_List), 1 do
        for x,_ in pairs(info) do
          info[x]=nil
        end
        info.text = HealBot_Titan_EmergencyFilter_List[i];
        info.func = HealBot_Titan_EFUpdate;
        if i==Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin] then info.checked = true; end
        info.value = i;
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      end
      
    elseif UIDROPDOWNMENU_MENU_VALUE == HEALBOT_OPTIONS_EMERGFILTERGROUPS then
      TitanPanelRightClickMenu_AddTitle(HEALBOT_OPTIONS_EMERGFILTERGROUPS, UIDROPDOWNMENU_MENU_LEVEL);
      
      for i=1, 8, 1 do
        for x,_ in pairs(info) do
          info[x]=nil
        end
        info.text = HEALBOT_OPTIONS_GROUPHEALS.." "..i;
        info.func = HealBot_Titan_ExtraGroupsUpdate;
        if Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][i] then
          info.value = 1;
        else
          info.value = 0;
        end
        info.keepShownOnClick = 1;
        info.checked=HealBot_Titan_ExtraGroupsChecked(i)
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      end

    elseif UIDROPDOWNMENU_MENU_VALUE == HEALBOT_OPTIONS_EXTRASORT then
      TitanPanelRightClickMenu_AddTitle(HEALBOT_OPTIONS_EXTRASORT, UIDROPDOWNMENU_MENU_LEVEL);
          
      for i=1, getn(HealBot_Titan_ExtraSort_List), 1 do
        for x,_ in pairs(info) do
          info[x]=nil
        end
        info.text = HealBot_Titan_ExtraSort_List[i];
        info.func = HealBot_Titan_ESUpdate;
        if i==Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin] then info.checked = true; end
        info.value = i;
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      end
    end
  end
 end
end

function HealBot_Titan_ToggleDisable()
  if this.value==1 then
    HealBot_Config.DisableHealBot=0;
  else
    HealBot_Config.DisableHealBot=1;
  end
  HealBot_Options_DisableHealBot:SetChecked(HealBot_Config.DisableHealBot);
  TitanToggleVar(TITAN_HEALBOT_ID, this:GetID());
  if HealBot_Config.DisableHealBot==0 then
    HealBot_Action_ResetUnitStatus()
    HealBot_DelayData=1;
    Delay_RecalcParty=3;
    ShowUIPanel(HealBot_Action);
  else
    HideUIPanel(HealBot_Action);
  end
end

function HealBot_Titan_ToggleSmartCast()
  if this.value==1 then
    HealBot_Config.SmartCast=0;
  else
    HealBot_Config.SmartCast=1;
  end
  HealBot_Options_EnableSmartCast:SetChecked(HealBot_Config.SmartCast);
  TitanToggleVar(TITAN_HEALBOT_ID, this:GetID());
end

function HealBot_Titan_ToggleMonitorBuffs()
  if this.value==1 then
    HealBot_Config.BuffWatch=0;
  else
    HealBot_Config.BuffWatch=1;
  end
  HealBot_Options_MonitorBuffs:SetChecked(HealBot_Config.BuffWatch);
  TitanToggleVar(TITAN_HEALBOT_ID, this:GetID());
  if HealBot_Config.BuffWatch==0 then
    HealBot_Options_MonitorBuffsInCombat:Disable();
    HealBot_DelayBuffCheck = {};
    HealBot_UnitBuff = {};
  else
    HealBot_Options_MonitorBuffsInCombat:Enable();
    HealBot_Options_Buff_Reset()
  end
end

function HealBot_Titan_ToggleMonitorDebuffs()
  if this.value==1 then
    HealBot_Config.DebuffWatch=0;
  else
    HealBot_Config.DebuffWatch=1;
  end
  HealBot_Options_MonitorDebuffs:SetChecked(HealBot_Config.DebuffWatch);
  TitanToggleVar(TITAN_HEALBOT_ID, this:GetID());
  if HealBot_Config.DebuffWatch==0 then
    HealBot_Options_MonitorDebuffsInCombat:Disable();
    HealBot_DelayDebuffCheck = {};
    HealBot_UnitDebuff = {};
  else
    HealBot_Options_MonitorDebuffsInCombat:Enable();
    HealBot_Options_Debuff_Reset()
  end
end

function HealBot_Titan_BarsChecked(i)
  if i==1 then
    return HealBot_Options_SelfHeals:GetChecked();
  elseif i==2 then
    return HealBot_Options_GroupHeals:GetChecked();
  elseif i==3 then
    return HealBot_Options_TankHeals:GetChecked();
  elseif i==4 then
    return HealBot_Options_EmergencyHeals:GetChecked();
  elseif i==5 then
    return HealBot_Options_PetHeals:GetChecked();
  elseif i==6 then
    return HealBot_Options_MyTargetsList:GetChecked();
  elseif i==7 then
    return HealBot_Options_FocusBar:GetChecked();
  elseif i==8 then
    return HealBot_Options_VehicleHeals:GetChecked();
  end
end

function HealBot_Titan_BarsUpdate()
    local newValue = 0;
    if this.checked then
      newValue=1;
    end

    if this.value==HEALBOT_OPTIONS_SELFHEALS then
      Healbot_Config_Skins.SelfHeals[Healbot_Config_Skins.Current_Skin]=newValue;
      HealBot_Options_SelfHeals:SetChecked(Healbot_Config_Skins.SelfHeals[Healbot_Config_Skins.Current_Skin]);
    end
    if this.value==HEALBOT_OPTIONS_GROUPHEALS then
      Healbot_Config_Skins.GroupHeals[Healbot_Config_Skins.Current_Skin]=newValue;
      HealBot_Options_GroupHeals:SetChecked(Healbot_Config_Skins.GroupHeals[Healbot_Config_Skins.Current_Skin]);
    end
    if this.value==HEALBOT_OPTIONS_TANKHEALS then
      Healbot_Config_Skins.TankHeals[Healbot_Config_Skins.Current_Skin]=newValue;
      HealBot_Options_TankHeals:SetChecked(Healbot_Config_Skins.TankHeals[Healbot_Config_Skins.Current_Skin]);
    end
    if this.value==HEALBOT_OPTIONS_SELFHEALS.." "..HEALBOT_OPTIONS_PETHEALS then
      Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Current_Skin]=newValue;
      HealBot_Options_SelfPet:SetChecked(Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Current_Skin]);
    end
    if this.value==HEALBOT_OPTIONS_EMERGENCYHEALS then
      Healbot_Config_Skins.EmergencyHeals[Healbot_Config_Skins.Current_Skin]=newValue;
      HealBot_Options_EmergencyHeals:SetChecked(Healbot_Config_Skins.EmergencyHeals[Healbot_Config_Skins.Current_Skin]);
    end
    if this.value==HEALBOT_OPTIONS_PETHEALS then
      Healbot_Config_Skins.PetHeals[Healbot_Config_Skins.Current_Skin]=newValue;
      HealBot_Options_PetHeals:SetChecked(Healbot_Config_Skins.PetHeals[Healbot_Config_Skins.Current_Skin]);
    end
    if this.value==HEALBOT_OPTIONS_MYTARGET then
      Healbot_Config_Skins.ShowMyTargetsList[Healbot_Config_Skins.Current_Skin]=newValue;
      HealBot_Options_MyTargetsList:SetChecked(Healbot_Config_Skins.ShowMyTargetsList[Healbot_Config_Skins.Current_Skin]);
    end
    if this.value==HEALBOT_FOCUS then
      Healbot_Config_Skins.SetFocusBar[Healbot_Config_Skins.Current_Skin]=newValue;
      HealBot_Options_FocusBar:SetChecked(Healbot_Config_Skins.SetFocusBar[Healbot_Config_Skins.Current_Skin]);
    end
    if this.value==HEALBOT_VEHICLE then
      Healbot_Config_Skins.VehicleHeals[Healbot_Config_Skins.Current_Skin]=newValue;
      HealBot_Options_VehicleHeals:SetChecked(Healbot_Config_Skins.VehicleHeals[Healbot_Config_Skins.Current_Skin]);
    end
    TitanToggleVar(TITAN_HEALBOT_ID, this:GetID());
    Delay_RecalcParty=2;
end

function HealBot_Titan_AlertLevelUpdate()
  Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Current_Skin]=this.value/100;
  HealBot_Options_AlertLevel:SetValue(Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Current_Skin]);
  TitanToggleVar(TITAN_HEALBOT_ID, this:GetID());
end

function HealBot_Titan_SkinUpdate()
  HealBot_Options_Set_Current_Skin(this.value);
  TitanToggleVar(TITAN_HEALBOT_ID, this:GetID());
end

function HealBot_Titan_EFUpdate()
  Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]=this.value;
  HealBot_Options_EmergencyFilter_Refresh();
  Delay_RecalcParty=3;
end

function HealBot_Titan_ExtraGroupsChecked(i)
  local objName=_G["HealBot_Options_EFGroup"..i];
  return objName:GetChecked();
end

local g=nil
function HealBot_Titan_ExtraGroupsUpdate()
  local id = this:GetID()-1
  if this.value==1 then
    Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][id]=false;
    this.value=0;
    g=_G["HealBot_Options_EFGroup"..id]
    g:SetChecked(nil)
  else
    Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][id]=true;
    this.value=1;
    g=_G["HealBot_Options_EFGroup"..id]
    g:SetChecked(1)
  end
  TitanToggleVar(TITAN_HEALBOT_ID, this:GetID());
end

function HealBot_Titan_ESUpdate()
  Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]=this.value;
  HealBot_Options_ExtraSort_Refresh();
  Delay_RecalcParty=3;
end

function TitalPanelHealBotButton_OnClick(self, button)
  if button~="RightButton" and HealBot_PlayerName then
    HealBot_ToggleOptions()
  end
end
