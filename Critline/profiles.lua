local addonName, addon = ...

local templates = addon.templates

local L = {
	profiles = "Profiles",
	current = "Current profile:",
	default = "Default",
	reset = "Reset profile",
	choose_desc = "You can either create a new profile by entering a name in the editbox, or choose one of the already existing profiles.",
	new = "New",
	choose = "Existing profiles",
	copy_desc = "Copy the settings from one existing profile into the currently active profile.",
	copy = "Copy from",
	delete_desc = "Delete existing and unused profiles from the database to save space, and cleanup the SavedVariables file.",
	delete = "Delete a profile",
	delete_confirm = "Are you sure you want to delete the selected profile?",
	
	dualspec_desc = "When enabled, this feature allow you to select a different "..
		"profile for each talent spec. The dual profile will be swapped with the "..
		"current profile each time you switch from a talent spec to the other.",
	enabled = "Enable dual profile",
	enabled_desc = "Check this box to automatically swap profiles on talent switch.",
	dual_profile = "Dual profile",
}

local LOCALE = GetLocale()
if LOCALE == "deDE" then
	L["profiles"] = "Profile"
	--L["current"] = "Current Profile:"
	L["default"] = "Standard"
	L["reset"] = "Profil zur\195\188cksetzen"
	L["choose"] = "Vorhandene Profile"
	L["new"] = "Neu"
	L["choose_desc"] = "Du kannst ein neues Profil erstellen, indem du einen neuen Namen in der Eingabebox 'Neu' eingibst, oder w\195\164hle eines der vorhandenen Profile aus."
	L["copy_desc"] = "Kopiere die Einstellungen von einem vorhandenen Profil in das aktive Profil."
	L["copy"] = "Kopieren von..."
	L["delete_desc"] = "L\195\182sche vorhandene oder unbenutzte Profile aus der Datenbank um Platz zu sparen und um die SavedVariables Datei 'sauber' zu halten."
	L["delete"] = "Profil l\195\182schen"
	L["delete_confirm"] = "Willst du das ausgew\195\164hlte Profil wirklich l\195\182schen?"
	
	L["dualspec_desc"] = "Wenn aktiv, wechselt dieses Feature bei jedem Wechsel "..
		"der dualen Talentspezialisierung das Profil. Das duale Profil wird beim "..
		"Wechsel automatisch mit dem derzeit aktiven Profil getauscht."
	L["enabled"] = "Aktiviere Duale Profile"
	L["enabled_desc"] = "Aktiviere diese Option, um beim Talentwechsel automatisch zwischen den Profilen zu wechseln."
	L["dual_profile"] = "Duales Profil"
elseif LOCALE == "frFR" then
	L["profiles"] = "Profils"
	--L["current"] = "Current Profile:"
	L["default"] = "D\195\169faut"
	L["reset"] = "R\195\169initialiser le profil"
	L["choose_desc"] = "Vous pouvez cr\195\169er un nouveau profil en entrant un nouveau nom dans la bo\195\174te de saisie, ou en choississant un des profils d\195\169j\195\160 existants."
	L["new"] = "Nouveau"
	L["choose"] = "Profils existants"
	L["copy_desc"] = "Copie les param\195\168tres d'un profil d\195\169j\195\160 existant dans le profil actuellement actif."
	L["copy"] = "Copier \195\160 partir de"
	L["delete_desc"] = "Supprime les profils existants inutilis\195\169s de la base de donn\195\169es afin de gagner de la place et de nettoyer le fichier SavedVariables."
	L["delete"] = "Supprimer un profil"
	L["delete_confirm"] = "Etes-vous s\195\187r de vouloir supprimer le profil s\195\169lectionn\195\169 ?"
	
	L["dualspec_desc"] = "Lorsqu'elle est activée, cette fonctionnalité vous permet "..
		"de choisir un profil différent pour chaque spécialisation de talents. "..
		"Le second profil sera échangé avec le profil courant chaque fois que vous "..
		"passerez d'une spécialisation à l'autre."
	L["enabled"] = 'Activez le second profil'
	L["enabled_desc"] = "Cochez cette case pour échanger automatiquement les profils lors d'un changement de spécialisation."
	L["dual_profile"] = 'Second profil'
-- elseif LOCALE == "koKR" then
	-- L["profiles"] = "프로필"
	-- L["current"] = "Current Profile:"
	-- L["default"] = "기본값"
	-- L["reset"] = "프로필 초기화"
	-- L["choose_desc"] = "새로운 이름을 입력하거나, 이미 있는 프로필중 하나를 선택하여 새로운 프로필을 만들 수 있습니다."
	-- L["new"] = "새로운 프로필"
	-- L["choose"] = "프로필 선택"
	-- L["copy_desc"] = "현재 사용중인 프로필에, 선택한 프로필의 설정을 복사합니다."
	-- L["copy"] = "복사"
	-- L["delete_desc"] = "데이터베이스에 사용중이거나 저장된 프로파일 삭제로 SavedVariables 파일의 정리와 공간 절약이 됩니다."
	-- L["delete"] = "프로필 삭제"
	-- L["delete_confirm"] = "정말로 선택한 프로필의 삭제를 원하십니까?"
elseif LOCALE == "esES" or LOCALE == "esMX" then
	L["profiles"] = "Perfiles"
	--L["current"] = "Current Profile:"
	L["default"] = "Por defecto"
	L["reset"] = "Reiniciar Perfil"
	L["choose_desc"] = "Puedes crear un nuevo perfil introduciendo un nombre en el recuadro o puedes seleccionar un perfil de los ya existentes."
	L["new"] = "Nuevo"
	L["choose"] = "Perfiles existentes"
	L["copy_desc"] = "Copia los ajustes de un perfil existente al perfil actual."
	L["copy"] = "Copiar de"
	L["delete_desc"] = "Borra los perfiles existentes y sin uso de la base de datos para ganar espacio y limpiar el archivo SavedVariables."
	L["delete"] = "Borrar un Perfil"
	L["delete_confirm"] = "¿Estas seguro que quieres borrar el perfil seleccionado?"
elseif LOCALE == "zhTW" then
	L["profiles"] = "設定檔"
	--L["current"] = "Current Profile:"
	L["default"] = "預設"
	L["reset"] = "重置設定檔"
	L["choose_desc"] = "你可以通過在文本框內輸入一個名字創立一個新的設定檔，也可以選擇一個已經存在的設定檔。"
	L["new"] = "新建"
	L["choose"] = "現有的設定檔"
	L["copy_desc"] = "從當前某個已保存的設定檔複製到當前正使用的設定檔。"
	L["copy"] = "複製自"
	L["delete_desc"] = "從資料庫裏刪除不再使用的設定檔，以節省空間，並且清理SavedVariables檔。"
	L["delete"] = "刪除一個設定檔"
	L["delete_confirm"] = "你確定要刪除所選擇的設定檔嗎？"
	
	L["dualspec_desc"] = "啟用時，你可以為你的雙天賦設定另一組設定檔。你的雙設定檔將在你轉換天賦時自動與目前使用設定檔交換。"
	L["enabled"] = "啟用雙設定檔"
	L["enabled_desc"] = "勾選以在轉換天賦時自動交換設定檔"
	L["dual_profile"] = "雙設定檔"
elseif LOCALE == "zhCN" then
	L["profiles"] = "配置文件"
	--L["current"] = "Current Profile:"
	L["default"] = "默认"
	L["reset"] = "重置配置文件"
	L["choose_desc"] = "你可以通过在文本框内输入一个名字创立一个新的配置文件，也可以选择一个已经存在的配置文件。"
	L["new"] = "新建"
	L["choose"] = "现有的配置文件"
	L["copy_desc"] = "从当前某个已保存的配置文件复制到当前正使用的配置文件。"
	L["copy"] = "复制自"
	L["delete_desc"] = "从数据库里删除不再使用的配置文件，以节省空间，并且清理SavedVariables文件。"
	L["delete"] = "删除一个配置文件"
	L["delete_confirm"] = "你确定要删除所选择的配置文件么？"
	
	L["dualspec_desc"] = "启时，你可以为你的双天赋设定另一组配置文件，你的双重配置文件将在你转换天赋时自动与目前使用配置文件交换。"
	L["enabled"] = "开启双重配置文件"
	L["enabled_desc"] = "勾选以便转换天赋时自动交换配置文件。"
	L["dual_profile"] = "双重配置文件"
elseif LOCALE == "ruRU" then
	L["profiles"] = "Профили"
	--L["current"] = "Current Profile:"
	L["default"] = "По умолчанию"
	L["reset"] = "Сброс профиля"
	L["choose_desc"] = "Вы можете создать новый профиль, введя название в поле ввода, или выбрать один из уже существующих профилей."
	L["new"] = "Новый"
	L["choose"] = "Существующие профили"
	L["copy_desc"] = "Скопировать настройки из выбранного профиля в активный."
	L["copy"] = "Скопировать из"
	L["delete_desc"] = "Удалить существующий и неиспользуемый профиль из БД для сохранения места, и очистить SavedVariables файл."
	L["delete"] = "Удалить профиль"
	L["delete_confirm"] = "Вы уверены, что вы хотите удалить выбранный профиль?"
end


local defaultProfiles = {}


local function profileSort(a, b)
	return a.value < b.value
end

local tempProfiles = {}

local function getProfiles(db, common, nocurrent)
	local profiles = {}
	
	-- copy existing profiles into the table
	local currentProfile = db:GetCurrentProfile()
	for _, v in ipairs(db:GetProfiles(tempProfiles)) do 
		if not (nocurrent and v == currentProfile) then 
			profiles[v] = v 
		end 
	end
	
	-- add our default profiles to choose from ( or rename existing profiles)
	for k, v in pairs(defaultProfiles) do
		if (common or profiles[k]) and not (nocurrent and k == currentProfile) then
			profiles[k] = v
		end
	end
	
	local sortProfiles = {}
	local n = 1
	
	for k, v in pairs(profiles) do
		sortProfiles[n] = {text = v, value = k}
		n = n + 1
	end
	
	sort(sortProfiles, profileSort)
	
	return sortProfiles
end


local function createFontString(parent)
	local text = parent:CreateFontString(nil, "BACKGROUND", "GameFontHighlightSmall")
	-- text:SetHeight(32)
	text:SetPoint("LEFT", parent.title)
	text:SetPoint("RIGHT", -32, 0)
	text:SetJustifyH("LEFT")
	text:SetJustifyV("TOP")
	return text
end


local function profilesLoaded(self)
	local db = addon[self.db]
	self.db = db
	
	for k, object in pairs(self.objects) do
		object.db = db
		self[k] = object
	end
	
	db.RegisterCallback(self, "OnProfileChanged")
	db.RegisterCallback(self, "OnNewProfile")
	db.RegisterCallback(self, "OnProfileDeleted")
	
	local keys = db.keys
	defaultProfiles["Default"] = L.default
	defaultProfiles[keys.char] = keys.char
	defaultProfiles[keys.realm] = keys.realm
	defaultProfiles[keys.class] = UnitClass("player")
	
	self.currProfile:SetFormattedText("Current profile: %s%s%s", NORMAL_FONT_COLOR_CODE, db:GetCurrentProfile(), FONT_COLOR_CODE_CLOSE)
	
	self.choose:SetSelectedValue(db:GetCurrentProfile())
	
	self.dualProfile:SetSelectedValue(db:GetDualSpecProfile())
	
	local isDualSpecEnabled = db:IsDualSpecEnabled()
	self.dualEnabled:SetChecked(isDualSpecEnabled)
	self.dualProfile:SetDisabled(not isDualSpecEnabled)
	
	self:CheckProfiles()
end

local function onProfileChanged(self, event, db, profile)
	self.currProfile:SetFormattedText("Current profile: %s%s%s", NORMAL_FONT_COLOR_CODE, profile, FONT_COLOR_CODE_CLOSE)
	self.choose:SetSelectedValue(profile)
	self.dualProfile:SetSelectedValue(db:GetDualSpecProfile())
	self:CheckProfiles()
end

local function onNewProfile(self, event, db, profile)
	self:CheckProfiles()
end

local function onProfileDeleted(self, event, db, profile)
	self:CheckProfiles()
end

local function checkProfiles(self)
	local hasNoProfiles = self:HasNoProfiles()
	self.copy:SetDisabled(hasNoProfiles)
	self.delete:SetDisabled(hasNoProfiles)
end

local function hasNoProfiles(self)
	return next(getProfiles(self.db, nil, true)) == nil
end


local function initializeDropdown(self)
	for _, v in ipairs(getProfiles(self.db, self.common, self.nocurrent)) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = v.text
		info.value = v.value
		info.func = self.func
		info.owner = self
		UIDropDownMenu_AddButton(info)
	end
end

local function newProfileOnEnterPressed(self)
	self.db:SetProfile(self:GetText())
	self:SetText("")
	self:ClearFocus()
end

local function chooseProfileOnClick(self)
	self.owner.db:SetProfile(self.value)
end

local function enableDualProfileOnClick(self)
	local checked = self:GetChecked()
	self.db:SetDualSpecEnabled(checked)
	self.dualProfile:SetDisabled(not checked)
end

local function dualProfileOnClick(self)
	self.owner.db:SetDualSpecProfile(self.value)
	UIDropDownMenu_SetSelectedValue(self.owner, self.value)
end

local function copyProfileOnClick(self)
	self.owner.db:CopyProfile(self.value)
end

local function deleteProfileOnClick(self)
	UIDropDownMenu_SetSelectedValue(self.owner, self.value)
	StaticPopup_Show("CRITLINE_DELETE_PROFILE", nil, nil, {db = self.owner.db, obj = self.owner})
end


local function createProfileUI(name, db)
	local frame = templates:CreateConfigFrame(name, addonName, true, true)
	frame.db = db
	
	frame.ProfilesLoaded = profilesLoaded
	frame.OnProfileChanged = onProfileChanged
	frame.OnNewProfile = onNewProfile
	frame.OnProfileDeleted = onProfileDeleted
	
	addon.RegisterCallback(frame, "AddonLoaded", "ProfilesLoaded")
	
	frame.CheckProfiles = checkProfiles
	frame.HasNoProfiles = hasNoProfiles
	
	local objects = {}
	frame.objects = objects
	
	local reset = addon.templates:CreateButton(frame)
	reset:SetSize(160, 22)
	reset:SetPoint("TOPLEFT", frame.desc, "BOTTOMLEFT")
	reset:SetScript("OnClick", function(self) self.db:ResetProfile() end)
	reset:SetText(L.reset)
	objects.reset = reset

	local currProfile = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlightSmall")
	currProfile:SetPoint("LEFT", reset, "RIGHT")
	currProfile:SetJustifyH("LEFT")
	currProfile:SetJustifyV("CENTER")
	objects.currProfile = currProfile

	local chooseDesc = createFontString(frame)
	chooseDesc:SetHeight(32)
	chooseDesc:SetPoint("TOP", reset, "BOTTOM", 0, -8)
	-- chooseDesc:SetWordWrap(true)
	chooseDesc:SetText(L.choose_desc)

	local newProfile = templates:CreateEditBox(frame)
	newProfile:SetAutoFocus(false)
	newProfile:SetWidth(160)
	newProfile:SetPoint("TOPLEFT", chooseDesc, "BOTTOMLEFT", 0, -16)
	newProfile:SetScript("OnEscapePressed", newProfile.ClearFocus)
	newProfile:SetScript("OnEnterPressed", newProfileOnEnterPressed)
	objects.newProfile = newProfile

	local label = newProfile:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	label:SetPoint("BOTTOMLEFT", newProfile, "TOPLEFT", 0, -2)
	label:SetPoint("BOTTOMRIGHT", newProfile, "TOPRIGHT", 0, -2)
	label:SetJustifyH("LEFT")
	label:SetHeight(18)
	label:SetText(L.new)

	local choose = templates:CreateDropDownMenu("CritlineDBChooseProfile"..name, frame, nil, initializeDropdown, defaultProfiles)
	choose:SetFrameWidth(144)
	choose:SetPoint("LEFT", newProfile, "RIGHT", 0, -2)
	choose.label:SetText(L.choose)
	choose.func = chooseProfileOnClick
	choose.common = true
	objects.choose = choose

	do
		local dualDesc = createFontString(frame)
		dualDesc:SetHeight(32)
		dualDesc:SetPoint("TOP", newProfile, "BOTTOM", 0, -8)
		-- dualDesc:SetWordWrap(true)
		dualDesc:SetText(L.dualspec_desc)
		
		local enabled = CreateFrame("CheckButton", nil, frame, "OptionsBaseCheckButtonTemplate")
		enabled:SetPoint("TOPLEFT", dualDesc, "BOTTOMLEFT", 0, -16)
		enabled:SetPushedTextOffset(0, 0)
		enabled:SetScript("OnClick", enableDualProfileOnClick)
		enabled.tooltipText = L.enable_desc
		local text = enabled:CreateFontString(nil, nil, "GameFontHighlight")
		text:SetPoint("LEFT", enabled, "RIGHT", 0, 1)
		text:SetText(L.enabled)
		objects.dualEnabled = enabled

		local dualProfile = templates:CreateDropDownMenu("CritlineDBDualProfile"..name, frame, nil, initializeDropdown, defaultProfiles)
		dualProfile:SetFrameWidth(144)
		dualProfile:SetPoint("LEFT", choose)
		dualProfile:SetPoint("TOP", enabled)
		dualProfile.label:SetText(L.dual_profile)
		dualProfile.func = dualProfileOnClick
		dualProfile.common = true
		objects.dualProfile = dualProfile
		
		enabled.dualProfile = dualProfile
	end

	local copyDesc = createFontString(frame)
	copyDesc:SetHeight(32)
	copyDesc:SetPoint("TOP", objects.dualEnabled, "BOTTOM", 0, -8)
	copyDesc:SetWordWrap(true)
	copyDesc:SetText(L.copy_desc)

	local copy = templates:CreateDropDownMenu("CritlineDBCopyProfile"..name, frame, nil, initializeDropdown, defaultProfiles)
	copy:SetFrameWidth(144)
	copy:SetPoint("TOPLEFT", copyDesc, "BOTTOMLEFT", -16, -8)
	copy.label:SetText(L.copy)
	copy.func = copyProfileOnClick
	copy.nocurrent = true
	objects.copy = copy

	local deleteDesc = createFontString(frame)
	deleteDesc:SetHeight(32)
	deleteDesc:SetPoint("TOP", copy, "BOTTOM", 0, -8)
	deleteDesc:SetWordWrap(true)
	deleteDesc:SetText(L.delete_desc)

	local delete = templates:CreateDropDownMenu("CritlineDBDeleteProfile"..name, frame, nil, initializeDropdown, defaultProfiles)
	delete:SetFrameWidth(144)
	delete:SetPoint("TOPLEFT", deleteDesc, "BOTTOMLEFT", -16, -8)
	delete.label:SetText(L.delete)
	delete.func = deleteProfileOnClick
	delete.nocurrent = true
	objects.delete = delete
	
	return frame
end


StaticPopupDialogs["CRITLINE_DELETE_PROFILE"] = {
	text = L.delete_confirm,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self, data)
		local delete = data.obj
		self.data.db:DeleteProfile(delete:GetSelectedValue())
		delete:SetSelectedValue(nil)
	end,
	OnCancel = function(self, data)
		data.obj:SetSelectedValue(nil)
	end,
	whileDead = true,
	timeout = 0,
}


local profiles = createProfileUI("Profiles", "db")
profiles.desc:SetText("This profile controls all settings that are not related to individual trees or their records.")

local spellProfiles = createProfileUI("Spell profiles", "percharDB")
spellProfiles.desc:SetText("This profile stores individual tree settings, including which trees will be registered, and spell records.")