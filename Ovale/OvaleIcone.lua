local LBF = LibStub("LibButtonFacade", true)
local L = LibStub("AceLocale-3.0"):GetLocale("Ovale")
local RANGE_INDICATOR = "●";

local function Update(self, element, minAttente, actionTexture, actionInRange, actionCooldownStart, actionCooldownDuration,
				actionUsable, actionShortcut, actionIsCurrent, actionEnable, spellName, actionTarget)
				
	self.spellName = spellName
	if (minAttente~=nil and actionTexture) then	
	
		if (actionTexture~=self.actionCourante or self.ancienneAttente==nil or 
			(minAttente~=Ovale.maintenant and minAttente>self.ancienneAttente+0.01) or
			(minAttente < self.finAction-0.01)) then
			if (actionTexture~=self.actionCourante or self.ancienneAttente==nil or 
					(minAttente~=Ovale.maintenant and minAttente>self.ancienneAttente+0.01)) then
				self.debutAction = Ovale.maintenant
			end
			self.actionCourante = actionTexture
			self.finAction = minAttente
			if (minAttente == Ovale.maintenant) then
				self.cd:Hide()
			else
				self.lastSound = nil
				self.cd:Show()
				self.cd:SetCooldown(self.debutAction, self.finAction - self.debutAction);
			end
		end
		
		self.ancienneAttente = minAttente
		
		-- L'icône avec le cooldown
		self.icone:Show()
		self.icone:SetTexture(actionTexture);
		
		if (actionUsable) then
			self.icone:SetAlpha(1.0)
		else
			self.icone:SetAlpha(0.33)
		end
		
		local red
		if (minAttente > actionCooldownStart + actionCooldownDuration + 0.01 and minAttente > Ovale.maintenant
			and minAttente>Ovale.attenteFinCast) then
			self.icone:SetVertexColor(0.75,0.2,0.2)
			red = true
		else
			self.icone:SetVertexColor(1,1,1)
		end 
		
		--if (minAttente==Ovale.maintenant) then
			--self.cd:Hide()
		--end

		if element.params.sound and not self.lastSound then
			local delay = self.soundtime or 0.5
			if Ovale.maintenant>=minAttente - delay then
				self.lastSound = element.params.sound
			--	print("Play" .. self.lastSound)
				PlaySoundFile(self.lastSound)
			end
		end
		
		-- La latence
		if minAttente>Ovale.maintenant and Ovale.db.profile.apparence.highlightIcon and not red then
			local lag = 0.6
			local newShouldClick
			if minAttente<Ovale.maintenant + lag then
				newShouldClick = true
			else
				newShouldClick = false
			end
			if self.shouldClick ~= newShouldClick then
				if newShouldClick then
					self:SetChecked(1)
				else
					self:SetChecked(0)
				end
				self.shouldClick = newShouldClick
			end
		elseif self.shouldClick then
			self.shouldClick = false
			self:SetChecked(0)
		end
		
		-- Le temps restant
		if (Ovale.db.profile.apparence.numeric and minAttente > Ovale.maintenant) then
			self.remains:SetText(string.format("%.1f", minAttente - Ovale.maintenant))
			self.remains:Show()
		else
			self.remains:Hide()
		end
		
		-- Le raccourcis clavier 
		if (Ovale.db.profile.apparence.raccourcis) then
			self.shortcut:Show()
			self.shortcut:SetText(actionShortcut)
		else
			self.shortcut:Hide()
			self.shortcut:SetText("")
		end
		
		-- L'indicateur de portée
		self.aPortee:Show()
		if (actionInRange==1) then
			self.aPortee:SetVertexColor(0.6,0.6,0.6)
			self.aPortee:Show()
		elseif (actionInRange==0) then
			self.aPortee:SetVertexColor(1.0,0.1,0.1)
			self.aPortee:Show()
		else
			self.aPortee:Hide()
		end
		if actionTarget=="focus" then
			self.focusText:Show()
		else
			self.focusText:Hide()
		end
		self:Show()
	else
		self.icone:Hide()
		self.aPortee:Hide()
		self.shortcut:Hide()
		self.remains:Hide()
		self.focusText:Hide()
		if Ovale.db.profile.apparence.hideEmpty then
			self:Hide()
		else
			self:Show()
		end
		if self.shouldClick then
			self:SetChecked(0)
			self.shouldClick = false
		end
	end
	
	
	return minAttente,element
end

local function SetSkinGroup(self, _skinGroup)
	self.skinGroup = _skinGroup
	self.skinGroup:AddButton(self)
end

local function SetSize(self, width, height)
	self:SetWidth(width)
	self:SetHeight(height)
	if (not LBF) then
		self.normalTexture:SetWidth(width*66/36)
		self.normalTexture:SetHeight(height*66/36)
		self.shortcut:SetWidth(width)
		self.remains:SetWidth(width)
	end
end

local function SetHelp(self, help)
	self.help = help
end

function OvaleIcone_OnClick(self)
	Ovale:ToggleOptions()
	self:SetChecked(0)
end

function OvaleIcone_OnEnter(self)
	if self.help or next(Ovale.casesACocher) or next(Ovale.listes) or self.spellName then
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
		if self.help then
			GameTooltip:SetText(L[self.help])
		end
		if self.spellName then
			GameTooltip:AddLine(self.spellName,0.5,1,0.75)
		end
		if next(Ovale.casesACocher) or next(Ovale.listes) then
			GameTooltip:AddLine(L["Cliquer pour afficher/cacher les options"],1,1,1)
		end
		GameTooltip:Show()
	end
end

function OvaleIcone_OnLeave(self)
	if self.help  or next(Ovale.casesACocher) or next(Ovale.listes)  then
		GameTooltip:Hide()
	end
end

function OvaleIcone_OnLoad(self)
	local name = self:GetName()
	self.icone = _G[name.."Icon"]
	self.shortcut = _G[name.."HotKey"]
	self.remains = _G[name.."Name"]
	self.aPortee = _G[name.."Count"]
	self.aPortee:SetText(RANGE_INDICATOR)
	self.cd = _G[name.."Cooldown"]
	self.normalTexture = _G[name.."NormalTexture"]
	
	self.focusText = self:CreateFontString(nil, "OVERLAY");
	self.focusText:SetFontObject("GameFontNormal");
	self.focusText:SetAllPoints(self);
	self.focusText:SetTextColor(1,1,1);
	self.focusText:SetText(L["Focus"])
	
	self:RegisterForClicks("LeftButtonUp")
	self.SetSkinGroup = SetSkinGroup
	self.Update = Update
	self.SetSize = SetSize
	self.SetHelp = SetHelp
	if Ovale.db.profile.clickThru then
		self:EnableMouse(false)
	end
end

