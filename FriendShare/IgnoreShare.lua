--------------------------------------------------------------------------
-- IgnoreShare.lua 
--------------------------------------------------------------------------
--[[
author: Vimrasha

IgnoreShare works the same way that FriendShare works. The only 
difference is that it synchronizes your ignore lists instead of
your friends lists.
]]--


local Saved_AddIgnore = nil;
local Saved_DelIgnore = nil;
local realmAndFaction = nil;

--[[ SavedVariables --]]
IgnoreShare_GlobalIgnores = {}
IgnoreShare_RemovedIgnores = {}

function IgnoreShare_ChatPrint(str)
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage(str, 0.3, 0.3, 1.0);
	end
end

function IgnoreShare_OnLoad()

	-- register events
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");

	SLASH_IgnoreShare1 = "/ignoreshare";
	SLASH_IgnoreShare2 = "/is";
	SlashCmdList["IgnoreShare"] = function(msg)
		IgnoreShare_Command(msg);
	end

	-- Hook the Add/Remove ignore handlers
	Saved_AddIgnore = AddIgnore;
	AddIgnore = IgnoreShare_AddIgnore;
	Saved_DelIgnore = DelIgnore;
	DelIgnore = IgnoreShare_DelIgnore;

	-- IgnoreShare_ChatPrint("IgnoreShare by Vimrasha loaded.");
end

function IgnoreShare_CurrentIgnores()
	local numIgnores = GetNumIgnores();
	local curIgnores = {};
	
	-- Build a list of my current ignores so I don't try to add them below.
	for i=1, numIgnores do
		local name = GetIgnoreName(i);
		if (name and name ~= UNKNOWN) then curIgnores[name] = name; end
	end
	return curIgnores;
end


function IgnoreShare_Command(command)
	local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");
	if (not cmd) then cmd = command; end
	if (not cmd) then cmd = ""; end
	if (not param) then param = ""; end

	if ((cmd == "") or (cmd == "help")) then
		local  lineFormat = "  |cffffffff/IgnoreShare %s|r - %s";
		IgnoreShare_ChatPrint( "Usage:" );
		IgnoreShare_ChatPrint(string.format(lineFormat, "<help>", "Print this message."));
		IgnoreShare_ChatPrint(string.format(lineFormat, "reset", "Reset the global ignore list."));
		IgnoreShare_ChatPrint(string.format(lineFormat, "import", "Import the global ignore list."));
	end
	if (cmd == "reset" ) then
		-- Reset global ignores list to match my ignores
		IgnoreShare_GlobalIgnores[realmAndFaction] = IgnoreShare_CurrentIgnores();
		IgnoreShare_RemovedIgnores[realmAndFaction] = {};
	end
	if ( cmd == "import" ) then
		IgnoreShare_Import();
		FriendShare_ChatPrint( "IgnoreShare: Global ignore list imported." );
	end
end

function IgnoreShare_Import()
	local curIgnores = IgnoreShare_CurrentIgnores();
	local player = UnitName("player");

	-- Add global ignores that are not currently in local ignores list
	-- Make a copy of the table as we will modify the original in the loop
	local globalIgnores = IgnoreShare_GlobalIgnores[realmAndFaction];
	for i, name in pairs( globalIgnores ) do
		if ( name ~= player and not curIgnores[name] and
			not IgnoreShare_RemovedIgnores[realmAndFaction][name] )
		then
			IgnoreShare_ChatPrint( "IgnoreShare: Attempting to ignore " .. name );
			AddIgnore( name );
		end
	end

	-- Remove local ignores that have been removed globaly
	for i, name in pairs( IgnoreShare_RemovedIgnores[realmAndFaction] ) do
		if ( name ~= player and curIgnores[name] ) then
			IgnoreShare_GlobalIgnores[realmAndFaction][name] = nil;
			DelIgnore( name );
			curIgnores[name] = nil;
		end
	end

	IgnoreShare_UpdateGlobalIgnores( curIgnores );
	IgnoreShare_ChatPrint( "IgnoreShare: Global ignore list imported." );
end

function IgnoreShare_OnEvent(event)

	if ( event == "PLAYER_ENTERING_WORLD" ) then
		-- Only do this stuff once.
		this:UnregisterEvent("PLAYER_ENTERING_WORLD");

		-- Can't init this value until the player is in the world...
		realmAndFaction = FriendShare_RealmAndFaction();

		if ( not IgnoreShare_GlobalIgnores[realmAndFaction] ) then
			IgnoreShare_GlobalIgnores[realmAndFaction] = {};
		end
		-- A client timing bug could have placed this bogus value in the list
		IgnoreShare_GlobalIgnores[realmAndFaction][UNKNOWN] = nil;

		
		if ( not IgnoreShare_RemovedIgnores[realmAndFaction] ) then
			IgnoreShare_RemovedIgnores[realmAndFaction] = {};
		end
		-- A client timing bug could have placed this bogus value in the list
		IgnoreShare_RemovedIgnores[realmAndFaction][UNKNOWN] = nil;

		-- Player must be in the world before we start listening to these events
		-- so that the player's faction is know and its list of ignores
		-- has been loaded.
		this:RegisterEvent("IGNORELIST_UPDATE");
	end

	if ( event == "IGNORELIST_UPDATE" ) then
		local curIgnores = IgnoreShare_CurrentIgnores();
		IgnoreShare_UpdateGlobalIgnores( curIgnores );
	end

end

-- Ensure all ignores in the given list are in the global ignores list
function IgnoreShare_UpdateGlobalIgnores(ignoresList)
	for i, name in pairs( ignoresList ) do
		if ( not IgnoreShare_GlobalIgnores[realmAndFaction][name] and
			not IgnoreShare_RemovedIgnores[realmAndFaction][name] )
		then
			IgnoreShare_ChatPrint( "IgnoreShare: Adding global ignore " .. name );
			IgnoreShare_GlobalIgnores[realmAndFaction][name] = name;
		end
	end
end

function IgnoreShare_AddIgnore(name)
	if ( not name ) then return; end

	-- Ensure the first letter and only the first letter is capitalized
	name = string.lower(name);
	name = string.gsub(name, "^%l", string.upper);

	Saved_AddIgnore(name);
	-- Ignore will be added to the global list on next IGNORELIST_UPDATE event if needed
	IgnoreShare_RemovedIgnores[realmAndFaction][name] = nil;
end

function IgnoreShare_DelIgnore(nameOrIndex)
	local name = nil;
	if ( type(nameOrIndex) == "string" ) then
		name = nameOrIndex;
	else
		name = GetIgnoreName(nameOrIndex);
	end

	if ( not name ) then return; end

	-- Ensure the first letter and only the first letter is capitalized
	name = string.lower(name);
	name = string.gsub(name, "^%l", string.upper);

	Saved_DelIgnore(name);
	IgnoreShare_GlobalIgnores[realmAndFaction][name] = nil;
	IgnoreShare_RemovedIgnores[realmAndFaction][name] = name;
end

