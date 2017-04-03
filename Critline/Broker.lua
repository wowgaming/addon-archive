local addonName, addon = ...

local LDB = LibStub("LibDataBroker-1.1")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)


local feeds = {
	dmg = L["Damage"],
	heal = L["Healing"],
	pet = L["Pet"],
}

for k, v in pairs(feeds) do
	feeds[k] = LDB:NewDataObject("Critline "..addon.treeNames[k], {
		type = "data source",
		label = v,
		icon = addon.icons[k],
		OnClick = function()
			if IsShiftKeyDown() then
				local normalRecord, critRecord, normalSpell, critSpell = addon:GetHighest(k)
				local normal = format("%s: %s", L["Normal"], (normalSpell and format("%d (%s)", normalRecord, normalSpell) or "n/a"))
				local crit = format("%s: %s", L["Crit"], (critSpell and format("%d (%s)", critRecord, critSpell) or "n/a"))
				ChatFrame_OpenChat(normal.." - "..crit)
			else
				addon:OpenConfig()
			end
		end,
		OnTooltipShow = function()
			addon:ShowTooltip(k)
		end
	})
end


local function updateRecords(event, tree, isFiltered)
	if not isFiltered then
		if tree then
			feeds[tree].text = format("%s/%s", addon:GetHighest(tree))
		else
			for k in pairs(feeds) do
				updateRecords(nil, k)
			end
		end
	end
end

addon.RegisterCallback(feeds, "PerCharSettingsLoaded", updateRecords)
addon.RegisterCallback(feeds, "RecordsChanged", updateRecords)
addon.RegisterCallback(feeds, "SpellsChanged", updateRecords)