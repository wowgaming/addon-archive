local L = LibStub("AceLocale-3.0"):GetLocale("Ovale")

Ovale = LibStub("AceAddon-3.0"):NewAddon("Ovale", "AceEvent-3.0", "AceConsole-3.0")
local Recount = Recount

Ovale.defaut = {}
Ovale.action = {}
Ovale.casesACocher = {}
Ovale.actionSort = {}
Ovale.listeTalents = {}
Ovale.pointsTalent = {}
Ovale.talentIdToName = {}
Ovale.talentNameToId = {}
Ovale.firstInit = false
Ovale.Inferieur = 1
Ovale.Superieur = 2
Ovale.listeTalentsRemplie = false
Ovale.frame = nil
Ovale.checkBoxes = {}
Ovale.dropDowns = {}
Ovale.masterNodes = nil
Ovale.bug = false
Ovale.enCombat = false
Ovale.spellHaste = 0
Ovale.meleeHaste = 0
Ovale.aura = { player = {}, target = {}}
Ovale.targetGUID = nil
Ovale.spellInfo = {}
Ovale.spellStack = {}
Ovale.buff = {}
Ovale.className = nil
Ovale.state = {rune={}, cd = {}}
Ovale.scoreSpell = {}
Ovale.otherDebuffs = {}
Ovale.score = 0
Ovale.maxScore = 0
Ovale.serial = 0
Ovale.counter = {}
Ovale.lastSpell = {}

Ovale.arbre = {}

BINDING_HEADER_OVALE = "Ovale"
BINDING_NAME_OVALE_CHECKBOX0 = L["Inverser la boîte à cocher "].."(1)"
BINDING_NAME_OVALE_CHECKBOX1 = L["Inverser la boîte à cocher "].."(2)"
BINDING_NAME_OVALE_CHECKBOX2 = L["Inverser la boîte à cocher "].."(3)"
BINDING_NAME_OVALE_CHECKBOX3 = L["Inverser la boîte à cocher "].."(4)"
BINDING_NAME_OVALE_CHECKBOX4 = L["Inverser la boîte à cocher "].."(5)"

-- Ovale.trace=true
local nouvelleCondition
local nouveauSort

local options = 
{ 
	type = "group",
	args = 
	{
		apparence =
		{
			name = L["Apparence"],
			type = "group",
			args =
			{
				combatUniquement =
				{
					order = 1,
					type = "toggle",
					name = L["En combat uniquement"],
					get = function(info)
						return Ovale.db.profile.apparence.enCombat
					end,
					set = function(info, v)
						Ovale.db.profile.apparence.enCombat = v
						Ovale:UpdateVisibility()
					end,
					width = full
				},
				targetOnly =
				{
					order = 1.5,
					type = "toggle",
					name = L["Si cible uniquement"],
					get = function(info)
						return Ovale.db.profile.apparence.avecCible
					end,
					set = function(info, v)
						Ovale.db.profile.apparence.avecCible = v
						Ovale:UpdateVisibility()
					end,
					width = full
				},
				iconWidth = 
				{
					order = 2,
					type = "range",
					name = L["Largeur des icônes"],
					desc = L["La largeur des icônes"],
					min = 16, max = 256, step = 2,
					get = function(info) return Ovale.db.profile.apparence.iconWidth end,
					set = function(info,value) Ovale.db.profile.apparence.iconWidth = value; Ovale:UpdateFrame() end
				},
				iconHeight = 
				{
					order = 3,
					type = "range",
					name = L["Hauteur des icônes"],
					desc = L["La hauteur des icônes"],
					min = 16, max = 256, step = 2,
					get = function(info) return Ovale.db.profile.apparence.iconHeight end,
					set = function(info,value) Ovale.db.profile.apparence.iconHeight = value; Ovale:UpdateFrame() end
				},
				smallIconWidth = 
				{
					order = 4,
					type = "range",
					name = L["Largeur des petites icônes"],
					desc = L["La largeur des petites icônes"],
					min = 16, max = 256, step = 2,
					get = function(info) return Ovale.db.profile.apparence.smallIconWidth end,
					set = function(info,value) Ovale.db.profile.apparence.smallIconWidth = value; Ovale:UpdateFrame() end
				},
				smallIconHeight = 
				{
					order = 5,
					type = "range",
					name = L["Hauteur des petites icônes"],
					desc = L["La hauteur des petites icônes"],
					min = 16, max = 256, step = 2,
					get = function(info) return Ovale.db.profile.apparence.smallIconHeight end,
					set = function(info,value) Ovale.db.profile.apparence.smallIconHeight = value; Ovale:UpdateFrame() end
				},
				margin = 
				{
					order = 5.5,
					type = "range",
					name = L["Marge entre deux icônes"],
					min = 0, max = 64, step = 1,
					get = function(info) return Ovale.db.profile.apparence.margin end,
					set = function(info,value) Ovale.db.profile.apparence.margin = value; Ovale:UpdateFrame() end
				},
				raccourcis =
				{
					order = 6,
					type = "toggle",
					name = L["Raccourcis clavier"],
					desc = L["Afficher les raccourcis clavier dans le coin inférieur gauche des icônes"],
					get = function(info) return Ovale.db.profile.apparence.raccourcis end,
					set = function(info, value) Ovale.db.profile.apparence.raccourcis = value end
				},
				numeric =
				{
					order = 7,
					type = "toggle",
					name = L["Affichage numérique"],
					desc = L["Affiche le temps de recharge sous forme numérique"],
					get = function(info) return Ovale.db.profile.apparence.numeric end,
					set = function(info, value) Ovale.db.profile.apparence.numeric = value end
				},
				verrouille =
				{
					order = 8,
					type = "toggle",
					name = L["Verrouiller position"],
					get = function(info) return Ovale.db.profile.apparence.verrouille end,
					set = function(info, value) Ovale.db.profile.apparence.verrouille = value end
				},
				vertical =
				{
					order = 9,
					type = "toggle",
					name = L["Vertical"],
					get = function(info) return Ovale.db.profile.apparence.vertical end,
					set = function(info, value) Ovale.db.profile.apparence.vertical = value; Ovale:UpdateFrame() end
				},
				predictif =
				{
					order = 10,
					type = "toggle",
					name = L["Prédictif"],
					desc = L["Affiche les deux prochains sorts et pas uniquement le suivant"],
					get = function(info) return Ovale.db.profile.apparence.predictif end,
					set = function(info, value) Ovale.db.profile.apparence.predictif = value; Ovale:UpdateFrame() end
				},
				moving = 
				{
					order = 11,
					type = "toggle",
					name = L["Défilement"],
					desc = L["Les icônes se déplacent"],
					get = function(info) return Ovale.db.profile.apparence.moving end,
					set = function(info, value) Ovale.db.profile.apparence.moving = value; Ovale:UpdateFrame() end
				},
				hideEmpty =
				{
					order = 12,
					type = "toggle",
					name = L["Cacher bouton vide"],
					get = function(info) return Ovale.db.profile.apparence.hideEmpty end,
					set = function(info, value) Ovale.db.profile.apparence.hideEmpty = value; Ovale:UpdateFrame() end
				},
				targetHostileOnly = 
				{
					order = 13,
					type = "toggle",
					name = L["Cacher si cible amicale ou morte"],
					get = function(info) return Ovale.db.profile.apparence.targetHostileOnly end,
					set = function(info, value) Ovale.db.profile.apparence.targetHostileOnly = value; Ovale:UpdateFrame() end
				},
				highlightIcon =
				{
					order = 14,
					type = "toggle",
					name = L["Illuminer l'icône"],
					desc = L["Illuminer l'icône quand la technique doit être spammée"],
					get = function(info) return Ovale.db.profile.apparence.highlightIcon end,
					set = function(info, value) Ovale.db.profile.apparence.highlightIcon = value; Ovale:UpdateFrame() end
				},
				clickThru =
				{
					order = 15,
					type = "toggle",
					name = L["Ignorer les clics souris"],
					get = function(info) return Ovale.db.profile.apparence.clickThru end,
					set = function(info, value) Ovale.db.profile.apparence.clickThru = value; Ovale:UpdateFrame() end
				},
				latencyCorrection =
				{
					order = 16,
					type = "toggle",
					name = L["Correction de la latence"],
					get = function(info) return Ovale.db.profile.apparence.latencyCorrection end,
					set = function(info, value) Ovale.db.profile.apparence.latencyCorrection = value end
				},
				hideVehicule =
				{
					order = 17,
					type = "toggle",
					name = L["Cacher dans les véhicules"],
					get = function(info) return Ovale.db.profile.apparence.hideVehicule end,
					set = function(info, value) Ovale.db.profile.apparence.hideVehicule = value end
				}
			}
		},
		code =
		{
			name = L["Code"],
			type = "group",
			args = 
			{
				code = 
				{
					order = 1,
					type = "input",
					multiline = 15,
					name = L["Code"],
					get = function(info)
						return string.gsub(Ovale.db.profile.code, "\t", "    ")
					end,
					set = function(info,v)
						Ovale.db.profile.code = v
						Ovale.needCompile = true
						-- Ovale:UpdateFrame()
						-- Ovale:Print("code change")
					end,
					width = "full"
				}
			}
		},
		actions =
		{
			name = "Actions",
			type = "group",
			args = 
			{
				show =
				{
					order = -1,
					type = "execute",
					name = L["Afficher la fenêtre"],
					guiHidden = true,
					func = function()
						Ovale.db.profile.display = true
						Ovale:UpdateVisibility()
					end
				},
				hide =
				{
					order = -2,
					type = "execute",
					name = L["Cacher la fenêtre"],
					guiHidden = true,
					func = function()
						Ovale.db.profile.display = false
						Ovale.frame:Hide()	
					end
				},
				config  =
				{
					name = "Configuration",
					type = "execute",
					func = function() Ovale:AfficherConfig() end
				},
				code  =
				{
					name = "Code",
					type = "execute",
					func = function() Ovale:AfficherCode() end
				}
			}
		}
	}
}

local function nilstring(text)
	if text == nil then
		return "nil"
	else
		return text
	end
end

function Ovale:Debug()
	self:Print(self:DebugNode(self.masterNodes[1]))
end

function Ovale:OnInitialize()
	self.AceConfig = LibStub("AceConfig-3.0");
	self.AceConfigDialog = LibStub("AceConfigDialog-3.0");
end

function Ovale:ACTIONBAR_SLOT_CHANGED(event, slot, unknown)
	if (slot == 0) then
		self:RemplirActionIndexes()
	elseif (slot) then
	-- on reçoit aussi si c'est une macro avec mouseover à chaque fois que la souris passe sur une cible!
		self:RemplirActionIndex(tonumber(slot))
	end
end

function Ovale:ACTIONBAR_PAGE_CHANGED()
	-- self:RemplirActionIndexes()
end

function Ovale:CHARACTER_POINTS_CHANGED()
	self:RemplirListeTalents()
--	self:Print("CHARACTER_POINTS_CHANGED")
end

function Ovale:PLAYER_TALENT_UPDATE()
	self:RemplirListeTalents()
--	self:Print("PLAYER_TALENT_UPDATE")
end

function Ovale:SPELLS_CHANGED()
	-- self:RemplirActionIndexes()
	-- self:RemplirListeTalents()
	self.needCompile = true
end

function Ovale:UPDATE_BINDINGS()
	self:RemplirActionIndexes()
end

function Ovale:GetOtherDebuffs(spellName)
	if not self.otherDebuffs[spellName] then
		self.otherDebuffs[spellName] = {}
	end
	return self.otherDebuffs[spellName]
end

function Ovale:WithHaste(temps, hate)
	if not temps then
		temps = 0
	end
	if (not hate) then
		return temps
	elseif (hate == "spell") then
		return temps/(1+self.spellHaste/100)
	elseif (hate == "melee") then
		return temps/(1+self.meleeHaste/100)
	else
		return temps
	end
end

function Ovale:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	local time, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)
	--self:Print("event="..event.." source="..nilstring(sourceName).." destName="..nilstring(destName).." " ..GetTime())
	if sourceName == UnitName("player") then
		if string.find(event, "SPELL_CAST_SUCCESS") == 1 or string.find(event, "SPELL_DAMAGE")==1 
				or string.find(event, "SPELL_MISSED") == 1 
				or string.find(event, "SPELL_CAST_FAILED") == 1 then
			local spellId, spellName = select(9, ...)
			for i,v in ipairs(self.lastSpell) do
				if v.name == spellName then
					table.remove(self.lastSpell, i)
					--self:Print("on supprime "..spellName.." a "..GetTime())
					--self:Print(UnitDebuff("target", "Etreinte de l'ombre"))
					break
				end
			end
		end
		if self.otherDebuffsEnabled then
			if string.find(event, "SPELL_AURA_") == 1 then
				local spellId, spellName, spellSchool, auraType = select(9, ...)
				if auraType == "DEBUFF" and self.spellInfo[spellName] and self.spellInfo[spellName].duration then
					local otherDebuff = self:GetOtherDebuffs(spellName)
					if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH" then
						otherDebuff[destGUID] = Ovale.maintenant + self:WithHaste(self.spellInfo[spellName].duration, self.spellInfo[spellName].durationhaste)
					--	self:Print("ajout de "..spellName.." à "..destGUID)
					elseif event == "SPELL_AURA_REMOVED" then
						otherDebuff[destGUID] = nil						
					--	self:Print("suppression de "..spellName.." de "..destGUID)
					end	
				end
			end
		end
		--if string.find(event, "SWING")==1 then
		--	self:Print(select(1, ...))
		--end
	end
	if self.otherDebuffsEnabled then
		if event == "UNIT_DIED" then
			for k,v in pairs(self.otherDebuffs) do
				for j,w in pairs(v) do
					if j==destGUID then
						v[j] = nil
					end
				end
			end
		end
	end
end

--[[
function Ovale:SaveAura(unit, filter)
	local i=1
	
	for k, v in pairs(Ovale.aura[unit]) do
		v.dispelled = true
		v.unitCaster = nil
	end
	
	while (true) do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster = UnitAura(unit, i, filter)
		
		if (not name) then
			break
		end
		
		if (not Ovale.aura[unit][filter][name].isMine or not isMine) then
			Ovale.aura[unit][filter][name].icon = icon
			Ovale.aura[unit][filter][name].count = count
			Ovale.aura[unit][filter][name].duration = duration
			Ovale.aura[unit][filter][name].expirationTime = expirationTime
			Ovale.aura[unit][filter][name].unitCaster  = unitCaster 
		end
	end
end


function Ovale:PLAYER_TARGET_CHANGED()
	Ovale.targetGUID = UnitGUID("target")
	Ovale.aura.target.HELPFUL = {}
	Ovale.aura.target.HARMFUL = {}
end
]]

function Ovale:PLAYER_TARGET_CHANGED()
	self:UpdateVisibility()
end

function Ovale:UNIT_AURA(event, unit)
	if (unit == "player") then
		local hateBase = GetCombatRatingBonus(18)
		local hateCommune=0;
		local hateSorts = 0;
		local hateCaC = 0;
		local hateHero = 0
		local hateClasse = 0
		local i=1;
		
		while (true) do
			local name, rank, iconTexture, count, debuffType, duration, expirationTime, source =  UnitBuff("player", i);
			if (not name) then
				break
			end
			if (not self.buff[name]) then
				self.buff[name] = {}
			end
			self.buff[name].icon = iconTexture
			self.buff[name].count = count
			self.buff[name].duration = duration
			self.buff[name].expirationTime = expirationTime
			self.buff[name].source = source
			if (not self.buff[name].present) then
				self.buff[name].gain = Ovale.maintenant
			end
			self.buff[name].lastSeen = Ovale.maintenant
			self.buff[name].present = true
			
			if (name == self.RETRIBUTION_AURA or name == self.MOONKIN_AURA) then
				hateCommune = 3
			elseif (name == self.WRATH_OF_AIR_TOTEM) then
				hateSorts = 5
			elseif (name == self.WINDFURY_TOTEM and hateCaC == 0) then
				hateCaC = 16
			elseif (name == self.ICY_TALONS) then
				hateCaC = 20
			elseif (name == self.BLOODLUST or name == self.HEROISM) then
				hateHero = 30
			elseif (name == self.JUDGMENT_OF_THE_PURE) then
				hateClasse = 15
			end
			i = i + 1;
		end
		
		for k,v in pairs(self.buff) do
			if (v.lastSeen ~= Ovale.maintenant) then
				v.present = false
			end
		end
		
		self.spellHaste = hateBase + hateCommune + hateSorts + hateHero + hateClasse
		self.meleeHaste = hateBase + hateCommune + hateCaC + hateHero + hateClasse
--		self.rangedHaste = hateBase + hateCommune + hateHero + hateClasse -- TODO ajouter le bidule du chasseur en spé bête
--		print("spellHaste = "..self.spellHaste)
	end
end

function Ovale:CompileAll()
	if self.db.profile.code then
		self.masterNodes = self:Compile(self.db.profile.code)
		self:UpdateFrame()
		self.needCompile = false
	end
end

function Ovale:HandleProfileChanges()
	if (self.firstInit) then
		if (self.db.profile.code) then
			self.needCompile = true
		end
	end
end

function Ovale:ChercherNomsBuffs()
	self.MOONKIN_AURA = self:GetSpellInfoOrNil(24907)
	self.RETRIBUTION_AURA = self:GetSpellInfoOrNil(7294)
	self.WRATH_OF_AIR_TOTEM = self:GetSpellInfoOrNil(3738)
	self.WINDFURY_TOTEM = self:GetSpellInfoOrNil(8512)
	self.ICY_TALONS = self:GetSpellInfoOrNil(50880)
	self.BLOODLUST = self:GetSpellInfoOrNil(2825)
	self.HEROISM = self:GetSpellInfoOrNil(32182)
	self.JUDGMENT_OF_THE_PURE = self:GetSpellInfoOrNil(54153)
end

function Ovale:FirstInit()
	self:RemplirActionIndexes()
	self:RemplirListeTalents()
	self:ChercherNomsBuffs()
	-- self:InitEcranOption()
	
	local playerClass, englishClass = UnitClass("player")
	self.className = englishClass
	if self.className == "DEATHKNIGHT" then
		for i=1,6 do
			self.state.rune[i] = {}
		end
	end
	-- OvaleFrame_Update(OvaleFrame)
	-- OvaleFrame:Show()
	
	self:ChargerDefaut()
	
	self.frame = LibStub("AceGUI-3.0"):Create("OvaleFrame")

	self.frame:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",self.db.profile.left,self.db.profile.top)

	self.firstInit = true
	
	
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.AceConfig:RegisterOptionsTable("Ovale", options.args.code)
	self.AceConfig:RegisterOptionsTable("Ovale Actions", options.args.actions, "Ovale")
	self.AceConfig:RegisterOptionsTable("Ovale Profile", options.args.profile)
	self.AceConfig:RegisterOptionsTable("Ovale Apparence", options.args.apparence)

	self.AceConfigDialog:AddToBlizOptions("Ovale", "Ovale")
	self.AceConfigDialog:AddToBlizOptions("Ovale Profile", "Profile", "Ovale")
	self.AceConfigDialog:AddToBlizOptions("Ovale Apparence", "Apparence", "Ovale")
	
	self.db.RegisterCallback( self, "OnNewProfile", "HandleProfileChanges" )
	self.db.RegisterCallback( self, "OnProfileReset", "HandleProfileChanges" )
	self.db.RegisterCallback( self, "OnProfileChanged", "HandleProfileChanges" )
	self.db.RegisterCallback( self, "OnProfileCopied", "HandleProfileChanges" )

	
	if (self.db.profile.code) then
		self.needCompile = true
	end
	self:UpdateFrame()
	if (not Ovale.db.profile.display) then
		self.frame:Hide()
	end
end

function Ovale:OnEnable()
    -- Called when the addon is enabled
    self:RegisterEvent("PLAYER_REGEN_ENABLED");
    self:RegisterEvent("PLAYER_REGEN_DISABLED");
    self:RegisterEvent("SPELLS_CHANGED")
    self:RegisterEvent("PLAYER_TALENT_UPDATE")
    self:RegisterEvent("CHARACTER_POINTS_CHANGED")
    self:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
    self:RegisterEvent("UPDATE_BINDINGS");
    self:RegisterEvent("UNIT_AURA");
    self:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
    self:RegisterEvent("UNIT_SPELLCAST_SENT")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("CHAT_MSG_ADDON")
	self:RegisterEvent("GLYPH_UPDATED")
	self:RegisterEvent("GLYPH_ADDED")
	    
	if (not self.firstInit) then
		self:FirstInit()
	end
	self:UNIT_AURA("","player")
	self:UpdateVisibility()
end

function Ovale:OnDisable()
    -- Called when the addon is disabled
	self:UnregisterEvent("ACTIONBAR_PAGE_CHANGED")
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    self:UnregisterEvent("PLAYER_REGEN_DISABLED")
    self:UnregisterEvent("PLAYER_TALENT_UPDATE")
    self:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
    self:UnregisterEvent("SPELLS_CHANGED")
    self:UnregisterEvent("CHARACTER_POINTS_CHANGED")
    self:UnregisterEvent("UPDATE_BINDINGS")
    self:UnregisterEvent("UNIT_AURA")
    self:UnregisterEvent("UNIT_SPELLCAST_SENT")
    self:UnregisterEvent("PLAYER_TARGET_CHANGED")
    self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:UnregisterEvent("CHAT_MSG_ADDON")
    self:UnregisterEvent("GLYPH_UPDATED")	
	self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    self.frame:Hide()
end

function Ovale:GLYPH_ADDED(event)
	-- self:Print("GLYPH_ADDED")
	-- self:CompileAll()
	self.needCompile = true
end

function Ovale:GLYPH_UPDATED(event)
	-- self:Print("GLYPH_UPDATED")
	-- self:CompileAll()
	self.needCompile = true
end

function Ovale:UNIT_SPELLCAST_INTERRUPTED(event, unit, name, rank)
	if unit=="player" then
		for i,v in ipairs(self.lastSpell) do
			if v.name == name then
				table.remove(self.lastSpell, i)
				--self:Print("on supprime "..name)
				break
			end
		end
	end
end

function Ovale:UNIT_SPELLCAST_SENT(event,unit,name,rank,target)
	-- self:Print("UNIT_SPELLCAST_SENT"..event.." unit="..unit.." name="..name.." tank="..rank.." target="..target)
	if unit=="player" then
		local newSpell = {}
		newSpell.name = name
		-- local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo("player")
		local spell, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(name)
		newSpell.start = GetTime()
		if spell then 
			newSpell.stop = newSpell.start + castTime/1000
		else
			newSpell.stop = newSpell.start
		end
		local si = self.spellInfo[name]
		
		if si and si.buffnocd and UnitBuff("player", GetSpellInfo(si.buffnocd)) then
			newSpell.nocd = true
		else
			newSpell.nocd = false
		end
		self.lastSpell[#self.lastSpell+1] = newSpell
		-- self:Print("on ajoute "..name.." a ".. newSpell.start)
	end
	
	if unit=="player" and self.enCombat then
		if self.spellInfo[name] then
			if self.spellInfo[name].resetcounter then
				self.counter[self.spellInfo[name].resetcounter] = 0
			end
			if self.spellInfo[name].inccounter then
				local cname = self.spellInfo[name].inccounter
				if not self.counter[cname] then
					self.counter[cname] = 0
				end
				self.counter[cname] = self.counter[cname] + 1
			end
		end
		if (not self.spellInfo[name] or not self.spellInfo[name].toggle) and self.scoreSpell[name] then
			local scored = self.frame:GetScore(name)
			if scored~=nil then
				self.score = self.score + scored
				self.maxScore = self.maxScore + 1
				if Recount then
					local source =Recount.db2.combatants[UnitName("player")]
					if source then
						Recount:AddAmount(source,"Ovale",scored)
						Recount:AddAmount(source,"OvaleMax",1)
					end
				end
			end
		end
	end
end

function Ovale:CHAT_MSG_ADDON(event, prefix, msg, type, author)
	if prefix ~= "Ovale" then return end
	if type ~= "RAID" and type~= "PARTY" then return end

	if Recount then
		local value, max = strsplit(";", msg)
		Recount:AddAmount(author, "Ovale", value)
		Recount:AddAmount(author, "OvaleMax", max)
	end
end

function Ovale:PLAYER_REGEN_ENABLED()
	self.enCombat = false
	self:UpdateVisibility()
	-- if self.maxScore and self.maxScore > 0 then
	-- 	self:Print((self.score/self.maxScore*100).."%")
	-- end
end

function Ovale:PLAYER_REGEN_DISABLED()
	if self.maxScore>0 then
		SendAddonMessage("Ovale", self.score..";"..self.maxScore, "RAID")
	end
	self.enCombat = true
	self.score = 0
	self.maxScore = 0
	self.combatStartTime = self.maintenant
	
	self:UpdateVisibility()
end


function Ovale_GetNomAction(i)
	local actionText = GetActionText(i);
	local text;
	if (actionText) then
		text = "Macro "..actionText;
	else
		local type, id = GetActionInfo(i);
		if (type=="spell") then
			if (id~=0) then
				local spellName, spellRank = GetSpellName(id, BOOKTYPE_SPELL);
				text = "Sort ".. spellName;
				if (spellRank and spellRank~="") then
					text = text .. " ("..spellRank..")"
				end
			end
		elseif (type =="item") then
			local itemName = GetItemInfo(id)
			text = "Objet "..itemName
		else 
			if (type) then
				text = type;
				if (id) then
					text = text.." "..id;
				end
			end
		end
	end
	return text
end

function Ovale:ChercherShortcut(id)
-- ACTIONBUTTON1..12 => principale (1..12, 13..24, 73..108)
-- MULTIACTIONBAR1BUTTON1..12 => bas gauche (61..72)
-- MULTIACTIONBAR2BUTTON1..12 => bas droite (49..60)
-- MULTIACTIONBAR3BUTTON1..12 => haut droit (25..36)
-- MULTIACTIONBAR4BUTTON1..12 => haut gauche (37..48)
	local name;
	if (id<=24 or id>72) then
		name = "ACTIONBUTTON"..(((id-1)%12)+1);
	elseif (id<=36) then
		name = "MULTIACTIONBAR3BUTTON"..(id-24);
	elseif (id<=48) then
		name = "MULTIACTIONBAR4BUTTON"..(id-36);
	elseif (id<=60) then
		name = "MULTIACTIONBAR2BUTTON"..(id-48);
	else
		name = "MULTIACTIONBAR1BUTTON"..(id-60);
	end
	local key = GetBindingKey(name);
--[[	if (not key) then
		DEFAULT_CHAT_FRAME:AddMessage(id.."=>"..name.." introuvable")
	else
		DEFAULT_CHAT_FRAME:AddMessage(id.."=>"..name.."="..key)
	end]]
	return key;
end

function Ovale:GetSpellInfoOrNil(spell)
	if (spell) then
		return GetSpellInfo(spell)
	else
		return nil
	end
end

function Ovale:GetSpellIdByName(name)
	if (not name) then
		return nil
	end
	local link = GetSpellLink(name);
	if (not link) then
		-- self:Print(name.." introuvable");
		return nil;
	end
	local a, b, spellId = string.find(link, "spell:(%d+)");
	return tonumber(spellId);
end

function Ovale:GetSpellIdRangMax(spellId)
	return self:GetSpellIdByName(GetSpellInfo(spellId))
end

function Ovale:GetSpellIdByNameAndRank(name,rank)
	if (not name or not rank) then
		return nil
	end
	local link = GetSpellLink(name.."("..rank..")");
	if (not link) then
		-- self:Print(name.."("..rank..")".." introuvable");
		return nil;
	end
	local a, b, spellId = string.find(link, "spell:(%d+)");
	return tonumber(spellId);
end

function Ovale:RemplirActionIndex(i)
	self.shortCut[i] = self:ChercherShortcut(i)
	local actionText = GetActionText(i);
	if (actionText) then
		self.actionMacro[actionText] = i
	else
		local type, id = GetActionInfo(i);
		if (type=="spell") then
			if (id~=0) then
				local spellName, spellRank = GetSpellName(id, BOOKTYPE_SPELL);
				self.actionSort[spellName] = i
			end
		elseif (type =="item") then
			self.actionObjet[id] = i
		end
	end
end

function Ovale:RemplirActionIndexes()
	self.actionSort = {}
	self.actionMacro = {}
	self.actionObjet = {}
	self.shortCut = {}
	for i=1,120 do
		self:RemplirActionIndex(i)
	end
end

function Ovale:RemplirListeTalents()
	local numTabs = GetNumTalentTabs();
	self.listeTalents = {}
	for t=1, numTabs do
		local numTalents = GetNumTalents(t);
		for i=1, numTalents do
			local nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(t,i);
			self.listeTalents[nameTalent] = nameTalent
			local link = GetTalentLink(t,i)
			local a, b, talentId = string.find(link, "talent:(%d+)");
			-- self:Print("talent = "..nameTalent.." id = ".. talentId)
			talentId = tonumber(talentId)
			self.talentIdToName[talentId] = nameTalent
			self.talentNameToId[nameTalent] = talentId
			self.pointsTalent[talentId] = currRank
			self.listeTalentsRemplie = true
			self.needCompile = true
		end
	end
end

function Ovale:ChercherBouton(sort)
	if (not sort) then
		return nil
	end
	local nom = GetSpellInfo(tonumber(sort))
	for i=1,120 do
		local type, id = GetActionInfo(i);
		if (type=="spell") then
			local spellName, spellRank = GetSpellName(id, BOOKTYPE_SPELL);
			if (spellName == nom) then
				return i
			end
		end
	end
end

function Ovale:AddRune(time, type, value)
	if value<0 then
		for i=1,6 do
			if (self.state.rune[i].type == type or self.state.rune[i].type==4)and self.state.rune[i].cd<=time then
				self.state.rune[i].cd = time + 10
			end
		end
	else
	
	end
end

function Ovale:Log(text)
	if self.trace then
		self:Print(text)
	end
end

function Ovale:GetAura(target, filter, spellId, forceduration)
	if not self.aura[target] then
		self.aura[target] = {}
	end
	if not self.aura[target][filter] then
		self.aura[target][filter] = {}
	end
	if not self.aura[target][filter][spellId] then
		self.aura[target][filter][spellId] = {}
	end
	local myAura = self.aura[target][filter][spellId]
	if myAura.serial == Ovale.serial then
		return myAura
	end
	
	myAura.mine = false
	myAura.start = nil
	myAura.ending = nil
	myAura.stacks = 0
	myAura.serial = Ovale.serial
	
	local i = 1
	local auraName, auraRank, auraIcon = self:GetSpellInfoOrNil(spellId)
	
	while (true) do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable =  UnitAura(target, i, filter);
		if not name then
			break
		end
		if (unitCaster=="player" or not myAura.mine) and name == auraName and icon==auraIcon then
			myAura.mine = (unitCaster == "player")
			myAura.start = expirationTime - duration
			
			if expirationTime>0 then
				myAura.ending = expirationTime
			else
				myAura.ending = nil
			end
			if count and count>0 then
				myAura.stacks = count
			else
				myAura.stacks = 1
			end
			if myAura.mine then
				break
			end
		end
		i = i + 1;
	end
	return myAura
end

function Ovale:GetCD(spellName)
	if not spellName then
		return nil
	end
	
	if self.spellInfo[spellName] and self.spellInfo[spellName].cd then
		local cdname
		if self.spellInfo[spellName].sharedcd then
			cdname = self.spellInfo[spellName].sharedcd
		else
			cdname = spellName
		end
		if not self.state.cd[cdname] then
			self.state.cd[cdname] = {}
		end
		return self.state.cd[cdname]
	else
		return nil
	end
end

-- Lance un sort dans le simulateur
-- spellName : le nom du sort
-- startCast : temps du cast
-- endCast : fin du cast
-- nextCast : temps auquel le prochain sort peut être lancé (>=endCast, avec le GCD)
-- nocd : le sort ne déclenche pas son cooldown
function Ovale:AddSpellToStack(spellName, startCast, endCast, nextCast, nocd)
	if not spellName then
		return
	end
	
	local newSpellInfo = nil
	newSpellInfo = self.spellInfo[spellName]
	
	--On enregistre les infos sur le sort en cours
	self.attenteFinCast = nextCast
	self.currentSpellName = spellName
	self.startCast = startCast
	--Temps actuel de la simulation : un peu après le dernier cast (ou maintenant si dans le passé)
	if startCast>=self.maintenant then
		self.currentTime = startCast+0.1
	else
		self.currentTime = self.maintenant
	end
	
	if Ovale.trace then
		Ovale:Print("add spell "..spellName.." at "..startCast.." currentTime = "..nextCast)
	end
	
	--Coût du sort (uniquement si dans le futur, dans le passé l'énergie est déjà dépensée)
	if startCast >= self.maintenant then
		--Mana
		local _, _, _, cost = GetSpellInfo(spellName)
		if cost then
			self.state.mana = self.state.mana - cost
		end

		if newSpellInfo then
			--Points de combo
			if newSpellInfo.combo then
				self.state.combo = self.state.combo + newSpellInfo.combo
				if self.state.combo<0 then
					self.state.combo = 0
				end
			end
			--Runes
			if newSpellInfo.frost then
				self:AddRune(startCast, 3, newSpellInfo.frost)
			end
			if newSpellInfo.death then
				self:AddRune(startCast, 4, newSpellInfo.death)
			end
			if newSpellInfo.blood then
				self:AddRune(startCast, 1, newSpellInfo.blood)
			end
			if newSpellInfo.unholy then
				self:AddRune(startCast, 2, newSpellInfo.unholy)
			end
		end
	end
	
	-- Effets du sort
	if newSpellInfo then
		-- Cooldown du sort
		local cd = self:GetCD(spellName)
		if cd then
			cd.start = startCast
			cd.duration = newSpellInfo.cd
			--Pas de cooldown
			if nocd then
				cd.duration = 0
			end
			--On vérifie si le buff "buffnocd" est présent, auquel cas le CD du sort n'est pas déclenché
			if newSpellInfo.buffnocd and not nocd then
				local buffAura = self:GetAura("player", "HELPFUL", newSpellInfo.buffnocd)
				if self.traceAura then
					if buffAura then
						self:Print("buffAura stacks = "..buffAura.stacks.." start="..nilstring(buffAura.start).." ending = "..nilstring(buffAura.ending))
						self:Print("startCast = "..startCast)
					else
						self:Print("buffAura = nil")
					end
					self.traceAura = false
				end
				if buffAura and buffAura.stacks>0 and buffAura.start and buffAura.start<=startCast and (not buffAura.ending or buffAura.ending>startCast) then
					cd.duration = 0
				end
			end
			cd.enable = 1
			if newSpellInfo.toggle then
				cd.toggled = 1
			end
		end

		--Auras causés par le sort
		if newSpellInfo.aura then
			for target, targetInfo in pairs(newSpellInfo.aura) do
				for filter, filterInfo in pairs(targetInfo) do
					for spell, spellData in pairs(filterInfo) do
						local newAura = self:GetAura(target, filter, spell)
						newAura.mine = true
						local duration = spellData
						local stacks = duration
						local auraSpellName = self:GetSpellInfoOrNil(spell)
						--Optionnellement, on va regarder la durée du buff
						if auraSpellName and self.spellInfo[auraSpellName] and self.spellInfo[auraSpellName].duration then
							duration = self.spellInfo[auraSpellName].duration
						end
						if stacks<0 and newAura.ending then
							--if filter~="HELPFUL" or target~="player" or startCast>=Ovale.maintenant then
								newAura.stacks = newAura.stacks + stacks
								if Ovale.trace then
									self:Print("removing aura "..auraSpellName.." because of ".. spellName)
								end
								--Plus de stacks, on supprime l'aura
								if newAura.stacks<=0 then
									newAura.stacks = 0
									newAura.ending = 0
								end
							--end
						elseif newAura.ending and newAura.ending >= endCast then
							newAura.ending = endCast + duration
							newAura.stacks = newAura.stacks + 1
						else
							newAura.start = endCast
							newAura.ending = endCast + duration
							newAura.stacks = 1
						end
						if Ovale.trace then
							if auraSpellName then
								self:Print(spellName.." adding "..stacks.." aura "..auraSpellName.." to "..target.." "..filter.." "..newAura.start..","..newAura.ending)
							else
								self:Print("adding nil aura")
							end
						end
					end
				end
			end
		end
	end
end

function Ovale:InitAllActions()
	self.maintenant = GetTime();
	self.gcd = self:GetGCD()
end

function Ovale:InitCalculerMeilleureAction()
	self.serial = self.serial + 1
	self.currentTime = Ovale.maintenant
	self.currentSpellName = nil
	self.attenteFinCast = Ovale.maintenant
	self.spellStack.length = 0
	self.state.combo = GetComboPoints("player")
	self.state.mana = UnitPower("player")
	if self.className == "DEATHKNIGHT" then
		for i=1,6 do
			self.state.rune[i].type = GetRuneType(i)
			local start, duration, runeReady = GetRuneCooldown(i)
			if runeReady then
				self.state.rune[i].cd = start
			else
				self.state.rune[i].cd = duration + start
				if self.state.rune[i].cd<0 then
					self.state.rune[i].cd = 0
				end
			end
		end
	end
	for k,v in pairs(self.state.cd) do
		v.start = nil
		v.duration = nil
		v.enable = 0
		v.toggled = nil
	end
	
	if (Ovale.db.profile.apparence.latencyCorrection) then
		for i,v in ipairs(self.lastSpell) do
			if not self.spellInfo[v.name] or not self.spellInfo[v.name].toggle then
				--[[local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo("player")
				if spell and spell == v.name and startTime/1000 - v.start < 0.5 and v.stop~=endTime/1000 then
					print("ancien = "..v.stop)
					v.stop = endTime/1000
					print("changement de v.stop en "..v.stop.." "..v.start)
				end]]
				
				if self.maintenant - v.stop<5 then
					self:AddSpellToStack(v.name, v.start, v.stop, v.stop, v.nocd)
				end
			end
		end
		
		local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo("player")
		if (spell) then
			self:AddSpellToStack(spell, startTime/1000, endTime/1000, endTime/1000)
		end
			
	else
		-- On attend que le sort courant soit fini
		local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo("player")
		if (spell) then
			self:AddSpellToStack(spell, startTime/1000, endTime/1000, endTime/1000)
		else
			local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo("player")
			if (spell) then
				self:AddSpellToStack(spell, startTime/1000, endTime/1000, endTime/1000)
			end
		end
	end
end

local function printTime(temps)
	if (temps == nil) then
		Ovale:Print("> nil")
	else
		Ovale:Print("> "..temps)
	end
end

function Ovale:GetGCD(spellName)
	if spellName and self.spellInfo[spellName] then
		if self.spellInfo[spellName].haste == "spell" then
			local cd = self.spellInfo[spellName].gcd
			if not cd then
				cd = 1.5
			end
			cd = cd /(1+self.spellHaste/100)
			if (cd<1) then
				cd = 1
			end
			return cd
		elseif self.spellInfo[spellName].gcd then
			return self.spellInfo[spellName].gcd
		end			
	end
	
	-- Default value
	if self.className == "ROGUE" or (self.className == "DRUID" and GetShapeshiftForm(true) == 3) then
		return 1.0
	elseif self.className == "MAGE" or self.className == "WARLOCK" or self.className == "PRIEST" or
			(self.className == "DRUID" and GetShapeshiftForm(true) ~= 1) then
		local cd = 1.5 /(1+self.spellHaste/100)
		if (cd<1) then
			cd = 1
		end
		return cd
	else
		return 1.5
	end
end

function Ovale:GetComputedSpellCD(spellName)
	local actionCooldownStart, actionCooldownDuration, actionEnable
	local cd = self:GetCD(spellName)
	if cd and cd.start then
		actionCooldownStart = cd.start
		actionCooldownDuration = cd.duration
		actionEnable = cd.enable
	else
		actionCooldownStart, actionCooldownDuration, actionEnable = GetSpellCooldown(spellName)
		-- Les chevaliers de la mort ont des infos fausses sur le CD quand ils n'ont plus les runes
		-- On force à 1,5s ou 1s en présence impie
		if self.className=="DEATHKNIGHT" and actionCooldownDuration==10 and
				(not self.spellInfo[spellName] or self.spellInfo[spellName].cd~=10) then
			local impie = GetSpellInfo(48265)
			if impie and UnitBuff("player", impie) then
				actionCooldownDuration=1
			else
				actionCooldownDuration=1.5
			end
		end
		if self.spellInfo[spellName] and self.spellInfo[spellName].forcecd then
			actionCooldownStart, actionCooldownDuration = GetSpellCooldown(GetSpellInfo(self.spellInfo[spellName].forcecd))
		end
	end
	return actionCooldownStart, actionCooldownDuration, actionEnable
end

function Ovale:GetActionInfo(element)
	if not element then
		return nil
	end
	
	local spellName
	local action
	local actionTexture, actionInRange, actionCooldownStart, actionCooldownDuration,
		actionUsable, actionShortcut, actionIsCurrent, actionEnable
	
	local target = element.params.target
	if (not target) then
		target = "target"
	end

	if (element.func == "Spell" ) then
		spellName = self:GetSpellInfoOrNil(element.params[1])
		if not spellName then
			return nil
		end
		action = self.actionSort[spellName]
		actionCooldownStart, actionCooldownDuration, actionEnable = self:GetComputedSpellCD(spellName)
		
		if (not action or not GetActionTexture(action)) then
			actionTexture = GetSpellTexture(spellName)
			actionInRange = IsSpellInRange(spellName, target)
			actionUsable = IsUsableSpell(spellName)
			actionShortcut = nil
			local casting = UnitCastingInfo("player")
			if (casting == spellName) then
				actionIsCurrent = 1
			else
				actionIsCurrent = nil
			end
			-- not quite the same as IsCurrentAction. Why did they remove IsCurrentCast?
		end
	elseif (element.func=="Macro") then
		action = self.actionMacro[element.params[1]]
	elseif (element.func=="Item") then
		local itemId
		if (type(element.params[1]) == "number") then
			itemId = element.params[1]
		else
			local _,_,id = string.find(GetInventoryItemLink("player",GetInventorySlotInfo(element.params[1])) or "","item:(%d+):%d+:%d+:%d+")
			if not id then
				return nil
			end
			itemId = tonumber(id)
		end
		
		if (Ovale.trace) then
			self:Print("Item "..nilstring(itemId))
		end

		spellName = GetItemSpell(itemId)
		actionUsable = (spellName~=nil)
		
		action = self.actionObjet[itemId]
		if (not action or not GetActionTexture(action)) then
			actionTexture = GetItemIcon(itemId)
			actionInRange = IsItemInRange(itemId, target)
			actionCooldownStart, actionCooldownDuration, actionEnable = GetItemCooldown(itemId)
			actionShortcut = nil
			actionIsCurrent = nil
		end
	elseif element.func=="Texture" then
		actionTexture = "Interface\\Icons\\"..element.params[1]
		actionCooldownStart = Ovale.maintenant
		actionCooldownDuration = 0
		actionEnable = 1
		actionUsable = true
	end
	
	if (action and not actionTexture) then
		actionTexture = GetActionTexture(action)
		actionInRange = IsActionInRange(action, target)
		if not actionCooldownStart then
			actionCooldownStart, actionCooldownDuration, actionEnable = GetActionCooldown(action)
		end
		if (actionUsable == nil) then
			actionUsable = IsUsableAction(action)
		end
		actionShortcut = self.shortCut[action]
		actionIsCurrent = IsCurrentAction(action)				
	end
	
	local cd = self:GetCD(spellName)
	if cd and cd.toggle then
		actionIsCurrent = 1
	end
	
	return actionTexture, actionInRange, actionCooldownStart, actionCooldownDuration,
					actionUsable, actionShortcut, actionIsCurrent, actionEnable, spellName, target, element.params.nored
end

local function subTime(time1, duration)
	if not time1 then
		return nil
	else
		return time1 - duration
	end
end

local function addTime(time1, duration)
	if not time1 then
		return nil
	else
		return time1 + duration
	end
end

local function isBefore(time1, time2)
	return time1 and (not time2 or time1<time2)
end

local function isAfter(time1, time2)
	return not time1 or (time2 and time1>time2)
end

function Ovale:CalculerMeilleureAction(element)
	if (self.bug and not self.trace) then
		return nil
	end
	
	if (not element) then
		return nil
	end
	
	--TODO: créer un objet par type au lieu de ce if else if tout moche
	if (element.type=="function")then
		if (element.func == "Spell" or element.func=="Macro" or element.func=="Item" or element.func=="Texture") then
			local action
			local actionTexture, actionInRange, actionCooldownStart, actionCooldownDuration,
				actionUsable, actionShortcut, actionIsCurrent, actionEnable, spellName = self:GetActionInfo(element)
			
			if (not actionTexture) then
				if (Ovale.trace) then
					self:Print("Action "..element.params[1].." not found")
				end
				return nil
			end
			if (element.params.usable==1 and not actionUsable) then
				if (Ovale.trace) then
					self:Print("Action "..element.params[1].." not usable")
				end
				return nil
			end
			if spellName and self.spellInfo[spellName] and self.spellInfo[spellName].casttime then
				element.castTime = self.spellInfo[spellName].casttime
			elseif spellName then
				local spell, rank, icon, cost, isFunnel, powerType, castTime = GetSpellInfo(spellName)
				if castTime then
					element.castTime = castTime/1000
				else
					element.castTime = nil
				end
			else
				element.castTime = 0
			end
			if (spellName and self.spellInfo[spellName] and self.spellInfo[spellName].toggle and actionIsCurrent) then
				if (Ovale.trace) then
					self:Print("Action "..element.params[1].." is current action")
				end
				return nil
			end
			if (actionEnable and actionEnable>0) then
				local restant
				if (not actionCooldownDuration or actionCooldownStart==0) then
					restant = self.currentTime
				else
					restant = actionCooldownDuration + actionCooldownStart
				end
				
				if restant<self.attenteFinCast then
					if -- spellName==self.currentSpellName or 
						not self.spellInfo[self.currentSpellName] or
							not self.spellInfo[self.currentSpellName].canStopChannelling then
						restant = self.attenteFinCast
					else
						--TODO: pas exact, parce que si ce sort est reporté de par exemple 0,5s par un debuff
						--ça tombera entre deux ticks
						local ticks = self.spellInfo[self.currentSpellName].canStopChannelling
						local tickLength = (self.attenteFinCast - self.startCast) / ticks
						local tickTime = self.startCast + tickLength
						if (Ovale.trace) then
							self:Print(spellName.." restant = " .. restant)
							self:Print("ticks = "..ticks.." tickLength="..tickLength.." tickTime="..tickTime)
						end	
						for i=1,ticks-1 do
							if restant<=tickTime then
								restant = tickTime
								break
							end
							tickTime = tickTime + tickLength
						end
						if (Ovale.trace) then
							self:Print(spellName.." restant = " .. restant)
						end	
					end
				end
				if (Ovale.trace) then
					self:Print("Action "..element.params[1].." remains "..restant)
				end
				local retourPriorite = element.params.priority
				if (not retourPriorite) then
					retourPriorite = 3
				end
				return restant, nil, retourPriorite, element
			else
				if (Ovale.trace) then
					self:Print("Action "..element.params[1].." not enabled")
				end
			end
		else
			local classe = Ovale.conditions[element.func]
			if (not classe) then
				self.bug = true
				self:Print("Function "..element.func.." not found")
				return nil
			end
			local start, ending = classe(element.params)
			
			if (Ovale.trace) then
				self:Print("Function "..element.func.." returned "..nilstring(start)..","..nilstring(ending))
			end
			
			return start, ending
		end
	elseif element.type == "time" then
		return element.value
	elseif (element.type == "before") then
		if (Ovale.trace) then
			self:Print(element.time.."s before ["..element.nodeId.."]")
		end
		local timeA = Ovale:CalculerMeilleureAction(element.time)
		local startA, endA = Ovale:CalculerMeilleureAction(element.a)
		return addTime(startA, -timeA), addTime(endA, -timeA)
	elseif (element.type == "between") then
		self:Log("between")
		local tempsA = Ovale:CalculerMeilleureAction(element.a)
		local tempsB = Ovale:CalculerMeilleureAction(element.b)
		if tempsB==nil and tempsA==nil then
			Ovale:Log("diff returns 0 because the two nodes are nil")
			return 0
		end
		
		if tempsA==nil or tempsB==nil then
			if Ovale.trace then Ovale:Print(element.type.." return nil") end
			return nil
		end
		local diff
		if tempsA>tempsB then
			diff = tempsA - tempsB
		else
			diff = tempsB - tempsA
		end
		Ovale:Log("diff returns "..diff)
		return diff
	elseif element.type == "fromuntil" then
		self:Log("fromuntil")
		local tempsA = Ovale:CalculerMeilleureAction(element.a)
		if (tempsA==nil) then
			if Ovale.trace then Ovale:Print(element.type.." return nil") end
			return nil
		end
		local tempsB = Ovale:CalculerMeilleureAction(element.b)
		if (tempsB==nil) then
			if Ovale.trace then Ovale:Print(element.type.." return nil") end
			return nil
		end
		Ovale:Log("fromuntil returns "..(tempsB - tempsA))
		return tempsB - tempsA
	elseif element.type == "compare" then
		self:Log("compare "..element.comparison)
		local tempsA = Ovale:CalculerMeilleureAction(element.a)
		local timeB = Ovale:CalculerMeilleureAction(element.time)
		self:Log(tempsA.." "..element.comparison.." "..timeB)
		if element.comparison == "more" and (not tempsA or tempsA>timeB) then
			if Ovale.trace then Ovale:Print(element.type.." return 0") end
			return 0
		elseif element.comparison == "less" and tempsA and tempsA<timeB then
			if Ovale.trace then Ovale:Print(element.type.." return 0") end
			return 0
		elseif element.comparison == "at most" and tempsA and tempsA<=timeB then
			if Ovale.trace then Ovale:Print(element.type.." return 0") end
			return 0
		elseif element.comparison == "at least" and (not tempsA or tempsA>=timeB) then
			if Ovale.trace then Ovale:Print(element.type.." return 0") end
			return 0
		end
		return nil
	elseif (element.type == "and" or element.type == "if") then
		if (Ovale.trace) then
			self:Print(element.type.." ["..element.nodeId.."]")
		end
		local startA, endA = Ovale:CalculerMeilleureAction(element.a)
		if (startA==nil) then
			if Ovale.trace then Ovale:Print(element.type.." return nil  ["..element.nodeId.."]") end
			return nil
		end
		if startA == endA then
			if Ovale.trace then Ovale:Print(element.type.." return startA=endA  ["..element.nodeId.."]") end
			return nil
		end
		local startB, endB, prioriteB, elementB = Ovale:CalculerMeilleureAction(element.b)
		if isAfter(startB, endA) or isAfter(startA, endB) then
			if Ovale.trace then Ovale:Print(element.type.." return nil ["..element.nodeId.."]") end
			return nil
		end
		if isBefore(startB, startA) then
			startB = startA
		end
		if isAfter(endB, endA) then
			endB = endA
		end
		if Ovale.trace then
			Ovale:Print(element.type.." return "..nilstring(startB)..","..nilstring(endB).." ["..element.nodeId.."]")
		end
		return startB, endB, prioriteB, elementB
	elseif (element.type == "unless") then
		if (Ovale.trace) then
			self:Print(element.type)
		end
		local startA, endA = Ovale:CalculerMeilleureAction(element.a)
		local startB, endB, prioriteB, elementB = Ovale:CalculerMeilleureAction(element.b)
		
		if isBefore(startA, startB) and isAfter(endA, endB) then
			if Ovale.trace then Ovale:Print(element.type.." return nil") end
			return nil
		end
		
		if isAfter(startA, startB) and isBefore(endA, endB) then
			if Ovale.trace then Ovale:Print(element.type.." return "..nilstring(endA)..","..nilstring(endB)) end
			return endA, endB, prioriteB, elementB
		end
		
		if isAfter(startA, startB) and isBefore(startA, endB) then
			endB = startA
		end
		
		if isAfter(endA, startB) and isBefore(endA, endB) then
			startB = endA
		end
					
		if Ovale.trace then Ovale:Print(element.type.." return "..nilstring(startB)..","..nilstring(endB)) end
		return startB, endB, prioriteB, elementB
	elseif (element.type == "or") then
		if (Ovale.trace) then
			self:Print(element.type)
		end
		
		local startA, endA = Ovale:CalculerMeilleureAction(element.a)
		local startB, endB = Ovale:CalculerMeilleureAction(element.b)
		if isBefore(endA,self.currentTime) then
			return startB,endB
		elseif isBefore(endB,self.currentTime) then
			return startA,endA
		end		
		
		if isBefore(endA,startB) then
			return startA,endA
		elseif isBefore(endB,startA) then
			return startB,endB
		end
				
		if isBefore(startA, startB) then
			startB = startA
		end
		if isAfter(endA, endB) then
			endB = endA
		end
		return startB, endB
	elseif (element.type == "group") then
		local meilleurTempsFils
		local bestEnd
		local meilleurePrioriteFils
		local bestElement
		local bestCastTime
		 
		if (Ovale.trace) then
			self:Print(element.type.." ["..element.nodeId.."]")
		end
		
		for k, v in ipairs(element.nodes) do
			local newStart, newEnd, priorite, nouveauElement = Ovale:CalculerMeilleureAction(v)
			if newStart~=nil and newStart<Ovale.currentTime then
				newStart = Ovale.currentTime
			end

			
			if newStart and (not newEnd or newStart<=newEnd) then
				local remplacer

				local newCastTime
				if nouveauElement then
					newCastTime = nouveauElement.castTime
				end
				if not newCastTime or newCastTime < self.gcd then
					newCastTime = self.gcd
				end
			
				if (not meilleurTempsFils) then
					remplacer = true
				else
					-- temps maximum entre le nouveau sort et le précédent
					local maxEcart
					if (priorite and not meilleurePrioriteFils) then
						self.bug = true
						self:Print("Internal error: meilleurePrioriteFils=nil and priorite="..priorite)
						return nil
					end
					if (priorite and priorite > meilleurePrioriteFils) then
						-- Si le nouveau sort est plus prioritaire que le précédent, on le lance
						-- si caster le sort actuel repousse le nouveau sort
						maxEcart = bestCastTime*0.75
					elseif (priorite and priorite < meilleurePrioriteFils) then
						-- A l'inverse, si il est moins prioritaire que le précédent, on ne le lance
						-- que si caster le nouveau sort ne repousse pas le meilleur
						maxEcart = -newCastTime*0.75
					else
						maxEcart = -0.01
					end
					if (newStart-meilleurTempsFils < maxEcart) then
						remplacer = true
					end
				end
				if (remplacer) then
					meilleurTempsFils = newStart
					meilleurePrioriteFils = priorite
					bestElement = nouveauElement
					bestEnd = newEnd
					bestCastTime = newCastTime
				end
			end
		end
		
		if (meilleurTempsFils) then
			if (Ovale.trace) then
				if bestElement then
					self:Print("group best action "..bestElement.params[1].." remains "..meilleurTempsFils..","..nilstring(bestEnd).." ["..element.nodeId.."]")
				else
					self:Print("group no best action returns "..meilleurTempsFils..","..nilstring(bestEnd).." ["..element.nodeId.."]")
				end
			end
			return meilleurTempsFils, bestEnd, meilleurePrioriteFils, bestElement
		else
			if (Ovale.trace) then self:Print("group return nil") end
			return nil
		end
	end
	if (Ovale.trace) then self:Print("unknown element "..element.type..", return nil") end
	return nil
end

function Ovale:ChargerDefaut()
	local localizedClass, englishClass = UnitClass("player")
	
	self.db = LibStub("AceDB-3.0"):New("OvaleDB",
	{
		profile = 
		{
			display = true,
			code = Ovale.defaut[englishClass],
			left = 500,
			top = 500,
			check = {},
			list = {},
			apparence = {enCombat=false, iconWidth = 64, iconHeight = 64, margin = 4,
				smallIconWidth=28, smallIconHeight=28, raccourcis=true, numeric=false, avecCible = false,
				verrouille = false, vertical = false, predictif=false, highlightIcon = true, clickThru = false, latencyCorrection=true, hideVehicule=true},
			skin = {SkinID="Blizzard", Backdrop = true, Gloss = false, Colors = {}}
		}
	})
end

function Ovale:AfficherConfig()
	self.AceConfigDialog:SetDefaultSize("Ovale Apparence", 500, 550)
	self.AceConfigDialog:Open("Ovale Apparence", configFrame)
end

function Ovale:AfficherCode()
	self.AceConfigDialog:SetDefaultSize("Ovale", 500, 550)
	self.AceConfigDialog:Open("Ovale", configFrame)
end

local function OnCheckBoxValueChanged(widget)
	Ovale.db.profile.check[widget.userdata.k] = widget:GetValue()
end

local function OnDropDownValueChanged(widget)
	Ovale.db.profile.list[widget.userdata.k] = widget.value
end

function Ovale:ToggleOptions()
	self.frame:ToggleOptions()
end

function Ovale:UpdateVisibility()
	if not Ovale.db.profile.display then
		self.frame:Hide()
		return
	end

	self.frame:Show()

	if Ovale.db.profile.apparence.hideVehicule and UnitInVehicle("player") then
		self.frame:Hide()
	end
	
	if Ovale.db.profile.apparence.avecCible and not UnitExists("target") then
		self.frame:Hide()
	end
	
	if Ovale.db.profile.apparence.enCombat and not Ovale.enCombat then
		self.frame:Hide()
	end	
	
	if Ovale.db.profile.apparence.targetHostileOnly and (UnitIsDead("target") or not UnitCanAttack("player", "target")) then
		self.frame:Hide()
	end
end

function Ovale:UpdateFrame()
	self.frame:ReleaseChildren()

	self.frame:UpdateIcons()
	
	self:UpdateVisibility()
	
	self.checkBoxes = {}
	
	for k,checkBox in pairs(self.casesACocher) do
		self.checkBoxes[k] = LibStub("AceGUI-3.0"):Create("CheckBox");
		self.frame:AddChild(self.checkBoxes[k])
		self.checkBoxes[k]:SetLabel(checkBox.text)
		if self.db.profile.check[k]==nil then
			self.db.profile.check[k] = checkBox.checked
		end
		if (self.db.profile.check[k]) then
			self.checkBoxes[k]:SetValue(self.db.profile.check[k]);
		end
		self.checkBoxes[k].userdata.k = k
		self.checkBoxes[k]:SetCallback("OnValueChanged",OnCheckBoxValueChanged)
	end
	
	self.dropDowns = {}
	
	if (self.listes) then
		for k,list in pairs(self.listes) do
			self.dropDowns[k] = LibStub("AceGUI-3.0"):Create("Dropdown");
			self.dropDowns[k]:SetList(list.items)
			if not self.db.profile.list[k] then
				self.db.profile.list[k] = list.default
			end
			if (self.db.profile.list[k]) then
				self.dropDowns[k]:SetValue(self.db.profile.list[k]);
			end
			self.dropDowns[k].userdata.k = k
			self.dropDowns[k]:SetCallback("OnValueChanged",OnDropDownValueChanged)
			self.frame:AddChild(self.dropDowns[k])
		end
	end
end

function Ovale:IsChecked(v)
	return self.checkBoxes[v] and self.checkBoxes[v]:GetValue()
end

function Ovale:GetListValue(v)
	return self.dropDowns[v] and self.dropDowns[v].value
end

function Ovale:GetSpellInfo(spell)
	if (not self.spellInfo[spell]) then
		self.spellInfo[spell] = { aura = {player = {}, target = {}} }
	end
	return self.spellInfo[spell]
end

function Ovale:ResetSpellInfo()
	self.spellInfo = {}
end

function Ovale:EnableOtherDebuffs()
	if self.otherDebuffsEnabled then
		return
	end
	self.otherDebuffsEnabled = true
end

function Ovale:ToggleCheckBox(v)
	for k,checkBox in pairs(self.casesACocher) do
		if v==0 then
			self.checkBoxes[k]:SetValue(not self.checkBoxes[k]:GetValue())
			break
		end
		v = v - 1
	end
end