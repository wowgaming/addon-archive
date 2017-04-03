-- Please see enus.lua for reference.

QuestHelper_Translations.frFR =
 {
  -- Displayed by locale chooser.
  LOCALE_NAME = "Français",
  
  -- Messages used when starting.
  LOCALE_ERROR = "La langue de vos données sauvegardées ne correspond pas à la langue de votre client WoW. Pour utiliser QuestHelper, vous devez soit remettre la langue que vous aviez avant, soit supprimer les données en tapant %h(/qh purge).",
  ZONE_LAYOUT_ERROR = "Votre version de QuestHelper n'est plus à jour, vous êtes prié de vous connecter sur http://www.questhelp.us pour poursuivre son utilisation. Votre version actuelle est %1.",
  HOME_NOT_KNOWN = "Vous n'avez pas de foyer défini. Lorsque cela sera possible, veuillez parler à votre aubergiste et réinitialisez-le.",
  PRIVATE_SERVER = "QuestHelper ne supporte pas les serveurs privés.",
  PLEASE_RESTART = "Une erreur est survenue au lancement de QuestHelper. Veuillez quitter World of Warcraft et essayer à nouveau.",
  NOT_UNZIPPED_CORRECTLY = "QuestHelper n'a pas été installé correctement. Nous vous recommandons d'utiliser soit le client Curse soit 7zip pour l'installation. Assurez-vous que les sous-dossiers soient extraits.",
  PLEASE_SUBMIT = "%h(QuestHelper a besoin de votre aide !) Si vous avez quelques minutes, s'il vous plaît, allez sur la page d'accueil de QuestHelper à %h(http://www.questhelp.us) et suivez les instructions pour soumettre vos données collectées. Vos informations maintiennent à jour l'exactitude de QuestHelper. Merci !",
  HOW_TO_CONFIGURE = "QuestHelper n'a pas encore une page de configuration fonctionnelle, mais peut être configuré en tapant %h(/qh settings). L'aide est disponible en utilisant %h(/qh help).",
  TIME_TO_UPDATE = "Il semble qu'une %h(nouvelle version de QuestHelper) soit disponible. Les nouvelles versions incluent généralement de nouvelles fonctionalités, de nouvelles bases de données de quêtes et des corrections de bogues. Merci de mettre à jour !",
  
  -- Route related text.
  ROUTES_CHANGED = "Les itinéraires de vol de votre personnage ont été modifiés.",
  HOME_CHANGED = "Votre foyer a été changé.",
  TALK_TO_FLIGHT_MASTER = "Parler au maître d'envol local.",
  TALK_TO_FLIGHT_MASTER_COMPLETE = "Merci.",
  WILL_RESET_PATH = "Réinitialisation des informations de route.",
  UPDATING_ROUTE = "Trajet actualisée.",
  
  -- Special tracker text
  QH_LOADING = "Chargement de QuestHelper (%1%)...",
  QH_FLIGHTPATH = "Recalcul des points de vols (%1%)...",
  QH_RECALCULATING = "Nouveau calcul de l'itinéraire (%1%)...",
  QUESTS_HIDDEN_1 = "Les quêtes peuvent êtres cachées",
  QUESTS_HIDDEN_2 = "(\"/qh hidden\" pour lister)",
  
  -- Locale switcher.
  LOCALE_LIST_BEGIN = "Langues disponibles :",
  LOCALE_CHANGED = "Langue changée en: %h1",
  LOCALE_UNKNOWN = "La langue %h1 est inconnue.",
  
  -- Words used for objectives.
  SLAY_VERB = "Tuer",
  ACQUIRE_VERB = "Obtenir",
  
  OBJECTIVE_REASON = "%1 %h2 pour la quête %h3.", -- %1 is a verb, %2 is a noun (item or monster)
  OBJECTIVE_REASON_FALLBACK = "%h1 pour la quête %h2.",
  OBJECTIVE_REASON_TURNIN = "Valider la quête %h1.",
  OBJECTIVE_PURCHASE = "A acheter auprès de %h1.",
  OBJECTIVE_TALK = "Parler à %h1.",
  OBJECTIVE_SLAY = "Tuer %h1.",
  OBJECTIVE_LOOT = "Ramasser en butin sur %h1.",
  OBJECTIVE_OPEN = "Expose %h1.",
  
  OBJECTIVE_MONSTER_UNKNOWN = "monstre inconnu",
  OBJECTIVE_ITEM_UNKNOWN = "objet inconnu",
  
  ZONE_BORDER_SIMPLE = "%1 bordure",
  
  -- Stuff used in objective menus.
  PRIORITY = "Priorité",
  PRIORITY1 = "La plus haute",
  PRIORITY2 = "Haute",
  PRIORITY3 = "Normale",
  PRIORITY4 = "Basse",
  PRIORITY5 = "La plus basse",
  SHARING = "Partage",
  SHARING_ENABLE = "Partager",
  SHARING_DISABLE = "Ne pas partager",
  IGNORE = "Ignore",
  IGNORE_LOCATION = "Ignorer cet endroit",
  
  IGNORED_PRIORITY_TITLE = "La priorité sélectionnée sera ignorée.",
  IGNORED_PRIORITY_FIX = "Appliquer la même priorité aux objectifs bloquants.",
  IGNORED_PRIORITY_IGNORE = "Je réglerai les priorités moi-même.",
  
  -- "/qh find"
  RESULTS_TITLE = "Résultats de la recherche",
  NO_RESULTS = "Il n'y en a aucun !",
  CREATED_OBJ = "Créé : %1",
  REMOVED_OBJ = "Supprimé : %1",
  USER_OBJ = "Objectif utilisateur : %h1",
  UNKNOWN_OBJ = "Destination inconnue pour cet objectif.",
  INACCESSIBLE_OBJ = "QuestHelper n'a pas été capable de trouver une destination utile pour %h1. Nous avons ajouté une destination impossible à rejoindre dans la liste des objectifs. Si vous trouvez une version utile de cet objet, merci de soumettre vos données ! (%h(/qh submit))",
  FIND_REMOVE = "Annuler objectif",
  FIND_NOT_READY = "QuestHelper n'a pas encore terminé de charger. Veuillez patienter avant de réessayer.",
  FIND_CUSTOM_LOCATION = "Localisation personnalisée",
  FIND_USAGE = "La recherche ne fonctionne pas si vous ne dites pas quoi chercher. Essayez %h(/qh help) pour les instructions.",
  
  -- Shared objectives.
  PEER_TURNIN = "Attendre %h1 pour valider %h2.",
  PEER_LOCATION = "Aider %h1 à rallier la position %h2.",
  PEER_ITEM = "Aider %1 à obtenir %h2.",
  PEER_OTHER = "Aider %1 à faire %h2.",
  
  PEER_NEWER = "%h1 utilise une nouvelle version. Vous devriez faire une mise à jour.",
  PEER_OLDER = "%h1 utilise une ancienne version.",
  
  UNKNOWN_MESSAGE = "Type de message inconnu '%1' de '%2'.",
  
  -- Hidden objectives.
  HIDDEN_TITLE = "Objectifs cachés",
  HIDDEN_NONE = "Il n'y a pas d'objectifs cachés",
  DEPENDS_ON_SINGLE = "Dépend de '%1'",
  DEPENDS_ON_COUNT = "Dépend de %1 objectifs cachés",
  DEPENDS_ON = "Dépend des objectifs filtrés",
  FILTERED_LEVEL = "Filtré à cause du niveau",
  FILTERED_GROUP = "Filtré à cause de la taille du groupe",
  FILTERED_ZONE = "Filtré à cause de la zone",
  FILTERED_COMPLETE = "Filtré car terminé",
  FILTERED_BLOCKED = "Filtré car dépend d'un objectif qui n'a pas été réalisé",
  FILTERED_UNWATCHED = "Filtré car l'objectif n'est pas suivi dans le journal de quêtes",
  FILTERED_WINTERGRASP = "Filtré car vous êtes dans une quête JcJ du Joug d'Hiver",
  FILTERED_RAID = "Filtré car impossible en raid",
  FILTERED_USER = "Vous avez demandé à cacher cet objectif",
  FILTERED_UNKNOWN = "Ne sait pas comment le terminer",
  
  HIDDEN_SHOW = "Montrer",
  HIDDEN_SHOW_NO = "Non visible",
  HIDDEN_EXCEPTION = "Ajout d'exception",
  DISABLE_FILTER = "Désactiver le filtre : %1",
  FILTER_DONE = "terminé",
  FILTER_ZONE = "zone",
  FILTER_LEVEL = "niveau",
  FILTER_BLOCKED = "bloqué",
  FILTER_WATCHED = "regardé",
  
  -- Achievements. Or, as they are known in the biz, "cheeves".
  -- God I hate the biz.
  ACHIEVEMENT_CHECKBOX = "Cocher pour ajouter cet exploit à QuestHelper",
  
  -- Nagging. (This is incomplete, only translating strings for the non-verbose version of the nag command that appears at startup.)
  NAG_MULTIPLE_NEW = "Vous avez %h(des nouvelles informations) pour %h1 et %h(des mises à jour) pour %h2.",
  NAG_SINGLE_NEW = "Vous avez %h(une nouvelle information) sur %h1.",
  NAG_ADDITIONAL = "Vous avez %h(des informations complémentaires) pour %h1.",
  NAG_POLLUTED = "La base de données a été infectée par des données provenant d'un serveur privé ou de test, et sera remis à zéro lors du redémarrage.",
  
  NAG_NOT_NEW = "Vous n'avez aucune information qui n'est pas déjà dans la base de données statique.",
  NAG_NEW = "Vous devriez penser à partager vos données pour le bénéfice des autres joueurs.",
  NAG_INSTRUCTIONS = "Tapez %h(/qh submit) pour savoir comment soumettre des informations.",
  
  NAG_SINGLE_FP = "un maître d'envol",
  NAG_SINGLE_QUEST = "une quête",
  NAG_SINGLE_ROUTE = "un chemin de vol",
  NAG_SINGLE_ITEM_OBJ = "un objectif d'article",
  NAG_SINGLE_OBJECT_OBJ = "un objectif d'objet",
  NAG_SINGLE_MONSTER_OBJ = "un objectif de monstre",
  NAG_SINGLE_EVENT_OBJ = "un objectif d'évènement",
  NAG_SINGLE_REPUTATION_OBJ = "un objectif de réputation",
  NAG_SINGLE_PLAYER_OBJ = "un objectif de joueur",
  
  NAG_MULTIPLE_FP = "%1 maîtres d'envol",
  NAG_MULTIPLE_QUEST = "%1 quêtes",
  NAG_MULTIPLE_ROUTE = "%1 chemins de vol",
  NAG_MULTIPLE_ITEM_OBJ = "%1 objectifs d'objet",
  NAG_MULTIPLE_OBJECT_OBJ = "%1 objectifs d'article",
  NAG_MULTIPLE_MONSTER_OBJ = "%1 objectifs de monstre",
  NAG_MULTIPLE_EVENT_OBJ = "%1 objectifs d'évènement",
  NAG_MULTIPLE_REPUTATION_OBJ = "%1 objectifs de réputation",
  NAG_MULTIPLE_PLAYER_OBJ = "%1 objectifs de joueur",
  
  -- Stuff used by dodads.
  PEER_PROGRESS = "Progression pour %1 :",
  TRAVEL_ESTIMATE = "Temps de voyage estimé :",
  TRAVEL_ESTIMATE_VALUE = "%t1",
  WAYPOINT_REASON = "Aller à %h1 pour :",
  FLIGHT_POINT = "le point d'envol à %1",

  -- QuestHelper Map Button
  QH_BUTTON_TEXT = "QuestHelper",
  QH_BUTTON_TOOLTIP1 = "Clic-Gauche : %1 information de route.",
  QH_BUTTON_TOOLTIP2 = "Clic-Droit : afficher le menu des options.",
  QH_BUTTON_SHOW = "Afficher",
  QH_BUTTON_HIDE = "Cacher",

  MENU_CLOSE = "Fermer le menu",
  MENU_SETTINGS = "Options",
  MENU_ENABLE = "Activer",
  MENU_DISABLE = "Désactiver",
  MENU_OBJECTIVE_TIPS = "%1 les bulles d'aide pour les objectifs",
  MENU_TRACKER_OPTIONS = "Liste de quêtes",
  MENU_QUEST_TRACKER = "%1 la liste de quêtes",
  MENU_TRACKER_LEVEL = "%1 l'affichage des niveaux de quête",
  MENU_TRACKER_QCOLOUR = "%1 la colorisation des quêtes selon la difficulté",
  MENU_TRACKER_OCOLOUR = "%1 la colorisation des objectifs",
  MENU_TRACKER_SCALE = "Échelle de la liste de quêtes",
  MENU_TRACKER_RESET = "Réinitialiser la position de la liste de quêtes",
  MENU_FLIGHT_TIMER = "%1 le temps de vol",
  MENU_ANT_TRAILS = "%1 les chemins pointillés",
  MENU_WAYPOINT_ARROW = "%1 le compas",
  MENU_MAP_BUTTON = "%1 le bouton sur la carte",
  MENU_ZONE_FILTER = "%1 le filtre de zone",
  MENU_DONE_FILTER = "%1 filtré",
  MENU_BLOCKED_FILTER = "%1 filtre bloqué",
  MENU_WATCHED_FILTER = "%1 le filtrage des quêtes suivies",
  MENU_LEVEL_FILTER = "%1 le filtrage par niveau",
  MENU_LEVEL_OFFSET = "Limite pour le filtre de niveau",
  MENU_ICON_SCALE = "Échelle des icônes",
  MENU_FILTERS = "Filtres",
  MENU_PERFORMANCE = "Charge attribuée au calcul des routes",
  MENU_LOCALE = "Langue",
  MENU_PARTY = "Groupe",
  MENU_PARTY_SHARE = "%1 le partage d'objectif",
  MENU_PARTY_SOLO = "%1 le prise en compte du groupe",
  MENU_HELP = "Aide",
  MENU_HELP_SLASH = "Commandes /",
  MENU_HELP_CHANGES = "Historique des modifications",
  MENU_HELP_SUBMIT = "Envoi de données",
  
  -- Added to tooltips of items/npcs that are watched by QuestHelper but don't have any progress information.
  -- Otherwise, the PEER_PROGRESS text is added to the tooltip instead.
  TOOLTIP_WATCHED = "Suivi par QuestHelper",
  TOOLTIP_QUEST = "Pour la quête %h1.",
  TOOLTIP_PURCHASE = "Acheter %h1.",
  TOOLTIP_SLAY = "À tuer pour %h1.",
  TOOLTIP_LOOT = "Ramasser pour le butin %h1.",
  TOOLTIP_OPEN = "Expose pour %h1.",
  
  -- Settings
  SETTINGS_ARROWLINK_ON = "Utilisera %h1 pour afficher les objectifs.",
  SETTINGS_ARROWLINK_OFF = "N'utilise pas %h1 pour afficher les objectifs.",
  SETTINGS_ARROWLINK_ARROW = "Indicateur QuestHelper",
  SETTINGS_ARROWLINK_CART = "Etapes Cartographer",
  SETTINGS_ARROWLINK_TOMTOM = "TomTom",
  SETTINGS_PRECACHE_ON = "Le pré-chache a été %h(activé).",
  SETTINGS_PRECACHE_OFF = "Le pré-cache a été %h(désactivé).",
  
  SETTINGS_MENU_ENABLE = "Activer",
  SETTINGS_MENU_DISABLE = "Désactiver",
  SETTINGS_MENU_CARTWP = "%1 flèche de Cartographer",
  SETTINGS_MENU_TOMTOM = "%1 flèche TomTom",
  
  SETTINGS_MENU_ARROW_LOCK = "Verrouiller",
  SETTINGS_MENU_ARROW_ARROWSCALE = "Taille de la Flèche",
  SETTINGS_MENU_ARROW_TEXTSCALE = "Taille du texte",
  SETTINGS_MENU_ARROW_RESET = "Remise à zéro",
  
  SETTINGS_MENU_INCOMPLETE = "Quêtes imcompletes",
  
  SETTINGS_RADAR_ON = "Radar de Minimap désenclenché! (beep, beep, beep)",
  SETTINGS_RADAR_OFF = "Radar de Minimap enclenché. (whirrrrr, clunk) ",
  
  -- I'm just tossing miscellaneous stuff down here
  DISTANCE_YARDS = "%h1 yards",
  DISTANCE_METRES = "%h1 mètres"
 }

