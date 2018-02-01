local AceGUI = LibStub("AceGUI-3.0")
local LBF = LibStub("LibButtonFacade", true)
		
----------------
-- Main Frame --
----------------
--[[
	Events :
		OnClose

]]
do
	local Type = "OvaleFrame"
	local Version = 7

	local function frameOnClose(this)
		this.obj:Fire("OnClose")
	end
	
	local function closeOnClick(this)
		this.obj:Hide()
	end
	
	local function frameOnMouseDown(this)
		if (not Ovale.db.profile.apparence.verrouille) then
			this:StartMoving()
			AceGUI:ClearFocus()
		end
	end
	
	local function ToggleOptions(this)
		if (this.content:IsShown()) then
			this.content:Hide()
		else
			this.content:Show()
		end
	end
	
	local function frameOnMouseUp(this)
		this:StopMovingOrSizing()
		
		if (Ovale.db.profile.left~=this:GetLeft() or Ovale.db.profile.top ~=this:GetTop()) then
			Ovale.db.profile.left = this:GetLeft()
			Ovale.db.profile.top = this:GetTop()
		end
	end
	
	local function frameOnEnter(this)
		if (not Ovale.db.profile.apparence.verrouille) then
			this.obj.barre:Show()
		end
	end
	
	local function frameOnLeave(this)
		this.obj.barre:Hide()

	end
	
	local function frameOnUpdate(self)
		self.obj:OnUpdate()
	end
	
	local function Hide(self)
		self.frame:Hide()
	end
	
	local function Show(self)
		self.frame:Show()
	end
	
	local function OnAcquire(self)
		self.frame:SetParent(UIParent)
	end
	
	local function OnRelease(self)
	end
	
	local function OnWidthSet(self, width)
		local content = self.content
		local contentwidth = width - 34
		if contentwidth < 0 then
			contentwidth = 0
		end
		content:SetWidth(contentwidth)
		content.width = contentwidth
	end
	
	
	local function OnHeightSet(self, height)
		local content = self.content
		local contentheight = height - 57
		if contentheight < 0 then
			contentheight = 0
		end
		content:SetHeight(contentheight)
		content.height = contentheight
	end
	
	local function OnLayoutFinished(self, width, height)
		if (not width) then
			width = self.content:GetWidth()
		end
		self.content:SetWidth(width)
		self.content:SetHeight(height+50)
	end
	
	local function OnSkinChanged(self, skinID, gloss, backdrop, group, button, colors)
		Ovale.db.profile.SkinID = skinID
		Ovale.db.profile.Gloss = gloss
		Ovale.db.profile.Backdrop = backdrop
		Ovale.db.profile.Colors = colors
	end
	
	local function GetScore(self, spellName)
		for k,action in pairs(self.actions) do
			if action.spellName == spellName then
				if not action.waitStart then
					-- print("sort "..spellName.." parfait")
					return 1
				else
					local lag = Ovale.maintenant - action.waitStart
					if lag>5 then
					-- 	print("sort "..spellName.." ignoré (>5s)")
						return nil
					elseif lag>1.5 then
					-- 	print("sort "..spellName.." trop lent !")
						return 0
					elseif lag>0 then
					-- 	print("sort "..spellName.." un peu lent "..lag)
						return 1-lag/1.5
					else
					-- 	print("sort "..spellName.." juste bon")
						return 1
					end
				end
			end
		end
--		print("sort "..spellName.." incorrect")
		return 0
	end
	
	local function OnUpdate(self)
		if not Ovale.listeTalentsRemplie then
			Ovale:RemplirListeTalents()
		end
		if Ovale.needCompile then
			Ovale:CompileAll()
			return
		end
		Ovale:InitAllActions()
		for k,node in pairs(Ovale.masterNodes) do
			if Ovale.trace then
				Ovale:Print("****Master Node "..k)
			end
			Ovale:InitCalculerMeilleureAction()
			local start, ending, priorite, element = Ovale:CalculerMeilleureAction(node)
			
			local action = self.actions[k]
			
			local actionTexture, actionInRange, actionCooldownStart, actionCooldownDuration,
					actionUsable, actionShortcut, actionIsCurrent, actionEnable, spellName, actionTarget, noRed = Ovale:GetActionInfo(element)
			if noRed then
				start = actionCooldownStart + actionCooldownDuration
			end
			
			-- Dans le cas de canStopChannelling, on risque de demander d'interrompre le channelling courant, ce qui est stupide
			if start and Ovale.currentSpellName and Ovale.attenteFinCast and spellName == Ovale.currentSpellName and start<Ovale.attenteFinCast then
				start = Ovale.attenteFinCast
			end
			
			if (node.params.nocd and start~=nil and Ovale.maintenant<start-node.params.nocd) then
				action.icons[1]:Update(element, nil)
			else
				action.icons[1]:Update(element, start, actionTexture, actionInRange, actionCooldownStart, actionCooldownDuration,
					actionUsable, actionShortcut, actionIsCurrent, actionEnable, spellName, actionTarget)
			end
			
			action.spellName = spellName
			
			if start == Ovale.maintenant and actionUsable then
				if not action.waitStart then
					action.waitStart = Ovale.maintenant
				end
			else
				action.waitStart = nil
			end
			
			if Ovale.db.profile.apparence.moving and action.icons[1].debutAction and action.icons[1].finAction then
				local top=1-(Ovale.maintenant - action.icons[1].debutAction)/(action.icons[1].finAction-action.icons[1].debutAction)
				if top<0 then
					top = 0
				elseif top>1 then
					top = 1
				end
				action.icons[1]:SetPoint("TOPLEFT",self.frame,"TOPLEFT",action.left + top*action.dx,action.top - top*action.dy)
				if action.icons[2] then
					action.icons[2]:SetPoint("TOPLEFT",self.frame,"TOPLEFT",action.left + (top+1)*action.dx,action.top - (top+1)*action.dy)
				end
			end
								
			if (node.params.size ~= "small" and not node.params.nocd and Ovale.db.profile.apparence.predictif) then
				if start then
					local castTime=0
					if spellName then
						local _, _, _, _, _, _, _castTime = GetSpellInfo(spellName)
						if _castTime and _castTime>0 then
							castTime = _castTime/1000
						end
					end
					local gcd = Ovale:GetGCD(spellName)
					local nextCast
					if (castTime>gcd) then
						nextCast = start + castTime 
					else
						nextCast = start + gcd
					end					
					if Ovale.trace then
						Ovale:Print("****Second icon")
					end
					Ovale:AddSpellToStack(spellName, start, start + castTime, nextCast)
					start, ending, priorite, element = Ovale:CalculerMeilleureAction(node)
					action.icons[2]:Update(element, start, Ovale:GetActionInfo(element))
				else
					action.icons[2]:Update(element, nil)
				end
			end
		end
		
		if (not Ovale.bug) then
			Ovale.traced = false
		end
		
		if (Ovale.trace) then
			Ovale.trace=false
			Ovale.traced = true
		end
		
		if (Ovale.bug and not Ovale.traced) then
			Ovale.trace = true
		end	
	end
	
	local function UpdateIcons(self)
		for k, action in pairs(self.actions) do
			for i, icon in pairs(action.icons) do
				icon:Hide()
			end
		end
		
		self.frame:EnableMouse(not Ovale.db.profile.apparence.clickThru)
		
		local left = 0
		local maxHeight = 0
		local maxWidth = 0
		local top = 0
		
		if (not Ovale.masterNodes) then
			return;
		end
		
		local BARRE = 8
		
		local margin =  Ovale.db.profile.apparence.margin
			
		for k,node in pairs(Ovale.masterNodes) do
			if not self.actions[k] then
				self.actions[k] = {icons={}}
			end
			local action = self.actions[k]

			local width, height
			local nbIcons
			if (node.params.size == "small") then
				width = Ovale.db.profile.apparence.smallIconWidth + margin
				height = Ovale.db.profile.apparence.smallIconHeight + margin
				nbIcons = 1
			else
				width = Ovale.db.profile.apparence.iconWidth + margin
				height = Ovale.db.profile.apparence.iconHeight + margin
				if Ovale.db.profile.apparence.predictif then
					nbIcons = 2
				else
					nbIcons = 1
				end
			end
			if (top + height > Ovale.db.profile.apparence.iconHeight + margin) then
				top = 0
				left = maxWidth
			end
			
			action.width = width - margin
			action.height = height - margin
			if (Ovale.db.profile.apparence.vertical) then
				action.left = top
				action.top = -left-BARRE-margin
				action.dx = action.width
				action.dy = 0
			else
				action.left = left
				action.top = -top-BARRE-margin
				action.dx = 0
				action.dy = action.height
			end
					
			for l=1,nbIcons do
				if (not action.icons[l]) then
					action.icons[l] = CreateFrame("CheckButton", "Icon"..k.."n"..l,self.frame,"OvaleIcone");
				end			
				local icon = action.icons[l]
				icon:SetPoint("TOPLEFT",self.frame,"TOPLEFT",action.left + (l-1)*action.dx,action.top - (l-1)*action.dy)
				icon:SetSize(action.width, action.height)
				icon:SetHelp(node.params.help)
				icon:EnableMouse(not Ovale.db.profile.apparence.clickThru)
				
				if LBF then
					icon:SetSkinGroup(self.skinGroup)
				end
				if l==1 then
					icon:Show();
				end
			end
			
			top = top + height
			if (top> maxHeight) then
				maxHeight = top
			end
			if (left + width > maxWidth) then
				maxWidth = left + width
			end
		end
		
		if (Ovale.db.profile.apparence.vertical) then
			self.barre:SetWidth(maxHeight - margin)
			self.barre:SetHeight(BARRE)
			self.frame:SetWidth(maxHeight)
			self.frame:SetHeight(maxWidth+BARRE+margin)
			self.content:SetPoint("TOPLEFT",self.frame,"TOPLEFT",maxHeight,0)
		else
			self.barre:SetWidth(maxWidth - margin)
			self.barre:SetHeight(BARRE)
			self.frame:SetWidth(maxWidth)
			self.frame:SetHeight(maxHeight+BARRE+margin)
			self.content:SetPoint("TOPLEFT",self.frame,"TOPLEFT",maxWidth,0)
		end
	end
	
	local function Constructor()
		local frame = CreateFrame("Frame",nil,UIParent)
		local self = {}
		
		self.type = "Frame"
		
		self.Hide = Hide
		self.Show = Show
		self.OnRelease = OnRelease
		self.OnAcquire = OnAcquire
		self.ApplyStatus = ApplyStatus
		self.LayoutFinished = OnLayoutFinished
		self.UpdateIcons = UpdateIcons
		self.OnSkinChanged = OnSkinChanged
		self.ToggleOptions = ToggleOptions
		self.OnUpdate = OnUpdate
		self.GetScore = GetScore
		
		self.localstatus = {}
		self.actions = {}
		
		
		self.frame = frame
		frame.obj = self
		frame:SetWidth(100)
		frame:SetHeight(100)
		frame:SetPoint("CENTER",UIParent,"CENTER",0,0)
		if not Ovale.db.profile.apparence.clickThru then
			frame:EnableMouse()
		end
		frame:SetMovable(true)
		frame:SetFrameStrata("BACKGROUND")
		frame:SetScript("OnMouseDown", frameOnMouseDown)
		frame:SetScript("OnMouseUp", frameOnMouseUp)
		frame:SetScript("OnEnter", frameOnEnter)
		frame:SetScript("OnLeave", frameOnLeave)
	--	frame:SetScript("OnUpdate", frameOnUpdate)		
		frame:SetScript("OnHide",frameOnClose)

		self.updateFrame = CreateFrame("Frame")
		self.updateFrame:SetScript("OnUpdate", frameOnUpdate)
		self.updateFrame.obj = self
		
		self.barre = self.frame:CreateTexture();
		self.barre:SetTexture(0,0.8,0)
		self.barre:SetPoint("TOPLEFT",0,0)
		self.barre:Hide()
			
		--Container Support
		local content = CreateFrame("Frame",nil,frame)
		self.content = content
		content.obj = self
		content:SetWidth(200)
		content:SetHeight(100)
		content:Hide()
		
		AceGUI:RegisterAsContainer(self)

		if LBF then
			self.skinGroup = LBF:Group("Ovale")
			self.skinGroup.SkinID = Ovale.db.profile.SkinID
			self.skinGroup.Gloss = Ovale.db.profile.Gloss
			self.skinGroup.Backdrop = Ovale.db.profile.Backdrop
			self.skinGroup.Colors = Ovale.db.profile.Colors or {}
			LBF:RegisterSkinCallback("Ovale", self.OnSkinChanged, self)
		end

		return self	
	end
	
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end

