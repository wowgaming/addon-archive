-------------------------------------------------------------------------------
-- Title: MSBT Options German Localization
-- Author: Mikord
-- German Translation by: Farook, Archiv
-------------------------------------------------------------------------------

-- Don't do anything if the locale isn't German.
if (GetLocale() ~= "deDE") then return end

-- Local reference for faster access.
local L = MikSBT.translations

-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------


------------------------------
-- Interface messages
------------------------------

L.MSG_CUSTOM_FONTS					= "Benutzerdefinierte Schrift"
L.MSG_INVALID_CUSTOM_FONT_NAME		= "Ungültiger Schriftname"
L.MSG_FONT_NAME_ALREADY_EXISTS		= "Schriftname existiert bereits."
L.MSG_INVALID_CUSTOM_FONT_PATH		= "Schrift Pfad muss zu einer .ttf Datei führen."
L.MSG_CUSTOM_SOUNDS					= "Benutzerdefinierte Sounds"
L.MSG_INVALID_CUSTOM_SOUND_NAME		= "Ung�ltiger Sound-Name."
L.MSG_SOUND_NAME_ALREADY_EXISTS		= "Sound-Name existiert bereits."
L.MSG_NEW_PROFILE					= "Neues Profil"
L.MSG_PROFILE_ALREADY_EXISTS		= "Profil existiert bereits."
L.MSG_INVALID_PROFILE_NAME			= "Ungültiger Profil-Name."
L.MSG_NEW_SCROLL_AREA				= "Neuer Scroll-Bereich"
L.MSG_SCROLL_AREA_ALREADY_EXISTS	= "Name für Scroll-Bereich existiert bereits."
L.MSG_INVALID_SCROLL_AREA_NAME		= "Ungültiger Name für Scroll-Bereich."
L.MSG_ACKNOWLEDGE_TEXT				= "Bist du sicher, dass du diese Aktion durchführen willst?"
L.MSG_NORMAL_PREVIEW_TEXT			= "Normal"
L.MSG_INVALID_SOUND_FILE			= "Sound muss eine .mp3 oder .wav Datei sein."
L.MSG_NEW_TRIGGER					= "Neuer Auslöser"
L.MSG_TRIGGER_CLASSES				= "Klassen Auslöser"
L.MSG_MAIN_EVENTS					= "Haupt Ereignisse"
L.MSG_TRIGGER_EXCEPTIONS			= "Ausl�ser ausschließen"
L.MSG_EVENT_CONDITIONS				= "Ereignis Bedingungen"
L.MSG_DISPLAY_QUALITY				= "Zeige Benachrichtigungen für diese Gegenstand Qualtitäten."
L.MSG_SKILLS						= "Skills"
L.MSG_SKILL_ALREADY_EXISTS			= "Skill Name existiert bereits."
L.MSG_INVALID_SKILL_NAME			= "Ungültiger Skill Name."
L.MSG_HOSTILE						= "Feind"
L.MSG_ANY							= "Jeder"
L.MSG_CONDITION						= "Bedingung"
L.MSG_CONDITIONS					= "Bedingungen"
L.MSG_ITEM_QUALITIES				= "Gegenstands-Qualität"
L.MSG_ITEMS							= "Gegenstände"
L.MSG_ITEM_ALREADY_EXISTS			= "Gegenstandsname exisiert bereits."
L.MSG_INVALID_ITEM_NAME				= "Ungültiger Gegenstandsname."


------------------------------
-- Class Names.
------------------------------

local obj = L.CLASS_NAMES
obj["DEATHKNIGHT"]	= "Todesritter"
obj["DRUID"]		= "Druide"
obj["HUNTER"]		= "Jäger"
obj["MAGE"]			= "Magier"
obj["PALADIN"]		= "Paladin"
obj["PRIEST"]		= "Priester"
obj["ROGUE"]		= "Schurke"
obj["SHAMAN"]		= "Schamane"
obj["WARLOCK"]		= "Hexenmeister"
obj["WARRIOR"]		= "Krieger"


------------------------------
-- Interface tabs
------------------------------

obj = L.TABS
obj["customMedia"]	= { label="Benutzerdefinierte Media", tooltip="Optionen zum Einstellen für benutzerdefinierte Media anzeigen."}
obj["general"]		= { label="Allgemein", tooltip="Allgemeine Optionen anzeigen."}
obj["scrollAreas"]	= { label="Scroll-Bereiche", tooltip="Optionen für das Erstellen, Löschen, und Konfigurieren der Scroll-Bereiche anzeigen.\n\nMit der Maus über die Icons fahren für mehr Informationen."}
obj["events"]		= { label="Ereignisse", tooltip="Optionen für eingehende, ausgehende und benachrichtigende Ereignisse anzeigen.\n\nMit der Maus über die Icons fahren für mehr Informationen."}
obj["triggers"]		= { label="Auslöser", tooltip="Optionen für das Auslöser-System anzeigen.\n\nMit der Maus über die Icons fahren für mehr Informationen."}
obj["spamControl"]	= { label="Spam-Kontrolle", tooltip="Optionen für die Spam-Kontrolle anzeigen."}
obj["cooldowns"]	= { label="Abklingzeiten", tooltip="Optionen für Abklingzeiten anzeigen."}
obj["lootAlerts"]	= { label="Loot-Benachrichtigungen", tooltip="Optionen für Loot-Benachrichtigungen anzeigen."}
obj["skillIcons"]	= { label="Skill Icons", tooltip="Optionen für Skill Icons anzeigen."}


------------------------------
-- Interface checkboxes
------------------------------

obj = L.CHECKBOXES
obj["enableMSBT"]				= { label="Mik's Scrolling Battle Text aktivieren", tooltip="MSBT aktivieren."}
obj["stickyCrits"]				= { label="Sticky-Krits", tooltip="Bei kritischen Treffern den Sticky Style verwenden."}
obj["enableSounds"]				= { label="Sounds aktivieren", tooltip="Sounds abspielen, die zu den Ereignissen und Auslösern zugewiesen sind."}
obj["textShadowing"]			= { label="Text Schatten", tooltip="Fügt ein Schatten Effekt zu der Schrift hinzu um sie besser Aussehen zu lassen."}
obj["colorPartialEffects"]		= { label="Partielle Effekte einfärben", tooltip="Fügt festgelegte Farben zu den Partiellen Effekten hinzu."}
obj["crushing"]					= { label="Zerschmetternde Stöße", tooltip="Zeigt zerschmetternde Stöße an."}
obj["glancing"]					= { label="Streif-Treffer", tooltip="Zeigt Streif-Treffer an."}
obj["absorb"]					= { label="Partiell - Absorbieren", tooltip="Zeigt die zum Teil absobierte Menge an."}
obj["block"]					= { label="Partiell - Blocken", tooltip="Zeigt die zum Teil geblockte Menge an."}
obj["resist"]					= { label="Partiell - Widerstehen", tooltip="Zeigt die zum Teil widerstandene Menge an."}
obj["vulnerability"]			= { label="Verwundbarkeit Bonis", tooltip="Zeigt die Menge des Verwundbarkeits Bonis an."}
obj["overheal"]					= { label="Überheilung", tooltip="Zeigt die Menge der Überheilung an."}
obj["overkill"]					= { label="Overkills", tooltip="Zeigt die Menge der Overkills an."}
obj["colorDamageAmounts"]		= { label="Farbiger Schaden", tooltip="Fügt zu den Schadensbeträgen die festgelegten Farben hinzu."}
obj["colorDamageEntry"]			= { tooltip="Aktiviert Farbe für diese Schadensart."}
obj["colorUnitNames"]			= { label="Farbige Klassen Namen", tooltip="Fügt festgelegte Klassen Farben zu den Einheit Namen."}
obj["colorClassEntry"]			= { tooltip="Aktiviert Farbe für diese Klasse."}
obj["enableScrollArea"]			= { tooltip="Scroll-Bereich aktivieren."}
obj["inheritField"]				= { label="Übernehmen", tooltip="Übernehmen der eingegebenen Werte.  Markierung aufheben zum Überschreiben."}
obj["hideSkillIcons"]			= { label="Icons verstecken", tooltip="Keine Icons in diesem Scroll-Bereich anzeigen."}
obj["stickyEvent"]				= { label="Sticky-Style verwenden", tooltip="Ereignis immer im Sticky-Style anzeigen."}
obj["enableTrigger"]			= { tooltip="Auslöser aktivieren."}
obj["allPowerGains"]			= { label="ALLE Regenerationen", tooltip="Zeigt alle Power Gains einschließlich die, die nicht im Kampflog gemeldet werden.\n\nWARNUNG: Diese Einstellung ist sehr Spammy, ignoriert den Power Schwellwert und drosselt einige Funktionen.\n\nNICHT EMPFOHLEN."}
obj["hyperRegen"]				= { label="Hyper Regen", tooltip="Display power gains during fast regen abilities such as Innervate and Spirit Tap.\n\nNOTIZ: Die Power Gain-Anzeigen werden nicht gedrosselt."}
obj["abbreviateSkills"]			= { label="Skills abkürzen", tooltip="Skill Namen abkürzen (Nur Englisch).\n\nDies kann von jedem Ereignis mit dem %sl Ereignis Code überschrieben werden."}
--obj["mergeSwings"]				= { label="Merge Swings", tooltip="Merge regular melee swings that hit within a short time span."}
obj["hideSkills"]				= { label="Skills verstecken", tooltip="Keine Skill Namen für eingehende und ausgehende Ereignisse anzeigen.\n\nYou will give up some customization capability at the event level if you choose to use this option since it causes the %s event code to be ignored."}
obj["hideNames"]				= { label="Namen verstecken", tooltip="Namen für eingehende und ausgehende Ereignisse nicht anzeigen.\n\nYou will give up some customization capability at the event level if you choose to use this option since it causes the %n event code to be ignored."}
obj["hideFullOverheals"]		= { label="Komplette Überheilungen verstecken", tooltip="Heilungen die eine effektige Heilung von null haben, nicht anzeigen."}
--obj["hideFullHoTOverheals"]		= { label="Hide Full HoT Overheals", tooltip="Don't display heals over time that have an effective heal amount of zero."}
--obj["hideMergeTrailer"]			= { label="Hide Merge Trailer", tooltip="Don't display the trailer that specifies the number of hits and crits at the end of merged events."}
obj["allClasses"]				= { label="Alle Klassen"}
obj["enableCooldowns"]			= { label="Abklingzeiten aktivieren", tooltip="Zeige Benachrichtigungen wenn Abklingzeiten abgelaufen sind."}
obj["lootedItems"]				= { label="Gelootete Gegenstände", tooltip="Zeige Benachrichtigungen wenn Gegenstände geplündert wurden."}
obj["moneyGains"]				= { label="Gold erhalten", tooltip="Zeige Benachrichtigungen wenn Gold geplündert wurde."}
obj["alwaysShowQuestItems"]		= { label="Quest Gegenstände immer anzeigen", tooltip="Quest Gegenstände IMMER anzeigen, unabhängig der ausgewählten Qualitäten."}
obj["enableIcons"]				= { label="Skill Icons aktivieren", tooltip="Zeigt wenn möglich Icons für Ereignisse mit einem Skill an."}
obj["exclusiveSkills"]			= { label="Nur Skill Namen", tooltip="Zeige nur Skill Namen, solang kein Icon verfügbar ist."}


------------------------------
-- Interface dropdowns
------------------------------

obj = L.DROPDOWNS
obj["profile"]				= { label="Aktuelles Profil:", tooltip="Legt das aktuelle Profil fest."}
obj["normalFont"]			= { label="Schrift - Normal:", tooltip="Legt die Schriftart für Nicht-kritische Treffer."}
obj["critFont"]				= { label="Schrift - Kritisch:", tooltip="Legt die Schriftart für kritische Treffer."}
obj["normalOutline"]		= { label="Kontur - Normal:", tooltip="Legt die Kontur für Nicht-kritische Treffer."}
obj["critOutline"]			= { label="Kontur - Kritisch:", tooltip="Legt die Kontur für kritische Treffer."}
obj["scrollArea"]			= { label="Scroll-Bereich:", tooltip="Wählt den zu konfigurierenden Scroll-Bereich aus."}
obj["sound"]				= { label="Sound:", tooltip="Wählt den Sound zum Abspielen wenn das Ereignis erscheint."}
obj["animationStyle"]		= { label="Animationen:", tooltip="Der Animation Style für Nicht-Sticky Animationen in dem Scrollbereich."}
obj["stickyAnimationStyle"]	= { label="Sticky Animationen:", tooltip="Der Animation Style für Sticky Animationen in dem Scrollbereich."}
obj["direction"]			= { label="Richtung:", tooltip="Die Richtung der Animation."}
obj["behavior"]				= { label="Verhalten:", tooltip="Das Verhalten der Animation."}
obj["textAlign"]			= { label="Text ausrichten:", tooltip="Die Ausrichtung des Textes für die Animation."}
obj["iconAlign"]			= { label="Icon ausrichten:", tooltip="Die Ausrichtung des Icons für die Animation."}
obj["eventCategory"]		= { label="Ereignis-Kategorie:", tooltip="Die Kategorie der zu konfigurienden Ereignisse."}
obj["outputScrollArea"]		= { label="Scroll-Bereich:", tooltip="Den Scroll-Bereich für die Textausgabe auswählen."}
obj["mainEvent"]			= { label="Haupt Ereignis:"}
obj["triggerCondition"]		= { label="Bedingung:", tooltip="Die Bedingung zum Testen."}
obj["triggerRelation"]		= { label="Relation:"}
obj["triggerParameter"]		= { label="Parameter:"}


------------------------------
-- Interface buttons
------------------------------

obj = L.BUTTONS
obj["addCustomFont"]			= { label="Schrift hinzufügen", tooltip="Fügt eine benutzerdefinierte Schrift zu der Liste der verfügbaren Schriften.\n\nWARNUNG: Die Schrift Datei muss in dem Ziel Verzeichnis existieren *BEVOR* WoW gestartet wurde.\n\nEs ist empfohlen die Datei in den MikScrollingBattleText\\Fonts Ordner zu platzieren um Fehler zu vermeiden."}
obj["addCustomSound"]			= { label="Sound hinzufügen", tooltip="Fügt ein benutzerdefinierten Sound zu der Liste der verfügbaren Sounds.\n\nWARNUNG: Die Sound Datei muss in dem Ziel Verzeichnis existieren *BEVOR* WoW gestartet wurde.\n\nEs ist empfohlen die Datei in den MikScrollingBattleText\\Sounds Ordner zu platzieren um Fehler zu vermeiden."}
obj["editCustomFont"]			= { tooltip="Klicken, um benutzerdefinierte Schrift zu bearbeiten."}
obj["deleteCustomFont"]			= { tooltip="Klicken, um benutzerdefinierte Schrift aus MSBT zu entfernen."}
obj["editCustomSound"]			= { tooltip="Klicken, um benutzerdefinierten Sound zu bearbeiten."}
obj["deleteCustomSound"]		= { tooltip="Klicken, um benutzerdefinierten Sound aus MSBT zu entfernen."}
obj["copyProfile"]				= { label="Kopieren", tooltip="Kopiert das aktuelle Profil auf ein neues Profil, dessen Namen du selbst bestimmst."}
obj["resetProfile"]				= { label="Zurücksetzen", tooltip="Setzt das Profil auf die Standardeinstellungen zurück."}
obj["deleteProfile"]			= { label="Löschen", tooltip="Löscht das Profil."}
obj["masterFont"]				= { label="Master Schrift", tooltip="Erlaubt dir die Master Schrift festzulegen, welche bei allen Scroll-Bereichen und Ereignissen übernommen wird, sofern sie nicht überschrieben wird."}
obj["partialEffects"]			= { label="Partielle Effekte", tooltip="Erlaubt dir festzulegen welche partiellen Effekte angezeigt werden sollen, ob sie eingefärbt werden sollen, und wenn ja in welcher Farbe."}
obj["damageColors"]				= { label="Schaden Farben", tooltip="Erlaubt dir festzulegen ob oder auch nicht die Beträge nach der Farbe der Schadensart gefärbt sind und welche Farben für jede Art verwendet werden."}
obj["classColors"]				= { label="Klassen Farben", tooltip="Erlaubt dir festzulegen ob doer auch nicht die Namen nach der Farbe der Klassen gefärbt sind und welche Farben für jede Klasse verwendet werden." }
obj["inputOkay"]				= { label=OKAY, tooltip="Eingaben übernehmen."}
obj["inputCancel"]				= { label=CANCEL, tooltip="Eingaben zurücksetzen."}
obj["genericSave"]				= { label=SAVE, tooltip="Speichert die Änderungen."}
obj["genericCancel"]			= { label=CANCEL, tooltip="Änderungen zurücksetzen."}
obj["addScrollArea"]			= { label="Neuer Scroll-Bereich", tooltip="Einen neuen Scroll-Bereich auswählen, dem Ereignisse und Auslöser zugewiesen werden können."}
obj["configScrollAreas"]		= { label="Scroll-Bereiche konfigurieren", tooltip="Konfiguriert die normalen und Sticky-Styles, Text-Ausrichtung, Scroll Weite/Höhe und Position der Scroll-Bereiche."}
obj["editScrollAreaName"]		= { tooltip="Klicken, um den Namen des Scroll-Bereichs zu bearbeiten."}
obj["scrollAreaFontSettings"]	= { tooltip="Klicken, um die Schrifteinstellungen des Scroll-Bereichs zu bearbeiten, welche von allen Ereignissen dieses Bereichs übernommen werden, sofern sie nicht überschrieben werden."}
obj["deleteScrollArea"]			= { tooltip="Klicken, um den Scroll-Bereich zu löschen."}
obj["scrollAreasPreview"]		= { label="Vorschau", tooltip="Eine Vorschau auf die Änderungen."}
obj["toggleAll"]				= { label="Alle umschalten", tooltip="Die Aktivierung aller Ereignisse in der ausgewählten Kategorie umschalten."}
obj["moveAll"]					= { label="Alle verschieben", tooltip="Verschiebt alle Ereignisse in der ausgewählten Kategorie zu dem ausgewählten Scroll-Bereich."}
obj["eventFontSettings"]		= { tooltip="Klicken, um die Schrifteinstellungen für dieses Ereignis zu bearbeiten."}
obj["eventSettings"]			= { tooltip="Klicken, um die Ereigniseinstellungen wie Scroll-Bereich, Text, Sound, etc. zu bearbeiten."}
obj["customSound"]				= { tooltip="Klicken, um eine benutzerdefinierte Sound Datei auszuwählen." }
obj["playSound"]				= { label="Abspielen", tooltip="Klicken, um den ausgewählten Sound abzuspielen."}
obj["addTrigger"]				= { label="Neuen Auslöser hinzufügen", tooltip="Einen neuen Auslöser hinzufügen."}
obj["triggerSettings"]			= { tooltip="Klicken, um die Auslöser-Einstellungen zu konfigurieren."}
obj["deleteTrigger"]			= { tooltip="Klicken, um diesen Auslöser zu löschen."}
obj["editTriggerClasses"]		= { tooltip="Klicken, um die Klassen wo der Auslöser verwendet wird zu bearbeiten."}
obj["addMainEvent"]				= { label="Ereignis hinzufügen", tooltip="Wenn IRGENDEINER dieser Ereignisse auftritt und deren definierte Bedingungen geschehen, werden die Auslöser ausgeführt, außer es trifft eine festgelegte Ausnahme zu."}
obj["addTriggerException"]		= { label="Ausnahme hinzufügen", tooltip="Wenn IRGENDEINE dieser Ausnahmen auftritt, wird der Auslöser nicht ausgeführt."}
obj["editEventConditions"]		= { tooltip="Klicken, um für dieses Ereignis die Bedingungen zu bearbeiten."}
obj["deleteMainEvent"]			= { tooltip="Klicken, um Ereignis zu entfernen."}
obj["addEventCondition"]		= { label="Bedingung hinzufügen", tooltip="Wenn JEDE dieser Bedingungen zutrifft für das ausgewählte Ereignis, wird der Auslöser ausgeführt, außer es trifft eine festgelegte Ausnahme zu."}
obj["editCondition"]			= { tooltip="Klicken, um Bedingung zu bearbeiten."}
obj["deleteCondition"]			= { tooltip="Klicken, um Bedingung zu entfernen."}
obj["throttleList"]				= { label="Unterdrückungs Liste", tooltip="Benutzerdefinierte Unterdrückungs Zeit für festgelegte Fertigkeiten setzen."}
obj["mergeExclusions"]			= { label="Ausschlüsse zusammenfügen", tooltip="Verhindert, dass festgelegte Fertigkeiten zusammengefügt werden."}
obj["skillSuppressions"]		= { label="Skill Unterdrückungen", tooltip="Unterdrücke Skills durch ihren Namen."}
obj["skillSubstitutions"]		= { label="Skill Ersetzungen", tooltip="Ersetze Skill Namen mit angepassten Werten."}
obj["addSkill"]					= { label="Skill hinzufügen", tooltip="Neuen Skill zur Liste hinzufügen."}
obj["deleteSkill"]				= { tooltip="Klicken, um Skill zu entfernen."}
obj["cooldownExclusions"]		= { label="Cooldown Ausschlüsse", tooltip="Bei festgelegten Fertigkeiten die Cooldown-Verfolgung ignorieren."}
obj["itemsAllowed"]				= { label="Gegenstände erlauben", tooltip="Festgelegte Gegenstände unabhängig der Gegenstandsqualität immer anzeigen."}
obj["itemExclusions"]			= { label="Gegenstände ignorieren", tooltip="Verhindert, dass festgelegte Gegenstände angezeigt werden."}
obj["addItem"]					= { label="Gegenstand hinzufügen", tooltip="Neuen Gegenstand zur Liste hinzufügen."}
obj["deleteItem"]				= { tooltip="Klicken, um Gegenstand zu entfernen."}


------------------------------
-- Interface editboxes
------------------------------

obj = L.EDITBOXES
obj["customFontName"]	= { label="Schriftname:", tooltip="Der Name wird benutzt um die Schrift zu identifizieren.\n\nBeispiel: Meine Super Schrift"}
obj["customFontPath"]	= { label="Schrift Pfad:", tooltip="Der Pfad zu der Schrift Datei.\n\nNOTIZ: Wenn die Datei in dem empfohlenen MikScrollingBattleText\\Fonts Ordner ist, muss nur der Dateiname hier eingegeben werden anstatt der ganze Pfad.\n\nBeispiel: meineSchrift.ttf "}
obj["customSoundName"]	= { label="Sound Name:", tooltip="Der Name wird benutzt um den Sound zu identifizieren.\n\nBeispiel: Mein Sound"}
obj["customSoundPath"]	= { label="Sound Pfad:", tooltip="Der Pfad zu der Sound Datei.\n\nNOTIZ: Wenn die Datei in dem empfohlenen MikScrollingBattleText\\Sounds Ordner ist, muss nur der Dateiname hier eingegeben werden anstatt der ganze Pfad.\n\nBeispiel: mySound.mp3 "}
obj["copyProfile"]		= { label="Neuer Profilname:", tooltip="Der Name des neuen Profils auf den das eben gewählte Profil kopiert werden soll."}
obj["partialEffect"]	= { tooltip="Der Trailer, der angehängt wird wenn der Partielle Effekte erscheint."}
obj["scrollAreaName"]	= { label="Neuen Scroll-Bereich-Name eingeben:", tooltip="Neuer Name für den Scroll-Bereich."}
obj["xOffset"]			= { label="X-Achse:", tooltip="Die X-Achse des ausgewählten Scroll-Bereichs."}
obj["yOffset"]			= { label="Y-Achse:", tooltip="Die Y-Achse des ausgewählten Scroll-Bereichs."}
obj["eventMessage"]		= { label="Ausgabenachricht eingeben:", tooltip="Die Nachricht die angezeigt wird, wenn das Ereignis vorkommt."}
obj["soundFile"]		= { label="Sound Dateiname:", tooltip="Der Name der Sound Datei zum Abspielen wenn das Ereignis erscheint."}
obj["iconSkill"]		= { label="Icon Skill:", tooltip="Der Name oder spell ID des Zaubers mit dem Icon das angezeigt wird wenn das Ereignis erscheint.\n\nMSBT wird versuchen automatisch ein Icon auszuwählen wenn keins festgelegt ist.\n\nNOTIZ: Eine Zauber ID muss statt einem Namen benutzt werden wenn der Skill nicht im Zauberbuch für die Klasse die gespielt wird während das Ereignis erscheint.  Die meisten online Datenbanken wie wowhead können zum Auffinden dafür benutz werden."}
obj["skillName"]		= { label="Skill Name:", tooltip="Name des Skills welches hinzugefügt werden soll."}
obj["substitutionText"]	= { label="Ersetzungs Text:", tooltip="Der Text der Ersetzt werden soll für den Skill Namen."}
obj["itemName"]			= { label="Gegenstandname:", tooltip="Name des Gegenstandes welches hinzugefügt werden soll."}

------------------------------
-- Interface sliders
------------------------------

obj = L.SLIDERS
obj["animationSpeed"]		= { label="Animationsgeschwindigkeit", tooltip="Die Master Geschwindigkeit der Animation."}
obj["normalFontSize"]		= { label="Normale Schriftgröße", tooltip="Die Schriftgröße für Nicht-kritische Treffer."}
obj["normalFontOpacity"]	= { label="Normale Transparenz", tooltip="Die Schrift Transparez für Nicht-kritische Treffer."}
obj["critFontSize"]			= { label="Kritische Schriftgröße", tooltip="Die Schriftgröße für kritische Treffer."}
obj["critFontOpacity"]		= { label="Kritische Transparenz", tooltip="Die Schrift Transparenz für kritische Treffer."}
obj["scrollHeight"]			= { label="Scroll-Höhe", tooltip="Die Höhe des Scroll-Bereichs."}
obj["scrollWidth"]			= { label="Scroll-Weite", tooltip="Die Weite des Scroll-Bereichs."}
obj["scrollAnimationSpeed"]	= { label="Geschwindigkeit", tooltip="Die Geschwindigkeit der Animation des Scroll-Bereichs."}
obj["powerThreshold"]		= { label="Energie Schwelle", tooltip="The threshold that power gains must exceed to be displayed."}
obj["healThreshold"]		= { label="Heilung Schwelle", tooltip="The threshold that heals must exceed to be displayed."}
obj["damageThreshold"]		= { label="Schaden Schwelle", tooltip="The threshold that damage must exceed to be displayed."}
obj["dotThrottleTime"]		= { label="DoT Throttle Time", tooltip="The number of seconds to throttle DoTs."}
obj["hotThrottleTime"]		= { label="HoT Throttle Time", tooltip="The number of seconds to throttle HoTs."}
obj["powerThrottleTime"]	= { label="Energie Throttle Time", tooltip="The number of seconds to throttle power changes."}
obj["skillThrottleTime"]	= { label="Throttle Time", tooltip="The number of seconds to throttle the skill."}
obj["cooldownThreshold"]	= { label="Cooldown Schwelle", tooltip="Skills with a cooldown less than the specified number of seconds will not be displayed."}


------------------------------
-- Event categories
------------------------------
obj = L.EVENT_CATEGORIES
obj[1] = "Eingehend Spieler"
obj[2] = "Eingehend Begleiter"
obj[3] = "Ausgehend Spieler"
obj[4] = "Ausgehend Begleiter"
obj[5] = "Benachrichtigung"


------------------------------
-- Event codes
------------------------------

obj = L.EVENT_CODES
obj["DAMAGE_TAKEN"]			= "%a - Menge des erhaltenen Schadens.\n"
obj["HEALING_TAKEN"]		= "%a - Menge der erhaltenen Heilung.\n"
obj["DAMAGE_DONE"]			= "%a - Menge des Schadens.\n"
obj["HEALING_DONE"]			= "%a - Geheilte Menge.\n"
obj["ABSORBED_AMOUNT"]		= "%a - Menge des absobierten Schadens.\n"
--obj["AURA_AMOUNT"]			= "%a - Amount of stacks for the aura.\n"
obj["ENERGY_AMOUNT"]		= "%a - Menge der Energie.\n"
obj["CP_AMOUNT"]			= "%a - Menge der momentanen Combo Punkten.\n"
obj["HONOR_AMOUNT"]			= "%a - Menge der Ehre.\n"
obj["REP_AMOUNT"]			= "%a - Menge des Rufs.\n"
obj["ITEM_AMOUNT"]			= "%a - Menge des geplünderten Gegenstands.\n"
obj["SKILL_AMOUNT"]			= "%a - Menge der Punkte die du in der Fertigkeit hast.\n"
obj["EXPERIENCE_AMOUNT"]	= "%a - Menge der erhaltenen Erfahrung.\n"
--obj["PARTIAL_AMOUNT"]		= "%a - Amount of the partial effect.\n"
obj["ATTACKER_NAME"]		= "%n - Name des Angreifers.\n"
obj["HEALER_NAME"]			= "%n - Name des Heilers.\n"
obj["ATTACKED_NAME"]		= "%n - Name der angegriffenen Einheit.\n"
obj["HEALED_NAME"]			= "%n - Name der geheilten Einheit.\n"
obj["BUFFED_NAME"]			= "%n - Name der gebufften Einheit.\n"
obj["UNIT_KILLED"]			= "%n - Name der getöteten Einheit.\n"
obj["SKILL_NAME"]			= "%s - Name der Fertigkeit.\n"
obj["SPELL_NAME"]			= "%s - Name des Zaubers.\n"
obj["DEBUFF_NAME"]			= "%s - Name des Debuffs.\n"
obj["BUFF_NAME"]			= "%s - Name des Buffs\n"
obj["ITEM_BUFF_NAME"]		= "%s - Name des Gegenstand Buffs.\n"
obj["EXTRA_ATTACKS"]		= "%s - Name of skill granting the extra attacks.\n"
obj["SKILL_LONG"]			= "%sl - Long form of %s. Used to override abbreviation for the event.\n"
obj["DAMAGE_TYPE_TAKEN"]	= "%t - Art des erhaltenen Schadens.\n"
obj["DAMAGE_TYPE_DONE"]		= "%t - Type of damage done.\n"
obj["ENVIRONMENTAL_DAMAGE"]	= "%e - Name of the source of the damage (falling, drowning, lava, etc...)\n"
obj["FACTION_NAME"]			= "%e - Name der Fraktion.\n"
obj["SHARD_NAME"]			= "%e - Lokalisierter Name des Seelensplitters.\n"
obj["EMOTE_TEXT"]			= "%e - The text of the emote.\n"
obj["MONEY_TEXT"]			= "%e - The money gained text.\n"
obj["COOLDOWN_NAME"]		= "%e - Name der Fertigkeit die Bereit ist.\n"
obj["ITEM_NAME"]			= "%e - Der Name des geplünderten Gegenstands.\n"
obj["POWER_TYPE"]			= "%p - Art der Power (Energie, Wut, Mana).\n"
obj["TOTAL_ITEMS"]			= "%t - Gesamte Anzahl der geplünderten Gegenstände im Inventar."


------------------------------
-- Incoming events
------------------------------

obj = L.INCOMING_PLAYER_EVENTS
obj["INCOMING_DAMAGE"]						= { label="Nahkampf - Treffer", tooltip="Enable incoming melee hits."}
obj["INCOMING_DAMAGE_CRIT"]					= { label="Nahkampf - Kritisch", tooltip="Enable incoming melee crits."}
obj["INCOMING_MISS"]						= { label="Nahkampf - Fehlschlag", tooltip="Enable incoming melee misses."}
obj["INCOMING_DODGE"]						= { label="Nahkampf - Ausweichen", tooltip="Enable incoming melee dodges."}
obj["INCOMING_PARRY"]						= { label="Nahkampf - Parieren", tooltip="Enable incoming melee parries."}
obj["INCOMING_BLOCK"]						= { label="Nahkampf - Blocken", tooltip="Enable incoming melee blocks."}
--obj["INCOMING_DEFLECT"]						= { label="Melee Deflects", tooltip="Enable incoming melee deflects."}
obj["INCOMING_ABSORB"]						= { label="Nahkampf - Absorbieren", tooltip="Enable absorbed incoming melee damage."}
obj["INCOMING_IMMUNE"]						= { label="Nahkampf - Immun", tooltip="Enable incoming melee damage you are immune to."}
obj["INCOMING_SPELL_DAMAGE"]				= { label="Skill - Treffer", tooltip="Enable incoming skill hits."}
obj["INCOMING_SPELL_DAMAGE_CRIT"]			= { label="Skill - Kritisch", tooltip="Enable incoming skill damage."}
obj["INCOMING_SPELL_DOT"]					= { label="Skill - DoTs", tooltip="Enable incoming skill damage over time."}
obj["INCOMING_SPELL_DOT_CRIT"]				= { label="Skill - DoT Kritisch", tooltip="Enable incoming skill damage over time crits."}
obj["INCOMING_SPELL_DAMAGE_SHIELD"]			= { label="Schadensschild - Treffer", tooltip="Enable incoming damage done by damage shields."}
obj["INCOMING_SPELL_DAMAGE_SHIELD_CRIT"]	= { label="Schadensschild - Kritisch", tooltip="Enable incoming crits done by damage shields."}
obj["INCOMING_SPELL_MISS"]					= { label="Skill - Fehlschlag", tooltip="Enable incoming skill misses."}
obj["INCOMING_SPELL_DODGE"]					= { label="Skill - Ausweichen", tooltip="Enable incoming skill dodges."}
obj["INCOMING_SPELL_PARRY"]					= { label="Skill - Parieren", tooltip="Enable incoming skill parries."}
obj["INCOMING_SPELL_BLOCK"]					= { label="Skill - Blocken", tooltip="Enable incoming skill blocks."}
--obj["INCOMING_SPELL_DEFLECT"]				= { label="Skill Deflects", tooltip="Enable incoming skill deflects."}
obj["INCOMING_SPELL_RESIST"]				= { label="Zauber widerstanden", tooltip="Enable incoming spell resists."}
obj["INCOMING_SPELL_ABSORB"]				= { label="Zauber absorbieren", tooltip="Enable absorbed damage from incoming skills."}
obj["INCOMING_SPELL_IMMUNE"]				= { label="Skill - Immun", tooltip="Enable incoming skill damage you are immune to."}
obj["INCOMING_SPELL_REFLECT"]				= { label="Skill - Reflektieren", tooltip="Enable incoming skill damage you reflected."}
obj["INCOMING_SPELL_INTERRUPT"]				= { label="Zauber unterbrochen", tooltip="Aktiviert eingehende Zauber unterbrochen."}
obj["INCOMING_HEAL"]						= { label="Heilungen", tooltip="Aktiviert eingehende Heilungen."}
obj["INCOMING_HEAL_CRIT"]					= { label="Kritische Heilungen", tooltip="Aktiviert eingehende kritische Heilungen."}
obj["INCOMING_HOT"]							= { label="Heilungen über Zeit", tooltip="Aktiviert eingehende Heilungen über Zeit."}
--obj["INCOMING_HOT_CRIT"]					= { label="Crit Heals Over Time", tooltip="Enable incoming crit heals over time."}
obj["INCOMING_ENVIRONMENTAL"]				= { label="Umwelt-Schaden", tooltip="Aktiviert Umwelt-Schaden (fallen, ertrinken, Lava, etc...)."}

obj = L.INCOMING_PET_EVENTS
obj["PET_INCOMING_DAMAGE"]						= { label="Nahkampf - Treffer", tooltip="Enable your pet's incoming melee hits."}
obj["PET_INCOMING_DAMAGE_CRIT"]					= { label="Nahkampf - Kritisch", tooltip="Enable your pet's incoming melee crits."}
obj["PET_INCOMING_MISS"]						= { label="Nahkampf - Fehlschlag", tooltip="Enable your pet's incoming melee misses."}
obj["PET_INCOMING_DODGE"]						= { label="Nahkampf - Ausweichen", tooltip="Enable your pet's incoming melee dodges."}
obj["PET_INCOMING_PARRY"]						= { label="Nahkampf - Parieren", tooltip="Enable your pet's incoming melee parries."}
obj["PET_INCOMING_BLOCK"]						= { label="Nahkampf - Blocken", tooltip="Enable your pet's incoming melee blocks."}
--obj["PET_INCOMING_DEFLECT"]						= { label="Melee Deflects", tooltip="Enable your pet's incoming melee deflects."}
obj["PET_INCOMING_ABSORB"]						= { label="Nahkampf - Absorbieren", tooltip="Enable your pet's absorbed incoming melee damage."}
obj["PET_INCOMING_IMMUNE"]						= { label="Nahkampf - Immun", tooltip="Enable melee damage your is pet immune to."}
obj["PET_INCOMING_SPELL_DAMAGE"]				= { label="Skill - Treffer", tooltip="Enable your pet's incoming skill hits."}
obj["PET_INCOMING_SPELL_DAMAGE_CRIT"]			= { label="Skill - Kritisch", tooltip="Enable your pet's incoming skill crits."}
obj["PET_INCOMING_SPELL_DOT"]					= { label="Skill - DoTs", tooltip="Enable your pet's incoming skill damage over time."}
obj["PET_INCOMING_SPELL_DOT_CRIT"]				= { label="Skill - DoT Kritisch", tooltip="Enable your pet's incoming skill damage over time crits."}
obj["PET_INCOMING_SPELL_DAMAGE_SHIELD"]			= { label="Schadensschild - Treffer", tooltip="Enable incoming damage done to your pet by damage shields."}
obj["PET_INCOMING_SPELL_DAMAGE_SHIELD_CRIT"]	= { label="Schadensschild - Kritisch", tooltip="Enable incoming crits done to your pet by damage shields."}
obj["PET_INCOMING_SPELL_MISS"]					= { label="Skill - Fehlschlag", tooltip="Enable your pet's incoming skill misses."}
obj["PET_INCOMING_SPELL_DODGE"]					= { label="Skill - Ausweichen", tooltip="Enable your pet's incoming skill dodges."}
obj["PET_INCOMING_SPELL_PARRY"]					= { label="Skill - Parieren", tooltip="Enable your pet's incoming skill parries."}
obj["PET_INCOMING_SPELL_BLOCK"]					= { label="Skill - Blocken", tooltip="Enable your pet's incoming skill blocks."}
--obj["PET_INCOMING_SPELL_DEFLECT"]				= { label="Skill Deflects", tooltip="Enable your pet's incoming skill deflects."}
obj["PET_INCOMING_SPELL_RESIST"]				= { label="Skill - Widerstehen", tooltip="Enable your pet's incoming spell resists."}
obj["PET_INCOMING_SPELL_ABSORB"]				= { label="Skill - Absorbieren", tooltip="Enable absorbed damage from your pet's incoming skills."}
obj["PET_INCOMING_SPELL_IMMUNE"]				= { label="Skill - Immun", tooltip="Enable incoming skill damage your pet is immune to."}
obj["PET_INCOMING_HEAL"]						= { label="Heilungen", tooltip="Enable your pet's incoming heals."}
obj["PET_INCOMING_HEAL_CRIT"]					= { label="Kritische Heilungen", tooltip="Enable your pet's incoming crit heals."}
obj["PET_INCOMING_HOT"]							= { label="Heilungen über Zeit", tooltip="Enable your pet's incoming heals over time."}
--obj["PET_INCOMING_HOT_CRIT"]					= { label="Crit Heals Over Time", tooltip="Enable your pet's incoming crit heals over time."}


------------------------------
-- Outgoing events
------------------------------

obj = L.OUTGOING_PLAYER_EVENTS
obj["OUTGOING_DAMAGE"]						= { label="Nahkampf - Treffer", tooltip="Enable outgoing melee hits."}
obj["OUTGOING_DAMAGE_CRIT"]					= { label="Nahkampf - Kritisch", tooltip="Enable outgoing melee crits."}
obj["OUTGOING_MISS"]						= { label="Nahkampf - Fehlschlag", tooltip="Enable outgoing melee misses."}
obj["OUTGOING_DODGE"]						= { label="Nahkampf - Ausweichen", tooltip="Enable outgoing melee dodges."}
obj["OUTGOING_PARRY"]						= { label="Nahkampf - Parieren", tooltip="Enable outgoing melee parries."}
obj["OUTGOING_BLOCK"]						= { label="Nahkampf - Blocken", tooltip="Enable outgoing melee blocks."}
--obj["OUTGOING_DEFLECT"]						= { label="Melee Deflects", tooltip="Enable outgoing melee deflects."}
obj["OUTGOING_ABSORB"]						= { label="Nahkampf - Absorbieren", tooltip="Enable absorbed outgoing melee damage."}
obj["OUTGOING_IMMUNE"]						= { label="Nahkampf - Immun", tooltip="Enable outgoing melee damage the enemy is immune to."}
obj["OUTGOING_EVADE"]						= { label="Nahkampf - Entkommen", tooltip="Enable outgoing melee evades."}
obj["OUTGOING_SPELL_DAMAGE"]				= { label="Skill - Treffer", tooltip="Enable outgoing skill hits."}
obj["OUTGOING_SPELL_DAMAGE_CRIT"]			= { label="Skill - Kritisch", tooltip="Enable outgoing skill crits."}
obj["OUTGOING_SPELL_DOT"]					= { label="Skill - DoTs", tooltip="Enable outgoing skill damage over time."}
obj["OUTGOING_SPELL_DOT_CRIT"]				= { label="Skill - DoT Kritisch", tooltip="Enable outgoing skill damage over time crits."}
obj["OUTGOING_SPELL_DAMAGE_SHIELD"]			= { label="Schadensschild - Treffer", tooltip="Enable outgoing damage done by damage shields."}
obj["OUTGOING_SPELL_DAMAGE_SHIELD_CRIT"]	= { label="Schadensschild - Kritisch", tooltip="Enable outgoing crits done by damage shields."}
obj["OUTGOING_SPELL_MISS"]					= { label="Skill - Fehlschlag", tooltip="Enable outgoing skill misses."}
obj["OUTGOING_SPELL_DODGE"]					= { label="Skill - Ausweichen", tooltip="Enable outgoing skill dodges."}
obj["OUTGOING_SPELL_PARRY"]					= { label="Skill - Parieren", tooltip="Enable outgoing skill parries."}
obj["OUTGOING_SPELL_BLOCK"]					= { label="Skill - Blocken", tooltip="Enable outgoing skill blocks."}
--obj["OUTGOING_SPELL_DEFLECT"]				= { label="Skill Deflects", tooltip="Enable outgoing skill deflects."}
obj["OUTGOING_SPELL_RESIST"]				= { label="Skill - Widerstehen", tooltip="Enable outgoing spell resists."}
obj["OUTGOING_SPELL_ABSORB"]				= { label="Skill - Absorbieren", tooltip="Enable absorbed damage from outgoing skills."}
obj["OUTGOING_SPELL_IMMUNE"]				= { label="Skill - Immun", tooltip="Enable outgoing skill damage the enemy is immune to."}
obj["OUTGOING_SPELL_REFLECT"]				= { label="Skill - Reflektieren", tooltip="Enable outgoing skill damage reflected back to you."}
obj["OUTGOING_SPELL_INTERRUPT"]				= { label="Skill - Unterbrechen", tooltip="Enable outgoing spell interrupts."}
obj["OUTGOING_SPELL_EVADE"]					= { label="Skill - Entkommen", tooltip="Enable outgoing skill evades."}
obj["OUTGOING_HEAL"]						= { label="Heilungen", tooltip="Enable outgoing heals."}
obj["OUTGOING_HEAL_CRIT"]					= { label="Kritische Heilungen", tooltip="Enable outgoing crit heals."}
obj["OUTGOING_HOT"]							= { label="Heilungen über Zeit", tooltip="Enable outgoing heals over time."}
--obj["OUTGOING_HOT_CRIT"]					= { label="Crit Heals Over Time", tooltip="Enable outgoing crit heals over time."}
obj["OUTGOING_DISPEL"]						= { label="Dispels", tooltip="Enable outgoing dispels."}

obj = L.OUTGOING_PET_EVENTS
obj["PET_OUTGOING_DAMAGE"]						= { label="Nahkampf - Treffer", tooltip="Enable your pet's outgoing melee hits."}
obj["PET_OUTGOING_DAMAGE_CRIT"]					= { label="Nahkampf - Kritisch", tooltip="Enable your pet's outgoing melee crits."}
obj["PET_OUTGOING_MISS"]						= { label="Nahkampf - Fehlschlag", tooltip="Enable your pet's outgoing melee misses."}
obj["PET_OUTGOING_DODGE"]						= { label="Nahkampf - Ausweichen", tooltip="Enable your pet's outgoing melee dodges."}
obj["PET_OUTGOING_PARRY"]						= { label="Nahkampf - Parieren", tooltip="Enable your pet's outgoing melee parries."}
obj["PET_OUTGOING_BLOCK"]						= { label="Nahkampf - Blocken", tooltip="Enable your pet's outgoing melee blocks."}
--obj["PET_OUTGOING_DEFLECT"]						= { label="Melee Deflects", tooltip="Enable your pet's outgoing melee deflects."}
obj["PET_OUTGOING_ABSORB"]						= { label="Nahkampf - Absorbieren", tooltip="Enable your pet's absorbed outgoing melee damage."}
obj["PET_OUTGOING_IMMUNE"]						= { label="Nahkampf - Immun", tooltip="Enable your pet's outgoing melee damage the enemy is immune to."}
obj["PET_OUTGOING_EVADE"]						= { label="Nahkampf - Entkommen", tooltip="Enable your pet's outgoing melee evades."}
obj["PET_OUTGOING_SPELL_DAMAGE"]				= { label="Skill - Treffer", tooltip="Enable your pet's outgoing skill hits."}
obj["PET_OUTGOING_SPELL_DAMAGE_CRIT"]			= { label="Skill - Kritisch", tooltip="Enable your pet's outgoing skill crits."}
obj["PET_OUTGOING_SPELL_DOT"]					= { label="Skill - DoTs", tooltip="Enable outgoing skill damage over time."}
obj["PET_OUTGOING_SPELL_DOT_CRIT"]				= { label="Skill - DoT Kritisch", tooltip="Enable outgoing skill damage over time crits."}
obj["PET_OUTGOING_SPELL_DAMAGE_SHIELD"]			= { label="Schadensschild - Treffer", tooltip="Enable outgoing damage done by your pet's damage shields."}
obj["PET_OUTGOING_SPELL_DAMAGE_SHIELD_CRIT"]	= { label="Schadensschild - Kritisch", tooltip="Enable outgoing crits done by your pet's damage shields."}
obj["PET_OUTGOING_SPELL_MISS"]					= { label="Skill - Fehlschlag", tooltip="Enable your pet's outgoing skill misses."}
obj["PET_OUTGOING_SPELL_DODGE"]					= { label="Skill - Ausweichen", tooltip="Enable your pet's outgoing skill dodges."}
obj["PET_OUTGOING_SPELL_PARRY"]					= { label="Skill - Parieren", tooltip="Enable your pet's outgoing ability parries."}
obj["PET_OUTGOING_SPELL_BLOCK"]					= { label="Skill - Blocken", tooltip="Enable your pet's outgoing skill blocks."}
--obj["PET_OUTGOING_SPELL_DEFLECT"]				= { label="Skill Deflects", tooltip="Enable your pet's outgoing skill deflects."}
obj["PET_OUTGOING_SPELL_RESIST"]				= { label="Skill - Widerstehen", tooltip="Enable your pet's outgoing spell resists."}
obj["PET_OUTGOING_SPELL_ABSORB"]				= { label="Skill - Absorbieren", tooltip="Enable your pet's absorbed damage from outgoing skills."}
obj["PET_OUTGOING_SPELL_IMMUNE"]				= { label="Skill - Immun", tooltip="Enable your pet's outgoing skill damage the enemy is immune to."}
obj["PET_OUTGOING_SPELL_EVADE"]					= { label="Skill - Unterbrechen", tooltip="Enable your pet's outgoing skill evades."}
obj["PET_OUTGOING_DISPEL"]						= { label="Dispels", tooltip="Enable your pet's outgoing dispels."}


------------------------------
-- Notification events
------------------------------

obj = L.NOTIFICATION_EVENTS
obj["NOTIFICATION_DEBUFF"]				= { label="Debuffs", tooltip="Enable debuffs you are afflicted by."}
obj["NOTIFICATION_DEBUFF_STACK"]		= { label="Debuff Stacks", tooltip="Enable debuff stacks you are afflicted by."}
obj["NOTIFICATION_BUFF"]				= { label="Buffs", tooltip="Enable buffs you receive."}
obj["NOTIFICATION_BUFF_STACK"]			= { label="Gegenstand Stacks", tooltip="Enable buff stacks you receive."}
obj["NOTIFICATION_ITEM_BUFF"]			= { label="Gegenstand Buffs", tooltip="Enable buffs your items receive."}
obj["NOTIFICATION_DEBUFF_FADE"]			= { label="Debuff verblasst", tooltip="Enable debuffs that have faded from you."}
obj["NOTIFICATION_BUFF_FADE"]			= { label="Buff verblasst", tooltip="Enable buffs that have faded from you."}
obj["NOTIFICATION_ITEM_BUFF_FADE"]		= { label="Gegenstand Buff verblasst", tooltip="Enable item buffs that have faded from you."}
obj["NOTIFICATION_COMBAT_ENTER"]		= { label="Kampfaustritt", tooltip="Enable when you have entered combat."}
obj["NOTIFICATION_COMBAT_LEAVE"]		= { label="Kampfeintritt", tooltip="Enable when you have left combat."}
obj["NOTIFICATION_POWER_GAIN"]			= { label="Energie erhalten", tooltip="Enable when you gain extra mana, rage, or energy."}
obj["NOTIFICATION_POWER_LOSS"]			= { label="Energie verloren", tooltip="Enable when you lose mana, rage, or energy from drains."}
obj["NOTIFICATION_CP_GAIN"]				= { label="Combo Punkt erhalten", tooltip="Enable when you gain combo points."}
obj["NOTIFICATION_CP_FULL"]				= { label="Alle Combo Punkte", tooltip="Enable when you attain full combo points."}
obj["NOTIFICATION_HONOR_GAIN"]			= { label="Ehre erhalten", tooltip="Enable when you gain honor."}
obj["NOTIFICATION_REP_GAIN"]			= { label="Ruf erhalten", tooltip="Enable when you gain reputation."}
obj["NOTIFICATION_REP_LOSS"]			= { label="Ruf verloren", tooltip="Enable when you lose reputation."}
obj["NOTIFICATION_SKILL_GAIN"]			= { label="Skillpunkt erhalten", tooltip="Enable when you gain skill points."}
obj["NOTIFICATION_EXPERIENCE_GAIN"]		= { label="Erfahrung erhalten", tooltip="Enable when you gain experience points."}
obj["NOTIFICATION_PC_KILLING_BLOW"]		= { label="Spieler Todesstoß", tooltip="Enable when you get a killing blow against a hostile player."}
obj["NOTIFICATION_NPC_KILLING_BLOW"]	= { label="NPC Todesstoß", tooltip="Enable when you get a killing blow against an NPC."}
obj["NOTIFICATION_SOUL_SHARD_CREATED"]	= { label="Seelensplitter erhalten", tooltip="Enable when you gain a soul shard."}
obj["NOTIFICATION_EXTRA_ATTACK"]		= { label="Extra Attacken", tooltip="Enable when you gain extra attacks such as windfury, thrash, sword spec, etc."}
obj["NOTIFICATION_ENEMY_BUFF"]			= { label="Feind Buff erhalten", tooltip="Enable buffs your currently targeted enemy gains."}
obj["NOTIFICATION_MONSTER_EMOTE"]		= { label="Monster Emotes", tooltip="Enable emotes by the currently targeted monster."}


------------------------------
-- Trigger info
------------------------------

-- Main events.
--obj = L.TRIGGER_DATA
--obj["SWING_DAMAGE"]				= "Swing Damage"
--obj["RANGE_DAMAGE"]				= "Range Damage"
--obj["SPELL_DAMAGE"]				= "Skill Damage"
--obj["GENERIC_DAMAGE"]			= "Swing/Range/Skill Damage"
--obj["SPELL_PERIODIC_DAMAGE"]	= "Periodic Skill Damage (DoT)"
--obj["DAMAGE_SHIELD"]			= "Damage Shield Damage"
--obj["DAMAGE_SPLIT"]				= "Split Damage"
--obj["ENVIRONMENTAL_DAMAGE"]		= "Environmental Damage"
--obj["SWING_MISSED"]				= "Swing Miss"
--obj["RANGE_MISSED"]				= "Range Miss"
--obj["SPELL_MISSED"]				= "Skill Miss"
--obj["GENERIC_MISSED"]			= "Swing/Range/Skill Miss"
--obj["SPELL_PERIODIC_MISSED"]	= "Periodic Skill Miss"
--obj["SPELL_DISPEL_FAILED"]		= "Dispel Failed"
--obj["DAMAGE_SHIELD_MISSED"]		= "Damage Shield Miss"
--obj["SPELL_HEAL"]				= "Heal"
--obj["SPELL_PERIODIC_HEAL"]		= "Periodic Heal (HoT)"
--obj["SPELL_ENERGIZE"]			= "Power Gain"
--obj["SPELL_PERIODIC_ENERGIZE"]	= "Periodic Power Gain"
--obj["SPELL_DRAIN"]				= "Power Drain"
--obj["SPELL_PERIODIC_DRAIN"]		= "Periodic Power Drain"
--obj["SPELL_LEECH"]				= "Power Leech"
--obj["SPELL_PERIODIC_LEECH"]		= "Periodic Power Leech"
obj["SPELL_INTERRUPT"]			= "Fertigkeit unterbrochen"
obj["SPELL_AURA_APPLIED"]		= "Aura eingesetzt"
obj["SPELL_AURA_REMOVED"]		= "Aura entfernt"
obj["SPELL_STOLEN"]				= "Aura gestolen"
obj["SPELL_DISPEL"]				= "Aura Dispel"
--obj["SPELL_AURA_REFRESH"]		= "Aura Refresh"
obj["SPELL_AURA_BROKEN_SPELL"]	= "Aura gebrochen"
obj["ENCHANT_APPLIED"]			= "Verzauberung eingesetzt"
obj["ENCHANT_REMOVED"]			= "Verzauberung entfernt"
obj["SPELL_CAST_START"]			= "Wirken gestartet"
obj["SPELL_CAST_SUCCESS"]		= "Wirken erfolgreich"
obj["SPELL_CAST_FAILED"]		= "Wirken fehlgeschlagen"
obj["SPELL_SUMMON"]				= "Beschwören"
obj["SPELL_CREATE"]				= "Erstellen"
obj["PARTY_KILL"]				= "Todesstoß"
obj["UNIT_DIED"]				= "Einheit Tot"
obj["UNIT_DESTROYED"]			= "Einheit zerstört"
obj["SPELL_EXTRA_ATTACKS"]		= "Extra Attacken"
--obj["UNIT_HEALTH"]				= "Health Change"
--obj["UNIT_MANA"]				= "Mana Change"
--obj["UNIT_ENERGY"]				= "Energy Change"
--obj["UNIT_RAGE"]				= "Rage Change"
--obj["UNIT_RUNIC_POWER"]			= "Runic Power Change"
--obj["SKILL_COOLDOWN"]			= "Skill Cooldown Complete"
 
-- Main event conditions.
--obj["sourceName"]				= "Source Unit Name"
--obj["sourceAffiliation"]		= "Source Unit Affiliation"
--obj["sourceReaction"]			= "Source Unit Reaction"
--obj["sourceControl"]			= "Source Unit Control"
--obj["sourceUnitType"]			= "Source Unit Type"
--obj["recipientName"]			= "Recipient Unit Name"
--obj["recipientAffiliation"]		= "Recipient Unit Affiliation"
--obj["recipientReaction"]		= "Recipient Unit Reaction"
--obj["recipientControl"]			= "Recipient Unit Control"
--obj["recipientUnitType"]		= "Recipient Unit Type"
--obj["skillID"]					= "Skill ID"
--obj["skillName"]				= "Skill Name"
--obj["skillSchool"]				= "Skill School"
--obj["extraSkillID"]				= "Extra Skill ID"
--obj["extraSkillName"]			= "Extra Skill Name"
--obj["extraSkillSchool"]			= "Extra Skill School"
obj["amount"]					= "Menge"
obj["overkillAmount"]			= "Overkill Menge"
obj["damageType"]				= "Schadensart"
obj["resistAmount"]				= "Widerstandene Menge"
obj["blockAmount"]				= "Geblockte Menge"
obj["absorbAmount"]				= "Absobierte Menge"
obj["isCrit"]					= "Krit"
obj["isGlancing"]				= "Streif-Treffer"
obj["isCrushing"]				= "Zerschmetternder Stoß"
obj["extraAmount"]				= "Extra Menge"
--obj["missType"]					= "Miss Type"
--obj["hazardType"]				= "Hazard Type"
--obj["powerType"]				= "Power Type"
--obj["auraType"]					= "Aura Type"
obj["threshold"]				= "Schwelle"
obj["unitID"]					= "Einheit ID"
obj["unitReaction"]				= "Einheit Reaktion"

-- Exception conditions.
obj["activeTalents"]			= "Aktive Talente"
obj["buffActive"]				= "Buff Aktiv"
obj["buffInactive"]				= "Buff Inaktiv"
obj["currentCP"]				= "Momentane Combo Punkte"
obj["currentPower"]				= "Momentane Energie"
obj["inCombat"]					= "Im Kampf"
--obj["recentlyFired"]			= "Trigger Recently Fired"
--obj["trivialTarget"]			= "Trivial Target"
obj["unavailableSkill"]			= "Fehlende Fertigkeit"
obj["warriorStance"]			= "Krieger Haltung"
obj["zoneName"]					= "Zonenname"
obj["zoneType"]					= "Zonenart"
 
-- Relationships.
obj["eq"]						= "ist gleich wie"
obj["ne"]						= "ist nicht gleich wie"
obj["like"]						= "ist wie"
obj["unlike"]					= "ist nicht wie"
obj["lt"]						= "ist kleiner als"
obj["gt"]						= "ist größer als"
 
-- Affiliations.
obj["affiliationMine"]			= "Mein"
obj["affiliationParty"]			= "Gruppenmitglied"
obj["affiliationRaid"]			= "Schlachtzugsmitglied"
obj["affiliationOutsider"]		= "Außenstehender"
obj["affiliationTarget"]		= TARGET
obj["affiliationFocus"]			= FOCUS
obj["affiliationYou"]			= YOU

-- Reactions.
obj["reactionFriendly"]			= "Freundlich"
obj["reactionNeutral"]			= "Neutral"
obj["reactionHostile"]			= HOSTILE

-- Control types.
obj["controlServer"]			= "Server"
obj["controlHuman"]				= "Mensch"

-- Unit types.
obj["unitTypePlayer"]			= PLAYER 
obj["unitTypeNPC"]				= "NPC"
obj["unitTypePet"]				= PET
obj["unitTypeGuardian"]			= "Wächter"
obj["unitTypeObject"]			= "Objekt"

-- Aura types.
obj["auraTypeBuff"]				= "Buff"
obj["auraTypeDebuff"]			= "Debuff"

-- Zone types.
obj["zoneTypeArena"]			= "Arena"
obj["zoneTypePvP"]				= BATTLEGROUND
obj["zoneTypeParty"]			= "5-Mann Instanz"
obj["zoneTypeRaid"]				= "Schlachtzug-Instanz"

-- Booleans
obj["booleanTrue"]				= "Richtig"
obj["booleanFalse"]				= "Falsch"


------------------------------
-- Font info
------------------------------

-- Font outlines.
obj = L.OUTLINES
obj[1] = "Kein"
obj[2] = "Dünn"
obj[3] = "Dick"

-- Text aligns.
obj = L.TEXT_ALIGNS
obj[1] = "Links"
obj[2] = "Zentriert"
obj[3] = "Rechts"


------------------------------
-- Sound info
------------------------------

obj = L.SOUNDS
obj["MSBT Low Mana"]	= "MSBT Wenig Mana"
obj["MSBT Low Health"]	= "MSBT Wenig Gesundheit"
obj["MSBT Cooldown"]	= "MSBT Abklingzeit"

------------------------------
-- Animation style info
------------------------------

-- Animation styles
obj = L.ANIMATION_STYLE_DATA
obj["Angled"]		= "Gewinkelt"
obj["Horizontal"]	= "Horizontale"
obj["Parabola"]		= "Parabel"
obj["Straight"]		= "Gerade"
obj["Static"]		= "Statisch"
obj["Pow"]			= "Pow"

-- Animation style directions.
obj["Alternate"]	= "Alternativ"
obj["Left"]			= "Links"
obj["Right"]		= "Rechts"
obj["Up"]			= "Aufwärts"
obj["Down"]			= "Abwärts"

-- Animation style behaviors.
obj["AngleUp"]			= "Winkel aufwärts"
obj["AngleDown"]		= "Winkel abwärts"
obj["GrowUp"]			= "Wachsen aufwärts"
obj["GrowDown"]		= "Wachsen abwärts"
obj["CurvedLeft"]		= "Gerundet Links"
obj["CurvedRight"]		= "Gerundet Rechts"
obj["Jiggle"]			= "Rütteln"
obj["Normal"]			= "Normal"