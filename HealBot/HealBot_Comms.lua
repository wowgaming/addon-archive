local HealBotAddonMsgType=nil
local tmpttl=0
local HealBotcAddonIncHeals={}
local HealBotcAddonSummary={}
local HealBotcommAddonSummary={}
local HealBotAddonSummaryNoComms={}
local sortorder={}
local AddonName=nil
local AddonEnabled=nil
local hbcommver={}
local hbtmpver={}
local linenum=0
local addon_id=nil
local sender_id=nil
local i,v,x,z=nil,nil,nil,nil
local g=nil
local HBclient=nil
local HB_errtext=nil

function HealBot_Comms_SendAddonMsg(addon_id, msg, aType, pName)
    if aType==1 then
        SendAddonMessage(addon_id, msg, "BATTLEGROUND" );
    elseif aType==2 then
        SendAddonMessage(addon_id, msg, "RAID" );
    elseif aType==3 then
        SendAddonMessage(addon_id, msg, "PARTY" );
    elseif aType==4 and pName then
        SendAddonMessage(addon_id, msg, "WHISPER", pName );
    elseif aType==5 then
        SendAddonMessage(addon_id, msg, "GUILD" );
    end
  --  HealBot_AddDebug("addon msg="..msg)
end

function HealBot_Comms_GetChan(chan)
    if GetChannelName(chan)>0 then
        return GetChannelName(chan);
    else
        return nil;
    end
end

function HealBot_Comms_Info()
    if HealBot_Error:IsVisible() then
        HideUIPanel(HealBot_Error)
        return
    end
    UpdateAddOnCPUUsage()
    UpdateAddOnMemoryUsage()
    HealBotAddonMsgType=HealBot_GetHealBot_AddonMsgType()
    HealBotcAddonSummary=HealBot_RetHealBotAddonSummary()
    HealBotcAddonIncHeals=HealBot_RetHealBotAddonIncHeals()
    hbcommver=HealBot_GetInfo()
    
    for x,_ in pairs(hbtmpver) do
        hbtmpver[x]=nil
    end
    for x,_ in pairs(sortorder) do
        sortorder[x]=nil;
    end
    for z,x in pairs(HealBotcAddonIncHeals) do
        table.insert(sortorder,z)
    end
    table.sort(sortorder,function (a,b)
        if HealBotcAddonIncHeals[a]>HealBotcAddonIncHeals[b] then return true end
        if HealBotcAddonIncHeals[a]<HealBotcAddonIncHeals[b] then return false end
        return a<b
    end)

    linenum=1
    table.foreach(sortorder, function (index,z)
        tmpttl=HealBotcAddonIncHeals[z] or 0
        _,_,addon_id, sender_id = string.find(z, "(.+) : (.+)")
        if linenum<39 and addon_id and sender_id then
            if addon_id==HealBot_IncHeals_retAddonCommsID() then addon_id=hbcommver[sender_id] or "HealBot" end
            if hbcommver[sender_id] then hbtmpver[sender_id]=true end
            HealBot_Comms_Print_IncHealsSum(sender_id,addon_id,tmpttl,linenum)
            linenum=linenum+1
        end
    end)

    for x,v in pairs(hbcommver) do
        if not hbtmpver[x] and linenum<39 then
            HealBot_Comms_Print_IncHealsSum(x,v,0,linenum)
            linenum=linenum+1
        end
    end

    linenum=1
    for x,_ in pairs(HealBotAddonSummaryNoComms) do
        HealBotAddonSummaryNoComms[x]=nil;
    end
    for x,_ in pairs(sortorder) do
        sortorder[x]=nil;
    end
    for i=1, GetNumAddOns() do
        AddonName,_,_,AddonEnabled = GetAddOnInfo(i);
        if AddonEnabled and not HealBotAddonSummaryNoComms[AddonName] and GetAddOnCPUUsage(i)>100 then
            HealBotAddonSummaryNoComms[AddonName]=HealBot_Comm_round(GetAddOnCPUUsage(AddonName)/1000, 1)
            table.insert(sortorder,AddonName)
        end
    end
    table.sort(sortorder,function (a,b)
        if HealBotAddonSummaryNoComms[a]>HealBotAddonSummaryNoComms[b] then return true end
        if HealBotAddonSummaryNoComms[a]<HealBotAddonSummaryNoComms[b] then return false end
        return a<b
    end)
    table.foreach(sortorder, function (index,z)
        if linenum<39 and HealBotAddonSummaryNoComms[z]>0.4 then 
            HealBot_Comms_Print_AddonCPUSum(z,HealBotAddonSummaryNoComms[z],floor(GetAddOnMemoryUsage(z)),linenum)
            linenum=linenum+1
        end
    end)
    linenum=1
    for x,_ in pairs(sortorder) do
        sortorder[x]=nil;
    end
    for x,_ in pairs(HealBotcommAddonSummary) do
        HealBotcommAddonSummary[x]=nil;
    end
    for z,x in pairs(HealBotcAddonSummary) do
        HealBotcommAddonSummary[z]=HealBot_Comm_round(x/1024,2)
    end
    for z,x in pairs(HealBotcommAddonSummary) do
        table.insert(sortorder,z)
    end
    table.sort(sortorder,function (a,b)
        if HealBotcommAddonSummary[a]>HealBotcommAddonSummary[b] then return true end
        if HealBotcommAddonSummary[a]<HealBotcommAddonSummary[b] then return false end
        return a<b
    end)
    table.foreach(sortorder, function (index,z)
        if linenum<39 and HealBotcommAddonSummary[z]>0.04 then 
            HealBot_Comms_Print_AddonCommsSum(z,HealBotcommAddonSummary[z],linenum)
            linenum=linenum+1
        end
    end)
    ShowUIPanel(HealBot_Error)
end

function HealBot_Comms_Print_IncHealsSum(sender_id,addon_id,HealsCnt,linenum)
    g=_G["HBIncH"..linenum.."Healer"]
    g:SetText(sender_id);
    g=_G["HBIncH"..linenum.."Ver"]
    g:SetText(addon_id);
    g=_G["HBIncH"..linenum.."Cnt"]
    g:SetText(ceil(HealsCnt));
end

function HealBot_Comms_Print_AddonCPUSum(Addon,CPU,MEM,linenum)
    g=_G["HBMod"..linenum.."Name1"]
    g:SetText(Addon);
    g=_G["HBMod"..linenum.."CPU"]
    g:SetText(CPU);
    g=_G["HBMod"..linenum.."Mem"]
    g:SetText(MEM);
end

function HealBot_Comms_Print_AddonCommsSum(Addon,Comms,linenum)
    g=_G["HBMod"..linenum.."Name2"]
    g:SetText(Addon);
    g=_G["HBMod"..linenum.."Comm"]
    g:SetText(Comms);
end

function HealBot_Comms_TargetInfo()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID.."  UnitHealth="..UnitHealth("target").."   UnitHealthMax="..UnitHealthMax("target"))
    HealBot_AddChat(HEALBOT_CHAT_ADDONID.."  UnitMana="..UnitMana("target").."   UnitManaMax="..UnitManaMax("target"))
end

function HealBot_Comms_Zone()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Zone="..GetRealZoneText())
    if HealBotAddonMsgType==1 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=BATTLEGROUND")
    elseif HealBotAddonMsgType==2 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=RAID")
    elseif HealBotAddonMsgType==3 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=PARTY")
    elseif HealBotAddonMsgType==4 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=WHISPER")
    end
    HealBot_AddChat(HEALBOT_CHAT_ADDONID.."#Raid="..GetNumRaidMembers().."   #Party="..GetNumPartyMembers())
end

local mult = 0
function HealBot_Comm_round(num, idp)
    mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

local HealBot_MsgUpdateAvail=nil
local hbMajor, hbMinor, hbPatch, hbHealbot = string.split(".", HEALBOT_VERSION)
local tMajor, tMinor, tPatch, tHealbot = 0,0,0,0
local hbVersionChecked = {}
local tNewVer=nil
function HealBot_Comms_CheckVer(userName, version)
    if not hbVersionChecked[userName] then
        tNewVer=nil
        hbVersionChecked[userName]=true
        tMajor, tMinor, tPatch, tHealbot = string.split(".", version)
        if tonumber(tMajor)>tonumber(hbMajor) then 
            tNewVer=true
        elseif tonumber(tMajor)==tonumber(hbMajor) and tonumber(tMinor)>tonumber(hbMinor) then 
            tNewVer=true
        elseif tonumber(tMajor)==tonumber(hbMajor) and tonumber(tMinor)==tonumber(hbMinor) and tonumber(tPatch)>tonumber(hbPatch) then 
            tNewVer=true
        elseif tonumber(tMajor)==tonumber(hbMajor) and tonumber(tMinor)==tonumber(hbMinor) and tonumber(tPatch)==tonumber(hbPatch) and tonumber(tHealbot)>tonumber(hbHealbot) then 
            tNewVer=true
        end
        if tonumber(tMajor)>=3 and tonumber(tMinor)>=3 then HealBot_Options_sethbOptCompatUsers(userName, version) end
        if tNewVer then
            hbMajor=tMajor
            hbMinor=tMinor
            hbPatch=tPatch
            hbHealbot=tHealbot
            if not HealBot_MsgUpdateAvail then
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_NEWVERSION1)
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_NEWVERSION2)
            end
            HealBot_MsgUpdateAvail = hbMajor.."."..hbMinor.."."..hbPatch.."."..hbHealbot
        end
        HealBot_setOptions_Timer(190)
        HealBot_IncHeals_sethbUsers()
    end
end

function HealBot_Comms_ReportVer()
    return HealBot_MsgUpdateAvail
end

function HealBot_Comms_OnShow(self)
    HealBot_Error_Clientx:SetText(HEALBOT_WORD_CLIENT.."="..GetLocale())
    HealBot_Error_Versionx:SetText(HEALBOT_WORD_VERSION.."="..HEALBOT_VERSION)
    HealBot_Error_Classx:SetText(HEALBOT_SORTBY_CLASS.."="..HealBot_PlayerClassEN)
    if HealBot_Config.AcceptSkins==1 then
        HealBot_Info_AcceptSkinsVal:SetText("ON")
        HealBot_Info_AcceptSkinsVal:SetTextColor(0.1,1,0.1)
    else
        HealBot_Info_AcceptSkinsVal:SetText("OFF")
        HealBot_Info_AcceptSkinsVal:SetTextColor(0.88,0.1,0.1)
    end
    if HealBot_Config.MacroSuppressError==1 then
        HealBot_Info_SuppressErrorsVal:SetText("ON")
        HealBot_Info_SuppressErrorsVal:SetTextColor(0.1,1,0.1)
    else
        HealBot_Info_SuppressErrorsVal:SetText("OFF")
        HealBot_Info_SuppressErrorsVal:SetTextColor(0.88,0.1,0.1)
    end
    if HealBot_Config.MacroSuppressSound==1 then
        HealBot_Info_SuppressSoundsVal:SetText("ON")
        HealBot_Info_SuppressSoundsVal:SetTextColor(0.1,1,0.1)
    else
        HealBot_Info_SuppressSoundsVal:SetText("OFF")
        HealBot_Info_SuppressSoundsVal:SetTextColor(0.88,0.1,0.1)
    end
end

function HealBot_Comms_OnHide(self)
    HealBot_StopMoving(self);
end

function HealBot_Comms_OnDragStart(self)
    HealBot_StartMoving(self);
end

function HealBot_Comms_OnDragStop(self)
    HealBot_StopMoving(self);
end

function HealBot_ErrorsIn(msg,id)
    HB_errtext = _G["HealBot_Error"..id];
    HB_errtext:SetText(msg)
    if not HealBot_Error:IsVisible() then 
        ShowUIPanel(HealBot_Error)
    end
end



  