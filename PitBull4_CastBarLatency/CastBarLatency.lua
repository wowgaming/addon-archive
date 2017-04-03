if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

-- Upvalues
local min = math.min

-- CONSTANTS
local ALPHA_MODIFIER = 0.6 -- Multiplied to the main CastBar's alpha at any point of time.
local DEFAULT_COLOR = {1, 0, 0, 1}
local ADJUSTMENT_DIVISOR_FOR_EVENTS = 1e3 -- Events return different timestamps than GetTime. GetTime's is more useful.
local ADJUSTMENT_DIVISOR_FOR_QUEUES = 1e3
local MAX_GCD_TIME = 1.5
local DEFAULT_QUEUE_TIME = 300

-- Pseudo global initialization
local send_time  = 0
local start_time = 0
local end_time   = 0
local lag_time   = 0
local max_time   = 0
local is_channel = nil
local queue_time = DEFAULT_QUEUE_TIME
local gcd_time   = 0

local show_queue = true
local show_gcd   = true

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_CastBarLatency requires PitBull4")
end

local GetTime = _G.GetTime
local L = PitBull4.L

local PitBull4_CastBar = PitBull4:GetModule("CastBar", true)
if not PitBull4_CastBar then
	error(L["PitBull4_CastBarLatency requires the CastBar module"])
end

local PitBull4_CastBarLatency = PitBull4:NewModule("CastBarLatency", "AceEvent-3.0")
local self = PitBull4_CastBarLatency

PitBull4_CastBarLatency:SetModuleType("custom")
PitBull4_CastBarLatency:SetName(L["Cast bar latency"])
PitBull4_CastBarLatency:SetDescription(L["Show a guessed safe zone at the end of the player castbar."])
PitBull4_CastBarLatency:SetDefaults({},{
	show_queue = true,
	queue_time = DEFAULT_QUEUE_TIME,
	show_gcd = true,
	latency_color = DEFAULT_COLOR
})
PitBull4_CastBarLatency:SetLayoutOptionsFunction(function(self) end)

-- Create a timer frame with an onupdate to ensure updates of our bar..
local timerFrame = CreateFrame("Frame")
timerFrame:Hide()
timerFrame:SetScript("OnUpdate", function()
	-- No lag time so no reason to iterate the frames.
	if lag_time == 0 then
		return
	end

	-- Loop thru ALL PitBull Frames...
	for frame in PitBull4:IterateFrames() do
		local unit = frame.unit
		if unit and UnitIsUnit(unit,"player") then 
			-- ... but only force updates for frames representing the player
			PitBull4_CastBarLatency:Update(frame)
		end
	end

	end)

function PitBull4_CastBarLatency:UNIT_SPELLCAST_START(event, unit, spell, spellrank)
	if unit ~= 'player' then
		return
	end
	
	-- Try to determine GCD
	if show_gcd and spell then
		local _, duration = GetSpellCooldown(spell)
		if duration and duration > 0 and duration <= MAX_GCD_TIME then
			gcd_time = duration
		end
	end
	
	local name, _, _, _, new_start, new_end, _, _ = UnitCastingInfo(unit)
	if not name then
		return
	end
	
	end_time = new_end / ADJUSTMENT_DIVISOR_FOR_EVENTS
	start_time = new_start / ADJUSTMENT_DIVISOR_FOR_EVENTS
	max_time = end_time - start_time
	lag_time = start_time - send_time
	is_channel = nil
	local queue_val = queue_time / ADJUSTMENT_DIVISOR_FOR_QUEUES
	if show_queue and (lag_time < queue_val) then
		lag_time = queue_val
	end
	
	-- GCD handling
	if show_gcd then
		local gcd_rest = max_time - gcd_time
		if gcd_rest < 0 then gcd_rest = 0 end
		lag_time = math.min(lag_time, gcd_rest)
	end
	--print(string.format("DBG-USStart: GCD_time: %s; MAX_time: %s; LAG_time: %s", tostring(gcd_time), tostring(max_time), tostring(lag_time)))
end

function PitBull4_CastBarLatency:UNIT_SPELLCAST_CHANNEL_START(event, unit, spell, spellrank)
	if unit ~= 'player' then
		return
	end
	
	-- Try to determine GCD
	if show_gcd and spell then
		local _, duration = GetSpellCooldown(spell)
		if duration and duration > 0 and duration <= MAX_GCD_TIME then
			gcd_time = duration
		end
	end
	
	local name, _, _, _, new_start, new_end, _, _ = UnitChannelInfo(unit)
	if not name then
		return
	end
	
	end_time = new_end / ADJUSTMENT_DIVISOR_FOR_EVENTS
	start_time = new_start / ADJUSTMENT_DIVISOR_FOR_EVENTS
	max_time = end_time - start_time
	lag_time = start_time - send_time
	is_channel = true
	local queue_time = queue_time
	local queue_val = queue_time / ADJUSTMENT_DIVISOR_FOR_QUEUES
	if show_queue and (lag_time < queue_val) then
		lag_time = queue_val
	end
	
	-- GCD handling
	if show_gcd then
		local gcd_rest = max_time - gcd_time
		if gcd_rest < 0 then gcd_rest = 0 end
		lag_time = math.min(lag_time, gcd_rest)
	end
end


function PitBull4_CastBarLatency:UNIT_SPELLCAST_SENT(event, unit, spell, spellrank) 
	if unit ~= 'player' then
		return
	end
	send_time = GetTime()
end

function PitBull4_CastBarLatency:UNIT_SPELLCAST_STOP(event, unit, spell)
	if unit ~= 'player' then
		return
	end

	-- Try to determine GCD
	if show_gcd and spell then
		local _, duration = GetSpellCooldown(spell)
		if duration and duration > 0 and duration <= MAX_GCD_TIME then
			gcd_time = duration
		end
	end
	
	-- Ignore SPELLCAST_SUCCEEDED when we're channeling
	if event == 'UNIT_SPELLCAST_SUCCEEDED' and is_channel then
		return
	end

	-- Clear the lag_time when we're not casting
	lag_time = 0

	for frame in PitBull4:IterateFrames() do
		self:ClearFrame(frame)
	end
end

function PitBull4_CastBarLatency:OnEnable()
	timerFrame:Show()
	
	self:RegisterEvent("UNIT_SPELLCAST_SENT")
	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
	self:RegisterEvent("UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED","UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED","UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED","UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP","UNIT_SPELLCAST_STOP")
	
	queue_time = self.db.profile.global.queue_time
	show_queue = self.db.profile.global.show_queue
	show_gcd   = self.db.profile.global.show_gcd
end

function PitBull4_CastBarLatency:OnDisable()
	timerFrame:Hide()
end

function PitBull4_CastBarLatency:UpdateFrame(frame)
	local unit = frame.unit
	if not unit or not UnitIsUnit(unit,"player") then
		-- this frame does not represent the player so we remove ourselves
		return self:ClearFrame(frame) 
	end
	
	local bar = frame.CastBar
	if not bar or lag_time == 0 then
		-- no cast bar on this frame or no lag so we remove ourselves..
		return self:ClearFrame(frame)
	end
	
	local safe_zone = frame.CastBarLatency
	
	if not safe_zone then 
		-- Our own Bar doesn't exist yet, create it
		safe_zone = PitBull4.Controls.MakeBetterStatusBar(frame)
		
		-- Populate the new bar with default look attributes..
		safe_zone:SetTexture(bar:GetTexture()) -- Might need to be moved down to update properly
		safe_zone:SetValue(1)
		safe_zone:SetColor(unpack(self.db.profile.global.latency_color))
		safe_zone:SetBackgroundAlpha(0) -- so we can actually see the main bar behind us
		
		frame.CastBarLatency = safe_zone
	end
	
	-- Calculate the how much of the entire casttime will be lost to lag
	local safe_zone_percent = 0
	if max_time > 0 then
		safe_zone_percent = lag_time / max_time
	end
	if safe_zone_percent > 1 then safe_zone_percent = 1 end
	
	safe_zone:ClearAllPoints()
	safe_zone:SetAllPoints(bar)
	
	-- Find and apply the main castbar's alpha and apply it with a modifier. Must be dynamic for fadouts.
	local bar_alpha = select(4,PitBull4_CastBar:GetColor(frame, 'player'))
	if bar_alpha then
		safe_zone:SetAlpha(bar_alpha*ALPHA_MODIFIER)
	end
	
	-- Find and apply user settings to our bar
	safe_zone:SetColor(unpack(self.db.profile.global.latency_color))
	safe_zone:SetFrameLevel( bar:GetFrameLevel()+1 )
	local reverse = not bar:GetReverse()
	local icon_position = not bar:GetIconPosition()
	safe_zone:SetOrientation( bar:GetOrientation() )
	if bar:GetDeficit() then
		reverse = not reverse
		icon_position = not icon_position
	end
	
	if is_channel then 
		-- channelling casts are flipped... again...
		reverse = not reverse
		icon_position = not icon_position
	end
	safe_zone:SetReverse(reverse)
	
	-- Apply our calculated size
	safe_zone:SetValue(safe_zone_percent)
	safe_zone:Show()
	
	if bar.icon then
		safe_zone:SetIcon("")
		safe_zone:SetIconPosition(icon_position)
	else
		safe_zone:SetIcon(nil)
	end
	
	return false
end

function PitBull4_CastBarLatency:ClearFrame(frame)
	if not frame.CastBarLatency then
		return false
	end
	
	frame.CastBarLatency = frame.CastBarLatency:Delete()
	return false
end

PitBull4_CastBarLatency.OnHide = PitBull4_CastBarLatency.ClearFrame

PitBull4_CastBarLatency:SetGlobalOptionsFunction(function(self)
	return 'show_gcd', {
		type = 'toggle',
		width = 'full',
		name = L['Include GCD lockout'],
		desc = L['This assumes spells cannot be (locally) triggered before the GCD has run out.'],
		get = function(info)
			local id = info[#info]
			return self.db.profile.global[id]
		end,
		set = function(info, value)
			local id = info[#info]
			self.db.profile.global[id] = value
			show_gcd = value
		end,
	},
	'show_queue', {
		type = 'toggle',
		width = 'full',
		name = L['Include spell queue time'],
		desc = L['Always add the spell queue time to the shown latency.'],
		get = function(info)
			local id = info[#info]
			return self.db.profile.global[id]
		end,
		set = function(info, value)
			local id = info[#info]
			self.db.profile.global[id] = value
			show_queue = value
		end,
	},
	'queue_time', {
		type = 'range',
		width = 'double',
		name = L['Queue time'],
		desc = string.format(L["Fixed time at then end of a running cast where you are able to cast the next spell. Default is %s\nWARNING: Do not change this unless you know exactly what you're doing!"], tostring(DEFAULT_QUEUE_TIME)),
		min = 0,
		max = 1000,
		step = 1,
		get = function(info)
			local id = info[#info]
			return self.db.profile.global[id]
		end,
		set = function(info, value)
			local id = info[#info]
			self.db.profile.global[id] = value
			queue_time = value
		end,
	}
end)

PitBull4_CastBarLatency:SetColorOptionsFunction(function(self)
	return 'latency_color', {
		type = 'color',
		name = L['Latency'],
		desc = L['Sets which color the latency overlay on the castbar is using.'],
		get = function(info)
			return unpack(self.db.profile.global.latency_color)
		end,
		set = function(info, r, g, b, a)
			self.db.profile.global.latency_color = {r, g, b, 1} -- alpha is hardcoded for now because it must be calculated dynamically from the castbar in UpdateFrame()
			self:UpdateAll()
		end,
	},
	function(info)
		self.db.profile.global.latency_color = DEFAULT_COLOR
	end
end)
