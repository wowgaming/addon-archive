local spellLeft = nil
local spellMiddle = nil
local spellRight = nil
local spellButton4 = nil
local spellButton5 = nil
local spellLeftShow = nil
local spellMiddleShow = nil
local spellRightShow = nil
local spellButton4Show = nil
local spellButton5Show = nil
local hlth, maxhlth, linenum = 1,2,1
local id=nil
local lspell=nil
local lspellrank=nil
local r=nil
local g=nil
local b=nil
local a=nil
local br=nil
local bg=nil
local bb=nil
local text=nil
local Heals=nil
local ri=nil
local DebuffType=nil
local uName=nil
local uBuff=nil
local spellLeftRecInstant=nil
local spellMiddleRecInstant=nil
local spellRightRecInstant=nil
local spellButton4RecInstant=nil
local spellButton5RecInstant=nil
local hlthdelta, tmpnum=0,0
local spellLeftTxt=nil
local spellLeftHeal=nil
local spellMiddleTxt=nil
local spellMiddleHeal=nil
local spellRightTxt=nil
local spellRightHeal=nil
local spellButton4Txt=nil
local spellButton4Heal=nil
local spellButton5Txt=nil
local spellButton5Heal=nil
local height = 20 
local width = 0
local txtL = nil
local txtR = nil
local ret_val, ret_heal = "  ", 0;
local linenum=1
local raidID=nil
local zone=nil;
local Instant_check=false
local top = nil
local x, y, z = nil,nil,nil
local HealBot_CheckBuffs = {}
local HealBot_Tooltip_DirtyLines={}
local mins,secs=0,0
local sName,sRank=nil,nil
local vUnit=nil
local xGUID=nil
local doTalentRequest={}

function HealBot_Tooltip_Clear_CheckBuffs()
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
    HealBot_Clear_CheckBuffs()
end

function HealBot_Tooltip_CheckBuffs(buff)
    HealBot_CheckBuffs[buff]=buff;
    HealBot_Set_CheckBuffs(buff)
    z=HealBot_AltBuffNames(buff)
    if z then 
        HealBot_CheckBuffs[z]=buff; 
        HealBot_Set_CheckBuffs(z)
    end
end

function HealBot_talentSpam(hbGUID,cmd,status)
    if cmd=="insert" then
        if not doTalentRequest[hbGUID] then doTalentRequest[hbGUID]=1 end
    elseif cmd=="remove" then
        doTalentRequest[hbGUID]=nil
    else
        if not doTalentRequest[hbGUID] then 
            doTalentRequest[hbGUID]=1 
        else
            doTalentRequest[hbGUID]=status
        end
    end
end

function HealBot_Tooltip_ReturnMinsSecs(s)
    mins=floor(s/60)
    secs=floor(s-(mins*60))
    if secs<10 then secs="0"..secs end
    return mins,secs
end

local UnitOffline=nil
function HealBot_Action_RefreshTooltip(unit, state)
    if HealBot_Config.ShowTooltip==0 then return end
    if not unit then return end;
    if HealBot_Config.DisableToolTipInCombat==1 and HealBot_IsFighting then return end
  
    uName=UnitName(unit);
    if (not uName) then return end;
    xGUID=HealBot_UnitGUID(unit)
    
    if unit=="target" and Healbot_Config_Skins.TargetBarNormalMode[Healbot_Config_Skins.Current_Skin]==1 then
        HealBot_Action_RefreshTargetTooltip(xGUID, unit)
        return
    end
  
    hlth,maxhlth=HealBot_UnitHealth(xGUID, unit)

    if hlth>maxhlth then
        maxhlth=HealBot_CorrectPetHealth(unit,hlth,maxhlth,xGUID)
    end
  
    UnitOffline=HealBot_Action_GetTimeOffline(xGUID); --added by Diacono
    uBuff=HealBot_UnitBuff[xGUID]
    if HealBot_UnitDebuff[xGUID] then
        DebuffType=HealBot_UnitDebuff[xGUID]["type"];
    else
        DebuffType=nil
    end

    spellLeft = HealBot_Action_SpellPattern("Left", state);
    spellMiddle = HealBot_Action_SpellPattern("Middle", state);
    spellRight = HealBot_Action_SpellPattern("Right", state);
    spellButton4 = HealBot_Action_SpellPattern("Button4", state);
    spellButton5 = HealBot_Action_SpellPattern("Button5", state);
    linenum = 1
    
    if spellLeft and strsub(strlower(spellLeft),1,4)==strlower(HEALBOT_TELL) then spellLeft=HEALBOT_TELL end
    if spellMiddle and strsub(strlower(spellMiddle),1,4)==strlower(HEALBOT_TELL) then spellMiddle=HEALBOT_TELL end
    if spellRight and strsub(strlower(spellRight),1,4)==strlower(HEALBOT_TELL) then spellRight=HEALBOT_TELL end
    if spellButton4 and strsub(strlower(spellButton4),1,4)==strlower(HEALBOT_TELL) then spellButton4=HEALBOT_TELL end
    if spellButton5 and strsub(strlower(spellButton5),1,4)==strlower(HEALBOT_TELL) then spellButton5=HEALBOT_TELL end

    spellLeftShow = spellLeft
    spellMiddleShow = spellMiddle
    spellRightShow = spellRight
    spellButton4Show = spellButton4
    spellButton5Show = spellButton5
  
    if not IsModifierKeyDown() and not HealBot_IsFighting and HealBot_Config.SmartCast==1 then 
        z=spellLeft;
        spellLeft=nil;
        spellLeft=HealBot_Action_SmartCast(xGUID);
        if not spellLeft then spellLeft=z; end;
    end
    if  spellLeft and strlower(spellLeft)~=strlower(HEALBOT_DISABLED_TARGET) and strlower(spellLeft)~=strlower(HEALBOT_ASSIST) 
    and strlower(spellLeft)~=strlower(HEALBOT_FOCUS) and strlower(spellLeft)~=strlower(HEALBOT_MENU) and strlower(spellLeft)~=strlower(HEALBOT_HBMENU) 
    and strlower(spellLeft)~=strlower(HEALBOT_MAINTANK) and strlower(spellLeft)~=strlower(HEALBOT_MAINASSIST) 
    and strlower(spellLeft)~=strlower(HEALBOT_STOP) and strsub(strlower(spellLeft),1,4)~=strlower(HEALBOT_TELL) then
        x=GetMacroIndexByName(spellLeft)
        if x==0 then spellLeft, spellLeftShow = HealBot_Tooltip_GetHealSpell(unit,spellLeft,uName) end
    end
    if  spellMiddle and strlower(spellMiddle)~=strlower(HEALBOT_DISABLED_TARGET) and strlower(spellMiddle)~=strlower(HEALBOT_ASSIST) 
    and strlower(spellMiddle)~=strlower(HEALBOT_FOCUS) and strlower(spellMiddle)~=strlower(HEALBOT_MENU) and strlower(spellMiddle)~=strlower(HEALBOT_HBMENU) 
    and strlower(spellMiddle)~=strlower(HEALBOT_MAINTANK) and strlower(spellMiddle)~=strlower(HEALBOT_MAINASSIST) 
    and strlower(spellMiddle)~=strlower(HEALBOT_STOP) and strsub(strlower(spellMiddle),1,4)~=strlower(HEALBOT_TELL) then
        x=GetMacroIndexByName(spellMiddle)
        if x==0 then spellMiddle, spellMiddleShow = HealBot_Tooltip_GetHealSpell(unit,spellMiddle,uName) end
    end
    if  spellRight and strlower(spellRight)~=strlower(HEALBOT_DISABLED_TARGET) and strlower(spellRight)~=strlower(HEALBOT_ASSIST) 
    and strlower(spellRight)~=strlower(HEALBOT_FOCUS) and strlower(spellRight)~=strlower(HEALBOT_MENU) and strlower(spellRight)~=strlower(HEALBOT_HBMENU) 
    and strlower(spellRight)~=strlower(HEALBOT_MAINTANK) and strlower(spellRight)~=strlower(HEALBOT_MAINASSIST) 
    and strlower(spellRight)~=strlower(HEALBOT_STOP) and strsub(strlower(spellRight),1,4)~=strlower(HEALBOT_TELL) then
        x=GetMacroIndexByName(spellRight)
        if x==0 then spellRight, spellRightShow = HealBot_Tooltip_GetHealSpell(unit,spellRight,uName) end
    end
    if  spellButton4 and strlower(spellButton4)~=strlower(HEALBOT_DISABLED_TARGET) and strlower(spellButton4)~=strlower(HEALBOT_ASSIST) 
    and strlower(spellButton4)~=strlower(HEALBOT_FOCUS) and strlower(spellButton4)~=strlower(HEALBOT_MENU) and strlower(spellButton4)~=strlower(HEALBOT_HBMENU)  
    and strlower(spellButton4)~=strlower(HEALBOT_MAINTANK) and strlower(spellButton4)~=strlower(HEALBOT_MAINASSIST) 
    and strlower(spellButton4)~=strlower(HEALBOT_STOP) and strsub(strlower(spellButton4),1,4)~=strlower(HEALBOT_TELL) then
        x=GetMacroIndexByName(spellButton4)
        if x==0 then spellButton4, spellButton4Show = HealBot_Tooltip_GetHealSpell(unit,spellButton4,uName) end
    end
    if  spellButton5 and strlower(spellButton5)~=strlower(HEALBOT_DISABLED_TARGET) and strlower(spellButton5)~=strlower(HEALBOT_ASSIST) 
    and strlower(spellButton5)~=strlower(HEALBOT_FOCUS) and strlower(spellButton5)~=strlower(HEALBOT_MENU) and strlower(spellButton5)~=strlower(HEALBOT_HBMENU) 
    and strlower(spellButton5)~=strlower(HEALBOT_MAINTANK) and strlower(spellButton5)~=strlower(HEALBOT_MAINASSIST) 
    and strlower(spellButton5)~=strlower(HEALBOT_STOP) and strsub(strlower(spellButton5),1,4)~=strlower(HEALBOT_TELL) then
        x=GetMacroIndexByName(spellButton5)
        if x==0 then spellButton5, spellButton5Show = HealBot_Tooltip_GetHealSpell(unit,spellButton5,uName) end
    end
  
    HealBot_Tooltip_ClearLines();
    
    if HealBot_Config.Tooltip_ShowTarget==1 then
        if uName then
            r,g,b=HealBot_Action_RetHealBot_ClassCol(xGUID, unit)
            if UnitClass(unit) then
                if not HealBot_InspectUnit and HealBot_UnitSpec[xGUID] and doTalentRequest[xGUID] and CanInspect(unit) and UnitIsPlayer(unit) and doTalentRequest[xGUID]==1 then
                    if HealBot_UnitSpec[xGUID]==" " or not HealBot_IsFighting then
                        HealBot_InspectUnit=true
                        HealBot_TalentQuery(unit)
                    end
                end
                text = HealBot_UnitSpec[xGUID] or " "
                HealBot_Tooltip_SetLineLeft(uName,r,g,b,linenum,1)
                HealBot_Tooltip_SetLineRight("Level "..UnitLevel(unit)..text..UnitClass(unit),r,g,b,linenum,1)         
            else 
                HealBot_Tooltip_SetLineLeft(uName,r,g,b,linenum,1)   
            end      
      
            zone=nil;
            if HealBot_PlayerName==uName or UnitIsVisible(unit) then
                zone=GetRealZoneText();
            elseif GetNumRaidMembers()>0 and unit~="target" then
                if strsub(unit,1,4)~="raid" then
                    if UnitInRaid(unit) then
                        for r=1,40 do
                            if UnitName("raid"..r)==uName then
                                raidID=r
                                _, _, _, _, _, _, zone, _, _ = GetRaidRosterInfo(raidID);
                                break
                            end
                        end
                    end
                elseif strsub(unit,1,7)~="raidpet" then
                    raidID=tonumber(strsub(unit,5))
                    _, _, _, _, _, _, zone, _, _ = GetRaidRosterInfo(raidID);
                end
            else
                HealBot_TooltipInit();
                HealBot_ScanTooltip:SetUnit(unit)
                zone = HealBot_ScanTooltipTextLeft3:GetText()
                if zone == "PvP" then
                    zone = HealBot_ScanTooltipTextLeft4:GetText()
                end
            end
            linenum=linenum+1
            if zone and not strfind(zone,"Level") then
                -- HealBot_Tooltip_SetLineLeft(HEALBOT_TOOLTIP_LOCATION..":",1,1,0.5,linenum,1);
                if UnitOffline then -- added by Diacono
                    HealBot_Tooltip_SetLineLeft(HB_TOOLTIP_OFFLINE..": "..UnitOffline,1,1,1,linenum,1)
                else
                    if zone==HB_TOOLTIP_OFFLINE then HealBot_Action_UnitIsOffline(xGUID,time()) end
                    HealBot_Tooltip_SetLineLeft(zone,1,1,1,linenum,1);
                end
            elseif UnitOffline then
                HealBot_Tooltip_SetLineLeft(HB_TOOLTIP_OFFLINE..": "..UnitOffline,1,1,1,linenum,1)
            end
            if hlth and maxhlth then
                hlthdelta=maxhlth-hlth;
                r,g,b,a=HealBot_HealthColor(unit,hlth,maxhlth,true,xGUID,false,uBuff,DebuffType,HealBot_IncHeals_retHealsIn(xGUID));
                HealBot_Tooltip_SetLineRight(hlth.."/"..maxhlth.." (-"..maxhlth-hlth..")",r,g,b,linenum,1)
                vUnit=HealBot_retIsInVehicle(unit)
                if vUnit then
                    linenum=linenum+1
                    r,g,b=HealBot_Action_RetHealBot_ClassCol(HealBot_UnitGUID(vUnit), vUnit)
                    if UnitExists(vUnit) then
                        HealBot_Tooltip_SetLineLeft("  "..UnitName(vUnit),r,g,b,linenum,1) 
                    else
                        HealBot_Tooltip_SetLineLeft("  "..HEALBOT_VEHICLE,r,g,b,linenum,1) 
                    end
                    hlth,maxhlth=HealBot_VehicleHealth(vUnit)
                    r,g,b,a=HealBot_HealthColor(vUnit,hlth,maxhlth,true,HealBot_UnitGUID(vUnit),false,uBuff,DebuffType,0);
                    HealBot_Tooltip_SetLineRight(hlth.."/"..maxhlth.." (-"..maxhlth-hlth..")",r,g,b,linenum,1)
                end
            end
            if DebuffType then
                linenum=linenum+1
                if HealBot_Config.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]] then
                    HealBot_Tooltip_SetLineLeft(uName.." suffers from "..HealBot_UnitDebuff[xGUID]["name"],
                                                HealBot_Config.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].R+0.2,
                                                HealBot_Config.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].G+0.2,
                                                HealBot_Config.CDCBarColour[HealBot_UnitDebuff[xGUID]["name"]].B+0.2,
                                                linenum,1)
                else
                    HealBot_Tooltip_SetLineLeft(uName.." suffers from "..HealBot_UnitDebuff[xGUID]["name"],
                                                HealBot_Config.CDCBarColour[DebuffType].R+0.2,
                                                HealBot_Config.CDCBarColour[DebuffType].G+0.2,
                                                HealBot_Config.CDCBarColour[DebuffType].B+0.2,
                                                linenum,1)
                end
                HealBot_Tooltip_SetLineRight(" ",0,0,0,linenum,0)
            end
            linenum=linenum+1
            if uBuff then
                linenum=linenum+1
                br,bg,bb=HealBot_Options_RetBuffRGB(uBuff)
                HealBot_Tooltip_SetLineLeft("  Requires "..uBuff,br,bg,bb,linenum,1)
                HealBot_Tooltip_SetLineRight(" ",0,0,0,linenum,0)
            end
            if HealBot_Config.Tooltip_ShowMyBuffs==1 then
                d=false
                for x,y in pairs(HealBot_CheckBuffs) do
                    z=HealBot_RetMyBuffTime(xGUID,x)
                    if z then
                        d=true
                        z=z-GetTime()
                        mins,secs=HealBot_Tooltip_ReturnMinsSecs(z)
                        linenum=linenum+1
                        br,bg,bb=HealBot_Options_RetBuffRGB(y)
                        if mins>0 then 
                            HealBot_Tooltip_SetLineLeft("    "..x.."  "..mins..":"..secs.." mins",br,bg,bb,linenum,1)
                            HealBot_Tooltip_SetLineRight(" ",0,0,0,linenum,0)
                        elseif tonumber(secs)>=0 and mins==0 then
                            HealBot_Tooltip_SetLineLeft("    "..x.."  "..secs.." secs",br,bg,bb,linenum,1)
                            HealBot_Tooltip_SetLineRight(" ",0,0,0,linenum,0)
                        else
                            linenum=linenum-1
                            HealBot_Queue_MyBuffsCheck(xGUID, unit)
                        end
                    end
                end
            end
            if d then linenum=linenum+1 end
            if HealBot_Config.ProtectPvP==1 and UnitIsPVP(unit) and not UnitIsPVP("player") then 
                HealBot_Tooltip_SetLineLeft("    ----- PVP -----",1,0.5,0.5,linenum,1);
                HealBot_Tooltip_SetLineRight("----- PVP -----    ",1,0.5,0.5,linenum,1);
                linenum=linenum+1;
            end
        end
    else
        HealBot_Tooltip_SetLineLeft(HEALBOT_OPTIONS_TAB_SPELLS,1,1,1,linenum,1)
        HealBot_Tooltip_SetLineRight(" ",0,0,0,linenum,0)
    end
  
    spellLeftRecInstant=false;
    spellMiddleRecInstant=false;
    spellRightRecInstant=false;
    spellButton4RecInstant=false;
    spellButton5RecInstant=false;
  
    if spellLeft=="" then spellLeft=nil; end
    if spellMiddle=="" then spellMiddle=nil; end
    if spellRight=="" then spellRight=nil; end
    if spellButton4=="" then spellButton4=nil; end
    if spellButton5=="" then spellButton5=nil; end
    
    if HealBot_Config.Tooltip_ShowSpellDetail==1 then

        if spellLeft then
            linenum=linenum+1
            HealBot_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONLEFT.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellLeftShow,1,1,0,linenum,1) 
            HealBot_Tooltip_SpellInfo(spellLeft);
            spellLeftRecInstant=HealBot_Tooltip_CheckForInstant(unit,spellLeft)
            linenum=linenum+1;
        end
        if spellMiddle then
            linenum=linenum+1;
            HealBot_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONMIDDLE.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellMiddleShow,1,1,0,linenum,1) 
            HealBot_Tooltip_SpellInfo(spellMiddle);
            spellMiddleRecInstant=HealBot_Tooltip_CheckForInstant(unit,spellMiddle)
            linenum=linenum+1;
        end
        if spellRight then
            linenum=linenum+1;
            HealBot_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONRIGHT.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellRightShow,1,1,0,linenum,1) 
            HealBot_Tooltip_SpellInfo(spellRight);
            spellRightRecInstant=HealBot_Tooltip_CheckForInstant(unit,spellRight)
            linenum=linenum+1;
        end
        if spellButton4 then
            linenum=linenum+1;
            HealBot_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTON4.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellButton4Show,1,1,0,linenum,1) 
            HealBot_Tooltip_SpellInfo(spellButton4);
            spellButton4RecInstant=HealBot_Tooltip_CheckForInstant(unit,spellButton4)
            linenum=linenum+1;
        end
        if spellButton5 then
            linenum=linenum+1;
            HealBot_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTON5.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..spellButton5Show,1,1,0,linenum,1) 
            HealBot_Tooltip_SpellInfo(spellButton5);
            spellButton5RecInstant=HealBot_Tooltip_CheckForInstant(unit,spellButton5);
            linenum=linenum+1;
        end
    else
        spellLeftTxt, spellLeftHeal="",0
        spellMiddleTxt, spellMiddleHeal="",0
        spellRightTxt, spellRightHeal="",0
        spellButton4Txt, spellButton4Heal="",0
        spellButton5Txt, spellButton5Heal="",0
        tmpnum=0;
        if spellLeft then 
            spellLeftTxt, spellLeftHeal=HealBot_Tooltip_SpellSummary(spellLeft);
            r,g,b,a,spellLeftRecInstant,spellLeftHeal=HealBot_Tooltip_SetQuickTipsColours(spellLeftHeal,hlthdelta,unit,spellLeft)
            linenum=linenum+1
            HealBot_Tooltip_SetLineRight(spellLeftTxt,r,g,b,linenum,a) 
            HealBot_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONLEFT..": "..spellLeftShow,1,1,0,linenum,a) 
        end
        if spellMiddle then
            spellMiddleTxt, spellMiddleHeal=HealBot_Tooltip_SpellSummary(spellMiddle);
            r,g,b,a,spellMiddleRecInstant,spellMiddleHeal=HealBot_Tooltip_SetQuickTipsColours(spellMiddleHeal,hlthdelta,unit,spellMiddle)
            linenum=linenum+1
            HealBot_Tooltip_SetLineRight(HealBot_Tooltip_SpellSummary(spellMiddle),r,g,b,linenum,a) 
            HealBot_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONMIDDLE..": "..spellMiddleShow,1,1,0,linenum,a) 
        end
        if spellRight then
            spellRightTxt, spellRightHeal=HealBot_Tooltip_SpellSummary(spellRight);
            r,g,b,a,spellRightRecInstant,spellRightHeal=HealBot_Tooltip_SetQuickTipsColours(spellRightHeal,hlthdelta,unit,spellRight)
            linenum=linenum+1
            HealBot_Tooltip_SetLineRight(HealBot_Tooltip_SpellSummary(spellRight),r,g,b,linenum,a) 
            HealBot_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTONRIGHT..": "..spellRightShow,1,1,0,linenum,a) 
        end
        if spellButton4 then
            spellButton4Txt, spellButton4Heal=HealBot_Tooltip_SpellSummary(spellButton4);
            r,g,b,a,spellButton4RecInstant,spellButton4Heal=HealBot_Tooltip_SetQuickTipsColours(spellButton4Heal,hlthdelta,unit,spellButton4)
            linenum=linenum+1
            HealBot_Tooltip_SetLineRight(HealBot_Tooltip_SpellSummary(spellButton4),r,g,b,linenum,a) 
            HealBot_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTON4..": "..spellButton4Show,1,1,0,linenum,a) 
        end
        if spellButton5 then
            spellButton5Txt, spellButton5Heal=HealBot_Tooltip_SpellSummary(spellButton5);
            r,g,b,a,spellButton5RecInstant,spellButton5Heal=HealBot_Tooltip_SetQuickTipsColours(spellButton5Heal,hlthdelta,unit,spellButton5)
            linenum=linenum+1
            HealBot_Tooltip_SetLineRight(HealBot_Tooltip_SpellSummary(spellButton5),r,g,b,linenum,a) 
            HealBot_Tooltip_SetLineLeft(HEALBOT_OPTIONS_BUTTON5..": "..spellButton5Show,1,1,0,linenum,a) 
        end
    end      
    if HealBot_Config.Tooltip_Recommend==1 then
        Instant_check=false;
        if HealBot_Config.Tooltip_ShowSpellDetail==0 then linenum=linenum+1; end
        linenum=linenum+1
        HealBot_Tooltip_SetLineLeft(HEALBOT_TOOLTIP_RECOMMENDTEXT,0.8,0.8,0,linenum,1) 
        if spellLeftRecInstant then
            linenum=linenum+1;
            HealBot_Tooltip_SetLineLeft("   "..HEALBOT_OPTIONS_BUTTONLEFT..":",1,1,0.2,linenum,1);
            HealBot_Tooltip_SetLineRight(spellLeftShow.."    ",1,1,1,linenum,1);
            Instant_check=true;
        end
        if spellMiddleRecInstant then
            linenum=linenum+1;
            HealBot_Tooltip_SetLineLeft("   "..HEALBOT_OPTIONS_BUTTONMIDDLE..":",1,1,0.2,linenum,1);
            HealBot_Tooltip_SetLineRight(spellMiddleShow.."    ",1,1,1,linenum,1);
            Instant_check=true;
        end
        if spellRightRecInstant then
            linenum=linenum+1;
            HealBot_Tooltip_SetLineLeft("   "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,linenum,1);
            HealBot_Tooltip_SetLineRight(spellRightShow.."    ",1,1,1,linenum,1);
            Instant_check=true;
        end
        if spellButton4RecInstant then
            linenum=linenum+1;
            HealBot_Tooltip_SetLineLeft("   "..HEALBOT_OPTIONS_BUTTON4..":",1,1,0.2,linenum,1);
            HealBot_Tooltip_SetLineRight(spellButton4Show.."    ",1,1,1,linenum,1);
            Instant_check=true;
        end
        if spellButton5RecInstant then
            linenum=linenum+1;
            HealBot_Tooltip_SetLineLeft("   "..HEALBOT_OPTIONS_BUTTON5..":",1,1,0.2,linenum,1);
            HealBot_Tooltip_SetLineRight(spellButton5Show.."    ",1,1,1,linenum,1);
            Instant_check=true;
        end
        if not Instant_check then
            linenum=linenum+1
            HealBot_Tooltip_SetLineLeft("  None",0.4,0.4,0.4,linenum,1) 
        end
    else
        if HealBot_Config.Tooltip_ShowSpellDetail==1 then linenum=linenum-1; end
    end
  
    HealBot_ToolTip_PreDefined(xGUID)
    HealBot_ToolTip_ShowHoT(xGUID)
  
    height = 20 
    width = 0
    for x = 1, linenum do
        txtL = _G["HealBot_TooltipTextL" .. x]
        txtR = _G["HealBot_TooltipTextR" .. x]
        height = height + txtL:GetHeight() + 2
        if (txtL:GetWidth() + txtR:GetWidth() + 25 > width) then
            width = txtL:GetWidth() + txtR:GetWidth() + 25
        end
    end
    HealBot_ToolTip_SetTooltipPos();
    HealBot_Tooltip:SetWidth(width)
    HealBot_Tooltip:SetHeight(height)
    HealBot_Tooltip:Show();
end

function HealBot_Tooltip_SpellInfo(spellName)
    text=nil
    if HealBot_Spells[spellName] then
        if HealBot_Spells[spellName].HealsDur>0 then
            linenum=linenum+1
            HealBot_Tooltip_SetLineLeft(HEALBOT_WORDS_CAST..": "..HealBot_Spells[spellName].CastTime.." "..HEALBOT_WORDS_SEC..".",0.8,0.8,0.8,linenum,1)
            HealBot_Tooltip_SetLineRight("Mana: "..HealBot_Spells[spellName].Mana,0.5,0.5,1,linenum,1) 
            if HealBot_Spells[spellName].HealsMax>0 then
                Heals = HEALBOT_HEAL.." "
                if HealBot_Spells[spellName].Shield then
                    Heals = HEALBOT_TOOLTIP_SHIELD.." "
                    text=Heals..format("%d", HealBot_Spells[spellName].HealsMax)
                else
                    if HealBot_Spells[spellName].HealsMin<HealBot_Spells[spellName].HealsMax then
                        text=Heals..format("%d", HealBot_Spells[spellName].HealsMin + HealBot_Spells[spellName].RealHealing) .." "..HEALBOT_WORDS_TO.." "..format("%d",HealBot_Spells[spellName].HealsMax + HealBot_Spells[spellName].RealHealing)
                    else
                        text=Heals..format("%d", HealBot_Spells[spellName].HealsMax + HealBot_Spells[spellName].RealHealing)
                    end
                end
                linenum=linenum+1
                HealBot_Tooltip_SetLineLeft(text,1,1,1,linenum,1)
            end
            if HealBot_Spells[spellName].HealsExt>0 then
                text=HEALBOT_HEAL.." "..HealBot_Spells[spellName].HealsDur.." "..HEALBOT_WORDS_OVER.." "..HealBot_Spells[spellName].Duration-HealBot_Spells[spellName].CastTime.." sec."
                linenum=linenum+1
                HealBot_Tooltip_SetLineLeft(text,1,1,1,linenum,1)
            end
            if not HealBot_Spells[spellName].Shield then
                text=HEALBOT_TOOLTIP_ITEMBONUS.." +"..GetSpellBonusHealing().." | "..HEALBOT_TOOLTIP_ACTUALBONUS.." +"..HealBot_Spells[spellName].RealHealing.." "
                linenum=linenum+1
                HealBot_Tooltip_SetLineLeft(text,0.8,0.8,0.8,linenum,1)
            end
        end
    elseif HealBot_OtherSpells[spellName] then
        linenum=linenum+1
        HealBot_Tooltip_SetLineLeft(HEALBOT_WORDS_CAST..": "..HealBot_OtherSpells[spellName].CastTime.." "..HEALBOT_WORDS_SEC..".",0.8,0.8,0.8,linenum,1) 
        HealBot_Tooltip_SetLineRight("Mana: "..HealBot_OtherSpells[spellName].Mana,0.5,0.5,1,linenum,1)    
    end
end

function HealBot_Tooltip_SpellSummary(spellName)
    ret_val, ret_heal = "  ", 0
    if HealBot_Spells[spellName] then
        if HealBot_Spells[spellName].HealsDur>0 then
            if HealBot_Spells[spellName].HealsMax>0 then
                Heals = " "..HEALBOT_HEAL.." "
                if HealBot_Spells[spellName].Shield then
                    Heals = " "..HEALBOT_TOOLTIP_SHIELD.." "
                    ret_heal=HealBot_Spells[spellName].HealsMax
                    ret_val=ret_val..Heals..format("%d", ret_heal)
                    ret_heal=0-ret_heal
                else
                    if HealBot_Spells[spellName].HealsMin<HealBot_Spells[spellName].HealsMax then
                        ret_heal=((HealBot_Spells[spellName].HealsMin+HealBot_Spells[spellName].HealsMax)/2) + HealBot_Spells[spellName].RealHealing
                    else
                        ret_heal=HealBot_Spells[spellName].HealsMax + HealBot_Spells[spellName].RealHealing
                    end
                    ret_val=ret_val..Heals..format("%d", ret_heal)
                end
            end
            if HealBot_Spells[spellName].HealsExt>0 then
                ret_heal=HealBot_Spells[spellName].HealsDur;
                ret_val=ret_val.." HoT "..format("%d", ret_heal);
                ret_heal=0-ret_heal;
            end
            -- ret_val=ret_val.." "..HEALBOT_WORDS_FOR.." "..HealBot_Spells[spellName].Mana.." Mana";
        end
    elseif HealBot_OtherSpells[spellName] then
        ret_val = " -  "..HealBot_OtherSpells[spellName].Mana.." Mana"
    else
        ret_heal=-1;
    end
    if strlen(ret_val)<5 then ret_val = " - "..spellName; end
    return ret_val,ret_heal;
end

function HealBot_Tooltip_CheckForInstant(unit,spellName)
    if HealBot_Spells[spellName] then
        if HealBot_Spells[spellName].Buff then
            if HealBot_HasUnitBuff(HealBot_Spells[spellName].Buff,unit,"player") then return false end;  
            return true;
        end
    end
    return false;
end

function HealBot_Tooltip_SetQuickTipsColours(healval,hlthdelta,unit,spellName)
    r,g,b,a,ri=0.5,0.5,1,1,false;
    ri=HealBot_Tooltip_CheckForInstant(unit,spellName)
    if healval==-1 then
        -- r, g, b=0.58,0.58,1;
    elseif healval>0 then
        if healval>hlthdelta then
            tmpnum=(healval-hlthdelta);
            a=(hlthdelta-tmpnum)/(hlthdelta+1);
        else
            a=((healval)/(hlthdelta+1))*1.35;
        end
    elseif healval==0 then
        -- r, g, b=0.8,1,0.2;
    else
        healval=0-healval;
        if (healval*.72)>hlthdelta then
            tmpnum=((healval)-hlthdelta);
            a=((hlthdelta-tmpnum)/(hlthdelta+1))*1.35;
        else
            a=(healval/(hlthdelta+1))*1.5;
        end
        if not ri then
            a=0.4
        end
    end
    if a<0.4 then 
        a=0.4;
    elseif a>1 then 
        a=1;
    end
    return r,g,b,a,ri,healval;
end

function HealBot_Action_RefreshTargetTooltip(hbGUID, unit)
    HealBot_TooltipInit();
    HealBot_Tooltip_ClearLines();
    linenum=1
    r,g,b=HealBot_Action_RetHealBot_ClassCol(hbGUID, unit)
    HealBot_Tooltip_SetLineLeft(HealBot_UnitName[hbGUID],r,g,b,linenum,1)
    if UnitClass(unit) then
        text = HealBot_UnitSpec[hbGUID] or " "
        HealBot_Tooltip_SetLineRight(" Level "..UnitLevel(unit)..text..UnitClass(unit),r,g,b,linenum,1);
    end
    linenum=linenum+1
    HealBot_Tooltip_SetLineLeft(HEALBOT_TOOLTIP_TARGETBAR,1,1,0.5,linenum,1);
    HealBot_Tooltip_SetLineRight(HEALBOT_OPTIONS_TAB_SPELLS.." "..HEALBOT_SKIN_DISTEXT,1,1,0.5,linenum,1);
    linenum=linenum+2
  
    if HealBot_Config.SmartCast==1 then
        HealBot_Tooltip_SetLineLeft(" "..HEALBOT_OPTIONS_BUTTONLEFT..":",1,1,0.2,linenum,1)
        HealBot_Tooltip_SetLineRight(HEALBOT_TITAN_SMARTCAST.." ",1,1,1,linenum,1);
    end
    if HealBot_UnitID[hbGUID] then
        linenum=linenum+1
        HealBot_Tooltip_SetLineLeft(" "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,linenum,1)
        if HealBot_Panel_RetMyHealTarget(hbGUID) then
            HealBot_Tooltip_SetLineRight(HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_TARGETHEALS.." ",1,1,1,linenum,1);
        else
            HealBot_Tooltip_SetLineRight(HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_TARGETHEALS.." ",1,1,1,linenum,1);
        end
    end
  
    height = 20 
    width = 0
    for x = 1, linenum do
        txtL = _G["HealBot_TooltipTextL" .. x]
        txtR = _G["HealBot_TooltipTextR" .. x]
        height = height + txtL:GetHeight() + 2
        if (txtL:GetWidth() + txtR:GetWidth() + 25 > width) then
            width = txtL:GetWidth() + txtR:GetWidth() + 25
        end
    end
    HealBot_ToolTip_SetTooltipPos();
    HealBot_Tooltip:SetWidth(width)
    HealBot_Tooltip:SetHeight(height)
    HealBot_Tooltip:Show();
end

function HealBot_ToolTip_PreDefined(hbGUID)
    if HealBot_Config.Tooltip_PreDefined==1 then
        linenum=linenum+2
        HealBot_Tooltip_SetLineLeft("   "..HEALBOT_OPTIONS_CTRL.."+"..HEALBOT_OPTIONS_ALT.."+"..HEALBOT_OPTIONS_BUTTONLEFT..":",1,1,0.2,linenum,1)
        if HealBot_Action_RetMyTarget(hbGUID) then
            HealBot_Tooltip_SetLineRight(HEALBOT_SKIN_DISTEXT.."    ",1,1,1,linenum,1)
        else
            HealBot_Tooltip_SetLineRight(HEALBOT_SKIN_ENTEXT.."    ",1,1,1,linenum,1)
        end
  
        linenum=linenum+1
        HealBot_Tooltip_SetLineLeft("   "..HEALBOT_OPTIONS_CTRL.."+"..HEALBOT_OPTIONS_ALT.."+"..HEALBOT_OPTIONS_BUTTONMIDDLE..":",1,1,0.2,linenum,1)
        HealBot_Tooltip_SetLineRight(HEALBOT_PANEL_BLACKLIST.."    ",1,1,1,linenum,1)

        linenum=linenum+1
        HealBot_Tooltip_SetLineLeft("   "..HEALBOT_OPTIONS_CTRL.."+"..HEALBOT_OPTIONS_ALT.."+"..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,linenum,1)
        if HealBot_Panel_RetMyHealTarget(hbGUID) then
            HealBot_Tooltip_SetLineRight(HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_TARGETHEALS.."    ",1,1,1,linenum,1)
        else
            HealBot_Tooltip_SetLineRight(HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_TARGETHEALS.."    ",1,1,1,linenum,1)
        end
    end

end

local hbTTHoTinfo1=nil
local hbTTHoTinfo2=nil
local ttCaster=nil
local ttHoT=nil
local ttHoTd=nil
local ttHoTdt=nil
local ttHoTc=nil
local ttHoTright=nil
local hbHoTline1=nil
function HealBot_ToolTip_ShowHoT(hbGUID)
    if HealBot_Config.Tooltip_ShowHoT==1 then
        hbHoTline1=true
        hbTTHoTinfo1, hbTTHoTinfo2=HealBot_retHoTdetails(hbGUID)
        if hbTTHoTinfo1 then
            for x,y in pairs(hbTTHoTinfo1) do
                if y>0 and y<15 and linenum<44 then
                    xGUID,ttHoT=string.split("!", x)
                    ttCaster=HealBot_UnitName[xGUID] or HEALBOT_WORDS_UNKNOWN
                    if hbHoTline1 then
                        hbHoTline1=nil
                        linenum=linenum+1
                    end
                    linenum=linenum+1
                    HealBot_Tooltip_SetLineLeft("   "..ttCaster.." "..strlower(HEALBOT_WORDS_CAST).." "..ttHoT.." ",0.4,1,1,linenum,1)
                    if hbTTHoTinfo2[x] then
                        ttHoTd=floor(hbTTHoTinfo2[x]-GetTime())
                    else
                        ttHoTd=nil
                    end
                    ttHoTc=HealBot_retHoTcount(x,hbGUID)
                    ttHoTright=nil
                    if ttHoTd and ttHoTd>60 then
                        ttHoTdt=floor(ttHoTd/60)
                        if ttHoTdt>120 then
                            ttHoTd=nil
                        else
                            ttHoTd=ttHoTd - (ttHoTdt*60)
                            if ttHoTd<10 then ttHoTd="0"..ttHoTd end
                            ttHoTd=ttHoTdt.."m "..ttHoTd
                        end
                    end
                    if ttHoTd then 
                        ttHoTright=" "..HEALBOT_OPTIONS_HOTTEXTDURATION..": "..ttHoTd.."s   " 
                    else
                        ttHoTright=" "
                    end
                    if ttHoTc then 
                        ttHoTright=ttHoTright..HEALBOT_OPTIONS_HOTTEXTCOUNT..": "..ttHoTc.."   " 
                    else
                        ttHoTright=ttHoTright.."   " 
                    end
                    if ttHoTright then HealBot_Tooltip_SetLineRight(ttHoTright,0.7,1,0.7,linenum,1) end
                end
            end
        end
    end
end

function HealBot_ToolTip_SetTooltipPos()
    HealBot_Tooltip:ClearAllPoints();
    if HealBot_Config.TooltipPos>1 then
        top = HealBot_Action:GetTop();
        x, y = GetCursorPosition();
        x=x/UIParent:GetScale();
        y=y/UIParent:GetScale();
        if HealBot_Config.TooltipPos==2 then
            HealBot_Tooltip:SetPoint("TOPRIGHT","HealBot_Action","TOPLEFT",0,0-(top-(y+35)));
        elseif HealBot_Config.TooltipPos==3 then
            HealBot_Tooltip:SetPoint("TOPLEFT","HealBot_Action","TOPRIGHT",0,0-(top-(y+35)));
        elseif HealBot_Config.TooltipPos==4 then
            HealBot_Tooltip:SetPoint("BOTTOM","HealBot_Action","TOP",0,0);
        elseif HealBot_Config.TooltipPos==5 then
            HealBot_Tooltip:SetPoint("TOP","HealBot_Action","BOTTOM",0,0);
        else
            HealBot_Tooltip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",x+25,y-20);
        end
    else
        HealBot_Tooltip:SetPoint("BOTTOMRIGHT","WorldFrame","BOTTOMRIGHT",-105,105);
    end
end

function HealBot_Tooltip_SetLineLeft(Text,R,G,B,lNo,a)
    if lNo>40 then return end
    txtL = _G["HealBot_TooltipTextL" .. lNo]
    txtL:SetTextColor(R,G,B,a)
    txtL:SetText(Text)
    txtL:Show()
    HealBot_Tooltip_DirtyLines[lNo]=true
end

function HealBot_Tooltip_SetLineRight(Text,R,G,B,lNo,a)
    if lNo>40 then return end
    txtR = _G["HealBot_TooltipTextR" .. lNo]
    txtR:SetTextColor(R,G,B,a)
    txtR:SetText(Text)
    txtR:Show()
    HealBot_Tooltip_DirtyLines[lNo]=true
end

function HealBot_Tooltip_ClearLines()
    for x,_ in pairs(HealBot_Tooltip_DirtyLines) do
        txtR = _G["HealBot_TooltipTextR" .. x]
        txtR:SetText(" ")
        txtL = _G["HealBot_TooltipTextL" .. x]
        txtL:SetText(" ")
        HealBot_Tooltip_DirtyLines[x]=nil
    end
end

local timeOffline,uOffline = nil,nil
local hours, minutes, seconds
function HealBot_Action_GetTimeOffline(hbGUID)
    uOffline=HealBot_Action_retUnitOffline(hbGUID)
    timeOffline=nil
    if uOffline then
        timeOffline = time() - uOffline;
        seconds = timeOffline % 60;
        minutes = math.floor(timeOffline / 60) % 60
        hours = math.floor(timeOffline / 3600)
        timeOffline = "";
        if hours > 0 then
            if hours == 1 then
                timeOffline = hours.." hour ";
            else
                timeOffline = hours.." hours ";
            end
        end
        if minutes > 0 then
            if minutes == 1 then
                timeOffline = timeOffline..minutes.." min ";
            else
                timeOffline = timeOffline..minutes.." mins ";
            end
        end
        if seconds > 0 then
            if seconds == 1 then
                timeOffline = timeOffline..seconds.." sec";
            else
                timeOffline = timeOffline..seconds.." secs";
            end
        end                        
    end      
    return timeOffline;
end

function HealBot_Tooltip_GetHealSpell(unit,pattern,unitName)
 
    if not HealBot_Spells[pattern] then
        id = HealBot_GetSpellId(pattern);
    elseif HealBot_Spells[pattern].id then
        id = HealBot_Spells[pattern].id
    else
        id = HealBot_GetSpellId(pattern);
    end
    sName, sRank = HealBot_GetSpellName(id)
    if not sName then 
        if pattern then
            if unitName~=HealBot_PlayerName then
                if IsItemInRange(pattern,unit)~=1 then
                    return nil
                else
                    return pattern,pattern;
                end
            else
                w, _ = IsUsableItem(pattern, unit)
                if not w then 
                    return nil
                else
                    return pattern,pattern;
                end
            end
        else
            return nil
        end
    end

    if sRank then
        sNameRank=sName .. "(" .. sRank .. ")";
    else
        sNameRank=sName
    end
  
    if HealBot_UnitInRange(sName, unit)~=1 then return nil end;
 
    return sNameRank, sName;
end
