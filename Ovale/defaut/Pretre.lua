Ovale.defaut["PRIEST"] =
[[
# Define constants for easier addressing of spells
Define(SWP 589) # Shadow Word: Pain
Define(VT 34916) # Vampiric Touch
Define(VE 15286) # Vampiric Embrace
Define(SF 15473) # Shadowform
Define(MF 15407) # Mind Flay
Define(MB 8092) # Mind Blast
Define(DP 2944) # Devouring Plague
Define(SW 15257) # Shadow Weaving
Define(IF 48168) # Inner Fire
Define(Focus 14751) # Inner Focus
Define(Dispersion 47585)
Define(Shadowfiend 34433)
Define(Bloodlust 2825)
Define(Heroism 32182)

AddCheckBox(multidot L(multidot))

# Spells with cast time that add buff or debuff
SpellAddTargetDebuff(SWP SWP=18)
SpellInfo(SWP duration=18)
SpellAddBuff(SWP SW=15)
SpellAddTargetDebuff(VT VT=15)
SpellInfo(VT duration=15 durationhaste=spell)
SpellAddBuff(VT SW=15)
SpellInfo(MF canStopChannelling=3)
SpellAddBuff(MF SW=15)
SpellInfo(MB cd=5.5)
SpellAddBuff(MB SW=15)
SpellAddBuff(IF IF=1800)
SpellAddTargetDebuff(DP DP=24)
SpellInfo(DP duration=24 durationhaste=spell)
SpellInfo(Focus cd=180)
SpellInfo(Dispersion cd=120)
SpellInfo(Shadowfiend cd=300)
ScoreSpells(MB SWP VT DP MF)

# Add main monitor
AddIcon help=main
{
unless InCombat()
{
	#Check shadowform is up
	unless BuffPresent(SF)
		Spell(SF)
		
	# Refresh inner fire
	if BuffExpires(IF 400)
		Spell(IF)
		
	if BuffExpires(VE 400) 
		Spell(VE)
}

#if inner focus is active, cast mind blast
if BuffPresent(Focus) 
    Spell(MB)
    
# Check if Shadow Weave is stacked 5 times
# before suggesting Shadow Word: Pain
if BuffPresent(SW stacks=5) and TargetDebuffExpires(SWP 0 mine=1) and TargetDeadIn(more 6)
{
   Spell(SWP)
}

#Refresh VT
if TargetDebuffExpires(VT 1 mine=1 haste=spell) and TargetDeadIn(more 8)
	Spell(VT)
  
#cast MB if up
unless BuffPresent(Heroism) or BuffPresent(Bloodlust)
	Spell(MB)
  
#Refresh devouring plague  
unless CheckBoxOn(multidot) and OtherDebuffPresent(DP)
{
	if TargetDebuffExpires(DP 0 mine=1) and TargetDeadIn(more 8)
		Spell(DP)
}

if CheckBoxOn(multidot) and OtherDebuffExpires(SWP)
	Texture(INV_Misc_Coin_01) 

#cast Mind flay if nothing else can be done
Spell(MF priority=2)

} # End of main monitor    

AddIcon help=cd
{
	Item(Trinket0Slot usable=1)
	Item(Trinket1Slot usable=1)
}
        
# Add mana monitor
AddIcon help=mana {

#if up, launch focus (and then MB since it's the first priority)
Spell(Focus usable=1)

#Regain mana if needed and if shadowfiend is not already out
if Mana(less 4000) and PetPresent(no)
{
    Spell(Shadowfiend usable=1)
    unless TargetDebuffExpires(VT 6 mine=1 haste=spell) Spell(Dispersion usable=1)
}
}

# Add icons to monitor debuffs (will show up 5 secs before elapsed)
AddIcon size=small nocd=1 {if TargetDebuffExpires(VT 1.4 mine=1 haste=spell) Spell(VT) } # Vampiric Touch
AddIcon size=small nocd=1 {if TargetDebuffExpires(SWP 1 mine=1) Spell(SWP) } # Shadow Word: Pain
AddIcon size=small nocd=1 {if TargetDebuffExpires(DP 1 mine=1) Spell(DP) } 
]]
