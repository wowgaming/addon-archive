--[[ Code Credits - to the people whose code I borrowed and learned from:
Wowwiki
Kollektiv
Tuller
ckknight
The authors of Nao!!
And of course, Blizzard

Thanks! :)
]]

local L = "LoseControl"
local UIParent = UIParent -- it's faster to keep local references to frequently used global vars

local function log(msg) DEFAULT_CHAT_FRAME:AddMessage(msg) end -- alias for convenience

-------------------------------------------------------------------------------
local spellIds = {
	-- Death Knight
	[47481] = "CC",		-- Gnaw (Ghoul)
	[51209] = "CC",		-- Hungering Cold
	[47476] = "Silence",	-- Strangulate
	[45524] = "Snare",	-- Chains of Ice
	[55666] = "Snare",	-- Desecration (no duration, lasts as long as you stand in it)
	[58617] = "Snare",	-- Glyph of Heart Strike
	[50436] = "Snare",	-- Icy Clutch (Chilblains)
	-- Druid
	[5211]  = "CC",		-- Bash (also Shaman Spirit Wolf ability)
	[33786] = "CC",		-- Cyclone
	[2637]  = "CC",		-- Hibernate (works against Druids in most forms and Shamans using Ghost Wolf)
	[22570] = "CC",		-- Maim
	[9005]  = "CC",		-- Pounce
	[339]   = "Root",	-- Entangling Roots
	[19675] = "Root",	-- Feral Charge Effect (immobilize with interrupt [spell lockout, not silence])
	[58179] = "Snare",	-- Infected Wounds
	[61391] = "Snare",	-- Typhoon
	-- Hunter
	[3355]  = "CC",		-- Freezing Trap Effect
	[24394] = "CC",		-- Intimidation
	[1513]  = "CC",		-- Scare Beast (works against Druids in most forms and Shamans using Ghost Wolf)
	[19503] = "CC",		-- Scatter Shot
	[19386] = "CC",		-- Wyvern Sting
	[34490] = "Silence",	-- Silencing Shot
	[53359] = "Disarm",	-- Chimera Shot - Scorpid
	[19306] = "Root",	-- Counterattack
	[19185] = "Root",	-- Entrapment
	[35101] = "Snare",	-- Concussive Barrage
	[5116]  = "Snare",	-- Concussive Shot
	[13810] = "Snare",	-- Frost Trap Aura (no duration, lasts as long as you stand in it)
	[61394] = "Snare",	-- Glyph of Freezing Trap
	[2974]  = "Snare",	-- Wing Clip
	-- Hunter Pets
	[50519] = "CC",		-- Sonic Blast (Bat)
	[50541] = "Disarm",	-- Snatch (Bird of Prey)
	[54644] = "Snare",	-- Froststorm Breath (Chimera)
	[50245] = "Root",	-- Pin (Crab)
	[50271] = "Snare",	-- Tendon Rip (Hyena)
	[50518] = "CC",		-- Ravage (Ravager)
	[54706] = "Root",	-- Venom Web Spray (Silithid)
	[4167]  = "Root",	-- Web (Spider)
	-- Mage
	[44572] = "CC",		-- Deep Freeze
	[31661] = "CC",		-- Dragon's Breath
	[12355] = "CC",		-- Impact
	[118]   = "CC",		-- Polymorph
	[18469] = "Silence",	-- Silenced - Improved Counterspell
	[64346] = "Disarm",	-- Fiery Payback
	[33395] = "Root",	-- Freeze (Water Elemental)
	[122]   = "Root",	-- Frost Nova
	[11071] = "Root",	-- Frostbite
	[55080] = "Root",	-- Shattered Barrier
	[11113] = "Snare",	-- Blast Wave
	[6136]  = "Snare",	-- Chilled (generic effect, used by lots of spells [looks weird on Improved Blizzard, might want to comment out])
	[120]   = "Snare",	-- Cone of Cold
	[116]   = "Snare",	-- Frostbolt
	[47610] = "Snare",	-- Frostfire Bolt
	[31589] = "Snare",	-- Slow
	-- Paladin
	[853]   = "CC",		-- Hammer of Justice
	[2812]  = "CC",		-- Holy Wrath (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
	[20066] = "CC",		-- Repentance
	[20170] = "CC",		-- Stun (Seal of Justice proc)
	[10326] = "CC",		-- Turn Evil (works against Warlocks using Metamorphasis and Death Knights using Lichborne)
	[63529] = "Silence",	-- Shield of the Templar
	[20184] = "Snare",	-- Judgement of Justice (100% movement snare; druids and shamans might want this though)
	-- Priest
	[605]   = "CC",		-- Mind Control
	[64044] = "CC",		-- Psychic Horror
	[8122]  = "CC",		-- Psychic Scream
	[9484]  = "CC",		-- Shackle Undead (works against Death Knights using Lichborne)
	[15487] = "Silence",	-- Silence
	--[64058] = "Disarm",	-- Psychic Horror (duplicate debuff names not allowed atm, need to figure out how to support this later)
	[15407] = "Snare",	-- Mind Flay
	-- Rogue
	[2094]  = "CC",		-- Blind
	[1833]  = "CC",		-- Cheap Shot
	[1776]  = "CC",		-- Gouge
	[408]   = "CC",		-- Kidney Shot
	[6770]  = "CC",		-- Sap
	[1330]  = "Silence",	-- Garrote - Silence
	[18425] = "Silence",	-- Silenced - Improved Kick
	[51722] = "Disarm",	-- Dismantle
	[31125] = "Snare",	-- Blade Twisting
	[3409]  = "Snare",	-- Crippling Poison
	[26679] = "Snare",	-- Deadly Throw
	-- Shaman
	[39796] = "CC",		-- Stoneclaw Stun
	[51514] = "CC",		-- Hex (although effectively a silence+disarm effect, it is conventionally thought of as a "CC", plus you can trinket out of it)
	[64695] = "Root",	-- Earthgrab (Storm, Earth and Fire)
	[63685] = "Root",	-- Freeze (Frozen Power)
	[3600]  = "Snare",	-- Earthbind (5 second duration per pulse, but will keep re-applying the debuff as long as you stand within the pulse radius)
	[8056]  = "Snare",	-- Frost Shock
	[8034]  = "Snare",	-- Frostbrand Attack
	-- Warlock
	[710]   = "CC",		-- Banish (works against Warlocks using Metamorphasis and Druids using Tree Form)
	[6789]  = "CC",		-- Death Coil
	[5782]  = "CC",		-- Fear
	[5484]  = "CC",		-- Howl of Terror
	[6358]  = "CC",		-- Seduction (Succubus)
	[30283] = "CC",		-- Shadowfury
	[24259] = "Silence",	-- Spell Lock (Felhunter)
	[18118] = "Snare",	-- Aftermath
	[18223] = "Snare",	-- Curse of Exhaustion
	-- Warrior
	[7922]  = "CC",		-- Charge Stun
	[12809] = "CC",		-- Concussion Blow
	[20253] = "CC",		-- Intercept (also Warlock Felguard ability)
	[5246]  = "CC",		-- Intimidating Shout
	[12798] = "CC",		-- Revenge Stun
	[46968] = "CC",		-- Shockwave
	[18498] = "Silence",	-- Silenced - Gag Order
	[676]   = "Disarm",	-- Disarm
	[58373] = "Root",	-- Glyph of Hamstring
	[23694] = "Root",	-- Improved Hamstring
	[1715]  = "Snare",	-- Hamstring
	[12323] = "Snare",	-- Piercing Howl
	-- Other
	[30217] = "CC",		-- Adamantite Grenade
	[67769] = "CC",		-- Cobalt Frag Bomb
	[30216] = "CC",		-- Fel Iron Bomb
	[20549] = "CC",		-- War Stomp
	[25046] = "Silence",	-- Arcane Torrent
	[39965] = "Root",	-- Frost Grenade
	[55536] = "Root",	-- Frostweave Net
	[13099] = "Root",	-- Net-o-Matic
	[29703] = "Snare",	-- Dazed
	-- Immunities
	[46924] = "Immune",	-- Bladestorm (Warrior)
	[642]   = "Immune",	-- Divine Shield (Paladin)
	[45438] = "Immune",	-- Ice Block (Mage)
	[34692] = "Immune",	-- The Beast Within (Hunter)
	-- PvE
	[28169] = "PvE",	-- Mutating Injection (Grobbulus)
	[28059] = "PvE",	-- Positive Charge (Thaddius)
	[28084] = "PvE",	-- Negative Charge (Thaddius)
	[27819] = "PvE",	-- Detonate Mana (Kel'Thuzad)
	[63024] = "PvE",	-- Gravity Bomb (XT-002 Deconstructor)
	[63018] = "PvE",	-- Light Bomb (XT-002 Deconstructor)
	[62589] = "PvE",	-- Nature's Fury (Freya, via Ancient Conservator)
	[63276] = "PvE",	-- Mark of the Faceless (General Vezax)
}
local abilities = {} -- localized names are saved here
for k, v in pairs(spellIds) do
	local name = GetSpellInfo(k)
	if name then
		abilities[name] = v
	else -- Thanks to inph for this idea. Keeps things from breaking when Blizzard changes things.
		log(L .. " unknown spellId: " .. k)
	end
end

-------------------------------------------------------------------------------
-- Global references for attaching icons to various unit frames
local anchors = {
	None = {}, -- empty but necessary
	Blizzard = {
		player = "PlayerPortrait",
		target = "TargetFramePortrait",
		focus  = "FocusFramePortrait",
		party1 = "PartyMemberFrame1Portrait",
		party2 = "PartyMemberFrame2Portrait",
		party3 = "PartyMemberFrame3Portrait",
		party4 = "PartyMemberFrame4Portrait",
		arena1 = "ArenaEnemyFrame1ClassPortrait",
		arena2 = "ArenaEnemyFrame2ClassPortrait",
		arena3 = "ArenaEnemyFrame3ClassPortrait",
		arena4 = "ArenaEnemyFrame4ClassPortrait",
		arena5 = "ArenaEnemyFrame5ClassPortrait",
	},
	Perl = {
		player = "Perl_Player_Portrait",
		target = "Perl_Target_Portrait",
		focus  = "Perl_Focus_Portrait",
		party1 = "Perl_Party_MemberFrame1_Portrait",
		party2 = "Perl_Party_MemberFrame2_Portrait",
		party3 = "Perl_Party_MemberFrame3_Portrait",
		party4 = "Perl_Party_MemberFrame4_Portrait",
	},
	XPerl = {
		player = "XPerl_PlayerportraitFrameportrait",
		target = "XPerl_TargetportraitFrameportrait",
		focus  = "XPerl_FocusportraitFrameportrait",
		party1 = "XPerl_party1portraitFrameportrait",
		party2 = "XPerl_party2portraitFrameportrait",
		party3 = "XPerl_party3portraitFrameportrait",
		party4 = "XPerl_party4portraitFrameportrait",
	},
	-- more to come here?
}

-------------------------------------------------------------------------------
-- Default settings
local DBdefaults = {
	version = 3.32,
	noCooldownCount = false,
	tracking = { -- To Do: Priority
		Immune  = false, --100
		CC      = true,  -- 90
		PvE     = true,  -- 80
		Silence = true,  -- 70
		Disarm  = true,  -- 60
		Root    = false, -- 50
		Snare   = false, -- 40
	},
	frames = {
		player = {
			enabled = true,
			size = 36,
			alpha = 1,
			anchor = "None",
		},
		target = {
			enabled = true,
			size = 56,
			alpha = 1,
			anchor = "Blizzard",
		},
		focus = {
			enabled = true,
			size = 44,
			alpha = 1,
			anchor = "Blizzard",
		},
		party1 = {
			enabled = true,
			size = 36,
			alpha = 1,
			anchor = "Blizzard",
		},
		party2 = {
			enabled = true,
			size = 36,
			alpha = 1,
			anchor = "Blizzard",
		},
		party3 = {
			enabled = true,
			size = 36,
			alpha = 1,
			anchor = "Blizzard",
		},
		party4 = {
			enabled = true,
			size = 36,
			alpha = 1,
			anchor = "Blizzard",
		},
		arena1 = {
			enabled = true,
			size = 28,
			alpha = 1,
			anchor = "Blizzard",
		},
		arena2 = {
			enabled = true,
			size = 28,
			alpha = 1,
			anchor = "Blizzard",
		},
		arena3 = {
			enabled = true,
			size = 28,
			alpha = 1,
			anchor = "Blizzard",
		},
		arena4 = {
			enabled = true,
			size = 28,
			alpha = 1,
			anchor = "Blizzard",
		},
		arena5 = {
			enabled = true,
			size = 28,
			alpha = 1,
			anchor = "Blizzard",
		},
	},
}
local LoseControlDB -- local reference to the addon settings. this gets initialized when the ADDON_LOADED event fires

-------------------------------------------------------------------------------
-- Create the main class
local LoseControl = CreateFrame("Cooldown", nil, UIParent) -- Exposes the SetCooldown method

function LoseControl:OnEvent(event, ...) -- functions created in "object:method"-style have an implicit first parameter of "self", which points to object
	self[event](self, ...) -- route event parameters to LoseControl:event methods
end
LoseControl:SetScript("OnEvent", LoseControl.OnEvent)

-- Handle default settings
function LoseControl:ADDON_LOADED(arg1)
	if arg1 == L then
		if _G.LoseControlDB and _G.LoseControlDB.version then
			if _G.LoseControlDB.version < DBdefaults.version then
				if _G.LoseControlDB.version >= 3.22 then -- minor changes, so try to update without losing settings
					_G.LoseControlDB.tracking = {
						Immune  = false, --100
						CC      = true,  -- 90
						PvE     = true,  -- 80
						Silence = true,  -- 70
						Disarm  = true,  -- 60
						Root    = false, -- 50
						Snare   = false, -- 40
					}
					_G.LoseControlDB.version = 3.32
				else -- major changes, must reset settings
					_G.LoseControlDB = CopyTable(DBdefaults)
					log(LOSECONTROL["LoseControl reset."])
				end
			end
		else -- never installed before
			_G.LoseControlDB = CopyTable(DBdefaults)
			log(LOSECONTROL["LoseControl reset."])
		end
		LoseControlDB = _G.LoseControlDB
		LoseControl.noCooldownCount = LoseControlDB.noCooldownCount
	end
end
LoseControl:RegisterEvent("ADDON_LOADED")

-- Initialize a frame's position
function LoseControl:PLAYER_ENTERING_WORLD() -- this correctly anchors enemy arena frames that aren't created until you zone into an arena
	self.frame = LoseControlDB.frames[self.unitId] -- store a local reference to the frame's settings
	local frame = self.frame
	self.anchor = _G[anchors[frame.anchor][self.unitId]] or UIParent

	self:SetParent(self.anchor:GetParent()) -- or LoseControl) -- If Hide() is called on the parent frame, its children are hidden too. This also sets the frame strata to be the same as the parent's.
	--self:SetFrameStrata(frame.strata or "LOW")
	self:ClearAllPoints() -- if we don't do this then the frame won't always move
	self:SetWidth(frame.size)
	self:SetHeight(frame.size)
	self:SetPoint(
		frame.point or "CENTER",
		self.anchor,
		frame.relativePoint or "CENTER",
		frame.x or 0,
		frame.y or 0
	)
	--self:SetAlpha(frame.alpha) -- doesn't seem to work; must manually set alpha after the cooldown is displayed, otherwise it doesn't apply.
end

local WYVERN_STING = GetSpellInfo(19386)
local PSYCHIC_HORROR = GetSpellInfo(64058)
local UnitDebuff = UnitDebuff
local UnitBuff = UnitBuff
-- This is the main event
function LoseControl:UNIT_AURA(unitId) -- fired when a (de)buff is gained/lost
	if unitId ~= self.unitId or not self.frame.enabled or not self.anchor:IsVisible() then return end

	local maxExpirationTime = 0
	local _, name, icon, Icon, duration, Duration, expirationTime, wyvernsting

	for i = 1, 40 do
		name, _, icon, _, _, duration, expirationTime = UnitDebuff(unitId, i)

		if not name then
			--log("UnitDebuff " .. unitId .. " " .. i)
			break
		end -- no more debuffs, terminate the loop
		--log(i .. ") " .. name .. " | " .. rank .. " | " .. icon .. " | " .. count .. " | " .. debuffType .. " | " .. duration .. " | " .. expirationTime )

		-- exceptions
		if name == WYVERN_STING then
			wyvernsting = 1
			if not self.wyvernsting then
				self.wyvernsting = 1 -- this is the first time the debuff has been applied
			elseif expirationTime > self.wyvernsting_expirationTime then
				self.wyvernsting = 2 -- this is the second time the debuff has been applied
			end
			self.wyvernsting_expirationTime = expirationTime
			if self.wyvernsting == 2 then
				name = nil -- hack to skip the next if condition since LUA doesn't have a "continue" statement
			end
		elseif name == PSYCHIC_HORROR and icon == "Interface\\Icons\\Ability_Warrior_Disarm" then -- hack to remove Psychic Horror disarm effect
			name = nil
		end

		if LoseControlDB.tracking[abilities[name]] and expirationTime > maxExpirationTime then
			maxExpirationTime = expirationTime
			Duration = duration
			Icon = icon
		end
	end

	-- continue hack for Wyvern Sting
	if self.wyvernsting == 2 and not wyvernsting then -- dot either removed or expired
		self.wyvernsting = nil
	end

	-- Track Immunities
	if LoseControlDB.tracking.Immune and not Icon and unitId ~= "player" then -- only bother checking for immunities if there were no debuffs found
		for i = 1, 40 do
			name, _, icon, _, _, duration, expirationTime = UnitBuff(unitId, i)
			if not name then
				--log("UnitBuff " .. unitId .. " " .. i)
				break
			elseif abilities[name] == "Immune" and expirationTime > maxExpirationTime then
				maxExpirationTime = expirationTime
				Duration = duration
				Icon = icon
			end
		end
	end

	if maxExpirationTime == 0 then -- no (de)buffs found
		self.maxExpirationTime = 0
		if self.anchor ~= UIParent and self.drawlayer then
			self.anchor:SetDrawLayer(self.drawlayer) -- restore the original draw layer
		end
		self:Hide()
	elseif maxExpirationTime ~= self.maxExpirationTime then -- this is a different (de)buff, so initialize the cooldown
		self.maxExpirationTime = maxExpirationTime
		if self.anchor ~= UIParent then
			self:SetFrameLevel(self.anchor:GetParent():GetFrameLevel()) -- must be dynamic, frame level changes all the time
			if not self.drawlayer then
				self.drawlayer = self.anchor:GetDrawLayer() -- back up the current draw layer
			end
			self.anchor:SetDrawLayer("BACKGROUND") -- Temporarily put the portrait texture below the debuff texture. This is the only reliable method I've found for keeping the debuff texture visible with the cooldown spiral on top of it.
		end
		if self.frame.anchor == "Blizzard" then
			SetPortraitToTexture(self.texture, Icon) -- Sets the texture to be displayed from a file applying a circular opacity mask making it look round like portraits. TO DO: mask the cooldown frame somehow so the corners don't stick out of the portrait frame. Maybe apply a circular alpha mask in the OVERLAY draw layer.
		else
			self.texture:SetTexture(Icon)
		end
		self:Show()
		self:SetCooldown( maxExpirationTime - Duration, Duration )
		self:SetAlpha(self.frame.alpha) -- hack to apply transparency to the cooldown timer
	end
end

function LoseControl:PLAYER_FOCUS_CHANGED()
	self:UNIT_AURA("focus")
end

function LoseControl:PLAYER_TARGET_CHANGED()
	self:UNIT_AURA("target")
end

local UnitDropDown -- declared here, initialized below in the options panel code
local AnchorDropDown
-- Handle mouse dragging
function LoseControl:StopMoving()
	local frame = self.frame --LoseControlDB.frames[self.unitId]
	frame.point, frame.anchor, frame.relativePoint, frame.x, frame.y = self:GetPoint()
	if not frame.anchor then
		frame.anchor = "None"
		if UIDropDownMenu_GetSelectedValue(UnitDropDown) == self.unitId then
			UIDropDownMenu_SetSelectedValue(AnchorDropDown, "None") -- update the drop down to show that the frame has been detached from the anchor
		end
	end
	self.anchor = _G[anchors[frame.anchor][self.unitId]] or UIParent
	self:StopMovingOrSizing()
end

-- Constructor method
function LoseControl:new(unitId)
	local o = CreateFrame("Cooldown", L .. unitId) --, UIParent)
	setmetatable(o, self)
	self.__index = self

	-- Init class members
	o.unitId = unitId -- ties the object to a unit
	o.texture = o:CreateTexture(nil, "BORDER") -- displays the debuff; draw layer should equal "BORDER" because cooldown spirals are drawn in the "ARTWORK" layer.
	o.texture:SetAllPoints(o) -- anchor the texture to the frame
	o:SetReverse(true) -- makes the cooldown shade from light to dark instead of dark to light

	--[[ Rufio's code to make the frame border pretty. Maybe use this somehow to mask cooldown corners in Blizzard frames.
	o.overlay = o:CreateTexture(nil, "OVERLAY");
	o.overlay:SetTexture("Interface\\AddOns\\LoseControl\\gloss");
	o.overlay:SetPoint("TOPLEFT", -1, 1);
	o.overlay:SetPoint("BOTTOMRIGHT", 1, -1);
	o.overlay:SetVertexColor(0.25, 0.25, 0.25);]]
	o:Hide()

	-- Handle events
	o:SetScript("OnEvent", self.OnEvent)
	o:SetScript("OnDragStart", self.StartMoving) -- this function is already built into the Frame class
	o:SetScript("OnDragStop", self.StopMoving) -- this is a custom function
	o:RegisterEvent("PLAYER_ENTERING_WORLD")
	o:RegisterEvent("UNIT_AURA")
	if unitId == "focus" then
		o:RegisterEvent("PLAYER_FOCUS_CHANGED")
	elseif unitId == "target" then
		o:RegisterEvent("PLAYER_TARGET_CHANGED")
	end

	return o
end

-- Create new object instance for each frame
local LC = {}
for k in pairs(DBdefaults.frames) do
	LC[k] = LoseControl:new(k)
end

-------------------------------------------------------------------------------
-- Add main Interface Option Panel
local O = L .. "OptionsPanel"

local OptionsPanel = CreateFrame("Frame", O)
OptionsPanel.name = L

local title = OptionsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetText(L)

local subText = OptionsPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
local notes = GetAddOnMetadata(L, "Notes-" .. GetLocale())
if not notes then
	notes = GetAddOnMetadata(L, "Notes")
end
subText:SetText(notes)

-- "Unlock" checkbox - allow the frames to be moved
local Unlock = CreateFrame("CheckButton", O.."Unlock", OptionsPanel, "OptionsCheckButtonTemplate")
_G[O.."UnlockText"]:SetText(LOSECONTROL["Unlock"])
function Unlock:OnClick()
	if self:GetChecked() then
		_G[O.."UnlockText"]:SetText(LOSECONTROL["Unlock"] .. LOSECONTROL[" (drag an icon to move)"])
		local keys = {} -- for random icon sillyness
		for k in pairs(spellIds) do
			tinsert(keys, k)
		end
		for k, v in pairs(LC) do
			local frame = LoseControlDB.frames[k]
			if _G[anchors[frame.anchor][k]] or frame.anchor == "None" then -- only unlock frames whose anchor exists
				v:UnregisterEvent("UNIT_AURA")
				v:UnregisterEvent("PLAYER_FOCUS_CHANGED")
				v:UnregisterEvent("PLAYER_TARGET_CHANGED")
				v:SetMovable(true)
				v:RegisterForDrag("LeftButton")
				v:EnableMouse(true)
				v.texture:SetTexture(select(3, GetSpellInfo(keys[random(#keys)])))
				v:SetParent(nil) -- detach the frame from its parent or else it won't show if the parent is hidden
				--v:SetFrameStrata(frame.strata or "MEDIUM")
				if v.anchor:GetParent() then
					v:SetFrameLevel(v.anchor:GetParent():GetFrameLevel())
				end
				v:Show()
				v:SetCooldown( GetTime(), 30 )
				v:SetAlpha(frame.alpha) -- hack to apply the alpha to the cooldown timer
			end
		end
	else
		_G[O.."UnlockText"]:SetText(LOSECONTROL["Unlock"])
		for k, v in pairs(LC) do
			--local frame = LoseControlDB.frames[k]
			v:RegisterEvent("UNIT_AURA")
			if k == "focus" then
				v:RegisterEvent("PLAYER_FOCUS_CHANGED")
			elseif k == "target" then
				v:RegisterEvent("PLAYER_TARGET_CHANGED")
			end
			v:SetMovable(false)
			v:RegisterForDrag()
			v:EnableMouse(false)
			v:SetParent(v.anchor:GetParent()) -- or UIParent)
			--v:SetFrameStrata(frame.strata or "LOW")
			v:Hide()
		end
	end
end
Unlock:SetScript("OnClick", Unlock.OnClick)

local DisableCooldownCount = CreateFrame("CheckButton", O.."DisableCooldownCount", OptionsPanel, "OptionsCheckButtonTemplate")
_G[O.."DisableCooldownCountText"]:SetText(LOSECONTROL["Disable OmniCC/CooldownCount Support"])
DisableCooldownCount:SetScript("OnClick", function(self)
	LoseControlDB.noCooldownCount = self:GetChecked()
	LoseControl.noCooldownCount = LoseControlDB.noCooldownCount
end)

local Tracking = OptionsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
Tracking:SetText(LOSECONTROL["Tracking"])

local TrackCCs = CreateFrame("CheckButton", O.."TrackCCs", OptionsPanel, "OptionsCheckButtonTemplate")
_G[O.."TrackCCsText"]:SetText(LOSECONTROL["CC"])
TrackCCs:SetScript("OnClick", function(self)
	LoseControlDB.tracking.CC = self:GetChecked()
end)

local TrackSilences = CreateFrame("CheckButton", O.."TrackSilences", OptionsPanel, "OptionsCheckButtonTemplate")
_G[O.."TrackSilencesText"]:SetText(LOSECONTROL["Silence"])
TrackSilences:SetScript("OnClick", function(self)
	LoseControlDB.tracking.Silence = self:GetChecked()
end)

local TrackDisarms = CreateFrame("CheckButton", O.."TrackDisarms", OptionsPanel, "OptionsCheckButtonTemplate")
_G[O.."TrackDisarmsText"]:SetText(LOSECONTROL["Disarm"])
TrackDisarms:SetScript("OnClick", function(self)
	LoseControlDB.tracking.Disarm = self:GetChecked()
end)

local TrackRoots = CreateFrame("CheckButton", O.."TrackRoots", OptionsPanel, "OptionsCheckButtonTemplate")
_G[O.."TrackRootsText"]:SetText(LOSECONTROL["Root"])
TrackRoots:SetScript("OnClick", function(self)
	LoseControlDB.tracking.Root = self:GetChecked()
end)

local TrackSnares = CreateFrame("CheckButton", O.."TrackSnares", OptionsPanel, "OptionsCheckButtonTemplate")
_G[O.."TrackSnaresText"]:SetText(LOSECONTROL["Snare"])
TrackSnares:SetScript("OnClick", function(self)
	LoseControlDB.tracking.Snare = self:GetChecked()
end)

local TrackImmune = CreateFrame("CheckButton", O.."TrackImmune", OptionsPanel, "OptionsCheckButtonTemplate")
_G[O.."TrackImmuneText"]:SetText(LOSECONTROL["Immune"])
TrackImmune:SetScript("OnClick", function(self)
	LoseControlDB.tracking.Immune = self:GetChecked()
end)

local TrackPvE = CreateFrame("CheckButton", O.."TrackPvE", OptionsPanel, "OptionsCheckButtonTemplate")
_G[O.."TrackPvEText"]:SetText(LOSECONTROL["PvE"])
TrackPvE:SetScript("OnClick", function(self)
	LoseControlDB.tracking.PvE = self:GetChecked()
end)

-------------------------------------------------------------------------------
-- DropDownMenu helper function
local info = UIDropDownMenu_CreateInfo()
local function AddItem(owner, text, value)
	info.owner = owner
	info.func = owner.OnClick
	info.text = text
	info.value = value
	info.checked = nil -- initially set the menu item to being unchecked
	UIDropDownMenu_AddButton(info)
end

local UnitDropDownLabel = OptionsPanel:CreateFontString(O.."UnitDropDownLabel", "ARTWORK", "GameFontNormal")
UnitDropDownLabel:SetText(LOSECONTROL["Unit Configuration"])
UnitDropDown = CreateFrame("Frame", O.."UnitDropDown", OptionsPanel, "UIDropDownMenuTemplate")
function UnitDropDown:OnClick()
	UIDropDownMenu_SetSelectedValue(UnitDropDown, self.value)
	OptionsPanel.refresh() -- easy way to update all the other controls
end
UIDropDownMenu_Initialize(UnitDropDown, function() -- sets the initialize function and calls it
	for _, v in ipairs({ "player", "target", "focus", "party1", "party2", "party3", "party4", "arena1", "arena2", "arena3", "arena4", "arena5" }) do -- indexed manually so they appear in order
		AddItem(UnitDropDown, LOSECONTROL[v], v)
	end
end)
UIDropDownMenu_SetSelectedValue(UnitDropDown, "player") -- set the initial drop down choice

local AnchorDropDownLabel = OptionsPanel:CreateFontString(O.."AnchorDropDownLabel", "ARTWORK", "GameFontNormal")
AnchorDropDownLabel:SetText(LOSECONTROL["Anchor"])
AnchorDropDown = CreateFrame("Frame", O.."AnchorDropDown", OptionsPanel, "UIDropDownMenuTemplate")
function AnchorDropDown:OnClick()
	local unit = UIDropDownMenu_GetSelectedValue(UnitDropDown)
	local frame = LoseControlDB.frames[unit]
	local icon = LC[unit]

	UIDropDownMenu_SetSelectedValue(AnchorDropDown, self.value)
	frame.anchor = self.value
	if self.value ~= "None" then -- reset the frame position so it centers on the anchor frame
		frame.point = nil
		frame.relativePoint = nil
		frame.x = nil
		frame.y = nil
	end

	icon.anchor = _G[anchors[frame.anchor][unit]] or UIParent

	if not Unlock:GetChecked() then -- prevents the icon from disappearing if the frame is currently hidden
		icon:SetParent(icon.anchor:GetParent())
	end

	icon:ClearAllPoints() -- if we don't do this then the frame won't always move
	icon:SetPoint(
		frame.point or "CENTER",
		icon.anchor,
		frame.relativePoint or "CENTER",
		frame.x or 0,
		frame.y or 0
	)
end
function AnchorDropDown:initialize() -- called from OptionsPanel.refresh() and every time the drop down menu is opened
	local unit = UIDropDownMenu_GetSelectedValue(UnitDropDown)
	AddItem(self, LOSECONTROL["None"], "None")
	AddItem(self, "Blizzard", "Blizzard")
	if _G[anchors["Perl"][unit]] then AddItem(self, "Perl", "Perl") end
	if _G[anchors["XPerl"][unit]] then AddItem(self, "XPerl", "XPerl") end
end

local StrataDropDownLabel = OptionsPanel:CreateFontString(O.."StrataDropDownLabel", "ARTWORK", "GameFontNormal")
StrataDropDownLabel:SetText(LOSECONTROL["Strata"])
local StrataDropDown = CreateFrame("Frame", O.."StrataDropDown", OptionsPanel, "UIDropDownMenuTemplate")
function StrataDropDown:OnClick()
	local unit = UIDropDownMenu_GetSelectedValue(UnitDropDown)
	UIDropDownMenu_SetSelectedValue(StrataDropDown, self.value)
	LoseControlDB.frames[unit].strata = self.value
	LC[unit]:SetFrameStrata(self.value)
end
function StrataDropDown:initialize() -- called from OptionsPanel.refresh() and every time the drop down menu is opened
	for _, v in ipairs({ "HIGH", "MEDIUM", "LOW", "BACKGROUND" }) do -- indexed manually so they appear in order
		AddItem(self, v, v)
	end
end

-------------------------------------------------------------------------------
-- Slider helper function, thanks to Kollektiv
local function CreateSlider(text, parent, low, high, step)
	local name = parent:GetName() .. text
	local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")
	slider:SetWidth(160)
	slider:SetMinMaxValues(low, high)
	slider:SetValueStep(step)
	--_G[name .. "Text"]:SetText(text)
	_G[name .. "Low"]:SetText(low)
	_G[name .. "High"]:SetText(high)
	return slider
end

local SizeSlider = CreateSlider(LOSECONTROL["Icon Size"], OptionsPanel, 16, 512, 4)
SizeSlider:SetScript("OnValueChanged", function(self, value)
	local unit = UIDropDownMenu_GetSelectedValue(UnitDropDown)
	_G[self:GetName() .. "Text"]:SetText(LOSECONTROL["Icon Size"] .. " (" .. value .. "px)")
	LoseControlDB.frames[unit].size = value
	LC[unit]:SetWidth(value)
	LC[unit]:SetHeight(value)
end)

local AlphaSlider = CreateSlider(LOSECONTROL["Opacity"], OptionsPanel, 0, 100, 5) -- I was going to use a range of 0 to 1 but Blizzard's slider chokes on decimal values
AlphaSlider:SetScript("OnValueChanged", function(self, value)
	local unit = UIDropDownMenu_GetSelectedValue(UnitDropDown)
	_G[self:GetName() .. "Text"]:SetText(LOSECONTROL["Opacity"] .. " (" .. value .. "%)")
	LoseControlDB.frames[unit].alpha = value / 100 -- the real alpha value
	LC[unit]:SetAlpha(value / 100)
end)

-------------------------------------------------------------------------------
-- Defined last because it references earlier declared variables
local Enabled = CreateFrame("CheckButton", O.."Enabled", OptionsPanel, "OptionsCheckButtonTemplate")
_G[O.."EnabledText"]:SetText(LOSECONTROL["Enabled"])
function Enabled:OnClick()
	local enabled = self:GetChecked()
	LoseControlDB.frames[UIDropDownMenu_GetSelectedValue(UnitDropDown)].enabled = enabled
	if enabled then
		UIDropDownMenu_EnableDropDown(AnchorDropDown)
		UIDropDownMenu_EnableDropDown(StrataDropDown)
		BlizzardOptionsPanel_Slider_Enable(SizeSlider)
		BlizzardOptionsPanel_Slider_Enable(AlphaSlider)
	else
		UIDropDownMenu_DisableDropDown(AnchorDropDown)
		UIDropDownMenu_DisableDropDown(StrataDropDown)
		BlizzardOptionsPanel_Slider_Disable(SizeSlider)
		BlizzardOptionsPanel_Slider_Disable(AlphaSlider)
	end
end
Enabled:SetScript("OnClick", Enabled.OnClick)

-------------------------------------------------------------------------------
-- Arrange all the options neatly
title:SetPoint("TOPLEFT", 16, -16)
subText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)

Unlock:SetPoint("TOPLEFT", subText, "BOTTOMLEFT", 0, -16)
DisableCooldownCount:SetPoint("TOPLEFT", Unlock, "BOTTOMLEFT", 0, -2)

Tracking:SetPoint("TOPLEFT", DisableCooldownCount, "BOTTOMLEFT", 0, -12)
TrackCCs:SetPoint("TOPLEFT", Tracking, "BOTTOMLEFT", 0, -4)
TrackSilences:SetPoint("TOPLEFT", TrackCCs, "TOPRIGHT", 100, 0)
TrackDisarms:SetPoint("TOPLEFT", TrackSilences, "TOPRIGHT", 100, 0)
TrackRoots:SetPoint("TOPLEFT", TrackCCs, "BOTTOMLEFT", 0, -2)
TrackSnares:SetPoint("TOPLEFT", TrackSilences, "BOTTOMLEFT", 0, -2)
TrackImmune:SetPoint("TOPLEFT", TrackDisarms, "BOTTOMLEFT", 0, -2)
TrackPvE:SetPoint("TOPLEFT", TrackRoots, "BOTTOMLEFT", 0, -2)

UnitDropDownLabel:SetPoint("TOPLEFT", TrackPvE, "BOTTOMLEFT", 0, -12)
UnitDropDown:SetPoint("TOPLEFT", UnitDropDownLabel, "BOTTOMLEFT", 0, -8)	Enabled:SetPoint("TOPLEFT", UnitDropDownLabel, "BOTTOMLEFT", 200, -8)

AnchorDropDownLabel:SetPoint("TOPLEFT", UnitDropDown, "BOTTOMLEFT", 0, -12)	--StrataDropDownLabel:SetPoint("TOPLEFT", UnitDropDown, "BOTTOMLEFT", 200, -12)
AnchorDropDown:SetPoint("TOPLEFT", AnchorDropDownLabel, "BOTTOMLEFT", 0, -8)	--StrataDropDown:SetPoint("TOPLEFT", StrataDropDownLabel, "BOTTOMLEFT", 0, -8)

SizeSlider:SetPoint("TOPLEFT", AnchorDropDown, "BOTTOMLEFT", 0, -24)		AlphaSlider:SetPoint("TOPLEFT", AnchorDropDown, "BOTTOMLEFT", 200, -24)

-------------------------------------------------------------------------------
OptionsPanel.default = function() -- This method will run when the player clicks "defaults".
	_G.LoseControlDB = nil
	LoseControl:ADDON_LOADED(L)
	for _, v in pairs(LC) do
		v:PLAYER_ENTERING_WORLD()
	end
end

OptionsPanel.refresh = function() -- This method will run when the Interface Options frame calls its OnShow function and after defaults have been applied via the panel.default method described above, and after the Unit Configuration dropdown is changed.
	local tracking = LoseControlDB.tracking
	local unit = UIDropDownMenu_GetSelectedValue(UnitDropDown)
	local frame = LoseControlDB.frames[unit]
	DisableCooldownCount:SetChecked(LoseControlDB.noCooldownCount)
	TrackCCs:SetChecked(tracking.CC)
	TrackSilences:SetChecked(tracking.Silence)
	TrackDisarms:SetChecked(tracking.Disarm)
	TrackRoots:SetChecked(tracking.Root)
	TrackSnares:SetChecked(tracking.Snare)
	TrackImmune:SetChecked(tracking.Immune)
	TrackPvE:SetChecked(tracking.PvE)
	Enabled:SetChecked(frame.enabled)
	Enabled:OnClick()
	AnchorDropDown:initialize()
	UIDropDownMenu_SetSelectedValue(AnchorDropDown, frame.anchor)
	StrataDropDown:initialize()
	UIDropDownMenu_SetSelectedValue(StrataDropDown, frame.strata or "LOW")
	SizeSlider:SetValue(frame.size)
	AlphaSlider:SetValue(frame.alpha * 100)
end

InterfaceOptions_AddCategory(OptionsPanel)

-------------------------------------------------------------------------------
SLASH_LoseControl1 = "/lc"
SLASH_LoseControl2 = "/losecontrol"
SlashCmdList[L] = function(cmd)
	cmd = cmd:lower()
	if cmd == "reset" then
		OptionsPanel.default()
		OptionsPanel.refresh()
	elseif cmd == "lock" then
		Unlock:SetChecked(false)
		Unlock:OnClick()
		log(L .. " locked.")
	elseif cmd == "unlock" then
		Unlock:SetChecked(true)
		Unlock:OnClick()
		log(L .. " unlocked.")
	elseif cmd:sub(1, 6) == "enable" then
		local unit = cmd:sub(8, 14)
		if LoseControlDB.frames[unit] then
			LoseControlDB.frames[unit].enabled = true
			log(L .. ": " .. unit .. " frame enabled.")
		end
	elseif cmd:sub(1, 7) == "disable" then
		local unit = cmd:sub(9, 15)
		if LoseControlDB.frames[unit] then
			LoseControlDB.frames[unit].enabled = false
			log(L .. ": " .. unit .. " frame disabled.")
		end
	elseif cmd:sub(1, 4) == "help" then
		log(L .. " slash commands:")
		log("    reset")
		log("    lock")
		log("    unlock")
		log("    enable <unit>")
		log("    disable <unit>")
		log("<unit> can be: player, target, focus, party1 ... party4, arena1 ... arena5")
	else
		log(L .. ": Type \"/lc help\" for more options.")
		InterfaceOptionsFrame_OpenToCategory(OptionsPanel)
	end
end
