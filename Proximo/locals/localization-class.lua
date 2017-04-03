--Since Proximo is using select(2, UnitClass(unitid)) (the all caps enUS word) to
--do all syncing, I need an easy way to translate back to the local class name
--and BabbleClass was overkill and not converted to AceLocale-3.0

local PC = LibStub("AceLocale-3.0"):NewLocale("ProximoClass","enUS",true)
if PC then
PC["WARLOCK"] = "Warlock"
PC["WARRIOR"] = "Warrior"
PC["HUNTER"] = "Hunter"
PC["MAGE"] = "Mage"
PC["PRIEST"] = "Priest"
PC["DRUID"] = "Druid"
PC["PALADIN"] = "Paladin"
PC["SHAMAN"] = "Shaman"
PC["ROGUE"] = "Rogue"
end

PC = LibStub("AceLocale-3.0"):NewLocale("ProximoClass","deDE")
if PC then
PC["WARLOCK"] = "Hexenmeister"
PC["WARRIOR"] = "Krieger"
PC["HUNTER"] = "J\195\164ger"
PC["MAGE"] = "Magier"
PC["PRIEST"] = "Priester"
PC["DRUID"] = "Druide"
PC["PALADIN"] = "Paladin"
PC["SHAMAN"] = "Schamane"
PC["ROGUE"] = "Schurke"
end

PC = LibStub("AceLocale-3.0"):NewLocale("ProximoClass","frFR")
if PC then
PC["WARLOCK"] = "Démoniste"
PC["WARRIOR"] = "Guerrier"
PC["HUNTER"] = "Chasseur"
PC["MAGE"] = "Mage"
PC["PRIEST"] = "Prêtre"
PC["DRUID"] = "Druide"
PC["PALADIN"] = "Paladin"
PC["SHAMAN"] = "Chaman"
PC["ROGUE"] = "Voleur"
end

PC = LibStub("AceLocale-3.0"):NewLocale("ProximoClass","zhCN")
if PC then
PC["WARLOCK"] = "术士"
PC["WARRIOR"] = "战士"
PC["HUNTER"] = "猎人"
PC["MAGE"] = "法师"
PC["PRIEST"] = "牧师"
PC["DRUID"] = "德鲁伊"
PC["PALADIN"] = "圣骑士"
PC["SHAMAN"] = "萨满祭司"
PC["ROGUE"] = "潜行者"
end

PC = LibStub("AceLocale-3.0"):NewLocale("ProximoClass","zhTW")
if PC then
PC["WARLOCK"] = "術士"
PC["WARRIOR"] = "戰士"
PC["HUNTER"] = "獵人"
PC["MAGE"] = "法師"
PC["PRIEST"] = "牧師"
PC["DRUID"] = "德魯伊"
PC["PALADIN"] = "聖騎士"
PC["SHAMAN"] = "薩滿"
PC["ROGUE"] = "盜賊"
end

PC = LibStub("AceLocale-3.0"):NewLocale("ProximoClass","koKR")
if PC then
PC["WARLOCK"] = "흑마법사"
PC["WARRIOR"] = "전사"
PC["HUNTER"] = "사냥꾼"
PC["MAGE"] = "마법사"
PC["PRIEST"] = "사제"
PC["DRUID"] = "드루이드"
PC["PALADIN"] = "성기사"
PC["SHAMAN"] = "주술사"
PC["ROGUE"] = "도적"
end

PC = LibStub("AceLocale-3.0"):NewLocale("ProximoClass","esES")
if PC then
PC["WARLOCK"] = "Brujo"
PC["WARRIOR"] = "Guerrrero"
PC["HUNTER"] = "Cazador"
PC["MAGE"] = "Mago"
PC["PRIEST"] = "Sacerdote"
PC["DRUID"] = "Druida"
PC["PALADIN"] = "Palad\195\173n"
PC["SHAMAN"] = "Cham\195\161n"
PC["ROGUE"] = "P\195\173caro"
end

PC = LibStub("AceLocale-3.0"):NewLocale("ProximoClass","ruRU")
if PC then
PC["WARLOCK"] = "Чернокнижник"
PC["WARRIOR"] = "Воин"
PC["HUNTER"] = "Охотник"
PC["MAGE"] = "Маг"
PC["PRIEST"] = "Жрец"
PC["DRUID"] = "Друид"
PC["PALADIN"] = "Паладин"
PC["SHAMAN"] = "Шаман"
PC["ROGUE"] = "Разбойник"
end