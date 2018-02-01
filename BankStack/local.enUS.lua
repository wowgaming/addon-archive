-- BankStack Locale
-- Please use the Localization App on WoWAce to Update this
-- http://www.wowace.com/projects/bank-stack/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("BankStack", "enUS", true)
if not L then return end

-- Messages:
L['already_running'] = "BankStack: A stacker is already running."
L['at_bank'] = "BankStack: You must be at the bank."
L['complete'] = "BankStack: Complete."
L['confused'] = "BankStack: Confusion. Stopping."
L['moving'] = "BankStack: Moving %s."
L['opt_set'] = "BankStack: %s set to %s."
L['options'] = "BankStack options:"
L['perfect'] = "BankStack: Perfection already exists."
L['to_move'] = "BankStack: %d moves to make."

-- Item types and subtypes:
L['ARMOR'] = "Armor"
L['BAG'] = "Bag"
L['CONSUMABLE'] = "Consumable"
L['CONTAINER'] = "Container"
L['GEM'] = "Gem"
L['KEY'] = "Key"
L['MISC'] = "Miscellaneous"
L['PROJECTILE'] = "Projectile"
L['REAGENT'] = "Reagent"
L['RECIPE'] = "Recipe"
L['QUEST'] = "Quest"
L['QUIVER'] = "Quiver"
L['TRADEGOODS'] = "Trade Goods"
L['WEAPON'] = "Weapon"

--Bindings:
L['BINDING_HEADER_BANKSTACK_HEAD'] = "BankStack"
L['BINDING_NAME_BANKSTACK'] = "Stack to bank"
L['BINDING_NAME_COMPRESS'] = "Compress bags"
L['BINDING_NAME_BAGSORT'] = "Sorts bags"
