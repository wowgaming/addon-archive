QuestHelper_File["collect_spec.lua"] = "1.4.1"
QuestHelper_Loadtime["collect_spec.lua"] = GetTime()

local Bitstream

local classlookup = {
  ["DEATHKNIGHT"] = "K",
  ["DRUID"] = "D",
  ["HUNTER"] = "H",
  ["MAGE"] = "M",
  ["PALADIN"] = "N",
  ["PRIEST"] = "P",
  ["ROGUE"] = "R",
  ["SHAMAN"] = "S",
  ["WARLOCK"] = "L",
  ["WARRIOR"] = "W"
};

local racelookup = {
  ["Draenei"] = "R",
  ["Gnome"] = "G",
  ["Dwarf"] = "D",
  ["Human"] = "H",
  ["NightElf"] = "E",
  
  ["Orc"] = "O",
  ["Troll"] = "T",
  ["Tauren"] = "N",
  ["Undead"] = "U",
  ["BloodElf"] = "B",
  -- lol i spelled nub
}

local function GetSpecBolus()
  local _, id = UnitClass("player")
  local level = UnitLevel("player")
  local _, race = UnitRace("player")
  
  --[[ assert(racelookup[race]) ]]
  
  local bso = Bitstream.Output(8)
  
  for t = 1, GetNumTalentTabs() do -- come on. Is this ever not going to be 3? Seriously?
    for ta = 1, GetNumTalents(t) do
      local _, _, _, _, rank, _ = GetTalentInfo(t, ta)
      bso:append(rank, 3)
    end
    bso:append(6, 3)  -- no 6-point talents, so we use this as an end-of-tree market
  end
  bso:append(7, 3) -- end-of-spec! because of *all of those 4-tree classes*
  
  return string.format("2%s%s%02d", classlookup[id], racelookup[race] or "", level) .. bso:finish()
end

function QH_Collect_Spec_Init(_, API)
  Bitstream = API.Utility_Bitstream
  QuestHelper: Assert(Bitstream)
  
  API.Utility_GetSpecBolus = GetSpecBolus
end
