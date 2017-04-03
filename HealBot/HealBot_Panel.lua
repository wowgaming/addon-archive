local TempMaxH=0;
local TempMaxHinit=0;
local bwidth=nil
local bheight=nil
local bcspace=nil
local brspace=nil
local left=nil
local right=nil
local bottom=nil
local top=nil
local hheight=nil
local hrspace=nil
local hwidth=nil
local hwidthadj=nil
local cols=nil
local nraid=nil
local tBars=nil
local b=nil
local bar=nil
local hdr=nil
local HealBot_TrackNames={};
local i=nil
local h=nil
local j=nil
local k=nil
local z=nil
local t=nil
local x=nil
local xButton=nil
local curcol=nil
local xUnit=nil
local tUnit=nil
local sUnit=nil
local getUnitID=nil
local pUnit=nil
local header=nil
local order = {};
local units = {};
local subunits = {};
local HealBot_CheckedTargets={};
local subgroup=nil
local online=nil
local class=nil
local role=nil
local isTank, isHeal, isDPS=nil,nil,nil
local TempSort=nil
local MyGroup=0
local numHeaders = 0
local HealBot_headerno=0
local TargetValid=nil
local HeaderPos={}
local OffsetY = 10;
local OffsetX = 10;
local MaxOffsetY=0;
local HealBot_HeadX={};
local HealBot_HeadY={};
local HealBot_BarX={};
local HealBot_BarY={};
local HealBot_MultiColHoToffset=0;
local HealBot_MultiRowHoToffset=0;
local HealBot_TrackGUID={};
local HealBot_TrackUnit={}
local HealBot_TrackHButtons={};
local HealBot_TrackButtonsH={};
local HealBot_Panel_BlackList={};
local format=format
local ceil=ceil;
local strsub=strsub
local HealBot_AddHeight=4
local HealBot_MyHealTargets={}
local HealBot_MyPrivateTanks={}
local mti=0
local classEN=nil
local TempGrp=99
local TempUnitMaxH=1
local SubSort=nil
local uName=nil
local HealBot_MainTanks={};
local HealBot_TempTanks={};
local HealBot_RegTanks={}
local HealBot_GroupGUID={}
local HealBot_UnitNameGUID={}
local xGUID = nil
local sGUID = nil
local maxHealDiv=2500
local showCI = false
local HealBot_TestBars={}
local hbincSort=nil
local HealBot_unitRole={}
local HealBot_NumPlayerBars=0
local HealBot_BottomAnchors=false
local HealBot_cpName={}
local HealBot_cpData={}
local HealBot_cpOn=false

local hbRole={ [HEALBOT_MAINTANK]=3,
               [HEALBOT_MAINASSIST]=4,
               [HEALBOT_WORD_HEALER]=5,
               [HEALBOT_WORD_DPS]=7,
               [HEALBOT_WORDS_UNKNOWN]=9,
      }

local HealBot_Action_HealGroup = {
    "player",
    "party1",
    "party2",
    "party3",
    "party4",
};

local HealBot_Action_HealButtons = {};
local hbPanelShowhbFocus=false

function HealBot_Panel_clickToFocus(status)
    if status=="Show" then
        hbPanelShowhbFocus=true
    else
        hbPanelShowhbFocus=nil
    end
    if Delay_RecalcParty<3 then Delay_RecalcParty=3; end
end

function HealBot_GetMyHealTargets()
    return HealBot_MyHealTargets;
end

function HealBot_Panel_SetSubSortPlayer()
    if Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Current_Skin]==1 then
        Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Current_Skin]=0
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SUBSORTPLAYER2)
    else
        Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Current_Skin]=1
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SUBSORTPLAYER1)
    end
    HealBot_Options_SubSortPlayerFirst:SetChecked(Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Current_Skin] or 0)
    if Delay_RecalcParty<2 then Delay_RecalcParty=2; end
end

function HealBot_Panel_SethbTopRole(Role)
    if not Role then return end
    Role=strupper(strtrim(Role))
    if Role=="TANK" then
        hbRole[HEALBOT_MAINTANK]=2
        hbRole[HEALBOT_WORD_HEALER]=5
        hbRole[HEALBOT_WORD_DPS]=7
    elseif Role=="DPS" then
        hbRole[HEALBOT_MAINTANK]=3
        hbRole[HEALBOT_WORD_HEALER]=5
        hbRole[HEALBOT_WORD_DPS]=2
    elseif Role=="HEALER" then
        hbRole[HEALBOT_MAINTANK]=3
        hbRole[HEALBOT_WORD_HEALER]=2
        hbRole[HEALBOT_WORD_DPS]=7
    else
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..Role..HEALBOT_CHAT_TOPROLEERR)
        return
    end
    if HealBot_Globals.TopRole~=Role then
        HealBot_Globals.TopRole=Role
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_NEWTOPROLE..Role)
    end
end

function HealBot_Panel_SetBarArrays(bx)
    HealBot_BarX[bx]=0;
    HealBot_BarY[bx]=0;
end

function HealBot_Panel_SetHeadArrays(bx)
    HealBot_HeadX[bx]=0;
    HealBot_HeadY[bx]=0;
end

function HealBot_Panel_ClearBarArrays()
    for x,_ in pairs(HealBot_BarX) do
        HealBot_BarX[x]=0;
        HealBot_BarY[x]=0;
    end
    for x,_ in pairs(HealBot_HeadX) do
        HealBot_HeadX[x]=0;
        HealBot_HeadY[x]=0;
    end
    if Delay_RecalcParty<2 then Delay_RecalcParty=2; end
end

function HealBot_Panel_SetmaxHealDiv(lvl)
    maxHealDiv=500
    if lvl>76 then
        maxHealDiv=5000
    elseif lvl>70 then
        maxHealDiv=4000
    elseif lvl>60 then
        maxHealDiv=2500
    elseif lvl>45 then
        maxHealDiv=2000
    elseif lvl>30 then
        maxHealDiv=1000
    end
end

function HealBot_Panel_ClearBlackList()
    for x,_ in pairs(HealBot_Panel_BlackList) do
        HealBot_Panel_BlackList[x]=nil;
    end
    if Delay_RecalcParty<2 then Delay_RecalcParty=2 end
end

function HealBot_Panel_AddBlackList(hbGUID)
    HealBot_Panel_BlackList[hbGUID]=true;
    if Delay_RecalcParty<2 then 
        Delay_RecalcParty=2 
    end
end

function HealBot_Panel_ClearHealTarget(hbGUID)
    HealBot_MyHealTargets = {}
end

local myGUID=nil
function HealBot_Panel_ToggelHealTarget(hbGUID)
    mti=0
    for i=1, #HealBot_MyHealTargets do
        if hbGUID==HealBot_MyHealTargets[i] then
            mti=i
            break;
        end
    end
    if mti>0 then
        table.remove(HealBot_MyHealTargets,mti)
    else
        table.insert(HealBot_MyHealTargets,hbGUID)
    end
    if Delay_RecalcParty<2 then 
        Delay_RecalcParty=2 
    end
end

function HealBot_Panel_ToggelPrivateTanks(hbGUID)
    mti=0
    for i=1, #HealBot_MyPrivateTanks do
        if hbGUID==HealBot_MyPrivateTanks[i] then
            mti=i
            break;
        end
    end
    if mti>0 then
        table.remove(HealBot_MyPrivateTanks,mti)
        HealBot_removePrivateTanks(hbGUID)
    else
        table.insert(HealBot_MyPrivateTanks,hbGUID)
        HealBot_addPrivateTanks()
    end
    if Delay_RecalcParty<2 then 
        Delay_RecalcParty=2 
    end
end

function HealBot_Panel_retPrivateTanks()
    return HealBot_MyPrivateTanks
end

function HealBot_Panel_RetMyHealTarget(hbGUID)
    mti=0
    for i=1, #HealBot_MyHealTargets do
        if hbGUID==HealBot_MyHealTargets[i] then
            mti=i
            break;
        end
    end
    if mti>0 then
        return true
    else
        return false
    end
end

function HealBot_Panel_RetPrivateTanks(hbGUID)
    for i=1, #HealBot_MyPrivateTanks do
        if hbGUID==HealBot_MyPrivateTanks[i] then
            mti=i
            break;
        end
    end
    if mti>0 then
        return true
    else
        return false
    end
end
  
function HealBot_Panel_SetMultiColHoToffset(nx)
    HealBot_MultiColHoToffset=nx
end
  
function HealBot_Panel_SetMultiRowHoToffset(nx)
    HealBot_MultiRowHoToffset=nx
    HealBot_Action_SetAddHeight()
end

local HealBot_ClassIconCoord = {
    WARRIOR = {1,1},
    MAGE = {1,2},
    ROGUE = {1,3},
    DRUID = {1,4},
    HUNTER = {2,1},
    SHAMAN = {2,2},
    PRIEST = {2,3},
    WARLOCK = {2,4},
    PALADIN = {3,1},
    DEATHKNIGHT = {3,2},
    DEFAULT = {4,4}};
    
local ciCol,ciRow=nil,nil
function HealBot_Action_SetClassIconTexture(button, unit)
    bar = HealBot_Action_HealthBar(button);
    if not bar then return end
    iconName = _G[bar:GetName().."Icon15"];
    _,class = UnitClass(unit)
    ciCol, ciRow = HealBot_ClassIconCoord[class or "DEFAULT"][1],HealBot_ClassIconCoord[class or "DEFAULT"][2];
    left, top = (ciRow-1)*0.25,(ciCol-1)*0.25;
    iconName:SetTexture([[Interface\AddOns\HealBot\Images\icon_class.tga]]);
    iconName:SetTexCoord(left,left+0.25,top,top+0.25);
end

local thisX=nil
local HealBot_ResetHeaderSkinDone={}
function HealBot_Panel_clearResetHeaderSkinDone()
    for x,_ in pairs(HealBot_ResetHeaderSkinDone) do
        HealBot_ResetHeaderSkinDone[x]=nil;
    end
end

function HealBot_Action_PositionButton(button,OsetX,OsetY,bWidth,bHeight,xHeader)
    brspace=Healbot_Config_Skins.brspace[Healbot_Config_Skins.Current_Skin];
    if xHeader then
        HealBot_headerno=HealBot_headerno+1;
        hheight = ceil(bHeight*Healbot_Config_Skins.headhight[Healbot_Config_Skins.Current_Skin])
        hrspace = ceil(brspace*1.4)+3
        hdr=_G["HealBot_Action_Header"..HealBot_headerno];
        if not HealBot_ResetHeaderSkinDone[HealBot_headerno] then
            HealBot_Action_ResetSkin("header",hdr)
            HealBot_ResetHeaderSkinDone[HealBot_headerno]=true
        end
        bar = HealBot_Action_HealthBar(hdr);
        hwidth = bWidth*Healbot_Config_Skins.headwidth[Healbot_Config_Skins.Current_Skin]
        hwidthadj = ceil((bWidth-hwidth)/2);
        thisX=OsetX+hwidthadj+(HealBot_MultiColHoToffset*curcol)
        if HealBot_HeadX[hdr]~=thisX or HealBot_HeadY[hdr]~=format("%s",OsetY)..xHeader then
            HealBot_HeadX[hdr]=thisX
            HealBot_HeadY[hdr]=format("%s",OsetY)..xHeader;
            hdr:ClearAllPoints();
            if Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==1 then
                hdr:SetPoint("TOPLEFT","HealBot_Action","TOPLEFT",thisX,-OsetY);
            elseif Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==2 then
                hdr:SetPoint("BOTTOMLEFT","HealBot_Action","BOTTOMLEFT",thisX,OsetY);
            elseif Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==3 then
                hdr:SetPoint("TOPRIGHT","HealBot_Action","TOPRIGHT",-thisX,-OsetY);
            else
                hdr:SetPoint("BOTTOMRIGHT","HealBot_Action","BOTTOMRIGHT",-thisX,OsetY);
            end
            bar.txt = _G[bar:GetName().."_text"];
            bar.txt:SetText(xHeader);
            hdr:Show();
        end
        HealBot_TrackButtonsH[hdr]=nil;
        HealBot_TrackHButtons[hdr]=true;
        OsetY = OsetY+hheight+hrspace;
    else
        thisX=OsetX+(HealBot_MultiColHoToffset*curcol)
        if HealBot_BarX[button]~=thisX or HealBot_BarY[button]~=OsetY then
            HealBot_BarX[button]=thisX
            HealBot_BarY[button]=OsetY;
            button:ClearAllPoints();
            if Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==1 then
                button:SetPoint("TOPLEFT","HealBot_Action","TOPLEFT",thisX,-OsetY);
            elseif Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==2 then
                button:SetPoint("BOTTOMLEFT","HealBot_Action","BOTTOMLEFT",thisX,OsetY);
            elseif Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==3 then
                button:SetPoint("TOPRIGHT","HealBot_Action","TOPRIGHT",-thisX,-OsetY);
            else
                button:SetPoint("BOTTOMRIGHT","HealBot_Action","BOTTOMRIGHT",-thisX,OsetY);
            end
        end
        OsetY = OsetY+bHeight+brspace+HealBot_AddHeight
        if showCI and not HealBot_retdebuffTargetIcon(button.unit) then HealBot_Action_SetClassIconTexture(button, button.unit) end
    end
    return OsetY;
end

local HealBot_AggroBarSize=0
function HealBot_Action_SetAddHeight()
    if Healbot_Config_Skins.ShowAggro[Healbot_Config_Skins.Current_Skin]==0 and 
       Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==0 and
       Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==0 then        
        HealBot_AggroBarSize=0
    else
        HealBot_AggroBarSize=Healbot_Config_Skins.AggroBarSize[Healbot_Config_Skins.Current_Skin] or 2
    end
    if Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]==0 then
        if Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Current_Skin]==0 then
            HealBot_AddHeight=0
        else
            HealBot_AddHeight=(HealBot_AggroBarSize*2)
        end
    else
        if Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Current_Skin]==0 and 
           Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==0 and
           Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==0 then
            HealBot_AddHeight=Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]
        else
            HealBot_AddHeight=Healbot_Config_Skins.bar2size[Healbot_Config_Skins.Current_Skin]+(HealBot_AggroBarSize*2)
        end
    end
    HealBot_AddHeight=HealBot_AddHeight+HealBot_MultiRowHoToffset;
end



function HealBot_Action_SetHeightWidth(width,height,bWidth, numBars)
    HealBot_Action:SetHeight(height);
    if (Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]<3 and Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Current_Skin]==2) or (Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]>2 and Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Current_Skin]==1) then curcol=curcol+1; end;
    HealBot_Action:SetWidth(width+bWidth+7+(HealBot_MultiColHoToffset*curcol))
    HealBot_Action_setPoint()
end

local HealBot_noBars=25
function HealBot_Panel_SetNumBars(numBars)
    HealBot_noBars=numBars
end

local HealBot_setTestBars=false
local HealBot_setTestCols=false
function HealBot_Panel_ToggleTestBars()
    if HealBot_setTestBars then
        HealBot_setTestBars=false
        HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TESTBARS.." "..HEALBOT_WORD_OFF)
    else
        HealBot_setTestBars=true
        HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TESTBARS.." "..HEALBOT_WORD_ON)
        HealBot_setTestCols=false
    end
    HealBot_Action_Set_Timers()
end

function HealBot_Panel_retTestBars()
    return HealBot_setTestBars
end

local HealBot_noTestPets=0
function HealBot_Panel_TestBarsOn(showHeaders)
    noBars=HealBot_noBars
    i=0
    if Healbot_Config_Skins.SelfHeals[Healbot_Config_Skins.Current_Skin]==1 then
        j=i
        b=HealBot_Action_SetTestButton(j)
        if b then
            HealBot_Panel_TestBarShow(j,b)
            HeaderPos[j+1] = HEALBOT_OPTIONS_SELFHEALS 
            noBars=noBars-1
            i=i+1
        end
    end
    if Healbot_Config_Skins.TankHeals[Healbot_Config_Skins.Current_Skin]==1 and HealBot_Config.noTestTanks>0 and HealBot_Config.noTestTanks<noBars then
        HeaderPos[i+1] = HEALBOT_OPTIONS_TANKHEALS 
        for j=1+i,HealBot_Config.noTestTanks+i do
            b=HealBot_Action_SetTestButton(j)
            if b then
                HealBot_Panel_TestBarShow(j,b)
                noBars=noBars-1
                i=i+1
            end
        end
    end
    if noBars>0 then
        if noBars>5 then
            z=5
        else
            z=noBars
        end
        HeaderPos[i+1] = HEALBOT_OPTIONS_GROUPHEALS 
        for j=1+i,z+i do
            b=HealBot_Action_SetTestButton(j)
            if b then
                HealBot_Panel_TestBarShow(j,b)
                noBars=noBars-1
                i=i+1
            end
        end
    end
    if HealBot_Config.noTestTargets>0 and HealBot_Config.noTestTargets<noBars then
        HeaderPos[i+1] = HEALBOT_OPTIONS_MYTARGET 
        for j=1+i,HealBot_Config.noTestTargets+i  do
            b=HealBot_Action_SetTestButton(j)
            if b then
                HealBot_Panel_TestBarShow(j,b)
                noBars=noBars-1
                i=i+1
            end
        end
    end
    HealBot_noTestPets=HealBot_Config.noTestPets
    if HealBot_Config.noTestPets<=noBars then
        noBars=noBars-HealBot_Config.noTestPets
    else
        HealBot_noTestPets=0
    end
    for t=1,7 do
        if noBars>0 then
            if noBars>5 then
                z=5
            else
                z=noBars
            end
            HeaderPos[i+1] = HEALBOT_OPTIONS_GROUPHEALS 
            for j=1+i,z+i do
                b=HealBot_Action_SetTestButton(j)
                if b then
                    HealBot_Panel_TestBarShow(j,b)
                    noBars=noBars-1
                    i=i+1
                end
            end
        end
    end
    if HealBot_noTestPets>0 then
        HeaderPos[i+1] = HEALBOT_OPTIONS_PETHEALS
        for j=1+i,HealBot_noTestPets+i  do
            b=HealBot_Action_SetTestButton(j)
            if b then
                HealBot_Panel_TestBarShow(j,b)
            end
        end
    end
    HealBot_Panel_SetupBars(showHeaders)
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Unit_Button[xUnit]=nil
    end
    HealBot_setTestCols=true
end

local HealBot_keepClass=false
local HealBot_colIndex= {}

function HealBot_Panel_resetTestCols()
    if HealBot_setTestBars then
        HealBot_setTestCols=false
        if Delay_RecalcParty<2 then 
            Delay_RecalcParty=2; 
        end
    end
end

function HealBot_Panel_TestBarShow(index,button)
    table.insert(HealBot_Action_HealButtons,button)
    HealBot_TestBars[index]=button
    bar=HealBot_Action_HealthBar(button)
    HealBot_keepClass=false
    if not HealBot_setTestCols then
        if (Healbot_Config_Skins.SetBarClassColour[Healbot_Config_Skins.Current_Skin] == 1) then
            if (Healbot_Config_Skins.SetBarCustomColour[Healbot_Config_Skins.Current_Skin] == 1) then
                if index==1 then
                    HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index] = HealBot_Action_ClassColour(HealBot_PlayerGUID, "player")
                else
                    HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index] = HealBot_Panel_RandomClassColour()
                end
                if Healbot_Config_Skins.SetClassColourText[Healbot_Config_Skins.Current_Skin]==1 then
                    HealBot_keepClass=true
                end
            else
                HealBot_colIndex["hcr"..index]=Healbot_Config_Skins.barcolr[Healbot_Config_Skins.Current_Skin]
                HealBot_colIndex["hcg"..index]=Healbot_Config_Skins.barcolg[Healbot_Config_Skins.Current_Skin]
                HealBot_colIndex["hcb"..index]=Healbot_Config_Skins.barcolb[Healbot_Config_Skins.Current_Skin]
            end
        else
            HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index] = 0,1,0
        end
        if HealBot_keepClass then
            HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index] = HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index]
        else
            if Healbot_Config_Skins.SetClassColourText[Healbot_Config_Skins.Current_Skin]==1 then
                if index==1 then
                    HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index] = HealBot_Action_ClassColour(HealBot_PlayerGUID, "player")
                else
                    HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index] = HealBot_Panel_RandomClassColour()
                end
            else
                HealBot_colIndex["hctr"..index] = Healbot_Config_Skins.btextenabledcolr[Healbot_Config_Skins.Current_Skin]
                HealBot_colIndex["hctg"..index] = Healbot_Config_Skins.btextenabledcolg[Healbot_Config_Skins.Current_Skin]
                HealBot_colIndex["hctb"..index] = Healbot_Config_Skins.btextenabledcolb[Healbot_Config_Skins.Current_Skin]
            end
        end
        HealBot_initTestBar(bar)
        bar:SetValue(0)
    end
    bar:SetStatusBarColor(HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index],Healbot_Config_Skins.Barcola[Healbot_Config_Skins.Current_Skin]);
    bar.txt = _G[bar:GetName().."_text"];
    if Healbot_Config_Skins.ShowHealthOnBar[Healbot_Config_Skins.Current_Skin]==1 then
        if Healbot_Config_Skins.DoubleText[Healbot_Config_Skins.Current_Skin]==0 then
            if Healbot_Config_Skins.BarHealthType[Healbot_Config_Skins.Current_Skin]==1 then
                bar.txt:SetText(button.unit.." (0)");
            else
                bar.txt:SetText(button.unit.." (100%)");
            end
        else
            if Healbot_Config_Skins.BarHealthType[Healbot_Config_Skins.Current_Skin]==1 then
                bar.txt:SetText(button.unit.."\n(0)");
            else
                bar.txt:SetText(button.unit.."\n(100%)");
            end
        end
    else
        bar.txt:SetText(button.unit)
    end
    bar.txt:SetTextColor(HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index],Healbot_Config_Skins.btextenabledcola[Healbot_Config_Skins.Current_Skin]);
    bar:Show()
end

local HealBot_randomN=1
local HealBot_randomClCol = { [1] = { [1] = 1.0, [2] = 0.49, [3] = 0.04, },
                             [2] = { [1] = 0.67, [2] = 0.83, [3] = 0.45, },
                             [3] = { [1] = 0.41, [2] = 0.8, [3] = 0.94, },
                             [4] = { [1] = 0.96, [2] = 0.55, [3] = 0.73, },
                             [5] = { [1] = 1.0, [2] = 1.0, [3] = 1.0, },
                             [6] = { [1] = 1.0, [2] = 0.96, [3] = 0.41, },
                             [7] = { [1] = 0.14, [2] = 0.25, [3] = 1.0, },
                             [8] = { [1] = 0.58, [2] = 0.51, [3] = 0.79, },
                             [9] = { [1] = 0.78, [2] = 0.04, [3] = 0.04, },
                             [10] = { [1] = 0.78, [2] = 0.61, [3] = 0.43, },
                            }
function HealBot_Panel_RandomClassColour()
    HealBot_randomN=random(1, 10)
    return HealBot_randomClCol[HealBot_randomN][1],HealBot_randomClCol[HealBot_randomN][2],HealBot_randomClCol[HealBot_randomN][3]
end

function HealBot_Panel_TestBarsOff()
    for x,b in pairs(HealBot_TestBars) do
        HealBot_Action_InsButtonStore(b)
        HealBot_TestBars[x]=nil
    end
    for x,_ in pairs(HealBot_Action_HealButtons) do
        HealBot_Action_HealButtons[x]=nil;
    end
    for x,_ in pairs(HeaderPos) do
        HeaderPos[x]=nil;
    end
    HealBot_headerno=0;
end

function HealBot_Panel_PartyChanged(showHeaders)
    HealBot_Panel_TestBarsOff()
    if Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==2 or Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==4 then
        HealBot_BottomAnchors=true
    else
        HealBot_BottomAnchors=false
    end
    if Healbot_Config_Skins.ShowClassOnBar[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.ShowClassType[Healbot_Config_Skins.Current_Skin]==1 then
        showCI=true
    else
        showCI=false
    end
    if HealBot_setTestBars then
        if not HealBot_IsFighting then
            for xUnit,xButton in pairs(HealBot_Unit_Button) do
                HealBot_Action_InsButtonStore(xButton)
                HealBot_Unit_Button[xUnit]=nil
            end
            HealBot_Panel_TestBarsOn(showHeaders)
        else
            HealBot_Panel_PanelChanged(showHeaders)
            Delay_RecalcParty=1
        end
    else
        HealBot_Panel_PanelChanged(showHeaders)
    end
end

function HealBot_Panel_PanelChanged(showHeaders)

    local nraid=GetNumRaidMembers();
    local MyHealTargets=nil
    numHeaders = 0
    TempMaxH=9;
  
    for x,_ in pairs(HealBot_TrackNames) do
        HealBot_TrackNames[x]=nil;
    end
  
    for x,_ in pairs(HealBot_MainTanks) do
        HealBot_MainTanks[x]=nil;
    end
    
    for x,_ in pairs(HealBot_unitRole) do
        HealBot_unitRole[x]=nil;
    end
    
    for x,_ in pairs(HealBot_TempTanks) do
        HealBot_TempTanks[x]=nil;
    end
  
    for xGUID,_ in pairs(HealBot_Panel_BlackList) do
        HealBot_TrackNames[xGUID]=true
    end 
    
    for x,_ in pairs(HeaderPos) do
        HeaderPos[x]=nil
    end 

    for x,_ in pairs(HealBot_cpName) do
        HealBot_cpName[x]=nil
    end 
    
    for x,_ in pairs(HealBot_TrackUnit) do
        HealBot_TrackUnit[x]=nil
    end 
    
    table.foreach(HealBot_MyHealTargets, function (i,xGUID)
        HealBot_TrackNames[xGUID]=true
        MyHealTargets=true
    end)
  
    i=0;

    x=false
    if HealBot_retHealBot_UseCrashProtection() and Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]==1 then
        if nraid==0 and not UnitExists("player2") then
            HealBot_cpData["mName"]=HealBot_Config.CrashProtMacroName
            HealBot_cpData["body0"]=GetMacroBody(HealBot_cpData["mName"].."_0")
            if HealBot_cpData["body0"] and strsub(HealBot_cpData["body0"],1,5)~="Clean" then
                t=tonumber(strsub(HealBot_cpData["body0"],1,1))
                if t>0 and t<5 then
                    x=true
                    HealBot_cpData["numMacros"]=t
                    for j=1,t do
                        HealBot_cpData["body"..j]=GetMacroBody(HealBot_cpData["mName"].."_"..j)
                        if not HealBot_cpData["body"..j] or strlen(HealBot_cpData["body"..j])<14 then
                            x=false
                        end
                    end
                end
            end
        end
    end

    if x then -- Crash Protection
        for j=1,tonumber(HealBot_cpData["numMacros"]) do
            local u1n,u1u,u1g,u2n,u2u,u2g,u3n,u3u,u3g,u4n,u4u,u4g,u5n,u5u,u5g,u6n,u6u,u6g,u7n,u7u,u7g,u8n,u8u,u8g,u9n,u9u,u9g,u10n,u10u,u10g = string.split(":", HealBot_cpData["body"..j])
            HealBot_Panel_cpSort(u1n, u1u, u1g)
            HealBot_Panel_cpSort(u2n, u2u, u2g)
            HealBot_Panel_cpSort(u3n, u3u, u3g)
            HealBot_Panel_cpSort(u4n, u4u, u4g)
            HealBot_Panel_cpSort(u5n, u5u, u5g)
            HealBot_Panel_cpSort(u6n, u6u, u6g)
            HealBot_Panel_cpSort(u7n, u7u, u7g)
            HealBot_Panel_cpSort(u8n, u8u, u8g)
            HealBot_Panel_cpSort(u9n, u9u, u9g)
            HealBot_Panel_cpSort(u10n, u10u, u10g)
        end
        local _,c1,h1p,h1n,h2p,h2n,h3p,h3n,h4p,h4n,h5p,h5n,h6p,h6n,h7p,h7n,h8p,h8n,h9p,h9n,h10p,h10n,h11p,h11n,h12p,h12n = string.split(":", HealBot_cpData["body0"])
        if c1=="H" and h1p and h1n then
            showHeaders=true
            if h1p and h1n then HeaderPos[tonumber(h1p)] = h1n end
            if h2p and h2n then HeaderPos[tonumber(h2p)] = h2n end
            if h3p and h3n then HeaderPos[tonumber(h3p)] = h3n end
            if h4p and h4n then HeaderPos[tonumber(h4p)] = h4n end
            if h5p and h5n then HeaderPos[tonumber(h5p)] = h5n end
            if h6p and h6n then HeaderPos[tonumber(h6p)] = h6n end
            if h7p and h7n then HeaderPos[tonumber(h7p)] = h7n end
            if h8p and h8n then HeaderPos[tonumber(h8p)] = h8n end
            if h9p and h9n then HeaderPos[tonumber(h9p)] = h9n end
            if h10p and h10n then HeaderPos[tonumber(h10p)] = h10n end
            if h11p and h11n then HeaderPos[tonumber(h11p)] = h11n end
            if h12p and h12n then HeaderPos[tonumber(h12p)] = h12n end
        elseif showHeaders then
            showHeaders=false
        end
        HealBot_cpOn=true
    else
        HealBot_cpOn=false
        if nraid>0 then
            for j=1,40 do
                xUnit = "raid"..j;
                if UnitExists(xUnit) then
                    xGUID=UnitGUID(xUnit)
                    _, _, subgroup, _, _, _, _, online, _, role, _ = GetRaidRosterInfo(j);
                    HealBot_GroupGUID[xGUID]=subgroup
                    if role then
                        if string.lower(role)=="mainassist" then
                            HealBot_unitRole[xGUID]=hbRole[HEALBOT_MAINASSIST]
                        elseif string.lower(role)=="maintank" then
                            HealBot_unitRole[xGUID]=hbRole[HEALBOT_MAINTANK]
                        end
                    else
                        HealBot_unitRole[xGUID]=hbRole[HEALBOT_WORDS_UNKNOWN]
                    end
                    if (not online and not HealBot_Action_retUnitOffline(xGUID)) or HealBot_Action_retUnitOffline(xGUID) then
                        HealBot_Action_UnitIsOffline(xGUID)
                    end
                end
            end
        else
            for _,xUnit in ipairs(HealBot_Action_HealGroup) do
                if UnitExists(xUnit) then
                    xGUID=HealBot_UnitGUID(xUnit)
                    HealBot_GroupGUID[xGUID]=1
                    isTank, isHeal, isDPS = UnitGroupRolesAssigned(xUnit)
                    if isTank then
                        HealBot_unitRole[xGUID]=hbRole[HEALBOT_MAINTANK]
                        HealBot_addExtraTank(xGUID)
                    elseif isHeal then
                        HealBot_unitRole[xGUID]=hbRole[HEALBOT_WORD_HEALER]
                    elseif isDPS then
                        HealBot_unitRole[xGUID]=hbRole[HEALBOT_WORD_DPS]
                    else
                        HealBot_unitRole[xGUID]=hbRole[HEALBOT_WORDS_UNKNOWN]
                    end
                    if (not UnitIsConnected(xUnit) and not HealBot_Action_retUnitOffline(xGUID)) or HealBot_Action_retUnitOffline(xGUID) then
                        HealBot_Action_UnitIsOffline(xGUID)
                    end
                end
            end
        end
    
		if Healbot_Config_Skins.SelfHeals[Healbot_Config_Skins.Current_Skin]==1 then
			if not HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_SELFHEALS end
			k=i
			xUnit="player";
			uName=UnitName(xUnit);
			if not HealBot_TrackNames[HealBot_PlayerGUID] then
				i = i+1;
				HealBot_UnitName[HealBot_PlayerGUID] = uName;
				HealBot_UnitNameGUID[uName]=HealBot_PlayerGUID
				HealBot_TrackNames[HealBot_PlayerGUID]=true;
				b=HealBot_Action_SetHealButton(i,xUnit,HealBot_PlayerGUID);
				if b then
					HealBot_TrackGUID[HealBot_PlayerGUID]=nil
					HealBot_TrackUnit[xUnit]=HealBot_PlayerGUID
					table.insert(HealBot_Action_HealButtons,b)
				end
			end
			xUnit="pet";
			uName=UnitName(xUnit);
            xGUID=HealBot_UnitGUID(xUnit)
			if UnitExists(xUnit) and not HealBot_TrackNames[xGUID] then
				i = i+1;
				HealBot_UnitName[xGUID] = uName;
				HealBot_UnitNameGUID[uName]=xGUID
				HealBot_TrackNames[xGUID]=true;
				b=HealBot_Action_SetHealButton(i,xUnit,xGUID);
				if b then
					HealBot_TrackGUID[xGUID]=nil
					HealBot_TrackUnit[xUnit]=xGUID
					table.insert(HealBot_Action_HealButtons,b)
				end
			end
			if i>k then 
				numHeaders=numHeaders+1 
				if HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_SELFHEALS end
			end
		end
		
		if Healbot_Config_Skins.TankHeals[Healbot_Config_Skins.Current_Skin]==1 then
			if not HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_TANKHEALS end
			k=i
			if Healbot_Config_Skins.SubSortIncTanks[Healbot_Config_Skins.Current_Skin]==1 then 
				hbincSort=true
			else
				hbincSort=nil
			end
		    HealBot_RegTanks = HealBot_retHealBot_MainTanks()
			for _,xGUID in pairs(HealBot_RegTanks) do
				if not HealBot_TrackNames[xGUID] then 
					HealBot_MainTanks[xGUID]=true 
					HealBot_TempTanks[xGUID]=true 
				end
			end
			HealBot_RegTanks = HealBot_retHealBot_CTRATanks()
			for _,xGUID in pairs(HealBot_RegTanks) do
				if not HealBot_TrackNames[xGUID] then 
					HealBot_MainTanks[xGUID]=true 
					HealBot_TempTanks[xGUID]=true 
				end
			end
			if nraid>0 then
				for j=1,40 do
					xGUID=UnitGUID("raid"..j);
					if xGUID and not HealBot_TrackNames[xGUID] then
						if HealBot_MainTanks[xGUID] or ((HealBot_unitRole[xGUID] or "x")==hbRole[HEALBOT_MAINTANK]) then
							HealBot_MainTanks[xGUID]="raid"..j
							HealBot_TempTanks[xGUID]=nil 
						end
					end
				end
			else
				for _,xUnit in ipairs(HealBot_Action_HealGroup) do
					xGUID=UnitGUID(xUnit);
					if xGUID and not HealBot_TrackNames[xGUID] then
						if HealBot_MainTanks[xGUID] or ((HealBot_unitRole[xGUID] or "x")==hbRole[HEALBOT_MAINTANK]) then
							HealBot_MainTanks[xGUID]=xUnit
							HealBot_TempTanks[xGUID]=nil 
						end
					end
				end
			end
			for xGUID,_ in pairs(HealBot_TempTanks) do
				HealBot_MainTanks[xGUID]=nil
			end
			table.foreach(HealBot_MyPrivateTanks, function (index,xGUID)
				xUnit=HealBot_GetUnitID(xGUID)
				if xUnit and UnitExists(xUnit) and not HealBot_TrackNames[xGUID] then  
					HealBot_MainTanks[xGUID]=xUnit
				end
			end)
			for xGUID,xUnit in pairs(HealBot_MainTanks) do
				i = i+1;
				uName=UnitName(xUnit);
				HealBot_UnitName[xGUID] = uName
				HealBot_UnitNameGUID[uName]=xGUID
				HealBot_TrackNames[xGUID]=true;
				HealBot_unitRole[xGUID]=hbRole[HEALBOT_MAINTANK]
				if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
					HealBot_Panel_insSubSort(xUnit, xGUID)
				else
					table.insert(subunits,xUnit)
				end
			end
			if i>k then 
				HealBot_Panel_SubSort(hbincSort)
				numHeaders=numHeaders+1 
				if HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_TANKHEALS end
			end
		end
		
		if Healbot_Config_Skins.MainAssistHeals[Healbot_Config_Skins.Current_Skin]==1 then
			for x,_ in pairs(HealBot_MainTanks) do
				HealBot_MainTanks[x]=nil;
			end
			for x,_ in pairs(HealBot_TempTanks) do
				HealBot_TempTanks[x]=nil;
			end
			if not HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_MAINASSIST end
			k=i
			if Healbot_Config_Skins.SubSortIncTanks[Healbot_Config_Skins.Current_Skin]==1 then 
				hbincSort=true
			else
				hbincSort=nil
			end
			HealBot_RegTanks = HealBot_retHealBot_MainAssists()
			for _,xGUID in pairs(HealBot_RegTanks) do
				if not HealBot_TrackNames[xGUID] then 
					HealBot_MainTanks[xGUID]=true 
					HealBot_TempTanks[xGUID]=true 
				end
			end
			if nraid>0 then
			    for j=1,40 do
				xGUID=UnitGUID("raid"..j);
                    if xGUID and not HealBot_TrackNames[xGUID] then
                        if HealBot_MainTanks[xGUID] or ((HealBot_unitRole[xGUID] or "x")==hbRole[HEALBOT_MAINASSIST]) then
                            HealBot_MainTanks[xGUID]="raid"..j
                            HealBot_TempTanks[xGUID]=nil 
                        end
			        end
			    end
			else
		        for _,xUnit in ipairs(HealBot_Action_HealGroup) do
                    xGUID=UnitGUID(xUnit);
                    if xGUID and not HealBot_TrackNames[xGUID] then
                        if HealBot_MainTanks[xGUID] or ((HealBot_unitRole[xGUID] or "x")==hbRole[HEALBOT_MAINASSIST]) then
                            HealBot_MainTanks[xGUID]=xUnit
                            HealBot_TempTanks[xGUID]=nil 
                        end
                    end
			    end
			end
			for xGUID,_ in pairs(HealBot_TempTanks) do
				HealBot_MainTanks[xGUID]=nil
			end
			for xGUID,xUnit in pairs(HealBot_MainTanks) do
				i = i+1;
				uName=UnitName(xUnit);
				HealBot_UnitName[xGUID] = uName
				HealBot_UnitNameGUID[uName]=xGUID
				HealBot_TrackNames[xGUID]=true;
				HealBot_unitRole[xGUID]=hbRole[HEALBOT_MAINASSIST]
				if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
					HealBot_Panel_insSubSort(xUnit, xGUID)
				else
					table.insert(subunits,xUnit)
				end
			end
			if i>k then 
				HealBot_Panel_SubSort(hbincSort)
				numHeaders=numHeaders+1 
				if HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_MAINASSIST end
			end
            end
			
        MyGroup=0
        if Healbot_Config_Skins.GroupHeals[Healbot_Config_Skins.Current_Skin]==1 then
             if not HealBot_BottomAnchors then 
                 MyGroup=i+1
                 HeaderPos[MyGroup] = HEALBOT_OPTIONS_GROUPHEALS 
             end
             k=i
             if Healbot_Config_Skins.SubSortIncGroup[Healbot_Config_Skins.Current_Skin]==1 then 
                 hbincSort=true
             else
                 hbincSort=nil
            end
            z=0
            for _,xUnit in ipairs(HealBot_Action_HealGroup) do
                if UnitExists(xUnit) then
                    xGUID=HealBot_UnitGUID(xUnit)
                    if not HealBot_TrackNames[xGUID] then
                        uName=UnitName(xUnit);
                        if nraid>0 and uName~=HealBot_PlayerName then 
                            xUnit=HealBot_RaidUnit(xUnit,xGUID) 
                        end
                        i = i+1;
                        HealBot_UnitName[xGUID] = uName;
                        HealBot_UnitNameGUID[uName]=xGUID
                        HealBot_TrackNames[xGUID]=true;
                        if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
                            HealBot_Panel_insSubSort(xUnit, xGUID)
                        else
                            table.insert(subunits,xUnit)
                        end
                    end
                elseif nraid==0 and Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Current_Skin]==1 and 
                                    z<Healbot_Config_Skins.CombatProtParty[Healbot_Config_Skins.Current_Skin] then 
                    xGUID = xUnit
                    if not HealBot_TrackNames[xGUID] then
                        z=z+1
                        uName = HEALBOT_WORD_RESERVED..":"..xUnit
                        HealBot_GroupGUID[xGUID]=1
                        i=i+1;
                        HealBot_UnitName[xGUID] = uName;
                        HealBot_UnitNameGUID[uName]=xGUID
                        HealBot_TrackNames[xGUID]=true;
                        if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
                            HealBot_Panel_insSubSort(xUnit, xGUID)
                        else
                            table.insert(subunits,xUnit)
                        end
                    end
                end
            end
            if i>k then 
                numHeaders=numHeaders+1
                HealBot_Panel_SubSort(hbincSort)
                if HealBot_BottomAnchors then 
                    MyGroup=i+1
                    HeaderPos[MyGroup] = HEALBOT_OPTIONS_GROUPHEALS 
                end
            else
                MyGroup=0
            end
        end
		
        if Healbot_Config_Skins.SetFocusBar[Healbot_Config_Skins.Current_Skin]==1 then
            if UnitExists("focus") and not UnitIsEnemy("focus", "player") then
                xGUID=HealBot_UnitGUID("focus")
                if xGUID and not HealBot_Panel_RetMyHealTarget(xGUID) and not HealBot_TrackNames[xGUID] then 
                    HealBot_TrackNames[xGUID]=true;
                    table.insert(HealBot_MyHealTargets,xGUID)
                    MyHealTargets=true
                end
            end
        end
	  
        if MyHealTargets then
        --      if (Healbot_Config_Skins.ShowMyTargetsList[Healbot_Config_Skins.Current_Skin]==1 or MyGroup==0) then 
                if not HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_MYTARGET end
                k=i
        --     end
            if Healbot_Config_Skins.SubSortIncMyTargets[Healbot_Config_Skins.Current_Skin]==1 then 
                hbincSort=true
            else
                hbincSort=nil
            end
            table.foreach(HealBot_MyHealTargets, function (index,xGUID)
            --  HealBot_AddDebug("In MyHealTargets - uName="..uName)
                xUnit=HealBot_RaidUnit("unknown",xGUID) 
                if UnitExists(xUnit) then
                    i = i+1;
                    uName=UnitName(xUnit)
                    HealBot_UnitName[xGUID] = uName
                    HealBot_UnitNameGUID[uName]=xGUID
                    if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
                        HealBot_Panel_insSubSort(xUnit, xGUID)
                    else
                        table.insert(subunits,xUnit)
                    end
                else
                    HealBot_Panel_ToggelHealTarget(xGUID)
                end
            end)
            if i>k then 
                HealBot_Panel_SubSort(hbincSort)
                numHeaders=numHeaders+1 
                if HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_MYTARGET end
            end
        end

        if Healbot_Config_Skins.EmergencyHeals[Healbot_Config_Skins.Current_Skin]==1 then
            for x,_ in pairs(order) do
                order[x]=nil;
            end
            for x,_ in pairs(units) do
                units[x]=nil;
            end
            for x,_ in pairs(subunits) do
                subunits[x]=nil;
            end
            k=i
            if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==1 or Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==5 then
                if not HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_EMERGENCYHEALS end
                numHeaders=numHeaders+1;
            end
            if Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==1 then
                subgroup = 1;
                if nraid>0 then
                    z=0
                    for j=1,40 do
                        xUnit = "raid"..j;
                        xGUID=UnitGUID(xUnit)
                        uName=UnitName(xUnit);
                        _, _, subgroup, _, class, _, _, online, _, role, _ = GetRaidRosterInfo(j);
                        if xGUID then
                            if xGUID==HealBot_PlayerGUID then
                                xUnit="player"
                                if MyGroup>0 then
                                    HeaderPos[MyGroup] = HEALBOT_OPTIONS_GROUPHEALS.." "..subgroup;
                                end
                            end
                        end
                        if UnitExists(xUnit) then
                            if not HealBot_TrackNames[xGUID] then
                                class,classEN=UnitClass(xUnit)
                                if Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][subgroup] and classEN then
                                    if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==1 then
                                        order[xUnit] = uName;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==2 then
                                        order[xUnit] = classEN;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==3 then
                                        order[xUnit] = subgroup;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==4 then
                                        order[xUnit] = 0-UnitHealthMax(xUnit);
                                        if UnitHealthMax(xUnit)>TempMaxH then TempMaxH=UnitHealthMax(xUnit); end
                                    end
                                    table.insert(units,xUnit);
                                    HealBot_UnitName[xGUID] = uName;
                                    HealBot_UnitNameGUID[uName]=xGUID
                                    HealBot_TrackNames[xGUID]=true;
                                end
                            end
                        elseif Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Current_Skin]==1 and 
                               z<Healbot_Config_Skins.CombatProtRaid[Healbot_Config_Skins.Current_Skin] then 
                            xGUID = xUnit
                            if not HealBot_TrackNames[xGUID] then
                                HealBot_GroupGUID[xGUID]=8
                                uName = HEALBOT_WORD_RESERVED..":"..xUnit
                                z=z+1
                                if Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][subgroup] then
                                    if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==1 then
                                        order[xUnit] = "ZZZZ"..uName;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==2 then
                                        order[xUnit] = "WARRIOR"
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==3 then
                                        order[xUnit] = 8;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==4 then
                                        order[xUnit] = 0-maxHealDiv;
                                    end
                                    table.insert(units,xUnit);
                                    HealBot_UnitName[xGUID] = uName;
                                    HealBot_UnitNameGUID[uName]=xGUID
                                    HealBot_TrackNames[xGUID]=true;
                                end
                            end
                        end
                    end
                else
                    z=0
                    for _,xUnit in ipairs(HealBot_Action_HealGroup) do
                        uName=UnitName(xUnit);
                        xGUID=HealBot_UnitGUID(xUnit)
                        if UnitExists(xUnit) then
                            if not HealBot_TrackNames[xGUID] then
                                class,classEN=UnitClass(xUnit)
                                if Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][subgroup] and classEN then
                                    if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==1 then
                                        order[xUnit] = uName;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==2 then
                                        order[xUnit] = classEN;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==3 then
                                        order[xUnit] = subgroup;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==4 then
                                        order[xUnit] = 0-UnitHealthMax(xUnit);
                                        if UnitHealthMax(xUnit)>TempMaxH then TempMaxH=UnitHealthMax(xUnit); end
                                    end
                                    table.insert(units,xUnit);
                                    HealBot_UnitName[xGUID] = uName;
                                    HealBot_UnitNameGUID[uName]=xGUID
                                    HealBot_TrackNames[xGUID]=true;
                                end
                            end
                        elseif Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.GroupHeals[Healbot_Config_Skins.Current_Skin]==0 and
                               z<Healbot_Config_Skins.CombatProtParty[Healbot_Config_Skins.Current_Skin] then 
                            xGUID = xUnit
                            if not HealBot_TrackNames[xGUID] then
                                HealBot_GroupGUID[xGUID]=subgroup
                                uName = HEALBOT_WORD_RESERVED..":"..xUnit
                                z=z+1
                                if Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][subgroup] then
                                    if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==1 then
                                        order[xUnit] = "ZZZZ"..uName;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==2 then
                                        order[xUnit] = "WARRIOR";
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==3 then
                                        order[xUnit] = subgroup;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==4 then
                                        order[xUnit] = 0-maxHealDiv;
                                    end
                                    table.insert(units,xUnit);
                                    HealBot_UnitName[xGUID] = uName;
                                    HealBot_UnitNameGUID[uName]=xGUID
                                    HealBot_TrackNames[xGUID]=true;
                                end
                            end
                        end
                    end
                end
            else
                if nraid>0 then
		            z=0
                    for j=1,40 do
                        xUnit = "raid"..j;
                        xGUID=UnitGUID(xUnit)
                        uName=UnitName(xUnit);
                        _, _, subgroup, _, class, _, _, online, _, role, _ = GetRaidRosterInfo(j);
                        if xGUID then
                            if xGUID==HealBot_PlayerGUID then
                                xUnit="player"
                                if MyGroup>0 then
                                    HeaderPos[MyGroup] = HEALBOT_OPTIONS_GROUPHEALS.." "..subgroup;
                                end
                            end
                        end
                        if UnitExists(xUnit) and xGUID then
                            if HealBot_TrackNames[xGUID] then
                                class,classEN=UnitClass(xUnit)
                                if Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][subgroup] and class and HealBot_EmergInc[strsub(classEN,1,4)]==1 then
                                    if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==1 then
                                        order[xUnit] = uName;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==2 then
                                        order[xUnit] = classEN;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==3 then
                                        order[xUnit] = subgroup;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==4 then
                                        order[xUnit] = 0-UnitHealthMax(xUnit);
                                        if UnitHealthMax(xUnit)>TempMaxH then TempMaxH=UnitHealthMax(xUnit); end
                                    end
                                    table.insert(units,xUnit);
                                    HealBot_UnitName[xGUID] = uName;
                                    HealBot_UnitNameGUID[uName]=xGUID
                                    HealBot_TrackNames[xGUID]=true;
                                end
                            end
                        elseif Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Current_Skin]==1 and 
                               z<Healbot_Config_Skins.CombatProtRaid[Healbot_Config_Skins.Current_Skin] then 
                            xGUID = xUnit
                            if not HealBot_TrackNames[xGUID] then
                                HealBot_GroupGUID[xGUID]=8
                                uName = HEALBOT_WORD_RESERVED..":"..xUnit
                                z=z+1
                                if Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][subgroup] then
                                    if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==1 then
                                        order[xUnit] = "ZZZZ"..uName;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==2 then
                                        order[xUnit] = "WARRIOR";
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==3 then
                                        order[xUnit] = 8;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==4 then
                                        order[xUnit] = 0-maxHealDiv;
                                    end
                                    table.insert(units,xUnit);
                                    HealBot_UnitName[xGUID] = uName;
                                    HealBot_UnitNameGUID[uName]=xGUID
                                    HealBot_TrackNames[xGUID]=true;
                                end
                            end
                        end
                    end
                else
                    z=0
                    for _,xUnit in ipairs(HealBot_Action_HealGroup) do
                        class,classEN = UnitClass(xUnit);
                        xGUID=HealBot_UnitGUID(xUnit)
                        uName=UnitName(xUnit);
                        if UnitExists(xUnit) then
                            if not HealBot_TrackNames[xGUID] then
                                if Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][subgroup] and HealBot_EmergInc[strsub(classEN,1,4)]==1 then
                                    if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==1 then
                                        order[xUnit] = uName;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==2 then
                                        order[xUnit] = classEN;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==3 then
                                        order[xUnit] = subgroup;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==4 then
                                        order[xUnit] = 0-UnitHealthMax(xUnit);
                                        if UnitHealthMax(xUnit)>TempMaxH then TempMaxH=UnitHealthMax(xUnit); end
                                    end
                                    table.insert(units,xUnit);
                                    HealBot_UnitName[xGUID] = uName;
                                    HealBot_UnitNameGUID[uName]=xGUID
                                    HealBot_TrackNames[xGUID]=true;
                                end
                            end
                        elseif Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Current_Skin]==1 and Healbot_Config_Skins.GroupHeals[Healbot_Config_Skins.Current_Skin]==0 and
                               z<Healbot_Config_Skins.CombatProtParty[Healbot_Config_Skins.Current_Skin] then 
                            xGUID = xUnit
                            if not HealBot_TrackNames[xGUID] then
                                uName = HEALBOT_WORD_RESERVED..":"..xUnit
                                HealBot_GroupGUID[xGUID]=subgroup
                                z=z+1
                                if Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][subgroup] then
                                    if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==1 then
                                        order[xUnit] = "ZZZZ"..uName;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==2 then
                                        order[xUnit] = "WARRIOR";
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==3 then
                                        order[xUnit] = subgroup;
                                    elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==4 then
                                        order[xUnit] = 0-maxHealDiv;
                                    end
                                    table.insert(units,xUnit);
                                    HealBot_UnitName[xGUID] = uName;
                                    HealBot_UnitNameGUID[uName]=xGUID
                                    HealBot_TrackNames[xGUID]=true;
                                end
                            end
                        end
                    end
                end
            end
            if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]<5 then
                table.sort(units,function (a,b)
                    if order[a]<order[b] then return true end
                    if order[a]>order[b] then return false end
                    return a<b
                end)
            end
            TempMaxH=ceil(TempMaxH/maxHealDiv)*maxHealDiv;
            TempMaxHinit=TempMaxH
            TempSort="init"
            for x,_ in pairs(order) do
                order[x]=nil;
            end

            for j=1,41 do
                if not units[j] then 
                    classEN="end"
                    TempGrp=99
                    TempUnitMaxH=1
                else
                    xUnit=units[j];
                    if UnitExists(xUnit) then
                        class,classEN = UnitClass(xUnit)
                        xGUID=UnitGUID(xUnit)
                        TempUnitMaxH=UnitHealthMax(xUnit)
                    else
                        classEN = "WARRIOR";
                        class = HEALBOT_WARRIOR
                        xGUID = xUnit
                        TempUnitMaxH = maxHealDiv
                    end
                    TempGrp=HealBot_GroupGUID[xGUID]
                    i = i+1;
                end
                if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==2 and TempSort~=classEN then 
                    if TempSort=="init" then 
                        SubSort=classEN
                    else
                        if HealBot_BottomAnchors then 
                            HeaderPos[i+1] = class
                            numHeaders=numHeaders+1;
                        end
                    end
                    TempSort=classEN
                    if units[j] and not HealBot_BottomAnchors then 
                        HeaderPos[i] = class
                        numHeaders=numHeaders+1;
                    end
                    if TempSort~=SubSort then
                        HealBot_Panel_SubSort(true)
                        SubSort=TempSort
                    end
                elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==3 and TempSort~=TempGrp then
                    if TempSort=="init" then 
                        SubSort=TempGrp
                    else
                        if HealBot_BottomAnchors then 
                            HeaderPos[i+1] = HEALBOT_OPTIONS_GROUPHEALS.." "..TempSort
                            numHeaders=numHeaders+1;
                        end
                    end
                    TempSort=TempGrp
                    if units[j] and not HealBot_BottomAnchors then  
                        HeaderPos[i] = HEALBOT_OPTIONS_GROUPHEALS.." "..TempSort
                        numHeaders=numHeaders+1;
                    end
                    if TempSort~=SubSort then
                        HealBot_Panel_SubSort(true)
                        SubSort=TempSort
                    end
                elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==4 and TempMaxH>TempUnitMaxH then
                    if TempMaxHinit==TempMaxH then 
                        SubSort=TempMaxH-maxHealDiv
                    else
                        if HealBot_BottomAnchors then 
                            HeaderPos[i+1] = ">"..format("%s",(TempMaxH/1000)).."k"
                            numHeaders=numHeaders+1;
                        end
                    end
                    TempMaxH=TempMaxH-maxHealDiv
                    if TempMaxH>TempUnitMaxH and TempMaxH>0 then 
                        TempMaxH=TempMaxH-maxHealDiv
                        if TempMaxH>TempUnitMaxH and TempMaxH>0 then 
                            TempMaxH=TempMaxH-maxHealDiv
                            if TempMaxH>TempUnitMaxH and TempMaxH>0 then TempMaxH=TempMaxH-maxHealDiv end
                            if TempMaxH>TempUnitMaxH and TempMaxH>0 then TempMaxH=TempMaxH-maxHealDiv end
                            if TempMaxH>TempUnitMaxH and TempMaxH>0 then TempMaxH=TempMaxH-maxHealDiv end
                            if TempMaxH>TempUnitMaxH and TempMaxH>0 then TempMaxH=TempMaxH-maxHealDiv end
                            if TempMaxH>TempUnitMaxH and TempMaxH>0 then TempMaxH=TempMaxH-maxHealDiv end
                            if TempMaxH>TempUnitMaxH and TempMaxH>0 then TempMaxH=TempMaxH-maxHealDiv end
                            if TempMaxH>TempUnitMaxH and TempMaxH>0 then TempMaxH=TempMaxH-maxHealDiv end
                            if TempMaxH>TempUnitMaxH and TempMaxH>0 then TempMaxH=TempMaxH-maxHealDiv end
                        end
                    end
                    if units[j] and not HealBot_BottomAnchors then 
                        HeaderPos[i] = ">"..format("%s",(TempMaxH/1000)).."k"
                        numHeaders=numHeaders+1;
                    end
                    if TempMaxH~=SubSort then
                        HealBot_Panel_SubSort(true)
                        SubSort=TempMaxH
                    end
                end
                if Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==5 and not units[j] then
                    HealBot_Panel_SubSort(true)
                elseif Healbot_Config_Skins.ExtraOrder[Healbot_Config_Skins.Current_Skin]==1 and units[j] then
                    b=HealBot_Action_SetHealButton(i,xUnit,xGUID);
                    if b then
                        HealBot_TrackGUID[xGUID]=nil
                        HealBot_TrackUnit[xUnit]=xGUID
                        table.insert(HealBot_Action_HealButtons,b)
                    end
                elseif units[j] then
                    if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 then
                        HealBot_Panel_insSubSort(xUnit, xGUID)
                    else
                        table.insert(subunits,xUnit)
                    end
                else
                    do break end
                end
			end
			if i==k+1 and not HealBot_BottomAnchors then
				HeaderPos[i+1] = nil 
		 --   else
		 --       if HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_EMERGENCYHEALS end
			end
		end
		
		HealBot_NumPlayerBars=i
		
		if Healbot_Config_Skins.PetHeals[Healbot_Config_Skins.Current_Skin]==1 then
			for x,_ in pairs(HealBot_CheckedTargets) do
				HealBot_CheckedTargets[x]=nil;
			end
			if not HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_PETHEALS end
			k=i
			xUnit="pet"
			pUnit="player"
			xGUID=HealBot_UnitGUID(xUnit)
			uName=UnitName(xUnit);
			if Healbot_Config_Skins.SubSortIncPet[Healbot_Config_Skins.Current_Skin]==1 then 
				hbincSort=true
			else
				hbincSort=nil
			end
			if UnitExists(xUnit) and not HealBot_TrackNames[xGUID] and not HealBot_CheckedTargets[xGUID] and not UnitUsingVehicle(pUnit) then
				i = i+1;
				HealBot_UnitName[xGUID] = uName;
				HealBot_UnitNameGUID[uName]=xGUID
				HealBot_GroupGUID[xGUID]=HealBot_GroupGUID[UnitGUID(pUnit)]
				if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
					HealBot_Panel_insSubSort(xUnit, xGUID)
				else
					table.insert(subunits,xUnit)
				end
				HealBot_CheckedTargets[xGUID]=true;
			end
			if nraid>0 then
				for j=1,40 do
					xUnit="raidpet"..j;
					xGUID=HealBot_UnitGUID(xUnit)
					pUnit="raid"..j;
					uName=UnitName(xUnit);
					if UnitExists(xUnit) and not HealBot_TrackNames[xGUID] and not HealBot_CheckedTargets[xGUID] and HealBot_TrackNames[UnitGUID(pUnit)] and not UnitUsingVehicle(pUnit) then
						i = i+1;
						HealBot_UnitName[xGUID] = uName;
						HealBot_UnitNameGUID[uName]=xGUID
						HealBot_GroupGUID[xGUID]=HealBot_GroupGUID[UnitGUID(pUnit)]
						if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
							HealBot_Panel_insSubSort(xUnit, xGUID)
						else
							table.insert(subunits,xUnit)
						end
						HealBot_CheckedTargets[xGUID]=true;
					end
					if i>52 then break end
				end
			else
				for j=1,4 do
					xUnit="partypet"..j;
					xGUID=HealBot_UnitGUID(xUnit)
					pUnit="party"..j;
					uName=UnitName(xUnit);
					if UnitExists(xUnit) and not HealBot_TrackNames[xGUID] and not HealBot_CheckedTargets[xGUID] and HealBot_TrackNames[UnitGUID(pUnit)] and not UnitUsingVehicle(pUnit) then
						i = i+1;
						HealBot_UnitName[xGUID] = uName;
						HealBot_UnitNameGUID[uName]=xGUID
						HealBot_GroupGUID[xGUID]=HealBot_GroupGUID[UnitGUID(pUnit)]
						if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
							HealBot_Panel_insSubSort(xUnit, xGUID)
						else
							table.insert(subunits,xUnit)
						end
						HealBot_CheckedTargets[xGUID]=true;
					end
					if i>52 then break end
				end
			end
			if i>k then
				HealBot_Panel_SubSort(hbincSort)        
				numHeaders=numHeaders+1 
				if HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_OPTIONS_PETHEALS end
			end
		end

		
		if Healbot_Config_Skins.VehicleHeals[Healbot_Config_Skins.Current_Skin]==1 and i<53 then
			for x,_ in pairs(HealBot_CheckedTargets) do
				HealBot_CheckedTargets[x]=nil;
			end
			if Healbot_Config_Skins.SubSortIncVehicle[Healbot_Config_Skins.Current_Skin]==1 then 
				hbincSort=true
			else
				hbincSort=nil
			end
			if not HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_VEHICLE end
			k=i
			xUnit="pet"
			pUnit="player"
			xGUID=HealBot_UnitGUID(xUnit)
			uName=UnitName(xUnit);
			if xGUID and not HealBot_TrackNames[xGUID] and not HealBot_CheckedTargets[xGUID] and UnitUsingVehicle(pUnit) and uName then
				i = i+1;
				HealBot_UnitName[xGUID] = uName;
				HealBot_UnitNameGUID[uName]=xGUID
				HealBot_GroupGUID[xGUID]=HealBot_GroupGUID[UnitGUID(pUnit)]
				if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
					HealBot_Panel_insSubSort(xUnit, xGUID)
				else
					table.insert(subunits,xUnit)
				end
				HealBot_CheckedTargets[xGUID]=true;
			end
			if nraid>0 and i<53 then
				for j=1,40 do
					xUnit="raidpet"..j;
					xGUID=HealBot_UnitGUID(xUnit)
					pUnit="raid"..j;
					uName=UnitName(xUnit);
					if xGUID and not HealBot_TrackNames[xGUID] and not HealBot_CheckedTargets[xGUID] and HealBot_TrackNames[UnitGUID(pUnit)] and UnitUsingVehicle(pUnit) and uName then
						i = i+1;
						HealBot_UnitName[xGUID] = uName;
						HealBot_UnitNameGUID[uName]=xGUID
						HealBot_GroupGUID[xGUID]=HealBot_GroupGUID[UnitGUID(pUnit)]
						if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
							HealBot_Panel_insSubSort(xUnit, xGUID)
						else
							table.insert(subunits,xUnit)
						end
						HealBot_CheckedTargets[xGUID]=true;
					end
					if i>52 then break end
				end
			elseif i<55 then
				for j=1,4 do
					xUnit="partypet"..j;
					xGUID=HealBot_UnitGUID(xUnit)
					pUnit="party"..j;
					uName=UnitName(xUnit);
					if xGUID and not HealBot_TrackNames[xGUID] and not HealBot_CheckedTargets[xGUID] and HealBot_TrackNames[UnitGUID(pUnit)] and UnitUsingVehicle(pUnit) and uName then
						i = i+1;
						HealBot_UnitName[xGUID] = uName;
						HealBot_UnitNameGUID[uName]=xGUID
						HealBot_GroupGUID[xGUID]=HealBot_GroupGUID[UnitGUID(pUnit)]
						if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
							HealBot_Panel_insSubSort(xUnit, xGUID)
						else
							table.insert(subunits,xUnit)
						end
						HealBot_CheckedTargets[xGUID]=true;
					end
					if i>52 then break end
				end
			end
			if i>k then 
				HealBot_Panel_SubSort(hbincSort)    
				numHeaders=numHeaders+1 
				if HealBot_BottomAnchors then HeaderPos[i+1] = HEALBOT_VEHICLE end
			end
		end
		
		
		
		if Healbot_Config_Skins.TargetHeals[Healbot_Config_Skins.Current_Skin]==1 and not HealBot_IsFighting then
            xUnit="target";
			if UnitExists(xUnit) and UnitIsFriend("player",xUnit) and UnitHealth(xUnit)>99 then
				uName=UnitName(xUnit)
				TargetValid=false
				if uName==HealBot_PlayerName then 
					if Healbot_Config_Skins.TargetIncSelf[Healbot_Config_Skins.Current_Skin]==1 then TargetValid=true end
				elseif UnitInParty("target") then
					if Healbot_Config_Skins.TargetIncGroup[Healbot_Config_Skins.Current_Skin]==1 then TargetValid=true end
				elseif UnitInRaid("target") then 
					if Healbot_Config_Skins.TargetIncRaid[Healbot_Config_Skins.Current_Skin]==1 then TargetValid=true end
				elseif UnitPlayerOrPetInParty("target") or UnitPlayerOrPetInRaid("target") then
					if Healbot_Config_Skins.TargetIncPet[Healbot_Config_Skins.Current_Skin]==1 then TargetValid=true end
				else
					TargetValid=true
                    xGUID=HealBot_UnitGUID(xUnit)
				end
                
				if TargetValid and xGUID and not HealBot_Panel_BlackList[xGUID] then
					if HealBot_BottomAnchors then 
						HeaderPos[i+2] = HEALBOT_OPTIONS_TARGETHEALS
					else
						HeaderPos[i+1] = HEALBOT_OPTIONS_TARGETHEALS
					end
					if xGUID and HealBot_MayHeal(xUnit, uName) then
						HealBot_UnitName[xGUID] = uName;    
						b=HealBot_Action_SetTargetHealButton(xUnit,xGUID);
						if b then
							HealBot_TrackGUID[xGUID]=nil
							HealBot_TrackUnit[xUnit]=xGUID
							table.insert(HealBot_Action_HealButtons,b)
							numHeaders=numHeaders+1
						end
					end
				end
			end
		end
        
        for xGUID,xUnit in pairs(HealBot_TrackGUID) do
          --  if xGUID~=HealBot_PlayerGUID then
                HealBot_HoT_RemoveIcon(xGUID)
                HealBot_Action_RemoveMember(xGUID,xUnit)
          --  end
        end
        
        HealBot_TrackGUID={}

        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            xGUID=xButton.guid
            if HealBot_TrackUnit[xUnit] and not HealBot_Panel_BlackList[xGUID] then
                HealBot_TrackGUID[xGUID]=xUnit;
                if HealBot_HoT_Active_Button[xGUID] then
                    if HealBot_HoT_Active_Button[xGUID]~=xButton then
                        HealBot_HoT_MoveIcon(HealBot_HoT_Active_Button[xGUID], xButton, xGUID)
                        HealBot_HoT_Active_Button[xGUID]=xButton  
                    end
                end
                HealBot_talentSpam(xGUID,"insert",nil)
            else
                if xUnit~="target" then 
                    HealBot_Action_InsButtonStore(xButton)
                else
                    xButton:Hide()
                end
                HealBot_Unit_Button[xUnit]=nil
            end
        end

        if Healbot_Config_Skins.CrashProt[Healbot_Config_Skins.Current_Skin]==1 and not HealBot_IsFighting then
            HealBot_cpData["mName"]=HealBot_Config.CrashProtMacroName
            j=0
            k=1
            t=HealBot_cpData["body1"]
            HealBot_cpData["body1"]=""
            table.foreach(HealBot_Action_HealButtons, function (x,xButton)
                if UnitName(xButton.unit) then
                    j=j+1
                    if j>10 then 
                        if HealBot_cpData["body"..k]~=t then HealBot_Panel_cpSave(k) end
                        j=1 
                        k=k+1
                        t=HealBot_cpData["body"..k]
                        HealBot_cpData["body"..k]=""
                    end
                    if k<5 then
                        xUnit=HealBot_cpsUnit(xButton.unit,nil)
                        if xUnit then
                            if UnitGUID(xButton.unit) then
                                xGUID=strsub(UnitGUID(xButton.unit),3)
                                HealBot_cpData["body"..k]=HealBot_cpData["body"..k]..strsub(UnitName(xButton.unit),1,3)..":"..xUnit..":"..xGUID..":"
                            else
                                Delay_RecalcParty=1
                            end
                        end
                    end
                end
            end)
            if HealBot_cpData["body"..k]~=t then HealBot_Panel_cpSave(k) end
            t=HealBot_cpData["body0"]
            if showHeaders then
                
                HealBot_cpData["body0"]=k..":H:"
                for j=1,(k*10)+j do
                    if HeaderPos[j] then 
                        HealBot_cpData["body0"]=HealBot_cpData["body0"]..j..":"..HeaderPos[j]..":"
                    end
                end
            else
                HealBot_cpData["body0"]=k..":N"
            end
            if HealBot_cpData["body0"]~=t then HealBot_Panel_cpSave(0) end
        end

    end
    
    HealBot_Panel_SetupBars(showHeaders)

    if Healbot_Config_Skins.ShowRaidIcon[Healbot_Config_Skins.Current_Skin]==1 then HealBot_OnEvent_RaidTargetUpdate(nil) end
    
    HealBot_Update_nonAggro()
  
end

function HealBot_Panel_cpSave(mNum)
    HealBot_cpQueue(mNum, HealBot_cpData["mName"].."_"..mNum, HealBot_cpData["body"..mNum])
end

function HealBot_Panel_insSubSort(unit, hbGUID)
    if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]==1 then
        if unit == "player" and Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Current_Skin]==1 then
            order[unit] = "!";
        elseif UnitExists(unit) then
            order[unit] = HealBot_UnitName[hbGUID];
        else
            order[unit] = "ZZZZ"..HealBot_UnitName[hbGUID];
        end
    elseif Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]==2 then
        class,classEN = UnitClass(unit);
        if unit == "player" and Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Current_Skin]==1 then
            order[unit] = "!";
        else
            order[unit] = classEN or "ZZ"
        end
    elseif Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]==3 then
        if unit == "player" and Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Current_Skin]==1 then
            order[unit] = -1
        elseif UnitExists(unit) then
            order[unit] = HealBot_GroupGUID[hbGUID]
        else
            order[unit] = 9
        end
    elseif Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]==4 then
        if unit == "player" and Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Current_Skin]==1 then
            order[unit] = -999999
        else
            order[unit] = 0-(UnitHealthMax(unit) or 1)
        end
    else
        if unit == "player" and Healbot_Config_Skins.SubSortPlayerFirst[Healbot_Config_Skins.Current_Skin]==1 then
            order[unit] = -1
        else
            order[unit] = HealBot_unitRole[hbGUID] or 99
        end
    end
    table.insert(subunits,unit)
end

function HealBot_Panel_SubSort(hbincSort)
    if Healbot_Config_Skins.ExtraSubOrder[Healbot_Config_Skins.Current_Skin]<6 and hbincSort then
        table.sort(subunits,function (a,b)
            if not order[a] or not order[b] then
                return false
            else
                if order[a]<order[b] then return true end
                if order[a]>order[b] then return false end
                return a<b
            end
        end)
    end
    for j=1,#subunits do
        sUnit=subunits[j];
        sGUID=HealBot_UnitGUID(sUnit) or sUnit
        b=HealBot_Action_SetHealButton((j-#subunits)+i,sUnit,sGUID);
        if b then
            HealBot_TrackGUID[sGUID]=nil
            HealBot_TrackUnit[sUnit]=sGUID
            table.insert(HealBot_Action_HealButtons,b)
        end
    end
    for x,_ in pairs(order) do
        order[x]=nil;
    end
    for x,_ in pairs(subunits) do
        subunits[x]=nil;
    end
end

function HealBot_Panel_cpSort(unitName, unit, hbGUID)
    if unitName and unit and hbGUID then
        unit=HealBot_cpsUnit(nil,unit)
        hbGUID="0x"..hbGUID
        HealBot_UnitName[hbGUID] = unitName;
        i=i+1
        b=HealBot_Action_SetHealButton(i,unit,hbGUID);
        if b then
            table.insert(HealBot_Action_HealButtons,b)
            HealBot_cpName[unit]=unitName
            HealBot_TrackGUID[hbGUID]=unit
        end
    end
end

function HealBot_cpsUnit(unit,sUnit)
    xUnit=nil
    if unit then
        if unit=="player" then
            xUnit="p"
    --    elseif unit=="pet" then
    --        xUnit="t"
        elseif strsub(unit,6,3)=="pet" then
    --        xUnit="t"..strsub(unit,10)
        elseif strsub(unit,1,5)=="party" then
            xUnit="g"..strsub(unit,6)
        elseif strsub(unit,5,3)=="pet" then
--            xUnit="z"..strsub(unit,8)
        elseif strsub(unit,1,4)=="raid" then
            xUnit=strsub(unit,5)
        elseif unit=="focus" then
            xUnit="f"
        end
    elseif sUnit then
        if sUnit=="p" then
            xUnit="player"
    --    elseif sUnit=="t" then
    --        xUnit="pet"
    --    elseif strsub(sUnit,1,1)=="t" then
    --        xUnit="partypet"..strsub(sUnit,2)
        elseif strsub(sUnit,1,1)=="g" then
            xUnit="party"..strsub(sUnit,2)
    --    elseif strsub(sUnit,1,1)=="z" then
    --        xUnit="raidpet"..strsub(sUnit,2)
        elseif sUnit=="f" then
            xUnit="focus"
        else
            xUnit="raid"..sUnit
        end
    end
    return xUnit
end

function HealBot_Panel_SetupBars(showHeaders)
    bwidth = Healbot_Config_Skins.bwidth[Healbot_Config_Skins.Current_Skin];
    bheight=Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin];
    bcspace=Healbot_Config_Skins.bcspace[Healbot_Config_Skins.Current_Skin];
    cols=Healbot_Config_Skins.numcols[Healbot_Config_Skins.Current_Skin];
    i=0
    if Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]<3 then
        curcol=2-Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Current_Skin]
    else
        curcol=2-(3-Healbot_Config_Skins.HoTposBar[Healbot_Config_Skins.Current_Skin])
    end
    z=1;
    OffsetY = 4 + HealBot_AggroBarSize;
    OffsetX = 7;
    MaxOffsetY=0;
  
    if showHeaders then 
        if HealBot_BottomAnchors then 
            h=1
        else
            h=0
        end
        table.foreach(HealBot_Action_HealButtons, function (x,xButton)
            if UnitName(xButton.unit) then
                uName=UnitName(xButton.unit);
            elseif Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Current_Skin]==1 and HealBot_UnitName[xButton.guid] then -- Combat Protection 
                uName=HealBot_UnitName[xButton.guid];
                xButton:Show()
            elseif HealBot_cpOn and HealBot_cpName[xButton.unit] then -- Crash Protection 
                uName=HealBot_cpName[xButton.unit];
                xButton:Show()
            elseif strsub(xButton.unit,1,4)==strsub(HEALBOT_WORD_TEST,1,4) then
                uName=xButton.unit
                xButton:Show()
            end
            if uName then
                i=i+1
                if HeaderPos[i] then
                    h=h+1;
                    header=HeaderPos[i];
                    if HealBot_BottomAnchors then 
                        OffsetY = HealBot_Action_PositionButton(nil,OffsetX,OffsetY,bwidth,bheight,header,curcol); 
                    end
                    if h>cols then
                        if MaxOffsetY<OffsetY then MaxOffsetY = OffsetY; end
                        OffsetY = 4 + HealBot_AggroBarSize;
                        if HealBot_BottomAnchors then 
                            h=2
                        else
                            h=1
                        end
                        OffsetX = OffsetX + bwidth+bcspace; 
                        curcol=curcol+1
                    end
                    if not HealBot_BottomAnchors then OffsetY = HealBot_Action_PositionButton(nil,OffsetX,OffsetY,bwidth,bheight,header,curcol); end
                    OffsetY = HealBot_Action_PositionButton(xButton,OffsetX,OffsetY,bwidth,bheight,nil,curcol);
                else
                    OffsetY = HealBot_Action_PositionButton(xButton,OffsetX,OffsetY,bwidth,bheight,nil,curcol);
                end
            end
        end)
        if HeaderPos[i+1] and HealBot_BottomAnchors then
            header=HeaderPos[i+1];
            OffsetY = HealBot_Action_PositionButton(nil,OffsetX,OffsetY,bwidth,bheight,header,curcol);
        end
        
    elseif Healbot_Config_Skins.GroupsPerCol[Healbot_Config_Skins.Current_Skin]==1 then
        h=0
        table.foreach(HealBot_Action_HealButtons, function (x,xButton)
            if UnitName(xButton.unit) then
                uName=UnitName(xButton.unit);
            elseif Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Current_Skin]==1 and HealBot_UnitName[xButton.guid] then -- Combat Protection 
                uName=HealBot_UnitName[xButton.guid];
                xButton:Show()
            elseif HealBot_cpOn and HealBot_cpName[xButton.unit] then -- Crash Protection 
                uName=HealBot_cpName[xButton.unit];
                xButton:Show()
            elseif strsub(xButton.unit,1,4)==strsub(HEALBOT_WORD_TEST,1,4) then
                uName=xButton.unit
                xButton:Show()
            end
            if uName then
                i=i+1
                if HeaderPos[i] then
                    h=h+1;
                    if h>cols then
                        if MaxOffsetY<OffsetY then MaxOffsetY = OffsetY; end
                        OffsetY = 4 + HealBot_AggroBarSize;
                        OffsetX = OffsetX + bwidth+bcspace; 
                        h=1;
                        curcol=curcol+1
                    end
                end
                OffsetY = HealBot_Action_PositionButton(xButton,OffsetX,OffsetY,bwidth,bheight,nil,curcol);
            end
        end)
    else
        h=1
            tBars=table.getn(HealBot_Action_HealButtons)
            table.foreach(HealBot_Action_HealButtons, function (x,xButton)
            if UnitName(xButton.unit) then
                uName=UnitName(xButton.unit);
            elseif Healbot_Config_Skins.CombatProt[Healbot_Config_Skins.Current_Skin]==1 and HealBot_UnitName[xButton.guid] then -- Combat Protection 
                uName=HealBot_UnitName[xButton.guid];
                xButton:Show()
            elseif HealBot_cpOn and HealBot_cpName[xButton.unit] then -- Crash Protection 
                uName=HealBot_cpName[xButton.unit];
                xButton:Show()
            elseif strsub(xButton.unit,1,4)==strsub(HEALBOT_WORD_TEST,1,4) then
                uName=xButton.unit
                xButton:Show()
            end
            if uName then
                i=i+1
                OffsetY = HealBot_Action_PositionButton(xButton,OffsetX,OffsetY,bwidth,bheight,nil,curcol)
                if h==ceil((tBars)/cols) and z<tBars then
                    h=0;
                    if MaxOffsetY<OffsetY then MaxOffsetY = OffsetY; end
                    OffsetY = 4 + HealBot_AggroBarSize;
                    OffsetX = OffsetX + bwidth+bcspace; 
                    curcol=curcol+1;
                end
        
                z=z+1
                h=h+1;
            end
        end)
    end
     
    for xButton,_ in pairs(HealBot_TrackButtonsH) do
        xButton:Hide();
        HealBot_HeadY[xButton]="0"
        HealBot_TrackButtonsH[xButton]=nil;
    end
    
    for xButton,_ in pairs(HealBot_TrackHButtons) do
        HealBot_TrackButtonsH[xButton]=true;
    end

    if MaxOffsetY<OffsetY then MaxOffsetY = OffsetY; end

    if HealBot_Config.HideOptions==1 then
        HealBot_Action_OptionsButton:Hide();
    else
        HealBot_Action_OptionsButton:ClearAllPoints()
        if Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==2 or Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==4 then
            HealBot_Action_OptionsButton:SetPoint("TOP","HealBot_Action","TOP",0,-10);
            HealBot_Action_OptionsButton:Show();
        else
            HealBot_Action_OptionsButton:SetPoint("BOTTOM","HealBot_Action","BOTTOM",0,10);
            HealBot_Action_OptionsButton:Show();
        end
        MaxOffsetY = MaxOffsetY+30;
    end  
    if hbPanelShowhbFocus and not HealBot_IsFighting and UnitName("target") and UnitName("target") and HealBot_Config.FocusMonitor[UnitName("target")] then
        if UnitName("focus") and HealBot_Config.FocusMonitor[UnitName("focus")] then
            HealBot_Action_hbFocusButton:Hide();
        else
            HealBot_Action_ResetSkin("hbfocus","HealBot_Action_hbFocusButton",curcol)
            HealBot_Action_hbFocusButton:ClearAllPoints()
            if HealBot_Config.HideOptions==0 then
                if Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==2 or Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==4 then
                    HealBot_Action_hbFocusButton:SetPoint("TOP","HealBot_Action","TOP",0,-40);
                    MaxOffsetY = MaxOffsetY+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]+15;
                else
                    HealBot_Action_hbFocusButton:SetPoint("BOTTOM","HealBot_Action","BOTTOM",0,40);
                    MaxOffsetY = MaxOffsetY+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]+15;
                end
            else
                if Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==2 or Healbot_Config_Skins.Bars_Anchor[Healbot_Config_Skins.Current_Skin]==4 then
                    HealBot_Action_hbFocusButton:SetPoint("TOP","HealBot_Action","TOP",0,-10);
                    MaxOffsetY = MaxOffsetY+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]+15;
                else
                    HealBot_Action_hbFocusButton:SetPoint("BOTTOM","HealBot_Action","BOTTOM",0,10);
                    MaxOffsetY = MaxOffsetY+Healbot_Config_Skins.bheight[Healbot_Config_Skins.Current_Skin]+15;
                end
            end
            HealBot_Action_hbFocusButton:Show();
        end
    else
        HealBot_Action_hbFocusButton:Hide();
    end
    if Healbot_Config_Skins.ShowAggroBars[Healbot_Config_Skins.Current_Skin]==0 and 
       Healbot_Config_Skins.HighLightActiveBar[Healbot_Config_Skins.Current_Skin]==0 and 
       Healbot_Config_Skins.HighLightTargetBar[Healbot_Config_Skins.Current_Skin]==0 then
        HealBot_Action_SetHeightWidth(OffsetX, MaxOffsetY+2, bwidth,curcol, i);
    else
        HealBot_Action_SetHeightWidth(OffsetX, (MaxOffsetY+2)-(HealBot_AggroBarSize-2), bwidth,curcol, i);
    end
    
end

function HealBot_Action_RemoveMember(hbGUID, unit)
    if HealBot_GroupGUID[hbGUID] then HealBot_GroupGUID[hbGUID]=nil end
    uName=UnitName(unit) or HealBot_UnitName[hbGUID]
--    if HealBot_UnithbGUID[unit] and HealBot_UnitName[hbGUID]==uName then HealBot_UnithbGUID[unit]=nil end
    if HealBot_unitRole[hbGUID] then HealBot_unitRole[hbGUID]=nil end
    if HealBot_UnitNameGUID[uName] then HealBot_UnitNameGUID[uName]=nil end
    HealBot_setClearLocalArr(hbGUID)
    HealBot_Action_immediateClearLocalArr(hbGUID)
    HealBot_immediateClearLocalArr(hbGUID)
end

function HealBot_RetUnitNameGUIDs(unitName)
    return HealBot_UnitNameGUID[unitName]
end

function HealBot_RetGroupGUIDs(hbGUID)
    if not HealBot_GroupGUID[hbGUID] then 
        z=1
    else
        z=HealBot_GroupGUID[hbGUID]
    end
    y=hbGUID
    for xGUID,group in pairs(HealBot_GroupGUID) do
        if group==z and xGUID~=hbGUID then
            y=y..":"..xGUID
        end
    end
    return y
end

local prevNumBars=-1
function HealBot_retChangeNumBars()
    if prevNumBars~=HealBot_NumPlayerBars then
        prevNumBars=HealBot_NumPlayerBars
        return true
    else
        return nil
    end
end
