-- WoWEquip Localization file

local debugFlag = false
--[===[@debug@
--debugFlag = true
--@end-debug@]===]

local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:NewLocale("WoWEquip", "enUS", true, debugFlag)
L["Show/Hide WoWEquip"] = true
L["Inspect & Copy Target"] = true
L["Unsafe Item"] = true
L["Name:"] = true
L["ItemID:"] = true
L["This item is unsafe. To view this item without the risk of disconnection, you need to have first seen it in the game world since the last patch. This is a restriction enforced by Blizzard since Patch 1.10."] = true
L["You can right-click to attempt to query the server. You may be disconnected."] = true
L["%s's equipped gear.\nGuild: %s\nServer: %s, %s\nDate: %s"] = true
L["%s's imported gear.\nGuild: %s\nServer: %s, %s\nDate: %s"] = true
L["Equipped Gear"] = true
L["Copy Target"] = true
L["Search Equipment"] = true
L["Selected Slot: %s (%d)"] = true
L["WOW_EQUIP_FILTER_LETTER"] = "F"
L["WOW_EQUIP_SORT_LETTER"] = "S"
L["Equip"] = true
L["Filter Options"] = true
L["Off-hand"] = true
L["Select All"] = true
L["Unselect All"] = true
L["Sort Options"] = true
L["by ItemLevel > Name > Rarity"] = true
L["by ItemLevel > Rarity > Name"] = true
L["by Name > ItemLevel > Rarity"] = true
L["by Name > Rarity > ItemLevel"] = true
L["by Rarity > ItemLevel > Name"] = true
L["by Rarity > Name > ItemLevel"] = true
L["WOW_EQUIP_SEARCH_INFO"] = "Note: Only items you have seen before since the last patch can be searched (i.e. the items must be in your local cache). If an item isn't in your local cache, obtain the itemlink from somewhere first (such as AtlasLoot, WoWHead or somewhere else) and search again."
L["Query server for itemID:"] = true
L["Query"] = true
L["Unequip this slot"] = true
L["Query server for this item"] = true
L["|cffeda55fCtrl-Click|r to add to/remove from Favorites"] = true
L["|cffeda55fShift-Click|r to link to chat"] = true
L["Favorites"] = true
L["\34%s\34 added to Favorites."] = true
L["\34%s\34 removed from Favorites."] = true
L["Save Profile"] = true
L["Load Profile"] = true
L["Send Profile"] = true
L["Compare Profile"] = true
L["Save"] = true
L["Load"] = true
L["Send"] = true
L["Compare"] = true
L["Description/Notes:"] = true
L["Send profile to:"] = true
L["Rename"] = true
L["Delete"] = true
L["Overwrite the following profile?\n%s"] = true
L["Delete the following profile?\n%s"] = true
L["Rename the following profile?\n%s"] = true
L["List of saved profiles:"] = true
L["(No description)"] = true
L["Rename unsuccessful. A profile of that name already exists."] = true
L["Rename unsuccessful. Cannot rename to nothing."] = true
L["Right-Click profiles for more options."] = true
L["Profile \34%s\34 sent to %s."] = true
L["Profile \34%s\34 received successfully from %s"] = true
L["Options..."] = true
L["Lock WoWEquip windows from being moved"] = true
L["Keep previous enchant when equipping a new item"] = true
L["Background Color"] = true
L["Border Color"] = true
L["WoWEquip Transparency"] = true
L["WoWEquip Scaling"] = true
L["Attached Dressing Room Scaling"] = true
L["Add extra width to WoWEquip"] = true
L["Item Bonus Summary"] = true
L["Equipment Stats"] = true
L["Derived Stats"] = true
L["WOW_EQUIP_COMPARE_LETTER"] = "C"
L["WOW_EQUIP_IMPORT_LETTER"] = "I"
L["Compare against..."] = true
L["Don't compare"] = true
L["Currently equipped gear"] = true
L["Selected profile..."] = true
L["Comparing:"] = true
L["Lvl:"] = true
L["Show Cloak"] = true
L["Show Helm"] = true
L["Select class"] = true
L["WOW_EQUIP_DERIVED_STATS_NOTE"] = "Derived Stats only calculates the overall effects from |cFFFFFFFFequipment only|r and does not take into account base character stats, racials, talents, buffs or debuffs."
L["WOW_EQUIP_NOT_IN_CACHE"] = "Some items are not calculated in the saved profile because they do not exist in your local cache. Load the profile you are comparing against and query the server for the affected items."
L["WOW_EQUIP_BETA_TEXT"] = [[|cFFFFFFFFWoWEquip is currently in BETA status.

Please report bugs at |rhttp://forums.wowace.com/showthread.php?t=7879|cFFFFFFFF along with any other feedback and suggestions.

- Xinhuan (US Blackrock Alliance)|r
]]

L["Import Profile"] = true
L["WoW Armory"] = true
L["Armory Import"] = true
L["Paste the entire XML/XSLT source of the WoW Armory character page (View Source). Only works in IE6 and Firefox2 or newer."] = true
L["Rawr"] = true
L["Rawr Import"] = true
L["Paste the entire contents of a Rawr (v2.2.4 or later) XML saved character file."] = true
L["Type:"] = true
L["Data:"] = true
L["Import"] = true
L["Anonymous Import"] = true
L["Select Import Source"] = true

L["Warrior"] = true
L["Paladin"] = true
L["Hunter"] = true
L["Rogue"] = true
L["Priest"] = true
L["Death Knight"] = true
L["Shaman"] = true
L["Mage"] = true
L["Warlock"] = true
L["Druid"] = true


L["Health and Mana"] = true
L["Resistances"] = true
L["Gems"] = true
L["Others"] = true
L["Sets"] = true

L["Wrath"] = true
L["TBC"] = true
L["Classic"] = true
L["Scribes Only"] = true
L["Enchanters Only"] = true
L["Leatherworkers Only"] = true
L["Tailors Only"] = true
L["Jewelcrafters Only"] = true
L["Blacksmiths Only"] = true
L["Engineers Only"] = true
L["Enchanting"] = true
L["Leatherworking"] = true
L["Tailoring"] = true
L["Blacksmithing"] = true
L["Engineering"] = true
L["Runeforging"] = true
L["Reputation Vendors"] = true
L["PvP"] = true
L["Arcanums (Librams)"] = true
L["Zul'Gurub (Idols)"] = true
L["Argent Dawn (Insignias)"] = true
L["Hodir Inscriptions"] = true
L["Armor Kits"] = true
L["Aldor Inscriptions"] = true
L["Scryer Inscriptions"] = true
L["Violet Eye Inscriptions"] = true
L["Argent Dawn Mantles"] = true
L["Zul'Gurub Signets"] = true
L["Naxxramas Sapphiron Drops"] = true
L["Quest Rewards"] = true
L["(1H)"] = true
L["(2H)"] = true
L["(Lvl %d+)"] = true

L["Jewelcrafting"] = true
L["Wintergrasp"] = true
L["Green"] = true
L["Orange"] = true
L["Purple"] = true
L["Prismatic"] = true
L["Perfect"] = true
L["Instance Drops"] = true


-- Translations for 6th and 7th return values (itemType, itemSubType) from GetItemInfo()
local LGII = AceLocale:NewLocale("WoWEquipLGII", "enUS", true, debugFlag)
LGII["Weapon"] = true
LGII["Armor"] = true
LGII["Cloth"] = true
LGII["Leather"] = true
LGII["Mail"] = true
LGII["Plate"] = true
LGII["Daggers"] = true
LGII["Fist Weapons"] = true
LGII["One-Handed Axes"] = true
LGII["One-Handed Maces"] = true
LGII["One-Handed Swords"] = true
LGII["Fishing Poles"] = true
LGII["Polearms"] = true
LGII["Staves"] = true
LGII["Two-Handed Axes"] = true
LGII["Two-Handed Maces"] = true
LGII["Two-Handed Swords"] = true
LGII["Shields"] = true
LGII["Bows"] = true
LGII["Crossbows"] = true
LGII["Guns"] = true
LGII["Thrown"] = true
LGII["Wands"] = true
LGII["Idols"] = true
LGII["Librams"] = true
LGII["Totems"] = true
LGII["Sigils"] = true
LGII["Miscellaneous"] = true

-- Translations for enchant names/descriptions
local LE = AceLocale:NewLocale("WoWEquipLE", "enUS", true, debugFlag)
LE[0] = ""
-- Armor Kits
LE[2304] = "Armor +8 (Light Armor Kit)"
LE[2313] = "Armor +16 (Medium Armor Kit)"
LE[4265] = "Armor +24 (Heavy Armor Kit)"
LE[8173] = "Armor +32 (Thick Armor Kit)"
LE[15564] = "Armor +40 (Rugged Armor Kit)"
LE[18251] = "Defense Rating +5 (Core Armor Kit)"
LE[29488] = "Arcane Resistance +8 (Arcane Armor Kit)"
LE[25651] = "Defense Rating +8 (Vindicator's Armor Kit)"
LE[29485] = "Fire Resistance +8 (Flame Armor Kit)"
LE[29486] = "Frost Resistance +8 (Frost Armor Kit)"
LE[29487] = "Nature Resistance +8 (Nature Armor Kit)"
LE[29483] = "Shadow Resistance +8 (Shadow Armor Kit)"
LE[25650] = "Stamina +8 (Knothide Armor Kit)"
LE[34330] = "Stamina +10 (Heavy Knothide Armor Kit)"
LE[25652] = "3 mana per 5 sec. (Magister's Armor Kit)"
LE[38375] = "Stamina +12 (Borean Armor Kit)"
LE[38376] = "Stamina +18 (Heavy Borean Armor Kit)"
-- Wrath Reputation Vendor enchants
LE[44149] = "Attack Power +50 / Crit Rating +20 (Arcanum of Torment) (KotEB - Revered)"
LE[44159] = "Spell Power +30 / Crit Rating +20 (Arcanum of Burning Mysteries) (KT - Revered)"
LE[44152] = "Spell Power +30 / 8 mana per 5 sec. (Arcanum of Blissful Mending) (WA - Revered)"
LE[44140] = "Stamina +30 / Arcane Resistance +25 (Arcanum of the Eclipsed Moon) (WA - Honored)"
LE[44141] = "Stamina +30 / Fire Resistance +25 (Arcanum of the Flame's Soul) (KT - Honored)"
LE[44137] = "Stamina +30 / Frost Resistance +25 (Arcanum of the Frosty Soul) (SoH - Honored)"
LE[44138] = "Stamina +30 / Nature Resistance +25 (Arcanum of Toxic Warding) (KotEB - Honored)"
LE[44701] = "Stamina +30 / Resilience +25 (Arcanum of the Savage Gladiator) (AV/HE - Exalted)"
LE[44139] = "Stamina +30 / Shadow Resistance +25 (Arcanum of the Fleeing Shadow) (AC - Honored)"
LE[44150] = "Stamina +37 / Defense Rating +20 (Arcanum of the Stalwart Protector) (AC - Revered)"
LE[44069] = "Attack Power +50 / Resilience +20 (Arcanum of Triumph)"
LE[44075] = "Spell Power +29 / Resilience +20 (Arcanum of Dominance)"
-- TBC Reputation Vendor enchants
LE[29195] = "Arcane Resistance +20 (Arcanum of Arcane Warding) (Sha'tar - Honored)"
LE[29192] = "Attack Power +34 / Hit Rating +16 (Arcanum of Ferocity) (CE - Revered)"
LE[29186] = "Defense Rating +16 / Dodge Rating +17 (Arcanum of the Defender) (KoT - Revered)"
LE[29196] = "Fire Resistance +20 (Arcanum of Fire Warding) (Tm/HHold - Honored)"
LE[29198] = "Frost Resistance +20 (Arcanum of Frost Warding) (KoT - Honored)"
LE[29189] = "Spell Power +19 / 7 mana per 5 sec. (Arcanum of Renewal) (Tm/HH - Revered)"
LE[29194] = "Nature Resistance +20 (Arcanum of Nature Warding) (CE - Honored)"
LE[29199] = "Shadow Resistance +20 (Arcanum of Shadow Warding) (LC - Honored)"
LE[29191] = "Spell Power +22 / Hit Rating +14 (Arcanum of Power) (Sha'tar - Revered)"
LE[29193] = "Stamina +18 / Resilience +20 (Arcanum of the Gladiator) (SSO - Revered)"
LE[30846] = "Strength +17 / Intellect +16 (Arcanum of the Outcast) (LC - Revered)"
-- Arcanums
LE[11647] = "Agility +8 (Lesser Arcanum of Voracity)"
LE[11643] = "Armor +125 (Lesser Arcanum of Tenacity)"
LE[18331] = "Dodge Rating +12 (Arcanum of Protection)"
LE[11644] = "Fire Resistance +20 (Lesser Arcanum of Resilience)"
LE[18329] = "Haste Rating +10 (Arcanum of Rapidity)"
LE[11642] = "Health +100 (Lesser Arcanum of Constitution)"
LE[11648] = "Intellect +8 (Lesser Arcanum of Voracity)"
LE[11622] = "Mana +150 (Lesser Arcanum of Rumination)"
LE[18330] = "Spell Power +8 (Arcanum of Focus)"
LE[11649] = "Spirit +8 (Lesser Arcanum of Voracity)"
LE[11646] = "Stamina +8 (Lesser Arcanum of Voracity)"
LE[11645] = "Strength +8 (Lesser Arcanum of Voracity)"
-- ZG Idols
LE[19782] = "Def Rating +10/Sta +10/Block Value +15 (Presence of Might) (Warrior)"
LE[19783] = "Def Rating +10/Sta +10/Spell Power +12 (Syncretist's Sigil) (Paladin)"
LE[19784] = "+28 AP/+12 Dodge Rating (Death's Embrace) (Rogue)"
LE[19785] = "+24 RAP/+10 Sta/+10 Hit Rating (Falcon's Call) (Hunter)"
LE[19786] = "Spell Power +13/Int +15 (Vodouisant's Vigilant Embrace) (Shaman)"
LE[19787] = "Spell Power +18/Hit Rating +8 (Presence of Sight) (Mage)"
LE[19788] = "Spell Power +18/Sta +10 (Hoodoo Hex) (Warlock)"
LE[19789] = "Spell Power +13/Sta +10/+4 MP5 (Prophetic Aura) (Priest)"
LE[19790] = "Intellect +10/Sta +10/Spell Power +12 (Animist's Caress) (Druid)"
LE[22635] = "Nature Resistance +10 (Savage Guard)"
-- Argent Dawn Insignias enchants
LE[22636] = "Frost Resistance +10 (Ice Guard)"
LE[22638] = "Shadow Resistance +10 (Shadow Guard)"
-- Hodir Inscriptions
LE[44131] = "Attack Power +30 / Crit Rating +10 (Lesser Inscription of the Axe)"
LE[44133] = "Attack Power +40 / Crit Rating +15 (Greater Inscription of the Axe)"
LE[44132] = "Dodge Rating +15 / Defense Rating +10 (Lesser Inscription of the Pinnacle)"
LE[44136] = "Dodge Rating +20 / Defense Rating +15 (Greater Inscription of the Pinnacle)"
LE[44129] = "Spell Power +18 / Crit Rating +10 (Lesser Inscription of the Storm)"
LE[44135] = "Spell Power +24 / Crit Rating +15 (Greater Inscription of the Storm)"
LE[44130] = "Spell Power +18 / +4 mana per 5 sec (Lesser Inscription of the Crag)"
LE[44134] = "Spell Power +24 / +6 mana per 5 sec (Greater Inscription of the Crag)"
-- Scribes Only Wrath inscriptions
LE[-61117] = "Attack Power +120 / Crit Rating +15 (Master's Inscription of the Axe)"
LE[-61119] = "Dodge Rating +60 / Defense Rating +15 (Master's Inscription of the Pinnacle)"
LE[-61120] = "Spell Power +70 / Crit Rating +15 (Master's Inscription of the Storm)"
LE[-61118] = "Spell Power +70 / +6 mana per 5 sec (Master's Inscription of the Crag)"
-- Wrath PvP shoulder enchants
LE[44067] = "Attack Power +40 / Resilience +15 (Inscription of Triumph)"
LE[44068] = "Spell Power +23 / Resilience +15 (Inscription of Dominance)"
LE[44957] = "Stamina +30 / Resilience +15 (Greater Inscription of the Gladiator)"
-- Aldor Inscriptions
LE[28882] = "Dodge Rating +13 (Inscription of Warding)"
LE[28889] = "Dodge Rating +15 / Defense Rating +10 (Greater Inscription of Warding)"
LE[28878] = "Spell Power +15 (Inscription of Faith)"
LE[28887] = "Spell Power +18 / 4 mana per 5 sec. (Greater Inscription of Faith)"
LE[28881] = "Spell Power +15 (Inscription of Discipline)"
LE[28886] = "Spell Power +18 / Crit Rating +10 (Greater Inscription of Discipline)"
LE[28885] = "Attack Power +26 (Inscription of Vengeance)"
LE[28888] = "Attack Power +30 / Crit Rating +10 (Greater Inscription of Vengeance)"
-- Scryer Inscriptions
LE[28908] = "Def Rating +13 (Inscription of the Knight)"
LE[28911] = "Def Rating +15 / Dodge Rating +10 (Greater Inscription of the Knight)"
LE[28904] = "5 mana per 5 sec. (Inscription of the Oracle)"
LE[28912] = "6 mana per 5 sec. / Spell Power +12 (Greater Inscription of the Oracle)"
LE[28903] = "Crit Rating +13 (Inscription of the Orb)"
LE[28909] = "Crit Rating +15 / Spell Power +12 (Greater Inscription of the Orb)"
LE[28907] = "Crit Rating +13 (Inscription of the Blade)"
LE[28910] = "Crit Rating +15 / Attack Power +20 (Greater Inscription of the Blade)"
-- Violet Eye Inscriptions
LE[29187] = "All Resistances +7 (Inscription of Endurance)"
-- Argent Dawn Mantles
LE[18182] = "All Resistances +5 (Chromatic Mantle of the Dawn)"
LE[18171] = "Arcane Resistance +5 (Arcane Mantle of the Dawn)"
LE[18169] = "Fire Resistance +5 (Flame Mantle of the Dawn)"
LE[18170] = "Frost Resistance +5 (Frost Mantle of the Dawn)"
LE[18172] = "Nature Resistance +5 (Nature Mantle of the Dawn)"
LE[18173] = "Shadow Resistance +5 (Shadow Mantle of the Dawn)"
-- Zul'gurub Signets
LE[20077] = "Attack Power +30 (Zandalar Signet of Might)"
LE[20078] = "Spell Power +18 (Zandalar Signet of Serenity)"
LE[20076] = "Spell Power +18 (Zandalar Signet of Mojo)"
-- Naxxramas Sapphiron drops
LE[23545] = "Spell Power +15 / Crit Rating +14 (Power of the Scourge)"
LE[23547] = "Spell Power +16 / 5 mana per 5 sec. (Resilience of the Scourge)"
LE[23549] = "Stamina +16 / Armor +100 (Fortitude of the Scourge)"
LE[23548] = "Attack Power +26 / Crit Rating +14 (Might of the Scourge)"
-- Chest enchants Wrath
LE[-44623] = "All Stats +8 (Super Stats)"
LE[-60692] = "All Stats +10 (Powerful Stats)"
LE[-47766] = "Defense Rating +22 (Greater Defense)"
LE[-44492] = "Health +200 (Mighty Health)"
LE[-47900] = "Health +275 (Super Health)"
LE[-27958] = "Mana +250 (Exceptional Mana)"
LE[-44588] = "Resilience +20 (Exceptional Resilience)"
LE[-44509] = "8 mana per 5 sec. (Greater Mana Restoration)"
-- Chest enchants TBC
LE[-27960] = "All Stats +6 (Exceptional Stats)"
LE[-46594] = "Defense Rating +16 (Defense)"
LE[-27957] = "Health +150 (Exceptional Health)"
LE[-33992] = "Resilience +15 (Major Resilience)"
LE[-33990] = "Spirit +15 (Major Spirit)"
LE[-33991] = "6 mana per 5 sec. (Restore Mana Prime)"
-- Chest enchants Classic
LE[-7426] = "Absorption +10 (Minor Absorption)"
LE[-13538] = "Absorption +25 (Lesser Absorption)"
LE[-13626] = "All Stats +1 (Minor Stats)"
LE[-13700] = "All Stats +2 (Lesser Stats)"
LE[-13941] = "All Stats +3 (Stats)"
LE[-20025] = "All Stats +4 (Greater Stats)"
LE[-7420] = "Health +5 (Minor Health)"
LE[-7748] = "Health +15 (Lesser Health)"
LE[-7857] = "Health +25 (Health)"
LE[-13640] = "Health +35 (Greater Health)"
LE[-13858] = "Health +50 (Superior Health)"
LE[-20026] = "Health +100 (Major Health)"
LE[-7443] = "Mana +5 (Minor Mana)"
LE[-7776] = "Mana +20 (Lesser Mana)"
LE[-13607] = "Mana +30 (Mana)"
LE[-13663] = "Mana +50 (Greater Mana)"
LE[-13917] = "Mana +65 (Superior Mana)"
LE[-20028] = "Mana +100 (Major Mana)"
-- Tailoring Wrath leg enchants
LE[41601] = "Spell Power +35 / Spirit +12 (Shining Spellthread)"
LE[41603] = "Spell Power +35 / Stamina +20 (Azure Spellthread)"
LE[41602] = "Spell Power +50 / Spirit +20 (Brilliant Spellthread)"
LE[41604] = "Spell Power +50 / Stamina +30 (Sapphire Spellthread)"
LE[-56039] = "Spell Power +50 / Spirit +20 (Sanctified Spellthread)"
LE[-56034] = "Spell Power +50 / Stamina +30 (Master's Spellthread)"
-- Tailoring TBC leg enchants
LE[24275] = "Spell Power +25 / Stamina +15 (Silver Spellthread)"
LE[24273] = "Spell Power +25 / Stamina +15 (Mystic Spellthread)"
LE[24276] = "Spell Power +35 / Stamina +20 (Golden Spellthread)"
LE[24274] = "Spell Power +35 / Stamina +20 (Runic Spellthread)"
-- Leatherworking Wrath leg enchants
LE[38372] = "Attack Power +55 / Crit Rating +15 (Nerubian Leg Armor)"
LE[38374] = "Attack Power +75 / Crit Rating +22 (Icescale Leg Armor)"
LE[44963] = "Stamina +28 / Resilience +40 (Earthen Leg Armor)"
LE[38371] = "Stamina +45 / Agility +15 (Jormungar Leg Armor)"
LE[38373] = "Stamina +55 / Agility +22 (Frosthide Leg Armor)"
LE[-60584] = "Attack Power +75 / Crit Rating +22 (Nerubian Leg Reinforcements)"
LE[-60583] = "Stamina +55 / Agility +22 (Jormungar Leg Reinforcements)"
-- Leatherworking TBC leg enchants
LE[29533] = "Attack Power +40 / Crit Rating +10 (Cobrahide Leg Armor)"
LE[29535] = "Attack Power +50 / Crit Rating +12 (Nethercobra Leg Armor)"
LE[29534] = "Stamina +30 / Agility +10 (Clefthide Leg Armor)"
LE[29536] = "Stamina +40 / Agility +12 (Nethercleft Leg Armor)"
-- Feet Wrath enchants
LE[-44589] = "Agility +16 (Superior Agility)"
LE[-60606] = "Attack Power +24 (Assault)"
LE[-60763] = "Attack Power +32 (Greater Assault)"
LE[-60623] = "Crit Rating +12 / Hit Rating +12  (Icewalker)"
LE[-63746] = "Hit Rating +5 (Lesser Accuracy)"
LE[-47901] = "Minor Speed and +15 Stamina (Tuskarr's Vitality)"
LE[-44508] = "Spirit +18 (Greater Spirit)"
LE[-44528] = "Stamina +22 (Greater Fortitude)"
LE[-44584] = "6 health and mana per 5 sec.  (Greater Vitality)"
-- Feet TBC enchants
LE[-27951] = "Agility +12 (Dexterity)"
LE[-27954] = "Crit Rating +10 / Hit Rating +10 (Surefooted)"
LE[-34007] = "Minor Speed and +6 Agility (Cat's Swiftness)"
LE[-34008] = "Minor Speed and +9 Stamina (Boar's Speed)"
LE[-27950] = "Stamina +12 (Fortitude)"
LE[-27948] = "4 health and mana per 5 sec. (Vitality)"
-- Feet Classic enchants
LE[-7867] = "Agility +1 (Minor Agility)"
LE[-13637] = "Agility +3 (Lesser Agility)"
LE[-13935] = "Agility +5 (Agility)"
LE[-20023] = "Agility +7 (Greater Agility)"
LE[-13890] = "Minor Speed Increase (Minor Speed)"
LE[-7863] = "Stamina +1 (Minor Stamina)"
LE[-13644] = "Stamina +3 (Lesser Stamina)"
LE[-13836] = "Stamina +5 (Stamina)"
LE[-20020] = "Stamina +7 (Greater Stamina)"
LE[-13687] = "Spirit +3 (Lesser Spirit)"
LE[-20024] = "Spirit +5 (Spirit)"
-- Leatherworking Fur Lining bracer enchants
LE[-57701] = "Arcane Resist +70 (Fur Lining - Arcane Resist)"
LE[-57683] = "Attack Power +130 (Fur Lining - Attack Power)"
LE[-57692] = "Fire Resist +70 (Fur Lining - Fire Resist)"
LE[-57694] = "Frost Resist +70 (Fur Lining - Frost Resist)"
LE[-57699] = "Nature Resist +70 (Fur Lining - Nature Resist)"
LE[-57696] = "Shadow Resist +70 (Fur Lining - Shadow Resist)"
LE[-57691] = "Spell Power +76 (Fur Lining - Spell Power)"
LE[-57690] = "Stamina +102 (Fur Lining - Stamina)"
-- Bracer Wrath enchants
LE[-44616] = "All Stats +6 (Greater Stats)"
LE[-60616] = "Attack Power +38 (Striking)"
LE[-44575] = "Attack Power +50 (Greater Assault)"
LE[-44598] = "Expertise Rating +15 (Expertise)"
LE[-44555] = "Intellect +16 (Exceptional Intellect)"
LE[-44635] = "Spell Power +23 (Greater Spellpower)"
LE[-60767] = "Spell Power +30 (Superior Spellpower)"
LE[-44593] = "Spirit +18 (Major Spirit)"
LE[-62256] = "Stamina +40 (Major Stamina)"
-- Bracer TBC enchants
LE[-27905] = "All Stats +4 (Stats)"
LE[-34002] = "Attack Power +24 (Assault)"
LE[-27906] = "Defense Rating +12 (Major Defense)"
LE[-34001] = "Intellect +12 (Major Intellect)"
LE[-27917] = "Spell Power +15 (Spellpower)"
LE[-27911] = "Spell Power +15 (Superior Healing)"
LE[-27914] = "Stamina +12 (Fortitude)"
LE[-27899] = "Strength +12 (Brawn)"
LE[-27913] = "6 mana per 5 sec. (Restore Mana Prime)"
-- Bracer Classic enchants
LE[-7779] = "Agility +1 (Minor Agility)"
LE[-7428] = "Defense Rating +2 (Minor Deflection)"
LE[-13646] = "Defense Rating +3 (Lesser Deflection)"
LE[-13931] = "Defense Rating +5 (Deflection)"
LE[-13622] = "Intellect +3 (Lesser Intellect)"
LE[-13822] = "Intellect +5 (Intellect)"
LE[-20008] = "Intellect +7 (Greater Intellect)"
LE[-7418] = "Health +5 (Minor Health)"
LE[-23802] = "Spell Power +15 (Healing Power)"
LE[-7766] = "Spirit +1 (Minor Spirit)"
LE[-7859] = "Spirit +3 (Lesser Spirit)"
LE[-13642] = "Spirit +5 (Spirit)"
LE[-13846] = "Spirit +7 (Greater Spirit)"
LE[-20009] = "Spirit +9 (Superior Spirit)"
LE[-7457] = "Stamina +1 (Minor Stamina)"
LE[-13501] = "Stamina +3 (Lesser Stamina)"
LE[-13648] = "Stamina +5 (Stamina)"
LE[-13945] = "Stamina +7 (Greater Stamina)"
LE[-20011] = "Stamina +9 (Superior Stamina)"
LE[-7782] = "Strength +1 (Minor Strength)"
LE[-13536] = "Strength +3 (Lesser Strength)"
LE[-13661] = "Strength +5 (Strength)"
LE[-13939] = "Strength +7 (Greater Strength)"
LE[-20010] = "Strength +9 (Superior Strength)"
LE[-23801] = "4 mana per 5 sec. (Mana Regeneration)"
-- Blacksmithing boot enchants
LE[7969] = "Mount Speed +4% (Mithril Spurs)"
-- Glove Leatherworking enchant
LE[34207] = "Armor +240 (Glove Reinforcements)"
-- Glove Wrath enchants
LE[-44529] = "Agility +20 (Major Agility)"
LE[-44513] = "Attack Power +35 (Greater Assault)"
LE[-60668] = "Attack Power +44 (Crusher)"
LE[-44484] = "Expertise Rating +15 (Expertise)"
LE[-44506] = "Herbalism +5 / Mining +5 / Skinning +5 (Gatherer)"
LE[-44488] = "Hit Rating +20 (Precision)"
LE[-44625] = "Parry Rating +10 / Threat +2% (Armsman)"
LE[-44592] = "Spell Power +28 (Exceptional Spellpower)"
LE[-71692] = "Fishing +5 (Angler)"
-- Glove TBC enchants
LE[-33996] = "Attack Power +26 (Assault)"
LE[-33993] = "Crit Rating +10 (Blasting)"
LE[-33994] = "Hit Rating +15 (Precise Strikes)"
LE[-33999] = "Spell Power +19 (Major Healing)"
LE[-33997] = "Spell Power +20 (Major Spellpower)"
LE[-33995] = "Strength +15 (Major Strength)"
-- Glove Classic enchants
LE[-13815] = "Agility +5 (Agility)"
LE[-20012] = "Agility +7 (Greater Agility)"
LE[-25080] = "Agility +15 (Superior Agility)"
LE[-25078] = "Fire Spell Power +20 (Fire Power)"
LE[-13620] = "Fishing +5 (Fishing)"
LE[-25074] = "Frost Spell Power +20 (Frost Power)"
LE[-13948] = "Haste Rating +10 (Minor Haste)"
LE[-13617] = "Herbalism +2 (Herbalism)"
LE[-13868] = "Herbalism +5 (Advanced Herbalism)"
LE[-13612] = "Mining +2 (Mining)"
LE[-13841] = "Mining +5 (Advanced Mining)"
LE[-13947] = "Mount Speed +2% (Riding Skill)"
LE[-25073] = "Shadow Spell Power +20 (Shadow Power)"
LE[-13698] = "Skinning +5 (Skinning)"
LE[-25079] = "Spell Power +16 (Healing Power)"
LE[-13887] = "Strength +5 (Strength)"
LE[-20013] = "Strength +7 (Greater Strength)"
LE[-25072] = "Threat +2% (Threat)"
-- Ring Wrath enchants
LE[-44645] = "Attack Power +40 (Assault)"
LE[-44636] = "Spell Power +23 (Greater Spellpower)"
LE[-59636] = "Stamina +30 (Stamina)"
-- Ring TBC enchants
LE[-27927] = "All Stats +4 (Stats)"
LE[-27926] = "Spell Power +12 (Healing Power)"
LE[-27924] = "Spell Power +12 (Spellpower)"
LE[-27920] = "Weapon Damage +2 (Striking)"
-- Tailor cloak enchants
LE[-55777] = "Spirit +1 / Melee/Ranged Proc: Melee Attack Power +400 for 15 sec (Swordguard Embroidery)"
LE[-55769] = "Spirit +1 / Spellcast Proc: +400 Mana instant (Darkglow Embroidery)"
LE[-55642] = "Spirit +1 / Spellcast Proc: Spell Power +295 for 15 sec (Lightweave Embroidery)"
-- Cloak Wrath enchants
LE[-44631] = "Agility +10 / Stealth +5 (Shadow Armor)"
LE[-44500] = "Agility +16 (Superior Agility)"
LE[-60663] = "Agility +22 (Major Agility)"
LE[-44596] = "Arcane Resistance +20 (Superior Arcane Resistance)"
LE[-47672] = "Armor +225 (Mighty Armor)"
LE[-44591] = "Defense Rating +16 (Titanweave)"
LE[-44556] = "Fire Resistance +20 (Superior Fire Resistance)"
LE[-44483] = "Frost Resistance +20 (Superior Frost Resistance)"
LE[-60609] = "Haste Rating +15 (Speed)"
LE[-47898] = "Haste Rating +23 (Greater Speed)"
LE[-44494] = "Nature Resistance +20 (Superior Nature Resistance)"
LE[-44590] = "Shadow Resistance +20 (Superior Shadow Resistance)"
LE[-44582] = "Spell Penetration +35 (Spell Piercing)"
LE[-47899] = "Spirit +10 / Threat -2% (Wisdom)"
-- Cloak TBC enchants
LE[-34004] = "Agility +12 (Greater Agility)"
LE[-27962] = "All Resistances +7 (Major Resistance)"
LE[-34005] = "Arcane Resistance +15 (Greater Arcane Resistance)"
LE[-27961] = "Armor +120 (Major Armor)"
LE[-47051] = "Defense Rating +12 (Steelweave)"
LE[-25086] = "Dodge Rating +12 (Dodge)"
LE[-34006] = "Shadow Resistance +15 (Greater Shadow Resistance)"
LE[-34003] = "Spell Penetration +20 (Spell Penetration)"
-- Cloak Classic enchants
LE[-13419] = "Agility +1 (Minor Agility)"
LE[-13882] = "Agility +3 (Lesser Agility)"
LE[-7454] = "All Resistances +1 (Minor Resistance)"
LE[-13794] = "All Resistances +3 (Resistance)"
LE[-20014] = "All Resistances +5 (Greater Resistance)"
LE[-7771] = "Armor +10 (Minor Protection)"
LE[-13421] = "Armor +20 (Lesser Protection)"
LE[-13635] = "Armor +30 (Defense)"
LE[-13746] = "Armor +50 (Greater Defense)"
LE[-20015] = "Armor +70 (Superior Defense)"
LE[-7861] = "Fire Resistance +5 (Lesser Fire Resistance)"
LE[-13657] = "Fire Resistance +7 (Fire Resistance)"
LE[-25081] = "Fire Resistance +15 (Greater Fire Resistance)"
LE[-25082] = "Nature Resistance +15 (Greater Nature Resistance)"
LE[-13522] = "Shadow Resistance +10 (Lesser Shadow Resistance)"
LE[-25083] = "Stealth +5 (Stealth)"
LE[-25084] = "Threat -2% (Subtlety)"
-- Blacksmithing shield enchants
LE[6042] = "Iron Spike: 8-12 (Iron Shield Spike)"
LE[7967] = "Mithril Spike: 16-20 (Mithril Shield Spike)"
LE[12645] = "Thorium Spike: 20-30 (Thorium Shield Spike)"
LE[23530] = "Felsteel Spike: 26-38 (Felsteel Shield Spike)"
LE[42500] = "Titanium Spike: 45-67 (Titanium Shield Spike)"
LE[44936] = "Block Value +40, Disarm duration -50% (Titanium Plating)"
-- Shield Wrath enchants
LE[-44489] = "Defense Rating +20 (Defense)"
LE[-60653] = "Intellect +25 (Greater Intellect)"
-- Shield TBC enchants
LE[-27947] = "All Resistances +5 (Resistance)"
LE[-27944] = "Block Value +18 (Tough Shield)"
LE[-27945] = "Intellect +12 (Intellect)"
LE[-44383] = "Resilience +12 (Resilience)"
LE[-27946] = "Shield Block Rating +15 (Shield Block)"
LE[-34009] = "Stamina +18 (Major Stamina)"
-- Shield Classic enchants
LE[-13464] = "Armor +30 (Lesser Protection)"
LE[-13933] = "Frost Resistance +8 (Frost Resistance)"
LE[-13689] = "Shield Block Rating +10 (Lesser Block)"
LE[-13485] = "Spirit +3 (Lesser Spirit)"
LE[-13659] = "Spirit +5 (Spirit)"
LE[-13905] = "Spirit +7 (Greater Spirit)"
LE[-20016] = "Spirit +9 (Superior Spirit)"
LE[-13378] = "Stamina +1 (Minor Stamina)"
LE[-13631] = "Stamina +3 (Lesser Stamina)"
LE[-13817] = "Stamina +5 (Stamina)"
LE[-20017] = "Stamina +7 (Greater Stamina)"
-- Blacksmith weapon enchants
LE[6043] = "Haste Rating +20 (Iron Counterweight)"
LE[6041] = "Disarm duration -50% (Steel Weapon Chain)"
LE[33185] = "Disarm duration -50% / Parry Rating +15 (Adamantite Weapon Chain)"
LE[41976] = "Disarm duration -50% / Hit Rating +28 (Titanium Weapon Chain)"
-- Quest weapon enchants
LE[5421] = "Fiery Blaze (Fiery Blaze Enchantment)"
-- Weapon Wrath enchants
LE[-44633] = "Agility +26 (Exceptional Agility)"
LE[-60621] = "Attack Power +50 (Greater Potency)"
LE[-60707] = "Attack Power +65 (Superior Potency)"
LE[-59619] = "Crit Rating +25 / Hit Rating +25 (Accuracy)"
LE[-59621] = "Melee Proc: Attack Power +400, Armor -5% for 15 sec (Berserking)"
LE[-64441] = "Melee Proc: Parry Rating +200, 700 dmg on next parry for 10 sec (Blade Ward)"
LE[-44621] = "Melee Proc: 280 Dmg, Movement -25% vs Giants for 15 sec (Giant Slayer)"
LE[-44576] = "Melee Proc: 333 Heal instant (Lifeward)"
LE[-44524] = "Melee Proc: 200 Fire Dmg (Icebreaker)"
LE[-64579] = "Melee/Bleed Proc: Blood Reserve up to 5 stacks for 20 sec (Blood Draining)"
LE[-59625] = "Spelldmg Proc: 250 Haste for 10 sec (45 sec internal cd) (Black Magic)"
LE[-44629] = "Spell Power +50 (Exceptional Spellpower)"
LE[-60714] = "Spell Power +63 (Mighty Spellpower)"
LE[-44510] = "Spirit +45 (Exceptional Spirit)"
-- Weapon TBC enchants
LE[-42620] = "Agility +20 (Greater Agility)"
LE[-27967] = "Damage +7 (Major Striking)"
LE[-27981] = "Fire/Arcane Spell Power +50 (Sunfire)"
LE[-27982] = "Frost/Shadow Spell Power +54 (Soulfrost)"
LE[-27968] = "Intellect +30 (Major Intellect)"
LE[-27984] = "Melee Proc: Agility +120, Attack Speed +2% for 15 sec (Mongoose)"
LE[-42974] = "Melee Proc: Armor Penetration Rating +120 for 15 sec (Executioner)"
LE[-28004] = "Melee Proc: 240 Heal instant to party members (Battlemaster)"
LE[-46578] = "Melee/Spelldmg Proc: 150 Frost Dmg, 15% Slow for 8 sec (Deathfrost)"
LE[-34010] = "Spell Power +40 (Major Healing)"
LE[-27975] = "Spell Power +40 (Major Spellpower)"
LE[-28003] = "Spellcast Proc: +100 Mana to party over 10 sec (Spellsurge)"
LE[-27972] = "Strength +20 (Potency)"
-- Weapon enchants
LE[-23800] = "Agility +15 (Agility)"
LE[-7788] = "Damage +1 (Minor Striking)"
LE[-13503] = "Damage +2 (Lesser Striking)"
LE[-13693] = "Damage +3 (Striking)"
LE[-13943] = "Damage +4 (Greater Striking)"
LE[-20031] = "Damage +5 (Superior Striking)"
LE[-7786] = "Damage vs Beasts +2 (Minor Beastslayer)"
LE[-13653] = "Damage vs Beasts +6 (Lesser Beastslayer)"
LE[-13655] = "Damage vs Elementals +6 (Lesser Elemental Slayer)"
LE[-21931] = "Frost Spell Power +7 (Winter's Might)"
LE[-20029] = "Melee Proc: Movement -30%, Attack Speed -25% for 5 sec (Icy Chill)"
LE[-20033] = "Melee Proc: -15 Damage on target for 12 sec (Unholy Weapon)"
LE[-20032] = "Melee Proc: 30 Shadow Dmg, 30 Heal (Lifestealing)"
LE[-13898] = "Melee Proc: 40 Fire Dmg (Fiery Weapon)"
LE[-20034] = "Melee Proc: 100 Heal, Strength +100 for 15 sec (Crusader)"
LE[-13915] = "Melee Proc: 100 Holy Dmg, Stun vs Undead for 5 sec (Demonslaying)"
LE[-23804] = "Intellect +22 (Mighty Intellect)"
LE[-22750] = "Spell Power +29 (Healing Power)"
LE[-22749] = "Spell Power +30 (Spell Power)"
LE[-23803] = "Spirit +20 (Mighty Spirit)"
LE[-23799] = "Strength +15 (Strength)"
-- 2H Weapon Wrath enchants
LE[-44630] = "Attack Power +85 (Greater Savagery)"
LE[-60691] = "Attack Power +110 (Massacre)"
LE[-44595] = "Attack Power vs Undead +140 (Scourgebane)"
-- 2H Weapon TBC enchants
LE[-27977] = "Agility +35 (Major Agility)"
LE[-27971] = "Attack Power +70 (Savagery)"
-- 2H Weapon Classic enchants
LE[-27837] = "Agility +25 (Agility)"
LE[-7745] = "Damage +2 (Minor Impact)"
LE[-13529] = "Damage +3 (Lesser Impact)"
LE[-13695] = "Damage +5 (Impact)"
LE[-13937] = "Damage +7 (Greater Impact)"
LE[-20030] = "Damage +9 (Superior Impact)"
LE[-7793] = "Intellect +3 (Lesser Intellect)"
LE[-20036] = "Intellect +9 (Major Intellect)"
LE[-13380] = "Spirit +3 (Lesser Spirit)"
LE[-20035] = "Spirit +9 (Major Spirit)"
-- Runeforging enchants
LE[-54446] = "Parry +2% / Disarm Duration -50% (Rune of Swordbreaking)"
LE[-54447] = "Spell Damage Deflect 2% / Silence Duration -50% (Rune of Spellbreaking)"
LE[-70164] = "Defense +13 / Stamina +1% (Rune of the Nerubian Carapace)"
LE[-62158] = "Defense +25 / Stamina +2% (Rune of the Stoneskin Gargoyle)"
LE[-53323] = "Parry +4% / Disarm Duration -50% (Rune of Swordshattering)"
LE[-53342] = "Spell Damage Deflect 4% / Silence Duration -50% (Rune of Spellshattering)"
LE[-53331] = "+2% Weapon Damage / +4% Weapon Damage vs Undead (Rune of Lichbane)"
LE[-53343] = "+2% Weapon Damage / Melee Proc: +1% Frost Damage up to 5 debuff stacks (Rune of Razorice)"
LE[-53344] = "Melee Proc: Heal 3% HP and +15% Strength for 15 sec (Rune of the Fallen Crusader)"
LE[-53341] = "Melee Proc: Next 2 Frost/Shadow attacks +20% damage (Rune of Cinderglacier)"
-- Ranged weapon enchants
LE[4405] = "Damage +1 (Crude Scope)"
LE[4406] = "Damage +2 (Standard Scope)"
LE[4407] = "Damage +3 (Accurate Scope)"
LE[10546] = "Damage +5 (Deadly Scope)"
LE[10548] = "Damage +7 (Sniper Scope)"
LE[23764] = "Damage +10 (Adamantite Scope)"
LE[23765] = "Damage +12 (Khorium Scope)"
LE[44739] = "Damage +15 (Diamond-cut Refractor Scope)"
LE[23766] = "Ranged Crit Rating +28 (Stabilized Eternium Scope)"
LE[41167] = "Ranged Crit Rating +40 (Heartseeker Scope)"
LE[41146] = "Ranged Haste Rating +40 (Sun Scope)"
LE[18283] = "Ranged Hit Rating +30 (Biznicks 247x128 Accurascope)"
-- Fishing enchants
LE[34836] = "Fishing +3 (Spun Truesilver Fishing Line)"
LE[19971] = "Fishing +5 (High Test Eternium Fishing Line)"
-- Staff Wrath enchants
LE[-62959] = "Spell Power +69 (Spellpower)"
LE[-62948] = "Spell Power +81 (Greater Spellpower)"
-- Engineering boot enchants
LE[-55016] = "Crit Rating +24 / Use: +150% Run Speed for 5 sec (Nitro Boots) (3 min cd)"
-- Engineering glove enchants
LE[-63770] = "Armor +885 (Reticulated Armor Webbing)"
LE[-54999] = "Use: +340 Haste Rating for 12 sec (Hyperspeed Accelerators) (1 min cd)"
LE[-54998] = "Use: 1850 Fire Damage (Hand-Mounted Pyro Rocket) (45s cd)"
-- Engineering belt enchants
LE[-54736] = "Use: 3 sec Stun vs mechanical (Personal Electromagnetic Pulse Generator) (1 min cd)"
LE[-54793] = "Use: Throw Cobalt Frag Bomb (850 Fire Damage, 5 yard AOE) (Frag Belt) (6 min cd)"
-- Engineering cloak enchants
LE[-55002] = "Agility +23 / Use: Slow Fall for 30 sec (Flexweave Underlay) (1 min cd)"
LE[-63765] = "Spell Power +27 / Use: Slow Fall for 30 sec (Springy Arachnoweave) (1 min cd)"
-- Engineering head enchant
LE[-67839] = "45 Stamina / Use: Mind control (Mind Amplification Dish) (10 min cd)"

-- Crafted Uncommon Quality Gems
LE[39927] = "(Lustrous Chalcedony) +5 MP5"
LE[39919] = "(Solid Chalcedony) +18 Stamina"
LE[39920] = "(Sparkling Chalcedony) +12 Spirit"
LE[39932] = "(Stormy Chalcedony) 15 Spell Penetration"

LE[39900] = "(Bold Bloodstone) +12 Strength"
LE[39906] = "(Bright Bloodstone) +24 Attack Power"
LE[39905] = "(Delicate Bloodstone) +12 Agility"
LE[39908] = "(Flashing Bloodstone) +12 Parry Rating"
LE[39909] = "(Fractured Bloodstone) +12 Armor Penetration Rating"
LE[39910] = "(Precise Bloodstone) +12 Expertise Rating"
LE[39911] = "(Runed Bloodstone) +14 Spell Power"
LE[39907] = "(Subtle Bloodstone) +12 Dodge Rating"

LE[39912] = "(Brilliant Sun Crystal) +12 Intellect"
LE[39917] = "(Mystic Sun Crystal) +12 Resilience"
LE[39918] = "(Quick Sun Crystal) +12 Haste Rating"
LE[39915] = "(Rigid Sun Crystal) +12 Hit Rating"
LE[39914] = "(Smooth Sun Crystal) +12 Crit Rating"
LE[39916] = "(Thick Sun Crystal) +12 Defense Rating"

LE[39984] = "(Dazzling Dark Jade) +6 Intellect, +2 MP5"
LE[39976] = "(Enduring Dark Jade) +6 Defense Rating, +9 Stamina"
LE[39989] = "(Energized Dark Jade) +6 Haste Rating, +2 MP5"
LE[39978] = "(Forceful Dark Jade) +6 Haste Rating, +9 Stamina"
LE[39983] = "(Intricate Dark Jade) +6 Haste Rating, +6 Spirit"
LE[39974] = "(Jagged Dark Jade) +6 Crit Rating, +9 Stamina"
LE[39986] = "(Lambert Dark Jade) +6 Hit Rating, +2 MP5"
LE[39980] = "(Misty Dark Jade) +6 Crit Rating, +6 Spirit"
LE[39988] = "(Opaque Dark Jade) +6 Resilience, +2 MP5"
LE[39990] = "(Radiant Dark Jade) +6 Crit Rating, +8 Spell Penetration"
LE[39979] = "(Seer's Dark Jade) +6 Intellect, +6 Spirit"
LE[39992] = "(Shattered Dark Jade) +6 Haste Rating, +8 Spell Penetration"
LE[39981] = "(Shining Dark Jade) +6 Hit Rating, +6 Spirit"
LE[39977] = "(Steady Dark Jade) +6 Resilience, +9 Stamina"
LE[39985] = "(Sundered Dark Jade) +6 Crit Rating, +2 MP5"
LE[39991] = "(Tense Dark Jade) +6 Hit Rating, +8 Spell Penetration"
LE[39968] = "(Timeless Dark Jade) +6 Intellect, +9 Stamina"
LE[39982] = "(Turbid Dark Jade) +6 Resilience, +6 Spirit"
LE[39975] = "(Vivid Dark Jade) +6 Hit Rating, +9 Stamina"

LE[39966] = "(Accurate Huge Citrine) +6 Expertise Rating, +6 Hit Rating"
LE[39949] = "(Champion's Huge Citrine) +6 Strength, +6 Defense Rating"
LE[39952] = "(Deadly Huge Citrine) +6 Agility, +6 Crit Rating"
LE[39955] = "(Deft Huge Citrine) +6 Agility, +6 Haste Rating"
LE[39958] = "(Durable Huge Citrine) +7 Spell Power, +6 Resilience"
LE[39962] = "(Empowered Huge Citrine) +12 Attack Power, +6 Resilience"
LE[39948] = "(Etched Huge Citrine) +6 Strength, +6 Hit Rating"
LE[39951] = "(Fierce Huge Citrine) +6 Strength, +6 Haste Rating"
LE[39965] = "(Glimmering Huge Citrine) +6 Parry Rating, +6 Defense Rating"
LE[39953] = "(Glinting Huge Citrine) +6 Agility, +6 Hit Rating"
LE[39947] = "(Inscribed Huge Citrine) +6 Strength, +6 Crit Rating"
LE[39954] = "(Lucent Huge Citrine) +6 Agility, +6 Resilience"
LE[39946] = "(Luminous Huge Citrine) +7 Spell Power, +6 Intellect"
LE[39956] = "(Potent Huge Citrine) +7 Spell Power, +6 Crit Rating"
LE[39961] = "(Pristine Huge Citrine) +12 Attack Power, +6 Hit Rating"
LE[39959] = "(Reckless Huge Citrine) +7 Spell Power, +6 Haste Rating"
LE[39967] = "(Resolute Huge Citrine) +6 Expertise Rating, +6 Defense Rating"
LE[39950] = "(Resplendent Huge Citrine) +6 Strength, +6 Resilience"
LE[39964] = "(Stalwart Huge Citrine) +6 Dodge Rating, +6 Defense Rating"
LE[39963] = "(Stark Huge Citrine) +12 Attack Power, +6 Haste Rating"
LE[39957] = "(Veiled Huge Citrine) +7 Spell Power, +6 Hit Rating"
LE[39960] = "(Wicked Huge Citrine) +12 Attack Power, +6 Crit Rating"

LE[39937] = "(Balanced Shadow Crystal) +12 Attack Power, +9 Stamina"
LE[39939] = "(Defender's Shadow Crystal) +6 Parry Rating, +9 Stamina"
LE[39936] = "(Glowing Shadow Crystal) +7 Spell Power, +9 Stamina"
LE[39940] = "(Guardian Shadow Crystal) +6 Expertise Rating, +9 Stamina"
LE[39944] = "(Infused Shadow Crystal) +12 Attack Power, +2 MP5"
LE[39945] = "(Mysterious Shadow Crystal) +7 Spell Power, +8 Spell Penetration"
LE[39933] = "(Puissant Shadow Crystal) +6 Armor Penetration Rating, +9 Stamina"
LE[39941] = "(Purified Shadow Crystal) +7 Spell Power, +6 Spirit"
LE[39938] = "(Regal Shadow Crystal) +6 Dodge Rating, +9 Stamina"
LE[39943] = "(Royal Shadow Crystal) +7 Spell Power, +2 MP5"
LE[39935] = "(Shifting Shadow Crystal) +6 Agility, +9 Stamina"
LE[39934] = "(Sovereign Shadow Crystal) +6 Strength, +9 Stamina"
LE[39942] = "(Tenuous Shadow Crystal) +6 Agility, +2 MP5"

LE[42701] = "(Enchanted Pearl) +4 All Stats (UE)"

-- Crafted Uncommon Perfect Quality Gems
LE[41440] = "(Perfect Lustrous Chalcedony) +6 MP5"
LE[41441] = "(Perfect Solid Chalcedony) +21 Stamina"
LE[41442] = "(Perfect Sparkling Chalcedony) +14 Spirit"
LE[41443] = "(Perfect Stormy Chalcedony) +18 Spell Penetration"

LE[41432] = "(Perfect Bold Bloodstone) +14 Strength"
LE[41433] = "(Perfect Bright Bloodstone) +28 Attack Power"
LE[41434] = "(Perfect Delicate Bloodstone) +14 Agility"
LE[41435] = "(Perfect Flashing Bloodstone) +14 Parry Rating"
LE[41436] = "(Perfect Fractured Bloodstone) +14 Armor Penetration Rating"
LE[41437] = "(Perfect Precise Bloodstone) +14 Expertise Rating"
LE[41438] = "(Perfect Runed Bloodstone) +16 Spell Power"
LE[41439] = "(Perfect Subtle Bloodstone) +14 Dodge Rating"

LE[41444] = "(Perfect Brilliant Sun Crystal) +14 Intellect"
LE[41445] = "(Perfect Mystic Sun Crystal) +14 Resilience"
LE[41446] = "(Perfect Quick Sun Crystal) +14 Haste Rating"
LE[41447] = "(Perfect Rigid Sun Crystal) +14 Hit Rating"
LE[41448] = "(Perfect Smooth Sun Crystal) +14 Crit Rating"
LE[41449] = "(Perfect Thick Sun Crystal) +14 Defense Rating"

LE[41463] = "(Perfect Dazzling Dark Jade) +7 Intellect, +3 MP5"
LE[41464] = "(Perfect Enduring Dark Jade) +7 Defense Rating, +11 Stamina"
LE[41465] = "(Perfect Energized Dark Jade) +7 Haste Rating, +3 MP5"
LE[41466] = "(Perfect Forceful Dark Jade) +7 Haste Rating, +11 Stamina"
LE[41467] = "(Perfect Intricate Dark Jade) +7 Haste Rating, +7 Spirit"
LE[41468] = "(Perfect Jagged Dark Jade) +7 Crit Rating, +11 Stamina"
LE[41469] = "(Perfect Lambert Dark Jade) +7 Hit Rating, +3 MP5"
LE[41470] = "(Perfect Misty Dark Jade) +7 Crit Rating, +7 Spirit"
LE[41471] = "(Perfect Opaque Dark Jade) +7 Resilience, +3 MP5"
LE[41472] = "(Perfect Radiant Dark Jade) +7 Crit Rating, +9 Spell Penetration"
LE[41473] = "(Perfect Seer's Dark Jade) +7 Intellect, +7 Spirit"
LE[41474] = "(Perfect Shattered Dark Jade) +7 Haste Rating, +9 Spell Penetration"
LE[41475] = "(Perfect Shining Dark Jade) +7 Hit Rating, +7 Spirit"
LE[41476] = "(Perfect Steady Dark Jade) +7 Resilience, +11 Stamina"
LE[41477] = "(Perfect Sundered Dark Jade) +7 Crit Rating, +3 MP5"
LE[41478] = "(Perfect Tense Dark Jade) +7 Hit Rating, +9 Spell Penetration"
LE[41479] = "(Perfect Timeless Dark Jade) +7 Intellect, +11 Stamina"
LE[41480] = "(Perfect Turbid Dark Jade) +7 Resilience, +7 Spirit"
LE[41481] = "(Perfect Vivid Dark Jade) +7 Hit Rating, +11 Stamina"

LE[41482] = "(Perfect Accurate Huge Citrine) +7 Expertise Rating, +7 Hit Rating"
LE[41483] = "(Perfect Champion's Huge Citrine) +7 Strength, +7 Defense Rating"
LE[41484] = "(Perfect Deadly Huge Citrine) +7 Agility, +7 Crit Rating"
LE[41485] = "(Perfect Deft Huge Citrine) +7 Agility, +7 Haste Rating"
LE[41486] = "(Perfect Durable Huge Citrine) +8 Spell Power, +7 Resilience"
LE[41487] = "(Perfect Empowered Huge Citrine) +14 Attack Power, +7 Resilience"
LE[41488] = "(Perfect Etched Huge Citrine) +7 Strength, +7 Hit Rating"
LE[41489] = "(Perfect Fierce Huge Citrine) +7 Strength, +7 Haste Rating"
LE[41490] = "(Perfect Glimmering Huge Citrine) +7 Parry Rating, +7 Defense Rating"
LE[41491] = "(Perfect Glinting Huge Citrine) +7 Agility, +7 Hit Rating"
LE[41492] = "(Perfect Inscribed Huge Citrine) +7 Strength, +7 Crit Rating"
LE[41493] = "(Perfect Lucent Huge Citrine) +7 Agility, +7 Resilience"
LE[41494] = "(Perfect Luminous Huge Citrine) +8 Spell Power, +7 Intellect"
LE[41495] = "(Perfect Potent Huge Citrine) +8 Spell Power, +7 Crit Rating"
LE[41496] = "(Perfect Pristine Huge Citrine) +14 Attack Power, +7 Hit Rating"
LE[41497] = "(Perfect Reckless Huge Citrine) +8 Spell Power, +7 Haste Rating"
LE[41498] = "(Perfect Resolute Huge Citrine) +7 Expertise Rating, +7 Defense Rating"
LE[41499] = "(Perfect Resplendent Huge Citrine) +7 Strength, +7 Resilience"
LE[41500] = "(Perfect Stalwart Huge Citrine) +7 Dodge Rating, +7 Defense Rating"
LE[41501] = "(Perfect Stark Huge Citrine) +14 Attack Power, +7 Haste Rating"
LE[41502] = "(Perfect Veiled Huge Citrine) +8 Spell Power, +7 Hit Rating"
LE[41429] = "(Perfect Wicked Huge Citrine) +14 Attack Power, +7 Crit Rating"

LE[41450] = "(Perfect Balanced Shadow Crystal) +14 Attack Power, +11 Stamina"
LE[41451] = "(Perfect Defender's Shadow Crystal) +7 Parry Rating, +11 Stamina"
LE[41452] = "(Perfect Glowing Shadow Crystal) +8 Spell Power, +11 Stamina"
LE[41453] = "(Perfect Guardian Shadow Crystal) +7 Expertise Rating, +11 Stamina"
LE[41454] = "(Perfect Infused Shadow Crystal) +14 Attack Power, +3 MP5"
LE[41455] = "(Perfect Mysterious Shadow Crystal) +8 Spell Power, +8 Spell Penetration"
LE[41456] = "(Perfect Puissant Shadow Crystal) +7 Armor Penetration Rating, +11 Stamina"
LE[41457] = "(Perfect Purified Shadow Crystal) +8 Spell Power, +7 Spirit"
LE[41458] = "(Perfect Regal Shadow Crystal) +7 Dodge Rating, +11 Stamina"
LE[41459] = "(Perfect Royal Shadow Crystal) +8 Spell Power, +3 MP5"
LE[41460] = "(Perfect Shifting Shadow Crystal) +7 Agility, +11 Stamina"
LE[41461] = "(Perfect Sovereign Shadow Crystal) +7 Strength, +11 Stamina"
LE[41462] = "(Perfect Tenuous Shadow Crystal) +7 Agility, +3 MP5"

-- Crafted Rare Quality Gems
LE[40010] = "(Lustrous Sky Sapphire) +6 MP5"
LE[40008] = "(Solid Sky Sapphire) +24 Stamina"
LE[40009] = "(Sparkling Sky Sapphire) +16 Spirit"
LE[40011] = "(Stormy Sky Sapphire) +20 Spell Penetration"

LE[39996] = "(Bold Scarlet Ruby) +16 Strength"
LE[39999] = "(Bright Scarlet Ruby) +32 Attack Power"
LE[39997] = "(Delicate Scarlet Ruby) +16 Agility"
LE[40001] = "(Flashing Scarlet Ruby) +16 Parry Rating"
LE[40002] = "(Fractured Scarlet Ruby) +16 Armor Penetration Rating"
LE[40003] = "(Precise Scarlet Ruby) +16 Expertise Rating"
LE[39998] = "(Runed Scarlet Ruby) +19 Spell Power"
LE[40000] = "(Subtle Scarlet Ruby) +16 Dodge Rating"

LE[40012] = "(Brilliant Autumn's Glow) +16 Intellect"
LE[40016] = "(Mystic Autumn's Glow) +16 Resilience"
LE[40017] = "(Quick Autumn's Glow) +16 Haste Rating"
LE[40014] = "(Rigid Autumn's Glow) +16 Hit Rating"
LE[40013] = "(Smooth Autumn's Glow) +16 Crit Rating"
LE[40015] = "(Thick Autumn's Glow) +16 Defense Rating"

LE[40094] = "(Dazzling Forest Emerald) +8 Intellect, +3 MP5"
LE[40089] = "(Enduring Forest Emerald) +8 Defense Rating, +12 Stamina"
LE[40105] = "(Energized Forest Emerald) +8 Haste Rating, +3 MP5"
LE[40091] = "(Forceful Forest Emerald) +8 Haste Rating, +12 Stamina"
LE[40104] = "(Intricate Forest Emerald) +8 Haste Rating, +8 Spirit"
LE[40086] = "(Jagged Forest Emerald) +8 Crit Rating, +12 Stamina"
LE[40100] = "(Lambert Forest Emerald) +8 Hit Rating, +3 MP5"
LE[40095] = "(Misty Forest Emerald) +8 Crit Rating, +8 Spirit"
LE[40103] = "(Opaque Forest Emerald) +8 Resilience, +3 MP5"
LE[40098] = "(Radiant Forest Emerald) +8 Crit Rating, 10 Spell Penetration"
LE[40092] = "(Seer's Forest Emerald) +8 Intellect, +8 Spirit"
LE[40106] = "(Shattered Forest Emerald) +8 Haste Rating, 10 Spell Penetration"
LE[40099] = "(Shining Forest Emerald) +8 Hit Rating, +8 Spirit"
LE[40090] = "(Steady Forest Emerald) +8 Resilience, +12 Stamina"
LE[40096] = "(Sundered Forest Emerald) +8 Crit Rating, +3 MP5"
LE[40101] = "(Tense Forest Emerald) +8 Hit Rating, 10 Spell Penetration"
LE[40085] = "(Timeless Forest Emerald) +8 Intellect, +12 Stamina"
LE[40102] = "(Turbid Forest Emerald) +8 Resilience, +8 Spirit"
LE[40088] = "(Vivid Forest Emerald) +8 Hit Rating, +12 Stamina"

LE[40058] = "(Accurate Monarch Topaz) +8 Expertise Rating, +8 Hit Rating"
LE[40039] = "(Champion's Monarch Topaz) +8 Strength, +8 Defense Rating"
LE[40043] = "(Deadly Monarch Topaz) +8 Agility, +8 Crit Rating"
LE[40046] = "(Deft Monarch Topaz) +8 Agility, +8 Haste Rating"
LE[40050] = "(Durable Monarch Topaz) +9 Spell Power, +8 Resilience"
LE[40054] = "(Empowered Monarch Topaz) +16 Attack Power, +8 Resilience"
LE[40038] = "(Etched Monarch Topaz) +8 Strength, +8 Hit Rating"
LE[40041] = "(Fierce Monarch Topaz) +8 Strength, +8 Haste Rating"
LE[40057] = "(Glimmering Monarch Topaz) +8 Parry Rating, +8 Defense Rating"
LE[40044] = "(Glinting Monarch Topaz) +8 Agility, +8 Hit Rating"
LE[40037] = "(Inscribed Monarch Topaz) +8 Strength, +8 Crit Rating"
LE[40045] = "(Lucent Monarch Topaz) +8 Agility, +8 Resilience"
LE[40047] = "(Luminous Monarch Topaz) +9 Spell Power, +8 Intellect"
LE[40048] = "(Potent Monarch Topaz) +9 Spell Power, +8 Crit Rating"
LE[40053] = "(Pristine Monarch Topaz) +16 Attack Power, +8 Hit Rating"
LE[40051] = "(Reckless Monarch Topaz) +9 Spell Power, +8 Haste Rating"
LE[40059] = "(Resolute Monarch Topaz) +8 Expertise Rating, +8 Defense Rating"
LE[40040] = "(Resplendent Monarch Topaz) +8 Strength, +8 Resilience"
LE[40056] = "(Stalwart Monarch Topaz) +8 Dodge Rating, +8 Defense Rating"
LE[40055] = "(Stark Monarch Topaz) +16 Attack Power, +8 Haste Rating"
LE[40049] = "(Veiled Monarch Topaz) +9 Spell Power, +8 Hit Rating"
LE[40052] = "(Wicked Monarch Topaz) +16 Attack Power, +8 Crit Rating"

LE[40029] = "(Balanced Twilight Opal) +16 Attack Power, +12 Stamina"
LE[40032] = "(Defender's Twilight Opal) +8 Parry Rating, +12 Stamina"
LE[40025] = "(Glowing Twilight Opal) +9 Spell Power, +12 Stamina"
LE[40034] = "(Guardian Twilight Opal) +8 Expertise Rating, +12 Stamina"
LE[40030] = "(Infused Twilight Opal) +16 Attack Power, +3 MP5"
LE[40028] = "(Mysterious Twilight Opal) +9 Spell Power, 10 Spell Penetration"
LE[40033] = "(Puissant Twilight Opal) +8 Armor Penetration Rating, +12 Stamina"
LE[40026] = "(Purified Twilight Opal) +9 Spell Power, +8 Spirit"
LE[40031] = "(Regal Twilight Opal) +8 Dodge Rating, +12 Stamina"
LE[40027] = "(Royal Twilight Opal) +9 Spell Power, +3 MP5"
LE[40023] = "(Shifting Twilight Opal) +8 Agility, +12 Stamina"
LE[40022] = "(Sovereign Twilight Opal) +8 Strength, +12 Stamina"
LE[40024] = "(Tenuous Twilight Opal) +8 Agility, +3 MP5"

LE[42702] = "(Enchanted Tear) +6 All Stats (UE)"

-- Crafted Rare Quality Meta Gems
LE[41380] = "(Austere Earthsiege Diamond) +32 Stamina, +2% Armor Value from items"
LE[41389] = "(Beaming Earthsiege Diamond) +21 Crit Rating, +2% Mana"
LE[41395] = "(Bracing Earthsiege Diamond) +25 Spell Power, -2% Threat"
LE[41396] = "(Eternal Earthsiege Diamond) +21 Defense Rating, +5% Shield Block Value"
LE[41401] = "(Insightful Earthsiege Diamond) +21 Intellect, Spellcast Proc: Restore 600 mana"
LE[41385] = "(Invigorating Earthsiege Diamond) +42 Attack Power, Melee Proc on Crits: Heal 2% HP"
LE[41381] = "(Persistent Earthsiege Diamond) +42 Attack Power, -10% Stun Duration"
LE[41397] = "(Powerful Earthsiege Diamond) +32 Stamina, -10% Stun Duration"
LE[41398] = "(Relentless Earthsiege Diamond) +21 Agility, +3% Critical Damage"
LE[41382] = "(Trenchant Earthsiege Diamond) +25 Spell Power, -10% Stun Duration"

LE[41285] = "(Chaotic Skyflare Diamond) +21 Crit Rating, +3% Critical Damage"
LE[41307] = "(Destructive Skyflare Diamond) +25 Crit Rating, +1% Spell Reflect"
LE[41377] = "(Effulgent Skyflare Diamond) +32 Stamina, -2% Spell Damage taken"
LE[41333] = "(Ember Skyflare Diamond) +25 Spell Power, +2% Intellect"
LE[41335] = "(Enigmatic Skyflare Diamond) +21 Crit Rating, -10% Snare/Root Duration"
LE[41378] = "(Forlorn Skyflare Diamond) +25 Spell Power, -10% Silence Duration"
LE[41379] = "(Impassive Skyflare Diamond) +21 Crit Rating, -10% Fear Duration"
LE[41376] = "(Revitalizing Skyflare Diamond) +8 MP5, +3% Critical Healing Effect"
LE[41339] = "(Swift Skyflare Diamond) +42 Attack Power, +8% Run Speed"
LE[41400] = "(Thundering Skyflare Diamond) Melee/Ranged Proc: +480 Haste Rating for 6 sec"
LE[41375] = "(Tireless Skyflare Diamond) +25 Spell Power, +8% Run Speed"

-- PvP Purchased Gems (Wintergrasp)
LE[44081] = "(Enigmatic Starflare Diamond) +17 Crit Rating, -10% Snare/Root Duration"
LE[44084] = "(Forlorn Starflare Diamond) +20 Spell Power, -10% Silence Duration"
LE[44082] = "(Impassive Starflare Diamond) +17 Crit Rating, -10% Fear Duration"
LE[44076] = "(Swift Starflare Diamond) +34 Attack Power, +8% Run Speed"
LE[44078] = "(Tireless Starflare Diamond) +20 spell, +8% Run Speed"

LE[44087] = "(Persistent Earthshatter Diamond) +34 Attack Power, -10% Stun Duration"
LE[44088] = "(Powerful Earthshatter Diamond) +26 Stamina, -10% Stun Duration"
LE[44089] = "(Trenchant Earthshatter Diamond) +20 Spell Power, -10% Stun Duration"

LE[44066] = "(Kharmaa's Grace) +20 Resilience (UE)"

-- Crafted JC-only Epic Gems (Dragon's Eye)
LE[42146] = "(Lustrous Dragon's Eye) +20 MP5 (UE3)"
LE[36767] = "(Solid Dragon's Eye) +51 Stamina (UE3)"
LE[42145] = "(Sparkling Dragon's Eye) +34 Spirit (UE3)"
LE[42155] = "(Stormy Dragon's Eye) +43 Spell Penetration (UE3)"

LE[42142] = "(Bold Dragon's Eye) +34 Strength (UE3)"
LE[36766] = "(Bright Dragon's Eye) +68 Attack Power (UE3)"
LE[42143] = "(Delicate Dragon's Eye) +34 Agility (UE3)"
LE[42152] = "(Flashing Dragon's Eye) +34 Parry Rating (UE3)"
LE[42153] = "(Fractured Dragon's Eye) +34 Armor Penetration Rating (UE3)"
LE[42154] = "(Precise Dragon's Eye) +34 Expertise Rating (UE3)"
LE[42144] = "(Runed Dragon's Eye) +39 Spell Power (UE3)"
LE[42151] = "(Subtle Dragon's Eye) +34 Dodge Rating (UE3)"

LE[42148] = "(Brilliant Dragon's Eye) +34 Intellect (UE3)"
LE[42158] = "(Mystic Dragon's Eye) +34 Resilience (UE3)"
LE[42150] = "(Quick Dragon's Eye) +34 Haste Rating (UE3)"
LE[42156] = "(Rigid Dragon's Eye) +34 Hit Rating (UE3)"
LE[42149] = "(Smooth Dragon's Eye) +34 Crit Rating (UE3)"
LE[42157] = "(Thick Dragon's Eye) +34 Defense Rating (UE3)"

-- Crafted Epic Quality Gems (Added in 3.2.0)
LE[40121] = "(Lustrous Majestic Zircon) +10 MP5"
LE[40119] = "(Solid Majestic Zircon) +30 Stamina"
LE[40120] = "(Sparkling Majestic Zircon) +20 Spirit"
LE[40122] = "(Stormy Majestic Zircon) +25 Spell Penetration"

LE[40111] = "(Bold Cardinal Ruby) +20 Strength"
LE[40114] = "(Bright Cardinal Ruby) +40 Attack Power"
LE[40112] = "(Delicate Cardinal Ruby) +20 Agility"
LE[40116] = "(Flashing Cardinal Ruby) +20 Parry Rating"
LE[40117] = "(Fractured Cardinal Ruby) +20 Armor Penetration Rating"
LE[40118] = "(Precise Cardinal Ruby) +20 Expertise Rating"
LE[40113] = "(Runed Cardinal Ruby) +23 Spell Power"
LE[40115] = "(Subtle Cardinal Ruby) +20 Dodge Rating"

LE[40123] = "(Brilliant King's Amber) +20 Intellect"
LE[40127] = "(Mystic King's Amber) +20 Resilience"
LE[40128] = "(Quick King's Amber) +20 Haste Rating"
LE[40125] = "(Rigid King's Amber) +20 Hit Rating"
LE[40124] = "(Smooth King's Amber) +20 Crit Rating"
LE[40126] = "(Thick King's Amber) +20 Defense Rating"

LE[40175] = "(Dazzling Eye of Zul) +10 Intellect, +5 MP5"
LE[40167] = "(Enduring Eye of Zul) +10 Defense Rating, +15 Stamina"
LE[40179] = "(Energized Eye of Zul) +10 Haste Rating, +5 MP5"
LE[40169] = "(Forceful Eye of Zul) +10 Haste Rating, +15 Stamina"
LE[40174] = "(Intricate Eye of Zul) +10 Haste Rating, +10 Spirit"
LE[40165] = "(Jagged Eye of Zul) +10 Crit Rating, +15 Stamina"
LE[40177] = "(Lambert Eye of Zul) +10 Hit Rating, +5 MP5"
LE[40171] = "(Misty Eye of Zul) +10 Crit Rating, +10 Spirit"
LE[40178] = "(Opaque Eye of Zul) +10 Resilience, +5 MP5"
LE[40180] = "(Radiant Eye of Zul) +10 Crit Rating, 13 Spell Penetration"
LE[40170] = "(Seer's Eye of Zul) +10 Intellect, +10 Spirit"
LE[40182] = "(Shattered Eye of Zul) +10 Haste Rating, 13 Spell Penetration"
LE[40172] = "(Shining Eye of Zul) +10 Hit Rating, +10 Spirit"
LE[40168] = "(Steady Eye of Zul) +10 Resilience, +15 Stamina"
LE[40176] = "(Sundered Eye of Zul) +10 Crit Rating, +5 MP5"
LE[40181] = "(Tense Eye of Zul) +10 Hit Rating, 13 Spell Penetration"
LE[40164] = "(Timeless Eye of Zul) +10 Intellect, +15 Stamina"
LE[40173] = "(Turbid Eye of Zul) +10 Resilience, +10 Spirit"
LE[40166] = "(Vivid Eye of Zul) +10 Hit Rating, +15 Stamina"

LE[40162] = "(Accurate Ametrine) +10 Expertise Rating, +10 Hit Rating"
LE[40144] = "(Champion's Ametrine) +10 Strength, +10 Defense Rating"
LE[40147] = "(Deadly Ametrine) +10 Agility, +10 Crit Rating"
LE[40150] = "(Deft Ametrine) +10 Agility, +10 Haste Rating"
LE[40154] = "(Durable Ametrine) +12 Spell Power, +10 Resilience"
LE[40158] = "(Empowered Ametrine) +20 Attack Power, +10 Resilience"
LE[40143] = "(Etched Ametrine) +10 Strength, +10 Hit Rating"
LE[40146] = "(Fierce Ametrine) +10 Strength, +10 Haste Rating"
LE[40161] = "(Glimmering Ametrine) +10 Parry Rating, +10 Defense Rating"
LE[40148] = "(Glinting Ametrine) +10 Agility, +10 Hit Rating"
LE[40142] = "(Inscribed Ametrine) +10 Strength, +10 Crit Rating"
LE[40149] = "(Lucent Ametrine) +10 Agility, +10 Resilience"
LE[40151] = "(Luminous Ametrine) +12 Spell Power, +10 Intellect"
LE[40152] = "(Potent Ametrine) +12 Spell Power, +10 Crit Rating"
LE[40157] = "(Pristine Ametrine) +20 Attack Power, +10 Hit Rating"
LE[40155] = "(Reckless Ametrine) +12 Spell Power, +10 Haste Rating"
LE[40163] = "(Resolute Ametrine) +10 Expertise Rating, +10 Defense Rating"
LE[40145] = "(Resplendent Ametrine) +10 Strength, +10 Resilience"
LE[40160] = "(Stalwart Ametrine) +10 Dodge Rating, +10 Defense Rating"
LE[40159] = "(Stark Ametrine) +20 Attack Power, +10 Haste Rating"
LE[40153] = "(Veiled Ametrine) +12 Spell Power, +10 Hit Rating"
LE[40156] = "(Wicked Ametrine) +20 Attack Power, +10 Crit Rating"

LE[40136] = "(Balanced Dreadstone) +20 Attack Power, +15 Stamina"
LE[40139] = "(Defender's Dreadstone) +10 Parry Rating, +15 Stamina"
LE[40132] = "(Glowing Dreadstone) +12 Spell Power, +15 Stamina"
LE[40141] = "(Guardian Dreadstone) +10 Expertise Rating, +15 Stamina"
LE[40137] = "(Infused Dreadstone) +20 Attack Power, +5 MP5"
LE[40135] = "(Mysterious Dreadstone) +12 Spell Power, 13 Spell Penetration"
LE[40140] = "(Puissant Dreadstone) +10 Armor Penetration Rating, +15 Stamina"
LE[40133] = "(Purified Dreadstone) +12 Spell Power, +10 Spirit"
LE[40138] = "(Regal Dreadstone) +10 Dodge Rating, +15 Stamina"
LE[40134] = "(Royal Dreadstone) +12 Spell Power, +5 MP5"
LE[40130] = "(Shifting Dreadstone) +10 Agility, +15 Stamina"
LE[40129] = "(Sovereign Dreadstone) +10 Strength, +15 Stamina"
LE[40131] = "(Tenuous Dreadstone) +10 Agility, +5 MP5"

LE[49110] = "(Nightmare Tear) +10 All Stats (UE)"

-- Fishing Rewards Epic Gems (StormJewel)
LE[45880] = "(Solid Stormjewel) +30 Stamina"
LE[45881] = "(Sparkling Stormjewel) +20 Spirit"
LE[45862] = "(Bold Stormjewel) +20 Strength"
LE[45879] = "(Delicate Stormjewel) +20 Agility"
LE[45883] = "(Runed Stormjewel) +23 Spell Power"
LE[45882] = "(Brilliant Stormjewel) +20 Intellect"
LE[45987] = "(Rigid Stormjewel) +20 Hit Rating"

-- Crafted Uncommon Quality Gems
LE[23095] = "(Bold Blood Garnet) +6 Strength"
LE[28595] = "(Bright Blood Garnet) +12 Attack Power"
LE[23113] = "(Brilliant Golden Draenite) +6 Intellect"
LE[23106] = "(Dazzling Deep Peridot) +1 MP5, +3 Intellect"
LE[23097] = "(Delicate Blood Garnet) +6 Agility"
LE[23105] = "(Enduring Deep Peridot) +3 Defense Rating, +4 Stamina"
LE[23114] = "(Gleaming Golden Draenite) +6 Crit Rating"
LE[23100] = "(Glinting Flame Spessarite) +3 Hit Rating, +3 Agility"
LE[23108] = "(Glowing Shadow Draenite) +4 Spell Power, +4 Stamina"
LE[23098] = "(Inscribed Flame Spessarite) +3 Crit Rating, +3 Strength"
LE[23104] = "(Jagged Deep Peridot) +3 Crit Rating, +4 Stamina"
LE[23099] = "(Luminous Flame Spessarite) +4 Spell Power, +3 Intellect"
LE[23121] = "(Lustrous Azure Moonstone) +2 MP5"
LE[23101] = "(Potent Flame Spessarite) +3 Crit Rating, +4 Spell Power"
LE[23103] = "(Radiant Deep Peridot) +3 Crit Rating, +4 Spell Penetration"
LE[23116] = "(Rigid Golden Draenite) +6 Hit Rating"
LE[23109] = "(Royal Shadow Draenite) +4 Spell Power, +1 MP5"
LE[23096] = "(Runed Blood Garnet) +7 Spell Power"
LE[23110] = "(Shifting Shadow Draenite) +3 Agility, +4 Stamina"
LE[28290] = "(Smooth Golden Draenite) +6 Crit Rating"
LE[23118] = "(Solid Azure Moonstone) +9 Stamina"
LE[23111] = "(Sovereign Shadow Draenite) +3 Strength, +4 Stamina"
LE[23119] = "(Sparkling Azure Moonstone) +6 Spirit"
LE[23120] = "(Stormy Azure Moonstone) +8 Spell Penetration"
LE[23094] = "(Teardrop Blood Garnet) +7 Spell Power"
LE[23115] = "(Thick Golden Draenite) +6 Defense Rating"

-- Crafted Rare Quality Gems
LE[24027] = "(Bold Living Ruby) +8 Strength"
LE[24031] = "(Bright Living Ruby) +16 Attack Power"
LE[24047] = "(Brilliant Dawnstone) +8 Intellect"
LE[24065] = "(Dazzling Talasite) +4 Intellect, +2 MP5"
LE[24028] = "(Delicate Living Ruby) +8 Agility"
LE[24062] = "(Enduring Talasite) +4 Defense Rating, +6 Stamina"
LE[24036] = "(Flashing Living Ruby) +8 Parry Rating"
LE[24050] = "(Gleaming Dawnstone) +8 Crit Rating"
LE[24061] = "(Glinting Noble Topaz) +4 Hit Rating, +4 Agility"
LE[24056] = "(Glowing Nightseye) +5 Spell Power, +6 Stamina"
LE[24058] = "(Inscribed Noble Topaz) +4 Crit Rating, +4 Strength"
LE[24067] = "(Jagged Talasite) +4 Crit Rating, +6 Stamina"
LE[24060] = "(Luminous Noble Topaz) +5 Spell Power, +4 Intellect"
LE[24037] = "(Lustrous Star of Elune) +3 MP5"
LE[24059] = "(Potent Noble Topaz) +4 Crit Rating, +5 Spell Power"
LE[24066] = "(Radiant Talasite) +4 Crit Rating, +5 Spell Penetration"
LE[24051] = "(Rigid Dawnstone) +8 Hit Rating"
LE[24057] = "(Royal Nightseye) +5 Spell Power, +2 MP5"
LE[24030] = "(Runed Living Ruby) +9 Spell Power"
LE[24055] = "(Shifting Nightseye) +4 Agility, +6 Stamina"
LE[24048] = "(Smooth Dawnstone) +8 Crit Rating"
LE[24033] = "(Solid Star of Elune) +12 Stamina"
LE[24054] = "(Sovereign Nightseye) +4 Strength, +6 Stamina"
LE[24035] = "(Sparkling Star of Elune) +8 Spirit"
LE[24039] = "(Stormy Star of Elune) +10 Spell Penetration"
LE[24032] = "(Subtle Living Ruby) +8 Dodge Rating"
LE[24029] = "(Teardrop Living Ruby) +9 Spell Power"
LE[24052] = "(Thick Dawnstone) +8 Defense Rating"

-- Crafted Rare Meta Gems
LE[25897] = "(Bracing Earthstorm Diamond) +14 Spell Power, -2% Threat"
LE[25899] = "(Brutal Earthstorm Diamond) +3 Melee Damage, Melee Proc: Stun for 1 sec"
LE[25890] = "(Destructive Skyfire Diamond) +14 Crit Rating, +1% Spell Reflect"
LE[25895] = "(Enigmatic Skyfire Diamond) +12 Crit Rating, -10% Snare/Root Duration"
LE[25901] = "(Insightful Earthstorm Diamond) +12 Intellect, Spellcast Proc: Restore 300 mana"
LE[25893] = "(Mystical Skyfire Diamond) Spellcast Proc: +320 Haste Rating for 6 sec"
LE[25896] = "(Powerful Earthstorm Diamond) +18 Stamina, -10% Stun Duration"
LE[25894] = "(Swift Skyfire Diamond) +24 Attack Power, +8% Run Speed"
LE[25898] = "(Tenacious Earthstorm Diamond) +12 Defense Rating, Melee Proc: Heal 50 HP"

-- Enchanter Created
LE[22460] = "(Prismatic Sphere) +3 All Resistances"
LE[22459] = "(Void Sphere) +4 All Resistances"

-- PvP Purchased Rare Meta Gems (Terrokar Spirit Towers)
LE[28557] = "(Swift Starfire Diamond) +12 Spell Power, +8% Run Speed (UE)"
LE[28556] = "(Swift Windfire Diamond) +20 Attack Power, +8% Run Speed (UE)"

-- PvP Purchased Gems (Nagrand, Halaa)
LE[27679] = "(Sublime Mystic Dawnstone) +10 Resilience (UE)"
LE[30598] = "(Don Amancio's Heart) +8 Strength (UE)"
LE[30571] = "(Don Rodrigo's Heart) +8 Strength (UE)"

-- PvP Purchased Epic Gems (Honor Points)
LE[28362] = "(Bold Ornate Ruby) +20 Attack Power (UE)"
LE[28120] = "(Gleaming Ornate Dawnstone) +10 Crit Rating (UE)"
LE[28363] = "(Inscribed Ornate Topaz) +10 Attack Power, +5 Crit Rating (UE)"
LE[28123] = "(Potent Ornate Topaz) +6 Spell Power, +5 Crit Rating (UE)"
LE[28118] = "(Runed Ornate Ruby) +12 Spell Power (UE)"
LE[28119] = "(Smooth Ornate Dawnstone) +10 Crit Rating (UE)"

-- PvP Puchased Rare Gems (Honor Hold/Thrallmar)
-- Honor Hold itemIDs
LE[27809] = "(Barbed Deep Peridot) +3 Stamina, +4 Crit Rating (A) (UE)"
LE[28361] = "(Mighty Blood Garnet) +14 Attack Power (A) (UE)"
LE[27820] = "(Notched Deep Peridot) +3 Stamina, +4 Crit Rating (A) (UE)"
LE[27812] = "(Stark Blood Garnet) +8 Spell Power (A) (UE)"

--Thrallmar duplicates, different itemIDs
LE[27786] = "(Barbed Deep Peridot) +3 Stamina, +4 Crit Rating (H) (UE)"
LE[28360] = "(Mighty Blood Garnet) +14 Attack Power (H) (UE)"
LE[27785] = "(Notched Deep Peridot) +3 Stamina, +4 Crit Rating (H) (UE)"
LE[27777] = "(Stark Blood Garnet) +8 Spell Power (H) (UE)"

-- Vendor Purchased (Common Gems)
LE[28458] = "(Bold Tourmaline) +4 Strength"
LE[28462] = "(Bright Tourmaline) +8 Attack Power"
LE[28466] = "(Brilliant Amber) +4 Intellect"
LE[28459] = "(Delicate Tourmaline) +4 Agility"
LE[28469] = "(Gleaming Amber) +4 Crit Rating"
LE[28465] = "(Lustrous Zircon) +1 MP5"
LE[28468] = "(Rigid Amber) +4 Hit Rating"
LE[28461] = "(Runed Tourmaline) +5 Spell Power"
LE[28467] = "(Smooth Amber) +4 Crit Rating"
LE[28463] = "(Solid Zircon) +6 Stamina"
LE[28464] = "(Sparkling Zircon) +4 Spirit"
LE[28460] = "(Teardrop Tourmaline) +5 Spell Power"
LE[28470] = "(Thick Amber) +4 Defense Rating"

-- Instance Epic Gem Drops
LE[30565] = "(Assassin's Fire Opal) +6 Crit Rating, +5 Dodge Rating"
LE[30601] = "(Beaming Fire Opal) +5 Dodge Rating, +4 Resilience"
LE[30574] = "(Brutal Tanzanite) +10 Attack Power, +6 Stamina"
LE[30587] = "(Champion's Fire Opal) +5 Strength, +4 Defense Rating"
LE[30566] = "(Defender's Tanzanite) +5 Parry Rating, +6 Stamina"
LE[30594] = "(Effulgent Chrysoprase) +5 Defense Rating, +2 MP5"
LE[30584] = "(Enscribed Fire Opal) +5 Strength, +4 Crit Rating"
LE[30559] = "(Etched Fire Opal) +5 Strength, +4 Hit Rating"
LE[30600] = "(Fluorescent Tanzanite) +6 Spell Power, +4 Spirit"
LE[30558] = "(Glimmering Fire Opal) +5 Parry Rating, +4 Defense Rating"
LE[30556] = "(Glinting Fire Opal) +5 Agility, +4 Hit Rating"
LE[30585] = "(Glistening Fire Opal) +4 Agility, +5 Defense Rating"
LE[30555] = "(Glowing Tanzanite) +6 Spell Power, +6 Stamina"
LE[31116] = "(Infused Amethyst), +6 Spell Power, +6 Stamina"
LE[30551] = "(Infused Fire Opal) +6 Spell Power, +4 Intellect"
LE[30593] = "(Iridescent Fire Opal) +11 Spell Power, +4 Crit Rating"
LE[30602] = "(Jagged Chrysoprase) +6 Stamina, +5 Crit Rating"
LE[30606] = "(Lambent Chrysoprase), +5 Hit Rating, +2 MP5"
LE[30547] = "(Luminous Fire Opal) +6 Spell Power, +4 Intellect"
LE[30548] = "(Polished Chrysoprase) +6 Stamina, +5 Crit Rating"
LE[30553] = "(Pristine Fire Opal) +10 Attack Power, +4 Hit Rating"
LE[31118] = "(Pulsing Amethyst), +10 Attack Power, +6 Stamina"
LE[30608] = "(Radiant Chrysoprase) +5 Crit Rating, +5 Spell Penetration"
LE[30563] = "(Regal Tanzanite) +5 Dodge Rating, +6 Stamina"
LE[30604] = "(Resplendent Fire Opal) +5 Strength, +4 Resilience"
LE[30603] = "(Royal Tanzanite) +6 Spell Power, +2 MP5"
LE[30586] = "(Seer's Chrysoprase) +4 Intellect, +5 Spirit"
LE[30549] = "(Shifting Tanzanite) +5 Strength, +4 Agility"
LE[30564] = "(Shining Fire Opal) +6 Spell Power, +5 Hit Rating"
LE[31117] = "(Soothing Amethyst), +11 Spell Power, +6 Stamina"
LE[30546] = "(Sovereign Tanzanite) +5 Strength, +6 Stamina"
LE[30607] = "(Splendid Fire Opal) +5 Parry Rating, +4 Resilience"
LE[30554] = "(Stalwart Fire Opal) +5 Defense Rating, +4 Dodge Rating"
LE[30592] = "(Steady Chrysoprase) +6 Stamina, +5 Resilience"
LE[30550] = "(Sundered Chrysoprase) +5 Crit Rating, +2 MP5"
LE[30583] = "(Timeless Chrysoprase) +5 Intellect, +6 Stamina"
LE[30605] = "(Vivid Chrysoprase) +5 Hit Rating, +6 Stamina"

-- Added in Gem Helper v1.1
LE[30552] = "(Blessed Tanzanite) +11 Spell Power, +6 Stamina"
LE[30589] = "(Dazzling Chrysoprase) +5 Intellect, +2 MP5"
LE[30582] = "(Deadly Fire Opal) +8 Attack Power, +5 Crit Rating"
LE[30581] = "(Durable Fire Opal) +11 Spell Power, +4 Resilience"
LE[30591] = "(Empowered Fire Opal) +8 Attack Power, +5 Resilience"
LE[30590] = "(Enduring Chrysoprase) +6 Stamina, +5 Defense Rating"
LE[30572] = "(Imperial Tanzanite) +5 Spirit, +9 Spell Power"
LE[30573] = "(Mysterious Fire Opal) +6 Spell Power, +5 Spell Penetration"
LE[30575] = "(Nimble Fire Opal) +5 Dodge Rating, +4 Hit Rating"
LE[30588] = "(Potent Fire Opal) +6 Spell Power, +4 Crit Rating"
LE[30560] = "(Rune Covered Chrysoprase) +5 Crit Rating, +2 MP5"

-- Added in Gem Helper v1.2 (patch 2.1.1)
LE[31863] = "(Balanced Nightseye) +8 Attack Power, +6 Stamina"
LE[31861] = "(Great Dawnstone) +8 Hit Rating"
LE[31865] = "(Infused Nightseye) +8 Attack Power, +2 MP5"
LE[31867] = "(Veiled Noble Topaz) +4 Hit Rating, +6 Spell Power"
LE[31868] = "(Wicked Noble Topaz) +4 Crit Rating, +8 Attack Power"
LE[32836] = "(Purified Shadow Pearl) +7 Spell Power, +4 Spirit"
LE[32833] = "(Purified Jaggal Pearl) +4 Spell Power, +3 Spirit"
LE[32409] = "(Relentless Earthstorm Diamond) +12 Agility, +3% Critical Damage"
LE[32410] = "(Thundering Skyfire Diamond) Melee/Ranged Proc: +240 Haste Rating for 6 sec"

-- Added in Gem Helper v1.3 (patch 2.1.3)
LE[24053] = "(Mystic Dawnstone) +8 Resilience"
LE[32634] = "(Unstable Amethyst) +8 Attack Power, +6 Stamina (UE)"
LE[32635] = "(Unstable Peridot) +4 Intellect, +6 Stamina (UE)"
LE[32636] = "(Unstable Sapphire) +9 Spell Power, +4 Spirit (UE)"
LE[32637] = "(Unstable Citrine) +8 Attack Power, +4 Crit Rating (UE)"
LE[32638] = "(Unstable Topaz) +5 Spell Power, +4 Intellect (UE)"
LE[32639] = "(Unstable Talasite) +4 Stamina, +4 Crit Rating (UE)"
LE[32640] = "(Potent Unstable Diamond) +24 Attack Power, +5% Stun Resist (UE)"
LE[32641] = "(Imbued Unstable Diamond) +14 Spell Power, +5% Stun Resist (UE)"

-- Added in Gem Helper v1.3 (patch 2.1.3)
-- The following gems are crafted from epic gem drops in Black Temple/Hyjal
LE[32193] = "(Bold Crimson Spinel) +10 Strength"
LE[32194] = "(Delicate Crimson Spinel) +10 Agility"
LE[32195] = "(Teardrop Crimson Spinel) +12 Spell Power"
LE[32196] = "(Runed Crimson Spinel) +12 Spell Power"
LE[32197] = "(Bright Crimson Spinel) +20 Attack Power"
LE[32198] = "(Subtle Crimson Spinel) +10 Dodge Rating"
LE[32199] = "(Flashing Crimson Spinel) +10 Parry Rating"
LE[32200] = "(Solid Empyrean Sapphire) +15 Stamina"
LE[32201] = "(Sparkling Empyrean Sapphire) +10 Spirit"
LE[32202] = "(Lustrous Empyrean Sapphire) +4 MP5"
LE[32203] = "(Stormy Empyrean Sapphire) +13 Spell Penetration"
LE[32204] = "(Brilliant Lionseye) +10 Intellect"
LE[32205] = "(Smooth Lionseye) +10 Crit Rating"
LE[32206] = "(Rigid Lionseye) +10 Hit Rating"
LE[32207] = "(Gleaming Lionseye) +10 Crit Rating"
LE[32208] = "(Thick Lionseye) +10 Defense Rating"
LE[32209] = "(Mystic Lionseye) +10 Resilience"
LE[32210] = "(Great Lionseye) +10 Hit Rating"
LE[32211] = "(Sovereign Shadowsong Amethyst) +5 Strength, +7 Stamina"
LE[32212] = "(Shifting Shadowsong Amethyst) +5 Agility, +7 Stamina"
LE[32213] = "(Balanced Shadowsong Amethyst) +10 Attack Power, +7 Stamina"
LE[32214] = "(Infused Shadowsong Amethyst) +10 Attack Power, +2 MP5"
LE[32215] = "(Glowing Shadowsong Amethyst) +6 Spell Power, +7 Stamina"
LE[32216] = "(Royal Shadowsong Amethyst) +6 Spell Power, +2 MP5"
LE[32217] = "(Inscribed Pyrestone) +5 Crit Rating, +5 Strength"
LE[32218] = "(Potent Pyrestone) +5 Crit Rating, +6 Spell Power"
LE[32219] = "(Luminous Pyrestone) +6 Spell Power, +5 Intellect"
LE[32220] = "(Glinting Pyrestone) +5 Hit Rating, +5 Agility"
LE[32221] = "(Veiled Pyrestone) +5 Hit Rating, +6 Spell Power"
LE[32222] = "(Wicked Pyrestone) +5 Crit Rating, +10 Attack Power"
LE[32223] = "(Enduring Seaspray Emerald) +5 Defense Rating, +7 Stamina"
LE[32224] = "(Radiant Seaspray Emerald) +5 Crit Rating, +6 Spell Penetration"
LE[32225] = "(Dazzling Seaspray Emerald) +5 Intellect, +2 MP5"
LE[32226] = "(Jagged Seaspray Emerald) +5 Crit Rating, +7 Stamina"

-- Added in Gem Helper v1.4 (patch 2.2.0)
LE[33131] = "(Crimson Sun) +24 Attack Power (UE)"
LE[33133] = "(Don Julio's Heart) +14 Spell Power (UE)"
LE[33134] = "(Kailee's Rose) +14 Spell Power (UE)"
LE[33135] = "(Falling Star) +18 Stamina (UE)"
LE[33140] = "(Blood of Ember) +12 Crit Rating (UE)"
LE[33143] = "(Stone of Blades) +12 Crit Rating (UE)"
LE[33144] = "(Facet of Eternity) +12 Defense Rating (UE)"
LE[33782] = "(Steady Talasite) +4 Resilience, +6 Stamina (UE)"

-- Added in Gem Helper v1.41 (patch 2.2.2)
LE[31862] = "(Balanced Shadow Draenite) +6 Attack Power, +4 Stamina"
LE[31860] = "(Great Golden Draenite) +6 Hit Rating"
LE[31864] = "(Infused Shadow Draenite) +6 Attack Power, +1 MP5"
LE[31866] = "(Veiled Flame Spessarite) +3 Hit Rating, +4 Spell Power"
LE[31869] = "(Wicked Flame Spessarite) +3 Crit Rating, +6 Attack Power"

-- Added in Gem Helper v1.5 (patch 2.3.0)
LE[34220] = "(Chaotic Skyfire Diamond) +12 Crit Rating, +3% Critical Damage"
LE[34256] = "(Charmed Amani Jewel) +15 Stamina (UE)"

-- Added in Gem Helper v1.6 (patch 2.4.0)
LE[35503] = "(Ember Skyfire Diamond) +14 Spell Power, +2% Intellect"
LE[35501] = "(Eternal Earthstorm Diamond) +12 Defense Rating, +5% Shield Block Value"
LE[35707] = "(Regal Nightseye) +4 Dodge Rating, +6 Stamina"
LE[34831] = "(Eye of the Sea) +15 Stamina (UE)"
LE[35758] = "(Steady Seaspray Emerald) +5 Resilience, +7 Stamina"
LE[35759] = "(Forceful Seaspray Emerald) +5 Haste Rating, +7 Stamina"
LE[35760] = "(Reckless Pyrestone) +5 Haste Rating, +6 Spell Power"
LE[35761] = "(Quick Lionseye) +10 Haste Rating"

-- Added in Gem Helper v1.7 (patch 2.4.2)
LE[37503] = "(Purified Shadowsong Amethyst) +6 Spell Power, +5 Spirit"
LE[35315] = "(Quick Dawnstone) +8 Haste Rating"
LE[35316] = "(Reckless Noble Topaz) +4 Haste Rating, +5 Spell Power"
LE[35318] = "(Forceful Talasite) +4 Haste Rating, +6 Stamina"

-- Sunwell BoP quest rewards from "Hard to Kill" - http://www.wowhead.com/?quest=11492
LE[35487] = "(Bright Crimson Spinel) +20 Attack Power"
LE[35488] = "(Runed Crimson Spinel) +12 Spell Power"
LE[35489] = "(Teardrop Crimson Spinel) +12 Spell Power"


-- Translations for stat names
-- 4th arg is true so that new bonuses will not generate errors
local LS = AceLocale:NewLocale("WoWEquipLS", "enUS", true, true)
LS["STR"] = SPELL_STAT1_NAME
LS["AGI"] = SPELL_STAT2_NAME
LS["STA"] = SPELL_STAT3_NAME
LS["INT"] = SPELL_STAT4_NAME
LS["SPI"] = SPELL_STAT5_NAME
LS["ARMOR"] = RESISTANCE0_NAME
--LS["BASE_ARMOR"] = "Base Armor"
--LS["ARMOR_BONUS"] =  -- ignore

LS["ARCANERES"] = RESISTANCE6_NAME
LS["FIRERES"] = RESISTANCE2_NAME
LS["FROSTRES"] = RESISTANCE4_NAME
LS["HOLYRES"] = RESISTANCE1_NAME
LS["NATURERES"] = RESISTANCE3_NAME
LS["SHADOWRES"] = RESISTANCE5_NAME

LS["FISHING"] = "Fishing"
LS["MINING"] = "Mining"
LS["HERBALISM"] = "Herbalism"
LS["SKINNING"] = "Skinning"
LS["DEFENSE"] = DEFENSE

LS["BLOCK"] = STAT_BLOCK
LS["BLOCKVALUE"] = "Block Value"
LS["DODGE"] = STAT_DODGE
LS["PARRY"] = STAT_PARRY
LS["ATTACKPOWER"] = MELEE_ATTACK_POWER
LS["ATTACKPOWERUNDEAD"] = "Attack Power (vs Undead)"
LS["ATTACKPOWERBEAST"] = "Attacp Power (vs Beast)"
LS["ATTACKPOWERFERAL"] = "Attack Power (Feral)"
LS["CRIT"] = MELEE_CRIT_CHANCE
LS["RANGEDATTACKPOWER"] = RANGED_ATTACK_POWER
LS["RANGEDCRIT"] = "Ranged Crit Chance" -- RANGED_CRIT_CHANCE -- Doesn't have the word "Ranged"
LS["TOHIT"] = "Melee Hit Chance"
LS["THREATREDUCTION"] = "Threat Reduction"

LS["SPELLPOWER"] = "Spell Power"
LS["SPELLCRIT"] = SPELL_CRIT_CHANCE
LS["SPELLTOHIT"] = "Spell Hit Chance"
LS["SPELLPEN"] = "Spell Penetration" -- SPELL_PENETRATION -- Doesn't have the word "Spell"

LS["HEALTHREG"] = "Health Regen"
LS["MANAREG"] = MANA_REGEN
LS["HEALTH"] = HEALTH
LS["MANA"] = MANA

--LS["CR_WEAPON"] = 
LS["CR_DEFENSE"] = COMBAT_RATING_NAME2
LS["CR_DODGE"] = COMBAT_RATING_NAME3
LS["CR_PARRY"] = COMBAT_RATING_NAME4
LS["CR_BLOCK"] = COMBAT_RATING_NAME5
LS["CR_HIT"] = COMBAT_RATING_NAME6
LS["CR_CRIT"] = COMBAT_RATING_NAME9
LS["CR_HASTE"] = SPELL_HASTE
LS["CR_EXPERTISE"] = "Expertise Rating"
LS["CR_RESILIENCE"] = COMBAT_RATING_NAME15
LS["CR_WEAPON_AXE"] = "Axe skill rating"
LS["CR_WEAPON_DAGGER"] = "Dagger skill rating"
LS["CR_WEAPON_MACE"] = "Mace skill rating"
LS["CR_WEAPON_SWORD"] = "Sword skill rating"
LS["CR_WEAPON_SWORD_2H"] = "2H-Swords skill rating"
LS["CR_ARMOR_PENETRATION"] = "Armor Penetration Rating"

LS["CR_RANGEDCRIT"] = "Ranged Crit Rating" -- COMBAT_RATING_NAME10 -- Doesn't have the word "Ranged"
LS["CR_RANGEDHIT"] = "Ranged Hit Rating" -- COMBAT_RATING_NAME7 -- Doesn't have the word "Ranged"
LS["CR_WEAPON_FERAL"] = "Feral Combat s. rating"
LS["CR_WEAPON_FIST"] = "Fist skill rating"
LS["CR_WEAPON_CROSSBOW"] = "Crossbow skill rating"
LS["CR_WEAPON_GUN"] = "Gun skill rating"
LS["CR_WEAPON_BOW"] = "Bow skill rating"
LS["CR_WEAPON_STAFF"] = "Staff skill rating"
LS["CR_WEAPON_MACE_2H"] = "2H-Mace skill rating"
LS["CR_WEAPON_AXE_2H"] = "2H-Axe skill rating"

LS["ATTACKPOWERDEMON"] = "Attack Power (vs Demon)"
LS["ATTACKPOWERELEMENTAL"] = "Attack Power (vs Elem)"
LS["ATTACKPOWERDRAGON"] = "Attack Power (vs Dragon)"

LS["CASTINGREG"] = "Mana Regen w/casting %"
LS["STEALTH"] = "Stealth"
LS["RANGED_SPEED_BONUS"] = "Ranged Speed Bonus" -- bags are not scanned
LS["SWIMSPEED"] = "Swim Speed"
LS["MOUNTSPEED"] = "Mount Speed"
LS["RUNSPEED"] = "Run Speed"
--LS["NEGPARRY"] = "Less Parry %"
LS["MELEETAKEN"] = "Less Melee Dmg Taken"
LS["DMGTAKEN"] = "Less Spell Dmg Taken"
LS["CRITDMG"] = "More Critical Damage %" -- To be deprecated
LS["MOD_BLOCKVALUE"] = "More Block Value %"
LS["MOD_STA"] = "More Stamina %"
--LS["MELEEDMG"] = "Summed Melee Damage"
LS["HEALTHREG_P"] = "Normal Health Regen"
LS["UNDERWATER"] = "Underwater Breathing"
LS["LOCKPICK"] = "Lockpicking"
LS["STEALTHDETECT"] = "Stealth Detection"
LS["DISARMREDUCTION"] = "Less Disarm Duration %"
LS["SLOWFALL"] = "Less Falling Damage %"
--IMPRESS = 8, -- not scanned
--MOJO = 8, -- not scanned

LS["ARCANESPELLPOWER"] = "Arcane Spell Power"
LS["FIRESPELLPOWER"] = "Fire Spell Power"
LS["FROSTSPELLPOWER"] = "Frost Spell Power"
LS["HOLYSPELLPOWER"] = "Holy Spell Power"
LS["NATURESPELLPOWER"] = "Nature Spell Power"
LS["SHADOWSPELLPOWER"] = "Shadow Spell Power"

LS["EMPTY_SOCKET_BLUE"] = "Empty Blue Socket"
LS["EMPTY_SOCKET_META"] = "Empty Meta Socket"
LS["EMPTY_SOCKET_RED"] = "Empty Red Socket"
LS["EMPTY_SOCKET_YELLOW"] = "Empty Yellow Socket"
LS["BLUE_GEM"] = "Blue Gem"
LS["META_GEM"] = "Meta Gem"
LS["RED_GEM"] = "Red Gem"
LS["YELLOW_GEM"] = "Yellow Gem"

LS["EXPERTISE"] = STAT_EXPERTISE
LS["MOD_ARMOR"] = "More Armor %"
LS["MOD_MANA"] = "More Mana %"
LS["MOD_DAMAGE_CRIT"] = "More Critical Damage %"
LS["MOD_INT"] = "More Intellect %"
LS["MOD_HEAL_CRIT"] = "More Critical Healing %"
LS["SNAREREDUCTION"] = "Less Snare Duration %"
LS["SILENCEREDUCTION"] = "Less Silence Duration %"
LS["FEARREDUCTION"] = "Less Fear Duration %"
LS["STUNREDUCTION"] = "Less Stun Duration %"

LS["CR_SPELLHIT"] = COMBAT_RATING_NAME6
LS["CR_SPELLCRIT"] = COMBAT_RATING_NAME9
LS["CR_SPELLHASTE"] = SPELL_HASTE

--[[
LS["HEALTHFROMHP"] = "HP from %d Health"
LS["HEALTHFROMSTA"] = "HP from %d Stamina"
LS["HEALTHTOTAL"] = "HP Total"
LS["MANAFROMMP"] = "Mana from %d Mana"
LS["MANAFROMINT"] = "Mana from %d Intellect"
LS["MANATOTAL"] = "Mana Total"
]]

if GetLocale() == "enUS" then return end

-- vim: ts=4 noexpandtab
