--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-frFR.lua - Localized string constants (fr-FR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "frFR" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/frFR/
local _NPCScan = select( 2, ... );
_NPCScan.L = setmetatable( {
	NPCs = setmetatable( {
		[ 18684 ] = "Bro'Gaz Sans-clan",
		[ 32491 ] = "Proto-drake perdu dans le temps",
		[ 33776 ] = "Gondria",
		[ 35189 ] = "Skoll",
		[ 38453 ] = "Arcturis",
	}, { __index = _NPCScan.L.NPCs; } );

	BUTTON_FOUND = "PNJ trouvé !",
	CACHED_FORMAT = "Le(s) unité(s) suivante(s) sont déjà dans le cache : %s.",
	CACHED_LONG_FORMAT = "Le(s) unité(s) suivante(s) sont déjà dans le cache. Pensez à les enlever en utilisant le menu |cff808080“/npcscan”|r ou réinitialiser-les en effacant votre cache : %s.",
	CACHED_WORLD_FORMAT = "Le(s) unité(s) suivante(s) |2 %2$s sont déjà dans le cache : %1$s.",
	CACHELIST_ENTRY_FORMAT = "|cff808080“%s”|r",
	CACHELIST_SEPARATOR = ", ",
	CMD_ADD = "ADD",
	CMD_CACHE = "CACHE",
	CMD_CACHE_EMPTY = "Aucune des monstres recherchés n'est dans le cache.",
	CMD_HELP = "Les commandes sont |cff808080“/npcscan add <ID-PNJ> <Nom>”|r, |cff808080“/npcscan remove <ID-PNJ ou Nom>”|r, |cff808080“/npcscan cache”|r pour afficher la liste des monstres en cache, et simplement |cff808080“/npcscan”|r pour le menu des options.",
	CMD_REMOVE = "REMOVE",
	CMD_REMOVENOTFOUND_FORMAT = "PNJ |cff808080“%s”|r non trouvé.",
	CONFIG_ALERT = "Options de l'alerte",
	CONFIG_ALERT_SOUND = "Fichier son de l'alerte",
	CONFIG_ALERT_SOUND_DEFAULT = "|cffffd200Défaut|r",
	CONFIG_ALERT_SOUND_DESC = "Choisissez le son d'alerte à jouer quand un PNJ est trouvé. Des sons additionnels peuvent être ajoutés via l'addon |cff808080“SharedMedia”|r.",
	CONFIG_ALERT_UNMUTE = "Enlever la sourdine pour le son d'alerte",
	CONFIG_ALERT_UNMUTE_DESC = "Active brièvement les sons du jeu quand un PNJ est trouvé afin de jouer le son d'alerte dans le cas où vous auriez mis le jeu en sourdine.",
	CONFIG_CACHEWARNINGS = "Me rappeler de vider mon cache à la connexion",
	CONFIG_CACHEWARNINGS_DESC = "Si un PNJ est présent dans le cache quand vous vous connectez à ce personnage, cette option affichera un rappel des monstres en cache que l'addon ne pourra pas rechercher.",
	CONFIG_DESC = "Ces options vous permettent de définir comment _NPCScan vous prévient quand il trouve un PNJ rare.",
	CONFIG_TEST = "Test de l'alerte",
	CONFIG_TEST_DESC = "Simule une alerte |cff808080“PNJ trouvé”|r afin que vous puissez voir à quoi cela ressemble.",
	CONFIG_TEST_HELP_FORMAT = "Cliquez sur le cadre d'alerte ou utilisez le raccourci clavier prédéfini pour cibler le monstre trouvé. Maintenez enfoncé |cffffffff<%s>|r et saisissez le cadre d'alerte pour déplacer ce dernier. Notez que si un PNJ est trouvé quand vous êtes en combat, le cadre d'alerte n'apparaitra qu'une fois que vous serez hors combat.",
	CONFIG_TEST_NAME = "Vous ! (Test)",
	CONFIG_TITLE = "_|cffCCCC88NPCScan|r",
	FOUND_FORMAT = "|cff808080“%s”|r trouvé !",
	FOUND_TAMABLE_FORMAT = "|cff808080“%s”|r trouvé ! |cffff2020(Note : monstre domptable, il s'agit peut être d'un familier.)|r",
	FOUND_TAMABLE_WRONGZONE_FORMAT = "|cffff2020Fausse alerte :|r Monstre domptable |cff808080“%s”|r trouvé à %s au lieu |2 %s (ID %d) ; certainement un familier.",
	PRINT_FORMAT = "_|cffCCCC88NPCScan|r : %s",
	SEARCH_ACHIEVEMENTADDFOUND = "Rechercher les PNJs déjà réussis dans les hauts faits",
	SEARCH_ACHIEVEMENTADDFOUND_DESC = "Continue à rechercher tous les PNJs des hauts faits, même ceux dont vous n'avez plus besoin.",
	SEARCH_ACHIEVEMENT_DISABLED = "Désactivé",
	SEARCH_ADD = "+",
	SEARCH_ADD_DESC = "Ajoute un nouveau PNJ ou sauvegarde les changements appliqué à un pré-existant.",
	SEARCH_ADD_TAMABLE_FORMAT = "Note : |cff808080“%s”|r est domptable. S'il (ou elle) est vu(e) en tant que familier de chasseur, cela causera une fausse alerte.",
	SEARCH_CACHED = "En cache",
	SEARCH_COMPLETED = "Fait",
	SEARCH_DESC = "Cette table vous permet d'ajouter ou d'enlever des PNJs et de définir les hauts faits à surveiller.",
	SEARCH_ID = "ID du PNJ :",
	SEARCH_ID_DESC = "L'identifiant du PNJ à rechercher. Cette valeur peut être trouvée sur des sites comme WoWHead.com.",
	SEARCH_NAME = "Nom :",
	SEARCH_NAME_DESC = "Un libellé pour le PNJ. Il ne doit pas forcément correspondre au nom exact du PNJ.",
	SEARCH_NPCS = "PNJS perso.",
	SEARCH_NPCS_DESC = "Ajoute n'importe quel PNJ à la surveillance, même s'il n'est lié à aucun haut fait.",
	SEARCH_REMOVE = "-",
	SEARCH_TITLE = "Recherche",
	SEARCH_WORLD = "Monde :",
	SEARCH_WORLD_DESC = "Un nom de monde optionnel afin de limiter les recherches. Peut être un nom de continent ou |cffff7f3fun nom d'instance|r (sensible à la casse).",
	SEARCH_WORLD_FORMAT = "(%s)",
}, { __index = _NPCScan.L; } );


_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Cibler dernier monstre trouvé
|cff808080(Utile qd _NPCScan vous alerte)|r]=];