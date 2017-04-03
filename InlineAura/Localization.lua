--[[
Copyright (C) 2009 Adirelle

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
--]]

local _, ns = ...

local locale = GetLocale()
local L = setmetatable({}, {__index = function(self, key)
	local value = tostring(key)
	if key ~= nil then self[key] = value end
	--[===[@debug@
	InlineAura.dprint("Missing locale:", value)
	--@end-debug@]===]
	return value
end})
ns.L = L

--------------------------------------------------------------------------------
-- default: enUS
--------------------------------------------------------------------------------

L['Add spell'] = true
L['Application count position'] = true
L['Application text color'] = true
L['Auras to look up'] = true
L['Aura type'] = true
L['Border highlight colors'] = true
L['Bottom left'] = true
L['Bottom right'] = true
L['Bottom'] = true
L['Buff'] = true
L['Center'] = true
L['Check to have a more accurate countdown display instead of default Blizzard rounding.'] = true
L['Check to hide the aura application count (charges or stacks).'] = true
L['Check to hide the aura countdown.'] = true
L['Check to hide the aura duration countdown.'] = true
L['Check to ignore buffs cast by other characters.'] = true
L['Check to ignore debuffs cast by other characters.'] = true
L['Check to only show aura you applied. Uncheck to always show aura, even when applied by others. Leave grayed to use default settings.'] = true
L['Check to totally disable this spell. No border highlight nor text is displayed for disabled spells.'] = true
L['Check which units you want to be scanned for the aura. Auras of the first existing unit are shown, using this order: focus, target, pet and then player.'] = true
L['Click to create specific settings for the spell.'] = true
L['Countdown position'] = true
L['Countdown text color'] = true
L['Debuff'] = true
L['Decimal countdown threshold'] = true
L["%dh"] = true
L['Disable'] = true
L["%dm"] = true
L['Do you really want to remove these aura specific settings ?'] = true
L['Either OmniCC or CooldownCount is loaded so aura countdowns are displayed using small font at the bottom of action buttons.'] = true
L['Enter additional aura names to check. This allows to check for alternative or equivalent auras. Some spells also apply auras that do not have the same name as the spell.'] = true
L['Enter one aura name per line. They are spell-checked ; errors will prevents you to validate.'] = true
L['Enter the name of the spell for which you want to add specific settings. Non-existent spell or item names are rejected.'] = true
L['Font name'] = true
L['Friendly focus'] = true
L['Friendly target'] = true
L['Hostile focus'] = true
L['Hostile target'] = true
L['Inline Aura'] = true
L['Left'] = true
L['My buffs'] = true
L["My debuffs"] = true
L['New spell name'] = true
L['No application count'] = true
L['No countdown'] = true
L['Only my buffs'] = true
L['Only my debuffs'] = true
L['Only show mine'] = true
L["Others' buffs"] = true
L["Others' debuffs"] = true
L['Pet'] = true
L['Player'] = true
L['Precise countdown'] = true
L['Profiles'] = true
L['Remove spell specific settings.'] = true
L['Remove spell'] = true
L['Restore default settings of the selected spell.'] = true
L['Restore defaults'] = true
L['Right'] = true
L['Select the aura type of this spell. This helps to look up the aura.'] = true
L['Select the colors used to highlight the action button. There are selected based on aura type and caster.'] = true
L['Select the color to use for the buffs cast by other characters.'] = true
L['Select the color to use for the buffs you cast.'] = true
L['Select the color to use for the debuffs cast by other characters.'] = true
L['Select the color to use for the debuffs you cast.'] = true
L['Select the font to be used to display both countdown and application count.'] = true
L['Select the remaining time threshold under which tenths of second are displayed.'] = true
L['Select the spell to edit or to remove its specific settings. Spells with specific defaults are written in |cff77ffffcyan|r. Removed spells with specific defaults are written in |cff777777gray|r.'] = true
L['Select where to display countdown and application count in the button. When only one value is displayed, the "single value position" is used instead of the regular one.'] = true
L['Select where to place a single value.'] = true
L['Select where to place the application count text when both values are shown.'] = true
L['Select where to place the countdown text when both values are shown.'] = true
L['Single value position'] = true
L['Size of large text'] = true
L['Size of small text'] = true
L['Spell specific settings'] = true
L['Spell to edit'] = true
L['Text appearance'] = true
L['Text Position'] = true
L['The large font is used to display countdowns.'] = true
L['The small font is used to display application count (and countdown when cooldown addons are loaded).'] = true
L['Top left'] = true
L['Top right'] = true
L['Top'] = true
L['Units to scan'] = true
L["Unknown spell: %s"] = true

-- Replace true values by the key
for k,v in pairs(L) do if v == true then L[k] = k end end

--------------------------------------------------------------------------------
-- Locales from localization system
--------------------------------------------------------------------------------

-- %Localization: inline-aura
-- AUTOMATICALLY GENERATED BY UpdateLocalization.lua
-- ANY CHANGE BELOW THIS LINE WILL BE LOST ON NEXT UPDATE
-- CHANGES SHOULD BE MADE USING http://www.wowace.com/addons/inline-aura/localization/

local locale = GetLocale()
if locale == "frFR" then
L["Add spell"] = "Ajouter le sort"
L["Application count position"] = "Position du nombre de charges"
L["Application text color"] = "Couleur du nombre d'applications"
L["Auras to look up"] = "Aura à rechercher"
L["Aura type"] = "Type d'aura"
L["Border highlight colors"] = "Couleurs des bords"
L["Bottom"] = "Bas"
L["Bottom left"] = "En bas à gauche"
L["Bottom right"] = "En bas à droite"
L["Buff"] = "Buff"
L["Center"] = "Centré"
L["Check to have a more accurate countdown display instead of default Blizzard rounding."] = "Cochez pour avoir un compte à rebours plus précis plutôt que l'arrondi de Blizzard."
L["Check to hide the aura application count (charges or stacks)."] = "Cochez pour cacher l'affichage du nombre de charges ou d'applications."
L["Check to hide the aura countdown."] = "Cochez pour cacher le compte à rebours."
L["Check to hide the aura duration countdown."] = "Cochez pour cacher le compte-rebours de l'aura."
L["Check to ignore buffs cast by other characters."] = "Cochez pour ignorer les buffs lancés par les autres personnages."
L["Check to ignore debuffs cast by other characters."] = "Cochez pour ignorer les debuffs lancés par les autres personnages."
L["Check to only show aura you applied. Uncheck to always show aura, even when applied by others. Leave grayed to use default settings."] = "Cochez pour n'afficher que les auras que vous appliquez. Décochez pour toujours afficher les auras, même appliquées par d'autres. Laissez grisé pour utiliser le réglage par défaut."
L["Check to totally disable this spell. No border highlight nor text is displayed for disabled spells."] = "Cochez pour désactiver totalement ce sort. Aucun bord ni texte n'est affiché pour les sorts désactivés."
L["Check which units you want to be scanned for the aura. Auras of the first existing unit are shown, using this order: focus, target, pet and then player."] = "Cochez les unités que vous voulez analyser. Les auras de la première unité trouvée sont affichés, dans cet ordre : focus, cible, familier et enfin joueur."
L["Click to create specific settings for the spell."] = "Cliquer pour créer des réglages spécifiques pour ce sort."
L["Countdown position"] = "Position du compte à rebours"
L["Countdown text color"] = "Couleur du compte à rebours"
L["Debuff"] = "Debuff"
L["Decimal countdown threshold"] = "Seuil de compte à rebours décimal"
L["%dh"] = "%dh"
L["Disable"] = "Désactiver"
L["%dm"] = "%dm"
L["Do you really want to remove these aura specific settings ?"] = "Voulez-vous vraiment enlever les réglages spécifiques de ce sort ?"
L["Either OmniCC or CooldownCount is loaded so aura countdowns are displayed using small font at the bottom of action buttons."] = "Soit OmniCC soit CooldownCount est chargé donc les comptes à rebourd sont affichés en petit en bas des boutons d'action."
L["Enter additional aura names to check. This allows to check for alternative or equivalent auras. Some spells also apply auras that do not have the same name as the spell."] = "Entrez des noms d'auras supplémentaires à vérifier. Cela permet de vérifier des auras alternatives ou équivalentes. De plus, certains sorts appliquent une aura qui n'a pas le même nom que le sort."
L["Enter one aura name per line. They are spell-checked ; errors will prevents you to validate."] = "Entrez un nom d'aura par ligne. Leur orthographe est vérifié, toute erreur vous empêchera de valider."
L["Enter the name of the spell for which you want to add specific settings. Non-existent spell or item names are rejected."] = "Entrez le nom du sort pour lequel vous voulez définir des réglages spécifiques. Les noms d'objet ou de sort inexistants sont rejetés."
L["Font name"] = "Nom de la police"
L["Friendly focus"] = "Focus allié"
L["Friendly target"] = "Cible alliée"
L["Hostile focus"] = "Focus ennemi"
L["Hostile target"] = "Cible ennemie"
L["Inline Aura"] = "Inline Aura"
L["Left"] = "A gauche"
L["My buffs"] = "Mes buffs"
L["My debuffs"] = "Mes debuffs"
L["New spell name"] = "Nom du nouveau sort"
L["No application count"] = "Cacher le nombre d'applications"
L["No countdown"] = "Cacher le compte à rebours"
L["Only my buffs"] = "Seulement mes buffs"
L["Only my debuffs"] = "Seulement mes debuffs"
L["Only show mine"] = "Afficher seulement les miens"
L["Others' buffs"] = "Les buffs des autres"
L["Others' debuffs"] = "Les debuffs des autres"
L["Pet"] = "Familier"
L["Player"] = "Joueur"
L["Precise countdown"] = "Compte à rebours précis"
L["Profiles"] = "Profils"
L["Remove spell"] = "Enlever le sort"
L["Remove spell specific settings."] = "Supprime les réglages spécifiques du sort."
L["Restore defaults"] = "Par défaut"
L["Restore default settings of the selected spell."] = "Restaure les réglages par défaut du sort sélectionné."
L["Right"] = "A droite"
L["Select the aura type of this spell. This helps to look up the aura."] = "Sélectionnez le type d'aura du sort. Cela aide à rechercher l'aura."
L["Select the colors used to highlight the action button. There are selected based on aura type and caster."] = "Selectionnez les couleurs utilisées pour mettre les boutons d'actions en surbrillance. Elles sont choisies en fonction du type d'aura et du lanceur."
L["Select the color to use for the buffs cast by other characters."] = "Sélectionnez la couleur à utiliser pour les buffs lancés par d'autres personnages."
L["Select the color to use for the buffs you cast."] = "Sélectionnez la couleur à utiliser pour les buffs lancés par votre personnage."
L["Select the color to use for the debuffs cast by other characters."] = "Sélectionnez la couleur à utiliser pour les debuffs lancés par d'autres personnages."
L["Select the color to use for the debuffs you cast."] = "Sélectionnez la couleur à utiliser pour les debuffs lancés par votre personnage."
L["Select the font to be used to display both countdown and application count."] = "Sélectionnez la police utilisées pour afficher à la fois le compte à rebours et le nombre d'applications."
L["Select the remaining time threshold under which tenths of second are displayed."] = "Indiquez le seuil du temps restant au-dessous duquel les dixièmes de seconde sont affichés."
L["Select the spell to edit or to remove its specific settings. Spells with specific defaults are written in |cff77ffffcyan|r. Removed spells with specific defaults are written in |cff777777gray|r."] = "Sélecitonner le sort à éditer ou supprimer. Les sorts avec des valeurs par défaut sont indiqués en |cff77ffffcyan|r. Les sorts supprimés qui ont des réglages par défaut sont écrit en |cff777777gris|r."
L["Select where to display countdown and application count in the button. When only one value is displayed, the \"single value position\" is used instead of the regular one."] = "Sélectionnez où afficher le compte à rebours et le nombre de charges dans le bouton. Lorsqu'une seule valeur est affichée, le réglage \"position d'une valeur seule\" est utilisé."
L["Select where to place a single value."] = "Sélectionnez la position d'une valeur seule."
L["Select where to place the application count text when both values are shown."] = "Sélectionnezla position du nombre de charges quand les deux valeurs sont visibles."
L["Select where to place the countdown text when both values are shown."] = "Sélectionnez la position du compte à rebours quand les deux valeurs sont visibles."
L["Single value position"] = "Position d'une valeur seule"
L["Size of large text"] = "Taille du grand texte"
L["Size of small text"] = "Taille du petit texte"
L["Spell specific settings"] = "Réglages spécifiques aux sorts"
L["Spell to edit"] = "Sort à éditer"
L["Text appearance"] = "Apparence du texte"
L["Text Position"] = "Position des textes"
L["The large font is used to display countdowns."] = "La grande police est utilisée pour afficher les comptes à rebours."
L["The small font is used to display application count (and countdown when cooldown addons are loaded)."] = "La petite police est utilisée pour afficher le nombre d'applications (et le compte à rebours quand un addon de cooldown est chargé.)"
L["Top"] = "Haut"
L["Top left"] = "En haut à gauche"
L["Top right"] = "En haut à droite"
L["Units to scan"] = "Unité à analyser"
L["Unknown spell: %s"] = "Sort inconnu : %s"
elseif locale == "deDE" then
L["Add spell"] = "Zauber hinzufügen"
L["Click to create specific settings for the spell."] = "Klicken um spezifische Einstellungen für den Zauber vorzunehmen."
L["Countdown text color"] = "Countdown-Textfarbe"
L["%dh"] = "%dh"
L["Disable"] = "Deaktivieren"
L["%dm"] = "%dm"
L["Font name"] = "Schriftname"
L["Inline Aura"] = "Inline Aura"
L["New spell name"] = "Neuer Zaubername"
L["No countdown"] = "Kein Countdown"
L["Only show mine"] = "Nur meine zeigen"
L["Precise countdown"] = "Präziser Countdown"
L["Profiles"] = "Profile"
L["Remove spell"] = "Zauber entfernen"
L["Remove spell specific settings."] = "Zauber-spezifische Einstellungen entfernen."
L["Size of large text"] = "Größe von großem Text"
L["Size of small text"] = "Größe von kleinem Text"
L["Spell specific settings"] = "Zauber-spezifische Einstellungen"
L["Text appearance"] = "Texterscheinung"
L["The large font is used to display countdowns."] = "Die große Schrift wird zur Anzeige des Countdowns verwendet."
L["Unknown spell: %s"] = "Unbekannter Zauber: %s"
elseif locale == "ruRU" then
L["Add spell"] = "Добавить заклинание"
L["Auras to look up"] = "Отслеживаемые ауры"
L["Aura type"] = "Тип ауры"
L["Buff"] = "Бафф"
L["Check to hide the aura application count (charges or stacks)."] = "Скрывать количество стаков/зарядов ауры"
L["Check to ignore buffs cast by other characters."] = "Игнорировать баффы, накладываемые другими игроками."
L["Check to ignore debuffs cast by other characters."] = "Игнорировать дебаффы, накладываемые другими игроками."
L["Check to only show aura you applied. Uncheck to always show aura, even when applied by others. Leave grayed to use default settings."] = "Отметьте, чтобы показывать только ауру, наложеннуу вами. Снимите отметку, чтобы всегда показывать ауру, даже если она была наложена другими игроками."
L["Click to create specific settings for the spell."] = "Кликните, чтобы создать настройки для этого заклинания."
L["Debuff"] = "Дебафф"
L["%dh"] = "%dч"
L["Disable"] = "Отключить"
L["%dm"] = "%dм"
L["Do you really want to remove these aura specific settings ?"] = "Вы действительно хотите удалить настройки этой ауры ?"
L["Font name"] = "Название шрифта"
L["Inline Aura"] = "Inline Aura"
L["My buffs"] = "Мои баффы"
L["My debuffs"] = "Мои дебаффы"
L["New spell name"] = "Название нового заклинания"
L["Only my buffs"] = "Только мои баффы"
L["Only my debuffs"] = "Только мои дебаффы"
L["Only show mine"] = "Отображать только моё"
L["Others' buffs"] = "Баффы других игроков"
L["Others' debuffs"] = "Дебаффы других игроков"
L["Profiles"] = "Профили"
L["Remove spell"] = "Убрать заклинание"
L["Remove spell specific settings."] = "Удалить настройки заклинания."
L["Select the aura type of this spell. This helps to look up the aura."] = "Выбрать тип ауры для этого заклинания."
L["Select the color to use for the buffs cast by other characters."] = "Выбрать цвет, используемый для баффов, накладываемых другими игроками."
L["Select the color to use for the buffs you cast."] = "Выбрать цвет, используемый для баффов, накладываемых вами."
L["Select the color to use for the debuffs cast by other characters."] = "Выбрать цвет, используемый для дебаффов, накладываемых другими игроками."
L["Select the color to use for the debuffs you cast."] = "Выбрать цвет, используемый для дебаффов, накладываемых вами."
L["Size of large text"] = "Размер большого текста"
L["Size of small text"] = "Размер маленького текста"
L["Spell specific settings"] = "Настройки заклинания"
L["Spell to edit"] = "Изменяемое заклинание"
L["Text appearance"] = "Внешний вид текста"
L["Unknown spell: %s"] = "Неизвестное заклинание: %s"
elseif locale == "esES" then
L["Add spell"] = "Añadir hechizo"
L["Aura type"] = "Tipo de aura"
L["Bottom"] = "Abajo"
L["Buff"] = "Buff"
L["Click to create specific settings for the spell."] = "Click para crear ajustes específicos para el hechizo."
L["Debuff"] = "Debuff"
L["%dh"] = "%dh"
L["Disable"] = "Desactivado"
L["%dm"] = "%dm"
L["Do you really want to remove these aura specific settings ?"] = "¿Quieres eliminar realmente los ajustes específicos de éste aura?"
L["Font name"] = "Nombre de la fuente"
L["Friendly focus"] = "Foco Amistoso"
L["Friendly target"] = "Objetivo Amistoso"
L["Hostile focus"] = "Foco Hostil"
L["Hostile target"] = "Objetivo Hostil"
L["My buffs"] = "Mis buffs"
L["My debuffs"] = "Mis debuffs"
L["New spell name"] = "Nuevo nombre de hechizo"
L["Only my buffs"] = "Solo mis buffs"
L["Only my debuffs"] = "Solo mis debuffs"
L["Others' buffs"] = "Otros buffs"
L["Others' debuffs"] = "Otros debuffs"
L["Pet"] = "Mascota"
L["Player"] = "Jugador"
L["Profiles"] = "Perfiles"
L["Remove spell"] = "Eliminar hechizo"
L["Remove spell specific settings."] = "Eliminar ajustes específicos del hechizo."
L["Restore defaults"] = "Restaurar por defecto"
L["Restore default settings of the selected spell."] = "Restaurar ajustes por defecto del hechizo seleccionado."
L["Select the color to use for the buffs cast by other characters."] = "Selecciona el color a usar para buffs casteados por otros personajes."
L["Select the color to use for the buffs you cast."] = "Selecciona el color a usar para buffs casteados por ti."
L["Select the color to use for the debuffs cast by other characters."] = "Selecciona el color a usar para debuffs casteados por otros personajes."
L["Select the color to use for the debuffs you cast."] = "Selecciona el color a usar para debuffs casteados por ti."
L["Spell specific settings"] = "Ajustes específicos de hechizo"
L["Spell to edit"] = "Hechizo a editar"
L["Text appearance"] = "Apariencia del texto"
L["Top"] = "Arriba"
L["Units to scan"] = "Unidades a escanear"
L["Unknown spell: %s"] = "Hechizo desconocido: %s"
elseif locale == "zhTW" then
L["Add spell"] = "增加法術"
L["Application text color"] = "疊加文本顏色"
L["Auras to look up"] = "光環查看"
L["Aura type"] = "光環類型"
L["Border highlight colors"] = "邊境突出色彩"
L["Bottom"] = "底部"
L["Buff"] = "增益法術"
L["Check to have a more accurate countdown display instead of default Blizzard rounding."] = "檢查有一個更準確的倒計時顯示，而不是默認的暴雪四捨五入。"
L["Check to hide the aura application count (charges or stacks)."] = "隱藏光環疊加計數(衝能或堆疊)"
L["Check to hide the aura countdown."] = "隱藏光環倒數計時"
L["Check to hide the aura duration countdown."] = "檢查隱藏的光環時間倒計時。"
L["Check to ignore buffs cast by other characters."] = "忽略其他玩家施放的增益法術"
L["Check to ignore debuffs cast by other characters."] = "忽略其他玩家施放的減益法術"
L["Check to only show aura you applied. Uncheck to always show aura, even when applied by others. Leave grayed to use default settings."] = "檢查只顯示您應用的氣氛。取消選中始終顯示的光環，甚至在其他人使用。給灰色使用默認設置。"
L["Check to totally disable this spell. No border highlight nor text is displayed for disabled spells."] = "檢查完全禁用此法術。沒有邊框突出顯示的文本，也為殘疾法術。"
L["Click to create specific settings for the spell."] = "按一下以建立特定設置的咒語。"
L["Countdown text color"] = "倒計時文字顏色"
L["Debuff"] = "減益法術"
L["%dh"] = "%d小時"
L["Disable"] = "停用"
L["%dm"] = "%d分"
L["Do you really want to remove these aura specific settings ?"] = "你確定要刪除這些光環的特殊設置?"
L["Enter additional aura names to check. This allows to check for alternative or equivalent auras. Some spells also apply auras that do not have the same name as the spell."] = "輸入其他光環名稱來檢查。這使得檢查替代或同等學歷光環。也適用於一些魔法光環不具有相同的名稱的拼寫。"
L["Enter one aura name per line. They are spell-checked ; errors will prevents you to validate."] = "輸入一個名稱，每行的光環。他們是拼寫檢查;錯誤將阻止您驗證。"
L["Enter the name of the spell for which you want to add specific settings. Non-existent spell or item names are rejected."] = "輸入的名稱拼寫您要添加特定的設置。不存在的法術或項目名稱被拒絕。"
L["Font name"] = "字型"
L["Inline Aura"] = "內聯光環"
L["My buffs"] = "我的增益法術"
L["My debuffs"] = "我的減益法術"
L["New spell name"] = "新法術名稱"
L["No application count"] = "無疊加計數"
L["No countdown"] = "無倒數計秒"
L["Only my buffs"] = "僅我的增益法術"
L["Only my debuffs"] = "僅我的減益法術"
L["Only show mine"] = "僅顯示自己的"
L["Others' buffs"] = "別人的增益法術"
L["Others' debuffs"] = "別人的減益法術"
L["Pet"] = "寵物"
L["Player"] = "玩家"
L["Precise countdown"] = "精確倒數計時"
L["Profiles"] = "配置文件"
L["Remove spell"] = "移除法術"
L["Restore defaults"] = "恢復默認"
L["Restore default settings of the selected spell."] = "恢復默認設置選定的咒語。"
L["Select the colors used to highlight the action button. There are selected based on aura type and caster."] = "選擇顏色用於強調動作按鈕。有選擇的基礎上的光環類型和連鑄機。"
L["Select the color to use for the buffs cast by other characters."] = "選擇其他玩家施放的增益法術顏色"
L["Select the color to use for the buffs you cast."] = "選擇你施放的增益法術顏色"
L["Select the color to use for the debuffs cast by other characters."] = "選擇顏色用於debuffs投其他字符。"
L["Select the color to use for the debuffs you cast."] = "選擇顏色用於debuffs你們投。"
L["Select the font to be used to display both countdown and application count."] = "選擇用來顯示倒數計時&疊加計數的字體"
L["Select the spell to edit or to remove its specific settings. Spells with specific defaults are written in |cff77ffffcyan|r. Removed spells with specific defaults are written in |cff777777gray|r."] = "選擇拼寫編輯或刪除其特定的設置。法術具體違約是用青色。刪除與特定的法術默認是用灰色"
L["Size of large text"] = "大文本尺寸"
L["Size of small text"] = "小文本尺寸"
L["Spell specific settings"] = "特定法術設置"
L["Spell to edit"] = "法術編輯"
L["Text appearance"] = "文本外觀"
L["Top"] = "頂部"
L["Units to scan"] = "單位掃描"
L["Unknown spell: %s"] = "未知法術: %s"
elseif locale == "zhCN" then
L["Add spell"] = "添加法术"
L["Application text color"] = "叠加文本颜色"
L["Auras to look up"] = "光环查看"
L["Aura type"] = "光环类型"
L["Border highlight colors"] = "边框高亮颜色"
L["Bottom"] = "底部"
L["Buff"] = "增益法术"
L["Check to have a more accurate countdown display instead of default Blizzard rounding."] = "用更准确的倒计时显示来替代暴雪默认的四舍五入"
L["Check to hide the aura application count (charges or stacks)."] = "隐藏光环叠加计数(充能或堆叠)"
L["Check to hide the aura countdown."] = "隐藏光环倒计时"
L["Check to ignore buffs cast by other characters."] = "忽略其他玩家施放的增益法术"
L["Check to ignore debuffs cast by other characters."] = "忽略其他玩家施放的减益法术"
L["Check to only show aura you applied. Uncheck to always show aura, even when applied by others. Leave grayed to use default settings."] = "选中仅显示应用于你的光圈.未选中始终显示光圈,即使应用在别人.留灰为使用默认设置"
L["Check to totally disable this spell. No border highlight nor text is displayed for disabled spells."] = "此法术完全禁用.没有边框高亮和文本显示"
L["Click to create specific settings for the spell."] = "点击创建法术特殊设置"
L["Countdown text color"] = "倒计时文本颜色"
L["Debuff"] = "减益法术"
L["%dh"] = "%dh"
L["Disable"] = "禁用"
L["%dm"] = "%dm"
L["Do you really want to remove these aura specific settings ?"] = "您确定要删除这些光环的特殊设置?"
L["Either OmniCC or CooldownCount is loaded so aura countdowns are displayed using small font at the bottom of action buttons."] = "加载OmniCC或CooldownCount时,光圈倒计时用小字体显示在动作条按钮底部"
L["Enter additional aura names to check. This allows to check for alternative or equivalent auras. Some spells also apply auras that do not have the same name as the spell."] = "键入其他的光圈名称,允许检查替代或等同的光圈.使一些法术可以应用光圈在名称不同的法术上"
L["Font name"] = "字体"
L["Friendly focus"] = "友方焦点"
L["Friendly target"] = "友方目标"
L["Hostile focus"] = "敌对焦点"
L["Hostile target"] = "敌对目标"
L["Inline Aura"] = "Inline Aura"
L["My buffs"] = "我的增益法术"
L["My debuffs"] = "我的减益法术"
L["New spell name"] = "新法术名称"
L["No application count"] = "无叠加计数"
L["No countdown"] = "无倒计时"
L["Only my buffs"] = "仅我的增益法术"
L["Only my debuffs"] = "仅我的减益法术"
L["Only show mine"] = "只显示自己的"
L["Others' buffs"] = "别人的增益法术"
L["Others' debuffs"] = "别人的减益法术"
L["Pet"] = "宠物"
L["Player"] = "玩家"
L["Precise countdown"] = "精确倒计时"
L["Profiles"] = "配置文件"
L["Remove spell"] = "移除法术"
L["Remove spell specific settings."] = "移除法术特殊设置"
L["Restore defaults"] = "恢复默认"
L["Restore default settings of the selected spell."] = "恢复已选择法术的默认设置。"
L["Select the aura type of this spell. This helps to look up the aura."] = "为法术选择光圈类型.有助于光圈查看"
L["Select the colors used to highlight the action button. There are selected based on aura type and caster."] = "选择用来高亮动作条按钮的颜色.这些选择以光环类型和施法者为基础."
L["Select the color to use for the buffs cast by other characters."] = "选择其他玩家施放的增益法术颜色"
L["Select the color to use for the buffs you cast."] = "选择你施放的增益法术颜色"
L["Select the color to use for the debuffs cast by other characters."] = "选择其他玩家施放的减益法术颜色"
L["Select the color to use for the debuffs you cast."] = "选择你施放的减益法术颜色"
L["Select the font to be used to display both countdown and application count."] = "选择用来显示倒计时和叠加计数的字体"
L["Size of large text"] = "大文本尺寸"
L["Size of small text"] = "小文本尺寸"
L["Spell specific settings"] = "特定法术设置"
L["Spell to edit"] = "法术编辑"
L["Text appearance"] = "文本外观"
L["The large font is used to display countdowns."] = "大字体用来显示倒计时"
L["The small font is used to display application count (and countdown when cooldown addons are loaded)."] = "小字体用来显示倒计时(当加载冷却计时插件时)和叠加计数"
L["Top"] = "顶部"
L["Units to scan"] = "要检测的单位"
L["Unknown spell: %s"] = "未知法术: %s"
elseif locale == "koKR" then
L["Add spell"] = "주문 추가"
L["Application text color"] = "문자 색상 적용"
L["Aura type"] = "오오라 형태"
L["Buff"] = "강화효과"
L["Check to have a more accurate countdown display instead of default Blizzard rounding."] = "기본 블리자드 대기시간 대신 더 정확한 재사용 대기시간을 적용합니다."
L["Check to hide the aura application count (charges or stacks)."] = "지속 갯수(중첩이나 사용여부)를 숨깁니다."
L["Check to hide the aura countdown."] = "지속 재사용 대기시간을 숨깁니다."
L["Check to ignore buffs cast by other characters."] = "다른 캐릭터가 시전한 강화효과를 무시합니다."
L["Check to ignore debuffs cast by other characters."] = "다른 캐릭터가 시전한 약화효과를 무시합니다."
L["Countdown text color"] = "재사용 대기시간 문자 색상"
L["Debuff"] = "약화효과"
L["%dh"] = "%dh"
L["Disable"] = "사용 안함"
L["%dm"] = "%dm"
L["Do you really want to remove these aura specific settings ?"] = "정말 당신은 이 오오라 설정을 삭제하시겠습니까?"
L["Font name"] = "글꼴 이름"
L["Inline Aura"] = "Inline Aura"
L["My buffs"] = "나의 강화효과"
L["My debuffs"] = "나의 약화효과"
L["New spell name"] = "새로운 주문 이름"
L["No application count"] = "갯수 적용 안함"
L["No countdown"] = "재사용 대기시간 사용 안함"
L["Only my buffs"] = "나의 강화효과만"
L["Only my debuffs"] = "나의 약화효과만"
L["Only show mine"] = "나의 것만"
L["Others' buffs"] = "다른 플레이어어 강화효과"
L["Others' debuffs"] = "다른 플레이어의 약화효과"
L["Precise countdown"] = "정확한 재사용 대기시간"
L["Profiles"] = "Profiles"
L["Remove spell"] = "주문 제거"
L["Select the colors used to highlight the action button. There are selected based on aura type and caster."] = "액션 버튼을 강조할 색상을 선택합니다. 오오라의 형태와 시전에 따라 선택됩니다."
L["Select the color to use for the buffs cast by other characters."] = "다른 캐릭터가 시전한 강화효과의 사용 색상은 선택합니다."
L["Select the color to use for the buffs you cast."] = "당신이 시전한 강화효과의 사용 색상을 선택합니다."
L["Select the color to use for the debuffs cast by other characters."] = "다른 캐릭터가 시전한 약화효과의 사용 색상은 선택합니다."
L["Select the color to use for the debuffs you cast."] = "당신이 시전한 약화효과의 사용 색상을 선택합니다."
L["Select the font to be used to display both countdown and application count."] = "재사용 대기시간과 갯수 적용에 사용될 폰트를 선택합니다."
L["Size of large text"] = "큰 문자 크기"
L["Size of small text"] = "작은 문자 크기"
L["Spell specific settings"] = "특정 주문 설정"
L["Spell to edit"] = "주문 편집"
L["Text appearance"] = "문자 적용"
L["Unknown spell: %s"] = "알수없는 주문: %s"
end
