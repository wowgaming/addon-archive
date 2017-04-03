--[[
Name: SpecialEvents-Loot-1.0
Revision: $Rev: 218 $
Author: Xuerian (sky.shell@gmail.com)
Website: http://www.wowace.com/
Description: Special events for players looting items.
Dependencies: AceLibrary, AceEvent-2.0, Deformat
]]

local vmajor, vminor = "SpecialEvents-Loot-1.0", 90000 + tonumber(("$Revision: 218 $"):match("(%d+)"))

if not AceLibrary then error(vmajor .. " requires AceLibrary.") end
if not AceLibrary:HasInstance("AceEvent-2.0") then error(vmajor .. " requires AceEvent-2.0.") end
if not AceLibrary:HasInstance("Deformat-2.0") then error(vmajor .. " requires Deformat-2.0.") end
if not AceLibrary:HasInstance("AceConsole-2.0") then error(vmajor .." requires AceConsole-2.0.") end
if not AceLibrary:IsNewVersion(vmajor, vminor) then return end

local lib = {}
AceLibrary("AceEvent-2.0"):embed(lib)
local console = AceLibrary("AceConsole-2.0")
local deformat = AceLibrary("Deformat-2.0")


----------------------------
--     Initializaiton    --
----------------------------

-- Yay debug.
--local Dump = function(...) lib:PrintLiteral(...) end/

-- Check for detailed loot information
local lootspam = GetCVar('showLootSpam')
if GetCVar("showLootSpam") == "0" then
	console:Print("|cffff5555Warning: You do not have Detailed Loot Information enabled in Advanced Interface Options. Group loot events willl not function properly.")
end

-- Local fun.
local activerolls = 0
local lootpatterns, rollhandlers, unsortedloot, currentsort, lootmethod

-- Chatmsg handler
local function Handler(text)
	SEEL_LastEvent = text
	lootmethod = GetLootMethod()
	-- Handle group loot mode only if we're in the mode and there's a roll going
	if (lootmethod == 'group' or lootmethod == 'needbeforegreed') and activerolls > 0 then
		-- Move through the patterns one by one, match against the message
		for k, v in ipairs(rollhandlers) do
			local pat, func = v[1], v[2]
			local m1, m2, m3, m4 = deformat(text, pat)
			-- Match was found, call the handler with all captured values
			if m1 then
				return func(m1, m2, m3, m4)
			end
		end
	end
	
	-- Optimize by grouped/not and weight patterns by usage
	-- Check group mode (1 corresponds to ungrouped, 2 to grouped)
	local group = (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0) and 2 or 1
	-- If we're not currently sorting for our current mode, or it's been too long since last sort, sort ourpatterns for efficiency
	if not currentsort or currentsort ~= group or unsortedloot > 25 then
		unsortedloot = 0
		currentsort = group
		table.sort(lootpatterns, function(a, b) return a[group] < b[group] end)
	else
		unsortedloot = unsortedloot + 1
	end
	-- Match string against our patterns
	for i, v in ipairs(lootpatterns) do
		local pat, func = v[3], v[4]
		local m1, m2, m3, m4 = deformat(text, pat)
		-- Match found, add to counter and call pattern's handler
		if m1 then
			v[group] = v[group] + 1
			return func(m1, m2, m3, m4)
		end
	end
end

-- Invert gold patterns
local function invert(pstr)
	return pstr:gsub("%%d", "(%1+)")
end
local cg = invert(GOLD_AMOUNT)
local cs = invert(SILVER_AMOUNT)
local cc = invert(COPPER_AMOUNT)

-- Parse coin strings (Really?)
local function ParseCoinString(tstr)
	local g = tstr:match(cg) or 0
	local s = tstr:match(cs) or 0
	local c = tstr:match(cc) or 0
	return g*10000+s*100+c
end

-- Activate a new instance of this library
local function activate(self, oldLib, oldDeactivate)
	if oldLib then
		self.vars = oldLib.vars
		oldLib:UnregisterAllEvents()
	else
		self.vars = { }
	end
	
	-- Hook up with chat events for looting
	self:RegisterEvent("CHAT_MSG_LOOT", Handler)
	self:RegisterEvent("CHAT_MSG_MONEY", Handler)
	
	-- Register for the loopback, called in XLoot Monitor's options, mainly
	self:RegisterEvent("SpecialEvents_LootDummy", Handler)
	
	-- Incriment and deincement rolls to only match while there is a roll happening
	self:RegisterEvent("START_LOOT_ROLL", function() 
		activerolls = activerolls + 1
		end)
	self:RegisterEvent("CANCEL_LOOT_ROLL", function() 
		self:ScheduleEvent(function() 
			activerolls = activerolls < 1 and 0 or activerolls - 1 
		end, 2)
	end)
	
	local player = UnitName('player')

	-- Generate loot pattern handlers
	lootpatterns = { }
	
	-- Base loot handler function. Checks argument types, adds handler to table
	local lhandler = function(str, func)
		assert(type(str), "string", "First argument of lhandler() must be a string, instead, was ["..type(str).."]")
		assert(type(func) == "function" or not func, "Second argument of lhandler() must be a function, was ["..type(str).."]")
		table.insert(lootpatterns, { 0, 0, str, func })
	end
	
	-- Loot triggers
	local loot = function(who, what, num) self:TriggerEvent('SpecialEvents_ItemLooted', who, what, num or 1) end
	local coin = function(who, str) self:TriggerEvent('SpecialEvents_CoinLooted', who, ParseCoinString(str), str) end
	
	-- Add item patterns
	lhandler(LOOT_ITEM, loot)
	lhandler(LOOT_ITEM_MULTIPLE, loot)
	lhandler(LOOT_ITEM_PUSHED_SELF, function(what) loot(player, what) end)
	lhandler(LOOT_ITEM_PUSHED_SELF_MULTIPLE, function(what, num) loot(player, what, num) end)
	lhandler(LOOT_ITEM_SELF, function(what) loot(player, what) end)
	lhandler(LOOT_ITEM_SELF_MULTIPLE, function(what, num) loot(player, what, num) end)
	
	-- Add coin patterns
	lhandler(LOOT_MONEY, function(who, str) coin(who, str) end)
	lhandler(LOOT_MONEY_SPLIT, function(str) coin(player, str) end)
	lhandler(YOU_LOOT_MONEY, function(str) coin(player, str) end)

	-- Generate group loot mode handlers
	rollhandlers = { }

	-- Base handler function. Checks argument types, adds to handler table (Presorted)
	--    The pattern is stored as the first key, and the function to be called in the second
	local handler = function(str, func)
		assert(type(str) == "string", "First argument of handler() must be a string, was a "..type(str))
		assert(type(func) == "function" or not func, "Second argument of handler() must be a function, and must exist")
		table.insert(rollhandlers, { str, func })
	end
	
	-- Figures the appropriate owner of the event
	local ncheck = function(own, who)
		if own or  who == YOU then
			return player
		end
		return who
	end
	
	-- Roll selected handler (You select Greed for XXXX, etc)
	local selected = function(str, ty, own) handler(str,
		function(who, item)
			if own then item = who who = player end
			self:TriggerEvent('SpecialEvents_RollSelected', ty, who, item)
		end)
	end

	-- Rolled handler (XXXX roll - # by xxxxx, etc)
	local rolled = function(str, ty, own) handler(str, 
		function(roll, item, who)
			self:TriggerEvent('SpecialEvents_RollMade', ty, ncheck(own, who), roll, item) 
		end)
	end

	-- Add handlers using construct functions, ordered specifically
	if LOOT_ROLL_DISENCHANT then selected(LOOT_ROLL_DISENCHANT, 'dis') end -- patch 3.3
	selected(LOOT_ROLL_GREED, 'greed')
	selected(LOOT_ROLL_NEED, 'need')
	if LOOT_ROLL_DISENCHANT_SELF then selected(LOOT_ROLL_DISENCHANT_SELF, 'dis', true) end -- patch 3.3
	selected(LOOT_ROLL_GREED_SELF, 'greed', true)
	selected(LOOT_ROLL_NEED_SELF, 'need', true)
	selected(LOOT_ROLL_PASSED_AUTO, 'pass')
	selected(LOOT_ROLL_PASSED_AUTO_FEMALE, 'pass')
	selected(LOOT_ROLL_PASSED_SELF_AUTO, 'pass', true)
	handler(LOOT_ROLL_ALL_PASSED, function(item) self:TriggerEvent('SpecialEvents_RollAllPassed', item) end)
	selected(LOOT_ROLL_PASSED_SELF, 'pass', true)
	selected(LOOT_ROLL_PASSED, 'pass')
	if LOOT_ROLL_ROLLED_DE then rolled(LOOT_ROLL_ROLLED_DE, 'dis') end -- patch 3.3
	rolled(LOOT_ROLL_ROLLED_GREED, 'greed')
	rolled(LOOT_ROLL_ROLLED_NEED, 'need') 
	handler(LOOT_ROLL_WON, function(who, item) self:TriggerEvent('SpecialEvents_RollWon', item, ncheck(own, who)) end)

	-- Possibly deactivate a older version (We don't have a deactivate! Nya!)
	if oldDeactivate then oldDeactivate(oldLib) end
end

--------------------------------
--      Load this bitch!      --
--------------------------------
AceLibrary:Register(lib, vmajor, vminor, activate)
