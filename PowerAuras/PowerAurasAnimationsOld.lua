
cPowaAnimationBase = PowaClass(function(animation, aura, frame, base)
	animation.State = 0;
	animation.Aura = aura;
	animation.Frame = frame;
	animation.TargetWidth = frame.baseL;
	animation.TargetHeight = frame.baseH;
	animation.TargetAlpha = aura.alpha;
	animation.Width = animation.TargetWidth;
	animation.Height = animation.TargetHeight;
	animation.Alpha = animation.TargetAlpha;

	if (base) then
		for k, v in pairs (base) do
			local varType = type(v);
			if (varType == "string" or varType == "boolean" or varType == "number") then
				animation[k] = base[k];
			end
		end
	end
end);


function cPowaAnimationBase:InitialiseBase()
	--PowaAuras:Message("Base:InitialiseBase aura="..tostring(self.Aura).." frame="..tostring(self.Frame));
	self.StartWidth = self.TargetWidth;
	self.StartHeight = self.TargetHeight;
	self.StartAlpha = self.TargetAlpha;
	self:Reset();
end
function cPowaAnimationBase:Initialise()
	--PowaAuras:Message("Base:Initialise aura="..tostring(self.Aura).." frame="..tostring(self.Frame));
	self:InitialiseBase();
end

function cPowaAnimationBase:ResetBase()
	--PowaAuras:Message("Base:ResetBase aura="..tostring(self.Aura).." frame="..tostring(self.Frame));
	self.State = 0;
	self.Width = self.StartWidth;
	self.Height = self.StartHeight;
	self.Alpha = self.StartAlpha;
	self:UpdateFrame();
end

function cPowaAnimationBase:Reset()
	--PowaAuras:Message("Base:Reset aura="..tostring(self.Aura).." frame="..tostring(self.Frame));
	self:ResetBase();
end

function cPowaAnimationBase:UpdateFrameBase()
	--PowaAuras:Message("Base:UpdateFrameBase aura="..tostring(self.Aura).." frame="..tostring(self.Frame));
	self.Frame:SetWidth(self.Width);
	self.Frame:SetHeight(self.Height);
	self.Frame:SetAlpha(math.min(self.Alpha,0.99));
end 

function cPowaAnimationBase:UpdateFrame()
	--PowaAuras:Message("Base:UpdateFrame aura="..tostring(self.Aura).." frame="..tostring(self.Frame));
	self:UpdateFrameBase();
end 

function cPowaAnimationBase:Update(elapsed)
	----PowaAuras:UnitTestInfo("Base Update ", elapsed);
	return true;
end 

cPowaAnimationBaseTranslate = PowaClass(cPowaAnimationBase);
function cPowaAnimationBaseTranslate:UpdateFrame()
	--PowaAuras:Message("BaseTranslate:UpdateFrame aura="..tostring(self.Aura).." frame="..tostring(self.Frame));
	self.Frame:SetPoint("Center", self.X, self.Y);
	self:UpdateFrameBase();
end 
function cPowaAnimationBaseTranslate:InitialiseBase()
	--PowaAuras:Message("BaseTranslate:Initialise aura="..tostring(self.Aura).." frame="..tostring(self.Frame));
	self.StartWidth = self.TargetWidth;
	self.StartHeight = self.TargetHeight;
	self.TargetX = self.Aura.x;
	self.TargetY = self.Aura.y;
	self.X = self.TargetX + self.OffsetX;
	self.Y = self.TargetY + self.OffsetY;
	self.StartAlpha = 0.0;
	--PowaAuras:Message("BaseTranslate:Initialise X="..tostring(self.X).." Y="..tostring(self.Y));
	self:ResetBase();
end
function cPowaAnimationBaseTranslate:Initialise()
	self:InitialiseBase();
end

--- Begin Animations ---
cPowaAnimationBeginZoomIn = PowaClass(cPowaAnimationBase);
function cPowaAnimationBeginZoomIn:Initialise()
	self.StartWidth = self.TargetWidth * 1.5;
	self.StartHeight = self.TargetHeight * 1.5;
	self.StartAlpha = 0.0;
	self:ResetBase();
end
function cPowaAnimationBeginZoomIn:Update(elapsed)
	----PowaAuras:UnitTestInfo("BeginZoomIn Update ", elapsed);

	local step = elapsed * 150 * self.Aura.speed;
	
	self.Width  = self.Width  - (step * self.Aura.torsion);
	self.Height = self.Height - (step * (2-self.Aura.torsion));
	self.Alpha  = self.TargetAlpha * (self.StartWidth - self.Width) / (self.StartWidth - self.TargetWidth);
	
	local result = false;
	if (self.Width <= self.TargetWidth) then
		self.Width = self.TargetWidth;
		self.Height = self.TargetHeight;
		self.Alpha = self.TargetAlpha;
		result = true;
	end
	self:UpdateFrame();
	return result;
end 

cPowaAnimationBeginZoomOut = PowaClass(cPowaAnimationBase);
function cPowaAnimationBeginZoomOut:Initialise()
	--PowaAuras:Message("BeginZoomOut:Reset aura="..tostring(self.Aura).." frame="..tostring(self.Frame));
	self.StartWidth = self.TargetWidth * 0.5;
	self.StartHeight = self.TargetHeight * 0.5;
	self.StartAlpha = 0.0;
	self:Reset();
end
function cPowaAnimationBeginZoomOut:Update(elapsed)
	----PowaAuras:UnitTestInfo("cPowaAnimationBeginZoomOut Update ", elapsed);

	local step = elapsed * 150 * self.Aura.speed;
	
	self.Width  = self.Width  + (step * self.Aura.torsion);
	self.Height = self.Height + (step * (2-self.Aura.torsion));
	self.Alpha  = self.TargetAlpha * (self.StartWidth - self.Width) / (self.StartWidth - self.TargetWidth);
	
	local result = false;
	if (self.Width >= self.TargetWidth) then
		self.Width = self.TargetWidth;
		self.Height = self.TargetHeight;
		self.Alpha = self.TargetAlpha;
		result = true;
	end
	self:UpdateFrame();
	return result;
end 

cPowaAnimationBeginFadeIn = PowaClass(cPowaAnimationBase);
function cPowaAnimationBeginFadeIn:Initialise()
	--PowaAuras:Message("BeginFadeIn:Initialise aura="..tostring(self.Aura).." frame="..tostring(self.Frame));
	self.StartWidth = self.TargetWidth;
	self.StartHeight = self.TargetHeight;
	self.StartAlpha = 0.0;
	self:Reset();
end
function cPowaAnimationBeginFadeIn:Update(elapsed)
	--PowaAuras:Message("BeginFadeIn Update ", elapsed);

	self.Alpha  = self.Alpha + elapsed * 2 * self.Aura.speed * self.TargetAlpha;
	local result = false;
	if (self.Alpha >= self.TargetAlpha) then
		self.Alpha = self.TargetAlpha;
		result = true;
	end
	self:UpdateFrame();
	return result;
end 

cPowaAnimationBeginTranslate = PowaClass(cPowaAnimationBaseTranslate);
function cPowaAnimationBeginTranslate:Update(elapsed)
	--PowaAuras:Message("BeginTranslate Update ", elapsed);

	self.Alpha  = math.max(self.TargetAlpha + elapsed * self.TranslationSpeed * self.Aura.speed * self.TargetAlpha, self.TargetAlpha);

	local step = elapsed * self.TranslationSpeed * 100 * self.Aura.speed;

	--PowaAuras:Message("step ", step);
	--PowaAuras:Message("X=", self.X, " Y=", self.Y);
	
	self.X = self.X + self.DirectionX * step;
	self.Y = self.Y + self.DirectionY * step;
	--PowaAuras:Message("X=", self.X, " Y=", self.Y);
	--PowaAuras:Message("TargetX=", self.TargetX, " TargetY=", self.TargetY);
	--PowaAuras:Message("dX=", self.DirectionX * (self.X - self.TargetX), " dY=", self.DirectionY * (self.Y - self.TargetY));
	
	local result = false;
	if (((self.DirectionX * (self.X - self.TargetX)) >= 0) and (self.DirectionY * (self.Y - self.TargetY) >= 0)) then
		--PowaAuras:Message("Finished");
		self.X = self.TargetX;
		self.Y = self.TargetY;
		self.Alpha = self.TargetAlpha;
		result = true;
	end
			
	self:UpdateFrame();
	return result;
end 

cPowaAnimationBeginTranslateLeft        = PowaClass(cPowaAnimationBeginTranslate, {OffsetX=-100, OffsetY=0,    DirectionX=1,  DirectionY=0,  TranslationSpeed = 2.0});
cPowaAnimationBeginTranslateTopLeft     = PowaClass(cPowaAnimationBeginTranslate, {OffsetX=-75 , OffsetY=75,   DirectionX=1,  DirectionY=-1, TranslationSpeed = 1.5});
cPowaAnimationBeginTranslateTop         = PowaClass(cPowaAnimationBeginTranslate, {OffsetX=0,    OffsetY=100,  DirectionX=0,  DirectionY=-1, TranslationSpeed = 2.0});
cPowaAnimationBeginTranslateTopRight    = PowaClass(cPowaAnimationBeginTranslate, {OffsetX=75,   OffsetY=75,   DirectionX=-1, DirectionY=-1, TranslationSpeed = 1.5});
cPowaAnimationBeginTranslateRight       = PowaClass(cPowaAnimationBeginTranslate, {OffsetX=100,  OffsetY=0,    DirectionX=-1, DirectionY=0,  TranslationSpeed = 2.0});
cPowaAnimationBeginTranslateBottomRight = PowaClass(cPowaAnimationBeginTranslate, {OffsetX=75,   OffsetY=-75,  DirectionX=-1, DirectionY=1,  TranslationSpeed = 1.5});
cPowaAnimationBeginTranslateBottom      = PowaClass(cPowaAnimationBeginTranslate, {OffsetX=0,    OffsetY=-100, DirectionX=0,  DirectionY=1,  TranslationSpeed = 2.0});
cPowaAnimationBeginTranslateBottomLeft  = PowaClass(cPowaAnimationBeginTranslate, {OffsetX=-75,  OffsetY=-75,  DirectionX=1,  DirectionY=1,  TranslationSpeed = 1.5});


cPowaAnimationBeginBounce = PowaClass(cPowaAnimationBaseTranslate, {OffsetX=0, OffsetY=100, MinVelocity=100, Acceleration=1000});
function cPowaAnimationBeginBounce:Initialise()
	self.Velocity = 0;
	self:InitialiseBase();
	--PowaAuras:Message("Bounce Init v=", self.Velocity, " Y=", self.Y);
end
function cPowaAnimationBeginBounce:Update(elapsed)
	----PowaAuras:UnitTestInfo("BeginBounce Update ", elapsed);

	self.Alpha  = math.max(self.TargetAlpha + elapsed * 2 * self.Aura.speed * self.TargetAlpha , self.TargetAlpha);

	self.Velocity = math.max(math.min(self.Velocity + self.Acceleration * self.Aura.speed * elapsed, 1000), -1000);
	
	self.Y = self.Y - elapsed * (self.Velocity + self.Acceleration * self.Aura.speed * elapsed / 2);
	
	local result = false;
	if (self.Y <= self.TargetY and self.Velocity>0) then
		self.Y = self.TargetY;
		self.Alpha = self.TargetAlpha;
		if (self.Velocity <= self.MinVelocity) then
			self.Velocity = 0;
			result = true;
		else
			self.Velocity = -self.Velocity * 0.9;
		end
	end
			
	self:UpdateFrame();
	return result;
end

--- End Animations ---
cPowaAnimationEnd = PowaClass(cPowaAnimationBase);
function cPowaAnimationEnd:Initialise()
	self.StartWidth = self.Frame:GetWidth();
	self.StartHeight = self.Frame:GetHeight();
	self.StartAlpha = self.Frame:GetAlpha();
	self:Reset();
end

cPowaAnimationEndResizeAndFade = PowaClass(cPowaAnimationEnd);
function cPowaAnimationEndResizeAndFade:Update(elapsed)
	self.Alpha = self.Alpha - (elapsed * 2);

	if (self.Alpha <= 0) then
		return true;
	end
	
	local sizeStep = self.Direction * elapsed * 200;
	self.Width  = math.max(0, self.Width  + sizeStep);
	self.Height = math.max(0, self.Height + sizeStep);
	self:UpdateFrame();
	return false;
end

cPowaAnimationEndGrowAndFade   = PowaClass(cPowaAnimationEndResizeAndFade, {Direction = -1});
cPowaAnimationEndShrinkAndFade = PowaClass(cPowaAnimationEndResizeAndFade, {Direction = 1});

cPowaAnimationEndFade = PowaClass(cPowaAnimationEnd);
function cPowaAnimationEndFade:Update(elapsed)
	self.Alpha = self.Alpha - (elapsed * 2);

	if (self.Alpha <= 0) then
		return true;
	end
	
	self:UpdateFrame();
	return false;
end

--- Main Animations ---
cPowaAnimationFlashing = PowaClass(cPowaAnimationBase);
function cPowaAnimationFlashing:Initialise()
	self.Direction = -1;
	self.MinAlpha = self.TargetAlpha * 0.5 * self.Aura.speed;
	self.Alpha = self.Frame:GetAlpha();
end
function cPowaAnimationFlashing:Update(elapsed)
	----PowaAuras:UnitTestInfo("cPowaAnimationFlashing Update ", elapsed);
	
	self.Alpha = self.Alpha + self.Direction * elapsed / 2;
	if (self.Alpha<=self.MinAlpha) then
		self.Alpha = self.MinAlpha;
		self.Direction = 1;
	elseif (self.Alpha>=self.TargetAlpha) then
		self.Alpha = self.TargetAlpha;
		self.Direction = -1;
	end
	self:UpdateFrame();
end 

cPowaAnimationGrowing = PowaClass(cPowaAnimationBase);
function cPowaAnimationGrowing:Initialise()
	self.MinWidth  = self.TargetWidth  * 0.9;
	self.MinHeight = self.TargetHeight * 0.9;
	self.MaxWidth  = self.TargetWidth  * 1.2;
	self.MaxHeight = self.TargetHeight * 1.2;
	self.Width     = self.Frame:GetWidth();
	self.Height    = self.Frame:GetHeight();
	self.Alpha     = self.Frame:GetAlpha();
end
function cPowaAnimationGrowing:Update(elapsed)
	----PowaAuras:UnitTestInfo("cPowaAnimationGrowing Update ", elapsed);
	
	local step = elapsed * 25 * self.Aura.speed * self.Aura.size;
	self.Width  = self.Width  + step;
	self.Height = self.Height + step;
	if (self.Width >= self.MaxWidth) then
		self.Width = self.MinWidth;
		self.Height = self.MinHeight;
	end
	self.Alpha = self.TargetAlpha * (self.MaxWidth - self.Width) / (self.MaxWidth - self.MinWidth);
	self:UpdateFrame();
end 

cPowaAnimationPulse = PowaClass(cPowaAnimationBase);
function cPowaAnimationPulse:Initialise()
	self.Direction = 1;
	self.MinWidth  = self.TargetWidth  * 0.95;
	self.MinHeight = self.TargetHeight * 0.95;
	self.MaxWidth  = self.TargetWidth  * 1.05;
	self.MaxHeight = self.TargetHeight * 1.05;
	self.Width     = self.Frame:GetWidth();
	self.Height    = self.Frame:GetHeight();
end
function cPowaAnimationPulse:Update(elapsed)
	----PowaAuras:UnitTestInfo("cPowaAnimationPulse Update ", elapsed);
	
	local step  = self.Direction * elapsed * 50 * self.Aura.speed * self.Aura.size;
	self.Width  = self.Width  + step * self.Aura.torsion;
	self.Height = self.Height + step * (2-self.Aura.torsion);
	if (self.Width >= self.MaxWidth) then
		self.Width = self.MaxWidth;
		self.Height = self.MaxHeight;
		self.Direction = -1;
	elseif (self.Width <= self.MinWidth) then
		self.Width = self.MinWidth;
		self.Height = self.MinHeight;
		self.Direction = 1;
	end
	self:UpdateFrame();
end 

cPowaAnimationBubble = PowaClass(cPowaAnimationBase);
function cPowaAnimationBubble:Initialise()
	self.Direction = 1;
	self.MinWidth  = self.TargetWidth  * 0.95;
	self.MinHeight = self.TargetHeight * 0.95;
	self.MaxWidth  = self.TargetWidth  * 1.05;
	self.MaxHeight = self.TargetHeight * 1.05;
	self.Width     = self.Frame:GetWidth();
	self.Height    = self.Frame:GetHeight();
end
function cPowaAnimationBubble:Update(elapsed)
	----PowaAuras:UnitTestInfo("cPowaAnimationBubble Update ", elapsed);
	
	local step  = self.Direction * elapsed * 50 * self.Aura.speed * self.Aura.size;
	self.Width  = self.Width  + step * self.Aura.torsion;
	self.Height = self.Height - step * (2-self.Aura.torsion);
	if (self.Width >= self.MaxWidth) then
		self.Width = self.MaxWidth;
		self.Height = self.MinHeight;
		self.Direction = -1;
	elseif (self.Width <= self.MinWidth) then
		self.Width = self.MinWidth;
		self.Height = self.MaxHeight;
		self.Direction = 1;
	end
	self:UpdateFrame();
end 


cPowaAnimationWaterDrop = PowaClass(cPowaAnimationBaseTranslate, {OffsetX=0, OffsetY=0});
function cPowaAnimationWaterDrop:Initialise()
	self.Alpha     = self.Frame:GetAlpha();
	self.Width     = self.Frame:GetWidth();
	self.Height    = self.Frame:GetHeight();
	self.TargetX = self.Aura.x;
	self.TargetY = self.Aura.y;
	self.X = self.TargetX;
	self.Y = self.TargetY;
	self.Status = 0;
end
function cPowaAnimationWaterDrop:Update(elapsed)
	----PowaAuras:UnitTestInfo("cPowaAnimationWaterDrop Update ", elapsed);

	self.Alpha = self.Alpha - elapsed * self.TargetAlpha * 0.5 * self.Aura.speed;
	if (self.Alpha <= 0) then
		self.Alpha  = self.TargetAlpha;
		self.Width  = self.TargetWidth  * 0.85;
		self.Height = self.TargetHeight * 0.85;
		self.X = self.TargetX + (random(0,20) - 10) * self.Aura.speed;
		self.Y = self.TargetY + (random(0,20) - 10) * self.Aura.speed;
	else
		local width = self.Width  + elapsed * 100 * self.Aura.speed * self.Aura.size;
		if ( (width * 1.5) > self.Width) then --- evite les lags
			self.Width = width;
			self.Height = self.Height + elapsed * 100 * self.Aura.speed * self.Aura.size;
		end			
	end
		
	self:UpdateFrame();
end

cPowaAnimationElectric = PowaClass(cPowaAnimationBaseTranslate, {OffsetX=0, OffsetY=0});
function cPowaAnimationElectric:Initialise()
	self.Alpha     = self.Frame:GetAlpha();
	self.Width     = self.Frame:GetWidth();
	self.Height    = self.Frame:GetHeight();
	self.TargetX = self.Aura.x;
	self.TargetY = self.Aura.y;
	self.X = self.TargetX;
	self.Y = self.TargetY;
	self.Status = 0;
end
function cPowaAnimationElectric:Update(elapsed)
	----PowaAuras:UnitTestInfo("cPowaAnimationElectric Update ", elapsed);
	
	if (self.Status == 0) then
		if (random( 210 - self.Aura.speed * 100 ) == 1) then
			self.X = self.TargetX + random(0,10) - 5;
			self.Y = self.TargetY + random(0,10) - 5;
			self.Alpha = self.TargetAlpha;
			self.Status = 1;
		else
			self.Alpha = self.TargetAlpha / 2;
		end
	else
		self.X = self.TargetX;
		self.Y = self.TargetY;
		self.Status = 0;
	end
		
	self:UpdateFrame();
end 


cPowaAnimationShrinking = PowaClass(cPowaAnimationBase);
function cPowaAnimationShrinking:Initialise()
	self.Alpha     = self.Frame:GetAlpha();
	self.Width     = self.Frame:GetWidth();
	self.Height    = self.Frame:GetHeight();
	self.MinWidth  = self.TargetWidth;
	self.MinHeight = self.TargetHeight;
	self.MaxWidth  = self.TargetWidth  * 1.3;
	self.MaxHeight = self.TargetHeight * 1.3;
	self.Status = 0;
end
function cPowaAnimationShrinking:Update(elapsed)
	----PowaAuras:UnitTestInfo("cPowaAnimationShrinking Update ", elapsed);

	if (self.Status == 0) then --- demarre le zoom out (max size)
		self.Width = self.MaxWidth;
		self.Height = self.MaxHeight;
		self.Alpha = 0.0;
		self.Status = 2;
	elseif (self.Status == 2) then --- zoom out + fade in
		local speedScale = 50 * self.Aura.speed * self.Aura.size;
		self.Width  = self.Width   - elapsed * speedScale * self.Aura.torsion;
		self.Height = self.Height - elapsed * speedScale * (2-self.Aura.torsion);
		self.Alpha  = self.TargetAlpha * (self.MaxWidth - self.Width) / (self.MaxWidth - self.MinWidth);

		if (self.Width <= self.MinWidth) then
			self.Width  = self.MinWidth;
			self.Height = self.MinHeight;
			self.Status = 1;
		end
	elseif (self.Status == 1) then --- demarre le fade-out
		self.Width  = self.MinWidth;
		self.Height = self.MinHeight;
		self.Alpha  = self.TargetAlpha;
		self.Status = 3;

	elseif (self.Status == 3) then --- fade-out
		self.Alpha  = self.Alpha - (elapsed / random(1,2));
		if (self.Alpha <= 0.0) then
			self.Alpha = 0;
			self.Status = 0;
		end
	end		
	self:UpdateFrame();
end 



cPowaAnimationFlame = PowaClass(cPowaAnimationBaseTranslate, {OffsetX=0, OffsetY=0});
function cPowaAnimationFlame:Initialise()
	self.Alpha     = self.Frame:GetAlpha();
	self.Width     = self.Frame:GetWidth();
	self.Height    = self.Frame:GetHeight();
	self.TargetX = self.Aura.x;
	self.TargetY = self.Aura.y;
	self.X = self.TargetX;
	self.Y = self.TargetY;
	self.Status = 0;
end
function cPowaAnimationFlame:Update(elapsed)
	----PowaAuras:UnitTestInfo("cPowaAnimationFlame Update ", elapsed);

		
	if (self.Status < 2) then --- reset to center
		self.Width  =  self.TargetWidth;
		self.Height =  self.TargetHeight;
		self.Alpha  =  self.TargetAlpha;
		self.X = self.TargetX;
		self.Y = self.TargetY;
		self.Status = 2;
	else
		local speedScale = 50 * self.Aura.speed * self.Aura.size;
		self.X = self.X + random(1,3) - 2;
		self.Y = self.Y + elapsed * random(10,20);
		self.Alpha  =  self.Alpha  - self.TargetAlpha * elapsed / random(2,4);
		self.Width  =  self.Width - elapsed * speedScale * self.Aura.torsion;
		self.Height =  self.Height  - elapsed * speedScale * (2-self.Aura.torsion);
		if (self.Alpha < 0.0) then
			self.Alpha = 0;
			self.Status = 1;
		end
	end
		
	self:UpdateFrame();
end

cPowaAnimationOrbit = PowaClass(cPowaAnimationBaseTranslate, {OffsetX=0, OffsetY=0});
function cPowaAnimationOrbit:Initialise()
	self.Alpha     = self.Frame:GetAlpha();
	self.TargetX = self.Aura.x;
	self.TargetY = self.Aura.y;
	self.X = self.TargetX;
	self.Y = self.TargetY;
	self.MaxWidth  = math.max(self.TargetX, -self.TargetX, 5) * 1.0;
	self.MaxHeight = self.MaxWidth * (1.6 - self.Aura.torsion);
	--PowaAuras:ShowText("MaxWidth ", self.MaxWidth);
	--PowaAuras:ShowText("MaxHeight ", self.MaxHeight);
	self.Width     = self.TargetWidth / self.Aura.torsion;
	self.Height    = self.TargetHeight / (2-self.Aura.torsion);
	self.Angle = 0;
	--- annule la symetrie
	if self.Aura.textaura ~= true then
		local texture = self.Aura:GetTexture();
		if (texture) then
			texture:SetTexCoord(0, 1, 0, 1);
		end
	end
end
function cPowaAnimationOrbit:Update(elapsed)
	----PowaAuras:UnitTestInfo("cPowaAnimationOrbit Update ", elapsed);

	local speedScale = elapsed * 75 * self.Aura.speed;
	
	if (self.Aura.isSecondary and (PowaAuras.Auras[self.Aura.id].anim1 == PowaAuras.AnimationTypes.Orbit)) then
		if (self.Aura.symetrie < 2) then
			self.Angle = PowaAuras.Auras[self.Aura.id].animation.Angle + 180;
			if (self.Angle > 360) then self.Angle = self.Angle - 360; end
		else
			self.Angle = 180 - PowaAuras.Auras[self.Aura.id].animation.Angle;
			if (self.Angle < 0) then self.Angle = self.Angle + 360; end
		end
	elseif (self.Aura.symetrie == 1 or self.Aura.symetrie == 3) then
		self.Angle = self.Angle - speedScale;
		if (self.Angle < 0) then self.Angle = 360; end
	else
		self.Angle = self.Angle + speedScale;
		if (self.Angle > 360) then self.Angle = 0; end
	end

	--- transparence
	if (self.Angle < 180) then --- zone de transparence
		if (self.Angle < 90) then
			self.Alpha = self.TargetAlpha * (1-self.Angle/90);
		else
			self.Alpha = self.TargetAlpha * (self.Angle/90-1);
		end
	else
		self.Alpha = self.TargetAlpha;
	end
	self.X = self.MaxWidth  * cos(self.Angle);
	self.Y = self.TargetY + self.MaxHeight * sin(self.Angle);
		
	self:UpdateFrame();
end

-- Concrete Animation  Classes
PowaAuras.AnimationMainClasses = {
	[PowaAuras.AnimationTypes.Static]    = cPowaAnimationBase,
	[PowaAuras.AnimationTypes.Flashing]  = cPowaAnimationFlashing,
	[PowaAuras.AnimationTypes.Growing]   = cPowaAnimationGrowing,
	[PowaAuras.AnimationTypes.Pulse]     = cPowaAnimationPulse,
	[PowaAuras.AnimationTypes.Bubble]    = cPowaAnimationBubble,
	[PowaAuras.AnimationTypes.WaterDrop] = cPowaAnimationWaterDrop,
	[PowaAuras.AnimationTypes.Electric]  = cPowaAnimationElectric,
	[PowaAuras.AnimationTypes.Shrinking] = cPowaAnimationShrinking,
	[PowaAuras.AnimationTypes.Flame]     = cPowaAnimationFlame,
	[PowaAuras.AnimationTypes.Orbit]     = cPowaAnimationOrbit,
}


-- Concrete Animation Begin Classes
PowaAuras.AnimationBeginClasses = {
	[PowaAuras.AnimationBeginTypes.None]                 = cPowaAnimationBase,
	[PowaAuras.AnimationBeginTypes.ZoomIn]               = cPowaAnimationBeginZoomIn,
	[PowaAuras.AnimationBeginTypes.ZoomOut]              = cPowaAnimationBeginZoomOut,
	[PowaAuras.AnimationBeginTypes.FadeIn]               = cPowaAnimationBeginFadeIn,
	[PowaAuras.AnimationBeginTypes.TranslateLeft]        = cPowaAnimationBeginTranslateLeft,
	[PowaAuras.AnimationBeginTypes.TranslateTopLeft]     = cPowaAnimationBeginTranslateTopLeft,
	[PowaAuras.AnimationBeginTypes.TranslateTop]         = cPowaAnimationBeginTranslateTop,
	[PowaAuras.AnimationBeginTypes.TranslateTopRight]    = cPowaAnimationBeginTranslateTopRight,
	[PowaAuras.AnimationBeginTypes.TranslateRight]       = cPowaAnimationBeginTranslateRight,
	[PowaAuras.AnimationBeginTypes.TranslateBottomRight] = cPowaAnimationBeginTranslateBottomRight,
	[PowaAuras.AnimationBeginTypes.TranslateBottom]      = cPowaAnimationBeginTranslateBottom,
	[PowaAuras.AnimationBeginTypes.TranslateBottomLeft]  = cPowaAnimationBeginTranslateBottomLeft,
	[PowaAuras.AnimationBeginTypes.Bounce]               = cPowaAnimationBeginBounce,
}

function PowaAuras:AnimationBeginFactory(animationType, aura, frame, base)
	--self:Message("AnimationBeginFactory "..tostring(animationType).." aura.id="..tostring(aura.id).." frame="..tostring(frame));
	if (not base) then
		base = {};
	end
	base.IsBegin = true;
	return self:AnimationFactory(animationType, self.AnimationBeginClasses, aura, frame, base)
end

-- Concrete Animation End Classes
PowaAuras.AnimationEndClasses = {
	[PowaAuras.AnimationEndTypes.None]=cPowaAnimationEnd,
	[PowaAuras.AnimationEndTypes.GrowAndFade]=cPowaAnimationEndGrowAndFade,
	[PowaAuras.AnimationEndTypes.ShrinkAndFade]=cPowaAnimationEndShrinkAndFade,
	[PowaAuras.AnimationEndTypes.Fade]=cPowaAnimationEndFade,
}

function PowaAuras:AnimationEndFactory(animationType, aura, frame, base)
	--self:Message("AnimationEndFactory type="..tostring(animationType).." aura.id="..tostring(aura.id).." frame="..tostring(frame));
	if (aura.isSecondary) then
		return nil;
	end
	if (not base) then
		base = {};
	end
	base.IsEnd = true;
	return self:AnimationFactory(animationType, self.AnimationEndClasses, aura, frame, base)
end

function PowaAuras:AnimationMainFactory(animationType, aura, frame, base)
	--self:ShowText("AnimationMainFactory type="..tostring(animationType).." aura.id="..tostring(aura.id).." frame="..tostring(frame));
	if (animationType==PowaAuras.AnimationTypes.Invisible) then
		return nil;
	end
	return self:AnimationFactory(animationType, self.AnimationMainClasses, aura, frame, base)
end

-- Instance concrete class based on animation type
function PowaAuras:AnimationFactory(animationType, classList, aura, frame, base)
	if (not frame) then
		return nil;
	end
	local class = classList[animationType];
	if (class) then
		--self:ShowText("AnimationFactory type="..tostring(animationType).." aura.id="..tostring(aura.id).." class="..tostring(class).." frame="..tostring(frame));
		if (not base) then
			base = {};
		end
		base.AnimationType = animationType;
		local animation = class(aura, frame, base);
		if (animation) then
			animation:Initialise();
		end
		return animation;
	end
	--self:ShowText("AnimationFactory Unknown "..tostring(animationType).." auraId="..tostring(aura.id)); --OK
	return nil;
end
