-- This is the editbox module from Chatter by Antiarc

if not Prat.BN_CHAT then return end -- Requires 3.3.5

Prat:AddModuleToLoad(function() 

local PRAT_MODULE = Prat:RequestModuleName("Editbox")

if PRAT_MODULE == nil then 
    return 
end

local L = Prat:GetLocalizer({})

--[===[@debug@
L:AddLocale("enUS", {
	["Editbox"] = true,
	["Editbox options."] = true,
	["Top"] = true,
	["Bottom"] = true,
	["Free-floating"] = true,
	["Free-floating, Locked"] = true,
	["Background texture"] = true,
	["Border texture"] = true,
	["Background color"] = true,
	["Border color"] = true,
	["Background Inset"] = true,
	["Tile Size"] = true,
	["Edge Size"] = true,
	["Attach to..."] = true,
	["Attach edit box to..."] = true,
	["Color border by channel"] = true,
	["Sets the frame's border color to the color of your currently active channel"] = true,
	["Use Alt key for cursor movement"] = true,
	["Requires the Alt key to be held down to move the cursor in chat"] = true,
	["Font"] = true,
	["Select the font to use for the edit box"] = true,
})
--@end-debug@]===]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
L:AddLocale("enUS", 
{
	["Attach edit box to..."] = true,
	["Attach to..."] = true,
	["Background color"] = true,
	["Background Inset"] = true,
	["Background texture"] = true,
	["Border color"] = true,
	["Border texture"] = true,
	Bottom = true,
	["Color border by channel"] = true,
	["Edge Size"] = true,
	Editbox = true,
	["Editbox options."] = true,
	Font = true,
	["Free-floating"] = true,
	["Free-floating, Locked"] = true,
	["Requires the Alt key to be held down to move the cursor in chat"] = true,
	["Select the font to use for the edit box"] = true,
	["Sets the frame's border color to the color of your currently active channel"] = true,
	["Tile Size"] = true,
	Top = true,
	["Use Alt key for cursor movement"] = true,
}

)
L:AddLocale("frFR",  
{
	-- ["Attach edit box to..."] = "",
	-- ["Attach to..."] = "",
	-- ["Background color"] = "",
	-- ["Background Inset"] = "",
	-- ["Background texture"] = "",
	-- ["Border color"] = "",
	-- ["Border texture"] = "",
	Bottom = "Bas",
	-- ["Color border by channel"] = "",
	-- ["Edge Size"] = "",
	Editbox = "Boite d'édition",
	["Editbox options."] = "Options de la boite d'édition",
	-- Font = "",
	-- ["Free-floating"] = "",
	-- ["Free-floating, Locked"] = "",
	-- ["Requires the Alt key to be held down to move the cursor in chat"] = "",
	-- ["Select the font to use for the edit box"] = "",
	-- ["Sets the frame's border color to the color of your currently active channel"] = "",
	-- ["Tile Size"] = "",
	Top = "Haut",
	-- ["Use Alt key for cursor movement"] = "",
}

)
L:AddLocale("deDE", 
{
	["Attach edit box to..."] = "Befestige Eingabefeld an ...",
	["Attach to..."] = "Befestige an ...",
	["Background color"] = "Hintergrundfarbe",
	["Background Inset"] = "Hintergrundbild",
	["Background texture"] = "Hintergrundtextur",
	["Border color"] = "Randfarbe",
	["Border texture"] = "Randtextur",
	Bottom = "Unten",
	["Color border by channel"] = "Rand einfärben nach Kanal",
	["Edge Size"] = "Kantengröße",
	Editbox = "Eingabefeld",
	["Editbox options."] = "Optionen für das Eingabefeld.",
	Font = "Schriftart",
	["Free-floating"] = "Freischwebend",
	["Free-floating, Locked"] = "Freischwebend, festgesetzt",
	["Requires the Alt key to be held down to move the cursor in chat"] = "Das Drücken der Alt-Taste wird benötigt, um den Cursor (Zeiger) im Chat zu bewegen.",
	["Select the font to use for the edit box"] = "Schriftart auswählen, die im Eingabefeld verwendet wird.",
	["Sets the frame's border color to the color of your currently active channel"] = "Wendet die Randfarbe des Rahmens auf die Farbe deines gegenwärtig aktiven Kanals an.",
	["Tile Size"] = "Kachelgröße",
	Top = "Oben",
	["Use Alt key for cursor movement"] = "Benutze Alt-Taste für Cursor-Bewegung",
}

)
L:AddLocale("koKR",  
{
	-- ["Attach edit box to..."] = "",
	-- ["Attach to..."] = "",
	["Background color"] = "배경 색상",
	-- ["Background Inset"] = "",
	["Background texture"] = "배경 텍스쳐",
	["Border color"] = "테두리 색상",
	["Border texture"] = "테두리 텍스쳐",
	Bottom = "아래",
	["Color border by channel"] = "채널 테두리 색상",
	["Edge Size"] = "모서리 크기",
	Editbox = "대화입력창",
	["Editbox options."] = "대화입력창을 설정합니다.",
	Font = "폰트",
	["Free-floating"] = "자유로운 이동",
	["Free-floating, Locked"] = "자유로운 이동, 잠금",
	["Requires the Alt key to be held down to move the cursor in chat"] = "대화 입력창 커서 이동에 Alt 키를 사용합니다",
	["Select the font to use for the edit box"] = "대화 입력창에 사용할 폰트 선택",
	["Sets the frame's border color to the color of your currently active channel"] = "대화 입력창 테두리 색상을 현재 채널 색상으로 설정",
	-- ["Tile Size"] = "",
	Top = "위",
	["Use Alt key for cursor movement"] = "커서 이동에 Alt 키 사용",
}

)
L:AddLocale("esMX",  
{
	-- ["Attach edit box to..."] = "",
	-- ["Attach to..."] = "",
	-- ["Background color"] = "",
	-- ["Background Inset"] = "",
	-- ["Background texture"] = "",
	-- ["Border color"] = "",
	-- ["Border texture"] = "",
	-- Bottom = "",
	-- ["Color border by channel"] = "",
	-- ["Edge Size"] = "",
	-- Editbox = "",
	-- ["Editbox options."] = "",
	-- Font = "",
	-- ["Free-floating"] = "",
	-- ["Free-floating, Locked"] = "",
	-- ["Requires the Alt key to be held down to move the cursor in chat"] = "",
	-- ["Select the font to use for the edit box"] = "",
	-- ["Sets the frame's border color to the color of your currently active channel"] = "",
	-- ["Tile Size"] = "",
	-- Top = "",
	-- ["Use Alt key for cursor movement"] = "",
}

)
L:AddLocale("ruRU",  
{
	["Attach edit box to..."] = "Закрепить поле ввода к...",
	["Attach to..."] = "Закрепить к...",
	["Background color"] = "Цвет фона",
	["Background Inset"] = "Фоновая врезка",
	["Background texture"] = "Текстура фона",
	["Border color"] = "Цвет границ",
	["Border texture"] = "Текстура границы",
	Bottom = "Внизу",
	["Color border by channel"] = "Окраска граници по цвету канала",
	["Edge Size"] = "Размер контура",
	Editbox = true,
	["Editbox options."] = "Настройки поле ввода.",
	Font = "Шрифт",
	["Free-floating"] = "Свободно",
	["Free-floating, Locked"] = "Свободно, заблокировано",
	["Requires the Alt key to be held down to move the cursor in chat"] = "Для перемещения курсора в чат требуется нажатая клавиша Alt",
	["Select the font to use for the edit box"] = "Выбор шрифта для области редактирования",
	["Sets the frame's border color to the color of your currently active channel"] = "Установить окраску границы в цвет вашего активного канала",
	["Tile Size"] = "Размер мозаики",
	Top = "Вверху",
	["Use Alt key for cursor movement"] = "Исп. кливишу Alt для перемещения курсора",
}

)
L:AddLocale("zhCN",  
{
	-- ["Attach edit box to..."] = "",
	-- ["Attach to..."] = "",
	-- ["Background color"] = "",
	-- ["Background Inset"] = "",
	-- ["Background texture"] = "",
	-- ["Border color"] = "",
	-- ["Border texture"] = "",
	Bottom = "底部",
	-- ["Color border by channel"] = "",
	-- ["Edge Size"] = "",
	Editbox = "输入框",
	["Editbox options."] = "输入框选项",
	-- Font = "",
	-- ["Free-floating"] = "",
	-- ["Free-floating, Locked"] = "",
	-- ["Requires the Alt key to be held down to move the cursor in chat"] = "",
	-- ["Select the font to use for the edit box"] = "",
	-- ["Sets the frame's border color to the color of your currently active channel"] = "",
	-- ["Tile Size"] = "",
	Top = "顶部",
	-- ["Use Alt key for cursor movement"] = "",
}

)
L:AddLocale("esES",  
{
	-- ["Attach edit box to..."] = "",
	-- ["Attach to..."] = "",
	-- ["Background color"] = "",
	-- ["Background Inset"] = "",
	-- ["Background texture"] = "",
	-- ["Border color"] = "",
	-- ["Border texture"] = "",
	Bottom = "Abajo",
	-- ["Color border by channel"] = "",
	-- ["Edge Size"] = "",
	Editbox = "Caja de edición",
	["Editbox options."] = "Opciones de la caja de edición.",
	-- Font = "",
	-- ["Free-floating"] = "",
	-- ["Free-floating, Locked"] = "",
	-- ["Requires the Alt key to be held down to move the cursor in chat"] = "",
	-- ["Select the font to use for the edit box"] = "",
	-- ["Sets the frame's border color to the color of your currently active channel"] = "",
	-- ["Tile Size"] = "",
	Top = "Arriba",
	-- ["Use Alt key for cursor movement"] = "",
}

)
L:AddLocale("zhTW",  
{
	-- ["Attach edit box to..."] = "",
	-- ["Attach to..."] = "",
	["Background color"] = "背景色彩",
	-- ["Background Inset"] = "",
	["Background texture"] = "背景材質",
	["Border color"] = "邊緣色彩",
	["Border texture"] = "邊緣材質",
	Bottom = "底部",
	-- ["Color border by channel"] = "",
	-- ["Edge Size"] = "",
	Editbox = "輸入框",
	["Editbox options."] = "輸入框選單",
	Font = "字型",
	-- ["Free-floating"] = "",
	-- ["Free-floating, Locked"] = "",
	-- ["Requires the Alt key to be held down to move the cursor in chat"] = "",
	-- ["Select the font to use for the edit box"] = "",
	-- ["Sets the frame's border color to the color of your currently active channel"] = "",
	-- ["Tile Size"] = "",
	Top = "頂部",
	-- ["Use Alt key for cursor movement"] = "",
}

)
--@end-non-debug@



local mod = Prat:NewModule(PRAT_MODULE, "AceHook-3.0")


local Media = Prat.Media
local backgrounds, borders, fonts = {}, {}, {}
local CreateFrame = _G.CreateFrame
local max = _G.max
local pairs = _G.pairs
local select = _G.select

local VALID_ATTACH_POINTS = {
	TOP = L["Top"],
	BOTTOM = L["Bottom"],
	FREE = L["Free-floating"],
	LOCK = L["Free-floating, Locked"]
}

local function updateEditBox(method, ...)
	for i = 1, NUM_CHAT_WINDOWS do
		local f = _G["ChatFrame" .. i .. "EditBox"]
		f[method](f, ...)
	end
--	for index,name in ipairs(mod.TempChatFrames) do
--		local cf = _G[name.."EditBox"]
--		if cf then
--			cf[method](f,args)
--		end
--	end
end

Prat:SetModuleOptions(mod, {
    name = L["Editbox"],
    desc = L["Editbox options."],
    type = "group",
    args = {
		background = {
			type = "select",
			name = L["Background texture"],
			desc = L["Background texture"],
			values = backgrounds,
			get = function() return mod.db.profile.background end,
			set = function(info, v)
				mod.db.profile.background = v
				mod:SetBackdrop()
			end
		},
		border = {
			type = "select",
			name = L["Border texture"],
			desc = L["Border texture"],
			values = borders,
			get = function() return mod.db.profile.border end,
			set = function(info, v)
				mod.db.profile.border = v
				mod:SetBackdrop()
			end
		},
		backgroundColor = {
			type = "color",
			name = L["Background color"],
			desc = L["Background color"],
			hasAlpha = true,
			get = function()
				local c = mod.db.profile.backgroundColor
				return c.r, c.g, c.b, c.a
			end,
			set = function(info, r, g, b, a)
				local c = mod.db.profile.backgroundColor
				c.r, c.g, c.b, c.a = r, g, b, a
				mod:SetBackdrop()
			end
		},
		borderColor = {
			type = "color",
			name = L["Border color"],
			desc = L["Border color"],
			hasAlpha = true,
			get = function()
				local c = mod.db.profile.borderColor
				return c.r, c.g, c.b, c.a
			end,
			set = function(info, r, g, b, a)
				local c = mod.db.profile.borderColor
				c.r, c.g, c.b, c.a = r, g, b, a
				mod:SetBackdrop()
			end
		},
		inset = {
			type = "range",
			name = L["Background Inset"],
			desc = L["Background Inset"],
			min = 1,
			max = 64,
			step = 1,
			bigStep = 1,
			get = function() return mod.db.profile.inset end,
			set = function(info, v)
				mod.db.profile.inset = v
				mod:SetBackdrop()
			end
		},
		tileSize = {
			type = "range",
			name = L["Tile Size"],
			desc = L["Tile Size"],
			min = 1,
			max = 64,
			step = 1,
			bigStep = 1,
			get = function() return mod.db.profile.tileSize end,
			set = function(info, v)
				mod.db.profile.tileSize = v
				mod:SetBackdrop()
			end
		},
		edgeSize = {
			type = "range",
			name = L["Edge Size"],
			desc = L["Edge Size"],
			min = 1,
			max = 64,
			step = 1,
			bigStep = 1,
			get = function() return mod.db.profile.edgeSize end,
			set = function(info, v)
				mod.db.profile.edgeSize = v
				mod:SetBackdrop()
			end
		},
		attach = {
			type = "select",
			name = L["Attach to..."],
			desc = L["Attach edit box to..."],
			get = function() return mod.db.profile.attach end,
			values = VALID_ATTACH_POINTS,
			set = function(info, v)
				mod.db.profile.attach = v
				mod:SetAttach()
			end
		},
		colorByChannel = {
			type = "toggle",
			name = L["Color border by channel"],
			desc = L["Sets the frame's border color to the color of your currently active channel"],
			get = function()
				return mod.db.profile.colorByChannel
			end,
			set = function(info, v)
				mod.db.profile.colorByChannel = v
				if v then
					mod:RawHook("ChatEdit_UpdateHeader", "SetBorderByChannel", true)
				else
					if mod:IsHooked("ChatEdit_UpdateHeader") then
						mod:Unhook("ChatEdit_UpdateHeader")
					local c = mod.db.profile.borderColor
					for _, frame in ipairs(self.frames) do
						frame:SetBackdropBorderColor(c.r, c.g, c.b, c.a)
					end
					end
				end
			end
		},
		useAltKey = {
			type = "toggle",
			name = L["Use Alt key for cursor movement"],
			desc = L["Requires the Alt key to be held down to move the cursor in chat"],
			get = function()
				return mod.db.profile.useAltKey
			end,
			set = function(info, v)
				mod.db.profile.useAltKey = v
			updateEditBox("SetAltArrowKeyMode", v)
			end
		},
		font = {
			type = "select",
			name = L["Font"],
			desc = L["Select the font to use for the edit box"],
			values = fonts,
			get = function() return mod.db.profile.font end,
			set = function(i, v)
				mod.db.profile.font = v
			for i = 1, NUM_CHAT_WINDOWS do
				local ff = _G["ChatFrame"..i.."EditBox"]
				local _, s, m = ff:GetFont()
				ff:SetFont(Media:Fetch("font", v), s, m)
			end
		end
	},
--	height = {
--		type = "range",
--		name = L["Height"],
--		desc = L["Select the height of the edit box"],
--		min = 5,
--		max = 50,
--		step = 1,
--		bigStep = 1,
--		get = function() return mod.db.profile.height end,
--		set = function(i, v)
--			mod.db.profile.height = v
--			mod:UpdateHeight()
--		end
--		}
	}
} )

Prat:SetModuleDefaults(mod.name, {
	profile = {
		on = true,
		background = "Blizzard Tooltip",
		border = "Blizzard Tooltip",
		hideDialog = true,
		backgroundColor = {r = 0, g = 0, b = 0, a = 1},
		borderColor = {r = 1, g = 1, b = 1, a = 1},
		inset = 3,
		edgeSize = 12,
		tileSize = 16,
		height = 22,
		attach = "BOTTOM",
		colorByChannel = true,
		useAltKey = false,
		font = (function()
			for i = 1, NUM_CHAT_WINDOWS do
				local ff = _G["ChatFrame"..i.."EditBox"]
				local f = ff:GetFont()
			for k,v in pairs(Media:HashTable("font")) do
				if v == f then return k end
				end
			end
		end)()
	}
} )


function mod:LibSharedMedia_Registered()
	for k, v in pairs(Media:List("background")) do
		backgrounds[v] = v
	end
	for k, v in pairs(Media:List("border")) do
		borders[v] = v
	end
	for k, v in pairs(Media:List("font")) do
		fonts[v] = v
	end
end

Prat:SetModuleInit(mod, 
	function(self)
		
	Media.RegisterCallback(mod, "LibSharedMedia_Registered")
	self.frames = {}	

	
	self:LibSharedMedia_Registered()
	
	
	for i = 1, NUM_CHAT_WINDOWS do
		local parent = _G["ChatFrame"..i.."EditBox"]


		local frame = CreateFrame("Frame", nil, parent)
		frame:SetFrameStrata("DIALOG")
		
		frame:SetFrameLevel(parent:GetFrameLevel() - 1)
		frame:SetAllPoints(parent)
		frame:Hide()
		
		parent.lDrag = CreateFrame("Frame", nil, parent)
		parent.lDrag:SetWidth(15)
		parent.lDrag:SetPoint("TOPLEFT", parent, "TOPLEFT")
		parent.lDrag:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT")
	
		parent.rDrag = CreateFrame("Frame", nil, parent)
		parent.rDrag:SetWidth(15)
		parent.rDrag:SetPoint("TOPRIGHT", parent, "TOPRIGHT")
		parent.rDrag:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT")
		parent.lDrag.left = true
		parent.frame = frame
		tinsert(self.frames, frame)
	end
end )
		
--function mod:Decorate(chatframe)
-- -- prevent duplicate creation
--	for index,f in ipairs(self.frames) do
--		if f.owner == chatframe then
--			return nil
--		end
--	end
--	local parent = _G[chatframe:GetName().."EditBox"]
--	local frame = CreateFrame("Frame", nil, parent)
--	frame:SetFrameStrata("DIALOG")
--	frame:SetFrameLevel(parent:GetFrameLevel() - 1)
--	frame:SetAllPoints(parent)
--	frame.owner = chatframe
--	frame:Hide()
--	parent.lDrag = CreateFrame("Frame", nil, parent)
--	parent.lDrag:SetWidth(15)
--	parent.lDrag:SetPoint("TOPLEFT", parent, "TOPLEFT")
--	parent.lDrag:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT")
--	parent.rDrag = CreateFrame("Frame", nil, parent)
--	parent.rDrag:SetWidth(15)
--	parent.rDrag:SetPoint("TOPRIGHT", parent, "TOPRIGHT")
--	parent.rDrag:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT")
--	parent.lDrag.left = true
--	parent.frame = frame
--	tinsert(self.frames, frame)
--	local name = chatframe:GetName()
--	local f = _G[name.."EditBox"]
--	_G[name.."EditBoxLeft"]:Hide()
--	_G[name.."EditBoxRight"]:Hide()
--	_G[name.."EditBoxMid"]:Hide()
--	_G[name.."EditBoxFocusLeft"]:SetTexture(nil)
--	_G[name.."EditBoxFocusRight"]:SetTexture(nil)
--	_G[name.."EditBoxFocusMid"]:SetTexture(nil)
--	f:Hide()
--	self.frames[#self.frames]:Show()
--	local font, s, m = f:GetFont()
--	f:SetFont(Media:Fetch("font", self.db.profile.font), s, m)
--	local header = _G[f:GetName().."Header"]
--	local font, s, m = header:GetFont()
--	header:SetFont(Media:Fetch("font", self.db.profile.font), s, m)
--		
--	self:SetAttach(f, self.db.profile.editX, self.db.profile.editY, self.db.profile.editW)
--end

function mod:OnEnable()
	self:LibSharedMedia_Registered()

	for i = 1, NUM_CHAT_WINDOWS do
		local f = _G["ChatFrame"..i.."EditBox"]
		_G["ChatFrame"..i.."EditBoxLeft"]:Hide()
		_G["ChatFrame"..i.."EditBoxRight"]:Hide()
		_G["ChatFrame"..i.."EditBoxMid"]:Hide()
		_G["ChatFrame"..i.."EditBoxFocusLeft"]:SetTexture(nil)
		_G["ChatFrame"..i.."EditBoxFocusRight"]:SetTexture(nil)
		_G["ChatFrame"..i.."EditBoxFocusMid"]:SetTexture(nil)
		f:Hide()

        -- Prevent an error in FloatingChatFrame FCF_FadeOutChatFrame() (blizz bug)
		f:SetAlpha(f:GetAlpha() or 0)
		
		self.frames[i]:Show()
		local font, s, m = f:GetFont()
		f:SetFont(Media:Fetch("font", self.db.profile.font), s, m)		
		
		local header = _G[f:GetName().."Header"]
    	local font, s, m = header:GetFont()
    	header:SetFont(Media:Fetch("font", self.db.profile.font), s, m)			
	end
	updateEditBox("SetAltArrowKeyMode", mod.db.profile.useAltKey and 1 or nil)

--	for index,name in ipairs(self.TempChatFrames) do
--		local f = _G[name.."EditBox"]
--		_G[name.."EditBoxLeft"]:Hide()
--		_G[name.."EditBoxRight"]:Hide()
--		_G[name.."EditBoxMid"]:Hide()
--		_G[name.."EditBoxFocusLeft"]:SetTexture(nil)
--		_G[name.."EditBoxFocusRight"]:SetTexture(nil)
--		_G[name.."EditBoxFocusMid"]:SetTexture(nil)
--		f:Hide()
--		self.frames[NUM_CHAT_WINDOWS+index]:Show()
--		local font, s, m = f:GetFont()
--		f:SetFont(Media:Fetch("font", self.db.profile.font), s, m)
--	self:SetAttach(nil, self.db.profile.editX, self.db.profile.editY, self.db.profile.editW)
--	end
	
	self:SetAttach(nil, self.db.profile.editX, self.db.profile.editY, self.db.profile.editW)
	self:SecureHook("ChatEdit_DeactivateChat")
	self:SecureHook("ChatEdit_SetLastActiveWindow")
	
	self:SetBackdrop()
	self:UpdateHeight()
	if self.db.profile.colorByChannel then
		self:RawHook("ChatEdit_UpdateHeader", "SetBorderByChannel", true)
	end
	self:SecureHook("FCF_Tab_OnClick")
end
function mod:FCF_Tab_OnClick(frame,button)
	if self.db.profile.attach == "TOP" and GetCVar("chatStyle") ~= "classic" then
		local chatFrame = _G["ChatFrame"..frame:GetID()];
		ChatEdit_DeactivateChat(chatFrame.editBox)
	end
end

function mod:OnDisable()
	for i = 1, NUM_CHAT_WINDOWS do
		local f = _G["ChatFrame"..i.."EditBox"]
		_G["ChatFrame"..i.."EditBoxLeft"]:Show()
		_G["ChatFrame"..i.."EditBoxRight"]:Show()
		_G["ChatFrame"..i.."EditBoxMid"]:Show()
		f:SetAltArrowKeyMode(true)
		f:EnableMouse(true)
		f.frame:Hide()
		self:SetAttach("BOTTOM")
		--f:SetFont(Media:Fetch("font", defaults.profile.font), 14)
	end
--	for index,name in ipairs(self.TempChatFrames) do
--		local f = _G[name.."EditBox"]
--		_G[name.."EditBoxLeft"]:Show()
--		_G[name.."EditBoxRight"]:Show()
--		_G[name.."EditBoxMid"]:Show()
--		f:SetAltArrowKeyMode(true)
--		f:EnableMouse(true)
--		f.frame:Hide()
--	self:SetAttach("BOTTOM")
--		f:SetFont(Media:Fetch("font", defaults.profile.font), 14)
--	end
end

-- changed the Hide to SetAlpha(0), the new ChatSystem OnHide handlers go though some looping
-- when in IM style and Classic style, cause heavy delays on the chat edit box.
function mod:ChatEdit_SetLastActiveWindow(frame)
	if self.db.profile.hideDialog and frame:IsShown() then
		frame:SetAlpha(0)
	else
		frame:SetAlpha(1)
	end
	frame:EnableMouse(true)
end
function mod:ChatEdit_DeactivateChat(frame)
	if self.db.profile.hideDialog and frame:IsShown() then
		frame:SetAlpha(0)
		frame:EnableMouse(false)
	end
end
function mod:GetOptions()
	return options
end

function mod:SetBackdrop()
	for _, frame in ipairs(self.frames) do
		frame:SetBackdrop({
		bgFile = Media:Fetch("background", self.db.profile.background),
		edgeFile = Media:Fetch("border", self.db.profile.border),
		tile = true,
		tileSize = self.db.profile.tileSize,
		edgeSize = self.db.profile.edgeSize,
		insets = {left = self.db.profile.inset, right = self.db.profile.inset, top = self.db.profile.inset, bottom = self.db.profile.inset}
	})
	local c = self.db.profile.backgroundColor
		frame:SetBackdropColor(c.r, c.g, c.b, c.a)
	
	local c = self.db.profile.borderColor
		frame:SetBackdropBorderColor(c.r, c.g, c.b, c.a)
	end
end

function mod:SetBorderByChannel(...)
	self.hooks.ChatEdit_UpdateHeader(...)
	for index, frame in ipairs(self.frames) do
		local f = _G["ChatFrame"..index.."EditBox"]
		local attr = f:GetAttribute("chatType")
	if attr == "CHANNEL" then
			local chan = f:GetAttribute("channelTarget")
		if chan == 0 then
			local c = self.db.profile.borderColor
				frame:SetBackdropBorderColor(c.r, c.g, c.b, c.a)
		else	
			local r, g, b = GetMessageTypeColor("CHANNEL" .. chan)
				frame:SetBackdropBorderColor(r, g, b, 1)
		end
	else
		local r, g, b = GetMessageTypeColor(attr)
			frame:SetBackdropBorderColor(r, g, b, 1)
		end
	end
end

do
	local function startMoving(self)
		self:StartMoving()
	end

	local function stopMoving(self)
		self:StopMovingOrSizing()
		mod.db.profile.editX = self:GetLeft()
		mod.db.profile.editY = self:GetTop()
		mod.db.profile.editW = self:GetRight() - self:GetLeft()
	end

	local cfHeight
	local function constrainHeight(self)
		self:GetParent():SetHeight(cfHeight)
	end
	
	local function startDragging(self)
		cfHeight = self:GetParent():GetHeight()
		self:GetParent():StartSizing(not self.left and "TOPRIGHT" or "TOPLEFT")
		self:SetScript("OnUpdate", constrainHeight)
	end
	
	local function stopDragging(self)
		local parent = self:GetParent()
		parent:StopMovingOrSizing()
		self:SetScript("OnUpdate", nil)
		mod.db.profile.editX = parent:GetLeft()
		mod.db.profile.editY = parent:GetTop()
		mod.db.profile.editW = parent:GetWidth()	
	end

	function mod:SetAttach(val, x, y, w)
		for i = 1, NUM_CHAT_WINDOWS do 
			local frame = _G["ChatFrame" .. i .. "EditBox"]
		local val = val or self.db.profile.attach
		if not x and val == "FREE" then
				if self.db.profile.editX and self.db.profile.editY then
					x, y, w = self.db.profile.editX, self.db.profile.editY, self.db.profile.editW
				else
				x, y, w = frame:GetLeft(), frame:GetTop(), max(frame:GetWidth(), (frame:GetRight() or 0) - (frame:GetLeft() or 0))
			end
		end
		if not w or w < 10 then w = 100 end
			frame:ClearAllPoints()
		if val ~= "FREE" then
				frame:SetMovable(false)
				frame.lDrag:EnableMouse(false)
				frame.rDrag:EnableMouse(false)
				frame:SetScript("OnMouseDown", nil)
				frame:SetScript("OnMouseUp", nil)
				frame.lDrag:EnableMouse(false)
				frame.rDrag:EnableMouse(false)			
				frame.lDrag:SetScript("OnMouseDown", nil)
				frame.rDrag:SetScript("OnMouseDown", nil)
				frame.lDrag:SetScript("OnMouseUp", nil)
				frame.rDrag:SetScript("OnMouseUp", nil)
		end
		
		if val == "TOP" then
				frame:SetPoint("BOTTOMLEFT", frame.chatFrame, "TOPLEFT", 0, 3)
				frame:SetPoint("BOTTOMRIGHT", frame.chatFrame, "TOPRIGHT", 0, 3)
		elseif val == "BOTTOM" then			
				frame:SetPoint("TOPLEFT", frame.chatFrame, "BOTTOMLEFT", 0, -8)
				frame:SetPoint("TOPRIGHT", frame.chatFrame, "BOTTOMRIGHT", 0, -8)
		elseif val == "FREE" then
				frame:EnableMouse(true)
				frame:SetMovable(true)
				frame:SetResizable(true)
				frame:SetScript("OnMouseDown", startMoving)
				frame:SetScript("OnMouseUp", stopMoving)
				frame:SetWidth(w)
				frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
				frame:SetMinResize(40, 1)
			
				frame.lDrag:EnableMouse(true)
				frame.rDrag:EnableMouse(true)
			
				frame.lDrag:SetScript("OnMouseDown", startDragging)
				frame.rDrag:SetScript("OnMouseDown", startDragging)

				frame.lDrag:SetScript("OnMouseUp", stopDragging)
				frame.rDrag:SetScript("OnMouseUp", stopDragging)
			elseif val == "LOCK" then
				frame:SetWidth(self.db.profile.editW or w)
				frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.profile.editX or x, self.db.profile.editY or y)
			end
		end
--		for index,name in ipairs(self.TempChatFrames) do
--			local frame = _G[name .. "EditBox"]
--			local val = val or self.db.profile.attach
--			if not x and val == "FREE" then
--				x, y, w = frame:GetLeft(), frame:GetTop(), max(frame:GetWidth(), (frame:GetRight() or 0) - (frame:GetLeft() or 0))
--			end
--			if not w or w < 10 then w = 100 end
--			frame:ClearAllPoints()
--			if val ~= "FREE" then
--				frame:SetMovable(false)
--				frame.lDrag:EnableMouse(false)
--				frame.rDrag:EnableMouse(false)
--				frame:SetScript("OnMouseDown", nil)
--				frame:SetScript("OnMouseUp", nil)
--				frame.lDrag:EnableMouse(false)
--				frame.rDrag:EnableMouse(false)
--				frame.lDrag:SetScript("OnMouseDown", nil)
--				frame.rDrag:SetScript("OnMouseDown", nil)
--				frame.lDrag:SetScript("OnMouseUp", nil)
--				frame.rDrag:SetScript("OnMouseUp", nil)
--			end
--			if val == "TOP" then
--				frame:SetPoint("BOTTOMLEFT", frame.chatFrame, "TOPLEFT", 0, 3)
--				frame:SetPoint("BOTTOMRIGHT", frame.chatFrame, "TOPRIGHT", 0, 3)
--			elseif val == "BOTTOM" then
--				frame:SetPoint("TOPLEFT", frame.chatFrame, "BOTTOMLEFT", 0, -8)
--				frame:SetPoint("TOPRIGHT", frame.chatFrame, "BOTTOMRIGHT", 0, -8)
--			elseif val == "FREE" then
--				frame:EnableMouse(true)
--				frame:SetMovable(true)
--				frame:SetResizable(true)
--				frame:SetScript("OnMouseDown", startMoving)
--				frame:SetScript("OnMouseUp", stopMoving)
--				frame:SetWidth(w)
--				frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
--				frame:SetMinResize(40, 1)
--				frame.lDrag:EnableMouse(true)
--				frame.rDrag:EnableMouse(true)
--				frame.lDrag:SetScript("OnMouseDown", startDragging)
--				frame.rDrag:SetScript("OnMouseDown", startDragging)
--				frame.lDrag:SetScript("OnMouseUp", stopDragging)
--				frame.rDrag:SetScript("OnMouseUp", stopDragging)
--		elseif val == "LOCK" then
--				frame:SetWidth(self.db.profile.editW or w)
--				frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.profile.editX or x, self.db.profile.editY or y)
--			end
--		end
	end
end
function mod:UpdateHeight()
	for i = 1, NUM_CHAT_WINDOWS do
		local ff = _G["ChatFrame"..i.."EditBox"]
		ff:SetHeight(mod.db.profile.height)
	end
--	for index,name in ipairs(self.TempChatFrames) do
--		local ff = _G[name.."EditBox"]
--		ff:SetHeight(mod.db.profile.height)
--	end
end

  return
end ) -- Prat:AddModuleToLoad
