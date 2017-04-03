--imports
local WIM = WIM;
local _G = _G;
local strsub = strsub;
local string = string;
local format = format;
local table = table;
local type = type;
local pairs = pairs;

--set namespace
setfenv(1, WIM);

db_defaults.displayColors.webAddress = {
    r = 1,
    g = 1,
    b = 1
};

local URL = CreateModule("URLHandler", true);

armoryLinks = {
    {
        title = "Armory-Light",
        url = "http://www.armory-light.com/{eu/us}/{realm}/{user}"
    },
    {
        title = "ArmoryLite",
        url = "http://armorylite.com/{eu/us}/{realm}/{user}"
    },
    {
        title = "Be Imba!",
        url = "http://be.imba.hu/?zone={EU/US}&realm={realm}&character={user}"
    },
    {
        title = "Warcrafter",
        url = "http://{realm}-{eu/us}.warcrafter.net/{user}"
    },
    {
        title = "WoW Armory",
        url = "http://{eu/www}.wowarmory.com/character-sheet.xml?r={realm}&n={user}"
    },
    {
        title = "WoW-Heroes",
        url = "http://www.wow-heroes.com/index.php?zone={eu/us}&server={realm}&name={user}"
    },
    {
		title = "Wowhead Profiler",
		url = "http://www.wowhead.com/?profile={eu/us}.{realm-}.{user}",
    }
};

-- patterns created by Sylvanaar & used in Prat
local patterns = {
	-- X@X.Y url (---> email)
	"^(www%.[%w_-]+%.%S+[^%p%s])",
	"%s(www%.[%w_-]+%.%S+[^%p%s])",
	-- XXX.YYY.ZZZ.WWW:VVVV/UUUUU url
	"^(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?:%d%d?%d?%d?%d?/%S+[^%p%s])",
	"%s(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?:%d%d?%d?%d?%d?/%S+[^%p%s])",
	-- XXX.YYY.ZZZ.WWW:VVVV url (IP of ts server for example)
	"^(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?:%d%d?%d?%d?%d?)", 
	"%s(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?:%d%d?%d?%d?%d?)", 
	-- XXX.YYY.ZZZ.WWW/VVVVV url (---> IP)
	"^(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?/%S+[^%p%s])", 
	"%s(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?/%S+[^%p%s])", 
	-- XXX.YYY.ZZZ.WWW url (---> IP)
	"^(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?)", 
	"%s(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?)",
	-- X.Y.Z:WWWW/VVVVV url
	"^([%w_.-]+[%w_-]%.%a%a+:%d%d?%d?%d?%d?/%S+[^%p%s])", 
	"%s([%w_.-]+[%w_-]%.%a%a+:%d%d?%d?%d?%d?/%S+[^%p%s])", 
	-- X.Y.Z:WWWW url  (ts server for example)
	"^([%w_.-]+[%w_-]%.%a%a+:%d%d?%d?%d?%d?)", 
	"%s([%w_.-]+[%w_-]%.%a%a+:%d%d?%d?%d?%d?)", 
	-- X.Y.Z/WWWWW url
	"^([%w_.-]+[%w_-]%.%a%a+/%S+[^%p%s])", 
	"%s([%w_.-]+[%w_-]%.%a%a+/%S+[^%p%s])", 
	-- X.Y.Z url
	"^([%w_.-]+[%w_-]%.%a%a+)", 
	"%s([%w_.-]+[%w_-]%.%a%a+)", 
	-- X://Y url
	"(%a+://[%d%w_-%.]+[%.%d%w_%-%/%?%%%=%;%:%+%&]*)", 
};	


local LinkRepository = {};

local function formatRawURL(theURL)
    if(type(theURL) ~= "string" or theURL == "") then
        return "";
    else
        theURL = theURL:gsub('%%', '%%%%'); --make sure any %'s are escaped in order to preserve them.
        return " |cff"..RGBPercentToHex(db.displayColors.webAddress.r, db.displayColors.webAddress.g, db.displayColors.webAddress.b).."|Hwim_url:"..theURL.."|h".."["..theURL.."]".."|h|r";
    end
end

local function encodeColors(theMsg)
    theMsg = string.gsub(theMsg, "|c", "\001\002");
    theMsg = string.gsub(theMsg, "|r", "\001\003");
    return theMsg;
end

local function decodeColors(theMsg)
    theMsg = string.gsub(theMsg, "\001\002", "|c");
    theMsg = string.gsub(theMsg, "\001\003", "|r");
    return theMsg;
end

local function convertURLtoLinks(text)
        -- clean text first
        local theMsg = text;
        local results;
        theMsg = encodeColors(theMsg);
        repeat
            theMsg, results = string.gsub(theMsg, "(|H[^|]+|h[^|]+|h)", function(theLink)
                table.insert(LinkRepository, theLink);
                return "\001\004"..#LinkRepository;
            end, 1);
        until results == 0;
        
        -- create urls
        for i=1, table.getn(patterns) do
            theMsg = string.gsub(theMsg, patterns[i], formatRawURL);
        end
        
        --restore links
        for i=1, #LinkRepository do
            theMsg = string.gsub(theMsg, "\001\004"..i.."", LinkRepository[i]);
        end
        
        -- clear table to be recycled by next process
        for key, _ in pairs(LinkRepository) do
            LinkRepository[key] = nil;
        end
        
	return decodeColors(theMsg);
end

local function modifyURLs(str)
    return convertURLtoLinks(str);
end


function URL:OnEnable()
    RegisterStringModifier(modifyURLs, true);
end

function URL:OnDisable()
    UnregisterStringModifier(modifyURLs);
end


local function isLinkTypeURL(link)
	if (strsub(link, 1, 7) == "wim_url") then
		return true;
	else
		return false;
	end
end

local function displayURL(link)
    local theLink = "";
    if (string.len(link) > 4) and (string.sub(link,1,8) == "wim_url:") then
	theLink = string.sub(link,9, string.len(link));
    end
    -- The following code was written by Sylvannar.
    _G.StaticPopupDialogs["WIM_SHOW_URL"] = {
        text = "URL : %s",
        button2 = _G.TEXT(_G.ACCEPT),
        hasEditBox = 1,
        hasWideEditBox = 1,
        showAlert = 1, -- HACK : it"s the only way I found to make de StaticPopup have sufficient width to show WideEditBox :(
        OnShow = function(self)
                self = self or _G.this; -- tbc hack
                local editBox = _G.getglobal(self:GetName().."WideEditBox");
                editBox:SetText(format(theLink));
                editBox:SetFocus();
                editBox:HighlightText(0);
    
                local button = _G.getglobal(self:GetName().."Button2");
                button:ClearAllPoints();
                button:SetWidth(100);
                button:SetPoint("CENTER", editBox, "CENTER", 0, -30);
    
                _G.getglobal(self:GetName().."AlertIcon"):Hide();  -- HACK : we hide the false AlertIcon
            end,
        OnHide = function() end,
        OnAccept = function() end,
        OnCancel = function() end,
        EditBoxOnEscapePressed = function(self)
                self = self or _G.this; -- tbc hack
                self:GetParent():Hide();
            end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };        
    _G.StaticPopup_Show ("WIM_SHOW_URL", theLink);
end

WIM.RegisterItemRefHandler("wim_url", displayURL);

--context menu
local function MENU_ARMORY_CLICKED(self)
    local eu_www = isUS and "www" or "eu";
    local eu_us = isUS and "us" or "eu";
    local user, realm;
    if(MENU_ARMORY_USER:find("-")) then
        user, realm = string.split("-", MENU_ARMORY_USER);
    else
        user = MENU_ARMORY_USER;
    end
    realm = realm or MENU_ARMORY_REALM;
    local link = self.value;
    link = link:gsub("{eu/www}", eu_www);
    link = link:gsub("{realm}", realm);
    link = link:gsub("{realm%-}", ""..realm:gsub(" ","-"));
    link = link:gsub("{user}", user);
    link = link:gsub("{eu/us}", eu_us);
    link = link:gsub("{EU/US}", string.upper(eu_us));
    displayURL("wim_url:"..link);
end

-- this menu is not available for private servers.. der..
if(not isPrivateServer) then
    local info = _G.UIDropDownMenu_CreateInfo();
    info.text = "MENU_ARMORY";
    local armoryMenu = AddContextMenu(info.text, info);
        info.text = L["Profile Links"];
        info.notCheckable = true;
        info.isTitle = true;
        armoryMenu:AddSubItem(AddContextMenu("MENU_ARMORY_TITLE", info));
        for i=1, #armoryLinks do
            local info = _G.UIDropDownMenu_CreateInfo();
            info.text = armoryLinks[i].title;
            info.value = armoryLinks[i].url;
            info.notCheckable = true;
            info.func = MENU_ARMORY_CLICKED;
            armoryMenu:AddSubItem(AddContextMenu("MENU_ARMORY"..i, info));
        end
        --armoryMenu:AddSubItem(GetContextMenu("MENU_CANCEL"));
end
