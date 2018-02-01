--------------------------------------------------------------------------
-- GTFO_Spells_CAT.lua 
--------------------------------------------------------------------------
--[[
GTFO Spell List - Cataclysm (New areas)
Author: Zensunim of Malygos

Change Log:
	v2.3
		- Added Core Puppy's Lava Drool
		- Added Zin'jatar Pearlbender's Foul Waters
		- Added Naz'jar Sentinel's Noxious Mire
		- Added Commander Ulthok's Dark Fissure (Residual)
		- Added Facelace Watcher's Ground Pound
		- Added Erunak Stonespeaker's Earth Shards
		- Added Mindbender Ghur'sha's Mind Fog
		- Added Blight Beast's Aura of Dread
		- Added Ozumat's Blight of Ozumat
	v2.4
		- Added Corborus's Crystal Barrage
		- Added Stonecore Berserker's Spinning Slash
		- Added Stonecore Flayer's Flay
		- Added Slabhide's Lava Pool
		- Added High Priestess Azil's Gravity Well
	v2.5
		- Split spell files into sections
		- Added Twilight Flame Caller's Fire Strike 
		- Added Core Puppy's Little Big Flame Breath
		- Added Twilight Element Warden's Frostbomb
		- Added Asaad's Supremacy of the Storm
		- Added Armored Mistral's Whirlwind
		- Added Cloud Prince's Starfall
		- Added Turbulent Squall's Hurricane
		- Added Titanic Guardian's Burning Gaze
	v2.5.1
		- Added Twilight Drake's Twilight Flames
		- Added Forgemaster Throngus's Cave In
		- Added Ascended Rockbreaker's Fissure
		- Added Erudax's Shadow Gale
	v2.5.2
		- Added Temple Guardian Anhuur's Burning Light
		- Added Fire Warden's Raging Inferno
		- Added Anraphet's Alpha Beams
		- Added Earthrager Ptah's Quicksand
		- Added Isisit's Energy Flux
		- Added Budding Spores' Noxious Spores
		- Added Setesh's Chaos Burn
		- Added Setesh's Reign of Chaos
		- Added Core Puppy's Lava Drool (Heroic)
		- Added Naz'jar Sentinel's Noxious Mire (Heroic)
		- Added Commander Ulthok's Dark Fissure (Residual, Heroic)
		- Added Facelace Watcher's Ground Pound (Heroic)
		- Added Erunak Stonespeaker's Earth Shards (Heroic)
		- Added Ozumat's Blight of Ozumat (Heroic)
		- Added Corborus's Crystal Barrage (Heroic)
		- Added Stonecore Berserker's Spinning Slash (Heroic)
		- Added Slabhide's Lava Pool (Heroic)
		- Added Twilight Flame Caller's Fire Strike (Heroic)
		- Added Core Puppy's Little Big Flame Breath (Heroic)
		- Added Twilight Element Warden's Frostbomb (Heroic)
		- Updated Armored Mistral's Storm Surge
		- Added Asaad's Supremacy of the Storm (Heroic)
		- Added Cloud Prince's Starfall (Heroic)
		- Added Turbulent Squall's Hurricane (Heroic)
		- Added Twilight Drake's Twilight Flames (Heroic)
		- Added Forgemaster Throngus's Cave In (Heroic)
		- Added Ascended Rockbreaker's Fissure (Heroic)
		- Added Erudax's Shadow Gale (Heroic)
		- Added Oathsworn Captain's Earthquake
		- Added High Prophet Barim's Heaven's Fury
		- Added High Prophet Barim's Hallowed Ground
	v2.5.3
		- Added Drahga Shadowburner's Seeping Twilight
		- Updated Setesh's Chaos Burn
		- Added Vanessa VanCleef's Spark
		- Added Captain Cookie's Rotten Aura (Heroic)
		- Added Foe Reaper 5000's Overdrive (Heroic)
		- Added Glubtok's Fire Wall (Heroic)
		- Added Commander Springvale's Desecration (Heroic)
		- Added Commander Springvale's Shield of the Perfidious (Heroic)
		- Added Grand Vizier Ertan's Storm's Edge

]]--

GTFO.SpellID["76628"] = {
	--desc = "Lava Drool (Blackrock Caverns)";
	sound = 1;
};

GTFO.SpellID["93666"] = {
	--desc = "Lava Drool (Blackrock Caverns, Heroic)";
	sound = 1;
};

GTFO.SpellID["79411"] = {
	--desc = "Foul Waters (Vashj'ir)";
	sound = 2;
};

GTFO.SpellID["76776"] = {
	--desc = "Noxious Mire (Throne of the Tides)";
	sound = 1;
};

GTFO.SpellID["91446"] = {
	--desc = "Noxious Mire (Throne of the Tides, Heroic)";
	sound = 1;
};

GTFO.SpellID["76085"] = {
	--desc = "Dark Fissure (Residual, Throne of the Tides)";
	sound = 1;
};

GTFO.SpellID["91375"] = {
	--desc = "Dark Fissure (Residual, Throne of the Tides Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["76593"] = {
	--desc = "Ground Pound (Throne of the Tides)";
	sound = 1;
};

GTFO.SpellID["91468"] = {
	--desc = "Ground Pound (Throne of the Tides, Heroic)";
	sound = 1;
};

GTFO.SpellID["84945"] = {
	--desc = "Earth Shards (Throne of the Tides)";
	sound = 1;
};

GTFO.SpellID["91491"] = {
	--desc = "Earth Shards (Throne of the Tides, Heroic)";
	sound = 1;
};

GTFO.SpellID["76230"] = {
	--desc = "Mind Fog (Throne of the Tides)";
	sound = 1;
};

GTFO.SpellID["83971"] = {
	--desc = "Aura of Dread (Throne of the Tides)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["83561"] = {
	--desc = "Blight of Ozumat (Throne of the Tides)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["91495"] = {
	--desc = "Blight of Ozumat (Throne of the Tides, Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["86881"] = {
	--desc = "Crystal Barrage (Stonecore)";
	sound = 1;
};

GTFO.SpellID["92648"] = {
	--desc = "Crystal Barrage (Stonecore, Heroic)";
	sound = 1;
};

GTFO.SpellID["81569"] = {
	--desc = "Spinning Slash (Stonecore)";
	tankSound = 2;
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["92623"] = {
	--desc = "Spinning Slash (Stonecore, Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["79923"] = {
	--desc = "Flay (Stonecore)";
	tankSound = 0;
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["80801"] = {
	--desc = "Lava Pool (Stonecore)";
	sound = 1;
};

GTFO.SpellID["92658"] = {
	--desc = "Lava Pool (Stonecore, Heroic)";
	sound = 1;
};

GTFO.SpellID["79249"] = {
	--desc = "Gravity Well (Stonecore)";
	sound = 1;
};

GTFO.SpellID["76328"] = {
	--desc = "Fire Strike (Blackrock Caverns)";
	tankSound = 2;
	sound = 1;
};

GTFO.SpellID["93646"] = {
	--desc = "Fire Strike (Blackrock Caverns, Heroic)";
	sound = 1;
};

GTFO.SpellID["76665"] = {
	--desc = "Little Big Flame Breath (Blackrock Caverns)";
	tankSound = 0;
	sound = 1;
};

GTFO.SpellID["93667"] = {
	--desc = "Little Big Flame Breath (Blackrock Caverns, Heroic)";
	tankSound = 0;
	sound = 1;
};

GTFO.SpellID["76682"] = {
	--desc = "Frostbomb (Blackrock Caverns)";
	sound = 2;
};

GTFO.SpellID["93651"] = {
	--desc = "Frostbomb (Blackrock Caverns, Heroic)";
	sound = 2;
};

GTFO.SpellID["88056"] = {
	--desc = "Storm Surge (Vortex Pinnacle)";
	tankSound = 0;
	sound = 2;
};

GTFO.SpellID["87553"] = {
	--desc = "Supremacy of the Storm (Asaad, Vortex Pinnacle)";
	sound = 1;
};

GTFO.SpellID["93994"] = {
	--desc = "Supremacy of the Storm (Asaad, Vortex Pinnacle Heroic)";
	sound = 1;
};

GTFO.SpellID["88073"] = {
	--desc = "Starfall (Cloud Prince, Vortex Pinnacle)";
	sound = 2;
};

GTFO.SpellID["92783"] = {
	--desc = "Starfall (Cloud Prince, Vortex Pinnacle Heroic)";
	sound = 2;
};

GTFO.SpellID["88171"] = {
	--desc = "Hurricane (Turbulent Squall, Vortex Pinnacle)";
	sound = 2;
};

GTFO.SpellID["92773"] = {
	--desc = "Hurricane (Turbulent Squall, Vortex Pinnacle Heroic)";
	sound = 2;
};

GTFO.SpellID["87660"] = {
	--desc = "Burning Gaze (Titanic Guardian, Uldum)";
	sound = 1;
};

GTFO.SpellID["75939"] = {
	--desc = "Twilight Flames (Twilight Drake, Grim Batol)";
	sound = 1;
};

GTFO.SpellID["90876"] = {
	--desc = "Twilight Flames (Twilight Drake, Grim Batol Heroic)";
	sound = 1;
};

GTFO.SpellID["74986"] = {
	--desc = "Cave In (Forgemaster Throngus, Grim Batol)";
	sound = 1;
};

GTFO.SpellID["90722"] = {
	--desc = "Cave In (Forgemaster Throngus, Grim Batol Heroic)";
	sound = 1;
};

GTFO.SpellID["76786"] = {
	--desc = "Fissure (Ascended Rockbreaker, Grim Batol)";
	sound = 1;
};

GTFO.SpellID["90863"] = {
	--desc = "Fissure (Ascended Rockbreaker, Grim Batol Heroic)";
	sound = 1;
};

GTFO.SpellID["75692"] = {
	--desc = "Shadow Gale (Erudax, Grim Batol)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["91087"] = {
	--desc = "Shadow Gale (Erudax, Grim Batol)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["75117"] = {
	--desc = "Burning Light (Temple Guardian Anhuur, Halls of Origination)";
	sound = 1;
};

GTFO.SpellID["77262"] = {
	--desc = "Raging Inferno (Fire Warden, Halls of Origination)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["91159"] = {
	--desc = "Raging Inferno (Fire Warden, Halls of Origination Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["76956"] = {
	--desc = "Alpha Beams (Anraphet, Halls of Origination)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["91177"] = {
	--desc = "Alpha Beams (Anraphet, Halls of Origination Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["75547"] = {
	--desc = "Quicksand (Earthrager Ptah, Halls of Origination)";
	sound = 1;
};

GTFO.SpellID["89880"] = {
	--desc = "Quicksand (Earthrager Ptah, Halls of Origination Heroic)";
	sound = 1;
};

GTFO.SpellID["74045"] = {
	--desc = "Energy Flux (Isisit, Halls of Origination)";
	sound = 1;
};

GTFO.SpellID["89861"] = {
	--desc = "Energy Flux (Isisit, Halls of Origination Heroic)";
	sound = 1;
};

GTFO.SpellID["75702"] = {
	--desc = "Noxious Spores (Budding Spore, Halls of Origination)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["89889"] = {
	--desc = "Noxious Spores (Budding Spore, Halls of Origination Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["76684"] = {
	--desc = "Chaos Burn (Setesh, Halls of Origination)";
	sound = 1;
};

GTFO.SpellID["89874"] = {
	--desc = "Chaos Burn (Setesh, Halls of Origination Heroic)";
	sound = 1;
};

GTFO.SpellID["77030"] = {
	--desc = "Reign of Chaos (Setesh, Halls of Origination)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["89872"] = {
	--desc = "Reign of Chaos (Setesh, Halls of Origination Heroic)";
	sound = 1;
	applicationOnly = true;
};

GTFO.SpellID["84251"] = {
	--desc = "Earthquake (Oathsworn Captain, Lost City)";
	sound = 1;
};

GTFO.SpellID["90017"] = {
	--desc = "Earthquake (Oathsworn Captain, Lost City Heroic)";
	sound = 1;
};

GTFO.SpellID["81942"] = {
	--desc = "Heaven's Fury (High Prophet Barim, Lost City)";
	sound = 1;
};

GTFO.SpellID["90040"] = {
	--desc = "Heaven's Fury (High Prophet Barim, Lost City Heroic)";
	sound = 1;
};

GTFO.SpellID["88814"] = {
	--desc = "Hallowed Ground (High Prophet Barim, Lost City)";
	sound = 1;
};

GTFO.SpellID["90010"] = {
	--desc = "Hallowed Ground (High Prophet Barim, Lost City)";
	sound = 1;
};

GTFO.SpellID["75317"] = {
	--desc = "Seeping Twilight (Drahga Shadowburner, Grim Batol)";
	sound = 1;
};

GTFO.SpellID["90964"] = {
	--desc = "Seeping Twilight (Drahga Shadowburner, Grim Batol Heroic)";
	sound = 1;
};

GTFO.SpellID["92278"] = {
	--desc = "Spark (Vanessa VanCleef, Deadmines Heroic)";
	sound = 1;
};

GTFO.SpellID["92065"] = {
	--desc = "Rotten Aura (Captain Cookie, Deadmines Heroic)";
	sound = 1;
};

GTFO.SpellID["91716"] = {
	--desc = "Overdrive (Foe Reaper 5000, Deadmines Heroic)";
	sound = 1;
};

GTFO.SpellID["91397"] = {
	--desc = "Fire Wall (Glubtok, Deadmines Heroic)";
	sound = 1;
};

GTFO.SpellID["94370"] = {
	--desc = "Desecration (Commander Springvale, Shadowfang Keep Heroic)";
	sound = 1;
};

GTFO.SpellID["93737"] = {
	--desc = "Shield of the Perfidious (Commander Springvale, Shadowfang Keep Heroic)";
	tankSound = 0;
	sound = 1;
};

GTFO.SpellID["86309"] = {
	--desc = "Storm's Edge (Grand Vizier Ertan, Vortex Pinnacle)";
	sound = 1;
	test = true;
};

GTFO.SpellID["93992"] = {
	--desc = "Storm's Edge (Grand Vizier Ertan, Vortex Pinnacle)";
	sound = 1;
	test = true;
};
