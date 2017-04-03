if GetLocale() ~= "deDE" then return end

local L

-------------------------
--  Hellfire Ramparts  --
-----------------------------
--  Watchkeeper Gargolmar  --
-----------------------------
L = DBM:GetModLocalization("Gargolmar")

L:SetGeneralLocalization({
	name = "Wachhabender Gargolmar"
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
	name = "Omor der Narbenlose"
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
	name = "Nazan & Vazruden"
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
	name = "Der Schöpfer"
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
	name = "Broggok"
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
	name = "Keli'dan der Zerstörer"
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
	name = "Großhexenmeister Nethekurse"
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
	name = "Blutwache Porung"
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
	name = "Kriegshetzer O'mrogg"
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
	name = "Kriegshäuptling Kargath Messerfaust"
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
	name = "Mennu der Verräter"
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
	name = "Rokmar der Zerquetscher"
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
	name = "Quagmirran"
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
	name = "Hungarfenn"
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
	name = "Ghaz'an"
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
	name = "Sumpffürst Musel'ek"
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
	name = "Die Schattenmutter"
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
	name = "Wasserbeschwörerin Thespia"
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
	name = "Robogenieur Dampfhammer"
})

L:SetWarningLocalization({
	WarnSummon	= "Dampfhammers Mechaniker kommen"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnSummon	= "Zeige Warnung für Dampfhammers Mechaniker"
})

L:SetMiscLocalization({
	Mechs	= "Legt sie tiefer, Jungs!"
})

--------------------------
--  Warlord Kalithresh  --
--------------------------
L = DBM:GetModLocalization("Kalithresh")

L:SetGeneralLocalization({
	name = "Kriegsherr Kalithresh"
})

L:SetWarningLocalization({
	WarnChannel	= "Kalithresh kanalisiert"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnChannel	= "Zeige Warnung wenn Kalithresh kanalisiert"
})

-----------------------
--  Auchenai Crypts  --
--------------------------------
--  Shirrak the Dead Watcher  --
--------------------------------
L = DBM:GetModLocalization("Shirrak")

L:SetGeneralLocalization({
	name = "Shirrak der Totenwächter"
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
	name = "Exarch Maladaar"
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
	name = "Pandemonius"
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
	name = "Tavarok"
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
	name = "Nexusprinz Shaffar"
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
	name = "Yor"
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
	name = "Dunkelwirker Syth"
})

L:SetWarningLocalization({
	SummonElementals	= "Elementare beschworen"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SummonElementals	= "Zeige Warnung für beschworene Elementare"
})

------------
--  Anzu  --
------------
L = DBM:GetModLocalization("Anzu")

L:SetGeneralLocalization({
	name = "Anzu"
})

L:SetWarningLocalization({
	warnBirds	= "Brut des Anzu bald",
	warnStoned	= "%s wird wieder zu Stein"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	warnBirds	= "Zeige Vorwarnung für Brut des Anzu",
	warnStoned	= "Zeige Warnung für Geister die wieder zu Stein werden"
})

L:SetMiscLocalization({
    BirdStone	= "%s wird wieder zu Stein."
})

------------------------
--  Talon King Ikiss  --
------------------------
L = DBM:GetModLocalization("Ikiss")

L:SetGeneralLocalization({
	name = "Klauenkönig Ikiss"
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
	name = "Botschafter Höllenschlund"
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
	name = "Schwarzherz der Hetzer"
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
	name = "Großmeister Vorpil"
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
	name = "Murmur"
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
	name = "Leutnant Drach"
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
	name = "Hauptmann Skarloc"
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
	name = " Epochenjäger"
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
	name = "Chronolord Deja"
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
	name = "Temporus"
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
	name = "Aeonus"
})

L:SetWarningLocalization({
    warnFrenzy	= "Raserei"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
    warnFrenzy	= "Zeige Warnung für Raserei"
})

L:SetMiscLocalization({
    AeonusFrenzy	= "%s gerät in Raserei!"
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "Portaltimer (HdZ)"
})

L:SetWarningLocalization({
    WarnWavePortalSoon	= "Neues Portal bald",
    WarnWavePortal		= "Portal %d",
    WarnBossPortal		= "Boss kommt"
})

L:SetTimerLocalization({
	TimerNextPortal		= "Portal %d",
})

L:SetOptionLocalization({
    WarnWavePortalSoon	= "Zeige Vorwarnung für neues Portal",
    WarnWavePortal		= "Zeige Warnung für neues Portal",
    WarnBossPortal		= "Zeige Warnung für neuen Boss",
	TimerNextPortal		= "Zeige Timer für nächstes Portal (nach einem Boss)",
	ShowAllPortalTimers	= "Zeige Timer für alle Portale (ungenau)"
})

L:SetMiscLocalization({
	PortalCheck			= "Geöffnete Zeitrisse: (%d+)/18",
	Shielddown			= "Nein! Verdammt sei diese schwache, sterbliche Hülle!"
})

--------------------
--  The Mechanar  --
-----------------------------
--  Gatewatcher Gyro-Kill  --
-----------------------------
L = DBM:GetModLocalization("Gyrokill")

L:SetGeneralLocalization({
	name = "Torwächter Gyrotod"
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
	name = "Torwächter Eisenhand"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	JackHammer	= "%s erhebt seinen Hammer bedrohlich..."
})

------------------------------
--  Mechano-Lord Capacitus  --
------------------------------
L = DBM:GetModLocalization("Capacitus")

L:SetGeneralLocalization({
	name = "Mechanolord Kapazitus"
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
	name = "Nethermantin Sepethrea"
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
	name = "Pathaleon der Kalkulator"
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
	name = "Kommandant Sarannis"
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
	name = "Hochbotaniker Freywinn"
})

L:SetWarningLocalization({
	WarnTranq	= "Gelassenheit - Töte Peitschlingbeschützer"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnTranq	= "Zeige Warnung für Gelassenheit"
})

-----------------------------
--  Thorngrin the Tender  --
-----------------------------
L = DBM:GetModLocalization("Thorngrin")

L:SetGeneralLocalization({
	name = "Dorngrin der Hüter"
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
	name = "Laj"
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
	name = "Warpzweig"
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
	name = "Zereketh der Unabhängige"
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
	name = "Dalliah die Verdammnisverkünderin"
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
	name = "Zornseher Soccothrates"
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
	name = "Herold Horizontiss"
})

L:SetWarningLocalization({
	warnSplit		= "Teilung",
	warnSplitSoon	= "Teilung bald"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	warnSplit		= "Zeige Warnung für Teilung",
	warnSplitSoon	= "Zeige Vorwarnung für Teilung"
})

L:SetMiscLocalization({
	Split	= "Das Universum ist unser Zuhause, wir sind zahllos wie die Sterne!"
})

--------------------------
--  Magisters' Terrace  --
--------------------------
--  Selin Fireheart  --
-----------------------
L = DBM:GetModLocalization("Selin")

L:SetGeneralLocalization({
	name = "Selin Feuerherz"
})

L:SetWarningLocalization({
	warnChanneling	= "Teufelskristall Kanalisierung"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	warnChanneling	= "Zeige Warnung für Teufelskristall Kanalisierung"
})

L:SetMiscLocalization({
	ChannelCrystal	= "%s fängt an, die Energie des nahen Teufelskristalls in sich aufzusaugen..."
})

----------------
--  Vexallus  --
----------------
L = DBM:GetModLocalization("Vexallus")

L:SetGeneralLocalization({
	name = "Vexallus"
})

L:SetWarningLocalization({
	WarnEnergy	= "Pure Energie"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnEnergy	= "Zeige Warnung für Pure Energie"
})

L:SetMiscLocalization({
	Discharge	= "Un... kon... trollierbar."
})

--------------------------
--  Priestess Delrissa  --
--------------------------
L = DBM:GetModLocalization("Delrissa")

L:SetGeneralLocalization({
	name = "Priesterin Delrissa"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	DelrissaPull	= "Vernichtet sie.",
	DelrissaEnd		= "Das war so nicht... geplant."
})

------------------------------------
--  Kael'thas Sunstrider (Party)  --
------------------------------------
L = DBM:GetModLocalization("Kael")

L:SetGeneralLocalization({
	name = "Kael'thas Sonnenwanderer (Gruppe)"
})

L:SetWarningLocalization({
	specwarnPyroblast	= "Pyroschlag - Jetzt unterbrechen"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	specwarnPyroblast	= "Zeige Spezialwarnung für Pyroschlag (zum unterbrechen)"
})

L:SetMiscLocalization({
	KaelP2	= "Ich werde Eure Welt... auf den Kopf stellen."
})

