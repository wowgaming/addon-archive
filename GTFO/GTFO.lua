--------------------------------------------------------------------------
-- GTFO.lua 
--------------------------------------------------------------------------
--[[
GTFO
Author: Zensunim of Malygos

Usage: /GTFO or go to Interface->Add-ons

Note: Place your own custom spells and setups in GTFO_Custom.lua

Special thanks: Smacker (Power Auras), LibFail's GetMobID function and melee data

Change Log:
	v0.1
		- Beta Release
		- Added menu options
	v0.2
		- Put spells in its own area
	v0.3
		- Updated for Wrath spells
	v0.3.1
		- Updated for Naxx spells
	v0.3.2
		- More spells
	v0.3.3
		- More spells
	v1.0
		- Public Release
		- More spells
		- High/Low options
	v1.0.1
		- Added spells, replaced names with spell IDs
	v1.1
		- Bug fixes
		- Added "test" buttons to the menu option
		- Added spells, replaced names with spell IDs
		- Sound spam prevention
		- Alerts on "afflicted by" event
	v1.1.1
		- Spell fixes, new spells, replaced names with spell IDs
		- Added the ability to alert only on DoT application
		- Fixed "afflicted by" alerts to support stacking debuffs
	v1.1.2
		- Added spells
	v1.1.3
		- Added spells
	v1.1.4
		- Added spells
	v1.2
		- Patch 3.3 Compatible
		- Added version checking and update notification
		- Added spells
	v1.2.1
		- Added spells
	v1.2.2
		- Added spells
		- Casting Hellfire no longer triggers alerts
	v1.2.3
		- Added spells
	v1.2.4
		- Added spells
	v1.2.5
		- Added spells
		- Fixed bug in version updates
	v1.2.6
		- Added spells
	v2.0
		- Added "Fail" mode/sound
		- Added spells
	v2.0.1
		- Added spells
	v2.0.2
		- Added spells
	v2.0.3
		- Added spells
	v2.0.4
		- Added spells
	v2.0.5
		- Added/fixed spells
	v2.1
		- Added Power Auras Integration
	v2.2
		- Added volume control
		- Added "/gtfo options" command
		- Added melee hit/miss detection
	v2.2.1
		- Added spells
	v2.2.2
		- Fixed spells
	v2.2.3
		- Reduced memory footprint
		- Added spells
		- Improved help documentation
	v2.3
		- Added tank vs. non-tank alert support (alerts coming soon!)
		- Added Cataclysm beta spells (requires test mode)
		- Added test mode for untested alerts
		- Fixed a crash with users running a very old version of Power Auras Classic
	v2.4
		- Added Cataclysm compatibility
		- WAV sound effects converted to MP3s for Cataclysm support
		- Added Cataclysm beta spells
		- Removed test mode status of tested Cataclysm beta spells 
	v2.5
		- Added localization support
		- Split spell files into multiple sections
		- Added spells
		- Removed test mode status of tested Cataclysm beta spells 
	v2.5.1
		- Added Cataclysm spells from Blackrock Depths, Vortex Pinnacle, Grim Batol, Twilight Highlands
		- Added Classic spells from Molten Core
		- Added Wrath spells from Icecrown Citadel, Obsidian Sanctum, Ruby Sanctum
	v2.5.2
		- Added Cataclysm spells for Halls of Origination
		- Added Cataclysm spells for Lost City of the Tol'vir
		- Added Cataclysm spells for Blackrock Depths (Heroic)
		- Added Cataclysm spells for Throne of the Tides (Heroic)
		- Added Cataclysm spells for Vortex Pinnacle (Heroic)
		- Added Cataclysm spells for Grim Batol (Heroic)
	v2.5.3
		- Added Cataclysm spells for Halls of Origination
		- Added Cataclysm spells for Grim Batol
		- Added Cataclysm spells for Deadmines (Heroic)
		- Added Cataclysm spells for Shadowfang Keep (Heroic)
		- Added Wrath spells for Halls of Reflection
		- Added Wrath spells for Icecrown Citadel

]]--

GTFO = {
	Version = "2.5.3"; -- Version number (text format)
	VersionNumber = 20503; -- Numeric version number for checking out-of-date clients
	DataCode = "3"; -- Saved Variable versioning, change this value to force a reset to default
	DebugMode = nil; -- Turn on debug alerts
	TestMode = nil; -- Activate alerts for events marked as "test only"
	CanTank = nil; -- The active character is capable of tanking
	TankMode = nil; -- The active character is a tank
	SpellName = { }; -- List of spells (requires localization, spell IDs are preferred)
	SpellID = { }; -- List of spell IDs
	MobID = { }; -- List of mob IDs for melee attack detection
	UpdateFound = nil; -- Upgrade available?
	IgnoreTimeAmount = .2; -- Number of seconds between alert sounds
	IgnoreTime = nil;
	IgnoreUpdateTimeAmount = 5; -- Number of seconds between sending out version updates
	IgnoreUpdateTime = nil;
	IgnoreUpdateRequestTimeAmount = 90; -- Number of seconds between sending out version update requests
	IgnoreUpdateRequestTime = nil;
	Users = { };
	PartyMembers = 0;
	RaidMembers = 0;
	PowerAuras = nil;
	ShowAlert = nil;
	Volume = 3; -- Volume setting, 3 = default
};

GTFOData = {};

function GTFO_ChatPrint(str)
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..str, 0.25, 1.0, 0.25);
end

function GTFO_ErrorPrint(str)
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..str, 1.0, 0.5, 0.5);
end

function GTFO_DebugPrint(str)
	if (GTFO.DebugMode) then
		DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..str, 0.75, 1.0, 0.25);
	end
end

function GTFO_ScanPrint(str)
	if (GTFOData.ScanMode) then
		DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..str, 0.5, 0.5, 0.85);
	end
end

function GTFO_GetMobId(GUID)
    if not GUID then return end
    return tonumber(GUID:sub(-12, -7), 16)
end


function GTFO_OnEvent(self, event, ...)
	if (event == "VARIABLES_LOADED") then
		if (GTFOData.DataCode ~= GTFO.DataCode) then
			GTFOData.Active = true;
			GTFOData.Sounds = { };
			GTFOData.Sounds[1] = true;
			GTFOData.Sounds[2] = true;
			GTFOData.Sounds[3] = true;
			GTFOData.DataCode = GTFO.DataCode;
			GTFOData.Volume = GTFO.Volume;
			GTFOData.ScanMode = nil;
			GTFO_ChatPrint(string.format(GTFOLocal.Loading_NewDatabase, GTFO.Version));
		end
		GTFO_RenderOptions();
		GTFO_Option_Active(GTFOData.Active);
		GTFO_Option_ScanMode(GTFOData.ScanMode);
		GTFO_Option_HighSound(GTFOData.Sounds[1]);
		GTFO_Option_LowSound(GTFOData.Sounds[2]);
		GTFO_Option_FailSound(GTFOData.Sounds[3]);
		if (GTFOData.Volume) then
			GTFO.Volume = GTFOData.Volume;
		end
		if (IsAddOnLoaded("PowerAuras")) then
			if (PowaAuras and PowaAuras.AurasByType) then
				if (PowaAuras.AurasByType.GTFOHigh) then
					GTFO.PowerAuras = true;
				else
					GTFO_ChatPrint(GTFOLocal.Loading_PowerAurasOutOfDate);
				end
			else
				GTFO_ChatPrint(GTFOLocal.Loading_PowerAurasOutOfDate);
			end
		end
		if (GTFOData.Active and GTFO.PowerAuras) then
			GTFO_ChatPrint(string.format(GTFOLocal.Loading_LoadedWithPowerAuras, GTFO.Version));
		elseif (GTFOData.Active) then
			GTFO_ChatPrint(string.format(GTFOLocal.Loading_Loaded, GTFO.Version));
		else
			GTFO_ChatPrint(string.format(GTFOLocal.Loading_LoadedSuspended, GTFO.Version));
		end
		GTFO.Users[UnitName("player")] = GTFO.VersionNumber;
		GTFO_CanTankCheck();
		GTFO.TankMode = GTFO_CheckTankMode()
		GTFO_SendUpdateRequest();
		return;
	end
	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, misc1, misc2, misc3, misc4, misc5, misc6, misc7 = ...; 

		local SpellType = tostring(eventType);
		if (destGUID == UnitGUID("player")) then
			if (SpellType == "ENVIRONMENTAL_DAMAGE") then
				GTFO_ScanPrint(SpellType.." - "..misc1);
				if (misc1 ~= "FALLING") then
					GTFO_PlaySound(2);
					return;
				end
			elseif (SpellType=="SPELL_PERIODIC_DAMAGE" or SpellType=="SPELL_DAMAGE" or ((SpellType=="SPELL_AURA_APPLIED" or SpellType=="SPELL_AURA_APPLIED_DOSE") and misc4=="DEBUFF")) then
				local SpellID = tostring(misc1);
				local SpellName = tostring(misc2);
				local SpellSourceGUID = tostring(sourceGUID);
				GTFO_ScanPrint(SpellType.." - "..SpellID.." - "..SpellName.." - "..tostring(sourceName)..">"..tostring(destName));
				if (GTFO.SpellID[SpellID]) then
					GTFO_DebugPrint(SpellID.." - ID Match Found");
					if (GTFO.SpellID[SpellID].test and not GTFO.TestMode) then
						return;
					end
					if (SpellSourceGUID ~= UnitGUID("player") or not GTFO.SpellID[SpellID].ignoreSelfInflicted) then
						if ((not GTFO.SpellID[SpellID].applicationOnly) or (GTFO.SpellID[SpellID].applicationOnly and (SpellType == "SPELL_AURA_APPLIED" or SpellType == "SPELL_AURA_APPLIED_DOSE"))) then
							if (GTFO.SpellID[SpellID].tankSound and GTFO.TankMode) then
								GTFO_PlaySound(GTFO.SpellID[SpellID].tankSound);
							else
								GTFO_PlaySound(GTFO.SpellID[SpellID].sound);
							end
							--GTFO_DebugPrint(GTFO.SpellID[SpellID].desc);
							return;
						end
					end
				elseif (GTFO.SpellName[SpellName]) then
					if (GTFO.SpellName[SpellName].test and not GTFO.TestMode) then
						return;
					end
					if (SpellSourceGUID ~= UnitGUID("player") or not GTFO.SpellName[SpellName].ignoreSelfInflicted) then
						GTFO_DebugPrint(SpellName.." - Name Match Found");
						if ((not GTFO.SpellName[SpellName].applicationOnly) or (GTFO.SpellName[SpellName].applicationOnly and (SpellType == "SPELL_AURA_APPLIED" or SpellType == "SPELL_AURA_APPLIED_DOSE"))) then
							if (GTFO.SpellName[SpellName].tankSound and GTFO.TankMode) then
								GTFO_PlaySound(GTFO.SpellName[SpellName].tankSound);
							else
								GTFO_PlaySound(GTFO.SpellName[SpellName].sound);
							end
							--GTFO_DebugPrint(GTFO.SpellName[SpellName].desc);				
							return;
						end
					end
				end
			elseif (SpellType=="SWING_DAMAGE" or SpellType=="SWING_MISSED") then
				local SourceMobID = tostring(GTFO_GetMobId(sourceGUID));
				if (GTFO.MobID[SourceMobID]) then
					if (GTFO.MobID[SourceMobID].test and not GTFO.TestMode) then
						return;
					end
					if (SpellType=="SWING_DAMAGE") then
						local damage = misc1 ~= "ABSORB" and misc1 or 0
						if (damage > 0 or not GTFO.MobID[SourceMobID].damageOnly) then
							if (GTFO.MobID[SourceMobID].tankSound and GTFO.TankMode) then
								GTFO_PlaySound(GTFO.MobID[SourceMobID].tankSound);
							else
								GTFO_PlaySound(GTFO.MobID[SourceMobID].sound);
							end
							--GTFO_DebugPrint(GTFO.MobID[SourceMobID].desc);				
							return;						
						end
					elseif (not GTFO.MobID[SourceMobID].damageOnly and SpellType=="SWING_MISSED") then
						GTFO_PlaySound(GTFO.MobID[SourceMobID].sound);
						--GTFO_DebugPrint(GTFO.MobID[SourceMobID].desc);				
						return;						
					end
				end
				
			end
		end
		return;
	end
	if (event == "CHAT_MSG_ADDON") then
		local msgPrefix, msgMessage, msgType, msgSender = ...;
		if (msgPrefix == "GTFO_v") then
			if (not GTFO.Users[msgSender]) then
				GTFO_SendUpdate(msgType);
			end
			GTFO.Users[msgSender] = msgMessage;
			if ((tonumber(msgMessage) > GTFO.VersionNumber) and not GTFO.UpdateFound) then
				GTFO.UpdateFound = GTFO_ParseVersionNumber(msgMessage);
				GTFO_ChatPrint(string.format(GTFOLocal.Loading_OutOfDate, GTFO.UpdateFound));
			end
			return;
		end
		if (msgPrefix == "GTFO_u") then
			GTFO_DebugPrint(msgSender.." requested update to "..msgType);
			GTFO_SendUpdate(msgType);
			return;
		end
		return;
	end
	if (event == "PARTY_MEMBERS_CHANGED") then
		local PartyMembers = GetNumPartyMembers();
		if (PartyMembers > GTFO.PartyMembers and GTFO.RaidMembers == 0) then
			GTFO_SendUpdate("PARTY");
		end
		GTFO.PartyMembers = PartyMembers;
		return;
	end
	if (event == "RAID_ROSTER_UPDATE") then
		local RaidMembers = GetNumRaidMembers();		
		if (RaidMembers > GTFO.RaidMembers) then
			GTFO_SendUpdate("RAID");
		end
		GTFO.RaidMembers = RaidMembers;		
		return;
	end
	if (event == "UNIT_INVENTORY_CHANGED") then
		local msgUnit = ...;
		if (UnitIsUnit(msgUnit, "PLAYER")) then
			GTFO.TankMode = GTFO_CheckTankMode();
		end
	end
	if (event == "UPDATE_SHAPESHIFT_FORM") then
		GTFO.TankMode = GTFO_CheckTankMode();
	end
end

function GTFO_Command(arg1)
	local Command = string.upper(arg1);
	local DescriptionOffset = string.find(arg1,"%s",1);
	local Description = nil;
	
	if (DescriptionOffset) then
		Command = string.upper(string.sub(arg1, 1, DescriptionOffset - 1));
		Description = tostring(string.sub(arg1, DescriptionOffset + 1));
	end
	
	GTFO_DebugPrint("Command executed: "..Command);
	
	if (Command == "OPTION" or Command == "OPTIONS") then
		GTFO_Command_Options();
	elseif (Command == "STANDBY") then
		GTFO_Command_Standby();
	elseif (Command == "DEBUG") then
		GTFO_Command_Debug();
	elseif (Command == "SCAN" or Command == "SCANNER") then
		GTFO_Command_Scan();
	elseif (Command == "TESTMODE") then
		GTFO_Command_TestMode();
	elseif (Command == "VERSION") then
		GTFO_Command_Version();
	elseif (Command == "TEST") then
		GTFO_PlaySound(1);
		if (GTFOData.Sounds[1]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_High);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_HighMuted);		
		end
	elseif (Command == "TEST2") then
		GTFO_PlaySound(2);
		if (GTFOData.Sounds[2]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_Low);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_LowMuted);		
		end
	elseif (Command == "TEST3") then
		GTFO_PlaySound(3);
		if (GTFOData.Sounds[3]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_Fail);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_FailMuted);		
		end
	elseif (Command == "HELP" or Command == "") then
		GTFO_Command_Help();
	else
		GTFO_Command_Help();
	end
end

function GTFO_Command_Debug()
	if (GTFO.DebugMode) then
		GTFO.DebugMode = nil;
		GTFO_ChatPrint("Debug mode off.");
	else
		GTFO.DebugMode = true;
		GTFO_ChatPrint("Debug mode on.");
	end
end

function GTFO_Command_Scan()
	if (GTFOData.ScanMode) then
		GTFO_Option_ScanMode(nil);
		GTFO_ChatPrint("Scan mode off.");
	else
		GTFO_Option_ScanMode(true);
		GTFO_ChatPrint("Scan mode on.");
	end
end

function GTFO_Command_TestMode()
	if (GTFO.TestMode) then
		GTFO.TestMode = nil;
		GTFO_ChatPrint("Test mode off.");
	else
		GTFO.TestMode = true;
		GTFO_ChatPrint("Test mode on.");
	end
end

function GTFO_Command_Standby()
	if (GTFOData.Active) then
		GTFO_Option_Active(nil);
		GTFO_ChatPrint(GTFOLocal.Active_Off);
	else
		GTFO_Option_Active(true);
		GTFO_ChatPrint(GTFOLocal.Active_On);
	end
	GTFO_ActivateMod();
end

function GTFO_OnLoad()
	GTFOFrame:RegisterEvent("VARIABLES_LOADED");
	GTFOFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");
	GTFOFrame:RegisterEvent("RAID_ROSTER_UPDATE");
	GTFOFrame:RegisterEvent("CHAT_MSG_ADDON");
	SlashCmdList["GTFO"] = GTFO_Command;
	SLASH_GTFO1 = "/GTFO";
end

function GTFO_PlaySound(iSound)
	if (iSound == 0) then
		return;
	end
	
	local currentTime = GetTime();
	local soundTable = { };
	if (GTFO.IgnoreTime) then
		if (currentTime < GTFO.IgnoreTime) then
			return;
		end
	end
	GTFO.IgnoreTime = currentTime + GTFO.IgnoreTimeAmount;

	local version, build, date, tocversion = GetBuildInfo();

	if (GTFO.Volume == 2) then
		if (tocversion == 40000) then
			soundTable = {
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer_soft.mp3",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep_soft.mp3",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble_soft.mp3",
			};
		else
			soundTable = {
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer_soft.wav",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep_soft.wav",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble_soft.wav",
			};
		end
	elseif (GTFO.Volume == 1) then
		if (tocversion == 40000) then
			soundTable = {
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer_quiet.mp3",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep_quiet.mp3",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble_quiet.mp3",
			};
		else
			soundTable = {
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer_quiet.wav",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep_quiet.wav",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble_quiet.wav",
			};
		end
	elseif (GTFO.Volume == 4) then
		if (tocversion == 40000) then
			soundTable = {
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer_loud.mp3",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep_loud.mp3",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble_loud.mp3",
			};
		else
			soundTable = {
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer_loud.wav",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep_loud.wav",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble_loud.wav",
			};
		end
	else	
		if (tocversion == 40000) then
			soundTable = {
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer.mp3",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep.mp3",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble.mp3",
			};
		else
			soundTable = {
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer.wav",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep.wav",
				"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble.wav",
			};
		end
	end
	if (GTFOData.Sounds[iSound]) then
		PlaySoundFile(soundTable[iSound]);
	end
	if (GTFO.PowerAuras) then
		GTFO_DisplayAura(iSound);
	end
end

function GTFO_RenderOptions()
	local ConfigurationPanel = CreateFrame("FRAME","GTFO_MainFrame");
	ConfigurationPanel.name = "GTFO";
	InterfaceOptions_AddCategory(ConfigurationPanel);

	local VolumeText = ConfigurationPanel:CreateFontString("GTFO_VolumeText","ARTWORK","GameFontNormal");
	VolumeText:SetPoint("TOPLEFT", 170, -145);
	VolumeText:SetText("");

	local EnabledButton = CreateFrame("CheckButton", "GTFO_EnabledButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	EnabledButton:SetPoint("TOPLEFT", 10, -15)
	EnabledButton.tooltip = GTFOLocal.UI_EnabledDescription;
	getglobal(EnabledButton:GetName().."Text"):SetText(GTFOLocal.UI_Enabled);

	local HighSoundButton = CreateFrame("CheckButton", "GTFO_HighSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	HighSoundButton:SetPoint("TOPLEFT", 10, -45)
	HighSoundButton.tooltip = GTFOLocal.UI_HighDamageDescription;
	getglobal(HighSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_HighDamage);

	local LowSoundButton = CreateFrame("CheckButton", "GTFO_LowSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	LowSoundButton:SetPoint("TOPLEFT", 10, -75)
	LowSoundButton.tooltip = GTFOLocal.UI_LowDamageDescription;
	getglobal(LowSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_LowDamage);

	local FailSoundButton = CreateFrame("CheckButton", "GTFO_FailSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	FailSoundButton:SetPoint("TOPLEFT", 10, -105)
	FailSoundButton.tooltip = GTFOLocal.UI_FailDescription;
	getglobal(FailSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_Fail);

	local HighTestButton = CreateFrame("Button", "GTFO_HighTestButton", ConfigurationPanel, "OptionsButtonTemplate");
	HighTestButton:SetPoint("TOPLEFT", 300, -45);
	HighTestButton.tooltip = GTFOLocal.UI_TestDescription;
	HighTestButton:SetScript("OnClick",GTFO_Option_HighTest);
	getglobal(HighTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

	local LowTestButton = CreateFrame("Button", "GTFO_LowTestButton", ConfigurationPanel, "OptionsButtonTemplate");
	LowTestButton:SetPoint("TOPLEFT", 300, -75);
	LowTestButton.tooltip = GTFOLocal.UI_TestDescription;
	LowTestButton:SetScript("OnClick",GTFO_Option_LowTest);
	getglobal(LowTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

	local FailTestButton = CreateFrame("Button", "GTFO_FailTestButton", ConfigurationPanel, "OptionsButtonTemplate");
	FailTestButton:SetPoint("TOPLEFT", 300, -105);
	FailTestButton.tooltip = GTFOLocal.UI_TestDescription;
	FailTestButton:SetScript("OnClick",GTFO_Option_FailTest);
	getglobal(FailTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

	local VolumeSlider = CreateFrame("Slider", "GTFO_VolumeSlider", ConfigurationPanel, "OptionsSliderTemplate");
	VolumeSlider:SetPoint("TOPLEFT", 12, -145);
	VolumeSlider.tooltip = GTFOLocal.UI_VolumeDescription;
	VolumeSlider:SetScript("OnValueChanged",GTFO_Option_SetVolume);
	getglobal(GTFO_VolumeSlider:GetName().."Text"):SetText(GTFOLocal.UI_Volume);
	getglobal(GTFO_VolumeSlider:GetName().."High"):SetText(GTFOLocal.UI_VolumeMax);
	getglobal(GTFO_VolumeSlider:GetName().."Low"):SetText(GTFOLocal.UI_VolumeMin);
	VolumeSlider:SetMinMaxValues(1,4);
	VolumeSlider:SetValueStep(1);
	VolumeSlider:SetValue(GTFOData.Volume);
	
	GTFO_Option_SetVolumeText(GTFOData.Volume);

	ConfigurationPanel.okay = 
		function (self)
			GTFO_Option_Active(EnabledButton:GetChecked());
			GTFO_Option_HighSound(HighSoundButton:GetChecked());
			GTFO_Option_LowSound(LowSoundButton:GetChecked());
			GTFO_Option_FailSound(HighSoundButton:GetChecked());
			GTFOData.Volume = GTFO.Volume;
			VolumeSlider:SetValue(GTFO.Volume);
			GTFO_Option_SetVolumeText(GTFO.Volume);
		end
	ConfigurationPanel.cancel = 
		function (self)
			EnabledButton:SetChecked(GTFOData.Active);
			HighSoundButton:SetChecked(GTFOData.Sounds[1]);
			LowSoundButton:SetChecked(GTFOData.Sounds[2]);
			FailSoundButton:SetChecked(GTFOData.Sounds[3]);
			GTFO.Volume = GTFOData.Volume;
			VolumeSlider:SetValue(GTFO.Volume);
			GTFO_Option_SetVolumeText(GTFO.Volume);
		end
	ConfigurationPanel.default = 
		function (self)
			GTFO_Option_Active(true);
			GTFO_Option_HighSound(true);
			GTFO_Option_LowSound(true);
			GTFO_Option_FailSound(true);
			GTFO.Volume = 3;
			VolumeSlider:SetValue(GTFO.Volume);
			GTFO_Option_SetVolumeText(GTFO.Volume);
		end
end

function GTFO_ActivateMod()
	if (GTFOData.Active) then
		GTFOFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	else
		GTFOFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	end	
end

function GTFO_Option_Active(state)
	GTFOData.Active = state;
	getglobal("GTFO_EnabledButton"):SetChecked(state);
	GTFO_ActivateMod();
end

function GTFO_Option_ScanMode(state)
	GTFOData.ScanMode = state;
end

function GTFO_Command_Help()
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..string.format(GTFOLocal.Help_Intro, GTFO.Version), 0.25, 1.0, 0.25);
	if not (GTFOData.Active) then
		DEFAULT_CHAT_FRAME:AddMessage(GTFOLocal.Help_Suspended, 1.0, 0.1, 0.1);		
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo options|r -- "..GTFOLocal.Help_Options, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo standby|r -- "..GTFOLocal.Help_Suspend, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo version|r -- "..GTFOLocal.Help_Version, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test|r -- "..GTFOLocal.Help_TestHigh, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test2|r -- "..GTFOLocal.Help_TestLow, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test3|r -- "..GTFOLocal.Help_TestFail, 0.25, 1.0, 0.75);
end

function GTFO_Option_HighSound(state)
	GTFOData.Sounds[1] = state;
	getglobal("GTFO_HighSoundButton"):SetChecked(state);
end

function GTFO_Option_LowSound(state)
	GTFOData.Sounds[2] = state;
	getglobal("GTFO_LowSoundButton"):SetChecked(state);
end

function GTFO_Option_FailSound(state)
	GTFOData.Sounds[3] = state;
	getglobal("GTFO_FailSoundButton"):SetChecked(state);
end

function GTFO_Option_HighTest()
	GTFO_PlaySound(1);
end

function GTFO_Option_LowTest()
	GTFO_PlaySound(2);
end

function GTFO_Option_FailTest()
	GTFO_PlaySound(3);
end

function GTFO_Command_Version()
	GTFO_SendUpdateRequest();
	local raidmembers = GetNumRaidMembers();
	local partymembers = GetNumPartyMembers();
	local users = 0;

	if (raidmembers > 0 or partymembers > 0) then
		if (raidmembers > 0) then
			for i = 1, raidmembers, 1 do
				local name = UnitName("raid"..i);
				if (GTFO.Users[name]) then
					GTFO_ChatPrint(name..": "..GTFO_ParseVersionColor(GTFO.Users[name]));
					users = users + 1;
				else
					GTFO_ChatPrint(name..": |cFF999999"..GTFOLocal.Group_None.."|r");
				end
			end
			GTFO_ChatPrint(string.format(GTFOLocal.Group_RaidMembers, users, raidmembers));
		elseif (partymembers > 0) then
			GTFO_ChatPrint(UnitName("player")..": "..GTFO_ParseVersionColor(GTFO.VersionNumber));
			users = 1;
			for i = 1, partymembers, 1 do
				local name = UnitName("party"..i);
				if (GTFO.Users[name]) then
					GTFO_ChatPrint(name..": "..GTFO_ParseVersionColor(GTFO.Users[name]));
					users = users + 1;
				else
					GTFO_ChatPrint(name..": |cFF999999"..GTFOLocal.Group_None.."|r");
				end
			end
			GTFO_ChatPrint(string.format(GTFOLocal.Group_PartyMembers, users, (partymembers + 1)));
		end
	else
		GTFO_ErrorPrint(GTFOLocal.Group_NotInGroup);
	end		
end

function GTFO_ParseVersionColor(iVersionNumber)
	local Color = "";
	if (GTFO.VersionNumber < iVersionNumber * 1) then
		Color = "|cFFFFFF00"
	elseif (GTFO.VersionNumber == iVersionNumber * 1) then
		Color = "|cFFFFFFFF"
	else
		Color = "|cFFAAAAAA"
	end
	return Color..GTFO_ParseVersionNumber(iVersionNumber).."|r"
end

function GTFO_ParseVersionNumber(iVersionNumber)
	local sVersion = "";
	local iMajor = math.floor(iVersionNumber * 0.0001);
	local iMinor = math.floor((iVersionNumber - (iMajor * 10000)) * 0.01)
	local iMinor2 = iVersionNumber - (iMajor * 10000) - (iMinor * 100)
	if (iMinor2 > 0) then
		sVersion = iMajor.."."..iMinor.."."..iMinor2
	else
		sVersion = iMajor.."."..iMinor
	end
	return sVersion;
end

function GTFO_SendUpdate(sMethod)
	if not (sMethod == "PARTY" or sMethod == "RAID" or sMethod == "BATTLEGROUND") then
		return;
	end
	local currentTime = GetTime();
	if (GTFO.IgnoreUpdateTime) then
		if (currentTime < GTFO.IgnoreUpdateTime) then
			return;
		end
	end
	GTFO.IgnoreUpdateTime = currentTime + GTFO.IgnoreUpdateTimeAmount;

	SendAddonMessage("GTFO_v",GTFO.VersionNumber,sMethod)
end

function GTFO_SendUpdateRequest()
	local currentTime = GetTime();
	if (GTFO.IgnoreUpdateRequestTime) then
		if (currentTime < GTFO.IgnoreUpdateRequestTime) then
			return;
		end
	end
	GTFO.IgnoreUpdateRequestTime = currentTime + GTFO.IgnoreUpdateRequestTimeAmount;

	local raidmembers = GetNumRaidMembers();
	local partymembers = GetNumPartyMembers();
	
	if (UnitInBattleground("player")) then
		SendAddonMessage("GTFO_u","U","BATTLEGROUND");
	elseif (raidmembers > 0) then
		SendAddonMessage("GTFO_u","U","RAID");
	elseif (partymembers > 0) then
		SendAddonMessage("GTFO_u","U","PARTY");
	end
end

function GTFO_Command_Options()
	InterfaceOptionsFrame_OpenToCategory("GTFO")
end

function GTFO_Option_SetVolume()
	GTFO.Volume = getglobal("GTFO_VolumeSlider"):GetValue() * 1;
	GTFO_Option_SetVolumeText(GTFO.Volume)
end

function GTFO_Option_SetVolumeText(iVolume)
	if (iVolume == 1) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeQuiet);
	elseif (iVolume == 2) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeSoft);
	elseif (iVolume == 4) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeLoud);
	else
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeNormal);
	end
end

function GTFO_CheckTankMode()
	if (GTFO.CanTank) then
		local x, class = UnitClass("player");
		if (class == "PALADIN") then
			if (GetInventoryItemID("PLAYER",17)) then
				GTFO_DebugPrint("Shield found - tank mode activated");
				return true;
			end
		else
			local stance = GetShapeshiftForm();
			if (class == "DRUID") then
				if (stance == 1) then
					GTFO_DebugPrint("Bear Form found - tank mode activated");
					return true;
				end
			elseif (class == "DEATHKNIGHT") then
				if (stance == 2) then
					GTFO_DebugPrint("Frost Presense found - tank mode activated");
					return true;
				end
			elseif (class == "WARRIOR") then
				if (stance == 2) then
					GTFO_DebugPrint("Defensive stance found - tank mode activated");
					return true;
				end
			else
				GTFO_DebugPrint("Failed Tank Mode - This code shouldn't have ran");
				GTFO.CanTank = nil;
			end
		end
	end
	GTFO_DebugPrint("Tank mode off");
	return nil;
end

function GTFO_CanTankCheck()
	local x, class = UnitClass("player");
	if (class == "PALADIN" or class == "DRUID" or class == "DEATHKNIGHT" or class == "WARRIOR") then
		GTFO_DebugPrint("Possible tank detected");
		GTFO.CanTank = true;
		if (class == "PALADIN") then
			GTFOFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
		else
			GTFOFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
		end
	else
		GTFO_DebugPrint("This class isn't a tank");
		GTFO.CanTank = nil;
	end
end