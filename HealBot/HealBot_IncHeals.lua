local hbHealsIn={}
local hbHoThealsIn={}
local v, w, x, y, z=nil, nil, nil, nil, nil
local i, j, k, l=0, 0, 0
local r, s, t=nil, nil, nil
local hbUID=0
local hbCommsID = nil
local hbCommsUsers = {}
local hbUsers = {}
local hbLHC4 = {}
local HealComm = LibStub("LibHealComm-4.0", true)
local hbCin, hbDin, hbHin = 0, 0, 0
local utGUID=nil
local hbAcceptList=false
local hbIncHealsCommID="hbComms"
local hbArg1, hbArg2, hbArg3, hbSecNo, tSecNo = nil, nil, nil, 73, 0
local hbGUIDlist, hbTempGUID, hbCasterName = nil,nil,nil
local hbPermGUIDsecNo={}
local hbPermGUIDsecNor={}
local hbPermGUIDsecNot={}
local hbTempGUIDsecNo={}
local hbSugGUIDsecNo={}
local hbAccGUIDsecNo={}
local hbAccGUIDcount={}
local hbShinkWrapGUID={}
local hbShinkWrapGUIDr={}
local hbCasterUnit={}
local hbCasterHealValues={}
local hbSpellValue=0
local hbAddonMsgType=3;
local sName, endTime = nil, nil
local hbCommsActive=false
local hbNumCommsUsers=1
local scGUID,sctGUID=nil,nil
local hbHealValues={}
local hbHealTarget={}
local hbLastCast={}
local HealBot_TitanID=false
local HealBot_TitanCalled=false
local hbSuperCommGUIDs,hbSpellID,sGUID=nil,nil,nil
local hbFixedSpells = { ["a"]=HEALBOT_HOLY_LIGHT,
                        ["b"]=HEALBOT_FLASH_OF_LIGHT,
                        ["c"]=HEALBOT_HEALING_TOUCH,
                        ["d"]=HEALBOT_NOURISH,
                        ["e"]=HEALBOT_REGROWTH,
                        ["f"]=HEALBOT_LESSER_HEAL,
                        ["g"]=HEALBOT_HEAL,
                        ["h"]=HEALBOT_GREATER_HEAL,
                        ["i"]=HEALBOT_BINDING_HEAL,
                        ["j"]=HEALBOT_PRAYER_OF_HEALING,
                        ["k"]=HEALBOT_FLASH_HEAL,
                        ["l"]=HEALBOT_HEALING_WAVE,
                        ["m"]=HEALBOT_LESSER_HEALING_WAVE,
                        ["n"]=HEALBOT_CHAIN_HEAL,
                        ["o"]=HEALBOT_RENEW,
                        ["p"]="H"..HEALBOT_REGROWTH,
                        ["q"]=HEALBOT_REJUVENATION,
                        ["r"]=HEALBOT_LIFEBLOOM,
                        ["s"]=HEALBOT_WILD_GROWTH,
                        ["t"]=HEALBOT_RIPTIDE,
                      }

function HealBot_IncHeals_retHealsIn(hbGUID, spellType)
    if spellType then
        if spellType=="H" then
            x=hbHoThealsIn[hbGUID] or 0
            y=0
        else
            x=0
            y=hbHealsIn[hbGUID] or 0
        end
    else
        x=hbHoThealsIn[hbGUID] or 0
        y=hbHealsIn[hbGUID] or 0
    end
    z=x+y
    return z
end

function HealBot_IncHeals_retAddonCommsID()
    return hbIncHealsCommID
end

function HealBot_IncHeals_statusChanged()
    if HealBot_Config.HealCommMethod>3 then
        HealBot_IncHeals_Comms(hbIncHealsCommID, "V", hbAddonMsgType, HealBot_PlayerName, nil, true)
        HealBot_OnEvent_PlayerEquipmentChanged(nil,HealBot_PlayerName)
    else
        HealBot_IncHeals_Comms(hbIncHealsCommID, "N", hbAddonMsgType, HealBot_PlayerName, nil, true)
    end
end

function HealBot_IncHeals_sethbCommsUsers(unitName)
    xGUID=HealBot_Derive_GUID_fuName(unitName)
    if xGUID then hbCommsUsers[xGUID]=unitName end
    x=0
    for z,_ in pairs(hbCommsUsers) do
        x=x+1
    end
    hbNumCommsUsers=x
    HealBot_IncHeals_sethbCommsActive()
end

function HealBot_IncHeals_removehbCommsUsers(unitName)
    xGUID=HealBot_Derive_GUID_fuName(unitName)
    if xGUID and hbCommsUsers[xGUID] then hbCommsUsers[xGUID]=nil end
    x=0
    for z,_ in pairs(hbCommsUsers) do
        x=x+1
    end
    hbNumCommsUsers=x
    HealBot_IncHeals_sethbCommsActive()
end

function HealBot_IncHeals_sethbUsers()
    hbUsers=HealBot_GetInfo()
end

function HealBot_IncHeals_rethbCommsUsers()
    return hbCommsUsers
end

function HealBot_IncHeals_sethbAddonMsgType(msgType)
    hbAddonMsgType=msgType
    HealBot_IncHeals_sethbCommsActive()
end

local prevCommsActive=false
function HealBot_IncHeals_sethbCommsActive()
    if hbAddonMsgType<4 and hbNumCommsUsers>1 and HealBot_Config.HealCommMethod>3 then
        hbCommsActive=true
        if not prevCommsActive then
            HealBot_IncHeals_resetMyTabs()
        end
    else
        hbCommsActive=false
    end
    prevCommsActive=hbCommsActive
end

function HealBot_IncHeals_CommHealsInCheck(sGUID, value, spellName, casterName, unit, hbGUID)
    if sGUID then
        for l=1,string.len(sGUID) do
            sctGUID=strsub(sGUID,l,l)
            xGUID=HealBot_IncHeals_SuperCommGUIDtoGUID(sctGUID)
            if xGUID and HealBot_UnitID[xGUID] then
                HealBot_IncHeals_CommHealsInUpdate(xGUID, value, spellName, casterName, unit)
            end
        end
    elseif hbGUID and HealBot_UnitID[hbGUID] then
        HealBot_IncHeals_CommHealsInUpdate(hbGUID, value, spellName, casterName, unit)
    end
end

function HealBot_IncHeals_CommHealsInUpdate(hbGUID, value, spellName, casterName, unit)
    if not hbHealsIn[hbGUID] then hbHealsIn[hbGUID]=0 end
    hbHealsIn[hbGUID]=hbHealsIn[hbGUID]+value
 --   HealBot_AddDebug("IncHeals Value="..value.."  hbHealsIn="..hbHealsIn[hbGUID])
    if hbHealsIn[hbGUID]<0 then hbHealsIn[hbGUID]=0 end
    if HealBot_TitanID then TitanPanelButton_UpdateButton(HealBot_TitanID) end
    if value>0 then
        HealBot_IncHeals_CommCastingEndTime(spellName, unit, hbGUID, casterName)
        HealBot_RecalcHeals(hbGUID)
    else
        if hbHealsIn[hbGUID]==0 then hbHealsIn[hbGUID]=nil end
        if HealBot_Config.EnLibQuickHealth==1 then
            if HealBot_UnitID[hbGUID] then HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID]) end
        else
            HealBot_setDelayResetUnitStatus(hbGUID)
        end
    end
end

function HealBot_IncHeals_ExtraHealsInUpdate(hbGUID, casterGUID, spellType)
    if not HealBot_UnitID[hbGUID] then return end
    if not hbHealsIn[hbGUID] then hbHealsIn[hbGUID]=0 end
    i=hbHealsIn[hbGUID]
    if Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["C"]>0 then 
        hbCin=HealComm:GetHealAmount(hbGUID, HealComm.CHANNEL_HEALS, GetTime() + Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["C"], casterGUID) or 0
    else
        hbCin=0
    end
    if Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["D"]>0 then 
        hbDin=HealComm:GetHealAmount(hbGUID, HealComm.DIRECT_HEALS, GetTime() + Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["D"], casterGUID) or 0
    else
        hbDin=0
    end
    if Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["H"]>0 then 
        hbHin=HealComm:GetHealAmount(hbGUID, HealComm.HOT_HEALS, GetTime() + Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["H"], casterGUID) or 0
    else
        hbHin=0
    end
    y=ceil(hbCin+hbDin+hbHin)
    
    if hbHealValues[casterGUID] then 
        y=y-hbHealValues[casterGUID]
    elseif casterGUID then
        hbHealValues[casterGUID]=y
    end

    hbHealsIn[hbGUID]=hbHealsIn[hbGUID]+y
    if hbHealsIn[hbGUID]<0 then hbHealsIn[hbGUID]=0 end
    if i~=hbHealsIn[hbGUID] then 
        if hbHealsIn[hbGUID]>0 then
            HealBot_RecalcHeals(hbGUID)
        elseif HealBot_Config.EnLibQuickHealth==1  or spellType~=HealComm.DIRECT_HEALS then
            HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID])
        else
            HealBot_setDelayResetUnitStatus(hbGUID)
        end
        if HealBot_TitanID then TitanPanelButton_UpdateButton(HealBot_TitanID) end
    end
    
    if hbHealsIn[hbGUID]==0 then
        hbHealsIn[hbGUID]=nil
        if casterGUID then hbHealValues[casterGUID]=nil end
    elseif y<=0 then
        if casterGUID then hbHealValues[casterGUID]=nil end
    end
end

function HealBot_IncHeals_HealsInUpdate(hbGUID, spellType)
    if not HealBot_UnitID[hbGUID] then return end
    i=hbHealsIn[hbGUID] or 0
    if Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["C"]>0 then 
        hbCin=HealComm:GetHealAmount(hbGUID, HealComm.CHANNEL_HEALS, GetTime() + Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["C"]) or 0
    else
        hbCin=0
    end
    if Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["D"]>0 then 
        hbDin=HealComm:GetHealAmount(hbGUID, HealComm.DIRECT_HEALS, GetTime() + Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["D"]) or 0
    else
        hbDin=0
    end
    if Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["H"]>0 then 
        hbHin=HealComm:GetHealAmount(hbGUID, HealComm.HOT_HEALS, GetTime() + Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["H"]) or 0
    else
        hbHin=0
    end
    y=ceil(hbCin+hbDin+hbHin)
    if y==0 then
        hbHealsIn[hbGUID]=nil
    else
        hbHealsIn[hbGUID]=y
    end
    if i~=(hbHealsIn[hbGUID] or 0) then
        if hbHealsIn[hbGUID] then
            HealBot_RecalcHeals(hbGUID)
        elseif HealBot_Config.EnLibQuickHealth==1 or spellType~=HealComm.DIRECT_HEALS then
            HealBot_Action_ResetUnitStatus(HealBot_UnitID[hbGUID])
        else
            HealBot_setDelayResetUnitStatus(hbGUID)
        end
        if HealBot_TitanID then TitanPanelButton_UpdateButton(HealBot_TitanID) end
    end
end

function HealBot_IncHeals_CommHoThealsInUpdate(sGUID, value, spellName, casterName, unit)
    for l=1,string.len(sGUID) do
        sctGUID=strsub(sGUID,l,l)
        xGUID=HealBot_IncHeals_SuperCommGUIDtoGUID(sctGUID)
        if xGUID and HealBot_UnitID[xGUID] then
            hbUID=hbUID+1
            HealBot_HoT_incHealsStart(xGUID, hbUID, spellName, unit, value)
        end
    end
end

function HealBot_IncHeals_CommCastingEndTime(spellName, unit, hbGUID, casterName)
    sName, _, _, _, _, endTime, _, _, _ = UnitCastingInfo(unit)
    if sName~=spellName then endTime=HealBot_spellEndTimes(spellName) end
    HealBot_setHealsIncEndTime(hbGUID, casterName, endTime)
    hbLastCast[hbGUID]=endTime
end

local hbHoThealsInCaster={}
function HealBot_IncHeals_CommHoTtickUpdate(hbGUID, value, hbUID)
    if HealBot_UnitID[hbGUID] then
        if not hbHoThealsIn[hbGUID] then hbHoThealsIn[hbGUID]=0 end
        i=hbHoThealsIn[hbGUID]
        if not hbHoThealsInCaster[hbUID] then 
            hbHoThealsInCaster[hbUID]=value 
        else
            hbHoThealsIn[hbGUID]=hbHoThealsIn[hbGUID]-hbHoThealsInCaster[hbUID]
        end
        hbHoThealsIn[hbGUID]=hbHoThealsIn[hbGUID]+value
        if value==0 then
            hbHoThealsInCaster[hbUID]=nil
        else
            hbHoThealsInCaster[hbUID]=value
        end
        if hbHoThealsIn[hbGUID]<0 then hbHoThealsIn[hbGUID]=0 end
        if i~=(hbHoThealsIn[hbGUID]) then 
            HealBot_RecalcHeals(hbGUID) 
            if HealBot_TitanID then TitanPanelButton_UpdateButton(HealBot_TitanID) end
        end
        if hbHoThealsIn[hbGUID]==0 then hbHoThealsIn[hbGUID]=nil end
    end
end

function HealBot_IncHeals_parseHBincHeals(spellName, hbGUIDs, status, endTime, internal)
    if not hbGUIDs then return end
    hbSuperCommGUIDs=nil
    if strfind(hbGUIDs,":") then 
        utGUID = HealBot_Split(hbGUIDs, ":"); 
        table.foreach(utGUID, function (index,xGUID)
            sctGUID=HealBot_IncHeals_GUIDtoSuperCommGUID(xGUID, status)
            if sctGUID then
                if hbSuperCommGUIDs then
                    hbSuperCommGUIDs=hbSuperCommGUIDs..sctGUID
                else
                    hbSuperCommGUIDs=sctGUID
                end
                if status=="D" then 
                    HealBot_setHealsIncEndTime(xGUID, HealBot_PlayerName, endTime) 
                    hbLastCast[xGUID]=endTime
                end
            end
        end)
    else
        sctGUID=HealBot_IncHeals_GUIDtoSuperCommGUID(hbGUIDs, status)
        if sctGUID then 
            hbSuperCommGUIDs=sctGUID 
            if status=="D" then 
                HealBot_setHealsIncEndTime(hbGUIDs, HealBot_PlayerName, endTime) 
                hbLastCast[hbGUIDs]=endTime
            end
        end
    end
    hbSpellID=HealBot_IncHeals_hbFixedSpells(spellName)
    if hbSuperCommGUIDs and hbSpellID then
        if status~="E" then
            HealBot_IncHeals_Comms(hbIncHealsCommID, status..":"..hbSpellID..":"..hbSuperCommGUIDs, hbAddonMsgType, HealBot_PlayerName, internal, nil)
            if not internal then HealBot_IncHeals_Comms(hbIncHealsCommID, status..":"..hbSpellID..":"..hbSuperCommGUIDs, hbAddonMsgType, HealBot_PlayerName, true, nil) end
        else
            HealBot_IncHeals_Comms(hbIncHealsCommID, status..":"..hbSuperCommGUIDs, hbAddonMsgType, HealBot_PlayerName, internal, nil)
            if not internal then HealBot_IncHeals_Comms(hbIncHealsCommID, status..":"..hbSuperCommGUIDs, hbAddonMsgType, HealBot_PlayerName, true, nil) end
        end
    else
        HealBot_AddDebug("hbSuperCommGUIDs and/or hbSpellID is nil")
    end        
end

local hbCacheSpells={}
function HealBot_IncHeals_hbFixedSpells(spellName)
    if hbCacheSpells[spellName] then
        z=hbCacheSpells[spellName]
    else
        z=nil
        for x,y in pairs(hbFixedSpells) do
            if y==spellName then
                z=x;
                hbCacheSpells[spellName]=x
                do break end
            end
        end
    end
    return z
end

function HealBot_IncHeals_PartyChange()
    hbAcceptList=false
end

function HealBot_IncHeals_SuperCommGUIDtoGUID(scGUID)
    if hbPermGUIDsecNor[scGUID] then
        return hbPermGUIDsecNor[scGUID]
    else
        for x,y in pairs(hbAccGUIDsecNo) do
            if y==scGUID then
                do break end
            end
        end
    end
    return hbAccGUIDsecNo[x]
end

function HealBot_IncHeals_GUIDtoSuperCommGUID(hbGUID, status)
    scGUID=nil
    if hbPermGUIDsecNo[hbGUID] then
        if not hbTempGUIDsecNo[hbGUID] and status~="E" then
            HealBot_IncHeals_Comms(hbIncHealsCommID, "C:"..HealBot_IncHeals_shrinkGUID(hbGUID)..":"..hbPermGUIDsecNo[hbGUID], hbAddonMsgType, HealBot_PlayerName, nil, nil)
            hbTempGUIDsecNo[hbGUID]=hbPermGUIDsecNo[hbGUID]
        end
        scGUID=hbPermGUIDsecNo[hbGUID]
    elseif hbAccGUIDsecNo[hbGUID] then
        if status~="E" then
            if hbAccGUIDcount[hbGUID] then
                hbAccGUIDcount[hbGUID]=hbAccGUIDcount[hbGUID]+1
            else
                hbAccGUIDcount[hbGUID]=1
            end
            if hbAccGUIDcount[hbGUID]>3 then
                HealBot_IncHeals_Comms(hbIncHealsCommID, "C:"..HealBot_IncHeals_shrinkGUID(hbGUID)..":"..hbAccGUIDsecNo[hbGUID], hbAddonMsgType, HealBot_PlayerName, nil, nil)
                hbAccGUIDcount[hbGUID]=nil
            end
        end
        scGUID=hbAccGUIDsecNo[hbGUID]
    elseif status~="E" then
        if hbCommsActive then
            if not hbSugGUIDsecNo[hbGUID] then 
                tSecNo=HealBot_IncHeals_deriveSuperGUID(hbGUID)
                if tSecNo then
                    hbSugGUIDsecNo[hbGUID]=tSecNo
                    HealBot_IncHeals_Comms(hbIncHealsCommID, "S:"..HealBot_IncHeals_shrinkGUID(hbGUID)..":"..hbSugGUIDsecNo[hbGUID], hbAddonMsgType, HealBot_PlayerName, nil, nil)
                else
                    HealBot_AddDebug("secNo not found in GUIDtoSuperCommGUID - CommsActive")
                end
            else
                hbSugGUIDsecNo[hbGUID]=nil
            end
        else
            tSecNo=HealBot_IncHeals_deriveSuperGUID(hbGUID)
            if tSecNo then
                hbPermGUIDsecNo[hbGUID]=tSecNo
                hbPermGUIDsecNor[tSecNo]=hbGUID
                hbPermGUIDsecNot[hbGUID]=GetTime()
                hbTempGUIDsecNo[hbGUID]=hbPermGUIDsecNo[hbGUID]
                scGUID=hbPermGUIDsecNo[hbGUID]
            else
                HealBot_AddDebug("secNo not found in GUIDtoSuperCommGUID")
            end
        end
    end
    return scGUID
end

function HealBot_IncHeals_shrinkGUID(hbGUID, shGUID)
    s=nil
    if hbGUID then
        if hbShinkWrapGUIDr[hbGUID] then
            s=hbShinkWrapGUIDr[hbGUID]
        else
            if HealBot_retPetGUID(hbGUID) then
                xUnit=HealBot_retPetGUID(hbGUID)
            elseif HealBot_UnitID[hbGUID] then
                xUnit=HealBot_UnitID[hbGUID]
            else
                xUnit=HealBot_RaidUnit("unknown",hbGUID)
            end
            xGUID=UnitGUID(xUnit)
            r=strsub(xGUID,5,5)
            if r=="0" then
                s=r..strsub(xGUID,13)
            else
                s=r..strsub(xGUID,6,12)
            end
            hbShinkWrapGUID[s]=hbGUID
            hbShinkWrapGUIDr[hbGUID]=s
        end
    elseif shGUID then
        if hbShinkWrapGUID[shGUID] then
            s=hbShinkWrapGUID[shGUID]
        else
            r=strsub(shGUID,1,1)
            t=strsub(shGUID,2)
            if GetNumRaidMembers()>0 then
                for j=1,40 do
                    if r=="0" then
                        xGUID=UnitGUID("raid"..j)
                        if xGUID then
                            if t==strsub(xGUID,13) then
                                s=xGUID
                                do break end
                            end
                        end
                    elseif r=="4" then
                        xGUID=UnitGUID("raidpet"..j)
                        if xGUID then
                            if t==strsub(xGUID,6,12) then
                                s=HealBot_retPetGUID(xGUID)
                                do break end
                            end
                        end
                    end
                end
            elseif GetNumPartyMembers()>0 then
                for j=1,4 do
                    if r=="0" then
                        xGUID=UnitGUID("party"..j)
                        if xGUID then
                            if t==strsub(xGUID,13) then
                                s=xGUID
                                do break end
                            end
                        end
                    elseif r=="4" then
                        xGUID=UnitGUID("partypet"..j)
                        if xGUID then
                            if t==strsub(xGUID,6,12) then
                                s=HealBot_retPetGUID(xGUID)
                                do break end
                            end
                        end
                    end
                end
            elseif r==strsub(HealBot_PlayerGUID,5,5) and t==strsub(HealBot_PlayerGUID,13) then
                s=HealBot_PlayerGUID
            elseif UnitExists("focus") and r==strsub(UnitGUID("focus"),5,5) and r=="0" and t==strsub(UnitGUID("focus"),13) then
                s=UnitGUID("focus")
            elseif UnitExists("focus") and r==strsub(UnitGUID("focus"),5,5) and r=="4" and t==strsub(UnitGUID("focus"),6,12) then
                s=HealBot_retPetGUID(UnitGUID("focus"))
            elseif UnitExists("focus") and r==strsub(UnitGUID("focus"),5,5) and t==strsub(UnitGUID("focus"),6,12) then
                s=UnitGUID("focus")
            elseif UnitExists("target") and r==strsub(UnitGUID("target"),5,5) and r=="0" and t==strsub(UnitGUID("target"),13) then  
                s=UnitGUID("target")
            elseif UnitExists("target") and r==strsub(UnitGUID("target"),5,5) and r=="4" and t==strsub(UnitGUID("target"),6,12) then   
                s=HealBot_retPetGUID(UnitGUID("target"))
            elseif UnitExists("target") and r==strsub(UnitGUID("target"),5,5) and t==strsub(UnitGUID("target"),6,12) then  
                s=UnitGUID("target")
            end
            hbShinkWrapGUID[shGUID]=s
        end
    end
    return s
end

function HealBot_IncHeals_deriveSuperGUID(hbGUID)
    xUnit=HealBot_UnitID[hbGUID] or HealBot_RaidUnit("unknown",hbGUID)
    tSecNo=nil
    if xUnit then
        if strsub(xUnit,1,4)=="raid" then
            if strsub(xUnit,1,7)=="raidpet" then
                v=tonumber(strsub(xUnit,8))+80
            else
                v=tonumber(strsub(xUnit,5))+40
            end
        elseif HealBot_UnitName[hbGUID] then
            z=string.byte(HealBot_UnitName[hbGUID],2) or 80
            w=string.byte(HealBot_UnitName[hbGUID],1) or 50 
            w=ceil(w/10)
            v=z+w
        else
            v=HealBot_IncHeals_incSecNo()
        end
        tSecNo=HealBot_IncHeals_SuperGUIDincSecNo(v)
     --   if tSecNo then HealBot_AddDebug("deriveSuperGUID set to "..tSecNo.." for "..xUnit) end
    end
    return tSecNo
end

function HealBot_IncHeals_incSecNo()
    if hbSecNo>=122 then hbSecNo=34 end
    hbSecNo=hbSecNo+1
    return hbSecNo
end

function HealBot_IncHeals_SuperGUIDincSecNo(secNo)
    w=nil
    for k=1,70 do
        if secNo>=122 then secNo=34 end
        secNo=secNo+1
        z=string.char(secNo)
        if not hbPermGUIDsecNor[z] then
            w=z
            do break end
        end
    end
    return w
end

function HealBot_IncHeals_clearSuperGUID(hbGUID, getTime)
    if not hbPermGUIDsecNot[hbGUID] then hbPermGUIDsecNot[hbGUID]=GetTime()-5000 end
    if hbPermGUIDsecNot[hbGUID]<getTime then
        hbPermGUIDsecNot[hbGUID]=nil
        if hbPermGUIDsecNo[hbGUID] then hbPermGUIDsecNo[hbGUID]=nil end
        if hbTempGUIDsecNo[hbGUID] then hbTempGUIDsecNo[hbGUID]=nil end
        if hbSugGUIDsecNo[hbGUID] then hbSugGUIDsecNo[hbGUID]=nil end
        if hbAccGUIDsecNo[hbGUID] then hbAccGUIDsecNo[hbGUID]=nil end
        if hbAccGUIDcount[hbGUID] then hbAccGUIDcount[hbGUID]=nil end
        if hbShinkWrapGUIDr[hbGUID] then hbShinkWrapGUIDr[hbGUID]=nil end
        for x,y in pairs(hbPermGUIDsecNor) do
            if y==hbGUID then 
                hbPermGUIDsecNor[x]=nil
                do break end
            end
        end
        for x,y in pairs(hbShinkWrapGUID) do
            if y==hbGUID then 
                hbShinkWrapGUID[x]=nil
                do break end
            end
        end
    end
end

local hbHealVal=UnitLevel("player")*50
function HealBot_IncHeals_Msg(hbMsg, casterName, internal)
    hbArg1, hbArg2, hbArg3 = string.split(":", hbMsg)
  -- HealBot_AddDebug("IncHeals_Msg msg="..hbMsg)
    if hbArg1=="D" then
        if (casterName~=HealBot_PlayerName) or internal then
            sName=hbFixedSpells[hbArg2]
            hbSpellValue=hbHealVal
            if not hbCasterHealValues[casterName] then hbCasterHealValues[casterName]={} end
            if not hbCasterHealValues[casterName][sName] then
                if hbCasterHealValues[sName] then hbSpellValue=hbCasterHealValues[sName] end
                HealBot_IncHeals_Comms(hbIncHealsCommID, "X:"..hbArg2, 4, casterName, nil, nil)
            else
                hbSpellValue=hbCasterHealValues[casterName][sName]
            end
            hbCommsID=hbIncHealsCommID.." : "..casterName
            HealBot_addHealBotAddonIncHeals(hbCommsID)
            xUnit=HealBot_RaidUnit(hbCasterUnit[casterName],nil,casterName)
            if xUnit then
               -- if hbHealValues[casterName] and hbHealTarget[casterName] then
               --     HealBot_IncHeals_CommHealsInCheck(hbHealTarget[casterName], 0-hbHealValues[casterName])
               -- end
                HealBot_IncHeals_CommHealsInCheck(hbArg3, hbSpellValue, sName, casterName, xUnit)
                hbHealValues[casterName]=hbSpellValue
                hbCasterUnit[casterName]=xUnit
              --  hbHealTarget[casterName]=hbArg3
            end
        end
    elseif hbArg1=="H" then
        if (casterName~=HealBot_PlayerName) or internal then
            sName=hbFixedSpells[hbArg2]
            hbSpellValue=hbHealVal
            if not hbCasterHealValues[casterName] then hbCasterHealValues[casterName]={} end
            if not hbCasterHealValues[casterName][sName] then
                if hbCasterHealValues[sName] then hbSpellValue=hbCasterHealValues[sName] end
                HealBot_IncHeals_Comms(hbIncHealsCommID, "X:"..hbArg2, 4, casterName, nil, nil)
            else
                hbSpellValue=hbCasterHealValues[casterName][sName]
            end
            if Healbot_Config_Skins.incHealDur[Healbot_Config_Skins.Current_Skin]["H"]>0 then
                xUnit=HealBot_RaidUnit(hbCasterUnit[casterName],nil,casterName)
                if xUnit then
                    HealBot_IncHeals_CommHoThealsInUpdate(hbArg3, hbSpellValue, sName, casterName, xUnit)
                    hbCasterUnit[casterName]=xUnit
                end
            end
        end
    elseif hbArg1=="E" then
        if hbHealValues[casterName] then
            if (casterName~=HealBot_PlayerName) or internal then
                HealBot_IncHeals_CommHealsInCheck(hbArg2, 0-hbHealValues[casterName])
                hbHealValues[casterName]=nil
            end
        end
    elseif hbArg1=="I" then
        if casterName~=HealBot_PlayerName then
            x=0
            for z,_ in pairs(hbTempGUIDsecNo) do
                x=x+1
            end
            if GetNumRaidMembers()>0 and x>ceil(GetNumRaidMembers()/2) then
                hbSuperCommGUIDs=nil
                for k=1,40 do
                    xUnit = "raid"..k
                    xGUID=UnitGUID(xUnit)
                    if not xGUID then
                        do break end
                    end
                    if hbPermGUIDsecNo[xGUID] then
                        y=hbPermGUIDsecNo[xGUID]
                    else
                        y="!"
                    end
                    if hbSuperCommGUIDs then
                        hbSuperCommGUIDs=hbSuperCommGUIDs..y
                    else
                        hbSuperCommGUIDs=y
                    end
                end
                HealBot_IncHeals_Comms(hbIncHealsCommID, "L:"..hbSuperCommGUIDs, 4, casterName, nil, nil)    
            else
                for x,_ in pairs(hbTempGUIDsecNo) do
                    hbTempGUIDsecNo[x]=nil;
                end
            end
        end
    elseif hbArg1=="L" then
        if hbAcceptList then
            for k=1,40 do
                xUnit = "raid"..k
                xGUID=UnitGUID(xUnit)
                if not xGUID then
                    do break end
                end
                sctGUID=strsub(hbArg2,k,k)
                if sctGUID~="!" then
                    hbPermGUIDsecNo[xGUID]=sctGUID
                    hbPermGUIDsecNor[sctGUID]=xGUID
                    hbPermGUIDsecNot[xGUID]=GetTime()
                    hbTempGUIDsecNo[xGUID]=hbPermGUIDsecNo[xGUID]
                end
            end
            hbAcceptList=false
        end
    elseif hbArg1=="R" then
        xGUID=HealBot_IncHeals_shrinkGUID(nil, hbArg2)
        if hbSugGUIDsecNo[xGUID] then hbSugGUIDsecNo[xGUID]=nil end
        if hbAccGUIDsecNo[xGUID] then hbAccGUIDsecNo[xGUID]=nil end
        if hbArg3 then 
            x=strsub(hbArg3,2)
            if strsub(hbArg3,1)=="C" then
                hbPermGUIDsecNo[xGUID]=x
                hbPermGUIDsecNor[x]=xGUID
                hbPermGUIDsecNot[xGUID]=GetTime()
                hbTempGUIDsecNo[xGUID]=x 
            else
                hbAccGUIDsecNo[xGUID]=x
            end
        end            
    elseif hbArg1=="A" then
        xGUID=HealBot_IncHeals_shrinkGUID(nil, hbArg2)
        if hbSugGUIDsecNo[xGUID] then hbAccGUIDsecNo[xGUID]=hbArg3 end
    elseif hbArg1=="S" then
        xGUID=HealBot_IncHeals_shrinkGUID(nil, hbArg2)
        if (hbPermGUIDsecNo[xGUID] and hbPermGUIDsecNo[xGUID]~=hbArg3) or (hbSugGUIDsecNo[xGUID] and hbSugGUIDsecNo[xGUID]~=hbArg3) or (hbAccGUIDsecNo[xGUID] and hbAccGUIDsecNo[xGUID]~=hbArg3) then
            if hbPermGUIDsecNo[xGUID] then
                HealBot_IncHeals_Comms(hbIncHealsCommID, "R:"..hbArg2..":C"..hbPermGUIDsecNo[xGUID], hbAddonMsgType, casterName, nil, nil)
            elseif hbAccGUIDsecNo[xGUID] then
                if hbAccGUIDcount[xGUID] then
                    HealBot_IncHeals_Comms(hbIncHealsCommID, "R:"..hbArg2..":A"..hbAccGUIDsecNo[xGUID], hbAddonMsgType, casterName, nil, nil)
                else
                    HealBot_IncHeals_Comms(hbIncHealsCommID, "R:"..hbArg2, 4, casterName, nil, nil)
                    hbAccGUIDcount[xGUID]=1
                end
            else
                HealBot_IncHeals_Comms(hbIncHealsCommID, "R:"..hbArg2, 4, casterName, nil, nil)
            end
        else
            HealBot_IncHeals_Comms(hbIncHealsCommID, "A:"..hbArg2..":"..hbArg3, 4, casterName, nil, nil)
            hbAccGUIDsecNo[xGUID]=hbArg3
        end
    elseif hbArg1=="C" then
        xGUID=HealBot_IncHeals_shrinkGUID(nil, hbArg2)
        hbPermGUIDsecNo[xGUID]=hbArg3
        hbPermGUIDsecNor[hbArg3]=xGUID
        hbPermGUIDsecNot[xGUID]=GetTime()
        hbTempGUIDsecNo[xGUID]=hbArg3
        if hbSugGUIDsecNo[xGUID] then hbSugGUIDsecNo[xGUID]=nil end
        if hbAccGUIDsecNo[xGUID] then hbAccGUIDsecNo[xGUID]=nil end
    elseif hbArg1=="X" then
        sName=hbFixedSpells[hbArg2]
        if hbCasterHealValues[HealBot_PlayerName] and hbCasterHealValues[HealBot_PlayerName][sName] then
            HealBot_IncHeals_Comms(hbIncHealsCommID, "Z:"..hbArg2..":"..hbCasterHealValues[HealBot_PlayerName][sName], 4, casterName, nil, nil)
        else
            if hbCasterHealValues[HealBot_PlayerName] then
                HealBot_AddDebug("no hbCasterHealValues[HealBot_PlayerName][sName] sName="..sName)
            else
                HealBot_AddDebug("no hbCasterHealValues[HealBot_PlayerName]")
            end
        end
    elseif hbArg1=="Z" then
        sName=hbFixedSpells[hbArg2]
        HealBot_IncHeals_setHealValues(casterName, sName, hbArg3)
    elseif hbArg1=="V" then
        HealBot_IncHeals_sethbCommsUsers(casterName)
    elseif hbArg1=="N" then -- N - `ebil nazi dictator`
        HealBot_IncHeals_removehbCommsUsers(casterName)
    end
end

function HealBot_IncHeals_setHealValues(casterName, spellName, value)
    if not hbCasterHealValues[casterName] then hbCasterHealValues[casterName]={} end
    hbCasterHealValues[casterName][spellName]=floor(value)
    if not hbCasterHealValues[spellName] then
        hbCasterHealValues[spellName]=floor(value)
    else
        hbCasterHealValues[spellName]=floor((hbCasterHealValues[spellName]+value)/2)
    end
  --  HealBot_AddDebug("setHealValues "..casterName.." "..spellName.."="..value)
end

local hbResetUpd=false
function HealBot_IncHeals_resetIncHeals(hbGUID, spellType, casterName)
    if hbGUID then
        if not hbLastCast[hbGUID] or hbLastCast[hbGUID]<GetTime() then
            if hbHealsIn[hbGUID] then hbHealsIn[hbGUID]=nil end
            if hbHoThealsIn[hbGUID] and not spellType then hbHoThealsIn[hbGUID]=nil end
            if HealBot_UnitID[hbGUID] then HealBot_RecalcHeals(hbGUID) end
        elseif casterName and hbHealValues[casterName] then
            HealBot_IncHeals_CommHealsInUpdate(hbGUID, 0-hbHealValues[casterName], nil, casterName, nil)
            hbHealValues[casterName]=nil
          --  hbHealTarget[casterName]=nil
        end
    else
        for xGUID,_ in pairs(HealBot_UnitID) do
            hbResetUpd=false
            if hbHealsIn[xGUID] then 
                hbHealsIn[xGUID]=nil 
                hbResetUpd=true
            end
            if hbHoThealsIn[xGUID] then 
                hbHoThealsIn[xGUID]=nil 
                hbResetUpd=true
            end
            if hbResetUpd then HealBot_RecalcHeals(xGUID) end
        end
    end
    if HealBot_TitanID then TitanPanelButton_UpdateButton(HealBot_TitanID) end
end

function HealBot_IncHeals_resetMyTabs()
    HealBot_setOptions_Timer(122)
    for x,_ in pairs(hbPermGUIDsecNo) do
        hbPermGUIDsecNo[x]=nil;
    end
    for x,_ in pairs(hbPermGUIDsecNor) do
        hbPermGUIDsecNor[x]=nil;
    end
    for x,_ in pairs(hbPermGUIDsecNot) do
        hbPermGUIDsecNot[x]=nil;
    end
    for x,_ in pairs(hbTempGUIDsecNo) do
        hbTempGUIDsecNo[x]=nil;
    end
    for x,_ in pairs(hbAccGUIDsecNo) do
        hbAccGUIDsecNo[x]=nil;
    end
    for x,_ in pairs(hbAccGUIDcount) do
        hbAccGUIDcount[x]=nil;
    end
    for x,_ in pairs(hbSugGUIDsecNo) do
        hbSugGUIDsecNo[x]=nil;
    end
    hbAcceptList=true
    HealBot_AddDebug("in HealBot_IncHeals_resetMyTabs")
end

function HealBot_IncHeals_Comms(addonId, msgPayload, msgType, uName, internal, override)
    if internal then
        HealBot_IncHeals_Msg(msgPayload, uName, internal)
    elseif hbCommsActive or override then
        HealBot_Comms_SendAddonMsg(addonId, msgPayload, msgType, uName)
  --      HealBot_AddDebug("Sent HealBot_Comms_SendAddonMsg msg="..msgPayload.. "  type="..msgType.."  uName="..uName)        
    end
end

function HealBot_IncHeals_Init()
    if HealComm then
        HealComm.RegisterCallback(hbLHC4, "HealComm_HealStarted", "HealStarted")
        HealComm.RegisterCallback(hbLHC4, "HealComm_HealUpdated", "HealUpdated")
        HealComm.RegisterCallback(hbLHC4, "HealComm_HealDelayed", "HealDelayed")
        HealComm.RegisterCallback(hbLHC4, "HealComm_HealStopped", "HealStopped")
        HealComm.RegisterCallback(hbLHC4, "HealComm_ModifierChanged", "ModifierChanged")
        HealComm.RegisterCallback(hbLHC4, "HealComm_GUIDDisappeared", "GUIDDisappeared")
    end
end

function HealBot_IncHeals_allLoaded()
    hbCommsUsers[HealBot_PlayerGUID]=HealBot_PlayerName
end

function hbLHC4:HealStarted(event, casterGUID, spellID, spellType, endTime, ...)
    HealBot_IncHeals_genLHC4(casterGUID, casterGUID, spellID, spellType, endTime, ...)
end

function hbLHC4:HealUpdated(event, casterGUID, spellID, spellType, endTime, ...)
    HealBot_IncHeals_genLHC4(casterGUID, casterGUID, spellID, spellType, endTime, ...)
end

function hbLHC4:HealDelayed(event, casterGUID, spellID, spellType, endTime, ...)
    HealBot_IncHeals_genLHC4(casterGUID, casterGUID, spellID, spellType, endTime, ...)
end

function hbLHC4:HealStopped(event, casterGUID, spellID, spellType, interrupted, ...)
    HealBot_IncHeals_genLHC4(casterGUID, casterGUID, spellID, spellType, nil, ...)
end

function HealBot_IncHeals_genLHC4(casterGUID, casterGUID, spellID, spellType, endTime, ...)
    hbCasterName=nil
    if casterGUID then
        if HealBot_UnitName[casterGUID] then
            hbCasterName=HealBot_UnitName[casterGUID]
        else
            x=HealBot_RaidUnit("unknown",casterGUID)
            if UnitGUID(x)==casterGUID then
                hbCasterName=UnitName(x)
            end
        end
    end
    hbGUIDlist=nil
    if hbCasterName then
        for i=1, select("#", ...) do
            hbTempGUID = select(i, ...)
            if hbGUIDlist then
                hbGUIDlist = hbGUIDlist .. ":" .. hbTempGUID
            else
                hbGUIDlist = hbTempGUID
            end
        end
        if hbGUIDlist then HealBot_IncHeals_parseLHC4(hbGUIDlist, hbCasterName, endTime, casterGUID, spellID, spellType) end
    else
        HealBot_AddDebug("Cast in from LHC4 - NO caster")
        if casterGUID then HealBot_AddDebug("Cast in from LHC4 - casterGUID="..casterGUID) end
	end
end

function hbLHC4:ModifierChanged(event, guid)
    if hbHealsIn[guid] then
        HealBot_IncHeals_parseLHC4(guid, nil, nil, nil, nil, "na")
    end
end

function hbLHC4:GUIDDisappeared(event, guid)
    if hbHealsIn[guid] then
        HealBot_IncHeals_parseLHC4(guid, nil, nil, nil, nil, "na")
    end
end

function HealBot_IncHeals_parseLHC4(htGUID, casterName, endTime, casterGUID, spellID, spellType)
    if Healbot_Config_Skins.ShowIncHeals[Healbot_Config_Skins.Current_Skin]==1 and HealBot_Config.HealCommMethod==1 then
        if strfind(htGUID,":") then 
            utGUID = HealBot_Split(htGUID, ":"); 
        else
            utGUID = htGUID
        end
        if utGUID then
            if (type(utGUID) == "table") then
                table.foreach(utGUID, function (index,uGUID)
                    if HealBot_retPetGUID(uGUID) then uGUID=HealBot_retPetGUID(uGUID) end
                    if HealBot_UnitID[uGUID] then
                        if spellType==HealComm.DIRECT_HEALS and endTime then 
                            HealBot_setHealsIncEndTime(uGUID, casterName, endTime) 
                            if hbUsers[casterName] then
                                hbCommsID=hbIncHealsCommID.." : "..casterName
                            else
                                hbCommsID="LHC40".." : "..casterName
                            end
                            HealBot_addHealBotAddonIncHeals(hbCommsID)
                        end
                        HealBot_IncHeals_HealsInUpdate(uGUID, HealComm.DIRECT_HEALS)
                    end
                end)
            else
                if HealBot_retPetGUID(utGUID) then utGUID=HealBot_retPetGUID(utGUID) end
                if HealBot_UnitID[utGUID] then
                    if spellType==HealComm.DIRECT_HEALS and endTime then 
                        HealBot_setHealsIncEndTime(utGUID, casterName, endTime) 
                        if hbUsers[casterName] then
                            hbCommsID=hbIncHealsCommID.." : "..casterName
                        else
                            hbCommsID="LHC40".." : "..casterName
                        end
                        HealBot_addHealBotAddonIncHeals(hbCommsID)
                    end
                    HealBot_IncHeals_HealsInUpdate(utGUID, spellType)
                end
            end 
        end
    end
end

function HealBot_Titan_Installed(hbTitanId)
    HealBot_TitanCalled=hbTitanId
    HealBot_TitanHealBot_Toggle()
end

function HealBot_Titan_Toggle()
    if HealBot_Config.UpdateTitan==1 then
        HealBot_Config.UpdateTitan=0
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_TITANOFF)
    else
        HealBot_Config.UpdateTitan=1
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_TITANON)
    end
    HealBot_TitanHealBot_Toggle()
end

function HealBot_TitanHealBot_Toggle()
    if HealBot_TitanCalled then
        if HealBot_Config.UpdateTitan==1 then
            HealBot_TitanID=HealBot_TitanCalled
        else
            HealBot_TitanID=false
        end
    end
end
