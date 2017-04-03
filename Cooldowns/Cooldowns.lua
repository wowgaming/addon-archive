
YarkoCooldowns = {}

YarkoCooldowns.DefaultMainColor = NORMAL_FONT_COLOR;
YarkoCooldowns.DefaultFlashColor = { r = 1.0, g = 0, b = 0 };
YarkoCooldowns.DefaultFontLocation = "Fonts";
YarkoCooldowns.DefaultFontFile = "FRIZQT__.TTF";
YarkoCooldowns.DefaultFontHeight = 18;
YarkoCooldowns.DefaultShadow = "Y";
YarkoCooldowns.DefaultOutline = 1;
YarkoCooldowns.DefaultTenths = "N";
YarkoCooldowns.DefaultBelowTwo = "N";
YarkoCooldowns.DefaultSeconds = 60;

YarkoCooldowns.CounterFrames = {};


local Counters = {};

local Scales = {
	[1] = 1.3,
	[2] = 1.2,
	[3] = .8,
	[4] = .6
};

local TimeSinceLastUpdate = 1;
local UpdateInterval = .05;

local ButtonWidth = 28;
local OutlineList = {nil, "OUTLINE", "THICKOUTLINE"};


function YarkoCooldowns.OnLoad(self)
	self:RegisterEvent("PLAYER_LOGIN");
end


function YarkoCooldowns.OnEvent(self, event, ...)
	if (event == "PLAYER_LOGIN") then
        YarkoCooldowns.OptionsSetup();
        
		hooksecurefunc("CooldownFrame_SetTimer", YarkoCooldowns.CooldownSetTimer);
	end
end


function YarkoCooldowns.OnUpdate(self, elapsed)
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed;
	
	if (TimeSinceLastUpdate > UpdateInterval) then
		for k, v in pairs(Counters) do
			local timeleft = v.start + v.duration - GetTime();
			local countertext = _G["YarkoCooldowns_"..k.."CounterText"];
			local counter = _G["YarkoCooldowns_"..k.."Counter"];
			counter.timeleft = timeleft;
			
			if (timeleft > 0 and v.enable > 0) then
				if (_G[k]:IsVisible()) then
					local timeleftstr;
					timeleftstr, counter.length = YarkoCooldowns.GetTimeFormat(timeleft);
					counter.timeleftstr = timeleftstr;
					
					if (timeleft <= 3) then
						if (not v.flash) then
							v.flash = true;
							v.flag = false;
							v.accum = 0;
						end
					else
						if (v.flash) then
							v.flash = false;
						end
					end
					
					if (timeleftstr ~= countertext:GetText() or v.flash) then
						countertext:SetTextColor(YarkoCooldowns_SavedVars.MainColor.r, 
							YarkoCooldowns_SavedVars.MainColor.g, YarkoCooldowns_SavedVars.MainColor.b);
						YarkoCooldowns.DrawCooldown(counter);
						
						if (v.flash) then
							if (v.accum <= 0) then
								if (not v.flag) then
									v.flag = true;
								else
									v.flag = false;
								end
								
								v.accum = 3;
							else
								v.accum = v.accum - 1;
							end
						end
						
						if (v.flag) then
							countertext:SetTextColor(YarkoCooldowns_SavedVars.FlashColor.r, 
								YarkoCooldowns_SavedVars.FlashColor.g, YarkoCooldowns_SavedVars.FlashColor.b);
						end
					end
				else
					countertext:SetText("");
				end
			else
				Counters[k] = nil;
				countertext:SetText("");
			end
		end

		TimeSinceLastUpdate = 0;
	end
end


function YarkoCooldowns.CooldownSetTimer(self, start, duration, enable)
	if (self.mark == 0) then
		return;
	end
	
	local name = self:GetName();
	
	if (not self.mark) then
		if (not name) then
			self.mark = 0;
			return;
		end
		
		self.mark = (((self:GetParent():GetWidth() >= ButtonWidth 
			or self:GetParent():GetParent():GetName() == "WatchFrameLines") 
			and 1) or 0);
		--self.mark = 1;
	end
	
	if (self.mark == 1) then
		local countername = "YarkoCooldowns_"..name.."Counter";
		
		if (start > 0 and duration > 1.5 and enable > 0) then
			if (not _G[countername]) then
				local specialaddon = (ButtonFacade or Bartender4);
				
				local frame = CreateFrame("Frame", countername, 
					((not specialaddon) and self) or nil, "YarkoCooldowns_CounterTemplate");
				frame:SetPoint("CENTER", self:GetParent(), "CENTER", 0, 0);
				
				if (specialaddon) then
					frame:SetFrameStrata(self:GetParent():GetFrameStrata());
				end
				
				frame:SetFrameLevel(self:GetFrameLevel() + 5);
				frame:SetToplevel(true);
				frame.cooldown = self;
				self.yarkocounter = frame;
				
				self:HookScript("OnShow", function(self) self.yarkocounter:Show(); end);
				self:HookScript("OnHide", function(self) self.yarkocounter:Hide(); end);
				
				tinsert(YarkoCooldowns.CounterFrames, countername); 
				YarkoCooldowns.UpdateFont(countername);
				frame:Show();
			end
			
			Counters[name] = {};
			Counters[name].start = start;
			Counters[name].duration = duration;
			Counters[name].enable = enable;
			Counters[name].flash = false;
			Counters[name].flag = false;
			Counters[name].accum = 0;
		else
			if (_G[countername]) then
				_G[countername.."Text"]:SetText("");
			end
			
			Counters[name] = nil;
		end
	end
end


function YarkoCooldowns.GetTimeFormat(timeleft)
	local str1;
	local str2;
	
	if (timeleft > 3600) then
		str1 = ((YarkoCooldowns_SavedVars.Tenths == "Y" 
			and YarkoCooldowns.TrimZeros(format("%.1f", (timeleft + 180) / 3600)))
			or format("%d", ceil(timeleft / 3600)));
		str2 = str1..((strlen(str1) > 2 and "\n") or "").."h";
	elseif (timeleft > YarkoCooldowns_SavedVars.Seconds) then
		str1 = ((YarkoCooldowns_SavedVars.Tenths == "Y" 
			and YarkoCooldowns.TrimZeros(format("%.1f", (timeleft + 3) / 60)))
			or format("%d", ceil(timeleft / 60)));
		str2 = str1..((strlen(str1) > 2 and "\n") or "").."m";
	else
		str1 = ((timeleft <= 2 and YarkoCooldowns_SavedVars.BelowTwo == "Y" 
			and format("%.1f", timeleft + 0.05))
			or format("%d", ceil(timeleft)));
		str2 = str1;
	end
	
	return str2, strlen(str1);
end


function YarkoCooldowns.TrimZeros(instr)
	local outstr = "";
	local str = "";
	local i;
	
	for i = 1, strlen(instr) do
		if (strsub(instr, i, i) ~= "0") then
			str = strsub(instr, i);
			break;
		end
	end
	
	for i = strlen(str), 1, -1 do
		if (strsub(str, i, i) == ".") then
			outstr = strsub(str, 1, i - 1);
			break;
		end
		
		if (strsub(str, i, i) ~= "0") then
			outstr = strsub(str, 1, i);
			break;
		end
	end
	
	return outstr;
end


function YarkoCooldowns.UpdateFont(cooldownframename)
	local cooldownframe = _G[cooldownframename];
	local cooldowntext = _G[cooldownframename.."Text"];
	
	if (YarkoCooldowns_SavedVars.Shadow == "Y") then
		cooldowntext:SetShadowOffset(1, -1);
	else
		cooldowntext:SetShadowOffset(0, 0);
	end
	
	cooldowntext:SetFont(YarkoCooldowns_SavedVars.FontLocation.."\\"..YarkoCooldowns_SavedVars.FontFile, 
		YarkoCooldowns_SavedVars.FontHeight, OutlineList[YarkoCooldowns_SavedVars.Outline]);
	cooldowntext:SetTextColor(YarkoCooldowns_SavedVars.MainColor.r, YarkoCooldowns_SavedVars.MainColor.g,
		YarkoCooldowns_SavedVars.MainColor.b);
	
	if (cooldownframe:IsVisible() and cooldownframe.timeleft) then
		cooldownframe.timeleftstr, cooldownframe.length = YarkoCooldowns.GetTimeFormat(cooldownframe.timeleft);
		YarkoCooldowns.DrawCooldown(cooldownframe);
	end
end


function YarkoCooldowns.DrawCooldown(cooldownframe)
	local str = cooldownframe.timeleftstr;
	local len = cooldownframe.length;
	
	if (len > 4) then
		len = 4;
	end
	
	cooldownframe:SetScale(Scales[len] * (cooldownframe.cooldown:GetParent():GetWidth() 
		/ ActionButton1:GetWidth()));
	_G[cooldownframe:GetName().."Text"]:SetText(cooldownframe.timeleftstr);
end
