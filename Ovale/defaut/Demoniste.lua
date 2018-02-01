Ovale.defaut["WARLOCK"]=
[[
Define(CURSEELEMENTS 1490)
Define(CURSEAGONY 980)
Define(CURSEDOOM 603)
Define(CURSETONGUES 1714)
Define(CURSEWEAKNESS 702)
Define(UNSTABLEAFFLICTION 30108)
Define(CORRUPTION 172)
Define(TALENTUNSTABLEAFFLICTION 1670)
Define(TALENTSHADOWBOLT 944)
Define(IMMOLATE 348)
Define(TALENTIMMOLATE 961)
Define(TALENTEMBERSTORM 966)
Define(SOULFIRE 6353)
Define(SHADOWBOLT 686)
Define(HAUNT 48181)
Define(TALENTBACKDRAFT 1888)
Define(CONFLAGRATE 17962)
Define(DRAINSOUL 47855)
Define(SHADOWEMBRACE 32391)
Define(TALENTSHADOWEMBRACE 1763)
Define(METAMORPHOSIS 47241)
Define(TALENTDECIMATION 2261)
Define(SOULSHARD 6265)
Define(DEMONICEMPOWERMENT 47193)
Define(INCINERATE 29722)
Define(DECIMATION 63167)
Define(CHAOSBOLT 50796)
Define(MOLTENCORE 47383)
Define(GLYPHOFCONFLAGRATE 56235)
Define(FELARMOR 28176)
Define(FIRESTONE 6366)
Define(SPELLSTONE 2362)
Define(GLYPHLIFETAP 63320)
Define(LIFETAP 1454)
Define(SEEDOFCORRUPTION 27243)

AddListItem(curse elements SpellName(CURSEELEMENTS))
AddListItem(curse agony SpellName(CURSEAGONY))
AddListItem(curse doom SpellName(CURSEDOOM) default)
AddListItem(curse tongues SpellName(CURSETONGUES))
AddListItem(curse weakness SpellName(CURSEWEAKNESS))

SpellInfo(HAUNT cd=8)
SpellInfo(CONFLAGRATE cd=10)
SpellInfo(CHAOSBOLT cd=12)
SpellInfo(DRAINSOUL canStopChannelling=5)
SpellAddTargetDebuff(CORRUPTION CORRUPTION=18)
SpellAddTargetDebuff(CURSEAGONY CURSEAGONY=24)
SpellAddTargetDebuff(CURSEELEMENTS CURSEELEMENTS=300)
SpellAddTargetDebuff(CURSEDOOM CURSEDOOM=60)
SpellAddTargetDebuff(UNSTABLEAFFLICTION UNSTABLEAFFLICTION=15)
SpellAddTargetDebuff(IMMOLATE IMMOLATE=15)
SpellAddTargetDebuff(SHADOWBOLT SHADOWEMBRACE=12)
SpellAddBuff(INCINERATE MOLTENCORE=-1)
SpellAddBuff(IMMOLATE MOLTENCORE=-1)
SpellAddTargetDebuff(CONFLAGRATE IMMOLATE=0)
SpellAddTargetDebuff(CONFLAGRATE glyph=GLYPHOFCONFLAGRATE)

ScoreSpells(CURSEELEMENTS SHADOWBOLT HAUNT UNSTABLEAFFLICTION IMMOLATE CONFLAGRATE CURSEDOOM CURSETONGUES CURSEWEAKNESS
	CURSEAGONY CORRUPTION SOULFIRE DRAINSOUL INCINERATE SHADOWBOLT CHAOSBOLT)

AddIcon help=main
{

unless InCombat()
{
	if BuffExpires(FELARMOR 400) Spell(FELARMOR)
	if WeaponEnchantExpires(mainhand 400)
	{
		if TalentPoints(TALENTEMBERSTORM more 0) Spell(FIRESTONE)
		Spell(SPELLSTONE)
		Spell(FIRESTONE)
	}
}

if Glyph(GLYPHLIFETAP) and BuffExpires(LIFETAP 0) Spell(LIFETAP)
if List(curse elements) and TargetDebuffExpires(CURSEELEMENTS 2) and TargetDeadIn(more 8) Spell(CURSEELEMENTS)
if TalentPoints(TALENTSHADOWEMBRACE more 0) and TargetDebuffExpires(SHADOWEMBRACE 0) Spell(SHADOWBOLT)
if TargetDebuffExpires(HAUNT 1.5 mine=1) Spell(HAUNT)
if TargetDebuffExpires(UNSTABLEAFFLICTION 1.5 mine=1 haste=spell) and TargetDeadIn(more 8) Spell(UNSTABLEAFFLICTION)
if TalentPoints(TALENTBACKDRAFT more 0) and TargetDebuffPresent(IMMOLATE mine=1)
{
	if TargetDebuffExpires(IMMOLATE 3 mine=1) or Glyph(GLYPHOFCONFLAGRATE)
		Spell(CONFLAGRATE)
}

if TargetDebuffExpires(IMMOLATE 1.5 mine=1 haste=spell) and TargetDebuffExpires(UNSTABLEAFFLICTION 0 mine=1) and
		{TargetLifePercent(more 25) or TalentPoints(TALENTDECIMATION more 0)} and TargetDeadIn(more 8)
			Spell(IMMOLATE)

if TargetDebuffExpires(CORRUPTION 0 mine=1) and TargetDebuffExpires(SEEDOFCORRUPTION 0 mine=1)
	and TargetDeadIn(more 9) and TalentPoints(TALENTEMBERSTORM less 1) Spell(CORRUPTION)
			
if TargetDebuffExpires(CURSEDOOM 0) and TargetDebuffExpires(CURSETONGUES 2) and TargetDebuffExpires(CURSEWEAKNESS 2)
	and TargetDebuffExpires(CURSEAGONY 0 mine=1) and TargetDebuffExpires(CURSEELEMENTS 2)
{
	if List(curse doom) and TargetDeadIn(more 60) Spell(CURSEDOOM)
	if List(curse tongues) Spell(CURSETONGUES)
	if List(curse weakness) Spell(CURSEWEAKNESS)
	if TargetDeadIn(more 10) Spell(CURSEAGONY)
}

if BuffPresent(DECIMATION) Spell(SOULFIRE)

if TargetLifePercent(less 25) and Level(more 76) and {TalentPoints(TALENTDECIMATION less 1) or ItemCount(SOULSHARD less 16)}
		 and TalentPoints(TALENTEMBERSTORM less 1) Spell(DRAINSOUL)

Spell(CHAOSBOLT)
if Glyph(GLYPHLIFETAP) and BuffExpires(LIFETAP 1) Spell(LIFETAP)
if TalentPoints(TALENTEMBERSTORM more 0) or BuffPresent(MOLTENCORE) Spell(INCINERATE)
Spell(SHADOWBOLT)
}

AddIcon help=cd
{
	Spell(METAMORPHOSIS)
	Spell(DEMONICEMPOWERMENT)
	Item(Trinket0Slot usable=1)
	Item(Trinket1Slot usable=1)
}

AddIcon size=small nocd=1
{
	if TargetDebuffExpires(CURSEAGONY 0 mine=1) Spell(CURSEAGONY)
}
AddIcon size=small nocd=1
{
	if TargetDebuffExpires(CURSEDOOM 0 mine=1) Spell(CURSEDOOM)
}
AddIcon size=small nocd=1
{
	if TargetDebuffExpires(CORRUPTION 0 mine=1) Spell(CORRUPTION)
}
]]
