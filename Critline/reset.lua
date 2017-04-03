local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local templates = addon.templates

local treeNames = addon.treeNames


local module = templates:CreateList("CritlineReset", L["Reset"])

do
	local button = module.button
	button:SetScript("OnClick", function()
		PlaySound("gsTitleOptionOK")
		module:ResetRecords()
	end)
	
	local resetAll = templates:CreateButton(module)
	resetAll:SetSize(100, 22)
	resetAll:SetPoint("TOP", button, "BOTTOM", 0, -10)
	resetAll:SetText(L["Reset all"])
	resetAll:SetScript("OnClick", function(self)
		PlaySound("gsTitleOptionOK")
		StaticPopup_Show("CRITLINE_RESET_ALL", addon.treeNames[module.tree:GetSelectedValue()])
	end)

	-- "edit tooltip format" popup
	StaticPopupDialogs["CRITLINE_RESET_ALL"] = {
		text = L["Are you sure you want to reset all %s records?"],
		button1 = OKAY,
		button2 = CANCEL,
		OnAccept = function(self)
			module:ResetRecords(true)
		end,
		whileDead = true,
		timeout = 0,
	}
end


function module:ResetRecords(resetAll)
	local selectedSpells = self.selectedSpells
	local tree = self.tree:GetSelectedValue()
	local spells = addon.percharDB.profile.spells[tree]
	
	if resetAll then
		for i = #spells, 1, -1 do
			local data = spells[i]
			if data.filtered then
				data.normal = nil
				data.crit = nil
			else
				tremove(spells, i)
			end
		end
		addon:Message(format(L["Reset all %s records."], treeNames[tree]))
	else
		-- remove selected spells from database
		-- iterate first in ascending order to print chat messages in alphabetical order
		for i = 1, table.maxn(selectedSpells) do
			if selectedSpells[i] then
				local data = spells[i]
				if data.filtered then
					-- don't remove filtered entries completely; save the 'filtered' flag
					data.normal = nil
					data.crit = nil
					selectedSpells[i] = nil
				end
				addon:Message(format(L["Reset %s (%s) records."], addon:GetFullSpellName(tree, data.spellName, data.isPeriodic), treeNames[tree]))
			end
		end
		-- then iterate in descending order not to mess up the loop with tremove
		for i = table.maxn(selectedSpells), 1, -1 do
			if selectedSpells[i] then
				tremove(spells, i)
			end
		end
	end
	
	wipe(selectedSpells)
	self:Update()
	self.button:Disable()
	addon:UpdateSpells(tree)
end