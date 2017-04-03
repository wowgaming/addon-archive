
--
--  Overachiever - Tabs: Search.lua
--    by Tuhljin
--
--  If you don't wish to use the search tab, feel free to delete this file or rename it (e.g. to Search_unused.lua).
--  The addon's other features will work regardless.
--

local L = OVERACHIEVER_STRINGS

local CATEGORIES_ALL = Overachiever.UI_GetValidCategories()


local function copytab(from, to)
  for k,v in pairs(from) do
    if(type(v) == "table") then
      to[k] = {}
      copytab(v, to[k]);
    else
      to[k] = v;
    end
  end
end

local AchSearch = Overachiever.SearchForAchievement

local function findCriteria(id, pattern)
  local critString, foundCrit
  for i=1,GetAchievementNumCriteria(id) do
    critString = GetAchievementCriteriaInfo(id, i)
    foundCrit = strfind(strlower(critString), pattern, 1, true)
    if (foundCrit) then  return true;  end
  end
end

local found

local function AchSearch_Criteria(list, pattern, results)
  pattern = strlower(pattern)
  found = found and wipe(found) or {}
  local anyFound
  if (list) then
    for i,id in ipairs(list) do
      if (findCriteria(id, pattern)) then
        found[#found+1] = id
        anyFound = true
      end
    end
  else
    local id
    for _,cat in ipairs(CATEGORIES_ALL) do
      for i=1,GetCategoryNumAchievements(cat) do
        id = GetAchievementInfo(cat, i)
        if (findCriteria(id, pattern)) then
          found[#found+1] = id
          anyFound = true
        end
      end
    end
  end
  if (anyFound) then
    if (results ~= found) then
      results = results and wipe(results) or {}
      copytab(found, results)
    end
    return results
  end
end

local multifound

local function AchSearch_multiple(list, pattern, results, ...)
  found = found or {}
  multifound = multifound and wipe(multifound) or {}
  local anyFound, argnum, foundB
  for i=1, select("#", ...) do
    argnum = select(i, ...)
    foundB = AchSearch(true, list, argnum, pattern, nil, true, found)
    if (foundB) then  -- Theoretically faster than checking if #(found) < 1.
      for _,id in ipairs(found) do
        multifound[id] = true  -- With this method, we won't get duplicate IDs.
      end
      anyFound = true
    end
  end
  foundB = AchSearch_Criteria(list, pattern, found)
  if (foundB) then
    for _,id in ipairs(found) do
      multifound[id] = true
    end
    anyFound = true
  end
  if (anyFound) then
    results = results and wipe(results) or {}
    for id in pairs(multifound) do  -- pairs, not ipairs
      results[#results+1] = id
    end
    return results
  end
end


local VARS
local frame, panel, sortdrop
local EditAny, EditName, EditDesc, EditCriteria, EditReward
local SubmitBtn, ResetBtn, ResultsLabel
local FullListCheckbox

local function SortDrop_OnSelect(self, value)
  VARS.SearchSort = value
  frame.sort = value
  frame:ForceUpdate(true)
end

local function FullList_OnClick(self)
  if (self:GetChecked()) then
    PlaySound("igMainMenuOptionCheckBoxOn");
    VARS.SearchFullList = true
  else
    PlaySound("igMainMenuOptionCheckBoxOff");
    VARS.SearchFullList = false
  end
end

local function OnLoad(v)
  VARS = v
  sortdrop:SetSelectedValue(VARS.SearchSort or 0)
  if (VARS.SearchFullList) then  FullListCheckbox:SetChecked(1);  end
end

frame, panel = Overachiever.BuildNewTab("Overachiever_SearchFrame", L.SEARCH_TAB,
                 "Interface\\AddOns\\Overachiever_Tabs\\SearchWatermark", L.SEARCH_HELP, OnLoad)

sortdrop = TjDropDownMenu.CreateDropDown("Overachiever_SearchFrameSortDrop", panel, {
  {
    text = L.TAB_SORT_NAME,
    value = 0
  },
  {
    text = L.TAB_SORT_COMPLETE,
    value = 1
  },
  {
    text = L.TAB_SORT_POINTS,
    value = 2
  },
  {
    text = L.TAB_SORT_ID,
    value = 3
  };
})
sortdrop:SetLabel(L.TAB_SORT, true)
sortdrop:SetPoint("TOPLEFT", panel, "TOPLEFT", -16, -22)
sortdrop:OnSelect(SortDrop_OnSelect)

local function beginSearch()
  PlaySound("igMainMenuOptionCheckBoxOn")
  local name, desc, criteria, reward, any = EditName:GetText(), EditDesc:GetText(), EditCriteria:GetText(), EditReward:GetText(), EditAny:GetText()
  if (name == "" and desc == "" and criteria == "" and reward == "" and any == "") then  -- all fields are blank
    ResultsLabel:Hide()
    return;
  end
  local list = VARS.SearchFullList and Overachiever.GetAllAchievements() or nil
  local results = frame.AchList
  if (reward ~= "") then  -- Rewards first since there are few of these so it may narrow the list fastest
    list = AchSearch(true, list, 11, reward, nil, true, results) or 0
  end
  if (list ~= 0 and name ~= "") then
    list = AchSearch(true, list, 2, name, nil, true, results) or 0
  end
  if (list ~= 0 and desc ~= "") then
    list = AchSearch(true, list, 8, desc, nil, true, results) or 0
  end
  if (list ~= 0 and criteria ~= "") then
    list = AchSearch_Criteria(list, criteria, results) or 0
  end
  if (list ~= 0 and any ~= "") then
    list = AchSearch_multiple(list, any, results, 11, 2, 8) or 0
  end
  if (list == 0 or not list) then  wipe(results);  end
  Overachiever_SearchFrameContainerScrollBar:SetValue(0)
  frame:ForceUpdate(true)
  ResultsLabel:Show()
end

function frame.SetNumListed(num)
  ResultsLabel:SetText(L.SEARCH_RESULTS:format(num))
end

local EditBoxes = {}

local function tabPressed(self)
  self:SetAutoFocus(false)
  EditBox_HandleTabbing(self, EditBoxes)
end

local function escapeEditBox(self)
  self:SetAutoFocus(false)
end

local function focusEditBox(self)
  for i,editbox in ipairs(EditBoxes) do
    _G[editbox]:SetAutoFocus(false)
  end
  self:SetAutoFocus(true)
end

local function createEditBox(name, labeltext, obj, x, y)
  name = "Overachiever_SearchFrame"..name.."Edit"
  local editbox = CreateFrame("EditBox", name, panel, "InputBoxTemplate")
  editbox:SetAutoFocus(false)
  editbox:SetWidth(170); editbox:SetHeight(16)
  editbox:SetPoint("TOPLEFT", obj, "BOTTOMLEFT", x or 0, y or -23)
  local label = editbox:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  label:SetPoint("BOTTOMLEFT", editbox, "TOPLEFT", -6, 4)
  label:SetText(labeltext)
  editbox:SetScript("OnTabPressed", tabPressed)
  editbox:SetScript("OnEnterPressed", beginSearch)
  editbox:HookScript("OnEscapePressed", escapeEditBox)
  editbox:HookScript("OnEditFocusGained", focusEditBox)
  EditBoxes[#EditBoxes+1] = name  -- We use the name rather than a frame because names are used by EditBox_HandleTabbing.
  return editbox
end

EditName = createEditBox("Name", L.SEARCH_NAME, sortdrop, 22, -19)
EditDesc = createEditBox("Desc", L.SEARCH_DESC, EditName)
EditCriteria = createEditBox("Criteria", L.SEARCH_CRITERIA, EditDesc)
EditReward = createEditBox("Reward", L.SEARCH_REWARD, EditCriteria)
EditAny = createEditBox("Any", L.SEARCH_ANY, EditReward)

FullListCheckbox = CreateFrame("CheckButton", "Overachiever_SearchFrameFullListCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
FullListCheckbox:SetPoint("TOPLEFT", EditAny, "BOTTOMLEFT", -8, -12)
Overachiever_SearchFrameFullListCheckboxText:SetText(L.SEARCH_FULLLIST)
FullListCheckbox:SetHitRectInsets(0, -1 * min(Overachiever_SearchFrameFullListCheckboxText:GetWidth() + 8, 155), 0, 0)
FullListCheckbox:SetScript("OnClick", FullList_OnClick)
FullListCheckbox:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
  GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
  GameTooltip:SetText(L.SEARCH_FULLLIST_TIP, nil, nil, nil, nil, 1)
end)
FullListCheckbox:SetScript("OnLeave", GameTooltip_Hide)

local function resetEditBoxes()
  PlaySound("igMainMenuOptionCheckBoxOff")
  for i,editbox in ipairs(EditBoxes) do
    _G[editbox]:SetText("")
  end
end

SubmitBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
SubmitBtn:SetWidth(75); SubmitBtn:SetHeight(21)
SubmitBtn:SetPoint("TOPLEFT", FullListCheckbox, "BOTTOMLEFT", 2, -8)
SubmitBtn:SetText(L.SEARCH_SUBMIT)
SubmitBtn:SetScript("OnClick", beginSearch)

ResetBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
ResetBtn:SetWidth(75); ResetBtn:SetHeight(21)
ResetBtn:SetPoint("LEFT", SubmitBtn, "RIGHT", 4, 0)
ResetBtn:SetText(L.SEARCH_RESET)
ResetBtn:SetScript("OnClick", resetEditBoxes)

ResultsLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ResultsLabel:SetPoint("TOPLEFT", SubmitBtn, "BOTTOMLEFT", 0, -8)
ResultsLabel:Hide()


--[[
function Overachiever.Debug_GetIDRange()
  local gap, i, id, firstid, lastid = 0, 0
  repeat
    i = i + 1
    firstid = GetAchievementInfo(i)
    assert(i < 1000)
  until (firstid)
  repeat
    i = i + 1
    id = GetAchievementInfo(i)
    if (id) then  gap, lastid = 0, id;  else  gap = gap + 1;  end
  until (gap > 1000)
  print("ID range: {", firstid, ",", lastid, "}")
end
-- Last check: WoW 3.2: { 6 , 4316 }
--]]
