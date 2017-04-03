--[[
    This is a recontruction of the Huffman Compression method included in
    LibCompress. The origional was creating too much garbage so I have
    included this modified algorythm. The compressed data is also escaped
    for safe transmits through the AddonMessage Channel. (Thanks to Stewarta).
]]

-- includes
local WIM = WIM;
local _G = _G;
local table = table;
local pairs = pairs;
local string = string;
local type = type;
local unpack = unpack;
local math = math;
local bit = bit;
local tostring = tostring;
local setmetatable = setmetatable;
local rawset = rawset;
local rawget = rawget;
local next = next;
local select = select;
local math = math;

-- set namespace
setfenv(1, WIM);



-- clears all data found within the passed tables.
local function clearTables(...)
    for i=1, select("#", ...) do
        local tbl = select(i, ...);
        if(type(tbl) == "table") then
            setmetatable(tbl, nil);
            for i=#tbl, 1, -1 do
                table.remove(tbl, i);
            end
            for k, v in pairs(tbl) do
                tbl[k] = nil;
            end
        end
    end
end

-- Table Recycling
 tblInUse = {};
 tblAvailable = {};

local function getNewTable()
    if(#tblAvailable > 0) then
        local tbl = table.remove(tblAvailable, #tblAvailable);
        table.insert(tblInUse, tbl);
        return tbl;
    else
        local tbl = {};
        table.insert(tblInUse, tbl);
        return tbl;
    end
end

local function freeTables()
    clearTables(unpack(tblInUse));
    for i=#tblInUse, 1, -1 do
        table.insert(tblAvailable, table.remove(tblInUse, i));
    end
end




-- thank you stewarta
local function huff_encode(thestr)
	thestr=thestr:gsub("\001","\002\003");
	thestr=thestr:gsub("%z","\002\004");
	return thestr;
end

local function huff_decode(thestr)
	thestr=thestr:gsub("\002\004","\000");
	thestr=thestr:gsub("\002\003","\001");
	return thestr;
end

--------------------------------------------------------------------------------
-- Huffman codec
-- implemented by Galmok of European Stormrage (Horde), galmok@gmail.com

local function addCode(tree, bcode,len)
    if tree then
	tree.bcode = bcode;
	tree.blength = len;
	if tree.c1 then
	    addCode(tree.c1, bit.bor(bcode, bit.lshift(1,len)), len+1);
	end
	if tree.c2 then
	    addCode(tree.c2, bcode, len+1);
	end
    end
end

local function escape_code(code, len)
    local escaped_code = 0;
    local b;
    local l = 0;
    for i = len-1, 0,- 1 do
	b = bit.band( code, bit.lshift(1,i))==0 and 0 or 1;
	escaped_code = bit.lshift(escaped_code,1+b) + b;
	l = l + b;
    end
    return escaped_code, len+l;
end

local Huffman_compressed = {};
local Huffman_large_compressed = {};

local compressed_size = 0
local remainder;
local remainder_length;
local function addBits(tbl, code, len)
    remainder = remainder + bit.lshift(code, remainder_length);
    remainder_length = len + remainder_length;
    if remainder_length > 32 then
	return true; -- Bits lost due to too long code-words.
    end
    while remainder_length>=8 do
	compressed_size = compressed_size + 1;
	tbl[compressed_size] = string.char(bit.band(remainder, 255));
	remainder = bit.rshift(remainder, 8);
	remainder_length = remainder_length -8;
    end
end

local hist = {};
local leafs = {};
local symbols = {};
local huff = {};

local function cleanCompress()
    compressed_size = 0;
    freeTables();
    clearTables(Huffman_compressed, Huffman_large_compressed, hist, leafs, symbols, huff);
end

-- word size for this huffman algorithm is 8 bits (1 byte). This means the best compression is representing 1 byte with 1 bit, i.e. compress to 0.125 of original size.
local function CompressHuffman(uncompressed)
    compressed_size = 0;
    if not type(uncompressed)=="string" then
        cleanCompress();
        return nil, "Can only compress strings";
    end

    -- make histogram
    local n = 0;
    -- dont have to use all datat to make the histogram
    local uncompressed_size = string.len(uncompressed)
    local c;
    for i = 1, uncompressed_size do
	c = string.byte(uncompressed, i)
	hist[c] = (hist[c] or 0) + 1
    end

    --Start with as many leaves as there are symbols.
    local leaf;
    
    for symbol, weight in pairs(hist) do
        leaf = getNewTable();
        leaf.symbol=string.char(symbol);
        leaf.weight=weight;
	symbols[symbol] = leaf;
	table.insert(leafs, leaf);
    end
    --Enqueue all leaf nodes into the first queue (by probability in increasing order so that the least likely item is in the head of the queue).
    table.sort(leafs, function(a,b) if a.weight<b.weight then return true elseif a.weight>b.weight then return false else return nil end end)

    local nLeafs = #leafs
    
    --While there is more than one node in the queues:
    local l,h, li, hi, leaf1, leaf2
    local newNode;
    while (#leafs+#huff > 1) do
	-- Dequeue the two nodes with the lowest weight.
	-- Dequeue first
	if not next(huff) then
	    li, leaf1 = next(leafs)
			table.remove(leafs, li)
	elseif not next(leafs) then
	    hi, leaf1 = next(huff)
	    table.remove(huff, hi)
	else
	    li, l = next(leafs);
	    hi, h = next(huff);
	    if l.weight<=h.weight then
		leaf1 = l;
		    table.remove(leafs, li);
	    else
		leaf1 = h;
		table.remove(huff, hi);
	    end
	end
	-- Dequeue second
	if not next(huff) then
	    li, leaf2 = next(leafs);
	    table.remove(leafs, li);
	elseif not next(leafs) then
	    hi, leaf2 = next(huff);
	    table.remove(huff, hi);
	else
	    li, l = next(leafs);
	    hi, h = next(huff);
	    if l.weight<=h.weight then
		leaf2 = l;
		table.remove(leafs, li);
	    else
		leaf2 = h;
		table.remove(huff, hi);
	    end
	end

	--Create a new internal node, with the two just-removed nodes as children (either node can be either child) and the sum of their weights as the new weight.
        newNode = getNewTable();
        newNode.c1 = leaf1;
        newNode.c2 = leaf2;
        newNode.weight = leaf1.weight+leaf2.weight;
	table.insert(huff,newNode);
    end
    if #leafs>0 then
	li, l = next(leafs);
	table.insert(huff, l);
	table.remove(leafs, li);
    end
    local _huff = huff[1];

    -- assign codes to each symbol
    -- c1 = "0", c2 = "1"
    -- As a common convention, bit '0' represents following the left child and bit '1' represents following the right child.
    -- c1 = left, c2 = right

    addCode(_huff,0,0);
    if _huff then
	_huff.bcode = 0
	_huff.blength = 1
    end
	
    -- WRITING
    remainder = 0;
    remainder_length = 0;
	
    local compressed = Huffman_compressed;
    --compressed_size = 0

    -- first byte is version info. 0 = uncompressed, 1 = 8-bit word huffman compressed
    compressed[1] = "\003";
	
    -- Header: byte 0=#leafs, byte 1-3=size of uncompressed data
    -- max 2^24 bytes
    local l = string.len(uncompressed);
    compressed[2] = string.char(bit.band(nLeafs-1, 255));		-- number of leafs
    compressed[3] = string.char(bit.band(l, 255));			-- bit 0-7
    compressed[4] = string.char(bit.band(bit.rshift(l, 8), 255));	-- bit 8-15
    compressed[5] = string.char(bit.band(bit.rshift(l, 16), 255));	-- bit 16-23
    compressed_size = 5;
	
    -- create symbol/code map
    for symbol, leaf in pairs(symbols) do
	addBits(compressed, symbol, 8);
	if addBits(compressed, escape_code(leaf.bcode, leaf.blength)) then
	    -- code word too long. Needs new revision to be able to handle more than 32 bits
            cleanCompress();
	    return string_char(0)..uncompressed
	end
	addBits(compressed, 3, 2);
    end

	-- create huffman code
    local large_compressed = Huffman_large_compressed;
    local large_compressed_size = 0;
    local ulimit;
    for i = 1, l, 200 do
	ulimit = l<(i+199) and l or (i+199);
	for sub_i = i, ulimit do
	    c = string.byte(uncompressed, sub_i);
	    addBits(compressed, symbols[c].bcode, symbols[c].blength);
	end
	large_compressed_size = large_compressed_size + 1;
	large_compressed[large_compressed_size] = table.concat(compressed, "", 1, compressed_size);
	compressed_size = 0;
    end
	
    -- add remainding bits (if any)
    if remainder_length>0 then
	large_compressed_size = large_compressed_size + 1;
	large_compressed[large_compressed_size] = string.char(remainder);
    end
    local compressed_string = table.concat(large_compressed, "", 1, large_compressed_size);
	
    -- is compression worth it? If not, return uncompressed data.
    if (#uncompressed+1) <= #compressed_string then
        cleanCompress();
	--return "\001"..uncompressed;
        return uncompressed;
    end
    cleanCompress();
    return compressed_string;
end

-- lookuptable (cached between calls)
local lshiftMask = {};
local lshiftMask_metamap = {
    __index = function (t, k)
	local v = bit.lshift(1, k);
	rawset(t, k, v);
	return v;
    end
}

-- lookuptable (cached between calls)
local lshiftMinusOneMask = {};
local lshiftMinusOneMask_metamap = {
    __index = function (t, k)
	local v = bit.lshift(1, k)-1;
	rawset(t, k, v);
	return v;
    end
};

local function getCode(bitfield, field_len)
    if field_len>=2 then
	local b;
	local p = 0;
	for i = 0, field_len-1 do
	    b = bit.band(bitfield, lshiftMask[i]);
	    if not (p==0) and not (b == 0) then
		-- found 2 bits set right after each other (stop bits)
		return bit.band( bitfield, lshiftMinusOneMask[i-1]), i-1, 
			    bit.rshift(bitfield, i+1), field_len-i-1;
	    end
	    p = b;
	end
    end
    return nil;
end

local function unescape_code(code, code_len)
    local unescaped_code=0;
    local b;
    local l = 0;
    local i = 0
    while i < code_len do
	b = bit.band( code, lshiftMask[i]);
	if not (b==0) then
	    unescaped_code = bit.bor(unescaped_code, lshiftMask[l]);
	    i = i + 1;
	end
	i = i + 1;
	l = l + 1;
    end
    return unescaped_code, l;
end

local Huffman_uncompressed = {};
local Huffman_large_uncompressed = {}; -- will always be as big as the larges string ever decompressed. Bad, but clearing i every timetakes precious time.
local map = {}; -- only table not reused in Huffman decode.
local mt = {};

local function cleanDecompress()
    freeTables();
    clearTables(Huffman_uncompressed, Huffman_large_uncompressed, map, lshiftMask, lshiftMinusOneMask);
end

local map_metatable1 = {
    __index = function (t, k)
                local v = getNewTable();
		rawset(t, k, v)
		return v
            end
};

local map_metatable2 = {
    __index = function (t, k)
                return mt 
            end
};

local function DecompressHuffman(compressed)
    setmetatable(lshiftMask, lshiftMask_metamap);
    setmetatable(lshiftMinusOneMask, lshiftMinusOneMask_metamap);
    if type(compressed) ~= "string" then
        cleanDecompress();
	return nil, "Can only uncompress strings"
    end

    local compressed_size = string.len(compressed);
    --decode header
    local info_byte = string.byte(compressed)
    -- is data compressed
    if info_byte==1 then
        cleanDecompress();
	return compressed:sub(2) --return uncompressed data
    end
    if not (info_byte==3) then
        cleanDecompress();
	return compressed --, "Can only decompress Huffman compressed data ("..tostring(info_byte)..")"
    end

    local num_symbols = string.byte(string.sub(compressed, 2, 2)) + 1
    local c0 = string.byte(string.sub(compressed, 3, 3))
    local c1 = string.byte(string.sub(compressed, 4, 4))
    local c2 = string.byte(string.sub(compressed, 5, 5))
    local orig_size = c2*65536 + c1*256 + c0
    if orig_size==0 then
        cleanDecompress();
	return "";
    end

    -- decode code->symbal map
    local bitfield = 0;
    local bitfield_len = 0;
    
    setmetatable(map, map_metatable1)
	
    local i = 6; -- byte 1-5 are header bytes
    local c, cl;
    local minCodeLen = 1000;
    local maxCodeLen = 0;
    local symbol, code, code_len, _bitfield, _bitfield_len;
    local n = 0;
    local state = 0; -- 0 = get symbol (8 bits),  1 = get code (varying bits, ends with 2 bits set)
    while n<num_symbols do
	if i>compressed_size then
            cleanDecompress();
	    return nil, "Cannot decode map"
	end

	c = string.byte(compressed, i)
	bitfield = bit.bor(bitfield, bit.lshift(c, bitfield_len))
	bitfield_len = bitfield_len + 8
		
	if state == 0 then
	    symbol = bit.band(bitfield, 255)
	    bitfield = bit.rshift(bitfield, 8)
	    bitfield_len = bitfield_len -8
	    state = 1 -- search for code now
	else
	    code, code_len, _bitfield, _bitfield_len = getCode(bitfield, bitfield_len)
	    if code then
		bitfield, bitfield_len = _bitfield, _bitfield_len
		c, cl = unescape_code(code, code_len)
		map[cl][c]=string.char(symbol)
		minCodeLen = math.min(minCodeLen, cl); --cl<minCodeLen and cl or minCodeLen
		maxCodeLen = math.max(maxCodeLen, cl); --cl>maxCodeLen and cl or maxCodeLen
		--print("symbol: "..string_char(symbol).."  code: "..tobinary(c, cl))
		n = n + 1
		state = 0 -- search for next symbol (if any)
	    end
	end
	    i=i+1
    end
	
    -- dont create new subtables for entries not in the map. Waste of space.
    -- But do return an empty table to prevent runtime errors. (instead of returning nil)
    setmetatable(map, map_metatable2);
	
    local uncompressed = Huffman_uncompressed
    local large_uncompressed = Huffman_large_uncompressed
    local uncompressed_size = 0
    local large_uncompressed_size = 0
    local test_code
    local test_code_len = minCodeLen;
    local symbol;
    local dec_size = 0;
    compressed_size = compressed_size + 1
    local temp_limit = 200; -- first limit of uncompressed data. large_uncompressed will hold strings of length 200
    while true do
	if test_code_len<=bitfield_len then 
	    test_code=bit.band( bitfield, lshiftMinusOneMask[test_code_len])
	    symbol = map[test_code_len][test_code]
	    if symbol then
		uncompressed_size = uncompressed_size + 1
		uncompressed[uncompressed_size]=symbol
		dec_size = dec_size + 1
                if dec_size>=orig_size then -- checked here for speed reasons
		    break;
                end
		if dec_size >= temp_limit then
		    -- process compressed bytes in smaller chunks
		    large_uncompressed_size = large_uncompressed_size + 1
		    large_uncompressed[large_uncompressed_size] = table.concat(uncompressed, "", 1, uncompressed_size)
		    uncompressed_size = 0
		    temp_limit = temp_limit + 200 -- repeated chunk size is 200 uncompressed bytes
		    temp_limit = temp_limit > orig_size and orig_size or temp_limit
		end
		bitfield = bit.rshift(bitfield, test_code_len)
		bitfield_len = bitfield_len - test_code_len
		test_code_len = minCodeLen
	    else
		test_code_len = test_code_len + 1
		if test_code_len>maxCodeLen then
                    cleanDecompress();
		    return nil, "Decompression error at "..tostring(i).."/"..tostring(#compressed)
		end
	    end
	else
	    c = string.byte(compressed, i)
	    bitfield = bitfield + bit.lshift(c or 0, bitfield_len)
	    bitfield_len = bitfield_len + 8
	    i = i + 1
	    if i > temp_limit then
		if i > compressed_size then
		    break;
		end
	    end
	end
    end
    local out = table.concat(large_uncompressed, "", 1, large_uncompressed_size)..table.concat(uncompressed, "", 1, uncompressed_size);
    cleanDecompress();
    return out;
end


function Compress(uncompressed)
    if(not uncompressed) then
        return uncompressed;
    end
    local str, err = CompressHuffman(uncompressed);
    return huff_encode(str);
end

function Decompress(compressed)
    return DecompressHuffman(huff_decode(compressed));
end
