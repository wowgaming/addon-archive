-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------


function TRP2_OpenSoundFavList()
	TRP2_ListeSoundFav:Show();
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(string.lower(TRP2_ListeSoundFavRecherche:GetText()));
	local PlaylistNum = TRP2_Module_Interface["SoundPlaylist"]["ActualPlaylist"];
	local Playlist = TRP2_Module_Interface["SoundPlaylist"]["Playlist"][PlaylistNum];
	TRP2_ListeSoundFavSlider:Hide();
	TRP2_ListeSoundFavSlider:SetValue(0);
	wipe(TRP2_SoundFavListTab);
	
	TRP2_ListeSoundFavURLBox:Hide();
	
	table.foreach(Playlist,function(soundNum)
		i = i+1;
		if not search or string.find(Playlist[soundNum],search) then
			j = j + 1;
			TRP2_SoundFavListTab[j] = soundNum;
		end
	end);
	
	table.sort(TRP2_SoundFavListTab);
	
	if j > 0 then
		TRP2_ListeSoundFavEmpty:SetText("");
	elseif i == 0 then
		TRP2_ListeSoundFavEmpty:SetText(TRP2_LOC_PasDeSons);
	else
		TRP2_ListeSoundFavEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_ListeSoundFavSlider:Show();
		local total = floor((j-1)/49);
		TRP2_ListeSoundFavSlider:SetMinMaxValues(0,total);
	end
	TRP2_ListeSoundFavSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_LoadSoundFavListePage(self:GetValue());
		end
	end)
	TRP2_ListeSoundFavRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_OpenSoundFavList();
		end
	end)
	TRP2_ListeSoundFavTitre:SetText(TRP2_FT(TRP2_LOC_PlaylistNum,PlaylistNum).." ( "..j.." / "..i.." )");
	
	TRP2_LoadSoundFavListePage(0);
end

function TRP2_LoadSoundFavListePage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_ListeSoundFavSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	local PlaylistNum = TRP2_Module_Interface["SoundPlaylist"]["ActualPlaylist"];
	local Playlist = TRP2_Module_Interface["SoundPlaylist"]["Playlist"][PlaylistNum];
	table.foreach(TRP2_SoundFavListTab,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local TabElement = TRP2_SoundFavListTab[TabIndex];
			getglobal("TRP2_ListeSoundFavSlot"..j):Show();
			getglobal("TRP2_ListeSoundFavSlot"..j):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					if IsShiftKeyDown() then
						TRP2_ListeSoundFavURLBox:Show();
						TRP2_ListeSoundFavURLBox:SetText(Playlist[TabElement]);
						return;
					end
					if IsControlKeyDown() then
						TRP2_PlaySoundScript(Playlist[TabElement],3);
					else
						TRP2_PlayLocalSound(Playlist[TabElement],TRP2_ListeSoundFavSliderDistance:GetValue());
					end
				else
					if IsShiftKeyDown() then
						TRP2_Module_Interface["SoundPlaylist"]["Playlist"][PlaylistNum][TabElement]=nil;
						TRP2_OpenSoundFavList();
					else
						TRP2_PlaySound(Playlist[TabElement]);
					end
				end
			end);
			local rep,icone = TRP2_GetLastRep(Playlist[TabElement]);
			getglobal("TRP2_ListeSoundFavSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..icone);
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_ListeSoundFavSlot"..j),
				TRP2_ListeSoundFav,"TOPLEFT",0,0,
				"|TInterface\\ICONS\\"..icone..":30:30|t {w}"..ENABLE_SOUNDFX,
				rep.."\n\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_Sound_PlayLocal
				.."\n{j}"..TRP2_LOC_CLICCTRL.." {w}: "..TRP2_LOC_Sound_PlayGlobal
				.."\n{j}"..TRP2_LOC_CLICDROITMAJ.." {w}: "..TRP2_LOC_Sound_Remove
				.."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_Sound_PreListen
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_GetLastRep(text)
	local i=1;
	local rev = string.reverse(tostring(string.match(string.reverse(text),"\\(.-)\\")));
	
	text = string.gsub(text,"\\","\n   ");
	retour = "{c}   "..text;
	if TRP2_EmptyToNil(TRP2_SOUNDSICONES[rev]) then
		return retour,TRP2_SOUNDSICONES[rev];
	else
		return retour,"INV_Misc_Ear_Human_01";
	end
	
end

function TRP2_OpenSoundList()
	TRP2_ListeSound:Show();
	local i = 0; -- Nombre total
	local j = 0; -- Nombre pris
	local search = TRP2_EmptyToNil(string.lower(TRP2_ListeSoundRecherche:GetText()));
	local PlaylistNum = TRP2_Module_Interface["SoundPlaylist"]["ActualPlaylist"];
	local Playlist = TRP2_Module_Interface["SoundPlaylist"]["Playlist"][PlaylistNum];
	TRP2_ListeSoundSlider:Hide();
	TRP2_ListeSoundSlider:SetValue(0);
	wipe(TRP2_SoundListTab);
	TRP2_ListeSoundURLBox:Hide();
	
	table.foreach(TRP2_LISTE_SOUNDS,function(soundNum)
		i = i+1;
		if not search or string.find(string.lower(TRP2_LISTE_SOUNDS[soundNum]),search) or string.find(tostring(soundNum),search) then
			j = j + 1;
			TRP2_SoundListTab[j] = soundNum;
		end
	end);
	
	if j > 0 then
		TRP2_ListeSoundEmpty:SetText("");
	elseif i == 0 then
		TRP2_ListeSoundEmpty:SetText(TRP2_LOC_PasDeSons);
	else
		TRP2_ListeSoundEmpty:SetText(TRP2_LOC_SelectVide);
	end
	if j > 49 then
		TRP2_ListeSoundSlider:Show();
		local total = floor((j-1)/49);
		TRP2_ListeSoundSlider:SetMinMaxValues(0,total);
	end
	TRP2_ListeSoundSlider:SetScript("OnValueChanged",function(self)
		if self:IsVisible() then
			TRP2_LoadSoundListePage(self:GetValue());
		end
	end)
	TRP2_ListeSoundRecherche:SetScript("OnTextChanged",function(self)
		if self:IsVisible() then
			TRP2_OpenSoundList();
		end
	end)
	TRP2_ListeSoundTitre:SetText(TRP2_LOC_UI_ListeSon.." ( "..j.." / "..i.." )");
	
	TRP2_LoadSoundListePage(0);
end

function TRP2_DD_MenuSounds(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_PlaylistSelect;
	info.func = function() end;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	local i;
	for i=1,5,1 do
		info = TRP2_CreateSimpleDDButton();
		local count = TRP2_GetIndexedTabSize(TRP2_Module_Interface["SoundPlaylist"]["Playlist"][i]);
		if TRP2_Module_Interface["SoundPlaylist"]["ActualPlaylist"] == i then
			info.text = TRP2_FT(TRP2_LOC_PlaylistNum,i).." : "..count.." "..TRP2_LOC_UI_SOUNDS;
			info.disabled = true;
		else
			info.text = TRP2_FT(TRP2_LOC_PlaylistNum,i).." : "..count.." "..TRP2_LOC_UI_SOUNDS;
		end
		info.func = function() 
			TRP2_Module_Interface["SoundPlaylist"]["ActualPlaylist"] = i;
			TRP2_OpenSoundFavList();
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

function TRP2_LoadSoundListePage(num)
	for k=1,49,1 do --Initialisation
		getglobal("TRP2_ListeSoundSlot"..k):Hide();
	end
	local i = 1;
	local j = 1;
	local PlaylistNum = TRP2_Module_Interface["SoundPlaylist"]["ActualPlaylist"];
	table.foreach(TRP2_SoundListTab,
	function(TabIndex)
		if i > num*49 and i <= (num+1)*49 then
			local TabElement = TRP2_SoundListTab[TabIndex];
			getglobal("TRP2_ListeSoundSlot"..j):Show();
			getglobal("TRP2_ListeSoundSlot"..j):SetScript("OnClick", function(self,button)
				if button == "LeftButton" then
					if IsShiftKeyDown() then
						TRP2_ListeSoundURLBox:Show();
						TRP2_ListeSoundURLBox:SetText(TRP2_LISTE_SOUNDS[TabElement]);
						return;
					end
					TRP2_Module_Interface["SoundPlaylist"]["Playlist"][PlaylistNum][#TRP2_Module_Interface["SoundPlaylist"]["Playlist"][PlaylistNum]+1] = TRP2_LISTE_SOUNDS[TabElement];
					TRP2_OpenSoundFavList();
				else
					TRP2_PlaySound(TRP2_LISTE_SOUNDS[TabElement]);
				end
			end);
			local rep,icone = TRP2_GetLastRep(TRP2_LISTE_SOUNDS[TabElement]);
			getglobal("TRP2_ListeSoundSlot"..j.."Icon"):SetTexture("Interface\\ICONS\\"..icone);
			TRP2_SetTooltipForFrame(
				getglobal("TRP2_ListeSoundSlot"..j),
				TRP2_ListeSound,"TOPLEFT",0,0,
				"|TInterface\\ICONS\\"..icone..":30:30|t {w}"..ENABLE_SOUNDFX.." n°"..TabElement,
				rep.."\n\n{j}"..TRP2_LOC_CLIC.." {w}: "..TRP2_LOC_Sound_Add.."".."\n{j}"..TRP2_LOC_CLICDROIT.." {w}: "..TRP2_LOC_Sound_PreListen
			);
			j = j + 1;
		end
		i = i + 1;
	end);
end

function TRP2_DD_SoundCat(frame,level,menuList)
	UIDropDownMenu_SetWidth(frame, 50);
	UIDropDownMenu_SetButtonWidth(frame, 15);
	info = TRP2_CreateSimpleDDButton();
	info.text = TRP2_LOC_REPERT;
	info.isTitle = true;
	UIDropDownMenu_AddButton(info);
	
	info = TRP2_CreateSimpleDDButton();
	info.text = ALL;
	info.func = function() 
		TRP2_ListeSoundCategorie.Valeur = "all";
		TRP2_ListeSoundCategorieValeur:SetText(ALL);
	end;
	UIDropDownMenu_AddButton(info,level);
	
	local i;
	for k,v in pairs(TRP2_SOUNDSLIST2) do
		info = TRP2_CreateSimpleDDButton();
		info.text = k;
		if TRP2_ListeSoundCategorie.Valeur == k then
			info.checked = true;
			info.disabled = true;
		end
		info.func = function() 
			TRP2_ListeSoundCategorie.Valeur = k;
			TRP2_ListeSoundCategorieValeur:SetText(k);
		end;
		UIDropDownMenu_AddButton(info,level);
	end
	info = TRP2_CreateSimpleDDButton();
	info.text = CANCEL;
	UIDropDownMenu_AddButton(info,level);
end

TRP2_SOUNDSLIST2 = {
	["Ambience"] = {
	
	},
	["Character"] = {
	
	},
	["CinematicVoices"] = {
	
	},
	["Creature"] = {
	
	},
	["Doodad"] = {
	
	},
	["Effects"] = {
	
	},
	["Elevator_Transport"] = {
	
	},
	["Emitters"] = {
	
	},
	["event"] = {
	
	},
	["Event Sounds"] = {
	
	},
	["Events"] = {
	
	},
	["Interface"] = {
	
	},
	["Item"] = {
	
	},
	["Spells"] = {
	
	},
	["Universal"] = {
	
	},
	["Vehicles"] = {
	
	},
	["Voices"] = {
	
	},
};

TRP2_SOUNDSICONES = {
	["Abedneum"] = "Ability_Warrior_TitansGrip",
	["Abomination"] = "Spell_Shadow_AbominationExplosion",
	["Aeonis"] = "INV_Misc_Head_Dragon_Black",
	["AhabWheathoof"] = "Achievement_Character_Tauren_Male",
	["AhnQiraj"] = "INV_QirajIdol_Obsidian",
	["Akama"] = "",
	["Akilzon"] = "INV_Offhand_ZulAman_D_01",
	["AlexandrosMograine"] = "Spell_Holy_Crusade",
	["Alexstraza"] = "Ability_Mount_Drake_Red",
	["AlgalontheObserver"] = "Spell_Nature_AstralRecalGroup",
	["AlkizonExertions"] = "INV_Offhand_ZulAman_D_01",
	["AllianceGunShip"] = "Achievement_Zone_IceCrown_05",
	["AmbassadorHellmaw"] = "",
	["Ambience"] = "Achievement_Zone_Ashenvale_01",
	["AmnennarTheColdbringer"] = "Achievement_Boss_Amnennar_the_Coldbringer",
	["AncientProtector"] = "Ability_Druid_ManaTree",
	["AncientTreeOfWar"] = "Ability_Druid_ManaTree",
	["Anetheron"] = "Ability_Warlock_DemonicPower",
	["AnnhyldeTheCaller"] = "",
	["Anomalus"] = "INV_Elemental_Primal_Shadow",
	["AnubArak"] = "Ability_Hunter_Pet_Spider",
	["AnubarCrusher"] = "Ability_Hunter_Pet_Spider",
	["Anubrekhan"] = "Ability_Hunter_Pet_Spider",
	["Anusibath"] = "",
	["Anveena"] = "",
	["Arakkoa"] = "",
	["ArcaneGolem"] = "Ability_GolemThunderClap",
	["ArcaneGolemBroken"] = "Ability_GolemThunderClap",
	["ArcaneTitan"] = "Achievement_Boss_Archaedas",
	["ArcanistDoan"] = "",
	["Archaedas"] = "Achievement_Boss_Archaedas",
	["ArchbishopBenedictus"] = "",
	["Archer"] = "INV_Weapon_Bow_04",
	["Archimonde"] = "Achievement_Boss_Archimonde",
	["ArchivumSystem"] = "",
	["ArcticCondor"] = "",
	["ArgentColiseum"] = "",
	["ArgentTournament"] = "",
	["Arnath"] = "",
	["Arthas"] = "Achievement_Zone_IceCrown_01",
	["ArthasPrisoner"] = "Achievement_Zone_IceCrown_01",
	["Arugal"] = "",
	["Ashbringer"] = "",
	["Atalalarion"] = "",
	["AttumenTheHuntsman"] = "",
	["Auriaya"] = "",
	["AvatarOfHakar"] = "",
	["AvatarOfHakkar"] = "",
	["Axe1H"] = "",
	["Axe2H"] = "Achievement_Arena_2v2_1",
	["Azgalor"] = "",
	["AzjolNerub"] = "Achievement_Dungeon_AzjolLowercity_10man",
	["Azuremyst"] = "",
	["BE_Broom01"] = "",
	["BabyCrocodile"] = "",
	["BabyLich"] = "Achievement_Boss_Amnennar_the_Coldbringer",
	["BabyMurloc"] = "Achievement_Boss_Mutanus_the_Devourer",
	["BallofFlame"] = "",
	["Banshee"] = "",
	["BarnesTheStageManager"] = "",
	["BaronRevilgaz"] = "",
	["BaronRivendare"] = "",
	["BarrenDry"] = "",
	["Basilisk"] = "",
	["Bear"] = "Ability_Hunter_Pet_Bear",
	["Beholder"] = "",
	["BlackKnight"] = "",
	["BlackTemple"] = "",
	["BlackheartTheInciter"] = "",
	["BladesEdge"] = "",
	["BloodElf"] = "Achievement_Character_Bloodelf_Male",
	["BloodElfFemalePC"] = "Achievement_Character_Bloodelf_Female",
	["BloodElfMalePC"] = "Achievement_Character_Bloodelf_Male",
	["BloodElfMale_Guard"] = "Achievement_Character_Bloodelf_Male",
	["BloodGuard"] = "",
	["BloodQueenLanathel"] = "",
	["BloodmageThalnos"] = "",
	["Bloodmyst"] = "",
	["Boar"] = "INV_Misc_Head_Quillboar_01",
	["BodyofKathune"] = "",
	["BogBeast"] = "",
	["BolvarFordragon"] = "",
	["BoneGolem"] = "Ability_GolemThunderClap",
	["BonechewerBeastmaster"] = "",
	["BoreanTundra"] = "",
	["Bow"] = "INV_Weapon_Bow_05",
	["Brandon"] = "",
	["Brann"] = "INV_Misc_Head_Dwarf_01",
	["BrannBronzebeard"] = "INV_Misc_Head_Dwarf_01",
	["Brewfest"] = "INV_Misc_Beer_01",
	["BrokenMale"] = "",
	["BrokenNPC1"] = "",
	["BrokenNPC2"] = "",
	["Bronjahm"] = "",
	["BroodlordLasher"] = "",
	["BroomStickMount"] = "",
	["Brutallus"] = "",
	["CairneBloodhoof"] = "Achievement_Leader_Cairne Bloodhoof",
	["Caladis"] = "",
	["Cannon"] = "",
	["Captain"] = "",
	["CaptainScarloc"] = "",
	["CardinalDeathwhisper"] = "",
	["Carrion"] = "",
	["Cast"] = "",
	["Cat"] = "",
	["CavernsOfTime"] = "",
	["Centaur"] = "",
	["CentaurFemale"] = "",
	["ChamberOfTheAspects"] = "",
	["Character"] = "Spell_Shadow_Charm",
	["CharlgaRazorflank"] = "",
	["Chicken"] = "Spell_Magic_PolymorphChicken",
	["ChickenMount"] = "Spell_Magic_PolymorphChicken",
	["ChiefUkorzSandscalp"] = "",
	["ChineseDragon"] = "",
	["ChronoLordDeja"] = "",
	["ChronoLordEpoch"] = "",
	["CinematicVoices"] = "",
	["CityMusic"] = "",
	["ClockWorkGnome"] = "",
	["ClockworkGiant"] = "",
	["ClockworkGiantPet"] = "",
	["CloudSwampGasLoop"] = "",
	["Cocoon"] = "",
	["ColdWraith"] = "",
	["CommanderKolurg"] = "",
	["CommanderSarannis"] = "",
	["CommanderStoutbeard"] = "",
	["CoreHoundPet"] = "",
	["Cow"] = "",
	["Crab"] = "",
	["CrackElfMale"] = "",
	["Crawler"] = "",
	["Creature"] = "",
	["Creature_BurningLegionCannon"] = "",
	["Creature_EtherialStorm"] = "",
	["Creature_PowerCrystal"] = "",
	["Creature_ScourgeCrystalDamaged"] = "",
	["CrokScourgebane"] = "",
	["Crone"] = "",
	["CryptFiend"] = "",
	["CryptLord"] = "",
	["CrystalPortal"] = "",
	["Crystalsong"] = "",
	["Cthun"] = "Achievement_Boss_CThun",
	["Curator"] = "",
	["CursedLand"] = "",
	["Cyanigosa"] = "",
	["Dagger"] = "",
	["Dalaran"] = "",
	["DaliahTheDoomsayer"] = "",
	["DalronnTheController"] = "",
	["DameBlaumeux"] = "",
	["DarionMograine"] = "",
	["DarkHound"] = "",
	["DarkweaverSyth"] = "",
	["Darnassus"] = "",
	["Data"] = "",
	["DeathImpacts"] = "Achievement_BG_killingblow_30",
	["DeathKnight"] = "",
	["DeathKnightMount"] = "",
	["DeathbringerSaurfang"] = "",
	["Deer"] = "",
	["Demolisher"] = "",
	["DemonForm"] = "",
	["DemonHunter"] = "",
	["Desert"] = "",
	["DevourerofSouls"] = "",
	["DiabloFunSized"] = "",
	["DirectDamage"] = "",
	["Doodad"] = "",
	["DoodadCompression"] = "",
	["DoomGuard"] = "",
	["DoomGuardOutland"] = "",
	["DoomGuardVO"] = "",
	["DoomLordKazzak"] = "",
	["Doomwalker"] = "",
	["Dorothee"] = "",
	["Draenei"] = "Achievement_Character_Draenei_Male",
	["DraeneiFemalePC"] = "Achievement_Character_Draenei_Female",
	["DraeneiMalePC"] = "Achievement_Character_Draenei_Male",
	["DragonFootSoldier"] = "",
	["DragonHawk"] = "",
	["DragonKite"] = "",
	["DragonSpawn"] = "",
	["DragonWhelp"] = "",
	["Dragonblight"] = "",
	["Dragons"] = "",
	["Drake"] = "Ability_Mount_Drake_Red",
	["Drakeadon"] = "",
	["DrakosTheInterrogator"] = "",
	["Drakuru"] = "",
	["DreadLord"] = "",
	["Dreamscythe"] = "",
	["Druid of the Claw"] = "",
	["Dryad"] = "",
	["Dwarf"] = "Achievement_Character_Dwarf_Male",
	["DwarfFemale"] = "Achievement_Character_Dwarf_Female",
	["DwarfFemaleErrorMessages"] = "Achievement_Character_Dwarf_Female",
	["DwarfFemaleFinal"] = "Achievement_Character_Dwarf_Female",
	["DwarfFemaleGuardNPC"] = "Achievement_Character_Dwarf_Female",
	["DwarfFemaleMaternalNPC"] = "Achievement_Character_Dwarf_Female",
	["DwarfFemaleYoungNPC"] = "Achievement_Character_Dwarf_Female",
	["DwarfMale"] = "Achievement_Character_Dwarf_Male",
	["DwarfMaleErrorMessages"] = "Achievement_Character_Dwarf_Male",
	["DwarfMaleFinal"] = "Achievement_Character_Dwarf_Male",
	["DwarfMaleGrimNPC"] = "Achievement_Character_Dwarf_Male",
	["DwarfMaleGuardNPC"] = "Achievement_Character_Dwarf_Male",
	["DwarfMaleNPC"] = "Achievement_Character_Dwarf_Male",
	["DwarfMaleNpc1"] = "Achievement_Character_Dwarf_Male",
	["DwarfMaleStandardNPC"] = "Achievement_Character_Dwarf_Male",
	["DwarfVocalFemale"] = "Achievement_Character_Dwarf_Female",
	["DwarfVocalMale"] = "Achievement_Character_Dwarf_Male",
	["EadricthePure"] = "",
	["Ebon Hold"] = "",
	["EdwinVanCleef"] = "Achievement_Boss_EdwinVancleef",
	["Effects"] = "",
	["ElderBrightleaf"] = "",
	["ElderIronbranch"] = "",
	["ElderNadox"] = "",
	["ElderStonebark"] = "",
	["Electrocutioner6000"] = "",
	["Elekk"] = "",
	["ElekkPet"] = "",
	["ElementalAir"] = "",
	["ElementalEarth"] = "",
	["ElementalFire"] = "",
	["Elevator_Transport"] = "",
	["Emissary"] = "",
	["Emitters"] = "",
	["EnchantedForest"] = "",
	["Ent"] = "",
	["EnterWaterSplash"] = "Spell_Frost_SummonWaterElemental",
	["EpochHunter"] = "",
	["Eredar"] = "",
	["Erekem"] = "",
	["EssenceOfAnger"] = "",
	["EssenceOfDesire"] = "",
	["EssenceOfGrief"] = "",
	["Ethereal"] = "",
	["Etherial"] = "",
	["Event Sounds"] = "",
	["Events"] = "",
	["Eversong"] = "",
	["EvilForest"] = "",
	["ExarchMaladaar"] = "Achievement_Boss_Exarch_Maladaar",
	["ExecutionerOrcMale"] = "Achievement_Character_Orc_Male",
	["Executus"] = "",
	["FacelessOne"] = "",
	["FaerieDragon"] = "",
	["Faerlina"] = "",
	["Falric"] = "",
	["FandralStaghelm"] = "",
	["Fankriss"] = "",
	["FathomLordKarathress"] = "",
	["FelBat"] = "",
	["FelBeast"] = "",
	["FelBoar"] = "",
	["FelElfCasterFemale"] = "",
	["FelElfCasterMale"] = "",
	["FelElfHunterFemale"] = "",
	["FelElfWarrirorMale"] = "",
	["FelGolem"] = "Ability_GolemThunderClap",
	["FelHound"] = "",
	["FelOrc"] = "",
	["FelReaver"] = "",
	["Felblaze"] = "",
	["FelendrenTheBanished"] = "",
	["Female"] = "",
	["FemaleErrorMessages"] = "",
	["FemaleTitan"] = "Achievement_Boss_Archaedas",
	["Festergut"] = "",
	["Feugen"] = "",
	["FireFly"] = "",
	["Fizzle"] = "",
	["FlameLeviathan"] = "",
	["FleshBeast"] = "",
	["FleshGiant"] = "",
	["FleshGolem"] = "Ability_GolemThunderClap",
	["FleshTitan"] = "Achievement_Boss_Archaedas",
	["FlyingBomber"] = "",
	["FlyingMachineCreature_Vehicle"] = "",
	["FlyingNerubian"] = "",
	["FlyingReindeer"] = "",
	["FoleySounds"] = "",
	["Footman"] = "",
	["Footsteps"] = "Ability_Rogue_FleetFooted",
	["ForceofNature"] = "",
	["Forest"] = "",
	["Forest Troll"] = "Achievement_Character_Troll_Male",
	["ForestTrollMale"] = "Achievement_Character_Troll_Male",
	["ForgemasterGarfrost"] = "",
	["ForsakenCatapult"] = "",
	["Frenzy"] = "",
	["Freya"] = "",
	["Frog"] = "",
	["FrostLord"] = "",
	["FrostNymph"] = "",
	["FrostWurmFelFire"] = "",
	["FrostWyrm"] = "",
	["FrostWyrmPet"] = "",
	["FrostwornGeneral"] = "",
	["FuelRobot"] = "",
	["FungalGiant"] = "",
	["Furbolg"] = "",
	["Galdarah"] = "",
	["GalgannFirehammer"] = "",
	["Garona"] = "",
	["Garrosh"] = "",
	["GatewatcherGyroKill"] = "",
	["GatewatcherIronHand"] = "",
	["GathiosTheShatterer"] = "",
	["Gazlowe"] = "",
	["Geist"] = "",
	["GeneralArlos"] = "",
	["GeneralBjarngrim"] = "",
	["GeneralVezax"] = "",
	["Ghost"] = "Achievement_Halloween_Ghost_01",
	["GhostMusic"] = "Achievement_Halloween_Ghost_01",
	["Ghostlands"] = "Achievement_Halloween_Ghost_01",
	["GhostlySkullPet"] = "Achievement_Halloween_Ghost_01",
	["Ghoul"] = "",
	["GiantFootSteps"] = "Ability_Rogue_FleetFooted",
	["GiantSpider"] = "",
	["Giraffe"] = "",
	["GlueScreen"] = "Achievement_Zone_Outland_01",
	["GlueScreenMusic"] = "Achievement_Zone_Outland_01",
	["Glutton"] = "",
	["Gnoll"] = "INV_Misc_Head_Gnoll_01",
	["Gnome"] = "Achievement_Character_Gnome_Male",
	["GnomeFemaleErrorMessages"] = "Achievement_Character_Gnome_Female",
	["GnomeFemaleFinal"] = "Achievement_Character_Gnome_Female",
	["GnomeFemaleHappyNPC"] = "Achievement_Character_Gnome_Female",
	["GnomeFemaleNerdyNPC"] = "Achievement_Character_Gnome_Female",
	["GnomeFemaleStandardNPC"] = "Achievement_Character_Gnome_Female",
	["GnomeMaleErrorMessages"] = "Achievement_Character_Gnome_Male",
	["GnomeMaleFinal"] = "Achievement_Character_Gnome_Male",
	["GnomeMaleStandardNPC"] = "Achievement_Character_Gnome_Male",
	["GnomeMaleYoungNPC"] = "Achievement_Character_Gnome_Male",
	["GnomeMaleZanyNPC"] = "Achievement_Character_Gnome_Male",
	["GnomePounder"] = "",
	["GnomeSpiderTank"] = "",
	["GnomeSpiderTank02"] = "",
	["GnomeVocalFemale"] = "Achievement_Character_Gnome_Female",
	["GnomeVocalMale"] = "Achievement_Character_Gnome_Male",
	["Gnomeragon"] = "",
	["Goblin"] = "",
	["GoblinFemaleZanyNPC"] = "",
	["GoblinMaleGruffNPC"] = "",
	["GoblinMaleGuardNPC"] = "",
	["GoblinMaleZanyNPC"] = "",
	["GoblinShredder"] = "",
	["Goblin_Cannon"] = "",
	["GolemIron"] = "Ability_GolemThunderClap",
	["Golem_Stone"] = "Ability_GolemThunderClap",
	["Gorilla"] = "",
	["GortokPalehoof"] = "",
	["Gothik"] = "",
	["GrandAdmiralWestwind"] = "",
	["GrandAstromancerCapernian"] = "",
	["GrandMagusTelestra"] = "",
	["GrandWarlockAlythess"] = "",
	["GrandmasterVorpil"] = "",
	["Grell"] = "",
	["Grethok"] = "",
	["Grimlock"] = "",
	["GrizzlyHills"] = "",
	["Grondel"] = "",
	["Gronn"] = "",
	["GroundFlower"] = "",
	["Grunt"] = "",
	["GruulTheDragonkiller"] = "Achievement_Boss_GruulTheDragonkiller",
	["Gryphon"] = "",
	["GryphonPet"] = "",
	["Gryphon_Ghost"] = "Achievement_Halloween_Ghost_01",
	["Gryphon_Skeletal"] = "",
	["Gun"] = "INV_Weapon_Rifle_06",
	["GurtoggBloodboil"] = "",
	["GyroPets"] = "",
	["Gyrocopter"] = "",
	["Hakkar"] = "Achievement_Boss_Hakkar",
	["Halazzi"] = "",
	["HalazziExertions"] = "",
	["HarbingerSkyriss"] = "Achievement_Boss_Harbinger_Skyriss",
	["Harkoa"] = "",
	["Harpy"] = "",
	["HarvestGolem"] = "Ability_GolemThunderClap",
	["Headless Horseman"] = "",
	["HeadlessHorseman"] = "",
	["HellfirePeninsula"] = "",
	["HeraldVolazj"] = "",
	["Hero Moon Priestess"] = "",
	["Hero Mountain King"] = "",
	["Herod"] = "",
	["HighAstromancerSolarian"] = "",
	["HighBontanistFreywinn"] = "",
	["HighGeneralAbbendis"] = "",
	["HighInquisitorWhitemane"] = "",
	["HighKingMaulgar"] = "",
	["HighNethermancerZerevor"] = "",
	["HighOverlordSaurfang"] = "",
	["HighTinkerMekkatorque"] = "",
	["HighWarlordNajentus"] = "",
	["HighlordMograine"] = "",
	["Hippogryph"] = "",
	["Hodir"] = "",
	["HoodWolf"] = "Ability_Mount_BlackDireWolf",
	["HordeGunShip"] = "",
	["Horisath"] = "",
	["Horse"] = "",
	["HorseUndead"] = "",
	["HoundmasterLoksey"] = "",
	["HowlingFjord"] = "",
	["Human"] = "Achievement_Character_Human_Male",
	["HumanFemaleFinal"] = "Achievement_Character_Human_Female",
	["HumanFemaleKid"] = "Achievement_Character_Human_Female",
	["HumanFemaleOfficialNPC"] = "Achievement_Character_Human_Female",
	["HumanFemaleStandardNPC"] = "Achievement_Character_Human_Female",
	["HumanFemaleWarriorNPC"] = "Achievement_Character_Human_Female",
	["HumanMAleKid"] = "Achievement_Character_Human_Male",
	["HumanMaleFinal"] = "Achievement_Character_Human_Male",
	["HumanMaleOfficialNPC"] = "Achievement_Character_Human_Male",
	["HumanMalePirate"] = "Achievement_Character_Human_Male",
	["HumanMalePirateHeavy"] = "Achievement_Character_Human_Male",
	["HumanMaleStandardNPC"] = "Achievement_Character_Human_Male",
	["HumanMaleWarriorNPC"] = "Achievement_Character_Human_Male",
	["HumanPesantMale"] = "Achievement_Character_Human_Male",
	["HumanVocalFemale"] = "Achievement_Character_Human_Female",
	["HumanVocalMale"] = "Achievement_Character_Human_Male",
	["HumanWarrior1"] = "Achievement_Character_Human_Male",
	["HumanWarrior2"] = "Achievement_Character_Human_Male",
	["HumanWarrior3"] = "Achievement_Character_Human_Male",
	["Huntress"] = "",
	["Hydra"] = "Achievement_Boss_Bazil_Akumai",
	["HydraBossAggro"] = "Achievement_Boss_Bazil_Akumai",
	["HydromancerThespia"] = "",
	["HydrossTheUnstable_Clean"] = "",
	["HydrossTheUnstable_Corrupt"] = "",
	["Hyena"] = "",
	["IcecrownGlacier"] = "Achievement_Zone_IceCrown_01",
	["IcecrownRaid"] = "Achievement_Zone_IceCrown_01",
	["Ichoron"] = "",
	["IgnisTheFireMaster"] = "",
	["Illidan"] = "Achievement_Boss_Illidan",
	["ImpVO"] = "",
	["InWater"] = "INV_Crystallized_Water",
	["Infernal"] = "",
	["IngvarThePlunderer"] = "",
	["Interface"] = "",
	["InterrogatorVishas"] = "",
	["Ionar"] = "",
	["IronDwarf"] = "",
	["IronVrykulMale"] = "",
	["Ironaya"] = "",
	["Ironforge"] = "",
	["Item"] = "",
	["JainaProudmoore"] = "",
	["JammalanTheProphet"] = "",
	["JanAlai"] = "",
	["JanAlaiExertions"] = "",
	["Jaraxxus"] = "",
	["JedogaShadowseeker"] = "",
	["JormungarLarva"] = "",
	["Julianne"] = "",
	["Jungle"] = "",
	["JustinBartlett"] = "",
	["Kadrak"] = "",
	["Kalecgos"] = "",
	["Karazhan"] = "",
	["KazRogal"] = "",
	["KeeperOfTheGrove"] = "",
	["Keleseth"] = "",
	["KelidanTheBreaker"] = "Achievement_Boss_KelidanTheBreaker",
	["Kelthuzad"] = "",
	["Keristrasza"] = "",
	["KilJaeden"] = "Achievement_Boss_Kiljaedan",
	["KingAnduinWrynn"] = "",
	["KingLlane"] = "",
	["KingMagniBronzebeard"] = "Achievement_Leader_King_Magni_Bronzebeard",
	["KingTerenas"] = "",
	["KingYmiron"] = "ACHIEVEMENT_BOSS_KINGYMIRON_01",
	["Kobold"] = "",
	["KodoBeast"] = "",
	["Kologarn"] = "",
	["Krakken"] = "",
	["Krick"] = "",
	["KrikThirTheGatewatcher"] = "",
	["KromBlackScar"] = "",
	["Krystallus"] = "",
	["KyleTheDog"] = "",
	["LadyAnacondra"] = "",
	["LadyLiadrin"] = "",
	["LadyMalande"] = "",
	["LadySacrolash"] = "",
	["LadySarevess"] = "",
	["LadyVashj"] = "Achievement_Boss_LadyVashj",
	["LakeWintergrasp"] = "",
	["Larva"] = "",
	["Lasher"] = "",
	["Legionnaire01"] = "",
	["Legionnaire02"] = "",
	["Legionnaire03"] = "",
	["Leotheras_Demon"] = "",
	["Leotheras_NightElf"] = "Achievement_Character_Nightelf_Male",
	["Leryssa"] = "",
	["LesserManaFiend"] = "",
	["LeyGuardianEregos"] = "",
	["Lich"] = "Achievement_Boss_Amnennar_the_Coldbringer",
	["LichKing"] = "Achievement_Zone_IceCrown_01",
	["LieutenantDrake"] = "Ability_Mount_Drake_Bronze",
	["LifebinderGift_Death"] = "Achievement_BG_killingblow_berserker",
	["LionSeal"] = "",
	["Loathstare"] = "",
	["Lobstrok"] = "",
	["Loken"] = "",
	["LordCobrahn"] = "",
	["LordMarrowgar"] = "",
	["LordMaxwellTyrosus"] = "",
	["LordPythas"] = "",
	["LordSanguinar"] = "",
	["LordSerpentis"] = "",
	["LordVictorNefarius"] = "",
	["LostOne"] = "",
	["MISC"] = "",
	["Mace1H"] = "INV_Mace_09",
	["Mace1HMetal"] = "INV_Mace_08",
	["Mace2H"] = "INV_Mace_07",
	["Mace2HMetal"] = "INV_Mace_06",
	["MadScientist"] = "",
	["Madrigosa"] = "",
	["MagathaGrimtotem"] = "",
	["MageHunter"] = "",
	["MageLordUrom"] = "",
	["Magnataur"] = "",
	["Magtheridon"] = "Achievement_Boss_Magtheridon",
	["MaidenOfGrief"] = "",
	["MaidenofVirtue"] = "",
	["Maiev"] = "",
	["Malacrass"] = "",
	["Male"] = "",
	["MaleErrorMessages"] = "",
	["MaleNPC"] = "",
	["Malganis"] = "",
	["Malygos"] = "Ability_Mount_Drake_Azure",
	["Mammoth"] = "",
	["MannorothsDeath"] = "Achievement_BG_killingblow_most",
	["MarineBabyMurloc"] = "Achievement_Boss_Mutanus_the_Devourer",
	["Marnak"] = "",
	["Marwyn"] = "",
	["MasterEngineerTelonicus"] = "",
	["Meathook"] = "",
	["MechaStrider"] = "",
	["MechanoLordCapacitus"] = "",
	["MediumLargeMetalFootsteps"] = "Ability_Rogue_FleetFooted",
	["Medivh"] = "",
	["MedivhsEcho"] = "",
	["MekgineerSteamrigger"] = "",
	["MekgineerThermaplug"] = "Achievement_Boss_Mekgineer_Thermaplugg ",
	["MennuTheTraitorous"] = "",
	["MillhouseManastorm"] = "",
	["Mimiron"] = "",
	["MimironCannon"] = "",
	["MimironHeadMount"] = "",
	["MimironTorso"] = "",
	["MissSwings"] = "INV_Misc_MissileSmall_White",
	["Missile"] = "INV_Misc_MissileSmall_White",
	["Moarg"] = "",
	["MoargMinion"] = "",
	["Mobat"] = "",
	["MobileAlertBot"] = "",
	["Moorabi"] = "",
	["MordreshFireEye"] = "",
	["Moroes"] = "",
	["MorogrimTidewalker"] = "",
	["Mortar Team"] = "",
	["MotherShahraz"] = "",
	["MotorcycleVehicle"] = "",
	["Mountain"] = "",
	["MountainGiant"] = "",
	["MrSmite"] = "",
	["Muradin"] = "Achievement_Leader_King_Magni_Bronzebeard",
	["MuradinBronzebeard"] = "Achievement_Leader_King_Magni_Bronzebeard",
	["Murloc"] = "Achievement_Boss_Mutanus_the_Devourer",
	["Murmur"] = "",
	["Music"] = "",
	["Musical Moments"] = "",
	["Myralion"] = "",
	["NPC"] = "",
	["NPCBloodElfFemaleMilitary"] = "Achievement_Character_Bloodelf_Female",
	["NPCBloodElfFemaleNoble"] = "Achievement_Character_Bloodelf_Female",
	["NPCBloodElfFemaleStandard"] = "Achievement_Character_Bloodelf_Female",
	["NPCBloodElfMaleMilitary"] = "Achievement_Character_Bloodelf_Male",
	["NPCBloodElfMaleNoble"] = "Achievement_Character_Bloodelf_Male",
	["NPCBloodElfMaleStandard"] = "Achievement_Character_Bloodelf_Male",
	["NPCDeathKnightFemaleGnome01"] = "Achievement_Character_Gnome_Female",
	["NPCDeathKnightFemaleLow01"] = "",
	["NPCDeathKnightFemaleLow02"] = "",
	["NPCDeathKnightFemaleMed01"] = "",
	["NPCDeathKnightFemaleMed02"] = "",
	["NPCDeathKnightMaleGnome01"] = "Achievement_Character_Gnome_Male",
	["NPCDeathKnightMaleLow01"] = "",
	["NPCDeathKnightMaleLow02"] = "",
	["NPCDeathKnightMaleMed01"] = "",
	["NPCDeathKnightMaleMed02"] = "",
	["NPCDeathKnightTrollFemale"] = "Achievement_Character_Troll_Female",
	["NPCDeathKnightTrollMale"] = "Achievement_Character_Troll_Male",
	["NPCDraeneiFemaleMilitary"] = "Achievement_Character_Draenei_Female",
	["NPCDraeneiFemaleNoble"] = "Achievement_Character_Draenei_Female",
	["NPCDraeneiFemaleStandard"] = "Achievement_Character_Draenei_Female",
	["NPCDraeneiMaleMilitary"] = "Achievement_Character_Draenei_Male",
	["NPCDraeneiMaleNoble"] = "Achievement_Character_Draenei_Male",
	["NPCDraeneiMaleStandard"] = "Achievement_Character_Draenei_Male",
	["NPCGeist"] = "",
	["NPCGhoul"] = "",
	["NPCTuskarrMaleMagicUser"] = "",
	["NPCTuskarrMaleStandard"] = "",
	["NPCTuskarrMaleWarrior"] = "",
	["NPCVrykulFemaleMagicUser"] = "",
	["NPCVrykulFemaleStandard"] = "",
	["NPCVrykulFemaleWarrior"] = "",
	["NPCVrykulMaleMagicUser"] = "",
	["NPCVrykulMaleStandard"] = "",
	["NPCVrykulMaleWarrior"] = "",
	["Naaru"] = "",
	["Naga"] = "Achievement_Boss_Warlord_Kalithresh",
	["NagaFemale"] = "Achievement_Boss_Warlord_Kalithresh",
	["Nagrand"] = "",
	["Nalorakk"] = "",
	["NalorakkExertions"] = "",
	["Naralex"] = "",
	["Naxxramas"] = "Achievement_Dungeon_Naxxramas",
	["Necromancer"] = "",
	["NecromancerDraenei01"] = "Achievement_Character_Draenei_Male",
	["NecromancerDraenei02"] = "Achievement_Character_Draenei_Male",
	["NecromancerDraenei03"] = "Achievement_Character_Draenei_Male",
	["Nefarian"] = "",
	["Neltharion"] = "",
	["Nerubian"] = "",
	["Nethekurse"] = "",
	["NetherDragon"] = "",
	["NetherDrake"] = "Ability_Mount_NetherdrakePurple",
	["NetherDrakeAll"] = "Ability_Mount_NetherdrakePurple",
	["NethermancerSepethrea"] = "",
	["Netherstorm"] = "",
	["Nexus"] = "Achievement_Dungeon_Nexus70_25man",
	["NexusPrinceShafar"] = "Achievement_Boss_Nexus_Prince_Shaffar",
	["NightElf"] = "Achievement_Character_Nightelf_Male",
	["NightElfFemale"] = "Achievement_Character_Nightelf_Female",
	["NightElfFemaleErrorMessages"] = "Achievement_Character_Nightelf_Female",
	["NightElfFemaleFinal"] = "Achievement_Character_Nightelf_Female",
	["NightElfFemalePriestessNPC"] = "Achievement_Character_Nightelf_Female",
	["NightElfFemaleSentinelNPC"] = "Achievement_Character_Nightelf_Female",
	["NightElfFemaleStandardNPC"] = "Achievement_Character_Nightelf_Female",
	["NightElfMale"] = "Achievement_Character_Nightelf_Male",
	["NightElfMaleErrorMessages"] = "Achievement_Character_Nightelf_Male",
	["NightElfMaleFinal"] = "Achievement_Character_Nightelf_Male",
	["NightElfMaleOfficialNPC"] = "Achievement_Character_Nightelf_Male",
	["NightElfMaleStandardNPC"] = "Achievement_Character_Nightelf_Male",
	["NightElfMaleWarriorNPC"] = "Achievement_Character_Nightelf_Male",
	["NightElfVocalFemale"] = "Achievement_Character_Nightelf_Female",
	["NightElfVocalMale"] = "Achievement_Character_Nightelf_Male",
	["Nightbane"] = "",
	["Northrend"] = "",
	["NorthrendFleshGiant"] = "",
	["NorthrendGeist"] = "",
	["NorthrendGhoul"] = "",
	["NorthrendGiant"] = "",
	["NorthrendIceGiant"] = "",
	["NorthrendIronGiant"] = "",
	["NorthrendPenguin"] = "",
	["NorthrendStoneGiant"] = "",
	["NorthrendTransport"] = "",
	["NothTheFrozen"] = "",
	["NovosTheSummoner"] = "",
	["ORcMaleNpc1"] = "Achievement_Character_Orc_Male",
	["ORca"] = "",
	["OWl"] = "",
	["Ogre"] = "",
	["OgreKing"] = "",
	["OgreMage"] = "",
	["Olum"] = "",
	["OmorTheUnscarred"] = "",
	["Oracle"] = "",
	["Orc"] = "Achievement_Character_Orc_Male",
	["OrcFemaleErrorMessages"] = "Achievement_Character_Orc_Female",
	["OrcFemaleFinal"] = "Achievement_Character_Orc_Female",
	["OrcFemaleKid"] = "Achievement_Character_Orc_Female",
	["OrcFemaleShamanNPC"] = "Achievement_Character_Orc_Female",
	["OrcFemaleStandardNPC"] = "Achievement_Character_Orc_Female",
	["OrcFemaleWarriorNPC"] = "Achievement_Character_Orc_Female",
	["OrcMale"] = "Achievement_Character_Orc_Male",
	["OrcMaleErrorMessages"] = "Achievement_Character_Orc_Male",
	["OrcMaleGuardNPC"] = "Achievement_Character_Orc_Male",
	["OrcMaleKid"] = "Achievement_Character_Orc_Male",
	["OrcMaleNPC"] = "Achievement_Character_Orc_Male",
	["OrcMaleShadyNPC"] = "Achievement_Character_Orc_Male",
	["OrcMaleStandardNPC"] = "Achievement_Character_Orc_Male",
	["OrcVocalFemale"] = "Achievement_Character_Orc_Female",
	["OrcVocalMale"] = "Achievement_Character_Orc_Male",
	["Orgrimmar"] = "",
	["OrmorokTheTreeShaper"] = "",
	["Ossirian"] = "",
	["OutlandGeneral"] = "",
	["OverlordRamtusk"] = "",
	["OverthaneBalargarde"] = "",
	["PVP"] = "",
	["Paletress"] = "",
	["PandaCub"] = "",
	["PandarenPet"] = "",
	["Parrot"] = "",
	["Parry"] = "",
	["ParrySounds"] = "",
	["Patchwerk"] = "",
	["PathaleonTheCalculator"] = "",
	["Peasant"] = "",
	["PenguinPet"] = "",
	["Peon"] = "",
	["PetGorilla"] = "",
	["Phoenix"] = "",
	["PhoenixPet"] = "",
	["PickUp"] = "",
	["PitLord"] = "",
	["Plains"] = "",
	["PlayerDamage"] = "",
	["PlayerExertions"] = "",
	["PlayerRoars"] = "Ability_Druid_TigersRoar",
	["PolarBearCub"] = "",
	["PossessedVardmadra"] = "",
	["PriestessDelrissa"] = "",
	["PrinceKaelThas"] = "Achievement_Boss_Kael'thasSunstrider_01",
	["PrinceKaelthasSunstrider"] = "Achievement_Boss_Kael'thasSunstrider_01",
	["PrinceKeleseth"] = "",
	["PrinceMalchezzar"] = "Achievement_Boss_Prince_Malchezaar",
	["PrinceTaldaram"] = "",
	["PrinceValanar"] = "",
	["ProfessorPutricide"] = "",
	["ProphetTharonja"] = "Achievement_Dungeon_Drak'Tharon_10man",
	["ProtoDragon"] = "Ability_Mount_Drake_Proto",
	["Pterrodax"] = "",
	["PugDog"] = "",
	["PumpkinSoldier"] = "",
	["Putress"] = "",
	["QueenAngerboda"] = "",
	["QuillBoar"] = "",
	["QuirajGladiator"] = "",
	["QuirajProphet"] = "",
	["QurajiProphet"] = "",
	["Rabbit"] = "",
	["RageWinterchill"] = "",
	["Ragnaros"] = "",
	["Rajaxx"] = "",
	["Ram"] = "",
	["Raptor"] = "",
	["Rat"] = "",
	["Razorgore"] = "",
	["RazorscaleNPC"] = "",
	["Razuvious"] = "",
	["ReinDeerMount"] = "",
	["Reindeer"] = "",
	["RevenantAir"] = "",
	["RevenantEarth"] = "",
	["RevenantFire"] = "",
	["RevenantWater"] = "INV_Crystallized_Water",
	["RhahkZor"] = "",
	["Rhonin"] = "",
	["RidingNetherRay"] = "",
	["RidingTalbuk"] = "",
	["RidingTurtle"] = "INV_Misc_Fish_Turtle_02",
	["Rifleman"] = "INV_Weapon_Rifle_11",
	["Roach"] = "",
	["Roar"] = "Ability_Druid_TigersRoar",
	["RobotPet"] = "Ability_Mount_MechaStrider",
	["RockFlayer"] = "",
	["RocketChicken"] = "Spell_Magic_PolymorphChicken",
	["RocketMount"] = "",
	["Romulo"] = "",
	["Rotface"] = "",
	["RunemasterMolgeim"] = "",
	["Rupert"] = "",
	["SaberWorg"] = "Ability_Mount_BlackDireWolf",
	["Sacred"] = "Ability_Paladin_SacredCleansing",
	["SalrammTheFleshcrafter"] = "",
	["SandfuryExecutioner"] = "",
	["Sargeras"] = "Ability_Warlock_DemonicEmpowerment",
	["Sartharion"] = "",
	["SathrovarTheCorruptor"] = "",
	["Satyr"] = "Spell_Shadow_DemonForm",
	["Satyre"] = "Spell_Shadow_DemonForm",
	["Saurfang"] = "",
	["ScarletCommanderMograine"] = "",
	["ScarletTrainee"] = "",
	["Scourge"] = "INV_Misc_Head_Undead_01",
	["ScourgeFemale"] = "INV_Misc_Head_Undead_02",
	["ScourgeFemaleErrorMessages"] = "INV_Misc_Head_Undead_02",
	["ScourgeMale"] = "INV_Misc_Head_Undead_01",
	["ScourgeMaleErrorMessages"] = "INV_Misc_Head_Undead_01",
	["ScourgeVocalFemale"] = "INV_Misc_Head_Undead_02",
	["ScourgeVocalMale"] = "INV_Misc_Head_Undead_01",
	["ScourgelordTyrannus"] = "",
	["Scout"] = "",
	["SeaGiant"] = "",
	["SeaTurtle"] = "INV_Misc_Fish_Turtle_03",
	["SeaVrykulMale"] = "",
	["SelimFireheart"] = "",
	["Serpent"] = "",
	["Shade"] = "",
	["ShadeofAran"] = "",
	["ShadowmoonValley"] = "",
	["Shadron"] = "",
	["Shark"] = "",
	["Sheep"] = "",
	["Shields"] = "",
	["Shivan"] = "",
	["SholazarBasin"] = "",
	["ShovelTusk"] = "",
	["SiegeVehicle"] = "",
	["Sif"] = "",
	["SilithidWasp"] = "",
	["SilthidWaspBoss"] = "",
	["Sindragosa"] = "",
	["SirZeliek"] = "",
	["SisterSvalna"] = "",
	["Sisters"] = "",
	["SjonnirTheIronshaper"] = "",
	["SkadiTheRuthless"] = "",
	["SkarvaldTheConstructor"] = "",
	["Skeleton"] = "",
	["SkeletonMage"] = "",
	["Skeram"] = "",
	["Skunk"] = "",
	["Sladran"] = "",
	["Slime"] = "",
	["Slith"] = "",
	["Snake"] = "Ability_Hunter_SnakeTrap",
	["SnowflakeCreature"] = "",
	["SoggyPlace"] = "",
	["Sound"] = "",
	["SpectralCat"] = "",
	["SpectralSaberWorg"] = "Ability_Mount_BlackDireWolf",
	["SpectralTiger"] = "INV_Misc_Head_Tiger_01",
	["SpellbinderBrokenMale"] = "",
	["Spells"] = "",
	["SpiderFootsteps"] = "Ability_Rogue_FleetFooted",
	["SpiritHealer"] = "",
	["SporeBat"] = "",
	["SporeCreature"] = "",
	["Sporeling"] = "",
	["Squirrel"] = "",
	["Stalagg"] = "",
	["SteamTonk"] = "",
	["Steelbreaker"] = "",
	["StoneGolem"] = "Ability_GolemThunderClap",
	["StormCrow"] = "",
	["StormPeaks"] = "",
	["StormcallerBrundir"] = "",
	["Stormwind"] = "",
	["StratholmePast"] = "Achievement_Dungeon_CoTStratholme_10man",
	["Strawman"] = "",
	["Succubus"] = "",
	["SuccubusVO"] = "",
	["SummonerOrcFemale"] = "Achievement_Character_Orc_Female",
	["Sunwell"] = "",
	["SuperZombie"] = "",
	["SvalaSorrowgrave"] = "",
	["SwamplordMuselek"] = "",
	["Sword1H"] = "",
	["Sword2H"] = "Achievement_Arena_3v3_2",
	["Sylvanas"] = "Achievement_Leader_Sylvanas",
	["SylvanasWindrunner"] = "Achievement_Leader_Sylvanas",
	["T_Robot_Pet"] = "",
	["Taldaram"] = "",
	["Tallstrider"] = "",
	["TalonkingIkiss"] = "Achievement_Boss_TalonKingIkiss",
	["Tarantula"] = "",
	["Taunka"] = "",
	["Tauren"] = "Achievement_Character_Tauren_Male",
	["TaurenFemaleErrorMessages"] = "Achievement_Character_Tauren_Female",
	["TaurenFemaleFinal"] = "Achievement_Character_Tauren_Female",
	["TaurenFemaleOfficialNPC"] = "Achievement_Character_Tauren_Female",
	["TaurenFemaleShamanNPC"] = "Achievement_Character_Tauren_Female",
	["TaurenFemaleStandardNPC"] = "Achievement_Character_Tauren_Female",
	["TaurenMale"] = "Achievement_Character_Tauren_Male",
	["TaurenMaleElderNPC"] = "Achievement_Character_Tauren_Male",
	["TaurenMaleErrorMessages"] = "Achievement_Character_Tauren_Male",
	["TaurenMaleFinal"] = "Achievement_Character_Tauren_Male",
	["TaurenMaleShamanNPC"] = "Achievement_Character_Tauren_Male",
	["TaurenMaleWarriorNPC"] = "Achievement_Character_Tauren_Male",
	["TaurenVocalFemale"] = "Achievement_Character_Tauren_Female",
	["TaurenVocalMale"] = "Achievement_Character_Tauren_Male",
	["Tauren_MountedCanoe"] = "Achievement_Character_Tauren_Male",
	["TavernAlliance"] = "",
	["TavernDwarf"] = "Achievement_Character_Dwarf_Female",
	["TavernHorde"] = "",
	["TavernHuman"] = "Achievement_Character_Human_Male",
	["TavernNightElf"] = "Achievement_Character_Nightelf_Male",
	["TavernOrc"] = "Achievement_Character_Orc_Male",
	["TavernPirate"] = "",
	["TavernTauren"] = "Achievement_Character_Tauren_Male",
	["TavernUndead"] = "Achievement_Character_Undead_Male",
	["TempestKeep"] = "",
	["TemporusTheUnraveller"] = "",
	["Tenebron"] = "",
	["TerestianIllhoof"] = "",
	["Terokkar"] = "",
	["TeronGorefiend"] = "",
	["Thaddius"] = "",
	["ThaladredTheDarkener"] = "",
	["ThalorienDawnseeker"] = "",
	["ThaneKorthazz"] = "",
	["Thassarian"] = "",
	["TheMaker"] = "",
	["Thief"] = "",
	["Thorim"] = "",
	["ThorngrinTheTender"] = "",
	["Thrall"] = "Achievement_Leader_ Thrall",
	["ThrallCoT"] = "Achievement_Leader_ Thrall",
	["ThrallCoTRaid"] = "Achievement_Leader_ Thrall",
	["Threshadon"] = "",
	["ThunderLizard"] = "",
	["Thunderaan"] = "",
	["Thunderbluff"] = "",
	["Tiger"] = "Ability_Mount_JungleTiger",
	["TigerCub"] = "Ability_Mount_JungleTiger",
	["TigonFemale"] = "",
	["TigonMale"] = "",
	["Time_Rift"] = "",
	["Tinhead"] = "",
	["TirionFordring"] = "Ability_Paladin_RighteousVengeance",
	["TitanFemale"] = "Achievement_Boss_Archaedas",
	["TitanMale"] = "Achievement_Boss_Archaedas",
	["TitanMale_Ghost"] = "Achievement_Boss_Archaedas",
	["TitanNPCGreetings"] = "Achievement_Boss_Archaedas",
	["TitanOrb_02"] = "Achievement_Boss_Archaedas",
	["TotemAll"] = "",
	["Tradeskills"] = "",
	["Trex"] = "",
	["Tripod"] = "",
	["Troglodyte"] = "",
	["Troll"] = "Achievement_Character_Troll_Male",
	["TrollDire"] = "Achievement_Character_Troll_Male",
	["TrollFemaleErrorMessages"] = "Achievement_Character_Troll_Female",
	["TrollFemaleFinal"] = "Achievement_Character_Troll_Female",
	["TrollFemaleLaidBackNPC"] = "Achievement_Character_Troll_Female",
	["TrollFemaleOldNPC"] = "Achievement_Character_Troll_Female",
	["TrollFemaleStandardNPC"] = "Achievement_Character_Troll_Female",
	["TrollMaleDarkNPC"] = "Achievement_Character_Troll_Male",
	["TrollMaleErrorMessages"] = "Achievement_Character_Troll_Male",
	["TrollMaleFinal"] = "Achievement_Character_Troll_Male",
	["TrollMaleShamanNPC"] = "Achievement_Character_Troll_Male",
	["TrollMaleStandardNPC"] = "Achievement_Character_Troll_Male",
	["TrollVocalFemale"] = "Achievement_Character_Troll_Female",
	["TrollVocalMale"] = "Achievement_Character_Troll_Male",
	["Trollgore"] = "Achievement_Character_Troll_Male",
	["TuskarrMale"] = "",
	["TwilightMasterKelris"] = "",
	["Tyral"] = "",
	["TyrandeWhisperwind"] = "Achievement_Leader_Tyrande_Whisperwind",
	["Ulduar"] = "Achievement_Dungeon_Ulduar77_25man",
	["UlduarRaidExt"] = "Achievement_Dungeon_Ulduar77_25man",
	["UlduarRaidInt"] = "Achievement_Dungeon_Ulduar77_25man",
	["Unarmed"] = "",
	["UndeadBeast"] = "Achievement_Character_Undead_Male",
	["UndeadDrake"] = "Ability_Mount_Drake_Twilight",
	["UndeadFemaleFinal"] = "Achievement_Character_Undead_Female",
	["UndeadFemaleMagicNPC"] = "Achievement_Character_Undead_Female",
	["UndeadFemaleStandardNPC"] = "Achievement_Character_Undead_Female",
	["UndeadFemaleWarriorNPC"] = "Achievement_Character_Undead_Female",
	["UndeadIceTroll"] = "Achievement_Character_Troll_Male",
	["UndeadMaleDarkNPC"] = "Achievement_Character_Undead_Male",
	["UndeadMaleFinal"] = "Achievement_Character_Undead_Male",
	["UndeadMaleNpc1"] = "Achievement_Character_Undead_Male",
	["UndeadMaleStandardNPC"] = "Achievement_Character_Undead_Male",
	["UndeadMaleWarriorNPC"] = "Achievement_Character_Undead_Male",
	["UndeadNPC"] = "Achievement_Character_Undead_Male",
	["Undead_Eagle"] = "",
	["Undercity"] = "",
	["Universal"] = "",
	["UseSounds"] = "",
	["Utgarde Keep"] = "Achievement_Dungeon_UtgardeKeep_10man",
	["Uther"] = "",
	["UtherLightbringer"] = "",
	["Vaelastrasz"] = "",
	["Valanar"] = "",
	["ValithriaDreamwalker"] = "",
	["Valkier"] = "",
	["VarianWrynn"] = "Achievement_Leader_King_Varian_Wrynn",
	["Varimathras"] = "",
	["VarosCloudstrider"] = "",
	["VazrudenTheHerald"] = "",
	["Vegard"] = "",
	["Vehicles"] = "",
	["VekLor"] = "",
	["VekNilash"] = "",
	["Velen"] = "Achievement_Leader_Prophet_Velen",
	["VerasDarkshadow"] = "",
	["Vesperon"] = "",
	["Vexallus"] = "",
	["VioletHold"] = "",
	["VoidGod"] = "",
	["VoidReaver"] = "",
	["VoidWalker"] = "",
	["VoidWalkerVO"] = "",
	["VoidlordPandemonius"] = "",
	["Voidwalker_VoidWraith"] = "",
	["Volcanic"] = "",
	["Voljin"] = "",
	["Volkhan"] = "",
	["VryKulMale"] = "",
	["VrykulFemale"] = "",
	["VrykulFemaleFrost"] = "",
	["WMOAmbience"] = "Achievement_Zone_DustwallowMarsh",
	["Walrus"] = "",
	["WarbringerOmrogg"] = "",
	["WarchiefKargath"] = "",
	["WardenMellichar"] = "",
	["WarlordKalithresh"] = "Achievement_Boss_Warlord_Kalithresh",
	["WarpSplinter"] = "",
	["WarpStalker"] = "",
	["WarpStorm"] = "",
	["WarriorSwings"] = "",
	["WatchkeeperGargolmar"] = "",
	["Water"] = "INV_Elemental_Primal_Water",
	["WaterElemental"] = "Spell_Frost_SummonWaterElemental_2",
	["WaterSplash"] = "INV_Elemental_Mote_Water01",
	["WeaponSwings"] = "",
	["Weapons"] = "Ability_Warrior_WeaponMastery",
	["Weather"] = "Spell_Shaman_ThunderStorm",
	["WellOFSouls"] = "",
	["Wendigo"] = "",
	["Whip"] = "",
	["Whisp"] = "INV_Misc_Herb_Whispervine",
	["Wight"] = "",
	["Wilfred"] = "",
	["WindSerpant"] = "Ability_Hunter_SnakeTrap",
	["WingFlapSmall"] = "",
	["WingFlaps"] = "",
	["WingedHorse"] = "",
	["Wisp"] = "INV_Misc_Herb_Whispervine",
	["Witch Doctor"] = "",
	["WitchDoctorZumrah"] = "",
	["Wolf"] = "Ability_Mount_BlackDireWolf",
	["Wolf Rider"] = "Ability_Mount_BlackDireWolf",
	["Wolf_Ghost"] = "Ability_Mount_BlackDireWolf",
	["Wolpertinger"] = "",
	["Wolvar"] = "Ability_Mount_BlackDireWolf",
	["Worgen"] = "Ability_Mount_BlackDireWolf",
	["WorldEvents"] = "",
	["WratchScryerSoccothrates"] = "",
	["WrathScryerAndDalliah"] = "",
	["Wyvern"] = "",
	["WyvernPet"] = "",
	["XT002Deconstructor"] = "",
	["Xevozz"] = "",
	["Yeti"] = "",
	["YoggSaron"] = "",
	["YoggSaronTentacles"] = "",
	["Ysera"] = "",
	["ZangarMarsh"] = "",
	["ZerekethTheUnbound"] = "",
	["ZerglingPet"] = "",
	["Zippelin"] = "",
	["Zombie"] = "",
	["ZombifiedVrykul"] = "",
	["ZoneAmbience"] = "Achievement_Zone_Duskwood",
	["ZoneMusic"] = "Achievement_Zone_BlastedLands_01",
	["ZulAmanGuard"] = "",
	["ZulDrak"] = "",
	["Zulaman"] = "",
	["ZuldrakGolem"] = "Ability_GolemThunderClap",
	["Zuljin"] = "Achievement_Boss_Zuljin",
	["ZuramatTheObliterator"] = "",
	["angelic"] = "",
	["baltharus"] = "",
	["battle"] = "",
	["boltcog"] = "",
	["bwonsamdi"] = "",
	["celestialhorse"] = "",
	["computer"] = "",
	["drakemount"] = "Ability_Mount_Drake_Red",
	["event"] = "",
	["flaminghippogryphmount"] = "",
	["flyingcarpetmount"] = "",
	["gloomy"] = "",
	["halion"] = "",
	["haunted"] = "",
	["magic"] = "",
	["mekkatorque"] = "",
	["mystery"] = "",
	["saviana"] = "",
	["spooky"] = "",
	["swamp"] = "",
	["thermaplugg"] = "",
	["turkey"] = "",
	["vanira"] = "",
	["xerestrasza"] = "",
	["zalazane"] = "",
	["zarithrian"] = "",
	["zentabra"] = "",
}