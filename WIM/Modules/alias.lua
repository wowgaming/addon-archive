-- This is an experimental module --

--imports
local WIM = WIM;
local _G = _G;
local table = table;
local pairs = pairs;
local string = string;

--set namespace
setfenv(1, WIM);

db_defaults.alias = {
    title_string = "{n} - {a}"
};

local enable_aliasing = false; -- init check.

-- create WIM Module
local Alias = CreateModule("Alias"); -- disabled by default.

function Alias:OnEnable()
    enable_aliasing = true;
end

function Alias:OnDisable()
    enable_aliasing = false;
end


-- Globals for WIM API
function getAlias(name, isRealid)
    if(not enable_aliasing) then
        return name;
    end
    -- processes alias table;
    local tbl = db.lists.alias;
    
    return name;
end

function getAliasTitle(name, isRealid)
    local alias = getAlias(name, isRealid);
    if(alias and alias ~= name) then
        return string.gsub(string.gsub(db.alias.title_string, "{n}", name), "{a}", alias);
    else
        return name;
    end
end
