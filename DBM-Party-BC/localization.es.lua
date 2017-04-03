if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------------------
--  Hellfire Ramparts  --
-----------------------------
--  Watchkeeper Gargolmar  --
-----------------------------
L = DBM:GetModLocalization("Gargolmar")

L:SetGeneralLocalization({
	name = "Guardián vigía Gargolmar"
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
	name = "Omor el Sinmarcas"
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
	name = "Nazan y Vazruden"
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
	name = "El Hacedor"
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
	name = "Keli'dan el Ultrajador"
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
	name = "Brujo supremo Malbisal"
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
	name = "Guardia de sangre Porung"
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
	name = "Belisario O'mrogg"
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
	name = "Jefe de Guerra Kargath Garrafilada"
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
	name = "Mennu el Traidor"
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
	name = "Rokmar el Crujidor"
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
	name = "Panthambre"
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
	name = "Señor del pantano Musel'ek"
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
	name = "La Acechadora Negra"
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
	name = "Hidromántica Thespia"
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
	name = "Mekigeniero Vaporino"
})

L:SetWarningLocalization({
	WarnSummon	= "Mecánicos Vaporinos vienen"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnSummon	= "Mostrar aviso para Mecánicos Vaporinos"
})

L:SetMiscLocalization({
	Mechs	= "¡Dadles bien, chicos!"
})

--------------------------
--  Warlord Kalithresh  --
--------------------------
L = DBM:GetModLocalization("Kalithresh")

L:SetGeneralLocalization({
	name = "Señor de la guerra Kalithresh"
})

L:SetWarningLocalization({
	WarnChannel	= "Canalizando"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnChannel	= "Mostrar aviso cuando esté canalizando"
})

-----------------------
--  Auchenai Crypts  --
--------------------------------
--  Shirrak the Dead Watcher  --
--------------------------------
L = DBM:GetModLocalization("Shirrak")

L:SetGeneralLocalization({
	name = "Shirrak el Vigía de los Muertos"
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
	name = "Exarca Maladaar"
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
	name = "Príncipe-nexo Shaffar"
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
	name = "Tejeoscuro Syth"
})

L:SetWarningLocalization({
	SummonElementals	= "Salen Elementales"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SummonElementals	= "Mostrar aviso cuando salgan Elementales"
})

------------
--  Anzu  --
------------
L = DBM:GetModLocalization("Anzu")

L:SetGeneralLocalization({
	name = "Anzu"
})

L:SetWarningLocalization({
	warnBirds	= "Linaje de Anzu pronto",
	warnStoned	= "%s ha vuelto a la piedra"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	warnBirds	= "Mostrar pre-aviso para Linaje de Anzu",
	warnStoned	= "Mostrar aviso para espiritus volviendo a la piedra"
})

L:SetMiscLocalization({
    BirdStone	= "%s se vuelve de piedra."
})

------------------------
--  Talon King Ikiss  --
------------------------
L = DBM:GetModLocalization("Ikiss")

L:SetGeneralLocalization({
	name = "Rey Garra Ikiss"
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
	name = "Embajador Faucinferno"
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
	name = "Negrozón el Incitador"
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
	name = "Maestro mayor Vorpil"
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
	name = "Murmullo"
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
	name = "Teniente Drake"
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
	name = "Capitán Skarloc"
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
	name = "Cazador de Época"
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
	name = "Cronolord Deja"
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
    warnFrenzy	= "Frenesí"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
    warnFrenzy	= "Mostrar aviso para Frenesí"
})

L:SetMiscLocalization({
    AeonusFrenzy	= "%s entra en Frenesí!"
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "Tiempo de portales (CoT)"
})

L:SetWarningLocalization({
    WarnWavePortalSoon	= "Nuevo portal pronto",
    WarnWavePortal		= "Portal %d",
    WarnBossPortal		= "Sale Boss"
})

L:SetTimerLocalization({
	TimerNextPortal		= "Portal %d",
})

L:SetOptionLocalization({
    WarnWavePortalSoon	= "Mostrar pre-aviso para nuevo portal",
    WarnWavePortal		= "Mostrar aviso para nuevo portal",
    WarnBossPortal		= "Mostrar aviso cuando sale Boss",
	TimerNextPortal		= "Mostrar tiempo para siguiente portal (después del Boss)",
	ShowAllPortalTimers	= "Mostrar tiempo para todos los portales (poco acurado)"
})

L:SetMiscLocalization({
	PortalCheck			= "Grietas en el Tiempo abiertas: (%d+)/18",
	Shielddown			= "No! Damn this feeble, mortal coil!" --translate
})

--------------------
--  The Mechanar  --
-----------------------------
--  Gatewatcher Gyro-Kill  --
-----------------------------
L = DBM:GetModLocalization("Gyrokill")

L:SetGeneralLocalization({
	name = "Vigía de las puertas Giromata"
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
	name = "Vigía de las puertas Manoyerro"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	JackHammer	= "%s levanta su martillo amenazador..."
})

------------------------------
--  Mechano-Lord Capacitus  --
------------------------------
L = DBM:GetModLocalization("Capacitus")

L:SetGeneralLocalization({
	name = "Mecano-lord Capacitus"
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
	name = "Abisálica Sepethrea"
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
	name = "Pathaleon el Calculador"
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
	name = "Comandante Sarannis"
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
	name = "Gran botánico Freywinn"
})

L:SetWarningLocalization({
	WarnTranq	= "Tranquilidad -Mata los Protectores de Rasgar"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnTranq	= "Mostrar aviso para Tranquilidad"
})

-----------------------------
--  Thorngrin the Tender  --
-----------------------------
L = DBM:GetModLocalization("Thorngrin")

L:SetGeneralLocalization({
	name = "Thorngrin el Cuidador"
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
	name = "Disidente de distorsión"
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
	name = "Zereketh el Desatado"
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
	name = "Dalliah la Oradora del Sino"
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
	name = "Arúspice de cólera Soccothrates"
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
	name = "Presagista Cieloriss"
})

L:SetWarningLocalization({
	warnSplit		= "Dividir",
	warnSplitSoon	= "Dividir pronto"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	warnSplit		= "Mostrar aviso para División",
	warnSplitSoon	= "Mostrar pre-aviso para División"
})

L:SetMiscLocalization({
	Split	= "We span the universe, as countless as the stars!" --translate
})

--------------------------
--  Magisters' Terrace  --
--------------------------
--  Selin Fireheart  --
-----------------------
L = DBM:GetModLocalization("Selin")

L:SetGeneralLocalization({
	name = "Selin Corazón de Fuego"
})

L:SetWarningLocalization({
	warnChanneling	= "Canalizando Cristal vil"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	warnChanneling	= "Mostrar aviso para Canalizar Cristal vil"
})

L:SetMiscLocalization({
	ChannelCrystal	= "%s comienza a canalizar el cristal vil cercano..."
})

----------------
--  Vexallus  --
----------------
L = DBM:GetModLocalization("Vexallus")

L:SetGeneralLocalization({
	name = "Vexallus"
})

L:SetWarningLocalization({
	WarnEnergy	= "Energía pura"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnEnergy	= "Mostrar aviso para Energía pura"
})

L:SetMiscLocalization({
	Discharge	= "In... contenible."
})

--------------------------
--  Priestess Delrissa  --
--------------------------
L = DBM:GetModLocalization("Delrissa")

L:SetGeneralLocalization({
	name = "Sacerdotisa Delrissa"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	DelrissaPull	= "Aniquiladlos.",
	DelrissaEnd		= "Esto no lo había planeado."
})

------------------------------------
--  Kael'thas Sunstrider (Party)  --
------------------------------------
L = DBM:GetModLocalization("Kael")

L:SetGeneralLocalization({
	name = "Kael'thas Caminante del Sol (Party)"
})

L:SetWarningLocalization({
	specwarnPyroblast	= "¡Piroexplosión! ¡Interrumpe!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	specwarnPyroblast	= "Mostrar aviso especial para Piroexplosión (para interrumpir)"
})

L:SetMiscLocalization({
	KaelP2	= "Pondré vuestro mundo... cabeza... abajo."
})

