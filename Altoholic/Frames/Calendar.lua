local L = LibStub("AceLocale-3.0"):GetLocale("Altoholic")

local WHITE		= "|cFFFFFFFF"
local TEAL		= "|cFF00FF9A"
local GREEN		= "|cFF00FF00"

-- Weekday constants
local CALENDAR_WEEKDAY_NORMALIZED_TEX_LEFT	= 0.0;
local CALENDAR_WEEKDAY_NORMALIZED_TEX_TOP		= 180 / 256;
local CALENDAR_WEEKDAY_NORMALIZED_TEX_WIDTH	= 90 / 256 - 0.001; -- fudge factor to prevent texture seams
local CALENDAR_WEEKDAY_NORMALIZED_TEX_HEIGHT	= 28 / 256 - 0.001; -- fudge factor to prevent texture seams

local CALENDAR_MAX_DAYS_PER_MONTH			= 42;		-- 6 weeks
local CALENDAR_DAYBUTTON_NORMALIZED_TEX_WIDTH	= 90 / 256 - 0.001; -- fudge factor to prevent texture seams
local CALENDAR_DAYBUTTON_NORMALIZED_TEX_HEIGHT	= 90 / 256 - 0.001; -- fudge factor to prevent texture seams
local CALENDAR_DAYBUTTON_HIGHLIGHT_ALPHA		= 0.5;
local DAY_BUTTON = "AltoCalendarDayButton"

local CALENDAR_FIRST_WEEKDAY = 1
-- 1 = Sunday, recreated locally to avoid the problem caused by the calendar addon not being loaded at startup.
-- On an EU client, CALENDAR_FIRST_WEEKDAY = 1 when the game is loaded, but becomes 2 as soon as the calendar is launched.
-- So default it to 1, and add an option to select Monday as 1st day of the week instead. If need be, use a slider.
-- Although the calendar is LoD, avoid it.

local CALENDAR_MONTH_NAMES = { CalendarGetMonthNames() };
local CALENDAR_WEEKDAY_NAMES = { CalendarGetWeekdayNames() };

local CALENDAR_FULLDATE_MONTH_NAMES = {
	-- month names show up differently for full date displays in some languages
	FULLDATE_MONTH_JANUARY,
	FULLDATE_MONTH_FEBRUARY,
	FULLDATE_MONTH_MARCH,
	FULLDATE_MONTH_APRIL,
	FULLDATE_MONTH_MAY,
	FULLDATE_MONTH_JUNE,
	FULLDATE_MONTH_JULY,
	FULLDATE_MONTH_AUGUST,
	FULLDATE_MONTH_SEPTEMBER,
	FULLDATE_MONTH_OCTOBER,
	FULLDATE_MONTH_NOVEMBER,
	FULLDATE_MONTH_DECEMBER,
};

local COOLDOWN_LINE = 1
local INSTANCE_LINE = 2
local CALENDAR_LINE = 3
local CONNECTMMO_LINE = 4
local TIMER_LINE = 5
local SHARED_CD_LINE = 6		-- this type is used for shared cooldowns (alchemy, etc..) among others.

Altoholic.Calendar = {}
Altoholic.Calendar.Days = {}
Altoholic.Calendar.Events = {}

local TimeTable = {}	-- to pass as an argument to time()	see http://lua-users.org/wiki/OsLibraryTutorial for details
local ClockDiff
local lastServerMinute

local function SetClockDiff(elapsed)
	-- this function is called every second until the server time changes (track minutes only)
	local ServerHour, ServerMinute = GetGameTime()
	local continue = true		-- keeps the task running
	
	if not lastServerMinute then		-- ServerMinute not set ? this is the first pass, save it
		lastServerMinute = ServerMinute
	else
		if lastServerMinute ~= ServerMinute then		-- next minute ? do our stuff and stop
			local _, ServerMonth, ServerDay, ServerYear = CalendarGetDate()
			TimeTable.year = ServerYear
			TimeTable.month = ServerMonth
			TimeTable.day = ServerDay
			TimeTable.hour = ServerHour
			TimeTable.min = ServerMinute
			TimeTable.sec = 0					-- minute just changed, so second is 0

			-- our goal is achieved, we can calculate the difference between server time and local time, in seconds.
			-- a positive value means that the server time is ahead of local time.
			-- ex: server: 21:05, local 21.02 could lead to something like 180 (or close to it, depending on seconds)
			ClockDiff = difftime(time(TimeTable), time())
			Altoholic.Calendar.Events:BuildList()		-- rebuild the event list to take the known difference into account
			
			-- now that the difference is known, we can check events for warnings, first check should occur right now (hence 0)
			Altoholic.Tasks:Add("EventWarning", 0, Altoholic.Calendar.CheckEvents, Altoholic.Calendar)
		
			lastServerMinute = nil
			continue = nil
		end
	end
	
	if continue then
		Altoholic.Tasks:Reschedule("SetClockDiff", 1)	-- 1 second later
		return true
	end
end

local function GetClockDiff()
	return ClockDiff or 0
end

function Altoholic.Calendar:Init()
	-- by default, the week starts on Sunday, adjust CALENDAR_FIRST_WEEKDAY if necessary
	if Altoholic.Options:Get("WeekStartsMonday") == 1 then
		CALENDAR_FIRST_WEEKDAY = 2
	end
	
	local _, thisMonth, _, thisYear = CalendarGetDate();
	CalendarSetAbsMonth(thisMonth, thisYear);
	
	-- only register after setting the current month
	Altoholic:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST", Altoholic.Calendar.OnUpdate)
	
	local band = bit.band;
	
	-- initialize weekdays
	for i = 1, 7 do
		local bg = _G["AltoholicFrameCalendarWeekday"..i.."Background"]
		local left = (band(i, 1) * CALENDAR_WEEKDAY_NORMALIZED_TEX_WIDTH) + CALENDAR_WEEKDAY_NORMALIZED_TEX_LEFT;		-- mod(index, 2) * width
		local right = left + CALENDAR_WEEKDAY_NORMALIZED_TEX_WIDTH;
		local top = CALENDAR_WEEKDAY_NORMALIZED_TEX_TOP;
		local bottom = top + CALENDAR_WEEKDAY_NORMALIZED_TEX_HEIGHT;
		bg:SetTexCoord(left, right, top, bottom);
	end
	
	-- initialize day buttons
	for i = 1, CALENDAR_MAX_DAYS_PER_MONTH do
		CreateFrame("Button", DAY_BUTTON..i, AltoholicFrameCalendar, "AltoCalendarDayButtonTemplate");
		self.Days:Init(i)
	end
	
	self.Events:BuildList()
	self.Events:InitialExpiryCheck()
	
	-- determine the difference between local time and server time
	Altoholic.Tasks:Add("SetClockDiff", 0, SetClockDiff, Altoholic.Calendar)
end

local function GetWeekdayIndex(index)
	-- GetWeekdayIndex takes an index in the range [1, n] and maps it to a weekday starting
	-- at CALENDAR_FIRST_WEEKDAY. For example,
	-- CALENDAR_FIRST_WEEKDAY = 1 => [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY]
	-- CALENDAR_FIRST_WEEKDAY = 2 => [MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY]
	-- CALENDAR_FIRST_WEEKDAY = 6 => [FRIDAY, SATURDAY, SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY]
	
	-- the expanded form for the left input to mod() is:
	-- (index - 1) + (CALENDAR_FIRST_WEEKDAY - 1)
	-- why the - 1 and then + 1 before return? because lua has 1-based indexes! awesome!
	return mod(index - 2 + CALENDAR_FIRST_WEEKDAY, 7) + 1;
end

local function GetFullDate(weekday, month, day, year)
	local weekdayName = CALENDAR_WEEKDAY_NAMES[weekday];
	local monthName = CALENDAR_FULLDATE_MONTH_NAMES[month];
	return weekdayName, monthName, day, year, month;
end

local function GetDay(fullday)
	-- full day = a date as YYYY-MM-DD
	-- this function is actually different than the one in Blizzard_Calendar.lua, since weekday can't necessarily be determined from a UI button
	local refDate = {}		-- let's use the 1st of current month as reference date
	local refMonthFirstDay
	refDate.month, refDate.year, _, refMonthFirstDay = CalendarGetMonth()
	refDate.day = 1

	local t = {}
	local year, month, day = strsplit("-", fullday)
	t.year = tonumber(year)
	t.month = tonumber(month)
	t.day = tonumber(day)

	local numDays = floor(difftime(time(t), time(refDate)) / 86400)
	local weekday = mod(refMonthFirstDay + numDays, 7)
	
	-- at this point, weekday might be negative or 0, simply add 7 to keep it in the proper range
	weekday = (weekday <= 0) and (weekday+7) or weekday
	
	return t.year, t.month, t.day, weekday
end

local function GetEventExpiry(event)
	-- returns the number of seconds in which a calendar event expires
	assert(type(event) == "table")

	local year, month, day = strsplit("-", event.eventDate)
	local hour, minute = strsplit(":", event.eventTime)

	TimeTable.year = tonumber(year)
	TimeTable.month = tonumber(month)
	TimeTable.day = tonumber(day)
	TimeTable.hour = tonumber(hour)
	TimeTable.min = tonumber(minute)

	return difftime(time(TimeTable), time() + GetClockDiff())	-- in seconds
end

local TimerThresholds = { 30, 15, 10, 5, 4, 3, 2, 1 }

local CalendarEventTypes = {
	[COOLDOWN_LINE] = {
		GetReadyNowWarning = function(self, event)
				local name = DataStore:GetCraftCooldownInfo(event.source, event.parentID)
				return format(L["%s is now ready (%s on %s)"], name, event.char, event.realm)
			end,
		GetReadySoonWarning = function(self, event, minutes)
				local name = DataStore:GetCraftCooldownInfo(event.source, event.parentID)
				return format(L["%s will be ready in %d minutes (%s on %s)"], name, minutes, event.char, event.realm)
			end,
		GetInfo = function(self, event)
				local title, expiresIn = DataStore:GetCraftCooldownInfo(event.source, event.parentID)
				return title, format("%s %s", COOLDOWN_REMAINING, Altoholic:GetTimeString(expiresIn))
			end,
	},
	[INSTANCE_LINE] = {
		GetReadyNowWarning = function(self, event)
				local instance = strsplit("|", event.parentID)
				return format(L["%s is now unlocked (%s on %s)"], instance, event.char, event.realm)
			end,
		GetReadySoonWarning = function(self, event, minutes)
				local instance = strsplit("|", event.parentID)
				return format(L["%s will be unlocked in %d minutes (%s on %s)"], instance, minutes, event.char, event.realm)
			end,
		GetInfo = function(self, event)
				-- title gets the instance name, desc gets the raid id
				local instanceName, raidID = strsplit("|", event.parentID)
		
				--	CALENDAR_EVENTNAME_FORMAT_RAID_LOCKOUT = "%s Unlocks"; -- %s = Raid Name
				return instanceName, format("%s%s\nID: %s%s", WHITE,	format(CALENDAR_EVENTNAME_FORMAT_RAID_LOCKOUT, instanceName), GREEN, raidID)
			end,
	},
	[CALENDAR_LINE] = {
		GetReadyNowWarning = function(self, event)
				local c = Altoholic:GetCharacterTable(event.char, event.realm)
				local _, _, title = strsplit("|", c.Calendar[event.parentID])
				return format(CALENDAR_EVENTNAME_FORMAT_START .. " (%s/%s)", title, event.char, event.realm)
			end,
		GetReadySoonWarning = function(self, event, minutes)
				local c = Altoholic:GetCharacterTable(event.char, event.realm)
				local _, _, title = strsplit("|", c.Calendar[event.parentID])
				return format(L["%s starts in %d minutes (%s on %s)"], title, minutes, event.char, event.realm)
			end,
		GetInfo = function(self, event)
				local c = Altoholic:GetCharacterTable(event.char, event.realm)
				local _, _, title, eventType, inviteStatus = strsplit("|", c.Calendar[event.parentID])

				inviteStatus = tonumber(inviteStatus)
				
				local desc
				if type(inviteStatus) == "number" and (inviteStatus > 1) and (inviteStatus < 8) then
					local StatusText = {
						CALENDAR_STATUS_INVITED,		-- CALENDAR_INVITESTATUS_INVITED   = 1
						CALENDAR_STATUS_ACCEPTED,		-- CALENDAR_INVITESTATUS_ACCEPTED  = 2
						CALENDAR_STATUS_DECLINED,		-- CALENDAR_INVITESTATUS_DECLINED  = 3
						CALENDAR_STATUS_CONFIRMED,		-- CALENDAR_INVITESTATUS_CONFIRMED = 4
						CALENDAR_STATUS_OUT,				-- CALENDAR_INVITESTATUS_OUT       = 5
						CALENDAR_STATUS_STANDBY,		-- CALENDAR_INVITESTATUS_STANDBY   = 6
						CALENDAR_STATUS_SIGNEDUP,		-- CALENDAR_INVITESTATUS_SIGNEDUP     = 7
						CALENDAR_STATUS_NOT_SIGNEDUP	-- CALENDAR_INVITESTATUS_NOT_SIGNEDUP = 8
					}
				
					desc = format("%s: %s", STATUS, WHITE..StatusText[inviteStatus]) 
				else 
					desc = format("%s", STATUS) 
				end
		
				return title, desc
			end,
	},
	[CONNECTMMO_LINE] = {
		GetReadyNowWarning = function(self, event)
				local c = Altoholic:GetCharacterTable(event.char, event.realm)
				local _, _, title = strsplit("|", c.ConnectMMO[event.parentID])
				return format(CALENDAR_EVENTNAME_FORMAT_START .. " (%s/%s)", title, event.char, event.realm)
			end,
		GetReadySoonWarning = function(self, event, minutes)
				local c = Altoholic:GetCharacterTable(event.char, event.realm)
				local _, _, title = strsplit("|", c.ConnectMMO[event.parentID])
				return format(L["%s starts in %d minutes (%s on %s)"], title, minutes, event.char, event.realm)
			end,
		GetInfo = function(self, event)
				local c = Altoholic:GetCharacterTable(event.char, event.realm)
				local _, _, title, eventType, eventDesc, attendees = strsplit("|", c.ConnectMMO[event.parentID])
				
				local numPlayers, minLvl, maxLvl, privateToFriends, privateToGuild = strsplit(",", eventDesc)
				local eventTable = {}
			
				table.insert(eventTable, WHITE .. format(L["Number of players: %s"], GREEN .. numPlayers))
				table.insert(eventTable, WHITE .. format(L["Minimum Level: %s"], GREEN .. minLvl))
				table.insert(eventTable, WHITE .. format(L["Maximum Level: %s"], GREEN .. maxLvl))
				table.insert(eventTable, WHITE .. format(L["Private to friends: %s"], GREEN .. (tonumber(privateToFriends) == 1 and YES or NO)))
				table.insert(eventTable, WHITE .. format(L["Private to guild: %s"], GREEN .. (tonumber(privateToGuild) == 1 and YES or NO)))

				local attendeesTable = { strsplit(",", attendees) }
				
				if #attendeesTable > 0 then
					table.insert(eventTable, "")
					table.insert(eventTable, WHITE..L["Attendees: "].."|r")
					for _, name in pairs(attendeesTable) do
						table.insert(eventTable, " " .. name )
					end
					table.insert(eventTable, "")
					table.insert(eventTable, GREEN .. L["Left-click to invite attendees"])
				end
				
				return title, table.concat(eventTable, "\n")
			end,
	},
	[TIMER_LINE] = {
		GetReadyNowWarning = function(self, event)
				local c = Altoholic:GetCharacterTable(event.char, event.realm)
				local item = strsplit("|", c.Timers[event.parentID])
				return format(L["%s is now ready (%s on %s)"], item, event.char, event.realm)
			end,
		GetReadySoonWarning = function(self, event, minutes)
				local c = Altoholic:GetCharacterTable(event.char, event.realm)
				local item = strsplit("|", c.Timers[event.parentID])
				return format(L["%s will be ready in %d minutes (%s on %s)"], item, minutes, event.char, event.realm)
			end,
		GetInfo = function(self, event)
				local c = Altoholic:GetCharacterTable(event.char, event.realm)
				local title = strsplit("|", c.Timers[event.parentID])
				local expiresIn = GetEventExpiry(event)
				return title, format("%s %s", COOLDOWN_REMAINING, Altoholic:GetTimeString(expiresIn))
			end,
	},
	[SHARED_CD_LINE] = {
		GetReadyNowWarning = function(self, event)
				return format(L["%s is now ready (%s on %s)"], event.source, event.char, event.realm)
			end,
		GetReadySoonWarning = function(self, event, minutes)
				return format(L["%s will be ready in %d minutes (%s on %s)"], event.source, minutes, event.char, event.realm)
			end,
		GetInfo = function(self, event)
				local expiresIn = GetEventExpiry(event)
				return event.source, format("%s %s", COOLDOWN_REMAINING, Altoholic:GetTimeString(expiresIn))
			end,
	},
}

local function ShowExpiryWarning(index, minutes)
	local event = Altoholic.Calendar.Events:Get(index)
	local CalendarEvent = CalendarEventTypes[event.eventType]
	
	local warning
	if minutes == 0 then
		warning = CalendarEvent:GetReadyNowWarning(event)
	else
		warning = CalendarEvent:GetReadySoonWarning(event, minutes)
	end
	if not warning then return end
	
	-- print instead of dialog box if player is in combat
	if Altoholic.Options:Get("WarningDialogBox") == 1 and not UnitAffectingCombat("player") then
		AltoMsgBox.ButtonHandler = Altoholic.Calendar.WarningButtonHandler
		AltoMsgBox_Text:SetText(format("%s\n%s", WHITE..warning, L["Do you want to open Altoholic's calendar for details ?"]))
		AltoMsgBox:Show()
	else
		Altoholic:Print(warning)
	end
end

local function ClearExpiredEvents()
	local DS = DataStore
	
	for realm in pairs(DS:GetRealms()) do
		for characterName, character in pairs(DS:GetCharacters(realm)) do

			-- Profession Cooldowns
			local professions = DS:GetProfessions(character)
			if professions then
				for professionName, profession in pairs(professions) do
					DS:ClearExpiredCooldowns(profession)
				end
			end
			
			local c = Altoholic:GetCharacterTable(characterName, realm)
			
			-- Saved Instances
			for k, v in pairs(c.SavedInstance) do
				local reset, lastCheck = strsplit("|", v)
				reset = tonumber(reset)
				lastCheck = tonumber(lastCheck)
				
				if reset - (time() - lastCheck) <= 0 then	-- has expired
					c.SavedInstance[k] = nil
				end
			end
			
			-- Other timers (like mysterious egg, etc..)
			for k, v in pairs(c.Timers) do
				local _, lastCheck, duration = strsplit("|", v)
				lastCheck = tonumber(lastCheck)
				duration = tonumber(duration)
				local expires = duration + lastCheck + GetClockDiff()
				if (expires - time()) <= 0 then
					c.Timers[k] = nil
				end
			end
		end
	end
end

local function IsNumberInString(number, str)
	-- ex: with str = "15|10|3" returns true if value is in this string
	for v in str:gmatch("(%d+)") do
		if tonumber(v) == number then
			return true
		end
	end
end

local WARNING_TYPE_PROFESSION_CD = 1
local WARNING_TYPE_DUNGEON_RESET = 2
local WARNING_TYPE_CALENDAR_EVENT = 3
local WARNING_TYPE_ITEM_TIMER = 4

local EventToWarningType = {
	[COOLDOWN_LINE] = WARNING_TYPE_PROFESSION_CD,
	[INSTANCE_LINE] = WARNING_TYPE_DUNGEON_RESET,
	[CALENDAR_LINE] = WARNING_TYPE_CALENDAR_EVENT,
	[CONNECTMMO_LINE] = WARNING_TYPE_CALENDAR_EVENT,
	[TIMER_LINE] = WARNING_TYPE_ITEM_TIMER,
	[SHARED_CD_LINE] = WARNING_TYPE_PROFESSION_CD,
}

function Altoholic.Calendar:CheckEvents(elapsed)
	if Altoholic.Options:Get("DisableWarnings") == 1 then	-- warnings disabled ? do nothing
		Altoholic.Tasks:Reschedule("EventWarning", 60)
		return true
	end

	-- called every 60 seconds
	local hasEventExpired
	
	for k, v in pairs(Altoholic.Calendar.Events.List) do
		local numMin = floor(GetEventExpiry(v) / 60)

		if numMin < 0 then
			hasEventExpired = true		-- at least one event has expired
		elseif numMin == 0 then
			ShowExpiryWarning(k, 0)
			hasEventExpired = true		-- at least one event has expired
		elseif numMin <= 30 then
			local warnings = Altoholic.Options:Get("WarningType"..EventToWarningType[v.eventType])		-- Gets something like "15|5|1"
			for _, threshold in pairs(TimerThresholds) do
				if threshold == numMin then			-- if snooze is allowed for this value
					if IsNumberInString(threshold, warnings) then
						ShowExpiryWarning(k, numMin)
					end
					break
				elseif threshold < numMin then		-- save some cpu cycles, exit if threshold too low
					break
				end
			end
		end
	end
	
	if hasEventExpired then		-- if at least one event has expired, rebuild the list & refresh
		ClearExpiredEvents()
		Altoholic.Calendar.Events:BuildList()
		Altoholic.Tabs.Summary:Refresh()
	end
	
	-- the task was executed right after the minute changed server side, so reschedule exactly 60 seconds later
	Altoholic.Tasks:Reschedule("EventWarning", 60)
	return true
end

function Altoholic.Calendar:WarningButtonHandler(button)
	AltoMsgBox.ButtonHandler = nil		-- prevent any other call to msgbox from coming back here
	if not button then return end

	Altoholic:ToggleUI()
	Altoholic.Tabs.Summary:MenuItem_OnClick(8)
end

function Altoholic.Calendar:SetFirstDayOfWeek(day)
	CALENDAR_FIRST_WEEKDAY = day
end

function Altoholic.Calendar:Update()
	-- taken from CalendarFrame_Update() in Blizzard_Calendar.lua, adjusted for my needs.

	local self = Altoholic.Calendar
	self.Events:BuildList()				-- force a rebuild when updating the view. In some rare cases, the list was not correctly updated. Temporary workaround	26/04/2010
	
	
	local presentWeekday, presentMonth, presentDay, presentYear = CalendarGetDate();
	local prevMonth, prevYear, prevNumDays = CalendarGetMonth(-1);
	local nextMonth, nextYear, nextNumDays = CalendarGetMonth(1);
	local month, year, numDays, firstWeekday = CalendarGetMonth();

	-- set title
	AltoholicFrameCalendar_MonthYear:SetText(CALENDAR_MONTH_NAMES[month] .. " ".. year)
	
	-- initialize weekdays
	for i = 1, 7 do
		_G["AltoholicFrameCalendarWeekday"..i.."Name"]:SetText(string.sub(CALENDAR_WEEKDAY_NAMES[GetWeekdayIndex(i)], 1, 3));
	end

	local buttonIndex = 1;
	local isDarkened = true
	local day;

	-- set the previous month's days before the first day of the week
	local viewablePrevMonthDays = mod((firstWeekday - CALENDAR_FIRST_WEEKDAY - 1) + 7, 7);
	day = prevNumDays - viewablePrevMonthDays;

	while ( GetWeekdayIndex(buttonIndex) ~= firstWeekday ) do
		self.Days:Update(buttonIndex, day, prevMonth, prevYear, isDarkened)
		day = day + 1;
		buttonIndex = buttonIndex + 1;
	end

	-- set the days of this month
	day = 1;
	isDarkened = false
	while ( day <= numDays ) do
		self.Days:Update(buttonIndex, day, month, year, isDarkened)
		day = day + 1;
		buttonIndex = buttonIndex + 1;
	end
	
	-- set the first days of the next month
	day = 1;
	isDarkened = true
	while ( buttonIndex <= CALENDAR_MAX_DAYS_PER_MONTH ) do
		self.Days:Update(buttonIndex, day, nextMonth, nextYear, isDarkened)

		day = day + 1;
		buttonIndex = buttonIndex + 1;
	end
	
	self.Events:Update()
end

function Altoholic.Calendar.Days:Init(index)
	local button = _G[DAY_BUTTON..index]
	button:SetID(index)
	
	-- set anchors
	button:ClearAllPoints();
	if ( index == 1 ) then
		button:SetPoint("TOPLEFT", AltoholicFrameCalendar, "TOPLEFT", 285, -1);
	elseif ( mod(index, 7) == 1 ) then
		button:SetPoint("TOPLEFT", _G[DAY_BUTTON..(index - 7)], "BOTTOMLEFT", 0, 0);
	else
		button:SetPoint("TOPLEFT", _G[DAY_BUTTON..(index - 1)], "TOPRIGHT", 0, 0);
	end

	-- set the normal texture to be the background
	local tex = button:GetNormalTexture();
	tex:SetDrawLayer("BACKGROUND");
	local texLeft = random(0,1) * CALENDAR_DAYBUTTON_NORMALIZED_TEX_WIDTH;
	local texRight = texLeft + CALENDAR_DAYBUTTON_NORMALIZED_TEX_WIDTH;
	local texTop = random(0,1) * CALENDAR_DAYBUTTON_NORMALIZED_TEX_HEIGHT;
	local texBottom = texTop + CALENDAR_DAYBUTTON_NORMALIZED_TEX_HEIGHT;
	tex:SetTexCoord(texLeft, texRight, texTop, texBottom);
	
	-- adjust the highlight texture layer
	tex = button:GetHighlightTexture();
	tex:SetAlpha(CALENDAR_DAYBUTTON_HIGHLIGHT_ALPHA);
end

function Altoholic.Calendar.Days:Update(index, day, month, year, isDarkened)
	local button = _G[DAY_BUTTON..index]
	local buttonName = button:GetName();
	
	button.day = day
	button.month = month
	button.year = year
	
	-- set date
	local dateLabel = _G[buttonName.."Date"];
	local tex = button:GetNormalTexture();

	dateLabel:SetText(day);
	if isDarkened then
		tex:SetVertexColor(0.4, 0.4, 0.4)
	else
		tex:SetVertexColor(1.0, 1.0, 1.0)
	end
	
	-- set count
	local countLabel = _G[buttonName.."Count"];
	local count = Altoholic.Calendar.Events:GetNum(year, month, day)
	
	if count == 0 then
		countLabel:Hide()
	else
		countLabel:SetText(count)
		countLabel:Show()
	end
end

function Altoholic.Calendar.Days:OnClick(self, button)
	local Events = Altoholic.Calendar.Events
	local count = Events:GetNum(self.year, self.month, self.day)
	if count == 0 then	-- no events on that day ? exit
		return
	end	
	
	local index = Events:GetIndex(self.year, self.month, self.day)
	if index then
		Events:SetOffset(index - 1)	-- if the date is the 4th line, offset is 3
		Events:Update()
	end
end

function Altoholic.Calendar.Days:OnEnter(self)

	local Events = Altoholic.Calendar.Events
	local count = Events:GetNum(self.year, self.month, self.day)
	if count == 0 then	-- no events on that day ? exit
		return
	end
	
	AltoTooltip:SetOwner(self, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	local eventDate = format("%04d-%02d-%02d", self.year, self.month, self.day)
	local weekday = GetWeekdayIndex(mod(self:GetID(), 7)) 
	weekday = (weekday == 0) and 7 or weekday
	
	AltoTooltip:AddLine(TEAL..format(FULLDATE, GetFullDate(weekday, self.month, self.day, self.year)));

	for k, v in pairs(Events.List) do
		if v.eventDate == eventDate then
			local char, eventTime, title = Events:GetInfo(k)
			AltoTooltip:AddDoubleLine(format("%s %s", WHITE..eventTime, char), title);
		end
	end
	AltoTooltip:Show();
end

local EVENT_DATE = 1
local EVENT_INFO = 2

function Altoholic.Calendar.Events:InitialExpiryCheck()
	for index, event in pairs(self.List) do			-- browse all events
		local expiresIn = GetEventExpiry(event)
		if expiresIn < 0 then					-- if the event has expired
			event.markForDeletion = true		-- .. mark it for deletion (no table.remove in this pass, to avoid messing up indexes)
			ShowExpiryWarning(index, 0)		-- .. and do the appropriate warning
		end
	end
	
	for i = #self.List, 1, -1 do			-- browse the event table backwards
		if self.List[i].markForDeletion then	-- erase marked events
			table.remove(self.List, i)
		end
	end
	
	ClearExpiredEvents()	-- quick fix, it seems that for some reason, egg timers did not get cleared as they should without this call
	self.InitialExpiryCheck = nil		-- kill self, function won't be called again
end

function Altoholic.Calendar.Events:BuildView()
	self.view = self.view or {}
	wipe(self.view)
	
	-- the following list of events : 10/05, 10/05, 12/05, 14/05, 14/05
	-- turns into this view : 
	-- 	"10/05"
	--	event 1
	--	event 2
	--	"12/05"
	--	event 1
	-- 	"14/05"
	--	event 1
	--	event 2
	
	
	local eventDate = ""
	for k, v in pairs(self.List) do
		if eventDate ~= v.eventDate then
			table.insert(self.view, { linetype = EVENT_DATE, eventDate = v.eventDate })
			eventDate = v.eventDate
		end
		table.insert(self.view, { linetype = EVENT_INFO, parentID = k })
	end
end

function Altoholic.Calendar.Events:BuildList()
	self.List = self.List or {}
	wipe(self.List)

	local ClockDiff = GetClockDiff()
	local DS = DataStore
	
	for realm in pairs(DS:GetRealms()) do
		for characterName, character in pairs(DS:GetCharacters(realm)) do
			-- add all timers, even expired ones. Expiries will be handled elsewhere.

			-- Profession Cooldowns
			local professions = DS:GetProfessions(character)
			if professions then
				for professionName, profession in pairs(professions) do
					local supportsSharedCD
					if professionName == GetSpellInfo(2259) or			-- alchemy
						professionName == GetSpellInfo(3908) or 			-- tailoring
						professionName == GetSpellInfo(2575) then			-- mining
						supportsSharedCD = true		-- current profession supports shared cooldowns
					end
					
					if supportsSharedCD then
						local sharedCDFound		-- is there a shared cd for this profession ?
						for i = 1, DS:GetNumActiveCooldowns(profession) do
							local name, _, reset, lastCheck = DS:GetCraftCooldownInfo(profession, i)
							local expires = reset + lastCheck + ClockDiff

							if not sharedCDFound then
								sharedCDFound = true
								self:Add(SHARED_CD_LINE, date("%Y-%m-%d",expires), date("%H:%M",expires), characterName, realm, nil, professionName)
							end
						end
					else
						for i = 1, DS:GetNumActiveCooldowns(profession) do
							local name, _, reset, lastCheck = DS:GetCraftCooldownInfo(profession, i)
							local expires = reset + lastCheck + ClockDiff

							self:Add(COOLDOWN_LINE, date("%Y-%m-%d",expires), date("%H:%M",expires), characterName, realm, i, profession)
						end
					end
				end
			end
			
			local c = Altoholic:GetCharacterTable(characterName, realm)
			
			-- Saved Instances
			for k, v in pairs(c.SavedInstance) do
				local reset, lastCheck = strsplit("|", v)
				reset = tonumber(reset)
				lastCheck = tonumber(lastCheck)
				
				local expires = reset + lastCheck + ClockDiff
				self:Add(INSTANCE_LINE, date("%Y-%m-%d",expires), date("%H:%M",expires), characterName, realm, k)
			end
			
			-- Calendar Events
			for k, v in pairs(c.Calendar) do
				local eventDate, eventTime = strsplit("|", v)
				-- TODO: do not add declined invitations
				self:Add(CALENDAR_LINE, eventDate, eventTime, characterName, realm, k)
			end
			
			-- ConnectMMO events
			for k, v in pairs(c.ConnectMMO) do
				local eventDate, eventTime = strsplit("|", v)
				self:Add(CONNECTMMO_LINE, eventDate, eventTime, characterName, realm, k)
			end
			
			-- Other timers (like mysterious egg, etc..)
			for k, v in pairs(c.Timers) do
				local item, lastCheck, duration = strsplit("|", v)
				lastCheck = tonumber(lastCheck)
				duration = tonumber(duration)

				local expires = duration + lastCheck + ClockDiff
				self:Add(TIMER_LINE, date("%Y-%m-%d",expires), date("%H:%M",expires), characterName, realm, k)
			end
		end
	end
	
	-- sort by time
	self:Sort()
	self:BuildView()
end

local NUM_EVENTLINES = 14

function Altoholic.Calendar.Events:Update()
	local self = Altoholic.Calendar.Events
	
	local VisibleLines = NUM_EVENTLINES
	local frame = "AltoholicFrameCalendar"
	local entry = frame.."Entry"

	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );

	for i=1, VisibleLines do
		local line = i + offset
		if line <= #self.view then
			local s = self.view[line]

			if s.linetype == EVENT_DATE then
				local year, month, day, weekday = GetDay(s.eventDate)
				_G[ entry..i.."Date" ]:SetText(format(FULLDATE, GetFullDate(weekday, month, day, year)))
				_G[ entry..i.."Date" ]:Show()
				
				_G[ entry..i.."Hour" ]:Hide()
				_G[ entry..i.."Character" ]:Hide()
				_G[ entry..i.."Title" ]:Hide()
				_G[ entry..i.."_Background"]:Show()
				
			elseif s.linetype == EVENT_INFO then
				local char, eventTime, title = self:GetInfo(s.parentID)

				_G[ entry..i.."Hour" ]:SetText(eventTime)
				_G[ entry..i.."Character" ]:SetText(char)
				_G[ entry..i.."Title" ]:SetText(title)
				
				_G[ entry..i.."Hour" ]:Show()
				_G[ entry..i.."Character" ]:Show()
				_G[ entry..i.."Title" ]:Show()

				_G[ entry..i.."Date" ]:Hide()
				_G[ entry..i.."_Background"]:Hide()
			end

			_G[ entry..i ]:SetID(line)
			_G[ entry..i ]:Show()
		else
			_G[ entry..i ]:Hide()
		end
	end
	
	local last = (#self.view < VisibleLines) and VisibleLines or #self.view
	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], last, VisibleLines, 18);
end

function Altoholic.Calendar.Events:Get(index)
	return self.List[index]
end

function Altoholic.Calendar.Events:GetInfo(index)
	local event = self.List[index]		-- dereference event
	if not event then return end
	
	local DS = DataStore
	local character = DS:GetCharacter(event.char, event.realm)
	local char = DS:GetColoredCharacterName(character)
	
	if event.realm ~= GetRealmName() then	-- different realm ?
		char = format("%s %s(%s)", char, GREEN, event.realm)
	end
	
	local CalendarEvent = CalendarEventTypes[event.eventType]
	local title, desc = CalendarEvent:GetInfo(event)
				
	return char, event.eventTime, title, desc
end

function Altoholic.Calendar.Events:Sort()
	table.sort(self.List, function(a, b)
		if (a.eventDate ~= b.eventDate) then			-- sort by date first ..
			return a.eventDate < b.eventDate
		elseif (a.eventTime ~= b.eventTime) then		-- .. then by hour
			return a.eventTime < b.eventTime
		elseif (a.char ~= b.char) then					-- .. then by alt
			return a.char < b.char
		end
	end)
end

function Altoholic.Calendar.Events:Add(eventType, eventDate, eventTime, char, realm, index, externalTable)
	table.insert(self.List, {
		eventType = eventType, 
		eventDate = eventDate, 
		eventTime = eventTime, 
		char = char,
		realm = realm,
		parentID = index,
		source = externalTable})
end

function Altoholic.Calendar.Events:GetNum(year, month, day)
	local eventDate = format("%04d-%02d-%02d", year, month, day)
	local count = 0
	for k, v in pairs(self.List) do
		if v.eventDate == eventDate then
			count = count + 1
		end
	end
	return count
end

function Altoholic.Calendar.Events:OnEnter(frame)
	local self = Altoholic.Calendar.Events
	local s = self.view[frame:GetID()]
	if not s or s.linetype == EVENT_DATE then return end
	
	
	AltoTooltip:SetOwner(frame, "ANCHOR_RIGHT");
	AltoTooltip:ClearLines();
	-- local eventDate = format("%04d-%02d-%02d", self.year, self.month, self.day)
	-- local weekday = GetWeekdayIndex(mod(self:GetID(), 7))
	-- AltoTooltip:AddLine(TEAL..format(FULLDATE, GetFullDate(weekday, self.month, self.day, self.year)));
	
	local char, eventTime, title, desc = self:GetInfo(s.parentID)
	AltoTooltip:AddDoubleLine(format("%s %s", WHITE..eventTime, char), title);
	if desc then
		AltoTooltip:AddLine(" ")
		AltoTooltip:AddLine(desc)
	end
	AltoTooltip:Show();
end

function Altoholic.Calendar.Events:OnClick(frame, button)
	-- if an event is left-clicked, try to invite attendees. ConnectMMO events only
	
	local self = Altoholic.Calendar.Events
	local s = self.view[frame:GetID()]
	if not s or s.linetype == EVENT_DATE then return end		-- date line ? exit
	
	local e = self.List[s.parentID]		-- dereference event
	-- not a connectmmo event ? or wrong realm ? exit
	if not e or e.eventType ~= CONNECTMMO_LINE or e.realm ~= GetRealmName() then return end	
	
	local c = Altoholic:GetCharacterTable(e.char, e.realm)
	if not c then return end	-- invalid char table ? exit
	
	local _, _, _, _, _, attendees = strsplit("|", c.ConnectMMO[e.parentID])

	-- TODO, add support for raid groups
	for _, name in pairs({ strsplit(",", attendees) }) do
		if name ~= UnitName("player") then
			InviteUnit(name) 
		end
	end
end

function Altoholic.Calendar.Events:GetIndex(year, month, day)
	local eventDate = format("%04d-%02d-%02d", year, month, day)
	for k, v in pairs(self.view) do
		if v.linetype == EVENT_DATE and v.eventDate == eventDate then
			-- if the date line is found, return its index
			return k
		end
	end
end

function Altoholic.Calendar.Events:SetOffset(offset)
	-- if the view has less entries than can be displayed, don't change the offset
	if #self.view <= NUM_EVENTLINES then return end

	if offset <= 0 then
		offset = 0
	elseif offset > (#self.view - NUM_EVENTLINES) then
		offset = (#self.view - NUM_EVENTLINES)
	end
	FauxScrollFrame_SetOffset( AltoholicFrameCalendarScrollFrame, offset )
	AltoholicFrameCalendarScrollFrameScrollBar:SetValue(offset * 18)
end

function Altoholic.Calendar:Scan()
	if not CalendarFrame then
		-- The Calendar addon is LoD, and most functions return nil if the calendar is not loaded, so unless the CalendarFrame is valid, exit right away
		return
	end
	Altoholic:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")	-- prevent CalendarSetAbsMonth from triggering a scan (= avoid infinite loop)
	
	local currentMonth, currentYear = CalendarGetMonth()		-- save the current month
	local _, thisMonth, thisDay, thisYear = CalendarGetDate();
	CalendarSetAbsMonth(thisMonth, thisYear);
	
	local c = Altoholic.ThisCharacter
	wipe(c.Calendar)
	
	-- save this month (from today) + 6 following months
	for monthOffset = 0, 6 do
		local month, year, numDays = CalendarGetMonth(monthOffset)
		local startDay = (monthOffset == 0) and thisDay or 1
		
		for day = startDay, numDays do
			for i = 1, CalendarGetNumDayEvents(monthOffset, day) do		-- number of events that day ..
				-- http://www.wowwiki.com/API_CalendarGetDayEvent
				local title, hour, minute, calendarType, _, eventType, _, _, inviteStatus = CalendarGetDayEvent(monthOffset, day, i)
				if calendarType ~= "HOLIDAY" and calendarType ~= "RAID_LOCKOUT" and 
					calendarType ~= "RAID_RESET" and inviteStatus ~= CALENDAR_INVITESTATUS_DECLINED then
					-- don't save holiday events, they're the same for all chars, and would be redundant..who wants to see 10 fishing contests every sundays ? =)

					table.insert(c.Calendar, format("%s|%s|%s|%d|%d",
						format("%04d-%02d-%02d", year, month, day), format("%02d:%02d", hour, minute),
						title, eventType, inviteStatus ))
				end
			end
		end
	end
	
	CalendarSetAbsMonth(currentMonth, currentYear);		-- restore current month
	Altoholic:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST", Altoholic.Calendar.OnUpdate)
end

function Altoholic.Calendar:OnUpdate()
	local self = Altoholic.Calendar
	self:Scan()
	self.Events:BuildList()
	Altoholic.Tabs.Summary:Refresh()
end

local function ToggleWarningThreshold(self)
	local id = self.arg1
	local warnings = Altoholic.Options:Get("WarningType"..id)		-- Gets something like "15|5|1"
	
	local t = {}		-- create a temporary table to store checked values
	for v in warnings:gmatch("(%d+)") do
		v = tonumber(v)
		if v ~= self.value then		-- add all values except the one that was clicked
			table.insert(t, v)
		end
	end
	
	if not IsNumberInString(self.value, warnings) then		-- if number is not yet in the string, save it (we're checking it, otherwise we're unchecking)
		table.insert(t, self.value)
	end
	
	Altoholic.Options:Set("WarningType"..id, table.concat(t, "|"))		-- Sets something like "15|5|10|1"
end

function Altoholic.Calendar:WarningType_Initialize()
	local info = UIDropDownMenu_CreateInfo();
	local id = self:GetID()
	local warnings = Altoholic.Options:Get("WarningType"..id)		-- Gets something like "15|5|1"
	
	for _, threshold in pairs(TimerThresholds) do
		info.text = format(D_MINUTES, threshold)
		info.value = threshold
		info.func = ToggleWarningThreshold
		info.checked = IsNumberInString(threshold, warnings)
		info.arg1 = id		-- save the id of the current option
		UIDropDownMenu_AddButton(info, 1); 
	end
end
