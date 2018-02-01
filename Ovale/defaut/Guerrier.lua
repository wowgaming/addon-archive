Ovale.defaut["WARRIOR"] =
[[
Define(THUNDERCLAP 6343)
Define(SHOCKWAVE 46968)
Define(DEMOSHOUT 1160)
Define(COMMANDSHOUT 469)
Define(BATTLESHOUT 2048)
Define(REVENGE 6572)
Define(SHIELDSLAM 23922)
Define(DEVASTATE 20243)
Define(VICTORY 34428)
Define(EXECUTE 5308)
Define(BLOODTHIRST 23881)
Define(WHIRLWIND 1680)
Define(SLAMBUFF 46916)
Define(SLAM 1464)
Define(MORTALSTRIKE 12294)
Define(SLAMTALENT 2233)
Define(CLEAVE 845)
Define(HEROICSTRIKE 78)
Define(SUNDER 7386)
Define(CONCUSSIONBLOW 12809)
Define(REND 772)
Define(OVERPOWER 7384)
Define(SHIELDBLOCK 2565)
Define(SHIELDWALL 871)
Define(LASTSTAND 12975)
Define(DEATHWISH 12292)
Define(RECKLESSNESS 1719)
Define(BLADESTORM 46924)
Define(SUDDENDEATH 52437)
Define(RETALIATION 20230)
Define(TASTEFORBLOOD 56636)

Define(DEMORALIZINGROAR 48560)
Define(CURSEOFWEAKNESS 50511)

AddCheckBox(multi L(AOE))
AddCheckBox(demo SpellName(DEMOSHOUT))
AddCheckBox(whirlwind SpellName(WHIRLWIND) default)
AddCheckBox(sunder SpellName(SUNDER) default)
AddListItem(shout none L(None))
AddListItem(shout battle SpellName(BATTLESHOUT))
AddListItem(shout command SpellName(COMMANDSHOUT))

SpellAddTargetDebuff(THUNDERCLAP THUNDERCLAP=30)
SpellAddTargetDebuff(DEMOSHOUT DEMOSHOUT=45)
SpellAddTargetDebuff(REND REND=15)
SpellAddTargetDebuff(DEVASTATE SUNDER=30)
SpellAddTargetDebuff(SUNDER SUNDER=30)
SpellAddBuff(BATTLESHOUT BATTLESHOUT=120)
SpellAddBuff(COMMANDSHOUT COMMANDSHOUT=120)
SpellAddBuff(SLAM SLAMBUFF=-1)
SpellInfo(WHIRLWIND cd=8)
SpellInfo(BLOODTHIRST cd=4)
SpellInfo(DEATHWISH cd=180)
SpellInfo(HEROICSTRIKE toggle=1)
SpellInfo(CLEAVE toggle=1)
ScoreSpells(WHIRLWIND BLOODTHIRST SLAM REND MORTALSTRIKE EXECUTE SHIELDSLAM REVENGE)

AddIcon help=main
{
     if List(shout command) and
       BuffExpires(COMMANDSHOUT 3)
          Spell(COMMANDSHOUT nored=1)
        
     if List(shout battle) and BuffExpires(BATTLESHOUT 3)
          Spell(BATTLESHOUT nored=1)
      
     if TargetClassification(worldboss) 
            and CheckBoxOn(demo)
            and TargetDebuffExpires(DEMOSHOUT 2)
            and TargetDebuffExpires(DEMORALIZINGROAR 0)
            and TargetDebuffExpires(CURSEOFWEAKNESS 0)
          Spell(DEMOSHOUT nored=1)
         
	if CheckBoxOn(sunder) and TargetDebuffExpires(SUNDER 2 stacks=5) and TargetDebuffPresent(SUNDER stacks=4)
	{
		Spell(DEVASTATE nored=1)
		Spell(SUNDER nored=1)
	}
	
     if Stance(2) #Defense
     {
        if TargetClassification(worldboss)
        {
            if TargetDebuffExpires(THUNDERCLAP 2)
				Spell(THUNDERCLAP nored=1)
			Spell(CONCUSSIONBLOW)
			Spell(SHOCKWAVE)
		}
        
        if CheckBoxOn(multi)
        {
               Spell(THUNDERCLAP)
               Spell(SHOCKWAVE)
        }
        
        Spell(REVENGE usable=1)
        Spell(SHIELDSLAM)
        Spell(BLOODTHIRST)
		Spell(MORTALSTRIKE)
        
        if Mana(more 10) Spell(DEVASTATE)
     }

     if Stance(3) #berserker
     {
        if HasShield() Spell(SHIELDSLAM)
        Spell(SHOCKWAVE)
        Spell(CONCUSSIONBLOW)
    
        if CheckBoxOn(whirlwind) Spell(WHIRLWIND)
        Spell(BLOODTHIRST)
        if TargetLifePercent(less 20) Spell(EXECUTE)
        Spell(VICTORY usable=1)
        if BuffPresent(SLAMBUFF)
        {
			if BuffExpires(SLAMBUFF 2.5)
      			Spell(SLAM nored=1)
			if BuffDuration(SLAMBUFF more 6) and 1s before Spell(BLOODTHIRST) and { 1s before Spell(WHIRLWIND) or CheckBoxOff(whirlwind) }
				Spell(SLAM nored=1)
      		Spell(SLAM priority=2 nored=1)
      	}
	 
        Spell(MORTALSTRIKE)
   
        if TalentPoints(SLAMTALENT more 1)
		    Spell(SLAM priority=2)

        Spell(DEVASTATE)
    }

     if Stance(1) #combat
     {
		#Suggestions by wikiupd
		if BuffExpires(TASTEFORBLOOD 1.5) and TargetDebuffExpires(REND 0 mine=1) Spell(OVERPOWER usable=1)
		if TargetDebuffExpires(REND 0 mine=1) and TargetDeadIn(more 8) Spell(REND)
		unless BuffPresent(TASTEFORBLOOD) Spell(OVERPOWER usable=1) # Dodge OP
		if BuffExpires(TASTEFORBLOOD 4.5) Spell(OVERPOWER usable=1) # OP w/ less than 4.5 sec 
        if TargetLifePercent(more 20) Spell(MORTALSTRIKE)
        if BuffPresent(SUDDENDEATH) or TargetLifePercent(less 20) Spell(EXECUTE)
        Spell(OVERPOWER usable=1)
        Spell(VICTORY usable=1)
     
         if TalentPoints(SLAMTALENT more 1)
		    Spell(SLAM priority=2)
 
		#Some other specs stuff, just in case
		Spell(BLOODTHIRST)
        if HasShield() Spell(SHIELDSLAM)
        Spell(SHOCKWAVE)
        Spell(CONCUSSIONBLOW)
        Spell(DEVASTATE)
     }

	if CheckBoxOn(sunder) and TargetDebuffExpires(SUNDER 10 stacks=5)
	{
	    Spell(DEVASTATE priority=2 nored=1)
		Spell(SUNDER priority=2 nored=1)
    }
}

AddIcon help=offgcd
{
	if CheckBoxOff(multi)
	{
		if Stance(2)
		{
			if Mana(more 66) 
				Spell(HEROICSTRIKE)
		}
		if Stance(3)
		{
			if Mana(more 66)
				Spell(HEROICSTRIKE)
		}
		if Stance(1)
		{
			if Mana(more 94)
				Spell(HEROICSTRIKE)
		}
	}
    if Mana(more 50) and CheckBoxOn(multi)
		Spell(CLEAVE)
 }

AddIcon help=cd
{
    if Stance(2) #Defense
    {
        Spell(SHIELDBLOCK)
		Spell(LASTSTAND)
		Spell(SHIELDWALL)
    }
    if Stance(3) #berserker
    {
		Spell(DEATHWISH)
		Spell(RECKLESSNESS)
    }
    if Stance(1) #combat
    {
		Spell(BLADESTORM)
		Spell(RETALIATION)
    }
    Item(Trinket0Slot usable=1)
	Item(Trinket1Slot usable=1)
}

]]
