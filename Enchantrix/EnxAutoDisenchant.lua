--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: EnxAutoDisenchant.lua 4587 2009-12-17 22:00:31Z Nechckn $
	URL: http://enchantrix.org/

	Automatic disenchant scanner.

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]
Enchantrix_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Enchantrix/EnxAutoDisenchant.lua $", "$Rev: 4587 $")

local auto_de_session_ignore_list = {}
local auto_de_frame
local auto_de_prompt

local showPrompt
local hidePrompt
local clearPrompt

local auto_de_tooltip = LibStub("nTipHelper:1")

--------------------------------------------------------------------------------
-- Debug stuff

local DebugLib = LibStub("DebugLib")
local debug, assert
if DebugLib then
	debug, assert = DebugLib("Enchantrix")
else
	function debug() end
	assert = debug
end

local function debugSpam(...)
--	local message = debug:Dump(...)
--	local r, g, b = 0, 0.75, 1
--	getglobal("ChatFrame1"):AddMessage("AutoDe: " .. message, r, g, b)
end

local function eventSpam(...)
--	local message = debug:Dump(...)
--	debugSpam("Event: " .. message)
end

--------------------------------------------------------------------------------
-- Item ignore list and utility functions

local function itemStringFromLink(link)
	local _, _, itemString = string.find(link, "^|c%x+|H(.+)|h%[.+%]")
	return itemString
end

-- remove the uniqueID and viewer level from the link
-- this needs to be updated whenever the link format changes
local function genericizeItemLink(link)
	-- strip out unique id
	local _, _, head, tail = string.find(link, "^(|c%x+|H.+:)[-%d]+:%d+(|h.+)")
	return head .. "0:0" .. tail
end

local function ignoreItemPermanent(link)
	local genericLink = genericizeItemLink(link)
	Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeIgnorePermanent"):format(genericLink))
	AutoDisenchantIgnoreList[genericLink] = true
end

local function ignoreItemSession(link, silent)
	local genericLink = genericizeItemLink(link)
	if not silent then
		Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeIgnoreSession"):format(genericLink))
	end
	auto_de_session_ignore_list[genericLink] = true
end

local function isItemIgnored(link)
	local genericLink = genericizeItemLink(link)
	return auto_de_session_ignore_list[genericLink] or AutoDisenchantIgnoreList[genericLink]
end


-- check item quality and reason for purchase (if BeanCounter is installed)
local function isAutoDisenchantAllowed(link, count)
	local _, _, quality, _ = GetItemInfo(link)

	if (quality == 3) and (not Enchantrix.Settings.GetSetting('AutoDeRareItems')) then
		return false
	end
	
	if (quality == 4) and (not Enchantrix.Settings.GetSetting('AutoDeEpicItems')) then
		return false
	end
	
	-- this WILL NOT WORK for milling or prospecting
	-- because changing the stack size in any way will change the reason returned by beancounter
	if Enchantrix.Settings.GetSetting('AutoDeOnlyIfBoughtForDE') then
		if (BeanCounter and BeanCounter.API) then
			local reason = BeanCounter.API.getBidReason(link, count)
			if (reason == "Disenchant" or reason == "EnchantMats") then
				return true;
			else
				return false;
			end
		else
			-- tell the user that beancounter is required
			Enchantrix.Util.ChatPrint(_ENCH("BeanCounterRequired"))
			Enchantrix.Settings.SetSetting('AutoDeOnlyIfBoughtForDE', false)
		end
	end
	
	return true
end

local function nameFromIgnoreListItem(item)
	local _, _, name = string.find(item, "%[(.+)%]")
	return name
end

--------------------------------------------------------------------------------
-- Main logic

local moduleState
local function setState(newState)
	if newState ~= state then
		debugSpam("State: " .. newState)
		moduleState = newState
	end
end

-- declared local at top
local function isState(state)
	return moduleState == state
end

local function getDisenchantOrProspectValue(link, count)
	local _, _, quality, level = GetItemInfo(link)
	if not (quality and level) then return end

	if quality >= 2 then
		local enchSkillRequired = Enchantrix.Util.DisenchantSkillRequiredForItemLevel(level, quality)
		if enchSkillRequired and Enchantrix.Util.GetUserEnchantingSkill() >= enchSkillRequired then
			local hsp, median, baseline, valFive = Enchantrix.Storage.GetItemDisenchantTotals(link)
			if (not hsp) or (hsp == 0) then
				-- what to do when Auc4 isn't loaded, but Auc5 is
				-- or when you have no data for mat prices
				if valFive and valFive > 0 then
					hsp = valFive
				else
					hsp = baseline
				end
			end
			if hsp and hsp > 0 then
				return hsp, _ENCH('ArgSpellname')
			end
		end
	end
	
	-- some quality 2 ores are now prospectable
	
	if count >= 5 then

-- TODO - ccox - these could share some code
		local jcSkillRequired = Enchantrix.Util.JewelCraftSkillRequiredForItem(link)
		if jcSkillRequired and Enchantrix.Util.GetUserJewelCraftingSkill() >= jcSkillRequired then
			local prospect = Enchantrix.Storage.GetItemProspects(link)
			if prospect then
				local prospectValue = 0
				for result, yield in pairs(prospect) do
					local hsp, median, baseline, valFive = Enchantrix.Util.GetReagentPrice(result)
					if (not hsp) or (hsp == 0) then
						-- what to do when Auc4 isn't loaded, but Auc5 is
						-- or when you have no data for mat prices
						if valFive and valFive > 0 then
							hsp = valFive
						else
							hsp = baseline
						end
					end
					local value = (hsp or 0) * yield
					prospectValue = prospectValue + value
				end
				return prospectValue, _ENCH('ArgSpellProspectingName')
			end
		end

		local inscriptionSkillRequired = Enchantrix.Util.InscriptionSkillRequiredForItem(link)
		if inscriptionSkillRequired and Enchantrix.Util.GetUserInscriptionSkill() >= inscriptionSkillRequired then
			local milling = Enchantrix.Storage.GetItemMilling(link)
			if milling then
				local millingValue = 0
				for result, yield in pairs(milling) do
					local hsp, median, baseline, valFive = Enchantrix.Util.GetReagentPrice(result)
					if (not hsp) or (hsp == 0) then
						-- what to do when Auc4 isn't loaded, but Auc5 is
						-- or when you have no data for mat prices
						if valFive and valFive > 0 then
							hsp = valFive
						else
							hsp = baseline
						end
					end
					local value = (hsp or 0) * yield
					millingValue = millingValue + value
				end
				return millingValue, _ENCH('ArgSpellMillingName')
			end
		end

	end
end


-- check one bag (to save time when we know something moved in just this bag)
local function findItemInOneBag(bag, findLink)
	for slot = 1, GetContainerNumSlots(bag) do
		local _, count = GetContainerItemInfo(bag, slot)
    	local link = GetContainerItemLink(bag, slot)
		if link and (not findLink or link == findLink) then
			if not findLink and link == auto_de_prompt.link and bag == auto_de_prompt.bag
				and slot == auto_de_prompt.slot and count == auto_de_prompt.count then
				-- items sometimes linger after they've been disenchanted and looted
				debugSpam("Skipping zombie item " .. link)
			else
				if (not isItemIgnored(link)) and isAutoDisenchantAllowed(link, count) then
					local value, spell = getDisenchantOrProspectValue(link, count)
					if value and value > 0 then
						return link, bag, slot, value, spell
					end
				end
			end
		end
	end
end


-- check all bags for disenchantable items
local function findItemInBags(findLink)
	debugSpam("scanning bags")
	for bag = 0, 4 do
		local link, bag, slot, value, spell = findItemInOneBag(bag, findLink)
		if (spell) then
			return link, bag, slot, value, spell
		end
	end
end


local function beginScan(bag)
	setState("scan")
	
	-- do not scan while in combat
	if UnitAffectingCombat("player") then
		debugSpam("aborting scan during combat")
		return
	end
	
	hidePrompt()		-- we can't hide the UI during combat

	local link, outBag, slot, value, spell
	if (bag and bag >= 0 and bag <= 4) then	-- exclude bank bags, we can't DE from the bank
		link, outBag, slot, value, spell = findItemInOneBag(bag)
	else
		link, outBag, slot, value, spell = findItemInBags()
	end
	if link then
		-- prompt for disenchant
		setState("prompt")
		showPrompt(link, outBag, slot, value, spell)
	end
end

local function onEvent(...)
	if isState("sleep") or isState("disabled") then return end

	local _, event, arg1, arg2, arg3, arg4 = ...;
	if event == "LOOT_OPENED" then
		if isState("loot_wait") then
			-- loot window opened - grab the spoils
			eventSpam(...)
			for slot = 1, GetNumLootItems() do
				LootSlot(slot)
			end
			setState("loot")
		else
			-- see if the user wants to auto-loot their manual disenchants
			if (Enchantrix.Settings.GetSetting('autoLootDE')) then
				eventSpam(...)
				
				-- make sure all results are DE/prospect/milling results
				for slot = 1, GetNumLootItems() do
					if (not LootSlotIsItem(slot)) then return end
					local link = GetLootSlotLink(slot)
					local _, itemID = auto_de_tooltip:DecodeLink(link)
					if (not itemID) then return end
					
					if ( not
						(Enchantrix.Constants.ReverseDisenchantLevelList[itemID]
						 or Enchantrix.Constants.ReverseProspectingSources[itemID]
						 or Enchantrix.Constants.ReversePigmentList[itemID])) then
						--eventSpam("item "..itemID.." not in our lists")
						return		-- this is not a DE,prospect, or milling result
					end
				end
				
				for slot = 1, GetNumLootItems() do
					LootSlot(slot)
				end
				
			end
		end
	elseif event == "LOOT_CLOSED" then
		if isState("loot") then
			-- looting done - continue scanning
			eventSpam(...)
			beginScan()
		end
	elseif event == "UNIT_SPELLCAST_SENT" then
		if isState("prompt") and arg1 == "player" and arg2 == auto_de_prompt.Yes:GetAttribute("spell") then
			-- disenchant started - wait for completion
			eventSpam(...)
			if (Enchantrix.Settings.GetSetting('chatShowFindings')) then
				if arg2 == _ENCH('ArgSpellProspectingName') then
					Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeProspecting"):format(auto_de_prompt.link))
				elseif arg2 == _ENCH('ArgSpellname') then
					Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeDisenchanting"):format(auto_de_prompt.link))
				elseif arg2 == _ENCH('ArgSpellMillingName') then
					Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeMilling"):format(auto_de_prompt.link))
				end
			end
			hidePrompt()
			setState("cast")
		end
	elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
		if arg1 == "player" then
			-- interrupted - revert to scanning
			eventSpam(...)
			hidePrompt()
			beginScan()
		end
	elseif event == "UNIT_SPELLCAST_FAILED" then
		if arg1 == "player" then
			-- failed - revert to scanning
			eventSpam(...)
			hidePrompt()
			beginScan()
		end
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		if isState("cast") and arg1 == "player" and arg2 == auto_de_prompt.Yes:GetAttribute("spell") then
			-- completed - wait for loot window to come up
			eventSpam(...)
			setState("loot_wait")
		end
	elseif event == "BAG_UPDATE" then
		if isState("scan") then
			-- bag contents changed - rescan bags
			eventSpam(...)
			beginScan(arg1)
		elseif isState("prompt") and arg1 == auto_de_prompt.bag then
			-- verify that our item is still there
		    local link = GetContainerItemLink(auto_de_prompt.bag, auto_de_prompt.slot)
			if link ~= auto_de_prompt.link then
				eventSpam(...)
				debugSpam(auto_de_prompt.link, "moved/disappeared")
				hidePrompt()

				local bag, slot, value, spell
				link, bag, slot, value, spell = findItemInBags(auto_de_prompt.link)
				if link then
					-- moved
					debugSpam("  found again at [" .. bag .. "," .. slot .. "]")
					showPrompt(link, bag, slot, value, spell)
				else
					-- sold, traded, banked, destroyed, ...
					local spellName = auto_de_prompt.Yes:GetAttribute("spell")
					if spellName == _ENCH('ArgSpellProspectingName') then
						Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeProspectCancelled"))
					elseif spellName == _ENCH('ArgSpellMillingName')  then
						Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeMillingCancelled"))
					elseif spellName == _ENCH('ArgSpellname')  then
						Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeDisenchantCancelled"))
					end
					hidePrompt()
					beginScan()
				end
			end
		end
	end
end

local updatedAgo = 0
local function onUpdate(frame, elapsed)
	if isState("disabled") then return end

	-- only handle initialization and settings changes in here, so don't need to
	-- update often. most of the grunt work happens in the event handler

	local updateEvery = 1
	updatedAgo = updatedAgo + elapsed
	if updatedAgo < updateEvery then return end

	local enabledInOptions = Enchantrix.Settings.GetSetting('AutoDisenchantEnable')
	if enabledInOptions then
		if isState("sleep") or isState("init") then
			if Enchantrix.Util.GetUserEnchantingSkill() >= 1
				or Enchantrix.Util.GetUserJewelCraftingSkill() >= 20
				or Enchantrix.Util.GetUserInscriptionSkill() >= 1 then
				Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeActive"))
				beginScan()
			elseif isState("init") then
				Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeDisabled"))
				setState("disabled")
			end
		end
	else
		if isState("prompt") or isState("scan") or isState("init") then
			Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeInactive"))
			if isState("prompt") then
				clearPrompt()
			end
			setState("sleep")
		end
	end

	updatedAgo = 0
end

--------------------------------------------------------------------------------
-- Prompt handling

local function getGSC(money)
	if (money == nil) then money = 0 end
	local g = math.floor(money / 10000)
	local s = math.floor((money - (g*10000)) / 100)
	local c = math.ceil(money - (g*10000) - (s*100))
	return g,s,c
end

local function getTextGSC(money)
	if (type(money) ~= "number") then return end

	local TEXT_NONE = "0"

	local GSC_GOLD="ffd100"
	local GSC_SILVER="e6e6e6"
	local GSC_COPPER="c8602c"
	local GSC_START="|cff%s%d%s|r"
	local GSC_PART=".|cff%s%02d%s|r"
	local GSC_NONE="|cffa0a0a0"..TEXT_NONE.."|r"

	if (not money) then money = 0 end

	local g, s, c = getGSC(money)
	local gsc = ""
	local fmt = GSC_START
	if (g > 0) then gsc = gsc..string.format(fmt, GSC_GOLD, g, 'g') fmt = GSC_PART end
	if (s > 0) or (c > 0) then gsc = gsc..string.format(fmt, GSC_SILVER, s, 's') fmt = GSC_PART end
	if (c > 0) then gsc = gsc..string.format(fmt, GSC_COPPER, c, 'c') end

	if (gsc == "") then gsc = GSC_NONE end

	return gsc
end


-- declared local at top
function showPrompt(link, bag, slot, value, spell)
	clearPrompt()		-- safety
	
	-- avoid taint, don't hide or show while in combat
	if UnitAffectingCombat("player") then
		return
	end
	
	debugSpam(link ..",".. bag ..",".. slot ..",".. value ..",".. spell)

	local _, count = GetContainerItemInfo(bag, slot)

	auto_de_prompt.link, auto_de_prompt.bag, auto_de_prompt.slot, auto_de_prompt.count = link, bag, slot, count
	auto_de_prompt.time = GetTime()		-- not yet used

	local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(auto_de_prompt.link)
	auto_de_prompt.Item:SetNormalTexture(texture)
	auto_de_prompt.Yes:SetAttribute("target-item", itemStringFromLink(auto_de_prompt.link))
	auto_de_prompt.Yes:SetAttribute("spell", spell)

	if spell == _ENCH('ArgSpellProspectingName') then
		auto_de_prompt.Lines[1]:SetText(_ENCH("GuiAutoProspectPromptLine1"))
		auto_de_prompt.Lines[2]:SetText("  " .. auto_de_prompt.link .. "x5")
	elseif spell == _ENCH('ArgSpellMillingName') then
		auto_de_prompt.Lines[1]:SetText(_ENCH("GuiAutoMillingPromptLine1"))
		auto_de_prompt.Lines[2]:SetText("  " .. auto_de_prompt.link .. "x5")
	elseif spell == _ENCH('ArgSpellname') then
		auto_de_prompt.Lines[1]:SetText(_ENCH("GuiAutoDePromptLine1"))
		auto_de_prompt.Lines[2]:SetText("  " .. auto_de_prompt.link)
	end
	auto_de_prompt.Lines[3]:SetText(_ENCH("GuiAutoDePromptLine3"):format(getTextGSC(floor(value))))

	-- clear the lines, just in case
	auto_de_prompt.Lines[4]:SetText( nil );
	auto_de_prompt.Lines[5]:SetText( nil );
	
	if (BeanCounter and BeanCounter.API) then
		local reason = BeanCounter.API.getBidReason(link, count)
		if (reason) then
			auto_de_prompt.Lines[4]:SetText( format( _ENCH("GuiAutoDEPurchaseReason"), reason ) );
		end
	end
	
	if (AucAdvanced and AucAdvanced.Modules and AucAdvanced.Modules.Util
		and AucAdvanced.Modules.Util.ItemSuggest) then
		local suggestion = AucAdvanced.Modules.Util.ItemSuggest.itemsuggest( link, count )
		if (suggestion) then
			auto_de_prompt.Lines[5]:SetText( format( _ENCH("GuiAutoDESuggestion"), suggestion)  );
		end
	end
	
	auto_de_prompt:Show()
end

-- declared local at top
function hidePrompt()
	-- avoid taint, don't hide or show while in combat
	if not UnitAffectingCombat("player") then
		auto_de_prompt:Hide()
	end
end

-- declared local at top
function clearPrompt()
	hidePrompt()
	auto_de_prompt.link, auto_de_prompt.bag, auto_de_prompt.slot, auto_de_prompt.count, auto_de_prompt.time = nil, nil, nil, nil, nil
	-- clear the button target so macro junkies don't get a surprise
	auto_de_prompt.Yes:SetAttribute("target-item", nil)
end

local function promptNo()
	if auto_de_prompt.link then
		ignoreItemSession(auto_de_prompt.link)
	end
	clearPrompt()
	beginScan()
end

local function promptIgnore()
	if auto_de_prompt.link then
		ignoreItemPermanent(auto_de_prompt.link)
	end
	clearPrompt()
	beginScan()
end

--------------------------------------------------------------------------------
-- Tooltip handling

local function showTooltip()
	GameTooltip:SetOwner(auto_de_prompt, "ANCHOR_NONE")
	
	local count = 1
	local spellName = auto_de_prompt.Yes:GetAttribute("spell")
	if spellName == _ENCH('ArgSpellProspectingName')
		or spellName == _ENCH('ArgSpellMillingName') then
		count = 5
	end
	
	auto_de_tooltip:ShowItemLink(GameTooltip, auto_de_prompt.link, count)
	
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("TOPRIGHT", "AutoDisenchantPromptItem", "TOPLEFT", -10, -20)
	GameTooltip:Show()
end

local function hideTooltip()
	GameTooltip:Hide()
end

--------------------------------------------------------------------------------
-- UI

local function initUI()
	-- main frame
	auto_de_frame = CreateFrame("Frame")

	-- prompt frame
	auto_de_prompt = CreateFrame("Frame", "", UIParent)
	auto_de_prompt:Hide()

	auto_de_prompt:SetPoint("TOP", "UIParent", "TOP", 0, -100)
	auto_de_prompt:SetFrameStrata("DIALOG")
	auto_de_prompt:SetHeight(170)
	auto_de_prompt:SetWidth(400)
	auto_de_prompt:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 9, right = 9, top = 9, bottom = 9 }
	})
	auto_de_prompt:SetBackdropColor(0,0,0, 0.8)
	auto_de_prompt:EnableMouse(true)
	auto_de_prompt:SetMovable(true)

	-- prompt dragbar
	auto_de_prompt.Drag = CreateFrame("Button", "", auto_de_prompt)
	auto_de_prompt.Drag:SetPoint("TOPLEFT", auto_de_prompt, "TOPLEFT", 10,-5)
	auto_de_prompt.Drag:SetPoint("TOPRIGHT", auto_de_prompt, "TOPRIGHT", -10,-5)
	auto_de_prompt.Drag:SetHeight(6)
	auto_de_prompt.Drag:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
	auto_de_prompt.Drag:SetScript("OnMouseDown", function() auto_de_prompt:StartMoving() end)
	auto_de_prompt.Drag:SetScript("OnMouseUp", function() auto_de_prompt:StopMovingOrSizing() end)

	-- prompt item icon
	auto_de_prompt.Item = CreateFrame("Button", "AutoDisenchantPromptItem", auto_de_prompt)
	auto_de_prompt.Item:SetNormalTexture("Interface\\Buttons\\UI-Slot-Background")
	auto_de_prompt.Item:SetPoint("TOPLEFT", auto_de_prompt, "TOPLEFT", 15, -15)
	auto_de_prompt.Item:SetHeight(37)
	auto_de_prompt.Item:SetWidth(37)
	auto_de_prompt.Item:SetScript("OnEnter", showTooltip)
	auto_de_prompt.Item:SetScript("OnLeave", hideTooltip)

	-- prompt text
	auto_de_prompt.Lines = {}
	for i = 1, 5 do
		auto_de_prompt.Lines[i] = auto_de_prompt:CreateFontString("AutoDisenchantPromptLine"..i, "HIGH")
		if (i == 1) then
			auto_de_prompt.Lines[i]:SetPoint("TOPLEFT", auto_de_prompt.Item, "TOPRIGHT", 5, 5)
			auto_de_prompt.Lines[i]:SetFont("Fonts\\FRIZQT__.TTF",16)
		else
			auto_de_prompt.Lines[i]:SetPoint("TOPLEFT", auto_de_prompt.Lines[i-1], "BOTTOMLEFT", 0, -5)
			auto_de_prompt.Lines[i]:SetFont("Fonts\\FRIZQT__.TTF",13)
		end
		auto_de_prompt.Lines[i]:SetWidth(350)
		auto_de_prompt.Lines[i]:SetJustifyH("LEFT")
		auto_de_prompt.Lines[i]:SetText(" ")
	end

	-- prompt buttons

	-- there is no secure version of OptionsButton, so create an invisible
	-- OptionsButton (auto_de_prompt.DummyYes) and copy its visual settings across to a
	-- SecureActionButton (auto_de_prompt.Yes) to perform the spellcast

	local function copyButtonVisuals(dest, source)
		dest:ClearAllPoints()
		dest:SetPoint("TOPLEFT", source, "TOPLEFT")
		dest:SetPoint("BOTTOMRIGHT", source, "BOTTOMRIGHT")
		dest:SetNormalTexture(source:GetNormalTexture())
		dest:SetHighlightTexture(source:GetHighlightTexture())
		dest:SetPushedTexture(source:GetPushedTexture())
		dest:SetText(source:GetText())
		dest:SetNormalFontObject(GameFontNormal);
		dest:SetHighlightFontObject(GameFontHighlight);
	end

	-- create an invisible "Yes" OptionsButton, then copy its settings
	-- across to the secure button
	auto_de_prompt.DummyYes = CreateFrame("Button", "", auto_de_prompt, "OptionsButtonTemplate")
	auto_de_prompt.DummyYes:SetText(_ENCH("GuiYes"))
	auto_de_prompt.DummyYes:SetPoint("BOTTOMRIGHT", auto_de_prompt, "BOTTOMRIGHT", -10, 10)
	auto_de_prompt.DummyYes:Hide()

	auto_de_prompt.Yes = CreateFrame("Button", "AutoDEPromptYes", auto_de_prompt, "SecureActionButtonTemplate")
	copyButtonVisuals(auto_de_prompt.Yes, auto_de_prompt.DummyYes)
	auto_de_prompt.Yes:SetAttribute("unit", "none")
	auto_de_prompt.Yes:SetAttribute("type", "spell")

	auto_de_prompt.No = CreateFrame("Button", "AutoDEPromptNo", auto_de_prompt, "OptionsButtonTemplate")
	auto_de_prompt.No:SetText(_ENCH("GuiNo"))
	auto_de_prompt.No:SetPoint("BOTTOMRIGHT", auto_de_prompt.Yes, "BOTTOMLEFT", -5, 0)
	auto_de_prompt.No:SetScript("OnClick", promptNo)

	auto_de_prompt.Ignore = CreateFrame("Button", "AutoDEPromptIgnore", auto_de_prompt, "OptionsButtonTemplate")
	auto_de_prompt.Ignore:SetText(_ENCH("GuiIgnore"))
	auto_de_prompt.Ignore:SetPoint("BOTTOMRIGHT", auto_de_prompt.No, "BOTTOMLEFT", -5, 0)
	auto_de_prompt.Ignore:SetScript("OnClick", promptIgnore)
end

--------------------------------------------------------------------------------
-- Global setup

local function addonLoaded()
	if not AutoDisenchantIgnoreList then AutoDisenchantIgnoreList = {} end

	setState("init")

	initUI()

	Stubby.RegisterEventHook("LOOT_OPENED", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("LOOT_CLOSED", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("UNIT_SPELLCAST_SENT", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("UNIT_SPELLCAST_INTERRUPTED", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("UNIT_SPELLCAST_FAILED", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("UNIT_SPELLCAST_SUCCEEDED", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("BAG_UPDATE", "Enchantrix.AutoDisenchant", onEvent)

	auto_de_frame:SetScript("OnUpdate", onUpdate)
end


Enchantrix.AutoDisenchant = {
	AddonLoaded = addonLoaded,
	NameFromIgnoreListItem = nameFromIgnoreListItem,

}
