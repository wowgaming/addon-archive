local Talented = LibStub("AceAddon-3.0"):NewAddon("Talented",
	"AceConsole-3.0", "AceComm-3.0", "AceHook-3.0", "AceEvent-3.0", "AceSerializer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

Talented.prev_Print = Talented.Print
function Talented:Print(s, ...)
	if type(s) == "string" and s:find("%", nil, true) then
		self:prev_Print(s:format(...))
	else
		self:prev_Print(s, ...)
	end
end

function Talented:Debug(...)
	if not self.db or self.db.profile.debug then
		self:Print(...)
	end
end

function Talented:MakeTarget(targetName)
	local name = self.db.char.targets[targetName]
	local src = name and self.db.global.templates[name]
	if not src then
		if name then
			self.db.char.targets[targetName] = nil
		end
		return
	end

	local target = self.target
	if not target then
		target = {}
		self.target = target
	end
	self:CopyPackedTemplate(src, target)

	if not self:ValidateTemplate(target) or
		(RAID_CLASS_COLORS[target.class] and target.class ~= select(2, UnitClass"player")) or
		(not RAID_CLASS_COLORS[target.class] and (not self.GetPetClass or target.class ~= self:GetPetClass()))
	then
		self.db.char.targets[targetName] = nil
		return nil
	end
	target.name = name
	return target
end

function Talented:GetMode()
	return self.mode
end

function Talented:SetMode(mode)
	if self.mode ~= mode then
		self.mode = mode
		if mode == "apply" then
			self:ApplyCurrentTemplate()
		elseif self.base and self.base.view then
			self.base.view:SetViewMode(mode)
		end
	end
	local cb = self.base and self.base.checkbox
	if cb then
		cb:SetChecked(mode == "edit")
	end
end

-- Hook this function if you wanna change the way Talented loads its modules
function Talented:LoadAddOn(name)
	LoadAddOn(name)
end

function Talented:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("TalentedDB", self.defaults)
	self:UpgradeOptions()
	self:LoadTemplates()

	local AceDBOptions = LibStub("AceDBOptions-3.0", true)
	if AceDBOptions then
		self.options.args.profiles = AceDBOptions:GetOptionsTable(self.db)
		self.options.args.profiles.order = 200
	end

	LibStub("AceConfig-3.0"):RegisterOptionsTable("Talented", self.options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Talented", "Talented")
	self:RegisterChatCommand("talented", "OnChatCommand")

	self:RegisterComm("Talented")
	if self.InitializePet then
		self:InitializePet()
	end
	if IsLoggedIn() then
		self:LoadAddOn"Talented_SpecTabs"
	else
		self.PLAYER_LOGIN = function (self)
			self:LoadAddOn"Talented_SpecTabs"
			self:UnregisterEvent"PLAYER_LOGIN"
			self.PLAYER_LOGIN = nil
		end
		self:RegisterEvent"PLAYER_LOGIN"
	end
	self.OnInitialize = nil
end

function Talented:OnChatCommand(input)
	if not input or input:trim() == "" then
		self:OpenOptionsFrame()
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(self, "talented", "Talented", input)
	end
end

function Talented:DeleteCurrentTemplate()
	local template = self.template
	if template.talentGroup then return end
	local templates = self.db.global.templates
	templates[template.name] = nil
	self:SetTemplate()
end

function Talented:UpdateTemplateName(template, newname)
	if self.db.global.templates[newname] or
			template.talentGroup or
			type(newname) ~= "string" or newname == "" then
		return
	end

	local oldname = template.name
	template.name = newname
	local t = self.db.global.templates
	t[newname] = template
	t[oldname] = nil
end

do
	local function new(templates, name, class)
		local count = 0
		local template = {
			name = name,
			class = class
		}
		while templates[template.name] do
			count = count + 1
			template.name = format(L["%s (%d)"], name, count)
		end
		templates[template.name] = template
		return template
	end

	local function copy(dst, src)
		dst.class = src.class
		if src.code then
			dst.code = src.code
			return
		else
			for tab, tree in ipairs(Talented:UncompressSpellData(src.class)) do
				local s, d = src[tab], {}
				dst[tab] = d
				for index = 1, #tree do
					d[index] = s[index]
				end
			end
		end
	end

	function Talented:ImportFromOther(name, src)
		if not self:UncompressSpellData(src.class) then return end

		local dst = new(self.db.global.templates, name, src.class)

		copy(dst, src)

		self:OpenTemplate(dst)

		return dst
	end

	function Talented:CopyTemplate(src)
		local dst = new(self.db.global.templates, format(L["Copy of %s"], src.name), src.class)

		copy(dst, src)

		return dst
	end

	function Talented:CreateEmptyTemplate(class)
		class = class or select(2, UnitClass"player")
		local template = new(self.db.global.templates, L["Empty"], class)

		local info = self:UncompressSpellData(class)

		for tab, tree in ipairs(info) do
			local t = {}
			template[tab] = t
				for index = 1, #tree do
				t[index] = 0
			end
		end

		return template
	end

	Talented.importers = {}
	Talented.exporters = {}
	function Talented:ImportTemplate(url)
		local dst, result = new(self.db.global.templates, L["Imported"])
		for pattern, method in pairs(self.importers) do
			if url:find(pattern) then
				result = method(self, url, dst)
				if result then break end
			end
		end
		if result then
			if not self:ValidateTemplate(dst) then
				self:Print(L["The given template is not a valid one!"])
				self.db.global.templates[dst.name] = nil
			else
				return dst
			end
		else
			self:Print(L["\"%s\" does not appear to be a valid URL!"], url)
			self.db.global.templates[dst.name] = nil
		end
	end
end

function Talented:OpenTemplate(template)
	self:UnpackTemplate(template)
	if not self:ValidateTemplate(template, true) then
		local name = template.name
		self.db.global.templates[name] = nil
		self:Print(L["The template '%s' is no longer valid and has been removed."], name)
		return
	end
	local base = self:CreateBaseFrame()
	if not self.alternates then
		self:UpdatePlayerSpecs()
	end
	self:SetTemplate(template)
	if not base:IsVisible() then
		ShowUIPanel(base)
	end
end

function Talented:SetTemplate(template)
	if not template then
		template = assert(self:GetActiveSpec())
	end
	local view = self:CreateBaseFrame().view
	local old = view.template
	if template ~= old then
		if template.talentGroup then
			if not template.pet then
				view:SetTemplate(template, self:MakeTarget(template.talentGroup))
			else
				view:SetTemplate(template, self:MakeTarget(UnitName"PET"))
			end
		else
			view:SetTemplate(template)
		end
		self.template = template
	end
	if not template.talentGroup then
		self.db.profile.last_template = template.name
	end
	self:SetMode(self:GetDefaultMode())
	-- self:UpdateView()
end

function Talented:GetDefaultMode()
	return self.db.profile.always_edit and "edit" or "view"
end

function Talented:OnEnable()
	self:RawHook("ToggleTalentFrame", true)
	self:RawHook("ToggleGlyphFrame", true)
	self:SecureHook("UpdateMicroButtons")
	self:CheckHookInspectUI()

	UIParent:UnregisterEvent"USE_GLYPH"
	UIParent:UnregisterEvent"CONFIRM_TALENT_WIPE"
	self:RegisterEvent"USE_GLYPH"
	self:RegisterEvent"CONFIRM_TALENT_WIPE"
	self:RegisterEvent"CHARACTER_POINTS_CHANGED"
	self:RegisterEvent"PLAYER_TALENT_UPDATE"
	TalentMicroButton:SetScript("OnClick", ToggleTalentFrame)
end

function Talented:OnDisable()
	self:UnhookInspectUI()
	UIParent:RegisterEvent"USE_GLYPH"
	UIParent:RegisterEvent"CONFIRM_TALENT_WIPE"
end

function Talented:PLAYER_TALENT_UPDATE()
	self:UpdatePlayerSpecs()
end

function Talented:CONFIRM_TALENT_WIPE(_, cost)
	local dialog = StaticPopup_Show"CONFIRM_TALENT_WIPE"
	if dialog then
		MoneyFrame_Update(dialog:GetName().."MoneyFrame", cost)
		self:SetTemplate()
		local frame = self.base
		if not frame or not frame:IsVisible() then
			self:Update()
			ShowUIPanel(self.base)
		end
		dialog:SetFrameLevel(frame:GetFrameLevel() + 5)
	end
end


function Talented:CHARACTER_POINTS_CHANGED()
	self:UpdatePlayerSpecs()
	self:UpdateView()
	if self.mode == "apply" then
		self:CheckTalentPointsApplied()
	end
end

function Talented:UpdateMicroButtons()
	local button = TalentMicroButton
	if self.db.profile.donthide and UnitLevel"player" < button.minLevel then
		button:Enable()
	end
	if self.base and self.base:IsShown() then
		button:SetButtonState("PUSHED", 1)
	else
		button:SetButtonState"NORMAL"
	end
end

function Talented:ToggleTalentFrame()
	local frame = self.base
	if not frame or not frame:IsVisible() then
		self:Update()
		ShowUIPanel(self.base)
	else
		HideUIPanel(frame)
	end
end

function Talented:Update()
	self:CreateBaseFrame()
	self:UpdatePlayerSpecs()
	if not self.template then
		self:SetTemplate()
	end
	self:UpdateView()
end

function Talented:LoadTemplates()
	local db = self.db.global.templates
	local invalid = {}
	for name, code in pairs(db) do
		if type(code) == "string" then
			local class = self:GetTemplateStringClass(code)
			if class then
				db[name] = {
					name = name,
					code = code,
					class = class,
				}
			else
				db[name] = nil
				invalid[#invalid + 1] = name
			end
		elseif not self:ValidateTemplate(code) then
			db[name] = nil
			invalid[#invalid + 1] = name
		end
	end
	if next(invalid) then
		table.sort(invalid)
		self:Print(L["The following templates are no longer valid and have been removed:"])
		self:Print(table.concat(invalid, ", "))
	end

	self.OnDatabaseShutdown = function (self, event, db)
		local db = db.global.templates
		for name, template in pairs(db) do
			template.talentGroup = nil
			Talented:PackTemplate(template)
			if template.code then
				db[name] = template.code
			end
		end
		self.db = nil
	end
	self.db.RegisterCallback(self, "OnDatabaseShutdown")
	self.LoadTemplates = nil
end

_G.Talented = Talented
