--------------------------------------------------------------------------
-- GTFO_Fail_LK.lua 
--------------------------------------------------------------------------
--[[
GTFO Fail List - Wrath of the Lich King
Author: Zensunim of Malygos

Change Log:
	v2.0
		- Added Kel'thuzad's Void Blast
		- Added Obsidian Sanctum's Void Blast
		- Added Obsidian Sanctum's Flame Tsunami
		- Added Prince Valanar's Shock Vortex
		- Added Professor Putricide's Malleable Goo (Normal only)
		- Added Professor Putricide's Choking Gas Explosion
		- Added Valithria Dreamwalker's Column of Frost
		- Added Valithria Dreamwalker's Acid Burst
	v2.0.1
		- Added Sindragosa's Tail Smash
		- Added Sindragosa's Frost Bomb
		- Added Sindragosa's Blistering Cold
	v2.0.3
		- Added Lich King's Spirit Burst
	v2.0.4
		- Reclassified Mimiron's Mine Explosion
		- Reclassified Ick's Explosive Barrage
		- Reclassified Gunship Explosion
	v2.0.5
		- Added Professor Putricide's Malleable Goo (Heroic)
		- Added Professor Putricide's Choking Gas
		- Fixed Professor Putricide's Choking Gas Explosion
		- Added Lady Deathwhispers's Vengeful Blast
		- Added Lich King's Ice Burst
		- Added Lich King's Shadow Trap
	v2.2.1
		- Added Halion's Meteor Strike
		- Added Halion's Twilight Cutter
	v2.2.3
		- Reduced memory footprint
	v2.3.1
		- Updated Twilight Cutter (non-heroic)
		- Updated Malleable Goo (Heroic Festergut)
	v2.5
		- Split spell files into sections
	v2.5.1
		- Added Lord Marrowgar's Bone Slice
		- Added Valithria Dreamwalker's Gut Spray
		- Added Lich King's Soul Shriek
		- Added Lich King's Shockwave
		- Added Saviana Ragefire's Flame Breath
		- Added Halion's Cleave
		- Added Halion's Flame Breath
		- Added Halion's Dark Breath
		- Added Halion's Tail Lash
		- Added Charscale Assaulter's Shockwave
		- Added Deathspeaker Zealot's Shadow Cleave
		- Added Lady Deathwhisper's Shadow Cleave
	v2.5.3
		- Added Lumbering Abomination's Vomit Spray
		- Added Spinestalker's Tail Sweep
		- Added Rimefang's Frost Breath
		- Added Sindragosa's Frost Breath
	
]]--

GTFO.SpellID["27812"] = {
	--desc = "Void Blast (Kel'thuzad)";
	sound = 3;
};

GTFO.SpellID["57581"] = {
	--desc = "Void Blast (OS 10)";
	sound = 3;
};

GTFO.SpellID["59128"] = {
	--desc = "Void Blast (OS 25)";
	sound = 3;
};

GTFO.SpellID["27812"] = {
	--desc = "Flame Tsunami (OS)";
	sound = 3;
	applicationOnly = true;
};


GTFO.SpellID["71944"] = {
	--desc = "Shock Vortex (Prince Valanar 10)";
	sound = 3;
};

GTFO.SpellID["72812"] = {
	--desc = "Shock Vortex (Prince Valanar 25)";
	sound = 3;
};

GTFO.SpellID["72813"] = {
	--desc = "Shock Vortex (Prince Valanar 10H)";
	sound = 3;
};

GTFO.SpellID["72814"] = {
	--desc = "Shock Vortex (Prince Valanar 25H)";
	sound = 3;
};

GTFO.SpellID["72814"] = {
	--desc = "Shock Vortex (Prince Valanar 25H)";
	sound = 3;
};

GTFO.SpellID["70853"] = {
	--desc = "Malleable Goo (Professor Putricide 10)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72458"] = {
	--desc = "Malleable Goo (Professor Putricide 25)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72873"] = {
	--desc = "Malleable Goo (Professor Putricide 10 Heroic)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72874"] = {
	--desc = "Malleable Goo (Professor Putricide 25 Heroic)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["71279"] = {
	--desc = "Choking Gas Explosion (Professor Putricide 10)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72459"] = {
	--desc = "Choking Gas Explosion (Professor Putricide 25)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72621"] = {
	--desc = "Choking Gas Explosion (Professor Putricide 10H)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72622"] = {
	--desc = "Choking Gas Explosion (Professor Putricide 25H)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["70702"] = {
	--desc = "Column of Frost (Valithria Dreamwalker - 10)";
	sound = 3;
};

GTFO.SpellID["71746"] = {
	--desc = "Column of Frost (Valithria Dreamwalker - 25)";
	sound = 3;
};

GTFO.SpellID["70744"] = {
	--desc = "Acid Burst (Valithria Dreamwalker - 10)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["71733"] = {
	--desc = "Acid Burst (Valithria Dreamwalker - 25)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["71077"] = {
	--desc = "Tail Smash (Sindragosa)";
	sound = 3;
};

GTFO.SpellID["71053"] = {
	--desc = "Frost Bomb (Sindragosa)";
	sound = 3;
};

GTFO.SpellID["70123"] = {
	--desc = "Blistering Cold (Sindragosa - 10)";
	sound = 3;
};

GTFO.SpellID["71047"] = {
	--desc = "Blistering Cold (Sindragosa - 25)";
	sound = 3;
};

GTFO.SpellID["71048"] = {
	--desc = "Blistering Cold (Sindragosa - 10H)";
	sound = 3;
};

GTFO.SpellID["71049"] = {
	--desc = "Blistering Cold (Sindragosa - 25H)";
	sound = 3;
};

GTFO.SpellID["70503"] = {
	--desc = "Spirit Burst (Lich King - 10)";
	sound = 3;
};

GTFO.SpellID["73806"] = {
	--desc = "Spirit Burst (Lich King - 25)";
	sound = 3;
};

GTFO.SpellID["73807"] = {
	--desc = "Spirit Burst (Lich King - 10H)";
	sound = 3;
};

GTFO.SpellID["73808"] = {
	--desc = "Spirit Burst (Lich King - 25H)";
	sound = 3;
};

GTFO.SpellID["66351"] = {
	--desc = "Mine Explosion (Mimiron 10)";
	sound = 3;
};

GTFO.SpellID["63009"] = {
	--desc = "Mine Explosion (Mimiron 25)";
	sound = 3;
};

GTFO.SpellID["69680"] = {
	--desc = "Gunship Explosion (Gunship Battle - 10 Normal)";
	sound = 3;
};

GTFO.SpellID["69687"] = {
	--desc = "Gunship Explosion (Gunship Battle - 25 Normal)";
	sound = 3;
};

GTFO.SpellID["69688"] = {
	--desc = "Gunship Explosion (Gunship Battle - 10 Heroic)";
	sound = 3;
};

GTFO.SpellID["69689"] = {
	--desc = "Gunship Explosion (Gunship Battle - 25 Heroic)";
	sound = 3;
};

GTFO.SpellID["69019"] = {
	--desc = "Explosive Barrage (Ick - Normal)";
	sound = 3;
};

GTFO.SpellID["70433"] = {
	--desc = "Explosive Barrage (Ick - Heroic)";
	sound = 3;
};

GTFO.SpellID["71377"] = {
	--desc = "Icy Blast (Rimefang - ICC 10)";
	sound = 3;
};

GTFO.SpellID["71378"] = {
	--desc = "Icy Blast (Rimefang - ICC 25)";
	sound = 3;
};

GTFO.SpellID["71544"] = {
	--desc = "Vengeful Blast (Lady Deathwhisper 10)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72010"] = {
	--desc = "Vengeful Blast (Lady Deathwhisper 25)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72011"] = {
	--desc = "Vengeful Blast (Lady Deathwhisper 10H)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72012"] = {
	--desc = "Vengeful Blast (Lady Deathwhisper 25H)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72549"] = {
	--desc = "Malleable Goo (Festergut 10H)";
	tankSound = 0;
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72550"] = {
	--desc = "Malleable Goo (Festergut 25H)";
	tankSound = 0;
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["69108"] = {
	--desc = "Ice Burst (Lich King 10)";
	sound = 3;
};

GTFO.SpellID["73773"] = {
	--desc = "Ice Burst (Lich King 25)";
	sound = 3;
};

GTFO.SpellID["73774"] = {
	--desc = "Ice Burst (Lich King 10H)";
	sound = 3;
};

GTFO.SpellID["73775"] = {
	--desc = "Ice Burst (Lich King 25H)";
	sound = 3;
};

GTFO.SpellID["73529"] = {
	--desc = "Shadow Trap (Lich King - Heroic)";
	sound = 3;
};

GTFO.SpellID["74648"] = {
	--desc = "Meteor Strike (Halion 10)";
	sound = 3;
};

GTFO.SpellID["75877"] = {
	--desc = "Meteor Strike (Halion 25)";
	sound = 3;
};

GTFO.SpellID["75878"] = {
	--desc = "Meteor Strike (Halion 10H)";
	sound = 3;
};

GTFO.SpellID["75879"] = {
	--desc = "Meteor Strike (Halion 25H)";
	sound = 3;
};

GTFO.SpellID["74769"] = {
	--desc = "Twilight Cutter (Halion 10)";
	tankSound = 1;
	sound = 3;
};

GTFO.SpellID["77844"] = {
	--desc = "Twilight Cutter (Halion 25)";
	tankSound = 1;
	sound = 3;
};

GTFO.SpellID["77845"] = {
	--desc = "Twilight Cutter (Halion 10H)";
	sound = 3;
};

GTFO.SpellID["77846"] = {
	--desc = "Twilight Cutter (Halion 25H)";
	sound = 3;
};

GTFO.SpellID["69055"] = {
	--desc = "Bone Slice (Lord Marrowgar 10)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["70814"] = {
	--desc = "Bone Slice (Lord Marrowgar 25)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["70633"] = {
	--desc = "Gut Spray (Valithria Dreamwalker 10)";
	tankSound = 0;
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["71283"] = {
	--desc = "Gut Spray (Valithria Dreamwalker 25)";
	tankSound = 0;
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72025"] = {
	--desc = "Gut Spray (Valithria Dreamwalker 10H)";
	tankSound = 0;
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["72026"] = {
	--desc = "Gut Spray (Valithria Dreamwalker 25H)";
	tankSound = 0;
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["69242"] = {
	--desc = "Soul Shriek (Lich King 10)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["73800"] = {
	--desc = "Soul Shriek (Lich King 25)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["73801"] = {
	--desc = "Soul Shriek (Lich King 10H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["73802"] = {
	--desc = "Soul Shriek (Lich King 25H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["72149"] = {
	--desc = "Shockwave (Lich King 10)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["73794"] = {
	--desc = "Shockwave (Lich King 25)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["73795"] = {
	--desc = "Shockwave (Lich King 10H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["73796"] = {
	--desc = "Shockwave (Lich King 25H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["74403"] = {
	--desc = "Flame Breath (Saviana Ragefire 10)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["74404"] = {
	--desc = "Flame Breath (Saviana Ragefire 25)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["74524"] = {
	--desc = "Cleave (Halion)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["74525"] = {
	--desc = "Flame Breath (Halion 10)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["74526"] = {
	--desc = "Flame Breath (Halion 10H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["74527"] = {
	--desc = "Flame Breath (Halion 25)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["74528"] = {
	--desc = "Flame Breath (Halion 25H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["74806"] = {
	--desc = "Dark Breath (Halion 10)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["75954"] = {
	--desc = "Dark Breath (Halion 10H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["75955"] = {
	--desc = "Dark Breath (Halion 25)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["75956"] = {
	--desc = "Dark Breath (Halion 25H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["74531"] = {
	--desc = "Tail Lash (Halion)";
	sound = 3;
};

GTFO.SpellID["75418"] = {
	--desc = "Shockwave (Charscale Assaulter)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["69492"] = {
	--desc = "Shadow Cleave (Deathspeaker Zealot, ICC)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["70670"] = {
	--desc = "Shadow Cleave (Lady Deathwhisper 10)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["72006"] = {
	--desc = "Shadow Cleave (Lady Deathwhisper 25)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["72493"] = {
	--desc = "Shadow Cleave (Lady Deathwhisper 10H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["72494"] = {
	--desc = "Shadow Cleave (Lady Deathwhisper 25H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["70176"] = {
	--desc = "Vomit Spray (Lumbering Abomination, HoR)";
	tankSound = 0;
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["70181"] = {
	--desc = "Vomit Spray (Lumbering Abomination, HoR Heroic)";
	tankSound = 0;
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["71369"] = {
	--desc = "Tail Sweep (Spinestalker, ICC 10)";
	sound = 3;
};

GTFO.SpellID["71370"] = {
	--desc = "Tail Sweep (Spinestalker, ICC 25)";
	sound = 3;
};

GTFO.SpellID["71386"] = {
	--desc = "Frost Breath (Rimefang, ICC 25)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["69649"] = {
	--desc = "Frost Breath P1 (Sindragosa, ICC 10)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["73061"] = {
	--desc = "Frost Breath P2 (Sindragosa, ICC 10)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["71056"] = {
	--desc = "Frost Breath P1 (Sindragosa, ICC 25)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["73062"] = {
	--desc = "Frost Breath P2 (Sindragosa, ICC 25)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["71057"] = {
	--desc = "Frost Breath P1 (Sindragosa, ICC 10H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["73063"] = {
	--desc = "Frost Breath P2 (Sindragosa, ICC 10H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["71058"] = {
	--desc = "Frost Breath P1 (Sindragosa, ICC 25H)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["73064"] = {
	--desc = "Frost Breath P2 (Sindragosa, ICC 25H)";
	tankSound = 0;
	sound = 3;
};
