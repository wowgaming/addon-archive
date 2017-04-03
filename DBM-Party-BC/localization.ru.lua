if GetLocale() ~= "ruRU" then return end

local L

-------------------------
--  Hellfire Ramparts  --
-----------------------------
--  Watchkeeper Gargolmar  --
-----------------------------
L = DBM:GetModLocalization("Gargolmar")

L:SetGeneralLocalization({
	name = "Начальник стражи Гарголмар"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------
--  Omor the Unscarred  --
--------------------------
L = DBM:GetModLocalization("Omor")

L:SetGeneralLocalization({
	name = "Омор Неодолимый"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SetIconOnBaneTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(37566)
})

------------------------
--  Nazan & Vazruden  --
------------------------
L = DBM:GetModLocalization("Vazruden")

L:SetGeneralLocalization({
	name = "Назан & Вазруден"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
--  The Blood Furnace  --
-------------------------
--  The Maker  --
-----------------
L = DBM:GetModLocalization("Maker")

L:SetGeneralLocalization({
	name = "Мастер"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------
--  Broggok  --
---------------
L = DBM:GetModLocalization("Broggok")

L:SetGeneralLocalization({
	name = "Броггок"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------------------
--  Keli'dan the Breaker  --
----------------------------
L = DBM:GetModLocalization("Keli'dan")

L:SetGeneralLocalization({
	name = "Кели'дан Разрушитель"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------------
--  The Shattered Halls  --
--------------------------------
--  Grand Warlock Nethekurse  --
--------------------------------
L = DBM:GetModLocalization("Nethekurse")

L:SetGeneralLocalization({
	name = "Главный чернокнижник Пустоклят"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------
--  Blood Guard Porung  --
--------------------------
L = DBM:GetModLocalization("Porung")

L:SetGeneralLocalization({
	name = "Кровавый страж Порунг"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------
--  Warbringer O'mrogg  --
--------------------------
L = DBM:GetModLocalization("O'mrogg")

L:SetGeneralLocalization({
	name = "О'мрогг Завоеватель"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------------------------
--  Warchief Kargath Bladefist  --
----------------------------------
L = DBM:GetModLocalization("Kargath")

L:SetGeneralLocalization({
	name = "Вождь Каргат Острорук"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------
--  Slave Pens  --
--------------------------
--  Mennu the Betrayer  --
--------------------------
L = DBM:GetModLocalization("Mennu")

L:SetGeneralLocalization({
	name = "Менну Предатель"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------------
--  Rokmar the Crackler  --
---------------------------
L = DBM:GetModLocalization("Rokmar")

L:SetGeneralLocalization({
	name = "Рокмар Трескун"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------
--  Quagmirran  --
------------------
L = DBM:GetModLocalization("Quagmirran")

L:SetGeneralLocalization({
	name = "Зыбун"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------
--  The Underbog  --
--------------------
--  Hungarfen  --
-----------------
L = DBM:GetModLocalization("Hungarfen")

L:SetGeneralLocalization({
	name = "Топеглад"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------
--  Ghaz'an  --
---------------
L = DBM:GetModLocalization("Ghazan")

L:SetGeneralLocalization({
	name = "Газ'ан"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------
--  Swamplord Musel'ek  --
--------------------------
L = DBM:GetModLocalization("Muselek")

L:SetGeneralLocalization({
	name = "Владыка болота Мусел'ек"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
--  The Black Stalker  --
-------------------------
L = DBM:GetModLocalization("Stalker")

L:SetGeneralLocalization({
	name = "Черная Охотница"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------------
--  The Steamvault  --
---------------------------
--  Hydromancer Thespia  --
---------------------------
L = DBM:GetModLocalization("Thespia")

L:SetGeneralLocalization({
	name = "Гидромант Теспия"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------------
--  Mekgineer Steamrigger  --
-----------------------------
L = DBM:GetModLocalization("Steamrigger")

L:SetGeneralLocalization({
	name = "Анжинер Паропуск"
})

L:SetWarningLocalization({
	WarnSummon	= "Steamrigger Mechanics incomming"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnSummon	= "Show warning for Steamrigger Mechanics"
})

L:SetMiscLocalization({
	Mechs	= "Tune 'em up good boys!"
})

--------------------------
--  Warlord Kalithresh  --
--------------------------
L = DBM:GetModLocalization("Kalithresh")

L:SetGeneralLocalization({
	name = "Полководец Калитреш"
})

L:SetWarningLocalization({
	WarnChannel	= "Channeling"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnChannel	= "Show warning when channeling"
})

-----------------------
--  Auchenai Crypts  --
--------------------------------
--  Shirrak the Dead Watcher  --
--------------------------------
L = DBM:GetModLocalization("Shirrak")

L:SetGeneralLocalization({
	name = "Ширрак Страж Мертвых"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------
--  Exarch Maladaar  --
-----------------------
L = DBM:GetModLocalization("Maladaar")

L:SetGeneralLocalization({
	name = "Экзарх Маладаар"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------
--  Mana-Tombs  --
-------------------
--  Pandemonius  --
-------------------
L = DBM:GetModLocalization("Pandemonius")

L:SetGeneralLocalization({
	name = "Пандемоний"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------
--  Tavarok  --
---------------
L = DBM:GetModLocalization("Tavarok")

L:SetGeneralLocalization({
	name = "Таварок"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------------------
--  Nexus-Prince Shaffar  --
----------------------------
L = DBM:GetModLocalization("Shaffar")

L:SetGeneralLocalization({
	name = "Принц Шаффар"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------
--  Yor  --
-----------
L = DBM:GetModLocalization("Yor")

L:SetGeneralLocalization({
	name = "Йор"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------
--  Sethekk Halls  --
-----------------------
--  Darkweaver Syth  --
-----------------------
L = DBM:GetModLocalization("Syth")

L:SetGeneralLocalization({
	name = "Темнопряд Сит"
})

L:SetWarningLocalization({
	SummonElementals	= "Elementals spawned"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SummonElementals	= "Show warning for Elemental spawns"
})

------------
--  Anzu  --
------------
L = DBM:GetModLocalization("Anzu")

L:SetGeneralLocalization({
	name = "Анзу"
})

L:SetWarningLocalization({
	warnBirds	= "Brood of Anzu soon",
	warnStoned	= "%s returned to stone"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	warnBirds	= "Show pre-warning for Brood of Anzu",
	warnStoned	= "Show warning for spirits returning to stone"
})

L:SetMiscLocalization({
    BirdStone	= "%s returns to stone."
})

------------------------
--  Talon King Ikiss  --
------------------------
L = DBM:GetModLocalization("Ikiss")

L:SetGeneralLocalization({
	name = "Король воронов Айкисс"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------
--  Shadow Labyrinth  --
--------------------------
--  Ambassador Hellmaw  --
--------------------------
L = DBM:GetModLocalization("Hellmaw")

L:SetGeneralLocalization({
	name = "Посол Гиблочрев"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------------
--  Blackheart the Inciter  --
------------------------------
L = DBM:GetModLocalization("Inciter")

L:SetGeneralLocalization({
	name = "Черносерд Проповедник"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------
--  Grandmaster Vorpil  --
--------------------------
L = DBM:GetModLocalization("Vorpil")

L:SetGeneralLocalization({
	name = "Великий мастер Ворпил"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------
--  Murmur  --
--------------
L = DBM:GetModLocalization("Murmur")

L:SetGeneralLocalization({
	name = "Бормотун"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SetIconOnTouchTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(33711)
})

-------------------------------
--  Old Hillsbrad Foothills  --
-------------------------------
--  Lieutenant Drake  --
------------------------
L = DBM:GetModLocalization("Drake")

L:SetGeneralLocalization({
	name = "Лейтенант Дрейк"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------
--  Captain Skarloc  --
-----------------------
L = DBM:GetModLocalization("Skarloc")

L:SetGeneralLocalization({
	name = "Капитан Скарлок"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------
--  Epoch Hunter  --
--------------------
L = DBM:GetModLocalization("EpochHunter")

L:SetGeneralLocalization({
	name = "Охотник Вечности"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------
--  The Black Morass  --
------------------------
--  Chrono Lord Deja  --
------------------------
L = DBM:GetModLocalization("Deja")

L:SetGeneralLocalization({
	name = "Повелитель времени Дежа"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})
----------------
--  Temporus  --
----------------
L = DBM:GetModLocalization("Temporus")

L:SetGeneralLocalization({
	name = "Темпорус"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})
--------------
--  Aeonus  --
--------------
L = DBM:GetModLocalization("Aeonus")

L:SetGeneralLocalization({
	name = "Эонус"
})

L:SetWarningLocalization({
    warnFrenzy	= "Frenzy"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
    warnFrenzy	= "Show warning for Frenzy"
})

L:SetMiscLocalization({
    AeonusFrenzy	= "%s goes into a frenzy!"
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "Таймеры порталов (ПВ)"
})

L:SetWarningLocalization({
    WarnWavePortalSoon	= "New portal soon",
    WarnWavePortal		= "Portal %d",
    WarnBossPortalSoon	= "Boss incoming soon",
    WarnBossPortal		= "Boss incoming"
})

L:SetTimerLocalization({
	TimerNextPortal		= "Portal %d",
})

L:SetOptionLocalization({
    WarnWavePortalSoon	= "Show pre-warning for new portal",
    WarnWavePortal		= "Show warning for new portal",
    WarnBossPortalSoon	= "Show pre-warning for boss incoming",
    WarnBossPortal		= "Show warning for boss incoming",
	TimerNextPortal		= "Show timer for portal number"
})

L:SetMiscLocalization({
	PortalCheck			= "Врат Времени открыто: (%d+)/18",
	Shielddown			= "No! Damn this feeble, mortal coil!"
})

--------------------
--  The Mechanar  --
-----------------------------
--  Gatewatcher Gyro-Kill  --
-----------------------------
L = DBM:GetModLocalization("Gyrokill")

L:SetGeneralLocalization({
	name = "Страж ворот Точеный Нож"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------------
--  Gatewatcher Iron-Hand  --
-----------------------------
L = DBM:GetModLocalization("Ironhand")

L:SetGeneralLocalization({
	name = "Страж ворот Стальная Клешня"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	JackHammer	= "%s raises his hammer menacingly..."
})

------------------------------
--  Mechano-Lord Capacitus  --
------------------------------
L = DBM:GetModLocalization("Capacitus")

L:SetGeneralLocalization({
	name = "Механо-лорд Конденсарон"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------------
--  Nethermancer Sepethrea  --
------------------------------
L = DBM:GetModLocalization("Sepethrea")

L:SetGeneralLocalization({
	name = "Пустомант Сепетрея"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------------
--  Pathaleon the Calculator  --
--------------------------------
L = DBM:GetModLocalization("Pathaleon")

L:SetGeneralLocalization({
	name = "Паталеон Вычислитель"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------
--  The Botanica  --
--------------------------
--  Commander Sarannis  --
--------------------------
L = DBM:GetModLocalization("Sarannis")

L:SetGeneralLocalization({
	name = "Командир Сараннис"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------------
--  High Botanist Freywinn  --
------------------------------
L = DBM:GetModLocalization("Freywinn")

L:SetGeneralLocalization({
	name = "Верховный ботаник Фрейвин"
})

L:SetWarningLocalization({
	WarnTranq	= "Tranquility - Kill Frayer Protectors"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnTranq	= "Show warning for Tranquility"
})

-----------------------------
--  Thorngrin the Tender  --
-----------------------------
L = DBM:GetModLocalization("Thorngrin")

L:SetGeneralLocalization({
	name = "Скалезуб Скорбный"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------
--  Laj  --
-----------
L = DBM:GetModLocalization("Laj")

L:SetGeneralLocalization({
	name = "Ладж"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------
--  Warp Splinter  --
---------------------
L = DBM:GetModLocalization("WarpSplinter")

L:SetGeneralLocalization({
	name = "Узлодревень"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------
--  The Arcatraz  --
----------------------------
--  Zereketh the Unbound  --
----------------------------
L = DBM:GetModLocalization("Zereketh")

L:SetGeneralLocalization({
	name = "Зерекет Бездонный"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------------
--  Dalliah the Doomsayer  --
-----------------------------
L = DBM:GetModLocalization("Dalliah")

L:SetGeneralLocalization({
	name = "Даллия Глашатай Судьбы"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------------------
--  Wrath-Scryer Soccothrates  --
---------------------------------
L = DBM:GetModLocalization("Soccothrates")

L:SetGeneralLocalization({
	name = "Провидец Гнева Соккорат"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
--  Harbinger Skyriss  --
-------------------------
L = DBM:GetModLocalization("Skyriss")

L:SetGeneralLocalization({
	name = "Предвестник Скайрисс"
})

L:SetWarningLocalization({
	warnSplit		= "Split",
	warnSplitSoon	= "Split soon"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	warnSplit		= "Show warning for Split",
	warnSplitSoon	= "Show pre-warning for Split"
})

L:SetMiscLocalization({
	Split	= "We span the universe, as countless as the stars!"
})

--------------------------
--  Magisters' Terrace  --
--------------------------
--  Selin Fireheart  --
-----------------------
L = DBM:GetModLocalization("Selin")

L:SetGeneralLocalization({
	name = "Селин Огненное Сердце"
})

L:SetWarningLocalization({
	warnChanneling	= "Fel Crystal channeling"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	warnChanneling	= "Show warning for Fel Crystal channeling"
})

L:SetMiscLocalization({
	ChannelCrystal	= "%s begins to channel from the nearby Fel Crystal..."
})

----------------
--  Vexallus  --
----------------
L = DBM:GetModLocalization("Vexallus")

L:SetGeneralLocalization({
	name = "Вексалиус"
})

L:SetWarningLocalization({
	WarnEnergy	= "Pure Energy"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnEnergy	= "Show warning for Pure Energy"
})

L:SetMiscLocalization({
	Discharge	= "Un...con...tainable."
})

--------------------------
--  Priestess Delrissa  --
--------------------------
L = DBM:GetModLocalization("Delrissa")

L:SetGeneralLocalization({
	name = "Жрица Делрисса"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	DelrissaPull	= "Annihilate them.",
	DelrissaEnd		= "Not what I had... planned."
})

------------------------------------
--  Kael'thas Sunstrider (Party)  --
------------------------------------
L = DBM:GetModLocalization("Kael")

L:SetGeneralLocalization({
	name = "Кель'тас Солнечный Скиталец (группа)"
})

L:SetWarningLocalization({
	specwarnPyroblast	= "Pyroblast - Interrupt now"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	specwarnPyroblast	= "Show special warning for Pyroblast (to interrupt)"
})

L:SetMiscLocalization({
	KaelP2	= "I'll turn your world... upside... down."
})

