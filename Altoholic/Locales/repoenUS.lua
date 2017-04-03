local L = LibStub("AceLocale-3.0"):NewLocale("Altoholic", "enUS", true, true)

if not L then return end

-- Note: since 2.4.004 and the support of LibBabble, certain lines are commented, but remain there for clarity (especially those concerning the menu)
-- A lot of translations, especially those concerning the loot table, come from atlas loot, credit goes to their team for gathering this info, I (Thaoky) simply took what I needed.

L["Death Knight"] = true

-- note: these string are the ones found in item tooltips, make sure to respect the case when translating, and to distinguish them (like crit vs spell crit)
L["Increases healing done by up to %d+"] = true
L["Increases damage and healing done by magical spells and effects by up to %d+"] = true
L["Increases attack power by %d+"] = true
L["Restores %d+ mana per"] = true
L["Classes: Shaman"] = true
L["Classes: Mage"] = true
L["Classes: Rogue"] = true
L["Classes: Hunter"] = true
L["Classes: Warrior"] = true
L["Classes: Paladin"] = true
L["Classes: Warlock"] = true
L["Classes: Priest"] = true
L["Classes: Death Knight"] = true
L["Resistance"] = true

--skills
L["Class Skills"] = true
L["Professions"] = true
L["Secondary Skills"] = true
L["Fishing"] = true
L["Riding"] = true
L["Herbalism"] = true
L["Mining"] = true
L["Skinning"] = true
L["Lockpicking"] = true
L["Poisons"] = true
L["Beast Training"] = true
L["Inscription"] = true

--factions not in LibFactions or LibZone
L["Alliance Forces"] = true
L["Horde Forces"] = true
L["Steamwheedle Cartel"] = true
L["Other"] = true

-- menu
L["Reputations"] = true
L["Containers"] = true
L["Guild Bank not visited yet (or not guilded)"] = true
L["E-Mail"] = true
L["Quests"] = true
L["Equipment"] = true

--Altoholic.lua
L["Account"] = true
L["Default"] = true
L["Loots"] = true
L["Unknown"] = true
L["has come online"] = true
L["has gone offline"] = true
L["Bank not visited yet"] = true
L["Levels"] = true
L["(has mail)"] = true
L["(has auctions)"] = true
L["(has bids)"] = true

L["No rest XP"] = true
L["Rested"] = true
L["Transmute"] = true

L["Bags"] = true
L["Bank"] = true
L["AH"] = true				-- for auction house, obviously
L["Equipped"] = true
L["Mail"] = true
L["Mails %s(%d)"] = true
L["Mails"] = true
L["Visited"] = true
L["Auctions %s(%d)"] = true
L["Bids %s(%d)"] = true

L["Level"] = true
L["Zone"] = true
L["Rest XP"] = true

L["Source"] = true
L["Total owned"] = true
L["Already known by "] = true
L["Will be learnable by "] = true
L["Could be learned by "] = true

L["At least one recipe could not be read"] = true
L["Please open this window again"] = true

--Calendar.lua
L["Number of players: %s"] = true
L["Minimum Level: %s"] = true
L["Maximum Level: %s"] = true
L["Private to friends: %s"] = true
L["Private to guild: %s"] = true
L["Attendees: "] = true
L["%s starts in %d minutes (%s on %s)"] = true
L["%s will be ready in %d minutes (%s on %s)"] = true
L["%s is now ready (%s on %s)"] = true
L["%s is now unlocked (%s on %s)"] = true
L["%s will be unlocked in %d minutes (%s on %s)"] = true
L["Left-click to invite attendees"] = true
L["Display warnings in a dialog box"] = true
L["Do you want to open Altoholic's calendar for details ?"] = true

--Comm.lua
L["Sending account sharing request to %s"] = true
L["Account sharing request received from %s"] = true
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = true
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = true
L["Request rejected by %s"] = true
L["%s is in combat, request cancelled"] = true
L["%s has disabled account sharing"] = true
L["Table of content received (%d items)"] = true
L["Sending reputations (%d of %d)"] = true
L["Sending currencies (%d of %d)"] = true
L["Sending guilds (%d of %d)"] = true
L["Sending character %s (%d of %d)"] = true
L["No reputations found"] = true
L["No currencies found"] = true
L["No guild found"] = true
L["Transfer complete"] = true
L["Reputations received !"] = true
L["Currencies received !"] = true
L["Guilds received !"] = true
L["Character %s received !"] = true
L["Requesting item %d of %d"] = true
L["Sending table of content (%d items)"] = true
L["Guild bank tab %s successfully updated !"] = true
L["%s has disabled guild communication"] = true
L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = true
L["%sWarning:|r make sure this user may view this information before accepting"] = true
L["%s|r has received a mail from %s"] = true
L["Sending reference data: %s (%d of %d)"] = true
L["Reference data not available"] = true
L["Reference data received (%s) !"] = true
L["Waiting for %s to accept .."] = true

--GuildBankTabs.lua
L["Requesting %s information from %s"] = true
L["Guild Bank Remote Update"] = true
L["Clicking this button will update\nyour local %s%s|r bank tab\nbased on %s%s's|r data"] = true

--GuildMembers.lua
L["Left-click to see this character's equipment"] = true
L["Click a character's AiL to see its equipment"] = true

--GuildProfessions.lua
L["Offline Members"] = true
L["Left click to view"] = true
L["Shift+Left click to link"] = true

--Core.lua
L['search'] = true
L["Search in bags"] = true
L['show'] = true
L["Shows the UI"] = true
L['hide'] = true
L["Hides the UI"] = true
L['toggle'] = true
L["Toggles the UI"] = true
L["Altoholic:|r Usage = /altoholic search <item name>"] = true

--AltoholicFu.lua
L["Left-click to"] = true
L["open/close"] = true

--AccountSummary.lua
L["View bags"] = true
L["All-in-one"] = true
L["View mailbox"] = true
L["View quest log"] = true
L["View auctions"] = true
L["View bids"] = true
L["Delete this Alt"] = true
L["Cannot delete current character"] = true
L["Character %s successfully deleted"] = true
L["Delete this Realm"] = true
L["Cannot delete current realm"] = true
L["Realm %s successfully deleted"] = true
L["Suggested leveling zone: "] = true
L["Arena points: "] = true
L["Honor points: "] = true
L["Right-Click for options"] = true
L["Average Item Level"] = true

-- AuctionHouse.lua
L["%s has no auctions"] = true
L["%s has no bids"] = true
L["last check "] = true
L["Goblin AH"] = true
L["Clear your faction's entries"] = true
L["Clear goblin AH entries"] = true
L["Clear all entries"] = true

--BagUsage.lua
L["Totals"] = true
L["slots"] = true
L["free"] = true

--Containers.lua
L["32 Keys Max"] = true
L["28 Slot"] = true
L["Bank bag"] = true
L["Unknown link, please relog this character"] = true

--Equipment.lua
L["Find Upgrade"] = true
L["(based on iLvl)"] = true
L["Right-Click to find an upgrade"] = true
L["Tank"] = true
L["DPS"] = true
L["Balance"] = true
L["Elemental Shaman"] = true		-- shaman spec !
L["Heal"] = true

--GuildBank.lua
L["Last visit: %s by %s"] = true
L["Local Time: %s   %sRealm Time: %s"] = true

--Mails.lua
L[" has not visited his/her mailbox yet"] = true
L["%s has no mail"] = true
L[" has no mail, last check "] = true
L[" days ago"] = true
L["Mail was last checked "] = true
L[" days"] = true
L["Mail is about to expire on at least one character."] = true
L["Refer to the activity pane for more details."] = true
L["Do you want to view it now ?"] = true
L["Will be %sreturned|r in"] = true
L["Will be %sdeleted|r in"] = true

--Quests.lua
L["No quest found for "] = true
L["QuestID"] = true
L["Are also on this quest:"] = true

--Recipes.lua
L["No data"] = true
L[" scan failed for "] = true

--Reputations.lua
L["Shift-Click to link this info"] = true
L[" is "] = true
L[" with "] = true
L["%s is %s with %s (%d/%d)"] = true

--Search.lua
L["Item Level"] = true
L[" results found (Showing "] = true
L["No match found!"] = true
L[" not found!"] = true
L["Socket"] = true

--skills.lua
L["Rogue Proficiencies"] = true
L["up to"] = true
L["at"] = true
L["and above"] = true
L["Suggestion"] = true
L["Prof. 1"] = true
L["Prof. 2"] = true
L["Grey"] = true
L["All cooldowns are up"] = true

-- TabSummary.lua
L["All accounts"] = true

-- TabCharacters.lua
L["Cannot link another realm's tradeskill"] = true
L["Cannot link another account's tradeskill"] = true
L["Invalid tradeskill link"] = true
L["Expiry:"] = true

-- TabGuildBank.lua
L["N/A"] = true
L["Delete Guild Bank?"] = true
L["Guild %s successfully deleted"] = true

-- TabSearch.lua
L["Any"] = true
L["Miscellaneous"] = true
L["Fishing Poles"] = true
L["This realm"] = true
L["All realms"] = true
L["Loot tables"] = true
L["This character"] = true
L["This faction"] = true
L["Both factions"] = true

--loots.lua
--Instinct drop
L["Hard Mode"] = true
L["Trash Mobs"] = true
L["Random Boss"] = true
L["Druid Set"] = true
L["Hunter Set"] = true
L["Mage Set"] = true
L["Paladin Set"] = true
L["Priest Set"] = true
L["Rogue Set"] = true
L["Shaman Set"] = true
L["Warlock Set"] = true
L["Warrior Set"] = true
L["Legendary Mount"] = true
L["Legendaries"] = true
L["Muddy Churning Waters"] = true
L["Shared"] = true
L["Enchants"] = true
L["Rajaxx's Captains"] = true
L["Class Books"] = true
L["Quest Items"] = true
L["Druid of the Fang (Trash Mob)"] = true
L["Spawn Of Hakkar"] = true
L["Troll Mini bosses"] = true
L["Henry Stern"] = true
L["Magregan Deepshadow"] = true
L["Tablet of Ryuneh"] = true
L["Krom Stoutarm Chest"] = true
L["Garrett Family Chest"] = true
L["Eric The Swift"] = true
L["Olaf"] = true
L["Baelog's Chest"] = true
L["Conspicuous Urn"] = true
L["Tablet of Will"] = true
L["Shadowforge Cache"] = true
L["Roogug"] = true
L["Aggem Thorncurse"] = true
L["Razorfen Spearhide"] = true
L["Pyron"] = true
L["Theldren"] = true
L["The Vault"] = true
L["Summoner's Tomb"] = true
L["Plans"] = true
L["Zelemar the Wrathful"] = true
L["Rethilgore"] = true
L["Fel Steed"] = true
L["Tribute Run"] = true
L["Shen'dralar Provisioner"] = true
L["Books"] = true
L["Trinkets"] = true
L["Sothos & Jarien"] = true
L["Fel Iron Chest"] = true
L[" (Heroic)"] = true
L["Yor (Heroic Summon)"] = true
L["Avatar of the Martyred"] = true
L["Anzu the Raven God (Heroic Summon)"] = true
L["Thomas Yance"] = true
L["Aged Dalaran Wizard"] = true
L["Cache of the Legion"] = true
L["Opera (Shared Drops)"] = true
L["Timed Chest"] = true
L["Patterns"] = true

--Rep
L["Token Hand-Ins"] = true
L["Items"] = true
L["Beasts Deck"] = true
L["Elementals Deck"] = true
L["Warlords Deck"] = true
L["Portals Deck"] = true
L["Furies Deck"] = true
L["Storms Deck"] = true
L["Blessings Deck"] = true
L["Lunacy Deck"] = true
L["Quest rewards"] = true

--World drop
L["Outdoor Bosses"] = true
L["Highlord Kruul"] = true
L["Bash'ir Landing"] = true
L["Skyguard Raid"] = true
L["Stasis Chambers"] = true
L["Skettis"] = true
L["Darkscreecher Akkarai"] = true
L["Karrog"] = true
L["Gezzarak the Huntress"] = true
L["Vakkiz the Windrager"] = true
L["Terokk"] = true
L["Ethereum Prison"] = true
L["Armbreaker Huffaz"] = true
L["Fel Tinkerer Zortan"] = true
L["Forgosh"] = true
L["Gul'bor"] = true
L["Malevus the Mad"] = true
L["Porfus the Gem Gorger"] = true
L["Wrathbringer Laz-tarash"] = true
L["Abyssal Council"] = true
L["Crimson Templar (Fire)"] = true
L["Azure Templar (Water)"] = true
L["Hoary Templar (Wind)"] = true
L["Earthen Templar (Earth)"] = true
L["The Duke of Cinders (Fire)"] = true
L["The Duke of Fathoms (Water)"] = true
L["The Duke of Zephyrs (Wind)"] = true
L["The Duke of Shards (Earth)"] = true
L["Elemental Invasion"] = true
L["Gurubashi Arena"] = true
L["Booty Run"] = true
L["Fishing Extravaganza"] = true
L["First Prize"] = true
L["Rare Fish"] = true
L["Rare Fish Rewards"] = true
L["Children's Week"] = true
L["Love is in the air"] = true
L["Gift of Adoration"] = true
L["Box of Chocolates"] = true
L["Hallow's End"] = true
L["Various Locations"] = true
L["Treat Bag"] = true
L["Headless Horseman"] = true
L["Feast of Winter Veil"] = true
L["Smokywood Pastures Vendor"] = true
L["Gaily Wrapped Present"] = true
L["Festive Gift"] = true
L["Winter Veil Gift"] = true
L["Gently Shaken Gift"] = true
L["Ticking Present"] = true
L["Carefully Wrapped Present"] = true
L["Noblegarden"] = true
L["Brightly Colored Egg"] = true
L["Smokywood Pastures Extra-Special Gift"] = true
L["Harvest Festival"] = true
L["Food"] = true
L["Scourge Invasion"] = true
L["Miscellaneous"] = true
L["Cloth Set"] = true
L["Leather Set"] = true
L["Mail Set"] = true
L["Plate Set"] = true
L["Balzaphon"] = true
L["Lord Blackwood"] = true
L["Revanchion"] = true
L["Scorn"] = true
L["Sever"] = true
L["Lady Falther'ess"] = true
L["Lunar Festival"] = true
L["Fireworks Pack"] = true
L["Lucky Red Envelope"] = true
L["Midsummer Fire Festival"] = true
L["Lord Ahune"] = true
L["Shartuul"] = true
L["Blade Edge Mountains"] = true
L["Brewfest"] = true
L["Barleybrew Brewery"] = true
L["Thunderbrew Brewery"] = true
L["Gordok Brewery"] = true
L["Drohn's Distillery"] = true
L["T'chali's Voodoo Brewery"] = true

--craft
L["Crafted Weapons"] = true
L["Master Swordsmith"] = true
L["Master Axesmith"] = true
L["Master Hammersmith"] = true
L["Blacksmithing (Lv 60)"] = true
L["Blacksmithing (Lv 70)"] = true
L["Engineering (Lv 60)"] = true
L["Engineering (Lv 70)"] = true
L["Blacksmithing Plate Sets"] = true
L["Imperial Plate"] = true
L["The Darksoul"] = true
L["Fel Iron Plate"] = true
L["Adamantite Battlegear"] = true
L["Flame Guard"] = true
L["Enchanted Adamantite Armor"] = true
L["Khorium Ward"] = true
L["Faith in Felsteel"] = true
L["Burning Rage"] = true
L["Blacksmithing Mail Sets"] = true
L["Bloodsoul Embrace"] = true
L["Fel Iron Chain"] = true
L["Tailoring Sets"] = true
L["Bloodvine Garb"] = true
L["Netherweave Vestments"] = true
L["Imbued Netherweave"] = true
L["Arcanoweave Vestments"] = true
L["The Unyielding"] = true
L["Whitemend Wisdom"] = true
L["Spellstrike Infusion"] = true
L["Battlecast Garb"] = true
L["Soulcloth Embrace"] = true
L["Primal Mooncloth"] = true
L["Shadow's Embrace"] = true
L["Wrath of Spellfire"] = true
L["Leatherworking Leather Sets"] = true
L["Volcanic Armor"] = true
L["Ironfeather Armor"] = true
L["Stormshroud Armor"] = true
L["Devilsaur Armor"] = true
L["Blood Tiger Harness"] = true
L["Primal Batskin"] = true
L["Wild Draenish Armor"] = true
L["Thick Draenic Armor"] = true
L["Fel Skin"] = true
L["Strength of the Clefthoof"] = true
L["Primal Intent"] = true
L["Windhawk Armor"] = true
L["Leatherworking Mail Sets"] = true
L["Green Dragon Mail"] = true
L["Blue Dragon Mail"] = true
L["Black Dragon Mail"] = true
L["Scaled Draenic Armor"] = true
L["Felscale Armor"] = true
L["Felstalker Armor"] = true
L["Fury of the Nether"] = true
L["Netherscale Armor"] = true
L["Netherstrike Armor"] = true
L["Armorsmith"] = true
L["Weaponsmith"] = true
L["Dragonscale"] = true
L["Elemental"] = true
L["Tribal"] = true
L["Mooncloth"] = true
L["Shadoweave"] = true
L["Spellfire"] = true
L["Gnomish"] = true
L["Goblin"] = true
L["Apprentice"] = true
L["Journeyman"] = true
L["Expert"] = true
L["Artisan"] = true
L["Master"] = true

--Set & PVP
L["Superior Rewards"] = true
L["Epic Rewards"] = true
L["Lv %s Rewards"] = true
L["PVP Cloth Set"] = true
L["PVP Leather Sets"] = true
L["PVP Mail Sets"] = true
L["PVP Plate Sets"] = true
L["World PVP"] = true
L["Hellfire Fortifications"] = true
L["Twin Spire Ruins"] = true
L["Spirit Towers (Terrokar)"] = true
L["Halaa (Nagrand)"] = true
L["Arena Season %d"] = true
L["Weapons"] = true
L["Accessories"] = true
L["Level 70 Reputation PVP"] = true
L["Level %d Honor PVP"] = true
L["Savage Gladiator\'s Weapons"] = true
L["Deadly Gladiator\'s Weapons"] = true
L["Lake Wintergrasp"] = true
L["Non Set Accessories"] = true
L["Non Set Cloth"] = true
L["Non Set Leather"] = true
L["Non Set Mail"] = true
L["Non Set Plate"] = true
L["Tier 0.5 Quests"] = true
L["Tier %d Tokens"] = true
L["Blizzard Collectables"] = true
L["WoW Collector Edition"] = true
L["BC Collector Edition (Europe)"] = true
L["Blizzcon 2005"] = true
L["Blizzcon 2007"] = true
L["Christmas Gift 2006"] = true
L["Upper Deck"] = true
L["Loot Card Items"] = true
L["Heroic Mode Tokens"] = true
L["Fire Resistance Gear"] = true
L["Emblems of Valor"] = true
L["Emblems of Heroism"] = true

L["Cloaks"] = true
L["Relics"] = true
L["World Drops"] = true
L["Level 30-39"] = true
L["Level 40-49"] = true
L["Level 50-60"] = true
L["Level 70"] = true

-- Altoholic.Gathering : Mining 
L["Copper Vein"] = true
L["Tin Vein"] = true
L["Iron Deposit"] = true
L["Silver Vein"] = true
L["Gold Vein"] = true
L["Mithril Deposit"] = true
L["Ooze Covered Mithril Deposit"] = true
L["Truesilver Deposit"] = true
L["Ooze Covered Silver Vein"] = true
L["Ooze Covered Gold Vein"] = true
L["Ooze Covered Truesilver Deposit"] = true
L["Ooze Covered Rich Thorium Vein"] = true
L["Ooze Covered Thorium Vein"] = true
L["Small Thorium Vein"] = true
L["Rich Thorium Vein"] = true
L["Hakkari Thorium Vein"] = true
L["Dark Iron Deposit"] = true
L["Lesser Bloodstone Deposit"] = true
L["Incendicite Mineral Vein"] = true
L["Indurium Mineral Vein"] = true
L["Fel Iron Deposit"] = true
L["Adamantite Deposit"] = true
L["Rich Adamantite Deposit"] = true
L["Khorium Vein"] = true
L["Large Obsidian Chunk"] = true
L["Small Obsidian Chunk"] = true
L["Nethercite Deposit"] = true

-- Altoholic.Gathering : Herbalism
L["Peacebloom"] = true
L["Silverleaf"] = true
L["Earthroot"] = true
L["Mageroyal"] = true
L["Briarthorn"] = true
L["Swiftthistle"] = true
L["Stranglekelp"] = true
L["Bruiseweed"] = true
L["Wild Steelbloom"] = true
L["Grave Moss"] = true
L["Kingsblood"] = true
L["Liferoot"] = true
L["Fadeleaf"] = true
L["Goldthorn"] = true
L["Khadgar's Whisker"] = true
L["Wintersbite"] = true
L["Firebloom"] = true
L["Purple Lotus"] = true
L["Wildvine"] = true
L["Arthas' Tears"] = true
L["Sungrass"] = true
L["Blindweed"] = true
L["Ghost Mushroom"] = true
L["Gromsblood"] = true
L["Golden Sansam"] = true
L["Dreamfoil"] = true
L["Mountain Silversage"] = true
L["Plaguebloom"] = true
L["Icecap"] = true
L["Bloodvine"] = true
L["Black Lotus"] = true
L["Felweed"] = true
L["Dreaming Glory"] = true
L["Terocone"] = true
L["Ancient Lichen"] = true
L["Bloodthistle"] = true
L["Mana Thistle"] = true
L["Netherbloom"] = true
L["Nightmare Vine"] = true
L["Ragveil"] = true
L["Flame Cap"] = true
L["Fel Lotus"] = true
L["Netherdust Bush"] = true

L["Glowcap"] = true
L["Sanguine Hibiscus"] = true
	
-- Old XML strings

L["Location"] = true
L["Left-click to |cFF00FF00open"] = true
L["Right-click to |cFF00FF00drag"] = true
L["Enter an account name that will be\nused for |cFF00FF00display|r purposes only."] = true
L["This name can be anything you like,\nit does |cFF00FF00NOT|r have to be the real account name."] = true
L["This field |cFF00FF00cannot|r be left empty."] = true

L["Summary"] = true
L["Characters"] = true

L["Account Summary"] = true
L["Bag Usage"] = true
L["Activity"] = true
L["Guild Members"] = true
L["Guild Skills"] = true
L["Guild Bank Tabs"] = true
L["Calendar"] = true

L["Account Sharing Request"] = true
L["Click this button to ask a player\nto share his entire Altoholic Database\nand add it to your own"] = true
L["Both parties must enable account sharing\nbefore using this feature (see options)"] = true
L["Account Sharing"] = true
				
L["Realm"] = true
L["Character"] = true
L["View"] = true

L["Item / Location"] = true

L["Hide this guild in the tooltip"] = true

L["Not started"] = true
L["Started"] = true

L["General"] = true
L["Tooltip"] = true

L["Totals"] = true
L["Search Containers"] = true
L["Equipment Slot"] = true
L["Reset"] = true

L["Account Name"] = true
L["Send account sharing request to:"] = true

--TabOptions.lua

-- ** Frame 1 : General **
L["Max rest XP displayed as 150%"] = true
L["Show FuBar icon"] = true
L["Show FuBar text"] = true
L["Account Sharing Enabled"] = true
L["Guild Communication Enabled"] = true

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto send you account sharing requests.\n"] = true
L["Your confirmation will still be required any time someone requests your information.\n\n"] = true
L["When |cFFFF0000disabled|cFFFFFFFF, all requests will be automatically rejected.\n\n"] = true
L["Security hint: Only enable this when you actually need to transfer data,\ndisable otherwise"] = true

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow your guildmates\nto see your alts and their professions.\n\n"] = true
L["When |cFFFF0000disabled|cFFFFFFFF, there will be no communication with the guild."] = true

L["Automatically authorize guild bank updates"] = true

L["|cFFFFFFFFWhen |cFF00FF00enabled|cFFFFFFFF, this option will allow other Altoholic users\nto update their guild bank information with yours automatically.\n\n"] = true
L["When |cFFFF0000disabled|cFFFFFFFF, your confirmation will be\nrequired before sending any information.\n\n"] = true
L["Security hint: disable this if you have officer rights\non guild bank tabs that may not be viewed by everyone,\nand authorize requests manually"] = true
L["Transparency"] = true

-- ** Frame 2 : Search **				
L["AutoQuery server |cFFFF0000(disconnection risk)"] = true
L["|cFFFFFFFFIf an item not in the local item cache\nis encountered while searching loot tables,\nAltoholic will attempt to query the server for 5 new items.\n\n"] = true
L["This will gradually improve the consistency of the searches,\nas more items are available in the item cache.\n\n"] = true
L["There is a risk of disconnection if the queried item\nis a loot from a high level dungeon.\n\n"] = true
L["|cFF00FF00Disable|r to avoid this risk"] = true


L["Sort loots in descending order"] = true
L["Include items without level requirement"] = true
L["Include mailboxes"] = true
L["Include guild bank(s)"] = true
L["Include known recipes"] = true
L["Include guild members' professions"] = true

-- ** Frame 3 : Mail **
L["Warn when mail expires in less days than this value"] = true
L["Mail Expiry Warning"] = true
L["Scan mail body (marks it as read)"] = true
L["New mail notification"] = true
L["Be informed when a guildmate sends a mail to one of my alts.\n\nMail content is directly visible without having to reconnect the character"] = true

-- ** Frame 4 : Minimap **
L["Move to change the angle of the minimap icon"] = true
L["Minimap Icon Angle"] = true
L["Move to change the radius of the minimap icon"] = true
L["Minimap Icon Radius"] = true
L["Show Minimap Icon"] = true

-- ** Frame 5 : Tooltip **
L["Show item source"] = true
L["Show item count per character"] = true
L["Show total item count"] = true
L["Show guild bank count"] = true
L["Show already known/learnable by"] = true
L["Show recipes already known/learnable by"] = true
L["Show pets already known/learnable by"] = true
L["Show item ID and item level"] = true
L["Show counters on gathering nodes"] = true
L["Show counters for both factions"] = true
L["Show counters for all accounts"] = true
L["Include guild bank count in the total count"] = true
L["Detailed guild bank count"] = true

-- ** Frame 6 : Calendar **
L["Week starts on Monday"] = true
L["Warn %d minutes before an event starts"] = true
L["Disable warnings"] = true
