local L = LibStub("AceLocale-3.0"):GetLocale("Talented")
local Talented = Talented

local prev_script
local new_script = function ()
	local template = Talented:UpdateInspectTemplate()
	if template then Talented:OpenTemplate(template) end
end

function Talented:HookInspectUI()
	if not prev_script then
		prev_script = InspectFrameTab3:GetScript("OnClick")
		InspectFrameTab3:SetScript("OnClick", new_script)
	end
end

function Talented:UnhookInspectUI()
	if prev_script then
		InspectFrameTab3:SetScript("OnClick", prev_script)
		prev_script = nil
	end
end

function Talented:CheckHookInspectUI()
	self:RegisterEvent("INSPECT_TALENT_READY")
	if self.db.profile.hook_inspect_ui then
		if IsAddOnLoaded("Blizzard_InspectUI") then
			self:HookInspectUI()
		else
			self:RegisterEvent("ADDON_LOADED")
		end
	else
		if IsAddOnLoaded("Blizzard_InspectUI") then
			self:UnhookInspectUI()
		else
			self:UnregisterEvent("ADDON_LOADED")
		end
	end
end

function Talented:ADDON_LOADED(_, addon)
	if addon == "Blizzard_InspectUI" then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		self:HookInspectUI()
	end
end

function Talented:GetInspectUnit()
	return InspectFrame and InspectFrame.unit
end

function Talented:UpdateInspectTemplate()
	local unit = self:GetInspectUnit()
	if not unit then return end
	local name = UnitName(unit)
	if not name then return end
	local inspections = self.inspections
	if not inspections then
		inspections = {}
		self.inspections = inspections
	end
	local _, class = UnitClass(unit)
	local info = self:UncompressSpellData(class)
	local retval
	for talentGroup = 1, GetNumTalentGroups(true) do
		local template_name = name.." - "..tostring(talentGroup)
		local template = inspections[template_name]
		if not template then
			template = {
				name = L["Inspection of %s"]:format(name)..(talentGroup == GetActiveTalentGroup(true) and "" or L[" (alt)"]),
				class = class,
			}
			for tab, tree in ipairs(info) do
				template[tab] = {}
			end
			inspections[template_name] = template
		else
			self:UnpackTemplate(template)
		end
		for tab, tree in ipairs(info) do
			for index = 1, #tree do
				local rank = select(5, GetTalentInfo(tab, index, true, nil, talentGroup))
				template[tab][index] = rank
			end
		end
		if not self:ValidateTemplate(template) then
			inspections[template_name] = nil
		else
			local found
			for _, view in self:IterateTalentViews(template) do
				view:Update()
				found = true
			end
			if not found then self:PackTemplate(template) end
			if talentGroup == GetActiveTalentGroup(true) then
				retval = template
			end
		end
	end
	return retval
end

Talented.INSPECT_TALENT_READY = Talented.UpdateInspectTemplate

