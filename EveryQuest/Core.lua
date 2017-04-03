
local ALPHA = "ALPHA"
local RELEASE = "RELEASE"
local UNKNOWN = "UNKNOWN"
local releaseString = nil
local addon = LibStub("AceAddon-3.0"):NewAddon("EveryQuest", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")
EveryQuest = addon
local Quixote = LibStub("LibQuixote-2.0")
local L = LibStub("AceLocale-3.0"):GetLocale("EveryQuest")
local locale = GetLocale()
local releaseRevision = nil
do -- Borrowed from BigWigs :)
	-- START: MAGIC WOWACE VOODOO VERSION STUFF
	local releaseType = RELEASE
	
	
	--@alpha@
	-- The following code will only be present in alpha ZIPs.
	releaseType = ALPHA
	--@end-alpha@

	-- This will (in ZIPs), be replaced by the highest revision number in the source tree.
	releaseRevision = tonumber("162")

	-- If the releaseRevision ends up NOT being a number, it means we're running a SVN copy.
	if type(releaseRevision) ~= "number" then
		releaseRevision = -1
	end

	-- Then build the release string, which we can add to the interface option panel.
	local majorVersion = GetAddOnMetadata("EveryQuest", "Version") or "2.?"
	if releaseRevision == -1 then
		releaseString = L["You are running a source checkout of EveryQuest %s directly from the repository."]:format(majorVersion) -- Version message, %s = majorVersion
	elseif releaseType == RELEASE then
		--releaseString = L["You are running an official release of EveryQuest %s (revision %d)"]:format(majorVersion, releaseRevision) -- Version message, %s = majorVersion, %d = revision
	elseif releaseType == ALPHA then
		releaseString = L["You are running an ALPHA RELEASE of EveryQuest %s (revision %d). Please report any bugs @ http://www.wowace.com/addons/everyquest/tickets/"]:format(majorVersion, releaseRevision) -- Version message, %s = majorVersion, %d = revision
	end
	_G.EVERYQUEST_RELEASE_TYPE = releaseType
	_G.EVERYQUEST_RELEASE_REVISION = releaseRevision
	_G.EVERYQUEST_RELEASE_STRING = releaseString
	-- END:   MAGIC WOWACE VOODOO VERSION STUFF
end

local db, dbpc
local faction, zoneid, zonegroup, clickedID, recentquest, recentcompleted, recentcategory
addon.zoneid = zoneid
addon.zonegroup = zonegroup
addon.cshown, addon.cfailed, addon.cprogress, addon.ccompleted, addon.cdone, addon.cunknown, addon.cignored = 0,0,0,0,0,0,0
local oldprofile = {}
local oldprofilecount = 0
EveryQuestData = {}
local questdisplay = {}
EQ_TextColors = {}
local sfmt = string.format
EQ_TextColors["s-1"] = { r = 1.00, g = 0.00, b = 0.00, font = EQFont_Failed, hex = "ff0000" };
EQ_TextColors["s0"] = { r = 1.00, g = 1.00, b = 0, font = EQFont_Progress, hex = "ffff00" };
EQ_TextColors["s1"] = { r = 0.00, g = 1.00, b = 0.00, font = EQFont_Complete, hex = "00ff00" };
EQ_TextColors["s2"] = { r = 0.0, g = 0.807, b = 0.019, font = EQFont_TurnedIn, hex = "00cd04" };
EQ_TextColors["unknown"]	= { r = 1, g = 1, b = 1, font = EQFont_Unknown, hex = "ffffff" };
EQ_TextColors["ignored"] = { r = 0.733, g = 0.372, b = 1, font = EQFont_Ignored, hex = "BB5FFF" };

local SECOND = 1
local MINUTE = 60
local HOUR = 3600
local DAY = 86400
local currentsort = {}
addon.listsorted = false


-- Short form quest types, used in quest names (Buttons)
local qtypes = {}

local new, del
do
	local list = setmetatable({},{__mode='k'})
	function new()
		local t = next(list)
		if t then
			list[t] = nil
			return t
		else
			return {}
		end
	end
	function del(t)
		for k in pairs(t) do
			t[k] = nil
		end
		list[t] = true
		return nil
	end
end

function addon:GetReleaseString()
	return releaseString
end

function addon:Error(string)
	self:Print("|cffFF3232", string, "|r")
end
function addon:Debug(string)
	if self.db.profile.debug then  
		self:Print(string)
	end
end
function addon:Colorize(hexColor, text)
	return "|cff" .. tostring(hexColor or 'ffffff') .. tostring(text) .. "|r"
end

--[[StaticPopupDialogs["EVERYQUEST_UPGRADEDB"] = {
  text = L["EQ_UPGRADETXT"], -- Upgrade Popup Dialog text
  button1 = L["Upgrade"], -- Upgrade Popup Dialog
  button2 = L["Cancel"], -- Upgrade Popup Dialog
  OnAccept = function()
	  addon:Debug("EVERYQUEST_UPGRADEDB: OnAccept")
	  addon:UpgradeDB()
  end,
  OnCancel = function()
	dbpc.upgradeshow = true
  end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
};]]
StaticPopupDialogs["EVERYQUEST_PURGEOLD"] = {
	text = L["EQ_PURGETXT"], -- Purge data Popup Dialog
	button1 = L["Purge"], -- Purge data Popup Dialog
	button2 = L["Cancel"], -- Purge data Popup Dialog
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetText("")
	end,
	OnAccept = function()
		addon:Debug("EVERYQUEST_PURGEOLD: OnAccept")
		local text = getglobal(this:GetParent():GetName().."EditBox"):GetText()
		if text and text == "DELETE" then
			dbpc.QuestHistory = nil
			EveryQuestDBPC = nil
		else
			addon:Error(L["PURGE_ERROR"]) -- Purge data Popup Dialog
		end
	end,
	timeout = 0,
	whileDead = 1,
	hasEditBox = 1,
	hideOnEscape = 1
};
local function getfaction(side)
	if UnitFactionGroup("player") == side then return true else return false end
end

function addon:OnInitialize()
	local f = UnitFactionGroup("player")
	if f == "Alliance" then
		faction = 1
	else
		faction = 2
	end
	---------------------------------------------------------------------
	
	--- Setup Databases, Options
    self.db = LibStub("AceDB-3.0"):New("EQ2DB", {
			profile = {
				debug = false,
				localized = {
					["*"] = {},
				},
			},
		}, "global")
	db = self.db.profile
	self.dbpc = LibStub("AceDB-3.0"):New("EQ2DBPC", {
			profile = {
		        zoneid = nil,
				dbversion = 3,
				zonegroup = nil,
				history = {
					["*"] = {}
				},
				ignored = {},
				enabledfilters = {
					Faction = true,
				},
				enabledsort = {
					["*"] = true,
				},
				sort = {
					["d"] = {
						["Weight"] = 5,
						["Dir"] = 2,
					},
					["n"] = {
						["Weight"] = -10,
						["Dir"] = 1,
					},
					["l"] = {
						["Weight"] = -5,
						["Dir"] = 2,
					},
					["w"] = {
						["Weight"] = 10,
						["Dir"] = 2,
					},
					["t"] = {
						["Weight"] = 0,
						["Dir"] = 2,
					},
				},
				filters = {
					FailedAbandoned = true,
					TurnedIn = true,
					Ignored = true,
					Completed = true,
					Alliance = getfaction("Alliance"),
					Horde = getfaction("Horde"),
					SideBoth = true,
					SideNone = true,
					Unknown = true,
					InProgress = true,
					MinLevel = 1,
					MaxLevel = 80,
					NormalQuest = true,
					GroupQuest = true,
					DailyQuest = true,
					WeeklyQuest = true,
					HeroicQuest = true,
					DungeonQuest = true,
					RaidQuest = true,
					PvpQuest = true,
				},
		    },
		}, "global")
	dbpc = self.dbpc.profile
	
	self:SetupOptions()
	--self:UpgradeCheck()
	
	if dbpc.dbversion < 3 then
		self:SilentUpgrade()
	end
	--EQ_zones = self:GetZoneMenu()
	self:SetupFrames()
	qtypes[1] = L["G"] -- Short for 'Group'
	qtypes[62] = L["R"] -- Short for 'Raid'
	qtypes[85] = L["H"] -- Short for 'Heroic'
	qtypes[81] = L["D"] -- Short for 'Dungeon'
	qtypes[41] = L["P"] -- Short for 'PvP'
	qtypes[84] = L["E"] -- Short for 'Escort'
	qtypes[82] = L["WE"] -- Short for 'World Event'
	addon:UpdateSortList()
	
	EveryQuest:SecureHook(GameTooltip, "SetHyperlink", "SetHyperlink")
end

function addon:ModGetDB()
	return db, dbpc
end

local continentmap = {
	[1] = "Kalimdor",
	[2] = "Eastern Kingdoms",
	[3] = "Outland",
	[4] = "Northrend",
}

function addon:GetZoneId(category, continent)
	for k,v in pairs(EQ_zones) do -- for each top level category
		if v[1] == category then
			return nil, v[1]
		else
			if continent ~= nil then
				if v[1] == continentmap[continent] then
					for ak,av in pairs(v[2]) do -- for each category
						if av[2] == category then
							return av[1], v[1]
						end
					end
				end
			else
				for ak,av in pairs(v[2]) do -- for each category
					if type(av[2]) == "table" then
						for bk,bv in pairs(av[2]) do
							if bv[2] == category then
								return bv[1], v[1]
							end
						end
					else
						if av[2] == category then
							return av[1], v[1]
						end
					end
				end
			end
		end
	end
end

function addon:GetCategory(zid)
	for k,zoneg in pairs(EQ_zones) do -- for each top level category
		for ak,category in pairs(zoneg[2]) do -- for each category -- category[1] = Zone ID, [2] = Zone Name
			-- if the second item in the table is a table, then it must be a sub menu (Dungeons)
			if type(category[2]) == "table" then
				for bk,dungeon in pairs(category[2]) do -- dungeon[1] = Zone ID, [2] = Zone Name
					if dungeon[1] == zid then
						return zoneg[1], dungeon[2]
					end
				end
			else
				if category[1] == zid then
					return zoneg[1], category[2]
				end
			end
		end
	end
end

-- menu create function
do
	local info = {}
	local EveryQuest_ZoneMenu = CreateFrame("Frame", "EveryQuest_ZoneMenu")
	EveryQuest_ZoneMenu.displayMode = "MENU"
	EveryQuest_ZoneMenu.point = "TOPRIGHT"
	--/run DropDownList1:SetPoint("TOPRIGHT", "EQ_MenuButton", "BOTTOMRIGHT",0,0)
	EveryQuest_ZoneMenu.relativeTo = "EQ_MenuButton"
	EveryQuest_ZoneMenu.relativePoint = "BOTTOMRIGHT"
	EveryQuest_ZoneMenu.initialize = function(self, level)
		if not level then return end
		--sort(EQ_zones, function(a, b) addon:Debug(a .. " - " .. b) return true end)
		wipe(info)
		if (level == 1) then
			for key,value in pairs(EQ_zones) do
				info.hasArrow = true; -- creates submenu
				info.notCheckable = true;
				info.text = value[3];
				info.value = key;
				UIDropDownMenu_AddButton(info, level);
			end -- for key, subarray
			-- Close menu item
			info.text         = CLOSE
			info.func         = function() CloseDropDownMenus() end
			info.checked      = nil
			info.arg1         = nil
			info.notCheckable = 1
			info.hasArrow = nil
			UIDropDownMenu_AddButton(info, level)
		end -- if level 1
		if level == 2 then
			--addon:Debug("level 2")
			curzone = EQ_zones[UIDROPDOWNMENU_MENU_VALUE]
			--sort(curzone, function(a, b) addon:Debug(a .. " - " .. b) return true end)
			info.isTitle      = 1
			info.text         = curzone[3]
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)
			info.disabled     = false
			info.isTitle      = nil
			info.notCheckable = nil
			for key, value in pairs(curzone[2]) do
				if curzone[1] ~= "Dungeons" then
					info.hasArrow = nil; -- creates submenu
					info.text = value[2];
					info.value = value[1];
					info.checked = function() if zoneid == value[1] then return true end end
					info.func = function()
						zoneid = value[1]
						zonegroup = curzone[1]
						CloseDropDownMenus()
						addon.listsorted = false
						addon:UpdateFrame()
					end
				else
					info.hasArrow = true
					info.text = value[3]
					info.value = key
					info.checked = nil
					info.func = nil
				end
				UIDropDownMenu_AddButton(info, level);
			end -- for key, subarray
			-- Close menu item
			info.text         = CLOSE
			info.func         = function() CloseDropDownMenus() end
			info.hasArrow = nil
			info.checked      = nil
			info.arg1         = nil
			info.tooltipTitle = nil
			info.tooltipText = nil
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)
		end
		if level == 3 then
			local dungeonid
			for k,v in pairs(EQ_zones) do if v[1] == "Dungeons" then dungeonid = k end end
			curzone = EQ_zones[dungeonid][2][UIDROPDOWNMENU_MENU_VALUE]
			--addon:Debug("level 3 - did:" .. dungeonid .. " value:" .. tostring(UIDROPDOWNMENU_MENU_VALUE) .. " 1:" .. curzone[1])
			info.isTitle      = 1
			info.text         = curzone[3]
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)
			info.disabled     = false
			info.isTitle      = nil
			info.notCheckable = nil
			for key, value in pairs(curzone[2]) do
				info.hasArrow = nil; -- creates submenu
				info.text = value[2];
				info.value = value[1];
				info.tooltipTitle = key -- Title of the tooltip shown on mouseover
				info.tooltipText = "tooltiptext" -- Text of the tooltip shown on mouseover, return the current amount of completed quests out of the total available to that faction
				info.func = function()
					zoneid = value[1]
					zonegroup = EQ_zones[dungeonid][1]
					CloseDropDownMenus()
					addon.listsorted = false
					addon:UpdateFrame()
				end
				info.checked = function() if zoneid == value[1] then return true end end  --  Check the button if true or function returns true
				UIDropDownMenu_AddButton(info, level);
			end -- for key, subarray
			-- Close menu item
			info.text         = CLOSE
			info.func         = function() CloseDropDownMenus() end
			info.hasArrow = nil
			info.checked      = nil
			info.arg1         = nil
			info.tooltipTitle = nil
			info.tooltipText = nil
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)
		end
	end
end

do
	local info = {}
	local statues = {
		{name = L["Turned In"],	status = 2}, -- Quest Right click menu, status change
		{name = L["Completed"], status = 1}, -- Quest Right click menu, status change
		{name = L["In Progress"], status = 0}, -- Quest Right click menu, status change
		{name = L["Abandoned"], status = -1,}, -- Quest Right click menu, status change
		{name = L["Failed"], status = -1}, -- Quest Right click menu, status change
	}
	local EveryQuest_QuestMenu = CreateFrame("Frame", "EveryQuest_QuestMenu")
	EveryQuest_QuestMenu.displayMode = "MENU"
	EveryQuest_QuestMenu.initialize = function(self, level)
		if not level then return end
		for k in pairs(info) do info[k] = nil end
		if (level == 1) then
			for key, value in pairs(statues) do
				info.checked = function() return addon:GetStatus(clickedID, value.status) end
				info.func = function() addon:UpdateStatus(clickedID, value.status) end
				info.text = value.name;
				UIDropDownMenu_AddButton(info, level);
			end -- for key, subarray
			info.checked = function() return addon:GetStatus(clickedID, "ignored", true) end
			info.func = function() addon:UpdateStatus(clickedID, "ignored", true) end
			info.text = L["Ignore"]; -- Quest Right click menu, status change
			UIDropDownMenu_AddButton(info, level);
			info.checked = function() return addon:GetStatus(clickedID, "forget", true) end
			info.func = function() addon:UpdateStatus(clickedID, "forget", true) end
			info.text = L["Forget"]; -- Quest Right click menu, status change
			UIDropDownMenu_AddButton(info, level);
			-- Close menu item
			info.text         = CLOSE
			info.func         = function() CloseDropDownMenus() end
			info.checked      = nil
			info.arg1         = nil
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)
		end -- if level 1
	end
end

do
	-- To fix Blizzard's bug caused by the new "self:SetFrameLevel(2);"
	local function FixFrameLevel(level, ...)
		for i = 1, select("#", ...) do
			local button = select(i, ...)
			button:SetFrameLevel(level)
		end
	end
	function addon.FixMenuFrameLevels()
		local f = DropDownList1
		local i = 1
		while f do
			FixFrameLevel(f:GetFrameLevel() + 2, f:GetChildren())
			i = i + 1
			f = _G["DropDownList"..i]
		end
	end

	-- To fix Blizzard's bug caused by the new "self:SetFrameLevel(2);"
	hooksecurefunc("UIDropDownMenu_CreateFrames", addon.FixMenuFrameLevels)
end

function addon:OnEnable()
	addon:EventsEnable()
	self:ZONE_CHANGED_NEW_AREA()
end

function addon:OnDisable()
	Quixote:UnregisterAll()
	addon:UnhookAll()
end

function addon:Toggle()
	if EveryQuestFrame:IsShown() then
		EveryQuestFrame:Hide()
	else
		EveryQuestFrame:Show()	
		self:UpdateFrame()
	end
end
function addon:OnShow()
	if dbpc.posx and dbpc.posy then
		EveryQuestFrame:ClearAllPoints()
		EveryQuestFrame:SetPoint("TOPLEFT","UIParent", "BOTTOMLEFT", dbpc.posx, dbpc.posy)
	end
end
function addon:SavePosition()
	local Left = EveryQuestFrame:GetLeft()
	local Top = EveryQuestFrame:GetTop()
	if Left and Top then
		dbpc.posx = Left
		dbpc.posy = Top
	end
end

--[[function addon:UpgradeCheck()
	---------------------------------------------------------------------
	--- Handle Migration
	---	EveryQuestDBPC = dbversion 1
	---	EQ2DBPC.QuestHistory = dbversion 2
	--- EQ2DBPC.history = dbversion 3
	if EveryQuestDBPC ~= nil then
		for profilename,profile in pairs(EveryQuestDBPC) do 
			self:Debug(tostring(profilename) .. " - " .. tostring(profile))
			if profile.history ~= nil --[and not dbpc.copied] then
				self:Debug("history is not nil, single upgrade copy")
				if dbpc.history == nil then
					dbpc.history = {}
				end
				if dbpc.history == nil then
					dbpc.history = profile.history
					dbpc.copied = true
					profile.history = nil
				end
			end
			if profile.QuestHistory ~= nil and not profile.upgraded then
				tinsert(oldprofile,profile)
				oldprofilecount = oldprofilecount + 1
				self:Debug("oldprofilecount "..tostring(oldprofilecount))
				--StaticPopupDialogs["EVERYQUEST_UPGRADEDB"].text = string.format(L["EQ_UPGRADETXT"], oldprofilecount)
				--StaticPopup_Show ("EVERYQUEST_UPGRADEDB")
				self:Debug("QuestHistory is not nil, double upgrade")
			end
		end
	end
	
	if dbpc.QuestHistory ~= nil and dbpc.upgradeshow ~= true and not dbpc.upgraded then
		tinsert(oldprofile,dbpc)
		oldprofilecount = oldprofilecount + 1
		--StaticPopupDialogs["EVERYQUEST_UPGRADEDB"].text = string.format(L["EQ_UPGRADETXT"], oldprofilecount)
		--StaticPopup_Show ("EVERYQUEST_UPGRADEDB")
	end
	
	if oldprofilecount > 0 then
		StaticPopupDialogs["EVERYQUEST_UPGRADEDB"].text = string.format(L["EQ_UPGRADETXT"], oldprofilecount)
		StaticPopup_Show ("EVERYQUEST_UPGRADEDB")
	end
end
function addon:UpgradeDB()
	local toupgrade
	for k,p in pairs(oldprofile) do
		if p and p.QuestHistory ~= nil then
			local category, questname, quest, zone, uid
			for category,v in pairs(p.QuestHistory) do
				--self:Debug(category)
				for questname, oldquest in pairs(v) do
					if questname ~= "Collapsed" then
						uid, quest, zone = self:GetQuestData(nil, category, questname)
						if quest then
							self:Debug("|cffffff00UpgradeDB|r: qid:" .. tostring(uid) .. ", zoneid:"..tostring(zone))
							if dbpc.history == nil then
								dbpc.history = {}
							end
							if dbpc.history[zone] == nil then
								dbpc.history[zone] = {}
							end
							if dbpc.history[zone][uid] == nil then
								dbpc.history[zone][uid] = {}
							end
							--dbpc.history[zone][uid].id = quest.id
							if dbpc.history[zone][uid].status == nil then
								if oldquest.status ~= nil then
									dbpc.history[zone][uid].status = oldquest.status
								else
									dbpc.history[zone][uid].status = 2
								end
							end
							if oldquest.completed ~= nil and dbpc.history[zone][uid].completed == nil then
								dbpc.history[zone][uid].completed = oldquest.completed
							end
							if oldquest.abandoned ~= nil and dbpc.history[zone][uid].abandoned == nil then
								dbpc.history[zone][uid].abandoned = oldquest.abandoned
							end
						else
							self:Debug("|cffffff00UpgradeDB|r: Failed to get QID for: '" .. tostring(questname) .. "' in " .. tostring(category))
						end
					end
				end
			end
			p.upgraded = true
		end
	end
	dbpc.dbversion = 2
	LibStub("AceConfigRegistry-3.0"):NotifyChange("EveryQuest")
end]]

function addon:SilentUpgrade()
	for zoneid,zone in pairs(dbpc.history) do
		for uid, quest in pairs(zone) do
			dbpc.history[zoneid][uid].id = nil
		end
	end
	dbpc.dbversion = 3
end

function addon:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.Filters)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.EveryQuest)
end

function addon:AddQuest(questid, category, completed, zoneid)
	if dbpc.history == nil then
		dbpc.history = {} 
	end
	if questid then
		local uid, quest, zone = self:GetQuestData(questid, category, nil, zoneid)
		self:Debug("AddQuest - questid:"..tostring(questid) .. " zone:"..tostring(zone))
		if quest == false then
			return false
		end
		if zone ~= nil then
			if dbpc.history[zone] == nil then
				dbpc.history[zone] = {}
			end
			if quest ~= nil then
				if dbpc.history[zone][questid] == nil then
					dbpc.history[zone][questid] = {}
					--dbpc.history[zone][questid].id = questid
					if completed then
						dbpc.history[zone][questid].status = 1
					else
						dbpc.history[zone][questid].status = 0
					end
				end
				self:UpdateFrame()
				-- if quest.w ~= nil then
					return zone, quest.d, quest.w
				-- else
					-- return zone, quest.d
				-- end
			else
				return false
			end
		else
			self:UpdateFrame()
			return false
		end
	end
end

function addon:AddUnknown(uid, category, title)
	if uid and uid ~= nil then
		if db.unknowns == nil then
			db.unknowns = {}
		end
		if db.unknowns[uid] == nil then
			db.unknowns[uid] = EVERYQUEST_RELEASE_REVISION .. "||" .. date("%x") .. "||" .. tostring(title) .. "||" .. tostring(category)
		end
	end
end

function addon:Filterer(uid, quest)
	local filters = dbpc.filters
	local enabledfilters = dbpc.enabledfilters
	local side = false
	local status = false
	local level = false
	local qtype = false
	local daily = true
	local weekly = true
	local ignored = true
	local level = false
	if enabledfilters.Faction then
		if quest.s == 1 and filters.Alliance then side = true end
		if quest.s == 2 and filters.Horde then side = true end
		if quest.s == 3 and filters.SideBoth then side = true end
		if (quest.s == 0 or quest.s == nil) and filters.SideNone then side = true end
	else
		side = true
	end
	
	if enabledfilters.Status then
		if dbpc.ignored[uid] ~= nil and not filters.Ignored then
			ignored = false
		end
	else
		ignored = true
	end
	
	if enabledfilters.Type then
		if quest.t == 1 and filters.GroupQuest then
			qtype = true
		elseif quest.t == 62 and filters.RaidQuest then
			qtype = true
		elseif quest.t == 85 and filters.HeroicQuest then
			qtype = true
		elseif quest.t == 81 and filters.DungeonQuest then
			qtype = true
		elseif quest.t == 41 and filters.PvpQuest then
			qtype = true
		elseif quest.t == nil and filters.NormalQuest then
			qtype = true
		end
		
		if quest.w and not filters.WeeklyQuest then
			weekly = false
		else
			if quest.w and not filters.NormalQuest then
				qtype = true
			end
		end
		
		if quest.d and not filters.DailyQuest then
			daily = false
		else
			if quest.d and not filters.NormalQuest then
				qtype = true
			end
		end
	else
		qtype = true
		daily = true
		weekly = true
	end
	
	if enabledfilters.Status then
		local qstatus = nil
		if dbpc.history[zoneid] and dbpc.history[zoneid][uid] then
			qstatus = dbpc.history[zoneid][uid].status
		end
		if qstatus == -1 and filters.FailedAbandoned then
			status = true
		elseif qstatus == 0 and filters.InProgress then
			status = true
		elseif qstatus == 1 and filters.Completed then
			status = true
		elseif qstatus == 2 and filters.TurnedIn then
			status = true
		elseif qstatus == nil and filters.Unknown then
			status = true
		elseif dbpc.ignored[uid] ~= nil and not filters.Ignored then
			status = true
		end
	else
		status = true
	end
	
	if enabledfilters.Level then
		local qlevel
		if quest.l == nil and quest.r == nil then
			qlevel = 0
		elseif quest.l == nil then
			qlevel = quest.r
		else
			qlevel = quest.l
		end
		if qlevel >= filters.MinLevel and qlevel <= filters.MaxLevel then
			level = true
		end
	else
		level = true
	end
	
	if side and status and ignored and qtype and daily and weekly and level then
		return true
	else 
		return false
	end
	--return shown
end

function addon:UpdateFrame(zid, zgid)
	local zonename
	if zid ~= nil then
		zoneid = zid
	end
	if zgid ~= nil then
		zonegroup = zgid
	end
	addon.cfailed, addon.cprogress, addon.ccompleted, addon.cdone, addon.cunknown, addon.cignored, addon.chidden = 0,0,0,0,0,0,0
	dbpc.zoneid = zoneid
	dbpc.zonegroup = zonegroup
	_, zonename = self:GetCategory(zoneid)
	UIDropDownMenu_SetText(EQDropdown, zonename)
	if EveryQuestFrame:IsShown() then
		--[[if db.locallist then
			self:Debug("Localized quest list is on")
		end]]
		local buttonid = 1
		local controli = 0
		questlist = self:GetZoneQuestData(zonegroup, zoneid)
		-- Spew("questlist", questlist)
		local questcount = 0
		if questlist then
			for k, quest in pairs (questlist) do
				-- if quest.s then
					--if quest.s == faction or quest.s == 3 then
					if addon:Filterer(quest.id, quest) then
						--[[if db.view == "history" then
							if dbpc.history[zoneid] ~= nil and dbpc.history[zoneid][uid] ~= nil then
								questcount = questcount +1
							end
						else]]
						if dbpc.history[zoneid] ~= nil and dbpc.history[zoneid][quest.id] ~= nil then
							--if db.detailnumbers then
								if dbpc.history[zoneid][quest.id].status == -1 then
									addon.cfailed = addon.cfailed + 1
								elseif dbpc.history[zoneid][quest.id].status == 0 then
									addon.cprogress = addon.cprogress + 1
								elseif dbpc.history[zoneid][quest.id].status == 1 then
									addon.ccompleted = addon.ccompleted + 1
								elseif dbpc.history[zoneid][quest.id].status == 2 then
									addon.cdone = addon.cdone + 1
								end
							--end
						else
							addon.cunknown = addon.cunknown +1
						end
						questcount = questcount +1
						--end
						if dbpc.ignored[quest.id] then
							addon.cignored = addon.cignored +1
						end
					else
						addon.chidden = addon.chidden +1
					end
				-- end
			end
		end
		cshown = questcount
		
		if questcount > 0 and not addon.listsorted then
			--self:Print("Sort the list")
			sort(questlist, function(a,b) return self:SortTable(a,b) end)
			addon.listsorted = true
		end
		FauxScrollFrame_Update(EveryQuestListScrollFrame,questcount,27,16)
		local scrolloffset = FauxScrollFrame_GetOffset(EveryQuestListScrollFrame)
		local quest
		if questcount then
			if questlist then
				for k, quest in pairs (questlist) do
					-- if quest["s"] then
						if addon:Filterer(quest.id, quest) then
							controli = controli + 1
							if controli > scrolloffset then
								if buttonid > 27 then 
									break 
								end
								if dbpc.history[zoneid] ~= nil and dbpc.history[zoneid][quest.id] ~= nil then
									quest.completed = dbpc.history[zoneid][quest.id].completed
									quest.abandoned = dbpc.history[zoneid][quest.id].abandoned
									quest.status = dbpc.history[zoneid][quest.id].status
								end
								
								self:UpdateButton(buttonid, quest, quest.id)
								buttonid = buttonid +1		
							end
						end
					-- end
				end
			end
		end
		for j = buttonid, 27 ,1 do
			button = getglobal("EveryQuestTitle"..j)
			button:Hide()
		end
		addon.frames.Shown:SetText( sfmt(L["%d Shown"], questcount) )  -- Main frame list count
	end
end
--- Get Quest History data for the specified Quest ID
-- @name EveryQuest:GetHistory
-- @param uid Integer > 1: Unique Quest ID
-- @param zoneid Integer: Numerical quest category
-- @return Table or nil Quest History, returns nil on unknown quest
-- @usage questhistory = EveryQuest:GetHistory(uid [, zoneid])
function addon:GetHistory(uid, zoneid)
	if zoneid ~= nil then
		for huid, quest in pairs(dbpc.history[zoneid]) do
			if uid == huid then
				return quest
			end
		end
	else
		for zid, zone in pairs(dbpc.history) do
			for huid, quest in pairs(zone) do
				if uid == huid then
					return quest
				end
			end
		end
	end
	return nil
end
--- Get Quest status for the specified Quest ID
-- @name EveryQuest:GetHistoryStatus
-- @param uid Integer > 1: Unique Quest ID
-- @param zoneid Integer: Numerical quest category
-- @return Integer or nil Numerical Quest Status
-- -1: Failed or Abandoned
-- 0: In Progress
-- 1: Completed but still in the Quest Log
-- 2: Completed and turned in
-- nil: Unknown quest
-- @usage questhistory = EveryQuest:GetHistoryStatus(uid [, zoneid])
function addon:GetHistoryStatus(uid, zoneid)
	if zoneid ~= nil then
		for huid, quest in pairs(dbpc.history[zoneid]) do
			if uid == huid then
				return quest.status, quest.count
			end
		end
	else
		for zid, zone in pairs(dbpc.history) do
			for huid, quest in pairs(zone) do
				if uid == huid then
					return quest.status, quest.count
				end
			end
		end
	end
	return nil
end

--- Get Quest Data from a LOD module and return the table and the Category
-- @name EveryQuest:GetQuestData
-- @param uid Integer > 1: Unique Quest ID
-- @param category String: Numerical quest category
-- @param questname String: English Quest Name
-- @param zoneid Integer: Numerical quest category
-- @return uid
-- @return quest data
-- @return zoneid
-- @usage 
-- uid, quest, zoneid = EveryQuest:GetQuestData(uid, nil, nil, zoneid)
-- uid, quest, zoneid = EveryQuest:GetQuestData(uid)
-- uid, quest, zoneid = EveryQuest:GetQuestData(nil, category, questname)
-- uid, quest, zoneid = EveryQuest:GetQuestData(uid, category, nil, zoneid)
function addon:GetQuestData(questid, category, questname, zid)
	self:Debug("GetQuestData - questid:"..tostring(questid).." category:"..tostring(category))
	local zg
	if zid == nil then
		zid = self:GetZoneId(category)
	end
	if zg == nil and zid ~= nil then
		zg = self:GetCategory(zid)
	end
	self:Debug("GetQuestData - zonegroup:"..tostring(zg).." zoneid:"..tostring(zid))
	if zg ~= nil and zid ~= nil then
		self:Debug("1GetQuestData - zonegroup:"..tostring(zg).." zoneid:"..tostring(zid))
		quests = self:GetZoneQuestData(zg, zid)
		if quests == false or quests == nil then
			self:Debug("GetQuestData(): No quests, returning false")
			return false
		end
		for uid,quest in pairs(quests) do
			--for kt,vt in pairs(quest) do self:Print(kt .. " - " .. vt) end
			if quest.id == questid then
				self:Debug("GetQuestData - from data - questid:"..tostring(questid).." zonegroup:"..tostring(zg).." zoneid:"..tostring(zid))
				return uid, quest, zid
			end
			if quest.n == questname then
				self:Debug("GetQuestData - from data - questid:"..tostring(questid).." zonegroup:"..tostring(zg).." zoneid:"..tostring(zid))
				return uid, quest, zid
			end
		end
	end
	self:Debug("GetQuestData(): Try an expanded search")
	-- try an expanded search
	if zg ~= nil then
		local moduledata = self:LoadQuestData(zg)
		if moduledata == false then
			return false
		end
		for k,part in pairs(moduledata) do
			for uid,quest in pairs(part) do
				--for kt,vt in pairs(quest) do self:Print(kt .. " - " .. vt) end
				if quest.id == questid then
					zid = k
					self:Debug(k)
					self:Debug("GetQuestData (Expanded) - from data - questid:"..tostring(questid).." zonegroup:"..tostring(zg).." zoneid:"..tostring(zid))
					return uid, quest, zid
				end
				if quest.n == questname then
					zid = k
					self:Debug("GetQuestData (Expanded) - from data - questid:"..tostring(questid).." zonegroup:"..tostring(zg).." zoneid:"..tostring(zid))
					return uid, quest, zid
				end
			end
		end
	end
	self:Debug("Expanded Search")
	local groups = {"Miscellaneous", "Dungeons", "Raids", "Classes", "Professions", "Battlegrounds", "World Events", "Northrend", "Outland", "Eastern Kingdoms", "Kalimdor"}
	local moduledata
	for _,group in pairs(groups) do
		moduledata = self:LoadQuestData(group)
		if moduledata ~= false then
			for k,part in pairs(moduledata) do
				for kt,quest in pairs(part) do
					--for kt,vt in pairs(quest) do self:Print(kt .. " - " .. vt) end
					if quest.id == questid then
						zid = k
						self:Debug("GetQuestData (Expanded 2x) - from data - questid:"..tostring(questid).." zonegroup:"..tostring(v).." zoneid:"..tostring(zid))
						return quest.id, quest, zid
					end
					if quest.n == questname then
						zid = k
						self:Debug("GetQuestData (Expanded 2x) - from data - questid:"..tostring(questid).." zonegroup:"..tostring(zg).." zoneid:"..tostring(zid))
						return quest.id, quest, zid
					end
				end
			end
		end
	end
		
	return false
end
local que = {}
local doneList = {}
local tt = CreateFrame("GameTooltip", "EveryQuestScanningTooltip", UIParent, "GameTooltipTemplate")
local ttlt = EveryQuestScanningTooltipTextLeft1
local ttScanFrame = CreateFrame("frame")
ttScanFrame:Hide()
do
    tt:SetScript("OnTooltipSetQuest", function(self, ...)
		local uid = que[1]
		--print(uid)
		if (not uid) then
			--print("hide ttscanframe")
            ttScanFrame:Hide()
        end
        local questName = ttlt:GetText()
		db.localized[locale][uid] = questName
		addon:UpdateButtonTextByUID(uid)
	   table.remove(que, 1)
        local uid = que[1]
        if not uid then
            ttScanFrame:Hide()
            return
        end
        self.questId = uid
    end)

    local interval, delay = 1, 0
    ttScanFrame:SetScript("OnUpdate", function(self, elapsed)
        delay = delay + elapsed
        if delay > interval then
            tt:SetHyperlink("quest:"..tt.questId)
            delay = 0
        end
    end)
end
function addon:StartTTScan()
    local uid = que[1]
    tt.questId = uid
    ttScanFrame:Show()
    return tt:SetHyperlink( ("quest:%d"):format(uid) )
end
function addon:StopTTScan()
    ttScanFrame:Hide()
end

function addon:GetLocalizedQuestName(uid)
	if db.localized[locale][uid] then
		self:Debug(string.format("Found %s (%d) in the DB", tostring(db.localized[locale][uid]), uid))
		return db.localized[locale][uid]
	else
		local name = nil
		local inQue = false
		for _,v in pairs(que) do
			if v == uid then
				inQue = true
				break
			end
		end
		if not inQue then
			table.insert(que, uid)
		end
		if not ttScanFrame:IsShown() then
			self:StartTTScan()
		end
		return nil
	end
end

local function mergequest(quest1, quest2)
	local quest1, quest2 = quest1, quest2
	if quest2 then
		for k,v in ipairs(quest2) do table.insert(quest1, v) end return quest1
	end
	return quest1
end

function addon:UpdateButtonTextByUID(uid)
	for k,v in pairs(questdisplay) do
		if v.id == uid then
			
			local button = getglobal("EveryQuestTitle"..k)
			local text = "["
			if questdisplay[k].l then
				text = text .. questdisplay[k].l
			else 
				if questdisplay[k].r then
					text = text .. sfmt(L["r%d"], questdisplay[k].r) -- Short for 'required level'
				else
					text = text .. "--"
				end
			end
			if questdisplay[k].t then
				text = text .. qtypes[questdisplay[k].t]
			end
			if questdisplay[k].d then
				text = text .. L["Y"] -- Short for 'Daily', ie Daily Quest
			end
			if questdisplay[k].w then
				text = text .. L["W"] -- Short for 'Weekly', ie Weekly Quest
			end
			
			text = text .. "] " .. db.localized[locale][uid]
			
			if Loremaster and Loremaster:GetBoolFromID(uid) then
				text = text .. L[" [L]"]
			end
			--print("found matching button: "..text)
			button:SetText(text)
			break
		end
	end
end

function addon:UpdateButton(buttonid, quest, uid)
	--if db.view == "history" or db.view == "zone" then
		local button = getglobal("EveryQuestTitle"..buttonid)
		local qTag = ""
		local strLM = ""
		button:SetNormalTexture("")
		button:SetText("")
		if not questdisplay[buttonid] or questdisplay[buttonid].id ~= uid then
			--[[if dbpc.history[zoneid] and dbpc.history[zoneid][uid] then
				questdisplay[buttonid] = mergequest(quest, dbpc.history[zoneid][uid])
				questdisplay[buttonid].id = uid
			else]]
				questdisplay[buttonid] = nil
				questdisplay[buttonid] = mergequest(quest, dbpc.history[zoneid][uid])
				questdisplay[buttonid].id = uid
			--end
		--[[elseif  then
			
			if dbpc.history[zoneid] and dbpc.history[zoneid][uid] then
				questdisplay[buttonid] = dbpc.history[zoneid][uid]
				questdisplay[buttonid].id = uid
			else
				questdisplay[buttonid] = mergequest(quest, dbpc.history[zoneid][uid])
				questdisplay[buttonid].id = uid
			--end]]
		end
		
		--questdisplay[buttonid].arrayid = arrayid
		if quest.t then
			qTag = qtypes[quest.t]
		end
		if quest.d then
			qTag = qTag .. L["Y"] -- Short for 'Daily', ie Daily Quest
		end
		if quest.w then
			qTag = qTag .. L["W"] -- Short for 'Weekly', ie Weekly Quest
		end
		local level
		if quest.l then
			level = quest.l
		else 
			if quest.r then
				level = sfmt(L["r%d"], quest.r) -- Short for 'required level'
			else
				level = "--"
			end
		end
		if Loremaster and Loremaster:GetBoolFromID(uid) then
			strLM = L[" [L]"]
		end
		--print("set text")
		if db.locallist then
			--self:Debug("Localized quest list is on")
			local name = addon:GetLocalizedQuestName(uid)
			if name then
				button:SetText(string.format("[%s%s] %s%s", level, qTag, name, strLM))
			else
				button:SetText(string.format("[%s%s] %s%s", level, qTag, quest.n, strLM))
			end
		else
			button:SetText(string.format("[%s%s] %s%s", level, qTag, quest.n, strLM))
		end
		
		if dbpc.history[zoneid] and dbpc.history[zoneid][uid] then
			local qhistory = dbpc.history[zoneid][uid]
			if qhistory.status ~= nil then
				--self:Debug(history["status"] .. " - " .. history["id"])
				button:SetNormalFontObject(EQ_TextColors["s"..qhistory["status"]].font)
			else
				button:SetNormalFontObject(EQ_TextColors["unknown"].font)
			end
		else
			button:SetNormalFontObject(EQ_TextColors["unknown"].font)
		end
		if dbpc.ignored[uid] then
			button:SetNormalFontObject(EQ_TextColors["ignored"].font)
		end
		button:Show()
	--end
end

function addon:SetHyperlink(self, value)
	-- Spew("sethyperlink", value)
	-- print(string.match(value, "^quest:(%d+)"))
	if string.find(value, "^quest:") then
		local quest = addon:GetHistory(tonumber(string.match(value, "^quest:(%d+)")))
		-- Spew("quest", quest)
		local queststatus = L["Unknown"] -- Quest Status
		local status = 99
		if quest ~= nil then
			if quest.status == -1 then
				queststatus = L["Failed or Abandoned"] -- Quest Status
			elseif quest.status == 0 then
				queststatus = L["In Progress"] -- Quest Status
			elseif quest.status == 1 then
				queststatus = L["Completed"] -- Quest Status
			elseif quest.status == 2 then
				queststatus = L["Turned In"] -- Quest Status
			end
		end
		GameTooltip:AddLine(" ", addon:GetColor("FFFFFF"))
		GameTooltip:AddLine( L["Status: %s"]:format(queststatus), addon:GetColor((quest and quest.status or status))) -- Tooltip quest status, %s = localized quest status
		if quest ~= nil then
			if quest.completed then
				completedline = L["Completed%s: %s"] -- Tooltip, %s = daily/weekly quest complete count, %s = timediff string
				local repeatcount = ""
				if quest.count then
					repeatcount = L[" (%d Times)"]:format(quest.count) -- Tooltip, %d = number of times completed
				end
				completedline = (completedline):format(repeatcount, addon:timeDiff(quest.completed))
			end
			if tostring(quest.completed, true) > tostring(quest.failed, true) and tostring(quest.completed, true) > tostring(quest.abandoned, true) then
				GameTooltip:AddLine(completedline,addon:GetColor("FFFFFF"))
			else
				if quest.completed then
					GameTooltip:AddLine(completedline,addon:GetColor("FFFFFF"))
				end
				if quest.failed then
					GameTooltip:AddLine( L["Failed: %s"]:format(addon:timeDiff(quest.failed)), addon:GetColor("FFFFFF")) -- Tooltip, %s = timediff string
				end
				if quest.abandoned then
					GameTooltip:AddLine( L["Abandoned: %s"]:format(addon:timeDiff(quest.abandoned)), addon:GetColor("FFFFFF")) -- Tooltip, %s = timediff string
				end
			end
			if quest.imported then
				local importedfrom
				if quest.imported == 1 then
					importedfrom = L["QuestGuru"] -- Tooltip, import line
				elseif quest.imported == 2 then
					importedfrom = L["QuestHistory"] -- Tooltip, import line
				elseif quest.imported == 3 then
					importedfrom = L["Server Query"] -- Tooltip, import line
				else
					importedfrom = L["Other"] -- Tooltip, import line
				end
				GameTooltip:AddLine( L["Imported From: %s"]:format(importedfrom), addon:GetColor("FFFFFF")) -- Tooltip, %s = localized origin name
			end
		end
	end
end

function addon:ButtonEnter(self)
	local index = self:GetID()
	local isCollected = false
	local quest = questdisplay[index]
	local zoneid = zoneid
	local uid = quest.id
	GameTooltip_SetDefaultAnchor(GameTooltip, self)
	GameTooltip:SetHyperlink("quest:"..uid)
	GameTooltip:Show()
end

function addon:ButtonClick(self, button)
	clickedID = self:GetID()
	local questname, questlevel
	local quest = questdisplay[clickedID]
	local uid = quest.id
	if button == "LeftButton" then
		if ( IsModifiedClick() ) then
			if ( IsModifiedClick("CHATLINK") and ChatFrameEditBox:IsVisible() ) then
				local _, questinfo = self:GetQuestData(uid, nil, nil, zoneid)
				questname = quest.n or questinfo.n or L["Unknown"] -- Quest Status
				questlevel = quest.l or questinfo.l or -1
				local questLink = self:CreateQuestLink(uid, questname, questlevel);
				if ( questLink ) then
					ChatEdit_InsertLink(questLink);
				end
			end
		else
			-- open lightheaded if enabled
			if IsAddOnLoaded("Lightheaded") then
				if IsAddOnLoaded("beql") then
					beql:MinimizeQuestLog()
				end
				
				QuestLogFrame:Show()
				LightHeaded:UpdateFrame(uid, 1)
				QuestLogFrame:ClearAllPoints()
				QuestLogFrame:SetPoint("TOPLEFT",EveryQuestFrame, "TOPLEFT", 360, 0)
			end
			if quest.status == 0 or quest.status == 1 then
				Quixote:ShowQuestLog(uid)
				QuestLogFrame:ClearAllPoints()
				QuestLogFrame:SetPoint("TOPLEFT",EveryQuestFrame, "TOPLEFT", 360, 0)
			end
		end
	elseif button == "RightButton" then
		-- open quest menu
		ToggleDropDownMenu(1, nil, EveryQuest_QuestMenu, self:GetName(), 0, 0)
	end
end

function addon:GetStatus(displayid, status, ignored)
	--self:Debug("GetStatus - did:"..tostring(displayid)..", status:"..tostring(queststatus))
	if ignored and status == "ignored" then
		if dbpc.ignored[questdisplay[displayid].id] then
			return true
		else
			return false
		end
	else
		if questdisplay[displayid].status and questdisplay[displayid].status == status then
			return true
		else
			return false
		end
	end
end

function addon:UpdateStatus(displayid, queststatus, ignored, questid)
	--questdisplay[displayid]
	local uid = questdisplay[displayid].id
	--if (questid ~= nil and displayid == nil) then
	--	uid = questid
	--else
		 
		--uid = quest.id
	--end
	if ignored and queststatus == "ignored" then
		if dbpc.ignored[uid] == nil then
			dbpc.ignored[uid] = true
		else
			dbpc.ignored[uid] = nil
		end
		--dbpc.ignored[uid] = not dbpc.ignored[uid]
	elseif ignored and queststatus == "forget" then
		if dbpc.history[zoneid] then
			if dbpc.history[zoneid][uid] then
				dbpc.history[zoneid][uid]["status"] = nil
			end
		end
	else
		if not dbpc.history[zoneid] then
			dbpc.history[zoneid] = {}
		end
		if not dbpc.history[zoneid][uid] then
			dbpc.history[zoneid][uid] = {}
			--dbpc.history[zoneid][uid].id = uid
		end
		dbpc.history[zoneid][uid].status = queststatus
	end
	if dbpc.history[zoneid] and dbpc.history[zoneid][uid] then
		dbpc.history[zoneid][uid]["imported"] = nil
	end
	self:UpdateFrame()
end

local function pairsByKeys (t, f)
      local a = {}
      for n in pairs(t) do table.insert(a, n) end
      table.sort(a, f)
      local i = 0      -- iterator variable
      local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
      end
      return iter
    end

function addon:UpdateSortList()
	--wipe(currentsort)
	--self:Print("UpdateSortList")
	local list = {}
	local list2 = {}
	for k,v in pairs(dbpc.sort) do
		if dbpc.enabledsort[k] then
			if list[v["Weight"]] == nil then
				list[v["Weight"]] = k
			else
				list[v["Weight"] +1] = k
			end
			--self:Print(k)
		end
	end
	for k,v in pairsByKeys(list) do
		list2[#list2 + 1] = v
		--self:Print(v)
	end
	--Spew("list", list)
	currentsort = list2
	addon.listsorted = false
	--Spew("list2", list2)
end

--[[function addon:SortTable(a,b)
	if (a.d or 0) == (b.d or 0) then
		if (a.t or 0) == (b.t or 0) then
			if (a.l or a.r or 0) == (b.l or b.r or 0) then
				if a.n == b.n then
					return false
				else
					return a.n > b.n
				end
			else
				return (a.l or a.r or 0) > (b.l or b.r or 0)
			end
		else 
			return (a.t or 0) > (b.t or 0)
		end
	else 
		return (a.d or 0) > (b.d or 0)
	end
end]]

function addon:SortTable(aa,bee)
	local f = currentsort
	local a = new()
	local b = new()
	a.l = (aa.l ~= nil and aa.l) or (aa.r ~= nil and aa.r) or 0
	b.l = (bee.l ~= nil and bee.l) or (bee.r ~= nil and bee.r) or 0
	a.d = aa.d
	b.d = bee.d
	a.w = aa.w
	b.w = bee.w
	a.n = db.localized[locale][aa.id] ~= nil and db.localized[locale][aa.id] or aa.n
	b.n = db.localized[locale][bee.id] ~= nil and db.localized[locale][bee.id] or bee.n
	a.t = aa.t
	b.t = bee.t
	if a["l"] == nil then if a["r"] == nil then a["l"] = 0 else a["l"] = a["r"] end end
	if b["l"] == nil then if b["r"] == nil then b["l"] = 0 else b["l"] = b["r"] end end
	if (a[f[5]] or 0) == (b[f[5]] or 0) then
		if (a[f[4]] or 0) == (b[f[4]] or 0) then
			if (a[f[3]] or 0) == (b[f[3]] or 0) then
				if (a[f[2]] or 0) == (b[f[2]] or 0) then
					if (a[f[1]] or 0) == (b[f[1]] or 0) then
						return false
					else
						if dbpc.sort[f[1]].Dir == 2 then
							return (a[f[1]] or 0) > (b[f[1]] or 0)
						else
							return (a[f[1]] or 0) < (b[f[1]] or 0)
						end
					end
				else
					if dbpc.sort[f[2]].Dir == 2 then
						return (a[f[2]] or 0) > (b[f[2]] or 0)
					else
						return (a[f[2]] or 0) < (b[f[2]] or 0)
					end
				end
			else
				if dbpc.sort[f[3]].Dir == 2 then
					return (a[f[3]] or 0) > (b[f[3]] or 0)
				else
					return (a[f[3]] or 0) < (b[f[3]] or 0)
				end
			end
		else 
			if dbpc.sort[f[4]].Dir == 2 then
				return (a[f[4]] or 0) > (b[f[4]] or 0)
			else
				return (a[f[4]] or 0) < (b[f[4]] or 0)
			end
		end
	else 
		if dbpc.sort[f[5]].Dir == 2 then
			return (a[f[5]] or 0) > (b[f[5]] or 0)
		else
			return (a[f[5]] or 0) < (b[f[5]] or 0)
		end
	end
	del(a)
	del(b)
end

function addon:GetZoneQuestData(zonegroup, zoneid)
	groupdata = self:LoadQuestData(zonegroup)
	if groupdata ~= false then
		return groupdata[zoneid]
	else
		return false
	end
	return false
end

function addon:LoadQuestData(group)
	if group ~= nil then
		local varname = "EveryQuest_"..gsub(group, " ", "_")
		--self:Debug("Loading single module: "..tostring(varname))
		local _, _, _, enabled = GetAddOnInfo(varname)
		if not EveryQuestData[group] then
			
			--self:Debug("Module "..tostring(group).." not loaded")
			if enabled then
				self:Print( sfmt(L["Loading %s Quest Data"], group) ) -- LOD status, %s = localized module name
				local succ,reason = LoadAddOn(varname)
				if succ ~= 1 then
					self:Print( sfmt(L["Could not load %s Quest Data because of %s"], group, reason) ) -- LOD status, %s = localized module name, %s = failure reason from WoW API
					return false
				end
				collectgarbage("collect")
			else
				self:Print( sfmt(L["Requires LOD Module: %s"], varname) ) -- LOD status, %s = localized module name
				return false
			end
		else
			--self:Debug("Module "..tostring(group).." is loaded")
		end
		return EveryQuestData[group] --questdata[varname] and varname
	else
		
	end
	return false
end


function addon:GetColor(hex)
	if hex == 1 then
		return 0,1,0
	elseif hex == -1 then
		return 1,0,0
	elseif hex == 2 then
		return 0,.807,.019
	elseif hex == 0 then
		return 1,1,0
	elseif hex == 99 then -- Unknown
		return 1,1,1
	end
	local rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)
	return tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255
end

function addon:CreateQuestLink(questid, questname, questlevel)
	if questlevel == nil then questlevel = -1 end
	self:Debug("CreateQuestLink - quest:"..tostring(questid)..":"..tostring(questlevel))
	return "\124cffffff00\124Hquest:"..questid..":"..questlevel.."\124h["..questname.."]\124h\124r"
end

function EveryQuest_ScrollFrame_Update()
	addon:UpdateFrame()
end


function addon:timeDiff(timestamp)
	--[["""
		Returns a string representing the amount of time that has passed since timestamp
	"""]]
    local now = time()
	local amount = now - timestamp
	local value
	local seconds, minutes, hours, days
    --If the difference is positive "ago" - negative "away"

	--amount = amount + DAY + HOUR*5
	
	if amount >= (DAY * 10) then
		return date(L["%m/%d/%y %I%p"], timestamp) -- timeDiff string, date() format for times over 10 days old
	end
	
	if (amount >= DAY) and (amount < (DAY * 10)) then
		-- between one day and 30 days
		days = math.floor(amount/DAY)
		hours = amount%DAY
		hours = math.floor(hours/HOUR)
		if days ~= 1 then
			if hours ~= 0 then
				return sfmt(L["%d days %d hr ago"], days, hours) -- timeDiff string, %d = digit, %d = digit
			else
				return sfmt(L["%d days ago"], days) -- timeDiff string, %d = digit
			end
		else
			if hours ~= 0 then
				return sfmt(L["1 day %d hr ago"], days, hours) -- timeDiff string, %d = digit
			else
				return L["1 day ago"] -- timeDiff string
			end
		end
	end
  
	if (amount < DAY) and (amount >= HOUR) then
		-- between one hour and one day
		--value = string.format("%H hr %M min ago", amount)
		hours = math.floor(amount/HOUR)
		minutes = amount%HOUR
		minutes = math.floor(minutes/MINUTE +.5)
		--return  .. " between one hour and one day"
		if minutes ~= 0 then
			return sfmt(L["%d hr %d min ago"], hours, minutes) -- timeDiff string, %d = digit, %d = digit
		else
			return sfmt(L["%d hr ago"], hours) -- timeDiff string, %d = digit
		end
	end
	
	if (amount < HOUR and amount >= MINUTE) then
		-- between one minute and one hour
		if self:round(amount / MINUTE) > 1 then
			return sfmt(L["%d minutes ago"], self:round(amount / MINUTE)) -- timeDiff string, %d = digit
		else
			return L["1 minute ago"] -- timeDiff string
		end
	end
	
	if amount > 1 then
		return sfmt(L["%d seconds ago"], amount) -- timeDiff string
	else
		return L["1 second ago"] -- timeDiff string
	end
end

function addon:round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

--- EOF ---