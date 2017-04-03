RaidRollHasLoaded = true



function RR_LootSettings_Setup()


--[[
	_G["LootButton2"]:SetScript("OnMouseDown",	function()
												RR_Test("pressed")
											end
	)
]]
end



RR_ListOfIcons={}
RR_NumberOfIcons = 5

RR_ListOfIcons = {"","! ","(N)","(G)","(NG)"}









 


function RR_LootWindowEvent(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6 = ...;

	if event == "CHAT_MSG_ADDON" then
		if arg1 == "RRL" then
			if RaidRoll_DB["debug"] == true then 
				RR_Test("---Addon messages---")
				RR_Test(event)
				RR_Test(arg1)
				RR_Test(arg2)
				RR_Test(arg3)
				RR_Test(arg4)
				RR_Test(arg5)
				RR_Test(arg6)
			end
			
			
			
		-- change this to send it after 5 seconds
			if arg2 == "Request" then
				
			-- only send info if its more than 5 seconds since the last request
				if time() >= RR_LastItemDataReSent + 5 then 
					RR_LastItemDataReSent = time()
					RR_SendRequestFrame:SetScript("OnUpdate",	function() 
																	if time() >= RR_LastItemDataReSent + 5 then
																		RR_SendItemInfo()
																		RR_SendRequestFrame:SetScript("OnUpdate",	function() end)
																	end
																end)
				end
			else
				if RaidRoll_LootTrackerLoaded == true then
					RR_AddonMessageReceived(arg2,arg3)
				end
			end
		end
	end

	
	if event == "LOOT_OPENED" then
		if RaidRoll_DB["debug"] == true then 
			RR_Test(event)
			RR_Test(arg1)
			RR_Test(arg2)
		end
		
		RR_SendItemInfo()
	end
end



function RR_SendItemInfo()
local 	player_name,mob_name,mob_guid,numLootItems,
		LootNumber,WeHaveFoundAnItem,ItemLink,AcceptItem,
		DontAcceptItem,AcceptableZone,ZoneName,Seperator,
		Version,String,ItemId

	player_name = UnitName("player"); 
	mob_name = UnitName("target"); 
	mob_guid = UnitGUID("target");
	
	if mob_guid == nil then mob_guid = "0xF1008F32001790BE" end
	
	
-- Check if we are looking at a mob
	if mob_guid ~= nil then
	
	-- Breakdown the guid to see if its an npc
		local B = tonumber(mob_guid:sub(5,5), 16);
		local maskedB = B % 8; -- x % 8 has the same effect as x & 0x7 on numbers <= 0xf
		local knownTypes = {[0]="player", [3]="NPC", [4]="pet", [5]="vehicle"};
		if knownTypes[maskedB] ~= nil then 
			Type = knownTypes[maskedB]
		else
			Type = "unknown entity!"
		end
		if RaidRoll_DB["debug"] == true then RR_Test("Your target is a " .. Type); end
		
		if Type ~= "NPC" then mob_name = "Unknown" end
		
--		if RaidRoll_DB["debug"] == true then RR_Test(mob_name.." has the GUID: "..mob_guid); end
		
	-- Create an array for the mob GUID
--		if RaidRoll_DB["Loot"][mob_guid] == nil then RaidRoll_DB["Loot"][mob_guid] = {} end
		
		
--		if RaidRoll_DB["Loot"][mob_guid]["ALREADY FOUND"] == nil then
			
		-- Set it so that we know the mob has been found
--			RaidRoll_DB["Loot"][mob_guid]["ALREADY FOUND"] = true
--			if RaidRoll_DB["debug"] == true then RR_Test("New Mob Found!") end
			
		-- Get the number of items on the body
			numLootItems = GetNumLootItems();
			
			LootNumber = 0
			
		-- Check if the mob has loots
			if numLootItems ~= nil then
				if RaidRoll_DB["debug"] == true then RR_Test("The Mob Has Loots!") end
				if RaidRoll_DB["debug"] == true then RR_Test(numLootItems .. " items found") end
				
			-- Used later to see if an item was found yet
				WeHaveFoundAnItem = false
				
			-- Start scanning for items
				for i=1,numLootItems do
				-- If its an item
					if LootSlotIsItem(i) then
						if WeHaveFoundAnItem == false then
						-- If we are currently looking at the last window
	--						if RaidRoll_DB["Loot"]["TOTAL WINDOWS"] == RaidRoll_DB["Loot"]["CURRENT WINDOW"] then
							--then increment the current window ID
	--							RaidRoll_DB["Loot"]["CURRENT WINDOW"] = RaidRoll_DB["Loot"]["CURRENT WINDOW"] + 1
	--						end
							
						-- Add a window to the list of windows
	--						RaidRoll_DB["Loot"]["TOTAL WINDOWS"] = RaidRoll_DB["Loot"]["TOTAL WINDOWS"] + 1
	--						Max_LootID = RaidRoll_DB["Loot"]["TOTAL WINDOWS"]
							
							
						-- Set the Identifier to the mob guid
	--						if RaidRoll_DB["Loot"][Max_LootID] == nil then RaidRoll_DB["Loot"][Max_LootID] = mob_guid end
							
							WeHaveFoundAnItem = true
						end
						
						--for j=1,10 do
							
						-- Increase the count by 1 (because an item was found)
							LootNumber = LootNumber + 1
							
						-- Get the ICON and ITEMLINK
							local lootIcon, lootName, lootQuantity, rarity = GetLootSlotInfo(i);
							ItemLink = GetLootSlotLink(i); 
							
							if ItemLink ~= nil then
								
							-- Create an array
								if RR_Check_lootName == nil then RR_Check_lootName = {} end
								
								AcceptItem = false
								
								local _, _, _, _, ItemId = string.find(ItemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
								ItemId = tonumber(ItemId)
								
								local _, _, _, ItemLvl = GetItemInfo(ItemId);
								ItemLvl = tonumber(ItemLvl);
								
							-- Special rare items that should be included
								if 	ItemId == 	46110 	or		-- Alchemist's Cache
									ItemId == 	47556	or		-- Crusader Orb
									ItemId == 	45087	or		-- Runed Orb
									ItemId == 	49908	then	-- Primordial Saronite
										AcceptItem = true
										if RaidRoll_DB["debug"] == true then RR_Test("[Rarity] This is an acceptable Item - " .. lootName) end
								else
									if RaidRoll_DB["debug"] == true then RR_Test("[Rarity] This is >NOT< an acceptable Item - " .. lootName) end
								end
								
								
								DontAcceptItem = false
							-- Special epic items that should not be included
								if 	ItemId == 	34057 	or		-- Abyss Crystal
								
									ItemId == 	36931	or		-- Ametrine
									ItemId == 	36919	or		-- Cardinal Ruby
									ItemId == 	36928	or		-- Dreadstone
									ItemId == 	36934	or		-- Eye of Zul
									ItemId == 	36922	or		-- King's Amber
									ItemId == 	36925	or		-- Majestic Zircon
									
									ItemId == 	47241	or		-- Emblem of Triumph
									ItemId == 	49426	then	-- Emblem of Frost
										DontAcceptItem = true
										if RaidRoll_DB["debug"] == true then RR_Test("[Epic Items] This is >NOT< an acceptable Item - " .. lootName) end
								else
									if RaidRoll_DB["debug"] == true then RR_Test("[Epic Items] This is an acceptable Item - " .. lootName) end
								end
								
								AcceptableZone = false
								
							-- Non-Localized zone info
								ZoneName = GetRealZoneText();
								
								if 	ZoneName == "Trial of the Crusader" or
									ZoneName == "Icecrown Citadel" or
									ZoneName == "Naxxramas" or
									ZoneName == "Onyxia's Lair" or
									ZoneName == "The Eye of Eternity" or
									ZoneName == "The Obsidian Sanctum" or
									ZoneName == "Ulduar" or
									ZoneName == "Vault of Archavon" then
										AcceptableZone = true
										if RaidRoll_DB["debug"] == true then RR_Test("This is an acceptable Zone - " .. ZoneName) end
								else
									if RaidRoll_DB["debug"] == true then RR_Test("This is >NOT< an acceptable zone - " .. ZoneName) end
								end
								
								if RaidRoll_DBPC[UnitName("player")]["RR_Frame_WotLK_Dung_Only"] == false then
									local name, ins_type, _, _, maxPlayers = GetInstanceInfo()
									if RaidRoll_DB["debug"] == true then RR_Test("ins_type - " .. ins_type) end
									if ins_type == "raid" or RaidRoll_DB["debug"] == true then
										AcceptableZone = true
										if RaidRoll_DB["debug"] == true then RR_Test("This is a Raid - " .. ZoneName) end
									end
								end
								
								
								--[[
								Trial of the Crusader
								Icecrown Citadel
								Naxxramas
								Onyxia's Lair
								The Eye of Eternity
								The Obsidian Sanctum
								Ulduar
								Vault of Archavon
								]]
								
								RR_Check_lootName[LootNumber] = lootName
								LootCount = 0
								RR_Temp_lootName = lootName
								
								if LootNumber > 1 then
									for i = 1,LootNumber-1 do
									-- Check if the lootName is the same as one in the list
										if lootName == RR_Check_lootName[i] then
											LootCount = LootCount + 1
											lootName = RR_Temp_lootName .. LootCount
											RR_Check_lootName[LootNumber] = lootName
										end
									end
								end
								
								
						--		local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(ItemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
								
								--if RaidRoll_DB["debug"] == true then RR_Test("Item ID = " .. Id) end
								
								Seperator = "\a" -- "\226\149\145"
								Version = "Beta_2"
								
								String = ""
								
								--[[ beta string format
								String = (
											Version .. Seperator .. 
											player_name .. Seperator .. 
											mob_name .. Seperator .. 
											ItemId .. Seperator ..
											lootName.. Seperator ..
											ItemLvl
										) 
								]]--
								
								String = (
											Version .. Seperator .. 
											player_name .. Seperator .. 
											mob_name .. Seperator .. 
											ItemId .. Seperator ..
											lootName .. Seperator ..
											ItemLvl
										) 
								
								if time() >= RR_LastItemDataReSent + 60 then
									RR_LastItemDataReSent = time() - 10
									SendAddonMessage( "RRL", "Request" ,"RAID" );
								end
								
								
								
	--[[
	/cast [target=focus] Tricks of the Trade
	/run SendChatMessage("ToTT nuke!" ,"WHISPER" ,nil ,UnitName("focus"));

								
								UnitName("focus")
	]]
								
								

								
								--[[
								0 for grey, 
								1 for white items and quest items, 
								2 for green, 
								3 for blue,
								4 for epic,
								5 for legendary,
								]]
								
							-- Send items with epic or higher quality, also send items on the acceptable items list. Also, only send items from an acceptable zone (raid)
								if rarity > 3 or RaidRoll_DB["debug"] == true or AcceptItem == true then
									if AcceptableZone == true or RaidRoll_DB["debug"] == true then
										if DontAcceptItem == false or RaidRoll_DB["debug"] == true then
											if UnitInRaid("player") ~= nil then
												SendAddonMessage( "RRL", 
																		String
																,"RAID" );
											end
											
											if IsInGuild() then
												SendAddonMessage( "RRL", 
																		String
																,"GUILD" );
											end
										end
									end
								end
								
			--					RaidRoll_DB["Loot"][mob_guid]["LOOTER NAME"] 	= player_name
			--					RaidRoll_DB["Loot"][mob_guid]["MOB NAME"] 		= mob_name
			--					RaidRoll_DB["Loot"][mob_guid]["TOTAL ITEMS"] 	= LootNumber
								
								
			--					if RaidRoll_DB["Loot"][mob_guid]["ITEM_" .. LootNumber] == nil then RaidRoll_DB["Loot"][mob_guid]["ITEM_" .. LootNumber] = {} end
								
			--					RaidRoll_DB["Loot"][mob_guid]["ITEM_" .. LootNumber]["ITEMLINK"] 	= ItemLink
			--					RaidRoll_DB["Loot"][mob_guid]["ITEM_" .. LootNumber]["ICON"]		= lootIcon
			--					RaidRoll_DB["Loot"][mob_guid]["ITEM_" .. LootNumber]["WINNER"]		= "-"
			--					RaidRoll_DB["Loot"][mob_guid]["ITEM_" .. LootNumber]["RECEIVED"]	= "-"
							--end
							
							
							if RaidRoll_DB["debug"] == true then 
								RR_Test(ItemLink)
								RR_Test(lootIcon)
								RR_Test(lootName)
								RR_Test(lootQuantity)
								RR_Test(rarity)	
							end
							
							if RaidRoll_LootTrackerLoaded == true then
								RR_Loot_Display_Refresh()	
							end
						end
					end
				end
			--end	
		end
	end
end




--	--	--	--	--	--	--	--	--	--	--	--
--		USED TO DISPLAY TOOLTIPS THEN MOUSING	--
--		OVER A BUTTON. THE FRAME NAME IS			--
--		PASSED AS "ID" AND THE TOOLTIPS ARE		--
--		STORED IN THE "RR_Tooltips" ARRAY.			--
--	--	--	--	--	--	--	--	--	--	--	--
function RR_MouseOverTooltip(ID)
	if RR_Tooltips == nil then 
		RR_Tooltips = {}
	end
	
	RR_Tooltips[ID]=RAIDROLL_LOCALE[ID]
	
-- Displays tooltip for rollers
	if ID ~= nil then
		if string.find(ID, "Raid_Roll_SetSymbol") then
		
		CharID = tonumber(string.sub(ID,20))
		
		if RaidRoll_DB["debug"] == true then
			RR_Test(ID)
			RR_Test(CharID)--Raid_Roll_SetSymbol
		end
		
		if RR_RollData ~= nil and RR_RollData[rr_CurrentRollID] ~= nil and RR_RollData[rr_CurrentRollID][CharID] ~= nil then
			RR_Tooltips[ID] = RollerName[rr_CurrentRollID][CharID] .. " " .. RollerRoll[rr_CurrentRollID][CharID] .. " " .. RR_RollData[rr_CurrentRollID][CharID]["LowHigh"]
			if RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] ==  true then
				RR_Tooltips[ID] = RollerName[rr_CurrentRollID][CharID] .. " " .. RR_RollData[rr_CurrentRollID][CharID]["EPGPValues"] .. " PR:" .. RR_EPGP_PRValue[rr_CurrentRollID][CharID]	
			end
		else
			RR_Tooltips[ID] = ""
		end
		
		--[[
		RollerName[rr_rollID][j]
		RollerRoll[rr_rollID][j]
		RR_EPGP_PRValue[rr_rollID][j]
		
		RR_EPGP_EPGPValues[rr_rollID][j]
		RaidRoll_LowHigh[rr_rollID][j]
		]]
		end
	end
	
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
	GameTooltip:ClearAllPoints(); 
	GameTooltip:SetPoint("bottomleft", _G[ID], "top", 0, 0)
	GameTooltip:ClearLines()
	GameTooltip:SetText(RR_Tooltips[ID])
end







--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function RR_Test(msg)
	if type(msg) ~= "string" then
		msg = tostring(msg)
	end
	if DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
end

function RR_SetupSlashCommands()
 SLASH_RR1 = "/rr";
 SLASH_RR2 = "/raidroll";
 SLASH_RR3 = "/rrl";
 
 
 SlashCmdList["RR"] =  RR_Command;
end

function RaidRoll_OnLoad(self)
 
 RR_Test("Kilerpet's Raid Roll Addon - Loaded")
 
-- local f = CreateFrame("Frame")
 
  self:RegisterEvent("CHAT_MSG_SYSTEM")
  
  self:RegisterEvent("CHAT_MSG_PARTY")
  self:RegisterEvent("CHAT_MSG_PARTY_LEADER")
  
  self:RegisterEvent("CHAT_MSG_RAID")
  self:RegisterEvent("CHAT_MSG_RAID_LEADER")
  self:RegisterEvent("CHAT_MSG_RAID_WARNING")
  self:RegisterEvent("CHAT_MSG_SAY")
  self:RegisterEvent("CHAT_MSG_YELL")
  self:RegisterEvent("CHAT_MSG_WHISPER")
  --self:RegisterEvent("CHAT_MSG_ADDON")
  self:RegisterEvent("GUILD_ROSTER_UPDATE"); 
  self:RegisterEvent("ADDON_LOADED");   
  self:RegisterEvent("VARIABLES_LOADED");-- Fired when saved variables are loaded

  RR_ClearAllData_Startup()
  
--  f:SetScript("OnEvent", RaidRoll_Event)


-- Hook Looting events
 local RR_LootEventHook = CreateFrame("Frame")
 
  RR_LootEventHook:RegisterEvent("LOOT_OPENED")
  RR_LootEventHook:RegisterEvent("CHAT_MSG_ADDON")
  
  
 RR_LootEventHook:SetScript("OnEvent", RR_LootWindowEvent)
  
end
  
function RR_ClearAllData_Startup()
  RR_Has_Rolled = false
  RR_Rolling_on_item = true
  
  rr_rollID = 0
  rr_CurrentRollID = 0
  
  RR_ScrollOffset = 0
  
-- Define the various arrays
  rr_Roll = {}
  rr_PlayersRolled = {}
  rr_Item = {}
  rr_playername = {}
  RollerRoll = {}
  RollerName = {}
  RollerGroup = {}
  MaxPlayers = {}
  RollerFirst = {}
  RollerRank = {}
  RollerRankIndex = {}
  HasRolled = {}
  Roll_Number = {}
  RR_LegitRoll = {}
  RaidRoll_LegitRoll = {}
  if RaidRoll_DBPC == nil then RaidRoll_DBPC = {} end
  if RaidRoll_DBPC[UnitName("player")] == nil then RaidRoll_DBPC[UnitName("player")] = {} end
  if RaidRoll_DBPC[UnitName("player")]["RR_NameMark"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_NameMark"] = {} end
  if RaidRoll_DBPC[UnitName("player")]["RR_PlayerIconID"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_PlayerIconID"] = {} end
  if RaidRoll_DBPC[UnitName("player")]["RR_PlayerIcon"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_PlayerIcon"] = {} end
  RollerColor = {}
  RR_EPGPAboveThreshold = {}
  RR_EPGP_PRValue = {}
  RR_RollData = {}
  


  rr_Item[0] = "ID #0"
  
  RollerName[0] = {}
  
  RollerName[0][1] = ""
  
  RR_Timestamp = 0
  
  RR_Doing_a_New_Roll = false
  
  if RR_LastItemDataReSent == nil then RR_LastItemDataReSent = time() - 60 end
  RR_SendRequestFrame = CreateFrame("Frame")

  
  
end

function RaidRoll_Window_Scroll(direction)

-- Debugging, shows the direction and value
if RaidRoll_DB["debug"] == true then RR_Test(direction) end
if RaidRoll_DB["debug"] == true then RR_Test(RaidRoll_Slider:GetValue()) end

-- Dont scroll unless a maxplayers value exists
	if MaxPlayers[rr_CurrentRollID] ~= nil then
		if MaxPlayers[rr_CurrentRollID] >= 5 then
			RaidRoll_MaxNumber = MaxPlayers[rr_CurrentRollID]-4
		--else
			--RaidRoll_MaxNumber = 1
		--end
			
			RaidRoll_MaxNumber_Slider = RaidRoll_MaxNumber
			
			if rr_CurrentRollID > 0 and RaidRoll_MaxNumber > 1 then RaidRoll_MaxNumber_Slider = RaidRoll_MaxNumber - 1 end
			
			RaidRoll_Slider:SetMinMaxValues(1, RaidRoll_MaxNumber_Slider)
			
			
			RaidRoll_Slider:SetValue(RaidRoll_Slider:GetValue() - (direction * 3))
			
			if RaidRoll_Slider:GetValue() > RaidRoll_MaxNumber then
				RaidRoll_Slider:SetValue(RaidRoll_MaxNumber)
			end
			
			RR_ScrollOffset = RaidRoll_Slider:GetValue() - 1
			
			--for i=1, 5 do
				--if InviteHelper_Position[i+RaidRoll_Slider:GetValue()] ~= nil then
				--	_G["InviteHelper_GMButton_name" .. i]:SetText(i+RaidRoll_Slider:GetValue() - 1 .. ": " .. RaidRoll_Position[i+RaidRoll_Slider:GetValue()])		
				--else
				--	_G["InviteHelper_GMButton_name" .. i]:SetText("")	
				--end
			--end
			
		 --RaidRoll_Slider.tooltipText = RaidRoll_Slider:GetValue() .. " - " .. RaidRoll_Slider:GetValue() + 4
		 
			RR_Display(rr_CurrentRollID)
			
			
		end
	end
end

-- TOGGLE THE OPTIONS MENU
function RR_Roll_Options_Toggle()

	if RR_BottomFrame:IsShown() then
		_G["RaidRoll_Catch_All"]:Hide()
		_G["RaidRoll_Allow_All"]:Hide()
		RR_BottomFrame:Hide()
	else
		_G["RaidRoll_Catch_All"]:Show()
		_G["RaidRoll_Allow_All"]:Show()
		RR_BottomFrame:Show()
	end


end
----------------------------------------------------------------------------------------------

function RaidRoll_Event(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6 = ...;
  
	if event == "CHAT_MSG_ADDON" and arg1 == "RAIDROLL" then
		RR_Test("|cFF11aacc" .. arg2 .. " found.")
		if RaidRoll_DB == nil then RaidRoll_DB = {} end
		if RaidRoll_DB["Amount"] == nil then RaidRoll_DB["Amount"] = 1 end
		if RaidRoll_DB["Names"] == nil then RaidRoll_DB["Names"] = {} end
		
		RR_CharacterWasFound = false
		
		for i=1,RaidRoll_DB["Amount"] do
			if RaidRoll_DB["Names"][i] == arg2 then RR_CharacterWasFound = true	end
		end
			
		if RR_CharacterWasFound == false then
			RaidRoll_DB["Names"][RaidRoll_DB["Amount"]] = arg2
			RaidRoll_DB["Amount"] = RaidRoll_DB["Amount"] + 1
		end
	end

		
-- Set up the variables with default values and set up the check boxes
	if event == "VARIABLES_LOADED" then
		RR_SetupVariables()	
		RR_SetupSlashCommands()
		RR_EPGP_Setup()
		RR_LootSettings_Setup()
	end
	
	
	if event == "GUILD_ROSTER_UPDATE" then
		RR_GuildRankUpdate()
	end

-- Debugging, show the events that occured and the arguments
	if RaidRoll_DB ~= nil then
		if RaidRoll_DB["debug"] == true then 
			
			if arg1 == nil or (arg1 ~= nil and (arg1 ~= "Crb" and arg1 ~= "LGP")) then
				RR_Test("An event has occured")
				RR_Test(event) 
				if arg1 ~= nil then RR_Test("1 .. " .. arg1) end
				if arg2 ~= nil then RR_Test("2 .. " .. arg2) end
				if arg3 ~= nil then RR_Test("3 .. " .. arg3) end 
				if arg4 ~= nil then RR_Test("4 .. " .. arg4) end 
				if arg5 ~= nil then RR_Test("5 .. " .. arg5) end 
				if arg6 ~= nil then RR_Test("6 .. " .. arg6) end 
			end
		end
	end

	if event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_RAID_WARNING" or event == "CHAT_MSG_SAY" then
		arg1_s = string.lower(arg1)
		
		if string.find(arg1,RAIDROLL_LOCALE["Rolling_Ends_in_10_Sec"]) then
			RR_FinishRolling(true,10)
		end
		
		if string.find(arg1,RAIDROLL_LOCALE["Rolling_Ends_in_5_Sec"]) then
			RR_HasAnnounced_10_Sec = true
			RR_FinishRolling(true,5)
		end
		
		if string.find(arg1_s, "item:") then
			
		--Find the start and end location of the item link
			xRR_Start_Loc,_ = string.find(arg1_s, "item:");
			_,xRR_End_Loc = string.find(arg1_s, "|h|r")
			
			if xRR_Start_Loc == nil then xRR_Start_Loc = 0 end
			if xRR_End_Loc == nil then xRR_End_Loc = 0 end
			
			
		--Get the words before and after the item link
			RR_String_minus_ILink1 = strsub(arg1,0,xRR_Start_Loc-12)
			RR_String_minus_ILink2 = strsub(arg1,xRR_End_Loc,strlen(arg1))
			
		--If they are nil set them to blank values
			if RR_String_minus_ILink1 == nil then RR_String_minus_ILink1 = "" end
			if RR_String_minus_ILink2 == nil then RR_String_minus_ILink2 = "" end

		--Put them together
			RR_String_minus_ILink = RR_String_minus_ILink1 .. RR_String_minus_ILink2
			
			
		-- use lower case characters
			RR_String_minus_ILink = string.lower(RR_String_minus_ILink)
			
			if RaidRoll_DB["debug"] == true then RR_Test(RR_String_minus_ILink) end	
			
			RR_ChatRollFound = string.find(RR_String_minus_ILink, "roll")
			--[[
			if RR_ChatRollFound == nil then
				RR_ChatRollFound = string.find(RR_String_minus_ILink, RAIDROLL_LOCALE["Roll"])
			end
			]]
			
			-- Includes german searching for roll announcement
			if string.find(arg1_s, "|h|r") ~= nil and string.find(RR_String_minus_ILink, "raid roll") == nil and (RR_ChatRollFound ~= nil  or event == "CHAT_MSG_RAID_WARNING") then 
				if RaidRoll_DB["debug"] == true then RR_Test("Rolling on an item detected") end
				
				if IsInGuild() then GuildRoster() end
				if IsInGuild() then RR_GetEPGPGuildData() end
				
				
			--Timestamp of when the rolling was announced
				RR_Timestamp = time() + RaidRoll_DBPC[UnitName("player")]["Time_Offset"]
				if RaidRoll_DB["debug"] == true then  RR_Test("Timestamp set to :" .. RR_Timestamp) end	--Debugging, displays the timestamp
				
				-- This being false tells us that we should begin decrementing the counter
				RR_Doing_a_New_Roll = false
				
				
			--Cut the itemlink out of the string
				if xRR_Start_Loc ~= nil and xRR_End_Loc ~= nil then
					xRR_ItemLink = strsub(arg1,xRR_Start_Loc-12,xRR_End_Loc)
				end
			--For debugging, show the itemlink
				if RaidRoll_DB["debug"] == true then RR_Test(xRR_ItemLink) end
				
				if rr_Item[rr_rollID] ~= "ID #"..rr_rollID or RollerName[rr_rollID][1] ~= "" then
				
					rr_rollID = rr_rollID + 1	
					
					
					if rr_CurrentRollID+1 == rr_rollID then
						rr_CurrentRollID = rr_rollID
					end
				end
				
				rr_Item[rr_rollID] = xRR_ItemLink
				rr_RollSort(rr_rollID,0,"",true)
				
				if RaidRoll_DB["debug"] == true then RR_Test("New item roll found, ID#" .. rr_rollID) end
			end
			
			RR_Rolling_on_item = true
			
		end
	end
	
	if RaidRoll_DBPC[UnitName("player")] ~= nil then
		if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_EPGPSays"] == true then
			if event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_RAID_WARNING" or event == "CHAT_MSG_SAY" then
				if arg1 ~= nil and arg2 ~= nil then
					arg1_s = string.lower(arg1)
					
					if string.find(arg1_s, "%!epgp") then
						RR_ARollHasOccured(arg2,"1","1","100")
					end
				end
			end
		end
		
		
		
	end
	
	if RaidRoll_DBPC[UnitName("player")] ~= nil then
		if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_Bids"] == true then
			if event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_RAID_WARNING" or event == "CHAT_MSG_SAY" then
				arg1_s = string.lower(arg1)
				
				if string.find(arg1_s, "%!bid") then
					
					_,bid = strsplit(" ",arg1_s)
					
					RR_Test(bid)
					RR_Test(tonumber(bid))
					
					if tonumber(bid) ~= nil then
						RR_ARollHasOccured(arg2,bid,"1","100")
					else
						if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Num_Not_Req"] == true then 
							RR_ARollHasOccured(arg2,0,"1","100")
						end
					end
					
				end
			end
		end
	end
	
-- Roll handler
	if event == "CHAT_MSG_SYSTEM" then
		if arg1 ~= nil then 
			if string.find(arg1, "%(") ~= nil then
				if string.find(arg1, "%)") ~= nil then
					if string.find(arg1, "%-") ~= nil then
						local Name,Roll,Low,High = RR_RollHandler(arg1)
						
						if Name ~= nil then 
							RR_ARollHasOccured(Name,Roll,Low,High)
						end
					end
				end
			end

			--zhCN code
			if GetLocale() == "zhCN" then
				if string.find(arg1, "%（") ~= nil then	
					if string.find(arg1, "%）") ~= nil then
						if string.find(arg1, "%-") ~= nil then

							local Name,Roll,Low,High = RR_RollHandler(arg1)
						
							if Name ~= nil then 
								RR_ARollHasOccured(Name,Roll,Low,High)
							end
						end
					end
				end
			end

		end
	end
end

function RR_ARollHasOccured(Name,Roll,Low,High)

if IsInGuild() then GuildRoster() end
if IsInGuild() then RR_GetEPGPGuildData() end


local Roll = tonumber(Roll)
local Low = tonumber(Low)
local High = tonumber(High)

-- Standard Roll Catcher
	if RR_Rolling_on_item == true then
	-- Debugging, tells us how long after the announcement the roll was detected
		if RaidRoll_DB["debug"] == true then RR_Test("Roll detected " .. time() - RR_Timestamp .. " seconds after announcement") end
			
	-- If its less than 60 seconds after then accept the roll
		if time() < RR_Timestamp + 60 or RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] == true then
		--This creates a new window for rolls made more than 60 seconds after the last roll if the option to track unannounced rolls is turned on
			if RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] == true then
				if time() > RR_Timestamp + 60 then
					RR_NewRoll()
				end
			end
			
		-- This controls the showing of the window (true = show window, false = dont show window)
			if RaidRoll_DBPC[UnitName("player")]["RR_Roll_Tracking_Enabled"] == true then
				RR_RollFrame:Show()
				RR_NAME_FRAME:Show()
			end
				
		-- Find out if the roll is a standard (1-100) roll or not
			if High == 100 and Low == 1 then
				RR_LegitRoll = true
				if RaidRoll_DB["debug"] == true then RR_Test("Standard roll detected") end
			else
				RR_LegitRoll = false
			end
			
			LowHigh = "("..Low.."-"..High..")"
			
		-- This being false tells us that we should begin decrementing the counter
			RR_Doing_a_New_Roll = false
			
		-- Create a new array for rolls if needed
			if rr_Roll[rr_rollID] == nil then rr_Roll[rr_rollID] = {} end
			
		-- If the person has not rolled yet
			if rr_Roll[rr_rollID][Name] == nil then
			-- Record their roll
				rr_Roll[rr_rollID][Name] = tonumber(Roll)
				
			-- If the list of players that rolled is empty then set it to 1, otherwise add 1 to it
				if rr_PlayersRolled[rr_rollID] == nil then 
					rr_PlayersRolled[rr_rollID] = 1
				else
					rr_PlayersRolled[rr_rollID] = rr_PlayersRolled[rr_rollID] + 1
				end
				
			-- Debugging message, tells you how many ppl have rolled unique rolls
				if RaidRoll_DB["debug"] == true then RR_Test("Total players rolled: " .. rr_PlayersRolled[rr_rollID])	end
				
			
				if rr_playername[rr_rollID] == nil then	rr_playername[rr_rollID] = {} end
				
				rr_playername[rr_rollID][rr_PlayersRolled[rr_rollID]] = Name	
				
				rr_RollSort(rr_rollID,Roll,Name,true,true,RR_LegitRoll,LowHigh)
				
			else
				
				rr_RollSort(rr_rollID,Roll,Name,true,false,RR_LegitRoll,LowHigh)
				
				if RR_RollCheckBox_Multi_Rollers:GetChecked() then
					if GetNumRaidMembers() ~= 0 then
						SendChatMessage(RAIDROLL_LOCALE["Multiroll_by"] .. Name, "RAID")
					elseif GetNumPartyMembers() > 0 then
						SendChatMessage(RAIDROLL_LOCALE["Multiroll_by"] .. Name, "PARTY")
					else
						SendChatMessage(RAIDROLL_LOCALE["Multiroll_by"] .. Name, "SAY")
					end
				end 
				
				
			end
		end
	end		

	
-- Raid Roll Catcher
	if RR_Has_Rolled == true then
	--Check if the player rolling is the user
		if Name == UnitName("player") then
			if RaidRoll_DB["debug"] == true then RR_Test("You have rolled on a raid roll") end
			
			if RR_Name_Array[Roll] ~= nil and RR_ItemLink == nil then
				SendChatMessage(">>> " .. RR_Name_Array[Roll] .. " " .. RAIDROLL_LOCALE["Wins"] .. " <<<", rr_AnnounceType1)
			end
			
			if RR_Name_Array[Roll] ~= nil and RR_ItemLink ~= nil then
				SendChatMessage(">>> " .. RR_Name_Array[Roll] .. " " .. RAIDROLL_LOCALE["Wins"] .. " <<<", rr_AnnounceType1)
			end
			
			RR_Has_Rolled  = false
		end
	end
	
-- update scrollbar
	if MaxPlayers[rr_CurrentRollID] and MaxPlayers[rr_CurrentRollID] >= 5 then
		RaidRoll_MaxNumber = MaxPlayers[rr_CurrentRollID]-4
		RaidRoll_MaxNumber_Slider = RaidRoll_MaxNumber
		if rr_CurrentRollID > 0 and RaidRoll_MaxNumber > 1 then RaidRoll_MaxNumber_Slider = RaidRoll_MaxNumber - 1 end
		RaidRoll_Slider:SetMinMaxValues(1, RaidRoll_MaxNumber_Slider)
	end
	
end






function RR_FindRollNumbers(msg)
local Roll,Low,High

	Low = tonumber(string.sub(msg,Start+1,Mid-1))
	High =  tonumber(string.sub(msg,Mid+1,End-1))

	--zhCN code
	if GetLocale() == "zhCN" then
		Low = tonumber(string.sub(msg,Start+3,Mid-1))
		High = tonumber(string.sub(msg,Mid+1,End-1))
	end
	
	digits = 0
	
-- how many digits are before the brackets?
	for i=1,7 do
		if tonumber(string.sub(msg,Start-i,Start-i)) ~= nil or i==1 then
			digits = digits+1
		end
	end
	
	Roll =  tonumber(string.sub(msg,Start-digits,Start-1))

return Roll,Low,High
end

-- RR_FindName("abcdefgh95(1-100)")

function RR_FindName(msg)

local Name

	if GetLocale() ~= "zhTW" then
		Name = strsplit(" ",msg, 2)
	else
		Start = string.find(msg, "擲出")
		--Start = string.find(msg, "%srolls")
		Name = string.sub(msg,0,Start-1)
		
		if RaidRoll_DB["debug"] == true then RR_Test("Message 1 - " .. Name) end
	end
	
	--zhCN code
	if GetLocale() == "zhCN" then
		Start = string.find(msg, "掷出")
		--Start = string.find(msg, "%srolls")
		Name = string.sub(msg,0,Start-1)
		if RaidRoll_DB["debug"] == true then RR_Test("Message 1 - " .. Name) end
	end
	
return Name
end

function RR_RollHandler(msg)
local Name,Roll,Low,High
	
	-- musou rolls 99 (1-100)
	-- Killerpet wrfelt. Ergebnis: 1 (1-100)
	
	if msg ~= nil then 
		if string.find(msg, "%(") ~= nil then
			if string.find(msg, "%)") ~= nil then
				if string.find(msg, "%-") ~= nil then
					
					Start = string.find(msg, "%(")
					End = string.find(msg, "%)")
					Mid = string.find(msg, "%-")
					
					if Start < End  and Start < Mid and Mid < End then
						
						Roll,Low,High = RR_FindRollNumbers(msg)
						Name = RR_FindName(msg)
						
						if RaidRoll_DB["debug"] == true then 
							RR_Test("Roll Handler")	
							RR_Test(Name)		
							RR_Test(Roll)			
							RR_Test(Low)		
							RR_Test(High)		
						end
						
						return Name,Roll,Low,High
						
					end
				end
			end
		end

		--zhCN code
		if GetLocale() == "zhCN" then
			if string.find(msg, "%（") ~= nil then
				if string.find(msg, "%）") ~= nil then
					if string.find(msg, "%-") ~= nil then
					
						Start = string.find(msg, "%（")
						End = string.find(msg, "%）")
						Mid = string.find(msg, "%-")
										
						if Start < End  and Start < Mid and Mid < End then
						
							Roll,Low,High = RR_FindRollNumbers(msg)
							Name = RR_FindName(msg)
						
							if RaidRoll_DB["debug"] == true then 
								RR_Test("Roll Handler")	
								RR_Test(Name)		
								RR_Test(Roll)			
								RR_Test(Low)		
								RR_Test(High)		
							end
						
							return Name,Roll,Low,High
						
						end
					end
				end
			end
		end
	end
end



-- PlayerRoll = the roll performed 
-- PlayerName = the name of the player who rolled
-- rr_rollID = the id of the list
-- rr_FirstRoll = was it this persons first roll? (true / false)
-- rr_AddedPlayer = if we added a player this is true, otherwise it is false (for re-sorting)


function rr_RollSort(rr_rollID,PlayerRoll,PlayerName,rr_AddedPlayer,rr_FirstRoll,RR_LegitRoll,LowHigh)


--RR_Test("www"..LowHigh)
		

local temp

--if rr_rollID == nil then rr_rollID = rr_CurrentRollID end 

	if rr_AddedPlayer == true then
		
	-- Checks for the variables that are passed to make sure no nil values are passed
		if rr_FirstRoll ==   nil then 	rr_FirstRoll = false   end	-- Was this their first roll?
		if rr_GuildRank ==   nil then 	rr_GuildRank = ""      end	-- What was their Guild Rank?
		if rr_AddedPlayer == nil then 	rr_AddedPlayer = false end	-- Are you adding more players to the list or just re-sorting? (SET THIS TO DEFAULT FALSE)
		if RR_LegitRoll == 	nil then 	RR_LegitRoll = false   end	-- Is it a 1-100 roll?
		if LowHigh == 		nil then 	LowHigh = "(1-100)"   end	-- Is it a 1-100 roll?

		
	-- If this is the first time that it is called then set the max rollers value to zero
		if MaxPlayers[rr_rollID] == nil then MaxPlayers[rr_rollID] = 0 end
		
	-- If you are to add a player then increment the value
		if rr_AddedPlayer == true then MaxPlayers[rr_rollID] = MaxPlayers[rr_rollID] + 1 end
		
		
		
	-- If there are less than 5 rollers then set the value to 5 (to avoid bugs)
		if MaxPlayers[rr_rollID] < 5 then
			MaxPlayersValue = 5
		else
			MaxPlayersValue = MaxPlayers[rr_rollID]
		end
		
		
		if RR_RollData[rr_rollID] == nil then 
			RR_RollData[rr_rollID] = {} 
		end
		
		if RR_RollData[rr_rollID][MaxPlayersValue] == nil then 
			RR_RollData[rr_rollID][MaxPlayersValue] = {}
			
			RR_RollData[rr_rollID][MaxPlayersValue]["LowHigh"] = "" 
			RR_RollData[rr_rollID][MaxPlayersValue]["EPGPValues"] = ""
		end
		
		
	-- Making the variable to an array
		if RollerName[rr_rollID] == nil then RollerName[rr_rollID] = {} end
		if RollerRoll[rr_rollID] == nil then RollerRoll[rr_rollID] = {} end
		if RollerFirst[rr_rollID] == nil then RollerFirst[rr_rollID] = {} end
		if RollerRank[rr_rollID] == nil then RollerRank[rr_rollID] = {} end
		if RollerRankIndex[rr_rollID] == nil then RollerRankIndex[rr_rollID] = {} end
		if HasRolled[rr_rollID] == nil then HasRolled[rr_rollID] = {} end		
		if Roll_Number[rr_rollID] == nil then Roll_Number[rr_rollID] = {} end		
		if RaidRoll_LegitRoll[rr_rollID] == nil then RaidRoll_LegitRoll[rr_rollID] = {} end	
		if RollerColor[rr_rollID]  == nil then RollerColor[rr_rollID]  = {}  end
		if RR_EPGPAboveThreshold[rr_rollID] == nil then RR_EPGPAboveThreshold[rr_rollID] = {} end
		if RR_EPGP_PRValue[rr_rollID] == nil then RR_EPGP_PRValue[rr_rollID] = {} end
		
		
		
		
		if HasRolled[rr_rollID][PlayerName] == nil then
			HasRolled[rr_rollID][PlayerName] = 1
		else
			HasRolled[rr_rollID][PlayerName] = HasRolled[rr_rollID][PlayerName] + 1
		end
		
		Roll_Number[rr_rollID][MaxPlayersValue] = HasRolled[rr_rollID][PlayerName]
		
	-- Filling in the blank values with dummies
		for i=1,MaxPlayersValue-1 do
			if RollerName[rr_rollID][i]  == nil then RollerName[rr_rollID][i]  = "" end
			if RollerRoll[rr_rollID][i]  == nil then RollerRoll[rr_rollID][i]  = 0  end
			if RollerFirst[rr_rollID][i] == nil then RollerFirst[rr_rollID][i] = false end
			if RollerRank[rr_rollID][i]  == nil then RollerRank[rr_rollID][i]  = "" end
			if RollerRankIndex[rr_rollID][i]  == nil then RollerRankIndex[rr_rollID][i]  = 11 end
			if RaidRoll_LegitRoll[rr_rollID][i]  == nil then RaidRoll_LegitRoll[rr_rollID][i]  = false end
			if RollerColor[rr_rollID][i]  == nil then RollerColor[rr_rollID][i]  = ""  end
			if RR_EPGPAboveThreshold[rr_rollID][i] == nil then RR_EPGPAboveThreshold[rr_rollID][i] = false end
			if RR_EPGP_PRValue[rr_rollID][i] == nil then RR_EPGP_PRValue[rr_rollID][i] = 0 end
	
			
		end
		
	-- Getting and filling in the name colors
		if RaidRoll_DBPC[UnitName("player")]["RR_ShowClassColors"] == true then
			if GetNumRaidMembers() ~= 0 then
			-- we are in a raid
				for i = 1,40 do
					local name, rank, subgroup, level, class, fileName = GetRaidRosterInfo(i);
					-- fileName
					-- 	String - The system representation of the character's class; always in english, always fully capitalized.
					if PlayerName ~= nil and name ~= nil then
						if strupper(PlayerName) == strupper(name) then
							RollerColor[rr_rollID][MaxPlayersValue] =  RR_GetClassColor(fileName)
							
							if RaidRoll_DB["debug"] == true then RR_Test("Color " .. RollerColor[rr_rollID][MaxPlayersValue] .. fileName) end
						end
					end
				end
			else
				for i = 1,5 do
					--[[
					if i==1 then 
						name = UnitName("player")
						guid = UnitGUID("player")
						DEFAULT_CHAT_FRAME:AddMessage(guid)
						locClass, engClass, locRace, engRace, gender = GetPlayerInfoByGUID(guid)
						-- engClass 
						-- 	String - Class of the character in question (in English) 
						if RaidRoll_DB["debug"] == true then if engClass ~= nil then RR_Test(name .. engClass) end end
					else
						name = UnitName("party" .. i-1)
						guid = UnitGUID("party" .. i-1)
						if guid ~= nil then
							locClass, engClass, locRace, engRace, gender = GetPlayerInfoByGUID(guid)
						else
							engClass = ""
						end
						if RaidRoll_DB["debug"] == true then if name ~= nil then RR_Test(name .. engClass) end end
					end
					]]

					--zhCN code
					if (GetLocale() == "zhCN") then
						name = UnitName("party" .. i)
						_,engClass =  UnitClass("party" .. i)
					else
						if i==1 then 
							name = UnitName("player")
							guid = UnitGUID("player")
							--DEFAULT_CHAT_FRAME:AddMessage(guid)
							locClass, engClass, locRace, engRace, gender = GetPlayerInfoByGUID(guid)
							-- engClass 
							-- 	String - Class of the character in question (in English) 
							if RaidRoll_DB["debug"] == true then if engClass ~= nil then RR_Test(name .. engClass) end end
						else
							name = UnitName("party" .. i-1)
							guid = UnitGUID("party" .. i-1)
							if guid ~= nil then
								locClass, engClass, locRace, engRace, gender = GetPlayerInfoByGUID(guid)
							else
								engClass = ""
							end
							if RaidRoll_DB["debug"] == true then if name ~= nil then RR_Test(name .. engClass) end end
						end
					end
					
					if RaidRoll_DB["debug"] == true then if PlayerName ~= nil then RR_Test("RROL539 pn" .. PlayerName) end end
					if RaidRoll_DB["debug"] == true then if name ~= nil then RR_Test("RROL539 n" .. name) end end
					
					
					if PlayerName ~= nil and name ~= nil then
						if RaidRoll_DB["debug"] == true then RR_Test("RROL539 " .. PlayerName .. " - " .. name) end
						if strupper(PlayerName) == strupper(name) then
							if engClass ~= nil then
								RollerColor[rr_rollID][MaxPlayersValue] =  RR_GetClassColor(engClass)
								if RaidRoll_DB["debug"] == true then RR_Test("Color " .. RollerColor[rr_rollID][MaxPlayersValue] .. engClass) end
							end
						end
					end
				end
				
			end
		end
		
	-- Setting the players name, roll, guild rank and roll status to the current max players value
		if rr_AddedPlayer == true then
			RollerName[rr_rollID][MaxPlayersValue] = PlayerName
			RollerRoll[rr_rollID][MaxPlayersValue] = tonumber(PlayerRoll)
			
			
			
			
			RollerFirst[rr_rollID][MaxPlayersValue] = rr_FirstRoll
			
			local PR,AboveThreshold,EP,GP = RR_GetEPGPCharacterData(PlayerName)
			
			RR_EPGPAboveThreshold[rr_rollID][MaxPlayersValue] = AboveThreshold
			RR_EPGP_PRValue[rr_rollID][MaxPlayersValue] = PR
			
			
			RR_RollData[rr_rollID][MaxPlayersValue]["LowHigh"] = LowHigh
			RR_RollData[rr_rollID][MaxPlayersValue]["EPGPValues"] = "EP: "..EP.." GP: "..GP
			
			--CODE CHANGED DRKNEZSZ
			if RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] == true then
				if PlayerName ~= "" then
					local message = PlayerName.." has Prio: ".. PR;
					if GetNumRaidMembers() ~= 0 then
						SendChatMessage(message, "Raid"); 
					else
						SendChatMessage(message, "Party"); 
					end
				end
			end
			--END OF CODE CHANGED
			
		-- Default rank and rank id values (will be overwritten if the person is in the guild
			RollerRank[rr_rollID][MaxPlayersValue] = ""
			RollerRankIndex[rr_rollID][MaxPlayersValue] = 10
			
			RaidRoll_LegitRoll[rr_rollID][MaxPlayersValue] = RR_LegitRoll
			
		-- Get how many guild members are online
			numOnline = GetNumGuildMembers()
			
		-- scan the guild info for the person 
			for i=1,numOnline do
				name, rank, rankIndex = GetGuildRosterInfo(i)
			
			-- If a match is found set the rank and rankindex 
				if PlayerName == name then
					RollerRank[rr_rollID][MaxPlayersValue] = rank
					RollerRankIndex[rr_rollID][MaxPlayersValue] = rankIndex
				end
			end		
			
		-- Debugging, lists the name, guild rank, and guild rank id of the player (Rank ID starts at 0)
			if RaidRoll_DB["debug"] == true then RR_Test(RollerName[rr_rollID][MaxPlayersValue] .. " " .. RollerRank[rr_rollID][MaxPlayersValue] .. " " .. RollerRankIndex[rr_rollID][MaxPlayersValue]) end
			
		end	
		
	--Debugging values 
		--[[
		RollerRoll[rr_rollID][1] = 2
		RollerRoll[rr_rollID][2] = 4
		RollerRoll[rr_rollID][3] = 5
		RollerRoll[rr_rollID][4] = 1
		RollerRoll[rr_rollID][5] = 9
		]]
		
	end
		
	
	if MaxPlayersValue ~= nil then
		
		for i=1,MaxPlayersValue do
			--RR_Test(i)	-- Debugging, shows the ''i'' value
			for j=1,MaxPlayersValue-1 do
				--RR_Test(j) 	-- Debugging, shows the ''j'' value
				if RollerRoll[rr_rollID] ~= nil then
					if RollerRoll[rr_rollID][j+1] ~= nil then
						if RollerRoll[rr_rollID][j+1] > RollerRoll[rr_rollID][j] then
							RaidRoll_Flip(rr_rollID,j)
						end
					end
				end
			end
		end
		
		
		if RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] == true then
			for i=1,MaxPlayersValue do
				--RR_Test(i)	-- Debugging, shows the ''i'' value
				for j=1,MaxPlayersValue-1 do
					if RR_EPGP_PRValue[rr_rollID] ~= nil then
						if RR_EPGP_PRValue[rr_rollID][j+1] ~= nil then
							if RR_EPGP_PRValue[rr_rollID][j+1] > RR_EPGP_PRValue[rr_rollID][j] then
								RaidRoll_Flip(rr_rollID,j)
							end
						end
					end
				end
			end
		end
		
		if RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] == true then
			if RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Priority"] == true then
				for i=1,MaxPlayersValue do
					--RR_Test(i)	-- Debugging, shows the ''i'' value
					for j=1,MaxPlayersValue-1 do
						if RR_EPGPAboveThreshold[rr_rollID] ~= nil then
							if RR_EPGPAboveThreshold[rr_rollID][j+1] ~= nil then
								if RR_EPGPAboveThreshold[rr_rollID][j+1] == true and RR_EPGPAboveThreshold[rr_rollID][j] == false then
									RaidRoll_Flip(rr_rollID,j)
								end
							end
						end
					end
				end
			end
		end
		
		if RaidRoll_DBPC[UnitName("player")]["RR_RankPriority"] == true then
			for i=1,MaxPlayersValue do
				--RR_Test(i)	-- Debugging, shows the ''i'' value
				for j=1,MaxPlayersValue-1 do
					--RR_Test(j) 	-- Debugging, shows the ''j'' value
					--RR_Test("i=" .. i .. " j=" .. " " .. j .. RollerRankIndex[rr_rollID][j+1] .. "/" .. RollerRankIndex[rr_rollID][j])
					if RollerRankIndex[rr_rollID] ~= nil then
						if RollerRankIndex[rr_rollID][j+1] ~= nil then
							if RaidRoll_DB["Rank Priority"][RollerRankIndex[rr_rollID][j+1]+1] > RaidRoll_DB["Rank Priority"][RollerRankIndex[rr_rollID][j]+1] then
								RaidRoll_Flip(rr_rollID,j)
							end
						end
					end
				end
			end
		end
		
		if RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] == false then
			for i=1,MaxPlayersValue do
				--RR_Test(i)	-- Debugging, shows the ''i'' value
				for j=1,MaxPlayersValue-1 do
					--RR_Test(j) 	-- Debugging, shows the ''j'' value
					--RR_Test("i=" .. i .. " j=" .. j .. " " .. RollerRankIndex[rr_rollID][j+1] .. "/" .. RollerRankIndex[rr_rollID][j])
					if RollerFirst[rr_rollID][j+1] ~= nil then
						if RollerFirst[rr_rollID][j+1] == true and RollerFirst[rr_rollID][j] == false then
							RaidRoll_Flip(rr_rollID,j)
						end
					end
				end
			end
		end
		
		
		
		
		if RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] == false then
			for i=1,MaxPlayersValue do
				--RR_Test(i)	-- Debugging, shows the ''i'' value
				for j=1,MaxPlayersValue-1 do
					--RR_Test(j) 	-- Debugging, shows the ''j'' value
					--RR_Test("i=" .. i .. " j=" .. j .. " " .. RollerRankIndex[rr_rollID][j+1] .. "/" .. RollerRankIndex[rr_rollID][j])
					if RaidRoll_LegitRoll[rr_rollID] ~= nil then
						if RaidRoll_LegitRoll[rr_rollID][j+1] ~= nil then
							if RaidRoll_LegitRoll[rr_rollID][j+1] == true and RaidRoll_LegitRoll[rr_rollID][j] == false then
								RaidRoll_Flip(rr_rollID,j)
							end
						end
					end
				end
			end
		end
		
		
		
--Debugging, lists all the raid rolls
		--[[RR_Test("Listing Results")
		for i=1,41 do
			RR_Test(RollerName[rr_rollID][i])
			RR_Test(RollerRoll[rr_rollID][i])
		end
		]]
		
		if rr_CurrentRollID == rr_rollID then
				RR_Display(rr_rollID)
		end
		
	end
	
end

function RaidRoll_Flip(rr_rollID,j)

temp_arr={{{}}}


	temp_arr = RR_RollData[rr_rollID][j+1]
	RR_RollData[rr_rollID][j+1] = RR_RollData[rr_rollID][j]
	RR_RollData[rr_rollID][j] = temp_arr

	temp = RollerRoll[rr_rollID][j+1]
	RollerRoll[rr_rollID][j+1] = RollerRoll[rr_rollID][j]
	RollerRoll[rr_rollID][j] = temp
	
	temp = RollerName[rr_rollID][j+1]
	RollerName[rr_rollID][j+1] = RollerName[rr_rollID][j]
	RollerName[rr_rollID][j] = temp
	
	temp = RollerRank[rr_rollID][j+1]
	RollerRank[rr_rollID][j+1] = RollerRank[rr_rollID][j]
	RollerRank[rr_rollID][j] = temp
	
	temp = RollerRankIndex[rr_rollID][j+1]
	RollerRankIndex[rr_rollID][j+1] = RollerRankIndex[rr_rollID][j]
	RollerRankIndex[rr_rollID][j] = temp
	
	temp = RollerFirst[rr_rollID][j+1]
	RollerFirst[rr_rollID][j+1] = RollerFirst[rr_rollID][j]
	RollerFirst[rr_rollID][j] = temp
	
	temp = Roll_Number[rr_rollID][j+1]
	Roll_Number[rr_rollID][j+1] = Roll_Number[rr_rollID][j]
	Roll_Number[rr_rollID][j] = temp
	
	temp = RaidRoll_LegitRoll[rr_rollID][j+1]
	RaidRoll_LegitRoll[rr_rollID][j+1] = RaidRoll_LegitRoll[rr_rollID][j]
	RaidRoll_LegitRoll[rr_rollID][j] = temp
	
	temp = RollerColor[rr_rollID][j+1]
	RollerColor[rr_rollID][j+1] = RollerColor[rr_rollID][j]
	RollerColor[rr_rollID][j] = temp
	
	temp = RR_EPGPAboveThreshold[rr_rollID][j+1]
	RR_EPGPAboveThreshold[rr_rollID][j+1] = RR_EPGPAboveThreshold[rr_rollID][j]
	RR_EPGPAboveThreshold[rr_rollID][j] = temp
	
	temp = RR_EPGP_PRValue[rr_rollID][j+1]
	RR_EPGP_PRValue[rr_rollID][j+1] = RR_EPGP_PRValue[rr_rollID][j]
	RR_EPGP_PRValue[rr_rollID][j] = temp
	
end


function RR_Update_Name_Frame(RR_DisplayID)


-- This allows auto-reporting of 10 and 5 seconds left
	if time() < RR_Timestamp + 48 then
		if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Announce"] == true then
			if RR_RollCountdown ~= true then
				RR_RollCountdown = true;
				RR_HasAnnounced_10_Sec = false;
				RR_HasAnnounced_5_Sec = false;
			end
		end
	end

	if 	rr_Item[rr_CurrentRollID] ~= "ID #"..rr_CurrentRollID and (time() > RR_Timestamp + 59 or rr_CurrentRollID ~= rr_rollID) then
		RaidRoll_AnnounceWinnerButton:Show()
		RR_Roll_5SecAndAnnounce:SetWidth(145)
	else
		RaidRoll_AnnounceWinnerButton:Hide()
		RR_Roll_5SecAndAnnounce:SetWidth(168)
	end
	

	if 	rr_Item[rr_CurrentRollID] ~= "ID #"..rr_CurrentRollID and (time() > RR_Timestamp + 59 or rr_CurrentRollID ~= rr_rollID) then
		
		local Winner = RR_FindWinner(rr_CurrentRollID)
		
		
		
		if 	Winner  ~= "" then
			
			RR_Roll_5SecAndAnnounce:SetText(string.format(RAIDROLL_LOCALE["Award"],Winner))
		else
			RR_Roll_5SecAndAnnounce:SetText(RAIDROLL_LOCALE["No_Winner"])
		end
	elseif 	(time() > RR_Timestamp + 59 or rr_CurrentRollID ~= rr_rollID) then
		RR_Roll_5SecAndAnnounce:SetText(RAIDROLL_LOCALE["No_Item"])
	else
		if RR_Doing_a_New_Roll == true then
			RR_Roll_5SecAndAnnounce:SetText(RAIDROLL_LOCALE["Awaiting Rolls"])
		else
			
			if (60 - (time() - RR_Timestamp)) <= 11 or RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_No_countdown"] == true then
				RR_Roll_5SecAndAnnounce:SetText(RAIDROLL_LOCALE["Finish_Early"])
			else
				RR_Roll_5SecAndAnnounce:SetText(RAIDROLL_LOCALE["10_Sec_Announce_Winner"])
			end
		end
	end

l_RR_DisplayID = RR_DisplayID

	-- If you clicked "new roll" then dont  decrement the timer (unless there was a roll performed)
	if RR_Doing_a_New_Roll == true then RR_Timestamp = time() + RaidRoll_DBPC[UnitName("player")]["Time_Offset"] end

	if time() < RR_Timestamp + 60 and rr_rollID == rr_CurrentRollID then
		_G["RR_Itemname"]:SetText("(" .. 60 - time() + RR_Timestamp .. ") " .. rr_Item[l_RR_DisplayID])
	else
		_G["RR_Itemname"]:SetText(rr_Item[l_RR_DisplayID])
	end
	
	
	if RR_RollCountdown == true then
		
	-- What channel to announce it in?
		if GetNumRaidMembers() ~= 0 then
		-- raid
			rr_AnnounceType = "RAID"
		elseif GetNumPartyMembers() > 0 then
		-- party
			rr_AnnounceType = "PARTY"
		else
		-- say
			rr_AnnounceType = "SAY"
		end
		
		if RR_HasAnnounced_10_Sec == false and time() > RR_Timestamp + 49 then
			RR_HasAnnounced_10_Sec = true
			if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Announce"] == true or RR_AnnounceCountdowns == true then
				SendChatMessage(RAIDROLL_LOCALE["Rolling_Ends_in_10_Sec"], rr_AnnounceType)
			end
		end
		
		if RR_HasAnnounced_5_Sec == false and time() > RR_Timestamp + 54 then
			RR_HasAnnounced_5_Sec = true
			if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Announce"] == true or RR_AnnounceCountdowns == true then
				SendChatMessage(RAIDROLL_LOCALE["Rolling_Ends_in_5_Sec"], rr_AnnounceType)
			end
		end
		
		
		
	-- Announce the winner when the time runs out
		if time() > RR_Timestamp + 60 then
			
			
			if RR_RollCountdown == true then
				if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Announce"] == true or RR_AnnounceCountdowns == true then
				

					local Winner,Roll,EPGP = RR_FindWinner(rr_rollID)
					
					
					
					if Winner  ~= "" then
						if GetLocale() ~= "zhTW" and GetLocale() ~= "ruRU" and GetLocale() ~= "zhCN" then
							Winner = string.upper(string.sub(Winner,1,1))..string.lower(string.sub(Winner,2))
						end
						
						if RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] ==  true then
							if rr_Item[rr_rollID] == "ID #"..rr_rollID then
								Winner_Message = string.format(RAIDROLL_LOCALE["won_PR_value"], Winner,EPGP)
							else
								Winner_Message = string.format(RAIDROLL_LOCALE["won_item_PR_value"], Winner, rr_Item[rr_rollID],EPGP)
							end
						else
							if rr_Item[rr_rollID] == "ID #"..rr_rollID then
								Winner_Message = string.format(RAIDROLL_LOCALE["won_with"], Winner,Roll)
							else
								Winner_Message = string.format(RAIDROLL_LOCALE["won_item_with"], Winner,rr_Item[rr_rollID],Roll)
							end
						end
					else
						Winner_Message = string.format(RAIDROLL_LOCALE["No_winner_for"], rr_Item[rr_rollID])
					end
					
					
					SendChatMessage(Winner_Message, rr_AnnounceType)
					
					if RR_RollCheckBox_GuildAnnounce:GetChecked() then
						if RR_RollCheckBox_GuildAnnounce_Officer:GetChecked() then
							SendChatMessage(Winner_Message, "OFFICER")
						else
							SendChatMessage(Winner_Message, "GUILD")
						end
					end
				end
				RR_AnnounceCountdowns = false
				RR_RollCountdown = false
			end
		end
		
	end
	
	--[[
			for i=1,MaxPlayersValue-1 do
			if RollerName[rr_rollID][i]  == nil then RollerName[rr_rollID][i]  = "" end
			if RollerRoll[rr_rollID][i]  == nil then RollerRoll[rr_rollID][i]  = 0  end
			if RollerFirst[rr_rollID][i] == nil then RollerFirst[rr_rollID][i] = false end
			if RollerRank[rr_rollID][i]  == nil then RollerRank[rr_rollID][i]  = "" end
			if RollerRankIndex[rr_rollID][i]  == nil then RollerRankIndex[rr_rollID][i]  = 11 end
			if RaidRoll_LegitRoll[rr_rollID][i]  == nil then RaidRoll_LegitRoll[rr_rollID][i]  = false end
			if RollerColor[rr_rollID][i]  == nil then RollerColor[rr_rollID][i]  = ""  end
			if RR_EPGPAboveThreshold[rr_rollID][i] == nil then RR_EPGPAboveThreshold[rr_rollID][i] = false end
			if RR_EPGP_PRValue[rr_rollID][i] == nil then RR_EPGP_PRValue[rr_rollID][i] = 0 end
		end
	
	]]
	
	--RR_width = _G["RR_Itemname"]:GetWidth();

	RR_NAME_FRAME:SetWidth(_G["RR_Itemname"]:GetWidth() + 20)
	
	--if RR_width + 45 > 185 then
	--	RR_RollFrame:SetWidth(RR_width+45);
	--else
	--	RR_RollFrame:SetWidth(185);
	--end
	

	
	if not _RR then 
		RR_NAME_FRAME:SetScript("OnUpdate",function() if _RR>0 and GetTime()>=_RR then _RR=0 RR_Update_Name_Frame(l_RR_DisplayID); end end)
	end 
	_RR=GetTime()
end


function RR_FindWinner(rollID)
-- Find the highest roller/PR non-ignored person
	local Winner = ""
	local Roll = 0
	local EPGP = 0
	
	if MaxPlayers ~= nil then
		if MaxPlayers[rollID] ~= nil then
			for i=1,MaxPlayers[rollID] do
				j = MaxPlayers[rollID] - i + 1
				
				Name_low = string.lower(RollerName[rollID][j])
				
				--if RaidRoll_DB["debug"] == true then RR_Test(j .. ": " .. Name_low) end
				
				
				if 	(RaidRoll_LegitRoll[rollID][j] == false and RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] == false) or 
					(RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] == false and RollerFirst[rollID][j] == false) or
					RR_IgnoredList[rollID][Name_low] == true	then
					
					--if RaidRoll_DB["debug"] == true then RR_Test(Name_low .. " ignored. Moving on") end
				else
					Winner = Name_low
					EPGP = RR_EPGP_PRValue[rollID][j]
					Roll = RollerRoll[rollID][j]
					
					--if RaidRoll_DB["debug"] == true then
					--	RR_Test("Setting winner to: "..Name_low)
					--	RR_Test("EPGP Value: " .. EPGP)
					--	RR_Test("Roll Value: " .. Roll)
					--end
				end
			end
		end
	end
	
	
	if RaidRoll_DB["debug3"] == true then 
		RR_Test("--- RR_FindWinner Debug Messages: ---") 
		RR_Test("1.."..RollerName[rollID][1]) 
		RR_Test("2.."..string.lower(RollerName[rollID][1]))
		RR_Test("3.."..string.upper(RollerName[rollID][1]))
		RR_Test("4.."..Winner) 
		RR_Test("5..".." "..Winner)
		RR_Test("--- --- ---") 
	end
	
	--if GetLocale() == "ruRU" then
	--	return " " .. Winner,Roll,EPGP	-- #2
	--else
		return Winner,Roll,EPGP	-- #4
	--end
end


function RR_Display(RR_DisplayID)


RR_HasDisplayedAlready = true

l_RR_DisplayID = RR_DisplayID

	if RollerGroup[l_RR_DisplayID] == nil then RollerGroup[l_RR_DisplayID] = {} end

---If the current roll is the latest rol it shows a 60 second countdown
	if time() < RR_Timestamp + 60 and rr_rollID == rr_CurrentRollID then
		_G["RR_Itemname"]:SetText("(" .. 60 - time() + RR_Timestamp .. ") " .. rr_Item[l_RR_DisplayID])
		RR_Update_Name_Frame(l_RR_DisplayID)
	else
		_G["RR_Itemname"]:SetText(rr_Item[l_RR_DisplayID])
	end
	
	if RollerFirst[RR_DisplayID] ~= nil and RollerFirst[RR_DisplayID][1] ~= nil then
		for i=1,5 do
			
			--To make sure these are not nil values
			mark = ""
			color = ""
			
			_G["RR_RollerPos"..i]:SetText(i + RR_ScrollOffset .. ":")
			
			if RollerFirst[RR_DisplayID][i+RR_ScrollOffset] == false then
				color = "|cFF11aacc"
			else
				color = "|cFFFF0000|r"
			end
			
			if RaidRoll_DBPC[UnitName("player")] == nil then RaidRoll_DBPC[UnitName("player")] = {} end
			if RaidRoll_DBPC[UnitName("player")]["RR_NameMark"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_NameMark"] = {} end
			if RaidRoll_DBPC[UnitName("player")]["RR_NameMark"][strlower(RollerName[RR_DisplayID][i+RR_ScrollOffset])] == nil then RaidRoll_DBPC[UnitName("player")]["RR_NameMark"][strlower(RollerName[RR_DisplayID][i+RR_ScrollOffset])] = {} end
			
			
		-- Checks to see if the roll should be shown
		-- RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"]
		-- RaidRoll_LegitRoll
		
			if (RaidRoll_LegitRoll[RR_DisplayID][i+RR_ScrollOffset] == false and RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] == false) or (RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] == false and RollerFirst[RR_DisplayID][i+RR_ScrollOffset] == false) then
				_G["RR_Roller"..i]:SetText("")
				_G["RR_Rolled"..i]:SetText("")
				_G["Raid_Roll_Rank_String"..i]:SetText("")
				_G["RR_Group"..i]:SetText("")
			else
				Name_low = string.lower(RollerName[RR_DisplayID][i+RR_ScrollOffset])
				
				if RR_IgnoredList == nil then RR_IgnoredList = {} end
				if RR_IgnoredList[RR_DisplayID] == nil then RR_IgnoredList[RR_DisplayID] = {} end

				
				if RR_IgnoredList[RR_DisplayID][Name_low] == true then
					if (GetLocale() ~= "zhTW") then
						_G["RR_Roller"..i]:SetFont("Fonts\\FRIZQT__.TTF", 12, "THICKOUTLINE")
					end
					if (GetLocale() == "zhCN") then
						_G["RR_Roller"..i]:SetFont("Fonts\\ZYKai_T.TTF", 12, "THICKOUTLINE")
					end
				else
					if (GetLocale() ~= "zhTW") then
						_G["RR_Roller"..i]:SetFont("Fonts\\FRIZQT__.TTF", 12)
					end
					if (GetLocale() == "zhCN") then
						_G["RR_Roller"..i]:SetFont("Fonts\\ZYKai_T.TTF", 12)
					end
				end
				
				if RollerName[RR_DisplayID][i+RR_ScrollOffset] then
					if RaidRoll_DBPC[UnitName("player")]["RR_NameMark"][strlower(RollerName[RR_DisplayID][i+RR_ScrollOffset])] == nil then	RaidRoll_DBPC[UnitName("player")]["RR_NameMark"][strlower(RollerName[RR_DisplayID][i+RR_ScrollOffset])] = false end
					
					if RaidRoll_DBPC[UnitName("player")]["RR_NameMark"][strlower(RollerName[RR_DisplayID][i+RR_ScrollOffset])] == true then 
						if RaidRoll_DBPC[UnitName("player")]["RR_PlayerIcon"] ~= nil then
							if RaidRoll_DBPC[UnitName("player")]["RR_PlayerIcon"][strlower(RollerName[RR_DisplayID][i+RR_ScrollOffset])] ~= nil then
								mark = RaidRoll_DBPC[UnitName("player")]["RR_PlayerIcon"][strlower(RollerName[RR_DisplayID][i+RR_ScrollOffset])] 
							end
						end
					else
						mark = "" 
					end
				end
				
				if RollerColor[RR_DisplayID][i+RR_ScrollOffset] ~= nil and RollerColor[RR_DisplayID][i+RR_ScrollOffset] ~= "" then
					_G["RR_Roller"..i]:SetText(color .. mark .. RollerColor[RR_DisplayID][i+RR_ScrollOffset] ..  RollerName[RR_DisplayID][i+RR_ScrollOffset] .. "|r")
				else
					_G["RR_Roller"..i]:SetText(color .. mark ..  RollerName[RR_DisplayID][i+RR_ScrollOffset])
				end
				
				if RollerRoll[RR_DisplayID][i+RR_ScrollOffset] == 0 then
					_G["RR_Rolled"..i]:SetText("")
				else
					if RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] == true then
						-- Display epgp values instead of rolls
						RR_Rolled:SetText("PR")
						if RR_EPGPAboveThreshold[RR_DisplayID][i+RR_ScrollOffset] ~= true then
							_G["RR_Rolled"..i]:SetText("|cFFC41F3B" .. RR_EPGP_PRValue[RR_DisplayID][i+RR_ScrollOffset])	-- not above threshold (red)
						else
							_G["RR_Rolled"..i]:SetText("|cFFABD473" .. RR_EPGP_PRValue[RR_DisplayID][i+RR_ScrollOffset])	-- above threshold (green)
						end
					else
						RR_Rolled:SetText("Roll")
						if RaidRoll_LegitRoll[RR_DisplayID][i+RR_ScrollOffset] == true then
							ExtraChar = ""
						else
							ExtraChar = "*"
						end
						
						
						
						if RollerFirst[RR_DisplayID][i+RR_ScrollOffset] == true then
							_G["RR_Rolled"..i]:SetText(color .. RollerRoll[RR_DisplayID][i+RR_ScrollOffset] .. ExtraChar)
						else
							_G["RR_Rolled"..i]:SetText(color .. "(" .. Roll_Number[RR_DisplayID][i+RR_ScrollOffset] .. ") " .. RollerRoll[RR_DisplayID][i+RR_ScrollOffset] .. ExtraChar)
						end
					end
				end
				
				
				if RollerRankIndex[RR_DisplayID][i+RR_ScrollOffset] == 99 then
					_G["Raid_Roll_Rank_String"..i]:SetText("")
				else
					_G["Raid_Roll_Rank_String"..i]:SetText(color .. "(" .. RollerRankIndex[RR_DisplayID][i+RR_ScrollOffset] .. ") " .. RollerRank[RR_DisplayID][i+RR_ScrollOffset])
				end
				
				for j = 1,40 do
					local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(j);
					
					--RR_Test(j .. name .. subgroup)
					
					if name == RollerName[RR_DisplayID][i+RR_ScrollOffset] then
						--RR_Test(i .. " " .. RollerName[RR_DisplayID][i+RR_ScrollOffset] .. " - " .. name)
						RollerGroup[RR_DisplayID][i+RR_ScrollOffset] = subgroup
					end
				end
				
				if RollerGroup[RR_DisplayID][i+RR_ScrollOffset] == nil then RollerGroup[RR_DisplayID][i+RR_ScrollOffset] = "" end
				_G["RR_Group"..i]:SetText(color .. RollerGroup[RR_DisplayID][i+RR_ScrollOffset])
			end
		end
	end

	-- This controls the showing of the window (true = show window, false = dont show window)
		if RaidRoll_DBPC[UnitName("player")]["RR_Roll_Tracking_Enabled"] == true then
			RR_RollFrame:Show()
			RR_NAME_FRAME:Show()
		end
	
	if rr_rollID ~= 0 then
		if rr_CurrentRollID < rr_rollID then
			RR_Next:Enable()
		else
			RR_Next:Disable()
		end
		
		if rr_CurrentRollID > 0 then
			RR_Last:Enable()
		else
			RR_Last:Disable()
		end
	else
		RR_Last:Disable()
		RR_Next:Disable()
	end
	
end


function RR_Command(cmd)
--Stuff that happens when you press /mm <command>

RR_ItemLink = nil --clearing the variable

cmd_n = tonumber(cmd)
cmd_s = string.lower(cmd)

	if cmd_s == "options" 
	or cmd_s == "option" 
	or cmd_s == "config" then 
		RR_OptionsScreenToggle()
	end

	if cmd_s == "zone" then 
		RR_ZoneInfo = {}
		RR_NamesList = {}
		RR_NameAmount = 0
		
		for i=1,40 do
			name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(i);
			
			if name ~= nil then
				--RR_Test("Name: " .. name .. " - Location: " .. zone)
				
				RR_NameAmount = RR_NameAmount + 1
				RR_NamesList[RR_NameAmount] = name
				RR_ZoneInfo[name] = {}
				RR_ZoneInfo[name]["Zone"] = zone
			end			
		end
		
		for i=1,40 do
			name, realm = UnitName("raid"..i)
			inRange = CheckInteractDistance("raid"..i, 1);
			
			if name ~= nil then	
				if inRange == nil then inRange = 0 end	
				
				--RR_Test("Name: " .. name .. " - InRange: " .. inRange)
				
				RR_ZoneInfo[name]["InRange"] = inRange
			end			
		end
		
		if RR_NameAmount > 0 then
			RR_DifferentZone = ""
			RR_OutOfRange = ""
			
			for i=1,RR_NameAmount do
				name = RR_NamesList[i]
				
				if RR_ZoneInfo[name]["InRange"] ~= RR_ZoneInfo[UnitName("player")]["InRange"] then
					if RR_ZoneInfo[name]["Zone"] ~= RR_ZoneInfo[UnitName("player")]["Zone"] then
						-- Different Zone
						if RR_DifferentZone == "" then
							RR_DifferentZone = name
						else
							RR_DifferentZone = RR_DifferentZone .. "," .. name
						end
					else
						-- Same Zone > 28yd away
						if RR_OutOfRange == "" then
							RR_OutOfRange = name
						else
							RR_OutOfRange = RR_OutOfRange .. "," .. name
						end
					end
				end
			end
			
			if RR_DifferentZone ~= "" then
				SendChatMessage(RAIDROLL_LOCALE["Players_in_another_zone"] .. RR_DifferentZone, "RAID")
			end
			
			if RR_OutOfRange ~= "" then
				SendChatMessage(RAIDROLL_LOCALE["Players_28_yd_from_me"] .. RR_OutOfRange, "RAID")
			end
			
			if RR_DifferentZone == "" and RR_OutOfRange == "" then
				SendChatMessage(RAIDROLL_LOCALE["Everyone_is_here"] .. " /cheer", "RAID")
			end
		end
		
	end

	if cmd_s == "loot" then 
		if RR_LOOT_FRAME:IsShown() then
			RR_LOOT_FRAME:Hide()
		else
			RR_LOOT_FRAME:Show()
		end
	end

	if cmd_s == "debug" then
		if RaidRoll_DB["debug"] == nil then
			RaidRoll_DB["debug"] = true
		elseif RaidRoll_DB["debug"] == false then
			RaidRoll_DB["debug"] = true
		elseif RaidRoll_DB["debug"] == true then
			RaidRoll_DB["debug"] = false
		end
		
		
		if RaidRoll_DB["debug"] == true then
			RR_Test("Raid Roll - Debug Mode Enabled")
		end
		
		if RaidRoll_DB["debug"] == false then
			RR_Test("Raid Roll - Debug Mode Disabled")
		end
	end
	
	if cmd_s == "debug2" then
		if RaidRoll_DB["debug2"] == nil then
			RaidRoll_DB["debug2"] = true
		elseif RaidRoll_DB["debug2"] == false then
			RaidRoll_DB["debug2"] = true
		elseif RaidRoll_DB["debug2"] == true then
			RaidRoll_DB["debug2"] = false
		end
		
		
		if RaidRoll_DB["debug2"] == true then
			RR_Test("Raid Roll - Debug2 Mode Enabled")
		end
		
		if RaidRoll_DB["debug2"] == false then
			RR_Test("Raid Roll - Debug2 Mode Disabled")
		end
	end
	
	
	if cmd_s == "help" then
		for i=1,13 do
			RR_Test(RAIDROLL_LOCALE["HELP"..i])
		end
	end
	
	if cmd_s == "epgp" then
		if RR_RollCheckBox_EPGPMode_panel:GetChecked() then
			RR_RollCheckBox_EPGPMode_panel:SetChecked(false)
			RR_Test("EPGP Mode - |cFFC41F3BDISABLED")
		else
			RR_RollCheckBox_EPGPMode_panel:SetChecked(true)
			RR_Test("EPGP Mode - |cFFABD473ENABLED")
		end
		RaidRoll_CheckButton_Update_Panel()
		RR_Display(rr_CurrentRollID)
	end

-- reset the position of the rolling frame
	if cmd_s == "reset" or cmd_s == "resetpos" then
		_G["RR_RollFrame"]:ClearAllPoints(); 
		_G["RR_RollFrame"]:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		RR_Display(rr_CurrentRollID)
	end


	if cmd_s == "show" then
		RR_RollFrame:Show()
		RR_NAME_FRAME:Show()
	end
	
	if cmd_s == "toggle" then
		if RR_RollFrame:IsShown() then
			RR_RollFrame:Hide()
			RR_NAME_FRAME:Hide()
		else
			RR_RollFrame:Show()
			RR_NAME_FRAME:Show()
		end
	end
	
	if cmd_s == "test" then
		 RR_Test("Kilerpet's Raid Roll Addon - Loaded")
	end	
	
	
	if cmd_s == "unan" or cmd_s == "unannounced" then
		if RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] == true then
			RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] =  false
			RR_Test("Raid Roll: Auto-Tracking Rolls Disabled")
			RaidRoll_Catch_All:SetChecked(false);
		else
			RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] =  true
			RR_Test("Raid Roll: Auto-Tracking Rolls Enabled")
			RaidRoll_Catch_All:SetChecked(true);
		end
	end	

-- This controls the showing of the window (true = show window, false = dont show window)
	if cmd_s == "enable" then
		RaidRoll_DBPC[UnitName("player")]["RR_Roll_Tracking_Enabled"] = true
		RR_Test("Raid Roll: Raid Roll Tracking enabled. Type ''/rr disable'' to disable tracking")
	end	
	
	if cmd_s == "disable" then
		RaidRoll_DBPC[UnitName("player")]["RR_Roll_Tracking_Enabled"] = false
		RR_Test("Raid Roll: Raid Roll Tracking disabled. Type ''/rr enable'' to enable tracking")
	end	
	
	
	if cmd_s == "all" then
		if RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] == true then
			RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] =  false
			RR_Test("Raid Roll: Only 1-100 rolls accepted")
			RaidRoll_Allow_All:SetChecked(false);
		else
			RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] =  true
			RR_Test("Raid Roll: All rolls accepted")
			RaidRoll_Allow_All:SetChecked(true);
		end
	end
	
	
	
	
	
	
	
	local cmd1, cmd2, cmd3 = strsplit(" ", cmd_s, 3)
	
	if cmd1 == "mark" then
		if cmd2 ~= nil and cmd2 ~= "!reset" then
			name = "Nobody was"
			if tonumber(cmd2) == nil then
				name = cmd2
				if RaidRoll_DBPC[UnitName("player")]["RR_NameMark"][name] == true then
					RaidRoll_DBPC[UnitName("player")]["RR_NameMark"][name] = false
				else
					RaidRoll_DBPC[UnitName("player")]["RR_NameMark"][name] = true
				end
				RR_Test(name .. " " .. RAIDROLL_LOCALE["added_to_marking_list"])
			else
				if RollerName[rr_CurrentRollID][tonumber(cmd2)] ~= nil then
					name = strlower(RollerName[rr_CurrentRollID][tonumber(cmd2)])
					
					if RaidRoll_DBPC[UnitName("player")]["RR_NameMark"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_NameMark"] = {} end
					
					RaidRoll_DBPC[UnitName("player")]["RR_NameMark"][name] = true
					
					if RaidRoll_DBPC[UnitName("player")]["RR_PlayerIconID"]==nil then  RaidRoll_DBPC[UnitName("player")]["RR_PlayerIconID"]={} end
					if RaidRoll_DBPC[UnitName("player")]["RR_PlayerIcon"]==nil then  RaidRoll_DBPC[UnitName("player")]["RR_PlayerIcon"]={} end
					
					if RaidRoll_DBPC[UnitName("player")]["RR_PlayerIconID"][name] == nil then 
						RaidRoll_DBPC[UnitName("player")]["RR_PlayerIconID"][name] = 1
					end
					
					if RaidRoll_DBPC[UnitName("player")]["RR_PlayerIconID"][name] < RR_NumberOfIcons then
						RaidRoll_DBPC[UnitName("player")]["RR_PlayerIconID"][name] = RaidRoll_DBPC[UnitName("player")]["RR_PlayerIconID"][name] + 1
					else
						RaidRoll_DBPC[UnitName("player")]["RR_PlayerIconID"][name] = 1
					end
					
					RaidRoll_DBPC[UnitName("player")]["RR_PlayerIcon"][name] = RR_ListOfIcons[RaidRoll_DBPC[UnitName("player")]["RR_PlayerIconID"][name]]
				end
			end
			
			
		end
		
	end
	
	if cmd1 == "unmark" then
		if cmd2 ~= nil and cmd2 ~= "!reset" then
			if tonumber(cmd2) == nil then
				name = cmd2
				RaidRoll_DBPC[UnitName("player")]["RR_NameMark"][name] = false
			else
				name = strlower(RollerName[rr_CurrentRollID][tonumber(cmd2)])
				RaidRoll_DBPC[UnitName("player")]["RR_NameMark"][name] = false
			end
			
			RR_Test(name .. " " .. RAIDROLL_LOCALE["removed_from_marking_list"])
		end
	end
	
	if cmd1 == "mark" and cmd2 == "!reset" then
		RaidRoll_DBPC[UnitName("player")]["RR_NameMark"] = {}
		RR_Test(RAIDROLL_LOCALE["Marking_list_cleared"])
	end
	
	if RR_RollFrame:IsShown() then
		RR_Display(rr_CurrentRollID)
	end	
	
	
	
	
	
	
	
	
	-- GetNumRaidMembers() == 0 then alone / in party
	
if RaidRoll_DB["debug"] == true then if cmd == "" then RR_Test("Standard Raid Roll Detected") end end

--Do a standard Raid roll
	if cmd == "" then 
		if GetNumRaidMembers() ~= 0 then 
			if RaidRoll_DB["debug"] == true then  RR_Test("Raid Group detected. Doing a raid roll") end
			RR_DoARaidRoll()
		else
			if RaidRoll_DB["debug"] == true then  RR_Test("You are not in a raid group. Doing a party roll") end
			RR_DoAPartyRoll()
		end
	end
	
	
	

--Find the start and end location of the item link
	RR_Start_Loc,_ = string.find(cmd, "item:");
	_,RR_End_Loc = string.find(cmd, "|h|r")
	
--Cut the itemlink out of the string
	if RR_Start_Loc ~= nil and RR_End_Loc ~= nil then
		RR_ItemLink = strsub(cmd,RR_Start_Loc-12,RR_End_Loc)
	end
--For debugging, show the itemlink
	if RaidRoll_DB["debug"] == true then RR_Test(RR_ItemLink) end
	
--Cut up the command to see if it was a reroll or not
	RR_Reroll = strsub(cmd_s,1,3)
	RR_Reroll_Long = strsub(cmd_s,1,6)
	
--for debugging, show the results of the split up string
	if RaidRoll_DB["debug"] == true then RR_Test(RR_Reroll) end
	if RaidRoll_DB["debug"] == true then RR_Test(RR_Reroll_Long) end
	
--Do a  repeat Raid roll
	if RR_Reroll == "re " or RR_Reroll_Long == "reroll" or cmd1 == "re" then
		if RR_ItemLink ~= nil then 
			if GetNumRaidMembers() ~= 0 then 
				if RaidRoll_DB["debug"] == true then  RR_Test("Raid Group detected. Doing a raid roll") end
				RR_DoARaidRoll(RR_ItemLink,"ReRoll")
			else
				if RaidRoll_DB["debug"] == true then  RR_Test("You are not in a raid group. Doing a party roll") end
				RR_DoAPartyRoll(RR_ItemLink,"ReRoll")
			end
		else
			if GetNumRaidMembers() ~= 0 then 
				if RaidRoll_DB["debug"] == true then  RR_Test("Raid Group detected. Doing a raid roll") end
				RR_DoARaidRoll(nil,"ReRoll")
			else
				if RaidRoll_DB["debug"] == true then  RR_Test("You are not in a raid group. Doing a party roll") end
				RR_DoAPartyRoll(nil,"ReRoll")
			end
		end
	else
	--Do a  Raid roll and show the item being rolled for
		if RR_ItemLink ~= nil then 
			if GetNumRaidMembers() ~= 0 then 
				if RaidRoll_DB["debug"] == true then  RR_Test("Raid Group detected. Doing a raid roll") end
				RR_DoARaidRoll(RR_ItemLink)
			else
				if RaidRoll_DB["debug"] == true then  RR_Test("You are not in a raid group. Doing a party roll") end
				RR_DoAPartyRoll(RR_ItemLink)
			end
		end
	end
	
	
end



function RR_Ignore(ID)
	Name = string.lower(RollerName[rr_CurrentRollID][tonumber(ID)])
	
	if RaidRoll_DB["debug"] == true then RR_Test("ID # "..ID) end
	
	if Name ~= nil and Name ~= "" then
		if RR_IgnoredList == nil then RR_IgnoredList = {} end
		if RR_IgnoredList[rr_CurrentRollID] == nil then RR_IgnoredList[rr_CurrentRollID] = {} end
		
		if RR_IgnoredList[rr_CurrentRollID][Name] == true then
			RR_IgnoredList[rr_CurrentRollID][Name] = false 
			RR_Test(">> " .. Name .. " NOT ignored for " .. rr_Item[rr_CurrentRollID])
		else
			RR_IgnoredList[rr_CurrentRollID][Name] = true
			RR_Test(">> " .. Name .. " ignored for " .. rr_Item[rr_CurrentRollID])
		end
	end
	
	RR_Display(rr_CurrentRollID)
	
end


function RR_DoARaidRoll(ItemLink, Type)

-- Set the number to the amout of people in the raid
	RR_num = GetNumRaidMembers()
	local num = RR_num

-- Clear the list of people in the raid
	if RR_Name_Array == nil then 
		RR_Name_Array = {}
	end
	
-- Setup announce types (if raid leader its raid warning, otherwise its raid chat)
	rr_AnnounceType1 = "RAID"
	if IsRaidLeader() ~= nil or IsRaidOfficer() ~= nil then
		rr_AnnounceType2 = "RAID_WARNING"
	else
		rr_AnnounceType2 = "RAID"
	end
	
-- If the array is empty then we are not doing a reroll
	if RR_Name_Array[1] == nil then
		if RaidRoll_DB["debug"] == true then  RR_Test("Name array empty, we are not rerolling") end
		Type = nil	
	end

	
-- Output the list of people to raid chat if its not a reroll
	if Type ~= "ReRoll" then
		
	-- Check if there is an item being rolled on
		if ItemLink == nil then
			SendChatMessage(RAIDROLL_LOCALE["Raid_Rolling"] .. " " .. RAIDROLL_LOCALE["ID_Name"] , rr_AnnounceType2)
		else
			SendChatMessage("<<" .. RAIDROLL_LOCALE["Raid_Rolling_for"] .. ItemLink .. " >> " .. RAIDROLL_LOCALE["ID_Name"] , rr_AnnounceType2)
		end
		
	-- Add the members of the raid to the name array
		for i=1,GetNumRaidMembers() do				
			RR_Name_Array[i] = GetRaidRosterInfo(i);			
		end
		
		if num < 21 then 
			num = num + 1
			for i=1,num/2 do
				i_mod = 2 * i
				--RR_Test(i_mod .. num)
				if GetRaidRosterInfo(i_mod) ~= nil and i_mod <= num-1 then 
					SendChatMessage("#".. i_mod-1 .." - " .. GetRaidRosterInfo(i_mod-1) .. "" .. "    #" .. i_mod .." - " .. GetRaidRosterInfo(i_mod), rr_AnnounceType1)
				else
					SendChatMessage("#".. i_mod-1 .." - " .. GetRaidRosterInfo(i_mod-1), rr_AnnounceType1)
				end
				--RR_Test("#".. i .." - " .. GetRaidRosterInfo(i))
				--RR_Test(num)				
			end
		else
			num = num + 2
			for i=1,num/3 do
				i_mod = 3 * i
				--RR_Test(i_mod .. num)
				if GetRaidRosterInfo(i_mod) ~= nil and i_mod <= num-2 then 
					SendChatMessage("#".. i_mod-2 .." - " .. GetRaidRosterInfo(i_mod-2) .. "    #" .. i_mod-1 .." - " .. GetRaidRosterInfo(i_mod-1) .. "    #" .. i_mod .." - " .. GetRaidRosterInfo(i_mod), rr_AnnounceType1)
				elseif GetRaidRosterInfo(i_mod-1) ~= nil and  i_mod <= num-1 then
					SendChatMessage("#".. i_mod-2 .." - " .. GetRaidRosterInfo(i_mod-2) .. "" .. "    #" .. i_mod-1 .." - " .. GetRaidRosterInfo(i_mod-1), rr_AnnounceType1)
				else
					SendChatMessage("#".. i_mod-2 .." - " .. GetRaidRosterInfo(i_mod-2), rr_AnnounceType1)
				end
				--RR_Test("#".. i .." - " .. GetRaidRosterInfo(i))
				--RR_Test(num)				
			end
		end
	else
	-- Check if there is an item being rolled on
		if ItemLink == nil then
			SendChatMessage(RAIDROLL_LOCALE["Re_Rolling"] , rr_AnnounceType2)
		else
			SendChatMessage("<<" .. RAIDROLL_LOCALE["Re_Rolling_for"] .. ItemLink .. " >>" , rr_AnnounceType2)
		end
	end
	
	
	
-- After 2 seconds do a roll
	Raid_Roll_AutoUpdate_Time=GetTime()+2
	Raid_Roll_AutoUpdate:SetScript("OnUpdate",function() 
												if GetTime() >= Raid_Roll_AutoUpdate_Time then 
													Raid_Roll_AutoUpdate_Time=0 
													Raid_Roll_AutoUpdate:SetScript("OnUpdate",function() end)
													RR_Roll(); 
												end
											end)

	
end


function RR_DoAPartyRoll(ItemLink, Type)

-- Set the number to the amout of people in the party (it ranges from 0-4)
	RR_num = GetNumPartyMembers() + 1
	local num = RR_num

-- Clear the list of people in the raid
	if RR_Name_Array == nil then 
		RR_Name_Array = {}
	end
	
-- Setup announce types (Party and raid warning if in a party, say if alone)
	if GetNumPartyMembers() > 0 then
		rr_AnnounceType1 = "PARTY"
		rr_AnnounceType2 = "PARTY"
	else
		rr_AnnounceType1 = "SAY"
		rr_AnnounceType2 = "SAY"
	end
	
-- If the array is empty then we are not doing a reroll
	if RR_Name_Array[1] == nil then
		if RaidRoll_DB["debug"] == true then  RR_Test("Name array empty, we are not rerolling") end
		Type = nil	
	end
	
-- Output the list of people to raid chat if its not a reroll
	if Type ~= "ReRoll" then
	
	-- Check if there is an item being rolled on
		if ItemLink == nil then
			SendChatMessage(RAIDROLL_LOCALE["Raid_Rolling"] .. " " .. RAIDROLL_LOCALE["ID_Name"] , rr_AnnounceType2)
		else
			SendChatMessage("<<" .. RAIDROLL_LOCALE["Raid_Rolling_for"] .. ItemLink .. " >> " .. RAIDROLL_LOCALE["ID_Name"] , rr_AnnounceType2)
		end
	
	-- Add the members of the raid to the name array
		for i=1,RR_num do
			if i == 1 then
				RR_Name_Array[i] = UnitName("player")
			else
				RR_Name_Array[i] = UnitName("party" .. i-1)
			end
		end
		
		num = num + 1
		for i=1,num/2 do
			i_mod = 2 * i
			--RR_Test(i_mod .. num)
			if RR_Name_Array[i_mod] ~= nil and i_mod <= num-1 then 
				SendChatMessage("#".. i_mod-1 .." - " .. RR_Name_Array[i_mod-1] .. "" .. "    #" .. i_mod .." - " .. RR_Name_Array[i_mod], rr_AnnounceType1)
			else
				SendChatMessage("#".. i_mod-1 .." - " .. RR_Name_Array[i_mod-1], rr_AnnounceType1)
			end		
		end
	else
	-- Check if there is an item being rolled on
		if ItemLink == nil then
			SendChatMessage(RAIDROLL_LOCALE["Re_Rolling"] , rr_AnnounceType2)
		else
			SendChatMessage("<<" .. RAIDROLL_LOCALE["Re_Rolling_for"] .. ItemLink .. " >>" , rr_AnnounceType2)
		end
	end
	
-- After 2 seconds do a roll	
	Raid_Roll_AutoUpdate_Time=GetTime()+2
	Raid_Roll_AutoUpdate:SetScript("OnUpdate",function() 
												if GetTime() >= Raid_Roll_AutoUpdate_Time then 
													Raid_Roll_AutoUpdate_Time=0 
													Raid_Roll_AutoUpdate:SetScript("OnUpdate",function() end)
													RR_Roll(); 
												end
											end)

	
end

function RR_Roll()

RandomRoll(1,RR_num);

RR_Has_Rolled = true

end


function RR_CloseWindow()
	RR_RollFrame:Hide()
	RR_NAME_FRAME:Hide()
end

function RR_PrevRoll()

	RR_ScrollOffset = 0

	if rr_CurrentRollID > 0 then
		rr_CurrentRollID = rr_CurrentRollID - 1
		RR_Display(rr_CurrentRollID)
	end
	
	if rr_CurrentRollID == 0 then 
		RR_Last:Disable()
		RR_Next:Enable()
	else
		RR_Last:Enable()
		RR_Next:Enable()
	end
	
	rr_RollSort(rr_CurrentRollID)
	RR_Display(rr_CurrentRollID)
end

function RR_NewRoll()






	RR_RollFrame:SetHeight(155)
	RR_ScrollOffset = 0
	
	RR_Timestamp = time() + RaidRoll_DBPC[UnitName("player")]["Time_Offset"]
	--RR_Test("Timestamp set to :" .. RR_Timestamp)	--Debugging, displays the timestamp
	
	RR_Doing_a_New_Roll = true

	if RollerName[rr_rollID][1] ~= "" or rr_Item[rr_rollID] ~= "ID #"..rr_rollID then
		rr_rollID = rr_rollID + 1		
		
		rr_Item[rr_rollID] = "ID #"..rr_rollID
		
		
		if rr_CurrentRollID+1 == rr_rollID then
			rr_CurrentRollID = rr_rollID
			RR_Last:Enable()
		end
		
		rr_RollSort(rr_rollID,0,"",true)
	end
	
	rr_RollSort(rr_CurrentRollID)
	RR_Display(rr_CurrentRollID)
end

function RR_NextRoll()

	RR_ScrollOffset = 0
	
	if rr_CurrentRollID < rr_rollID then
		rr_CurrentRollID = rr_CurrentRollID + 1
		RR_Display(rr_CurrentRollID)
	end
	
	if rr_CurrentRollID == rr_rollID then 
		RR_Next:Disable()
		RR_Last:Enable()
	else
		RR_Next:Enable()
		RR_Last:Enable()
	end	
	
	rr_RollSort(rr_CurrentRollID)
	RR_Display(rr_CurrentRollID)
end

function RaidRoll_CheckButton_Update()

--RaidRoll_Allow_All:SetChecked(true);
	if RaidRoll_Catch_All:GetChecked()  then
		RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] =  true
		RaidRoll_Catch_All:SetChecked(true)
		RR_RollCheckBox_Unannounced_panel:SetChecked(true)
		--RR_Test("Raid Roll: Auto-Tracking Rolls Enabled")
	else
		RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] =  false
		RaidRoll_Catch_All:SetChecked(false)
		RR_RollCheckBox_Unannounced_panel:SetChecked(false)
		--RR_Test("Raid Roll: Auto-Tracking Rolls Disabled")
	end

	if RaidRoll_Allow_All:GetChecked()  then
		RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] =  true
		RaidRoll_Allow_All:SetChecked(true)
		RR_RollCheckBox_AllRolls_panel:SetChecked(true)
		--RR_Test("Raid Roll: All rolls accepted")
	else
		RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] =  false
		RaidRoll_Allow_All:SetChecked(false)
		RR_RollCheckBox_AllRolls_panel:SetChecked(false)
		--RR_Test("Raid Roll: Only 1-100 rolls accepted")
	end
	
	if RR_RollCheckBox_ExtraRolls:GetChecked()  then
		RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] =  true
		RR_RollCheckBox_ExtraRolls:SetChecked(true)
		RR_RollCheckBox_ExtraRolls_panel:SetChecked(true)
		--RR_Test("Raid Roll: All rolls accepted")
	else
		RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] =  false
		RR_RollCheckBox_ExtraRolls:SetChecked(false)
		RR_RollCheckBox_ExtraRolls_panel:SetChecked(false)
		--RR_Test("Raid Roll: Only 1-100 rolls accepted")
	end

--[[
	if RR_RollCheckBox_ShowRanks:GetChecked()  then
		RaidRoll_DBPC[UnitName("player")]["RR_Show_Ranks"] =  true
		RR_RollCheckBox_ShowRanks:SetChecked(true)
		RR_RollCheckBox_ShowRanks_panel:SetChecked(true)
		for i=1,6 do
			_G["Raid_Roll_Rank_String"..i-1]:Show()
		end
		RR_RollFrame:SetWidth(265+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"])
		_G["RR_Rolled"]:ClearAllPoints()
		_G["RR_Rolled"]:SetPoint("TOPLEFT", _G["RR_RollFrame"], "TOPLEFT",170+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"],-30)
		
		_G["RR_Group0"]:ClearAllPoints()
		_G["RR_Group0"]:SetPoint("TOPLEFT", _G["RR_RollFrame"], "TOPLEFT",220+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"],-30)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_Show_Ranks"] =  false
		RR_RollCheckBox_ShowRanks:SetChecked(false)
		RR_RollCheckBox_ShowRanks_panel:SetChecked(false)
		for i=1,6 do
			_G["Raid_Roll_Rank_String"..i-1]:Hide()
		end
		RR_RollFrame:SetWidth(215+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"])
		_G["RR_Rolled"]:ClearAllPoints()
		_G["RR_Rolled"]:SetPoint("TOPLEFT", _G["RR_RollFrame"], "TOPLEFT",120+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"],-30)
		
		_G["RR_Group0"]:ClearAllPoints()
		_G["RR_Group0"]:SetPoint("TOPLEFT", _G["RR_RollFrame"], "TOPLEFT",170+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"],-30)
		
	end
]]
	
	
	if RR_RollCheckBox_RankPrio_panel:GetChecked()  then
		RaidRoll_DBPC[UnitName("player")]["RR_RankPriority"] =  true
		--RR_RollCheckBox_RankPrio:SetChecked(true)
		RR_RollCheckBox_RankPrio_panel:SetChecked(true)
		--RR_Test("Raid Roll: All rolls accepted")
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RankPriority"] =  false
		--RR_RollCheckBox_RankPrio:SetChecked(false)
		RR_RollCheckBox_RankPrio_panel:SetChecked(false)
		--RR_Test("Raid Roll: Only 1-100 rolls accepted")
	end
	
	rr_RollSort(rr_CurrentRollID)
	
	if RR_HasDisplayedAlready ~= nil then
		RR_Display(rr_CurrentRollID)
	end
	
	for i=1,5 do
		_G["Raid_Roll_Rank_String"..i]:SetWidth(65+RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"]); 
	end
	
	RaidRoll_CheckButton_Update_Panel()
end


function Set_RaidRoll_ExtraWidth(width)

 RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"] = width
 RaidRoll_CheckButton_Update()

end


function RR_SetupVariables()

	Raid_Roll_AutoUpdate=CreateFrame("FRAME","Raid_Roll_AutoUpdate");
	
--[[
	if IsInGuild() then 
		if RaidRoll_DB["debug"] == true then RR_Test("--In Guild, Auto refreshing guild info--") end
		RR_AutoUpdate_GUILDROSTERTIME = GetTime() + 6
		UIParent:HookScript("OnUpdate",	function() 
											if GetTime() > RR_AutoUpdate_GUILDROSTERTIME then
												if IsInGuild() then GuildRoster() end
												if RaidRoll_DB["debug"] == true then RR_Test("--Auto refreshing guild info again--") end
												RR_AutoUpdate_GUILDROSTERTIME = GetTime() + 6
											end 
										end)
	end 
]]

	if RaidRoll_DB == nil then RaidRoll_DB = {} end
	if RaidRoll_DBPC == nil then RaidRoll_DBPC = {} end
	if RaidRoll_DBPC[UnitName("player")] == nil then RaidRoll_DBPC[UnitName("player")] = {} end
	
	--[[
	if RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] == nil then RaidRoll_DBPC[UnitName("player")][""] = RR_Accept_All_Rolls end
	if RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] = RR_Track_Unannounced_Rolls end
	if RaidRoll_DBPC[UnitName("player")]["RR_Roll_Tracking_Enabled"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_Roll_Tracking_Enabled"] = RR_Roll_Tracking_Enabled end
	if RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] = RR_AllowExtraRolls end
	if RaidRoll_DBPC[UnitName("player")]["RR_Show_Ranks"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_Show_Ranks"] = RR_Show_Ranks end
	if RaidRoll_DBPC[UnitName("player")]["RR_RankPriority"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_RankPriority"] = RR_RankPriority end
	if RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"] = RR_ExtraWidth end
	if RaidRoll_DBPC[UnitName("player")]["RR_ShowGroupNumber"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_ShowGroupNumber"] = RR_ShowGroupNumber end
	if RaidRoll_DBPC[UnitName("player")]["RR_RollFrameHeight"] == nil then RaidRoll_DBPC[UnitName("player")]["RR_RollFrameHeight"] = RR_RollFrameHeight end
	]]

	RR_SetupNameFrame()
	RR_ExtraFrame_Options()
	Setup_RR_Panel()

	if RaidRoll_LootTrackerLoaded==true then
		RR_SetupLootFrame()
		
		
-- edit box 1
		if RaidRoll_DBPC[UnitName("player")]["Raid_Roll_SetMsg1_EditBox"] == nil then
			RaidRoll_DBPC[UnitName("player")]["Raid_Roll_SetMsg1_EditBox"] = "Roll [Item] Main Spec"
		end
		
-- edit box 2
		if RaidRoll_DBPC[UnitName("player")]["Raid_Roll_SetMsg2_EditBox"] == nil then
			RaidRoll_DBPC[UnitName("player")]["Raid_Roll_SetMsg2_EditBox"] = "Roll [Item] Off Spec"
		end
		
-- edit box 3
		if RaidRoll_DBPC[UnitName("player")]["Raid_Roll_SetMsg3_EditBox"] == nil then
			RaidRoll_DBPC[UnitName("player")]["Raid_Roll_SetMsg3_EditBox"] = "Roll [Item] Off Spec"
		end
		
		Raid_Roll_SetMsg1_EditBox:Insert(RaidRoll_DBPC[UnitName("player")]["Raid_Roll_SetMsg1_EditBox"])
		Raid_Roll_SetMsg2_EditBox:Insert(RaidRoll_DBPC[UnitName("player")]["Raid_Roll_SetMsg2_EditBox"])
		Raid_Roll_SetMsg3_EditBox:Insert(RaidRoll_DBPC[UnitName("player")]["Raid_Roll_SetMsg3_EditBox"])
		
-- RR_ReceiveGuildMessages
		if RaidRoll_DBPC[UnitName("player")]["RR_ReceiveGuildMessages"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_ReceiveGuildMessages"] == false then
			RaidRoll_DBPC[UnitName("player")]["RR_ReceiveGuildMessages"] =  false
			RR_ReceiveGuildMessages:SetChecked(false)
		else
			RR_ReceiveGuildMessages:SetChecked(true)
		end
		
-- RR_Enable3Messages
		if RaidRoll_DBPC[UnitName("player")]["RR_Enable3Messages"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_Enable3Messages"] == false then
			RaidRoll_DBPC[UnitName("player")]["RR_Enable3Messages"] =  false
			RR_Enable3Messages:SetChecked(false)
		else
			RR_Enable3Messages:SetChecked(true)
		end
		
-- RR_Frame_WotLK_Dung_Only
		if RaidRoll_DBPC[UnitName("player")]["RR_Frame_WotLK_Dung_Only"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_Frame_WotLK_Dung_Only"] == false then
			RaidRoll_DBPC[UnitName("player")]["RR_Frame_WotLK_Dung_Only"] = false
			RR_Frame_WotLK_Dung_Only:SetChecked(false)
		else
			RR_Frame_WotLK_Dung_Only:SetChecked(true)
		end
		
		
-- RR_AutoOpenLootWindow
		if RaidRoll_DBPC[UnitName("player")]["RR_AutoOpenLootWindow"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_AutoOpenLootWindow"] == true then
			RaidRoll_DBPC[UnitName("player")]["RR_AutoOpenLootWindow"] =  true
			RR_AutoOpenLootWindow:SetChecked(true)
		else
			RR_AutoOpenLootWindow:SetChecked(false)
		end
	end
	
	-- Show Class Colors
	if RaidRoll_DBPC[UnitName("player")]["Time_Offset"] == nil then
		RaidRoll_DBPC[UnitName("player")]["Time_Offset"] = 0
	end
	
	
-- RR_RollCheckBox_Auto_Close
	if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Close"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Close"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Close"] =  false
		RR_RollCheckBox_Auto_Close:SetChecked(false)
	else
		RR_RollCheckBox_Auto_Close:SetChecked(true)
	end
	
-- RR_RollCheckBox_No_countdown
	if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_No_countdown"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_No_countdown"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_No_countdown"] =  false
		RR_RollCheckBox_No_countdown:SetChecked(false)
	else
		RR_RollCheckBox_No_countdown:SetChecked(true)
	end	
	
	
-- RR_RollCheckBox_GuildAnnounce
	if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_GuildAnnounce"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_GuildAnnounce"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_GuildAnnounce"] =  false
		RR_RollCheckBox_GuildAnnounce:SetChecked(false)
	else
		RR_RollCheckBox_GuildAnnounce:SetChecked(true)
	end	
	
-- RR_RollCheckBox_GuildAnnounce_Officer
	if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_GuildAnnounce_Officer"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_GuildAnnounce_Officer"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_GuildAnnounce_Officer"] =  false
		RR_RollCheckBox_GuildAnnounce_Officer:SetChecked(false)
	else
		RR_RollCheckBox_GuildAnnounce_Officer:SetChecked(true)
	end	
	
-- RR_RollCheckBox_Auto_Announce
	if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Announce"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Announce"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Announce"] =  false
		RR_RollCheckBox_Auto_Announce:SetChecked(false)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Auto_Announce"] =  true
		RR_RollCheckBox_Auto_Announce:SetChecked(true)
	end

-- Show Class Colors
	if RaidRoll_DBPC[UnitName("player")]["RR_ShowClassColors"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_ShowClassColors"] == true then
		RaidRoll_DBPC[UnitName("player")]["RR_ShowClassColors"] =  true
		RR_RollCheckBox_ShowClassColors_panel:SetChecked(true)
	else
		RR_RollCheckBox_ShowClassColors_panel:SetChecked(false)
	end
	
-- Catch unannounced rolls
	if RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_Track_Unannounced_Rolls"] = false	--Set true if unannounced rolls are tracked
		RaidRoll_Catch_All:SetChecked(false)
		RR_RollCheckBox_Unannounced_panel:SetChecked(false)
	else
		RaidRoll_Catch_All:SetChecked(true)
		RR_RollCheckBox_Unannounced_panel:SetChecked(true)
	end
	
-- Allow all rolls (e.g. 1-50)
	if RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_Accept_All_Rolls"] = false	--Set true if all rolls are counted (False = only 1-100 rolls are counted)
		RaidRoll_Allow_All:SetChecked(false)
		RR_RollCheckBox_AllRolls_panel:SetChecked(false)
	else
		RaidRoll_Allow_All:SetChecked(true)
		RR_RollCheckBox_AllRolls_panel:SetChecked(true)
	end

-- Allow Extra Rolls
	if RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_AllowExtraRolls"] = false	--
		RR_RollCheckBox_ExtraRolls:SetChecked(false)
		RR_RollCheckBox_ExtraRolls_panel:SetChecked(false)
	else
		RR_RollCheckBox_ExtraRolls:SetChecked(true)
		RR_RollCheckBox_ExtraRolls_panel:SetChecked(true)
	end
	
-- Show Rank beside names
	if RaidRoll_DBPC[UnitName("player")]["RR_Show_Ranks"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_Show_Ranks"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_Show_Ranks"] = false	--
		--RR_RollCheckBox_ShowRanks:SetChecked(false)
		RR_RollCheckBox_ShowRanks_panel:SetChecked(false)
	else
		--RR_RollCheckBox_ShowRanks:SetChecked(true)
		RR_RollCheckBox_ShowRanks_panel:SetChecked(true)
	end
	
	
	
	if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Multi_Rollers"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Multi_Rollers"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Multi_Rollers"] = false
		RR_RollCheckBox_Multi_Rollers:SetChecked(false)
	else
		RR_RollCheckBox_Multi_Rollers:SetChecked(true)
	end
	
-- !bid
	if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_EPGPSays"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_EPGPSays"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_EPGPSays"] = false
		RR_RollCheckBox_Track_EPGPSays:SetChecked(false)
	else
		RR_RollCheckBox_Track_EPGPSays:SetChecked(true)
	end
	
	if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Num_Not_Req"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Num_Not_Req"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Num_Not_Req"] = false
		RR_RollCheckBox_Num_Not_Req:SetChecked(false)
	else
		RR_RollCheckBox_Num_Not_Req:SetChecked(true)
	end
	
	
	
-- !epgp
	if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_Bids"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_Bids"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Track_Bids"] = false
		RR_RollCheckBox_Track_Bids:SetChecked(false)
	else
		RR_RollCheckBox_Track_Bids:SetChecked(true)
	end
	
	
-- Give higher ranks higher priority
	if RaidRoll_DBPC[UnitName("player")]["RR_RankPriority"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_RankPriority"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_RankPriority"] = false	--
		--RR_RollCheckBox_RankPrio:SetChecked(false)
		RR_RollCheckBox_RankPrio_panel:SetChecked(false)
	else
		--RR_RollCheckBox_RankPrio:SetChecked(true)
		RR_RollCheckBox_RankPrio_panel:SetChecked(true)
	end
	
	if RaidRoll_DBPC[UnitName("player")]["RR_ShowGroupNumber"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_ShowGroupNumber"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_ShowGroupNumber"] = false
		RR_RollCheckBox_ShowGroupNumber_panel:SetChecked(false)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_ShowGroupNumber"] = true
		RR_RollCheckBox_ShowGroupNumber_panel:SetChecked(true)
	end
	
	if RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] = false
		RR_RollCheckBox_EPGPMode_panel:SetChecked(false)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Enabled"] = true
		RR_RollCheckBox_EPGPMode_panel:SetChecked(true)
	end
	
	if RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Priority"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Priority"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Priority"] = false
		RR_RollCheckBox_EPGPThreshold_panel:SetChecked(false)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_EPGP_Priority"] = true
		RR_RollCheckBox_EPGPThreshold_panel:SetChecked(true)
	end
	
	if RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Enable_Alt_Mode"] == nil or RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Enable_Alt_Mode"] == false then
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Enable_Alt_Mode"] = false
		RR_RollCheckBox_Enable_Alt_Mode:SetChecked(false)
	else
		RaidRoll_DBPC[UnitName("player")]["RR_RollCheckBox_Enable_Alt_Mode"] = true
		RR_RollCheckBox_Enable_Alt_Mode:SetChecked(true)
	end

	
	


	RR_Next:Disable()
	RR_Last:Disable()
	
-- This controls the showing of the window (true = show window, false = dont show window)
	if RaidRoll_DBPC[UnitName("player")]["RR_Roll_Tracking_Enabled"] == nil then
		RaidRoll_DBPC[UnitName("player")]["RR_Roll_Tracking_Enabled"] = true
	end
	
	if RaidRoll_DBPC[UnitName("player")]["RR_Roll_Tracking_Enabled"] == false then
		RR_Test("Raid Roll: Raid Roll Tracking disabled. Type ''/rr enable'' to enable tracking")
	end
	
-- sets up the name frame
	--RR_SetupNameFrame()
	
	

	
	RR_RollFrame:SetHeight(155)
	RR_RollWindowSizeUpdated()
	RaidRoll_CheckButton_Update()
	RaidRoll_CheckButton_Update_Panel()
end


	-- /run RaidRoll_DBPC[UnitName("player")]["RR_ExtraWidth"]=300
	-- /run RaidRoll_CheckButton_Update()

function RR_GetClassColor(Class)

	local ClassColor = ""
	local Red,Green,Blue

	Class = strupper(Class)

	if RAID_CLASS_COLORS[Class] ~= nil then
		Red = RAID_CLASS_COLORS[Class].r
		Green = RAID_CLASS_COLORS[Class].g
		Blue = RAID_CLASS_COLORS[Class].b
		
		ClassColor = "|c" .. string.format("%2x%2x%2x%2x", 255, Red*255, Green*255, Blue*255);
	end

	return ClassColor

end 