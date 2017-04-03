local WIM = WIM;


--------------------------------------
--          Table Functions         --
--------------------------------------

-- Simple shallow copy for copying defaults
function copyTable(src, dest)
        if type(dest) ~= type(src) and type(src) == "table" then dest = {} end
        if type(src) == "table" then
    		for k,v in pairs(src) do
    			if type(v) == "table" then
    				-- try to index the key first so that the metatable creates the defaults, if set, and use that table
    				v = copyTable(v, dest[k])
    			end
    			dest[k] = v
    		end
    	end
    	return dest or src
end
WIM.copyTable = copyTable;

function WIM.inherritTable(src, dest, ...)
        if(type(src) == "table") then
                if(type(dest) ~= "table") then dest = {}; end
                for k, v in pairs(src) do
                        local ignoredKey = false;
                        for i=1, select("#", ...) do
                                if(tostring(k) == tostring(select(i, ...))) then
                                        ignoredKey = true;
                                        break;
                                end
                        end
                        if(not ignoredKey) then
                                if(type(v) == "table") then
                                        dest[k] = WIM.inherritTable(v, dest[k], ...);
                                else
                                        if(dest[k] == nil) then
                                                dest[k] = v
                                        end
                                end
                        end
                end
                return dest;
        else
                if(dest == nil) then
                        return src;
                else
                        return dest;
                end
        end
end

-- a simple function to add an item to a table checking for duplicates.
-- this is ok, since the table is never too large to slow things down.
function WIM.addToTableUnique(tbl, item, prioritize)
    local i;
    for i=1,table.getn(tbl) do
        if(tbl[i] == item) then
            return false;
        end
    end
    if(prioritize) then
        table.insert(tbl, 1, item);
    else
        table.insert(tbl, item);
    end
    return true;
end

-- remove item from table. Return true if removed, false otherwise.
function WIM.removeFromTable(tbl, item)
    local i;
    for i=1,table.getn(tbl) do
        if(tbl[i] == item) then
            table.remove(tbl, i);
            return true;
        end
    end
    return false;
end

function WIM.isInTable(tbl, val)
        for i=1, #tbl do
                if(tbl[i] == val) then
                        return true;
                end
        end
        return false;
end
----------------------------------------------
--              Text Formatting             --
----------------------------------------------


function WIM.FormatUserName(user)
	if(user ~= nil) then
	    user = string.gsub(user, "[A-Z]", string.lower);
	    user = string.gsub(user, "^[a-z]", string.upper);
	    user = string.gsub(user, "-[a-z]", string.upper); -- accomodate for cross server...
            user = string.gsub(user, " [a-z]", string.upper); -- accomodate second name (BN)
	end
	return user;
end


----------------------------------------------
--              Gradient Tools              --
----------------------------------------------
-- the following bits of code is a result of boredom
-- and determination to get it done. The gradient pattern
-- which I was aiming for could not be manipulated in RGB,
-- however by converting RGB to HSV, the pattern now becomes
-- linear and as such, can now be given any color and
-- have the same gradient effect applied.

function WIM.RGBPercentToHex(r, g, b)
        return string.format ("%.2x%.2x%.2x",r*255,g*255,b*255);
end

function WIM.RGBHexToPercent(rgbStr)
        local R, G, B = string.sub(rgbStr, 1, 2), string.sub(rgbStr, 3, 4), string.sub(rgbStr, 5, 6);
        return tonumber(R, 16)/255, tonumber(G, 16)/255, tonumber(B, 16)/255;
end

function WIM.RGBHextoHSVPerc(rgbStr)
    local R, G, B = WIM.RGBHexToPercent(rgbStr);
    local i, x, v, f;
    x = math.min(R, G);
    x = math.min(x, B);
    v = math.max(R, G);
    v = math.max(v, B);
    if(v == x) then
        return nil, 0, v;
    else
        if(R == x) then
            f = G - B;
        elseif(G == x) then
            f = B - R;
        else
            f = R - G;
        end
        if(R == x) then
            i = 3;
        elseif(G == x) then
            i = 5;
        else
            i = 1;
        end
        return ((i - f /(v - x))/6), (v - x)/v, v;
    end
end

function WIM.HSVPerctoRGBPerc(H, S, V)
    local m, n, f, i;
    if(H == nil) then
        return V, V, V;
    else
        H = H * 6;
        if (H == 0) then
            H=.01;
        end
        i = math.floor(H);
        f = H - i;
        if((i % 2) == 0) then
            f = 1 - f; -- if i is even
        end
        m = V * (1 - S);
        n = V * (1 - S * f);
        if(i == 6 or i == 0) then
            return V, n, m;
        elseif(i == 1) then
            return n, V, m;
        elseif(i == 2) then
            return m, V, n;
        elseif(i == 3) then
            return m, n, V;
        elseif(i == 4) then
            return n, m, V;
        elseif(i == 5) then
            return V, m, n;
        else
            return 0, 0, 0;
        end
    end
end

-- pass rgb as signle arg hex, or triple arg rgb percent.
-- entering ! before a hex, will return a solid color.
function WIM.getGradientFromColor(...)
    local h, s, v, s1, v1, s2, v2;
    if(select("#", ...) == 0) then
        return 0, 0, 0, 0, 0, 0;
    elseif(select("#", ...) == 1) then
        if(string.sub(select(1, ...),1, 1) == "!") then
            local rgbStr = string.sub(select(1, ...), 2, 7);
            local R, G, B = string.sub(rgbStr, 1, 2), string.sub(rgbStr, 3, 4), string.sub(rgbStr, 5, 6);
            return tonumber(R, 16)/255, tonumber(G, 16)/255, tonumber(B, 16)/255, tonumber(R, 16)/255, tonumber(G, 16)/255, tonumber(B, 16)/255;
        else
            h, s, v = WIM.RGBHextoHSVPerc(select(1, ...));
        end
    else
        h, s, v = WIM.RGBHextoHSVPerc(string.format ("%.2x%.2x%.2x",select(1, ...), select(2, ...), select(3, ...)));
    end

    s1 = math.min(1, s+.29/2);
    v1 = math.max(0, v-.57/2);
    s2 = math.max(0, s-.29/2);
    v2 = math.min(1, s+.57/2);
    
    local r1, g1, b1 = WIM.HSVPerctoRGBPerc(h, s1, v1);
    local r2, g2, b2 = WIM.HSVPerctoRGBPerc(h, s2, v2);
    
    return r1, g1, b1, r2, g2, b2;
end


--------------------------------------
--         String Functions         --
--------------------------------------
function WIM.paddString(str, paddingChar, minLength, paddRight)
    str = tostring(str or "");
    paddingChar = tostring(paddingChar or " ");
    minLength = tonumber(minLength or 0);
    while(string.len(str) < minLength) do
        if(paddRight) then
            str = str..paddingChar;
        else
            str = paddingChar..str;
        end
    end
    return str;
end

function WIM.gSplit(splitBy, str)
    local index, splitBy, str = 0, splitBy, str;
    return function()
        index = index + 1;
        return select(index, string.split(splitBy, str));
    end
end

function WIM.SplitToTable(str, inSplitPattern, outResults )
  if not outResults then
    return;
  end
  local theStart = 1
  local theSplitStart, theSplitEnd = string.find( str, inSplitPattern, theStart )
  while theSplitStart do
    table.insert( outResults, string.sub( str, theStart, theSplitStart-1 ) )
    theStart = theSplitEnd + 1
    theSplitStart, theSplitEnd = string.find( str, inSplitPattern, theStart )
  end
  table.insert( outResults, string.sub( str, theStart ) )
  --if(#outResults > 0) then
  --  table.remove(outResults, 1);
  --end
end



--------------------------------------
--      Debugging Functions         --
--------------------------------------
function WIM.dPrint(t)
    if WIM.debug then
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[WIM Debug]:|r "..tostring(t));
    end
end


function dumpGlobals()
    local tmp = {};
    for var, _ in pairs(_G) do
        table.insert(tmp, var);
    end
    table.sort(tmp);
    return tmp;
end
