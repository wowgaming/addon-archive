------------
-- GERMAN --
------------

-- Ä = \195\132
-- Ö = \195\150
-- Ü = \195\156
-- ß = \195\159
-- ä = \195\164
-- ö = \195\182
-- ü = \195\188


if (GetLocale() == "deDE") then

-------------------
-- Compatibility --
-------------------

HEALBOT_DRUID   = "Druide";
HEALBOT_HUNTER  = "J\195\164ger";
HEALBOT_MAGE    = "Magier";
HEALBOT_PALADIN = "Paladin";
HEALBOT_PRIEST  = "Priester";
HEALBOT_ROGUE   = "Schurke";
HEALBOT_SHAMAN  = "Schamane";
HEALBOT_WARLOCK = "Hexenmeister";
HEALBOT_WARRIOR = "Krieger";
HEALBOT_DEATHKNIGHT = "Todesritter";

HEALBOT_HEAVY_NETHERWEAVE_BANDAGE = GetItemInfo(21991) or "Schwerer Netherstoffverband";
HEALBOT_HEAVY_RUNECLOTH_BANDAGE   = GetItemInfo(14530) or "Schwerer Runenstoffverband";
HEALBOT_MAJOR_HEALING_POTION      = GetItemInfo(13446) or "Erheblicher Heiltrank";
HEALBOT_PURIFICATION_POTION       = GetItemInfo(13462) or "L\195\164uterungstrank";
HEALBOT_ANTI_VENOM                = GetItemInfo(6452) or "Gegengift";
HEALBOT_POWERFUL_ANTI_VENOM       = GetItemInfo(19440) or "M\195\164chtiges Gegengift";
HEALBOT_ELIXIR_OF_POISON_RES      = GetItemInfo(3386) or "Elixier des Giftwiderstands";

HEALBOT_FLASH_HEAL          = GetSpellInfo(2061) or "Blitzheilung";
HEALBOT_FLASH_OF_LIGHT      = GetSpellInfo(19750) or "Lichtblitz";
HEALBOT_GREATER_HEAL        = GetSpellInfo(2060) or "Gro\195\159e Heilung";
HEALBOT_BINDING_HEAL        = GetSpellInfo(32546) or "Verbindende Heilung";
HEALBOT_PENANCE             = GetSpellInfo(47540) or "S\195\188hne"
HEALBOT_PRAYER_OF_MENDING   = GetSpellInfo(33076) or "Gebet der Besserung";
HEALBOT_HEALING_TOUCH       = GetSpellInfo(5185) or "Heilende Ber\195\188hrung";
HEALBOT_HEAL                = GetSpellInfo(2054) or "Heilen";
HEALBOT_HEALING_WAVE        = GetSpellInfo(331) or "Welle der Heilung";
HEALBOT_RIPTIDE             = GetSpellInfo(61295) or "Springflut";
HEALBOT_HEALING_WAY         = GetSpellInfo(29206) or "Pfad der Heilung";
HEALBOT_HOLY_LIGHT          = GetSpellInfo(635) or "Heiliges Licht";
HEALBOT_LESSER_HEAL         = GetSpellInfo(2050) or "Geringes Heilen";
HEALBOT_LESSER_HEALING_WAVE = GetSpellInfo(8004) or "Geringe Welle der Heilung";
HEALBOT_POWER_WORD_SHIELD   = GetSpellInfo(17) or "Machtwort: Schild";
HEALBOT_REGROWTH            = GetSpellInfo(8936) or "Nachwachsen";
HEALBOT_RENEW               = GetSpellInfo(139) or "Erneuerung";
HEALBOT_REJUVENATION        = GetSpellInfo(774) or "Verj\195\188ngung";
HEALBOT_LIFEBLOOM           = GetSpellInfo(33763) or "Bl\195\188hendes Leben";
HEALBOT_WILD_GROWTH         = GetSpellInfo(48438) or "Wildwuchs"
HEALBOT_REVIVE              = GetSpellInfo(50769) or "Wiederbelebung";
HEALBOT_TRANQUILITY         = GetSpellInfo(740) or "Gelassenheit";
HEALBOT_SWIFTMEND           = GetSpellInfo(18562) or "Rasche Heilung";
HEALBOT_PRAYER_OF_HEALING   = GetSpellInfo(596) or "Gebet der Heilung";
HEALBOT_CHAIN_HEAL          = GetSpellInfo(1064) or "Kettenheilung";
HEALBOT_NOURISH             = GetSpellInfo(50464) or "Pflege";


HEALBOT_PAIN_SUPPRESSION      = GetSpellInfo(33206) or "Schmerzunterdr\195\188ckung";
HEALBOT_POWER_INFUSION        = GetSpellInfo(10060) or "Seele der Macht";
HEALBOT_POWER_WORD_FORTITUDE  = GetSpellInfo(1243) or "Machtwort: Seelenst\195\164rke";
HEALBOT_PRAYER_OF_FORTITUDE   = GetSpellInfo(21562) or "Gebet der Seelenst\195\164rke";
HEALBOT_DIVINE_SPIRIT         = GetSpellInfo(14752) or "G\195\182ttlicher Wille";
HEALBOT_PRAYER_OF_SPIRIT      = GetSpellInfo(27681) or "Gebet der Willenskraft";
HEALBOT_SHADOW_PROTECTION     = GetSpellInfo(976) or "Schattenschutz";
HEALBOT_PRAYER_OF_SHADOW_PROTECTION = GetSpellInfo(27683) or "Gebet des Schattenschutzes";
HEALBOT_INNER_FIRE            = GetSpellInfo(588) or "Inneres Feuer";
HEALBOT_SHADOWFORM            = GetSpellInfo(15473) or "Schattenform"
HEALBOT_INNER_FOCUS           = GetSpellInfo(14751) or "Innerer Fokus";
HEALBOT_TWIN_DISCIPLINES      = GetSpellInfo(47586) or "Zwillingsdisziplinen";
HEALBOT_SPIRITAL_HEALING      = GetSpellInfo(14898) or "Spirituelle Heilung";
HEALBOT_EMPOWERED_HEALING     = GetSpellInfo(33158) or "Machtvolle Heilung";
HEALBOT_DIVINE_PROVIDENCE     = GetSpellInfo(47562) or "G\195\182ttliche Vorsehung";
HEALBOT_IMPROVED_RENEW        = GetSpellInfo(14908) or "Verbesserte Erneuerung";
HEALBOT_FOCUSED_POWER         = GetSpellInfo(33186) or "Fokussierte Macht";
HEALBOT_GENESIS               = GetSpellInfo(57810) or "Genesis";
HEALBOT_NURTURING_INSTINCT    = GetSpellInfo(33872) or "Besch\195\188tzerinstinkt";
HEALBOT_IMPROVED_REJUVENATION = GetSpellInfo(17111) or "Verbesserte Verj\195\188ngung";
HEALBOT_GIFT_OF_NATURE        = GetSpellInfo(17104) or "Geschenk der Natur";
HEALBOT_EMPOWERED_TOUCH       = GetSpellInfo(33879) or "Machtvolle Ber\195\188hrung";
HEALBOT_EMPOWERED_REJUVENATION = GetSpellInfo(33886) or "Machtvolle Verj\195\188ngung";
HEALBOT_HEALING_LIGHT         = GetSpellInfo(20237) or "Heilendes Licht";
HEALBOT_PURIFICATION          = GetSpellInfo(16178) or "L\195\164uterung";
HEALBOT_IMPROVED_CHAIN_HEAL   = GetSpellInfo(30872) or "Verbesserte Kettenheilung";
HEALBOT_NATURES_BLESSING      = GetSpellInfo(30867) or "Segen der Natur";
HEALBOT_FEAR_WARD             = GetSpellInfo(6346) or "Furchtzauberschutz";
HEALBOT_ARCANE_INTELLECT      = GetSpellInfo(1459) or "Arkane Intelligenz";
HEALBOT_ARCANE_BRILLIANCE     = GetSpellInfo(23028) or "Arkane Brillanz";
HEALBOT_DALARAN_INTELLECT     = GetSpellInfo(61024) or "Dalaran Intelligenz";
HEALBOT_DALARAN_BRILLIANCE    = GetSpellInfo(61316) or "Dalaran Brillianz";
HEALBOT_FROST_ARMOR           = GetSpellInfo(168) or "Frostr\195\188stung";
HEALBOT_ICE_ARMOR             = GetSpellInfo(7302) or "Eisr\195\188stung";
HEALBOT_MAGE_ARMOR            = GetSpellInfo(6117) or "Magische R\195\188stung";
HEALBOT_MOLTEN_ARMOR          = GetSpellInfo(30482) or "Gl\195\188hende R\195\188stung";
HEALBOT_DEMON_ARMOR           = GetSpellInfo(706) or "D\195\164monenr\195\188stung";
HEALBOT_DEMON_SKIN            = GetSpellInfo(687) or "D\195\164monenhaut";
HEALBOT_FEL_ARMOR             = GetSpellInfo(28176) or "Teufelsr\195\188stung";   
HEALBOT_DAMPEN_MAGIC          = GetSpellInfo(604) or "Magie d\195\164mpfen";
HEALBOT_AMPLIFY_MAGIC         = GetSpellInfo(1008) or "Magie verst\195\164rken";
HEALBOT_DETECT_INV            = GetSpellInfo(132) or "Unsichtbarkeit entdecken";
HEALBOT_FOCUS_MAGIC           = GetSpellInfo(54646) or "Magie fokussieren";

HEALBOT_LIGHTNING_SHIELD      = GetSpellInfo(324) or "Blitzschlagschild";    
HEALBOT_ROCKBITER_WEAPON      = GetSpellInfo(8017) or "Waffe des Felsbei\195\159ers";    
HEALBOT_FLAMETONGUE_WEAPON    = GetSpellInfo(8024) or "Waffe der Flammenzunge";    
HEALBOT_EARTHLIVING_WEAPON    = GetSpellInfo(51730) or "Waffe der Lebensgeister"
HEALBOT_WINDFURY_WEAPON       = GetSpellInfo(8232) or "Waffe des Windzorns";
HEALBOT_FROSTBRAND_WEAPON     = GetSpellInfo(8033) or "Waffe des Frostbrands";     
HEALBOT_EARTH_SHIELD          = GetSpellInfo(974) or "Erdschild";              
HEALBOT_WATER_SHIELD          = GetSpellInfo(52127) or "Wasserschild";              

HEALBOT_MARK_OF_THE_WILD      = GetSpellInfo(1126) or "Mal der Wildnis";
HEALBOT_GIFT_OF_THE_WILD      = GetSpellInfo(21849) or "Gabe der Wildnis";
HEALBOT_THORNS                = GetSpellInfo(467) or "Dornen";
HEALBOT_OMEN_OF_CLARITY       = GetSpellInfo(16864) or "Omen der Klarsicht";

HEALBOT_BEACON_OF_LIGHT         = GetSpellInfo(53563) or "Flamme des Glaubens";
HEALBOT_LIGHT_BEACON            = GetSpellInfo(53651);
HEALBOT_SACRED_SHIELD           = GetSpellInfo(53601) or "Geheiligter Schild";
HEALBOT_SHEATH_OF_LIGHT         = GetSpellInfo(53501) or "Glaubensflamme";
HEALBOT_BLESSING_OF_MIGHT       = GetSpellInfo(19740) or "Segen der Macht";
HEALBOT_BLESSING_OF_WISDOM      = GetSpellInfo(19742) or "Segen der Weisheit";
HEALBOT_BLESSING_OF_SANCTUARY   = GetSpellInfo(20911) or "Segen des Refugiums";
HEALBOT_BLESSING_OF_PROTECTION  = GetSpellInfo(41450) or "Segen des Schutzes";
HEALBOT_BLESSING_OF_KINGS       = GetSpellInfo(20217) or "Segen der K\195\182nige";
HEALBOT_GREATER_BLESSING_OF_MIGHT     = GetSpellInfo(25782) or "Gro\195\159er Segen der Macht";
HEALBOT_GREATER_BLESSING_OF_WISDOM    = GetSpellInfo(25894) or "Gro\195\159er Segen der Weisheit";
HEALBOT_GREATER_BLESSING_OF_KINGS     = GetSpellInfo(25898) or "Gro\195\159er Segen der K\195\182nige";
HEALBOT_GREATER_BLESSING_OF_SANCTUARY = GetSpellInfo(25899) or "Gro\195\159er Segen des Refugiums";
HEALBOT_SEAL_OF_RIGHTEOUSNESS   = GetSpellInfo(21084) or "Siegel des Rechtschaffenden"
HEALBOT_SEAL_OF_BLOOD           = GetSpellInfo(31892) or "Siegel des Blutes"
HEALBOT_SEAL_OF_CORRUPTION      = GetSpellInfo(53736) or "Siegel der Verderbnis"
HEALBOT_SEAL_OF_JUSTICE         = GetSpellInfo(20164) or "Siegel der Gerechtigkeit"
HEALBOT_SEAL_OF_LIGHT           = GetSpellInfo(20165) or "Siegel des Lichts"
HEALBOT_SEAL_OF_VENGEANCE       = GetSpellInfo(31801) or "Siegel der Vergeltung"
HEALBOT_SEAL_OF_WISDOM          = GetSpellInfo(20166) or "Siegel der Weisheit"
HEALBOT_SEAL_OF_COMMAND         = GetSpellInfo(20375) or "Siegel des Befehls"
HEALBOT_SEAL_OF_THE_MARTYR      = GetSpellInfo(53720) or "Siegel des M\195\164rtyrers"
HEALBOT_HAND_OF_FREEDOM         = GetSpellInfo(1044) or "Segen der Freiheit"
HEALBOT_HAND_OF_PROTECTION      = GetSpellInfo(1022) or "Segen des Schutzes"
HEALBOT_HAND_OF_SACRIFICE       = GetSpellInfo(6940) or "Segen der Opferung"
HEALBOT_HAND_OF_SALVATION       = GetSpellInfo(1038) or "Segen der Rettung"
HEALBOT_RIGHTEOUS_FURY          = GetSpellInfo(25780) or "Zorn der Gerechtigkeit"; 
HEALBOT_DEVOTION_AURA           = GetSpellInfo(465) or "Aura der Hingabe"; 
HEALBOT_RETRIBUTION_AURA        = GetSpellInfo(7294) or "Aura der Vergeltung"; 
HEALBOT_CONCENTRATION_AURA      = GetSpellInfo(19746) or "Aura der Konzentration"; 
HEALBOT_SHR_AURA                = GetSpellInfo(19876) or "Aura des Schattenwiderstands"; 
HEALBOT_FRR_AURA                = GetSpellInfo(19888) or "Aura des Frostwiderstands"; 
HEALBOT_FIR_AURA                = GetSpellInfo(19891) or "Aura des Feuerwiderstands"; 
HEALBOT_CRUSADER_AURA           = GetSpellInfo(32223) or "Aura des Kreuzfahrers"; 


HEALBOT_A_MONKEY      = GetSpellInfo(13163) or "Aspekt des Affen"; 
HEALBOT_A_HAWK        = GetSpellInfo(13165) or "Aspekt des Falken"; 
HEALBOT_A_CHEETAH     = GetSpellInfo(5118) or "Aspekt des Geparden"; 
HEALBOT_A_BEAST       = GetSpellInfo(13161) or "Aspekt des Wildtiers"; 
HEALBOT_A_PACK        = GetSpellInfo(13159) or "Aspekt des Rudels"; 
HEALBOT_A_WILD        = GetSpellInfo(20043) or "Aspekt der Wildniss"; 
HEALBOT_A_VIPER       = GetSpellInfo(34074) or "Aspekt der Viper";
HEALBOT_A_DRAGONHAWK  = GetSpellInfo(61846) or "Aspekt des Drachenfalken"
HEALBOT_MENDPET       = GetSpellInfo(136) or "Tier heilen";

HEALBOT_UNENDING_BREATH     = GetSpellInfo(5697) or "Unendlicher Atem"

HEALBOT_RESURRECTION        = GetSpellInfo(2006) or "Auferstehung";
HEALBOT_REDEMPTION          = GetSpellInfo(7328) or "Erl\195\182sung";
HEALBOT_REBIRTH             = GetSpellInfo(20484) or "Wiedergeburt";
HEALBOT_ANCESTRALSPIRIT     = GetSpellInfo(2008) or "Geist der Ahnen";

HEALBOT_PURIFY             = GetSpellInfo(1152) or "L\195\164utern";
HEALBOT_CLEANSE            = GetSpellInfo(4987) or "Reinigung des Glaubens";
HEALBOT_CURE_POISON        = GetSpellInfo(8946) or "Vergiftung heilen";
HEALBOT_REMOVE_CURSE       = GetSpellInfo(2782) or "Fluch aufheben"; 
HEALBOT_CURE_TOXINS        = GetSpellInfo(526) or "Toxine heilen"
HEALBOT_ABOLISH_POISON     = GetSpellInfo(2893) or "Vergiftung aufheben";
HEALBOT_CURE_DISEASE       = GetSpellInfo(528) or "Krankheit heilen";
HEALBOT_ABOLISH_DISEASE    = GetSpellInfo(552) or "Krankheit aufheben";
HEALBOT_DISPEL_MAGIC       = GetSpellInfo(527) or "Magiebannung";
HEALBOT_CLEANSE_SPIRIT	   = GetSpellInfo(51886) or "Geistl\195\164uterung";
HEALBOT_DISEASE            = "Krankheit";   
HEALBOT_MAGIC              = "Magie";
HEALBOT_CURSE              = "Fluch";   
HEALBOT_POISON             = "Gift";
HEALBOT_DISEASE_en         = "Disease";  -- Do NOT localize this value.
HEALBOT_MAGIC_en           = "Magic";  -- Do NOT localize this value.
HEALBOT_CURSE_en           = "Curse";  -- Do NOT localize this value.
HEALBOT_POISON_en          = "Poison";  -- Do NOT localize this value.
HEALBOT_CUSTOM_en          = "Custom";  -- Do NOT localize this value. 

HEALBOT_DEBUFF_ANCIENT_HYSTERIA = "Uralte Hysterie";
HEALBOT_DEBUFF_IGNITE_MANA      = "Mana entz\195\188nden";
HEALBOT_DEBUFF_TAINTED_MIND     = "Besudelte Gedanken";
HEALBOT_DEBUFF_VIPER_STING      = "Vipernbiss";
HEALBOT_DEBUFF_SILENCE          = "Stille";
HEALBOT_DEBUFF_MAGMA_SHACKLES   = "Magmafesseln";
HEALBOT_DEBUFF_FROSTBOLT        = "Frostblitz";
HEALBOT_DEBUFF_HUNTERS_MARK     = "Mal des J\195\164gers";
HEALBOT_DEBUFF_SLOW             = "Verlangsamen";
HEALBOT_DEBUFF_ARCANE_BLAST     = "Arkanschlag";
HEALBOT_DEBUFF_IMPOTENCE        = "Fluch der Machtlosigkeit";
HEALBOT_DEBUFF_DECAYED_STR      = "Verfallene St\195\164rke";
HEALBOT_DEBUFF_DECAYED_INT      = "Verfallene Intelligenz";
HEALBOT_DEBUFF_CRIPPLE          = "Verkr\195\188ppeln";
HEALBOT_DEBUFF_CHILLED          = "K\195\164lte";
HEALBOT_DEBUFF_CONEOFCOLD       = "K\195\164ltekegel";
HEALBOT_DEBUFF_CONCUSSIVESHOT   = "Ersch\195\188tternder Schuss";
HEALBOT_DEBUFF_THUNDERCLAP      = "Donnerknall";         
HEALBOT_DEBUFF_HOWLINGSCREECH  = "Heulender Schrei";
HEALBOT_DEBUFF_DAZED            = "Benommen";
HEALBOT_DEBUFF_UNSTABLE_AFFL    = "Instabiles Gebrechen";
HEALBOT_DEBUFF_DREAMLESS_SLEEP  = "Traumloser Schlaf";
HEALBOT_DEBUFF_GREATER_DREAMLESS = "Gro\195\159er traumloser Schlaf";
HEALBOT_DEBUFF_MAJOR_DREAMLESS  = "\195\156berragender traumloser Schlaf";
HEALBOT_DEBUFF_FROST_SHOCK      = "Frostschock";
HEALBOT_DEBUFF_WEAKENED_SOUL    = GetSpellInfo(6788)

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

HB_SPELL_PATTERN_LESSER_HEAL         = "Euer Ziel um (%d+) bis (%d+)";
HB_SPELL_PATTERN_HEAL                = "Euer Ziel um (%d+) bis (%d+)";
HB_SPELL_PATTERN_GREATER_HEAL        = "Ein langsam zu wirkender Zauber, der ein einzelnes Ziel um (%d+) bis (%d+)";
HB_SPELL_PATTERN_FLASH_HEAL          = "Heilt das Ziel um (%d+) bis (%d+)";
HB_SPELL_PATTERN_RENEW1              = "Heilt das Ziel um (%d+) bis (%d+) \195\188ber (%d+) Sek.";
HB_SPELL_PATTERN_RENEW               = "Heilt das Ziel um (%d+) \195\188ber (%d+) Sek.";
HB_SPELL_PATTERN_RENEW2              = "Heilt das Ziel (%d+) Sek. lang um (%d+) bis (%d+) Schaden";
HB_SPELL_PATTERN_RENEW3              = "Heilt das Ziel (%d+) Sek. lang um (%d+) Schaden";
HB_SPELL_PATTERN_SHIELD              = "absorbiert dabei (%d+) Punkt%(e%) Schaden. H\195\164lt (%d+) Sek";
HB_SPELL_PATTERN_HEALING_TOUCH       = "Heilt ein befreundetes Ziel um (%d+) bis (%d+)";
HB_SPELL_PATTERN_REGROWTH            = "Heilt ein befreundetes Ziel um (%d+) bis (%d+) und \195\188ber (%d+) Sek%. um weitere (%d+)";
HB_SPELL_PATTERN_REGROWTH1           = "Heilt ein befreundetes Ziel um (%d+) bis (%d+) und \195\188ber (%d+) Sek%. um weitere (%d+) bis (%d+)";
HB_SPELL_PATTERN_HOLY_LIGHT          = "Heilt ein befreundetes Ziel um (%d+) bis (%d+)";
HB_SPELL_PATTERN_FLASH_OF_LIGHT      = "Heilt ein befreundetes Ziel um (%d+) bis (%d+)";
HB_SPELL_PATTERN_HEALING_WAVE        = "Heilt ein befreundetes Ziel um (%d+) bis (%d+)";
HB_SPELL_PATTERN_LESSER_HEALING_WAVE = "Heilt ein befreundetes Ziel um (%d+) bis (%d+)";
HB_SPELL_PATTERN_REJUVENATION        = "Heilt das Ziel von (%d+) \195\188ber (%d+) Sek";
HB_SPELL_PATTERN_REJUVENATION1       = "Heilt das Ziel von (%d+) bis (%d+) \195\188ber (%d+) Sek";
HB_SPELL_PATTERN_REJUVENATION2       = "Heilt beim Ziel (%d+) Sek. lang (%d+)";
HB_SPELL_PATTERN_MEND_PET            = "Heilt Euer Tier um (%d+) jede Sekunde (%d+) Sek. lang";

HB_TOOLTIP_MANA                      = "^(%d+) Mana$";
HB_TOOLTIP_RANGE                     = "(%d+) m";
HB_TOOLTIP_INSTANT_CAST              = "Spontanzauber";
HB_TOOLTIP_CAST_TIME                 = "(%d+.?%d*) Sek";
HB_TOOLTIP_CHANNELED                 = "Abgebrochen"; 
HB_TOOLTIP_OFFLINE                 = "Offline";
HB_OFFLINE                			   = "offline"; -- has gone offline msg
HB_ONLINE                				   = "online"; -- has come online msg
HB_HASLEFTRAID                       = "^([^%s]+) hat den Schlachtzug verlassen%.$";
HB_HASLEFTPARTY                      = "^([^%s]+) hat die Gruppe verlassen"; 
HB_YOULEAVETHEGROUP                  = "Ihr habt die Gruppe verlassen";  
HB_YOULEAVETHERAID                   = "Ihr habt den Schlachtzug verlassen"; 
HB_YOUJOINTHERAID                    = "Ihr seit dem Schlachtzug beigetreten";
HB_YOUJOINTHEGROUP                   = "Ihr seit der Gruppe beigetreten";

-----------------
-- Translation --
-----------------

HEALBOT_ADDON = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED = " geladen.";

HEALBOT_ACTION_OPTIONS    = "Optionen";

HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS      = "Defaults";
HEALBOT_OPTIONS_CLOSE         = "Schlie\195\159en";
HEALBOT_OPTIONS_HARDRESET     = "ReloadUI"
HEALBOT_OPTIONS_SOFTRESET     = "ResetHB"
HEALBOT_OPTIONS_INFO          = "Info"
HEALBOT_OPTIONS_TAB_GENERAL   = "Allg.";
HEALBOT_OPTIONS_TAB_SPELLS    = "Spr\195\188che";  
HEALBOT_OPTIONS_TAB_HEALING   = "Heilung";
HEALBOT_OPTIONS_TAB_CDC       = "Debuffs";  
HEALBOT_OPTIONS_TAB_SKIN      = "Skin";   
HEALBOT_OPTIONS_TAB_TIPS      = "Tips";
HEALBOT_OPTIONS_TAB_BUFFS     = "Buffs";

HEALBOT_OPTIONS_PANEL_TEXT    = "Heilungspanel Optionen:";
HEALBOT_OPTIONS_BARALPHA      = "Balken Transparenz";
HEALBOT_OPTIONS_BARALPHAINHEAL = "Ankomm.Heilung Transparenz";
HEALBOT_OPTIONS_BARALPHAEOR   = "Trasparenz wenn au\195\159er Reichweite";
HEALBOT_OPTIONS_ACTIONLOCKED  = "Fenster fixieren";
HEALBOT_OPTIONS_AUTOSHOW      = "Automatisch \195\182ffnen";
HEALBOT_OPTIONS_PANELSOUNDS   = "Sound beim \195\150ffnen";
HEALBOT_OPTIONS_HIDEOPTIONS   = "Kein Optionen-Knopf";
HEALBOT_OPTIONS_PROTECTPVP    = "Vermeidung des PvP Flags";
HEALBOT_OPTIONS_HEAL_CHATOPT  = "Chat-Optionen";

HEALBOT_OPTIONS_SKINTEXT      = "Benutze Skin";  
HEALBOT_SKINS_STD             = "Standard";
HEALBOT_OPTIONS_SKINTEXTURE   = "Textur";  
HEALBOT_OPTIONS_SKINHEIGHT    = "H\195\182he";  
HEALBOT_OPTIONS_SKINWIDTH     = "Breite";   
HEALBOT_OPTIONS_SKINNUMCOLS   = "Anzahl Spalten";  
HEALBOT_OPTIONS_SKINNUMHCOLS  = "Anzahl Gruppen pro Spalte";
HEALBOT_OPTIONS_SKINBRSPACE   = "Reihenabstand";   
HEALBOT_OPTIONS_SKINBCSPACE   = "Spaltenabstand";  
HEALBOT_OPTIONS_EXTRASORT     = "Sort. Extrabalken nach";  
HEALBOT_SORTBY_NAME           = "Name";  
HEALBOT_SORTBY_CLASS          = "Klasse";  
HEALBOT_SORTBY_GROUP          = "Gruppe";
HEALBOT_SORTBY_MAXHEALTH      = "Max. Leben";
HEALBOT_OPTIONS_NEWDEBUFFTEXT = "Neuer Debuff"   
HEALBOT_OPTIONS_DELSKIN       = "L\195\182schen"; 
HEALBOT_OPTIONS_NEWSKINTEXT   = "Neuer Skin";   
HEALBOT_OPTIONS_SAVESKIN      = "Speichern";  
HEALBOT_OPTIONS_SKINBARS      = "Balken-Optionen";   
HEALBOT_OPTIONS_SKINPANEL     = "Panel-Farben";   
HEALBOT_SKIN_ENTEXT           = "Aktiv";   
HEALBOT_SKIN_DISTEXT          = "Inaktiv";   
HEALBOT_SKIN_DEBTEXT          = "Debuff";   
HEALBOT_SKIN_BACKTEXT         = "Hintergrund"; 
HEALBOT_SKIN_BORDERTEXT       = "Rand"; 
HEALBOT_OPTIONS_SKINFONT      = "Font"
HEALBOT_OPTIONS_SKINFHEIGHT   = "Schriftgr\195\182\195\159e";
HEALBOT_OPTIONS_BARALPHADIS   = "Inaktiv-Transparenz";
HEALBOT_OPTIONS_SHOWHEADERS   = "Zeige \195\156berschriften";

HEALBOT_OPTIONS_ITEMS  = "Gegenst\195\164nde";
HEALBOT_OPTIONS_SPELLS = "Spr\195\188che";

HEALBOT_OPTIONS_COMBOCLASS    = "Tastenkombinationen f\195\188r";
HEALBOT_OPTIONS_CLICK         = "Klick";
HEALBOT_OPTIONS_SHIFT         = "Shift";
HEALBOT_OPTIONS_CTRL          = "Strg";
HEALBOT_OPTIONS_ENABLEHEALTHY = "Auch unverletzte Ziele heilen";

HEALBOT_OPTIONS_CASTNOTIFY1   = "Keine Benachrichtigungen";
HEALBOT_OPTIONS_CASTNOTIFY2   = "Nachricht an mich selbst";
HEALBOT_OPTIONS_CASTNOTIFY3   = "Nachricht ans Ziel";
HEALBOT_OPTIONS_CASTNOTIFY4   = "Nachricht an die Gruppe";
HEALBOT_OPTIONS_CASTNOTIFY5   = "Nachricht an den Raid ";
HEALBOT_OPTIONS_CASTNOTIFY6   = "Channel";
HEALBOT_OPTIONS_CASTNOTIFYRESONLY = "Benachrichtigung nur bei Wiederbelebung";
HEALBOT_OPTIONS_TARGETWHISPER = "Ziel bei Heilung anfl\195\188stern";

HEALBOT_OPTIONS_CDCBARS       = "Balkenfarben";   
HEALBOT_OPTIONS_CDCSHOWHBARS  = "Zeige auf Gesundheitsbalken";
HEALBOT_OPTIONS_CDCSHOWABARS  = "Zeige auf Aggrobalken";
HEALBOT_OPTIONS_CDCCLASS      = "\195\156berwache Klasse"; 
HEALBOT_OPTIONS_CDCWARNINGS   = "Warnung bei Debuffs";
HEALBOT_OPTIONS_SHOWDEBUFFICON = "Zeige Debuff-Icon";
HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "Zeige Warnung bei Debuff";
HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "Spiele Ton bei Debuff"; 
HEALBOT_OPTIONS_SOUND         = "Ton";  
HEALBOT_OPTIONS_SOUND1        = "Ton 1";  
HEALBOT_OPTIONS_SOUND2        = "Ton 2";  
HEALBOT_OPTIONS_SOUND3        = "Ton 3"; 

HEALBOT_OPTIONS_HEAL_BUTTONS  = "Heilungsbalken f\195\188r";
HEALBOT_OPTIONS_SELFHEALS     = "Selbst";
HEALBOT_OPTIONS_PETHEALS      = "Begleiter";
HEALBOT_OPTIONS_GROUPHEALS    = "Gruppe";
HEALBOT_OPTIONS_TANKHEALS     = "Maintanks";
HEALBOT_OPTIONS_PRIVATETANKS  = "Eigene Maintanks";
HEALBOT_OPTIONS_TARGETHEALS   = "Ziele";
HEALBOT_OPTIONS_EMERGENCYHEALS= "Raid";
HEALBOT_OPTIONS_ALERTLEVEL    = "Alarmstufe";
HEALBOT_OPTIONS_EMERGFILTER   = "Notfall-Optionen f\195\188r";
HEALBOT_OPTIONS_EMERGFCLASS   = "Klassenauswahl nach";
HEALBOT_OPTIONS_COMBOBUTTON   = "Maustaste";  
HEALBOT_OPTIONS_BUTTONLEFT    = "Links";  
HEALBOT_OPTIONS_BUTTONMIDDLE  = "Mitte";  
HEALBOT_OPTIONS_BUTTONRIGHT   = "Rechts"; 
HEALBOT_OPTIONS_BUTTON4       = "Taste4";  
HEALBOT_OPTIONS_BUTTON5       = "Taste5";  
HEALBOT_OPTIONS_BUTTON6       = "Taste6";
HEALBOT_OPTIONS_BUTTON7       = "Taste7";
HEALBOT_OPTIONS_BUTTON8       = "Taste8";
HEALBOT_OPTIONS_BUTTON9       = "Taste9";
HEALBOT_OPTIONS_BUTTON10      = "Taste10";
HEALBOT_OPTIONS_BUTTON11      = "Taste11";
HEALBOT_OPTIONS_BUTTON12      = "Taste12";
HEALBOT_OPTIONS_BUTTON13      = "Taste13";
HEALBOT_OPTIONS_BUTTON14      = "Taste14";
HEALBOT_OPTIONS_BUTTON15      = "Taste15";

HEALBOT_CLASSES_ALL     = "Alle Klassen";
HEALBOT_CLASSES_MELEE   = "Nahkampf";
HEALBOT_CLASSES_RANGES  = "Fernkampf";
HEALBOT_CLASSES_HEALERS = "Heiler";
HEALBOT_CLASSES_CUSTOM  = "Pers\195\182nlich";

HEALBOT_OPTIONS_SHOWTOOLTIP     = "Zeige Tooltips"; 
HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "Zeige detaillierte Spruchinfos";
HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "Zeige Zielinfos";  
HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "Zeige empf. Sofortzauber";
HEALBOT_OPTIONS_SHOWPDCTOOLTIP  = "Zeige vordefinierte Combos";
HEALBOT_TOOLTIP_POSDEFAULT      = "Standardposition";  
HEALBOT_TOOLTIP_POSLEFT         = "Links von Healbot";  
HEALBOT_TOOLTIP_POSRIGHT        = "Rechts von Healbot";   
HEALBOT_TOOLTIP_POSABOVE        = "\195\156ber Healbot";  
HEALBOT_TOOLTIP_POSBELOW        = "Unter Healbot";   
HEALBOT_TOOLTIP_POSCURSOR       = "Neben Mauszeiger";
HEALBOT_TOOLTIP_RECOMMENDTEXT   = "Sofortzauber-Empfehlung";
HEALBOT_TOOLTIP_NONE            = "nicht verf\195\188gbar";
HEALBOT_TOOLTIP_ITEMBONUS       = "Item-Bonus";
HEALBOT_TOOLTIP_ACTUALBONUS     = "Aktueller Bonus ist";
HEALBOT_TOOLTIP_SHIELD          = "Absorbiert";
HEALBOT_TOOLTIP_LOCATION        = "Position";
HEALBOT_TOOLTIP_CORPSE          = "Leichnam von "
HEALBOT_WORDS_OVER              = "\195\188ber";
HEALBOT_WORDS_SEC               = "Sek";
HEALBOT_WORDS_TO                = "bis";
HEALBOT_WORDS_CAST              = "Zauber";
HEALBOT_WORDS_FOR               = "f\195\188r";
HEALBOT_WORDS_UNKNOWN           = "Unbekannt";
HEALBOT_WORDS_YES               = "Ja";
HEALBOT_WORDS_NO                = "Nein";

HEALBOT_WORDS_NONE              = "Nichts";
HEALBOT_OPTIONS_ALT             = "Alt";
HEALBOT_DISABLED_TARGET         = "Ziel";
HEALBOT_OPTIONS_SHOWCLASSONBAR  = "Zeige Klasse";
HEALBOT_OPTIONS_SHOWHEALTHONBAR = "Zeige Leben auf Balken";
HEALBOT_OPTIONS_BARHEALTHINCHEALS = "Zeige ankommende Heilung";
HEALBOT_OPTIONS_BARHEALTH1      = "Defizit";
HEALBOT_OPTIONS_BARHEALTH2      = "prozentual";
HEALBOT_OPTIONS_TIPTEXT         = "Tooltip-Anzeige";
HEALBOT_OPTIONS_BARINFOTEXT     = "Balken-Anzeige";
HEALBOT_OPTIONS_POSTOOLTIP      = "Tooltip-Position";
HEALBOT_OPTIONS_SHOWNAMEONBAR   = "mit Namen";
HEALBOT_SKIN_BARCLASSCUSTOMCOLOUR = "Balkenfarbe nach ";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "Text in Klassenfarben";
HEALBOT_OPTIONS_EMERGFILTERGROUPS   = "in Gruppe";

HEALBOT_ONE   = "1";
HEALBOT_TWO   = "2";
HEALBOT_THREE = "3";
HEALBOT_FOUR  = "4";
HEALBOT_FIVE  = "5";
HEALBOT_SIX   = "6";
HEALBOT_SEVEN = "7";
HEALBOT_EIGHT = "8";

HEALBOT_OPTIONS_SETDEFAULTS    = "Setze Standard-Einstellungen";
HEALBOT_OPTIONS_SETDEFAULTSMSG = "Stelle alle Optionen auf Standard zur\195\188ck";
HEALBOT_OPTIONS_RIGHTBOPTIONS  = "Panel-Rechtsklick \195\182ffnet Optionen";

HEALBOT_OPTIONS_HEADEROPTTEXT = "\195\156berschriften-Optionen"; 
HEALBOT_OPTIONS_ICONOPTTEXT    = "Icon-Optionen";
HEALBOT_SKIN_HEADERBARCOL = "Balkenfarbe"; 
HEALBOT_SKIN_HEADERTEXTCOL = "Textfarbe"; 
HEALBOT_OPTIONS_BUFFSTEXT1 = "Buff-Typ";
HEALBOT_OPTIONS_BUFFSTEXT2 = "auf Mitglieder"; 
HEALBOT_OPTIONS_BUFFSTEXT3 = "Balkenfarbe"; 
HEALBOT_OPTIONS_BUFF = "Buff "; 
HEALBOT_OPTIONS_BUFFSELF = "nur selbst"; 
HEALBOT_OPTIONS_BUFFPARTY = "f\195\188r Gruppe"; 
HEALBOT_OPTIONS_BUFFRAID = "f\195\188r Raid"; 
HEALBOT_OPTIONS_MONITORBUFFS = "\195\156berwachung fehlender Buffs"; 
HEALBOT_OPTIONS_MONITORBUFFSC = "auch im Kampf"; 
HEALBOT_OPTIONS_ENABLESMARTCAST = "SmartCast au\195\159erhalb des Kampfs"; 
HEALBOT_OPTIONS_SMARTCASTSPELLS = "Inclusive Spr\195\188che"; 
HEALBOT_OPTIONS_SMARTCASTDISPELL = "Entferne Debuffs"; 
HEALBOT_OPTIONS_SMARTCASTBUFF = "Buffen"; 
HEALBOT_OPTIONS_SMARTCASTHEAL = "Heilen"; 
HEALBOT_OPTIONS_BAR2SIZE = "Manabalken-Gr\195\182\195\159e"; 
HEALBOT_OPTIONS_SETSPELLS = "Setze Zauber f\195\188r"; 
HEALBOT_OPTIONS_ENABLEDBARS = "Aktive Balken zu jeder Zeit"; 
HEALBOT_OPTIONS_DISABLEDBARS = "Inaktive Balken au\195\159erhalb des Kampfs"; 
HEALBOT_OPTIONS_MONITORDEBUFFS = "Debuff-\195\188berwachung"; 
HEALBOT_OPTIONS_DEBUFFTEXT1 = "Zauber zum Entfernen des Debuffs"; 

HEALBOT_OPTIONS_IGNOREDEBUFF = "Ignoriere:"; 
HEALBOT_OPTIONS_IGNOREDEBUFFCLASS = "Klassen"; 
HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "Verlangsamung"; 
HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "Kurzer Effekt"; 
HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM = "Kein negativer Effekt"; 

HEALBOT_OPTIONS_RANGECHECKFREQ = "Reichweite, Aura und Aggro \195\156berpr\195\188fungs-Frequenz";
HEALBOT_OPTIONS_RANGECHECKUNITS = "Max. leicht verwundete Ziele in Reichweiten \195\156berpr\195\188fung";

HEALBOT_OPTIONS_HIDEPARTYFRAMES = "Keine Portraits";
HEALBOT_OPTIONS_HIDEPLAYERTARGET = "Spieler- und Zielportrait ausblenden";
HEALBOT_OPTIONS_DISABLEHEALBOT = "HealBot deaktivieren";

HEALBOT_OPTIONS_CHECKEDTARGET        = "Checked";

HEALBOT_ASSIST = "Helfen";
HEALBOT_FOCUS = "Fokus";
HEALBOT_MENU        = "Men\195\188";
HEALBOT_MAINTANK    = "Main-Tank";
HEALBOT_MAINASSIST  = "Main-Assist";

HEALBOT_TITAN_SMARTCAST      = "SmartCast";
HEALBOT_TITAN_MONITORBUFFS   = "\195\156berwache Buffs";
HEALBOT_TITAN_MONITORDEBUFFS = "\195\156berwache Debuffs";
HEALBOT_TITAN_SHOWBARS       = "Zeige Balken f\195\188r";
HEALBOT_TITAN_EXTRABARS      = "Extra Balken";
HEALBOT_BUTTON_TOOLTIP       = "Linksklick f\195\188r Umschalten der Optionspanels\nRechtsklick (und halten) zum Verschieben";
HEALBOT_TITAN_TOOLTIP        = "Linksklick f\195\188r Umschalten der Optionspanels";
HEALBOT_OPTIONS_SHOWMINIMAPBUTTON = "Zeige Minimap-Button";
HEALBOT_OPTIONS_BARBUTTONSHOWHOT  = "Zeige HoT-Icons";
HEALBOT_OPTIONS_HOTONBAR     = "auf Balken";
HEALBOT_OPTIONS_HOTOFFBAR    = "neben Balken";
HEALBOT_OPTIONS_HOTBARRIGHT  = "rechte Seite";
HEALBOT_OPTIONS_HOTBARLEFT   = "linke Seite";

HEALBOT_OPTIONS_ENABLETARGETSTATUS = "Verwende aktivierte Einstellungen, wenn Ziel im Kampf";

HEALBOT_ZONE_AB = "Arathibecken";
HEALBOT_ZONE_AV = "Alteractal";
HEALBOT_ZONE_ES = "Auge des Sturms";
HEALBOT_ZONE_WG = "Kriegshymnenschlucht";

HEALBOT_OPTION_AGGROTRACK = "Aggro aufsp\195\188ren"; 
HEALBOT_OPTION_AGGROBAR = "Aufblitzen"; 
HEALBOT_OPTION_AGGROTXT = ">> Zeige Text <<"; 
HEALBOT_OPTION_BARUPDFREQ = "Balken-Aktualisierungsfrequenz";
HEALBOT_OPTION_USEFLUIDBARS = "'flie\195\159ende' Balken";
HEALBOT_OPTION_CPUPROFILE  = "CPU-Profiler verwenden (Addons CPU usage Info)"
HEALBOT_OPTIONS_SETCPUPROFILERMSG = "UI Reload erforderlich, Reload jetzt durchf\195\188hren?"

HEALBOT_SELF_PVP              = "selbst im PvP"
HEALBOT_OPTIONS_ANCHOR        = "Rahmen Anker"
HEALBOT_OPTIONS_BARSANCHOR    = "Balken Anker"
HEALBOT_OPTIONS_TOPLEFT       = "Oben Links"
HEALBOT_OPTIONS_BOTTOMLEFT    = "Unten Links"
HEALBOT_OPTIONS_TOPRIGHT      = "Oben Rechts"
HEALBOT_OPTIONS_BOTTOMRIGHT   = "Unten Rechts"

HEALBOT_PANEL_BLACKLIST       = "BlackList"

HEALBOT_WORDS_REMOVEFROM      = "Entferne von";
HEALBOT_WORDS_ADDTO           = "Hinzuf\195\188gen";
HEALBOT_WORDS_INCLUDE         = "f\195\188r";

HEALBOT_OPTIONS_TTALPHA       = "Transparenz"
HEALBOT_TOOLTIP_TARGETBAR     = "Ziel-Balken"
HEALBOT_OPTIONS_MYTARGET      = "meine Ziele"

HEALBOT_DISCONNECTED_TEXT	    = "<DC>"
HEALBOT_OPTIONS_SHOWUNITBUFFTIME    = "Zeige meine Buffs";
HEALBOT_OPTIONS_TOOLTIPUPDATE       = "St\195\164ndig updaten";
HEALBOT_OPTIONS_BUFFSTEXTTIMER      = "Zeige Buffs, bevor sie auslaufen";
HEALBOT_OPTIONS_SHORTBUFFTIMER      = "Kurze Buffs"
HEALBOT_OPTIONS_LONGBUFFTIMER       = "Lange Buffs"

HEALBOT_BALANCE       = "Gleichgewicht"
HEALBOT_FERAL         = "Wilder Kampf"
HEALBOT_RESTORATION   = "Wiederherstellung"
HEALBOT_SHAMAN_RESTORATION = "Wiederherstellung"
HEALBOT_ARCANE        = "Arkan"
HEALBOT_FIRE          = "Feuer"
HEALBOT_FROST         = "Frost"
HEALBOT_DISCIPLINE    = "Disziplin"
HEALBOT_HOLY          = "Heilig"
HEALBOT_SHADOW        = "Schatten"
HEALBOT_ASSASSINATION = "Meucheln"
HEALBOT_COMBAT        = "Kampf"
HEALBOT_SUBTLETY      = "T\195\164uschung"
HEALBOT_ARMS          = "Waffen"
HEALBOT_FURY          = "Furor"
HEALBOT_PROTECTION    = "Schutz"
HEALBOT_BEASTMASTERY  = "Tierherrschaft"
HEALBOT_MARKSMANSHIP  = "Treffsicherheit"
HEALBOT_SURVIVAL      = "\195\156berleben"
HEALBOT_RETRIBUTION   = "Vergeltung"
HEALBOT_ELEMENTAL     = "Elementar"
HEALBOT_ENHANCEMENT   = "Verst\195\164rkung"
HEALBOT_AFFLICTION    = "Gebrechen"
HEALBOT_DEMONOLOGY    = "D\195\164monologie"
HEALBOT_DESTRUCTION   = "Destruction"
HEALBOT_BLOOD         = "Blut"
HEALBOT_UNHOLY        = "Unheilig"

HEALBOT_OPTIONS_VISIBLERANGE = "Balken deaktivieren, wenn Entfernung > 100 Meter"
HEALBOT_OPTIONS_NOTIFY_HEAL_MSG  = "Nachricht beim Heilen"
HEALBOT_OPTIONS_NOTIFY_OTHER_MSG = "Andere Nachricht"
HEALBOT_WORDS_YOU                = "dir/dich";
HEALBOT_NOTIFYHEALMSG            = "Wirke #s und heile #n um #h";
HEALBOT_NOTIFYOTHERMSG           = "Wirke #s auf #n";

HEALBOT_OPTIONS_HOTPOSITION = "Icon-Position";
HEALBOT_OPTIONS_HOTSHOWTEXT = "Zeige Icontext";
HEALBOT_OPTIONS_HOTTEXTCOUNT = "Z\195\164hler";
HEALBOT_OPTIONS_HOTTEXTDURATION = "Dauer";
HEALBOT_OPTIONS_ICONSCALE = "Ma\195\159stab";
HEALBOT_OPTIONS_ICONTEXTSCALE   = "Icon Text Scale"

HEALBOT_SKIN_FLUID = "Fluid";
HEALBOT_SKIN_VIVID = "Vivid";
HEALBOT_SKIN_LIGHT = "Light";
HEALBOT_SKIN_SQUARE = "Square";
HEALBOT_OPTIONS_AGGROBARSIZE = "Gr\195\182\195\159e des Aggrobalkens";
HEALBOT_OPTIONS_TARGETBARMODE   = "Beschr\195\164nke Targetbalken auf vordefinierte Einstellungen"
HEALBOT_OPTIONS_DOUBLETEXTLINES = "Zweifache Textzeilen";
HEALBOT_OPTIONS_TEXTALIGNMENT   = "Text-Ausrichtung";
HEALBOT_OPTIONS_ENABLELIBQH     = "libQuickHealth einschalten";
HEALBOT_VEHICLE                 = "Fahrzeug"
HEALBOT_OPTIONS_UNIQUESPEC      = "Speichere individuelle Einstellungen für jede Skillung"
HEALBOT_WORDS_ERROR		= "Fehler"
HEALBOT_SPELL_NOT_FOUND		= "Spruch nicht gefunden"
HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT = "Kein Tooltipp im Kampf"

HEALBOT_OPTIONS_BUFFNAMED       = "Eingabe der Spielernamen f\195\188r\n\n"
HEALBOT_OPTIONS_INHEALS         = "Verwende HealBot f\195\188r Heil-Komm"
HEALBOT_WORD_ALWAYS             = "Immer";
HEALBOT_WORD_SOLO               = "Solo";
HEALBOT_WORD_NEVER              = "Nie";

-----------------------------------------------------------------------------------------------------
HEALBOT_DEBUFF_FALTER           = "Z\195\182gern";
HEALBOT_DEBUFF_PSYCHIC_HORROR   = "Psychischer Schrei";
HEALBOT_CASTINGSPELLONYOU  = "Wirke %s auf Euch ...";
HEALBOT_CASTINGSPELLONUNIT = "Wirke %s auf %s ...";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR2 = "deakt. Skin-Einstellung f\195\188r Aktiv und Debuff";

HB_HASLEFTRAID = "^([^%s]+) hat den Raid verlassen";
HB_HASLEFTPARTY = "^([^%s]+) hat die Gruppe verlassen";
HB_YOULEAVETHEGROUP = "Du hast die Gruppe verlassen"
HB_YOULEAVETHERAID = "Du hast den Raidgruppe verlassen"
HB_YOUJOINTHERAID = "Du bist einem Raid beigetreten"
HB_YOUJOINTHEGROUP = "Du bist einer Gruppe beigetreten"
HB_GROUPDISBANDED = "Deine Gruppe wurde aufgel\195\182st"

HEALBOT_OPTIONS_TESTBARS            = "Test Balken"
HEALBOT_OPTION_NUMBARS              = "Anzahl Balken"
HEALBOT_OPTION_NUMTANKS             = "Anzahl Tanks"
HEALBOT_OPTION_NUMMYTARGETS         = "Anzahl meine Ziele"
HEALBOT_OPTION_NUMPETS              = "Anzahl Begleiter"
HEALBOT_WORD_TEST                   = "Test";
HEALBOT_WORD_OFF                    = "Aus";
HEALBOT_WORD_ON                     = "An";

HEALBOT_OPTIONS_TAB_INCHEALS        = "Ank. Heilung"
HEALBOT_OPTIONS_TAB_CHAT            = "Chat"
HEALBOT_OPTIONS_TAB_HEADERS         = "\195\156berschriften"
HEALBOT_OPTIONS_TAB_BARS            = "Balken"
HEALBOT_OPTIONS_TAB_TEXT            = "Balken Text"
HEALBOT_OPTIONS_TAB_ICONS           = "Icons"
HEALBOT_OPTIONS_SKINDEFAULTFOR      = "Standardskin f\195\188r"
HEALBOT_OPTIONS_INCHEAL             = "Ankommende Heilungen"
HEALBOT_WORD_ARENA                  = "Arena"
HEALBOT_WORD_BATTLEGROUND           = "Schlachtfeld"
HEALBOT_OPTIONS_TEXTOPTIONS         = "Text Optionen"
HEALBOT_OPTIONS_COMBOAUTOTARGET     = "Auto Ziel"
HEALBOT_OPTIONS_COMBOAUTOTRINKET    = "Auto Schmuck"

HEALBOT_HELP={ [1] = "[HealBot] /hb h -- zeige Hilfe",
               [2] = "[HealBot] /hb o -- Optionen umschalten",
               [3] = "[HealBot] /hb d -- Optionen auf Standard zur\195\188cksetzen",
               [4] = "[HealBot] /hb ui -- UI neu laden",
               [5] = "[HealBot] /hb ri -- Reset HealBot",
               [6] = "[HealBot] /hb t -- zwischen Healbot aktiviert/deaktiviert umschalten",
               [7] = "[HealBot] /hb bt -- zwischen Buff Monitor aktiviert/deaktiviert umschalten",
               [8] = "[HealBot] /hb dt -- zwischen Debuff Monitor aktiviert/deaktiviert umschalten",
               [9] = "[HealBot] /hb skin <skinName> -- wechselt Skins",
               [10] = "[HealBot] /hb tr <Role> -- Setze h\195\182chste Rollenpriorit\195\164t f\195\188r Untersortierung nach Rolle. G\195\188ltige Rollen sind 'TANK', 'HEALER' oder 'DPS'",
              }
             
HEALBOT_OPTION_HIGHLIGHTACTIVEBAR = "Mouseover hervorheben"
HEALBOT_OPTION_HIGHLIGHTTARGETBAR = "Ziel hervorheben"

HEALBOT_SHOW_INCHEALS           = "Zeige ankommende Heilung";
HEALBOT_D_DURATION              = "Direkte Dauer";
HEALBOT_H_DURATION              = "HoT Dauer";
HEALBOT_C_DURATION              = "Kanalisierte Dauer";

HEALBOT_OPTIONS_GROUPSPERCOLUMN     = "Benutze Gruppen pro Spalte"

HEALBOT_OPTIONS_BARHEALTHSEPHEALS = "getrennte ankommende Heilung";

HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON  = "Zeige Schlachtzugssymbols";

HEALBOT_OPTIONS_ICONSCALE       = "Icon Ma\195\159stab"
HEALBOT_OPTIONS_ICONTEXTSCALE   = "Icon Text Ma\195\159stab"

HEALBOT_SHOW_CLASS_AS_ICON      = "als Icon";
HEALBOT_SHOW_CLASS_AS_TEXT      = "als Text";

HEALBOT_OPTIONS_MAINSORT = "Sortieren nach"
HEALBOT_OPTIONS_SUBSORT = "Anschließend nach"
HEALBOT_OPTIONS_SUBSORTINC = "Ebenfalls sortieren"

HEALBOT_OPTIONS_TOP = "Oben"
HEALBOT_OPTIONS_BOTTOM = "Unten"

HEALBOT_OPTIONS_HEALCOMMMETHOD = "Heal Comm Methode:"
HEALBOT_OPTIONS_HEALCOMMUSELHC = "Aktiviere libHealComm"
HEALBOT_OPTIONS_HEALCOMMINTERNAL1 = "Intern nicht prüfen (Keine Komm.)"
HEALBOT_OPTIONS_HEALCOMMINTERNAL2 = "Intern prüfe Zauber (Keine Komm.)"

HEALBOT_OPTIONS_BUTTONCASTMETHOD   = "Wirke beim"
HEALBOT_OPTIONS_BUTTONCASTPRESSED  = "dr\195\188cken"
HEALBOT_OPTIONS_BUTTONCASTRELEASED = "loslassen"

HEALBOT_INFO_INCHEALINFO            = "== Ankommende Heilung Info =="
HEALBOT_INFO_ADDONCPUUSAGE          = "== Addon CPU Nutzung in Sek. =="
HEALBOT_INFO_ADDONCOMMUSAGE         = "== Addon Comms Nutzung =="
HEALBOT_WORD_HEALER                 = "Heiler"
HEALBOT_WORD_VERSION                = "Version"
HEALBOT_WORD_CLIENT                 = "Client"
HEALBOT_WORD_ADDON                  = "Addon"
HEALBOT_INFO_CPUSECS                = "CPU Sek."
HEALBOT_INFO_MEMORYKB               = "Speicher KB"
HEALBOT_INFO_COMMS                  = "Komm. KB"

HEALBOT_OPTIONS_HEALCOMMINTERNAL3 = "HB Sehr niedrige Komm. - nicht prüfen"
HEALBOT_OPTIONS_HEALCOMMINTERNAL4 = "HB Sehr niedrige Komm. - prüfe Zauber"

HEALBOT_OPTIONS_HEALCOMMNOLHC = "libHealComm ist nicht eingebaut\n\nEinige der ankomm. Heilung Schieber werden nicht benutzt"
HEALBOT_OPTIONS_HEALCOMMNOLHC2 = "libHealComm ist nicht aktiviert aber eingebaut\nDie Bibliothek sendet noch Addon-Komm. Spam\n\nZum Deaktivieren bitte disable_libHealComm.html im Docs Verzeichnis lesen"

HEALBOT_OPTIONS_HEALCOMMLHCNOTFOUND = "libHealComm nicht installiert"

HEALBOT_WORD_STAR                   = "Stern"
HEALBOT_WORD_CIRCLE                 = "Kreis"
HEALBOT_WORD_DIAMOND                = "Diamant"
HEALBOT_WORD_TRIANGLE               = "Dreieck"
HEALBOT_WORD_MOON                   = "Mond"
HEALBOT_WORD_SQUARE                 = "Viereck"
HEALBOT_WORD_CROSS                  = "Kreuz"
HEALBOT_WORD_SKULL                  = "Totenkopf"

HEALBOT_OPTIONS_ACCEPTSKINMSG       = "Akzeptiere [HealBot] Skin: "
HEALBOT_OPTIONS_ACCEPTSKINMSGFROM   = " von "
HEALBOT_OPTIONS_BUTTONSHARESKIN     = "Teile mit"

HEALBOT_CHAT_ADDONID                = "[HealBot]  "
HEALBOT_CHAT_NEWVERSION1            = "Eine neuere Version ist unter"
HEALBOT_CHAT_NEWVERSION2            = "http://healbot.alturl.com verf\195\188gbar"
HEALBOT_CHAT_SHARESKINERR1          = " Skin zum Teilen nicht gefunden"
HEALBOT_CHAT_SHARESKINERR2          = "'s HealBot Version ist zu alt zum Skin Teilen"
HEALBOT_CHAT_SHARESKINERR3          = " nicht gefunden zum Skin Teilen"
HEALBOT_CHAT_SHARESKINACPT          = "Geteiltes Skin akzeptiert von "
HEALBOT_CHAT_CONFIRMSKINDEFAULTS    = "Skins auf Standard gesetzt"
HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS  = "Pers\195\182nliche Debuffs zur\195\188ckgesetzt"
HEALBOT_CHAT_CHANGESKINERR1         = "Unbekanntes skin: /hb skin "
HEALBOT_CHAT_CHANGESKINERR2         = "G\195\188ltige skins:  "
HEALBOT_CHAT_CONFIRMSPELLCOPY       = "Aktuelle Spr\195\188che f\195\188r in alle Skillungen \195\188bernommen"
HEALBOT_CHAT_UNKNOWNCMD             = "Unbekanntes Kommandozeilenbefehl: /hb "
HEALBOT_CHAT_ENABLED                = "Status jetzt aktiviert"
HEALBOT_CHAT_DISABLED               = "Status jetzt deaktiviert"
HEALBOT_CHAT_SOFTRELOAD             = "Healbot Reload angefragt"
HEALBOT_CHAT_HARDRELOAD             = "UI Reload angefragt"
HEALBOT_CHAT_CONFIRMSPELLRESET      = "Spr\195\188che wurden zur\195\188ckgesetzt"
HEALBOT_CHAT_CONFIRMCURESRESET      = "Heilung wurde zur\195\188ckgesetzt"
HEALBOT_CHAT_CONFIRMBUFFSRESET      = "Buffs wurde zur\195\188ckgesetzt"
HEALBOT_CHAT_USE10ON                = "Auto Schmuck - Use10 ist eingeschaltet - Damit use10 funktioniert muss ein Auto Schmuck aktiviert sein"
HEALBOT_CHAT_USE10OFF               = "Auto Schmuck - Use10 ist ausgeschaltet"
HEALBOT_CHAT_TOPROLEERR             = " Rolle in diesem Zusammenhang nicht g\195\188ltig - benutze 'TANK', 'DPS' oder 'HEALER'"
HEALBOT_CHAT_NEWTOPROLE             = "H\195\188chste obere Rolle ist jetzt "
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA = "Es ist nicht m\195\182glich alle Skin-Einstellungen zu empfangen - evtl. fehlen SharedMedia-Daten. Links hierzu siehe HealBot/Docs/readme.html"

HEALBOT_CHAT_MACROSOUNDON           = "Sound wird nicht unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
HEALBOT_CHAT_MACROSOUNDOFF          = "Sound wird unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
HEALBOT_CHAT_MACROERRORON           = "Fehler werden nicht unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
HEALBOT_CHAT_MACROERROROFF          = "Fehler werden unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
HEALBOT_CHAT_TITANON                = "Titan Panel - Updates an"
HEALBOT_CHAT_TITANOFF               = "Titan Panel - Updates aus"
HEALBOT_CHAT_ACCEPTSKINON           = "Teile Skin - Zeige Akzeptiere-Skin-Popup wenn jemand ein Skin mit dir teilen m\195\182chte"
HEALBOT_CHAT_ACCEPTSKINOFF          = "Teile Skin - Skin Teilen von allen immer ignorieren"

HEALBOT_OPTIONS_SELFCASTS           = "Nur eigene Zauber"
HEALBOT_OPTIONS_HOTSHOWICON         = "Zeige Icon"
HEALBOT_OPTIONS_ALLSPELLS           = "Alle Spr\195\188che"
HEALBOT_OPTIONS_DOUBLEROW           = "zweizeilig"
HEALBOT_OPTIONS_HOTBELOWBAR         = "unter Balken"
HEALBOT_OPTIONS_OTHERSPELLS         = "andere Spr\195\188che"
HEALBOT_WORD_MACROS                 = "Makros"
HEALBOT_WORD_SELECT                 = "Ausw\195\164hlen"
HEALBOT_OPTIONS_QUESTION            = "?"
HEALBOT_WORD_CANCEL                 = "Abbrechen"
HEALBOT_WORD_COMMANDS               = "Kommandos"
HEALBOT_OPTIONS_BARHEALTH3          = "als Gesundheit";
HEALBOT_CHAT_SKINREC                = " Skin erhalten von " 
HEALBOT_SORTBY_ROLE                 = "Rolle"
HEALBOT_OPTIONS_BARBUTTONSHOWHOT    = "Zeige HoT";
HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON = "Zeige Schlachtzugssymbole";
HEALBOT_OPTIONS_SHOWDEBUFFICON      = "Zeige Debuff";
HEALBOT_OPTIONS_SHOWREADYCHECK      = "Zeige Ready Check";
HEALBOT_OPTIONS_SUBSORTSELFFIRST    = "Selbst zuerst"
HEALBOT_OPTION_AGGROPCTBAR          = "Bew. Balken"
HEALBOT_OPTION_AGGROPCTTXT          = "Zeige Text"
HEALBOT_OPTION_AGGROPCTTRACK        = "Prozentual verfolgen" 
HEALBOT_OPTIONS_ALERTAGGROLEVEL0    = "0 - hat niedrige Bedrohung und tankt nichts"
HEALBOT_OPTIONS_ALERTAGGROLEVEL1    = "1 - hat hohe Bedrohung und tankt nichts"
HEALBOT_OPTIONS_ALERTAGGROLEVEL2    = "2 - unsicher ob tankt, nicht die h\195\182chste Bedrohung am Gegner"
HEALBOT_OPTIONS_ALERTAGGROLEVEL3    = "3 - tankt sicher mindestens einen Gegner"
HEALBOT_OPTIONS_AGGROALERT          = "Aggro Alarm Level"
HEALBOT_OPTIONS_SETAGGROERROR1      = " Ung\195\188ltige Parameter bearbeitet zum Einstellen von Aggro ..."
HEALBOT_OPTIONS_SETAGGRORESET       = " Aggro Balken Einstellungen zur\195\188cksetzen"
HEALBOT_OPTIONS_SETAGGROERROR2      = " Setzen der min. Aggro-Tr\195\188bung fehlgeschlagen - G\195\188ltiger Wertebereich ist 0 bis 0.8"
HEALBOT_OPTIONS_SETAGGROERROR3      = " Setzen der min. Aggro-Tr\195\188bung fehlgeschlagen - Min Wert ist gr\195\182\195\159er als Max"
HEALBOT_OPTIONS_SETAGGROERROR4      = " Setzen der max. Aggro-Tr\195\188bung fehlgeschlagen - G\195\188ltiger Wertebereich ist 0.2 bis 1"
HEALBOT_OPTIONS_SETAGGROERROR5      = " Setzen der max. Aggro-Tr\195\188bung fehlgeschlagen - Max Wert ist kleiner als Min"
HEALBOT_OPTIONS_SETAGGROMIN         = " min. Aggro-Tr\195\188bung eingestellt auf "
HEALBOT_OPTIONS_SETAGGROMAX         = " min. Aggro-Tr\195\188bung eingestellt auf "
HEALBOT_OPTIONS_SETAGGROERROR6      = " Setzen der Aggro Aufblitz-Frequenz fehlgeschlagen - G\195\188ltiger Wertebereich ist 0.005 bis 0.2"
HEALBOT_OPTIONS_SETAGGROFLASH       = " Aggro Aufblitz-Frequenz eingestellt auf "
HEALBOT_OPTIONS_SETAGGROERROR7      = " Setzen der Aggro-Tr\195\188bung fehlgeschlagen - Ung\195\188ltiges <What End>.  Benutze 'Min' oder 'Max'"
HEALBOT_OPTIONS_SETAGGROERROR8      = " Ung\195\188ltiger Aggro Status - Benutze 'Low', 'High' oder 'Has'"
HEALBOT_OPTIONS_SETAGGROERROR9      = " Setzen der Aggro-Farbe fehlgeschlagen - Blau nicht zwischen 0 und 1"
HEALBOT_OPTIONS_SETAGGROERROR10     = " Setzen der Aggro-Farbe fehlgeschlagen - Gr\195\188n nicht zwischen 0 und 1"
HEALBOT_OPTIONS_SETAGGROERROR11     = " Setzen der Aggro-Farbe fehlgeschlagen - Rot nicht zwischen 0 und 1"
HEALBOT_OPTIONS_SETAGGROCOL         = " Aggro-Farben eingestellt auf "
HEALBOT_OPTIONS_TOOLTIPSHOWHOT      = "Zeige aktiv verfolgte HoT Details"
HEALBOT_OPTIONS_SETAGGROFLASHCUR    = " Aggro Aufblitz-Frequenz="
HEALBOT_OPTIONS_SETAGGROALPHACUR    = " Aggro-Tr\195\188bung "
HEALBOT_OPTIONS_SETAGGROCOLLOW      = " Aggro-Farbe f\195\188r 'niedrige Bedrohung' (1) "
HEALBOT_OPTIONS_SETAGGROCOLHIGH     = " Aggro-Farbe f\195\188r 'hohe Bedrohung' (2) "
HEALBOT_OPTIONS_SETAGGROCOLHAS      = " Aggro-Farbe f\195\188r 'hat Aggro' (3) "
HEALBOT_WORDS_MIN                   = "min"
HEALBOT_WORDS_MAX                   = "max"
HEALBOT_WORDS_R                     = "R"
HEALBOT_WORDS_G                     = "G"
HEALBOT_WORDS_B                     = "B"
HEALBOT_OPTIONS_MAINASSIST          = "Hauptassistent";
HEALBOT_CHAT_SELFPETSON             = "Eigenen Begleiter anschalten"
HEALBOT_CHAT_SELFPETSOFF            = "Eigenen Begleiter ausschalten"
HEALBOT_OPTIONS_TAB_WARNING = "Warnung"
HEALBOT_WORD_PRIORITY               = "Priorit\195\164t"
HEALBOT_OPTIONS_CDCSHOWHBARS        = "Lebensbalkenfarbe \195\164ndern";
HEALBOT_OPTIONS_CDCSHOWABARS        = "Aggrobalkenfarbe \195\164ndern";
HEALBOT_VISIBLE_RANGE               = "Innerhalb 100 Metern"
HEALBOT_SPELL_RANGE                 = "In Zauberreichweite"

HEALBOT_CUSTOM_CATEGORY               = "Kategorie"
HEALBOT_CUSTOM_CAT_CUSTOM             = "Pers\195\182nlich"
HEALBOT_CUSTOM_CAT_CLASSIC            = "Classic"
HEALBOT_CUSTOM_CAT_TBC_OTHER          = "TBC - Sonstige"
HEALBOT_CUSTOM_CAT_TBC_BT             = "TBC - Der Schwarze Tempel"
HEALBOT_CUSTOM_CAT_TBC_SUNWELL        = "TBC - Sonnenbrunnenplateau"
HEALBOT_CUSTOM_CAT_LK_OTHER           = "WotLK - Sonstige"
HEALBOT_CUSTOM_CAT_LK_ULDUAR          = "WotLK - Ulduar"
HEALBOT_CUSTOM_CAT_LK_TOC             = "WotLK - Kolosseum der Kreuzfahrers"
HEALBOT_CUSTOM_CAT_LK_ICC_LOWER       = "WotLK - ICC Zitadelle"
HEALBOT_CUSTOM_CAT_LK_ICC_PLAGUEWORKS = "WotLK - ICC Die Seuchenwerke"
HEALBOT_CUSTOM_CAT_LK_ICC_CRIMSON     = "WotLK - ICC Die Blutrote Halle"
HEALBOT_CUSTOM_CAT_LK_ICC_FROSTWING   = "WotLK - ICC Hallen der Frostschwingen"
HEALBOT_CUSTOM_CAT_LK_ICC_THRONE      = "WotLK - ICC Frostthron"
HEALBOT_WORD_RESET                    = "Reset"
HEALBOT_HBMENU                        = "HBmenu"
HEALBOT_ACTION_HBFOCUS                = "Linksklick um Ziel als\nFokus zu setzen"
HEALBOT_WORD_CLEAR                    = "L\195\182schen"
HEALBOT_WORD_SET                      = "Setze"
HEALBOT_WORD_HBFOCUS                  = "HealBot Fokus"
HEALBOT_WORD_OUTSIDE                  = "Außerhalb"
HEALBOT_WORD_ALLZONE                  = "Alle Zonen"

HEALBOT_OPTIONS_TAB_ALERT            = "Alarm"
HEALBOT_OPTIONS_TAB_SORT             = "Sortieren"
HEALBOT_OPTIONS_TAB_AGGRO            = "Aggro"
HEALBOT_OPTIONS_TAB_ICONTEXT         = "Icon Text"
HEALBOT_OPTIONS_AGGROBARCOLS         = "Aggro Balken Farben";
HEALBOT_OPTIONS_AGGRO1COL            = "Hat hohe\nBedrohung"
HEALBOT_OPTIONS_AGGRO2COL            = "Unsicher \nob tankt"
HEALBOT_OPTIONS_AGGRO3COL            = "Tankt\nsicher"
HEALBOT_OPTIONS_AGGROFLASHFREQ       = "Aufblitz-Frequenz"
HEALBOT_OPTIONS_AGGROFLASHALPHA      = "Aufblitz-Durchsichtigkeit"
HEALBOT_OPTIONS_SHOWDURATIONFROM     = "Zeige Dauer ab"
HEALBOT_OPTIONS_SHOWDURATIONWARN     = "Dauer Warnung ab"
HEALBOT_CMD_RESETCUSTOMDEBUFFS       = "Reset pers\195\182nliche Debuffs"
HEALBOT_CMD_RESETSKINS               = "Reset Skins"
HEALBOT_CMD_CLEARBLACKLIST           = "L\195\182sche BlackList"
HEALBOT_CMD_TOGGLEACCEPTSKINS        = "Umschalten Akzeptieren von Skins Anderer"
HEALBOT_CMD_COPYSPELLS               = "\195\156bernehme aktuelle Spr\195\188che f\195\188r alle Skillungen"
HEALBOT_CMD_RESETSPELLS              = "Reset Spr\195\188che"
HEALBOT_CMD_RESETCURES               = "Reset Heilungen"
HEALBOT_CMD_RESETBUFFS               = "Reset Buffs"
HEALBOT_CMD_RESETBARS                = "Reset Balken Position"
HEALBOT_CMD_TOGGLETITAN              = "Umschalten Titan Updates"
HEALBOT_CMD_SUPPRESSSOUND            = "Umschalten der Soundunterdr\195\188ckung, wenn Auto Schmuck benutzt wird"
HEALBOT_CMD_SUPPRESSERRORS           = "Umschalten der Fehlerunterdr\195\188ckung, wenn Auto Schmuck benutzt wird"
HEALBOT_OPTIONS_COMMANDS             = "HealBot Kommandos"
HEALBOT_WORD_RUN                     = "Ausf\195\188hren"
HEALBOT_OPTIONS_MOUSEWHEEL           = "Aktiviere Men\195\188 auf Mausrad"
HEALBOT_CMD_DELCUSTOMDEBUFF10        = "L\195\182sche pers\195\182nliche Debuffs mit Priorit\195\164t 10"
HEALBOT_ACCEPTSKINS                  = "Akzeptiere Skins von anderen"
HEALBOT_SUPPRESSSOUND                = "Auto Schmuck: Unterdr\195\188cke Sound"
HEALBOT_SUPPRESSERROR                = "Auto Schmuck: Unterdr\195\188cke Fehler"

HEALBOT_WORD_OTHER                      = "Sonstige"
HEALBOT_WORD_RESERVED                   = "Reserviert"

HEALBOT_OPTIONS_CRASHPROT               = "Crash Protection"
HEALBOT_CP_MACRO_LEN                    = "Makro Name muss zwischen 1 und 14 Zeichen lang sein"
HEALBOT_CP_MACRO_BASE                   = "Grund-Makro Name"
HEALBOT_CP_MACRO_INFO                   = "Crash Protection stellt die HealBot-UI nach einem DC wieder her.\nUm Crash Protection zu benutzen M\195\156SSEN 5 pers\195\182nliche Makropl\195\164tze frei sein."
HEALBOT_CP_MACRO_SAVE                   = "Zuletzt gespeichert um: "
HEALBOT_CP_STARTTIME                    = "Schutzdauer beim Einloggen"

HEALBOT_OPTIONS_COMBATPROT              = "Combat Protection"
HEALBOT_COMBATPROT_INFO                 = "Combat Protection stellt die HealBot-UI bei Gruppen-/Raid\195\164nderungen wieder her."
HEALBOT_COMBATPROT_PARTYNO              = "Balken f\195\188r Gruppe reserviert"
HEALBOT_COMBATPROT_RAIDNO               = "Balken f\195\188r Raid reserviert"


end