local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()

if GetLocale() ~= "deDE" then return end

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

-- This table contains a list of suggestions to get to the next level of reputation, craft or skill
addon.Suggestions = {
	[L["Riding"]] = {
		{ 75, "Unerfahrener Reiter (Lv 20): |cFFFFFFFF4g\n|cFFFFD700Standard mount in der Nähe einer Hauptstadt: |cFFFFFFFF1g" },
		{ 150, "Geübter Reiter (Lv 40): |cFFFFFFFF50g\n|cFFFFD700Epic mount in der Nähe einer Hauptstadt: |cFFFFFFFF10g" },
		{ 225, "Erfahrener Reiter (Lv 60): |cFFFFFFFF600g\n|cFFFFD700Flugmount im Schattenmondtal: |cFFFFFFFF50g" },
		{ 300, "Gekonnter Reiter (Lv 70): |cFFFFFFFF5000g\n|cFFFFD700Epic Flugmount im Schattenmondtal: |cFFFFFFFF200g" }
	},
	
	-- source : http://forums.worldofwarcraft.com/thread.html?topicId=102789457&sid=1
	-- ** Primary professions **
	[BI["Tailoring"]] = {
		{ 50, "bis zu 50: Leinenstoffballen" },
		{ 70, "bis zu 70: Leinentasche" },
		{ 75, "bis zu 75: Verstärktes Leinencape" },
		{ 105, "bis zu 105: Wollstoffballen" },
		{ 110, "bis zu 110: Graues Wollhemd"},
		{ 125, "bis zu 125: Doppeltgenähte Wollschultern" },
		{ 145, "bis zu 145: Seidenstoffballen" },
		{ 160, "bis zu 160: Azurblaue Seidenkapuze" },
		{ 170, "bis zu 170: Seidenes Stirnband" },
		{ 175, "bis zu 175: Formelles weißes Hemd" },
		{ 185, "bis zu 185: Magiestoffballen" },
		{ 205, "bis zu 205: Purpurrote Seidenweste" },
		{ 215, "bis zu 215: Purpurrote Seidenpantalons" },
		{ 220, "bis zu 220: Schwarze Magiestoffgamaschen\noder Schwarze Magiestoffweste" },
		{ 230, "bis zu 230: Schwarze Magiestoffhandschuhe" },
		{ 250, "bis zu 250: Schwarzes Magiestoffstirnband\noder Schwarze Magiestoffschultern" },
		{ 260, "bis zu 260: Runenstoffballen" },
		{ 275, "bis zu 275: Runenstoffgürtel" },
		{ 280, "bis zu 280: Runenstofftasche" },
		{ 300, "bis zu 300: Runenstoffhandschuhe" },
		{ 325, "bis zu 325: Netherstoffballen\n|cFFFFD700Nicht verkaufen! Du brauchst sie später noch!" },
		{ 340, "bis zu 340: Magieerfüllter Netherstoffballen\n|cFFFFD700Nicht verkaufen! Du brauchst sie später noch!" },
		{ 350, "bis zu 350: Netherstoffstiefel\n|cFFFFD700Entzaubern um Arkanen Staub zu bekommen" },
		{ 360, "bis zu 360: Netherstofftunika\n|cFFFFD700Entzaubern um Arkanen Staub zu bekommen" },
		{ 375, "bis zu 375: Magieerfüllte Netherstofftunika\nStelle das Set her, auf das du dich spezialisiert hast" }
	},
	[BI["Leatherworking"]] = {
		{ 35, "bis zu 35: Leichtes Rüstungsset" },
		{ 55, "bis zu 55: Geschmeidiger leichter Balg" },
		{ 85, "bis zu 85: Geprägte Lederhandschuhe" },
		{ 100, "bis zu 100: Feiner Ledergürtel" },
		{ 120, "bis zu 120: Geschmeidiger mittlerer Balg" },
		{ 125, "bis zu 125: Feiner Ledergürtel" },
		{ 150, "bis zu 150: Dunkler Ledergürtel" },
		{ 160, "bis zu 160: Geschmeidiger schwerer Balg" },
		{ 170, "bis zu 170: Schweres Rüstungsset" },
		{ 180, "bis zu 180: Schwärzliche Ledergamaschen\noder Wächterhose" },
		{ 195, "bis zu 195: Barbarische Schultern" },
		{ 205, "bis zu 205: Schwärzliche Armschienen" },
		{ 220, "bis zu 220: Dickes Rüstungsset" },
		{ 225, "bis zu 225: Stirnband des Nachtschleichers" },
		{ 250, "bis zu 250: Kommt auf deine Spezialisierung an\nStirnband des Nachtschleichers/Tunika des Nachtschleichers/Hose des Nachtschleichers (Elementar)\nFeste Skorpidbrustplatte/Feste Skorpidhandschuhe (Drachenleder)\nSchildkrötenschuppenset (Stammesleder)" },
		{ 260, "bis zu 260: Stiefel des Nachtschleichers" },
		{ 270, "bis zu 270: Tückische Lederstulpen" },
		{ 285, "bis zu 285: Tückische Lederarmschienen" },
		{ 300, "bis zu 300: Tückisches Lederstirnband" },
		{ 310, "bis zu 310: Knotenhautleder" },
		{ 320, "bis zu 320: Wilde draenische Handschuhe" },
		{ 325, "bis zu 325: Dicke draenische Stiefel" },
		{ 335, "bis zu 335: Schweres Knotenhautleder\n|cFFFFD700Nicht verkaufen! Du brauchst es später noch!" },
		{ 340, "bis zu 340: Dicke draenische Weste" },
		{ 355, "bis zu 355: Teufelsschuppenbrustplatte" },
		{ 365, "bis zu 365: Schwere Grollhufstiefel\n|cFFFFD700Farme Grollhufleder in Nagrand" },
		{ 375, "bis zu 375: Trommeln der Schlacht\n|cFFFFD700Benötigt Die Sha'tar - Wohlwollend" }
	},
	[BI["Engineering"]] = {
		{ 40, "bis zu 40: Raues Sprengpulver" },
		{ 50, "bis zu 50: Eine Hand voll Kupferbolzen" },
		{ 51, "Stelle einen Bogenlichtschraubenschlüssel her" },
		{ 65, "bis zu 65: Kupferrohr" },
		{ 75, "bis zu 75: Raues Schießeisen" },
		{ 95, "bis zu 95: Grobes Sprengpulver" },
		{ 105, "bis zu 105: Silberkontakt" },
		{ 120, "bis zu 120: Bronzeröhre" },
		{ 125, "bis zu 125: Kleine Bronzebombe" },
		{ 145, "bis zu 145: Schweres Sprengpulver" },
		{ 150, "bis zu 150: Große Bronzebombe" },
		{ 175, "bis zu 175: Blaue, grüne oder rote Feuerwerksrakete" },
		{ 176, "Stelle einen Gyromatischer Mikroregler her" },
		{ 190, "bis zu 190: Robustes Sprengpulver" },
		{ 195, "bis zu 195: Große Eisenbombe" },
		{ 205, "bis zu 205: Mithrilrohr" },
		{ 210, "bis zu 210: Instabiler Auslöser" },
		{ 225, "bis zu 225: Stark einschlagende Mithrilpatronen" },
		{ 235, "bis zu 235: Mithrilgehäuse" },
		{ 245, "bis zu 245: Hochexplosive Bombe" },
		{ 250, "bis zu 250: Gyromithrilgeschoss" },
		{ 260, "bis zu 260: Dichtes Sprengpulver" },
		{ 290, "bis zu 290: Thoriumapparat" },
		{ 300, "bis zu 300: Thoriumröhre\noder Thoriumpatronen (günstiger)" },
		{ 310, "bis zu 310: Teufelseisengehäuse,\nEine Hand voll Teufelseisenbolzen,\n und Elementarsprengpulver\nWird später noch benötigt" },
		{ 320, "bis zu 320: Teufelseisenbombe" },
		{ 335, "bis zu 335: Teufelseisenmuskete" },
		{ 350, "bis zu 350: Weißes Rauchsignal" },
		{ 360, "bis zu 360: Khoriumkraftkern\nUm 375 zu erreichen brauchst du 20 Stück davon" },
		{ 375, "bis zu 375: Feldreparaturbot 110G" }
	},
	[BI["Jewelcrafting"]] = {
		{ 20, "bis zu 20: Feiner Kupferdraht" },
		{ 30, "bis zu 30: Raue Steinstatue" },
		{ 50, "bis zu 50: Tigeraugenband" },
		{ 75, "bis zu 75: Bronzefassung" },
		{ 80, "bis zu 80: Robuster Bronzering" },
		{ 90, "bis zu 90: Eleganter Silberring" },
		{ 110, "bis zu 110: Ring der Silbermacht" },
		{ 120, "bis zu 120: Schwere Steinstatue" },
		{ 150, "bis zu 150: Anhänger des Achatschilds\noder Goldener Drachenring" },
		{ 180, "bis zu 180: Filigranarbeit aus Mithril" },
		{ 200, "bis zu 200: Gravierter Echtsilberring" },
		{ 210, "bis zu 210: Citrinring der rapiden Heilung" },
		{ 225, "bis zu 225: Aquamarinsiegel" },
		{ 250, "bis zu 250: Thoriumfassung" },
		{ 255, "bis zu 255: Roter Ring der Zerstörung" },
		{ 265, "bis zu 265: Echtsilberring der Heilung" },
		{ 275, "bis zu 275: Einfacher Opalring" },
		{ 285, "bis zu 285: Saphirsiegel" },
		{ 290, "bis zu 290: Diamantener Fokusring" },
		{ 300, "bis zu 300: Smaragdring des Löwen" },
		{ 310, "bis zu 310: Seltene (grüne) Gems" },
		{ 315, "bis zu 315: Teufelseisenblutring\noder Seltene (grüne) Gems" },
		{ 320, "bis zu 320: Seltene (grüne) Gems" },
		{ 325, "bis zu 325: Azurmondsteinring" },
		{ 335, "bis zu 335: Quecksilberadamantit (später benötigt)\noder Seltene (grüne) Gems" },
		{ 350, "bis zu 350: Schwerer Adamantitring" },
		{ 355, "bis zu 355: Rare (blaue) Gems" },
		{ 360, "bis zu 360: World drop Rezepte wie z.B.:\nLebendiger Rubinanhänger\noder Dicke Teufelsstahlhalskette" },
		{ 365, "bis zu 365: Ring des Arkanschutzes\nBenötigt Die Sha'tar - Wohlwollend" },
		{ 375, "bis zu 375: Wandeln Sie Diamanten um\nWorld drops (blau)\nRespektvoll: Die Sha'tar, Ehrenfeste, Thrallmar" }
	},
	[BI["Enchanting"]] = {
		{ 2, "bis zu 2: Runenverzierte Kupferrute" },
		{ 75, "bis zu 75: Armschiene - Schwache Gesundheit" },
		{ 85, "bis zu 85: Armschiene - Schwache Abwehr" },
		{ 100, "bis zu 100: Armschiene - Schwache Ausdauer" },
		{ 101, "Stelle eine Runenverzierte Silberrute her" },
		{ 105, "bis zu 105: Armschiene - Schwache Ausdauer" },
		{ 120, "bis zu 120: Großer Magiezauberstab" },
		{ 130, "bis zu 130: Schild - Schwache Ausdauer" },
		{ 150, "bis zu 150: Armschiene - Geringe Ausdauer" },
		{ 151, "Stelle eine Runenverzierte Goldrute her" },
		{ 160, "bis zu 160: Armschiene - Geringe Ausdauer" },
		{ 165, "bis zu 165: Schild - Geringe Ausdauer" },
		{ 180, "bis zu 180: Armschiene - Geringe Willenskraft" },
		{ 200, "bis zu 200: Armschiene - Geringe Stärke" },
		{ 201, "Stelle eine Runenverzierte Echtsilberrute her" },
		{ 205, "bis zu 205: Armschiene - Geringe Stärke" },
		{ 225, "bis zu 225: Umhang - Große Verteidigung" },
		{ 235, "bis zu 235: Handschuhe - Beweglichkeit" },
		{ 245, "bis zu 245: Brust - Überragende Gesundheit" },
		{ 250, "bis zu 250: Armschiene - Große Stärke" },
		{ 270, "bis zu 270: Geringes Manaöl\nRezept wird verkauft in Silithus" },
		{ 290, "bis zu 290: Schild - Große Ausdauer\noder Stiefel - Große Ausdauer" },
		{ 291, "Stelle eine Runenverzierte Arkanitrute her" },
		{ 300, "bis zu 300: Umhang - Überragende Verteidigung" },
		{ 301, "Stelle eine Runenverzierte Teufelseisenrute her" },
		{ 305, "bis zu 305: Umhang - Überragende Verteidigung" },
		{ 315, "bis zu 315: Armschiene - Sturmangriff" },
		{ 325, "bis zu 325: Umhang - Erhebliche Rüstung\noder Handschuhe - Sturmangriff" },
		{ 335, "bis zu 335: Brust - Erhebliche Willenskraft" },
		{ 340, "bis zu 340: Schild - Erhebliche Ausdauer" },
		{ 345, "bis zu 345: Überragendes Zauberöl\nBis 350 herstellen wenn die Mats vorhanden sind" },
		{ 350, "bis zu 350: Handschuhe - Erhebliche Stärke" },
		{ 351, "Stelle eine Runenverzierte Adamantitrute her" },
		{ 360, "bis zu 360: Handschuhe - Erhebliche Stärke" },
		{ 370, "bis zu 370: Handschuhe - Zauberschlag\nBenötigt Respektvoll bei Expedition des Cenarius" },
		{ 375, "bis zu 375: Ring - Heilkraft\nBenötigt Respektvoll bei Die Sha'tar" }
	},
	[BI["Blacksmithing"]] = {	
		{ 25, "bis zu 25: Rauer Wetzstein" },
		{ 45, "bis zu 45: Rauer Schleifstein" },
		{ 75, "bis zu 75: Kupferner Kettengürtel" },
		{ 80, "bis zu 80: Grober Schleifstein" },
		{ 100, "bis zu 100: Runenverzierter Kupfergürtel" },
		{ 105, "bis zu 105: Silberrute" },
		{ 125, "bis zu 125: Raue bronzene Gamaschen" },
		{ 150, "bis zu 150: Schwerer Schleifstein" },
		{ 155, "bis zu 155: Goldrute" },
		{ 165, "bis zu 165: Grüne Eisengamaschen" },
		{ 185, "bis zu 185: Grüne Eisenarmschienen" },
		{ 200, "bis zu 200: Goldene Schuppenarmschienen" },
		{ 210, "bis zu 210: Robuster Schleifstein" },
		{ 215, "bis zu 215: Goldene Schuppenarmschienen" },
		{ 235, "bis zu 235: Stahlplattenhelm\noder Mithrilschuppenarmschienen (günstiger)\nRezept zu kaufen in Der Nistgipfel (A) oder Steinard (H)" },
		{ 250, "bis zu 250: Mithrilhelmkappe\noder Mithrilsporen (günstiger)" },
		{ 260, "bis zu 260: Verdichteter Wetzstein" },
		{ 270, "bis zu 270: Thoriumgürtel oder Thoriumarmschienen (günstiger)\nErdgeschmiedete Gamaschen (Rüstungsschmied)\nLeichte erdgeschmiedete Klinge (Schwertschmiedemeister)\nLeichter glutgeschmiedeter Hammer (Hammerschmiedemeister)\nLeichte himmelsgeschmiedete Axt (Axtschmiedemeister)" },
		{ 295, "bis zu 295: Imperiale Plattenarmschienen" },
		{ 300, "bis zu 300: Imperiale Plattenstiefel" },
		{ 305, "bis zu 305: Teufelsgewichtsstein" },
		{ 320, "bis zu 320: Teufelseisenplattengürtel" },
		{ 325, "bis zu 325: Teufelseisenplattenstiefel" },
		{ 330, "bis zu 330: Geringe Rune des Schutzes" },
		{ 335, "bis zu 335: Teufelseisenbrustplatte" },
		{ 340, "bis zu 340: Adamantitbeil\nZu kaufen in Shattrah, Silbermond, Exodar" },
		{ 345, "bis zu 345: Geringer Zauberschutz der Abschirmung\nZu kaufen im Schattenmondtal und Thrallmar" },
		{ 350, "bis zu 350: Adamantitbeil" },
		{ 360, "bis zu 360: Adamantitgewichtsstein\nBenötigt Expedition des Cenarius - Wohlwollend" },
		{ 370, "bis zu 370: Teufelsstahlhandschuhe (Auchenaikrypta)\nFlammenbannhandschuhe (Aldor - Wohlwollend)\nVerzauberter Adamantitgürtel (Seher - Freundlich)" },
		{ 375, "bis zu 375: Teufelsstahlhandschuhe (Auchenaikrypta)\nFlammenbannbrustplatte (Aldor - Respektvoll)\nVerzauberter Adamantitgürtel (Seher - Freundlich)" }
	},
	[BI["Alchemy"]] = {	
		{ 60, "bis zu 60: Schwacher Heiltrank" },
		{ 110, "bis zu 110: Geringer Heiltrank" },
		{ 140, "bis zu 140: Heiltrank" },
		{ 155, "bis zu 155: Geringer Manatrank" },
		{ 185, "bis zu 185: Großer Heiltrank" },
		{ 210, "bis zu 210: Elixier der Beweglichkeit" },
		{ 215, "bis zu 215: Elixier der großen Verteidigung" },
		{ 230, "bis zu 230: Überragender Heiltrank" },
		{ 250, "bis zu 250: Elixier der Untotenentdeckung" },
		{ 265, "bis zu 265: Elixier der großen Beweglichkeit" },
		{ 285, "bis zu 285: Überragender Manatrank" },
		{ 300, "bis zu 300: Erheblicher Heiltrank" },
		{ 315, "bis zu 315: Flüchtiger Heiltrank\noder Erheblicher Manatrank" },
		{ 350, "bis zu 350: Trank des verrückten Alchimisten\nWird ab 335 gelb, ist aber günstig herzustellen" },
		{ 375, "bis zu 375: Erheblicher Trank des traumlosen Schlafs\nZu kaufen in Allerias Feste (A)\noder Donnerfeste (H)" }
	},
	[L["Mining"]] = {
		{ 65, "bis zu 65: Baue Kupfer ab\nVerfügbar in allen Startgebieten" },
		{ 125, "bis zu 125: Baue Zinn, Silber, Pyrophor and geringes Blutsteinerz ab\n\nBaue Phyrophorerz in Thelgen Rock (Sumpfland)\nEinfach zu skillen bis 125" },
		{ 175, "bis zu 175: \nDesolace,Eschental, Ödland, Arathihochland,\nAlteracgebirge, Schlingendorntal, Sümpfe des Elends" },
		{ 250, "bis zu 250: Baue Mithril und Echtsilber ab\nVerwüstete Lande, Sengende Schlucht, Ödland, Hinterland,\nWestliche Pestländer, Azshara, Winterquell, Teufelswald, Steinkrallengebirge, Tanaris" },
		{ 300, "bis zu 300: Baue Thorium ab \nKrater von Un'goro, Azshara, Winterquell, Verwüstete Lande\nSengende Schlucht, Brennende Steppe, Östliche Pestländer, Westliche Pestländer" },
		{ 330, "bis zu 330: Baue Teufelseisen ab\nHöllenfeuerhalbinsel, Zangarmarschen" },
		{ 375, "bis zu 375: Baue Teufelseisen und Adamantit ab\nWälder von Terokkar, Nagrand\nEigentlich überall in der Scherbenwelt" }
	},
	[L["Herbalism"]] = {
		{ 50, "bis zu 50: Sammel Silberblatt und Friedensblume\nVerfügbar in allen Startgebieten" },
		{ 70, "bis zu 70: Sammel Maguskönigskraut and Erdwurzel\nBrachland, Westfall, Silberwald, Loch Modan" },
		{ 100, "bis zu 100: Sammel Wilddornrose\nSilberwald, Dämmerwald, Dunkelküste,\nLoch Modan, Rotkammgebirge" },
		{ 115, "bis zu 115: Sammel Beulengras\nEschental, Steinkrallengebirge, Südliches Brachland\nLoch Modan, Rotkammgebirge" },
		{ 125, "bis zu 125: Sammel Wildstahlblume\nSteinkrallengebirge, Arathihochland, Schlingendorntal\nSüdliches Brachland, Tausend Nadeln" },
		{ 160, "bis zu 160: Sammel Königsblut\nEschental, Steinkrallengebirge, Sumpfland,\nVorgebirge des Hügellands, Sümpfe des Elends" },
		{ 185, "bis zu 185: Sammel Blassblatt\nSümpfe des Elends" },
		{ 205, "bis zu 205: Sammel Khadgars Schnurrbart\nHinterland, Arathihochland, Sümpfe des Elends" },
		{ 230, "bis zu 230: Sammel Feuerblüte\nSengende Schlucht, Verwüstete Lande, Tanaris" },
		{ 250, "bis zu 250: Sammel Sonnengras\nTeufelswald, Feralas, Azshara\nHinterland" },
		{ 270, "bis zu 270: Sammel Gromsblut\nTeufelswald, Verwüstete Lande,\nMannoroc Coven in Desolace" },
		{ 285, "bis zu 285: Sammel Traumblatt\nKrater von Un'Goro, Azshara" },
		{ 300, "bis zu 300: Sammel Pestblüte\nÖstliche & Westliche Pestländer, Teufelswald\noder Eiskappen in Winterquell" },
		{ 330, "bis zu 330: Sammel Teufelsgras\nHöllenfeuerhalbinsel, Zangarmarschen" },
		{ 375, "bis zu 375: Alles was in der Scherenwelt verfügbar ist aufsammeln\nBesonders in Zangarmarschen & Wälder von Terokkar" }
	},
	[L["Skinning"]] = {
		{ 375, "bis zu 375: Teilen Sie Ihr gegenwärtiges Fähigkeitsniveau durch 5\nund kürschnern sie Mobs mit diesem Level" }
	},
	-- source: http://www.almostgaming.com/wowguides/world-of-warcraft-lockpicking-guide
	[L["Lockpicking"]] = {
		{ 85, "bis zu 85: Thieves Training\nAtler Mill, Rotkammgebirge (A)\nSchiff in der Nähe von Ratchet (H)" },
		{ 150, "bis zu 150: Kasten in der Nähe vom Boss der Gift Quest\nWestfall (A) or Brachland (H)" },
		{ 185, "bis zu 185: Murloc Camps (Sumpfland)" },
		{ 225, "bis zu 225: Sar'Theris Strand (Desolace)\n" },
		{ 250, "bis zu 250: Angor Fortress (Ödland)" },
		{ 275, "bis zu 275: Slag Pit (Sengende Schlucht)" },
		{ 300, "bis zu 300: Lost Rigger Cove (Tanaris)\nBay of Storms (Azshara)" },
		{ 325, "bis zu 325: Feralfen Village (Zangarmarschen)" },
		{ 350, "bis zu 350: Kil'sorrow Fortress (Nagrand)\nWende Taschendiebstahl an den Felsfäuste in Nagrand an" }
	},
	
	-- ** Secondary professions **
	[BI["First Aid"]] = {
		{ 40, "bis zu 40: Leinenverbände" },
		{ 80, "bis zu 80: Schwerer Leinenverband\nWerde Geselle mit 50" },
		{ 115, "bis zu 115: Wollverband" },
		{ 150, "bis zu 150: Schwerer Wollverband\nHol dir das Erste Hilfe Buch mit 125\nKaufe die 2 Rezepte in Stromgarde (A) or Brackenwall (H)" },
		{ 180, "bis zu 180: Seidenverband" },
		{ 210, "bis zu 210: Schwerer Seidenverband" },
		{ 240, "bis zu 240: Magiestoffverband\nErste Hilfe Quest mit level 35 in\nTheramore (A) oder Hammerfall (H)" },
		{ 260, "bis zu 260: Schwerer Magiestoffverband" },
		{ 290, "bis zu 290: Runenstoffverband" },
		{ 330, "bis zu 330: Schwerer Runenstoffverband\nKaufe das Erste Hilfe Buch für Meister\nTempel von Telhamat (A) oder Falkenwacht (H)" },
		{ 360, "bis zu 360: Netherstoffverband\nKaufe das Buch im Tempel von Telhamat (A) oder in der Falkenwacht (H)" },
		{ 375, "bis zu 375: Schwerer Netherstoffverband\nKaufe das Buch im Tempel von Telhamat (A) oder in der Falkenwacht (H)" }
	},
	[BI["Cooking"]] = {
		{ 40, "bis zu 40: Gewürzbrot"	},
		{ 85, "bis zu 85: Geräuchertes Bärenfleisch, Krebsküchlein" },
		{ 100, "bis zu 100: Gekochte Krebsschere (A)\nGrubenratteneintopf (H)" },
		{ 125, "bis zu 125: Grubenratteneintopf (H)\nGewürzter Wolfskebab (A)" },
		{ 175, "bis zu 175: Seltsam schmeckendes Omelett (A)\nScharfe Löwenkoteletts (H)" },
		{ 200, "bis zu 200: Gerösteter Raptor" },
		{ 225, "bis zu 225: Spinnenwurst\n\n|cFFFFFFFFKoch Quest:\n|cFFFFD70012 Rieseneier,\n10 Scharfes Muschelfleisch,\n20 Alteraclochkäse " },
		{ 275, "bis zu 275: Monsteromelett\noder Zartes Wolfsteak" },
		{ 285, "bis zu 285: Runn Tum Knolle Surprise\nDüsterbruch (Pusillin)" },
		{ 300, "bis zu 300: Geräucherte Wüstenknödel\nQuest in Silithus" },
		{ 325, "bis zu 325: Heißer Hetzer, Bussardbissen" },
		{ 350, "bis zu 350: Gerösteter Grollhuf\nDoppelwarper, Talbuksteak" },
		{ 375, "bis zu 375: Knusperschlange\nLeckerbissen der Mok'Nathal" }
	},	
	-- source: http://www.wowguideonline.com/fishing.html
	[BI["Fishing"]] = {
		{ 50, "bis zu 50: Jedes Startgebiet" },
		{ 75, "bis zu 75:\nDie Kanäle in Sturmwind\nDer Teich in Orgrimmar" },
		{ 150, "bis zu 150: Vorgebirge des Hügellands' Fluss" },
		{ 225, "bis zu 225: Expertenangelbuch wird in Beutebuch verkauft\nAngel in Desolace oder Arathihochland" },
		{ 250, "bis zu 250: Hinterland, Tanaris\n\n|cFFFFFFFFAngelquest in Düstermarschen\n|cFFFFD700Blauwimpel von der ungezähmten Küste (Schlingendorntal)\nFeralas Ahi (Verdantis Fluss, Feralas)\nSar'therisbarsch (Nördlicher Sartheris Strand, Desolace)\nNebelschilf-Mahi-Mahi (Sümpfe des Elends Küste)" },
		{ 260, "bis zu 260: Teufelswald" },
		{ 300, "bis zu 300: Azshara" },
		{ 330, "bis zu 330: Angel in den östlichen Zangarmarschen\nDas Fachmann Anglerbuch gibt es in der Expedition des Cenarius " },
		{ 345, "bis zu 345: Westliche Zangarmarschen" },
		{ 360, "bis zu 360: Wälder von Terokkar" },
		{ 375, "bis zu 375: Wälder von Terokkar, in der Hochebene\nFlugmount benötigt" }
	},
	
	-- suggested leveling zones, compiled by Thaoky, based on too many sources to list + my own leveling experience on Alliance side
	["Leveling"] = {
		{ 10, "bis Level 10: Jedes Startgebiet" },
		{ 20, "bis Level 20: "  .. BZ["Loch Modan"] .. "\n" .. BZ["Westfall"] .. "\n" .. BZ["Darkshore"] .. "\n" .. BZ["Bloodmyst Isle"] 
						.. "\n" .. BZ["Silverpine Forest"] .. "\n" .. BZ["The Barrens"] .. "\n" .. BZ["Ghostlands"]},
		{ 25, "bis Level 25: " .. BZ["Wetlands"] .. "\n" .. BZ["Redridge Mountains"] .. "\n" .. BZ["Ashenvale"] 
						.. "\n" .. BZ["The Barrens"] .. "\n" .. BZ["Stonetalon Mountains"] .. "\n" .. BZ["Hillsbrad Foothills"] },
		{ 28, "bis Level 28: " .. BZ["Duskwood"] .. "\n" .. BZ["Wetlands"] .. "\n" .. BZ["Ashenvale"] 
						.. "\n" .. BZ["Stonetalon Mountains"] .. "\n" .. BZ["Thousand Needles"] },
		{ 31, "bis Level 31: " .. BZ["Duskwood"] .. "\n" .. BZ["Thousand Needles"] .. "\n" .. BZ["Ashenvale"] },
		{ 35, "bis Level 35: " .. BZ["Thousand Needles"] .. "\n" .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Alterac Mountains"] 
						.. "\n" .. BZ["Arathi Highlands"] .. "\n" .. BZ["Desolace"] },
		{ 40, "bis Level 40: " .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Desolace"] .. "\n" .. BZ["Badlands"]
						.. "\n" .. BZ["Dustwallow Marsh"] .. "\n" .. BZ["Swamp of Sorrows"] },
		{ 43, "bis Level 43: " .. BZ["Tanaris"] .. "\n" .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Badlands"] 
						.. "\n" .. BZ["Dustwallow Marsh"] .. "\n" .. BZ["Swamp of Sorrows"] },
		{ 45, "bis Level 45: " .. BZ["Tanaris"] .. "\n" .. BZ["Feralas"] .. "\n" .. BZ["The Hinterlands"] },
		{ 48, "bis Level 48: " .. BZ["Tanaris"] .. "\n" .. BZ["Feralas"] .. "\n" .. BZ["The Hinterlands"] .. "\n" .. BZ["Searing Gorge"] },
		{ 51, "bis Level 51: " .. BZ["Tanaris"] .. "\n" .. BZ["Azshara"] .. "\n" .. BZ["Blasted Lands"] 
						.. "\n" .. BZ["Searing Gorge"] .. "\n" .. BZ["Un'Goro Crater"] .. "\n" .. BZ["Felwood"] },
		{ 55, "bis Level 55: " .. BZ["Un'Goro Crater"] .. "\n" .. BZ["Felwood"] .. "\n" .. BZ["Burning Steppes"]
						.. "\n" .. BZ["Blasted Lands"] .. "\n" .. BZ["Western Plaguelands"] },
		{ 58, "bis Level 58: " .. BZ["Winterspring"] .. "\n" .. BZ["Burning Steppes"] .. "\n" .. BZ["Western Plaguelands"] 
						.. "\n" .. BZ["Eastern Plaguelands"] .. "\n" .. BZ["Silithus"] },
		{ 60, "bis Level 60: " .. BZ["Winterspring"] .. "\n" .. BZ["Eastern Plaguelands"] .. "\n" .. BZ["Silithus"] },
		{ 62, "bis Level 62: " .. BZ["Hellfire Peninsula"] },
		{ 64, "bis Level 64: " .. BZ["Zangarmarsh"] .. "\n" .. BZ["Terokkar Forest"]},
		{ 65, "bis Level 65: " .. BZ["Terokkar Forest"] },
		{ 66, "bis Level 66: " .. BZ["Terokkar Forest"] .. "\n" .. BZ["Nagrand"]},
		{ 67, "bis Level 67: " .. BZ["Nagrand"]},
		{ 68, "bis Level 68: " .. BZ["Blade's Edge Mountains"]},
		{ 70, "bis Level 70: " .. BZ["Blade's Edge Mountains"] .. "\n" .. BZ["Netherstorm"] .. "\n" .. BZ["Shadowmoon Valley"]},
		{ 72, "bis Level 72: " .. BZ["Howling Fjord"] .. "\n" .. BZ["Borean Tundra"]},
		{ 74, "bis Level 74: " .. BZ["Grizzly Hills"] .. "\n" .. BZ["Dragonblight"]},
		{ 76, "bis Level 76: " .. BZ["Dragonblight"] .. "\n" .. BZ["Zul'Drak"]},
		{ 78, "bis Level 78: " .. BZ["Zul'Drak"] .. "\n" .. BZ["Sholazar Basin"]},
		{ 80, "bis Level 80: " .. BZ["The Storm Peaks"] .. "\n" .. BZ["Icecrown"]},
	},

	-- Reputation levels
	-- -42000 = "Hasserfüllt"
	-- -6000 = "Feindselig"
	-- -3000 = "Unfreundlich"
	-- 0 = "Neutral"
	-- 3000 = "Freundlich"
	-- 9000 = "Wohlwollend"
	-- 21000 = "Respektvoll"
	-- 42000 = "Ehrfürchtig"
	
	-- Outland factions: source: http://www.mmo-champion.com/
	[BF["The Aldor"]] = {
		{ 0, "bis zu Neutral:\n" .. WHITE .. "[Schreckensgiftbeutel]|r +250 Ruf\n\n"
				.. YELLOW .. "Schreckenslauerer,\nSchreckenswitwe\n"
				.. WHITE .. "(Wälder von Terokkar)" },
		{ 9000, "bis zu Wohlwollend:\n" .. WHITE .. "[Mal von Kil'jaeden]|r\n+25 Ruf" },
		{ 42000, "bis zu Ehrfürchtig:\n" .. WHITE .. "[Mal des Sargeras]|r +25 Ruf pro Mal\n" 
				.. GREEN .. "[Teuflische Waffen]|r +350 Ruf (+1 Heiliger Staub)"       }
	},
	[BF["The Scryers"]] = {
		{ 0, "bis zu Neutral:\n" .. WHITE .. "[Auge eines Dunstschuppenbasilisken]|r +250 Ruf\n\n"
				.. YELLOW .. "Eisenrückenversteinerer,\nDunstschuppenbeißer,\nDunstschuppenbasilisk\n"
				.. WHITE .. "(Wälder von Terokkar)" },
		{ 9000, "bis zu Wohlwollend:\n" .. WHITE .. "[Siegel der Feuerschwingen]|r\n+25 Ruf" },
		{ 42000, "bis zu Ehrfürchtig:\n" .. WHITE .. "[Siegel des Sonnenzorns]|r +25 Ruf pro Siegel\n" 
				.. GREEN .. "[Arkaner Foliant]|r +350 Ruf (+1 Arkane Rune)"       }
	},
	[BF["Netherwing"]] = {
		{ 3000, "bis zu Freundlich, wiederhole diese Quests:\n\n" 
				.. YELLOW .. "Ein langsamer Tod (Daily)|r 250 Ruf\n"
				.. YELLOW.. "Netherstaubpollen (Daily)|r 250 Ruf\n"
				.. YELLOW.. "Kristalle der Netherschwingen (Daily)|r 250 Ruf\n"
				.. YELLOW.. "Ein Schatten am Horizont (Daily)\n"
				.. YELLOW.. "Die große Eierjagd (Wiederholbar)|r 250 Ruf" },
		{ 9000, "bis zu Wohlwollend, wiederhole diese Quests:\n\n" 
				.. YELLOW .. "Aufsehen und Ihr: Die richtige Wahl treffen|r 350 Ruf\n"
				.. YELLOW .. "Der Schuhmerang: Das Mittel gegen den wertlosen Peon (Daily)|r 350 Ruf\n"
				.. YELLOW .. "Die Dinge in den Griff bekommen... (Daily)|r 350 Ruf\n"
				.. YELLOW .. "Drachen sind unsere geringste Sorge (Daily)|r 350 Ruf\n"
				.. YELLOW .. "Verrückt und verwirrt|r 350 Ruf\n" },
		{ 21000, "bis zu Respektvoll, wiederhole diese Quests:\n\n" 
				.. YELLOW .. "Unterdrückt den Unterdrücker|r 500 Ruf\n" 
				.. YELLOW .. "Schwächt das Portal des Zwielichts (Daily)|r 500 Ruf\n"
				.. YELLOW .. "Rennen Quests: 500 für die ersten 5, 1000 für das 6.\n" },
		{ 42000, "bis zu Ehrfürchtig, wiederhole diese Quest:\n\n" 
				.. YELLOW .. "Die tödlichste Falle aller Zeiten (Daily) (3er Gruppenquest)|r 500 Ruf" }
	},
	[BF["Honor Hold"]] = {
		{ 9000, "bis zu Wohlwollend:\n\n" 
				.. YELLOW .. "Quest in Höllenfeuerhalbinsel\n"
				.. GREEN .. "Höllenfeuerbollwerk |r(Normal)\n"
				.. GREEN .. "Der Blutkessel |r(Normal)" },		
		{ 42000, "bis zu Ehrfürchtig:\n\n" 
				.. GREEN .. "Die zerschmetterten Hallen |r(Normal & Heroisch)\n"
				.. GREEN .. "Höllenfeuerbollwerk |r(Heroisch)\n"
				.. GREEN .. "Der Blutkessel |r(Heroisch)" }
	},
	[BF["Thrallmar"]] = {
		{ 9000, "bis zu Wohlwollend:\n\n" 
				.. YELLOW .. "Quest in Höllenfeuerhalbinsel\n"
				.. GREEN .. "Höllenfeuerbollwerk |r(Normal)\n"
				.. GREEN .. "Der Blutkessel |r(Normal)" },		
		{ 42000, "bis zu Ehrfürchtig:\n\n" 
				.. GREEN .. "Die zerschmetterten Hallen |r(Normal & Heroisch)\n"
				.. GREEN .. "Höllenfeuerbollwerk |r(Heroisch)\n"
				.. GREEN .. "Der Blutkessel |r(Heroisch)" }
	},
	[BF["Cenarion Expedition"]] = {
		{ 3000, "bis zu Freundlich:\n\n" 
				.. WHITE .. "Dunkelkämme & Blutschuppen Nagas (+5 Ruf)\n"
				.. YELLOW .. "Quest in Zangarmarschen\n"
				.. "|rGehe in jede " .. GREEN .. "Echsenkessel|r Instanz\n\n"
				.. WHITE .. "Bewahre [Unbekannte Pflanzenteile] auf für später" },	
		{ 9000, "bis zu Wohlwollend:\n\n" 
				.. WHITE .. "Gebe [Unbekannte Pflanzenteile] 240x ab\n"
				.. YELLOW .. "Quest in Zangarmarschen\n"
				.. "|rGehe in jede " .. GREEN .. "Echsenkessel|r Instanz" },
		{ 42000, "bis zu Ehrfürchtig:\n\n" 
				.. WHITE .. "Gebe [Waffen des Echsenkessels] ab (+75 Ruf)\n\n"
				.. GREEN .. "Dampfkammer |r(Normal)\n"
				.. GREEN .. "Jede Echsenkessel Instanz |r(Heroisch)" }
	},
	[BF["Keepers of Time"]] = {
		{ 42000, "bis zu Ehrfürchtig:\n\n" 
				.. "|rGehe in die Instanzen " .. GREEN .. "Durnholde|r & " .. GREEN .. "Der Schwarze Morast\n\n"
				.. YELLOW .. "Behalte die Quests für später:\nDurnholde Questreihe = 5000 Ruf\nSchwarzer Morast Questreihe = 8000 Ruf" }
	},
	[BF["The Sha'tar"]] = {
		{ 42000, "bis zu Ehrfürchtig:\n\n" 
				.. GREEN .. "Die Botanica |r(Normal & Heroisch)\n"
				.. GREEN .. "Die Mechanar |r(Normal & Heroisch)\n"
				.. GREEN .. "Die Arcatraz |r(Normal & Heroisch)\n" }
	},	
	[BF["Lower City"]] = {
		{ 9000, "bis zu Wohlwollend:\n\n" 
				.. WHITE .. "Gebe [Arrakoa Feder] 30x ab (+250 Ruf)\n"
				.. GREEN .. "Schattenlabyrinth |r(Normal)\n"
				.. GREEN .. "Auchenaikrypta |r(Normal)\n"
				.. GREEN .. "Sethekkhallen |r(Normal)" },
		{ 42000, "bis zu Ehrfürchtig:\n\n" 
				.. GREEN .. "Schattenlabyrinth |r(Normal & Heroisch)\n"
				.. GREEN .. "Auchenaikrypta |r(Heroisch)\n"
				.. GREEN .. "Sethekkhallen |r(Heroisch)" }
	},	
	[BF["The Consortium"]] = {
		{ 3000, "bis zu Freundlich:\n\n" 
				.. "|rGebe [Kristallfragment von Oshu'gun] ab (+250 Ruf)\n"
				.. "Gebe [Paar Elfenbeinstoßzähne] ab (+250 Ruf)\n\n"
				.. GREEN .. "Managruft |r(Normal)" },
		{ 9000, "bis zu Wohlwollend:\n\n" 
				.. "|rGebe [Obsidiankriegsperlen] ab (+250 Ruf)\n\n"
				.. GREEN .. "Managruft |r(Normal)" },
		{ 42000, "bis zu Ehrfürchtig:\n\n" 
				.. "|rGebe [Insigne der Zaxxis] ab (+250 Ruf)\n"
				.. "|rGebe [Obsidiankriegsperlen] ab (+250 Ruf)\n\n"
				.. GREEN .. "Managruft |r(Heroisch)" }
	}

}

