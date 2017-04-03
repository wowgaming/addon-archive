-- X-Perl UnitFrames
-- Author: Zek <Boodhoof-EU>
-- License: GNU GPL v3, 29 June 2007 (see LICENSE.txt)

------------------
-- Some code pulled and modded from FrameXML/TutorualFrame.lua, but most re-used.
--
-- XPerl.lua has a dummy XPerl_Tutorial() function for when this addon not loaded
--
-- The XPerl_Tutorial class here has a metatable setup with a __call definition
-- so that it can be used like a function

local conf
XPerl_RequestConfig(function(new) conf = new end, "$Revision: 382 $")

XPerl_Tutorial = setmetatable({}, {__call = function(self, n) self:Start(n) end})
local xpTut = XPerl_Tutorial

-- XPerl_Tutorial:Reset()
function xpTut:Reset()
	if (conf) then
		conf.showTutorials = true
		conf.tutorialFlags = nil
	end
end

-- XPerl_Tutorial:Notified
function xpTut:Flagged(id)
	return conf and conf.tutorialFlags and strsub(conf.tutorialFlags, id, id) == "1"
end

-- xpTut:FlagTutorial(id)
function xpTut:FlagTutorial(id)
	if (not conf) then
		return
	end
	conf.tutorialFlags = string.sub((conf.tutorialFlags or "")..string.rep("0", id), 1, id - 1).."1"..string.sub((conf.tutorialFlags or ""), id + 1)
end

-- XPerl_Tutorial:Start
function xpTut:Start(id)
	if (id and conf.showTutorials and not self:Flagged(id)) then
		self:NewTutorial(id)
	end
end

-- XPerl_Tutorial:NewTutorial
function xpTut:NewTutorial(tutorialID)
	self:FlagTutorial(tutorialID)
	-- Get tutorial button
	local button = TutorialFrameAlertButton()
	-- Not enough tutorial buttons, not sure how to handle this right now
	if ( not button ) then
		return
	end
	tinsert(TUTORIALFRAME_QUEUE, {tutorialID, button:GetName()})

	if ( LAST_TUTORIAL_BUTTON_SHOWN and LAST_TUTORIAL_BUTTON_SHOWN ~= button ) then
		button:SetPoint("BOTTOM", LAST_TUTORIAL_BUTTON_SHOWN, "BOTTOM", 36, 0)
	else
		-- No button shown so this is the first one
		button:SetPoint("BOTTOM", "TutorialFrameParent", "BOTTOM", 0, 0)
	end
	button.id = tutorialID
	button.tooltip = XPerl_ShortProductName.." ".._G["XPERL_TUTORIAL_TITLE"..tutorialID]
	LAST_TUTORIAL_BUTTON_SHOWN = button
	button:Show()
	SetButtonPulse(button, 10, 0.5)

	button.XPerl_oldOnClick = button:GetScript("OnClick")
	button:SetScript("OnClick",
		function(self)
			TutorialFrame:Show()
			self:ClearAllPoints()
			self:Hide()
			XPerl_Tutorial:Update(self.id)
			self.id = nil
		end
	)
	button:SetScript("OnHide",
		function(self)
			if (self.XPerl_oldOnClick) then
				self:SetScript("OnClick", self.XPerl_oldOnClick)
				self.XPerl_oldOnClick = nil
			end
			self:SetScript("OnHide", nil)
		end
	)
end

hooksecurefunc("TutorialFrame_Update",
	function(currentTutorial)
		TutorialFrame.xpPerlFlag = nil
		TutorialFrameCheckButton:SetChecked(TutorialsEnabled())
	end
)

-- XPerl_Tutorial:Update(currentTutorial)
function xpTut:Update(currentTutorial)
	TutorialFrame.id = currentTutorial
	local title = XPerl_ShortProductName.." ".._G["XPERL_TUTORIAL_TITLE"..currentTutorial]
	local text = _G["XPERL_TUTORIAL"..currentTutorial]
	if ( title and text) then
		TutorialFrameTitle:SetText(title)
		TutorialFrameText:SetText(text)
	end
	TutorialFrame:SetHeight(TutorialFrameText:GetHeight() + 62)

	-- Remove the tutorial from the queue and reanchor the remaining buttons
	local index = 1
	while TUTORIALFRAME_QUEUE[index] do
		if ( currentTutorial == TUTORIALFRAME_QUEUE[index][1] ) then
			tremove(TUTORIALFRAME_QUEUE, index);
		end
		index = index + 1
	end
	-- Go through the queue and reanchor the buttons
	local button
	LAST_TUTORIAL_BUTTON_SHOWN = nil
	for index, value in pairs(TUTORIALFRAME_QUEUE) do
		button = _G[value[2]]
		if ( LAST_TUTORIAL_BUTTON_SHOWN and LAST_TUTORIAL_BUTTON_SHOWN ~= button ) then
			button:SetPoint("BOTTOM", LAST_TUTORIAL_BUTTON_SHOWN, "BOTTOM", 36, 0)
		else
			button:SetPoint("BOTTOM", "TutorialFrameParent", "BOTTOM", 0, 0)
		end
		LAST_TUTORIAL_BUTTON_SHOWN = button
	end

	local onHide = TutorialFrame:GetScript("OnHide")
	if (onHide ~= self.TutFrameOnHide) then
		TutorialFrame.XPerl_oldOnHide = onHide
		TutorialFrame:SetScript("OnHide", self.TutFrameOnHide)
	end

	TutorialFrameCheckButton:SetChecked(conf.showTutorials)
	TutorialFrame.xpPerlFlag = true
end

-- XPerl_Tutorial:TutFrameOnHide
function xpTut:TutFrameOnHide()

	if (self.XPerl_oldOnHide) then
		self:SetScript("OnHide", self.XPerl_oldOnHide)
		self.XPerl_oldOnHide = nil
	end

	PlaySound("igMainMenuClose")
	if (not TutorialFrameCheckButton:GetChecked()) then
		if (self.xpPerlFlag) then
			conf.showTutorials = nil
		else
			ClearTutorials()
		end

		-- Hide all tutorial buttons
		TutorialFrame_HideAllAlerts()
		return
	end

	self.xpPerlFlag = nil
end
