local Talented = Talented

local entered
local function handler(self)
	if not entered then
		entered = true
		self:LoadAddOn"Talented_GlyphFrame"
		return self:OpenGlyphFrame()
	else
		Talented:Print("ERROR: Talented_GlyphFrame is not available. You must enable the addon to be able to open the glyph frame.")
		entered = nil
	end
end

Talented.OpenGlyphFrame = handler
Talented.ToggleGlyphFrame = handler
Talented.USE_GLYPH = handler
