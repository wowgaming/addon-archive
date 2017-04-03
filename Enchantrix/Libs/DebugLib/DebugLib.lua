--[[
	DebugLib - An embedded library which works as a higher layer for nLog,
	by providing easier usage of debugging features.
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: DebugLib.lua 130 2008-10-11 12:38:07Z Norganna $
	URL: http://auctioneeraddon.com/dl/

	Manual:
		This manual is a basic introduction to this library and gives examples
		about how to use it. For a more detailed description, refer to each
		function's documentation.

		>>>What the library is designed for<<<
		DebugLib is designed to help developers to add structured error handling
		to their code. That is being done by providing developers with three
		new functions: DebugPrint(), Assert() and Dump().
		The library was designed with the idea in mind that each function
		returns two new error values: An error code and a descriptive error
		message. These two additional values could then be used by the caller to
		check and, in case an error occured, handle the function's outcome.

		Even if the developer does not use this feature, each error will be
		recorded using nLog. The benefit of DebugLib is that it's working even
		without nLog being installed at all (which is most likely the case for
		any user of your addon, since he does not want being bothered with
		having to install a debug addon, he does not need at all).
		On the other side developers can install nLog and at once have access to
		all the debug messages without having to change anything in the code.
		If you want to know more about nLog, please refer to the nLog
		documentation and www.auctioneeraddon.com.

		>>>Installation Requirements<<<
		Any addon which uses debugLib should add nLog as an optional dependancy.
		That way it is made sure that nLog is being loaded before debugLib is so
		debugLib's initialization code works as intended.

		>>>Integrating the Template Functions in an Addon<<<
		This library provides 2 template functions. These are designed to get
		local counterparts in an addon and should not be used directly.
		Instead the suggestion is to define local functions in your addon equal
		to the following reference implementation:

		METHOD 1:
			local addonName = "MyAddon"
			local DebugLib = LibStub("DebugLib")

			local function debugPrint(message, category, title, errorCode, level, ...)
				return DebugLib.DebugPrint(addonName, message, category, title, errorCode, level, ...)
			end

			local function assert(test, ...)
				return DebugLib.Assert(addonName, test, ...)
			end

		METHOD 2:
			local DebugLib = LibStub("DebugLib")
			local debug, assert = DebugLib("MyAddon")

			debug(message, category, title, errorCode, level, ...)
			assert(test, ...)

		Refer to the assert() and debugPrint() functions in this file to see a
		more detailed example.

		>>>Common Syntax/Usage of Main Functions<<<
		There are 3 main functions provided by this library:
		DebugLib.DebugPrint(), DebugLib.Assert() and DebugLib.Dump()
		The following examples show how these functions could be used in your own
		addon. For these examples it is expected that your addon provides the
		local counterparts for DebugLib.DebugPrint() and DebugLib.Assert() as
		described above.

			debugPrint("An error occured while processing the data.",
			           "data processor", 5)
			This is the normal usage for defined errors using debugPrint.

			debugPrint("Defaulting the parameters...",
			           "scan", "Defaulting", DebugLib.Level.Notice)
			This generates a notice message.

			assert(v < 5, "The given value is too big.")
			Simple usage of the assert function.

			debugPrint("Corrupt tempTable: "..DebugLib.Dump(tempTable),
			           "general", 5)
			Creating an error message and dumping the content of a table.

			if type(a) == "string" then
				return debugPrint("The given parameter must not be a string.",
				                  "testPattern()", 22)
			end
			This demonstrates the usage debugPrints()'s return value. In this case
			the function returns 22, "The given parameter must not be a string."
			which the calling function can use to handle the error.

			if not assert(isValidParameter(a1), "a1 is invalid abording...") then
				return
			end
			Example usage of the assert return value.

		For a more detailed description of possible syntaxes for these functions
		refer to the specific function's description.

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
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]

local LIBRARY_VERSION_MAJOR = "DebugLib"
local LIBRARY_VERSION_MINOR = 1

--[[-----------------------------------------------------------------

LibStub is a simple versioning stub meant for use in Libraries.
See <http://www.wowwiki.com/LibStub> for more info.
LibStub is hereby placed in the Public Domain.
Credits:
    Kaelten, Cladhaire, ckknight, Mikk, Ammo, Nevcairiel, joshborke

--]]-----------------------------------------------------------------
do
	local LIBSTUB_MAJOR, LIBSTUB_MINOR = "LibStub", 2
	local LibStub = _G[LIBSTUB_MAJOR]

	if not LibStub or LibStub.minor < LIBSTUB_MINOR then
		LibStub = LibStub or {libs = {}, minors = {} }
		_G[LIBSTUB_MAJOR] = LibStub
		LibStub.minor = LIBSTUB_MINOR

		function LibStub:NewLibrary(major, minor)
			assert(type(major) == "string", "Bad argument #2 to `NewLibrary' (string expected)")
			minor = assert(tonumber(strmatch(minor, "%d+")), "Minor version must either be a number or contain a number.")

			local oldminor = self.minors[major]
			if oldminor and oldminor >= minor then return nil end
			self.minors[major], self.libs[major] = minor, self.libs[major] or {}
			return self.libs[major], oldminor
		end

		function LibStub:GetLibrary(major, silent)
			if not self.libs[major] and not silent then
				error(("Cannot find a library instance of %q."):format(tostring(major)), 2)
			end
			return self.libs[major], self.minors[major]
		end

		function LibStub:IterateLibraries() return pairs(self.libs) end
		setmetatable(LibStub, { __call = LibStub.GetLibrary })
	end
end
--[End of LibStub]---------------------------------------------------

local lib = LibStub:NewLibrary(LIBRARY_VERSION_MAJOR, LIBRARY_VERSION_MINOR)
if not lib then return end

LibStub("LibRevision"):Set("$URL: http://svn.norganna.org/libs/tags/5.8/DebugLib/DebugLib.lua $","$Rev: 130 $","5.1.DEV.", 'auctioneer', 'libs')

if not lib.private then
	lib.private = {}
end
local private = lib.private

local debug

-------------------------------------------------------------------------------
-- Error Codes
-------------------------------------------------------------------------------
-- 1 = invalid argument (at least one of the arguments passed to the function
--                       is invalid)

-------------------------------------------------------------------------------
-- Enumerations
-------------------------------------------------------------------------------
-- Lookup list of all nLog levels. It should correspond with the list in nLog.
if not nLog then
	private.levelLookupList = {
		["Critical"] = 1,
		["Error"]    = 2,
		["Warning"]  = 3,
		["Notice"]   = 4,
		["Info"]     = 5,
		["Debug"]    = 6
	}
else
	-- if nLog exists, we can use its list to make 100% sure, that the content
	-- is the same
	private.levelLookupList = {}
	for index, levelString in ipairs(nLog.levels) do
		private.levelLookupList[levelString] = index
	end
end

-- The different supported debug levels.
private.levelList = {
	-- Critical = "Critical",
	-- Error    = "Error",
	-- Warning  = "Warning",
	-- Notice   = "Notice",
	-- Info     = "Info",
	-- Debug    = "Debug"
}
for stringLevel in pairs(private.levelLookupList) do
	private.levelList[stringLevel] = stringLevel
end

lib.Level = private.levelList


-- these variables are to limit the dump() function to prevent crashes, hour long waits, etc.

-- Complex tables will cause dump() to overflow the stack, and trigger a Lua error
-- so we limit recursion
private.dumpCurrentRecursionDepth = 0
private.dumpRecursionLimit = 20

-- Sometimes, the output string gets so large that it crashes WoW
-- so we need to stop the string before it gets too large
private.dumpStringLimit = 4*1024*1024

-- And we need to limit the length of tables dumped to prevent WoW from spinning it's wheels
private.dumpTableLengthLimit = 100


-------------------------------------------------------------------------------
-- Function definitions
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Prints the specified message to nLog.
-- This is the version used for lib.DebugPrint, if nLog is installed and
-- enabled.
--
-- syntax:
--    errorCode, message = lib.DebugPrint(addon[, message][, category][, title][, errorCode][, level] |
--                                       addon, message, category, title, errorCode, level, ...)
--
-- parameters:
--    addon     - (string) the name of the addon
--    message   - (string) the error message
--                nil, no error message specified
--    category  - (string) the category of the debug message
--                nil, no category specified
--    title     - (string) the title for the debug message
--                nil, no title specified
--    errorCode - (number) the error code
--                nil, no error code specified
--    level     - (string) nLog message level
--                         Any nLog.levels string is valid.
--                nil, no level specified
--    ...       - (any) additional data which will be appended to the error
--                      message in nLog
--
-- returns:
--    errorCode - (number) errorCode, if one is specified
--                nil, otherwise
--    message   - (string) message, if one is specified
--                nil, otherwise
--
-- remarks:
--    >>>EXAMPLES<<<
--    Here are examples of all valid syntaxes for this function. The list is
--    ordered by how common the usage of the specific syntax is.
--       1) Common usage to quickly create debug messages in your working copy:
--          lib.DebugPrint("DebugLib", "Entered the function.")
--          This results in the message being written as a debug message to
--          nLog and, if enabled in nLog, to the chat channel as well. These
--          message types are normally used for local debugging, only.
--
--       2) Complete specified error entry with default title:
--          lib.DebugPrint("DebugLib", "Error while processing the frame.",
--                        "UI", 6)
--          This is the preferred syntax for specifying errors, if you don't
--          want to specify your own title.
--
--       3) Complete specified error entry with specified title:
--          lib.DebugPrint("DebugLib", "Error while processing the frame.",
--                        "UI", "Process error", 6)
--          This is the preferred syntax for specifying errors, if you want to
--          specify your own title.
--
--       4) Complete specified debug warning entry with a title:
--          lib.DebugPrint("DebugLib", "Entering failsafe mode.", "Backend",
--                        "Failsafe", DebugLib.Level.Warning)
--          This is the preferred syntax for any message type except errors.
--
--       5) Complete specified debug warning entry with default title:
--          lib.DebugPrint("DebugLib", "Entering failsafe mode.", "Backend",
--                        DebugLib.Level.Warning)
--          This is another syntax for any message type except errors, though
--          this time the default title is used.
--
--       6) Fully specified debug message with default title:
--          lib.DebugPrint("DebugLib", "Critical error in function call.",
--                        "Scan", 6, DebugLib.Level.Critical)
--          This is the full syntax except the title is missing. It is the
--          suggested syntax for specifying log entries which return error
--          codes, have a different level than DebugLib.Level.Error and do not
--          need their own title.
--
--       7) Fully specified debug message:
--          lib.DebugPrint("DebugLib", "Critical error in function call.",
--                        "Scan", "Invalid function call", 6,
--                        DebugLib.Level.Critical)
--          This is the full syntax. It is the suggested syntax for specifying
--          log entries which return error codes, have a different level than
--          DebugLib.Level.Error and require their own title.
--
--       8) Fully specified debug message with additional output data:
--          lib.DebugPrint("DebugLib", "Critical error in function call.",
--                        "Scan", "Invalid function call", 6,
--                        DebugLib.Level.Critical,
--                        "table = ", table1,
--                        "variable = ", variable1)
--          This is the full syntax including additional data for the generated
--          message. It is the suggested syntax for specifying log entries, if
--          the developer wants to dump additional variables to the generated
--          error message.
--          Note, that the additional data will only be added to the message
--          displayed within nLog. It will not be appended to the error message
--          which is returned by debugPrint(). If you want the additional
--          data to also be included in the function's return value, generate
--          the message yourself first and then pass it to debugPrint() using
--          syntax style no 7. For instance:
--          Instead of using:
--          DebugPrint("DebugLib", "Message", [...], "variable1=", variable1)
--          use the following method:
--          DebugPrint("DebugLib", "Message".." variable1="..DebugLib.Dump(variable1))
--
--       9) Quick specified error entry, with only basic information:
--          lib.DebugPrint("DebugLib", "Failed to read data.", 5)
--          This creates a new error entry in nLog. This syntax can be used, if
--          you have to add this message quickly but don't want to specify the
--          category yet.
--
--      10) Quick specified debug entry, with only basic information:
--          lib.DebugPrint("DebugLib", "Executing unsafe code.",
--                        DebugLib.Level.Notice)
--          This creates a new notice entry in nLog. It's basically used, if
--          you have to quickly add some debug information but don't want to
--          specify the category yet.
--
--       11) Partly specified error entry:
--           lib.DebugPrint("DebugLib", "Fatal error in command handler.", 9,
--                         DebugLib.Level.Critical)
--           This syntax is possible, but quite uncommon. Instead of using this,
--           one should prefer the fully specified debug message.
--           It generates a new log entry for critical errors with no category.
--
--       12) Empty log entry:
--           lib.DebugPrint("DebugLib")
--           This unusual usage will generate an empty debug log entry in nLog.
--
--       13) Empty log entry with defined log level:
--           lib.DebugPrint("DebugLib", DebugLib.Level.Info)
--           Though valid, this syntax is also not very common. It creates an
--           empty notice in nLog.
--
--    >>>SPECIAL FUNCTION HANDLING<<<
--    Since the level parameter is a string representation, be aware of how the
--    function handles the following ambiguous calls.
--
--       Second, third or fourth parameter is a string found in DebugLib.Level:
--          lib.DebugPrint("DebugLib", "Error")
--          This will be interpreted as a type 12 syntax.
--          message  = nil
--          category = "unspecified"
--          title    = "Errorcode: unspecified"
--          level    = DebugLib.Level.Error
--
--          lib.DebugPrint("DebugLib", "Ambiguous call.", "Warning")
--          This will be interpreted as a type 9 syntax.
--          message  = "Ambiguous call."
--          category = "unspecified"
--          title    = "Warning"
--          level    = DebugLib.Level.Warning
--
--          >>lib.DebugPrint("DebugLib", "Error occured.", "Invalid function call.", "Critical")
--          This will be interpreted as a type 5 syntax.
--          message  = "Error occured."
--          category = "Invalid functioncall."
--          title    = "Errorcode: unspecified"
--          level    = DebugLib.Level.Critical
--
--       Two out of the second, third and fourth parameters are strings found in
--       DebugLib.Level:
--          lib.DebugPrint("DebugLib", "Warning", "Notice")
--          This will be interpreted as a type 9 syntax.
--          message  = "Warning"
--          category = "unspecified"
--          title    = "Notice"
--          level    = DebugLib.Level.Notice
--
--          lib.DebugPrint("DebugLib", "Info", "Engine", "Warning")
--          This will be interpreted as a type 5 syntax.
--          message  = "Info"
--          category = "Engine"
--          title    = "Warning"
--          level    = DebugLib.Level.Warning
--
--          lib.DebugPrint("DebugLib", "Invalid type", "Error", "Critical")
--          This will be interpreted as a type 5 syntax.
--          message  = "Invalid type"
--          category = "Error"
--          title    = "Errorcode: unspecified"
--          level    = DebugLib.Level.Critical
--
--       Second and/or third and/or fourth and fifth parameter are strings found
--       in DebugLib.Level:
--          lib.DebugPrint("DebugLib", "Warning", "Debug", "Error", "Critical")
--          This will be interpreted as a type 4 syntax.
--          message  = "Warning"
--          category = "Debug"
--          title    = "Error"
--          level    = DebugLib.Level.Critical
--
--    >>>OPTIONAL PARAMETERS<<<
--    The examples above show all allowed syntaxes for this function and
--    explain the outcome. The following is a more code driven explanation of
--    what the default behaviour is, if one or more of the optional parameters
--    are missing.
--
--    category:
--    If no category is specified, the generated nLog message will print
--    "unspecified" as the category.
--
--    level:
--    If no level and no error code is specified, the level will be defaulting
--    to DebugLib.Level.Debug.
--    If no level is specified but an error code is given, the level will be
--    defaulting to DebugLib.Level.Error.
--
--    title:
--    If no title is specified it will be automatically generated based on the
--    errorCode and level.
--    If an errorCode is specified, the title says: "Errorcode: x".
--    If no errorCode is present and the level is either
--    DebugLib.Level.Critical or DebugLib.Level.Error, then the title says:
--    "Errorcode: unspecified".
--    If no errorCode is given and the level is neither DebugLib.Level.Critical
--    nor DebugLib.Level.Error, the title is the same as the level (for
--    instance: "Notice").
--
--    >>>ERROR HANDLING<<<
--    If any error occurs, the error will be written to nLog, if nLog is
--    enabled. Whether or not nLog is installed, processing the debug
--    message will continue.
--    To continue processing, invalid parameters will be ignored and in cases
--    of invalid ambiguous function calls, a decision is made about which value
--    will be used. The generated error message in nLog will explain, what was
--    wrong.
--    For a list of possible errorcodes, refer to the "Error Codes" section.
--
--    >>>TEMPLATE FUNCTION<<<
--    This function is not designed to be called directly. Instead it is meant
--    to have a local counterpart in each file, which automatically specifies
--    the addon parameter and then calls this function.
--    Refer to the local debugPrint() function for the reference implementation.
-------------------------------------------------------------------------------
function lib.DebugPrint(addon, message, category, title, errorCode, level, ...)
	addon, message, category, title, errorCode, level = private.normalizeParameters(addon, message, category, title, errorCode, level)

	if not nLog then return end

	-- nLog.AddMessage() uses select() to check if any message is there.
	-- Since select() will count even passed nil values, nLog would create "NIL"
	-- as the message rather than an empty string. Therefore we need to take
	-- care of this behavior and handle it by ourself.
	local textMessage = message or ""

	nLog.AddMessage(addon, category, private.levelLookupList[level], title, textMessage, ...)

	-- We explicitly do not append any additional passed data to the returned
	-- errormessage.
	-- Doing so, would require us to call the dump/format functions for each
	-- vararg parameter, causing a big performance loss, which is normally
	-- unwanted.
	-- If the developer wants the additional data to be added to the returned
	-- errormessage, he'd have to concatenate it first and instead of adding
	-- each single variable to the function's parameter list, pass the
	-- concatenated string right into the message parameter.
	return errorCode, message
end



-------------------------------------------------------------------------------
-- Prints the specified message to nLog.
-- This is the version used for lib.DebugPrintQuick, if nLog is installed and
-- enabled.
--
-- syntax:
--    errorCode, message = lib.DebugPrintQuick(...)
--
-- parameters:
--    ...       - (any) data which will be appended to the error
--                      message in nLog
--
-- returns:
--    nothing
--
-------------------------------------------------------------------------------
function lib.DebugPrintQuick(...)
	if not nLog then return end
	nLog.AddSimpleMessage(...)
end


-------------------------------------------------------------------------------
-- The function does not do anything but processing the parameters and returning
-- the errorCode and message.
-- This is the version used for lib.DebugPrint, if nLog is not installed or
-- disabled.
--
-- syntax:
--    errorCode, message = lib.SimpleDebugPrint(addon[, message][, category][, title][, errorCode][, level] |
--                                             addon, message, category, title, errorCode, level, ...)
--
-- parameters:
--    addon     - (string) the name of the addon
--    message   - (string) the error message
--                nil, no error message specified
--    category  - (string) the category of the debug message
--                nil, no category specified
--    title     - (string) the title for the debug message
--                nil, no title specified
--    errorCode - (number) the error code
--                nil, no error code specified
--    level     - (string) nLog message level
--                         Any nLog.levels string is valid.
--                nil, no level specified
--    ...       - (any) additional data which will be appended to the error
--                      message in nLog
--
-- returns:
--    errorCode - (number) errorCode, if one is specified
--                nil, otherwise
--    message   - (string) message, if one is specified
--                nil, otherwise
--
-- remarks:
--    Refer to the description of lib.DebugPrint() to see a more detailed
--    explanation about this function.
-------------------------------------------------------------------------------
function lib.SimpleDebugPrint(addon, message, category, title, errorCode, level, ...)
	_, message, _, _, errorCode = private.normalizeParameters(addon, message, category, title, errorCode, level)

	return errorCode, message
end


-------------------------------------------------------------------------------
-- The function does not do anything.
-- This is the version used for lib.DebugPrintQuick, if nLog is not installed or
-- disabled.
--
-- syntax:
--    errorCode, message = lib.SimpleDebugPrintQuick(...)
--
-- parameters:
--    ...       - (any) data which will be appended to the error
--                      message in nLog
--
-- returns:
--    nothing
--
-------------------------------------------------------------------------------
function lib.SimpleDebugPrintQuick(...)
end


-------------------------------------------------------------------------------
-- Analyses and rearanges the given parameters, if necessary. Any invalidity
-- will cause a debug message, but the function will continue by automatically
-- handling these cases.
--
-- syntax:
--    addon, message, category, title, errorCode, level = normalizeParameter(addon[, message][, category][, title][, errorCode][, level])
--
-- parameters:
--    addon     - (string) the name of the addon
--    message   - (string) the error message
--                nil, no error message specified
--    category  - (string) the category of the debug message
--                nil, no category specified
--    title     - (string) the title for the debug message
--                nil, no title specified
--    errorCode - (number) the error code
--                nil, no error code specified
--    level     - (string) nLog message level
--                         Any nLog.levels string is valid.
--                nil, no level specified
--
-- returns:
--    addon     - (string) the name of the addon
--                "unspecified", if there was no addon name
--    message   - (string) message, if one is specified
--                nil, otherwise
--    title     - (string) the title for the debug message
--    category  - (string) category
--                "unspecified", if no valid category was specified
--    errorCode - (number) error code
--                nil, if no valid error code was specified
--    level     - (string) debug level
--                   One of the levelList values.
--
-- remarks:
--    This is a helper function for lib.DebugPrint and manages its complex
--    syntax by correctly ordering and handling the specified parameters.
--    Refer to the documentation about lib.DebugPrint() to read in detail how
--    the parameter list is handled.
-------------------------------------------------------------------------------
function private.normalizeParameters(addon, message, category, title, errorCode, level)
	-- return values
	local retAddon, retMessage, retCategory, retTitle, retErrorCode, retLevel

	-- process the addon parameter
	if addon == nil then
		-- addon is not defined
		debug("No addon specified! Defaulting to \"unspecified\" and continue with processing the debug message.",
		           "debug",
		           1)
	elseif type(addon) ~= "string" then
		-- addon is of an invalid type
		debug("Invalid addon parameter! The type "..type(addon).." is not supported. Defaulting to \"unspecified\" and continue with processing the debug message.",
		           "debug",
		           1)
	else
		-- addon content is valid
		retAddon = addon
	end

	-- process the level parameter
	if level ~= nil then
		-- The level parameter is present. It should contain the level content.
		if type(level) ~= "string" then
			-- It's not a string, therefore it's invalid.
			debug("Invalid level parameter. The type "..type(level).." is not supported.  Removing the value and continue with processing the debug message.",
			           "debug",
			           1)
		else
			-- It's a string and should be one of the valid levels.
			if not isDebugLevel(level) then
				-- It's not one of the valid levels, therefore the content is
				-- invalid.
				debug("Invalid level parameter. The given string is no valid debug level. Removing the value and continue with processing the debug message.",
				           "debug",
				           1)
			else
				-- level content is valid
				retLevel = level
			end
		end
	end

	-- process the errorCode parameter
	if errorCode ~= nil then
		-- The errorCode parameter is present. It should contain either the
		-- errorCode or level content.
		if (type(errorCode) == "string") and (level == nil) then
			-- errorCode could contain the level parameter
			if not isDebugLevel(errorCode) then
				-- It does not contain a valid level, therefore the parameter is
				-- invalid.
				debug("Invalid errorCode parameter. The given string is no valid debug level. Removing the value and continue with processing the debug message.",
				           "debug",
				           1)
			elseif retLevel ~= nil then
				-- ErrorCode contains a valid level parameter, but level parameter
				-- is set, too.
				debug("Multiple level parameters specified. Ignoring the one in errorCode and continue processing the debug message.",
				           "debug",
				           1)
			else
				-- ErrorCode contains the valid level parameter and it's the only
				-- one.
				retLevel = errorCode
			end
		elseif type(errorCode) ~= "number" then
			-- errorCode contains an invalid parameter
			debug("Invalid errorCode type. The type "..type(errorCode).." is not supported. Removing the value and continue with processing the debug message.",
			           "debug",
			           1)
		else
			-- errorCode content is valid
			retErrorCode = errorCode
		end
	end

	-- process the title parameter
	if title ~= nil then
		-- The title parameter is present. It should contain either the
		-- title, errorCode or level content.
		if (type(title) == "number") and (level == nil) then
			-- It's the error code. Make sure that it's the only one.
			if retErrorCode then
				-- errorCode is already present, ignore the one in title
				debug("Multiple error codes specified! Ignoring the one in title and continue processing the debug message.",
				           "debug",
				           1)
			else
				-- we got the error code, so safe it in the right place
				retErrorCode = title
			end
		elseif type(title) ~= "string" then
			-- title contains invalid content
			debug("Invalid title type. The type "..type(title).." is not supported. Removing the value and continue with processing the debug message.",
			           "debug",
			           1)
		else
			-- It's either the title or the level content.
			if (errorCode == nil) and (level == nil) and isDebugLevel(title) then
				-- it's the level content
				retLevel = title
			else
				-- it's the title
				retTitle = title
			end
		end
	end

	-- process the category parameter
	if category ~= nil then
		-- The category parameter is present. It should contain either the
		-- category, errorCode or level content.
		if (type(category) == "number") and (errorCode == nil) and (level == nil) then
			-- It's the error code. Make sure that it's the only one.
			if retErrorCode then
				-- errorCode is already present, ignore the one in category
				debug("Multiple error codes specified! Ignoring the one in category and continue processing the debug message.",
				           "debug",
				           1)
			else
				-- we got the error code, so safe it in the right place
				retErrorCode = category
			end
		elseif type(category) ~= "string" then
			-- category contains invalid content
			debug("Invalid category type. The type "..type(category).." is not supported. Removing the value and continue with processing the debug message.",
			           "debug",
			           1)
		else
			-- It's either the category or the level content.
			if (title == nil) and (errorCode == nil) and (level == nil) and isDebugLevel(category) then
				-- it's the level content
				retLevel = category
			else
				-- it's the category
				retCategory = category
			end
		end
	end

	-- process the message parameter
	if message ~= nil then
		-- The message parameter is present. It should contain either the
		-- message, errorCode or level content.
		if (type(message) == "number") and (title == nil) and (errorCode == nil) and (level == nil) then
			-- It's the error code. Make sure that it's the only one.
			if retErrorCode then
				-- errorCode is already present, ignore the one in message
				debug("Multiple error codes specified! Ignoring the one in message and continue processing the debug message.",
				           "debug",
				           1)
			else
				-- we got the error code, so safe it in the right place
				retErrorCode = message
			end
		elseif type(message) ~= "string" then
			-- message contains invalid content
			debug("Invalid message type. The type "..type(message).." is not supported. Removing the value and continue with processing the debug message.",
			           "debug",
			           1)
		else
			-- It's either the message or the level content.
			if (category == nil) and (title == nil) and (errorCode == nil) and (level == nil) and isDebugLevel(message) then
				-- it's the level content
				retLevel = message
			else
				retMessage = message
			end
		end
	end

	-- defaulting return values, for unspecified ones
	retAddon    = retAddon    or "unspecified"
	retCategory = retCategory or "unspecified"
	if not retLevel then
		if retErrorCode then
			retLevel = private.levelList.Error
		else
			retLevel = private.levelList.Debug
		end
	end
	if not retTitle then
		retTitle = private.generateTitle(retLevel, retErrorCode)
	end

	return retAddon, retMessage, retCategory, retTitle, retErrorCode, retLevel
end

-------------------------------------------------------------------------------
-- Checks the given level to see if it's a valid debug level.
--
-- syntax:
--    validLevel = isDebugLevel(level)
--
-- parameters:
--    level - (string) the level parameter to be checked
--
-- returns:
--    validLevel - (boolean) true, if the level string represents a valid
--                                 debug level
--                           false, otherwise
-------------------------------------------------------------------------------
function isDebugLevel(level)
	if type(level) ~= "string" then
		return false -- it's not a string, so it can't be a valid level
	end

	for _, levelString in pairs(private.levelList) do
		if levelString == level then
			return true -- it's a valid level
		end
	end

	return false -- level is not in the level list, therefore it's invalid
end

-------------------------------------------------------------------------------
-- Takes the debug level and error code and returns a title for the log entry
-- according to these parameters.
--
-- syntax:
--    title = private.generateTitle(level[, errorCode])
--
-- parameters:
--    level     - (string) the debug level
--    errorCode - (number) the error code
--                nil, if no error code is specified
--
-- returns:
--    title - (string) the generated title
--
-- remarks:
--    Refer to the documentation about lib.DebugPrint() to see which titles are
--    generated.
-------------------------------------------------------------------------------
function private.generateTitle(level, errorCode)
	if errorCode then
		return "Errorcode: "..errorCode
	elseif (level == lib.Level.Error) or (level == lib.Level.Critical) then
		return "Errorcode: unspecified"
	else
		return level
	end
end

-------------------------------------------------------------------------------
-- Used to make sure that conditions are met within functions.
-- If test is false, the error message will be written to nLog and the user's
-- default chat channel.
-- This is the version used for lib.Assert, if nLog is installed and
-- enabled.
--
-- syntax:
--    assertion = lib.Assert(addon, test, ...)
--
-- parameters:
--    addon   - (string)  the name of the addon/file used to identify the
--                        specific assertion
--    test    - (any)     false/nil, if the assertion failed
--                        anything else, otherwise
--    ...     - (any)     data which will be appended to the nLog message
--
-- return:
--    assertion - (boolean) true, if the test passed
--                          false, otherwise
--
-- remark:
--    >>>NLOG ENTRY<<<
--    If nLog is present, the message will not only be written to the user's
--    chat channel, but also to nLog with the priority set to N_CRITICAL, since
--    it is assumed that Assert() is only used in critical parts of functions
--    and that test is expected to never fail. This is especially useful to
--    track down bugs which might randomly occure. Therefore this log message is
--    given the highest priority.
--
--    >>>ERROR HANDLING<<<
--    If any error occurs, the error will be written to nLog, if nLog is
--    enabled. Whether or not nLog is installed, processing the debug
--    message will continue.
--    To continue processing, missing parameters will get default values. The
--    generated error message in nLog will explain, what was wrong.
--    For a list of possible errorcodes, refer to the Error Codes section.
--
--    >>>TEMPLATE FUNCTION<<<
--    This function is not designed to be called directly. Instead it is meant
--    to have a local counterpart in each file, which automatically specifies
--    the addon parameter and then calls this function.
--    Refer to the local assert() function for the reference implementation.
-------------------------------------------------------------------------------
function lib.Assert(addon, test, ...)
	-- validate the parameters
	if type(addon) ~= "string" then
		debug("Invalid addon parameter. Addon must be a string.",
		           "assert",
		           1)
		addon = "unspecified"
	end

	if test then
		return true -- test passed
	end

	local message = private.format(...)

	getglobal("ChatFrame1"):AddMessage(message, 1.0, 0.3, 0.3)

	if nLog then
		nLog.AddMessage(addon, "Assertion", N_CRITICAL, "assertion failed", message)
	end

	return false -- test failed
end


-------------------------------------------------------------------------------
-- Used to make sure that conditions are met within functions.
-- If test is false, the error message will be written to the user's default
-- chat channel.
-- This is the version used for lib.Assert, if nLog is not installed or
-- disabled.
--
-- syntax:
--    assertion = lib.SimpleAssert(addon, test, ...)
--
-- parameters:
--    addon   - (string)  the name of the addon/file used to identify the
--                        specific assertion
--    test    - (any)     false/nil, if the assertion failed
--                        anything else, otherwise
--    ...     - (any)     data which will be appended to the nLog message
--
-- return:
--    assertion - (boolean) true, if the test passed
--                          false, otherwise
--
-- remarks:
--    Refer to the description of lib.Assert() to see a more detailed explanation
--    about this function.
-------------------------------------------------------------------------------
function lib.SimpleAssert(addon, test, ...)
	-- validate the parameters
	if type(addon) ~= "string" then
		debug("Invalid addon parameter. Addon must be a string.",
		           "assert",
		           1)
		addon = "unspecified"
	end

	if test then
		return true -- test passed
	end

	local message = private.format(...)

	getglobal("ChatFrame1"):AddMessage(message, 1.0, 0.3, 0.3)

	return false -- test failed
end

-------------------------------------------------------------------------------
-- Creates a comma-separated string by transforming all parameters into string
-- representations and concatenating these.  Recursion and length limits have
-- been added to prevent crashes and hour long waits for output.
--
-- syntax:
--    concatString = dump(...)
--
-- parameters:
--    ... - (any) parameters which should be added to the string
--
-- returns:
--    concatString - (string) The concatenated string.
--
--    Variables are concatenated the following way:
--    variable type => resulting string
--    [table]       => {[key1] = [value1], [key2] = [value2], ...}
--    [nil]         => NIL
--    [number]      => [number]
--    [string]      => "[string]"
--    [boolean]     => true/false
--    [other]       => TYPE_OF_OTHER??
-------------------------------------------------------------------------------

function private.dump(...)
	if (private.dumpCurrentRecursionDepth >= private.dumpRecursionLimit) then
		return "recursion limit reached"
	end
	private.dumpCurrentRecursionDepth = private.dumpCurrentRecursionDepth + 1
	local out = ""
	local numVarArgs = select("#", ...)
	for i = 1, numVarArgs do
		local d = select(i, ...)
		local t = type(d)
		if (t == "table") then
			out = out .. "{"
			local tableEntryCount = 0
			if (d) then
				for k, v in pairs(d) do
					if (tableEntryCount <= private.dumpTableLengthLimit) then
						if (tableEntryCount > 0) then out = out .. ", " end
						out = out .. private.dump(k)
						out = out .. " = "
						out = out .. private.dump(v)
						if (string.len(out) > private.dumpStringLimit) then
							out = out .. "..."
							break
						end
					end
					tableEntryCount = tableEntryCount + 1
				end
			end
			if (tableEntryCount > private.dumpTableLengthLimit) then
				out = out .. " table was " .. tableEntryCount .. " entries long. "
			end
			out = out .. "}"
		elseif (t == "nil") then
			out = out .. "NIL"
		elseif (t == "number") then
			out = out .. d
		elseif (t == "string") then
			out = out .. "\"" .. d .. "\""
		elseif (t == "boolean") then
			if (d) then
				out = out .. "true"
			else
				out = out .. "false"
			end
		else
			out = out .. t:upper() .. "??"
		end
		if (string.len(out) > private.dumpStringLimit) then
			out = out .. "..."
			break
		end
		if (i < numVarArgs) then out = out .. ", " end
	end

	-- make sure returns come though here, or we won't balance the depth increase above
	private.dumpCurrentRecursionDepth = private.dumpCurrentRecursionDepth - 1
	return out
end
function lib.Dump(...)
	return private.dump(...)
end

-------------------------------------------------------------------------------
-- Transforms all parameters into string representations and concatenates those
-- into a comma separated string (except strings, which are separated by a
-- single space).
--
-- syntax:
--    concatString = format(...)
--
-- parameters:
--    ... - (any) parameters which should be added to the string
--
-- returns:
--    concatString - (string) The concatenated string.
--
-- remark:
--    What makes this function different from the dump() function is how it
--    handles strings. For example:
--    format("str1", " str2") = str1 str2
--    dump("str1", " str2")   = "str1", " str2"
--
-------------------------------------------------------------------------------
function private.format(...)
	local n = select("#", ...)
	local out = ""
	for i = 1, n do
		if i > 1 and out:sub(-1) ~= " " then out = out .. " "; end
		local d = select(i, ...)
		if (type(d) == "string") then
			if (d:sub(1,1) == " ") then
				out = out .. d:sub(2)
			else
				out = out..d;
			end
		else
			out = out..private.dump(d);
		end
	end
	return out
end


--Kit functions
--These are the preferred ways to access the DebugLib functions now.  The lib functions above are maintained for compatibility reasons only.
local kit = {}
if (nLog) then
	function kit:Debug(...)
		return lib.DebugPrint(self.name, ...)
	end
	function kit:Assert(...)
		return lib.Assert(self.name, ...)
	end
	function kit:DebugQuick(...)
		return lib.DebugPrintQuick(...)
	end
else
	function kit:Debug(...)
		return lib.SimpleDebugPrint(self.name, ...)
	end
	function kit:Assert(...)
		return lib.SimpleAssert(self.name, ...)
	end
	function kit:DebugQuick(...)
		return lib.SimpleDebugPrintQuick(...)
	end
end

function kit:Dump(...)
	return private.dump(...)
end

function lib:New(addonName)
	assert(addonName, "Usage: DebugLib(addonName)")
	local debugObj, assertObj, debugQuickObj = {name=addonName}, {name=addonName}, {name=addonName}
	for k,v in pairs(kit) do
		debugObj[k] = v
		assertObj[k] = v
		debugQuickObj[k] = v
	end
	setmetatable(debugObj, { __call = kit.Debug })
	setmetatable(assertObj, { __call = kit.Assert })
	setmetatable(debugQuickObj, { __call = kit.DebugQuick })
	return debugObj, assertObj, debugQuickObj
end
setmetatable(lib, { __call = lib.New })

-- Set our local debug function
debug = lib:New("DebugLib")
