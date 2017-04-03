-- AddOn by Daîsey, Argent Dawn, Europe. Please give me credit when you want to redistribute or modify this addon! Contact: coenvdwel@planet.nl
-- Coen van der Wel, Almere, the Netherlands.

																							local rewatch_versioni = "5.3.1"; -- current revision



--------------------------------------------------------------------------------------------------------------[ FUNCTIONS ]----------------------

-- display a message to the user in the chat pane
-- msg: the message to pass onto the user
-- return: void
function rewatch_Message(msg)
	-- send the message to the chat pane, in yellow-ish
	DEFAULT_CHAT_FRAME:AddMessage(rewatch_loc["prefix"]..msg, 0.95, 0.85, 0.15);
	
	-- return
	return;
end;

-- displays a message to the user in the raidwarning frame
-- msg: the message to pass onto the user
-- return: void
function rewatch_RaidMessage(msg)
	-- send the message to the raid warning frame, in yellow-ish, too
	RaidNotice_AddMessage(RaidWarningFrame, msg, { r = 0.95, g = 0.85, b = 0.15 });
	
	-- return
	return;
end;

-- loads the internal vars from the savedvariables
-- return: void
function rewatch_OnLoad()
	-- reset changed var (options window)
	rewatch_ChangedDimentions = false;
	-- has been loaded before, get vars
	if(rewatch_load) then
		-- if the savedvariable data isn't corrupt
		if(	(rewatch_load["GcdAlpha"]) and (rewatch_load["HideSolo"]) and (rewatch_load["Hide"]) and
			(rewatch_load["AutoGroup"]) and (rewatch_load["FrameColor"]) and
			(rewatch_load["SpellBarWidth"]) and (rewatch_load["SpellBarHeight"]) and
			(rewatch_load["SpellBarMargin"]) and (rewatch_load["NumFramesWide"]) and (rewatch_load["SmallButtonWidth"]) and
			(rewatch_load["SmallButtonHeight"]) and (rewatch_load["SmallButtonMargin"])
		) then
			-- if the user is using a version before 5.0, enforce default dimentions
			local update = (rewatch_version == nil);
			if(update) then
				rewatch_load["SpellBarWidth"] = 90;
				rewatch_load["SpellBarHeight"] = 9;
				rewatch_load["SmallButtonWidth"] = 18;
				rewatch_load["SmallButtonHeight"] = 18;
				rewatch_load["SmallButtonMargin"] = 0;
				rewatch_load["WildGrowth"] = 1;
				rewatch_load["ClassColors"] = {
					DEATHKNIGHT = {r=0.77;g=0.12;b=0.23};
					DRUID = {r=1.00;g=0.49;b=0.04};
					HUNTER = {r=0.67;g=0.83;b=0.45};
					MAGE = {r=0.41;g=0.80;b=0.94};
					PALADIN = {r=0.96;g=0.55;b=0.73};
					PRIEST = {r=1.00;g=1.00;b=1.00};
					ROGUE = {r=1.00;g=0.96;b=0.41};
					SHAMAN = {r=0.14;g=0.35;b=1.00};
					WARLOCK = {r=0.58;g=0.51;b=0.79};
					WARRIOR = {r=0.78;g=0.61;b=0.43}
				}
				rewatch_load["Font"] = "GameFontHighlightSmall";
				rewatch_load["BarColor"..rewatch_loc["lifebloom"]] = { r=0; g=0; b=0.8};
				rewatch_load["BarColor"..rewatch_loc["rejuvenation"]] = { r=0.85; g=0.15; b=0.80};
				rewatch_load["BarColor"..rewatch_loc["regrowth"]] = { r=0.05; g=0.3; b=0.1};
				rewatch_load["BarColor"..rewatch_loc["wildgrowth"]] = { r=0.5; g=0.8; b=0.3};
			end;
			-- update changes from 5.0 to 5.0.1
			update = update or (rewatch_version == "5.0");
			if(update) then
				rewatch_load["HealthBarHeight"] = 18;
				rewatch_load["SpellBarHeight"] = 9;
				rewatch_load["BarColor"..rewatch_loc["lifebloom"]] = { r=0.6; g=0; b=0};
				rewatch_load["BarColor"..rewatch_loc["lifebloom"].."2"] = { r=1; g=0.5; b=0};
				rewatch_load["BarColor"..rewatch_loc["lifebloom"].."3"] = { r=0; g=0; b=0.8};
				rewatch_load["Labels"] = 0;
			end;
			-- update changes from 5.0.1/5.0.2 to 5.1
			update = update or (rewatch_version == "5.0.1") or (rewatch_version == "5.0.2");
			if(update) then
				rewatch_load["SideBar"] = 5;
			end;
			-- update changes from 5.1 to 5.2
			update = update or (rewatch_version == "5.1");
			if(update) then
				rewatch_load["HealthDeficit"] = 1;
				rewatch_load["DeficitThreshold"] = 0; rewatch_load["SideBar"] = 5;
				rewatch_load["SmallButtonHeight"] = 19; rewatch_load["SmallButtonWidth"] = 19;
			end;
			-- update changes from 5.2/5.2.1 to 5.2.2
			update = update or (rewatch_version == "5.2") or (rewatch_version == "5.2.1");
			if(update) then
				rewatch_load["ForcedHeight"] = 0;
				rewatch_load["OORAlpha"] = 0.3;
				rewatch_load["NameCharLimit"] = 0;
				rewatch_load["HealthColor"] = { r=0; g=0.7; b=0};
				rewatch_load["MaxPlayers"] = 0;
			end;
			update = update or (rewatch_version == "5.2.2") or (rewatch_version == "5.2.3") or (rewatch_version == "5.2.4");
			if(update) then
				rewatch_load["MarkFrameColor"] = { r=0; g=1; b=0; a=0.7 };
			end;
			update = update or (rewatch_version == "5.2.5");
			if(update) then
				rewatch_load["Highlighting"] = { "Frost Blast" };
			end;
			update = update or (rewatch_version == "5.2.6");
			if(update) then
				rewatch_load["ShowButtons"] = 1;
			end;
			update = update or (rewatch_version == "5.2.7");
			update = update or (rewatch_version == "5.2.8");
			update = update or (rewatch_version == "5.2.9");
			if(update) then
				rewatch_load["Highlighting2"] = { "Incinerate Flesh" };
				rewatch_load["Highlighting3"] = { "Mark of the Fallen Champion" };
			end;
			update = update or (rewatch_version == "5.2.10");
			update = update or (rewatch_version == "5.2.11");
			if(update) then
				rewatch_load["ShowTooltips"] = 1;
			end;
			update = update or (rewatch_version == "5.3");
			-- set internal vars from loaded vars
			rewatch_loadInt["Loaded"] = true;
			rewatch_loadInt["GcdAlpha"] = rewatch_load["GcdAlpha"];
			rewatch_loadInt["HideSolo"] = rewatch_load["HideSolo"];
			rewatch_loadInt["Hide"] = rewatch_load["Hide"];
			rewatch_loadInt["AutoGroup"] = rewatch_load["AutoGroup"];
			rewatch_loadInt["WildGrowth"] = rewatch_load["WildGrowth"];
			rewatch_loadInt["HealthColor"] = rewatch_load["HealthColor"];
			rewatch_loadInt["FrameColor"] = rewatch_load["FrameColor"];
			rewatch_loadInt["MarkFrameColor"] = rewatch_load["MarkFrameColor"];
			rewatch_loadInt["MaxPlayers"] = rewatch_load["MaxPlayers"];
			rewatch_loadInt["Highlighting"] = rewatch_load["Highlighting"];
			rewatch_loadInt["Highlighting2"] = rewatch_load["Highlighting2"];
			rewatch_loadInt["Highlighting3"] = rewatch_load["Highlighting3"];
			rewatch_loadInt["ShowButtons"] = rewatch_load["ShowButtons"];
			rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]] = rewatch_load["BarColor"..rewatch_loc["lifebloom"]];
			rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"] = rewatch_load["BarColor"..rewatch_loc["lifebloom"].."2"];
			rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"] = rewatch_load["BarColor"..rewatch_loc["lifebloom"].."3"];
			rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]] = rewatch_load["BarColor"..rewatch_loc["rejuvenation"]];
			rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]] = rewatch_load["BarColor"..rewatch_loc["regrowth"]];
			rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]] = rewatch_load["BarColor"..rewatch_loc["wildgrowth"]];
			rewatch_loadInt["Labels"] = rewatch_load["Labels"];
			rewatch_loadInt["ShowTooltips"] = rewatch_load["ShowTooltips"];
			rewatch_loadInt["NameCharLimit"] = rewatch_load["NameCharLimit"];
			rewatch_loadInt["Font"] = rewatch_load["Font"];
			rewatch_loadInt["ForcedHeight"] = rewatch_load["ForcedHeight"];
			rewatch_loadInt["OORAlpha"] = rewatch_load["OORAlpha"];
			rewatch_loadInt["SideBar"] = rewatch_load["SideBar"];
			rewatch_loadInt["HealthDeficit"] = rewatch_load["HealthDeficit"];
			rewatch_loadInt["DeficitThreshold"] = rewatch_load["DeficitThreshold"];
			rewatch_loadInt["ClassColors"] = rewatch_load["ClassColors"];
			rewatch_loadInt["SpellBarWidth"] = rewatch_load["SpellBarWidth"];
			rewatch_loadInt["SpellBarHeight"] = rewatch_load["SpellBarHeight"];
			rewatch_loadInt["HealthBarHeight"] = rewatch_load["HealthBarHeight"];
			rewatch_loadInt["SpellBarMargin"] = rewatch_load["SpellBarMargin"];
			rewatch_loadInt["NumFramesWide"] = rewatch_load["NumFramesWide"];
			rewatch_loadInt["SmallButtonWidth"] = rewatch_load["SmallButtonWidth"];
			rewatch_loadInt["SmallButtonHeight"] = rewatch_load["SmallButtonHeight"];
			rewatch_loadInt["SmallButtonMargin"] = rewatch_load["SmallButtonMargin"];
			-- apply possible changes
			rewatch_loadInt["FrameWidth"] = max(rewatch_loadInt["SpellBarWidth"]+rewatch_loadInt["SideBar"], rewatch_loadInt["SmallButtonMargin"]*4+rewatch_loadInt["SmallButtonWidth"]*5);
			rewatch_loadInt["FrameHeight"] = (rewatch_loadInt["SpellBarMargin"] + rewatch_loadInt["SpellBarHeight"])*(3+rewatch_loadInt["WildGrowth"]) + ((rewatch_loadInt["SmallButtonHeight"] + rewatch_loadInt["SmallButtonMargin"])*rewatch_loadInt["ShowButtons"]) + rewatch_loadInt["SpellBarMargin"] + rewatch_loadInt["HealthBarHeight"];
			for _, cd in ipairs(rewatch_gcds) do cd:SetAlpha(rewatch_loadInt["GcdAlpha"]); end;
			for i=1,rewatch_i-1 do local val = rewatch_bars[i]; if(val) then val["Frame"]:SetBackdropColor(rewatch_loadInt["FrameColor"].r, rewatch_loadInt["FrameColor"].g, rewatch_loadInt["FrameColor"].b, rewatch_loadInt["FrameColor"].a); end; end;
			if(((rewatch_i == 2) and (rewatch_loadInt["HideSolo"] == 1)) or (rewatch_loadInt["Hide"] == 1)) then rewatch_f[1]:Hide(); else rewatch_ShowFrame(); end;
			rewatch_SetAbs(); rewatch_OptionsFromData(true); rewatch_UpdateSwatch();
			-- set current version
			rewatch_version = rewatch_versioni;
		-- or if it's modified/outdated, reset it
		else rewatch_load = nil; rewatch_version = nil; end;
	-- not loaded before, initialise and welcome new user
	else
		rewatch_load = {};
		rewatch_load["GcdAlpha"], rewatch_load["HideSolo"], rewatch_load["Hide"], rewatch_load["AutoGroup"] = 1, 0, 0, 1;
		rewatch_load["HealthColor"] = { r=0; g=0.7; b=0};
		rewatch_load["FrameColor"] = { r=0; g=0; b=0; a=0.3 };
		rewatch_load["MarkFrameColor"] = { r=0; g=1; b=0; a=1 };
		rewatch_load["BarColor"..rewatch_loc["lifebloom"]] = { r=0.6; g=0; b=0};
		rewatch_load["BarColor"..rewatch_loc["lifebloom"].."2"] = { r=1; g=0.5; b=0};
		rewatch_load["BarColor"..rewatch_loc["lifebloom"].."3"] = { r=0; g=0; b=0.8};
		rewatch_load["BarColor"..rewatch_loc["rejuvenation"]] = { r=0.85; g=0.15; b=0.80};
		rewatch_load["BarColor"..rewatch_loc["regrowth"]] = { r=0.05; g=0.3; b=0.1};
		rewatch_load["BarColor"..rewatch_loc["wildgrowth"]] = { r=0.5; g=0.8; b=0.3};
		rewatch_load["Labels"] = 0; rewatch_load["SideBar"] = 5;
		rewatch_load["SpellBarWidth"] = 90; rewatch_load["SpellBarHeight"] = 9;
		rewatch_load["HealthBarHeight"] = 18; rewatch_load["SpellBarMargin"] = 0;
		rewatch_load["NumFramesWide"] = 5; rewatch_load["SmallButtonMargin"] = 0;
		rewatch_load["SmallButtonHeight"] = 19; rewatch_load["SmallButtonWidth"] = 19;
		rewatch_load["WildGrowth"] = 1; rewatch_load["Font"] = "GameFontHighlightSmall";
		rewatch_load["HealthDeficit"] = 1; rewatch_load["DeficitThreshold"] = 0;
		rewatch_load["ForcedHeight"] = 0; rewatch_load["OORAlpha"] = 0.3;
		rewatch_load["NameCharLimit"] = 0; rewatch_load["MaxPlayers"] = 0;
		rewatch_load["Highlighting"] = { "Frost Blast" };
		rewatch_load["Highlighting2"] = { "Incinerating Flesh" };
		rewatch_load["Highlighting2"] = { "Mark of the Fallen Champion" };
		rewatch_load["ShowButtons"] = 1;
		rewatch_load["ShowTooltips"] = 1;
		rewatch_load["ClassColors"] = {
			DEATHKNIGHT = {r=0.77;g=0.12;b=0.23};
			DRUID = {r=1.00;g=0.49;b=0.04};
			HUNTER = {r=0.67;g=0.83;b=0.45};
			MAGE = {r=0.41;g=0.80;b=0.94};
			PALADIN = {r=0.96;g=0.55;b=0.73};
			PRIEST = {r=1.00;g=1.00;b=1.00};
			ROGUE = {r=1.00;g=0.96;b=0.41};
			SHAMAN = {r=0.14;g=0.35;b=1.00};
			WARLOCK = {r=0.58;g=0.51;b=0.79};
			WARRIOR = {r=0.78;g=0.61;b=0.43}
		}
		rewatch_Message(rewatch_loc["welcome"]); rewatch_RaidMessage(rewatch_loc["welcome"]);
		-- set current version
		rewatch_version = rewatch_versioni;
	end;
end;

-- cut a name by the specified name character limit
-- name: the name to be cut
-- return: the cut name
function rewatch_CutName(name)
	if((rewatch_loadInt["NameCharLimit"] == 0) or (name:len() < rewatch_loadInt["NameCharLimit"])) then return name;
	else return name:sub(1, rewatch_loadInt["NameCharLimit"]); end;
end;

-- set the ability data
-- return: void
function rewatch_SetAbs()
	rewatch_abs = {
		[rewatch_loc["lifebloom"]] = {
			Duration = 7;
			Offset = 0;
		};
		[rewatch_loc["rejuvenation"]] = {
			Duration = 15;
			Offset = 0;
		};
		[rewatch_loc["regrowth"]] = {
			Duration = 21;
			Offset = 0;
		};
		[rewatch_loc["wildgrowth"]] = {
			Duration = 7;
			Offset = 0;
		};
		[rewatch_loc["swiftmend"]] = {
			Duration = 15;
			Offset = 0;
		};
		[rewatch_loc["abolishpoison"]] = {
			Duration = 1.5;
			Offset = 1;
		};
		[rewatch_loc["removecurse"]] = {
			Duration = 1.5;
			Offset = 2;
		};
		[rewatch_loc["healingtouch"]] = {
			Duration = 1.5;
			Offset = 3;
		};
		[rewatch_loc["nourish"]] = {
			Duration = 1.5;
			Offset = 4;
		};
	};
end;

-- update frame dimentions by changes in component sizes/margins
-- return: void
function rewatch_UpdateOffset()
	rewatch_loadInt["FrameWidth"] = max(rewatch_loadInt["SpellBarWidth"]+rewatch_loadInt["SideBar"], rewatch_loadInt["SmallButtonMargin"]*4+rewatch_loadInt["SmallButtonWidth"]*5);
	rewatch_loadInt["FrameHeight"] = (rewatch_loadInt["SpellBarMargin"] + rewatch_loadInt["SpellBarHeight"])*(3+rewatch_loadInt["WildGrowth"]) + ((rewatch_loadInt["SmallButtonHeight"] + rewatch_loadInt["SmallButtonMargin"])*rewatch_loadInt["ShowButtons"]) + rewatch_loadInt["SpellBarMargin"] + rewatch_loadInt["HealthBarHeight"];
end;

-- pops up the tooltip bar
-- data: the data to put in the tooltip. either a spell name or player name.
-- return: void
function rewatch_SetTooltip(data)
	-- ignore if not wanted
	if(rewatch_loadInt["ShowTooltips"] == 1) then
		-- is it a spell?
		local md = rewatch_GetSpellId(data);
		if(md < 0) then
			-- if not, then is it a player?
			md = rewatch_GetPlayer(data);
			if(md >= 0) then
				GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
				GameTooltip:SetUnit(rewatch_bars[md]["Player"]);
			end; -- do nothing with the tooltip if not
		else
			GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
			GameTooltip:SetSpell(md, BOOKTYPE_SPELL);
		end;
	end;
	
	-- return
	return;
end;

-- gets the spell ID of the highest rank of the specified spell
-- spellName: the name of the spell to get the highest ranked spellId from
-- return: the corresponding spellId
function rewatch_GetSpellId(spellName)
	-- get spell info and highest rank, return if the user can't cast it (not learned, etc)
	local name, rank, icon = GetSpellInfo(spellName);
	if(name == nil) then return -1; end;
	-- loop through all book spells, return the number if it matches above data
	local i, ispell, irank = 1, GetSpellName(1, BOOKTYPE_SPELL);
	repeat
		if ((ispell == name) and ((rank == irank) or (not irank))) then return i; end;
		i, ispell, irank = i+1, GetSpellName(i+1, BOOKTYPE_SPELL);
	until (not ispell);
	
	-- return default -1
	return -1;
end;

-- clears the entire list and resets it
-- return: void
function rewatch_Clear()
	-- call each playerframe's Hide method
	for i=1,rewatch_i-1 do local val = rewatch_bars[i]; if(val) then rewatch_HidePlayer(i); end; end;
	rewatch_bars = nil; rewatch_bars = {}; rewatch_i = 1;
	
	-- return
	return;
end;

-- get the number of the supplied player's place in the player table, or -1
-- player: name of the player to search for
-- return: the supplied player's table index, or -1 if not found
function rewatch_GetPlayer(player)
	-- prevent nil entries
	if(not player) then return; end;
	-- for every seen player; return if the name matches the supplied name
	local guid = UnitGUID(player);
	-- ignore pet guid; this changes sometimes
	if(not UnitIsPlayer(player)) then guid = false; end;
	-- browse list and return corresponding id
	for i=1,rewatch_i-1 do local val = rewatch_bars[i]; if(val) then
		if(not guid) then
			if(val["Player"] == player) then return i; end;
		elseif(val["UnitGUID"] == guid) then return i;
		-- recognise pets (Playername-pet != Petname)
		elseif(val["Pet"]) then if(UnitGUID(val["Player"]) == UnitGUID(player)) then return i; end;
		-- load bug, UnitGUID returns nil when not fully loaded, even on "player"
		elseif((player == UnitName("player")) and (not val["UnitGUID"])) then val["UnitGUID"] = guid; return i; end;
	end; end;
	
	-- return -1 if not found
	return -1;
end;

-- checks if the player or pet is in the group
-- player: name of the player or pet to check for
-- return: true, if the player is the user, or in the user's party or raid (or pet); false elsewise
function rewatch_InGroup(player)

	-- catch a self-check; return true if searching for the user itself
	if(UnitName("player") == player) then return true;
	else
		-- strip possible -pet suffix
		--if(player:sub(-4) == "-pet") then
		--	rewatch_Message("referring "..player:sub(1, -4));
		--	return rewatch_InGroup(player:sub(1, -5));
		-- process by environment (party or raid)
		--else
		if(GetNumRaidMembers() > 0) then if(UnitPlayerOrPetInRaid(player)) then return true; end;
		elseif(GetNumPartyMembers() > 0) then if(UnitPlayerOrPetInParty(player)) then return true; end;
		end;
	end;
	
	-- return
	return false;
end;

-- colors the frame corresponding to the player with playerid accordingly
-- playerId: the index number of the player in the player table
-- return: void
function rewatch_SetFrameBG(playerId)
	if(rewatch_bars[playerId]["Curse"]) then
		rewatch_bars[playerId]["Frame"]:SetBackdropColor(0.5, 0.0, 0.5, 1);
	elseif(rewatch_bars[playerId]["Poison"]) then
		rewatch_bars[playerId]["Frame"]:SetBackdropColor(0.0, 0.3, 0.0, 1);
	elseif(rewatch_bars[playerId]["Notify"]) then
		rewatch_bars[playerId]["Frame"]:SetBackdropColor(0.9, 0.8, 0.2, 1);
	elseif(rewatch_bars[playerId]["Notify2"]) then
		rewatch_bars[playerId]["Frame"]:SetBackdropColor(1.0, 0.5, 0.1, 1);
	elseif(rewatch_bars[playerId]["Notify3"]) then
		rewatch_bars[playerId]["Frame"]:SetBackdropColor(1.0, 0.0, 0.0, 1);
	elseif(rewatch_bars[playerId]["Mark"]) then
		rewatch_bars[playerId]["Frame"]:SetBackdropColor(rewatch_loadInt["MarkFrameColor"].r, rewatch_loadInt["MarkFrameColor"].g, rewatch_loadInt["MarkFrameColor"].b, rewatch_loadInt["MarkFrameColor"].a);
	else
		rewatch_bars[playerId]["Frame"]:SetBackdropColor(rewatch_loadInt["FrameColor"].r, rewatch_loadInt["FrameColor"].g, rewatch_loadInt["FrameColor"].b, rewatch_loadInt["FrameColor"].a);
	end;
end;

-- checks the druid buffs on players in your list
-- return: void
function rewatch_BuffCheck()
	-- check all listed players
	local thorns, motw = false, {};
	for i,val in ipairs(rewatch_bars) do if(val) then
		local thisMotw = false;
		for j=1,40 do
			local name = UnitBuff(val["Player"], j);
			if(thorns and thisMotw) then break; elseif(name == rewatch_loc["thorns"]) then thorns = true;
			elseif((name == rewatch_loc["markofthewild"]) or (name == rewatch_loc["giftofthewild"])) then thisMotw = true; end;
		end;
		if(not thisMotw) then table.insert(motw, val["Player"]); end;
	end; end;
	-- build report
	local msg = rewatch_loc["buffresults"].." ";
	if(not thorns) then msg = msg..rewatch_loc["nothorns"].." "; end;
	if(table.getn(motw) > 0) then
		msg = msg..rewatch_loc["missingmotw"].." "..motw[1];
		for i=2,table.getn(motw) do	msg = msg..", "..motw[i]; end;
	end;
	if((thorns) and (table.getn(motw) == 0)) then msg = msg.."Ok."; end;
	-- message the user
	rewatch_Message(msg);
	
	-- return
	return;
end;

-- trigger the cooldown overlays
-- return: void
function rewatch_TriggerCooldown()
	-- get global cooldown, and trigger it on all frames
	local start, duration, enabled = GetSpellCooldown(rewatch_loc["rejuvenation"]); -- some non-cd spell
	for _, cd in ipairs(rewatch_gcds) do
		CooldownFrame_SetTimer(cd, start, duration, enabled);
	end;
	
	-- return
	return;
end;

-- show the first rewatch frame, with the last 'flash' of the cooldown effect
-- return: void
function rewatch_ShowFrame()
	rewatch_f[1]:Show();
	for _, cd in ipairs(rewatch_gcds) do
		CooldownFrame_SetTimer(cd, GetTime()-1, 1.125, 1);
	end;
end;

-- adjusts the parent frame container's height
-- return: void
function rewatch_AlterFrame()
	-- forcedHeight mode only alters width
	if(rewatch_loadInt["ForcedHeight"] > 0) then
		rewatch_AlterFrameWidth();
	else
		-- set height and width according to number of frames
		local num = rewatch_f[1]:GetNumChildren()-1;
		local height = math.max(rewatch_loadInt["ForcedHeight"], math.ceil(num/rewatch_loadInt["NumFramesWide"])) * rewatch_loadInt["FrameHeight"];
		local width = math.min(rewatch_loadInt["NumFramesWide"],  math.max(num, 1)) * rewatch_loadInt["FrameWidth"];
		-- apply
		rewatch_f[1]:SetWidth(width); rewatch_f[1]:SetHeight(height+15);
		rewatch_gcds[1]:SetWidth(rewatch_f[1]:GetWidth()); rewatch_gcds[1]:SetHeight(rewatch_f[1]:GetHeight());
		-- hide/show on solo
		if(((num == 1) and (rewatch_loadInt["HideSolo"] == 1)) or (rewatch_loadInt["Hide"] == 1)) then rewatch_f[1]:Hide(); else rewatch_f[1]:Show(); end;
		-- make sure frames have a solid height and width (bugfix)
		for j=1,rewatch_i-1 do local val = rewatch_bars[j]; if(val) then
			if(not((val["Frame"]:GetWidth() == rewatch_loadInt["FrameWidth"]) and (val["Frame"]:GetHeight() == rewatch_loadInt["FrameHeight"]))) then
				val["Frame"]:SetWidth(rewatch_loadInt["FrameWidth"]); val["Frame"]:SetHeight(rewatch_loadInt["FrameHeight"]);
			end;
		end; end;
	end;
	
	-- return
	return;
end;

-- alter the frame width (instead of height) in forcedHeight mode (assumed)
-- return: void
function rewatch_AlterFrameWidth()
	-- get number of frames
	local num = rewatch_f[1]:GetNumChildren()-1;
	-- for each frame
	local framesPerY, maxPerY = {}, 0;
	for j=1,rewatch_i-1 do local val = rewatch_bars[j]; if(val) then
		-- save Y to list
		if(framesPerY[val["Frame"]:GetTop()]) then framesPerY[val["Frame"]:GetTop()] = framesPerY[val["Frame"]:GetTop()]+1; maxPerY = max(maxPerY, framesPerY[val["Frame"]:GetTop()]);
		else framesPerY[val["Frame"]:GetTop()] = 1; maxPerY = max(maxPerY, 1); end;
		-- make sure frames have a solid height and width (bugfix)
		if(not((val["Frame"]:GetWidth() == rewatch_loadInt["FrameWidth"]) and (val["Frame"]:GetHeight() == rewatch_loadInt["FrameHeight"]))) then
			val["Frame"]:SetWidth(rewatch_loadInt["FrameWidth"]); val["Frame"]:SetHeight(rewatch_loadInt["FrameHeight"]);
		end;
	end; end;
	-- set width according to number of frames
	rewatch_loadInt["NumFramesWide"] = maxPerY;
	local height = rewatch_loadInt["ForcedHeight"] * rewatch_loadInt["FrameHeight"];
	local width = math.min(rewatch_loadInt["NumFramesWide"],  math.max(num, 1)) * rewatch_loadInt["FrameWidth"];
	-- apply
	rewatch_f[1]:SetWidth(width+15); rewatch_f[1]:SetHeight(height);
	rewatch_gcds[1]:SetWidth(rewatch_f[1]:GetWidth()); rewatch_gcds[1]:SetHeight(rewatch_f[1]:GetHeight());
	-- hide/show on solo
	if(((num == 1) and (rewatch_loadInt["HideSolo"] == 1)) or (rewatch_loadInt["Hide"] == 1)) then rewatch_f[1]:Hide(); else rewatch_f[1]:Show(); end;
	
	-- return
	return;
end;

-- snap the supplied frame to the grid when it's placed on a rewatch_f frame
-- frame: the frame to snap to a grid
-- return: void
function rewatch_SnapToGrid(frame)
	-- return if in combat
	if(InCombatLockdown() == 1) then return -1; end;
	
	-- get parent frame
	local parent = frame:GetParent();
	if(parent ~= UIParent) then
		-- get frame's location relative to it's parent's
		local dx, dy = frame:GetLeft()-parent:GetLeft(), frame:GetTop()-parent:GetTop();
		-- make it snap (make dx a number closest to frame:GetWidth*n...)
		dx = math.floor((dx/(rewatch_loadInt["FrameWidth"] + rewatch_loadInt["SpellBarMargin"]))+0.5) * (rewatch_loadInt["FrameWidth"] + rewatch_loadInt["SpellBarMargin"]);
		dy = math.floor((dy/(rewatch_loadInt["FrameHeight"] + rewatch_loadInt["SpellBarMargin"]))+0.5) * (rewatch_loadInt["FrameHeight"] + rewatch_loadInt["SpellBarMargin"]);
		-- check if this is outside the frame, remove it
		if((dx < 0) or (dy > 0) or (dx+5 >= parent:GetWidth()) or ((dy*-1)+5 >= parent:GetHeight())) then
			-- remove it from it's parent
			frame:SetParent(UIParent); rewatch_AlterFrame();
			rewatch_Message(rewatch_loc["offFrame"]);
		-- if it's in the frame, move it
		else
			-- set id and get children
			frame:SetID(1337); local children = { parent:GetChildren() };
			-- move a frame to a new position if this frame covers it now
			for i, child in ipairs(children) do if(child:GetID() ~= 1337) then
				if((child:GetLeft() and (i>1))) then
					if((math.abs(dx - (child:GetLeft()-parent:GetLeft())) < 1) and (math.abs(dy - (child:GetTop()-parent:GetTop())) < 1)) then
						local x, y = rewatch_GetFramePos(parent); child:ClearAllPoints(); child:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y);
						child:SetPoint("BOTTOMRIGHT", parent, "TOPLEFT", x+rewatch_loadInt["FrameWidth"], y-rewatch_loadInt["FrameHeight"]); break;
					end;
				end;
			end; end;
			-- reset id and apply the snap location
			frame:SetID(0); frame:ClearAllPoints(); frame:SetPoint("TOPLEFT", parent, "TOPLEFT", dx, dy);
			frame:SetPoint("BOTTOMRIGHT", parent, "TOPLEFT", dx+rewatch_loadInt["FrameWidth"], dy-rewatch_loadInt["FrameHeight"]);
			-- now, if in forced height mode, recalculate frame width
			if(rewatch_loadInt["ForcedHeight"] > 0) then rewatch_AlterFrameWidth(); end;
		end;
	else
		-- check if there's need to snap it back onto the frame
		local dx, dy;
		for _, parent in ipairs(rewatch_f) do
			dx, dy = frame:GetLeft()-parent:GetLeft(), frame:GetTop()-parent:GetTop();
			if((dx > 0) and (dy < 0) and (dx < parent:GetWidth()) and (dy < parent:GetHeight())) then
				frame:SetParent(parent); rewatch_AlterFrame();
				rewatch_SnapToGrid(frame); rewatch_Message(rewatch_loc["backOnFrame"]);
			end;
		end;
	end;
	
	-- return
	return;
end;

-- return the first available empty spot in the frame
-- frame: the outline (parent) frame in which the player frame should be positioned
-- return: position coordinates; { x, y }
function rewatch_GetFramePos(frame)
	-- assume: there is at least one free position in the specified parent frame
	local children = { frame:GetChildren() }; local x, y, found = 0, 0, false;
	-- walk through the available spots, left to right, top to bottom
	for dy=0, 1-(ceil(frame:GetNumChildren()/rewatch_loadInt["NumFramesWide"])), -1 do for dx=0, rewatch_loadInt["NumFramesWide"]-1 do
		found, x, y = false, (rewatch_loadInt["FrameWidth"] + rewatch_loadInt["SpellBarMargin"])*dx, (rewatch_loadInt["FrameHeight"] + rewatch_loadInt["SpellBarMargin"])*dy;
		-- check if there's a frame here already
		for i, child in ipairs(children) do
			if((child:GetLeft() and (i>1))) then
				if((math.abs(x - (child:GetLeft()-frame:GetLeft())) < 1) and (math.abs(y - (child:GetTop()-frame:GetTop())) < 1)) then
					found = true; break; --[[ break for children loop ]] end;
			end;
		end;
		-- if not, we found a spot and we should break!
		if(not found) then break; --[[ break for dxloop ]] end;
	end; if(not found) then break; --[[ break for dy loop ]] end; end;
	
	-- return either the found spot, or a formula based on array positioning (fallback)
	if(found) then
		return frame:GetWidth()*((rewatch_i-1)%rewatch_loadInt["NumFramesWide"]), math.floor((rewatch_i-1)/rewatch_loadInt["NumFramesWide"]) * frame:GetHeight() * -1;
	else
		if(rewatch_loadInt["ForcedHeight"] > 0) then if(y < 1-frame:GetHeight()) then
			rewatch_loadInt["NumFramesWide"] = rewatch_loadInt["NumFramesWide"]+1;
			return rewatch_GetFramePos(frame);
		end; end;
		return x, y;
	end;
end;

-- compares the current player table to the party/raid schedule
-- return: void
function rewatch_ProcessGroup()
	local name, i, n, m;
	-- remove non-grouped players
	for i=1,rewatch_i-1 do if(rewatch_bars[i]) then
		if(not (rewatch_InGroup(rewatch_bars[i]["Player"]) or rewatch_bars[i]["Pet"])) then rewatch_HidePlayer(i); end;
	end; end;
	-- process raid group
	n = GetNumRaidMembers(); if(n > 0) then
		-- for each group, for each group member, if he's not in the list, add him
		for m=1, 8 do for i=1, n do
			name, _, subgroup = GetRaidRosterInfo(i) if((name) and (rewatch_GetPlayer(name) == -1) and (subgroup == m)) then rewatch_AddPlayer(name, nil); end;
		end; end;
	-- or, process party group
	elseif(GetNumPartyMembers() > 0) then 
		n = GetNumPartyMembers();
		-- for each group member, if he's not in the list, add him
		for i=1, n do name = UnitName("party"..i); if(rewatch_GetPlayer(name) == -1) then rewatch_AddPlayer(name, nil); end; end;
	-- or if none, remove all but yourself
	else rewatch_i = 2; end;
	
	-- return
	return;
end;

-- create a spell button with icon and add it to the global player table
-- spellName: the name of the spell to create a bar for (must be in rewatch_abs and have Offset)
-- playerId: the index number of the player in the player table
-- btnIcon: the string path and name with extention of the icon to use
-- above: the name of the rewatch_bars[n] key, referencing to the above castbar for layout
-- return: the created spell button reference
function rewatch_CreateButton(spellName, playerId, btnIcon, above)
	-- build button
	local button = CreateFrame("BUTTON", nil, rewatch_bars[playerId]["Frame"], "SecureActionButtonTemplate");
	button:SetWidth(rewatch_loadInt["SmallButtonWidth"]); button:SetHeight(rewatch_loadInt["SmallButtonHeight"]);
	button:SetPoint("TOPLEFT", rewatch_bars[playerId][above], "BOTTOMLEFT", (rewatch_loadInt["SmallButtonMargin"]+rewatch_loadInt["SmallButtonWidth"])*rewatch_abs[spellName]["Offset"], -1*rewatch_loadInt["SmallButtonMargin"] - rewatch_loadInt["SpellBarMargin"]);
	-- arrange clicking
	button:RegisterForClicks("LeftButtonDown", "RightButtonDown"); button:SetAttribute("unit", rewatch_bars[playerId]["Player"]); button:SetNormalTexture(btnIcon);
	button:SetAttribute("type1", "spell"); button:SetAttribute("spell1", spellName); button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square.blp");
	-- workaround for the WG bug
	if(spellName == rewatch_loc["wildgrowth"]) then
		button:SetAttribute("type1", "macro"); button:SetAttribute("macrotext1", "/cleartarget\n/cast [target=mouseover,exists,help]Wild Growth;Wild Growth\n/targetlasttarget");
	-- apply modifier-click for nature's swiftness
	elseif(spellName == rewatch_loc["healingtouch"]) then
		button:SetAttribute("*type1", "macro"); button:SetAttribute("*macrotext1", "/stopcasting\n/cast "..rewatch_loc["naturesswiftness"].."\n/stopcasting\n/cast [target=mouseover] "..rewatch_loc["healingtouch"]);
		button:SetAttribute("type2", "macro"); button:SetAttribute("macrotext2", "/stopcasting\n/cast "..rewatch_loc["naturesswiftness"].."\n/stopcasting\n/cast [target=mouseover] "..rewatch_loc["healingtouch"]);
	elseif(spellName == rewatch_loc["nourish"]) then
		button:SetAttribute("*type1", "macro"); button:SetAttribute("*macrotext1", "/stopcasting\n/cast "..rewatch_loc["naturesswiftness"].."\n/stopcasting\n/cast [target=mouseover] "..rewatch_loc["nourish"]);
		button:SetAttribute("type2", "macro"); button:SetAttribute("macrotext2", "/stopcasting\n/cast "..rewatch_loc["naturesswiftness"].."\n/stopcasting\n/cast [target=mouseover] "..rewatch_loc["nourish"]);
	elseif((spellName == rewatch_loc["abolishpoison"]) or (spellName == rewatch_loc["removecurse"])) then
		button:SetAlpha(0.15);
	end;
	-- apply tooltip support
	button:SetScript("OnEnter", function() rewatch_SetTooltip(spellName); end);
	button:SetScript("OnLeave", function() GameTooltip:Hide(); end);

	-- return
	return button;
end;

-- create a spell bar with text and add it to the global player table
-- spellName: the name of the spell to create a bar for (must be in rewatch_abs and have Offset)
-- playerId: the index number of the player in the player table
-- above: the name of the rewatch_bars[n] key, referencing to the above castbar for layout
-- return: the created spell bar reference
function rewatch_CreateBar(spellName, playerId, above)
	-- create the bar
	local b = CreateFrame("STATUSBAR", spellName..playerId, rewatch_bars[playerId]["Frame"], "TextStatusBar"); b:SetWidth(rewatch_loadInt["SpellBarWidth"]); b:SetHeight(rewatch_loadInt["SpellBarHeight"]);
	b:SetPoint("TOPLEFT", rewatch_bars[playerId][above], "BOTTOMLEFT", 0, -1*rewatch_loadInt["SpellBarMargin"]);
	b:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = false, tileSize = 1, edgeSize = 3, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	b:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar"); b:SetStatusBarColor(rewatch_loadInt["BarColor"..spellName].r, rewatch_loadInt["BarColor"..spellName].g, rewatch_loadInt["BarColor"..spellName].b, 1);
	b:SetBackdropColor(rewatch_loadInt["BarColor"..spellName].r, rewatch_loadInt["BarColor"..spellName].g, rewatch_loadInt["BarColor"..spellName].b, 0.25);
	-- if it's lifebloom
	if(spellName == rewatch_loc["lifebloom"]) then
		-- color frame background to 3rd stack of LB color
		b:SetBackdropColor(rewatch_loadInt["BarColor"..spellName.."3"].r, rewatch_loadInt["BarColor"..spellName.."3"].g, rewatch_loadInt["BarColor"..spellName.."3"].b, 0.25);
	end;
	-- set bar reach
	b:SetMinMaxValues(0, rewatch_abs[spellName]["Duration"]); b:SetValue(0);
	-- put text in bar
	b.text = b:CreateFontString("$parentText", "ARTWORK", rewatch_loadInt["Font"]);
	b.text:SetPoint("RIGHT", b); b.text:SetAllPoints();
	if(rewatch_loadInt["Labels"] == 1) then b.text:SetText(spellName); else b.text:SetText(""); end;
	-- overlay cast button
	local bc = CreateFrame("BUTTON", nil, b, "SecureActionButtonTemplate");
	bc:SetWidth(rewatch_loadInt["SpellBarWidth"]); bc:SetHeight(rewatch_loadInt["SpellBarHeight"]); bc:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0);
	bc:RegisterForClicks("LeftButtonDown", "RightButtonDown"); bc:SetAttribute("type1", "spell"); bc:SetAttribute("unit", rewatch_bars[playerId]["Player"]);
	bc:SetAttribute("spell1", spellName); bc:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square.blp");
	-- apply modifier-clicks for nature's swiftness on Regrowth bar only
	if(spellName == rewatch_loc["regrowth"]) then
		bc:SetAttribute("*type1", "macro"); bc:SetAttribute("*macrotext1", "/stopcasting\n/cast "..rewatch_loc["naturesswiftness"].."\n/stopcasting\n/cast [target=mouseover] "..rewatch_loc["regrowth"]);
		bc:SetAttribute("type2", "macro"); bc:SetAttribute("macrotext2", "/stopcasting\n/cast "..rewatch_loc["naturesswiftness"].."\n/stopcasting\n/cast [target=mouseover] "..rewatch_loc["regrowth"]);
	end;
	
	-- return the reference to the spell bar
	return b;
end;

-- update a bar by resetting spell duration
-- spellName: the name of the spell to reset it's duration from
-- player: player name
-- stacks: if given, the amount of LB stacks
-- return: void
function rewatch_UpdateBar(spellName, player, stacks)
	-- this shouldn't happen, but just in case
	if(not spellName) then return; end;
	
	-- get player
	local playerId = rewatch_GetPlayer(player);
	
	-- add if needed
    if(playerId < 0) then
        if((rewatch_loadInt["AutoGroup"] == 0) or (arg10 == rewatch_loc["wildgrowth"])) then return;
        else playerId = rewatch_AddPlayer(UnitName(player), nil); end;
		if(playerId < 0) then return; end;
    end;
	
	-- if the spell exists
	if(rewatch_bars[playerId][spellName]) then
		-- update lifebloom stack counter
		if(spellName == rewatch_loc["lifebloom"]) then
			if(stacks) then rewatch_bars[playerId]["LifebloomStacks"] = stacks;
			else rewatch_bars[playerId]["LifebloomStacks"] = 1; end;
			a = rewatch_bars[playerId]["LifebloomStacks"]; if(a == 1) then a = ""; end;
			rewatch_bars[playerId][rewatch_loc["lifebloom"].."Bar"]:SetStatusBarColor(rewatch_loadInt["BarColor"..spellName..a].r, rewatch_loadInt["BarColor"..spellName..a].g, rewatch_loadInt["BarColor"..spellName..a].b, 1);
		else
			rewatch_bars[playerId][spellName.."Bar"]:SetStatusBarColor(rewatch_loadInt["BarColor"..spellName].r, rewatch_loadInt["BarColor"..spellName].g, rewatch_loadInt["BarColor"..spellName].b, 1);
		end;
		-- get buff duration
		local a = select(7, UnitBuff(player, spellName, nil, "PLAYER"));
		local b = a - GetTime();
		-- set bar values
        rewatch_bars[playerId][spellName] = a;
		rewatch_bars[playerId][spellName.."Bar"]:SetMinMaxValues(0, b);
		rewatch_bars[playerId][spellName.."Bar"]:SetValue(b);
	end;
	
	-- return
	return;
end;

-- clear a bar back to 0 because it's been dispelled or removed
-- spellName: the name of the spell to reset it's duration from
-- playerId: the index number of the player in the player table
-- return: void
function rewatch_DowndateBar(spellName, playerId)
	-- if the spell exists for this player
	if(rewatch_bars[playerId][spellName]) then
		-- ignore if it's WG and we have no WG bar
		if((spellName == rewatch_loc["wildgrowth"]) and (not rewatch_bars[playerId][rewatch_loc["wildgrowth"].."Bar"])) then
			return;
		-- reset lifebloom stack counter
		elseif(spellName == rewatch_loc["lifebloom"]) then
			rewatch_bars[playerId]["LifebloomStacks"] = 0;
		end;
		-- reset bar values
		rewatch_bars[playerId][spellName] = 0;
		if(rewatch_loadInt["Labels"] == 0) then rewatch_bars[playerId][spellName.."Bar"].text:SetText(""); end;
		rewatch_bars[playerId][spellName.."Bar"]:SetValue(0);
	end;
	
	-- return
	return;
end;

-- add a player to the players table and create his bars and button
-- player: the name of the player
-- pet: if it's the pet of the named player ("pet" if so, nil if not)
-- return: the index number the player has been assigned
function rewatch_AddPlayer(player, pet)
	-- return if in combat or if the max amount of players is passed
	if((InCombatLockdown() == 1) or ((rewatch_loadInt["MaxPlayers"] > 0) and (rewatch_loadInt["MaxPlayers"] < rewatch_f[1]:GetNumChildren()))) then return -1; end;
	
	-- process pets
	if(pet) then
		player = player.."-pet"; pet = UnitName(player);
		if(pet) then player = pet; end; pet = true;
	else pet = false; end;
	-- prepare table
	rewatch_bars[rewatch_i] = {};
	-- build frame
	local x, y = rewatch_GetFramePos(rewatch_f[1]);
	local frame = CreateFrame("FRAME", nil, rewatch_f[1]); frame:SetWidth(rewatch_loadInt["FrameWidth"]); frame:SetHeight(rewatch_loadInt["FrameHeight"]);
	frame:SetPoint("TOPLEFT", rewatch_f[1], "TOPLEFT", x, y); frame:EnableMouse(true); frame:SetMovable(true);
	frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = nil, tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	frame:SetBackdropColor(rewatch_loadInt["FrameColor"].r, rewatch_loadInt["FrameColor"].g, rewatch_loadInt["FrameColor"].b, rewatch_loadInt["FrameColor"].a);
	frame:SetScript("OnMouseDown", function() if(not rewatch_loadInt["LockP"]) then frame:StartMoving(); rewatch_f[1]:SetBackdrop({bgFile = nil, edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 10, edgeSize = 10, insets = { left = 3, right = 3, top = 3, bottom = 3 }}); end; end);
	frame:SetScript("OnMouseUp", function() frame:StopMovingOrSizing(); rewatch_SnapToGrid(frame); rewatch_f[1]:SetBackdrop({bgFile = nil, edgeFile = nil, tile = 1, tileSize = 10, edgeSize = 10, insets = { left = 3, right = 3, top = 3, bottom = 3 }}); end);
	-- create player HP bar
	local statusbar = CreateFrame("STATUSBAR", nil, frame, "TextStatusBar"); statusbar:SetWidth(rewatch_loadInt["SpellBarWidth"]); statusbar:SetHeight(rewatch_loadInt["HealthBarHeight"]-4);
	statusbar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -1);
	statusbar:SetBackdrop({bgFile = nil, edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	statusbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar"); statusbar:SetStatusBarColor(rewatch_loadInt["HealthColor"].r, rewatch_loadInt["HealthColor"].g, rewatch_loadInt["HealthColor"].b, 1);
	statusbar:SetMinMaxValues(0, 1); statusbar:SetValue(0);
	-- class-color it / classcolor sidebar
	local _, class = UnitClass(player); if(class) then
		local ccsb = CreateFrame("FRAME", nil, frame); ccsb:SetWidth(rewatch_loadInt["SideBar"]); ccsb:SetHeight(rewatch_loadInt["FrameHeight"]-1);
		ccsb:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = nil, tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
		ccsb:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -1); ccsb:SetBackdropColor(rewatch_loadInt["ClassColors"][class].r, rewatch_loadInt["ClassColors"][class].g, rewatch_loadInt["ClassColors"][class].b, 1);
	end;
	-- put text in HP bar
	statusbar.text = statusbar:CreateFontString("$parentText", "ARTWORK", rewatch_loadInt["Font"]);
	statusbar.text:SetAllPoints(); statusbar.text:SetText(rewatch_CutName(player));
	-- energy/mana/rage bar
	local statusbar2 = CreateFrame("STATUSBAR", nil, frame, "TextStatusBar"); statusbar2:SetWidth(rewatch_loadInt["SpellBarWidth"]); statusbar2:SetHeight(4);
	statusbar2:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 4-rewatch_loadInt["HealthBarHeight"]);
	statusbar2:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 5, edgeSize = 5, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	statusbar2:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar"); statusbar2:SetMinMaxValues(0, 1); statusbar2:SetValue(0);
	-- color it correctly
	local pt = UnitPowerType(player);
	if(pt == 0) then statusbar2:SetStatusBarColor(0.0, 0.0, 0.6, 1);
	elseif(pt == 1) then statusbar2:SetStatusBarColor(0.6, 0.0, 0.0, 1);
	elseif(pt == 6) then statusbar2:SetStatusBarColor(0.85, 0.15, 0.8, 1);
	else statusbar2:SetStatusBarColor(0.95, 0.85, 0.15, 1); end;
	-- overlay target/remove button
	local tgb = CreateFrame("BUTTON", nil, statusbar, "SecureActionButtonTemplate");
	tgb:SetWidth(statusbar:GetWidth()); tgb:SetHeight(statusbar:GetHeight()); tgb:SetPoint("TOPLEFT", statusbar, "TOPLEFT", 0, 0);
	tgb:SetAttribute("type1", "target"); tgb:SetAttribute("unit", player); tgb:SetAttribute("*type1", "macro"); tgb:SetAttribute("*macrotext1", "/cast [target=mouseover,dead,combat] "..rewatch_loc["rebirth"].."; [target=mouseover,dead] "..rewatch_loc["revive"].."\n/stopmacro [target=mouseover,nodead]\n/say "..rewatch_loc["rez1"]..player..rewatch_loc["rez2"]);
	tgb:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square.blp");
	tgb:SetScript("OnMouseDown", function()
		if(arg1 == "RightButton") then
			rewatch_DropDown.relativeTo = frame; rewatch_RightClickMenuTable[1] = player;
			ToggleDropDownMenu(1, nil, rewatch_DropDown, "rewatch_DropDown", -10, -10);
		elseif(not rewatch_loadInt["LockP"]) then frame:StartMoving(); end;
	end);
	tgb:SetScript("OnMouseUp", function() if(not rewatch_loadInt["LockP"]) then frame:StopMovingOrSizing(); rewatch_SnapToGrid(frame); end; end);
	tgb:SetScript("OnEnter", function() rewatch_SetTooltip(player); rewatch_bars[rewatch_GetPlayer(player)]["Hover"] = 1; end);
	tgb:SetScript("OnLeave", function() GameTooltip:Hide(); rewatch_bars[rewatch_GetPlayer(player)]["Hover"] = 2; end);
	-- save player data
	rewatch_bars[rewatch_i]["UnitGUID"] = nil; if(UnitExists(player)) then rewatch_bars[rewatch_i]["UnitGUID"] = UnitGUID(player); end;
	rewatch_bars[rewatch_i]["Frame"] = frame; rewatch_bars[rewatch_i]["Player"] = player;
	rewatch_bars[rewatch_i]["PlayerBar"] = statusbar; rewatch_bars[rewatch_i]["ManaBar"] = statusbar2;
	rewatch_bars[rewatch_i]["Mark"] = false; rewatch_bars[rewatch_i]["Pet"] = pet;
	rewatch_bars[rewatch_i][rewatch_loc["lifebloom"]] = 0; rewatch_bars[rewatch_i]["LifebloomStacks"] = 0;
	rewatch_bars[rewatch_i][rewatch_loc["rejuvenation"]] = 0; rewatch_bars[rewatch_i][rewatch_loc["regrowth"]] = 0;
	rewatch_bars[rewatch_i][rewatch_loc["wildgrowth"]] = 0;
	rewatch_bars[rewatch_i][rewatch_loc["lifebloom"].."Bar"] = rewatch_CreateBar(rewatch_loc["lifebloom"], rewatch_i, "ManaBar");
	rewatch_bars[rewatch_i][rewatch_loc["rejuvenation"].."Bar"] = rewatch_CreateBar(rewatch_loc["rejuvenation"], rewatch_i, rewatch_loc["lifebloom"].."Bar");
	rewatch_bars[rewatch_i][rewatch_loc["regrowth"].."Bar"] = rewatch_CreateBar(rewatch_loc["regrowth"], rewatch_i, rewatch_loc["rejuvenation"].."Bar");
	pt = rewatch_loc["regrowth"].."Bar"; -- reusing var, but this holds the bar below which bottons are placed
	if(rewatch_loadInt["WildGrowth"] == 1) then
		pt = rewatch_loc["wildgrowth"].."Bar";
		rewatch_bars[rewatch_i][rewatch_loc["wildgrowth"].."Bar"] = rewatch_CreateBar(rewatch_loc["wildgrowth"], rewatch_i, rewatch_loc["regrowth"].."Bar");
	end;
	if(rewatch_loadInt["ShowButtons"] == 1) then
		rewatch_bars[rewatch_i]["SwiftmendButton"] = rewatch_CreateButton(rewatch_loc["swiftmend"], rewatch_i, "Interface\\Icons\\INV_Relics_IdolofRejuvenation.blp", pt);
			local smbcd = CreateFrame("Cooldown", "SwiftmendButtonCD"..rewatch_i, rewatch_bars[rewatch_i]["SwiftmendButton"], "CooldownFrameTemplate");
			rewatch_bars[rewatch_i]["SwiftmendButton"].cooldown = smbcd; smbcd:SetPoint("CENTER", 0, -1);
			smbcd:SetWidth(rewatch_bars[rewatch_i]["SwiftmendButton"]:GetWidth()); smbcd:SetHeight(rewatch_bars[rewatch_i]["SwiftmendButton"]:GetHeight()); smbcd:Hide();
		rewatch_bars[rewatch_i]["AbolishPoisonButton"] = rewatch_CreateButton(rewatch_loc["abolishpoison"], rewatch_i, "Interface\\Icons\\Spell_Nature_NullifyPoison_02.blp", pt);
			local apbcd = CreateFrame("Cooldown", "AbolishPoisonButtonCD"..rewatch_i, rewatch_bars[rewatch_i]["AbolishPoisonButton"], "CooldownFrameTemplate");
			rewatch_bars[rewatch_i]["AbolishPoisonButton"].cooldown = apbcd; apbcd:SetPoint("CENTER", 0, -1);
			apbcd:SetWidth(rewatch_bars[rewatch_i]["AbolishPoisonButton"]:GetWidth()); apbcd:SetHeight(rewatch_bars[rewatch_i]["AbolishPoisonButton"]:GetHeight()); apbcd:Hide();
		rewatch_bars[rewatch_i]["DecurseButton"] = rewatch_CreateButton(rewatch_loc["removecurse"], rewatch_i, "Interface\\Icons\\Spell_Shadow_Curse.blp", pt);
		rewatch_bars[rewatch_i]["HealingTouchButton"] = rewatch_CreateButton(rewatch_loc["healingtouch"], rewatch_i, "Interface\\Icons\\Spell_Nature_HealingTouch.blp", pt);
			local htbcd = CreateFrame("Cooldown", "HealingTouchButtonCD"..rewatch_i, rewatch_bars[rewatch_i]["HealingTouchButton"], "CooldownFrameTemplate");
			rewatch_bars[rewatch_i]["HealingTouchButton"].cooldown = htbcd; htbcd:SetPoint("CENTER", 0, -1);
			htbcd:SetWidth(rewatch_bars[rewatch_i]["HealingTouchButton"]:GetWidth()); htbcd:SetHeight(rewatch_bars[rewatch_i]["HealingTouchButton"]:GetHeight()); htbcd:Hide();
		rewatch_bars[rewatch_i]["NourishButton"] = rewatch_CreateButton(rewatch_loc["nourish"], rewatch_i, "Interface\\Icons\\Ability_Druid_Nourish.blp", pt);
			local nrbcd = CreateFrame("Cooldown", "NourishButtonCD"..rewatch_i, rewatch_bars[rewatch_i]["NourishButton"], "CooldownFrameTemplate");
			rewatch_bars[rewatch_i]["NourishButton"].cooldown = nrbcd; nrbcd:SetPoint("CENTER", 0, -1);
			nrbcd:SetWidth(rewatch_bars[rewatch_i]["NourishButton"]:GetWidth()); nrbcd:SetHeight(rewatch_bars[rewatch_i]["NourishButton"]:GetHeight()); nrbcd:Hide();
	end;
	rewatch_bars[rewatch_i]["Notify"] = nil; rewatch_bars[rewatch_i]["Notify2"] = nil; rewatch_bars[rewatch_i]["Notify3"] = nil;
	rewatch_bars[rewatch_i]["Curse"] = nil; rewatch_bars[rewatch_i]["Poison"] = nil; rewatch_bars[rewatch_i]["Class"] = class; rewatch_bars[rewatch_i]["Hover"] = 0;
	-- increment the global index
	rewatch_i = rewatch_i+1; rewatch_AlterFrame(); rewatch_SnapToGrid(frame);
	
	-- return the inserted player's player table index
	return rewatch_GetPlayer(player);
end;

-- hide all bars and buttons from - and the player himself, by name
-- player: the name of the player to hide
-- return: void
-- PRE: Called by specific user request
function rewatch_HidePlayerByName(player)
	if(InCombatLockdown() == 1) then rewatch_Message(rewatch_loc["combatfailed"]);
	else
		-- get the index of this player
		local playerId = rewatch_GetPlayer(player);
		-- if this player exists, hide all bars and buttons from - and the player himself
		if(playerId > 0) then
			-- check for others
			local others = false;
			for i=1,rewatch_i-1 do local val = rewatch_bars[i]; if(val) then
				if(i ~= playerId) then others = true; break; end;
			end; end;
			-- if there are other people in the frame
			if(others) then
				-- hide the player
				rewatch_HidePlayer(playerId);
				-- prevent auto-adding grouped players automatically
				if((rewatch_loadInt["AutoGroup"] == 1) and (rewatch_InGroup(player)) and UnitIsPlayer(player) and UnitIsConnected(player)) then
					rewatch_load["AutoGroup"], rewatch_loadInt["AutoGroup"] = 0, 0;
					rewatch_OptionsFromData(true);
					rewatch_Message(rewatch_loc["setautogroupauto0"]);
				end;
			else rewatch_Message(rewatch_loc["removefailed"]); end;
		end;
	end;
	
	-- return
	return;
end;

-- hide all bars and buttons from - and the player himself
-- playerId: the table index of the player to hide
-- return: void
function rewatch_HidePlayer(playerId)
	-- return if in combat
	if(InCombatLockdown() == 1) then return; end;
	
	-- remove the bar
	local parent = rewatch_bars[playerId]["Frame"]:GetParent();
	rewatch_bars[playerId]["PlayerBar"]:Hide();
	rewatch_bars[playerId][rewatch_loc["lifebloom"].."Bar"]:Hide();
	rewatch_bars[playerId][rewatch_loc["rejuvenation"].."Bar"]:Hide();
	if(rewatch_bars[playerId][rewatch_loc["wildgrowth"].."Bar"]) then
			rewatch_bars[playerId][rewatch_loc["wildgrowth"].."Bar"]:Hide();
	end;
	rewatch_bars[playerId][rewatch_loc["regrowth"].."Bar"]:Hide();
	if(rewatch_bars[playerId]["SwiftmendButton"]) then rewatch_bars[playerId]["SwiftmendButton"]:Hide(); end;
	if(rewatch_bars[playerId]["AbolishPoisonButton"]) then rewatch_bars[playerId]["AbolishPoisonButton"]:Hide(); end;
	if(rewatch_bars[playerId]["DecurseButton"]) then rewatch_bars[playerId]["DecurseButton"]:Hide(); end;
	if(rewatch_bars[playerId]["HealingTouchButton"]) then rewatch_bars[playerId]["HealingTouchButton"]:Hide(); end;
	if(rewatch_bars[playerId]["NourishButton"]) then rewatch_bars[playerId]["NourishButton"]:Hide(); end;
	rewatch_bars[playerId]["Frame"]:Hide();
	rewatch_bars[playerId]["Frame"]:SetParent(nil);
	rewatch_bars[playerId] = nil;
	
	-- update the frame width/height
	if(parent ~= UIParent) then rewatch_AlterFrame(); end;
	
	-- return
	return;
end;

-- process highlighting
function rewatch_ProcessHighlight(spell, player, highlighting, notify)
	if(not rewatch_loadInt[highlighting]) then return false; end;
	for _, b in ipairs(rewatch_loadInt[highlighting]) do
		if(spell == b) then
			playerId = rewatch_GetPlayer(player);
			if(playerId > 0) then
				rewatch_bars[playerId][notify] = spell; rewatch_SetFrameBG(playerId);
				return true;
			end;
		end;
	end;
	return false;
end;

-- build a frame
-- return: void
function rewatch_BuildFrame()
	-- create it
	local frame = CreateFrame("FRAME", "Rewatch_Frame"..table.getn(rewatch_f), UIParent);
	-- set proper dimentions and location
	frame:SetWidth(100); frame:SetHeight(100); frame:SetPoint("CENTER", UIParent);
	frame:EnableMouse(true); frame:SetMovable(true);
	-- set looks
	frame:SetBackdrop({bgFile = nil, edgeFile = nil, tile = 1, tileSize = 10, edgeSize = 10, insets = { left = 3, right = 3, top = 3, bottom = 3 }});
	-- make it draggable
	frame:SetScript("OnMouseDown", function()
		if(arg1 == "RightButton") then
			if(rewatch_loadInt["Lock"]) then
				rewatch_loadInt["Lock"] = false; rewatch_OptionsFromData(true);
				rewatch_Message(rewatch_loc["unlocked"]);
			else
				rewatch_loadInt["Lock"] = true; rewatch_OptionsFromData(true);
				rewatch_Message(rewatch_loc["locked"]);
			end;
		else if(not rewatch_loadInt["Lock"]) then frame:StartMoving(); end; end;
	end);
	frame:SetScript("OnMouseUp", function() frame:StopMovingOrSizing(); end);
	frame:SetScript("OnEnter", function () frame:SetBackdrop({bgFile = nil, edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = 1, tileSize = 10, edgeSize = 10, insets = { left = 3, right = 3, top = 3, bottom = 3 }}); end);
	frame:SetScript("OnLeave", function () frame:SetBackdrop({bgFile = nil, edgeFile = nil, tile = 1, tileSize = 10, edgeSize = 10, insets = { left = 3, right = 3, top = 3, bottom = 3 }}); end);
	-- add the frame to the table
	table.insert(rewatch_f, frame);
	-- create cooldown overlay and add it to it's own table
	local gcd = CreateFrame("Cooldown", "FrameCD", frame, "CooldownFrameTemplate"); gcd:SetAlpha(1);
	gcd:SetPoint("CENTER", 0, -1); gcd:SetWidth(frame:GetWidth()); gcd:SetHeight(frame:GetHeight()); gcd:Hide();
	table.insert(rewatch_gcds, gcd);
	
	-- return
	return;
end;

-- process the sent commands
-- cmd: the command that has to be executed
-- return: void
function rewatch_SlashCommandHandler(cmd)
	-- when there's a command typed
	if(cmd) then
		-- declaration and initialisation
		local pos, commands = 0, {};
		for st, sp in function() return string.find(cmd, " ", pos, true) end do
			table.insert(commands, string.sub(cmd, pos, st-1));
			pos = sp + 1;
		end; table.insert(commands, string.sub(cmd, pos));
		-- on a help request, reply with the localisation help table
		if(string.lower(commands[1]) == "help") then
			for _,val in ipairs(rewatch_loc["help"]) do
				rewatch_Message(val);
			end;
		-- if the user wants to add a player manually
		elseif(string.lower(commands[1]) == "add") then
			if(InCombatLockdown() == 1) then rewatch_Message(rewatch_loc["combatfailed"]);
			elseif(commands[2]) then
				if(rewatch_GetPlayer(commands[2]) < 0) then
					if(rewatch_InGroup(commands[2])) then rewatch_AddPlayer(commands[2], nil);
					elseif(commands[3]) then
						if(string.lower(commands[3]) == "always") then rewatch_AddPlayer(commands[2], nil);
						else rewatch_Message(rewatch_loc["notingroup"]); end;
					else rewatch_Message(rewatch_loc["notingroup"]); end;
				end;
			elseif(UnitName("target")) then if(rewatch_GetPlayer(UnitName("target")) < 0) then rewatch_AddPlayer(UnitName("target"), nil); end;
			else rewatch_Message(rewatch_loc["noplayer"]); end;
		-- if the user wants to resort the list (clear and processgroup)
		elseif(string.lower(commands[1]) == "sort") then
			if(rewatch_loadInt["AutoGroup"] == 0) then
				rewatch_Message(rewatch_loc["nosort"]);
			else
				if(InCombatLockdown() == 1) then rewatch_Message(rewatch_loc["combatfailed"]);
				else
					rewatch_Clear(); rewatch_changed = true;
					rewatch_Message(rewatch_loc["sorted"]);
				end;
			end;
		-- if the user wants to clear the player list
		elseif(string.lower(commands[1]) == "clear") then
			if(InCombatLockdown() == 1) then rewatch_Message(rewatch_loc["combatfailed"]);
			else rewatch_Clear(); rewatch_Message(rewatch_loc["cleared"]); end;
		-- allow setting the forced height
		elseif(string.lower(commands[1]) == "forcedheight") then
			if(tonumber(commands[2])) then
				rewatch_loadInt["ForcedHeight"] = tonumber(commands[2]); rewatch_load["ForcedHeight"] = rewatch_loadInt["ForcedHeight"];
				rewatch_loadInt["NumFramesWide"] = rewatch_load["NumFramesWide"];
				rewatch_Message("Forced height to "..rewatch_load["ForcedHeight"]..". Set to 0 to set to autosizing."); rewatch_AlterFrame();
			end;
		-- allow setting the max amount of players to be in the list
		elseif(string.lower(commands[1]) == "maxplayers") then
			if(tonumber(commands[2])) then
				rewatch_loadInt["MaxPlayers"] = tonumber(commands[2]); rewatch_load["MaxPlayers"] = rewatch_loadInt["MaxPlayers"];
				rewatch_Message("Set max players to "..rewatch_load["MaxPlayers"]..". Set to 0 to ignore the maximum."); rewatch_changed = true;
			end;
		-- if the user wants to set the gcd alpha
		elseif(string.lower(commands[1]) == "gcdalpha") then
			if(not tonumber(commands[2])) then rewatch_Message(rewatch_loc["nonumber"]);
			elseif((tonumber(commands[2]) < 0) or (tonumber(commands[2]) > 1)) then rewatch_Message(rewatch_loc["nonumber"]);
			else
				rewatch_load["GcdAlpha"] = tonumber(commands[2]); rewatch_loadInt["GcdAlpha"] = rewatch_load["GcdAlpha"];
				for _, cd in ipairs(rewatch_gcds) do cd:SetAlpha(rewatch_loadInt["GcdAlpha"]); end;
				rewatch_OptionsFromData(true);
				rewatch_Message(rewatch_loc["setalpha"]..commands[2]);
			end;
		-- if the user wants to set the hide solo feature
		elseif(string.lower(commands[1]) == "hidesolo") then
			if(not((commands[2] == "0") or (commands[2] == "1"))) then rewatch_Message(rewatch_loc["nonumber"]);
			else
				rewatch_load["HideSolo"] = tonumber(commands[2]); rewatch_loadInt["HideSolo"] = rewatch_load["HideSolo"];
				if(((rewatch_i == 2) and (rewatch_load["HideSolo"] == 1)) or (rewatch_load["Hide"] == 1)) then rewatch_f[1]:Hide(); else rewatch_ShowFrame(); end;
				rewatch_OptionsFromData(true);
				rewatch_Message(rewatch_loc["sethidesolo"..commands[2]]);
			end;
		-- if the user wants to set the hide feature
		elseif(string.lower(commands[1]) == "hide") then
			rewatch_load["Hide"] = 1; rewatch_loadInt["Hide"] = rewatch_load["Hide"];
			if(((rewatch_i == 2) and (rewatch_load["HideSolo"] == 1)) or (rewatch_load["Hide"] == 1)) then rewatch_f[1]:Hide(); else rewatch_ShowFrame(); end;
			rewatch_OptionsFromData(true); rewatch_Message(rewatch_loc["sethide1"]);
		elseif(string.lower(commands[1]) == "show") then
			rewatch_load["Hide"] = 0; rewatch_loadInt["Hide"] = rewatch_load["Hide"];
			if(((rewatch_i == 2) and (rewatch_load["HideSolo"] == 1)) or (rewatch_load["Hide"] == 1)) then rewatch_f[1]:Hide(); else rewatch_ShowFrame(); end;
			rewatch_OptionsFromData(true); rewatch_Message(rewatch_loc["sethide0"]);
		-- if the user wants to set the autoadjust list to group feature
		elseif(string.lower(commands[1]) == "autogroup") then
			if(not((commands[2] == "0") or (commands[2] == "1"))) then rewatch_Message(rewatch_loc["nonumber"]);
			else
				rewatch_load["AutoGroup"] = tonumber(commands[2]); rewatch_loadInt["AutoGroup"] = rewatch_load["AutoGroup"];
				rewatch_OptionsFromData(true);
				rewatch_Message(rewatch_loc["setautogroup"..commands[2]]);
				rewatch_changed = true;
			end;
		-- if the user wants to use the lock feature
		elseif(string.lower(commands[1]) == "lock") then
			rewatch_loadInt["Lock"] = true; rewatch_OptionsFromData(true);
			rewatch_Message(rewatch_loc["locked"]);
		-- if the user wants to use the unlock feature
		elseif(string.lower(commands[1]) == "unlock") then
			rewatch_loadInt["Lock"] = false; rewatch_OptionsFromData(true);
			rewatch_Message(rewatch_loc["unlocked"]);
		-- if the user wants to use the player lock feature
		elseif(string.lower(commands[1]) == "lockp") then
			rewatch_loadInt["LockP"] = true; rewatch_OptionsFromData(true);
			rewatch_Message(rewatch_loc["lockedp"]);
		-- if the user wants to use the player unlock feature
		elseif(string.lower(commands[1]) == "unlockp") then
			rewatch_loadInt["LockP"] = false; rewatch_OptionsFromData(true);
			rewatch_Message(rewatch_loc["unlockedp"]);
		-- if the user demanded a druid buff check
		elseif(string.lower(commands[1]) == "check") then
			rewatch_BuffCheck();
		-- if the user wants to check his version
		elseif(string.lower(commands[1]) == "version") then
			rewatch_Message("Rewatch v"..rewatch_versioni);
		-- if the user wants to toggle the settings GUI
		elseif(string.lower(commands[1]) == "options") then
			rewatch_ChangedDimentions = false;
			InterfaceOptionsFrame_OpenToCategory("Rewatch");
		-- if the user wants something else (unsupported)
		elseif(string.len(commands[1]) > 0) then rewatch_Message(rewatch_loc["invalid_command"]);
		else rewatch_Message(rewatch_loc["credits"]); end;
	-- if there's no command typed
	else rewatch_Message(rewatch_loc["credits"]); end;
	
	-- return
	return;
end;



--------------------------------------------------------------------------------------------------------------[ SCRIPT ]-------------------------


-- make the addon stop here if the user isn't a druid
if((select(2, UnitClass("player"))) ~= "DRUID") then return; end;

-- build event logger
rewatch_events = CreateFrame("FRAME", nil, UIParent); rewatch_events:SetWidth(0); rewatch_events:SetHeight(0);
rewatch_events:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED"); rewatch_events:RegisterEvent("PARTY_MEMBERS_CHANGED");
rewatch_events:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE"); rewatch_events:RegisterEvent("UPDATE_SHAPESHIFT_FORM");

-- initialise all vars
rewatch_ChangedDimentions = false;
rewatch_f, rewatch_bars, rewatch_abs, rewatch_i, rewatch_RightClickMenuTable, rewatch_DropDown = {},  {}, {}, 1, {}, nil;
rewatch_loadInt = {
	Loaded = false; GcdAlpha = 1; HideSolo = 0; AutoGroup = 1; FrameColor = { r=0; g=0; b=0; a=0.3 }; MarkFrameColor = { r=0; g=1; b=0; a=0.3 }; HealthColor = { r=0; g=0.7; b=0 };
	SpellBarWidth = 75; SpellBarHeight = 8; SpellBarMargin = 0; NumFramesWide = 5; SmallButtonWidth = 19; SmallButtonHeight = 19; SmallButtonMargin = 1; FrameWidth = 1; FrameHeight = 1;
	Lock = false; LockP = false; ShowButtons = 1; WildGrowth = 1; Font = "GameFontHighlightSmall"; HealthBarHeight = 18; Labels = 0; SideBar = 7; ForcedHeight = 0; OORAlpha = 0.3; NameCharLimit = 0; MaxPlayers = 0
};

rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"]] = { r=0; g=0; b=0 }; rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."2"] = { r=0; g=0; b=0 }; rewatch_loadInt["BarColor"..rewatch_loc["lifebloom"].."3"] = { r=0; g=0; b=0 };
rewatch_loadInt["BarColor"..rewatch_loc["rejuvenation"]] = { r=0; g=0; b=0 }; rewatch_loadInt["BarColor"..rewatch_loc["regrowth"]] = { r=0; g=0; b=0 }; rewatch_loadInt["BarColor"..rewatch_loc["wildgrowth"]] = { r=0; g=0; b=0 };
rewatch_gcds, rewatch_changed, rewatch_options = {}, true, nil;

-- add the slash command handler
SLASH_REWATCH1 = "/rewatch";
SLASH_REWATCH2 = "/rew";
SlashCmdList["REWATCH"] = function(cmd)
	rewatch_SlashCommandHandler(cmd);
end;

-- create the outline frame
rewatch_BuildFrame();

-- create the rightclick menu frame
rewatch_RightClickMenuTable = { "", "Remove player", "Add his/her pet", "Mark this player", "Lock playerframes", "Close menu" };
rewatch_DropDown = CreateFrame("FRAME", "rewatch_DropDownFrame", nil, "UIDropDownMenuTemplate");
rewatch_DropDown.point = "TOPLEFT";
rewatch_DropDown.relativePoint = "TOPRIGHT";
rewatch_DropDown.displayMode = "MENU";
rewatch_DropDown.relativeTo = rewatch_f[1];
local playerId;
UIDropDownMenu_Initialize(rewatch_DropDownFrame, function(self)
	for i, title in ipairs(rewatch_RightClickMenuTable) do
		local info = UIDropDownMenu_CreateInfo();
		info.isTitle = (i == 1); info.notCheckable = ((i < 2) or (i > 5));
		info.text = title; info.value = i; info.owner = rewatch_DropDown;
		if(i == 4) then
			playerId = rewatch_GetPlayer(rewatch_RightClickMenuTable[1]);
			if(playerId >= 0) then info.checked = rewatch_bars[playerId]["Mark"]; end;
		end;
		if(i == 5) then info.checked = rewatch_loadInt["LockP"]; end;
		info.func = function(self)
			if(self.value == 2) then rewatch_HidePlayerByName(rewatch_RightClickMenuTable[1]);
			elseif(self.value == 3) then
				rewatch_AddPlayer(rewatch_RightClickMenuTable[1], "pet");
			elseif(self.value == 4) then
				playerId = rewatch_GetPlayer(rewatch_RightClickMenuTable[1]);
				if(playerId) then rewatch_bars[playerId]["Mark"] = not rewatch_bars[playerId]["Mark"]; end;
				rewatch_SetFrameBG(playerId);
			elseif(self.value == 5) then
				rewatch_loadInt["LockP"] = (not self.checked); if(rewatch_loadInt["LockP"]) then rewatch_Message(rewatch_loc["lockedp"]); else rewatch_Message(rewatch_loc["unlockedp"]); end;
				rewatch_OptionsFromData(true);
			end; 
		end;
		UIDropDownMenu_AddButton(info);
	end;
end, "MENU");
UIDropDownMenu_SetWidth(rewatch_DropDown, 90);

-- create options
rewatch_CreateOptions();

-- make sure we catch events and process them
local status, r, g, b, a, val, left, i, debuffType;
rewatch_events:SetScript("OnEvent", function(timestamp, event, ...)
	-- only process if properly loaded
	if(not rewatch_loadInt["Loaded"]) then
		return;
	-- if the group/raid the player is in has changed
	elseif(event == "PARTY_MEMBERS_CHANGED") then		
		rewatch_changed = true;
	-- update threat
	elseif(event == "UNIT_THREAT_SITUATION_UPDATE") then
		if(arg1) then
			playerId = rewatch_GetPlayer(UnitName(arg1));
			if(playerId >= 0) then
				val = rewatch_bars[playerId];
				if(val["UnitGUID"]) then
					status = UnitThreatSituation(val["Player"]);
					if(status == 0) then val["PlayerBar"].text:SetTextColor(1, 1, 1, 1);
					else r, g, b = GetThreatStatusColor(status); val["PlayerBar"].text:SetTextColor(r, g, b, 1); end;
				end;
			end;
		end;
	-- so first of all, check spell_aura_applied for the wild growth buff
	elseif((arg2 == "SPELL_AURA_APPLIED_DOSE") or (arg2 == "SPELL_AURA_APPLIED") or (arg2 == "SPELL_AURA_REFRESH")) then
		--  ignore heals on non-party-/raidmembers
		if(not rewatch_InGroup(arg7)) then return; end;
		-- if it was a HoT being applied
		if((arg3 == UnitGUID("player")) and (((arg10 == rewatch_loc["wildgrowth"]) and (rewatch_loadInt["WildGrowth"] == 1)) or (arg10 == rewatch_loc["regrowth"]) or (arg10 == rewatch_loc["rejuvenation"]) or (arg10 == rewatch_loc["lifebloom"]))) then
			-- bugfix LB stack event
			if(arg2 == "SPELL_AURA_APPLIED") then arg13 = 1;
			elseif(arg2 == "SPELL_AURA_REFRESH") then arg13 = 3; end;
			-- update the spellbar
			rewatch_UpdateBar(arg10, arg7, arg13);
		-- if it's a spell that needs custom highlighting, notify by highlighting player frame
		elseif(rewatch_ProcessHighlight(arg10, arg7, "Highlighting", "Notify")) then
		elseif(rewatch_ProcessHighlight(arg10, arg7, "Highlighting2", "Notify2")) then
		elseif(rewatch_ProcessHighlight(arg10, arg7, "Highlighting3", "Notify3")) then
			-- ignore further, already processed it
		-- else, if it was abolish poison
		elseif((arg3 == UnitGUID("player")) and (arg10 == rewatch_loc["abolishpoison"])) then
			playerId = rewatch_GetPlayer(arg7);
			if(playerId < 0) then return; end;
			if(rewatch_bars[playerId]["AbolishPoisonButton"]) then
				rewatch_bars[playerId]["AbolishPoisonButton"]:SetAlpha(1);
				CooldownFrame_SetTimer(rewatch_bars[playerId]["AbolishPoisonButton"].cooldown, GetTime(), 12, 1);
			end;
		-- else, if it was a debuff applied
		elseif(arg12 == "DEBUFF") then
			-- get the player position, or if -1, return
			playerId = rewatch_GetPlayer(arg7);
			if(playerId < 0) then return; end;
			-- get the debuff type
			_, _, _, _, debuffType = UnitDebuff(arg7, arg10);
			-- process it
			if(debuffType == "Curse") then
				rewatch_bars[playerId]["Curse"] = arg10; if(rewatch_bars[playerId]["DecurseButton"]) then rewatch_bars[playerId]["DecurseButton"]:SetAlpha(1); end; rewatch_SetFrameBG(playerId);
			elseif(debuffType == "Poison") then
				rewatch_bars[playerId]["Poison"] = arg10; if(rewatch_bars[playerId]["AbolishPoisonButton"]) then rewatch_bars[playerId]["AbolishPoisonButton"]:SetAlpha(1); end; rewatch_SetFrameBG(playerId);
			end;
		-- else, if it was a bear/cat shapeshift
		elseif((arg10 == rewatch_loc["bearForm"]) or (arg10 == rewatch_loc["direBearForm"]) or (arg10 == rewatch_loc["catForm"])) then
			-- get the player position, or if -1, return
			playerId = rewatch_GetPlayer(arg7);
			if(playerId < 0) then return; end;
			-- if it was cat, make it yellow
			if(arg10 == rewatch_loc["catForm"]) then
				rewatch_bars[playerId]["ManaBar"]:SetStatusBarColor(0.95, 0.85, 0.15, 1);
			-- else, it was bear form, make it red
			else
				rewatch_bars[playerId]["ManaBar"]:SetStatusBarColor(0.6, 0.0, 0.0, 1);
			end;
		end;
	-- if an aura faded
	elseif((arg2 == "SPELL_AURA_REMOVED") or (arg2 == "SPELL_AURA_DISPELLED") or (arg2 == "SPELL_AURA_REMOVED_DOSE")) then
		--  ignore non-party-/raidmembers
		if(not rewatch_InGroup(arg7)) then return; end;
		-- get the player position
		playerId = rewatch_GetPlayer(arg7);
		-- if it doesn't exists, stop
		if(playerId < 0) then -- nuffin!
		-- or, if a HoT runs out / has been dispelled, process it
		elseif((arg3 == UnitGUID("player")) and ((arg10 == rewatch_loc["regrowth"]) or (arg10 == rewatch_loc["rejuvenation"]) or (arg10 == rewatch_loc["lifebloom"]) or (arg10 == rewatch_loc["wildgrowth"]))) then
			rewatch_DowndateBar(arg10, playerId);
		-- or, resume abolish poison button to normal alpha
		elseif(rewatch_loc["abolishpoison"] == arg10) then
			if(rewatch_bars[playerId]["AbolishPoisonButton"]) then rewatch_bars[playerId]["AbolishPoisonButton"]:SetAlpha(0.15); end;
		-- or, process nature's swiftness CD pie on HT button
		elseif(rewatch_loc["naturesswiftness"] == arg10) then
			for i=1,rewatch_i-1 do val = rewatch_bars[i]; if(val) then
				CooldownFrame_SetTimer(val["HealingTouchButton"].cooldown, GetTime(), 180, 1);
			end; end;
		-- or, process it if it is the applied curse or poison or something else to be notified about
		elseif(rewatch_bars[playerId]["Curse"] == arg10) then
			rewatch_bars[playerId]["Curse"] = nil; if(rewatch_bars[playerId]["DecurseButton"]) then rewatch_bars[playerId]["DecurseButton"]:SetAlpha(0.15); end; rewatch_SetFrameBG(playerId);
		elseif(rewatch_bars[playerId]["Poison"] == arg10) then
			rewatch_bars[playerId]["Poison"] = nil; if(rewatch_bars[playerId]["AbolishPoisonButton"]) then rewatch_bars[playerId]["AbolishPoisonButton"]:SetAlpha(0.15); end; rewatch_SetFrameBG(playerId);
		elseif(rewatch_bars[playerId]["Notify"] == arg10) then
			rewatch_bars[playerId]["Notify"] = nil; rewatch_SetFrameBG(playerId);
		elseif(rewatch_bars[playerId]["Notify2"] == arg10) then
			rewatch_bars[playerId]["Notify2"] = nil; rewatch_SetFrameBG(playerId);
		elseif(rewatch_bars[playerId]["Notify3"] == arg10) then
			rewatch_bars[playerId]["Notify3"] = nil; rewatch_SetFrameBG(playerId);
		-- else, if it was a bear/cat shapeshift
		elseif((arg10 == rewatch_loc["bearForm"]) or (arg10 == rewatch_loc["direBearForm"]) or (arg10 == rewatch_loc["catForm"])) then
			rewatch_bars[playerId]["ManaBar"]:SetStatusBarColor(0.0, 0.0, 0.6, 1);
		end;
	-- if an other spell was cast successfull by the user or a heal has been received
	elseif((arg2 == "SPELL_CAST_SUCCESS") or (arg2 == "SPELL_HEAL")) then
		-- if it was your spell/heal
		if(arg3 == UnitGUID("player")) then
			rewatch_TriggerCooldown();
			-- if a swiftmend was received
			if((arg10 == rewatch_loc["swiftmend"]) and (arg2 == "SPELL_HEAL")) then
				--  ignore heals on non-party-/raidmembers
				if(not rewatch_InGroup(arg7)) then return; end;
				-- trigger all cooldown overlays of every player's swiftmend button
				if(rewatch_loadInt["ShowButtons"] == 1) then
					b, g, r = GetSpellCooldown(rewatch_loc["swiftmend"]);
					for i=1,rewatch_i-1 do val = rewatch_bars[i]; if(val) then
						CooldownFrame_SetTimer(val["SwiftmendButton"].cooldown, b, g, r);
					end; end;
				end;
			end;
		end;	
	-- if it's Rebirth
	elseif((arg2 == "SPELL_RESURRECT") and (arg10 == rewatch_loc["rebirth"]) and (arg3 == UnitGUID("player"))) then
		rewatch_TriggerCooldown();
		for i=1,rewatch_i-1 do val = rewatch_bars[i]; if(val) then
			CooldownFrame_SetTimer(val["NourishButton"].cooldown, GetTime(), 600, 1);
		end; end;
	end;
	
	-- return
	return;
end);

-- update everything
rewatch_events:SetScript("OnUpdate", function()
	-- load saved vars
	if(not rewatch_loadInt["Loaded"]) then
		rewatch_OnLoad();
	else
		-- if the group formation has been changed, add new group members to the list
		if(rewatch_changed) then
			if(rewatch_loadInt["AutoGroup"] == 1) then
				if(InCombatLockdown() ~= 1) then
					if((GetNumRaidMembers() == 0) and (GetNumPartyMembers() == 0)) then rewatch_Clear(); end;
					if(rewatch_i == 1) then rewatch_AddPlayer(UnitName("player"), nil); end;
					rewatch_ProcessGroup(); rewatch_changed = nil;
				end;
			end;
		end;
		-- process updates
		for i=1,rewatch_i-1 do val = rewatch_bars[i];
			-- if this player exists
			if(val) then
				-- clear buffs if the player just died
				if(UnitIsDeadOrGhost(val["Player"])) then
					if(select(4, val["PlayerBar"]:GetStatusBarColor()) > 0.6) then
						val["PlayerBar"]:SetStatusBarColor(0.5, 0.5, 0.5, 0.5);
						val["PlayerBar"].text:SetTextColor(1, 1, 1, 1); val["ManaBar"]:SetValue(0); val["PlayerBar"]:SetValue(0);
						if(val["Mark"]) then
							val["Frame"]:SetBackdropColor(rewatch_loadInt["MarkFrameColor"].r, rewatch_loadInt["MarkFrameColor"].g, rewatch_loadInt["MarkFrameColor"].b, rewatch_loadInt["MarkFrameColor"].a);
						else
							val["Frame"]:SetBackdropColor(rewatch_loadInt["FrameColor"].r, rewatch_loadInt["FrameColor"].g, rewatch_loadInt["FrameColor"].b, rewatch_loadInt["FrameColor"].a);
						end;
						val["LifebloomStacks"] = 0; val["PlayerBar"].text:SetText(rewatch_CutName(val["Player"]));
						if(rewatch_loadInt["Labels"] == 0) then
							val[rewatch_loc["rejuvenation"].."Bar"].text:SetText("");
							val[rewatch_loc["regrowth"].."Bar"].text:SetText("");
							val[rewatch_loc["lifebloom"].."Bar"].text:SetText("");
							if(val[rewatch_loc["wildgrowth"].."Bar"]) then
								val[rewatch_loc["wildgrowth"].."Bar"].text:SetText("");
							end;
						end;
						val[rewatch_loc["rejuvenation"]] = 0; val[rewatch_loc["rejuvenation"].."Bar"]:SetValue(0);
						val[rewatch_loc["regrowth"]] = 0; val[rewatch_loc["regrowth"].."Bar"]:SetValue(0);
						val[rewatch_loc["lifebloom"]] = 0; val[rewatch_loc["lifebloom"].."Bar"]:SetValue(0);
						if(val[rewatch_loc["wildgrowth"].."Bar"]) then
							val[rewatch_loc["wildgrowth"]] = 0; val[rewatch_loc["wildgrowth"].."Bar"]:SetValue(0);
						end;
						val["Notify"] = nil; val["Notify2"] = nil; val["Notify3"] = nil;
						val["Poison"] = nil; val["Curse"] = nil; val["Frame"]:SetAlpha(0.2);
						if(val["AbolishPoisonButton"]) then val["AbolishPoisonButton"]:SetAlpha(0.15); val["DecurseButton"]:SetAlpha(0.15); end;
					end;
					-- else, unit's dead and processed, ignore him now
				else
					-- get and set health data
					a, b = UnitHealthMax(val["Player"]), UnitHealth(val["Player"]);
					val["PlayerBar"]:SetMinMaxValues(0, a); val["PlayerBar"]:SetValue(b);
					-- set healthbar color accordingly
					if(a == b) then val["PlayerBar"]:SetStatusBarColor(rewatch_loadInt["HealthColor"].r, rewatch_loadInt["HealthColor"].g, rewatch_loadInt["HealthColor"].b, 1);
					elseif(b/a < .25) then val["PlayerBar"]:SetStatusBarColor(0.6, 0.0, 0.0, 1);
					elseif(b/a < .50) then val["PlayerBar"]:SetStatusBarColor(0.6, 0.6, 0.0, 1);
					else val["PlayerBar"]:SetStatusBarColor(rewatch_loadInt["HealthColor"].r, rewatch_loadInt["HealthColor"].g, rewatch_loadInt["HealthColor"].b, 0.8); end;
					-- update text if needed
					if(rewatch_loadInt["HealthDeficit"] >= 0) then
						if(rewatch_loadInt["HealthDeficit"] == 0) then rewatch_loadInt["HealthDeficit"] = -1; end;
						g = rewatch_CutName(val["Player"]); if(val["Hover"] == 1) then g = string.format("%i/%i", b, a); elseif(val["Hover"] == 2) then val["Hover"] = 0; end;
						if((val["Hover"] == 0) and ((a-b) > (rewatch_loadInt["DeficitThreshold"]*1000))) then
							if(rewatch_loadInt["HealthDeficit"] > 1) then g = g.."\n"; else g = g.." "; end;
							g = g..string.format("%#.1f", (b-a)/1000).."k";
						end; val["PlayerBar"].text:SetText(g);
					else
						if(val["Hover"] == 1) then val["PlayerBar"].text:SetText(string.format("%i/%i", b, a));
						elseif(val["Hover"] == 2) then val["PlayerBar"].text:SetText(rewatch_CutName(val["Player"])); val["Hover"] = 0; end;
					end;
					-- get and set mana data
					a, b = UnitPowerMax(val["Player"]), UnitPower(val["Player"]);
					val["ManaBar"]:SetMinMaxValues(0, a); val["ManaBar"]:SetValue(b);
					-- fade when out of range
					if(IsSpellInRange(rewatch_loc["rejuvenation"], val["Player"]) == 1) then val["Frame"]:SetAlpha(1); else val["Frame"]:SetAlpha(rewatch_loadInt["OORAlpha"]); end;
					-- current time
					a = GetTime();
					-- rejuvenation bar process
					left = val[rewatch_loc["rejuvenation"]]-a;
					if(left > 0) then
						val[rewatch_loc["rejuvenation"].."Bar"]:SetValue(left);
						if(rewatch_loadInt["Labels"] == 0) then val[rewatch_loc["rejuvenation"].."Bar"].text:SetText(string.format("%.00f", left)); end;
						if(math.abs(left-2)<0.1) then val[rewatch_loc["rejuvenation"].."Bar"]:SetStatusBarColor(0.6, 0.0, 0.0, 1); end;
					end;
					-- regrowth bar process
					left = rewatch_bars[i][rewatch_loc["regrowth"]]-a;
					if(left > 0) then
						val[rewatch_loc["regrowth"].."Bar"]:SetValue(left);
						if(rewatch_loadInt["Labels"] == 0) then val[rewatch_loc["regrowth"].."Bar"].text:SetText(string.format("%.00f", left)); end;
						if(math.abs(left-2)<0.1) then val[rewatch_loc["regrowth"].."Bar"]:SetStatusBarColor(0.6, 0.0, 0.0, 1); end;
					end;
					-- lifebloom bar process
					left = rewatch_bars[i][rewatch_loc["lifebloom"]]-a;
					if(left > 0) then
						val[rewatch_loc["lifebloom"].."Bar"]:SetValue(left);
						if(rewatch_loadInt["Labels"] == 0) then val[rewatch_loc["lifebloom"].."Bar"].text:SetText(string.format("%.00f", left)); end;
						if(math.abs(left-2)<0.1) then val[rewatch_loc["lifebloom"].."Bar"]:SetStatusBarColor(0.6, 0.0, 0.0, 1); end;
					end;
					-- wild growth bar process
					if(val[rewatch_loc["wildgrowth"].."Bar"]) then
						left = rewatch_bars[i][rewatch_loc["wildgrowth"]]-a;
						if(left > 0) then
							val[rewatch_loc["wildgrowth"].."Bar"]:SetValue(left);
							if(rewatch_loadInt["Labels"] == 0) then val[rewatch_loc["wildgrowth"].."Bar"].text:SetText(string.format("%.00f", left)); end;
							if(math.abs(left-2)<0.1) then val[rewatch_loc["wildgrowth"].."Bar"]:SetStatusBarColor(0.6, 0.0, 0.0, 1); end;
						end;
					end;
				end;
			end;
		end;
	end;
	
	-- return
	return;
end);