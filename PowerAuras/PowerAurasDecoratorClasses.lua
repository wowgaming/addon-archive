
cPowaStacks = PowaClass(function(stacker, aura, base)
	stacker.enabled = false;
	stacker.x = 0;
	stacker.y = 0;
	stacker.a = 1.0;
	stacker.h = 1.0;
	stacker.Transparent = false;
	stacker.HideLeadingZeros = false;
	stacker.UpdatePing = false;
	stacker.Texture = "Default";
	stacker.Relative = "NONE";
	stacker.UseOwnColor = false;
	stacker.r = 1.0;
	stacker.g = 1.0;
	stacker.b = 1.0;
	--PowaAuras:ShowText("cPowaTimer");
	if (base) then
		for k, v in pairs (stacker) do
			--PowaAuras:ShowText("  base."..tostring(k).."="..tostring(base[k]));
			local varType = type(v);
			if (varType == "string" or varType == "boolean" or varType == "number") then
				if (base[k] ~= nil) then
					stacker[k] = base[k];
				end
			end
		end
	end
	stacker.Showing = false;
	stacker.id = aura.id;
end);


function cPowaStacks:IsRelative()
	return (self.Relative and self.Relative~="NONE");
end

function cPowaStacks:GetTexture()
	local texture = PowaMisc.DefaultStacksTexture;
	if (self.Texture ~= "Default") then
		texture = self.Texture;
	end
	local postfix = "";
	if (self.Transparent) then
		postfix = "Transparent";
	end
	return "Interface\\Addons\\PowerAuras\\TimerTextures\\"..texture.."\\Timers"..postfix..".tga";
end

function cPowaStacks:ShowValue(aura, newvalue)
	--PowaAuras:ShowText("Stacks Showvalue id=", self.id, " newvalue=", newvalue);
	if (PowaAuras.ModTest) then
		newvalue = random(1,8);
	end
	
	local frame = PowaAuras.StacksFrames[self.id];
	if (frame==nil or newvalue==nil) then
		return;
	end
	
	if (aura.texmode == 1) then
		frame.texture:SetBlendMode("ADD");
	else
		frame.texture:SetBlendMode("DISABLE");
	end
	if (self.UseOwnColor) then
		frame.texture:SetVertexColor(self.r,self.g,self.b);
	else
		local auraTexture = PowaAuras.Textures[self.id];
		if (auraTexture) then
			if auraTexture:GetObjectType() == "Texture" then
				frame.texture:SetVertexColor(auraTexture:GetVertexColor());
			elseif auraTexture:GetObjectType() == "FontString" then
				frame.texture:SetVertexColor(auraTexture:GetTextColor());
			end
		else
			frame.texture:SetVertexColor(aura.r,aura.g,aura.b);
		end
	end

	--PowaAuras:ShowText("newvalue=", newvalue);
	
	local deci = math.floor(newvalue / 10);
	local uni  = math.floor(newvalue - (deci*10));
	--PowaAuras:ShowText("Show stacks: ",deci, " ", uni);
	local tStep = PowaAuras.Tstep;
	if (deci==0) then
		frame.texture:SetTexCoord(tStep , tStep * 1.5, tStep * uni, tStep * (uni+1));
	else
		frame.texture:SetTexCoord(tStep * uni, tStep * (uni+1), tStep * deci, tStep * (deci+1));
	end
	if (not frame:IsVisible()) then
		--PowaAuras:Message("Show Stacks Frame for ", self.id);
		frame:Show(); 
	end
	if (self.UpdatePing and frame.PingAnimationGroup) then
		--PowaAuras:ShowText("Stacks UpdatePing");
		frame.PingAnimationGroup:Play();
	end

end

function cPowaStacks:SetStackCount(count)
	--PowaAuras:UnitTestInfo("SetStackCount ",self.id);
	--PowaAuras:Message("SetStackCount ",self.id);
	local aura = PowaAuras.Auras[self.id];
	if (aura == nil) then
		--PowaAuras:UnitTestInfo("Stacks aura missing");
		--PowaAuras:Message("Stacks aura missing");
		return;
	end
	if (self.enabled==false) then 
		--PowaAuras:UnitTestInfo("Stacks disabled");
		--PowaAuras:Message("Stacks disabled");
		return;
	end
	if (not count or count==0) then
		local frame = PowaAuras.StacksFrames[self.id];
		if (frame and frame:IsVisible()) then
			frame:Hide();
		end
		self.Showing = false;
		return;
	end
	if (self.lastShownValue==count and self.Showing) then
		--PowaAuras:Message("Stacks disabled");
		return;
	end
	self.lastShownValue=count;
	PowaAuras:CreateStacksFrameIfMissing(self.id, self.UpdatePing);
	self:ShowValue(aura, count);
	self.Showing = true;
end

function cPowaStacks:Hide()
	--PowaAuras:ShowText("Hide Stacks Frame for ", self.id, " ", self.Showing, " ", PowaAuras.StacksFrames[self.id]);
	if (not self.Showing) then return; end
	if (PowaAuras.StacksFrames[self.id]) then
		PowaAuras.StacksFrames[self.id]:Hide();
	end
	self.Showing = false;
end

function cPowaStacks:Delete()
	self:Hide();
	if PowaAuras.StacksFrames[self.id] then
		PowaAuras.StacksFrames[self.id] = nil;
	end
end

--===== Timer =====

cPowaTimer = PowaClass(function(timer, aura, base)
	timer.enabled = false;
	timer.x = 0;
	timer.y = 0;
	timer.a = 1.0;
	timer.h = 1.0;
	timer.cents = true;
	timer.Transparent = false;
	timer.HideLeadingZeros = false;
	timer.UpdatePing = false;
	timer.ShowActivation = false;
	timer.InvertAuraBelow = 0;
	timer.Texture = "Default";
	timer.Relative = "NONE";
	timer.UseOwnColor = false;
	timer.r = 1.0;
	timer.g = 1.0;
	timer.b = 1.0;
	--PowaAuras:ShowText("cPowaTimer");
	if (base) then
		for k, v in pairs (timer) do
			--PowaAuras:Message("  base."..tostring(k).."="..tostring(base[k]));
			local varType = type(v);
			if (varType == "string" or varType == "boolean" or varType == "number") then
				if (base[k] ~= nil) then
					timer[k] = base[k];
				end
			end
		end
	end
	timer.Showing = false;
	timer.id = aura.id;
	timer:SetShowOnAuraHide(aura);

	--for k,v in pairs (timer) do
	--	PowaAuras:ShowText("  "..tostring(k).."="..tostring(v));
	--end
end);


function cPowaTimer:SetShowOnAuraHide(aura)
	--PowaAuras:Message("CTR Timer id=", aura.id);
	--PowaAuras:Message("CooldownAura=", aura.CooldownAura);
	--PowaAuras:Message("inverse=", aura.inverse);
	--PowaAuras:Message("CanHaveTimer=", aura.CanHaveTimer);
	--PowaAuras:Message("CanHaveTimerOnInverse=", aura.CanHaveTimerOnInverse);
	--PowaAuras:Message("ShowActivation=", self.ShowActivation);
	self.ShowOnAuraHide = self.ShowActivation~=true and ((aura.CooldownAura and (not aura.inverse and aura.CanHaveTimer)) or (not aura.CooldownAura and (aura.inverse and aura.CanHaveTimerOnInverse)));
	--PowaAuras:Message("ShowOnAuraHide=", self.ShowOnAuraHide);
 end

function cPowaTimer:IsRelative()
	return (self.Relative and self.Relative~="NONE");
end

function cPowaTimer:GetTexture()
	local texture = PowaMisc.DefaultTimerTexture;
	if (self.Texture ~= "Default") then
		texture = self.Texture;
	end
	local postfix = "";
	if (self.Transparent) then
		postfix = "Transparent";
	end
    texture = "Interface\\Addons\\PowerAuras\\TimerTextures\\"..texture.."\\Timers"..postfix..".tga";
	--PowaAuras:ShowText("Timer texture: ", texture);
	return texture;
end
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> TIMERS
function cPowaTimer:Update(elapsed)
	--PowaAuras:UnitTestInfo("Timer.Update ",self.id);
	local aura = PowaAuras.Auras[self.id];
	if (aura == nil) then
		--PowaAuras:UnitTestInfo("Timer aura missing");
		if (PowaAuras.DebugCycle) then
			PowaAuras:ShowText("Timer aura missing for id=",self.id);
		end
		return;
	end
	
	if (PowaAuras.DebugCycle) then
		PowaAuras:ShowText("Timer.Update ",self.id);
	end

	if (self.enabled==false and self.InvertAuraBelow==0) then
		--PowaAuras:UnitTestInfo("Timer disabled");
		if (PowaAuras.DebugCycle) then
			PowaAuras:ShowText("Timer disabled");
		end
		return;
	end

	local newvalue = 0;
	if (PowaAuras.DebugCycle) then
		PowaAuras:ShowText("newvalue=",newvalue);
	end
	--- Determine the value to display in the timer
	if (PowaAuras.ModTest) then
		newvalue = random(0,99) + (random(0, 99) / 100);
		
	elseif (self.ShowActivation and self.Start~=nil) then
		newvalue = math.max(GetTime() - self.Start, 0);
	
	elseif (aura.timerduration > 0) then--- if a user defined timer is active for the aura override the rest
		if (((aura.target or aura.targetfriend) and (PowaAuras.ResetTargetTimers == true)) or not self.CustomDuration) then
			self.CustomDuration = aura.timerduration;
		else
			self.CustomDuration = math.max(self.CustomDuration - elapsed, 0);
		end	
		newvalue = self.CustomDuration;
	else
		if (self.DurationInfo and self.DurationInfo > 0) then
			newvalue = math.max(self.DurationInfo - GetTime(), 0);
		end
		aura:CheckTimerInvert();
	end

	if (PowaAuras.DebugCycle) then
		PowaAuras:Message("newvalue=",newvalue); --OK
	end

	--PowaAuras:UnitTestInfo("Timer newvalue", newvalue);
	--PowaAuras:ShowText("Timer newvalue=", newvalue, " elapsed=", elapsed);

	
	if (self.enabled==false or (aura.ForceTimeInvert and aura.InvertTimeHides)) then
		--PowaAuras:UnitTestInfo("Timer disabled");
		--PowaAuras:ShowText("Timer disabled");
		return;
	end
	
		
	if (newvalue and newvalue > 0) then --- Time has value to display

		PowaAuras:CreateTimerFrameIfMissing(self.id, self.UpdatePing);
	
		if (PowaAuras.DebugCycle) then
			PowaAuras:Message("cents=",self.cents); --OK
		end
		local incLarge = 0;
		if (self.cents) then
			local small;
			if (newvalue > 60.00) then 
				small = math.fmod(newvalue,60); 
			else
				small = (newvalue - math.floor(newvalue)) * 100;
			end
			if (PowaMisc.TimerRoundUp) then
				small = math.ceil(small);
			end
			
			--if (small==60) then
			--	incLarge=1;
			--	small = 0;
			--end

			if (PowaAuras.DebugCycle) then
				PowaAuras:Message("small=",small); --OK
			end
			if (self.lastShownSmall~=small) then
				self:ShowValue(aura, 2, small);
				self.lastShownSmall=small;
			end
		end	

		local large = newvalue;
		if (newvalue > 60.00) then 
			large = newvalue / 60;		
		end
		large = math.min (99.00, large);
		if ((not self.cents) and PowaMisc.TimerRoundUp) then
			large = math.ceil(large);
		else
			large = math.floor(large);		
		end
		large = large + incLarge;

		if (PowaAuras.DebugCycle) then
			PowaAuras:Message("large=",large); --OK
		end
		if (self.lastShownLarge~=large) then
			self:ShowValue(aura, 1, large);
			self.lastShownLarge=large;
		end

		self.Showing = true;		

	elseif (self.Showing) then
		if (PowaAuras.DebugCycle) then
			PowaAuras:Message("HideTimerFrames"); --OK
		end
		self:Hide();
		PowaAuras:TestThisEffect(self.id);
	end			
	
end

function cPowaTimer:SetDurationInfo(endtime)
	if (self.DurationInfo ~= endtime) then
		self.DurationInfo = endtime;
		--PowaAuras:ShowText("Timer refresh ", self.id, " DurationInfo", self.DurationInfo, " time=", self.DurationInfo - GetTime());
		if (PowaAuras.TimerFrame[self.id]) then
			for frameIndex = 1,2 do
				local timerFrame = PowaAuras.TimerFrame[self.id][frameIndex];
				if (timerFrame and self.UpdatePing and timerFrame.PingAnimationGroup) then
					--PowaAuras:ShowText("Timer UpdatePing");
					timerFrame.PingAnimationGroup:Play();
				end
			end
		end
	end
end

function cPowaTimer:ExtractDigits(displayValue)
	local deci = math.floor(displayValue / 10);
	local uni = math.floor(displayValue - (deci*10))
	return deci, uni;
end

function cPowaTimer:ShowValue(aura, frameIndex, displayValue)
	if (PowaAuras.TimerFrame==nil) then return; end
	if (PowaAuras.TimerFrame[self.id]==nil) then return; end
	local timerFrame = PowaAuras.TimerFrame[self.id][frameIndex];
	if (timerFrame==nil) then return; end
	if (aura.texmode == 1) then
		timerFrame.texture:SetBlendMode("ADD");
	else
		timerFrame.texture:SetBlendMode("DISABLE");
	end
	if (self.UseOwnColor) then
		timerFrame.texture:SetVertexColor(self.r,self.g,self.b);
	else
		local auraTexture = PowaAuras.Textures[self.id];
		if (auraTexture) then
			if auraTexture:GetObjectType() == "Texture" then
				timerFrame.texture:SetVertexColor(auraTexture:GetVertexColor());
			elseif auraTexture:GetObjectType() == "FontString" then
				timerFrame.texture:SetVertexColor(auraTexture:GetTextColor());
			end
		else
			timerFrame.texture:SetVertexColor(aura.r,aura.g,aura.b);
		end
	end
	
	local deci, uni = self:ExtractDigits(displayValue);
	--PowaAuras:ShowText("Show timer: ",deci, " ", uni, " ", PowaAuras.Auras[k].Timer.HideLeadingZeros);
	local tStep = PowaAuras.Tstep;
	if (deci==0 and self.HideLeadingZeros) then
		timerFrame.texture:SetTexCoord(tStep , tStep * 1.5, tStep * uni, tStep * (uni+1));
	else
		timerFrame.texture:SetTexCoord(tStep * uni, tStep * (uni+1), tStep * deci, tStep * (deci+1));
	end
	if (not timerFrame:IsVisible()) then
		if (aura.Debug) then
			PowaAuras:ShowText("Show timer frame id=", self.id, " index=", frameIndex);
		end
		timerFrame:Show(); -- Timer Frame
	end
	--PowaAuras:ShowText("Show #3 ", k, " ", i, " ", j, " ", seconds);
	
	--PowaAuras:ShowText("deci=", deci, " uni=", uni);
end


function cPowaTimer:HideFrame(i)
	if (PowaAuras.TimerFrame[self.id] and PowaAuras.TimerFrame[self.id][i]) then
		--PowaAuras:ShowText("Hide Timer Frame ", i," for ", self.id);
		PowaAuras.TimerFrame[self.id][i]:Hide();
	end
end

function cPowaTimer:Hide()
	if (not self.Showing) then return; end
	if PowaAuras.TimerFrame[self.id] then
		self:HideFrame(1);
		self:HideFrame(2);
	end
	self.lastShownLarge = nil;
	self.lastShownSmall = nil;
	self.Showing = false;
	--PowaAuras:ShowText("Hide timer frame");
end

function cPowaTimer:Delete()
	self:Hide();
	if PowaAuras.TimerFrame[self.id] then
		PowaAuras.TimerFrame[self.id][1] = nil;
		PowaAuras.TimerFrame[self.id][2] = nil;
		PowaAuras.TimerFrame[self.id] = nil;
	end
end