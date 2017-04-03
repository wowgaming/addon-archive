-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--      << Power Auras >>
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- ^\s*[^-\s][^-\s].*:ShowText\(.*$

-- Exposed for Saving
PowaMisc = 
	{
		Disabled = false,
		debug = false,
		OnUpdateLimit = 0,
		AnimationLimit = 0,
		Version = GetAddOnMetadata("PowerAuras", "Version"),
		DefaultTimerTexture = "Original",
		DefaultStacksTexture = "Original",
		TimerRoundUp = true,
		AllowInspections = true,
		AnimationFps = 30,
		UseGTFO = nil,
	};

PowaAuras.PowaMiscDefault = PowaAuras:CopyTable(PowaMisc);

PowaSet = {};
PowaTimer = {};

PowaGlobalSet = {};
PowaGlobalListe = {};
PowaPlayerListe = {};

--Default page names
for i = 1, 5 do
	PowaPlayerListe[i] = PowaAuras.Text.ListePlayer.." "..i;
end
for i = 1, 10 do
	PowaGlobalListe[i] = PowaAuras.Text.ListeGlobal.." "..i;
end



-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function PowaAuras:Toggle(enable)
	if (self.Initialising) then return; end
	--self:ShowText("Toggle Frame=", PowaAuras_Frame);
	if (enable==nil) then
		enable = PowaMisc.Disabled;
	end
	if enable then
		if (not PowaMisc.Disabled) then
			return;
		end
		if PowaAuras_Frame and not PowaAuras_Frame:IsShown() then		
			PowaAuras_Frame:Show(); -- Show Main Options Frame
			self:RegisterEvents(PowaAuras_Frame);
		end
		PowaMisc.Disabled = false;
		self:Setup();
		self:DisplayText("Power Auras "..self.Colors.Green..PowaAuras.Text.Enabled.."|r");
	else
		if (PowaMisc.Disabled) then
			return;
		end
		if PowaAuras_Frame and PowaAuras_Frame:IsShown() then
			PowaAuras_Frame:UnregisterAllEvents();
			PowaAuras_Frame:Hide();
		end
		self:OptionHideAll(true);
		PowaMisc.Disabled = true;
		self:DisplayText("Power Auras "..self.Colors.Red..ADDON_DISABLED.."|r");
	end
	--self:ShowText("Setting Enabled button to: ", PowaMisc.Disabled~=true);
	PowaEnableButton:SetChecked(PowaMisc.Disabled~=true);
end

function PowaAuras:OnLoad(frame)

	-- Remove Cata stuff from live
	if (not PowaAuras.Cataclysm) then
		PowaAuras.Text.PowerType[PowaAuras.PowerTypes.HolyPower] = nil;
		PowaAuras.PowerTypes.HolyPower = nil;
	end
	
	--- Setting up the Import/Export static popups
	self:SetupStaticPopups();

	frame:RegisterEvent("VARIABLES_LOADED");
	frame:RegisterEvent("PLAYER_ENTERING_WORLD");

	--- options init
	SlashCmdList["POWA"] = PowaAuras_CommanLine;
	SLASH_POWA1 = "/powa";
end

function PowaAuras:ReregisterEvents(frame)
	PowaAuras_Frame:UnregisterAllEvents();
	self:RegisterEvents(frame);
end

function PowaAuras:RegisterEvents(frame)
	for event in pairs(self.Events) do
		if (self[event]) then
			frame:RegisterEvent(event);
		else
			self:DisplayText("Event has no method ", event); --OK
		end
	end
end

function PowaAuras:LoadAuras()
	--self:Message("Saved varaible convertion: PowaSet");

	self.Auras = {};
	
	for k, v in pairs(PowaGlobalSet) do
		--self:UnitTestDebug("PowaGlobalSet",k,v.buffname);
		if (k~=0 and v.is_a == nil or not v:is_a(cPowaAura)) then
			--self:UnitTestDebug(k,v.buffname);
			self.Auras[k] = self:AuraFactory(v.bufftype, k, v);
		end
	end

	for k, v in pairs(PowaSet) do
		--self:UnitTestDebug("PowaSet",k,v.buffname, self.Auras[k]);
		if (k>0 and k <121 and not self.Auras[k]) then
			--self:UnitTestDebug("is_a=",v.is_a);
			if (v.is_a == nil or not v:is_a(cPowaAura)) then
				--self:ShowText("load aura ", k, " isResting=", v.isResting);
				self.Auras[k] = self:AuraFactory(v.bufftype, k, v);
				--self:ShowText("loaded isResting=", self.Auras[k].isResting);
				--self:UnitTestDebug("Out=",self.Auras[k].buffname);
			end
		end
	end

	--self:Message("backwards combatiblity");
	--self.Auras[0] = cPowaAura(0, {off=true});
	self:UpdateOldAuras();
	
	-- Copy to Saved Sets
	PowaSet = self.Auras;
	for i = 121, 360 do
		PowaGlobalSet[i] = self.Auras[i];
	end
	PowaTimer = {};
	
end

function PowaAuras:UpdateOldAuras()
	--self:Message("Saved varaible convertion: PowaTimer #", #PowaTimer);
	-- Copy old timer info (should be once only)
	for k, v in pairs(PowaTimer) do
		local aura = self.Auras[k];
		if (aura) then
			aura.Timer = cPowaTimer(aura, v);
			if (PowaSet[k]~=nil and PowaSet[k].timer~=nil) then
				aura.Timer.enabled = PowaSet[k].timer;
			end
			if (PowaGlobalSet[k]~=nil and PowaGlobalSet[k].timer~=nil) then
				aura.Timer.enabled = PowaGlobalSet[k].timer;
			end
		end	
	end
	
	local rescaleRatio = UIParent:GetHeight() / 768;
	if (not rescaleRatio or rescaleRatio==0) then
		rescaleRatio = 1;
	end

	-- Update for backwards combatiblity
	for i = 1, 360 do
		-- gere les rajouts
		local aura = self.Auras[i];
		local oldaura = PowaSet[i];
		if (oldaura==nil) then
			oldaura = PowaGlobalSet[i];
		end
		if (aura) then
			if (aura.combat==0) then
				aura.combat = 0;
			elseif (aura.combat==1) then
				aura.combat = true;
			elseif (aura.combat==2) then
				aura.combat = false;
			end
			if (aura.ignoreResting==true) then
				aura.isResting = true;
			elseif (aura.ignoreResting==true) then
				aura.isResting = false;
			end
			aura.ignoreResting = nil;
			if (aura.isinraid==true) then
				aura.inRaid = true;
			elseif (aura.isinraid==false) then
				aura.inRaid = 0;
			end
			aura.isinraid = nil;
			if (aura.isDead==true) then
				aura.isAlive = false;
			elseif (aura.isDead==false) then
				aura.isAlive = true;
			elseif (aura.isDead==0) then
				aura.isAlive = 0;
			end
			aura.isDead = nil;
			if (aura.buffname == "") then
				--self:Message("Delete aura "..i);
				self.Auras[i] = nil;
			elseif (aura.bufftype == nil and oldaura~=nil) then
				--self:Message("Repair bufftype for #"..i);
				
				if (oldaura.isdebuff) then
					aura.bufftype = self.BuffTypes.Debuff;
				elseif (oldaura.isdebufftype) then
					aura.bufftype = self.BuffTypes.TypeDebuff;
				elseif (oldaura.isenchant) then
					aura.bufftype = self.BuffTypes.Enchant;
				else
					aura.bufftype = self.BuffTypes.Buff;
				end
				
			-- Update old combo style 1235 => 1/2/3/5
			elseif (aura.bufftype==self.BuffTypes.Combo) then
				--self:UnitTestDebug("Combo upgrade check ", aura.buffname, " for ", aura.id);
				if (string.len(aura.buffname)>1 and string.find(aura.buffname, "/", 1, true)==nil) then
					local newBuffName=string.sub(aura.buffname, 1, 1);
					for i=2, string.len(aura.buffname) do
						newBuffName = newBuffName.."/"..string.sub(aura.buffname, i, i);
					end
					aura.buffname = newBuffName
				end
				
			--Update Spell Alert logic
			elseif (aura.bufftype==self.BuffTypes.SpellAlert) then
				if (PowaSet[i]~=nil and PowaSet[i].RoleTank==nil) then
					if (aura.target) then
						aura.groupOrSelf = true;
					elseif (aura.targetfriend) then
						aura.targetfriend = false;
					end
				end
			end
			
			-- Rescale if required
			if (PowaSet[i]~=nil and PowaSet[i].RoleTank==nil and math.abs(rescaleRatio-1.0)>0.01) then
				if (aura.Timer) then
					self:DisplayText("Rescaling aura ", i, " Timer");
					aura.Timer.x = aura.Timer.x * rescaleRatio;
					aura.Timer.y = aura.Timer.y * rescaleRatio;
					aura.Timer.h = aura.Timer.h * rescaleRatio;
				end	
				if (aura.Stacks) then
					self:DisplayText("Rescaling aura ", i, " Stacks");
					aura.Stacks.x = aura.Stacks.x * rescaleRatio;
					aura.Stacks.y = aura.Stacks.y * rescaleRatio;
					aura.Stacks.h = aura.Stacks.h * rescaleRatio;
				end				
			end

			if (PowaSet[i]~=nil) then
				if (aura.Timer) then
					aura.Timer.x = math.floor(aura.Timer.x + 0.5);
					aura.Timer.y = math.floor(aura.Timer.y + 0.5);
					aura.Timer.h = math.floor(aura.Timer.h * 100 + 0.5) / 100;
				end	
				if (aura.Stacks) then
					aura.Stacks.x = math.floor(aura.Stacks.x + 0.5);
					aura.Stacks.y = math.floor(aura.Stacks.y + 0.5);
					aura.Stacks.h = math.floor(aura.Stacks.h * 100 + 0.5) / 100;
				end				
			end			
			
		end
	end

end

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> EVENTS
function PowaAuras:FindAllChildren()
	--self:ShowText("FindAllChildren");
	for _, aura in pairs(self.Auras) do
		aura.Children = nil;
	end
	for _, aura in pairs(self.Auras) do
		self:FindChildren(aura);
	end
	--for _, aura in pairs(self.Auras) do
	--	if (aura.Children) then
	--		self:ShowText("Aura "..aura.id.." Children:");
	--		for childId in pairs(aura.Children) do
	--			self:ShowText("  "..childId);
	--		end
	--	end
	--end
end

function PowaAuras:FindChildren(aura)
	if (not aura.multiids or aura.multiids=="") then return; end
	--self:ShowText(aura.id.." "..aura.multiids);
	for pword in string.gmatch(aura.multiids, "[^/]+") do
		if (string.sub(pword, 1, 1) == "!") then
			pword = string.sub(pword, 2);
		end
		local id = tonumber(pword);
		--self:ShowText(" >>"..id);
		local dependant = self.Auras[id];
		if (dependant) then
			if (not dependant.Children) then
				dependant.Children = {};
			end
			dependant.Children[aura.id] = true;
		end
	end
end

function PowaAuras:CustomTexPath(customname)
	local texpath;
	if string.find(customname,".", 1, true) then
		texpath = "Interface\\Addons\\PowerAuras\\Custom\\"..customname;
	else
		_, _, texpath = GetSpellInfo(customname);
	end
	if not texpath then texpath = "" end
	return texpath;
end

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function PowaAuras:CreateTimerFrame(auraId, index, updatePing)
	local frame = CreateFrame("Frame", nil, UIParent);
	self.TimerFrame[auraId][index] = frame;
	local aura = self.Auras[auraId];
	
	frame:SetFrameStrata(aura.strata);
	frame:Hide(); 

	frame.texture = frame:CreateTexture(nil,"BACKGROUND");
	frame.texture:SetBlendMode("ADD");
	frame.texture:SetAllPoints(frame);
	frame.texture:SetTexture(aura.Timer:GetTexture());
	if (updatePing) then
		--self:ShowText("Creating Ping animation ", auraId, " ", index);
		frame.PingAnimationGroup = frame:CreateAnimationGroup("Ping");
		self:AddJumpScaleAndReturn(frame.PingAnimationGroup, 1.1, 1.1, 0.3, PowaMisc.AnimationFps, 1)
		self:AddBrightenAndReturn(frame.PingAnimationGroup, 1.2, aura.alpha, 0.3, PowaMisc.AnimationFps, 1);
	end
	
end

function PowaAuras:CreateTimerFrameIfMissing(auraId, updatePing)
	local aura = self.Auras[auraId];
	if (not self.Frames[auraId] and aura.Timer:IsRelative()) then
		aura.Timer.Showing = false;
		return;
	end
	if (not self.TimerFrame[auraId]) then
		--self:Message("Creating missing TimerFrames for aura "..tostring(auraId));		
		self.TimerFrame[auraId] = {};
		self:CreateTimerFrame(auraId, 1, updatePing);
		self:CreateTimerFrame(auraId, 2, updatePing);
	end
	self:UpdateOptionsTimer(auraId);
	return self.TimerFrame[auraId][1], self.TimerFrame[auraId][2];
end

function PowaAuras:CreateStacksFrameIfMissing(auraId, updatePing)
	local aura = self.Auras[auraId];
	if (not self.Frames[auraId] and aura.Stacks:IsRelative()) then
		aura.Stacks.Showing = false;
		return;
	end
	if (not self.StacksFrames[auraId]) then
		--self:Message("Creating missing StacksFrame for aura "..tostring(auraId));		
		local frame = CreateFrame("Frame", nil, UIParent);
		self.StacksFrames[auraId] = frame;
		
		frame:SetFrameStrata(aura.strata);
		frame:Hide(); 
		
		frame.texture = frame:CreateTexture(nil, "BACKGROUND");
		frame.texture:SetBlendMode("ADD");
		frame.texture:SetAllPoints(frame);
		frame.texture:SetTexture(aura.Stacks:GetTexture());
		if (updatePing) then
			--self:ShowText("Creating Ping animation ", auraId, " ", index);
			frame.PingAnimationGroup = frame:CreateAnimationGroup("Ping");
			self:AddJumpScaleAndReturn(frame.PingAnimationGroup, 1.1, 1.1, 0.3, PowaMisc.AnimationFps, 1)
			self:AddBrightenAndReturn(frame.PingAnimationGroup, 1.2, aura.alpha, 0.3, PowaMisc.AnimationFps, 1);
		end
	end
	self:UpdateOptionsStacks(auraId);
	return self.StacksFrames[auraId];
end

function PowaAuras:CreateEffectLists()
	
	for k in pairs(self.AurasByType) do
		wipe(self.AurasByType[k]);
	end
	
	self.Events = self:CopyTable(self.AlwaysEvents);
	for _, aura in pairs(self.Auras) do
		--print("Aura", aura.id);
		if (not aura.off) then
			aura:AddEffectAndEvents();
		end
	end 

	if (PowaMisc.debug == true) then
		for k in pairs(self.AurasByType) do
			self:DisplayText(k .. " : " .. #self.AurasByType[k]);
		end
	end

end

function PowaAuras:InitialiseAllAuras()
	for _, aura in pairs(self.Auras) do
		aura:Init();
	end 
end

function PowaAuras:MemorizeActions(actionIndex)
	local imin, imax;
	--self:Debug("---MemorizeActions---");
	if (#self.AurasByType.Actions == 0) then
		return;
	end
	
	--- scan tout ou uniquement le slot qui a change
	if (actionIndex == nil) then
		--self:ShowText("---Scan all Actionbuttons---");
		imin = 1;
		imax = 120;
		--- reset all action positions
		for _, v in pairs(self.AurasByType.Actions) do
			self.Auras[v].slot = nil;
		end
		
	else
		imin = actionIndex;
		imax = actionIndex;
	end

	for i = imin, imax do
		if (HasAction(i)) then
			local type, id, subType, spellID = GetActionInfo(i);
			local name, text;
			if (type=="macro") then
				name = GetMacroInfo(id);
			end
			PowaAction_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");
			PowaAction_Tooltip:SetAction(i);
			text = PowaAction_TooltipTextLeft1:GetText();
			PowaAction_Tooltip:Hide();

			--self:ShowText("---Button",i," Action Found---");
			--self:ShowText("tooltip text=",text);
			--if text and text ~= "" then
			--	self:ShowText("| "..text.." |");
			--end	
			if (text~=nil) then
				for k, v in pairs(self.AurasByType.Actions) do
					local actionAura = self.Auras[v];
					if (actionAura==nil) then
						self.AurasByType.Actions[k] = nil; -- aura deleted
					elseif (not actionAura.slot) then
						--self:ShowText("actionAura",v,actionAura.buffname, actionAura.ignoremaj);
						if (self:MatchString(name, actionAura.buffname, actionAura.ignoremaj)
						 or self:MatchString(text, actionAura.buffname, actionAura.ignoremaj)) then
							actionAura.slot = i; --- remember the slot
							--self:ShowText("========================================");
							--self:ShowText("Name=", name, "Tooltip=", text, " Match=", actionAura.buffname);
							--- remember the texture
							local tempicon;
							if (actionAura.owntex == true) then
								PowaIconTexture:SetTexture(GetActionTexture(i));
								tempicon = PowaIconTexture:GetTexture();
								if (actionAura.icon ~= tempicon) then
									actionAura.icon = tempicon;
								end
							elseif (actionAura.icon == "") then
								PowaIconTexture:SetTexture(GetActionTexture(i));
								actionAura.icon = PowaIconTexture:GetTexture();
							end
						end
					end
				end
			end
		end
	end
end


function PowaAuras:AddChildrenToCascade(aura, originalId)
	if (not aura or not aura.Children) then return; end
	for id in pairs(aura.Children) do
		if (not self.Cascade[id] and id~=originalId) then
			--self:ShowText("Cascade adding aura."..id);
			self.Cascade[id] = true;
			self:AddChildrenToCascade(self.Auras[id], originalId or aura.id);
		end
	end
end


--=== Run time ===--
function PowaAuras:OnUpdate(elapsed)
	--self:UnitTestInfo("OnUpdate", elapsed);

	if (self.Initialising) then return; end 
		
	self.ChecksTimer = self.ChecksTimer + elapsed;
	self.TimerUpdateThrottleTimer = self.TimerUpdateThrottleTimer + elapsed;	
	self.ThrottleTimer = self.ThrottleTimer + elapsed;
		
	self.DebugTimer = self.DebugTimer + elapsed;
	self.DebugCycle = false;
	if (self.NextDebugCheck>0 and self.DebugTimer > self.NextDebugCheck) then
		self.DebugTimer = 0;
		PowaAuras:Message("========DebugCycle========"); --OK
		self.DebugCycle = true;
	end

	--[[
	self.ProfileTimer = self.ProfileTimer + elapsed;
	self.UpdateCount = self.UpdateCount + 1;
	if (self.NextProfileCheck>0 and self.ProfileTimer > self.NextProfileCheck) then
		self.ProfileTimer = 0;
		PowaAuras:Message("========ProfileCycle========");
		PowaAuras:Message("UpdateCount=", self.UpdateCount);
		PowaAuras:Message("CheckCount=", self.CheckCount);
		PowaAuras:Message("EffectCount=", self.EffectCount);
		PowaAuras:Message("AuraCheckCount=", self.AuraCheckCount);
		PowaAuras:Message("AuraCheckShowCount=", self.AuraCheckShowCount);
		PowaAuras:Message("BuffUnitSetCount=", self.BuffUnitSetCount);
		PowaAuras:Message("BuffRaidCount=", self.BuffRaidCount);
		PowaAuras:Message("BuffUnitCount=", self.BuffUnitCount);
		PowaAuras:Message("BuffSlotCount=", self.BuffSlotCount);
		for k, v in pairs (self.AuraTypeCount) do
			PowaAuras:Message("AuraTypeCount[",k,"]=", v);
		end
		
		self.UpdateCount = 0;
		self.CheckCount = 0;
		self.EffectCount = 0;
		self.AuraCheckCount = 0;
		self.AuraCheckShowCount = 0;
		self.BuffUnitSetCount = 0;
		self.BuffRaidCount = 0;
		self.BuffUnitCount = 0;
		self.BuffSlotCount = 0;
		self.AuraTypeCount = {};
	end
	]]
	
	self.InGCD = nil;
	if (self.GCDSpellName) then
		local gcdStart = GetSpellCooldown(self.GCDSpellName);
		if (gcdStart) then
			self.InGCD = (gcdStart>0);
		end
	end
	
	local checkAura = false;
	if (PowaMisc.OnUpdateLimit == 0 or self.ThrottleTimer >= PowaMisc.OnUpdateLimit) then
		checkAura = true;
		self.ThrottleTimer = 0;
	end
			
	if (not self.ModTest and (checkAura or self.DebugCycle)) then

		--self.CheckCount = self.CheckCount + 1;

	    --self:Message("OnUpdate ",elapsedCheck, " ", self.ChecksTimer);
		--self:UnitTestInfo("ChecksTimer", self.ChecksTimer, self.NextCheck);
		if ((self.ChecksTimer > (self.NextCheck + PowaMisc.OnUpdateLimit))) then
			self.ChecksTimer = 0;
			local isMountedNow = (IsMounted()~=nil);
			if (isMountedNow ~= self.WeAreMounted) then
				self.DoCheck.All = true;
				self.WeAreMounted = isMountedNow;
			end	
			local isInVehicledNow = (UnitInVehicle("player")~=nil);
			if (isInVehicledNow ~= self.WeAreInVehicle) then
				self.DoCheck.All = true;
				self.WeAreInVehicle = isInVehicledNow;
			end	
		end

		if (self.PendingRescan and GetTime() >= self.PendingRescan) then	
			self:InitialiseAllAuras();
			self:MemorizeActions();
			self.DoCheck.All = true;
			self.PendingRescan = nil;
		end
		
		--self:UnitTestInfo("Pending");
		for id, cd in pairs(self.Pending) do	
			--self:ShowText("Pending check for ", id, " cd=", cd, " time=", GetTime());
			if cd and cd >0 then
				--self:ShowText("Pending check for ", id, " cd=", cd, " time=", GetTime());
				if (GetTime() >= cd) then
					self.Pending[id] = nil;
					if (self.Auras[id]) then
						self.Auras[id].CooldownOver = true;
						--self:ShowText("Pending TestThisEffect for ", id);
						self:TestThisEffect(id);
						self.Auras[id].CooldownOver = nil;
					end
				end
			else
				self.Pending[id] = nil;
			end
		end
	
		--self:UnitTestInfo("DoCheck update");
		for k ,v in pairs(self.DoCheck) do
			--self:ShowText("DoCheck "..k.." = " .. tostring(v)  );
			if (v) then
				--self:ShowText("DoCheck ", k);
				self:NewCheckBuffs();
				break;
			end
		end

		--self:UnitTestInfo("Check Cascade auras");
		for k in pairs(self.Cascade) do
			--self:ShowText("Checking Cascade aura."..k);
			self:TestThisEffect(k, false, true);
		end
		wipe(self.Cascade);		
	end
	
	local skipTimerUpdate = false
	local timerElapsed = 0;
	if (PowaMisc.AnimationLimit > 0 and self.TimerUpdateThrottleTimer < PowaMisc.AnimationLimit) then
		skipTimerUpdate = true and not self.DebugCycle;
	else
		timerElapsed = self.TimerUpdateThrottleTimer;
		self.TimerUpdateThrottleTimer = 0;
	end
	
	if (PowaMisc.AllowInspections) then
		-- Refresh Inspect, check timeout
		if (self.NextInspectUnit ~= nil) then
			if (GetTime() > self.NextInspectTimeOut) then
				--self:Message("Inspection timeout for ", self.NextInspectUnit);
				self:SetRoleUndefined(self.NextInspectUnit);
				self.NextInspectUnit = nil;
				self.InspectAgain = GetTime() + self.InspectDelay;
			end
		elseif (not self.InspectsDone
				and self.InspectAgain~=nil 
				and not UnitOnTaxi("player")
				and GetTime()>self.InspectAgain) then
			self:TryInspectNext();
			self.InspectAgain = GetTime() + self.InspectDelay;
		end
	end


	-- Update each aura (timers and stacks)
	--self:UnitTestInfo("Aura updates");
	for _, aura in pairs(self.Auras) do
		if (self:UpdateAura(aura, elapsed)) then
			self:UpdateTimer(aura, timerElapsed, skipTimerUpdate);
		end
	end	
	for _, aura in pairs(self.SecondaryAuras) do
		self:UpdateAura(aura, elapsed);
	end	
	
	self.ResetTargetTimers = false;

end

function PowaAuras:NewCheckBuffs()
   	--self:UnitTestInfo("NewCheckBuffs");

	--if (self.DoCheck.All) then
	--	self:ShowText("self.DoCheck.All");
	--end
	for auraType in pairs(self.AurasByType) do
		--self:ShowText("Check auraType ",auraType);
		if ((self.DoCheck[auraType] or self.DoCheck.All) and #self.AurasByType[auraType]>0) then
			--self:ShowText("Checking auraType ",auraType, " #", #self.AurasByType[auraType]);
			--if (self.DoCheck.All) then
				--self:ShowText("TestAuraTypes ",auraType," DoCheck ", self.DoCheck[auraType], " All ", self.DoCheck.All, " #", #self.AurasByType[auraType]);
			--end
			for k, v in pairs(self.AurasByType[auraType]) do
				--self:ShowText(k," TestThisEffect ",v);
				if (self.Auras[v].Debug) then
					self:ShowText("TestThisEffect ",v);
				end
				--if (self.AuraTypeCount[auraType] == nil) then self.AuraTypeCount[auraType] = 0; end
				--self.AuraTypeCount[auraType] = self.AuraTypeCount[auraType] + 1;
				self:TestThisEffect(v);
			end
		end
		self.DoCheck[auraType] = false;
	end

	self.DoCheck.All = false;
	
	wipe(self.AoeAuraAdded);
	wipe(self.ChangedUnits.Buffs);
	wipe(self.ExtraUnitEvent);
	wipe(self.CastOnMe);

end

function PowaAuras:TestThisEffect(auraId, giveReason, ignoreCascade)
	--self:UnitTestInfo("TestThisEffect", auraId);
	--self:ShowText("TestThisEffect", auraId);

	local aura = self.Auras[auraId];
	if (not aura) then
		--self:ShowText("Aura missing ", auraId);
		return false, self.Text.nomReasonAuraMissing;
	end
	if (aura.off) then
		if (aura.Showing) then
			--self:ShowText("aura:Hide because off", auraId);
			aura:Hide();
		end
		if (not giveReason) then return false; end
		return false, self.Text.nomReasonAuraOff;
	end
	
	local debugEffectTest = PowaAuras.DebugCycle or aura.Debug;
	--self.EffectCount = self.EffectCount + 1;

	if (debugEffectTest) then
		self:Message("===================================");
		self:Message("Test Aura for Hide or Show = ",auraId);
		self:Message("Active= ", aura.Active);
		self:Message("Showing= ", aura.Showing);
	end
	-- Prevent crash if class not set-up properly
	if (not aura.ShouldShow) then
		self:Message("ShouldShow nil! id= ",auraId)
		if (not giveReason) then return false; end
		return false, self.Text.nomReasonAuraBad;
	end
	
	--self:ShowText("Test Aura for Hide or Show = ",auraId, " showing=",aura.Showing);
	aura.TimerInactiveDueToMulti = nil;
	local shouldShow, reason = aura:ShouldShow(giveReason or debugEffectTest);
	if (shouldShow==-1) then
		if (debugEffectTest) then
			self:Message("TestThisEffect unchanged");
		end
		return aura.Active, reason;
	end
	
	if (shouldShow==true) then
		shouldShow, reason = self:CheckMultiple(aura, reason, giveReason or debugEffectTest);
		if (not shouldShow) then
			--self:ShowText("TimerInactiveDueToMulti Aura ", aura.buffname, " (",auraId,")");
			aura.TimerInactiveDueToMulti = true;
		end
	elseif (aura.Timer and aura.CanHaveTimerOnInverse) then
		local multiShouldShow = self:CheckMultiple(aura, reason, giveReason or debugEffectTest);
		if (not multiShouldShow) then
			--self:ShowText("TimerInactiveDueToMulti Aura ", aura.buffname, " (",auraId,")");
			aura.TimerInactiveDueToMulti = true;
		end
	end
	if (debugEffectTest) then
		self:Message("shouldShow=", shouldShow, " because ", reason);
	end
	
	if shouldShow then
		if (not aura.Active) then
			if (debugEffectTest) then
				self:Message("ShowAura ", aura.buffname, " (",auraId,") ", reason);
			end
			self:DisplayAura(auraId);
			if (not ignoreCascade) then self:AddChildrenToCascade(aura); end
			aura.Active = true;
		end
	else
		local secondaryAura = self.SecondaryAuras[aura.id];
		if (aura.Showing) then
			if (debugEffectTest) then
				self:Message("HideAura ", aura.buffname, " (",auraId,") ", reason);
			end
			self:SetAuraHideRequest(aura, secondaryAura);
		end
		if (aura.Active) then
			if (not ignoreCascade) then
				self:AddChildrenToCascade(aura);
			end
			aura.Active = false;
			if (secondaryAura) then
				secondaryAura.Active = false;
			end
		end
	end
	
	return shouldShow, reason;
end

function PowaAuras:CheckMultiple(aura, reason, giveReason)
	if (not aura.multiids or aura.multiids == "") then
		if (not giveReason) then return true; end
		return true, reason;
	end
	if string.find(aura.multiids, "[^0-9/!]") then --- invalid input (only numbers and / allowed)
		--self:Debug("Multicheck. Invalid Input. Only numbers and '/' allowed.");
		if (not giveReason) then return true; end
		return true, reason;
	end
	for pword in string.gmatch(aura.multiids, "[^/]+") do
		local reverse;
		if (string.sub(pword, 1, 1) == "!") then
			pword = string.sub(pword, 2);
			reverse = true;
		end
		local k = tonumber(pword);
		local linkedAura = self.Auras[k];
		local state;
		if linkedAura then
			--self:ShowText("Multicheck. Aura ",k);	
			result, reason = linkedAura:ShouldShow(giveReason, reverse);
			if (result==false or (result==-1 and not linkedAura.Showing and not linkedAura.HideRequest)) then
				if (not giveReason) then return false; end
				return result, reason;
			end 				
		else
			--self:Debug("Multicheck. Non-existant Aura ID specified: "..pword);
		end
	end
	if (not giveReason) then return true; end
	return true, self:InsertText(self.Text.nomReasonMulti, aura.multiids);	
end

function PowaAuras:SetAuraHideRequest(aura, secondaryAura)
	if (aura.Debug) then
		self:Message("SetAuraHideRequest ", aura.buffname);
	end
	aura.HideRequest = true;
	if (not aura.InvertTimeHides) then
		aura.ForceTimeInvert = nil;
	end
	if (secondaryAura and secondaryAura.Active) then
		secondaryAura.HideRequest = true;
	end
end

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
function PowaAuras:ShowAuraForFirstTime(aura)
	--self:UnitTestInfo("ShowAuraForFirstTime", aura.id);
	if (aura.Debug) then
		self:Message("ShowAuraForFirstTime ", aura.id);
	end
	local auraId = aura.id;
	
	if (not aura.UseOldAnimations and aura.EndAnimation and aura.EndAnimation:IsPlaying()) then
		if (aura.Debug) then
			self:Message("Hide aura as already playing");
		end
		aura:Hide();
	end

	aura.EndSoundPlayed = nil;
	
	if (self.ModTest == false) then
		if (aura.customsound ~= "") then
			local pathToSound;
			if (string.find(aura.customsound, "\\")) then
				pathToSound = aura.customsound;
			else 
				pathToSound = "Interface\\AddOns\\PowerAuras\\Sounds\\"..aura.customsound;
			end
			--self:ShowText("Playing sound "..pathToSound);		
			PlaySoundFile(pathToSound);
		elseif (aura.sound > 0) then
			if (PowaAuras.Sound[aura.sound]~=nil and string.len(PowaAuras.Sound[aura.sound])>0) then
				if (string.find(PowaAuras.Sound[aura.sound], "%.")) then
					PlaySoundFile("Interface\\AddOns\\PowerAuras\\Sounds\\"..PowaAuras.Sound[aura.sound]);
				else
					PlaySound(PowaAuras.Sound[aura.sound]);
				end
			end
		end	
	end
	
	local frame, texture = aura:CreateFrames();

	if (aura.owntex == true) then
		if (aura.icon=="") then
			texture:SetTexture("Interface\\Icons\\Inv_Misc_QuestionMark");
		else
			texture:SetTexture(aura.icon);
		end
	elseif (aura.wowtex == true) then
		texture:SetTexture(self.WowTextures[aura.texture]);
	elseif (aura.customtex == true) then
		texture:SetTexture(self:CustomTexPath(aura.customname));
	elseif (aura.textaura == true) then
		texture:SetText(aura:GetAuraText());	  	
	else
		texture:SetTexture("Interface\\Addons\\PowerAuras\\Auras\\Aura"..aura.texture..".tga");
	end
  
	if (aura.randomcolor) then
		texture:SetVertexColor(random(20,100)/100,random(20,100)/100,random(20,100)/100);	
	else
		texture:SetVertexColor(aura.r,aura.g,aura.b);
	end
  
	if (aura.texmode == 1) then
		if (aura.textaura ~= true) then
			texture:SetBlendMode("ADD");
		else
			texture:SetShadowColor(0.0, 0.0, 0.0, 0.8);
			texture:SetShadowOffset(2,-2);
		end
		frame:SetFrameStrata(aura.strata);
	else
		if (aura.textaura ~= true) then
			texture:SetBlendMode("DISABLE");
		else
			texture:SetShadowColor(0.0, 0.0, 0.0, 0.0);
			texture:SetShadowOffset(0,0);
		end
		frame:SetFrameStrata("BACKGROUND");
	end

	if (aura.textaura ~= true) then
	  if (aura.symetrie == 1) then 
		texture:SetTexCoord(1, 0, 0, 1); --- inverse X
	  elseif (aura.symetrie == 2) then 
		texture:SetTexCoord(0, 1, 1, 0); --- inverse Y
	  elseif (aura.symetrie == 3) then 
		texture:SetTexCoord(1, 0, 1, 0); --- inverse XY
	  else 
		texture:SetTexCoord(0, 1, 0, 1); 
	  end	
	end

	frame.baseH = 256 * aura.size * (2-aura.torsion);
	if (aura.textaura == true) then
		local fontsize = math.min(33, math.max(10, math.floor(frame.baseH / 12.8)));
		local checkfont = texture:SetFont(self.Fonts[aura.aurastextfont], fontsize, "OUTLINE, MONOCHROME");
		if not checkfont then
			texture:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE, MONOCHROME");
		end
		frame.baseL = texture:GetStringWidth() + 5;
	else
		frame.baseL = 256 * aura.size * aura.torsion;
	end

	PowaAuras:InitialiseFrame(aura, frame);

	if (aura.duration>0) then
		aura.TimeToHide = GetTime() + aura.duration;
	else
		aura.TimeToHide = nil;
	end
	
	if (aura.InvertTimeHides) then
		aura.ForceTimeInvert = nil;
	end
	

	if (aura.Timer and aura.Timer.enabled) then
		if (aura.Debug) then
			self:Message("Show Timer");
		end
		PowaAuras:CreateTimerFrameIfMissing(aura.id, aura.Timer.UpdatePing);
		if (aura.timerduration) then
			aura.Timer.CustomDuration = aura.timerduration;
		end
		aura.Timer.Start = GetTime();
	end
	if (aura.Stacks and aura.Stacks.enabled) then
		PowaAuras:CreateStacksFrameIfMissing(aura.id, aura.Stacks.UpdatePing);
		aura.Stacks:ShowValue(aura, aura.Stacks.lastShownValue)
	end

	if (aura.UseOldAnimations) then
	
		frame.statut = 0;
	
		if (aura.begin > 0) then 
			frame.beginAnim = 1;
		else 
			frame.beginAnim = 0; 
		end

		if (aura.begin and aura.begin>0) then
			aura.animation = self:AnimationBeginFactory(aura.begin, aura, frame);
		else
			aura.animation = self:AnimationMainFactory(aura.anim1, aura, frame);
		end
	else
	
		if (not aura.BeginAnimation) then aura.BeginAnimation = self:AddBeginAnimation(aura, frame); end
		if (not aura.MainAnimation) then aura.MainAnimation = self:AddMainAnimation(aura, frame); end
		if (not aura.EndAnimation) then aura.EndAnimation = self:AddEndAnimation(aura, frame); end
	
	end
	
	if (not aura.UseOldAnimations) then
		if (aura.BeginAnimation) then
			aura.BeginAnimation:Play();
			frame:SetAlpha(0); -- prevents flickering
		elseif (aura.MainAnimation) then
			aura.MainAnimation:Play();
		end
	end

	--self:UnitTestInfo("frame:Show()", aura.id);
	if (aura.Debug) then
		self:Message("frame:Show()", aura.id, " ", frame);
	end
	frame:Show(); -- Show Aura Frame

	aura.Showing = true;
	aura.HideRequest = false;
	self:ShowSecondaryAuraForFirstTime(aura);	
end

function PowaAuras:InitialiseFrame(aura, frame)
	frame:SetAlpha(math.min(aura.alpha,0.99));
	frame:SetPoint("CENTER",aura.x, aura.y);
	frame:SetWidth(frame.baseL);
	frame:SetHeight(frame.baseH);
end

function PowaAuras:ShowSecondaryAuraForFirstTime(aura)
	--self:UnitTestInfo("ShowSecondaryAuraForFirstTime", aura.id);

	if (aura.anim2 == 0) then --- no secondary aura
		local secondaryAura = self.SecondaryAuras[aura.id];
		if (secondaryAura) then
			secondaryAura:Hide();
		end
		self.SecondaryAuras[aura.id] = nil;
		self.SecondaryFrames[aura.id] = nil;
		self.SecondaryTextures[aura.id] = nil;
		return;
	end

	-- new secondary Aura
	local secondaryAura = self:AuraFactory(aura.bufftype, aura.id, aura);
	self.SecondaryAuras[aura.id] = secondaryAura;
	
	secondaryAura.isSecondary = true;
	secondaryAura.alpha = aura.alpha * 0.5;
	secondaryAura.anim1 = aura.anim2;
	if (aura.speed > 0.5) then
		secondaryAura.speed = aura.speed - 0.1; --- legerement plus lent
	else
		secondaryAura.speed = aura.speed / 2; --- legerement plus lent
	end

	local auraId = aura.id;
	local frame = self.Frames[auraId];
	local texture = self.Textures[auraId];

	local secondaryFrame, secondaryTexture = secondaryAura:CreateFrames();
	
	if (aura.owntex == true) then
		secondaryTexture:SetTexture(aura.icon);
	elseif (aura.wowtex == true) then
		secondaryTexture:SetTexture(self.WowTextures[aura.texture]);
	elseif (aura.customtex == true) then
		secondaryTexture:SetTexture(self:CustomTexPath(aura.customname));
	elseif (aura.textaura == true) then
		secondaryTexture:SetText(aura.aurastext);	  	
	else
		secondaryTexture:SetTexture("Interface\\Addons\\PowerAuras\\Auras\\Aura"..aura.texture..".tga");
	end
	
	if (aura.randomcolor) then
		if texture:GetObjectType() == "Texture" then
			secondaryTexture:SetVertexColor( texture:GetVertexColor() );
		elseif texture:GetObjectType() == "FontString" then
			secondaryTexture:SetVertexColor(texture:GetTextColor());
		end
	else
		secondaryTexture:SetVertexColor(aura.r,aura.g,aura.b);
	end
	
	if (aura.texmode == 1) then
		if (aura.textaura ~= true) then
			secondaryTexture:SetBlendMode("ADD");
		end
		secondaryFrame:SetFrameStrata(aura.strata);
	else
		if (aura.textaura ~= true) then
			secondaryTexture:SetBlendMode("DISABLE");
		end
		secondaryFrame:SetFrameStrata("BACKGROUND");
	end

	if not aura.textaura == true then
		if (aura.symetrie == 1) then 
			secondaryTexture:SetTexCoord(1, 0, 0, 1); --- inverse X
		elseif (aura.symetrie == 2) then 
			secondaryTexture:SetTexCoord(0, 1, 1, 0); --- inverse Y
		elseif (aura.symetrie == 3) then 
			secondaryTexture:SetTexCoord(1, 0, 1, 0); --- inverse XY
		else 
			secondaryTexture:SetTexCoord(0, 1, 0, 1); 
		end
	end

	secondaryFrame.baseL = frame.baseL;
	secondaryFrame.baseH = frame.baseH;
	secondaryFrame:SetPoint("CENTER",aura.x, aura.y);
	secondaryFrame:SetWidth(secondaryFrame.baseL);
	secondaryFrame:SetHeight(secondaryFrame.baseH);



	if (aura.UseOldAnimations) then

		secondaryFrame.statut = 1;
		
		if (aura.begin > 0) then 
			secondaryFrame.beginAnim = 2;
		else 
			secondaryFrame.beginAnim = 0; 
		end

		if (not aura.begin or aura.begin==0) then
			secondaryAura.animation = self:AnimationMainFactory(aura.anim2, secondaryAura, secondaryFrame);
		else
			secondaryFrame:SetAlpha(0.0); -- Hide secondary until primary begin animation finishes
		end
		--self:UnitTestInfo("secondaryFrame:Show()", aura.id);
		secondaryFrame:Show(); -- Show Secondary Aura Frame
		--self:Message("Show #2");
	else	
		if (not secondaryAura.MainAnimation) then
			secondaryAura.MainAnimation = self:AddMainAnimation(secondaryAura, secondaryFrame);
		end	
	
		if (not aura.BeginAnimation) then
			--self:UnitTestInfo("secondaryFrame:Show()", aura.id);
			secondaryFrame:Show(); -- Show Secondary Aura Frame
			--self:Message("Show #2");
			if (secondaryAura.MainAnimation) then
				secondaryAura.MainAnimation:Play();
			end
		end

	end
	
	secondaryAura.Showing = true;
	secondaryAura.HideRequest = false;
end

function PowaAuras:DisplayAura(auraId)
	--self:UnitTestInfo("DisplayAura", auraId);
	--self:ShowText("DisplayAura aura ", auraId);
	if (self.Initialising) then return; end   --- de-actived

	local aura = self.Auras[auraId];
	if (aura==nil or aura.off) then return; end

	--self:ShowText("DisplayAura aura ", aura.id);
	
	self:ShowAuraForFirstTime(aura);
end


function PowaAuras:UpdateAura(aura, elapsed)
	--self:ShowText("UpdateAura ", aura.id, " ", elapsed);
	if (aura == nil) then
		--self:UnitTestInfo("UpdateAura: Don't show, aura missing");
		--self:ShowText("UpdateAura: Don't show, aura missing");
		return false;
	end
	if (aura.off) then
		if (aura.Showing) then
			aura:Hide();
		end
		if (aura.Timer and aura.Timer.Showing) then
			aura.Timer:Hide(); -- Aura off
		end
		return false;
	end
	
	if (PowaAuras.DebugCycle) then
		self:DisplayText("====Aura"..aura.id.."====");
		self:DisplayText("aura.HideRequest=",aura.HideRequest);
		self:DisplayText("aura.Showing=",aura.Showing);
	end

	--self:ShowText("aura.Showing ", aura.Showing);
	if (aura.Showing) then
		local frame = aura:GetFrame();
		if (frame == nil) then
			----self:UnitTestInfo("UpdateAura: Don't show, frame missing");
			--self:ShowText("UpdateAura: Don't show, frame missing");
			return false;
		end
		--self:ShowText("UpdateAura ", aura, " ", elapsed, " HideRequest=", aura.HideRequest);
		
		if (not aura.HideRequest and not aura.isSecondary and not self.ModTest and aura.TimeToHide) then
			if (GetTime() >= aura.TimeToHide) then --- If duration has expired then hide this aura
				----self:UnitTestInfo("UpdateAura: Hide, duration expired");
				--self:ShowText("UpdateAura: Hide, duration expired");
				self:SetAuraHideRequest(aura);
				aura.TimeToHide = nil;
			end
		end
		
		if (aura.HideRequest) then

		
			if (self.ModTest == false and not aura.EndSoundPlayed) then
				
				if (aura.customsoundend ~= "") then
					if (aura.Debug) then
						self:Message("Playing Custom end sound ", aura.customsoundend);
					end
					local pathToSound;
					if (string.find(aura.customsoundend, "\\")) then
						pathToSound = aura.customsoundend;
					else 
						pathToSound = "Interface\\AddOns\\PowerAuras\\Sounds\\"..aura.customsoundend;
					end
					--self:ShowText("Playing sound "..pathToSound);		
					PlaySoundFile(pathToSound);
				elseif (aura.soundend > 0) then
					if (PowaAuras.Sound[aura.soundend]~=nil and string.len(PowaAuras.Sound[aura.soundend])>0) then
						if (aura.Debug) then
							self:Message("Playing end sound ", PowaAuras.Sound[aura.soundend]);
						end
						if (string.find(PowaAuras.Sound[aura.soundend], "%.")) then
							PlaySoundFile("Interface\\AddOns\\PowerAuras\\Sounds\\"..PowaAuras.Sound[aura.soundend]);
						else
							PlaySound(PowaAuras.Sound[aura.soundend]);
						end
					end
				end
				aura.EndSoundPlayed = true;
			end
		
		
			if (aura.Stacks) then
				aura.Stacks:Hide();
			end
			if (aura.Debug) then
				self:Message("Hide Requested for ",aura.id);
			end
			
			if (aura.UseOldAnimations) then
				aura.animation = self:AnimationEndFactory(aura.finish, aura, frame);
				if (not aura.animation) then
					aura:Hide();
				end
			else
				if (not aura.EndAnimation) then
					aura:Hide();
				else
					if (aura.Debug) then
						self:Message("Stop current animations ",aura.id);
					end
					if (aura.BeginAnimation and aura.BeginAnimation:IsPlaying()) then
						aura.BeginAnimation:Stop();	
					end
					if (aura.MainAnimation and aura.MainAnimation:IsPlaying()) then
						aura.MainAnimation:Stop();
					end
					if (aura.Debug) then
						self:Message("Play end animation ",aura.id);
					end
					aura.EndAnimation:Play();
				end
			end
		end

		if (aura.UseOldAnimations) then
			self:UpdateAuraAnimation(aura, elapsed, frame);
		end

		if (self.ModTest and aura.Stacks and aura.Active) then
			if (aura.Stacks.SetStackCount) then
				aura.Stacks:SetStackCount(random(1,12));
			else
				self:Message("aura.Stacks:SetStackCount nil!! ",aura.id);			
			end
		end

	end

	aura.HideRequest = false;
	return true;
end

function PowaAuras:UpdateTimer(aura, timerElapsed, skipTimerUpdate)

	--if (aura.Debug) then
	--	--PowaAuras:UnitTestInfo("UpdateTimer ",self.id, " ", aura.Timer, " skip=",skipTimerUpdate);
	--end
	
	if (not aura.Timer or skipTimerUpdate) then
		return;
	end
	
	if (PowaAuras.DebugCycle) then
		self:DisplayText("aura.Timer id=",aura.id);
		self:DisplayText("ShowOnAuraHide=",aura.Timer.ShowOnAuraHide);
		self:DisplayText("ForceTimeInvert=",aura.ForceTimeInvert);
		self:DisplayText("InvertTimeHides=",aura.InvertTimeHides);
		self:DisplayText("ModTest=",self.ModTest);
		self:DisplayText("aura.Active=",aura.Active);
	end
	local timerHide;
	if (aura.Timer.ShowOnAuraHide and not self.ModTest and (not aura.ForceTimeInvert and not aura.InvertTimeHides)) then
		timerHide = aura.Active;
	else
		timerHide = not aura.Active;
	end
	if (PowaAuras.DebugCycle) then
		self:Message("timerHide=",timerHide);
		self:Message("InactiveDueToState=",aura.InactiveDueToState);
	end
	if (timerHide or (aura.InactiveDueToState and not aura.Active) or aura.TimerInactiveDueToMulti) then
		aura.Timer:Hide(); -- Request or state
		if (aura.ForceTimeInvert) then
			aura.Timer:Update(timerElapsed);				
		end
	else
		aura.Timer:Update(timerElapsed);
	end
	
end

function PowaAuras:UpdateAuraAnimation(aura, elapsed, frame)
	if (not aura.Showing) then return; end
	if (not aura.animation or elapsed==0) then return; end
	if (aura.isSecondary) then
		-- Secondary animation only shows during primary main animation
		primaryAnimation = PowaAuras.Auras[aura.id].animation;
		if (primaryAnimation.IsBegin or primaryAnimation.IsEnd) then
			return;
		end
	end
			
	local finished = aura.animation:Update(math.min(elapsed, 0.03));
	
	if (not finished) then return end
	
	if (aura.animation.IsBegin) then
		--self:ShowText("Create main animation for primary aura");
		aura.animation = self:AnimationMainFactory(aura.anim1, aura, frame);
		--self:ShowText("Create main animation for primary aura");
		local secondaryAura = self.SecondaryAuras[aura.id];
		if (secondaryAura) then
			local secondaryAuraFrame = self.SecondaryFrames[aura.id];
			if (secondaryAuraFrame) then
				--self:ShowText("Create main animation for secondary aura");
				secondaryAura.animation = self:AnimationMainFactory(aura.anim2, secondaryAura, secondaryAuraFrame);
				--self:ShowText("animation=", secondaryAura.animation);
			end
		end
		return;
	end
	
	if (aura.animation.IsEnd) then
		aura:Hide();
	end

end

function PowaAuras:SetupStaticPopups()
	
	StaticPopupDialogs["POWERAURAS_IMPORT_AURA"] = {
		text = self.Text.aideImport,
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = self.ExportMaxSize,
		--hasWideEditBox = 1,
		editBoxWidth = self.ExportWidth,
		OnAccept = function(self)
			PowaAuras:CreateNewAuraFromImport(PowaAuras.ImportAuraId, self.editBox:GetText());
			self:Hide();
		end,
		OnShow = function(self)
			self.editBox:SetFocus();
		end,
		OnHide = function(self)
			ChatEdit_FocusActiveWindow(); 	
			self.editBox:SetText("");
			PowaAuras:DisplayAura(PowaAuras.CurrentAuraId);
			PowaAuras:UpdateMainOption();
		end,
		EditBoxOnEnterPressed = function(self)
			local parent = self:GetParent();
			PowaAuras:CreateNewAuraFromImport(PowaAuras.ImportAuraId, parent.editBox:GetText());
			parent:Hide();
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	};	
	
	StaticPopupDialogs["POWERAURAS_EXPORT_AURA"] = {
		text = self.Text.aideExport,
		button1 = DONE,
		hasEditBox = 1,
		maxLetters = self.ExportMaxSize,
		--hasWideEditBox = 1,
		editBoxWidth = self.ExportWidth,
		OnShow = function(self)
			self.editBox:SetText(PowaAuras.Auras[PowaAuras.CurrentAuraId]:CreateAuraString());
			self.editBox:SetFocus();
			self.editBox:HighlightText();
		end,
		OnHide = function(self)
			ChatEdit_FocusActiveWindow(); 
			self.editBox:SetText("");
		end,
		EditBoxOnEnterPressed = function(self)
			self:GetParent():Hide();
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	};

	
	StaticPopupDialogs["POWERAURAS_IMPORT_AURA_SET"] = {
		text = self.Text.aideImportSet,
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = self.ExportMaxSize * 24,
		--hasWideEditBox = 1,
		editBoxWidth = self.ExportWidth,
		OnAccept = function(self)
			PowaAuras:CreateNewAuraSetFromImport(self.editBox:GetText());
			self:Hide();
		end,
		OnShow = function(self)
			self.editBox:SetFocus();
		end,
		OnHide = function(self)
			ChatEdit_FocusActiveWindow(); 
			self.editBox:SetText("");
			PowaAuras:DisplayAura(PowaAuras.CurrentAuraId);
			PowaAuras:UpdateMainOption();
		end,
		EditBoxOnEnterPressed = function(self)
			local parent = self:GetParent();
			PowaAuras:CreateNewAuraSetFromImport(parent.editBox:GetText());
			parent:Hide();
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	};	
	
	StaticPopupDialogs["POWERAURAS_EXPORT_AURA_SET"] = {
		text = self.Text.aideExportSet,
		button1 = DONE,
		hasEditBox = 1,
		maxLetters = self.ExportMaxSize * 24,
		--hasWideEditBox = 1,
		editBoxWidth = self.ExportWidth,
		OnShow = function(self)
			self.editBox:SetText(PowaAuras:CreateAuraSetString());
			self.editBox:SetFocus();
			self.editBox:HighlightText();
		end,
		OnHide = function(self)
			ChatEdit_FocusActiveWindow(); 
			self.editBox:SetText("");
		end,
		EditBoxOnEnterPressed = function(self)
			self:GetParent():Hide();
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	};

end