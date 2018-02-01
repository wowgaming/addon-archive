

local actiontypes = {
	A = "ACCEPT",
	C = "COMPLETE",
	T = "TURNIN",
	K = "KILL",
	R = "RUN",
	H = "HEARTH",
	h = "SETHEARTH",
	F = "FLY",
	f = "GETFLIGHTPOINT",
	N = "NOTE",
	B = "BUY",
	b = "BOAT",
	U = "USE",
}


function TourGuide:GetObjectiveTag(tag, i)
	self:Debug(11, "GetObjectiveTag", tag, i)
	i = i or self.current
	local tags = self.tags[i]
	if not tags then return end

	if tag == "O" then return tags:find("|O|")
	elseif tag == "T" then return tags:find("|T|")
	elseif tag == "QID" then return tonumber((tags:match("|QID|(%d+)|")))
	elseif tag == "L" then
		local _, _, lootitem, lootqty = tags:find("|L|(%d+)%s?(%d*)|")
		lootqty = tonumber(lootqty) or 1

		return lootitem, lootqty
	end

	return select(3, tags:find("|"..tag.."|([^|]*)|?"))
end


local myclass, myrace = UnitClass("player"), UnitRace("player")
local function ParseQuests(...)
	local accepts, turnins, completes = {}, {}, {}
	local uniqueid = 1
	local actions, quests, tags = {}, {}, {}
	local i = 1

	for j=1,select("#", ...) do
		local text = select(j, ...)
		local _, _, classes = text:find("|C|([^|]+)|")
		local _, _, races = text:find("|R|([^|]+)|")
		local noraf = text:match("|NORAF|")
		local raf = text:match("|RAF|")

		if text ~= "" and ((TourGuide.db.char.rafmode and not noraf) or (not TourGuide.db.char.rafmode and not raf)) and (not classes or classes:find(myclass)) and (not races or races:find(myrace)) then
			local _, _, action, quest, tag = text:find("^(%a) ([^|]*)(.*)")
			assert(actiontypes[action], "Unknown action: "..text)
			quest = quest:trim()
			if not (action == "A" or action =="C" or action =="T") then
				quest = quest.."@"..uniqueid.."@"
				uniqueid = uniqueid + 1
			end

			actions[i], quests[i], tags[i] = actiontypes[action], quest, tag

			i = i + 1
		end
	end

	return actions, quests, tags
end


function TourGuide:LoadGuide(name, complete)
	if not name then return end

	if complete then self.db.char.completion[self.db.char.currentguide] = 1
	elseif self.actions then self.db.char.completion[self.db.char.currentguide] = (self.current-1)/#self.actions end

	self.db.char.currentguide = self.guides[name] and name or self.guidelist[1]
	self:DebugF(1, "Loading guide: %s", name)
	self.guidechanged = true
	local zonename = name:match("%s*([^]]+) %(.*%)$")
	self.zonename = zonename
	self.actions, self.quests, self.tags = ParseQuests(string.split("\n", self.guides[self.db.char.currentguide]()))

	if not self.db.char.turnins[name] then self.db.char.turnins[name] = {} end
	self.turnedin = self.db.char.turnins[name]
end


