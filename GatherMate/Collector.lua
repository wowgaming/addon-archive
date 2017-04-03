local GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate")
local Collector = GatherMate:NewModule("Collector", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("GatherMate",true)
local NL = LibStub("AceLocale-3.0"):GetLocale("GatherMateNodes")   -- for get the local name of Gas Cloud´s
local Display = nil
-- prevSpell, curSpell are markers for what has been cast now and the lastcast
-- gatherevents if a flag for wether we are listening to events
local prevSpell, curSpell, foundTarget, gatherEvents, ga

--[[
Convert for 2.4 spell IDs
]]
local miningSpell = (GetSpellInfo(2575))
local herbSpell = (GetSpellInfo(2366))
local herbSkill = (GetSpellInfo(9134))
local fishSpell = (GetSpellInfo(33095))
local gasSpell = (GetSpellInfo(30427))
--local gasSpell = (GetSpellInfo(48929))  --other gasspell 
local openSpell = (GetSpellInfo(3365))
local openNoTextSpell = (GetSpellInfo(22810))
local pickSpell = (GetSpellInfo(1804))
--[[
Convert for 3.1.3 Item IDs to get the name for Gascloud Item´s
]]
local Dampf = (GetItemInfo(37705)) or ""
local Windig = (GetItemInfo(22572)) or ""
local Sumpf = (GetItemInfo(22578)) or ""
local Teufel = (GetItemInfo(22577)) or ""
local Arkan = (GetItemInfo(22576)) or ""

local spells = { -- spellname to "database name"
	[miningSpell] = "Mining",
	[herbSpell] = "Herb Gathering",
	[fishSpell] = "Fishing",
	[gasSpell] = "Extract Gas",
	[openSpell] = "Treasure",
	[openNoTextSpell] = "Treasure",
	[pickSpell] = "Treasure",
}
local tooltipLeftText1 = _G["GameTooltipTextLeft1"]
local strfind, stringmatch = string.find, string.match
local pii = math.pi
local sin = math.sin
local cos = math.cos
local gsub = gsub
local strtrim = strtrim
--[[
	This search string code no longer needed since we use CombatEvent to detect gas clouds harvesting
]]
-- buffsearchstring is for gas extartion detection of the aura event
-- local buffSearchString
--local sub_string = GetLocale() == "deDE" and "%%%d$s" or "%%s"
--buffSearchString = string.gsub(AURAADDEDOTHERHELPFUL, sub_string, "(.+)")

local function getArrowDirection(...)
	if GetPlayerFacing then
		return GetPlayerFacing()
	else
		if(GetCVar("rotateMinimap") == "1") then return -MiniMapCompassRing:GetFacing()	end
		for i=select("#",...),1,-1 do
			local model=select(i,...)
			if model:IsObjectType("Model") and not model:GetName() then	return model and model:GetFacing() end
		end
		return nil
	end
end

--[[
	Enable the collector
]]
function Collector:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZoneChange")
	self:ZoneChange()
end

--[[
	Register the events we are interesting
]]
function Collector:RegisterGatherEvents()
	self:RegisterEvent("UNIT_SPELLCAST_SENT","SpellStarted")
	self:RegisterEvent("UNIT_SPELLCAST_STOP","SpellStopped")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED","SpellFailed")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED","SpellFailed")
	self:RegisterEvent("CURSOR_UPDATE","CursorChange")
	self:RegisterEvent("UI_ERROR_MESSAGE","UIError")
	self:RegisterEvent("LOOT_CLOSED","GatherCompleted")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "GasBuffDetector")
	self:RegisterEvent("CHAT_MSG_LOOT","Loot")		--for Gas Clout ther not have a Died Event
	gatherEvents = true
end

--[[
	Unregister the events
]]
function Collector:UnregisterGatherEvents()
	self:UnregisterEvent("UNIT_SPELLCAST_SENT")
	self:UnregisterEvent("UNIT_SPELLCAST_SENT")
	self:UnregisterEvent("UNIT_SPELLCAST_STOP")
	self:UnregisterEvent("UNIT_SPELLCAST_FAILED")
	self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
	self:UnregisterEvent("CURSOR_UPDATE")
	self:UnregisterEvent("UI_ERROR_MESSAGE")
	self:UnregisterEvent("LOOT_CLOSED")
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:UnregisterEvent("CHAT_MSG_LOOT")
	gatherEvents = false
end

--[[
	Change of Zone event
]]
function Collector:ZoneChange()
	local inInstance, instanceType = IsInInstance()
	if inInstance and gatherEvents then
		self:UnregisterGatherEvents()
	elseif not gatherEvents then
		self:RegisterGatherEvents()
	end
end
--[[
	This is a hack for scanning mote extraction, hopefully blizz will make the mote mobs visible so we can mouse over 
	or get a better event instead of cha msg parsing
	!! I have changed some places in this funktion and added with it mine is implemented funktion and this the gas seem, they an event UNIT_DIED have here are immediately processed.  Devil™ @malfurion
]]
function Collector:GasBuffDetector(b,timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId,spellName,spellSchool,auraType)
	if foundTarget or (prevSpell and prevSpell ~= gasSpell) then return end	
	if eventType == "SPELL_CAST_SUCCESS" and  spellName == gasSpell then
	ga = gasSpell		
	elseif eventType == "UNIT_DISSIPATES" and  ga == gasSpell then
		foundTarget = true
		self:addItem(ga,dstName)
		ga = "No"
	end
end
--[[
	This funktion analyzes the Loot and shows him to a gas occurence.
]]
function Collector:Loot(eventl,was)
	if ga ~= gasSpell then return	end	
	if not was then return end
	if eventl == "CHAT_MSG_LOOT" and ga == gasSpell  then			
	if gam == "0" and strfind(was, Dampf) then		
		foundTarget = true	
	    Obj = NL["Steam Cloud"]
		self:addItem(ga,Obj)		
		gam = "1"			
	elseif gam == "0" and  strfind(was, Windig) then
		foundTarget = true		
	    Obj = NL["Windy Cloud"]
		self:addItem(ga,Obj)		
		gam = "1"
	elseif gam == "0" and  strfind(was, Sumpf) then
		foundTarget = true	
	    Obj = NL["Swamp Gas"]
		self:addItem(ga,Obj)		
		gam = "1"
	elseif gam == "0" and  strfind(was, Teufel) then
		foundTarget = true	
	    Obj = NL["Felmist"]
		self:addItem(ga,Obj)		
		gam = "1"
	elseif gam == "0" and  strfind(was, Arkan) then
		foundTarget = true	
	    Obj = NL["Arcane Vortex"]
		self:addItem(ga,Obj)
		gam = "1"	
	end
	end
end
--[[
	Any time we close a loot window stop checking for targets ala the Fishing bobber
]]
function Collector:GatherCompleted()
	prevSpell, curSpell = nil, nil
	foundTarget = false
end


--[[
	When the hand icon goes to a gear see if we can find a nde under the gear ala for the fishing bobber OR herb of mine
]]
function Collector:CursorChange()
	if foundTarget then return end
	if (MinimapCluster:IsMouseOver()) then return end
	if spells[prevSpell] then 
		self:GetWorldTarget()
	end
end

--[[
	We stopped casting the spell
]]
function Collector:SpellStopped(event,unit)
	if unit ~= "player" then return end
	if spells[prevSpell] then
		self:GetWorldTarget()
	end
	-- prev spel needs set since it is used for cursor changes
	prevSpell, curSpell = curSpell, curSpell
end

--[[
	We failed to cast
]]
function Collector:SpellFailed(event,unit)
	if unit ~= "player" then return end
	prevSpell, curSpell = nil, nil
end

--[[
	UI Error from gathering when you dont have the required skill
]]
function Collector:UIError(event,msg)
	local what = tooltipLeftText1:GetText();
	if not what then return end
	if strfind(msg, miningSpell) then
		self:addItem(miningSpell,what)
	elseif strfind(msg, herbSkill) then
		self:addItem(herbSpell,what)
	elseif strfind(msg, pickSpell) or strfind(msg, openSpell) then -- locked box or failed pick
		self:addItem(openSpell, what)
	end
end

--[[
	spell cast started
]]
function Collector:SpellStarted(event,unit,spellcast,rank,target)
	if unit ~= "player" then return end
	foundTarget = false
	ga ="NO"
	gam = "0"
	if spells[spellcast] then
		curSpell = spellcast
		prevSpell = spellcast
		local nodeID = GatherMate:GetIDForNode(spells[prevSpell], target)
		if nodeID then -- seem 2.4 has the node name now as the target
			self:addItem(prevSpell,target)
			foundTarget = true
		else
			self:GetWorldTarget()
		end
	else
		prevSpell, curSpell = nil, nil
	end
end

--[[
	add an item to the map (we delgate to GatherMate)
]]
local lastNode = ""
local lastNodeCoords = 0

function Collector:addItem(skill,what)
	local x, y = GetPlayerMapPosition("player")
	if x == 0 and y == 0 then return end

	-- Temporary fix, the map "ScarletEnclave" and "EasternPlaguelands"
	-- both have the same English display name as "Eastern Plaguelands"
	-- so we ignore the new Death Knight starting zone for now.
	if GetMapInfo() == "ScarletEnclave" then return end
	--self:GatherCompleted()
	local zone = GetRealZoneText()
	local node_type = spells[skill]
	if not node_type or not what then return end
	-- db lock check
	if GatherMate.db.profile.dbLocks[node_type] then
		return
	end
	local range = GatherMate.db.profile.cleanupRange[node_type]
	-- special case for fishing and gas extraction guage the pointing direction
	if node_type == fishSpell or node_type == gasSpell then
		local yw, yh = GatherMate:GetZoneSize(zone)
		if yw == 0 or yh == 0 then return end -- No zone size data
		x,y = self:GetFloatingNodeLocation(x, y, yw, yh)
	end
	local nid = GatherMate:GetIDForNode(node_type, what)
	-- if we couldnt find the node id for what was found, exit the add
	if not nid then return end 
	local rares = self.rareNodes
	-- run through the nearby's
	local skip = false
	local zoneID = GatherMate:GetZoneID(zone)
	local foundCoord = GatherMate:getID(x, y)
	local specialNode = false
	local specialWhat = what
	if foundCoord == lastNodeCoords and what == lastNode then return end
	-- DISABLE SPECIAL NODE PROCESSING FOR HERBS
	--if self.specials[zoneID] and self.specials[zoneID][node_type] ~= nil then
	--	specialWhat = GatherMate:GetNameForNode(node_type,self.specials[zoneID][node_type]) 
	--	specialNode = true
	--end
	for coord, nodeID in GatherMate:FindNearbyNode(zone, x, y, node_type, range, true) do
		if nodeID == nid or rares[nodeID] and rares[nodeID][nid]  then
			GatherMate:RemoveNodeByID(zone, node_type, coord)
		-- we're trying to add a rare node, but there is already a normal node present, skip the adding
		elseif rares[nid] and rares[nid][nodeID] then
			skip = true
		elseif specialNode then -- handle special case zone mappings
			skip = false
			GatherMate:RemoveNodeByID(zone, node_type, coord)
		end
	end
	if not skip then
		if specialNode then
			GatherMate:AddNode(zone, x, y, node_type, specialWhat)			
		else
			GatherMate:AddNode(zone, x, y, node_type, what)
		end
		lastNode = what
		lastNodeCoords = foundCoord
	end
end

--[[
	move the node 20 yards in the direction the player is looking at
]]
function Collector:GetFloatingNodeLocation(x,y,yardWidth,yardHeight)
	local facing = getArrowDirection(Minimap:GetChildren())
	if not facing then	-- happens when minimap rotation is on
		return x,y
	else
		local rad = facing + pii
		return x + sin(rad)*20/yardWidth, y + cos(rad)*20/yardHeight
	end	
end

--[[
	get the target your clicking on
]]
function Collector:GetWorldTarget()
	if foundTarget or not spells[curSpell] then return end
	if (MinimapCluster:IsMouseOver()) then return end
	local what = tooltipLeftText1:GetText()
	local nodeID = GatherMate:GetIDForNode(spells[prevSpell], what)
	if what and prevSpell and what ~= prevSpell and nodeID then
		self:addItem(prevSpell,what)
		foundTarget = true
	end
end
