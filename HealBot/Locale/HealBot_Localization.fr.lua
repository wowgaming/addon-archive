-- French version (by Kubik of Vol'Jin) 2010-06-02 / V. 3.3.5.0
-- à = \195\160
-- â = \195\162
-- ç = \195\167
-- è = \195\168
-- é = \195\169
-- ê = \195\170
-- î = \195\174
-- ï = \195\175
-- ô = \195\180
-- û = \195\187
-- espace avant ':' (?) = \194\160

if (GetLocale() == "frFR") then

-------------------
-- Compatibility --
-------------------
HEALBOT_DRUID   = "Druide";
HEALBOT_HUNTER  = "Chasseur";
HEALBOT_MAGE    = "Mage";
HEALBOT_PALADIN = "Paladin";
HEALBOT_PRIEST  = "Pr\195\170tre";
HEALBOT_ROGUE   = "Voleur";
HEALBOT_SHAMAN  = "Chaman";
HEALBOT_WARLOCK = "D\195\169moniste";
HEALBOT_WARRIOR = "Guerrier";
HEALBOT_DEATHKNIGHT = "Chevalier de la mort";

HEALBOT_HEAVY_RUNECLOTH_BANDAGE  = GetItemInfo(14530) or "Bandage en \195\169toffe runique \195\169pais";
HEALBOT_MAJOR_HEALING_POTION     = GetItemInfo(13446) or "Potion de Soins majeure";
HEALBOT_PURIFICATION_POTION      = GetItemInfo(13462) or "Potion de purification";
HEALBOT_ANTI_VENOM               = GetItemInfo(6452) or "Anti-venin";
HEALBOT_POWERFUL_ANTI_VENOM      = GetItemInfo(19440) or "Anti-venin puissant";
HEALBOT_ELIXIR_OF_POISON_RES     = GetItemInfo(3386) or "Elixir de r\195\169sistance au poison";

HEALBOT_FLASH_HEAL          = GetSpellInfo(2061) or "Soins rapides";
HEALBOT_FLASH_OF_LIGHT      = GetSpellInfo(19750) or "Eclair lumineux";
HEALBOT_GREATER_HEAL        = GetSpellInfo(2060) or "Soins sup\195\169rieurs";
HEALBOT_BINDING_HEAL        = GetSpellInfo(32546) or "Soins de lien"
HEALBOT_PENANCE             = GetSpellInfo(47540) or "P\195\169nitance"
HEALBOT_PRAYER_OF_MENDING   = GetSpellInfo(33076) or "Pri\195\168re de gu\195\169rison";
HEALBOT_HEALING_TOUCH       = GetSpellInfo(5185) or "Toucher gu\195\169risseur";
HEALBOT_HEAL                = GetSpellInfo(2054) or "Soins";
HEALBOT_HEALING_WAVE        = GetSpellInfo(331) or "Vague de soins";
HEALBOT_RIPTIDE             = GetSpellInfo(61295) or "Remous";
HEALBOT_HEALING_WAY         = GetSpellInfo(29206) or "Flots de soins";
HEALBOT_HOLY_LIGHT          = GetSpellInfo(635) or "Lumi\195\168re sacr\195\169e";
HEALBOT_LESSER_HEAL         = GetSpellInfo(2050) or "Soins inf\195\169rieurs";
HEALBOT_LESSER_HEALING_WAVE = GetSpellInfo(8004) or "Vague de soins inf\195\169rieurs";
HEALBOT_POWER_WORD_SHIELD   = GetSpellInfo(17) or "Mot de pouvoir\194\160: Bouclier"
HEALBOT_REGROWTH            = GetSpellInfo(8936) or "R\195\169tablissement";
HEALBOT_RENEW               = GetSpellInfo(139) or "R\195\169novation";
HEALBOT_REJUVENATION        = GetSpellInfo(774) or "R\195\169cup\195\169ration";
HEALBOT_LIFEBLOOM           = GetSpellInfo(33763) or "Fleur de vie";
HEALBOT_WILD_GROWTH         = GetSpellInfo(48438) or "Croissance sauvage";
HEALBOT_REVIVE              = GetSpellInfo(50769) or "Ressusciter";
HEALBOT_TRANQUILITY         = GetSpellInfo(740) or "Tranquilit\195\169";
HEALBOT_SWIFTMEND           = GetSpellInfo(18562) or "Prompte gu\195\169rison";
HEALBOT_PRAYER_OF_HEALING   = GetSpellInfo(596) or "Pri\195\168re de soins";
HEALBOT_CHAIN_HEAL          = GetSpellInfo(1064) or "Salve de gu\195\169rison";
HEALBOT_NOURISH             = GetSpellInfo(50464) or "Nourrir";












HEALBOT_BLESSED_RESILIENCE    = GetSpellInfo(33142) or "Résilience bénie";
HEALBOT_PAIN_SUPPRESSION	  = GetSpellInfo(33206) or "Suppression de la douleur";
HEALBOT_POWER_INFUSION        = GetSpellInfo(10060) or "Infusion de puissance";
HEALBOT_PRAYER_OF_FORTITUDE   = GetSpellInfo(21562) or "Pri\195\168re de robustesse";
HEALBOT_POWER_WORD_FORTITUDE  = GetSpellInfo(1243) or "Mot de pouvoir\194\160: Robustesse";
HEALBOT_DIVINE_SPIRIT         = GetSpellInfo(14752) or "Esprit divin";
HEALBOT_PRAYER_OF_SPIRIT      = GetSpellInfo(27681) or "Pri\195\168re d'Esprit"
HEALBOT_SHADOW_PROTECTION     = GetSpellInfo(976) or "Protection contre l\'Ombre";
HEALBOT_PRAYER_OF_SHADOW_PROTECTION = GetSpellInfo(27683) or "Pri\195\168re de protection contre l\'Ombre";
HEALBOT_INNER_FIRE            = GetSpellInfo(588) or "Feu int\195\169rieur";


HEALBOT_TWIN_DISCIPLINES      = GetSpellInfo(47586) or "Disciplines jumelles";
HEALBOT_SPIRITAL_HEALING      = GetSpellInfo(14898) or "Soins spirituels";
HEALBOT_SPIRITAL_GUIDANCE     = GetSpellInfo(14901) or "Direction spirituelle";
HEALBOT_EMPOWERED_HEALING     = GetSpellInfo(33158) or "Soins surpuissants";
HEALBOT_DIVINE_PROVIDENCE     = GetSpellInfo(47562) or "Providence divine";
HEALBOT_IMPROVED_RENEW        = GetSpellInfo(14908) or "R\195\169novation am\195\169lior\195\169e";
HEALBOT_EMPOWERED_RENEW       = GetSpellInfo(63534) or "Rénovation surpuissante";
HEALBOT_FOCUSED_POWER         = GetSpellInfo(33186) or "Puissance focalis\195\169e";
HEALBOT_GENESIS               = GetSpellInfo(57810) or "Gen\195\168se";
HEALBOT_NURTURING_INSTINCT    = GetSpellInfo(33872) or "Instinct nourricier";
HEALBOT_IMPROVED_REJUVENATION = GetSpellInfo(17111) or "R\195\169cup\195\169ration am\195\169lior\195\169e";
HEALBOT_GIFT_OF_NATURE        = GetSpellInfo(17104) or "Don de la Nature";
HEALBOT_EMPOWERED_TOUCH       = GetSpellInfo(33879) or "Toucher surpuissant";
HEALBOT_EMPOWERED_REJUVENATION = GetSpellInfo(33886) or "R\195\169cup\195\169ration surpuissante";
HEALBOT_MASTER_SHAPESHIFTER   = GetSpellInfo(48412) or "Maître changeforme";
HEALBOT_HEALING_LIGHT         = GetSpellInfo(20237) or "Lumi\195\168re gu\195\169risseuse";
HEALBOT_DIVINITY              = GetSpellInfo(63646) or "Divinité";
HEALBOT_TOUCHED_BY_THE_LIGHT  = GetSpellInfo(53590) or "Touché par la Lumière";
HEALBOT_PURIFICATION          = GetSpellInfo(16178) or "Purification";
HEALBOT_IMPROVED_CHAIN_HEAL   = GetSpellInfo(30872) or "Salve de gu\195\169rison am\195\169lior\195\169e";
HEALBOT_TIDAL_WAVES           = GetSpellInfo(51562) or "Raz-de-marée";
HEALBOT_NATURES_BLESSING      = GetSpellInfo(30867) or "B\195\169n\195\169diction de la nature";


HEALBOT_FEAR_WARD             = GetSpellInfo(6346) or "Gardien de peur";
HEALBOT_ARCANE_INTELLECT      = GetSpellInfo(1459) or "Intelligence des arcanes";
HEALBOT_ARCANE_BRILLIANCE     = GetSpellInfo(23028) or "Illumination des arcanes";
HEALBOT_DALARAN_INTELLECT     = GetSpellInfo(61024) or "Intelligence de Dalaran";
HEALBOT_DALARAN_BRILLIANCE    = GetSpellInfo(61316) or "Illumination de Dalaran";
HEALBOT_FROST_ARMOR           = GetSpellInfo(168) or "Armure de givre";
HEALBOT_ICE_ARMOR             = GetSpellInfo(7302) or "Armure de glace";
HEALBOT_MAGE_ARMOR            = GetSpellInfo(6117) or "Armure du Mage";
HEALBOT_MOLTEN_ARMOR          = GetSpellInfo(30482) or "Armure de la fournaise";
HEALBOT_DEMON_ARMOR           = GetSpellInfo(706) or "Armure d\195\169moniaque";
HEALBOT_DEMON_SKIN            = GetSpellInfo(687) or "Peau de d\195\169mon";
HEALBOT_FEL_ARMOR             = GetSpellInfo(28176) or "Gangrarmure"; 
HEALBOT_SOUL_LINK             = GetSpellInfo(19028) or "Lien spirituel";
HEALBOT_DAMPEN_MAGIC          = GetSpellInfo(604) or "Att\195\169nuation de la magie";
HEALBOT_AMPLIFY_MAGIC         = GetSpellInfo(1008) or "Amplification de la magie";
HEALBOT_DETECT_INV            = GetSpellInfo(132) or "D\195\169tection de l\'invisibilit\195\169";
HEALBOT_FOCUS_MAGIC           = GetSpellInfo(54646) or "Focalisation de la magie";

HEALBOT_LIGHTNING_SHIELD      = GetSpellInfo(324) or "Bouclier de Foudre";
HEALBOT_ROCKBITER_WEAPON      = GetSpellInfo(8017) or "Arme Croque-roc";
HEALBOT_FLAMETONGUE_WEAPON    = GetSpellInfo(8024) or "Arme Langue de feu";
HEALBOT_EARTHLIVING_WEAPON    = GetSpellInfo(51730) or "Arme Viveterre";
HEALBOT_WINDFURY_WEAPON       = GetSpellInfo(8232) or "Arme Furie-des-vents";
HEALBOT_FROSTBRAND_WEAPON     = GetSpellInfo(8033) or "Arme de givre"; 
HEALBOT_EARTH_SHIELD          = GetSpellInfo(974) or "Bouclier de terre"; 
HEALBOT_WATER_SHIELD          = GetSpellInfo(52127) or "Bouclier d'eau";

HEALBOT_MARK_OF_THE_WILD      = GetSpellInfo(1126) or "Marque du fauve";
HEALBOT_GIFT_OF_THE_WILD      = GetSpellInfo(21849) or "Don du fauve";
HEALBOT_THORNS                = GetSpellInfo(467) or "Epines";
HEALBOT_OMEN_OF_CLARITY       = GetSpellInfo(16864) or "Augure de clart\195\169";

HEALBOT_BEACON_OF_LIGHT       = GetSpellInfo(53563) or "Guide de lumi\195\168re";

HEALBOT_SACRED_SHIELD         = GetSpellInfo(53601) or "Bouclier saint";





HEALBOT_SHEATH_OF_LIGHT         = GetSpellInfo(53501) or "Fourreau de lumi\195\168re"
HEALBOT_BLESSING_OF_MIGHT       = GetSpellInfo(19740) or "B\195\169n\195\169diction de puissance";
HEALBOT_BLESSING_OF_WISDOM      = GetSpellInfo(19742) or "B\195\169n\195\169diction de sagesse";
HEALBOT_BLESSING_OF_SANCTUARY   = GetSpellInfo(20911) or "B\195\169n\195\169diction du sanctuaire";
HEALBOT_BLESSING_OF_PROTECTION  = GetSpellInfo(41450) or "B\195\169n\195\169diction de protection";
HEALBOT_BLESSING_OF_KINGS       = GetSpellInfo(20217) or "B\195\169n\195\169diction des rois";
HEALBOT_GREATER_BLESSING_OF_MIGHT     = GetSpellInfo(25782) or "B\195\169n\195\169diction de puissance sup\195\169rieure";
HEALBOT_GREATER_BLESSING_OF_WISDOM    = GetSpellInfo(25894) or "B\195\169n\195\169diction de sagesse sup\195\169rieure";
HEALBOT_GREATER_BLESSING_OF_KINGS     = GetSpellInfo(25898) or "B\195\169n\195\169diction des rois sup\195\169rieure";
HEALBOT_GREATER_BLESSING_OF_SANCTUARY = GetSpellInfo(25899) or "B\195\169n\195\169diction du sanctuaire sup\195\169rieure";
HEALBOT_SEAL_OF_RIGHTEOUSNESS   = GetSpellInfo(21084) or "Sceau de pi\195\169t\195\169"
HEALBOT_SEAL_OF_BLOOD           = GetSpellInfo(31892) or "Sceau de sang"
HEALBOT_SEAL_OF_CORRUPTION      = GetSpellInfo(53736) or "Sceau de corruption"
HEALBOT_SEAL_OF_JUSTICE         = GetSpellInfo(20164) or "Sceau de justice"
HEALBOT_SEAL_OF_LIGHT           = GetSpellInfo(20165) or "Sceau de lumi\195\168re"
HEALBOT_SEAL_OF_VENGEANCE       = GetSpellInfo(31801) or "Sceau de vengeance"
HEALBOT_SEAL_OF_WISDOM          = GetSpellInfo(20166) or "Sceau de sagesse"
HEALBOT_SEAL_OF_COMMAND         = GetSpellInfo(20375) or "Sceau d\'autorit\195\169"
HEALBOT_SEAL_OF_THE_MARTYR      = GetSpellInfo(53720) or "Sceau du martyr"
HEALBOT_HAND_OF_FREEDOM         = GetSpellInfo(1044) or "Main de libert\195\169"
HEALBOT_HAND_OF_PROTECTION      = GetSpellInfo(1022) or "Main de protection"
HEALBOT_HAND_OF_SACRIFICE       = GetSpellInfo(6940) or "Main de sacrifice"
HEALBOT_HAND_OF_SALVATION       = GetSpellInfo(1038) or "Main de salut"
HEALBOT_RIGHTEOUS_FURY          = GetSpellInfo(25780) or "Fureur vertueuse"
HEALBOT_DEVOTION_AURA           = GetSpellInfo(465) or "Aura de d\195\169votion"
HEALBOT_RETRIBUTION_AURA        = GetSpellInfo(7294) or "Aura de vindicte"
HEALBOT_CONCENTRATION_AURA      = GetSpellInfo(19746) or "Aura de concentration"
HEALBOT_SHR_AURA                = GetSpellInfo(19876) or "Aura de r\195\169sistance \195\160 l\'Ombre"
HEALBOT_FRR_AURA                = GetSpellInfo(19888) or "Aura de r\195\169sistance au Givre"
HEALBOT_FIR_AURA                = GetSpellInfo(19891) or "Aura de r\195\169sistance au Feu"
HEALBOT_CRUSADER_AURA           = GetSpellInfo(32223) or "Aura de crois\195\169"

























HEALBOT_A_MONKEY           = GetSpellInfo(13163) or "Aspect du singe"
HEALBOT_A_HAWK             = GetSpellInfo(13165) or "Aspect du faucon"
HEALBOT_A_CHEETAH          = GetSpellInfo(5118) or "Aspect du gu\195\169pard"
HEALBOT_A_BEAST            = GetSpellInfo(13161) or "Aspect de la b\195\170te"
HEALBOT_A_PACK             = GetSpellInfo(13159) or "Aspect de la meute"
HEALBOT_A_WILD             = GetSpellInfo(20043) or "Aspect de la nature"
HEALBOT_A_VIPER            = GetSpellInfo(34074) or "Aspect de la vip\195\168re"
HEALBOT_A_DRAGONHAWK       = GetSpellInfo(61846) or "Aspect du faucon-dragon"
HEALBOT_MENDPET            = GetSpellInfo(136) or "Gu\195\169rison du familier"

HEALBOT_UNENDING_BREATH    = GetSpellInfo(5697) or "Respiration interminable"

HEALBOT_RESURRECTION       = GetSpellInfo(2006) or "R\195\169surrection";
HEALBOT_REDEMPTION         = GetSpellInfo(7328) or "R\195\169demption";
HEALBOT_REBIRTH            = GetSpellInfo(20484) or "Renaissance";
HEALBOT_ANCESTRALSPIRIT    = GetSpellInfo(2008) or "Esprit Ancestral";

HEALBOT_PURIFY             = GetSpellInfo(1152) or "Purification";
HEALBOT_CLEANSE            = GetSpellInfo(4987) or "Epuration";
HEALBOT_CURE_POISON        = GetSpellInfo(8946) or "Gu\195\169rison du poison";
HEALBOT_REMOVE_CURSE       = GetSpellInfo(2782) or "D\195\169livrance de la mal\195\169diction";
HEALBOT_ABOLISH_POISON     = GetSpellInfo(2893) or "Abolir le poison";
HEALBOT_CURE_DISEASE       = GetSpellInfo(528) or "Gu\195\169rison des maladies";
HEALBOT_ABOLISH_DISEASE    = GetSpellInfo(552) or "Abolir maladie";
HEALBOT_DISPEL_MAGIC       = GetSpellInfo(527) or "Dissipation de la magie";
HEALBOT_CLEANSE_SPIRIT	   = GetSpellInfo(51886) or "Purifier l\'esprit";
HEALBOT_CURE_TOXINS        = GetSpellInfo(526) or "Gu\195\169rison des toxines";
HEALBOT_DISEASE            = "Maladie";
HEALBOT_MAGIC              = "Magie";
HEALBOT_CURSE              = "Mal\195\169diction";
HEALBOT_POISON             = "Poison";






HEALBOT_DEBUFF_ANCIENT_HYSTERIA = "Hyst\195\169rie ancienne";
HEALBOT_DEBUFF_IGNITE_MANA      = "Enflammer le mana";
HEALBOT_DEBUFF_TAINTED_MIND     = "Esprit corrompu";
HEALBOT_DEBUFF_VIPER_STING      = "Morsure de vip\195\168re";
HEALBOT_DEBUFF_SILENCE          = "Silence";
HEALBOT_DEBUFF_MAGMA_SHACKLES   = "Entraves de magma";
HEALBOT_DEBUFF_FROSTBOLT        = "Eclair de givre";
HEALBOT_DEBUFF_HUNTERS_MARK     = "Marque du chasseur";
HEALBOT_DEBUFF_SLOW             = "Lent";
HEALBOT_DEBUFF_ARCANE_BLAST     = "D\195\169flagration des arcanes";
HEALBOT_DEBUFF_IMPOTENCE        = "Mal\195\169diction d'impuissance";
HEALBOT_DEBUFF_DECAYED_STR      = "Force diminu\195\169e";
HEALBOT_DEBUFF_DECAYED_INT      = "Intelligence diminu\195\169e";
HEALBOT_DEBUFF_CRIPPLE          = "Estropi\195\169";
HEALBOT_DEBUFF_CHILLED          = "Gel\195\169";
HEALBOT_DEBUFF_CONEOFCOLD       = "C\195\180ne de froid";
HEALBOT_DEBUFF_CONCUSSIVESHOT   = "Fl\195\168che de dispersion";
HEALBOT_DEBUFF_THUNDERCLAP      = "Coup de tonnerre";
HEALBOT_DEBUFF_HOWLINGSCREECH   = "Etreinte vampirirque";
HEALBOT_DEBUFF_DAZED            = "h\195\169b\195\169t\195\169";
HEALBOT_DEBUFF_UNSTABLE_AFFL    = "Affliction instable";
HEALBOT_DEBUFF_DREAMLESS_SLEEP  = "Sommeil sans r\195\170ve";
HEALBOT_DEBUFF_GREATER_DREAMLESS = "Sommeil sans r\195\170ve sup\195\169rieur";
HEALBOT_DEBUFF_MAJOR_DREAMLESS  = "Sommeil sans r\195\170ve majeure";
HEALBOT_DEBUFF_FROST_SHOCK      = "Horion de givre"


HEALBOT_RANK_1              = "(Rang 1)";
HEALBOT_RANK_2              = "(Rang 2)";
HEALBOT_RANK_3              = "(Rang 3)";
HEALBOT_RANK_4              = "(Rang 4)";
HEALBOT_RANK_5              = "(Rang 5)";
HEALBOT_RANK_6              = "(Rang 6)";
HEALBOT_RANK_7              = "(Rang 7)";
HEALBOT_RANK_8              = "(Rang 8)";
HEALBOT_RANK_9              = "(Rang 9)";
HEALBOT_RANK_10             = "(Rang 10)";
HEALBOT_RANK_11             = "(Rang 11)";
HEALBOT_RANK_12             = "(Rang 12)";
HEALBOT_RANK_13             = "(Rang 13)";
HEALBOT_RANK_14             = "(Rang 14)";
HEALBOT_RANK_15             = "(Rang 15)";
HEALBOT_RANK_16             = "(Rang 16)";
HEALBOT_RANK_17             = "(Rang 17)";
HEALBOT_RANK_18             = "(Rang 18)";

HB_SPELL_PATTERN_LESSER_HEAL         = "Rend \195\160 votre cible (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_HEAL                = "Rend \195\160 votre cible (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_GREATER_HEAL        = "Une longue incantation qui rend (%d+) \195\160 (%d+) points de vie \195\160 une cible unique";
HB_SPELL_PATTERN_FLASH_HEAL          = "Rend (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_RENEW               = "Rend (%d+) \195\160 (%d+) points de vie \195\160 la cible en (%d+) sec";
HB_SPELL_PATTERN_RENEW1              = "Rend (%d+) points de vie \195\160 la cible en (%d+) sec";
HB_SPELL_PATTERN_RENEW2              = "Not needed for fr";
HB_SPELL_PATTERN_RENEW3              = "Not needed for fr";
HB_SPELL_PATTERN_SHIELD              = "absorbe (%d+) points de d\195\169g\195\162ts. Dure (%d+) sec";
HB_SPELL_PATTERN_HEALING_TOUCH       = "Rend (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_REGROWTH            = "Soigne une cible amie pour (%d+) \195\160 (%d+) puis pour (%d+) points suppl.+mentaires pendant (%d+) sec";
HB_SPELL_PATTERN_REGROWTH1           = "Soigne une cible amie pour (%d+) \195\160 (%d+) puis pour (%d+) \195\160 (%d+) points suppl.+mentaires pendant (%d+) sec";
HB_SPELL_PATTERN_HOLY_LIGHT          = "Rend (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_FLASH_OF_LIGHT      = "Rend (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_HEALING_WAVE        = "Rend (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_LESSER_HEALING_WAVE = "Rend (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_REJUVENATION        = "Rend (%d+) points de vie \195\160 la cible en (%d+) sec";
HB_SPELL_PATTERN_REJUVENATION1       = "Rend (%d+) \195\160 (%d+) points de vie \195\160 la cible en (%d+) sec";
HB_SPELL_PATTERN_REJUVENATION2       = "Not needed for fr";
HB_SPELL_PATTERN_MEND_PET            = "Soigne votre pet de (%d+) points de vie chaques secondes que vous le ciblez. Dure (%d+) sec"

HB_TOOLTIP_MANA                      = "^Mana : (%d+)$";
HB_TOOLTIP_RANGE                     = "de (%d+) m"
HB_TOOLTIP_INSTANT_CAST              = "Incantation imm\195\169diate";
HB_TOOLTIP_CAST_TIME                 = "Incantation (%d+.?%d*) sec";
HB_TOOLTIP_CHANNELED                 = "Canalis\195\169"
HB_TOOLTIP_OFFLINE                   = "Hors ligne";
HB_OFFLINE                			 = "Hors ligne"; -- has gone offline msg
HB_ONLINE                	         = "En ligne"; -- has come online msg

-----------------
-- Translation --
-----------------

HEALBOT_ADDON                 = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED                = " charg\195\169.";

HEALBOT_ACTION_OPTIONS        = "Options";

HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS      = "D\195\169faut";
HEALBOT_OPTIONS_CLOSE         = "Fermer";
HEALBOT_OPTIONS_HARDRESET     = "ReloadUI";
HEALBOT_OPTIONS_SOFTRESET     = "ResetHB";
HEALBOT_OPTIONS_INFO          = "Infos";
HEALBOT_OPTIONS_TAB_GENERAL   = "G\195\169n\195\169ral";
HEALBOT_OPTIONS_TAB_SPELLS    = "Sorts";
HEALBOT_OPTIONS_TAB_HEALING   = "Soins";
HEALBOT_OPTIONS_TAB_CDC       = "Gu\195\169rison";
HEALBOT_OPTIONS_TAB_SKIN      = "Skin";
HEALBOT_OPTIONS_TAB_TIPS      = "Affich.";
HEALBOT_OPTIONS_TAB_BUFFS     = "Buffs"

HEALBOT_OPTIONS_PANEL_TEXT    = "Options de soins"
HEALBOT_OPTIONS_BARALPHA      = "OPACITE : Barres";
HEALBOT_OPTIONS_BARALPHAINHEAL= "Sorts en cours";
HEALBOT_OPTIONS_BARALPHAEOR   = "Joueurs hors d\'atteinte";
HEALBOT_OPTIONS_ACTIONLOCKED  = "Verr. la position";
HEALBOT_OPTIONS_AUTOSHOW      = "Fermer auto.";
HEALBOT_OPTIONS_PANELSOUNDS   = "Son \195\160 l\'ouverture";
HEALBOT_OPTIONS_HIDEOPTIONS   = "Masquer \'options\'";
HEALBOT_OPTIONS_PROTECTPVP    = "Eviter le passage accidentel en JcJ";
HEALBOT_OPTIONS_HEAL_CHATOPT  = "Options de chat";

HEALBOT_OPTIONS_SKINTEXT      = "Skin"
HEALBOT_SKINS_STD             = "Standard"
HEALBOT_OPTIONS_SKINTEXTURE   = "Texture"
HEALBOT_OPTIONS_SKINHEIGHT    = "Hauteur"
HEALBOT_OPTIONS_SKINWIDTH     = "Largeur"
HEALBOT_OPTIONS_SKINNUMCOLS   = "Nb de colonnes"
HEALBOT_OPTIONS_SKINNUMHCOLS  = "Nb d\'en-t\195\170tes par col."
HEALBOT_OPTIONS_SKINBRSPACE   = "Espacement rang\195\169es"
HEALBOT_OPTIONS_SKINBCSPACE   = "Espacement col."
HEALBOT_OPTIONS_EXTRASORT     = "Trier les barres par"
HEALBOT_SORTBY_NAME           = "Nom"
HEALBOT_SORTBY_CLASS          = "Classe"
HEALBOT_SORTBY_GROUP          = "Groupe"
HEALBOT_SORTBY_MAXHEALTH      = "Vie max."
HEALBOT_OPTIONS_NEWDEBUFFTEXT = "Nveau d\195\169buff"
HEALBOT_OPTIONS_DELSKIN       = "Supprimer"
HEALBOT_OPTIONS_NEWSKINTEXT   = "Nveau nom"
HEALBOT_OPTIONS_SAVESKIN      = "Sauver"
HEALBOT_OPTIONS_SKINBARS      = "Options des barres"
HEALBOT_OPTIONS_SKINPANEL     = "Couleurs du panneau"
HEALBOT_SKIN_ENTEXT           = "Activ\195\169"
HEALBOT_SKIN_DISTEXT          = "Hors combat"
HEALBOT_SKIN_DEBTEXT          = "D\195\169buff"
HEALBOT_SKIN_BACKTEXT         = "Arri\195\168re plan"
HEALBOT_SKIN_BORDERTEXT       = "Bordure"
HEALBOT_OPTIONS_SKINFONT      = "Police"
HEALBOT_OPTIONS_SKINFHEIGHT   = "Taille des caract\195\168res"
HEALBOT_OPTIONS_BARALPHADIS   = "Hors combat"
HEALBOT_OPTIONS_SHOWHEADERS   = "Afficher les en-t\195\170tes"

HEALBOT_OPTIONS_ITEMS  = "Objets";
HEALBOT_OPTIONS_SPELLS = "Sorts";

HEALBOT_OPTIONS_COMBOCLASS    = "Combinaison de touche pour";
HEALBOT_OPTIONS_CLICK         = "Clic";
HEALBOT_OPTIONS_SHIFT         = "Maj";
HEALBOT_OPTIONS_CTRL          = "Ctrl";
HEALBOT_OPTIONS_ENABLEHEALTHY = "Toujours utiliser config. 'en combat'";

HEALBOT_OPTIONS_CASTNOTIFY1         = "Pas de messages";
HEALBOT_OPTIONS_CASTNOTIFY2         = "Avertir soi-m\195\170me";
HEALBOT_OPTIONS_CASTNOTIFY3         = "Avertir la cible";
HEALBOT_OPTIONS_CASTNOTIFY4         = "Avertir le groupe";
HEALBOT_OPTIONS_CASTNOTIFY5         = "Avertir le raid";
HEALBOT_OPTIONS_CASTNOTIFY6         = "Sur canal";
HEALBOT_OPTIONS_CASTNOTIFYRESONLY   = "Avertir uniquement de la r\195\169surrection";
HEALBOT_OPTIONS_TARGETWHISPER       = "Chuchoter lors de l\'incantation du soin";

HEALBOT_OPTIONS_CDCBARS             = "Couleur";
HEALBOT_OPTIONS_CDCSHOWHBARS        = "Sur la barre de vie";
HEALBOT_OPTIONS_CDCSHOWABARS        = "Sur la barre d\'aggro";
HEALBOT_OPTIONS_CDCCLASS            = "Surveiller les classes";
HEALBOT_OPTIONS_CDCWARNINGS         = "Alertes d\195\169buffs";
HEALBOT_OPTIONS_SHOWDEBUFFICON      = "Aff. les d\195\169buffs";
HEALBOT_OPTIONS_SHOWDEBUFFWARNING   = "Afficher une alerte de d\195\169buff";
HEALBOT_OPTIONS_SOUNDDEBUFFWARNING  = "Son pour les d\195\169buffs";
HEALBOT_OPTIONS_SOUND	            = "Son"
HEALBOT_OPTIONS_SOUND1              = "Son 1"
HEALBOT_OPTIONS_SOUND2              = "Son 2"
HEALBOT_OPTIONS_SOUND3              = "Son 3"

HEALBOT_OPTIONS_HEAL_BUTTONS    = "Barres de soins:"
HEALBOT_OPTIONS_SELFHEALS       = "soi-m\195\170me"
HEALBOT_OPTIONS_PETHEALS        = "Familiers"
HEALBOT_OPTIONS_GROUPHEALS      = "Groupe";
HEALBOT_OPTIONS_TANKHEALS       = "Tank principal";
HEALBOT_OPTIONS_TARGETHEALS     = "Cibles";
HEALBOT_OPTIONS_PRIVATETANKS    = "Main Tanks perso.";
HEALBOT_OPTIONS_EMERGENCYHEALS  = "Raid";
HEALBOT_OPTIONS_ALERTLEVEL      = "Niveau d'alerte";
HEALBOT_OPTIONS_EMERGFILTER     = "Barre pour";
HEALBOT_OPTIONS_EMERGFCLASS     = "Config. classes pour";
HEALBOT_OPTIONS_COMBOBUTTON     = "Bouton";
HEALBOT_OPTIONS_BUTTONLEFT      = "Gauche";
HEALBOT_OPTIONS_BUTTONMIDDLE    = "Milieu";
HEALBOT_OPTIONS_BUTTONRIGHT     = "Droite";
HEALBOT_OPTIONS_BUTTON4         = "Bouton4";
HEALBOT_OPTIONS_BUTTON5         = "Bouton5";
HEALBOT_OPTIONS_BUTTON6         = "Bouton6";
HEALBOT_OPTIONS_BUTTON7         = "Bouton7";
HEALBOT_OPTIONS_BUTTON8         = "Bouton8";
HEALBOT_OPTIONS_BUTTON9         = "Bouton9";
HEALBOT_OPTIONS_BUTTON10        = "Bouton10";
HEALBOT_OPTIONS_BUTTON11        = "Bouton11";
HEALBOT_OPTIONS_BUTTON12        = "Bouton12";
HEALBOT_OPTIONS_BUTTON13        = "Bouton13";
HEALBOT_OPTIONS_BUTTON14        = "Bouton14";
HEALBOT_OPTIONS_BUTTON15        = "Bouton15";

HEALBOT_CLASSES_ALL     = "Toutes les classes";
HEALBOT_CLASSES_MELEE   = "Corps \195\160 corps";
HEALBOT_CLASSES_RANGES  = "A distance";
HEALBOT_CLASSES_HEALERS = "Soigneurs";
HEALBOT_CLASSES_CUSTOM  = "Personnalis\195\169";

HEALBOT_OPTIONS_SHOWTOOLTIP     = "Montrer infos";
HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "Montrer le d\195\169tail des sorts";
HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "Montrer infos sur la cible";
HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "Montrer le soin HoT recommand\195\169";
HEALBOT_OPTIONS_SHOWPDCTOOLTIP  = "Afficher les combinaisons de touches pr\195\169d\195\169finies";
HEALBOT_TOOLTIP_POSDEFAULT      = "Par d\195\169faut";
HEALBOT_TOOLTIP_POSLEFT         = "A gauche de Healbot";
HEALBOT_TOOLTIP_POSRIGHT        = "A droite de Healbot";
HEALBOT_TOOLTIP_POSABOVE        = "Au dessus de Healbot";
HEALBOT_TOOLTIP_POSBELOW        = "Au dessous de Healbot";
HEALBOT_TOOLTIP_POSCURSOR       = "Pr\195\170t du Curseur";
HEALBOT_TOOLTIP_RECOMMENDTEXT   = "Soin HoT recommand\195\169";
HEALBOT_TOOLTIP_NONE            = "Non disponible";
HEALBOT_TOOLTIP_ITEMBONUS       = "Bonus d'objets";
HEALBOT_TOOLTIP_ACTUALBONUS     = "Bonus r\195\169el";
HEALBOT_TOOLTIP_SHIELD          = "Salle"
HEALBOT_TOOLTIP_LOCATION        = "Lieu";
HEALBOT_TOOLTIP_CORPSE          = "Cadavre de ";
HEALBOT_WORDS_OVER              = "par";
HEALBOT_WORDS_SEC               = "sec";
HEALBOT_WORDS_TO                = "\195\160";
HEALBOT_WORDS_CAST              = "lancer"
HEALBOT_WORDS_FOR               = "sur";
HEALBOT_WORDS_UNKNOW            = "inconnu";
HEALBOT_WORDS_YES               = "Oui";
HEALBOT_WORDS_NO                = "Non";

HEALBOT_WORDS_NONE                  = "Aucun";
HEALBOT_OPTIONS_ALT                 = "Alt";
HEALBOT_DISABLED_TARGET             = "Cible"
HEALBOT_OPTIONS_SHOWCLASSONBAR      = "Afficher la classe";
HEALBOT_OPTIONS_SHOWHEALTHONBAR     = "Afficher la vie";
HEALBOT_OPTIONS_BARHEALTHINCHEALS   = "Inclure les soins en cours";
HEALBOT_OPTIONS_BARHEALTHSEPHEALS   = "Montant des soins en cours";
HEALBOT_OPTIONS_BARHEALTH1          = "en \195\169cart";
HEALBOT_OPTIONS_BARHEALTH2          = "en pourcentage";
HEALBOT_OPTIONS_TIPTEXT             = "Bulle d\'info";
HEALBOT_OPTIONS_BARINFOTEXT         = "Barre d\'info";
HEALBOT_OPTIONS_POSTOOLTIP          = "Position";
HEALBOT_OPTIONS_SHOWNAMEONBAR       = "Afficher le nom";
HEALBOT_SKIN_BARCLASSCUSTOMCOLOUR   = "Couleur par";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "Colorer les noms par classe";
HEALBOT_OPTIONS_EMERGFILTERGROUPS   = "Inclure groupes";










HEALBOT_OPTIONS_SETDEFAULTS      = "R\195\169g. par d\195\169faut";
HEALBOT_OPTIONS_SETDEFAULTSMSG   = "R\195\169-initialise toutes les options par d\195\169faut";
HEALBOT_OPTIONS_RIGHTBOPTIONS    = "Clic droit ouvre les options";

HEALBOT_OPTIONS_HEADEROPTTEXT    = "Options des titres";
HEALBOT_OPTIONS_ICONOPTTEXT      = "Options d\'ic\195\180nes";
HEALBOT_SKIN_HEADERBARCOL        = "Couleur des barres";
HEALBOT_SKIN_HEADERTEXTCOL       = "Couleur du texte";
HEALBOT_OPTIONS_BUFFSTEXT1       = "Type de buff";
HEALBOT_OPTIONS_BUFFSTEXT2       = "V\195\169rifier membres";
HEALBOT_OPTIONS_BUFFSTEXT3       = "Couleur";
HEALBOT_OPTIONS_BUFF             = "Buff ";
HEALBOT_OPTIONS_BUFFSELF         = "sur soi";
HEALBOT_OPTIONS_BUFFPARTY        = "sur le groupe";
HEALBOT_OPTIONS_BUFFRAID         = "sur le raid";
HEALBOT_OPTIONS_MONITORBUFFS     = "Afficher les buffs manquants";
HEALBOT_OPTIONS_MONITORBUFFSC    = "\195\169galement en combat";
HEALBOT_OPTIONS_ENABLESMARTCAST  = "Sorts intelligents hors combat";
HEALBOT_OPTIONS_SMARTCASTSPELLS  = "Inclure les sorts";
HEALBOT_OPTIONS_SMARTCASTDISPELL = "Enlever les d\195\169buffs";
HEALBOT_OPTIONS_SMARTCASTBUFF    = "Ajouter les buffs";
HEALBOT_OPTIONS_SMARTCASTHEAL    = "Sorts de soin";
HEALBOT_OPTIONS_BAR2SIZE         = "Taille de la barre de mana";
HEALBOT_OPTIONS_SETSPELLS        = "Conf. sorts pour";
HEALBOT_OPTIONS_ENABLEDBARS      = "Barres en combat";
HEALBOT_OPTIONS_DISABLEDBARS     = "Barres hors combat";
HEALBOT_OPTIONS_MONITORDEBUFFS   = "Afficher les d\195\169buffs";
HEALBOT_OPTIONS_DEBUFFTEXT1      = "Sort pour retirer les d\195\169buffs";

HEALBOT_OPTIONS_IGNOREDEBUFF         = "Ignorer d\195\169buffs:";
HEALBOT_OPTIONS_IGNOREDEBUFFCLASS    = "Par classe";
HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "Ralentissement";
HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "Dur\195\169e courte";
HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM   = "Non nocifs";

HEALBOT_OPTIONS_RANGECHECKFREQ       = "Fr\195\169quence de v\195\169rif. de la distance, des auras et de l\'aggro";
HEALBOT_OPTIONS_RANGECHECKUNITS      = "Freq. v\195\169rif. sur cibles avec blessures mineures"

HEALBOT_OPTIONS_HIDEPARTYFRAMES      = "Masquer avatars";
HEALBOT_OPTIONS_HIDEPLAYERTARGET     = "Y compris joueur & Cible";
HEALBOT_OPTIONS_DISABLEHEALBOT       = "D\195\169sactiver HealBot";

HEALBOT_OPTIONS_CHECKEDTARGET        = "V\195\169rifi\195\169";

HEALBOT_ASSIST               = "Assist";
HEALBOT_FOCUS                = "Focus";
HEALBOT_MENU                 = "Menu";
HEALBOT_MAINTANK             = "MainTank";
HEALBOT_MAINASSIST           = "MainAssist";
HEALBOT_STOP                 = "Stop";
HEALBOT_TELL                 = "Dire";

HEALBOT_TITAN_SMARTCAST      = "Sorts intelligents";
HEALBOT_TITAN_MONITORBUFFS   = "Afficher les Buffs";
HEALBOT_TITAN_MONITORDEBUFFS = "Afficher les d\195\169buffs"
HEALBOT_TITAN_SHOWBARS       = "Afficher barres pour";
HEALBOT_TITAN_EXTRABARS      = "Barres suppl.";
HEALBOT_BUTTON_TOOLTIP       = "Clic gauche : options HealBot\nClic-drag droit : d\195\169placer mini bouton";
HEALBOT_TITAN_TOOLTIP        = "Clic gauche : options HealBot";
HEALBOT_OPTIONS_SHOWMINIMAPBUTTON = "Aff. le bouton sur la minicarte";
HEALBOT_OPTIONS_BARBUTTONSHOWHOT  = "Aff. les HoT";
HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON = "Afficher les ic\195\180nes de raid";
HEALBOT_OPTIONS_HOTONBAR     = "Sur barre"
HEALBOT_OPTIONS_HOTOFFBAR    = "Hors barre"
HEALBOT_OPTIONS_HOTBARRIGHT  = "Droite"
HEALBOT_OPTIONS_HOTBARLEFT   = "Gauche"

HEALBOT_OPTIONS_ENABLETARGETSTATUS = "Utiliser r\195\169glages 'en combat' si cible en combat";

HEALBOT_ZONE_AB = "Bassin d\'Arathi"; 
HEALBOT_ZONE_AV = "Vall\195\169e d\'Alterac";   
HEALBOT_ZONE_ES = "Oeil du cyclone";
HEALBOT_ZONE_IC = "Ile des conqu\195\169rants";
HEALBOT_ZONE_SA = "Rivage des anciens";
HEALBOT_ZONE_WG = "Goulet des Chanteguerres";

HEALBOT_OPTION_AGGROTRACK     = "Moniteur d'aggro"
HEALBOT_OPTION_AGGROBAR       = "Barres Flash"
HEALBOT_OPTION_AGGROTXT       = ">> Montrer texte <<"
HEALBOT_OPTION_BARUPDFREQ     = "Fr\195\169quence de mise \195\160 jour des barres"
HEALBOT_OPTION_USEFLUIDBARS   = "Barres fluides"
HEALBOT_OPTION_CPUPROFILE     = "Aff. utilisation CPU des addons (intensif pour le CPU !)"
HEALBOT_OPTIONS_RELOADUIMSG   = "Requiert un re-chargement de l\'UI, charger maintenant ?"

HEALBOT_SELF_PVP              = "Self PvP"
HEALBOT_OPTIONS_ANCHOR        = "Ancre du cadre"
HEALBOT_OPTIONS_BARSANCHOR    = "Ancre des barres"
HEALBOT_OPTIONS_TOPLEFT       = "Haut \195\160 gauche"
HEALBOT_OPTIONS_BOTTOMLEFT    = "Bas \195\160 gauche"
HEALBOT_OPTIONS_TOPRIGHT      = "Haut \195\160 droite"
HEALBOT_OPTIONS_BOTTOMRIGHT   = "Bas \195\160 droite"
HEALBOT_OPTIONS_TOP           = "Haut"
HEALBOT_OPTIONS_BOTTOM        = "Bas"

HEALBOT_PANEL_BLACKLIST       = "BlackList"

HEALBOT_WORDS_REMOVEFROM      = "Retirer de";
HEALBOT_WORDS_ADDTO           = "Ajouter \195\160";
HEALBOT_WORDS_INCLUDE         = "Inclure";

HEALBOT_OPTIONS_TTALPHA       = "Opacit\195\169"
HEALBOT_TOOLTIP_TARGETBAR     = "Barre de cible"
HEALBOT_OPTIONS_MYTARGET      = "Mes cibles"

HEALBOT_DISCONNECTED_TEXT			= "<DC>"
HEALBOT_OPTIONS_SHOWUNITBUFFTIME    = "Montrer mes buffs";
HEALBOT_OPTIONS_TOOLTIPUPDATE       = "M\195\160J permanente";
HEALBOT_OPTIONS_BUFFSTEXTTIMER      = "Pr\195\169venir de la fin des buffs avant expiration";
HEALBOT_OPTIONS_SHORTBUFFTIMER      = "Buffs courts"
HEALBOT_OPTIONS_LONGBUFFTIMER       = "Buffs longs"

HEALBOT_BALANCE       = "Equilibre"
HEALBOT_FERAL         = "Feral"
HEALBOT_RESTORATION   = "Restauration"
HEALBOT_SHAMAN_RESTORATION = "Restauration"
HEALBOT_ARCANE        = "Arcane"
HEALBOT_FIRE          = "Feu"
HEALBOT_FROST         = "Givre"
HEALBOT_DISCIPLINE    = "Discipline"
HEALBOT_HOLY          = "Sacr\195\169"
HEALBOT_SHADOW        = "Ombre"
HEALBOT_ASSASSINATION = "Assassinat"
HEALBOT_COMBAT        = "Combat"
HEALBOT_SUBTLETY      = "Finesse"
HEALBOT_ARMS          = "Armes"
HEALBOT_FURY          = "Fureur"
HEALBOT_PROTECTION    = "Protection"
HEALBOT_BEASTMASTERY  = "Ma\195\175trise des b\195\170tes"
HEALBOT_MARKSMANSHIP  = "Pr\195\169cision"
HEALBOT_SURVIVAL      = "Survie"
HEALBOT_RETRIBUTION   = "Restauration"
HEALBOT_ELEMENTAL     = "El\195\169mentaire"
HEALBOT_ENHANCEMENT   = "Am\195\169lioration"
HEALBOT_AFFLICTION    = "Affliction"
HEALBOT_DEMONOLOGY    = "D\195\169monologie"
HEALBOT_DESTRUCTION   = "Destruction"
HEALBOT_BLOOD         = "Sang"
HEALBOT_UNHOLY        = "Impie"

HEALBOT_OPTIONS_VISIBLERANGE = "D\195\169sactiver la barre si au-del\195\160 de 100m"
HEALBOT_OPTIONS_NOTIFY_HEAL_MSG  = "Message de soin"
HEALBOT_OPTIONS_NOTIFY_OTHER_MSG = "Autre Message"
HEALBOT_WORDS_YOU                = "vous";
HEALBOT_NOTIFYHEALMSG            = "Incante #s pour soigner #n de #h pv";
HEALBOT_NOTIFYOTHERMSG           = "Incante #s sur #n";

HEALBOT_OPTIONS_HOTPOSITION     = "Position ic\195\180ne"
HEALBOT_OPTIONS_HOTSHOWTEXT     = "Texte de l\'ic\195\180ne"
HEALBOT_OPTIONS_HOTTEXTCOUNT    = "D\195\169compte"
HEALBOT_OPTIONS_HOTTEXTDURATION = "Dur\195\169e"
HEALBOT_OPTIONS_ICONSCALE       = "Echelle de l\'ic\195\180ne"
HEALBOT_OPTIONS_ICONTEXTSCALE   = "Echelle du texte de l\'ic\195\180ne"

HEALBOT_SKIN_FLUID              = "Fluide"
HEALBOT_SKIN_VIVID              = "Vif"
HEALBOT_SKIN_LIGHT              = "Lumi\195\168re"
HEALBOT_SKIN_SQUARE             = "Carr\195\169"
HEALBOT_OPTIONS_AGGROBARSIZE    = "Taille de la barre d\'aggro"
HEALBOT_OPTIONS_TARGETBARMODE   = "Limiter la barre de cible aux r\195\169glages pr\195\169d\195\169finis"
HEALBOT_OPTIONS_DOUBLETEXTLINES = "Texte sur deux lignes"
HEALBOT_OPTIONS_TEXTALIGNMENT   = "Alignement du texte"
HEALBOT_OPTIONS_ENABLELIBQH     = "Activer libQuickHealth"
HEALBOT_VEHICLE                 = "V\195\169hicules"
HEALBOT_OPTIONS_UNIQUESPEC      = "Enreg. des sorts en fonction de la sp\195\169cialisation"
HEALBOT_WORDS_ERROR             = "Erreur"
HEALBOT_SPELL_NOT_FOUND	        = "Sort pas trouv\195\169"
HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT = "Cacher les infos durant les combats"

HEALBOT_OPTIONS_BUFFNAMED       = "Nom du joueur \195\160 surveiller\n\n"
HEALBOT_OPTIONS_INHEALS         = "Utiliser HealBot pour les 'heals comm'"
HEALBOT_WORD_ALWAYS             = "Toujours";
HEALBOT_WORD_SOLO               = "En solo";
HEALBOT_WORD_NEVER              = "Jamais";
HEALBOT_SHOW_CLASS_AS_ICON      = "Ic\195\180ne";
HEALBOT_SHOW_CLASS_AS_TEXT      = "Texte";

HEALBOT_SHOW_INCHEALS           = "Montrer les soins entrants";
HEALBOT_D_DURATION              = "Dur\195\169e des sorts directs ";
HEALBOT_H_DURATION              = "Dur\195\169e des HoT ";
HEALBOT_C_DURATION 				= "Dur\195\169e des sorts canalis\195\169s "

HEALBOT_HELP={  [1] = "[HealBot] /hb h -- Afficher l\'aide",
                [2] = "[HealBot] /hb o -- Bascule options",
                [3] = "[HealBot] /hb d -- R\195\160Z des options",
                [4] = "[HealBot] /hb ui -- Recharger UI (reloadui)",
                [5] = "[HealBot] /hb ri -- R\195\160Z HealBot",
                [6] = "[HealBot] /hb t -- Bascule Healbot activ\195\169/d\195\169sactiv\195\169",
                [7] = "[HealBot] /hb bt -- Bascule moniteur de Buffs activ\195\169/d\195\169sactiv\195\169", 
                [8] = "[HealBot] /hb dt -- Bascule moniteur de D\195\169buffs activ\195\169/d\195\169sactiv\195\169",
                [9] = "[HealBot] /hb skin <skinName> -- Changer de Skin",
                [10] = "[HealBot] /hb tr <Role> -- D\195\169termine le r\195\180le prioritaire pour le sous-tri par r\195\180le. Les r\195\180les valides sont 'TANK', 'HEALER' ou 'DPS'",
}
              
HEALBOT_OPTION_HIGHLIGHTACTIVEBAR   = "Surbrillance au mouseover"
HEALBOT_OPTION_HIGHLIGHTTARGETBAR   = "Surbrillance cible"
HEALBOT_OPTIONS_TESTBARS            = "Barres de test"
HEALBOT_OPTION_NUMBARS              = "Nombre de barres"
HEALBOT_OPTION_NUMTANKS             = "Nombre de tanks"
HEALBOT_OPTION_NUMMYTARGETS         = "Nombre de cibles"
HEALBOT_OPTION_NUMPETS              = "Nombre de familiers"
HEALBOT_WORD_TEST                   = "Test";
HEALBOT_WORD_OFF                    = "Off";
HEALBOT_WORD_ON                     = "On";

HEALBOT_OPTIONS_TAB_INCHEALS        = "Heals entrants"
HEALBOT_OPTIONS_TAB_CHAT            = "Chat"
HEALBOT_OPTIONS_TAB_HEADERS         = "En-t\195\170tes"
HEALBOT_OPTIONS_TAB_BARS            = "Barres"
HEALBOT_OPTIONS_TAB_TEXT            = "Texte des barres"
HEALBOT_OPTIONS_TAB_ICONS           = "Ic\195\180nes"
HEALBOT_OPTIONS_SKINDEFAULTFOR      = "Skin par d\195\169faut pour"
HEALBOT_OPTIONS_INCHEAL             = "Heals entrants"
HEALBOT_WORD_ARENA                  = "Ar\195\170ne"
HEALBOT_WORD_BATTLEGROUND           = "Champ de bataille"
HEALBOT_OPTIONS_TEXTOPTIONS         = "Options de texte"
HEALBOT_WORD_PARTY                  = "Groupe"
HEALBOT_OPTIONS_COMBOAUTOTARGET     = "Cible Auto"
HEALBOT_OPTIONS_COMBOAUTOTRINKET    = "Trinket Auto"
HEALBOT_OPTIONS_GROUPSPERCOLUMN     = "Groupes (en-t\195\170tes) par colonne"

HEALBOT_OPTIONS_MAINSORT            = "Cl\195\169 principale"
HEALBOT_OPTIONS_SUBSORT             = "Cl\195\169 secondaire"
HEALBOT_OPTIONS_SUBSORTINC          = "Trier par cl\195\169 sec. :"

HEALBOT_OPTIONS_HEALCOMMMETHOD      = "Comm. Heal :"
HEALBOT_OPTIONS_HEALCOMMUSELHC      = "Activer libHealComm"
HEALBOT_OPTIONS_HEALCOMMLHCNOTFOUND = "libHealComm pas install\195\169"
HEALBOT_OPTIONS_HEALCOMMINTERNAL1   = "Pas de v\195\169rif. interne (pas de comm.)"
HEALBOT_OPTIONS_HEALCOMMINTERNAL2   = "V\195\169rif. interne des sorts (pas de comm.)"
HEALBOT_OPTIONS_HEALCOMMNOLHC       = "libHealComm n\'est pas charg\195\169\n\nCertains r\195\169glages de Heals de cet onglet ne sont pas utilis\195\169s"
HEALBOT_OPTIONS_HEALCOMMNOLHC2      = "libHealComm est charg\195\169 mais pas activ\195\169\nLa librairie envoie encore du spam sur la canal Addon\nPour le d\195\169sactiver\nvoir 'disable_libHealComm.html' (en anglais) dans le dossier Docs"

HEALBOT_OPTIONS_BUTTONCASTMETHOD    = "Incanter quand"
HEALBOT_OPTIONS_BUTTONCASTPRESSED   = "press\195\169"
HEALBOT_OPTIONS_BUTTONCASTRELEASED  = "relach\195\169"

HEALBOT_INFO_INCHEALINFO            = "== Informations sur les heal entrants =="
HEALBOT_INFO_ADDONCPUUSAGE          = "== Utilisation CPU en sec. =="
HEALBOT_INFO_ADDONCOMMUSAGE         = "== Comm. des addons =="
HEALBOT_WORD_HEALER                 = "Healer"
HEALBOT_WORD_VERSION                = "Version"
HEALBOT_WORD_CLIENT                 = "Client"
HEALBOT_WORD_ADDON                  = "Addon"
HEALBOT_INFO_CPUSECS                = "CPU Sec."
HEALBOT_INFO_MEMORYKB               = "M\195\169moire Ko"
HEALBOT_INFO_COMMS                  = "Comm. Ko"

HEALBOT_OPTIONS_HEALCOMMINTERNAL3   = "HB Comm. ultra basses - Pas de v\195\169rif."
HEALBOT_OPTIONS_HEALCOMMINTERNAL4   = "HB Comm. ultra basses - V\195\169rif. des sorts"

HEALBOT_WORD_STAR                   = "\195\169toile"
HEALBOT_WORD_CIRCLE                 = "cercle"
HEALBOT_WORD_DIAMOND                = "diamant"
HEALBOT_WORD_TRIANGLE               = "triangle"
HEALBOT_WORD_MOON                   = "lune"
HEALBOT_WORD_SQUARE                 = "carr\195\169"
HEALBOT_WORD_CROSS                  = "croix"
HEALBOT_WORD_SKULL                  = "cr\195\162ne"

HEALBOT_OPTIONS_ACCEPTSKINMSG       = "Accepter skin [HealBot] : "
HEALBOT_OPTIONS_ACCEPTSKINMSGFROM   = " de "
HEALBOT_OPTIONS_BUTTONSHARESKIN     = "Partager avec"

HEALBOT_CHAT_ADDONID                = "[HealBot]  "
HEALBOT_CHAT_NEWVERSION1            = "Une version plus r\195\169cente est disponible"
HEALBOT_CHAT_NEWVERSION2            = "sur http://healbot.alturl.com"
HEALBOT_CHAT_SHARESKINERR1          = " Skin pas trouv\195\169e pour le partage"
HEALBOT_CHAT_SHARESKINERR2          = " cette version de HealBot ne permet pas le partage de skins"
HEALBOT_CHAT_SHARESKINERR3          = " pas trouv\195\169e pour le partage de skin"
HEALBOT_CHAT_SHARESKINACPT          = "Partage de skin accept\195\169 de "
HEALBOT_CHAT_CONFIRMSKINDEFAULTS    = "Skins par d\195\169faut"
HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS  = "RaZ Debuffs personnalis\195\169s"
HEALBOT_CHAT_CHANGESKINERR1         = "Skin inconnu: /hb skin "
HEALBOT_CHAT_CHANGESKINERR2         = "Skins valides:  "
HEALBOT_CHAT_CONFIRMSPELLCOPY       = "Sort actuel copi\195\169 pour toutes les sp\195\169."
HEALBOT_CHAT_UNKNOWNCMD             = "Commande slash inconnue: /hb "
HEALBOT_CHAT_ENABLED                = "Entr\195\169e en mode combat"
HEALBOT_CHAT_DISABLED               = "Entr\195\169e en mode hors combat"
HEALBOT_CHAT_SOFTRELOAD             = "Reload healbot demand\195\169"
HEALBOT_CHAT_HARDRELOAD             = "Reload UI demand\195\169"
HEALBOT_CHAT_CONFIRMSPELLRESET      = "RaZ des sorts"
HEALBOT_CHAT_CONFIRMCURESRESET      = "RaZ des gu\195\169risons"
HEALBOT_CHAT_CONFIRMBUFFSRESET      = "RaZ des buffs"
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA   = "Impossible de recevoir les r\195\169glages de Skin - Possible absence de SharedMedia, voir HealBot/Docs/readme.html pour les liens"
HEALBOT_CHAT_MACROSOUNDON           = "Son pas supprim\195\169 \195\160 l\'utilisation auto d\'un trinket"
HEALBOT_CHAT_MACROSOUNDOFF          = "Son supprim\195\169 \195\160 l\'utilisation auto d\'un trinket"
HEALBOT_CHAT_MACROERRORON           = "Erreurs pas supprim\195\169es \195\160 l\'utilisation auto d\'un trinket"
HEALBOT_CHAT_MACROERROROFF          = "Erreurs supprim\195\169es \195\160 l\'utilisation auto d\'un trinket"
HEALBOT_CHAT_TITANON                = "Titan panel - MaJ on"
HEALBOT_CHAT_TITANOFF               = "Titan panel - MaJ off"
HEALBOT_CHAT_ACCEPTSKINON           = "Partage de skin actif - Afficher une fen\195\170tre de confirmation avant d'accepter un skin"
HEALBOT_CHAT_ACCEPTSKINOFF          = "Partage de Skin inactif - Ignorer les propositions de skin"
HEALBOT_CHAT_USE10ON                = "Trinket auto - Use10 est actif - Vous devez activer un auto trinket existant pour que use10 fonctionne"
HEALBOT_CHAT_USE10OFF               = "Trinket auto - Use10 est inactif"
HEALBOT_CHAT_SKINREC                = " skin re\195\167u de "

HEALBOT_OPTIONS_SELFCASTS           = "Seulement mes sorts"
HEALBOT_OPTIONS_HOTSHOWICON         = "Afficher ic\195\180ne"
HEALBOT_OPTIONS_ALLSPELLS           = "Tous les sorts"
HEALBOT_OPTIONS_DOUBLEROW           = "Sur deux lignes"
HEALBOT_OPTIONS_HOTBELOWBAR         = "Sous la barre"
HEALBOT_OPTIONS_OTHERSPELLS         = "Autres sorts"
HEALBOT_WORD_MACROS                 = "Macros"
HEALBOT_WORD_SELECT                 = "S\195\169lection"
HEALBOT_OPTIONS_QUESTION            = "?"
HEALBOT_WORD_CANCEL                 = "Annuler"
HEALBOT_WORD_COMMANDS               = "Commandes"
HEALBOT_OPTIONS_BARHEALTH3          = "pv totaux";
HEALBOT_SORTBY_ROLE                 = "R\195\180le"
HEALBOT_WORD_DPS                    = "DPS"
HEALBOT_CHAT_TOPROLEERR             = " r\195\180le non valide - utiliser 'TANK', 'DPS' ou 'HEALER'"
HEALBOT_CHAT_NEWTOPROLE             = "Le r\195\180le prioritaire est "
HEALBOT_CHAT_SUBSORTPLAYER1         = "Joueur en premier dans le sous-tri"
HEALBOT_CHAT_SUBSORTPLAYER2         = "Joueur tri\195\169 avec les autres"
HEALBOT_OPTIONS_SHOWREADYCHECK      = "Afficher l\'appel Raid";
HEALBOT_OPTIONS_SUBSORTSELFFIRST    = "Soi en premier"
HEALBOT_WORD_FILTER                 = "Filtre"
HEALBOT_OPTION_AGGROPCTBAR          = "Bouger la barre" ---- ??????????????????
HEALBOT_OPTION_AGGROPCTTXT          = "Aff. texte"
HEALBOT_OPTION_AGGROPCTTRACK        = "Suivre pourcent."
HEALBOT_OPTIONS_ALERTAGGROLEVEL0    = "0 - Menace faible et ne tanke rien"
HEALBOT_OPTIONS_ALERTAGGROLEVEL1    = "1 - Menace \195\169lev\195\169e et ne tanke rien"
HEALBOT_OPTIONS_ALERTAGGROLEVEL2    = "2 - Tanking pas assur\195\169, n\'a pas la menace la plus \195\169lev\195\169e sur le mob"
HEALBOT_OPTIONS_ALERTAGGROLEVEL3    = "3 - Tanking assur\195\169 sur au moins un mob"
HEALBOT_OPTIONS_AGGROALERT          = "Niveau d\'alerte d'aggro"
HEALBOT_OPTIONS_SETAGGROERROR1      = " Param\195\168tres invalides pour r\195\169gler l\'affichage de l\'aggro ..."
HEALBOT_OPTIONS_SETAGGRORESET       = " Reset des r\195\169glages de la barre d\'aggro"
HEALBOT_OPTIONS_SETAGGROERROR2      = " Echec du r\195\169glage opacit\195\169 mini de l\'aggro - Valeur de 0 \195\160 0.8"
HEALBOT_OPTIONS_SETAGGROERROR3      = " Echec du r\195\169glage opacit\195\169 mini de l\'aggro - Valeur Min > Max"
HEALBOT_OPTIONS_SETAGGROERROR4      = " Echec du r\195\169glage opacit\195\169 maxi de l\'aggro - Valeur de 0.2 \195\160 1"
HEALBOT_OPTIONS_SETAGGROERROR5      = " Echec du r\195\169glage opacit\195\169 maxi de l\'aggro - Valeur Max < Min"
HEALBOT_OPTIONS_SETAGGROMIN         = " Opacit\195\169 mini aggro r\195\169gl\195\169 \195\160 "
HEALBOT_OPTIONS_SETAGGROMAX         = " Opacit\195\169 maxi aggro r\195\169gl\195\169 \195\160 "
HEALBOT_OPTIONS_SETAGGROERROR6      = " Echec du r\195\169glage fr\195\169quence flash de l\'aggro - Valeur de 0.005 \195\160 0.2"
HEALBOT_OPTIONS_SETAGGROFLASH       = " Fr\195\169quence flash de l\'aggro r\195\169gl\195\169 \195\160 "
HEALBOT_OPTIONS_SETAGGROERROR7      = " Echec \195\169opacit\195\169 de l\'aggro - <What End> invalide.  Utiliser 'Min' ou 'Max'"
HEALBOT_OPTIONS_SETAGGROERROR8      = " Statut d\'aggro erronn\195\169 - utilser 'Low', 'High' ou 'Has'"
HEALBOT_OPTIONS_SETAGGROERROR9      = " Echec du r\195\169glage des couleurs d\'aggro - Bleu pas entre 0 et 1"
HEALBOT_OPTIONS_SETAGGROERROR10     = " Echec du r\195\169glage des couleurs d\'aggro - Vert pas entre 0 et 1"
HEALBOT_OPTIONS_SETAGGROERROR11     = " Echec du r\195\169glage des couleurs d\'aggro - Rouge pas entre 0 et 1"
HEALBOT_OPTIONS_SETAGGROCOL         = " Couleurs d\'aggro fix\195\169es \195\160 "
HEALBOT_OPTIONS_TOOLTIPSHOWHOT      = "Montrer les d\195\169tails des HoT suivis"
HEALBOT_OPTIONS_SETAGGROFLASHCUR    = " Aggro flash frequency="
HEALBOT_OPTIONS_SETAGGROALPHACUR    = " Aggro opacit\195\169 "
HEALBOT_OPTIONS_SETAGGROCOLLOW      = " Aggro coul. menace faible (1) "
HEALBOT_OPTIONS_SETAGGROCOLHIGH     = " Aggro coul. menace haute (2) "
HEALBOT_OPTIONS_SETAGGROCOLHAS      = " Aggro coul. a aggro (3) "
HEALBOT_WORDS_MIN                   = "min"
HEALBOT_WORDS_MAX                   = "max"
HEALBOT_WORDS_R                     = "R"
HEALBOT_WORDS_G                     = "G"
HEALBOT_WORDS_B                     = "B"
HEALBOT_OPTIONS_MAINASSIST          = "Main assist."
HEALBOT_CHAT_SELFPETSON             = "Auto Pet activ\195\169"
HEALBOT_CHAT_SELFPETSOFF            = "Auto Pet d\195\169sactiv\195\169"
HEALBOT_OPTIONS_TAB_WARNING = "Alerte"

HEALBOT_WORD_PRIORITY               = "Priorit\195\169"
HEALBOT_OPTIONS_CDCSHOWHBARS 		= "Colorer la barre de vie";
HEALBOT_OPTIONS_CDCSHOWABARS 		= "Colorer la barre d\'aggro";
HEALBOT_VISIBLE_RANGE               = "Dans les 100 yards"
HEALBOT_SPELL_RANGE                 = "A port\195\169e de sorts"

HEALBOT_CUSTOM_CATEGORY                 = "Cat\195\169gorie"
HEALBOT_CUSTOM_CAT_CUSTOM               = "Personnalis\195\169"
HEALBOT_CUSTOM_CAT_CLASSIC              = "Classique"
HEALBOT_CUSTOM_CAT_TBC_OTHER            = "BC - Autre"
HEALBOT_CUSTOM_CAT_TBC_BT               = "BC - Le temple noir"
HEALBOT_CUSTOM_CAT_TBC_SUNWELL          = "BC - Plateau du Puits de Soleil"
HEALBOT_CUSTOM_CAT_LK_OTHER             = "WotLK - Autre"
HEALBOT_CUSTOM_CAT_LK_ULDUAR            = "WotLK - Ulduar"
HEALBOT_CUSTOM_CAT_LK_TOC               = "WotLK - L\'Epreuve du crois\195\169"
HEALBOT_CUSTOM_CAT_LK_ICC_LOWER         = "WotLK - ICC L\'entr\195\169e de la citadelle"
HEALBOT_CUSTOM_CAT_LK_ICC_PLAGUEWORKS   = "WotLK - ICC La pesterie"
HEALBOT_CUSTOM_CAT_LK_ICC_CRIMSON       = "WotLK - ICC La salle cramoisie"
HEALBOT_CUSTOM_CAT_LK_ICC_FROSTWING     = "WotLK - ICC L\'aile de givre"
HEALBOT_CUSTOM_CAT_LK_ICC_THRONE        = "WotLK - ICC Le tr\195\180ne de glace"

HEALBOT_WORD_RESET                  = "R\195\160Z"
HEALBOT_HBMENU                      = "menuHB"

HEALBOT_ACTION_HBFOCUS              = "Bouton gauche\npour focus la cible"
HEALBOT_WORD_CLEAR                  = "Effacer"
HEALBOT_WORD_SET                    = "R\195\169gler"
HEALBOT_WORD_HBFOCUS                = "Focus HealBot"
HEALBOT_OPTIONS_TAB_ALERT           = "Alerte"
HEALBOT_OPTIONS_TAB_SORT            = "Tri"
HEALBOT_OPTIONS_TAB_AGGRO           = "Aggro"
HEALBOT_OPTIONS_TAB_ICONTEXT        = "Texte de l\'ic\195\180ne"
HEALBOT_OPTIONS_AGGROBARCOLS        = "Couleur des barres d\'aggro";
HEALBOT_OPTIONS_AGGRO1COL           = "Menace\n\195\169lev\195\169e"
HEALBOT_OPTIONS_AGGRO2COL           = "tanking\npas assur\195\169"
HEALBOT_OPTIONS_AGGRO3COL           = "tanking\nassur\195\169"
HEALBOT_OPTIONS_AGGROFLASHFREQ      = "Fr\195\169quence flash"
HEALBOT_OPTIONS_AGGROFLASHALPHA     = "Opacit\195\169 flash"
HEALBOT_OPTIONS_SHOWDURATIONFROM    = "Montrer la dur\195\169e de"
HEALBOT_OPTIONS_SHOWDURATIONWARN    = "Dur\195\169e de l\'alerte de"
HEALBOT_CMD_RESETCUSTOMDEBUFFS      = "R\195\160Z d\195\169buffs personnalis\195\169s"
HEALBOT_CMD_RESETSKINS              = "R\195\160Z skins"
HEALBOT_CMD_CLEARBLACKLIST          = "Effacer blackList"
HEALBOT_CMD_TOGGLEACCEPTSKINS       = "Bascule accepter Skins des autres"
HEALBOT_CMD_COPYSPELLS              = "Copier les sorts pour toutes les sp\195\169cialisations"
HEALBOT_CMD_RESETSPELLS             = "R\195\160Z sorts"
HEALBOT_CMD_RESETCURES              = "R\195\160Z gu\195\169risons"
HEALBOT_CMD_RESETBUFFS              = "R\195\160Z buffs"
HEALBOT_CMD_RESETBARS               = "R\195\160Z position des barres"
HEALBOT_CMD_TOGGLETITAN             = "Bascule M\195\160J Titan"
HEALBOT_CMD_SUPPRESSSOUND           = "Bascule son pour trinket auto"
HEALBOT_CMD_SUPPRESSERRORS          = "Bascule messages d\'erreurs pour trinket auto"
HEALBOT_OPTIONS_COMMANDS            = "Commandes HealBot"
HEALBOT_WORD_RUN                    = "Ex\195\169cuter"
HEALBOT_OPTIONS_MOUSEWHEEL          = "Activer les menus avec la roue de souris"
HEALBOT_CMD_DELCUSTOMDEBUFF10       = "Effacer les d\195\169buffs personnalis\195\169s de priorit\195\169 10"
HEALBOT_ACCEPTSKINS                 = "Accepter les Skins des autres joueurs"
HEALBOT_SUPPRESSSOUND               = "Auto Trinket : Supprimer le son"
HEALBOT_SUPPRESSERROR               = "Auto Trinket : Supprimer les erreurs"

HEALBOT_WORD_OTHER                  = "Autre"

HEALBOT_OPTIONS_CRASHPROT           = "Protection anti-Crash"
HEALBOT_CP_MACRO_LEN                = "Le nom de la macro doit avoir 1 \195\160 14 caract\195\168res"
HEALBOT_CP_MACRO_BASE               = "hbMacro"
HEALBOT_CP_MACRO_INFO               = "La protection anti-crash permet \195\160 HealBot de r\195\169cup\195\169rer d\'une d\195\169connection\nPour l\'utiliser vous DEVEZ avoir 5 macros sp\195\169cifiques disponibles."
HEALBOT_CP_MACRO_SAVE               = "Derni\195\168re sauvegarde: "
HEALBOT_CP_STARTTIME                = "Dur\195\169e de la protection \195\160 la connexion"

HEALBOT_WORD_RESERVED               = "R\195\169serv\195\169"
HEALBOT_OPTIONS_COMBATPROT          = "Protection en combat "
HEALBOT_COMBATPROT_INFO             = "Protection en combat permet \195\160 HealBot de prendre en compte les changements de groupes pendant un combat."
HEALBOT_COMBATPROT_PARTYNO          = "barres r\195\169serv\195\169es pour le groupe"
HEALBOT_COMBATPROT_RAIDNO           = "barres r\195\169serv\195\169es pour le raid"

end
