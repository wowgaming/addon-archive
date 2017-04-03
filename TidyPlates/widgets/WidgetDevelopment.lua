
--[[
* Widgets
	TidyPlatesWidgets. table
	AddWidget("Type", ...) where ... is the parameters
	So, using...  TidyPlatesWidgets:AddWidget("ThreatWheel"), would check to make sure the widget exists
	Each widget should use the .Update() method for updating, as standard practice
	Widgets should accept the UnitInfo table, and work automatically
	Widgets should only need init, placement, and update calls
	- Threat Wheel (Unit, Time) (ShowName)
	- Threat Line (Unit, Time) (ShowName)
	- Text Widget (Text)
	- Mana Widget (Percent)
	- Buff Widget (Buff,Time) (ShowTimerBar)
	- Combo Point Widget (Number)
	- "Behind" Widget
	- Incoming Heal Widget (Requires Healcomm)
	- Current Target Widget
	- Selection Widget
	- Class Icon
	
	-- Update Artwork Paths


--]]

---------------
-- Mana Widget
---------------

local MANA_COLOR = {r = 1, g = .67, b = .14}

local function UpdateManaLine(frame, unitid)
	if unitid then
		local mana = UnitMana(unitid)	
		local manamax = UnitManaMax(unitid)		
		if mana and mana > 0 then
			-- Set Size
			frame.Line:SetWidth(.9 * (mana/manamax))
			-- Set Fading
			frame:Show()
			frame.FadeTime = GetTime() + 3
			frame:SetScript("OnUpdate", SetFade)
		else frame:Hide() end
	elseif (GetTime() > frame.FadeTime) or (not InCombatLockdown()) then frame:Hide() end
end
local manapath = path.."\\Art\\ThreatLine\\"
local function CreateManaLine(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(100)
	frame:SetHeight(24)
	-- Threat Center
	frame.Left = frame:CreateTexture(nil, "OVERLAY")
	frame.Left:SetTexture(manapath.."LeftDot")
	frame.Left:SetPoint("CENTER", frame, "LEFT")
	frame.Left:SetWidth(32)
	frame.Left:SetHeight(32)
	-- Threat Dot
	frame.Right = frame:CreateTexture(nil, "OVERLAY")
	frame.Right:SetTexture(manapath.."RightDot")
	frame.Right:SetPoint("CENTER", frame.Line, "RIGHT")
	frame.Right:SetWidth(32)
	frame.Right:SetHeight(32)
	-- Threat Line
	frame.Line = frame:CreateTexture(nil, "OVERLAY")
	frame.Line:SetTexture(manapath.."Threatline")
	frame.Line:SetPoint("LEFT", frame)
	frame.Line:SetWidth(32)
	frame.Line:SetHeight(32)
	-- Target Text
	frame.TargetText = frame:CreateFontString(nil, "OVERLAY")
	frame.TargetText:SetFont(threatfont, 9, "NONE")
	frame.TargetText:SetPoint("BOTTOM",frame.Dot,"TOP", 0, -15)
	frame.TargetText:SetWidth(50)
	frame.TargetText:SetHeight(20)
	-- Set Colors
	frame.Right:SetVertexColor(MANA_COLOR.r, MANA_COLOR.g, MANA_COLOR.b)
	frame.Line:SetVertexColor(MANA_COLOR.r, MANA_COLOR.g, MANA_COLOR.b)
	frame.Left:SetVertexColor(MANA_COLOR.r, MANA_COLOR.g, MANA_COLOR.b)
	-- Mechanics/Setup
	frame.FadeTime = 0
	frame:Hide()
	frame.UpdateMana = UpdateManaLine
	return frame
end
