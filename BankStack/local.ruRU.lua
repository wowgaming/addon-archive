-- BankStack Locale
-- Please use the Localization App on WoWAce to Update this
-- http://www.wowace.com/projects/bank-stack/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("BankStack", "ruRU")
if not L then return end

-- Messages:
L['already_running'] = "BankStack: A stacker is already running."
L['at_bank'] = "BankStack: вы должны быть в банке."
L['complete'] = "BankStack: завершено."
L['confused'] = "BankStack: Confusion. Stopping."
L['moving'] = "BankStack: перемещение %s."
L['opt_set'] = "BankStack: %s установлено в %s."
L['options'] = "BankStack опции:"
L['perfect'] = "BankStack: Perfection already exists."
L['to_move'] = "BankStack: %d moves to make."

-- Item types and subtypes:
L['ARMOR'] = "Доспехи"
L['BAG'] = "Сумка"
L['CONSUMABLE'] = "Потребляемые"
L['CONTAINER'] = "Сумки"
L['GEM'] = "Самоцветы"
L['KEY'] = "Ключ"
L['MISC'] = "Разное"
L['PROJECTILE'] = "Боеприпасы"
L['REAGENT'] = "Реагент"
L['RECIPE'] = "Рецепты"
L['QUEST'] = "Задания"
L['QUIVER'] = "Амуниция"
L['TRADEGOODS'] = "Ремесла"
L['WEAPON'] = "Оружие"

--Bindings:
L['BINDING_HEADER_BANKSTACK_HEAD'] = "BankStack"
L['BINDING_NAME_BANKSTACK'] = "Stack to bank"
L['BINDING_NAME_COMPRESS'] = "Сжать сумки"
L['BINDING_NAME_BAGSORT'] = "Отсортировать сумки"
