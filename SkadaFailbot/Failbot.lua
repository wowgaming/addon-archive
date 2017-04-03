local fail = LibStub("LibFail-1.0", true)
if not fail then return end
local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

local Skada = Skada

local mod = Skada:NewModule(L["Fails"])
local playermod = Skada:NewModule("FailbotModePlayerView")

local fail_events = fail:GetSupportedEvents()

function mod:AddToTooltip(set, tooltip)
 	GameTooltip:AddDoubleLine(L["Fails"], set.fails, 1,1,1)
end

function mod:GetSetSummary(set)
	return set.fails
end

-- Called by Skada when a new player is added to a set.
function mod:AddPlayerAttributes(player)
	if not player.fails then
		player.fails = 0
		player.failevents = {}
	end
end

-- Called by Skada when a new set is created.
function mod:AddSetAttributes(set)
	if not set.fails then
		set.fails = 0
	end
end

local function onFail(event, who, fatal)
--   print(event, who, fatal)
	if event and who then
		-- Always log to Total set. Current only if we are active.
		-- Idea: let modes force-start a set, so we can get a set
		-- for these things.
		if Skada.current then
			local unitGUID = UnitGUID(who)
			local player = Skada:get_player(Skada.current, unitGUID, who)
			player.fails = player.fails + 1
			
			if player.failevents[event] then
				player.failevents[event] = player.failevents[event] + 1
			else
				player.failevents[event] = 1
			end
			Skada.current.fails = Skada.current.fails + 1
		end
		
		if Skada.total then
			local unitGUID = UnitGUID(who)
			local player = Skada:get_player(Skada.total, unitGUID, who)
			player.fails = player.fails + 1
		
			if player.failevents[event] then
				player.failevents[event] = player.failevents[event] + 1
			else
				player.failevents[event] = 1
			end
			Skada.total.fails = Skada.total.fails + 1
		end
	end
end

for _, event in ipairs(fail_events) do
	fail:RegisterCallback(event, onFail)
end

function mod:Update(win, set)

	local nr = 1
	local max = 0
	for i, player in ipairs(set.players) do
		if player.fails > 0 then
		
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = player.id
			d.value = player.fails
			d.label = player.name
			d.class = player.class
			d.valuetext = tostring(player.fails)
			
			if player.fails > max then
				max = player.fails
			end
			
			nr = nr + 1
		end
	end
		
	win.metadata.maxvalue = max
end

function playermod:Enter(win, id, label)
	playermod.playerid = id
	playermod.title = label..L["'s Fails"]
end

-- Detail view of a player.
function playermod:Update(win, set)
	-- View spells for this player.
		
	local player = Skada:find_player(set, self.playerid)
	local nr = 1
	if player then
		for event, fails in pairs(player.failevents) do
			
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			
			d.id = event
			d.value = fails
			d.label = event
			d.valuetext = fails
			
			nr = nr + 1
		end
	end
	
	win.metadata.maxvalue = player.fails
end

function mod:OnEnable()
	mod.metadata 		= {click1 = playermod, showspots = true}
	playermod.metadata 	= {}

	Skada:AddMode(self)
end

function mod:OnDisable()
	Skada:RemoveMode(self)
end
