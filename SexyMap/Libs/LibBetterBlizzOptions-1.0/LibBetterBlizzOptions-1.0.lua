local MAJOR, MINOR = "LibBetterBlizzOptions-1.0", 1
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

local function makeMovable(frame)
	local mover = _G[frame:GetName() .. "Mover"] or CreateFrame("Frame", frame:GetName() .. "Mover", frame)
	mover:EnableMouse(true)
	mover:SetPoint("TOP", frame, "TOP", 0, 10)
	mover:SetWidth(160)
	mover:SetHeight(40)
	mover:SetScript("OnMouseDown", function(self)
		self:GetParent():StartMoving()
	end)
	mover:SetScript("OnMouseUp", function(self)
		self:GetParent():StopMovingOrSizing()
	end)
	frame:SetMovable(true)
	frame:ClearAllPoints()
	frame:SetPoint("CENTER")
end

local freeButtons = {
    [InterfaceOptionsFrameCategories] = {},
    [InterfaceOptionsFrameAddOns] = {},
}
local function updateScrollHeight(categoryFrame)
    local buttons = categoryFrame.buttons
    local numButtons = #buttons
    local maxButtons = (categoryFrame:GetTop() - categoryFrame:GetBottom() - 8) / categoryFrame.buttonHeight
    local name = categoryFrame:GetName()

    if numButtons < maxButtons then
        for i = numButtons + 1, maxButtons do
            local button
            if freeButtons[categoryFrame][i] then
                button = freeButtons[categoryFrame][i]
            else
                button = _G[name .. "Button" .. i] or CreateFrame("BUTTON", name .. "Button" .. i, categoryFrame, "InterfaceOptionsListButtonTemplate")
                button:SetPoint("TOPLEFT", buttons[#buttons], "BOTTOMLEFT")
            end
            local listwidth = InterfaceOptionsFrameAddOnsList:GetWidth()
            if InterfaceOptionsFrameAddOnsList:IsShown() then
                button:SetWidth(button:GetWidth() - listwidth)
            end
            tinsert(buttons, button)
            categoryFrame.update()
        end
    else
        for i = numButtons, maxButtons, -1 do
            local button = tremove(buttons, i)
            button:Hide()
            local listwidth = InterfaceOptionsFrameAddOnsList:GetWidth()
            if InterfaceOptionsFrameAddOnsList:IsShown() then
                button:SetWidth(button:GetWidth() + listwidth)
            end
            freeButtons[categoryFrame][i] = button
            categoryFrame.update()
        end
    end
end

local grip = _G.BetterBlizzOptionsResizeGrip or CreateFrame("Frame", "BetterBlizzOptionsResizeGrip", InterfaceOptionsFrame)
grip:EnableMouse(true)
local tex = grip.tex or grip:CreateTexture(grip:GetName() .. "Grip")
grip.tex = tex
tex:SetTexture([[Interface\BUTTONS\UI-AutoCastableOverlay]])
tex:SetTexCoord(0.619, 0.760, 0.612, 0.762)
tex:SetDesaturated(true)
tex:ClearAllPoints()
tex:SetPoint("TOPLEFT")
tex:SetPoint("BOTTOMRIGHT", grip, "TOPLEFT", 12, -12)

-- Deal with BBO base installs
if grip.SetNormalTexture then
	grip:SetNormalTexture(nil)
	grip:SetHighlightTexture(nil)
end
-- tex:SetAllPoints()

grip:SetWidth(22)
grip:SetHeight(21)
grip:SetScript("OnMouseDown", function(self)
	self:GetParent():StartSizing()
end)
grip:SetScript("OnMouseUp", function(self)
	self:GetParent():StopMovingOrSizing()
	updateScrollHeight(InterfaceOptionsFrameCategories)
	updateScrollHeight(InterfaceOptionsFrameAddOns)
end)
grip:SetScript("OnEvent", function(self)
	updateScrollHeight(InterfaceOptionsFrameCategories)
	updateScrollHeight(InterfaceOptionsFrameAddOns)
	makeMovable(InterfaceOptionsFrame)
	makeMovable(ChatConfigFrame)
	makeMovable(AudioOptionsFrame)
	makeMovable(GameMenuFrame)
	makeMovable(VideoOptionsFrame)
	if MacOptionsFrame then
	   makeMovable(MacOptionsFrame)
	end	
end)
if not grip:IsEventRegistered("PLAYER_LOGIN") then
	grip:RegisterEvent("PLAYER_LOGIN")
end

grip:ClearAllPoints()
grip:SetPoint("BOTTOMRIGHT")
grip:SetScript("OnEnter", function(self)
	self.tex:SetDesaturated(false)
end)
grip:SetScript("OnLeave", function(self)
	self.tex:SetDesaturated(true)
end)

InterfaceOptionsFrame:SetPoint("CENTER", UIParent, "CENTER")

InterfaceOptionsFrameCategories:SetPoint("BOTTOMLEFT", InterfaceOptionsFrame, "BOTTOMLEFT", 22, 50)
InterfaceOptionsFrameAddOns:SetPoint("BOTTOMLEFT", InterfaceOptionsFrame, "BOTTOMLEFT", 22, 50)

if not InterfaceOptionsFrameAddOns:IsMouseWheelEnabled() then
	InterfaceOptionsFrameAddOns:EnableMouseWheel(true)
	InterfaceOptionsFrameAddOns:SetScript("OnMouseWheel", function(self, dir)
		InterfaceOptionsFrameAddOnsListScrollBar:SetValue(
			InterfaceOptionsFrameAddOnsListScrollBar:GetValue() - (dir * 18)
		)
	end)
end

InterfaceOptionsFrame:SetFrameStrata("FULLSCREEN_DIALOG")
InterfaceOptionsFrame:SetResizable(true)
InterfaceOptionsFrame:SetWidth(900)
InterfaceOptionsFrame:SetMinResize(585, 495)
InterfaceOptionsFrame:SetToplevel(true)