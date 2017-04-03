tinsert(Prat.EnableTasks, function(self) 
	-- register formatting with WIM.
	if(_G.WIM and _G.WIM.RegisterMessageFormatting) then
	   _G.WIM.RegisterMessageFormatting("Prat", function(smf, event, ...) return Prat.Format(smf, event, _G.WIM.nextColor, ...) end )
	end
end )


Prat:AddModuleExtension(function() 
	local module = Prat.Addon:GetModule("CopyChat", true)	
	if not module then return end
	
    local orgOME = module.OnModuleEnable
	function module:OnModuleEnable(...) 
		orgOME(self, ...)
    	if WIM then
			WIM.RegisterWidgetTrigger("chat_display", "whisper,chat,w2w,demo", "OnHyperlinkClick", function(...) self:ChatFrame_OnHyperlinkShow(...) end);
		end
	end

  return
end ) -- Prat:AddModuleExtension