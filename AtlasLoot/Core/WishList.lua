--[[
File containing functions related to the wish list.

Functions:
AtlasLoot_ShowWishList()
AtlasLoot_AddToWishlist(itemID, itemTexture, itemName, lootPage, sourcePage)
AtlasLoot_DeleteFromWishList(itemID)
AtlasLoot_WishListSort()
AtlasLoot_WishListSortCheck(temp1, temp2)
local RecursiveSearchZoneName(dataTable, zoneID)
AtlasLoot_GetWishListSubheading(dataID)
AtlasLoot_CategorizeWishList(wlTable)
AtlasLoot_GetWishListPage(page)
AtlasLoot_WishListCheck(itemID, all)
AtlasLoot_GetWishLists([playerName])
AtlasLoot_CheckWishlistItem(itemID ,[playerName ,[wishlist] ])

<local> ClearLines()
<local> AddWishListOptions(parrent,name,icon,xxx,tabname,tab2)
<local> AddTexture(par, num)
AtlasLoot_RefreshWishlists()
AtlasLoot_CreateWishlistOptions()
]]

local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BabbleFaction = AtlasLoot_GetLocaleLibBabble("LibBabble-Faction-3.0")

local ALModule = AtlasLoot:NewModule("WishList", "AceSerializer-3.0", "AceComm-3.0")

AtlasLoot_WishListDrop = AceLibrary("Dewdrop-2.0");

AtlasLoot_WishList = nil;
local currentPage = 1;
local playerName = UnitName("player")
local itemID, itemTexture, itemName, lootPage, sourcePage, lasttyp, xtyp, xarg2, xarg3
local lastWishListtyp, lastWishListarg2, lastWishListarg3
local OptionsLoadet = false

local ShareWishlistPref = "AtlasLootWishlist"

AtlasLootWishList = {}

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

--[[
AtlasLoot_ShowWishList()
Displays the WishList
]]
function AtlasLoot_ShowWishList()
	if lastWishListtyp == "addOwn" then
		AtlasLoot_ShowItemsFrame("WishList", "WishListPage"..currentPage, AtlasLootWishList["Own"][playerName][lastWishListarg2]["info"][1], pFrame);
	elseif lastWishListtyp == "addOther" then
		AtlasLoot_ShowItemsFrame("WishList", "WishListPage"..currentPage, AtlasLootWishList["Own"][lastWishListarg2][lastWishListarg3]["info"][1], pFrame);
	elseif lastWishListtyp == "addShared" then
		AtlasLoot_ShowItemsFrame("WishList", "WishListPage"..currentPage, AtlasLootWishList["Shared"][lastWishListarg2][lastWishListarg3]["info"][1], pFrame);
	end
end

--[[
CheckTable(tab)
Check tables for content
]]	
local function CheckTable(tab)
	for k,v in pairs(tab) do
		if k then
			return true
		end
	end
	return false
end

--[[
AtlasLoot_WishListAddDropClick(typ, arg2, arg3, arg4)
Add a item too the wishlist or show the selectet wishlist
]]	
function AtlasLoot_WishListAddDropClick(typ, arg2, arg3, arg4)
	if arg4 == true then
		if typ == "addOwn" then
			lastWishListtyp = typ
			lastWishListarg2 = arg2
			AtlasLoot_ShowWishList()
			AtlasLoot_WishListDrop:Close(1)
		elseif typ == "addOther" then
			lastWishListtyp = typ
			lastWishListarg2 = arg2
			lastWishListarg3 = arg3
			AtlasLoot_ShowWishList()
			AtlasLoot_WishListDrop:Close(1)
		elseif typ == "addShared" then
			lastWishListtyp = typ
			lastWishListarg2 = arg2
			lastWishListarg3 = arg3
			AtlasLoot_ShowWishList()
			AtlasLoot_WishListDrop:Close(1)
		end
	else
		xtyp = typ
		xarg2 = arg2
		xarg3 = arg3
		if typ == "addOwn" then
			if AtlasLoot_WishListCheck(itemID) then
				DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..AtlasLoot_FixText(itemName)..RED..AL[" already in the WishList!"]..WHITE.." ("..AtlasLootWishList["Own"][playerName][arg2]["info"][1]..")");
				return;
			end

			table.insert(AtlasLootWishList["Own"][playerName][arg2], { 0, itemID, itemTexture, itemName, lootPage, "", "", sourcePage });

			DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot"]..": "..AtlasLoot_FixText(itemName)..GREY..AL[" added to the WishList."]..WHITE.." ("..AtlasLootWishList["Own"][playerName][arg2]["info"][1]..")");
			AtlasLoot_WishList = AtlasLoot_CategorizeWishList(AtlasLootWishList["Own"][playerName][arg2]);

			AtlasLoot_WishListDrop:Close(1)
		elseif typ == "addOther" then
			if AtlasLoot_WishListCheck(itemID) then
				DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..AtlasLoot_FixText(itemName)..RED..AL[" already in the WishList!"]..WHITE.." ("..AtlasLootWishList["Own"][arg2][arg3]["info"][1].." - "..arg2..")");
				return;
			end

			table.insert(AtlasLootWishList["Own"][arg2][arg3], { 0, itemID, itemTexture, itemName, lootPage, "", "", sourcePage });

			DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot"]..": "..AtlasLoot_FixText(itemName)..GREY..AL[" added to the WishList."]..WHITE.." ("..AtlasLootWishList["Own"][arg2][arg3]["info"][1].." - "..arg2..")");
			AtlasLoot_WishList = AtlasLoot_CategorizeWishList(AtlasLootWishList["Own"][arg2][arg3]);

			AtlasLoot_WishListDrop:Close(1)
		elseif typ == "addShared" then
			if AtlasLoot_WishListCheck(itemID) then
				DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..AtlasLoot_FixText(itemName)..RED..AL[" already in the WishList!"]..WHITE.." ("..AtlasLootWishList["Shared"][arg2][arg3]["info"][1].." - "..arg2..")");
				return;
			end

			table.insert(AtlasLootWishList["Shared"][arg2][arg3], { 0, itemID, itemTexture, itemName, lootPage, "", "", sourcePage });

			DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot"]..": "..AtlasLoot_FixText(itemName)..GREY..AL[" added to the WishList."]..WHITE.." ("..AtlasLootWishList["Shared"][arg2][arg3]["info"][1].." - "..arg2..")");
			AtlasLoot_WishList = AtlasLoot_CategorizeWishList(AtlasLootWishList["Shared"][arg2][arg3]);

			AtlasLoot_WishListDrop:Close(1)
		end
	end
end

--[[
AtlasLoot_ShowWishListDropDown(xitemID, xitemTexture, xitemName, xlootPage, xsourcePage, button, show)
Show the dropdownlist with the wishlists
]]	
function AtlasLoot_ShowWishListDropDown(xitemID, xitemTexture, xitemName, xlootPage, xsourcePage, button, show)
	itemID, itemTexture, itemName, lootPage, sourcePage = xitemID, xitemTexture, xitemName, xlootPage, xsourcePage
	if AtlasLootWishList["Options"][playerName]["UseDefaultWishlist"] == false then
				if AtlasLoot_WishListDrop:IsOpen(button) then
					AtlasLoot_WishListDrop:Close(1);
				else
					local setOptions = function(level, value)
						if level == 1 then
							AtlasLoot_WishListDrop:AddLine(
								"text", AL["Own Wishlists"],
								"tooltipTitle", AL["Own Wishlists"],
								--"tooltipText", "",
								"value", "OwnWishlists",
								"arg1", "1",
								"hasArrow", true,
								"func", AtlasLoot_WishListAddDropClick,
								"notCheckable", true
							);
							AtlasLoot_WishListDrop:AddLine(
								"text", AL["Other Wishlists"],
								"tooltipTitle", AL["Other Wishlists"],
								--"tooltipText", "",
								"value", "OtherWishlists",
								"arg1", "1",
								"hasArrow", true,
								"func", AtlasLoot_WishListAddDropClick,
								"notCheckable", true
							);
							AtlasLoot_WishListDrop:AddLine(
								"text", AL["Shared Wishlists"],
								"tooltipTitle", AL["Shared Wishlists"],
								--"tooltipText", "",
								"value", "SharedWishlists",
								"arg1", "1",
								"hasArrow", true,
								"func", AtlasLoot_WishListAddDropClick,
								"notCheckable", true
							);
							AtlasLoot_WishListDrop:AddLine(
								"text", AL["Options"],
								"func", function() InterfaceOptionsFrame_OpenToCategory(AL["AtlasLoot"]); AtlasLoot_WishListDrop:Close(1) end,
								"notCheckable", true
							);
							AtlasLoot_WishListDrop:AddLine(
								"text", AL["Close"],
								"func", function() AtlasLoot_WishListDrop:Close(1) end,
								"notCheckable", true
							);
						elseif level == 2 then
							if value == "OwnWishlists" then
								for k,v in pairs(AtlasLootWishList["Own"][playerName]) do
									AtlasLoot_WishListDrop:AddLine(
										"text", AtlasLootWishList["Own"][playerName][k]["info"][1],
										"tooltipTitle", AtlasLootWishList["Own"][playerName][k]["info"][1],
										"tooltipText", "",
										"func", AtlasLoot_WishListAddDropClick,
										"arg1", "addOwn",
										"arg2", k,
										"arg3", "",
										"arg4", show,
										"notCheckable", true
									);
								end
							elseif value == "OtherWishlists" then
								for k,v in pairs(AtlasLootWishList["Own"]) do
									if k ~= playerName then
										if CheckTable(AtlasLootWishList["Own"][k]) then
											AtlasLoot_WishListDrop:AddLine(
												"text", k,
												"tooltipTitle", k,
												--"tooltipText", "",
												"func", AtlasLoot_WishListAddDropClick,
												"value", k,
												"arg1", "1",
												"hasArrow", true,
												"notCheckable", true
											);
										end
									end
								end
							elseif value == "SharedWishlists" then
								for k,v in pairs(AtlasLootWishList["Shared"]) do
									if k ~= playerName then
										if CheckTable(AtlasLootWishList["Shared"][k]) then
											AtlasLoot_WishListDrop:AddLine(
												"text", k,
												"tooltipTitle", k,
												--"tooltipText", "",
												"func", AtlasLoot_WishListAddDropClick,
												"value", k,
												"arg1", "1",
												"hasArrow", true,
												"notCheckable", true
											);
										end
									end
								end
							end
						elseif level == 3 then
								for k,v in pairs(AtlasLootWishList["Own"]) do
									if value == k then
										for i,j in pairs(AtlasLootWishList["Own"][k]) do
											AtlasLoot_WishListDrop:AddLine(
												"text", AtlasLootWishList["Own"][k][i]["info"][1],
												"tooltipTitle", AtlasLootWishList["Own"][k][i]["info"][1],
												"tooltipText", "",
												"func", AtlasLoot_WishListAddDropClick,
												"arg1", "addOther",
												"arg2", k,
												"arg3", i,
												"arg4", show,
												"value", 
												"notCheckable", true
											);
										end
									end
								end
								for k,v in pairs(AtlasLootWishList["Shared"]) do
									if value == k then
										for i,j in pairs(AtlasLootWishList["Shared"][k]) do
											AtlasLoot_WishListDrop:AddLine(
												"text", AtlasLootWishList["Shared"][k][i]["info"][1],
												"tooltipTitle", AtlasLootWishList["Shared"][k][i]["info"][1],
												"tooltipText", "",
												"func", AtlasLoot_WishListAddDropClick,
												"arg1", "addShared",
												"arg2", k,
												"arg3", i,
												"arg4", show,
												"value", 
												"notCheckable", true
											);
										end
									end
								end
						end
					end
					AtlasLoot_WishListDrop:Open(button,
						"point", function(parent)
							return "TOPLEFT", "TOPRIGHT";
						end,
						"children", setOptions
					);
				end
	else
		for k,v in pairs(AtlasLootWishList["Own"][playerName]) do
			if AtlasLootWishList["Own"][playerName][k]["info"] then
				if AtlasLootWishList["Own"][playerName][k]["info"][2][playerName] == true then
					AtlasLoot_WishListAddDropClick("addOwn", k, "", show)
					return
				end
			end
		end
		
		for k,v in pairs(AtlasLootWishList["Own"]) do
			if AtlasLootWishList["Own"][k] then
				for i,j in pairs(AtlasLootWishList["Own"][k]) do
					if AtlasLootWishList["Own"][k][i]["info"] then
						if AtlasLootWishList["Own"][k][i]["info"][2][playerName] == true then
							AtlasLoot_WishListAddDropClick("addOther", k, i, show)
							return
						end
					end
				end
			end
		end
		
		DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot"]..": "..AL["Please set a default Wishlist."]);
	end
end

--[[
AtlasLoot_DeleteFromWishList(itemID)
Deletes the specified items from the wishlist
]]	
function AtlasLoot_DeleteFromWishList(itemID)
	if itemID and itemID == 0 then return end
	if lastWishListtyp == "addOwn" then
		for i, v in ipairs(AtlasLootWishList["Own"][playerName][lastWishListarg2]) do
			if v[2] == itemID then
				DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot"]..": "..AtlasLoot_FixText(v[4])..GREY..AL[" deleted from the WishList."]..WHITE.." ("..AtlasLootWishList["Own"][playerName][lastWishListarg2]["info"][1]..")");
				table.remove(AtlasLootWishList["Own"][playerName][lastWishListarg2], i);
				break;
			end
		end
		AtlasLoot_WishList = AtlasLoot_CategorizeWishList(AtlasLootWishList["Own"][playerName][lastWishListarg2])
	elseif lastWishListtyp == "addOther" then
		for i, v in ipairs(AtlasLootWishList["Own"][lastWishListarg2][lastWishListarg3]) do
			if v[2] == itemID then
				DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot"]..": "..AtlasLoot_FixText(v[4])..GREY..AL[" deleted from the WishList."]..WHITE.." ("..AtlasLootWishList["Own"][lastWishListarg2][lastWishListarg3]["info"][1].." - "..lastWishListarg2..")");
				table.remove(AtlasLootWishList["Own"][lastWishListarg2][lastWishListarg3], i);
				break;
			end
		end
		AtlasLoot_WishList = AtlasLoot_CategorizeWishList(AtlasLootWishList["Own"][lastWishListarg2][lastWishListarg3])	
	elseif lastWishListtyp == "addShared" then
		for i, v in ipairs(AtlasLootWishList["Shared"][lastWishListarg2][lastWishListarg3]) do
			if v[2] == itemID then
				DEFAULT_CHAT_FRAME:AddMessage(RED..AL["AtlasLoot"]..": "..AtlasLoot_FixText(v[4])..GREY..AL[" deleted from the WishList."]..WHITE.." ("..AtlasLootWishList["Shared"][lastWishListarg2][lastWishListarg3]["info"][1].." - "..lastWishListarg2..")");
				table.remove(AtlasLootWishList["Shared"][lastWishListarg2][lastWishListarg3], i);
				break;
			end
		end
		AtlasLoot_WishList = AtlasLoot_CategorizeWishList(AtlasLootWishList["Shared"][lastWishListarg2][lastWishListarg3])
	end
	AtlasLootItemsFrame:Hide();
	AtlasLoot_ShowWishList()
end

--[[
AtlasLoot_WishListSort()
Sorts the Wishlist
]]
function AtlasLoot_WishListSort()

	j=0;
	P=2;
	temp={};
	check=false;

	while(P<31) do
		temp=AtlasLootCharDB["WishList"][P];
		j=P;
		check=AtlasLoot_WishListSortCheck(AtlasLootCharDB["WishList"][j-1], temp);
		while((j>1) and check) do
			AtlasLootCharDB["WishList"][j] = AtlasLootCharDB["WishList"][j-1];
			j=j-1;
			check=AtlasLoot_WishListSortCheck(AtlasLootCharDB["WishList"][j-1], temp);
		end
		AtlasLootCharDB["WishList"][j]=temp;
		P=P+1;
	end

end

--[[
AtlasLoot_WishListSortCheck(temp1, temp2)
Checks if temp1 > temp2
Sorts by rarity, then alphabetically.
]]
function AtlasLoot_WishListSortCheck(temp1, temp2)
	if (temp1 == nil) then
		return false;
	elseif (temp2 == nil) then
		return false;
	end
	if temp2[2] == 0 then
		return false;
	elseif temp1[2] == 0 then
		return true;
	else
		prefix1=string.lower(string.sub(temp1[4], 1, 10));
		prefix2=string.lower(string.sub(temp2[4], 1, 10));
		if prefix1 ~= prefix2 then
			if prefix1 == "|cffff0000" then
				return false;
			elseif (prefix1 == "|cffff8000") and (prefix2 ~= "|cffff0000") then
				return false;
			elseif (prefix1 == "|cffa335ee") then
				if (prefix2 == "|cffff8000") or (prefix2 == "|cffff0000") then
					return true;
				else
					return false;
				end
			elseif (prefix1 == "|cff0070dd") then
				if (prefix2 == "|cffa335ee") or (prefix2 == "|cffff8000") or (prefix2 == "|cffff0000") then
					return true;
				else
					return false;
				end
			elseif (prefix1 == "|cff1eff00") then
				if (prefix2 == "|cffffffff") or (prefix2 == "|cff9d9d9d") then
					return false;
				else
					return true;
				end
			elseif (prefix1 == "|cff9d9d9d") then
				return true;
			elseif (prefix1 == "|cffffffff") and (prefix2~="|cff9d9d9d") then
				return true;
			else
				return false;
			end
		else
			if(temp1[4] > temp2[4]) then
				return true;
			else
				return false;
			end
		end
	end
end

--[[
local RecursiveSearchZoneName(dataTable, zoneID):
A recursive function iterate AtlasLoot_DewDropDown table for the zone name
]]
local function RecursiveSearchZoneName(dataTable, zoneID)
	if(dataTable[2] == zoneID) then
		if dataTable[1] == BabbleFaction["Alliance"] or dataTable[1] == BabbleFaction["Horde"] then
			return dataTable[4];
		else
			return dataTable[1];
		end
	end
	for _, v in pairs(dataTable) do
		if type(v) == "table" then
			local result = RecursiveSearchZoneName(v, zoneID);
			if result then return result end
		end
	end
end

--[[
AtlasLoot_GetWishListSubheading(dataID):
Iterating through dropdown data tables to search backward for zone name with specified dataID
]]
function AtlasLoot_GetWishListSubheading(dataID)
	if not AtlasLoot_DewDropDown or not AtlasLoot_DewDropDown_SubTables then return end
	local zoneID, ret
	for subKey, subTable in pairs(AtlasLoot_DewDropDown_SubTables) do
		for _, t in ipairs(subTable) do
			if t[2] == dataID then
				zoneID = subKey;
				break;
			end
		end
		if zoneID then break end
	end
	if zoneID then
		return RecursiveSearchZoneName(AtlasLoot_DewDropDown, zoneID or dataID);
	else
		if AtlasLoot_TableNames[dataID] then
			zoneID = AtlasLoot_TableNames[dataID][1]
		end
		return zoneID
	end
end

--[[
AtlasLoot_CategorizeWishList(wlTable):
Group items with zone/event name etc, and format them by adding subheadings and empty lines
This function returns a single table with all items, use AtlasLoot_GetWishListPage to split it
wlTable: is AtlasLootCharDB["WishList"], parameterized for flexible
]]
function AtlasLoot_CategorizeWishList(wlTable)
	local subheadings, categories, result = {}, {}, {};

	for _, v in pairs(wlTable) do
		if v[8] and v[8] ~= "" then
			local dataID = strsplit("|", v[8]);
			-- Build subheading table
			if not subheadings[dataID] then
				-- Heroic handling
				local HeroicCheck=string.sub(dataID, string.len(dataID)-10, string.len(dataID));
				local NonHeroicdataID=string.sub(dataID, 1, string.len(dataID)-6);
				local BigraidCheck=string.sub(dataID, string.len(dataID)-4, string.len(dataID));
				
				if BigraidCheck == "25Man" or HeroicCheck == "25ManHEROIC" then
					HeroicCheck=string.sub(dataID, string.len(dataID)-10, string.len(dataID));
					NonHeroicdataID=string.sub(dataID, 1, string.len(dataID)-11);
				else
					HeroicCheck=string.sub(dataID, string.len(dataID)-5, string.len(dataID));
					NonHeroicdataID=string.sub(dataID, 1, string.len(dataID)-6);
				end

				if HeroicCheck == "HEROIC" then
					subheadings[dataID] = AtlasLoot_GetWishListSubheading(NonHeroicdataID);
					if subheadings[dataID] then subheadings[dataID] = subheadings[dataID].." ("..AL["Heroic"]..")" end
				elseif HeroicCheck == "25ManHEROIC" then
					subheadings[dataID] = AtlasLoot_GetWishListSubheading(NonHeroicdataID);
					if subheadings[dataID] then subheadings[dataID] = subheadings[dataID].." ("..AL["25 Man"].."-"..AL["Heroic"]..")" end
				elseif strsub(dataID, strlen(dataID) - 4) == "25Man" then
					subheadings[dataID] = AtlasLoot_GetWishListSubheading(strsub(dataID, 1, strlen(dataID) - 5));
					if subheadings[dataID] then subheadings[dataID] = subheadings[dataID].." ("..AL["25 Man"]..")" end
                else
					subheadings[dataID] = AtlasLoot_GetWishListSubheading(dataID);
					-- If search failed, replace ID like "Aldor2" to "Aldor1" and try again
					if not subheadings[dataID] and string.find(dataID, "^%a+%d?$") then
						subheadings[dataID] = AtlasLoot_GetWishListSubheading(strsub(dataID, 1, strlen(dataID) - 1).."1");
					end
				end
				-- If still cant find it, mark it with Unknown
				if not subheadings[dataID] then subheadings[dataID] = AL["Unknown"] end
			end
			-- Build category tables
			if not categories[subheadings[dataID]] then categories[subheadings[dataID]] = {} end
			table.insert(categories[subheadings[dataID]], v);
		end
	end

	-- Sort and flatten categories
	for k, v in pairs(categories) do
		-- Add a empty line between categories when in a same column
		if #result > 1 and #result % 15 > 0 then table.insert(result, { 0, 0, "", "", "" }) end
		-- If a subheading is on the last row of a column, push it to next column
		if (#result + 1) % 15 == 0 then table.insert(result, { 0, 0, "", "", "" }) end
		-- Subheading
		table.insert(result, { 0, 0, "INV_Box_01", "=q6="..k, "" });
		-- Sort first then add items
		table.sort(v, AtlasLoot_WishListSortCheck); -- not works?
		for i = 1, #v do table.insert(result, v[i]) end
	end

	return result;
end

--[[
AtlasLoot_GetWishListPage(page):
Return partial data of WishList table
page: the page number needed
]]
	
function AtlasLoot_GetWishListPage(page)
	if lastWishListtyp == "addOwn" then
		AtlasLoot_WishList = AtlasLoot_CategorizeWishList(AtlasLootWishList["Own"][playerName][lastWishListarg2])
	elseif lastWishListtyp == "addOther" then
		AtlasLoot_WishList = AtlasLoot_CategorizeWishList(AtlasLootWishList["Own"][lastWishListarg2][lastWishListarg3])
	elseif lastWishListtyp == "addShared" then
		AtlasLoot_WishList = AtlasLoot_CategorizeWishList(AtlasLootWishList["Shared"][lastWishListarg2][lastWishListarg3])
	end
	-- Calc for maximal pages
	local pageMax = math.ceil(#AtlasLoot_WishList / 30);
	if page < 1 then page = 1 end
	if page > pageMax then page = pageMax end
	currentPage = page;

	-- Table copy
    local k=1;
	local result = {};
	local start = (page - 1) * 30 + 1;
	for i = start, start + 29 do
		if not AtlasLoot_WishList[i] then break end
        AtlasLoot_WishList[i][1] = k;
		table.insert(result, AtlasLoot_WishList[i]);
        k=k+1;
	end
	return result, pageMax;
end

--[[
AtlasLoot_WishListCheck(itemID, all):
Returns true if an item is already in the wishlist
]]
function AtlasLoot_WishListCheck(itemID, all)
	if all == true then
		local rettex = ""
		if not AtlasLootWishList["Options"][playerName]["markInTable"] then AtlasLootWishList["Options"][playerName]["markInTable"] = "own" end
		if AtlasLootWishList["Options"][playerName]["markInTable"] == "own" then
			for k,v in pairs(AtlasLootWishList["Own"][playerName]) do
				for i,j in pairs(AtlasLootWishList["Own"][playerName][k]) do
					if AtlasLootWishList["Own"][playerName][k][i][2] == itemID then
						if AtlasLootWishList["Own"][playerName][k]["info"][3] ~= "" then
							rettex = rettex.."|T"..AtlasLootWishList["Own"][playerName][k]["info"][3]..":0|t"
						else
							rettex = rettex.."|TInterface\\Icons\\INV_Misc_QuestionMark:0|t"
						end
						break
					end
				end
			end
		elseif AtlasLootWishList["Options"][playerName]["markInTable"] == "all" then
			for k,v in pairs(AtlasLootWishList["Own"]) do
				for i,j in pairs(AtlasLootWishList["Own"][k]) do
					for b,c in pairs(AtlasLootWishList["Own"][k][i]) do
						if AtlasLootWishList["Own"][k][i][b][2] == itemID then
							if AtlasLootWishList["Own"][k][i]["info"][3] ~= "" then
								rettex = rettex.."|T"..AtlasLootWishList["Own"][k][i]["info"][3]..":0|t"
							else
								rettex = rettex.."|TInterface\\Icons\\INV_Misc_QuestionMark:0|t"
							end
							break
						end
					end
				end
			end
            for k,v in pairs(AtlasLootWishList["Shared"]) do
				for i,j in pairs(AtlasLootWishList["Shared"][k]) do
					for b,c in pairs(AtlasLootWishList["Shared"][k][i]) do
						if AtlasLootWishList["Shared"][k][i][b][2] == itemID then
							if AtlasLootWishList["Shared"][k][i]["info"][3] ~= "" then
								rettex = rettex.."|T"..AtlasLootWishList["Shared"][k][i]["info"][3]..":0|t"
							else
								rettex = rettex.."|TInterface\\Icons\\INV_Misc_QuestionMark:0|t"
							end
							break
						end
					end
				end
			end
		end
		if rettex == "" then 
			return false
		else
			return true, rettex
		end
	else
		if xtyp == "addOwn" then
			for _, v in ipairs(AtlasLootWishList["Own"][playerName][xarg2]) do
				if v[2] == itemID then
					return true;
				end
			end
		elseif xtyp == "addOther" then
			for _, v in ipairs(AtlasLootWishList["Own"][xarg2][xarg3]) do
				if v[2] == itemID then
					return true;
				end
			end	
		elseif xtyp == "addShared" then
			for _, v in ipairs(AtlasLootWishList["Shared"][xarg2][xarg3]) do
				if v[2] == itemID then
					return true;
				end
			end	
		end
		return false;
	end
end

--[[
AtlasLoot_GetWishLists([playerName])
Returns a Table with wishlist infos, if name not exist in wishlisttable it returns nil.
[playerName]		-> Enter a PlayerName <string>

return:
table = {
	["playerName"] = {
		[WishListNumber] = {
			[1] = "WishlistName",
			[2] = "WishlistIcon",
		},
	},
}
]]
function AtlasLoot_GetWishLists(playerName)
	local returnTable = {}
	if playerName then
		if not returnTable[playerName] then returnTable[playerName] = {} end
		if not AtlasLootWishList["Own"][playerName] then return nil end
		for listIndex,_ in pairs(AtlasLootWishList["Own"][playerName]) do
			if not returnTable[playerName][listIndex] then returnTable[playerName][listIndex] = {} end
			returnTable[playerName][listIndex][1] = AtlasLootWishList["Own"][playerName][listIndex]["info"][1]
			returnTable[playerName][listIndex][2] = AtlasLootWishList["Own"][playerName][listIndex]["info"][2]
		end
	else
		for name,_ in pairs(AtlasLootWishList["Own"]) do
			if not returnTable[name] then returnTable[name] = {} end
			for listIndex,_ in pairs(AtlasLootWishList["Own"][name]) do
				if not returnTable[name][listIndex] then returnTable[name][listIndex] = {} end
				returnTable[name][listIndex][1] = AtlasLootWishList["Own"][name][listIndex]["info"][1]
				returnTable[name][listIndex][2] = AtlasLootWishList["Own"][name][listIndex]["info"][2]
			end
		end
	end
	return returnTable
end

--[[
AtlasLoot_CheckWishlistItem(itemID ,[playerName ,[wishlist] ])
Returns a Table with infos about the item.
itemID 			-> Enter a ItemID
[playerName]	-> Enter a PlayerName, needed if you want to check only wishlists from a particular player (if you need to check all players, enter nil)
[wishlist]		-> Checks only this wishlist (playerName can be nil)

return:
table = {
	[index] = {
		[1] = "playerName",
		[2] = "WishListName"
	}
}
]]
function AtlasLoot_CheckWishlistItem(itemID, playerName, wishList)
	if not itemID then return nil end
	local returnTable = {}
	local returnIndex = 1
	
	if playerName and not wishList then
		if not AtlasLootWishList["Own"][playerName] then return nil end
		for listIndex,_ in pairs(AtlasLootWishList["Own"][playerName]) do
			for itemIndex,_ in pairs(AtlasLootWishList["Own"][playerName][listIndex]) do
				if AtlasLootWishList["Own"][playerName][listIndex][itemIndex][2] == itemID then
					returnTable[returnIndex] = {}
					returnTable[returnIndex][1] = playerName
					returnTable[returnIndex][2] = AtlasLootWishList["Own"][playerName][listIndex]["info"][1]
					returnIndex = returnIndex + 1
					break
				end
			end
		end
	elseif wishList then
		for name,_ in pairs(AtlasLootWishList["Own"]) do
			for listIndex,_ in pairs(AtlasLootWishList["Own"][name]) do
				if wishList ~= AtlasLootWishList["Own"][name][listIndex]["info"][1] then break end
				for itemIndex,_ in pairs(AtlasLootWishList["Own"][name][listIndex]) do
					if AtlasLootWishList["Own"][name][listIndex][itemIndex][2] == itemID then
						if playerName and playerName == name then
							returnTable[returnIndex] = {}
							returnTable[returnIndex][1] = name
							returnTable[returnIndex][2] = AtlasLootWishList["Own"][name][listIndex]["info"][1]
							returnIndex = returnIndex + 1
							break
						elseif not playerName then
							returnTable[returnIndex] = {}
							returnTable[returnIndex][1] = name
							returnTable[returnIndex][2] = AtlasLootWishList["Own"][name][listIndex]["info"][1]
							returnIndex = returnIndex + 1
							break
						end
					end
				end
			end
		end
	else
		for name,_ in pairs(AtlasLootWishList["Own"]) do
			for listIndex,_ in pairs(AtlasLootWishList["Own"][name]) do
				for itemIndex,_ in pairs(AtlasLootWishList["Own"][name][listIndex]) do
					if AtlasLootWishList["Own"][name][listIndex][itemIndex][2] == itemID then
						returnTable[returnIndex] = {}
						returnTable[returnIndex][1] = name
						returnTable[returnIndex][2] = AtlasLootWishList["Own"][name][listIndex]["info"][1]
						returnIndex = returnIndex + 1
						break
					end
				end
			end
		end
	end
	if type(returnTable) == "table" and #returnTable < 1 then
		return nil
	else
		return returnTable
	end
end

-- **********************************************************************
-- Options:
--	<local> ClearLines()
--	<local> AddWishListOptions(parrent,name,icon,xxx,tabname,tab2)
--	<local> AddTexture(par, num)
--	<local> TableGetSet(tab)
-- 	<local> GenerateTabNum(strg,sender)
--	AtlasLoot_RefreshWishlists()
--	AtlasLoot_CreateWishlistOptions()

-- **********************************************************************
local AddWishlist = "new"
local curaddicon,curaddname,curtabname,curplayername = "","","",""
local lastframewidht = 0

local showallwishlists,firstload = false,true

local xpos = 0
local ypos = 0

local lines = {}
local numlines = 0
local yoffset = -5

--[[
StaticPopupDialogs["ATLASLOOT_GET_WISHLIST"]
This is shown, if you want too delet a wishlist
]]
StaticPopupDialogs["ATLASLOOT_DELETE_WISHLIST"] = {
	text = AL["Delete Wishlist %s?"],
	button1 = AL["Delete"],
	button2 = AL["Cancel"],
	OnShow = function()
		this:SetFrameStrata("TOOLTIP");
	end,
	OnAccept = function()
		AtlasLootWishList["Own"][curplayername][curtabname] = nil;
		curtabname = ""
		curplayername = ""
		AtlasLoot_RefreshWishlists()
	end,
	OnCancel = function ()
		curtabname = ""
		curplayername = ""
		deletwishlistname = ""
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["ATLASLOOT_DELETE_SHARED_WISHLIST"] = {
	text = AL["Delete Wishlist %s?"],
	button1 = AL["Delete"],
	button2 = AL["Cancel"],
	OnShow = function()
		this:SetFrameStrata("TOOLTIP");
	end,
	OnAccept = function()
		AtlasLootWishList["Shared"][curplayername][curtabname] = nil;
		curtabname = ""
		curplayername = ""
		AtlasLoot_RefreshWishlists()
	end,
	OnCancel = function ()
		curtabname = ""
		curplayername = ""
		deletwishlistname = ""
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

--[[
StaticPopupDialogs["ATLASLOOT_GET_WISHLIST"]
This is shown, if someone send you a wishlist
]]
StaticPopupDialogs["ATLASLOOT_GET_WISHLIST"] = {
	text = AL["%s sends you a Wishlist. Accept?"],
	button1 = ACCEPT,
	button2 = CANCEL,
	OnShow = function()
		this:SetFrameStrata("TOOLTIP");
	end,
	OnAccept = function(self,data)
		ALModule:SendCommMessage(ShareWishlistPref, "AcceptWishlist", "WHISPER", data)
	end,
	OnCancel = function (self,data)
		ALModule:SendCommMessage(ShareWishlistPref, "CancelWishlist", "WHISPER", data)
	end,
	timeout = 15,
	whileDead = 1,
	hideOnEscape = 1
};

--[[
<local> ClearLines()
Delet all wishlists from the ScrollFrame
]]	
local function ClearLines()
	for i=1,numlines do
		lines[i]:Hide()
	end
	yoffset = -5
	numlines = 0
end

--[[
<local> AddWishListOptions(parrent,name,icon,xxx,tabname,tab2,shared)
Add a wishlist too the ScrollFrame
]]
local function AddWishListOptions(parrent,name,icon,xxx,tabname,tab2,shared)
	if not name or not icon then return end
	local frame = CreateFrame("FRAME", nil, parrent)
		frame:SetHeight(30)
		frame:SetWidth(xxx)
		frame:SetPoint("TOPLEFT", parrent, "TOPLEFT", 5, yoffset)

	local Textur = frame:CreateTexture(nil,"OVERLAY")
		Textur:SetPoint("TOPLEFT", frame, "TOPLEFT", 0 , -2.5)
		Textur:SetTexture(icon)
		Textur:SetHeight(25)
		Textur:SetWidth(25)	

	local Text = frame:CreateFontString(nil,"OVERLAY","GameFontNormal")
		Text:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, 0)
		if tab2 ~= playerName then
			Text:SetText(name..WHITE.." ("..tab2..")");
		else
			Text:SetText(name);
		end
		Text:SetHeight(30)

	local delIcon = frame:CreateTexture(nil,"OVERLAY")
		delIcon:SetHeight(20)
		delIcon:SetWidth(20)
		delIcon:SetPoint("TOPLEFT", frame, "TOPLEFT", xxx-delIcon:GetWidth()-10, -5)
		delIcon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\delete")

	local ButtonDel = CreateFrame("BUTTON", nil, frame, "UIPanelButtonTemplate")
		ButtonDel:SetHeight(delIcon:GetHeight())
		ButtonDel:SetWidth(delIcon:GetWidth())  
		--ButtonDel:SetText(AL["Delete"])
		--ButtonDel:SetWidth(ButtonDel:GetTextWidth()+20)
		ButtonDel:SetPoint("TOPLEFT", frame, "TOPLEFT", xxx-ButtonDel:GetWidth()-10, -2.5)
		ButtonDel:SetNormalTexture(nil)
		ButtonDel:SetPushedTexture(nil)
		ButtonDel:SetScript("OnClick", function()
			curtabname = tabname
			curplayername = tab2
			if shared then
				StaticPopup_Show ("ATLASLOOT_DELETE_SHARED_WISHLIST",AtlasLootWishList["Shared"][tab2][tabname]["info"][1]);
			else
				StaticPopup_Show ("ATLASLOOT_DELETE_WISHLIST",AtlasLootWishList["Own"][tab2][tabname]["info"][1]);
			end
		end)
		ButtonDel:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			if shared then
				GameTooltip:SetText(AL["Delete"]..": "..AtlasLootWishList["Shared"][tab2][tabname]["info"][1])
			else
				GameTooltip:SetText(AL["Delete"]..": "..AtlasLootWishList["Own"][tab2][tabname]["info"][1])
			end
			GameTooltip:Show()
		end)
		ButtonDel:SetScript("OnLeave", function() GameTooltip:Hide() end)

	local ediIcon = frame:CreateTexture(nil,"OVERLAY")
		ediIcon:SetHeight(20)
		ediIcon:SetWidth(20)
		ediIcon:SetPoint("TOPLEFT", frame, "TOPLEFT", xxx-delIcon:GetWidth()-ediIcon:GetWidth()-15, -5)
		ediIcon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\edit")

	local ButtonEdi = CreateFrame("BUTTON", nil, frame, "UIPanelButtonTemplate")
		ButtonEdi:SetHeight(ediIcon:GetHeight())
		ButtonEdi:SetWidth(ediIcon:GetWidth())  
		--ButtonEdi:SetText(AL["Edit"])
		--ButtonEdi:SetWidth(ButtonEdi:GetTextWidth()+20)
		ButtonEdi:SetPoint("TOPLEFT", frame, "TOPLEFT", xxx-ButtonEdi:GetWidth()-ButtonDel:GetWidth()-15, -2.5)
		ButtonEdi:SetNormalTexture(nil)
		ButtonEdi:SetPushedTexture(nil)
		ButtonEdi:SetScript("OnClick", function()
			AtlasLootWishList_AddFrame:Hide()
			curaddname = name
			curaddicon = icon
			curtabname = tabname
			curplayername = tab2
			AtlasLootWishList_AddFrame:Show()
			AtlasLottAddEditWishList:SetText(AL["Edit Wishlist"])
		end)
		ButtonEdi:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			if shared then
				GameTooltip:SetText(AL["Edit"]..": "..AtlasLootWishList["Shared"][tab2][tabname]["info"][1])
			else
				GameTooltip:SetText(AL["Edit"]..": "..AtlasLootWishList["Own"][tab2][tabname]["info"][1])
			end
			GameTooltip:Show()
		end)
		ButtonEdi:SetScript("OnLeave", function() GameTooltip:Hide() end)

	local shareIcon = frame:CreateTexture(nil,"OVERLAY")
		shareIcon:SetHeight(20)
		shareIcon:SetWidth(20)
		shareIcon:SetPoint("TOPLEFT", frame, "TOPLEFT", xxx-delIcon:GetWidth()-ediIcon:GetWidth()-shareIcon:GetWidth()-20, -5)
		shareIcon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\share")	

	local ButtonShare = CreateFrame("BUTTON", nil, frame, "UIPanelButtonTemplate")
		ButtonShare:SetHeight(shareIcon:GetHeight())
		ButtonShare:SetWidth(shareIcon:GetWidth())  
		--ButtonShare:SetText(AL["Share"])
		--ButtonShare:SetWidth(ButtonShare:GetTextWidth()+20)
		ButtonShare:SetPoint("TOPLEFT", frame, "TOPLEFT", xxx-ButtonShare:GetWidth()-ButtonDel:GetWidth()-ButtonEdi:GetWidth()-20, -2.5)
		ButtonShare:SetNormalTexture(nil)
		ButtonShare:SetPushedTexture(nil)
		ButtonShare:SetScript("OnClick", function()
			curtabname = tabname
			curplayername = tab2
			StaticPopup_Show ("ATLASLOOT_SEND_WISHLIST",AtlasLootWishList["Own"][tab2][tabname]["info"][1]);
		end)
		ButtonShare:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			if shared then
				GameTooltip:SetText(AL["Share"]..": "..AtlasLootWishList["Shared"][tab2][tabname]["info"][1])
			else
				GameTooltip:SetText(AL["Share"]..": "..AtlasLootWishList["Own"][tab2][tabname]["info"][1])
			end
			GameTooltip:Show()
		end)
		ButtonShare:SetScript("OnLeave", function() GameTooltip:Hide() end)

	if not shared then
		local CheckBox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
			CheckBox:SetPoint("LEFT", frame, "TOPLEFT", xxx-ButtonShare:GetWidth()-ButtonDel:GetWidth()-ButtonEdi:GetWidth()-45, -15)
			CheckBox:SetWidth(25)
			CheckBox:SetHeight(25)
			CheckBox:SetScript("OnUpdate", function()
				if AtlasLootWishList["Own"][tab2][tabname]["info"][2][playerName] == true then
					this:SetChecked(1);
				else
					this:SetChecked(nil);
				end
			end)
			CheckBox:SetScript("OnClick", function()
				for k,v in pairs(AtlasLootWishList["Own"]) do
					if AtlasLootWishList["Own"][k] then
						for i,j in pairs(AtlasLootWishList["Own"][k]) do
							if AtlasLootWishList["Own"][k][i]["info"] then
                                if (type(AtlasLootWishList["Own"][k][i]["info"][2]) ~= "table") then
                                    AtlasLootWishList["Own"][k][i]["info"][2] = {};
                                end
                                if k == tab2 and i == tabname then
                                    AtlasLootWishList["Own"][k][i]["info"][2][playerName] = true;
                                else
                                    AtlasLootWishList["Own"][k][i]["info"][2][playerName] = false;
                                end
							end
						end
					end
				end
			end)
			CheckBox:SetScript("OnEnter", function()
				GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
				GameTooltip:SetText(AL["Set as default Wishlist"].." ("..AtlasLootWishList["Own"][tab2][tabname]["info"][1]..")")
				GameTooltip:Show()
			end)
			CheckBox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end

	yoffset = yoffset-30
	numlines = numlines + 1
	lines[numlines] = frame
end

--[[
<local> AddTexture(par, num)
Add a Icon too the AddFrame. 
]]
local function AddTexture(par, num)
	local numIcons = GetNumMacroIcons();
	local iconTexture = GetMacroIconInfo(num);

	local Button = CreateFrame("BUTTON", nil, par, "UIPanelButtonTemplate")
		Button:SetHeight(20)
		Button:SetWidth(20)  
		Button:SetPoint("TOPLEFT", par, "TOPLEFT", xpos, ypos)
		Button:SetText("")
		Button:SetScript("OnClick", function()
			if AddWishlist == "new" then
				AtlasLootPrevTexture:SetTexture(iconTexture)
				curaddicon = iconTexture
			elseif AddWishlist == "edit" then
				AtlasLootPrevTexture:SetTexture(iconTexture)
				curaddicon = iconTexture
			end
		end)

	local Textur = Button:CreateTexture("textur","OVERLAY")
		Textur:SetPoint("TOPLEFT", Button, "TOPLEFT")
		Textur:SetTexture(iconTexture)
		Textur:SetHeight(20)
		Textur:SetWidth(20)

	if xpos == 280 then
		xpos = 0
		ypos = ypos - 20
	else
		xpos = xpos + 20
	end
end

--[[
TableGetSet(tab)
Sort and count number of wishlists
]]
local function TableGetSet(tab)
	local save = {}
	local num = 0
	for k,v in pairs(tab) do
		if type(v) == "table" then
			num = num + 1
			if not save[num] then save[num] = {} end
			for i,j in pairs(tab[k]) do
				if type(j) == "table" then
					if not save[num][i] then save[num][i] = {} end
					for b,c in pairs(tab[k][i]) do
						save[num][i][b] = c
					end
				else
					save[num][i] = j
				end
			end
		else
			save[k] = v
		end
	end
	return save, num
end

--[[
function GenerateTabNum(strg,sender)
Sort and count number of wishlists, return number of next wishlist
]]
local function GenerateTabNum(strg,sender)
	local num = 0
	local save = {}
	if strg == "own" then
		save, num = TableGetSet(AtlasLootWishList["Own"][curplayername])
		AtlasLootWishList["Own"][curplayername] = {}
		AtlasLootWishList["Own"][curplayername] = TableGetSet(save)
		num = num +1
	elseif strg == "shared" then
		if not AtlasLootWishList["Shared"][sender] then AtlasLootWishList["Shared"][sender] = {} end
		save, num = TableGetSet(AtlasLootWishList["Shared"][sender])
		AtlasLootWishList["Shared"][sender] = {}
		AtlasLootWishList["Shared"][sender] = TableGetSet(save)
		num = num +1
	end
	return num
end

--[[
AtlasLoot_RefreshWishlists()
Refresh all wishlists at the scrollframe
]]
function AtlasLoot_RefreshWishlists()
	if showallwishlists == false and showsharedwishlists == true then
		ClearLines()
		local framewidht = InterfaceOptionsFramePanelContainer:GetWidth()
		for i,j in pairs(AtlasLootWishList["Shared"]) do
			for k,v in pairs(AtlasLootWishList["Shared"][i]) do
				AddWishListOptions(AtlasLootWishlistOwnOptionsScrollInhalt,AtlasLootWishList["Shared"][i][k]["info"][1],AtlasLootWishList["Shared"][i][k]["info"][3], framewidht-45, k, i, true)
			end
		end
    elseif showallwishlists == true and showsharedwishlists == true then
		ClearLines()
		local framewidht = InterfaceOptionsFramePanelContainer:GetWidth()
		for i,j in pairs(AtlasLootWishList["Own"]) do
			for k,v in pairs(AtlasLootWishList["Own"][i]) do
				AddWishListOptions(AtlasLootWishlistOwnOptionsScrollInhalt,AtlasLootWishList["Own"][i][k]["info"][1],AtlasLootWishList["Own"][i][k]["info"][3], framewidht-45, k, i)
			end
		end
        for i,j in pairs(AtlasLootWishList["Shared"]) do
			for k,v in pairs(AtlasLootWishList["Shared"][i]) do
				AddWishListOptions(AtlasLootWishlistOwnOptionsScrollInhalt,AtlasLootWishList["Shared"][i][k]["info"][1],AtlasLootWishList["Shared"][i][k]["info"][3], framewidht-45, k, i, true)
			end
		end
	elseif showallwishlists == true then
		ClearLines()
		local framewidht = InterfaceOptionsFramePanelContainer:GetWidth()
		for i,j in pairs(AtlasLootWishList["Own"]) do
			for k,v in pairs(AtlasLootWishList["Own"][i]) do
				AddWishListOptions(AtlasLootWishlistOwnOptionsScrollInhalt,AtlasLootWishList["Own"][i][k]["info"][1],AtlasLootWishList["Own"][i][k]["info"][3], framewidht-45, k, i)
			end
		end
	elseif showallwishlists == false then
		ClearLines()
		local framewidht = InterfaceOptionsFramePanelContainer:GetWidth()
		for k,v in pairs(AtlasLootWishList["Own"][playerName]) do
			AddWishListOptions(AtlasLootWishlistOwnOptionsScrollInhalt,AtlasLootWishList["Own"][playerName][k]["info"][1],AtlasLootWishList["Own"][playerName][k]["info"][3], framewidht-45, k, playerName)
		end
	end
end

--[[
AtlasLoot_CreateWishlistOptions()
Create the Options for the Wishlists(called on variables loadet)
]]
function AtlasLoot_CreateWishlistOptions()
	if OptionsLoadet then return end
	if not AtlasLootWishList["Own"] then AtlasLootWishList["Own"] = {} end
	if not AtlasLootWishList["Own"][playerName] then AtlasLootWishList["Own"][playerName] = {} end
	if not AtlasLootWishList["Shared"] then AtlasLootWishList["Shared"] = {} end
	if not AtlasLootWishList["Options"] then AtlasLootWishList["Options"] = {} end
	if not AtlasLootWishList["Options"][playerName] then AtlasLootWishList["Options"][playerName] = {} end
	if AtlasLootCharDB["WishList"] and #AtlasLootCharDB["WishList"]~=0 then 
		if not AtlasLootWishList["Own"][playerName]["OldWishlist"] then AtlasLootWishList["Own"][playerName]["OldWishlist"] = {} end
		for k,v in pairs(AtlasLootCharDB["WishList"]) do
			AtlasLootWishList["Own"][playerName]["OldWishlist"][k] = v
		end
		AtlasLootWishList["Own"][playerName]["OldWishlist"]["info"] = {"OldWishlist",{[playerName] = false},"Interface\\Icons\\INV_Misc_QuestionMark"}
		AtlasLootCharDB["WishList"] = nil
	end
	for k,v in pairs(AtlasLootWishList["Own"]) do
		for i,j in pairs(AtlasLootWishList["Own"][k]) do
			if type(AtlasLootWishList["Own"][k][i]["info"][2]) ~= "table" then
				AtlasLootWishList["Own"][k][i]["info"][2] = {[playerName] = false};
			end
		end
	end

	-- Add wishlistframe --
	local WishListAddFrame = CreateFrame("FRAME","AtlasLootWishList_AddFrame",UIParent)
		WishListAddFrame:Hide()
		WishListAddFrame:SetFrameStrata("TOOLTIP")
		WishListAddFrame:SetWidth(350)
		WishListAddFrame:SetHeight(250)
		WishListAddFrame:SetPoint("CENTER",UIParent)
		WishListAddFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
												edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
												tile = true, tileSize = 16, edgeSize = 16, 
												insets = { left = 4, right = 4, top = 4, bottom = 4 }});
		WishListAddFrame:SetMovable(true)
		WishListAddFrame:EnableMouse(true)
		WishListAddFrame:RegisterForDrag("LeftButton")
		WishListAddFrame:RegisterForDrag("LeftButton", "RightButton")
		WishListAddFrame:SetScript("OnMouseDown", function()
			this:StartMoving()
		end)
		WishListAddFrame:SetScript("OnMouseUp", WishListAddFrame.StopMovingOrSizing)

	local Textur = WishListAddFrame:CreateTexture("AtlasLootPrevTexture","OVERLAY")
		Textur:SetPoint("TOPRIGHT", WishListAddFrame, "TOPRIGHT", -40, -10)
		Textur:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		Textur:SetHeight(40)
		Textur:SetWidth(40)

	local Text = WishListAddFrame:CreateFontString("AtlasLootAddWishListName","OVERLAY","GameFontNormal")
		Text:SetPoint("TOPLEFT", WishListAddFrame, "TOPLEFT", 10, -5)
		Text:SetText(AL["Wishlist name:"]);
		Text:SetHeight(20)

	local Edit1 = CreateFrame("EditBox", "AtlasLootWishListNewName", WishListAddFrame, "InputBoxTemplate")
		Edit1:SetPoint("LEFT", WishListAddFrame, "TOPLEFT", 15, -37)
		Edit1:SetWidth(250)
		Edit1:SetHeight(32)
		Edit1:SetAutoFocus(false)
		Edit1:SetTextInsets(0, 8, 0, 0)
		Edit1:SetScript("OnEnterPressed", function()
			this:ClearFocus();
			local text = this:GetText();
			curaddname = text
		end)
		Edit1:SetScript("OnShow", function()
			this:SetText(curaddname);
		end)

	local CloseButton = CreateFrame("BUTTON",nil, WishListAddFrame, "UIPanelCloseButton")
		CloseButton:SetPoint("TOPRIGHT", WishListAddFrame, "TOPRIGHT", -5, -5)	

	local WishListIconListSc = CreateFrame("ScrollFrame", "AtlasLootWishlistAddFrameIconList", WishListAddFrame, "UIPanelScrollFrameTemplate")
	local WishlistIconListIn = CreateFrame("Frame", "AtlasLootWishlistAddFrameIconListInhalt", WishListIconListSc)
		WishListIconListSc:SetScrollChild(WishlistIconListIn)
		WishListIconListSc:SetPoint("TOPLEFT", WishListAddFrame, "TOPLEFT", 10, -60)
		WishlistIconListIn:SetPoint("TOPLEFT", WishListIconListSc, "TOPLEFT", 0, 0)
		WishListIconListSc:SetWidth(310)  
		WishListIconListSc:SetHeight(150) 
		WishlistIconListIn:SetWidth(310)  
		WishlistIconListIn:SetHeight(150)  
		WishListIconListSc:SetHorizontalScroll(-50)
		WishListIconListSc:SetVerticalScroll(50)
		WishListIconListSc:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }})
		WishListIconListSc:SetScript("OnVerticalScroll", function()  end)
		WishListIconListSc:EnableMouse(true)
		WishListIconListSc:SetVerticalScroll(0)
		WishListIconListSc:SetHorizontalScroll(0)

	local AddWishlistFr = CreateFrame("BUTTON", "AtlasLottAddEditWishList", WishListIconListSc, "UIPanelButtonTemplate")
		AddWishlistFr:SetHeight(20)
		AddWishlistFr:SetWidth(150)  
		AddWishlistFr:SetPoint("TOPLEFT", WishListIconListSc, "TOPLEFT",0,-1*(AtlasLootWishlistAddFrameIconList:GetHeight() + 5))
		AddWishlistFr:SetText(AL["Add Wishlist"])
		AddWishlistFr:SetScript("OnClick", function()
			if AddWishlistFr:GetText() == AL["Add Wishlist"] then
				curtabname = GenerateTabNum("own")
			end

			curaddname = Edit1:GetText()
            --DEFAULT_CHAT_FRAME:AddMessage(curplayername..":"..curtabname..":"..curaddicon);
			if curaddicon == "" then 
                curaddicon = "Interface\\Icons\\INV_Misc_QuestionMark"
			elseif curaddicon ~= "" and curtabname ~= "" then
				if AtlasLootWishList["Shared"][curplayername] then
                    if AtlasLootWishList["Shared"][curplayername][curtabname] then AtlasLootWishList["Shared"][curplayername][curtabname]["info"] = {curaddname,{[playerName] = false},curaddicon} end
                elseif not AtlasLootWishList["Own"][curplayername][curtabname] then
                    AtlasLootWishList["Own"][curplayername][curtabname] = {} 
                    AtlasLootWishList["Own"][curplayername][curtabname]["info"] = {curaddname,{[playerName] = false},curaddicon}
                else
                    AtlasLootWishList["Own"][curplayername][curtabname]["info"] = {curaddname,{[playerName] = false},curaddicon}
				end
				WishListAddFrame:Hide()
				curaddname = ""
				curaddicon = ""
				curtabname  = ""
				curplayername = ""
				AtlasLoot_RefreshWishlists()
			end
		end)

	local AddWishlistIcons = CreateFrame("BUTTON", nil, WishListIconListSc, "UIPanelButtonTemplate")
		AddWishlistIcons:SetHeight(20)
		AddWishlistIcons:SetWidth(150)  
		AddWishlistIcons:SetPoint("TOPLEFT", WishListIconListSc, "TOPLEFT",160,-1*(AtlasLootWishlistAddFrameIconList:GetHeight() + 5))
		AddWishlistIcons:SetText(AL["Show More Icons"])
		AddWishlistIcons:SetScript("OnClick", function()
			for i=211,GetNumMacroIcons() do
				AddTexture(WishlistIconListIn, i)
			end
		end)

		WishListAddFrame:SetScript("OnShow", function()
			if firstload then
				for i=1,210 do
					AddTexture(WishlistIconListIn, i)
				end
				firstload = false
			end
			if curaddicon == "" then
				AtlasLootPrevTexture:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
			else
				AtlasLootPrevTexture:SetTexture(curaddicon)
			end
		end)

	-- Add wishlistframe --
	
	local framewidht = InterfaceOptionsFramePanelContainer:GetWidth()
	if AtlasLootWishList["Options"][playerName]["Mark"] ~= true and AtlasLootWishList["Options"][playerName]["Mark"] ~= false then AtlasLootWishList["Options"][playerName]["Mark"] = true end
	if not AtlasLootWishList["Options"][playerName]["markInTable"] then AtlasLootWishList["Options"][playerName]["markInTable"] = "own" end
	if AtlasLootWishList["Options"][playerName]["AllowShareWishlist"] ~= true and AtlasLootWishList["Options"][playerName]["AllowShareWishlist"] ~= false then AtlasLootWishList["Options"][playerName]["AllowShareWishlist"] = true end
	if AtlasLootWishList["Options"][playerName]["AllowShareWishlistInCombat"] ~= true and AtlasLootWishList["Options"][playerName]["AllowShareWishlistInCombat"] ~= false then AtlasLootWishList["Options"][playerName]["AllowShareWishlistInCombat"] = true end
	if AtlasLootWishList["Options"][playerName]["UseDefaultWishlist"] ~= true and AtlasLootWishList["Options"][playerName]["UseDefaultWishlist"] ~= false then AtlasLootWishList["Options"][playerName]["UseDefaultWishlist"] = false end

	local WishlistOptionsFrame = CreateFrame("FRAME", nil)
		WishlistOptionsFrame.name = AL["Wishlist"]
		WishlistOptionsFrame.parent = AL["AtlasLoot"]

	local WishListMark = CreateFrame("CheckButton", "AtlasLootOptionsWishListMark", WishlistOptionsFrame, "OptionsCheckButtonTemplate")
		WishListMark:SetPoint("LEFT", WishlistOptionsFrame, "TOPLEFT", 5, -15)
		WishListMark:SetWidth(25)
		WishListMark:SetHeight(25)
		WishListMark:SetScript("OnShow", function()
			getglobal(this:GetName().."Text"):SetText(AL["Mark items in loot tables"]);
			if AtlasLootWishList["Options"][playerName]["Mark"] then
				this:SetChecked(1);
			else
				this:SetChecked(nil);
				AtlasLootOptionsWishListMarkOwn:Disable();
				AtlasLootOptionsWishListMarkAll:Disable();
			end
		end)
		WishListMark:SetScript("OnClick", function()
			if AtlasLootWishList["Options"][playerName]["Mark"] then
				AtlasLootWishList["Options"][playerName]["Mark"] = false;
				AtlasLootOptionsWishListMarkOwn:Disable();
				AtlasLootOptionsWishListMarkAll:Disable();
			else
				AtlasLootWishList["Options"][playerName]["Mark"] = true;
				AtlasLootOptionsWishListMarkOwn:Enable();
				AtlasLootOptionsWishListMarkAll:Enable();
			end
		end)

	local WishListMarkOwn = CreateFrame("CheckButton", "AtlasLootOptionsWishListMarkOwn", WishlistOptionsFrame, "OptionsCheckButtonTemplate")
		WishListMarkOwn:SetPoint("LEFT", WishlistOptionsFrame, "TOPLEFT", 5, -35)
		WishListMarkOwn:SetWidth(25)
		WishListMarkOwn:SetHeight(25)
		WishListMarkOwn:SetScript("OnShow", function()
			getglobal(this:GetName().."Text"):SetText(AL["Mark items from own Wishlist"]);
			if AtlasLootWishList["Options"][playerName]["markInTable"] == "own" then
				this:SetChecked(1);
			else
				this:SetChecked(nil);
			end
		end)
		WishListMarkOwn:SetScript("OnClick", function()
			if AtlasLootWishList["Options"][playerName]["markInTable"] == "own" then
				AtlasLootWishList["Options"][playerName]["markInTable"] = "all";
			else
				AtlasLootWishList["Options"][playerName]["markInTable"] = "own";
			end
			WishlistOptionsFrame:Hide()
			WishlistOptionsFrame:Show()
		end)

	local WishListMarkAll = CreateFrame("CheckButton", "AtlasLootOptionsWishListMarkAll", WishlistOptionsFrame, "OptionsCheckButtonTemplate")
		WishListMarkAll:SetPoint("LEFT", WishlistOptionsFrame, "TOPLEFT", 5, -55)
		WishListMarkAll:SetWidth(25)
		WishListMarkAll:SetHeight(25)
		WishListMarkAll:SetScript("OnShow", function()
			getglobal(this:GetName().."Text"):SetText(AL["Mark items from all Wishlists"]);
			if AtlasLootWishList["Options"][playerName]["markInTable"] == "all" then
				this:SetChecked(1);
			else
				this:SetChecked(nil);
			end
		end)
		WishListMarkAll:SetScript("OnClick", function()
			if AtlasLootWishList["Options"][playerName]["markInTable"] == "own" then
				AtlasLootWishList["Options"][playerName]["markInTable"] = "all";
			else
				AtlasLootWishList["Options"][playerName]["markInTable"] = "own";
			end
			WishlistOptionsFrame:Hide()
			WishlistOptionsFrame:Show()
		end)

	local WishListShare = CreateFrame("CheckButton", "AtlasLootOptionsWishListShare", WishlistOptionsFrame, "OptionsCheckButtonTemplate")
		WishListShare:SetPoint("LEFT", WishlistOptionsFrame, "TOPLEFT", framewidht/2+13, -15)
		WishListShare:SetWidth(25)
		WishListShare:SetHeight(25)
		WishListShare:SetScript("OnShow", function()
			getglobal(this:GetName().."Text"):SetText(AL["Enable Wishlist Sharing"]);
			if AtlasLootWishList["Options"][playerName]["AllowShareWishlist"] then
				this:SetChecked(1);
			else
				this:SetChecked(nil);
			end
		end)
		WishListShare:SetScript("OnClick", function()
			if AtlasLootWishList["Options"][playerName]["AllowShareWishlist"] then
				AtlasLootWishList["Options"][playerName]["AllowShareWishlist"] = false;
				AtlasLootOptionsWishListShareInCombat:Disable();
			else
				AtlasLootWishList["Options"][playerName]["AllowShareWishlist"] = true;
				AtlasLootOptionsWishListShareInCombat:Enable();
			end
		end)

	local WishListShareInCombat = CreateFrame("CheckButton", "AtlasLootOptionsWishListShareInCombat", WishlistOptionsFrame, "OptionsCheckButtonTemplate")
		WishListShareInCombat:SetPoint("LEFT", WishlistOptionsFrame, "TOPLEFT", framewidht/2+13, -35)
		WishListShareInCombat:SetWidth(25)
		WishListShareInCombat:SetHeight(25)
		WishListShareInCombat:SetScript("OnShow", function()
			getglobal(this:GetName().."Text"):SetText(AL["Auto reject in combat"]);
			if AtlasLootWishList["Options"][playerName]["AllowShareWishlistInCombat"] then
				this:SetChecked(1);
			else
				this:SetChecked(nil);
			end
		end)
		WishListShareInCombat:SetScript("OnClick", function()
			if AtlasLootWishList["Options"][playerName]["AllowShareWishlistInCombat"] then
				AtlasLootWishList["Options"][playerName]["AllowShareWishlistInCombat"] = false;
			else
				AtlasLootWishList["Options"][playerName]["AllowShareWishlistInCombat"] = true;
			end
		end)

	local WishListAutoAdd = CreateFrame("CheckButton", "AtlasLootOptionsWishListAutoAdd", WishlistOptionsFrame, "OptionsCheckButtonTemplate")
		WishListAutoAdd:SetPoint("LEFT", WishlistOptionsFrame, "TOPLEFT", framewidht/2+13, -55)
		WishListAutoAdd:SetWidth(25)
		WishListAutoAdd:SetHeight(25)
		WishListAutoAdd:SetScript("OnShow", function()
			getglobal(this:GetName().."Text"):SetText(AL["Always use default Wishlist"]);
			if AtlasLootWishList["Options"][playerName]["UseDefaultWishlist"] == true then
				this:SetChecked(1);
			else
				this:SetChecked(nil);
			end
		end)
		WishListAutoAdd:SetScript("OnClick", function()
			if AtlasLootWishList["Options"][playerName]["UseDefaultWishlist"] then
				AtlasLootWishList["Options"][playerName]["UseDefaultWishlist"] = false;
			else
				AtlasLootWishList["Options"][playerName]["UseDefaultWishlist"] = true;
			end
		end)

	local WishListOwnSc = CreateFrame("ScrollFrame", "AtlasLootWishlistOwnOptionsScrollFrame", WishlistOptionsFrame, "UIPanelScrollFrameTemplate")
	local WishlistOwnIn = CreateFrame("Frame", "AtlasLootWishlistOwnOptionsScrollInhalt", WishListOwnSc)
		WishListOwnSc:SetScrollChild(WishlistOwnIn)
		WishListOwnSc:SetPoint("TOPLEFT", WishlistOptionsFrame, "TOPLEFT", 10, -125)
		WishlistOwnIn:SetPoint("TOPLEFT", WishListOwnSc, "TOPLEFT", 0, 0)
		WishListOwnSc:SetWidth(framewidht-45)  
		WishListOwnSc:SetHeight(265) 
		WishlistOwnIn:SetWidth(framewidht-45)  
		WishlistOwnIn:SetHeight(265)  
		WishListOwnSc:SetHorizontalScroll(-50)
		WishListOwnSc:SetVerticalScroll(50)
		WishListOwnSc:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }})
		WishListOwnSc:SetScript("OnVerticalScroll", function()  end)
		WishListOwnSc:EnableMouse(true)
		WishListOwnSc:SetVerticalScroll(0)
		WishListOwnSc:SetHorizontalScroll(0)
		WishListOwnSc:SetScript("OnUpdate", function()
			local xframewidht = InterfaceOptionsFramePanelContainer:GetWidth()

			if lastframewidht ~= xframewidht then
				WishListOwnSc:SetWidth(xframewidht-45)
				WishlistOwnIn:SetWidth(xframewidht-45)

				AtlasLootOptionsWishListMarkAll:SetPoint("LEFT", WishlistOptionsFrame, "TOPLEFT", 15, -55)
				AtlasLootOptionsWishListShare:SetPoint("LEFT", WishlistOptionsFrame, "TOPLEFT", xframewidht/2+15, -15)
				AtlasLootOptionsWishListShareInCombat:SetPoint("LEFT", WishlistOptionsFrame, "TOPLEFT", xframewidht/2+25, -35)
				AtlasLootOptionsWishListAutoAdd:SetPoint("LEFT", WishlistOptionsFrame, "TOPLEFT", xframewidht/2+15, -55)
				AtlasLoot_RefreshWishlists()
				lastframewidht = xframewidht
			end
		end)

	local ShowAllWishlists = CreateFrame("BUTTON", nil, WishListOwnSc, "UIPanelButtonTemplate")
		ShowAllWishlists:SetHeight(20)
		ShowAllWishlists:SetWidth(180)  
		ShowAllWishlists:SetPoint("TOPLEFT", WishListOwnSc, "TOPLEFT",0,47)
		ShowAllWishlists:SetText(AL["Show all Wishlists"])
		ShowAllWishlists:SetWidth(ShowAllWishlists:GetTextWidth()+20)
		ShowAllWishlists:SetScript("OnClick", function()
			showallwishlists = true
			showsharedwishlists = true
			AtlasLoot_RefreshWishlists()
		end)

	local ShowOwnWishlists = CreateFrame("BUTTON", nil, WishListOwnSc, "UIPanelButtonTemplate")
		ShowOwnWishlists:SetHeight(20)
		ShowOwnWishlists:SetWidth(180)  
		ShowOwnWishlists:SetPoint("TOPLEFT", WishListOwnSc, "TOPLEFT",ShowAllWishlists:GetWidth()+10,47)
		ShowOwnWishlists:SetText(AL["Show own Wishlists"])
		ShowOwnWishlists:SetWidth(ShowOwnWishlists:GetTextWidth()+20)
		ShowOwnWishlists:SetScript("OnClick", function()
			showallwishlists = false
			showsharedwishlists = false
			AtlasLoot_RefreshWishlists()
		end)

	local ShowAllWishlists = CreateFrame("BUTTON", nil, WishListOwnSc, "UIPanelButtonTemplate")
		ShowAllWishlists:SetHeight(20)
		ShowAllWishlists:SetWidth(180)  
		ShowAllWishlists:SetPoint("TOPLEFT", WishListOwnSc, "TOPLEFT",0,25)
		ShowAllWishlists:SetText(AL["Show shared Wishlists"])
		ShowAllWishlists:SetWidth(ShowAllWishlists:GetTextWidth()+20)
		ShowAllWishlists:SetScript("OnClick", function()
			showallwishlists = false
			showsharedwishlists = true
			AtlasLoot_RefreshWishlists()
		end)

	local AddWishlist = CreateFrame("BUTTON", nil, WishListOwnSc, "UIPanelButtonTemplate")
		AddWishlist:SetHeight(20)
		AddWishlist:SetWidth(150)  
		AddWishlist:SetPoint("TOPLEFT", WishListOwnSc, "TOPLEFT",0,-1*(AtlasLootWishlistOwnOptionsScrollFrame:GetHeight() + 5))
		AddWishlist:SetText(AL["Add Wishlist"])
		AddWishlist:SetScript("OnClick", function()
			curaddname = ""
			curaddicon = ""
			curtabname = ""
			curplayername = playerName
			WishListAddFrame:Show()
			AddWishlistFr:SetText(AL["Add Wishlist"])
		end)	

	AtlasLoot_RefreshWishlists()

			
	InterfaceOptions_AddCategory(WishlistOptionsFrame)
	OptionsLoadet = true
end

-- **********************************************************************
-- WishListShare:
--	<local>SpamProtect(name)
-- 	ALModule:OnEnable()
--	AtlasLoot_SendWishList(wltab,sendname)
--	AtlasLoot_GetWishList(wlstrg,sendername)
--	ALModule:OnCommReceived(prefix, message, distribution, sender)
-- **********************************************************************

local SpamFilter = {}
local SpamFilterTime = 10
local xwltab = {}

--[[
<local> SpamProtect(name)
Check Spamfilter table
]]
local function SpamProtect(name)
	if not name then return true end
	if SpamFilter[string.lower(name)] then
		if GetTime() - SpamFilter[string.lower(name)] > SpamFilterTime then
			SpamFilter[string.lower(name)] = nil
			return true
		else
			return false
		end
	else
		return true
	end
end

--[[
ALModule:OnEnable()
Register the AceComm channel
]]
function ALModule:OnEnable()
    self:RegisterComm(ShareWishlistPref)
end

--[[
AtlasLoot_SendWishList(wltab,sendname)
Send wishlist request 
Seralize and send wishlist
]]
function AtlasLoot_SendWishList(wltab,sendname)
	if string.lower(sendname) == string.lower(playerName) then return end
	if not xwltab[sendname] then
		xwltab[sendname] = wltab
		ALModule:SendCommMessage(ShareWishlistPref, "WishlistRequest", "WHISPER", sendname)
	else
		local SplitTable = ALModule:Serialize(wltab)
		ALModule:SendCommMessage(ShareWishlistPref, SplitTable, "WHISPER", sendname)
	end
end

--[[
AtlasLoot_GetWishList(wlstrg,sendername)
Get the Wishlist, Deserialize it and save it in the savedvariables table
]]
function AtlasLoot_GetWishList(wlstrg,sendername)
	if not wlstrg or not sendername then return end
	if string.lower(sendername) == string.lower(playerName) then return end
	local success, wltab = ALModule:Deserialize(wlstrg)
	if success then
		if wltab["info"] then
			local num = GenerateTabNum("shared",sendername)
			if not AtlasLootWishList["Shared"][sendername] then AtlasLootWishList["Shared"][sendername] = {} end
			AtlasLootWishList["Shared"][sendername][num] = {}
			for k,v in pairs(wltab) do
				if type(v) == "table" then
					for i,j in pairs(wltab[k]) do
						if not AtlasLootWishList["Shared"][sendername][num][k] then AtlasLootWishList["Shared"][sendername][num][k] = {} end
						AtlasLootWishList["Shared"][sendername][num][k][i] = j
					end
				else
					AtlasLootWishList["Shared"][sendername][num][k] = v
				end
			end
		end
	end
end

--[[
ALModule:OnCommReceived(prefix, message, distribution, sender)
Incomming messages from AceComm
]]
function ALModule:OnCommReceived(prefix, message, distribution, sender)
	if prefix ~= ShareWishlistPref then return end
	if message == "SpamProtect" then
		--local _,_,timeleft = string.find( 10-(GetTime() - SpamFilter[string.lower(sender)]), "(%d+)%.")
		--DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["You must wait "]..WHITE..timeleft..RED..AL[" seconds before you can send a new Wishlist too "]..WHITE..sender..RED..".");
	elseif message == "FinishSend" then
		SpamFilter[string.lower(sender)] = GetTime()
	elseif message == "AcceptWishlist" then
		AtlasLoot_SendWishList(xwltab[sender],sender)
		xwltab[sender] = nil
	elseif message == "WishlistRequest" then

		if AtlasLootWishList["Options"][playerName]["AllowShareWishlist"] == true then
			if AtlasLootWishList["Options"][playerName]["AllowShareWishlistInCombat"] == true then
				if UnitAffectingCombat("player") then
					ALModule:SendCommMessage(ShareWishlistPref, "CancelWishlist", "WHISPER", sender)
					DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..WHITE..sender..RED..AL[" tried to send you a Wishlist. Rejected because you are in combat."]);
				else
					local dialog = StaticPopup_Show("ATLASLOOT_GET_WISHLIST", sender); 
					if ( dialog ) then 
						dialog.data = sender; 
					end
				end
			else
				local dialog = StaticPopup_Show("ATLASLOOT_GET_WISHLIST", sender); 
				if ( dialog ) then 
					dialog.data = sender; 
				end
			end
		else
			ALModule:SendCommMessage(ShareWishlistPref, "CancelWishlist", "WHISPER", sender)
		end
		
	elseif message == "CancelWishlist" then
		DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..WHITE..sender..RED..AL[" rejects your Wishlist."]);
		xwltab[sender] = nil
	else
		--if SpamProtect(sender) then
			SpamFilter[string.lower(sender)] = GetTime()
			AtlasLoot_GetWishList(message,sender)
			ALModule:SendCommMessage(ShareWishlistPref, "FinishSend", "WHISPER", sender)
		--else
		--	ALModule:SendCommMessage(ShareWishlistPref, "SpamProtect", "WHISPER", sender)
		--end
	end
end

--[[
StaticPopupDialogs["ATLASLOOT_GET_WISHLIST"]
This is shown, if you want too share a wishlist
]]
StaticPopupDialogs["ATLASLOOT_SEND_WISHLIST"] = {
	text = AL["Send Wishlist (%s) to"],
	button1 = AL["Send"],
	button2 = AL["Cancel"],
	OnShow = function()
		this:SetFrameStrata("TOOLTIP");
	end,
	OnAccept = function()
		local name = getglobal(this:GetParent():GetName().."EditBox"):GetText()
		if string.lower(name) == string.lower(playerName) then
			DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["You can't send Wishlists to yourself."]);
			curtabname = ""
			curplayername = ""
		elseif name == "" then

		else
			if SpamProtect(string.lower(name)) then
				AtlasLoot_SendWishList(AtlasLootWishList["Own"][curplayername][curtabname],name)
				curtabname = ""
				curplayername = ""
			else
				local _,_,timeleft = string.find( 10-(GetTime() - SpamFilter[string.lower(name)]), "(%d+)%.")
				DEFAULT_CHAT_FRAME:AddMessage(BLUE..AL["AtlasLoot"]..": "..RED..AL["You must wait "]..WHITE..timeleft..RED..AL[" seconds before you can send a new Wishlist to "]..WHITE..name..RED..".");
			end
		end
	end,
	OnCancel = function ()
		curtabname = ""
		curplayername = ""
	end,
	hasEditBox = 1,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};
