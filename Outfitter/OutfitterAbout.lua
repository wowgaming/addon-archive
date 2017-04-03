----------------------------------------
-- Outfitter Copyright 2009, 2010 John Stephen, wobbleworks.com
-- All rights reserved, unauthorized redistribution is prohibited
----------------------------------------

----------------------------------------
Outfitter._AboutView = {}
----------------------------------------

function Outfitter._AboutView:New(pParent)
	return OutfitterAboutFrame
end

function Outfitter._AboutView:Construct(pParent)
	self.Title = self:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	self.Title:SetPoint("TOP", self, "TOP", -4, -36)
	self.Title:SetWidth(230)
	self.Title:SetText(Outfitter.cAboutTitle:format(Outfitter.cVersion))
	
	self.AuthorText = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	self.AuthorText:SetPoint("TOP", self.Title, "BOTTOM", 0, -15)
	self.AuthorText:SetWidth(230)
	self.AuthorText:SetJustifyH("CENTER")
	self.AuthorText:SetText(Outfitter.cAboutAuthor)
	
	self.CopyrightText = self:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	self.CopyrightText:SetPoint("TOP", self.AuthorText, "BOTTOM", 0, -10)
	self.CopyrightText:SetWidth(230)
	self.CopyrightText:SetJustifyH("CENTER")
	self.CopyrightText:SetText(Outfitter.cAboutCopyright)
	
	self.ThanksText = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	self.ThanksText:SetPoint("TOP", self.CopyrightText, "BOTTOM", 0, -10)
	self.ThanksText:SetWidth(230)
	self.ThanksText:SetJustifyH("CENTER")
	self.ThanksText:SetText(Outfitter.cAboutThanks)
	
	self.Credits = Outfitter:New(Outfitter._Credits, self)
	self.Credits:SetPoint("TOP", self.ThanksText, "BOTTOM", 0, -10)
	self.Credits:SetWidth(230)
	self.Credits:SetHeight(200)
	
	--self.TestTexture = self.Credits:CreateTexture(nil, "OVERLAY")
	--self.TestTexture:SetAllPoints()
	--self.TestTexture:SetTexture(1, 0, 0, 0.5)
end

----------------------------------------
Outfitter._Credits = {}
----------------------------------------

function Outfitter._Credits:New(pParent)
	return CreateFrame("Frame", nil, pParent)
end

function Outfitter._Credits:Construct(pParent)
	self.CreditFrames = {}
	self.AvailableCreditFrames = {}
	
	self:SetScript("OnShow", self.OnShow)
	self:SetScript("OnHide", self.OnHide)
	self:SetScript("OnUpdate", self.OnUpdate)
	
	-- Compile the list
	
	-- Add everything except the current realm
	
	self.Players = {}
	
	for vRealm, vRealmPlayers in pairs(Outfitter.CreditPlayersByRealm) do
		if vRealm ~= Outfitter.RealmName then
			for vPlayerName, vPlayerInfo in pairs(vRealmPlayers) do
				if type(vPlayerInfo) == "number" then
					table.insert(self.Players,
					{
						Name = vPlayerName,
						Realm = vRealm,
						Level = vPlayerInfo
					})
				end
			end
		end
	end -- for
	
	-- Add the current realm
	
	local vRealmPlayers = Outfitter.CreditPlayersByRealm[Outfitter.RealmName]
	
	if vRealmPlayers then
		-- Calculate how many players there are in the current realm
		
		local vNumRealmPlayers = 0
		
		for vPlayerName, vPlayerInfo in pairs(vRealmPlayers) do
			vNumRealmPlayers = vNumRealmPlayers + 1
		end
		
		-- Calculate the desired percentage of players from this realm.  This
		-- ensures that donors and other contributors will show up more often
		-- to themselves and other players on their realms
		
		local vLocalPercentage = 0.02 * vNumRealmPlayers
		
		if vLocalPercentage > 0.5 then
			vLocalPercentage = 0.5
		end
		
		-- Calculate the minimum number of players to add and repeatedly add the
		-- realm until that minimum is met
		
		local vMinRealmPlayers = #self.Players * vLocalPercentage / (1 - vLocalPercentage)
		
		repeat
			for vPlayerName, vPlayerInfo in pairs(vRealmPlayers) do
				if type(vPlayerInfo) == "number" then
					table.insert(self.Players,
					{
						Name = vPlayerName,
						Realm = Outfitter.RealmName,
						Level = vPlayerInfo
					})
				end
				
				vMinRealmPlayers = vMinRealmPlayers - 1
			end
		until vMinRealmPlayers <= 0
	end
	
	self:Shuffle()
	
	self.PlayerIndex = 1
	self.NextPlayerTime = 0
end

function Outfitter._Credits:Shuffle()
	for _, vPlayerInfo in ipairs(self.Players) do
		vPlayerInfo.SortValue = math.random()
	end
	
	table.sort(self.Players, function (pInfo1, pInfo2)
		return pInfo1.SortValue < pInfo2.SortValue
	end)
end

function Outfitter._Credits:OnShow()
	while next(self.AvailableCreditFrames) do
		table.remove(self.AvailableCreditFrames)
	end
	
	for _, vCreditFrame in ipairs(self.CreditFrames) do
		table.insert(self.AvailableCreditFrames, vCreditFrame)
	end
end

function Outfitter._Credits:OnHide()
end

function Outfitter._Credits:OnUpdate(pElapsed)
	self.NextPlayerTime = self.NextPlayerTime - pElapsed
	
	if self.NextPlayerTime > 0 then
		return
	end
	
	self.NextPlayerTime = 1.2
	
	local vCreditFrame = table.remove(self.AvailableCreditFrames)
	
	if not vCreditFrame then
		vCreditFrame = Outfitter:New(Outfitter._CreditFrame, self)
		table.insert(self.CreditFrames, vCreditFrame)
	end
	
	vCreditFrame:SetPlayer(self.Players[self.PlayerIndex])
	vCreditFrame:Animate("DROPLET")
	
	self.PlayerIndex = self.PlayerIndex + 1
	
	if self.PlayerIndex > #self.Players then
		self:Shuffle()
		self.PlayerIndex = 1
	end
end

function Outfitter._Credits:ReleaseCreditFrame(pCreditFrame)
	table.insert(self.AvailableCreditFrames, pCreditFrame)
end

----------------------------------------
Outfitter._CreditFrame = {}
----------------------------------------

function Outfitter._CreditFrame:New(pParent)
	return CreateFrame("Frame", nil, pParent)
end

function Outfitter._CreditFrame:Construct(pParent)
	self.Width = 130
	self.Height = 30
	
	self.Line1 = self:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	self.Line1:SetPoint("TOP", self, "TOP")
	self.Line1:SetWidth(self.Width)
	
	self.Line2 = self:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	self.Line2:SetPoint("TOP", self.Line1, "BOTTOM")
	self.Line2:SetWidth(self.Width)
	
	self:SetWidth(self.Width)
	self:SetHeight(self.Height)
	
	--self.TestTexture = self:CreateTexture(nil, "OVERLAY")
	--self.TestTexture:SetAllPoints()
	--self.TestTexture:SetTexture(1, 0, 0, 0.5)
	
	self.DestWidth = self:GetParent():GetWidth() - self.Width
	self.DestHeight = self:GetParent():GetHeight() - self.Height
	
	self:SetScript("OnUpdate", self.OnUpdate)
end

function Outfitter._CreditFrame:SetPlayer(pPlayerInfo)
	self.Line1:SetText(pPlayerInfo.Name)
	self.Line2:SetText(pPlayerInfo.Realm)
end

function Outfitter._CreditFrame:Animate(pStyle)
	self.AnimationStyle = pStyle
	self.AnimationElapsed = 0
	
	if self.AnimationStyle == "DROPLET" then
		self.HorizPos = math.random() * self.DestWidth - 0.5 * self.DestWidth
		self.VertPos = 0
		
		self:SetPoint("TOP", self:GetParent(), "TOP", self.HorizPos, self.VertPos)
		self:SetAlpha(0)
		
		self.FadeInTime = 0.8
		
		self.VertVelocity = 0
		self.VertAccel = 0
	end
end

function Outfitter._CreditFrame:OnUpdate(pElapsed)
	if self.AnimationStyle == "DROPLET" then
		self.AnimationElapsed = self.AnimationElapsed + pElapsed
		
		if self.AnimationElapsed > self.FadeInTime then
			self:SetAlpha(1)
			
			self.VertAccel = -50
			self.VertVelocity = self.VertVelocity + self.VertAccel * pElapsed
			self.VertPos = self.VertPos + self.VertVelocity * pElapsed
			
			self:SetPoint("TOP", self:GetParent(), "TOP", self.HorizPos, self.VertPos)
			
			if self.VertPos < -self.DestHeight then
				self.AnimationStyle = nil
				self:SetAlpha(0)
				self:GetParent():ReleaseCreditFrame(self)
			end
		else
			self:SetAlpha(self.AnimationElapsed / self.FadeInTime)
		end
	end
end
