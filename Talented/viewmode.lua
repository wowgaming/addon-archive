local select = select
local ipairs = ipairs
local GetTalentInfo = GetTalentInfo
local Talented = Talented

local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

function Talented:UpdatePlayerSpecs()
	if GetNumTalentTabs() == 0 then return end
	local class = select(2, UnitClass"player")
	local info = self:UncompressSpellData(class)
	if not self.alternates then self.alternates = {} end
	for talentGroup = 1, GetNumTalentGroups() do
		local template = self.alternates[talentGroup]
		if not template then
			template = {
				talentGroup = talentGroup,
				name = talentGroup == 1 and TALENT_SPEC_PRIMARY or TALENT_SPEC_SECONDARY,
				class = class,
			}
		else
			template.points = nil
		end
		for tab, tree in ipairs(info) do
			local ttab = template[tab]
			if not ttab then
				ttab = {}
				template[tab] = ttab
			end
			for index = 1, #tree do
				ttab[index] = select(5, GetTalentInfo(tab, index, nil, nil, talentGroup))
			end
		end
		self.alternates[talentGroup] = template
		if self.template == template then
			self:UpdateTooltip()
		end
		for _, view in self:IterateTalentViews(template) do
			view:Update()
		end
	end
end

function Talented:GetActiveSpec()
	if not self.alternates then self:UpdatePlayerSpecs() end
	return self.alternates[GetActiveTalentGroup()]
end

function Talented:UpdateView()
	if not self.base then return end
	self.base.view:Update()
end
