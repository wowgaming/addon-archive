local addonName = ...
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local BI = LibStub("LibBabble-Inventory-3.0"):GetLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BF = LibStub("LibBabble-Faction-3.0"):GetLookupTable()

if GetLocale() ~= "frFR" then return end		-- ** French translation by Laumac **

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"

-- This table contains a list of suggestions to get to the next level of reputation, craft or skill
addon.Suggestions = {
	[L["Riding"]] = {
		{ 75, "Apprenti cavalier (Lv 20): |cFFFFFFFF4g\n|cFFFFD700Monture standard dans/pr\195\168s d'une capitale: |cFFFFFFFF1g" },
		{ 150, "Compagnon cavalier (Lv 40): |cFFFFFFFF50g\n|cFFFFD700Monture \195\169pique dans/pr\195\168s d'une capitale: |cFFFFFFFF10g" },
		{ 225, "Expert cavalier (Lv 60): |cFFFFFFFF600g\n|cFFFFD700Monture volante dans la vall\195\169e d'Ombrelune: |cFFFFFFFF50g" },
		{ 225, "Vol par temps froid (Lv 77): |cFFFFFFFF5000g\n|cFFFFD700Monture volante par temps froid \195\160 Dalaran sur l'aire de Krasus : |cFFFFFFFF1000g" },
		{ 300, "Artisan cavalier (Lv 70): |cFFFFFFFF5000g\n|cFFFFD700Monture volante \195\169pique dans la vall\195\169e d'Ombrelune: |cFFFFFFFF200g" }
	},

	-- source : http://forums.worldofwarcraft.com/th...02789457&sid=1
	-- ** Primary professions **
	[BI["Tailoring"]] = {
		{ 50, "Atteindre 50: Rouleau d'\195\169toffe en lin" },
		{ 70, "Atteindre 70: Sac en lin" },
		{ 75, "Atteindre 75: Cape en lin renforc\195\169" },
		{ 105, "Atteindre 105: Rouleau d'\195\169toffe de laine" },
		{ 110, "Atteindre 110: Chemise grise en laine"},
		{ 125, "Atteindre 125: Epauli\195\168res \195\160 double couture en laine" },
		{ 145, "Atteindre 145: Rouleau d'\195\169toffe de soie" },
		{ 160, "Atteindre 160: Chaperon azur en soie" },
		{ 170, "Atteindre 170: Bandeau en soie" },
		{ 175, "Atteindre 175: Chemise blanche habill\195\169e" },
		{ 185, "Atteindre 185: Rouleau de tisse-mage" },
		{ 205, "Atteindre 205: Gilet cramoisi en soie" },
		{ 215, "Atteindre 215: Culotte cramoisie en soie" },
		{ 220, "Atteindre 220: Jambi\195\168res noires en tisse-mage\nou Robe noire en tisse-mage" },
		{ 230, "Atteindre 230: Gants noirs en tisse-mage" },
		{ 250, "Atteindre 250: Bandeau noir en tisse-mage\nou Epauli\195\168res noires en tisse-mage" },
		{ 260, "Atteindre 260: Rouleau d'\195\169toffe runique" },
		{ 275, "Atteindre 275: Ceinture en \195\169toffe runique" },
		{ 280, "Atteindre 280: Sac en \195\169toffe runique" },
		{ 300, "Atteindre 300: Gants en \195\169toffe runique" },
-----------     OUTRETERRE
		{ 325, "Atteindre 325: Rouleau de tisse-n\195\169ant\n|cFFFFD700Ne pas vendre, sera tr\195\168s utile pour plus tard" },
		{ 340, "Atteindre 340: Rouleau de tisse-n\195\169ant impr\195\169gn\195\169\n|cFFFFD700Ne pas vendre, sera tr\195\168s utile pour plus tard" },
		{ 350, "Atteindre 350: Bottes en tisse-n\195\169ant\n|cFFFFD700A d\195\169senchanter en poussi\195\168re des arcanes" },
-- OBSOLETE	{ 360, "Atteindre 360: Tunique en tisse-n\195\169ant\n|cFFFFD700A d\195\169senchanter en poussi\195\168re des arcanes" },
-- OBSOLETE	{ 375, "Atteindre 375: Tunique en tisse-n\195\169ant impr\195\169gn\195\169\nFabriquer son emsemble de sp\195\169cialisation" },
-----------     NORFENDRE
		{ 375, "Atteindre 375: Rouleau de tisse-givre\n|cFFFFD700En faire un maximum pour la suite (genre 600)" },
		{ 380, "Atteindre 380: Ceinture tiss\195\169e de givre" },
		{ 385, "Atteindre 385: Bottes tiss\195\169es de givre" },
		{ 395, "Atteindre 395: Coiffe tiss\195\169e de givre" },
		{ 400, "Atteindre 400: Ceinture en tisse-brune" },
		{ 405, "Atteindre 405: Rouleau de tisse-givre impr\195\169gn\195\169\n|cFFFFD700En pr\195\169voir environ 120 pour la suite" },
		{ 410, "Atteindre 410: Bandelettes en tisse-brune" },
		{ 415, "Atteindre 415: Gants en tisse-brune" },
		{ 425, "Atteindre 425: Bottes en tisse-brune" },
		{ 440, "Atteindre 440: Sac en tisse-givre\n|cFFFFD700Devient vert au-dessus de 430 mais reste rentable" },
		{ 450, "Atteindre 450: N'importe quel craft \195\169pique de haut niveau\nSinon continuer \195\160 faire des sacs\nvoire le sac glaciaire apr\195\168s 445 (exalt\195\169 Fils de Hodir)" }
	},
	[BI["Leatherworking"]] = {
		{ 35, "Atteindre 35: Renfort d'armure l\195\169ger" },
		{ 55, "Atteindre 55: Peau l\195\169g\195\168re trait\195\169e" },
		{ 85, "Atteindre 85: Gants en cuir estamp\195\169" },
		{ 100, "Atteindre 100: Bottes \195\169l\195\169gantes en cuir" },
		{ 120, "Atteindre 120: Peau moyenne trait\195\169e" },
		{ 125, "Atteindre 125: Bottes \195\169l\195\169gantes en cuir" },
		{ 150, "Atteindre 150: Bottes noires en cuir" },
		{ 160, "Atteindre 160: Peau lourde trait\195\169e" },
		{ 170, "Atteindre 170: Renfort d'armure lourd" },
		{ 180, "Atteindre 180: Jambi\195\168res en cuir mat\nou Pantalon du gardien" },
		{ 195, "Atteindre 195: Epauli\195\168res barbares" },
		{ 205, "Atteindre 205: Brassards mats" },
		{ 220, "Atteindre 220: Renfort d'armure \195\169pais" },
		{ 225, "Atteindre 225: Bandeau de la nuit" },
		{ 250, "Atteindre 250: D\195\169pend de votre sp\195\169cialisation\nBandeau/Tunique/Pantalon de la nuit (El\195\169mentaire)\nCuirasse/Gants arm\195\169s du scorpide (Ecailles de dragon)\nEnsemble en \195\169cailles de tortue (Tribal)" },
		{ 260, "Atteindre 260: Bottes de la nuit" },
		{ 270, "Atteindre 270: Gantelets corrompus en cuir" },
		{ 285, "Atteindre 285: Brassards corrompus en cuir" },
		{ 300, "Atteindre 300: Bandeau corrompu en cuir" },
-----------     OUTRETERRE
		{ 310, "Atteindre 310: Cuir granuleux" },
		{ 320, "Atteindre 320: Gants draeniques sauvages" },
		{ 325, "Atteindre 325: Bottes draeniques \195\169paisses" },
		{ 335, "Atteindre 335: Cuir granuleux lourd\n|cFFFFD700Ne pas vendre, sera tr\195\168s utile pour plus tard" },
		{ 340, "Atteindre 340: Gilet draenique \195\169pais" },
		{ 350, "Atteindre 350: Bottes draeniques en \195\169cailles" },
-- OBSOLETE	{ 365, "Atteindre 365: Bottes du sabot-fourchu \195\169paisses\n|cFFFFD700Farmer le cuir sabot-fourchu \195\160 Nagrand" },
-- OBSOLETE	{ 375, "Atteindre 375: Tambours de bataille\n|cFFFFD700Requiert Les Sha'tar - Honor\195\169" },
-----------     NORFENDRE
		{ 380, "Atteindre 380: Renfort d'armure bor\195\169en" },
		{ 385, "Atteindre 385: Gants arctiques" },
		{ 390, "Atteindre 390: Prot\195\168ge-\195\169paules cryost\195\168nes" },
		{ 405, "Atteindre 405: Cuir bor\195\169en lourd\n|cFFFFD700En pr\195\169voir environ 300 pour la suite" },
		{ 415, "Atteindre 415: Armure de jambe du jormungar" },
		{ 420, "Atteindre 420: Sac des poches infinies" },
		{ 425, "Atteindre 425: Brassards surjet\195\169s ou \195\169quivalent selon la classe" },
		{ 435, "Atteindre 435: Prot\195\168ge-mains surjet\195\169s ou \195\169quivalent selon la classe" },
		{ 440, "Atteindre 440: Renforts de jambe givrepeau ou \nArmure de jambe en \195\169cailles de glace\nSinon continuer sur les Prot\195\168ge-mains surjet\195\169s ou \195\169quivalent" },
		{ 450, "Atteindre 450: N'importe quel craft \195\169pique de haut niveau\nCela reste inutile car aucun craft n\195\169c\195\169ssite d'\195\170tre plus de 440" }
	},
	[BI["Engineering"]] = {
		{ 40, "Atteindre 40: Poudre d'explosion basique" },
		{ 50, "Atteindre 50: Poign\195\169e de boulons en cuivre" },
		{ 51, "Cr\195\169er une Cl\195\169 plate" },
		{ 65, "Atteindre 65: Tube en cuivre" },
		{ 75, "Atteindre 75: Dynamite grossi\195\168re" },
		{ 95, "Atteindre 95: Poudre d'explosion grossi\195\168re" },
		{ 105, "Atteindre 105: Contact en argent" },
		{ 120, "Atteindre 120: Tube en bronze" },
		{ 125, "Atteindre 125: Petite bombe en bronze" },
		{ 145, "Atteindre 145: Poudre d'explosion majeure" },
		{ 150, "Atteindre 150: Grande bombe en bronze" },
		{ 175, "Atteindre 175: Fus\195\169e bleue, rouge ou verte" },
		{ 176, "Cr\195\169er un Micro-ajusteur gyromatique" },
		{ 190, "Atteindre 190: Poudre noire solide" },
		{ 195, "Atteindre 195: Grande bombe en fer" },
		{ 205, "Atteindre 205: Tube en mithril" },
		{ 210, "Atteindre 210: D\195\169clencheur instable" },
		{ 225, "Atteindre 225: Balles per\185\167antes en mithril" },
		{ 235, "Atteindre 235: Armature en mithril" },
		{ 245, "Atteindre 245: Bombe explosive" },
		{ 250, "Atteindre 250: Balle gyroscopique en mithril" },
		{ 260, "Atteindre 260: Poudre d'explosion dense" },
		{ 290, "Atteindre 290: Rouage en thorium" },
		{ 300, "Atteindre 300: Tube en thorium\nou Obus en thorium (plus rentable)" },
-----------     OUTRETERRE
		{ 310, "Atteindre 310: Etui en gangrefer,\nPoign\195\169e de boulons en gangrefer,\n et Poudre d'explosion \195\169l\195\169mentaire\nA garder pour des fabrications futures" },
		{ 320, "Atteindre 320: Obus en gangrefer" },
		{ 335, "Atteindre 335: Mousquet en gangrefer" },
		{ 350, "Atteindre 350: Fumig\195\168ne blanc" },
-- OBSOLETE	{ 360, "Atteindre 360: Batterie en khorium\nEn faire 20, vous les utiliserez pour monter jusqu'\195\160 375" },
-- OBSOLETE	{ 375, "Atteindre 375: Robot r\195\169parateur 110G" },
-----------     NORFENDRE
		{ 370, "Atteindre 370: Poign\195\169e de boulons en cobalt\nEn pr\195\169voir environ 50 pour la suite" },
		{ 377, "Atteindre 377: D\195\169clencheur d'explosion volatile\nEn pr\195\169voir environ 36 pour la suite" },
		{ 385, "Atteindre 385: Condensateur surcharg\195\169\nEn pr\195\169voir 10 pour la suite" },
		{ 380, "Atteindre 380: Leurre explosif" },
		{ 400, "Atteindre 400: Tube en givracier\nEn pr\195\169voir 15 pour la suite" },
		{ 405, "Atteindre 405: Lunette \195\160 r\195\169fracteur en diamant taill\195\169" },
		{ 415, "Atteindre 415: Bo\195\174te de bombes" },
		{ 420, "Atteindre 420: Trousse d'injection de mana\nPeut \195\170tre lucratif et surement utile" },
		{ 430, "Atteindre 430: Lunettes de glacier m\195\169canis\195\169es" },
		{ 435, "Atteindre 435: Machine \195\160 bruit\nUtiliser les composants mis de cot\195\169" },
		{ 450, "Atteindre 450: Couteau de l'arm\195\169e gnome\nPr\195\169voir un point vers la fin pour le craft de t\195\170te" }
	},
	[BI["Jewelcrafting"]] = {
		{ 20, "Atteindre 20: Fil de cuivre d\195\169licat" },
		{ 30, "Atteindre 30: Statue de pierre brute" },
		{ 50, "Atteindre 50: Bague d'oeil de tigre" },
		{ 75, "Atteindre 75: Monture en bronze" },
		{ 80, "Atteindre 80: Anneau solide en bronze" },
		{ 90, "Atteindre 90: Anneau d'argent \195\169l\195\169gant" },
		{ 110, "Atteindre 110: Anneau du pouvoir argent\195\169" },
		{ 120, "Atteindre 120: Statue en pierre lourde" },
		{ 150, "Atteindre 150: Pendentif du bouclier d'agate\nou Anneau dor\195\169 du dragon" },
		{ 180, "Atteindre 180: Filigrane en mithril" },
		{ 200, "Atteindre 200: Anneau cisel\195\169 en vrai-argent" },
		{ 210, "Atteindre 210: Citrine Ring of Rapid Healing" },
		{ 225, "Atteindre 225: Chevali\195\168re d'aigue-marine" },
		{ 250, "Atteindre 250: Monture en thorium" },
		{ 255, "Atteindre 255: Bague de destruction rouge" },
		{ 265, "Atteindre 265: Anneau de soin en vrai-argent" },
		{ 275, "Atteindre 275: Anneau d'opale simple" },
		{ 285, "Atteindre 285: Chevali\195\168re de saphir" },
		{ 290, "Atteindre 290: Bague \195\160 diamant de focalisation" },
		{ 300, "Atteindre 300: Anneau d'\195\169meraude du lion" },
-----------     OUTRETERRE
		{ 310, "Atteindre 310: Toute gemme de qualit\195\169 verte" },
		{ 315, "Atteindre 315: Anneau de sang en gangrefer\nou toute gemme de qualit\195\169 verte" },
		{ 320, "Atteindre 320: Toute gemme de qualit\195\169 verte" },
		{ 325, "Atteindre 325: Anneau de pierre de lune azur" },
		{ 335, "Atteindre 335: Adamantite mercurienne (requis pour plus tard)\nou toute gemme de qualit\195\169 verte" },
		{ 350, "Atteindre 350: Anneau \195\169pais en adamantite" },
-- OBSOLETE	{ 355, "Atteindre 355: Toute gemme de qualit\195\169 bleue" },
-- OBSOLETE	{ 360, "Atteindre 360: Butin mondial comme:\nPendentif de rubis vivant\nou Collier \195\169pais en gangracier" },
-- OBSOLETE	{ 365, "Atteindre 365: Anneau de protection contre les arcanes\nRequiert Les Sha'tar - Honor\195\169" },
-- OBSOLETE	{ 375, "Atteindre 375: Butins mondiaux de qualit\195\169 bleue\nou transmutations de diamants\nRequiert Les Sha'tar,Thrallmar ou Bastion de l'honneur - R\195\169v\195\169r\195\169" },
-----------     NORFENDRE
		{ 395, "Atteindre 395: Toute nouvelle gemme de Norfendre de qualit\195\169 verte" },
		{ 400, "Atteindre 400: Bague de pierre de sang, Amulette en calc\195\169doine cristalline (la plus lucrative)\nCollier en citrine cristalline ou Anneau roche-soleil" },
		{ 420, "Atteindre 420: Bague du garde de pierre" },
		{ 425, "Atteindre 425: Toute nouvelle gemme de Norfendre de qualit\195\169 bleue\nLes plus interessantes sont Saphir c\195\169leste solide, Rubis \195\169carlate \195\169clatant..." },
		{ 450, "Atteindre 450: Faire des m\195\169ta-gemmes\nPenser \195\160 faire les qu\195\170tes journali\195\168res de Dalaran" }
	},
	[BI["Enchanting"]] = {
		{ 2, "Atteindre 2: B\195\162tonnet runique en cuivre" },
		{ 75, "Atteindre 75: Ench. de brassards (Vie mineure)" },
		{ 85, "Atteindre 85: Ench. de brassards (D\195\169viation mineure)" },
		{ 100, "Atteindre 100: Ench. de brassards (Endurance mineure)" },
		{ 101, "Cr\195\169er un B\195\162tonnet runique en argent" },
		{ 105, "Atteindre 105: Ench. de brassards (Endurance mineure)" },
		{ 120, "Atteindre 120: Baguette magique sup\195\169rieure" },
		{ 130, "Atteindre 130: Ench. de bouclier (Endurance mineure)" },
		{ 150, "Atteindre 150: Ench. de brassards (Endurance inf\195\169rieure)" },
		{ 151, "Cr\195\169er un B\195\162tonnet runique en or" },
		{ 160, "Atteindre 160: Ench. de brassards (Endurance inf\195\169rieure)" },
		{ 165, "Atteindre 165: Ench. de bouclier (Endurance inf\195\169rieure)" },
		{ 180, "Atteindre 180: Ench. de brassards (Esprit)" },
		{ 200, "Atteindre 200: Ench. de brassards (Force)" },
		{ 201, "Cr\195\169er un B\195\162tonnet runique en vrai-argent" },
		{ 205, "Atteindre 205: Ench. de brassards (Force)" },
		{ 225, "Atteindre 225: Ench. de cape (D\195\169fense sup\195\169rieure)" },
		{ 235, "Atteindre 235: Ench. de gants (Agilit\195\169)" },
		{ 245, "Atteindre 245: Ench. de plastron (Sant\195\169 excellente)" },
		{ 250, "Atteindre 250: Ench. de brassards (Force sup\195\169rieure)" },
		{ 270, "Atteindre 270: Huile de mana inf\195\169rieure\nRecette vendue \195\160 Silithus" },
		{ 290, "Atteindre 290: Ench. de bouclier (Endurance sup\195\169rieure)\nou Ench. de bottes (Endurance sup\195\169rieure)" },
		{ 291, "Cr\195\169er un B\195\162tonnet runique en arcanite" },
		{ 300, "Atteindre 300: Ench. de cape (D\195\169fense excellente)" },
-----------     OUTRETERRE
		{ 301, "Cr\195\169er un B\195\162tonnet runique en gangrefer" },
		{ 305, "Atteindre 305: Ench. de cape (D\195\169fense excellente)" },
		{ 315, "Atteindre 315: Ench. de brassards (Assaut)" },
		{ 325, "Atteindre 325: Ench. de cape (Armure majeure)\nou Ench. de gants (Assaut)" },
		{ 335, "Atteindre 335: Ench. de plastron (Esprit majeur)" },
		{ 340, "Atteindre 340: Ench. de bouclier (Endurance majeure)" },
		{ 345, "Atteindre 345: Huile de sorcier excellente\nFaire cel\195\160 jusqu'\195\160 atteindre 350 si vous avez les composants" },
		{ 350, "Atteindre 350: Ench. de gants (Force majeure)" },
-- OBSOLETE	{ 351, "Cr\195\169er un B\195\162tonnet runique en adamantite" },
-- OBSOLETE	{ 360, "Atteindre 360: Ench. de gants (Force majeure)" },
-- OBSOLETE	{ 370, "Atteindre 370: Ench. de gants (Frappe-sort)\nRequiert Exp\195\169dition C\195\169narienne - R\195\169v\195\169r\195\169" },
-- OBSOLETE	{ 375, "Atteindre 375: Ench. d'anneau (Pouvoir de gu\195\169rison)\nRequiert Les Sha'tar - R\195\169v\195\169r\195\169" },
-----------     NORFENDRE
		{ 360, "Atteindre 360: Enchantement de cape (Vitesse)" },
		{ 375, "Atteindre 375: Enchantement. de brassards (Frappe)" },
		{ 376, "Cr\195\169er un B\195\162tonnet runique en \195\169ternium" },
		{ 380, "Atteindre 380: Enchantement. de brassards (Frappe)" },
		{ 385, "Atteindre 385: Enchantement. de brassards (Intel. exceptionnelle)" },
		{ 395, "Atteindre 395: Enchantement. de bottes (Marcheglace)" },
		{ 415, "Atteindre 415: Enchantement. de cape (Agilit\195\169 excellente)" },
		{ 420, "Atteindre 420: Enchantement. de bottes (Esprit sup\195\169rieur)" },
		{ 425, "Atteindre 425: Enchantement. de bouclier (D\195\169fense)" },
		{ 426, "Cr\195\169er un B\195\162tonnet runique en titane" },
		{ 430, "Atteindre 430: Enchantement. de bouclier (D\195\169fense)" },
		{ 435, "Atteindre 435: Enchantement. de cape (Armure puissante)\n|cFFFFD700Disponible chez Vanessa Sellers \195\160 Dalaran pour 4 \195\169clats de r\195\170ve" },
		{ 445, "Atteindre 445: Enchantement. de gants (Homme d'armes)\n|cFFFFD700Disponible chez Vanessa Sellers \195\160 Dalaran pour 4 \195\169clats de r\195\170ve" },
		{ 450, "Atteindre 450: Enchantement. de bottes (Assaut sup\195\169rieur)\n|cFFFFD700Disponible chez Vanessa Sellers \195\160 Dalaran pour 4 \195\169clats de r\195\170ve" }
	},
	[BI["Blacksmithing"]] = {
		{ 25, "Atteindre 25: Pierre \195\160 aiguiser brute" },
		{ 45, "Atteindre 45: Pierre de lest brute" },
		{ 75, "Atteindre 75: Ceinture en anneaux de cuivre" },
		{ 80, "Atteindre 80: Pierre de lest grossi\195\168re" },
		{ 100, "Atteindre 100: Ceinture runique en cuivre" },
		{ 105, "Atteindre 105: B\195\162tonnet en argent" },
		{ 125, "Atteindre 125: Epauli\195\168res grossi\195\168res en bronze" },
		{ 150, "Atteindre 150: Pierre de lest lourde" },
		{ 155, "Atteindre 155: B\195\162tonnet dor\195\169" },
		{ 165, "Atteindre 165: Epauli\195\168res en fer \195\169meraude" },
		{ 185, "Atteindre 185: Brassards en fer \195\169meraude" },
		{ 200, "Atteindre 200: Brassards en \195\169cailles dor\195\169es" },
		{ 210, "Atteindre 210: Pierre de lest solide" },
		{ 215, "Atteindre 215: Gantelets en \195\169cailles dor\195\169es" },
		{ 235, "Atteindre 235: Heaume en plaques d'acier\nou Brassards en \195\169cailles de mithril (plus rentable)\nRecette \195\160 Nid-de-l'aigle (A) ou Pierr\195\170che (H)" },
		{ 250, "Atteindre 250: Camail en mithril\nou Eperons en mithril (plus rentable)" },
		{ 260, "Atteindre 260: Pierre \195\160 aiguiser dense" },
		{ 270, "Atteindre 270: Ceinture en thorium ou Brassards en thorium (plus rentable)\nJambi\195\168res de forge-terre (Sp\195\169 armure)\nLame l\195\169g\195\168re de forge-terre (Sp\195\169 arme)\nMarteau l\195\169ger de forge-braise (Sp\195\169 marteau)\nHache l\195\169g\195\168re de forge-ciel (Sp\195\169 hache)" },
		{ 295, "Atteindre 295: Brassards imp\195\169riaux en plaques" },
		{ 300, "Atteindre 300: Bottes imp\195\169riales en plaques" },
-----------     OUTRETERRE
		{ 305, "Atteindre 305: Pierre de lest gangren\195\169e" },
		{ 320, "Atteindre 320: Ceinture en plaques de gangrefer" },
		{ 325, "Atteindre 325: Bottes en plaques de gangrefer" },
		{ 330, "Atteindre 330: Rune de garde inf\195\169rieure" },
		{ 335, "Atteindre 335: Cuirasse en gangrefer" },
		{ 340, "Atteindre 340: Fendoir en adamantite\nVendu \195\160 Shattrah, Lune-d'argent, Exodar" },
		{ 345, "Atteindre 345: Gardien de sauvegarde inf\195\169rieur\nVendu au bastion des Marteaux-hardis et Thrallmar" },
		{ 350, "Atteindre 350: Fendoir en adamantite" },
-- OBSOLETE	{ 360, "Atteindre 360: Pierre de lest d'adamantite\nRequiert Exp\195\169dition C\195\169narienne - Honor\195\169" },
-- OBSOLETE	{ 370, "Atteindre 370: Gants en gangracier (Cryptes d'Auchenai)\nGants plaie-des-flammes (Aldor - Honor\195\169)\nCeinture enchant\195\169e en adamantite (Clairvoyants - Amical)" },
-- OBSOLETE	{ 375, "Atteindre 375: Gants en gangracier (Cryptes d'Auchenai)\nCuirasse plaie-des-flammes (Aldor - R\195\169v\195\169r\195\169)\nCeinture enchant\195\169e en adamantite (Clairvoyants - Amical)" },
-----------     NORFENDRE
		{ 360, "Atteindre 360: Ceinture en cobalt" },
		{ 370, "Atteindre 370: Brassards en cobalt" },
		{ 375, "Atteindre 375: Heaume en cobalt" },
		{ 380, "Atteindre 380: Gantelets en cobalt" },
		{ 385, "Atteindre 385: Bottes \195\160 pointes en cobalt" },
		{ 390, "Atteindre 390: Shuriken au vol s\195\187r" },
		{ 395, "Atteindre 395: Hache de guerre \195\169br\195\169ch\195\169e en cobalt" },
		{ 400, "Atteindre 400: Ceinture brillante en saronite" },
		{ 405, "Atteindre 405: Casque \195\160 cornes en cobalt" },
		{ 410, "Atteindre 410: Bottes brillantes en saronite" },
		{ 415, "Atteindre 415: Brassards en saronite tremp\195\169e" },
		{ 425, "Atteindre 425: Boucle de ceinture \195\169ternelle\nTr\195\168s lucratives" },
		{ 430, "Atteindre 430: Dragonne en titane\nSe revend bien" },
		{ 435, "Atteindre 435: Haubert sauvage en saronite" },
		{ 445, "Atteindre 445: Cuissards d'intimidation" },
		{ 450, "Atteindre 450: Fabriquer des pi\195\168ces \195\169piques utiles\nSinon continuer Cuissards d'intimidation (mais vert)\n" }
	},
	[BI["Alchemy"]] = { 
		{ 60, "Atteindre 60: Potion de soins mineure" },
		{ 110, "Atteindre 110: Potion de soins inf\195\169rieure" },
		{ 140, "Atteindre 140: Potion de soins" },
		{ 155, "Atteindre 155: Potion de mana inf\195\169rieure" },
		{ 185, "Atteindre 185: Potion de soins sup\195\169rieure" },
		{ 210, "Atteindre 210: Elixir d'Agilit\195\169" },
		{ 215, "Atteindre 215: Elixir de d\195\169fense sup\195\169rieure" },
		{ 230, "Atteindre 230: Potion de soins excellente" },
		{ 250, "Atteindre 250: Elixir de d\195\169tection des morts-vivants" },
		{ 265, "Atteindre 265: Elixir d'agilit\195\169 sup\195\169rieure" },
		{ 285, "Atteindre 285: Potion de mana excellente" },
		{ 300, "Atteindre 300: Potion de soins majeure" },
-----------     OUTRETERRE
		{ 315, "Atteindre 315: Potion de super-soins\nou Potion de super-mana" },
		{ 350, "Atteindre 350: Potion de l'alchimiste fou\nPasse rapidement jaune (335), mais rentable \195\160 faire" },
-- OBSOLETE	{ 375, "Atteindre 375: Potion de sommeil sans r\195\170ve majeure\nVendu au Bastion All\195\169rien (A)\nou Bastion des Sirre-Tonnerre (H)" },
-----------     NORFENDRE
		{ 365, "Atteindre 365: Potion de mana glaciale" },
		{ 380, "Atteindre 380: Elixir de puissance des sorts" },
		{ 385, "Atteindre 385: Potion des cauchemars" },
		{ 395, "Atteindre 395: Elixir de force puissante" },
		{ 405, "Atteindre 405: Elixir d'agilit\195\169 puissante\nPass\195\169 400 on peut utiliser la Recherches en alchimie de Norfendre (passe vert \195\160 420)" },
		{ 410, "Atteindre 410: Potion de soins runique" },
		{ 425, "Atteindre 425: Potion de mana runique" },
		{ 435, "Atteindre 435: Diamant si\195\168geterre" },
		{ 450, "Atteindre 450: N'importe quel flacon\nMonter au-del\195\160 de 335 est juste utile pour la Transmutation \195\169ternelle : Pouvoir" }
	},
	[L["Mining"]] = {
		{ 65, "Atteindre 65: Miner le cuivre\nToutes zones de d\195\169part" },
		{ 125, "Atteindre 125: Miner l'\195\169tain, l'argent, l'incendicite et la pierre de sang inf\195\169rieur\n\nMiner l'incendicite au Rocher de Thelgen (Les Paluns)\nProgression rapide jusqu'\195\160 125" },
		{ 175, "Atteindre 175: Miner le fer et l'or\nD\195\169solace, Orneval, Terres ingrates, Hautes-terres d'Arathi,\nMontagnes d'Alt\195\169rac, Vall\195\169e de strangleronce, Marais des chagrins" },
		{ 250, "Atteindre 250: Miner le mithril et le vrai-argent\nTerres foudroy\195\169es, Gorge des vents br\195\187lants, Terres ingrates, Les Hinterlands,\nMaleterres de l'ouest, Azshara, Berceau-de-l'hiver, Gangrebois, Les Serres-Rocheuses, Tanaris" },
		{ 300, "Atteindre 300: Miner le thorium \nCrat\195\168re d'Un'Goro, Azshara, Berceau-de-l'hiver, Terres foudroy\195\169es\nGorge des vents br\195\187lants, Steppes ardentes, Maleterres (Est et Ouest)" },
-----------     OUTRETERRE
		{ 330, "Atteindre 330: Miner le gangrefer\nP\195\169ninsule des flammes infernales, Mar\195\169cage de Zangar" },
		{ 350, "Atteindre 350: Miner le gangrefer et l'adamantite\nFor\195\170t de Terrokar, Nagrand\nSimplement partout en Outreterre" },
-----------     NORFENDRE
		{ 400, "Atteindre 400: Miner le cobalt dans le Ford Hurlant, Zul'Drak et la d\195\169solation des dragons\nPermet aussi de monter 450" },
		{ 450, "Atteindre 450: Miner la saronite dans le bassin de Sholazar, la couronne de glace et les Pics foudroy\195\169s" }
	},
	[L["Herbalism"]] = {
		{ 50, "Atteindre 50: Collecter du Feuillargent et Pacifique\nToutes zones de d\195\169part" },
		{ 70, "Atteindre 70: Collecter de la Mage royale et Terrestrine\nLes tarides, Marche de l'ouest, For\195\170t des pins argent\195\169s, Loch Modan" },
		{ 100, "Atteindre 100: Collecter de l'Eglantine\nFor\195\170t des pins argent\195\169s, Bois de la p\195\169nombre, Sombrivage,\nLoch Modan, Les Carmines" },
		{ 115, "Atteindre 115: Collecter de la Doulourante\nOrneval, Les Serres-Rocheuses, Sud des Tarides\nLoch Modan, Les Carmines" },
		{ 125, "Atteindre 125: Collecter de l'Aci\195\169rite sauvage\nLes Serres-Rocheuses, Hautes-Terres d'Arathi, Vall\195\169e de Strangleronce\nSud des Tarides, Milles pointes" },
		{ 160, "Atteindre 160: Collecter du Sang royal\nOrneval, Les Serres-Rocheuses, Les Paluns,\nContreforts de Hautebrande, Marais des chagrins" },
		{ 185, "Atteindre 185: Collecter de l'Aveuglette\nMarais des chagrins" },
		{ 205, "Atteindre 205: Collecter de la Moustaches de Khadgar\nLes Hinterlands, Hautes-Terres d'Arathi, Marais des chagrins" },
		{ 230, "Atteindre 230: Collecter de la Fleur de feu\nGorge des vents br\195\187lants, Les terres foudroy\195\169es, Tanaris" },
		{ 250, "Atteindre 250: Collecter de la Soleillette\nGangrebois, Feralas, Azshara\nLes Hinterlands" },
		{ 270, "Atteindre 270: Collecter du Gromsang\nGangrebois, Les terres foudroy\195\169es,\nConvent de Mannoroc en D\195\169solace" },
		{ 285, "Atteindre 285: Collecter du Feuiller\195\170ve\nCrat\195\168re d'Un'Goro, Azshara" },
		{ 300, "Atteindre 300: Collecter de la Fleur de peste\nMaleterres (Est et Ouest), Gangrebois\nou Calot de glace au Berceau-de-l'hiver" },
-----------     OUTRETERRE
		{ 330, "Atteindre 330: Collecter de la  Gangrelette\nP\195\169ninsule des flammes infernales, Le mar\195\169cage de Zangar" },
		{ 350, "Atteindre 350: Toute fleur disponible en Outreterre\nCibler le mar\195\169cage de Zangar et la for\195\170t de Terrokar" },
-----------     NORFENDRE
		{ 400, "Atteindre 400: Collecter du Tr\195\168fle dor\195\169\nLa Toundra Bor\195\169enne, Ford Hurlant" },
		{ 450, "Atteindre 450: Collecter du Lys tigr\195\169\nLe bassin de sholazar, les Grisonnes, Ford Hurlant" }
	},
	[L["Skinning"]] = {
		{ 375, "Atteindre 375: Diviser le niveau actuel de d\195\169pe\185\167age par 5,\net tuer les monstres d\195\169pe\185\167ables du niveau obtenu" }
	},
	-- source: http://www.almostgaming.com/wowguide...kpicking-guide
	[L["Lockpicking"]] = {
		{ 85, "Atteindre 85: Coffre d'entrainement pour voleur\nScierie d'Alther dans les Carmines (A)\nBateau au sud de Cabestan (H)" },
		{ 150, "Atteindre 150: Coffre pr\195\168s du boss de la qu\195\170te du poison\nMarche de l'ouest (A) ou Les tarides (H)" },
		{ 185, "Atteindre 185: Camps des Murlocs (Les Paluns)" },
		{ 225, "Atteindre 225: Gr\195\168ve de Sar'Theris (D\195\169solace)\n" },
		{ 250, "Atteindre 250: Forteresse d'Angor (Terres ingrates)" },
		{ 275, "Atteindre 275: La fosse aux scories (Gorge des vents br\195\187lants)" },
		{ 300, "Atteindre 300: Crique des gr\195\169ements (Tanaris)\nPlage des cr\195\170tes du sud (Azshara)" },
-----------     OUTRETERRE
		{ 325, "Atteindre 325: Village des Tourbe-farouche (Le mar\195\169cage de Zangar)" },
		{ 350, "Atteindre 350: Forteresse Kil'sorrau (Nagrand)\nVoler les Rochepoing \195\160 Nagrand" },
-----------     NORFENDRE        
		{ 400, "Atteindre 400: Faire du vol \195\160 la tire sur les humanoides du Norfendre\n R\195\169cup\195\169rer des Coffrets renforc\195\169s pour les crocheter" }
	},

	-- ** Secondary professions **
	[BI["First Aid"]] = {
		{ 40, "Atteindre 40: Bandages en lin" },
		{ 80, "Atteindre 80: Bandage \195\169pais en lin\nDevenir compagnon \195\160 50" },
		{ 115, "Atteindre 115: Bandages en laine" },
		{ 150, "Atteindre 150: Bandages \195\169pais en laine\nObtenir le manuel de secourisme expert \195\160 125\nAcheter le manuel \195\160 Stormgarde (A) ou \195\160 Mur-de-foug\195\168res (H)" },
		{ 180, "Atteindre 180: Bandage en soie" },
		{ 210, "Atteindre 210: Bandage \195\169pais en soie" },
		{ 240, "Atteindre 240: Bandages en tisse-mage\nQu\195\170te de secourisme au niveau 35\nIle de Theramore (A) ou Tr\195\169pas d'Orgrim (H)" },
		{ 260, "Atteindre 260: Bandage \195\169pais en tisse-mage\nValider niveau suivant au donneur de qu\195\170te secourisme" },
		{ 290, "Atteindre 290: Bandage en \195\169toffe runique\nValider niveau suivant au donneur de qu\195\170te secourisme" },
-----------     OUTRETERRE
		{ 330, "Atteindre 330: Bandage \195\169pais en \195\169toffe runique\nAcheter le manuel de maitre en secourisme\nTemple de Telhamat (A) Guet de l'\195\169pervier (H)" },
		{ 360, "Atteindre 360: Bandage en tisse-n\195\169ant\nAcheter le manuel au Temple de Telhamat (A) ou au Guet de l'\195\169pervier (H)" },
		{ 375, "Atteindre 375: Bandage \195\169pais en tisse-n\195\169ant\nAcheter le manuel au Temple de Telhamat (A) ou au Guet de l'\195\169pervier (H)" },
-----------     NORFENDRE
		{ 400, "Atteindre 400: Bandage en tisse-givre\nValider niveau suivant au donneur de qu\195\170te secourisme" },
		{ 450, "Atteindre 450: Bandage \195\169pais en tisse-givre\nLe manuel est un butin mondial est n\195\169c\195\169ssite d'\195\170tre au moins 390\nCertains conseillent les trolls de Zul'drak pour le trouver" }
	},
	[BI["Cooking"]] = {
		{ 40, "Atteindre 40: Pain \195\169pic\195\169" },
		{ 85, "Atteindre 85: Viande d'ours fum\195\169e, Beignet de crabe" },
		{ 100, "Atteindre 100: Pince de crabe farcie (A)\nBrouet de rat (H)" },
		{ 125, "Atteindre 125: Brouet de rat (H)\nK\195\169bab de loup assaisonn\195\169 (A)" },
		{ 175, "Atteindre 175: Omelette au go\195\187t \195\169trange (A)\nC\195\180telettes de lion \195\169pic\195\169es (H)" },
		{ 200, "Atteindre 200: R\195\180ti de raptor" },
		{ 225, "Atteindre 225: Saucisse d'araign\195\169e\n\n|cFFFFFFFFQu\195\170te de cuisine:\n|cFFFFD70012 Oeufs g\195\169ants,\n10 Chair de palourde piquante,\n20 Emmental d'Alterac " },
		{ 275, "Atteindre 275: Omelette monstrueuse\nou Steak de loup tendre" },
		{ 285, "Atteindre 285: Courante-surprise\nHaches-trippes (Pusillin)" },
		{ 300, "Atteindre 300: Boulettes fum\195\169es du d\195\169sert\nQu\195\170te en Silithus" },
-----------     OUTRETERRE
		{ 325, "Atteindre 325: Croque-ravageur, Bouch\195\169es de busard" },
		{ 335, "Atteindre 335: Sabot-fourchu r\195\180ti\nSteak dimensionnel, Steak de talbuk" },
-- OBSOLETE	{ 375, "Atteindre 375: Serpent croustillant\nC\195\180telettes mok'nathal" },
-----------     NORFENDRE
		{ 350, "Atteindre 350: Rago\195\187t nordique\n|cFFFFFFFFQu\195\170te de cuisine disponible dans les zones de d\195\169part" },
		{ 400, "Atteindre 400: Steak de brochepelle si la zone de d\195\169part est Fjord Hurlant\nMenu de mammouth si la zone de d\195\169part est la Toundra Bor\195\169enne" },
		{ 450, "Atteindre 450: Toutes les recettes disponibles via les qu\195\170tes journali\195\168res de Dalaran" }
	}, 
	-- source: http://www.wowguideonline.com/fishing.html
	[BI["Fishing"]] = {
		{ 50, "Atteindre 50: Toute zone de d\195\169part" },
		{ 75, "Atteindre 75: Les canaux \195\160 Hurlevent (A)\nLe bassin d'eau d'Orgrimmar (H)" },
		{ 150, "Atteindre 150: Rivi\195\168re des contreforts de hautebrande" },
		{ 225, "Atteindre 225: Acheter le manuel d'expert en p\195\170che \195\160 Baie-du-butin\nP\195\170cher en D\195\169solace ou hautes-terres d'Arathi" },
		{ 250, "Atteindre 250: Hinterlands, Tanaris\n\n|cFFFFFFFFQu\195\170te de p\195\170che dans les mar\195\169cages d'Aprefrange\n|cFFFFD700Savage Coast Blue Sailfin (Vall\195\169e de Strangleronce)\nFeralas Ahi (Verdantis River, Feralas)\nSer'theris Striker (Northern Sartheris Strand, D\195\169solace)\nMisty Reed Mahi Mahi (Marais des chagrins coastline)" },
		{ 260, "Atteindre 260: Gangrebois" },
		{ 300, "Atteindre 300: Azshara" },
-----------     OUTRETERRE
		{ 330, "Atteindre 330: Est du Mar\195\169cage de Zangar\nAcheter le manuel d'artisan p\195\170che \195\160 l'Exp\195\169dition C\195\169narienne" },
		{ 345, "Atteindre 345: Ouest du Mar\195\169cage de Zangar" },
		{ 360, "Atteindre 360: For\195\170t de Terrokar" },
		{ 375, "Atteindre 375: For\195\170t de Terrokar (Skettis), en altitude\nMonture volante requise" },
-----------     NORFENDRE
		{ 450, "Atteindre 450: Avoir de la patience et des appats\nVoir le maitre des p\195\170cheurs, pas besoin de manuel" }
	},
	
	-- suggested leveling zones, compiled by Thaoky, based on too many sources to list + my own leveling experience on Alliance side
	["Leveling"] = {
		{ 10, "Atteindre 10: Toute zone de d\195\169part" },
		{ 20, "Atteindre 20: "  .. BZ["Loch Modan"] .. "\n" .. BZ["Westfall"] .. "\n" .. BZ["Darkshore"] .. "\n" .. BZ["Bloodmyst Isle"] 
						.. "\n" .. BZ["Silverpine Forest"] .. "\n" .. BZ["The Barrens"] .. "\n" .. BZ["Ghostlands"]},
		{ 25, "Atteindre 25: " .. BZ["Wetlands"] .. "\n" .. BZ["Redridge Mountains"] .. "\n" .. BZ["Ashenvale"] 
						.. "\n" .. BZ["The Barrens"] .. "\n" .. BZ["Stonetalon Mountains"] .. "\n" .. BZ["Hillsbrad Foothills"] },
		{ 28, "Atteindre 28: " .. BZ["Duskwood"] .. "\n" .. BZ["Wetlands"] .. "\n" .. BZ["Ashenvale"] 
						.. "\n" .. BZ["Stonetalon Mountains"] .. "\n" .. BZ["Thousand Needles"] },
		{ 31, "Atteindre 31: " .. BZ["Duskwood"] .. "\n" .. BZ["Thousand Needles"] .. "\n" .. BZ["Ashenvale"] },
		{ 35, "Atteindre 35: " .. BZ["Thousand Needles"] .. "\n" .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Alterac Mountains"] 
						.. "\n" .. BZ["Arathi Highlands"] .. "\n" .. BZ["Desolace"] },
		{ 40, "Atteindre 40: " .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Desolace"] .. "\n" .. BZ["Badlands"]
						.. "\n" .. BZ["Dustwallow Marsh"] .. "\n" .. BZ["Swamp of Sorrows"] },
		{ 43, "Atteindre 43: " .. BZ["Tanaris"] .. "\n" .. BZ["Stranglethorn Vale"] .. "\n" .. BZ["Badlands"] 
						.. "\n" .. BZ["Dustwallow Marsh"] .. "\n" .. BZ["Swamp of Sorrows"] },
		{ 45, "Atteindre 45: " .. BZ["Tanaris"] .. "\n" .. BZ["Feralas"] .. "\n" .. BZ["The Hinterlands"] },
		{ 48, "Atteindre 48: " .. BZ["Tanaris"] .. "\n" .. BZ["Feralas"] .. "\n" .. BZ["The Hinterlands"] .. "\n" .. BZ["Searing Gorge"] },
		{ 51, "Atteindre 51: " .. BZ["Tanaris"] .. "\n" .. BZ["Azshara"] .. "\n" .. BZ["Blasted Lands"] 
						.. "\n" .. BZ["Searing Gorge"] .. "\n" .. BZ["Un'Goro Crater"] .. "\n" .. BZ["Felwood"] },
		{ 55, "Atteindre 55: " .. BZ["Un'Goro Crater"] .. "\n" .. BZ["Felwood"] .. "\n" .. BZ["Burning Steppes"]
						.. "\n" .. BZ["Blasted Lands"] .. "\n" .. BZ["Western Plaguelands"] },
		{ 58, "Atteindre 58: " .. BZ["Winterspring"] .. "\n" .. BZ["Burning Steppes"] .. "\n" .. BZ["Western Plaguelands"] 
						.. "\n" .. BZ["Eastern Plaguelands"] .. "\n" .. BZ["Silithus"] },
		{ 60, "Atteindre 60: " .. BZ["Winterspring"] .. "\n" .. BZ["Eastern Plaguelands"] .. "\n" .. BZ["Silithus"] },
		{ 62, "Atteindre 62: " .. BZ["Hellfire Peninsula"] },
		{ 64, "Atteindre 64: " .. BZ["Zangarmarsh"] .. "\n" .. BZ["Terokkar Forest"]},
		{ 65, "Atteindre 65: " .. BZ["Terokkar Forest"] },
		{ 66, "Atteindre 66: " .. BZ["Terokkar Forest"] .. "\n" .. BZ["Nagrand"]},
		{ 67, "Atteindre 67: " .. BZ["Nagrand"]},
		{ 68, "Atteindre 68: " .. BZ["Blade's Edge Mountains"]},
		{ 70, "Atteindre 70: " .. BZ["Blade's Edge Mountains"] .. "\n" .. BZ["Netherstorm"] .. "\n" .. BZ["Shadowmoon Valley"]},
		{ 72, "Atteindre 72: " .. BZ["Howling Fjord"] .. "\n" .. BZ["Borean Tundra"]},
		{ 74, "Atteindre 74: " .. BZ["Grizzly Hills"] .. "\n" .. BZ["Dragonblight"]},
		{ 76, "Atteindre 76: " .. BZ["Dragonblight"] .. "\n" .. BZ["Zul'Drak"]},
		{ 78, "Atteindre 78: " .. BZ["Zul'Drak"] .. "\n" .. BZ["Sholazar Basin"]},
		{ 80, "Atteindre 80: " .. BZ["The Storm Peaks"] .. "\n" .. BZ["Icecrown"]},
	},
	

	-- Reputation levels
	-- -42000 = "Haï"
	-- -6000 = "Hostile"
	-- -3000 = "Inamical"
	-- 0 = "Neutre"
	-- 3000 = "Amical"
	-- 9000 = "Honor\195\169"
	-- 21000 = "R\195\169v\195\169r\195\169"
	-- 42000 = "Exalt\195\169"

	-- Outland factions: source: http://www.mmo-champion.com/
	[BF["The Aldor"]] = {
		{ 0, "Atteindre Neutre:\n" .. WHITE .. "[Glande \195\160 venin de croc-d'effroi]|r +250 rep\n\n"
				.. YELLOW .. "R\195\180deuse croc-d'effroi,\nVeuve croc-d'effroi\n"
				.. WHITE .. "(For\195\170t de Terrokar)" },
		{ 9000, "Atteindre Honor\195\169:\n" .. WHITE .. "[Marque de Kil'jaeden]|r\n+25 rep" },
		{ 42000, "Atteindre Exalt\195\169:\n" .. WHITE .. "[Marque de Sargeras]|r +25 rep par marque\n"
				.. GREEN .. "[Arme gangren\195\169e]|r +350 rep (+1 [Poussi\195\168re sacr\195\169e])" }
	},
	[BF["The Scryers"]] = {
		{ 0, "Atteindre Neutral:\n" .. WHITE .. "[Oeil de basilic tremp\195\169caille]|r +250 rep\n\n"
				.. YELLOW .. "P\195\169trificateur Echine-de-fer,\nD\195\169voreur Tremp\195\169caille,\nBasilic Tremp\195\169caille\n"
				.. WHITE .. "(For\195\170t de Terrokar)" },
		{ 9000, "Atteindre Honor\195\169:\n" .. WHITE .. "[Chevali\195\168re Aile-de-feu]|r\n+25 rep" },
		{ 42000, "Atteindre Exalt\195\169:\n" .. WHITE .. "[Chevali\195\168re Solfurie]|r +25 rep par chevali\195\168re\n"
				.. GREEN .. "[Tome des arcanes]|r +350 rep (+1 [Rune des arcanes])" }
	},
	[BF["Netherwing"]] = {
		{ 3000, "Atteindre Amical, r\195\169p\195\169ter ces qu\195\170tes:\n\n"
				.. YELLOW .. "Une mort lente (Journali\195\168re)|r 250 rep\n"
				.. YELLOW .. "Du pollen de pruin\195\169ante (Journali\195\168re)|r 250 rep\n"
				.. YELLOW .. "Les cristaux de l'Aile-du-N\195\169ant (Journali\195\168re)|r 250 rep\n"
				.. YELLOW .. "Les cieux pas si cl\195\169ments... (Journali\195\168re)\n"
				.. YELLOW .. "La ru\195\169e vers les oeufs de l'Aile-du-N\195\169ant (R\195\169p\195\169table)|r 250 rep" },
		{ 9000, "Atteindre Honor\195\169, r\195\169p\195\169ter ces qu\195\170tes:\n\n"
				.. YELLOW .. "\195\170tre surveillant : savoir faire les bons choix|r 350 rep\n"
				.. YELLOW .. "Le botterang : un traitement pour les p\195\169ons bons \195\160 rien (Journali\195\168re)|r 350 rep\n"
				.. YELLOW .. "Ramasser les morceaux... (Journali\195\168re)|r 350 rep\n"
				.. YELLOW .. "Les dragons sont les derniers de nos soucis (Journali\195\168re)|r 350 rep\n"
				.. YELLOW .. "Affol\195\169s et perturb\195\169s|r 350 rep\n" },
		{ 21000, "Atteindre R\195\169v\195\169r\195\169, r\195\169p\195\169ter ces qu\195\170tes:\n\n"
				.. YELLOW .. "Dominer le Dominateur|r 500 rep\n"
				.. YELLOW .. "Perturber la Porte du cr\195\169puscule (Journali\195\168re)|r 500 rep\n"
				.. YELLOW .. "Qu\195\170tes de course de drake: 500 chacune \navec 5 pour la 1\195\168re , et 1000 pour la 6\195\168me" },
		{ 42000, "Atteindre Exalt\195\169, r\195\169p\195\169ter cette qu\195\170te:\n\n"
				.. YELLOW .. "Le plus mortel des pi\195\168ges (Journali\195\168re) (groupe de 3)|r 500 rep" }
	},
	[BF["Honor Hold"]] = {
		{ 9000, "Atteindre Honor\195\169:\n\n" 
				.. YELLOW .. "Qu\195\170tes de la p\195\169ninsule des flammes infernales\n"
				.. GREEN .. "Faire l'instance : Remparts des flammes infernales |r(Normal)\n"
				.. GREEN .. "Faire l'instance : La fournaise du sang |r(Normal)" },
		{ 42000, "Atteindre Exalt\195\169:\n\n" 
				.. GREEN .. "Faire l'instance : Les salles bris\195\169es |r(Normal et H\195\169roïque)\n"
				.. GREEN .. "Faire l'instance : Remparts des flammes infernales |r(H\195\169roïque)\n"
				.. GREEN .. "Faire l'instance : La fournaise du sang |r(H\195\169roïque)" }
	},
	[BF["Thrallmar"]] = {
		{ 9000, "Atteindre Honor\195\169:\n\n" 
				.. YELLOW .. "Qu\195\170tes de la p\195\169ninsule des flammes infernales\n"
				.. GREEN .. "Faire l'instance : Remparts des flammes infernales |r(Normal)\n"
				.. GREEN .. "Faire l'instance : La fournaise du sang |r(Normal)" },
		{ 42000, "Atteindre Exalt\195\169:\n\n" 
				.. GREEN .. "Faire l'instance : Les salles bris\195\169es |r(Normal et H\195\169roïque)\n"
				.. GREEN .. "Faire l'instance : Remparts des flammes infernales |r(H\195\169roïque)\n"
				.. GREEN .. "Faire l'instance : La fournaise du sang |r(H\195\169roïque)" }
	},
	
	[BF["Cenarion Expedition"]] = {
		{ 3000, "Atteindre Amical:\n\n" 
				.. WHITE .. "Tuer les Nagas Sombrecr\195\170te et Ecaille-sanglante (+5 rep)\n"
				.. YELLOW .. "Qu\195\170tes dans le Mar\195\169cage de Zangar\n"
				.. "Faire n'importe quelle instance du " .. GREEN .. "R\195\169servoir de Glissecroc|r\n\n"
				.. WHITE .. "Garder les [Morceaux de plantes non identifi\195\169es] pour passer honor\195\169" },
		{ 9000, "Atteindre Honor\195\169:\n\n"
				.. WHITE .. "Rendre les [Morceaux de plantes non identifi\195\169es] x240\n"
				.. YELLOW .. "Qu\195\170tes dans le Mar\195\169cage de Zangar\n"
				.. "Faire n'importe quelle instance du " .. GREEN .. "R\195\169servoir de Glissecroc|r" },
		{ 42000, "Atteindre Exalt\195\169:\n\n"
				.. WHITE .. "Rendre les [Armes de Glissecroc] +75 rep\n\n"
				.. GREEN .. "Faire l'instance : Les enclos aux esclaves |r(Normal)\n"
				.. "Faire n'importe quelle instance du " .. GREEN .. "R\195\169servoir de Glissecroc|r (H\195\169roïque)" }
	},
	[BF["Keepers of Time"]] = {
		{ 42000, "Atteindre Exalt\195\169:\n\n" 
				.. "|rFaire les instances " .. GREEN .. "Les Contreforts d'Hautebrande d'antan|r et " .. GREEN .. "Le noir mar\195\169cage\n\n"
				.. YELLOW .. "Garder les qu\195\170tes pour le plus tard possible:\n s\195\169rie de qu\195\170tes du Hautebrande d'antan = 5000 rep\ns\195\169rie de qu\195\170tes du noir mar\195\169cage = 8000 rep" }
	},
	[BF["The Sha'tar"]] = {
		{ 42000, "Atteindre Exalt\195\169:\n\n" 
				.. GREEN .. "Faire l'instance : La Botanica |r(Normal et H\195\169roïque)\n"
				.. GREEN .. "Faire l'instance : Le Mechanar |r(Normal et H\195\169roïque)\n"
				.. GREEN .. "Faire l'instance : L'Arcatraz |r(Normal et H\195\169roïque)\n" }
	}, 
	[BF["Lower City"]] = {
		{ 9000, "Atteindre Honor\195\169:\n\n" 
				.. WHITE .. "Rendre les [Plume d'Arakkoa] x30 (+250 rep)\n"
				.. GREEN .. "Faire l'instance : Labyrinthe des ombres |r(Normal)\n"
				.. GREEN .. "Faire l'instance : Cryptes Auchenai |r(Normal)\n"
				.. GREEN .. "Faire l'instance : Les salles de Sethekk |r(Normal)" },
		{ 42000, "Atteindre Exalt\195\169:\n\n" 
				.. GREEN .. "Faire l'instance : Labyrinthe des ombres |r(Normal et H\195\169roïque)\n"
				.. GREEN .. "Faire l'instance : Cryptes Auchenai |r(H\195\169roïque)\n"
				.. GREEN .. "Faire l'instance : Les salles de Sethekk |r(H\195\169roïque)" }
	}, 
	[BF["The Consortium"]] = {
		{ 3000, "Atteindre Amical:\n\n"
				.. "|rRendre les [Fragment de cristal d'Oshu'gun] +250 rep\n"
				.. "Rendre les [Paire de d\195\169fenses d'ivoire] +250 rep\n\n"
				.. GREEN .. "Faire l'instance : Tombes-mana |r(Normal)" },
		{ 9000, "Atteindre Honor\195\169:\n\n"
				.. "|rRendre les [Perles de guerre d'obsidienne] +250 rep\n\n"
				.. GREEN .. "Faire l'instance : Tombes-mana |r(Normal)" },
		{ 42000, "Atteindre Exalt\195\169:\n\n"
				.. "|rRendre les [Insigne de Zaxxis] +250 rep\n"
				.. "|rRendre les [Perles de guerre d'obsidienne] +250 rep\n\n"
				.. GREEN .. "Faire l'instance : Tombes-mana |r(H\195\169roïque)" }
	}

}
