SellJunk = LibStub("AceAddon-3.0"):NewAddon("SellJunk", "AceConsole-3.0","AceEvent-3.0")
local addon	= LibStub("AceAddon-3.0"):GetAddon("SellJunk")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog 	= LibStub("AceConfigDialog-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("SellJunk", true)

addon.optionsFrame = {}
local options = nil

addon.sellButton = CreateFrame("Button", nil, MerchantFrame, "OptionsButtonTemplate")
addon.sellButton:SetPoint("TOPRIGHT", -41, -40)
addon.sellButton:SetText(L["SELLJUNK"])
addon.sellButton:SetScript("OnClick", function() SellJunk:Sell() end)

-- upvalues
local floor = floor
local mod = mod
local string_find = string.find
local pairs = pairs
local wipe = wipe
local DeleteCursorItem = DeleteCursorItem
local GetContainerItemInfo = GetContainerItemInfo
local GetItemInfo = GetItemInfo
local PickupContainerItem = PickupContainerItem
local PickupMerchantItem = PickupMerchantItem


function addon:OnInitialize()
  self:RegisterChatCommand("selljunk", "HandleSlashCommands")
  self:RegisterChatCommand("sj", "HandleSlashCommands")

  self.db = LibStub("AceDB-3.0"):New("SellJunkDB")
  self.db:RegisterDefaults({
    char = {
      exceptions = {},
      auto = false,
			max12 = true,
			printGold = true,
      showSpam = true
    },
    global = {
      exceptions = {},
    }
  })

  self:PopulateOptions()
  AceConfigRegistry:RegisterOptionsTable("SellJunk", options)
  addon.optionsFrame = AceConfigDialog:AddToBlizOptions("SellJunk", nil, nil, "general")
end

function addon:OnEnable()
  self:RegisterEvent("MERCHANT_SHOW")
	self.total = 0
end

function addon:MERCHANT_SHOW()	
  if addon.db.char.auto then
    self:Sell()
  end
end

function addon:AddProfit(profit)
	if profit then
		self.total = self.total + profit
	end
end

-------------------------------------------------------------
-- Sells items:                                            --
--   - grey quality, unless it's in exception list         --
--   - better than grey quality, if it's in exception list --
-------------------------------------------------------------
function addon:Sell()
	local limit = 0
  local currPrice

  for bag = 0,4 do
    for slot = 1,GetContainerNumSlots(bag) do
      local item = GetContainerItemLink(bag,slot)
      if item then
				-- is it grey quality item?
        local found = string_find(item,"|cff9d9d9d")

        if ((found) and (not addon:isException(item))) or ((not found) and (addon:isException(item))) then
          currPrice = select(11, GetItemInfo(item)) * select(2, GetContainerItemInfo(bag, slot))
          -- this should get rid of problems with grey items, that cant be sell to a vendor
          if currPrice > 0 then
            addon:AddProfit(currPrice)
            PickupContainerItem(bag, slot)
            PickupMerchantItem()
            if addon.db.char.showSpam then
              self:Print(L["SOLD"].." "..item)
            end

            if addon.db.char.max12 then
              limit = limit + 1
              if limit == 12 then
                return
              end
            end
          end
        end
      end
    end
  end

	if self.db.char.printGold then
		self:PrintGold()
	end
	self.total = 0
end

-------------------------------------------------------------
-- Destroys items:                                         --
--   - grey quality, unless it's in exception list         --
--   - better than grey quality, if it's in exception list --
-------------------------------------------------------------
function addon:Destroy(count)
  local limit = 9001 -- it's over NINE THOUSAND!!!
  if count ~= nil then
    limit = count
  end
  for bag = 0,4 do
    for slot = 1,GetContainerNumSlots(bag) do
      local item = GetContainerItemLink(bag,slot)
      if item then
				-- is it grey quality item?
        local found = string_find(item,"|cff9d9d9d")

        if ((found) and (not addon:isException(item))) or ((not found) and (addon:isException(item))) then
          PickupContainerItem(bag, slot)
					DeleteCursorItem()
          if addon.db.char.showSpam then
            self:Print(L["DESTROYED"].." "..item)
          end
          limit = limit - 1
          if limit == 0 then
            break
          end
        end
      end
    end
    if limit == 0 then
      break
    end
  end

	if self.db.char.printGold then
		self:PrintGold()
	end
	self.total = 0
end

function addon:PrintGold()
	local ret = ""
	local gold = floor(self.total / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((self.total - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(self.total, COPPER_PER_SILVER);
	if gold > 0 then
		ret = gold.." "..L["GOLD"].." "
	end
	if silver > 0 or gold > 0 then
		ret = ret..silver .." "..L["SILVER"].." "
	end
	ret = ret..copper.." "..L["COPPER"]
	if silver > 0 or gold > 0  or copper > 0 then
		self:Print(L["GAINED"].." "..ret)
	end
end

function addon:Add(link, global)

	-- remove all trailing whitespace
	link = strtrim(link)

	-- extract name from an itemlink
  local found, _, name = string_find(link, "^|c%x+|H.+|h.(.*)\].+")

	-- if it's not an itemlink, guess it's name of an item
	if not found then
		name = link
	end

  if global then
		for k,v in pairs(self.db.global.exceptions) do
			if v == name or v == link then
				return
			end
		end

		-- append name of the item to global exception list
    self.db.global.exceptions[#(self.db.global.exceptions) + 1] = name
    if ( GetLocale() == "koKR" ) then
			self:Print( link .. "|1이;가; ".. L["GLOBAL_EXC"] .. L["TO"].. " " .. L["ADDED"])
    else
			self:Print(L["ADDED"] .. " " .. link .. " " .. L["TO"].." "..L["GLOBAL_EXC"])
    end
  else
		for k,v in pairs(self.db.char.exceptions) do
			if v == name or v == link then
				return
			end
		end

		-- append name of the item to character specific exception list
    self.db.char.exceptions[#(self.db.char.exceptions) + 1] = name
    if ( GetLocale() == "koKR" ) then
			self:Print( link .. "|1이;가; ".. L["CHAR_EXC"] .. L["TO"].. " " .. L["ADDED"])
    else
			self:Print(L["ADDED"] .. " " .. link .. " " .. L["TO"].." "..L["CHAR_EXC"])
    end
  end
end

function addon:Rem(link, global)
	local found = false
	local exception = nil

	-- remove all trailing whitespace
	link = strtrim(link)

	-- extract name from an itemlink
  local isLink, _, name = string_find(link, "^|c%x+|H.+|h.(.*)\].+")

	-- if it's not an itemlink, guess it's name of an item
	if not isLink then
		name = link
	end

	if global then

		-- looping through global exceptions
		for k,v in pairs(self.db.global.exceptions) do
			-- comparing exception list entry with given name
			if v:lower() == name:lower() then
				found = true
			end

			-- extract name from itemlink (only for compatibility with old saved variables)
			isLink, _, exception = string_find(v, "^|c%x+|H.+|h.(.*)\].+")
			if isLink then
				-- comparing exception list entry with given name
				if exception:lower() == name:lower() then
					found = true
				end
			end

			if found then
				if self.db.global.exceptions[k+1] then
					self.db.global.exceptions[k] = self.db.global.exceptions[k+1]
				else
					self.db.global.exceptions[k] = nil
				end
			end
		end

		if found then
			if ( GetLocale() == "koKR" ) then
				self:Print(link.."|1이;가; "..L["GLOBAL_EXC"]..L["FROM"] .." "..L["REMOVED"])
			else
				self:Print(L["REMOVED"].." "..link.." "..L["FROM"].." "..L["GLOBAL_EXC"])
			end
		end
	else

		-- looping through character specific exceptions
		for k,v in pairs(self.db.char.exceptions) do
			-- comparing exception list entry with given name
			if v:lower() == name:lower() then
				found = true
			end

			-- extract name from itemlink (only for compatibility with old saved variables)
			isLink, _, exception = string_find(v, "^|c%x+|H.+|h.(.*)\].+")
			if isLink then
				-- comparing exception list entry with given name
				if exception:lower() == name:lower() then
					found = true
				end
			end

			if found then
				if self.db.char.exceptions[k+1] then
					self.db.char.exceptions[k] = self.db.char.exceptions[k+1]
				else
					self.db.char.exceptions[k] = nil
				end
			end
		end

		if found then
			if ( GetLocale() == "koKR" ) then
				self:Print(link.."|1이;가; "..L["CHAR_EXC"]..L["FROM"] .." "..L["REMOVED"]) 
			else
				self:Print(L["REMOVED"].." "..link..L["FROM"].." "..L["CHAR_EXC"])
			end
		end
	end
end

function addon:isException(link)
	local exception = nil

	-- extracting name of an item from the itemlink
	local isLink, _, name = string_find(link, "^|c%x+|H.+|h.(.*)\].+")

	-- it's not an itemlink, so guess it's name of the item
	if not isLink then
		name = link
	end

	if self.db.global.exceptions then

		-- looping through global exceptions
		for k,v in pairs(self.db.global.exceptions) do

			-- comparing exception list entry with given name
			if v:lower() == name:lower() then
				return true
			end

			-- extract name from itemlink (only for compatibility with old saved variables)
			isLink, _, exception = string_find(v, "^|c%x+|H.+|h.(.*)\].+")
			if isLink then
				-- comparing exception list entry with given name
				if exception:lower() == name:lower() then
					return true
				end
			end
		end
	end


	if self.db.char.exceptions then

		-- looping through character specific eceptions
		for k,v in pairs(self.db.char.exceptions) do

			-- comparing exception list entry with given name
			if v:lower() == name:lower() then
        return true
      end

			-- extract name from itemlink (only for compatibility with old saved variables)
			isLink, _, exception = string_find(v, "^|c%x+|H.+|h.(.*)\].+")
			if isLink then
				-- comparing exception list entry with given name
				if exception:lower() == name:lower() then
					return true
				end
			end
		end
	end

	-- item not found in any exception list
	return false
end

function addon:ClearGlobalDB()
  wipe(self.db.global.exceptions)
  self:Print(L["CLEARED"])
end

function addon:ClearCharDB()
  wipe(self.db.char.exceptions)
  self:Print(L["CLEARED"])
end

function addon:HandleSlashCommands(input)
  local arg1, arg2 = self:GetArgs(input, 2, 1, input)
  if arg1 == 'destroy' then
    self:Destroy(arg2)
  elseif arg1 == 'add' and arg2 ~= nil then
    if arg2:find('|Hitem') == nil then
      self:Print(L["ITEMLINK_ONLY"])
    else
      self:Add(arg2, true)
    end
  elseif arg1 == 'rem' and arg2 ~= nil then
    if arg2:find('|Hitem') == nil then
      self:Print(L["ITEMLINK_ONLY"])
    else
      self:Rem(arg2, true)
    end
  else
    InterfaceOptionsFrame_OpenToCategory(addon.optionsFrame)
  end
end

function addon:PopulateOptions()
	if not options then
		options = {
			order = 1,
			type  = "group",
			name  = "SellJunk",
			args  = {
				general = {
					order	= 1,
					type	= "group",
					name	= "global",
					args	= {
						divider1 = {
							order	= 1,
							type	= "description",
							name	= "",
						},
						auto = {
							order	= 2,
							type 	= "toggle",
							name 	= L["AUTO_SELL"],
							desc 	= L["AUTO_SELL_DESC"],
							get 	= function() return addon.db.char.auto end,
							set 	= function() self.db.char.auto = not self.db.char.auto end,
						},
						divider2 = {
							order	= 3,
							type	= "description",
							name	= "",
						},

						max12 = {
							order = 4,
							type  = "toggle",
							name  = L["MAX12"],
							desc  = L["MAX12_DESC"],
							get 	= function() return addon.db.char.max12 end,
							set 	= function() self.db.char.max12 = not self.db.char.max12 end,
						},
						divider3 = {
							order	= 5,
							type	= "description",
							name	= "",
						},
						printGold = {
							order = 6,
							type  = "toggle",
							name  = L["SHOW_GAIN"],
							desc  = L["SHOW_GAIN_DESC"],
							get 	= function() return addon.db.char.printGold end,
							set 	= function() self.db.char.printGold = not self.db.char.printGold end,
						},
            divider4 = {
							order	= 7,
							type	= "description",
							name	= "",
						},
            showSpam = {
              order = 8,
              type  = "toggle",
              name  = L["SHOW_SPAM"],
              desc  = L["SHOW_SPAM_DESC"],
              get   = function() return addon.db.char.showSpam end,
              set   = function() addon.db.char.showSpam = not addon.db.char.showSpam end,
            },
						divider5 = {
							order	= 9,
							type	= "header",
							name	= L["CLEAR_HEADER"],
						},
						clearglobal = {
							order	= 10,
							type 	= "execute",
							name 	= L["CLEAR_GLOBAL"],
              desc  = L["CLEAR_GLOBAL_DESC"],
							func 	= function() addon:ClearGlobalDB() end,
						},
            clearchar = {
							order	= 11,
							type 	= "execute",
							name 	= L["CLEAR_CHAR"],
              desc  = L["CLEAR_CHAR_DESC"],
							func 	= function() addon:ClearCharDB() end,
						},
						divider6 = {
							order	= 12,
							type	= "description",
							name	= "",
						},
						header1 = {
							order	= 13,
							type	= "header",
							name	= L["GLOBAL_EXC"],
						},
						note1 = {
							order = 14,
							type 	= "description",
							name	= L["DRAG_ITEM_DESC"],
						},
						add = {
							order	= 15,
							type 	= "input",
							name 	= L["ADD_ITEM"],
							desc 	= L["ADD"].." "..L["ALL_CHARS"],
							usage = L["ITEMLINK"],
							get 	= false,
							set 	= function(info, v) addon:Add(v, true) end,
						},
						rem = {
							order	= 16,
							type 	= "input",
							name 	= L["REM_ITEM"],
							desc 	= L["REM"].." "..L["ALL_CHARS"],
							usage 	= L["ITEMLINK"],
							get 	= false,
							set 	= function(info, v) addon:Rem(v, true) end,
						},
						header2 = {
							order	= 17,
							type	= "header",
							name	= L["CHAR_EXC"],
						},
						addMe = {
							order	= 18,
							type 	= "input",
							name 	= L["ADD_ITEM"],
							desc 	= L["ADD"].." "..L["THIS_CHAR"],
							usage 	= L["ITEMLINK"],
							get 	= false,
							set 	= function(info, v) addon:Add(v, false) end,
						},
						remMe = {
							order	= 19,
							type 	= "input",
							name 	= L["REM_ITEM"],
							desc 	= L["REM"].." "..L["THIS_CHAR"],
							usage 	= L["ITEMLINK"],
							get 	= false,
							set 	= function(info, v) addon:Rem(v, false) end,
						},
					}
				}
			}
		}
	end
end
