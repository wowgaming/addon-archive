local WIM = WIM;

-- imports
local _G = _G;
local table = table;
local type = type;
local string = string;
local pairs = pairs;

-- set namespace
setfenv(1, WIM);


constants.classes = {};
local classes = constants.classes;

local classList = {
     "Druid", "Hunter", "Mage", "Paladin", "Priest", "Rogue",
     "Shaman", "Warlock", "Warrior",  "Death Knight"
};

constants.classListEng = classList;

--Male Classes - this doesn't apply to every locale
classes[L["Druid"]]	= {
                              color = "ff7d0a",
                              tag = "DRUID",
                              talent = {L["Balance"], L["Feral Combat"], L["Restoration"]}
                         };
classes[L["Hunter"]]	= {
                              color = "abd473",
                              tag = "HUNTER",
                              talent = {L["Beast Mastery"], L["Marksmanship"], L["Survival"]}
                         };
classes[L["Mage"]]	= {
                              color = "69ccf0",
                              tag = "MAGE",
                              talent = {L["Arcane"], L["Fire"], L["Frost"]}
                         };
classes[L["Paladin"]]	= {
                              color = "f58cba",
                              tag = "PALADIN",
                              talent = {L["Holy"], L["Protection"], L["Retribution"]}
                         };
classes[L["Priest"]]	= {
                              color = "ffffff",
                              tag = "PRIEST",
                              talent = {L["Discipline"], L["Holy"], L["Shadow"]}
                         };
classes[L["Rogue"]]	= {
                              color = "fff569",
                              tag = "ROGUE",
                              talent = {L["Assassination"], L["Combat"], L["Subtlety"]}
                         };
classes[L["Shaman"]]	= {
                              color = "2459FF",
                              tag = "SHAMAN",
                              talent = {L["Elemental"], L["Enhancement"], L["Restoration"]}
                         };
classes[L["Warlock"]]	= {
                              color = "9482ca",
                              tag = "WARLOCK",
                              talent = {L["Affliction"], L["Demonology"], L["Destruction"]}
                         };
classes[L["Warrior"]]	= {
                              color = "c79c6e",
                              tag = "WARRIOR",
                              talent = {L["Arms"], L["Fury"], L["Protection"]}
                         };
classes[L["Death Knight"]] = {
                              color = "c41f3b",
                              tag = "DEATHKNIGHT",
                              talent = {L["Blood"], L["Frost"], L["Unholy"]}
                         };
classes[L["Game Master"]] = {
                              color = "00c0ff",
                              tag = "GM",
                              talent = {"", "", ""} -- talent place holder
                         };

-- propigate female class types and update tags appropriately
local i;
for i=1, table.getn(classList) do
     if(L[classList[i]] ~= L[classList[i].."F"]) then
          classes[L[classList[i].."F"]] = {
               color = classes[L[classList[i]]].color,
               tag = classes[L[classList[i]]].tag.."F"
          };
     end
end


classes.GetClassByTag = function(t)
     for class, tbl in pairs(classes) do
          if(type(tbl) == "table") then
               if(tbl.tag == t) then
                    return class;
               end
          end
     end
     -- can't find tag, before returning blank, see we're being asked for a female class, then try again.
     local ft = string.gsub(t, "(F)$", "");
     if( ft == t) then
          return ""
     else
          return classes.GetClassByTag(ft);
     end
end

function classes.GetMyColoredName()
     local name = _G.UnitName("player");
     local class, englishClass = _G.UnitClass("player");
     local classColorTable = _G.RAID_CLASS_COLORS[englishClass];
     return string.format("\124cff%.2x%.2x%.2x", classColorTable.r*255, classColorTable.g*255, classColorTable.b*255)..name.."\124r"
end

function classes.GetColoredNameByChatEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
     if(arg12 and arg12 ~= "") then
          local localizedClass, englishClass, localizedRace, englishRace, sex = _G.GetPlayerInfoByGUID(arg12)
          if ( englishClass ) then
               local classColorTable = _G.RAID_CLASS_COLORS[englishClass];
               if ( not classColorTable ) then
                    return arg2;
               end
               return string.format("\124cff%.2x%.2x%.2x", classColorTable.r*255, classColorTable.g*255, classColorTable.b*255)..arg2.."\124r"
          else
               return arg2;
          end
    else
          return arg2;
    end
end
