local Proximo = Proximo
local media = LibStub("LibSharedMedia-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Proximo", true)
media:Register("statusbar", "Minimalist", "Interface\\Addons\\Proximo\\Textures\\Minimalist")

--media setup
local fonts = {}
local bars = {}
for k, v in pairs(media:List("font")) do
   fonts[v] = v
end
for k, v in pairs(media:List("statusbar")) do
   bars[v] = v
end
media.RegisterCallback(Proximo, "LibSharedMedia_Registered",
  function(event, mediatype, key)
    if mediatype == 'font' then
      fonts[key] = key
    elseif mediatype == 'statusbar' then
      bars[key] = key
    end
  end)



local defaults = {
  profile = {
    scale=1,
    x=0,
    y=0,
    framecolor = {r = 0, g = 0, b = .1, a = 1},
    manacolor = {r = .18, g = .44, b = .75, a = 1},
    highlightcolor = {r = 1, g = 1, b = 0, a = 1},
    auracolor = {r = 1, g = 1, b = 0, a = 1},
    spellcolor = {r = 1, g = 1, b = 0, a = 1},
    fontsize=16,
    aurafontsize=12,
    padding=5,
    barheight=22,
    barwidth=200,
    header=true,
    leftclick="target",
    rightclick="disable",
    mouse3click="disable",
    mouse4click="disable",
    mouse5click="disable",
    leftspellname="",
    rightspellname="",
    mouse3spellname="",
    mouse4spellname="",
    mouse5spellname="",
    texture="Minimalist",
    font="Friz Quadrata TT",
    announce="disabled",
    ma=UnitName("player"),
    sync=true,
    partytargets=true,
    partytargetheight=4,
    mana=true,
    manaheight=4,
    race=true,
    highlighttar=true,
    highlight="solid",
    lowhealth=true,
    lowhealthsound=true,
    death=true,
    deathsound=nil,
    classtext=nil,
    talents=true,
    auras=true,
    grow=nil,
    growup=nil,
    lockframe=nil,
    announceauragain=nil,
    announceaurafade=nil,
    spell=true,
    spellheight=8,
    spellfontsize=10,
    spelltime=true,
    useinbg=nil,
  }
}

--common functions for options callbacks
local function getOption(info)
  return (info.arg and Proximo.db.profile[info.arg] or Proximo.db.profile[info[#info]])
end

local function setOption(info, value)
  local key = info.arg or info[#info]
  Proximo.db.profile[key] = value
  Proximo:UpdateFrame()
end

local function getColorOption(info)
  local key = info.arg or info[#info]
  return Proximo.db.profile[key].r, Proximo.db.profile[key].g, Proximo.db.profile[key].b, Proximo.db.profile[key].a
end

local function setColorOption(info, r, g, b, a)
  local key = info.arg or info[#info]
  Proximo.db.profile[key].r, Proximo.db.profile[key].g, Proximo.db.profile[key].b, Proximo.db.profile[key].a = r, g, b, a
  Proximo:UpdateFrame()
end

local slashHandler = function(option)
  local self = Proximo
  if option == "menu" then
    self:ShowOptions()
  elseif option == "test" then
    self:ToggleFrame()
  else
    self:Print(self.version)
    self:Print("/proximo test")
    self:Print("/proximo menu")
  end
end

function Proximo:GetDefaultConfig()
  return defaults
end

function Proximo:ToggleFrame()
  if self.frame and self.frame:IsShown() then
    self:ResetList()
    self.frame:Hide()
  else
    if self.frame==nil then
      self:MakeFrame()
    end
    self.frame:Show()
    self:Test()
    self:Print(L["HelpTip"])
  end
end

function Proximo:SetupOptions()

  local clicktypes = {
    target = TARGET,
    focus = L["Focus"],
    spell = L["CastSpell"],
    macro = MACRO,
    disable = ADDON_DISABLED,
  }

  self.options = {
    type="group",
    icon = "Interface\\PVPFrame\\PVP-ArenaPoints-Icon",
    name = "Proximo",
    childGroups = "tab",
    plugins = {},
    args = {
      frame = {
        type="group",
        name=L["Frame"],
        desc=L["Frame"],
        order=1,
        childGroups="tab",
        args = {
          colors = {
            type="group",
            name=L["Colors"],
            desc=L["Colors"],
            order=1,
            args = {
              framecolor = {
                type="color",
                name=L["FrameColor"],
                desc=L["FrameColor"],
                get=getColorOption,
                set=setColorOption,
                hasAlpha=true,
                order=1,
              },
              manacolor = {
                type="color",
                name=L["ManaColor"],
                desc=L["ManaColor"],
                get=getColorOption,
                set=setColorOption,
                hasAlpha=false,
                order=2,
              },
              spellcolor = {
                type="color",
                name=L["SpellColor"],
                desc=L["SpellColor"],
                get=getColorOption,
                set=setColorOption,
                hasAlpha=false,
                order=3,
              },
              highlightcolor = {
                type="color",
                name=L["HighlightColor"],
                desc=L["HighlightColor"],
                get=getColorOption,
                set=setColorOption,
                hasAlpha=false,
                order=4,
              },
              auracolor = {
                type="color",
                name=L["AuraColor"],
                desc=L["AuraColor"],
                get=getColorOption,
                set=setColorOption,
                hasAlpha=false,
                order=5,
                disabled = function() return not self.db.profile.auras end,
              },
            },
          },
          fonts = {
            type="group",
            name=L["Text"],
            order=2,
            args = {
              fontsize = {
                type="range",
                name=L["FontSize"],
                desc=L["FontSize"],
                get=getOption,
                set=setOption,
                min=8,
                max=36,
                step=1,
                order=1,
              },
              aurafontsize = {
                type="range",
                name=L["AuraFontSize"],
                desc=L["AuraFontSize"],
                get=getOption,
                set=setOption,
                min=8,
                max=36,
                step=1,
                order=2,
                disabled = function() return not self.db.profile.auras end,
              },
              spellfontsize = {
                type="range",
                name=L["SpellFontSize"],
                desc=L["SpellFontSize"],
                get=getOption,
                set=setOption,
                min=8,
                max=36,
                step=1,
                order=3,
                disabled = function() return not self.db.profile.spell end,
              },
              font = {
                type = "select",
                name = L["Font"],
                desc = L["Font"],
                dialogControl = 'LSM30_Font',
                --values = media:List('font'),
                values = fonts,
                get=function(info)
                  --local mt = media:List('font')
                  --for k,v in pairs(mt) do
                  --  if v==self.db.profile.font then
                  --    return k
                  --  end
                  --end
                  return fonts[self.db.profile.font]
                end,
                set=function(info,v)
                  --local mt = media:List('font')
                  --self.db.profile.font = mt[v]
                  self.db.profile.font=fonts[v]
                  self:UpdateFrame()
                end,
                order=4,
              },
            },
          },
          bars = {
            type="group",
            name=L["Bars"],
            order=3,
            args = {
              barwidth = {
                type="range",
                name=L["BarWidth"],
                desc=L["BarWidth"],
                get=getOption,
                set=setOption,
                min=100,
                max=500,
                step=5,
                order=1,
              },
              barheight = {
                type="range",
                name=L["BarHeight"],
                desc=L["BarHeight"],
                get=getOption,
                set=setOption,
                min=10,
                max=40,
                step=1,
                order=2,
              },
              texture = {
                type = "select",
                name = L["BarTexture"],
                desc = L["BarTexture"],
                dialogControl = 'LSM30_Statusbar',
                --values = media:List('statusbar'),
                values = bars,
                get=function(info)
                  --local mt = media:List('statusbar')
                  --for k,v in pairs(mt) do
                  --  if v==self.db.profile.texture then
                  --    return k
                  --  end
                  --end
                  return bars[self.db.profile.texture]
                end,
                set=function(info,v)
                  --local mt = media:List('statusbar')
                  --self.db.profile.texture = mt[v]
                  self.db.profile.texture = bars[v]
                  self:UpdateFrame()
                end,
                order=3,
              },
              padding = {
                type="range",
                name=L["Padding"],
                desc=L["Padding"],
                get=getOption,
                set=setOption,
                min=1,
                max=30,
                step=1,
                order=4,
              },
              scale = {
                type="range",
                name=L["Scale"],
                desc=L["Scale"],
                get=getOption,
                set=setOption,
                min=0.1,
                max=3,
                step=0.1,
                order=5,
              },
            },
          },
          extrabars = {
            type="group",
            name=L["ExtraBars"],
            order=4,
            args = {
              partytargets = {
                type='toggle',
                name=L["PartyTargets"],
                desc=L["PartyTargets"],
                get=getOption,
                set=setOption,
                order=1,
              },
              partytargetheight = {
                type="range",
                name=L["PartyTargetsHeight"],
                desc=L["PartyTargetsHeight"],
                get=getOption,
                set=setOption,
                min=2,
                max=20,
                step=1,
                order=2,
                disabled = function() return not self.db.profile.partytargets end,
              },
              header1 = {
                type='header',
                name="",
                order=3,
              },
              mana = {
                type='toggle',
                name=L["Mana"],
                desc=L["Mana"],
                get=getOption,
                set=setOption,
                order=4,
              },
              manaheight = {
                type="range",
                name=L["ManaHeight"],
                desc=L["ManaHeight"],
                get=getOption,
                set=setOption,
                min=2,
                max=20,
                step=1,
                order=5,
                disabled = function() return not self.db.profile.mana end,
              },
              header2 = {
                type='header',
                name="",
                order=6,
              },
              spell = {
                type='toggle',
                name=L["Spell"],
                desc=L["Spell"],
                get=getOption,
                set=setOption,
                order=7,
              },
              spellheight = {
                type="range",
                name=L["SpellHeight"],
                desc=L["SpellHeight"],
                get=getOption,
                set=setOption,
                min=2,
                max=20,
                step=1,
                order=8,
                disabled = function() return not self.db.profile.spell end,
              },
              spelltime = {
                type='toggle',
                name=L["SpellTime"],
                desc=L["SpellTime"],
                get=getOption,
                set=setOption,
                order=9,
              },
              header3 = {
                type='header',
                name="",
                order=10,
              },
              highlighttarget = {
                type='toggle',
                name=L["HighlightTarget"],
                desc=L["HighlightTarget"],
                get=getOption,
                set=setOption,
                order=11,
              },
              highlight = {
                type="select",
                name=L["Highlight"],
                desc=L["Highlight"],
                get=getOption,
                set=setOption,
                values = {
                  solid = L["HighlightSolid"],
                  tooltip = L["HighlightTooltip"],
                },
                order=12,
              },
            },
          },
          optional = {
            type="group",
            name=L["Optional"],
            order=5,
            args = {
              header = {
                type='toggle',
                name=L["Header"],
                desc=L["Header"],
                get=getOption,
                set=setOption,
                order=1,
              },
              lockframe = {
                type='toggle',
                name=L["LockFrame"],
                desc=L["LockFrame"],
                get=getOption,
                set=setOption,
                order=2,
              },
              grow = {
                type='toggle',
                name=L["GrowFrame"],
                desc=L["GrowFrameDesc"],
                get=getOption,
                set=setOption,
                order=3,
              },
              growup = {
                type='toggle',
                name=L["GrowUp"],
                desc=L["GrowUp"],
                get=getOption,
                set=function(info,v)
                  self.db.profile.growup = v
                  local x, y = self.frame:GetLeft(),  self.db.profile.growup and self.frame:GetBottom() or self.frame:GetTop()
                  local es = self.frame:GetEffectiveScale()
                  local ps = UIParent:GetScale()
                  x = x*es - GetScreenWidth()*ps/2
                  y = y*es - GetScreenHeight()*ps/2
                  self.db.profile.x, self.db.profile.y = x, y
                  self:UpdateFrame()
                end,
                order=4,
                disabled = function() return not self.db.profile.grow end,
              },
              sync = {
                type='toggle',
                name=L["Sync"],
                desc=L["SyncDesc"],
                get=getOption,
                set=setOption,
                order=5,
              },
              race = {
                type='toggle',
                name=L["Race"],
                desc=L["Race"],
                get=getOption,
                set=setOption,
                order=6,
              },
              auras = {
                type='toggle',
                name=L["AurasIcon"],
                desc=L["AurasDesc"],
                get=getOption,
                set=setOption,
                order=7,
              },
              classtext = {
                type='toggle',
                name=L["ClassText"],
                desc=L["ClassText"],
                get=getOption,
                set=setOption,
                order=8,
              },
              talents = {
                type='toggle',
                name=L["Talents"],
                desc=L["Talents"],
                get=getOption,
                set=setOption,
                order=9,
              },
              useinbg = {
                type='toggle',
                name=L["UseInBG"],
                desc=L["UseInBG"],
                get=getOption,
                set=setOption,
                order=10,
              },
            },
          },
        },
      },
      clicks = {
        type="group",
        name=L["Clicks"],
        order=2,
        args = {
          leftclick = {
            type = "select",
            name = L["LeftClick"],
            desc = L["LeftClick"],
            get = getOption,
            set = setOption,
            values = clicktypes,
            order = 1,
          },
          leftspellname = {
            type = "input",
            name = L["CastSpellName"],
            desc = L["CastSpellNameDesc"],
            usage = "<spellname>",
            get=getOption,
            set=setOption,
            disabled = function() return self.db.profile.leftclick ~= "spell" and self.db.profile.leftclick ~= "macro" end,
            order=2,
          },
          rightclick = {
            type = "select",
            name = L["RightClick"],
            desc = L["RightClick"],
            get = getOption,
            set = setOption,
            values = clicktypes,
            order = 3,
          },
          rightspellname = {
            type = 'input',
            name = L["CastSpellName"],
            desc = L["CastSpellNameDesc"],
            usage = "<spellname>",
            get=getOption,
            set=setOption,
            disabled = function() return self.db.profile.rightclick ~= "spell" and self.db.profile.rightclick ~= "macro" end,
            order=4,
          },
          mouse3click = {
            type = "select",
            name = L["Mouse3Click"],
            desc = L["Mouse3Click"],
            get = getOption,
            set = setOption,
            values = clicktypes,
            order = 5,
          },
          mouse3spellname = {
            type = 'input',
            name = L["CastSpellName"],
            desc = L["CastSpellNameDesc"],
            usage = "<spellname>",
            get=getOption,
            set=setOption,
            disabled = function() return self.db.profile.mouse3click ~= "spell" and self.db.profile.mouse3click ~= "macro" end,
            order=6,
          },
          mouse4click = {
            type = "select",
            name = L["Mouse4Click"],
            desc = L["Mouse4Click"],
            get = getOption,
            set = setOption,
            values = clicktypes,
            order = 7,
          },
          mouse4spellname = {
            type = 'input',
            name = L["CastSpellName"],
            desc = L["CastSpellNameDesc"],
            usage = "<spellname>",
            get=getOption,
            set=setOption,
            disabled = function() return self.db.profile.mouse4click ~= "spell" and self.db.profile.mouse4click ~= "macro" end,
            order=8,
          },
          mouse5click = {
            type = "select",
            name = L["Mouse5Click"],
            desc = L["Mouse5Click"],
            get = getOption,
            set = setOption,
            values = clicktypes,
            order = 9,
          },
          mouse5spellname = {
            type = 'input',
            name = L["CastSpellName"],
            desc = L["CastSpellNameDesc"],
            usage = "<spellname>",
            get=getOption,
            set=setOption,
            disabled = function() return self.db.profile.mouse5click ~= "spell" and self.db.profile.mouse5click ~= "macro" end,
            order=10,
          },
        },
      },
      annoucements = {
        type="group",
        name=L["Announce"],
        order=3,
        args = {
          lowhealth = {
            type='toggle',
            name=L["LowHealth"],
            desc=L["LowHealthDesc"],
            get=getOption,
            set=setOption,
            order=1,
          },
          lowhealthsound = {
            type='toggle',
            name=L["LowHealthSound"],
            desc=L["LowHealthSound"],
            get=getOption,
            set=setOption,
            order=2,
            disabled = function() return not self.db.profile.lowhealth end,
          },
          death = {
            type='toggle',
            name=L["Death"],
            desc=L["DeathDesc"],
            get=getOption,
            set=setOption,
            order=3,
          },
          deathsound = {
            type='toggle',
            name=L["DeathSound"],
            desc=L["DeathSound"],
            get=getOption,
            set=setOption,
            order=4,
            disabled = function() return not self.db.profile.death end,
          },
          announceauragain = {
            type='toggle',
            name=L["AuraGain"],
            desc=L["AuraGain"],
            get=getOption,
            set=setOption,
            order=5,
            disabled = function() return not self.db.profile.auras end,
          },
          announceaurafade = {
            type='toggle',
            name=L["AuraFade"],
            desc=L["AuraFade"],
            get=getOption,
            set=setOption,
            order=6,
            disabled = function() return not self.db.profile.auras end,
          },
          announce = {
            type = "select",
            name = L["AnnounceLoc"],
            desc = L["AnnounceLoc"],
            get = getOption,
            set = setOption,
            values = {
              chat = CHAT_LABEL,
              raid = CHAT_MSG_RAID_WARNING,
              sct = "SCT",
              msbt = "MSBT",
              fct = "FCT (Blizzard)",
              party = PARTY,
              disabled = L["Disabled"],
            },
            order=7,
          },
        },
      },
      commands = {
        type="group",
        name=L["Commands"],
        desc=L["Commands"],
        order=5,
        args = {
          menu = {
            name = L["Menu"], type = 'execute',
            desc = L["Menu"],
            order = 1,
            guiHidden = true,
            func = function()
                if not InCombatLockdown() then self:ShowOptions() end
            end
          },
          ma = {
            type = "input",
            name = L["MainAssist"],
            desc = L["MainAssist"],
            usage = "<name>",
            width="double",
            get=getOption,
            set=function(info,v) self.db.profile.ma = v
              self:SetMainAssist(v)
              self:SendProxComm("ReceiveMainAssist:"..v)
              self:Print(L["MainAssist"]..": "..v)
            end,
            order=2,
          },
          version = {
            name = L["VersionCheck"], type = 'execute',
            desc = L["VersionCheck"],
            order = 3,
            func = function()
                self:Print(L["VersionCheckDesc"])
                self:SendProxComm("ReceiveVersion:version")
            end
          },
          test = {
            type='execute',
            name=L["Test"],
            desc=L["TestDesc"],
            func = function()
              self:ToggleFrame()
            end,
            order=4,
          },
          spelltest = {
            type='execute',
            name=L["SpellTest"],
            desc=L["SpellTest"],
            func = function()
              self:SpellTest()
            end,
            order=5,
            disabled = function() return not self.db.profile.spell end,
          },
          resetframe = {
            name = L["ResetFrame"], type = 'execute',
            desc = L["ResetFrame"],
            order = 6,
            func = function()
              self.db.profile.x, self.db.profile.y = 0, 0
              self:UpdateFrame()
            end
          },
        }
      }
    }
  }

  self.options.plugins.profiles = { profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db) }
  LibStub("AceConfig-3.0"):RegisterOptionsTable("Proximo", self.options)
  LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Proximo", "Proximo")
  self:RegisterChatCommand("prox", slashHandler)
  self:RegisterChatCommand("proximo", slashHandler)
end

function Proximo:ShowOptions()
  --LibStub("AceConfigDialog-3.0"):Open("Proximo")
  InterfaceOptionsFrame_OpenToCategory("Proximo")
end


