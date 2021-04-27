--[[
	MSP4TRP2, a modification of LibMSP by Etarna Moonshyne, author of MyRolePlay 4.x, all credits go to him.
	----------------       http://moonshyne.org/msp/    -------------------------
	
	
	Modified by Telkostrasz "Kajisensei" for Total RP 2.
	- Moving callback calls, adding it parameters.
	- Inserted TRP2 ignore system.
	
	!!! THIS IS NOT A EMBEDABLE VERSION, WORKS ONLY WITH TRP2 !!!
]]


_G.msptrp = {};

local msptrp = _G.msptrp;

msptrp.protocolversion = 1;

msptrp.callback = {
	received = {}
}

local function emptyindex( table, key )
	table[key] = ""
	return table[key]
end

local function charindex( table, key )
	if key == "field" then
		table[key] = setmetatable( {}, { __index = emptyindex, } )
		return table[key]
	elseif key == "ver" or key == "time" then
		table[key] = {}
		return table[key]
	else 
		return nil
	end
end

local function bufferindex( table, key )
	table[key] = setmetatable( {}, { __index = charindex, } )
	return table[key]
end

msptrp.char = setmetatable( {}, { __index = bufferindex } )

msptrp.my = {}
msptrp.myver = {}
msptrp.my.VP = tostring( msptrp.protocolversion )

local msptrp_my_previous = {}
local msptrp_tt_cache = false

local strfind, strmatch, strsub, strgmatch = strfind, strmatch, strsub, string.gmatch
local tinsert, tconcat = tinsert, table.concat
local tostring, tonumber, wipe, next = tostring, tonumber, wipe, next
local GetTime = GetTime

local MSP_FIELDS_IN_TT = { 'VP', 'VA', 'NA', 'NH', 'NI', 'NT', 'RA', 'FR', 'FC', 'CU' }
local MSP_TT_FIELD = { VP=true, VA=true, NA=true, NH=true, NI=true, NT=true, RA=true, FR=true, FC=true, CU=true }
local MSP_PROBE_FREQUENCY = 300.0 + math.random(0, 60) -- Wait 5-6 minutes for someone to respond before asking again
local MSP_FIELD_UPDATE_FREQUENCY = 10.0 + math.random(0, 5) -- Fields newer than 10-15 seconds old are still fresh

local garbage = setmetatable( {}, { __mode = "k" } )
local function newtable()
	local t = next( garbage )
	if t then 
		garbage[t] = nil
		return wipe(t)
	end
	return {}
end

function msptrp_onevent( this, event, prefix, body, dist, sender )
	if event == "CHAT_MSG_ADDON" then
		if MSP_INCOMING_HANDLER[ prefix ] then
			if TRP2_EstIgnore(sender) or not TRP2_GetConfigValueFor("ActivateExchange",true) then
				return;
			end
			MSP_INCOMING_HANDLER[ prefix ]( sender, body )
		end
	end
end

function msptrp_incomingfirst( sender, body )
	msptrp.char[ sender ].buffer = body
end

function msptrp_incomingnext( sender, body )
	local buf = msptrp.char[ sender ].buffer
	if buf then
		if type( buf ) == "table" then
			tinsert( buf, body )
		else
			local temp = newtable()
			temp[ 1 ] = buf
			temp[ 2 ] = body
			msptrp.char[ sender ].buffer = temp
		end
	end
end

function msptrp_incominglast( sender, body )
	local buf = msptrp.char[ sender ].buffer
	if buf then
		if type( buf ) == "table" then
			tinsert( buf, body )
			msptrp_incoming( sender, tconcat( buf ) )
			garbage[ buf ] = true
		else
			msptrp_incoming( sender, buf .. body )
		end
	end
end

function msptrp_incoming( sender, body )
	msptrp.char[ sender ].supported = true
	msptrp.char[ sender ].scantime = nil
	msptrp.reply = newtable()
	if body ~= "" then
		if strfind( body, "\1", 1, true ) then
			for chunk in strgmatch( body, "([^\1]+)\1*" ) do
				msptrp_incomingchunk( sender, chunk )
			end
		else
			msptrp_incomingchunk( sender, body )
		end
	end
	for k, v in ipairs( msptrp.callback.received ) do
		v(sender)
	end
	msptrp:Send( sender, msptrp.reply )
	garbage[ msptrp.reply ] = true
end

function msptrp_incomingchunk( sender, chunk )
	local reply = msptrp.reply
	local head, field, ver, body = strmatch( chunk, "(%p?)(%a%a)(%d*)=?(.*)" )
	ver = tonumber( ver ) or 0
	if not field then
		return
	end
	if head == "?" then
		if (ver == 0) or (ver < (msptrp.myver[ field ] or 0)) or (ver > (msptrp.myver[ field ] or 0)) then
			if field == "TT" then
				if not msptrp_tt_cache then
					msptrp:Update()
				end
				tinsert( reply, msptrp_tt_cache )
			else
				if not msptrp.my[ field ] or msptrp.my[ field ] == "" then
					tinsert( reply, field .. (msptrp.myver[ field ] or "") )
				else
					tinsert( reply, field .. (msptrp.myver[ field ] or "") .. "=" .. msptrp.my[ field ] )
				end
			end
		else
			tinsert( reply, "!"..field..(msptrp.myver[ field ] or "") )
		end
	elseif head == "!" then
		msptrp.char[ sender ].ver[ field ] = ver
		msptrp.char[ sender ].time[ field ] = GetTime()
	elseif head == "" then
		msptrp.char[ sender ].ver[ field ] = ver;
		msptrp.char[ sender ].time[ field ] = GetTime();
		msptrp.char[ sender ].field[ field ] = body or "";
	end
end

MSP_INCOMING_HANDLER = {
	["MSP"] = msptrp_incoming,
	["MSP\1"] = msptrp_incomingfirst,
	["MSP\2"] = msptrp_incomingnext,
	["MSP\3"] = msptrp_incominglast
}

msptrp.dummyframe = msptrp.dummyframe or CreateFrame( "Frame", "libmsptrpDummyFrame" )
msptrp.dummyframe:SetScript( "OnEvent", msptrp_onevent )
msptrp.dummyframe:RegisterEvent( "CHAT_MSG_ADDON" )

for prefix, handler in pairs( MSP_INCOMING_HANDLER ) do
	RegisterAddonMessagePrefix( prefix )
end

--[[
	msptrp:Update()
	Call this function when you update (or might have updated) one of the fields in the player's own profile (msptrp.my).
	It'll deal with any version updates necessary and will rebuild the cached tooltip reply.
]]
function msptrp:Update()
	local updated = false
	local tt = newtable()
	for field, value in pairs( msptrp_my_previous ) do
		if not msptrp.my[ field ] then
			updated = true
			msptrp_my_previous[ field ] = ""
			msptrp.myver[ field ] = (msptrp.myver[ field ] or 0) + 1
			if MSP_TT_FIELD[ field ] then
				ttupdated = true
				tinsert( tt, field .. msptrp.myver[ field ] )
			end
		end
	end
	for field, value in pairs( msptrp.my ) do
		if (msptrp_my_previous[ field ] or "") ~= value then
			updated = true
			msptrp_my_previous[ field ] = value or ""
			msptrp.myver[ field ] = (msptrp.myver[ field ] or 0) + 1
		end
	end
	for k, field in ipairs( MSP_FIELDS_IN_TT ) do
		local value = msptrp.my[ field ]
		if not value or value == "" then
			tinsert( tt, field .. (msptrp.myver[ field ] or "") )
		else
			tinsert( tt, field .. (msptrp.myver[ field ] or "") .. "=" .. value )
		end
	end
	local newtt = tconcat( tt, "\1" ) or ""
	if msptrp_tt_cache ~= newtt.."\1TT"..(msptrp.myver.TT or 0) then
		msptrp.myver.TT = (msptrp.myver.TT or 0) + 1
		msptrp_tt_cache = newtt.."\1TT"..msptrp.myver.TT
	end
	garbage[ tt ] = true
	return updated
end

--[[
	msptrp:Request( player, fields )
		player = Player name to query; if from a different realm, format should be "Name-Realm"
		fields = One (string) or more (table) fields to request from the player in question

	Returns true if we sent them a request, and false if we didn't (because we either have it
	recently cached already, or they didn't respond to our last request so might not support MSP).

	Notes: 
	- This function does not spam: feel free to use frequently.
	- To avoid problems with network congestion, doesn't work on a player called "Unknown".
	- Player names are CASE SENSITIVE; pass them as you got them.
	- Replies aren't instant: to be notified if/when we get a reply, register a callback function.
	- For a quick shortcut, request field TT to get basic data you'll probably use in the tooltip.
	- Defaults to a TT (tooltip) request, if there is only one parameter.
]]
function msptrp:Request( player, fields )
	if player == "Unknown" then
		return false
	else
		local now = GetTime()
		if msptrp.char[ player ].supported == false and ( now < msptrp.char[ player ].scantime + MSP_PROBE_FREQUENCY ) then
			return false
		elseif not msptrp.char[ player ].supported then
			msptrp.char[ player ].supported = false
			msptrp.char[ player ].scantime = now
		end
		if type( fields ) == "string" then
			fields = { fields }
		elseif type( fields ) ~= "table" then
			fields = { "TT" }
		end
		local updateneeded = false
		local tosend = newtable()
		for k, field in ipairs(fields) do
			if not msptrp.char[ player ].supported or not msptrp.char[ player ].time[ field ] or (now > msptrp.char[ player ].time[ field ] + MSP_FIELD_UPDATE_FREQUENCY) then
				updateneeded = true
				if not msptrp.char[ player ].supported or not msptrp.char[ player ].ver[ field ] or msptrp.char[ player ].ver[ field ] == 0 then
					tinsert( tosend, "?" .. field )
				else
					tinsert( tosend, "?" .. field .. tostring( msptrp.char[ player ].ver[ field ] ) )
				end
			end
		end
		if updateneeded then
			msptrp:Send( player, tosend )
		end
		garbage[ tosend ] = true
		return updateneeded
	end
end

--[[
	msptrp:Send( player, chunks )
		player = Player name to send to; if from a different realm, format should be "Name-Realm"
		chunks = One (string) or more (table) MSP chunks to send

	Normally internally used, but published just in case you want to 'push' a field onto someone.
	Returns the number of messages used to send the data.
]]
function msptrp:Send( player, chunks )
	local payload = ""
	if type( chunks ) == "string" then		
		payload = chunks;
	elseif type( chunks ) == "table" then
		payload = tconcat( chunks, "\1" );
	end
	
	
	if payload ~= "" then
		local len = #payload
		local queue = "MSPWHISPER" .. player
		if len < 256 then
			ChatThrottleLib:SendAddonMessage( "BULK", "MSP", payload, "WHISPER", player, queue )
			return 1
		else
			local chunk = strsub( payload, 1, 255 )
			ChatThrottleLib:SendAddonMessage( "BULK", "MSP\1", chunk, "WHISPER", player, queue )
			local pos = 256
			local parts = 2
			while pos + 255 <= len do
				chunk = strsub( payload, pos, pos + 254 )
				ChatThrottleLib:SendAddonMessage( "BULK", "MSP\2", chunk, "WHISPER", player, queue )
				pos = pos + 255
				parts = parts + 1
			end
			chunk = strsub( payload, pos )
			ChatThrottleLib:SendAddonMessage( "BULK", "MSP\3", chunk, "WHISPER", player, queue )
			return parts
		end
	end
	return 0
end

--[[
	WoW 4.0.3.13329: Bug Workaround
	(Invisible SendAddonMessage() returning visible ERR_CHAT_PLAYER_NOT_FOUND_S system message on failure)
]]
ChatFrame_AddMessageEventFilter( "CHAT_MSG_SYSTEM", function( self, event, msg ) 
	return msptrp:PlayerKnownAbout( msg:match( ERR_CHAT_PLAYER_NOT_FOUND_S:format( "(.+)" ) ) )
end )
function msptrp:PlayerKnownAbout( player )
	if player == nil or player == "" then
		return false
	end
	return msptrp.char[ player ].supported ~= nil
end