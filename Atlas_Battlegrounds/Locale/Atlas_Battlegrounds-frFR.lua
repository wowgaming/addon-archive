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

if ( GetLocale() == "frFR" ) then

AtlasBGLocale = {

	--Common
	["Alliance"] = "Alliance";
	["Battleground Maps"] = "Cartes des champs de bataille";
	["Entrance"] = "Entrée";
	["Horde"] = "Horde";
	["Neutral"] = "Neutre";
	["North"] = "Nord";
	["Orange"] = "Orange "; -- Espace pour le blanc avant une double ponctuation française
	["Red"] = "Rouge "; -- Espace pour le blanc avant une double ponctuation française
	["Reputation"] = "Réputation ";
	["Rescued"] = "Sauvé";
	["South"] = "Sud";
	["Start"] = "Départ";
	["Summon"] = "Invoqué";
	["White"] = "Blanc "; -- Espace pour le blanc avant une double ponctuation française

	--Places
	["AV"] = "AV/Alterac"; -- Alterac Valley
	["AB"] = "AB/Arathi"; -- Arathi Basin
	["Eye of the Storm"] = "L'Œil du cyclone"; ["EotS"] = "EotS/L'Œil";
	["IoC"] = "IoC"; -- Isle of Conquest
	["SotA"] = "RdA"; -- Strand of the Ancients
	["WSG"] = "WSG/Goulet"; -- Warsong Gulch

	--Alterac Valley (North)
	["Stormpike Guard"] = "Garde Foudrepique";
	["Vanndar Stormpike <Stormpike General>"] = "Vanndar Foudrepique <Général Foudrepique>";
	["Dun Baldar North Marshal"] = "Maréchal de Dun Baldar nord";
	["Dun Baldar South Marshal"] = "Maréchal de Dun Baldar sud";
	["Icewing Marshal"] = "Maréchal de l'Aile de glace";
	["Stonehearth Marshal"] = "Maréchal de Gîtepierre";
	["Prospector Stonehewer"] = "Prospectrice Taillepierre";
	["Morloch"] = "Morloch";
	["Umi Thorson"] = "Umi Thorson";
	["Keetar"] = "Keetar";
	["Arch Druid Renferal"] = "Archidruide Ranfarouche";
	["Dun Baldar North Bunker"] = "Fortin nord de Dun Baldar";
	["Wing Commander Mulverick"] = "Chef d'escadrille Mulverick";
	["Murgot Deepforge"] = "Murgot Forge-profonde";
	["Dirk Swindle <Bounty Hunter>"] = "Dirk Lembrouille <Chasseur de primes>";
	["Athramanis <Bounty Hunter>"] = "Athramanis <Chasseur de primes>";
	["Lana Thunderbrew <Blacksmithing Supplies>"] = "Lana Tonnebière <Fournitures de forgeron>";
	["Stormpike Aid Station"] = "Poste de Secours Foudrepique";
	["Stormpike Stable Master <Stable Master>"] = "Maître des écuries Foudrepique <Maître des écuries>";
	["Stormpike Ram Rider Commander"] = "Commandant Chevaucheur de bélier Foudrepique";
	["Svalbrad Farmountain <Trade Goods>"] = "Svalbrad Mont-lointain <Fournitures d'artisanat>";
	["Kurdrum Barleybeard <Reagents & Poison Supplies>"] = "Kurdrum Barbe-d'orge <Composants & fournitures pour poisons>";
	["Stormpike Quartermaster"] = "Intendant Foudrepique";
	["Jonivera Farmountain <General Goods>"] = "Jonivera Mont-lointain <Fournitures générales>";
	["Brogus Thunderbrew <Food & Drink>"] = "Brogus Tonnebière <Nourriture & boissons>";
	["Wing Commander Ichman"] = "Chef d'escadrille Ichman";
	["Wing Commander Slidore"] = "Chef d'escadrille Slidore";
	["Wing Commander Vipore"] = "Chef d'escadrille Vipore";
	["Dun Baldar South Bunker"] = "Fortin sud de Dun Baldar";
	["Corporal Noreg Stormpike"] = "Caporal Noreg Foudrepique";
	["Gaelden Hammersmith <Stormpike Supply Officer>"] = "Gaelden Forgemartel <Officier de ravitaillement Foudrepique>";
	["Stormpike Banner"] = "Bannière foudrepique";
	["Stormpike Lumber Yard"] = "Entrepôt de bois Foudrepique";
	["Wing Commander Jeztor"] = "Chef d'escadrille Jeztor";
	["Wing Commander Guse"] = "Chef d'escadrille Guse";
	["Stormpike Ram Rider Commander"] = "Commandant Chevaucheur de bélier Foudrepique";
	["Captain Balinda Stonehearth <Stormpike Captain>"] = "Capitaine Balinda Gîtepierre <Capitaine Foudrepique>";
	["Ichman's Beacon"] = "Balise d'Ichman";
	["Mulverick's Beacon"] = "Balise de Mulverick";
	["Ivus the Forest Lord"] = "Ivus le Seigneur de la forêt";
	["Western Crater"] = "Cratère Ouest";
	["Vipore's Beacon"] = "Balise de Vipore";
	["Jeztor's Beacon"] = "Balise de Jeztor";
	["Eastern Crater"] = "Cratère Est";
	["Slidore's Beacon"] = "Balise de Slidore";
	["Guse's Beacon"] = "Balise de Guse";
	["Graveyards, Capturable Areas"] = "Cimetières, Zones capturable";--omitted from AVS
	["Bunkers, Towers, Destroyable Areas"] = "Fortins, Tours, Zones destructibles";--omitted from AVS
	["Assault NPCs, Quest Areas"] = "PNJs, Zones de quêtes";--omitted from AVS

	--Alterac Valley (South)
	["Frostwolf Clan"] = "Clan Loup-de-givre";
	["Drek'Thar <Frostwolf General>"] = "Drek'Thar <Général Loup-de-givre>";
	["Duros"] = "Duros";
	["Drakan"] = "Drakan";
	["West Frostwolf Warmaster"] = "Maître de guerre Loup-de-givre ouest";
	["East Frostwolf Warmaster"] = "Maître de guerre Loup-de-givre est";
	["Tower Point Warmaster"] = "Maître de guerre de la Tour de la halte";
	["Iceblood Warmaster"] = "Maître de guerre de Glace-sang";
	["Lokholar the Ice Lord"] = "Lokholar le Seigneur de glace";
	["Captain Galvangar <Frostwolf Captain>"] = "Capitaine Galvangar <Capitaine Loup-de-givre>";
	["Iceblood Tower"] = "Tour de Glace-sang";
	["Tower Point"] = "Tour de la Halte";
	["Taskmaster Snivvle"] = "Sous-chef Snivvle";
	["Masha Swiftcut"] = "Masha Vivecoupe";
	["Aggi Rumblestomp"] = "Aggi Grondécrase";
	["Jotek"] = "Jotek";
	["Smith Regzar"] = "Forgeron Regzar";
	["Primalist Thurloga"] = "Primaliste Thurloga";
	["Sergeant Yazra Bloodsnarl"] = "Sergent Yazra Gronde-sang";
	["Frostwolf Stable Master <Stable Master>"] = "Maître des écuries Loup-de-givre <Maître des écuries>";
	["Frostwolf Wolf Rider Commander"] = "Commandant Chevaucheur de loup Loup-de-givre";
	["Frostwolf Quartermaster"] = "Intendant Loup-de-givre";
	["West Frostwolf Tower"] = "Tour Loup-de-givre occidentale";
	["East Frostwolf Tower"] = "Tour Loup-de-givre orientale";
	["Frostwolf Relief Hut"] = "Hutte de guérison Loup-de-givre";
	["Frostwolf Banner"] = "Bannière Loup-de-givre";

	--Arathi Basin
	["The Defilers"] = "Les Profanateurs";
	["The League of Arathor"] = "La Ligue d'Arathor";

	--Eye of the Storm
	["Flag"] = "Drapeau";

	--Isle of Conquest
	["The Refinery"] = "Raffinerie";
	["The Docks"] = "Docks";
	["The Workshop"] = "Atelier";
	["The Hangar"] = "Hangar";
	["The Quarry"] = " Carrière";
	["Contested Graveyards"] = "Donjons contestés";
	["Horde Graveyard"] = "Donjon de la Horde";
	["Alliance Graveyard"] = "Donjon de l'Alliance";
	["Gates are marked with red bars."] = "Les portes sont marquées par des barres rouges.";
	["Overlord Agmar"] = "Seigneur Agmar";
	["High Commander Halford Wyrmbane <7th Legion>"] = "Haut commandant Halford Verroctone <7e Légion>";

	--Strand of the Ancients
	["Attacking Team"] = "Equipe en attaque";
	["Defending Team"] = "Equipe en défense";
	["Massive Seaforium Charge"] = "Charge d'hydroglycérine massive";
	["Battleground Demolisher"] = "Démolisseur de champ de bataille";
	["Resurrection Point"] = "Point de résurrection";
	["Graveyard Flag"] = "Drapeau de cimetière";
	["Titan Relic"] = "Relique des titans";
	["Gates are marked with their colors."] = "Les portes sont marquées avec leur couleur.";

	--Warsong Gulch
	["Warsong Outriders"] = "Voltigeurs Chanteguerre";
	["Silverwing Sentinels"] = "Sentinelles d'Aile-argent";

	-- Hellfire Peninsula PvP 
	["Hellfire Fortifications"] = "Fortifications des flammes infernales";
	
	-- Zangarmarsh PvP
	["West Beacon"] = "West Beacon"; -- Need translation
	["East Beacon"] = "East Beacon"; -- Need translation
	["Twinspire Graveyard"] = "Twinspire Graveyard"; -- Need translation
	["Alliance Field Scout"] = "Eclaireur de terrain de l'Alliance";
	["Horde Field Scout"] = "Eclaireur de terrain de la Horde";
	
	-- Terokkar Forest PvP
	["Auchindoun Spirit Towers"] = "Auchindoun Spirit Towers"; -- Need translation

	-- Halaa
	["Wyvern Camp"] = "Wyvern Camp"; -- Need translation
	["Quartermaster Jaffrey Noreliqe"] = "Intendant Jaffrey Noreliqe";
	["Quartermaster Davian Vaclav"] = "Intendant Davian Vaclav";
	["Chief Researcher Amereldine"] = "Directrice de recherches Amereldine";
	["Chief Researcher Kartos"] = "Directeur de recherches Kartos";
	["Aldraan <Blade Merchant>"] = "Aldraan <Marchand de lames>";
	["Banro <Ammunition>"] = "Banro <Munitions>";
	["Cendrii <Food & Drink>"] = "Cendrii <Nourriture & boissons>";
	["Coreiel <Blade Merchant>"] = "Coreiel <Marchande de lames>";
	["Embelar <Food & Drink>"] = "Embelar <Nourriture & boissons>";
	["Tasaldan <Ammunition>"] = "Tasaldan <Munitions>";

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