function Talented:OpenGlyphFrame()
	TalentedGlyphs:Update()
	TalentedGlyphs:Show()
end

function Talented:ToggleGlyphFrame()
	if not TalentedGlyphs then
		self:OpenGlyphFrame()
	elseif TalentedGlyphs:IsShown() then
		TalentedGlyphs:Hide()
	else
		TalentedGlyphs:Show()
	end
end

Talented.USE_GLYPH =  Talented.OpenGlyphFrame

StaticPopupDialogs["CONFIRM_REMOVE_GLYPH"].OnAccept = function(self)
	if TalentedGlyphs and TalentedGlyphs.group == GetActiveTalentGroup() then
		RemoveGlyphFromSocket(self.data)
	end
end
