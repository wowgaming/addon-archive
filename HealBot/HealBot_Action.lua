local class=nil
local HealBot_UnitStatus={};
local HealBot_PlayerDead=false;
local HealBot_CheckGroup=0;
local HealBot_Enabled={};
local HealBot_PetMaxH={};
local HealBot_PetMaxHcnt1={};
local HealBot_PetMaxHcnt2={};
local HealBot_AttribStatus={};
local HealBot_UnitRange={}
local HealBot_UnitRangeSpell={}
local HealBot_UnitRanger={}
local HealBot_UnitRangeg={}
local HealBot_UnitRangeb={}
local HealBot_UnitRangea={}
local HealBot_UnitRangeb3a={}
local HealBot_UnitRangeitr={}
local HealBot_UnitRangeitg={}
local HealBot_UnitRangeitb={}
local HealBot_UnitRangeotr={}
local HealBot_UnitRangeotg={}
local HealBot_UnitRangeotb={}
local HealBot_UnitRangeota={}
local HealBot_curUnitHealth={}
local HealBot_UnitBarUpdate={}
local HealBot_UnitOffline={}
local HealBot_ResetAttribs=nil
local ceil=ceil;
local b=nil
local btHBbarText=nil
local bttextlen=0
local bthlthdelta=0
local floor=floor
local strsub=strsub
local HealBot_ButtonStore={}
local HealBot_hSpell=HEALBOT_HEAVY_RUNECLOTH_BANDAGE
local HealBot_bSpell=HEALBOT_HEAVY_RUNECLOTH_BANDAGE
local HealBot_dSpell=HEALBOT_HEAVY_RUNECLOTH_BANDAGE
local HealBot_rSpell=HEALBOT_HEAVY_RUNECLOTH_BANDAGE

local HealBot_ButtonArray1={}
local HealBot_ButtonArray2={}
local HealBot_ButtonArray=1
local HealBot_Aggro={}
local HealBot_AggroBar4={}
local HealBot_AggroBarA=0.8
local HealBot_AggroBarAup=true
local HealBot_MyTargets={}
local HB_Action_Timer1 = 2000
local HB_Action_Timer2 = 2000

local HealBot_Unit_Bar1={}
local HealBot_Unit_Bar2={}
local HealBot_Unit_Bar3={}
local HealBot_Unit_Bar4={}

local rangeSpell=nil
local sID=nil
local sName=nil
local uHealIn=nil
local uHlth=nil
local uMaxHlth=nil
local uName=nil
local xButton=nil
local xUnit=nil
local xGUID=nil
local x=nil
local y=nil
local z=nil
local vUnit=nil
local HealBot_FrameMoving=nil
local LSM = LibStub("LibSharedMedia-3.0")
local HealBot_UnitThreat={}
local HealBot_ResetBarSkinDone={}
local HealBot_curGUID=nil
local HealBot_Hightlight={}
local HealBot_GUID={}
local HealBot_Reserved={}

-- Register Default HealBot Media
for i = 1, #HealBot_Default_Textures do
    LSM:Register("statusbar", HealBot_Default_Textures[i].name, HealBot_Default_Textures[i].file)
end
for i = 1, #HealBot_Default_Sounds do
    LSM:Register("sound", HealBot_Default_Sounds[i].name, HealBot_Default_Sounds[i].file)
end

local barName=nil
local barTemp=nil
local HealBot_prevUnitThreat={}
local Healbot_tempUnitThreat=0
local UnitDebuffStatus={}
local HealBot_UnitThreatPct={}
local hbprevThreatPct=-1
local hbtempThreatPct=-1
-- local HealBot_resetUnitStatus=nil
function HealBot_Action_UpdateAggro(unit,status,threatStatus,hbGUID,threatPct)
    uName=UnitName(unit)
    barName=HealBot_Unit_Bar4[unit]
    if unit and not hbGUID then hbGUID=HealBot_GUID[unit] end
    
    if not barName or not uName or not hbGUID then 
        return 
    end    
    if UnitIsDeadOrGhost(unit) and not UnitIsFeignDeath(unit) then
        status=nil
        threatPct=0
        if threatStatus then threatStatus=0 end
    end
    hbprevThreatPct=HealBot_UnitThreatPct[hbGUID] or -3
    if threatStatus and (Healbot_Config_Skins.ShowAggroBarsPct[Healbot_Config_Skins.Current_Skin]==1 or Healbot_Config_Skins.ShowAggroTextPct[Healbot_Config_Skins.Current_Skin]==1) then
        if not threatPct then
            hbtempThreatPct=HealBot_CalcThreat(unit)
            if hbtempThreatPct==100 and threatStatus<2 then threatStatus=2 end
        else
            hbtempThreatPct=threatPct
        end
        if threatStatus==3 then
            if hbtempThreatPct and hbtempThreatPct>0 then
                HealBot_UnitThreatPct[hbGUID]=hbtempThreatPct
            else
                HealBot_UnitThreatPct[hbGUID]=100
            end
        elseif threatStatus==2 then
            if hbtempThreatPct and hbtempThreatPct>0 then
                HealBot_UnitThreatPct[hbGUID]=hbtempThreatPct
            elseif not HealBot_UnitThreatPct[hbGUID] then
                HealBot_UnitThreatPct[hbGUID]=75
            elseif HealBot_UnitThreatPct[hbGUID]<90 then 
                HealBot_UnitThreatPct[hbGUID]=HealBot_UnitThreatPct[hbGUID]+1
            end
        elseif threatStatus==1 then
            if hbtempThreatPct and hbtempThreatPct>0 then
                HealBot_UnitThreatPct[hbGUID]=hbtempThreatPct
            elseif not HealBot_UnitThreatPct[hbGUID] then
                HealBot_UnitThreatPct[hbGUID]=25
            elseif HealBot_UnitThreatPct[hbGUID]>10 then 
                HealBot_UnitThreatPct[hbGUID]=HealBot_UnitThreatPct[hbGUID]-1
            end
        elseif threatStatus==0 then
            if hbtempThreatPct and hbtempThreatPct>0 then
                threatStatus=1
                HealBot_UnitThreatPct[hbGUID]=hbtempThreatPct
                if not status then status=true end
            else
                HealBot_UnitThreatPct[hbGUID]=0
            end
        elseif threatStatus>4 then 
            if hbtempThreatPct and hbtempThreatPct>0 then
                HealBot_UnitThreatPct[hbGUID]=hbtempThreatPct
            elseif not HealBot_UnitThreatPct[hbGUID] then
                HealBot_UnitThreatPct[hbGUID]=50
            end
        elseif hbtempThreatPct and hbtempThreatPct>0 then
            HealBot_UnitThreatPct[hbGUID]=hbtempThreatPct
        else
            HealBot_UnitThreatPct[hbGUID]=0
        end
    else
        if not threatStatus then threatStatus=0 end
        HealBot_UnitThreatPct[hbGUID]=0
    end
    if HealBot_UnitThreatPct[hbGUID]>100 then
        HealBot_UnitThreatPct[hbGUID]=100
    else
        HealBot_UnitThreatPct[hbGUID]=HealBot_Comm_round(HealBot_UnitThreatPct[hbGUID], 0)
    end
    if status then
        if HealBot_Config.CDCshownAB==1 and UnitDebuffStatus[hbGUID] then
            HealBot_Aggro[hbGUID]="d"
            HealBot_UnitThreat[hbGUID]=UnitDebuffStatus[hbGUID]
        elseif Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 and 
               threatStatus>(Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Current_Skin]-2) then
            HealBot_UnitThreat[hbGUID]=threatStatus
            HealBot_Aggro[hbGUID]="a"
        elseif status=="target" and Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_Aggro[hbGUID]="h"
            HealBot_UnitThreat[hbGUID]=-2
            HealBot_Hightlight[hbGUID]="T"
        elseif status=="highlight" and Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_Aggro[hbGUID]="h"
            HealBot_UnitThreat[hbGUID]=-1
            HealBot_Hightlight[hbGUID]="M"
        elseif HealBot_Aggro[hbGUID] and HealBot_Aggro[hbGUID]=="h" then
            if status~="off" then
                if (HealBot_Hightlight[hbGUID] or "M")=="M" then 
                    HealBot_UnitThreat[hbGUID]=-1
                else    
                    HealBot_UnitThreat[hbGUID]=-2
                end
            else
                HealBot_Aggro[hbGUID]=nil
                HealBot_UnitThreat[hbGUID]=threatStatus
            end
        else
            HealBot_UnitThreat[hbGUID]=threatStatus
            HealBot_Aggro[hbGUID]="a"
        end
    else
        HealBot_UnitThreat[hbGUID]=threatStatus
        HealBot_Aggro[hbGUID]=nil
    end
    if status and 
       (HealBot_Aggro[hbGUID]=="h" or 
       (HealBot_Aggro[hbGUID]=="a" and Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Current_Skin]==1 and
       threatStatus>(Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Current_Skin]-2))) then
        if not HealBot_AggroBar4[hbGUID] then
            if HealBot_UnitThreat[hbGUID]>-1 and HealBot_UnitThreat[hbGUID]<4 and Healbot_Config_Skins.ShowAggroBarsPct[Healbot_Config_Skins.Current_Skin]==1 then
                barName:SetValue(HealBot_UnitThreatPct[hbGUID])
            else
                barName:SetValue(100)
            end
            HealBot_AggroBar4[hbGUID]=barName
        elseif HealBot_AggroBar4[hbGUID]~=barName then
            barTemp=HealBot_AggroBar4[hbGUID]
            barTemp:SetStatusBarColor(1,0,0,0)
            HealBot_AggroBar4[hbGUID]=barName
        elseif HealBot_UnitThreat[hbGUID]>-1 and HealBot_UnitThreat[hbGUID]<4 and Healbot_Config_Skins.ShowAggroBarsPct[Healbot_Config_Skins.Current_Skin]==1 then
            barName:SetValue(HealBot_UnitThreatPct[hbGUID])
        else
            barName:SetValue(100)
        end
    elseif HealBot_Hightlight[hbGUID] then
        HealBot_Hightlight[hbGUID]=nil
        if HealBot_AggroBar4[hbGUID] then
            barName=HealBot_AggroBar4[hbGUID]
            barName:SetStatusBarColor(1,0,0,0)
            HealBot_AggroBar4[hbGUID]=nil
        end
        HealBot_OnEvent_PlayerTargetChanged(nil)
    elseif HealBot_AggroBar4[hbGUID] then
        barName=HealBot_AggroBar4[hbGUID]
        barName:SetStatusBarColor(1,0,0,0)
        HealBot_AggroBar4[hbGUID]=nil
    end
    HealBot_Action_ResetUnitStatus(unit)
end

function HealBot_Action_SetThreatPct(hbGUID, threatPct)
    if not threatPct then return end
    hbprevThreatPct=HealBot_UnitThreatPct[hbGUID] or 0
    HealBot_UnitThreatPct[hbGUID]=threatPct
    if HealBot_UnitThreatPct[hbGUID]~=hbprevThreatPct then HealBot_Action_ResetUnitStatus(unit) end
end

function HealBot_Action_SetVAggro(hbGUID, threatStatus)
    if threatStatus and hbGUID then
        HealBot_Aggro[hbGUID]="a"
    elseif hbGUID then
        HealBot_Aggro[hbGUID]=nil
    end
end

function HealBot_Action_retAggro(hbGUID)
    return HealBot_Aggro[hbGUID]
end

function HealBot_Action_EndAggro()
    for hbGUID,_ in pairs(HealBot_Aggro) do
        if HealBot_UnitID[hbGUID] then
            HealBot_Action_UpdateAggro(HealBot_UnitID[hbGUID],false,nil,hbGUID)
        end
    end
    for hbGUID,barName in pairs(HealBot_AggroBar4) do
        barName:SetStatusBarColor(1,0,0,0)
        HealBot_AggroBar4[hbGUID]=nil
    end
end

function HealBot_Action_SetUnitDebuffStatus(hbGUID,status)
    if not status then
        UnitDebuffStatus[hbGUID]=nil
    else
        UnitDebuffStatus[hbGUID]=status
    end
end

function HealBot_Action_ClearUnitDebuffStatus(hbGUID)
    if hbGUID then
        UnitDebuffStatus[hbGUID]=nil
    else
        for x,_ in pairs(UnitDebuffStatus) do
            UnitDebuffStatus[x]=nil;
        end
    end
end

function HealBot_Action_RetUnitThreat(hbGUID)
    return HealBot_UnitThreat[hbGUID] or -9
end

function HealBot_Action_RetUnitThreatPct(hbGUID)
    return HealBot_UnitThreatPct[hbGUID] or -1
end

function HealBot_Action_RetHealBot_UnitStatus(unit)
    return HealBot_UnitStatus[unit] or -9
end

function HealBot_Action_SetrSpell()
    HealBot_hSpell=HealBot_GetBandageType()
    HealBot_bSpell=HealBot_GetBandageType()
    HealBot_dSpell=HealBot_GetBandageType()
    HealBot_rSpell=HealBot_GetBandageType()
    if strsub(HealBot_PlayerClassEN,1,4)=="DRUI" then
        HealBot_hSpell=HEALBOT_REJUVENATION
        HealBot_bSpell=HEALBOT_MARK_OF_THE_WILD
        HealBot_dSpell=HEALBOT_CURE_POISON
        HealBot_rSpell=HEALBOT_REVIVE
    elseif strsub(HealBot_PlayerClassEN,1,4)=="HUNT" then
        HealBot_hSpell=HEALBOT_MENDPET
    elseif strsub(HealBot_PlayerClassEN,1,4)=="MAGE" then
        HealBot_bSpell=HEALBOT_ARCANE_INTELLECT
        HealBot_dSpell=HEALBOT_REMOVE_CURSE
    elseif strsub(HealBot_PlayerClassEN,1,4)=="PALA" then
        HealBot_hSpell=HEALBOT_HOLY_LIGHT
        HealBot_bSpell=HEALBOT_BLESSING_OF_MIGHT
        HealBot_dSpell=HEALBOT_PURIFY
        HealBot_rSpell=HEALBOT_REDEMPTION
    elseif strsub(HealBot_PlayerClassEN,1,4)=="PRIE" then
        HealBot_hSpell=HEALBOT_LESSER_HEAL
        HealBot_bSpell=HEALBOT_POWER_WORD_FORTITUDE
        HealBot_dSpell=HEALBOT_CURE_DISEASE
        HealBot_rSpell=HEALBOT_RESURRECTION
    elseif strsub(HealBot_PlayerClassEN,1,4)=="SHAM" then
        HealBot_hSpell=HEALBOT_HEALING_WAVE
        HealBot_bSpell=HEALBOT_WATER_SHIELD
        HealBot_dSpell=HEALBOT_CURE_DISEASE
        HealBot_rSpell=HEALBOT_ANCESTRALSPIRIT
    elseif strsub(HealBot_PlayerClassEN,1,4)=="WARL" then
        HealBot_bSpell=HEALBOT_UNENDING_BREATH
        HealBot_hSpell=HEALBOT_HEALTH_FUNNEL
    elseif strsub(HealBot_PlayerClassEN,1,4)=="WARR" then
        if HealBot_GetSpellId(HEALBOT_VIGILANCE) then
            HealBot_hSpell=HEALBOT_VIGILANCE
            HealBot_bSpell=HEALBOT_VIGILANCE
        end
    end
    HealBot_Set_debuffSpell(HealBot_dSpell)
--    HealBot_SetrSpells(HealBot_hSpell,HealBot_bSpell,HealBot_dSpell,HealBot_rSpell)
end

function HealBot_GetBandageType()
    local bandage = ""
    if IsUsableItem(HEALBOT_HEAVY_FROSTWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_FROSTWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_FROSTWEAVE_BANDAGE) then bandage = HEALBOT_FROSTWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_NETHERWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_NETHERWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_NETHERWEAVE_BANDAGE) then bandage = HEALBOT_NETHERWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_RUNECLOTH_BANDAGE) then bandage = HEALBOT_HEAVY_RUNECLOTH_BANDAGE
    elseif IsUsableItem(HEALBOT_RUNECLOTH_BANDAGE) then bandage = HEALBOT_RUNECLOTH_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_MAGEWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_MAGEWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_MAGEWEAVE_BANDAGE) then bandage = HEALBOT_MAGEWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_SILK_BANDAGE) then bandage = HEALBOT_HEAVY_SILK_BANDAGE
    elseif IsUsableItem(HEALBOT_SILK_BANDAGE) then bandage = HEALBOT_SILK_BANDAGE
    else
        local hbLevel = UnitLevel("player")
        if hbLevel > 70 then
            bandage = HEALBOT_HEAVY_FROSTWEAVE_BANDAGE
        elseif hbLevel > 60 then
            bandage = HEALBOT_HEAVY_NETHERWEAVE_BANDAGE
        else
            bandage = HEALBOT_HEAVY_RUNECLOTH_BANDAGE
        end
    end
    return bandage
end

local hcaggro=nil
local hcr=nil
local hcg=nil
local hcb=nil
local hca=nil
local hcta=nil
local hcpct=nil
local hrpct=100
local inSpellRange = -1
function HealBot_HealthColor(unit,hlth,maxhlth,tooltipcol,hbGUID,UnitDead,Member_Buff,Member_Debuff,healin)
    if UnitDead then
        hcpct=0
        hrpct=0
    else
        hcpct = hlth+healin
        if hcpct<maxhlth then
            hcpct=hcpct/maxhlth
        else
            hcpct=1;
        end
        if maxhlth == 0 then
            hrpct = 100;
        else
            hrpct=floor((hlth/maxhlth)*100)
        end
    end
  
    if HealBot_Aggro[hbGUID] and (HealBot_UnitThreat[hbGUID] or 0)>(Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Current_Skin]-2) and UnitIsConnected(unit) then
        hcaggro=true
    else
        hcaggro=nil
    end
    
    if not tooltipcol then
        HealBot_UnitStatus[unit]=1
        if UnitDead then
            HealBot_UnitStatus[unit]=8
        elseif Member_Debuff and UnitIsConnected(unit) then
            inSpellRange = HealBot_UnitInRange(HealBot_dSpell, unit)
            if HealBot_Config.CDCshownHB==1 and inSpellRange>(HealBot_Config.HealBot_CDCWarnRange_Bar-3) then
                if HealBot_Config.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]] then
                    return HealBot_Config.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]].R,
                           HealBot_Config.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]].G,
                           HealBot_Config.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]].B,
                           Healbot_Config_Skins.bareora[Healbot_Config_Skins.Current_Skin],
                           hrpct,
                           Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]
                else
                    return HealBot_Config.CDCBarColour[Member_Debuff].R,
                           HealBot_Config.CDCBarColour[Member_Debuff].G,
                           HealBot_Config.CDCBarColour[Member_Debuff].B,
                           Healbot_Config_Skins.bareora[Healbot_Config_Skins.Current_Skin],
                           hrpct,
                           Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]
                end
            end
        elseif Member_Buff and UnitIsConnected(unit) then
            hcr,hcg,hcb=HealBot_Options_RetBuffRGB(Member_Buff)
            return hcr,
                   hcg,
                   hcb,
                   Healbot_Config_Skins.bareora[Healbot_Config_Skins.Current_Skin],
                   hrpct,
                   Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]
        elseif hlth>maxhlth*Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Current_Skin] and not hcaggro then
            vUnit=HealBot_retIsInVehicle(unit)
            if vUnit then
                x,y=HealBot_VehicleHealth(vUnit)
                if x>y*Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Current_Skin] and not hcaggro then
                    HealBot_UnitStatus[unit]=0;
                end
            else
                HealBot_UnitStatus[unit]=0;
            end
        end
    end

    hcr,hcg,hcb = 1.0, 1.0, 0.0;
    if HealBot_UnitStatus[unit]~=0 then --(hcpct<=Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Current_Skin] or HealBot_Aggro[hbGUID]) then -- 
        hca=Healbot_Config_Skins.bareora[Healbot_Config_Skins.Current_Skin]
        hcta=Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]
    else
        hca=Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]
        hcta=Healbot_Config_Skins.btextdisbledcola[Healbot_Config_Skins.Current_Skin]
    end
  
    if UnitDead then
        hcr = 0
        hcg = 0
        hcb = 0
    elseif (Healbot_Config_Skins.SetBarClassColour[Healbot_Config_Skins.Current_Skin] == 1) and not tooltipcol then
        if (Healbot_Config_Skins.SetBarCustomColour[Healbot_Config_Skins.Current_Skin] == 1) then
            hcr,hcg,hcb = HealBot_Action_ClassColour(hbGUID, unit)
        else
            hcr=Healbot_Config_Skins.barcolr[Healbot_Config_Skins.Current_Skin]
            hcg=Healbot_Config_Skins.barcolg[Healbot_Config_Skins.Current_Skin]
            hcb=Healbot_Config_Skins.barcolb[Healbot_Config_Skins.Current_Skin]
        end
    else
        if hcpct>=0.98 then 
            hcr = 0.0
        elseif hcpct<0.98 and hcpct>=0.65 then 
            hcr=2.94-(hcpct*3)
        elseif hcpct<=0.64 and hcpct>0.31 then 
            hcg=(hcpct-0.31)*3
        elseif hcpct<=0.31 then 
            hcg = 0.0 
        end
    end

    return hcr,hcg,hcb,hca,hrpct,hcta
end

function HealBot_Action_HealthBar(button)
    if not button then return end
    barName = button:GetName();
    return _G[barName.."Bar"];
end

function HealBot_Action_HealthBar2(button)
    if not button then return end
    barName = button:GetName();
    return _G[barName.."Bar2"];
end

function HealBot_Action_HealthBar3(button)
    if not button then return end
    barName = button:GetName();
    return _G[barName.."Bar3"];
end

function HealBot_Action_HealthBar4(button)
    if not button then return end
    barName = button:GetName();
    return _G[barName.."Bar4"];
end

function HealBot_Action_ShouldHealSome(hbGUID)
    if HealBot_Enabled[hbGUID] then 
        return true
    else
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            if HealBot_Enabled[HealBot_UnitGUID(xUnit)] then
                return true
            end
        end
    end
end

function HealBot_MayHeal(unit, unitName)
    if unitName then
        if unit ~= 'target' then 
            return true 
        end
        if UnitCanAttack("player",unit) then 
            return false 
        end
        return true;
    else
        return false;
    end
end

function HealBot_Action_SetBar3Value(button)
    if not button then return end
    barName = HealBot_Unit_Bar3[button.unit]
    if UnitManaMax(button.unit)==0 then
        x=100
    else
        x=UnitManaMax(button.unit)
    end
    y=floor((UnitMana(button.unit)/x)*100)
    hcr,hcg,hcb=HealBot_Action_GetManaBarCol(button.unit)
    barName:SetValue(y);
    barName:SetStatusBarColor(hcr,hcg,hcb,HealBot_UnitRangeb3a[button.unit] or Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin])
end

function HealBot_Action_GetManaBarCol(unit)
    z=UnitPowerType(unit);
    if z==0 then
        return 0.1,0.1,1 -- Mana
    elseif z==1 then
        return 1,0.1,0.1 -- Rage
    elseif z==4 then
        return 0,1,1 -- Happy
    elseif z==6 then
        return 0.1,0.8,1 -- Rune
    end
    return 1,1,0 -- Energy
end

local hbPetLevel = 1
function HealBot_CorrectPetHealth(unit,hlth,maxhlth,hbGUID)
    if not hbGUID then return maxhlth end
    if not HealBot_PetMaxH[hbGUID] then
        hbPetLevel=UnitLevel(unit)
        if hbPetLevel>70 then
            if hlth<3550 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*50
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>60 then
            if hlth<2745 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*45
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>40 then
            if hlth<1640 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*40
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>20 then
            if hlth<735 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*35
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>5 then
            if hlth<180 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*30
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        else
            if hlth<25 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*25
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        end
    elseif hlth>HealBot_PetMaxH[hbGUID] then
        HealBot_PetMaxH[hbGUID]=hlth;
    elseif not HealBot_IsFighting then
        if not HealBot_PetMaxHcnt1[hbGUID] then
            HealBot_PetMaxHcnt1[hbGUID]=1
            HealBot_PetMaxHcnt2[hbGUID]=HealBot_PetMaxH[hbGUID];
        else
            if HealBot_PetMaxHcnt2[hbGUID]~=hlth then
                HealBot_PetMaxHcnt2[hbGUID]=hlth;
                HealBot_PetMaxHcnt1[hbGUID]=1;
            else
                HealBot_PetMaxHcnt1[hbGUID]=HealBot_PetMaxHcnt1[hbGUID]+1;
                if HealBot_PetMaxHcnt1[hbGUID]>9 then
                    HealBot_PetMaxH[hbGUID]=HealBot_PetMaxHcnt2[hbGUID];
                    HealBot_PetMaxHcnt1[hbGUID]=1;
                end
            end
        end
    end
    return HealBot_PetMaxH[hbGUID]
end

local ebubar=nil
local ebubar2=nil
local ebuicon15=nil
local ebusr=nil
local ebusg=nil
local ebusb=nil
local ebusa=nil
local ebur=nil
local ebug=nil
local ebub=nil
local ebua=nil
local ebpct=1
local ebipct=0
local ebtext=nil
local ebub2=nil
local ebufastenable=nil
local ebuProcessThis=nil
local ebuUnitDead=nil
local ebuHealBot_UnitDebuff=nil
local ebuHealBot_UnitBuff=nil
function HealBot_Action_EnableButton(button, hbGUID)
    ebUnit=button.unit

--    if not uName then return end
--    if not uName then uName=HEALBOT_WORDS_UNKNOWN end

    ebubar = HealBot_Unit_Bar1[ebUnit]
    ebubar2 = HealBot_Unit_Bar2[ebUnit]
    ebuicon15 = _G[ebubar:GetName().."Icon15"];
    HealBot_UnitRangeSpell[ebUnit]=HealBot_hSpell

    if UnitExists(ebUnit) then
        uName=UnitName(ebUnit)
        uHlth,uMaxHlth=HealBot_UnitHealth(hbGUID, ebUnit)
        uHealIn = HealBot_IncHeals_retHealsIn(hbGUID)
    
        ebuUnitDead = UnitIsDeadOrGhost(ebUnit)
        if HealBot_UnitDebuff[hbGUID] then
            ebuHealBot_UnitDebuff=HealBot_UnitDebuff[hbGUID]["type"]
        else
            ebuHealBot_UnitDebuff=nil
        end
        ebuHealBot_UnitBuff=HealBot_UnitBuff[hbGUID]
        
        if uHlth>uMaxHlth then uMaxHlth=HealBot_CorrectPetHealth(ebUnit,uHlth,uMaxHlth,hbGUID) end
    
        if ebuUnitDead then
            if UnitIsFeignDeath(ebUnit) then
                ebuUnitDead = nil
            else
                if uHealIn>0 then
                    uHealIn=0
                end
                if HealBot_Aggro[hbGUID] then
                    HealBot_Action_SetUnitDebuffStatus(hbGUID)
                    HealBot_Action_UpdateAggro(ebUnit,false,nil,hbGUID)
                    HealBot_Aggro[hbGUID]=nil
                end
                if HealBot_UnitDebuff[hbGUID] then
                    HealBot_UnitDebuff[hbGUID]=nil
                end
                if HealBot_HoT_Active_Button[hbGUID] then 
                    HealBot_HoT_RemoveIconButton(button)
                end
            end
            if uName==HealBot_PlayerName and not HealBot_PlayerDead then
                HealBot_Action_ResetActiveUnitStatus()
                HealBot_PlayerDead=true
            end
        elseif uName==HealBot_PlayerName and HealBot_PlayerDead then
            HealBot_Action_ResetActiveUnitStatus()
            HealBot_PlayerDead=false
        end

        if uHealIn>0 then
            ebipct = uHlth+uHealIn
            if ebipct<uMaxHlth then
                ebipct=ebipct/uMaxHlth
            else
                ebipct=1;
            end
            ebipct=floor(ebipct*100)
            ebubar2:SetValue(ebipct);
        elseif ebubar2:GetValue()>0 then
            ebubar2:SetValue(0)
        end    
    
        ebur,ebug,ebub,ebua,ebpct,ebusa = HealBot_HealthColor(ebUnit,uHlth,uMaxHlth,false,hbGUID,ebuUnitDead,ebuHealBot_UnitBuff,ebuHealBot_UnitDebuff,uHealIn)
        if Healbot_Config_Skins.SetClassColourText[Healbot_Config_Skins.Current_Skin]==1 then
            ebusr,ebusg,ebusb = HealBot_Action_ClassColour(hbGUID, ebUnit);
        elseif ebuHealBot_UnitDebuff then
            ebusr=Healbot_Config_Skins.btextcursecolr[Healbot_Config_Skins.Current_Skin];
            ebusg=Healbot_Config_Skins.btextcursecolg[Healbot_Config_Skins.Current_Skin];
            ebusb=Healbot_Config_Skins.btextcursecolb[Healbot_Config_Skins.Current_Skin];
        else
            ebusr=Healbot_Config_Skins.btextenabledcolr[Healbot_Config_Skins.Current_Skin] or 1;
            ebusg=Healbot_Config_Skins.btextenabledcolg[Healbot_Config_Skins.Current_Skin] or 1;
            ebusb=Healbot_Config_Skins.btextenabledcolb[Healbot_Config_Skins.Current_Skin] or 1;
        end

        if uMaxHlth<1 then 
            uHlth=1 
        end
  
        if Healbot_Config_Skins.UseFluidBars[Healbot_Config_Skins.Current_Skin]==0 then
            if ebuUnitDead then
                if HealBot_UnitInRange(HealBot_rSpell, ebUnit)==1 and not UnitIsGhost(ebUnit) then
                    ebubar:SetValue(100)
                else
                    ebubar:SetValue(0)
                end
                ebubar2:SetValue(0)
            else
                ebubar:SetValue(ebpct)
            end
        else
            if HealBot_curUnitHealth[ebubar]~=ebpct then
                if ebuUnitDead then
                    if HealBot_UnitInRange(HealBot_rSpell, ebUnit)==1 and not UnitIsGhost(ebUnit) then
                        ebubar:SetValue(100)
                    else
                        ebubar:SetValue(0)
                    end
                    ebubar2:SetValue(0)
                else
                    HealBot_UnitBarUpdate[ebubar]=HealBot_curUnitHealth[ebubar]
                end
                HealBot_curUnitHealth[ebubar]=ebpct
            end
        end
    
        ebuProcessThis=true
        ebufastenable=false
        if HealBot_Config.ProtectPvP==1 then
            if UnitIsPVP(ebUnit) and not UnitIsPVP("player") then 
                ebuProcessThis=false
            end
        end
        if not ebuUnitDead and not HealBot_PlayerDead and ebuProcessThis then
            if ebuHealBot_UnitDebuff then
                HealBot_UnitRangeSpell[ebUnit]=HealBot_dSpell
                if HealBot_UnitInRange(HealBot_dSpell, ebUnit)==1 then ebufastenable=true end
            elseif ebuHealBot_UnitBuff then
                HealBot_UnitRangeSpell[ebUnit]=HealBot_bSpell
                if HealBot_UnitInRange(HealBot_bSpell, ebUnit)==1 then ebufastenable=true end
            end
            if not ebufastenable and (uHlth<=(uMaxHlth*Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Current_Skin]) or HealBot_MyTargets[hbGUID]) and HealBot_UnitInRange(HealBot_hSpell, ebUnit)==1 then
                ebufastenable=true
                HealBot_UnitRangeSpell[ebUnit]=HealBot_hSpell
            elseif not ebufastenable and HealBot_Aggro[hbGUID] and (HealBot_UnitThreat[hbGUID] or 0)>(Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Current_Skin]-2) and HealBot_UnitInRange(HealBot_hSpell, ebUnit)==1 then
                ebufastenable=true
                HealBot_UnitRangeSpell[ebUnit]=HealBot_hSpell
            end
        end
        if ebufastenable then
            ebusa = Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin];
            HealBot_Enabled[hbGUID]=true
            ebubar:SetStatusBarColor(ebur,ebug,ebub,Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin]);
            HealBot_UnitRangeb3a[ebUnit]=Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin]
            if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then -- and HealBot_retdebuffTargetIcon(ebUnit) then
                ebuicon15:SetAlpha(1) --Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin]);
            end
            HealBot_UnitRangeitr[ebUnit]=ebusr
            HealBot_UnitRangeitg[ebUnit]=ebusg
            HealBot_UnitRangeitb[ebUnit]=ebusb
            HealBot_UnitRangeotr[ebUnit]=ebusr
            HealBot_UnitRangeotg[ebUnit]=ebusg
            HealBot_UnitRangeotb[ebUnit]=ebusb
            if ebUnit==HealBot_Action_DisableTooltipUnit then
                HealBot_Action_TooltipUnit = ebUnit;
                HealBot_Action_DisableTooltipUnit = nil;
            end
            if ebUnit==HealBot_Action_TooltipUnit then
                HealBot_Action_RefreshTooltip(ebUnit,"Enabled")
            end
            if Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==1 then HealBot_Action_ShowPanel() end
        else
            HealBot_Enabled[hbGUID]=false
            if Healbot_Config_Skins.SetClassColourText[Healbot_Config_Skins.Current_Skin]==0 then
                ebusr=Healbot_Config_Skins.btextdisbledcolr[Healbot_Config_Skins.Current_Skin]
                ebusg=Healbot_Config_Skins.btextdisbledcolg[Healbot_Config_Skins.Current_Skin]
                ebusb=Healbot_Config_Skins.btextdisbledcolb[Healbot_Config_Skins.Current_Skin]
            end
            if HealBot_RetHealBot_Ressing(hbGUID) then
                if ebuUnitDead then
                    ebusr=0.2
                    ebusg=1.0
                    ebusb=0.2
                    ebusa=1
                else
                    HealBot_UnsetHealBot_Ressing(hbGUID)
                end
                HealBot_UnitRangeitr[ebUnit]=0.2
                HealBot_UnitRangeitg[ebUnit]=1
                HealBot_UnitRangeitb[ebUnit]=0.2
                HealBot_UnitRangeotr[ebUnit]=0.2
                HealBot_UnitRangeotg[ebUnit]=1
                HealBot_UnitRangeotb[ebUnit]=0.2
            elseif ebuUnitDead and uName~=HealBot_PlayerName then
                if HealBot_rSpell then
                    HealBot_UnitRangeSpell[ebUnit]=HealBot_rSpell
                    if HealBot_UnitInRange(HealBot_rSpell, ebUnit)==1 and not UnitIsGhost(ebUnit) then
                        ebusr=1;
                        ebusg=0.2;
                        ebusb=0.2;
                        ebusa=1;
                    else
                        ebusr=0.8;
                        ebusg=0;
                        ebusb=0;
                        ebusa=1;
                    end
                    if not UnitIsGhost(ebUnit) then
                        HealBot_UnitRangeitr[ebUnit]=1
                        HealBot_UnitRangeitg[ebUnit]=0.2
                        HealBot_UnitRangeitb[ebUnit]=0.2
                    else
                        HealBot_UnitRangeitr[ebUnit]=0.8
                        HealBot_UnitRangeitg[ebUnit]=0
                        HealBot_UnitRangeitb[ebUnit]=0
                    end
                    HealBot_UnitRangeotr[ebUnit]=0.8
                    HealBot_UnitRangeotg[ebUnit]=0
                    HealBot_UnitRangeotb[ebUnit]=0
                end
            else
                HealBot_UnitRangeitr[ebUnit]=ebusr
                HealBot_UnitRangeitg[ebUnit]=ebusg
                HealBot_UnitRangeitb[ebUnit]=ebusb
                HealBot_UnitRangeotr[ebUnit]=ebusr
                HealBot_UnitRangeotg[ebUnit]=ebusg
                HealBot_UnitRangeotb[ebUnit]=ebusb
                --ebua=Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]
            end
            if UnitIsVisible(ebUnit) or Healbot_Config_Skins.NotVisibleDisable[Healbot_Config_Skins.Current_Skin]==0 then
                ebubar:SetStatusBarColor(ebur,ebug,ebub,ebua);
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then -- and HealBot_retdebuffTargetIcon(ebUnit) then
                    ebuicon15:SetAlpha(ebua);
                end
            else
                ebubar:SetStatusBarColor(ebur,ebug,ebub,Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]);
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then -- and HealBot_retdebuffTargetIcon(ebUnit) then
                    ebuicon15:SetAlpha(Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]);
                end
            end
            if not HealBot_IsFighting and HealBot_Config.EnableHealthy==0 then
                if ebUnit==HealBot_Action_TooltipUnit then
                    HealBot_Action_TooltipUnit = nil;
                    HealBot_Action_DisableTooltipUnit = ebUnit;
                end
                if ebUnit==HealBot_Action_DisableTooltipUnit then
                    HealBot_Action_RefreshTooltip(ebUnit,"Disabled")
                end
            end
            HealBot_UnitRangeb3a[ebUnit]=ebua
        end
        HealBot_UnitRanger[ebUnit]=ebur
        HealBot_UnitRangeg[ebUnit]=ebug
        HealBot_UnitRangeb[ebUnit]=ebub
        HealBot_UnitRangea[ebUnit]=ebua
        HealBot_UnitRangeota[ebUnit]=ebusa
    else
        uHlth,uMaxHlth=1,1
        uHealIn = 0
        if HealBot_UnitName[hbGUID] and HealBot_UnitName[hbGUID]==HEALBOT_WORD_RESERVED..":"..ebUnit then
            uName=HealBot_UnitName[hbGUID]
            ebubar:SetStatusBarColor(0,1,0,0)
            HealBot_Reserved[ebUnit]=true
            ebusr,ebusg,ebusb=0.7,0.7,0.7
            HealBot_UnitRanger[ebUnit]=ebur or 0
            HealBot_UnitRangeg[ebUnit]=ebug or 1
            HealBot_UnitRangeb[ebUnit]=ebub or 0
        else
            uName=HEALBOT_WORDS_UNKNOWN
            if Delay_RecalcParty<1 then Delay_RecalcParty=1 end
            HealBot_UnitStatus[ebUnit]=9
            HealBot_UnitRanger[ebUnit]=ebur or 0
            HealBot_UnitRangeg[ebUnit]=ebug or 1
            HealBot_UnitRangeb[ebUnit]=ebub or 0
        end
        HealBot_UnitRangea[ebUnit]=ebua or 0.1
        HealBot_UnitRangeb3a[ebUnit]=ebua or 0.1
        HealBot_UnitRangeota[ebUnit]=ebusa or 0.01
    end
    
    if uHealIn>0 then
        ebubar2:SetStatusBarColor(ebur,ebug,ebub,Healbot_Config_Skins.BarcolaInHeal[Healbot_Config_Skins.Current_Skin]);
        if HealBot_UnitRangeb3a[ebUnit]<Healbot_Config_Skins.BarcolaInHeal[Healbot_Config_Skins.Current_Skin] then
            HealBot_UnitRangeb3a[ebUnit]=Healbot_Config_Skins.BarcolaInHeal[Healbot_Config_Skins.Current_Skin]
        end
    else
        ebubar2:SetStatusBarColor(ebur,ebug,ebub,0);
    end
  
    ebubar.txt = _G[ebubar:GetName().."_text"];
    ebtext=HealBot_Action_HBText(uHlth,uMaxHlth,uName,ebUnit,uHealIn, hbGUID)
    ebubar.txt:SetText(ebtext);
    if UnitIsVisible(ebUnit) or Healbot_Config_Skins.NotVisibleDisable[Healbot_Config_Skins.Current_Skin]==0 then
        ebubar.txt:SetTextColor(ebusr,ebusg,ebusb,ebusa);
    else
        ebubar.txt:SetTextColor(ebusr,ebusg,ebusb,Healbot_Config_Skins.btextdisbledcola[Healbot_Config_Skins.Current_Skin]);
    end
    if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]>0 then 
        HealBot_Action_SetBar3Value(HealBot_Unit_Button[ebUnit]);
    end
    HealBot_UnitRange[ebUnit]=HealBot_UnitInRange(HealBot_UnitRangeSpell[ebUnit], ebUnit)
end

local hpPerc=nil
local r,g,b=nil,nil,nil
local hbFont=nil
local hbFontAdj=nil
local hbFontVal={ ["Accidental Presidency"]=3,
                  ["Alba Super"]=1.4,
                  ["Anime Ace"]=1,
                  ["Ariel Narrow"]=3,
                  ["Blazed"]=1.1,
                  ["Designer Block"]=1.7,
                  ["DestructoBeam BB"]=1.4,
                  ["Diogenes"]=2.1,
                  ["Disko"]=1.9,
                  ["DreamSpeak"]=3,
                  ["Drummon"]=1.5,
                  ["Dustismo"]=1.9,
                  ["Electrofied"]=1.1,
                  ["Emblem"]=1.7,
                  ["Frakturika Spamless"]=2.4,
                  ["Friz Quadrata TT"]=1.6,
                  ["Impact"]=2,
                  ["Liberation Sans"]=1.6,
                  ["Liberation Serif"]=1.8,
                  ["Morpheus"]=1.9,
                  ["Mystic Orbs"]=1.2,
                  ["Pokemon Solid"]=1.9,
                  ["Rock Show Whiplash"]=2.4,
                  ["SF Diego Sans"]=1.5,
                  ["SF Laundromatic"]=3,
                  ["Skurri"]=2.2,
                  ["Solange"]=1.4,
                  ["Star Cine"]=1,
                  ["Trashco"]=1.6,
                  ["Waltograph UI"]=1,
                  ["X360"]=1.4,
                  ["Zekton"]=1.6,
                }
                

local hbNumFormatPlaces=-1
local hbNumFormatSurL="("
local hbNumFormatSurR=")"
local hbNumFormatSuffix="K"
function HealBot_Action_sethbNumberFormat()
    if Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==2 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==5 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==8 then
        hbNumFormatPlaces=0
    elseif Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==3 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==6 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==9 then
        hbNumFormatPlaces=1
    elseif Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==4 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==7 or Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]==10 then
        hbNumFormatPlaces=2
    else
        hbNumFormatPlaces=-1
    end
    if Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]>1 and Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]<5 then
        hbNumFormatSuffix="K"
    elseif Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]>4 and Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Current_Skin]<8 then
        hbNumFormatSuffix="k"
    else
        hbNumFormatSuffix=""
    end
    if Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==2 then
        hbNumFormatSurL="("
        hbNumFormatSurR=")"
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==3 then
        hbNumFormatSurL="["
        hbNumFormatSurR="]"
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==4 then
        hbNumFormatSurL="{"
        hbNumFormatSurR="}"
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==5 then
        hbNumFormatSurL="<"
        hbNumFormatSurR=">"
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==6 then
        hbNumFormatSurL="~"
        hbNumFormatSurR=""
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==7 then
        hbNumFormatSurL=":"
        hbNumFormatSurR=":"
    elseif Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Current_Skin]==8 then
        hbNumFormatSurL="*"
        hbNumFormatSurR="*"
    else
        hbNumFormatSurL=""
        hbNumFormatSurR=""
    end
    if hbNumFormatPlaces==-1 then
        hbNumFormatSuffix=""
    end
end

local hbNumFormatSurLa="["
local hbNumFormatSurRa="]"
function HealBot_Action_sethbAggroNumberFormat()
    if Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==2 then
        hbNumFormatSurLa="("
        hbNumFormatSurRa=")"
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==3 then
        hbNumFormatSurLa="["
        hbNumFormatSurRa="]"
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==4 then
        hbNumFormatSurLa="{"
        hbNumFormatSurRa="}"
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==5 then
        hbNumFormatSurLa="<"
        hbNumFormatSurRa=">"
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==6 then
        hbNumFormatSurLa="~"
        hbNumFormatSurRa=""
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==7 then
        hbNumFormatSurLa=":"
        hbNumFormatSurRa=":"
    elseif Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Current_Skin]==8 then
        hbNumFormatSurLa="*"
        hbNumFormatSurRa="*"
    else
        hbNumFormatSurLa=""
        hbNumFormatSurRa=""
    end
end

function HealBot_Action_HBText(hlth,maxhlth,unitName,unit,healin, hbGUID)
    btHBbarText=" "
    
    if unitName and unitName==HEALBOT_WORD_RESERVED..":"..unit then
        uName=unitName;
    else
        if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==2 and UnitClass(unit) then
            if Healbot_Config_Skins.ShowNameOnBar[Healbot_Config_Skins.Current_Skin]==1 then
                uName=UnitClass(unit)..":"..unitName;
            else
                uName=UnitClass(unit);
            end
        elseif Healbot_Config_Skins.ShowNameOnBar[Healbot_Config_Skins.Current_Skin]==1 then
            uName=unitName;
        else
            uName=" "
        end
        hbFont=Healbot_Config_Skins.btextfont[Healbot_Config_Skins.Current_Skin]
        hbFontAdj=hbFontVal[hbFont] or 2
        bttextlen = floor((hbFontAdj*2)+2+(((Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]*1.88)/Healbot_Config_Skins.btextheight[Healbot_Config_Skins.Current_Skin])-(Healbot_Config_Skins.btextheight[Healbot_Config_Skins.Current_Skin]/hbFontAdj)))
        if Healbot_Config_Skins.ShowHealthOnBar[Healbot_Config_Skins.Current_Skin]==1 and maxhlth then
            if Healbot_Config_Skins.BarHealthType[Healbot_Config_Skins.Current_Skin]==1 then
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==2 then
                    bthlthdelta=hlth+healin
                    if bthlthdelta>maxhlth then bthlthdelta=maxhlth end
                else
                    bthlthdelta=hlth;
                end
                if hbNumFormatPlaces>-1 then bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,hbNumFormatPlaces) end
                btHBbarText=btHBbarText..hbNumFormatSurL..bthlthdelta..hbNumFormatSuffix..hbNumFormatSurR;
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==3 and healin>0 then
                    if hbNumFormatPlaces>-1 then healin=HealBot_Comm_round(healin/1000,hbNumFormatPlaces) end
                    btHBbarText=btHBbarText.." +"..healin..hbNumFormatSuffix
                end
            elseif Healbot_Config_Skins.BarHealthType[Healbot_Config_Skins.Current_Skin]==2 then
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==2 then
                    bthlthdelta=(hlth+healin)-maxhlth;
                else
                    bthlthdelta=hlth-maxhlth;
                end
                if hbNumFormatPlaces>-1 then bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,hbNumFormatPlaces) end
                if bthlthdelta>0 then
                    btHBbarText=btHBbarText.." "..hbNumFormatSurL.."+"..bthlthdelta..hbNumFormatSuffix..hbNumFormatSurR;
                else
                    btHBbarText=btHBbarText..hbNumFormatSurL..bthlthdelta..hbNumFormatSuffix..hbNumFormatSurR;
                end
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==3 and healin>0 then
                    if hbNumFormatPlaces>-1 then healin=HealBot_Comm_round(healin/1000,hbNumFormatPlaces) end
                    btHBbarText=btHBbarText.." +"..healin..hbNumFormatSuffix
                end
            else
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==2 then
                    btHBbarText=btHBbarText..hbNumFormatSurL..floor(((hlth+healin)/maxhlth)*100).."%"..hbNumFormatSurR
                else
                    btHBbarText=btHBbarText..hbNumFormatSurL..floor((hlth/maxhlth)*100).."%"..hbNumFormatSurR
                end
                if Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Current_Skin]==3 and healin>0 then
                    btHBbarText=btHBbarText.." +"..floor((healin/maxhlth)*100).."%"
                end
            end
        end
        
        if HealBot_Action_UnitIsOffline(hbGUID) then
            uName=HEALBOT_DISCONNECTED_TEXT.." "..uName;
        end    -- added by Diacono of Ursin
        if Healbot_Config_Skins.ShowAggroText[Healbot_Config_Skins.Current_Skin]==1 and HealBot_Aggro[hbGUID] and HealBot_Aggro[hbGUID]=="a" and 
           (HealBot_UnitThreat[hbGUID] or 0)>(Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Current_Skin]-2) and uName then
            uName=">> "..uName.." <<"
            --uName=">"..HealBot_UnitThreat[hbGUID].."> "..uName.." <"..HealBot_UnitThreat[hbGUID].."<"
        end
        vUnit=HealBot_retIsInVehicle(unit)
        if vUnit then
            x,y=HealBot_VehicleHealth(vUnit)
            hpPerc = floor((x/y)*100)
            if hpPerc < 0 then 
                hpPerc = 0
            end
            bthlthdelta="  "..string.format("|cff%s%d%%|r", HealBot_PercentToHexColor(hpPerc), hpPerc)
            if bttextlen>9 then 
                y=bttextlen-7
            else
                y=3
            end
            if UnitName(vUnit) and string.utf8len(UnitName(vUnit))>y then
                bthlthdelta = string.utf8sub(UnitName(vUnit),1,y).. '..'..bthlthdelta
            elseif UnitExists(vUnit) then
                bthlthdelta = UnitName(vUnit)..bthlthdelta
            else
                HealBot_CheckAllUnitVehicle(unit)
                if HealBot_retIsInVehicle(unit) then
                    bthlthdelta = HEALBOT_VEHICLE..bthlthdelta
                end
            end
        end
    end
    if Healbot_Config_Skins.ShowAggroTextPct[Healbot_Config_Skins.Current_Skin]==1 and HealBot_UnitThreatPct[hbGUID] and HealBot_UnitThreatPct[hbGUID]>0 then 
        btHBbarText=btHBbarText.."  "..hbNumFormatSurLa..HealBot_UnitThreatPct[hbGUID].."%"..hbNumFormatSurRa
    end
    if Healbot_Config_Skins.DoubleText[Healbot_Config_Skins.Current_Skin]==0 then
        bttextlen=bttextlen-string.utf8len(btHBbarText)
        if bttextlen<1 then 
            bttextlen=1
        end
        if uName and string.utf8len(uName)>bttextlen then
            btHBbarText = string.utf8sub(uName,1,bttextlen) .. '.'..btHBbarText;
        elseif uName then
            btHBbarText = uName..btHBbarText;
        end
        if vUnit then
            btHBbarText = btHBbarText.."\n".." "..bthlthdelta
        end
    else
        if bttextlen<1 then 
            bttextlen=1
        end
        if uName and string.utf8len(uName)>bttextlen then
            btHBbarText = string.utf8sub(uName,1,bttextlen) .. '.'.."\n"..btHBbarText;
        elseif uName then
            btHBbarText = uName.."\n"..btHBbarText;
        end
        if vUnit then
            btHBbarText = btHBbarText.." "..bthlthdelta
        end
    end
    return btHBbarText;
end

function HealBot_PercentToHexColor(percent)
    percent = percent/100
    r,g,b = 2-percent*2,1,0
    if percent <= 0 then
        r,g,b = 1,0,0
    elseif percent <= 0.5 then
        r,g,b = 1,percent*2,0
    elseif percent >= 1 then
        r,g,b = 0,1,0
    end 
    return string.format("%02x%02x%02x",r*255,g*255,b*255)
end

function HealBot_Action_UnitIsOffline(hbGUID,preset) -- added by Diacono of Ursin
    x = nil;
    if not HealBot_UnitID[hbGUID] then return end
    if preset then
        HealBot_UnitOffline[hbGUID]=preset
    else
        if HealBot_UnitOffline[hbGUID] then
            if time() - HealBot_UnitOffline[hbGUID] <= 2 then
                x = true;
            end
        end
        if not UnitIsConnected(HealBot_UnitID[hbGUID]) or x then
            if not HealBot_UnitOffline[hbGUID] then
                HealBot_UnitOffline[hbGUID] = time();
            elseif HealBot_UnitOffline[hbGUID] == -1 then
                HealBot_UnitOffline[hbGUID] = nil;
            end
        else
            HealBot_UnitOffline[hbGUID] = nil;
        end
        return HealBot_UnitOffline[hbGUID]
    end
end

function HealBot_Action_retUnitOffline(hbGUID)
    return HealBot_UnitOffline[hbGUID]
end

function HealBot_Action_RefreshButton(button, hbGUID)
    if not button or not hbGUID then return end
--  if type(button)~="table" then DEFAULT_CHAT_FRAME:AddMessage("***** "..type(button)) end
    HealBot_Action_EnableButton(button, hbGUID)
    if UnitExists("target") and HealBot_UnitGUID("target")==hbGUID and button.unit~="target" and HealBot_Unit_Button["target"] then
        HealBot_Action_EnableButton(HealBot_Unit_Button["target"], hbGUID)
    end
end

local HealBot_resetSkinTo=""
local HealBot_initSkin={}
function HealBot_Action_ResetSkin(barType,button,numcols)
local bwidth = Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin];
local bheight=Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin];
local br=Healbot_Config_Skins.headbarcolr[Healbot_Config_Skins.Current_Skin];  
local bg=Healbot_Config_Skins.headbarcolg[Healbot_Config_Skins.Current_Skin];
local bb=Healbot_Config_Skins.headbarcolb[Healbot_Config_Skins.Current_Skin];
local ba=Healbot_Config_Skins.headbarcola[Healbot_Config_Skins.Current_Skin];
local sr=Healbot_Config_Skins.headtxtcolr[Healbot_Config_Skins.Current_Skin];  
local sg=Healbot_Config_Skins.headtxtcolg[Healbot_Config_Skins.Current_Skin];
local sb=Healbot_Config_Skins.headtxtcolb[Healbot_Config_Skins.Current_Skin];
local sa=Healbot_Config_Skins.headtxtcola[Healbot_Config_Skins.Current_Skin];
local btexture=Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin];
local btextheight=Healbot_Config_Skins.btextheight[Healbot_Config_Skins.Current_Skin]; 
local b,bar,bar2,bar3,bar4,icon1,icon15,icon16,icon1t,icon15t,icon1ta,icon15ta
local barScale,h,hwidth,hheight,iScale,itScale
local abSize = Healbot_Config_Skins.AggroBarSize[Healbot_Config_Skins.Current_Skin] or 2
local abtSize = {[0]=1,[1]=1,[2]=1,[3]=2,[4]=2,[5]=2,[6]=3,[7]=3,[8]=3,[9]=3,[10]=4,[11]=4,[12]=4,[13]=4,[14]=4,[15]=5}
  
    if barType=="bar" then
        if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==0 and 
           Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==0 and
           Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==0 then 
            abSize=0 
        end
        if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
            iScale=floor(((bheight*Healbot_Config_Skins.IconScale[Healbot_Config_Skins.Current_Skin])-2)*0.485)
        else
            iScale=(bheight*Healbot_Config_Skins.IconScale[Healbot_Config_Skins.Current_Skin])-2
        end
        itScale=ceil(iScale*Healbot_Config_Skins.IconTextScale[Healbot_Config_Skins.Current_Skin])
         --for x=1,51 do
        b=button;
        HealBot_ResetBarSkinDone[b.id]=true
        bar = HealBot_Action_HealthBar(b);
        bar2 = HealBot_Action_HealthBar2(b);
        bar3 = HealBot_Action_HealthBar3(b);
        bar4 = HealBot_Action_HealthBar4(b)
        bar.txt = _G[bar:GetName().."_text"];
        bar:SetHeight(bheight);
        bar:SetWidth(bwidth)
     --   bar:SetTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin]),false);
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin]));
        bar:GetStatusBarTexture():SetHorizTile(false)
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.btextfont[Healbot_Config_Skins.Current_Skin]),btextheight,"");
        bar.txt:ClearAllPoints();
        if Healbot_Config_Skins.TextAlignment[Healbot_Config_Skins.Current_Skin]==1 then
            bar.txt:SetPoint("LEFT",bar,"LEFT",4,0)
        elseif Healbot_Config_Skins.TextAlignment[Healbot_Config_Skins.Current_Skin]==2 then
            bar.txt:SetPoint("CENTER",bar,"CENTER")
        else
            bar.txt:SetPoint("RIGHT",bar,"RIGHT",-4,0)
        end
    --bar.txt:SetTextHeight(btextheight);
        bar2:SetHeight(bheight);
        bar2:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin]));
        bar2:GetStatusBarTexture():SetHorizTile(false)
        bar3:SetHeight(Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]);
        bar3:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin]));
        bar3:GetStatusBarTexture():SetHorizTile(false)
        bar4:ClearAllPoints();
        bar4:SetPoint("TOPLEFT",bar,"TOPLEFT",0,abSize);
        bar4:SetPoint("TOPRIGHT",bar,"TOPRIGHT",0,abSize);
        if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]==0 then
            bar4:SetHeight(bheight+(abSize*2))
        else
            bar4:SetHeight(Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]+bheight+(abSize*2))
        end
        bar4:SetStatusBarTexture('Interface\\Addons\\HealBot\\Images\\aggro'..abtSize[abSize]..'.tga')
        bar4:GetStatusBarTexture():SetHorizTile(false)
        bar4:SetStatusBarColor(1,0,0,0)
        bar4:SetMinMaxValues(0,100)
        bar4:SetValue(100)
        b:SetHeight(bheight); 
        b:SetWidth(bwidth)
        for x=2,14 do
            icon=_G[bar:GetName().."Icon"..x];
            icont=_G[bar:GetName().."Count"..x];
            iconta=_G[bar:GetName().."Count"..x.."a"];
            icon:SetHeight(iScale);
            icon:SetWidth(iScale);
            icont:SetTextHeight(itScale)
            iconta:SetTextHeight(itScale)
        end
        icon1 = _G[bar:GetName().."Icon1"];
        icon1t = _G[bar:GetName().."Count1"];
        icon1ta = _G[bar:GetName().."Count1a"];
        icon15 = _G[bar:GetName().."Icon15"];
        icon16 = _G[bar:GetName().."Icon16"];
        icon15t = _G[bar:GetName().."Count15"]; 
        icon15ta = _G[bar:GetName().."Count15a"];   
        icon1:SetHeight(iScale);
        icon1:SetWidth(iScale);
        icon1t:SetTextHeight(itScale)
        icon1ta:SetTextHeight(itScale)        
        icon15:SetHeight(iScale);
        icon15:SetWidth(iScale);
        icon15t:SetTextHeight(itScale)
        icon15ta:SetTextHeight(itScale)
        icon16:SetHeight(iScale);
        icon16:SetWidth(iScale);
        if not HealBot_initSkin[b.id] then
            HealBot_initSkin[b.id]=true
            b:Enable();
            bar:SetMinMaxValues(0,100)
            bar2:SetMinMaxValues(0,100);
            bar3:SetMinMaxValues(0,100)
            bar:SetStatusBarColor(0,1,0,Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]);
            if not HealBot_curUnitHealth[bar] then
                uHlth,uMaxHlth=HealBot_UnitHealth(hbGUID, b.unit)
                if uHlth>uMaxHlth then uMaxHlth=HealBot_CorrectPetHealth(b.unit,uHlth,uMaxHlth,hbGUID) end
                if uHlth<uMaxHlth then
                    hcpct=floor(uHlth/uMaxHlth)*100
                else
                    hcpct=100;
                end
                HealBot_curUnitHealth[bar]=hcpct
            end
            bar:SetValue(HealBot_curUnitHealth[bar])
            HealBot_Panel_SetBarArrays(b)
            bar2:SetValue(0);
            bar2:SetStatusBarColor(0,1,0,0);
        end
        if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
            icon15:SetTexture([[Interface\AddOns\HealBot\Images\icon_class.tga]]);
        else
            icon15:SetTexCoord(0,1,0,1);
            icon15:SetAlpha(0);
        end
        if Healbot_Config_Skins.HoTonBar[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_Panel_SetMultiColHoToffset(0)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Current_Skin]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-2,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",4,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-2,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPRIGHT",icon,"TOPRIGHT",4,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"TOPRIGHT",0,1);
                else
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMLEFT",-1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMLEFT",icon15,"BOTTOMLEFT",-2,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPRIGHT",icon15,"TOPRIGHT",4,0);
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",4,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPLEFT",icon1,"TOPLEFT",-2,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",4,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPLEFT",icon,"TOPLEFT",-2,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("BOTTOMLEFT",icon15,"TOPLEFT",0,1);
                else
                    icon16:SetPoint("BOTTOMLEFT",icon15,"BOTTOMRIGHT",1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMRIGHT",-2,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPLEFT",icon15,"TOPLEFT",4,0);
            end
        elseif Healbot_Config_Skins.HoTonBar[Healbot_Config_Skins.Current_Skin]==2 then
            HealBot_Panel_SetMultiColHoToffset((iScale+1)*5)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Current_Skin]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",-1,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",4,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPLEFT",icon1,"TOPLEFT",-2,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",4,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPLEFT",icon,"TOPLEFT",-2,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("BOTTOMLEFT",icon15,"TOPLEFT",0,1);
                else
                    icon16:SetPoint("BOTTOMLEFT",icon15,"BOTTOMRIGHT",1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMRIGHT",-2,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPLEFT",icon15,"TOPLEFT",4,0);
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",2,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-2,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",4,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-2,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPRIGHT",icon,"TOPRIGHT",4,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",-1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"TOPRIGHT",0,1);
                else
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMLEFT",-1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMLEFT",icon15,"BOTTOMLEFT",-2,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPRIGHT",icon15,"TOPRIGHT",4,0);
            end
        else
            HealBot_Panel_SetMultiColHoToffset(0)
            if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                HealBot_Panel_SetMultiRowHoToffset((iScale*2)+1)
            else
                HealBot_Panel_SetMultiRowHoToffset(iScale+1)
            end
            if Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Current_Skin]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("TOPLEFT",b,"BOTTOMLEFT",1,-1);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-2,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",4,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPLEFT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",0,-1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-2,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPRIGHT",icon,"TOPRIGHT",4,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"TOPRIGHT",0,-1);
                else
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMLEFT",-1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMLEFT",icon15,"BOTTOMLEFT",-2,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPRIGHT",icon15,"TOPRIGHT",4,0);
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",4,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPLEFT",icon1,"TOPLEFT",-2,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",0,-1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",4,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPLEFT",icon,"TOPLEFT",-2,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("TOPLEFT",b,"BOTTOMLEFT",1,-1);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Current_Skin]==1 then
                    icon16:SetPoint("TOPLEFT",icon15,"BOTTOMRIGHT",0,-1);
                else
                    icon16:SetPoint("BOTTOMLEFT",icon15,"BOTTOMRIGHT",1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMRIGHT",-2,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPLEFT",icon15,"TOPLEFT",4,0);
            end
        end

        if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]==0 then
            bar3:SetHeight(1);
            bar3:SetValue(0);
            bar3:SetStatusBarColor(0,0,0,0)
        end
        if Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Current_Skin]==0 and 
           Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==0 and
           Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==0 then
            bar4:SetMinMaxValues(0,100)
            bar4:SetValue(0)
            bar4:SetStatusBarColor(0,0,0,0)
        end
        barScale = bar:GetScale();
        bar:SetScale(barScale + 0.01);
        bar:SetScale(barScale);
        barScale = bar2:GetScale();
        bar2:SetScale(barScale + 0.01);
        bar2:SetScale(barScale);
        barScale = bar3:GetScale();
        bar3:SetScale(barScale + 0.01);
        bar3:SetScale(barScale);
        barScale = bar4:GetScale();
        bar4:SetScale(barScale + 0.01);
        bar4:SetScale(barScale);
    elseif barType=="header" then
          --for x=1,15 do
        h=button
        bar = HealBot_Action_HealthBar(h);
        hwidth = ceil(bwidth*Healbot_Config_Skins.headwidth[Healbot_Config_Skins.Current_Skin])
        hheight = ceil(bheight*Healbot_Config_Skins.headhight[Healbot_Config_Skins.Current_Skin])
        HealBot_Panel_SetHeadArrays(h)
        h:SetHeight(hheight);
        h:SetWidth(hwidth);
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.headtexture[Healbot_Config_Skins.Current_Skin]));
        bar:GetStatusBarTexture():SetHorizTile(false)
        bar:SetMinMaxValues(0,100);
        bar:SetValue(100);
        bar:SetStatusBarColor(br,bg,bb,ba);
        bar:SetHeight(hheight);
        bar:SetWidth(hwidth);
        bar.txt = _G[bar:GetName().."_text"];
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.headtextfont[Healbot_Config_Skins.Current_Skin]),Healbot_Config_Skins.headtextheight[Healbot_Config_Skins.Current_Skin],"");
        bar.txt:SetTextColor(sr,sg,sb,sa);
        h:Disable();
        barScale = bar:GetScale();
        bar:SetScale(barScale + 0.01);
        bar:SetScale(barScale);
    elseif barType=="hbfocus" then
        HealBot_Action_hbFocusButtonBar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.btexture[Healbot_Config_Skins.Current_Skin]));
        HealBot_Action_hbFocusButtonBar:GetStatusBarTexture():SetHorizTile(false)

        HealBot_Action_hbFocusButtonBar:SetStatusBarColor(1,1,1,1);
        HealBot_Action_hbFocusButtonBar.txt = _G[HealBot_Action_hbFocusButtonBar:GetName().."_text"];
        HealBot_Action_hbFocusButtonBar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.btextfont[Healbot_Config_Skins.Current_Skin]),btextheight,"");
        HealBot_Action_hbFocusButtonBar.txt:SetTextColor(0,0,0,1);
        iScale=0.84
        iScale=iScale+(numcols/10)
        HealBot_Action_hbFocusButtonBar:SetWidth(bwidth*iScale)
        HealBot_Action_hbFocusButton:SetWidth(bwidth*iScale)
        HealBot_Action_hbFocusButtonBar:SetHeight(bheight); 
        HealBot_Action_hbFocusButton:SetHeight(bheight); 
        HealBot_Action_hbFocusButtonBar.txt:SetText(HEALBOT_ACTION_HBFOCUS)
        barScale = HealBot_Action_hbFocusButtonBar:GetScale();
        HealBot_Action_hbFocusButtonBar:SetScale(barScale + 0.01);
        HealBot_Action_hbFocusButtonBar:SetScale(barScale);
    else
        HealBot_Action_SetAddHeight()
        HealBot_Panel_clearResetHeaderSkinDone()
        HealBot_Action_clearResetBarSkinDone()
        if HealBot_resetSkinTo~=Healbot_Config_Skins.Current_Skin then
            HealBot_resetSkinTo=Healbot_Config_Skins.Current_Skin
            HealBot_Options_RaidTargetUpdate()
            HealBot_CheckFrame()
        end
        if Delay_RecalcParty<4 then 
            Delay_RecalcParty=4; 
        end
    end
end

function HealBot_Action_RefreshButtons(hbGUID)
    if hbGUID then
        HealBot_Action_RefreshButton(HealBot_Unit_Button[HealBot_UnitID[hbGUID]], hbGUID)
    else
        if HealBot_ButtonArray==1 then
            for xUnit,xButton in pairs(HealBot_ButtonArray1) do
                HealBot_Action_CheckRange(xUnit, xButton)
            end
            HealBot_ButtonArray=2
        else
            for xUnit,xButton in pairs(HealBot_ButtonArray2) do
                HealBot_Action_CheckRange(xUnit, xButton)
            end
            HealBot_ButtonArray=1
        end
    end
end

local uRange=0
local db1=nil
local db2=nil
local tdebugtime=GetTime()
function HealBot_Action_CheckRange(unit, button)
    if not HealBot_UnitStatus[unit] then return end
    if HealBot_UnitStatus[unit]>0 then
        uRange=HealBot_UnitInRange(HealBot_UnitRangeSpell[unit] or HealBot_hSpell, unit)
        if unit~="player" and HealBot_UnitStatus[unit]==8 and UnitHealth(unit)>1 then 
            HealBot_OnEvent_UnitHealth(nil,unit,UnitHealth(unit),UnitHealthMax(unit)) 
        end
        if HealBot_UnitRange[unit]==-2 then
            --HealBot_AddDebug("HealBot_UnitRange[unit]==-2 unit="..unit)
            HealBot_Action_RefreshButton(button, HealBot_UnitGUID(unit) or button.guid)
        elseif uRange~=HealBot_UnitRange[unit] then
            ebubar = HealBot_Unit_Bar1[unit]
            ebubar.txt=_G[ebubar:GetName().."_text"];
            ebuicon15 = _G[ebubar:GetName().."Icon15"];
            HealBot_UnitRange[unit]=uRange
            if uRange==1 and not HealBot_PlayerDead then
                ebubar:SetStatusBarColor(HealBot_UnitRanger[unit],HealBot_UnitRangeg[unit],HealBot_UnitRangeb[unit],Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin])
                ebubar.txt:SetTextColor(HealBot_UnitRangeitr[unit],HealBot_UnitRangeitg[unit],HealBot_UnitRangeitb[unit],Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]);
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
                    ebuicon15:SetAlpha(Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin]);
                end
                if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]>0 then 
                    HealBot_UnitRangeb3a[unit]=Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin]
                    HealBot_Action_SetBar3Value(HealBot_Unit_Button[unit]);
                end
                if Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==1 then HealBot_Action_ShowPanel() end
            elseif uRange==0 or Healbot_Config_Skins.NotVisibleDisable[Healbot_Config_Skins.Current_Skin]==0 then
                --ebubar:SetStatusBarColor(HealBot_UnitRanger[unit],HealBot_UnitRangeg[unit],HealBot_UnitRangeb[unit],Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin])
                ebubar:SetStatusBarColor(HealBot_UnitRanger[unit],HealBot_UnitRangeg[unit],HealBot_UnitRangeb[unit],HealBot_UnitRangea[unit])
                ebubar.txt:SetTextColor(HealBot_UnitRangeitr[unit],HealBot_UnitRangeitg[unit],HealBot_UnitRangeitb[unit],HealBot_UnitRangeota[unit]);
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
                    ebuicon15:SetAlpha(HealBot_UnitRangea[unit]);
                end
                if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]>0 then 
                    HealBot_UnitRangeb3a[unit]=HealBot_UnitRangea[unit]
                    HealBot_Action_SetBar3Value(HealBot_Unit_Button[unit]);
                end
            else
                ebubar:SetStatusBarColor(HealBot_UnitRanger[unit],HealBot_UnitRangeg[unit],HealBot_UnitRangeb[unit],Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin])
                ebubar.txt:SetTextColor(HealBot_UnitRangeotr[unit],HealBot_UnitRangeotg[unit],HealBot_UnitRangeotb[unit],Healbot_Config_Skins.btextdisbledcola[Healbot_Config_Skins.Current_Skin]);
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
                    ebuicon15:SetAlpha(Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]);
                end
                if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]>0 then 
                    HealBot_UnitRangeb3a[unit]=Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Current_Skin]
                    HealBot_Action_SetBar3Value(HealBot_Unit_Button[unit]);
                end
            end
        end
    end
end

function HealBot_Action_CheckReserved()
    for xUnit,_ in pairs(HealBot_Reserved) do
        if HealBot_UnitGUID(xUnit) then
            HealBot_UnitNameUpdate(xUnit,HealBot_UnitGUID(xUnit))
            HealBot_Action_ResetUnitStatus(xUnit)
            HealBot_Reserved[xUnit]=nil
        end
    end
end

function HealBot_Action_ShowPanel()
    if HealBot_Config.ActionVisible==0 and HealBot_Config.DisableHealBot==0 then
        HealBot_Config.ActionVisible=1
        ShowUIPanel(HealBot_Action)
    end
end

function HealBot_Action_ResetUnitStatus(unit)
    if unit then
        HealBot_UnitStatus[unit]=1;
        HealBot_UnitRange[unit]=-2
    else
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            HealBot_UnitStatus[xUnit]=1;
            HealBot_UnitRange[xUnit]=-2
        end
    end
end

function HealBot_Action_ResetActiveUnitStatus()
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if HealBot_UnitStatus[xUnit]>0 or UnitHealth(xUnit)<2 then
            HealBot_UnitRange[xUnit]=-2
        end
    end
end

local shb=nil
local shbar=nil

function HealBot_Action_clearResetBarSkinDone()
    for x,_ in pairs(HealBot_ResetBarSkinDone) do
        HealBot_ResetBarSkinDone[x]=nil;
    end
end

function HealBot_Action_SetHealButton(index,unit,hbGUID)
    if hbGUID then
        if not HealBot_Unit_Button[unit] then
            if not HealBot_ButtonStore[1] then
                return nil
            else
                shb=HealBot_ButtonStore[1]
                table.remove(HealBot_ButtonStore,1)
                HealBot_Unit_Button[unit]="init"
            end
        else
            shb=HealBot_Unit_Button[unit]
        end
        if not HealBot_UnitSpec[hbGUID] then
            HealBot_UnitID[hbGUID]="init"
            HealBot_Unit_Button[unit]="init"
            HealBot_UnitSpec[hbGUID] = " "
            HealBot_UnitTime[hbGUID]=GetTime()
        end
        if HealBot_UnitID[hbGUID]~=unit then
            HealBot_UnitID[hbGUID]=unit
            HealBot_CheckAllBuffs(hbGUID)
            HealBot_CheckAllDebuffs(hbGUID)
            HealBot_Unit_Button[unit]="init"
            HealBot_GUID[unit]=hbGUID
        end
        if HealBot_Unit_Button[unit]~=shb or not shb.guid then
            shb.unit=unit
            shb.guid=hbGUID
            shb:SetAttribute("unit", unit);
            HealBot_Action_SetAllButtonAttribs(shb,"Enabled")
            HealBot_Unit_Button[unit]=shb
            HealBot_UnitStatus[unit]=9
            HealBot_UnitRange[unit]=-2
            HealBot_Unit_Bar1[unit]=HealBot_Action_HealthBar(shb)
            HealBot_Unit_Bar2[unit]=HealBot_Action_HealthBar2(shb)
            HealBot_Unit_Bar3[unit]=HealBot_Action_HealthBar3(shb)
            HealBot_Unit_Bar4[unit]=HealBot_Action_HealthBar4(shb)
            HealBot_UnitRangeSpell[unit]=HealBot_hSpell
            HealBot_Enabled[hbGUID]=false
            HealBot_CheckHealth(hbGUID)
            shb:Show()
        elseif hbGUID~=shb.guid then
            shb.guid=hbGUID
            HealBot_CheckHealth(hbGUID)
            HealBot_UnitStatus[unit]=9
            HealBot_UnitRange[unit]=-2
        end
        if not HealBot_ResetBarSkinDone[shb.id] then
            HealBot_Action_ResetSkin("bar",shb)
        end
    else
        return nil
    end
    return shb
end

function HealBot_Action_SetTargetHealButton(unit,hbGUID)
    if hbGUID then
        shb=_G["HealBot_Action_HealUnit56"];
        if not HealBot_UnitSpec[hbGUID] then
            HealBot_Unit_Button[unit]="init"
            HealBot_UnitSpec[hbGUID] = " "
            HealBot_UnitTime[hbGUID]=GetTime()
        end
        if HealBot_Unit_Button[unit]~=shb or not shb.guid then
            shb.unit=unit
            shb.guid=hbGUID
            shb:SetAttribute("unit", unit);
            if Healbot_Config_Skins.TargetBarNormalMode[Healbot_Config_Skins.Current_Skin]==0 then      
                HealBot_Action_SetAllButtonAttribs(shb,"Enabled")
            else
                HealBot_Action_SetAllButtonAttribs(shb,"nil")
            end
            HealBot_Unit_Button[unit]=shb
            HealBot_UnitStatus[unit]=9
            HealBot_UnitRange[unit]=-2
            HealBot_Unit_Bar1[unit]=HealBot_Action_HealthBar(shb)
            HealBot_Unit_Bar2[unit]=HealBot_Action_HealthBar2(shb)
            HealBot_Unit_Bar3[unit]=HealBot_Action_HealthBar3(shb)
            HealBot_Unit_Bar4[unit]=HealBot_Action_HealthBar4(shb)
            HealBot_CheckHealth(hbGUID)
            HealBot_UnitRangeSpell[unit]=HealBot_hSpell
        elseif hbGUID~=shb.guid then
            shb.guid=hbGUID
            HealBot_CheckHealth(hbGUID)
            HealBot_UnitStatus[unit]=9
            HealBot_UnitRange[unit]=-2
        end
        if not HealBot_ResetBarSkinDone[shb.id] then
            HealBot_Action_ResetSkin("bar",shb)
        end 
        if not HealBot_UnitID[hbGUID] then
            HealBot_UnitID[hbGUID]=unit
            HealBot_CheckAllBuffs(hbGUID)
            HealBot_CheckAllDebuffs(hbGUID)
        end
        HealBot_GUID[unit]=hbGUID
        shb:Show()
    else
        return nil
    end
    return shb
end

function HealBot_Action_SetTestButton(index)
    shb=nil
    if HealBot_ButtonStore[1] then
        shb=HealBot_ButtonStore[1]
        table.remove(HealBot_ButtonStore,1)
        shb.unit=HEALBOT_WORD_TEST.." "..index
      --  shb.guid=index
    end
    if shb and not HealBot_ResetBarSkinDone[shb.id] then
        HealBot_Action_ResetSkin("bar",shb)
    end 
    return shb
end

local HealBotButtonMacroAttribs={}
function HealBot_Action_SetAllAttribs()
 --   HealBot_AddDebug("In HealBot_Action_SetAllAttribs")
    HealBot_ResetAttribs=true
    Delay_RecalcParty=1
end

local HB_button,HB_prefix=nil
local HB_combo_prefix=nil
local HealBot_Keys_List = {"","Shift","Ctrl","Alt","Alt-Shift","Ctrl-Shift"}
local hbAttribsMinReset = {}
function HealBot_Action_SetAllButtonAttribs(button,status)
    for x=1,15 do
  --      HB_button=HealBot_Options_ComboClass_Button(x) ' Cannot use this as 2 returns Middle and 3 returns Right, this function is older than Blizzards secure templates.
        if x==1 then 
            HB_button="Left";
        elseif x==2 then 
            HB_button="Right";
        elseif x==3 then 
            HB_button="Middle";
        elseif x==4 then 
            HB_button="Button4";
        elseif x==5 then 
            HB_button="Button5";
        elseif x==6 then 
            HB_button="Button6";
        elseif x==7 then 
            HB_button="Button7";
        elseif x==8 then 
            HB_button="Button8";
        elseif x==9 then 
            HB_button="Button9";
        elseif x==10 then 
            HB_button="Button10";
        elseif x==11 then
            HB_button="Button11";
        elseif x==12 then
            HB_button="Button12";
        elseif x==13 then
            HB_button="Button13";
        elseif x==14 then
            HB_button="Button14";
        elseif x==15 then
            HB_button="Button15";
        end
    
        for y=1, getn(HealBot_Keys_List), 1 do
            if strlen(HealBot_Keys_List[y])>1 then
                HB_prefix = strlower(HealBot_Keys_List[y]).."-"
            else
                HB_prefix = "";
            end
            if not hbAttribsMinReset[button.id..HB_prefix..status..x] then
                HealBot_Action_SetButtonAttrib(button,HB_button,HealBot_Keys_List[y],status,x)
            end
        end
    end
end

--local mUnit=nil
local mText=nil
local mId=nil
local showmenu=nil
local showHBmenu=nil
local setDropdown=nil
local partyNo=nil
local sTar, sTrin1, sTrin2=0, 0, 0
local curGUID=nil
function HealBot_Action_SetButtonAttrib(button,bbutton,bkey,status,j)
 
    if strlen(bkey)>1 then
        HB_prefix = strlower(bkey).."-"
    else
        HB_prefix = "";
    end
    
    HB_combo_prefix = bkey..bbutton..HealBot_Config.CurrentSpec;
    if status=="Enabled" then
        sName, sTar, sTrin1, sTrin2 = HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    elseif status=="Disabled" then
        sName, sTar, sTrin1, sTrin2 = HealBot_Action_AttribDisSpellPattern(HB_combo_prefix)
    else
        sName=nil;
    end
    if sName then
        if strlower(sName)==strlower(HEALBOT_DISABLED_TARGET) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, "target"..j);
            button:SetAttribute(HB_prefix.."type"..j, "target")
            button:SetAttribute(HB_prefix.."type-target"..j, "target")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_FOCUS) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, "focus"..j);
            button:SetAttribute(HB_prefix.."type"..j, "focus")
            button:SetAttribute(HB_prefix.."type-focus"..j, "focus")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_ASSIST) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, "assist"..j);
            button:SetAttribute(HB_prefix.."type"..j, "assist")
            button:SetAttribute(HB_prefix.."type-assist"..j, "assist")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_STOP) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, "/stopcasting")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strsub(strlower(sName),1,4)==strlower(HEALBOT_TELL) then
            mText='/script local n=UnitName("hbtarget");SendChatMessage("hbMSG","WHISPER",nil,n)'
            mText=string.gsub(mText,"hbtarget",button.unit)
            mText=string.gsub(mText,"hbMSG", strtrim(strsub(sName,5)))
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_MENU) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "showmenu")
            showmenu = function()
                if button.unit=="player" then
                    setDropdown=PlayerFrameDropDown
                elseif button.unit=="target" then
                    setDropdown=TargetFrameDropDown
                elseif button.unit=="pet" then
                    setDropdown=PetFrameDropDown
                else
                    xUnit=HealBot_Action_UnitID(button.unit)
                    partyNo = tonumber(xUnit:match('party(%d+)')) or 0
                    if partyNo > 0 then
                        setDropdown = _G['PartyMemberFrame' .. partyNo .. 'DropDown']
                    else
                        partyNo = tonumber(xUnit:match('raid(%d+)')) or 0
                        if partyNo == 0 then
                            partyNo=button.id
                        end
                        FriendsDropDown.name = UnitName(xUnit);    
                        FriendsDropDown.id = partyNo;    
                        FriendsDropDown.unit = xUnit;    
                        FriendsDropDown.initialize = RaidFrameDropDown_Initialize;    
                        FriendsDropDown.displayMode = "MENU";    
                        setDropdown=FriendsDropDown
                    end
                end
                ToggleDropDownMenu(1, nil, setDropdown, "cursor", 10, -8)  
            end
            button.showmenu = showmenu 
        elseif strlower(sName)==strlower(HEALBOT_HBMENU) and HealBot_UnitGUID(button.unit) then
            curGUID=HealBot_UnitGUID(button.unit)
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "showhbmenu")
            showHBmenu = function()
                local HBFriendsDropDown = CreateFrame("Frame", "HealBot_Action_hbmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
                HBFriendsDropDown.unit = button.unit
                HBFriendsDropDown.name = UnitName(button.unit)
                HBFriendsDropDown.initialize = HealBot_Action_hbmenuFrame_DropDown_Initialize
                HBFriendsDropDown.displayMode = "MENU"
                ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
            end
            button.showhbmenu = showHBmenu
        elseif strlower(sName)==strlower(HEALBOT_MAINTANK) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "maintank")
            button:SetAttribute(HB_prefix.."type-maintank"..j, "toggle")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_MAINASSIST) then
            button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "mainassist")
            button:SetAttribute(HB_prefix.."type-mainassist"..j, "toggle")
            hbAttribsMinReset[button.id..HB_prefix..status..j]=true
        else
            sID=HealBot_GetSpellId(sName)
            if sID then
                if sTar==1 or sTrin1==1 or sTrin2==1 then
                    mText = HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, button.unit, HB_combo_prefix)
                    button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
                    button:SetAttribute(HB_prefix.."type"..j,"macro")
                    button:SetAttribute(HB_prefix.."macrotext"..j, mText)
                else
                    button:SetAttribute(HB_prefix.."helpbutton"..j, "heal"..j);
                    button:SetAttribute(HB_prefix.."type-heal"..j, "spell");
                    button:SetAttribute(HB_prefix.."spell-heal"..j, sName);
                    hbAttribsMinReset[button.id..HB_prefix..status..j]=true
                end
            else
                mId=GetMacroIndexByName(sName)
                if mId ~= 0 then
                    _,_,mText=GetMacroInfo(mId)
         --        mUnit = button.unit
                    if UnitExists(HealBot_UnitPet(button.unit)) then
                        mText=string.gsub(mText,"hbtargetpet",HealBot_UnitPet(button.unit))
                    end
                    mText=string.gsub(mText,"hbtargettargettarget",button.unit.."targettarget")
                    mText=string.gsub(mText,"hbtargettarget",button.unit.."target")
                    mText=string.gsub(mText,"hbtarget",button.unit)
                    button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
                    button:SetAttribute(HB_prefix.."type"..j,"macro")
                    button:SetAttribute(HB_prefix.."macrotext"..j, mText)
                    if status=="Enabled" then
                        HealBotButtonMacroAttribs[HB_prefix..j]=sName
                    end
                else
                    button:SetAttribute(HB_prefix.."helpbutton"..j, "item"..j);
                    button:SetAttribute(HB_prefix.."type-item"..j, "item");
                    button:SetAttribute(HB_prefix.."item-item"..j, sName);
                end
            end
        end
    else
        button:SetAttribute(HB_prefix.."helpbutton"..j, nil);
    end
end

function HealBot_Action_SethbFocusButtonAttrib(button)
    button:SetAttribute("unit", "target")
    button:SetAttribute("helpbutton1", "focus1");
    button:SetAttribute("type1", "focus")
    button:SetAttribute("type-focus1", "focus")
end

local smName={}
local sysSoundSFX = strsub(GetCVar("Sound_EnableSFX") or "nil",1,1)

function HealBot_Action_AlterSpell2Macro(spellName, spellTar, spellTrin1, spellTrin2, unit, combo)
    if not smName[combo..unit] then
        smName[combo..unit]=""
        if HealBot_Config.MacroSuppressSound==1 and sysSoundSFX=="1" then smName[combo..unit]=smName[combo..unit].."/console Sound_EnableSFX 0;\n" end
        if HealBot_Config.MacroSuppressError==1 then smName[combo..unit]=smName[combo..unit].."/script UIErrorsFrame:Hide();\n" end
        if spellTar==1 then smName[combo..unit]=smName[combo..unit].."/target "..unit..";\n" end
        if spellTrin1==1 then smName[combo..unit]=smName[combo..unit].."/use 13;\n" end
        if spellTrin2==1 then smName[combo..unit]=smName[combo..unit].."/use 14;\n" end
        if HealBot_Config.MacroUse10==1 then smName[combo..unit]=smName[combo..unit].."/use 10;\n" end
        if HealBot_Config.MacroSuppressError==1 then smName[combo..unit]=smName[combo..unit].."/script UIErrorsFrame:Clear(); UIErrorsFrame:Show();\n" end
        if HealBot_Config.MacroSuppressSound==1 and sysSoundSFX=="1" then smName[combo..unit]=smName[combo..unit].."/console Sound_EnableSFX 1;\n" end
        smName[combo..unit]=smName[combo..unit].."/cast [@"..unit.."] "..spellName..";"
        if strlen(smName[combo..unit])>255 then
            smName[combo..unit]=""
            if HealBot_Config.MacroSuppressSound==1 and sysSoundSFX=="1" then smName[combo..unit]=smName[combo..unit].."/console Sound_EnableSFX 0;\n" end
            if spellTar==1 then smName[combo..unit]=smName[combo..unit].."/target "..UnitName(unit)..";\n" end
            if spellTrin1==1 then smName[combo..unit]=smName[combo..unit].."/use 13;\n" end
            if spellTrin2==1 then smName[combo..unit]=smName[combo..unit].."/use 14;\n" end
            if HealBot_Config.MacroUse10==1 then smName[combo..unit]=smName[combo..unit].."/use 10;\n" end
            if HealBot_Config.MacroSuppressSound==1 and sysSoundSFX=="1" then smName[combo..unit]=smName[combo..unit].."/console Sound_EnableSFX 1;\n" end
            smName[combo..unit]=smName[combo..unit].."/cast [@"..unit.."] "..spellName..";"
            if strlen(smName[combo..unit])>255 then
                smName[combo..unit]=""
                if spellTar==1 then smName[combo..unit]=smName[combo..unit].."/target "..UnitName(unit)..";\n" end
                if spellTrin1==1 then smName[combo..unit]=smName[combo..unit].."/use 13;\n" end
                if spellTrin2==1 then smName[combo..unit]=smName[combo..unit].."/use 14;\n" end
                if HealBot_Config.MacroUse10==1 then smName[combo..unit]=smName[combo..unit].."/use 10;\n" end
                smName[combo..unit]=smName[combo..unit].."/cast [@"..unit.."] "..spellName..";"
                if strlen(smName[combo..unit])>255 then
                    smName[combo..unit]=spellName
                end
            end
        end
    end
    return smName[combo..unit]
end

function HealBot_Action_hbmenuFrame_DropDown_Initialize(self,level)
    local info
    level = level or 1;
    if level==1 then
 
        info = UIDropDownMenu_CreateInfo();
        info.isTitle = 1
        info.text = self.name
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Action_RetMyTarget(HealBot_UnitGUID(self.unit)) then
            info.text = HEALBOT_SKIN_DISTEXT;
        else
            info.text = HEALBOT_SKIN_ENTEXT;
        end
        info.func = function() HealBot_Action_Toggle_Enabled(HealBot_UnitGUID(self.unit)); end
        UIDropDownMenu_AddButton(info, 1);

        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetMyHealTarget(HealBot_UnitGUID(self.unit)) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_TARGETHEALS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_TARGETHEALS
        end
        info.func = function() HealBot_Panel_ToggelHealTarget(HealBot_UnitGUID(self.unit)); end;
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateTanks(HealBot_UnitGUID(self.unit)) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATETANKS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATETANKS
        end
        info.func = function() HealBot_Panel_ToggelPrivateTanks(HealBot_UnitGUID(self.unit)); end;
        UIDropDownMenu_AddButton(info, 1);

        info = UIDropDownMenu_CreateInfo();
        info.notCheckable = true;
        if HealBot_retHbFocus(self.name) then
            info.text = HEALBOT_WORD_CLEAR.." "..HEALBOT_WORD_HBFOCUS;
            info.hasArrow = false;
            info.func = function() HealBot_ToggelFocusMonitor(self.name); end;
        else
            info.text = HEALBOT_WORD_SET.." "..HEALBOT_WORD_HBFOCUS
            info.hasArrow = true; 
        end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_WORD_RESET
        info.func = function() HealBot_Reset_Unit(HealBot_UnitGUID(self.unit)); end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_PANEL_BLACKLIST
        info.func = function() HealBot_Panel_AddBlackList(HealBot_UnitGUID(self.unit)); end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_WORD_CANCEL
        UIDropDownMenu_AddButton(info, 1);
    end
    if level==2 then
        info = UIDropDownMenu_CreateInfo();
        _,z = IsInInstance()
        info.text = HEALBOT_WORD_ALLZONE
        info.hasArrow = false; 
        info.notCheckable = true;
        info.func = function() HealBot_ToggelFocusMonitor(self.name, "all"); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info = UIDropDownMenu_CreateInfo();
        _,z = IsInInstance()
        if z=="pvp" or z == "arena" then 
            z = "bg"
            info.text = HEALBOT_WORD_BATTLEGROUND
        elseif z~="none" then
            z = GetRealZoneText()
            info.text=z
        else
            info.text = HEALBOT_WORD_OUTSIDE
        end
        info.hasArrow = false; 
        info.notCheckable = true;
        info.func = function() HealBot_ToggelFocusMonitor(self.name, z); end;
        UIDropDownMenu_AddButton(info, 2);
    end
end

function HealBot_Action_UnitID(unit)
    if strsub(unit,1,4)=="raid" then
        if UnitIsUnit(unit,"party1") then
            unit="party1"
        elseif UnitIsUnit(unit,"party2") then
            unit="party2"
        elseif UnitIsUnit(unit,"party3") then
            unit="party3"
        elseif UnitIsUnit(unit,"party4") then
            unit="party4"
        end
    end
    return unit
end

local hbCombos, hbTarget, hbTrinket1, hbTrinket2=nil, nil, nil, nil
function HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    hbCombos = HealBot_Config.EnabledKeyCombo
    hbTarget = HealBot_Config.EnabledSpellTarget
    hbTrinket1 = HealBot_Config.EnabledSpellTrinket1
    hbTrinket2 = HealBot_Config.EnabledSpellTrinket2
    if not hbCombos then 
        return nil 
    end
    return hbCombos[HB_combo_prefix], hbTarget[HB_combo_prefix] or 0, hbTrinket1[HB_combo_prefix] or 0, hbTrinket2[HB_combo_prefix] or 0
end

function HealBot_Action_AttribDisSpellPattern(HB_combo_prefix)
    hbCombos = HealBot_Config.DisabledKeyCombo
    hbTarget = HealBot_Config.DisabledSpellTarget
    hbTrinket1 = HealBot_Config.DisabledSpellTrinket1
    hbTrinket2 = HealBot_Config.DisabledSpellTrinket2
    if not hbCombos then 
        return nil 
    end
    return hbCombos[HB_combo_prefix], hbTarget[HB_combo_prefix] or 0, hbTrinket1[HB_combo_prefix] or 0, hbTrinket2[HB_combo_prefix] or 0
end

local hbInitButtons=false
function HealBot_Action_ResethbInitButtons()
    hbInitButtons=false
end

local uCnt=0
function HealBot_Action_PartyChanged(HealBot_PreCombat)
    if HealBot_Config.DisableHealBot==1 then return end
    if InCombatLockdown() then 
        HealBot_IsFighting=true
    elseif HealBot_IsFighting then 
        HealBot_PreCombat=true
        HealBot_IsFighting=nil
    end
    if not HealBot_IsFighting and HealBot_PlayerGUID then
        if HealBot_FrameMoving and HealBot_PreCombat then
            HealBot_Action_OnDragStop(self)
        elseif HealBot_FrameMoving then
            Delay_RecalcParty=1
            return
        end
  
        if not HealBot_PreCombat and HealBot_ResetAttribs then
            for j=1,56 do
                b=_G["HealBot_Action_HealUnit"..j]
                b.guid=nil
            end
            for x,_ in pairs(HealBot_UnitID) do
                HealBot_UnitID[x]=nil;
            end
            for x,_ in pairs(HealBotButtonMacroAttribs) do
                HealBotButtonMacroAttribs[x]=nil;
            end
            for x,_ in pairs(smName) do
                smName[x]=nil;
            end
            for x,_ in pairs(hbAttribsMinReset) do
                hbAttribsMinReset[x]=nil;
            end
            HealBot_ResetAttribs=nil
        end

        if not hbInitButtons then
            for x,_ in pairs(HealBot_ButtonStore) do
                HealBot_ButtonStore[x]=nil;
            end
            for xUnit,xButton in pairs(HealBot_Unit_Button) do
                HealBot_Unit_Button[xUnit]=nil
            end 
            for x=1,55 do
                b=_G["HealBot_Action_HealUnit"..x];
                HealBot_Action_InsButtonStore(b)
                b.id=x
            end
            b=_G["HealBot_Action_HealUnit56"]
            b.id=56
            hbInitButtons=true
        end
        
        if HealBot_PreCombat then 
            HealBot_EnteringCombat()
        end
  
        if Healbot_Config_Skins.ShowHeader[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_Panel_PartyChanged(true)
        else
            HealBot_Panel_PartyChanged(false)
        end
        uCnt=0
        HealBot_ButtonArray=1
        for x,_ in pairs(HealBot_ButtonArray1) do
            HealBot_ButtonArray1[x]=nil;
        end
        for x,_ in pairs(HealBot_ButtonArray2) do
            HealBot_ButtonArray2[x]=nil;
        end
    
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            uCnt=uCnt+1
            if HealBot_ButtonArray==1 then
                HealBot_ButtonArray1[xUnit]=xButton
                if uCnt==1 then HealBot_ButtonArray2[xUnit]=xButton end
                HealBot_ButtonArray=2
            else
                HealBot_ButtonArray2[xUnit]=xButton
                HealBot_ButtonArray=1
            end
            if HealBot_UnitStatus[xUnit]==9 then
                HealBot_Action_ResetUnitStatus(xUnit)
            end
        end
    elseif Delay_RecalcParty<2 then 
        Delay_RecalcParty=2; 
    end
end

function HealBot_Action_InsButtonStore(b)
    if not HealBot_ButtonStore[b] then
        table.insert(HealBot_ButtonStore,b)
        HealBot_HoT_RemoveIconButton(b,true)
        if b.guid then b.guid=nil end
        b:Hide();
        HealBot_Panel_SetBarArrays(b)
    end
end

function HealBot_Action_retButtonStoreCnt()
    return getn(HealBot_ButtonStore)
end

function HealBot_Action_Reset()
    Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]=0
    Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()/2
    Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()/2
    HealBot_Action_setPoint()
    HealBot_Action:Show()
    HealBot_Action_unlockFrame()
end

function HealBot_Action_unlockFrame()
    Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Current_Skin]=0
    HealBot_Options_ActionLocked:SetChecked(Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Current_Skin])
end

function HealBot_Action_setPoint()
    if Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==1 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==2 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("BOTTOMLEFT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==3 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("TOPRIGHT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==4 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("BOTTOMRIGHT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==5 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("TOP","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==6 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("LEFT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==7 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("RIGHT","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==8 then
        HealBot_Action:ClearAllPoints();
        HealBot_Action:SetPoint("BOTTOM","UIParent","BOTTOMLEFT",Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin],Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]);
    end
end

local hbClassCols = {
          ["DRUI"] = {r=1.0,  g=0.49, b=0.04, },
          ["HUNT"] = {r=0.67, g=0.83, b=0.45, },
          ["MAGE"] = {r=0.41, g=0.8,  b=0.94, },
          ["PALA"] = {r=0.96, g=0.55, b=0.73, },
          ["PRIE"] = {r=1.0,  g=1.0,  b=1.0,  },
          ["ROGU"] = {r=1.0,  g=0.96, b=0.41, },
          ["SHAM"] = {r=0.14, g=0.35, b=1.0,  },
          ["WARL"] = {r=0.58, g=0.51, b=0.79, },
          ["DEAT"] = {r=0.78, g=0.04, b=0.04, },
          ["WARR"] = {r=0.78, g=0.61, b=0.43, },
      }
      
function HealBot_Action_ClassColour(hbGUID, unit)
    class=nil
    if unit and UnitClass(unit) then
        _,class=UnitClass(unit)
    elseif hbGUID and HealBot_UnitID[hbGUID] and UnitClass(HealBot_UnitID[hbGUID]) then
        _,class=UnitClass(HealBot_UnitID[hbGUID])        
    end
    if class then
        class = strsub(class,1,4)
    else
        class = "WARR"
    end
    return hbClassCols[class].r, hbClassCols[class].g, hbClassCols[class].b
end

function HealBot_Action_ShowTooltip(unit)
    if HealBot_Config.ShowTooltip==0 then return end
    HealBot_Action_TooltipUnit = unit;
    HealBot_Action_DisableTooltipUnit = nil;
    HealBot_Action_RefreshTooltip(unit,"Enabled");
end

function HealBot_Action_ShowDisabledTooltip(unit)
    if HealBot_Config.ShowTooltip==0 then return end
    HealBot_Action_TooltipUnit = nil;
    HealBot_Action_DisableTooltipUnit = unit;
    HealBot_Action_RefreshTooltip(unit,"Disabled");
end

function HealBot_Action_HideTooltip(self)
    HealBot_Action_TooltipUnit = nil;
    HealBot_Action_DisableTooltipUnit = nil;
    HealBot_Action_HideTooltipFrame()
    HealBot_InspectUnit=false
end

function HealBot_Action_HideTooltipFrame()
    HealBot_Tooltip:Hide();
end

function HealBot_Action_Refresh(hbGUID)
    if HealBot_Config.DisableHealBot==1 then return end
    if HealBot_PlayerDead then
        if Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==1 and HealBot_Config.ActionVisible~=0 and not HealBot_IsFighting then
            HideUIPanel(HealBot_Action); 
        else
            HealBot_Action_RefreshButtons(hbGUID);
        end
        return;
    end
    HealBot_Action_RefreshButtons(hbGUID);
    if not HealBot_IsFighting then
        if HealBot_Config.ActionVisible==0 then
            if HealBot_Action_ShouldHealSome(hbGUID) then
                ShowUIPanel(HealBot_Action)
            end
        elseif Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==1 then 
            if not HealBot_Action_ShouldHealSome(hbGUID) then
                HideUIPanel(HealBot_Action);
            end
        end
    end
end

function HealBot_Action_SpellPattern(button,state)
    if state and state=="Disabled" then
        hbCombos = HealBot_Config.DisabledKeyCombo
    else
        hbCombos = HealBot_Config.EnabledKeyCombo
    end
    if not hbCombos then return nil end
    x = button;
    if IsShiftKeyDown() then 
        if IsAltKeyDown() then 
            x = "Alt-Shift"..x
        elseif IsControlKeyDown() then 
            x = "Ctrl-Shift"..x
        else
            x = "Shift"..x
        end
    elseif IsAltKeyDown() then 
        x = "Alt"..x
    elseif IsControlKeyDown() then 
        x = "Ctrl"..x 
    end
    x=x..HealBot_Config.CurrentSpec
    return hbCombos[x]
end

function HealBot_Action_HealUnit_OnEnter(self)
    if not self.unit then return; end
    xGUID=HealBot_UnitGUID(self.unit)
    HealBot_curGUID=xGUID
    if HealBot_IsFighting then
        if HealBot_Config.DisableToolTipInCombat==0 then
            HealBot_Action_ShowTooltip(self.unit);
        else
            HealBot_Action_TooltipUnit = self.unit
        end
    elseif UnitAffectingCombat(self.unit)==1 then
        HealBot_Action_ShowTooltip(self.unit);
    elseif HealBot_Enabled[xGUID] or HealBot_Config.EnableHealthy==1 then 
        HealBot_Action_ShowTooltip(self.unit);
    else
        if not HealBot_PlayerDead then
            HealBot_Action_ShowDisabledTooltip(self.unit);
        end
    end
    if Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==1 and not UnitIsDeadOrGhost(self.unit) and HealBot_retHighlightTarget()~=self.unit then
        z=false
        if HealBot_IsFighting then
            if Healbot_Config_Skins.HighLightActiveBarInCombat[Healbot_Config_Skins.Current_Skin]==1 then z=true end
        else
            z=true
        end
        if z then
            HealBot_Action_UpdateAggro(self.unit,"highlight",HealBot_UnitThreat[xGUID] or 0,xGUID)
        end
    end
end

function HealBot_Action_HealUnit_OnLeave(self)
    HealBot_Action_HideTooltip(self);
    xGUID=HealBot_UnitGUID(self.unit)
    if Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==1 and HealBot_Hightlight[xGUID] and HealBot_Hightlight[xGUID]=="M" then
        if HealBot_Aggro[xGUID] and HealBot_Aggro[xGUID]=="h" then
            HealBot_Action_UpdateAggro(self.unit,"off",nil,xGUID)
        end
    end
    HealBot_curGUID=nil
end

local HEALBOT_MOUSEWHEEL={["U"] = HEALBOT_MENU, ["D"] = HEALBOT_HBMENU,}

function HealBot_Action_HealUnit_Wheel(delta)
    if not HealBot_curGUID then return end
    xUnit=HealBot_UnitID[HealBot_curGUID] or "none"
    if not UnitExists(xUnit) then return end
    
    if HealBot_Config.HealBot_MouseWheelMod>1 then
        y=9
        if IsShiftKeyDown() then
            if not IsControlKeyDown() and not IsAltKeyDown() then  y=2 end
        elseif IsControlKeyDown() then
            if not IsShiftKeyDown() then
                if not IsAltKeyDown() then 
                    y=3 
                else
                    y=5
                end
            end
        elseif IsAltKeyDown() then
            if not IsControlKeyDown() and not IsShiftKeyDown() then y=4 end
        end
        if HealBot_Config.HealBot_MouseWheelMod~=y then return end
    end
    
    if delta>0 then
        delta="U"
    else
        delta="D"
    end
    
    if strlower(HEALBOT_MOUSEWHEEL[delta])==strlower(HEALBOT_MENU) then
        if xUnit=="player" then
            setDropdown=PlayerFrameDropDown
        elseif xUnit=="target" then
            setDropdown=TargetFrameDropDown
        elseif xUnit=="pet" then
            setDropdown=PetFrameDropDown
        else
            partyNo = tonumber(xUnit:match('party(%d+)')) or 0
            if partyNo > 0 then
                setDropdown = _G['PartyMemberFrame' .. partyNo .. 'DropDown']
            else
                partyNo = tonumber(strmatch(xUnit, "(%d+)"))
                FriendsDropDown.name = UnitName(xUnit);    
                FriendsDropDown.id = partyNo;    
                FriendsDropDown.unit = xUnit;    
                FriendsDropDown.initialize = RaidFrameDropDown_Initialize;    
                FriendsDropDown.displayMode = "MENU";    
                setDropdown=FriendsDropDown
            end
        end
        ToggleDropDownMenu(1, nil, setDropdown, "cursor", 10, -8)  
    
    elseif strlower(HEALBOT_MOUSEWHEEL[delta])==strlower(HEALBOT_HBMENU) then
        local HBFriendsDropDown = CreateFrame("Frame", "HealBot_Action_hbmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
        HBFriendsDropDown.unit = xUnit
        HBFriendsDropDown.name = UnitName(xUnit)
        HBFriendsDropDown.initialize = HealBot_Action_hbmenuFrame_DropDown_Initialize
        HBFriendsDropDown.displayMode = "MENU"
        ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
    end

end

function HealBot_Action_OptionsButton_OnLoad(self)
    HealBot_Action_OptionsButtonBar:SetMinMaxValues(0,100);
    HealBot_Action_OptionsButtonBar:SetValue(0);
end

function HealBot_Action_OptionsButton_OnClick(self)
    HealBot_TogglePanel(HealBot_Options);
end

function HealBot_Action_hbFocusButton_OnLoad(self)
    HealBot_Action_hbFocusButtonBar:SetMinMaxValues(0,100);
    HealBot_Action_hbFocusButtonBar:SetValue(100);
    HealBot_Action_SethbFocusButtonAttrib(_G["HealBot_Action_hbFocusButton"])
    b=_G["HealBot_Action_hbFocusButton"]
    b.id=999
    HealBot_Action_OnLoad(self)
end

function HealBot_Action_OnLoad(self)
    self:SetScript("PreClick", HealBot_Action_PreClick); 
    self:SetScript("PostClick", HealBot_Action_PostClick)
end

function HealBot_Action_setRegisterForClicks()
    if HealBot_Config.ButtonCastMethod==1 then
        for x=1,56 do
            b=_G["HealBot_Action_HealUnit"..x];
            b:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                                "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                               "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down");
         end
         HealBot_Action_hbFocusButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
    else
        for x=1,56 do
            b=_G["HealBot_Action_HealUnit"..x];
            b:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up",
                                "Button6Up", "Button7Up", "Button8Up", "Button9Up", "Button10Up",
                                "Button11Up", "Button12Up", "Button13Up", "Button14Up", "Button15Up");
        end
        HealBot_Action_hbFocusButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    end
end

local HealBot_Action_Timer1,HealBot_Action_Timer2 = -2,-2

function HealBot_Action_Set_Timers(override)
    if HealBot_Panel_retTestBars() then
        HB_Action_Timer1 = 0.02
    else
        if HealBot_Config.DisableHealBot==0 and Healbot_Config_Skins.UseFluidBars[Healbot_Config_Skins.Current_Skin]==1 then
            if not override then
                HB_Action_Timer1 = 0.02
            else
                HB_Action_Timer1 = 0.5
            end
        else
            HB_Action_Timer1 = 5
        end
    end
    if HealBot_Config.DisableHealBot==0 and ((Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1) or 
                                             (Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==1 or Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==1)) then
        if not override then
            HB_Action_Timer2 = Healbot_Config_Skins.AggroBarsFreq[Healbot_Config_Skins.Current_Skin]
        else
            HB_Action_Timer2 = 0.5
        end
    else
        HB_Action_Timer2 = 2
    end
end

local HealBot_AggroBarColr = {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1}
local HealBot_AggroBarColg = {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1}
local HealBot_AggroBarColb = {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1}
local HealBot_AggroUnitThreat=1
local HealBot_HasAggro=false

function HealBot_Action_SetDebuffAggroCols()
    HealBot_AggroBarColr[5]=HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].R
    HealBot_AggroBarColg[5]=HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].G
    HealBot_AggroBarColb[5]=HealBot_Config.CDCBarColour[HEALBOT_DISEASE_en].B 
    HealBot_AggroBarColr[6]=HealBot_Config.CDCBarColour[HEALBOT_MAGIC_en].R
    HealBot_AggroBarColg[6]=HealBot_Config.CDCBarColour[HEALBOT_MAGIC_en].G
    HealBot_AggroBarColb[6]=HealBot_Config.CDCBarColour[HEALBOT_MAGIC_en].B 
    HealBot_AggroBarColr[7]=HealBot_Config.CDCBarColour[HEALBOT_POISON_en].R
    HealBot_AggroBarColg[7]=HealBot_Config.CDCBarColour[HEALBOT_POISON_en].G
    HealBot_AggroBarColb[7]=HealBot_Config.CDCBarColour[HEALBOT_POISON_en].B 
    HealBot_AggroBarColr[8]=HealBot_Config.CDCBarColour[HEALBOT_CURSE_en].R
    HealBot_AggroBarColg[8]=HealBot_Config.CDCBarColour[HEALBOT_CURSE_en].G
    HealBot_AggroBarColb[8]=HealBot_Config.CDCBarColour[HEALBOT_CURSE_en].B 
    HealBot_AggroBarColr[9]=HealBot_Config.CDCBarColour[HEALBOT_CUSTOM_en].R
    HealBot_AggroBarColg[9]=HealBot_Config.CDCBarColour[HEALBOT_CUSTOM_en].G
    HealBot_AggroBarColb[9]=HealBot_Config.CDCBarColour[HEALBOT_CUSTOM_en].B
end

function HealBot_Action_SetHightlightAggroCols()
    HealBot_AggroBarColr[-1]=Healbot_Config_Skins.highcolr[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColg[-1]=Healbot_Config_Skins.highcolg[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColb[-1]=Healbot_Config_Skins.highcolb[Healbot_Config_Skins.Current_Skin]
end

function HealBot_Action_SetHightlightTargetAggroCols()
    HealBot_AggroBarColr[-2]=Healbot_Config_Skins.targetcolr[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColg[-2]=Healbot_Config_Skins.targetcolg[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColb[-2]=Healbot_Config_Skins.targetcolb[Healbot_Config_Skins.Current_Skin]
end

function HealBot_Action_SetAggroCols()
    HealBot_AggroBarColr[1]=Healbot_Config_Skins.AggroCol1r[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColg[1]=Healbot_Config_Skins.AggroCol1g[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColb[1]=Healbot_Config_Skins.AggroCol1b[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColr[2]=Healbot_Config_Skins.AggroCol2r[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColg[2]=Healbot_Config_Skins.AggroCol2g[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColb[2]=Healbot_Config_Skins.AggroCol2b[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColr[3]=Healbot_Config_Skins.AggroCol3r[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColg[3]=Healbot_Config_Skins.AggroCol3g[Healbot_Config_Skins.Current_Skin]
    HealBot_AggroBarColb[3]=Healbot_Config_Skins.AggroCol3b[Healbot_Config_Skins.Current_Skin]
end

function HealBot_Action_setTestBar(b)
    HealBot_UnitBarUpdate[b]=0
    HealBot_curUnitHealth[b]=100
end

local lTimer,eTimer=0,GetTime()
function HealBot_Action_OnUpdate(self)
    lTimer=GetTime()-eTimer
    eTimer=GetTime()
    HealBot_Action_Timer1 = HealBot_Action_Timer1+lTimer
    HealBot_Action_Timer2 = HealBot_Action_Timer2+lTimer
    if HealBot_Action_Timer1>HB_Action_Timer1 then
        HealBot_Action_Timer1 = 0
        for ebubar,value in pairs(HealBot_UnitBarUpdate) do 
            if value>HealBot_curUnitHealth[ebubar] then
                if value-Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Current_Skin]<=HealBot_curUnitHealth[ebubar] then
                    HealBot_UnitBarUpdate[ebubar]=HealBot_curUnitHealth[ebubar]
                else
                    HealBot_UnitBarUpdate[ebubar]=value-Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Current_Skin]
                end
            elseif value+Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Current_Skin]>=HealBot_curUnitHealth[ebubar] then
                HealBot_UnitBarUpdate[ebubar]=HealBot_curUnitHealth[ebubar]
            else
                HealBot_UnitBarUpdate[ebubar]=value+Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Current_Skin]
            end
            ebubar:SetValue(HealBot_UnitBarUpdate[ebubar])
            if HealBot_UnitBarUpdate[ebubar]==HealBot_curUnitHealth[ebubar] then
                HealBot_UnitBarUpdate[ebubar]=nil
            end
        end
    end
    if HealBot_Action_Timer2>HB_Action_Timer2 then
        HealBot_Action_Timer2 = 0
        for xGUID,bar4 in pairs(HealBot_AggroBar4) do
            HealBot_AggroUnitThreat=HealBot_UnitThreat[xGUID] or 2
            if HealBot_AggroUnitThreat==9 and HealBot_UnitDebuff[xGUID] and HealBot_Config.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]] then
                bar4:SetStatusBarColor(HealBot_Config.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].R,
                                       HealBot_Config.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].G,
                                       HealBot_Config.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].B,HealBot_AggroBarA)
            else
                bar4:SetStatusBarColor(HealBot_AggroBarColr[HealBot_AggroUnitThreat],HealBot_AggroBarColg[HealBot_AggroUnitThreat],HealBot_AggroBarColb[HealBot_AggroUnitThreat],HealBot_AggroBarA)
            end
        end
        if HealBot_AggroBarAup then
            if HealBot_AggroBarA>=Healbot_Config_Skins.AggroBarsMaxAlpha[Healbot_Config_Skins.Current_Skin] then
                HealBot_AggroBarAup=false
                HealBot_AggroBarA=HealBot_AggroBarA-0.05
            else
                HealBot_AggroBarA=HealBot_AggroBarA+0.05
            end
        else
            if HealBot_AggroBarA<=Healbot_Config_Skins.AggroBarsMinAlpha[Healbot_Config_Skins.Current_Skin] then
                HealBot_AggroBarAup=true
                HealBot_AggroBarA=HealBot_AggroBarA+0.05
            else
                HealBot_AggroBarA=HealBot_AggroBarA-0.05
            end
        end
    end
end

function HealBot_Action_OnShow(self)
    if Healbot_Config_Skins.PanelSounds[Healbot_Config_Skins.Current_Skin]==1 then
        PlaySound("igAbilityOpen");
    end
    HealBot_Config.ActionVisible = 1
    HealBot_Action:SetBackdropColor(
    Healbot_Config_Skins.backcolr[Healbot_Config_Skins.Current_Skin],
    Healbot_Config_Skins.backcolg[Healbot_Config_Skins.Current_Skin],
    Healbot_Config_Skins.backcolb[Healbot_Config_Skins.Current_Skin], 
    Healbot_Config_Skins.backcola[Healbot_Config_Skins.Current_Skin]);
    HealBot_Action:SetBackdropBorderColor(
    Healbot_Config_Skins.borcolr[Healbot_Config_Skins.Current_Skin],
    Healbot_Config_Skins.borcolg[Healbot_Config_Skins.Current_Skin],
    Healbot_Config_Skins.borcolb[Healbot_Config_Skins.Current_Skin],
    Healbot_Config_Skins.borcola[Healbot_Config_Skins.Current_Skin]);
end

function HealBot_Action_OnHide(self)
    HealBot_StopMoving(self,true);
    HealBot_Config.ActionVisible = 0
end

function HealBot_Action_OnMouseDown(self,button)
    if button=="LeftButton" then
        if Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Current_Skin]==0 or (IsControlKeyDown() and IsAltKeyDown()) then
            HealBot_FrameMoving=true
            HealBot_StartMoving(self);
        end
    end
end

function HealBot_Action_OnMouseUp(self,button)
    if button=="LeftButton" then
        HealBot_StopMoving(self,true);
        HealBot_FrameMoving=nil
    elseif button=="RightButton" and not HealBot_IsFighting and HealBot_Config.RightButtonOptions~=0 then
        HealBot_Action_OptionsButton_OnClick();
    end
end

function HealBot_Action_OnDragStart(self)
    if Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Current_Skin]==0 then
        HealBot_FrameMoving=true
        HealBot_StartMoving(self);
    end
end

function HealBot_Action_OnDragStop(self)
 --   HealBot_StopMoving(self,true);
    HealBot_FrameMoving=nil
end

local usedSmartCast=nil
local ModKey=nil
local abutton=nil
local aj=nil
function HealBot_Action_PreClick(self,button)
    if self.id<100 then
        HealBot_UpdTargetUnitID(self.unit)
        xGUID=HealBot_UnitGUID(self.unit)
        usedSmartCast=false;
        ModKey=""
        if IsShiftKeyDown() then 
            if IsControlKeyDown() then 
                ModKey="Ctrl-Shift"
            elseif IsAltKeyDown() then 
                ModKey="Alt-Shift"
            else
                ModKey="Shift" 
            end
        elseif IsControlKeyDown() then 
            ModKey="Ctrl"
        elseif IsAltKeyDown() then 
            ModKey="Alt"
        end
        if button=="LeftButton" then 
            abutton="Left"
            aj=1
        elseif button=="RightButton" then 
            abutton="Right"
            aj=2
        elseif button=="MiddleButton" then 
            abutton="Middle"
            aj=3
        else
            abutton=button
            aj=tonumber(strmatch(button, "(%d+)"))
        end
        if self.unit=="target" and Healbot_Config_Skins.TargetBarNormalMode[Healbot_Config_Skins.Current_Skin]==1 then
            if button=="RightButton" then
                if HealBot_UnitID[xGUID] then
                    HealBot_Panel_ToggelHealTarget(xGUID)
                    if HealBot_Config.ShowTooltip==1 then 
                        HealBot_Action_RefreshTargetTooltip(xGUID, self.unit) 
                    end
                end
            elseif button=="LeftButton" and HealBot_Config.SmartCast==1 and not IsModifierKeyDown() then
                HealBot_Action_UseSmartCast(self,xGUID)
            end
        elseif IsControlKeyDown() and IsAltKeyDown() and (button=="LeftButton" or button=="MiddleButton" or button=="RightButton") then
            if button=="LeftButton" then
                HealBot_Action_Toggle_Enabled(xGUID)
            elseif button=="RightButton" then
                HealBot_Panel_ToggelHealTarget(xGUID)
            elseif xGUID and xGUID~=HealBot_PlayerGUID and button=="MiddleButton" then
                HealBot_Panel_AddBlackList(xGUID)
            end
        elseif not HealBot_IsFighting then
            if UnitAffectingCombat(self.unit)==1 then 
                return
            end
            if HealBot_Config.ProtectPvP==1 then
                if UnitIsPVP(self.unit) and not UnitIsPVP("player") then 
                    HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"nil",aj)
                    usedSmartCast=true;
                end
            end
            if button=="LeftButton" and HealBot_Config.SmartCast==1 and not IsModifierKeyDown() then
                HealBot_Action_UseSmartCast(self,xGUID)
            end
            if not HealBot_Enabled[xGUID] and HealBot_Config.EnableHealthy==0 and not usedSmartCast then
                HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Disabled",aj)
                usedSmartCast=true;
            end
        end
    end
end

function HealBot_Action_Toggle_Enabled(hbGUID)
    if HealBot_MyTargets[hbGUID] then
        HealBot_MyTargets[hbGUID]=nil
    else
        HealBot_MyTargets[hbGUID]=true
    end
    if HealBot_UnitID[hbGUID] then HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID]) end
end

function HealBot_Action_UseSmartCast(bp,hbGUID)
    sName=HealBot_Action_SmartCast(hbGUID);
    if sName then
        sID=HealBot_GetSpellId(sName)
        if sID then
            if HealBot_UnitInRange(sName, bp.unit)==1 or hbGUID==HealBot_PlayerGUID then
                bp:SetAttribute("helpbutton1", "heal1");
                bp:SetAttribute("type-heal1", "spell");
                bp:SetAttribute("spell-heal1", sName);
            end
        else
            mId=GetMacroIndexByName(sName)
            if mId ~= 0 then
                _,_,mText=GetMacroInfo(mId)
     --        mUnit = bp.unit
                if UnitExists(HealBot_UnitPet(bp.unit)) then
                    mText=string.gsub(mText,"hbtargetpet",HealBot_UnitPet(bp.unit))
                end
                mText=string.gsub(mText,"hbtarget",bp.unit)
                mText=string.gsub(mText,"hbtargettarget",bp.unit.."target")
                mText=string.gsub(mText,"hbtargettargettarget",bp.unit.."targettarget")
                bp:SetAttribute("type1","macro")
                bp:SetAttribute("macrotext1", mText)
            else
                bp:SetAttribute("helpbutton1", "item1");
                bp:SetAttribute("type-item1", "item");
                bp:SetAttribute("item-item1", sName);
            end
        end
        usedSmartCast=true;
        HealBot_Check_WeaponBuffs(sName)
    end
end

function HealBot_Action_PostClick(self,button)
    if self.id==999 and not IsModifierKeyDown() then
        HealBot_Panel_clickToFocus("hide")
    elseif usedSmartCast then
        if self.unit=="target" then
            if aj==1 then
                self:SetAttribute(HB_prefix.."helpbutton"..aj, "target"..aj);
                self:SetAttribute(HB_prefix.."type"..aj, "target")
                self:SetAttribute(HB_prefix.."type-target"..aj, "target")
            end
        else
            HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Enabled",aj)
        end
    end
end

function HealBot_Action_RetMyTarget(hbGUID)
    return HealBot_MyTargets[hbGUID]
end

local scuHlth, scuMaxHlth, scuHealsIn = nil,nil,nil
function HealBot_Action_SmartCast(hbGUID)
    sName=nil
    rangeSpell=HealBot_hSpell
    if HealBot_PlayerDead or not HealBot_UnitID[hbGUID] then return nil; end
  
    if HealBot_Config.SmartCastRes==1 and UnitIsDead(HealBot_UnitID[hbGUID]) and not UnitIsGhost(HealBot_UnitID[hbGUID]) then
        sName=HealBot_Init_retSmartCast_Res();
        rangeSpell=HealBot_rSpell
    elseif HealBot_UnitDebuff[hbGUID] and HealBot_Config.SmartCastDebuff==1 then
        sName=HealBot_DebuffSpell[HealBot_UnitDebuff[hbGUID]["type"]];
        rangeSpell=HealBot_dSpell
    elseif HealBot_UnitBuff[hbGUID] and HealBot_Config.SmartCastBuff==1 then
        sName=HealBot_UnitBuff[hbGUID];
        rangeSpell=HealBot_bSpell
    elseif HealBot_Config.SmartCastHeal==1 then
        scuHealsIn = HealBot_IncHeals_retHealsIn(hbGUID);
        scuHlth, scuMaxHlth = HealBot_UnitHealth(hbGUID, HealBot_UnitID[hbGUID]);
        x = scuMaxHlth-(scuHlth+scuHealsIn);
        if x>200 then
            sName=HealBot_SmartCast(hbGUID,x)
        end
    end
    if sName and hbGUID~=HealBot_PlayerGUID then
        if HealBot_UnitInRange(rangeSpell, HealBot_UnitID[hbGUID])~=1 then return nil; end
    end
    return sName;
end

function HealBot_Action_RetHealBot_ClassCol(hbGUID, unit)
    return HealBot_Action_ClassColour(hbGUID, unit)
end

function HealBot_Action_immediateClearLocalArr(hbGUID)
    HealBot_Enabled[hbGUID]=nil
    HealBot_UnitOffline[hbGUID]=nil
    HealBot_UnitThreatPct[hbGUID]=nil
    UnitDebuffStatus[hbGUID]=nil
end

function HealBot_Action_ClearLocalArr(hbGUID)
    if HealBot_AggroBar4[hbGUID] then HealBot_AggroBar4[hbGUID]=nil end
    if HealBot_Aggro[hbGUID] then HealBot_Aggro[hbGUID]=nil end
    if HealBot_Hightlight[hbGUID] then HealBot_Hightlight[hbGUID]=nil end
end
