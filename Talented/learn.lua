local L = LibStub("AceLocale-3.0"):GetLocale("Talented")
local StaticPopupDialogs = StaticPopupDialogs

local function ShowDialog(text, tab, index, pet)
	StaticPopupDialogs.TALENTED_CONFIRM_LEARN = {
		button1 = YES,
		button2 = NO,
		OnAccept = function(self)
			LearnTalent(self.talent_tab, self.talent_index, self.is_pet)
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		interruptCinematic = 1
	}
	ShowDialog = function (text, tab, index, pet)
		StaticPopupDialogs.TALENTED_CONFIRM_LEARN.text = text
		local dlg = StaticPopup_Show"TALENTED_CONFIRM_LEARN"
		dlg.talent_tab = tab
		dlg.talent_index = index
		dlg.is_pet = pet
		return dlg
	end
	return ShowDialog(text, tab, index, pet)
end

function Talented:LearnTalent(template, tab, index)
	local is_pet = not RAID_CLASS_COLORS[template.class]
	local p = self.db.profile

	if not p.confirmlearn then
		LearnTalent(tab, index, is_pet)
		return
	end

	if not p.always_call_learn_talents then
		local state = self:GetTalentState(template, tab, index)
		if
			state == "full" or -- talent maxed out
			state == "unavailable" or -- prereqs not fullfilled
			GetUnspentTalentPoints(nil, is_pet, GetActiveTalentGroup(nil, is_pet)) == 0 -- no more points
		then
			return
		end
	end

	ShowDialog(L["Are you sure that you want to learn \"%s (%d/%d)\" ?"]:format(
			self:GetTalentName(template.class, tab, index),
			template[tab][index] + 1,
			self:GetTalentRanks(template.class, tab, index)),
		tab, index, is_pet)
end
