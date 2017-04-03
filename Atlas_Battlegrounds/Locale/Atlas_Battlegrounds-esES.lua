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

-- Datos de Atlas (Español)
-- Traducido por --> maqjav|Marosth de Tyrande<--
-- maqjav@hotmail.com
-- Última Actualización (last update): 04/02/2010

--]]

if ( GetLocale() == "esES" ) then

AtlasBGLocale = {

	--Common
	["Alliance"] = "Alianza";
	["Battleground Maps"] = "Mapas de Campos de Batalla";
	["Entrance"] = "Entrada";
	["Horde"] = "Horda";
	["Neutral"] = "Neutral";
	["North"] = "Norte";
	["Orange"] = "Naranja";
	["Red"] = "Rojo";
	["Reputation"] = "Reputación";
	["Rescued"] = "Rescate";
	["South"] = "Sur";
	["Start"] = "Comienzo";
	["Summon"] = "Invocar";
	["White"] = "Blanco";

	--Places
	["AV"] = "VA"; -- Alterac Valley
	["AB"] = "CA"; -- Arathi Basin
	["Eye of the Storm"] = "El Ojo de la Tormenta"; ["EotS"] = "OT";
	["IoC"] = "IcC"; -- Isle of Conquest
	["SotA"] = "PDLA"; -- Strand of the Ancients
	["WSG"] = "GGG"; -- Warsong Gulch

	--Alterac Valley (North)
	["Stormpike Guard"] = "Guardia Pico Tormenta";
	["Vanndar Stormpike <Stormpike General>"] = "Vanndar Pico Tormenta <General Pico Tormenta>";
	["Dun Baldar North Marshal"] = "Alguacil de Dun Baldar Norte";
	["Dun Baldar South Marshal"] = "Alguacil de Dun Baldar Sur";
	["Icewing Marshal"] = "Alguacil Alahielo";
	["Stonehearth Marshal"] = "Alguacil Piedrahogar";
	["Prospector Stonehewer"] = "Prospectora Tallapiedra";
	["Morloch"] = "Morloch";
	["Umi Thorson"] = "Umi Thorson";
	["Keetar"] = "Keetar";
	["Arch Druid Renferal"] = "Archidruida Renferal";
	["Dun Baldar North Bunker"] = "Búnker Norte de Dun Baldar";
	["Wing Commander Mulverick"] = "Comandante del aire Mulverick";--omitted from AVS
	["Murgot Deepforge"] = "Murgot Forjahonda";
	["Dirk Swindle <Bounty Hunter>"] = "Dirk Estafa <Cazador de recompensas>";
	["Athramanis <Bounty Hunter>"] = "Athramanis <Cazadora de recompensas>";
	["Lana Thunderbrew <Blacksmithing Supplies>"] = "Lana Cebatruenos <Suministros de herrería>";
	["Stormpike Aid Station"] = "Puesto de socorro de Pico Tormenta";
	["Stormpike Stable Master <Stable Master>"] = "Maestra de establo de Pico Tormenta <Maestra de establos>";
	["Stormpike Ram Rider Commander"] = "Comandante de jinetes de carneros de Pico Tormenta";
	["Svalbrad Farmountain <Trade Goods>"] = "Svalbrad Montelejano <Objetos comerciables>";
	["Kurdrum Barleybeard <Reagents & Poison Supplies>"] = "Kurdrum Barbacebada <Suministros de venenos y componentes>";
	["Stormpike Quartermaster"] = "Intendente de Pico Tormenta";
	["Jonivera Farmountain <General Goods>"] = "Jonivera Montelejano <Pertrechos>";
	["Brogus Thunderbrew <Food & Drink>"] = "Brogus Cebatruenos <Alimentos y bebidas>";
	["Wing Commander Ichman"] = "Comandante del aire Ichman";--omitted from AVS
	["Wing Commander Slidore"] = "Comandante del aire Slidore";--omitted from AVS
	["Wing Commander Vipore"] = "Comandante del aire Vipore";--omitted from AVS
	["Dun Baldar South Bunker"] = "Búnker Sur de Dun Baldar";
	["Corporal Noreg Stormpike"] = "Cabo Noreg Pico Tormenta";
	["Gaelden Hammersmith <Stormpike Supply Officer>"] = "Gaelden Martillero <Oficial de suministros Pico Tormenta>";
	["Stormpike Banner"] = "Estandarte de Pico Tormenta";
	["Stormpike Lumber Yard"] = "Stormpike Lumber Yard"; --FALTA
	["Wing Commander Jeztor"] = "Comandante del aire Jeztor";--omitted from AVS
	["Wing Commander Guse"] = "Comandante del aire Guse";--omitted from AVS
	["Stormpike Ram Rider Commander"] = "Comandante de jinetes de carneros de Pico Tormenta";
	["Captain Balinda Stonehearth <Stormpike Captain>"] = "Capitana Balinda Piedrahogar <Capitana Pico Tormenta>";
	["Ichman's Beacon"] = "Señal de Inchman";
	["Mulverick's Beacon"] = "Señal de Mulverick";
	["Ivus the Forest Lord"] = "Ivus el Señor del Bosque";
	["Western Crater"] = "Cráter occidental";
	["Vipore's Beacon"] = "Señal de Vipore";
	["Jeztor's Beacon"] = "Señal de Jeztor";
	["Eastern Crater"] = "Cráter del este";
	["Slidore's Beacon"] = "Señal de Slidore";
	["Guse's Beacon"] = "Señal de Guse";
	["Graveyards, Capturable Areas"] = "Cementerios, Areas capturables";--omitted from AVS
	["Bunkers, Towers, Destroyable Areas"] = "Búnkers, Torres, Areas destruibles";--omitted from AVS
	["Assault NPCs, Quest Areas"] = "Personajes de asalto, Areas de Misiones";--omitted from AVS

	--Alterac Valley (South)
	["Frostwolf Clan"] = "Clan Lobo Gélido";
	["Drek'Thar <Frostwolf General>"] = "Drek'Thar <General Lobo Gélido>";
	["Duros"] = "Duros";
	["Drakan"] = "Drakan";
	["West Frostwolf Warmaster"] = "Maestro de guerra del oeste Lobo Gélido";
	["East Frostwolf Warmaster"] = "Maestro de guerra del este Lobo Gélido";
	["Tower Point Warmaster"] = "Maestro de guerra de Punta de la Torre";
	["Iceblood Warmaster"] = "Maestro de guerra Sangrehielo";
	["Lokholar the Ice Lord"] = "Lokholar el Señor de Hielo";
	["Captain Galvangar <Frostwolf Captain>"] = "Capitán Galvangar <Capitán Lobo Gélido>";
	["Iceblood Tower"] = "Torre Sangre Fría";
	["Tower Point"] = "Punto Torre";
	["Taskmaster Snivvle"] = "Capataz Sniwle";
	["Masha Swiftcut"] = "Masha Corteveloz";
	["Aggi Rumblestomp"] = "Aggi Piesdeplomo";
	["Jotek"] = "Jotek";
	["Smith Regzar"] = "Herrero Regzar";
	["Primalist Thurloga"] = "Primalist Thurloga";
	["Sergeant Yazra Bloodsnarl"] = "Sargento Yazra Gruñidosangriento";
	["Frostwolf Stable Master <Stable Master>"] = "Maestra de establo Lobo Gélido <Maestro de establos>";
	["Frostwolf Wolf Rider Commander"] = "Comandate jinete de lobos Lobo Gélido";
	["Frostwolf Quartermaster"] = "Intendente Lobo Gélido";
	["West Frostwolf Tower"] = "Torre Lobo Gélido Oeste";
	["East Frostwolf Tower"] = "Torre Lobo Gélido Este";
	["Frostwolf Relief Hut"] = "Puesto de auxilio de Lobo Gélido";
	["Frostwolf Banner"] = "Estandarte de Lobo Gélido";

	--Arathi Basin
	["The Defilers"] = "Los Rapiñadores";
	["The League of Arathor"] = "La Liga de Arathor";

	--Eye of the Storm
	["Flag"] = "Bandera";

	--Isle of Conquest
	["The Refinery"] = "La Refinería";
	["The Docks"] = "El Astillero";
	["The Workshop"] = "El Taller de Asedio";
	["The Hangar"] = "El Hangar";
	["The Quarry"] = "La Cantera";
	["Contested Graveyards"] = "Cementerios de disputa";
	["Horde Graveyard"] = "Cementerio de la Horda";
	["Alliance Graveyard"] = "Cementerio de la Alianza";
	["Gates are marked with red bars."] = "Las puertas están marcadas con barras rojas.";
	["Overlord Agmar"] = "Señor supremo Agmar";
	["High Commander Halford Wyrmbane <7th Legion>"] = "Alto comandante Halford Aterravermis <La Séptima Legión>";

	--Strand of the Ancients
	["Attacking Team"] = "Equipo atacante";
	["Defending Team"] = "Equipo defendiendo";
	["Massive Seaforium Charge"] = "Carga de seforio enorme";
	["Battleground Demolisher"] = "Demoledor del campo de batalla";
	["Resurrection Point"] = "Punto de Resurrección";
	["Graveyard Flag"] = "Bandera del Cementerio";
	["Titan Relic"] = "Reliquia de titán";
	["Gates are marked with their colors."] = "Las puertas están marcadas con sus colores.";

	--Warsong Gulch
	["Warsong Outriders"] = "Escoltas de Grito de Guerra";
	["Silverwing Sentinels"] = "Centinelas Ala de Plata";

	-- Hellfire Peninsula PvP 
	["Hellfire Fortifications"] = "Fortificaciones de la Península de fuego";
	
	-- Zangarmarsh PvP
	["West Beacon"] = "West Beacon"; -- Need translation
	["East Beacon"] = "East Beacon"; -- Need translation
	["Twinspire Graveyard"] = "Twinspire Graveyard"; -- Need translation
	["Alliance Field Scout"] = "Explorador de campo de la Alianza";
	["Horde Field Scout"] = "Explorador de campo de la Horda";
	
	-- Terokkar Forest PvP
	["Auchindoun Spirit Towers"] = "Auchindoun Spirit Towers"; -- Need translation

	-- Halaa
	["Wyvern Camp"] = "Wyvern Camp"; -- Need translation
	["Quartermaster Jaffrey Noreliqe"] = "Intendente Jaffrey Noreliqe";
	["Quartermaster Davian Vaclav"] = "Intendente Davian Vaclav";
	["Chief Researcher Amereldine"] = "Jefa de investigación Amereldine";
	["Chief Researcher Kartos"] = "Jefe de investigación Kartos";
	["Aldraan <Blade Merchant>"] = "Aldraan <Mercader de armas de filo>";
	["Banro <Ammunition>"] = "Banro <Munición>";
	["Cendrii <Food & Drink>"] = "Cendrii <Alimentos y bebidas>";
	["Coreiel <Blade Merchant>"] = "Coreiel <Mercader de armas de filo>";
	["Embelar <Food & Drink>"] = "Embelar <Alimentos y bebidas>";
	["Tasaldan <Ammunition>"] = "Tasaldan <Munición>";

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
