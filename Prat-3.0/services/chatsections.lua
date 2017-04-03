--[[
Name: Prat 3.0 (chatsections.lua)
Revision: $Revision: 79217 $
Author(s): Sylvaanar (sylvanaar@mindspring.com)
Inspired By: Prat 2.0, Prat, and idChat2 by Industrial
Website: http://files.wowace.com/Prat/
Documentation: http://www.wowace.com/wiki/Prat
Forum: http://www.wowace.com/forums/index.php?topic=6243.0
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: Implements the chat string sectioning service
]]

--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local LibStub = LibStub

local setmetatable = setmetatable
local pairs, ipairs = pairs, ipairs
local tinsert, tremove, tconcat = table.insert, table.remove, table.concat
local string = string
local strsub = string.sub 
local strsplit = strsplit
local tonumber, tostring = tonumber, tostring
local strlower, strupper = strlower, strupper
local strlen = strlen
local type = type
local next, wipe = next, wipe

--local function RunOldMessageEventFilters(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
--	local filter = false
--	local chatFilters = _G.ChatFrame_GetMessageEventFilters and _G.ChatFrame_GetMessageEventFilters(event)
--    local newarg1 = arg1
--
--	if chatFilters then
--		for _, filterFunc in next, chatFilters do
--			filter, newarg1 = filterFunc(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
--			if filter then
--				return true
--			end
--			arg1 = newarg1 or arg1
--		end
--	end
--
--    return filter, arg1
--end


-- arg1, filterthisout = RunMessageEventFilters(event, arg1)
local newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12
local function RunMessageEventFilters(frame, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
	local filter = false
	local chatFilters = _G.ChatFrame_GetMessageEventFilters and _G.ChatFrame_GetMessageEventFilters(event)

	if chatFilters then
		for _, filterFunc in next, chatFilters do
			filter, newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12 = 
                    filterFunc(frame, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
			if filter then
				return true
			elseif ( newarg1 ) then
				arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = 
                    newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12
			end
		end
	end

    return filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12
end



-- Isolate the environment
setfenv(1, SVC_NAMESPACE)

--[[ END STANDARD HEADER ]]--


-- This is the structure of the chat message once it is split
-- section delimiters are uppercase inside and lower case outside
-- ie.   cC CHANNEL Cc =  [ channame ]
SplitMessageSrc = {  -- todo, incidicate which module uses which field, and remove unused fields
    PRE = "",

	nN = "",
	CHANLINK = "",
	NN = "",

    cC = "",
        CHANNELNUM = "",
        CC = "",
        CHANNEL = "",
        zZ = "",
            ZONE = "",
        Zz = "",
    Cc = "",

    TYPEPREFIX = "",

	Nn = "",

    fF = "",
        FLAG = "",
    Ff = "",

    pP = "",
        lL = "",  -- link start
        PLAYERLINK= "",
        PLAYERLINKDATA = "",
        LL = "", --  link text start
        PLAYER = "",

        sS = "",
            SERVER = "",
        Ss = "",
        Ll = "",  -- link text end
    Pp = "",

    TYPEPOSTFIX = "",

    mM = "",
        gG = "",
        LANGUAGE = "",
        Gg = "",
        MESSAGE = "",
    Mm = "",

    POST = "",
}

SplitMessageIdx = {
    "PRE",
	"nN",
	"CHANLINK",
	"NN",
    "cC",
        "CHANNELNUM",
        "CC",
        "CHANNEL",
-- Zone is not usually included
--      "zZ",
--          "ZONE",
--      "Zz",

    "Cc",
    "TYPEPREFIX",
	"Nn",

    "fF",
        "FLAG",
    "Ff",
    "pP",
        "lL",
            "PLAYERLINK",
            "PLAYERLINKDATA",
        "LL",
        "PLAYER",
        "sS",
            "SERVER",
        "Ss",
        "Ll",
    "Pp",
    "TYPEPOSTFIX",
    "mM",
        "gG",
        "LANGUAGE",
        "Gg",
        "MESSAGE",
    "Mm",
    "POST",
}

SplitMessage = {}
SplitMessageOrg = {}

SplitMessageOut = {
    MESSAGE = "",
    TYPE = "",
    TARGET = "",
    CHANNEL = "",
    LANGUAGE = "",
}

setmetatable(SplitMessageOrg, { __index=SplitMessageSrc }) 


setmetatable(SplitMessage, { __index=SplitMessageOrg })


do 
	local t = {}
	function BuildChatText(message, index)
	    local index = index or SplitMessageIdx  --todo
	    local s = message
	
	    for k in pairs(t) do
	        t[k] = nil
	    end
	
	    for i,v in ipairs(index) do
            tinsert(t, s[v])
	    end
	
	    return tconcat(t, "")
	end
end

function RegisterMessageItem(itemname, anchorvar, relativepos)
	--[[ RegisterMessageItem:

		API to allow other modules to inject new items into the components
		making up a chat message. Primarily intended to help resolve
		conflicts between modules.

		 - itemname  = name of the variable to be injected

		 - aftervar  = the position in the chat message after which the item
		               will be displayed

		 - relativepos = "before" or "after"
		Leave aftervar blank to position the item at the beginning of the list.

		If you would like to change the item's position in the chat message,
		call :RegisterMessageItem() again with a different value for aftervar.

		Example:
		--------

		The mod Prat_ExampleMod counts the number of times people
		say the word "Example" and you would like to display the count
		for a player before their name in a chat message. Default chat
		message structure contains:

			... cC CHANNEL Cc .. pP PLAYER Pp ...

		This means that the module should use the following:

			RegisterMessageItem('NUMEXAMPLES', 'Cc')

		Which would then alter the structure of chat messages to be:

			.. CHANNEL Cc .. NUMEXAMPLES .. pP PLAYER ...

]]

	local pos = 1

	if SplitMessageSrc[itemname] then
--		ResetSeparators(itemname)

		local oldpos = GetMessageItemIdx(itemname)

		if oldpos ~= 0 then
			tremove(SplitMessageIdx, oldpos)
		end
	end

	if anchorvar then 
		pos = GetMessageItemIdx(anchorvar) + (relativepos == "before" and 0 or 1)
	end

	tinsert(SplitMessageIdx, pos, itemname)
	SplitMessageSrc[itemname] = ""
end


function GetMessageItemIdx(itemname)
	for i, v in ipairs(SplitMessageIdx) do
		if v == itemname then
			return i
		end
	end

	return 0
end


function ClearChatSections(message)
    if message then wipe(message) end
--    for k,v in pairs(message) do
--        message[k] = SplitMessageSrc[k] and nil -- WTF?
--    end
end

local function safestr(s) return s or "" end

function SplitChatMessage(frame, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13 = ...

	ClearChatSections(SplitMessageOrg)
	ClearChatSections(SplitMessage)

	if ( strsub((event or ""), 1, 8) == "CHAT_MSG" ) then
        local type = strsub(event, 10)
        local info = _G.ChatTypeInfo[type]

        local s = SplitMessageOrg

        -- blizzard bug, arg2 (player name) can have an extra space
        if arg2 then
            arg2=arg2:trim()
        end

	    s.GUID = arg12

--[===[@debug@ 
        s.ARGS = { ... }

        if CHAT_PLAYER_GUIDS then    
    		if s.GUID and s.GUID:len() > 0 then
    			s.GUIDINFO = { _G.GetPlayerInfoByGUID(s.GUID) }
    		end        
        end
--@end-debug@]===]

--        if NEW_CHATFILTERS then
            local kill, newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12 = 
                    RunMessageEventFilters(frame, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
            if kill then
                return true
            end
            if newarg1 ~= nil then
                arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = 
                    newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12
            end
--        else
--            local kill, newarg1 = RunOldMessageEventFilters(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
--            if kill then
--                return true
--            end
--
--            arg1 = newarg1 or arg1
--        end


		if ((type == "PARTY_LEADER") and (_G.HasLFGRestrictions())) then
			type = "PARTY_GUIDE"
            event = "CHAT_MSG_PARTY_GUIDE"
		end

        s.CHATTYPE = type
        s.EVENT = event
        local chatGroup = _G.Chat_GetChatCategory(type)
        s.CHATGROUP = chatGroup
        
        
        
      	local chatTarget;
		if ( chatGroup == "CHANNEL" or chatGroup == "BN_CONVERSATION" ) then
			chatTarget = tostring(arg8);
		elseif ( chatGroup == "WHISPER" or chatGroup == "BN_WHISPER" ) then
			chatTarget = strupper(arg2);
		end

        s.CHATTARGET = chatTarget
        s.MESSAGE = safestr(arg1)
     
     
     	if ( _G.FCFManager_ShouldSuppressMessage(frame, s.CHATGROUP, s.CHATTARGET) ) then
			s.DONOTPROCESS = true
		end
     
		if ( chatGroup == "WHISPER" or chatGroup == "BN_WHISPER" ) then
			if ( frame.privateMessageList and not frame.privateMessageList[strlower(arg2)] ) then
				s.DONOTPROCESS = true
			elseif ( frame.excludePrivateMessageList and frame.excludePrivateMessageList[strlower(arg2)] ) then
				s.DONOTPROCESS = true
			end
		elseif ( chatGroup == "BN_CONVERSATION" ) then
			if ( frame.bnConversationList and not frame.bnConversationList[arg8] ) then
				s.DONOTPROCESS = true
			elseif ( frame.excludeBNConversationList and frame.excludeBNConversationList[arg8] ) then
				s.DONOTPROCESS = true
			end
		end     
     

        local chatget = _G["CHAT_"..type.."_GET"]


        if chatget then
            local chatlink = chatget:match("|H(channel:[^|]-)|h[^|]-|h")

            if chatlink then
                s.CHANLINK = chatlink
    			s.nN = "|H"
    			s.NN = "|h"
    			s.Nn = "|h"

                chatget = chatget:gsub("|Hchannel:[^|]-|h([^|]-)|h", "%1")
            end
 
            s.TYPEPREFIX, s.TYPEPOSTFIX = string.match(_G.TEXT(chatget), "(.*)%%s(.*)")
        end

        s.TYPEPOSTFIX = safestr(s.TYPEPOSTFIX)
        s.TYPEPREFIX = safestr(s.TYPEPREFIX)



        local arg2 = safestr(arg2)
        if strlen(arg2) > 0 then

        	if ( strsub(type, 1, 7) == "MONSTER" or type == "RAID_BOSS_EMOTE" or 
                    type == "CHANNEL_NOTICE" or type == "CHANNEL_NOTICE_USER") then
        		-- no link
        	else
               local plr, svr = arg2:match("([^%-]+)%-?(.*)")

                s.pP = "["
                s.lL = "|Hplayer:"
                
                s.PLAYERLINK = arg2
                
                s.LL = "|h"
                s.PLAYER = plr

                if svr and strlen(svr) > 0 then
                    s.sS = "-"
                    s.SERVER = svr
                end


            	if ( type ~= "BN_WHISPER" and type ~= "BN_WHISPER_INFORM" and type ~= "BN_CONVERSATION") or arg2 == _G.UnitName("player") then
    				s.PLAYERLINKDATA = ":"..safestr(arg11)..":"..chatGroup..(chatTarget and ":"..chatTarget or "")
    			else
    			    s.lL = "|HBNplayer:"
    				s.PLAYERLINKDATA = ":"..safestr(arg13)..":"..safestr(arg11)..":"..chatGroup..(chatTarget and ":"..chatTarget or "")
    			end

                s.Ll = "|h"
                s.Pp = "]"
            end
        end

        -- If we are handling notices, format them like bliz
        if (type == "CHANNEL_NOTICE_USER") then
            local chatnotice = _G["CHAT_"..arg1.."_NOTICE"]:gsub("|Hchannel:[^|]-|h[^|]-|h", ""):trim()

			if strlen(arg5) > 0 then
				-- TWO users in this notice (E.G. x kicked y)
				s.MESSAGE = chatnotice:format(arg2, arg5)
			elseif ( arg1 == "INVITE" ) then
				s.MESSAGE = chatnotice:format(arg4, arg2)
			else
				s.MESSAGE = chatnotice:format(arg2)
			end
		elseif type == "CHANNEL_NOTICE" then
			if ( arg10 > 0 ) then
				arg4 = arg4.." "..arg10;
			end

            if _G["CHAT_"..arg1.."_NOTICE"] then
                if arg1 == "YOU_JOINED" or arg1 == "YOU_LEFT"  or arg1 == "YOU_CHANGED" or arg1 == "SUSPENDED" or arg1 == "NOT_IN_LFG" then
        			s.MESSAGE =  _G["CHAT_"..arg1.."_NOTICE"]:format(arg8, arg4):trim()                
                else
        			s.MESSAGE =  _G["CHAT_"..arg1.."_NOTICE"]:gsub("|Hchannel:[^|]-|h[^|]-|h", ""):trim()
                end
            end
		end

        local arg6 = safestr(arg6)
        if strlen(arg6) > 0 then
            s.fF = ""

			-- 2.4 Change
			if arg6 == "GM" then 
				s.FLAG = "|TInterface\\ChatFrame\\UI-ChatIcon-Blizz.blp:0:2:0:-3|t "
			elseif ( arg6 == "DEV" ) then
				--Add Blizzard Icon, this was sent by a Dev
				s.FLAG = "|TInterface\\ChatFrame\\UI-ChatIcon-Blizz.blp:0:2:0:-3|t ";
            else
	            s.FLAG = _G["CHAT_FLAG_"..arg6]
			end

            s.Ff = ""
        end

        local arg3 = safestr(arg3)
        if ( (strlen(arg3) > 0) and (arg3 ~= "Universal") and (arg3 ~= frame.defaultLanguage) ) then
            s.gG = "["
            s.LANGUAGE = arg3
            s.Gg = "] "
        else
            s.LANGUAGE_NOSHOW = arg3
        end

        local arg9 = safestr(arg9)
        if strlen(arg9) > 0 or chatGroup == "BN_CONVERSATION" then
--            local bracket, post_bracket = string.match(s.TYPEPREFIX, "%[(.*)%](.*)")
--            bracket = safestr(bracket)
--            if strlen(bracket) > 0 then
--                s.cC = "["
--                s.Cc = "]"
--                s.CHANNEL = bracket
--                s.TYPEPREFIX = safestr(post_bracket)
--            end



            if strlen(safestr(arg8)) > 0 and arg8 > 0 then
                s.CC = ". "

    			s.nN = "|H"
    			s.NN = "|h"
    			s.Nn = "|h"
                
                
     			if chatGroup  == "BN_CONVERSATION" then
     			    s.CHANLINK = "channel:BN_CONVERSATION:"..arg8
    			else
                    s.CHANNELNUM = tostring(arg8)
                    s.CHANLINK = "channel:channel:"..tostring(arg8)	
    			end                
            end

            if chatGroup  == "BN_CONVERSATION" then                
                s.cC = "["
                s.Cc = "] "
 			    s.CHANNELNUM = tostring(_G.MAX_WOW_CHAT_CHANNELS + arg8)
                s.CHANNEL = _G.CHAT_BN_CONVERSATION_SEND:match("%[%%d%. (.*)%]")
            elseif arg7 > 0 then
                s.cC = "["
                s.Cc = "] "
                s.CHANNEL, s.zZ, s.ZONE = string.match(arg9, "(.*)(%s%-%s)(.*)")

                if s.CHANNEL:len() == 0 then
                    s.CHANNEL = arg9
                end

                s.CHANNEL = safestr(s.CHANNEL)
                s.zZ = safestr(s.zZ)
                s.ZONE = safestr(s.ZONE)
                s.Zz = ""
            else
                if strlen(arg9) > 0 then
                    s.CHANNEL = arg9
                    s.cC = "["
                    s.Cc = "] "
                end
            end
        end


--		local _, fontHeight = _G.GetChatWindowInfo(frame:GetID());
--		
--		if ( fontHeight == 0 ) then
--			--fontHeight will be 0 if it's still at the default (14)
--			fontHeight = 14;
--		end



		local arg7 = tonumber(arg7)
 		-- 2.4
		-- Search for icon links and replace them with texture links.
		if arg7 and ( arg7 < 1 or ( arg7 >= 1 and _G.CHAT_SHOW_ICONS ~= "0" ) ) then
			local term;
			for tag in string.gmatch(arg1, "%b{}") do
				term = strlower(string.gsub(tag, "[{}]", ""));
				if ( _G.ICON_TAG_LIST[term] and _G.ICON_LIST[_G.ICON_TAG_LIST[term]] ) then
					s.MESSAGE  = string.gsub(s.MESSAGE , tag, _G.ICON_LIST[_G.ICON_TAG_LIST[term]] .. "0|t");
-- 
-- This would allow for ignoring unknown icon tags
--
--				else
--					s.MESSAGE = string.gsub(s.MESSAGE, tag, "");
				end
			end
		end

        if type == "SYSTEM" or strsub(type,1,11) == "ACHIEVEMENT" or strsub(type,1,18) == "GUILD_ACHIEVEMENT" then
			if strsub(type,1,11) == "ACHIEVEMENT" or strsub(type,1,18) == "GUILD_ACHIEVEMENT" then
				s.MESSAGE = s.MESSAGE:format("")
			end
            local pl, p, rest = string.match(s.MESSAGE, "|Hplayer:(.-)|h%[(.-)%]|h(.+)")
            if pl and p then
                local plr, svr = pl:match("([^%-]+)%-?(.*)")
                s.pP = "["
                s.lL = "|Hplayer:"
                s.PLAYERLINK = pl
                s.LL = "|h"
                s.PLAYER = plr
                s.Ll = "|h"
                s.Pp = "]"
                s.MESSAGE = rest

                if svr and strlen(svr) > 0 then
                    s.sS = "-"
                    s.SERVER = svr
                end

                if arg11 then
                    s.PLAYERLINKDATA = ":"..safestr(arg11)
                end
            end
        end

        s.ACCESSID = _G.ChatHistory_GetAccessID(chatGroup, chatTarget);
        s.TYPEID = _G.ChatHistory_GetAccessID(type, chatTarget);
        
        s.ORG = SplitMessageOrg

        return SplitMessage, info
    end
end

local NULL_INFO = {r = 1.0, g = 1.0, b = 1.0, id = 0 }



