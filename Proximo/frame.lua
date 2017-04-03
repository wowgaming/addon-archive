local Proximo = Proximo
local db
local media = LibStub("LibSharedMedia-3.0")

local max_unit_size = 5
local max_party_size = 4
local header_padding = 33
local partypadding_default = 5
local manapadding_default = 5
local spellpadding_default = 5
local highlight_padding = 10
local base_height = 0
local per_bar_height = 0

local SendChatMessage = SendChatMessage
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local InCombatLockdown = InCombatLockdown

function Proximo:MakeFrame()
  --local the profile table
  db = self.db.profile
  local barwidth = db.barwidth
  local barheight = db.barheight
  local padding = db.padding
  local extrapadding = 0
  local ptpadding = 0
  local racepadding = 0
  partypadding_default = db.partytargetheight + 1
  manapadding_default = db.manaheight + 1
  spellpadding_default = db.spellheight + 1
  if db.partytargets then
    extrapadding = extrapadding + partypadding_default
    ptpadding = ptpadding + partypadding_default
  end
  if db.mana then
    extrapadding = extrapadding + manapadding_default
  end
  if db.spell then
    extrapadding = extrapadding + spellpadding_default
  end
  if db.race or db.auras then
    racepadding = barheight
  end
  base_height = 4+header_padding+padding
  per_bar_height = barheight+padding+extrapadding

  self.frame=CreateFrame("Button", "ProximoMain", UIParent)
  self.frame.owner = self
  self.frame:Hide()
  self.frame:SetWidth(barwidth+barheight+(padding*2)+8+racepadding)
  self.frame:SetHeight(1)
  self.frame:SetScale(db.scale)
  self.frame:ClearAllPoints()
  if db.x==0 and db.y==0 then
    self.frame:SetPoint("TOP", UIParent, "TOP")
  else
    local es = self.frame:GetEffectiveScale()
    if db.growup then
      self.frame:SetPoint("BOTTOMLEFT", UIParent, "CENTER", db.x/es, db.y/es)
    else
      self.frame:SetPoint("TOPLEFT", UIParent, "CENTER", db.x/es, db.y/es)
    end
  end
  self.frame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
    edgeFile = "Interface\\AddOns\\Proximo\\Textures\\otravi-semi-full-border", edgeSize = 32,
    insets = {left = 1, right = 1, top = 30, bottom = 1},
  })
  self.frame:SetBackdropColor(db.framecolor.r,db.framecolor.g,db.framecolor.b,db.framecolor.a)
  self.frame:SetBackdropBorderColor(1,1,1,0)
  self.frame:EnableMouse(true)
  self.frame:SetMovable(true)
  self.frame:RegisterForDrag("LeftButton")
  self.frame:RegisterForClicks("RightButtonUp")
  self.frame:SetScript(
    'OnClick', function()
       if not InCombatLockdown() and not self:ArenaStarted() then self:ShowOptions() end
    end
  )
  self.frame:SetScript(
    'OnDragStart', function()
      if not InCombatLockdown() and (IsAltKeyDown() or not db.lockframe) then this:StartMoving() end
    end
  )
  self.frame:SetScript(
    'OnDragStop', function()
        if not InCombatLockdown() then
        this:StopMovingOrSizing()
        local x, y = this:GetLeft(),  db.growup and this:GetBottom() or this:GetTop()
        local es = this:GetEffectiveScale()
        local ps = UIParent:GetScale()
        x = x*es - GetScreenWidth()*ps/2
        y = y*es - GetScreenHeight()*ps/2
        this.owner.db.profile.x, this.owner.db.profile.y = x, y
      end
    end
  )

  self.frame.text = self.frame:CreateFontString(nil, "OVERLAY")
  self.frame.text:ClearAllPoints()
  self.frame.text:SetWidth(barwidth)
  self.frame.text:SetHeight(header_padding)
  self.frame.text:SetPoint("TOP", self.frame, "TOP", 0, -5)
  self.frame.text:SetFont(media:Fetch("font", db.font), 16)
  self.frame.text:SetJustifyH("CENTER")
  self.frame.text:SetText("")
  self.frame.text:SetShadowOffset(1, -1)
  self.frame.text:SetShadowColor(0, 0, 0, 1)

  --set up header settings
  if (db.header) then
    self.frame:SetBackdropBorderColor(1,1,1,1)
    self.frame.text:SetText(self.title)
  end

  self.frame.buttons={}
  for i=1,max_unit_size do
    local b=CreateFrame("Button", "ProximoTarget"..i, self.frame, "SecureActionButtonTemplate")
    b:SetHeight(barheight+extrapadding)
    b:SetWidth(barwidth+barheight+racepadding)
    b:ClearAllPoints()
    if i==1 then
      b:SetPoint("TOP",self.frame,"TOP", 0, -padding-header_padding-ptpadding)
    else
      b:SetPoint("TOP",self.frame.buttons[i-1],"BOTTOM", 0, -padding)
    end
    b:RegisterForClicks("AnyUp")
    b:SetAttribute("*type*", "macro")
    b:SetAttribute("macrotext1", "/script PlaySound(\"igQuestLogAbandonQuest\")")
    b:SetAttribute("macrotext2", "/script PlaySound(\"igQuestLogAbandonQuest\")")
    b:SetAttribute("macrotext3", "/script PlaySound(\"igQuestLogAbandonQuest\")")
    b:SetAttribute("macrotext4", "/script PlaySound(\"igQuestLogAbandonQuest\")")
    b:SetAttribute("macrotext5", "/script PlaySound(\"igQuestLogAbandonQuest\")")
    b:Hide()

    b.healthBar = CreateFrame("StatusBar", "HealthBar", b)
    b.healthBar:ClearAllPoints()
    b.healthBar:SetPoint("TOPLEFT",b,"TOPLEFT", barheight, 0)
    b.healthBar:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT", -racepadding, extrapadding)
    b.healthBar:SetStatusBarTexture(media:Fetch('statusbar', db.texture))
    b.healthBar:SetMinMaxValues(0, 100)
    b.healthBar:SetValue(0)

    b.healthBar.bg = b.healthBar:CreateTexture(nil, "BACKGROUND")
    b.healthBar.bg:ClearAllPoints()
    b.healthBar.bg:SetAllPoints(b.healthBar)
    b.healthBar.bg:SetTexture(media:Fetch('statusbar', db.texture))
    b.healthBar.bg:SetVertexColor(0.3, 0.3, 0.3)
    b.healthBar.bg:SetAlpha(0.3)
    b.healthBar.bg:Hide()

    b.healthBar.highlight = CreateFrame("Frame", "Highlight", b.healthBar)
    if db.highlight == "tooltip" then
      highlight_padding = 10
      b.healthBar.highlight:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
        insets = {left = 4, right = 4, top = 4, bottom = 4},
      })
    elseif db.highlight == "solid" then
      highlight_padding = 4
      b.healthBar.highlight:SetBackdrop({
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 1,
        insets = {left = 0, right = 0, top = 0, bottom = 0},
      })
    end
    b.healthBar.highlight:SetBackdropBorderColor(db.highlightcolor.r,db.highlightcolor.g,db.highlightcolor.b,0)
    b.healthBar.highlight:SetHeight(barheight+highlight_padding+extrapadding)
    b.healthBar.highlight:SetWidth(barwidth+highlight_padding)
    b.healthBar.highlight:ClearAllPoints()
    b.healthBar.highlight:SetPoint("TOP",b.healthBar,"TOP", 0, (highlight_padding/2)+ptpadding)

    b.healthBar.selected = b.healthBar:CreateTexture(nil, "OVERLAY")
    b.healthBar.selected:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    b.healthBar.selected:SetBlendMode("ADD")
    b.healthBar.selected:SetAlpha(0.5)
    b.healthBar.selected:ClearAllPoints()
    b.healthBar.selected:SetAllPoints(b.healthBar)
    b.healthBar.selected:Hide()

    b.healthtext = b.healthBar:CreateFontString(nil,"LOW")
    b.healthtext:SetFont(media:Fetch("font", db.font), db.fontsize)
    b.healthtext:SetShadowOffset(1, -1)
    b.healthtext:SetShadowColor(0, 0, 0, 1)
    b.healthtext:SetJustifyH("RIGHT")
    b.healthtext:SetPoint("RIGHT")

    b.text = b.healthBar:CreateFontString(nil,"LOW")
    b.text:SetFont(media:Fetch("font", db.font), db.fontsize)
    b.text:SetShadowOffset(1, -1)
    b.text:SetShadowColor(0, 0, 0, 1)
    b.text:SetJustifyH("LEFT")
    b.text:SetPoint("LEFT")
    b.text:SetPoint("RIGHT", b.healthtext, "LEFT")

    b.icon = b:CreateTexture(nil, "ARTWORK")
    b.icon:ClearAllPoints()
    b.icon:SetHeight(barheight)
    b.icon:SetWidth(barheight)
    b.icon:SetPoint("TOPLEFT",b,"TOPLEFT",-1,0)

    self:CreateManaBar(b)
    self:CreateSpellBar(b)
    self:CreateRaceIcon(b)
    self:CreateAuraIcon(b)
    self:CreatePartyTargets(b)

    table.insert(self.frame.buttons,b)
  end
  self:UpdateFrameHeight()
end


function Proximo:UpdateFrame()
  --if no frame made, then make it instead of update.
  if not self.frame then
    return
  end
  --local the profile table
  db = self.db.profile
  local barwidth = db.barwidth
  local barheight = db.barheight
  local padding = db.padding
  local extrapadding = 0
  local ptpadding = 0
  local racepadding = 0
  partypadding_default = db.partytargetheight + 1
  manapadding_default = db.manaheight + 1
  spellpadding_default = db.spellheight + 1
  if db.partytargets then
    extrapadding = extrapadding + partypadding_default
    ptpadding = ptpadding + partypadding_default
  end
  if db.mana then
    extrapadding = extrapadding + manapadding_default
  end
  if db.spell then
    extrapadding = extrapadding + spellpadding_default
  end
  if db.race or db.auras then
    racepadding = barheight
  end
  base_height = 4+header_padding+padding
  per_bar_height = barheight+padding+extrapadding

  self.frame:SetWidth(barwidth+barheight+(padding*2)+8+racepadding)
  self.frame:SetHeight(1)
  self.frame:SetScale(db.scale)
  self.frame:SetBackdropColor(db.framecolor.r,db.framecolor.g,db.framecolor.b,db.framecolor.a)
  self.frame:SetBackdropBorderColor(1,1,1,0)
  self.frame:ClearAllPoints()
  if db.x==0 and db.y==0 then
    self.frame:SetPoint("TOP", UIParent, "TOP")
  else
    local es = self.frame:GetEffectiveScale()
    if db.growup then
      self.frame:SetPoint("BOTTOMLEFT", UIParent, "CENTER", db.x/es, db.y/es)
    else
      self.frame:SetPoint("TOPLEFT", UIParent, "CENTER", db.x/es, db.y/es)
    end
  end

  self.frame.text:SetFont(media:Fetch("font", db.font), 16)
  self.frame.text:SetWidth(barwidth)
  self.frame.text:SetText("")

  if (db.header) then
    self.frame:SetBackdropBorderColor(1,1,1,1)
    self.frame.text:SetText(self.title)
  end

  for i=1,max_unit_size do
    local b=self.frame.buttons[i]
    b:SetHeight(barheight+extrapadding)
    b:SetWidth(barwidth+barheight+racepadding)
    b:ClearAllPoints()
    if i==1 then
      b:SetPoint("TOP",self.frame,"TOP", 0, -padding-header_padding-ptpadding)
    else
      b:SetPoint("TOP",self.frame.buttons[i-1],"BOTTOM", 0, -padding)
    end
    b.healthBar:ClearAllPoints()
    b.healthBar:SetPoint("TOPLEFT",b,"TOPLEFT", barheight, 0)
    b.healthBar:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT", -racepadding, extrapadding)
    b.healthBar:SetStatusBarTexture(media:Fetch('statusbar', db.texture))
    b.healthBar.bg:SetTexture(media:Fetch('statusbar', db.texture))
    if db.highlight == "tooltip" then
      highlight_padding = 10
      b.healthBar.highlight:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
        insets = {left = 4, right = 4, top = 4, bottom = 4},
      })
    elseif db.highlight == "solid" then
      highlight_padding = 4
      b.healthBar.highlight:SetBackdrop({
        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 1,
        insets = {left = 0, right = 0, top = 0, bottom = 0},
      })
    end
    b.healthBar.highlight:SetBackdropBorderColor(db.highlightcolor.r,db.highlightcolor.g,db.highlightcolor.b,0)
    b.healthBar.highlight:SetHeight(barheight+highlight_padding+extrapadding)
    b.healthBar.highlight:SetWidth(barwidth+highlight_padding)
    b.healthBar.highlight:SetPoint("TOP",b.healthBar,"TOP", 0, (highlight_padding/2)+ptpadding)
    b.text:SetFont(media:Fetch("font", db.font), db.fontsize)
    b.healthtext:SetFont(media:Fetch("font", db.font), db.fontsize)
    b.icon:SetHeight(barheight)
    b.icon:SetWidth(barheight)
    if db.partytargets then
      if b.partytargets then
        for j=1,max_party_size do
          b.partytargets[j]:SetWidth((barwidth/max_party_size)-1)
          b.partytargets[j]:SetHeight(db.partytargetheight)
          if j==1 then
            b.partytargets[j]:ClearAllPoints()
            b.partytargets[j]:SetPoint("BOTTOMLEFT",b,"TOPLEFT",barheight,1)
          end
          b.partytargets[j]:SetStatusBarTexture(media:Fetch('statusbar', db.texture))
          b.partytargets[j].bg:SetTexture(media:Fetch('statusbar', db.texture))
          if b.healthBar.bg:IsVisible() then b.partytargets[j]:Show() end
        end
      else
        self:CreatePartyTargets(b)
      end
    elseif b.partytargets then
      for j=1,max_party_size do
        b.partytargets[j]:Hide()
      end
    end
    if db.mana then
      if b.manaBar then
        b.manaBar:SetWidth(barwidth)
        b.manaBar:SetHeight(db.manaheight)
        b.manaBar:SetStatusBarTexture(media:Fetch('statusbar', db.texture))
        b.manaBar:SetStatusBarColor(db.manacolor.r,db.manacolor.g,db.manacolor.b,1)
        b.manaBar.bg:SetVertexColor(db.manacolor.r,db.manacolor.g,db.manacolor.b)
      else
        self:CreateManaBar(b)
      end
    elseif b.manaBar then
      b.manaBar:Hide()
    end
    if db.spell then
      if b.spellBar then
        b.spellBar:SetWidth(barwidth)
        b.spellBar:SetHeight(db.spellheight)
        b.spellBar:SetStatusBarTexture(media:Fetch('statusbar', db.texture))
        b.spellBar:SetStatusBarColor(db.spellcolor.r,db.spellcolor.g,db.spellcolor.b,1)
        b.spellBar.bg:SetVertexColor(db.spellcolor.r,db.spellcolor.g,db.spellcolor.b)
        b.spellBar.text:SetFont(media:Fetch("font", db.font), db.spellfontsize)
        if db.mana then
          b.spellBar:SetPoint("TOPLEFT",b.manaBar,"BOTTOMLEFT",0,-1)
        else
          b.spellBar:SetPoint("TOPLEFT",b.healthBar,"BOTTOMLEFT",0,-1)
        end
      else
        self:CreateSpellBar(b)
      end
    elseif b.spellBar then
      b.spellBar:Hide()
    end
    if db.race then
      if b.raceicon then
        b.raceicon:SetHeight(barheight)
        b.raceicon:SetWidth(barheight)
        if not b.raceicon:IsVisible() then
          b.raceicon:Show()
        end
      else
        self:CreateRaceIcon(b)
      end
    elseif b.raceicon then
      b.raceicon:Hide()
    end
    if db.auras then
      if b.aura then
        b.aura:SetHeight(barheight)
        b.aura:SetWidth(barheight)
        b.aura.text:SetFont(media:Fetch("font", db.font), db.aurafontsize)
        b.aura.text:SetTextColor(db.auracolor.r, db.auracolor.g, db.auracolor.b)
      else
        self:CreateAuraIcon(b)
      end
    elseif b.aura then
      b.aura:Hide()
    end
  end
  if db.race then
    self:SetAllRaceIcon()
  end
  self:UpdateFrameHeight()
  self:FrameRefresh()
end

function Proximo:UpdateFrameHeight()
  --check again in a second
  if InCombatLockdown() then
    self:ScheduleTimer("UpdateFrameHeight", 1, self)
    return
  end
  local size = self:GetMaxUnit()
  --set size
  self.frame:SetHeight(base_height+(per_bar_height*size))
  --show frames
  for i=1,size do
    if self.frame.buttons[i] then
      if not self.frame.buttons[i]:IsShown() then self.frame.buttons[i]:Show() end
    end
  end
end

function Proximo:CreatePartyTargets(frame)
  local pt
  if db.partytargets and not frame.partytargets then
    local barwidth = db.barwidth
    local barheight = db.barheight
    frame.partytargets={}
    for j=1,max_party_size do
      pt = CreateFrame("StatusBar", "PartyBar", frame)
      pt:ClearAllPoints()
      if j==1 then
        pt:SetPoint("BOTTOMLEFT",frame,"TOPLEFT",barheight,1)
        pt:SetWidth((barwidth/max_party_size))
      else
        pt:SetPoint("TOPLEFT",frame.partytargets[j-1],"TOPRIGHT",1,0)
        pt:SetWidth((barwidth/max_party_size)-1)
      end
      pt:SetHeight(db.partytargetheight)
      pt:SetStatusBarTexture(media:Fetch('statusbar', db.texture))
      pt:SetMinMaxValues(0, 1)
      pt:SetValue(0)

      pt.bg = pt:CreateTexture(nil, "BACKGROUND")
      pt.bg:ClearAllPoints()
      pt.bg:SetAllPoints(pt)
      pt.bg:SetTexture(media:Fetch('statusbar', db.texture))
      pt.bg:SetVertexColor(.7,.7,.7)
      pt.bg:SetAlpha(0.3)

      pt:Hide()
      table.insert(frame.partytargets,pt)
    end
  end
end

function Proximo:CreateManaBar(frame)
  if db.mana and not frame.manaBar then
    frame.manaBar = CreateFrame("StatusBar", "ManaBar", frame)
    frame.manaBar:ClearAllPoints()
    frame.manaBar:SetHeight(db.manaheight)
    frame.manaBar:SetWidth(frame.healthBar:GetWidth())
    frame.manaBar:SetPoint("TOPLEFT",frame.healthBar,"BOTTOMLEFT",0,-1)
    frame.manaBar:SetStatusBarTexture(media:Fetch('statusbar', db.texture))
    frame.manaBar:SetStatusBarColor(db.manacolor.r,db.manacolor.g,db.manacolor.b,1)
    frame.manaBar:SetMinMaxValues(0, 100)
    frame.manaBar:SetValue(0)

    frame.manaBar.bg = frame.manaBar:CreateTexture(nil, "BACKGROUND")
    frame.manaBar.bg:ClearAllPoints()
    frame.manaBar.bg:SetAllPoints(frame.manaBar)
    frame.manaBar.bg:SetTexture(media:Fetch('statusbar', db.texture))
    frame.manaBar.bg:SetVertexColor(db.manacolor.r,db.manacolor.g,db.manacolor.b)
    frame.manaBar.bg:SetAlpha(0.3)

    frame.manaBar:Hide()
  end
end

local function spellUpdate(self, elapsed)
  self.time = self.time + elapsed
  if self.time >= self.maxtime then
    Proximo:SpellEnd(self)
  else
    self:SetValue(self.time)
    self.text:SetFormattedText(self.format, self.spell, self.maxtime - self.time)
  end
end

function Proximo:CreateSpellBar(frame)
  if db.spell and not frame.spellBar then
    frame.spellBar = CreateFrame("StatusBar", "SpellBar", frame)
    frame.spellBar:ClearAllPoints()
    frame.spellBar:SetHeight(db.spellheight)
    frame.spellBar:SetWidth(frame.healthBar:GetWidth())
    if db.mana then
      frame.spellBar:SetPoint("TOPLEFT",frame.manaBar,"BOTTOMLEFT",0,-1)
    else
      frame.spellBar:SetPoint("TOPLEFT",frame.healthBar,"BOTTOMLEFT",0,-1)
    end
    frame.spellBar:SetStatusBarTexture(media:Fetch('statusbar', db.texture))
    frame.spellBar:SetStatusBarColor(db.spellcolor.r,db.spellcolor.g,db.spellcolor.b,1)
    frame.spellBar:SetMinMaxValues(0, 0)
    frame.spellBar:SetValue(0)
    frame.spellBar:SetScript("OnUpdate", spellUpdate)

    frame.spellBar.bg = frame.spellBar:CreateTexture(nil, "BACKGROUND")
    frame.spellBar.bg:ClearAllPoints()
    frame.spellBar.bg:SetAllPoints(frame.spellBar)
    frame.spellBar.bg:SetTexture(media:Fetch('statusbar', db.texture))
    frame.spellBar.bg:SetVertexColor(db.spellcolor.r,db.spellcolor.g,db.spellcolor.b)
    frame.spellBar.bg:SetAlpha(0.3)

    frame.spellBar.text = frame.spellBar:CreateFontString(nil,"LOW")
    frame.spellBar.text:SetFont(media:Fetch("font", db.font), db.spellfontsize)
    frame.spellBar.text:SetShadowOffset(1, -1)
    frame.spellBar.text:SetShadowColor(0, 0, 0, 1)
    frame.spellBar.text:SetJustifyH("CENTER")
    frame.spellBar.text:SetAllPoints(frame.spellBar)

    frame.spellBar:Hide()
  end
end

function Proximo:CreateRaceIcon(frame)
  if db.race and not frame.raceicon then
    frame.raceicon = frame:CreateTexture(nil, "ARTWORK")
    frame.raceicon:ClearAllPoints()
    frame.raceicon:SetHeight(db.barheight)
    frame.raceicon:SetWidth(db.barheight)
    frame.raceicon:SetPoint("TOPRIGHT",frame,"TOPRIGHT",1,0)
  end
end

local function auraUpdate(self, elapsed)
  self.time = self.time - elapsed
  if self.time <= 0 then
    Proximo:AuraFade(self)
  else
    self.text:SetFormattedText("%d", math.ceil(self.time))
  end
end

function Proximo:CreateAuraIcon(frame)
  if db.auras and not frame.aura then
    frame.aura = CreateFrame("Frame", nil, frame)
    frame.aura:ClearAllPoints()
    frame.aura:SetHeight(db.barheight)
    frame.aura:SetWidth(db.barheight)
    frame.aura:SetPoint("TOPRIGHT",frame,"TOPRIGHT",1,0)
    frame.aura:SetScript("OnUpdate", auraUpdate)
    frame.aura:Hide()

    frame.aura.icon = frame.aura:CreateTexture(nil, "ARTWORK")
    frame.aura.icon:SetAllPoints(frame.aura)

    frame.aura.text = frame.aura:CreateFontString(nil, "OVERLAY")
    frame.aura.text:SetFont(media:Fetch("font", db.font), db.aurafontsize)
    frame.aura.text:SetTextColor(db.auracolor.r, db.auracolor.g, db.auracolor.b)
    frame.aura.text:SetShadowOffset(1,-1)
    frame.aura.text:SetPoint("CENTER")
  end
end

function Proximo:FrameClean()
  if not self.frame then return end
  --clean up all unit info
  for i=1,max_unit_size do
    if self.frame.buttons[i] then
      self.frame.buttons[i]:Hide()
      self.frame.buttons[i]:SetAttribute("macrotext1", "/script PlaySound(\"igQuestLogAbandonQuest\")")
      self.frame.buttons[i]:SetAttribute("macrotext2", "/script PlaySound(\"igQuestLogAbandonQuest\")")
      self.frame.buttons[i]:SetAttribute("macrotext3", "/script PlaySound(\"igQuestLogAbandonQuest\")")
      self.frame.buttons[i]:SetAttribute("macrotext4", "/script PlaySound(\"igQuestLogAbandonQuest\")")
      self.frame.buttons[i]:SetAttribute("macrotext5", "/script PlaySound(\"igQuestLogAbandonQuest\")")
      self.frame.buttons[i].healthBar:SetValue(0)
      self.frame.buttons[i].healthBar.bg:Hide()
      self.frame.buttons[i].healthBar.selected:Hide()
      self.frame.buttons[i].healthBar.highlight:SetBackdropBorderColor(db.highlightcolor.r,db.highlightcolor.g,db.highlightcolor.b,0)
      self.frame.buttons[i].healthtext:SetText(nil)
      self.frame.buttons[i].text:SetText(nil)
      self.frame.buttons[i].icon:SetTexture(nil)
      if self.frame.buttons[i].partytargets then
        for j=1,max_party_size do
          self.frame.buttons[i].partytargets[j]:SetValue(0)
          self.frame.buttons[i].partytargets[j]:Hide()
        end
      end
      if self.frame.buttons[i].manaBar then
        self.frame.buttons[i].manaBar:SetValue(0)
        self.frame.buttons[i].manaBar:Hide()
      end
      if self.frame.buttons[i].spellBar then
        self:SpellEnd(self.frame.buttons[i].spellBar)
      end
      if self.frame.buttons[i].raceicon then
        self.frame.buttons[i].raceicon:SetTexture(nil)
      end
      if self.frame.buttons[i].aura then
        self:AuraFade(self.frame.buttons[i].aura)
      end
    end
  end
end

function Proximo:Test()
  local server = GetRealmName()
  self:ResetList()
  self:AddToList("Perseph", server, "ROGUE", "Scourge", 3, 100, 0, "31/30/0|Assassination")
  self:AddToList("Reznic", server, "WARLOCK", "Orc", 2, 76, 53, "26/35/0|Demonology")
  self:AddToList("Suun", server, "PRIEST", "Troll", 3, 54, 24, "42/19/0|Discipline")
  self:AddToList("Alynn", server, "PALADIN", "BloodElf", 3, 21, 87, "41/20/0|Holy")
  self:AddToList("Grayhoof", server, "SHAMAN", "Tauren", 2, 59, 100, "0/42/19|Enhancement")
  self:FrameRefresh()
  if db.partytargets then
    local name, unit, button
    for i=1,max_unit_size do
      for j=1, max_party_size do
        self.frame.buttons[i].partytargets[j]:Show()
      end
    end
  end
  self:SpellTest()
end

function Proximo:SpellTest()
  if self.frame and db.spell then
    local name, unit, button
    for i=1,max_unit_size do
      self:SpellStart(i, self.title, 30)
    end
  end
end