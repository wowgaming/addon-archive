Healium_Slash = "/hlm" -- the slash command 

local function DumpVar(varName, Value)
	if (Value == nil) then 
		Healium_Print(varName .. " = (nil)")	
	else
		Healium_Print(varName .. " = " .. tostring(Value))	
	end
end

function Healium_InitSlashCommands()
	SLASH_HEALIUM1 = Healium_Slash
	SlashCmdList["HEALIUM"] = Healium_SlashCmdHandler
end	


local function printUsage()
	Healium_Print(Healium_AddonName .. " Commands")  
	Healium_Print(Healium_Slash .. " - Shows " .. Healium_AddonName .. " commands.  (what you see here)")
	Healium_Print(Healium_Slash .. " config - Shows the " .. Healium_AddonName .. " config panel")		
	Healium_Print(Healium_Slash .. " show [party | pets | me | tanks | 1-8] - Shows the corresponding " .. Healium_AddonName .. " frame")				
	Healium_Print(Healium_Slash .. " reset frames - Resets the positions of all " .. Healium_AddonName .. " frames")	
	Healium_Print(Healium_Slash .. " friends add [name or Target] - Adds name to the " .. Healium_AddonName .. " friends list.")	
	Healium_Print(Healium_Slash .. " friends remove [name or Target] - Removes name from the " .. Healium_AddonName .. " friends list.")		
	Healium_Print(Healium_Slash .. " friends show - Shows the current " .. Healium_AddonName .. " friends list.")			
	Healium_Print(Healium_Slash .. " friends clear - clears the " .. Healium_AddonName .. " friends list.")				
--		Healium_Print(Slash .. " reset - Resets the ".. Healium_AddonName .. " UI")
--		DEFAULT_CHAT_FRAME:AddMessage(Slash .. " debug - Toggles " .. Healium_AddonName .. " debugging")
--		DEFAULT_CHAT_FRAME:AddMessage(Slash .. " dump - Outputs " .. Healium_AddonName .. " variables for debugging purposes")
end

-- handles /hlm reset 
local function doReset(args)
	if (args == "frames") then 
		Healium_ResetAllFramePositions()
	elseif (cmd == "all") then
		Healium = nil
		Healium_Print("Reset all complete.  Please log out now.")  
	elseif (cmd == "profiles") then
		Healium.Profiles = nil
		Healium_Print("Reset Profiles complete.  Please log out now.")  
	else
		printUsage()
	end
end

-- handles /hlm debug
local function doDebug(args)
	Healium_Debug = not Healium_Debug
	if (Healium_Debug) then
		Healium_Print(Healium_AddonName .. " Debug is ON")
	else
		Healium_Print(Healium_AddonName .. " Debug is OFF")
	end
end

-- handles /hlm dump
local function doDump(args)
	if not IsAddOnLoaded("Blizzard_DebugTools") then
		LoadAddOn("Blizzard_DebugTools")
	end	
	DevTools_Dump("Healium = ")
	DevTools_Dump(Healium)
	DevTools_Dump("")
	DevTools_Dump("Healium_ButtonIDs = ")
	DevTools_Dump(Healium_ButtonIDs)
end

-- handles /hlm config
local function doConfig(args)
	Healium_ShowConfigPanel()
end

local mt = { __index =  function() return printUsage end }

local showHandlers = {
	["1"] = function() Healium_ShowHideGroupFrame(1, true) end,
	["2"] = function() Healium_ShowHideGroupFrame(2, true) end,
	["3"] = function() Healium_ShowHideGroupFrame(3, true) end,
	["4"] = function() Healium_ShowHideGroupFrame(4, true) end,
	["5"] = function() Healium_ShowHideGroupFrame(5, true) end,
	["6"] = function() Healium_ShowHideGroupFrame(6, true) end,
	["7"] = function() Healium_ShowHideGroupFrame(7, true) end,
	["8"] = function() Healium_ShowHideGroupFrame(8, true) end,
	party = function() Healium_ShowHidePartyFrame(true) end,
	pets = function() Healium_ShowHidePetsFrame(true) end,
	me = function() Healium_ShowHideMeFrame(true) end,
	friends = function() Healium_ShowHideFriendsFrame(true) end,
	tanks = function() Healium_ShowHideTanksFrame(true) end,

}

setmetatable(showHandlers, mt)

-- handles /hlm show
local function doShow(args)
	if args == nil then
		Healium_ShowHidePartyFrame(true)
		return
	end
	
	return showHandlers[args]()
end

--[[ *************************************************************************************
									FRIENDS
************************************************************************************* --]]


local function GetFriendsTarget(args)
	local friend = args
	
	if args == nil then
		local realm
		friend, realm  = UnitName("Target")
		if realm ~= nil then
			if realm:len() > 0 then
				friend = friend .. "-" .. realm
			end
		end
	end
	
	if friend == nil then
		Healium_Warn("No unit specified")
		return nil
	end

	return friend
end

-- handles /hlm friends add
local function doFriendsAdd(args)
	local friend = GetFriendsTarget(args)
	
	if friend == nil then 
		return
	end
	
	local f = HealiumGlobal.Friends[string.lower(friend)]
	if f then
		Healium_Warn(friend .. " is already in the friends list.")
		return
	end
	
	HealiumGlobal.Friends[string.lower(friend)] = friend
	Healium_UpdateFriends()
	Healium_Print(friend .. " added to friends list") 
end

-- handles  /hlm friends remove
local function doFriendsRemove(args)
	local friend = GetFriendsTarget(args)
	
	if friend == nil then 
		return
	end
	
	local num = tonumber(friend)

	if num then
		local index = 1
		for k, v in pairs(HealiumGlobal.Friends) do
			if index == num then 
				friend = v
			end
			index = index + 1
		end
	end
	
	local f = HealiumGlobal.Friends[string.lower(friend)]
	if f == nil then
		Healium_Warn(friend .. " is not in the friends list.")
		return
	end	
	
	HealiumGlobal.Friends[string.lower(friend)] = nil
	Healium_UpdateFriends()
	Healium_Print(f .. " removed from friends list.") 
end

-- handles /hlm friends show
local function doFriendsShow(args)
	local friends = ""
	local index = 1
	Healium_Print("Listing " .. Healium_AddonName .. " friends:")
	for k, v in pairs(HealiumGlobal.Friends) do
		Healium_Print("Friend (" .. index .. ") " .. v)
		index = index + 1
	end
end

local function doFriendsClear(args)
	HealiumGlobal.Friends = {}
	Healium_UpdateFriends()
	Healium_Print("Friends cleared.")	
end

local friendsHandlers = {
	add = doFriendsAdd,
	remove = doFriendsRemove,
	show = doFriendsShow,
	clear = doFriendsClear,
	list = doFriendsShow,
}

setmetatable(friendsHandlers, mt)

--handles /hlm friends
local function doFriends(val)
	if val == nil then
		doFriendsShow()
		return
	end
	
	local switch = val:match("([^ ]+)")
	local args = val:match("[^ ]+ (.+)")	

	return friendsHandlers[switch](args)
end

local handlers = {
	reset = doReset,
	dump = doDump,
	config = doConfig,
	show = doShow,
	friend = doFriends,
	friends = doFriends,
	debug = doDebug,	
}

setmetatable(handlers, mt)

-- handles the slash commands for this addon
function Healium_SlashCmdHandler(cmd)
	local switch = cmd:match("([^ ]+)")
	local args = cmd:match("[^ ]+ (.+)")	
	return handlers[switch](args)
end
