-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

TRP2_DB_Objects = nil;

function TRP2_LoadDBItems_1()
	TRP2_DB_Objects = {
		["ITE00001"] = {
			["Nom"] = "Objet";
			["Description"] = "Un objet vide, sans aucune données.",
		},
		------------------------------------------------------------
		-- Range 00001 à 00010 : Tests
		------------------------------------------------------------

		------------------------------------------------------------
		-- Range 00011 à 00100 : Bordel
		------------------------------------------------------------
		
		["ITE00011"] = {
			["Poids"] = 200,
			["Description"] = "Un séchoir qui semble très complexe, avec un gros bouton rouge.\n\nP.S.  Les industries gnomes ne sont pas responsables des potentiels mauvais fonctionnements.",
			["bUtilisable"] = true,
			["TexteAnim"] = "Séchage",
			["TooltipUse"] = "Se sécher",
			["Createur"] = "Isshrinä",
			["OnUseEndFailEffet"] = "aura$AUR00905$0$2$1;aura$AUR00014$300$1$1;parole$|| Le séchoir gnome X-54 surchauffe et recouvre {me} de poussières et de cendres !$2;son$Sound\\\\Spells\\\\WandFireCast1.wav$2$10;aura$AUR01110$1200$1$1;",
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
			["OnUseStartFailEffet"] = "texte${me} n'est pas mouillé.$1;",
			["Nom"] = "Séchoir ultime gnome X-54",
			["OnUseStartCondi"] = "aurat(AUR00905)$>=$0;",
			["Icone"] = "INV_Weapon_Rifle_36",
			["Anim"] = 63,
			["Date"] = "28/04/11, 21:57:39 par Isshrinä",
			["OnUseEndEffet"] = "aura$AUR00905$0$2$1;parole$est maintenant sec !$2;son$Sound\\\\Spells\\\\WaterSteam_Impact2.wav$2$10",
			["Categorie"] = "Outil",
			["Outils"] = " 1  1  1  1  1",
			["DureeAnim"] = 5,
			["OnUseEndCondi"] = "rand$>$2;",
			["OnUseStartEffet"] = "son$Sound\\\\Spells\\\\WaterSteam_Impact1.wav$2$10;parole$utilise le séchoir gnome X-54 pour se sécher.$2;",
		},
		
		------------------------------------------------------------
		-- Range 00101 à 00200 : Nourriture
		------------------------------------------------------------
		
		
		
		
		------------------------------------------------------------
		-- Range 00201 à 00300 : Richesses
		------------------------------------------------------------
		["ITE00201"] = { -- Bourse (Bronze)
			["bUtilisable"] = true,
			["Charges"] = 1,
			["Description"] = "Une bourse contenant 10 pièces de bronze.",
			["Nom"] = "Bourse de monnaie de bronze",
			["OnUseEndEffet"] = "or$10$1;",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Richesse",
			["Icone"] = "INV_Misc_Bag_10_Black",
			["MaxStack"] = 10,
			["TooltipUse"] = "Récupérer l'argent",
			["Qualite"] = 2,
		},
		["ITE00202"] = { -- Bourse (Argent)
			["Charges"] = 1,
			["Description"] = "Une bourse contenant 10 pièces d'argent.",
			["bUtilisable"] = true,
			["Nom"] = "Bourse de monnaie d'argent",
			["OnUseEndEffet"] = "or$1000$1;",
			["TooltipUse"] = "Récupérer l'argent",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Richesse",
			["Icone"] = "INV_Misc_Bag_10_Blue",
			["MaxStack"] = 10,
			["Qualite"] = 3,
		},
		["ITE00203"] = { -- Bourse (Or)
			["bUtilisable"] = true,
			["Charges"] = 1,
			["Description"] = "Une bourse contenant 10 pièces d'or.",
			["Nom"] = "Bourse de monnaie d'or",
			["OnUseEndEffet"] = "or$100000$1;",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Richesse",
			["Icone"] = "INV_Misc_Bag_10",
			["MaxStack"] = 10,
			["TooltipUse"] = "Récupérer l'argent",
			["Qualite"] = 4,
		},
		
		------------------------------------------------------------
		-- Range 00301 à 00400 : Medecine
		------------------------------------------------------------
		["ITE00301"] = { -- Onguent
			["Poids"] = 100,
			["Description"] = "Un onguent permettant de soigner une brûlure fraiche.",
			["Outils"] = " 1  1  1  1  1",
			["OnUseEndEffet"] = "aura$AUR00011$0$2$1;",
			["Createur"] = "Telkostrasz",
			["Icone"] = "INV_Potion_01",
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 3,
			["Charges"] = 1,
			["Valeur"] = 500,
			["Nom"] = "Onguent",
			["TooltipUse"] = "Appliquer l'onguent",
			["Anim"] = 63,
			["bUtilisable"] = true,
			["Categorie"] = "Médecine",
			["DureeAnim"] = 4,
			["MaxStack"] = 5,
			["bImmobile"] = true,
			["OnUseStartEffet"] = "parole$s'applique un onguent.$2;son$Sound\\\\Item\\\\UseSounds\\\\UseBandage.wav$2$14;",
		},

		------------------------------------------------------------
		-- Range 00401 à 01000 : Objets de Quêtes
		------------------------------------------------------------
		-- Quête : Traitresse ! Horde --
		["ITE00401"] = { -- Lettre de Sana 
			["OnUseEndEffet"] = "docu$DOC00101;son$Sound\\\\Interface\\\\PickUp\\\\PickUpParchment_Paper.wav$1$0;",
			["Poids"] = 100,
			["Description"] = "Un lettre parfumée.",
			["bUtilisable"] = true,
			["bQuest"] = true,
			["TooltipUse"] = "Lire la lettre",
			["Nom"] = "Lettre de Sana",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Lettre",
			["Icone"] = "INV_Letter_15",
			["Outils"] = " 1  1  1  1  1",
			["Unique"] = 1,
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
		},
		-- Quête : Traitresse ! Alliance --
		["ITE00402"] = { -- Lettre d'Elly 
			["OnUseEndEffet"] = "docu$DOC00102;son$Sound\\\\Interface\\\\PickUp\\\\PickUpParchment_Paper.wav$1$0;",
			["Poids"] = 100,
			["Description"] = "Un lettre parfumée.",
			["bUtilisable"] = true,
			["bQuest"] = true,
			["TooltipUse"] = "Lire la lettre",
			["Nom"] = "Lettre d'Elly",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Lettre",
			["Icone"] = "INV_Letter_15",
			["Outils"] = " 1  1  1  1  1",
			["Unique"] = 1,
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
		},
	};
end

function TRP2_LoadDBItems_2()
	TRP2_DB_Objects = {
		["ITE00001"] = {
			["Nom"] = "Item";
			["Description"] = "A blank item, with no data.",
		},
		------------------------------------------------------------
		-- Range 00001 à 00010 : Tests
		------------------------------------------------------------

		------------------------------------------------------------
		-- Range 00011 à 00100 : Bordel
		------------------------------------------------------------
		
		["ITE00011"] = {
			["Poids"] = 200,
			["Description"] = "A hairdryer which seems very complex, with a big red button.\n\nP.S.  The gnomes industries are not responsible for potential malfunction.",
			["bUtilisable"] = true,
			["TexteAnim"] = "Drying",
			["TooltipUse"] = "Dry yourself",
			["Createur"] = "Isshrinä",
			["OnUseEndFailEffet"] = "aura$AUR00905$0$2$1;aura$AUR00014$300$1$1;parole$|| The X-54 gnome hairdryer overheat and taints {me} with dusts and ashes !$2;son$Sound\\\\Spells\\\\WandFireCast1.wav$2$10;aura$AUR01110$1200$1$1;",
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
			["OnUseStartFailEffet"] = "texte${me} is not soaked.$1;",
			["Nom"] = "The Ultimate X-54 Gnome Hairdryer",
			["OnUseStartCondi"] = "aurat(AUR00905)$>=$0;",
			["Icone"] = "INV_Weapon_Rifle_36",
			["Anim"] = 63,
			["Date"] = "28/04/11, 21:57:39 by Isshrinä",
			["OnUseEndEffet"] = "aura$AUR00905$0$2$1;parole$is now dry !$2;son$Sound\\\\Spells\\\\WaterSteam_Impact2.wav$2$10",
			["Categorie"] = "Util",
			["Outils"] = " 1  1  1  1  1",
			["DureeAnim"] = 5,
			["OnUseEndCondi"] = "rand$>$2;",
			["OnUseStartEffet"] = "son$Sound\\\\Spells\\\\WaterSteam_Impact1.wav$2$10;parole$uses the gnome dryer to dry {prod}self.$2;",
		},
		
		------------------------------------------------------------
		-- Range 00101 à 00200 : Nourriture
		------------------------------------------------------------
		
		
		
		
		------------------------------------------------------------
		-- Range 00201 à 00300 : Richesses
		------------------------------------------------------------
		["ITE00201"] = { -- Bourse (Bronze)
			["bUtilisable"] = true,
			["Charges"] = 1,
			["Description"] = "A pouch containing 10 bronze coins.",
			["Nom"] = "Bronze coins pouch",
			["OnUseEndEffet"] = "or$10$1;",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Wealth",
			["Icone"] = "INV_Misc_Bag_10_Black",
			["MaxStack"] = 10,
			["TooltipUse"] = "Retrieve the money",
			["Qualite"] = 2,
		},
		["ITE00202"] = { -- Bourse (Argent)
			["Charges"] = 1,
			["Description"] = "A pouch containing 10 silver coins.",
			["bUtilisable"] = true,
			["Nom"] = "Silver coins pouch",
			["OnUseEndEffet"] = "or$1000$1;",
			["TooltipUse"] = "Retrieve the money",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Wealth",
			["Icone"] = "INV_Misc_Bag_10_Blue",
			["MaxStack"] = 10,
			["Qualite"] = 3,
		},
		["ITE00203"] = { -- Bourse (Or)
			["bUtilisable"] = true,
			["Charges"] = 1,
			["Description"] = "A pouch containing 10 gold coins..",
			["Nom"] = "Gold coins pouch",
			["OnUseEndEffet"] = "or$100000$1;",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Wealth",
			["Icone"] = "INV_Misc_Bag_10",
			["MaxStack"] = 10,
			["TooltipUse"] = "Retrieve the money",
			["Qualite"] = 4,
		},
		
		------------------------------------------------------------
		-- Range 00301 à 00400 : Medecine
		------------------------------------------------------------
		["ITE00301"] = { -- Onguent
			["Poids"] = 100,
			["Description"] = "A ointment used to heal fresh bruns.",
			["Outils"] = " 1  1  1  1  1",
			["OnUseEndEffet"] = "aura$AUR00011$0$2$1;",
			["Createur"] = "Telkostrasz",
			["Icone"] = "INV_Potion_01",
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 3,
			["Charges"] = 1,
			["Valeur"] = 500,
			["Nom"] = "Ointment",
			["TooltipUse"] = "Apply ointment",
			["Anim"] = 63,
			["bUtilisable"] = true,
			["Categorie"] = "Medecine",
			["DureeAnim"] = 4,
			["MaxStack"] = 5,
			["bImmobile"] = true,
			["OnUseStartEffet"] = "parole$applies an ointment.$2;son$Sound\\\\Item\\\\UseSounds\\\\UseBandage.wav$2$14;",
		},

		------------------------------------------------------------
		-- Range 00401 à 01000 : Objets de Quêtes
		------------------------------------------------------------
		-- Quête : Traitresse ! Horde --
		["ITE00401"] = { -- Lettre de Sana 
			["OnUseEndEffet"] = "docu$DOC00101;son$Sound\\\\Interface\\\\PickUp\\\\PickUpParchment_Paper.wav$1$0;",
			["Poids"] = 100,
			["Description"] = "A scented letter.",
			["bUtilisable"] = true,
			["bQuest"] = true,
			["TooltipUse"] = "Read the letter",
			["Nom"] = "Letter from Sana",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Letter",
			["Icone"] = "INV_Letter_15",
			["Outils"] = " 1  1  1  1  1",
			["Unique"] = 1,
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
		},
		-- Quête : Traitresse ! Alliance --
		["ITE00402"] = { -- Lettre d'Elly 
			["OnUseEndEffet"] = "docu$DOC00102;son$Sound\\\\Interface\\\\PickUp\\\\PickUpParchment_Paper.wav$1$0;",
			["Poids"] = 100,
			["Description"] = "A scented letter.",
			["bUtilisable"] = true,
			["bQuest"] = true,
			["TooltipUse"] = "Read the letter",
			["Nom"] = "Letter from Elly",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Letter",
			["Icone"] = "INV_Letter_15",
			["Outils"] = " 1  1  1  1  1",
			["Unique"] = 1,
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
		},
	};
end

function TRP2_LoadDBItems_3()
	TRP2_DB_Objects = {
		["ITE00001"] = {
			["Nom"] = "Objeto";
			["Description"] = "Un objeto en blanco, sin datos.",
		},
		------------------------------------------------------------
		-- Range 00001 à 00010 : Tests
		------------------------------------------------------------

		------------------------------------------------------------
		-- Range 00011 à 00100 : Bordel
		------------------------------------------------------------
		
		["ITE00011"] = {
			["Poids"] = 200,
			["Description"] = "Un secador de pelo de diseño complejo, con un gran botón rojo.\n\nNota:   las industrias gnómicas no se hacen responsables de su mal funconamiento.",
			["bUtilisable"] = true,
			["TexteAnim"] = "Secando",
			["TooltipUse"] = "Sécate tú mismo",
			["Createur"] = "Isshrinä",
			["OnUseEndFailEffet"] = "aura$AUR00905$0$2$1;aura$AUR00014$300$1$1;parole$|| ¡El secador gnómico X-54 se sobrecalienta y escupe a {me} polvo y cenizas!$2;son$Sound\\\\Spells\\\\WandFireCast1.wav$2$10;aura$AUR01110$1200$1$1;",
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
			["OnUseStartFailEffet"] = "texte${me} no está mojado.$1;",
			["Nom"] = "Nuevo Secador Gnómico X-54",
			["OnUseStartCondi"] = "aurat(AUR00905)$>=$0;",
			["Icone"] = "INV_Weapon_Rifle_36",
			["Anim"] = 63,
			["Date"] = "28/04/11, 21:57:39 by Isshrinä",
			["OnUseEndEffet"] = "aura$AUR00905$0$2$1;parole$ahora está seco!$2;son$Sound\\\\Spells\\\\WaterSteam_Impact2.wav$2$10",
			["Categorie"] = "Herramienta",
			["Outils"] = " 1  1  1  1  1",
			["DureeAnim"] = 5,
			["OnUseEndCondi"] = "rand$>$2;",
			["OnUseStartEffet"] = "son$Sound\\\\Spells\\\\WaterSteam_Impact1.wav$2$10;parole$usa el secador gnómico para secarse.$2;",
		},
		
		------------------------------------------------------------
		-- Range 00101 à 00200 : Nourriture
		------------------------------------------------------------
		
		
		
		
		------------------------------------------------------------
		-- Range 00201 à 00300 : Richesses
		------------------------------------------------------------
		["ITE00201"] = { -- Bourse (Bronze)
			["bUtilisable"] = true,
			["Charges"] = 1,
			["Description"] = "Una bolsa con 10 monedas de bronce.",
			["Nom"] = "Bolsa de monedas de bronce",
			["OnUseEndEffet"] = "or$10$1;",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Dinero",
			["Icone"] = "INV_Misc_Bag_10_Black",
			["MaxStack"] = 10,
			["TooltipUse"] = "Vacía la bolsa.",
			["Qualite"] = 2,
		},
		["ITE00202"] = { -- Bourse (Argent)
			["Charges"] = 1,
			["Description"] = "Una bolsa con 10 monedas de plata.",
			["bUtilisable"] = true,
			["Nom"] = "Bolsa de monedas de plata",
			["OnUseEndEffet"] = "or$1000$1;",
			["TooltipUse"] = "Vacía la bolsa.",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Dinero",
			["Icone"] = "INV_Misc_Bag_10_Blue",
			["MaxStack"] = 10,
			["Qualite"] = 3,
		},
		["ITE00203"] = { -- Bourse (Or)
			["bUtilisable"] = true,
			["Charges"] = 1,
			["Description"] = "Una bolsa con 10 monedas de oro.",
			["Nom"] = "Bolsa de monedas de oro",
			["OnUseEndEffet"] = "or$100000$1;",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Dinero",
			["Icone"] = "INV_Misc_Bag_10",
			["MaxStack"] = 10,
			["TooltipUse"] = "Vacía la bolsa.",
			["Qualite"] = 4,
		},
		
		------------------------------------------------------------
		-- Range 00301 à 00400 : Medecine
		------------------------------------------------------------
		["ITE00301"] = { -- Onguent
			["Poids"] = 100,
			["Description"] = "Un ungüento para el tratamiento de quemaduras recientes.",
			["Outils"] = " 1  1  1  1  1",
			["OnUseEndEffet"] = "aura$AUR00011$0$2$1;",
			["Createur"] = "Telkostrasz",
			["Icone"] = "INV_Potion_01",
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 3,
			["Charges"] = 1,
			["Valeur"] = 500,
			["Nom"] = "Ungüento",
			["TooltipUse"] = "Aplica un ungüento.",
			["Anim"] = 63,
			["bUtilisable"] = true,
			["Categorie"] = "Medicina",
			["DureeAnim"] = 4,
			["MaxStack"] = 5,
			["bImmobile"] = true,
			["OnUseStartEffet"] = "parole$aplica un ungüento.$2;son$Sound\\\\Item\\\\UseSounds\\\\UseBandage.wav$2$14;",
		},

		------------------------------------------------------------
		-- Range 00401 à 01000 : Objets de Quêtes
		------------------------------------------------------------
		-- Quête : Traitresse ! Horde --
		["ITE00401"] = { -- Lettre de Sana 
			["OnUseEndEffet"] = "docu$DOC00101;son$Sound\\\\Interface\\\\PickUp\\\\PickUpParchment_Paper.wav$1$0;",
			["Poids"] = 100,
			["Description"] = "Una carta perfumada.",
			["bUtilisable"] = true,
			["bQuest"] = true,
			["TooltipUse"] = "Lee la carta",
			["Nom"] = "Carta de Mojka",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Carta",
			["Icone"] = "INV_Letter_15",
			["Outils"] = " 1  1  1  1  1",
			["Unique"] = 1,
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
		},
		-- Quête : Traitresse ! Alliance --
		["ITE00402"] = { -- Lettre d'Elly 
			["OnUseEndEffet"] = "docu$DOC00102;son$Sound\\\\Interface\\\\PickUp\\\\PickUpParchment_Paper.wav$1$0;",
			["Poids"] = 100,
			["Description"] = "Una carta perfumada.",
			["bUtilisable"] = true,
			["bQuest"] = true,
			["TooltipUse"] = "Lee la carta.",
			["Nom"] = "Carta de Elly",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Carta",
			["Icone"] = "INV_Letter_15",
			["Outils"] = " 1  1  1  1  1",
			["Unique"] = 1,
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
		},
	};
end

function TRP2_LoadDBItems_4()
	TRP2_DB_Objects = {
		["ITE00001"] = {
			["Nom"] = "Item";
			["Description"] = "Ein leeres Item, ohne Inhalt.",
		},
		------------------------------------------------------------
		-- Range 00001 à 00010 : Tests
		------------------------------------------------------------

		------------------------------------------------------------
		-- Range 00011 à 00100 : Bordel
		------------------------------------------------------------
		
		------------------------------------------------------------
		-- Range 00101 à 00200 : Nourriture
		------------------------------------------------------------
		
		["ITE00011"] = {
			["Poids"] = 200,
			["Description"] = "Ein ziemlich kompliziert wirkender Haartrockner mit einem großen roten Knopf drauf.\n\nP.S.   Gnomes Industries sind für eventuelle Fehlfunktionen nicht verantwortlich zu machen.",
			["bUtilisable"] = true,
			["TexteAnim"] = "Trocknen",
			["TooltipUse"] = "Trockne dich ab",
			["Createur"] = "Isshrinä",
			["OnUseEndFailEffet"] = "aura$AUR00905$0$2$1;aura$AUR00014$300$1$1;parole$|| The X-54 Gnomen Haartrockner überhitzt worauf dieser {me} mit Staub und Asche übersät!$2;son$Sound\\\\Spells\\\\WandFireCast1.wav$2$10;aura$AUR01110$1200$1$1;",
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
			["OnUseStartFailEffet"] = "texte${me} ist nicht durchnässt.$1;",
			["Nom"] = "The Ultimate X-54 Gnomen Haartrockner",
			["OnUseStartCondi"] = "aurat(AUR00905)$>=$0;",
			["Icone"] = "INV_Weapon_Rifle_36",
			["Anim"] = 63,
			["Date"] = "28/04/11, 21:57:39 by Isshrinä",
			["OnUseEndEffet"] = "aura$AUR00905$0$2$1;parole$trocknet nun !$2;son$Sound\\\\Spells\\\\WaterSteam_Impact2.wav$2$10",
			["Categorie"] = "Werkzeug",
			["Outils"] = " 1  1  1  1  1",
			["DureeAnim"] = 5,
			["OnUseEndCondi"] = "rand$>$2;",
			["OnUseStartEffet"] = "son$Sound\\\\Spells\\\\WaterSteam_Impact1.wav$2$10;parole$verwendet den Gnomen Haartrockner um sich selbst zu trocknen.$2;",
		},
		
		------------------------------------------------------------
		-- Range 00201 à 00300 : Richesses
		------------------------------------------------------------
		["ITE00201"] = { -- Bourse (Bronze)
			["bUtilisable"] = true,
			["Charges"] = 1,
			["Description"] = "Ein Geldbeutel mit 10 Kupfermünzen.",
			["Nom"] = "Geldbeutel (Kupfer)",
			["OnUseEndEffet"] = "or$10$1;",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Wertsachen",
			["Icone"] = "INV_Misc_Bag_10_Black",
			["MaxStack"] = 10,
			["TooltipUse"] = "10 Kupfermünzen erhalten.",
			["Qualite"] = 2,
		},
		["ITE00202"] = { -- Bourse (Argent)
			["Charges"] = 1,
			["Description"] = "Ein Geldbeutel mit 10 Silbermünzen.",
			["bUtilisable"] = true,
			["Nom"] = "Geldbeutel (Silber)",
			["OnUseEndEffet"] = "or$1000$1;",
			["TooltipUse"] = "10 Silbermünzen erhalten.",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Wertsachen",
			["Icone"] = "INV_Misc_Bag_10_Blue",
			["MaxStack"] = 10,
			["Qualite"] = 3,
		},
		["ITE00203"] = { -- Bourse (Or)
			["bUtilisable"] = true,
			["Charges"] = 1,
			["Description"] = "Ein Geldbeutel mit 10 Goldmünzen.",
			["Nom"] = "Geldbeutel (Gold)",
			["OnUseEndEffet"] = "or$100000$1;",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Wertsachen",
			["Icone"] = "INV_Misc_Bag_10",
			["MaxStack"] = 10,
			["TooltipUse"] = "10 Goldmünzen erhalten.",
			["Qualite"] = 4,
		},
		
		------------------------------------------------------------
		-- Range 00301 à 00400 : Medecine
		------------------------------------------------------------
		["ITE00301"] = { -- Onguent
			["Poids"] = 100,
			["Description"] = "Eine Salbe zum heilen von frischen Wunden.",
			["Outils"] = " 1  1  1  1  1",
			["OnUseEndEffet"] = "aura$AUR00011$0$2$1;",
			["Createur"] = "Telkostrasz",
			["Icone"] = "INV_Potion_01",
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 3,
			["Charges"] = 1,
			["Valeur"] = 500,
			["Nom"] = "Salbe",
			["TooltipUse"] = "Salbe auftragen",
			["Anim"] = 63,
			["bUtilisable"] = true,
			["Categorie"] = "Medezin",
			["DureeAnim"] = 4,
			["MaxStack"] = 5,
			["bImmobile"] = true,
			["OnUseStartEffet"] = "parole$applies an ointment.$2;son$Sound\\\\Item\\\\UseSounds\\\\UseBandage.wav$2$14;",
		},

		------------------------------------------------------------
		-- Range 00401 à 01000 : Objets de Quêtes
		------------------------------------------------------------
		-- Quête : Traitresse ! Horde --
		["ITE00401"] = { -- Lettre de Sana 
			["OnUseEndEffet"] = "docu$DOC00101;son$Sound\\\\Interface\\\\PickUp\\\\PickUpParchment_Paper.wav$1$0;",
			["Poids"] = 100,
			["Description"] = "Ein duftender Brief.",
			["bUtilisable"] = true,
			["bQuest"] = true,
			["TooltipUse"] = "Brief lesen",
			["Nom"] = "Brief von Sana",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Brief",
			["Icone"] = "INV_Letter_15",
			["Outils"] = " 1  1  1  1  1",
			["Unique"] = 1,
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
		},
		-- Quête : Traitresse ! Alliance --
		["ITE00402"] = { -- Lettre d'Elly 
			["OnUseEndEffet"] = "docu$DOC00102;son$Sound\\\\Interface\\\\PickUp\\\\PickUpParchment_Paper.wav$1$0;",
			["Poids"] = 100,
			["Description"] = "Ein duftender Brief.",
			["bUtilisable"] = true,
			["bQuest"] = true,
			["TooltipUse"] = "Brief lesen",
			["Nom"] = "Brief von Elly",
			["Createur"] = "Telkostrasz",
			["Categorie"] = "Brief",
			["Icone"] = "INV_Letter_15",
			["Outils"] = " 1  1  1  1  1",
			["Unique"] = 1,
			["Composants"] = " 1  1  1  1  1  1  1  1  1  1 ",
			["Qualite"] = 2,
		},
	};
end