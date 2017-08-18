local Talented = Talented
local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

function Talented:ApplyCurrentTemplate()
	local template = self.template
	local pet = not RAID_CLASS_COLORS[template.class]
	if pet then
		if not self.GetPetClass or self:GetPetClass() ~= template.class then
			self:Print(L["Sorry, I can't apply this template because it doesn't match your pet's class!"])
			self.mode = "view"
			self:UpdateView()
			return
		end
	elseif select(2, UnitClass"player") ~= template.class then
		self:Print(L["Sorry, I can't apply this template because it doesn't match your class!"])
		self.mode = "view"
		self:UpdateView()
		return
	end
	local count = 0
	local current = pet and self.pet_current or self:GetActiveSpec()
	local group = GetActiveTalentGroup(nil, pet)
	-- check if enough talent points are available
	local available = GetUnspentTalentPoints(nil, pet, group)
	for tab, tree in ipairs(self:UncompressSpellData(template.class)) do
		for index = 1, #tree do
			local delta = template[tab][index] - current[tab][index]
			if delta > 0 then
				count = count + delta
			end
		end
	end
	if count == 0 then
		self:Print(L["Nothing to do"])
		self.mode = "view"
		self:UpdateView()
	elseif count > available then
		self:Print(L["Sorry, I can't apply this template because you don't have enough talent points available (need %d)!"], count)
		self.mode = "view"
		self:UpdateView()
	else
		self:EnableUI(false)
		self:ApplyTalentPoints()
	end
end

function Talented:ApplyTalentPoints()
	local p = GetCVar"previewTalents"
	SetCVar("previewTalents", "1")

	local template = self.template
	local pet = not RAID_CLASS_COLORS[template.class]
	local group = GetActiveTalentGroup(nil, pet)
	ResetGroupPreviewTalentPoints(pet, group)
	local cp = GetUnspentTalentPoints(nil, pet, group)

	while true do
		local missing, set
		for tab, tree in ipairs(self:UncompressSpellData(template.class)) do
			local ttab = template[tab]
			for index = 1, #tree do
				local rank = select(9, GetTalentInfo(tab, index, nil, pet, group))
				local delta = ttab[index] - rank
				if delta > 0 then
					AddPreviewTalentPoints(tab, index, delta, pet, group)
					local nrank = select(9, GetTalentInfo(tab, index, nil, pet, group))
					if nrank < ttab[index] then
						missing = true
					elseif nrank > rank then
						set = true
					end
					cp = cp - nrank + rank
				end
			end
		end
		if not missing then break end
		assert(set) -- make sure we did something
	end
	if cp < 0 then
		Talented:Print(L["Error while applying talents! Not enough talent points!"])
		ResetGroupPreviewTalentPoints(pet, group)
		Talented:EnableUI(true)
	else
		LearnPreviewTalents(pet)
	end
	SetCVar("previewTalents", p)
end

function Talented:CheckTalentPointsApplied()
	local template = self.template
	local pet = not RAID_CLASS_COLORS[template.class]
	local group = GetActiveTalentGroup(nil, pet)
	local failed
	for tab, tree in ipairs(self:UncompressSpellData(template.class)) do
		local ttab = template[tab]
		for index = 1, #tree do
			local delta = ttab[index] - select(5, GetTalentInfo(tab, index, nil, pet, group))
			if delta > 0 then
				failed = true
				break
			end
		end
	end
	if failed then
		Talented:Print(L["Error while applying talents! some of the request talents were not set!"])
	else
		local cp = GetUnspentTalentPoints(nil, pet, group)
		Talented:Print(L["Template applied successfully, %d talent points remaining."], cp)
	end
	Talented:OpenTemplate(pet and self.pet_current or self:GetActiveSpec())
	Talented:EnableUI(true)

	return not failed
end
