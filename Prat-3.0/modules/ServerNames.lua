---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat mods
--
-- Copyright (C) 2006-2007  Prat Development Team
--
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to:
--
-- Free Software Foundation, Inc., 
-- 51 Franklin Street, Fifth Floor, 
-- Boston, MA  02110-1301, USA.
--
--
-------------------------------------------------------------------------------



--[[
Name: PratServerNames
Revision: $Revision: 80432 $
Author(s): Curney (asml8ed@gmail.com)
           Krtek (krtek4@gmail.com)
           Sylvanaar (sylvanaar@mindspring.com)

Website: http://www.wowace.com/files/index.php?path=Prat/
Documentation: http://www.wowace.com/wiki/Prat/Integrated_Modules#ServerNames
Subversion: http://svn.wowace.com/wowace/trunk/Prat/
Discussions: http://groups.google.com/group/wow-prat
Issues and feature requests: http://code.google.com/p/prat/issues/list
Description: Module for Prat that options for replacing server names with abbreviations.
Dependencies: Prat
]]

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("ServerNames")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
    ["ServerNames"] = true,
    ["Server name abbreviation options."] = true,
    ["randomclr_name"] = "Random Colors",
    ["randomclr_desc"] = "Use a random color for each server.",
    ["colon_name"] = "Show Colon",
    ["colon_desc"] = "Toggle adding colon after server replacement.",
	["autoabbreviate_name"] = "Auto-abbreviate",	
	["autoabbreviate_desc"] = "Shorten the server name to 3 letters",
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	autoabbreviate_desc = "Shorten the server name to 3 letters",
	autoabbreviate_name = "Auto-abbreviate",
	colon_desc = "Toggle adding colon after server replacement.",
	colon_name = "Show Colon",
	randomclr_desc = "Use a random color for each server.",
	randomclr_name = "Random Colors",
	["Server name abbreviation options."] = true,
	ServerNames = true,
}

)
L:AddLocale("frFR",  
{
	-- autoabbreviate_desc = "",
	-- autoabbreviate_name = "",
	-- colon_desc = "",
	-- colon_name = "",
	-- randomclr_desc = "",
	-- randomclr_name = "",
	-- ["Server name abbreviation options."] = "",
	-- ServerNames = "",
}

)
L:AddLocale("deDE", 
{
	autoabbreviate_desc = "Kürze den Server-Namen auf 3 Buchstaben",
	autoabbreviate_name = "Auto-Abkürzen",
	colon_desc = "Hinzufügen eines Doppelpunkts nach dem Ersetzen des Servers ein-/ausschalten.",
	colon_name = "Doppelpunkt anzeigen",
	randomclr_desc = "Eine zufällige Farbe für jeden Server verwenden.",
	randomclr_name = "Zufällige Farben",
	["Server name abbreviation options."] = "Optionen für Abkürzungen von Server-Namen",
	ServerNames = "ServerNamen",
}

)
L:AddLocale("koKR",  
{
	autoabbreviate_desc = "서버이름을 3글자로 줄임",
	autoabbreviate_name = "자동-줄임",
	colon_desc = "서버 대체이름 뒤에 콜론 추가",
	colon_name = "콜론 보이기",
	randomclr_desc = "서버이름에 무작위 색상 사용",
	randomclr_name = "무작위 색상",
	["Server name abbreviation options."] = "서버이름 줄이기 옵션.",
	ServerNames = "서버이름",
}

)
L:AddLocale("esMX",  
{
	-- autoabbreviate_desc = "",
	-- autoabbreviate_name = "",
	-- colon_desc = "",
	-- colon_name = "",
	-- randomclr_desc = "",
	-- randomclr_name = "",
	-- ["Server name abbreviation options."] = "",
	-- ServerNames = "",
}

)
L:AddLocale("ruRU",  
{
	autoabbreviate_desc = "Сокращает название сервера до трех букв",
	autoabbreviate_name = "Авто-сокращение",
	colon_desc = "Вкл/Выкл добавление двоеточия после замещения сервера.",
	colon_name = "Показывать двоеточие",
	randomclr_desc = "Использовать случайные цвета для всех серверов.",
	randomclr_name = "Случайные цвета",
	["Server name abbreviation options."] = "Настройки сокращений имен серверов.",
	ServerNames = true,
}

)
L:AddLocale("zhCN",  
{
	-- autoabbreviate_desc = "",
	-- autoabbreviate_name = "",
	colon_desc = "在服务器后添加冒号",
	colon_name = "显示冒号",
	randomclr_desc = "为每个服务器使用随机颜色",
	randomclr_name = "随机颜色",
	["Server name abbreviation options."] = "服务器名称缩写选项",
	ServerNames = "服务器名称",
}

)
L:AddLocale("esES",  
{
	-- autoabbreviate_desc = "",
	-- autoabbreviate_name = "",
	colon_desc = "Alterna añadir dos puntos despues del servidor reemplazado.",
	colon_name = "Mostrar dos puntos",
	randomclr_desc = "Utiliza un color aleatorio para cada servidor.",
	randomclr_name = "Colores Aleatorios",
	["Server name abbreviation options."] = "Opciones de la abreviatura del nombre del servidor.",
	ServerNames = "NombreServidor",
}

)
L:AddLocale("zhTW",  
{
	-- autoabbreviate_desc = "",
	-- autoabbreviate_name = "",
	-- colon_desc = "",
	colon_name = "顯示冒號",
	randomclr_desc = "伺服器名稱使用隨機色彩",
	randomclr_name = "隨機色彩",
	["Server name abbreviation options."] = "伺服器名稱縮寫選項",
	-- ServerNames = "",
}

)
--@end-non-debug@





--

--

--

--

--


local module = Prat:NewModule(PRAT_MODULE)

Prat:SetModuleDefaults(module.name, {
	profile = {
	    on = true,
	    space = true,
	    colon = true,

	    autoabbreviate = true,
	
	    chanSave = {},
	   
	    serveropts = { 
	        ["*"] = {
	            replace = false,
	            customcolor = false,
	            shortname = "",
	            color = {
	                r = 0.65,
	                g = 0.65,
	                b = 0.65,
					a = 1,
	            },   
	        },
	    },
	
	    randomclr = true,
	}
} )

local serverPlugins = { servers={} }

Prat:SetModuleOptions(module.name, {
        name = L["ServerNames"],
        desc = L["Server name abbreviation options."],
        type = "group",
		plugins = serverPlugins,
        args = {
			autoabbreviate = {
				type = "toggle",
				name = L["autoabbreviate_name"],
				desc = L["autoabbreviate_desc"],
				order = 250
			},
			randomclr = {
				type = "toggle",
				name = L["randomclr_name"],
				desc = L["randomclr_desc"],
				order = 250
			}
        }
    }
)

-- build the options menu using prat templates
--module.toggleOptions = { optsep_sep = 240, randomclr = 250}
--module.toggleOptions = { optsep_sep = 229, space = 230, colon = 240 }

--local server_tags = {
--    ["Normal"] = "(E)",
--    ["PvP"] = "(P)",
--    ["RP"] = "(R)",
--    ["RP-PvP"] = "(PR)",
--}
--
--local server_desctags = {
--    ["Normal"] = "PvE",
--    ["PvP"] = "PvP",
--    ["RP"] = "RP",
--    ["RP-PvP"] = "RPPvP",
--}

local CLR = Prat.CLR
local function Server(server, text) return CLR:Colorize(module:GetServerCLR(server), text or server) end

local KeyToFullNameMap = { }
local FullNameToKeyMap = { }

-- Get the key for the server specified, safe to pass this nil and "", if no key then it returns nil
function module:GetServerKey(server) 
    local key = FullNameToKeyMap[server]

	if key==nil then
        self:AddServer(server)

        key = FullNameToKeyMap[server]
	end 

    return key
end


function module:AddServer(server)
	if server and strlen(server)>0 then 
		local key = server:gsub(" ", ""):lower() 
        FullNameToKeyMap[server] = key
        KeyToFullNameMap[key] = KeyToFullNameMap[key] or server
	end 
end

function module:GetServerSettings(serverKey)
    opts = self.db.profile.serveropts[serverKey]
	if not opts then
		self.db.profile.serveropts[serverKey] = {}
		opts = self.db.profile.serveropts[serverKey]
	end
	
	return opts
end

--[[------------------------------------------------
    Module Event Functions
------------------------------------------------]]--
function module:OnModuleEnable()
    self:BuildServerOptions()
    Prat.RegisterChatEvent(self, "Prat_PreAddMessage")
end

function module:OnModuleDisable()
    Prat.UnregisterAllChatEvents(self)
end

--[[------------------------------------------------
    Core Functions
------------------------------------------------]]--

-- replace text using prat event implementation
function module:Prat_PreAddMessage(e, m, frame, event)
    local serverKey = self:GetServerKey(m.SERVER) 
    local opts = serverKey and self:GetServerSettings(serverKey)

    if opts and opts.replace then
        m.SERVER = opts.shortname
    end  

    if m.SERVER and strlen(m.SERVER)>0 then
        m.SERVER = self:FormatServer(m.SERVER, serverKey)
    end

    if not (m.SERVER and strlen(m.SERVER)>0) then
		local s = Prat.SplitMessage        
		s.SERVER, s.sS, s.Ss = "", "", ""
    end
end


function module:FormatServer(server, serverKey)
    if server==nil then
        server=KeyToFullNameMap[serverKey]
    elseif serverKey==nil then
        serverKey=self:GetServerKey(server)
    end

    if server==nil or serverKey==nil then return end

	if self.db.profile.autoabbreviate then	    
		server = server:match("[\192-\255]?%a?[\128-\191]*[\192-\255]?%a?[\128-\191]*[\192-\255]?%a?[\128-\191]*")
	end

    return Server(serverKey, server)
end

local serverHashes = setmetatable({}, { __mode = "kv", __index = function(t,k) t[k] = CLR:GetHashColor(k) return t[k] end })
local serverColors = setmetatable({}, { __mode = "kv", __index = function(t,k) t[k] = CLR:GetHexColor(k) return t[k] end })

function module:GetServerCLR(server)
    local serverKey = self:GetServerKey(server) 

    if serverKey then
        local opts = self:GetServerSettings(serverKey)
    
        if opts and opts.customcolor then
            return serverColors[opts.color]        
        elseif self.db.profile.randomclr then 
            return serverHashes[serverKey]
        end
    end

    return CLR.COLOR_NONE
end

--[[------------------------------------------------
    Menu Builder Functions
------------------------------------------------]]--

function module:BuildServerOptions()   
--    if Glory then 
--        if opts.noglory then opts.noglory = nil end
--        local serverList = {}
--        local homeservName = GetRealmName()
--        Glory:GetBattlegroupServers(nil, serverList)
--        
--        local scount = 0
--
--        local serverKey, serverType
--        for _,v in pairs(serverList) do
--        -- Since we dont detect the home server, dont offer an option
--            if v ~= homeservName then
--                serverKey = GetServerKey(v)   
--                serverType = Glory:GetServerType(v)
--                self:CreateServerOption(self.moduleOptions.args, v, serverKey, serverType)
--                
--                scount = scount + 1
--            end
--        end
--        
--        if scount == 0 then 
--            opts.noservers = {}
--            opts.noservers.type = 'header'
--            opts.noservers.name = L["Unknown Battlegroup"]
--        else
--            opts.noservers = nil
--        end
--    else
--
--    end
    
    
end



--
--
-- "-Name(type)" is how we have it
--
--  so provide
--
--   %S = Full Server Name
--   %s = Abbreviated Server Name
--   %T = Full Realm Type eg PvP
--   %t = Abbreviated Realm Type e.g P
--
--  So the default format is:
--
--      -%S(%t)
--
--   We can support a coloring syntax
--   which can say use the color of
--   (some other field) Here, we can 
--   Set the color of the server to use
--   the color value of the realm type
--   
--
local t_sort = {}
function module:UpdateServerMenu()
--    for k,v in pairs(args) do
--        if v.name_org then
--            local opts = self.db.profile.serveropts[k]
--
--            v.name = CLR:Server(v.name_org)
--            if opts and opts.replace and opts.shortname and strlen(opts.shortname) > 0 then
--                v.name = v.name .. " - (" .. CLR:Server(v.name_org, opts.shortname) .. ")"
--            end
--
--            v.args.setname.name = v.name
--            t_sort[#t_sort+1] = k
--        end
--    end
--
--    -- Now it must be sorted   
--    table.sort(t_sort)
--
--    -- Now apply ordering
--    local o = 10
--    for i,k in ipairs(t_sort) do
--        t_sort[i] = nil
--        args[k].order = o
--        o = o + 1
--    end
end


function module:CreateServerOption(args, servername, serverkey, servertype)
--    local name = serverkey
--    local text = servername
--    local type = text
--
--
--
--    args[name] = {
--        name = CLR:Server(text),
--        name_org = text,
--        type_org = servertype,
--        desc = string.format(L["'%s - %s' display settings."], text, server_desctags[servertype]),
--        type = "group",
--        args = {
--            setname = {
--                name = CLR:Server(text),
--                desc = string.format(L["Use a custom replacement for the server %s text."], text),
--                order = 10,
--                type = "text",
--                usage = "<string>",
--                get = function() return self.db.profile.serveropts[name].shortname end,
--                set = function(v) self.db.profile.serveropts[name].shortname = v end
--            },
--            optsep20 = {
--                order = 20,
--                type = 'header',
--            },
--            usecustomcolor = {
--                name = L["Use custom color"],
--                desc = L["Toggle useing custom color this server."],
--                type = "toggle",
--                order = 24,
--                get = function() return self.db.profile.serveropts[name].customcolor end,
--                set = function(v) self.db.profile.serveropts[name].customcolor = v end
--            },
--            customcolor = {
--                name = L["Set color"],
--                desc = L["Change the color for this server name"],
--                type = "color",
--                order = 25,
--                get = function() local c = self.db.profile.serveropts[name].color
--                         return c.r, c.g, c.b end,
--                set = function(r, g, b, a) local c = self.db.profile.serveropts[name].color
--                        c.r, c.g, c.b = r, g, b end,
--                disabled = function() if not self.db.profile.serveropts[name].customcolor then return true else return false end end,
--            },
--            optsep27 = {
--                order = 27,
--                type = 'header',
--            },
--            replace = {
--                name = L["Replace"],
--                desc = L["Toggle replacing this server."],
--                type = "toggle",
--                order = 30,
--                get = function() return self.db.profile.serveropts[name].replace  end,
--                set = function(v) self.db.profile.serveropts[name].replace  = v end,
--            },
--            off = {
--                name = L["Blank"],
--                desc = L["Don't display the server name"],
--                type = "execute",
--                order = 40,
--                func = function() self.db.profile.serveropts[name].shortname  = ""  end
--            }
--        }
--    }
end


  return
end ) -- Prat:AddModuleToLoad