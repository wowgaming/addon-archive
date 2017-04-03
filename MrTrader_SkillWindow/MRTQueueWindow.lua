-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

MRTQueueWindow = {};

-- MRTRADER_TRADE_SKILL_HEIGHT = 16;

UIPanelWindows["MRTQueueFrame"] =	{ area = "left", pushable = 4 };

function MRTQueueWindow:Show()
	ShowUIPanel(MRTQueueFrame);
end

function MRTQueueWindow:Close()
	HideUIPanel(MRTQueueFrame);
end