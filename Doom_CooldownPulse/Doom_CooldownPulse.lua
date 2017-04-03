local fadeInTime, fadeOutTime, maxAlpha, animScale, iconSize, holdTime, ignoredSpells
local cooldowns, animating, watching = { }, { }, { }
local GetTime = GetTime

local defaultsettings = { 
    fadeInTime = 0.3, 
    fadeOutTime = 0.7, 
    maxAlpha = 0.7, 
    animScale = 1.5, 
    iconSize = 75, 
    holdTime = 0,
    petOverlay = {1,1,1},
    ignoredSpells = "",
    x = UIParent:GetWidth()/2, 
    y = UIParent:GetHeight()/2 
}

local DCP = CreateFrame("frame")
DCP:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
DCP:SetMovable(true)
DCP:RegisterForDrag("LeftButton")
DCP:SetScript("OnDragStart", function(self) self:StartMoving() end)
DCP:SetScript("OnDragStop", function(self) 
    self:StopMovingOrSizing() 
    DCP_Saved.x = self:GetLeft()+self:GetWidth()/2 
    DCP_Saved.y = self:GetBottom()+self:GetHeight()/2 
    self:ClearAllPoints() 
    self:SetPoint("CENTER",UIParent,"BOTTOMLEFT",DCP_Saved.x,DCP_Saved.y)
end)

local DCPT = DCP:CreateTexture(nil,"BACKGROUND")
DCPT:SetAllPoints(DCP)

-----------------------
-- Utility Functions --
-----------------------
local function tcount(tab)
    local n = 0
    for _ in pairs(tab) do
        n = n + 1
    end
    return n
end

local function GetPetActionIndexByName(name)
    for i=1, NUM_PET_ACTION_SLOTS, 1 do
        if (GetPetActionInfo(i) == name) then
            return i
        end
    end
    return nil
end

local function RefreshLocals()
    fadeInTime = DCP_Saved.fadeInTime
    fadeOutTime = DCP_Saved.fadeOutTime
    maxAlpha = DCP_Saved.maxAlpha
    animScale = DCP_Saved.animScale
    iconSize = DCP_Saved.iconSize
    holdTime = DCP_Saved.holdTime

    ignoredSpells = { }
    for _,v in ipairs({strsplit(",",DCP_Saved.ignoredSpells)}) do
        ignoredSpells[strtrim(v)] = true
    end
end

--------------------------
-- Cooldown / Animation --
--------------------------
local elapsed = 0
local runtimer = 0
local function OnUpdate(_,update)
    elapsed = elapsed + update
    if (elapsed > 0.05) then
        for i,v in pairs(watching) do
            if (GetTime() >= v[1] + 0.5) then
                if ignoredSpells[i] then
                    watching[i] = nil
                else
                    local start, duration, enabled, texture, isPet
                    if (v[2] == "spell") then
                        texture = GetSpellTexture(v[3])
                        start, duration, enabled = GetSpellCooldown(v[3])
                    elseif (v[2] == "item") then
                        texture = v[3]
                        start, duration, enabled = GetItemCooldown(i)
                    elseif (v[2] == "pet") then
                        texture = select(3,GetPetActionInfo(v[3]))
                        start, duration, enabled = GetPetActionCooldown(v[3])
                        isPet = true
                    end
                    if (enabled ~= 0) then
                        if (duration and duration > 2.0 and texture) then
                            cooldowns[i] = { start, duration, texture, isPet }
                        end
                    end
                    if (not (enabled == 0 and v[2] == "spell")) then
                        watching[i] = nil
                    end
                end
            end
        end
        for i,v in pairs(cooldowns) do
            local remaining = v[2]-(GetTime()-v[1])
            if (remaining <= 0) then
                tinsert(animating, {v[3],v[4]})
                cooldowns[i] = nil
            end
        end
        
        elapsed = 0
        if (#animating == 0 and tcount(watching) == 0 and tcount(cooldowns) == 0) then
            DCP:SetScript("OnUpdate", nil)
            return
        end
    end
    
    if (#animating > 0) then
        runtimer = runtimer + update
        if (runtimer > (fadeInTime + holdTime + fadeOutTime)) then
            tremove(animating,1)
            runtimer = 0
            DCPT:SetTexture(nil)
            DCPT:SetVertexColor(1,1,1)
        else
            if (not DCPT:GetTexture()) then
                DCPT:SetTexture(animating[1][1])
                if animating[1][2] then
                    DCPT:SetVertexColor(unpack(DCP_Saved.petOverlay))
                end
                PlaySoundFile("Interface\\AddOns\\Doom_CooldownPulse\\lubdub.wav")
            end
            local alpha = maxAlpha
            if (runtimer < fadeInTime) then
                alpha = maxAlpha * (runtimer / fadeInTime)
            elseif (runtimer >= fadeInTime + holdTime) then
                alpha = maxAlpha - ( maxAlpha * ((runtimer - holdTime - fadeInTime) / fadeOutTime))
            end
            DCP:SetAlpha(alpha)
            local scale = iconSize+(iconSize*((animScale-1)*(runtimer/(fadeInTime+holdTime+fadeOutTime))))
            DCP:SetWidth(scale)
            DCP:SetHeight(scale)
        end
    end
end

--------------------
-- Event Handlers --
--------------------
function DCP:ADDON_LOADED(addon)
    if (not DCP_Saved) then
        DCP_Saved = defaultsettings
    else
        for i,v in pairs(defaultsettings) do
            if (not DCP_Saved[i]) then
                DCP_Saved[i] = v
            end
        end
    end
    RefreshLocals()
    self:SetPoint("CENTER",UIParent,"BOTTOMLEFT",DCP_Saved.x,DCP_Saved.y)
    self:UnregisterEvent("ADDON_LOADED")
end
DCP:RegisterEvent("ADDON_LOADED")

function DCP:UNIT_SPELLCAST_SUCCEEDED(unit,spell,rank)
    if (unit == "player") then
        watching[spell] = {GetTime(),"spell",spell.."("..rank..")"}
        if (not self:IsMouseEnabled()) then
            self:SetScript("OnUpdate", OnUpdate)
        end
    end
end
DCP:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

function DCP:COMBAT_LOG_EVENT_UNFILTERED(...)
    local _,event,_,_,sourceFlags,_,_,_,spellID = ...
    if (event == "SPELL_CAST_SUCCESS") then
        if (bit.band(sourceFlags,COMBATLOG_OBJECT_TYPE_PET) == COMBATLOG_OBJECT_TYPE_PET and bit.band(sourceFlags,COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE) then
            local name = GetSpellInfo(spellID)
            local index = GetPetActionIndexByName(name)
            if (index and not select(7,GetPetActionInfo(index))) then
                watching[name] = {GetTime(),"pet",index}
            elseif (not index and name) then
                watching[name] = {GetTime(),"spell",name}
            else
                return
            end
            if (not self:IsMouseEnabled()) then
                self:SetScript("OnUpdate", OnUpdate)
            end
        end
    end
end
PetActionButton1:HookScript("OnShow", function() DCP:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") end)
PetActionButton1:HookScript("OnHide", function() DCP:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED") end)

function DCP:PLAYER_ENTERING_WORLD()
    local inInstance,instanceType = IsInInstance()
    if (inInstance and instanceType == "arena") then
        self:SetScript("OnUpdate", nil)
        wipe(cooldowns)
        wipe(watching)
    end
end
DCP:RegisterEvent("PLAYER_ENTERING_WORLD")

hooksecurefunc("UseAction", function(slot)
    local actionType,itemID = GetActionInfo(slot)
    if (actionType == "item") then
        local item = GetItemInfo(itemID)
        local texture = GetActionTexture(slot)
        watching[item] = {GetTime(),"item",texture}
    end
end)

hooksecurefunc("UseInventoryItem", function(slot)
    local item = GetItemInfo(GetInventoryItemLink("player",slot) or "")
    if (item) then
        local texture = GetInventoryItemTexture("player",slot)
        watching[item] = {GetTime(),"item",texture}
    end
end)
hooksecurefunc("UseContainerItem", function(bag,slot)
    local item = GetItemInfo(GetContainerItemLink(bag,slot) or "")
    if (item) then
        local texture = select(10,GetItemInfo(GetContainerItemLink(bag,slot) or ""))
        watching[item] = {GetTime(),"item",texture}
    end
end)

-------------------
-- Options Frame --
-------------------

SlashCmdList["DOOMCOOLDOWNPULSE"] = function() if (not DCP_OptionsFrame) then DCP:CreateOptionsFrame() end DCP_OptionsFrame:Show() end
SLASH_DOOMCOOLDOWNPULSE1 = "/dcp"
SLASH_DOOMCOOLDOWNPULSE2 = "/cooldownpulse"
SLASH_DOOMCOOLDOWNPULSE3 = "/doomcooldownpulse"

function DCP:CreateOptionsFrame()
    local sliders = {
        { text = "Icon Size", value = "iconSize", min = 30, max = 125, step = 5 },
        { text = "Fade In Time", value = "fadeInTime", min = 0, max = 1.5, step = 0.1 },
        { text = "Fade Out Time", value = "fadeOutTime", min = 0, max = 1.5, step = 0.1 },
        { text = "Max Opacity", value = "maxAlpha", min = 0, max = 1, step = 0.1 },
        { text = "Max Opacity Hold Time", value = "holdTime", min = 0, max = 1.5, step = 0.1 },
        { text = "Animation Scaling", value = "animScale", min = 0, max = 2, step = 0.1 },
    }
    
    local buttons = {
        { text = "Close", func = function(self) self:GetParent():Hide() end },
        { text = "Test", func = function(self) 
            DCP_OptionsFrameButton3:SetText("Unlock") 
            DCP:EnableMouse(false) 
            RefreshLocals() 
            tinsert(animating,{"Interface\\Icons\\Spell_Nature_Earthbind"}) 
            DCP:SetScript("OnUpdate", OnUpdate) 
            end },
        { text = "Unlock", func = function(self) 
            if (self:GetText() == "Unlock") then
                RefreshLocals()
                DCP:SetWidth(iconSize) 
                DCP:SetHeight(iconSize) 
                self:SetText("Lock") 
                DCP:SetScript("OnUpdate", nil) 
                DCP:SetAlpha(1) 
                DCPT:SetTexture("Interface\\Icons\\Spell_Nature_Earthbind") 
                DCP:EnableMouse(true) 
            else 
                DCP:SetAlpha(0) 
                self:SetText("Unlock") 
                DCP:EnableMouse(false) 
            end end },
        { text = "Defaults", func = function(self) 
            for i,v in pairs(defaultsettings) do 
                DCP_Saved[i] = v 
            end 
            for i,v in pairs(sliders) do 
                getglobal("DCP_OptionsFrameSlider"..i):SetValue(DCP_Saved[v.value]) 
            end
            DCP_OptionsFramePetColorBox:GetNormalTexture():SetVertexColor(unpack(DCP_Saved.petOverlay))
            DCP_OptionsFrameIgnoreBox:SetText("")
            DCP:ClearAllPoints()
            DCP:SetPoint("CENTER",UIParent,"BOTTOMLEFT",DCP_Saved.x,DCP_Saved.y) 
            end },
    }

    local optionsframe = CreateFrame("frame","DCP_OptionsFrame")
    optionsframe:SetBackdrop({
      bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
      edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
      tile=1, tileSize=32, edgeSize=32, 
      insets={left=11, right=12, top=12, bottom=11}
    })
    optionsframe:SetWidth(220)
    optionsframe:SetHeight(485)
    optionsframe:SetPoint("CENTER",UIParent)
    optionsframe:EnableMouse(true)
    optionsframe:SetMovable(true)
    optionsframe:RegisterForDrag("LeftButton")
    optionsframe:SetScript("OnDragStart", function(self) self:StartMoving() end)
    optionsframe:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    optionsframe:SetFrameStrata("FULLSCREEN_DIALOG")
    optionsframe:SetScript("OnHide", function() RefreshLocals() end)
    tinsert(UISpecialFrames, "DCP_OptionsFrame")

    local header = optionsframe:CreateTexture(nil,"ARTWORK")
    header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header.blp")
    header:SetWidth(350)
    header:SetHeight(68)
    header:SetPoint("TOP",optionsframe,"TOP",0,12)

    local headertext = optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormal")
    headertext:SetPoint("TOP",header,"TOP",0,-14)
    headertext:SetText("Doom_CooldownPulse")

    for i,v in pairs(sliders) do
        local slider = CreateFrame("slider", "DCP_OptionsFrameSlider"..i, optionsframe, "OptionsSliderTemplate")
        if (i == 1) then
            slider:SetPoint("TOP",optionsframe,"TOP",0,-40)
        else
            slider:SetPoint("TOP",getglobal("DCP_OptionsFrameSlider"..(i-1)),"BOTTOM",0,-35)
        end
        local valuetext = slider:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
        valuetext:SetPoint("TOP",slider,"BOTTOM",0,-1)
        valuetext:SetText(format("%.1f",DCP_Saved[v.value]))
        getglobal("DCP_OptionsFrameSlider"..i.."Text"):SetText(v.text)
        getglobal("DCP_OptionsFrameSlider"..i.."Low"):SetText(v.min)
        getglobal("DCP_OptionsFrameSlider"..i.."High"):SetText(v.max)
        slider:SetMinMaxValues(v.min,v.max)
        slider:SetValueStep(v.step)
        slider:SetValue(DCP_Saved[v.value])
        slider:SetScript("OnValueChanged",function() 
            local val=slider:GetValue() DCP_Saved[v.value]=val 
            valuetext:SetText(format("%.1f",val)) 
            if (DCP:IsMouseEnabled()) then 
                DCP:SetWidth(DCP_Saved.iconSize) 
                DCP:SetHeight(DCP_Saved.iconSize) 
            end end)
    end
    
    local ignoretext = optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
    ignoretext:SetPoint("TOPLEFT","DCP_OptionsFrameSlider"..#sliders,"BOTTOMLEFT",-15,-25)
    ignoretext:SetText("Cooldowns to ignore:")
    
    local ignorebox = CreateFrame("EditBox","DCP_OptionsFrameIgnoreBox",optionsframe,"InputBoxTemplate")
    ignorebox:SetAutoFocus(false)
    ignorebox:SetPoint("TOPLEFT",ignoretext,"BOTTOMLEFT",0,3)
    ignorebox:SetWidth(180)
    ignorebox:SetHeight(32)
    ignorebox:SetText(DCP_Saved.ignoredSpells)
    ignorebox:SetScript("OnEnter",function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR") GameTooltip:SetText("Note: Separate multiple spells with commas") end)
    ignorebox:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
    ignorebox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    ignorebox:SetScript("OnEditFocusLost",function(self)
        DCP_Saved.ignoredSpells = ignorebox:GetText()
        RefreshLocals()
    end)
    
    local pettext = optionsframe:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
    pettext:SetPoint("TOPLEFT",ignorebox,"BOTTOMLEFT",0,-5)
    pettext:SetText("Pet color overlay:")
    
    local petcolorselect = CreateFrame('Button',"DCP_OptionsFramePetColorBox",optionsframe)
    petcolorselect:SetPoint("LEFT",pettext,"RIGHT",5,-2)
    petcolorselect:SetWidth(20)
    petcolorselect:SetHeight(20)
	petcolorselect:SetNormalTexture('Interface/ChatFrame/ChatFrameColorSwatch')
    petcolorselect:GetNormalTexture():SetVertexColor(unpack(DCP_Saved.petOverlay))
    petcolorselect:SetScript("OnEnter",function(self) GameTooltip:SetOwner(self, "ANCHOR_CURSOR") GameTooltip:SetText("Note: Use white if you don't want any overlay for pet cooldowns") end)
    petcolorselect:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
    petcolorselect:SetScript('OnClick', function(self) 
        self.r,self.g,self.b = unpack(DCP_Saved.petOverlay) 
        OpenColorPicker(self) 
        ColorPickerFrame:SetPoint("TOPLEFT",optionsframe,"TOPRIGHT")
        end)
    petcolorselect.swatchFunc = function(self) DCP_Saved.petOverlay={ColorPickerFrame:GetColorRGB()} petcolorselect:GetNormalTexture():SetVertexColor(ColorPickerFrame:GetColorRGB()) end
    petcolorselect.cancelFunc = function(self) DCP_Saved.petOverlay={self.r,self.g,self.b} petcolorselect:GetNormalTexture():SetVertexColor(unpack(DCP_Saved.petOverlay)) end
	
	local petcolorselectbg = petcolorselect:CreateTexture(nil, 'BACKGROUND')
	petcolorselectbg:SetWidth(17)
    petcolorselectbg:SetHeight(17)
	petcolorselectbg:SetTexture(1,1,1)
	petcolorselectbg:SetPoint('CENTER')
    
    for i,v in pairs(buttons) do
        local button = CreateFrame("Button", "DCP_OptionsFrameButton"..i, optionsframe, "UIPanelButtonTemplate")
        button:SetHeight(24)
        button:SetWidth(75)
        button:SetPoint("BOTTOM", optionsframe, "BOTTOM", ((i%2==0 and -1) or 1)*45, ceil(i/2)*15 + (ceil(i/2)-1)*15)
        button:SetText(v.text)
        button:SetScript("OnClick", function(self) PlaySound("igMainMenuOption") v.func(self) end)
    end
end