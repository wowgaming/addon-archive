--[[
Atlasloot Enhanced
Author Daviesh
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)

Functions:
AtlasLoot_HideNoUsableItems()
AtlasLoot_FilterEnableButton()
<local> CreateCheckButton(parrent, text, num)
AtlasLoote_CreateFilterOptions()

]]
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

local OptionsLoadet = false

AtlasLootFilterDB = {};

local FilterTableNames = {
	["Armor"] = AL["Armor:"],
	["WeaponsMeele"] = AL["Melee weapons:"],
	["WeaponsMeeleTwoHand"] = BabbleInventory["Two-Hand"]..":",--.." "..AL["Melee weapons:"],
	["WeaponsRanged"] = AL["Ranged weapons:"],
	["Relics"] = AL["Relics:"],
	["Other"] = AL["Other:"],
}

local FilterSort = {"Armor","WeaponsMeele","WeaponsMeeleTwoHand","WeaponsRanged","Relics","Other"}
local FilterTable = {
	["Armor"] = {
		"Cloth",		--1
		"Leather",		--2
		"Mail",			--3
		"Plate",		--4
		},
		
	["WeaponsMeele"] = {
		"Held in Off-Hand",	--1
		"Dagger",			--2
		"Mace",				--3
		"Staff",			--4		
		"Axe",				--5
		"Polearm",			--6
		"Shield",			--7
		"Sword",			--8
		"Fist Weapon",		--9
		},
		
	["WeaponsMeeleTwoHand"] = {
		"Mace",				--1
		"Axe",				--2
		"Sword",			--3	
		},
		
	["WeaponsRanged"] = {
		"Wand",			--1
		"Bow",			--2
		"Crossbow",		--3
		"Gun",			--4
		"Thrown",		--5
		},
		
	["Relics"] = {
		"Idol",			--1
		"Totem",		--2
		"Libram",		--3
		"Sigils",		--4
		},
		
	["Other"] = {
		"Ring",			--1
		"Trinket",		--2
		"Neck",			--3
		"Back",			--4
		}
}

local ClassHides = {
	["DRUID"] = {["Armor"] = {true,true,false,false},["WeaponsMeele"] = {true,true,true,true,false,true,false,false,false},["WeaponsMeeleTwoHand"] = {true,false,false},["WeaponsRanged"] = {false,false,false,false,false},["Relics"] = {true,false,false,false},["Other"] = {true,true,true,true}},
	["MAGE"] = {["Armor"] = {true,false,false,false},["WeaponsMeele"] = {true,true,false,true,false,false,false,true,false},["WeaponsMeeleTwoHand"] = {false,false,false},["WeaponsRanged"] = {true,false,false,false,false},["Relics"] = {false,false,false,false},["Other"] = {true,true,true,true}},
	["PALADIN"] = {["Armor"] = {true,true,true,true},["WeaponsMeele"] = {true,false,true,false,true,true,true,true,false},["WeaponsMeeleTwoHand"] = {true,false,true},["WeaponsRanged"] = {false,false,false,false,false},["Relics"] = {false,false,true,false},["Other"] = {true,true,true,true}},
	["PRIEST"] = {["Armor"] = {true,false,false,false},["WeaponsMeele"] = {true,true,true,true,false,false,false,false,false},["WeaponsMeeleTwoHand"] = {false,false,false},["WeaponsRanged"] = {true,false,false,false,false},["Relics"] = {false,false,false,false},["Other"] = {true,true,true,true}},
	["ROGUE"] = {["Armor"] = {true,true,false,false},["WeaponsMeele"] = {true,true,true,false,true,false,false,true,true},["WeaponsMeeleTwoHand"] = {false,false,false},["WeaponsRanged"] = {false,true,true,true,true},["Relics"] = {false,false,false,false},["Other"] = {true,true,true,true}},
	["HUNTER"] = {["Armor"] = {false,true,true,false},["WeaponsMeele"] = {false,true,false,true,true,true,false,true,true},["WeaponsMeeleTwoHand"] = {false,true,true},["WeaponsRanged"] = {false,true,true,true,false},["Relics"] = {false,false,false,false},["Other"] = {true,true,true,true}},
	["SHAMAN"] = {["Armor"] = {true,true,true,false},["WeaponsMeele"] = {true,true,true,true,true,false,true,false,true},["WeaponsMeeleTwoHand"] = {true,true,false},["WeaponsRanged"] = {false,false,false,false,false},["Relics"] = {false,true,false,false},["Other"] = {true,true,true,true}},
	["WARLOCK"] = {["Armor"] = {true,false,false,false},["WeaponsMeele"] = {true,true,false,true,false,false,false,true,false},["WeaponsMeeleTwoHand"] = {false,false,false},["WeaponsRanged"] = {true,false,false,false,false},["Relics"] = {false,false,false,false},["Other"] = {true,true,true,true}},
	["WARRIOR"] = {["Armor"] = {true,true,true,true},["WeaponsMeele"] = {true,true,true,true,true,true,true,true,true},["WeaponsMeeleTwoHand"] = {true,true,true},["WeaponsRanged"] = {false,true,true,true,true},["Relics"] = {false,false,false,false},["Other"] = {true,true,true,true}},
	["DEATHKNIGHT"] = {["Armor"] = {true,true,true,true},["WeaponsMeele"] = {true,false,true,false,true,true,false,true,false},["WeaponsMeeleTwoHand"] = {true,false,true},["WeaponsRanged"] = {false,false,false,false,false},["Relics"] = {false,false,false,true},["Other"] = {true,true,true,true}}
}

-- **********************************************************************
-- ItemFilter:
--	AtlasLoot_HideNoUsableItems()
--	AtlasLoot_FilterEnableButton()
-- **********************************************************************

AtlasLoot_Data["FilterList"] = {
};

function AtlasLoot_Testabc()
		print(BabbleInventory["Two-Hand"])
end	
	
	
function AtlasLoot_HideNoUsableItems()
	local dataID = AtlasLootItemsFrame.refreshOri[1] 
	local dataSource = AtlasLootItemsFrame.refreshOri[2] 
	local boss = AtlasLootItemsFrame.refreshOri[3] 
	local pFrame = AtlasLootItemsFrame.refreshOri[4] 	
	local tablebase = AtlasLoot_Data[dataID]
	if not tablebase or dataID == "WishList" or dataID == "SearchResult" or dataSource == "AtlasLootCrafting" then return end
	local itemCount = 0
	local countAll = 1
	local count = 0
	local leatherworking = GetSpellInfo(2108)

	AtlasLoot_Data["FilterList"] = {}
	for i=1,30 do
		local info = getglobal("AtlasLootItem_"..i.."_Extra"):GetText()
		if getglobal("AtlasLootItem_"..i):IsShown() then
			local xgo = true
			local countOld = count
			itemCount = itemCount + 1
			countAll = countAll + count
			count = 0
			local xitemID = getglobal("AtlasLootItem_"..i).itemID
			local xspellitemID = getglobal("AtlasLootItem_"..i).spellitemID
			local xitemTexture = tablebase[itemCount][3]
			local xitemExtraText = AtlasLoot_FixText(tablebase[itemCount][5])
			local xitemExtraTextSave = xitemExtraText
			-- remove the "-"
			xitemExtraText = gsub(xitemExtraText, "-", "") 
			local xitemNameText = getglobal("AtlasLootItem_"..i.."_Name"):GetText()
			
			if xitemExtraText and xitemExtraText ~= "" then
				for k = 1,#FilterSort do
					k = FilterSort[k]
					if type(FilterTable[k]) == "table" then
						for i,j in pairs(FilterTable[k]) do
							local Slotname = ""
							-- Bugfix with Sigils
							if j == "Sigils" then
								Slotname = AL["Sigil"]
							else
								Slotname = BabbleInventory[j]
							end

							if (k ~= "WeaponsMeeleTwoHand" and not strfind(xitemExtraText, BabbleInventory["Two-Hand"]) and strfind(xitemExtraText, Slotname) and AtlasLootFilterDB[k][j] == false) then
								xgo = false
								-- German fix
								if j == "Shield" and not strfind(xitemExtraText, BabbleInventory["Held in Off-Hand"]) and not strfind(xitemExtraText, BabbleInventory["Off Hand"]) then
									xgo = false
								elseif j == "Shield" and strfind(xitemExtraText, BabbleInventory["Held in Off-Hand"]) and AtlasLootFilterDB["WeaponsMeele"]["Held in Off-Hand"] == true then
									xgo = true
								end
							elseif k == "WeaponsMeeleTwoHand" and strfind(xitemExtraText, BabbleInventory["Two-Hand"]) and strfind(xitemExtraText, Slotname) and AtlasLootFilterDB[k][j] == false then
								xgo = false
							-- Fix bug with Leatherworking Patterns
							elseif strfind(xitemExtraText, leatherworking) then
								xgo = true
							end
						end
					end
				end
			end
			
			-- Sort the items
			if xgo == true then
				if i==16 and countOld > 0 then
					AtlasLoot_Data["FilterList"][16] = { 16, xitemID, xitemTexture, xitemNameText, xitemExtraTextSave}	
					countAll = 16
				elseif i==16 and xitemExtraText and strfind(xitemExtraText, AL["Token"]) then
					AtlasLoot_Data["FilterList"][16] = { 16, xitemID, xitemTexture, xitemNameText, xitemExtraTextSave}	
					countAll = 16
				elseif countAll < 16 and xitemNameText and strfind(xitemNameText, AL["Hard Mode"]) then
					AtlasLoot_Data["FilterList"][16] = { 16, xitemID, xitemTexture, xitemNameText, xitemExtraTextSave}	
					countAll = 16
				elseif i==16 and xitemTexture == "INV_Box_01" then
					AtlasLoot_Data["FilterList"][16] = { 16, xitemID, xitemTexture, xitemNameText, xitemExtraTextSave}	
					countAll = 16
				else
					AtlasLoot_Data["FilterList"][countAll] = { countAll, xitemID, xitemTexture, xitemNameText, xitemExtraTextSave}					
				end
				
				if tablebase[itemCount][6] and countAll==16 then
					AtlasLoot_Data["FilterList"][16][6] = tablebase[itemCount][6]
				elseif tablebase[itemCount][6] and countAll~=16 then
					AtlasLoot_Data["FilterList"][countAll][6] = tablebase[itemCount][6]
				end
				if tablebase[itemCount][7] and countAll==16 then
					AtlasLoot_Data["FilterList"][16][7] = tablebase[itemCount][7]
				elseif tablebase[itemCount][7] and countAll~=16 then
					AtlasLoot_Data["FilterList"][countAll][7] = tablebase[itemCount][7]
				end
				if tablebase[itemCount][8] and countAll==16 then
					AtlasLoot_Data["FilterList"][16][8] = tablebase[itemCount][8]
				elseif tablebase[itemCount][8] and countAll~=16 then
					AtlasLoot_Data["FilterList"][countAll][8] = tablebase[itemCount][8]
				end

				countAll = countAll + 1
				count = 0
			end
		else
			count = count + 1
		end		
	end

	-- Set the Next, Prev and Back button.
	if tablebase.Next then
		AtlasLoot_Data["FilterList"].Next = tablebase.Next
	end
	if tablebase.Prev then
		AtlasLoot_Data["FilterList"].Prev = tablebase.Prev
	end
	if tablebase.Back then
		AtlasLoot_Data["FilterList"].Back = tablebase.Back
	end
	
	AtlasLoot_TableNames["FilterList"] = {AtlasLoot_TableNames[dataID][1],AtlasLoot_TableNames[dataID][2]};
	AtlasLoot_ShowItemsFrame("FilterList", "AtlasLootFilter", "", AtlasLootItemsFrame.refresh[4])
end

function AtlasLoot_FilterEnableButton()
	if ATLASLOOT_FILTER_ENABLE == true then
		ATLASLOOT_FILTER_ENABLE = false
		AtlasLoot_ShowItemsFrame(AtlasLootItemsFrame.refreshOri[1], AtlasLootItemsFrame.refreshOri[2], AtlasLootItemsFrame.refreshOri[3], AtlasLootItemsFrame.refreshOri[4])
	else
		ATLASLOOT_FILTER_ENABLE = true
		AtlasLoot_HideNoUsableItems()
	end
end

-- **********************************************************************
-- Options:
--	AtlasLoot_HideNoUsableItems()
--	<local> CreateCheckButton(parrent, text, num)
--	AtlasLoote_CreateFilterOptions()
-- **********************************************************************
local ypos = -40
local xpos = 0
local linecount = 1
local lastframewidht,lastframeheight = 0,0

local function CreateCheckButton(parrent, text, num)
	local framewidht = InterfaceOptionsFramePanelContainer:GetWidth()
	local Check = CreateFrame("CheckButton", "AtlasLootOptionsCheck"..text..num, parrent, "OptionsCheckButtonTemplate")
		Check:SetPoint("LEFT", parrent, "TOPLEFT", xpos, ypos)
		Check:SetWidth(25)
		Check:SetHeight(25)
		Check:SetScript("OnShow", function()
			getglobal(this:GetName().."Text"):SetText(BabbleInventory[text]);
			if AtlasLootFilterDB[num][text] then
				this:SetChecked(1);
			else
				this:SetChecked(nil);
			end
		end)
		Check:SetScript("OnClick", function()
			if AtlasLootFilterDB[num][text] then
				AtlasLootFilterDB[num][text] = false;
			else
				AtlasLootFilterDB[num][text] = true;
			end
		end)
			
	if xpos == framewidht/2 then
		xpos = 0
		ypos = ypos - 20
		linecount = 1
	elseif xpos == 0 then
		xpos = framewidht/2
		linecount = 2
	end
end

local function CreateCat(parrent, text)
	if not AtlasLootFilterDB[text] then AtlasLootFilterDB[text] = {} end
	if linecount == 2 then
		ypos = ypos - 10
	else
		ypos = ypos + 10
	end
	local Text = parrent:CreateFontString("AtlasLoot"..text,"OVERLAY","GameFontNormal")
		Text:SetPoint("TOPLEFT", parrent, "TOPLEFT", xpos, ypos)
		Text:SetText(FilterTableNames[text]);
		Text:SetHeight(20)
		Text:SetTextColor(1.0, 1.0, 1.0, 1.0);
		
	ypos = ypos - 30
		
	for i,j in pairs(FilterTable[text]) do
		if AtlasLootFilterDB[text][j] ~= true and AtlasLootFilterDB[text][j] ~= false then AtlasLootFilterDB[text][j] = true end
		CreateCheckButton(parrent, j, text)
	end
	
	xpos = 0
	ypos = ypos - 10
end

function AtlasLoot_CreateFilterOptions()
	if OptionsLoadet then return end
	local FilterOptionsFrame = CreateFrame("FRAME", nil)
		FilterOptionsFrame.name = AL["Filter"];
		FilterOptionsFrame.parent = AL["AtlasLoot"];
		
	local framewidht = InterfaceOptionsFramePanelContainer:GetWidth()
	local panel3 = CreateFrame("ScrollFrame", "AtlasLootFilterOptionsScrollFrame", FilterOptionsFrame, "UIPanelScrollFrameTemplate")
	local scc = CreateFrame("Frame", "AtlasLootFilterOptionsScrollInhalt", panel3)
		panel3:SetScrollChild(scc)
		panel3:SetPoint("TOPLEFT", FilterOptionsFrame, "TOPLEFT", 10, -10)
		scc:SetPoint("TOPLEFT", panel3, "TOPLEFT", 0, 0)
		panel3:SetWidth(framewidht-45)  
		panel3:SetHeight(410) 
		scc:SetWidth(framewidht-45)  
		scc:SetHeight(410)  
		panel3:SetHorizontalScroll(-50)
		panel3:SetVerticalScroll(50)
		panel3:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }})
		panel3:SetScript("OnVerticalScroll", function()  end)
		panel3:EnableMouse(true)
		panel3:SetVerticalScroll(0)
		panel3:SetHorizontalScroll(0)
		panel3:SetScript("OnUpdate", function()
			local xframewidht = InterfaceOptionsFramePanelContainer:GetWidth()
			local xframeheight = InterfaceOptionsFramePanelContainer:GetHeight()
			if xframewidht ~= lastframewidht or xframeheight ~= lastframeheight then
				panel3:SetWidth(xframewidht-45)  
				scc:SetWidth(xframewidht-45)  
				panel3:SetHeight(xframeheight-20) 
				scc:SetHeight(xframeheight-20) 
			end
		end)
		
    local FilterDisableButton = CreateFrame("BUTTON", nil, scc, "UIPanelButtonTemplate")
        FilterDisableButton:SetHeight(20)
		FilterDisableButton:SetWidth(150)  
		FilterDisableButton:SetPoint("TOPLEFT", scc, "TOPLEFT",0,-5)
		FilterDisableButton:SetText(AL["Select All Loot"])
		FilterDisableButton:SetWidth(FilterDisableButton:GetTextWidth()+20)
        FilterDisableButton:SetScript("OnClick", function()
            for k,v in pairs(FilterTable) do
				if type(v) == "table" then
					for i,j in pairs(FilterTable[k]) do
						AtlasLootFilterDB[k][j] = true
					end
				end
			end					
			scc:Hide()
			scc:Show()
		end)
    
    local locClass,playerClass = UnitClass("player");
	local ClassFilterLoadButton = CreateFrame("BUTTON", nil, scc, "UIPanelButtonTemplate")
		ClassFilterLoadButton:SetHeight(20)
		ClassFilterLoadButton:SetWidth(150)  
		ClassFilterLoadButton:SetPoint("TOPRIGHT", scc, "TOPRIGHT",0,-5)
		ClassFilterLoadButton:SetText(AL["Apply Filter:"].." "..locClass)
		ClassFilterLoadButton:SetWidth(ClassFilterLoadButton:GetTextWidth()+20)
		ClassFilterLoadButton:SetScript("OnClick", function()
			for k,v in pairs(FilterTable) do
				if type(v) == "table" then
					for i,j in pairs(FilterTable[k]) do
						if ClassHides[playerClass][k][i] == false then
							AtlasLootFilterDB[k][j] = false
						else
							AtlasLootFilterDB[k][j] = true
						end
					end
				end
			end					
			scc:Hide()
			scc:Show()
		end)
        
    
	
	CreateCat(scc, "Armor")
	CreateCat(scc, "WeaponsMeele")
	CreateCat(scc, "WeaponsMeeleTwoHand")
	CreateCat(scc, "WeaponsRanged")
	CreateCat(scc, "Relics")
	CreateCat(scc, "Other")
			
	InterfaceOptions_AddCategory(FilterOptionsFrame)
	OptionsLoadet = true
end
