local TITAN_VOLUME_ID = "Volume";
local TITAN_VOLUME_FRAME_SHOW_TIME = 0.5;
local TITAN_VOLUME_ARTWORK_PATH = "Interface\\AddOns\\TitanVolume\\Artwork\\";
local _G = getfenv(0);
local L = LibStub("AceLocale-3.0"):GetLocale("Titan", true)
local LB = LibStub("AceLocale-3.0"):GetLocale("Titan_Volume", true)

function TitanPanelVolumeButton_OnLoad(self)
	self.registry = { 
		id = TITAN_VOLUME_ID,
--		builtIn = 1,
			category = "Built-ins",
		version = TITAN_VERSION,
		menuText = LB["TITAN_VOLUME_MENU_TEXT"], 
		tooltipTitle = LB["TITAN_VOLUME_TOOLTIP"], 
		tooltipTextFunction = "TitanPanelVolumeButton_GetTooltipText",
		iconWidth = 32,
		iconButtonWidth = 18,		
		savedVariables = {
		OverrideBlizzSettings = false,
		VolumeMaster = 1,
		VolumeAmbience = 0.5,
		VolumeSFX = 0.5,
		VolumeMusic = 0.5,
		VolumeOutboundChat = 1,
		VolumeInboundChat = 1,     
          }
	};	
	table.insert(TITAN_PANEL_NONMOVABLE_PLUGINS, TITAN_VOLUME_ID)
	self:RegisterEvent("PLAYER_ENTERING_WORLD");	
end


function TitanPanelVolumeButton_OnEvent(self, event, a1, ...)
	if event == "PLAYER_ENTERING_WORLD" and TitanGetVar(TITAN_VOLUME_ID, "OverrideBlizzSettings") then
		-- Override Blizzard's volume CVar settings
		if TitanGetVar(TITAN_VOLUME_ID, "VolumeMaster") then SetCVar("Sound_MasterVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeMaster")) TitanPanelVolume_SetVolumeIcon() end
		if TitanGetVar(TITAN_VOLUME_ID, "VolumeAmbience") then SetCVar("Sound_AmbienceVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeAmbience")) end
		if TitanGetVar(TITAN_VOLUME_ID, "VolumeSFX") then SetCVar("Sound_SFXVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeSFX")) end
		if TitanGetVar(TITAN_VOLUME_ID, "VolumeMusic") then SetCVar("Sound_MusicVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeMusic")) end
		if TitanGetVar(TITAN_VOLUME_ID, "VolumeOutboundChat") then SetCVar("OutboundChatVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeOutboundChat")) end
		if TitanGetVar(TITAN_VOLUME_ID, "VolumeInboundChat") then SetCVar("InboundChatVolume", TitanGetVar(TITAN_VOLUME_ID, "VolumeInboundChat")) end
	end		
end

function TitanPanelVolumeButton_OnShow()
	TitanPanelVolume_SetVolumeIcon();
end

function TitanPanelVolumeButton_OnEnter()
	-- Confirm master volume value
	TitanPanelMasterVolumeControlSlider:SetValue(1 - GetCVar("Sound_MasterVolume"));
	TitanPanelAmbienceVolumeControlSlider:SetValue(1 - GetCVar("Sound_AmbienceVolume"));
	TitanPanelSoundVolumeControlSlider:SetValue(1 - GetCVar("Sound_SFXVolume"));
	TitanPanelMusicVolumeControlSlider:SetValue(1 - GetCVar("Sound_MusicVolume"));
	TitanPanelMicrophoneVolumeControlSlider:SetValue(1 - GetCVar("OutboundChatVolume"));
	TitanPanelSpeakerVolumeControlSlider:SetValue(1 - GetCVar("InboundChatVolume"));
	TitanPanelVolume_SetVolumeIcon();	
end

-- 'Master' 
function TitanPanelMasterVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(GetCVar("Sound_MasterVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelMasterVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelMasterVolumeControlSlider_OnShow(self)        
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("Sound_MasterVolume")));
	_G[self:GetName().."High"]:SetText(LB["TITAN_VOLUME_CONTROL_LOW"]);
	_G[self:GetName().."Low"]:SetText(LB["TITAN_VOLUME_CONTROL_HIGH"]);
	self:SetMinMaxValues(0, 1);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("Sound_MasterVolume"));
	
	local position = TitanUtils_GetRealPosition(TITAN_VOLUME_ID);
     
     TitanPanelVolumeControlFrame:SetPoint("BOTTOMRIGHT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_VOLUME_ID) .."Button", "TOPRIGHT", 0, 0);
     if (position == TITAN_PANEL_PLACE_TOP) then 
          TitanPanelVolumeControlFrame:ClearAllPoints();
          TitanPanelVolumeControlFrame:SetPoint("TOPLEFT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_VOLUME_ID) .."Button", "BOTTOMLEFT", UIParent:GetRight() - TitanPanelVolumeControlFrame:GetWidth(), -4);
     else
          TitanPanelVolumeControlFrame:ClearAllPoints();
          TitanPanelVolumeControlFrame:SetPoint("BOTTOMLEFT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_VOLUME_ID) .."Button", "TOPLEFT", UIParent:GetRight() - TitanPanelVolumeControlFrame:GetWidth(), 0);
     end   
	
end

function TitanPanelMasterVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		
	SetCVar("Sound_MasterVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeMaster", 1 - self:GetValue())
	
	TitanPanelVolume_SetVolumeIcon();

	-- Update GameTooltip
	if (self.tooltipText) then
		self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

function TitanPanelUnifiedVolumeControlSlider_OnMouseWheel(self, a1)
local tempval = self:GetValue();
if a1 == -1 then
	  self:SetValue(tempval + 0.01);
	end
	
	if a1 == 1 then
	  self:SetValue(tempval - 0.01);
	end
end


-- 'Music'
function TitanPanelMusicVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(GetCVar("Sound_MusicVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelMusicVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelMusicVolumeControlSlider_OnShow(self)        
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("Sound_MusicVolume")));
	_G[self:GetName().."High"]:SetText(LB["TITAN_VOLUME_CONTROL_LOW"]);
	_G[self:GetName().."Low"]:SetText(LB["TITAN_VOLUME_CONTROL_HIGH"]);
	self:SetMinMaxValues(0, 1);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("Sound_MusicVolume"));
end

function TitanPanelMusicVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));

	SetCVar("Sound_MusicVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeMusic", 1 - self:GetValue())
		
	-- Update GameTooltip
	if (self.tooltipText) then
		self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

-- 'Sound'
function TitanPanelSoundVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(GetCVar("Sound_SFXVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelSoundVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelSoundVolumeControlSlider_OnShow(self)        
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("Sound_SFXVolume")));
	_G[self:GetName().."High"]:SetText(LB["TITAN_VOLUME_CONTROL_LOW"]);
	_G[self:GetName().."Low"]:SetText(LB["TITAN_VOLUME_CONTROL_HIGH"]);
	self:SetMinMaxValues(0, 1);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("Sound_SFXVolume"));
end

function TitanPanelSoundVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
	
	SetCVar("Sound_SFXVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeSFX", 1 - self:GetValue())
	
	-- Update GameTooltip
	if (self.tooltipText) then
		self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

-- 'Ambience'
function TitanPanelAmbienceVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(GetCVar("Sound_AmbienceVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelAmbienceVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelAmbienceVolumeControlSlider_OnShow(self)        
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("Sound_AmbienceVolume")));
	_G[self:GetName().."High"]:SetText(LB["TITAN_VOLUME_CONTROL_LOW"]);
	_G[self:GetName().."Low"]:SetText(LB["TITAN_VOLUME_CONTROL_HIGH"]);
	self:SetMinMaxValues(0, 1);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("Sound_AmbienceVolume"));
end

function TitanPanelAmbienceVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
local tempval = self:GetValue();
	
	SetCVar("Sound_AmbienceVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeAmbience", 1 - self:GetValue())
	
	-- Update GameTooltip
	if (self.tooltipText) then
		self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

function TitanPanelVolume_GetVolumeText(volume)
	return tostring(floor(100 * volume + 0.5)) .. "%";
end

-- 'Microphone'
function TitanPanelMicrophoneVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(GetCVar("OutboundChatVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelMicrophoneVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelMicrophoneVolumeControlSlider_OnShow(self)        
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("OutboundChatVolume")));
	_G[self:GetName().."High"]:SetText(LB["TITAN_VOLUME_CONTROL_LOW"]);
	_G[self:GetName().."Low"]:SetText(LB["TITAN_VOLUME_CONTROL_HIGH"]);
	self:SetMinMaxValues(-1.50, 0.75);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("OutboundChatVolume"));
end

function TitanPanelMicrophoneVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
	
	SetCVar("OutboundChatVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeOutboundChat", 1 - self:GetValue())
		
	-- Update GameTooltip
	if (self.tooltipText) then
		self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

-- 'Speaker'
function TitanPanelSpeakerVolumeControlSlider_OnEnter(self)
	self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(GetCVar("InboundChatVolume")));
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(self:GetParent());
end

function TitanPanelSpeakerVolumeControlSlider_OnLeave(self)
	self.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(self:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelSpeakerVolumeControlSlider_OnShow(self)        
	_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(GetCVar("InboundChatVolume")));
	_G[self:GetName().."High"]:SetText(LB["TITAN_VOLUME_CONTROL_LOW"]);
	_G[self:GetName().."Low"]:SetText(LB["TITAN_VOLUME_CONTROL_HIGH"]);
	self:SetMinMaxValues(0, 1);
	self:SetValueStep(0.01);
	self:SetValue(1 - GetCVar("InboundChatVolume"));
end

function TitanPanelSpeakerVolumeControlSlider_OnValueChanged(self, a1)
_G[self:GetName().."Text"]:SetText(TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
	
	SetCVar("InboundChatVolume", 1 - self:GetValue());
	TitanSetVar(TITAN_VOLUME_ID, "VolumeInboundChat", 1 - self:GetValue())
		
	-- Update GameTooltip
	if (self.tooltipText) then
		self.tooltipText = TitanOptionSlider_TooltipText(LB["TITAN_VOLUME_CONTROL_TOOLTIP"], TitanPanelVolume_GetVolumeText(1 - self:GetValue()));
		GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
	end
end

function TitanPanelVolumeControlFrame_OnLoad(self)
	_G[self:GetName().."Title"]:SetText(LB["TITAN_VOLUME_CONTROL_TITLE"]);
	_G[self:GetName().."MasterTitle"]:SetText(LB["TITAN_VOLUME_MASTER_CONTROL_TITLE"]);
	_G[self:GetName().."MusicTitle"]:SetText(LB["TITAN_VOLUME_MUSIC_CONTROL_TITLE"]);
	_G[self:GetName().."SoundTitle"]:SetText(LB["TITAN_VOLUME_SOUND_CONTROL_TITLE"]);
	_G[self:GetName().."AmbienceTitle"]:SetText(LB["TITAN_VOLUME_AMBIENCE_CONTROL_TITLE"]);
	_G[self:GetName().."MicrophoneTitle"]:SetText(LB["TITAN_VOLUME_MICROPHONE_CONTROL_TITLE"]);
	_G[self:GetName().."SpeakerTitle"]:SetText(LB["TITAN_VOLUME_SPEAKER_CONTROL_TITLE"]);
	self:SetBackdropBorderColor(1, 1, 1);
	self:SetBackdropColor(0, 0, 0, 1);
end

function TitanPanelVolumeControlFrame_OnUpdate(self, elapsed)
	TitanUtils_CheckFrameCounting(self, elapsed);
end

function TitanPanelVolume_SetVolumeIcon()
	local icon = _G["TitanPanelVolumeButtonIcon"];
	local masterVolume = tonumber(GetCVar("Sound_MasterVolume"));
	if (masterVolume <= 0) then
		icon:SetTexture(TITAN_VOLUME_ARTWORK_PATH.."TitanVolumeMute");
	elseif (masterVolume < 0.33) then
		icon:SetTexture(TITAN_VOLUME_ARTWORK_PATH.."TitanVolumeLow");
	elseif (masterVolume < 0.66) then
		icon:SetTexture(TITAN_VOLUME_ARTWORK_PATH.."TitanVolumeMedium");
	else
		icon:SetTexture(TITAN_VOLUME_ARTWORK_PATH.."TitanVolumeHigh");
	end	
end

function TitanPanelVolumeButton_GetTooltipText()
	local volumeMasterText = TitanPanelVolume_GetVolumeText(GetCVar("Sound_MasterVolume"));
	local volumeSoundText = TitanPanelVolume_GetVolumeText(GetCVar("Sound_SFXVolume"));
	local volumeMusicText = TitanPanelVolume_GetVolumeText(GetCVar("Sound_MusicVolume"));
	local volumeAmbienceText = TitanPanelVolume_GetVolumeText(GetCVar("Sound_AmbienceVolume"));
	local volumeMicrophoneText = TitanPanelVolume_GetVolumeText(GetCVar("OutboundChatVolume"));
	local volumeSpeakerText = TitanPanelVolume_GetVolumeText(GetCVar("InboundChatVolume"));
	return ""..
		LB["TITAN_VOLUME_MASTER_TOOLTIP_VALUE"].."\t"..TitanUtils_GetHighlightText(volumeMasterText).."\n"..
		LB["TITAN_VOLUME_SOUND_TOOLTIP_VALUE"].."\t"..TitanUtils_GetHighlightText(volumeSoundText).."\n"..
		LB["TITAN_VOLUME_MUSIC_TOOLTIP_VALUE"].."\t"..TitanUtils_GetHighlightText(volumeMusicText).."\n"..
		LB["TITAN_VOLUME_AMBIENCE_TOOLTIP_VALUE"].."\t"..TitanUtils_GetHighlightText(volumeAmbienceText).."\n"..
		LB["TITAN_VOLUME_MICROPHONE_TOOLTIP_VALUE"].."\t"..TitanUtils_GetHighlightText(volumeMicrophoneText).."\n"..
		LB["TITAN_VOLUME_SPEAKER_TOOLTIP_VALUE"].."\t"..TitanUtils_GetHighlightText(volumeSpeakerText).."\n"..
		TitanUtils_GetGreenText(LB["TITAN_VOLUME_TOOLTIP_HINT1"]).."\n"..
		TitanUtils_GetGreenText(LB["TITAN_VOLUME_TOOLTIP_HINT2"]);
end

function TitanPanelRightClickMenu_PrepareVolumeMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_VOLUME_ID].menuText);
	
	local info = {};
  info.text = LB["TITAN_VOLUME_MENU_AUDIO_OPTIONS_LABEL"];
  info.func = function() 
  	if not AudioOptionsFrame:IsVisible() then
  		AudioOptionsFrame:Show()
  	end
  end  
  UIDropDownMenu_AddButton(info);
  
  info.text = LB["TITAN_VOLUME_MENU_OVERRIDE_BLIZZ_SETTINGS"];
  info.func = function() 
  	TitanToggleVar(TITAN_VOLUME_ID, "OverrideBlizzSettings");
  end 
  info.checked = TitanGetVar(TITAN_VOLUME_ID, "OverrideBlizzSettings");
  UIDropDownMenu_AddButton(info);	
  
	TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], TITAN_VOLUME_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end