local addonName = "Altoholic"
local addon = _G[addonName]

local WHITE		= "|cFFFFFFFF"

local view
local highlightIndex

addon.Tabs.Achievements = {}

local ns = addon.Tabs.Achievements		-- ns = namespace

local function BuildView()
	view = view or {}
	wipe(view)
	
	local cats = GetCategoryList()
	for _, categoryID in ipairs(cats) do
		local _, parentID = GetCategoryInfo(categoryID)
		
		if parentID == -1 then		-- add categories, followed by their respective sub-categories
			table.insert(view, { id = categoryID, isCollapsed = true } )
			
			for _, subCatID in ipairs(cats) do
				local _, subCatParentID = GetCategoryInfo(subCatID)
				if subCatParentID == categoryID then
					table.insert(view, subCatID )
				end
			end
		end
	end
end

local function Header_OnClick(frame)
	highlightIndex = frame.categoryIndex
	local header = view[highlightIndex]
	header.isCollapsed = not header.isCollapsed

	ns:Update();
	AltoholicFrameAchievements:Show()
	addon.Achievements:SetCategory(header.id)
	addon.Achievements:Update()
end

local function Item_OnClick(frame)
	highlightIndex = frame.subCategoryIndex
	local item = view[highlightIndex]
	
	ns:Update();
	AltoholicFrameAchievements:Show()
	addon.Achievements:SetCategory(item)
	addon.Achievements:Update()
end

function ns:Update()
	if not view then
		BuildView()
	end

	local VisibleLines = 15

	local categoryIndex				-- index of the category in the menu table
	local categoryCacheIndex		-- index of the category in the cache table
	local MenuCache = {}
	
	for k, v in pairs (view) do		-- rebuild the cache
		if type(v) == "table" then		-- header
			categoryIndex = k
			table.insert(MenuCache, { linetype=1, nameIndex=k } )
			categoryCacheIndex = #MenuCache
			
			if (highlightIndex) and (highlightIndex == k) then
				MenuCache[#MenuCache].needsHighlight = true
			end
		else
			if view[categoryIndex].isCollapsed == false then
				table.insert(MenuCache, { linetype=2, nameIndex=k, parentIndex=categoryIndex } )
				
				if (highlightIndex) and (highlightIndex == k) then
					MenuCache[#MenuCache].needsHighlight = true
					MenuCache[categoryCacheIndex].needsHighlight = true
				end
			end
		end
	end
	
	local buttonWidth = 156
	if #MenuCache > 15 then
		buttonWidth = 136
	end
	
	local scrollFrame = AltoholicAchievementsMenuScrollFrame
	local offset = FauxScrollFrame_GetOffset( scrollFrame );
	local itemButtom = "AltoholicTabAchievementsMenuItem"
	for i=1, VisibleLines do
		local line = i + offset
		
		if line > #MenuCache then
			_G[itemButtom..i]:Hide()
		else
			local p = MenuCache[line]
			
			_G[itemButtom..i]:SetWidth(buttonWidth)
			_G[itemButtom..i.."NormalText"]:SetWidth(buttonWidth - 21)
			if p.needsHighlight then
				_G[itemButtom..i]:LockHighlight()
			else
				_G[itemButtom..i]:UnlockHighlight()
			end			
			
			if p.linetype == 1 then
				local catName = GetCategoryInfo(view[p.nameIndex].id)
				
				_G[itemButtom..i.."NormalText"]:SetText(WHITE .. catName)
				_G[itemButtom..i]:SetScript("OnClick", Header_OnClick)
				_G[itemButtom..i].categoryIndex = p.nameIndex
			elseif p.linetype == 2 then
				local catName = GetCategoryInfo(view[p.nameIndex])
				
				_G[itemButtom..i.."NormalText"]:SetText("|cFFBBFFBB   " .. catName)
				_G[itemButtom..i]:SetScript("OnClick", Item_OnClick)
				_G[itemButtom..i].categoryIndex = p.parentIndex
				_G[itemButtom..i].subCategoryIndex = p.nameIndex
			end

			_G[itemButtom..i]:Show()
		end
	end
	
	FauxScrollFrame_Update( scrollFrame, #MenuCache, VisibleLines, 20);
end
