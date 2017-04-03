local lib = LibStub:NewLibrary("LibItemBonus-2.0", tonumber(("$Revision: 94 $"):match("(%d+)")) + 90000)

if not lib then return end

lib._LOADING = true

function lib:Print(s, ...)
	if s:find("%", nil, true) then
		s = s:format(...)
	end
	ChatFrame1:AddMessage("LibItemBonus "..s)
end

if DEBUG_ItemBonusLib then
	lib.Debug = lib.Print
else
	lib.Debug = function () end
end

function lib:error(msg)
	self:Print("Error (%s)", msg)
end

do -- tooltip, frame & events
	local tooltip = lib.tooltip
	if not tooltip then
		tooltip = CreateFrame("GameTooltip")
		local lefts, rights = {}, {}
		for i = 1, 30 do
			local left, right = tooltip:CreateFontString(), tooltip:CreateFontString()
			left:SetFontObject(GameFontNormal)
			right:SetFontObject(GameFontNormal)
			tooltip:AddFontStrings(left, right)
			lefts[i], rights[i] = left, right
		end
		tooltip.lefts, tooltip.rights = lefts, rights
	end
	lib.tooltip = tooltip
	local frame = lib.frame or CreateFrame("Frame")

	function tooltip:SetLink(link)
		self:SetOwner(frame)
		self:ClearLines()
		self:SetHyperlink(link)
	end

	frame:UnregisterAllEvents()

	local waitTime = 1
	frame:SetScript("OnUpdate", function(self, elapsed)
		waitTime = waitTime - elapsed
		if waitTime < 0 then
			lib:ScanEquipment()
			self:Hide()
		end
	end)

	frame:SetScript("OnEvent", function (self, event, unit)
		if unit == "player" then
			waitTime = .25
			self:Show()
		end
	end)
	frame:RegisterEvent"UNIT_INVENTORY_CHANGED"
	frame:Show()
	lib.frame = frame

	lib.events = lib.events or LibStub("CallbackHandler-1.0"):New(lib)
end

local GetPattern
do
-- This is very much a rippof of Deformat, simplified in that it does not
-- handle merged patterns
	local select = select
	local tonumber = tonumber
	local string_match = string.match
	local function donothing() end

	local sequences = {
		["%d*d"] = "%%-?%%d+",
		["s"] = ".+",
		["[fg]"] = "%%-?%%d+%%.?%%d*",
		["%%%.%d[fg]"] = "%%-?%%d+%%.?%%d*",
		["c"] = ".",
	}

	local function get_first_pattern(s)
		local first_pos, first_pattern
		for pattern in pairs(sequences) do
			local pos = s:find("%%%%"..pattern)
			if pos and (not first_pos or pos < first_pos) then
				first_pos, first_pattern = pos, pattern
			end
		end
		return first_pattern
	end

	local function get_indexed_pattern(s, i)
		for pattern in pairs(sequences) do
			if s:find("%%%%" .. i .. "%%%$" .. pattern) then
				return pattern
			end
		end
	end

	local function unpattern_unordered(unpattern, f)
		local i = 1
		while true do
			local pattern = get_first_pattern(unpattern)
			if not pattern then return unpattern, i > 1 end

			unpattern = unpattern:gsub("%%%%" .. pattern, "(" .. sequences[pattern] .. ")", 1)
			f[i] = (pattern ~= "c" and pattern ~= "s")
			i = i + 1
		end
	end

	local function unpattern_ordered(unpattern, f)
		local i = 1
		while true do
			local pattern = get_indexed_pattern(unpattern, i)
			if not pattern then return unpattern, i > 1 end

			unpattern = unpattern:gsub("%%%%" .. i .. "%%%$" .. pattern, "(" .. sequences[pattern] .. ")", 1)
			f[i] = (pattern ~= "c" and pattern ~= "s")
			i = i + 1
		end
	end

	function GetPattern(pattern)
		local unpattern, f, matched = '^' .. pattern:gsub("([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1") .. '$', {}
		if not pattern:find("%1$", nil, true) then
			unpattern, matched = unpattern_unordered(unpattern, f)
			if not matched then
				return donothing
			else
				local locals, returns = {}, {}
				for index, number in ipairs(f) do
					local l = ("v%d"):format(index)
					locals[index] = l
					if number then
						returns[#returns + 1] = "n("..l..")"
					else
						returns[#returns + 1] = l
					end
				end
				locals = table.concat(locals, ",")
				returns = table.concat(returns, ",")
				local code = ("local m, n = string.match, tonumber return function(s) local %s = m(s, %q) return %s end"):format(locals, unpattern, returns)
				return assert(loadstring(code))()
			end
		else
			unpattern, matched = unpattern_ordered(unpattern, f)
			if not matched then
				return donothing
			else
				local i, o = 1, {}
				pattern:gsub("%%(%d)%$", function(w) o[i] = tonumber(w); i = i + 1; end)
				local sorted_locals, returns = {}, {}
				for index, number in ipairs(f) do
					local l = ("v%d"):format(index)
					sorted_locals[index] = ("v%d"):format(o[index])
					if number then
						returns[#returns + 1] = "n("..l..")"
					else
						returns[#returns + 1] = l
					end
				end
				sorted_locals = table.concat(sorted_locals, ",")
				returns = table.concat(returns, ",")
				local code =("local m, n = string.match, tonumber return function(s) local %s = m(s, %q) return %s end"):format(sorted_locals, unpattern, returns)
				return assert(loadstring(code))()
			end
		end
	end
	lib.GetPattern = GetPattern
end

local CHAT_COMMAND = "ibonus"
local ABOUT_ADDON = "An addon to get information about bonus from equipped items"
local SHOW_CMD = "show"
local SHOW_ABOUT = "Show all bonuses from the current equipment"
local SHOW_INFO = "Current equipment bonuses:"
local DETAILS_CMD = "details"
local DETAILS_ABOUT = "Shows bonuses with slot distribution"
local DETAILS_INFO = "Current equipment bonus details:"
local ITEM_CMD = "item"
local ITEM_ABOUT = "show bonuses of given itemlink"
local ITEM_USAGE = "<itemlink>"
local ITEM_INFO = "Bonuses for %s:"
local ITEM_SET = "Item is part of set [%s]"
local SET_BONUS = " %sBonus for %d pieces :"
local SLOT_CMD = "slot"
local SLOT_ABOUT = "show bonuses of given slot"
local SLOT_USAGE = "<slotname>"
local SLOT_INFO = "Bonuses of slot %s:"
local INSPECT_CMD = "inspect"
local INSPECT_ABOUT = "show bonuses of the equipment of the given unit (must be able to inspect the unit)"
local INSPECT_USAGE = "<unit>"
local INSPECT_ERROR = "Unable to inspect unit \"%s\""
local INSPECT_INFO = "Bonuses of \"%s\":"
local L
local get_speed
do -- Locale
	local locale = GetLocale()
	if locale == "frFR" then
		-- CHAT_COMMAND = "ibonus"
		ABOUT_ADDON = "Un addon pour obtenir les bonus concernant les items équipés"
		-- SHOW_CMD = "show"
		SHOW_ABOUT = "Afficher tous les bonus de l'équipement actuel"
		SHOW_INFO = "Bonus de l'équipement actuel :"
		-- DETAILS_CMD = "details"
		DETAILS_ABOUT = "Afficher les détails des bonus par emplacement d'inventaire"
		DETAILS_INFO = "Détails des bonus de l'équipement :"
		-- ITEM_CMD = "item"
		 ITEM_ABOUT = "Afficher les bonus détectés sur l'objet donnée"
		-- ITEM_USAGE = "<itemlink>"
		ITEM_INFO = "Bonus de %s :"
		ITEM_SET = "L'objet fait partie du set [%s]"
		SET_BONUS = " %sBonus pour %d pièces :"
		-- SLOT_CMD = "slot"
		SLOT_ABOUT = "Afficher les bonus de l'emplacement spécifié"
		SLOT_USAGE = "<emplacement>"
		SLOT_INFO = "Bonus de l'emplacement %s:"
		-- INSPECT_CMD = "inspect"
		INSPECT_ABOUT = "Afficher les bonus de l'équipement de l'unité donnée (vous devez être en mesure d'inspecter l'unité"
		INSPECT_USAGE = "<unité>"
		INSPECT_ERROR = "Impossible d'inspecter l'unité \"%s\""
		INSPECT_INFO = "Bonus de \"%s\" :"
		get_speed = function (s)
			return tonumber(s:sub(9):gsub(",", "."), nil)
		end
	elseif locale == "zhTW" then
		-- CHAT_COMMAND = "ibonus"

		ABOUT_ADDON = "一個用來取得裝備屬性加成訊息的插件"
		SHOW_CMD = "顯示"
		SHOW_ABOUT = "顯示所有現在所穿的裝備屬性加成"
		SHOW_INFO = "現在所穿的裝備屬性加成:"
		DETAILS_CMD = "詳細數據"
		DETAILS_ABOUT = "顯示屬性加成的位置分佈"

		DETAILS_INFO = "現在所穿的裝備屬性加成詳細數據:"
		ITEM_CMD = "物品"
		ITEM_ABOUT = "顯示屬性加成的物品連結"--"show bonuses of given itemlink"
		ITEM_USAGE = "<物品連結>"
		ITEM_INFO = "屬性加成 %s:"
		ITEM_SET = "Item is part of set [%s]"

		SET_BONUS = " %sBonus for %d pieces :"
		SLOT_CMD = "位置"
		SLOT_ABOUT = "顯示屬性加成的位置"--"show bonuses of given slot"
		SLOT_USAGE = "<位置名稱>"
		SLOT_INFO = "屬性加成的位置 %s:"
		INSPECT_CMD = "觀察"

		INSPECT_ABOUT = "顯示目標現在所穿的裝備屬性加成 (必須對目標點擊觀察)"
		INSPECT_USAGE = "<查詢目標>"
		INSPECT_ERROR = "目標不能觀察 \"%s\""
		INSPECT_INFO = "屬性加成 \"%s\":"
	elseif locale == "deDE" then
		CHAT_COMMAND = "ibonus"
		ABOUT_ADDON = "Ein Addon um Item-Boni-Informationen deiner Ausr\195\188stung aufzulisten"
		SHOW_CMD = "Auflisten"
		SHOW_ABOUT = "Zeige alle Boni der aktuellen Ausr\195\188stung"
		SHOW_INFO = "Derzeitige Ausr\195\188stungs-Boni:"
		DETAILS_CMD = "Details"
		DETAILS_ABOUT = "Zeige Boni nach Slot-Verteilung"
		DETAILS_INFO = "Derzeitige Ausr\195\188stungs-Boni Details:"
		ITEM_CMD = "Item"
		ITEM_ABOUT = "zeige Boni eines Item-Links"
		ITEM_USAGE = "<itemlink>"
		ITEM_INFO = "Boni f\195\188r %s:"
		ITEM_SET = "Item ist Teil des [%s] Sets"
		SET_BONUS = " %sBonus f\195\188r %d Teile :"
		SLOT_CMD = "Slot"
		SLOT_ABOUT = "zeige Boni f\195\188r bestimten Slot"
		SLOT_USAGE = "<slotname>"
		SLOT_INFO = "Boni f\195\188r Slot %s:"
		INSPECT_CMD = "Inspizieren"
		INSPECT_ABOUT = "zeige Boni der Ausr\195\188stung eines anderen Spielers"
		INSPECT_USAGE = "<unit>"
		INSPECT_ERROR = "Kann die Ausr\195\188stung von \"%s\" nicht einsehen"
		INSPECT_INFO = "Boni von \"%s\":"
		get_speed = function (s)
			return tonumber(s:sub(7):gsub(",", "."), nil)
		end
	elseif locale == "koKR" then
		ABOUT_ADDON = "착용 장비의 보너스 효과에 대한 정보를 작성하는 애드온입니다"
		SHOW_CMD = "표시"
		SHOW_ABOUT = "현재 착용 장비의 모든 보너스 표시"
		SHOW_INFO = "현재 착용 장비 보너스:"
		DETAILS_CMD = "상세정보"
		DETAILS_ABOUT = "슬롯 부위별 보너스를 표시합니다"
		DETAILS_INFO = "현재 착용 보너스 상세정보:"
		ITEM_CMD = "아이템"
		ITEM_ABOUT = "주어진 아이템 링크에 대한 보너스를 표시합니다."
		ITEM_USAGE = "<아이템링크>"
		ITEM_INFO = "%s의 보너스 효과:"
		ITEM_SET = "[%s] 세트의 부분 아이템"
		SET_BONUS = "%d 피스 %s 보너스 효과"
		SLOT_CMD = "슬롯"
		SLOT_ABOUT = "주어진 슬롯에 대한 보너스 효과 표시"
		SLOT_USAGE = "<슬롯명칭>"
		SLOT_INFO = "%s 슬롯의 보너스 효과:"
		INSPECT_CMD = "살펴보기"
		INSPECT_ABOUT = "주어진 대상의 장비에 대한 보너스 효과 표시(대상 살펴보기가 가능해야 합니다)"
		INSPECT_USAGE = "<대상>"
		INSPECT_ERROR = "\"%s\" 대상을 조사할 수 없습니다."
		INSPECT_INFO = "\"%s\"의 보너스 효과:"
	elseif locale == "ruRU" then
		-- CHAT_COMMANDS = { "/ibonus" }
		ABOUT_ADDON = "Аддон для получения информации о бонусах с вещей"
		-- SHOW_CMD = "показать"
		SHOW_ABOUT = "Показать бонусы текущего снаряжения"
		SHOW_INFO = "Бонусы текущего снаражения:"
		-- DETAILS_CMD = "детали"
		DETAILS_ABOUT = "Показывает бонусы с распределением по слотам"
		DETAILS_INFO = "Детальные бонусы текущего снаряжения:"
		-- ITEM_CMD = "итем"
		ITEM_ABOUT = "показывает бонусы по переданной ссылке на предмет"
		-- ITEM_USAGE = "<itemlink>"
		ITEM_INFO = "Бонусы на %s:"
		ITEM_SET = "Этот предмет часть сета [%s]"
		SET_BONUS = " %sБонус за %d частей :"
		-- SLOT_CMD = "слот"
		SLOT_ABOUT = "Показывает бонусы к выбранному слоту"
--~ 		SLOT_USAGE = "<slotname>"
		SLOT_INFO = "Бонусы слота %s:"
		-- INSPECT_CMD = "инспект"
		INSPECT_ABOUT = "показывает бонусы экипировки выбранного персонажа (у вас должна быть возможность его проинспектить)"
--~ 		INSPECT_USAGE = "<unit>"
		INSPECT_ERROR = "Невозможно проинспектить \"%s\""
		INSPECT_INFO = "Бонусы у \"%s\":"
		get_speed = function (s)
			return tonumber(s:sub(18):gsub(",", "."), nil)
		end
	end
end
if not get_speed then
	local l = WEAPON_SPEED:len() + 2
	get_speed = function (s)
		return tonumber(s:sub(l))
	end
end

-- bonuses[BONUS] = VALUE
-- details[BONUS][SLOT] = VALUE
-- items[LINK].bonuses[BONUS] = VALUE
-- items[LINK].set = SETNAME
-- items[LINK].set_line = number
-- sets[SETNAME].bonuses[NUM][BONUS] = VALUE
-- sets[SETNAME].scan_count = COUNT
-- sets[SETNAME].scan_bonuses = COUNT
local bonuses, details, items, sets = {}, {}, {}, {}

local slots = {
	["Head"] = true,
	["Neck"] = true,
	["Shoulder"] = true,
	["Shirt"] = true,
	["Chest"] = true,
	["Waist"] = true,
	["Legs"] = true,
	["Feet"] = true,
	["Wrist"] = true,
	["Hands"] = true,
	["Finger0"] = true,
	["Finger1"] = true,
	["Trinket0"] = true,
	["Trinket1"] = true,
	["Back"] = true,
	["MainHand"] = true,
	["SecondaryHand"] = true,
	["Ranged"] = true,
	["Tabard"] = true,
}
for s in pairs(slots) do
	slots[s] = GetInventorySlotInfo (s.."Slot")
end


local discard_on_add = {
	WEAPON_MIN = true,
	WEAPON_MAX = true,
	WEAPON_SPEED = true,
}
do -- options & OnInitialize()
	local options = {
		type = "group",
		desc = ABOUT_ADDON,
		args = {
			show = {
				type = "execute",
				name = SHOW_CMD,
				desc = SHOW_ABOUT,
				func = function ()
					lib:Print(SHOW_INFO)
					for bonus in pairs(bonuses) do
						local type, value = lib:GetFriendlyBonus(bonus, bonuses)
						lib:Print("%s : %f", lib:GetBonusFriendlyName(type), value)
					end
				end
			},
			details = {
				type = "execute",
				name = DETAILS_CMD,
				desc = DETAILS_ABOUT,
				func = function ()
					lib:Print(DETAILS_INFO)
					for bonus, detail in pairs(details) do
						local s = {}
						for slot, value in pairs(detail) do
							table.insert(s, string.format("%s : %d", slot, value))
						end
						local type, value = lib:GetFriendlyBonus(bonus, bonuses)
						if type ~= bonus then
							value = string.format("%s (%s : %d)", tostring(bonuses[bonus]), lib:GetBonusFriendlyName(type), value)
						else
							value = tostring(bonuses[bonus])
						end
						lib:Print("%s : %s (%s)", lib:GetBonusFriendlyName(bonus), value, table.concat(s, ", "))
					end
				end
			},
			item = {
				type = "input",
				name = ITEM_CMD,
				desc = ITEM_ABOUT,
				usage = ITEM_USAGE,
				get = false,
				set = function (_, link)
					local info = lib:ScanItemLink(link)
					lib:Print(ITEM_INFO, link)
					for bonus, value in pairs(info.bonuses) do
						lib:Print("%s : %s", lib:GetBonusFriendlyName(bonus), value)
					end
					if info.set then
						lib:Print(ITEM_SET, info.set)
						local set = sets[info.set]
						for number, bonuses in pairs(set.bonuses) do
							local has_bonus = number <= set.count and "*" or " "
							lib:Print(SET_BONUS, has_bonus, number)
							for bonus, value in pairs(bonuses) do
								lib:Print(" %s : %s", lib:GetBonusFriendlyName(bonus), value)
							end
						end
					end
				end
			},
			slot = {
				type = "input",
				name = SLOT_CMD,
				desc = SLOT_ABOUT,
				usage = SLOT_USAGE,
				get = false,
				set = function (_, slot)
					lib:Print(SLOT_INFO, slot)
					for bonus, detail in pairs(details) do
						if detail[slot] then
							lib:Print("%s : %s", lib:GetBonusFriendlyName(bonus), detail[slot])
						end
					end
				end
			},
			inspect = {
				type = "input",
				name = INSPECT_CMD,
				desc = INSPECT_ABOUT,
				usage = INSPECT_USAGE,
				get = false,
				set = function (_, unit)
					local eq = lib:GetUnitEquipment(unit)
					if not eq then
						lib:Print(string.format(INSPECT_ERROR, unit))
						return
					end
					local b = lib:MergeDetails(lib:BuildBonusSet(eq))
					local n = UnitName(unit)
					local level = UnitLevel(unit)
					if n then
						n = string.format("|Hplayer:%s|h[%s]|h", n, n)
					else
						n = unit
					end
					lib:Print(string.format(INSPECT_INFO, n))
					for bonus in pairs(b) do
						local type, value = lib:GetFriendlyBonus(bonus, b, level)
						lib:Print("%s : %d", lib:GetBonusFriendlyName(type), value)
					end
				end
			},
		},
	}

	function lib:OnInitialize()
		L = self.patterns

		local l = LibStub("AceConfig-3.0", true)
		if l then l:RegisterOptionsTable("LibItemBonus", options) end
		l = LibStub("AceConfigCmd-3.0", true)
		if l then l:CreateChatCommand(CHAT_COMMAND, "LibItemBonus") end
		self.OnInitialize = nil
	end
end

local cleanItemLink
do -- AddValue & line scanning
	local trim = function (str)
		return strtrim(str, "\t \194\160"):gsub("%.$", "")
	end

	local equip = ITEM_SPELL_TRIGGER_ONEQUIP
	local l_equip = equip:len()

	function cleanItemLink(itemLink)
		local link = itemLink:match("|H(item[%d:]*)|")
		return link or itemLink
	end

	local otherEffect = {
		CR_HIT = "CR_SPELLHIT",
		CR_CRIT = "CR_SPELLCRIT",
		CR_HASTE = "CR_SPELLHASTE",
		CR_HIT_TAKEN = "CR_SPELLHIT_TAKEN",
	}

	function lib:AddValue(bonuses, effect, value)
		if type(effect) == "string" then
			bonuses[effect] = (bonuses[effect] or 0) + value
			effect = otherEffect[effect]
			if effect then
				bonuses[effect] = (bonuses[effect] or 0) + value
			end
		elseif type(value) == "table" then
			for i, e in ipairs(effect) do
				self:AddValue (bonuses, e, value[i])
			end
		else
			for _, e in ipairs(effect) do
				self:AddValue (bonuses, e, value)
			end
		end
	end

	function lib:AddValueMultiple(bonuses, effect, ...)
		if not ... then return end
		local n = select("#", ...)
		if n > 1 then
			assert(type(effect) == "table" and #effect == n)
			for i, e in ipairs(effect) do
				self:AddValue(bonuses, e, select(i, ...))
			end
		else
			self:AddValue(bonuses, effect, ...)
		end
		return true
	end
	function lib:CheckPassive(bonuses, line)
		for _, p in pairs(L.PATTERNS_PASSIVE) do
			local r = self:AddValueMultiple(bonuses, p.effect, line:match(p.pattern))
			if r then return r end
		end
	end

	function lib:CheckToken(bonuses, token, value)
		local t = L.PATTERNS_GENERIC_LOOKUP[token:lower()]
		if t then
			self:AddValue (bonuses, t, value)
			return true
		else
			local s1, s2

			for _, p in ipairs(L.PATTERNS_GENERIC_STAGE1) do
				if token:find (p.pattern, 1, 1) then
					s1 = p.effect
					break
				end
			end
			for _, p in ipairs(L.PATTERNS_GENERIC_STAGE2) do
				if token:find(p.pattern, 1, 1) then
					s2 = p.effect
					break
				end
			end
			if s1 and s2 then
				self:Debug("Detected %q as a generic %s%s", token, s1, s2)
				self:AddValue (bonuses, s1..s2, value)
				return true
			end
		end
		self:Debug("CheckToken failed for \"%s\" (%s)", token, value)
	end


	function lib:CheckSingleGeneric(bonuses, line)
		line = trim (line)
		if self:CheckSkillRating(bonuses, line) then
			return true
		end
		for pattern, invert in pairs(L.GENERIC_PATTERNS) do
			local token, value = line:match(pattern)
			if token and value then
				if invert then
					token, value = value, token
				end
				token, value = trim(token), trim(value)
				if self:CheckToken(bonuses, token, value) then
					return true
				end
			end
		end
	end

	function lib:CheckGeneric(bonuses, line)
		local found = self:CheckSingleGeneric(bonuses, line)

		if not found then
			while line:len() > 0 do
				local tmpStr
				for _, sep in ipairs(L.SEPARATORS) do
					local lstart, lend  = line:find(sep, 1, true)
					if lstart then
						tmpStr = line:sub(1, lstart - 1)
						line = line:sub(lend + 1)
						break
					end
				end
				if tmpStr then
					found = self:CheckSingleGeneric(bonuses, tmpStr) or found
				else
					found = self:CheckSingleGeneric(bonuses, line) or found
					break
				end
			end
		end
		return found
	end

	function lib:AddOtherValue(bonuses, p, start, stop, ...)
		if start then
			if p.value then
				self:AddValue(bonuses, p.effect, p.value)
				return true
			elseif ... then
				self:AddValueMultiple(bonuses, p.effect, ...)
				return true
			end
		end
	end

	function lib:CheckOther(bonuses, line)
		for _, p in ipairs(L.PATTERNS_OTHER) do
			local result = self:AddOtherValue(bonuses, p, line:find (p.pattern))
			if result then return result end
		end
	end

	function lib:CheckSkillRating(bonuses, line)
		for _, p in ipairs(L.PATTERNS_SKILL_RATING) do
			local rating, value = line:match(p.pattern)
			if p.invert then
				value, rating = rating, value
			end
			if rating then
				local bonus = L.SKILL_NAMES[rating]
				if bonus then
					self:AddValue(bonuses, bonus, value)
					return true
				else
					self:Debug("Unknown rating \"%s\"", rating)
					return
				end
			end
		end
	end

	function lib:AddBonusInfo(bonuses, line)
		local found
		line = strtrim(line)
		if line:sub(0, 2) == "|c" then
			-- fix for white enchants
			-- @WARNING: may cut more than intented, but it's perfect for meta gems.
			line = strtrim(line:sub(11, line:find("|r") - 1))
		end
		if line:sub(0, l_equip) == equip then
			line = strtrim(line:sub(l_equip + 2))
		end
		if
			not self:CheckPassive (bonuses, line)
			and not self:CheckOther(bonuses, line) -- other has precedence so that meta gems are parsed there first
			and not self:CheckGeneric(bonuses, line)
		then
			self:Debug("Unmatched bonus line \"%s\"", line)
		end
	end
end

do -- Item scanning
	local p_ITEM_SET_NAME = GetPattern(ITEM_SET_NAME)
	local p_ITEM_SET_BONUS = GetPattern(ITEM_SET_BONUS)
	local p_ITEM_SET_BONUS_GRAY = GetPattern(ITEM_SET_BONUS_GRAY)
	local p_ITEM_SOCKET_BONUS = GetPattern(ITEM_SOCKET_BONUS)
	local p_DAMAGE_TEMPLATE = GetPattern(DAMAGE_TEMPLATE)
	local p_DAMAGE_TEMPLATE_WITH_SCHOOL = GetPattern(DAMAGE_TEMPLATE_WITH_SCHOOL)

	local function tooltip_SetLink(link, bonuses)
		lib.tooltip:SetLink(lib:CheckEnchantId(link, bonuses))
	end

	function lib:ScanItemLink(link, no_cache)
		link = cleanItemLink(link)
		local info = not no_cache and items[link]
		local scan_set, set_name, set_count, set_total
		if not info then
			info = { bonuses = {} }
			tooltip_SetLink(link, info.bonuses)
			for i = 2, self.tooltip:NumLines() do
				local line = self.tooltip.lefts[i]:GetText()

				-- The following is needed after 2.2 because meta-gem
				-- requirements are appened after the bonus. (thanks Lerkur)
				if line:find("\n", nil, true) then
					line = strsplit("\n", line)
				end

				set_name, set_count, set_total = p_ITEM_SET_NAME(line)
				if set_name then
					info.set = set_name
					info.set_line = i
					local set = sets[set_name]
					if not set or set.scan_count > set_count and set.scan_bonuses > 1 then
						scan_set = true
					end
					break
				end
				local bonus = p_ITEM_SOCKET_BONUS(line)
				if bonus then
					-- evil hack, I need to check the color of the string to know
					-- if the bonus is active or not.
					local frame = self.tooltip.lefts[i]
					local r, g, b = frame:GetTextColor()
					self:Debug("Found Gem Bonus line \"%s\" : color = %f, %f, %f", bonus, r, g, b)
					if r <= 0.1 and g >= 0.9 and b <= 0.1 then
						self:AddBonusInfo(info.bonuses, bonus)
					else
						local b = info.inactive_gem_bonus
						if not b then
							b = {}
							info.inactive_gem_bonus = b
						end
						self:AddBonusInfo(b, bonus)
					end
				else
					local dmg_min, dmg_max = p_DAMAGE_TEMPLATE(line)
					if not dmg_min then
						dmg_min, dmg_max = p_DAMAGE_TEMPLATE_WITH_SCHOOL(line)
					end
					if not dmg_min then
						self:AddBonusInfo(info.bonuses, line)
					else
						local b = info.bonuses
						b.WEAPON_MIN = dmg_min
						b.WEAPON_MAX = dmg_max
						b.WEAPON_SPEED = get_speed(self.tooltip.rights[i]:GetText())
					end
				end
			end
			if not no_cache then
				items[link] = info
			end
		elseif info.set and sets[info.set].scan_count > 2 then
			tooltip_SetLink(link, nil)
			set_name, set_count, set_total = p_ITEM_SET_NAME(self.tooltip.lefts[info.set_line]:GetText())
			local set = sets[set_name]
			if not set or set.scan_count > set_count and set.scan_bonuses > 1 then
				scan_set = true
			end
		end
		if scan_set then
			self:Debug("Scanning set \"%s\"", set_name)
			local set = { count = 0, bonuses = {}, scan_count = set_count, scan_bonuses = 0 }
			local tt = self.tooltip
			local numlines, maxlines = tt:NumLines(), #tt.lefts
			if maxlines < numlines then
				self:Print("Error: Not enough lines to parse the tooltip of %s. I need %d lines.", link, numlines)
				numlines = maxlines
			end
			for i = info.set_line + set_total + 2, numlines do
				local line = tt.lefts[i]:GetText()
				local count, bonus
				local bonus = p_ITEM_SET_BONUS(line)
				if bonus then
					set.scan_bonuses = set.scan_bonuses + 1
					count = set_count
				else
					count, bonus = p_ITEM_SET_BONUS_GRAY(line)
				end
				if not bonus then
					self:Debug("Invalid set line \"%s\"", line)
					-- break
				else
					local bonuses = set.bonuses[count] or {}
					self:AddBonusInfo(bonuses, bonus, true)
					set.bonuses[count] = bonuses
				end
			end
			sets[set_name] = set
		end
		return info
	end
end

function lib:GetUnitEquipment(unit)
	local inspect
	if unit ~= "player" and (unit ~= "target" or not InspectFrame or not InspectFrame:IsShown()) then
		if not CheckInteractDistance(unit, 1) or
				not CanInspect(unit, true) then
			return nil
		end
		HideUIPanel(InspectFrame)
		NotifyInspect(unit)
		inspect = true
	end
	local eq = {}
	for slot, id in pairs(slots) do
		eq[slot] = GetInventoryItemLink(unit, id)
	end
	if inspect then
		ClearInspectPlayer()
	end
	return eq
end

local function mergeBonusTable(result, operand)
	for k, v in pairs(operand) do
		result[k] = (result[k] or 0) + v
	end
end

function lib:BuildBonusSet(eq)
	local details = {}
	local set_count = {}
	for slot, link in pairs(eq) do
		local info = self:ScanItemLink(link)
		local set = info.set
		if set then
			set_count[set] = (set_count[set] or 0) + 1
		end
		for bonus, value in pairs(info.bonuses) do
			local b = details[bonus]
			if not b then
				b = {}
				details[bonus] = b
			end
			b[slot] = value
		end
	end
	for set, count in pairs(set_count) do
		local info = sets[set]
		for i = 2, count do
			local bonuses = info.bonuses[i]
			if bonuses then
				for bonus, value in pairs(bonuses) do
					local b = details[bonus]
					if not b then
						b = {}
						details[bonus] = b
					end
					b.Set = (b.Set or 0) + value
				end
			end
		end
	end
	return details, set_count
end

function lib:MergeDetails(details)
	local bonuses = {}
	for bonus, slots in pairs(details) do
		if not discard_on_add[bonus] then
			for slot, value in pairs(slots) do
				bonuses[bonus] = (bonuses[bonus] or 0) + value
			end
		end
	end
	return bonuses
end

do
	local ace2event, ace3event
	function lib:TriggerEvent(...)
		self.events:Fire(...)

		if ace2event == nil then
			ace2event = AceLibrary and AceLibrary:HasInstance("AceEvent-2.0")
				and AceLibrary("AceEvent-2.0") or false
		end
		if ace2event then
			ace2event:TriggerEvent(...)
		end

		if ace3event == nil then
			ace3event = LibStub("AceEvent-3.0", true) or false
		end
		if ace3event then
			ace3event:SendMessage(...)
		end
	end
end

function lib:ScanEquipment()
	local eq = self:GetUnitEquipment("player")
	details = self:BuildBonusSet(eq)
	bonuses = self:MergeDetails(details)
	self.bonuses = bonuses
	self:TriggerEvent("ItemBonusLib_Update")
end


function lib:Reload()
	self:ClearCache()
	self:ScanEquipment()
end

function lib:ClearCache()
	items, sets = {}, {}
end

function lib:GetSetBonuses(set)
	local info = sets[set]
	if info then
		return info.bonuses
	end
end

-- BonusScanner compatible API
lib.bonuses = bonuses

function lib:GetSlotBonuses (slotname)
	local bonuses = {}
	for bonus, detail in pairs(details) do
		if detail[slotname] then
			bonuses[bonus] = detail[slotname]
		end
	end
	return bonuses
end

function lib:GetBonusDetails (bonus)
	return details[bonus] or {}
end

function lib:GetSlotBonus (bonus, slotname)
	local detail = details[bonus]
	return detail and detail[slotname] or 0
end

function lib:GetBonusFriendlyName (bonus)
	return L.NAMES[bonus] or bonus
end

function lib:IsActive ()
	return true
end

function lib:ScanItem (itemlink, excludeSet, no_cache)
	if not excludeSet then
		self:error("excludeSet can't be false on BonusScanner compatible API")
	end
	local name, link = GetItemInfo(itemlink)
	if not name then
		return
	end
	return self:ScanItemLink(link, no_cache).bonuses
end

function lib:ScanTooltipFrame (frame, excludeSet)
	self:error("BonusScanner:ScanTooltipFrame() is not available")
end
