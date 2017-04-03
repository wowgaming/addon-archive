local addonName = ...
local addon = _G[addonName]

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"

local currentTokenType
local usedTokens
local tokenTextures = {}

addon.Currencies = {}

local ns = addon.Currencies		-- ns = namespace

local function HashToSortedArray(hash)
	local array = {}		-- order them
	for k, _ in pairs(hash) do
		table.insert(array, k)
	end
	table.sort(array)
	return array
end

local function GetUsedHeaders()
	local realm, account = addon:GetCurrentRealm()
	local DS = DataStore
	
	local usedHeaders = {}

	for _, character in pairs(DS:GetCharacters(realm, account)) do	-- all alts on this realm
		local num = DS:GetNumCurrencies(character) or 0
		for i = 1, num do
			local isHeader, name = DS:GetCurrencyInfo(character, i)	-- save ech header found in the table
			if isHeader then
				usedHeaders[name] = true
			end
		end
	end
	
	return HashToSortedArray(usedHeaders)
end

local function GetUsedTokens(header)
	-- get the list of tokens found under a specific header, across all alts

	local realm, account = addon:GetCurrentRealm()
	local DS = DataStore
	
	local tokens = {}
	local useData				-- use data for a specific header or not

	for _, character in pairs(DS:GetCharacters(realm, account)) do	-- all alts on this realm
		local num = DS:GetNumCurrencies(character) or 0
		for i = 1, num do
			local isHeader, name, _, itemID = DS:GetCurrencyInfo(character, i)
			if isHeader then
				if name == header then		-- the header we're searching for, set the flag
					useData = true
				else
					useData = nil
				end
			else
				if useData then		-- mark it as used
					tokens[name] = true
					tokenTextures[name] = GetItemIcon(itemID)
				end
			end
		end
	end
	
	return HashToSortedArray(tokens)
end

local function DDM_Add(text, func, arg1, arg2)
	-- tiny wrapper
	local info = UIDropDownMenu_CreateInfo(); 
	
	info.text		= text
	info.func		= func
	info.arg1		= arg1
	info.arg2		= arg2
	info.checked	= nil
	UIDropDownMenu_AddButton(info, 1); 
end

local function DDM_AddCloseMenu()
	local info = UIDropDownMenu_CreateInfo(); 
	
	-- Close menu item
	info.text = CLOSE
	info.func = function() CloseDropDownMenus() end
	info.checked = nil
	info.notCheckable = 1
	info.icon		= nil
	UIDropDownMenu_AddButton(info, 1)
end

local function DDM_OnClick(self, header)
	currentTokenType = header
	UIDropDownMenu_SetText(AltoholicFrameCurrencies_SelectCurrencies, currentTokenType)
	usedTokens = GetUsedTokens(currentTokenType)
	ns:Update()
end

local function Currencies_UpdateEx(self, offset, entry, desc)
	local line
	local size = desc:GetSize()
	
	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	local character
	
	for i=1, desc.NumLines do
		line = i + offset
		if line <= size then
			local token = usedTokens[line]
		
			_G[entry..i.."Name"]:SetText(WHITE .. token)
			_G[entry..i.."Name"]:SetJustifyH("LEFT")
			_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
			
			for j = 1, 10 do	-- loop through the 10 alts
				local itemName = entry.. i .. "Item" .. j;
				local itemButton = _G[itemName]
				local classButton = _G["AltoholicFrameClassesItem" .. j]
				
				local itemTexture = _G[itemName .. "_Background"]
				itemTexture:SetTexture(tokenTextures[token])

				if classButton.CharName then	-- if there's an alt in this column..
					character = DS:GetCharacter(classButton.CharName, realm, account)
					local count = DS:GetCurrencyInfoByName(character, token)
					itemButton.count = count
				
					if count then 
						itemTexture:SetVertexColor(0.5, 0.5, 0.5);	-- greyed out
						itemButton.CharName = classButton.CharName
						
						if count >= 100000 then
							count = format("%2.1fM", count/1000000)
						elseif count >= 10000 then
							count = format("%2.0fk", count/1000)
						elseif count >= 1000 then
							count = format("%2.1fk", count/1000)
						end
						
						_G[itemName .. "Name"]:SetText(GREEN..count)
						itemButton:Show()
					else
						itemButton.CharName = nil
						itemButton:Hide()
					end
				else
					itemButton:Hide()
				end
			end
			_G[ entry..i ]:SetID(line)
			_G[ entry..i ]:Show()
		end
	end
end

local CurrenciesScrollFrame_Desc = {
	NumLines = 8,
	LineHeight = 41,
	Frame = "AltoholicFrameCurrencies",
	GetSize = function() return #usedTokens end,
	Update = Currencies_UpdateEx,
}

local function DropDown_Initialize()
	for _, header in ipairs(GetUsedHeaders()) do		-- and add them to the DDM
		DDM_Add(header, DDM_OnClick, header)
	end
	DDM_AddCloseMenu()
end

function ns:Init()
	local headers = GetUsedHeaders()
	currentTokenType = headers[1]

	local f = AltoholicFrameCurrencies_SelectCurrencies
	UIDropDownMenu_SetText(f, currentTokenType)
	UIDropDownMenu_Initialize(f, DropDown_Initialize)
	
	usedTokens = GetUsedTokens(currentTokenType)
end

function ns:Update()
	addon:ScrollFrameUpdate(CurrenciesScrollFrame_Desc)
end

function ns:OnEnter(frame)
	local charName = frame.CharName
	if not charName then return end
	
	local DS = DataStore
	local realm, account = addon:GetCurrentRealm()
	local character = DS:GetCharacter(charName, realm, account)
	
	AltoTooltip:SetOwner(frame, "ANCHOR_LEFT");
	AltoTooltip:ClearLines();
	AltoTooltip:AddLine(DS:GetColoredCharacterName(character));
	AltoTooltip:AddLine(usedTokens[frame:GetParent():GetID()], 1, 1, 1);
	AltoTooltip:AddLine(GREEN..frame.count);
	AltoTooltip:Show();
end
