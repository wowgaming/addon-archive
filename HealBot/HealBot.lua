--[[

  HealBot Contined
    
]]

local HealBot_NeedEquipUpdate=0;
local HealBot_IamRessing = nil;
local HealBot_RequestVer=nil;
local HealBot_BarCheck = {};
local HealBot_Loaded=nil;
local HealBot_IamHealing = nil;
local HealBot_HealData = {};
local HealBot_initHealData = {};
local HealBot_Talents={}
local HealBot_CheckTalents=false
local HealBot_Player_HoT={};
local HealBot_Player_HoT_Icons={};
local HealBot_Watch_HoT={};
local HealBot_HoT_Count={};
local HealBot_HoTincHeals={}
local HealBot_HoTincData={}
local HealBot_InCombatUpdate=false
local HealBot_SmartCast_Spells={};
local HealBot_AddonMsgType=3;
local HealBot_HoT_Texture={};
local HealBot_SpamCnt=0;
local HealBot_Ressing = {};
local HealBot_DelayBuffCheck = {};
local HealBot_DelayDebuffCheck = {};
local HealBot_DelayAuraCheck = {};
local HealBot_HealsIncEndTime={}
local HealBot_Vers={}
local HealBot_CTRATanks={};
local HealBot_MainTanks={};
local HealBot_MainAssists={};
local HealBot_CastingTarget = "player";
local i=nil
local w=nil
local x=nil
local y=nil
local z=nil
local strfind=strfind
local strsub=strsub
local gsub=gsub
local HealBot_ThrottleCnt=5
local HealBot_Aggro1={}
local HealBot_Aggro2={}
local HealBot_AggroS=1
local HealBot_Reset_flag=nil
local HB_Timer1=0.5
local HB_Timer2=0.3
local HB_Timer3=0.2
local HealBot_UpUnitInCombat={}
local HealBot_InCombatUpdCnt=0
local HealBot_InCombatUpdCntFlag=nil
local k=nil
local s=nil
local HealBot_Buff_Spells_List ={}
local HealBot_BuffNameSwap = {}            
local HealBot_VehicleCheck={};   
local HealBot_ReCheckBuffsTime=nil
local HealBot_ReCheckBuffsTimed={}
local HealBot_cleanGUIDs={}
local initIncHeals=true
local HealBot_Ignore_Class_Debuffs = {
    ["WARR"] = { [HEALBOT_DEBUFF_ANCIENT_HYSTERIA] = true,    
                          [HEALBOT_DEBUFF_IGNITE_MANA] = true, 
                          [HEALBOT_DEBUFF_TAINTED_MIND] = true, 
                          [HEALBOT_DEBUFF_VIPER_STING] = true,
                          [HEALBOT_DEBUFF_IMPOTENCE] = true,
                          [HEALBOT_DEBUFF_DECAYED_INT] = true,
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["ROGU"] = {   [HEALBOT_DEBUFF_SILENCE] = true,    
                          [HEALBOT_DEBUFF_ANCIENT_HYSTERIA] = true, 
                          [HEALBOT_DEBUFF_IGNITE_MANA] = true, 
                          [HEALBOT_DEBUFF_TAINTED_MIND] = true, 
                          [HEALBOT_DEBUFF_VIPER_STING] = true,
                          [HEALBOT_DEBUFF_IMPOTENCE] = true,
                          [HEALBOT_DEBUFF_DECAYED_INT] = true,
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["HUNT"] = {  [HEALBOT_DEBUFF_MAGMA_SHACKLES] = true, 
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["MAGE"] = {    [HEALBOT_DEBUFF_MAGMA_SHACKLES] = true, 
                          [HEALBOT_DEBUFF_DECAYED_STR] = true,
                          [HEALBOT_DEBUFF_CRIPPLE] = true,
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["DRUI"] = {   [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["PALA"] = { [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["PRIE"] = {  [HEALBOT_DEBUFF_DECAYED_STR] = true,
                          [HEALBOT_DEBUFF_CRIPPLE] = true,
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["SHAM"] = {  [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["WARL"] = { [HEALBOT_DEBUFF_DECAYED_STR] = true,
                          [HEALBOT_DEBUFF_CRIPPLE] = true,
                          [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
    ["DEAT"] = { [HEALBOT_DEBUFF_UNSTABLE_AFFL] = true,},
};

local HealBot_Ignore_Movement_Debuffs = {
                                  [HEALBOT_DEBUFF_FROSTBOLT] = true,
                                  [HEALBOT_DEBUFF_MAGMA_SHACKLES] = true,
                                  [HEALBOT_DEBUFF_SLOW] = true,
                                  [HEALBOT_DEBUFF_CHILLED] = true,
                                  [HEALBOT_DEBUFF_CONEOFCOLD] = true,
                                  [HEALBOT_DEBUFF_CONCUSSIVESHOT] = true,
                                  [HEALBOT_DEBUFF_THUNDERCLAP] = true,
                                  [HEALBOT_DEBUFF_HOWLINGSCREECH] = true,
                                  [HEALBOT_DEBUFF_DAZED] = true,
                                  [HEALBOT_DEBUFF_FROST_SHOCK] = true,
};

local HealBot_Ignore_NonHarmful_Debuffs = {
                                  [HEALBOT_DEBUFF_HUNTERS_MARK] = true,
                                  [HEALBOT_DEBUFF_ARCANE_BLAST] = true,
                                  [HEALBOT_DEBUFF_MAJOR_DREAMLESS] = true,
                                  [HEALBOT_DEBUFF_GREATER_DREAMLESS] = true,
                                  [HEALBOT_DEBUFF_DREAMLESS_SLEEP] = true,
};

local HealBot_Timer1,HealBot_Timer2,HealBot_Timer3 = 0,0,0;
local Ti=nil
local inc_msg=nil
local datatype=nil
local datamsg=nil
local sender=nil
local arr=nil
local arrg = {}
local HoTActive=nil
local DebuffType=nil
local checkthis=nil
local WatchTarget=nil
local WatchGUID=nil
local debuff_type=nil
local dName=nil
local HealBot_Ignore_Debuffs_Class=nil
local bName=nil
local PlayerBuffs = {}
local HealBot_dSpell=HEALBOT_HEAVY_RUNECLOTH_BANDAGE
local bar=nil
local iconName=nil
local id=0
local sName=nil
local sRank=nil
local sNameRank=nil
local uName=nil
local xUnit=nil
local xGUID = nil
local utGUID=nil
local uClass=nil
local QuickHealth = LibStub("LibQuickHealth-2.0")
local LSM = LibStub("LibSharedMedia-3.0")
local TalentQuery = LibStub:GetLibrary("LibTalentQuery-1.0")
local HealBot_PlayerBuff={}
local HealBot_CheckBuffs = {}
local HealBot_ShortBuffs = {}
local HealBot_CheckBuffsTime=nil
local HealBot_CheckBuffsTimehbGUID=nil
local HealBot_QueueCheckBuffs={}
local PlayerBuffsGUID=nil
local huUnit,huHoTtime,huHoTicon=nil,nil,nil
local HealBot_TrackWS={}
local HealBot_BuffWatch={}
local HealBot_DeBuff_Texture={}
local iTexture, bCount, expirationTime, caster, spellID=nil,nil,nil,nil,nil
local DeBuff_Count={}
local HealBot_unitHealth={}
local HealBot_unitHealthMax={}
local BuffClass=nil
local HasWeaponBuff=false
local CheckWeaponBuffs={[HEALBOT_ROCKBITER_WEAPON]=true, 
                        [HEALBOT_FLAMETONGUE_WEAPON]=true, 
                        [HEALBOT_EARTHLIVING_WEAPON]=true, 
                        [HEALBOT_WINDFURY_WEAPON]=true,
                        [HEALBOT_FROSTBRAND_WEAPON]=true,}
local CooldownBuffs={[HEALBOT_FEAR_WARD]=true, 
                     [HEALBOT_PAIN_SUPPRESSION]=true, 
                     [HEALBOT_POWER_INFUSION]=true,
                     [HEALBOT_DIVINE_PLEA]=true,
                     [HEALBOT_DIVINE_FAVOR]=true,
                     [HEALBOT_DIVINE_ILLUMINATION]=true,}
local debuffCodes={ [HEALBOT_DISEASE_en]=5, [HEALBOT_MAGIC_en]=6, [HEALBOT_POISON_en]=7, [HEALBOT_CURSE_en]=8, [HEALBOT_CUSTOM_en]=9}
local HealBot_VehicleUnit={}
local HealBot_UnitInVehicle={}
local hGUID=nil
local hUnit=nil
local vGUID=nil
local vUnit=nil
local tGUID=nil
local HBvUnits=nil
local HealBot_TargetIcons={}
local HealBot_PetGUID={}
local HealBot_HelpCnt=nil
local HealBot_debuffTargetIcon={}
local hotName=nil
local HealBot_luVars={}
local HealBot_endAggro={}

function HealBot_UpdTargetUnitID(unit)
    HealBot_luVars["TargetUnitID"]=unit
end

function HealBot_Check_WeaponBuffs(spellName)
    if CheckWeaponBuffs[spellName] then
        HealBot_luVars["WeaponBuffCheck"]=3
    end
end

function HealBot_Clear_BuffWatch()
    for x,_ in pairs(HealBot_BuffWatch) do
        HealBot_BuffWatch[x]=nil;
    end
end

function HealBot_Set_BuffWatch(buffName)
    table.insert(HealBot_BuffWatch,buffName);
end

function HealBot_Clear_CheckBuffs()
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
end

function HealBot_Set_CheckBuffs(buffName)
    if not CheckWeaponBuffs[buffName] and not CooldownBuffs[buffName] then
        HealBot_CheckBuffs[buffName]=buffName;
    end
end

function HealBot_Set_debuffSpell(debuffName)
    HealBot_dSpell=debuffName
end

function HealBot_Queue_MyBuffsCheck(hbGUID,unit)
    HealBot_QueueCheckBuffs[hbGUID]=unit
end

function HealBot_Queue_AllActiveMyBuffs()
    for z,y in pairs(HealBot_UnitID) do
        HealBot_Queue_MyBuffsCheck(z,y)
    end
end

function HealBot_RetMyBuffTime(hbGUID,buffName)
    if not HealBot_PlayerBuff[hbGUID] or not HealBot_PlayerBuff[hbGUID][buffName] then return end
    if HealBot_ShortBuffs[buffName] then
        return HealBot_PlayerBuff[hbGUID][buffName]+HealBot_Config.ShortBuffTimer
    else
        return HealBot_PlayerBuff[hbGUID][buffName]+HealBot_Config.LongBuffTimer
    end
end

function HealBot_retHealBot_MainTanks()
    return HealBot_MainTanks
end

function HealBot_retHealBot_CTRATanks()
    return HealBot_CTRATanks
end

function HealBot_retHealBot_MainAssists()
    return HealBot_MainAssists
end

function HealBot_retHealBot_UseCrashProtection()
    return HealBot_luVars["UseCrashProtection"]
end

function HealBot_cpQueue(id, mName, mBody)
    HealBot_luVars["cpMacro"]=GetTime()+8
    if id==0 then
        HealBot_luVars["cpSave0"]=true
        HealBot_luVars["cpName0"]=mName
        HealBot_luVars["cpBody0"]=mBody
    elseif id==1 then
        HealBot_luVars["cpSave1"]=true
        HealBot_luVars["cpName1"]=mName
        HealBot_luVars["cpBody1"]=mBody
    elseif id==2 then
        HealBot_luVars["cpSave2"]=true
        HealBot_luVars["cpName2"]=mName
        HealBot_luVars["cpBody2"]=mBody
    elseif id==3 then
        HealBot_luVars["cpSave3"]=true
        HealBot_luVars["cpName3"]=mName
        HealBot_luVars["cpBody3"]=mBody
    else
        HealBot_luVars["cpSave4"]=true
        HealBot_luVars["cpName4"]=mName
        HealBot_luVars["cpBody4"]=mBody
    end
end

function HealBot_cpSaveAll()
    HealBot_luVars["cpMacro"]=nil
    if HealBot_luVars["cpSave0"] then
        HealBot_luVars["cpSave0"]=nil
        HealBot_cpSave(HealBot_luVars["cpName0"], HealBot_luVars["cpBody0"])
    end
    if HealBot_luVars["cpSave1"] then
        HealBot_luVars["cpSave1"]=nil
        HealBot_cpSave(HealBot_luVars["cpName1"], HealBot_luVars["cpBody1"])
    end
    if HealBot_luVars["cpSave2"] then
        HealBot_luVars["cpSave2"]=nil
        HealBot_cpSave(HealBot_luVars["cpName2"], HealBot_luVars["cpBody2"])
    end
    if HealBot_luVars["cpSave3"] then
        HealBot_luVars["cpSave3"]=nil
        HealBot_cpSave(HealBot_luVars["cpName3"], HealBot_luVars["cpBody3"])
    end
    if HealBot_luVars["cpSave4"] then
        HealBot_luVars["cpSave4"]=nil
        HealBot_cpSave(HealBot_luVars["cpName4"], HealBot_luVars["cpBody4"])
    end
    HBmsg=HEALBOT_CP_MACRO_SAVE.."   "..date("%H:%M:%S", time())
    HealBot_Options_cpMacroSave:SetText(HBmsg)
end

function HealBot_cpSave(mName, mBody)
    z=GetMacroIndexByName(mName)
    if (z or 0) == 0 then
        z = CreateMacro(mName, 12, mBody, 1)
    else
        z = EditMacro(z, mName, 12, mBody)
    end
end

function HealBot_SetResetFlag(mode)
    if mode=="HARD" then
        ReloadUI()
    else
        HealBot_Reset_flag=1
    end
end

function HealBot_AltBuffNames(buffName)
    return HealBot_BuffNameSwap[buffName]
end

function HealBot_GetHealBot_AddonMsgType()
    return HealBot_AddonMsgType;
end

function HealBot_RetHealBot_Ressing(hbGUID)
    return HealBot_Ressing[hbGUID];
end

function HealBot_UnsetHealBot_Ressing(hbGUID)
    HealBot_Ressing[hbGUID]=nil;
end

function HealBot_TooltipInit()
    if ( HealBot_ScanTooltip:IsOwned(HealBot) ) then return; end;
    HealBot_ScanTooltip:SetOwner(HealBot, 'ANCHOR_NONE' );
    HealBot_ScanTooltip:ClearLines();
end

function HealBot_AddChat(HBmsg)
    x=HealBot_Comms_GetChan("HBmsg");
    if x and HealBot_SpamCnt < 24 then
        HealBot_SpamCnt=HealBot_SpamCnt+1;
        HBmsg="["..date("%H:%M", time()).."] "..HBmsg;
        SendChatMessage(HBmsg , "CHANNEL", nil, x); 
    elseif ( DEFAULT_CHAT_FRAME ) then
        DEFAULT_CHAT_FRAME:AddMessage(HBmsg, 0.7, 0.7, 1.0);
    end
end

function HealBot_AddDebug(HBmsg)
    x=HealBot_Comms_GetChan("HBmsg");
    if x and HealBot_SpamCnt < 17 then
        HealBot_SpamCnt=HealBot_SpamCnt+1;        
        HBmsg="["..date("%H:%M", time()).."] DEBUG: "..HBmsg;
        SendChatMessage(HBmsg , "CHANNEL", nil, x);
    end
end

function HealBot_AddError(HBmsg)
    UIErrorsFrame:AddMessage(HBmsg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
    HealBot_AddDebug(HBmsg);
end

function HealBot_TogglePanel(HBpanel)
    if not HBpanel then return end
    if ( HBpanel:IsVisible() ) then
        HideUIPanel(HBpanel);
    else
        ShowUIPanel(HBpanel);
    end
end

function HealBot_StartMoving(HBframe)
    if ( not HBframe.isMoving ) and ( HBframe.isLocked ~= 1 ) then
        HBframe:StartMoving();
        HBframe.isMoving = true;
    end
end

function HealBot_StopMoving(HBframe,ActionFrame)
    if ( HBframe.isMoving ) then
        HBframe:StopMovingOrSizing();
        HBframe.isMoving = false;
    end
    if ActionFrame then
        HealBot_CheckActionFrame()
    end
end

function HealBot_CheckActionFrame()
    if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<-20 or Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<-20 then 
        Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=ceil(GetScreenHeight()/2);
        Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=ceil(GetScreenWidth()/2); 
    else
        if Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==1 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetTop();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetLeft()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==2 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetBottom();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetLeft()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==3 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetTop();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetRight()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==4 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetBottom();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetRight()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==5 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetTop();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetCenter()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==6 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = ceil((HealBot_Action:GetTop()+HealBot_Action:GetBottom())/2);
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetLeft()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==7 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = ceil((HealBot_Action:GetTop()+HealBot_Action:GetBottom())/2);
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetRight()
        elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==8 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetBottom();
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin] = HealBot_Action:GetCenter()
        end
    end
    HealBot_CheckFrame()
end

function HealBot_CheckFrame()
    if not GetScreenWidth() or not Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin] then return end
    if Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==1 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<-9 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=-9
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<11+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=11+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] 
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()+12 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()+12
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==2 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<-9 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=-9
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<-15 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=-15
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==3 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()+8) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()+8
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<11+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=11+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] 
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()+12 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()+12
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==4 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()+8) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()+8
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<-15 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=-15
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==5 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<1 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=1
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()+1) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()+1
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<-15 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=-15
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==6 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<-9 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=-9
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()-(Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7)
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<1 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=1 
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()+1 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()+1
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==7 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin]+7
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()+8) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()+8
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<1 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=1 
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()+1 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()+1
        end
    elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Current_Skin]==8 then
        if Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]<1 then 
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=1
        elseif Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]>(GetScreenWidth()+1) then
            Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()+1
        end
        if Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]<-15 then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=-15
        elseif Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]>GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()-15-Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]
        end
    end
end

function HealBot_SlashCmd(HBcmd)
    if not HBcmd then HBcmd="" end
    HBcmd, x, y, z = string.split(" ", HBcmd)
    HBcmd=string.lower(HBcmd) 
    if (HBcmd=="") then
        HealBot_TogglePanel(HealBot_Action);
    elseif (HBcmd=="o" or HBcmd=="options" or HBcmd=="opt" or HBcmd=="config" or HBcmd=="cfg") then
        HealBot_TogglePanel(HealBot_Options);
    elseif (HBcmd=="d" or HBcmd=="defaults") then
        HealBot_Options_Defaults_OnClick(HealBot_Options_Defaults);
    elseif (HBcmd=="ui") then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_HARDRELOAD)
        HealBot_SetResetFlag("HARD")
    elseif (HBcmd=="ri" or (HBcmd=="reset" and x and x=="healbot")) then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SOFTRELOAD)
        HealBot_SetResetFlag("SOFT")
    elseif (HBcmd=="rc" or (HBcmd=="reset" and x and x=="customdebuffs")) then
        HealBot_Reset_flag=2
    elseif (HBcmd=="rs" or (HBcmd=="reset" and x and x=="skin")) then
        HealBot_Reset_flag=3
    elseif (HBcmd=="info" or HBcmd=="ver" or HBcmd=="status") then
        HealBot_Comms_Info()
    elseif (HBcmd=="show") then
        HealBot_Action_Reset()
    elseif (HBcmd=="cb") then
        HealBot_Panel_ClearBlackList()
    elseif (HBcmd=="cspells") then
        HealBot_Copy_SpellCombos()
    elseif (HBcmd=="rspells") then
        HealBot_Reset_Spells()
    elseif (HBcmd=="rcures") then
        HealBot_Reset_Cures()
    elseif (HBcmd=="rbuffs") then
        HealBot_Reset_Buffs()
    elseif (HBcmd=="disable") then
        HealBot_Options_DisableHealBot:SetChecked(1)
        HealBot_Options_ToggleHealBot(1)
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_DISABLED)
    elseif (HBcmd=="enable") then
        HealBot_Options_DisableHealBot:SetChecked(0)
        HealBot_Options_ToggleHealBot(0)
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_ENABLED)
    elseif (HBcmd=="t") then
        HB_Timer1=0.01
        if HealBot_Config.DisableHealBot==0 then
            HealBot_Options_DisableHealBot:SetChecked(1)
            HealBot_Options_ToggleHealBot(1)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_DISABLED)
        else
            HealBot_Options_DisableHealBot:SetChecked(0)
            HealBot_Options_ToggleHealBot(0)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_ENABLED)
        end
    elseif (HBcmd=="tinfo") then
        if UnitExists("target") then
            HealBot_Comms_TargetInfo()
        else
            HealBot_AddDebug( "No Target" );
        end
    elseif (HBcmd=="comms") then
        HealBot_Comms_Zone()
    elseif (HBcmd=="help" or HBcmd=="h") then
        HealBot_HelpCnt=0
    elseif (HBcmd=="tt") then
        HealBot_Titan_Toggle()
    elseif (HBcmd=="skin" and x) then
        if y then x=x.." "..y end
        if z then x=x.." "..z end
        HealBot_Options_Set_Current_Skin(x)
    elseif (HBcmd=="ss" and x and y) then
        HealBot_Options_ShareSkinSend("A", x, y)
    elseif (HBcmd=="as") then
        HealBot_ToggleAcceptSkins()
    elseif (HBcmd=="use10") then
        if HealBot_Config.MacroUse10==1 then
            HealBot_Config.MacroUse10=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_USE10OFF)
        else
            HealBot_Config.MacroUse10=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_USE10ON)
        end
    elseif (HBcmd=="suppress" and x) then
        x=string.lower(x)
        HealBot_ToggleSuppressSetting(x)
    elseif (HBcmd=="test" and x) then
        if tonumber(x) and tonumber(x)>4 and tonumber(x)<51 then
            HealBot_TestBars(x)
        end
    elseif (HBcmd=="tr" and x) then
        HealBot_Panel_SethbTopRole(x)
    elseif (HBcmd=="ssp") then
        HealBot_Panel_SetSubSortPlayer()
    elseif (HBcmd=="spt") then
        if Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Current_Skin]==1 then
            Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Current_Skin]=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SELFPETSOFF)
        else
            Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Current_Skin]=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SELFPETSON)
        end
        if Delay_RecalcParty<2 then Delay_RecalcParty=2; end
    elseif (HBcmd=="ws") then
        if HealBot_Config.ShowWSicon==1 then
            HealBot_Config.ShowWSicon=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_DEBUFF_WEAKENED_SOUL.." - "..HEALBOT_WORD_OFF)
        else
            HealBot_Config.ShowWSicon=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_DEBUFF_WEAKENED_SOUL.." - "..HEALBOT_WORD_ON)
        end
    elseif (HBcmd=="cp") then
        if not x then
            if Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]==1 then
                Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]=0
            else
                Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]=1
            end
            HealBot_Options_update_cpSkin()
        else
            x=1 -- Do Stuff
        end
    elseif (HBcmd=="bt") then
        if HealBot_Config.BuffWatch==1 then
            HealBot_Config.BuffWatch=0
        else
            HealBot_Config.BuffWatch=1
        end
        HealBot_Options_MonitorBuffs:SetChecked(HealBot_Config.BuffWatch)
        HealBot_Options_MonitorBuffs_Toggle()
    elseif (HBcmd=="dt") then
        if HealBot_Config.DebuffWatch==1 then
            HealBot_Config.DebuffWatch=0
        else
            HealBot_Config.DebuffWatch=1
        end
        HealBot_Options_MonitorDebuffs:SetChecked(HealBot_Config.DebuffWatch)
        HealBot_Options_MonitorDebuffs_Toggle()
    else
        if x then HBcmd=HBcmd.." "..x end
        if y then HBcmd=HBcmd.." "..y end
        if z then HBcmd=HBcmd.." "..z end
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_UNKNOWNCMD..HBcmd)
        HealBot_HelpCnt=0
    end
end

function HealBot_setResetFlagCode(resetCode)
    HealBot_Reset_flag=resetCode
end

function HealBot_ToggleAcceptSkins()
    if HealBot_Config.AcceptSkins==1 then
        HealBot_Config.AcceptSkins=0
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_ACCEPTSKINOFF)
    else
        HealBot_Config.AcceptSkins=1
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_ACCEPTSKINON)
    end
end

function HealBot_ToggleSuppressSetting(settingType)
    if settingType=="sound" then
        if HealBot_Config.MacroSuppressSound==1 then
            HealBot_Config.MacroSuppressSound=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROSOUNDON)
        else
            HealBot_Config.MacroSuppressSound=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROSOUNDOFF)
        end
        HealBot_Action_SetAllAttribs()
    elseif settingType=="error" then
        if HealBot_Config.MacroSuppressError==1 then
            HealBot_Config.MacroSuppressError=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROERRORON)
        else
            HealBot_Config.MacroSuppressError=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROERROROFF)
        end
        HealBot_Action_SetAllAttribs()
    end
end

function HealBot_TestBars(noBars)
    local numBars=noBars or HealBot_Config.noTestBars
    HealBot_Panel_SetNumBars(numBars)
    HealBot_Panel_ToggleTestBars()
    if Delay_RecalcParty<2 then Delay_RecalcParty=2; end
end

function HealBot_Reset()
    HB_Timer1=0.01
    HB_Timer2=0.2
    HB_Timer3=0.2
    HealBot_UnRegister_Events()
    initIncHeals=true
    HealBot_Panel_ClearBlackList()
    HealBot_Panel_ClearHealTarget()
    HealBot_Action_ResethbInitButtons()
    HealBot_ClearAggro(true)
    HealBot_Panel_ClearBarArrays()
    HealBot_Loaded=1
    HealBot_setOptions_Timer(150)
    HealBot_PlayerGUID=nil
    HealBot_Load("hbReset") 
    HealBot_OnEvent_PlayerEnteringWorld(nil);
    HealBot_setOptions_Timer(190)
    HealBot_IncHeals_resetIncHeals()
    HealBot_OnEvent_RaidRosterUpdate(nil)
end

function HealBot_ResetCustomDebuffs()
    HealBot_Config.HealBot_Custom_Debuffs = HealBot_ConfigDefaults.HealBot_Custom_Debuffs
    HealBot_Globals.Custom_Debuff_Categories = HealBot_GlobalsDefaults.Custom_Debuff_Categories
    for s in pairs(HealBot_Config.CDCBarColour) do
        if not HealBot_ConfigDefaults.CDCBarColour[s] then
            HealBot_Config.CDCBarColour[s]=nil
        end
    end
    HealBot_Config.CDCBarColour[HEALBOT_CUSTOM_en]=HealBot_ConfigDefaults.CDCBarColour[HEALBOT_CUSTOM_en]
    HealBot_Options_NewCDebuff:SetText("")
    HealBot_Options_CDebuffTxt1_Refresh()
    HealBot_Options_CDCPriorityC_Refresh()
    HealBot_SetCDCBarColours();
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS)
end

function HealBot_ResetSkins()
    Healbot_Config_Skins = HealBot_Config_SkinsDefaults
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSKINDEFAULTS)
    HealBot_Reset_flag=1
end

function HealBot_Reset_Unit(hbGUID)
    HealBot_Action_ClearUnitDebuffStatus(hbGUID)
    HealBot_ClearAllBuffs(hbGUID)
    HealBot_ClearAllDebuffs(hbGUID)
    HealBot_Reset_UnitHealth(hbGUID)
    if HealBot_UnitID[hbGUID] then
        HealBot_ClearUnitAggro(HealBot_UnitID[hbGUID], hbGUID)
        HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID])
    end
    if HealBot_Action_RetMyTarget(hbGUID) then  HealBot_Action_Toggle_Enabled(hbGUID); end
end

function HealBot_GetSpellName(id)
    if (not id) then return nil end
    sName, sRank = GetSpellName(id,BOOKTYPE_SPELL);
    if (not sName) then
        return nil;
    end
    if (not sRank or sRank=="") then
        return sName;
    end
    return sName, sRank;
end

function HealBot_GetSpellId(spellName)
    if (not spellName) then return nil end
    x,y = 1,0;
    if HealBot_Spells[spellName] then   
        if HealBot_Spells[spellName].x then return HealBot_Spells[spellName].x; end
    end
    while true do 
        sName, sRank = GetSpellName(x,BOOKTYPE_SPELL);
        if (sName) then
            if (spellName == sName .. "(" .. sRank .. ")") then
                return x;
            end
            if (spellName == sName) then
                y=x;
            end   
        else
            do break end
        end
        x = x + 1;
    end
    if y>0 then
        return y
    else
        return nil;
    end
end

function HealBot_UnitHealth(hbGUID, unit)
    x,y=nil,nil
    if HealBot_unitHealth[hbGUID] then
        x=HealBot_unitHealth[hbGUID]
        y=HealBot_unitHealthMax[hbGUID]
    elseif unit and UnitHealth(unit) then
        x=UnitHealth(unit)
        y=UnitHealthMax(unit)
    end
    if not x or not y then
        if unit then
            HealBot_AddDebug("HealBot_UnitHealth - Health(Max) is nil!  unit passed in = "..unit.." ("..UnitName(unit)..")")
        else
            HealBot_AddDebug("HealBot_UnitHealth - Health(Max) is nil! unitid is nil")
        end
        x=500
        y=1000
    end
    return x,y;
end


local talenty,talentx,talentz=0,0,0
local initIncHealsVals={}
function HealBot_FindHealSpells()
  
    if strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_PRIEST] then 
        y=1+HealBot_Talents[HEALBOT_SPIRITAL_HEALING]+HealBot_Talents[HEALBOT_BLESSED_RESILIENCE]+HealBot_Talents[HEALBOT_FOCUSED_POWER]
    elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_DRUID] then 
        y=1+HealBot_Talents[HEALBOT_GIFT_OF_NATURE]+HealBot_Talents[HEALBOT_MASTER_SHAPESHIFTER]
    elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_SHAMAN] then 
        y=1+HealBot_Talents[HEALBOT_PURIFICATION]
    else
        y=1
    end
  
    table.foreach(HealBot_Spells, function (spell,_)
        if HealBot_Spells[spell].NoBonus then
            HealBot_Spells[spell].RealHealing = 0
        else
            talentz=GetSpellBonusHealing()*1.88;
            talentx=y
            if strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_DRUID] then
                talenty=1+HealBot_Talents[HEALBOT_NURTURING_INSTINCT]
            elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_SHAMAN] then
                talenty=1+HealBot_Talents[HEALBOT_NATURES_BLESSING]
            elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_PALADIN] then 
                talenty=1+HealBot_Talents[HEALBOT_TOUCHED_BY_THE_LIGHT]
                talenty=talenty+HealBot_Talents[HEALBOT_HOLY_GUIDANCE]
            else
                talenty=1
            end
            local healingbonus_penalty=1;
            if HealBot_Spells[spell].Level < 20 then
                healingbonus_penalty=(1-((20-HealBot_Spells[spell].Level)*0.0375));
            end
            if strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_DRUID] and HealBot_Spells[spell].HealsExt>0 then
                talentx=talentx+HealBot_Talents[HEALBOT_EMPOWERED_REJUVENATION]
            end
            if HealBot_Spells[spell].Cast == 0 then
                if strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_PRIEST] then 
                    talentx=talentx+HealBot_Talents[HEALBOT_TWIN_DISCIPLINES]
                    if strfind(spell,HEALBOT_RENEW,1) then
                        talentx=talentx+HealBot_Talents[HEALBOT_IMPROVED_RENEW]
                        talentx=talentx+HealBot_Talents[HEALBOT_EMPOWERED_RENEW]
                    end
                elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_DRUID] then
                    talentx=talentx+HealBot_Talents[HEALBOT_GENESIS]
                    if strfind(spell,HEALBOT_REJUVENATION,1) then
                        talentx=talentx+HealBot_Talents[HEALBOT_IMPROVED_REJUVENATION]
                    end
                end
                w=3.5;
            else
                if strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_PRIEST] then 
                    if strfind(spell,HEALBOT_GREATER_HEAL,1) then
                        talentx=talentx+(HealBot_Talents[HEALBOT_EMPOWERED_HEALING]*2)
                    elseif strfind(spell,HEALBOT_FLASH_HEAL,1) then
                        talentx=talentx+HealBot_Talents[HEALBOT_EMPOWERED_HEALING]
                    elseif strfind(spell,HEALBOT_BINDING_HEAL,1) then
                        talentx=talentx+HealBot_Talents[HEALBOT_DIVINE_PROVIDENCE]
                        talentx=talentx+HealBot_Talents[HEALBOT_EMPOWERED_HEALING]
                    elseif strfind(spell,HEALBOT_PRAYER_OF_HEALING,1) then
                        talentz=GetSpellBonusHealing()
                        talentx=talentx+HealBot_Talents[HEALBOT_DIVINE_PROVIDENCE]
                    end
                elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_DRUID] then
                    if strfind(spell,HEALBOT_HEALING_TOUCH,1) then
                        talentx=talentx+HealBot_Talents[HEALBOT_EMPOWERED_TOUCH]
                    end
                elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_PALADIN] then 
                    talentx=talentx+HealBot_Talents[HEALBOT_HEALING_LIGHT]+HealBot_Talents[HEALBOT_DIVINITY]
                elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_SHAMAN] then
                    if strfind(spell,HEALBOT_CHAIN_HEAL,1) then            
                        talentx=talentx+HealBot_Talents[HEALBOT_IMPROVED_CHAIN_HEAL]
                    elseif strfind(spell,HEALBOT_HEALING_WAVE,1) then
                        talentx=talentx+HealBot_Talents[HEALBOT_HEALING_WAY]
                        talentx=talentx+(HealBot_Talents[HEALBOT_TIDAL_WAVES]*2)
                    elseif strfind(spell,HEALBOT_LESSER_HEALING_WAVE,1) then
                        talentx=talentx+HealBot_Talents[HEALBOT_TIDAL_WAVES]
                    end
                end
                if HealBot_Spells[spell].Cast > 0 and HealBot_Spells[spell].Cast < 3.5 then
                    w=HealBot_Spells[spell].Cast;
                else
                    w=3.5
                end
            end
            talentz = (talentz * healingbonus_penalty);
            z = ((HealBot_Spells[spell].Level)+6)/(UnitLevel("player"))
            if z<1 then talentz=talentz*z; end
            talentz = talentz + talenty
            talentz=talentz*(w/3.5)
            x=ceil(talentz*talentx)
            HealBot_Spells[spell].RealHealing = x;
        end
        if HealBot_Config.HealCommMethod>1 then
            if HealBot_Spells[spell].HealsCast>0 and HealBot_Spells[spell].Cast>0 and HealBot_Spells[spell].spell and HealBot_Spells[HealBot_Spells[spell].spell].Level==HealBot_Spells[spell].Level then
                if initIncHeals then
                    initIncHealsVals[HealBot_Spells[spell].spell]=HealBot_Spells[spell].HealsCast+HealBot_Spells[spell].RealHealing
                    initIncHeals="nil"
                    if HealBot_Spells[spell].spell==HEALBOT_REGROWTH then initIncHealsVals["H"..HealBot_Spells[spell].spell]=HealBot_Spells[spell].HealsExt+HealBot_Spells[spell].RealHealing end
                else
                    HealBot_initHealData[HealBot_Spells[spell].spell]=true
                end
            elseif HealBot_Spells[spell].Duration and HealBot_Spells[spell].Duration>0 and HealBot_Spells[spell].spell and HealBot_Spells[HealBot_Spells[spell].spell].Level==HealBot_Spells[spell].Level then
                if initIncHeals then
                    initIncHealsVals[HealBot_Spells[spell].spell]=HealBot_Spells[spell].HealsExt+HealBot_Spells[spell].RealHealing
                else
                    HealBot_initHealData[HealBot_Spells[spell].spell]=true
                end
            end
        end
        HealBot_Spells[spell].HealsDur = floor((HealBot_Spells[spell].HealsCast+HealBot_Spells[spell].HealsExt) + HealBot_Spells[spell].RealHealing);
    end);

    if initIncHeals and initIncHeals=="nil" then 
        for x,y in pairs(initIncHealsVals) do
            HealBot_IncHeals_setHealValues(HealBot_PlayerName, x, y)
        end
        initIncHeals=nil 
    end
end

function HealBot_RecalcHeals(hbGUID)
    if HealBot_luVars["DoUpdates"] and UnitExists(HealBot_UnitID[hbGUID]) then
        HealBot_Action_Refresh(hbGUID);
    end
end

function HealBot_RecalcParty(HealBot_PreCombat)
    Delay_RecalcParty=0;
    HealBot_Action_PartyChanged(HealBot_PreCombat);
end

function HealBot_RecalcSpells()
    HealBot_FindHealSpells();
end

function HealBot_OnLoad(self)
    HealBot_PlayerClass, HealBot_PlayerClassEN=UnitClass("player")
    HealBot_PlayerRace, HealBot_PlayerRaceEN=UnitRace("player")
    HealBot_PlayerName=UnitName("player")
    HealBot:RegisterEvent("VARIABLES_LOADED");
    HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
    HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
    SLASH_HEALBOT1 = "/healbot";
    SLASH_HEALBOT2 = "/hb";
    SlashCmdList["HEALBOT"] = function(msg)
        HealBot_SlashCmd(msg);
    end
end

local ouName=nil
local aSwitch=0

function HealBot_Set_Timers()
    if HealBot_Config.DisableHealBot==0 then
        HB_Timer1=0.7
        HB_Timer2=HealBot_Comm_round(HealBot_Config.RangeCheckFreq/8, 4)   
        HB_Timer3=0.3
    else
        HB_Timer1=2
        HB_Timer2=5
        HB_Timer3=5
    end
end

local HealBot_Options_Timer={}
function HealBot_setOptions_Timer(value)
    HealBot_Options_Timer[value]=true
end

local HealBot_ErrorNum=0
local HealBot_testBarInit={}
local HealBot_trackPartyFrames=false
local hbRequestTime=0
function HealBot_initTestBar(b)
    table.insert(HealBot_testBarInit,b)
end

local hbDelayResetUnitStatus={}
function HealBot_setDelayResetUnitStatus(hbGUID)
    hbDelayResetUnitStatus[hbGUID]=GetTime()+0.3
end

local lTimer,eTimer=0,GetTime()
function HealBot_OnUpdate(self)
    lTimer=GetTime()-eTimer
    eTimer=GetTime()
    HealBot_Timer1 = HealBot_Timer1+lTimer;
    HealBot_Timer2 = HealBot_Timer2+lTimer;
    HealBot_Timer3 = HealBot_Timer3+lTimer;
    if HealBot_Loaded then
        if not HealBot_PlayerGUID then
            HealBot_Load("onUpdate")      
        elseif HealBot_Timer1>=HB_Timer1 then
            HealBot_Timer1 = 0;
            Ti=0
            for s in pairs(HealBot_HealsIncEndTime) do
                if HealBot_HealsIncEndTime[s]<GetTime() then
                    xGUID, casterName = string.split(":", s)
                    if HealBot_IncHeals_retHealsIn(xGUID, "D")>0 then
                        if HealBot_Config.HealCommMethod==1 then
                            HealBot_IncHeals_HealsInUpdate(xGUID)
                        else
                            HealBot_IncHeals_resetIncHeals(xGUID, "D", casterName)
                        end
                    else
                        HealBot_HealsIncEndTime[s]=nil
                    end
                end
            end
            if HealBot_luVars["rcEnd"] and HealBot_luVars["rcEnd"]<GetTime() then
                HealBot_OnEvent_ReadyCheckClear()
                HealBot_luVars["rcEnd"]=nil
            end
            if not HealBot_IsFighting and not InCombatLockdown() then
                if HealBot_Reset_flag then
                    if HealBot_Reset_flag==1 then
                        HealBot_Reset()
                    elseif HealBot_Reset_flag==2 then
                        HealBot_ResetCustomDebuffs()
                    elseif HealBot_Reset_flag==3 then
                        HealBot_ResetSkins()
                    end
                    HealBot_Reset_flag=nil
                elseif HealBot_luVars["UseCrashProtection"] and HealBot_luVars["UseCrashProtection"]<GetTime() then 
                        HealBot_luVars["UseCrashProtection"]=nil
                        if Delay_RecalcParty<2 then Delay_RecalcParty=2; end
                elseif Delay_RecalcParty>0 then
                    Delay_RecalcParty=Delay_RecalcParty+1
                    if Delay_RecalcParty>2 and HealBot_luVars["CheckSkin"] then
                        HealBot_PartyUpdate_CheckSkin()
                    elseif Delay_RecalcParty>3 then
                        HealBot_RecalcParty(nil);
                        HealBot_InCombatUpdCnt=0
                    end
                elseif HealBot_NeedEquipUpdate then
                    HealBot_NeedEquipUpdate=false
                    HealBot_RecalcSpells();
                    if strsub(HealBot_PlayerClassEN,1,4)=="SHAM" then
                        HealBot_CheckAllBuffs(HealBot_PlayerGUID)
                    end
                elseif HealBot_CheckTalents then
                    HealBot_InitSpells()
                    HealBot_CheckTalents=false; 
                    HealBot_NeedEquipUpdate=true
                    HealBot_GetTalentInfo(HealBot_PlayerGUID, "player")
                    if strsub(HealBot_PlayerClassEN,1,4)=="PRIE" then 
                        HealBot_Talents[HEALBOT_BODY_AND_SOUL]=HealBot_HasTalent(2,20,HEALBOT_BODY_AND_SOUL)
                        HealBot_Talents[HEALBOT_IMPROVED_RENEW]=(5*HealBot_HasTalent(2,2,HEALBOT_IMPROVED_RENEW))/100
                        HealBot_Talents[HEALBOT_EMPOWERED_RENEW]=(5*HealBot_HasTalent(2,23,HEALBOT_EMPOWERED_RENEW))/100
                        HealBot_Talents[HEALBOT_SPIRITAL_HEALING]=(2*HealBot_HasTalent(2,16,HEALBOT_SPIRITAL_HEALING))/100
                        HealBot_Talents[HEALBOT_TWIN_DISCIPLINES]=HealBot_HasTalent(1,2,HEALBOT_TWIN_DISCIPLINES)/100
                        HealBot_Talents[HEALBOT_FOCUSED_POWER]=(2*HealBot_HasTalent(1,16,HEALBOT_FOCUSED_POWER))/100
                        HealBot_Talents[HEALBOT_EMPOWERED_HEALING]=(4*HealBot_HasTalent(2,21,HEALBOT_EMPOWERED_HEALING))/100
                        HealBot_Talents[HEALBOT_DIVINE_PROVIDENCE]=(2*HealBot_HasTalent(2,26,HEALBOT_DIVINE_PROVIDENCE))/100
                        HealBot_Talents[HEALBOT_BLESSED_RESILIENCE]=HealBot_HasTalent(2,19,HEALBOT_BLESSED_RESILIENCE)/100
                    elseif strsub(HealBot_PlayerClassEN,1,4)=="DRUI" then 
                        HealBot_Talents[HEALBOT_GENESIS]=HealBot_HasTalent(1,2,HEALBOT_GENESIS)/100
                        _,i=UnitStat("player", 2)
                        HealBot_Talents[HEALBOT_NURTURING_INSTINCT]=i*(0+(35*HealBot_HasTalent(2,15,HEALBOT_NURTURING_INSTINCT)/100))
                        HealBot_Talents[HEALBOT_IMPROVED_REJUVENATION]=(5*HealBot_HasTalent(3,11,HEALBOT_IMPROVED_REJUVENATION))/100
                        HealBot_Talents[HEALBOT_GIFT_OF_NATURE]=(2*HealBot_HasTalent(3,13,HEALBOT_GIFT_OF_NATURE))/100
                        HealBot_Talents[HEALBOT_EMPOWERED_TOUCH]=(20*HealBot_HasTalent(3,15,HEALBOT_EMPOWERED_TOUCH))/100
                        HealBot_Talents[HEALBOT_EMPOWERED_REJUVENATION]=(4*HealBot_HasTalent(3,20,HEALBOT_EMPOWERED_REJUVENATION))/100
                        HealBot_Talents[HEALBOT_MASTER_SHAPESHIFTER]=(2*HealBot_HasTalent(3,9,HEALBOT_MASTER_SHAPESHIFTER))/100
                    elseif strsub(HealBot_PlayerClassEN,1,4)=="SHAM" then 
                        HealBot_Talents[HEALBOT_PURIFICATION]=(2*HealBot_HasTalent(3,15,HEALBOT_PURIFICATION))/100
                        HealBot_Talents[HEALBOT_IMPROVED_CHAIN_HEAL]=(10*HealBot_HasTalent(3,20,HEALBOT_IMPROVED_CHAIN_HEAL))/100
                        HealBot_Talents[HEALBOT_TIDAL_WAVES]=(2*HealBot_HasTalent(3,25,HEALBOT_TIDAL_WAVES))/100
                        HealBot_Talents[HEALBOT_HEALING_WAY]=(3*HealBot_HasTalent(3,12,HEALBOT_HEALING_WAY))/100
                        _,i=UnitStat("player", 4)
                        HealBot_Talents[HEALBOT_NATURES_BLESSING]=i*(0+(5*HealBot_HasTalent(3,21,HEALBOT_NATURES_BLESSING)/100))
                    elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_PALADIN] then 
                        HealBot_Talents[HEALBOT_HEALING_LIGHT]=(4*HealBot_HasTalent(1,3,HEALBOT_HEALING_LIGHT))/100
                        HealBot_Talents[HEALBOT_DIVINITY]=(1*HealBot_HasTalent(2,1,HEALBOT_DIVINITY))/100
                        _,i=UnitStat("player", 1)
                        HealBot_Talents[HEALBOT_TOUCHED_BY_THE_LIGHT]=i*(0+(20*HealBot_HasTalent(2,21,HEALBOT_TOUCHED_BY_THE_LIGHT)/100))
                        _,i=UnitStat("player", 4)
                        HealBot_Talents[HEALBOT_HOLY_GUIDANCE]=i*(0+(4*HealBot_HasTalent(1,21,HEALBOT_HOLY_GUIDANCE)/100))
                    end  
                    HealBot_Options_InitBuffList()
                    HealBot_setOptions_Timer(15)
                    HealBot_Options_ResetDoInittab(10)
                    HealBot_Options_ResetDoInittab(5)
                    HealBot_Options_ResetDoInittab(4)
                    HealBot_setOptions_Timer(40)
                    HealBot_setOptions_Timer(50)
                    HealBot_ClearAllBuffs()
                    HealBot_ClearAllDebuffs()
                    HealBot_setOptions_Timer(400)
                    HealBot_setOptions_Timer(10)
                elseif HealBot_CheckBuffsTimehbGUID and HealBot_CheckBuffsTime<GetTime() and not HealBot_UnitBuff[HealBot_CheckBuffsTimehbGUID] then
                    if HealBot_UnitSpec[HealBot_CheckBuffsTimehbGUID] then
                        PlayerBuffsGUID=HealBot_PlayerBuff[HealBot_CheckBuffsTimehbGUID]
                        Ti=0
                        if PlayerBuffsGUID then
                            for bName,_ in pairs (PlayerBuffsGUID) do
                                if PlayerBuffsGUID[bName] < GetTime() then
                                    HealBot_CheckUnitBuffs(HealBot_CheckBuffsTimehbGUID)
                                    Ti=1
                                    do break end
                                end
                            end
                        end
                        if Ti==0 then
                            HealBot_CheckMyBuffs(HealBot_CheckBuffsTimehbGUID)
                            HealBot_ResetCheckBuffsTime()  
                        end
                    else
                        HealBot_PlayerBuff[HealBot_CheckBuffsTimehbGUID]=nil
                        HealBot_ResetCheckBuffsTime()
                    end
                elseif HealBot_ReCheckBuffsTime and HealBot_ReCheckBuffsTime<GetTime() then
                    HealBot_CheckAllBuffs(HealBot_ReCheckBuffsTimed[HealBot_ReCheckBuffsTime])
                    HealBot_ReCheckBuffsTimed[HealBot_ReCheckBuffsTime]=nil
                    z=HealBot_ReCheckBuffsTime+1000000
                    HealBot_ReCheckBuffsTime=nil 
                    for Time,_ in pairs (HealBot_ReCheckBuffsTimed) do
                        if Time < z then
                            z=Time
                            HealBot_ReCheckBuffsTime=Time
                        end
                    end
                elseif HealBot_luVars["WeaponBuffCheck"] then
                    HealBot_luVars["WeaponBuffCheck"]=HealBot_luVars["WeaponBuffCheck"]-1
                    if HealBot_luVars["WeaponBuffCheck"]<=0 then HealBot_luVars["WeaponBuffCheck"]=nil end
                    if HealBot_UnitBuff[HealBot_PlayerGUID] then HealBot_CheckUnitBuffs(HealBot_PlayerGUID) end
                else
                    for xGUID,_ in pairs(HealBot_DelayDebuffCheck) do
                        if Ti<4 then
                            HealBot_CheckUnitDebuffs(xGUID)
                            Ti=Ti+1
                            HealBot_DelayDebuffCheck[xGUID] = nil;
                        end
                    end
                    for xGUID,_ in pairs(HealBot_DelayBuffCheck) do
                        if Ti<5 then
                            HealBot_CheckUnitBuffs(xGUID)
                            Ti=Ti+1
                            HealBot_DelayBuffCheck[xGUID] = nil;
                        end
                    end
                    for xGUID,xUnit in pairs(HealBot_QueueCheckBuffs) do
                        if Ti<3 then
                            HealBot_CheckMyBuffs(xGUID)
                            HealBot_DelayAuraCheck[xGUID]=xUnit
                            HealBot_QueueCheckBuffs[xGUID]=nil
                            Ti=Ti+1
                        end
                    end
                    for xGUID,x in pairs(HealBot_cleanGUIDs) do
                        if Ti<3 then
                            HealBot_IncHeals_clearSuperGUID(xGUID, x)
                            HealBot_ClearLocalArr(xGUID, x)
                            HealBot_cleanGUIDs[xGUID]=nil
                            Ti=Ti+1
                        end
                    end
                    if HealBot_RequestVer then
                        if HealBot_Config.HealCommMethod>3 then
                            HealBot_Comms_SendAddonMsg("HealBot", "S:"..HEALBOT_VERSION..":V", HealBot_AddonMsgType, HealBot_PlayerName)
                        else
                            HealBot_Comms_SendAddonMsg("HealBot", "S:"..HEALBOT_VERSION..":N", HealBot_AddonMsgType, HealBot_PlayerName)
                        end
                        HealBot_RequestVer=nil;
                    end
                    if HealBot_Config.TooltipUpdate==1 then  
                        if HealBot_Action_TooltipUnit then
                            HealBot_Action_RefreshTooltip(HealBot_Action_TooltipUnit,"Enabled");
                        elseif HealBot_Action_DisableTooltipUnit then
                            HealBot_Action_RefreshTooltip(HealBot_Action_DisableTooltipUnit,"Disabled");
                        end
                    end
                    if HealBot_luVars["cpMacro"] and HealBot_luVars["cpMacro"]<GetTime() then 
                        HealBot_cpSaveAll()
                    end
                end
                if HealBot_Options_Timer then
                    if HealBot_Options_Timer[150] then
                        HealBot_Options_Timer[150]=nil
                        HealBot_Action_ResetSkin("init")
                    elseif HealBot_Options_Timer[1] then
                        HealBot_Options_Timer[1]=nil
                        if ( UIDROPDOWNMENU_MAXBUTTONS < 29 ) then 
                            local toggle;
                            if ( not WorldMapFrame:IsVisible() ) then
                                ToggleFrame(WorldMapFrame);
                                toggle = true;
                            end
                            SetMapZoom(2);
                            if ( toggle ) then
                                ToggleFrame(WorldMapFrame);
                            end
                        end
                    elseif HealBot_Options_Timer[5] then
                        HealBot_Options_Timer[5]=nil
                        HealBot_Options_InitBuffList()
                    elseif HealBot_Options_Timer[10] then
                        HealBot_Options_Timer[10]=nil
                        HealBot_Queue_AllActiveMyBuffs()
                    elseif HealBot_Options_Timer[15] then
                        HealBot_Options_Timer[15]=nil
                        HealBot_Options_ComboClass_Text()
                    elseif HealBot_Options_Timer[20] then
                        HealBot_Options_Timer[20]=nil
                        HealBot_CheckAllDebuffs()
                    elseif HealBot_Options_Timer[30] then
                        HealBot_Options_Timer[30]=nil
                        HealBot_CheckAllBuffs()
                    elseif HealBot_Options_Timer[40] then
                        HealBot_Options_Timer[40]=nil
                        HealBot_Options_Buff_Reset()
                    elseif HealBot_Options_Timer[50] then
                        HealBot_Options_Timer[50]=nil
                        HealBot_Options_Debuff_Reset()
                    elseif HealBot_Options_Timer[60] then
                        HealBot_Options_Timer[60]=nil
                        HealBot_Options_EmergencyFilter_Reset()
                    elseif HealBot_Options_Timer[70] then
                        HealBot_Options_Timer[70]=nil
                        HealBot_Options_CheckCombos()
                    elseif HealBot_Options_Timer[80] then
                        HealBot_Options_Timer[80]=nil
                        HealBot_Action_ResetUnitStatus()
                        HealBot_Action_sethbNumberFormat()
                    elseif HealBot_Options_Timer[85] then
                        HealBot_Options_Timer[85]=nil
                        HealBot_Action_ResetUnitStatus()
                        HealBot_Action_sethbAggroNumberFormat()
                    elseif HealBot_Options_Timer[90] then
                        HealBot_Options_Timer[90]=nil
                        HealBot_SetSkinColours();
                    elseif HealBot_Options_Timer[100] then
                        HealBot_Options_Timer[100]=nil
                        HealBot_SetBuffBarColours()
                    elseif HealBot_Options_Timer[110] then
                        HealBot_Options_Timer[110]=nil
                        HealBot_Action_setRegisterForClicks()
                    elseif HealBot_Options_Timer[120] then
                        HealBot_Options_Timer[120]=nil
                        HealBot_CheckZone();
                    elseif HealBot_Options_Timer[122] then
                        HealBot_Options_Timer[122]=nil
                        HealBot_Comms_SendAddonMsg(HealBot_IncHeals_retAddonCommsID(), "I", HealBot_AddonMsgType, HealBot_PlayerName)
                    elseif HealBot_Options_Timer[125] then
                        HealBot_Options_Timer[125]=nil
                        if HealBot_retChangeNumBars() then
                            hbRequestTime=GetTime()+20
                            HealBot_setOptions_Timer(130)
                        end
                    elseif HealBot_Options_Timer[130] and hbRequestTime<GetTime() then
                        HealBot_Options_Timer[130]=nil
                        HealBot_Comms_SendAddonMsg("HealBot", "R", HealBot_AddonMsgType, HealBot_PlayerName)
                        HealBot_Comms_SendAddonMsg(HealBot_IncHeals_retAddonCommsID(), "I", HealBot_AddonMsgType, HealBot_PlayerName)
                    elseif HealBot_Options_Timer[140] and hbRequestTime<GetTime() then
                        HealBot_Options_Timer[140]=nil
                        if GetGuildInfo("player") then HealBot_Comms_SendAddonMsg("HealBot", "G", 5, HealBot_PlayerName) end
                        x=GetNumFriends()
                        if x>0 then
                            for y=1,x do
                                uName, _, _, _, z = GetFriendInfo(y)
                                if z then HealBot_Comms_SendAddonMsg("HealBot", "F", 4, uName) end
                            end
                        end
                        HealBot_TalentQuery("player")
                    elseif HealBot_Options_Timer[160] then
                        HealBot_Options_Timer[160]=nil
                        HealBot_Options_SetSkinBars()
                    elseif HealBot_Options_Timer[170] then
                        HealBot_Options_Timer[170]=nil                        
                        HealBot_configClassHoT(strsub(HealBot_PlayerClassEN,1,4), strsub(HealBot_PlayerRaceEN,1,3))
                    elseif  HealBot_Options_Timer[180] then
                        HealBot_Options_Timer[180]=nil
                        if Healbot_Config_Skins.HidePartyFrames[Healbot_Config_Skins.Current_Skin]==1 then
                            HealBot_Options_DisablePartyFrame()
                            HealBot_Options_PlayerTargetFrames:Enable();
                            HealBot_trackPartyFrames=true
                            if Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Current_Skin]==1 then
                                HealBot_Options_DisablePlayerFrame()
                                HealBot_Options_DisablePetFrame()
                                HealBot_Options_DisableTargetFrame()
                            else
                                HealBot_Options_EnablePlayerFrame()
                                HealBot_Options_EnablePetFrame()
                                HealBot_Options_EnableTargetFrame()
                            end
                        elseif HealBot_trackPartyFrames then
                            if Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Current_Skin]==1 then
                                HealBot_Options_EnablePlayerFrame();
                                HealBot_Options_EnablePetFrame()
                                HealBot_Options_EnableTargetFrame()
                                Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Current_Skin]=0;
                                HealBot_Options_PlayerTargetFrames:SetChecked(Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Current_Skin]);
                            end
                            HealBot_Options_PlayerTargetFrames:Disable();
                            HealBot_Options_EnablePartyFrame()
                            HealBot_trackPartyFrames=nil
                        end
                    elseif HealBot_Options_Timer[190] then
                        HealBot_Options_Timer[190]=nil
                        HealBot_Options_ShareSkin_Refresh()
                        HealBot_luVars["CheckSkin"]=true
                        if Delay_RecalcParty<1 then Delay_RecalcParty=1 end
                        HealBot_Loaded=9
                    elseif HealBot_Options_Timer[200] then
                        HealBot_talentSpam(HealBot_PlayerGUID,"update",1)
                        HealBot_TalentQuery("player")
                        HealBot_Options_Timer[200]=nil
                    elseif  HealBot_Options_Timer[400] then
                        HealBot_Options_Timer[400]=nil
                        HealBot_Action_SetAllAttribs()
                    elseif HealBot_Options_Timer[500] or HealBot_Options_Timer[501] then
                        if HealBot_Options_Timer[500] then
                            HealBot_SetResetFlag("SOFT")
                            ShowUIPanel(HealBot_Action)
                            HealBot_Options_Timer[500]=nil
                        else
                            HealBot_UnRegister_Events()
                            HealBot_Register_Events()
                            HideUIPanel(HealBot_Action)
                            HealBot_SetResetFlag("SOFT")
                            HealBot_Options_Timer[501]=nil
                        end
                    elseif  HealBot_Options_Timer[950] then
                        HealBot_Options_Timer[950]=nil
                        _,z = GetNumMacros()
                        if z>12 then
                            HealBot_AddDebug("Calling HealBot_useCrashProtection()")
                            HealBot_useCrashProtection()
                        end
                    elseif HealBot_Options_Timer[5000] then
                        HealBot_Set_Timers()
                        HealBot_Action_Set_Timers()
                        HealBot_Options_Timer[5000]=nil
                    end
                end
            elseif HealBot_luVars["IsReallyFighting"] then
                if not InCombatLockdown() then
                    HealBot_luVars["IsReallyFighting"] = nil
                    HealBot_IsFighting = nil;
                end
            end
            HealBot_SpamCnt = 0;
            for xGUID,bType in pairs(HealBot_BarCheck) do
                if Ti<5 then
                    if bType=="H" then
                        if HealBot_UnitID[xGUID] and UnitExists(HealBot_UnitID[xGUID]) then 
                            HealBot_OnEvent_UnitHealth(nil,HealBot_UnitID[xGUID],UnitHealth(HealBot_UnitID[xGUID]),UnitHealthMax(HealBot_UnitID[xGUID])) 
                        end
                    elseif bType=="P" then
                        if HealBot_UnitID[xGUID] and UnitExists(HealBot_UnitID[xGUID]) then 
                            HealBot_OnEvent_UnitMana(nil,HealBot_UnitID[xGUID],UnitPowerType(HealBot_UnitID[xGUID])); 
                        end
                    elseif HealBot_UnitID[xGUID] and UnitExists(HealBot_UnitID[xGUID]) then 
                        HealBot_OnEvent_UnitHealth(nil,HealBot_UnitID[xGUID],UnitHealth(HealBot_UnitID[xGUID]),UnitHealthMax(HealBot_UnitID[xGUID])) 
                        HealBot_OnEvent_UnitMana(nil,HealBot_UnitID[xGUID],UnitPowerType(HealBot_UnitID[xGUID])) 
                    end
                    HealBot_BarCheck[xGUID]=nil
                    Ti=Ti+1
                end
            end
            for xGUID in pairs(HealBot_Ressing) do
                if HealBot_Ressing[xGUID]=="_NIL_" then 
                    HealBot_Ressing[xGUID]=nil;
                    if HealBot_UnitID[xGUID] then HealBot_Action_ResetUnitStatus(HealBot_UnitID[xGUID]) end
                elseif HealBot_Ressing[xGUID]=="_RESSED3_" then 
                    HealBot_Ressing[xGUID]="_NIL_"
                elseif HealBot_Ressing[xGUID]=="_RESSED2_" then 
                    HealBot_Ressing[xGUID]="_RESSED3_"
                elseif HealBot_Ressing[xGUID]=="_RESSED1_" then 
                    HealBot_Ressing[xGUID]="_RESSED2_";
                elseif HealBot_Ressing[xGUID]=="_RESSED_" then 
                    HealBot_Ressing[xGUID]="_RESSED1_";
                end
            end
        end
        if HealBot_Timer3>=HB_Timer3 and HealBot_Loaded then
            HealBot_Timer3=0

            for xGUID in pairs(HealBot_Player_HoT) do
                huHoTtime=HealBot_Player_HoT[xGUID]
                for sName in pairs(huHoTtime) do
                    if huHoTtime[sName]<40 then
                        huHoTtime[sName]=huHoTtime[sName]-1
                        if huHoTtime[sName]<2 then
                            if HealBot_Player_HoT_Icons[xGUID][sName]>0 then
                                HealBot_HoT_Update(xGUID, sName)
                            else
                                huHoTtime[sName]=nil
                            end
                        end
                    elseif huHoTtime[sName]<=GetTime()+Healbot_Config_Skins.IconTextDurationShow[Healbot_Config_Skins.Current_Skin] then
                        HealBot_HoT_Update(xGUID, sName)
                    end
                end
            end
            
            for hbUID,xGUID in pairs(HealBot_HoTincHeals) do
                HealBot_HoT_incHealsCheck(xGUID, hbUID)
            end
            
            HealBot_ThrottleCnt=0
            for xUnit,z in pairs(HealBot_VehicleCheck) do
                if z<4 then
                    HealBot_VehicleCheck[xUnit]=HealBot_VehicleCheck[xUnit]+1
                else
                    HealBot_VehicleCheck[xUnit]=nil
                end
                HealBot_OnEvent_VehicleChange(nil, xUnit, true)
            end
            if HealBot_InCombatUpdate then
                HealBot_IC_PartyMembersChanged()
            end
            if HealBot_HelpCnt then
                HealBot_HelpCnt=HealBot_HelpCnt+1
                if HealBot_HelpCnt>#HEALBOT_HELP then
                    HealBot_HelpCnt=nil
                else
                    HealBot_AddChat(HEALBOT_HELP[HealBot_HelpCnt])
                end
            end
        end
        if HealBot_Timer2>HB_Timer2 then
            HealBot_Timer2=0
            aSwitch=aSwitch+1
            if aSwitch==1 then
                if HealBot_luVars["DelayAuraCheck"] then
                    HealBot_doAura()
                elseif HealBot_luVars["DelayClearAggro"] then
                    HealBot_doClearAggro()
                    aSwitch=aSwitch+1
                elseif HealBot_luVars["DelayDebuffCheck"] then
                    aSwitch=aSwitch+2
                    HealBot_doDebuff()
                elseif HealBot_luVars["DelayBuffCheck"] then  
                    aSwitch=aSwitch+3
                    HealBot_doBuff()
                else
                    aSwitch=aSwitch+4
                    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then 
                        HealBot_CheckAggro()
                    end
                end
            elseif aSwitch==2 then
                if HealBot_luVars["DelayClearAggro"] then
                    HealBot_doClearAggro()
                elseif HealBot_luVars["DelayDebuffCheck"] then
                    aSwitch=aSwitch+1
                    HealBot_doDebuff()
                elseif HealBot_luVars["DelayBuffCheck"] then  
                    aSwitch=aSwitch+2
                    HealBot_doBuff()
                else
                    aSwitch=aSwitch+3
                    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then 
                        HealBot_CheckAggro()
                    end
                end
            elseif aSwitch==3 then
                if HealBot_luVars["DelayDebuffCheck"] then
                    HealBot_doDebuff()
                elseif HealBot_luVars["DelayBuffCheck"] then
                    aSwitch=aSwitch+1
                    HealBot_doBuff()
                else
                    aSwitch=aSwitch+2
                    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then 
                        HealBot_CheckAggro()
                    end
                end
            elseif aSwitch==4 then
                if HealBot_luVars["DelayBuffCheck"] then
                    HealBot_doBuff()
                else
                    aSwitch=aSwitch+1
                    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then 
                        HealBot_CheckAggro()
                    end
                end
            elseif aSwitch==5 and Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then 
                HealBot_CheckAggro()
            else
                HealBot_Action_RefreshButtons()
                aSwitch=0
            end
            if HealBot_testBarInit[1] then
                HealBot_Action_setTestBar(HealBot_testBarInit[1])
                table.remove(HealBot_testBarInit,1)
            end
            for xGUID,xTime in pairs(hbDelayResetUnitStatus) do
                if xTime<GetTime() then 
                    if HealBot_UnitID[hbGUID] then HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID]) end
                    hbDelayResetUnitStatus[xGUID]=nil
                end
            end
        end
    end
end

function HealBot_doClearAggro()
    for xUnit,xGUID in pairs(HealBot_endAggro) do
        HealBot_ClearUnitAggro(xUnit, xGUID)
        HealBot_endAggro[xUnit] = nil
    end
    HealBot_luVars["DelayClearAggro"]=nil
end

function HealBot_doDebuff()
    for xGUID,xType in pairs(HealBot_DelayDebuffCheck) do
        if xType=="F" then 
            HealBot_CheckUnitDebuffs(xGUID)
            HealBot_DelayDebuffCheck[xGUID] = nil;
        end
    end
    HealBot_luVars["DelayDebuffCheck"]=nil
end

function HealBot_doBuff()
    for xGUID,xType in pairs(HealBot_DelayBuffCheck) do
        if xType=="F" then 
            HealBot_CheckUnitBuffs(xGUID)
            HealBot_DelayBuffCheck[xGUID] = nil;
        end
    end
    HealBot_luVars["DelayBuffCheck"]=nil
end

function HealBot_doAura()
    for xGUID,xUnit in pairs(HealBot_DelayAuraCheck) do
        if UnitIsVisible(xUnit) then 
            HealBot_HasMyBuffs(xGUID) 
        end
        HealBot_DelayAuraCheck[xGUID] = nil;
    end
    HealBot_luVars["DelayAuraCheck"]=nil
end

function HealBot_RetVersion()
    return HEALBOT_VERSION
end

function HealBot_OnEvent(self, event, ...)
    local arg1,arg2,arg3,arg4 = ...;
    if (event=="CHAT_MSG_ADDON") then
        HealBot_OnEvent_AddonMsg(self,arg1,arg2,arg3,arg4);
    elseif (event=="UNIT_AURA") then
        HealBot_OnEvent_UnitAura(self,arg1);
    elseif (event=="UNIT_HEALTH") or (event=="UNIT_MAXHEALTH") then
        HealBot_OnEvent_UnitHealth(self,arg1,UnitHealth(arg1),UnitHealthMax(arg1));
    elseif (event=="UnitHealthUpdated") then
        HealBot_OnEvent_UnitHealth(self,arg1,arg2,arg3);
    elseif (event=="UNIT_COMBAT") or (event=="UNIT_THREAT_SITUATION_UPDATE") then
        if arg1 then HealBot_OnEvent_UnitCombat(self,arg1); end
    elseif (event=="UNIT_SPELLCAST_START") then
        HealBot_OnEvent_UnitSpellcastStart(self,arg1,arg2)
    elseif (event=="UNIT_SPELLCAST_STOP") or (event=="UNIT_SPELLCAST_SUCCEEDED") then
        HealBot_OnEvent_UnitSpellcastStop(self,arg1,arg2);
    elseif (event=="UNIT_SPELLCAST_FAILED") or (event=="UNIT_SPELLCAST_INTERRUPTED") then
        HealBot_OnEvent_UnitSpellcastFail(self,arg1,arg2);
    elseif (event=="UNIT_SPELLCAST_SENT") then
        HealBot_OnEvent_UnitSpellcastSent(self,arg1,arg2,arg3,arg4);  
    elseif (event=="PLAYER_REGEN_DISABLED") then
        HealBot_OnEvent_PlayerRegenDisabled(self);
    elseif (event=="PLAYER_REGEN_ENABLED") then
        HealBot_OnEvent_PlayerRegenEnabled(self);
    elseif (event=="UNIT_NAME_UPDATE") then
        HealBot_OnEvent_UnitNameUpdate(self,arg1)
    elseif (event=="UNIT_MANA") or (event=="UNIT_RAGE") or (event=="UNIT_ENERGY") or (event=="UNIT_RUNIC_POWER") or (event=="UNIT_MAXRAGE") or (event=="UNIT_MAXENERGY") or (event=="UNIT_MAXRUNIC_POWER") then
        HealBot_OnEvent_UnitMana(self,arg1);
    elseif (event=="UNIT_MAXMANA") then 
        HealBot_OnEvent_UnitMaxMana(self,arg1);
    elseif (event=="CHAT_MSG_SYSTEM") then
        HealBot_OnEvent_SystemMsg(self,arg1);
    elseif (event=="PARTY_MEMBERS_CHANGED") then
        HealBot_OnEvent_PartyMembersChanged(self);
    elseif (event=="RAID_TARGET_UPDATE") then
        if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_RaidTargetUpdate(self); end
    elseif (event=="PLAYER_TARGET_CHANGED") then
        HealBot_OnEvent_PlayerTargetChanged(self);
    elseif (event=="PLAYER_FOCUS_CHANGED") then
        HealBot_OnEvent_FocusChanged(self);
    elseif (event=="MODIFIER_STATE_CHANGED") then
        HealBot_OnEvent_ModifierStateChange(self,arg1,arg2);
    elseif (event=="UNIT_INVENTORY_CHANGED") then
        HealBot_OnEvent_PlayerEquipmentChanged(self,arg1);
    elseif (event=="UNIT_PET") then
        HealBot_OnEvent_PartyPetChanged(self);
    elseif (event=="RAID_ROSTER_UPDATE") then
        HealBot_OnEvent_RaidRosterUpdate(self);
    elseif (event=="LEARNED_SPELL_IN_TAB") then
        HealBot_OnEvent_SpellsChanged(self,arg1);
    elseif (event=="UNIT_ENTERED_VEHICLE") then
        HealBot_OnEvent_VehicleChange(self, arg1, true)
    elseif (event=="UNIT_EXITED_VEHICLE") then
        HealBot_OnEvent_VehicleChange(self, arg1, nil)
    elseif (event=="UNIT_EXITING_VEHICLE") then
        HealBot_OnEvent_LeavingVehicle(self, arg1)
    elseif (event=="PLAYER_ENTERING_WORLD") then
        HealBot_OnEvent_PlayerEnteringWorld(self);
    elseif (event=="PLAYER_LEAVING_WORLD") then
        HealBot_OnEvent_PlayerLeavingWorld(self);
    elseif (event=="CHARACTER_POINTS_CHANGED") then
        HealBot_OnEvent_TalentsChanged(self);
    elseif (event=="TalentQuery_Ready") or (event=="TalentQuery_Ready_Outsider") then
        HealBot_GetUnitTalentInfo(arg1, arg2, arg3)
    elseif (event=="ZONE_CHANGED_NEW_AREA") then
        HealBot_OnEvent_ZoneChanged(self);
    elseif (event=="READY_CHECK") then
        HealBot_OnEvent_ReadyCheck(self,arg1,arg2);
    elseif (event=="READY_CHECK_CONFIRM") then
        HealBot_OnEvent_ReadyCheckConfirmed(self,arg1,arg2);
    elseif (event=="READY_CHECK_FINISHED") then
        HealBot_OnEvent_ReadyCheckFinished(self);
    elseif (event=="UPDATE_MACROS") then
        HealBot_setOptions_Timer(950)
    elseif (event=="VARIABLES_LOADED") then
        HealBot_OnEvent_VariablesLoaded(self);
    else
        HealBot_AddDebug("OnEvent (" .. event .. ")");
    end
end

function HealBot_OnEvent_VariablesLoaded(self)
    table.foreach(HealBot_ConfigDefaults, function (key,val)
        if not HealBot_Config[key] then
            HealBot_Config[key] = val;
        end
    end);
    table.foreach(HealBot_GlobalsDefaults, function (key,val)
        if not HealBot_Globals[key] then
            HealBot_Globals[key] = val;
        end
    end);
    table.foreach(HealBot_Config_SkinsDefaults, function (key,val)
        if not Healbot_Config_Skins[key] then
            Healbot_Config_Skins[key] = val;
        end
    end);
    if HealBot_Config.HealBot_Enable_MouseWheel==1 then
        HealBot_Action:EnableMouseWheel(1)  
        HealBot_Action:SetScript("OnMouseWheel", function(self, delta)
            HealBot_Action_HealUnit_Wheel(delta)
        end)
    end
    HealBot_Update_Skins()    
    HealBot_PlayerClass, HealBot_PlayerClassEN=UnitClass("player")
    HealBot_PlayerRace, HealBot_PlayerRaceEN=UnitRace("player")
    HealBot_PlayerName=UnitName("player")
    HealBot_InitSpells()
    HealBot_Options_InitBuffClassList()
    HealBot_Vers[HealBot_PlayerName]=HEALBOT_VERSION
	HealBot_luVars["TargetUnitID"]="player"
    if strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_ShortBuffs[HEALBOT_SHADOW_PROTECTION]=true
        HealBot_ShortBuffs[HEALBOT_LEVITATE]=true
        HealBot_BuffNameSwap = {[HEALBOT_POWER_WORD_FORTITUDE] = HEALBOT_PRAYER_OF_FORTITUDE,
                                [HEALBOT_PRAYER_OF_FORTITUDE] = HEALBOT_POWER_WORD_FORTITUDE,
                                [HEALBOT_SHADOW_PROTECTION] = HEALBOT_PRAYER_OF_SHADOW_PROTECTION,
                                [HEALBOT_PRAYER_OF_SHADOW_PROTECTION] = HEALBOT_SHADOW_PROTECTION,
                                [HEALBOT_DIVINE_SPIRIT] = HEALBOT_PRAYER_OF_SPIRIT,
                                [HEALBOT_PRAYER_OF_SPIRIT] = HEALBOT_DIVINE_SPIRIT}
        HealBot_Talents[HEALBOT_IMPROVED_RENEW]=0
        HealBot_Talents[HEALBOT_EMPOWERED_RENEW]=0
        HealBot_Talents[HEALBOT_TWIN_DISCIPLINES]=0
        HealBot_Talents[HEALBOT_SPIRITAL_HEALING]=0
        HealBot_Talents[HEALBOT_EMPOWERED_HEALING]=0
        HealBot_Talents[HEALBOT_BLESSED_RESILIENCE]=0
        HealBot_Talents[HEALBOT_DIVINE_PROVIDENCE]=0
        HealBot_Talents[HEALBOT_FOCUSED_POWER]=0
    elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_ShortBuffs[HEALBOT_THORNS]=true
        HealBot_BuffNameSwap = {[HEALBOT_MARK_OF_THE_WILD] = HEALBOT_GIFT_OF_THE_WILD,
                                [HEALBOT_GIFT_OF_THE_WILD] = HEALBOT_MARK_OF_THE_WILD}
        HealBot_Talents[HEALBOT_GENESIS]=0
        HealBot_Talents[HEALBOT_NURTURING_INSTINCT]=0
        HealBot_Talents[HEALBOT_IMPROVED_REJUVENATION]=0
        HealBot_Talents[HEALBOT_GIFT_OF_NATURE]=0
        HealBot_Talents[HEALBOT_EMPOWERED_TOUCH]=0
        HealBot_Talents[HEALBOT_EMPOWERED_REJUVENATION]=0
        HealBot_Talents[HEALBOT_MASTER_SHAPESHIFTER]=0
    elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_ShortBuffs[HEALBOT_BLESSING_OF_MIGHT]=true
        HealBot_ShortBuffs[HEALBOT_BLESSING_OF_WISDOM]=true
        HealBot_ShortBuffs[HEALBOT_BLESSING_OF_SANCTUARY]=true
        HealBot_ShortBuffs[HEALBOT_BLESSING_OF_PROTECTION]=true
        HealBot_ShortBuffs[HEALBOT_BLESSING_OF_KINGS]=true
        HealBot_ShortBuffs[HEALBOT_BEACON_OF_LIGHT]=true
        HealBot_ShortBuffs[HEALBOT_SACRED_SHIELD]=true
        HealBot_ShortBuffs[HEALBOT_SEAL_OF_RIGHTEOUSNESS]=true
        HealBot_ShortBuffs[HEALBOT_SEAL_OF_BLOOD]=true
        HealBot_ShortBuffs[HEALBOT_SEAL_OF_CORRUPTION]=true
        HealBot_ShortBuffs[HEALBOT_SEAL_OF_JUSTICE]=true
        HealBot_ShortBuffs[HEALBOT_SEAL_OF_LIGHT]=true
        HealBot_ShortBuffs[HEALBOT_SEAL_OF_VENGEANCE]=true
        HealBot_ShortBuffs[HEALBOT_SEAL_OF_WISDOM]=true
        HealBot_ShortBuffs[HEALBOT_SEAL_OF_COMMAND]=true
        HealBot_ShortBuffs[HEALBOT_SEAL_OF_THE_MARTYR]=true
        HealBot_BuffNameSwap = {[HEALBOT_BLESSING_OF_MIGHT] = HEALBOT_GREATER_BLESSING_OF_MIGHT,
                                [HEALBOT_GREATER_BLESSING_OF_MIGHT] = HEALBOT_BLESSING_OF_MIGHT,
                                [HEALBOT_BLESSING_OF_WISDOM] = HEALBOT_GREATER_BLESSING_OF_WISDOM,
                                [HEALBOT_GREATER_BLESSING_OF_WISDOM] = HEALBOT_BLESSING_OF_WISDOM,
                                [HEALBOT_BLESSING_OF_KINGS] = HEALBOT_GREATER_BLESSING_OF_KINGS,
                                [HEALBOT_GREATER_BLESSING_OF_KINGS] = HEALBOT_BLESSING_OF_KINGS,
                                [HEALBOT_BLESSING_OF_SANCTUARY] = HEALBOT_GREATER_BLESSING_OF_SANCTUARY,
                                [HEALBOT_GREATER_BLESSING_OF_SANCTUARY] = HEALBOT_BLESSING_OF_SANCTUARY}
        HealBot_Talents[HEALBOT_HEALING_LIGHT]=0
        HealBot_Talents[HEALBOT_DIVINITY]=0
        HealBot_Talents[HEALBOT_TOUCHED_BY_THE_LIGHT]=0
        HealBot_Talents[HEALBOT_HOLY_GUIDANCE]=0
    elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_ShortBuffs[HEALBOT_ANCESTRAL_FORTITUDE]=true
        HealBot_Talents[HEALBOT_PURIFICATION]=0
        HealBot_Talents[HEALBOT_IMPROVED_CHAIN_HEAL]=0
        HealBot_Talents[HEALBOT_TIDAL_WAVES]=0
        HealBot_Talents[HEALBOT_HEALING_WAY]=0
        HealBot_Talents[HEALBOT_NATURES_BLESSING]=0
    elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_WARRIOR] then
        HealBot_HoT_Texture[HEALBOT_VIGILANCE] = "Interface\\Icons\\Ability_Warrior_Vigilance";
        HealBot_ShortBuffs[HEALBOT_BATTLE_SHOUT]=true
        HealBot_ShortBuffs[HEALBOT_COMMANDING_SHOUT]=true
    end
    if HealBot_Config.EnLibQuickHealth==1 then
        QuickHealth.RegisterCallback(self, "UnitHealthUpdated", function(event, unitID, health, healthMax)
            HealBot_OnEvent(self, "UnitHealthUpdated", unitID, health, healthMax)
        end);
    else
        QuickHealth.eventFrame:UnregisterAllEvents()
    end
    TalentQuery.RegisterCallback(self, "TalentQuery_Ready", function(event, name, realm, unitid)
        HealBot_OnEvent(self, "TalentQuery_Ready", name, realm, unitid)
    end);
    TalentQuery.RegisterCallback(self, "TalentQuery_Ready_Outsider", function(event, name, realm, unitid)
        HealBot_OnEvent(self, "TalentQuery_Ready_Outsider", name, realm, unitid)
    end);
    HealBot_IncHeals_Init()
    HealBot_Options_HealCommMethod_SetWarning()
    HealBot_Options_Init(1)
    HealBot_Options_Init(9)
    HealBot_setOptions_Timer(60)
    HealBot_setOptions_Timer(70)
    HealBot_setOptions_Timer(50)
    HealBot_setOptions_Timer(40)
    HealBot_setOptions_Timer(85)
    HealBot_Action_setRegisterForClicks()
    HealBot:RegisterEvent("PLAYER_ENTERING_WORLD");
    HealBot:RegisterEvent("PLAYER_LEAVING_WORLD");
    HealBot_Tooltip:SetBackdropColor(0,0,0,HealBot_Config.ttalpha)
    bar = HealBot_Action_HealthBar(HealBot_Action_OptionsButton);
    bar:SetStatusBarColor(0.1,0.1,0.4,0);
    bar.txt = _G[bar:GetName().."_text"];
    bar.txt:SetTextColor(0.8,0.8,0.2,0.85);
    bar.txt:SetText(HEALBOT_ACTION_OPTIONS);
    HealBot_EnTextColorpickt:SetText(HEALBOT_SKIN_ENTEXT);
    HealBot_DisTextColorpickt:SetText(HEALBOT_SKIN_DISTEXT);
    HealBot_DebTextColorpickt:SetText(HEALBOT_SKIN_DEBTEXT);
    HealBot_Loaded=1;
    HealBot_Action_ResetSkin("init")
    HealBot_Init_SetSpec()
    HealBot_CheckFrame()
    HealBot_setOptions_Timer(5)
    HealBot_CheckMyBuffs(HealBot_PlayerGUID)
    HealBot_Action_SetDebuffAggroCols()
    HealBot_Action_SetHightlightAggroCols()
    HealBot_Action_SetAggroCols()
    HealBot_Panel_SetNumBars(HealBot_Config.noTestBars)
    HealBot_Options_Class_HoTctlText:SetText(HealBot_PlayerClass.." "..HEALBOT_ACTION_OPTIONS);
    HealBot_Action_sethbNumberFormat()
    HealBot_Panel_SethbTopRole(HealBot_Globals.TopRole)
    HealBot_CureFrameSelectWarningFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_CureFrameSelectCustomFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_CureFrameSelectDebuffFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsFrameSelectIconsFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsFrameSelectTextFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsFrameSelectBarsFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsFrameSelectHeadersFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsFrameSelectChatFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsFrameSelectIncHealsFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsFrameSelectHealingFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsFrameSelectGeneralFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsFrameSelectAggroFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsFrameSelectIconTextFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsSubFrameSelectHealAlertFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsSubFrameSelectHealRaidFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_SkinsSubFrameSelectHealSortFrame:GetStatusBarTexture():SetHorizTile(false)
    HealBot_MMButton_Init();
    HealBot_setOptions_Timer(200)
    HealBot_luVars["UseCrashProtection"]=GetTime()+HealBot_Config.CrashProtStartTime
end

function HealBot_useCrashProtection()
    _,z = GetNumMacros()
    x=18-z
    if Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]==1 then
        y=0
        for z=0,5 do
            w=GetMacroBody(HealBot_Config.CrashProtMacroName.."_"..z)
            if w then
                x=x+1
            end
        end
    end
    if x<5 then
        Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]=0
        HealBot_Options_CrashProt:SetChecked(Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin])
        HealBot_Options_CrashProt:Disable();
    end
end

function HealBot_Load(hbCaller)
    HealBot_useCrashProtection()
    HealBot_Options_Set_Current_Skin()
    if not HealBot_Config.DisabledKeyCombo then 
        HealBot_InitNewChar(HealBot_PlayerClassEN)
    else
        HealBot_Options_SetSkins();
    end
    HealBot_PlayerGUID=UnitGUID("player")
    HealBot_PlayerBuff[HealBot_PlayerGUID]={}
    if Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==0 then HealBot_Config.ActionVisible=1; end
    if HealBot_Config.DisableHealBot==0 and HealBot_Config.ActionVisible==1 then HealBot_Action:Show() end
    if not HealBot_IsFighting then
        HealBot_RecalcParty(nil);
    else
        HealBot_RecalcParty(true);
    end
    HealBot_configClassHoT(strsub(HealBot_PlayerClassEN,1,4), strsub(HealBot_PlayerRaceEN,1,3))
    HealBot_CheckTalents=true
    if HealBot_AddonMsgType==2 then HealBot_Comms_SendAddonMsg("CTRA", "SR", HealBot_AddonMsgType, HealBot_PlayerName) end
    HealBot_AddChat("  "..HEALBOT_ADDON .. HEALBOT_LOADED);
    HealBot_AddChat(HEALBOT_HELP[1])
    HealBot_Panel_SetmaxHealDiv(UnitLevel("player"))
    HealBot_Options_RaidTargetUpdate()
    HealBot_Loaded=2
    HealBot_IncHeals_allLoaded()
    if hbCaller~="playerEW" then
        HealBot_OnEvent_PlayerEnteringWorld()
    end
    HealBot_setOptions_Timer(140)
    HealBot_Set_Timers()
end

local hbClassHoTwatch={}
function HealBot_configClassHoT(class, race)
    hbClassHoTwatch=HealBot_Globals.WatchHoT[class]

    if hbClassHoTwatch[HEALBOT_GUARDIAN_SPIRIT]==3 then
        HealBot_Watch_HoT[HEALBOT_GUARDIAN_SPIRIT]="A"
    elseif hbClassHoTwatch[HEALBOT_GUARDIAN_SPIRIT]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_GUARDIAN_SPIRIT]="C"
    else
        HealBot_Watch_HoT[HEALBOT_GUARDIAN_SPIRIT]=nil
    end
    if hbClassHoTwatch[HEALBOT_PAIN_SUPPRESSION]==3 then
        HealBot_Watch_HoT[HEALBOT_PAIN_SUPPRESSION]="A"
    elseif hbClassHoTwatch[HEALBOT_PAIN_SUPPRESSION]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_PAIN_SUPPRESSION]="C"
    else
        HealBot_Watch_HoT[HEALBOT_PAIN_SUPPRESSION]=nil
    end
    if hbClassHoTwatch[HEALBOT_POWER_INFUSION]==3 then
        HealBot_Watch_HoT[HEALBOT_POWER_INFUSION]="A"
    elseif hbClassHoTwatch[HEALBOT_POWER_INFUSION]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_POWER_INFUSION]="C"
    else
        HealBot_Watch_HoT[HEALBOT_POWER_INFUSION]=nil
    end
    if hbClassHoTwatch[HEALBOT_RENEW]==3 then
        HealBot_Watch_HoT[HEALBOT_RENEW]="A"
    elseif hbClassHoTwatch[HEALBOT_RENEW]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_RENEW]="C"
    else
        HealBot_Watch_HoT[HEALBOT_RENEW]=nil
    end
    if hbClassHoTwatch[HEALBOT_ABOLISH_DISEASE]==3 then
        HealBot_Watch_HoT[HEALBOT_ABOLISH_DISEASE]="A"
    elseif hbClassHoTwatch[HEALBOT_ABOLISH_DISEASE]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_ABOLISH_DISEASE]="C"
    else
        HealBot_Watch_HoT[HEALBOT_ABOLISH_DISEASE]=nil
    end
    if hbClassHoTwatch[HEALBOT_POWER_WORD_SHIELD]==3 then
        HealBot_Watch_HoT[HEALBOT_POWER_WORD_SHIELD]="A"
    elseif hbClassHoTwatch[HEALBOT_POWER_WORD_SHIELD]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_POWER_WORD_SHIELD]="C"
    else
        HealBot_Watch_HoT[HEALBOT_POWER_WORD_SHIELD]=nil
    end
    if hbClassHoTwatch[HEALBOT_PRAYER_OF_MENDING]==3 then
        HealBot_Watch_HoT[HEALBOT_PRAYER_OF_MENDING]="A"
    elseif hbClassHoTwatch[HEALBOT_PRAYER_OF_MENDING]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_PRAYER_OF_MENDING]="C"
    else
        HealBot_Watch_HoT[HEALBOT_PRAYER_OF_MENDING]=nil
    end
    if hbClassHoTwatch[HEALBOT_GRACE]==3 then
        HealBot_Watch_HoT[HEALBOT_GRACE]="A"
    elseif hbClassHoTwatch[HEALBOT_GRACE]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_GRACE]="C"
    else
        HealBot_Watch_HoT[HEALBOT_GRACE]=nil
    end
    if hbClassHoTwatch[HEALBOT_LIGHTWELL_RENEW]==3 then
        HealBot_Watch_HoT[HEALBOT_LIGHTWELL_RENEW]="A"
    elseif hbClassHoTwatch[HEALBOT_LIGHTWELL_RENEW]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_LIGHTWELL_RENEW]="C"
    else
        HealBot_Watch_HoT[HEALBOT_LIGHTWELL_RENEW]=nil
    end
    if hbClassHoTwatch[HEALBOT_SURGE_OF_LIGHT]==3 then
        HealBot_Watch_HoT[HEALBOT_SURGE_OF_LIGHT]="A"
    elseif hbClassHoTwatch[HEALBOT_SURGE_OF_LIGHT]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_SURGE_OF_LIGHT]="C"
    else
        HealBot_Watch_HoT[HEALBOT_SURGE_OF_LIGHT]=nil
    end
    if hbClassHoTwatch[HEALBOT_INSPIRATION]==3 then
        HealBot_Watch_HoT[HEALBOT_INSPIRATION]="A"
    elseif hbClassHoTwatch[HEALBOT_INSPIRATION]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_INSPIRATION]="C"
    else
        HealBot_Watch_HoT[HEALBOT_INSPIRATION]=nil
    end
    if hbClassHoTwatch[HEALBOT_DIVINE_AEGIS]==3 then
        HealBot_Watch_HoT[HEALBOT_DIVINE_AEGIS]="A"
    elseif hbClassHoTwatch[HEALBOT_DIVINE_AEGIS]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_DIVINE_AEGIS]="C"
    else
        HealBot_Watch_HoT[HEALBOT_DIVINE_AEGIS]=nil
    end
    if hbClassHoTwatch[HEALBOT_FEAR_WARD]==3 then
        HealBot_Watch_HoT[HEALBOT_FEAR_WARD]="A"
    elseif hbClassHoTwatch[HEALBOT_FEAR_WARD]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_FEAR_WARD]="C"
    else
        HealBot_Watch_HoT[HEALBOT_FEAR_WARD]=nil
    end
    if hbClassHoTwatch[HEALBOT_BLESSED_HEALING]==3 then
        HealBot_Watch_HoT[HEALBOT_BLESSED_HEALING]="A"
    elseif hbClassHoTwatch[HEALBOT_BLESSED_HEALING]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_BLESSED_HEALING]="C"
    else
        HealBot_Watch_HoT[HEALBOT_BLESSED_HEALING]=nil
    end
    if hbClassHoTwatch[HEALBOT_INNER_FOCUS]==3 then
        HealBot_Watch_HoT[HEALBOT_INNER_FOCUS]="A"
    elseif hbClassHoTwatch[HEALBOT_INNER_FOCUS]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_INNER_FOCUS]="C"
    else
        HealBot_Watch_HoT[HEALBOT_INNER_FOCUS]=nil
    end
    if hbClassHoTwatch[HEALBOT_SERENDIPITY]==3 then
        HealBot_Watch_HoT[HEALBOT_SERENDIPITY]="A"
    elseif hbClassHoTwatch[HEALBOT_SERENDIPITY]==2 and class==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_Watch_HoT[HEALBOT_SERENDIPITY]="C"
    else
        HealBot_Watch_HoT[HEALBOT_SERENDIPITY]=nil
    end
    if hbClassHoTwatch[HEALBOT_REJUVENATION]==3 then
        HealBot_Watch_HoT[HEALBOT_REJUVENATION]="A"
    elseif hbClassHoTwatch[HEALBOT_REJUVENATION]==2 and class==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_Watch_HoT[HEALBOT_REJUVENATION]="C"
    else
        HealBot_Watch_HoT[HEALBOT_REJUVENATION]=nil
    end
    if hbClassHoTwatch[HEALBOT_LIVING_SEED]==3 then
        HealBot_Watch_HoT[HEALBOT_LIVING_SEED]="A"
    elseif hbClassHoTwatch[HEALBOT_LIVING_SEED]==2 and class==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_Watch_HoT[HEALBOT_LIVING_SEED]="C"
    else
        HealBot_Watch_HoT[HEALBOT_LIVING_SEED]=nil
    end
    if hbClassHoTwatch[HEALBOT_REGROWTH]==3 then
        HealBot_Watch_HoT[HEALBOT_REGROWTH]="A"
    elseif hbClassHoTwatch[HEALBOT_REGROWTH]==2 and class==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_Watch_HoT[HEALBOT_REGROWTH]="C"
    else
        HealBot_Watch_HoT[HEALBOT_REGROWTH]=nil
    end
    if hbClassHoTwatch[HEALBOT_NATURE_SWIFTNESS]==3 then
        HealBot_Watch_HoT[HEALBOT_NATURE_SWIFTNESS]="A"
    elseif hbClassHoTwatch[HEALBOT_NATURE_SWIFTNESS]==2 and (class==HealBot_Class_En[HEALBOT_DRUID] or class==HealBot_Class_En[HEALBOT_SHAMAN]) then
        HealBot_Watch_HoT[HEALBOT_NATURE_SWIFTNESS]="C"
    else
        HealBot_Watch_HoT[HEALBOT_NATURE_SWIFTNESS]=nil
    end
    if hbClassHoTwatch[HEALBOT_LIFEBLOOM]==3 then
        HealBot_Watch_HoT[HEALBOT_LIFEBLOOM]="A"
    elseif hbClassHoTwatch[HEALBOT_LIFEBLOOM]==2 and class==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_Watch_HoT[HEALBOT_LIFEBLOOM]="C"
    else
        HealBot_Watch_HoT[HEALBOT_LIFEBLOOM]=nil
    end
    if hbClassHoTwatch[HEALBOT_ABOLISH_POISON]==3 then
        HealBot_Watch_HoT[HEALBOT_ABOLISH_POISON]="A"
    elseif hbClassHoTwatch[HEALBOT_ABOLISH_POISON]==2 and class==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_Watch_HoT[HEALBOT_ABOLISH_POISON]="C"
    else
        HealBot_Watch_HoT[HEALBOT_ABOLISH_POISON]=nil
    end
    if hbClassHoTwatch[HEALBOT_WILD_GROWTH]==3 then
        HealBot_Watch_HoT[HEALBOT_WILD_GROWTH]="A"
    elseif hbClassHoTwatch[HEALBOT_WILD_GROWTH]==2 and class==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_Watch_HoT[HEALBOT_WILD_GROWTH]="C"
    else
        HealBot_Watch_HoT[HEALBOT_WILD_GROWTH]=nil
    end
    if hbClassHoTwatch[HEALBOT_TRANQUILITY]==3 then
        HealBot_Watch_HoT[HEALBOT_TRANQUILITY]="A"
    elseif hbClassHoTwatch[HEALBOT_TRANQUILITY]==2 and class==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_Watch_HoT[HEALBOT_TRANQUILITY]="C"
    else
        HealBot_Watch_HoT[HEALBOT_TRANQUILITY]=nil
    end
    if hbClassHoTwatch[HEALBOT_THORNS]==3 then
        HealBot_Watch_HoT[HEALBOT_THORNS]="A"
    elseif hbClassHoTwatch[HEALBOT_THORNS]==2 and class==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_Watch_HoT[HEALBOT_THORNS]="C"
    else
        HealBot_Watch_HoT[HEALBOT_THORNS]=nil
    end
    if hbClassHoTwatch[HEALBOT_BARKSKIN]==3 then
        HealBot_Watch_HoT[HEALBOT_BARKSKIN]="A"
    elseif hbClassHoTwatch[HEALBOT_BARKSKIN]==2 and class==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_Watch_HoT[HEALBOT_BARKSKIN]="C"
    else
        HealBot_Watch_HoT[HEALBOT_BARKSKIN]=nil
    end
    if hbClassHoTwatch[HEALBOT_SURVIVAL_INSTINCTS]==3 then
        HealBot_Watch_HoT[HEALBOT_SURVIVAL_INSTINCTS]="A"
    elseif hbClassHoTwatch[HEALBOT_SURVIVAL_INSTINCTS]==2 and class==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_Watch_HoT[HEALBOT_SURVIVAL_INSTINCTS]="C"
    else
        HealBot_Watch_HoT[HEALBOT_SURVIVAL_INSTINCTS]=nil
    end
    if hbClassHoTwatch[HEALBOT_FRENZIED_REGEN]==3 then
        HealBot_Watch_HoT[HEALBOT_FRENZIED_REGEN]="A"
    elseif hbClassHoTwatch[HEALBOT_FRENZIED_REGEN]==2 and class==HealBot_Class_En[HEALBOT_DRUID] then
        HealBot_Watch_HoT[HEALBOT_FRENZIED_REGEN]="C"
    else
        HealBot_Watch_HoT[HEALBOT_FRENZIED_REGEN]=nil
    end
    if hbClassHoTwatch[HEALBOT_FLASH_OF_LIGHT]==3 then
        HealBot_Watch_HoT[HEALBOT_FLASH_OF_LIGHT]="A"
    elseif hbClassHoTwatch[HEALBOT_FLASH_OF_LIGHT]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_FLASH_OF_LIGHT]="C"
    else
        HealBot_Watch_HoT[HEALBOT_FLASH_OF_LIGHT]=nil
    end
    if hbClassHoTwatch[HEALBOT_BEACON_OF_LIGHT]==3 then
        HealBot_Watch_HoT[HEALBOT_BEACON_OF_LIGHT]="A"
    elseif hbClassHoTwatch[HEALBOT_BEACON_OF_LIGHT]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_BEACON_OF_LIGHT]="C"
    else
        HealBot_Watch_HoT[HEALBOT_BEACON_OF_LIGHT]=nil
    end
    if hbClassHoTwatch[HEALBOT_SACRED_SHIELD]==3 then
        HealBot_Watch_HoT[HEALBOT_SACRED_SHIELD]="A"
    elseif hbClassHoTwatch[HEALBOT_SACRED_SHIELD]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_SACRED_SHIELD]="C"
    else
        HealBot_Watch_HoT[HEALBOT_SACRED_SHIELD]=nil
    end
    if hbClassHoTwatch[HEALBOT_HAND_OF_FREEDOM]==3 then
        HealBot_Watch_HoT[HEALBOT_HAND_OF_FREEDOM]="A"
    elseif hbClassHoTwatch[HEALBOT_HAND_OF_FREEDOM]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_HAND_OF_FREEDOM]="C"
    else
        HealBot_Watch_HoT[HEALBOT_HAND_OF_FREEDOM]=nil
    end
    if hbClassHoTwatch[HEALBOT_SACRED_CLEANSING]==3 then
        HealBot_Watch_HoT[HEALBOT_SACRED_CLEANSING]="A"
    elseif hbClassHoTwatch[HEALBOT_SACRED_CLEANSING]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_SACRED_CLEANSING]="C"
    else
        HealBot_Watch_HoT[HEALBOT_SACRED_CLEANSING]=nil
    end
    if hbClassHoTwatch[HEALBOT_LIGHT_BEACON]==3 then
        HealBot_Watch_HoT[HEALBOT_LIGHT_BEACON]="A"
    elseif hbClassHoTwatch[HEALBOT_LIGHT_BEACON]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_LIGHT_BEACON]="C"
    else
        HealBot_Watch_HoT[HEALBOT_LIGHT_BEACON]=nil
    end
    if hbClassHoTwatch[HEALBOT_HANDOFPROTECTION]==3 then
        HealBot_Watch_HoT[HEALBOT_HANDOFPROTECTION]="A"
    elseif hbClassHoTwatch[HEALBOT_HANDOFPROTECTION]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_HANDOFPROTECTION]="C"
    else
        HealBot_Watch_HoT[HEALBOT_HANDOFPROTECTION]=nil
    end
    if hbClassHoTwatch[HEALBOT_IMPROVED_LAY_ON_HANDS]==3 then
        HealBot_Watch_HoT[HEALBOT_IMPROVED_LAY_ON_HANDS]="A"
    elseif hbClassHoTwatch[HEALBOT_IMPROVED_LAY_ON_HANDS]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_IMPROVED_LAY_ON_HANDS]="C"
    else
        HealBot_Watch_HoT[HEALBOT_IMPROVED_LAY_ON_HANDS]=nil
    end
    if hbClassHoTwatch[HEALBOT_HAND_OF_SALVATION]==3 then
        HealBot_Watch_HoT[HEALBOT_HAND_OF_SALVATION]="A"
    elseif hbClassHoTwatch[HEALBOT_HAND_OF_SALVATION]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_HAND_OF_SALVATION]="C"
    else
        HealBot_Watch_HoT[HEALBOT_HAND_OF_SALVATION]=nil
    end
    if hbClassHoTwatch[HEALBOT_DIVINE_SHIELD]==3 then
        HealBot_Watch_HoT[HEALBOT_DIVINE_SHIELD]="A"
    elseif hbClassHoTwatch[HEALBOT_DIVINE_SHIELD]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_DIVINE_SHIELD]="C"
    else
        HealBot_Watch_HoT[HEALBOT_DIVINE_SHIELD]=nil
    end
    if hbClassHoTwatch[HEALBOT_HAND_OF_SACRIFICE]==3 then
        HealBot_Watch_HoT[HEALBOT_HAND_OF_SACRIFICE]="A"
    elseif hbClassHoTwatch[HEALBOT_HAND_OF_SACRIFICE]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_HAND_OF_SACRIFICE]="C"
    else
        HealBot_Watch_HoT[HEALBOT_HAND_OF_SACRIFICE]=nil
    end
    if hbClassHoTwatch[HEALBOT_BLESSED]==3 then
        HealBot_Watch_HoT[HEALBOT_BLESSED]="A"
    elseif hbClassHoTwatch[HEALBOT_BLESSED]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_BLESSED]="C"
    else
        HealBot_Watch_HoT[HEALBOT_BLESSED]=nil
    end
    if hbClassHoTwatch[HEALBOT_INFUSION_OF_LIGHT]==3 then
        HealBot_Watch_HoT[HEALBOT_INFUSION_OF_LIGHT]="A"
    elseif hbClassHoTwatch[HEALBOT_INFUSION_OF_LIGHT]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_INFUSION_OF_LIGHT]="C"
    else
        HealBot_Watch_HoT[HEALBOT_INFUSION_OF_LIGHT]=nil
    end
    if hbClassHoTwatch[HEALBOT_DIVINE_PROTECTION]==3 then
        HealBot_Watch_HoT[HEALBOT_DIVINE_PROTECTION]="A"
    elseif hbClassHoTwatch[HEALBOT_DIVINE_PROTECTION]==2 and class==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_Watch_HoT[HEALBOT_DIVINE_PROTECTION]="C"
    else
        HealBot_Watch_HoT[HEALBOT_DIVINE_PROTECTION]=nil
    end
    if hbClassHoTwatch[HEALBOT_MENDPET]==3 then
        HealBot_Watch_HoT[HEALBOT_MENDPET]="A"
    elseif hbClassHoTwatch[HEALBOT_MENDPET]==2 and class==HealBot_Class_En[HEALBOT_HUNTER] then
        HealBot_Watch_HoT[HEALBOT_MENDPET]="C"
    else
        HealBot_Watch_HoT[HEALBOT_MENDPET]=nil
    end
    if hbClassHoTwatch[HEALBOT_RIPTIDE]==3 then
        HealBot_Watch_HoT[HEALBOT_RIPTIDE]="A"
    elseif hbClassHoTwatch[HEALBOT_RIPTIDE]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_RIPTIDE]="C"
    else
        HealBot_Watch_HoT[HEALBOT_RIPTIDE]=nil
    end
    if hbClassHoTwatch[HEALBOT_EARTHLIVING_WEAPON]==3 then
        HealBot_Watch_HoT[HEALBOT_EARTHLIVING_WEAPON]="A"
    elseif hbClassHoTwatch[HEALBOT_EARTHLIVING_WEAPON]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_EARTHLIVING_WEAPON]="C"
    else
        HealBot_Watch_HoT[HEALBOT_EARTHLIVING_WEAPON]=nil
    end
    if hbClassHoTwatch[HEALBOT_EARTH_SHIELD]==3 then
        HealBot_Watch_HoT[HEALBOT_EARTH_SHIELD]="A"
    elseif hbClassHoTwatch[HEALBOT_EARTH_SHIELD]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_EARTH_SHIELD]="C"
    else
        HealBot_Watch_HoT[HEALBOT_EARTH_SHIELD]=nil
    end
    if hbClassHoTwatch[HEALBOT_WATER_SHIELD]==3 then
        HealBot_Watch_HoT[HEALBOT_WATER_SHIELD]="A"
    elseif hbClassHoTwatch[HEALBOT_WATER_SHIELD]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_WATER_SHIELD]="C"
    else
        HealBot_Watch_HoT[HEALBOT_WATER_SHIELD]=nil
    end
    if hbClassHoTwatch[HEALBOT_LIGHTNING_SHIELD]==3 then
        HealBot_Watch_HoT[HEALBOT_LIGHTNING_SHIELD]="A"
    elseif hbClassHoTwatch[HEALBOT_LIGHTNING_SHIELD]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_LIGHTNING_SHIELD]="C"
    else
        HealBot_Watch_HoT[HEALBOT_LIGHTNING_SHIELD]=nil
    end
    if hbClassHoTwatch[HEALBOT_ANCESTRAL_FORTITUDE]==3 then
        HealBot_Watch_HoT[HEALBOT_ANCESTRAL_FORTITUDE]="A"
    elseif hbClassHoTwatch[HEALBOT_ANCESTRAL_FORTITUDE]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_ANCESTRAL_FORTITUDE]="C"
    else
        HealBot_Watch_HoT[HEALBOT_ANCESTRAL_FORTITUDE]=nil
    end
    if hbClassHoTwatch[HEALBOT_HEALING_WAY]==3 then
        HealBot_Watch_HoT[HEALBOT_HEALING_WAY]="A"
    elseif hbClassHoTwatch[HEALBOT_HEALING_WAY]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_HEALING_WAY]="C"
    else
        HealBot_Watch_HoT[HEALBOT_HEALING_WAY]=nil
    end
    if hbClassHoTwatch[HEALBOT_EARTHLIVING]==3 then
        HealBot_Watch_HoT[HEALBOT_EARTHLIVING]="A"
    elseif hbClassHoTwatch[HEALBOT_EARTHLIVING]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_EARTHLIVING]="C"
    else
        HealBot_Watch_HoT[HEALBOT_EARTHLIVING]=nil
    end
    if hbClassHoTwatch[HEALBOT_ENERGIZED]==3 then
        HealBot_Watch_HoT[HEALBOT_ENERGIZED]="A"
    elseif hbClassHoTwatch[HEALBOT_ENERGIZED]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_ENERGIZED]="C"
    else
        HealBot_Watch_HoT[HEALBOT_ENERGIZED]=nil
    end
    if hbClassHoTwatch[HEALBOT_CHAINHEALHOT]==3 then
        HealBot_Watch_HoT[HEALBOT_CHAINHEALHOT]="A"
    elseif hbClassHoTwatch[HEALBOT_CHAINHEALHOT]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_CHAINHEALHOT]="C"
    else
        HealBot_Watch_HoT[HEALBOT_CHAINHEALHOT]=nil
    end
    if hbClassHoTwatch[HEALBOT_TIDAL_WAVES]==3 then
        HealBot_Watch_HoT[HEALBOT_TIDAL_WAVES]="A"
    elseif hbClassHoTwatch[HEALBOT_TIDAL_WAVES]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_TIDAL_WAVES]="C"
    else
        HealBot_Watch_HoT[HEALBOT_TIDAL_WAVES]=nil
    end
    if hbClassHoTwatch[HEALBOT_TIDAL_FORCE]==3 then
        HealBot_Watch_HoT[HEALBOT_TIDAL_FORCE]="A"
    elseif hbClassHoTwatch[HEALBOT_TIDAL_FORCE]==2 and class==HealBot_Class_En[HEALBOT_SHAMAN] then
        HealBot_Watch_HoT[HEALBOT_TIDAL_FORCE]="C"
    else
        HealBot_Watch_HoT[HEALBOT_TIDAL_FORCE]=nil
    end
    if hbClassHoTwatch[HEALBOT_VIGILANCE]==3 then
        HealBot_Watch_HoT[HEALBOT_VIGILANCE]="A"
    elseif hbClassHoTwatch[HEALBOT_VIGILANCE]==2 and class==HealBot_Class_En[HEALBOT_WARRIOR] then
        HealBot_Watch_HoT[HEALBOT_VIGILANCE]="C"
    else
        HealBot_Watch_HoT[HEALBOT_VIGILANCE]=nil
    end
    if hbClassHoTwatch[HEALBOT_LAST_STAND]==3 then
        HealBot_Watch_HoT[HEALBOT_LAST_STAND]="A"
    elseif hbClassHoTwatch[HEALBOT_LAST_STAND]==2 and class==HealBot_Class_En[HEALBOT_WARRIOR] then
        HealBot_Watch_HoT[HEALBOT_LAST_STAND]="C"
    else
        HealBot_Watch_HoT[HEALBOT_LAST_STAND]=nil
    end
    if hbClassHoTwatch[HEALBOT_SHIELD_WALL]==3 then
        HealBot_Watch_HoT[HEALBOT_SHIELD_WALL]="A"
    elseif hbClassHoTwatch[HEALBOT_SHIELD_WALL]==2 and class==HealBot_Class_En[HEALBOT_WARRIOR] then
        HealBot_Watch_HoT[HEALBOT_SHIELD_WALL]="C"
    else
        HealBot_Watch_HoT[HEALBOT_SHIELD_WALL]=nil
    end
    if hbClassHoTwatch[HEALBOT_SHIELD_BLOCK]==3 then
        HealBot_Watch_HoT[HEALBOT_SHIELD_BLOCK]="A"
    elseif hbClassHoTwatch[HEALBOT_SHIELD_BLOCK]==2 and class==HealBot_Class_En[HEALBOT_WARRIOR] then
        HealBot_Watch_HoT[HEALBOT_SHIELD_BLOCK]="C"
    else
        HealBot_Watch_HoT[HEALBOT_SHIELD_BLOCK]=nil
    end
    if hbClassHoTwatch[HEALBOT_ENRAGED_REGEN]==3 then
        HealBot_Watch_HoT[HEALBOT_ENRAGED_REGEN]="A"
    elseif hbClassHoTwatch[HEALBOT_ENRAGED_REGEN]==2 and class==HealBot_Class_En[HEALBOT_WARRIOR] then
        HealBot_Watch_HoT[HEALBOT_ENRAGED_REGEN]="C"
    else
        HealBot_Watch_HoT[HEALBOT_ENRAGED_REGEN]=nil
    end
    if hbClassHoTwatch[HEALBOT_ICEBOUND_FORTITUDE]==3 then
        HealBot_Watch_HoT[HEALBOT_ICEBOUND_FORTITUDE]="A"
    elseif hbClassHoTwatch[HEALBOT_ICEBOUND_FORTITUDE]==2 and class==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        HealBot_Watch_HoT[HEALBOT_ICEBOUND_FORTITUDE]="C"
    else
        HealBot_Watch_HoT[HEALBOT_ICEBOUND_FORTITUDE]=nil
    end
    if hbClassHoTwatch[HEALBOT_ANTIMAGIC_SHELL]==3 then
        HealBot_Watch_HoT[HEALBOT_ANTIMAGIC_SHELL]="A"
    elseif hbClassHoTwatch[HEALBOT_ANTIMAGIC_SHELL]==2 and class==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        HealBot_Watch_HoT[HEALBOT_ANTIMAGIC_SHELL]="C"
    else
        HealBot_Watch_HoT[HEALBOT_ANTIMAGIC_SHELL]=nil
    end
    if hbClassHoTwatch[HEALBOT_ARMY_OF_THE_DEAD]==3 then
        HealBot_Watch_HoT[HEALBOT_ARMY_OF_THE_DEAD]="A"
    elseif hbClassHoTwatch[HEALBOT_ARMY_OF_THE_DEAD]==2 and class==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        HealBot_Watch_HoT[HEALBOT_ARMY_OF_THE_DEAD]="C"
    else
        HealBot_Watch_HoT[HEALBOT_ARMY_OF_THE_DEAD]=nil
    end
    if hbClassHoTwatch[HEALBOT_LICHBORNE]==3 then
        HealBot_Watch_HoT[HEALBOT_LICHBORNE]="A"
    elseif hbClassHoTwatch[HEALBOT_LICHBORNE]==2 and class==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        HealBot_Watch_HoT[HEALBOT_LICHBORNE]="C"
    else
        HealBot_Watch_HoT[HEALBOT_LICHBORNE]=nil
    end
    if hbClassHoTwatch[HEALBOT_ANTIMAGIC_SHELL]==3 then
        HealBot_Watch_HoT[HEALBOT_ANTIMAGIC_SHELL]="A"
    elseif hbClassHoTwatch[HEALBOT_ANTIMAGIC_SHELL]==2 and class==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        HealBot_Watch_HoT[HEALBOT_ANTIMAGIC_SHELL]="C"
    else
        HealBot_Watch_HoT[HEALBOT_ANTIMAGIC_SHELL]=nil
    end
    if hbClassHoTwatch[HEALBOT_ARMY_OF_THE_DEAD]==3 then
        HealBot_Watch_HoT[HEALBOT_ARMY_OF_THE_DEAD]="A"
    elseif hbClassHoTwatch[HEALBOT_ARMY_OF_THE_DEAD]==2 and class==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        HealBot_Watch_HoT[HEALBOT_ARMY_OF_THE_DEAD]="C"
    else
        HealBot_Watch_HoT[HEALBOT_ARMY_OF_THE_DEAD]=nil
    end
    if hbClassHoTwatch[HEALBOT_ANTIMAGIC_ZONE]==3 then
        HealBot_Watch_HoT[HEALBOT_ANTIMAGIC_ZONE]="A"
    elseif hbClassHoTwatch[HEALBOT_ANTIMAGIC_ZONE]==2 and class==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        HealBot_Watch_HoT[HEALBOT_ANTIMAGIC_ZONE]="C"
    else
        HealBot_Watch_HoT[HEALBOT_ANTIMAGIC_ZONE]=nil
    end
    if hbClassHoTwatch[HEALBOT_VAMPIRIC_BLOOD]==3 then
        HealBot_Watch_HoT[HEALBOT_VAMPIRIC_BLOOD]="A"
    elseif hbClassHoTwatch[HEALBOT_VAMPIRIC_BLOOD]==2 and class==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        HealBot_Watch_HoT[HEALBOT_VAMPIRIC_BLOOD]="C"
    else
        HealBot_Watch_HoT[HEALBOT_VAMPIRIC_BLOOD]=nil
    end
    if hbClassHoTwatch[HEALBOT_UNBREAKABLE_ARMOR]==3 then
        HealBot_Watch_HoT[HEALBOT_UNBREAKABLE_ARMOR]="A"
    elseif hbClassHoTwatch[HEALBOT_UNBREAKABLE_ARMOR]==2 and class==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        HealBot_Watch_HoT[HEALBOT_UNBREAKABLE_ARMOR]="C"
    else
        HealBot_Watch_HoT[HEALBOT_UNBREAKABLE_ARMOR]=nil
    end
    if hbClassHoTwatch[HEALBOT_BONE_SHIELD]==3 then
        HealBot_Watch_HoT[HEALBOT_BONE_SHIELD]="A"
    elseif hbClassHoTwatch[HEALBOT_BONE_SHIELD]==2 and class==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        HealBot_Watch_HoT[HEALBOT_BONE_SHIELD]="C"
    else
        HealBot_Watch_HoT[HEALBOT_BONE_SHIELD]=nil
    end
    if hbClassHoTwatch[HEALBOT_GIFT_OF_THE_NAARU]==3 then
        HealBot_Watch_HoT[HEALBOT_GIFT_OF_THE_NAARU]="A"
    elseif hbClassHoTwatch[HEALBOT_GIFT_OF_THE_NAARU]==2 and race=="Dra" then
        HealBot_Watch_HoT[HEALBOT_GIFT_OF_THE_NAARU]="C"
    else
        HealBot_Watch_HoT[HEALBOT_GIFT_OF_THE_NAARU]=nil
    end
    if hbClassHoTwatch[HEALBOT_PROTANCIENTKINGS]==3 then
        HealBot_Watch_HoT[HEALBOT_PROTANCIENTKINGS]="A"
    elseif hbClassHoTwatch[HEALBOT_PROTANCIENTKINGS]==2 then
        HealBot_Watch_HoT[HEALBOT_PROTANCIENTKINGS]="C"
    else
        HealBot_Watch_HoT[HEALBOT_PROTANCIENTKINGS]=nil
    end
    if hbClassHoTwatch[HEALBOT_FOUNTAIN_OF_LIGHT]==3 then
        HealBot_Watch_HoT[HEALBOT_FOUNTAIN_OF_LIGHT]="A"
    elseif hbClassHoTwatch[HEALBOT_FOUNTAIN_OF_LIGHT]==2 then
        HealBot_Watch_HoT[HEALBOT_FOUNTAIN_OF_LIGHT]="C"
    else
        HealBot_Watch_HoT[HEALBOT_FOUNTAIN_OF_LIGHT]=nil
    end
end

function HealBot_Register_Events()
    if HealBot_Config.DisableHealBot==0 then
        HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:RegisterEvent("PLAYER_TARGET_CHANGED");
        HealBot:RegisterEvent("PARTY_MEMBERS_CHANGED");
        HealBot:RegisterEvent("PLAYER_FOCUS_CHANGED");
        HealBot:RegisterEvent("UNIT_ENTERED_VEHICLE");
        HealBot:RegisterEvent("UNIT_EXITED_VEHICLE");
        HealBot:RegisterEvent("UNIT_EXITING_VEHICLE");
        HealBot:RegisterEvent("UNIT_HEALTH");
        HealBot:RegisterEvent("UNIT_MAXHEALTH");
        HealBot:RegisterEvent("UNIT_MAXMANA")
        if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]>0 then HealBot_Register_Mana() end
        HealBot:RegisterEvent("LEARNED_SPELL_IN_TAB");
        HealBot:RegisterEvent("UNIT_SPELLCAST_START");
        HealBot:RegisterEvent("UNIT_AURA");
        HealBot:RegisterEvent("CHARACTER_POINTS_CHANGED");
        HealBot:RegisterEvent("UNIT_INVENTORY_CHANGED");
        HealBot:RegisterEvent("CHAT_MSG_ADDON");
        HealBot:RegisterEvent("CHAT_MSG_SYSTEM");
        HealBot:RegisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:RegisterEvent("UNIT_PET");
        HealBot:RegisterEvent("UNIT_NAME_UPDATE");
        if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then HealBot_Register_Aggro() end
        HealBot:RegisterEvent("ZONE_CHANGED_NEW_AREA");
        HealBot:RegisterEvent("RAID_ROSTER_UPDATE");
        if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot:RegisterEvent("RAID_TARGET_UPDATE") end
        if Healbot_Config_Skins.ReadyCheck[Healbot_Config_Skins.Current_Skin]==1 then HealBot_Register_ReadyCheck() end
    --    HealBot:RegisterEvent("INSPECT_TALENT_READY");
    --    HealBot:RegisterEvent("PARTY_MEMBER_DISABLE");
    --    HealBot:RegisterEvent("PARTY_MEMBER_ENABLE");
    end
    HealBot:RegisterEvent("UNIT_SPELLCAST_SENT");
    HealBot:RegisterEvent("CHAT_MSG_ADDON");
    HealBot:RegisterEvent("UNIT_SPELLCAST_STOP");
    HealBot:RegisterEvent("UNIT_SPELLCAST_FAILED");
    HealBot:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
    HealBot:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
    HealBot:RegisterEvent("UPDATE_MACROS");
    HealBot_setOptions_Timer(125)
    HealBot_setOptions_Timer(5000)
end

function HealBot_Register_Aggro()
    HealBot:RegisterEvent("UNIT_COMBAT")
    HealBot:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
end

function HealBot_UnRegister_Aggro()
    HealBot:UnregisterEvent("UNIT_COMBAT")
    HealBot:UnregisterEvent("UNIT_THREAT_SITUATION_UPDATE")
    HealBot_ClearAggro(true)
end

function HealBot_Register_ReadyCheck()
    HealBot:RegisterEvent("READY_CHECK")
    HealBot:RegisterEvent("READY_CHECK_CONFIRM")
    HealBot:RegisterEvent("READY_CHECK_FINISHED")
end

function HealBot_UnRegister_ReadyCheck()
    HealBot:UnregisterEvent("READY_CHECK")
    HealBot:UnregisterEvent("READY_CHECK_CONFIRM")
    HealBot:UnregisterEvent("READY_CHECK_FINISHED")
    HealBot_OnEvent_ReadyCheckFinished(nil);
end

function HealBot_Register_Mana()
    HealBot:RegisterEvent("UNIT_MANA")
    HealBot:RegisterEvent("UNIT_RAGE")
    HealBot:RegisterEvent("UNIT_ENERGY")
    HealBot:RegisterEvent("UNIT_RUNIC_POWER")
    HealBot:RegisterEvent("UNIT_MAXRAGE")
    HealBot:RegisterEvent("UNIT_MAXENERGY")
    HealBot:RegisterEvent("UNIT_MAXRUNIC_POWER")
    for xGUID,_ in pairs(HealBot_UnitID) do
        HealBot_CheckPower(xGUID)
    end
end

function HealBot_UnRegister_Mana()
    HealBot:UnregisterEvent("UNIT_MANA")
    HealBot:UnregisterEvent("UNIT_RAGE")
    HealBot:UnregisterEvent("UNIT_ENERGY")
    HealBot:UnregisterEvent("UNIT_RUNIC_POWER")
   -- HealBot:UnregisterEvent("UNIT_MAXMANA")
    HealBot:UnregisterEvent("UNIT_MAXRAGE")
    HealBot:UnregisterEvent("UNIT_MAXENERGY")
    HealBot:UnregisterEvent("UNIT_MAXRUNIC_POWER")
end

function HealBot_UnRegister_Events()

--    HealBot:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
--    HealBot:UnregisterEvent("PLAYER_REGEN_DISABLED");
--    HealBot:UnregisterEvent("PLAYER_REGEN_ENABLED");
--    HealBot:UnregisterEvent("UNIT_ENTERED_VEHICLE");
--    HealBot:UnregisterEvent("UNIT_EXITED_VEHICLE");
--    HealBot:UnregisterEvent("UNIT_EXITING_VEHICLE");
--    HealBot:UnregisterEvent("PLAYER_TARGET_CHANGED");
--    HealBot:UnregisterEvent("PLAYER_FOCUS_CHANGED");
--    HealBot:UnregisterEvent("PARTY_MEMBERS_CHANGED");
--    HealBot:UnregisterEvent("UNIT_HEALTH");
--    HealBot_UnRegister_Mana()
--    HealBot:UnregisterEvent("LEARNED_SPELL_IN_TAB");
--    HealBot:UnregisterEvent("UNIT_SPELLCAST_SENT");
--    HealBot:UnregisterEvent("UNIT_SPELLCAST_START");
--    HealBot:UnregisterEvent("UNIT_SPELLCAST_STOP");
--    HealBot:UnregisterEvent("UNIT_SPELLCAST_FAILED");
--    HealBot:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED");
--    HealBot:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED");
--    HealBot:UnregisterEvent("UNIT_AURA");
--    HealBot:UnregisterEvent("CHARACTER_POINTS_CHANGED");
--    HealBot:UnregisterEvent("UNIT_INVENTORY_CHANGED");
--    HealBot:UnregisterEvent("CHAT_MSG_ADDON");
--    HealBot:UnregisterEvent("CHAT_MSG_SYSTEM");
--    HealBot:UnregisterEvent("MODIFIER_STATE_CHANGED");
--    HealBot:UnregisterEvent("UNIT_PET");
--    HealBot:UnregisterEvent("UNIT_NAME_UPDATE");
--    HealBot:UnregisterEvent("RAID_ROSTER_UPDATE");
--    HealBot:UnregisterEvent("INSPECT_TALENT_READY");
--    HealBot_UnRegister_Aggro()
    
    HB_Timer1=0.5
    HB_Timer2=0.2
    HB_Timer3=0.025
    HealBot_Action_Set_Timers(true)
    
--    HealBot:UnregisterEvent("PARTY_MEMBER_DISABLE");
--    HealBot:UnregisterEvent("PARTY_MEMBER_ENABLE");
end

local aUnit,oUnit,eUnit=nil,nil,nil
local aGUID=nil
local HealBot_nonAggro={}
local aggroSwitch=0
function HealBot_CheckAggro()
    aggroSwitch=aggroSwitch+1
    if aggroSwitch>1 then
        for aUnit,oUnit in pairs(HealBot_Aggro2) do 
            HealBot_CheckUnitAggro(aUnit, oUnit)
        end
        aggroSwitch=0
    else
        for aUnit,oUnit in pairs(HealBot_Aggro1) do 
            HealBot_CheckUnitAggro(aUnit, oUnit)
        end
    end
    if eUnit and UnitExists(eUnit) then
        for xGUID,xUnit in pairs(HealBot_nonAggro) do
            if UnitExists(eUnit) and UnitIsEnemy(xUnit, eUnit) then
                z=HealBot_CalcThreat(xUnit) or 0
                if z and z>0 then
                    y = UnitThreatSituation(xUnit) or 0
                    if HealBot_AggroS==1 then
                        HealBot_Aggro1[xUnit]=xUnit
                        HealBot_AggroS=2
                    else
                        HealBot_Aggro2[xUnit]=xUnit
                        HealBot_AggroS=1
                    end
                    HealBot_nonAggro[xGUID]=nil
                    if z==100 and y<2 then y=2 end
                    HealBot_Action_UpdateAggro(xUnit,true,y,xGUID,z)
                end
            end
        end
    end
end

function HealBot_CheckUnitAggro(aUnit, oUnit)
    y = UnitThreatSituation(aUnit)
    xGUID=HealBot_UnitGUID(aUnit)
    if not y then
        if UnitIsEnemy(aUnit, aUnit.."target") then
            if not UnitIsUnit(aUnit, aUnit.."targettarget") then
                HealBot_qClearUnitAggro(aUnit, xGUID)
                HealBot_SetAggro(aUnit)
            end
        elseif UnitIsEnemy(oUnit, oUnit.."target") then
            if not UnitIsUnit(aUnit, oUnit.."targettarget") then
                HealBot_qClearUnitAggro(aUnit, xGUID)
                HealBot_SetAggro(oUnit)
            end
        else
            HealBot_qClearUnitAggro(aUnit, xGUID)
        end
    else
        z=HealBot_CalcThreat(aUnit) or 0
        if z==100 and y<2 then y=2 end
        if y~=HealBot_Action_RetUnitThreat(xGUID) or z~=HealBot_Action_RetUnitThreatPct(xGUID) then HealBot_Action_UpdateAggro(aUnit,true,y,xGUID,z) end
    end
end

function HealBot_CalcThreat(unit)
    z=nil
    if UnitIsEnemy(unit, unit.."target") then 
        if UnitIsUnit(unit, unit.."targettarget") then
            z=100
        else
            _, _, z, _, _ = UnitDetailedThreatSituation(unit, unit.."target")
        end
    elseif eUnit and UnitExists(eUnit) and UnitIsEnemy(unit, eUnit) then 
        _, _, z, _, _ = UnitDetailedThreatSituation(unit, eUnit)
    elseif UnitExists("playertarget") and UnitIsEnemy("player", "playertarget") then 
        _, _, z, _, _ = UnitDetailedThreatSituation(unit, "playertarget") 
    end
    return z
end

function HealBot_qClearUnitAggro(unit, hbGUID)
    HealBot_endAggro[unit]=hbGUID
    HealBot_luVars["DelayClearAggro"]=true
end

function HealBot_ClearUnitAggro(unit, hbGUID)
    if UnitExists(unit) and eUnit and hbGUID then
        z=HealBot_CalcThreat(unit)
        if not z or z==0 then
            if HealBot_Aggro1[unit] then HealBot_Aggro1[unit]=nil end
            if HealBot_Aggro2[unit] then HealBot_Aggro2[unit]=nil end
            HealBot_nonAggro[hbGUID]=unit
            HealBot_Action_UpdateAggro(unit,false,nil,hbGUID)
        else
            y = UnitThreatSituation(unit) or 0
            if z==100 and y<2 then y = 2 end
            if y~=HealBot_Action_RetUnitThreat(hbGUID) or z~=HealBot_Action_RetUnitThreatPct(hbGUID) then HealBot_Action_UpdateAggro(unit,true,y,hbGUID,z) end
        end
    else
        if HealBot_Aggro1[unit] then HealBot_Aggro1[unit]=nil end
        if HealBot_Aggro2[unit] then HealBot_Aggro2[unit]=nil end
        if unit then HealBot_Action_UpdateAggro(unit,false,nil,hbGUID) end
    end
end

function HealBot_SetAggro(unit)
    uName=UnitName(unit.."targettarget")
    aGUID=HealBot_Derive_GUID_fuName(uName)
    xUnit=HealBot_UnitID[aGUID]
    if xUnit and xUnit~="target" then
        if UnitIsUnit(unit, xUnit) then
            z=100
        elseif UnitIsEnemy(xUnit, xUnit.."target") and UnitIsUnit (xUnit, xUnit.."targettarget") then 
            z=100
        else
            _, _, z, _, _ = UnitDetailedThreatSituation(xUnit, unit.."target")
        end
        y = UnitThreatSituation(xUnit) or 0
        if z==100 and y<2 then y = 2 end
        if HealBot_Aggro1[xUnit] then
            HealBot_Aggro1[xUnit]=unit
        elseif HealBot_Aggro2[xUnit] then
            HealBot_Aggro2[xUnit]=unit
        elseif HealBot_AggroS==1 then
            HealBot_Aggro1[xUnit]=unit
            HealBot_AggroS=2
        else
            HealBot_Aggro2[xUnit]=unit
            HealBot_AggroS=1
        end
        HealBot_nonAggro[aGUID]=nil
        if y~=HealBot_Action_RetUnitThreat(aGUID) or z~=HealBot_Action_RetUnitThreatPct(aGUID) then HealBot_Action_UpdateAggro(xUnit,true,y,aGUID,z) end
    end
    if Healbot_Config_Skins.ShowAggroBarsPct[Healbot_Config_Skins.Current_Skin]==1 or Healbot_Config_Skins.ShowAggroTextPct[Healbot_Config_Skins.Current_Skin]==1 then
        if not eUnit or not UnitIsEnemy(unit, eUnit) then
            eUnit=unit.."target"
            HealBot_unitHealthMax["eUnit"]=UnitHealthMax(eUnit) or 2
            HealBot_unitHealth["eUnit"]=UnitHealth(eUnit) or 1
        elseif UnitHealthMax(eUnit)>HealBot_unitHealthMax["eUnit"] or (UnitHealthMax(eUnit)==HealBot_unitHealthMax["eUnit"] and UnitHealth(eUnit)>HealBot_unitHealth["eUnit"]) then
            eUnit=unit.."target"
            HealBot_unitHealthMax["eUnit"]=UnitHealthMax(eUnit)
            HealBot_unitHealth["eUnit"]=UnitHealth(eUnit)
        end
    end
end

function HealBot_nileUnit()
    eUnit=nil
    HealBot_unitHealth["eUnit"]=0
    HealBot_unitHealthMax["eUnit"]=0
end

function HealBot_Update_nonAggro()
    for xGUID,xUnit in pairs(HealBot_UnitID) do
        HealBot_nonAggro[xGUID]=xUnit
    end
end

function HealBot_RetSetAggroSize()
    z=0
    for _,_ in pairs(HealBot_Aggro1) do 
        z=z+1
    end
    y=0
    for _,_ in pairs(HealBot_Aggro2) do 
        y=y+1
    end
    return z, y
end

function HealBot_ClearAggro(force, unit)
    if unit then
        xGUID=HealBot_UnitGUID(unit)
        if force then
            HealBot_Action_UpdateAggro(unit,false,nil,xGUID)
            HealBot_Aggro1[unit]=nil
        else
            HealBot_ClearUnitAggro(xUnit, xGUID)
        end
    else
        for xUnit,_ in pairs(HealBot_Aggro1) do
            xGUID=HealBot_UnitGUID(xUnit)
            if force then
                HealBot_Action_UpdateAggro(xUnit,false,nil,xGUID)
                HealBot_Aggro1[xUnit]=nil
            else
                HealBot_qClearUnitAggro(xUnit, xGUID)
            end
        end
        for xUnit,_ in pairs(HealBot_Aggro2) do
            xGUID=HealBot_UnitGUID(xUnit)
            if force then
                HealBot_Action_UpdateAggro(xUnit,false,nil,xGUID)
                HealBot_Aggro2[xUnit]=nil
            else
                HealBot_qClearUnitAggro(xUnit, xGUID)
            end
        end
        if force then 
            HealBot_Action_EndAggro() 
            HealBot_nileUnit()
            HealBot_Update_nonAggro()
        end
    end
end

local HealBotAddonSummary={}
local HealBotAddonIncHeals={}
local hbExtra1, hbExtra2=nil, nil
function HealBot_OnEvent_AddonMsg(self,addon_id,msg,distribution,sender_id)
--  inc_msg = gsub(msg, "%$", "s");
--  inc_msg = gsub(inc_msg, "�", "S");
    inc_msg=msg
    sender_id = HealBot_UnitNameOnly(sender_id)
    utGUID=nil
    if not HealBotAddonSummary[sender_id..": "..addon_id] then
        HealBotAddonSummary[sender_id..": "..addon_id]=string.len(inc_msg)
    else
        HealBotAddonSummary[sender_id..": "..addon_id]=HealBotAddonSummary[sender_id..": "..addon_id]+string.len(inc_msg)
    end
    if addon_id==HealBot_IncHeals_retAddonCommsID() and HealBot_Config.HealCommMethod>3 then
        HealBot_IncHeals_Msg(inc_msg, sender_id)
    elseif addon_id=="HealBot" then
        _,_, datatype, sender, datamsg = strfind(inc_msg, ">> (%a+) <<=>> (%a+) <<=>> (.+)");
        if sender then
            if datatype=="RequestVersion" then
                HealBot_Comms_SendAddonMsg("HealBot", ">> SendVersion <<=>> "..sender.." <<=>> Version="..HEALBOT_VERSION, HealBot_AddonMsgType, HealBot_PlayerName)
            elseif datatype=="SendVersion" then
                HealBot_Vers[sender_id]=strsub(datamsg,9,-1)
                HealBot_AddDebug(sender_id..":  "..datamsg);
                HealBot_Comms_CheckVer(sender_id, strsub(datamsg,9,-1))
            end
        else
            datatype, datamsg, hbExtra1, hbExtra2 = string.split(":", inc_msg)
            if datatype=="R" then
                HealBot_RequestVer=sender_id
                if HealBot_Options_Timer[130] then HealBot_Options_Timer[130]=nil end
            elseif datatype=="S" then
                HealBot_Vers[sender_id]=datamsg
                if hbExtra1 then
                    if hbExtra1=="V" then
                        HealBot_IncHeals_sethbCommsUsers(sender_id)
                    else
                        HealBot_IncHeals_removehbCommsUsers(sender_id)
                    end
                end
                HealBot_AddDebug(sender_id..":  "..datamsg);
                HealBot_Comms_CheckVer(sender_id, datamsg)
            elseif datatype=="G" then
                HealBot_Comms_SendAddonMsg("HealBot", "H:"..HEALBOT_VERSION, 4, sender_id)
                if not HealBot_Vers[sender_id] then
                    HealBot_Comms_SendAddonMsg("HealBot", "G", 4, sender_id)
                end
            elseif datatype=="F" then
                HealBot_Comms_SendAddonMsg("HealBot", "C:"..HEALBOT_VERSION, 4, sender_id)
                if not HealBot_Vers[sender_id] then
                    HealBot_Comms_SendAddonMsg("HealBot", "F", 4, sender_id)
                end
            elseif datatype=="H" then
                HealBot_Vers[sender_id]=datamsg
                HealBot_AddDebug(sender_id..":  "..datamsg);
                HealBot_Comms_CheckVer(sender_id, datamsg)
                HealBot_Options_setMyGuildMates(sender_id)
            elseif datatype=="C" then
                HealBot_Vers[sender_id]=datamsg
                HealBot_AddDebug(sender_id..":  "..datamsg);
                HealBot_Comms_CheckVer(sender_id, datamsg)
                HealBot_Options_setMyFriends(sender_id)
            elseif datatype=="S" then
                HealBot_Vers[sender_id]=datamsg
                if hbExtra1 then
                    if hbExtra1=="V" then
                        HealBot_IncHeals_sethbCommsUsers(sender_id)
                    else
                        HealBot_IncHeals_removehbCommsUsers(sender_id)
                    end
                end
                HealBot_AddDebug(sender_id..":  "..datamsg);
                HealBot_Comms_CheckVer(sender_id, datamsg)
            elseif datatype=="X" and HealBot_Config.AcceptSkins==1 then
                HealBot_Options_ShareSkinRec("X", sender_id.."!"..datamsg)
            elseif datatype=="Y" then
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SHARESKINACPT..sender_id);
                HealBot_Options_ShareSkinSend("Z", datamsg, sender_id)
            elseif datatype=="Z" then
                HealBot_Options_ShareSkinRec("Z", hbExtra1, datamsg)
            elseif datatype=="RC" and Healbot_Config_Skins.ReadyCheck[Healbot_Config_Skins.Current_Skin]==1 then
                if datamsg=="I" then
                    HealBot_OnEvent_hbReadyCheck(hbExtra1,hbExtra2)
                else
                    HealBot_OnEvent_hbReadyCheckConfirmed(hbExtra1,hbExtra2)
                end
            end
        end
    elseif addon_id=="CTRA" then
        if ( strfind(inc_msg, "#") ) then
            arr = HealBot_Split(inc_msg, "#");
            for k in pairs(arr) do
                HealBot_ParseCTRAMsg(sender_id, arr[k]);
            end
        else
            HealBot_ParseCTRAMsg(sender_id, inc_msg);
        end
    end
end

function HealBot_addHealBotAddonIncHeals(id)
    if not HealBotAddonIncHeals[id] then
        HealBotAddonIncHeals[id]=1
    else
        HealBotAddonIncHeals[id]=HealBotAddonIncHeals[id]+1
    end
end

function HealBot_RetHealBotAddonSummary()
    return HealBotAddonSummary
end

function HealBot_RetHealBotAddonIncHeals()
    return HealBotAddonIncHeals
end

function HealBot_GetInfo()
    return HealBot_Vers
end

function HealBot_Split(msg, char)
    for x,_ in pairs(arrg) do
        arrg[x]=nil;
    end
    while (strfind(msg, char) ) do
        x, y = strfind(msg, char);
        tinsert(arrg, strsub(msg, 1, x-1));
        msg = strsub(msg, y+1, strlen(msg));
    end
    if ( strlen(msg) > 0 ) then
        tinsert(arrg, msg);
    end
    return arrg;
end

function HealBot_ParseCTRAMsg(sender_id, inc_msg)
    if ( strsub(inc_msg, 1, 3) == "RES" ) then
        if ( inc_msg == "RESNO" ) then
            for j in pairs(HealBot_Ressing) do
                if HealBot_Ressing[j]==sender_id then
                    HealBot_Ressing[j] = "_RESSED_";
                    break
                end
            end
        else
            _,_, uName = strfind(inc_msg, "^RES (.+)$");
            if ( uName ) then
                xGUID = HealBot_Derive_GUID_fuName(uName)
                if HealBot_UnitID[xGUID] then
                    HealBot_Ressing[xGUID] = sender_id;
                    HealBot_RecalcHeals(xGUID);
                end
            end
        end
    elseif ( strsub(inc_msg, 1, 4) == "SET " ) then
        _,_, x, uName = strfind(inc_msg, "^SET (%d+) (.+)$");
        if ( x and uName ) then
            xGUID = HealBot_Derive_GUID_fuName(uName)
            if HealBot_UnitID[xGUID] then
                for k in pairs(HealBot_CTRATanks) do
                    if ( HealBot_CTRATanks[k] == xGUID ) then
                        HealBot_CTRATanks[k] = nil;
                    end
                end
            end
            HealBot_CTRATanks[tonumber(x)] = xGUID;
        end
        HealBot_addPrivateTanks()
    elseif ( strsub(inc_msg, 1, 2) == "R " ) then
        _,_, uName = strfind(inc_msg, "^R (.+)$");
        if ( uName ) then
            xGUID = HealBot_Derive_GUID_fuName(uName)
            if HealBot_UnitID[xGUID] then
                for k in pairs(HealBot_CTRATanks) do
                    if ( HealBot_CTRATanks[k] == xGUID ) then
                        HealBot_CTRATanks[k] = nil;
                    end
                end
            end
        end
        HealBot_addPrivateTanks()
    end
end

local dGUID,uGUID=nil,nil
local hbTempUnitNames={}
function HealBot_Derive_GUID_fuName(unitName)
    if not unitName then return end
    dGUID=HealBot_RetUnitNameGUIDs(unitName)
    if not dGUID then
        xUnit=HealBot_RaidUnit(hbTempUnitNames[unitName],nil,unitName)
        if xUnit then
            hbTempUnitNames[unitName]=xUnit
            dGUID=HealBot_UnitGUID(xUnit)
        end
    end
    return dGUID
end

function HealBot_OnEvent_RaidRosterUpdate(self)
    for x,_ in pairs(HealBot_MainTanks) do
        HealBot_MainTanks[x]=nil;
    end
    for x,_ in pairs(HealBot_MainAssists) do
        HealBot_MainAssists[x]=nil;
    end
    y = 0
    w = 0
    for i=1,GetNumRaidMembers() do
        xUnit = "raid"..i
        xGUID=UnitGUID(xUnit)
        if xGUID then
            _,_,_,_,_,_,_,_,_,z,_ = GetRaidRosterInfo(i)
            if z and string.lower(z)=="maintank" then
                y = y + 1
                HealBot_MainTanks[y]=xGUID
            elseif z and string.lower(z)=="mainassist" then
                w = w + 1
                HealBot_MainAssists[w]=xGUID
            end
        end
    end
    HealBot_addPrivateTanks()
end

function HealBot_addPrivateTanks()
    local PrivTanks = HealBot_Panel_retPrivateTanks()
    table.foreach(PrivTanks, function (i,xGUID)
        HealBot_addExtraTank(xGUID)
    end)
    if Delay_RecalcParty<2 then Delay_RecalcParty=2; end
end

function HealBot_addExtraTank(hbGUID)
    z = true
    for i=1, #HealBot_MainTanks do
        if hbGUID==HealBot_MainTanks[i] then
            z = false
            break;
        end
    end
    if z then
        HealBot_MainTanks[#HealBot_MainTanks+1]=hbGUID
    end
end

function HealBot_removePrivateTanks(hbGUID)
    for i=1, #HealBot_MainTanks do
        if hbGUID==HealBot_MainTanks[i] then
            y=i
            break;
        end
    end
    if y>0 then
        HealBot_MainTanks[y]=nil
        if #HealBot_MainTanks>y then
            for i=y, #HealBot_MainTanks-1 do
                HealBot_MainTanks[i]=HealBot_MainTanks[i+1]
            end
        end
    end
end

function HealBot_OnEvent_UnitHealth(self,unit,health,healthMax)
    hGUID=HealBot_UnitGUID(unit)
    if not hGUID then return end
    if hGUID and HealBot_VehicleUnit[unit] and not HealBot_UnitID[hGUID] then
        HealBot_UnitID[hGUID]=unit
    end
    if HealBot_Config.DisableHealBot==1 or not HealBot_UnitID[hGUID] then return end
    hUnit=HealBot_IDs(unit,hGUID)
    if not hUnit then return end
    if HealBot_VehicleUnit[hUnit] then
        HBvUnits=HealBot_VehicleUnit[hUnit]
        for xUnit,_ in pairs(HBvUnits) do
            HealBot_Action_ResetUnitStatus(xUnit)
        end
        if not HealBot_Unit_Button[hUnit] then
            y = UnitThreatSituation(hUnit) or 0
            if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 and (UnitIsEnemy(hUnit, hUnit.."target") or y>0) then
                HealBot_Action_SetVAggro(hGUID, true)
            else
                HealBot_Action_SetVAggro(hGUID, nil)
            end
            HealBot_VehicleSetHealth(hUnit, health, healthMax)
            return
        end
    end
    if not HealBot_unitHealth[hGUID] then 
        HealBot_unitHealth[hGUID]=-1
        HealBot_unitHealthMax[hGUID]=-1
    end
    if HealBot_unitHealth[hGUID]~=health or HealBot_unitHealthMax[hGUID]~=healthMax then
        if HealBot_unitHealthMax[hGUID]~=healthMax then HealBot_talentSpam(hGUID,"update",1) end
        HealBot_unitHealth[hGUID]=health
        HealBot_unitHealthMax[hGUID]=healthMax
        HealBot_RecalcHeals(hGUID)
    end
 --   if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 and UnitIsEnemy(hUnit, hUnit.."target") then HealBot_SetAggro(hUnit) end
end

function HealBot_Reset_UnitHealth(hbGUID)
    if hbGUID and HealBot_UnitID[hbGUID] then
        HealBot_OnEvent_UnitHealth(nil,HealBot_UnitID[hbGUID],UnitHealth(HealBot_UnitID[hbGUID]),UnitHealthMax(HealBot_UnitID[hbGUID]))
    else
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            HealBot_OnEvent_UnitHealth(nil,xUnit,UnitHealth(xUnit),UnitHealthMax(xUnit))
        end
    end
end

function HealBot_VehicleHealth(unit)
    vGUID=HealBot_UnitGUID(unit)
    if not vGUID then
        HealBot_NoVehicle(unit)
        return 100,100
    end
    if not HealBot_unitHealth[vGUID] then 
        HealBot_unitHealth[vGUID]=UnitHealth(unit)
        HealBot_unitHealthMax[vGUID]=UnitHealthMax(unit)
    end
    return HealBot_unitHealth[vGUID], HealBot_unitHealthMax[vGUID]
end

function HealBot_NoVehicle(unit)
    HBvUnits=HealBot_VehicleUnit[unit]
    if not HBvUnits then 
        HealBot_AddDebug("HBvUnits is NIL in HealBot_NoVehicle")
    else
        for xUnit,_ in pairs(HBvUnits) do
            if HealBot_UnitInVehicle[xUnit] then HealBot_UnitInVehicle[xUnit]=nil end
        end
    end
	if HealBot_VehicleUnit[unit] then HealBot_VehicleUnit[unit]=nil end
    vGUID=HealBot_UnitGUID(unit)
    if vGUID then
      if HealBot_unitHealth[vGUID] then
          HealBot_unitHealth[vGUID]=nil
          HealBot_unitHealthMax[vGUID]=nil
      end
      if HealBot_UnitID[vGUID] then
          HealBot_UnitID[vGUID]=nil
      end
    end
end

function HealBot_VehicleSetHealth(unit, health, healthMax)
    vGUID=HealBot_UnitGUID(unit)
    if not vGUID then
        HealBot_NoVehicle(unit)
    else
        HealBot_unitHealth[vGUID]=health
        HealBot_unitHealthMax[vGUID]=healthMax
    end
end

function HealBot_OnEvent_VehicleChange(self, unit, enterVehicle)
    xGUID=HealBot_UnitGUID(unit)
    if not xGUID then return end 
    xUnit=HealBot_IDs(unit,xGUID)
    if not xUnit then return end 
    if enterVehicle then
        vUnit=HealBot_UnitPet(xUnit)
        if vUnit and UnitHasVehicleUI(xUnit) then
            if HealBot_VehicleCheck[xUnit] then HealBot_VehicleCheck[xUnit]=nil end
            if not HealBot_VehicleUnit[vUnit] then HealBot_VehicleUnit[vUnit]={} end
            HealBot_VehicleUnit[vUnit][xUnit]=true
            HealBot_UnitInVehicle[xUnit]=vUnit
            xGUID=HealBot_UnitGUID(vUnit)
            if xGUID and not HealBot_UnitID[xGUID] then 
                HealBot_UnitID[xGUID]=vUnit 
            end
            HealBot_OnEvent_UnitHealth(self,vUnit,UnitHealth(vUnit),UnitHealthMax(vUnit))
        elseif self then
            HealBot_VehicleCheck[xUnit]=1
        end
    elseif HealBot_UnitInVehicle[xUnit] then
        vUnit=HealBot_UnitInVehicle[xUnit]
        HealBot_NoVehicle(vUnit)
    end
    HealBot_Action_ResetUnitStatus(xUnit)
    Delay_RecalcParty=1
end

function HealBot_OnEvent_LeavingVehicle(self, unit)
    xGUID=HealBot_UnitGUID(unit)
    if not xGUID then return end
    xUnit=HealBot_IDs(unit,xGUID)
    if not xUnit then return end
    if HealBot_UnitInVehicle[xUnit] then
        vUnit=HealBot_UnitInVehicle[xUnit]
        HealBot_Action_SetVAggro(HealBot_UnitGUID(vUnit), nil)
    end
end

function HealBot_retIsInVehicle(unit)
    return HealBot_UnitInVehicle[unit]
end

function HealBot_CheckAllUnitVehicle(unit)
    if unit then
        HealBot_OnEvent_VehicleChange(nil, unit, true)
    else
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            HealBot_VehicleCheck[xUnit]=3
        end
    end
end

function HealBot_OnEvent_UnitMana(self,unit)
    xGUID=HealBot_UnitGUID(unit)
    if not xGUID then return end
    xUnit=HealBot_IDs(unit,xGUID)
    if not xUnit or not HealBot_UnitName[xGUID] or HealBot_Config.DisableHealBot==1 then return end
    HealBot_Action_SetBar3Value(HealBot_Unit_Button[xUnit])
end

function HealBot_OnEvent_UnitMaxMana(self,unit)
    xGUID=HealBot_UnitGUID(unit)
    if not xGUID then return end
    HealBot_talentSpam(xGUID,"update",1)
end

function HealBot_OnEvent_UnitCombat(self,unit)
    xGUID=HealBot_UnitGUID(unit)
    if not xGUID then return end
    xUnit=HealBot_IDs(unit,xGUID)
    if not xUnit then return end
    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 and UnitIsEnemy(xUnit, xUnit.."target") then HealBot_SetAggro(xUnit) end
end

function HealBot_OnEvent_ModifierStateChange(self,arg1,arg2)
    if HealBot_Action_TooltipUnit then
        HealBot_Action_RefreshTooltip(HealBot_Action_TooltipUnit,"Enabled");
    elseif HealBot_Action_DisableTooltipUnit then
        HealBot_Action_RefreshTooltip(HealBot_Action_DisableTooltipUnit,"Disabled");
    end
end

function HealBot_OnEvent_ZoneChanged(self)
    HealBot_setOptions_Timer(120)
end

function HealBot_CheckZone()
    local inBG=nil
--   z = GetRealZoneText()
    _,z = IsInInstance()
    if z=="pvp" or z == "arena" then inBG=true end
    HealBot_SetAddonComms(inBG)
    HealBot_Queue_AllActiveMyBuffs()
    for xGUID,_ in pairs(HealBot_UnitID) do
        HealBot_CheckHealth(xGUID)
    end
end

local uaUnit=nil
local uaGUID=nil
function HealBot_OnEvent_UnitAura(self,unit)
    uaGUID=HealBot_UnitGUID(unit)
    if not uaGUID or not HealBot_UnitID[uaGUID] then return end
    uaUnit=HealBot_IDs(unit,uaGUID)
    
    if not HealBot_Unit_Button[uaUnit] then
        if UnitName("target")==UnitName(uaUnit) then
            uaUnit="target"
            uaGUID=HealBot_UnitGUID(uaUnit)
            if not uaGUID or not HealBot_UnitID[uaGUID] then return end
        else
            return;
        end
    end

    if HealBot_Config.DebuffWatch==1 then
        if HealBot_Config.DebuffWatchInCombat==0 and HealBot_IsFighting then
            HealBot_DelayDebuffCheck[uaGUID]="S";
        else
            HealBot_DelayDebuffCheck[uaGUID]="F";
            HealBot_luVars["DelayDebuffCheck"]=true
        end
    end  
  
    if HealBot_Config.BuffWatch==1 then 
        if HealBot_Config.BuffWatchInCombat==0 and HealBot_IsFighting then
            HealBot_DelayBuffCheck[uaGUID]="S";
        else
            HealBot_DelayBuffCheck[uaGUID]="F";
            HealBot_luVars["DelayBuffCheck"]=true
        end
    end

    if Healbot_Config_Skins.ShowHoTicons[Healbot_Config_Skins.Current_Skin]==1 then 
        HealBot_DelayAuraCheck[uaGUID]=uaUnit
        HealBot_luVars["DelayAuraCheck"]=true
    end

   -- if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 and UnitIsEnemy(uaUnit, uaUnit.."target") then HealBot_SetAggro(uaUnit) end
end

function HealBot_SetUnitBuffTimer(hbGUID,buffName,endtime)

    if not HealBot_PlayerBuff[hbGUID] then
        HealBot_PlayerBuff[hbGUID]={}
    end

    if HealBot_ShortBuffs[buffName] then 
        HealBot_PlayerBuff[hbGUID][buffName] = endtime-HealBot_Config.ShortBuffTimer
    else
        HealBot_PlayerBuff[hbGUID][buffName] = endtime-HealBot_Config.LongBuffTimer
    end
--  HealBot_AddDebug("Set bufftimer.buffName="..buffName.."  hbGUID="..hbGUID.."  endtime="..endtime)
    if not HealBot_CheckBuffsTime or HealBot_PlayerBuff[hbGUID][buffName] < HealBot_CheckBuffsTime then
        HealBot_CheckBuffsTime=HealBot_PlayerBuff[hbGUID][buffName]
        HealBot_CheckBuffsTimehbGUID=hbGUID
    end
end

function HealBot_HasBuff(buffName, unit)
    x,_,iTexture,bCount,_,_,expirationTime, caster,_ = UnitBuff(unit,buffName)
    if x then
        if not HealBot_HoT_Texture[buffName] then HealBot_HoT_Texture[buffName]=iTexture end
        return true, expirationTime, caster, bCount;
    end
    return false;
end

local hbExcludeSpells = { [67358]="Rejuvenating",
                          [58597]="Sacred Shield"
                        }
                        
function HealBot_HasUnitBuff(buffName, unit, casterUnitID)
    if UnitExists(unit) then
        k = 1
        while true do
            x,_,iTexture,bCount,_,_,expirationTime, caster,_,_,spellID = UnitAura(unit, k, "HELPFUL"); 
            if x then
                if x==buffName and casterUnitID==caster and not hbExcludeSpells[spellID] then
                    if not HealBot_HoT_Texture[buffName] then HealBot_HoT_Texture[buffName]=iTexture end
                    return true, expirationTime, bCount
                end
                k=k+1
            else
                do break end
            end
        end
    end
    return false;
end

function HealBot_HasDebuff(debuffName, unit)
    x,_,_,_,_,_,_,_,_ = UnitDebuff(unit,debuffName)
    if x then
        return true;
    end
    return false;
end

local hbHoTcaster="!";
local hbFoundHoT={}
local hbNoEndTime=GetTime()+604800
function HealBot_HasMyBuffs(hbGUID)
    xUnit=HealBot_UnitID[hbGUID]
    if UnitExists(xUnit) then
        for x,_ in pairs(hbFoundHoT) do
            hbFoundHoT[x]=nil;
        end
        k = 1
        HoTActive=nil
        while true do
            bName,_,iTexture,bCount,_,_,expirationTime, caster,_,_,spellID = UnitAura(xUnit, k, "HELPFUL"); 
            if bName and caster then
                y=HealBot_Watch_HoT[bName] or "nil"
                if (y=="A" or (y=="C" and caster=="player")) and not hbExcludeSpells[spellID] then
                    hbHoTcaster=UnitGUID(caster).."!" 
                    if bName==HEALBOT_INNER_FOCUS or bName==HEALBOT_NATURE_SWIFTNESS or (expirationTime or 0)==0 then expirationTime=hbNoEndTime end
                    if not HealBot_Player_HoT[hbGUID] then HealBot_Player_HoT[hbGUID]={} end
                    if not HealBot_Player_HoT_Icons[hbGUID] then HealBot_Player_HoT_Icons[hbGUID]={} end
                    if not HealBot_Player_HoT_Icons[hbGUID][hbHoTcaster..bName] then HealBot_Player_HoT_Icons[hbGUID][hbHoTcaster..bName]=0 end
                    if not HealBot_Player_HoT[hbGUID][hbHoTcaster..bName] then HealBot_Player_HoT[hbGUID][hbHoTcaster..bName]=expirationTime+1 end
                    hbFoundHoT[hbHoTcaster..bName]=true
                    if (bCount and bCount>1) or HealBot_HoT_Count[hbHoTcaster..bName] then
                        if (Healbot_Config_Skins.ShowIconTextCountSelfCast[Healbot_Config_Skins.Current_Skin]==1 and caster~="player") or Healbot_Config_Skins.ShowIconTextCount[Healbot_Config_Skins.Current_Skin]==0 then
                            if HealBot_HoT_Count[hbHoTcaster..bName] then HealBot_HoT_Count[hbHoTcaster..bName]=nil end
                        else
                            if not HealBot_HoT_Count[hbHoTcaster..bName] then HealBot_HoT_Count[hbHoTcaster..bName]={} end
                            if bCount~=(HealBot_HoT_Count[hbHoTcaster..bName][hbGUID] or 0) then
                                HealBot_HoT_Count[hbHoTcaster..bName][hbGUID]=bCount
                                HealBot_Player_HoT[hbGUID][hbHoTcaster..bName]=expirationTime+1
                            end
                        end
                    end    
                    if bName==HEALBOT_POWER_WORD_SHIELD then
                        HoTActive=HEALBOT_POWER_WORD_SHIELD
                        if (HealBot_TrackWS[hbGUID] or "-")=="-" and expirationTime>GetTime()+20 then
                            HealBot_TrackWS[hbGUID]="+"
                            HealBot_Player_HoT[hbGUID][hbHoTcaster..bName]=expirationTime+1
                        elseif HealBot_TrackWS[hbGUID] and not HealBot_HasDebuff(HEALBOT_DEBUFF_WEAKENED_SOUL, xUnit) then
                            HealBot_TrackWS[hbGUID]=nil
                            HealBot_Player_HoT[hbGUID][hbHoTcaster..bName]=expirationTime+1
                        end
                    end
                    if not HealBot_HoT_Texture[bName] then 
                        HealBot_HoT_Texture[bName]=iTexture
                    end  
                    if HealBot_Player_HoT[hbGUID][hbHoTcaster..bName]~=expirationTime then
                        HealBot_Player_HoT[hbGUID][hbHoTcaster..bName]=expirationTime
                        HealBot_HoT_Update(hbGUID, hbHoTcaster..bName)
                    end
                end
                k=k+1
            else
                do break end
            end
        end
        if not HoTActive and (HealBot_Watch_HoT[HEALBOT_POWER_WORD_SHIELD]=="A" or HealBot_Watch_HoT[HEALBOT_POWER_WORD_SHIELD]=="C") then
            bName,_,iTexture,bCount,_,_,expirationTime, caster,_,_,spellID = UnitDebuff(xUnit, HEALBOT_DEBUFF_WEAKENED_SOUL); 
            if bName and caster then
                if (HealBot_Watch_HoT[HEALBOT_POWER_WORD_SHIELD]=="A" or (HealBot_Watch_HoT[HEALBOT_POWER_WORD_SHIELD]=="C" and caster=="player")) then
                    hbHoTcaster=UnitGUID(caster).."!" 
                    if not HealBot_Player_HoT[hbGUID] then HealBot_Player_HoT[hbGUID]={} end
                    if not HealBot_Player_HoT_Icons[hbGUID] then HealBot_Player_HoT_Icons[hbGUID]={} end
                    if not HealBot_Player_HoT_Icons[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD] then HealBot_Player_HoT_Icons[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD]=0 end
                    if not HealBot_Player_HoT[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD] then 
                        HealBot_Player_HoT[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD]=expirationTime+1
                    end
                    HealBot_HoT_Texture[HEALBOT_DEBUFF_WEAKENED_SOUL]=iTexture
                    HealBot_TrackWS[hbGUID]="-"
                    if HealBot_Player_HoT[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD]~=expirationTime then
                        HealBot_Player_HoT[hbGUID][hbHoTcaster..HEALBOT_POWER_WORD_SHIELD]=expirationTime
                        HealBot_HoT_Update(hbGUID, hbHoTcaster..HEALBOT_POWER_WORD_SHIELD)
                    end
                    hbFoundHoT[hbHoTcaster..HEALBOT_POWER_WORD_SHIELD]=true
                elseif HealBot_TrackWS[hbGUID] then
                    HealBot_TrackWS[hbGUID]=nil
                end
            end
        end
        huHoTtime=HealBot_Player_HoT[hbGUID]
        if huHoTtime then
            for sName, expirationTime in pairs(huHoTtime) do
                if not hbFoundHoT[sName] then
                    _, hotName=string.split("!", sName)
                    if HealBot_Watch_HoT[hotName] then
                        huHoTtime[sName]=1
                        if HealBot_Player_HoT_Icons[hbGUID][sName]>0 then
                            HealBot_HoT_Update(hbGUID, sName)
                        else
                            huHoTtime[sName]=nil
                            HealBot_Player_HoT_Icons[hbGUID][sName]=nil
                            if HealBot_HoT_Count[sName] and HealBot_HoT_Count[sName][hbGUID] then HealBot_HoT_Count[sName][hbGUID]=nil end
                        end
                    end
                end
            end
        end
    end
end

function HealBot_CheckMyBuffs(hbGUID)
    xUnit=HealBot_UnitID[hbGUID]
    if not xUnit then return end
    for bName,_ in pairs(HealBot_CheckBuffs) do
        _,_,_,_,_,_,z,caster,_ = HealBot_HasUnitBuff(xUnit,bName,"player")
        if z and caster and caster=="player" then
            HealBot_SetUnitBuffTimer(hbGUID,bName,z)
        elseif HealBot_PlayerBuff[hbGUID] and HealBot_PlayerBuff[hbGUID][bName] then
            if HealBot_PlayerBuff[hbGUID][bName]==HealBot_CheckBuffsTime then
                HealBot_PlayerBuff[hbGUID][bName]=nil
                HealBot_ResetCheckBuffsTime()
            else
                HealBot_PlayerBuff[hbGUID][bName]=nil
            end
        end
    end
end

function HealBot_CheckAllBuffs(hbGUID)
    if HealBot_Config.BuffWatch==1 then 
        if hbGUID then
            if not HealBot_DelayBuffCheck[hbGUID] then HealBot_DelayBuffCheck[hbGUID]="S" end
        else
            for xGUID,_  in pairs(HealBot_UnitID) do
                if not HealBot_DelayBuffCheck[xGUID] then HealBot_DelayBuffCheck[xGUID]="S" end
            end
        end
    end
end

function HealBot_ClearAllBuffs(hbGUID)
    if hbGUID then
        if HealBot_DelayBuffCheck[hbGUID] then 
            HealBot_DelayBuffCheck[hbGUID]=nil
            HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID])
        end
    else
        for x,_ in pairs(HealBot_DelayBuffCheck) do
            HealBot_DelayBuffCheck[x]=nil;
            HealBot_Action_ResetUnitStatus(HealBot_UnitID[x])
        end
    end
end

function HealBot_CheckAllDebuffs(hbGUID)
    if HealBot_Config.DebuffWatch==1 then 
        if hbGUID then
            if not HealBot_DelayDebuffCheck[hbGUID] then HealBot_DelayDebuffCheck[hbGUID]="S" end
        else
            for xGUID,_ in pairs(HealBot_UnitID) do
		        if not HealBot_DelayDebuffCheck[xGUID] then HealBot_DelayDebuffCheck[xGUID]="S" end
            end
        end
    end
end

function HealBot_ClearAllDebuffs(hbGUID)
    if hbGUID then
        if HealBot_DelayDebuffCheck[hbGUID] then 
            HealBot_DelayDebuffCheck[hbGUID]=nil 
            HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID])
        end
    else
        for x,_ in pairs(HealBot_DelayDebuffCheck) do
            HealBot_DelayDebuffCheck[x]=nil;
            HealBot_Action_ResetUnitStatus(HealBot_UnitID[x])
        end
    end
end

local DebuffNameIn="x"
local curDebuffs={}
local DebuffClass=nil
local myhTargets={}
local inSpellRange = 0 -- added by Diacono
local dPrio=100
local debuffDuration=nil
local trackdebuffIcon={}
function HealBot_CheckUnitDebuffs(hbGUID)
    if not HealBot_UnitID[hbGUID] then return end
    xUnit=HealBot_UnitID[hbGUID]
    if not xUnit or not HealBot_Unit_Button[xUnit] or not UnitExists(xUnit) then return end
    _,DebuffClass=UnitClass(xUnit)
    if not DebuffClass then DebuffClass=HealBot_Class_En[HEALBOT_WARRIOR] end
    DebuffType=nil;
    y = 1;
    if HealBot_UnitDebuff[hbGUID] then
        DebuffNameIn=HealBot_UnitDebuff[hbGUID]["name"]
    else
        DebuffNameIn="x"
    end
    for x,_ in pairs(curDebuffs) do
        curDebuffs[x]=nil;
    end
    while true do
        dName,_,_,_,debuff_type,debuffDuration,_,_,_,_ = UnitDebuff(xUnit,y)
        if dName then
            y = y +1
            curDebuffs[dName]={}
            if HealBot_Config.HealBot_Custom_Debuffs[dName] then debuff_type = HEALBOT_CUSTOM_en end
            curDebuffs[dName]["priority"]=HealBot_Options_retDebuffPriority(dName, debuff_type)
            curDebuffs[dName]["type"]=debuff_type
            curDebuffs[dName]["duration"]=debuffDuration
        else
            do break end
        end 
    end
    dPrio = 100
    for dName,_ in pairs(curDebuffs) do
        if curDebuffs[dName]["priority"]<dPrio then
            debuff_type=curDebuffs[dName]["type"]
            debuffDuration=curDebuffs[dName]["duration"]
            if dName~=DebuffNameIn then
                checkthis=false;
                
                if HealBot_Config.HealBot_Custom_Debuffs[dName] then 
                    WatchTarget={["Raid"]=true,} 
                else
                    WatchTarget, WatchGUID=HealBot_Options_retDebuffWatchTarget(debuff_type,hbGUID);
                end

                if (debuff_type == HEALBOT_POISON_en) and (HealBot_DebuffSpell[HEALBOT_DISEASE_en] == HEALBOT_ABOLISH_DISEASE) then
                    if (not HealBot_DebuffSpell[HEALBOT_POISON_en]) and ( HealBot_Talents[HEALBOT_BODY_AND_SOUL] > 0) then
                        WatchTarget={["Self"]=true,};
                    end
                end
      
                if WatchTarget then 
                    if WatchTarget["Raid"] then
                        checkthis=true;
                    elseif WatchTarget["Party"] and (UnitInParty(xUnit) or hbGUID==HealBot_PlayerGUID) then
                        checkthis=true;
                    elseif WatchTarget["Self"] and hbGUID==HealBot_PlayerGUID then
                        checkthis=true
                    elseif WatchTarget[strsub(DebuffClass,1,4)] then
                        checkthis=true;
                    elseif WatchTarget["PvP"] and UnitIsPVP("player") then
                        checkthis=true;
                    elseif WatchTarget["Name"] and hbGUID==WatchGUID then
                        checkthis=true;
                    elseif WatchTarget["Focus"] and UnitIsUnit(xUnit, "focus") then
                        checkthis=true;
                    elseif WatchTarget["MainTanks"] then
                        for i=1, #HealBot_MainTanks do
                            if hbGUID==HealBot_MainTanks[i] then
                                checkthis=true;
                                break;
                            end
                        end
                        for i=1, #HealBot_MainAssists do
                            if hbGUID==HealBot_MainAssists[i] then
                                checkthis=true;
                                break;
                            end
                        end
                        for i=1, #HealBot_CTRATanks do
                            if hbGUID==HealBot_CTRATanks[i] then
                                checkthis=true;
                                break;
                            end
                        end
                    elseif WatchTarget["MyTargets"] then
                        myhTargets=HealBot_GetMyHealTargets();
                        for i=1, #myhTargets do
                            if hbGUID==myhTargets[i] then
                                checkthis=true;
                                break;
                            end
                        end
                    end
       
                    if checkthis and (debuff_type ~= HEALBOT_CUSTOM_en) then
                        if HealBot_Config.IgnoreMovementDebuffs==1 and HealBot_Ignore_Movement_Debuffs[dName] then
                            checkthis=false;
                        elseif HealBot_Config.IgnoreFastDurDebuffs==1 and debuffDuration and debuffDuration<HealBot_Config.IgnoreFastDurDebuffsSecs then
                            checkthis=false;
                        elseif HealBot_Config.IgnoreNonHarmfulDebuffs==1 and HealBot_Ignore_NonHarmful_Debuffs[dName] then
                            checkthis=false;
                        elseif HealBot_Config.IgnoreClassDebuffs==1 then
                            HealBot_Ignore_Debuffs_Class=HealBot_Ignore_Class_Debuffs[strsub(DebuffClass,1,4)];
                            if HealBot_Ignore_Debuffs_Class[dName] then
                                checkthis=false;
                            end
                        end
                    end
                end
            else
                checkthis=true
            end
            if checkthis then
                if not HealBot_UnitDebuff[hbGUID] then HealBot_UnitDebuff[hbGUID]={} end
                HealBot_UnitDebuff[hbGUID]["type"]=debuff_type
                HealBot_UnitDebuff[hbGUID]["name"]=dName
                DebuffType=debuff_type;
                dPrio = curDebuffs[dName]["priority"]
            end
        end 
    end
    
    if not DebuffType then 
        if HealBot_UnitDebuff[hbGUID] then
            if HealBot_Player_HoT[hbGUID] and HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..HealBot_UnitDebuff[hbGUID]["name"]] then
                HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..HealBot_UnitDebuff[hbGUID]["name"]]=10
                HealBot_HoT_Update(hbGUID, HealBot_PlayerGUID.."!"..HealBot_UnitDebuff[hbGUID]["name"])
                trackdebuffIcon[hbGUID]=nil
            end
            HealBot_UnitDebuff[hbGUID] = nil;
            if HealBot_ThrottleCnt>5 then
                HealBot_Action_ResetUnitStatus(xUnit)
            else
                HealBot_RecalcHeals(hbGUID)
                HealBot_ThrottleCnt=HealBot_ThrottleCnt+1
            end
            if HealBot_Config.CDCshownAB==1 then
                HealBot_Action_SetUnitDebuffStatus(hbGUID)
                if not HealBot_Aggro1[xUnit] and not HealBot_Aggro2[xUnit] then 
                    if HealBot_AggroS==1 then
                        HealBot_Aggro1[xUnit]=xUnit
                        HealBot_AggroS=2
                    else
                        HealBot_Aggro2[xUnit]=xUnit
                        HealBot_AggroS=1
                    end
                end
            end
        end
    end
    
    if HealBot_UnitDebuff[hbGUID] then
        if HealBot_UnitDebuff[hbGUID]["name"]~=DebuffNameIn then
            inSpellRange = HealBot_UnitInRange(HealBot_dSpell, xUnit)
            if HealBot_Config.CDCshownAB==1 and inSpellRange>(HealBot_Config.HealBot_CDCWarnRange_Aggro-3) then
                HealBot_Action_SetUnitDebuffStatus(hbGUID,debuffCodes[DebuffType])
                HealBot_Action_UpdateAggro(xUnit,"debuff",debuffCodes[DebuffType],hbGUID)
            end
            if HealBot_Config.ShowDebuffWarning==1 and inSpellRange>(HealBot_Config.HealBot_CDCWarnRange_Screen-3) then
                if HealBot_Config.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]] then
                    UIErrorsFrame:AddMessage(UnitName(xUnit).." suffers from "..HealBot_UnitDebuff[hbGUID]["name"], 
                                             HealBot_Config.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]].R,
                                             HealBot_Config.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]].G,
                                             HealBot_Config.CDCBarColour[HealBot_UnitDebuff[hbGUID]["name"]].B,
                                             1, UIERRORS_HOLD_TIME);
                else
                    UIErrorsFrame:AddMessage(UnitName(xUnit).." suffers from "..HealBot_UnitDebuff[hbGUID]["name"], 
                                             HealBot_Config.CDCBarColour[DebuffType].R,
                                             HealBot_Config.CDCBarColour[DebuffType].G,
                                             HealBot_Config.CDCBarColour[DebuffType].B,
                                             1, UIERRORS_HOLD_TIME);
                end
            end
            if HealBot_Config.SoundDebuffWarning==1 and inSpellRange>(HealBot_Config.HealBot_CDCWarnRange_Sound-3) then
                HealBot_PlaySound(HealBot_Config.SoundDebuffPlay)
            end

            if inSpellRange >-1 then
                if HealBot_ThrottleCnt>5 then
                    HealBot_Action_ResetUnitStatus(xUnit)
                else
                    HealBot_RecalcHeals(hbGUID)
                    HealBot_ThrottleCnt=HealBot_ThrottleCnt+1
                end
            else
                HealBot_Action_ResetUnitStatus(xUnit)
            end
        end
        if HealBot_UnitDebuff[hbGUID] then
            if Healbot_Config_Skins.ShowDebuffIcon[Healbot_Config_Skins.Current_Skin]==1 and UnitIsVisible(xUnit) then
                dName,_,deBuffTexture,bCount,_,_,expirationTime,_,_ = UnitDebuff(xUnit,HealBot_UnitDebuff[hbGUID]["name"])
                if dName then
                    if not HealBot_DeBuff_Texture[dName] and deBuffTexture then HealBot_DeBuff_Texture[dName]=deBuffTexture end
                    if (expirationTime or 0)==0 then expirationTime=hbNoEndTime end
                    if HealBot_DeBuff_Texture[dName] then
                        if not trackdebuffIcon[hbGUID] then 
                            trackdebuffIcon[hbGUID]=dName
                        elseif trackdebuffIcon[hbGUID]~=dName and HealBot_Player_HoT[hbGUID] and HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..trackdebuffIcon[hbGUID]] then
                            HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..trackdebuffIcon[hbGUID]]=10
                            HealBot_HoT_Update(hbGUID, HealBot_PlayerGUID.."!"..trackdebuffIcon[hbGUID])
                            trackdebuffIcon[hbGUID]=dName
                        end
                        if not bCount then bCount=1 end
                        if not HealBot_Player_HoT[hbGUID] then HealBot_Player_HoT[hbGUID]={} end
                        if (DeBuff_Count[hbGUID] or -1)~=bCount then
                            DeBuff_Count[hbGUID]=bCount
                            HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..dName]=expirationTime+1
                        elseif not HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..dName] then 
                            HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..dName]=expirationTime+1 
                        end
                        if not HealBot_Player_HoT_Icons[hbGUID] then HealBot_Player_HoT_Icons[hbGUID]={} end
                        if not HealBot_Player_HoT_Icons[hbGUID][HealBot_PlayerGUID.."!"..dName] then HealBot_Player_HoT_Icons[hbGUID][HealBot_PlayerGUID.."!"..dName]=0 end
                        if HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..dName]~=expirationTime then
                            HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..dName]=expirationTime
                            HealBot_HoT_Update(hbGUID, HealBot_PlayerGUID.."!"..dName)
                        end
                    end
                elseif HealBot_Player_HoT[hbGUID] and HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn] then
                    HealBot_Player_HoT[hbGUID][HealBot_PlayerGUID.."!"..DebuffNameIn]=10
                    HealBot_HoT_Update(hbGUID, HealBot_PlayerGUID.."!"..DebuffNameIn)
                    trackdebuffIcon[hbGUID]=nil
                end
            end
        end
    end
end

function HealBot_CheckUnitBuffs(hbGUID)
    if not HealBot_UnitID[hbGUID] then return end
    xUnit=HealBot_UnitID[hbGUID]
    if not UnitName(xUnit) then return end
    if not xUnit or not HealBot_Unit_Button[xUnit] or not UnitExists(xUnit) then return end
    uName=UnitName(xUnit);
    if not uName then return end
    _,BuffClass=UnitClass(xUnit)
    if not BuffClass then BuffClass=HealBot_Class_En[HEALBOT_WARRIOR] end
    y = 1;

    for x,_ in pairs(PlayerBuffs) do
        PlayerBuffs[x]=nil;
    end

    while true do
        bName,_,_,_,_,_,w,_ = UnitAura(xUnit,y,"HELPFUL") 
        if bName then
            PlayerBuffs[bName]=true
            y = y + 1;
            if HealBot_CheckBuffs[bName] then
                if w-GetTime()>0 then
                    HealBot_SetUnitBuffTimer(hbGUID,bName,w)
                elseif HealBot_PlayerBuff[hbGUID] and HealBot_PlayerBuff[hbGUID][bName] then
                    if HealBot_PlayerBuff[hbGUID][bName]==HealBot_CheckBuffsTime then
                        HealBot_PlayerBuff[hbGUID][bName]=nil
                        HealBot_ResetCheckBuffsTime()
                    else
                        HealBot_PlayerBuff[hbGUID][bName]=nil
                    end
           
                end
            end
        else
            do break end
        end
    end 

    if HealBot_PlayerBuff[hbGUID] then
        PlayerBuffsGUID=HealBot_PlayerBuff[hbGUID]
        for z,_ in pairs (PlayerBuffsGUID) do
            if not PlayerBuffs[z] then
--              HealBot_AddDebug("Removed buff="..z)
                if PlayerBuffsGUID[z]==HealBot_CheckBuffsTime then
                    PlayerBuffsGUID[z]=nil
                    HealBot_ResetCheckBuffsTime()
                else
                    PlayerBuffsGUID[z]=nil
                end
            end
        end
        for x,_ in pairs(PlayerBuffs) do
            if HealBot_PlayerBuff[hbGUID][x] and HealBot_PlayerBuff[hbGUID][x] < GetTime() then
                PlayerBuffs[x]=nil
            end
        end
    end

    HasWeaponBuff=GetWeaponEnchantInfo()
    bName=nil;
    for k in pairs(HealBot_BuffWatch) do
        if not PlayerBuffs[HealBot_BuffWatch[k]] then
            checkthis=false;
            WatchTarget, WatchGUID=HealBot_Options_retBuffWatchTarget(HealBot_BuffWatch[k], hbGUID);
            z, x, _ = GetSpellCooldown(HealBot_BuffWatch[k]);
            if not x then
                -- Spec change within that last few secs - buff outdated so do nothing
            elseif x<2 then
                if WatchTarget["Raid"] then
                    checkthis=true;
                elseif WatchTarget["Party"] and (UnitInParty(xUnit) or uName==HealBot_PlayerName) then
                    checkthis=true;
                elseif WatchTarget["Self"] and uName==HealBot_PlayerName then 
                    checkthis=true
                elseif WatchTarget[strsub(BuffClass,1,4)] then
                    checkthis=true
                elseif WatchTarget["PvP"] and UnitIsPVP(xUnit) then
                    checkthis=true;
                elseif WatchTarget["Name"] and hbGUID==WatchGUID then
                    checkthis=true;
                elseif WatchTarget["Focus"] and UnitIsUnit(xUnit, "focus") then
                    checkthis=true;
                elseif WatchTarget["MainTanks"] then
                    for i=1, #HealBot_MainTanks do
                        if hbGUID==HealBot_MainTanks[i] then
                            checkthis=true;
                            break;
                        end
                    end
                    for i=1, #HealBot_MainAssists do
                        if hbGUID==HealBot_MainAssists[i] then
                            checkthis=true;
                            break;
                        end
                    end
                    for i=1, #HealBot_CTRATanks do
                        if hbGUID==HealBot_CTRATanks[i] then
                            checkthis=true;
                            break;
                        end
                    end
                elseif WatchTarget["MyTargets"] then
                    myhTargets=HealBot_GetMyHealTargets();
                    for i=1, #myhTargets do
                        if hbGUID==myhTargets[i] then
                            checkthis=true;
                            break;
                        end
                    end
                end
            elseif not HealBot_ReCheckBuffsTime or HealBot_ReCheckBuffsTime>z+x then
                HealBot_ReCheckBuffsTime=z+x
                HealBot_ReCheckBuffsTimed[HealBot_ReCheckBuffsTime]=hbGUID
            elseif HealBot_ReCheckBuffsTime<z+x then
                HealBot_ReCheckBuffsTimed[z+x]=hbGUID
            end
            if CheckWeaponBuffs[HealBot_BuffWatch[k]] and HasWeaponBuff then checkthis=false end
            if checkthis and UnitLevel("player")<80 and HealBot_BuffWatch[k]==HEALBOT_DIVINE_SPIRIT or HealBot_BuffWatch[k]==HEALBOT_PRAYER_OF_SPIRIT then
                if PlayerBuffs[HEALBOT_FEL_INTELLECT] then
                    checkthis=false
                end
            end
            if checkthis then
                if HealBot_BuffWatch[k]==HEALBOT_ARCANE_INTELLECT or HealBot_BuffWatch[k]==HEALBOT_ARCANE_BRILLIANCE or 
                   HealBot_BuffWatch[k]==HEALBOT_DALARAN_BRILLIANCE or HealBot_BuffWatch[k]==HEALBOT_DALARAN_INTELLECT then
                    if not PlayerBuffs[HEALBOT_ARCANE_INTELLECT] and not PlayerBuffs[HEALBOT_ARCANE_BRILLIANCE] and not
                       PlayerBuffs[HEALBOT_DALARAN_BRILLIANCE] and not PlayerBuffs[HEALBOT_DALARAN_INTELLECT] then
                        bName=HealBot_BuffWatch[k];
                        break
                    end
                elseif HealBot_BuffNameSwap[HealBot_BuffWatch[k]] then
                    checkthis=HealBot_BuffNameSwap[HealBot_BuffWatch[k]];
                    if not PlayerBuffs[checkthis] then
                        bName=HealBot_BuffWatch[k];
                        break
                    end
                else
                    bName=HealBot_BuffWatch[k];
                    break
                end
            end
        end
    end
    if bName then
        if HealBot_UnitBuff[hbGUID] and HealBot_UnitBuff[hbGUID]==bName then
            return
        else
            HealBot_UnitBuff[hbGUID]=bName;
            HealBot_Action_ResetUnitStatus(xUnit)
        end
    elseif HealBot_UnitBuff[hbGUID] then 
        HealBot_UnitBuff[hbGUID]=nil
        if HealBot_ThrottleCnt>3 then
            HealBot_Action_ResetUnitStatus(xUnit)
        else
            HealBot_RecalcHeals(hbGUID)
            HealBot_ThrottleCnt=HealBot_ThrottleCnt+1
        end
    end
end

local needReset=nil
function HealBot_OnEvent_PlayerRegenDisabled(self)
    if not HealBot_Loaded then return end
    if not HealBot_PlayerGUID then
        HealBot_Load("playerRD")      
        needReset=true
    elseif (Healbot_Config_Skins.TargetHeals[Healbot_Config_Skins.Current_Skin]==1 and UnitExists("target") and not UnitIsEnemy("target", "player")) or HealBot_Panel_retTestBars() or HealBot_Loaded<9 then
        HealBot_RecalcParty(true);
    else
        HealBot_EnteringCombat()
    end
    if HealBot_Config.BuffWatch==1 and HealBot_Config.BuffWatchInCombat==0 then
        for xGUID,_ in pairs(HealBot_UnitBuff) do
            HealBot_UnitBuff[xGUID]=nil
            if HealBot_UnitID[xGUID] and HealBot_Unit_Button[HealBot_UnitID[xGUID]] then
                HealBot_RecalcHeals(xGUID)
                HealBot_DelayBuffCheck[xGUID]="S"
            end
        end
        if HealBot_UnitID[HealBot_PlayerGUID] then HealBot_DelayBuffCheck[HealBot_PlayerGUID]="S"; end
    end
    
    if HealBot_Config.DebuffWatch==1 and HealBot_Config.DebuffWatchInCombat==0 then
        for xGUID,_ in pairs(HealBot_UnitDebuff) do
            HealBot_UnitDebuff[xGUID]=nil
            if HealBot_UnitID[xGUID] and HealBot_Unit_Button[HealBot_UnitID[xGUID]] then
                HealBot_RecalcHeals(xGUID)
                HealBot_DelayDebuffCheck[xGUID]="S"
            end
        end
        if HealBot_UnitID[HealBot_PlayerGUID] then HealBot_DelayDebuffCheck[HealBot_PlayerGUID]="S"; end
    end
    if Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Current_Skin]==1 and HealBot_Config.ActionVisible==0 and HealBot_Config.DisableHealBot==0 then HealBot_TogglePanel(HealBot_Action) end
    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_UnitCombat(self,"player") end
    if Healbot_Config_Skins.HighLightTargetBarInCombat[Healbot_Config_Skins.Current_Skin]==0 and HealBot_luVars["HighlightTarget"] then
        if (HealBot_Action_retAggro(HealBot_UnitGUID(HealBot_luVars["HighlightTarget"])) or "z")=="h" then
            HealBot_Action_UpdateAggro(HealBot_luVars["HighlightTarget"],"off",nil,HealBot_UnitGUID(HealBot_luVars["HighlightTarget"]))
            HealBot_luVars["HighlightTarget"]=nil
        end
    end        
end

function HealBot_OnEvent_PlayerRegenEnabled(self)
    if InCombatLockdown() then
        HealBot_luVars["IsReallyFighting"] = true
    else
        HealBot_IsFighting = nil;
    end
    if Healbot_Config_Skins.TargetHeals[Healbot_Config_Skins.Current_Skin]==1 and UnitExists("target") and not UnitIsEnemy("target", "player") then
        HealBot_RecalcParty(nil);
    end
    if needReset then
        HealBot_Reset_flag=true 
        needReset=nil
    end
    if HealBot_Config.DisableToolTipInCombat==1 then
        if HealBot_Action_TooltipUnit then
            HealBot_Action_ShowTooltip(HealBot_Action_TooltipUnit)
        elseif HealBot_Action_DisableTooltipUnit then
            HealBot_Action_ShowDisabledTooltip(HealBot_Action_DisableTooltipUnit)
        end
    end
    if HealBot_InCombatUpdCntFlag then
        HealBot_InCombatUpdCntFlag=nil
        HealBot_Reset_UnitHealth()
    end
    HealBot_ClearAggro(true)
end

function HealBot_EnteringCombat()
    if HealBot_Config.DisableToolTipInCombat==1 and (HealBot_Action_TooltipUnit or HealBot_Action_DisableTooltipUnit) then
        HealBot_Action_HideTooltipFrame()
    end
    HealBot_IsFighting = true;
end

function HealBot_OnEvent_UnitNameUpdate(self,unit)
    xGUID=HealBot_UnitGUID(unit)
    if HealBot_UnitID[xGUID] then
        if unit==HealBot_UnitID[xGUID] then
            HealBot_Action_ResetUnitStatus(unit)    
        elseif HealBot_IsFighting then 
            HealBot_InCombatUpdate=true
        else
            HealBot_UnitNameUpdate(unit,HealBot_UnitGUID(unit))
        end
    end
end

function HealBot_UnitNameUpdate(unUnit,unGUID)
    if unGUID and unGUID==HealBot_PlayerGUID then unUnit="player" end
    if HealBot_Unit_Button[unUnit] then
        if UnitExists(unUnit) and unGUID then
            HealBot_UnitName[unGUID]=UnitName(unUnit)
            HealBot_UnitID[unGUID]=unUnit
            HealBot_CheckAllDebuffs(unGUID)
            HealBot_CheckAllBuffs(unGUID)
            if HealBot_HoT_Active_Button[unGUID] then
                b=HealBot_Unit_Button[unUnit]
                if HealBot_HoT_Active_Button[unGUID]~=b then
                    HealBot_HoT_MoveIcon(HealBot_HoT_Active_Button[unGUID], b, unGUID)
                    HealBot_HoT_Active_Button[unGUID]=b
                end
            end    
            HealBot_unitHealth[unGUID]=nil
            HealBot_BarCheck[unGUID]="A"
            HealBot_ClearUnitAggro(unUnit, unGUID)
            HealBot_CheckAllUnitVehicle(unUnit)
            HealBot_Queue_MyBuffsCheck(unGUID,unUnit)
        end
        HealBot_Action_ResetUnitStatus(unUnit) 
    end
    if Delay_RecalcParty<2 then Delay_RecalcParty=2; end
end

function HealBot_UnitNameOnly(unitName)
    uName=string.match(unitName, "^[^-]*") or "noName"
    return uName
end

function HealBot_CheckHealth(hbGUID)
    if not HealBot_BarCheck[hbGUID] then 
        HealBot_BarCheck[hbGUID]="H" 
    elseif HealBot_BarCheck[hbGUID]=="P" then
        HealBot_BarCheck[hbGUID]="A"
    end
end

function HealBot_CheckPower(hbGUID)
    if not HealBot_BarCheck[hbGUID] then 
        HealBot_BarCheck[hbGUID]="P" 
    elseif HealBot_BarCheck[hbGUID]=="H" then
        HealBot_BarCheck[hbGUID]="A"
    end
end

function HealBot_IDs(unit,hbGUID)
    xUnit=HealBot_UnitID[hbGUID]
    if xUnit and not UnitIsUnit(unit,xUnit) then
        xUnit=HealBot_RaidUnit("unknown",hbGUID,nil)
        HealBot_UnitNameUpdate(xUnit,hbGUID)
    end
    return xUnit
end

function HealBot_RaidUnit(unit,hbGUID,unitName)
    if unitName then
        if not unit or UnitName(unit)~=unitName then
            unit=nil
            if unitName==HealBot_PlayerName then
                unit="player"
            elseif GetNumRaidMembers()>0 then
                for j=1,40 do
                    xUnit = "raid"..j
                    if UnitExists(xUnit) and UnitName(xUnit)==unitName then
                        unit=xUnit
                        do break end
                    end
                    xUnit = "raidpet"..j
                    if UnitExists(xUnit) and UnitName(xUnit)==unitName then
                        unit=xUnit
                        do break end
                    end
                end
            elseif GetNumPartyMembers()>0 then
                for j=1,4 do
                    xUnit = "party"..j
                    if UnitExists(xUnit) and UnitName(xUnit)==unitName then
                        unit=xUnit
                        do break end
                    end
                    xUnit = "partypet"..j
                    if UnitExists(xUnit) and UnitName(xUnit)==unitName then
                        unit=xUnit
                        do break end
                    end
                end
            end
            if not unit then
                if UnitName("focus")==unitName then
                    unit="focus"
                elseif UnitName("target")==unitName then
                    unit="target"
                end
            end
        end
    else
        if hbGUID==HealBot_PlayerGUID then
            unit="player"
        elseif Healbot_Config_Skins.SetFocusBar[Healbot_Config_Skins.Current_Skin]==1 and HealBot_UnitGUID("focus")==hbGUID then
            unit="focus"
        elseif unit and GetNumRaidMembers()>0 then
            if unit~="unknown" and HealBot_UnitID[hbGUID] and HealBot_UnitGUID(HealBot_UnitID[hbGUID])==hbGUID then
                unit=HealBot_UnitID[hbGUID]
            else
                for j=1,40 do
                    xUnit = "raid"..j
                    if UnitGUID(xUnit)==hbGUID then
                        unit=xUnit
                        do break end
                    end
                    xUnit = "raidpet"..j
                    if HealBot_UnitGUID(xUnit)==hbGUID then
                        unit=xUnit
                        do break end
                    end
                end
            end
        elseif unit and GetNumPartyMembers()>0 then
            if unit~="unknown" and HealBot_UnitID[hbGUID] and HealBot_UnitGUID(HealBot_UnitID[hbGUID])==hbGUID then
                unit=HealBot_UnitID[hbGUID]
            else
                for j=1,4 do
                    xUnit = "party"..j
                    if UnitGUID(xUnit)==hbGUID then
                        unit=xUnit
                        do break end
                    end
                    xUnit = "partypet"..j
                    if HealBot_UnitGUID(xUnit)==hbGUID then
                        unit=xUnit
                        do break end
                    end
                end
            end
        end
    end
    return unit
end

function HealBot_UnitGUID(unit)
    if not unit or not UnitExists(unit) then
        xGUID=nil
    else
        s=string.gsub(UnitName(unit), " ", "")
        if unit=="pet" then
            xGUID=UnitGUID("player")..s
            HealBot_PetGUID[UnitGUID(unit)]=xGUID
        elseif strsub(unit,1,7)=="raidpet" then
            if strsub(unit,8) and UnitGUID("raid"..strsub(unit,8)) then
                xGUID=UnitGUID("raid"..strsub(unit,8))..s
                HealBot_PetGUID[UnitGUID(unit)]=xGUID
            else
                HealBot_AddDebug("No owner found for pet "..unit.." ("..s..")")
                xGUID=UnitGUID(unit)
            end
        elseif strsub(unit,1,8)=="partypet" then
            if strsub(unit,9) and UnitGUID("party"..strsub(unit,9)) then
                xGUID=UnitGUID("party"..strsub(unit,9))..s
                HealBot_PetGUID[UnitGUID(unit)]=xGUID
            else
                HealBot_AddDebug("No owner found for pet "..unit.." ("..s..")")
                xGUID=UnitGUID(unit)
            end
        else
            xGUID=UnitGUID(unit)
        end
    end
    return xGUID
end

function HealBot_retPetGUID(hbGUID)
    return HealBot_PetGUID[hbGUID]
end

function HealBot_UnitPet(unit)
    vUnit=nil
    if unit=="player" then
        vUnit="pet"
    elseif strsub(unit,1,4)=="raid" then
        vUnit="raidpet"..strsub(unit,5)
    elseif strsub(unit,1,5)=="party" then
        vUnit="partypet"..strsub(unit,6)
    end
    return vUnit
end

function HealBot_IC_PartyMembersChanged()
    z=false
    HealBot_InCombatUpdCnt=HealBot_InCombatUpdCnt+1
    if HealBot_InCombatUpdCnt<15 then
        for x,_ in pairs(HealBot_UpUnitInCombat) do
            HealBot_UpUnitInCombat[x]=nil
        end
        for xGUID,xUnit in pairs(HealBot_UnitID) do
            if HealBot_UnitGUID(xUnit) and HealBot_UnitGUID(xUnit)~=xGUID then
                HealBot_ClearAggro(true, xUnit)
                HealBot_ClearAggro(true, HealBot_GetUnitID(xGUID))
                HealBot_UpUnitInCombat[xGUID]=xUnit
            end
       end
        for zGUID,zUnit in pairs(HealBot_UpUnitInCombat) do
            HealBot_UnitNameUpdate(HealBot_GetUnitID(zGUID),zGUID)
            HealBot_UnitNameUpdate(zUnit,HealBot_UnitGUID(zUnit))
            z=true
        end
    end
    if z then
        HealBot_InCombatUpdCnt=HealBot_InCombatUpdCnt+1
        HealBot_InCombatUpdCntFlag=true
    else
        HealBot_AddDebug("HealBot_InCombatUpdCnt="..HealBot_InCombatUpdCnt)
        HealBot_InCombatUpdate=false
        HealBot_InCombatUpdCnt=0
        if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_RaidTargetUpdate(nil) end
    end
end

function HealBot_GetUnitID(hbGUID)
    xUnit=nil
    for _,zUnit in pairs(HealBot_UnitID) do
        if HealBot_UnitGUID(zUnit)==hbGUID then
            xUnit=zUnit
            do break end
        end
    end
    return xUnit
end

function HealBot_OnEvent_PartyMembersChanged(self)
    if HealBot_IsFighting then HealBot_InCombatUpdate=true end
    HealBot_luVars["CheckSkin"]=true
    if Delay_RecalcParty<3 then Delay_RecalcParty=3; end
    HealBot_IncHeals_PartyChange()
    if Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Current_Skin]==1 then
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            if not UnitExists(xUnit) then
                HealBot_Action_ResetUnitStatus(xUnit) 
            end
        end
        HealBot_Action_CheckReserved()
    end
end

function HealBot_PartyUpdate_CheckSkin()
    _,z = IsInInstance()
    x = GetInstanceDifficulty()
    HealBot_luVars["CheckSkin"]=nil
    if z == "arena" then
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=7 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==7 then
                    Delay_RecalcParty=0
                    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                    do break end
                end
            end
        end
    elseif z=="pvp" then
        if GetNumRaidMembers()>19 then
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=10 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==10 then
                        Delay_RecalcParty=0
                        HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                        do break end
                    end
                end
            end
        elseif GetNumRaidMembers()>11 then
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=9 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==9 then
                        Delay_RecalcParty=0
                        HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                        do break end
                    end
                end
            end
        else
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=8 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==8 then
                        Delay_RecalcParty=0
                        HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                        do break end
                    end
                end
            end
        end
    elseif x==4 or (x==2 and GetNumRaidMembers()>17) then 
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=5 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==5 then
                    Delay_RecalcParty=0
                    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                    do break end
                end
            end
        end
    elseif x==3 then
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=4 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==4 then
                    Delay_RecalcParty=0
                    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                    do break end
                end
            end
        end
    elseif GetNumRaidMembers()>29 then
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=6 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==6 then
                    Delay_RecalcParty=0
                    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                    do break end
                end
            end
        end
    elseif GetNumRaidMembers()>17 then
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=5 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==5 then
                    Delay_RecalcParty=0
                    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                    do break end
                end
            end
        end
    elseif GetNumRaidMembers()>5 then
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=4 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==4 then
                    Delay_RecalcParty=0
                    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                    do break end
                end
            end
        end
    elseif GetNumPartyMembers()>0 then
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=3 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==3 then
                    Delay_RecalcParty=0
                    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                    do break end
                end
            end
        end
    else
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]~=2 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==2 then
                    Delay_RecalcParty=0
                    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[x])
                    do break end
                end
            end
        end
    end
    if Delay_RecalcParty>2 then
        HealBot_RecalcParty(nil);
    end
end

function HealBot_OnEvent_PlayerTargetChanged(self)
    if Healbot_Config_Skins.TargetHeals[Healbot_Config_Skins.Current_Skin]==1 then
        HealBot_RecalcParty(nil);
        if UnitExists("target") and not UnitIsEnemy("target", "player") then
            HealBot_OnEvent_UnitAura(nil,"target")
        end
    end
    if UnitName("target") and HealBot_retHbFocus(UnitName("target")) then
        HealBot_Panel_clickToFocus("Show")
    end
    if Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==1 then
        HealBot_luVars["HighlightTargetFound"]=false
        if not HealBot_IsFighting or Healbot_Config_Skins.HighLightTargetBarInCombat[Healbot_Config_Skins.Current_Skin]==1 then
            if UnitExists("target") and not UnitIsDeadOrGhost("target") and not UnitIsEnemy("target", "player") then
                for _,xUnit in pairs(HealBot_UnitID) do
                    if UnitIsUnit(xUnit, "target") then
                        if xUnit~="target" then 
                            if HealBot_luVars["HighlightTarget"] and 
                               HealBot_luVars["HighlightTarget"]~=xUnit and 
                               (HealBot_Action_retAggro(HealBot_UnitGUID(HealBot_luVars["HighlightTarget"])) or "z")=="h" then
                                HealBot_Action_UpdateAggro(HealBot_luVars["HighlightTarget"],"off",nil,HealBot_UnitGUID(HealBot_luVars["HighlightTarget"]))
                            end
                            HealBot_luVars["HighlightTargetFound"]=true
                            HealBot_luVars["HighlightTarget"]=xUnit
                           -- HealBot_AddDebug("Aggro Target")
                        end
                        z=HealBot_Action_RetUnitThreat(hbGUID)
                        HealBot_Action_UpdateAggro(xUnit,"target",z,HealBot_UnitGUID(xUnit))
                    end
                end
            end
        end
        if not HealBot_luVars["HighlightTargetFound"] and HealBot_luVars["HighlightTarget"] and 
          (HealBot_Action_retAggro(HealBot_UnitGUID(HealBot_luVars["HighlightTarget"])) or "z")=="h" then
            HealBot_Action_UpdateAggro(HealBot_luVars["HighlightTarget"],"off",nil,HealBot_UnitGUID(HealBot_luVars["HighlightTarget"]))
            HealBot_luVars["HighlightTarget"]=nil
        end    
    end
end

function HealBot_retHighlightTarget()
    return HealBot_luVars["HighlightTarget"] or "nil"
end

function HealBot_retHbFocus(unitName)
    if HealBot_Config.FocusMonitor[unitName] then
        if HealBot_Config.FocusMonitor[unitName]=="all" then
            return true
        else
            _,z = IsInInstance()
            if z=="pvp" or z == "arena" then 
                if HealBot_Config.FocusMonitor[unitName]=="bg" then
                    return true
                end
            elseif z==HealBot_Config.FocusMonitor[unitName] then
                return true
            else
                z = GetRealZoneText()
                if z==HealBot_Config.FocusMonitor[unitName] then
                    return true
                end
            end
        end
    end
    return false
end

function HealBot_OnEvent_ReadyCheck(self,unitName,timer)
    local isLeader = IsRaidLeader() or IsRaidOfficer() or IsPartyLeader()
    if isLeader then
        HealBot_luVars["rcEnd"]=nil
		HealBot_luVars["isLeader"]=true
        HealBot_Comms_SendAddonMsg("HealBot", "RC:I:"..unitName..":"..timer, HealBot_AddonMsgType, HealBot_PlayerName)
	else
		HealBot_luVars["isLeader"]=false
    end
end

function HealBot_OnEvent_hbReadyCheck(unitName,timer)
    local lUnit=HealBot_RaidUnit(hbTempUnitNames[unitName],nil,unitName)
    if not HealBot_luVars["rcEnd"] or HealBot_luVars["rcEnd"]<GetTime()+timer then
        if lUnit then
            hbTempUnitNames[unitName]=lUnit
            HealBot_luVars["rcEnd"]=GetTime()+timer
            if HealBot_Unit_Button[lUnit] then HealBot_OnEvent_ReadyCheckUpdate(lUnit,"Y") end
            for xUnit,_ in pairs(HealBot_Unit_Button) do
                if xUnit~=lUnit and strsub(xUnit,1,8)~="partypet" and strsub(xUnit,1,7)~="raidpet" then
                    HealBot_OnEvent_ReadyCheckUpdate(xUnit,"W")
                end
            end
        end
    end
end

function HealBot_OnEvent_ReadyCheckConfirmed(self,unit,response)
    xGUID=UnitGUID(unit)
    if not xGUID then return end
    xUnit=HealBot_IDs(unit,xGUID)
    if not xUnit then return end
    if HealBot_Unit_Button[xUnit] then 
		local hbResponse="N"
        if response then hbResponse="Y" end
		if HealBot_luVars["isLeader"] then HealBot_OnEvent_ReadyCheckUpdate(xUnit,hbResponse) end
        HealBot_Comms_SendAddonMsg("HealBot", "RC:U:"..xGUID..":"..hbResponse, HealBot_AddonMsgType, HealBot_PlayerName)
    end
end

function HealBot_OnEvent_hbReadyCheckConfirmed(hbGUID,response)
    unit=HealBot_UnitID[hbGUID] or hbGUID
    if HealBot_Unit_Button[unit] and not HealBot_luVars["isLeader"] then
        HealBot_OnEvent_ReadyCheckUpdate(unit,response)
    end
end

function HealBot_OnEvent_ReadyCheckUpdate(unit,response)
    bar = HealBot_Action_HealthBar(HealBot_Unit_Button[unit]);
    if bar then
        iconName = _G[bar:GetName().."Icon16"];
        if response=="Y" then
            iconName:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
        elseif response=="W" then
            iconName:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Waiting")
        else
            iconName:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-NotReady")
        end
        iconName:SetAlpha(1);
    end
end

function HealBot_OnEvent_ReadyCheckFinished(self)
	HealBot_luVars["rcEnd"]=GetTime()
end

function HealBot_OnEvent_ReadyCheckClear()
    for _,z in pairs(HealBot_Unit_Button) do
        bar = HealBot_Action_HealthBar(z);
        if bar then
            iconName = _G[bar:GetName().."Icon16"];
            iconName:SetAlpha(0);
        end
    end
    if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_RaidTargetUpdate(nil) end
end

function HealBot_OnEvent_RaidTargetUpdate(self)
    for _,xUnit in pairs(HealBot_UnitID) do
        if UnitExists(xUnit) then 
            x=GetRaidTargetIndex(xUnit)
            if x then
                if HealBot_RaidTargetChecked(x) then
                    HealBot_TargetIcons[xUnit]=x
                    if HealBot_debuffTargetIcon[xUnit] then HealBot_debuffTargetIcon[xUnit]=x end
                    HealBot_RaidTargetUpdate(HealBot_Unit_Button[xUnit], x, xUnit)
                end
            else
                if HealBot_debuffTargetIcon[xUnit] then
                    HealBot_RaidTargetUpdate(HealBot_Unit_Button[xUnit], nil, xUnit)
                    HealBot_debuffTargetIcon[xUnit]=0
                end
                if HealBot_TargetIcons[xUnit] then
                    HealBot_TargetIcons[xUnit]=nil
                    HealBot_RaidTargetUpdate(HealBot_Unit_Button[xUnit], nil, xUnit)
                end
            end
        end
    end
end

function HealBot_RaidTargetChecked(iconID)
    z=nil
    if iconID==1 then
        if Healbot_Config_Skins.ShowRaidIconStar[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==2 then
        if Healbot_Config_Skins.ShowRaidIconCircle[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==3 then
        if Healbot_Config_Skins.ShowRaidIconDiamond[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==4 then
        if Healbot_Config_Skins.ShowRaidIconTriangle[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==5 then
        if Healbot_Config_Skins.ShowRaidIconMoon[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==6 then
        if Healbot_Config_Skins.ShowRaidIconSquare[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==7 then
        if Healbot_Config_Skins.ShowRaidIconCross[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    elseif iconID==8 then
        if Healbot_Config_Skins.ShowRaidIconSkull[Healbot_Config_Skins.Current_Skin]==1 then z=true end
    end
    return z
end

local HealBot_TargetIconsTextures = {[1]=[[Interface\Addons\HealBot\Images\Star.tga]],
                                     [2]=[[Interface\Addons\HealBot\Images\Circle.tga]],
                                     [3]=[[Interface\Addons\HealBot\Images\Diamond.tga]],
                                     [4]=[[Interface\Addons\HealBot\Images\Triangle.tga]],
                                     [5]=[[Interface\Addons\HealBot\Images\Moon.tga]],
                                     [6]=[[Interface\Addons\HealBot\Images\Square.tga]],
                                     [7]=[[Interface\Addons\HealBot\Images\Cross.tga]],
                                     [8]=[[Interface\Addons\HealBot\Images\Skull.tga]],}
                                     
function HealBot_RaidTargetUpdate(button, iconID, unit)
    bar = HealBot_Action_HealthBar(button);
    if not bar then return end
    if (Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1) or HealBot_debuffTargetIcon[unit] then
        iconName = _G[bar:GetName().."Icon16"];
    else
        iconName = _G[bar:GetName().."Icon15"];
    end
    if iconID then
        iconName:SetTexture(HealBot_TargetIconsTextures[iconID])
        iconName:SetAlpha(1);
    else
        iconName:SetAlpha(0);
    end
end

function HealBot_RaidTargetToggle(switch)
    if switch then
        HealBot:RegisterEvent("RAID_TARGET_UPDATE")
        HealBot_OnEvent_RaidTargetUpdate(nil)
    else
        HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
        for _,xUnit in pairs(HealBot_UnitID) do
            if HealBot_TargetIcons[xUnit] then
                HealBot_TargetIcons[xUnit]=nil
                HealBot_RaidTargetUpdate(HealBot_Unit_Button[xUnit],nil,xUnit)
            end
        end
    end
end

function HealBot_OnEvent_FocusChanged(self)
    if Healbot_Config_Skins.SetFocusBar[Healbot_Config_Skins.Current_Skin]==1 and Delay_RecalcParty<2 then 
        Delay_RecalcParty=2; 
    end
end

function HealBot_TalentQuery(unit)
    TalentQuery:Query(unit)
end

function HealBot_GetUnitTalentInfo(name, realm, unit)
 --   if HealBot_InspectUnit==unit then
        xGUID=UnitGUID(unit)
        if xGUID then HealBot_GetTalentInfo(xGUID, unit) end
 --   end
end

function HealBot_GetTalentInfo(hbGUID, unit)
    if HealBot_UnitSpec[hbGUID] then
        x,y,z=0,0,0
        if hbGUID==HealBot_PlayerGUID then
            uClass=HealBot_PlayerClassEN
            i = GetActiveTalentGroup(false)
            _,_,x,_,_ = GetTalentTabInfo(1,false,nil,i)
            _,_,y,_,_ = GetTalentTabInfo(2,false,nil,i)
            _,_,z,_,_ = GetTalentTabInfo(3,false,nil,i)
        else
            _,uClass=UnitClass(unit)
            i = GetActiveTalentGroup(true)
            _,_,x,_,_ = GetTalentTabInfo(1,true,nil,i)
            _,_,y,_,_ = GetTalentTabInfo(2,true,nil,i)
            _,_,z,_,_ = GetTalentTabInfo(3,true,nil,i)
        end

        if x+y+z>0 and uClass then
            if ((x > y) and (x > z)) then
                w = 1
            elseif (y > z) then
                w = 2
            else
                w = 3
            end
            uClass=strsub(uClass,1,4)
            s=HealBot_Init_retSpec(uClass,w)
            if s then 
                if hbGUID==HealBot_PlayerGUID then HealBot_Config.CurrentSpec=w end
                HealBot_UnitSpec[hbGUID] = " "..s.." " 
                HealBot_talentSpam(hbGUID,"update",0)
            end
            --HealBot_AddDebug("tab1="..x.."  tab2="..y.."  tab3="..z)
        end
    end
end

local HealBot_PrevComm=0
function HealBot_SetAddonComms(hbInBG)
    if not hbInBG then
        if GetNumRaidMembers()>0 then
            HealBot_AddonMsgType=2;
        elseif GetNumPartyMembers()>0 then
            HealBot_AddonMsgType=3;
        else
            HealBot_AddonMsgType=4;
        end
    else
        HealBot_AddonMsgType=1;
    end
    if HealBot_PrevComm~=HealBot_AddonMsgType then
        HealBot_PrevComm=HealBot_AddonMsgType
        HealBot_IncHeals_sethbAddonMsgType(HealBot_AddonMsgType)
    end
end

function HealBot_OnEvent_PartyPetChanged(self)
    if Healbot_Config_Skins.PetHeals[Healbot_Config_Skins.Current_Skin]==1 and Delay_RecalcParty<2 then
        Delay_RecalcParty=2
    end
end

function HealBot_OnEvent_SystemMsg(self,msg)
    if type(msg)=="string" then
        if (string.find(msg, HB_ONLINE)) or (string.find(msg, HB_OFFLINE)) then
            msg = gsub(msg, "|Hplayer:([^%c^%d^%s^%p]+)|h(.+)|h", "%1")
            uName = msg:match("([^%c^%d^%s^%p]+)")
            xGUID=HealBot_Derive_GUID_fuName(uName)
            if HealBot_UnitID[xGUID] then
                if (string.find(msg, HB_ONLINE)) then
                    HealBot_Action_UnitIsOffline(xGUID,-1)
                else
                    HealBot_Action_UnitIsOffline(xGUID,time())
                end
                HealBot_Action_ResetUnitStatus(HealBot_UnitID[xGUID]);
            end
        end
    end
end

function HealBot_OnEvent_PlayerEquipmentChanged(self,unit)
    if UnitName(unit)==HealBot_PlayerName then
        HealBot_NeedEquipUpdate=true
    end
end

function HealBot_OnEvent_SpellsChanged(self, arg1)
    if arg1==0 then return; end
    HealBot_OnEvent_TalentsChanged(self)
end

function HealBot_OnEvent_TalentsChanged(self)
    HealBot_UnitSpec[HealBot_PlayerGUID] = " "
    HealBot_CheckTalents=true
end

function HealBot_OnEvent_PlayerEnteringWorld(self)
    if not HealBot_Loaded then 
        return 
    elseif not HealBot_PlayerGUID then
        HealBot_Load("playerEW")      
    end
    HealBot_luVars["DoUpdates"]=true
    HealBot_setOptions_Timer(180)
    HealBot_setOptions_Timer(190)
    HealBot_Register_Events()
    HealBot_OnEvent_ZoneChanged(self)
    HealBot_CheckAllUnitVehicle()
    if not HealBot_IsFighting then
        HealBot_RecalcParty(nil);
    else
        HealBot_RecalcParty(true);
    end
    HealBot_ClearAggro(true)
end

function HealBot_OnEvent_PlayerLeavingWorld(self)
    HealBot_luVars["DoUpdates"]=false
  --  if Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]==1 then HealBot_cpSave(HealBot_Config.CrashProtMacroName.."_0", "Clean") end
    HealBot_UnRegister_Events();
    if Healbot_Config_Skins.HidePartyFrames[Healbot_Config_Skins.Current_Skin]==1 then
        HealBot_Options_EnablePartyFrame()
    end
    if Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Current_Skin]==1 then
        HealBot_Options_EnablePlayerFrame()
        HealBot_Options_EnablePetFrame()
        HealBot_Options_EnableTargetFrame()
    end
end

local uscSpell,uscName,uscGUID=nil,nil,nil
function HealBot_OnEvent_UnitSpellcastSent(self,caster,spellName,spellRank,unitName)
    uscGUID=nil
    uscName = HealBot_UnitNameOnly(unitName)
    if uscName=="" then
        if spellName==HEALBOT_PRAYER_OF_HEALING or spellName==HEALBOT_INNER_FIRE or spellName==HEALBOT_WILD_GROWTH or spellName==HEALBOT_TRANQUILITY then 
            uscName=HealBot_PlayerName 
            uscGUID=HealBot_PlayerGUID
            if spellName==HEALBOT_INNER_FIRE then HealBot_NeedEquipUpdate=true end
        elseif spellName==HEALBOT_MENDPET then
            uscName=UnitName("pet")
            uscGUID=HealBot_UnitGUID("pet")
        end
    end
    if caster=="player" and uscName == HEALBOT_WORDS_UNKNOWN then
        uscName = HealBot_GetCorpseName(uscName)
    end
    if not uscGUID then
        if uscName==UnitName(HealBot_luVars["TargetUnitID"]) then
            uscGUID=HealBot_UnitGUID(HealBot_luVars["TargetUnitID"])
        elseif HealBot_Derive_GUID_fuName(uscName) then
            uscGUID=HealBot_Derive_GUID_fuName(uscName)
        elseif UnitName("target") and UnitName("target")==uscName then
            xUnit="target"
            uscGUID=HealBot_UnitGUID("target")
        end
    end
    xUnit = HealBot_UnitID[uscGUID];
    if caster=="player" and uscGUID and UnitExists(xUnit) then
        uscSpell=spellName.."("..spellRank..")"
        if spellName==HEALBOT_RESURRECTION or spellName==HEALBOT_ANCESTRALSPIRIT or spellName==HEALBOT_REBIRTH or spellName==HEALBOT_REDEMPTION or spellName==HEALBOT_REVIVE then
            HealBot_IamRessing = uscName;
            if HealBot_IamRessing then
                HealBot_Comms_SendAddonMsg("CTRA", "RES "..HealBot_IamRessing, HealBot_AddonMsgType, HealBot_PlayerName)
            end
            HealBot_CastingTarget = xUnit;
            if Healbot_Config_Skins.CastNotify[Healbot_Config_Skins.Current_Skin]>1 and Healbot_Config_Skins.CastNotifyResOnly[Healbot_Config_Skins.Current_Skin]==1 then
                HealBot_CastNotify(uscSpell,uscName,spellName)
            end
        elseif HealBot_Spells[uscSpell] then
            if HealBot_Spells[uscSpell].CastTime>=1 then
                if HealBot_IamHealing then
                    HealBot_OnEvent_UnitSpellcastFail(nil,"player",HealBot_HealData.Spell) -- Chances are there is no fail, only lag but fail will stop the last cast.
                    HealBot_IamHealing=nil
                end
                if HealBot_initHealData[spellName] then
                    HealBot_IncHeals_setHealValues(HealBot_PlayerName, spellName, HealBot_Spells[uscSpell].HealsCast+HealBot_Spells[uscSpell].RealHealing)
                    if spellName==HEALBOT_REGROWTH then HealBot_IncHeals_setHealValues(HealBot_PlayerName, "H"..spellName, HealBot_Spells[uscSpell].HealsExt+HealBot_Spells[uscSpell].RealHealing) end
                    HealBot_initHealData[spellName]=nil
                end
                if spellName==HEALBOT_BINDING_HEAL then
                    if HealBot_Config.HealCommMethod>1 then
                        HealBot_AddIamHealingList(HealBot_PlayerGUID)
                        HealBot_AddIamHealingList(uscGUID)
                    end
                elseif spellName==HEALBOT_PRAYER_OF_HEALING then
                    utGUID=HealBot_RetGroupGUIDs(uscGUID)
                    utGUID = HealBot_Split(utGUID, ":");
                    table.foreach(utGUID, function (index,xGUID)
                        if HealBot_UnitID[xGUID] and HealBot_UnitInRange(HEALBOT_PRAYER_OF_HEALING, HealBot_UnitID[xGUID])==1 then
                            if HealBot_Config.HealCommMethod>1 then HealBot_AddIamHealingList(xGUID) end
                        end
                    end)
                elseif uscName then
                    if HealBot_Config.HealCommMethod>1 then HealBot_AddIamHealingList(uscGUID) end
                end
                if HealBot_IamHealing and HealBot_IncHeals_hbFixedSpells(spellName) then
                    HealBot_HealData.Spell=spellName
                    HealBot_HealData.EndTime=GetTime()+HealBot_Spells[uscSpell].CastTime+0.2
                    if HealBot_Config.HealCommMethod==2 or HealBot_Config.HealCommMethod==4 then
                        HealBot_IncHeals_parseHBincHeals(spellName, HealBot_IamHealing, "D", HealBot_HealData.EndTime)
                    end
                    if spellName==HEALBOT_REGROWTH then HealBot_AddHoThbHeals(uscGUID, "H"..spellName, uscSpell) end
                elseif HealBot_IamHealing then
                    HealBot_IamHealing=nil
                end
            elseif HealBot_Spells[uscSpell].Duration and HealBot_Spells[uscSpell].Duration>0 and HealBot_Config.HealCommMethod>1 and HealBot_IncHeals_hbFixedSpells(spellName) then
                if HealBot_initHealData[spellName] then
                    HealBot_IncHeals_setHealValues(HealBot_PlayerName, spellName, HealBot_Spells[uscSpell].HealsExt+HealBot_Spells[uscSpell].RealHealing)
                    HealBot_initHealData[spellName]=nil
                end
                HealBot_AddHoThbHeals(uscGUID, spellName, uscSpell)
            end
            HealBot_CastingTarget = xUnit;
        end
        if HealBot_Spells[uscSpell] or HealBot_OtherSpells[uscSpell] then
            if Healbot_Config_Skins.CastNotify[Healbot_Config_Skins.Current_Skin]>1 and Healbot_Config_Skins.CastNotifyResOnly[Healbot_Config_Skins.Current_Skin]==0 then
                HealBot_CastNotify(uscSpell,uscName,spellName)
            end
        end
    end
    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_UnitCombat(self,"player") end
end

function HealBot_AddHoThbHeals(hbGUID, spellName, spell)
    z=GetTime()+HealBot_Spells[spell].CastTime+HealBot_Spells[spell].Duration
    HealBot_IncHeals_parseHBincHeals(spellName, hbGUID, "H", z)
end

function HealBot_GetCorpseName(cName)
    z = _G["GameTooltipTextLeft1"];
    x = z:GetText();
    if (x) then
        cName = string.gsub(x, HEALBOT_TOOLTIP_CORPSE, "")
    end
    return cName
end

function HealBot_AddIamHealingList(hbGUID)
    if Healbot_Config_Skins.ShowIncHeals[Healbot_Config_Skins.Current_Skin]==1 then
        if HealBot_IamHealing then
            HealBot_IamHealing=HealBot_IamHealing..":"..hbGUID
        else
            HealBot_IamHealing=hbGUID
        end
    end
end

function HealBot_ResetCheckBuffsTime()
    HealBot_CheckBuffsTime=GetTime()+10000200
    for z,_ in pairs(HealBot_PlayerBuff) do
        if HealBot_PlayerBuff[z] then
            PlayerBuffsGUID=HealBot_PlayerBuff[z]
            for y,_ in pairs (PlayerBuffsGUID) do
                if PlayerBuffsGUID[y]<0 then
                    PlayerBuffsGUID[y]=nil
                elseif PlayerBuffsGUID[y] < HealBot_CheckBuffsTime then
                    HealBot_CheckBuffsTime=PlayerBuffsGUID[y]
                    HealBot_CheckBuffsTimehbGUID=z
                end
            end
        end
    end
    if HealBot_CheckBuffsTime>GetTime()+10000000 then
        HealBot_CheckBuffsTime=nil
        HealBot_CheckBuffsTimehbGUID=nil
    end
end

function HealBot_CastNotify(spellrank,unitName,spell)
    z = Healbot_Config_Skins.CastNotify[Healbot_Config_Skins.Current_Skin];
    if HealBot_Spells[spellrank] then
        if HealBot_Spells[spellrank].HealsDur>0 then
            s = gsub(Healbot_Config_Skins.NotifyHealMsg[Healbot_Config_Skins.Current_Skin],"#s",spell)
            s = gsub(s,"#n",unitName)
            s = gsub(s,"#h",HealBot_Spells[spellrank].HealsDur)
        else
            s = gsub(Healbot_Config_Skins.NotifyOtherMsg[Healbot_Config_Skins.Current_Skin],"#s",spell)
            s = gsub(s,"#n",unitName)
        end
    elseif HealBot_OtherSpells[spellrank] then
        if HealBot_OtherSpells[spellrank].HealsDur and HealBot_OtherSpells[spellrank].HealsDur>0 then
            s = gsub(Healbot_Config_Skins.NotifyHealMsg[Healbot_Config_Skins.Current_Skin],"#s",spell)
            s = gsub(s,"#n",unitName)
            s = gsub(s,"#h",HealBot_Spells[spellrank].HealsDur)
        else
            s = gsub(Healbot_Config_Skins.NotifyOtherMsg[Healbot_Config_Skins.Current_Skin],"#s",spell)
            s = gsub(s,"#n",unitName)
        end
    else
        s = gsub(Healbot_Config_Skins.NotifyOtherMsg[Healbot_Config_Skins.Current_Skin],"#s",spell)
        s = gsub(s,"#n",unitName)
    end
    w=nil;
    if z==6 then
        w=HealBot_Comms_GetChan(Healbot_Config_Skins.NotifyChan[Healbot_Config_Skins.Current_Skin]) 
        if not w then z=2 end
    end
    if z==5 and GetNumRaidMembers()==0 then z = 4 end
    if z==4 and GetNumPartyMembers()==0 then z = 2 end
    if z==3 and not (UnitPlayerControlled(HealBot_CastingTarget) and HealBot_CastingTarget~='player' and HealBot_CastingTarget~='pet') then z = 2 end
    if z==3 then
        s = gsub(s,unitName,HEALBOT_WORDS_YOU)
        SendChatMessage(s,"WHISPER",nil,unitName);
    elseif z==4 then
        SendChatMessage(s,"PARTY",nil,nil);
    elseif z==5 then
        SendChatMessage(s,"RAID",nil,nil);
    elseif z==6 then
        SendChatMessage(s,"CHANNEL",nil,w);
    else
        HealBot_AddChat(s);
    end
end

-- HealBot_IncHeals_retHealsIn(hbGUID)
function HealBot_Titan_Check()
    if HealBot_CastingTarget and UnitExists(HealBot_CastingTarget) and HealBot_IncHeals_retHealsIn(HealBot_UnitGUID(HealBot_CastingTarget))>0 then
        return UnitName(HealBot_CastingTarget), HealBot_IncHeals_retHealsIn(HealBot_UnitGUID(HealBot_CastingTarget))
    else
        return nil, nil
    end
end

function HealBot_OnEvent_UnitSpellcastStart(self,unit,spellName)
    if not HealBot_Unit_Button[unit] then return end
    if UnitGUID(unit)==HealBot_PlayerGUID then
        if HealBot_IamHealing and HealBot_Config.HealCommMethod>2 and HealBot_HealData.Spell==spellName then
            if HealBot_Config.HealCommMethod==3 or HealBot_Config.HealCommMethod==5 then 
                HealBot_IncHeals_parseHBincHeals(spellName, HealBot_IamHealing, "D", HealBot_HealData.EndTime)
            end
        end
    end
    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_UnitCombat(self,unit) end
end

function HealBot_setHealsIncEndTime(hbGUID, casterName, endTime)
    s=hbGUID..":"..casterName
    if HealBot_HealsIncEndTime[s] then
        if HealBot_HealsIncEndTime[s]<endTime then
            HealBot_HealsIncEndTime[s]=endTime
        end
    else
        HealBot_HealsIncEndTime[s]=endTime
    end
end

function HealBot_OnEvent_UnitSpellcastStop(self,unit,spellName)
    if not HealBot_Unit_Button[unit] then return end
    if UnitGUID(unit)==HealBot_PlayerGUID then
        if HealBot_IamRessing then
            HealBot_Comms_SendAddonMsg("CTRA", "RESNO", HealBot_AddonMsgType, HealBot_PlayerName)
            HealBot_IamRessing=nil;
        elseif HealBot_IamHealing and HealBot_HealData.Spell==spellName then
            HealBot_IncHeals_parseHBincHeals(spellName, HealBot_IamHealing, "E")
            HealBot_IamHealing=nil
        end
    end
    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_UnitCombat(self,unit) end
end

function HealBot_OnEvent_UnitSpellcastFail(self,unit,spellName)
    if not HealBot_Unit_Button[unit] then return end
    if UnitGUID(unit)==HealBot_PlayerGUID then
        if HealBot_IamRessing then
            HealBot_Comms_SendAddonMsg("CTRA", "RESNO", HealBot_AddonMsgType, HealBot_PlayerName)
            HealBot_IamRessing=nil;
        elseif HealBot_IamHealing and HealBot_HealData.Spell==spellName then
            HealBot_IncHeals_parseHBincHeals(spellName, HealBot_IamHealing, "E")
            HealBot_IamHealing=nil
        end
    end
    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_UnitCombat(self,unit) end
end

local hbHoTinterval = { [HEALBOT_RENEW] = 3,
                        [HEALBOT_REGROWTH] = 3,
                        [HEALBOT_REJUVENATION] = 3,
                        [HEALBOT_LIFEBLOOM] = 1,
                        [HEALBOT_WILD_GROWTH] = 1,
                        [HEALBOT_RIPTIDE] = 3,
                      }
                      
function HealBot_HoT_incHealsStart(hbGUID, hbUID, spellName, casterUnitID, healValue)
    if spellName=="H"..HEALBOT_REGROWTH then spellName=HEALBOT_REGROWTH end
    HealBot_HoTincData[hbUID]={}
    HealBot_HoTincData[hbUID].Spell=spellName
    HealBot_HoTincData[hbUID].tickHealValue=floor(healValue/(HealBot_Spells[spellName].Duration/hbHoTinterval[spellName]))
    HealBot_HoTincData[hbUID].cUnit=casterUnitID
    HealBot_HoTincData[hbUID].Found=false
    if spellName==HEALBOT_REGROWTH then
        HealBot_HoTincData[hbUID].Time=GetTime()+3.25
    else
        HealBot_HoTincData[hbUID].Time=GetTime()+1.25
    end
    HealBot_HoT_incHealsCheck(hbGUID, hbUID)
    HealBot_HoTincHeals[hbUID]=hbGUID
end

function HealBot_HoT_incHealsCheck(hbGUID, hbUID)
    HoTActive, expirationTime, bCount=HealBot_HasUnitBuff(HealBot_HoTincData[hbUID].Spell, HealBot_UnitID[hbGUID], HealBot_HoTincData[hbUID].cUnit)
    if HoTActive then
        x=ceil((expirationTime-GetTime())/3)
        y=ceil(Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["H"]/hbHoTinterval[HealBot_HoTincData[hbUID].Spell])
        if x<y then y=x end
        if y<1 then y=1 end
        z=floor(HealBot_HoTincData[hbUID].tickHealValue*y)
        if not HealBot_HoTincData[hbUID].Found then
            if HealBot_HoTincData[hbUID].Spell==HEALBOT_REGROWTH then
                HealBot_IncHeals_parseHBincHeals(HealBot_HoTincData[hbUID].Spell, hbGUID, "E")
            end
            HealBot_HoTincData[hbUID].Found=true
        end
        HealBot_IncHeals_CommHoTtickUpdate(hbGUID, z, hbUID)
    elseif HealBot_HoTincData[hbUID].Time<GetTime() then
        HealBot_IncHeals_CommHoTtickUpdate(hbGUID, 0, hbUID)
        HealBot_HoTincData[hbUID]=nil
        HealBot_HoTincHeals[hbUID]=nil
    end
end

function HealBot_spellEndTimes(spellName)
	if HealBot_Spells[spellName] then
		z=HealBot_Spells[spellName].Duration or 15
	else
		HealBot_Spells[spellName].Duration=15
		z=15
    end
    x=GetTime()+z
    return x
end

local HoTtxt2=nil
local temp_caster={}
local temp_HoT={}
function HealBot_HoT_Update(hbGUID, hotID)
    huUnit=HealBot_UnitID[hbGUID]
    huHoTtime=HealBot_Player_HoT[hbGUID]
    huHoTicon=HealBot_Player_HoT_Icons[hbGUID]
    _, hotName=string.split("!", hotID)
    iTexture=HealBot_Icon_Texture(hotName)
    secLeft=floor(huHoTtime[hotID]-GetTime())
    
    if huHoTicon[hotID]>0 then
        if secLeft<0 then
            HealBot_HoT_UpdateIcon(HealBot_Unit_Button[huUnit], huHoTicon[hotID], -1)
            huHoTtime[hotID]=9
            huHoTicon[hotID]=0
            if HealBot_HoT_Count[hotID] and HealBot_HoT_Count[hotID][hbGUID] then
                HealBot_HoT_Count[hotID][hbGUID]=nil
            end
            if not HealBot_DeBuff_Texture[hotName] then 
                HealBot_HoT_RefreshIcons(hbGUID,HealBot_Unit_Button[huUnit]) 
            else
                if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
                    HealBot_Action_SetClassIconTexture(HealBot_Unit_Button[huUnit], huUnit)
                    if HealBot_debuffTargetIcon[huUnit] then HealBot_debuffTargetIcon[huUnit]=nil end
                elseif Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 and HealBot_debuffTargetIcon[huUnit] and HealBot_debuffTargetIcon[huUnit]>0 then
                    HealBot_RaidTargetUpdate(HealBot_Unit_Button[huUnit], nil, huUnit)
                    HealBot_debuffTargetIcon[huUnit]=nil
                    HealBot_RaidTargetUpdate(HealBot_Unit_Button[huUnit], HealBot_TargetIcons[huUnit], huUnit)
                end
            end
        else
            HealBot_HoT_UpdateIcon(HealBot_Unit_Button[huUnit], huHoTicon[hotID], secLeft, iTexture, hotID, hbGUID)
        end
    else
        if HealBot_DeBuff_Texture[hotName] then
            i=15
            if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then
                if HealBot_TargetIcons[huUnit] then
                    HealBot_debuffTargetIcon[huUnit]=HealBot_TargetIcons[huUnit]
                    HealBot_RaidTargetUpdate(HealBot_Unit_Button[huUnit], HealBot_TargetIcons[huUnit], huUnit)
                else
                    HealBot_debuffTargetIcon[huUnit]=0
                end
            end
        else
            i=1
            for k,z in pairs(huHoTicon) do 
                _,w=string.split("!", k)
                if z>0 and not HealBot_DeBuff_Texture[w] then 
                    i=i+1
                end 
            end  
        end
        if HealBot_DeBuff_Texture[hotName] or i<15 then 
            huHoTicon[hotID]=i
            HealBot_HoT_UpdateIcon(HealBot_Unit_Button[huUnit], huHoTicon[hotID], secLeft, iTexture, hotID, hbGUID)
            HealBot_HoT_Active_Button[hbGUID]=HealBot_Unit_Button[huUnit]
        end
    end
end

function HealBot_retdebuffTargetIcon(unit)
    if HealBot_debuffTargetIcon[unit] and HealBot_debuffTargetIcon[unit]>0 then
        return true
    else
        return false
    end
end

local temp_icons={}
function HealBot_HoT_RefreshIcons(hbGUID,button)
    huHoTtime=HealBot_Player_HoT[hbGUID]
    huHoTicon=HealBot_Player_HoT_Icons[hbGUID]
    if not huHoTtime then 
        HealBot_HoT_RemoveIcon(hbGUID)
        HealBot_AddDebug("huHoTtime==nil in HealBot_HoT_RefreshIcons")
    else
        z=0
        for bName,k in pairs(huHoTicon) do
            temp_caster[k],temp_HoT[k]=string.split("!", bName)
            if k>0 and not HealBot_DeBuff_Texture[temp_HoT[k]] then 
                temp_icons[k]=bName
                z=z+1
            end
        end
        if z>0 then
            for i=1,13 do
                if not temp_icons[i] then
                    if temp_icons[i+1] then
                        HealBot_HoT_UpdateIcon(button, i+1, -1)
                        secLeft=floor(huHoTtime[temp_icons[i+1]]-GetTime())
                        iTexture=HealBot_Icon_Texture(temp_HoT[i+1])
                        HealBot_HoT_UpdateIcon(button, i, secLeft, iTexture, temp_icons[i+1], hbGUID)
                        -- HealBot_HoT_Update(hbGUID, temp_icons[i+1])
                        huHoTicon[temp_icons[i+1]]=i
                        temp_icons[i+1]=nil
                    end
                end
                temp_icons[i]=nil
            end
        else
            HealBot_HoT_Active_Button[hbGUID]=nil
        end
    end
end

function HealBot_retHoTdetails(hbGUID)
    return HealBot_Player_HoT_Icons[hbGUID], HealBot_Player_HoT[hbGUID]
end

function HealBot_retHoTcount(hotID,hbGUID)
    if HealBot_HoT_Count[hotID] then
        return HealBot_HoT_Count[hotID][hbGUID]
    end
end

function HealBot_HoT_MoveIcon(oldButton, newButton, hbGUID)
    huHoTtime=HealBot_Player_HoT[hbGUID]
    huHoTicon=HealBot_Player_HoT_Icons[hbGUID]
    if not huHoTicon then 
        -- HealBot_AddDebug("huHoTicon is NIL in HealBot_HoT_MoveIcon")
        return 
    end
    for bName,i in pairs(huHoTicon) do
        if i>0 then
            HealBot_HoT_UpdateIcon(oldButton, huHoTicon[bName], -1)
            if huHoTtime[bName] then
                secLeft=floor(huHoTtime[bName]-GetTime())
            else
                secLeft=10
            end
            _,w=string.split("!", bName)
            iTexture=HealBot_Icon_Texture(w)
            HealBot_HoT_UpdateIcon(newButton, i, secLeft, iTexture, bName, hbGUID)
        end
    end
    if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 and HealBot_debuffTargetIcon[huUnit] and HealBot_debuffTargetIcon[huUnit]>0 then
        HealBot_RaidTargetUpdate(oldButton, nil, huUnit)
        HealBot_RaidTargetUpdate(newButton, HealBot_debuffTargetIcon[huUnit], huUnit)
    end
end

function HealBot_HoT_RemoveIcon(hbGUID)
    z=HealBot_HoT_Active_Button[hbGUID];
    huHoTicon=HealBot_Player_HoT_Icons[hbGUID]
    if not huHoTicon then 
      --  HealBot_AddDebug("huHoTicon is NIL in HealBot_HoT_RemoveIcon")
        return 
    end
    for _,i in pairs(huHoTicon) do
        if i>0 then
            HealBot_HoT_UpdateIcon(z, i, -1)
        end
    end
    HealBot_HoT_Active_Button[hbGUID]=nil;
end

function HealBot_HoT_RemoveIconButton(button,removeAll)
    for i=1,15 do
        HealBot_HoT_UpdateIcon(button, i, -1)
    end
    if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 and HealBot_debuffTargetIcon[button.unit] and HealBot_debuffTargetIcon[button.unit]>0 then
        HealBot_RaidTargetUpdate(button, nil, button.unit)
        HealBot_debuffTargetIcon[button.unit]=nil
    end
    if not removeAll then
        if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
            HealBot_Action_SetClassIconTexture(button, button.unit)
        end
        if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 and HealBot_TargetIcons[button.unit] then
            HealBot_OnEvent_RaidTargetUpdate(nil)
        end
    end
end

local iconTxt=nil
local hbiconcount=nil
local hbiconcount2=nil

function HealBot_HoT_UpdateIcon(button, index, secLeft, Texture, hotID, hbGUID)
    if not button then return; end;
    bar = HealBot_Action_HealthBar(button);
    iconName = _G[bar:GetName().."Icon"..index];
    if not iconName then
        HealBot_AddDebug("iconName is nil index="..index)
        return
    end
    hbiconcount = _G[bar:GetName().."Count"..index];
    hbiconcount2 = _G[bar:GetName().."Count"..index.."a"];
    x=HealBot_HoT_AlphaValue(secLeft)
    if index==15 then
        iconName:SetTexCoord(0,1,0,1);
        if x>0 then x=1 end
    end
    iconName:SetAlpha(x)
    if x==0 then 
        hbiconcount:SetTextColor(1,1,1,0);
        hbiconcount2:SetTextColor(1,1,1,0)
        hbiconcount:SetText(" ");
        hbiconcount2:SetText(" ");
    else
        xGUID, sName=string.split("!", hotID or "H!B")
        if (Healbot_Config_Skins.ShowIconTextCountSelfCast==1 and xGUID~=HealBot_PlayerGUID) or Healbot_Config_Skins.ShowIconTextCount[Healbot_Config_Skins.Current_Skin]==0 then
            iconTxt=nil
        else
            if HealBot_HoT_Count[hotID] and HealBot_HoT_Count[hotID][hbGUID] then
                iconTxt=HealBot_HoT_Count[hotID][hbGUID]
            elseif sName==HEALBOT_POWER_WORD_SHIELD and HealBot_TrackWS[hbGUID] then
                if HealBot_TrackWS[hbGUID]=="-" and HealBot_Config.ShowWSicon==1 then
                    Texture=HealBot_HoT_Texture[HEALBOT_DEBUFF_WEAKENED_SOUL]
                    iconTxt=nil
                else
                    iconTxt=HealBot_TrackWS[hbGUID]
                end
            elseif HealBot_DeBuff_Texture[sName] and DeBuff_Count[hbGUID]>0 then
                iconTxt=DeBuff_Count[hbGUID]
            else
                iconTxt=nil
            end
        end
        if Texture then iconName:SetTexture(Texture); end
        if iconTxt then
            hbiconcount2:SetText(iconTxt);
            hbiconcount2:SetTextColor(1,1,1,1);
        else
            hbiconcount2:SetText(" ");
            hbiconcount2:SetTextColor(1,1,1,0);
        end
        if (Healbot_Config_Skins.ShowIconTextDurationSelfCast==1 and xGUID~=HealBot_PlayerGUID) or Healbot_Config_Skins.ShowIconTextDuration[Healbot_Config_Skins.Current_Skin]==0 then
            iconTxt=nil
        else
            iconTxt=secLeft
        end
        hbiconcount:SetText(iconTxt or " ");
        if not iconTxt or iconTxt<0 or iconTxt>Healbot_Config_Skins.IconTextDurationShow[Healbot_Config_Skins.Current_Skin] then
            hbiconcount:SetTextColor(1,1,1,0);
        elseif iconTxt<=Healbot_Config_Skins.IconTextDurationWarn[Healbot_Config_Skins.Current_Skin] then
            if (Texture==HealBot_HoT_Texture[HEALBOT_REJUVENATION] or Texture==HealBot_HoT_Texture[HEALBOT_REGROWTH]) then
                y, x, _ = GetSpellCooldown(HEALBOT_SWIFTMEND);
                if x and y and (x+y)==0 then
                    hbiconcount:SetTextColor(0,1,0,1);
                else
                    hbiconcount:SetTextColor(1,0,0,1);        
                end
            else
                hbiconcount:SetTextColor(1,0,0,1);           
            end
        else
            hbiconcount:SetTextColor(1,1,1,1);
        end   
    end    
end 

function HealBot_HoT_AlphaValue(secLeft)
    if not UnitIsDeadOrGhost("player") then
        if secLeft>=0 and secLeft<6 then
            return (secLeft/9)+.4
        elseif secLeft<0 then
            return 0
        else
            return 1
        end
    end
    return 0
end

function HealBot_Icon_Texture(spellName)
    if HealBot_HoT_Texture[spellName] then
        return HealBot_HoT_Texture[spellName]
    elseif HealBot_DeBuff_Texture[spellName] then
        return HealBot_DeBuff_Texture[spellName]
    else
        return nil
    end
end

function HealBot_ToggelFocusMonitor(unitName, zone)
    if HealBot_Config.FocusMonitor[unitName] then
        if UnitName("target") and unitName==UnitName("target") then HealBot_Panel_clickToFocus("hide") end
        HealBot_Config.FocusMonitor[unitName] = nil
    else
        HealBot_Config.FocusMonitor[unitName] = zone
        if UnitName("target") and HealBot_Config.FocusMonitor[UnitName("target")] then HealBot_Panel_clickToFocus("Show") end
    end
end

function HealBot_PlaySound(id)
    if HealBot_Loaded then
        PlaySoundFile(LSM:Fetch('sound',id));
    end
end

function HealBot_InitSpells()

    for x,_ in pairs(HealBot_SmartCast_Spells) do
        HealBot_SmartCast_Spells[x]=nil;
    end
  
    HealBot_Init_Spells_Defaults(HealBot_PlayerClassEN);
  
    for x in pairs(HealBot_Spells) do
        if not HealBot_Spells[x].RealHealing then
            HealBot_Spells[x].RealHealing=0;
        end
        if not HealBot_Spells[x].HealsDur then
           HealBot_Spells[x].HealsDur=0;
        end
        HealBot_InitClearSpellNils(x)
    end

    id = 1
    z = 0;  
    local lsName,lsRank,iSpell,lsValue,tmpName = nil,nil,nil,0,"none"
    while true do
        lsName, lsRank = HealBot_GetSpellName(id);
        iSpell=nil;
        if not lsName then
            break
        end
        if lsRank then
            iSpell=lsName .. "(" .. lsRank .. ")";
        end
        if tmpName~=lsName then
            lsValue=0
            tmpName=lsName
        end
        if (HealBot_Spells[iSpell]) then
            HealBot_Spells[iSpell].id = id;
            HealBot_InitGetSpellData(iSpell, id, HealBot_PlayerClassEN, lsName);
            if (HealBot_Spells[iSpell].HealsMax+HealBot_Spells[iSpell].HealsExt)>lsValue then
                HealBot_Spells[iSpell].spell=lsName
                HealBot_Spells[lsName].Duration=HealBot_Spells[iSpell].Duration
                HealBot_Spells[lsName].Level=HealBot_Spells[iSpell].Level
                lsValue=HealBot_Spells[iSpell].HealsMax+HealBot_Spells[iSpell].HealsExt
            end
            z = z + 1;
        end
        id = id + 1;
    end
    if strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_PRIEST] then
        if UnitLevel("player") < 20 then
            sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_LESSER_HEAL))
            if sName and sRank then
                HealBot_SmartCast_Spells[HEALBOT_LESSER_HEAL]=sName .. "(" .. sRank .. ")"
            elseif sName then
                HealBot_SmartCast_Spells[HEALBOT_LESSER_HEAL]=sName
            end
        end
        if UnitLevel("player") < 40 then
            sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_HEAL))
            if sName and sRank then
                HealBot_SmartCast_Spells[HEALBOT_HEAL]=sName .. "(" .. sRank .. ")"
            elseif sName then
                HealBot_SmartCast_Spells[HEALBOT_HEAL]=sName
            end
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_GREATER_HEAL))
        if sName and sRank then
            HealBot_SmartCast_Spells[HEALBOT_GREATER_HEAL]=sName .. "(" .. sRank .. ")"
        elseif sName then
            HealBot_SmartCast_Spells[HEALBOT_GREATER_HEAL]=sName
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_RENEW))
        if sName and sRank then
            HealBot_SmartCast_Spells[HEALBOT_RENEW]=sName .. "(" .. sRank .. ")"
        elseif sName then
            HealBot_SmartCast_Spells[HEALBOT_RENEW]=sName
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_FLASH_HEAL))
        if sName and sRank then
            HealBot_SmartCast_Spells[HEALBOT_FLASH_HEAL]=sName .. "(" .. sRank .. ")"
        elseif sName then
            HealBot_SmartCast_Spells[HEALBOT_FLASH_HEAL]=sName
        end
    elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_DRUID] then
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_REGROWTH))
        if sName and sRank then
            HealBot_SmartCast_Spells[HEALBOT_REGROWTH]=sName .. "(" .. sRank .. ")"
        elseif sName then
            HealBot_SmartCast_Spells[HEALBOT_REGROWTH]=sName
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_HEALING_TOUCH))
        if sName and sRank then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_TOUCH]=sName .. "(" .. sRank .. ")"
        elseif sName then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_TOUCH]=sName
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_REJUVENATION))
        if sName and sRank then
            HealBot_SmartCast_Spells[HEALBOT_REJUVENATION]=sName .. "(" .. sRank .. ")"
        elseif sName then
            HealBot_SmartCast_Spells[HEALBOT_REJUVENATION]=sName
        end
    elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_PALADIN] then
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_HOLY_LIGHT))
        if sName and sRank then
            HealBot_SmartCast_Spells[HEALBOT_HOLY_LIGHT]=sName .. "(" .. sRank .. ")"
        elseif sName then
            HealBot_SmartCast_Spells[HEALBOT_HOLY_LIGHT]=sName
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_FLASH_OF_LIGHT))
        if sName and sRank then
            HealBot_SmartCast_Spells[HEALBOT_FLASH_OF_LIGHT]=sName .. "(" .. sRank .. ")"
        elseif sName then
            HealBot_SmartCast_Spells[HEALBOT_FLASH_OF_LIGHT]=sName
        end
    elseif strsub(HealBot_PlayerClassEN,1,4)==HealBot_Class_En[HEALBOT_SHAMAN] then
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_HEALING_WAVE))
        if sName and sRank then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_WAVE]=sName .. "(" .. sRank .. ")"
        elseif sName then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_WAVE]=sName
        end
        sName,sRank= HealBot_GetSpellName(HealBot_GetSpellId(HEALBOT_LESSER_HEALING_WAVE))
        if sName and sRank then
            HealBot_SmartCast_Spells[HEALBOT_LESSER_HEALING_WAVE]=sName .. "(" .. sRank .. ")"
        elseif sName then
            HealBot_SmartCast_Spells[HEALBOT_LESSER_HEALING_WAVE]=sName
        end
    end
    HealBot_Action_SetrSpell()
    HealBot_AddDebug("Initiated HealBot with ".. z .." Spells");
    HealBot_Options_CheckCombos();
    HealBot_Init_SmartCast();
end

function HealBot_InitNewChar(PlayerClassEN)
    if HealBot_Config.EnabledKeyCombo then
        HealBot_Config.DisabledKeyCombo=HealBot_Config.EnabledKeyCombo
    else
        HealBot_DoReset_Spells(PlayerClassEN)
        HealBot_DoReset_Cures(PlayerClassEN)
        HealBot_DoReset_Buffs(PlayerClassEN)
        HealBot_Config.HealBotBuffColR = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
        HealBot_Config.HealBotBuffColG = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
        HealBot_Config.HealBotBuffColB = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
        HealBot_Update_SpellCombos()
        HealBot_Update_BuffsForSpec()
        Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Current_Skin]=GetScreenHeight()/2
        Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Current_Skin]=GetScreenWidth()/2
        HealBot_Action_setPoint()
        HealBot_Action_unlockFrame()
    end
end

function HealBot_ToggleOptions()
    HealBot_TogglePanel(HealBot_Options)
end

function HealBot_HasTalent(tab,icon,talentName)
    s,_,_,_,z,_ = GetTalentInfo(tab,icon);
    if s then
        if s~=talentName then
            HealBot_AddDebug("ERROR: in function HealBot_HasTalent");
            HealBot_AddDebug("found talent "..s.." when expecting "..talentName);
            z=0
        end
    else
        z=0
    end
    return z
end

function HealBot_MMButton_UpdatePosition()
    HealBot_ButtonFrame:SetPoint(
        "TOPLEFT",
        "Minimap",
        "TOPLEFT",
        54 - (HealBot_Config.HealBot_ButtonRadius * cos(HealBot_Config.HealBot_ButtonPosition)),
        (HealBot_Config.HealBot_ButtonRadius * sin(HealBot_Config.HealBot_ButtonPosition)) - 55
    );
end

function HealBot_MMButton_OnLoad(self)
    g=_G[self:GetName().."Icon"]
    g:SetVertexColor(1, 1, 0);
    self:RegisterForDrag("RightButton");
    self.dragme = false;
end

function HealBot_MMButton_Init()
    if HealBot_Config.ButtonShown==1 then
        HealBot_ButtonFrame:Show();
        HealBot_MMButton_UpdatePosition()
    else
        HealBot_ButtonFrame:Hide();
    end
end

function HealBot_MMButton_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT");
    GameTooltip:SetText(HEALBOT_BUTTON_TOOLTIP);
    GameTooltipTextLeft1:SetTextColor(1, 1, 1);
    GameTooltip:Show();
end

function HealBot_MMButton_OnClick(self,button)
    if button~="RightButton" then
        HealBot_ToggleOptions()
    else
        HealBot_AddDebug("right click")
    end
end

function HealBot_MMButton_BeingDragged()
    w,x = GetCursorPosition() 
    y,z = Minimap:GetLeft(), Minimap:GetBottom() 
    w = y-w/UIParent:GetScale()+70 
    x = x/UIParent:GetScale()-z-70 
    HealBot_MMButton_SetPosition(math.deg(math.atan2(x,w)));
end

function HealBot_MMButton_SetPosition(c)
    if(c < 0) then
        c = c + 360;
    end

    HealBot_Config.HealBot_ButtonPosition = c;
    HealBot_MMButton_UpdatePosition();
end

function HealBot_SmartCast(hbGUID,hlthDelta)
    w=nil;
    x=0;
    y=0;
    z=false;
    for sName,sNameRank in pairs(HealBot_SmartCast_Spells) do
        if (HealBot_Spells[sNameRank]) then
            if HealBot_Spells[sNameRank].HealsDur<(hlthDelta*2) then
                if HealBot_Spells[sNameRank].Buff then
                    if HealBot_HasBuff(sName,HealBot_UnitID[hbGUID]) then 
                        z=false;  
                    else
                        z=true;
                    end;  
                else
                    z=true
                end
                if z then
                    x=(HealBot_Spells[sNameRank].HealsDur/hlthDelta)/5;
                    x=x-(HealBot_Spells[sNameRank].Mana/2);
                    x=x/(HealBot_Spells[sNameRank].CastTime+0.5);
                    if x>y then
                        y=x;
                        w=sName;
                    end
                end
            end
        end
    end
    return w;
end

local uRange=0
function HealBot_UnitInRange(spellName, unit) -- added by Diacono of Ursin
    if UnitGUID(unit)==HealBot_PlayerGUID then
        uRange = 1
    elseif not spellName then
        if UnitInRange(unit) == 1 then
            uRange = 1
        else
            uRange = 0
        end
    elseif IsSpellInRange(spellName, unit) ~= nil then
        uRange = IsSpellInRange(spellName, unit)
    elseif IsItemInRange(spellName, unit) ~= nil then
        uRange = IsItemInRange(spellName, unit)
    elseif UnitInRange(unit) == 1 then
        uRange = 1
    else
        uRange=0
    end
    if uRange==0 and not UnitIsVisible(unit) then 
        uRange=-1 
    end
    return uRange
end

function HealBot_ClearLocalArr(hbGUID, getTime)
    if (HealBot_UnitTime[hbGUID] or 0)<getTime then
        if HealBot_PlayerBuff[hbGUID] then HealBot_PlayerBuff[hbGUID]=nil end
        if HealBot_Player_HoT[hbGUID] then HealBot_Player_HoT[hbGUID]=nil end
        if HealBot_Player_HoT_Icons[hbGUID] then HealBot_Player_HoT_Icons[hbGUID]=nil end
        if DeBuff_Count[hbGUID] then DeBuff_Count[hbGUID]=nil end
        if HealBot_unitHealth[hbGUID] then
            HealBot_unitHealth[hbGUID]=nil
            HealBot_unitHealthMax[hbGUID]=nil
        end
        for k in pairs(HealBot_MainTanks) do
            if ( HealBot_MainTanks[k] == hbGUID ) then
                HealBot_MainTanks[k] = nil;
            end
        end
        for k in pairs(HealBot_CTRATanks) do
            if ( HealBot_CTRATanks[k] == hbGUID ) then
                HealBot_CTRATanks[k] = nil;
            end
        end
        for k in pairs(HealBot_MainAssists) do
            if ( HealBot_MainAssists[k] == hbGUID ) then
                HealBot_MainAssists[k] = nil;
            end
        end
        if HealBot_DelayBuffCheck[hbGUID] then HealBot_DelayBuffCheck[hbGUID]=nil end
        HealBot_ClearAllDebuffs(hbGUID)
        HealBot_UnitBuff[hbGUID]=nil
        HealBot_UnitDebuff[hbGUID]=nil
        for k in pairs(HealBot_PetGUID) do
            if ( HealBot_PetGUID[k] == hbGUID ) then
                HealBot_PetGUID[k] = nil;
            end
        end
        if HealBot_CheckBuffsTimehbGUID==hbGUID then HealBot_ResetCheckBuffsTime() end
        if HealBot_PetGUID[hbGUID] then HealBot_PetGUID[hbGUID]=nil end
        HealBot_UnitTime[hbGUID]=nil
        if HealBot_nonAggro[hbGUID] then HealBot_nonAggro[hbGUID]=nil end
        HealBot_talentSpam(hbGUID,"remove",nil)
        HealBot_Action_ClearLocalArr(hbGUID)
    end
end

function HealBot_immediateClearLocalArr(hbGUID)
    HealBot_ClearUnitAggro(HealBot_UnitID[hbGUID], hbGUID)
    HealBot_UnitName[hbGUID]=nil
    HealBot_UnitSpec[hbGUID]=nil
    HealBot_UnitID[hbGUID]=nil
end

function HealBot_setClearLocalArr(hbGUID)
    HealBot_cleanGUIDs[hbGUID]=GetTime()
end

function HealBot_Update_Skins()

    if HealBot_Config.Skin_Version then
        Healbot_Config_Skins.Skin_Version=1
        HealBot_Config.Skin_Version=nil
    end
  
    if HealBot_Config.Current_Skin then
        HealBot_Config.Current_Skin = nil
    end
  
    if not HealBot_Config.HealBotBuffColB[10] then
        HealBot_Config.HealBotBuffColR[10]=1
        HealBot_Config.HealBotBuffColG[10]=1
        HealBot_Config.HealBotBuffColB[10]=1
    end  
	
	if not HealBot_Config.CDCBarColour[HEALBOT_CUSTOM_en] then
		HealBot_Config.CDCBarColour[HEALBOT_CUSTOM_en] = { R = 0.45, G = 0, B = 0.26, }
    end
    
    if not HealBot_Config.SkinDefault then HealBot_Config.SkinDefault={} end

    if HealBot_Config.LastVersionSkinUpdate~=HEALBOT_VERSION then
        for x in pairs (Healbot_Config_Skins.Skins) do
            if not Healbot_Config_Skins.DoubleText[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.Skin_Version = 1 end
            if not Healbot_Config_Skins.AggroBarSize[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroBarSize[Healbot_Config_Skins.Skins[x]] = 3 end
            if not Healbot_Config_Skins.btextfont[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextfont[Healbot_Config_Skins.Skins[x]] = HealBot_Default_Font end
            if not Healbot_Config_Skins.headtextfont[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtextfont[Healbot_Config_Skins.Skins[x]] = HealBot_Default_Font end
            if not Healbot_Config_Skins.headtextheight[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtextheight[Healbot_Config_Skins.Skins[x]] = 10 end
            if not Healbot_Config_Skins.numcols[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.numcols[Healbot_Config_Skins.Skins[x]] = 2 end
            if not Healbot_Config_Skins.btexture[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btexture[Healbot_Config_Skins.Skins[x]] = HealBot_Default_Textures[8].name end
            if Healbot_Config_Skins.btexture[Healbot_Config_Skins.Skins[x]] == "Empty" then Healbot_Config_Skins.btexture[Healbot_Config_Skins.Skins[x]]="Smooth" end
            if not Healbot_Config_Skins.bcspace[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bcspace[Healbot_Config_Skins.Skins[x]] = 4 end
            if not Healbot_Config_Skins.brspace[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.brspace[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Skins[x]] = 144 end
            if not Healbot_Config_Skins.bheight[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bheight[Healbot_Config_Skins.Skins[x]] = 22 end
            if not Healbot_Config_Skins.btextenabledcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextenabledcolr[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextenabledcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextenabledcolg[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextenabledcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextenabledcolb[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextdisbledcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextdisbledcolr[Healbot_Config_Skins.Skins[x]] = 0.5 end
            if not Healbot_Config_Skins.btextdisbledcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextdisbledcolg[Healbot_Config_Skins.Skins[x]] = 0.5 end
            if not Healbot_Config_Skins.btextdisbledcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextdisbledcolb[Healbot_Config_Skins.Skins[x]] = 0.5 end
            if not Healbot_Config_Skins.btextdisbledcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextdisbledcola[Healbot_Config_Skins.Skins[x]] = 0.5 end
            if not Healbot_Config_Skins.btextcursecolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextcursecolr[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextcursecolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextcursecolg[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextcursecolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextcursecolb[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.btextcursecola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextcursecola[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.backcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.backcola[Healbot_Config_Skins.Skins[x]] = 0.02 end
            if not Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Skins[x]] = 0.9 end
            if not Healbot_Config_Skins.BarcolaInHeal[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarcolaInHeal[Healbot_Config_Skins.Skins[x]] = 0.45 end
            if not Healbot_Config_Skins.backcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.backcolr[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.backcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.backcolg[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.backcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.backcolb[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.borcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.borcolr[Healbot_Config_Skins.Skins[x]] = 0.4    end  
            if not Healbot_Config_Skins.borcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.borcolg[Healbot_Config_Skins.Skins[x]] = 0.4    end 
            if not Healbot_Config_Skins.borcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.borcolb[Healbot_Config_Skins.Skins[x]] = 0.4    end
            if not Healbot_Config_Skins.borcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.borcola[Healbot_Config_Skins.Skins[x]] = 0.2 end
            if not Healbot_Config_Skins.btextheight[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.btextheight[Healbot_Config_Skins.Skins[x]] = 10 end
            if not Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bardisa[Healbot_Config_Skins.Skins[x]] = 0.28 end
            if not Healbot_Config_Skins.bareora[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bareora[Healbot_Config_Skins.Skins[x]] = 0.45 end
            if not Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.ShowHeader[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowHeader[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.headbarcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headbarcolr[Healbot_Config_Skins.Skins[x]] = 0.1 end
            if not Healbot_Config_Skins.headbarcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headbarcolg[Healbot_Config_Skins.Skins[x]] = 0.1 end
            if not Healbot_Config_Skins.headbarcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headbarcolb[Healbot_Config_Skins.Skins[x]] = 0.4 end
            if not Healbot_Config_Skins.headbarcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headbarcola[Healbot_Config_Skins.Skins[x]] = 0.25 end
            if not Healbot_Config_Skins.headtxtcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtxtcolr[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.headtxtcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtxtcolg[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.headtxtcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtxtcolb[Healbot_Config_Skins.Skins[x]] = 0.4 end
            if not Healbot_Config_Skins.headtxtcola[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtxtcola[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.headtexture[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headtexture[Healbot_Config_Skins.Skins[x]] = HealBot_Default_Textures[6].name end
            if not Healbot_Config_Skins.headwidth[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headwidth[Healbot_Config_Skins.Skins[x]] = 0.72 end
            if not Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowAggroText[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowAggroText[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowAggroBarsPct[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowAggroBarsPct[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowAggroTextPct[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowAggroTextPct[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.UseFluidBars[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.UseFluidBars[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarFreq[Healbot_Config_Skins.Skins[x]] = 5 end
            if not Healbot_Config_Skins.ShowHoTicons[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowHoTicons[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.HoTonBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HoTonBar[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HoTx2Bar[Healbot_Config_Skins.Skins[x]] = 0  end
            if not Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.ShowNameOnBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowNameOnBar[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowHealthOnBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowHealthOnBar[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarHealthIncHeals[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarHealthNumFormat1[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarHealthNumFormat2[Healbot_Config_Skins.Skins[x]] = 2  end
            if not Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarHealthNumFormatAggro[Healbot_Config_Skins.Skins[x]] = 3  end
            if not Healbot_Config_Skins.BarHealthType[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.BarHealthType[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.SetClassColourText[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SetClassColourText[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.ShowDebuffIcon[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowDebuffIcon[Healbot_Config_Skins.Skins[x]] = 1  end
            if not Healbot_Config_Skins.ShowIconTextCount[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowIconTextCount[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowIconTextCountSelfCast[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowIconTextCountSelfCast[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.ShowIconTextDuration[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowIconTextDuration[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.ShowIconTextDurationSelfCast[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowIconTextDurationSelfCast[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.IconScale[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.IconScale[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.IconTextScale[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.IconTextScale[Healbot_Config_Skins.Skins[x]] = 0.55 end
            if not Healbot_Config_Skins.DoubleText[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.DoubleText[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.TextAlignment[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TextAlignment[Healbot_Config_Skins.Skins[x]] = 2 end
            if not Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.SetBarClassColour[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SetBarClassColour[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.SetBarCustomColour[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SetBarCustomColour[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.barcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.barcolr[Healbot_Config_Skins.Skins[x]] = 0.4 end
            if not Healbot_Config_Skins.barcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.barcolg[Healbot_Config_Skins.Skins[x]] = 0.7 end
            if not Healbot_Config_Skins.barcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.barcolb[Healbot_Config_Skins.Skins[x]] = 0.7 end
            if not Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.HighLightActiveBarInCombat[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightActiveBarInCombat[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.HighLightActiveBarInCombat[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightActiveBarInCombat[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.highcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.highcolr[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.highcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.highcolg[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.highcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.highcolb[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.targetcolr[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.targetcolr[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.targetcolg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.targetcolg[Healbot_Config_Skins.Skins[x]] = 0.8 end
            if not Healbot_Config_Skins.targetcolb[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.targetcolb[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.AggroCol1r[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroCol1r[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.AggroCol1g[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroCol1g[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.AggroCol1b[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroCol1b[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.AggroCol2r[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroCol2r[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.AggroCol2g[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroCol2g[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.AggroCol2b[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroCol2b[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.AggroCol3r[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroCol3r[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.AggroCol3g[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroCol3g[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.AggroCol3b[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroCol3b[Healbot_Config_Skins.Skins[x]] = 0 end
            if not Healbot_Config_Skins.AggroBarsMaxAlpha[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroBarsMaxAlpha[Healbot_Config_Skins.Skins[x]] = 1 end
            if not Healbot_Config_Skins.AggroBarsMinAlpha[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroBarsMinAlpha[Healbot_Config_Skins.Skins[x]] = 0.2 end
            if not Healbot_Config_Skins.AggroBarsFreq[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroBarsFreq[Healbot_Config_Skins.Skins[x]] = 0.03 end
            if not Healbot_Config_Skins.IconTextDurationShow[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.IconTextDurationShow[Healbot_Config_Skins.Skins[x]] = 9 end
            if not Healbot_Config_Skins.IconTextDurationWarn[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.IconTextDurationWarn[Healbot_Config_Skins.Skins[x]] = 3 end
            if not Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.PanelAnchorY[Healbot_Config_Skins.Skins[x]] = GetScreenHeight()/2 end
            if not Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.PanelAnchorX[Healbot_Config_Skins.Skins[x]] = GetScreenWidth()/2 end
            if not HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]] then HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Skins[x]]=2 end
            if not Healbot_Config_Skins.headhight[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.headhight[Healbot_Config_Skins.Skins[x]]=0.75 end
            if not Healbot_Config_Skins.SelfHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SelfHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.SelfHeals or 0 end
            if not Healbot_Config_Skins.PetHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.PetHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.PetHeals or 0 end
            if not Healbot_Config_Skins.GroupHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.GroupHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.GroupHeals or 1 end
            if not Healbot_Config_Skins.TankHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TankHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TankHeals or 1 end
            if not Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SelfPet[Healbot_Config_Skins.Skins[x]]=HealBot_Config.SelfPet or 0 end
            if not Healbot_Config_Skins.MainAssistHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.MainAssistHeals[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.EmergencyHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.EmergencyHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.EmergencyHeals or 1 end
            if not Healbot_Config_Skins.SetFocusBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SetFocusBar[Healbot_Config_Skins.Skins[x]]=HealBot_Config.SetFocusBar or 1 end
            if not Healbot_Config_Skins.VehicleHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.VehicleHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.VehicleHeals or 1 end
            if not Healbot_Config_Skins.ShowMyTargetsList[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowMyTargetsList[Healbot_Config_Skins.Skins[x]]=HealBot_Config.ShowMyTargetsList or 1 end
            if not Healbot_Config_Skins.TargetHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TargetHeals or 1 end
            if not Healbot_Config_Skins.TargetIncSelf[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetIncSelf[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TargetIncSelf or 0 end
            if not Healbot_Config_Skins.TargetIncGroup[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetIncGroup[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TargetIncGroup or 0 end
            if not Healbot_Config_Skins.TargetIncRaid[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetIncRaid[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TargetIncRaid or 1 end
            if not Healbot_Config_Skins.TargetIncPet[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetIncPet[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TargetIncPet or 0 end
            if not Healbot_Config_Skins.TargetBarNormalMode[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.TargetBarNormalMode[Healbot_Config_Skins.Skins[x]]=HealBot_Config.TargetBarNormalMode or 0 end
            if not Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AlertLevel[Healbot_Config_Skins.Skins[x]]=HealBot_Config.AlertLevel or 82 end
            if not Healbot_Config_Skins.NotVisibleDisable[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.NotVisibleDisable[Healbot_Config_Skins.Skins[x]]=HealBot_Config.NotVisibleDisable or 1 end
            if not Healbot_Config_Skins.HidePartyFrames[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HidePartyFrames[Healbot_Config_Skins.Skins[x]]=HealBot_Config.HidePartyFrames or 0 end
            if not Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HidePlayerTarget[Healbot_Config_Skins.Skins[x]]=HealBot_Config.HidePlayerTarget or 0 end
            if not Healbot_Config_Skins.CastNotify[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.CastNotify[Healbot_Config_Skins.Skins[x]]=HealBot_Config.CastNotify or 1 end
            if not Healbot_Config_Skins.NotifyChan[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.NotifyChan[Healbot_Config_Skins.Skins[x]]=HealBot_Config.NotifyChan or "" end
            if not Healbot_Config_Skins.NotifyHealMsg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.NotifyHealMsg[Healbot_Config_Skins.Skins[x]]=HealBot_Config.NotifyHealMsg or HEALBOT_NOTIFYHEALMSG end
            if not Healbot_Config_Skins.NotifyOtherMsg[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.NotifyOtherMsg[Healbot_Config_Skins.Skins[x]]=HealBot_Config.NotifyOtherMsg or HEALBOT_NOTIFYOTHERMSG end
            if not Healbot_Config_Skins.CastNotifyResOnly[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.CastNotifyResOnly[Healbot_Config_Skins.Skins[x]]=HealBot_Config.CastNotifyResOnly or 1 end
            if not Healbot_Config_Skins.ShowIncHeals[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowIncHeals[Healbot_Config_Skins.Skins[x]]=HealBot_Config.ShowIncHeals or 1 end
            if not Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Skins[x]] = { D = 5, H = 3, C = 3 } end
            if not Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Skins[x]]=HealBot_Config.EmergIncMonitor or 1 end
            if not Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Skins[x]]=HealBot_Config.ExtraOrder or 3 end
            if not Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]=HealBot_Config.Panel_Anchor or 1 end
            if not Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]] then 
                if Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==1 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=1
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==2 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=1
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==3 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=3
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==4 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=3
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==5 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=1
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==6 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=1
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==7 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=3
                elseif Healbot_Config_Skins.Panel_Anchor[Healbot_Config_Skins.Skins[x]]==8 then
                    Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Skins[x]]=1
                end
            end
            if not Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Skins[x]] then 
                Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Skins[x]]={[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true}
            end
            if not Healbot_Config_Skins.GroupsPerCol[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.GroupsPerCol[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ActionLocked[Healbot_Config_Skins.Skins[x]]=HealBot_Config.ActionLocked or 0 end
            if not Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.AutoClose[Healbot_Config_Skins.Skins[x]]=HealBot_Config.AutoClose or 0 end
            if not Healbot_Config_Skins.PanelSounds[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.PanelSounds[Healbot_Config_Skins.Skins[x]]=HealBot_Config.PanelSounds or 0 end
            if not Healbot_Config_Skins.SubSortIncGroup[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortIncGroup[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.SubSortIncPet[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortIncPet[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.SubSortIncVehicle[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortIncVehicle[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.SubSortIncTanks[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortIncTanks[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.SubSortIncMyTargets[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortIncMyTargets[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.ShowRaidIconStar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconStar[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconCircle[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconCircle[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconDiamond[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconDiamond[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconTriangle[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconTriangle[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconMoon[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconMoon[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconSquare[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconSquare[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconCross[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconCross[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconSkull[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconSkull[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ReadyCheck[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ReadyCheck[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.ShowRaidIconSkull[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.ShowRaidIconSkull[Healbot_Config_Skins.Skins[x]]=1 end
            if not Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.HighLightTargetBarInCombat[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.HighLightTargetBarInCombat[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Skins[x]] then 
                Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Skins[x]]=HealBot_Config.CrashProt or 0 
                if HealBot_Config.CrashProt then HealBot_Config.CrashProt=nil end
            end
            if not Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.CombatProtParty[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.CombatProtParty[Healbot_Config_Skins.Skins[x]]=0 end
            if not Healbot_Config_Skins.CombatProtRaid[Healbot_Config_Skins.Skins[x]] then Healbot_Config_Skins.CombatProtRaid[Healbot_Config_Skins.Skins[x]]=0 end
            
            if strsub(HEALBOT_VERSION,1,7)=="3.3.5.2" then
                if Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Skins[x]]==4 then Healbot_Config_Skins.AggroAlertLevel[Healbot_Config_Skins.Skins[x]]=3 end
            end
        end
        HealBot_Config.LastVersionSkinUpdate=HEALBOT_VERSION
    end
    
    if HealBot_Config.CurrentSpec==4 then
        HealBot_Config.CurrentSpec=1
        HealBot_Update_SpellCombos()
        HealBot_Update_BuffsForSpec()
    end
    
    local _,class=UnitClass("player")
    class=strsub(class,1,4)
    local hbClassHoTwatchDef=HealBot_GlobalsDefaults.WatchHoT[class]
   -- hbClassHoTwatch=HealBot_Globals.WatchHoT[class]
    
    for sName,x  in pairs(hbClassHoTwatchDef) do
        if not HealBot_Globals.WatchHoT[class][sName] then
            HealBot_Globals.WatchHoT[class][sName]=x
        end
    end

    for dName, _ in pairs(HealBot_Config.HealBot_Custom_Debuffs) do
        if not tonumber(HealBot_Config.HealBot_Custom_Debuffs[dName]) then
            HealBot_Config.HealBot_Custom_Debuffs[dName]=10
        end
    end
    
    Healbot_Config_Skins.Skin_Version=HealBotSkinVersion
end

function HealBot_Update_SpellCombos()
    local combo=nil
    local button=nil

    for x=1,2 do
        if x==1 then
            combo = HealBot_Config.EnabledKeyCombo;
        else
            combo = HealBot_Config.DisabledKeyCombo;
        end
        for y=1,15 do
            button = HealBot_Options_ComboClass_Button(y)
            for z=1,3 do
                if combo then
                    combo[button..z] = combo[button]
                    combo["Shift"..button..z] = combo["Shift"..button]
                    combo["Ctrl"..button..z] = combo["Ctrl"..button]
                    combo["Alt"..button..z] = combo["Alt"..button]
                    combo["Ctrl-Shift"..button..z] = combo["Ctrl-Shift"..button]
                    combo["Alt-Shift"..button..z] = combo["Alt-Shift"..button]
                end
            end
        end
    end
end

function HealBot_Copy_SpellCombos()
    local combo=nil
    local button=nil

    for x=1,2 do
        if x==1 then
            combo = HealBot_Config.EnabledKeyCombo;
        else
            combo = HealBot_Config.DisabledKeyCombo;
        end
        for y=1,15 do
            button = HealBot_Options_ComboClass_Button(y)
            if combo then
                combo[button] = combo[button..HealBot_Config.CurrentSpec]
                combo["Shift"..button] = combo["Shift"..button..HealBot_Config.CurrentSpec]
                combo["Ctrl"..button] = combo["Ctrl"..button..HealBot_Config.CurrentSpec]
                combo["Alt"..button] = combo["Alt"..button..HealBot_Config.CurrentSpec]
                combo["Ctrl-Shift"..button] = combo["Ctrl-Shift"..button..HealBot_Config.CurrentSpec]
                combo["Alt-Shift"..button] = combo["Alt-Shift"..button..HealBot_Config.CurrentSpec]
            end
        end
    end
    HealBot_Update_SpellCombos()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSPELLCOPY)
end

function HealBot_Reset_Spells()
    HealBot_DoReset_Spells(HealBot_PlayerClassEN)
    HealBot_Config.ProtectPvP=HealBot_ConfigDefaults.ProtectPvP
    HealBot_Config.SmartCast=HealBot_ConfigDefaults.SmartCast
    HealBot_Config.SmartCastDebuff=HealBot_ConfigDefaults.SmartCastDebuff
    HealBot_Config.SmartCastBuff=HealBot_ConfigDefaults.SmartCastBuff
    HealBot_Config.SmartCastHeal=HealBot_ConfigDefaults.SmartCastHeal
    HealBot_Config.SmartCastRes=HealBot_ConfigDefaults.SmartCastRes
    HealBot_Config.EnableHealthy=HealBot_ConfigDefaults.EnableHealthy
    HealBot_Update_SpellCombos()
    HealBot_Options_ResetDoInittab(2)
    HealBot_Options_Init(2)
    HealBot_Options_ComboClass_Text()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSPELLRESET)
end

function HealBot_Reset_Buffs()
    HealBot_DoReset_Buffs(HealBot_PlayerClassEN)
    HealBot_Config.BuffWatch=HealBot_ConfigDefaults.BuffWatch
    HealBot_Config.BuffWatchInCombat=HealBot_ConfigDefaults.BuffWatchInCombat
    HealBot_Config.ShortBuffTimer=HealBot_ConfigDefaults.ShortBuffTimer
    HealBot_Config.LongBuffTimer=HealBot_ConfigDefaults.LongBuffTimer
    HealBot_Update_BuffsForSpec("Buff")
    HealBot_Options_ResetDoInittab(5)
    HealBot_Options_Init(5)
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMBUFFSRESET)
end

function HealBot_Reset_Cures()
    HealBot_DoReset_Cures(HealBot_PlayerClassEN)
    HealBot_Config.SoundDebuffWarning=HealBot_ConfigDefaults.SoundDebuffWarning
    HealBot_Config.DebuffWatch=HealBot_ConfigDefaults.DebuffWatch
    HealBot_Config.IgnoreClassDebuffs=HealBot_ConfigDefaults.IgnoreClassDebuffs
    HealBot_Config.IgnoreNonHarmfulDebuffs=HealBot_ConfigDefaults.IgnoreNonHarmfulDebuffs
    HealBot_Config.IgnoreFastDurDebuffs=HealBot_ConfigDefaults.IgnoreFastDurDebuffs
    HealBot_Config.IgnoreFastDurDebuffsSecs=HealBot_ConfigDefaults.IgnoreFastDurDebuffsSecs
    HealBot_Config.IgnoreMovementDebuffs=HealBot_ConfigDefaults.IgnoreMovementDebuffs
    HealBot_Config.SoundDebuffPlay=HealBot_ConfigDefaults.SoundDebuffPlay
    HealBot_Config.DebuffWatchInCombat=HealBot_ConfigDefaults.DebuffWatchInCombat
    HealBot_Config.ShowDebuffWarning=HealBot_ConfigDefaults.ShowDebuffWarning
    HealBot_Config.CDCshownHB=HealBot_ConfigDefaults.CDCshownHB
    HealBot_Config.CDCshownAB=HealBot_ConfigDefaults.CDCshownAB
    HealBot_Update_BuffsForSpec("Debuff")
    HealBot_Options_ResetDoInittab(4)
    HealBot_Options_Init(4)
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMCURESRESET)
end

function HealBot_DoReset_Buffs(PlayerClassEN)
    HealBot_Config.HealBotBuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,[5]=HEALBOT_WORDS_NONE,
                                      [6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
    HealBot_Config.HealBotBuffDropDown = {[1]=4,[2]=4,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=4,[10]=4}
    if strsub(PlayerClassEN,1,4)=="DRUI" then
          HealBot_Config.HealBotBuffText = {[1]=HEALBOT_MARK_OF_THE_WILD,[2]=HEALBOT_THORNS,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,[5]=HEALBOT_WORDS_NONE,
                                      [6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
    elseif strsub(PlayerClassEN,1,4)=="PALA" then
          HealBot_Config.HealBotBuffText = {[1]=HEALBOT_BLESSING_OF_MIGHT,[2]=HEALBOT_DEVOTION_AURA,[3]=HEALBOT_SEAL_OF_RIGHTEOUSNESS,[4]=HEALBOT_WORDS_NONE,
                                            [5]=HEALBOT_WORDS_NONE,[6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
          HealBot_Config.HealBotBuffDropDown = {[1]=4,[2]=2,[3]=2,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=4,[10]=4}
    elseif strsub(PlayerClassEN,1,4)=="PRIE" then
          HealBot_Config.HealBotBuffText = {[1]=HEALBOT_POWER_WORD_FORTITUDE,[2]=HEALBOT_INNER_FIRE,[3]=HEALBOT_DIVINE_SPIRIT,[4]=HEALBOT_SHADOW_PROTECTION,
                                            [5]=HEALBOT_WORDS_NONE,[6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
          HealBot_Config.HealBotBuffDropDown = {[1]=4,[2]=2,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=4,[10]=4}
    elseif strsub(PlayerClassEN,1,4)=="SHAM" then
          HealBot_Config.HealBotBuffText = {[1]=HEALBOT_WATER_SHIELD,[2]=HEALBOT_ROCKBITER_WEAPON,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,
                                            [5]=HEALBOT_WORDS_NONE,[6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
          HealBot_Config.HealBotBuffDropDown = {[1]=2,[2]=2,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=4,[10]=4}
    elseif strsub(PlayerClassEN,1,4)=="MAGE" then
          HealBot_Config.HealBotBuffText = {[1]=HEALBOT_ARCANE_INTELLECT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,
                                            [5]=HEALBOT_WORDS_NONE,[6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
    end
end


function HealBot_DoReset_Cures(PlayerClassEN)
    HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
    HealBot_Config.HealBotDebuffDropDown = {[1]=4,[2]=4,[3]=4}
    if strsub(PlayerClassEN,1,4)=="DRUI" then
          HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_CURE_POISON,[2]=HEALBOT_REMOVE_CURSE,[3]=HEALBOT_WORDS_NONE}
    elseif strsub(PlayerClassEN,1,4)=="PALA" then
          HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_CLEANSE,[3]=HEALBOT_WORDS_NONE}
    elseif strsub(PlayerClassEN,1,4)=="PRIE" then
          HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_CURE_DISEASE,[2]=HEALBOT_DISPEL_MAGIC,[3]=HEALBOT_WORDS_NONE}
    elseif strsub(PlayerClassEN,1,4)=="SHAM" then
          HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_CURE_TOXINS,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
    elseif strsub(PlayerClassEN,1,4)=="MAGE" then
          HealBot_Config.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CURSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
    end
end

function HealBot_DoReset_Spells(PlayerClassEN)
    HealBot_Config.EnabledKeyCombo = {}
    HealBot_Config.DisabledKeyCombo = {}
    local bandage=HealBot_GetBandageType()
    if strsub(PlayerClassEN,1,4)=="DRUI" then
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = HEALBOT_REGROWTH,
          ["CtrlLeft"] =  HEALBOT_ABOLISH_POISON,
          ["Right"] = HEALBOT_HEALING_TOUCH,
          ["CtrlRight"] =  HEALBOT_REMOVE_CURSE,
          ["Middle"] = HEALBOT_REJUVENATION,
          ["ShiftMiddle"] = bandage,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["ShiftLeft"] = HEALBOT_MARK_OF_THE_WILD,
          ["Right"] = HEALBOT_ASSIST,
          ["AltRight"] = HEALBOT_THORNS,
          ["Middle"] = HEALBOT_REJUVENATION,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif strsub(PlayerClassEN,1,4)=="PALA" then
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = HEALBOT_FLASH_OF_LIGHT,
          ["CtrlLeft"] =  HEALBOT_CLEANSE,
          ["Right"] = HEALBOT_HOLY_LIGHT,
          ["Middle"] =  HEALBOT_HAND_OF_SALVATION,
          ["ShiftMiddle"] = bandage,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["Middle"] =  HEALBOT_HAND_OF_SALVATION,
          ["Right"] = HEALBOT_ASSIST,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif strsub(PlayerClassEN,1,4)=="PRIE" then
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = HEALBOT_FLASH_HEAL,
          ["ShiftLeft"] = HEALBOT_BINDING_HEAL,
          ["CtrlLeft"] = HEALBOT_ABOLISH_DISEASE,
          ["Right"] = HEALBOT_GREATER_HEAL,
          ["ShiftRight"] = HEALBOT_POWER_WORD_SHIELD,
          ["CtrlRight"] = HEALBOT_DISPEL_MAGIC,
          ["Middle"] = HEALBOT_RENEW,
          ["ShiftMiddle"] = HEALBOT_PRAYER_OF_MENDING,
          ["AltMiddle"] = HEALBOT_PRAYER_OF_HEALING,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["Right"] = HEALBOT_ASSIST,
          ["AltLeft"] = HEALBOT_RESURRECTION,
          ["ShiftRight"] = HEALBOT_POWER_WORD_SHIELD,
          ["Middle"] = HEALBOT_RENEW,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif strsub(PlayerClassEN,1,4)=="SHAM" then
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = HEALBOT_LESSER_HEALING_WAVE,
          ["CtrlLeft"] =  HEALBOT_CURE_TOXINS,
          ["Right"] = HEALBOT_HEALING_WAVE,
          ["CtrlRight"] = HEALBOT_CURE_TOXINS,
          ["Middle"] = HEALBOT_CHAIN_HEAL,
          ["ShiftMiddle"] = bandage,
          ["AltMiddle"] = HEALBOT_CLEANSE_SPIRIT,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["Right"] = HEALBOT_ASSIST,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif strsub(PlayerClassEN,1,4)=="MAGE" then
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = HEALBOT_REMOVE_CURSE,
          ["ShiftLeft"] = bandage,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["ShiftLeft"] = bandage,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
                                         }
    else
        HealBot_Config.EnabledKeyCombo = {
          ["Left"] = bandage,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
                                         }
        HealBot_Config.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["ShiftLeft"] = bandage,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
          ["Button4"] = HEALBOT_MAINTANK,
          ["Button5"] = HEALBOT_MAINASSIST,
                                         }
    end
end


function HealBot_Update_BuffsForSpec(buffType)
    if buffType then
        if buffType=="Debuff" then
            for x=1,3 do
                HealBot_Update_BuffsForSpecDD(x,"Debuff")
            end
        else
            for x=1,10 do
                HealBot_Update_BuffsForSpecDD(x,"Buff")
            end
        end
    else
        for x=1,3 do
            HealBot_Update_BuffsForSpecDD(x,"Debuff")
        end
        for x=1,10 do
            HealBot_Update_BuffsForSpecDD(x,"Buff")
        end
    end
end

function HealBot_Update_BuffsForSpecDD(ddId,bType)
    if bType=="Debuff" then
        for z=1,3 do
            if HealBot_Config.HealBotDebuffDropDown[ddId] and not HealBot_Config.HealBotDebuffDropDown[z..ddId] then 
                HealBot_Config.HealBotDebuffDropDown[z..ddId]=HealBot_Config.HealBotDebuffDropDown[ddId] 
            elseif not HealBot_Config.HealBotDebuffDropDown[z..ddId] then 
                HealBot_Config.HealBotDebuffDropDown[z..ddId]=4
            end
            if HealBot_Config.HealBotDebuffText[ddId] and not HealBot_Config.HealBotDebuffText[z..ddId] then 
                HealBot_Config.HealBotDebuffText[z..ddId]=HealBot_Config.HealBotDebuffText[ddId]
            elseif not not HealBot_Config.HealBotDebuffText[z..ddId] then 
                HealBot_Config.HealBotDebuffText[z..ddId]=HEALBOT_WORDS_NONE
            end
        end
    else
        for z=1,3 do
            if HealBot_Config.HealBotBuffDropDown[ddId] and not HealBot_Config.HealBotBuffDropDown[z..ddId] then 
                HealBot_Config.HealBotBuffDropDown[z..ddId]=HealBot_Config.HealBotBuffDropDown[ddId]
            elseif not HealBot_Config.HealBotBuffDropDown[z..ddId] then 
                HealBot_Config.HealBotBuffDropDown[z..ddId]=4
            end
            if HealBot_Config.HealBotBuffText[ddId] and not HealBot_Config.HealBotBuffText[z..ddId] then 
                HealBot_Config.HealBotBuffText[z..ddId]=HealBot_Config.HealBotBuffText[ddId]
            elseif not HealBot_Config.HealBotBuffText[z..ddId] then 
                HealBot_Config.HealBotBuffText[z..ddId]=HEALBOT_WORDS_NONE
            end
        end
    end
end
