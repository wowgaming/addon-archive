local ipairs = ipairs
local tinsert = table.insert
local tremove = table.remove

local modules = {}

local function setBarDefaults(bar)
	bar.button = {}
	bar.numButtons = 0
	bar.using = 0
end

local function setupSpellList(bar, spells)
	local spellList = {}
	for i, spellId in ipairs(spells) do
		local spellName = GetSpellInfo(spellId)
		if spellName then
			spellList[spellId] = spellName
		end
	end
	bar.spellList = spellList
end

local function empty() end
local function onEvent(bar, ...) bar:OnEvent(...) end

function ZActionBar_Create(name, spells, options, savedName)
	local bar = CreateFrame("Frame", name, UIParent)
	setupSpellList(bar, spells)
	setBarDefaults(bar)
	bar.options = options
	bar.savedName = savedName
	bar.name = name
	bar.OnLoad = empty
	bar.OnEvent = empty
	bar:SetScript("OnEvent", onEvent)
	tinsert(modules, bar)
	return bar
end

function ZActionBar_UpdateBar(bar)
	local id = 1
	bar.using = 0
	if bar.special then
		id = 2
		bar.using = 1
	end
	local saved = getglobal(bar.savedName)[bar.name]
	for i, spellId in pairs(saved.spells) do
		local button = bar.button[id] or ZActionBar_AddButton(bar)
		if button:SetSpell(spellId) then
			bar:OnEvent("BUTTON_SPELL_SET", id, button.spellName)
			id = id + 1
			bar.using = bar.using + 1
		end
	end
	for i = id, bar.numButtons do
		ZActionBar_DisableButton(bar.button[i])
	end
	if bar.using > 0 then
		bar.button[1]:Show()
	end
end

local function validateSpells(bar)
	local saved = getglobal(bar.savedName)[bar.name]
	if not saved["spells"] then
		saved["spells"] = {}
		for spellId in pairs(bar.spellList) do
			tinsert(saved["spells"], spellId)
		end
	end
end

function ZActionBar_ToggleBar(bar, value)
	if type(value) == "boolean" then
		bar.enabled = value
	end
	if bar.enabled then
		ZActionBar_UpdateBar(bar)
		ZActionBar_SetSize(bar)
		ZActionBar_SetCount(bar)
		ZActionBar_SetTrigger(bar)
		ZActionBar_SetRoundButton(bar)
		ZActionBar_SetCooldownDisplay(bar)
		ZActionBar_SetBackgroundColor(bar)
		ZActionBar_SetExpand(bar)
		ZActionBar_SetStack(bar)
		ZActionBar_SetPerRow(bar)
		ZActionBar_SetupLayout(bar)
	else
		for i = 1, bar.numButtons do
			bar.button[i]:Hide()
		end
	end
end

local setupFrame = CreateFrame("Frame")
setupFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
setupFrame:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	for i, bar in ipairs(modules) do
		ZActionBar_SetHeader(bar)
		ZActionBar_SetupOptions(bar)
		validateSpells(bar)
		ZActionBar_SetSpecial(bar)
		ZActionBar_ToggleBar(bar)
		bar:OnLoad()
	end
end)