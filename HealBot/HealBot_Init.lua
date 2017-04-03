local i=nil
local HB_mana=nil
local HB_cast=nil
local HB_HealsMin=nil
local HB_HealsMax=nil
local HB_HealsExt=nil
local HB_duration=nil
local HB_range=nil
local HB_shield=nil
local HB_channel=nil
local tmpText=nil
local line=nil
local tmpTest=nil
local tmpTest2=nil
local hbHealsMin=nil
local hbHealsMax=nil
local spell=nil
local spellrank=nil
local line1=nil
local line2=nil
local line3=nil
local SmartCast_Res=nil;
local HealBot_Spec = {}
local TempSkins = {}
local tonumber=tonumber
local strfind=strfind
local floor=floor
local strsub=strsub

function HealBot_Init_retSmartCast_Res()
    return SmartCast_Res
end

function HealBot_Init_SetSpec()
HealBot_Spec = {
    ["DRUI"] = { [1] = HEALBOT_BALANCE,       [2] = HEALBOT_FERAL,        [3] = HEALBOT_RESTORATION, },
    ["MAGE"] = { [1] = HEALBOT_ARCANE,        [2] = HEALBOT_FIRE,         [3] = HEALBOT_FROST,       },
    ["PRIE"] = { [1] = HEALBOT_DISCIPLINE,    [2] = HEALBOT_HOLY,         [3] = HEALBOT_SHADOW,      },
    ["ROGU"] = { [1] = HEALBOT_ASSASSINATION, [2] = HEALBOT_COMBAT,       [3] = HEALBOT_SUBTLETY,    },
    ["WARR"] = { [1] = HEALBOT_ARMS,          [2] = HEALBOT_FURY,         [3] = HEALBOT_PROTECTION,  },
    ["HUNT"] = { [1] = HEALBOT_BEASTMASTERY,  [2] = HEALBOT_MARKSMANSHIP, [3] = HEALBOT_SURVIVAL,    },
    ["PALA"] = { [1] = HEALBOT_HOLY,          [2] = HEALBOT_PROTECTION,   [3] = HEALBOT_RETRIBUTION, },
    ["SHAM"] = { [1] = HEALBOT_ELEMENTAL,     [2] = HEALBOT_ENHANCEMENT,  [3] = HEALBOT_SHAMAN_RESTORATION, },
    ["WARL"] = { [1] = HEALBOT_AFFLICTION,    [2] = HEALBOT_DEMONOLOGY,   [3] = HEALBOT_DESTRUCTION, },
    ["DEAT"] = { [1] = HEALBOT_BLOOD,         [2] = HEALBOT_FROST,        [3] = HEALBOT_UNHOLY, },
    }
end

function HealBot_Init_retSpec(class,tab)
    if HealBot_Spec[class] and HealBot_Spec[class][tab] then
        return HealBot_Spec[class][tab]
    end
    return nil
end

function HealBot_InitGetSpellData(spell, id, class, spellname)

    if ( not spell ) then return end
  
    HB_cast=nil
    HB_mana=nil
    HB_range=nil
    HB_HealsMin=nil
    HB_HealsMax=nil
    HB_HealsExt=nil
    HB_duration=nil
    HB_shield=nil
    HB_channel=nil
    
   -- name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange 
    _, _, _, HB_mana, _, _, HB_cast, _, HB_range = GetSpellInfo(spell)

    if HB_cast then HB_cast=HB_cast/1000 end
   
    HealBot_TooltipInit();
    HealBot_ScanTooltip:SetSpell( id, BOOKTYPE_SPELL );
    tmpText = _G["HealBot_ScanTooltipTextLeft2"];
    if (tmpText:GetText()) and not HB_mana then
        line = tmpText:GetText();
        tmpTest,tmpTest,HB_mana = strfind(line, HB_TOOLTIP_MANA ); 
    end

    tmpText = _G["HealBot_ScanTooltipTextRight2"];
    if (tmpText:GetText()) and not HB_range then
        line = tmpText:GetText();
        tmpTest,tmpTest,HB_range = strfind(line, HB_TOOLTIP_RANGE ); 
    else
        HB_range="30";
    end  

    tmpText = _G["HealBot_ScanTooltipTextLeft3"];
    if (tmpText:GetText()) then
        line = tmpText:GetText();
        if ( line == HB_TOOLTIP_INSTANT_CAST ) then
            HB_cast = 0;
        elseif line == HB_TOOLTIP_CHANNELED then
            HB_cast = 0;
        elseif ( tmpText ) then
            tmpTest,tmpTest,HB_cast = strfind(line, HB_TOOLTIP_CAST_TIME ); 
        end
    end  

    tmpText = _G["HealBot_ScanTooltipTextLeft4"];
    tmpTest = nil;
    if (tmpText:GetText()) then
        line = tmpText:GetText();
        if strsub(class,1,4)=="PRIE" then
            if spellname==HEALBOT_POWER_WORD_SHIELD then
                tmpTest,tmpTest,HB_HealsMin,HB_shield = strfind(line, HB_SPELL_PATTERN_SHIELD );    
                HB_HealsExt=0;
                HB_duration = 30;
                HB_HealsMax=HB_HealsMin;
            elseif spellname==HEALBOT_RENEW then
                tmpTest,tmpTest,HB_HealsExt,tmpTest,HB_duration = strfind(line, HB_SPELL_PATTERN_RENEW1 );  
                HB_HealsMin=0;
                HB_HealsMax=0;
                if ( HB_HealsExt == nil ) then
                    tmpTest,tmpTest,HB_HealsExt,HB_duration = strfind(line, HB_SPELL_PATTERN_RENEW );
                end
                if ( HB_HealsExt == nil ) then
                    tmpTest,tmpTest,HB_duration,HB_HealsExt = strfind(line, HB_SPELL_PATTERN_RENEW2 );
                end
                if ( HB_HealsExt == nil ) then
                    tmpTest,tmpTest,HB_duration,HB_HealsExt = strfind(line, HB_SPELL_PATTERN_RENEW3 );
                end
            elseif spellname==HEALBOT_LESSER_HEAL then
                tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line,HB_SPELL_PATTERN_LESSER_HEAL); 
            elseif spellname==HEALBOT_GREATER_HEAL then
                tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_GREATER_HEAL ); 
            elseif spellname==HEALBOT_FLASH_HEAL then
                tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_FLASH_HEAL ); 
            elseif spellname==HEALBOT_HEAL then
                tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_HEAL ); 
            end
        elseif strsub(class,1,4)=="DRUI" then
            if spellname==HEALBOT_REGROWTH then
                tmpTest,tmpTest,HB_HealsMin,HB_HealsMax,HB_HealsExt = strfind(line, HB_SPELL_PATTERN_REGROWTH );
                if ( tmpTest == nil ) then
                    tmpTest,tmpTest,HB_HealsMin,HB_HealsMax,tmpTest,HB_HealsExt = strfind(line, HB_SPELL_PATTERN_REGROWTH1 );
                end
            elseif spellname==HEALBOT_REJUVENATION then
                tmpTest,tmpTest,HB_HealsExt,HB_duration = strfind(line, HB_SPELL_PATTERN_REJUVENATION );  
                HB_HealsMin=0;
                HB_HealsMax=0;
                if ( HB_HealsExt == nil ) then
                    tmpTest,tmpTest,HB_HealsExt,tmpTest,HB_duration = strfind(line, HB_SPELL_PATTERN_REJUVENATION1 );
                end
                if ( HB_HealsExt == nil ) then
                    tmpTest,tmpTest,HB_duration,HB_HealsExt = strfind(line, HB_SPELL_PATTERN_REJUVENATION2 );
                end
            elseif spellname==HEALBOT_HEALING_TOUCH then
                tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_HEALING_TOUCH ); 
            end
        elseif strsub(class,1,4)=="PALA" then
            if spellname==HEALBOT_HOLY_LIGHT then
                tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_HOLY_LIGHT ); 
            elseif spellname==HEALBOT_FLASH_OF_LIGHT then
                tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_FLASH_OF_LIGHT ); 
            end
        elseif strsub(class,1,4)=="SHAM" then
            if spellname==HEALBOT_HEALING_WAVE then
                tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_HEALING_WAVE ); 
            elseif spellname==HEALBOT_LESSER_HEALING_WAVE then
                tmpTest,HB_HealsMin,HB_HealsMax = HealBot_Generic_Patten(line, HB_SPELL_PATTERN_LESSER_HEALING_WAVE ); 
            end
        end
    end  


    if HB_cast then
        HealBot_Spells[spell].CastTime=tonumber(HB_cast);
    end
    if HB_mana then
        HealBot_Spells[spell].Mana=tonumber(HB_mana);
    end
    if HB_range then
        HealBot_Spells[spell].Range=tonumber(HB_range);
    end
    if HB_HealsMin then
        HealBot_Spells[spell].HealsMin=tonumber(HB_HealsMin);
    end
    if HB_HealsMax then
        HealBot_Spells[spell].HealsMax=tonumber(HB_HealsMax);
    end
    if HB_HealsExt then
        HealBot_Spells[spell].HealsExt=tonumber(HB_HealsExt);
    end
    if HB_duration and tonumber(HB_duration)<31 then
        HealBot_Spells[spell].Duration=tonumber(HB_duration);
    end
    if HB_shield then
        HealBot_Spells[spell].Shield=tonumber(HB_shield);
    end
    if HB_channel then
        HealBot_Spells[spell].Channel=tonumber(HB_channel);
    end
    HealBot_InitClearSpellNils(spell)
end

function HealBot_InitClearSpellNils(spell)
    if not HealBot_Spells[spell].CastTime then
        HealBot_Spells[spell].CastTime=0;
        HealBot_Spells[spell].Cast=0;
    end
    if not HealBot_Spells[spell].Cast then 
        HealBot_Spells[spell].Cast=0;
    end
    if not HealBot_Spells[spell].Mana then
        HealBot_Spells[spell].Mana=10*UnitLevel("player");
    end
    if not HealBot_Spells[spell].Range then
        HealBot_Spells[spell].Range=40;
    end
    if not HealBot_Spells[spell].HealsMin then
        HealBot_Spells[spell].HealsMin=0;
    end
    if not HealBot_Spells[spell].HealsMax then
        HealBot_Spells[spell].HealsMax=0;
    end
    if not HealBot_Spells[spell].HealsExt then
        HealBot_Spells[spell].HealsExt = 0;
    end
    if not HealBot_Spells[spell].Channel then
        HealBot_Spells[spell].Channel = HealBot_Spells[spell].CastTime;
    end
    if not HealBot_Spells[spell].Duration then
        HealBot_Spells[spell].Duration = 0;
    end
    if not HealBot_Spells[spell].Target then
        HealBot_Spells[spell].Target = {"player","party","pet"};
    end
    if not HealBot_Spells[spell].Level then
        HealBot_Spells[spell].Level = 1;
    end

    if not HealBot_Spells[spell].RealHealing then
        HealBot_Spells[spell].RealHealing=0;
    end
    HealBot_Spells[spell].HealsCast = (HealBot_Spells[spell].HealsMin+HealBot_Spells[spell].HealsMax)/2;
    HealBot_Spells[spell].HealsDur = floor((HealBot_Spells[spell].HealsCast+HealBot_Spells[spell].HealsExt) + HealBot_Spells[spell].RealHealing);
end

function HealBot_Generic_Patten(matchStr,matchPattern)
    tmpTest2,tmpTest2,hbHealsMin,hbHealsMax = strfind(matchStr, matchPattern ); 
    return tmpTest2,hbHealsMin,hbHealsMax;
end

function HealBot_FindSpellRangeCast(id)

    if ( not id ) then return; end
  
    spell,spellrank = HealBot_GetSpellName(id);
    if spellrank then 
        spell=spell.."("..spellrank..")"; 
    end
  
    HealBot_TooltipInit();
    HealBot_ScanTooltip:SetSpell( id, BOOKTYPE_SPELL );
 
    if HealBot_ScanTooltipTextLeft2:GetText() then
        line1=HealBot_ScanTooltipTextLeft2:GetText();
    end
    if HealBot_ScanTooltipTextRight2:GetText() then
        line2 = HealBot_ScanTooltipTextRight2:GetText()
    end
    if HealBot_ScanTooltipTextLeft3:GetText() then
        line3 = HealBot_ScanTooltipTextLeft3:GetText();
    end
  
    if line1 then
        tmpTest,tmpTest,HB_mana = strfind(line1, HB_TOOLTIP_MANA ); 
    end

    if line2 then
        tmpTest,tmpTest,HB_range = strfind(line2, HB_TOOLTIP_RANGE ); 
    end  

    if line3 then
        if ( line3 == HB_TOOLTIP_INSTANT_CAST ) then
            HB_cast = 0;
        elseif line3 == HB_TOOLTIP_CHANNELED then
            HB_cast = 0;
        elseif ( line3 ) then
            tmpTest,tmpTest,HB_cast = strfind(line3, HB_TOOLTIP_CAST_TIME ); 
        end
    end  

    HealBot_OtherSpells[spell] = {spell = {}};
    if not HB_cast then
        HealBot_OtherSpells[spell].CastTime=0;
    else
        HealBot_OtherSpells[spell].CastTime=tonumber(HB_cast);
    end
    if not HB_mana then
        HealBot_OtherSpells[spell].Mana=10*UnitLevel("player");
    else
        HealBot_OtherSpells[spell].Mana=tonumber(HB_mana);
    end
    if not HB_range then
        HealBot_OtherSpells[spell].Range=40;
    else
        HealBot_OtherSpells[spell].Range=tonumber(HB_range);
    end
end

function HealBot_Init_Spells_Defaults(class)

--  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_PALADIN] then
-- PALADIN
    HealBot_Spells = {
        [HEALBOT_HOLY_LIGHT] = {},
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_1] = {
            CastTime = 2.5, Cast = 2.5, Mana =  35, HealsMin =   50, HealsMax =   60, Level = 1 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_2] = { 
            CastTime = 2.5, Cast = 2.5, Mana =  60, HealsMin =   96, HealsMax =   116, Level = 6 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_3] = { 
            CastTime = 2.5, Cast = 2.5, Mana = 110, HealsMin =  203, HealsMax =  239, Level = 14 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_4] = { 
            CastTime = 2.5, Cast = 2.5, Mana = 190, HealsMin =  397, HealsMax =  455, Level = 22 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_5] = { 
            CastTime = 2.5, Cast = 2.5, Mana = 275, HealsMin =  628, HealsMax =  708, Level = 30 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_6] = { 
            CastTime = 2.5, Cast = 2.5, Mana = 365, HealsMin =  894, HealsMax =  988, Level = 38 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_7] = { 
            CastTime = 2.5, Cast = 2.5, Mana = 465, HealsMin =  1209, HealsMax = 1349, Level = 46 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_8] = { 
            CastTime = 2.5, Cast = 2.5, Mana = 580, HealsMin = 1246, HealsMax = 1388, Level = 54 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_9] = { 
            CastTime = 2.5, Cast = 2.5, Mana = 660, HealsMin = 1595, HealsMax = 1777, Level = 60 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_10] = { 
            CastTime = 2.5, Cast = 2.5, Mana = 710, HealsMin = 2232, HealsMax = 2486, Level = 62 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_11] = { 
            CastTime = 2.5, Cast = 2.5, Mana = 840, HealsMin = 2818, HealsMax = 3138, Level = 70 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_12] = { 
            CastTime = 2.5, Cast = 2.5, Mana = 1585, HealsMin = 4199, HealsMax = 4677, Level = 75 },
        [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_13] = { 
            CastTime = 2.5, Cast = 2.5, Mana = 1880, HealsMin = 4888, HealsMax = 5444, Level = 80 },

        [HEALBOT_FLASH_OF_LIGHT] = {},
        [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_1] = {
            CastTime = 1.5, Cast = 1.5, Duration = 15, Mana =  35, HealsMin =   81, HealsMax =   93, Level = 20 },
        [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_2] = {
            CastTime = 1.5, Cast = 1.5, Duration = 15, Mana =  50, HealsMin =   124, HealsMax =  144, Level = 26 },
        [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_3] = {
            CastTime = 1.5, Cast = 1.5, Duration = 15, Mana =  70, HealsMin =  189, HealsMax =  221, Level = 34 },
        [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_4] = {
            CastTime = 1.5, Cast = 1.5, Duration = 15, Mana =  90, HealsMin =  256, HealsMax =  288, Level = 42 },
        [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_5] = {
            CastTime = 1.5, Cast = 1.5, Duration = 15, Mana = 115, HealsMin =  346, HealsMax =  390, Level = 50 },
        [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_6] = {
            CastTime = 1.5, Cast = 1.5, Duration = 15, Mana = 140, HealsMin =  445, HealsMax =  499, Level = 58 },
        [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_7] = {
            CastTime = 1.5, Cast = 1.5, Duration = 15, Mana = 180, HealsMin =  588, HealsMax =  658, Level = 66 },
        [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_8] = {
            CastTime = 1.5, Cast = 1.5, Duration = 15, Mana = 350, HealsMin =  682, HealsMax =  764, Level = 74 },
        [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_9] = {
            CastTime = 1.5, Cast = 1.5, Duration = 15, Mana = 420, HealsMin =  785, HealsMax =  879, Level = 79 },
    
--    };
--  end

--  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_DRUID] then
-- DRUID
--    HealBot_Spells = {

        [HEALBOT_REJUVENATION] = {},
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_1 ] = { 
            CastTime = 0, Cast = 0, Duration = 12, Mana =  25, HealsMin = 0, HealsMax = 0, HealsExt =   32, Level =  4, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_2 ] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana =  40, HealsMin = 0, HealsMax = 0, HealsExt =   56, Level = 10, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_3 ] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana =  75, HealsMin = 0, HealsMax = 0, HealsExt =  116, Level = 16, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_4 ] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 105, HealsMin = 0, HealsMax = 0, HealsExt =  180, Level = 22, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_5 ] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 135, HealsMin = 0, HealsMax = 0, HealsExt =  244, Level = 28, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_6 ] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 160, HealsMin = 0, HealsMax = 0, HealsExt =  304, Level = 34, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_7 ] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 195, HealsMin = 0, HealsMax = 0, HealsExt =  388, Level = 40, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_8 ] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 235, HealsMin = 0, HealsMax = 0, HealsExt =  488, Level = 46, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_9 ] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 280, HealsMin = 0, HealsMax = 0, HealsExt =  608, Level = 52, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_10] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 335, HealsMin = 0, HealsMax = 0, HealsExt =  756, Level = 58, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_11] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 360, HealsMin = 0, HealsMax = 0, HealsExt =  888, Level = 60, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_12] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 370, HealsMin = 0, HealsMax = 0, HealsExt =  932, Level = 63, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_13] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 415, HealsMin = 0, HealsMax = 0, HealsExt = 1060, Level = 69, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_14] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 550, HealsMin = 0, HealsMax = 0, HealsExt = 1192, Level = 75, Buff = HEALBOT_REJUVENATION },
        [HEALBOT_REJUVENATION .. HEALBOT_RANK_15] = {
            CastTime = 0, Cast = 0, Duration = 12, Mana = 645, HealsMin = 0, HealsMax = 0, HealsExt = 1352, Level = 80, Buff = HEALBOT_REJUVENATION },

        [HEALBOT_HEALING_TOUCH] = {},
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_1 ] = {
            CastTime = 1.5, Cast = 1.5, Mana =  25, HealsMin =   37, HealsMax =   51, Level  = 1 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_2 ] = {
            CastTime = 2.0, Cast = 2.0, Mana =  55, HealsMin =   88, HealsMax =  112, Level =  8 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_3 ] = {
            CastTime = 2.5, Cast = 2.5, Mana = 110, HealsMin =  195, HealsMax =  243, Level = 14 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_4 ] = {
            CastTime = 3.0, Cast = 3.0, Mana = 185, HealsMin =  363, HealsMax =  445, Level = 20 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_5 ] = {
            CastTime = 3.5, Cast = 3.5, Mana = 270, HealsMin =  572, HealsMax =  694, Level = 26 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_6 ] = {
            CastTime = 3.5, Cast = 3.5, Mana = 335, HealsMin =  742, HealsMax =  894, Level = 32 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_7 ] = {
            CastTime = 3.5, Cast = 3.5, Mana = 405, HealsMin =  935, HealsMax = 1120, Level = 38 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_8 ] = {
            CastTime = 3.5, Cast = 3.5, Mana = 495, HealsMin = 1199, HealsMax = 1427, Level = 44 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_9 ] = {
            CastTime = 3.5, Cast = 3.5, Mana = 600, HealsMin = 1516, HealsMax = 1796, Level = 50 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_10] = {
            CastTime = 3.5, Cast = 3.5, Mana = 720, HealsMin = 1890, HealsMax = 2230, Level = 56 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_11] = {
            CastTime = 3.5, Cast = 3.5, Mana = 800, HealsMin = 2267, HealsMax = 2677, Level = 60 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_12] = {
            CastTime = 3.5, Cast = 3.5, Mana = 820, HealsMin = 2364, HealsMax = 2790, Level = 62 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_13] = {
            CastTime = 3.5, Cast = 3.5, Mana = 935, HealsMin = 2707, HealsMax = 3197, Level = 69 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_14] = {
            CastTime = 3.5, Cast = 3.5, Mana = 1190, HealsMin = 3760, HealsMax = 4440, Level = 74 },
        [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_15] = {
            CastTime = 3.5, Cast = 3.5, Mana = 1400, HealsMin = 4375, HealsMax = 5165, Level = 79 },
 
        [HEALBOT_NOURISH] = {},
        [HEALBOT_NOURISH .. HEALBOT_RANK_1] = {
            CastTime = 1.5, Cast = 1.5, Mana = 1400, HealsMin = 1883, HealsMax = 2187, Level = 80 },
 
        [HEALBOT_REGROWTH] = {},
        [HEALBOT_REGROWTH .. HEALBOT_RANK_1] = {
            CastTime = 2, Cast = 2.0, Duration = 21, Mana =  80, HealsMin =   84, HealsMax =   98, HealsExt =   98, Level = 12, Buff = HEALBOT_REGROWTH },
        [HEALBOT_REGROWTH .. HEALBOT_RANK_2] = {
            CastTime = 2, Cast = 2.0, Duration = 21, Mana =  135, HealsMin =  164, HealsMax =  188, HealsExt =  175, Level = 18, Buff = HEALBOT_REGROWTH },
        [HEALBOT_REGROWTH .. HEALBOT_RANK_3] = {
            CastTime = 2, Cast = 2.0, Duration = 21, Mana =  185, HealsMin =  240, HealsMax =  274, HealsExt =  259, Level = 24, Buff = HEALBOT_REGROWTH },
        [HEALBOT_REGROWTH .. HEALBOT_RANK_4] = { 
            CastTime = 2, Cast = 2.0, Duration = 21, Mana =  230, HealsMin =  318, HealsMax =  360, HealsExt =  343, Level = 30, Buff = HEALBOT_REGROWTH },
        [HEALBOT_REGROWTH .. HEALBOT_RANK_5] = {
            CastTime = 2, Cast = 2.0, Duration = 21, Mana =  275, HealsMin =  405, HealsMax =  457, HealsExt =  427, Level = 36, Buff = HEALBOT_REGROWTH },
        [HEALBOT_REGROWTH .. HEALBOT_RANK_6] = {
            CastTime = 2, Cast = 2.0, Duration = 21, Mana =  335, HealsMin =  511, HealsMax =  576, HealsExt =  546, Level = 42, Buff = HEALBOT_REGROWTH },
        [HEALBOT_REGROWTH .. HEALBOT_RANK_7] = {
            CastTime = 2, Cast = 2.0, Duration = 21, Mana =  405, HealsMin =  646, HealsMax =  724, HealsExt =  686, Level = 48, Buff = HEALBOT_REGROWTH },
        [HEALBOT_REGROWTH .. HEALBOT_RANK_8] = {
            CastTime = 2, Cast = 2.0, Duration = 21, Mana =  485, HealsMin =  809, HealsMax =  905, HealsExt =  861, Level = 54, Buff = HEALBOT_REGROWTH },
        [HEALBOT_REGROWTH .. HEALBOT_RANK_9] = {
            CastTime = 2, Cast = 2.0, Duration = 21, Mana =  575, HealsMin = 1003, HealsMax = 1119, HealsExt = 1064, Level = 60, Buff = HEALBOT_REGROWTH },
        [HEALBOT_REGROWTH .. HEALBOT_RANK_10] = {
            CastTime = 2, Cast = 2.0, Duration = 21, Mana = 675, HealsMin = 1215, HealsMax = 1355, HealsExt = 1274, Level = 65, Buff = HEALBOT_REGROWTH },
        [HEALBOT_REGROWTH .. HEALBOT_RANK_11] = {
            CastTime = 2, Cast = 2.0, Duration = 21, Mana = 845, HealsMin = 1710, HealsMax = 1908, HealsExt = 1792, Level = 71, Buff = HEALBOT_REGROWTH },
        [HEALBOT_REGROWTH .. HEALBOT_RANK_12] = {
            CastTime = 2, Cast = 2.0, Duration = 21, Mana = 1040, HealsMin = 2234, HealsMax = 2494, HealsExt = 2345, Level = 77, Buff = HEALBOT_REGROWTH },
    
        [HEALBOT_LIFEBLOOM] = {},
        [HEALBOT_LIFEBLOOM .. HEALBOT_RANK_1] = {
            CastTime = 0, Cast = 0, Duration = 7, Mana = 220, HealsMin = 600, HealsMax = 600, HealsExt = 224, Level = 64, Buff = HEALBOT_LIFEBLOOM },
        [HEALBOT_LIFEBLOOM .. HEALBOT_RANK_2] = {
            CastTime = 0, Cast = 0, Duration = 7, Mana = 295, HealsMin = 770, HealsMax = 770, HealsExt = 287, Level = 72, Buff = HEALBOT_LIFEBLOOM },
        [HEALBOT_LIFEBLOOM .. HEALBOT_RANK_3] = {
            CastTime = 0, Cast = 0, Duration = 7, Mana = 430, HealsMin = 970, HealsMax = 970, HealsExt = 371, Level = 80, Buff = HEALBOT_LIFEBLOOM },

        [HEALBOT_WILD_GROWTH] = {},
        [HEALBOT_WILD_GROWTH .. HEALBOT_RANK_1] = {
            CastTime = 0, Cast = 0, Duration = 7, Mana = 200, HealsMin = 0, HealsMax = 0, HealsExt = 350, Level = 60, Buff = HEALBOT_WILD_GROWTH },
        [HEALBOT_WILD_GROWTH .. HEALBOT_RANK_2] = {
            CastTime = 0, Cast = 0, Duration = 7, Mana = 400, HealsMin = 0, HealsMax = 0, HealsExt = 469, Level = 70, Buff = HEALBOT_WILD_GROWTH },
        [HEALBOT_WILD_GROWTH .. HEALBOT_RANK_3] = {
            CastTime = 0, Cast = 0, Duration = 7, Mana = 600, HealsMin = 0, HealsMax = 0, HealsExt = 805, Level = 75, Buff = HEALBOT_WILD_GROWTH },
        [HEALBOT_WILD_GROWTH .. HEALBOT_RANK_4] = {
            CastTime = 0, Cast = 0, Duration = 7, Mana = 800, HealsMin = 0, HealsMax = 0, HealsExt = 1085, Level = 80, Buff = HEALBOT_WILD_GROWTH },    

        [HEALBOT_TRANQUILITY] = {},
        [HEALBOT_TRANQUILITY .. HEALBOT_RANK_1] = {
            CastTime = 0, Cast = 0, Duration = 8, Mana = 200, HealsMin = 0, HealsMax = 0, HealsExt = 351, Level = 30, Buff = HEALBOT_TRANQUILITY },
        [HEALBOT_TRANQUILITY .. HEALBOT_RANK_2] = {
            CastTime = 0, Cast = 0, Duration = 8, Mana = 400, HealsMin = 0, HealsMax = 0, HealsExt = 515, Level = 40, Buff = HEALBOT_TRANQUILITY },
        [HEALBOT_TRANQUILITY .. HEALBOT_RANK_3] = {
            CastTime = 0, Cast = 0, Duration = 8, Mana = 600, HealsMin = 0, HealsMax = 0, HealsExt = 765, Level = 50, Buff = HEALBOT_TRANQUILITY },
        [HEALBOT_TRANQUILITY .. HEALBOT_RANK_4] = {
            CastTime = 0, Cast = 0, Duration = 8, Mana = 800, HealsMin = 0, HealsMax = 0, HealsExt = 1097, Level = 60, Buff = HEALBOT_TRANQUILITY },    
        [HEALBOT_TRANQUILITY .. HEALBOT_RANK_5] = {
            CastTime = 0, Cast = 0, Duration = 8, Mana = 1000, HealsMin = 0, HealsMax = 0, HealsExt = 1518, Level = 70, Buff = HEALBOT_TRANQUILITY },
        [HEALBOT_TRANQUILITY .. HEALBOT_RANK_6] = {
            CastTime = 0, Cast = 0, Duration = 8, Mana = 1500, HealsMin = 0, HealsMax = 0, HealsExt = 2598, Level = 75, Buff = HEALBOT_TRANQUILITY },
        [HEALBOT_TRANQUILITY .. HEALBOT_RANK_7] = {
            CastTime = 0, Cast = 0, Duration = 8, Mana = 2000, HealsMin = 0, HealsMax = 0, HealsExt = 3035, Level = 80, Buff = HEALBOT_TRANQUILITY },    
    
--    };
--  end

--  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_PRIEST] then
-- PRIEST
--    HealBot_Spells = {

        [HEALBOT_LESSER_HEAL] = {},
        [HEALBOT_LESSER_HEAL .. HEALBOT_RANK_1] = {
            CastTime = 1.5, Cast = 1.5, Mana =  30, HealsMin =   46, HealsMax =   56, Level =  1 }, 
        [HEALBOT_LESSER_HEAL .. HEALBOT_RANK_2] = {
            CastTime = 2.0, Cast = 2.0, Mana =  45, HealsMin =   71, HealsMax =   85, Level =  4 }, 
        [HEALBOT_LESSER_HEAL .. HEALBOT_RANK_3] = {
            CastTime = 2.5, Cast = 2.5, Mana =  75, HealsMin =  135, HealsMax =  157, Level = 10 }, 

        [HEALBOT_HEAL] = {},
        [HEALBOT_HEAL .. HEALBOT_RANK_1] = {
            CastTime = 3.0, Cast = 3.0, Mana = 155, HealsMin =  295, HealsMax =  341, Level = 16 }, 
        [HEALBOT_HEAL .. HEALBOT_RANK_2] = {
            CastTime = 3.0, Cast = 3.0, Mana = 205, HealsMin =  429, HealsMax =  491, Level = 22 }, 
        [HEALBOT_HEAL .. HEALBOT_RANK_3] = {
            CastTime = 3.0, Cast = 3.0, Mana = 255, HealsMin =  566, HealsMax =  642, Level = 28 }, 
        [HEALBOT_HEAL .. HEALBOT_RANK_4] = {
            CastTime = 3.0, Cast = 3.0, Mana = 305, HealsMin =  712, HealsMax = 804, Level = 34 }, 

        [HEALBOT_GREATER_HEAL] = {},
        [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_1] = {
            CastTime = 3.0, Cast = 3.0, Mana =  370, HealsMin = 899, HealsMax = 1013, Level = 40 }, 
        [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_2] = {
            CastTime = 3.0, Cast = 3.0, Mana =  455, HealsMin = 1149, HealsMax = 1289, Level = 46 }, 
        [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_3] = {
            CastTime = 3.0, Cast = 3.0, Mana =  545, HealsMin = 1473, HealsMax = 1609, Level = 52 }, 
        [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_4] = {
            CastTime = 3.0, Cast = 3.0, Mana =  655, HealsMin = 1798, HealsMax = 2006, Level = 58 }, 
        [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_5] = {
            CastTime = 3.0, Cast = 3.0, Mana = 710, HealsMin = 1966, HealsMax = 2194, Level = 60 }, 
        [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_6] = {
            CastTime = 3.0, Cast = 3.0, Mana = 750, HealsMin = 2074, HealsMax = 2410, Level = 63 }, 
        [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_7] = {
            CastTime = 3.0, Cast = 3.0, Mana = 825, HealsMin = 2396, HealsMax = 2784, Level = 68 }, 
        [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_8] = {
            CastTime = 3.0, Cast = 3.0, Mana = 1095, HealsMin = 3395, HealsMax = 3945, Level = 73 }, 
        [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_9] = {
            CastTime = 3.0, Cast = 3.0, Mana = 1290, HealsMin = 3950, HealsMax = 4590, Level = 78 }, 
    
        [HEALBOT_BINDING_HEAL] = {},
        [HEALBOT_BINDING_HEAL .. HEALBOT_RANK_1] = {
            CastTime = 1.5, Cast = 1.5, Mana =  705, HealsMin = 1042, HealsMax = 1338, Level = 64 }, 
        [HEALBOT_BINDING_HEAL .. HEALBOT_RANK_2] = {
            CastTime = 1.5, Cast = 1.5, Mana =  1000, HealsMin = 1619, HealsMax = 2081, Level = 72 }, 
        [HEALBOT_BINDING_HEAL .. HEALBOT_RANK_3] = {
            CastTime = 1.5, Cast = 1.5, Mana =  1215, HealsMin = 1952, HealsMax = 2508, Level = 78 }, 
    
        [HEALBOT_PRAYER_OF_MENDING] = {},
        [HEALBOT_PRAYER_OF_MENDING .. HEALBOT_RANK_1] = {
            CastTime = 0, Cast = 0, Mana =  390, HealsMin = 800, HealsMax = 800, Level = 68, 
            Buff=HEALBOT_PRAYER_OF_MENDING, NoBonus=true, Duration = 30}, 
        [HEALBOT_PRAYER_OF_MENDING .. HEALBOT_RANK_2] = {
            CastTime = 0, Cast = 0, Mana =  545, HealsMin = 905, HealsMax = 905, Level = 74, 
            Buff=HEALBOT_PRAYER_OF_MENDING, NoBonus=true, Duration = 30}, 
        [HEALBOT_PRAYER_OF_MENDING .. HEALBOT_RANK_3] = {
            CastTime = 0, Cast = 0, Mana =  640, HealsMin = 1043, HealsMax = 1043, Level = 79, 
            Buff=HEALBOT_PRAYER_OF_MENDING, NoBonus=true, Duration = 30}, 
    
        [HEALBOT_PRAYER_OF_HEALING] = {},
        [HEALBOT_PRAYER_OF_HEALING .. HEALBOT_RANK_1] = {
            CastTime = 3.0, Cast = 3.0, Mana =  410, HealsMin = 301, HealsMax = 321, Level = 30 }, 
        [HEALBOT_PRAYER_OF_HEALING .. HEALBOT_RANK_2] = {
            CastTime = 3.0, Cast = 3.0, Mana =  560, HealsMin = 444, HealsMax = 472, Level = 40 }, 
        [HEALBOT_PRAYER_OF_HEALING .. HEALBOT_RANK_3] = {
            CastTime = 3.0, Cast = 3.0, Mana =  770, HealsMin = 657, HealsMax = 695, Level = 50 }, 
        [HEALBOT_PRAYER_OF_HEALING .. HEALBOT_RANK_4] = {
            CastTime = 3.0, Cast = 3.0, Mana =  1030, HealsMin = 939, HealsMax = 991, Level = 60 }, 
        [HEALBOT_PRAYER_OF_HEALING .. HEALBOT_RANK_5] = {
            CastTime = 3.0, Cast = 3.0, Mana = 1070, HealsMin = 997, HealsMax = 1053, Level = 60 }, 
        [HEALBOT_PRAYER_OF_HEALING .. HEALBOT_RANK_6] = {
            CastTime = 3.0, Cast = 3.0, Mana = 1255, HealsMin = 1246, HealsMax = 1316, Level = 68 }, 
        [HEALBOT_PRAYER_OF_HEALING .. HEALBOT_RANK_7] = {
            CastTime = 3.0, Cast = 3.0, Mana = 1840, HealsMin = 2091, HealsMax = 2209, Level = 76 },   

        [HEALBOT_PENANCE] = {},
        [HEALBOT_PENANCE .. HEALBOT_RANK_1] = {
            CastTime = 0, Cast = 0, Duration = 2, Mana =  400, HealsMin = 0, HealsMax = 0, HealsExt =   2130, Level =  60, Buff = HEALBOT_PENANCE }, 
        [HEALBOT_PENANCE .. HEALBOT_RANK_2] = {
            CastTime = 0, Cast = 0, Duration = 2, Mana =  600, HealsMin = 0, HealsMax = 0, HealsExt =   2550, Level =  70, Buff = HEALBOT_PENANCE }, 
        [HEALBOT_PENANCE .. HEALBOT_RANK_3] = {
            CastTime = 0, Cast = 0, Duration = 2, Mana =  900, HealsMin = 0, HealsMax = 0, HealsExt =   4050, Level =  75, Buff = HEALBOT_PENANCE }, 
        [HEALBOT_PENANCE .. HEALBOT_RANK_4] = {
            CastTime = 0, Cast = 0, Duration = 2, Mana =  1200, HealsMin = 0, HealsMax = 0, HealsExt =   4770, Level =  80, Buff = HEALBOT_PENANCE }, 
            
        [HEALBOT_RENEW] = {},
        [HEALBOT_RENEW .. HEALBOT_RANK_1] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  30, HealsMin = 0, HealsMax = 0, HealsExt =   45, Level =  8, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_2] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  65, HealsMin = 0, HealsMax = 0, HealsExt =  100, Level = 14, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_3] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 105, HealsMin = 0, HealsMax = 0, HealsExt =  175, Level = 20, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_4] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 140, HealsMin = 0, HealsMax = 0, HealsExt =  245, Level = 26, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_5] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 170, HealsMin = 0, HealsMax = 0, HealsExt =  315, Level = 32, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_6] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 205, HealsMin = 0, HealsMax = 0, HealsExt =  400, Level = 38, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_7] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 250, HealsMin = 0, HealsMax = 0, HealsExt =  510, Level = 44, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_8] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 305, HealsMin = 0, HealsMax = 0, HealsExt =  650, Level = 50, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_9] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 365, HealsMin = 0, HealsMax = 0, HealsExt =  810, Level = 56, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_10] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 410, HealsMin = 0, HealsMax = 0, HealsExt =  970, Level = 60, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_11] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 430, HealsMin = 0, HealsMax = 0, HealsExt = 1010, Level = 65, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_12] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 450, HealsMin = 0, HealsMax = 0, HealsExt = 1110, Level = 70, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_13] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 610, HealsMin = 0, HealsMax = 0, HealsExt = 1235, Level = 75, Buff = HEALBOT_RENEW }, 
        [HEALBOT_RENEW .. HEALBOT_RANK_14] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 720, HealsMin = 0, HealsMax = 0, HealsExt = 1400, Level = 80, Buff = HEALBOT_RENEW }, 
    
        [HEALBOT_FLASH_HEAL] = {},
        [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_1] = {
            CastTime = 1.5, Cast = 1.5, Mana = 125, HealsMin = 193, HealsMax = 237, Level = 20 }, 
        [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_2] = {
            CastTime = 1.5, Cast = 1.5, Mana = 155, HealsMin = 258, HealsMax = 314, Level = 26 }, 
        [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_3] = {
            CastTime = 1.5, Cast = 1.5, Mana = 185, HealsMin = 327, HealsMax = 393, Level = 32 }, 
        [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_4] = {
            CastTime = 1.5, Cast = 1.5, Mana = 215, HealsMin = 400, HealsMax = 478, Level = 38 }, 
        [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_5] = {
            CastTime = 1.5, Cast = 1.5, Mana = 265, HealsMin = 518, HealsMax = 616, Level = 44 }, 
        [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_6] = {
            CastTime = 1.5, Cast = 1.5, Mana = 315, HealsMin = 644, HealsMax = 764, Level = 50 }, 
        [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_7] = { 
            CastTime = 1.5, Cast = 1.5, Mana = 380, HealsMin = 812, HealsMax = 958, Level = 56 }, 
        [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_8] = { 
            CastTime = 1.5, Cast = 1.5, Mana = 400, HealsMin = 913, HealsMax = 1059, Level = 61 }, 
        [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_9] = { 
            CastTime = 1.5, Cast = 1.5, Mana = 470, HealsMin = 1101, HealsMax = 1279, Level = 67 }, 
        [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_10] = { 
            CastTime = 1.5, Cast = 1.5, Mana = 640, HealsMin = 1578, HealsMax = 1832, Level = 73 }, 
        [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_11] = { 
            CastTime = 1.5, Cast = 1.5, Mana = 775, HealsMin = 1887, HealsMax = 2193, Level = 79 }, 
    
        [HEALBOT_POWER_WORD_SHIELD] = {},
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_1] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana =  45, HealsMin =  44, HealsMax =  44, Level =  6,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30  }, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_2] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana =  80, HealsMin =  88, HealsMax =  88, Level = 12,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30 }, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_3] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 130, HealsMin = 158, HealsMax = 158, Level = 18,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30 }, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_4] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 175, HealsMin = 234, HealsMax = 234, Level = 24,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30 }, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_5] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 210, HealsMin = 301, HealsMax = 301, Level = 30,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30 }, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_6] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 250, HealsMin = 381, HealsMax = 381, Level = 36,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30 }, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_7] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 300, HealsMin = 484, HealsMax = 484, Level = 42,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30 }, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_8] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 355, HealsMin = 605, HealsMax = 605, Level = 48,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30 }, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_9] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 425, HealsMin = 763, HealsMax = 763, Level = 54,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30 }, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_10] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 500, HealsMin = 942, HealsMax = 942, Level = 60,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30 }, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_11] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 540, HealsMin = 1125, HealsMax = 1125, Level = 65,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30 }, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_12] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 600, HealsMin = 1265, HealsMax = 1265, Level = 70,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30}, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_13] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 815, HealsMin = 1920, HealsMax = 1920, Level = 75,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30}, 
        [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_14] = {
            CastTime = 0, Cast = 0, Shield = 30, Mana = 960, HealsMin = 2230, HealsMax = 2230, Level = 80,
            Buff= HEALBOT_POWER_WORD_SHIELD, Duration = 30}, 

--    };
--  end

--  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_SHAMAN] then
-- SHAMAN
--    HealBot_Spells = {

        [HEALBOT_HEALING_WAVE] = {},
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_1] = {
             CastTime = 1.5, Cast = 1.5, Mana =  25, HealsMin =   34, HealsMax =   44, Level =  1 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_2] = {
             CastTime = 2.0, Cast = 2.0, Mana =  45, HealsMin =   64, HealsMax =   78, Level =  6 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_3] = {
             CastTime = 2.5, Cast = 2.5, Mana =  80, HealsMin =  129, HealsMax =  155, Level = 12 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_4] = {
             CastTime = 3.0, Cast = 3.0, Mana = 155, HealsMin =  268, HealsMax =  316, Level = 18 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_5] = {
             CastTime = 3.0, Cast = 3.0, Mana = 200, HealsMin =  376, HealsMax =  440, Level = 24 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_6] = {
             CastTime = 3.0, Cast = 3.0, Mana = 265, HealsMin =  536, HealsMax =  622, Level = 32 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_7] = {
             CastTime = 3.0, Cast = 3.0, Mana = 340, HealsMin =  740, HealsMax =  854, Level = 40 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_8] = {
             CastTime = 3.0, Cast = 3.0, Mana = 440, HealsMin = 1017, HealsMax = 1167, Level = 48 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_9] = {
             CastTime = 3.0, Cast = 3.0, Mana = 560, HealsMin = 1367, HealsMax = 1561, Level = 56 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_10] = {
             CastTime = 3.0, Cast = 3.0, Mana = 620, HealsMin = 1620, HealsMax = 1850, Level = 60 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_11] = {
             CastTime = 3.0, Cast = 3.0, Mana = 655, HealsMin = 1725, HealsMax = 1969, Level = 63 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_12] = {
             CastTime = 3.0, Cast = 3.0, Mana = 720, HealsMin = 2134, HealsMax = 2436, Level = 70 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_13] = {
             CastTime = 3.0, Cast = 3.0, Mana = 1355, HealsMin = 2624, HealsMax = 2996, Level = 75 }, 
        [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_14] = {
             CastTime = 3.0, Cast = 3.0, Mana = 1600, HealsMin = 3034, HealsMax = 3466, Level = 80 }, 

        [HEALBOT_LESSER_HEALING_WAVE] = {},
        [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_1] = {
             CastTime = 1.5, Cast = 1.5, Mana = 105, HealsMin = 162, HealsMax = 186, Level = 20 }, 
        [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_2] = {
             CastTime = 1.5, Cast = 1.5, Mana = 145, HealsMin = 247, HealsMax = 281, Level = 28 }, 
        [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_3] = {
             CastTime = 1.5, Cast = 1.5, Mana = 185, HealsMin = 337, HealsMax = 381, Level = 36 }, 
        [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_4] = {
             CastTime = 1.5, Cast = 1.5, Mana = 235, HealsMin = 458, HealsMax = 514, Level = 44 }, 
        [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_5] = {
             CastTime = 1.5, Cast = 1.5, Mana = 305, HealsMin = 631, HealsMax = 705, Level = 52 }, 
        [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_6] = {
             CastTime = 1.5, Cast = 1.5, Mana = 380, HealsMin = 832, HealsMax = 928, Level = 60 }, 
        [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_7] = {
             CastTime = 1.5, Cast = 1.5, Mana = 440, HealsMin = 1039, HealsMax = 1185, Level = 66 }, 
        [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_8] = {
             CastTime = 1.5, Cast = 1.5, Mana = 805, HealsMin = 1382, HealsMax = 1578, Level = 72 }, 
        [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_9] = {
             CastTime = 1.5, Cast = 1.5, Mana = 965, HealsMin = 1606, HealsMax = 1834, Level = 77 }, 
    
        [HEALBOT_CHAIN_HEAL] = {},
        [HEALBOT_CHAIN_HEAL .. HEALBOT_RANK_1] = {
            CastTime = 2.5, Cast = 2.5, Mana = 260, HealsMin = 320, HealsMax = 368, Level = 40 },
        [HEALBOT_CHAIN_HEAL .. HEALBOT_RANK_2] = {
            CastTime = 2.5, Cast = 2.5, Mana = 315, HealsMin = 405, HealsMax = 465, Level = 46 },
        [HEALBOT_CHAIN_HEAL .. HEALBOT_RANK_3] = {
            CastTime = 2.5, Cast = 2.5, Mana = 405, HealsMin = 551, HealsMax = 629, Level = 54 },
        [HEALBOT_CHAIN_HEAL .. HEALBOT_RANK_4] = {
            CastTime = 2.5, Cast = 2.5, Mana = 435, HealsMin = 605, HealsMax = 691, Level = 61 },
        [HEALBOT_CHAIN_HEAL .. HEALBOT_RANK_5] = {
            CastTime = 2.5, Cast = 2.5, Mana = 540, HealsMin = 826, HealsMax = 942, Level = 68 },
        [HEALBOT_CHAIN_HEAL .. HEALBOT_RANK_6] = {
            CastTime = 2.5, Cast = 2.5, Mana = 1020, HealsMin = 906, HealsMax = 1034, Level = 74 },
        [HEALBOT_CHAIN_HEAL .. HEALBOT_RANK_7] = {
            CastTime = 2.5, Cast = 2.5, Mana = 1260, HealsMin = 1055, HealsMax = 1205, Level = 80 },

        [HEALBOT_EARTH_SHIELD] = {},
        [HEALBOT_EARTH_SHIELD .. HEALBOT_RANK_1] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 50 },
        [HEALBOT_EARTH_SHIELD .. HEALBOT_RANK_2] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 60 },
        [HEALBOT_EARTH_SHIELD .. HEALBOT_RANK_3] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 70 },
        [HEALBOT_EARTH_SHIELD .. HEALBOT_RANK_4] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 75 },
        [HEALBOT_EARTH_SHIELD .. HEALBOT_RANK_5] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 80 },

        [HEALBOT_WATER_SHIELD] = {},
        [HEALBOT_WATER_SHIELD .. HEALBOT_RANK_1] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 20 },
        [HEALBOT_WATER_SHIELD .. HEALBOT_RANK_2] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 28 },
        [HEALBOT_WATER_SHIELD .. HEALBOT_RANK_3] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 34 },
        [HEALBOT_WATER_SHIELD .. HEALBOT_RANK_4] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 41 },
        [HEALBOT_WATER_SHIELD .. HEALBOT_RANK_5] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 48 },
        [HEALBOT_WATER_SHIELD .. HEALBOT_RANK_6] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 55 },
        [HEALBOT_WATER_SHIELD .. HEALBOT_RANK_7] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 62 },
        [HEALBOT_WATER_SHIELD .. HEALBOT_RANK_8] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 69 },
        [HEALBOT_WATER_SHIELD .. HEALBOT_RANK_9] = {
            CastTime = 0, Cast = 0, Duration = 600, Mana = 0, HealsMin = 0, HealsMax = 0, HealsExt =  0, Level = 76 },

        [HEALBOT_RIPTIDE] = {},
        [HEALBOT_RIPTIDE .. HEALBOT_RANK_1] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 250, HealsMin = 639, HealsMax = 691, HealsExt =  500, Level = 60 },
        [HEALBOT_RIPTIDE .. HEALBOT_RANK_2] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 405, HealsMin = 849, HealsMax = 919, HealsExt =  665, Level = 70 },
        [HEALBOT_RIPTIDE .. HEALBOT_RANK_3] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 800, HealsMin = 888, HealsMax = 960, HealsExt =  695, Level = 75 },
        [HEALBOT_RIPTIDE .. HEALBOT_RANK_4] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana = 1500, HealsMin = 1015, HealsMax = 1099, HealsExt =  795, Level = 80 },
            
--    };
--  end

--  if strsub(class,1,4)==HealBot_Class_En[HEALBOT_HUNTER] then
--  Hunter
--    HealBot_Spells = {
        [HEALBOT_MENDPET] = {},
        [HEALBOT_MENDPET .. HEALBOT_RANK_1] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  40, HealsMin = 0, HealsMax = 0, HealsExt =   125, Level =  12, Buff = HEALBOT_MENDPET }, 
        [HEALBOT_MENDPET .. HEALBOT_RANK_2] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  70, HealsMin = 0, HealsMax = 0, HealsExt =   250, Level =  20, Buff = HEALBOT_MENDPET }, 
        [HEALBOT_MENDPET .. HEALBOT_RANK_3] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  100, HealsMin = 0, HealsMax = 0, HealsExt =   450, Level =  28, Buff = HEALBOT_MENDPET }, 
        [HEALBOT_MENDPET .. HEALBOT_RANK_4] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  130, HealsMin = 0, HealsMax = 0, HealsExt =   700, Level =  36, Buff = HEALBOT_MENDPET }, 
        [HEALBOT_MENDPET .. HEALBOT_RANK_5] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  165, HealsMin = 0, HealsMax = 0, HealsExt =   1000, Level =  44, Buff = HEALBOT_MENDPET }, 
        [HEALBOT_MENDPET .. HEALBOT_RANK_6] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  200, HealsMin = 0, HealsMax = 0, HealsExt =   1400, Level =  52, Buff = HEALBOT_MENDPET }, 
        [HEALBOT_MENDPET .. HEALBOT_RANK_7] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  250, HealsMin = 0, HealsMax = 0, HealsExt =   1825, Level =  60, Buff = HEALBOT_MENDPET }, 
        [HEALBOT_MENDPET .. HEALBOT_RANK_8] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  300, HealsMin = 0, HealsMax = 0, HealsExt =   2375, Level =  68, Buff = HEALBOT_MENDPET }, 
        [HEALBOT_MENDPET .. HEALBOT_RANK_9] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  610, HealsMin = 0, HealsMax = 0, HealsExt =   4250, Level =  74, Buff = HEALBOT_MENDPET }, 
        [HEALBOT_MENDPET .. HEALBOT_RANK_10] = {
            CastTime = 0, Cast = 0, Duration = 15, Mana =  750, HealsMin = 0, HealsMax = 0, HealsExt =   5250, Level =  80, Buff = HEALBOT_MENDPET }, 
    };
--  end

end


function HealBot_Init_SmartCast()
    if strsub(HealBot_PlayerClassEN,1,4)=="PRIE" then
        SmartCast_Res=HEALBOT_RESURRECTION;
    elseif strsub(HealBot_PlayerClassEN,1,4)=="DRUI" then
        SmartCast_Res=HEALBOT_REVIVE;
    elseif strsub(HealBot_PlayerClassEN,1,4)=="PALA" then
        SmartCast_Res=HEALBOT_REDEMPTION;
    elseif strsub(HealBot_PlayerClassEN,1,4)=="SHAM" then
        SmartCast_Res=HEALBOT_ANCESTRALSPIRIT;
    end
end
