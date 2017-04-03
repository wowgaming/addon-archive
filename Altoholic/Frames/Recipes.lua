local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()

local WHITE				= "|cFFFFFFFF"
local TEAL				= "|cFF00FF9A"
local YELLOW			= "|cFFFFFF00"
local GREEN				= "|cFF00FF00"
local RECIPE_GREY		= "|cFF808080"
local RECIPE_GREEN	= "|cFF40C040"
local RECIPE_ORANGE	= "|cFFFF8040"

local view

local RecipeColors = { RECIPE_ORANGE, YELLOW, RECIPE_GREEN, RECIPE_GREY }
local RecipeColorNames = { BI["Orange"], BI["Yellow"], BI["Green"], L["Grey"] }

local ns = addon.TradeSkills.Recipes		-- ns = namespace

local function GetCurrentProfessionTable()
	local character = addon.Tabs.Characters:GetCurrent()
	return DataStore:GetProfession(character, addon.TradeSkills.CurrentProfession)		-- current profession
end

local function GetLinkByLine(index)
	local profession = GetCurrentProfessionTable()
	local _, _, spellID = DataStore:GetCraftLineInfo(profession, index)
	
	return ns:GetLink(spellID, addon.TradeSkills.CurrentProfession)
end

-- drop down menus
local function DDM_AddButton(text, value, func)
	local info = UIDropDownMenu_CreateInfo()
	
	info.text = text
	info.value = value
	info.func = func
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
end

local function OnColorChange(self)
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectColor, self.value);
	ns:BuildView()
	ns:Update()
end

function ns:DropDownColor_Initialize()
	local ts = Altoholic.TradeSkills
	if not ts.CurrentProfession then
		DDM_AddButton(L["Any"], 0, OnColorChange)
		return
	end
	
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local profession = DataStore:GetProfession(character, ts.CurrentProfession)
	local orange, yellow, green, grey = DataStore:GetNumRecipesByColor(profession)
	
	DDM_AddButton(format("%s %s(%s)", L["Any"], GREEN, orange+yellow+green+grey ), 0, OnColorChange)
	DDM_AddButton(format("%s %s(%s)", RecipeColors[1] .. RecipeColorNames[1], GREEN, orange ), 1, OnColorChange)
	DDM_AddButton(format("%s %s(%s)", RecipeColors[2] .. RecipeColorNames[2], GREEN, yellow ), 2, OnColorChange)
	DDM_AddButton(format("%s %s(%s)", RecipeColors[3] .. RecipeColorNames[3], GREEN, green ), 3, OnColorChange)
	DDM_AddButton(format("%s %s(%s)", RecipeColors[4] .. RecipeColorNames[4], GREEN, grey ), 4, OnColorChange)
end

local function OnSubClassChange(self)
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectSubclass, self.value);
	ns:BuildView()
	ns:Update()
end

function ns:DropDownSubclass_Initialize()
	DDM_AddButton(ALL_SUBCLASSES, ALL_SUBCLASSES, OnSubClassChange)
	
	local ts = Altoholic.TradeSkills
	if not ts.CurrentProfession then return end
	
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local profession = DataStore:GetProfession(character, ts.CurrentProfession)
		
	for index = 1, DataStore:GetNumCraftLines(profession) do
		local isHeader, _, name = DataStore:GetCraftLineInfo(profession, index)
		
		if isHeader then
			DDM_AddButton(name, name, OnSubClassChange)
		end
	end
end

local function OnInvSlotChange(self)
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectInvSlot, self.value);
	ns:BuildView()
	ns:Update()
end

function ns:DropDownInvSlot_Initialize()
	DDM_AddButton(ALL_INVENTORY_SLOTS, ALL_INVENTORY_SLOTS, OnInvSlotChange)

	local ts = Altoholic.TradeSkills
	if not ts.CurrentProfession then return end
	
	local invSlots = {}
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local profession = DataStore:GetProfession(character, ts.CurrentProfession)
		
	for index = 1, DataStore:GetNumCraftLines(profession) do
		local isHeader, _, spellID = DataStore:GetCraftLineInfo(profession, index)
		
		if not isHeader then		-- NON header !!
			local itemID = DataStore:GetCraftInfo(spellID)
			
			if itemID then
				local _, _, _, _, _, itemType, _, _, itemEquipLoc = GetItemInfo(itemID)
				
				if itemEquipLoc and strlen(itemEquipLoc) > 0 then
					local slot = Altoholic.Equipment:GetInventoryTypeName(itemEquipLoc)
					if slot then
						invSlots[slot] = itemEquipLoc
					end
				end
			end
		end
	end
	
	for k, v in pairs(invSlots) do		-- add all the slots found
		DDM_AddButton(k, v, OnInvSlotChange)
	end

	--NONEQUIPSLOT = "Created Items"; -- Items created by enchanting
	DDM_AddButton(NONEQUIPSLOT, NONEQUIPSLOT, OnInvSlotChange)
end


function ns:BuildView()
	view = view or {}
	wipe(view)
		
	local ts = addon.TradeSkills
	local character = addon.Tabs.Characters:GetCurrent()
	local profession = DataStore:GetProfession(character, ts.CurrentProfession)
	if not profession then return end
	
	local selectedColor = UIDropDownMenu_GetSelectedValue(AltoholicFrameRecipesInfo_SelectColor)
	local selectedClass = UIDropDownMenu_GetSelectedValue(AltoholicFrameRecipesInfo_SelectSubclass)
	local selectedSlot = UIDropDownMenu_GetSelectedValue(AltoholicFrameRecipesInfo_SelectInvSlot)
	
	local hideCategory		-- hide or show the current header ?
	local hideLine			-- hide or show the current line ?
	
	for index = 1, DataStore:GetNumCraftLines(profession) do
		local isHeader, color, info = DataStore:GetCraftLineInfo(profession, index)

		if isHeader then
			hideCategory = false
			if selectedClass ~= ALL_SUBCLASSES and selectedClass ~= info then
				hideCategory = true	-- hide if a specific subclass is selected AND we're not on it
			end

			if not hideCategory then
				table.insert(view, { id = index, isCollapsed = false } )
			end
		else		-- data line
			if not hideCategory then
				hideLine = false
				if selectedColor ~= 0 and selectedColor ~= color then
					hideLine = true
				elseif selectedSlot ~= ALL_INVENTORY_SLOTS then
					if info then	-- on a data line, info contains the itemID and is numeric
						local itemID = DataStore:GetCraftInfo(info)
						if itemID then
							local _, _, _, _, _, itemType, _, _, itemEquipLoc = GetItemInfo(itemID)

							if itemType == BI["Armor"] or itemType == BI["Weapon"] then
								if itemEquipLoc and strlen(itemEquipLoc) > 0 then
									if selectedSlot ~= itemEquipLoc then
										hideLine = true
									end
								end
							else	-- not a weapon or armor ? then test if it's a generic "Created item"
								if selectedSlot ~= NONEQUIPSLOT then
									hideLine = true
								end
							end
						else		-- enchants, like socket bracker, might not have an item id, so hide the line
							hideLine = true
						end
					else
						if selectedSlot ~= NONEQUIPSLOT then
							hideLine = true
						end
					end
				end
				
				if not hideLine then
					table.insert(view, index)
				end
			end
		end
	end

	-- going from last to first, if two headers follow one another, it means that the smallest index is an empty category, so delete it
	for i = (#view - 1), 1, -1 do
		if type(view[i]) == "table" and type(view[i+1]) == "table" then
			table.remove(view, i)
		end
	end
	
	-- to avoid testing for exceptions in the previous loop, deal with the only shortcoming here (if the last entry is a table, it's an empty category, delete it)
	if type(view[#view]) == "table" then
		table.remove(view)
	end
end

function ns:Update()
	local currentProfession = addon.TradeSkills.CurrentProfession
	
	local VisibleLines = 14
	local frame = "AltoholicFrameRecipes"
	local entry = frame.."Entry"
	
	local character = addon.Tabs.Characters:GetCurrent()
	local profession = DataStore:GetProfession(character, currentProfession)
	
	AltoholicFrameRecipesInfo:Show()
	AltoholicTabCharactersStatus:SetText("")

	local curRank, maxRank = DataStore:GetSkillInfo(character, currentProfession)

	AltoholicFrameRecipesInfo_NumRecipes:SetText(
		format("%s" ..TEAL .. " %d/%d", currentProfession, curRank or 0, maxRank or 0 )
	)
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawGroup = true
	local i=1
	
	local isHeader
	local isCollapsed
	
	for index, s in pairs(view) do
		if type(s) == "table" then
			isHeader = true
			isCollapsed = s.isCollapsed
		else
			isHeader = nil
		end
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if isHeader then													-- then keep track of counters
				if isCollapsed == false then
					DrawGroup = true
				else
					DrawGroup = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawGroup then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if isHeader then
				if isCollapsed == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawGroup = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawGroup = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Craft"]:Hide()
				
				local _, _, name = DataStore:GetCraftLineInfo(profession, s.id)
				_G[entry..i.."RecipeLinkNormalText"]:SetText(TEAL .. name)
				_G[entry..i.."RecipeLink"]:SetID(0)
				_G[entry..i.."RecipeLink"]:SetPoint("TOPLEFT", 25, 0)

				for j=1, 8 do
					_G[ entry..i .. "Item" .. j ]:Hide()
				end
				
				_G[ entry..i ]:SetID(index)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
				
			elseif DrawGroup then
				_G[entry..i.."Collapse"]:Hide()

				local _, color, spellID = DataStore:GetCraftLineInfo(profession, s)
				local itemID, reagents = DataStore:GetCraftInfo(spellID)
				
				if itemID then
					Altoholic:SetItemButtonTexture(entry..i.."Craft", GetItemIcon(itemID), 18, 18);
					_G[entry..i.."Craft"]:SetID(itemID)
					_G[entry..i.."Craft"]:Show()
				else
					_G[entry..i.."Craft"]:Hide()
				end
				
				if spellID then
					_G[entry..i.."RecipeLinkNormalText"]:SetText(ns:GetLink(spellID, currentProfession, RecipeColors[color]))
				else
					-- this should NEVER happen, like NEVER-EVER-ER !!
					_G[entry..i.."RecipeLinkNormalText"]:SetText(L["N/A"])
				end
				_G[entry..i.."RecipeLink"]:SetID(s)
				_G[entry..i.."RecipeLink"]:SetPoint("TOPLEFT", 32, 0)

				local j = 1
				
				if reagents then
					-- "2996x2;2318x1;2320x1"
					for reagent in reagents:gmatch("([^;]+)") do
						local itemName = entry..i .. "Item" .. j;
						local reagentID, reagentCount = strsplit("x", reagent)
						reagentID = tonumber(reagentID)
						
						if reagentID then
							reagentCount = tonumber(reagentCount)
							
							_G[itemName]:SetID(reagentID)
							Altoholic:SetItemButtonTexture(itemName, GetItemIcon(reagentID), 18, 18);

							local itemCount = _G[itemName .. "Count"]
							itemCount:SetText(reagentCount);
							itemCount:Show();
						
							_G[ itemName ]:Show()
							j = j + 1
						else
							_G[ itemName ]:Hide()
						end				
					end
				end
				
				while j <= 8 do
					_G[ entry..i .. "Item" .. j ]:Hide()
					j = j + 1
				end
					
				_G[ entry..i ]:SetID(index)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			end
		end
	end 

	while i <= VisibleLines do
		_G[ entry..i ]:SetID(0)
		_G[ entry..i ]:Hide()
		i = i + 1
	end
	
	if VisibleCount == 0 then
		AltoholicTabCharactersStatus:SetText(format("%s: %s", currentProfession, L["No data"]))
	end
	
	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleCount, VisibleLines, 18);
end

function ns:GetLink(spellID, profession, color)
	local name = GetSpellInfo(spellID)
	color = color or "|cffffd000"
	return format("%s|Henchant:%s|h[%s: %s]|h|r", color, spellID, profession, name)
end

function ns:ResetDropDownMenus()
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectColor, 0);
	UIDropDownMenu_SetText(AltoholicFrameRecipesInfo_SelectColor, L["Any"])
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectSubclass, ALL_SUBCLASSES);
	UIDropDownMenu_SetText(AltoholicFrameRecipesInfo_SelectSubclass, ALL_SUBCLASSES)
	UIDropDownMenu_SetSelectedValue(AltoholicFrameRecipesInfo_SelectInvSlot, ALL_INVENTORY_SLOTS);
	UIDropDownMenu_SetText(AltoholicFrameRecipesInfo_SelectInvSlot, ALL_INVENTORY_SLOTS)
end

function ns:ToggleAll(frame)
	-- expand or collapse all sections of the currently displayed alt /tradeskill
	if not frame.isCollapsed then
		frame.isCollapsed = true
		frame:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	else
		frame.isCollapsed = nil
		frame:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
	end

	for _, s in pairs(view) do
		if type(s) == "table" then		-- it's a header
			s.isCollapsed = (frame.isCollapsed) or false
		end
	end
	
	ns:Update()
end

function ns:RecipeLink_OnEnter(frame)
	local id = frame:GetID()
	if id == 0 then return end

	local link = GetLinkByLine(id)
	
	if link then
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(frame, "ANCHOR_RIGHT");
		GameTooltip:SetHyperlink(link);
		GameTooltip:AddLine(" ",1,1,1);
		GameTooltip:Show();
	end
end

function ns:RecipeLink_OnClick(frame, button)
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then
			local id = frame:GetID()
			if id == 0 then return end

			local link = GetLinkByLine(id)
			if link then
				chat:Insert(link)
			end
		end
	end
end

function ns:Collapse_OnClick(frame, button)
	local id = frame:GetParent():GetID()
	if id ~= 0 then
		local s = view[id]
		if s.isCollapsed ~= nil then
			if s.isCollapsed == true then
				s.isCollapsed = false
			else
				s.isCollapsed = true
			end
		end
	end
	ns:Update()
end

function ns:Link_OnClick(frame, button)
	if ( button ~= "LeftButton" ) then
		return
	end
	
	if addon:GetCurrentRealm() ~= GetRealmName() then
		addon:Print(L["Cannot link another realm's tradeskill"])
		return
	end

	local character = addon.Tabs.Characters:GetCurrent()
	local profession = DataStore:GetProfession(character, addon.TradeSkills.CurrentProfession)
	local link = profession.FullLink

	if not link then
		addon:Print(L["Invalid tradeskill link"])
		return
	end
	
	local chat = ChatEdit_GetLastActiveWindow()
	if chat:IsShown() then
		chat:Insert(addon:GetCurrentCharacter() .. ": " .. link);
	end
end
