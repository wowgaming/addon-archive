local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local GREEN		= "|cFF00FF00"

local BAGSBANK					= 1
local BAGSBANK_ALLINONE		= 2
local BAGSONLY					= 3
local BAGSONLY_ALLINONE		= 4
local BANKONLY					= 5
local BANKONLY_ALLINONE		= 6

addon.Containers = {}

local ns = addon.Containers		-- ns = namespace

local containerViewLabels = {
	format("%s & %s", L["Bags"], L["Bank"]),
	format("%s & %s %s(%s)", L["Bags"], L["Bank"], GREEN, L["All-in-one"]),
	L["Bags"],
	format("%s %s(%s)", L["Bags"], GREEN, L["All-in-one"]),
	L["Bank"],
	format("%s %s(%s)", L["Bank"], GREEN, L["All-in-one"]),
}

local function OnContainerViewChange(self)
	local value = self.value
	
	UIDropDownMenu_SetSelectedValue(AltoholicFrameContainers_SelectContainerView, value);
	addon.Options:Set("lastContainerView", value)
	ns:SetView(value)
	ns:Update();
end

local function DropDownContainerView_Initialize() 
	local info = UIDropDownMenu_CreateInfo(); 
	
	for i = 1, #containerViewLabels do
		info.text = containerViewLabels[i]
		info.value = i
		info.func = OnContainerViewChange
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end

local function OnRarityChange(self)
	UIDropDownMenu_SetSelectedValue(AltoholicFrameContainers_SelectRarity, self.value);
	ns:Update();
end

local function DropDownRarity_Initialize() 
	local info = UIDropDownMenu_CreateInfo(); 
	
	info.text =  L["Any"]
	info.value = 0
	info.func = OnRarityChange
	info.checked = nil; 
	info.icon = nil; 
	UIDropDownMenu_AddButton(info, 1); 
	
	for i = 2, 6 do		-- Quality: 0 = poor .. 5 = legendary
		info.text = ITEM_QUALITY_COLORS[i].hex .. _G["ITEM_QUALITY"..i.."_DESC"]
		info.value = i
		info.func = OnRarityChange
		info.checked = nil; 
		info.icon = nil; 
		UIDropDownMenu_AddButton(info, 1); 
	end
end

local bagIndices

local function UpdateBagIndices(bag, size)
	-- the BagIndices table will be used by self:Containers_Update to determine which part of a bag should be displayed on a given line
	-- ex: [1] = bagID = 0, from 1, to 12
	-- ex: [2] = bagID = 0, from 13, to 16

	local lowerLimit = 1

	while size > 0 do					-- as long as there are slots to process ..
		table.insert(bagIndices, { bagID=bag, from=lowerLimit} )
	
		if size <= 12 then			-- no more lines ? leave
			return
		else
			size = size - 12			-- .. or adjust counters
			lowerLimit = lowerLimit + 12
		end
	end
end

local function UpdateSpread()
	local mode = UIDropDownMenu_GetSelectedValue(AltoholicFrameContainers_SelectContainerView)
	local rarity = UIDropDownMenu_GetSelectedValue(AltoholicFrameContainers_SelectRarity)
	local VisibleLines = 7
	local frame = "AltoholicFrameContainers"
	local entry = frame.."Entry"
	
	if #bagIndices == 0 then
		addon:ClearScrollFrame( _G[ frame.."ScrollFrame" ], entry, VisibleLines, 41)
		return
	end

	AltoholicTabCharactersStatus:SetText("")
	
	local character = Altoholic.Tabs.Characters:GetCurrent()
	local DS = DataStore
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	for i=1, VisibleLines do
		local line = i + offset
		
		if line <= #bagIndices then
		
			local containerID = bagIndices[line].bagID
			local container = DS:GetContainer(character, containerID)
			local containerIcon, _, containerSize = DS:GetContainerInfo(character, containerID)
			
			local itemName = entry..i .. "Item1";
			
			if bagIndices[line].from == 1 then		-- if this is the first line for this bag .. draw bag icon
				local itemButton = _G[itemName];	
				if containerIcon then
					Altoholic:SetItemButtonTexture(itemName, containerIcon);
				else		-- will be nill for bag 100
					Altoholic:SetItemButtonTexture(itemName, "Interface\\Icons\\INV_Box_03");
				end

				itemButton:SetID(containerID)

				itemButton:SetScript("OnEnter", function(self)
					local id = self:GetID()
					GameTooltip:SetOwner(self, "ANCHOR_LEFT");
					if id == -2 then
						GameTooltip:AddLine(KEYRING,1,1,1);
						GameTooltip:AddLine(L["32 Keys Max"],1,1,1);
					elseif id == 0 then
						GameTooltip:AddLine(BACKPACK_TOOLTIP,1,1,1);
						GameTooltip:AddLine(format(CONTAINER_SLOTS, 16, BAGSLOT),1,1,1);
						
					elseif id == 100 then
						GameTooltip:AddLine(L["Bank"],0.5,0.5,1);
						GameTooltip:AddLine(L["28 Slot"],1,1,1);
					else
						local character = Altoholic.Tabs.Characters:GetCurrent()
						local _, link = DS:GetContainerInfo(character, id)
						GameTooltip:SetHyperlink(link);
						if (id >= 5) and (id <= 11) then
							GameTooltip:AddLine(L["Bank bag"],0,1,0);
						end
					end
					GameTooltip:Show();
				end)
				_G[itemName .. "Count"]:Hide()
				
				_G[ itemName ]:Show()
			else
				_G[ itemName ]:Hide()
			end
			
			_G[ entry..i .. "Item2" ]:Hide()
			_G[ entry..i .. "Item2" ].id = nil
			_G[ entry..i .. "Item2" ].link = nil
			
			for j=3, 14 do
				local itemName = entry..i .. "Item" .. j;
				local itemButton = _G[itemName];
				local itemTexture = _G[itemName.."IconTexture"]
						
				Altoholic:CreateButtonBorder(itemButton)
				itemButton.border:Hide()
				itemTexture:SetDesaturated(0)
				
				local slotID = bagIndices[line].from - 3 + j
				local itemID, itemLink, itemCount = DS:GetSlotInfo(container, slotID)
				
				if (slotID <= containerSize) then 
					if itemID then
						Altoholic:SetItemButtonTexture(itemName, GetItemIcon(itemID));
						
						if rarity ~= 0 then
							local _, _, itemRarity = GetItemInfo(itemID)
							if itemRarity and itemRarity == rarity then
								local r, g, b = GetItemQualityColor(itemRarity)
								itemButton.border:SetVertexColor(r, g, b, 0.5)
								itemButton.border:Show()
							else
								itemTexture:SetDesaturated(1)
							end
						end
					else
						Altoholic:SetItemButtonTexture(itemName, "Interface\\PaperDoll\\UI-Backpack-EmptySlot");
					end
				
					itemButton.id = itemID
					itemButton.link = itemLink
					itemButton:SetScript("OnEnter", function(self) 
							Altoholic:Item_OnEnter(self)
						end)
					
					local countWidget = _G[itemName .. "Count"]
					if not itemCount or (itemCount < 2) then
						countWidget:Hide();
					else
						countWidget:SetText(itemCount);
						countWidget:Show();
					end
					
					local startTime, duration, isEnabled = DS:GetContainerCooldownInfo(container, slotID)
					
					itemButton.startTime = startTime
					itemButton.duration = duration
					
					CooldownFrame_SetTimer(_G[itemName .. "Cooldown"], startTime or 0, duration or 0, isEnabled)
				
					itemButton:Show()
				else
					_G[ itemName ]:Hide()
					itemButton.id = nil
					itemButton.link = nil
					itemButton.startTime = nil
					itemButton.duration = nil
				end
			end
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end
	
	if #bagIndices < VisibleLines then
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleLines, VisibleLines, 41);
	else
		FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], #bagIndices, VisibleLines, 41);
	end	
end	

local function UpdateAllInOne()
	local mode = UIDropDownMenu_GetSelectedValue(AltoholicFrameContainers_SelectContainerView)
	local rarity = UIDropDownMenu_GetSelectedValue(AltoholicFrameContainers_SelectRarity)
	local VisibleLines = 7
	local frame = "AltoholicFrameContainers"
	local entry = frame.."Entry"
	
	AltoholicTabCharactersStatus:SetText("")
	
	local character = Altoholic.Tabs.Characters:GetCurrent()

	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	
	local minSlotIndex = offset * 14
	local currentSlotIndex = 0		-- this indexes the non-empty slots
	local i = 1
	local j = 1
	
	local containerList = {}
	
	if mode ~= BANKONLY_ALLINONE then		-- if it's not a bank only view, add the normal bags
		table.insert(containerList, -2)
		for i = 0, 4 do
			table.insert(containerList, i)
		end
	end
	
	if mode ~= BAGSONLY_ALLINONE then		-- if it's not a bag only view, add bank bags
		for i = 5, 11 do
			table.insert(containerList, i)
		end
		table.insert(containerList, 100)
	end

	local DS = DataStore
	for _, containerID in pairs(containerList) do
		local container = DS:GetContainer(character, containerID)
		local _, _, containerSize = DS:GetContainerInfo(character, containerID)

		for slotID = 1, containerSize do
			local itemID, itemLink, itemCount = DS:GetSlotInfo(container, slotID)
			if itemID then
				currentSlotIndex = currentSlotIndex + 1
				if (currentSlotIndex > minSlotIndex) and (i <= VisibleLines) then
					local itemName = entry..i .. "Item" .. j;
					local itemButton = _G[itemName];
					local itemTexture = _G[itemName.."IconTexture"]
					
					Altoholic:CreateButtonBorder(itemButton)
					itemButton.border:Hide()
					
					Altoholic:SetItemButtonTexture(itemName, GetItemIcon(itemID));
					itemTexture:SetDesaturated(0)
					
					if rarity ~= 0 then
						local _, _, itemRarity = GetItemInfo(itemID)
						if itemRarity and itemRarity == rarity then
							local r, g, b = GetItemQualityColor(itemRarity)
							itemButton.border:SetVertexColor(r, g, b, 0.5)
							itemButton.border:Show()
						else
							itemTexture:SetDesaturated(1)
						end
					end
					
					itemButton.id = itemID
					itemButton.link = itemLink
					itemButton:SetScript("OnEnter", function(self) 
							Altoholic:Item_OnEnter(self)
						end)
				
					local countWidget = _G[itemName .. "Count"]
					if not itemCount or (itemCount < 2) then
						countWidget:Hide();
					else
						countWidget:SetText(itemCount);
						countWidget:Show();
					end
					
					local startTime, duration, isEnabled = DS:GetContainerCooldownInfo(container, slotID)
					
					itemButton.startTime = startTime
					itemButton.duration = duration
					
					CooldownFrame_SetTimer(_G[itemName .. "Cooldown"], startTime or 0, duration or 0, isEnabled)
			
					_G[ itemName ]:Show()
					
					j = j + 1
					if j > 14 then
						j = 1
						i = i + 1
					end
				end				
			end
		end
	end
		
	while i <= VisibleLines do
		while j <= 14 do
			_G[ entry..i .. "Item" .. j ]:Hide()
			_G[ entry..i .. "Item" .. j ].id = nil
			_G[ entry..i .. "Item" .. j ].link = nil
			_G[ entry..i .. "Item" .. j ].startTime = nil
			_G[ entry..i .. "Item" .. j ].duration = nil
			j = j + 1
		end
	
		j = 1
		i = i + 1
	end
	
	for i=1, VisibleLines do
		_G[ entry..i ]:Show()
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], ceil(currentSlotIndex / 14), VisibleLines, 41);
end

function ns:Init()
	local mode = addon.Options:Get("lastContainerView")
	mode = mode or 1
	
	local f = AltoholicFrameContainers_SelectContainerView
	UIDropDownMenu_SetSelectedValue(f, mode);
	UIDropDownMenu_SetText(f, containerViewLabels[mode])
	UIDropDownMenu_Initialize(f, DropDownContainerView_Initialize)
	
	f = AltoholicFrameContainers_SelectRarity
	UIDropDownMenu_SetSelectedValue(f, 0);
	UIDropDownMenu_SetText(f, L["Any"])
	UIDropDownMenu_Initialize(f, DropDownRarity_Initialize)
end

function ns:SetView(view)
	view = view or 1
	if mod(view, 2) ~= 0 then	-- not an all-in-one view
		ns.Update = UpdateSpread
		ns:UpdateCache()
		FauxScrollFrame_SetOffset( AltoholicFrameContainersScrollFrame, 0)
	else
		ns.Update = UpdateAllInOne
	end
end

function ns:UpdateCache()
	local mode = UIDropDownMenu_GetSelectedValue(AltoholicFrameContainers_SelectContainerView)
	local character = addon.Tabs.Characters:GetCurrent()
	
	bagIndices = bagIndices or {}
	wipe(bagIndices)
	
	local bagMin = 0
	local bagMax = 11
	
	-- bags : -2 (keyring) and 0 to 4
	-- bank: 5 to 11 and 100
	if mode == BAGSONLY then
		bagMax = 4			-- 0 to 4
	elseif mode == BANKONLY then
		bagMin = 5			-- 5 to 11
	end
	
	local DS = DataStore
	for bagID = bagMin, bagMax do
		if DS:GetContainer(character, bagID) then
			local _, _, size = DS:GetContainerInfo(character, bagID)
			UpdateBagIndices(bagID, size)
		end
	end
	
	if mode ~= BANKONLY then
		UpdateBagIndices(-2, 32)		-- KeyRing
	end
	
	if mode ~= BAGSONLY then
		if DS:GetContainer(character, 100) then 	-- if bank hasn't been visited yet, exit
			UpdateBagIndices(100, 28)
		end
	end
end

-- *** EVENT HANDLERS ***
function ns:OnBagUpdate(bag)
	addon:RefreshTooltip()

	if DataStore:IsMailBoxOpen() and AltoholicFrameMail:IsVisible() then	
		-- if a bag is updated while the mailbox is opened, this means an attachment has been taken.
		addon.Mail:BuildView()
		addon.Mail:Update()
	end
end
