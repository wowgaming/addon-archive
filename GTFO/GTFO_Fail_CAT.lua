--------------------------------------------------------------------------
-- GTFO_Fail_CAT.lua 
--------------------------------------------------------------------------
--[[
GTFO Fail List - Cataclysm (New areas)
Author: Zensunim of Malygos

Change Log:
	v2.3
		- Added Lady Naz'jar's Fungal Spores
		- Added Commander Ulthok's Dark Fissure (Impact)
		- Added Erunak Stonespeaker's Magma Splash
		- Added Stonecore's Stalactite
	v2.4
		- Added Slabhide's Sand Blast
		- Added Stonecore Bruiser's Shockwave
		- Added Ozruk's Ground Slam
		- Added High Priestess Azil's Seismic Shard
	v2.5
		- Split spell files into sections
		- Added Rom'ogg Bonecrusher's Skullcracker
		- Added Rom'ogg Bonecrusher's Ground Rupture
		- Added Karsh Steelbender's Lava Spout
		- Added Young Storm Dragon's Chilling Blast
		- Added Titanic Guardian's Meteor Blast
		- Added Titanic Guardian's Blazing Eruption
	v2.5.1
		- Added Highbank's Artillery Barrage
		- Added Dragonmaw Hold's Blade Strike
		- Added Servias Windterror's Static Flux Detonation
		- Added Obsidian Stoneslave's Rupture Line
		- Added Bloodgorged Ettin's Log Smash
		- Added General Umbriss's Ground Siege
		- Added Twilight Drake's Twilight Breath
		- Added Erudax's Binding Shadows
		- Fixed Young Strom Dragon's Chilling Blast
		- Added Karsh Steelbender's Lava Spout (Heroic)
		- Added Young Storm Dragon's Chilling Blast (Heroic)
	v2.5.2
		- Added Water Warden's Aqua Bomb
		- Added Air Warden's Whirling Winds
		- Added Earth Warden's Rockwave
		- Added Rajh's Solar Winds
		- Added Lady Naz'jar's Fungal Spores (Heroic)
		- Added Stonecore's Stalactite (Heroic)
		- Added Stonecore's Crystal Shards (Heroic)
		- Added Stonecore's Magma Eruption (Heroic)
		- Added Slabhide's Sand Blast (Heroic)
		- Added Stonecore Bruiser's Shockwave (Heroic)
		- Added Ozruk's Ground Slam (Heroic)
		- Added High Priestess Azil's Seismic Shard (Heroic)
		- Added General Husam's Shockwave
		- Added General Husam's Mystic Trap
		- Added Siamat's Cloud Burst
	v2.5.3
		- Added Invoked Flaming Spirit's Supernova
		- Added Foe Reaper 5000's Reaper Strike (Heroic)
		- Added Defias Watcher's Cleave (Heroic)
]]--

GTFO.SpellID["80564"] = {
	--desc = "Fungal Spores (Throne of the Tides)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["91470"] = {
	--desc = "Fungal Spores (Throne of the Tides Heroic)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["76047"] = {
	--desc = "Dark Fissure (Impact, Throne of the Tides)";
	sound = 3;
};

GTFO.SpellID["76170"] = {
	--desc = "Magma Splash (Throne of the Tides)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["80643"] = {
	--desc = "Stalactite (Stonecore)";
	sound = 3;
};

GTFO.SpellID["92653"] = {
	--desc = "Stalactite (Stonecore, Heroic)";
	sound = 3;
};

GTFO.SpellID["80913"] = {
	--desc = "Crystal Shards (Stonecore)";
	sound = 3;
};

GTFO.SpellID["92122"] = {
	--desc = "Crystal Shards (Stonecore, Heroic)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["80052"] = {
	--desc = "Magma Eruption (Stonecore)";
	sound = 3;
};

GTFO.SpellID["92634"] = {
	--desc = "Magma Eruption (Stonecore, Heroic)";
	sound = 3;
};

GTFO.SpellID["80807"] = {
	--desc = "Sand Blast (Stonecore)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["92656"] = {
	--desc = "Sand Blast (Stonecore, Heroic)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["80195"] = {
	--desc = "Shockwave (Stonecore)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["92640"] = {
	--desc = "Shockwave (Stonecore, Heroic)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["78903"] = {
	--desc = "Ground Slam (Stonecore)";
	sound = 3;
};

GTFO.SpellID["92410"] = {
	--desc = "Ground Slam (Stonecore, Heroic)";
	sound = 3;
};

GTFO.SpellID["79021"] = {
	--desc = "Seismic Shard (Stonecore)";
	sound = 3;
};

GTFO.SpellID["92665"] = {
	--desc = "Seismic Shard (Stonecore, Heroic)";
	sound = 3;
};

GTFO.SpellID["75428"] = {
	--desc = "The Skullcracker (Rom'ogg Bonecrusher, Blackrock Caverns)";
	sound = 3;
};

GTFO.SpellID["93454"] = {
	--desc = "The Skullcracker (Rom'ogg Bonecrusher, Blackrock Caverns Heroic)";
	sound = 3;
};

GTFO.SpellID["75347"] = {
	--desc = "Ground Rupture (Rom'ogg Bonecrusher, Blackrock Caverns)";
	sound = 3;
	test = true;
};

GTFO.SpellID["93459"] = {
	--desc = "Ground Rupture (Rom'ogg Bonecrusher, Blackrock Caverns Heroic)";
	sound = 3;
	test = true;
};

GTFO.SpellID["76007"] = {
	--desc = "Lava Spout (Karsh Steelbender, Blackrock Caverns)";
	sound = 3;
};

GTFO.SpellID["93565"] = {
	--desc = "Lava Spout (Karsh Steelbender, Blackrock Caverns Heroic)";
	sound = 3;
};

GTFO.SpellID["88194"] = {
	--desc = "Chilling Blast (Young Storm Dragon, Vortex Pinnacle)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["92759"] = {
	--desc = "Chilling Blast (Young Storm Dragon, Vortex Pinnacle Heroic)";
	tankSound = 0;
	sound = 3;
};

GTFO.SpellID["87701"] = {
	--desc = "Meteor Blast (Titanic Guardian, Uldum)";
	sound = 3;
};

GTFO.SpellID["87755"] = {
	--desc = "Blazing Eruption (Titanic Guardian, Uldum)";
	sound = 3;
};

GTFO.SpellID["84864"] = {
	--desc = "Artillery Barrage (Highbank, Twilight Highlands)";
	sound = 3;
};

GTFO.SpellID["84834"] = {
	--desc = "Blade Strike (Dragonmaw Hold, Twilight Highlands)";
	sound = 3;
};

GTFO.SpellID["88208"] = {
	--desc = "Static Flux Detonation (Servias Windterror, Twilight Highlands)";
	sound = 3;
};

GTFO.SpellID["89936"] = {
	--desc = "Rupture Line (Obsidian Stoneslave, Twilight Highlands)";
	sound = 3;
};

GTFO.SpellID["88421"] = {
	--desc = "Log Smash (Bloodgorged Ettin, Twilight Highlands)";
	sound = 3;
};

GTFO.SpellID["74634"] = {
	--desc = "Ground Siege (General Umbriss, Grim Batol)";
	sound = 3;
};

GTFO.SpellID["90249"] = {
	--desc = "Ground Siege (General Umbriss, Grim Batol Heroic)";
	sound = 3;
};

GTFO.SpellID["76817"] = {
	--desc = "Twilight Breath (Twilight Drake, Grim Batol)";
	sound = 3;
	tankSound = 0;
};

GTFO.SpellID["90875"] = {
	--desc = "Twilight Breath (Twilight Drake, Grim Batol Heroic)";
	sound = 3;
	tankSound = 0;
};

GTFO.SpellID["75861"] = {
	--desc = "Binding Shadows (Erudax, Grim Batol)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["91079"] = {
	--desc = "Binding Shadows (Erudax, Grim Batol Heroic)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["77351"] = {
	--desc = "Aqua Bomb (Water Warden, Halls of Origination)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["91157"] = {
	--desc = "Aqua Bomb (Water Warden, Halls of Origination Heroic)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["77333"] = {
	--desc = "Whirling Winds (Air Warden, Halls of Origination)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["91153"] = {
	--desc = "Whirling Winds (Air Warden, Halls of Origination Heroic)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["77234"] = {
	--desc = "Rockwave (Earth Warden, Halls of Origination)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["91162"] = {
	--desc = "Rockwave (Earth Warden, Halls of Origination Heroic)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["74108"] = {
	--desc = "Solar Winds (Rajh, Halls of Origination)";
	sound = 3;
};

GTFO.SpellID["89130"] = {
	--desc = "Solar Winds (Rajh, Halls of Origination Heroic)";
	sound = 3;
};

GTFO.SpellID["83454"] = {
	--desc = "Shockwave (General Husam, Lost City)";
	sound = 3;
};

GTFO.SpellID["83454"] = {
	--desc = "Shockwave (General Husam, Lost City)";
	sound = 3;
};

GTFO.SpellID["90029"] = {
	--desc = "Shockwave (General Husam, Lost City Heroic)";
	sound = 3;
};

GTFO.SpellID["83171"] = {
	--desc = "Mystic Trap (General Husam, Lost City)";
	sound = 3;
};

GTFO.SpellID["91259"] = {
	--desc = "Mystic Trap (General Husam, Lost City Heroic)";
	sound = 3;
};

GTFO.SpellID["83051"] = {
	--desc = "Cloud Burst (Siamat, Lost City)";
	sound = 3;
};

GTFO.SpellID["90032"] = {
	--desc = "Cloud Burst (Siamat, Lost City Heroic)";
	sound = 3;
};

GTFO.SpellID["75238"] = {
	--desc = "Supernova (Invoked Flaming Spirit, Grim Batol)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["90972"] = {
	--desc = "Supernova (Invoked Flaming Spirit, Grim Batol Heroic)";
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["91717"] = {
	--desc = "Reaper Strike (Foe Reaper 5000, Deadmine Heroic)";
	tankSound = 0;
	sound = 3;
	applicationOnly = true;
};

GTFO.SpellID["90981"] = {
	--desc = "Cleave (Defias Watcher, Deadmine Heroic)";
	tankSound = 0;
	sound = 3;
	applicationOnly = true;
};

