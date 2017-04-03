--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005-2010 Dan Gilbert <dan.b.gilbert@gmail.com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

--[[

-- Atlas Data  (Russian)
-- Compiled by StingerSoft
-- stingersoft@gmail.com
-- Last Update: 27.09.2008

--]]

if ( GetLocale() == "ruRU" ) then

AtlasBGLocale = {

	--Common
	["Alliance"] = "Альянс";
	["Battleground Maps"] = "Карты Полей Сражений";
	["Entrance"] = "Вход";
	["Horde"] = "Орда";
	["Neutral"] = "Нейтральный";
	["North"] = "Север";
	["Orange"] = "Оранжевый";
	["Red"] = "Красный";
	["Reputation"] = "Реп";
	["Rescued"] = "Спасенный";
	["South"] = "Юг";
	["Start"] = "Начало";
	["Summon"] = "Призыв";
	["White"] = "Белый";

	--Places
	["AV"] = "АД"; -- Alterac Valley
	["AB"] = "НА"; -- Arathi Basin
	["Eye of the Storm"] = "Око Бури"; ["EotS"] = "Око";
	["IoC"] = "ОЗ"; -- Isle of Conquest
	["SotA"] = "Берег"; -- Strand of the Ancients
	["WSG"] = "УПВ"; -- Warsong Gulch

	--Alterac Valley (North)
	["Stormpike Guard"] = "Стража Грозовой Вершины";
	["Vanndar Stormpike <Stormpike General>"] = "Вандар Грозовая Вершина <Генерал клана Грозовой Вершины>";
	["Dun Baldar North Marshal"] = "Маршал северного Оплота Дун Балдара";
	["Dun Baldar South Marshal"] = "Маршал южного Оплота Дун Балдара";
	["Icewing Marshal"] = "Маршал Ледяного Крыла";
	["Stonehearth Marshal"] = "Маршал Каменного Очага";
	["Prospector Stonehewer"] = "Геолог Камнегрыз";
	["Morloch"] = "Морлох";
	["Umi Thorson"] = "Уми Торсон";
	["Keetar"] = "Китар";
	["Arch Druid Renferal"] = "Верховный друид Дикая Лань";
	["Dun Baldar North Bunker"] = "Северный Оплот Дун Болдара";
	["Wing Commander Mulverick"] = "Командир звена Малверик";--omitted from AVS
	["Murgot Deepforge"] = "Мургот Подземная Кузня";
	["Dirk Swindle <Bounty Hunter>"] = "Дирк Надувалло <Охотник за головами>";
	["Athramanis <Bounty Hunter>"] = "Атраманис <Охотник за головами>";
	["Lana Thunderbrew <Blacksmithing Supplies>"] = "Лана Грозовар <Товары для кузнецов>";
	["Stormpike Aid Station"] = "Лазарет Грозовой Вершины";
	["Stormpike Stable Master <Stable Master>"] = "Смотритель стойл из клана Грозовой Вершины <Смотритель стойл>";
	["Stormpike Ram Rider Commander"] = "Командир наездников на баранах из клана Грозовой Вершины";
	["Svalbrad Farmountain <Trade Goods>"] = "Свальбрад Дальногор <Хозяйственные товары>";
	["Kurdrum Barleybeard <Reagents & Poison Supplies>"] = "Курдрум Ячменобород <Реагенты и яды>";
	["Stormpike Quartermaster"] = "Интендант клана Грозовой Вершины";
	["Jonivera Farmountain <General Goods>"] = "Джонивера Дальняя Гора <Потребительские товары>";
	["Brogus Thunderbrew <Food & Drink>"] = "Брогус Грозовар <Еда и напитки>";
	["Wing Commander Ichman"] = "Командир звена Ичман";--omitted from AVS
	["Wing Commander Slidore"] = "Командир звена Макарч";--omitted from AVS
	["Wing Commander Vipore"] = "Командир звена Сквороц";--omitted from AVS
	["Dun Baldar South Bunker"] = "Южный Оплот Дун Болдара";
	["Corporal Noreg Stormpike"] = "Капрал Норг Грозовая Вершина";
	["Gaelden Hammersmith <Stormpike Supply Officer>"] = "Гаелден Кузнечный Молот <Снабженец клана Грозовой Вершины>";
	["Stormpike Banner"] = "Знамя Грозовой Вершины";
	["Stormpike Lumber Yard"] = "Stormpike Lumber Yard";
	["Wing Commander Jeztor"] = "Командир звена Мааша";--omitted from AVS
	["Wing Commander Guse"] = "Командир звена Смуггл";--omitted from AVS
	["Stormpike Ram Rider Commander"] = "Командир наездников на баранах из клана Грозовой Вершины";
	["Captain Balinda Stonehearth <Stormpike Captain>"] = "Капитан Балинда Каменный Очаг <Капитан клана Грозовой Вершины>";
	["Ichman's Beacon"] = "Маяк Ичмена";
	["Mulverick's Beacon"] = "Маяк Малверика";
	["Ivus the Forest Lord"] = "Ивус Лесной Властелин";
	["Western Crater"] = "Западный Кратер";
	["Vipore's Beacon"] = "Маяк Сквороца";
	["Jeztor's Beacon"] = "Маяк Мааша";
	["Eastern Crater"] = "Восточный Кратер";
	["Slidore's Beacon"] = "Маяк Макарча";
	["Guse's Beacon"] = "Маяк Смуггла";
	["Graveyards, Capturable Areas"] = "Кладбище, Зоны захвата";--omitted from AVS
	["Bunkers, Towers, Destroyable Areas"] = "Бункеры, Башни, Зоны уничтожения";--omitted from AVS
	["Assault NPCs, Quest Areas"] = "Штурм НИПов, Зоны заданий";--omitted from AVS

	--Alterac Valley (South)
	["Frostwolf Clan"] = "Клан Северного Волка";
	["Drek'Thar <Frostwolf General>"] = "Дрек'Тар <Генерал клана Северного Волка>";
	["Duros"] = "Дарос";
	["Drakan"] = "Дракан";
	["West Frostwolf Warmaster"] = "Воевода западной башни Северного Волка";
	["East Frostwolf Warmaster"] = "Воевода восточной башни Северного Волка";
	["Tower Point Warmaster"] = "Воевода Смотровой башня";
	["Iceblood Warmaster"] = "Воевода Стылой Крови";
	["Lokholar the Ice Lord"] = "Локолар Владыка Льда";
	["Captain Galvangar <Frostwolf Captain>"] = "Капитан Гальвангар <Капитан клана Северного Волка>";
	["Iceblood Tower"] = "Башня Стылой Крови";
	["Tower Point"] = "Смотровая башня";
	["Taskmaster Snivvle"] = "Надсмотрщик Хныкс";
	["Masha Swiftcut"] = "Маша Быстрорезка";
	["Aggi Rumblestomp"] = "Агги Шумнотоп";
	["Jotek"] = "Джотек";
	["Smith Regzar"] = "Кузнец Регзар";
	["Primalist Thurloga"] = "Старейшина Турлога";
	["Sergeant Yazra Bloodsnarl"] = "Сержант Язра Кровавый Рык";
	["Frostwolf Stable Master <Stable Master>"] = "Смотритель стойл из клана Северного Волка <Смотритель стойл>";
	["Frostwolf Wolf Rider Commander"] = "Командир наездников на волках клана Северного Волка";
	["Frostwolf Quartermaster"] = "Интендант клана Северного Волка";
	["West Frostwolf Tower"] = "Западная башня Северного Волка";
	["East Frostwolf Tower"] = "Восточная башня Северного Волка";
	["Frostwolf Relief Hut"] = "Приют Северного Волка";
	["Frostwolf Banner"] = "Знамя Северного Волка";

	--Arathi Basin
	["The Defilers"] = "Осквернители";
	["The League of Arathor"] = "Лига Аратора";

	--Eye of the Storm
	["Flag"] = "Флаг";

	--Isle of Conquest
	["The Refinery"] = "Нефтезавод";
	["The Docks"] = "Причал";
	["The Workshop"] = "Мастерская";
	["The Hangar"] = "Ангар	";
	["The Quarry"] = "Каменоломня";
	["Contested Graveyards"] = "Спорные Кладбища";
	["Horde Graveyard"] = "Кладбище Орды";
	["Alliance Graveyard"] = "Кладбище Альянса";
	["Gates are marked with red bars."] = "Ворота помечены красным.";
	["Overlord Agmar"] = "Командир Агмар";
	["High Commander Halford Wyrmbane <7th Legion>"] = "Главнокомандующий Халфорд Змеевержец <7-й легион>";

	--Strand of the Ancients
	["Attacking Team"] = "Группа штурма";
	["Defending Team"] = "Группа защиты";
	["Massive Seaforium Charge"] = "Сверхмощный сефориевый заряд";
	["Battleground Demolisher"] = "Разрушитель";
	["Resurrection Point"] = "Точки воскрешения";
	["Graveyard Flag"] = "Кладбище";
	["Titan Relic"] = "Реликвия титанов";
	["Gates are marked with their colors."] = "Ворота, отмечены их цветами.";

	--Warsong Gulch
	["Warsong Outriders"] = "Всадники Песни Войны";
	["Silverwing Sentinels"] = "Среброкрылые Часовые";

	-- Hellfire Peninsula PvP 
	["Hellfire Fortifications"] = "Штурмовые укрепления";
	
	-- Zangarmarsh PvP
	["West Beacon"] = "West Beacon"; -- Need translation
	["East Beacon"] = "East Beacon"; -- Need translation
	["Twinspire Graveyard"] = "Twinspire Graveyard"; -- Need translation
	["Alliance Field Scout"] = "Боевой разведчик Альянса";
	["Horde Field Scout"] = "Боевой разведчик Орды";
	
	-- Terokkar Forest PvP
	["Auchindoun Spirit Towers"] = "Auchindoun Spirit Towers"; -- Need translation

	-- Halaa
	["Wyvern Camp"] = "Wyvern Camp"; -- Need translation
	["Quartermaster Jaffrey Noreliqe"] = "Интендант Джеффри Норелик";
	["Quartermaster Davian Vaclav"] = "Интендант Дэвиан Ваклав";
	["Chief Researcher Amereldine"] = "Старший ученый Амерельдина";
	["Chief Researcher Kartos"] = "Старший ученый Картос";
	["Aldraan <Blade Merchant>"] = "Алдраан <Торговец клинками>";
	["Banro <Ammunition>"] = "Банро <Боеприпасы>";
	["Cendrii <Food & Drink>"] = "Сендри <Еда и напитки>";
	["Coreiel <Blade Merchant>"] = "Кориэль <Торговец клинками>";
	["Embelar <Food & Drink>"] = "Янталар <Еда и напитки>";
	["Tasaldan <Ammunition>"] = "Тасалдан <Боеприпасы>";

	-- Wintergrasp
	["Fortress Vihecal Workshop (E)"] = "Fortress Vihecal Workshop (E)"; -- Need translation
	["Fortress Vihecal Workshop (W)"] = "Fortress Vihecal Workshop (W)"; -- Need translation
	["Sunken Ring Vihecal Workshop"] = "Sunken Ring Vihecal Workshop"; -- Need translation
	["Broken Temple Vihecal Workshop"] = "Broken Temple Vihecal Workshop"; -- Need translation
	["Eastspark Vihecale Workshop"] = "Eastspark Vihecale Workshop"; -- Need translation
	["Westspark Vihecale Workshop"] = "Westspark Vihecale Workshop"; -- Need translation
	["Wintergrasp Graveyard"] = "Wintergrasp Graveyard"; -- Need translation
	["Sunken Ring Graveyard"] = "Sunken Ring Graveyard"; -- Need translation
	["Broken Temple Graveyard"] = "Broken Temple Graveyard"; -- Need translation
	["Southeast Graveyard"] = "Southeast Graveyard"; -- Need translation
	["Southwest Graveyard"] = "Southwest Graveyard"; -- Need translation

	-- Eastern Plaguelands - Game of Tower
	["A Game of Towers"] = "Game of Tower"; -- Need translation

	-- Silithus - The Silithyst Must Flow
	["The Silithyst Must Flow"] = "The Silithyst Must Flow"; -- Need translation
	["Alliance's Camp"] = "Alliance's Camp"; -- Need translation
	["Horde's Camp"] = "Horde's Camp"; -- Need translation
};

end