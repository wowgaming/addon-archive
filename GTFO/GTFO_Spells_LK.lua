--------------------------------------------------------------------------
-- GTFO_Spells_LK.lua 
--------------------------------------------------------------------------
--[[
GTFO Spell List - Lich King
Author: Zensunim of Malygos

Change Log:
	v0.3
		- Wrath spells
	v0.3.1
		- Naxx spells
	v0.3.2
		- Naxx, Archavon
	v0.3.3
		- Ulduar
	v1.0
		- Trial of the Crusader
	v1.0.1
		- Added Koralon's Flaming Cinder, Ulduar spells
		- Replaced some spell names with spell IDs
	v1.1
		- Replaced some spell names with spell IDs
		- Added Ground Fissure (Freya trash)
	v1.1.1
		- Fixed Lord Jaraxxus's Legion Flame
		- Added Lord Jaraxxus's Fel Inferno
		- Fixed Northrend Beast's Slime Pool
		- Fixed Northrend Beast's Fire Bomb
	v1.1.2
		- Added Deathstalker Visceri's Poison Bottle
		- Added Anub'arak's Scarabs' Acid-Drenched Mandibles
		- Added Mimiron's Flames
		- Added Freya Trash's Hurricane
	v1.1.3
		- Added Runemaster Molgeim's Rune of Death
		- Added Stormcaller Brundir's Lightning Tendrils
	v1.1.4
		- Added Drakuru's Blight Crystal Explosion
		- Added Toxic Waste (Pit of Saron)
		- Added Scourgelord Tyrannus's Icy Blast
		- Added Onyxia's Deep Breath
	v1.2
		- Added The Black Knight's Desecration
		- Added Bronjahm's Soulstorm
		- Added Marwyn's Well of Corruption
		- Added Marwyn's Corrupted Touch
		- Added Devourer of Souls' Well of Souls
		- Added Lord Marrowgar's Coldflame
		- Added Lady Deathwhisper's Death and Decay
	v1.2.1
		- Added Gunship Battle's Explosion
		- Added Lich King's Remorseless Winter (Halls of Reflection)
		- Added Ick's Explosive Barrage
	v1.2.2
		- Added Hall of Stone's Searing Gaze
	v1.2.3
		- Added Icecrown Citadel's Coldflame Trap
		- Added Rotface's Slime Spray
		- Added Rotface's Sticky Ooze
		- Added Rotface's Unstable Ooze Explosion
	v1.2.4
		- Added Professor Putricide's Mutated Slime
	v1.2.5
		- Added Novos the Summoner's Arcane Field
		- Added Devourer of Souls' Wailing Souls
		- Added Rotface's Ooze Flood (Low Damage normal/High Damage heroic)
		- Added Magmus's Gout of Flame
		- Added Varos Cloudstrider's Ice Beam
	v1.2.6
		- Added Blood Queen Lana'thel's Swarming Shadows
		- Added Blood Queen Lana'thel's Bloodbolt Splash
	v2.0.0
		- Added Toravon the Ice Watcher's Frozen Orb
		- Added Valithria Dreamwalker's Mana Void
		- Added ICC Trash's Arctic Chill
	v2.0.1
		- Added Rimefang's Icy Blast
	v2.0.3
		- Added Lich King's Remorseless Winter (Icecrown Citadel)
		- Added Lich King's Defile
		- Added Lich King's Ice Pulse
	v2.0.4
		- Fix Rimefang's Icy Blast
		- Added Frostblade (Icecrown Citadel)
	v2.0.5
		- Added Lavanthor's Lava Burn
		- Added Sindragosa's Backlash (Heroic)
	v2.1
		- Fixed Choking Gas (again...)
	v2.2.1
		- Added Halion's Combustion
		- Added Halion's Consumption
		- Added Halion's Meteor Strike
		- Added Halion's Twilight Cutter
	v2.2.2
		- Fixed Halion's Combustion (Heroic)
	v2.2.3
		- Added Dragonflayer Flamebinder's Flame Patch
		- Reduced memory footprint
	v2.3.1
		- Moved Twilight Cutter (non-heroic) to fail list
	v2.5
		- Split spell files into sections
		- Replaced some spell names with spell IDs
	v2.5.1
		- Added Lord Marrowgar's Bone Storm
		- Added Valithria Dreamwalker's Corrosion
		- Added Valithria Dreamwalker's Flesh Rot
		- Added Skybreaker/Kor'kron Sergeant's Bladestorm
		- Added Saviana Ragefire's Conflagration
		- Added Baltharus the Warborn's Blade Tempest
		- Added Obsidian Sanctum's Magma
	v2.5.3
		- Added Lich King's Pain and Suffering
		- Removed Lord Marrowgar's Bone Storm

]]--

GTFO.SpellID["62548"] = {
	--desc = "Scorch (Ignis-10)";
	sound = 1;
};

GTFO.SpellID["62549"] = {
	--desc = "Scorch (Ignis-10)";
	sound = 1;
};

GTFO.SpellID["63475"] = {
	--desc = "Scorch (Ignis-25)";
	sound = 1;
};

GTFO.SpellID["63476"] = {
	--desc = "Scorch (Ignis-25)";
	sound = 1;
};

GTFO.SpellID["29371"] = {
	--desc = "Eruption (Heigan the Unclean)";
	sound = 1;
};

GTFO.SpellID["47579"] = {
	--desc = "Freezing Cloud (Skadi)";
	sound = 1;
};

GTFO.SpellID["60020"] = {
	--desc = "Freezing Cloud (Skadi)";
	sound = 1;
};

GTFO.SpellID["51103"] = {
	--desc = "Frostbomb (Mage-Lord Urom)";
	sound = 2;
};

GTFO.SpellID["56926"] = {
	--desc = "Thundershock (Jedoga Shadowseeker)";
	sound = 1;
};

GTFO.SpellID["60029"] = {
	--desc = "Thundershock (Jedoga Shadowseeker - Heroic)";
	sound = 1;
};

GTFO.SpellID["55847"] = {
	--desc = "Shadow Void (Risen Drakkari Soulmage - Drak'Tharon Keep - Normal)";
	sound = 1;
};

GTFO.SpellID["59014"] = {
	--desc = "Shadow Void (Risen Drakkari Soulmage - Drak'Tharon Keep - Normal)";
	sound = 1;
};

GTFO.SpellID["49548"] = {
	--desc = "Poison Cloud (The Prophet Tharon'ja - Drak'Tharon Keep - Normal)";
	sound = 1;
};

GTFO.SpellID["59969"] = {
	--desc = "Poison Cloud (The Prophet Tharon'ja - Drak'Tharon Keep - Heroic)";
	sound = 1;
};

GTFO.SpellID["57061"] = {
	--desc = "Poison Cloud (Poisonous Mushroom - Old Kingdom)";
	sound = 1;
};

GTFO.SpellID["59116"] = {
	--desc = "Poison Cloud (Savage Cave Beast - Old Kingdom)";
	sound = 1;
};

GTFO.SpellID["56867"] = {
	--desc = "Poison Cloud (Savage Cave Beast - Old Kingdom)";
	sound = 1;
};

GTFO.SpellID["48381"] = {
	--desc = "Spirit Fount (King Ymiron)";
	sound = 1;
};

GTFO.SpellID["59321"] = {
	--desc = "Spirit Fount (King Ymiron)";
	sound = 1;
};

GTFO.SpellID["58965"] = {
	--desc = "Choking Cloud (Archavon 10)";
	sound = 1;
};

GTFO.SpellID["61672"] = {
	--desc = "Choking Cloud (Archavon 25)";
	sound = 1;
};

GTFO.SpellID["28547"] = {
	--desc = "Chill (Sapphron 10)";
	sound = 1;
};

GTFO.SpellID["55699"] = {
	--desc = "Chill (Sapphron 25)";
	sound = 1;
};

GTFO.SpellID["60919"] = {
	--desc = "Rock Shower (Archavon Warder 10)";
	sound = 1;
};

GTFO.SpellID["60923"] = {
	--desc = "Rock Shower (Archavon Warder 25)";
	sound = 1;
};

GTFO.SpellID["54362"] = {
	--desc = "Poison (Grobbulus)";
	sound = 1;
};

GTFO.SpellID["28158"] = {
	--desc = "Poison (Grobbulus)";
	sound = 1;
};

GTFO.SpellID["28241"] = {
	--desc = "Poison (Grobbulus)";
	sound = 1;
};

GTFO.SpellID["54363"] = {
	--desc = "Poison (Grobbulus)";
	sound = 1;
};

GTFO.SpellID["53400"] = {
	--desc = "Acid Cloud (Hadronox)";
	sound = 1;
};

GTFO.SpellID["59419"] = {
	--desc = "Acid Cloud (Hadronox - Heroic)";
	sound = 1;
};

GTFO.SpellID["64851"] = {
	--desc = "Flaming Rune (Ulduar trash)";
	sound = 1;
};

GTFO.SpellID["64989"] = {
	--desc = "Flaming Rune (Ulduar trash)";
	sound = 1;
};

GTFO.SpellID["50752"] = {
	--desc = "Storm of Grief (Maiden of Grief)";
	sound = 1;
};

GTFO.SpellID["59772"] = {
	--desc = "Storm of Grief (Maiden of Grief - Heroic)";
	sound = 1;
};

GTFO.SpellID["50915"] = {
	--desc = "Raging Consecration (High General Abbendis - Dragonblight)";
	sound = 2;
};

GTFO.SpellID["59451"] = {
	--desc = "Mojo Puddle";
	sound = 1;
};

GTFO.SpellID["58994"] = {
	--desc = "Mojo Puddle - Heroic";
	sound = 1;
};

GTFO.SpellID["55627"] = {
	--desc = "Mojo Puddle";
	sound = 1;
};

GTFO.SpellID["62466"] = {
	--desc = "Lightning Charge (Thorim)";
	sound = 1;
};

GTFO.SpellID["62451"] = {
	--desc = "Unstable Energy (Freya 10)";
	sound = 1;
};

GTFO.SpellID["62865"] = {
	--desc = "Unstable Energy (Freya 25)";
	sound = 1;
};

GTFO.SpellID["66881"] = {
	--desc = "Slime Pool (Northrend Beasts 10 Normal)";
	sound = 1;
};

GTFO.SpellID["67639"] = {
	--desc = "Slime Pool (Northrend Beasts 10 Heroic)";
	sound = 1;
};

GTFO.SpellID["67638"] = {
	--desc = "Slime Pool (Northrend Beasts 25 Normal)";
	sound = 1;
};

GTFO.SpellID["67640"] = {
	--desc = "Slime Pool (Northrend Beasts 25 Heroic)";
	sound = 1;
};

GTFO.SpellID["66320"] = {
	--desc = "Fire Bomb (Northrend Beasts 10 Normal)";
	sound = 1;
};

GTFO.SpellID["67473"] = {
	--desc = "Fire Bomb (Northrend Beasts 10 Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["67472"] = {
	--desc = "Fire Bomb (Northrend Beasts 25 Normal)";
	sound = 1;
};

GTFO.SpellID["67475"] = {
	--desc = "Fire Bomb (Northrend Beasts 25 Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["66877"] = {
	--desc = "Legion Flame (Lord Jaraxxus 10 Normal)";
	sound = 1;
};

GTFO.SpellID["67071"] = {
	--desc = "Legion Flame (Lord Jaraxxus 10 Heroic)";
	sound = 1;
};

GTFO.SpellID["67070"] = {
	--desc = "Legion Flame (Lord Jaraxxus 25 Normal)";
	sound = 1;
};

GTFO.SpellID["67072"] = {
	--desc = "Legion Flame (Lord Jaraxxus 25 Heroic)";
	sound = 1;
};

GTFO.SpellID["66496"] = {
	--desc = "Fel Inferno (Lord Jaraxxus 10 Normal)";
	sound = 2;
};

GTFO.SpellID["68717"] = {
	--desc = "Fel Inferno (Lord Jaraxxus 10 Heroic)";
	sound = 2;
};

GTFO.SpellID["68716"] = {
	--desc = "Fel Inferno (Lord Jaraxxus 25 Normal)";
	sound = 2;
};

GTFO.SpellID["68718"] = {
	--desc = "Fel Inferno (Lord Jaraxxus 25 Heroic)";
	sound = 2;
};

GTFO.SpellID["64704"] = {
	--desc = "Devouring Flame (Razorscale 10)";
	sound = 1;
};

GTFO.SpellID["64733"] = {
	--desc = "Devouring Flame (Razorscale 25)";
	sound = 1;
};

GTFO.SpellID["66684"] = {
	--desc = "Flaming Cinder (Koralon 10)";
	sound = 1;
};

GTFO.SpellID["67332"] = {
	--desc = "Flaming Cinder (Koralon 25)";
	sound = 1;
};

GTFO.SpellID["63346"] = {
	--desc = "Focused Eyebeam (Kologarn 10)";
	sound = 1;
};

GTFO.SpellID["63976"] = {
	--desc = "Focused Eyebeam (Kologarn 25)";
	sound = 1;
};

GTFO.SpellID["64459"] = {
	--desc = "Seeping Feral Essence (Auriaya 10)";
	sound = 1;
};

GTFO.SpellID["64675"] = {
	--desc = "Seeping Feral Essence (Auriaya 25)";
	sound = 1;
};

GTFO.SpellID["63157"] = {
	--desc = "Ground Fissure (Freya Trash 10)";
	sound = 1;
};

GTFO.SpellID["63548"] = {
	--desc = "Ground Fissure (Freya Trash 25)";
	sound = 1;
};

GTFO.SpellID["67594"] = {
	--desc = "Poison Bottle (Trials of the Champion Regular)";
	sound = 1;
};

GTFO.SpellID["68316"] = {
	--desc = "Poison Bottle (Trials of the Champion Heroic)";
	sound = 1;
};

GTFO.SpellID["65775"] = {
	--desc = "Acid-Drenched Mandibles (Anub'arak 10 Normal)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["67861"] = {
	--desc = "Acid-Drenched Mandibles (Anub'arak 10 Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["67862"] = {
	--desc = "Acid-Drenched Mandibles (Anub'arak 25 Normal)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["67863"] = {
	--desc = "Acid-Drenched Mandibles (Anub'arak 25 Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["64566"] = {
	--desc = "Flames (Mimiron Hard Mode)";
	sound = 1;
};

GTFO.SpellID["63272"] = {
	--desc = "Hurricane (Freya Trash)";
	sound = 1;
};

GTFO.SpellID["62269"] = {
	--desc = "Rune of Death (Runemaster Molgeim 10)";
	sound = 1;
};

GTFO.SpellID["63490"] = {
	--desc = "Rune of Death (Runemaster Molgeim 25)";
	sound = 1;
};

GTFO.SpellID["61886"] = {
	--desc = "Lightning Tendrils (Stormcaller Brundir 10)";
	sound = 1;
};

GTFO.SpellID["63485"] = {
	--desc = "Lightning Tendrils (Stormcaller Brundir 25)";
	sound = 1;
};

GTFO.SpellID["54115"] = {
	--desc = "Blight Crystal Explosion (Drakuru)";
	sound = 1;
};

GTFO.SpellID["69024"] = {
	--desc = "Toxic Waste";
	sound = 1;
};

GTFO.SpellID["70274"] = {
	--desc = "Toxic Waste";
	sound = 1;
};

GTFO.SpellID["70436"] = {
	--desc = "Toxic Waste";
	sound = 1;
};

GTFO.SpellID["69238"] = {
	--desc = "Icy Blast (Scourgelord Tyrannus - Normal)";
	sound = 1;
};

GTFO.SpellID["69628"] = {
	--desc = "Icy Blast (Scourgelord Tyrannus - Heroic)";
	sound = 1;
};

-- There are 92 different spell IDs for this one!  Going to stick with the name for now...
GTFO.SpellName["Breath"] = {
	--desc = "Breath (Onyxia)";
	sound = 1;
};

GTFO.SpellID["67781"] = {
	--desc = "Desecration (The Black Knight - Normal)";
	sound = 1;
};

GTFO.SpellID["67876"] = {
	--desc = "Desecration (The Black Knight - Heroic)";
	sound = 1;
};

GTFO.SpellID["72362"] = {
	--desc = "Well of Corruption (Marwyn)";
	sound = 1;
};

GTFO.SpellID["72383"] = {
	--desc = "Corrupted Touch (Marwyn - Normal)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["72450"] = {
	--desc = "Corrupted Touch (Marwyn - Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["68921"] = {
	--desc = "Soulstorm (Bronjahm - Normal)";
	sound = 1;
};

GTFO.SpellID["69049"] = {
	--desc = "Soulstorm (Bronjahm - Heroic)";
	sound = 1;
};

GTFO.SpellID["68863"] = {
	--desc = "Well of Souls (Devourer of Souls - Normal)";
	sound = 1;
};

GTFO.SpellID["70323"] = {
	--desc = "Well of Souls (Devourer of Souls - Heroic)";
	sound = 1;
};

GTFO.SpellID["69146"] = {
	--desc = "Coldflame (Lord Marrowgar - Normal 10)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["70823"] = {
	--desc = "Coldflame (Lord Marrowgar - Normal 25)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["70824"] = {
	--desc = "Coldflame (Lord Marrowgar - Heroic 10)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["70825"] = {
	--desc = "Coldflame (Lord Marrowgar - Heroic 25)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["71001"] = {
	--desc = "Death and Decay (Lady Deathwhisper - 10 Normal)";
	sound = 1;
};

GTFO.SpellID["72108"] = {
	--desc = "Death and Decay (Lady Deathwhisper - 25 Normal)";
	sound = 1;
};

GTFO.SpellID["72109"] = {
	--desc = "Death and Decay (Lady Deathwhisper - 10 Heroic)";
	sound = 1;
};

GTFO.SpellID["72110"] = {
	--desc = "Death and Decay (Lady Deathwhisper - 25 Heroic)";
	sound = 1;
};

GTFO.SpellID["69781"] = {
	--desc = "Remorseless Winter (Lich King - HoR)";
	sound = 1;
};

GTFO.SpellID["51125"] = {
	--desc = "Searing Gaze (Hall of Stone - Normal)";
	sound = 1;
};

GTFO.SpellID["59866"] = {
	--desc = "Searing Gaze (Hall of Stone - Heroic)";
	sound = 1;
};

GTFO.SpellID["70461"] = {
	--desc = "Coldflame Trap (Icecrown Citadel)";
	sound = 1;
};

GTFO.SpellID["69774"] = {
	--desc = "Sticky Ooze (Rotface)";
	sound = 1;
};

GTFO.SpellID["69776"] = {
	--desc = "Sticky Ooze (Rotface)";
	sound = 1;
};

GTFO.SpellID["69778"] = {
	--desc = "Sticky Ooze (Rotface)";
	sound = 1;
};

GTFO.SpellID["71208"] = {
	--desc = "Sticky Ooze (Rotface)";
	sound = 1;
};

GTFO.SpellID["69507"] = {
	--desc = "Slime Spray (Rotface)";
	sound = 1;
};

GTFO.SpellID["71213"] = {
	--desc = "Slime Spray (Rotface)";
	sound = 1;
};

GTFO.SpellID["73190"] = {
	--desc = "Slime Spray (Rotface)";
	sound = 1;
};

GTFO.SpellID["73189"] = {
	--desc = "Slime Spray (Rotface)";
	sound = 1;
};

GTFO.SpellID["71209"] = {
	--desc = "Unstable Ooze Explosion (Rotface)";
	sound = 1;
};

GTFO.SpellID["73030"] = {
	--desc = "Unstable Ooze Explosion (Rotface)";
	sound = 1;
};

GTFO.SpellID["73029"] = {
	--desc = "Unstable Ooze Explosion (Rotface)";
	sound = 1;
};

GTFO.SpellID["69839"] = {
	--desc = "Unstable Ooze Explosion (Rotface)";
	sound = 1;
};

GTFO.SpellID["69833"] = {
	--desc = "Unstable Ooze Explosion (Rotface)";
	sound = 1;
};

GTFO.SpellID["69832"] = {
	--desc = "Unstable Ooze Explosion (Rotface)";
	sound = 1;
};

GTFO.SpellID["70346"] = {
	--desc = "Mutated Slime (Professor Putricide)";
	sound = 1;
};

GTFO.SpellID["70346"] = {
	--desc = "Mutated Slime (Professor Putricide - 10 Normal)";
	sound = 1;
};

GTFO.SpellID["72456"] = {
	--desc = "Mutated Slime (Professor Putricide - 25 Normal)";
	sound = 1;
};

GTFO.SpellID["47346"] = {
	--desc = "Arcane Field (Novos the Summoner)";
	sound = 1;
};

GTFO.SpellID["68873"] = {
	--desc = "Wailing Souls (Devourer of Souls - Normal)";
	sound = 1;
};

GTFO.SpellID["70324"] = {
	--desc = "Wailing Souls (Devourer of Souls - Heroic)";
	sound = 1;
};

GTFO.SpellID["69789"] = {
	--desc = "Ooze Flood (Rotface - 10)";
	sound = 2;
};

GTFO.SpellID["71215"] = {
	--desc = "Ooze Flood (Rotface - 25)";
	sound = 2;
};

GTFO.SpellID["71587"] = {
	--desc = "Ooze Flood (Rotface - 10H)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["71588"] = {
	--desc = "Ooze Flood (Rotface - 25H)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["15538"] = {
	--desc = "Gout of Flame (Magmus - Blackrock Depths)";
	sound = 1;
};

GTFO.SpellID["49549"] = {
	--desc = "Ice Beam (Varos Cloudstrider - Normal)";
	sound = 1;
};

GTFO.SpellID["59211"] = {
	--desc = "Ice Beam (Varos Cloudstrider - Heroic)";
	sound = 1;
};

GTFO.SpellID["71268"] = {
	--desc = "Swarming Shadows (Blood Queen Lana'thel - 10)";
	sound = 1;
};

GTFO.SpellID["72635"] = {
	--desc = "Swarming Shadows (Blood Queen Lana'thel - 25)";
	sound = 1;
};

GTFO.SpellID["72636"] = {
	--desc = "Swarming Shadows (Blood Queen Lana'thel - 10 Heroic)";
	sound = 1;
};

GTFO.SpellID["72637"] = {
	--desc = "Swarming Shadows (Blood Queen Lana'thel - 25 Heroic)";
	sound = 1;
};

GTFO.SpellID["71447"] = {
	--desc = "Bloodbolt Splash (Blood Queen Lana'thel - 10)";
	sound = 1;
};

GTFO.SpellID["71481"] = {
	--desc = "Bloodbolt Splash (Blood Queen Lana'thel - 25)";
	sound = 1;
};

GTFO.SpellID["71482"] = {
	--desc = "Bloodbolt Splash (Blood Queen Lana'thel - 10 Heroic)";
	sound = 1;
};

GTFO.SpellID["71483"] = {
	--desc = "Bloodbolt Splash (Blood Queen Lana'thel - 25 Heroic)";
	sound = 1;
};

GTFO.SpellID["72082"] = {
	--desc = "Frozen Orb (Toravon 10)";
	tankSound = 2;
	sound = 1;
};

GTFO.SpellID["72097"] = {
	--desc = "Frozen Orb (Toravon 25)";
	tankSound = 2;
	sound = 1;
};

GTFO.SpellID["71271"] = {
	--desc = "Arctic Chill (ICC Frostwing Trash - 10)";
	sound = 1;
};

GTFO.SpellID["71829"] = {
	--desc = "Arctic Chill (ICC Frostwing Trash - 25)";
	sound = 1;
};

GTFO.SpellID["71086"] = {
	--desc = "Mana Void (Valithria Dreamwalker - 10)";
	sound = 1;
};

GTFO.SpellID["71743"] = {
	--desc = "Mana Void (Valithria Dreamwalker - 25)";
	sound = 1;
};

GTFO.SpellID["71380"] = {
	--desc = "Icy Blast (Rimefang - ICC 10)";
	sound = 1;
};

GTFO.SpellID["71381"] = {
	--desc = "Icy Blast (Rimefang - ICC 25)";
	sound = 1;
};

GTFO.SpellID["72754"] = {
	--desc = "Defile (Lich King - 10)";
	sound = 1;
};

GTFO.SpellID["73708"] = {
	--desc = "Defile (Lich King - 25)";
	sound = 1;
};

GTFO.SpellID["73709"] = {
	--desc = "Defile (Lich King - 10H)";
	sound = 1;
};

GTFO.SpellID["73710"] = {
	--desc = "Defile (Lich King - 25H)";
	sound = 1;
};

GTFO.SpellID["68983"] = {
	--desc = "Remorseless Winter (Lich King - 10)";
	sound = 1;
};

GTFO.SpellID["73791"] = {
	--desc = "Remorseless Winter (Lich King - 25)";
	sound = 1;
};

GTFO.SpellID["73792"] = {
	--desc = "Remorseless Winter (Lich King - 10H)";
	sound = 1;
};

GTFO.SpellID["73793"] = {
	--desc = "Remorseless Winter (Lich King - 25H)";
	sound = 1;
};

GTFO.SpellID["69099"] = {
	--desc = "Ice Pulse (Lich King - 10)";
	sound = 1;
};

GTFO.SpellID["73776"] = {
	--desc = "Ice Pulse (Lich King - 25)";
	sound = 1;
};

GTFO.SpellID["73777"] = {
	--desc = "Ice Pulse (Lich King - 10H)";
	sound = 1;
};

GTFO.SpellID["73778"] = {
	--desc = "Ice Pulse (Lich King - 25H)";
	sound = 1;
};

GTFO.SpellID["70305"] = {
	--desc = "Frostblade (Icecrown Citadel)";
	sound = 1;
};

GTFO.SpellID["54251"] = {
	--desc = "Lava Burn (Lavanthor - VH)";
	sound = 2;
};

GTFO.SpellID["59470"] = {
	--desc = "Lava Burn (Lavanthor - VH)";
	sound = 1;
};

GTFO.SpellID["71045"] = {
	--desc = "Backlash (Sindragosa - 10H)";
	sound = 1;
	ignoreSelfInflicted = true;
};

GTFO.SpellID["71046"] = {
	--desc = "Backlash (Sindragosa - 25H)";
	sound = 1;
	ignoreSelfInflicted = true;
};

GTFO.SpellID["71278"] = {
	--desc = "Choking Gas (Professor Putricide 10)";
	sound = 1;
};

GTFO.SpellID["72460"] = {
	--desc = "Choking Gas (Professor Putricide 25)";
	sound = 1;
};

GTFO.SpellID["72619"] = {
	--desc = "Choking Gas (Professor Putricide 10H)";
	sound = 1;
};

GTFO.SpellID["72620"] = {
	--desc = "Choking Gas (Professor Putricide 25H)";
	sound = 1;
};

GTFO.SpellID["74630"] = {
	--desc = "Combustion (Halion 10)";
	sound = 1;
};

GTFO.SpellID["75882"] = {
	--desc = "Combustion (Halion 25)";
	sound = 1;
};

GTFO.SpellID["75883"] = {
	--desc = "Combustion (Halion 10H)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["75884"] = {
	--desc = "Combustion (Halion 25H)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["74712"] = {
	--desc = "Meteor Strike (Halion)";
	sound = 1;
};

GTFO.SpellID["74717"] = {
	--desc = "Meteor Strike (Halion)";
	sound = 1;
};

GTFO.SpellID["75877"] = {
	--desc = "Meteor Strike (Halion)";
	sound = 1;
};

GTFO.SpellID["75947"] = {
	--desc = "Meteor Strike (Halion)";
	sound = 1;
};

GTFO.SpellID["75948"] = {
	--desc = "Meteor Strike (Halion)";
	sound = 1;
};

GTFO.SpellID["75949"] = {
	--desc = "Meteor Strike (Halion)";
	sound = 1;
};

GTFO.SpellID["75950"] = {
	--desc = "Meteor Strike (Halion)";
	sound = 1;
};

GTFO.SpellID["75951"] = {
	--desc = "Meteor Strike (Halion)";
	sound = 1;
};

GTFO.SpellID["75952"] = {
	--desc = "Meteor Strike (Halion)";
	sound = 1;
};

GTFO.SpellID["74802"] = {
	--desc = "Consumption (Halion 10)";
	sound = 1;
};

GTFO.SpellID["75874"] = {
	--desc = "Consumption (Halion 25)";
	sound = 1;
};

GTFO.SpellID["75875"] = {
	--desc = "Consumption (Halion 10H)";
	sound = 1;
};

GTFO.SpellID["75876"] = {
	--desc = "Consumption (Halion 25H)";
	sound = 1;
};

GTFO.SpellID["52208"] = {
	--desc = "Flame Patch (Grizzly Hills)";
	sound = 2;
};

GTFO.SpellID["70751"] = {
	--desc = "Corrosion (Valithria Dreamwalker - 10)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["71738"] = {
	--desc = "Corrosion (Valithria Dreamwalker - 25)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["72021"] = {
	--desc = "Corrosion (Valithria Dreamwalker - 10H)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["72022"] = {
	--desc = "Corrosion (Valithria Dreamwalker - 25H)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["72963"] = {
	--desc = "Flesh Rot (Valithria Dreamwalker - 10)";
	sound = 1;
	tankSound = 0;
	applicationOnly = true;
};

GTFO.SpellID["72964"] = {
	--desc = "Flesh Rot (Valithria Dreamwalker - 25)";
	sound = 1;
	tankSound = 0;
	applicationOnly = true;
};

GTFO.SpellID["72965"] = {
	--desc = "Flesh Rot (Valithria Dreamwalker - 10H)";
	sound = 1;
	tankSound = 0;
	applicationOnly = true;
};

GTFO.SpellID["72966"] = {
	--desc = "Flesh Rot (Valithria Dreamwalker - 25H)";
	sound = 1;
	tankSound = 0;
	applicationOnly = true;
};

GTFO.SpellID["69653"] = {
	--desc = "Bladestorm (Skybreaker/Kor'kron Sergeant)";
	sound = 1;
	tankSound = 0;
	applicationOnly = true;
};

GTFO.SpellID["74457"] = {
	--desc = "Conflagration (Saviana Ragefire)";
	sound = 1;
	ignoreSelfInflicted = true;
};

GTFO.SpellID["75126"] = {
	--desc = "Blade Tempest (Baltharus the Warborn)";
	sound = 1;
	tankSound = 0;
};

GTFO.SpellID["57634"] = {
	--desc = "Magma (Obsidian Sanctum)";
	sound = 1;
};

GTFO.SpellID["74117"] = {
	--desc = "Pain and Suffering (Lich King - HoR)";
	sound = 1;
};
