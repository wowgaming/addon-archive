local easyLootLevels = {
	"Poor",
	"Common",
	"Uncommon",
	"Rare",
	"Epic",
	"Legendary",
	"Artifact",
	"Heirloom"
}

local panelName
local EasyLootDestroyItem = {}
local EasyLootSearchItemHits = {}

local function eventHandler(self, event, ...)
  if (event=="LOOT_OPENED") then
  	local arg1 = ...
  	if(arg1 == 0 and EasyLootSettings.enabled) then
		EasyLoot_HandleLoot()
	elseif(not EasyLootSettings.enabled) then
			--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot disabled")
  	end
  elseif(event == "BAG_UPDATE") then
	if EasyLootLootList.destroygrey and EasyLootDestroyItem and #EasyLootDestroyItem > 0 then
		EasyLoot_AutoDestroy()
	end
  elseif (event=="START_LOOT_ROLL") then
  	if(EasyLootSettings.enabled) then
	  	local id, timer = ...
  		EasyLoot_HandleRoll(id)
  	end
  elseif (event=="CONFIRM_LOOT_ROLL") then
  	if(EasyLootSettings.enabled) then
  		local id, rolltype = ...
  		EasyLoot_HandleConfirmation(id, rolltype)
  	end
  elseif (event=="LOOT_BIND_CONFIRM") then
  	if(EasyLootSettings.enabled) then
  		local slotId = ...
  		EasyLoot_HandleBoP(slotId)
  	end
  elseif (event=="CONFIRM_DISENCHANT_ROLL") then
  	if(EasyLootSettings.enabled) then
  		local id, rolltype = ...
  		EasyLoot_HandleConfirmation(id, rolltype)
  	end
  elseif (event=="CHAT_MSG_LOOT") then
  	local message, sender, language, channelString, target, flags, _, channelNumber, channelName, _, _ = ...
	EasyLoot_HandleIncomingLoot(message)
  elseif (event=="VARIABLES_LOADED") then
  	EasyLootFilter:SetPoint("BOTTOMLEFT","UIParent", "BOTTOMLEFT", EasyLootSettings.dispx, EasyLootSettings.dispy);
	if(not (EasyLootLootList.greed)) then
		EasyLootLootList.greed = {}
		EasyLoot_GreedScrollBar_Update()
	end
	if(not (EasyLootLootList.greedkeep)) then
		EasyLootLootList.greedkeep = {}
		for i=1,#(EasyLootLootList.greed),1 do
			EasyLootLootList.greedkeep[i] = false
		end
		EasyLoot_GreedScrollBar_Update()
	end
	if(not (EasyLootLootList.needkeep)) then
		EasyLootLootList.needkeep = {}
		for i=1,#(EasyLootLootList.need),1 do
			EasyLootLootList.needkeep[i] = false
		end
		EasyLoot_NeedScrollBar_Update()
	end
	if(not EasyLootLootList.DisenchantRarity) then
		EasyLootLootList.DisenchantRarity = -1
	end
	if(not EasyLootLootList.iLevel) then
		EasyLootLootList.iLevel = 0
	end
	if(not EasyLootLootList.EasyLootPriceLimit) then
		EasyLootLootList.EasyLootPriceLimit = 5000
	end
  end
end

function EasyLoot_OnLoad(self)
	local version = GetAddOnMetadata("EasyLoot", "Version")
	EasyLoot_SetVariables()
	--One of them allows EasyLoot to be closed with the Escape key
	tinsert(UISpecialFrames, "EasyLootFilter");
	UIPanelWindows["EasyLootFilter"] = nil;

	self:SetScript("OnEvent", eventHandler)
	self:RegisterEvent("VARIABLES_LOADED")

	SlashCmdList["EASYLOOT"] = function(msg)
		EasyLoot_SlashCommand(msg)
	end
	SLASH_EASYLOOT1 = "/el"

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot v"..version.." loaded")
	end
	UIErrorsFrame:AddMessage("EasyLoot v"..version.." AddOn loaded", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
	self:RegisterEvent("LOOT_OPENED")
	self:RegisterEvent("START_LOOT_ROLL")
 	self:RegisterEvent("CONFIRM_LOOT_ROLL")
 	self:RegisterEvent("CONFIRM_DISENCHANT_ROLL")
	self:RegisterEvent("CHAT_MSG_LOOT")
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("LOOT_BIND_CONFIRM")
end

function EasyLoot_SetVariables()
	if(not EasyLootSettings) then
		EasyLootSettings = {}
		EasyLootSettings.rarity = 1
		EasyLootSettings.quest = 1
		EasyLootSettings.enabled = true
		EasyLootSettings.freeforall = true
		EasyLootSettings.roundrobin = true
		EasyLootSettings.master = true
		EasyLootSettings.group = true
		EasyLootSettings.needbeforegreed = true
		EasyLootSettings.dispx = GetScreenWidth()/2 - 200;
		EasyLootSettings.dispy = GetScreenHeight()/2 - 200;
	end
	if(not EasyLootLootList) then
		EasyLootLootList = {}
		EasyLootLootList.ignore = {}
		EasyLootLootList.autoloot = {}
		EasyLootLootList.need = {}
		EasyLootLootList.needkeep = {}
		EasyLootLootList.greed = {}
		EasyLootLootList.greedkeep = {}
		EasyLootLootList.destroy = {}
	end
end

function EasyLoot_SlashCommand(msg)
  if(msg) then
	local command = strlower(msg)
	if (command == "options") then
		InterfaceOptionsFrame_OpenToCategory(panelName);
	elseif(command == "show") then
		EasyLootFilter:Show()
	else
		EasyLootFilter:Hide()
	end
  end
end

function EasyLoot_OnDragStop(self)
	EasyLootSettings.dispx = self:GetLeft();
	EasyLootSettings.dispy = self:GetBottom();
end

function EasyLoot_HandleLoot()
	local numItems = GetNumLootItems()
	--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot number of items:" .. numItems)
	for i=1,numItems do
		local lootIcon, lootName, lootQuantity, rarity, locked = GetLootSlotInfo(i)
		if(not locked and EasyLootSettings[GetLootMethod()] and (rarity >= EasyLootSettings.rarity or not LootSlotIsItem(i) or EasyLoot_InTable(EasyLootLootList.autoloot, lootName)) and not(EasyLoot_InTable(EasyLootLootList.ignore, lootName))) then
			LootSlot(i)
		elseif(EasyLootSettings.quest and not(EasyLoot_InTable(EasyLootLootList.ignore, lootName))) then
			local itemLink = GetLootSlotLink(i)
			local _, _, _, _, _, itemType, _, _, _, _, _ = GetItemInfo(itemLink)
			if(itemType == "Quest") then
				LootSlot(i)
			end
		end
	end
end

function EasyLoot_HandleRoll(id)
	local texture, name, count, quality, bindOnPickUp, canNeed, canGreed, canDE = GetLootRollItemInfo(id)
	local link = GetLootRollItemLink(id)
	local _, _, _, iLevel,  _, _, _, _,  _, _, _ = GetItemInfo(link)
  	--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot item up for rolling: "..name.." Link: "..GetLootRollItemLink(id))
  	if(EasyLoot_InTable(EasyLootLootList.need, name) and canNeed) then
	  	--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot item up for rolling: "..name.." canNeed: "..canNeed)
  		RollOnLoot(id, 1)
  	elseif (canNeed and EasyLootSettings.atlasloot and (AtlasLoot_CheckWishlistItem and AtlasLoot_CheckWishlistItem(tonumber(EasyLoot_GetItemId(GetLootRollItemLink(id))), GetUnitName("player")))) then
  		RollOnLoot(id, 1)
  	elseif (EasyLoot_InTable(EasyLootLootList.greed, name)) then
  		local index = EasyLoot_InTable(EasyLootLootList.greed, name)
  		if(type(EasyLootLootList.greed[index]) == "table") then
  			if(EasyLootLootList.greed[index].disenchant and canDE) then
			  	--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot item up for rolling: "..name.." canDE: "..canDE.." DEing")
  				RollOnLoot(id, 3)
  			elseif (canGreed) then
			  	--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot item up for rolling: "..name.." greeding")
  				RollOnLoot(id, 2)
  			end
  		elseif(canDE) then
	  		RollOnLoot(id, 2)
  		end
  	elseif (not (EasyLootLootList.greedonboe and not bindOnPickUp) and EasyLootLootList.DisenchantRarity >= quality and canDE) then
  		if(EasyLootLootList.DEbeforeGreed and canDE) then
	  	--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot item up for disenchanting due to quality: "..name.." canDE: "..canDE.." canNeed: "..canNeed)
	  		RollOnLoot(id, 3)
	  	elseif (canGreed) then
	  		RollOnLoot(id, 2)
	  	end
  	elseif (iLevel <= EasyLootLootList.iLevel) then
  		if(EasyLootLootList.DEbeforeGreed and canDE) then
  			RollOnLoot(id, 3)
	  	elseif (canGreed) then
	  		RollOnLoot(id, 2)
	  	end
  	elseif(EasyLootLootList.DisenchantRarity >= quality and canGreed) then
	  	--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot item up for greeding due to quality: "..name)
  		RollOnLoot(id, 2)
  	end
end

function EasyLoot_HandleConfirmation(id, rolltype)
	local texture, name, count, quality, bindOnPickUp = GetLootRollItemInfo(id)
	local link = GetLootRollItemLink(id)
	local _, _, _, iLevel,  _, _, _, _,  _, _, _ = GetItemInfo(link)
	--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot confirm roll on "..name)
	if(rolltype == 1 and EasyLoot_InTable(EasyLootLootList.need, name)) then
		--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot confirm "..name .." Need roll")
		ConfirmLootRoll(id, rolltype)
	elseif(EasyLootSettings.atlasloot and rolltype==1 and AtlasLoot_CheckWishlistItem and AtlasLoot_CheckWishlistItem(tonumber(EasyLoot_GetItemId(GetLootRollItemLink(id))), GetUnitName("player"))) then
		ConfirmLootRoll(id, rolltype)
	elseif(rolltype == 2 and EasyLoot_InTable(EasyLootLootList.greed, name)) then
		--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot confirm "..name .." Greed roll")
		ConfirmLootRoll(id, rolltype)
	elseif(rolltype == 3 and EasyLoot_InTable(EasyLootLootList.greed, name)) then
		local index = EasyLoot_InTable(EasyLootLootList.greed, name)
  		if(type(EasyLootLootList.greed[index]) == "table") then
  			if(EasyLootLootList.greed[index].disenchant and canDE) then
				--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot confirm "..name .." DE roll listed")
				ConfirmLootRoll(id, rolltype)
			end
		end
	elseif((rolltype == 3 or rolltype == 2) and not EasyLoot_InTable(EasyLootLootList.greed, name)) then
		if (EasyLootLootList.DisenchantRarity >= quality) then
			--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot confirm "..name .." DE roll")
			ConfirmLootRoll(id, rolltype)
		elseif (iLevel <= EasyLootLootList.iLevel) then
			ConfirmLootRoll(id, rolltype)
		end
	else
		--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot confirm "..name .." confirmation on roll failed")
	end
end

function EasyLoot_HandleBoP(slotId)
	local lootIcon, lootName, lootQuantity, rarity, locked = GetLootSlotInfo(slotId)
	if EasyLoot_InTable(EasyLootLootList.autoloot, lootName) then
		ConfirmLootSlot(slotId)
	end
end

function EasyLoot_HandleIncomingLoot(message)
	for i=1,#(EasyLootLootList.need),1  do
		if(strmatch(message, "You receive .*"..EasyLootLootList.need[i]..".*")) then
			--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot Match need")
			if(not EasyLootLootList.needkeep[i]) then
				tremove(EasyLootLootList.need, i)
				tremove(EasyLootLootList.needkeep, i)
				EasyLoot_NeedScrollBar_Update()
			end
			return
		end
	end
	for i=1, #(EasyLootLootList.greed),1  do
		local name
		if (type(EasyLootLootList.greed) == "table") then
			name = EasyLootLootList.greed[i].name
		else
			name = EasyLootLootList.greed[i]
		end
		if(name and strmatch(message, "You receive .*"..name..".*")) then
			--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot Match greed")
			if(not EasyLootLootList.greedkeep[i]) then
				tremove(EasyLootLootList.greed, i)
				tremove(EasyLootLootList.greedkeep, i)
				EasyLoot_GreedScrollBar_Update()
			end
			return
		end
	end

	if AtlasLoot_CheckWishlistItem and AtlasLoot_GetWishLists then
		if AtlasLoot_GetWishLists(GetUnitName("player")) then
			local _,_,_,itemId = string.find(message, "^You receive loot: |?c?f?f?(.*)|Hitem:(%d+):.*:.*:.*:.*:.*:.*:.*:.*|.*$")
			if itemId and AtlasLoot_CheckWishlistItem(tonumber(itemId), GetUnitName("player")) then
				--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot Matched AtlasLoot "..itemId)
				AtlasLoot_DeleteFromWishList(tonumber(itemID))
			end
		end
	end
	
	if EasyLootLootList.destroygrey then
		local _,_,_,itemId = string.find(message, "^You receive loot: |?c?f?f?(.*)|Hitem:(%d+):.*:.*:.*:.*:.*:.*:.*:.*|.*$")
		if(itemId) then
			local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemId)
			if quality == 0 and EasyLootLootList.EasyLootPriceLimit > vendorPrice then
				--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot Destroy grey: "..itemId..", quality:"..quality)
				EasyLootDestroyItem[#(EasyLootDestroyItem) + 1] = tonumber(itemId)
			end
		end
	end
	
	if EasyLootLootList.destroy and #EasyLootLootList.destroy > 0 then
		local _, _, _, _, itemId, _, _, _, _, _, _, _, _, name = string.find(message, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
		--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot Destroy item: "..name)
		if EasyLoot_InTable(EasyLootLootList.destroy, name) then
			EasyLootDestroyItem[#(EasyLootDestroyItem) + 1] = tonumber(itemId)
		end
	end
end

function EasyLoot_AutoDestroy()
	for i = 0, 4, 1 do
		x = GetContainerNumSlots(i)
		for j = 0, x, 1 do
			if GetContainerItemID(i, j) then
				local tableIndex = EasyLoot_InTable(EasyLootDestroyItem, tonumber(GetContainerItemID(i, j)))
				if tableIndex then
					PickupContainerItem(i, j)
					if CursorHasItem() then
						--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot Destroying "..tableIndex)
						DeleteCursorItem()
						tremove(EasyLootDestroyItem, tableIndex)
					end
				end
			end
		end
	end
end

function EasyLoot_ConfigLoadOrCancel()
	EasyLootConfigFrameEnabled:SetChecked(EasyLootSettings.enabled)
	EasyLootConfigFrameFreeForAll:SetChecked(EasyLootSettings.freeforall)
	EasyLootConfigFrameRoundRobin:SetChecked(EasyLootSettings.roundrobin)
	EasyLootConfigFrameMaster:SetChecked(EasyLootSettings.master)
	EasyLootConfigFrameGroup:SetChecked(EasyLootSettings.group)
	EasyLootConfigFrameNeedBeforeGreed:SetChecked(EasyLootSettings.needbeforegreed)
	EasyLootConfigFrameQuest:SetChecked(EasyLootSettings.quest)
	EasyLootConfigFrameAtlasLoot:SetChecked(EasyLootSettings.atlasloot)
end

function EasyLootConfigFrame_OnLoad(panel)
	panelName = "EasyLoot " .. GetAddOnMetadata("EasyLoot", "Version")
	panel.name = panelName
	panel.okay = function(self)
		EasyLootConfig_Ok()
	end
	panel.cancel = function(self)
		EasyLoot_ConfigLoadOrCancel()
	end
	InterfaceOptions_AddCategory(panel);
	if(AtlasLoot_CheckWishlistItem) then
		EasyLootConfigFrameAtlasLoot:Show()
	else
		EasyLootConfigFrameAtlasLoot:Hide()
	end
end

function EasyLootConfig_Ok()
	EasyLootSettings.enabled=EasyLootConfigFrameEnabled:GetChecked()
	EasyLootSettings.freeforall=EasyLootConfigFrameFreeForAll:GetChecked()
	EasyLootSettings.roundrobin=EasyLootConfigFrameRoundRobin:GetChecked()
	EasyLootSettings.master=EasyLootConfigFrameMaster:GetChecked()
	EasyLootSettings.group=EasyLootConfigFrameGroup:GetChecked()
	EasyLootSettings.needbeforegreed = EasyLootConfigFrameNeedBeforeGreed:GetChecked()
	EasyLootSettings.quest = EasyLootConfigFrameQuest:GetChecked()
	EasyLootSettings.atlasloot = EasyLootConfigFrameAtlasLoot:GetChecked()
end

function EasyLoot_RarityDropdown_OnClick(self)
  local i = self:GetID()
  EasyLootSettings.rarity = i-1
  UIDropDownMenu_SetSelectedID(EasyLootConfigFrameComboRarity, i)
end

function EasyLoot_RarityDropdown_OnShow()
	UIDropDownMenu_Initialize(EasyLootConfigFrameComboRarity, EasyLoot_RarityDropdown_Initialize)
	UIDropDownMenu_SetSelectedID(EasyLootConfigFrameComboRarity, EasyLootSettings.rarity+1)
end

function EasyLoot_RarityDropdown_Initialize()
	local i;
	if(#(easyLootLevels) > 0) then
		for i = 1, #(easyLootLevels), 1 do
			local redComponent, greenComponent, blueComponent, hexColor = GetItemQualityColor(i-1)
			info = {
				text = hexColor..easyLootLevels[i];
				func = EasyLoot_RarityDropdown_OnClick;
			};
			UIDropDownMenu_AddButton(info);
			i = i + 1;
		end
	end
end

function EasyLoot_DisenchantRarityDropdown_OnClick(self)
  local i = self:GetID()
  if(i >= #(easyLootLevels)) then
  	EasyLootLootList.DisenchantRarity = -1
  else
  	EasyLootLootList.DisenchantRarity = i-1
  end
  UIDropDownMenu_SetSelectedID(EasyLootFilterDisenchantComboRarity, i)
end

function EasyLoot_DisenchantRarityDropdown_OnShow()
	if(not EasyLootLootList.DisenchantRarity) then
		EasyLootLootList.DisenchantRarity = -1
	end
	UIDropDownMenu_Initialize(EasyLootFilterDisenchantComboRarity, EasyLoot_DisenchantRarityDropdown_Initialize)
	if(EasyLootLootList.DisenchantRarity == -1) then
		UIDropDownMenu_SetSelectedID(EasyLootFilterDisenchantComboRarity, #(easyLootLevels)+1)
	else
		UIDropDownMenu_SetSelectedID(EasyLootFilterDisenchantComboRarity, EasyLootLootList.DisenchantRarity+1)
	end
end

function EasyLoot_DisenchantRarityDropdown_Initialize()
	local i;
	if(#(easyLootLevels) > 0) then
		for i = 1, #(easyLootLevels)+1, 1 do
			local redComponent, greenComponent, blueComponent, hexColor = GetItemQualityColor(i-1)
			local tempText
			if(i > #(easyLootLevels)) then
				tempText = hexColor.."Disabled"
			else
				tempText = hexColor..easyLootLevels[i]
			end
			info = {
				text = tempText;
				func = EasyLoot_DisenchantRarityDropdown_OnClick;
			}
			UIDropDownMenu_AddButton(info)
			i = i + 1
		end
	end
end

function EasyLoot_InTable2(t, val)
	for i=1, #(t), 1 do
		local localValue
		if(type(t[i]) == "table") then
			localValue = t[i].name
		else
			localValue = t[i]
		end
  		if localValue == val then
		    return i
  		end
	end
	return false
end

function EasyLoot_InTable(t, val)
	for index, v in ipairs(t) do
		local localValue
		if(type(v) == "table") then
			localValue = v.name
		else
			localValue = v
		end
  		if localValue == val then
		    return index
  		end
	end
	return false
end

function EasyLoot_AutoLootScrollBar_Update()
	local line
	local lineplusoffset
	FauxScrollFrame_Update(EasyLootFilterAutoLootScrollFrame, #(EasyLootLootList.autoloot), 5, 16)
	for line=1,5 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(EasyLootFilterAutoLootScrollFrame)
		if lineplusoffset <= #(EasyLootLootList.autoloot) then
			if(strlen(EasyLootLootList.autoloot[lineplusoffset]) > 12) then
				text = strsub(EasyLootLootList.autoloot[lineplusoffset],1,12).."..."
			else
				text = EasyLootLootList.autoloot[lineplusoffset]
			end
			_G["EasyLootAutoLootEntry"..line]:SetText(text)
			_G["EasyLootAutoLootEntry"..line]:Show()
		else
			_G["EasyLootAutoLootEntry"..line]:Hide()
		end
	end
end

function EasyLoot_IgnoreScrollBar_Update()
	local line
	local lineplusoffset
	FauxScrollFrame_Update(EasyLootFilterIgnoreScrollFrame, #(EasyLootLootList.ignore), 5, 16)
	for line=1,5 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(EasyLootFilterIgnoreScrollFrame)
		if lineplusoffset <= #(EasyLootLootList.ignore) then
			if(strlen(EasyLootLootList.ignore[lineplusoffset]) > 12) then
				text = strsub(EasyLootLootList.ignore[lineplusoffset],1,12).."..."
			else
				text = EasyLootLootList.ignore[lineplusoffset]
			end
			_G["EasyLootIgnoreEntry"..line]:SetText(text)
			_G["EasyLootIgnoreEntry"..line]:Show()
		else
			_G["EasyLootIgnoreEntry"..line]:Hide()
		end
	end
end

function EasyLoot_DestroyScrollBar_Update()
	local line
	local lineplusoffset
	if(not EasyLootLootList.destroy) then
		EasyLootLootList.destroy = {}
	end
	FauxScrollFrame_Update(EasyLootFilterDestroyScrollFrame, #(EasyLootLootList.destroy), 5, 16)
	for line=1,5 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(EasyLootFilterDestroyScrollFrame)
		if lineplusoffset <= #(EasyLootLootList.destroy) then
			if(strlen(EasyLootLootList.destroy[lineplusoffset]) > 12) then
				text = strsub(EasyLootLootList.destroy[lineplusoffset],1,12).."..."
			else
				text = EasyLootLootList.destroy[lineplusoffset]
			end
			_G["EasyLootDestroyEntry"..line]:SetText(text)
			_G["EasyLootDestroyEntry"..line]:Show()
		else
			_G["EasyLootDestroyEntry"..line]:Hide()
		end
	end
end

function EasyLoot_NeedScrollBar_Update()
	local line
	local lineplusoffset
	FauxScrollFrame_Update(EasyLootFilterNeedScrollFrame, #(EasyLootLootList.need), 5, 16)
	for line=1,5 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(EasyLootFilterNeedScrollFrame)
		if lineplusoffset <= #(EasyLootLootList.need) then
			if(strlen(EasyLootLootList.need[lineplusoffset]) > 12) then
				text = strsub(EasyLootLootList.need[lineplusoffset],1,12).."..."
			else
				text = EasyLootLootList.need[lineplusoffset]
			end
			local keep = EasyLootLootList.needkeep[lineplusoffset]
			if(not keep) then
				keep = false
			end
			_G["EasyLootNeedEntry"..line]:SetText(text)
			_G["EasyLootNeedEntry"..line]:Show()
			_G["EasyLootNeedPermanent"..line]:SetChecked(keep)
			_G["EasyLootNeedPermanent"..line]:Show()
		else
			_G["EasyLootNeedEntry"..line]:Hide()
			_G["EasyLootNeedPermanent"..line]:Hide()
		end
	end
end

function EasyLoot_GreedScrollBar_Update()
	local line
	local lineplusoffset
	local name
	local disenchant
	FauxScrollFrame_Update(EasyLootFilterGreedScrollFrame, #(EasyLootLootList.greed), 5, 16)
	for line=1,5 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(EasyLootFilterGreedScrollFrame)
		if lineplusoffset <= #(EasyLootLootList.greed) then
			if(type(EasyLootLootList.greed[lineplusoffset]) == "table") then
				name = EasyLootLootList.greed[lineplusoffset].name
				disenchant = EasyLootLootList.greed[lineplusoffset].disenchant
			else
				name = EasyLootLootList.greed[lineplusoffset]
				disenchant = nil
			end
			if(strlen(name) > 12) then
				text = strsub(name,1,12).."..."
			else
				text = name
			end
			local keep = EasyLootLootList.greedkeep[lineplusoffset]
			if(not keep) then
				keep = false
			end
			_G["EasyLootGreedEntry"..line]:SetText(text)
			_G["EasyLootGreedEntry"..line]:Show()
			_G["EasyLootGreedPermanent"..line]:SetChecked(keep)
			_G["EasyLootGreedPermanent"..line]:Show()
			_G["EasyLootGreedDisenchant"..line]:SetChecked(disenchant)
			_G["EasyLootGreedDisenchant"..line]:Show()
		else
			_G["EasyLootGreedEntry"..line]:Hide()
			_G["EasyLootGreedPermanent"..line]:Hide()
			_G["EasyLootGreedDisenchant"..line]:Hide()
		end
	end
end

function EasyLoot_ListButtonClicked(button)
	local text = button:GetText()
	local name = button:GetName()
	if(strmatch(name, "^EasyLootAutoLootEntry")) then
		local o = FauxScrollFrame_GetOffset(EasyLootFilterAutoLootScrollFrame)
		local line = tonumber(strmatch(name, "%d"))
		tremove(EasyLootLootList.autoloot, o+line)
		EasyLoot_AutoLootScrollBar_Update()
	elseif(strmatch(name, "^EasyLootIgnoreEntry")) then
		local o = FauxScrollFrame_GetOffset(EasyLootFilterIgnoreScrollFrame)
		local line = tonumber(strmatch(name, "%d"))
		tremove(EasyLootLootList.ignore, o+line)
		EasyLoot_IgnoreScrollBar_Update()
	elseif(strmatch(name, "^EasyLootNeedEntry")) then
		local o = FauxScrollFrame_GetOffset(EasyLootFilterNeedScrollFrame)
		local line = tonumber(strmatch(name, "%d"))
		tremove(EasyLootLootList.need, o+line)
		tremove(EasyLootLootList.needkeep, o+line)
		EasyLoot_NeedScrollBar_Update()
	elseif(strmatch(name, "^EasyLootGreedEntry")) then
		local o = FauxScrollFrame_GetOffset(EasyLootFilterGreedScrollFrame)
		local line = tonumber(strmatch(name, "%d"))
		tremove(EasyLootLootList.greed, o+line)
		tremove(EasyLootLootList.greedkeep, o+line)
		EasyLoot_GreedScrollBar_Update()
	elseif(strmatch(name, "^EasyLootDestroyEntry")) then
		local o = FauxScrollFrame_GetOffset(EasyLootFilterDestroyScrollFrame)
		local line = tonumber(strmatch(name, "%d"))
		tremove(EasyLootLootList.destroy, o+line)
		EasyLoot_DestroyScrollBar_Update()
	end
end

function EasyLoot_ListPermanentClicked(self)
	local name = self:GetName()
	local checked = self:GetChecked()
	if(strmatch(name, "^EasyLootNeedPermanent")) then
		local o = FauxScrollFrame_GetOffset(EasyLootFilterNeedScrollFrame)
		local line = tonumber(strmatch(name, "%d"))
		EasyLootLootList.needkeep[o+line] = checked
		EasyLoot_NeedScrollBar_Update()
	elseif(strmatch(name, "^EasyLootGreedPermanent")) then
		local o = FauxScrollFrame_GetOffset(EasyLootFilterGreedScrollFrame)
		local line = tonumber(strmatch(name, "%d"))
		EasyLootLootList.greedkeep[o+line] = checked
		EasyLoot_GreedScrollBar_Update()
	end
end

function EasyLoot_ListDisenchantClicked(self)
	local name = self:GetName()
	local checked = self:GetChecked()
	if(strmatch(name, "^EasyLootGreedDisenchant")) then
		local o = FauxScrollFrame_GetOffset(EasyLootFilterGreedScrollFrame)
		local line = tonumber(strmatch(name, "%d"))
		if(type(EasyLootLootList.greed[o+line]) == "table") then
			EasyLootLootList.greed[o+line].disenchant = checked
		else
			local name = EasyLootLootList.greed[o+line]
			EasyLootLootList.greed[o+line] = {}
			EasyLootLootList.greed[o+line].name = name
			EasyLootLootList.greed[o+line].disenchant = checked
		end
		EasyLoot_GreedScrollBar_Update()
	end
end

function EasyLoot_GreedOnBoEClicked(self)
	EasyLootLootList.greedonboe = self:GetChecked()
end

function EasyLoot_DestroygreyClicked(self)
	EasyLootLootList.destroygrey = self:GetChecked()
end

function EasyLoot_ItemLevelChange()
	local value = EasyLootItemLevel:GetText()
	EasyLootLootList.iLevel = tonumber(value)
end

function EasyLoot_DestroyValueChange()
	local value = EasyLootDestroyValue:GetText()
	EasyLootLootList.EasyLootPriceLimit = tonumber(value)
end

function EasyLoot_DestroyValue_Update()
	EasyLootDestroyValue:SetText(EasyLootLootList.EasyLootPriceLimit)
end

function EasyLoot_ItemLevel_Update()
	EasyLootItemLevel:SetText(EasyLootLootList.iLevel)
end

function EasyLoot_SetHook()
	Old_ChatEdit_InsertLink = ChatEdit_InsertLink
	ChatEdit_InsertLink = function(text)
		ChatEdit_InsertLink = Old_ChatEdit_InsertLink
		return EasyLoot_InsertLink(text) or Old_ChatEdit_InsertLink(text)
	end
end

function EasyLoot_GetItemId(link)
	local _, _, _, _, itemId, _, _, _, _, _, _, _, _, _ = string.find(link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
	return itemId
end

function EasyLoot_InsertLink(text)
	--DEFAULT_CHAT_FRAME:AddMessage(text)
	local _, _, _, _, _, _, _, _, _, _, _, _, _, Name = string.find(text, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
	EasyLootFilterItem:SetText(Name)
	return true
end

function EasyLoot_AddAutoLoot()
	local itemName = EasyLootFilterItem:GetText()
	if(itemName and not (itemName=="")) then
		EasyLootLootList.autoloot[#(EasyLootLootList.autoloot) + 1] = itemName
		EasyLoot_AutoLootScrollBar_Update()
		EasyLootFilterItem:SetText("")
	end
	EasyLootFilterItem:ClearFocus()
end

function EasyLoot_AddIgnore()
	local itemName = EasyLootFilterItem:GetText()
	if(itemName and not (itemName=="")) then
		EasyLootLootList.ignore[#(EasyLootLootList.ignore) + 1] = itemName
		EasyLoot_IgnoreScrollBar_Update()
		EasyLootFilterItem:SetText("")
	end
	EasyLootFilterItem:ClearFocus()
end

function EasyLoot_AddDestroy()
	local itemName = EasyLootFilterItem:GetText()
	if not EasyLootLootList.destroy then
		EasyLootLootList.destroy = {}
	end
	if(itemName and not (itemName=="")) then
		EasyLootLootList.destroy[#(EasyLootLootList.destroy) + 1] = itemName
		EasyLoot_DestroyScrollBar_Update()
		EasyLootFilterItem:SetText("")
	end
	EasyLootFilterItem:ClearFocus()
end

function EasyLoot_AddNeed()
	local itemName = EasyLootFilterItem:GetText()
	if(itemName and not (itemName=="")) then
		EasyLootLootList.need[#(EasyLootLootList.need) + 1] = itemName
		EasyLootLootList.needkeep[#(EasyLootLootList.need)] = false
		EasyLoot_NeedScrollBar_Update()
		EasyLootFilterItem:SetText("")
	end
	EasyLootFilterItem:ClearFocus()
end

function EasyLoot_AddGreed()
	local itemName = EasyLootFilterItem:GetText()
	if(itemName and not (itemName=="")) then
		local n = #(EasyLootLootList.greed) +1
		EasyLootLootList.greed[n] = {}
		EasyLootLootList.greed[n].name = itemName
		EasyLootLootList.greedkeep[n] = false
		EasyLoot_GreedScrollBar_Update()
		EasyLootFilterItem:SetText("")
	end
	EasyLootFilterItem:ClearFocus()
end

function EasyLoot_DEBeforeGreed(value)
	if value then
		EasyLootLootList.DEbeforeGreed = true
	else
		EasyLootLootList.DEbeforeGreed = nil
	end
end

function EasyLoot_SearchUpdate()
	--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot Search: "..EasyLootSearchText:GetText())
	EasyLootSearchItemHits = {}
	for i = 1, 6, 1 do
		_G["EasyLootItem"..i]:Hide()
	end
	for i = 0, 4, 1 do
		x = GetContainerNumSlots(i)
		for j = 0, x, 1 do
			if GetContainerItemID(i, j) and #EasyLootSearchText:GetText() > 0 then
				name = GetItemInfo(GetContainerItemID(i, j))
				if(string.find(string.lower(name), ".*"..string.lower(EasyLootSearchText:GetText())..".*")) then
					-- DEFAULT_CHAT_FRAME:AddMessage("|cffffff00EasyLoot Match "..name)
					EasyLootSearchItemHits[(#(EasyLootSearchItemHits) or 0) +1] = {GetContainerItemID(i, j), i, j}
				end
			end
		end
	end
	if #EasyLootSearchItemHits > 0 then
		for i = 1,6,1 do
			if EasyLootSearchItemHits and i <= #EasyLootSearchItemHits then
				itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(EasyLootSearchItemHits[i][1])
				_, count = GetContainerItemInfo(EasyLootSearchItemHits[i][2], EasyLootSearchItemHits[i][3])
				_G["EasyLootItem"..i]:SetNormalTexture(itemTexture)
				_G["EasyLootItem"..i.."Text"]:SetText(count)
				_G["EasyLootItem"..i]:Show()
			end
		end
		EasyLoot_SearchScrollBar_Update()
	end
end

function EasyLoot_ItemClicked(self)
	local name = self:GetName()
	local line = tonumber(strmatch(name, "%d"))
	if line and EasyLootSearchItemHits and EasyLootSearchItemHits[line] then
		if IsShiftKeyDown() then
			itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(EasyLootSearchItemHits[line + FauxScrollFrame_GetOffset(EasyLootSearchScrollFrame)][1])
			EasyLootFilterItem:SetText(itemName)
		else
			PickupContainerItem(EasyLootSearchItemHits[line+FauxScrollFrame_GetOffset(EasyLootSearchScrollFrame)][2], EasyLootSearchItemHits[line+FauxScrollFrame_GetOffset(EasyLootSearchScrollFrame)][3])
		end
	end
end

function EasyLoot_ItemEnter(self)
	local name = self:GetName()
	local line = tonumber(strmatch(name, "%d"))
	if line and EasyLootSearchItemHits and EasyLootSearchItemHits[line] then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetBagItem(EasyLootSearchItemHits[line+FauxScrollFrame_GetOffset(EasyLootSearchScrollFrame)][2], EasyLootSearchItemHits[line + FauxScrollFrame_GetOffset(EasyLootSearchScrollFrame)][3])
		GameTooltip:Show()
	end
end

function EasyLoot_ItemLeave(self)
	GameTooltip:Hide()
end

function EasyLoot_SearchScrollBar_Update()
	local line
	local lineplusoffset
	FauxScrollFrame_Update(EasyLootSearchScrollFrame, #(EasyLootSearchItemHits), 6, 64)
	for line=1,6 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(EasyLootSearchScrollFrame)
		if lineplusoffset <= #(EasyLootSearchItemHits) then
			itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(EasyLootSearchItemHits[lineplusoffset][1])
			_G["EasyLootItem"..line]:SetNormalTexture(itemTexture)
			_G["EasyLootItem"..line]:Show()
		else
			_G["EasyLootItem"..line]:Hide()
		end
	end
end