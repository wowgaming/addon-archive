function AllStats_OnLoad()
	CharacterAttributesFrame:Hide();
	CharacterModelFrame:SetHeight(300);
	PaperDollFrame_UpdateStats = NewPaperDollFrame_UpdateStats;
end

function NewPaperDollFrame_UpdateStats()
	PrintStats();
end

function PrintStats()
	local str = AllStatsFrameStat1;
	local agi = AllStatsFrameStat2;
	local sta = AllStatsFrameStat3;
	local int = AllStatsFrameStat4;
	local spi = AllStatsFrameStat5;

	local md = AllStatsFrameStatMeleeDamage;
	local ms = AllStatsFrameStatMeleeSpeed;
	local mp = AllStatsFrameStatMeleePower;
	local mh = AllStatsFrameStatMeleeHit;
	local mc = AllStatsFrameStatMeleeCrit;
	local me = AllStatsFrameStatMeleeExpert;

	local rd = AllStatsFrameStatRangeDamage;
	local rs = AllStatsFrameStatRangeSpeed;
	local rp = AllStatsFrameStatRangePower;
	local rh = AllStatsFrameStatRangeHit;
	local rc = AllStatsFrameStatRangeCrit;

	local sd = AllStatsFrameStatSpellDamage;
	local she = AllStatsFrameStatSpellHeal;
	local shi = AllStatsFrameStatSpellHit;
	local sc = AllStatsFrameStatSpellCrit;
	local sha = AllStatsFrameStatSpellHaste;
	local sr = AllStatsFrameStatSpellRegen;

	local armor = AllStatsFrameStatArmor;
	local def = AllStatsFrameStatDefense;
	local dodge = AllStatsFrameStatDodge;
	local parry = AllStatsFrameStatParry;
	local block = AllStatsFrameStatBlock;
	local res = AllStatsFrameStatResil;


	PaperDollFrame_SetStat(str, 1);
	PaperDollFrame_SetStat(agi, 2);
	PaperDollFrame_SetStat(sta, 3);
	PaperDollFrame_SetStat(int, 4);
	PaperDollFrame_SetStat(spi, 5);

	PaperDollFrame_SetDamage(md);
	md:SetScript("OnEnter", CharacterDamageFrame_OnEnter);
	PaperDollFrame_SetAttackSpeed(ms);
	PaperDollFrame_SetAttackPower(mp);
	PaperDollFrame_SetRating(mh, CR_HIT_MELEE);
	PaperDollFrame_SetMeleeCritChance(mc);
	PaperDollFrame_SetExpertise(me);

	PaperDollFrame_SetRangedDamage(rd);
	rd:SetScript("OnEnter", CharacterRangedDamageFrame_OnEnter);
	PaperDollFrame_SetRangedAttackSpeed(rs);
	PaperDollFrame_SetRangedAttackPower(rp);
	PaperDollFrame_SetRating(rh, CR_HIT_RANGED);
	PaperDollFrame_SetRangedCritChance(rc);

	PaperDollFrame_SetSpellBonusDamage(sd);
	sd:SetScript("OnEnter", CharacterSpellBonusDamage_OnEnter);
	PaperDollFrame_SetSpellBonusHealing(she);
	PaperDollFrame_SetRating(shi, CR_HIT_SPELL);
	PaperDollFrame_SetSpellCritChance(sc);
	sc:SetScript("OnEnter", CharacterSpellCritChance_OnEnter);
	PaperDollFrame_SetSpellHaste(sha);
	PaperDollFrame_SetManaRegen(sr);

	PaperDollFrame_SetArmor(armor);
	PaperDollFrame_SetDefense(def);
	PaperDollFrame_SetDodge(dodge);
	PaperDollFrame_SetParry(parry);
	PaperDollFrame_SetBlock(block);
	PaperDollFrame_SetResilience(res);
end

local AllStatsShowFrame = true;

function AllStatsButtonShowFrame_OnClick()
	AllStatsShowFrame = not AllStatsShowFrame;
	if AllStatsShowFrame then
		AllStatsFrame:Show();
	else
		AllStatsFrame:Hide();
	end
end
