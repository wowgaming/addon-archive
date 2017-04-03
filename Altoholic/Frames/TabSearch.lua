local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local RED		= "|cFFFF0000"

local view
local highlightIndex

addon.Tabs.Search = {}

local ns = addon.Tabs.Search		-- ns = namespace

local function BuildView()
	view = view or {}
	wipe(view)
	
	local itemClasses =  { GetAuctionItemClasses() };
	local classNum = 1
	for _, itemClass in pairs(itemClasses) do
		table.insert(view, { name = itemClass, isCollapsed = true } )
		table.insert(view, L["Any"] )
		
		local itemSubClasses =  { GetAuctionItemSubClasses(classNum) };
		for _, itemSubClass in pairs(itemSubClasses) do
			table.insert(view, itemSubClass )
		end
		
		classNum = classNum + 1
	end
end

local function Header_OnClick(frame)
	local header = view[frame.itemTypeIndex]
	header.isCollapsed = not header.isCollapsed
	
	-- if header.isCollapsed == true then
		-- header.isCollapsed = false
	-- else
		-- header.isCollapsed = true
	-- end
	ns:Update()
end

local function Item_OnClick(frame)
	local itemType = frame.itemTypeIndex
	local itemSubType = frame.itemSubTypeIndex

	highlightIndex = itemSubType
	ns:Update()
	
	-- around 5-7 ms on the current realm, 25-40 ms in the loot tables
	if view[itemSubType] == L["Any"] then
		addon.Search:FindItem(view[itemType].name)
	else
		addon.Search:FindItem(view[itemType].name, view[itemSubType])
	end
end

function ns:Update()
	if not view then
		BuildView()
	end
	
	local VisibleLines = 15

	local itemTypeIndex				-- index of the item type in the menu table
	local itemTypeCacheIndex		-- index of the item type in the cache table
	local MenuCache = {}
	
	for k, v in pairs (view) do		-- rebuild the cache
		if type(v) == "table" then		-- header
			itemTypeIndex = k
			table.insert(MenuCache, { linetype=1, nameIndex=k } )
			itemTypeCacheIndex = #MenuCache
		else
			if view[itemTypeIndex].isCollapsed == false then
				table.insert(MenuCache, { linetype=2, nameIndex=k, parentIndex=itemTypeIndex } )
				
				if (highlightIndex) and (highlightIndex == k) then
					MenuCache[#MenuCache].needsHighlight = true
					MenuCache[itemTypeCacheIndex].needsHighlight = true
				end
			end
		end
	end
	
	local buttonWidth = 156
	if #MenuCache > 15 then
		buttonWidth = 136
	end
	
	local offset = FauxScrollFrame_GetOffset( _G[ "AltoholicSearchMenuScrollFrame" ] );
	local itemButtom = "AltoholicTabSearchMenuItem"
	for i=1, VisibleLines do
		local line = i + offset
		
		if line > #MenuCache then
			_G[itemButtom..i]:Hide()
		else
			local p = MenuCache[line]
			
			_G[itemButtom..i]:SetWidth(buttonWidth)
			_G[itemButtom..i.."NormalText"]:SetWidth(buttonWidth - 21)
			if p.needsHighlight then
				_G[itemButtom..i]:LockHighlight()
			else
				_G[itemButtom..i]:UnlockHighlight()
			end			
			
			if p.linetype == 1 then
				_G[itemButtom..i.."NormalText"]:SetText(WHITE .. view[p.nameIndex].name)
				_G[itemButtom..i]:SetScript("OnClick", Header_OnClick)
				_G[itemButtom..i].itemTypeIndex = p.nameIndex
			elseif p.linetype == 2 then
				_G[itemButtom..i.."NormalText"]:SetText("|cFFBBFFBB   " .. view[p.nameIndex])
				_G[itemButtom..i]:SetScript("OnClick", Item_OnClick)
				_G[itemButtom..i].itemTypeIndex = p.parentIndex
				_G[itemButtom..i].itemSubTypeIndex = p.nameIndex
			end

			_G[itemButtom..i]:Show()
		end
	end
	
	FauxScrollFrame_Update( _G[ "AltoholicSearchMenuScrollFrame" ], #MenuCache, VisibleLines, 20);
end

function ns:Reset()
	AltoholicFrame_SearchEditBox:SetText("")
	AltoholicTabSearch_MinLevel:SetText("")
	AltoholicTabSearch_MaxLevel:SetText("")
	AltoholicTabSearchStatus:SetText("")				-- .. the search results
	AltoholicFrameSearch:Hide()
	addon.Search:ClearResults()
	collectgarbage()
	
	if view then
		for k, v in pairs(view) do			-- rebuild the cache
			if type(v) == "table" then		-- header
				v.isCollapsed = true
			end
		end
	end
	highlightIndex = nil
	
	for i = 1, 8 do 
		_G[ "AltoholicTabSearch_Sort"..i ]:Hide()
		_G[ "AltoholicTabSearch_Sort"..i ].ascendingSort = nil
	end
	ns:Update()
end

function ns:DropDownRarity_Initialize()
	local info = UIDropDownMenu_CreateInfo(); 

	for i = 0, 6 do		-- Quality: 0 = poor .. 5 = legendary
		info.text = ITEM_QUALITY_COLORS[i].hex .. _G["ITEM_QUALITY"..i.."_DESC"]
		info.value = i
		info.func = function(self)	
			UIDropDownMenu_SetSelectedValue(AltoholicTabSearch_SelectRarity, self.value);
		end
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end 

function ns:DropDownSlot_Initialize()
	local function SetSearchSlot(self) 
		UIDropDownMenu_SetSelectedValue(AltoholicTabSearch_SelectSlot, self.value);
	end
	
	local info = UIDropDownMenu_CreateInfo(); 
	info.text = L["Any"]
	info.value = 0
	info.func = SetSearchSlot
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 	
	
	for i = 1, 18 do
		info.text = addon.Equipment:GetSlotName(i)
		info.value = i
		info.func = SetSearchSlot
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end 

function ns:DropDownLocation_Initialize()
	local info = UIDropDownMenu_CreateInfo();
	local text = {
		L["This character"],
		format("%s %s(%s)", L["This realm"], GREEN, L["This faction"]),
		format("%s %s(%s)", L["This realm"], GREEN, L["Both factions"]),
		L["All realms"],
		L["All accounts"],
		L["Loot tables"]
	}
	
	for i = 1, #text do
		info.text = text[i]
		info.value = i
		info.func = function(self) 
				UIDropDownMenu_SetSelectedValue(AltoholicTabSearch_SelectLocation, self.value)
			end
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 		
	end
end

function ns:SetMode(mode)

	local Columns = addon.Tabs.Columns
	Columns:Init()
	
	-- sets the search mode, and prepares the frame accordingly (search update callback, column sizes, headers, etc..)
	if mode == "realm" then
		addon.Search:SetUpdateHandler("Realm_Update")
		
		Columns:Add(L["Item / Location"], 240, function(self) addon.Search:SortResults(self, "name") end)
		Columns:Add(L["Character"], 160, function(self) addon.Search:SortResults(self, "char") end)
		Columns:Add(L["Realm"], 150, function(self) addon.Search:SortResults(self, "realm") end)

		AltoholicTabSearch_Sort2:SetPoint("LEFT", AltoholicTabSearch_Sort1, "RIGHT", 5, 0)
		AltoholicTabSearch_Sort3:SetPoint("LEFT", AltoholicTabSearch_Sort2, "RIGHT", 5, 0)
		
		for i=1, 7 do
			_G[ "AltoholicFrameSearchEntry"..i.."Name" ]:SetWidth(240)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetWidth(160)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Name" ], "RIGHT", 5, 0)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetWidth(150)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Stat1" ], "RIGHT", 5, 0)
			
			for j=3, 6 do
				_G[ "AltoholicFrameSearchEntry"..i.."Stat"..j ]:Hide()
			end
			_G[ "AltoholicFrameSearchEntry"..i.."ILvl" ]:Hide()
			
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnEnter", nil)
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnLeave", nil)
		end
				
	elseif mode == "loots" then
		addon.Search:SetUpdateHandler("Loots_Update")
		
		Columns:Add(L["Item / Location"], 240, function(self) addon.Search:SortResults(self, "item") end)
		Columns:Add(L["Source"], 160, function(self) addon.Search:SortResults(self, "bossName") end)
		Columns:Add(L["Item Level"], 150, function(self) addon.Search:SortResults(self, "iLvl") end)
		
		AltoholicTabSearch_Sort2:SetPoint("LEFT", AltoholicTabSearch_Sort1, "RIGHT", 5, 0)
		AltoholicTabSearch_Sort3:SetPoint("LEFT", AltoholicTabSearch_Sort2, "RIGHT", 5, 0)
		
		for i=1, 7 do
			_G[ "AltoholicFrameSearchEntry"..i.."Name" ]:SetWidth(240)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetWidth(160)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Name" ], "RIGHT", 5, 0)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetWidth(150)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Stat1" ], "RIGHT", 5, 0)
			
			for j=3, 6 do
				_G[ "AltoholicFrameSearchEntry"..i.."Stat"..j ]:Hide()
			end
			_G[ "AltoholicFrameSearchEntry"..i.."ILvl" ]:Hide()
			
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnEnter", nil)
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnLeave", nil)
		end
		
	elseif mode == "upgrade" then
		addon.Search:SetUpdateHandler("Upgrade_Update")

		Columns:Add(L["Item / Location"], 200, function(self) addon.Search:SortResults(self, "item") end)
		
		for i=1, 6 do 
			local text = select(i, strsplit("|", addon.Equipment.FormatStats[addon.Search:GetClass()]))
			
			if text then
				Columns:Add(string.sub(text, 1, 3), 50, function(self)
					addon.Search:SortResults(self, "stat") -- use a getID to know which stat
				end)
			else
				Columns:Add(nil)
			end
		end
		
		AltoholicTabSearch_Sort2:SetPoint("LEFT", AltoholicTabSearch_Sort1, "RIGHT", 0, 0)
		AltoholicTabSearch_Sort3:SetPoint("LEFT", AltoholicTabSearch_Sort2, "RIGHT", 0, 0)

		Columns:Add("iLvl", 50, function(self) addon.Search:SortResults(self, "iLvl") end)
		
		for i=1, 7 do
			_G[ "AltoholicFrameSearchEntry"..i.."Name" ]:SetWidth(190)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetWidth(50)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat1" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Name" ], "RIGHT", 0, 0)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetWidth(50)
			_G[ "AltoholicFrameSearchEntry"..i.."Stat2" ]:SetPoint("LEFT", _G[ "AltoholicFrameSearchEntry"..i.."Stat1" ], "RIGHT", 0, 0)
			
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnEnter", function(self) 
				ns:TooltipStats(self) 
			end)
			_G[ "AltoholicFrameSearchEntry"..i ]:SetScript("OnLeave", function(self) 
				AltoTooltip:Hide()
			end)
		end
	end
end

function ns:TooltipStats(frame)
	AltoTooltip:ClearLines();
	AltoTooltip:SetOwner(frame, "ANCHOR_RIGHT");
	
	AltoTooltip:AddLine(STATS_LABEL)
	AltoTooltip:AddLine(" ");
	
	local s = addon.Search:GetResult(frame:GetID())

	for i=1, 6 do
		local text = select(i, strsplit("|", addon.Equipment.FormatStats[addon.Search:GetClass()]))
		if text then 
			local color
			local diff = select(2, strsplit("|", s["stat"..i]))
			diff = tonumber(diff)

			if diff < 0 then
				color = RED
			elseif diff > 0 then 
				color = GREEN
				diff = "+" .. diff
			else
				color = WHITE
			end
			AltoTooltip:AddLine(format("%s%s %s", color, diff, text))
		end
	end
	AltoTooltip:Show()
end
