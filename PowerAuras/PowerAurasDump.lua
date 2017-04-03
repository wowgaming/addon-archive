--[[

powa_dump.lua
Power Auras debug dump function

--]]

--==============================================
-- Dump eveything we can think of into PowaState
--==============================================
function PowaAuras:Dump()

	--self:Dump_Safe();
	
	local Status, Err = pcall(PowaAuras.Dump_Safe, self);

	if (not Status) then
		self:Message(Err); -- OK
		self:DisplayText(self.Colors.Red, "Error in dump protected call: ", Err);
	else
		self:DisplayText(self.Colors.Green, "Dump OK");	
	end
end

function PowaAuras:Dump_Safe()
	PowaState = {};
	-- Build
	if (GetBuildInfo~=nil) then
		local version, buildnum, builddate, toc = GetBuildInfo();
		PowaState["BuildInfo"] = {Version=version, BuildNum=buildnum, BuildDate=builddate, Toc=toc};
	end
	-- Time
	PowaState["Time"] = GetTime();
	-- Locale
	PowaState["Locale"] = GetLocale();
	-- Zone
	PowaState["Zone"] = GetRealZoneText();
	-- Realm
	PowaState["Realm"] = GetRealmName();
	-- CurrentMapZone
	PowaState["CurrentMapZone"] = GetCurrentMapZone();
	-- CurrentMapContinent
	PowaState["CurrentMapContinent"] = GetCurrentMapContinent();
	--ActiveTalentGroup
	PowaState["ActiveTalentGroup"] = GetActiveTalentGroup()
	-- IsInInstance
	PowaState["IsInInstance"] = IsInInstance();
	-- IsMounted
	PowaState["IsMounted"] = IsMounted();
	-- IsFlying
	PowaState["IsFlying"] = IsFlying();
	-- IsResting
	PowaState["IsResting"] = IsResting();
	-- Player
	PowaState["player"] = self:GetUnitInfo("player");
	-- PlayerPet
	PowaState["playerpet"] = self:GetUnitInfo("playerpet");
	-- Target
	PowaState["target"] = self:GetUnitInfo("target");
	-- TargetPet
	PowaState["targetpet"] = self:GetUnitInfo("targetpet");
	-- TargetTarget
	PowaState["targettarget"] = self:GetUnitInfo("targettarget");
	--ComboPoints
	PowaState["ComboPoints"] = {player=GetComboPoints("player"), vehicle=GetComboPoints("vehicle")};
	-- Weapon Enchant
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
	PowaState.WeaponEnchant = {hasMainHandEnchant=hasMainHandEnchant, mainHandExpiration=mainHandExpiration, mainHandCharges=mainHandCharges, hasOffHandEnchant=hasOffHandEnchant, offHandExpiration=offHandExpiration, offHandCharges=offHandCharges};
	-- Stances
	local numforms = GetNumShapeshiftForms();
	PowaState["NumShapeshiftForms"] =  numforms;
	if (numforms>0) then
		PowaState["ShapeshiftFormInfo"] = {};
		for iForm=1, NUM_SHAPESHIFT_SLOTS do
			local icon, name, active, castable = GetShapeshiftFormInfo(iForm);
			PowaState["ShapeshiftFormInfo"][iForm] = {Icon=icon, Name=name, Active=active, Castable=castable};
		end
	end
	PowaState["ShapeshiftForm"] =  GetShapeshiftForm(false);

	
	-- CTRA MainTanks
	if (CT_RA_MainTanks~=nil) then
		PowaState.CT_RA_MainTanks = {};
		for Index, MTName in pairs(CT_RA_MainTanks) do
			PowaState.CT_RA_MainTanks[Index] = MTName;
		end
	end
	-- RDX MainTanks
	if (RDX~=nil and RDXM.Assists~=nil and RDXM.Assists.cfg~=nil and RDXM.Assists.cfg.mtarray~=nil) then
		PowaState.RDX_MainTanks = {};
		for Index, MTName in pairs(RDXM.Assists.cfg.mtarray) do
			PowaState.RDX_MainTanks[Index] = MTName;
		end
	end
	-- oRA MainTanks
	if (oRA_MainTank~=nil and oRA_MainTank.MainTankTable~=nil) then
		PowaState.oRA_MainTanks = {};
		for Index, MTName in pairs(oRA_MainTank.MainTankTable) do
			PowaState.oRA_MainTanks[Index] = MTName;
		end
	end	

	-- Slots
	PowaState["Inventory"] = {};
	PowaState.Inventory["Slot"] = {};
	PowaState.Inventory["ItemLink"] = {};
	PowaState.Inventory["ItemCooldown"] = {};
	self:GetSlotInfo("HeadSlot");
	self:GetSlotInfo("NeckSlot");
	self:GetSlotInfo("ShoulderSlot");
	self:GetSlotInfo("BackSlot");
	self:GetSlotInfo("ChestSlot");
	self:GetSlotInfo("ShirtSlot");
	self:GetSlotInfo("TabardSlot");
	self:GetSlotInfo("WristSlot");
	self:GetSlotInfo("HandsSlot");
	self:GetSlotInfo("WaistSlot");
	self:GetSlotInfo("LegsSlot");
	self:GetSlotInfo("FeetSlot");
	self:GetSlotInfo("Finger0Slot");
	self:GetSlotInfo("Finger1Slot");
	self:GetSlotInfo("Trinket0Slot");
	self:GetSlotInfo("Trinket1Slot");
	self:GetSlotInfo("MainHandSlot");
	self:GetSlotInfo("SecondaryHandSlot");
	self:GetSlotInfo("RangedSlot");
	self:GetSlotInfo("AmmoSlot");
	self:GetSlotInfo("Bag0Slot");
	self:GetSlotInfo("Bag1Slot");
	self:GetSlotInfo("Bag2Slot");
	self:GetSlotInfo("Bag3Slot");

	-- SpellTabs
	PowaState.SpellTabs = {};
	for i = 1, MAX_SKILLLINE_TABS do
		local Name, Texture, Offset, Count = GetSpellTabInfo(i);
		PowaState.SpellTabs[i] = {Name=Name, Texture=Texture, Offset=Offset, Count=Count};
	end
	-- Spells
	PowaState.SpellBook = {};
	local i = 1;
	while (true) do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
		local Texture = GetSpellTexture(i, BOOKTYPE_SPELL);
		if (spellName==nil or Texture==nil) then
			do break end
		end
		PowaState.SpellBook[i] = {Name=spellName, Rank=spellRank, Texture=Texture};
		local StartTime, Duration, Enabled = GetSpellCooldown(i, BOOKTYPE_SPELL);
		PowaState.SpellBook[i]["Cooldown"] = {StartTime=StartTime, Duration=Duration, Enabled=Enabled};
		PowaState.SpellBook[i]["UsableSpell"] = IsUsableSpell(spellName);
		self:ResetTooltip();
		PowaAuras_Tooltip:SetSpell(i, BOOKTYPE_SPELL);
		self:CaptureTooltip(PowaState.SpellBook[i]);
		PowaState.SpellBook[spellName] = PowaState.SpellBook[i];
		i = i + 1;
	end
	-- Debuff Spells
	PowaState.DebuffSpellInfo = {}
	--self:DisplayText("Debuff Spells");	
	for k in pairs(PowaAuras.DebuffTypeSpellIds) do
		--self:DisplayText(k, " ", v);	
		local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(k);
		if name then
			PowaState.DebuffSpellInfo[k] = {Name=name, Rank=rank, Icon=icon, Cost=cost, IsFunnel=isFunnel, PowerType=powerType, CastTime=castTime, MinRange=minRange, MaxRange=maxRange};
		end
	end
	-- SpellIds used in auras
	--self:DisplayText("Aura Spells");	
	PowaState.SpellInfo = {}
	for id, aura in pairs(PowaAuras.Auras) do
		for pword in string.gmatch(aura.buffname, "[^/]+") do
			local _, _,spellId = string.find(pword, "%[(%d+)%]")
			if (spellId) then		
				--self:DisplayText(id, " ", aura);	
				--self:DisplayText(" ", pword, "  ", spellId);	
				local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(tonumber(spellId));
				if name then
					PowaState.SpellInfo[tonumber(spellId)] = {Name=name, Rank=rank, Icon=icon, Cost=cost, IsFunnel=isFunnel, PowerType=powerType, CastTime=castTime, MinRange=minRange, MaxRange=maxRange};
				end
			end
		end
	end


	-- BonusScan
	if (BonusScanner~=nil and
		BonusScanner.active==1 and
		BonusScanner.bonuses~=nil and
		BonusScanner.bonuses.HEAL~=nil) then
		PowaState.BonusScanner = {Active=BonusScanner.active, Heal=BonusScanner.bonuses.HEAL};
	end
	-- ActionSlots
	PowaState.ActionSlots = {};
	for Id = 1, 120 do
		local Text = GetActionText(Id);
		local cdStart, cdDuration, cdEnabled = GetActionCooldown(Id);
		PowaState.ActionSlots[Id] = {HasAction=HasAction(Id),
									ActionText=Text,
									InRange=IsActionInRange(Id),
									HasRange=ActionHasRange(Id),
									CurrentAction=IsCurrentAction(Id),
									AutoRepeatAction=IsAutoRepeatAction(Id),
									UsableAction=IsUsableAction(Id),
									AttackAction=IsAttackAction(Id),
									Texture=GetActionTexture(Id),
									Count=GetActionCount(Id),
									Cooldown={Start=cdStart, Duration=cdDuration, Enabled=cdEnabled},
									};
		if (Text==nil and HasAction(Id)) then
			self:ResetTooltip();
			PowaAuras_Tooltip:SetAction(Id);
			self:CaptureTooltip(PowaState.ActionSlots[Id]);
		end
	end
	--Bags
	PowaState.Bags = {};
	for bag = 0, NUM_BAG_FRAMES do
		PowaState.Bags[bag] = {Slots=GetContainerNumSlots(bag)};
		for slot = 1, GetContainerNumSlots(bag) do
			local itemName = GetContainerItemLink(bag, slot);
			if itemName then
				local texture, count = GetContainerItemInfo(bag, slot);
				PowaState.Bags[bag][slot] = {Name=itemName, Texture=texture, Count=count};
			end
		end
	end
	--Macros
	PowaState.Macros = {};
	for Id = 1, 36 do
		local Name, IconTexture, Body = GetMacroInfo(Id);
		PowaState.Macros[Id] = {Name=Name, Texture=IconTexture, Body=self:Escape(Body)};
	end
	
	-- Totems
	PowaState.Totem = {};
	for slot = 1, 4 do
		local haveTotem, name, startTime, duration, icon = GetTotemInfo(1);
		PowaState.Totem[slot] = {HaveTotem=haveTotem, Name=name, StartTime=startTime, Duration=duration, Icon=icon};
	end
			
    -- Inventory Slots
	PowaState.InventorySlot = {};
	for k, v in pairs (PowaAuras.Text.Slots) do
		local slotId, emptyTexture = GetInventorySlotInfo(k.."Slot");
		PowaState.InventorySlot[k.."Slot"] = {SlotId=slotId, EmptyTexture=emptyTexture};
	end

	-- Tracking
	PowaState.NumTrackingTypes = GetNumTrackingTypes();
	PowaState.Tracking = {};
	for i = 1, PowaState.NumTrackingTypes do 
		local name, texture, active, category = GetTrackingInfo(i);
		PowaState.Tracking[i] = { Name= name, Texture=texture, Active=active, Category=category};
	end
	
	--Groups
	PowaState["RaidLeader"] = IsRaidLeader();
	PowaState["PartyLeader"] = IsPartyLeader();
	PowaState["PartyLeaderIndex"] = GetPartyLeaderIndex();
	
	local numpm = GetNumPartyMembers();
	local numrm = GetNumRaidMembers();
	--Raid
	if (numrm>0) then
		PowaState.Raid = {Count=numrm};
		PowaState.Raid.Roster = {};
		for Id = 1, 40 do
			local unit = "raid"..Id;
			if (UnitExists(unit)) then
				PowaState.Raid[unit] = self:GetUnitInfo(unit);
				PowaState.Raid["raidpet"..Id] = self:GetUnitInfo("raidpet"..Id);
				PowaState.Raid[unit.."Target"] = self:GetUnitInfo(unit.."Target");
				PowaState.Raid[unit.."TargetTarget"] = self:GetUnitInfo(unit.."TargetTarget");
			end
			local name, rank, subgroup, level, classloc, class, zone, online, isDead = GetRaidRosterInfo(Id);
			PowaState.Raid.Roster[Id] = {Name=name, Rank=rank, Subgroup=subgroup, Level=level, ClassLoc=classloc, Class=class, Zone=zone, Online=online, IsDead=isDead};
		end
	end
	--Party
	if (numpm>0) then
		PowaState.Party = {Count=numpm};
		for Id = 1, 4 do
			local unit = "party"..Id;
			if (UnitExists(unit)) then
				PowaState.Party[unit] = self:GetUnitInfo(unit);
				PowaState.Party["partypet"..Id] = self:GetUnitInfo("partypet"..Id);
				PowaState.Party[unit.."Target"] = self:GetUnitInfo(unit.."Target");
				PowaState.Party[unit.."TargetTarget"] = self:GetUnitInfo(unit.."TargetTarget");
			end
		end
	end
	
	--Battlefields
	PowaState.Battlefields = {};
	for Id=1, MAX_BATTLEFIELD_QUEUES do
		local bgstatus, BGName, instanceID = GetBattlefieldStatus(Id);
		PowaState.Battlefields[Id] = {Status=bgstatus, Name=BGName, Id=instanceID};
	end
	
	-- Powa
	PowaState.Powa = self:CopyTable(PowaAuras);
	PowaState.PowaGlobalListe = self:CopyTable(PowaGlobalListe);
	PowaState.PowaPlayerListe = self:CopyTable(PowaPlayerListe);

end

-- Extract details for specified unit
function PowaAuras:GetUnitInfo(unit)
	if (not UnitExists(unit)) then
		return nil;
	end

	--self:Message("GetUnitInfo for " .. tostring(unit));

	local UnitInfo = {Unit=unit}
	local Name, Realm = UnitName(unit)
	UnitInfo["Name"] = Name;
	UnitInfo["Realm"] = Realm;
	UnitInfo["Level"] = UnitLevel(unit);
	local LocClass, Class= UnitClass(unit);
	UnitInfo["LocClass"] = LocClass;
	UnitInfo["Class"] = Class;
	UnitInfo["Sex"] = UnitSex(unit);
	UnitInfo["Connected"] = UnitIsConnected(unit);
	UnitInfo["Dead"] = UnitIsDead(unit);
	UnitInfo["Ghost"] = UnitIsGhost(unit);
	UnitInfo["DeadOrGhost"] = UnitIsDeadOrGhost(unit);
	UnitInfo["Corpse"] = UnitIsCorpse(unit);
	UnitInfo["Player"] = UnitIsUnit(unit, "player");
	UnitInfo["Visible"] = UnitIsVisible(unit);
	UnitInfo["Enemy"] = UnitIsEnemy(unit, "player");
	UnitInfo["Friend"] = UnitIsFriend(unit, "player");
	UnitInfo["PVP"] = UnitIsPVP(unit);
	UnitInfo["ThreatSituation"] = UnitThreatSituation(unit);
	UnitInfo["CanAttack"] = UnitCanAttack(unit, "player");
	UnitInfo["CanBeAttacked"] = UnitCanAttack("player", unit);
	UnitInfo["CanCooperate"] = UnitCanCooperate("player", unit);
	local X, Y = GetPlayerMapPosition(unit);
	UnitInfo["Pos"]= {X=X, Y=Y};
	UnitInfo["InteractDistance"] = {[1]=CheckInteractDistance(unit, 1);
									[2]=CheckInteractDistance(unit, 2),
									[3]=CheckInteractDistance(unit, 3),
									[4]=CheckInteractDistance(unit, 4)};
	UnitInfo["InParty"] = UnitInParty(unit);
	UnitInfo["UnitInRaid"] = UnitInRaid(unit);
	UnitInfo["PlayerOrPetInParty"] = UnitPlayerOrPetInParty(unit);
	UnitInfo["PlayerOrPetInRaid"] = UnitPlayerOrPetInRaid(unit);

	self:ResetTooltip();
	PowaAuras_Tooltip:SetUnit(unit);
	self:CaptureTooltip(UnitInfo)

	UnitInfo["InCombat"] = UnitAffectingCombat(unit);
	UnitInfo["TargetInCombat"] = UnitAffectingCombat(unit, "target");

	UnitInfo.Buffs = {};
	local Index = 1;
	local Name, Rank, Icon, Applications, Type, Duration, Expires, Source, Stealable, shouldConsolidate, spellId = UnitAura(unit, Index, "HELPFUL");
	while (Name~=nil) do
		UnitInfo.Buffs[Index] = {Name=Name, Applications=Applications, Type=Type, Rank=Rank, Icon=Icon, Duration=Duration, Expires=Expires, Source=Source, Stealable=Stealable, ShouldConsolidate=shouldConsolidate, SpellId=spellId};
		self:ResetTooltip();
		PowaAuras_Tooltip:SetUnitBuff(unit, Index);
		self:CaptureTooltip(UnitInfo["Buffs"][Index])
		Index = Index + 1;
		 Name, Rank, Icon, Applications, Type, Duration, Expires, Source, Stealable, shouldConsolidate, spellId = UnitAura(unit, Index, "HELPFUL");
	end

	UnitInfo.Debuffs = {};
	Index = 1;
	Name, Rank, Icon, Applications, Type, Duration, Expires, Source, Stealable, shouldConsolidate, spellId = UnitAura(unit, Index, "HARMFUL");
	while (Name~=nil) do
		UnitInfo.Debuffs[Index] = {Name=Name, Applications=Applications, Type=Type, Rank=Rank, Icon=Icon, Duration=Duration, Expires=Expires, Source=Source, Stealable=Stealable, ShouldConsolidate=shouldConsolidate, SpellId=spellId};
		self:ResetTooltip();
		PowaAuras_Tooltip:SetUnitDebuff(unit, Index);
		self:CaptureTooltip(UnitInfo["Debuffs"][Index]);
		Index = Index + 1;
		Name, Rank, Icon, Applications, Type, Duration, Expires, Source, Stealable, shouldConsolidate, spellId = UnitAura(unit, Index, "HARMFUL");
	end

	UnitInfo.RemoveableDebuffs = {};
	Index = 1;
	Name, Rank, Icon, Applications, Type, Duration, Expires, Source, Stealable = UnitDebuff(unit, Index, 1);
	while (Name~=nil) do
		UnitInfo.RemoveableDebuffs[Index] = {Name=Name, Applications=Applications, Type=Type, Rank=Rank, Icon=Icon, Duration=Duration, Expires=Expires, Source=Source, Stealable=Stealable};
		self:ResetTooltip();
		PowaAuras_Tooltip:SetUnitDebuff(unit, Index);
		self:CaptureTooltip(UnitInfo["RemoveableDebuffs"][Index]);
		Index = Index + 1;
		Name, Rank, Icon, Applications, Type, Duration, Expires, Source, Stealable = UnitDebuff(unit, Index, 1);
	end

	local StatIndex = {[1]="Strength", [2]="Agility", [3]="Stamina", [4]="Intellect", [5]="Spirit"};
	UnitInfo["Stats"] = {};
    for Index = 1, 5 do
		local base, stat, posBuff, negBuff = UnitStat(unit, Index);
		UnitInfo.Stats[Index] = {Type=StatIndex[Index], Base=base, Stat=stat, PosBuff=posBuff, NegBuff=negBuff};
	end

	local ResIndex = {[0]="Physical", [1]="Holy", [2]="Fire", [3]="Nature", [4]="Frost", [5]="Shadow", [6]="Arcane"};
	UnitInfo.Resistances = {};
    for Index = 0, 6 do
		local base, total, bonus, malus = UnitResistance(unit, Index)
		UnitInfo["Resistances"][Index] = {Type=ResIndex[Index], Base=base, Total=total, Bonus=bonus, Malus=malus};
	end

    UnitInfo["Armor"] = UnitArmor(unit);
    UnitInfo["AttackBothHands"] = UnitAttackBothHands(unit);
    UnitInfo["AttackPower"] = UnitAttackPower(unit);
    UnitInfo["AttackSpeed"] = UnitAttackSpeed(unit);
    UnitInfo["Classification"] = UnitClassification(unit);
    UnitInfo["CreatureFamily"] = UnitCreatureFamily(unit);
    UnitInfo["CreatureType"] = UnitCreatureType(unit) ;
    UnitInfo["Damage"] = UnitDamage(unit);
	local defense, defenseModifier = UnitDefense(unit);
    UnitInfo["Defense"] = defense;
	UnitInfo["DefenseModifier"] = defenseModifier;
    UnitInfo["FactionGroup"] = UnitFactionGroup(unit);
    UnitInfo["Health"] = UnitHealth(unit);
    UnitInfo["HealthMax"] = UnitHealthMax(unit) ;
    UnitInfo["IsCharmed"] = UnitIsCharmed(unit);
    --UnitInfo["IsCivilian"] = UnitIsCivilian(unit);
    UnitInfo["IsPartyLeader"] = UnitIsPartyLeader(unit);
    UnitInfo["IsPlayer"] = UnitIsPlayer(unit);
   -- UnitInfo["IsPlusMob"] = UnitIsPlusMob(unit);
    UnitInfo["IsTapped"] = UnitIsTapped(unit);
    UnitInfo["IsTappedByPlayer"] = UnitIsTappedByPlayer(unit);
    UnitInfo["IsTrivial"] = UnitIsTrivial(unit);
	
    UnitInfo["InVehicle"] = UnitInVehicle(unit);
	
    UnitInfo["Mana"] = UnitMana(unit);
    UnitInfo["ManaMax"] = UnitManaMax(unit);
    UnitInfo["Power"] = {};
    UnitInfo["PowerMax"] = {};
    UnitInfo.Power.Default = UnitPower(unit);
    UnitInfo.PowerMax.Default = UnitPowerMax(unit);
	for powerType=0,6 do
		UnitInfo.Power[powerType] = UnitPower(unit, powerType);
		UnitInfo.PowerMax[powerType] = UnitPowerMax(unit, powerType);
	end
	local powerType, powerTypeString = UnitPowerType(unit);
    UnitInfo["PowerType"] = powerType;
    UnitInfo["PowerTypeString"] = powerTypeString;
	UnitInfo.RuneCooldown  = {};
	UnitInfo.RuneType  = {};
	for runeId=1,6 do
		local runeStart, runeDuration, runeReady = GetRuneCooldown(runeId)
		UnitInfo.RuneCooldown[runeId] = {Start=runeStart, Duration=runeDuration, RuneReady=runeReady};
		UnitInfo.RuneType[runeId] = GetRuneType(runeId);
	end
    UnitInfo["OnTaxi"] = UnitOnTaxi(unit);
    UnitInfo["PVPName"] = UnitPVPName(unit) ;
    UnitInfo["PVPRank"] = UnitPVPRank(unit);
    UnitInfo["Race"] = UnitRace(unit);
    UnitInfo["RangedAttack"] = UnitRangedAttack(unit);
    UnitInfo["RangedAttackPower"] = UnitRangedAttackPower(unit);
    UnitInfo["RangedDamage"] = UnitRangedDamage(unit);
	Name, Realm = UnitName(unit.."Target")
    UnitInfo["Target"] = Name;
    UnitInfo["TargetRealm"] = Realm;
	Name, Realm = UnitName(unit.."TargetTarget")
    UnitInfo["TargetTarget"] = Name;
    UnitInfo["TargetTargetRealm"] = Realm;
    UnitInfo["XP"] = UnitXP(unit);
    UnitInfo["XPMax"] = UnitXPMax(unit);
	UnitInfo["UnitHasVehicleUI"] = UnitHasVehicleUI(unit);
	local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo(unit);
	UnitInfo["CastingInfo"] = {Spell=spell, Rank=rank, DisplayName=displayName, Icon=icon, StartTime=startTime, EndTime=endTime, IsTradeSkill=isTradeSkill};
	spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo(unit);
	UnitInfo["ChannelInfo"] = {Spell=spell, Rank=rank, DisplayName=displayName, Icon=icon, StartTime=startTime, EndTime=endTime, IsTradeSkill=isTradeSkill};

	return UnitInfo;
end

-- Extract details for specified slot
function PowaAuras:GetSlotInfo(slot)
	local Id, Texture = GetInventorySlotInfo(slot);
	if (Id~=nil) then
		PowaState.Inventory.Slot[slot] = {Id=Id, Texture=Texture, Slot=slot};
		PowaState.Inventory.ItemLink[Id] = GetInventoryItemLink("player", Id);
		PowaState.Inventory.ItemCooldown[Id] = GetInventoryItemCooldown("player", Id);
		PowaState.Inventory.Slot[Id] = PowaState.Inventory.Slot[slot]
		self:ResetTooltip();
		PowaAuras_Tooltip:SetInventoryItem("player", Id);
		self:CaptureTooltip(PowaState.Inventory.Slot[Id]);
	end
end

function PowaAuras:Escape(text)
	if (text==nil) then
		return nil;
	end
	return string.gsub(string.gsub(text, "\n", "<LF>"), "\r", "<CR>");
end

function PowaAuras:ResetTooltip()
	for z = 1, 9 do
		local line = getglobal("PowaAuras_TooltipTextLeft"..z);
		if (line~=nil) then line:SetText(nil); end
		line = getglobal("PowaAuras_TooltipTextRight"..z);
		if (line~=nil) then line:SetText(nil); end
	end
	PowaAuras_Tooltip:ClearLines();
	PowaAuras_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");
end

function PowaAuras:CaptureTooltip(store)
	store["Tooltip"] = {};
	store.Tooltip.NumLines = PowaAuras_Tooltip:NumLines();
	for z = 1, PowaAuras_Tooltip:NumLines() do
		local line = getglobal("PowaAuras_TooltipTextLeft"..z);
		store.Tooltip["Left"..z]  = self:Escape(line:GetText());
		line = getglobal("PowaAuras_TooltipTextRight"..z);
		store.Tooltip["Right"..z] = self:Escape(line:GetText());
	end
end

