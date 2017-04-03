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

if ( GetLocale() == "deDE" ) then

AtlasBGLocale = {

	--Common
	["Alliance"] = "Allianz";
	["Battleground Maps"] = "Schlachtfeldkarten";
	["Entrance"] = "Eingang";
	["Horde"] = "Horde";
	["Neutral"] = "Neutral";
	["North"] = "Nord";
	["Orange"] = "Orange";
	["Red"] = "Rot";
	["Reputation"] = "Ruf";
	["Rescued"] = "Gerettet";
	["South"] = "Süd";
	["Start"] = "Anfang";
	["Summon"] = "Beschwörbar";
	["White"] = "Weiß";

	--Places
	["AV"] = "AV"; -- Alterac Valley
	["AB"] = "AB"; -- Arathi Basin
	["Eye of the Storm"] = "Auge des Sturms"; ["EotS"] = "Auge";
    	["IoC"] = "Insel";-- Isle of Conquest
	["SotA"] = "SdU"; -- Strand of the Ancients
	["WSG"] = "WS"; -- Warsong Gulch

	--Alterac Valley (North)
	["Stormpike Guard"] = "Sturmlanzengarde";
	["Vanndar Stormpike <Stormpike General>"] = "Vanndar Sturmlanze <General der Sturmlanzen>";
	["Dun Baldar North Marshal"] = "Marschall der Nordtruppen von Dun Baldar";
	["Dun Baldar South Marshal"] = "Marschall der Südtruppen von Dun Baldar";
	["Icewing Marshal"] = "Marschall der Eisschwingentruppen";
	["Stonehearth Marshal"] = "Marschall der Steinbruchtruppen";
	["Prospector Stonehewer"] = "Ausgrabungsleiter Steinhauer";
	["Morloch"] = "Morloch";
	["Umi Thorson"] = "Umi Thorson";
	["Keetar"] = "Keetar";
	["Arch Druid Renferal"] = "Erzdruide Renferal";
	["Dun Baldar North Bunker"] = "Nordbunker von Dun Baldar";
	["Wing Commander Mulverick"] = "Schwadronskommandant Mulverick";--omitted from AVS
	["Murgot Deepforge"] = "Murgot Tiefenschmied";
	["Dirk Swindle <Bounty Hunter>"] = "Dirk Schwindel <Kopfgeldjäger>";
	["Athramanis <Bounty Hunter>"] = "Athramanis <Kopfgeldjäger>";
	["Lana Thunderbrew <Blacksmithing Supplies>"] = "Lana Donnerbräu <Schmiedekunstbedarf>";
	["Stormpike Aid Station"] = "Lazarett der Sturmlanzen";
	["Stormpike Stable Master <Stable Master>"] = "Stallmeister der Sturmlanzen <Stallmeister>";
	["Stormpike Ram Rider Commander"] = "Kommandant der Sturmlanzenwidderreiter";
	["Svalbrad Farmountain <Trade Goods>"] = "Svalbrad Bergweh <Handwerkswaren>";
	["Kurdrum Barleybeard <Reagents & Poison Supplies>"] = "Kurdrum Gerstenbart <Reagenzien & Giftreagenzien>";
	["Stormpike Quartermaster"] = "Rüstmeister der Sturmlanzen";
	["Jonivera Farmountain <General Goods>"] = "Jonivera Bergweh <Gemischtwaren>";
	["Brogus Thunderbrew <Food & Drink>"] = "Brogus Donnerbräu <Essen & Getränke>";
	["Wing Commander Ichman"] = "Schwadronskommandant Ichman";--omitted from AVS
	["Wing Commander Slidore"] = "Schwadronskommandant Erzrutsch";--omitted from AVS
	["Wing Commander Vipore"] = "Schwadronskommandant Vipore";--omitted from AVS
	["Dun Baldar South Bunker"] = "Südbunker von Dun Baldar";
	["Corporal Noreg Stormpike"] = "Korporal Noreg Sturmlanze";
	["Gaelden Hammersmith <Stormpike Supply Officer>"] = "Gaelden Hammerschmied <Versorgungsoffizier der Sturmlanzen>";
	["Stormpike Banner"] = "Banner der Sturmlanzen";
	["Stormpike Lumber Yard"] = "Sägewerk der Sturmlanzen";
	["Wing Commander Jeztor"] = "Schwadronskommandant Jeztor";--omitted from AVS
	["Wing Commander Guse"] = "Schwadronskommandant Guse";--omitted from AVS
	["Stormpike Ram Rider Commander"] = "Kommandant der Sturmlanzenwidderreiter";
	["Captain Balinda Stonehearth <Stormpike Captain>"] = "Hauptmann Balinda Steinbruch <Hauptmann der Sturmlanzen>";
	["Ichman's Beacon"] = "Ichmans Signal";
	["Mulverick's Beacon"] = "Mulvericks Signal";
	["Ivus the Forest Lord"] = "Ivus der Waldfürst";
	["Western Crater"] = "Westlicher Krater";
	["Vipore's Beacon"] = "Vipores Signal";
	["Jeztor's Beacon"] = "Jeztors Signal";
	["Eastern Crater"] = "Östlicher Krater";
	["Slidore's Beacon"] = "Erzrutschs Signal";
	["Guse's Beacon"] = "Guses Signal";
	["Graveyards, Capturable Areas"] = "Friedhöfe, Einnehmbare Gebiete";--omitted from AVS
	["Bunkers, Towers, Destroyable Areas"] = "Bunker, Türme, Zerstörbare Gebiete";--omitted from AVS
	["Assault NPCs, Quest Areas"] = "Angreifbare NPCs, Questgebiete";--omitted from AVS

	--Alterac Valley (South)
	["Frostwolf Clan"] = "Frostwolfklan";
	["Drek'Thar <Frostwolf General>"] = "Drek'Thar <General der Frostwölfe>";
	["Duros"] = "Duros";
	["Drakan"] = "Drakan";
	["West Frostwolf Warmaster"] = "Westkriegsmeister der Frostwölfe";
	["East Frostwolf Warmaster"] = "Ostkriegsmeister der Frostwölfe";
	["Tower Point Warmaster"] = "Kriegsmeister der Turmstellung";
	["Iceblood Warmaster"] = "Kriegsmeister der Eisbluttruppen";
	["Lokholar the Ice Lord"] = "Lokholar der Eislord";
	["Captain Galvangar <Frostwolf Captain>"] = "Hauptmann Galvangar <Hauptmann der Frostwölfe>";
	["Iceblood Tower"] = "Eisblutturm";
	["Tower Point"] = "Turmstellung";
	["Taskmaster Snivvle"] = "Zuchtmeister Schnuffel";
	["Masha Swiftcut"] = "Masha Schnellstreich";
	["Aggi Rumblestomp"] = "Aggi Polterbein";
	["Jotek"] = "Jotek";
	["Smith Regzar"] = "Schmied Regzar";
	["Primalist Thurloga"] = "Primalist Thurloga";
	["Sergeant Yazra Bloodsnarl"] = "Unteroffizier Yazra Murrblut";
	["Frostwolf Stable Master <Stable Master>"] = "Stallmeisterin der Frostwölfe <Stallmeisterin>";
	["Frostwolf Wolf Rider Commander"] = "Wolfsreiterkommandant der Frostwölfe";
	["Frostwolf Quartermaster"] = "Rüstmeister der Frostwölfe";
	["West Frostwolf Tower"] = "Westlicher Frostwolfturm";
	["East Frostwolf Tower"] = "Östlicher Frostwolfturm";
	["Frostwolf Relief Hut"] = "Heilerhütte der Frostwölfe";
	["Frostwolf Banner"] = "Banner der Frostwölfe";

	--Arathi Basin
	["The Defilers"] = "Die Entweihten";
	["The League of Arathor"] = "Der Bund von Arathor";

	--Eye of the Storm
	["Flag"] = "Flagge";

	--Isle of Conquest
    	["The Refinery"] = "Die Raffinerie";
    	["The Docks"] = "Die Docks";
    	["The Workshop"] = "Die Belagerungswerkstatt";
    	["The Hangar"] = "Der Hangar";
    	["The Quarry"] = "Der Steinbruch";
    	["Contested Graveyards"] = "Umkämpfte Friedhöfe";
    	["Horde Graveyard"] = "Horde Friedhof";
    	["Alliance Graveyard"] = "Allianz Friedhof";
    	["Gates are marked with red bars."] = "Tore sind mit roten Balken makiert.";
    	["Overlord Agmar"] = "Oberanführer Agmar";
    	["High Commander Halford Wyrmbane <7th Legion>"] = "Hochkommandant Halford Wyrmbann <7. Legion>";

	--Strand of the Ancients
	["Attacking Team"] = "Angreifende Fraktion";
	["Defending Team"] = "Verteidigende Fraktion";
	["Massive Seaforium Charge"] = "Massive Zephyriumladung";
	["Battleground Demolisher"] = "Schlachtfeldverwüster";
	["Resurrection Point"] = "Wiederbelebungspunkt";
	["Graveyard Flag"] = "Friedhofflagge";
	["Titan Relic"] = "Relikt der Titanen";
	["Gates are marked with their colors."] = "Tore sind in ihren Farben eingezeichnet.";

	--Warsong Gulch
	["Warsong Outriders"] = "Kriegshymnenklan";
	["Silverwing Sentinels"] = "Schildwachen der Silberschwingen";

	-- Hellfire Peninsula PvP 
	["Hellfire Fortifications"] = "Befestigung des Höllenfeuers";
	
	-- Zangarmarsh PvP
	["West Beacon"] = "Westliches Leuchtsignal";
	["East Beacon"] = "Östliches Leuchtsignal";
	["Twinspire Graveyard"] = "Friedhof der Zwillingsspitze";
	["Alliance Field Scout"] = "Feldspäher der Allianz";
	["Horde Field Scout"] = "Feldspäher der Horde";
	
	-- Terokkar Forest PvP
	["Auchindoun Spirit Towers"] = "Auchindoun Geistertürme";

	-- Halaa
	["Wyvern Camp"] = "Flügeldrachenlager";
	["Quartermaster Jaffrey Noreliqe"] = "Rüstmeister Jaffrey Keinespuhr";
	["Quartermaster Davian Vaclav"] = "Rüstmeister Davian Watzlav";
	["Chief Researcher Amereldine"] = "Forschungsleiterin Amereldine";
	["Chief Researcher Kartos"] = "Forschungsleiter Kartos";
	["Aldraan <Blade Merchant>"] = "Aldraan <Klingenhändler>";
	["Banro <Ammunition>"] = "Banro <Munition>";
	["Cendrii <Food & Drink>"] = "Cendrii <Speis & Trank>";
	["Coreiel <Blade Merchant>"] = "Coreiel <Klingenhändlerin>";
	["Embelar <Food & Drink>"] = "Embelar <Speis & Trank>";
	["Tasaldan <Ammunition>"] = "Tasaldan <Munition>";

	-- Wintergrasp
	["Fortress Vihecal Workshop (E)"] = "Fahrzeugwerkstatt der Feste (O)";
	["Fortress Vihecal Workshop (W)"] = "Fahrzeugwerkstatt der Feste (W)";
	["Sunken Ring Vihecal Workshop"] = "Fahrzeugwerkstatt des versunkenen Rings";
	["Broken Temple Vihecal Workshop"] = "Fahrzeugwerkstatt des zerbrochenen Tempels";
	["Eastspark Vihecale Workshop"] = "Fahrzeugwerkstatt Ostfunk";
	["Westspark Vihecale Workshop"] = "Fahrzeugwerkstatt Westfunk";
	["Wintergrasp Graveyard"] = "Friedhof der Festung";
	["Sunken Ring Graveyard"] = "Friedhof des versunkenen Rings";
	["Broken Temple Graveyard"] = "Friedhof des zerbrochenen Tempels";
	["Southeast Graveyard"] = "Südöstlicher Friedhof";
	["Southwest Graveyard"] = "Südwestlicher Friedhof";

	-- Eastern Plaguelands - Game of Tower
	["A Game of Towers"] = "Türme einnehmen";

	-- Silithus - The Silithyst Must Flow
	["The Silithyst Must Flow"] = "Silithyst sammeln";
	["Alliance's Camp"] = "Allianzlager";
	["Horde's Camp"] = "Hordelager";
};

end