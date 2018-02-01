function TopFit:GetPresets()
        local playerClass = select(2,UnitClass("player"))
        local playerRace = select(2,UnitRace("player"))
        
        if not TopFit.presets then -- don't want to create new tables every time this function is called
                local spellCap = math.ceil(26.23 * (17 - (playerRace == "Draenei" and 1 or 0) - ((playerClass == "PRIEST" or playerClass == "DRUID") and 3 or 0)))
                local spellCapMinus3 = math.ceil(26.23 * (14 - (playerRace == "Draenei" and 1 or 0) - ((playerClass == "PRIEST" or playerClass == "DRUID") and 3 or 0)))
                local spellCapMinus6 = math.ceil(26.23 * (11 - (playerRace == "Draenei" and 1 or 0) - ((playerClass == "PRIEST" or playerClass == "DRUID") and 3 or 0)))
                local meleeCap = math.ceil(32.79 * ((TopFit.playerCanDualWield and 27 or 8) - (playerRace == "Draenei" and 1 or 0)))
                local meleeCapMinus3 = math.ceil(32.79 * (((TopFit.playerCanDualWield and playerClass ~= "HUNTER") and 24 or 5) - (playerRace == "Draenei" and 1 or 0)))
                local meleeCapDW = math.ceil(32.79 * 24)
        
                TopFit.presets = {
                        ["DEATHKNIGHT"] = {
                                [1] = {
                                        name = "Blood Tank",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 50,
                                                ["ITEM_MOD_STAMINA_SHORT"] = 10,
                                                ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 9,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 6.9,
                                                ["ITEM_MOD_DODGE_RATING_SHORT"] = 5,
                                                ["ITEM_MOD_PARRY_RATING_SHORT"] = 4.3,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 3.8,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 3.1,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 2.6,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 2.2,
                                                ["RESISTANCE0_NAME"] = 1.8,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 1.6,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 1.6,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 0.8,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCap,
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                                ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = {
                                                        ["value"] = 689,
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [2] = {
                                        name = "Frost Tank",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 41.9,
                                                ["ITEM_MOD_PARRY_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 9.7,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 9.6,
                                                ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 8.5,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 6.9,
                                                ["ITEM_MOD_DODGE_RATING_SHORT"] = 6.1,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 6.1,
                                                ["ITEM_MOD_STAMINA_SHORT"] = 6.1,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 4.9,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 4.1,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 3.1,
                                                ["RESISTANCE0_NAME"] = 0.5,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCapDW,
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                                ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = {
                                                        ["value"] = "689",
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [3] = {
                                        name = "Blood DPS",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 36,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 9.9,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 9.1,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 9,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 5.7,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 5.5,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 3.6,
                                                ["RESISTANCE0_NAME"] = 0.1,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCap,
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [4] = {
                                        name = "Frost DPS",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 33.7,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 9.7,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 8.1,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 6.1,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 4.5,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 3.5,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 2.8,
                                                ["RESISTANCE0_NAME"] = 0.1,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCapDW,
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [5] = {
                                        name = "Unholy DPS",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 20.9,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 6.6,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 10,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 5.1,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 3.2,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 4.5,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 3.4,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 4.8,
                                                ["RESISTANCE0_NAME"] = 0.1,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCap,
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                        },
                        ["DRUID"] = {
                                [1] = {
                                        name = "Feral Tank",
                                        weights = {
                                                ["ITEM_MOD_AGILITY_SHORT"] = 10,
                                                ["ITEM_MOD_STAMINA_SHORT"] = 7.5,
                                                ["ITEM_MOD_DODGE_RATING_SHORT"] = 6.5,
                                                ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 6,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.6,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 1,
                                                ["RESISTANCE0_NAME"] = 1,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 0.8,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.5,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 0.4,
                                                ["ITEM_MOD_FERAL_ATTACK_POWER_SHORT"] = 0.4,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.3,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCap,
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [2] = {
                                        name = "Feral DPS",
                                        weights = {
                                                ["ITEM_MOD_AGILITY_SHORT"] = 10,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 9,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 8,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 5.5,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 5,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 5,
                                                ["ITEM_MOD_FERAL_ATTACK_POWER_SHORT"] = 4,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 4,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 3.5,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCap,
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [3] = {
                                        name = "Balance",
                                        weights = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 6.6,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 5.4,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 4.3,
                                                ["ITEM_MOD_SPIRIT_SHORT"] = 2.2,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 2.2,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = spellCap,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [4] = {
                                        name = "Restoration",
                                        weights = {
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 10,
                                                ["ITEM_MOD_MANA_REGENERATION_SHORT"] = 7.3,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 5.7,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.1,
                                                ["ITEM_MOD_SPIRIT_SHORT"] = 3.2,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 5.1,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {},
                                },
                        },
                        ["HUNTER"] = {
                                [1] = {
                                        name = "Beastmastery",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 21.3,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 5.8,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 4,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 3.7,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 3,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 2.8,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 2.1,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCapMinus3,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [2] = {
                                        name = "Marksmanship",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 37.9,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 7.4,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 5.7,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 4,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 3.9,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 3.2,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 2.4,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCapMinus3,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [3] = {
                                        name = "Survival",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 18.1,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 7.6,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 4.2,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 2.6,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 3.5,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 2.9,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 3.1,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCapMinus3,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                        },
                        ["MAGE"] = {
                                [1] = {
                                        name = "Arcane",
                                        weights = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 4.9,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 5.4,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 3.7,
                                                ["ITEM_MOD_SPIRIT_SHORT"] = 1.4,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 3.4,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = spellCapMinus6,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [2] = {
                                        name = "Fire",
                                        weights = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 4.6,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 5.3,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 4.3,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 1.3,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = spellCapMinus3,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [3] = {
                                        name = "Frost",
                                        weights = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 3.9,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 4.2,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.9,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 0.6,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = spellCapMinus3,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                        },
                        ["PALADIN"] = {
                                [1] = {
                                        name = "Holy",
                                        weights = {
                                                ["ITEM_MOD_MANA_REGENERATION_SHORT"] = 8.8,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 5.8,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 3.5,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 4.6,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 10,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {},
                                },
                                [2] = {
                                        name = "Retribution",
                                        weights = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 0.9,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 47,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 8,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 6.6,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 3,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 4,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 3.4,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 3.2,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 2.2,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCap,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [3] = {
                                        name = "Protection",
                                        weights = {
                                                ["ITEM_MOD_STAMINA_SHORT"] = 10,
                                                ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 4.5,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 1.6,
                                                ["ITEM_MOD_DODGE_RATING_SHORT"] = 5.5,
                                                ["ITEM_MOD_PARRY_RATING_SHORT"] = 3,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 5.9,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 1.6,
                                                ["RESISTANCE0_NAME"] = 0.8,
                                                ["ITEM_MOD_BLOCK_RATING_SHORT"] = 0.7,
                                                ["ITEM_MOD_BLOCK_VALUE_SHORT"] = 0.6,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCap,
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                                ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = {
                                                        ["value"] = 689,
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                        },
                        ["PRIEST"] = {
                                [1] = {
                                        name = "Shadow",
                                        weights = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 7.6,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 5,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 5.4,
                                                ["ITEM_MOD_SPIRIT_SHORT"] = 1.6,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 1.6,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = spellCapMinus3,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [2] = {
                                        name = "Holy",
                                        weights = {
                                                ["ITEM_MOD_MANA_REGENERATION_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 6,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 3.1,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 3.8,
                                                ["ITEM_MOD_SPIRIT_SHORT"] = 5.2,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 6.9,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {},
                                },
                                [3] = {
                                        name = "Discipline",
                                        weights = {
                                                ["ITEM_MOD_MANA_REGENERATION_SHORT"] = 6.7,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 10,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 5.9,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 4.8,
                                                ["ITEM_MOD_SPIRIT_SHORT"] = 2.2,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 6.5,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {},
                                },
                        },
                        ["ROGUE"] = {
                                [1] = {
                                        name = "Assassination",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 17,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 10,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 8.3,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 5.5,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 8.7,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 6.5,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 8.1,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 6.5,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 6.4,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = math.ceil(22*32.79),
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [2] = {
                                        name = "Combat",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 22,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 10,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 8,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 5.5,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 8.2,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 7.5,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 5,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 7.3,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = math.ceil(22*32.79),
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [3] = {
                                        name = "Subtlety",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 22.8,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 10,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 8,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 5.5,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 7.5,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 7.5,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 5,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 7.5,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = math.ceil(22*32.79),
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                        },
                        ["SHAMAN"] = {
                                [1] = {
                                        name = "Enhancement",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 13.5,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 5.5,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 3.5,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 5.5,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 8.4,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 2.6,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 5.5,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 3.2,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 2.9,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 4.2,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCapDW,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [2] = {
                                        name = "Elemental",
                                        weights = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 6,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 5.6,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 4,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 1.1,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = spellCapMinus3,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [3] = {
                                        name = "Restoration",
                                        weights = {
                                                ["ITEM_MOD_MANA_REGENERATION_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 7.7,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 3.5,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 6.2,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 8.5,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {},
                                },
                        },
                        ["WARLOCK"] = {
                                [1] = {
                                        name = "Affliction",
                                        weights = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 7.2,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 6.1,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 3.8,
                                                ["ITEM_MOD_SPIRIT_SHORT"] = 3.4,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 1.5,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
        
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = spellCapMinus3,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [2] = {
                                        name = "Demonology",
                                        weights = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 4.5,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 5,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 3.1,
                                                ["ITEM_MOD_SPIRIT_SHORT"] = 2.9,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 1.3,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = spellCap,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [3] = {
                                        name = "Destruction",
                                        weights = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_SPELL_POWER_SHORT"] = 4.7,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 4.6,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 1.6,
                                                ["ITEM_MOD_SPIRIT_SHORT"] = 2.6,
                                                ["ITEM_MOD_INTELLECT_SHORT"] = 1.3,
                                                ["RESISTANCE0_NAME"] = 0.001,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = spellCap,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                        },
                        ["WARRIOR"] = {
                                [1] = {
                                        name = "Fury",
                                        weights = {
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 13.5,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 5.3,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 4.8,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 8.2,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 10,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 5.2,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 6.6,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 3.1,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 3.6,
                                                ["RESISTANCE0_NAME"] = 0.5,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCapDW,
                                                        ["soft"] = false,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                                [2] = {
                                        name = "Protection",
                                        weights = {
                                                ["ITEM_MOD_STAMINA_SHORT"] = 10,
                                                ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = 8.6,
                                                ["ITEM_MOD_AGILITY_SHORT"] = 6.7,
                                                ["ITEM_MOD_DODGE_RATING_SHORT"] = 9,
                                                ["ITEM_MOD_PARRY_RATING_SHORT"] = 6.7,
                                                ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 1.9,
                                                ["ITEM_MOD_STRENGTH_SHORT"] = 4.8,
                                                ["RESISTANCE0_NAME"] = 0.6,
                                                ["ITEM_MOD_BLOCK_RATING_SHORT"] = 4.8,
                                                ["ITEM_MOD_BLOCK_VALUE_SHORT"] = 8.1,
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = 1,
                                                ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = 1,
                                                ["ITEM_MOD_CRIT_RATING_SHORT"] = 0.7,
                                                ["ITEM_MOD_HASTE_RATING_SHORT"] = 0.1,
                                                ["ITEM_MOD_ATTACK_POWER_SHORT"] = 0.1,
                                                ["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = 0.001,
                                        },
                                        caps = {
                                                ["ITEM_MOD_HIT_RATING_SHORT"] = {
                                                        ["value"] = meleeCap,
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                                ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = {
                                                        ["value"] = "689",
                                                        ["soft"] = true,
                                                        ["active"] = true,
                                                },
                                        },
                                },
                        },
                }
        end
        
        return TopFit.presets[playerClass]
end
