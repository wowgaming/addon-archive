--[[
constants.en.lua
This file defines an AceLocale table for all the various text strings needed
by AtlasLoot.  In this implementation, if a translation is missing, it will fall
back to the English translation.

The AL["text"] = true; shortcut can ONLY be used for English (the root translation).
]]
-- Translated by acemage
-- Last Updated: 6/28/2007
-- missing some BabbleBoss names.

--Table holding all loot tables is initialised here as it loads early
--AtlasLoot_Data = {};

--Create the library instance
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");

local AL = AceLocale:NewLocale("AtlasLoot", "koKR", false);

--Register translations
if AL then

    --Text strings for UI objects
--	AL["AtlasLoot"] = true;
	AL["Select Loot Table"] = "루팅 테이블 선택";
	AL["Select Sub-Table"] = "하위 테이블 선택";
	AL["Drop Rate: "] = "드랍률: ";
--	AL["DKP"] = true;
	AL["Priority:"] = "우선도: ";
	AL["Click boss name to view loot."] = "보스이름을 클릭하면 루팅을 볼수 있습니다.";
	AL["Various Locations"] = "다양한 위치";
	AL["This is a loot browser only.  To view maps as well, install either Atlas or Alphamap."] = "이것은 루팅정보만 보여줍니다.  맵정보를 확인하려면 Atlas 또는 Alphamap을 설치하셔야 합니다";
	AL["Toggle AL Panel"] = "AL Panel 토글";
	AL["Back"] = "뒤로";
	AL["Level 60"] = "레벨 60";
	AL["Level 70"] = "레벨 70";
	AL["Level 80"] = "레벨 80";
	AL["|cffff0000(unsafe)"] = "|cffff0000(불안전)";
	AL["Misc"] = "일반";
--	AL["Miscellaneous"] = true;
	AL["Rewards"] = "보상";
	AL["Show 10 Man Loot"] = true;
	AL["Show 25 Man Loot"] = true;
--	AL["Factions - Original WoW"] = true;
--	AL["Factions - Burning Crusade"] = true;
--	AL["Factions - Wrath of the Lich King"] = true;
	AL["Choose Table ..."] = "테이블 선택 ...";
--	AL["Unknown"] = true;
--	AL["Add to QuickLooks:"] = true;
--	AL["Assign this loot table\n to QuickLook"] = true;
--	AL["Query Server"] = true;
--	AL["Reset Frames"] = true;
--	AL["Reset Wishlist"] = true;
--	AL["Reset Quicklooks"] = true;
--	AL["Select a Loot Table..."] = true;
--	AL["OR"] = true;
--	AL["FuBar Options"] = true;
---	AL["Attach to Minimap"] = true;
--	AL["Hide FuBar Plugin"] = true;
--	AL["Show FuBar Plugin"] = true;
--	AL["Position:"] = true;
--	AL["Left"] = true;
--	AL["Center"] = true;
--	AL["Right"] = true;
--	AL["Hide Text"] = true;
--	AL["Hide Icon"] = true;
--	AL["Minimap Button Options"] = true;

    --Text for Options Panel
	AL["Atlasloot Options"] = "Atlasloot 설정";
	AL["Safe Chat Links"] = "안전한 채팅 링크";
	AL["Default Tooltips"] = "기본 툴팁";
	AL["Lootlink Tooltips"] = "Lootlink 툴팁";
	AL["|cff9d9d9dLootlink Tooltips|r"] = "|cff9d9d9dLootlink 툴팁|r";
	AL["ItemSync Tooltips"] = "ItemSync 툴팁";
	AL["|cff9d9d9dItemSync Tooltips|r"] = "|cff9d9d9dItemSync 툴팁|r";
	AL["Use EquipCompare"] = "EquipCompare 사용";
	AL["|cff9d9d9dUse EquipCompare|r"] = "|cff9d9d9dEquipCompare 사용|r";
	AL["Show Comparison Tooltips"] = "비교 툴팁 보기";
	AL["Make Loot Table Opaque"] = "배경 불투명하게 하기";
	AL["Show itemIDs at all times"] = "itemID 항상 보기";
	AL["Hide AtlasLoot Panel"] = "AtlasLoot 숨기기";
	AL["Show Basic Minimap Button"] = "미니맵버튼 보이기"; -- Needs review
--	AL["|cff9d9d9dShow Basic Minimap Button|r"] = true;
	AL["Set Minimap Button Position"] = "미니맵버튼 위치 설정";
--	AL["Suppress Item Query Text"] = true;
--	AL["Notify on LoD Module Load"] = true;
--	AL["Load Loot Modules at Startup"] = true;
--	AL["Loot Browser Scale: "] = true;
--	AL["Button Position: "] = true;
--	AL["Button Radius: "] = true;
	AL["Done"] = "완료";
--	AL["FuBar Toggle"] = true;
--	AL["Search Result: %s"] = true;
--	AL["Search on"] = true;
--	AL["All modules"] = true;
--	AL["If checked, AtlasLoot will load and search across all the modules."] = true;
--	AL["Search options"] = true;
--	AL["Partial matching"] = true;
--	AL["If checked, AtlasLoot search item names for a partial match."] = true;
--	AL["You don't have any module selected to search on!"] = true;
--	AL["Treat Crafted Items:"] = true;
--	AL["As Crafting Spells"] = true;
--	AL["As Items"] = true;
--	AL["Loot Browser Style:"] = true;
--	AL["New Style"] = true;
--	AL["Classic Style"] = true;

	-- Slash commands
--	AL["reset"] = true;
--	AL["options"] = true;
--	AL["Reset complete!"] = true;

    --AtlasLoot Panel
	AL["Collections"] = "세트 모음집";
--	AL["Crafting"] = true;
	AL["Factions"] = "평판 진영";
--	AL["Load Modules"] = true;
	AL["Options"] = "설정";
	AL["PvP Rewards"] = "PvP 보상";
--	AL["QuickLook"] = true;
--	AL["World Events"] = true;

	-- AtlasLoot Panel - Search
	AL["Clear"] = "지우기";
--	AL["Last Result"] = true;
	AL["Search"] = "찾기";

	-- AtlasLoot Browser Menus
--	AL["Classic Instances"] = true;
--	AL["BC Instances"] = true;
	AL["Sets/Collections"] = "세트/모음집";
	AL["Reputation Factions"] = "평판 진영";
--	AL["WotLK Instances"] = true;
	AL["World Bosses"] = "월드 보스";
--	AL["Close Menu"] = true;

	-- Crafting Menu
--	AL["Crafting Daily Quests"] = true;
--	AL["Cooking Daily"] = true;
--	AL["Fishing Daily"] = true;
--	AL["Jewelcrafting Daily"] = true;
	AL["Crafted Sets"] = "제작 세트";
	AL["Crafted Epic Weapons"] = "제작된 영웅 무기";
--	AL["Dragon's Eye"] = true;

	-- Sets/Collections Menu
--	AL["Badge of Justice Rewards"] = true;
--	AL["Emblem of Valor Rewards"] = true;
--	AL["Emblem of Heroism Rewards"] = true;
--	AL["Emblem of Conquest Rewards"] = true;
--	AL["Emblem of Triumph Rewards"] = true;
--	AL["Emblem of Frost Rewards"] = true;
--	AL["BoE World Epics"] = true;
	AL["Dungeon 1/2 Sets"] = "던전 세트 1/2";
	AL["Dungeon 3 Sets"] = "던전 세트 3";
	AL["Legendary Items"] = "전설급 아이템";
--	AL["Mounts"] = true;
--	AL["Vanity Pets"] = true;
--	AL["Misc Sets"] = true;
--	AL["Classic Sets"] = true;
--	AL["Burning Crusade Sets"] = true;
--	AL["Wrath Of The Lich King Sets"] = true;
	AL["Ruins of Ahn'Qiraj Sets"] = "안퀴라즈 폐허 세트";
	AL["Temple of Ahn'Qiraj Sets"] = "안퀴라즈 사원 세트";
	AL["Tabards"] = "겉옷";
	AL["Tier 1/2 Sets"] = "T1/2 세트";
	AL["Tier 1/2/3 Sets"] = "T1/2/3 세트";
	AL["Tier 3 Sets"] = "T3 세트";
	AL["Tier 4/5/6 Sets"] = "T4/5/6 세트";
	AL["Tier 7/8 Sets"] = "T7/8 세트";
--	AL["Upper Deck Card Game Items"] = true;
	AL["Zul'Gurub Sets"] = "줄구룹 세트";

	-- Factions Menu
	AL["Original Factions"] = true;
	AL["BC Factions"] = true;
	AL["WotLK Factions"] = true;

	-- PvP Menu
	AL["Arena PvP Sets"] = "투기장 PvP 보상";
	AL["PvP Rewards (Level 60)"] = "PvP 보상 (레벨 60)";
	AL["PvP Rewards (Level 70)"] = "PvP 보상 (레벨 70)";
	AL["PvP Rewards (Level 80)"] = "PvP 보상 (레벨 80)";
	AL["Arathi Basin Sets"] = "아라시 분지 세트";
	AL["PvP Accessories"] = "PvP 장신구류";
	AL["PvP Armor Sets"] = "PvP 방어구 세트";
	AL["PvP Weapons"] = "PvP 무기";
	AL["PvP Non-Set Epics"] = "PvP Non-Set 영웅템";
--	AL["PvP Reputation Sets"] = true;
	AL["Arena PvP Weapons"] = "투기장 PvP 보상";
--	AL["PvP Misc"] = true;
--	AL["PVP Gems/Enchants/Jewelcrafting Designs"] = true;
--	AL["Level 80 PvP Sets"] = true;
--	AL["Old Level 80 PvP Sets"] = true;
--	AL["Arena Season 7/8 Sets"] = true;
--	AL["PvP Class Items"] = true;
--	AL["NOT AVAILABLE ANYMORE"] = true;

	-- World Events
--	AL["Abyssal Council"] = true;
--	AL["Argent Tournament"] = true;
--	AL["Bash'ir Landing Skyguard Raid"] = true;
--	AL["Brewfest"] = true;
--	AL["Children's Week"] = true;
--	AL["Day of the Dead"] = true;
--	AL["Elemental Invasion"] = true;
--	AL["Ethereum Prison"] = true;
--	AL["Feast of Winter Veil"] = true;
--	AL["Gurubashi Arena Booty Run"] = true;
--	AL["Hallow's End"] = true;
--	AL["Harvest Festival"] = true;
--	AL["Love is in the Air"] = true;
--	AL["Lunar Festival"] = true;
--	AL["Midsummer Fire Festival"] = true;
--	AL["Noblegarden"] = true;
--	AL["Pilgrim's Bounty"] = true;
--	AL["Skettis"] = true;
--	AL["Stranglethorn Fishing Extravaganza"] = true;

    --Minimap Button
	AL["|cff1eff00Left-Click|r Browse Loot Tables"] = "|cff1eff00왼쪽 클릭|r 루팅 테이블 화면";
	AL["|cffff0000Right-Click|r View Options"] = "|cffff0000오른쪽 클릭|r 설정 화면";
	AL["|cffff0000Shift-Click|r View Options"] = "|cffff0000Shift클릭|r 보기 설정";
	AL["|cffccccccLeft-Click + Drag|r Move Minimap Button"] = "|cffcccccc왼쪽 + 드레그|r 미니맵 버튼 이동";
--	AL["|cffccccccRight-Click + Drag|r Move Minimap Button"] = true;

	-- Filter
--	AL["Filter"] = true;
--	AL["Select All Loot"] = true;
--	AL["Apply Filter:"] = true;
--	AL["Armor:"] = true;
--	AL["Melee weapons:"] = true;
--	AL["Ranged weapons:"] = true;
--	AL["Relics:"] = true;
--	AL["Other:"] = true;

	-- Wishlist
--	AL["Close"] = true;
--	AL["Wishlist"] = true;
--	AL["Own Wishlists"] = true;
--	AL["Other Wishlists"] = true;
--	AL["Shared Wishlists"] = true;
--	AL["Mark items in loot tables"] = true;
--	AL["Mark items from own Wishlist"] = true;
--	AL["Mark items from all Wishlists"] = true;
--	AL["Enable Wishlist Sharing"] = true;
--	AL["Auto reject in combat"] = true;
--	AL["Always use default Wishlist"] = true;
--	AL["Add Wishlist"] = true;
--	AL["Edit Wishlist"] = true;
--	AL["Show More Icons"] = true;
--	AL["Wishlist name:"] = true;
--	AL["Delete"] = true;
--	AL["Edit"] = true;
--	AL["Share"] = true;
--	AL["Show all Wishlists"] = true;
--	AL["Show own Wishlists"] = true;
--	AL["Show shared Wishlists"] = true;
--	AL["You must wait "] = true;
--	AL[" seconds before you can send a new Wishlist to "] = true;
--	AL["Send Wishlist (%s) to"] = true;
--	AL["Send"] = true;
--	AL["Cancel"] = true;
--	AL["Delete Wishlist %s?"] = true;
--	AL["%s sends you a Wishlist. Accept?"] = true;
--	AL[" tried to send you a Wishlist. Rejected because you are in combat."] = true;
--	AL[" rejects your Wishlist."] = true;
--	AL["You can't send Wishlists to yourself"] = true;
--	AL["Please set a default Wishlist."] = true;
--	AL["Set as default Wishlist"] = true;

    --Misc Inventory related words
	AL["Enchant"] = "마법부여";
	AL["Scope"] = "장치";
	AL["Darkmoon Faire Card"] = "다크문 축제 카드";
	AL["Banner"] = "깃발";
	AL["Set"] = "세트";
	AL["Token"] = "휘장";
--	AL["Tokens"] = true;
--	AL["Token Hand-Ins"] = true;
--	AL["Skinning Knife"] = true;
--	AL["Herbalism Knife"] = true;
--	AL["Fish"] = true;
--	AL["Combat Pet"] = true;
--	AL["Fireworks"] = true;
--	AL["Fishing Lure"] = true;

	-- Extra inventory stuff
--	AL["Cloak"] = true;
--	AL["Sigil"] = true; -- Can be added to BabbleInv

	-- Alchemy
--	AL["Battle Elixirs"] = true;
--	AL["Guardian Elixirs"] = true;
--	AL["Potions"] = true;
--	AL["Transmutes"] = true;
--	AL["Flasks"] = true;

	-- Enchanting
--	AL["Enchant Boots"] = true;
--	AL["Enchant Bracer"] = true;
--	AL["Enchant Chest"] = true;
--	AL["Enchant Cloak"] = true;
--	AL["Enchant Gloves"] = true;
--	AL["Enchant Ring"] = true;
--	AL["Enchant Shield"] = true;
--	AL["Enchant 2H Weapon"] = true;
--	AL["Enchant Weapon"] = true;

	-- Engineering
--	AL["Ammunition"] = true;
--	AL["Explosives"] = true;

	-- Inscription
--	AL["Major Glyph"] = true;
--	AL["Minor Glyph"] = true;
--	AL["Scrolls"] = true;
--	AL["Off-Hand Items"] = true;
--	AL["Reagents"] = true;
--	AL["Book of Glyph Mastery"] = true;

	-- Leatherworking
--	AL["Leather Armor"] = true;
--	AL["Mail Armor"] = true;
--	AL["Cloaks"] = true;
--	AL["Item Enhancements"] = true;
--	AL["Quivers and Ammo Pouches"] = true;
--	AL["Drums, Bags and Misc."] = true;

	-- Tailoring
--	AL["Cloth Armor"] = true;
--	AL["Shirts"] = true;
--	AL["Bags"] = true;

	--Labels for loot descriptions
	AL["Classes:"] = "직업:";
	AL["This Item Begins a Quest"] = "퀘스트시작 아이템";
	AL["Quest Item"] = "퀘스트 아이템";
--	AL["Old Quest Item"] = true;
	AL["Quest Reward"] = "퀘스트 보상";
--	AL["Old Quest Reward"] = true;
	AL["Shared"] = "공통";
	AL["Unique"] = "유닉";
	AL["Right Half"] = "오른쪽 반쪽";
	AL["Left Half"] = "왼쪽 반쪽";
	AL["28 Slot Soul Shard"] = "28 칸 영혼";
	AL["20 Slot"] = "20칸";
	AL["18 Slot"] = "18칸";
	AL["16 Slot"] = "16칸";
	AL["10 Slot"] = "10칸";
	AL["(has random enchantment)"] = "(렌덤 마법부여)";
	AL["Currency"] = "보상아이템 구입에 사용";
	AL["Currency (Horde)"] = "보상아이템 구입에 사용 (호드)";
	AL["Currency (Alliance)"] = "보상아이템 구입에 사용 (얼라이언스)";
--	AL["Conjured Item"] = true;
--	AL["Used to summon boss"] = true;
--	AL["Tradable against sunmote + item above"] = true;
	AL["Card Game Item"] = "카드게임 아이템";
--	AL["Skill Required:"] = true;
--	AL["Rating:"] = true; -- Shorthand for 'Required Rating' for the personal/team ratings
--	AL["Random Heroic Reward"] = true;

	-- Minor Labels for loot table descriptions
--	AL["Original WoW"] = true;
--	AL["Burning Crusade"] = true;
--	AL["Wrath of the Lich King"] = true;
--	AL["Entrance"] = true;
	AL["Season 2"] = "시즌 2";
	AL["Season 3"] = "시즌 3";
	AL["Season 4"] = "시즌 4";
	AL["Dungeon Set 1"] = "던전 세트 1";
	AL["Dungeon Set 2"] = "던전 세트 2";
	AL["Dungeon Set 3"] = "던전 세트 3";
	AL["Tier 1"] = "T1";
	AL["Tier 2"] = "T2";
	AL["Tier 3"] = "T3";
	AL["Tier 4"] = "T4";
	AL["Tier 5"] = "T5";
	AL["Tier 6"] = "T6";
	AL["Tier 7"] = "T7";
	AL["Tier 8"] = "T8";
	AL["Tier 9"] = "T9";
	AL["Tier 10"] = "T10";
--	AL["10 Man"] = true;
--	AL["25 Man"] = true;
--	AL["10/25 Man"] = true;
	AL["Epic Set"] = "영웅 세트";
	AL["Rare Set"] = "희귀 세트";
--	AL["Fire"] = true;
--	AL["Water"] = true;
--	AL["Wind"] = true;
--	AL["Earth"] = true;
--	AL["Master Angler"] = true;
	AL["Fire Resistance Gear"] = "화염 저항 장비";
	AL["Arcane Resistance Gear"] = "비전 저항 장비";
	AL["Nature Resistance Gear"] = "자연 저항 장비";
--	AL["Frost Resistance Gear"] = true;
--	AL["Shadow Resistance Gear"] = true;

	-- Labels for loot table sections
--	AL["Additional Heroic Loot"] = true;
	AL["Heroic Mode"] = "영웅 모드";
	AL["Normal Mode"] = "일반 모드";
	AL["Raid"] = "레이드";
	AL["Arena Reward"] = "투기장 보상";
	AL["Accessories"] = "장신구류";  --Hard mode tokens

	-- Loot Table Names
	AL["PvP Accessories (Level 60)"] = "PvP 장신구류 (레벨 60)";
	AL["PvP Accessories (Level 70)"] = "PvP 장신구류 (레벨 70)";
	AL["Heroic"] = "Heroic";
	AL["Summon"] = "Summon";
	AL["Random"] = "Random";

	-- Extra Text in Boss lists
	AL["Set: Embrace of the Viper"] = "세트: 독사의 은총";
	AL["Set: Defias Leather"] = "세트: 데피아즈단";
	AL["Set: The Gladiator"] = "세트: 검투사";
	AL["Set: Chain of the Scarlet Crusade"] = "세트: 붉은십자군";
	AL["Set: The Postmaster"] = "세트: 우체국장";
	AL["Set: Necropile Raiment"] = "세트: 시체더미 의복";
	AL["Set: Cadaverous Garb"] = "세트: 시체 수의";
	AL["Set: Bloodmail Regalia"] = "세트: 피고리 제복";
	AL["Set: Deathbone Guardian"] = "세트: 죽음의 뼈갑옷";
	AL["Set: Dal'Rend's Arms"] = "세트: 달렌드의 무기";
	AL["Set: Spider's Kiss"] = "세트: 거미의 입마춤";
	AL["AQ20 Class Sets"] = "안퀴라즈 폐허 직업 세트";
	AL["AQ Enchants"] = "안퀴라즈 마법부여";
	AL["AQ40 Class Sets"] = "안퀴라즈 사원 직업 세트";
	AL["AQ Opening Quest Chain"] = "안퀴라즈 열기 연퀘";
	AL["ZG Class Sets"] = "줄구룹 직업 세트";
	AL["ZG Enchants"] = "줄구룹 마법부여";
	AL["Class Books"] = "직업 책";
	AL["Tribute Run"] = "공물함";
	AL["Dire Maul Books"] = "혈장 책";
	AL["Random Boss Loot"] = "렌덤 보스 루팅";

	-- Pets

	-- Mounts
	AL["Rare Mounts"] = "희귀 탈 것";

	-- Darkmoon Faire

	-- Card Game Decks and descriptions

	-- First set

	-- Second set

	-- Third set

	-- Fourth set

	-- Fifth set

	-- Sixth set

	-- Seventh set

	-- Eighth set

	-- Ninth set

	-- Tenth set

	-- Eleventh set

	-- Twelvth set
	-- Battleground Brackets
	AL["Misc. Rewards"] = "일반급 보상";

    --Brood of Nozdormu Paths
	AL["Path of the Conqueror"] = "정복자의 길";
	AL["Path of the Invoker"] = "기원사의 길";
	AL["Path of the Protector"] = "수호자의 길";

    --Violet Eye Paths
	AL["Path of the Violet Protector"] = "위대한 수호자의 길";
	AL["Path of the Violet Mage"] = "대마법사의 길";
	AL["Path of the Violet Assassin"] = "일급 암살자의 길";
	AL["Path of the Violet Restorer"] = "숭고한 구원자의 길";
	
	-- Ashen Verdict Paths
--	AL["Path of Courage"] = true;
--	AL["Path of Destruction"] = true;
--	AL["Path of Vengeance"] = true;
--	AL["Path of Wisdom"] = true;

    --AQ Opening Event
	AL["Red Scepter Shard"] = "붉은색 홀 파편";
	AL["Blue Scepter Shard"] = "파란색 홀 파편";
	AL["Green Scepter Shard"] = "녹색 홀 파편";
--	AL["Scepter of the Shifting Sands"] = "Scepter of the Shifting Sands";

    --World PvP
	AL["Hellfire Fortifications"] = "지옥불 성채";
	AL["Twin Spire Ruins"] = "쌍둥이 첨탑 폐허";
	AL["Spirit Towers"] = "영혼의 탑";
	AL["Halaa"] = "할라아";
--	AL["Venture Bay"] = true;

    --Karazhan Opera Event Headings
	AL["Shared Drops"] = "공통 드랍";
	AL["Romulo & Julianne"] = "로미오와 줄리엣";
	AL["Wizard of Oz"] = "오즈의 마법사";
	AL["Red Riding Hood"] = "빨간 두건";

    --Karazhan Animal Boss Types
	AL["Spider"] = "거미";
	AL["Darkhound"] = "똥개";
	AL["Bat"] = "박쥐";

    --ZG Tokens
	AL["Primal Hakkari Kossack"] = "고대 학카리 조끼";
	AL["Primal Hakkari Shawl"] = "고대 학카리 어깨걸이";
	AL["Primal Hakkari Bindings"] = "고대 학카리 팔보호구";
	AL["Primal Hakkari Sash"] = "고대 학카리 장식띠";
	AL["Primal Hakkari Stanchion"] = "고대 학카리 손목갑옷";
	AL["Primal Hakkari Aegis"] = "고대 학카리 아이기스";
	AL["Primal Hakkari Girdle"] = "고대 학카리 벨트";
	AL["Primal Hakkari Armsplint"] = "고대 학카리 어깨갑옷";
	AL["Primal Hakkari Tabard"] = "고대 학카리 휘장";

    --AQ20 Tokens
	AL["Qiraji Ornate Hilt"] = "화려한 퀴라지 자루";
	AL["Qiraji Martial Drape"] = "전쟁의 퀴라지 망토";
	AL["Qiraji Magisterial Ring"] = "권위의 퀴라지 반지";
	AL["Qiraji Ceremonial Ring"] = "의식의 퀴라지 반지";
	AL["Qiraji Regal Drape"] = "제왕의 퀴라지 망토";
	AL["Qiraji Spiked Hilt"] = "못박힌 퀴라지 자루";

    --AQ40 Tokens
	AL["Qiraji Bindings of Dominance"] = "지배의 퀴라지 팔보호구";
	AL["Qiraji Bindings of Command"] = "지휘의 퀴라지 팔보호구";
	AL["Vek'nilash's Circlet"] = "베크닐라쉬의 관";
	AL["Vek'lor's Diadem"] = "베클로어의 관";
	AL["Ouro's Intact Hide"] = "온전한 아우로의 가죽";
	AL["Skin of the Great Sandworm"] = "거대한 미늘벌레의 가죽";
	AL["Husk of the Old God"] = "고대신의 허물";
	AL["Carapace of the Old God"] = "고대신의 껍질";

	-- Blacksmithing Mail Crafted Sets
	AL["Bloodsoul Embrace"] = "붉은영혼의 손아귀";
	AL["Fel Iron Chain"] = "지옥무쇠 사슬 방어구";

	-- Blacksmithing Plate Crafted Sets
	AL["Imperial Plate"] = "황제의 갑옷";
	AL["The Darksoul"] = "검은 영혼의 손아귀";
	AL["Fel Iron Plate"] = "지옥무쇠 판금 방어구";
	AL["Adamantite Battlegear"] = "아다만다이트 전투장비";
	AL["Flame Guard"] = "화염의 수호";
	AL["Enchanted Adamantite Armor"] = "마력 깃든 아다만다이트 갑옷";
	AL["Khorium Ward"] = "코륨 방어구";
	AL["Faith in Felsteel"] = "지옥강철 전투장비";
	AL["Burning Rage"] = "불타는 분노";

    --Leatherworking Crafted Sets
	AL["Volcanic Armor"] = "화산 갑옷";
	AL["Ironfeather Armor"] = "무쇠깃털 갑옷";
	AL["Stormshroud Armor"] = "폭풍안개 갑옷";
	AL["Devilsaur Armor"] = "데빌사우루스 갑옷";
	AL["Blood Tiger Harness"] = "붉은호랑이 방어구";
	AL["Primal Batskin"] = "원시 박쥐가죽";
	AL["Wild Draenish Armor"] = "야생의 드레나이 방어구";
	AL["Thick Draenic Armor"] = "두꺼운 드레나이 방어구";
	AL["Fel Skin"] = "지옥 가죽 방어구";
	AL["Strength of the Clefthoof"] = "갈래발굽의 힘";
	AL["Primal Intent"] = "원소쐐기 갑옷";
	AL["Windhawk Armor"] = "바람매 갑옷";
	-- Leatherworking Crafted Mail Sets
	AL["Green Dragon Mail"] = "녹색용 쇠사슬 갑옷";
	AL["Blue Dragon Mail"] = "푸른용 쇠사슬 갑옷";
	AL["Black Dragon Mail"] = "검은용 쇠사슬 갑옷";
	AL["Scaled Draenic Armor"] = "드레나이 미늘 갑옷";
	AL["Felscale Armor"] = "지옥껍질 갑옷";
	AL["Felstalker Armor"] = "지옥추적자 갑옷";
	AL["Fury of the Nether"] = "황천의 격노";
	AL["Netherscale Armor"] = "황천비늘 갑옷";
	AL["Netherstrike Armor"] = "황천쐐기 갑옷";

    --Tailoring Crafted Sets
	AL["Bloodvine Garb"] = "붉은덩굴 의복";
	AL["Netherweave Vestments"] = "황천매듭 제복";
	AL["Imbued Netherweave"] = "마력 깃든 황천매듭 제복";
	AL["Arcanoweave Vestments"] = "비전매듭 의복";
	AL["The Unyielding"] = "불굴의 방어구";
	AL["Whitemend Wisdom"] = "백마법의 지혜";
	AL["Spellstrike Infusion"] = "마법 강타의 마력";
	AL["Battlecast Garb"] = "전투시전술 의복";
	AL["Soulcloth Embrace"] = "영혼매듭 예복";
	AL["Primal Mooncloth"] = "태초의 달빛매듭 의복";
	AL["Shadow's Embrace"] = "어둠의 은총";
	AL["Wrath of Spellfire"] = "마법불꽃의 격노";

	-- Classic WoW Sets
	AL["Defias Leather"] = "데피아즈단";
	AL["Embrace of the Viper"] = "독사의 은총";
	AL["Chain of the Scarlet Crusade"] = "붉은십자군";
	AL["The Gladiator"] = "검투사";
	AL["Ironweave Battlesuit"] = "강철매듭 전투장비";
	AL["Necropile Raiment"] = "시체더미 의복";
	AL["Cadaverous Garb"] = "시체 수의";
	AL["Bloodmail Regalia"] = "피고리 제복";
	AL["Deathbone Guardian"] = "죽음의 뼈갑옷";
	AL["The Postmaster"] = "우체국장";
	AL["Shard of the Gods"] = "신의 파편";
	AL["Zul'Gurub Rings"] = "줄구룹 반지";
	AL["Major Mojo Infusion"] = "강력한 모조";
	AL["Overlord's Resolution"] = "대군주의 결의";
	AL["Prayer of the Primal"] = "원시술사의 기원";
	AL["Zanzil's Concentration"] = "잔질의 집중력";
	AL["Spirit of Eskhandar"] = "에스칸다르의 영혼";
	AL["The Twin Blades of Hakkari"] = "학카리 쌍검";
	AL["Primal Blessing"] = "원시 축복";
	AL["Dal'Rend's Arms"] = "달렌드의 무기";
	AL["Spider's Kiss"] = "거미의 입마춤";

	-- The Burning Crusade Sets
	AL["The Twin Stars"] = "쌍둥이 별";
	AL["The Twin Blades of Azzinoth"] = "아지노스의 쌍날검";

	-- Wrath of the Lich King Sets

	-- Recipe origin strings
    --Scourge Invasion
	AL["Scourge Invasion"] = "스컬지 침공";
--	AL["Scourge Invasion Sets"] = true;
--	AL["Blessed Regalia of Undead Cleansing"] = true;
--	AL["Undead Slayer's Blessed Armor"] = true;
--	AL["Blessed Garb of the Undead Slayer"] = true;
--	AL["Blessed Battlegear of Undead Slaying"] = true;
--	AL["Prince Tenris Mirkblood"] = true;

    --ZG Sets
	AL["Haruspex's Garb"] = "제사장의 의복";
	AL["Predator's Armor"] = "수렵꾼의 갑옷";
	AL["Illusionist's Attire"] = "환영술사의 의복";
	AL["Freethinker's Armor"] = "자유사상가의 갑옷";
	AL["Confessor's Raiment"] = "성자의 의복";
	AL["Madcap's Outfit"] = "개혁가의 장비";
	AL["Augur's Regalia"] = "점술가의 의복";
	AL["Demoniac's Threads"] = "악령술사의 의복";
	AL["Vindicator's Battlegear"] = "구원자의 전투장비";

    --AQ20 Sets
	AL["Symbols of Unending Life"] = "영원한 삶의 의복";
	AL["Trappings of the Unseen Path"] = "선도자의 전투장비";
	AL["Trappings of Vaulted Secrets"] = "밝혀진 비밀의 의복";
	AL["Battlegear of Eternal Justice"] = "영원한 정의의 전투장비";
	AL["Finery of Infinite Wisdom"] = "무한한 지혜의 의복";
	AL["Emblems of Veiled Shadows"] = "어두운그림자의 상징";
	AL["Gift of the Gathering Storm"] = "휘몰아치는 폭풍의 선물";
	AL["Implements of Unspoken Names"] = "절대자의 의복";
	AL["Battlegear of Unyielding Strength"] = "굴하지 않는 힘의 전투장비";

    --AQ40 Sets
	AL["Genesis Raiment"] = "태초의 의복";
	AL["Striker's Garb"] = "관통의 전투장비";
	AL["Enigma Vestments"] = "불가사의의 의복";
	AL["Avenger's Battlegear"] = "응징의 전투장비";
	AL["Garments of the Oracle"] = "신탁의 예복";
	AL["Deathdealer's Embrace"] = "죽음의 선고자 전투장비";
	AL["Stormcaller's Garb"] = "폭풍소환사의 어깨갑옷";
	AL["Doomcaller's Attire"] = "파멸의 소환사";
	AL["Conqueror's Battlegear"] = "정복자의 전투장비";

    --Dungeon 1 Sets
	AL["Wildheart Raiment"] = "자연의 정수 의복";
	AL["Beaststalker Armor"] = "야수 추적자 갑옷";
	AL["Magister's Regalia"] = "원소술사 의복";
	AL["Lightforge Armor"] = "성전사 방어구";
	AL["Vestments of the Devout"] = "기원의 의목";
	AL["Shadowcraft Armor"] = "어둠추적자 갑옷";
	AL["The Elements"] = "정령의 방어구";
	AL["Dreadmist Raiment"] = "공포의 안개 의복";
	AL["Battlegear of Valor"] = "용맹의 전투장비";

    --Dungeon 2 Sets
	AL["Feralheart Raiment"] = "야생의 정수 의복";
	AL["Beastmaster Armor"] = "야수왕의 갑옷";
	AL["Sorcerer's Regalia"] = "마술사의 의복";
	AL["Soulforge Armor"] = "성령의 갑옷";
	AL["Vestments of the Virtuous"] = "고결의 의복";
	AL["Darkmantle Armor"] = "검은장막의 방어구";
	AL["The Five Thunders"] = "우레의 방어구";
	AL["Deathmist Raiment"] = "죽음의 안개 의복";
	AL["Battlegear of Heroism"] = "무용의 전투장비";

    --Dungeon 3 Sets
	AL["Hallowed Raiment"] = "신성의 예복";
	AL["Incanter's Regalia"] = "주문술사 의복";
	AL["Mana-Etched Regalia"] = "마나 깃든 예복";
	AL["Oblivion Raiment"] = "망각의 수의";
	AL["Assassination Armor"] = "암살의 제복";
	AL["Moonglade Raiment"] = "달의 숲 의복";
	AL["Wastewalker Armor"] = "거친 황야 의복";
	AL["Beast Lord Armor"] = "야수군주 갑옷";
	AL["Desolation Battlegear"] = "황폐의 방어구";
	AL["Tidefury Raiment"] = "성난 파도의 방어구";
	AL["Bold Armor"] = "용자의 갑옷";
	AL["Doomplate Battlegear"] = "파멸의 판금 갑옷";
	AL["Righteous Armor"] = "정의의 방어구";

    --Tier 1 Sets
	AL["Cenarion Raiment"] = "세나리온 의복";
	AL["Giantstalker Armor"] = "거인추적자 갑옷";
	AL["Arcanist Regalia"] = "신비술사 의복";
	AL["Lawbringer Armor"] = "집행의 방어구";
	AL["Vestments of Prophecy"] = "계시의 의복";
	AL["Nightslayer Armor"] = "밤그림자 갑옷";
	AL["The Earthfury"] = "지각변동의 방어구";
	AL["Felheart Raiment"] = "타락심장의 의복";
	AL["Battlegear of Might"] = "투지의 전투장비";

    --Tier 2 Sets
	AL["Stormrage Raiment"] = "성난폭풍 의복";
	AL["Dragonstalker Armor"] = "용추적자 갑옷";
	AL["Netherwind Regalia"] = "소용돌이 의복";
	AL["Judgement Armor"] = "심판의 갑옷";
	AL["Vestments of Transcendence"] = "초월의 의복";
	AL["Bloodfang Armor"] = "붉은송곳니 방어구";
	AL["The Ten Storms"] = "폭풍우 방어구";
	AL["Nemesis Raiment"] = "천벌의 의복";
	AL["Battlegear of Wrath"] = "격노의 전투장비";

    --Tier 3 Sets
	AL["Dreamwalker Raiment"] = "꿈의감시자 의복";
	AL["Cryptstalker Armor"] = "지하추적자 갑옷";
	AL["Frostfire Regalia"] = "얼음불꽃 의복";
	AL["Redemption Armor"] = "구원의 갑옷";
	AL["Vestments of Faith"] = "신념의 의복";
	AL["Bonescythe Armor"] = "해골사신의 갑옷";
	AL["The Earthshatterer"] = "지축이동의 갑옷";
	AL["Plagueheart Raiment"] = "역병의심장 의복";
	AL["Dreadnaught's Battlegear"] = "무쌍의 전투장비";

    --Tier 4 Sets
	AL["Malorne Harness"] = "말로른의 갑옷";
	AL["Malorne Raiment"] = "말로른의 예복";
	AL["Malorne Regalia"] = "말로른의 의복";
	AL["Demon Stalker Armor"] = "악마추적자의 갑옷";
	AL["Aldor Regalia"] = "알도르 의복";
	AL["Justicar Armor"] = "심판관의 갑옷";
	AL["Justicar Battlegear"] = "심판관의 전투장비";
	AL["Justicar Raiment"] = "심판관의 예복";
	AL["Incarnate Raiment"] = "현신의 예복";
	AL["Incarnate Regalia"] = "현신의 의복";
	AL["Netherblade Set"] = "황천의 칼날";
	AL["Cyclone Harness"] = "회오리 갑옷";
	AL["Cyclone Raiment"] = "회오리 예복";
	AL["Cyclone Regalia"] = "회오리 의복";
	AL["Voidheart Raiment"] = "공허의심장 의복";
	AL["Warbringer Armor"] = "전쟁의 인도자 갑옷";
	AL["Warbringer Battlegear"] = "전쟁의 인도자 전투장비";

    --Tier 5 Sets
	AL["Nordrassil Harness"] = "놀드랏실 갑옷";
	AL["Nordrassil Raiment"] = "놀드랏실 예복";
	AL["Nordrassil Regalia"] = "놀드랏실 의복";
	AL["Rift Stalker Armor"] = "균열추적자 갑옷";
	AL["Tirisfal Regalia"] = "티리스팔 의복";
	AL["Crystalforge Armor"] = "정화의 갑옷";
	AL["Crystalforge Battlegear"] = "정화의 전투장비";
	AL["Crystalforge Raiment"] = "정화의 예복";
	AL["Avatar Raiment"] = "화신의 예복";
	AL["Avatar Regalia"] = "화신의 의복";
	AL["Deathmantle Set"] = "죽음의 장막";
	AL["Cataclysm Harness"] = "천재지변의 갑옷";
	AL["Cataclysm Raiment"] = "천재지변의 예복";
	AL["Cataclysm Regalia"] = "천재지변의 의복";
	AL["Corruptor Raiment"] = "타락자의 의복";
	AL["Destroyer Armor"] = "파괴자의 갑옷";
	AL["Destroyer Battlegear"] = "파괴자의 전투장비";

    --Tier 6 Sets
	AL["Thunderheart Harness"] = "천둥심장 갑옷";
	AL["Thunderheart Raiment"] = "천둥심장 예복";
	AL["Thunderheart Regalia"] = "천둥심장 의복";
	AL["Gronnstalker's Armor"] = "그론추적자 갑옷";
	AL["Tempest Regalia"] = "폭풍우 의복";
	AL["Lightbringer Armor"] = "빛의 수호자 갑옷";
	AL["Lightbringer Battlegear"] = "빛의 수호자 전투장비";
	AL["Lightbringer Raiment"] = "빛의 수호자 예복";
	AL["Vestments of Absolution"] = "면죄의 예복";
	AL["Absolution Regalia"] = "면죄의 의복";
	AL["Slayer's Armor"] = "학살자의 제복";
	AL["Skyshatter Harness"] = "무너지는 하늘의 갑옷";
	AL["Skyshatter Raiment"] = "무너지는 하늘의 예복";
	AL["Skyshatter Regalia"] = "무너지는 하늘의 의복";
	AL["Malefic Raiment"] = "재앙의 의복";
	AL["Onslaught Armor"] = "맹공의 갑옷";
	AL["Onslaught Battlegear"] = "맹공의 전투장비";

	-- Tier 7 Sets
--	AL["Scourgeborne Battlegear"] = true;
--	AL["Scourgeborne Plate"] = true;
--	AL["Dreamwalker Garb"] = true;
--	AL["Dreamwalker Battlegear"] = true;
--	AL["Dreamwalker Regalia"] = true;
--	AL["Cryptstalker Battlegear"] = true;
--	AL["Frostfire Garb"] = true;
--	AL["Redemption Regalia"] = true;
--	AL["Redemption Battlegear"] = true;
--	AL["Redemption Plate"] = true;
--	AL["Regalia of Faith"] = true;
--	AL["Garb of Faith"] = true;
--	AL["Bonescythe Battlegear"] = true;
--	AL["Earthshatter Garb"] = true;
--	AL["Earthshatter Battlegear"] = true;
--	AL["Earthshatter Regalia"] = true;
--	AL["Plagueheart Garb"] = true;
--	AL["Dreadnaught Battlegear"] = true;
--	AL["Dreadnaught Plate"] = true;

	-- Tier 8 Sets
--	AL["Darkruned Battlegear"] = true;
--	AL["Darkruned Plate"] = true;
--	AL["Nightsong Garb"] = true;
--	AL["Nightsong Battlegear"] = true;
--	AL["Nightsong Regalia"] = true;
--	AL["Scourgestalker Battlegear"] = true;
--	AL["Kirin Tor Garb"] = true;
--	AL["Aegis Regalia"] = true;
--	AL["Aegis Battlegear"] = true;
--	AL["Aegis Plate"] = true;
--	AL["Sanctification Regalia"] = true;
--	AL["Sanctification Garb"] = true;
--	AL["Terrorblade Battlegear"] = true;
--	AL["Worldbreaker Garb"] = true;
--	AL["Worldbreaker Battlegear"] = true;
--	AL["Worldbreaker Regalia"] = true;
--	AL["Deathbringer Garb"] = true;
--	AL["Siegebreaker Battlegear"] = true;
--	AL["Siegebreaker Plate"] = true;

	-- Tier 9 Sets
--	AL["Malfurion's Garb"] = true;
--	AL["Malfurion's Battlegear"] = true;
--	AL["Malfurion's Regalia"] = true;
--	AL["Runetotem's Garb"] = true;
--	AL["Runetotem's Battlegear"] = true;
--	AL["Runetotem's Regalia"] = true;
--	AL["Windrunner's Battlegear"] = true;
--	AL["Windrunner's Pursuit"] = true;
--	AL["Khadgar's Regalia"] = true;
--	AL["Sunstrider's Regalia"] = true;
--	AL["Turalyon's Garb"] = true;
--	AL["Turalyon's Battlegear"] = true;
--	AL["Turalyon's Plate"] = true;
--	AL["Liadrin's Garb"] = true;
--	AL["Liadrin's Battlegear"] = true;
--	AL["Liadrin's Plate"] = true;
--	AL["Velen's Regalia"] = true;
--	AL["Velen's Raiment"] = true;
--	AL["Zabra's Regalia"] = true;
--	AL["Zabra's Raiment"] = true;
--	AL["VanCleef's Battlegear"] = true;
--	AL["Garona's Battlegear"] = true;
--	AL["Nobundo's Garb"] = true;
--	AL["Nobundo's Battlegear"] = true;
--	AL["Nobundo's Regalia"] = true;
--	AL["Thrall's Garb"] = true;
--	AL["Thrall's Battlegear"] = true;
--	AL["Thrall's Regalia"] = true;
--	AL["Kel'Thuzad's Regalia"] = true;
--	AL["Gul'dan's Regalia"] = true;
--	AL["Wrynn's Battlegear"] = true;
--	AL["Wrynn's Plate"] = true;
--	AL["Hellscream's Battlegear"] = true;
--	AL["Hellscream's Plate"] = true;
--	AL["Thassarian's Battlegear"] = true;
--	AL["Koltira's Battlegear"] = true;
--	AL["Thassarian's Plate"] = true;
--	AL["Koltira's Plate"] = true;

	-- Tier 10 Sets
--	AL["Lasherweave's Garb"] = true;
--	AL["Lasherweave's Battlegear"] = true;
--	AL["Lasherweave's Regalia"] = true;
--	AL["Ahn'Kahar Blood Hunter's Battlegear"] = true;
--	AL["Bloodmage's Regalia"] = true;
--	AL["Lightsworn Garb"] = true;
--	AL["Lightsworn Plate"] = true;
--	AL["Lightsworn Battlegear"] = true;
--	AL["Crimson Acolyte's Regalia"] = true;
--	AL["Crimson Acolyte's Raiment"] = true;
--	AL["Shadowblade's Battlegear"] = true;
--	AL["Frost Witch's Garb"] = true;
--	AL["Frost Witch's Battlegear"] = true;
--	AL["Frost Witch's Regalia"] = true;
--	AL["Dark Coven's Garb"] = true;
--	AL["Ymirjar Lord's Battlegear"] = true;
--	AL["Ymirjar Lord's Plate"] = true;
--	AL["Scourgelord's Battlegear"] = true;
--	AL["Scourgelord's Plate"] = true;

    --Arathi Basin Sets - Alliance
	AL["The Highlander's Intent"] = "산악연대의 기상";
	AL["The Highlander's Purpose"] = "산악연대의 맹새";
	AL["The Highlander's Will"] = "산악연대의 의지";
	AL["The Highlander's Determination"] = "산악연대의 결심";
--	AL["The Highlander's Fortitude"] = true;
	AL["The Highlander's Resolution"] = "산악연대의 결의";
	AL["The Highlander's Resolve"] = "산악연대의 결단";

    --Arathi Basin Sets - Horde
	AL["The Defiler's Intent"] = "파멸단의 기상";
	AL["The Defiler's Purpose"] = "파멸단의 맹세";
	AL["The Defiler's Will"] = "파멸단의 의지";
	AL["The Defiler's Determination"] = "파멸단의 결심";
	AL["The Defiler's Fortitude"] = "파멸단의 인내";
	AL["The Defiler's Resolution"] = "파멸단의 결의";

    --PvP Level 60 Rare Sets - Alliance
	AL["Lieutenant Commander's Refuge"] = "위안의 부사령관 의복";
	AL["Lieutenant Commander's Pursuance"] = "추적의 부사령관 갑옷";
	AL["Lieutenant Commander's Arcanum"] = "비전의 부사령관 의복";
	AL["Lieutenant Commander's Redoubt"] = "보루의 부사령관 갑옷";
	AL["Lieutenant Commander's Investiture"] = "신탁의 부사령관 의복";
	AL["Lieutenant Commander's Guard"] = "경계의 부사령관 갑옷";
	AL["Lieutenant Commander's Stormcaller"] = "폭풍의 부사령관 갑옷";
	AL["Lieutenant Commander's Dreadgear"] = "공포의 부사령관 의복";
	AL["Lieutenant Commander's Battlearmor"] = "전투의 부사령관 갑옷";

    --PvP Level 60 Rare Sets - Horde
	AL["Champion's Refuge"] = "위안의 부사령관 의복";
	AL["Champion's Pursuance"] = "추적의 부사령관 갑옷";
	AL["Champion's Arcanum"] = "비전의 부사령관 의복";
	AL["Champion's Redoubt"] = "보루의 부사령관 갑옷";
	AL["Champion's Investiture"] = "신탁의 부사령관 의복";
	AL["Champion's Guard"] = "경계의 부사령관 갑옷";
	AL["Champion's Stormcaller"] = "폭풍의 부사령관 갑옷";
	AL["Champion's Dreadgear"] = "공포의 부사령관 의복";
	AL["Champion's Battlearmor"] = "전투의 부사령관 갑옷";

    --PvP Level 60 Epic Sets - Alliance
	AL["Field Marshal's Sanctuary"] = "야전사령관의 드루이드 의복";
	AL["Field Marshal's Pursuit"] = "야전사령관의 사냥꾼 갑옷";
	AL["Field Marshal's Regalia"] = "야전사령관의 마법사 의복";
	AL["Field Marshal's Aegis"] = "야전사령관의 성기사 갑옷";
	AL["Field Marshal's Raiment"] = "야전사령관의 사제 예복";
	AL["Field Marshal's Vestments"] = "야전사령관의 도적 제복";
	AL["Field Marshal's Earthshaker"] = "야전사령관의 주술사 갑옷";
	AL["Field Marshal's Threads"] = "야전사령관의 흑마법사 의복";
	AL["Field Marshal's Battlegear"] = "야전사령관의 전사 갑옷";

    --PvP Level 60 Epic Sets - Horde
	AL["Warlord's Sanctuary"] = "장군의 드루이드 의복";
	AL["Warlord's Pursuit"] = "장군의 사냥꾼 갑옷";
	AL["Warlord's Regalia"] = "장군의 마법사 의복";
	AL["Warlord's Aegis"] = "장군의 성기사 갑옷";
	AL["Warlord's Raiment"] = "장군의 사제 예복";
	AL["Warlord's Vestments"] = "장군의 도적 제복";
	AL["Warlord's Earthshaker"] = "장군의 주술사 갑옷";
	AL["Warlord's Threads"] = "장군의 흑마법사 의복";
	AL["Warlord's Battlegear"] = "장군의 전사 갑옷";

	-- Outland Faction Reputation PvP Sets
--	AL["Dragonhide Battlegear"] = true;
--	AL["Wyrmhide Battlegear"] = true;
--	AL["Kodohide Battlegear"] = true;
--	AL["Stalker's Chain Battlegear"] = true;
--	AL["Evoker's Silk Battlegear"] = true;
--	AL["Crusader's Scaled Battledgear"] = true;
--	AL["Crusader's Ornamented Battledgear"] = true;
--	AL["Satin Battlegear"] = true;
--	AL["Mooncloth Battlegear"] = true;
--	AL["Opportunist's Battlegear"] = true;
--	AL["Seer's Linked Battlegear"] = true;
--	AL["Seer's Mail Battlegear"] = true;
--	AL["Seer's Ringmail Battlegear"] = true;
--	AL["Dreadweave Battlegear"] = true;
--	AL["Savage's Plate Battlegear"] = true;

    --Arena Epic Sets
	AL["Gladiator's Sanctuary"] = "성역의 검투사 의복";
	AL["Gladiator's Wildhide"] = "야생의 검투사 방어구";
	AL["Gladiator's Refuge"] = "위안의 검투사 의복";
	AL["Gladiator's Pursuit"] = "추적의 검투사 장비";
	AL["Gladiator's Regalia"] = "비전의 검투사 의복";
	AL["Gladiator's Aegis"] = "심판의 검투사 전투장비";
	AL["Gladiator's Vindication"] = "비호의 검투사 방어구";
	AL["Gladiator's Redemption"] = "구원의 검투사 방어구";
	AL["Gladiator's Raiment"] = "믿음의 검투사 예복";
	AL["Gladiator's Investiture"] = "신탁의 검투사 예복";
	AL["Gladiator's Vestments"] = "암살의 검투사 제복";
	AL["Gladiator's Earthshaker"] = "지각변동의 검투사 방어구";
	AL["Gladiator's Thunderfist"] = "천둥주먹의 검투사 방어구";
	AL["Gladiator's Wartide"] = "전세의 검투사 방어구";
	AL["Gladiator's Dreadgear"] = "공포의 검투사 의복";
	AL["Gladiator's Felshroud"] = "악마의 검투사 수의";
	AL["Gladiator's Battlegear"] = "전투의 검투사 갑옷";
--	AL["Gladiator's Desecration"] = true;

	-- Level 80 PvP Weapons
--	AL["Savage Gladiator\'s Weapons"] = true; --unused
--	AL["Deadly Gladiator\'s Weapons"] = true; --unused
--	AL["Furious Gladiator\'s Weapons"] = true;
--	AL["Relentless Gladiator\'s Weapons"] = true;
--	AL["Wrathful Gladiator\'s Weapons"] = true;

	-- Months
--	AL["January"] = true;
--	AL["February"] = true;
--	AL["March"] = true;
--	AL["April"] = true;
--	AL["May"] = true;
--	AL["June"] = true;
--	AL["July"] = true;
--	AL["August"] = true;
--	AL["September"] = true;
--	AL["October"] = true;
--	AL["November"] = true;
--	AL["December"] = true;

	-- Specs
--	AL["Balance"] = true;
--	AL["Feral"] = true;
--	AL["Restoration"] = true;
--	AL["Holy"] = true;
--	AL["Protection"] = true;
--	AL["Retribution"] = true;
--	AL["Shadow"] = true;
--	AL["Elemental"] = true;
--	AL["Enhancement"] = true;
--	AL["Fury"] = true;
--	AL["Demonology"] = true;
--	AL["Destruction"] = true;
--	AL["Tanking"] = true;
--	AL["DPS"] = true;

	-- Naxx Zones
--	AL["Construct Quarter"] = true;
--	AL["Arachnid Quarter"] = true;
--	AL["Military Quarter"] = true;
--	AL["Plague Quarter"] = true;
--	AL["Frostwyrm Lair"] = true;

    --NPCs missing from BabbleBoss
	AL["Trash Mobs"] = "일반 몹";
	AL["Dungeon Set 2 Summonable"] = "던전 세트 2 소환가능";
--	AL["Highlord Kruul"] = "Highlord Kruul";
	AL["Theldren"] = "텔드렌";
	AL["Sothos and Jarien"] = "소도스와 자리엔";
	AL["Druid of the Fang"] = "송곳니의 드루이드";
	AL["Defias Strip Miner"] = "드랍 : 데피아즈단 갱부";
	AL["Defias Overseer/Taskmaster"] = "드랍 : 데피아즈단 갱부 감독관/작업반장";
	AL["Scarlet Defender/Myrmidon"] = "드랍 : 붉은십자군 호위병/정예병";
	AL["Scarlet Champion"] = "드랍 : 붉은십자군 용사";
	AL["Scarlet Centurion"] = "드랍 : 붉은십자군 백인대장";
	AL["Scarlet Trainee"] = "드랍 : 붉은십자군 신병";
	AL["Herod/Mograine"] = "드랍 : 헤로드/모그레인";
	AL["Scarlet Protector/Guardsman"] = "드랍 : 붉은십자군 수호병/보초";
	AL["Shadowforge Flame Keeper"] = "어둠괴철로단 불꽃지기";
	AL["Olaf"] = "올라프";
	AL["Eric 'The Swift'"] = "날쌘돌이 에릭";
--	AL["Shadow of Doom"] = "Shadow of Doom";
--	AL["Bone Witch"] = "Bone Witch";
--	AL["Lumbering Horror"] = "Lumbering Horror";
	AL["Avatar of the Martyred"] = "순교자의 화신";
--	AL["Yor"] = "Yor";
	AL["Nexus Stalker"] = "연합 추적자";
	AL["Auchenai Monk"] = "아키나이 수도승";
	AL["Cabal Fanatic"] = "비밀결사단 광신자";
	AL["Unchained Doombringer"] = "풀려난 파멸의 인도자";
--	AL["Crimson Sorcerer"] = true;
--	AL["Thuzadin Shadowcaster"] = true;
--	AL["Crimson Inquisitor"] = true;
--	AL["Crimson Battle Mage"] = true;
--	AL["Ghoul Ravener"] = true;
--	AL["Spectral Citizen"] = true;
--	AL["Spectral Researcher"] = true;
--	AL["Scholomance Adept"] = true;
--	AL["Scholomance Dark Summoner"] = true;
--	AL["Blackhand Elite"] = true;
--	AL["Blackhand Assassin"] = true;
--	AL["Firebrand Pyromancer"] = true;
--	AL["Firebrand Invoker"] = true;
--	AL["Firebrand Grunt"] = true;
--	AL["Firebrand Legionnaire"] = true;
--	AL["Spirestone Warlord"] = true;
--	AL["Spirestone Mystic"] = true;
--	AL["Anvilrage Captain"] = true;
--	AL["Anvilrage Marshal"] = true;
--	AL["Doomforge Arcanasmith"] = true;
--	AL["Weapon Technician"] = true;
--	AL["Doomforge Craftsman"] = true;
--	AL["Murk Worm"] = true;
--	AL["Atal'ai Witch Doctor"] = true;
--	AL["Raging Skeleton"] = true;
--	AL["Ethereal Priest"] = true;
--	AL["Sethekk Ravenguard"] = true;
--	AL["Time-Lost Shadowmage"] = true;
--	AL["Coilfang Sorceress"] = true;
--	AL["Coilfang Oracle"] = true;
--	AL["Shattered Hand Centurion"] = true;
--	AL["Eredar Deathbringer"] = true;
--	AL["Arcatraz Sentinel"] = true;
--	AL["Gargantuan Abyssal"] = true;
--	AL["Sunseeker Botanist"] = true;
--	AL["Sunseeker Astromage"] = true;
--	AL["Durnholde Rifleman"] = true;
--	AL["Rift Keeper/Rift Lord"] = true;
--	AL["Crimson Templar"] = true;
--	AL["Azure Templar"] = true;
--	AL["Hoary Templar"] = true;
--	AL["Earthen Templar"] = true;
--	AL["The Duke of Cynders"] = true;
--	AL["The Duke of Fathoms"] = true;
--	AL["The Duke of Zephyrs"] = true;
--	AL["The Duke of Shards"] = true;
--	AL["Aether-tech Assistant"] = true;
--	AL["Aether-tech Adept"] = true;
--	AL["Aether-tech Master"] = true;
--	AL["Trelopades"] = true;
--	AL["King Dorfbruiser"] = true;
--	AL["Gorgolon the All-seeing"] = true;
--	AL["Matron Li-sahar"] = true;
--	AL["Solus the Eternal"] = true;
--	AL["Balzaphon"] = true;
--	AL["Lord Blackwood"] = true;
--	AL["Revanchion"] = true;
--	AL["Scorn"] = true;
--	AL["Sever"] = true;
--	AL["Lady Falther'ess"] = true;
--	AL["Smokywood Pastures Vendor"] = true;
--	AL["Shartuul"] = true;
--	AL["Darkscreecher Akkarai"] = true;
--	AL["Karrog"] = true;
--	AL["Gezzarak the Huntress"] = true;
--	AL["Vakkiz the Windrager"] = true;
--	AL["Terokk"] = true;
--	AL["Armbreaker Huffaz"] = true;
--	AL["Fel Tinkerer Zortan"] = true;
--	AL["Forgosh"] = true;
--	AL["Gul'bor"] = true;
--	AL["Malevus the Mad"] = true;
--	AL["Porfus the Gem Gorger"] = true;
--	AL["Wrathbringer Laz-tarash"] = true;
--	AL["Bash'ir Landing Stasis Chambers"] = true;
--	AL["Templars"] = true;
--	AL["Dukes"] = true;
--	AL["High Council"] = true;
--	AL["Headless Horseman"] = true; --Is in BabbleBoss
--	AL["Barleybrew Brewery"] = true;
--	AL["Thunderbrew Brewery"] = true;
--	AL["Gordok Brewery"] = true;
--	AL["Drohn's Distillery"] = true;
--	AL["T'chali's Voodoo Brewery"] = true;
--	AL["Scarshield Quartermaster"] = true;
--	AL["Overmaster Pyron"] = true; --Is in BabbleBoss
--	AL["Father Flame"] = true;
--	AL["Thomas Yance"] = true;
--	AL["Knot Thimblejack"] = true;
--	AL["Shen'dralar Provisioner"] = true;
--	AL["Namdo Bizzfizzle"] = true;
--	AL["The Nameles Prophet"] = true;
--	AL["Zelemar the Wrathful"] = true;
--	AL["Henry Stern"] = true; --Is in BabbleBoss
--	AL["Aggem Thorncurse"] = true;
--	AL["Roogug"] = true;
--	AL["Rajaxx's Captains"] = true;
--	AL["Razorfen Spearhide"] = true;
--	AL["Rethilgore"] = true;
--	AL["Kalldan Felmoon"] = true;
--	AL["Magregan Deepshadow"] = true;
--	AL["Lord Ahune"] = true;
--	AL["Coren Direbrew"] = true; --Is in BabbleBoss
--	AL["Don Carlos"] = true;
--	AL["Thomas Yance"] = true;
--	AL["Aged Dalaran Wizard"] = true;
--	AL["Cache of the Legion"] = true;
--	AL["Rajaxx's Captains"] = true;
--	AL["Felsteed"] = true;
--	AL["Shattered Hand Executioner"] = true;
--	AL["Commander Stoutbeard"] = true; -- Is in BabbleBoss
--	AL["Bjarngrim"] = true; -- Is in BabbleBoss
--	AL["Loken"] = true; -- Is in BabbleBoss
--	AL["Time-Lost Proto Drake"] = true;
--	AL["Faction Champions"] = true; -- if you have a better name, use it.
--	AL["Razzashi Raptor"] = true;
--	AL["Deviate Ravager/Deviate Guardian"] = true;
--	AL["Krick and Ick"]  = true;

	--Zones
	AL["World Drop"] = "월드 드랍";
--	AL["Sunwell Isle"] = true;

	--Shortcuts for Bossname files
--	AL["LBRS"] = true;
--	AL["UBRS"] = true;
--	AL["CoT1"] = true;
--	AL["CoT2"] = true;
--	AL["Scholo"] = true;
--	AL["Strat"] = true;
--	AL["Serpentshrine"] = true;
--	AL["Avatar"] = true; -- Avatar of the Martyred

    --Chests, etc
	AL["Dark Coffer"] = "비밀 금고";
	AL["The Secret Safe"] = "검은 금고";
	AL["The Vault"] = "검은 금고";
	AL["Ogre Tannin Basket"] = "오우거 타닌 바구니";
	AL["Fengus's Chest"] = "펜쿠스의 괴짝";
	AL["The Prince's Chest"] = "오래된 괴짝";
	AL["Doan's Strongbox"] = "도안의 금고";
	AL["Frostwhisper's Embalming Fluid"] = "프로스트위스퍼의 불변의 영액";
	AL["Unforged Rune Covered Breastplate"] = "버려지지 않은 룬문자 흉갑";
	AL["Malor's Strongbox"] = "말로의 금고";
	AL["Unfinished Painting"] = "완성되지 않은 그림";
	AL["Felvine Shard"] = "악령덩쿨 조각";
	AL["Baelog's Chest"] = "밸로그의 괴짝";
	AL["Lorgalis Manuscript"] = "로르갈리스 초본";
	AL["Fathom Core"] = "심연의 핵";
--	AL["Conspicuous Urn"] = true;
--	AL["Gift of Adoration"] = true;
--	AL["Box of Chocolates"] = true;
--	AL["Treat Bag"] = true;
--	AL["Gaily Wrapped Present"] = true;
--	AL["Festive Gift"] = true;
--	AL["Ticking Present"] = true;
--	AL["Gently Shaken Gift"] = true;
--	AL["Carefully Wrapped Present"] = true;
--	AL["Winter Veil Gift"] = true;
--	AL["Smokywood Pastures Extra-Special Gift"] = true;
--	AL["Brightly Colored Egg"] = true;
--	AL["Lunar Festival Fireworks Pack"] = true;
--	AL["Lucky Red Envelope"] = true;
--	AL["Small Rocket Recipes"] = true;
--	AL["Large Rocket Recipes"] = true;
--	AL["Cluster Rocket Recipes"] = true;
--	AL["Large Cluster Rocket Recipes"] = true;
--	AL["Timed Reward Chest"] = true;
--	AL["Timed Reward Chest 1"] = true;
--	AL["Timed Reward Chest 2"] = true;
--	AL["Timed Reward Chest 3"] = true;
--	AL["Timed Reward Chest 4"] = true;
--	AL["The Talon King's Coffer"] = true;
--	AL["Krom Stoutarm's Chest"] = true;
--	AL["Garrett Family Chest"] = true;
--	AL["Reinforced Fel Iron Chest"] = true;
--	AL["DM North Tribute Chest"] = true;
--	AL["The Saga of Terokk"] = true;
--	AL["First Fragment Guardian"] = true;
--	AL["Second Fragment Guardian"] = true;
--	AL["Third Fragment Guardian"] = true;
--	AL["Overcharged Manacell"] = true;
--	AL["Mysterious Egg"] = true;
--	AL["Hyldnir Spoils"] = true;
--	AL["Ripe Disgusting Jar"] = true;
--	AL["Cracked Egg"] = true;
--	AL["Small Spice Bag"] = true;
--	AL["Handful of Candy"] = true;
--	AL["Lovely Dress Box"] = true;
--	AL["Dinner Suit Box"] = true;
--	AL["Bag of Heart Candies"] = true;

	-- The next 4 lines are the tooltip for the Server Query Button
	-- The translation doesn't have to be literal, just re-write the
	-- sentences as you would naturally and break them up into 4 roughly
	-- equal lines.
--	AL["Queries the server for all items"] = true;
--	AL["on this page. The items will be"] = true;
--	AL["refreshed when you next mouse"] = true;
--	AL["over them."] = true;
--	AL["The Minimap Button is generated by the FuBar Plugin."] = true;
--	AL["This is automatic, you do not need FuBar installed."] = true;

	-- Help Frame
--	AL["Help"] = true;
--	AL["AtlasLoot Help"] = true;
--	AL["For further help, see our website and forums: "] = true;
--	AL["How to open the standalone Loot Browser:"] = true;
--	AL["If you have AtlasLootFu enabled, click the minimap button, or alternatively a button generated by a mod like Titan or FuBar.  Finally, you can type '/al' in the chat window."] = true;
--	AL["How to view an 'unsafe' item:"] = true;
--	AL["Unsafe items have a red border around the icon and are marked because you have not seen the item since the last patch or server restart. Right-click the item, then move your mouse back over the item or click the 'Query Server' button at the bottom of the loot page."] = true;
--	AL["How to view an item in the Dressing Room:"] = true;
--	AL["Simply Ctrl+Left Click on the item.  Sometimes the dressing room window is hidden behind the Atlas or AtlasLoot windows, so if nothing seems to happen move your Atlas or AtlasLoot windows and see if anything is hidden."] = true;
--	AL["How to link an item to someone else:"] = true;
--	AL["Shift+Left Click the item like you would for any other in-game item"] = true;
--	AL["How to add an item to the wishlist:"] = true;
--	AL["Alt+Left Click any item to add it to the wishlist."] = true;
--	AL["How to delete an item from the wishlist:"] = true;
--	AL["While on the wishlist screen, just Alt+Left Click on an item to delete it."] = true;
--	AL["What else does the wishlist do?"] = true;
--	AL["If you Left Click any item on the wishlist, you can jump to the loot page the item comes from.  Also, on a loot page any item already in your wishlist is marked with a yellow star."] = true;
--	AL["HELP!! I have broken the mod somehow!"] = true;
--	AL["Use the reset buttons available in the options menu, or type '/al reset' in your chat window."] = true;

	-- Error Messages and warnings
--	AL["AtlasLoot Error!"] = true;
--	AL["WishList Full!"] = true;
--	AL[" added to the WishList."] = true;
--	AL[" already in the WishList!"] = true;
--	AL[" deleted from the WishList."] = true;
	AL["No match found for"] = "와 일치하는게 없습니다";
	AL[" is safe."] = " 은 이제 안전합니다.";
	AL["Server queried for "] = "서버에 ";
	AL[".  Right click on any other item to refresh the loot page."] = "에 대한 정보를 요청합니다.  다른 아이템을 우클릭하면 페이지가 수정됩니다.";

	-- Incomplete Table Registry error message
--	AL[" not listed in loot table registry, please report this message to the AtlasLoot forums at http://www.atlasloot.net"] = true;

	-- LoD Module disabled or missing
--	AL[" is unavailable, the following load on demand module is required: "] = true;

	-- LoD Module load sequence could not be completed
--	AL["Status of the following module could not be determined: "] = true;

	-- LoD Module required has loaded, but loot table is missing
--	AL[" could not be accessed, the following module may be out of date: "] = true;

	-- LoD module not defined
--	AL["Loot module returned as nil!"] = true;

	-- LoD module loaded successfully
--	AL["sucessfully loaded."] = true;

	-- Need a big dataset for searching
--	AL["Loading available tables for searching"] = true;

	-- All Available modules loaded
--	AL["All Available Modules Loaded"] = true;

	-- First time user
--	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences."] = true;
--	AL["Welcome to Atlasloot Enhanced.  Please take a moment to set your preferences for tooltips and links in the chat window.\n\n  This options screen can be reached again at any later time by typing '/atlasloot'."] = true;
--	AL["Setup"] = true;

    --Old Atlas Detected
	AL["It has been detected that your version of Atlas does not match the version that Atlasloot is tuned for ("] = "Atlas 버전과 Atlasloot 버전이 일치하지 않는 것이 감지되었습니다 (";
	AL[").  Depending on changes, there may be the occasional error, so please visit http://www.atlasmod.com as soon as possible to update."] = ").  버전 일치가 안되서 에러가 있을지도 모릅니다.가능한 빨리 http://www.atlasmod.com를 방문해서 최신 버전으로 업데이트를 해주시기 바랍니다.";
	AL["OK"] = "확인";
	AL["Incompatible Atlas Detected"] = "호환되지 않는 altas 감지";

    --Unsafe item tooltip
	AL["Unsafe Item"] = "불안전 아이템";
--	AL["Item Unavailable"] = true;
	AL["ItemID:"] = "ItemID:";
--	AL["This item is not available on your server or your battlegroup yet."] = true;
	AL["This item is unsafe.  To view this item without the risk of disconnection, you need to have first seen it in the game world. This is a restriction enforced by Blizzard since Patch 1.10."] = "불안전 아이템.  서버 연결종료의 위험 없이 아이템을 보려면 먼저 게임에서 해당 아이템을 보셔야 합니다. 이는 1.10 패치후 블리자드가 채택한 사항입니다.";
	AL["You can right-click to attempt to query the server.  You may be disconnected."] = "오른쪽 클릭으로 서버에 아이템 정보를 요청할 수 있습니다.  서버연결이 종료될 수도 있습니다.";
end
