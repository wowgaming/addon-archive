-- imports
local WIM = WIM;
local _G = _G;
local CreateFrame = CreateFrame;
local select = select;
local type = type;
local table = table;
local pairs = pairs;
local string = string;
local next = next;

-- set name space
setfenv(1, WIM);

-- Core information
addonTocName = "WIM";
version = "3.3.7";
beta = false; -- flags current version as beta.
debug = false; -- turn debugging on and off.
useProtocol2 = false; -- test switch for new W2W Protocol. (Dev use only)

-- WOTLK check by CKKnight (we'll keep this around for now...)
isPTR = select(4, _G.GetBuildInfo()) >= 30100;

-- is Private Server?
isPrivateServer = not (string.match(_G.GetCVar("realmList"), "worldofwarcraft.com$")
                        or string.match(_G.GetCVar("realmList"), "battle.net$")
                        or string.match(_G.GetCVar("realmListbn"), "battle.net$")) and true or false;

-- is US or EU server?
isUS = _G.GetCVar("realmList"):sub(1,2) == "us" and true or false;

constants = {}; -- constants such as class colors will be stored here. (includes female class names).
modules = {}; -- module table. consists of all registerd WIM modules/plugins/skins. (treated the same).
windows = {active = {whisper = {}, chat = {}, w2w = {}}}; -- table of WIM windows.
libs = {}; -- table of loaded library references.
stats = {};

-- default options. live data is found in WIM.db
-- modules may insert fields into this table to
-- respect their option contributions.
db_defaults = {
    enabled = true,
    showToolTips = true,
    modules = {},
    alertedPrivateServer = false,
};

-- WIM.env is an evironmental reference for the current instance of WIM.
-- Information is stored here such as .realm and .character.
-- View table dump for more available information.
env = {};

-- default lists - This will store lists such as friends, guildies, raid members etc.
lists = {};

-- list of all the events registered from attached modules.
local Events = {};

-- create a frame to moderate events and frame updates.
    local workerFrame = CreateFrame("Frame", "WIM_workerFrame");
    workerFrame:SetScript("OnEvent", function(self, event, ...) WIM:CoreEventHandler(event, ...); end);
    
    -- some events we always want to listen to so data is ready upon WIM being enabled.
    workerFrame:RegisterEvent("VARIABLES_LOADED");
    workerFrame:RegisterEvent("ADDON_LOADED");


-- called when WIM is first loaded into memory but after variables are loaded.
local function initialize()
    --load cached information from the WIM_Cache saved variable.
	env.cache[env.realm] = env.cache[env.realm] or {};
        env.cache[env.realm][env.character] = env.cache[env.realm][env.character] or {};
	lists.friends = env.cache[env.realm][env.character].friendList;
	lists.guild = env.cache[env.realm][env.character].guildList;
        
        if(type(lists.friends) ~= "table") then lists.friends = {}; end
        if(type(lists.guild) ~= "table") then lists.guild = {}; end
        
        workerFrame:RegisterEvent("GUILD_ROSTER_UPDATE");
        workerFrame:RegisterEvent("FRIENDLIST_UPDATE");
	workerFrame:RegisterEvent("BN_FRIEND_LIST_SIZE_CHANGED");
	workerFrame:RegisterEvent("BN_FRIEND_INFO_CHANGED");
        
        --querie guild roster
        if( _G.IsInGuild() ) then
            _G.GuildRoster();
        end
        
    -- import libraries.
    libs.WhoLib = _G.LibStub:GetLibrary("LibWho-2.0");
    libs.Astrolabe = _G.DongleStub("Astrolabe-0.4");
    libs.SML = _G.LibStub:GetLibrary("LibSharedMedia-3.0");
    libs.ChatHandler = _G.LibStub:GetLibrary("LibChatHandler-1.0");
    
    isInitialized = true;
    
    RegisterPrematureSkins();
    
    --enableModules
    local moduleName, tData;
    for moduleName, tData in pairs(modules) do
        modules[moduleName].db = db;
        if(modules[moduleName].canDisable ~= false) then
            local modDB = db.modules[moduleName];
            if(modDB) then
                if(modDB.enabled == nil) then
                    modDB.enabled = modules[moduleName].enableByDefault;
                end
                EnableModule(moduleName, modDB.enabled);
            else
                if(modules[moduleName].enableByDefault) then
                    EnableModule(moduleName, true);
                end
            end
        else
                EnableModule(moduleName, true);
        end
    end
    
        for mName, module in pairs(modules) do
                if(db.enabled) then
                        if(type(module.OnEnableWIM) == "function") then
                            module:OnEnableWIM();
                        end
                else
                        if(type(module.OnDisableWIM) == "function") then
                            module:OnDisableWIM();
                        end
                end
        end
    
    -- notify all modules of current state.
    CallModuleFunction("OnStateChange", WIM.curState);
    RegisterSlashCommand("enable", function() SetEnabled(not db.enabled) end, L["Toggle WIM 'On' and 'Off'."]);
    RegisterSlashCommand("debug", function() debug = not debug; end, L["Toggle Debugging Mode 'On' and 'Off'."]);
    FRIENDLIST_UPDATE(); -- pretend event has been fired in order to get cache loaded.
    CallModuleFunction("OnInitialized");
    WindowParent:Show();
    dPrint("WIM initialized...");
end

-- called when WIM is enabled.
-- WIM will not be enabled until WIM is initialized event is fired.
local function onEnable()
    db.enabled = true;
    
    local tEvent;
    for tEvent, _ in pairs(Events) do
        workerFrame:RegisterEvent(tEvent);
    end
    
        if(isInitialized) then
            for mName, module in pairs(modules) do
                if(type(module.OnEnableWIM) == "function") then
                    module:OnEnableWIM();
                end
                if(db.modules[mName] and db.modules[mName].enabled and type(module.OnEnable) == "function") then
                    module:OnEnable();
                end
            end
        end
    DisplayTutorial(L["WIM (WoW Instant Messenger)"], L["WIM is currently running. To access WIM's wide array of options type:"].." |cff69ccf0/wim|r");
    dPrint("WIM is now enabled.");
    
    --Private Server Check
    if(isPrivateServer and not db.alertedPrivateServer) then
      _G.StaticPopupDialogs["WIM_PRIVATE_SERVER"] = {
        text = L["WIM has detected that you are playing on a private server. Some servers can not process ChatAddonMessages. Would you like to enable them anyway?"],
        button1 = _G.TEXT(_G.YES),
        button2 = _G.TEXT(_G.NO),
        OnShow = function(self) end,
        OnHide = function() end,
        OnAccept = function() db.disableAddonMessages = false; db.alertedPrivateServer = true; end,
        OnCancel = function() db.disableAddonMessages = true; db.alertedPrivateServer = true; end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
      };        
      _G.StaticPopup_Show ("WIM_PRIVATE_SERVER", theLink);
    end
end

-- called when WIM is disabled.
local function onDisable()
    db.enabled = false;
    
    local tEvent;
    for tEvent, _ in pairs(Events) do
        workerFrame:UnregisterEvent(tEvent);
    end
    
    if(isInitialized) then
        for _, module in pairs(modules) do
            if(type(module.OnDisableWIM) == "function") then
                module:OnDisableWIM();
            end
            if(type(module.OnDisable) == "function") then
                module:OnDisable();
            end
        end
    end
    
    dPrint("WIM is now disabled.");
end


function SetEnabled(enabled)
    if( enabled ) then
        onEnable();
    else
        onDisable();
    end
end

-- events are passed to modules. Events do not need to be
-- unregistered. A disabled module will not receive events.
local function RegisterEvent(event)
    Events[event] = true;
    if( db and db.enabled ) then
        workerFrame:RegisterEvent(event);
    end
end

-- create a new WIM module. Will return module object.
function CreateModule(moduleName, enableByDefault)
    if(type(moduleName) == "string") then
        modules[moduleName] = {
            title = moduleName,
            enabled = false,
            enableByDefault = enableByDefault or false,
            canDisable = true,
            resources = {
                lists = lists,
                windows = windows,
                env = env,
                constants = constants,
                libs = libs,
            },
            db = db,
            db_defaults = db_defaults,
            RegisterEvent = function(self, event) RegisterEvent(event); end,
            Enable = function() EnableModule(moduleName, true) end,
            Disable = function() EnableModule(moduleName, false) end,
            dPrint = function(self, t) dPrint(t); end,
            hasWidget = false,
            RegisterWidget = function(widgetName, createFunction) RegisterWidget(widgetName, createFunction, moduleName); end
        }
        return modules[moduleName];
    else
        return nil;
    end
end

function EnableModule(moduleName, enabled)
    if(enabled == nil) then enabled = false; end
    local module = modules[moduleName];
    if(module) then
        if(module.canDisable == false and enabled == false) then
            dPrint("Module '"..moduleName.."' can not be disabled!");
            return;
        end
        if(db) then
            db.modules[moduleName] = WIM.db.modules[moduleName] or {};
            db.modules[moduleName].enabled = enabled;
        end
        if(enabled) then
            module.enabled = enabled;
            if(enabled and type(module.OnEnable) == "function") then
                module:OnEnable();
            elseif(not enabled and type(module.OnDisable) == "function") then
                module:OnDisable();
            end
            dPrint("Module '"..moduleName.."' Enabled");
        else
            if(module.hasWidget) then
                dPrint("Module '"..moduleName.."' will be disabled after restart.");
            else
                module.enabled = enabled;
                if(enabled and type(module.OnEnable) == "function") then
                    module:OnEnable();
                elseif(not enabled and type(module.OnDisable) == "function") then
                    module:OnDisable();
                end
                dPrint("Module '"..moduleName.."' Disabled");
            end
        end
    end
end

function CallModuleFunction(funName, ...)
    -- notify all enabled modules.
    dPrint("Calling Module Function: "..funName);
    local module, tData, fun;
    for module, tData in pairs(WIM.modules) do
        fun = tData[funName];
        if(type(fun) == "function" and tData.enabled) then
                dPrint(" +--"..module);
                fun(tData, ...);
        end
    end
end
--------------------------------------
--          Event Handlers          --
--------------------------------------

function WIM.honorChatFrameEventFilter(event, ...)
        local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = ...;
        local chatFilters = _G.ChatFrame_GetMessageEventFilters(event);
	local filter = false;
        if chatFilters then
            local narg1, narg2, narg3, narg4, narg5, narg6, narg7, narg8, narg9, narg10, narg11, narg12;
            for _, filterFunc in next, chatFilters do
		filter, narg1, narg2, narg3, narg4, narg5, narg6, narg7, narg8, narg9, narg10, narg11, narg12 = filterFunc(workerFrame, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
                if filter then 
                    return true, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12; 
                elseif(narg1) then
                    arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = narg1, narg2, narg3, narg4, narg5, narg6, narg7, narg8, narg9, narg10, narg11, narg12;
                end
            end 
        end 
        return filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12;
end


function WIM:EventHandler(event,...) 
        -- depricated - here for compatibility only
end

-- This is WIM's core event controler.
function WIM:CoreEventHandler(event, ...)

    -- Core WIM Event Handlers.
    dPrint("Event '"..event.."' received.");
    
    local fun = WIM[event];
    if(type(fun) == "function") then
        dPrint("  +-- WIM:"..event);
        fun(WIM, ...);
    end
    
    -- Module Event Handlers
    if(db and db.enabled) then
        local module, tData;
        for module, tData in pairs(modules) do
            fun = tData[event];
            if(type(fun) == "function" and tData.enabled) then
                dPrint("  +-- "..module..":"..event);
                fun(modules[module], ...);
            end
        end
    end
end

function WIM:VARIABLES_LOADED()
    _G.WIM3_Data = _G.WIM3_Data or {};
    db = _G.WIM3_Data;
    _G.WIM3_Cache = _G.WIM3_Cache or {};
    env.cache = _G.WIM3_Cache;
    _G.WIM3_Filters = _G.WIM3_Filters or GetDefaultFilters();
    _G.WIM3_ChatFilters = _G.WIM3_ChatFilters or {};
    if(#_G.WIM3_Filters == 0) then
        _G.WIM3_Filters = GetDefaultFilters();
    end
    filters = _G.WIM3_Filters;
    chatFilters = _G.WIM3_ChatFilters;
    
    _G.WIM3_History = _G.WIM3_History or {};
    history = _G.WIM3_History;
    
    -- load some environment data.
    env.realm = _G.GetCVar("realmName");
    env.character = _G.UnitName("player");
    
    -- inherrit any new default options which wheren't shown in previous releases.
    inherritTable(db_defaults, db);
    lists.gm = {};
    
    -- load previous state into memory
    curState = db.lastState;
    
    SetEnabled(db.enabled);
    initialize();
end

function WIM:FRIENDLIST_UPDATE()
    env.cache[env.realm][env.character].friendList = env.cache[env.realm][env.character].friendList or {};
    for key, d in pairs(env.cache[env.realm][env.character].friendList) do
	if(d == 1) then
	    env.cache[env.realm][env.character].friendList[key] = nil;
	end
    end
	for i=1, _G.GetNumFriends() do 
		local name, junk = _G.GetFriendInfo(i);
		if(name) then
			env.cache[env.realm][env.character].friendList[name] = 1; --[set place holder for quick lookup
		end
	end
    lists.friends = env.cache[env.realm][env.character].friendList;
    dPrint("Friends list updated...");
end

function WIM:BN_FRIEND_LIST_SIZE_CHANGED()
    env.cache[env.realm][env.character].friendList = env.cache[env.realm][env.character].friendList or {};
    for key, d in pairs(env.cache[env.realm][env.character].friendList) do
	if(d == 2) then
            env.cache[env.realm][env.character].friendList[key] = nil;
	end
    end
	for i=1, _G.BNGetNumFriends() do
	    local id, name, surname = _G.BNGetFriendInfo(i);
	    name = name.." "..surname;
	    if(name) then
		env.cache[env.realm][env.character].friendList[name] = 2; --[set place holder for quick lookup
		if(windows.active.whisper[name]) then
		    windows.active.whisper[name]:SendWho();
		end
	    end
	end
    lists.friends = env.cache[env.realm][env.character].friendList;
    dPrint("RealID list updated...");
end
WIM.BN_FRIEND_INFO_CHANGED = WIM.BN_FRIEND_LIST_SIZE_CHANGED;


function WIM:GUILD_ROSTER_UPDATE()
	env.cache[env.realm][env.character].guildList = env.cache[env.realm][env.character].guildList or {};
        for key, _ in pairs(env.cache[env.realm][env.character].guildList) do
            env.cache[env.realm][env.character].guildList[key] = nil;
        end
	if(_G.IsInGuild()) then
		for i=1, _G.GetNumGuildMembers(true) do 
			local name = _G.GetGuildRosterInfo(i);
			if(name) then
				env.cache[env.realm][env.character].guildList[name] = true; --[set place holder for quick lookup
			end
		end
	end
	lists.guild = env.cache[env.realm][env.character].guildList;
        dPrint("Guild list updated...");
end

function IsGM(name)
        if(name == nil or name == "") then
		return false;
	end
        
        -- Blizz gave us a new tool. Lets use it.
        if(_G.GMChatFrame_IsGM and _G.GMChatFrame_IsGM(name)) then
                lists.gm[name] = 1;
                return true;
        end
        
	if(lists.gm[name]) then
		return true;
	else
		return false;
	end
end

function IsInParty(user)
    for i=1, 4 do
        if(_G.UnitName("party"..i) == user) then
            return true;
        end
    end
    return false;
end

function IsInRaid(user)
    for i=1, 40 do
        if(_G.UnitName("raid"..i) == user) then
            return true;
        end
    end
    return false;
end

function CompareVersion(v, withV)
    withV = withV or version;
    local M, m, r = string.match(v, "(%d+).(%d+).(%d+)");
    local cM, cm, cr = string.match(withV, "(%d+).(%d+).(%d+)");
    M, m = M*100000, m*1000;
    cM, cm = cM*100000, cm*1000;
    local this, that = cM+cm+cr, M+m+r;
    return that - this;
end

local talentOrder = {};
function TalentsToString(talents, class)
	--passed talents in format of "#/#/#";
        -- first check that all required information is passed.
	local t1, t2, t3 = string.match(talents or "", "(%d+)/(%d+)/(%d+)");
	if(not t1 or not t2 or not t3 or not class) then
                return talents;
        end
	
        -- next check if we even have information to show.
        if(talents == "0/0/0") then return L["None"]; end
        
        local classTbl = constants.classes[class];
	if(not classTbl) then
                return talents;
        end
        
        -- clear talentOrder
        for k, _ in pairs(talentOrder) do
                talentOrder[k] = nil;
        end
        
	--calculate which order the tabs should be in; in relation to spec.
	table.insert(talentOrder, t1.."1");
        table.insert(talentOrder, t2.."2");
        table.insert(talentOrder, t3.."3");
	table.sort(talentOrder);
	
	local fVal, f = string.match(_G.tostring(talentOrder[3]), "^(%d+)(%d)$");
        local sVal, s = string.match(_G.tostring(talentOrder[2]), "^(%d+)(%d)$");
        local tVal, t = string.match(_G.tostring(talentOrder[1]), "^(%d+)(%d)$");
        
	if(_G.tonumber(fVal)*.75 <= _G.tonumber(sVal)) then
		if(_G.tonumber(fVal)*.75 <= _G.tonumber(tVal)) then
			return L["Hybrid"]..": "..talents;
		else
			return classTbl.talent[_G.tonumber(f)].."/"..classTbl.talent[_G.tonumber(s)]..": "..talents;
		end
	else
		return classTbl.talent[_G.tonumber(f)]..": "..talents;
	end
end

function GetTalentSpec()
        local talents, tabs = "", _G.GetNumTalentTabs();
        for i=1, tabs do
                local name, iconTexture, pointsSpent, background = _G.GetTalentTabInfo(i);
                talents = i==tabs and talents..pointsSpent or talents..pointsSpent.."/";
        end
        return talents ~= "" and talents or "0/0/0";
end




-- list of PreSendFilterText(text)
local preSendFilterTextFunctions = {};
function PreSendFilterText(text)
    for i=1, #preSendFilterTextFunctions do
	text = preSendFilterTextFunctions[i](text);
    end
    return text;
end

function RegisterPreSendFilterText(func)
    if(type(func) == "function") then
        table.insert(preSendFilterTextFunctions, func);
    end
end

--[[ Example usage
RegisterPreSendFilterText(
function(text)
    return "john";
end
);
]]
