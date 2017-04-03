-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

if (GetLocale() == "frFR") then
	XPerl_LongDescription = "UnitFrame replacement for new look Joueur, Familier, Groupe, Cible, Cible de la cible, Raid"
	XPERL_MINIMAP_HELP1 = "|c00FFFFFFClique gauche pour options"
	XPERL_MINIMAP_HELP2 = "|c00FFFFFFClique droit pour bouger l'ic\195\180ne"
	XPERL_MINIMAP_HELP3 = "\rReal Raid Members: |c00FFFF80%d|r\rReal Party Members: |c00FFFF80%d|r"
	XPERL_MINIMAP_HELP4 = "\rYou are leader of the real party/raid"

	XPERL_TYPE_NOT_SPECIFIED = "Non indiqu\195\169"

	XPERL_TYPE_PET = "Familiers"

	XPERL_LOC_CLASS_WARRIORFEM = "Guerri\195\168re"
	XPERL_LOC_CLASS_ROGUEFEM = "Voleuse"
	XPERL_LOC_CLASS_DRUIDFEM = "Druidesse"
	XPERL_LOC_CLASS_HUNTERFEM = "Chasseresse"
	XPERL_LOC_CLASS_SHAMANFEM = "Chamane"
	XPERL_LOC_CLASS_PRIESTFEM = "Pr\195\170tresse"

	XPERL_LOC_ZONE_SERPENTSHRINE_CAVERN = "Caverne du sanctuaire du Serpent"
	XPERL_LOC_ZONE_BLACK_TEMPLE = "Temple noir"
	XPERL_LOC_ZONE_HYJAL_SUMMIT = "Sommet d'Hyjal"
	XPERL_LOC_ZONE_KARAZHAN = "Karazhan"
	XPERL_LOC_ZONE_SUNWELL_PLATEAU = "Plateau du Puits de soleil"
	XPERL_LOC_ZONE_ULDUAR = "Ulduar"
	XPERL_LOC_ZONE_TRIAL_OF_THE_CRUSADER = "L'épreuve du croisé"
	XPERL_LOC_ZONE_ICECROWN_CITADEL = "Citadelle de la Couronne de glace"
	XPERL_LOC_ZONE_RUBY_SANCTUM = "Le sanctum Rubis"

	XPERL_LOC_DEAD = "Mort"
	XPERL_LOC_GHOST = "Fant\195\180me"
	XPERL_LOC_FEIGNDEATH = "Feindre la Mort"
	XPERL_LOC_OFFLINE = "Hors-ligne"
	XPERL_LOC_RESURRECTED = "R\195\169ssusict\195\169"
	XPERL_LOC_SS_AVAILABLE = "SS Available"
	XPERL_LOC_UPDATING = "Mise \195\162 jour"
	XPERL_LOC_ACCEPTEDRES = "Accepter la r\195\169sur\195\169ction" -- Res accepted
	XPERL_RAID_GROUP = "Groupe %d"

	XPERL_LOC_STATUSTIP = "Statuts accentu\195\169s: " -- Tooltip explanation of status highlight on unit
	XPERL_LOC_STATUSTIPLIST = {
		HOT = "Soins sur la dur\195\169e",
		AGGRO = "Aggro",
		MISSING = "Manque votre buff de classe",
		HEAL = "Viens d'\195\170tre soign\195\169",
		SHIELD = "envellop\195\169 d'un bouclier"
	}

	XPERL_OK = "Ok"
	XPERL_CANCEL = "Annuler"

	XPERL_LOC_LARGENUMDIV = 1000
	XPERL_LOC_LARGENUMTAG = "K"

	BINDING_HEADER_XPERL = "X-Perl Key Bindings"
	BINDING_NAME_TOGGLERAID = "D\195\169scriptif de raid"
	BINDING_NAME_TOGGLERAIDSORT = "D\195\169scriptif de raid assorti par classe/groupe"
	BINDING_NAME_TOGGLEOPTIONS = "Bascule de la fen\195\170tre d'options"
	BINDING_NAME_TOGGLEBUFFTYPE = "Bascule aucun buffs/debuffs"
	BINDING_NAME_TOGGLEBUFFCASTABLE = "Bascule lanceable/soignable"
	BINDING_NAME_TEAMSPEAKMONITOR = "Moniteur Teamspeack"
	BINDING_NAME_TOGGLERANGEFINDER = "Bascule du t\195\169l\195\169m\195\169tre"

	XPERL_KEY_NOTICE_RAID_BUFFANY = "Montrer tout les buffs/debuffs"
	XPERL_KEY_NOTICE_RAID_BUFFCURECAST = "Ne montrer que les Buffs/Debuffs que l'on peux soigner"
	XPERL_KEY_NOTICE_RAID_BUFFS = "Montrer les buffs du raid"
	XPERL_KEY_NOTICE_RAID_DEBUFFS = "Montrer les debuffs du raid"
	XPERL_KEY_NOTICE_RAID_NOBUFFS = "Ne pas montrer les debuffs du raid"

	XPerl_DefaultRangeSpells.ANY = {item = "Bandage \195\169pais en \195\169toffe runique"}

	XPERL_RAID_TOOLTIP_WITHBUFF	      = "Avec buffs: (%s)"
	XPERL_RAID_TOOLTIP_WITHOUTBUFF	      = "Sans buffs: (%s)"
	XPERL_RAID_TOOLTIP_BUFFEXPIRING	      = "%s's %s expires dans %s"	-- Name, buff name, time to expire
end
