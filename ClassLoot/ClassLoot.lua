--[[ Set the module up ]]--
local ClassLoot = LibStub("AceAddon-3.0"):NewAddon("ClassLoot", "AceConsole-3.0", "AceHook-3.0")

local L, db
local ttList = {
	["GameTooltip"] = { 
		["OnTooltipSetItem"] = true, 
		["OnTooltipSetSpell"] = true, 
		["OnTooltipSetAchievement"] = true,
	},
	["ItemRefTooltip"] = { 
		["OnTooltipSetItem"] = true, 
	},
	["AtlasLootTooltip"] = { 
		["OnTooltipSetItem"] = true,
	},
}
local ttHooks = {}
local ttLine = {}

--[[ Run when ClassLoot is initialized ]]--
function ClassLoot:OnInitialize()
	-- Get Locale
	L = LibStub("AceLocale-3.0"):GetLocale("ClassLoot", true)
	
	-- Register Saved Variables
	local defaults = {
		profile = {
			showTooltip = true,
			showBoss = true,
			showInstance = true
		}
	}
	db = LibStub("AceDB-3.0"):New("ClassLootDB", defaults, "profile")
	
	-- Register slash command
	local opts = {
		name = "ClassLoot",
		handler = ClassLoot,
		type='group',
		args = {
			check = {
				type = 'input',
				name = L["Check an item (Local)"],
				desc = L["Display ClassLoot for an item locally"],
				usage = L["<item link>"],
				get = false,
				set = function(info, val) self:ShowItemStars(val, "LOCAL") end,
				pattern = "item:%d+"
			},
			gcheck = {
				type = 'input',
				name = L["Check an item (Guild)"],
				desc = L["Display ClassLoot for an item in guild chat"],
				usage = L["<item link>"],
				get = false,
				set = function(info, val) self:ShowItemStars(val, "GUILD") end,
				pattern = "item:%d+"
			},
			rcheck = {
				type = 'input',
				name = L["Check an item (Raid)"],
				desc = L["Display ClassLoot for an item in raid chat"],
				usage = L["<item link>"],
				get = false,
				set = function(info, val) self:ShowItemStars(val, "RAID") end,
				pattern = "item:%d+"
			}
		}
	}
	LibStub("AceConfig-3.0"):RegisterOptionsTable("ClassLoot", opts, self.CC["Slash-Commands"])
	
	-- Support LinkWrangler
	if LinkWrangler then
		LinkWrangler.RegisterCallback("ClassLoot", function(f) 
			ttList[f:GetName()] = { 
				["OnTooltipSetItem"] = true, 
				["OnTooltipSetSpell"] = true, 
				["OnTooltipSetAchievement"] = true,
			}
			self:HookTip(f, "OnTooltipSetItem") 
			self:HookTip(f, "OnTooltipSetSpell") 
			self:HookTip(f, "OnTooltipSetAchievement") 
		end, "allocate", "allocatecomp")
	end
end

--[[ Run when ClassLoot is enabled ]]--
function ClassLoot:OnEnable()
	-- Hook tooltips if needed
	if db.profile.showTooltip then
		self:HookTooltips()
	end
	-- Build Interface Options window
	self:CreateInterfaceOptions()
end

--[[ Hook Tooltips ]]--
function ClassLoot:HookTooltips()
	for tooltip, scripts in pairs(ttList) do
		if _G[tooltip] then
			for script, _ in pairs(scripts) do
				self:HookTip(_G[tooltip], script)
			end
		end
	end
end

function ClassLoot:HookTip(tooltip, script)
	local ttName = tooltip:GetName()
	-- Add the tooltip to the line list
	ttLine[ttName] = ttLine[ttName] or {}
	-- Hook the script
	self:HookScript(tooltip, script)
	-- Add the hook to the hook list
	ttHooks[ttName] = ttHooks[ttName] or {}
	ttHooks[ttName][script] = true
end

--[[ Unhook Tooltips ]]--
function ClassLoot:UnhookTooltips()
	for tooltip, scripts in pairs(ttHooks) do
		for script, _ in pairs(scripts) do
			self:UnhookTip(tooltip, script)
		end
	end
end

function ClassLoot:UnhookTip(tooltip, script)
	-- Unhook the script
	self:Unhook(_G[tooltip], script)
	-- Remove the script from the hooks list
	ttHooks[tooltip][script] = nil
	-- If there are no more hooks on the tooltip, remove it completely
	if not next(ttHooks[tooltip]) then
		self:FixRightTextAnchors(_G[tooltip])
		ttHooks[tooltip] = nil
		ttLine[tooltip] = nil
	end
end

-- Make Star Table
--  itemInfo - Table of class/stars
function ClassLoot:MakeStarTable(itemInfo, useTexture)
	local starTable = { [3] = {}; [4] = {}; [5] = {}; }
	local output = {}
	
	-- First, set the class names to the starTable sub-tables
	for class, stars in pairs(itemInfo) do
		starTable[stars][#starTable[stars]+1] = self.CC[class]
	end
	
	-- Now, concat all the class names and set them as the value 
	for stars, _ in pairs(starTable) do
		starTable[stars] = table.concat(starTable[stars], ", ")
	end
	
	-- Walk the table backwards to generate the output
	for i = 5, 3, -1 do
		if starTable[i] ~= "" then
			local stars = ''
			for j = 1, 6 do
				if j <= i then
					stars = ("%s%s"):format(stars, useTexture and ICON_LIST[1]..'0|t' or '{rt1}')
				else
					stars = ("%s%s"):format(stars, useTexture and '|T:0|t' or ' ')
				end
			end
			output[#output+1] = { ["stars"] = stars, ["classes"] = starTable[i] }
		end
	end
	
	-- Finally, return the output
	return output
end

-- WrapInfo
-- 	info - Either a comma-delimited string, or a table of entries to wrap into strings
-- 	len - The length to wrap to
function ClassLoot:WrapInfo(info, len)
	if type(info) == "string" and #info < len then
		return {info}
	end
	if type(info) == "table" and #info == 1 then
		return info
	end
	if type(info) == "string" then
		info = {strsplit(",", info)}
	end
	
	local output = {}
	local line
	for _, c in pairs(info) do
		c = strtrim(c)
		if not line then
			line = c
		elseif (#c + #line + 2) < len then
			line = line .. ", " .. c
		else
			output[#output+1] = line..","
			line = c
		end
	end
	output[#output+1] = line
	return output
end

-- Show Item Stars
--	target   - The chat target (LOCAL, RAID or GUILD)
--	itemLink - The link for the item
function ClassLoot:ShowItemStars(itemLink, target)
	-- Validate Target
	if target == "RAID" and GetNumRaidMembers() == 0 then
		self:Print(L["Not in a raid!"])
		return
	elseif target == "GUILD" and not IsInGuild() then
		self:Print(L["Not in a guild!"])
		return
	end
	
	-- Get the info table
	local itemInfo = self.CD[tonumber(itemLink:match('item:(%d+)'))]
	if not itemInfo then
		-- Not in ClassLoot_Data
		self:Print(itemLink..' '..L["could not be found"])
		return
	end
	
	local PT = LibStub("LibPeriodicTable-3.1"):ItemSearch(itemLink)
	local BB = LibStub("LibBabble-Boss-3.0"):GetUnstrictLookupTable()
	local BZ = LibStub("LibBabble-Zone-3.0"):GetUnstrictLookupTable()
	local output = {}
	
	-- Header
	output[#output+1] = L["ClassLoot info for"]..' '..itemLink
	
	-- Who drops it where
	if PT then
		-- k = index, v = table name [RaidLoot.InstanceName.Difficulty.BossName]
		for _, v in pairs(PT) do
			local set, instance, difficulty, boss = strsplit(".", v)
			if set == "RaidLoot" then
				-- Special cases where the "boss" is not the Boss!
				boss = self.CC[boss] or boss
				-- Localise "boss" and "instance" first, as it could be in 2 different places
				boss = BB[boss] or L[boss]
				instance = BZ[instance] or L[instance]
				if difficulty ~= "0" then
					output[#output+1] = L["Dropped in"]..' '..instance..': '.._G["RAID_DIFFICULTY"..difficulty]..' '..L["by"]..' '..boss
				else
					output[#output+1] = L["Dropped in"]..' '..instance..' '..L["by"]..' '..boss
				end
			end
		end
	end
	
	-- Add all the loot priorities to the output
	for _, v in pairs(self:MakeStarTable(itemInfo, target == "LOCAL")) do
		output[#output+1] = v["stars"]..v["classes"]
	end
	
	-- Ouptput the Item Info!
	for _, v in pairs(output) do
		if target == "LOCAL" then
			self:Print(v)
		else
			SendChatMessage(v, target)
		end
	end
end

--[[ Tooltip Handler to add ClassLoot info to items ]]--
function ClassLoot:OnTooltipSetItem(tooltip, ...)
	local ttName = tooltip:GetName()
	
	-- Reset the 'right text' anchor points on this tooltip
	self:FixRightTextAnchors(tooltip)
	
	local itemLink = select(2, tooltip:GetItem())
	if not itemLink then return end
	local itemInfo = self.CD[tonumber(itemLink:match('item:(%d+)'))]
	if itemInfo and db.profile.showTooltip then
		local firstLine = tooltip:NumLines() + 2
		-- Header
		tooltip:AddLine("|cffff0000ClassLoot:|r")
		
		-- Build the star table
		for _, v in pairs(self:MakeStarTable(itemInfo, true)) do
			for i, c in ipairs(self:WrapInfo(v["classes"], 50)) do
				tooltip:AddDoubleLine(i == 1 and v["stars"] or '|T:0|t', "|cff0099ff"..c.."|r")
			end
		end
		
		if (db.profile.showBoss or db.profile.showInstance) and tooltip ~= AtlasLootTooltip then
			-- Search the item in PT to get instances and bosses
			local PT = LibStub("LibPeriodicTable-3.1"):ItemSearch(itemLink)
			if PT then
				local BB = LibStub("LibBabble-Boss-3.0"):GetUnstrictLookupTable()
				local BZ = LibStub("LibBabble-Zone-3.0"):GetUnstrictLookupTable()
				local bSet, iSet, bList, iList = {}, {}, {}, {}
				
				-- Loop the PT results to get the instances and bosses. k = index, v = table name [RaidLoot.InstanceName.Difficulty.BossName]
				for _, v in pairs(PT) do
					local set, instance, difficulty, boss = strsplit(".", v)
					if set == "RaidLoot" then
						-- Special cases where the "boss" is not the Boss!
						boss = self.CC[boss] or boss
						-- Localize into the  boss and instance sets
						bSet[BB[boss] or L[boss]] = true
						local l_instance = BZ[instance] or L[instance]
						if difficulty ~= "0" then
							l_instance = l_instance..": ".._G["RAID_DIFFICULTY"..difficulty]
						end
						iSet[l_instance] = true
					end
				end
				
				-- Convert boss and instance sets to lists for table.concat()
				for k, _ in pairs(bSet) do
					bList[#bList+1] = k
				end
				for k, _ in pairs(iSet) do
					iList[#iList+1] = k
				end
				
				-- Finally, append to the tooltip
				if db.profile.showBoss and next(bList) then
					for i, c in ipairs(self:WrapInfo(bList, 50)) do
						tooltip:AddDoubleLine(i == 1 and L["Boss"] or '|T:0|t', "|cfff0e68c"..c.."|r", 0.95, 0.90, 0.55)
					end
				end
				if db.profile.showInstance and next(iList) then
					for i, c in ipairs(self:WrapInfo(iList, 50)) do
						tooltip:AddDoubleLine(i == 1 and L["Instance"] or '|T:0|t', "|cfff0e68c"..c.."|r", 0.95, 0.90, 0.55)
					end
				end
			end
		end
		
		local maxLeft = 0
		local lastLine = tooltip:NumLines()
		
		-- Check our new lines for the longest 'left text' (To cope with long localised strings)
		for i = firstLine, lastLine, 1 do
			maxLeft = max(_G[ttName.."TextLeft"..i]:GetWidth(), maxLeft)
		end
		
		-- Now adjust our 'right text' to sit left-aligned, making a note of what we've changed
		for i = firstLine, lastLine, 1 do
			ttLine[ttName][i] = true
			_G[ttName.."TextRight"..i]:SetPoint("LEFT", _G[ttName.."TextLeft"..i], "LEFT", maxLeft+10, 0)
		end
	end
end

function ClassLoot:OnTooltipSetSpell(tooltip, ...)
	self:FixRightTextAnchors(tooltip)
end

function ClassLoot:OnTooltipSetAchievement(tooltip, ...)
	self:FixRightTextAnchors(tooltip)
end

--[[ Tooltip Handler to fix 'right text' anchor points ]]--
function ClassLoot:FixRightTextAnchors(tooltip)
	local ttName = tooltip:GetName()
	for n, _ in pairs(ttLine[ttName]) do
		_G[ttName.."TextRight"..n]:ClearAllPoints()
		ttLine[ttName][n] = nil
	end
end

--[[ Interface Options Window ]]--
function ClassLoot:CreateInterfaceOptions()
	local cfgFrame = CreateFrame("FRAME", nil, UIParent)
	cfgFrame.name = "ClassLoot"
	
	local cfgFrameHeader = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontNormalLarge")
	cfgFrameHeader:SetPoint("TOPLEFT", 15, -15)
	cfgFrameHeader:SetText("ClassLoot")
	
	local cfgShowTooltip = CreateFrame("CHECKBUTTON", "ClassLoot_cfgShowTooltip", cfgFrame, "InterfaceOptionsCheckButtonTemplate")
	ClassLoot_cfgShowTooltip:SetPoint("TOPLEFT", 20, -40)
	ClassLoot_cfgShowTooltipText:SetText(L["Enable ClassLoot Tooltips"])
	ClassLoot_cfgShowTooltip:SetChecked(db.profile.showTooltip)
	ClassLoot_cfgShowTooltip:SetScript("OnClick", function(self)
		db.profile.showTooltip = not db.profile.showTooltip
		-- Toggle the sub-options
		if db.profile.showTooltip then
			-- Enable Sub-Options
			ClassLoot_cfgShowBossTooltip:Enable()
			ClassLoot_cfgShowInstanceTooltip:Enable()
			-- Hook the tooltips
			ClassLoot:HookTooltips()
		else
			-- Disable Sub-Options
			ClassLoot_cfgShowBossTooltip:Disable()
			ClassLoot_cfgShowInstanceTooltip:Disable()
			-- Unhook the tooltips
			ClassLoot:UnhookTooltips()
		end
	end)
	
	local cfgShowBossTooltip = CreateFrame("CHECKBUTTON", "ClassLoot_cfgShowBossTooltip", cfgFrame, "InterfaceOptionsCheckButtonTemplate")
	ClassLoot_cfgShowBossTooltip:SetPoint("TOPLEFT", 40, -64)
	ClassLoot_cfgShowBossTooltipText:SetText(L["Display Boss Name"])
	ClassLoot_cfgShowBossTooltip:SetChecked(db.profile.showBoss)
	ClassLoot_cfgShowBossTooltip:SetScript("OnClick", function(self)
		db.profile.showBoss = not db.profile.showBoss
	end)
	
	local cfgShowInstanceTooltip = CreateFrame("CHECKBUTTON", "ClassLoot_cfgShowInstanceTooltip", cfgFrame, "InterfaceOptionsCheckButtonTemplate")
	ClassLoot_cfgShowInstanceTooltip:SetPoint("TOPLEFT", 40, -88)
	ClassLoot_cfgShowInstanceTooltipText:SetText(L["Display Instance Name"])
	ClassLoot_cfgShowInstanceTooltip:SetChecked(db.profile.showInstance)
	ClassLoot_cfgShowInstanceTooltip:SetScript("OnClick", function(self)
		db.profile.showInstance = not db.profile.showInstance
	end)
	
	-- Check for disabled tooltips on startup
	if not db.profile.showTooltip then
		ClassLoot_cfgShowBossTooltip:Disable()
		ClassLoot_cfgShowInstanceTooltip:Disable()
	end
	
	InterfaceOptions_AddCategory(cfgFrame)
end
