

-------------------------------------------------------------------------------
--                              GearScore                                    --
--                            Version 3.1.20                                --
--								Mirrikat45                                   --
-------------------------------------------------------------------------------

-- Fixed a bug with the CharactherStat pane not loading correctly.
-- Added Spirit to list of approved stats for Paladins - The spec checking should still be ignored.
-- Added a check which will cause the addon to fail to load when Cataclysm is released.

------------------------------------------------------------------------------
function GearScore_OnUpdate(self, elapsed)
--Code use to Function Timing of Transmition Information--
	if not GSX_Timer then GSX_Timer = 0; end
	GSX_Timer = GSX_Timer + elapsed
	if GSX_Timer >= 0.5 then
		GSX_Timer = 0
		self:Hide()
  		GearScore_ContinueExchange()
	end
end

function GearScore_ThrottleUpdate(self, elapsed)
--Code use to Function Timing of Transmition Information--
	if not GS_ThrottleTimer then GS_ThrottleTimer = 0; end
	GS_ThrottleTimer = GS_ThrottleTimer + elapsed
	if GS_ThrottleTimer >= 1 then
	    GearScoreChatMessageThrottle = 0
		GS_ThrottleTimer = 0
	end
end

function GearScore_OnEvent(GS_Nil, GS_EventName, GS_Prefix, GS_AddonMessage, GS_Whisper, GS_Sender)
	if ( GS_EventName == "PLAYER_REGEN_ENABLED" ) then GS_PlayerIsInCombat = false; return; end
	if ( GS_EventName == "PLAYER_REGEN_DISABLED" ) then GS_PlayerIsInCombat = true; return; end
	if ( GS_EventName == "EQUIPMENT_SWAP_PENDING" ) then GS_PlayerIsSwitchingGear = true; GS_PlayerSwappedGear = 0 return; end
	if ( GS_EventName == "EQUIPMENT_SWAP_FINISHED" ) then
    	GearScore_GetScore(UnitName("player"), "player");
		GearScore_Send(UnitName("player"), "ALL")
		local Red, Blue, Green = GearScore_GetQuality(GS_Data[GetRealmName()].Players[UnitName("player")].GearScore)
    	PersonalGearScore:SetText(GS_Data[GetRealmName()].Players[UnitName("player")].GearScore); PersonalGearScore:SetTextColor(Red, Green, Blue, 1)
        GS_PlayerIsSwitchingGear = nil;
	return
	end

	if ( GS_EventName == "CHAT_MSG_CHANNEL" ) then
	    local Who = GS_AddonMessage; local Message = GS_Prefix; local ExtraMessage = ""; local ColorClass = ""; local Channel = GS_Sender
	    if GS_Data[GetRealmName()].Players[Who] then
            ColorClass = "|cff"..string.format("%02x%02x%02x", GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Who].Class]].Red * 255, GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Who].Class]].Green * 255, GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Who].Class]].Blue * 255)
			local Red, Green, Blue = GearScore_GetQuality(GS_Data[GetRealmName()].Players[Who].GearScore)
			local ColorGearScore = "|cff"..string.format("%02x%02x%02x", Red * 255, Blue * 255, Green * 255)
            ExtraMessage = "("..ColorGearScore..tostring(GS_Data[GetRealmName()].Players[Who].GearScore).."|r)" ;

		end

		if string.find(Channel, "Trade") then
		    --print("StringFound!")
			local A, B = string.find(Channel, "Trade"); Channel = string.sub(Channel, 1, B)
		end
		Channel = "["..Channel.."] "

	    local NewMessage = Channel..ExtraMessage.."|Hplayer:"..Who.."|h["..ColorClass..Who.."|r]|h: "..Message
	    --print(NewMessage)

	end

    if ( GS_EventName == "INSPECT_ACHIEVEMENT_READY" ) then
     	GearScoreCalculateEXP()
     	if ( GS_DisplayFrame:IsVisible() ) then GS_DisplayXP(UnitName("target")); --GearScoreClassScan(UnitName("target"));
     	 end
    end

	if ( GS_EventName == "PLAYER_EQUIPMENT_CHANGED" ) then
		
	    if ( GS_PlayerIsSwitchingGear == true ) then GS_PlayerSwappedGear = GS_PlayerSwappedGear + 1 return; end
	    if ( GS_PlayerSwappedGear ) then GS_PlayerSwappedGear = GS_PlayerSwappedGear - 1; if ( GS_PlayerSwappedGear == 0 ) then GS_PlayerSwappedGear = nil; end; return; end
	    GearScore_GetScore(UnitName("player"), "player");
		--GearScore_Send(UnitName("player"), "ALL")
		local Red, Blue, Green = GearScore_GetQuality(GS_Data[GetRealmName()].Players[UnitName("player")].GearScore)
    	PersonalGearScore:SetText(GS_Data[GetRealmName()].Players[UnitName("player")].GearScore); PersonalGearScore:SetTextColor(Red, Green, Blue, 1)
  	end
	if ( GS_EventName == "PLAYER_TARGET_CHANGED" ) then
		if UnitName("target") then 	GS_Data[GetRealmName()]["CurrentPlayer"] = {}; end
		if ( GS_DisplayFrame:IsVisible() ) then
			if UnitName("target") then  
				if CanInspect("target") then NotifyInspect("target"); GearScore_GetScore(UnitName("target"), "target"); end
				--ClearAchievementComparisonUnit(); SetAchievementComparisonUnit("target")				
				--GearScore_DisplayUnit(UnitName("target"), 1); 
				
				GS_ExPFrameUpdateCounter = 0;
				GS_SCANSET(UnitName("target"));
			end			
		end
			GS_Data["CurrentTarget"] = {}
			for i = 1, 18 do
				GS_Data["CurrentTarget"][i] = GetInventoryItemLink("target", i)
			end		
	end
	if ( GS_EventName == "CHAT_MSG_ADDON" ) then
			if not (GS_Whisper == "GUILD") then return; end
			if GS_Settings["BlackList"] then if GS_Settings["BlackList"][GS_Sender] then return; end; end
	    if not ( GearScoreChatMessageThrottle ) then GearScoreChatMessageThrottle = 0; end
        GearScoreChatMessageThrottle = GearScoreChatMessageThrottle + 1
		if not ( GSMega ) then GSMega = 1; end
		if ( GS_Prefix == "GSY_Version" ) and ( tonumber(GS_AddonMessage) ) and ( GS_Settings["OldVer"] ) then
			if ( tonumber(GS_AddonMessage) > GS_Settings["OldVer"] ) then print("There is a newer version of GearScore. Go to www.GearScoreAddon.com to update."); GS_Settings["OldVer"] = tonumber(GS_AddonMessage); end
		end
		if ( GS_Prefix == "GSY_Request" ) and ( GS_Settings["Communication"] == 1 ) and ( GS_Sender ~= UnitName("player") ) then
				if not ( GearScoreChatMessageThrottle ) then GearScoreChatMessageThrottle = 0; end
			    if ( GearScoreChatMessageThrottle >= 1 ) then return; end
				if ( GS_Data[GetRealmName()].Players[GS_AddonMessage] ) then GearScore_Send(GS_AddonMessage, "GUILD", GS_Sender); end
		end
		if ( GS_Prefix == "GSY" ) and ( GS_Settings["Communication"] == 1 ) and ( GS_Sender ~= UnitName("player") ) then
			if ( GS_Whisper == "RAID" ) then GS_Whisper = "PARTY"; end
			local tbl = {}
			for v in string.gmatch(GS_AddonMessage, "[^$]+") do
 				tinsert(tbl, v)
			end
			if ( tbl[1] == UnitName("player") ) or (( tbl[11] ~= GS_Sender ) and ( tbl[11] ~= " ") ) then return; end
			if ( tbl[1] ) and ( tbl[2] ) and ( tbl[3] ) then
				--IF No GearScore Record was Found
				if not ( GS_Data[GetRealmName()].Players[tbl[1]] ) then
					local TestAuthenticity = GearScore_ComposeRecord(tbl, GS_Sender)
					if TestAuthenticity then return end
					if ( UnitName("mouseover") == tbl[1] ) then GameTooltip:SetUnit(tbl[1]); end
					if ( GS_DisplayPlayer == tbl[1] ) and ( GS_DisplayFrame:IsVisible() ) then GearScore_DisplayUnit(tbl[1], 1); end
					if ( ( GS_Factions[GS_Data[GetRealmName()].Players[tbl[1]].Faction] ~= UnitFactionGroup("player") ) and ( GS_Settings["KeepFaction"] == -1 ) ) or ( ( GS_Data[GetRealmName()].Players[tbl[1]].Level < GS_Settings["MinLevel"] ) and ( tbl[1] ~= UnitName("player") ) ) then GS_Data[GetRealmName()].Players[tbl[1]] = nil; end
					if ( (type(tonumber(tbl[10]))) == "number" ) then GS_Data[GetRealmName()].Players[tbl[1]] = nil; end
					return
				end

				--If GearScore Record Needs Updating
				--if  ( tonumber(GS_Data[GetRealmName()].Players[tbl[1]].GearScore) ~= tonumber(tbl[2]) ) or ( tonumber(GS_Data[GetRealmName()].Players[tbl[1]].Date) ~= tonumber(tbl[3]) ) then
				if not ( tonumber(GS_Data[GetRealmName()].Players[tbl[1]].Date) >= tonumber(tbl[3]) ) then
					if ( tonumber(tbl[3]) > GearScore_GetTimeStamp() ) then return; end
				--not ( GS_Data[GetRealmName()].Players[tbl[1]].Date > tonumber(tbl[3]) ) then
					local PreviousRecord = GS_Data[GetRealmName()].Players[tbl[1]]
					local TestAuthenticity = GearScore_ComposeRecord(tbl, GS_Sender)
					if TestAuthenticity then return end
					local CurrentRecord = GS_Data[GetRealmName()].Players[tbl[1]]
					if ( GS_DisplayPlayer == tbl[1] ) and ( GS_DisplayFrame:IsVisible() ) then GearScore_DisplayUnit(tbl[1], 1); end
                    if ( ( GS_Factions[GS_Data[GetRealmName()].Players[tbl[1]].Faction] ~= UnitFactionGroup("player") ) and ( GS_Settings["KeepFaction"] == -1 ) ) or ( ( GS_Data[GetRealmName()].Players[tbl[1]].Level < GS_Settings["MinLevel"] ) and ( tbl[1] ~= UnitName("player") ) ) then GS_Data[GetRealmName()].Players[tbl[1]] = nil; end
					if ( (type(tonumber(tbl[10]))) == "number" ) then GS_Data[GetRealmName()].Players[tbl[1]] = nil; end
					return
				end
			end
        end
	end


	if ( GS_EventName == "ADDON_LOADED" ) then
		if ( GS_Prefix == "GearScore" ) then
      		if not ( GS_Settings ) then	GS_Settings = GS_DefaultSettings; GS_Talent = {}; GS_TimeStamp = {}; end
			GS_PVP = {}; GS_EquipTBL = {}; GS_Bonuses = {}; GS_Timer = {}; GS_Request = {}; GS_Average = {}
			if not ( GS_Data ) then GS_Data = {}; end; if not ( GS_Data[GetRealmName()] ) then GS_Data[GetRealmName()] = { ["Players"] = {} }; end
  			GS_Settings["Developer"] = 0; GS_VersionNum = 30119; GS_Settings["OldVer"] = GS_VersionNum
  			for i, v in pairs(GS_DefaultSettings) do if not ( GS_Settings[i] ) then GS_Settings[i] = GS_DefaultSettings[i]; end; end
  			if ( GS_Settings["AutoPrune"] == 1 ) then GearScore_Prune(); end
			if ( GS_Settings["Developer"] == 0 ) then print("Welcome to GearScore 3.1.20. Type /gs to visit options and turn off help."); end
			print("|cffFF1E00GearScore:|r There is currently a bug in which the UI will stop responding to inspection requests. This is not a bug caused by GearScore, but is a bug in the client. Blizzard is aware of the bug and a fix should be implimented shortly.");
			if ( GS_Settings["Developer"] == 1 ) then print("Welcome to GearScore 3.1.20. This is a test version. Please provide feedback at www.GearScoreAddon.com"); end
  			if ( GS_Settings["Restrict"] == 1 ) then GearScore_SetNone(); end
  			if ( GS_Settings["Restrict"] == 2 ) then GearScore_SetLight(); end
  			if ( GS_Settings["Restrict"] == 3 ) then GearScore_SetHeavy(); end
  			if ( GetGuildInfo("player") ) then GuildRoster(); end
  			GearScore_GetScore(UnitName("player"), "player"); GearScore_Send(UnitName("player"), "ALL")
       	  	if ( GetGuildInfo("player") ) and ( GS_Settings["Developer"] ~= 1 )then SendAddonMessage( "GSY_Version", GS_Settings["OldVer"], "GUILD"); end
--       	  	if ( GetBuildInfo() == "4.0.3") then 
--       	  		print("ERROR: This version of GearScore is incompatible with Cataclysm. Please update at www.GearScoreAddon.com"); 
--       	  		GS_DisplayFrame = nil;
--       	  		GS_Settings = nil;
--       	  		GS_Database = nil;
--       	  	end;
        end
        if ( GS_Prefix == "GearScoreRecount" ) then
            local f = CreateFrame("Frame", "GearScoreRecountErrorFrame", UIParent);
            f:CreateFontString("GearScoreRecountWarning")
			f:SetFrameStrata("TOOLTIP")
			local s = GearScoreRecountWarning; s:SetFont("Fonts\\FRIZQT__.TTF", 30); s:SetText("WARNING! GearScoreRecount MUST be disabled to use GearScore. 3.1.x")
			s:SetPoint("BOTTOMLEFT",UIParent,"CENTER",-600,200)
			s:Show();f:Show()
			print("WARNING! GearScoreRecount MUST be disabled to use GearScore. Please turn it off or remove it from your addons folder, Sorry for the inconvience")
			--error("WARNING! GearScoreRecount MUST be disabled to use GearScore. Please turn it off or remove it from your addons folder, Sorry for the inconvience")
   		end
		
	end
end

function GearScore_CheckPartyGuild(Name)
	local Group = "party"
	if UnitName("raid1") then Group = "raid"; else Group = "party"; end
	for i = 1, 40 do
		if ( UnitName(Group..i) == Name ) then return true; else return false; end
	end
end

function GearScore_ComposeRecord(tbl, GS_Sender)
	local Name, GearScore, Date, Class, Average, Race, Faction, Location, Level, Sex, Guild, Scanned, Equip = tbl[1], tonumber(tbl[2]), tonumber(tbl[3]), tbl[4], tonumber(tbl[5]), tbl[6], tbl[7], tbl[8], tostring(tbl[9]), 1, tbl[10], GS_Sender, {}
--	print(Name, GearScore, Date, Class, Average, Race, Faction, Location, Level, Sex, Guild, Scanned)
	if Scanned == "LOLGearScore" or Scanned == "GearScoreBreaker" then return "InValid"; end
	if ( Scanned == " " ) then Scanned = "Unknown"; end
	for i = 12, 30 do
		if ( i ~= 15 ) then Equip[i-11] = tbl[i]; end
	end	
	if ( GS_Data[GetRealmName()].Players[Name] ) then if ( GS_Data[GetRealmName()].Players[Name].StatString ) then local StatString = GS_Data[GetRealmName()].Players[Name].StatString; end end
	GS_Data[GetRealmName()].Players[Name] = { ["Name"] = Name, ["GearScore"] = GearScore, ["PVP"] = 1, ["Level"] = tonumber(Level), ["Faction"] = Faction, ["Sex"] = Sex, ["Guild"] = Guild,
    ["Race"] = Race, ["Class"] =  Class, ["Spec"] = 1, ["Location"] = Location, ["Scanned"] = Scanned, ["Date"] = Date, ["Average"] = Average, ["Equip"] = Equip, ["StatString"] = StatString}
end

function GearScore_Prune()
		--local time, monthago = GearScore_GetTimeStamp()
  		for i, v in pairs(GS_Data[GetRealmName()].Players) do 
			--if ( tonumber(v.Level) < GS_Settings["MinLevel"] ) then GS_Data[GetRealmName()].Players[i] = nil; end;
  			if ( ( GS_Factions[v.Faction] ~= UnitFactionGroup("player") ) and ( GS_Settings["KeepFaction"] == -1 ) ) or ( ( tonumber(v.Level) < GS_Settings["MinLevel"] ) and ( v.Name ~= UnitName("player") ) ) then GS_Data[GetRealmName()].Players[v.Name] = nil; end
			if not v.GearScore or not v.Name or not v.Sex or not v.Equip or not v.Location or not v.Level or not v.Faction or not v.Guild or not v.Race or not v.Class or not v.Date or not v.Average or not v.Scanned then GS_Data[GetRealmName()].Players[i] = nil; end
			if ( string.find(v.Scanned, "<") ) then GS_Data[GetRealmName()].Players[v.Name] = nil; end
            if v.Guild == "<>" or v.Guild == "" then GS_Data[GetRealmName()].Players[v.Name].Guild = "*"; end
			if ( string.find(v.Guild, "<") ) then GS_Data[GetRealmName()].Players[v.Name].Guild = string.sub(v.Guild, 2, strlen(v.Guild) - 1); end
  			if ( (type(tonumber(v.Guild))) == "number" ) then GS_Data[GetRealmName()].Players[v.Name] = nil; end
  			if v.Scanned == "LOLGearScore" then GS_Data[GetRealmName()].Players[v.Name] = nil; end
  			--if ( GearScore_GetDate(v.Date) > 30 )
			   --if ( GearScore_GetDate(v.Date) > 30 ) then print("Old Record Found     "..i); end
			  --if v.Guild == "<>" then GS_Data[GetRealmName()].Players[v.Name].Guild = "*"; end
		end
end


function GearScore_GetItemCode(ItemLink)
	if not ( ItemLink ) then return nil; end
	local found, _, ItemString = string.find(ItemLink, "^|c%x+|H(.+)|h%[.*%]"); local Table = {}
	for v in string.gmatch(ItemString, "[^:]+") do tinsert(Table, v); end
	return Table[2]..":"..Table[3], Table[2]
end

-------------------------- Get Mouseover Score -----------------------------------
function GearScore_GetScore(Name, Target)
	if ( UnitIsPlayer(Target) ) then
	    local PlayerClass, PlayerEnglishClass = UnitClass(Target);
		local GearScore = 0; local PVPScore = 0; local ItemCount = 0; local LevelTotal = 0; local TitanGrip = 1; local TempEquip = {}; local TempPVPScore = 0

		if ( GetInventoryItemLink(Target, 16) ) and ( GetInventoryItemLink(Target, 17) ) then
      		local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(GetInventoryItemLink(Target, 16))
            local TitanGripGuess = 0
            if ( ItemEquipLoc == "INVTYPE_2HWEAPON" ) then TitanGrip = 0.5; end
		end

		if ( GetInventoryItemLink(Target, 17) ) then
			local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(GetInventoryItemLink(Target, 17))
			if ( ItemEquipLoc == "INVTYPE_2HWEAPON" ) then TitanGrip = 0.5; end
			TempScore, ItemLevel = GearScore_GetItemScore(GetInventoryItemLink(Target, 17));
			if ( PlayerEnglishClass == "HUNTER" ) then TempScore = TempScore * 0.3164; end
			GearScore = GearScore + TempScore * TitanGrip;	ItemCount = ItemCount + 1; LevelTotal = LevelTotal + ItemLevel
            TempEquip[17] = GearScore_GetItemCode(ItemLink)
		else
      		TempEquip[17] = "0:0"
		end
		
		for i = 1, 18 do

			if ( i ~= 4 ) and ( i ~= 17 ) then
        		ItemLink = GetInventoryItemLink(Target, i)
				if ( ItemLink ) then
        			local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(ItemLink)
     				TempScore, ItemLevel, a, b, c, d, TempPVPScore = GearScore_GetItemScore(ItemLink);
					if ( i == 16 ) and ( PlayerEnglishClass == "HUNTER" ) then TempScore = TempScore * 0.3164; end
					if ( i == 18 ) and ( PlayerEnglishClass == "HUNTER" ) then TempScore = TempScore * 5.3224; end
					if ( i == 16 ) then TempScore = TempScore * TitanGrip; end
					GearScore = GearScore + TempScore;	ItemCount = ItemCount + 1; LevelTotal = LevelTotal + ItemLevel
					--PVPScore = PVPScore + TempPVPScore
     				TempEquip[i] = GearScore_GetItemCode(ItemLink)
				else
				    TempEquip[i] = "0:0"
				end
			end;
		end
		if ( GearScore <= 0 ) and ( Name ~= UnitName("player") ) then
			GearScore = 0; return;
		elseif ( Name == UnitName("player") ) and ( GearScore <= 0 ) then
		    GearScore = 0; end
		
		--if ( GearScore < 0 ) and ( PVPScore < 0 ) then return 0, 0; end
		--if ( PVPScore < 0 ) then PVPScore = 0; end
        --print(GearScore, PVPScore)
		local __, RaceEnglish = UnitRace(Target);
		local __, ClassEnglish = UnitClass(Target);
        local currentzone = GetZoneText()
        if not ( GS_Zones[currentzone] ) then 
			--print("Alert! You have found a zone unknown to GearScore. Please report the zone '"..GetZoneText().." at gearscore.blogspot.com Thanks!"); 
			currentzone = "Unknown Location"
		end
        local GuildName = GetGuildInfo(Target); if not ( GuildName ) then GuildName = "*"; else GuildName = GuildName; end
		GS_Data[GetRealmName()].Players[Name] = { ["Name"] = Name, ["GearScore"] = floor(GearScore), ["PVP"] = 1, ["Level"] = UnitLevel(Target), ["Faction"] = GS_Factions[UnitFactionGroup(Target)], ["Sex"] = UnitSex(Target), ["Guild"] = GuildName,
        ["Race"] = GS_Races[RaceEnglish], ["Class"] =  GS_Classes[ClassEnglish], ["Spec"] = 1, ["Location"] = GS_Zones[currentzone], ["Scanned"] = UnitName("player"), ["Date"] = GearScore_GetTimeStamp(), ["Average"] = floor((LevelTotal / ItemCount)+0.5), ["Equip"] = TempEquip}
	end
end

-------------------------------------------------------------------------------
	--attempt to obtain raid members GearScores
function GearScore_GetGroupScores()
	--Is this Called by anything?
end

-------------------------------------------------------------------------------
function GearScore_EquipCompare(Tooltip, ItemScore, ItemSlot, GS_ItemLink)
    if ( ItemSlot == 50 ) then return; end
    local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(GS_ItemLink)
    local HunterMultiplier = 1
    local TokenLink, TokenNumber = GearScore_GetItemCode(ItemLink)
	if ( GS_Tokens[TokenNumber] ) then
	    ItemSlot = GS_Tokens[TokenNumber].ItemSlot
	    ItemScore = GS_Tokens[TokenNumber].ItemScore
	    ItemSubType = GS_Tokens[TokenNumber].ItemSubType
	end
    local X = ""; local Red = 0; local Blue = 0; local Green = 0; local Table = {};	local NoTable = {}; local Count = 1; local PartySize = 0; local Group = ""; local CompareScore = 0; local Percent = 0
	Tooltip:AddLine("Best Upgrade for:")
	local GSL_DataBase = GearScore_BuildDatabase("Party")
	
	for i,v in pairs(GSL_DataBase) do
 	local Difference = 0
				--print( ItemSubType )
			if ( GS_ClassInfo[GS_Classes[v.Class]].Equip[ItemSubType] ) or ( ItemEquipLoc == "INVTYPE_CLOAK" )  then
			    if ( ItemSlot == 18 ) and v.Class == "HU" then HunterMultiplier = 5.3224; end
			    if ( ( ItemSlot == 17 ) or ( ItemSlot == 16 ) or ( ItemSlot == 36 ) ) and ( v.Class == "HU" ) then HunterMultiplier = 0.3164; end
			    
			    --Code To fix 2H issue.

               		if ( ItemSlot > 20 ) or ( ItemSlot == 16 ) then
             		if ( ItemSlot == 16 ) then ItemSlot = 36; end
					local ItemName2, ItemLink2, ItemRarity2, ItemLevel2, ItemMinLevel2, ItemType2, ItemSubType2, ItemStackCount2, ItemEquipLoc2, ItemTexture2 = GetItemInfo("item:"..v.Equip[ItemSlot - 20])
 	  				local ItemName3, ItemLink3, ItemRarity3, ItemLevel3, ItemMinLevel3, ItemType3, ItemSubType3, ItemStackCount3, ItemEquipLoc3, ItemTexture3 = GetItemInfo("item:"..v.Equip[ItemSlot - 19])
     				if ( ItemLink2 ) then ItemScore2 = GearScore_GetItemScore(ItemLink2); else ItemScore2 = 0; end
	    			if ( ItemLink3 ) then ItemScore3 = GearScore_GetItemScore(ItemLink3); else ItemScore3 = 0; end
					if ( ItemScore2 > ItemScore3 ) then CompareScore = ItemScore3; else CompareScore = ItemScore2; end
					--if ( ItemEquipLoc == "INVTYPE_2HWEAPON" ) then
					if ( ItemSlot ~= 31 ) and ( ItemSlot ~= 32 ) and ( ItemSlot ~= 33 ) and ( ItemSlot ~= 34 ) then
					    Difference = floor((ItemScore - ( ItemScore2 + ItemScore3 )) * HunterMultiplier)
					else
					    Difference = floor((ItemScore - ( CompareScore )) * HunterMultiplier)
					end
     			else
        			local ItemName2, ItemLink2, ItemRarity2, ItemLevel2, ItemMinLevel2, ItemType2, ItemSubType2, ItemStackCount2, ItemEquipLoc2, ItemTexture2 = GetItemInfo("item:"..v.Equip[ItemSlot])
    	 			if ( ItemLink2 ) then ItemScore2 = GearScore_GetItemScore(ItemLink2); else ItemScore2 = 0; end
     				Difference = floor(((ItemScore) - (ItemScore2)) * HunterMultiplier )
         		end
				Percent = floor((Difference / v.GearScore) * 10000 ) / 100
				if ( Percent > 99.99 ) or ( v.GearScore == ( 4/0 ) ) then Percent = 99.99; end
				Table[Count] = { ["Name"] = v.Name, ["Percent"] = Percent, ["Difference"] = Difference, ["Class"] = GS_Classes[v.Class] }
                Count = Count + 1
	   		end
		--end
	end
    table.sort(Table, function(a, b) return a.Percent > b.Percent end)
    for i, v in ipairs(Table) do
		local Red = 0; local Blue = 0; local Green = 0; local X = ""
		if ( v.Percent > 0 ) then Green = 1; X = "+"; end
		if ( v.Percent < 0 ) then Red = 1; end
	    if ( v.Percent == 0 ) then Red = 1; Green = 1; v.Percent = "0.00"; end
  		Tooltip:AddDoubleLine(v.Name, X..v.Percent.."% ("..X..v.Difference..")", GS_ClassInfo[v.Class].Red, GS_ClassInfo[v.Class].Green, GS_ClassInfo[v.Class].Blue, Red, Green, Blue)
	end
	for i = 1, PartySize do if ( UnitName(GS_Group..i) ) and not ( GS_Data[GetRealmName()].Players[UnitName(Group..i)] ) and not ( GS_ClassInfo[GS_Data[GetRealmName()].Players[UnitName(Group..i)].Class].Equip[ItemSubType] ) then Tooltip:AddDoubleLine(UnitName(GS_Group..i), "No Data", GS_ClassInfo[UnitClass(GS_Group..i)].Red, GS_ClassInfo[UnitClass(GS_Group..i)].Green, GS_ClassInfo[UnitClass(GS_Group..i)].Blue, 1, 1, 1); end; end
end

------------------------------ Get Item Score ---------------------------------
function GearScore_GetItemScore(ItemLink)
	local QualityScale = 1; local PVPScale = 1; local PVPScore = 0; local GearScore = 0
	if not ( ItemLink ) then return 0, 0; end
	local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(ItemLink); local Table = {}; local Scale = 1.8618
 	if ( ItemRarity == 5 ) then QualityScale = 1.3; ItemRarity = 4;
	elseif ( ItemRarity == 1 ) then QualityScale = 0.005;  ItemRarity = 2
	elseif ( ItemRarity == 0 ) then QualityScale = 0.005;  ItemRarity = 2 end
    if ( ItemRarity == 7 ) then ItemRarity = 3; ItemLevel = 187.05; end
    local TokenLink, TokenNumber = GearScore_GetItemCode(ItemLink)
	if ( GS_Tokens[TokenNumber] ) then return GS_Tokens[TokenNumber].ItemScore, GS_Tokens[TokenNumber].ItemLevel, GS_Tokens[TokenNumber].ItemSlot; end
    if ( GS_ItemTypes[ItemEquipLoc] ) then
        if ( ItemLevel > 120 ) then Table = GS_Formula["A"]; else Table = GS_Formula["B"]; end
		if ( ItemRarity >= 2 ) and ( ItemRarity <= 4 )then
            local Red, Green, Blue = GearScore_GetQuality((floor(((ItemLevel - Table[ItemRarity].A) / Table[ItemRarity].B) * 1 * Scale)) * 12.25 )
            GearScore = floor(((ItemLevel - Table[ItemRarity].A) / Table[ItemRarity].B) * GS_ItemTypes[ItemEquipLoc].SlotMOD * Scale * QualityScale)
			if ( ItemLevel == 187.05 ) then ItemLevel = 0; end
			if ( GearScore < 0 ) then GearScore = 0;   Red, Green, Blue = GearScore_GetQuality(1); end
			GearScoreTooltip:SetOwner(GS_Frame1, "ANCHOR_Right")
			if ( PVPScale == 0.75 ) then PVPScore = 1; GearScore = GearScore * 1; 
			else PVPScore = GearScore * 0; end
			GearScore = floor(GearScore)
			PVPScore = floor(PVPScore)
			return GearScore, ItemLevel, GS_ItemTypes[ItemEquipLoc].ItemSlot, Red, Green, Blue, PVPScore, ItemEquipLoc;
		end
  	end
	return -1, ItemLevel, 50, 1, 1, 1, PVPScore, ItemEquipLoc
end
-------------------------------------------------------------------------------

---------------------------- Request Information ------------------------------
function GearScore_Request(GS_Target)
	if not ( GearScoreChatMessageThrottle ) then GearScoreChatMessageThrottle = 0; end
    if ( GearScoreChatMessageThrottle >= 5 ) then return; end
	if ( GS_Settings["Communication"] == 1 ) then
		    if ( GetGuildInfo("player") ) then SendAddonMessage( "GSY_Request", GS_Target, "GUILD"); --SendAddonMessage( "GSY_Version", GS_Settings["OldVer"], "GUILD"); 
		    end
	end
end
-------------------------------------------------------------------------------
                                                
---------------------------- Send Information ------------------------------
function GearScore_Send(Name, Group, Target)
	if Group == "RAID" then Group = "GUILD"; end --Command to convert info to only Guild Channel
	if not ( GearScoreChatMessageThrottle ) then GearScoreChatMessageThrottle = 0; end
    if ( GearScoreChatMessageThrottle >= 1 ) then return; end
        
	if ( GS_PlayerIsInCombat ) then return; end
	local GS_MessageA, GS_MessageB, GS_MessageC, GS_MessageD, GS_Lenght = "", "", "", "", 0
	if ( GS_Settings["Communication"] == 1 ) then
	    GS_TempVersion = GS_VersionNum
		if ( GS_Settings["Developer"] ) then GS_TempVersion = ""; end
			if ( Name ) and ( GS_Data[GetRealmName()].Players[Name] ) then
				local A = GetRealmName()
				GS_MessageA = GS_Data[A].Players[Name].Name.."$"..GS_Data[A].Players[Name].GearScore.."$"..GS_Data[A].Players[Name].Date.."$"..GS_Data[A].Players[Name].Class.."$"
				GS_MessageB = GS_Data[A].Players[Name].Average.."$"..GS_Data[A].Players[Name].Race.."$"..GS_Data[A].Players[Name].Faction.."$"..GS_Data[A].Players[Name].Location.."$"
				--GS_MessageC = GS_Data[A].Players[Name].Level.."$"..GS_Data[A].Players[Name].Sex.."$"..GS_Data[A].Players[Name].Guild.."$"..GS_Data[A].Players[Name].Scanned
				GS_MessageC = GS_Data[A].Players[Name].Level.."$"..GS_Data[A].Players[Name].Guild.."$"..GS_Data[A].Players[Name].Scanned
				--print( GS_MessageC )
				GS_MessageD = "$"
				for i = 1, 18 do
					if ( i ~= 4 ) then
						GS_MessageD = GS_MessageD..GS_Data[A].Players[Name].Equip[i].."$"
					else
					   	GS_MessageD = GS_MessageD.."0:0".."$"
					end
				end       
			if ( strlen(GS_MessageA..GS_MessageB..GS_MessageC..GS_MessageD) >= 252 ) then GS_MessageC = GS_Data[A].Players[Name].Level.."$"..GS_Data[A].Players[Name].Guild.."$".." "; end
			GS_Length = strlen(GS_MessageA..GS_MessageB..GS_MessageC..GS_MessageD);
			end
			if not ( GS_Length ) then return; end
		if ( GS_Length ) and ( GS_Length < 252 ) then
		    if ( Group == "ALL" ) then
				if ( GetGuildInfo("player") ) then SendAddonMessage( "GSY", GS_MessageA..GS_MessageB..GS_MessageC..GS_MessageD, "Guild"); end
				SendAddonMessage( "GSY", GS_MessageA..GS_MessageB..GS_MessageC..GS_MessageD, "RAID")
			else
			    if ( Group == "GUILD" ) and not ( GetGuildInfo("player") ) then return; end
				SendAddonMessage( "GSY", GS_MessageA..GS_MessageB..GS_MessageC..GS_MessageD, Group, Target)
			end
		end
	end
end
-------------------------------------------------------------------------------

-------------------------------- Get Quality ----------------------------------

function GearScore_GetQuality(ItemScore)
	--if not ItemScore then return; end
	--ItemScore = ItemScore / 2;
	local Red = 0.1; local Blue = 0.1; local Green = 0.1; local GS_QualityDescription = "Legendary"
   	if not ( ItemScore ) then return 0, 0, 0, "Trash"; end
   	if ( ItemScore > 5999 ) then ItemScore = 5999; end
	for i = 0,6 do
		if ( ItemScore > i * 1000 ) and ( ItemScore <= ( ( i + 1 ) * 1000 ) ) then
		    local Red = GS_Quality[( i + 1 ) * 1000].Red["A"] + (((ItemScore - GS_Quality[( i + 1 ) * 1000].Red["B"])*GS_Quality[( i + 1 ) * 1000].Red["C"])*GS_Quality[( i + 1 ) * 1000].Red["D"])
            local Blue = GS_Quality[( i + 1 ) * 1000].Green["A"] + (((ItemScore - GS_Quality[( i + 1 ) * 1000].Green["B"])*GS_Quality[( i + 1 ) * 1000].Green["C"])*GS_Quality[( i + 1 ) * 1000].Green["D"])
            local Green = GS_Quality[( i + 1 ) * 1000].Blue["A"] + (((ItemScore - GS_Quality[( i + 1 ) * 1000].Blue["B"])*GS_Quality[( i + 1 ) * 1000].Blue["C"])*GS_Quality[( i + 1 ) * 1000].Blue["D"])
			return Red, Green, Blue, GS_Quality[( i + 1 ) * 1000].Description
		end
	end
return 0.1, 0.1, 0.1
end
-------------------------------------------------------------------------------

------------------------------Get Date ----------------------------------------
function GearScore_GetDate(TimeStamp)
	if not (TimeStamp) then return; end
	--Example Time Stamp 12/28/1985 10:45am--> 198512281045
	local min, hour, day, month, year, GS_Date = 0; CopyStamp = TimeStamp; meridian = "am"
	local Red, Green, Blue = 0
	year = floor(TimeStamp / 100000000); TimeStamp = TimeStamp - (year * 100000000)
	month = floor(TimeStamp / 1000000); TimeStamp = TimeStamp - (month * 1000000)
	day = floor(TimeStamp / 10000); TimeStamp = TimeStamp - (day * 10000)
	hour = floor(TimeStamp / 100); TimeStamp = TimeStamp - (hour * 100)
	min = TimeStamp
	if ( hour == 24 ) then hour = 0; end
	--if ( hour >= 12 ) then
--	    meridian = "pm"; hour = hour - 12
--		if ( hour == 0 ) then hour = 12; end
--	end
	if ( min < 10 ) then min = "0"..tonumber(min); end
	GS_Date = month.."/"..day--.."/"..year
	local TempDate = GearScore_GetTimeStamp();
 	--print(floor(CopyStamp / 10000), floor(TempDate / 10000))
	if ( floor(CopyStamp / 10000) == floor(TempDate / 10000) ) then GS_Date = hour..":"..min.." "--..meridian; 
	end

	--Add Color!
	local CurrentTime = GearScore_GetTimeStamp()
	local currentyear = floor(CurrentTime / 100000000); CurrentTime = CurrentTime - (currentyear * 100000000)
	local currentmonth = floor(CurrentTime / 1000000); CurrentTime = CurrentTime - (currentmonth * 1000000)
	local currentday = floor(CurrentTime / 10000); CurrentTime = CurrentTime - (currentday * 10000)
	local currenthour = floor(CurrentTime / 100); CurrentTime = CurrentTime - (currenthour * 100)
	local currentmin = CurrentTime
	local currentdays = ( currentmonth * 30 ) + currentday
	--print(currentyear, currentmonth, currentday, currenthour, currentmin)
	local totaldays = (month * 30 ) + day
	if currentdays < totaldays then currentdays = currentdays + 365; end
	Blue = 0; Red = 0; Green = 1
	--if ( (currentdays - totaldays) >= 1 ) then Red = 0; Green = 1; Blue = 0; end
	--if ( (currentdays - totaldays) > 3 ) then Green = 1; Red = 0; Blue = 0; end
	if ( (currentdays - totaldays) >= 7 ) then Green = 0.9; Red = .9; Blue = .0; end  
	if ( (currentdays - totaldays) >= 14 ) then Green = .5; Red = 1; Blue = .25; end
	if ( (currentdays - totaldays) >= 21 ) then Green = 0; Red = 1; Blue = 0; end
	--print("CurrentDay:", currentdays, "    RecordedDays:", totaldays)
	
	--365
	--1


	return currentdays - totaldays, Red, Green, Blue
end
-------------------------------------------------------------------------------


---------------------------- Get TimeStamp ------------------------------------
function GearScore_GetTimeStamp()
	local GS_Hour, GS_Minute = GetGameTime(); local monthago = 0
	local GS_Weekday, GS_Month, GS_Day, GS_Year = CalendarGetDate()
	local GS_TimeStamp = (GS_Year * 100000000) + (GS_Month * 1000000) + (GS_Day * 10000) + (GS_Hour * 100) + (GS_Minute)
	if ( GS_Month == 1 ) then
		monthago = ( ( GS_Year - 1 ) *100000000 ) + ( 12 * 1000000 ) + (GS_Day * 10000) + (GS_Hour * 100) + (GS_Minute)
	else
		monthago = (GS_Year * 100000000) + ((GS_Month - 1) * 1000000) + (GS_Day * 10000) + (GS_Hour * 100) + (GS_Minute)
	end
	return GS_TimeStamp, monthago
end
-------------------------------------------------------------------------------


----------------------------- Show Tooltip ------------------------------------
function GearScore_ShowTooltip(GS_Target)
	GameTooltip:SetUnit(GS_Target)
	GameTooltip:Show()
end
-------------------------------------------------------------------------------

function GearScore_GetAge(ScanDate)
	local CurrentDate = GearScore_GetTimeStamp();
	local DateSpread = CurrentDate - ScanDate;
	if ( DateSpread == 0 ) then return "*Scanned < 1 min ago.", 0,1,0, 0, "minutes"; end;
	if ( DateSpread < 60 ) then	return "*Scanned "..DateSpread.." minutes ago.", 0,1,0, DateSpread, "minutes"; end;
	DateSpread = floor((DateSpread + 40) / 100);
	if ( DateSpread < 24 ) then	return "*Scanned "..DateSpread.." hours ago.", 1,1,0, DateSpread, "hours"; end;
	DateSpread = floor(DateSpread / 100) + floor(mod(DateSpread, 100) / 24);
	if ( DateSpread < 31 ) then	return "*Scanned "..DateSpread.." days ago.", 1,0.5,0, DateSpread, "days"; end;
	return "*Scanned over 1 month ago.", 1,0,0, floor(DateSpread / 30), "months";
end

----------------------------- Hook Set Unit -----------------------------------
function GearScore_HookSetUnit(arg1, arg2)
    GS_GearScore = nil; local Name = GameTooltip:GetUnit(); GearScore_GetGroupScores(); local PreviousRecord = {}; 
    local Age = "*";
    local Realm = ""; if UnitName("mouseover") == Name then _, Realm = UnitName("mouseover"); if not Realm then Realm = GetRealmName(); end; end
	if ( CanInspect("mouseover") ) and ( UnitName("mouseover") == Name ) and not ( GS_PlayerIsInCombat ) and ( UnitIsUnit("target", "mouseover") ) then 
		Age = "";
		if (GS_DisplayFrame:IsVisible()) and GS_DisplayPlayer and UnitName("target") then if GS_DisplayPlayer == UnitName("target") then return; end; end			
		if ( GS_Data[GetRealmName()].Players[Name] ) then PreviousRecord = GS_Data[GetRealmName()].Players[Name]; end 
		NotifyInspect("mouseover"); GearScore_GetScore(Name, "mouseover"); --GS_Data[GetRealmName()]["CurrentPlayer"] = GS_Data[GetRealmName()]["Players"][Name]
		if not ( GearScore_IsRecordTheSame(GS_Data[GetRealmName()].Players[Name], PreviousRecord) ) then GearScore_Send(Name, "ALL"); end
	end
 	if ( GS_Data[GetRealmName()].Players[Name] ) and ( GS_Data[GetRealmName()].Players[Name].GearScore > 0 ) and ( GS_Settings["Player"] == 1 ) then 
		local Red, Blue, Green = GearScore_GetQuality(GS_Data[GetRealmName()].Players[Name].GearScore)
		if ( GS_Settings["Level"] == 1 ) then 
			GameTooltip:AddDoubleLine(Age.."GearScore: "..GS_Data[GetRealmName()].Players[Name].GearScore, "(iLevel: "..GS_Data[GetRealmName()].Players[Name].Average..")", Red, Green, Blue, Red, Green, Blue)
			if ( GS_Settings["Date2"] == 1 ) and ( Age == "*" ) then 
				local NoWDate, DateRed, DateGreen, DateBlue = GearScore_GetAge(GS_Data[GetRealmName()].Players[Name].Date); 
				--print(GearScore_GetAge(GS_Data[GetRealmName()].Players[Name].Date));
				GameTooltip:AddLine(NoWDate, DateRed, DateGreen, DateBlue);
			end
		else
			GameTooltip:AddLine(Age.."GearScore: "..GS_Data[GetRealmName()].Players[Name].GearScore, Red, Green, Blue)
			if ( GS_Settings["Date2"] == 1 ) and ( Age == "*" ) then 
				local NoWDate, DateRed, DateGreen, DateBlue = GearScore_GetAge(GS_Data[GetRealmName()].Players[Name].Date); 
				--print(GearScore_GetAge(GS_Data[GetRealmName()].Players[Name].Date));
				GameTooltip:AddLine(NoWDate, DateRed, DateGreen, DateBlue); 
			end
		end
		if ( GS_Settings["Compare"] == 1 ) then
			local MyGearScore = GS_Data[GetRealmName()].Players[UnitName("player")].GearScore
			local TheirGearScore = GS_Data[GetRealmName()].Players[Name].GearScore
			if ( MyGearScore  > TheirGearScore  ) then GameTooltip:AddDoubleLine("YourScore: "..MyGearScore  , "(+"..(MyGearScore - TheirGearScore  )..")", 0,1,0, 0,1,0); end
			if ( MyGearScore   < TheirGearScore   ) then GameTooltip:AddDoubleLine("YourScore: "..MyGearScore, "(-"..(TheirGearScore - MyGearScore  )..")", 1,0,0, 1,0,0); end	
			if ( MyGearScore   == TheirGearScore   ) then GameTooltip:AddDoubleLine("YourScore: "..MyGearScore  , "(+0)", 0,1,1,0,1,1); end	
		end
		
		if ( GS_Settings["Detail"] == 1 ) then GearScore_SetDetails(GameTooltip, Name); end
		if ( GS_Settings["Special"] == 1 ) and ( GS_Special[Name] ) then if ( GS_Special[Name]["Realm"] == Realm ) then GameTooltip:AddLine(GS_Special[GS_Special[Name].Type], 1, 0, 0 ); end; end
		if ( GS_Settings["Special"] == 1 ) and ( GS_Special[GS_Data[GetRealmName()].Players[Name].Guild] ) then GameTooltip:AddLine(GS_Special[GS_Special[GS_Data[GetRealmName()].Players[Name].Guild].Type], 1, 0, 0 ); end
        local EnglishFaction, Faction = UnitFactionGroup("player")
		--print(EnglishFaction)
		if ( ( GS_Factions[GS_Data[GetRealmName()].Players[Name].Faction] ~= UnitFactionGroup("player") ) and ( GS_Settings["KeepFaction"] == -1 ) ) or ( ( GS_Data[GetRealmName()].Players[Name].Level < GS_Settings["MinLevel"] ) and ( Name ~= UnitName("player") ) ) then GS_Data[GetRealmName()].Players[Name] = nil; end
--		if ( ( GS_Data[GetRealmName()].Players[Name].Level < GS_Settings["MinLevel"] ) and ( Name ~= UnitName("player") ) ) then GS_Data[GetRealmName()].Players[Name] = nil; end
		if ( GS_Settings["ShowHelp"] == 1 ) then GameTooltip: AddLine("Target this player and type /gs for detailed information. You can turn this msg off in the options screen. (/gs)", 1,1,1,1); end
	end
	--GearScore_Request(Name)
end

function GearScoreChatAdd(self,event,msg,arg1,...)
if ( msg == "You aren't in a party." ) then return true; end   
if ( GS_ExchangeName ) then if ( msg == "No player named '"..GS_ExchangeName.."' is currently playing." ) then GS_ExchangeCount = nil; print("Transmission Interrupted!"); return true; end; end
if ( GS_Settings["CHAT"] == 1 ) then
	--msg = "(1234): "..msg

	    --print("A", GS_AddonMessage, "B", GS_Whisper, "C", GS_Sender)
	    local Who = arg1; local Message = msg; local ExtraMessage = ""; local ColorClass = "";
	    if GS_Data[GetRealmName()].Players[Who] then
            ColorClass = "|cff"..string.format("%02x%02x%02x", GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Who].Class]].Red * 255, GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Who].Class]].Green * 255, GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Who].Class]].Blue * 255)
			local Red, Green, Blue = GearScore_GetQuality(GS_Data[GetRealmName()].Players[Who].GearScore)
			local ColorGearScore = "|cff"..string.format("%02x%02x%02x", Red * 255, Blue * 255, Green * 255)
            ExtraMessage = "("..ColorGearScore..tostring(GS_Data[GetRealmName()].Players[Who].GearScore).."|r): " ;
            ExtraMessage = (ColorGearScore.."|Hplayer:X33"..Who.."|h("..tostring(GS_Data[GetRealmName()].Players[Who].GearScore)..")|h|r ")

		end

	    local NewMessage = ExtraMessage..Message
		--local NewMessage = Message
		--local arg1 = arg1..ExtraMessage
		--print(arg1)

--return true
	return false,NewMessage,arg1,...
else
	return false
end
end

--function GearScoreChatAddddd(self,event,msg,arg1,...)
--print("Captured Info: ", msg)
--return true
--end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL",GearScoreChatAdd)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY",GearScoreChatAdd)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID",GearScoreChatAdd)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD",GearScoreChatAdd)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM",GearScoreChatAdd)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER",GearScoreChatAdd)
--ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_LIST",GearScoreChatAddddd)






function GearScoreSetItemRef(arg1, arg2, ...)
	if string.find(arg1, "player:X33") then
        GearScore_DisplayUnit(string.sub(arg1, 11), 1)
        return
	end
 	--return OriginalSetItemRef(arg1, arg2, ...)
end



function GearScore_IsRecordTheSame(Current, Previous)
	if not ( Previous.Name ) or not ( Current.Name ) then return true; end
	if ( Previous.GearScore ~= Current.GearScore ) then return false; end
	if ( Previous.Date + 10000 <= Current.Date ) then return false; end
	if ( Previous.Guild ~= Current.Guild ) then return false; end
	if ( Previous.Level ~= Current.Level ) then return false; end
	for i = 1, 18 do
		if ( i ~= 4 ) then 
			if ( Previous.Equip[i] ~= Current.Equip[i] ) then return false; end
		end
	end
	return true
end


function GearScore_SetDetails(tooltip, Name)
    if not ( GS_Data[GetRealmName()].Players[Name] ) then return; end
  	for i = 1,18 do
  	    if not ( i == 4 ) then
    	local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo("item:"..GS_Data[GetRealmName()].Players[Name].Equip[i])
		if ( ItemLink ) then
			local GearScore, ItemLevel, EquipLoc, Red, Green, Blue = GearScore_GetItemScore(ItemLink)
			if ( GS_Data[GetRealmName()].Players[Name].Equip[i] ) and ( i ~= 4 ) then
    		   	local Add = ""
        		if ( GS_Settings["Level"] == 1 ) then Add = " (iLevel "..tostring(ItemLevel)..")"; end
             	tooltip:AddDoubleLine("["..ItemName.."]", tostring(GearScore)..Add, GS_Rarity[ItemRarity].Red, GS_Rarity[ItemRarity].Green, GS_Rarity[ItemRarity].Blue, Red, Blue, Green)
        	end
		end
		end
	end
end
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
function GearScore_HookSetItem() ItemName, ItemLink = GameTooltip:GetItem(); GearScore_HookItem(ItemName, ItemLink, GameTooltip); end
function GearScore_HookRefItem() ItemName, ItemLink = ItemRefTooltip:GetItem(); GearScore_HookItem(ItemName, ItemLink, ItemRefTooltip); end
function GearScore_HookCompareItem() ItemName, ItemLink = ShoppingTooltip1:GetItem(); GearScore_HookItem(ItemName, ItemLink, ShoppingTooltip1); end
function GearScore_HookCompareItem2() ItemName, ItemLink = ShoppingTooltip2:GetItem(); GearScore_HookItem(ItemName, ItemLink, ShoppingTooltip2); end
function GearScore_HookItem(ItemName, ItemLink, Tooltip)
	local PlayerClass, PlayerEnglishClass = UnitClass("player");
	local TokenLink, TokenNumber = GearScore_GetItemCode(ItemLink)
	if not ( IsEquippableItem(ItemLink) ) and not GS_Tokens[TokenNumber] then return; end
	local ItemScore, ItemLevel, EquipLoc, Red, Green, Blue, PVPScore, ItemEquipLoc = GearScore_GetItemScore(ItemLink);
 	if ( ItemScore >= 0 ) then
		if ( GS_Settings["Item"] == 1 ) then
  			if ( ItemLevel ) and ( GS_Settings["Level"] == 1 ) then Tooltip:AddDoubleLine("GearScore: "..ItemScore, "(iLevel "..ItemLevel..")", Red, Blue, Green, Red, Blue, Green);
				if ( PlayerEnglishClass == "HUNTER" ) then
					if ( ItemEquipLoc == "INVTYPE_RANGEDRIGHT" ) or ( ItemEquipLoc == "INVTYPE_RANGED" ) then
						Tooltip:AddLine("HunterScore: "..floor(ItemScore * 5.3224), Red, Blue, Green)
					end
					if ( ItemEquipLoc == "INVTYPE_2HWEAPON" ) or ( ItemEquipLoc == "INVTYPE_WEAPONMAINHAND" ) or ( ItemEquipLoc == "INVTYPE_WEAPONOFFHAND" ) or ( ItemEquipLoc == "INVTYPE_WEAPON" ) or ( ItemEquipLoc == "INVTYPE_HOLDABLE" )  then
						Tooltip:AddLine("HunterScore: "..floor(ItemScore * 0.3164), Red, Blue, Green)
					end
				end
			else
				Tooltip:AddLine("GearScore: "..ItemScore, Red, Blue, Green)
				if ( PlayerEnglishClass == "HUNTER" ) then
					if ( ItemEquipLoc == "INVTYPE_RANGEDRIGHT" ) or ( ItemEquipLoc == "INVTYPE_RANGED" ) then
						Tooltip:AddLine("HunterScore: "..floor(ItemScore * 5.3224), Red, Blue, Green)
					end
					if ( ItemEquipLoc == "INVTYPE_2HWEAPON" ) or ( ItemEquipLoc == "INVTYPE_WEAPONMAINHAND" ) or ( ItemEquipLoc == "INVTYPE_WEAPONOFFHAND" ) or ( ItemEquipLoc == "INVTYPE_WEAPON" ) or ( ItemEquipLoc == "INVTYPE_HOLDABLE" )  then
						Tooltip:AddLine("HunterScore: "..floor(ItemScore * 0.3164), Red, Blue, Green)
					end
				end
    		end
    		if ( Tooltip ~= ShoppingTooltip1 ) and ( Tooltip ~= ShoppingTooltip2 ) then CalculateClasicItemScore(ItemLink, Tooltip, Red, Green, Blue); end
           if ( GS_Settings["ML"] == 1 ) then GearScore_EquipCompare(Tooltip, ItemScore, EquipLoc, ItemLink); end
  		end
	else
	    if ( GS_Settings["Level"] == 1 ) and ( ItemLevel ) then
	        Tooltip:AddLine("iLevel "..ItemLevel)
		end
    end
end
function GearScore_OnEnter(Name, ItemSlot, Argument)
	if ( UnitName("target") ) then NotifyInspect("target"); GS_LastNotified = UnitName("target"); end
	local OriginalOnEnter = GearScore_Original_SetInventoryItem(Name, ItemSlot, Argument); return OriginalOnEnter
end
function MyPaperDoll()
	GearScore_GetScore(UnitName("player"), "player"); GearScore_Send(UnitName("player"), "ALL"); 
	--SendAddonMessage( "GSY_Version", GS_Settings["OldVer"], "GUILD")
	local Red, Blue, Green = GearScore_GetQuality(GS_Data[GetRealmName()].Players[UnitName("player")].GearScore)
    PersonalGearScore:SetText(GS_Data[GetRealmName()].Players[UnitName("player")].GearScore); PersonalGearScore:SetTextColor(Red, Green, Blue, 1)
end
-------------------------------------------------------------------------------

----------------------------- Reports -----------------------------------------
function GearScore_ManualReport(Group, Who, Target)   --Please Rewrite All of this Code. It sucks.

--/gspam raid whisper bob
--
--	GearScore_BuildDatabase()	
--	GearScore_SendReport("Manual", Group, Who, G_Direction)
		
end	

---------------GS-SPAM Slasch Command--------------------------------------
function GS_SPAM(Command)
	local tbl = {}
	for v in string.gmatch(Command, "[^ ]+") do tinsert(tbl, v); end
	if ( strlower(Command) == "group" ) then
		if ( UnitName("raid1") ) then Command = "raid"; else Command = "party"; end
	end
	if ( strlower(Command) == "party" ) then
        local GspamDatabase = GearScore_BuildDatabase("Party"); table.sort(GspamDatabase, function(a, b) return a.GearScore > b.GearScore end);
		GearScore_SendSpamReport("PARTY", nil, GspamDatabase)
		--GearScore_SendSpamReport(Target, Who, Database)
	end
	if ( strlower(Command) == "raid" ) then
        local GspamDatabase = GearScore_BuildDatabase("Party"); table.sort(GspamDatabase, function(a, b) return a.GearScore > b.GearScore end);
		GearScore_SendSpamReport("RAID", nil, GspamDatabase)
	end
	if ( tbl[1] == "party" ) or ( tbl[1] == "raid" ) then
	    if ( tbl[2] ) then
            tbl[1] = strupper(string.sub(tbl[1], 1, 1))..strlower(string.sub(tbl[1], 2))
			tbl[2] = strupper(string.sub(tbl[2], 1, 1))..strlower(string.sub(tbl[2], 2))
	        if ( tbl[2] == "Party" ) then local GspamDatabase = GearScore_BuildDatabase(tbl[1]); table.sort(GspamDatabase, function(a, b) return a.GearScore > b.GearScore end); GearScore_SendSpamReport("PARTY", nil, GspamDatabase); end
	        if ( tbl[2] == "Raid" ) then local GspamDatabase = GearScore_BuildDatabase(tbl[1]); table.sort(GspamDatabase, function(a, b) return a.GearScore > b.GearScore end); GearScore_SendSpamReport("RAID", nil, GspamDatabase); end
	        if ( tbl[2] == "Guild" ) then local GspamDatabase = GearScore_BuildDatabase(tbl[1]); table.sort(GspamDatabase, function(a, b) return a.GearScore > b.GearScore end); GearScore_SendSpamReport("GUILD", nil, GspamDatabase); end
	        if ( tbl[2] == "Officer" ) then local GspamDatabase = GearScore_BuildDatabase(tbl[1]); table.sort(GspamDatabase, function(a, b) return a.GearScore > b.GearScore end); GearScore_SendSpamReport("OFFICER", nil, GspamDatabase); end
	        if ( tbl[2] == "Say" ) then local GspamDatabase = GearScore_BuildDatabase(tbl[1]); table.sort(GspamDatabase, function(a, b) return a.GearScore > b.GearScore end); GearScore_SendSpamReport("SAY", nil, GspamDatabase); end
	        if ( tbl[2] == "Whisper" ) then local GspamDatabase = GearScore_BuildDatabase(tbl[1]); table.sort(GspamDatabase, function(a, b) return a.GearScore > b.GearScore end); GearScore_SendSpamReport("WHISPER", tbl[3], GspamDatabase); end
	        if ( tbl[2] == "Channel" ) then local GspamDatabase = GearScore_BuildDatabase(tbl[1]); table.sort(GspamDatabase, function(a, b) return a.GearScore > b.GearScore end); GearScore_SendSpamReport("CHANNEL", tbl[3], GspamDatabase); end
         end
	end
end

function GS_BANSET(Command)
	if not ( GS_Settings["BlackList"] ) then GS_Settings["BlackList"] = {}; end
	if ( GS_Settings["BlackList"][Command] ) then GS_Settings["BlackList"][Command] = nil; print(Command.." removed from GearScore's Communication Ban list.")
	else GS_Settings["BlackList"][Command] = 1; print(Command.." added to GearScore's Communication Ban list."); end
end

function GS_MANSET(Command)
	if ( strlower(Command) == "" ) or ( strlower(Command) == "options" ) or ( strlower(Command) == "option" ) or ( strlower(Command) == "help" ) then for i,v in ipairs(GS_CommandList) do print(v); end; return end
	if ( strlower(Command) == "show" ) then GS_Settings["Player"] = GS_ShowSwitch[GS_Settings["Player"]]; if ( GS_Settings["Player"] == 1 ) or ( GS_Settings["Player"] == 2 ) then print("Player Scores: On"); else print("Player Scores: Off"); end; return; end
	if ( strlower(Command) == "player" ) then GS_Settings["Player"] = GS_ShowSwitch[GS_Settings["Player"]]; if ( GS_Settings["Player"] == 1 ) or ( GS_Settings["Player"] == 2 ) then print("Player Scores: On"); else print("Player Scores: Off"); end; return; end
    if ( strlower(Command) == "item" ) then GS_Settings["Item"] = GS_ItemSwitch[GS_Settings["Item"]]; if ( GS_Settings["Item"] == 1 ) or ( GS_Settings["Item"] == 3 ) then print("Item Scores: On"); else print("Item Scores: Off"); end; return; end
	if ( strlower(Command) == "describe" ) then GS_Settings["Description"] = GS_Settings["Description"] * -1; if ( GS_Settings["Description"] == 1 ) then print ("Descriptions: On"); else print ("Descriptions: Off"); end; return; end
	if ( strlower(Command) == "level" ) then GS_Settings["Level"] = GS_Settings["Level"] * -1; if ( GS_Settings["Level"] == 1 ) then print ("Item Levels: On"); else print ("Item Levels: Off"); end; return; end
	if ( strlower(Command) == "communicate" ) then GS_Settings["Communication"] = GS_Settings["Communication"] * -1; if ( GS_Settings["Communication"] == 1 ) then print ("Communication: On"); else print ("Communication: Off"); end; return; end
	if ( strlower(Command) == "compare" ) then GS_Settings["Compare"] = GS_Settings["Compare"] * -1; if ( GS_Settings["Compare"] == 1 ) then print ("Comparisons: On"); else print ("Comparisons: Off"); end; return; end
    --if ( strlower(Command) == "average" ) then GS_Settings["Average"] = GS_Settings["Average"] * -1; if ( GS_Settings["Average"] == 1 ) then print ("Average ItemLevels: On"); else print ("Average ItemLevels: Off"); end; return; end
    if ( strlower(Command) == "date" ) then GS_Settings["Date"] = GS_Settings["Date"] * -1; if ( GS_Settings["Date"] == 1 ) then print ("Date/Time: On"); else print ("Date/Time: Off"); end; return; end
    if ( strlower(Command) == "chat" ) then GS_Settings["CHAT"] = GS_Settings["CHAT"] * -1; if ( GS_Settings["CHAT"] == 1 ) then print ("Chat Scores: On"); else print ("ChatScores: Off"); end; return; end
	if ( strlower(Command) == "time" ) then GS_Settings["Date"] = GS_Settings["Date"] * -1; if ( GS_Settings["Date"] == 1 ) then print ("Date/Time: On"); else print ("Date/Time: Off"); end; return; end
    if ( strlower(Command) == "ml" ) then GS_Settings["ML"] = GS_Settings["ML"] * -1; if ( GS_Settings["ML"] == 1 ) then print ("MasterLooting: On"); else print ("MasterLooting: Off"); end; return; end
    if ( strlower(Command) == "detail" ) then GS_Settings["Detail"] = GS_Settings["Detail"] * -1; if ( GS_Settings["Detail"] == 1 ) then print ("Details: On"); else print ("Details: Off"); end; return; end
    if ( strlower(Command) == "details" ) then GS_Settings["Detail"] = GS_Settings["Detail"] * -1; if ( GS_Settings["Detail"] == 1 ) then print ("Details: On"); else print ("Details: Off"); end; return; end
	if ( strlower(Command) == "reset" ) then GS_Settings = GS_DefaultSettings; print("All Settings returned to Default"); return end
	if ( strlower(Command) == "purge" ) then print ("WARNING! This will remove your entire GearScore Database. To continue please type '/gset purge 314159265"); return; end
	if ( strlower(Command) == "purge 314159265" ) then GS_Data = nil; ReloadUI(); return; end
	local tbl = {}
    for v in string.gmatch(Command, "[^ ]+") do tinsert(tbl, v); end
 	if ( strlower(tbl[1]) == "transmit" ) and (tbl[2]) then
       if tbl[2] == "end" then GS_ExchangeCount = nil; print("Ending Transmission"); return; end
	     if  GS_ExchangeDatabase then print("You are already transmitting your database!"); return; end

--		if
--	        	tbl[2] = (strupper(string.sub(tbl[2], 1, 1))..strlower(string.sub(tbl[2], 2)))
--				local Message = floor(GearScore_GetTimeStamp()/314159265)
--				print(Message)
--				SendAddonMessage("GSYTRANSMIT", Message, "WHISPER", tbl[2])
		GearScore_Exchange("DATABASE", tbl[2])
		return
    end
	print("GearScore: Unknown Command. Type '/gset' for a list of options")
 	
end
function GS_SCANSET(Command)
		if ( GS_OptionsFrame:IsVisible() ) then GearScore_HideOptions(); end		
		PanelTemplates_SetTab(GS_DisplayFrame, 1)
		GS_DisplayFrame:Hide();
		GS_ExPFrame:Hide();
		GS_GearFrame:Show(); GS_NotesFrame:Hide(); GS_DefaultFrame:Show(); GS_ExPFrame:Hide()
		GS_GearScoreText:Show(); GS_LocationText:Show(); GS_DateText:Show(); GS_AverageText: Show();
		
	    if ( UnitName("target") ) and ( Command == "" ) then 
		 	 if not ( UnitIsPlayer("target") ) then GearScore_DisplayUnit(UnitName("player")) else GearScore_DisplayUnit(UnitName("target")); end
	    else
         	if ( Command == "" ) then Command = UnitName("player"); end
         	if ( strlen(strupper(string.sub(Command, 1, 1))..strlower(string.sub(Command, 2))) ~= strlen(Command) ) then GearScore_DisplayUnit(Command); end
         	GearScore_DisplayUnit(strupper(string.sub(Command, 1, 1))..strlower(string.sub(Command, 2))); return
	    end
end

------------------------ GUI PROGRAMS -------------------------------------------------------
function GearScore_GetRaidColor(Raid, Score)
	local Red = 0; local Blue = 0; local Green = 0
		if not (Raid) then return; end
		if ( (Raid - Score) >= 200 ) then return 1, 0, 0; end
		if ( (Score - Raid) >= 400 ) then return 0, 1, 0; end
		if ( (Score - Raid) >= 0 ) and ( (Score - Raid) <= 300 ) then return 1, 1, 0; end
  		if ( (Score - Raid) >= 0 ) and ( (Score - Raid) > 300 ) then return ( 400 - (Score - Raid) )/200 , 1, 0; end
        if ( (Raid - Score) < 200 ) then return 1, ((Score - (Raid - 200))/200), 0; end
	return 0, 0, 0
end
													

function GearScore_DisplayUnit(Name, Auto)
	if not ( Name ) then Name = UnitName("player"); end
	if ( Name == UnitName("player") ) then GearScore_GetScore(UnitName("player"), "player"); end
	--or not ( GS_Data[GetRealmName()].Players[Name] ) then return; end
	GearScore_HideDatabase(1)
	GS_DisplayPlayer = Name
	--GS_DisplayXP(Name); 
	GearScoreClassScan(Name)
--	if GS_GearFrame:IsVisible() then GS_DatabaseFrame.tooltip:Show(); end
 	--GearScore_Send(Name, "ALL")
	if not ( Auto ) then GearScore_Request(Name); end
	local Textures = {}
--	if ( Race == "Orc" ) then Scale = 0.8; end
    GS_EditBox1:SetText(Name)
	GS_DisplayFrame:Show()
	GS_Model:SetModelScale(1)
    GS_Model:SetCamera(1)
    GS_Model:SetLight(1, 0, 0, -0.707, -0.707, 0.7, 1.0, 1.0, 1.0, 0.8, 1.0, 1.0, 0.8)
	if Name == UnitName("target") then GS_Model:SetUnit("target"); else GS_Model:SetUnit("player"); end
	GS_Model:Undress()
 	GS_Model:EnableMouse(1)
    GS_Model:SetPosition(0,0,0)

	if ( GS_Data[GetRealmName()].Players[Name] ) then
	    for i = 1, 18 do
	    	if ( i ~= 4 ) then
	            local ItemName, ItemLink, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo("item:"..GS_Data[GetRealmName()].Players[Name].Equip[i])
				local backdrop = {}
				if ( ItemLink ) then GS_Model:TryOn(ItemLink); end
    			if ( ItemTexture ) then backdrop = { bgFile = ItemTexture }; _G["GS_Frame"..i]:SetBackdrop(backdrop); else backdrop = { bgFile = GS_TextureFiles[i] }; _G["GS_Frame"..i]:SetBackdrop(backdrop);end
			end
		end
	    GS_InfoText:SetText(GS_Data[GetRealmName()].Players[Name].Level.." "..GS_Races[GS_Data[GetRealmName()].Players[Name].Race].." "..GS_Classes[GS_Data[GetRealmName()].Players[Name].Class])
	    GS_InfoText:SetTextColor(GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Name].Class]].Red, GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Name].Class]].Green, GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Name].Class]].Blue, 1)
		GS_NameText:SetText(GS_Data[GetRealmName()].Players[Name].Name)
	    GS_NameText:SetTextColor(GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Name].Class]].Red, GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Name].Class]].Green, GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Name].Class]].Blue, 1)
		Red, Green, Blue = GearScore_GetQuality(GS_Data[GetRealmName()].Players[Name].GearScore)
		GS_GearScoreText:SetText("Raw GearScore: "..GS_Data[GetRealmName()].Players[Name].GearScore)
		GS_GearScoreText:SetTextColor(Red,Blue,Green)
		GS_GuildText:SetTextColor(GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Name].Class]].Red, GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Name].Class]].Green, GS_ClassInfo[GS_Classes[GS_Data[GetRealmName()].Players[Name].Class]].Blue, 1)
		GS_GuildText:SetText(GS_Data[GetRealmName()].Players[Name].Guild)
		local Date, DateRed, DateGreen, DateBlue = GearScore_GetDate(GS_Data[GetRealmName()].Players[Name].Date)
		ColorStringDate = "|cff"..string.format("%02x%02x%02x", DateRed * 255, DateGreen * 255, DateBlue * 255) 
		local MyDateText = Date.." days ago"; if ( tonumber(Date) == 0 ) then MyDateText = "Today"; end
		GS_DateText:SetText("Scanned "..ColorStringDate..MyDateText.."|r  by  "..GS_Data[GetRealmName()].Players[Name].Scanned)
		GS_AverageText:SetText("Average ItemLevel:|cFFFFFFFF "..GS_Data[GetRealmName()].Players[Name].Average)
		GS_LocationText:SetText(GS_Zones[GS_Data[GetRealmName()].Players[Name].Location])
		GearScore_UpdateRaidColors(Name)
	else
		GS_InfoText:SetText("")
		GS_NameText:SetText(Name)
		GS_GuildText:SetText("")
		GS_DateText:SetText("")
		GS_AverageText:SetText("")
		GS_LocationText:SetText("")
		GS_GearScoreText:SetText("No Record")
		local backdrop = {}
		for i = 1, 18 do if ( i ~=4 ) then backdrop = { bgFile = GS_TextureFiles[i] }; _G["GS_Frame"..i]:SetBackdrop(backdrop); end; end
		--GS_Slot1:Hide(); GS_Slot2:Hide(); GS_Slot3:Hide(); GS_Slot5:Hide(); GS_Slot6:Hide(); GS_Slot7:Hide(); GS_Slot8:Hide(); GS_Slot9:Hide(); GS_Slot10:Hide(); GS_Slot11:Hide(); GS_Slot12:Hide(); GS_Slot13:Hide(); GS_Slot14:Hide(); GS_Slot15:Hide(); GS_Slot16:Hide(); GS_Slot17:Hide(); GS_Slot18:Hide()
	end


 	GS_EditBox1:SetAutoFocus(0)
 end

 function GearScore_UpdateRaidColors(Name)
 	local RealmName = GetRealmName()
 	GS_InstanceText1:SetTextColor(GearScore_GetRaidColor(2600, GS_Data[RealmName].Players[Name].GearScore))
	GS_InstanceText2:SetTextColor(GearScore_GetRaidColor(2896, GS_Data[RealmName].Players[Name].GearScore))
	GS_InstanceText3:SetTextColor(GearScore_GetRaidColor(3353, GS_Data[RealmName].Players[Name].GearScore))
	GS_InstanceText4:SetTextColor(GearScore_GetRaidColor(3563, GS_Data[RealmName].Players[Name].GearScore))
	GS_InstanceText5:SetTextColor(GearScore_GetRaidColor(3809, GS_Data[RealmName].Players[Name].GearScore))
	GS_InstanceText6:SetTextColor(GearScore_GetRaidColor(4019, GS_Data[RealmName].Players[Name].GearScore))
	GS_InstanceText7:SetTextColor(GearScore_GetRaidColor(4475, GS_Data[RealmName].Players[Name].GearScore))
	GS_InstanceText8:SetTextColor(GearScore_GetRaidColor(4932, GS_Data[RealmName].Players[Name].GearScore))
	GS_InstanceText9:SetTextColor(GearScore_GetRaidColor(4686, GS_Data[RealmName].Players[Name].GearScore))
	GS_InstanceText10:SetTextColor(GearScore_GetRaidColor(5142, GS_Data[RealmName].Players[Name].GearScore))
	GS_InstanceText11:SetTextColor(GearScore_GetRaidColor(5598, GS_Data[RealmName].Players[Name].GearScore))			
end

function GearScore_ShowOptions()
	GS_OptionalDisplayed = 	GS_Displayed
	GS_Displayed = nil
	if ( GS_Settings["Restrict"] == 1 ) then GS_None:SetChecked(true); GS_Light:SetChecked(false); GS_Heavy:SetChecked(false); end
	if ( GS_Settings["Restrict"] == 2 ) then GS_Light:SetChecked(true); GS_None:SetChecked(false); GS_Heavy:SetChecked(false);end
	if ( GS_Settings["Restrict"] == 3 ) then GS_Heavy:SetChecked(true); GS_Light:SetChecked(false); GS_None:SetChecked(false);end
	if ( GS_Settings["Player"] == 1 ) then GS_ShowPlayerCheck:SetChecked(true); else GS_ShowPlayerCheck:SetChecked(false); end
	if ( GS_Settings["Item"] == 1 ) then GS_ShowItemCheck:SetChecked(true); else GS_ShowItemCheck:SetChecked(false); end
	if ( GS_Settings["Detail"] == 1 ) then GS_DetailCheck:SetChecked(true); else GS_DetailCheck:SetChecked(false); end
	if ( GS_Settings["Level"] == 1 ) then GS_LevelCheck:SetChecked(true); else GS_LevelCheck:SetChecked(false); end
	if ( GS_Settings["Date2"] == 1 ) then GS_DateCheck:SetChecked(true); else GS_DateCheck:SetChecked(false); end
	if ( GS_Settings["AutoPrune"] == 1 ) then GS_PruneCheck:SetChecked(true); else GS_PruneCheck:SetChecked(false); end	
	if ( GS_Settings["ShowHelp"] == 1 ) then GS_HelpCheck:SetChecked(true); else GS_HelpCheck:SetChecked(false); end
	if ( GS_Settings["KeepFaction"] == 1 ) then GS_FactionCheck:SetChecked(true); else GS_FactionCheck:SetChecked(false); end
	if ( GS_Settings["ML"] == 1 ) then GS_MasterlootCheck:SetChecked(true); else GS_MasterlootCheck:SetChecked(false); end
	if ( GS_Settings["CHAT"] == 1 ) then GS_ChatCheck:SetChecked(true); else GS_ChatCheck:SetChecked(false); end
	GS_DatabaseAgeSliderText:SetText("Keep data for: "..(GS_Settings["DatabaseAgeSlider"] or 30).." days.")
	GS_DatabaseAgeSlider:SetValue(GS_Settings["DatabaseAgeSlider"] or 30)
	GS_LevelEditBox:SetText(GS_Settings["MinLevel"])
	--Set SpecScore Options--
	local class, englishClass = UnitClass("player")
	for i = 1,4 do _G["GS_SpecFontString"..i]:Hide(); _G["GS_SpecScoreCheck"..i]:Hide(); end
    for i, v in ipairs(GearScoreClassSpecList[englishClass]) do
    _G["GS_SpecFontString"..i]:SetText("Show "..GearScoreClassSpecList[englishClass][i].." SpecScores")
   		_G["GS_SpecScoreCheck"..i]:SetText(GearScoreClassSpecList[englishClass][i])
   		_G["GS_SpecFontString"..i]:Show(); _G["GS_SpecScoreCheck"..i]:Show()
    	if not ( GS_Settings["ShowSpecScores"] ) then GS_Settings["ShowSpecScores"] = {}; end
    	if not ( GS_Settings["ShowSpecScores"][GearScoreClassSpecList[englishClass][i]] ) then GS_Settings["ShowSpecScores"][GearScoreClassSpecList[englishClass][i]] = 1; end
    	if ( GS_Settings["ShowSpecScores"][GearScoreClassSpecList[englishClass][i]] == 1 ) then _G["GS_SpecScoreCheck"..i]:SetChecked(1); else _G["GS_SpecScoreCheck"..i]:SetChecked(0); end
    end
	
	GS_Displayed = 1; GS_OptionsFrame:Show(); GS_GearFrame:Hide(); GS_ExPFrame:Hide()
end 
 
function GearScore_HideOptions()
	if ( GS_ShowItemCheck:GetChecked() ) then GS_Settings["Item"] = 1; else GS_Settings["Item"] = -1; end
	if ( GS_None:GetChecked() ) then GearScore_SetNone(); end												
	if ( GS_Light:GetChecked() ) then GearScore_SetLight(); end												
	if ( GS_Heavy:GetChecked() ) then GearScore_SetHeavy(); end	
	if ( GS_HelpCheck:GetChecked() ) then GS_Settings["ShowHelp"] = 1; else GS_Settings["ShowHelp"] = -1; end
	if ( GS_ShowPlayerCheck:GetChecked() ) then GS_Settings["Player"] = 1; else GS_Settings["Player"] = -1; end											
	if ( GS_DetailCheck:GetChecked() ) then GS_Settings["Detail"] = 1; else GS_Settings["Detail"] = -1; end											
	if ( GS_LevelCheck:GetChecked() ) then GS_Settings["Level"] = 1; else GS_Settings["Level"] = -1; end	
	if ( GS_ChatCheck:GetChecked() ) then GS_Settings["CHAT"] = 1; else GS_Settings["CHAT"] = -1; end
	if ( GS_ShowItemCheck:GetChecked() ) then GS_Settings["Item"] = 1; else GS_Settings["Item"] = -1; end
	if ( GS_DateCheck:GetChecked() ) then GS_Settings["Date2"] = 1; else GS_Settings["Date2"] = -1; end
	if ( GS_PruneCheck:GetChecked() ) then GS_Settings["AutoPrune"] = 1; else GS_Settings["AutoPrune"] = -1; end		
	if ( GS_FactionCheck:GetChecked() ) then GS_Settings["KeepFaction"] = 1; else GS_Settings["KeepFaction"] = -1; end
	if ( GS_MasterlootCheck:GetChecked() ) then GS_Settings["ML"] = 1; else GS_Settings["ML"] = -1; end
	GS_Settings["MinLevel"] = tonumber(GS_LevelEditBox:GetText());
	GS_Settings["DatabaseAgeSlider"] = ( GS_DatabaseAgeSlider:GetValue() or 30 )
	GS_OptionsFrame:Hide()		
	if (GS_Displayed) then GearScore_DisplayUnit(GS_DisplayPlayer); end
	GS_Displayed = nil
	
	--Update Settings for new SpecScore Options--
	local class, englishClass = UnitClass("player")
	for i, v in ipairs(GearScoreClassSpecList[englishClass]) do
		if ( _G["GS_SpecScoreCheck"..i]:GetChecked() ) then GS_Settings["ShowSpecScores"][GearScoreClassSpecList[englishClass][i]] = 1; else GS_Settings["ShowSpecScores"][GearScoreClassSpecList[englishClass][i]] = 0; end
	end
	
	
end
 

function GearScore_SetHeavy()
	GS_Settings["Restrict"] = 3
	GS_ClassInfo["Warrior"].Equip["Cloth"] = nil
	GS_ClassInfo["Warrior"].Equip["Mail"] = nil
	GS_ClassInfo["Warrior"].Equip["Leather"] = nil
	GS_ClassInfo["Paladin"].Equip["Cloth"] = nil
	GS_ClassInfo["Paladin"].Equip["Mail"] = nil
	GS_ClassInfo["Paladin"].Equip["Leather"] = nil
	GS_ClassInfo["Death Knight"].Equip["Cloth"] = nil
	GS_ClassInfo["Death Knight"].Equip["Mail"] = nil
	GS_ClassInfo["Death Knight"].Equip["Leather"] = nil
	GS_ClassInfo["Hunter"].Equip["Cloth"] = nil
	GS_ClassInfo["Hunter"].Equip["Leather"] = nil
	GS_ClassInfo["Shaman"].Equip["Cloth"] = nil
	GS_ClassInfo["Shaman"].Equip["Leather"] = nil
	GS_ClassInfo["Rogue"].Equip["Cloth"] = nil
	GS_ClassInfo["Druid"].Equip["Cloth"] = nil
end

function GearScore_SetLight()
	GS_Settings["Restrict"] = 2
	GS_ClassInfo["Warrior"].Equip["Cloth"] = nil
	GS_ClassInfo["Warrior"].Equip["Mail"] = nil
	GS_ClassInfo["Warrior"].Equip["Leather"] = nil
	GS_ClassInfo["Paladin"].Equip["Cloth"] = 1
	GS_ClassInfo["Paladin"].Equip["Mail"] = 1
	GS_ClassInfo["Paladin"].Equip["Leather"] = 1
	GS_ClassInfo["Death Knight"].Equip["Cloth"] = nil
	GS_ClassInfo["Death Knight"].Equip["Mail"] = nil
	GS_ClassInfo["Death Knight"].Equip["Leather"] = nil
	GS_ClassInfo["Hunter"].Equip["Cloth"] = nil
	GS_ClassInfo["Hunter"].Equip["Leather"] = 1
	GS_ClassInfo["Shaman"].Equip["Cloth"] = 1
	GS_ClassInfo["Shaman"].Equip["Leather"] = 1
	GS_ClassInfo["Rogue"].Equip["Cloth"] = nil
	GS_ClassInfo["Druid"].Equip["Cloth"] = 1
end

function GearScore_SetNone()
	GS_Settings["Restrict"] = 1
	GS_ClassInfo["Warrior"].Equip["Cloth"] = 1
	GS_ClassInfo["Warrior"].Equip["Mail"] = 1
	GS_ClassInfo["Warrior"].Equip["Leather"] = 1
	GS_ClassInfo["Paladin"].Equip["Cloth"] = 1
	GS_ClassInfo["Paladin"].Equip["Mail"] = 1
	GS_ClassInfo["Paladin"].Equip["Leather"] = 1
	GS_ClassInfo["Death Knight"].Equip["Cloth"] = 1
	GS_ClassInfo["Death Knight"].Equip["Mail"] = 1
	GS_ClassInfo["Death Knight"].Equip["Leather"] = 1
	GS_ClassInfo["Hunter"].Equip["Cloth"] = 1
	GS_ClassInfo["Hunter"].Equip["Leather"] = 1
	GS_ClassInfo["Shaman"].Equip["Cloth"] = 1
	GS_ClassInfo["Shaman"].Equip["Leather"] = 1
	GS_ClassInfo["Rogue"].Equip["Cloth"] = 1
	GS_ClassInfo["Druid"].Equip["Cloth"] = 1
end

function GearScore_DisplayDatabase(Group, SortType, Auto, GSX_StartPage)
	--GS_HighlightedColNum = 1
	if not ( Group ) then Group = "Party"; end
	GS_StartPage = GSX_StartPage
	if not ( GS_StartPage ) or ( GS_StartPage < 0 ) then GS_StartPage = 0; end
	
	GS_DisplayedGroup = Group; GS_DisplayFrame:Hide(); 	GS_DatabaseFrame:Show(); GS_DatabaseDisplayed =  1 
	if not ( SortType ) then SortType = "GearScore"; end
	GS_SortedType = SortType
	LibQTip:Release(GS_DatabaseFrame.tooltip)
   	GS_DatabaseFrame.tooltip = nil
	local tooltip = LibQTip:Acquire("GearScoreTooltip", 10, "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER")
	tooltip:SetCallback("OnMouseUp", GearScore_DatabaseOnClick)
	GS_DatabaseFrame.tooltip = tooltip 
	
--	GS_DatabaseFrame.tooltip:SetCell(lineNum, GS_HighlightedColNum, value[, font][, justification][, colSpan][, provider][, left][, rightPadding][, maxWidth, ...][, minWidth])

	tooltip:SetPoint("TOPLEFT", GS_DatabaseFrame, 10, -10)
				--tooltip:SetFrameStrata("LOW");
	tooltip:SetPoint("TOPRIGHT", GS_DatabaseFrame, -10, 0)
			--tooltip:SetPoint("BOTTOMLEFT", GS_DatabaseFrame, 0, 40)
    tooltip:SetFrameStrata("DIALOG")
	tooltip:SetHeight(420)
	tooltip:SetAlpha(100)
	tooltip:SetScale(1)
	tooltip:AddLine('#', 'GearScore', 'Name', "iLevel", 'Level', 'Race', 'Class', 'Guild', 'Days Old', 'Sent By'); tooltip:AddSeparator(1, 1, 1, 1)
	tooltip:SetColumnLayout(10, "CENTER", "CENTER", "LEFT", "CENTER", "CENTER", "LEFT", "LEFT", "CENTER", "CENTER", "LEFT") 


	local count = 1; local ColorString1 = ""; local ColorString2 = ""; local gsfunc = ""; local PartySize = 0; local GroupType = ""; local FactionColor = nil
	if not ( GSX_DataBase ) then GSX_DataBase = {}; GSX_DataBase = GearScore_BuildDatabase(Group); Auto = 0; end
	
	if not ( GS_SortDirection ) then GS_SortDirection = {}; end
	if ( Auto ~= 1 ) then 
		if ( GS_SortDirection[SortType] ) then GS_SortDirection[SortType] = GS_SortDirection[SortType] * -1; else GS_SortDirection[SortType] = 1; end
		if ( SortType == "Name" ) then GS_HighlightedColNum = 3; if ( GS_SortDirection[SortType] == 1 ) then table.sort(GSX_DataBase, function(a, b) return a.Name < b.Name end); else table.sort(GSX_DataBase, function(a, b) return a.Name > b.Name end); end; end
		if ( SortType == "GearScore" ) then GS_HighlightedColNum = 2; if ( GS_SortDirection[SortType] == 1 ) then table.sort(GSX_DataBase, function(a, b) return a.GearScore > b.GearScore end); else table.sort(GSX_DataBase, function(a, b) return a.GearScore < b.GearScore end); end; end
		if ( SortType == "iLevel" ) then GS_HighlightedColNum = 4; if ( GS_SortDirection[SortType] == 1 ) then table.sort(GSX_DataBase, function(a, b) return a.Average > b.Average end); else table.sort(GSX_DataBase, function(a, b) return a.Average < b.Average end); end; end
		if ( SortType == "Level" ) then GS_HighlightedColNum = 5; if ( GS_SortDirection[SortType] == 1 ) then table.sort(GSX_DataBase, function(a, b) return tonumber(a.Level) > tonumber(b.Level) end); else table.sort(GSX_DataBase, function(a, b) return tonumber(a.Level) < tonumber(b.Level) end); end; end
		if ( SortType == "Guild" ) then GS_HighlightedColNum = 8; if ( GS_SortDirection[SortType] == 1 ) then table.sort(GSX_DataBase, function(a, b) return a.Guild < b.Guild end); else table.sort(GSX_DataBase, function(a, b) return a.Guild > b.Guild end); end; end
		if ( SortType == "Class" ) then GS_HighlightedColNum = 7; if ( GS_SortDirection[SortType] == 1 ) then table.sort(GSX_DataBase, function(a, b) return GS_Classes[a.Class] < GS_Classes[b.Class] end); else table.sort(GSX_DataBase, function(a, b) return GS_Classes[a.Class] > GS_Classes[b.Class] end); end; end
		if ( SortType == "Date" ) then GS_HighlightedColNum = 9; if ( GS_SortDirection[SortType] == 1 ) then table.sort(GSX_DataBase, function(a, b) return a.Date > b.Date end); else table.sort(GSX_DataBase, function(a, b) return a.Date < b.Date end); end; end
		if ( SortType == "Race" ) then GS_HighlightedColNum = 6; if ( GS_SortDirection[SortType] == 1 ) then table.sort(GSX_DataBase, function(a, b) return GS_Races[a.Race] < GS_Races[b.Race] end); else table.sort(GSX_DataBase, function(a, b) return GS_Races[a.Race] > GS_Races[b.Race] end); end; end
		if ( SortType == "Scanned" ) then GS_HighlightedColNum = 10; if ( GS_SortDirection[SortType] == 1 ) then table.sort(GSX_DataBase, function(a, b) return a.Scanned < b.Scanned end); else table.sort(GSX_DataBase, function(a, b) return a.Scanned > b.Scanned end); end; end
	end		
	if ( GS_StartPage > (#(GSX_DataBase))) then GS_StartPage = GS_StartPage - 25; end
	local Recount = GS_StartPage
	for i,v in pairs(GSX_DataBase) do
	if ( i > GS_StartPage ) then
		local Red, Green, Blue = GearScore_GetQuality(v.GearScore) 
	
    	--if ( Red ) and ( Green ) and ( Blue ) then
    		Recount = Recount + 1
    		if ( v.Faction == "H" ) then FactionColor = "|cff"..string.format("%02x%02x%02x", 1 * 255, 0 * 255, 0 * 255); else  FactionColor = "|cff"..string.format("%02x%02x%02x", 0 , 162, 255); end   
  			ColorString1 = "|cff"..string.format("%02x%02x%02x", GS_ClassInfo[GS_Classes[v.Class]].Red * 255, GS_ClassInfo[GS_Classes[v.Class]].Green * 255, GS_ClassInfo[GS_Classes[v.Class]].Blue * 255)
  			local NowDate, NoWRed, NowGreen, NowBlue = GearScore_GetDate(v.Date) 
--  			print(NowDate, NoWRed, NowGreen, NowBlue)
			ColorStringDate = "|cff"..string.format("%02x%02x%02x", NoWRed * 255, NowGreen * 255, NowBlue * 255) 
--			ColorStringDate..NowDate
			local Red, Green, Blue = GearScore_GetQuality(v.GearScore) 
			ColorString2 = "|cff"..string.format("%02x%02x%02x", Red * 255, Blue * 255, Green * 255)
    	   	tooltip:AddLine(Recount, ColorString2..v.GearScore, ColorString1..v.Name, v.Average, ColorString1..v.Level, ColorString1..GS_Races[v.Race], ColorString1..GS_Classes[v.Class], FactionColor.."<"..v.Guild..">", ColorStringDate..NowDate, v.Scanned)
    	   	if ( i >= ( GS_StartPage + 25 ) ) then break; end
       	--else
		  -- print(v.Name, "doesn't have a GearScore!") 
	end
	end
	local SubRecount = ((Recount - (floor(Recount/25) * 25) ))
	if SubRecount == 0 then SubRecount = 25; end
	
	
	for i = count + SubRecount, 25 do 
		if ( i >= 26 ) then break; end
		tooltip:AddLine("    ", "                        ", "   ", "  ", "       ", "            ", "          "); 
	end
	tooltip:Show()
	--tooltip:SetColumnColor(GS_HighlightedColNum, 1, 1, 1, .5);
	tooltip:SetBackdropColor(.1,.1,.2,1)
end

function GearScore_SetSortingColor(ColNum, AlphaDirection, tooltip)

end

function GearScore_HideDatabase(erase)
	LibQTip.OnLeave()
    --GearScoreTooltip:ClearLines()
	local keepreport = nil
	if ( GS_ReportFrame:IsVisible() ) then keepreport = 1; end
   	--LibQTip:ReleaseAllCallbacks(GS_DatabaseFrame.tooltip)
    LibQTip:Release(GS_DatabaseFrame.tooltip)
   	GS_DatabaseFrame.tooltip = nil
   	GS_SortDirection = nil
   	GS_DatabaseFrame:Hide()
   	GS_ReportFrame:Hide()
	
	if ( keepreport == 1 ) then GS_ReportFrame:Show(); end
	if not (erase) then GS_DatabaseDisplayed =  nil; GSX_DataBase = nil; end
   
 end
 
 function GearScore_BuildDatabase(Group, Auto)
 	--print("Compiling Database")
 	local count = 1; local GSL_DataBase = {}
 	if ( Group == "Party" ) then 
	    if ( UnitName("raid1") ) then GroupType = "raid"; PartySize = 40; else GroupType = "party"; PartySize = 5; end
	    count = 0; for i = 1, PartySize do 
			if ( GS_Data[GetRealmName()].Players[UnitName(GroupType..i)] ) then 
				count = count + 1; GSL_DataBase[count] = GS_Data[GetRealmName()].Players[UnitName(GroupType..i)]; 
			else
				--GearScore_Request(UnitName(GroupType..i))
			end; 
		end
		if ( GroupType == "party" ) then GSL_DataBase[count+1] = GS_Data[GetRealmName()].Players[UnitName("player")]; end
	end
	if ( Group == "All" ) then count = 0;
		for i,v in pairs(GS_Data[GetRealmName()].Players) do
            if ( GS_Settings["AutoPrune"] == 1 ) then
				if ( GearScore_GetDate(v.Date) > (GS_Settings["DatabaseAgeSlider"] or 30 ) ) then
				    GS_Data[GetRealmName()].Players[i] = nil
				else
                    count = count+1; GSL_DataBase[count] = v;
				end
			else
			count = count+1; GSL_DataBase[count] = v;
			end
		end;
	end

	if ( Group == "Guild" ) then
	GuildRoster(); for i = 1, GetNumGuildMembers(1) do	if ( GS_Data[GetRealmName()].Players[GetGuildRosterInfo(i)] ) then GSL_DataBase[count] = GS_Data[GetRealmName()].Players[GetGuildRosterInfo(i)]; count = count + 1; end; end; end
 if ( Group == "Search" ) then count = 0; for i,v in pairs(GS_Data[GetRealmName()].Players) do local DataString = tostring(v.GearScore..v.Name..v.Level..v.Guild..GS_Classes[v.Class]..GS_Races[v.Race]); if string.find(strlower(DataString), strlower(GS_SearchXBox:GetText())) then count = count + 1; GSL_DataBase[count] = v; end; end; end
    if ( Group == "Friends" ) then GuildRoster(); for i = 1, GetNumFriends(1) do	if ( GS_Data[GetRealmName()].Players[GetFriendInfo(i)] ) then GSL_DataBase[count] = GS_Data[GetRealmName()].Players[GetFriendInfo(i)]; count = count + 1; end; end; end
	
	if Group == "All" then GSDatabaseInfoString:SetText("Database: "..count.." entries. (Approx "..floor(0.8372131704586988304093567251462 * count).."Kb)"); GS_Settings["DatabaseSize"] = count;
	else if GS_Settings["DatabaseSize"] then GSDatabaseInfoString:SetText("Database: "..GS_Settings["DatabaseSize"].." entries. (Approx "..floor(0.8372131704586988304093567251462 * GS_Settings["DatabaseSize"]).."Kb)"); end
	end
	return GSL_DataBase
end

 function GearScore_ShowReport()
 	GS_ReportFrame:Show()
 	GS_SliderText:SetText("Top: "..GS_Settings["Slider"])
 	GS_Slider:SetValue(GS_Settings["Slider"])
 end
 
 function GearScore_SendReport(Manual, G_Target, G_Who, G_Direction)
 	local Target = ""; local Who = ""; local Direction = ""; local Extra = ""
 	if ( GSXSayCheck:GetChecked() ) then Target = "SAY"; end
 	if ( GSXPartyCheck:GetChecked() ) then Target = "PARTY"; end
 	if ( GSXRaidCheck:GetChecked() ) then Target = "RAID"; end
 	if ( GSXGuildCheck:GetChecked() ) then Target = "GUILD"; end
 	if ( GSXOfficerCheck:GetChecked() ) then Target = "OFFICER"; end
	if ( GSXWhisperCheck:GetChecked() ) then Target = "WHISPER"; Who = GSX_WhisperEditBox:GetText(); end 	
	if ( GSXWhisperTargetCheck:GetChecked() ) then Target = "WHISPER"; Who = UnitName("target"); end 	
	if ( GSXChannelCheck:GetChecked() ) then Target = "CHANNEL"; Who = GSX_ChannelEditBox:GetText(); end 


	if ( Target == "" ) then print("Please check the box for where you would like the report to go."); return; end
	if not ( Who ) then return; end	
	if ( GS_SortDirection[GS_SortedType] == 1 ) then Direction = "Top"; else Direction = "Bottom"; end
	if ( GS_DisplayedGroup == "Search" ) then Extra = "'"..GS_SearchXBox:GetText().."'"; else Extra = GS_DisplayedGroup; end
	if ( GS_DisplayedGroup == "All" ) then Extra = "Entire Database"; end
	if ( Manual ) then Target = G_Target; Who = G_Who; Direction = "Top"; Extra = "GearScore"; end

	SendChatMessage(Direction.." ".." GearScore Reports for "..Extra.." sorted by "..GS_SortedType..".", Target, nil, Who);


	for i,v in ipairs(GSX_DataBase) do
		local DaysOld = GearScore_GetDate(v.Date)
		SendChatMessage("#"..i..".  "..v.GearScore.."    (iLevel "..v.Average..")     "..v.Name, Target, nil, Who)
	--	SendChatMessage("#"..i.." "..v.Name.."   "..v.GearScore.."  ("..v.Average..")   "..v.Level.." "..GS_Races[v.Race].." "..GS_Classes[v.Class], Target, nil, Who)
		if ( i >= GS_Settings["Slider"] ) then break; end
	end
 end
 
 function GearScore_SendSpamReport(Target, Who, Database)
 	SendChatMessage("Top".." ".." GearScore Reports for ".."group".." sorted by ".."GearScore"..".", Target, nil, Who);
 	for i,v in ipairs(Database) do
 		local DaysOld = GearScore_GetDate(v.Date)
		SendChatMessage("#"..i..".  "..v.GearScore.."    (iLevel "..v.Average..")     "..v.Name, Target, nil, Who)
		--SendChatMessage("#"..i.." "..v.Name.."   "..v.GearScore.."  ("..v.Average..")   "..v.Level.." "..GS_Races[v.Race].." "..GS_Classes[v.Class], Target, nil, Who)
		if ( i >= 26 ) then break; end
	end
 end
 
--------------------------------SETUP-----------------------------------------

function GearScore_TextureOnEnter()
--print("OnEnter!")
end

function GearScore_DatabaseOnClick(Event, Cell, Misc, Button)
	--LibQTip:Release(GearScoreTooltip)
	if ( Button == "RightButton" ) and ( Cell["_line"] > 2 ) and ( Cell["_column"] == 3 ) and ( GSX_DataBase[Cell["_line"]-2+GS_StartPage] )	then ChatFrameEditBox:Show(); ChatFrameEditBox:Insert("/t "..GSX_DataBase[Cell["_line"]-2+GS_StartPage].Name.." "); return; end
	
	if ( Cell["_line"] == 1 ) and ( Cell["_column"] == 2 ) then GearScore_DisplayDatabase(GS_DisplayedGroup, "GearScore", nil, GS_StartPage); return; end
	if ( Cell["_line"] == 1 ) and ( Cell["_column"] == 3 ) then GearScore_DisplayDatabase(GS_DisplayedGroup, "Name", nil, GS_StartPage); return; end
	if ( Cell["_line"] == 1 ) and ( Cell["_column"] == 4 ) then GearScore_DisplayDatabase(GS_DisplayedGroup, "iLevel", nil, GS_StartPage); return; end
	if ( Cell["_line"] == 1 ) and ( Cell["_column"] == 5 ) then GearScore_DisplayDatabase(GS_DisplayedGroup, "Level", nil, GS_StartPage); return; end
	if ( Cell["_line"] == 1 ) and ( Cell["_column"] == 6 ) then GearScore_DisplayDatabase(GS_DisplayedGroup, "Race", nil, GS_StartPage); return; end
	if ( Cell["_line"] == 1 ) and ( Cell["_column"] == 7 ) then GearScore_DisplayDatabase(GS_DisplayedGroup, "Class", nil, GS_StartPage); return; end
	if ( Cell["_line"] == 1 ) and ( Cell["_column"] == 8 ) then GearScore_DisplayDatabase(GS_DisplayedGroup, "Guild", nil, GS_StartPage); return; end
	if ( Cell["_line"] == 1 ) and ( Cell["_column"] == 9 ) then GearScore_DisplayDatabase(GS_DisplayedGroup, "Date", nil, GS_StartPage); return; end	
	if ( Cell["_line"] == 1 ) and ( Cell["_column"] == 10 ) then GearScore_DisplayDatabase(GS_DisplayedGroup, "Scanned", nil, GS_StartPage); return; end
	--print("pie", Cell["_line"], Cell["_column"]) 
	local LineCount = GS_DatabaseFrame.tooltip:GetLineCount(); if not ( LineCount ) then LineCount = 0; end
	--print(LineCount)
	if ( Cell["_line"] > 2 ) and ( Cell["_column"] == 3 ) and ( GSX_DataBase[Cell["_line"]-2] ) and ( Cell["_line"] ~= 28 ) then --GearScore_Send(GSX_DataBase[Cell["_line"]-2+GS_StartPage].Name, "ALL"); 
	GearScore_DisplayUnit(GSX_DataBase[Cell["_line"]-2+GS_StartPage].Name); return; end
	if ( Cell["_line"] > 2 ) and ( Cell["_column"] == 6 ) and ( GSX_DataBase[Cell["_line"]-2] ) then GS_SearchXBox:SetText(GS_Races[(GSX_DataBase[Cell["_line"]-2+GS_StartPage].Race)]); GearScore_HideDatabase(); GearScore_DisplayDatabase("Search"); return; end
	if ( Cell["_line"] > 2 ) and ( Cell["_column"] == 7 ) and ( GSX_DataBase[Cell["_line"]-2] ) then GS_SearchXBox:SetText(GS_Classes[(GSX_DataBase[Cell["_line"]-2+GS_StartPage].Class)]); GearScore_HideDatabase(); GearScore_DisplayDatabase("Search"); return; end
	if ( Cell["_line"] > 2 ) and ( Cell["_column"] == 8 ) and ( GSX_DataBase[Cell["_line"]-2] ) then GS_SearchXBox:SetText((GSX_DataBase[Cell["_line"]-2+GS_StartPage].Guild)); GearScore_HideDatabase(); GearScore_DisplayDatabase("Search"); return; end
--tooltip:AddHeader('#', 'GearScore', '  Name ', "iLevel", 'Level', '  Race   ', ' Class   ', 'Date'); tooltip:AddSeparator(1, 1, 1, 1)
end

function GearScore_Exchange(Type, Who)
 	if Type == "DATABASE" then
	    GS_ExchangeDatabase =  GearScore_BuildDatabase("All")
		GS_ExchangeName = Who
		GS_ExchangeCount = 1
		GearScore_ContinueExchange()
		print("GearScore Database Transmission In Progress")
    end
end

function GearScore_ContinueExchange()
 	for i = 1,5 do
 	if not GS_ExchangeCount then return; end
	if ( GS_ExchangeDatabase[GS_ExchangeCount] ) then
   			GearScore_Send(GS_ExchangeDatabase[GS_ExchangeCount].Name, "WHISPER", GS_ExchangeName)
			GS_ExchangeCount = GS_ExchangeCount + 1
		else
		print("GearScore Database Transmission complete!")
		GS_ExchangeCount = nil
		GS_ExchangeName = nil
		GS_ExchangeDatabase = nil
		GearScore_TimerFrame:Hide()
		end
	end
	GearScore_TimerFrame:Show()
end


if not GearScore_TimerFrame then GearScore_TimerFrame = CreateFrame("Frame") end

function GearScoreCalculateEXP()
	STable = nil
	local STable = {}
	local TotalPoints = 0
	local count = 0
	local SuperCount = 0
	local StatString = ""
	local id = 0
	--local BackString = {}
	for j = 1, 61 do
		id = GetAchievementInfo(14823, j)
		for i,v in pairs(GS_AchInfo) do
			if v[id] then
			 --   SuperCount = SuperCount + 1
				count = GetComparisonStatistic(id);
				if ( count == "--" ) then count = 0; end
				if ( tonumber(count) > 5 ) then count = 5; end
				STable[GS_BackString[id]] = count
			end
		end
		--BackString[id] = SuperCount
	end
	for j = 1, 30 do
		id = GetAchievementInfo(14963, j)
		for i,v in pairs(GS_AchInfo) do
			if v[id] then
		--	SuperCount = SuperCount + 1
				count = GetComparisonStatistic(id);
				if ( count == "--" ) then count = 0; end
				if ( tonumber(count) > 5 ) then count = 5; end
				STable[GS_BackString[id]] = count
			 end
		end
		--BackString[id] = SuperCount
	end
	for j = 15, 38 do
		id = GetAchievementInfo(15021, j)
		for i,v in pairs(GS_AchInfo) do
			if v[id] then
		--	SuperCount = SuperCount + 1
				--print(count,i,v[id])
				count = GetComparisonStatistic(id);
				--print(count,i,v[id])
                if ( count == "--" ) then count = 0; end
				if ( tonumber(count) > 5 ) then count = 5; end
    			STable[GS_BackString[id]] = count
				--print(GS_BackString[id], count, id)
		 	end
		end
    --BackString[id] = SuperCount
	end

	for j = 17, 68 do
		id = GetAchievementInfo(15062, j)
		for i,v in pairs(GS_AchInfo) do
			if v[id] then
		--	SuperCount = SuperCount + 1
				--print(count,i,v[id])
				count = GetComparisonStatistic(id);
				--print(count,i,v[id])
                if ( count == "--" ) then count = 0; end
				if ( tonumber(count) > 5 ) then count = 5; end
    			STable[GS_BackString[id]] = count
				--print(GS_BackString[id], count, id)
		 	end
		end
    --BackString[id] = SuperCount
	end	
	
	
	
	
	if GS_Settings["BackString"] then GS_Settings["BackString"] = nil; end
	--GS_Settings["BackString"] = BackString
	StatString = ""
	for i,v in ipairs(STable) do
		StatString = StatString..v
	end
	--print(StatString)
	
	--	if UnitName("target") then

		    if not ( GS_Data[GetRealmName()]["CurrentPlayer"] ) then GS_Data[GetRealmName()]["CurrentPlayer"] = {}; end
		    
		--	if GS_Data[GetRealmName()].Players[UnitName("mouseover")] then
   			   GS_Data[GetRealmName()]["CurrentPlayer"]["EXP"] = StatString
				--SendAddonMessage("GSZZZ", StatString, "GUILD")
				--SendAddonMessage("GSZZZ", StatString, "PARTY")
	--		end
	--	end

end

function GS_DisplayXP(Name)
	--print("Displaying", Name)
	GS_XpedName = Name
	local StatTable = {}; --local RangeCheck = nil
	StatTable, RangeCheck = GS_DecodeStats(Name)
	local barcount = 0
	if not StatTable  then print("OutofRange"); return; end
	for i,v in ipairs(GS_InstanceOrder) do
		local RangeCheck = nil
	    if not (StatTable[v]) then StatTable[v] = 0; end
		barcount = barcount + 1
		local PPValue = (floor(( StatTable[v] / GS_AchMax[v] ) * 100 ))
		local red,green,blue = 0,0,0
		_G["GS_XpBar"..barcount]:SetValue(PPValue )

		
		if ( PPValue < 50 ) then  red, green, blue = 1,(PPValue / 50),(PPValue / 100); end
		if ( PPValue >= 50 ) then red, green, blue = 1 - ((PPValue - 50) * 0.02), 1, 0.5 - ((PPValue - 50) * 0.01) ; end
		_G["GS_XpBar"..barcount]:SetStatusBarColor(red, green, blue)		
        _G["GS_XpBar"..barcount.."PercentText"]:SetText(PPValue .."%")
        if not ( UnitName("target") ) then _G["GS_XpBar"..barcount.."PercentText"]:SetText("No Target"); end
        --if ( RangeCheck ) then _G["GS_XpBar"..barcount.."PercentText"]:SetText("Out of Range / No target"); end
		_G["GS_XpBar"..barcount.."InstaceText"]:SetText(v)
	end
end

function GS_DecodeStats(Name)
	--print("DecodingStats for ", Name)
	local StatTable = {}
	local count = 0; --local RangeCheck = nil
	local StatString = ""
	if not GS_Data[GetRealmName()]["CurrentPlayer"] then GS_Data[GetRealmName()]["CurrentPlayer"] = {}; end
	if GS_Data[GetRealmName()].Players[Name] then
	    if GS_Data[GetRealmName()]["CurrentPlayer"]["EXP"] then
			StatString = GS_Data[GetRealmName()]["CurrentPlayer"]["EXP"]
		else
			for i = 1,114 do
			StatString = StatString.."0"
			end
			--RangeCheck = true
		end
	end
		for i,v in pairs(GS_BackString) do
		    count = tonumber(string.sub(StatString, v, v))
        	for j, w in pairs(GS_AchInfo) do
				if w[i] then
					StatTable[j] = (StatTable[j] or 0) + ( count or 0 );
					--if not count then print(j, i, v); end
					break;
				end

			end
		end
		return StatTable, RangeCheck
end



hooksecurefunc("SetItemRef",GearScoreSetItemRef)

GearScore_TimerFrame:Hide()
GearScore_TimerFrame:SetScript("OnUpdate", GearScore_OnUpdate)
local f = CreateFrame("Frame", "GearScore", UIParent);
f:SetScript("OnUpdate", GearScore_ThrottleUpdate)
f:SetScript("OnEvent", GearScore_OnEvent);
f:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
f:RegisterEvent("CHAT_MSG_ADDON");
f:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
f:RegisterEvent("PLAYER_TARGET_CHANGED")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
GameTooltip:HookScript("OnTooltipSetUnit", GearScore_HookSetUnit)
GameTooltip:HookScript("OnTooltipSetItem", GearScore_HookSetItem)
ShoppingTooltip1:HookScript("OnTooltipSetItem", GearScore_HookCompareItem)
ShoppingTooltip2:HookScript("OnTooltipSetItem", GearScore_HookCompareItem2)
PaperDollFrame:HookScript("OnShow", MyPaperDoll)
PaperDollFrame:CreateFontString("PersonalGearScore")
PersonalGearScore:SetFont("Fonts\\FRIZQT__.TTF", 10)
PersonalGearScore:SetText("GS: 0")
PersonalGearScore:SetPoint("BOTTOMLEFT",PaperDollFrame,"TOPLEFT",72,-253)
PersonalGearScore:Show()
PaperDollFrame:CreateFontString("GearScore2")
GearScore2:SetFont("Fonts\\FRIZQT__.TTF", 10)
GearScore2:SetText("GearScore")
GearScore2:SetPoint("BOTTOMLEFT",PaperDollFrame,"TOPLEFT",72,-265)
GearScore2:Show()
ItemRefTooltip:HookScript("OnTooltipSetItem", GearScore_HookRefItem)
GearScore_Original_SetInventoryItem = GameTooltip.SetInventoryItem
GameTooltip.SetInventoryItem = GearScore_OnEnter
SlashCmdList["MYSCRIPT"] = GS_SPAM
SLASH_MYSCRIPT1 = "/gspam";
SlashCmdList["MY2SCRIPT"] = GS_MANSET
SLASH_MY2SCRIPT1 = "/gset"
SLASH_MY2SCRIPT3 = "/gearscore"
SlashCmdList["MY3SCRIPT"] = GS_SCANSET
SLASH_MY3SCRIPT3 = "/gs"
SLASH_MY3SCRIPT1 = "/gscan"
SLASH_MY3SCRIPT2 = "/gsearch"
SlashCmdList["MY4SCRIPT"] = GS_BANSET
SLASH_MY4SCRIPT1 = "/gsban"
GS_DisplayFrame:Hide()
LibQTip = LibStub("LibQTipClick-1.1")



