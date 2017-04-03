local Gladius = Gladius
local self = Gladius
local LSM = LibStub("LibSharedMedia-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Gladius", true)
LSM:Register("statusbar", "Minimalist", "Interface\\Addons\\Gladius\\images\\Minimalist")

local sounds = AceGUIWidgetLSMlists.sound
sounds[L["Disabled"]] = "disabled"

local spellCache

local defaults = {
	profile = {
	   x=0,
		y=0,
		frameScale = 1,
		barWidth=150,
		barHeight=25,
		manaBarHeight=15,
		castBarHeight=12,
		petBarHeight=15,
		petBarWidth=150,
		padding=5,
		frameColor = {r = 0, g = 0, b = 0, a = .3},
		manaColor = {r = .18, g = .44, b = .75, a = 1},
		energyColor = {r = 1, g = 1, b = 0, a = 1},
		rageColor = {r = 1, g = 0, b = 0, a = 1},
		rpColor = {r = 0, g = 0.82, b = 1, a = 1},
		selectedFrameColor = {r = 1, g = .7, b = 0, a = 1},
		focusBorderColor = {r = 1, g = 0, b = 0, a = 1},
		assistBorderColor = {r = 0, g = 1, b = 0, a = 1},
		castBarColor = {r = 1, g = 1, b = 0, a = 1},
		manaFontColor = {r = 2.55, g = 2.55, b = 2.55, a = 1},
		healthFontColor = {r = 2.55, g = 2.55, b = 2.55, a = 1},
		castBarFontColor = {r = 2.55, g = 2.55, b = 2.55, a = 1},
		petBarFontColor = {r = 2.55, g = 2.55, b = 2.55, a = 1},
		auraFontColor = {r = 0, g = 1, b = 0, a = 1},
		debuffFontColor = {r = 0, g = 1, b = 0, a = 1},
		drFontColor = {r = 0, g = 1, b = 0, a = 1},
		healthColor = {r = 0.20, g = 0.90, b = 0.20, a = 1},
		healthBarColor = {r = 0.95, g = 0.95, b = 0.95, a = 1},
		castBarBgColor = {r = 1, g = 1, b = 1, a = 0.3},
		healthBarClassColor = true,
		healthFontSize = 11,
		manaFontSize = 10,
		castBarFontSize = 9,
		castBarWidth = 150,
		castBarPos = "CENTER",
		petFontSize = 9,
		auraFontSize = 16,
		drFontSize = 13,
		healthFont = "Friz Quadrata TT",
      manaFont = "Friz Quadrata TT",
      castBarFont = "Friz Quadrata TT",
      petBarFont = "Friz Quadrata TT",
      auraFont = "Friz Quadrata TT",
      debuffFont = "Friz Quadrata TT",
      drFont = "Friz Quadrata TT",
		barTexture = "Minimalist",
		barBottomMargin = 8,
		highlight = true,
		selectedBorder = true,
		focusBorder = true,
		assistBorder = true,
		manaDefault = false,
		energyDefault = false,
		rageDefault = false,
		rpDefault = false,
		locked=false,
		manaText=true,
		manaPercentage=false,
		manaActual=true,
		manaMax=true,
		healthPercentage=true,
		healthActual=false,
		healthMax=false,
		shortHpMana=true,
		frameResize=true,
		classText=false,
		raceText=true,
		specText=true,
		castBar=true,
		powerBar=true,
		classIcon=true,
		targetIcon=false,
		trinketStatus=true,
		prodSpecial=false,
		displayAuras=true,
		frameResize=true,
		enemyAnnounce=false,
		specAnnounce=false,
		trinketUpAnnounce=false,
		trinketUsedAnnounce=false,
		lowHealthAnnounce=false,
		lowHealthPercentage=30,
		drinkAnnounce=false,
		resAnnounce=false,
		auraAnnounce=false,
		auraAnnounceList={},
		growUp=false,
		cliqueSupport=false,
		showPets=false,
		showPetType=true,
		showPetHealth=true,
		trinketDisplay="nameIcon",
		bigTrinketScale=1,
		announceType="party",
		attributes = {
			{ name = "Target", button = "1", modifier = "", action = "target", spell = ""},
			{ name = "Focus", button = "2", modifier = "", action = "focus", spell = ""},
		},
		auras = {},
		auraPos = "LEFT",
		enableDebuffs = false,
		debuffHiddenStyle = "alpha",
		debuffFontSize = 13,
		debuffPos = "RIGHT",
		debuffs = {},
		cooldown = false,
		cooldownPos = "RIGHT",
		cooldownAnnounce = false,
		cooldownAnnounceList = {},
		cooldownList = {},
		cooldownSoundList = {},
		drCooldown = false,
		drCooldownPos = "LEFT",
		drCooldownAnchor = "CENTER",
		drMargin = 5,
		drIconSize = 30,
		drIconAdjust = true,
		drNoCooldownCount = false,
		drText = true,
		drList = {},
	}
}

-- insert the auralist to the defaults
for k, v in pairs(Gladius:GetAuraList()) do
	table.insert(defaults.profile.auras, { name = k, priority = v, deleted = false })
end

-- setup  the default attributes 3-10
for i=3, 10 do
	table.insert(defaults.profile.attributes, {name = string.format(L["Action #%d"], i), modifier = "", button = "", action = "disabled", spell = ""})
end

-- debuffs
for i=1, 4 do
	table.insert(defaults.profile.debuffs, {id="", name=""})
end

--LSM statusbars
local statusbars = {}

for _, name in pairs(LSM:List(LSM.MediaType.STATUSBAR)) do
	statusbars[name] = name
end

local function slashHandler(option)
	-- Mayhaps use Ace to handle slash command? It leaves something to be desired, methinks. -kremonted
	option = string.lower(option)
	
	if option == "ui" or option == "config" or option == "options" then
		Gladius:ShowOptions()
	elseif option == "test1" then
		self:ToggleFrame(1)
	elseif option == "test2" then
		self:ToggleFrame(2)
	elseif option == "test3" then
		self:ToggleFrame(3)
	elseif option == "test4" then
		self:ToggleFrame(4)
	elseif option == "test5" or option == "test" then
		self:ToggleFrame(5)
	elseif option == "hide" then
		self:HideFrame()
	elseif option == "trinket" then
		Gladius:TrinketUsed("arena1",120)
	else
		self:Print(L["Valid slash commands are:"])
		self:Print(L["/gladius ui"])
		self:Print(L["/gladius test1-5"])
		self:Print(L["/gladius hide"])
	end
end

function Gladius:ToggleFrame(i)
	self:ClearAllUnits()
	if (self.frame and self.frame:IsShown() and i == self.currentBracket) then
		self:UnregisterAllEvents()
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA")
		self.frame:Hide()
		self.frame.testing = false
	else
		self.currentBracket = i
		if ( not self.frame ) then
			self:CreateFrame()
		end
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:RegisterEvent("PLAYER_FOCUS_CHANGED")
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		self:RegisterEvent("UNIT_PET")
		self:RegisterEvent("UNIT_NAME_UPDATE")
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		self:RegisterEvent("UNIT_AURA")
		self.frame:Show()
		self.frame.testing = true
		self:Test()
		self:UpdateFrame()
		Gladius:UpdateBindings()
	end
end

function Gladius:HideFrame()
	if ( self.frame ) then
		self.frame:Hide()
		self.frame.testing = false
	end
	self:UnregisterAllEvents()
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA")
	self.currentBracket = nil
end

-- General Get/Set etc
local function getOption(info)
  return (info.arg and Gladius.db.profile[info.arg] or Gladius.db.profile[info[#info]])
end

local function setOption(info, value)
  local key = info.arg or info[#info]
  Gladius.db.profile[key] = value
  Gladius:UpdateFrame()
end

local function getColorOption(info)
  local key = info.arg or info[#info]
  return Gladius.db.profile[key].r, Gladius.db.profile[key].g, Gladius.db.profile[key].b, Gladius.db.profile[key].a
end

local function setColorOption(info, r, g, b, a)
  local key = info.arg or info[#info]
  Gladius.db.profile[key].r, Gladius.db.profile[key].g, Gladius.db.profile[key].b, Gladius.db.profile[key].a = r, g, b, a
  Gladius:UpdateFrame()
end

function Gladius:getDefaults()
	return defaults
end

-- Get/set for auras
local function setAura(info, value)
	Gladius.db.profile.auras[tonumber(info[#(info) - 1])][info[(#info)]] = value

	if ( info[#(info)] == "name" ) then
		self.options.args.auras.args.list.args[info[#(info) - 1]].name = value 
	end

	Gladius:ConvertAuraList()
	Gladius:UpdateFrame()
end

local function getAura(info)
	return Gladius.db.profile.auras[tonumber(info[#(info) - 1])][info[(#info)]]
end

-- Get/set for attributes, credits to Shadowed (SSAF)
local function setAttribute(info, value)
	Gladius.db.profile.attributes[tonumber(info[#(info) - 1])][info[(#info)]] = value

	if ( info[#(info)] == "name" ) then 
		self.options.args.clicks.args[info[#(info) - 1]].name = value 
	end

	Gladius:UpdateFrame()
end

local function getAttribute(info)
	return Gladius.db.profile.attributes[tonumber(info[#(info) - 1])][info[(#info)]]
end

local function CacheSpells()
	if(spellCache) then return end
	spellCache = {}
	for id=65000,1,-1 do
		local name = GetSpellInfo(id)
		if(name) then
			spellCache[string.lower(name)] = id
		end
	end
end

local function GetSpellID(spell)
	CacheSpells()
	spell = string.lower(spell)
	id = spellCache[spell]
	if(id) then
		return id
	end
end

--Validate a spell id, credits to SpellAlerter
local function ValidateSpellInfo(info,value)
	local spellid = tonumber(value)
	local exists = false
	if value == "" or (type(spellid) == "number" and GetSpellInfo(spellid)) then
		exists = true
	else
		if(GetSpellID(value)) then
			exists = true
		end
	end
	return exists and true or L["Invalid spell name/spell id"]
end

-- Value tables for attributes
local modifiers = {[""] = L["None"], ["ctrl-"] = L["CTRL"], ["shift-"] = L["SHIFT"], ["alt-"] = L["ALT"]}
local buttons = {["1"] = L["Left button"], ["2"] = L["Right button"], ["3"] = L["Middle button"], ["4"] = L["Button 4"], ["5"] = L["Button 5"]}
local clickValues = {["macro"] = MACRO, ["target"] = TARGET, ["focus"] = FOCUS, ["spell"] = L["Cast Spell"], ["disabled"] = ADDON_DISABLED}

local auraAnnounceValues = {
   ["disabled"] = L["Disabled"],
   ["self"] = L["Self"],
   ["party"] = L["Party"],
   ["say"] = L["Say"],
   ["rw"] = L["Raid Warning"],
   ["sct"] = L["Scrolling Combat Text"],
   ["msbt"] = L["MikScrollingBattleText"],
   ["fct"] = L["Blizzard's Floating Combat Text"],
   ["parrot"] = L["Parrot"],
}

local announceValues = {
   ["self"] = L["Self"],
   ["party"] = L["Party"],
   ["say"] = L["Say"],
   ["rw"] = L["Raid Warning"],
   ["sct"] = L["Scrolling Combat Text"],
   ["msbt"] = L["MikScrollingBattleText"],
   ["fct"] = L["Blizzard's Floating Combat Text"],
   ["parrot"] = L["Parrot"],
}

-- Setup an attribute in the options
local function SetupAttributeOption(number)
	local attribute = {
		order = number,
		type = "group",
		name = self.db.profile.attributes[number].name,
		desc = self.db.profile.attributes[number].name,
		get = getAttribute,
		set = setAttribute,
		args = {
			name = {
				type = "input",
				name = L["Name"],
				desc = L["Select the name of the click option"],
				order=1,
			},
			button = {
				type = "select",
				name = L["Button"],
				desc = L["Select which mouse button to use"],
				values=buttons,
				order=2,
			},
			modifier = {
				type = "select",
				name = L["Modifier"],
				desc = L["Select which modifier to use"],
				values = modifiers,
				order=3,
			},
			action = {
				type = "select",
				name = L["Action"],
				desc = L["Select what action this mouse button does"],
				values=clickValues,
				order=4,
			},
			spell = {
				type = "input",
				multiline = true,
				name = L["Spell name / Macro text"],
				desc = L["Spell name / Macro text"],
				order=5,
			},
		},
	}
	
	return attribute
end

local function SetupAuraOption(number)
	local aura = {
		type = "group",
		name = self.db.profile.auras[number].name,
		desc = self.db.profile.auras[number].name,
		get = getAura,
		set = setAura,
		args = {
			name = {
				type = "input",
				name = L["Name"],
				desc = L["Name of the aura"],
				order=1,
			},
			priority = {
				type= "range",
				name = L["Priority"],
				desc = L["Select what priority the aura should have - higher equals more priority"],
				min=0,
				max=5,
				step=1,
				order=2,
			},
			announceType = {
            type = "select",
            name = L["Announcement type"],
            desc = L["Where to display the announcement messages"],
            get=function(info) 
               local name = self.options.args.auras.args.list.args[info[#(info) - 1]].name
               return self.db.profile.auraAnnounceList[name] == nil and "disabled" or self.db.profile.auraAnnounceList[name] 
            end,
            set=function(info, value)
               local name = self.options.args.auras.args.list.args[info[#(info) - 1]].name               
               self.db.profile.auraAnnounceList[name] = value
               
               Gladius:ConvertAuraList()
               Gladius:UpdateFrame()
            end,
            values=auraAnnounceValues,
            order=3,
			},
			delete = {
				type = "execute",
				name = L["Delete"],
				func = function(info)
				
					local defaultAuras = Gladius:GetAuraList()
					local name = self.db.profile.auras[tonumber(info[#(info) - 1])].name
					self.db.profile.auraAnnounceList[name] = nil
					
					-- check if it's a default aura, thus it can't really get deleted and it'll just set the deleted variable to true instead
					if ( defaultAuras[name] ) then
						self.db.profile.auras[tonumber(info[#(info) - 1])].deleted = true
					else
						table.remove(self.db.profile.auras, tonumber(info[#(info) - 1]))
					end
					
					self.options.args.auras.args.list.args = {}
					for i=#(self.db.profile.auras), 1, -1 do
						if ( not self.db.profile.auras[i].deleted ) then
							self.options.args.auras.args.list.args[tostring(i)] = SetupAuraOption(i)
						end
					end
					
					Gladius:ConvertAuraList()
				end,
			},
		},
	}
	return aura
end

function Gladius:SetupOptions()

	local newAuraPrio = 3
	local newAuraName = "Aura name"
	local newAuraAnnounce = "disabled"
	
	local trinketValues = {
		["nameText"] = L["Name text"],
		["nameIcon"] = L["Name icon"],
		["bigIcon"] = L["Big icon"],
		["overrideIcon"] = L["Override class/aura icon"],
		["smallIcon"] = L["Small icon"],
		["gridIcon"] = L["Grid-style icon"],
	}
	
	self.options = {
		type = "group",
		name = "Gladius",
		plugins = {},
		get=getOption,
		set=setOption,
		args = {
			general = {
				type="group",
				name=L["General"],
				desc=L["General settings"],
				order=1,
				args = {
					locked = {
						type="toggle",
						name=L["Lock frame"],
						desc=L["Toggle if the frame can be moved"],
						order=5,
					},
					growUp = {
						type="toggle",
						name=L["Grow frame upwards"],
						desc=L["If this is toggled the frame will grow upwards instead of downwards."],
						order=7,
					},
					frameResize = {
						type="toggle",
						name=L["Frame resize"],
						desc=L["If this is enabled the frame will automaticly get resized to the appropriate size every time you enter an arena"],
						order=10,
					},
					frameScale = {
						type="range",
						name=L["Frame scale"],
						desc=L["Scale of the frame"],
						min=.1,
						max=2,
						step=.1,
						order=20,
					},
					padding = {
						type="range",
						name=L["Frame padding"],
						desc=L["Padding of the frame"],
						min=0,
						max=20,
						step=1,
						order=30,
					},
					frameColor = {
						type="color",
						name=L["Frame color"],
						desc=L["Color of the frame"],
						hasAlpha=true,
						order=35,
						get=getColorOption,
						set=setColorOption,
					},			
					highlight = {
						type="toggle",
						name=L["Highlight target"],
						desc=L["Toggle if the selected target should be highlighted"],
						order=80,
					},
					selectedBorder = {
						type="toggle",
						name=L["Show border around target"],
						desc=L["Toggle if a border should be shown around the selected target"],
						order=90,
					},
					focusBorder = {
						type="toggle",
						name=L["Show border around focus"],
						desc=L["Toggle if a border should be shown around your current focus"],
						order=91,
					},
					assistBorder = {
						type="toggle",
						name=L["Show border around main assist"],
						desc=L["Toggle if a border should be shown around your current main assist target"],
						order=92,
					},
					classIcon = {
						type="toggle",
						name=L["Show class icon"],
						desc=L["Show class icon\nIMPORTANT:\nToggling this off will disable showing auras even if it is enabled"],
						order=95,
					},
					targetIcon = {
						type="toggle",
						name=L["Show target icon"],
						desc=L["Show target icon"],
						order=97,
					},					
					cliqueSupport = {
						type="toggle",
						name=L["Clique support"],
						desc=L["Toggles the Clique support, requires UI reload to take effect"],					
						order=100,
					},
					announcements = {
						type="group",
						name=L["Announcements"],
						order=1,
						desc=L["Set options for different announcements"],
						args = {
							announceType = {
								type = "select",
								name = L["Announcement type"],
								desc = L["Where to display the announcement messages"],
								values=announceValues,
								order=5,
							},
							enemyAnnounce = {
								type="toggle",
								name=L["New enemies"],
								desc=L["Announce new enemies found"],
								order=10,
							},
							specAnnounce = {
								type="toggle",
								name=L["Talent spec detection"],
								desc=L["Announce when an enemy's talent spec is discovered"],
								order=11,
							},
							drinkAnnounce = {
								type="toggle",
								name=L["Drinking"],
								desc=L["Announces enemies that start to drink"],
								order=12,
							},
							resAnnounce = {
								type="toggle",
								name=L["Resurrections"],
								desc=L["Announces enemies who starts to cast a resurrection spell"],
								order=13,
							},
							auraAnnounce = {
								type="toggle",
								name=L["Aura"],
								desc=L["Announces enemies who gain an aura"],
								order=14,
							},
							trinketUsedAnnounce = {
								type="toggle",
								name=L["Trinket used"],
								desc=L["Announce when an enemy's trinket is used"],
								order=20,
							},
							trinketUpAnnounce = {
								type="toggle",
								name=L["Trinket ready"],
								desc=L["Announce when an enemy's trinket is ready again"],
								order=30,
							},
							cooldownAnnounce = {
								type="toggle",
								name=L["Cooldown"],
								desc=L["Announce when an enemy is using a cooldown"],
								order=35,
							},
							lowHealthAnnounce = {
								type="toggle",
								name=L["Enemies on low health"],
								desc=L["Announce enemies that go below a certain percentage of health"],
								order=40,
							},
							lowHealthPercentage = {
								type="range",
								name=L["Low health percentage"],
								desc=L["The percentage when enemies are counted as having low health"],
								min=1,
								max=100,
								step=1,
								disabled = function() return not self.db.profile.lowHealthAnnounce end,						
								order=50,
							},							
						},
					},
					trinket = {
						type="group",
						order=2,
						name=L["Trinket display"],
						desc=L["Set options for the trinket status display"],
						args = {
							trinketStatus = {
								type="toggle",
								name=L["Show PvP trinket status"],
								desc=L["Show PvP trinket status to the right of the enemy name"],
								order=10,
							},
							trinketDisplay = {
								type = "select",
								name = L["Trinket display"],
								desc = L["Choose how to display the trinket status"],
								values=trinketValues,
								disabled = function() return not self.db.profile.trinketStatus end,
								order=20,
							},
							bigTrinketScale = {
								type="range",
								name=L["Big icon scale"],
								desc=L["The scale of the big trinket icon"],
								min=.1,
								max=2,
								step=.1,
								disabled = function() return not self.db.profile.trinketStatus or self.db.profile.trinketDisplay ~= "bigIcon" end,						
								order=30,
							},
						},
					},
					debuffs = {
						type = "group",
						order = 3,
						name = "Debuff tracker",
						args = {
							enableDebuffs = {
								type="toggle",
								name=L["Enable the debuff tracker"],
								desc=L["Enable the debuff tracker"],
								order=1,
							},
							debuffPos = {
								type="select",
								name=L["Debuff position"],
								desc=L["Position of the debuff icons"],
								values = {
									["RIGHT"] = L["Right"],
									["LEFT"] = L["Left"],
								},
								order=2,
							},
							debuffHiddenStyle = {
								type="select",
								name=L["Hidden style"],
								desc=L["Choose how the debuff icon is displayed when it's not currently on the enemy."],
								values = {
									["alpha"] = L["Opacity 25%"],
									["hidden"] = L["Hidden"],
									["desat"] = L["Desaturated (grayscale)"],
								},
								order=3,
							},		
						},
					},
				},
			},
			bars = {
				type="group",
				name=L["Bars"],
				desc=L["Bar settings"],
				order=2,
				args = {
					castBarPos = {
                  type="select",
                  name=L["Cast bar position"],
                  desc=L["Position of the cast bar"],
                  values = {
                     ["CENTER"] = L["Center"],
                     ["RIGHT"] = L["Right"],
                     ["LEFT"] = L["Left"],
                  },
                  order=2,
               },
					castBar = {
						type="toggle",
						name=L["Show cast bars"],
						desc=L["Show cast bars"],
						order=1,
					},
					showPets = {
						type="toggle",
						name=L["Show pet bars"],
						desc=L["Show pet bars"],
						order=11,
					},
					powerBar = {
						type="toggle",
						name=L["Show power bars"],
						desc=L["Show power bars"],
						order=20,
					},
					barsizes = {
						type="group",
						name=L["Size and margin"],
						desc=L["Size and margin settings"],
						order=1,
						args = {
							barWidth = {
								type="range",
								name=L["Bar width"],
								desc=L["Width of the health and power bars"],
								min=20,
								max=500,
								step=5,
								order=2,
								},
							barHeight = {
								type="range",
								name=L["Health bar height"],
								desc=L["Height of the health bars"],
								min=5,
								max=50,
								step=1,
								order=3,
							},
							petBarWidth = {
								type="range",
								name=L["Pet bar width"],
								desc=L["Width of the pet bars"],
								disabled = function() return not self.db.profile.showPets end,
								min=20,
								max=500,
								step=1,
								order=4,
							},
							petBarHeight = {
								type="range",
								name=L["Pet bar height"],
								desc=L["Height of the pet bars"],
								disabled = function() return not self.db.profile.showPets end,
								min=5,
								max=50,
								step=1,
								order=4,
							},							
							castBarHeight = {
								type="range",
								name=L["Cast bar height"],
								desc=L["Height of the cast bars"],
								disabled = function() return not self.db.profile.castBar end,
								min=5,
								max=100,
								step=1,
								order=5,
							},
							castBarWidth = {
								type="range",
								name=L["Cast bar width"],
								desc=L["Width of the cast bars"],
								disabled = function() return not self.db.profile.castBar end,
								min=20,
								max=500,
								step=1,
								order=5,
							},
							manaBarHeight = {
								type="range",
								name=L["Power bar height"],
								desc=L["Height of the power bars"],
								disabled = function() return not self.db.profile.powerBar end,
								min=5,
								max=50,
								step=1,
								order=6,
							},
							barBottomMargin = {
								type="range",
								name=L["Bar bottom margin"],
								desc=L["Margin to the next bar"],
								min=0,
								max=30,
								step=1,
								order=7,
							},
						},
					},
					colors = {
						type="group",
						name=L["Colors"],
						desc=L["Color settings"],
						order=2,
						args = {
                     healthBarColor = {
								type="color",
								name=L["Health bar color"],
								desc=L["Color of the health bar"],
								disabled = function() return self.db.profile.healthBarClassColor end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=0,
							},
							healthBarClassColor = {
								type="toggle",
								name=L["Color by class"],
								desc=L["Color the health bar by class"],
								order=0,
							},
							barTexture = {
								type="select",
								name=L["Bar texture"],
								dialogControl = "LSM30_Statusbar",
								values = AceGUIWidgetLSMlists.statusbar,
								get=function(info)
										return Gladius.db.profile.barTexture
									end,
								set=function(info, v)
										Gladius.db.profile.barTexture = v
										self:UpdateFrame()
									end,
								order=1
							},
							selectedFrameColor = {
								type="color",
								name=L["Selected border color"],
								desc=L["Color of the selected targets border"],
								disabled = function() return not self.db.profile.selectedBorder end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=1,
							},
							focusBorderColor = {
								type="color",
								name=L["Focus border color"],
								desc=L["Color of the focus border"],
								disabled = function() return not self.db.profile.focusBorder end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=1,
							},
							assistBorderColor = {
								type="color",
								name=L["Main Assist border color"],
								desc=L["Color of the main assist border"],
								disabled = function() return not self.db.profile.assistBorder end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=1,
							},
							healthColor = {
								type="color",
								name=L["Pet bar color"],
								desc=L["Color of the pet bar"],
								disabled = function() return not self.db.profile.showPets end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=3,
							},
							manaColor = {
								type="color",
								name=L["Mana color"],
								desc=L["Color of the mana bar"],
								disabled = function() return not self.db.profile.powerBar or self.db.profile.manaDefault end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=4,
							},
							manaDefault = {
								type="toggle",
								name=L["Game default"],
								desc=L["Use game default mana color"],
								order=5,
							},
							energyColor = {
								type="color",
								name=L["Energy color"],
								desc=L["Color of the energy bar"],
								disabled = function() return not self.db.profile.powerBar or self.db.profile.energyDefault end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=6,
							},
							energyDefault = {
								type="toggle",
								name=L["Game default"],
								desc=L["Use game default energy color"],
								order=7,
							},
							rageColor = {
								type="color",
								name=L["Rage color"],
								desc=L["Color of the rage bar"],
								disabled = function() return not self.db.profile.powerBar or self.db.profile.rageDefault end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=8,
							},
							rageDefault = {
								type="toggle",
								name=L["Game default"],
								desc=L["Use game default rage color"],
								order=9,
							},
							rpColor = {
								type="color",
								name=L["Runic Power color"],
								desc=L["Color of the runic power bar"],
								disabled = function() return not self.db.profile.powerBar or self.db.profile.rpDefault end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=10,
							},
							rpDefault = {
								type="toggle",
								name=L["Game default"],
								desc=L["Use game default runic power color"],
								order=11,
							},
							castBarColor = {
								type="color",
								name=L["Cast bar color"],
								desc=L["Color of the cast bar"],
								disabled = function() return not self.db.profile.castBar end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=2,
							},
							castBarBgColor = {
								type="color",
								name=L["Cast bar background color"],
								desc=L["Color of the cast bar background"],
								disabled = function() return not self.db.profile.castBar end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=2,
							},
						},
					},
				},
			},
			text = {
				type="group",
				name=L["Text"],
				desc=L["Text settings"],
				order=3,
				args = {
					shortHpMana = {
						type="toggle",
						name=L["Shorten Health/Power text"],
						desc=L["Shorten the formatting of the health and power text to e.g. 20.0/25.3 when the amount is over 9999"],
						order=5,
					},
					healthPercentage = {
						type="toggle",
						name=L["Show health percentage"],
						desc=L["Show health percentage on the health bar"],
						order=10,
					},
					healthActual = {
						type="toggle",
						name=L["Show the actual health"],
						desc=L["Show the actual health on the health bar"],
						order=15,
					},
					healthMax = {
						type="toggle",
						name=L["Show max health"],
						desc=L["Show maximum health on the health bar"],
						order=20,
					},					
					manaText = {
						type="toggle",
						name=L["Show power text"],
						desc=L["Show mana/energy/rage text on the power bar"],
						disabled = function() return not self.db.profile.powerBar end,
						order=55,
					},
					manaPercentage = {
						type="toggle",
						name=L["Show power percentage"],
						desc=L["Show mana/energy/rage percentage on the power bar"],
						disabled = function() return not self.db.profile.powerBar or not self.db.profile.manaText end,
						order=60,
					},
					manaActual = {
						type="toggle",
						name=L["Show the actual power"],
						desc=L["Show the actual mana/energy/rage on the power bar"],
						disabled = function() return not self.db.profile.powerBar or not self.db.profile.manaText end,
						order=63,
					},
					manaMax = {
						type="toggle",
						name=L["Show max power"],
						desc=L["Show maximum mana/energy/rage on the power bar"],
						disabled = function() return not self.db.profile.powerBar or not self.db.profile.manaText end,
						order=66,
					},
					classText = {
						type="toggle",
						name=L["Show class text"],
						desc=L["Show class text on the power bar"],
						disabled = function() return not self.db.profile.powerBar end,
						order=70,
					},
					raceText = {
						type="toggle",
						name=L["Show race text"],
						desc=L["Show race text on the power bar"],
						disabled = function() return not self.db.profile.powerBar end,
						order=75,
					},
					specText = {
						type="toggle",
						name=L["Show spec text"],
						desc=L["Show spec text on the power bar"],
						disabled = function() return not self.db.profile.powerBar end,
						order=80,
					},
					drText = {
						type="toggle",
						name=L["Show DR text"],
						desc=L["Show DR text on the icons"],
						disabled = function() return not self.db.profile.drCooldown end,
						order=81,
					},
					showPetType = {
						type="toggle",
						name=L["Show pet type text"],
						desc=L["Show pet type on the pet bar"],
						disabled = function() return not self.db.profile.showPets end,
						order=85,
					},
					showPetHealth = {
						type="toggle",
						name=L["Show pet health text"],
						desc=L["Show pet health on the pet bar (formatted the same as the ordinary health text)"],
						disabled = function() return not self.db.profile.showPets end,
						order=90,
					},	
					sizes = {
						type="group",
						name=L["Sizes"],
						desc=L["Size settings for the text"],
						order=1,
						args = {
							healthFontSize = {
								type="range",
								name=L["Health text size"],
								desc=L["Size of the health bar text"],
								min=1,
								max=20,
								step=1,
								order=1,
							},
							manaFontSize = {
								type="range",
								name=L["Mana text size"],
								desc=L["Size of the mana bar text"],
								disabled = function() return not self.db.profile.powerBar end,
								min=1,
								max=20,
								step=1,
								order=3,
							},						
							castBarFontSize = {
								type="range",
								name=L["Cast bar text size"],
								desc=L["Size of the cast bar text"],
								disabled = function() return not self.db.profile.castBar end,
								min=1,
								max=20,
								step=1,
								order=5,
							},
							petFontSize = {
								type="range",
								name=L["Pet bar text size"],
								desc=L["Size of the pet bar text"],
								min=1,
								max=20,
								step=1,
								order=6,
							},
							auraFontSize = {
								type="range",
								name=L["Aura text size"],
								desc=L["Size of the aura text"],
								disabled = function() return not self.db.profile.auras end,
								min=1,
								max=20,
								step=1,
								order=10,
							},
							debuffFontSize = {
								type="range",
								name=L["Debuff text size"],
								desc=L["Size of the debuff text"],
								min=1,
								max=20,
								step=1,
								order=10,
							},
							drFontSize = {
								type="range",
								name=L["DR text size"],
								desc=L["Size of the DR text"],
								min=1,
								max=20,
								step=1,
								order=10,
							},
						},
					},
					colors = {
						type="group",
						name=L["Fonts"],
						desc=L["Fonts settings"],
						order=2,
						args = {
							healthFontColor = {
								type="color",
								name=L["Health text color"],
								desc=L["Color of the health bar text"],
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=2,
							},
							manaFontColor = {
								type="color",
								name=L["Mana text color"],
								desc=L["Color of the mana bar text"],
								disabled = function() return not self.db.profile.powerBar end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=4,
							},
							castBarFontColor = {
								type="color",
								name=L["Cast bar text color"],
								desc=L["Color of the cast bar text"],
								disabled = function() return not self.db.profile.castBar end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=6,
							},
							petBarFontColor = {
								type="color",
								name=L["Pet bar text color"],
								desc=L["Color of the text on the pet bar"],
								disabled = function() return not self.db.profile.showPets end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=7,
							},
							auraFontColor = {
								type="color",
								name=L["Aura text color"],
								desc=L["Color of the aura text"],
								disabled = function() return not self.db.profile.auras end,
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=10,
							},
							debuffFontColor = {
								type="color",
								name=L["Debuff text color"],
								desc=L["Color of the debuff text"],
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=11,
							},
							drFontColor = {
								type="color",
								name=L["DR text color"],
								desc=L["Color of the DR text"],
								get=getColorOption,
								set=setColorOption,
								hasAlpha=true,
								order=11,
							},
							healthFont = {
								type="select",
								name=L["Health text font"],
								desc=L["Font of the health bar text"],
								dialogControl = "LSM30_Font",
								values = AceGUIWidgetLSMlists.font,
								get=function(info)
										return Gladius.db.profile.healthFont
									end,
								set=function(info, v)
										Gladius.db.profile.healthFont = v
										self:UpdateFrame()
									end,
								order=12
							},	
							manaFont = {
								type="select",
								name=L["Mana text font"],
								desc=L["Font of the mana bar text"],
								dialogControl = "LSM30_Font",
								values = AceGUIWidgetLSMlists.font,
								get=function(info)
										return Gladius.db.profile.manaFont
									end,
								set=function(info, v)
										Gladius.db.profile.manaFont = v
										self:UpdateFrame()
									end,
								order=13
							},		
							castBarFont = {
								type="select",
								name=L["Cast bar text font"],
								desc=L["Font of the cast bar text"],
								dialogControl = "LSM30_Font",
								values = AceGUIWidgetLSMlists.font,
								get=function(info)
										return Gladius.db.profile.castBarFont
									end,
								set=function(info, v)
										Gladius.db.profile.castBarFont = v
										self:UpdateFrame()
									end,
								order=14
							},	
							petBarFont = {
								type="select",
								name=L["Pet bar text font"],
								desc=L["Font of the pet bar text"],
								dialogControl = "LSM30_Font",
								values = AceGUIWidgetLSMlists.font,
								get=function(info)
										return Gladius.db.profile.petBarFont
									end,
								set=function(info, v)
										Gladius.db.profile.petBarFont = v
										self:UpdateFrame()
									end,
								order=15
							},	
							auraFont = {
								type="select",
								name=L["Aura text font"],
								desc=L["Font of the aura text"],
								dialogControl = "LSM30_Font",
								values = AceGUIWidgetLSMlists.font,
								get=function(info)
										return Gladius.db.profile.auraFont
									end,
								set=function(info, v)
										Gladius.db.profile.auraFont = v
										self:UpdateFrame()
									end,
								order=16
							},	
							debuffFont = {
								type="select",
								name=L["Debuff text font"],
								desc=L["Font of the debuff text"],
								dialogControl = "LSM30_Font",
								values = AceGUIWidgetLSMlists.font,
								get=function(info)
										return Gladius.db.profile.debuffFont
									end,
								set=function(info, v)
										Gladius.db.profile.debuffFont = v
										self:UpdateFrame()
									end,
								order=17
							},		
							drFont = {
								type="select",
								name=L["DR text font"],
								desc=L["Font of the DR text"],
								dialogControl = "LSM30_Font",
								values = AceGUIWidgetLSMlists.font,
								get=function(info)
										return Gladius.db.profile.drFont
									end,
								set=function(info, v)
										Gladius.db.profile.drFont = v
										self:UpdateFrame()
									end,
								order=17
							},									
						},
					},
				},
			},
			dr = {
            type = "group",
            order = 4,
            name = L["DR Tracker"],
            args = {
               drCooldown = {
                  type="toggle",
                  name=L["Show DR cooldown icons"],
                  order=0,
               },
               drCooldownPos = {
                  type="select",
                  name=L["DR Cooldown position"],
                  desc=L["Position of the cooldown icons"],
                  values = {
                     ["RIGHT"] = L["Right"],
                     ["LEFT"] = L["Left"],
                  },
                  order=1,
               },
               drIconAdjust = {
                  type="toggle",
                  name=L["Adjust Icon Size"],
                  desc=L["Adjust Icon Size on the Unit's Height"],
                  order=2,
               },   
               drIconSize = {
                  type="range",
                  name=L["Icon Size"],
                  desc=L["Size of the DR Icons"],
                  disabled = function() return self.db.profile.drIconAdjust end,
                  min=5,
                  max=100,
                  step=1,
                  order=3,
               }, 
               drMargin = {
                  type="range",
                  name=L["Icon Margin"],
                  desc=L["Margin to the next icon"],
                  min=0,
                  max=20,
                  step=1,
                  order=4,
               },
               drCooldownAnchor = {
                  type="select",
                  name=L["DR Cooldown anchor"],
                  desc=L["Anchor of the cooldown icons"],
                  values = {
                     ["TOP"] = L["Top"],
                     ["CENTER"] = L["Center"],
                     ["BOTTOM"] = L["Bottom"],
                  },
                  order=5,
               },
               drNoCooldownCount = {
                  type="toggle",
                  name=L["No Cooldown Count (omniCC)"],
                  order=6,
               }, 
               drDisorient = {                  
                  type="toggle",
                  name=L["Disorient"],
                  get=function(info) return self.db.profile.drList["DISORIENT"] == nil and true or self.db.profile.drList["DISORIENT"] end,
                  set=function(info, value) self.db.profile.drList["DISORIENT"] = value end,
                  order=10,      
               },
               drSilence = {                  
                  type="toggle",
                  name=L["Silence"],
                  get=function(info) return self.db.profile.drList["SILENCE"] == nil and true or self.db.profile.drList["SILENCE"] end,
                  set=function(info, value) self.db.profile.drList["SILENCE"] = value end,
                  order=10,      
               },  
               drDisarm = {                  
                  type="toggle",
                  name=L["Disarm"],
                  get=function(info) return self.db.profile.drList["DISARM"] == nil and true or self.db.profile.drList["DISARM"] end,
                  set=function(info, value) self.db.profile.drList["DISARM"] = value end,
                  order=10,      
               },
               drFear = {                  
                  type="toggle",
                  name=L["Fear"],
                  get=function(info) return self.db.profile.drList["FEAR"] == nil and true or self.db.profile.drList["FEAR"] end,
                  set=function(info, value) self.db.profile.drList["FEAR"] = value end,
                  order=10,      
               },
               drControlledStun = {                  
                  type="toggle",
                  name=L["Controlled Stun"],
                  get=function(info) return self.db.profile.drList["CONTROLLEDSTUN"] == nil and true or self.db.profile.drList["CONTROLLEDSTUN"] end,
                  set=function(info, value) self.db.profile.drList["CONTROLLEDSTUN"] = value end,
                  order=10,      
               },
               drRandomStun = {                  
                  type="toggle",
                  name=L["Random Stun"],
                  get=function(info) return self.db.profile.drList["RANDOMSTUN"] == nil and true or self.db.profile.drList["RANDOMSTUN"] end,
                  set=function(info, value) self.db.profile.drList["RANDOMSTUN"] = value end,
                  order=10,      
               },  
               drControlledRoot = {                  
                  type="toggle",
                  name=L["Controlled Root"],
                  get=function(info) return self.db.profile.drList["CONTROLLEDROOT"] == nil and true or self.db.profile.drList["CONTROLLEDROOT"] end,
                  set=function(info, value) self.db.profile.drList["CONTROLLEDROOT"] = value end,
                  order=10,      
               },
               drRandomRoot = {                  
                  type="toggle",
                  name=L["Random Root"],
                  get=function(info) return self.db.profile.drList["RANDOMROOT"] == nil and true or self.db.profile.drList["RANDOMROOT"] end,
                  set=function(info, value) self.db.profile.drList["RANDOMROOT"] = value end,
                  order=10,      
               }, 
               drHorror = {                  
                  type="toggle",
                  name=L["Horror"],
                  get=function(info) return self.db.profile.drList["HORROR"] == nil and true or self.db.profile.drList["HORROR"] end,
                  set=function(info, value) self.db.profile.drList["HORROR"] = value end,
                  order=10,      
               },
               drOpenerStun = {                  
                  type="toggle",
                  name=L["Opener Stun"],
                  get=function(info) return self.db.profile.drList["OPENERSTUN"] == nil and true or self.db.profile.drList["OPENERSTUN"] end,
                  set=function(info, value) self.db.profile.drList["OPENERSTUN"] = value end,
                  order=10,      
               },  
               drCharge = {                  
                  type="toggle",
                  name=L["Charge"],
                  get=function(info) return self.db.profile.drList["CHARGE"] == nil and true or self.db.profile.drList["CHARGE"] end,
                  set=function(info, value) self.db.profile.drList["CHARGE"] = value end,
                  order=10,      
               },
               drMindControl = {                  
                  type="toggle",
                  name=L["Mind Control"],
                  get=function(info) return self.db.profile.drList["MINDCONTROL"] == nil and true or self.db.profile.drList["MINDCONTROL"] end,
                  set=function(info, value) self.db.profile.drList["MINDCONTROL"] = value end,
                  order=10,      
               },
               drBanish = {                  
                  type="toggle",
                  name=L["Banish"],
                  get=function(info) return self.db.profile.drList["BANISH"] == nil and true or self.db.profile.drList["BANISH"] end,
                  set=function(info, value) self.db.profile.drList["BANISH"] = value end,
                  order=10,      
               },
               drEntrapment = {                  
                  type="toggle",
                  name=L["Entrapment"],
                  get=function(info) return self.db.profile.drList["ENTRAPMENT"] == nil and true or self.db.profile.drList["ENTRAPMENT"] end,
                  set=function(info, value) self.db.profile.drList["ENTRAPMENT"] = value end,
                  order=10,      
               },  
               drSleep = {                  
                  type="toggle",
                  name=L["Sleep"],
                  get=function(info) return self.db.profile.drList["SLEEP"] == nil and true or self.db.profile.drList["SLEEP"] end,
                  set=function(info, value) self.db.profile.drList["SLEEP"] = value end,
                  order=10,      
               },
               drCyclone = {                  
                  type="toggle",
                  name=L["Cyclone"],
                  get=function(info) return self.db.profile.drList["CYCLONE"] == nil and true or self.db.profile.drList["CYCLONE"] end,
                  set=function(info, value) self.db.profile.drList["CYCLONE"] = value end,
                  order=10,      
               },              
            },
         },
		}
	}
	
	self.options.args.auras = {
		type = "group",
		order = 9,
		name = L["Auras"],
		args = {
         displayAuras = {
            type="toggle",
            name=L["Show auras"],
            desc=L["Show important auras over the class icon with a timer. You can select which auras to show and their respective priorites in the auralist.lua file"],
            disabled = function() return not self.db.profile.classIcon end,						
            order=0,
         },
         auraPos = {
            type="select",
            name=L["Aura position"],
            desc=L["Position of the aura icon"],
            values = {
               ["RIGHT"] = L["Right"],
               ["LEFT"] = L["Left"],
            },
            order=1,
         },
			new = {
				type = "group",
				name = L["Add new aura"],
				args = {
					name = {
						type = "input",
						name = L["Name"],
						desc = L["Name of the aura"],
						get = function() return newAuraName end,
						set = function(info, value) newAuraName = value end,
						order=2,
					},
					priority = {
						type= "range",
						name = L["Priority"],
						desc = L["Select what priority the aura should have - higher equals more priority"],
						min=1,
						max=5,
						step=1,
						get = function() return newAuraPrio end,
						set = function(info, value) newAuraPrio = value end,
						order=3,
					},
					announceType = {
                  type = "select",
                  name = L["Announcement type"],
                  desc = L["Where to display the announcement messages"],
                  get=function(info) return newAuraAnnounce end,
                  set=function(info, value) newAuraAnnounce = value end,
                  values=auraAnnounceValues,
                  order=3,
               },
					Add = {
						type = "execute",
						name = L["Add"],
						order = 4,
						func = function()
							if ( newAuraName ~= "") then
								table.insert(self.db.profile.auras, { name = newAuraName, priority = newAuraPrio })
								self.db.profile.auraAnnounceList[newAuraName] = newAuraAnnounce
								newAuraName = ""
								self.options.args.auras.args.list.args = {}
								for i=#(self.db.profile.auras), 1, -1 do
									if ( not self.db.profile.auras[i].deleted ) then
										self.options.args.auras.args.list.args[tostring(i)] = SetupAuraOption(i)
									end
								end
								Gladius:ConvertAuraList()
							end
						end,
					},
				},
			},
			list = {
				type = "group",
				name = L["Aura list"],
				args = {},
			},
		},
	}
	
		-- fix for aura variable that i managed to fuck up in r20
	if ( type(self.db.profile.auras) == "boolean" ) then
		self.db.profile.displayAuras = self.db.profile.auras
		self.db.profile.auras = defaults.profile.auras
	end
	
	for i=#(self.db.profile.auras), 1, -1 do
		if ( not self.db.profile.auras[i].deleted ) then
			self.options.args.auras.args.list.args[tostring(i)] = SetupAuraOption(i)
		end
	end
	
	Gladius:ConvertAuraList()
	
	
	self.options.args.cooldowns = {
		type = "group",
		order = 10,
		name = L["Cooldowns"],
		args = {
         cooldown = {
            type="toggle",
            name=L["Show cooldown icons"],
            order=0,
         },
         cooldownPos = {
            type="select",
            name=L["Cooldown position"],
            desc=L["Position of the cooldown icons"],
            values = {
               ["RIGHT"] = L["Right"],
               ["LEFT"] = L["Left"],
            },
            order=1,
         },         
		},
	}
	
	for class, spells in pairs(self.cooldownSpells) do
      self.options.args.cooldowns.args[class] = {
         type = "group",
         order = 1,
         name = LOCALIZED_CLASS_NAMES_MALE[class],
         args = {
            cooldownToggle = {
               type="toggle",
               name=L["Show cooldown"],
               get=function(info)
                  local name = info[2]
                  return self.db.profile.cooldownList[name] == nil and true or self.db.profile.cooldownList[name]
               end,
               set=function(info, value)
                  local name = info[2]
                  self.db.profile.cooldownList[name] = value
                  Gladius:UpdateFrame()
               end,
               order=0,
            },
            announceType = {
               type = "select",
               name = L["Announcement type"],
               desc = L["Where to display the announcement messages"],
               get=function(info) 
                  local name = info[2]
                  return self.db.profile.cooldownAnnounceList[name] == nil and "disabled" or self.db.profile.cooldownAnnounceList[name] 
               end,
               set=function(info, value)
                  local name = info[2]
                  self.db.profile.cooldownAnnounceList[name] = value
                  Gladius:UpdateFrame()
               end,
               values=auraAnnounceValues,
               order=1,
            },
         },
      }
      
      for k,v in pairs(self.cooldownSpells[class]) do
         self.options.args.cooldowns.args[class].args[tostring(k)] = {
            type = "group",
            order = 1,
            name = GetSpellInfo(k),
            args = {
               cooldownToggle = {
                  type="toggle",
                  name=L["Show cooldown"],
                  get=function(info)
                     local name = info[3]
                     return self.db.profile.cooldownList[tonumber(name)] == nil and true or self.db.profile.cooldownList[tonumber(name)]
                  end,
                  set=function(info, value)
                     local name = info[3]
                     self.db.profile.cooldownList[tonumber(name)] = value
                     Gladius:UpdateFrame()
                  end,
                  order=0,
               },
               announceType = {
                  type = "select",
                  name = L["Announcement type"],
                  desc = L["Where to display the announcement messages"],
                  get=function(info) 
                     local name = info[3]
                     return self.db.profile.cooldownAnnounceList[tonumber(name)] == nil and "disabled" or self.db.profile.cooldownAnnounceList[tonumber(name)] 
                  end,
                  set=function(info, value)
                     local name = info[3]
                     self.db.profile.cooldownAnnounceList[tonumber(name)] = value
                     Gladius:UpdateFrame()
                  end,
                  values=auraAnnounceValues,
                  order=1,
               },
               soundFile = {
                  type="select",
                  name=L["Sound"],
                  desc=L["Plays a sound when the cooldown is used"],
                  dialogControl = "LSM30_Sound",
                  values = sounds,
                  get=function(info)
                     local name = info[3]
                     return self.db.profile.cooldownSoundList[tonumber(name)] == nil and L["Disabled"] or self.db.profile.cooldownSoundList[tonumber(name)]
                  end,
                  set=function(info, value)
                     local name = info[3]
                     self.db.profile.cooldownSoundList[tonumber(name)] = value
                  end,
                  order=2
               },
               Play = {
						type = "execute",
						name = L["Play Sound"],
						order = 3,
						func = function(info)
							local name = info[3]
							local soundFile = self.db.profile.cooldownSoundList[tonumber(name)]
							if (soundFile ~= nil and soundFile ~= L["Disabled"]) then
                        PlaySoundFile(LSM:Fetch(LSM.MediaType.SOUND, self.db.profile.cooldownSoundList[tonumber(name)]))
							end
						end,
					},	
            },
         }
      end
	end	
	
	self.options.args.clicks = {
		type = "group",
		order = 11,
		name = L["Click actions"],
		args = {},
	}
	
	for i=1, 10 do
		self.options.args.clicks.args[tostring(i)] = SetupAttributeOption(i)
	end
	
	for i=1, 4 do
		self.options.args.general.args.debuffs.args[tostring(i)] = {
				type = "input",
				name = string.format(L["Debuff #%d"], i),
				desc = L["Name or spell id of the debuff you want to track."],
				get = function(info) return Gladius.db.profile.debuffs[i].name end,
				set = function(info, value)
						Gladius.db.profile.debuffs[i].name = tonumber(value) and GetSpellInfo(value) or GetSpellID(value) and GetSpellInfo(GetSpellID(value)) or ""
						Gladius.db.profile.debuffs[i].id = tonumber(value) and value or GetSpellID(value) and GetSpellID(value) or ""
						Gladius:UpdateFrame()
					  end,
				validate = ValidateSpellInfo,
				order= i+3,
		}
	end
	
	self.options.plugins.profiles = { profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db) }
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Gladius", self.options)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Gladius", "Gladius")
	self:RegisterChatCommand("gladius", slashHandler)
	
end

function Gladius:ShowOptions()
  InterfaceOptionsFrame_OpenToCategory("Gladius")
end
