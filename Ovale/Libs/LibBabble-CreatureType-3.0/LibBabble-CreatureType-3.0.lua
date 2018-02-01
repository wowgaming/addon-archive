--[[
Name: LibBabble-CreatureType-3.0
Revision: $Rev: 76 $
Maintainers: ckknight, nevcairiel, Ackis
Website: http://www.wowace.com/projects/libbabble-creaturetype-3-0/
Dependencies: None
License: MIT
]]

local MAJOR_VERSION = "LibBabble-CreatureType-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Rev: 76 $"):match("%d+"))

if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local lib = LibStub("LibBabble-3.0"):New(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

local GAME_LOCALE = GetLocale()

lib:SetBaseTranslations {
	Beast = "Beast",
	Critter = "Critter",
	Demon = "Demon",
	Dragonkin = "Dragonkin",
	Elemental = "Elemental",
	["Gas Cloud"] = "Gas Cloud",
	Giant = "Giant",
	Humanoid = "Humanoid",
	Mechanical = "Mechanical",
	["Non-combat Pet"] = "Non-combat Pet",
	["Not specified"] = "Not specified",
	Totem = "Totem",
	Undead = "Undead",
}


if GAME_LOCALE == "enUS" then
	lib:SetCurrentTranslations(true)
elseif GAME_LOCALE == "deDE" then
	lib:SetCurrentTranslations {
	Beast = "Wildtier",
	Critter = "Tier",
	Demon = "Dämon",
	Dragonkin = "Drachkin",
	Elemental = "Elementar",
	["Gas Cloud"] = "Gaswolken",
	Giant = "Riese",
	Humanoid = "Humanoid",
	Mechanical = "Mechanisch",
	["Non-combat Pet"] = "Haustier",
	["Not specified"] = "Nicht spezifiziert",
	Totem = "Totem",
	Undead = "Untoter",
}
elseif GAME_LOCALE == "frFR" then
	lib:SetCurrentTranslations {
	Beast = "Bête",
	Critter = "Bestiole",
	Demon = "Démon",
	Dragonkin = "Draconien",
	Elemental = "Elémentaire",
	["Gas Cloud"] = "Nuage de gaz",
	Giant = "Géant",
	Humanoid = "Humanoïde",
	Mechanical = "Machine",
	["Non-combat Pet"] = "Familier pacifique",
	["Not specified"] = "Non spécifié",
	Totem = "Totem",
	Undead = "Mort-vivant",
}
elseif GAME_LOCALE == "koKR" then
	lib:SetCurrentTranslations {
	Beast = "야수",
	Critter = "동물",
	Demon = "악마",
	Dragonkin = "용족",
	Elemental = "정령",
	["Gas Cloud"] = "가스",
	Giant = "거인",
	Humanoid = "인간형",
	Mechanical = "기계",
	["Non-combat Pet"] = "애완동물",
	["Not specified"] = "기타",
	Totem = "토템",
	Undead = "언데드",
}
elseif GAME_LOCALE == "esES" then
	lib:SetCurrentTranslations {
	Beast = "Bestia",
	Critter = "Alma",
	Demon = "Demonio",
	Dragonkin = "Dragón",
	Elemental = "Elemental",
	["Gas Cloud"] = "Nube de Gas",
	Giant = "Gigante",
	Humanoid = "Humanoide",
	Mechanical = "Mecánico",
	["Non-combat Pet"] = "Mascota no combatiente",
	["Not specified"] = "No especificado",
	Totem = "Tótem",
	Undead = "No-muerto",
}
elseif GAME_LOCALE == "esMX" then
	lib:SetCurrentTranslations {
	Beast = "Bestia",
	Critter = "Alma",
	Demon = "Demonio",
	Dragonkin = "Dragon",
	Elemental = "Elemental",
	-- ["Gas Cloud"] = "",
	Giant = "Gigante",
	Humanoid = "Humanoide",
	Mechanical = "Mecánico",
	["Non-combat Pet"] = "Mascota mansa",
	["Not specified"] = "Sin especificar",
	Totem = "Totém",
	Undead = "No-muerto",
}
elseif GAME_LOCALE == "ruRU" then
	lib:SetCurrentTranslations {
	Beast = "Животное",
	Critter = "Существо",
	Demon = "Демон",
	Dragonkin = "Дракон",
	Elemental = "Элементаль",
	["Gas Cloud"] = "Газовое облако",
	Giant = "Великан",
	Humanoid = "Гуманоид",
	Mechanical = "Механизм",
	["Non-combat Pet"] = "Спутник",
	["Not specified"] = "Не указано",
	Totem = "Тотем",
	Undead = "Нежить",
}
elseif GAME_LOCALE == "zhCN" then
	lib:SetCurrentTranslations {
	Beast = "野兽",
	Critter = "小动物",
	Demon = "恶魔",
	Dragonkin = "龙类",
	Elemental = "元素生物",
	["Gas Cloud"] = "气体云雾",
	Giant = "巨人",
	Humanoid = "人型生物",
	Mechanical = "机械",
	["Non-combat Pet"] = "非战斗宠物",
	["Not specified"] = "未指定",
	Totem = "图腾",
	Undead = "亡灵",
}
elseif GAME_LOCALE == "zhTW" then
	lib:SetCurrentTranslations {
	Beast = "野獸",
	Critter = "小動物",
	Demon = "惡魔",
	Dragonkin = "龍類",
	Elemental = "元素生物",
	["Gas Cloud"] = "氣體雲",
	Giant = "巨人",
	Humanoid = "人型生物",
	Mechanical = "機械",
	["Non-combat Pet"] = "非戰鬥寵物",
	["Not specified"] = "不明",
	Totem = "圖騰",
	Undead = "不死族",
}

else
	error(("%s: Locale %q not supported"):format(MAJOR_VERSION, GAME_LOCALE))
end
