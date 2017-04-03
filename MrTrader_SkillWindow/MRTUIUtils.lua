-------------------------------------------------------------------------------
-- MrTrader 
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

function MRTUIUtils_FilterButton_SetType(button, type, text, isLast)
	local normalText = _G[button:GetName().."NormalText"];
	local normalTexture = _G[button:GetName().."NormalTexture"];
	local line = _G[button:GetName().."Lines"];
	
	line:Hide();
	if ( type == "class" ) then
		button:SetText(text);
		normalText:SetPoint("LEFT", button, "LEFT", 4, 0);
		normalTexture:SetAlpha(1.0);	
	elseif ( type == "subclass" ) then
		button:SetText(HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE);
		normalText:SetPoint("LEFT", button, "LEFT", 12, 0);
		normalTexture:SetAlpha(0.4);
	end
	button.type = type; 
end

-----
-- Methods to let addons get at the state of 'have materials' for the tradeskill window.
-----
function MRTUIUtils_GetTradeSkillOnlyShowMakeable()
	return MRTSkillFrameAvailableFilterCheckButton:GetChecked();
end

function MRTUIUtils_SetTradeSkillOnlyShowMakeable(value)
	MRTSkillFrameAvailableFilterCheckButton:SetChecked(value);
	TradeSkillOnlyShowMakeable(MRTSkillFrameAvailableFilterCheckButton:GetChecked());
end


