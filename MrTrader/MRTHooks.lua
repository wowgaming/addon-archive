-------------------------------------------------------------------------------
-- MrTrader
--
-- Suite of tools for the avid crafter.
--
-- Send suggestions, comments, and bugs to user@zedonline.net
-------------------------------------------------------------------------------

-- Singleton (With AceHook embedded)
MRTHooks = LibStub("AceHook-3.0");

function MRTHooks:OnEnable()
	self:RawHook("TradeSkillFrame_LoadUI", nil, true);
	MrTrader:RegisterEvent("TRADE_SKILL_SHOW", MRTHooks_TradeSkillFrame_Show);
end

function MRTHooks:OnDisable()
	self:Unhook("TradeSkillFrame_LoadUI");
	if( self.hooks["TradeSkillFrame_Show"] ) then
		self:Unhook("TradeSkillFrame_Show");
	end
end

function MRTHooks_TradeSkillFrame_Show()
	-- OnDemand load the appropriate moddule and show it.
	-- If MrTrader_SkillWindow cannot be loaded, or has been disabled, go with the default of the original.
	if( MrTrader:ShouldUseCustomWindow() and LoadAddOn("MrTrader_SkillWindow") ) then
		-- Load and Call
		MRTSkillWindow:Show();
	else
		-- Hook, and Call Original		
		MRTHooks:HookTradeSkillFrameShow();
		if( MRTHooks.hooks["TradeSkillFrame_Show"] ~= nil ) then
			MRTHooks.hooks["TradeSkillFrame_Show"]();
		else
			MrTrader:Output("Cannot load any tradeskill plugins.");
		end
	end
end

function MRTHooks:HookTradeSkillFrameShow()
	if( TradeSkillFrame_Show ~= nil and
		TradeSkillFrame_Show ~= MRTHooks_TradeSkillFrame_Show and
		self.hooks["TradeSkillFrame_Show"] == nil ) then
		self:RawHook("TradeSkillFrame_Show", MRTHooks_TradeSkillFrame_Show, true);
	end
end

function MRTHooks:TradeSkillFrame_LoadUI()
	-- Load the Blizzard UI and hook it.
	MRTHooks.hooks["TradeSkillFrame_LoadUI"]();
	self:HookTradeSkillFrameShow();
end