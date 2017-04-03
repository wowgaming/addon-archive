local MAJOR = "LibQTipClick-1.1"
local MINOR =  3
assert(LibStub, MAJOR.." requires LibStub")

local lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end -- No upgrade needed

local QTip = LibStub:GetLibrary("LibQTip-1.0")
assert(QTip, MAJOR.." requires LibQTip-1.0")

local CBH = LibStub:GetLibrary("CallbackHandler-1.0")
assert(CBH, MAJOR.." requires CallbackHandler-1.0")

-------------------------------------------------------------------------------
-- Local variables
-------------------------------------------------------------------------------
lib.LabelProvider, lib.LabelPrototype, lib.BaseProvider = QTip:CreateCellProvider(QTip.LabelProvider)
local cell_provider, cell_prototype, cell_base = lib.LabelProvider, lib.LabelPrototype, lib.BaseProvider

-------------------------------------------------------------------------------
-- Public library API
-------------------------------------------------------------------------------
local highlighter = CreateFrame("Frame", nil, UIParent)
highlighter:SetFrameStrata("TOOLTIP")
highlighter:Hide()

local cell_highlight = highlighter:CreateTexture(nil, "OVERLAY")
cell_highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
cell_highlight:SetBlendMode("ADD")
cell_highlight:SetAllPoints(highlighter)

function lib.OnEnter(event, cell, arg)
	highlighter:SetAllPoints(cell)
	highlighter:SetFrameLevel(cell:GetFrameLevel())
	highlighter:Show()
end

function lib.OnLeave(event, cell, arg)
	highlighter:ClearAllPoints()
	highlighter:Hide()
end

function lib.OnMouseDown(event, cell, arg, button) PlaySound("igMainMenuOpen") end
function lib.OnMouseUp(event, cell, arg, button)  end

local function Cell_OnEnter(cell) cell.callbacks:Fire("OnEnter", cell, cell.arg) end
local function Cell_OnLeave(cell) cell.callbacks:Fire("OnLeave", cell, cell.arg) end
local function Cell_OnMouseDown(cell, button) cell.callbacks:Fire("OnMouseDown", cell, cell.arg, button) end
local function Cell_OnMouseUp(cell, button) cell.callbacks:Fire("OnMouseUp", cell, cell.arg, button) end

function cell_prototype:InitializeCell() cell_base.InitializeCell(self) end

function cell_prototype:SetupCell(tooltip, value, justification, font, arg, ...)
	local width, height = cell_base.SetupCell(self, tooltip, value, justification, font, ...)
	self:EnableMouse(true)
	self.arg = arg
	self.callbacks = tooltip.callbacks
	self:SetScript("OnEnter", Cell_OnEnter)
	self:SetScript("OnLeave", Cell_OnLeave)
	self:SetScript("OnMouseDown", Cell_OnMouseDown)
	self:SetScript("OnMouseUp", Cell_OnMouseUp)

	return width, height
end

function cell_prototype:ReleaseCell()
	self:EnableMouse(false)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnMouseDown", nil)
	self:SetScript("OnMouseUp", nil)
	self.arg = nil
	self.callbacks = nil
end

-------------------------------------------------------------------------------
-- LibQTip wrapper API
-------------------------------------------------------------------------------
local function AddNormalLine(tooltip, ...)
	local oldProvider = tooltip:GetDefaultProvider()
	tooltip:SetDefaultProvider(QTip.LabelProvider)
	local lineNum, colNum = tooltip:AddLine(...)
	tooltip:SetDefaultProvider(oldProvider)
	return lineNum, colNum
end

local function AddNormalHeader(tooltip, ...)
	local oldProvider = tooltip:GetDefaultProvider()
	tooltip:SetDefaultProvider(QTip.LabelProvider)
	local lineNum, colNum = tooltip:AddHeader(...)
	tooltip:SetDefaultProvider(oldProvider)
	return lineNum, colNum
end

local function SetNormalCell(tooltip, ...)
	local oldProvider = tooltip:GetDefaultProvider()
	tooltip:SetDefaultProvider(QTip.LabelProvider)
	local lineNum, colNum = tooltip:SetCell(...)
	tooltip:SetDefaultProvider(oldProvider)
	return lineNum, colNum
end

function lib:Acquire(key, ...)
	local tooltip = QTip:Acquire(key, ...)
	tooltip:EnableMouse(true)

	tooltip.callbacks = CBH:New(tooltip, "SetCallback", "UnSetCallback", "UnSetAllCallbacks" or false)
	tooltip:SetCallback("OnEnter", self.OnEnter)
	tooltip:SetCallback("OnLeave", self.OnLeave)
	tooltip:SetCallback("OnMouseDown", self.OnMouseDown)
	tooltip:SetCallback("OnMouseUp", self.OnMouseUp)

	tooltip.AddNormalLine = AddNormalLine
	tooltip.AddNormalHeader = AddNormalHeader
	tooltip.SetNormalCell = SetNormalCell
	tooltip:SetDefaultProvider(cell_provider)
	return tooltip
end

function lib:IsAcquired(key) return QTip:IsAcquired(key) end

function lib:Release(tooltip)
	if not tooltip then return end
	tooltip:EnableMouse(false)
	tooltip:UnSetAllCallbacks(tooltip)
	tooltip.callbacks = nil
	tooltip["SetCallback"] = nil
	tooltip["UnSetCallback"] = nil
	tooltip["UnSetAllCallbacks"] = nil
	QTip:Release(tooltip)
end

function lib:IterateTooltips() return QTip:IterateTooltips() end
function lib:CreateCellProvider(baseProvider) return QTip:CreateCellProvider(baseProvider) end
