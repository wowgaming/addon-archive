--------------------------------------------------------------------------
-- FriendShare.lua 
--------------------------------------------------------------------------
--[[
FriendShare

author: Vimrasha <vimrasha@fastmail.fm>

FriendShare synchronizes your friends lists across all your alts. No more jotting
down a character name and then logging into all your alts to add it. Just add it
once, and it will be added to your alts automatically when they log in.

Removing friends works the same way. If you remove a friend, then it will be
removed from your alts automatically the next time they log in.

When you log in, that alt is automatically added to your global friends list, and
will become a friend of all your other alts as they log in. This is really just
for auto name completion at the mailbox. If you manually remove an alt from your
friend list, it will not be re-added when you log that alt back in.

When you first start using FrendShare, the global friend list is initialized from
each alt as you log them in. So, just log all your alts in once and from that point
on they will all remain synchronized.

This all works without any user intervention.

Friends are stored on a per server, per faction (Horde or Alliance) basis.
]]--

local Saved_AddFriend = nil;
local Saved_RemoveFriend = nil;

local importedGlobalFriends = {};
local realmAndFaction = {};
local initialized = false;

-- Store current friends so that they are available when processing
-- the PLAYER_LEAVING_WORLD event.
local currentFriends = nil;

--[[ SavedVariables --]]
FriendShare_GlobalFriends = {};
FriendShare_RemovedFriends = {};
FriendShare_Alts = {};
FriendShare_AutoAlts = true;


function FriendShare_ChatPrint(str)
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage(str, 0.3, 0.3, 1.0);
	end
end

function FriendShare_OnLoad()

	-- register events
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");

	SLASH_FRIENDSHARE1 = "/friendshare";
	SLASH_FRIENDSHARE2 = "/fs";
	SlashCmdList["FRIENDSHARE"] = function(msg)
		FriendShare_Command(msg);
	end

	-- Hook the Add/Remove friend handlers
	Saved_AddFriend = AddFriend;
	AddFriend = FriendShare_AddFriend;
	Saved_RemoveFriend = RemoveFriend;
	RemoveFriend = FriendShare_RemoveFriend;

	-- FriendShare_ChatPrint("FriendShare by Vimrasha loaded.");
end

function FriendShare_RealmAndFaction()
	local realmName = GetCVar("realmName");
	local faction = UnitFactionGroup("player");
	return realmName .. "-" .. faction;
end

function FriendShare_CurrentFriends()
	local numFriends = GetNumFriends();
	local curFriends = {};
	
	-- Build a list of my current friends
	for i=1, numFriends do
		local name, level, class, area, connected = GetFriendInfo(i);
		if (name and name ~= UNKNOWN) then curFriends[name] = name; end
	end
	return curFriends;
end


function FriendShare_Command(command)
	local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");
	if (not cmd) then cmd = command; end
	if (not cmd) then cmd = ""; end
	if (not param) then param = ""; end

	if ((cmd == "") or (cmd == "help")) then
		local  lineFormat = "  |cffffffff/friendshare %s|r - %s";
		FriendShare_ChatPrint( "Usage:" );
		FriendShare_ChatPrint(string.format(lineFormat, "<help>", "Print this message."));
		FriendShare_ChatPrint(string.format(lineFormat, "reset", "Reset the globals friend list to the character's current friends list."));
		FriendShare_ChatPrint(string.format(lineFormat, "import", "Import the global friends list."));
		FriendShare_ChatPrint(string.format(lineFormat, "alts", "Toggle auto adding of alts to your local friends list."));
		FriendShare_ChatPrint(string.format(lineFormat, "alts on|off", "Turn auto adding of alts to your local friends list on or off."));
	end
	if (cmd == "reset" ) then
		FriendShare_ChatPrint( "FriendShare: Global friends list has been reset to this character's friends list." );
		-- Reset global friends list to match my friends
		FriendShare_GlobalFriends[realmAndFaction] = FriendShare_CurrentFriends();
		FriendShare_RemovedFriends[realmAndFaction] = {};
	end
	if (cmd == "import" ) then
		-- Import global friends list
		FriendShare_Import();
	end
	if (cmd == "alts" ) then
		local autoAlts = FriendShare_AutoAlts;
		if ( param == "" ) then
			FriendShare_AutoAlts = not FriendShare_AutoAlts;
			if ( FriendShare_AutoAlts ) then
				FriendShare_ChatPrint( "FriendShare: Auto adding of alts toggled on." );
			else
				FriendShare_ChatPrint( "FriendShare: Auto adding of alts toggled off." );
			end
		elseif ( param == "on" ) then
			FriendShare_AutoAlts = true;
			FriendShare_ChatPrint( "FriendShare: Auto adding of alts turned on." );
		elseif ( param == "off" ) then
			FriendShare_AutoAlts = false;
			FriendShare_ChatPrint( "FriendShare: Auto adding of alts turned off." );
		else
			FriendShare_ChatPrint( "FriendShare: Unknown parameter to '/FriendShare alts'." );
		end

		-- If AutoAlts setting changed, then process the alts list
		if ( autoAlts ~= FriendShare_AutoAlts ) then
			local currentFriends = FriendShare_CurrentFriends();
			FriendShare_ProcessAlts( currentFriends );
		end

	end
end

function FriendShare_Import()
	local curFriends = FriendShare_CurrentFriends();
	local player = UnitName("player");
	local numFriends = GetNumFriends();

	-- Clear the list of importedGlobalFriends before trying to import again.
	importedGlobalFriends = {};

	-- Remove local friends that have been removed globaly
	local globalRemoves = FriendShare_RemovedFriends[realmAndFaction];
	for i, name in pairs( globalRemoves ) do
		if ( name ~= player and curFriends[name] and
			not FriendShare_Alts[realmAndFaction][name] )
		then
			RemoveFriend( name );
			numFriends = numFriends - 1;
			curFriends[name] = nil;
		end
	end

	-- Add global friends that are not currently in local friends list
	-- Make a copy of the table as we will modify the original in the loop
	local globalFriends = FriendShare_GlobalFriends[realmAndFaction];
	for i, name in pairs( globalFriends ) do
		if ( name ~= player and not curFriends[name] and
			not FriendShare_RemovedFriends[realmAndFaction][name] and
			not FriendShare_Alts[realmAndFaction][name] )
		then
			-- If we exceed 50 friends (the max) then import will fail
			-- We don't want to removed those players from the global list even though import failed!
			if ( numFriends < 50 ) then
				-- If this charater still exists, it will be added back to the global list
				-- when processing the generated FRIENDLIST_UPDATE event.
				FriendShare_GlobalFriends[realmAndFaction][name] = nil;
				importedGlobalFriends[name] = name;
			end
			-- numFriends is just a guess since we don't know if AddFriend will succeed or not.
			numFriends = numFriends + 1;
			AddFriend( name );
		end
	end

	FriendShare_ProcessAlts( curFriends );
	FriendShare_UpdateGlobalFriends( curFriends );

	if ( numFriends > 50 ) then
		FriendShare_ChatPrint( "FriendShare: Warning! Could not import all friends from global list " ..
			"because you have reached the max number of allowed friends." );
	end
	FriendShare_ChatPrint( "FriendShare: Global friends list imported." );
end


function FriendShare_ProcessAlts( curFriends )
	local player = UnitName( "player" );
	for i, name in pairs( FriendShare_Alts[realmAndFaction] ) do
		local name = FriendShare_Alts[realmAndFaction][i]
		if ( FriendShare_AutoAlts ) then
			-- AutoAlts on - add alts that are not currently friends
			if ( name ~= player and not curFriends[name] ) then
				FriendShare_ChatPrint( "FriendShare: Auto adding alt " .. name .. " to local friends list." );
				AddFriend( name );
			end
		else
			-- AutoAlts off - remove alts that are currently friends
			if ( name ~= player and curFriends[name] ) then
				FriendShare_ChatPrint( "FriendShare: Auto removing alt " .. name .. " from local friends list." );
				RemoveFriend( name );
			end
		end
		-- Alts are not to be stored in the normal lists
		FriendShare_GlobalFriends[realmAndFaction][name] = nil;
		FriendShare_RemovedFriends[realmAndFaction][name] = nil;
	end
	-- Ensure this toon is in the alt list
	if ( not FriendShare_Alts[realmAndFaction][player] ) then
		FriendShare_ChatPrint( "Adding this toon to your global alt list." );
		FriendShare_Alts[realmAndFaction][player] = player;
	end
end

-- Keep a record of current friends for use when handling PLAYER_LEAVING_WORLD.
local savedCurrentFriends = {};
local savedPlayerName;

function FriendShare_OnEvent(event)

	if ( event == "PLAYER_ENTERING_WORLD" ) then
		-- Only do this stuff once.
		this:UnregisterEvent("PLAYER_ENTERING_WORLD");

		-- Can't init these values until the player is in the world...
		realmAndFaction = FriendShare_RealmAndFaction();
		savedPlayerName = UnitName( "player" );


		if ( not FriendShare_GlobalFriends[realmAndFaction] ) then
			FriendShare_GlobalFriends[realmAndFaction] = {};
		end
		-- A client timing bug could have placed this bogus value in the list
		FriendShare_GlobalFriends[realmAndFaction][UNKNOWN] = nil;

		if ( not FriendShare_RemovedFriends[realmAndFaction] ) then
			FriendShare_RemovedFriends[realmAndFaction] = {};
		end
		-- A client timing bug could have placed this bogus value in the list
		FriendShare_RemovedFriends[realmAndFaction][UNKNOWN] = nil;


		if ( not FriendShare_Alts[realmAndFaction] ) then
			FriendShare_Alts[realmAndFaction] = {};
		end

		-- Player must be in the world before we start listening to these events
		-- so that the player's faction is know and its list of friends
		-- has been loaded.
		this:RegisterEvent("FRIENDLIST_UPDATE");

		-- Force a FRIENDLIST_UPDATE event so that we can initialize.
		ShowFriends();
	end

	if ( event == "FRIENDLIST_UPDATE" ) then
		if ( not initialized ) then
			initialized = true;
			-- Import the global friends list.
			FriendShare_Import();
			savedCurrentFriends = FriendShare_CurrentFriends();
			-- Import the global ignore list.
			IgnoreShare_Import();
		else	
			savedCurrentFriends = FriendShare_CurrentFriends();
			FriendShare_UpdateGlobalFriends( savedCurrentFriends );
		end
	end

	if ( event == "PLAYER_LEAVING_WORLD" ) then
		-- Only do this stuff once.
		this:UnregisterEvent("PLAYER_LEAVING_WORLD");

		-- Imported global friends that are not current friends either
		-- had errors on import (player not found) or have been deleted.
		-- Either way they should be removed from the global list.
		for i, name in pairs( importedGlobalFriends ) do
			if ( not savedCurrentFriends[name] and not FriendShare_Alts[realmAndFaction][name] ) then
				FriendShare_GlobalFriends[realmAndFaction][name] = nil;
			end
		end

		-- Check for deleted alts
		if ( FriendShare_AutoAlts ) then
			for i, name in pairs( FriendShare_Alts[realmAndFaction] ) do
				if ( not (name == savedPlayerName) and not savedCurrentFriends[name] ) then
					FriendShare_ChatPrint( "FriendShare: " .. name .. " appears to be a deleted alt." );
					FriendShare_ChatPrint( "FriendShare: Removing " .. name .. " from global alt list." );
					FriendShare_Alts[realmAndFaction][name] = nil;
				end
			end
		end

	end
end

-- Ensure all friends in the given list are in the global friends list
function FriendShare_UpdateGlobalFriends(friendsList)
	for i, name in pairs( friendsList ) do
		if ( not FriendShare_GlobalFriends[realmAndFaction][name] and
			not FriendShare_RemovedFriends[realmAndFaction][name] and
			not FriendShare_Alts[realmAndFaction][name] )
		then
			FriendShare_ChatPrint( "FriendShare: Adding global friend " .. name );
			FriendShare_GlobalFriends[realmAndFaction][name] = name;
		end
	end
end

function FriendShare_AddFriend(name)
	if ( not name ) then return; end

	-- Ensure the first letter and only the first letter is capitalized
	name = string.lower(name);
	name = string.gsub(name, "^%l", string.upper);

	Saved_AddFriend(name);
	-- Friend will be added to the global list on next FRIENDLIST_UPDATE event if needed
	FriendShare_RemovedFriends[realmAndFaction][name] = nil;
end

function FriendShare_RemoveFriend(nameOrIndex)
	local name, level, class, area, connected;
	if ( type(nameOrIndex) == "string" ) then
		name = nameOrIndex;
	else
		name, level, class, area, connected = GetFriendInfo(nameOrIndex);
	end

	if ( not name ) then return; end

	-- Ensure the first letter and only the first letter is capitalized
	name = string.lower(name);
	name = string.gsub(name, "^%l", string.upper);

	Saved_RemoveFriend(name);
	FriendShare_GlobalFriends[realmAndFaction][name] = nil;
	-- Don't put alts on the removed friends list
	if ( not FriendShare_Alts[name] ) then
		FriendShare_RemovedFriends[realmAndFaction][name] = name;
	end
end

