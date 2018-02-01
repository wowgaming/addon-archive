Ovale.defaut["ROGUE"] =
[[
Define(ENVENOM 32645)
Define(TALENTVILEPOISONS 682)
Define(TALENTCUTTOTHECHASE 2070)
Define(SLICEANDDICE 5171)
Define(RUPTURE 1943)
Define(DEEPWOUNDS 12721)
Define(GARROTE 703)
Define(REND 772)
Define(RIP 1079)
Define(HUNGERFORBLOOD 51662)
Define(EVISCERATE 2098)
Define(MUTILATE 1329)
Define(SINISTERSTRIKE 1752)
Define(ADRENALINERUSH 13750)
Define(KILLINGSPREE 51690)
Define(BLADEFLURRY 13877)
Define(COLDBLOOD 14177)
Define(PREPARATION 14185)
Define(TRICKSOFTHETRADE 57934)
Define(CLOACKOFSHADOWS 31224)

ScoreSpells(SLICEANDDICE HUNGERFORBLOOD ENVENOM RUPTURE EVISCERATE MUTILATE SINISTERSTRIKE)

AddIcon help=main
{
	unless BuffPresent(SLICEANDDICE)
	{
		if ComboPoints(more 2)
			Spell(SLICEANDDICE)
	}
	
	if {TargetDebuffPresent(RUPTURE) or TargetDebuffPresent(DEEPWOUNDS) or TargetDebuffPresent(REND)
		or TargetDebuffPresent(RIP) or TargetDebuffPresent(GARROTE)} and BuffExpires(HUNGERFORBLOOD 2)
		Spell(HUNGERFORBLOOD)
		
	if ComboPoints(more 3) and Mana(more 69)
	{
		if BuffExpires(SLICEANDDICE 12) 
		{
			if TalentPoints(TALENTCUTTOTHECHASE more 0)
				Spell(ENVENOM)
			Spell(SLICEANDDICE)
		}

		if TargetDebuffExpires(RUPTURE 0) and TargetDeadIn(more 6)
			Spell(RUPTURE)
		
		if TalentPoints(TALENTVILEPOISONS more 0)
			Spell(ENVENOM)
		Spell(EVISCERATE)
	}
	
	if ComboPoints(less 4)
	{
		Spell(MUTILATE)
		Spell(SINISTERSTRIKE)
	} 
}

AddIcon help=cd
{
	unless BuffPresent(KILLINGSPREE) Spell(ADRENALINERUSH)
	unless BuffPresent(ADRENALINERUSH) Spell(KILLINGSPREE)
	Spell(BLADEFLURRY)
	Spell(COLDBLOOD)
	Item(Trinket0Slot usable=1)
	Item(Trinket1Slot usable=1)
	Spell(PREPARATION)
}

AddIcon size=small
{
	Spell(TRICKSOFTHETRADE)
}

AddIcon size=small
{
	Spell(CLOACKOFSHADOWS)
}

]]