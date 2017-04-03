local EveryQuest = LibStub("AceAddon-3.0"):GetAddon("EveryQuest")
local L = LibStub("AceLocale-3.0"):GetLocale("EveryQuest")
local Quixote = LibStub("LibQuixote-2.0")
local MODNAME = "Import"
local Import = EveryQuest:NewModule(MODNAME)
local db, dbpc
local server = GetRealmName()
local playername = UnitName("player")
local options
local clrimportchk = false

local function getOptions()
	if not options then
		options = {
			type = "group",
			name = L["Import"], -- Import Options Header
			arg = MODNAME,
			args = {
				intro = {
					order = 1,
					type = "description",
					name = L["EQ_IMPORT"] .. "\n", -- Import Options
				},
				questguru = {
					order = 2,
					type = "execute",
					name = L["Import QuestGuru Data"], -- Import Options
					desc = L["Import QuestGuru Data"], -- Import Options
					func = function() Import:ImportQuestGuru() end,
					disabled = not IsAddOnLoaded("QuestGuru"),
				},
				questhistory = {
					order = 3,
					type = "execute",
					name = L["Import QuestHistory Data"], -- Import Options
					desc = L["QuestHistory importing is strictly alpha quality. This is due to having to guess at which quest you are trying to import."], -- Import Options
					func = function() Import:ImportQuestHistory() end,
					disabled = not IsAddOnLoaded("QuestHistory"),
				},
				trailer = {
					order = 4,
					type = "description",
					name = L["EQ_IMPORT_TRAILER"] .. "\n", -- Import Options
				},
				clearimportcheck = {
					order = 5,
					type = "toggle",
					name = L["Clear Import Confirm"], -- Import Options
					get = function(info) return clrimportchk end,
					set = function(info, value) clrimportchk = value end,
				},
				clearimport = {
					order = 6,
					type = "execute",
					name = L["Clear Imported Data"], -- Import Options
					desc = L["Delete any quest tagged as being imported."], -- Import Options
					func = function() Import:ClearImport() end,
					disabled = function () if clrimportchk == true then return false else return true end end,
				},
				clearimportdesc = {
					order = 7,
					type = "description",
					name = L["EQ_CLEARIMPORTDESC"] .. "\n", -- Import Options
				},
			}
		}
	end
	
	return options
end

function Import:OnInitialize()
	--if (IsAddOnLoaded("QuestHistory") or IsAddOnLoaded("QuestGuru")) then
		db = EveryQuest.db.profile
		dbpc = EveryQuest.dbpc.profile.history
		EveryQuest:RegisterModuleOptions(MODNAME, getOptions, L["Import"]) -- Import Options Header
	--else
		--EveryQuest:Debug("Import:OnInitialize failed because QuestHistory and/or QuestGuru are not loaded.")
	--end
end

function Import:ImportQuestGuru()
	local count = 0
	--EveryQuest:Debug("I wanted to import your QuestGuru history, but sadly I haven't gotten around to it yet. Bummer.")
	EveryQuest:Debug(playername)
	local questid, status, currentid
	if (QuestGuru_Quests and QuestGuru_Quests[server]) then
		for k,v in pairs(QuestGuru_Quests[server]) do
			if (string.match(k, "^%d+$") == nil) then
				if (QuestGuru_Quests[server][k][playername]) then
					EveryQuest:Debug(k)
					-- lets import this!
					currentid = QuestGuru_Quests[server][k]
					questid = tonumber(currentid["_link"]:match(":(%d+):"))
					if (currentid[playername]:match("^Current")) then
						status = Import:CheckStatus(questid)
					elseif (currentid[playername]:match("^Completed")) then
						status = 2
					elseif (currentid[playername]:match("^Abandoned")) then
						status = -1
					end
					if (Import:ImportQuest(questid, nil, status, 1)) then
						count = count + 1
					end
					questid = nil
					status = nil
				end
			end
		end
		EveryQuest:Print( sfmt(L["Imported %d quests from %s"], count,  -- Import finished message, %d = number imported, %s = localized import source
																		L["QuestGuru"]) ) -- Import source
	else
		EveryQuest:Print(L["Import failed, you have no data relating to this character on this server."]) -- Import failed message
	end
end

function Import:ImportQuestHistory()
	local count = 0
	--EveryQuest:Debug("I wanted to import your quest history from QuestHistory, but sadly I haven't gotten around to it yet. Bummer.")
	local questid, status, currentid, zone
	if (QuestHistory_List and QuestHistory_List[server] and QuestHistory_List[server][playername]) then
		for k,v in pairs(QuestHistory_List[server][playername]) do
			currentid = QuestHistory_List[server][playername][k]
			if (currentid["lk"]) then -- WOWZERS, IT HAS A LINK!
				questid = tonumber(currentid["lk"]:match(":(%d+):"))
			else -- Bummer, no link, you're a bitch QuestHistory, but wait, I already wrote code to do this right? Somewhere...
				-- lets try to get a quest ID from the title [t] and the category [c], to sure it up, we can even add in the level [l]
				quest, zone = EveryQuest:GetQuestData(nil, currentid["c"], currentid["t"])
				if (quest and quest.id) then
					questid = quest.id
				end
			end
			-- since we don't know if we'll get a quest id...
			if (questid) then
				-- now for the status! yay
				if (currentid["a"] or currentid["f"]) then
					status = -1
				elseif (currentid["tc"]) then
					status = 2
				else
					status = Import:CheckStatus(questid)
				end
				if (Import:ImportQuest(questid, zone, status, 2)) then
					count = count + 1
				end
			end
			zone = nil
			questid = nil
			status = nil
		end
		EveryQuest:Print( sfmt(L["Imported %d quests from %s"], count,  -- Import finished message, %d = number imported, %s = localized import source
																		L["QuestHistory"]) ) -- Import source
	else
		EveryQuest:Print(L["Import failed, you have no data relating to this character on this server."]) -- Import failed message
	end
end

function Import:CheckStatus(questid)
	-- check to see if it's complete just not turned in
	local _, _, _, _, _, _, completed, _, _, category = Quixote:GetQuestByUid(questid)
	return (completed) and 1 or 0
end

local function cmpstatus(a, b)
	if (a == b) then
        return 0;
    end
    return (a < b) and -1 or 1
end

function Import:ImportQuest(questid, zoneid, status, from)
	EveryQuest:Debug("We're trying to import quest "..tostring(questid).. " which is from zone "..tostring(zoneid).. " with a status of " .. tostring(status) .. " from addon " .. tostring(from)..".")
	if (not zoneid) then
		--- we need to try to get the zoneid here for quests without one passed in, super bummer here because it's a pain
		quest, zoneid = EveryQuest:GetQuestData(questid)
	else
		quest, zoneid = EveryQuest:GetQuestData(questid, nil, nil, zoneid)
	end
	local b = -2
	-- next lets check to see if we even need to import it, as in we may have seen it in EQ
	if (dbpc[zoneid] and dbpc[zoneid][quest.id]) then
		-- we've seen it in EQ already, check the status
		b = dbpc[zoneid][quest.id]["status"]
	end
	
	if (cmpstatus(status, b) == 1) then
		-- we deam this quest worthy of import
		EveryQuest:Debug("status: " .. tostring(status) .. "  b: " .. tostring(b) .. "  cmp: " .. cmpstatus(status, b))
		EveryQuest:AddQuest(quest.id, nil, nil, zoneid)
		dbpc[zoneid][quest.id]["imported"] = from
		dbpc[zoneid][quest.id]["status"] = status
		return true
	else
		return false
	end
end

function Import:ClearImport()
	local count = 0
	for k,v in pairs(dbpc) do -- each zoneid
		for questid, quest in pairs(v) do -- each quest in the zone
			if (quest["imported"] ~= nil and (quest["imported"] == 1 or quest["imported"] == 2)) then
				dbpc[k][questid] = nil
				count = count + 1
			end
		end
	end
	EveryQuest:Print(string.format(L["Deleted %d quests from your database"], count)) -- Import: Delete imported data message
	clrimportchk = false
end

--- EOF ---