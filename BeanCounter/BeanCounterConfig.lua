--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: BeanCounterConfig.lua 4713 2010-04-13 00:09:44Z Nechckn $
	URL: http://auctioneeraddon.com/

	BeanCounterConfig - Controls Configuration data

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]
LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/auctioneer/branches/5.8/BeanCounter/BeanCounterConfig.lua $","$Rev: 4713 $","5.1.DEV.", 'auctioneer', 'libs')

--Most of this code is from enchantrix by ccox
local lib = BeanCounter
local private, print, _, _, _BC = lib.getLocals()
local gui, settings

local function debugPrint(...)
    if get("util.beancounter.debugConfig") then
        private.debugPrint("BeanCounterConfig",...)
    end
end

local function getUserSig()
	local userSig = string.format("users.%s.%s", GetRealmName(), UnitName("player"))
	return userSig
end

local function getUserProfileName()
	if (not settings) then settings = BeanCounterDB["settings"] end
	local userSig = getUserSig()
	return settings[userSig] or "Default"
end

local function getUserProfile()
	if (not settings) then settings = BeanCounterDB["settings"] end
	local profileName = getUserProfileName()
	if (not settings["profile."..profileName]) then
		if profileName ~= "Default" then
			profileName = "Default"
			settings[getUserSig()] = "Default"
		end
		if profileName == "Default" then
			settings["profile."..profileName] = {}
		end
	end
	return settings["profile."..profileName]
end


local function cleanse( profile )
	if (profile) then
		profile = {}
	end
end


-- Default setting values
local Buyer, Seller = string.match(_BC('UiBuyerSellerHeader'), "(.*)/(.*)") --We have no direct translation so this is a temp workaround
private.settingDefaults = {
	["util.beancounter.ButtonExactCheck"] = false,
	["util.beancounter.ButtonClassicCheck"] = false,
	["util.beancounter.ButtonBidCheck"] = true,
	["util.beancounter.ButtonBidFailedCheck"] = true,
	["util.beancounter.ButtonAuctionCheck"] = true,
	["util.beancounter.ButtonAuctionFailedCheck"] = true,

	["util.beancounter.activated"] = true,
	["util.beancounter.integrityCheckComplete"] = false,
	["util.beancounter.integrityCheck"] = true,

	--Tootip Settings
	["util.beancounter.displayReasonCodeTooltip"] = true,
	["util.beancounter.displaybeginerTooltips"] = true,

	--Debug settings
	["util.beancounter.debug"] = false,
	["util.beancounter.debugMail"] = true,
	["util.beancounter.debugCore"] = true,
	["util.beancounter.debugConfig"] = true,
	["util.beancounter.debugVendor"] = true,
	["util.beancounter.debugBid"] = true,
	["util.beancounter.debugPost"] = true,
	["util.beancounter.debugUpdate"] = true,
	["util.beancounter.debugFrames"] = true,
	["util.beancounter.debugAPI"] = true,
	["util.beancounter.debugSearch"] = true,

	["util.beacounter.invoicetime"] = 5,
	["util.beancounter.mailrecolor"] = "off",
	["util.beancounter.externalSearch"] = true,

	["util.beancounter.hasUnreadMail"] = false,

	--["util.beancounter.dateFormat"] = "%c",
	["dateString"] = "%c",
	
	--Data storage
	["monthstokeepdata"] = 48,
	
	--Color gradient
	["colorizeSearch"] = true,
	["colorizeSearchopacity"] = 0.2,
	
	--Search settings
	["numberofdisplayedsearchs"] = 500,

	--GUI column default widths
	["columnwidth.".._BC('UiNameHeader')] = 120,
	["columnwidth.".._BC('UiTransactions')] = 100,
	["columnwidth.".._BC('UiBidTransaction')] = 60,
	["columnwidth.".._BC('UiBuyTransaction')] = 60,
	["columnwidth.".._BC('UiNetHeader')] = 65,
	["columnwidth.".._BC('UiQuantityHeader')] = 40,
	["columnwidth.".._BC('UiPriceper')] = 70,

	["columnwidth.".."|CFFFFFF00"..Seller.."/|CFF4CE5CC"..Buyer] = 90,

	["columnwidth.".._BC('UiDepositTransaction')] = 58,
	["columnwidth.".._BC('UiPriceper')] = 50,
	["columnwidth.".._BC("UiFee")] = 70,
	["columnwidth.".._BC('UiReason')] = 70,
	["columnwidth.".._BC('UiDateHeader')] = 250,
	["ModTTShow"] = false,
    }

local function getDefault(setting)
	local a,b,c = strsplit(".", setting)

	-- basic settings
	if (a == "show") then return true end
	if (b == "enable") then return true end

	-- lookup the simple settings
	local result = private.settingDefaults[setting];

	return result
end

function lib.GetDefault(setting)
	local val = getDefault(setting);
	return val;
end
local tbl = {}
local function setter(setting, value)
	if (not settings) then settings = BeanCounterDB["settings"] end
	-- turn value into a canonical true or false
	if value == 'on' then
		value = true
	elseif value == 'off' then
		value = false
	end

	-- for defaults, just remove the value and it'll fall through
	if (value == 'default') or (value == getDefault(setting)) then
		-- Don't save default values
		value = nil
	end

	--button to check database integrity pushed
	if (setting == "database.validate") then
		print("Checking")
		private.integrityCheck(true)
		value = nil
	elseif (setting == "database.sort") then
		private.sortArrayByDate()
		value = time()
	
	--settings for gui
	elseif (setting ==  "monthstokeepdata") then
		local text = format("Enable purging transactions older than %s months from the database. \nYou must hold the SHIFT key to check this box since this will DELETE data.", gui.elements.monthstokeepdata:GetValue()/100 or 48)
		gui.elements.oldDataExpireEnabled.textEl:SetText(text)
		
		--Always uncheck and set valure to off when they change the slider value as a safety precaution
		local db = getUserProfile()
		db["oldDataExpireEnabled"] = false
		gui.elements.oldDataExpireEnabled:SetChecked(false)
	elseif (setting ==  "oldDataExpireEnabled") and value then
		if not IsShiftKeyDown() then --We wont allow the user to check this box unless shift key is down
			print("You will need to hold down the SHIFT key to check this box")
			lib.SetSetting("oldDataExpireEnabled", false)
			return
		end 
	end
	
	
	--This is used to do the DateString
	local a,b = strsplit(".", setting)
	if (a == "dateString") then --used to update the Config GUI when a user enters a new date string
		if not value then value = "%c" end
		tbl = {}
		for w in string.gmatch(value, "%%(.)" ) do --look for the date commands prefaced by %
			tinsert(tbl, w)
		end

		local valid, invalid = {['a']= 1,['A'] =1,['b'] =1,['B'] =1,['c']=1,['d']=1,['H']=1,['I']=1,['m']=1,['M']=1,['p']=1,['S']=1,['U']=1,['w']=1,['x']=1,['X']=1,['y']=1,['Y']=1} --valid date commands

		for i,v in pairs(tbl) do
			 if not valid[v] then  invalid = v break end
		end
		if invalid then print("Invalid Date Format", "%"..invalid)  return end --Prevent processing if we have an invalid command

		local text = gui.elements.dateString:GetText()
		gui.elements.dateStringdisplay.textEl:SetText(_BC('C_DateStringExample').." "..date(text, 1196303661))
	end

	--[[Check for profile changes or store settings ]]

	if (a == "profile") then
		if (setting == "profile.save") then
			value = gui.elements["profile.name"]:GetText()

			-- Create the new profile
			settings["profile."..value] = {}

			-- Set the current profile to the new profile
			settings[getUserSig()] = value
			-- Get the new current profile
			local newProfile = getUserProfile()

			-- Clean it out and then resave all data
			cleanse(newProfile)
			gui:Resave()

			-- Add the new profile to the profiles list
			local profiles = settings["profiles"]
			if (not profiles) then
				profiles = { "Default" }
				settings["profiles"] = profiles
			end

			-- Check to see if it already exists
			local found = false
			for pos, name in ipairs(profiles) do
				if (name == value) then found = true end
			end

			-- If not, add it and then sort it
			if (not found) then
				table.insert(profiles, value)
				table.sort(profiles)
			end

			print("ChatSavedProfile",value)

		elseif (setting == "profile.delete") then
			-- User clicked the Delete button, see what the select box's value is.
			value = gui.elements["profile"].value

			-- If there's a profile name supplied
			if (value) then
				-- Clean it's profile container of values
				cleanse(settings["profile."..value])

				-- Delete it's profile container
				settings["profile."..value] = nil

				-- Find it's entry in the profiles list
				local profiles = settings["profiles"]
				if (profiles) then
					for pos, name in ipairs(profiles) do
						-- If this is it, then extract it
						if (name == value and name ~= "Default") then
							table.remove(profiles, pos)
						end
					end
				end

				-- If the user was using this one, then move them to Default
				if (getUserProfileName() == value) then
					settings[getUserSig()] = 'Default'
				end

				print("ChatDeletedProfile",value)

			end

		elseif (setting == "profile.default") then
			-- User clicked the reset settings button

			-- Get the current profile from the select box
			value = gui.elements["profile"].value

			-- Clean it's profile container of values
			settings["profile."..value] = {}

			print("ChatResetProfile",value)

		elseif (setting == "profile") then
			-- User selected a different value in the select box, get it
			value = gui.elements["profile"].value

			-- Change the user's current profile to this new one
			settings[getUserSig()] = value

			print("ChatUsingProfile",value)

		end

		-- Refresh all values to reflect current data
		gui:Refresh()
	else
		-- Set the value for this setting in the current profile
		local db = getUserProfile()
		db[setting] = value
		--setUpdated()
	end

end

function lib.SetSetting(...)
	setter(...)
	if (gui) then
		gui:Refresh()
	end
end

local function getter(setting)
	if (not settings) then settings = BeanCounterDB["settings"] end
	if not setting then return end

	local a,b,c = strsplit(".", setting)
	if (a == 'profile') then
		if (b == 'profiles') then
			local pList = settings["profiles"]
			if (not pList) then
				pList = { "Default" }
			end
			return pList
		end
	end

	
	
	if (setting == 'profile') then
		return getUserProfileName()
	end
	local db = getUserProfile()
	if ( db[setting] ~= nil ) then
		return db[setting]
	else
		return getDefault(setting)
	end
end

function lib.GetSetting(setting, default)
	local option = getter(setting)
	if ( option ~= nil ) then
		return option
	else
		return default
	end
end
local _, _, get, set, _ = lib.getLocals()--now we can set our get, set locals to the above functions
private.setter = setter
private.getter = getter
function lib.MakeGuiConfig()
	if gui then return end

	local id
	local Configator = LibStub:GetLibrary("Configator")
	gui = Configator:Create(setter, getter)

	lib.Gui = gui

  	gui:AddCat("BeanCounter")

	id = gui:AddTab(_BC('C_BeanCounterConfig')) --"BeanCounter Config")
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    _BC('C_BeanCounterOptions')) --"BeanCounter options")
	gui:AddControl(id, "Checkbox", 0 , 1, "ModTTShow", _BC('C_ModTTShow'))--Only show extra tooltip if Alt is pressed.
	gui:AddTip(id, _BC('TTModTTShow'))--This option will display BeanCounter's extra tooltip only if Alt is pressed.
	gui:AddControl(id, "Checkbox",   0, 1, "util.beancounter.displaybeginerTooltips", _BC('C_ShowBeginnerTooltips'))--"Show beginner tooltips on mouse over"
	gui:AddTip(id, _BC('TTShowBeginnerTooltips')) --Turns on the beginner tooltips that display on mouse eover

	gui:AddControl(id, "Checkbox",   0, 1, "util.beancounter.displayReasonCodeTooltip", _BC('C_ShowReasonPurchase'))--Show reason for purchase in the games Tooltips
	gui:AddTip(id, _BC('TTShowReasonPurchase'))--Turns on the SearchUI reason an item was purchased for in the tooltip

	gui:AddControl(id, "Checkbox",   0, 1, "util.beancounter.externalSearch", _BC('C_ExtenalSearch')) --"Allow External Addons to use BeanCounter's Search?")
	gui:AddTip(id, _BC('TTExtenalSearch')) --"When entering a search in another addon, BeanCounter will also display a search for that item.")
	
	gui:AddControl(id, "Checkbox",   0, 1, "sendSearchBrowseFrame", _BC('C_SendToSearch')) --Add BeanCounter's searched item to the Main Auction House Window?
	gui:AddTip(id, _BC('TT_SendToSearch')) --"When entering a search in BeanCounter it will also add the string to the AH browse frame.

	gui:AddControl(id, "Note",       0, 1, nil, nil, " ")
	gui:AddControl(id, "WideSlider", 0, 1, "util.beacounter.invoicetime",    1, 20, 1, _BC('C_MailInvoiceTimeout')) --"Mail Invoice Timeout = %d seconds")
	gui:AddTip(id, _BC('TTMailInvoiceTimeout')) --Chooses how long BeanCounter will attempt to get a mail invoice from the server before giving up. Lower == quicker but more chance of missing data, Higher == slower but improves chances of getting data if the Mail server is extremely busy.

	gui:AddControl(id, "Subhead",    0,    _BC('C_MailRecolor')) --"Mail Re-Color Method")
	gui:AddControl(id, "Selectbox",  0, 1, {{"off",_BC("NoRe-Color")},{"icon",_BC("Re-ColorIcons")},{"both",_BC("Re-ColorIconsandText")},{"text",_BC("Re-ColorText")}}, "util.beancounter.mailrecolor", _BC("MailRe-ColorMethod"))
	gui:AddTip(id, _BC('TTMailRecolor')) --"Choose how Mail will appear after BeanCounter has scanned the Mail Box")

	gui:AddControl(id, "Text",       0, 1, "dateString", "|CCFFFCC00".._BC('C_DateString')) --"|CCFFFCC00Date format to use:")
	gui:AddTip(id, _BC('TTDateString'))--"Enter the format that you would like your date field to show. Default is %c")
	gui:AddControl(id, "Checkbox",   0, 1, "dateStringdisplay", "|CCFFFCC00".._BC('C_DateStringExample').." 11/28/07 21:34:21") --"|CCFFFCC00Example Date: 11/28/07 21:34:21")
	gui:AddTip(id, _BC('TTDateStringExample'))--"Displays an example of what your formated date will look like")

	gui:AddControl(id, "Note", 0, 1, nil, nil, " ")
	gui:AddControl(id, "Checkbox",   0, 1, "colorizeSearch", _BC('C_ColorizeSearch'))--Add a gradient color to each result in the search window
	gui:AddTip(id, _BC('TT_ColorizeSearch'))--This option changes the color of the items lines in the BeanCounter search window.

	gui:AddControl(id, "NumeriSlider", 0, 3, "colorizeSearchopacity",    0, 1, 0.1,  _BC('C_OpacityLevel')) --Opacity level
	gui:AddTip(id,  _BC('TT_OpacityLevel')) --This controls the level of opacity for the colored bars in the BeanCounter search window (if enabled)

	
	gui:AddControl(id, "Subhead",     0,    _BC('C_SearchConfiguration')) --Search Configuration
	
	gui:AddControl(id, "NumeriSlider", 0, 1, "numberofdisplayedsearchs",    500, 5000, 250,  _BC('C_MaxDisplayedResults')) --Max displayed search results (from each database)
	gui:AddTip(id, _BC('TT_MaxDisplayedResults')) --This controls the total number of results displayed in the scroll frame.
	
	gui:AddHelp(id, "what is invoice",
		_BC('Q_MailInvoiceTimeout'), --"What is Mail Invoice Timeout?",
		_BC('A_MailInvoiceTimeout') --"The length of time BeanCounter will wait on the server to respond to an invoice request. A invoice is the who, what, how of an Auction house mail"
		)
	gui:AddHelp(id, "what is recolor",
		_BC('Q_MailRecolor'), --"What is Mail Re-Color Method?",
		_BC('A_MailRecolor') --"BeanCounter reads all mail from the Auction House, This option tells Beancounter how the user want's to Recolor the messages to make them look unread."
		)
	gui:AddHelp(id, "what is tooltip",
		_BC('Q_BeanCountersTooltip'),--What is BeanCounters Tooltip
		_BC('A_BeanCountersTooltip')--BeanCounter will store the SearchUI reason an item was purchased and display it in the tooltip
		)
	gui:AddHelp(id, "what is external",
		_BC('Q_ExtenalSearch'), --"Allow External Addons to use BeanCounter?",
		_BC('A_ExtenalSearch') --"Other addons can have BeanCounter search for an item to be displayed in BeanCounter's GUI. For example this allows BeanCounter to show what items you are looking at in Appraiser"
		)
	gui:AddHelp(id, "what is date",
		_BC('Q_DateString'), --"Date Format to use?",
		_BC('A_DateString') --"This controls how the Date field of BeanCounter's GUI is shown. Commands are prefaced by % and multiple commands and text can be mixed. For example %a == %X would display Wed == 21:34:21"
		)
	gui:AddHelp(id, "what is date command",
		_BC('Q_DateStringCommands'), --"Acceptable Date Commands?",
		_BC('A_DateStringCommands') --"Commands: \n %a = abr. weekday name, \n %A = weekday name, \n %b = abr. month name, \n %B = month name,\n %c = date and time, \n %d = day of the month (01-31),\n %H = hour (24), \n %I = hour (12),\n %M = minute, \n %m = month,\n %p = am/pm, \n %S = second,\n %U = week number of the year ,\n %w = numerical weekday (0-6),\n %x = date, \n %X = time,\n %Y = full year (2007), \n %y = two-digit year (07)"
		)

	id = gui:AddTab(_BC('C_DataMaintenance')) --"Data Maintenance"
	lib.Id = id
	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    _BC('C_BeanCounterDatabaseMaintenance')) --"BeanCounter Database Maintenance"
	gui:AddControl(id, "Subhead",    0,    _BC('C_Resortascendingtime')) --"Resort all entries by ascending time"
	gui:AddControl(id, "Button",     0, 1, "database.sort", _BC('C_ResortDatabase')) --"Resort Database"
	gui:AddTip(id, _BC('TTResort Database'))--"This will scan Beancounter's Data sort all entries in ascending time order. This helps speed up the database compression functions"

	gui:AddControl(id, "Subhead",    0,    _BC('C_ScanDatabase')) --"Scan Database for errors: Use if you have errors when searching BeanCounter. \n Backup BeanCounter's saved variables before using."
	gui:AddControl(id, "Button",     0, 1, "database.validate", _BC('C_ValidateDatabase')) --"Validate Database"
	gui:AddTip(id, _BC('TTValidateDatabase')) --"This will scan Beancounter's Data and attempt to correct any error it may find. Use if you are getting errors on search"

	gui:AddControl(id, "Subhead",    0,    _BC('C_DatabaseLength')) --"Determines how long BeanCounter will save Auction House Transactions."
	gui:AddControl(id, "Checkbox",   0, 1, "oldDataExpireEnabled", format("Enable purging transactions older than %s months from the database. \nYou must hold the SHIFT key to check this box since this will DELETE data.", get("monthstokeepdata") or 48) )--Enable purging transactions older than %s months from the database. This will DELETE data.
	gui:AddTip(id, _BC('TTDataExpireEnabled'))--Data older than the selected time range will be DELETED
	gui:AddControl(id, "NumeriSlider", 0, 3, "monthstokeepdata",    6, 48 , 2, "How many months of data to keep?")

	id = gui:AddTab("BeanCounter Debug")
	gui:AddControl(id, "Header",     0,    "BeanCounter Debug")
	gui:AddControl(id, "Checkbox",   0, 1, "util.beancounter.debug", "Turn on BeanCounter Debugging.")
	gui:AddControl(id, "Subhead",    0,    "Reports From Specific Modules")

	gui:AddControl(id, "Checkbox",   0, 1, "util.beancounter.debug", "Turn on BeanCounter Debugging text. Dont check unless asked to do so")
	gui:AddControl(id, "Checkbox",   0, 2, "util.beancounter.debugMail", "Mail")
	gui:AddControl(id, "Checkbox",   0, 2, "util.beancounter.debugCore", "Core")
	gui:AddControl(id, "Checkbox",   0, 2, "util.beancounter.debugConfig", "Config")
	gui:AddControl(id, "Checkbox",   0, 2, "util.beancounter.debugVendor", "Vendor")
	gui:AddControl(id, "Checkbox",   0, 2, "util.beancounter.debugBid", "Bid")
	gui:AddControl(id, "Checkbox",   0, 2, "util.beancounter.debugPost", "Post")
	gui:AddControl(id, "Checkbox",   0, 2, "util.beancounter.debugUpdate", "Update")
	gui:AddControl(id, "Checkbox",   0, 2, "util.beancounter.debugFrames", "Frames")
	gui:AddControl(id, "Checkbox",   0, 2, "util.beancounter.debugAPI", "API")
	gui:AddControl(id, "Checkbox",   0, 2, "util.beancounter.debugSearch", "Search")
	gui:AddControl(id, "Checkbox",   0, 2, "util.beancounter.debugTidyUp", "TidyUp")

end
