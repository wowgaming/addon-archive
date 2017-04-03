--[[ Skillet: A tradeskill window replacement.
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

local L = AceLibrary("AceLocale-2.2"):new("Skillet")

SKILLET_TRADE_SKILL_HEIGHT = 16
SKILLET_NUM_REAGENT_BUTTONS = 8


local COLORORANGE = "|cffff8040"
local COLORYELLOW = "|cffffff00"
local COLORGREEN =  "|cff40c040"
local COLORGRAY =   "|cff808080"

-- min width for skill list window
local SKILLET_SKILLLIST_MIN_WIDTH = 200				-- was 165

-- min/max width for the reagent window
local SKILLET_REAGENT_MIN_WIDTH = 240
local SKILLET_REAGENT_MAX_WIDTH = 320

local skill_style_type = {
["unknown"]	 = { r = 1.00, g = 0.00, b = 0.00, level = 5, alttext="???", cstring = "|cffff0000"},
["optimal"]	 = { r = 1.00, g = 0.50, b = 0.25, level = 4, alttext="+++", cstring = "|cffff8040"},
["medium"] = { r = 1.00, g = 1.00, b = 0.00, level = 3, alttext="++", cstring = "|cffffff00"},
["easy"] = { r = 0.25, g = 0.75, b = 0.25, level = 2, alttext="+", cstring = "|cff40c000"},
["trivial"]	 = { r = 0.50, g = 0.50, b = 0.50, level = 1, alttext="", cstring = "|cff808080"},
["header"] = { r = 1.00, g = 0.82, b = 0, level = 0, alttext="", cstring = "|cffffc800"},
}

local nonLinkingTrade = { [2656] = true, [53428] = true }				-- smelting, runeforging


-- Events
local AceEvent = AceLibrary("AceEvent-2.0")

-- Stack of previsouly selected skills for use by the
-- "click on reagent, go to recipe" code and for clicking on Queue'd recipes
-- stack is stack of tables: { "player", "tradeID", "skillIndex"}
local skillStack = {}
local gearTexture

-- Stolen from the Waterfall Ace2 addon.
local ControlBackdrop  = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}
local FrameBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 30, bottom = 3 }
}

-- List of functions that are called before a button is shown
local pre_show_callbacks = {}

-- List of functions that are called before a button is hidden
local pre_hide_callbacks = {}

function Skillet:internal_AddPreButtonShowCallback(method)
	assert(method and type(method) == "function",
		   "Usage: Skillet:AddPreButtonShowCallback(method). method must be a non-nil function")
	table.insert(pre_show_callbacks, method)
end

function Skillet:internal_AddPreButtonHideCallback(method)
	assert(method and type(method) == "function",
		   "Usage: Skillet:AddPreButtonHideCallback(method). method must be a non-nil function")
	table.insert(pre_hide_callbacks, method)
end

-- Figures out how to display the craftable counts for a recipe.
-- Returns: num, num_with_bank, num_with_alts
local function get_craftable_counts(skill, numMade)
	local factor = 1

	if Skillet.db.profile.show_craft_counts then
		factor = numMade or 1
	end

	local num        = math.floor((skill.numCraftable or 0) / factor)
	local numwvendor = math.floor((skill.numCraftableVendor or 0) / factor)
	local numwbank   = math.floor((skill.numCraftableBank or 0) / factor)
	local numwalts   = math.floor((skill.numCraftableAlts or 0) / factor)

	return num, numwvendor, numwbank, numwalts
end


function Skillet:CreateTradeSkillWindow()
	-- The SkilletFrame is defined in the file main_frame.xml
	local frame = SkilletFrame
	if not frame then
		return frame
	end

	if TradeJunkieMain and TJ_OpenButtonTradeSkill then
		self:AddButtonToTradeskillWindow(TJ_OpenButtonTradeSkill)
	end
	if AC_Craft and AC_UseButton and AC_ToggleButton then
		self:AddButtonToTradeskillWindow(AC_ToggleButton)
		self:AddButtonToTradeskillWindow(AC_UseButton)
	end

	frame:SetBackdrop(FrameBackdrop);
	frame:SetBackdropColor(0.1, 0.1, 0.1)

	-- A title bar stolen from the Ace2 Waterfall window.
	local r,g,b = 0, 0.7, 0; -- dark green
	local titlebar = frame:CreateTexture(nil,"BACKGROUND")
	local titlebar2 = frame:CreateTexture(nil,"BACKGROUND")

	titlebar:SetPoint("TOPLEFT",frame,"TOPLEFT",3,-4)
	titlebar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",-3,-4)
	titlebar:SetHeight(13)

	titlebar2:SetPoint("TOPLEFT",titlebar,"BOTTOMLEFT",0,0)
	titlebar2:SetPoint("TOPRIGHT",titlebar,"BOTTOMRIGHT",0,0)
	titlebar2:SetHeight(13)

	titlebar:SetGradientAlpha("VERTICAL",r*0.6,g*0.6,b*0.6,1,r,g,b,1)
	titlebar:SetTexture(r,g,b,1)
	titlebar2:SetGradientAlpha("VERTICAL",r*0.9,g*0.9,b*0.9,1,r*0.6,g*0.6,b*0.6,1)
	titlebar2:SetTexture(r,g,b,1)

	local title = CreateFrame("Frame",nil,frame)
	title:SetPoint("TOPLEFT",titlebar,"TOPLEFT",0,0)
	title:SetPoint("BOTTOMRIGHT",titlebar2,"BOTTOMRIGHT",0,0)

	local titletext = title:CreateFontString("SkilletTitleText", "OVERLAY", "GameFontNormalLarge")
	titletext:SetPoint("TOPLEFT",title,"TOPLEFT",0,0)
	titletext:SetPoint("TOPRIGHT",title,"TOPRIGHT",0,0)
	titletext:SetHeight(26)
	titletext:SetShadowColor(0,0,0)
	titletext:SetShadowOffset(1,-1)
	titletext:SetTextColor(1,1,1)
	titletext:SetText(L["Skillet Trade Skills"]);

	local label = getglobal("SkilletFilterLabel");
	label:SetText(L["Filter"]);

	SkilletCreateAllButton:SetText(L["Create All"])
	SkilletQueueAllButton:SetText(L["Queue All"])
	SkilletCreateButton:SetText(L["Create"])
	SkilletQueueButton:SetText(L["Queue"])
	SkilletStartQueueButton:SetText(L["Process"])
	SkilletEmptyQueueButton:SetText(L["Clear"])
	SkilletEnchantButton:SetText(L["Enchant"])
--	SkilletShowOptionsButton:SetText(L["Options"])
--	SkilletRescanButton:SetText(L["Rescan"])
    SkilletRecipeNotesButton:SetText(L["Notes"])
--	SkilletRecipeNotesButton:SetTextFontObject("GameFontNormalSmall")
	SkilletRecipeNotesFrameLabel:SetText(L["Notes"])
	SkilletShoppingListButton:SetText(L["Shopping List"])

--	SkilletHideUncraftableRecipesText:SetText(L["Hide uncraftable"])
--	SkilletHideTrivialRecipesText:SetText(L["Hide trivial"])

	-- Always want these visible.
	SkilletItemCountInputBox:SetText("1");
	SkilletCreateCountSlider:SetMinMaxValues(1, 20);
	SkilletCreateCountSlider:SetValue(1);
	SkilletCreateCountSlider:Show();
	SkilletCreateCountSliderThumb:Show();

	-- Progression status bar
	SkilletRankFrame:SetStatusBarColor(0.2, 0.2, 1.0, 1.0)
	SkilletRankFrameBackground:SetVertexColor(0.0, 0.0, 0.5, 0.2)


	if not SkilletRankFrame.subRanks then
		SkilletRankFrame.subRanks = {}
		SkilletRankFrame.subRanks.red = CreateFrame("StatusBar", "SkilletRankFrameRed", SkilletFrame, "SkilletRankFrameTemplate")
		SkilletRankFrame.subRanks.red:SetStatusBarColor(1.00, 0.00, 0.00, 1.00);
		SkilletRankFrame.subRanks.red:SetFrameLevel(SkilletFrame:GetFrameLevel()+8)

		SkilletRankFrame.subRanks.orange = CreateFrame("StatusBar", "SkilletRankFrameOrange", SkilletFrame, "SkilletRankFrameTemplate")
		SkilletRankFrame.subRanks.orange:SetStatusBarColor(1.00, 0.50, 0.25, 1.00);
		SkilletRankFrame.subRanks.orange:SetFrameLevel(SkilletFrame:GetFrameLevel()+7)

		SkilletRankFrame.subRanks.yellow = CreateFrame("StatusBar", "SkilletRankFrameYellow", SkilletFrame, "SkilletRankFrameTemplate")
		SkilletRankFrame.subRanks.yellow:SetStatusBarColor(1.00, 1.00, 0.00, 1.00);
		SkilletRankFrame.subRanks.yellow:SetFrameLevel(SkilletFrame:GetFrameLevel()+6)

		SkilletRankFrame.subRanks.green  = CreateFrame("StatusBar", "SkilletRankFrameGreen" , SkilletFrame, "SkilletRankFrameTemplate")
		SkilletRankFrame.subRanks.green:SetStatusBarColor(0.25, 0.75, 0.25, 1.00);
		SkilletRankFrame.subRanks.green:SetFrameLevel(SkilletFrame:GetFrameLevel()+5)

		SkilletRankFrame.subRanks.gray   = CreateFrame("StatusBar", "SkilletRankFrameGray"  , SkilletFrame, "SkilletRankFrameTemplate")
		SkilletRankFrame.subRanks.gray:SetStatusBarColor(0.50, 0.50, 0.50, 1.00);
		SkilletRankFrame.subRanks.gray:SetFrameLevel(SkilletFrame:GetFrameLevel()+4)
	end


	SkilletFrameEmptySpace = CreateFrame("Button", nil, SkilletSkillListParent, "SkilletEmptySpaceTemplate")

--	SkilletFrameEmptySpace.texture = SkilletFrameEmptySpace:CreateTexture()
--	SkilletFrameEmptySpace.texture:SetAllPoints(SkilletFrameEmptySpace)
--	SkilletFrameEmptySpace.texture:SetTexture(.5,.5,.5,.5)

	SkilletFrameEmptySpace.skill = { ["mainGroup"] = true, }

	SkilletFrameEmptySpace:SetPoint("TOPLEFT",SkilletSkillListParent,"TOPLEFT")
	SkilletFrameEmptySpace:SetPoint("BOTTOMRIGHT",SkilletSkillListParent,"BOTTOMRIGHT")

	SkilletFrameEmptySpace:Show()


	-- The frame enclosing the scroll list needs a border and a background .....
	local backdrop = SkilletSkillListParent
	backdrop:SetBackdrop(ControlBackdrop)
	backdrop:SetBackdropBorderColor(0.6, 0.6, 0.6)
	backdrop:SetBackdropColor(0.05, 0.05, 0.05)
	backdrop:SetResizable(true)

	-- Frame enclosing the reagent list
	backdrop = SkilletReagentParent
	backdrop:SetBackdrop(ControlBackdrop)
	backdrop:SetBackdropBorderColor(0.6, 0.6, 0.6)
	backdrop:SetBackdropColor(0.05, 0.05, 0.05)
	backdrop:SetResizable(true)

	-- Frame enclosing the queue
	backdrop = SkilletQueueParent
	backdrop:SetBackdrop(ControlBackdrop)
	backdrop:SetBackdropBorderColor(0.6, 0.6, 0.6)
	backdrop:SetBackdropColor(0.05, 0.05, 0.05)
	backdrop:SetResizable(true)

	-- frame enclosing the pop out notes panel
	backdrop = SkilletRecipeNotesFrame
	backdrop:SetBackdrop(ControlBackdrop)
	backdrop:SetBackdropColor(0.1, 0.1, 0.1)
	backdrop:SetBackdropBorderColor(0.6, 0.6, 0.6)
	backdrop:SetResizable(true)
	backdrop:Hide() -- initially hidden

	gearTexture = SkilletReagentParent:CreateTexture(nil, "OVERLAY")
	gearTexture:SetTexture("Interface\\Icons\\Trade_Engineering")
	gearTexture:SetHeight(16)
	gearTexture:SetWidth(16)






	-- Ace Window manager library, allows the window position (and size)
	-- to be automatically saved
	local windowManger = AceLibrary("Window-1.0")
	local tradeSkillLocation = {
		prefix = "tradeSkillLocation_"
	}
	windowManger:RegisterConfig(frame, self.db.char, tradeSkillLocation)
	windowManger:RestorePosition(frame)  -- restores scale also
	windowManger:MakeDraggable(frame)

	-- lets play the resize me game!
	local minwidth = self:GetMinSkillButtonWidth()
	if not minwidth or minwidth < SKILLET_SKILLLIST_MIN_WIDTH then					-- upped from 165
		minwidth = SKILLET_SKILLLIST_MIN_WIDTH
	end

	minwidth = minwidth +                  -- minwidth of scroll button
			   20 +                        -- padding between sroll and detail
			   SKILLET_REAGENT_MIN_WIDTH + -- reagent window (fixed width)
			   10                          -- padding about window borders

	self:EnableResize(frame, minwidth, 480, Skillet.UpdateTradeSkillWindow)

	-- Set up the sorting methods here
	self:InitializeSorting()

	self:ConfigureRecipeControls(false)				-- initial setting




	return frame
end


function Skillet:InitRecipeFilterButtons()
	local lastButton = SkilletRecipeDifficultyButton

	if self.recipeFilters then

		for name, filter in pairs(self.recipeFilters) do

			local newButton = filter.initMethod(filter.namespace)

			if newButton then
				newButton:SetParent(SkilletFrame)
				newButton:SetPoint("BOTTOMRIGHT", lastButton, "BOTTOMLEFT", -5, 0)
				lastButton = newButton

				newButton:Show()
			end
		end
	end
end


-- Resets all the sorting and filtering info for the window
-- This is called when the window has changed enough that
-- sorting or filtering may need to be updated.
function Skillet:ResetTradeSkillWindow()
	Skillet:SortDropdown_OnShow()

	-- Reset all the added buttons so that they look OK.
	local buttons = SkilletFrame.added_buttons

	if buttons then
		local last_button = SkilletPluginButton
		for i=1, #buttons, 1 do
			local button = buttons[i]
			if button then
				button:ClearAllPoints()
				button:SetParent("SkilletFrame")
				button:SetPoint("TOPLEFT", last_button, "BOTTOMLEFT", 0, -1)
				button:Hide()
				button:SetAlpha(0)
				button:SetFrameLevel(0)
				last_button = button
			end
		end
	 else
--	 	SkilletPluginButton:Hide()
	 end
end

-- Something has changed in the tradeskills, and the window needs to be updated
function Skillet:TradeSkillRank_Updated()
DebugSpam("TradeSkillRank_Updated")
	local _, rank, maxRank = self:GetTradeSkillLine();

	if rank and maxRank then
		SkilletRankFrame:SetMinMaxValues(0, maxRank);
		SkilletRankFrame:SetValue(rank);
		SkilletRankFrameSkillRank:SetText(rank.."/"..maxRank);

		for c,s in pairs(SkilletRankFrame.subRanks) do
			s:SetMinMaxValues(0, maxRank)
		end


		SkilletRankFrame.subRanks.gray:SetValue(maxRank)
	end
DebugSpam("TradeSkillRank_Updated over")
end

-- Someone dragged the slider or set the value programatically.
function Skillet:UpdateNumItemsSlider(item_count, clicked)
	local value = floor(item_count + 0.5);

	self.numItemsToCraft = value

	if SkilletCreateCountSlider:IsVisible() then
		SkilletItemCountInputBox:SetText(tostring(value))
		SkilletItemCountInputBox:HighlightText()
		if not clicked then
			SkilletCreateCountSlider:SetValue(value)
		end
	end
end

-- Called when the list of skills is scrolled
function Skillet:SkillList_OnScroll()
	Skillet:UpdateTradeSkillWindow()
end

-- Called when the list of queued items is scrolled
function Skillet:QueueList_OnScroll()
	Skillet:UpdateQueueWindow()
end

local function Skillet_redo_the_update(self)
	AceEvent:CancelScheduledEvent("Skillet_redo_the_update")
--	self:UpdateTradeSkillWindow()
end

local num_recipe_buttons = 1
local function get_recipe_button(i)
	local button = getglobal("SkilletScrollButton"..i)

	if not button then
		button = CreateFrame("Button", "SkilletScrollButton"..i, SkilletSkillListParent, "SkilletSkillButtonTemplate")
		button:SetParent(SkilletSkillListParent)
		button:SetPoint("TOPLEFT", "SkilletScrollButton"..(i-1), "BOTTOMLEFT")
		button:SetFrameLevel(SkilletSkillListParent:GetFrameLevel() + 3)

		num_recipe_buttons = i
	end

	local buttonDrag = getglobal("SkilletScrollButtonDrag"..i)
	if not buttonDrag then
		buttonDrag = CreateFrame("Frame", "SkilletScrollButtonDrag"..i, SkilletSkillListParent, "SkilletSkillButtonDragTemplate")
		buttonDrag:SetParent(SkilletSkillListParent)
		buttonDrag:SetPoint("TOPLEFT", "SkilletScrollButton"..i, "TOPLEFT")
		buttonDrag:SetFrameLevel(SkilletSkillListParent:GetFrameLevel() + 2)
		buttonDrag:Hide()
	end


	if not button.highlight then
		button.index = i

		button.highlight = CreateFrame("Frame", "SkilletScrollHightlight"..i, button)

		button.highlight:SetParent(button)
		button.highlight:SetWidth(290)
		button.highlight:SetHeight(16)
--		button.highlight:SetFrameStrata("HIGH")

		button.highlight:SetPoint("LEFT", button:GetName(), "LEFT")
		button.highlight:SetPoint("RIGHT", button:GetName(), "RIGHT")

		button:SetFrameLevel(SkilletSkillListParent:GetFrameLevel())

		local t = button.highlight:CreateTexture(nil,"ARTWORK")

		t:SetTexture("Interface\\Buttons\\UI-Listbox-Highlight2.blp")
		t:SetAllPoints(button.highlight)
		button.highlight.texture = t

		button.highlight:SetAlpha(.25)
		button.highlight:Hide()
	end

	if Skillet.customSkillButtons then
		for n, b in pairs(Skillet.customSkillButtons) do
			b.initMethod(b.namespace, button, i)
		end
	end


	return button, buttonDrag
end

-- shows a recipe button (in the scrolling list) after doing the
-- required callbacks.
local function show_button(button, trade, skill, index)
	for i=1, #pre_show_callbacks, 1 do
		local new_button = pre_show_callbacks[i](button, trade, skill, index)
		if new_button and new_button ~= button then
			button:Hide() -- hide the old one just in case ....
			button = new_button
		end
	end

	button:Show()

end

-- hides a recipe button (in the scrolling list) after doing the
-- required callbacks.
local function hide_button(button, trade, skill, index)

	-- legacy method
--    local before = Skillet:BeforeRecipeButtonHide(button, trade, skill, index)
  --  if before and before ~= button then
 --       button:Hide()
 --       button = before
 --   end

	for i=1, #pre_hide_callbacks, 1 do
		local new_button = pre_hide_callbacks[i](button, trade, skill, index)
		if new_button and new_button ~= button then
			button:Hide() -- hide the old one just in case ....
			button = new_button
		end
	end

	button:Hide()
end


function Skillet:ConfigureRecipeControls(enchant)
  -- hide UI components that cannot be used for crafts and show that
	-- that are only applicable to trade skills, as needed
	if enchant then
		SkilletQueueAllButton:Hide()
		SkilletQueueButton:Hide()
		SkilletCreateAllButton:Hide()
		SkilletCreateButton:Hide()
		SkilletCreateCountSlider:Hide()
		SkilletCreateCountSliderThumb:Hide()
		SkilletItemCountInputBox:Hide()
--        SkilletQueueParent:Hide()
		SkilletStartQueueButton:Hide()
		SkilletEmptyQueueButton:Hide()

		SkilletEnchantButton:Show();
	else
		SkilletQueueAllButton:Show()
		SkilletQueueButton:Show()
		SkilletCreateAllButton:Show()
		SkilletCreateButton:Show()
		SkilletCreateCountSlider:Show()
		SkilletCreateCountSliderThumb:Show()
		SkilletItemCountInputBox:Show()
		SkilletQueueParent:Show()
		SkilletStartQueueButton:Show()
		SkilletEmptyQueueButton:Show()

		SkilletEnchantButton:Hide()
	end

	self:InitRecipeFilterButtons()

	if self.currentPlayer ~= (UnitName("player")) then				-- only allow processing for the current player
		SkilletStartQueueButton:Disable()
		SkilletCreateAllButton:Disable()
		SkilletCreateButton:Disable()
	else
		SkilletStartQueueButton:Enable()
		SkilletCreateAllButton:Enable()
		SkilletCreateButton:Enable()
	end
end


function Skillet:PlayerSelect_OnEnter(button)
	GameTooltip:SetOwner(button, "ANCHOR_TOPLEFT")

	GameTooltip:ClearLines()

	local player = getglobal(button:GetName().."Text"):GetText()

	GameTooltip:AddLine(player,1,1,1)
	GameTooltip:AddLine("Click to select a different character",.7,.7,.7)

	GameTooltip:Show()
end


function Skillet:RecipeDifficultyButton_OnShow()
	local level = self:GetTradeSkillOption("filterLevel")

	local v = 1-level/4

	SkilletRecipeDifficultyButtonTexture:SetTexCoord(0,1,v,v+.25)

--	SkilletRecipeDifficultySelector:SetPoint("BOTTOMLEFT", "SkilletRecipeDifficultyButton", "BOTTOMLEFT", 0, -(level-1)*16)
end


function Skillet:TradeButton_OnEnter(button)
	GameTooltip:SetOwner(button, "ANCHOR_TOPLEFT")

	GameTooltip:ClearLines()

	local _, player, tradeID = string.split("-", button:GetName())

	GameTooltip:AddLine(GetSpellInfo(tradeID))

	tradeID = tonumber(tradeID)

	local data = self:GetSkillRanks(player, tradeID)

	if not data or data == "" then
		GameTooltip:AddLine(L["No Data"],1,0,0)
	else

		local rank, maxRank = string.split(" ", data)

		GameTooltip:AddLine("["..rank.."/"..maxRank.."]",0,1,0)

		if tradeID == self.currentTrade then
			GameTooltip:AddLine("shift-click to link")
		end

		local buttonIcon = getglobal(button:GetName().."Icon")
		local r,g,b = buttonIcon:GetVertexColor()

		if g == 0 then
			GameTooltip:AddLine("scan incomplete...",1,0,0)
		end

		if nonLinkingTrade[tradeID] and player ~= UnitName("player") then
			GameTooltip:AddLine((GetSpellInfo(tradeID)).." not available for alts")
		end
	end

	GameTooltip:Show()
end


function Skillet:TradeButton_OnClick(button)
	local name = button:GetName()

	local _, player, tradeID = string.split("-", name)

	tradeID = tonumber(tradeID)

	local data =  self:GetSkillRanks(player, tradeID)

	if arg1 == "LeftButton" then
		if player == UnitName("player") or (data and data ~= "") then
			if self.currentTrade == tradeID and IsShiftKeyDown() then
				local link=GetTradeSkillListLink()

				if (ChatEdit_GetLastActiveWindow():IsVisible() or WIM_EditBoxInFocus ~= nil) then
					ChatEdit_InsertLink(link)
				else
					DEFAULT_CHAT_FRAME:AddMessage(link)
				end
			end

			if player == UnitName("player") then
				self:SetTradeSkill(self.currentPlayer, tradeID)
			else
				local link = self.db.server.linkDB[player][tradeID]
				local _,_,tradeString = string.find(link, "(trade:%d+:%d+:%d+:[0-9a-fA-F]+:[a-zA-Z0-9+/]+)")

				if tradeString then
					SetItemRef(tradeString,link,"LeftButton")
				end
			end

			button:SetChecked(1)
		else
			button:SetChecked(0)
		end
	else
		if button:GetChecked() then
			if IsShiftKeyDown() then
				Skillet:FlushAllData()
				Skillet:RescanTrade(true)
			else
				Skillet:RescanTrade(true)
			end
			Skillet:UpdateTradeSkillWindow()
		end
	end

	GameTooltip:Hide()
end


function Skillet:UpdateTradeButtons(player)
	local position = 0 -- pixels
	local tradeSkillList = self.tradeSkillList

	for playerAlt in pairs(self.dataGatheringModules) do
		local frameName = "SkilletFrameTradeButtons-"..playerAlt
		local frame = getglobal(frameName)

		if frame then
			frame:Hide()

--			frame.checked:SetChecked(0)
		end
	end


	local frameName = "SkilletFrameTradeButtons-"..player
	local frame = getglobal(frameName)

	if not frame then
		frame = CreateFrame("Frame", frameName, SkilletFrame)
	end

	frame:Show()

	for i=1,#tradeSkillList,1 do					-- iterate thru all skills in defined order for neatness (professions, secondary, class skills)
		local tradeID = tradeSkillList[i]
		local ranks = self:GetSkillRanks(player, tradeID)
		local tradeLink

		if self.db.server.linkDB[player] then
			tradeLink = self.db.server.linkDB[player][tradeID]

			if nonLinkingTrade[tradeID] then
				tradeLink = nil
			end
		end


		if ranks then
			local spellName, _, spellIcon = GetSpellInfo(tradeID)

			local buttonName = "SkilletFrameTradeButton-"..player.."-"..tradeID
			local button = getglobal(buttonName)

			if not button then
				button = CreateFrame("CheckButton", buttonName, frame, "SkilletTradeButtonTemplate")
			end

			if player ~= UnitName("player") and not tradeLink then						-- fade out buttons that don't have data collected
				button:SetAlpha(.4)
				button:SetHighlightTexture("")
				button:SetPushedTexture("")
				button:SetCheckedTexture("")
			end

			button:ClearAllPoints()
			button:SetPoint("BOTTOMLEFT", SkilletRankFrame, "TOPLEFT", position, 0)

			local buttonIcon = getglobal(buttonName.."Icon")
			buttonIcon:SetTexture(spellIcon)



			position = position + button:GetWidth()

			if tradeID == self.currentTrade then
				button:SetChecked(1)

				if Skillet.data.skillList[player][tradeID].scanned then
					buttonIcon:SetVertexColor(1,1,1)
				else
					buttonIcon:SetVertexColor(1,0,0)
				end
			else
				button:SetChecked(0)
			end

			button:Show()
		end
	end

DebugSpam("UpdateTradeButtons complete")
end



function SkilletPluginDropdown_OnClick(this)
	local oldScript = this.oldButton:GetScript("OnClick")
	oldScript(this)
--DEFAULT_CHAT_FRAME:AddMessage("click")
	for i=1,#SkilletFrame.added_buttons do
		local buttonName = "SkilletPluginDropdown"..i
		local button = getglobal(buttonName)

		if button then
			button:Hide()
		end
	end
end



function Skillet:PluginButton_OnClick(button)
	if SkilletFrame.added_buttons then
		for i=1,#SkilletFrame.added_buttons do
			local oldButton = SkilletFrame.added_buttons[i]

			local buttonName = "SkilletPluginDropdown"..i
			local button = getglobal(buttonName)


			if not button then
				button = CreateFrame("button", buttonName, SkilletPluginButton, "UIPanelButtonTemplate")
				button:Hide()
			end

	--DEFAULT_CHAT_FRAME:AddMessage(buttonName)
			button:SetText(oldButton:GetText())
			button:SetWidth(100)
			button:SetHeight(22)
			button:SetFrameLevel(SkilletFrame:GetFrameLevel()+10)
			button:SetScript("OnClick", SkilletPluginDropdown_OnClick)
			button:SetPoint("TOPLEFT", 0, -i*20)

			button.oldButton = oldButton
			oldButton:Hide()

			if button:IsVisible() then
				button:Hide()
			else
				button:Show()
			end
	--DEFAULT_CHAT_FRAME:AddMessage("okay")
		end
	end
end




local updateWindowBusy = false
-- this window busy thing was something i added cuz i kept getting asynchronous updates
local updateWindowCount = 1
-- Updates the trade skill window whenever anything has changed,
-- number of skills, skill type, skill level, etc
function Skillet:internal_UpdateTradeSkillWindow()
	self:NameEditSave()

	if not self.currentPlayer or not self.currentTrade then return end


	local skillListKey = self.currentPlayer..":"..self.currentTrade..":"..self.currentGroupLabel

	if updateWindowBusy then
		return
	end


	updateWindowBusy = true

	local numTradeSkills = 0


	if not self.dataScanned then
		self.dataScanned = self:RescanTrade()

		self:SortAndFilterRecipes()
	end


	if not self.data.sortedSkillList[skillListKey] then
		numTradeSkills = self:SortAndFilterRecipes()

		if not numTradeSkills or numTradeSkills<1 then
			numTradeSkills = 0
		end
	end

	self:ResetTradeSkillWindow()


	updateWindowCount = updateWindowCount + 1


	if self.data.sortedSkillList[skillListKey] then
		numTradeSkills = self.data.sortedSkillList[skillListKey].count
	else
		numTradeSkills = 0
	end


	self:UpdateDetailsWindow(self.selectedSkill)
	self:UpdateTradeButtons(self.currentPlayer)




	if not self.currentTrade then


		-- nothing to see, nothing to update
		self:SetSelectedSkill(nil)
		self.skillMainSelection = nil

		updateWindowBusy = false
		return
	end

	SkilletFrame:SetAlpha(self.db.profile.transparency)
	SkilletFrame:SetScale(self.db.profile.scale)

	local uiScale = SkilletFrame:GetEffectiveScale()



	-- shopping list button always shown
	SkilletShoppingListButton:Show()

	local width = SkilletFrame:GetWidth() - 20 -- for padding.
	local reagent_width = width / 2
	if reagent_width < SKILLET_REAGENT_MIN_WIDTH then
		reagent_width = SKILLET_REAGENT_MIN_WIDTH
	elseif reagent_width > SKILLET_REAGENT_MAX_WIDTH then
		reagent_width = SKILLET_REAGENT_MAX_WIDTH
	end

	SkilletReagentParent:SetWidth(reagent_width)
	SkilletQueueParent:SetWidth(reagent_width)


	local width = SkilletFrame:GetWidth() - reagent_width - 20 -- padding
	SkilletSkillListParent:SetWidth(width)

	-- Set the state of any craft specific options
--	SkilletHideTrivialRecipes:SetChecked(self:GetTradeSkillOption("hidetrivial"))
	self:RecipeDifficultyButton_OnShow()
	SkilletHideUncraftableRecipes:SetChecked(self:GetTradeSkillOption("hideuncraftable"))
--	self:SortDropdown_OnShow()
--	self:RecipeGroupDropdown_OnShow()

	self:UpdateQueueWindow()

	-- Window Title
	local tradeName = self:GetTradeName(self.currentTrade)

	local title = getglobal("SkilletTitleText");
	if title then
		title:SetText(L["Skillet Trade Skills"] .. ": " .. self.currentPlayer .. "/" .. tradeName)
	end



	local sortedSkillList = self.data.sortedSkillList[skillListKey]

	-- List of all the reagents we need for all queued recipies
	-- for this player. This is used to ajust the craftable item
	-- count
--    local queued_reagents = self:GetReagentsForQueuedRecipesSkillet.currentPlayer;
	-- Tell the Stitch library about the queued items so it knows how
	-- to adjust its item counts.
--    self:SetReservedReagentsList(queued_reagents);


	local rank,maxRank = string.split(" ", self:GetSkillRanks(self.currentPlayer, self.currentTrade) or "0 0")

	rank = tonumber(rank)
	maxRank = tonumber(maxRank)


	-- Progression status bar
	SkilletRankFrame:SetMinMaxValues(0, maxRank)
	SkilletRankFrame:SetValue(rank)
	SkilletRankFrameSkillRank:SetText(tradeName.."    "..rank.."/"..maxRank)

	SkilletRankFrame.subRanks.gray:SetValue(maxRank)

	for c,s in pairs(SkilletRankFrame.subRanks) do
		s:SetMinMaxValues(0, maxRank)
	end

	SkilletPlayerSelectText:SetText(self.currentPlayer)

--    local button_count = SkilletSkillList:GetHeight() / SKILLET_TRADE_SKILL_HEIGHT
	-- it seems the resize for the main skillet window happens before the resize for the skill list box
	local button_count = (SkilletFrame:GetHeight() - 115) / SKILLET_TRADE_SKILL_HEIGHT
	button_count = math.floor(button_count)


	-- Update the scroll frame
	FauxScrollFrame_Update(SkilletSkillList,				-- frame
						   numTradeSkills,                  -- num items
						   button_count,                    -- num to display
						   SKILLET_TRADE_SKILL_HEIGHT)      -- value step (item height)



	-- Where in the list of skill to start counting.
	local skillOffset = FauxScrollFrame_GetOffset(SkilletSkillList);

	-- Remove any selected highlight, it will be added back as needed
	SkilletHighlightFrame:Hide();

	local nilFound = false
	width = SkilletSkillListParent:GetWidth() - 10
	if SkilletSkillList:IsVisible() then
		-- adjust for the width of the scroll bar, if it is visible.
		width = width - 20
	end

	local max_text_width = width


	local showBag = self:GetTradeSkillOption("filterInventory-bag")
	local showVendor = self:GetTradeSkillOption("filterInventory-vendor")
	local showBank = self:GetTradeSkillOption("filterInventory-bank")
	local showAlts = self:GetTradeSkillOption("filterInventory-alts")

	local catstring = {}


	SkilletFrameEmptySpace.skill.subGroup = self:RecipeGroupFind(self.currentPlayer,self.currentTrade,self.currentGroupLabel,self.currentGroup)

	self.visibleSkillButtons = math.min(numTradeSkills - skillOffset, button_count)


	-- Iterate through all the buttons that make up the scroll window
	-- and fill them in with data or hide them, as necessary
	for i=1, button_count, 1 do


		local rawSkillIndex = i + skillOffset

		local button, buttonDrag = get_recipe_button(i)

		button.rawIndex = rawSkillIndex

		button:SetWidth(width)

		if rawSkillIndex <= numTradeSkills then
			local skill = sortedSkillList[rawSkillIndex]

			skillIndex = skill.skillIndex

			local buttonText = getglobal(button:GetName() .. "Name")
			local levelText = getglobal(button:GetName() .. "Level")
			local countText = getglobal(button:GetName() .. "Counts")

			local buttonExpand = getglobal(button:GetName() .. "Expand")

			buttonText:SetText("")
			levelText:SetText("")
			countText:SetText("")


			countText:Hide()
			countText:SetWidth(10)

--			buttonText:SetPoint("LEFT", levelText, "RIGHT", skill.depth*8-8, 0)
			levelText:SetWidth(skill.depth*8+20)

			local textAlpha = 1

			if self.dragEngaged then
				buttonDrag:SetWidth(width)

				button.highlight:Hide()

				if Skillet.mouseOver then
					if Skillet.mouseOver.skill.subGroup then
						if button == Skillet.mouseOver then
							button.highlight:Show()
						end
					elseif skill.subGroup == Skillet.mouseOver.skill.parent then
						button.highlight:Show()
					end
				end


				textAlpha = .75

				local dx = self.selectedTextOffsetXY[1] / uiScale
				local dy = self.selectedTextOffsetXY[2] / uiScale

				buttonDrag:SetPoint("TOPLEFT", button, "TOPLEFT", buttonDrag.skill.depth*8-8+dx, dy)
			else
				if skill.selected then
					button.highlight:Show()
				else
					button.highlight:Hide()
				end
			end

--[[
			buttonExpand:SetPoint("RIGHT", levelText, "RIGHT", skill.depth*8-8, 0)
			buttonExpand:SetPoint("LEFT", levelText, "RIGHT", skill.depth*8-24, 0)

			getglobal(button:GetName() .. "ExpandNormal"):SetPoint("RIGHT", levelText, "RIGHT", skill.depth*8-8, 0)
			getglobal(button:GetName() .. "ExpandNormal"):SetPoint("LEFT", levelText, "RIGHT", skill.depth*8-24, 0)

			getglobal(button:GetName() .. "ExpandHighlight"):SetPoint("RIGHT", levelText, "RIGHT", skill.depth*8-8, 0)
			getglobal(button:GetName() .. "ExpandHighlight"):SetPoint("LEFT", levelText, "RIGHT", skill.depth*8-24, 0)
]]

			if skill.subGroup then
				if SkillButtonNameEdit.originalButton ~= buttonText then
					buttonText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, textAlpha)
					countText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, textAlpha)

					local expanded = skill.subGroup.expanded

					if expanded then
						buttonExpand:SetNormalTexture("Interface\\Addons\\Skillet\\Icons\\expand_arrow_open.tga")
						buttonExpand:SetHighlightTexture("Interface\\Addons\\Skillet\\Icons\\expand_arrow_open.tga")
					else
						buttonExpand:SetNormalTexture("Interface\\Addons\\Skillet\\Icons\\expand_arrow_closed.tga")
						buttonExpand:SetHighlightTexture("Interface\\Addons\\Skillet\\Icons\\expand_arrow_closed.tga")
					end

					local name = skill.name.." ("..#skill.subGroup.entries..")"

					buttonText:SetText(name)      -- THIS IS A HEADER SO DON'T TRY TO USE THE RECIPE ID!

					button:SetID(skillIndex or 0)
					buttonExpand.group = skill.subGroup
					button.skill = skill

					button:UnlockHighlight() -- headers never get highlighted
					buttonExpand:Show()

					local button_width = button:GetTextWidth()

--					while button_width > max_text_width - skill.depth*8 do
--						text = string.sub(text, 0, -2)
--						buttonText:SetText(text .. "..")
--						button_width = button:GetTextWidth()
--					end

					show_button(button, self.currentTrade, skillIndex, i)
				end
			else
				local recipe = self:GetRecipe(skill.recipeID)


				buttonExpand.group = nil
				button.skill = skill

				local skill_color = skill.color or skill.skillData.color or NORMAL_FONT_COLOR

				buttonText:SetTextColor(skill_color.r, skill_color.g, skill_color.b, textAlpha)
				countText:SetTextColor(skill_color.r, skill_color.g, skill_color.b, textAlpha)

				buttonExpand:Hide()
--				button:SetNormalTexture("")
--				getglobal(button:GetName() .. "Highlight"):SetTexture("")

				-- if the item has a minimum level requirement, then print that here
				if self.db.profile.display_required_level then
					local level = self:GetLevelRequiredToUse(recipe.itemID)

					if level and level > 1 then
						local _, _, rarity = GetItemInfo("item:"..recipe.itemID)
						local r, g, b = GetItemQualityColor(rarity)
						if r and g and b then
							levelText:SetTextColor(r, g, b)
						end

						levelText:SetText(level)
					end
				end

				text = (self:GetRecipeNamePrefix(self.currentTrade, skillIndex) or "") .. skill.name

				if #recipe.reagentData > 0 then

					local num, numwvendor, numwbank, numwalts = get_craftable_counts(skill.skillData, recipe.numMade)
					local cbag = "|cffffff80"
					local cvendor = "|cff80ff80"
					local cbank =  "|cffffa050"
					local calts = "|cffff80ff"


					if (num > 0 and showBag) or (numwvendor > 0 and showVendor) or (numwbank > 0 and showBank) or (numwalts > 0 and showAlts) then
	--				if num > 0 or numwvendor > 0 or numwbank > 0 or numwalts > 0 then
						local c = 1

						if showBag then
							if num >= 1000 then
								num = "##"
							end

							catstring[c] = cbag .. num
							c = c + 1
						end

						if showVendor then
							if numwvendor >= 1000 then
								numwvendor = "##"
							end

							catstring[c] = cvendor .. numwvendor
							c = c + 1
						end

						if showBank then
							if numwbank >= 1000 then
								numwbank = "##"
							end

							catstring[c] =  cbank .. numwbank
							c = c + 1
						end

						if showAlts then
							if numwalts >= 1000 then
								numwalts = "##"
							end

							catstring[c] = calts .. numwalts
							c = c + 1
						end

						local count = ""

						if c > 1 then
							count = "|cffa0a0a0["

							for b=1,c-1 do
								count = count .. catstring[b]
								if b+1 < c then
									count = count .. "|cffa0a0a0/"
								end
							end

							count = count .. "|cffa0a0a0]|r"
						end

						countText:SetText(count)
						countText:Show()
					else
						countText:Hide()
					end
				else
					countText:Hide()
				end

				local countWidth = 0

				if showBag then
					countWidth = countWidth + 20
				end

				if showBank then
					countWidth = countWidth + 20
				end

				if showVendor then
					countWidth = countWidth + 20
				end

				if showAlts then
					countWidth = countWidth + 20
				end

				if countWidth > 0 then
					countWidth = countWidth + 20
				end

				countText:SetWidth(countWidth)


				button:SetID(skillIndex or 0)

				if self.db.profile.enhanced_recipe_display then
					text = text .. skill_color.alttext;
				end

				-- If enhanced recipe display is eanbled, show the difficulty as text,
				-- rather than as a colour. This should help used that have problems
				-- distinguishing between the difficulty colours we use.

				text = text .. (self:GetRecipeNameSuffix(self.currentTrade, skillIndex) or "")

				buttonText:SetText(text)
				buttonText:SetWidth(max_text_width)

				if not self.dragEngaged and self.selectedSkill and self.selectedSkill == skillIndex then
--[[
					-- user has this skill selected
					if not self:IsCraft() then
						-- This is so mods that call GetTradeSkillSelectionIndex() will work
						-- tested with ArmorCraft.
						SelectTradeSkill(self.selectedSkill)
					end
]]
					SkilletHighlightFrame:SetPoint("TOPLEFT", "SkilletScrollButton"..i, "TOPLEFT", 0, 0)
					SkilletHighlightFrame:SetWidth(button:GetWidth())
					SkilletHighlightFrame:SetFrameLevel(button:GetFrameLevel())

					if color then
						SkilletHighlight:SetTexture(color.r, color.g, color.b, 0.4)
					else
						SkilletHighlight:SetTexture(0.7, 0.7, 0.7, 0.4)
					end

					-- And update the details for this skill, just in case something
					-- has changed (mats consumed, etc)
					self:UpdateDetailsWindow(self.selectedSkill)

					SkilletHighlightFrame:Show()
					button:LockHighlight()

				else
					-- not selected
					button:SetBackdropColor(0.8, 0.2, 0.2)
					button:UnlockHighlight()
				end

				show_button(button, self.currentTrade, skillIndex, i)
			end
		else
			-- We have no data for you Mister Button .....
			hide_button(button, self.currentTrade, skillIndex, i)
			button:UnlockHighlight()
		end
	end

	-- Hide any of the buttons that we created but don't need right now
	for i = button_count+1, num_recipe_buttons, 1 do
		local button, buttonDrag = get_recipe_button(i)
		hide_button(button, self.currentTrade, 0, i)
	end

	if self.visibleSkillButtons > 0 then
		local button = get_recipe_button(self.visibleSkillButtons)
		SkilletFrameEmptySpace:SetPoint("TOPLEFT",button,"BOTTOMLEFT")
	else
		SkilletFrameEmptySpace:SetPoint("TOPLEFT",SkilletSkillListParent,"TOPLEFT")
	end

	SkilletFrameEmptySpace:SetPoint("BOTTOMRIGHT",SkilletSkillListParent,"BOTTOMRIGHT")


--    if nilFound then
--        if not AceEvent:IsEventScheduled("Skillet_redo_the_update") then
--            AceEvent:ScheduleEvent("Skillet_redo_the_update", 0.25, self)
--        end
--    end

	updateWindowBusy = false

	DebugSpam("UPDATE OVER")
end





-- Display an action packed tooltip when we are over
-- a recipe in the list of skills
function Skillet:SkillButton_OnEnter(button)
	local id = button:GetID()
	if not id then
		return
	end


	if button.locked then return end				-- it's possible that multiple onEnters might stack ontop of each other if you scroll really quickly, this is to avoid that problem

	button.locked = true

	local b = button:GetName()

	if not b then
		button.locked = false
		return
	end


	local buttonName = getglobal(b.."Name")

	if button.skill.subGroup then			-- header
		buttonName:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		button.locked = false
		return
	end

	if self.dragEngaged then		-- dragging a skill, don't highlight other buttons
		button.locked = false
		return
	end

	local skill = button.skill

	if not skill then
		button.locked = false
		return
	end

	if self.fencePickEngaged then
		self:SkillButton_ClearSelections()
		self:SkillButton_SetSelections(self.skillMainSelection, button.rawIndex)

		self:UpdateTradeSkillWindow()
		button.locked = false
		return
	end


	buttonName:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)

	local recipe = self:GetRecipe(skill.recipeID) or skilletUnknownRecipe

	local tip = SkilletSkillTooltip

	ShoppingTooltip1:Hide()
	ShoppingTooltip2:Hide()

	if IsControlKeyDown() then
		local name, link, quality, quantity

		if recipe.itemID == 0 then
			link = GetSpellLink(skill.recipeID)
			name = GetSpellInfo(link)
			quality = nil
			quantity = nil
		else
			name,link,quality = GetItemInfo(recipe.itemID)
			quantity = recipe.numMade
		end



		tip:SetOwner(SkilletSkillListParent, "ANCHOR_NONE")
		tip:SetPoint("TOPRIGHT",SkilletSkillListParent,"TOPLEFT", -10, 0)

--		tip:ClearLines()
		tip:SetHyperlink(link)

		tip:Show()


		if EnhTooltip and EnhTooltip.TooltipCall then
--			EnhTooltip.TooltipCall(tip, name, link, quality, quantity)
		end


		if IsShiftKeyDown() then
			if recipe.itemID == 0 then
				Tooltip_ShowCompareItem(tip, GetInventoryItemLink("player", recipe.slot), "left")
			else
				Tooltip_ShowCompareItem(tip, link, "left")
			end
		end
	else
		tip:Hide()
	end

	if not self.db.profile.show_detailed_recipe_tooltip then
		-- user does not want the tooltip displayed, it can get a bit big after all
		button.locked = false
		return
	end

	SkilletTradeskillTooltip:SetOwner(button, "ANCHOR_BOTTOMRIGHT",-300);
	SkilletTradeskillTooltip:SetBackdropColor(0,0,0,1);
	SkilletTradeskillTooltip:ClearLines();
	SkilletTradeskillTooltip:SetClampedToScreen(true)

	-- Set the tooltip's scale to match that of the default UI
	local uiScale = 1.0;
	if ( GetCVar("useUiScale") == "1" ) then
		uiScale = tonumber(GetCVar("uiscale"))
	end
	SkilletTradeskillTooltip:SetScale(uiScale)

	-- Name of the recipe

	local color = skill_style_type[skill.difficulty]

	if (color) then
		SkilletTradeskillTooltip:AddLine(skill.name, color.r, color.g, color.b, 0);
	else
		SkilletTradeskillTooltip:AddLine(skill.name, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 0);
	end

	local num, numwvendor, numwbank, numwalts = get_craftable_counts(skill)

	-- how many can be created with the reagents in the inventory
	if num > 0 then
		local text = "\n" .. num .. " " .. L["can be created from reagents in your inventory"];
		SkilletTradeskillTooltip:AddLine(text, 1, 1, 1, 0); -- (text, r, g, b, wrap)
	end
	-- how many can be created with the reagent in your inv + bank
	if self.db.profile.show_bank_alt_counts and numwbank > 0 and numwbank ~= num then
		local text = numwbank .. " " .. L["can be created from reagents in your inventory and bank"];
		if num == 0 then
			text = "\n" .. text;
		end
		SkilletTradeskillTooltip:AddLine(text, 1, 1, 1, 0);	-- (text, r, g, b, wrap)
	end
	-- how many can be crafted with reagents on *all* alts, including this one.
	if self.db.profile.show_bank_alt_counts and numwalts and numwalts > 0 and numwalts ~= num then
		local text = numwalts .. " " .. L["can be created from reagents on all characters"];
		if num and numwbank == 0 then
			text = "\n" .. text;
		end
		SkilletTradeskillTooltip:AddLine(text, 1, 1, 1, 0);	-- (text, r, g, b, wrap)
	end

	SkilletTradeskillTooltip:AddLine("\n" .. self:GetReagentLabel(self.currentTrade, id));

--	local inventoryData = self.db.server.inventoryData[self.currentPlayer]

	-- now the list of regents for this recipe and some info about them

	for i=1, #recipe.reagentData, 1 do
		local reagent = recipe.reagentData[i]
		if not reagent then
			break
		end

		local numInBags, numCraftable, numInBank, numCraftableBank = self:GetInventory(self.currentPlayer, reagent.id)

		local itemName = GetItemInfo(reagent.id) or reagent.id
--		local itemName = "xxxxxxx"
		local text

		if self:VendorSellsReagent(reagent.id) then
			text = string.format("  %d x %s  |cff808080(%s)|r", reagent.numNeeded, itemName, L["buyable"])
		else
			text = string.format("  %d x %s", reagent.numNeeded, itemName)
		end

		local counts = string.format("|cff808080[%d/%d]|r", numCraftable, numCraftableBank)

--[[
		local text = "  " .. reagent.numNeeded .. " x " .. (GetItemInfo("item:"..reagent.id) or reagent.id)
		local reagent_counts = GRAY_FONT_COLOR_CODE .. " (" .. numCraftable .. " / " .. numCraftableBank

--		if reagent.numwalts then
			-- numwalts includes this character, we want only alts
--			reagent_counts = reagent_counts .. " / " .. math.max(0, reagent.numwalts - reagent.numwbank)
--		end
		reagent_counts = reagent_counts .. ")" .. FONT_COLOR_CODE_CLOSE

		if self:VendorSellsReagent(reagent.id) then
			text = text .. GRAY_FONT_COLOR_CODE .. "  (" .. L["buyable"] .. ")" .. FONT_COLOR_CODE_CLOSE;
		end
]]

		SkilletTradeskillTooltip:AddDoubleLine(text, counts, 1, 1, 1);
	end

	local text = string.format("[%s/%s]", L["reagents in inventory"], L["bank"])

	SkilletTradeskillTooltip:AddDoubleLine("\n", text)


	-- Do any mods want to add extra info about this recipe?
--	local extra_text = self:GetExtraItemDetailText(self.currentTrade, id)
--	if extra_text then
--		SkilletTradeskillTooltip:AddLine("\n" .. extra_text)
--	end

	SkilletTradeskillTooltip:Show();

	button.locked = false
end

-- Sets the game tooltip item to the selected skill
function Skillet:SetTradeSkillToolTip(skillIndex)
	GameTooltip:ClearLines()

	local recipe, recipeID = self:GetRecipeDataByTradeIndex(self.currentTrade, skillIndex)

	if recipe then
		if recipe.itemID ~= 0 then
			GameTooltip:SetHyperlink("item:"..recipe.itemID)			-- creates an item, that's more interesting than the recipe

			if EnhTooltip and EnhTooltip.TooltipCall then
				local name, link, quality = GetItemInfo("item:"..recipe.itemID)

				quantity = recipe.numMade

				EnhTooltip.TooltipCall(GameTooltip, name, link, quality, quantity)
			end

			if IsShiftKeyDown() then
				GameTooltip_ShowCompareItem()
			end
		else
			GameTooltip:SetHyperlink("enchant:"..recipe.spellID)				-- doesn't create an item, just tell us about the recipe

			if IsShiftKeyDown() then
				Tooltip_ShowCompareItem(GameTooltip, GetInventoryItemLink("player", recipe.slot), "left")
			end
		end
	end
end


function Skillet:SetReagentToolTip(reagentID, numNeeded, numCraftable)
	GameTooltip:ClearLines()

	GameTooltip:SetHyperlink("item:"..reagentID)

	if EnhTooltip and EnhTooltip.TooltipCall then
		local name, link, quality = GetItemInfo("item:"..reagentID)

		EnhTooltip.TooltipCall(GameTooltip, name, link, quality, numNeeded)
	end

	if self:VendorSellsReagent(reagentID) then
		GameTooltip:AppendText(GRAY_FONT_COLOR_CODE .. " (" .. L["buyable"] .. ")" .. FONT_COLOR_CODE_CLOSE)
	end


	if self.data.itemRecipeSource[reagentID] then
		GameTooltip:AppendText(GRAY_FONT_COLOR_CODE .. " (" .. L["craftable"] .. ")" .. FONT_COLOR_CODE_CLOSE)

		for recipeID in pairs(self.data.itemRecipeSource[reagentID]) do
			local recipe = self:GetRecipe(recipeID)
			--self.db.account.recipeData[self.db.account.itemRecipeSource[reagentID][i]]

			GameTooltip:AddDoubleLine("Source: ",(self:GetTradeName(recipe.tradeID) or recipe.tradeID)..":"..self:GetRecipeName(recipeID),0,1,0,1,1,1)

			for player,lookupTable in pairs(self.data.skillIndexLookup) do
				if lookupTable[recipeID] then
					local rankData = self:GetSkillRanks(player, recipe.tradeID)

					if rankData then
						local rank, maxRank = string.split(" ", rankData)

						GameTooltip:AddDoubleLine("  "..player,"["..(rank or "?").."/"..(maxRank or "?").."]",1,1,1)
					else
						GameTooltip:AddDoubleLine("  "..player,"[???/???]",1,1,1)
					end
				end
			end
		end
	end

--	local recipe = self:GetRecipe(recipeID)
	local _, inBags, _, inBank = self:GetInventory(self.currentPlayer, reagentID)

--	self.db.server.inventoryData[self.currentPlayer][reagentID].numCraftableBank
	local surplus = inBank - numNeeded * numCraftable

	if inBank < 0 then
		GameTooltip:AddDoubleLine("in shopping list:",(-inBank),1,1,0)
	end

	if surplus < 0 then
		GameTooltip:AddDoubleLine("to craft "..numCraftable.." you need:",(-surplus),1,0,0)
	end


	if self.db.server.reagentsInQueue[self.currentPlayer] then
		local inQueue = self.db.server.reagentsInQueue[self.currentPlayer][reagentID]

		if inQueue then
			if inQueue < 0 then
				GameTooltip:AddDoubleLine("used in queued skills:",-inQueue,1,1,1)
			else
				GameTooltip:AddDoubleLine("created from queued skills:",inQueue,1,1,1)
			end
		end
	end


end


local bopCache = {}
local function bopCheck(item)

	if bopCache[item] == 1 then
		return true
	end

	if bopCache[item] == 0 then
		return false
	end

	local _,link = GetItemInfo(item)
--	if name then
		local tooltip = getglobal("SkilletParsingTooltip")

		if tooltip == nil then
			tooltip = CreateFrame("GameTooltip", "SkilletParsingTooltip", getglobal("ANCHOR_NONE"), "GameTooltipTemplate")
			tooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
		end

		tooltip:SetHyperlink("item:"..item)

--tooltip:SetOwner(SkilletSkillListParent, "ANCHOR_NONE")
--tooltip:SetPoint("TOPRIGHT",SkilletSkillListParent,"TOPLEFT", -10, 0)
--tooltip:Show()

		local tiplines = tooltip:NumLines()
--DEFAULT_CHAT_FRAME:AddMessage((link or "nil"))

		for i=1, tiplines, 1 do
			local lineText = string.lower(getglobal("SkilletParsingTooltipTextLeft"..i):GetText() or " ")
--DEFAULT_CHAT_FRAME:AddMessage(lineText)

			if (string.find(lineText, "binds when picked up")) then
				bopCache[item] = 1
--DEFAULT_CHAT_FRAME:AddMessage("bop")
				return true
			end
		end

		bopCache[item] = 0
--		DEFAULT_CHAT_FRAME:AddMessage("boe")
--	end
end


local lastDetailUpdate = 0
local lastUpdateSpellID = nil
local ARLProfessionInitialized = {}
-- Updates the details window with information about the currently selected skill
function Skillet:UpdateDetailsWindow(skillIndex)
	if not skillIndex or skillIndex < 0 then
		SkilletSkillName:SetText("")
		SkilletSkillCooldown:SetText("")
		SkilletRequirementLabel:Hide()
		SkilletRequirementText:SetText("")
		SkilletSkillIcon:Hide()
		SkilletReagentLabel:Hide()
		SkilletRecipeNotesButton:Hide()
		SkilletPreviousItemButton:Hide()
		SkilletExtraDetailTextLeft:Hide()
		SkilletExtraDetailTextRight:Hide()

		SkilletHighlightFrame:Hide()
		SkilletFrame.selectedSkill = -1;

		-- Always want these set.
		SkilletItemCountInputBox:SetText("1");
		SkilletCreateCountSlider:SetMinMaxValues(1, 20);
		SkilletCreateCountSlider:SetValue(1);

		for i=1, SKILLET_NUM_REAGENT_BUTTONS, 1 do
			local button = getglobal("SkilletReagent"..i)
			button:Hide();
		end

		for c,s in pairs(SkilletRankFrame.subRanks) do
			s:Hide()
		end

		return
	end

	local texture;
	SkilletFrame.selectedSkill = skillIndex;
	self.numItemsToCraft = 1;

	if self.recipeNotesFrame then
		self.recipeNotesFrame:Hide()
	end

	local skill = self:GetSkill(self.currentPlayer, self.currentTrade, skillIndex)

--	if skill.id == lastUpdateSpellID then return end

	lastUpdateSpellID = skill.id

	local recipe = skilletUnknownRecipe

	if not skill then return end

	if skill then
		recipe = self:GetRecipe(skill.id) or skilletUnknownRecipe
	-- Name of the skill
		SkilletSkillName:SetText(recipe.name)
		SkilletRecipeNotesButton:Show()

		if recipe.spellID then
			local orange,yellow,green,gray = self:GetTradeSkillLevels((recipe.itemID>0 and recipe.itemID) or -recipe.spellID)			-- was spellID now is itemID or -spellID

			SkilletRankFrame.subRanks.green:SetValue(gray)
			SkilletRankFrame.subRanks.yellow:SetValue(green)
			SkilletRankFrame.subRanks.orange:SetValue(yellow)
			SkilletRankFrame.subRanks.red:SetValue(orange)

			for c,s in pairs(SkilletRankFrame.subRanks) do
				s:Show()
			end
		end


		-- Whether or not it is in cooldown.
		local cooldown = 0

		cooldown = (skill.cooldown or 0) - time()

		if cooldown > 0 then
			SkilletSkillCooldown:SetText(COOLDOWN_REMAINING.." "..SecondsToTime(cooldown))
		else
			SkilletSkillCooldown:SetText("")
		end

	else
		recipe = skilletUnknownRecipe
		SkilletSkillName:SetText("unknown")
	end



	-- Are special tools needed for this skill?
	if recipe.tools then
		local toolList = {}

		for i=1,#recipe.tools do
--DEFAULT_CHAT_FRAME:AddMessage("tool: "..(recipe.tools[i] or "nil"))
			toolList[i*2-1] = recipe.tools[i]

			if skill.tools then
--DEFAULT_CHAT_FRAME:AddMessage("arg: "..(skill.tools[i] or "nil"))
				toolList[i*2] = skill.tools[i]
			else
				toolList[i*2] = 1
			end

		end

		SkilletRequirementText:SetText(BuildColoredListString(unpack(toolList)))
		SkilletRequirementText:Show()
		SkilletRequirementLabel:Show()
	else
		SkilletRequirementText:Hide()
		SkilletRequirementLabel:Hide()
	end



	if recipe.itemID ~= 0 then
		texture = GetItemIcon(recipe.itemID)
	else
		texture = "Interface\\Icons\\Spell_Holy_GreaterHeal"		-- standard enchant icon
	end

	SkilletSkillIcon:SetNormalTexture(texture)
	SkilletSkillIcon:Show()

	-- How many of these items are produced at one time ..
	if recipe.numMade > 1 then
		SkilletSkillIconCount:SetText(recipe.numMade)
		SkilletSkillIconCount:Show()
	else
		SkilletSkillIconCount:SetText("")
		SkilletSkillIconCount:Hide()
	end

	-- How many can we queue/create?
	SkilletCreateCountSlider:SetMinMaxValues(1, math.max(20, (skill.numCraftableBank or 0))) -- s.numcraftablewbank));
	SkilletCreateCountSlider:SetValue(self.numItemsToCraft);
	SkilletItemCountInputBox:SetText("" .. self.numItemsToCraft);
	SkilletItemCountInputBox:HighlightText()
	SkilletCreateCountSlider.tooltipText = L["Number of items to queue/create"];

	-- Reagents required ...
	SkilletReagentLabel:SetText(self:GetReagentLabel(SkilletFrame.selectedSkill));
	SkilletReagentLabel:Show();

	local width = SkilletReagentParent:GetWidth()
	local lastReagentButton

	for i=1, SKILLET_NUM_REAGENT_BUTTONS, 1 do
		local button = getglobal("SkilletReagent"..i)
		local   text = getglobal(button:GetName() .. "Text")
		local   icon = getglobal(button:GetName() .. "Icon")
		local  count = getglobal(button:GetName() .. "Count")
		local needed = getglobal(button:GetName() .. "Needed")

		local reagent = recipe.reagentData[i]

		if reagent then
			local reagentName

			if reagent.id then
				reagentName	= GetItemInfo("item:"..reagent.id) or reagent.id
			else
				reagentName = "unknown"
			end

			local numAlts = nil
			local _, num, _, numBank = self:GetInventory(self.currentPlayer, reagent.id)
--[[
			local num = 0
			local numBank = 0

			local invData = self.db.server.inventoryData[Skillet.currentPlayer]

			if invData then
				invData = invData[reagent.id]

				if invData then
					num = invData.numCraftable
					numBank = invData.numCraftableBank
					numAlts = invData.numCraftableAlts
				end
			end
]]
			local count_text

			if numAlts then
				count_text = string.format("[%d/%d/%d]", num, numBank, numAlts)
			else
				count_text = string.format("[%d/%d]", num, numBank)
			end

			if numBank < reagent.numNeeded then
				-- grey it out if we don't have it
				count:SetText(GRAY_FONT_COLOR_CODE .. count_text .. FONT_COLOR_CODE_CLOSE)
				text:SetText(GRAY_FONT_COLOR_CODE .. reagentName .. FONT_COLOR_CODE_CLOSE)

				if self:VendorSellsReagent(reagent.id) then
					needed:SetTextColor(0,1,0)
				else
					needed:SetTextColor(1,0,0)
				end
			else
				-- ungrey it
				count:SetText(count_text)
				text:SetText(reagentName)
				needed:SetTextColor(1,1,1)
			end

			texture = GetItemIcon(reagent.id)

			icon:SetNormalTexture(texture)
			needed:SetText(reagent.numNeeded.."x")

			button:SetWidth(width - 20)
			button:Show()

			lastReagentButton = button
		else
--			icon:SetNormalTexture(texture)
--			button:Show()
			-- out of necessary reagents, don't need to show the button,
			-- or any or the text.
			button:Hide()
		end

	end

	if #skillStack > 0 then
		SkilletPreviousItemButton:Show()
	else
		SkilletPreviousItemButton:Hide()
	end

	-- Do any mods want to add extra info to the details window?
--	local extra_text = self:GetExtraItemDetailText(self.currentTrade, skillIndex)

	local extra_text
	local bop


	if AckisRecipeList and AckisRecipeList.InitRecipeData then
		local _, recipeList, mobList, trainerList = AckisRecipeList:InitRecipeData()

		local recipeData = AckisRecipeList:GetRecipeData(skill.id)

		if recipeData == nil and not ARLProfessionInitialized[recipe.tradeID] then
			ARLProfessionInitialized[recipe.tradeID] = true

			local profession = GetSpellInfo(recipe.tradeID)

			AckisRecipeList:AddRecipeData(profession)

			recipeData = AckisRecipeList:GetRecipeData(skill.id)
		end


		if recipeData then
			extra_text = AckisRecipeList:GetRecipeLocations(skill.id)

--DEFAULT_CHAT_FRAME:AddMessage("ARL Data "..(extra_text or "nil"))

			if extra_text == "" then extra_text = nil end
		end
	end

	if TradeskillInfo and not extra_text then
-- tsi uses itemIDs for skill indices instead of enchantID numbers.  for enchants, the enchantID is negated to avoid overlaps
		local tsiRecipeID = recipe.itemID

		if tsiRecipeID == 0 and recipe.spellID then
			tsiRecipeID = -recipe.spellID
		elseif tsiRecipeID then
			tsiRecipeID = TradeskillInfo:MakeSpecialCase(tsiRecipeID, recipe.name)
		end

		if tsiRecipeID then
			local combineID = TradeskillInfo:GetCombineRecipe(tsiRecipeID)


			if combineID then
				_, extra_text = self:TSIGetRecipeSources(combineID, false)

				if not extra_text then
					extra_text = "Trained ("..(TradeskillInfo:GetCombineLevel(tsiRecipeID) or "??")..")"
				end

					--		SkilletExtraDetailText.dataSource = "TradeSkillInfo Mod - version "..(TradeskillInfo.version or "?")
--				local _, link = GetItemInfo(combineID)
--DEFAULT_CHAT_FRAME:AddMessage("recipe: "..(link or combineID))
				if bopCheck(combineID) then
					bop = true
				end

			else
				extra_text = "|cffff0000Unknown|r"
			end

		else
			extra_text = "can't find recipeID for item "..recipe.itemID
		end
	end
--DEFAULT_CHAT_FRAME:AddMessage(extra_text or "nil")

	if extra_text then
		SkilletExtraDetailTextLeft:SetPoint("TOPLEFT",lastReagentButton,"BOTTOMLEFT",0,-10)

		if bop then
			SkilletExtraDetailTextLeft:SetText(GRAY_FONT_COLOR_CODE.."Source:\n|cffff0000(*BOP*)|r")
		else
			SkilletExtraDetailTextLeft:SetText(GRAY_FONT_COLOR_CODE.."Source:")
		end

		SkilletExtraDetailTextLeft:Show()

		SkilletExtraDetailTextRight:SetPoint("TOPLEFT",lastReagentButton,"BOTTOMLEFT",50,-10)
		SkilletExtraDetailTextRight:SetText(extra_text)
		SkilletExtraDetailTextRight:Show()
	else
		SkilletExtraDetailTextRight:Hide()
		SkilletExtraDetailTextLeft:Hide()
	end
--DEFAULT_CHAT_FRAME:AddMessage("?")

	lastDetailUpdate = GetTime()
end





local num_queue_buttons = 0
local function get_queue_button(i)
	local button = getglobal("SkilletQueueButton"..i)
	if not button then
		button = CreateFrame("Button", "SkilletQueueButton"..i, SkilletQueueParent, "SkilletQueueItemButtonTemplate")
		button:SetParent(SkilletQueueParent)
		button:SetPoint("TOPLEFT", "SkilletQueueButton"..(i-1), "BOTTOMLEFT")
		button:SetFrameLevel(SkilletQueueParent:GetFrameLevel() + 1)
	end
	return button
end



function Skillet:QueueItemButton_OnClick(button)
	local queue = self.db.server.queueData[self.currentPlayer]

	local index = button:GetID()

	local recipeID = queue[index].recipeID

	local recipe = self:GetRecipe(recipeID)
	--self.db.account.recipeData[recipeID]

	local tradeID = recipe.tradeID

	local newSkillIndex = self.data.skillIndexLookup[self.currentPlayer][recipeID]

DebugSpam("selecting new skill "..tradeID..":"..(newSkillIndex or "nil"))
--	self:PushSkill(Skillet.currentPlayer, self.currentTrade, self.selectedSkill)			-- push the current skill or no?

	self:SetTradeSkill(self.currentPlayer, tradeID, newSkillIndex)
DebugSpam("done selecting new skill")
end


-- Updates the window/scroll list displaying queue of items
-- that are waiting to be crafted.
function Skillet:UpdateQueueWindow()
	local queue = self.db.server.queueData[self.currentPlayer]
	if not queue then
		SkilletStartQueueButton:SetText(L["Process"])
		SkilletEmptyQueueButton:Disable()
		SkilletStartQueueButton:Disable()
		return
	end

	local numItems = #queue

	if numItems > 0 then
		SkilletStartQueueButton:Enable()
		SkilletEmptyQueueButton:Enable()
	else
		SkilletStartQueueButton:Disable()
		SkilletEmptyQueueButton:Disable()
	end

	if self.queuecasting and UnitCastingInfo("player") then
		SkilletStartQueueButton:SetText(L["Pause"])
	else
		SkilletStartQueueButton:SetText(L["Process"])
	end

	local button_count = SkilletQueueList:GetHeight() / SKILLET_TRADE_SKILL_HEIGHT
	button_count = math.floor(button_count)

	-- Update the scroll frame
	FauxScrollFrame_Update(SkilletQueueList,				-- frame
						   numItems,                        -- num items
						   button_count,                    -- num to display
						   SKILLET_TRADE_SKILL_HEIGHT)      -- value step (item height)

	-- Where in the list of skill to start counting.
	local itemOffset = FauxScrollFrame_GetOffset(SkilletQueueList)

	local width = SkilletQueueList:GetWidth()

	-- Iterate through all the buttons that make up the scroll window
	-- and fill then in with data or hide them, as necessary
	for i=1, button_count, 1 do
		local itemIndex = i + itemOffset
		num_queue_buttons = math.max(num_queue_buttons, i)

		local button       = get_queue_button(i)
		local countFrame   = getglobal(button:GetName() .. "Count")
		local queueCount   = getglobal(button:GetName() .. "CountText")
		local nameButton   = getglobal(button:GetName() .. "Name")
		local queueName    = getglobal(button:GetName() .. "NameText")
		local deleteButton = getglobal(button:GetName() .. "DeleteButton")

		button:SetWidth(width)

		-- Stick this on top of the button we use for displaying queue contents.
		deleteButton:SetFrameLevel(button:GetFrameLevel() + 1)

		local fixed_width = countFrame:GetWidth() + deleteButton:GetWidth()
		fixed_width = width - fixed_width - 10 -- 10 for the padding between items

		queueName:SetWidth(fixed_width);
		nameButton:SetWidth(fixed_width);

		if itemIndex <= numItems then

			deleteButton:SetID(itemIndex)
			nameButton:SetID(itemIndex)

			local queueCommand = queue[itemIndex]

			if queueCommand then
				local recipe = self:GetRecipe(queueCommand.recipeID)
				--self.db.account.recipeData[queueCommand.recipeID]

				queueName:SetText((self:GetTradeName(recipe.tradeID) or recipe.tradeID)..":"..(recipe.name or recipeID))
				queueCount:SetText(queueCommand.count)
			end

			nameButton:Show()
			queueName:Show()
			countFrame:Show()
			queueCount:Show()
			button:Show()

		else
			button:Hide()
			queueName:Hide()
			queueCount:Hide()
		end
	end

	-- Hide any of the buttons that we created, but don't need right now
	for i = button_count+1, num_queue_buttons, 1 do
	   local button = get_queue_button(i)
	   button:Hide()
	end
end


function Skillet:SkillButton_SetSelections(id1, id2)
	local skillListKey = self.currentPlayer..":"..self.currentTrade..":"..self.currentGroupLabel
	local sortedSkillList = self.data.sortedSkillList[skillListKey]

	if id1 > id2 then id1,id2 = id2,id1 end

	for i=1,sortedSkillList.count do
		if i>=id1 and i<=id2 then
			sortedSkillList[i].selected = true
		else
			sortedSkillList[i].selected = false
		end
	end
end


function Skillet:SkillButton_SetAllSelections(toggle)
	local skillListKey = self.currentPlayer..":"..self.currentTrade..":"..self.currentGroupLabel
	local sortedSkillList = self.data.sortedSkillList[skillListKey]

	for i=1,sortedSkillList.count do
		sortedSkillList[i].selected = toggle
	end
end


function Skillet:SkillButton_ClearSelections()
	self:SkillButton_SetAllSelections(false)
end


function Skillet:NameEditSave()
	if SkillButtonNameEdit:IsVisible() and SkillButtonNameEdit.originalButton then
		SkillButtonNameEdit.originalButton:SetText(SkillButtonNameEdit:GetText())
		self:RecipeGroupRenameEntry(SkillButtonNameEdit.skill, SkillButtonNameEdit:GetText())
	end

	SkillButtonNameEdit:ClearFocus()
end


function Skillet:SkillButton_OnMouseDown(button)
	self.dragStartXY = { GetCursorPosition() }
	self.selectedTextOffsetXY = { 0, 0 }
end


function Skillet:SkillButton_OnMouseUp(button)
--DEFAULT_CHAT_FRAME:AddMessage("up")
end


function Skillet:SkillButton_DragUpdate()
	if self.dragEngaged then
		local x,y = GetCursorPosition()

		self.selectedTextOffsetXY[1] = x - self.dragStartXY[1]
		self.selectedTextOffsetXY[2] = y - self.dragStartXY[2]

		self:UpdateTradeSkillWindow()
	end
end




function Skillet:SkillButton_OnDragStop(button, mouse)
--	self.dragSkill = nil

--	if Skillet.mouseOver then
		Skillet:SkillButton_OnReceiveDrag(Skillet.mouseOver, mouse)
--	end

	for i=1,num_recipe_buttons do
		local button, buttonDrag = get_recipe_button(i)

		buttonDrag:Hide()
	end

	self.dragEngaged = false
	self.fencePickEngaged = false
	self:UpdateTradeSkillWindow()
end


function Skillet:SkillButton_OnDragStart(button, mouse)
	local skill = button.skill

	if skill.selected and skill then
		if not self:RecipeGroupIsLocked() then
--			self.dragStartXY = { GetCursorPosition() }
--			self.selectedTextOffsetXY = { 0, 0 }


			for i=1,self.visibleSkillButtons do
				local button, buttonDrag = get_recipe_button(i)
				local buttonText = getglobal(button:GetName().."Name")
				local buttonDragText = getglobal(buttonDrag:GetName().."Name")

				buttonDrag.skill = button.skill

				local r,g,b = buttonText:GetTextColor()

				buttonDragText:SetText(buttonText:GetText())
				buttonDragText:SetTextColor(r,g,b,.4)

				if button.skill and button.skill.selected then
					buttonDrag:Show()
				else
					buttonDrag:Hide()
				end
			end

			self.dragEngaged = true
			self.fencePickEngaged = false
		end
	else
		self.skillMainSelection = button.rawIndex
		self:SetSelectedSkill(button:GetID())

		self.dragEngaged = false
		self.fencePickEngaged = true

		if skill then skill.selected = true end
	end

	self:UpdateTradeSkillWindow()
end


function Skillet:SkillButton_OnReceiveDrag(button, mouse)
	if not self:RecipeGroupIsLocked() then
		local skill = nil
		local destinationGroup = nil

		if button then
			skill = button.skill

			if skill.subGroup then
				destinationGroup = button.skill.subGroup
			else
				if skill.parent ~= nil then
					destinationGroup = skill.parent
				else
					destinationGroup = skill
				end
			end
		else
			destinationGroup = self:RecipeGroupFind(self.currentPlayer, self.currentTrade, self.currentGroupLabel)
		end


		if self.dragEngaged and (skill == nil or not skill.selected) then

			local skillListKey = self.currentPlayer..":"..self.currentTrade..":"..self.currentGroupLabel
			local sortedSkillList = self.data.sortedSkillList[skillListKey]

			for i=1,sortedSkillList.count do
				if sortedSkillList[i].selected then
					self:RecipeGroupMoveEntry(sortedSkillList[i], destinationGroup)
				end
			end

			self.dragEngaged = false

			self:SortAndFilterRecipes()
			self:UpdateTradeSkillWindow()
		end
	end
end


local skillListCopyBuffer = {}
function Skillet:SkillButton_CopySelected()
	local skillListKey = self.currentPlayer..":"..self.currentTrade..":"..self.currentGroupLabel
	local sortedSkillList = self.data.sortedSkillList[skillListKey]

	skillListCopyBuffer[self.currentTrade] = {}

	local d = 1
	for i=1,sortedSkillList.count do
		if sortedSkillList[i].selected and not (sortedSkillList[i].parentIndex and sortedSkillList[sortedSkillList[i].parentIndex].selected) then
			skillListCopyBuffer[self.currentTrade][d] = sortedSkillList[i]
--DEFAULT_CHAT_FRAME:AddMessage("copying "..(sortedSkillList[i].name or "nil"))
			d = d + 1
		end
	end
end

function Skillet:SkillButton_PasteSelected(button)
	if not self:RecipeGroupIsLocked() then
--		local parentGroup = self:RecipeGroupFind(self.currentPlayer, self.currentTrade, self.currentGroupLabel, self.currentGroup)
		local parentGroup

		if button then
			parentGroup = button.skill.subGroup or button.skill.parent
		else
			parentGroup = self:RecipeGroupFind(self.currentPlayer, self.currentTrade, self.currentGroupLabel, self.currentGroup)
		end

		if skillListCopyBuffer[self.currentTrade] then
			for d=1,#skillListCopyBuffer[self.currentTrade] do
--DEFAULT_CHAT_FRAME:AddMessage("pasting "..(skillListCopyBuffer[self.currentTrade][d].name or "nil").." to "..parentGroup.name)
				self:RecipeGroupPasteEntry(skillListCopyBuffer[self.currentTrade][d], parentGroup)
			end
		end

		self:SortAndFilterRecipes()
	end
end



function Skillet:SkillButton_DeleteSelected()
	if not self:RecipeGroupIsLocked() then
		local skillListKey = self.currentPlayer..":"..self.currentTrade..":"..self.currentGroupLabel
		local sortedSkillList = self.data.sortedSkillList[skillListKey]

		for i=1,sortedSkillList.count do
			if sortedSkillList[i].selected and not (sortedSkillList[i].parent and sortedSkillList[i].parent.selected) then
				self:RecipeGroupDeleteEntry(sortedSkillList[i], newGroup)
			end
		end

		self.selectedSkill = nil

		self:RecipeGroupAddSubGroup(parentGroup, newGroup, index)

		self:SortAndFilterRecipes()
		self:UpdateTradeSkillWindow()
	end
end




function Skillet:SkillButton_NewGroup()
	if not self:RecipeGroupIsLocked() then
		local player = self.currentPlayer
		local tradeID = self.currentTrade
		local label = self.currentGroupLabel

		local name, index = self:RecipeGroupNewName(player..":"..tradeID..":"..label, "New Group")

		local newGroup = self:RecipeGroupNew(player, tradeID, label, name)

		local parentGroup = self:RecipeGroupFind(player, tradeID, label, self.currentGroup)

		self:RecipeGroupAddSubGroup(parentGroup, newGroup, index)

		self:SortAndFilterRecipes()
		self:UpdateTradeSkillWindow()
	end
end


function Skillet:SkillButton_MakeGroup()
	if not self:RecipeGroupIsLocked() then
		local player = self.currentPlayer
		local tradeID = self.currentTrade
		local label = self.currentGroupLabel

		local name, index = self:RecipeGroupNewName(player..":"..tradeID..":"..label, "New Group")

		local newGroup = self:RecipeGroupNew(player, tradeID, label, name)

		local parentGroup = self:RecipeGroupFind(player, tradeID, label, self.currentGroup)

		local skillListKey = self.currentPlayer..":"..self.currentTrade..":"..self.currentGroupLabel
		local sortedSkillList = self.data.sortedSkillList[skillListKey]

		for i=1,sortedSkillList.count do
			if sortedSkillList[i].selected and not (sortedSkillList[i].parent and sortedSkillList[i].parent.selected) then
				self:RecipeGroupMoveEntry(sortedSkillList[i], newGroup)
			end
		end

		self:RecipeGroupAddSubGroup(parentGroup, newGroup, index)

		self:SortAndFilterRecipes()
		self:UpdateTradeSkillWindow()
	end
end


function Skillet:SkillButton_OnKeyDown(button, key)
--DEFAULT_CHAT_FRAME:AddMessage(key)
	if key == "D" then
		self:SkillButton_SetAllSelections(false)
	elseif key == "A" then
		self:SkillButton_SetAllSelections(true)
	elseif key == "C" then
		self:SkillButton_CopySelected()
	elseif key == "X" then
		self:SkillButton_CopySelected()
		self:SkillButton_DeleteSelected()
	elseif key == "V" then
		self:SkillButton_PasteSelected(self.mouseOver)
	elseif key == "DELETE" or key == "BACKSPACE" then
		self:SkillButton_DeleteSelected()
	elseif key == "N" then
		self:SkillButton_NewGroup()
	elseif key == "G" then
		self:SkillButton_MakeGroup()
	else
		return
	end

	self:UpdateTradeSkillWindow()
end



function Skillet:SkillButton_NameEditEnable(button)
	if not self:RecipeGroupIsLocked() then
		SkillButtonNameEdit:SetText(button.skill.name)
		SkillButtonNameEdit:SetParent(button:GetParent())

		local buttonText = getglobal(button:GetName().."Name")

		local numPoints = button:GetNumPoints()

		for p=1,numPoints do
			SkillButtonNameEdit:SetPoint(buttonText:GetPoint(p))
		end

		SkillButtonNameEdit.originalButton = buttonText
		SkillButtonNameEdit.skill = button.skill

		SkillButtonNameEdit:Show()
		buttonText:Hide()

		button:UnregisterEvent("MODIFIER_STATE_CHANGED")
	end
end



local lastClick = 0
-- When one of the skill buttons in the left scroll pane is clicked
function Skillet:SkillButton_OnClick(button, mouse)
	if (mouse=="LeftButton") then
		local doubleClicked = false
		local thisClick = GetTime()
		local delay = thisClick - lastClick

		lastClick = thisClick

		if delay < .25 then
			doubleClicked = true
		end


		if doubleClicked then
			if button.skill.subGroup then
				if button.skill.mainGroup or self.currentGroup == button.skill.name then
					self.currentGroup = nil
					Skillet:SetTradeSkillOption("group", nil)
					button.skill.subGroup.expanded = true
				else
					self.currentGroup = button.skill.name
					Skillet:SetTradeSkillOption("group", button.skill.name)
					button.skill.subGroup.expanded = true
				end

				self:SortAndFilterRecipes()
			else
				local recipe = self:GetRecipe(button.skill.recipeID)
				local spellLink = GetSpellLink(recipe.spellID)

				if (ChatEdit_GetLastActiveWindow():IsVisible() or WIM_EditBoxInFocus ~= nil) then
					ChatEdit_InsertLink(spellLink)
				else
					DEFAULT_CHAT_FRAME:AddMessage(spellLink)
				end
			end
		elseif not button.skill.mainGroup then
			if IsShiftKeyDown() and self.skillMainSelection then
				self:SkillButton_ClearSelections()
				self:SkillButton_SetSelections(self.skillMainSelection, button.rawIndex)
			else
				if not IsControlKeyDown() then
					if not button.skill.subGroup then
						if not button.skill.selected then
							self:SkillButton_ClearSelections()
						end

						self:SetSelectedSkill(button:GetID(), true)
						button.skill.selected = true
					else
						if button.skill.selected and not self:RecipeGroupIsLocked() then
							self:SkillButton_NameEditEnable(button)

							return			-- avoid window update
						else
							self:SkillButton_ClearSelections()

							self.selectedSkill = nil
							button.skill.selected = true
						end
					end

					self.skillMainSelection = button.rawIndex
				else
					button.skill.selected = not button.skill.selected
				end
			end
		end

		self:UpdateTradeSkillWindow()
	elseif (mouse=="RightButton") then

		self:SkilletSkillMenu_Show(this)
--		self:UpdateTradeSkillWindow()
	end
end

-- When one of the skill buttons in the left scroll pane is clicked
function Skillet:SkillExpandButton_OnClick(button, mouse, doubleClicked)
	if (mouse=="LeftButton") then
		if button.group then
			button.group.expanded = not button.group.expanded

			self:SortAndFilterRecipes()

			self:UpdateTradeSkillWindow()
		end
	end
end

-- this function assures that a recipe that is indirectly selected (via reagent clicks, for example)
-- will be visible in the skill list (ie, not scrolled off the top/bottom)
function Skillet:ScrollToSkillIndex(skillIndex)
	if skillIndex == nil then
		return
	end

--	self:SortAndFilterRecipes()

	-- scroll the skill list to make sure the new skill is revealed
	if SkilletSkillList:IsVisible() then
		local skillListKey = self.currentPlayer..":"..self.currentTrade..":"..self.currentGroupLabel

		local sortedSkillList = self.data.sortedSkillList[skillListKey]
		local sortedIndex

		for i=1,#sortedSkillList,1 do
			if sortedSkillList[i].skillIndex == skillIndex then
				sortedIndex = i
				break
			end
		end

		local scrollbar = getglobal("SkilletSkillListScrollBar")

		local button_count = SkilletSkillList:GetHeight() / SKILLET_TRADE_SKILL_HEIGHT
		button_count = math.floor(button_count)

		local skillOffset = FauxScrollFrame_GetOffset(SkilletSkillList)

--DEFAULT_CHAT_FRAME:AddMessage((skillOffset or "nil").." > "..(sortedIndex or "nil"))
		if skillOffset > sortedIndex then
			sortedIndex = sortedIndex - 1
			FauxScrollFrame_SetOffset(SkilletSkillList, sortedIndex)
			scrollbar:SetValue(sortedIndex * SKILLET_TRADE_SKILL_HEIGHT)
		elseif (skillOffset + button_count) < sortedIndex then
			sortedIndex = sortedIndex - button_count
			FauxScrollFrame_SetOffset(SkilletSkillList, sortedIndex)
			scrollbar:SetValue(sortedIndex * SKILLET_TRADE_SKILL_HEIGHT)
		end
	end

	self:UpdateTradeSkillWindow()
end


-- Go to the previous recipe in the history list.
function Skillet:GoToPreviousSkill()
	local entry = table.remove(skillStack)

	if entry then
		self:SetTradeSkill(entry.player,entry.tradeID,entry.skillIndex)
	end
end

function Skillet:PushSkill(player, tradeID, skillIndex)
	local entry = { ["player"] = player, ["tradeID"] = tradeID, ["skillIndex"] = skillIndex }

	table.insert(skillStack, entry)
end


-- Called when then mouse enters the rank status bar
function Skillet:RankFrame_OnEnter(button)


--	if button ~= SkilletRankFrame then
		GameTooltip:SetOwner(button, "ANCHOR_BOTTOMLEFT")
		local r,g,b = SkilletSkillName:GetTextColor()
		GameTooltip:AddLine(SkilletSkillName:GetText(),r,g,b)

		local gray = SkilletRankFrame.subRanks.green:GetValue()
		local green = SkilletRankFrame.subRanks.yellow:GetValue()
		local yellow = SkilletRankFrame.subRanks.orange:GetValue()
		local orange = SkilletRankFrame.subRanks.red:GetValue()

		GameTooltip:AddLine(COLORORANGE..orange.."|r/"..COLORYELLOW..yellow.."|r/"..COLORGREEN..green.."|r/"..COLORGRAY..gray)

		GameTooltip:Show()
--	end
end


-- Called when then mouse enters the rank status bar
function Skillet:RankFrame_OnLeave(button)
	GameTooltip:Hide()
end

-- Called when then mouse enters a reagent button
function Skillet:ReagentButtonOnEnter(button, skillIndex, reagentIndex)
	GameTooltip:SetOwner(button, "ANCHOR_TOPLEFT")

	local skill = self:GetSkill(self.currentPlayer, self.currentTrade, skillIndex)
	local recipe = self:GetRecipe(skill.id)
	local reagent = recipe.reagentData[reagentIndex]

	if reagent then
		Skillet:SetReagentToolTip(reagent.id, reagent.numNeeded, skill.numCraftableBank or 0)

		if self.db.profile.link_craftable_reagents then
			if self.data.itemRecipeSource[reagent.id] then
				local icon = getglobal(button:GetName() .. "Icon")
				gearTexture:SetParent(icon)
				gearTexture:ClearAllPoints()
				gearTexture:SetPoint("TOPLEFT", icon)
				gearTexture:Show()
			end
		end
	else
		GameTooltip:AddLine("unknown", 1,0,0)
	end

	GameTooltip:Show()
	CursorUpdate()
end

-- called then the mouse leaves a reagent button
function Skillet:ReagentButtonOnLeave(button, skillIndex, reagentIndex)
	gearTexture:Hide()
end


function Skillet:ReagentButtonSkillSelect(player, id)
	local skillIndexLookup = self.data.skillIndexLookup[player]

	gearTexture:Hide()
	GameTooltip:Hide()
--	button:Hide()					-- hide the button so that if a new button is shown in this slot, a new "OnEnter" event will fire

	newRecipe = self:GetRecipe(id)

	self:PushSkill(self.currentPlayer, self.currentTrade, self.selectedSkill)
	self:SetTradeSkill(player, newRecipe.tradeID, skillIndexLookup[id])
end


-- Called when the reagent button is clicked
function Skillet:ReagentButtonOnClick(button, skillIndex, reagentIndex)
	if not self.db.profile.link_craftable_reagents then
		return
	end

	local recipe = self:GetRecipeDataByTradeIndex(self.currentTrade, skillIndex)
	local reagent = recipe.reagentData[reagentIndex]
	local newRecipeTable = self.data.itemRecipeSource[reagent.id]

	local skillIndexLookup = self.data.skillIndexLookup
	local player = self.currentPlayer
	local newRecipeID
	local newPlayer

	if newRecipeTable then
		local newRecipe

		local recipeCount = 0
		self.data.recipeMenuTable = {}

		if not self.recipeMenu then
			self.recipeMenu = CreateFrame("Frame", "SkilletRecipeMenu", getglobal("UIParent"), "UIDropDownMenuTemplate")
		end

		-- TODO: popup with selection if there is more than 1 potential recipe source for the reagent (small prismatic shards, for example)
		for player in pairs(skillIndexLookup) do
			for id in pairs(newRecipeTable) do
				if skillIndexLookup[player][id] then
					recipeCount = recipeCount + 1
					local skillID = skillIndexLookup[player][id]
					local newRecipe = self:GetRecipe(id)

					local newSkill = self:GetSkill(player, newRecipe.tradeID, skillID)

					self.data.recipeMenuTable[recipeCount] = {}
					self.data.recipeMenuTable[recipeCount].text = player .." : " .. newSkill.color.cstring .. newRecipe.name
					self.data.recipeMenuTable[recipeCount].arg1 = player
					self.data.recipeMenuTable[recipeCount].arg2 = id
					self.data.recipeMenuTable[recipeCount].func = function(arg1,arg2) Skillet:ReagentButtonSkillSelect(arg1,arg2) end

					if player == self.currentPlayer then
						self.data.recipeMenuTable[recipeCount].textr = 1.0
						self.data.recipeMenuTable[recipeCount].textg = 1.0
						self.data.recipeMenuTable[recipeCount].textb = 1.0
					else
						self.data.recipeMenuTable[recipeCount].textR = .7
						self.data.recipeMenuTable[recipeCount].textG = .7
						self.data.recipeMenuTable[recipeCount].textB = .7
					end

					newPlayer = player
					newRecipeID = id
				end
			end
		end

		if recipeCount == 1 then
			gearTexture:Hide()
			GameTooltip:Hide()
			button:Hide()					-- hide the button so that if a new button is shown in this slot, a new "OnEnter" event will fire

			newRecipe = self:GetRecipe(newRecipeID)

			self:PushSkill(self.currentPlayer, self.currentTrade, self.selectedSkill)
			self:SetTradeSkill(newPlayer, newRecipe.tradeID, skillIndexLookup[newPlayer][newRecipeID])
		else

			local x, y = GetCursorPosition()
			local uiScale = UIParent:GetEffectiveScale()

			EasyMenu(self.data.recipeMenuTable, self.recipeMenu, getglobal("UIParent"), x/uiScale,y/uiScale, "MENU", 5)
		end
	end
end


function Skillet:SkilletFrameForceClose()

	if self.dataSource == "api" then
		CloseTradeSkill()

		self.dataSource = "none"
		self:FreeCaches()
		return true
	else
		CloseTradeSkill()

		local x = self:HideAllWindows()
		self:FreeCaches()
		return x
	end
end

-- The start/pause queue button.
function Skillet:StartQueue_OnClick(button)
	if self.queuecasting then
		self:CancelCast() -- next update will reset the text
		button:Disable()
		self.queuecasting = false
	else
		button:SetText(L["Pause"])
		self:ProcessQueue()
	end
	self:UpdateQueueWindow()
end

-- Updates the "Scanning tradeskill" text area with provided text
-- Set nil/empty text to hide the area
function Skillet:UpdateScanningText(text)
	local area = getglobal("SkilletFrameScanningText")
	if area then
		if text and string.len(text) > 0 then
			area:SetText(text)
			area:Show()
		else
			area:Hide()
		end
	end
end

local old_CloseSpecialWindows

-- Called when the trade skill window is shown
function Skillet:Tradeskill_OnShow()
DebugSpam("Tradeskill_OnShow")

	-- Need to hook this so that hitting [ESC] will close the Skillet window(s).
	if not old_CloseSpecialWindows then
		old_CloseSpecialWindows = CloseSpecialWindows
		CloseSpecialWindows = function()
			local found = old_CloseSpecialWindows()
			return self:SkilletFrameForceClose() or found
		end
	end
DebugSpam("Tradeksill_OnShow END")
end

-- Called when the trade skill window is hidden
function Skillet:Tradeskill_OnHide()
end





function Skillet:InventoryFilterButton_OnClick(button)
	local slot = button.slot or ""
	local option = "filterInventory-"..slot

	self:ToggleTradeSkillOption(option)


	self:InventoryFilterButton_OnEnter(button)
	self:InventoryFilterButton_OnShow(button)
	self:SortAndFilterRecipes()
	self:UpdateTradeSkillWindow()
end


function Skillet:InventoryFilterButton_OnEnter(button)
	local slot = button.slot or ""
	local option = "filterInventory-"..slot
	local value = self:GetTradeSkillOption(option)

	GameTooltip:SetOwner(button, "ANCHOR_TOPLEFT")

	if value then
		GameTooltip:SetText(slot.." on")
	else
		GameTooltip:SetText(slot.." off")
	end
--	GameTooltip:AddLine(player,1,1,1)

	GameTooltip:Show()
end


function Skillet:InventoryFilterButton_OnLeave(button)
	GameTooltip:Hide()
end

function Skillet:InventoryFilterButton_OnShow(button)
	local slot = button.slot or ""
	local option = "filterInventory-"..slot

	local value = self:GetTradeSkillOption(option)

	if value then
		button:SetChecked(1)
	else
		button:SetChecked(0)
	end
end



function Skillet:InventoryFilterButtons_Show()
	SkilletInventoryFilterBag:Show()
	SkilletInventoryFilterVendor:Show()
	SkilletInventoryFilterBank:Show()
	SkilletInventoryFilterAlts:Show()
end


function Skillet:InventoryFilterButtons_Hide()
	SkilletInventoryFilterBag:Hide()
	SkilletInventoryFilterVendor:Hide()
	SkilletInventoryFilterBank:Hide()
	SkilletInventoryFilterAlts:Hide()
end



local skillMenuSelection = {
	{
		text = "Select All",
		func = function() Skillet:SkillButton_SetAllSelections(true) Skillet:UpdateTradeSkillWindow() end,
	},
	{
		text = "Select None",
		func = function() Skillet:SkillButton_SetAllSelections(false) Skillet:UpdateTradeSkillWindow() end,
	},
}


local skillMenuGroup = {
	{
		text = "Empty Group",
		func = function() Skillet:SkillButton_NewGroup() end,
	},
	{
		text = "From Selection",
		func = function() Skillet:SkillButton_MakeGroup() end,
	},
}


local skillMenuList = {
	{
		text = "Link Recipe",
		func = function()
					local spellLink = GetSpellLink(Skillet.menuButton.skill.recipeID)

					if (ChatEdit_GetLastActiveWindow():IsVisible() or WIM_EditBoxInFocus ~= nil) then
						ChatEdit_InsertLink(spellLink)
					else
						DEFAULT_CHAT_FRAME:AddMessage(spellLink)
					end
				end,
	},
	{
		text = "",
		disabled = true,
	},
	{
		text = "New Group",
		hasArrow = true,
		menuList = skillMenuGroup,
	},
	{
		text = "Selection",
		hasArrow = true,
		menuList = skillMenuSelection,
	},
	{
		text = "",
		disabled = true,
	},
	{
		text = "Copy",
		func = function() Skillet:SkillButton_CopySelected() end,
	},
	{
		text = "Cut",
		func = function() Skillet:SkillButton_DeleteSelected() end,
	},
	{
		text = "Paste",
		func = function() Skillet:SkillButton_PasteSelected(Skillet.menuButton) end,
	},
}

local headerMenuList = {
	{
		text = "Rename Group",
		func = function() Skillet:SkillButton_NameEditEnable(Skillet.menuButton) end,
	},
	{
		text = "",
		disabled = true,
	},
	{
		text = "New Group",
		hasArrow = true,
		menuList = skillMenuGroup,
	},
	{
		text = "Selection",
		hasArrow = true,
		menuList = skillMenuSelection,
	},
	{
		text = "",
		disabled = true,
	},
	{
		text = "Copy",
		func = function() Skillet:SkillButton_CopySelected() end,
	},
	{
		text = "Cut",
		func = function() Skillet:SkillButton_DeleteSelected() end,
	},
	{
		text = "Paste",
		func = function() Skillet:SkillButton_PasteSelected(Skillet.menuButton) end,
	},
}


local headerMenuListMainGroup = {
	{
		text = "New Group",
		hasArrow = true,
		menuList = skillMenuGroup,
	},
	{
		text = "Selection",
		hasArrow = true,
		menuList = skillMenuSelection,
	},
	{
		text = "",
		disabled = true,
	},
	{
		text = "Copy",
		func = function() Skillet:SkillButton_CopySelected() end,
	},
	{
		text = "Cut",
		func = function() Skillet:SkillButton_DeleteSelected() end,
	},
	{
		text = "Paste",
		func = function() Skillet:SkillButton_PasteSelected(Skillet.menuButton) end,
	},
}

local skillMenuListHidden = {
{
		text = "New Group",
		hasArrow = true,
		menuList = skillMenuGroup,
	},
	{
		text = "Selection",
		hasArrow = true,
		menuList = skillMenuSelection,
	},
	{
		text = "",
		disabled = true,
	},
	{
		text = "Copy",
		func = function() Skillet:SkillButton_CopySelected() end,
	},
	{
		text = "Cut",
		func = function() Skillet:SkillButton_DeleteSelected() end,
	},
	{
		text = "Paste",
		func = function() Skillet:SkillButton_PasteSelected(Skillet.menuButton) end,
	},
}


-- Called when the skill operators drop down is displayed
function Skillet:SkilletSkillMenu_Show(button)
	if not SkilletSkillMenu then
		SkilletSkillMenu = CreateFrame("Frame", "SkilletSkillMenu", getglobal("UIParent"), "UIDropDownMenuTemplate")
	end

	local x, y = GetCursorPosition()
	local uiScale = UIParent:GetEffectiveScale()

	self.menuButton = button

	if button.skill.subGroup then
		if button.skill.mainGroup then
			EasyMenu(headerMenuListMainGroup, SkilletSkillMenu, getglobal("UIParent"), x/uiScale,y/uiScale, "MENU", 5)
		else
			EasyMenu(headerMenuList, SkilletSkillMenu, getglobal("UIParent"), x/uiScale,y/uiScale, "MENU", 5)
		end
	else
		if button:GetText() == "" then
			EasyMenu(skillMenuListEmpty, SkilletSkillMenu, getglobal("UIParent"), x/uiScale,y/uiScale, "MENU", 5)
		else
			EasyMenu(skillMenuList, SkilletSkillMenu, getglobal("UIParent"), x/uiScale,y/uiScale, "MENU", 5)
		end
	end
--	UIDropDownMenu_Initialize(SkilletSkillMenu, SkilletSkillMenu_Init, "MENU")
--	ToggleDropDownMenu(1, nil, SkilletSkillMenu, button, 0, 0)
end






--- tsi hooks

local TSISourceColor = {
	V = "|cff00ff00",
	Q = "|cffffff00",
	D = "|cffff0000",
}



function Skillet:TSIGetRecipeSources(recipe, opposing)
	if not TradeskillInfo then return 0, "No TradeskillInfo" end

	if not TradeskillInfo.vars.recipes[recipe] then
		return nil
	end

	local found, _, sources, price, level = string.find(TradeskillInfo.vars.recipes[recipe],"[^|]+|(%w+)[|]?(%d*)[|]?(%d*)");

	if not found then return end

	local c = TradeskillInfo.db.profile.ColorRecipeSource;
	local Ltext, Rtext = "";

	if price == "" then
		price = nil
	else
		price = tonumber(price)
	end

	local uf = UnitFactionGroup("player")
	local res = ""
	local number_found = 0;

	opposing = true

	for s,n in string.gmatch(sources,"(%u%l*)(%d*)") do
		if (s=="V" or s=="Q" or s=="D") and n~="" then

			local found,_,vname,znr,fnr,pos,note = string.find(TradeskillInfo.vars.vendors[tonumber(n)],"([^|]+)|(%d+)|(%d+)[|]?([^|]*)[|]?([^|]*)");

			if found then
				if opposing or (uf=="Horde" and fnr~="1") or (uf=="Alliance" and fnr~="2") then
					number_found = number_found + 1;

					local zone = TradeskillInfo.vars.zones[tonumber(znr)];

					local faction = TradeskillInfo.vars.factions[tonumber(fnr)];

					if res ~= "" then
						res = res.."\n";
					end

					if note ~= "" then
						note = " "..note
					end

					if pos ~= "" then
						local found, _, x, y = string.find(pos,"([%d%.]+),([%d%.]+)");
						if found then
							zone = zone or ""
							pos = " |cFF0066FF|Htsicoord:"..zone..":"..x..":"..y..":"..vname.."|h("..x..", "..y..")|h|r"
						else
							pos = " ("..pos..")"
						end
					end

--					Rtext = TradeskillInfo.vars.sources[s]..": "..vname..", "..zone..pos..note
					Rtext = TSISourceColor[s]..vname.."|r: "..zone..pos.."|cff808080"..note.."|r"

					if level ~= "" then
						local rep = getglobal("FACTION_STANDING_LABEL"..level);
						Rtext = Rtext.."\n(|cff60a0f0"..faction.."|r-"..rep.."|r)";
					end

					res = res .. Rtext;
				end
			else
				TradeskillInfo:Print(TradeskillInfo_UnknownNPC_Text,s);
			end
		elseif TradeskillInfo.vars.sources[s] then
			local _,_,f = string.find(s,"%u(%l*)")
			if opposing or (uf=="Horde" and f~="a") or (uf=="Alliance" and f~="h") then
				number_found = number_found + 1;
				if res ~= "" then
					res = res.."\n"
				end
				Rtext = TradeskillInfo.vars.sources[s];
				res = res..Rtext;
			end
		else
			TradeskillInfo:Print(TradeskillInfo_UnknownSource_Text,s);
		end
	end

	if res == "" or not res then
--		res = "No Data (TradeskillInfo version "..TradeskillInfo.version..")"
		res = nil
	end

	return number_found,res
end

