--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Overlays.lua - Integration with NPC map overlay mods.             *
  ****************************************************************************]]


local AddOnName, _NPCScan = ...;
local me = LibStub( "AceEvent-3.0" ):Embed( {} );
_NPCScan.Overlays = me;

local MESSAGE_REGISTER = "NpcOverlay_RegisterScanner";
local MESSAGE_ADD = "NpcOverlay_Add";
local MESSAGE_REMOVE = "NpcOverlay_Remove";
local MESSAGE_FOUND = "NpcOverlay_Found";




--- Announces to overlay mods that _NPCScan will take over control of shown paths.
function me.Register ()
	me:SendMessage( MESSAGE_REGISTER, AddOnName );
end


--- Enables overlay maps for a given NPC ID.
function me.Add ( NpcID )
	me:SendMessage( MESSAGE_ADD, NpcID, AddOnName );
end
--- Disables overlay maps for a given NPC ID.
function me.Remove ( NpcID )
	me:SendMessage( MESSAGE_REMOVE, NpcID, AddOnName );
end
-- Lets overlay mods know the NPC ID was found.
function me.Found ( NpcID )
	me:SendMessage( MESSAGE_FOUND, NpcID, AddOnName );
end