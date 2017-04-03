--[[
	Portions of data included here may belong to either Wowhead or Blizzard.
	Code in this file is hereby released into the Public Domain.
	No warranty of merchantability or fitness of purpose is provided or
	implied. Use this code at your own risk.
]]

if not GathererDB then GathererDB = {} end

local lib = {}
GathererDB.Wowhead = lib

lib.isLoading = true
if not Gatherer then lib.isLoading = false
elseif not Gatherer.Api then lib.isLoading = false
elseif not Gatherer.Api.AddGather then lib.isLoading = false
elseif not Gatherer.ZoneTokens then lib.isLoading = false
elseif not Gatherer.Config.AddCallback then
	DEFAULT_CHAT_FRAME:AddMessage("GathererDB_Wowhead: Please upgrade to the latest version of Gatherer.")
	lib.isLoading = false
end

if not lib.isLoading then
	DEFAULT_CHAT_FRAME:AddMessage("GathererDB_Wowhead: Not loading due to missing or old Gatherer.")
	return
end

local zonelut
local updateFrame
local co

local YIELD_AT = 20
local function beginImport()
	-- Disable minimap updates for the duration of the update
	local curMini = Gatherer.Config.GetSetting("minimap.enable")
	local curHud = Gatherer.Config.GetSetting("hud.enable")
	Gatherer.Config.SetSetting("minimap.enable", false)
	Gatherer.Config.SetSetting("hud.enable", false)

	-- Count the total number of inserts needed, so that we can do a progress bar!
	local position, total, counter = 0,0,0
	for zone, zdata in pairs(lib.data) do
		for node, ndata in pairs(zdata) do
			total = total + #ndata
		end
	end

	-- Neutralize all of the unvalidated nodes by us from the current database...
	for zone, zonedef in pairs(zonelut) do
		local c,z = unpack(zonedef)
		for node, ntype in pairs(Gatherer.Nodes.Objects) do
			Gatherer.Storage.RemoveGather(c, z, node, "DB:Wowhead")
		end
		counter = counter + 1
		if counter > YIELD_AT then
			coroutine.yield()
			counter = 0
		end
	end

	-- Add all the nodes from the current database
	for zone, zdata in pairs(lib.data) do
		local zonedef = zonelut[zone]
		if zonedef then
			local c,z = unpack(zonedef)
			for node, ndata in pairs(zdata) do
				for pos, coord in ipairs(ndata) do
					local x = math.floor(coord/1000)/1000
					local y = (coord%1000)/1000
					local success = Gatherer.Api.AddGather(node, nil, nil, 'DB:Wowhead', nil, nil, false, c, z, x, y)
					position = position + 1
					counter = counter + 1
					if counter > YIELD_AT then
						updateFrame:SetPct(position/total)
						coroutine.yield()
						counter = 0
					end
				end
			end
		end
	end

	-- Restore the minimap and hud display settings
	Gatherer.Config.SetSetting("minimap.enable", curMini)
	Gatherer.Config.SetSetting("hud.enable", curHud)
end

function lib:PerformImport()
	if not updateFrame then
		zonelut = {}
		for c, zones in pairs(Gatherer.ZoneTokens.Tokens) do
			for zone, z in pairs(zones) do
				if type(zone)=='string' and type(z)=='number' then
					zonelut[zone] = {c, z}
				end
			end
		end

		updateFrame = CreateFrame("Frame", nil, UIParent)
		updateFrame:SetPoint("CENTER", UIParent, "CENTER")
		updateFrame:SetFrameStrata("TOOLTIP")
		updateFrame:SetWidth("320")
		updateFrame:SetHeight("50")
		updateFrame:SetScript("OnUpdate", function() 
			if not coroutine.resume(co) then
				this:Hide()
			end
		end)

		updateFrame.text = updateFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		updateFrame.text:SetPoint("TOPLEFT", updateFrame, "TOPLEFT", 10,-5)
		updateFrame.text:SetHeight(16)
		updateFrame.text:SetJustifyH("LEFT")
		updateFrame.text:SetJustifyV("TOP")
		updateFrame.text:SetText("Importing Wowhead database:")

		updateFrame.back = updateFrame:CreateTexture(nil, "BACKGROUND")
		updateFrame.back:SetPoint("TOPLEFT")
		updateFrame.back:SetPoint("BOTTOMRIGHT")
		updateFrame.back:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")

		updateFrame.bar = updateFrame:CreateTexture(nil, "BORDER")
		updateFrame.bar:SetTexture(1,1,1)
		updateFrame.bar:SetPoint("BOTTOMLEFT", updateFrame, "BOTTOMLEFT", 10, 5)
		updateFrame.bar:SetPoint("BOTTOMRIGHT", updateFrame, "BOTTOMRIGHT", -10, 5)
		updateFrame.bar:SetHeight(18)
		updateFrame.bar:SetAlpha(0.2)

		updateFrame.bar.pct = updateFrame:CreateTexture(nil, "ARTWORK")
		updateFrame.bar.pct:SetTexture(1,1,1)
		updateFrame.bar.pct:SetGradientAlpha("Vertical", 0,0,0.4, 1, 0,0,0.7, 1)
		updateFrame.bar.pct:SetPoint("BOTTOMLEFT", updateFrame.bar, "BOTTOMLEFT")
		updateFrame.bar.pct:SetPoint("TOPLEFT", updateFrame.bar, "TOPLEFT")

		updateFrame.bar.text = updateFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		updateFrame.bar.text:SetPoint("TOPLEFT", updateFrame.bar, "TOPLEFT", 0,0)
		updateFrame.bar.text:SetPoint("BOTTOMRIGHT", updateFrame.bar, "BOTTOMRIGHT", 0,0)
		updateFrame.bar.text:SetJustifyH("CENTER")
		updateFrame.bar.text:SetJustifyV("CENTER")

		updateFrame.bar.text:SetText("0%")

		function updateFrame:SetPct(pct)
			pct = math.max(0, math.min((tonumber(pct) or 0), 1))

			local width = updateFrame:GetWidth() - 20
			updateFrame.bar.pct:SetWidth(width * pct)
			updateFrame.bar.text:SetText(("%0.1f%%"):format(pct*100))
		end
	end
	updateFrame:Show()

	co = coroutine.create(beginImport)
end

local function setupGui(gui)
	local id
	if (GathererDB.guiId) then
		id = GathererDB.guiId
	else
		id = gui:AddTab("Database")
		gui:AddControl(id, "Header",     0,    "GathererDB Imports")
		gui:MakeScrollable(id)
		GathererDB.guiId = id
	end

	local version = GetAddOnMetadata("GathererDB_Wowhead", "Version")
	gui:AddControl(id, "Subhead",    0,    "Perform import of Wowhead "..version.." DB:")

	local buttonFrame = CreateFrame("Frame", nil, gui.tabs[id][3])
	buttonFrame:SetHeight(24)
	gui:AddControl(id, "Custom", 0, 1, buttonFrame)

	local button = CreateFrame("Button", nil, buttonFrame, "OptionsButtonTemplate")
	button:SetPoint("TOPLEFT", buttonFrame, "TOPLEFT", 0,0)
	button:SetScript("OnClick", lib.PerformImport)
	button:SetText("Import")

	button.text = button:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	button.text:SetPoint("LEFT", button, "RIGHT", 5, 0)
	button.text:SetPoint("RIGHT", buttonFrame, "RIGHT", 0, 0)
	button.text:SetJustifyH("LEFT")
	button.text:SetText("Data provided courtesy of |cffce0a11http://wowhead.com|r")
end
Gatherer.Config.AddCallback("GathererDB_Wowhead", setupGui)

local nodeBasics = {
	[324]    = { "MINE", "Small Thorium Vein" },
	[1610]   = { "MINE", "Incendicite Mineral Vein" },
	[1731]   = { "MINE", "Copper Vein" },
	[1732]   = { "MINE", "Tin Vein" },
	[1733]   = { "MINE", "Silver Vein" },
	[1734]   = { "MINE", "Gold Vein" },
	[1735]   = { "MINE", "Iron Deposit" },
	[2040]   = { "MINE", "Mithril Deposit" },
	[2047]   = { "MINE", "Truesilver Deposit" },
	[2653]   = { "MINE", "Lesser Bloodstone Deposit" },
	[19903]  = { "MINE", "Indurium Mineral Vein" },
	[73940]  = { "MINE", "Ooze Covered Silver Vein" },
	[73941]  = { "MINE", "Ooze Covered Gold Vein" },
	[123309] = { "MINE", "Ooze Covered Truesilver Deposit" },
	[123310] = { "MINE", "Ooze Covered Mithril Deposit" },
	[123848] = { "MINE", "Ooze Covered Thorium Vein" },
	[165658] = { "MINE", "Dark Iron Deposit" },
	[175404] = { "MINE", "Rich Thorium Vein" },
	[177388] = { "MINE", "Ooze Covered Rich Thorium Vein" },
	[180215] = { "MINE", "Hakkari Thorium Vein" },
	[181555] = { "MINE", "Fel Iron Deposit" },
	[181556] = { "MINE", "Adamantite Deposit" },
	[181557] = { "MINE", "Khorium Vein" },
	[181569] = { "MINE", "Rich Adamantite Deposit" },
	[185877] = { "MINE", "Nethercite Deposit" },
	[189978] = { "MINE", "Cobalt Node" },
	[189979] = { "MINE", "Rich Cobalt Node" },
	[189980] = { "MINE", "Saronite Node" },
	[189981] = { "MINE", "Rich Saronite Node" },
	[191133] = { "MINE", "Titanium Node" },
	[1617]   = { "HERB", "Silverleaf" },
	[1618]   = { "HERB", "Peacebloom" },
	[1619]   = { "HERB", "Earthroot" },
	[1620]   = { "HERB", "Mageroyal" },
	[1621]   = { "HERB", "Briarthorn" },
	[1622]   = { "HERB", "Bruiseweed" },
	[1623]   = { "HERB", "Wild Steelbloom" },
	[1624]   = { "HERB", "Kingsblood" },
	[1628]   = { "HERB", "Grave Moss" },
	[2041]   = { "HERB", "Liferoot" },
	[2042]   = { "HERB", "Fadeleaf" },
	[2043]   = { "HERB", "Khadgar's Whisker" },
	[2044]   = { "HERB", "Wintersbite" },
	[2045]   = { "HERB", "Stranglekelp" },
	[2046]   = { "HERB", "Goldthorn" },
	[2866]   = { "HERB", "Firebloom" },
	[142140] = { "HERB", "Purple Lotus" },
	[142141] = { "HERB", "Arthas' Tears" },
	[142142] = { "HERB", "Sungrass" },
	[142143] = { "HERB", "Blindweed" },
	[142144] = { "HERB", "Ghost Mushroom" },
	[142145] = { "HERB", "Gromsblood" },
	[176583] = { "HERB", "Golden Sansam" },
	[176584] = { "HERB", "Dreamfoil" },
	[176586] = { "HERB", "Mountain Silversage" },
	[176587] = { "HERB", "Plaguebloom" },
	[176588] = { "HERB", "Icecap" },
	[176589] = { "HERB", "Black Lotus" },
	[181166] = { "HERB", "Bloodthistle" },
	[181270] = { "HERB", "Felweed" },
	[181271] = { "HERB", "Dreaming Glory" },
	[181275] = { "HERB", "Ragveil" },
	[181276] = { "HERB", "Flame Cap" },
	[181277] = { "HERB", "Terocone" },
	[181278] = { "HERB", "Ancient Lichen" },
	[181279] = { "HERB", "Netherbloom" },
	[181280] = { "HERB", "Nightmare Vine" },
	[181281] = { "HERB", "Mana Thistle" },
	[185881] = { "HERB", "Netherdust Bush" },
	[189973] = { "HERB", "Goldclover" },
	[190169] = { "HERB", "Tiger Lily" },
	[190170] = { "HERB", "Talandra's Rose" },
	[190171] = { "HERB", "Lichbloom" },
	[190172] = { "HERB", "Icethorn" },
	[190175] = { "HERB", "Frozen Herb" },
	[190176] = { "HERB", "Frost Lotus" },
	[191019] = { "HERB", "Adder's Tongue" },
	[191303] = { "HERB", "Firethorn" },
	[2039]   = { "OPEN", "Hidden Strongbox" },
	[2744]   = { "OPEN", "Giant Clam" },
	[2843]   = { "OPEN", "Battered Chest" },
	[2844]   = { "OPEN", "Tattered Chest" },
	[2850]   = { "OPEN", "Solid Chest" },
	[3658]   = { "OPEN", "Water Barrel" },
	[3659]   = { "OPEN", "Barrel of Melon Juice" },
	[3660]   = { "OPEN", "Armor Crate" },
	[3661]   = { "OPEN", "Weapon Crate" },
	[3662]   = { "OPEN", "Food Crate" },
	[3705]   = { "OPEN", "Barrel of Milk" },
	[3706]   = { "OPEN", "Barrel of Sweet Nectar" },
	[3714]   = { "OPEN", "Alliance Strongbox" },
	[19019]  = { "OPEN", "Box of Assorted Parts" },
	[28604]  = { "OPEN", "Scattered Crate" },
	[74447]  = { "OPEN", "Large Iron Bound Chest" },
	[74448]  = { "OPEN", "Large Solid Chest" },
	[75293]  = { "OPEN", "Large Battered Chest" },
	[123330] = { "OPEN", "Buccaneer's Strongbox" },
	[131978] = { "OPEN", "Large Mithril Bound Chest" },
	[131979] = { "OPEN", "Large Darkwood Chest" },
	[142191] = { "OPEN", "Horde Supply Crate" },
	[157936] = { "OPEN", "Un'Goro Dirt Pile" },
	TREASURE_POWERCRYST = { "OPEN", "Blue Power Crystal" },
	TREASURE_POWERCRYST = { "OPEN", "Green Power Crystal" },
	TREASURE_POWERCRYST = { "OPEN", "Red Power Crystal" },
	TREASURE_POWERCRYST = { "OPEN", "Yellow Power Crystal" },
	[164958] = { "OPEN", "Bloodpetal Sprout" },
	[176213] = { "OPEN", "Blood of Heroes" },
	[176582] = { "OPEN", "Shellfish Trap" },
	[178244] = { "OPEN", "Practice Lockbox" },
	[179486] = { "OPEN", "Battered Footlocker" },
	[179487] = { "OPEN", "Waterlogged Footlocker" },
	[179492] = { "OPEN", "Dented Footlocker" },
	[179493] = { "OPEN", "Mossy Footlocker" },
	[179498] = { "OPEN", "Scarlet Footlocker" },
	[181628] = { "OPEN", "Empty Barrel" },
	[182053] = { "OPEN", "Glowcap" },
	[164881] = { "OPEN", "Cleansed Night Dragon" },
	[164882] = { "OPEN", "Cleansed Songflower" },
	[174662] = { "OPEN", "Cleansed Whipper Root" },
	[164884] = { "OPEN", "Cleansed Windblossom" },
	[185881] = { "OPEN", "Netherdust Bush" },
	[185877] = { "OPEN", "Nethercite Deposit" },
	[179697] = { "OPEN", "Arena Treasure Chest" },
	[182069] = { "OPEN", "Mature Spore Sac" },
	[142184] = { "OPEN", "Captain's Chest" },
	[177784] = { "OPEN", "Giant Softshell Clam" },
	[2560]   = { "OPEN", "Half-Buried Bottle" },
	[141931] = { "OPEN", "Hippogryph Egg" },
	[2883]   = { "OPEN", "Ripe Pumpkin" },
	[152608] = { "OPEN", "Kolkar's Booty" },
	[105176] = { "OPEN", "Venture Co. Strongbox" },
	[123330] = { "OPEN", "Buccaneer's Strongbox" },
	[181665] = { "OPEN", "Burial Chest" },
	[184793] = { "OPEN", "Primitive Chest" },
	[105570] = { "OPEN", "Alliance Strongbox" },
	[179486] = { "OPEN", "Battered Footlocker" },
	[179487] = { "OPEN", "Waterlogged Footlocker" },
	[179492] = { "OPEN", "Dented Footlocker" },
	[179493] = { "OPEN", "Mossy Footlocker" },
	[184740] = { "OPEN", "Wicker Chest" },
	[184742] = { "OPEN", "Dented Footlocker" },
	[181798] = { "OPEN", "Fel Iron Chest" },
	[181800] = { "OPEN", "Heavy Fel Iron Chest" },
	[181802] = { "OPEN", "Adamantite Bound Chest" },
	[181804] = { "OPEN", "Felsteel Chest" },
	[185915] = { "OPEN", "Netherwing Egg" },
	[182258] = { "OPEN", "Oshu'gun Crystal Fragment" },
	[181598] = { "OPEN", "Silithyst Geyser" },
	[193997] = { "OPEN", "Everfrost Chip" },
}

local locale = GetLocale()
for nodeId, nData in pairs(nodeBasics) do
	local nodeType, nodeName = unpack(nData)
	if not Gatherer.Nodes.Objects[nodeId] then
		Gatherer.Nodes.Objects[nodeId] = nodeType
	end
	if locale == "enUS" then
		if not Gatherer.Nodes.Names[nodeName] then
			Gatherer.Nodes.Names[nodeName] = nodeId
		end
		if not Gatherer.Categories.CategoryNames[nodeId] then
			Gatherer.Categories.CategoryNames[nodeId] = nodeName
		end
	end
end

