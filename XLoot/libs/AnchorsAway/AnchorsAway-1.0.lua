--[[
Name: AnchorsAway-1.0
Revision:
Author: Xuerian (sky.shell@gmail.com)
Website: none
Documentation: none
SVN: 
Description: Row stacking and anchoring template
Dependencies: AceLibrary, AceEvent-2.0, AceLocale-2.2
]]

local vmajor, vminor = "AnchorsAway-1.0", "$Revision: 45 $"

if not AceLibrary then error(vmajor .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(vmajor, vminor) then return end
if not AceLibrary:HasInstance("AceEvent-2.0") then error(vmajor .. " requires AceEvent-2.0") end
if not AceLibrary:HasInstance("AceLocale-2.2") then error(vmajor .. " requires AceLocale-2.2") end

-------------------------------------------
-------       Localization         ----------
-------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AnchorsAway")

L:RegisterTranslations("enUS", function()
	return {
		catGrowth = "Row growth",
		catPosSelf = "Anchor point...",
		catPosTarget = "To...",
		catPosOffset = "Offset frame...",
				
		optPositioning = "Positioning",
		optLock = "Lock",
		optAnchor = "Show Anchor",
		optPosVert = "Vertically",
		optPosHoriz = "Horizontally",
		optTimeout = "Timeout",
		optThreshold = "Stack Threshold",
		
		descPositioning = "Position and attachment of rows in the stack",
		descAnchor = "Show anchor for this stack",
		descPosVert = "Offset the row vertically from the point you choose to anchor it to by a specific amount",
		descPosHoriz = "Offset the row horizontally from the point you choose to anchor it to by a specific amount",
		descTimeout = "Time before each row fades. |cFFFF5522Setting this to 0 disables timed fading entirely",
		descDirection = "Direction stacks grow",
		descThreshold = "Maximum number of rows displayed at any given time",
		
		optPos = {
			TOPLEFT = "Top left corner",
			TOP = "Top edge",
			TOPRIGHT = "Top right corner",
			RIGHT = "Right edge",
			BOTTOMRIGHT = "Bottom right corner",
			BOTTOM = "Bottom edge",
			BOTTOMLEFT = "Bottom left corner",
			LEFT = "Left edge"
		},
	}
end)

L:RegisterTranslations("frFR", function()
	return {
		catGrowth = "Orientation des lignes",
		catPosSelf = "Point d'ancrage...",
		catPosTarget = "Vers...",
		catPosOffset = "D\195\169calage de la fen\195\170tre...",
					
		optPositioning = "Positionnement",
		optAnchor = "Afficher l'ancrage",
		optPosVert = "Verticalement",
		optPosHoriz = "Horizontalement",
		optTimeout = "Dur\195\169 d'affichage",
		optThreshold = "Nombre de ligne affich\195\169",
		
		descPositioning = "Position de chaque ligne",
		descAnchor = "Afficher l'ancrage pour cette ligne",
		descPosVert = "D\195\169cale la ligne verticalement depuis le point que vous avez choisie d'ancrer du nombre sp\195\169cifi\195\169",
		descPosHoriz = "D\195\169cale la ligne horizontalement depuis le point que vous avez choisie d'ancrer du nombre sp\195\169cifi\195\169",
		descTimeout = "Dur\195\169 avant disparition des lignes. |cFFFF5522A 0, d\195\169sactive la disparition compl\195\168tement",
		descDirection = "Direction de l'affichage des lignes de loot",
		descThreshold = "Nombre maximum de lignes affich\195\169 simultan\195\169ment",
		
		optPos = {
			TOPLEFT = "Coin sup\195\169rieur gauche",
			TOP = "Bord sup\195\169rieur",
			TOPRIGHT = "Coin sup\195\169rieur droit",
			RIGHT = "Bord droit",
			BOTTOMRIGHT = "Coin inf\195\169rieur droit",
			BOTTOM = "Bord infr\195\169rieur",
			BOTTOMLEFT = "Coin inf\195\169rieur gauche",
			LEFT = "Bord gauche"
		},
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		catGrowth = "延伸方向",
		catPosSelf = "定位点...",
		catPosTarget = "到...",
		catPosOffset = "偏移框架...",
				
		optPositioning = "定点",
		optLock = "锁定",
		optAnchor = "显示定位点",--锚点
		optPosVert = "垂直",
		optPosHoriz = "水平",
		optTimeout = "渐隐时间",
		optThreshold = "堆叠数目",
		
		descPositioning = "指定列在堆叠的定位",
		descAnchor = "显示此堆叠的定位点",
		descPosVert = "指定列从定位点的相对垂直偏移",
		descPosHoriz = "指定列从定位点的相对水平偏移",
		descTimeout = "每列渐隐至消失的时间. |cFFFF5522设置为0可取消渐隐显示特效",
		descDirection = "堆叠延伸的方向",
		descThreshold = "最大可同时显示的列数",
		
		optPos = {
			TOPLEFT = "左上角",
			TOP = "上部",
			TOPRIGHT = "右上角",
			RIGHT = "右部",
			BOTTOMRIGHT = "右下角",
			BOTTOM = "底部",
			BOTTOMLEFT = "左下角",
			LEFT = "左部"
		},
	}
end)

L:RegisterTranslations("zhTW", function()
	return {
		catGrowth = "拓展方向",
		catPosSelf = "錨點...",
		catPosTarget = "至...",
		catPosOffset = "位移框架...",
				
		optPositioning = "定位",
		optLock = "鎖定",
		optAnchor = "顯示錨點",
		optPosVert = "垂直",
		optPosHoriz = "水平",
		optTimeout = "漸隱時間",
		optThreshold = "堆疊數目",
		
		descPositioning = "指定列在堆疊的定位",
		descAnchor = "顯示這個堆疊的錨點",
		descPosVert = "指定列相對於錨點的垂直位移",
		descPosHoriz = "指定列相對於錨點的水平位移",
		descTimeout = "每列漸隱至消失的時間。|cFFFF5522設為0可取消漸隱顯示|r",
		descDirection = "堆疊拓展的方向",
		descThreshold = "最大可同時顯示的列數",
		
		optPos = {
			TOPLEFT = "左上",
			TOP = "上",
			TOPRIGHT = "右上",
			RIGHT = "右",
			BOTTOMRIGHT = "右下",
			BOTTOM = "下",
			BOTTOMLEFT = "左下",
			LEFT = "左",
		},
	}
end)

L:RegisterTranslations("esES", function()
	return {
		catGrowth = "Crecimiento de filas",
		catPosSelf = "Punto de anclaje...",
		catPosTarget = "En...",
		catPosOffset = "Desplazamiento de la ventana...",
				
		optPositioning = "Posicionamiento",
		optLock = "Bloquear",
		optAnchor = "Mostrar Ancla",
		optPosVert = "Verticalmente",
		optPosHoriz = "Horizontalmente",
		optTimeout = "Temporizador",
		optThreshold = "Límite del lote",
		
		descPositioning = "Posición y ajustes de las filas en el lote",
		descAnchor = "Muestra el ancla para este lote",
		descPosVert = "Desplaza la fila verticalmente en la cantidad especificada desde el punto en el que elijas anclarla",
		descPosHoriz = "Desplaza la fila horizontalmente en la cantidad especificada desde el punto en el que elijas anclarla",
		descTimeout = "Tiempo hasta que cada fila se desvanece. |cFFFF5522Si estableces esto a 0 desactivarás el desvanecimiento",
		descDirection = "Dirección hacia la que las filas crecen",
		descThreshold = "Cantidad máxima de filas a mostrar",
		
		optPos = {
			TOPLEFT = "Esquina Superior Izquierda",
			TOP = "Arriba",
			TOPRIGHT = "Esquina Superior Derecha",
			RIGHT = "Derecha",
			BOTTOMRIGHT = "Esquina Inferior Derecha",
			BOTTOM = "Abajo",
			BOTTOMLEFT = "Esquina Inferior Izquierda",
			LEFT = "Izquierda"
		},
	}
end)

L:RegisterTranslations("ruRU", function()
	return {
		catGrowth = "Рост ряда",
		catPosSelf = "Место якоря...",
		catPosTarget = "В...",
		catPosOffset = "Смещение фрейма...",
				
		optPositioning = "Расположение",
		optLock = "Закрепить",
		optAnchor = "Показать якорь",
		optPosVert = "Вертикально",
		optPosHoriz = "Горизонтально",
		optTimeout = "Простой",
		optThreshold = "Предел стопки",
		
		descPositioning = "Позиция и приклепление рядов в стопке",
		descAnchor = "Отображать якорь для данного набора",
		descPosVert = "Смещение ряда по вертикали от места якоря",
		descPosHoriz = "Смещение ряда по горизонтали от места якоря",
		descTimeout = "Время перед затуханием ряда. |cFFFF5522Установив значение на 0 вы полностью отключите время затухания",
		descDirection = "Направление роста стопки",
		descThreshold = "Максимально число отображаемых рядов",
		
		optPos = {
			TOPLEFT = "Верхний левый угол",
			TOP = "Сверху",
			TOPRIGHT = "Верхний правый угол",
			RIGHT = "Справо",
			BOTTOMRIGHT = "Нижний правый угол",
			BOTTOM = "Снизу",
			BOTTOMLEFT = "Нижний левый угол",
			LEFT = "Слево"
		},
	}
end)

-------------------------------------------
-------         Definition         ----------
-------------------------------------------

local AnchorsAway = { }

AceLibrary("AceEvent-2.0"):embed(AnchorsAway)

function AnchorsAway:NewStack(stackname, icon, db, index, mode)
	db.AnchorsAway = db.AnchorsAway or {}
	if not db.AnchorsAway[stackname] then
		db.AnchorsAway[stackname] = {}
	end
	local stackdb = db.AnchorsAway[stackname]
	local defaults =  { lock = false, anchor = true, attach = { self = "TOPLEFT", target = "BOTTOMLEFT", x = 0, y = 0 }, scale = 1, timeout = 15, threshold = 6, pos = {} }
	for k, v in pairs(defaults) do
		if stackdb[k] == nil then stackdb[k] = v end
	end
	if not self.stacks then self.stacks = { } end
	self.stacks[stackname] =  { 
				rows = {}, 
				rowstack = {}, 
				built = 0,
				shown = 0,
				index = index or 'key',
				db = stackdb,
				dismissable = true,
				detachable = false,
				mode = mode or 'insert',
				icon = icon
			}
	return self.stacks[stackname]
end

function AnchorsAway:Restack(stack, sortkey)
	sortkey = sortkey or stack.index
	for k, v in pairs(stack.rowstack) do
		v:ClearAllPoints()
		if stack.mode == 'insert' and ( not v:IsVisible() or not v.active ) then
			table.remove(stack.rowstack, k)
		end
	end
	for k, v in iteratetable(stack.rowstack, stack.mode ~= 'add' and sortkey or nil) do
		self:StackRow(stack, stack.rowstack[k], k == 1 and stack.frame or stack.rowstack[k-1]) 
		stack:SizeRow(stack, v)
		v:SetScale(stack.db.scale)
	end
	stack.frame:SetScale(stack.db.scale)
end

function AnchorsAway:StackRow(stack, row, target, xoff, yoff)
	row:ClearAllPoints()
	row:SetPoint(stack.db.attach.self, target, stack.db.attach.target, xoff and xoff + stack.db.attach.x or stack.db.attach.x, yoff and yoff + stack.db.attach.y or stack.db.attach.y)
end

function AnchorsAway:AcquireRow(stack)
	local nextkey = table.getn(stack.rowstack) + 1
	stack.shown = stack.shown +1
	local id
	for k, v in iteratetable(stack.rows) do
		if not v.active then
			id = k
			break
		end
	end
	if not id then
		id = table.getn(stack.rows) + 1
		stack:BuildRow(stack, id)
	end
	stack.rows[id].active = true
	stack.rows[id]:SetScale(stack.db.scale)
	return stack.rows[id], id
end

function AnchorsAway:AddRow(stack)
	local row, id = self:AcquireRow(stack)
	local rowstack = stack.rowstack
	local db = stack.db
	
	if not rowstack[id] then
		rowstack[id] = row
		self:StackRow(stack, rowstack[id], id-1 > 0 and rowstack[id-1] or stack.frame)
	end
	
	row:Show()
	UIFrameFadeIn(row, 0.5, 0, 1)
	return row
end

function AnchorsAway:PushRow(stack)
	local row, id = self:AcquireRow(stack)
	local db = stack.db
	
	table.insert(stack.rowstack, 1, row)
	
	if stack.rowstack[2] and stack.rowstack[2] ~= stack.rowstack[1] then
		self:StackRow(stack, stack.rowstack[2], stack.rowstack[1])
	elseif stack.rowstack[2] then
		return nil
	end
	self:StackRow(stack, stack.rowstack[1], stack.frame)
		
	row:Show()

	if stack.shown > db.threshold then
		self:PopRow(stack, nil, nil, db.threshold+1)
	end
	
	UIFrameFadeIn(row, 0.5, 0, 1)
	if db.timeout > 0 then
		row.event = self:ScheduleEvent(tostring(id), self.PopRow, db.timeout, self, stack, id, true)
	end
	row.key = self.uid
	self.uid = self.uid + 1
	return row
end

function AnchorsAway:PopRow(stack, id, event, stackid, time, func)
	if not id then
		id = stack.rowstack[stackid].id
	end
	
	if stack.rows[id].event and not event then 
		self:CancelScheduledEvent(stack.rows[id].event)
	end
	
	UIFrameFadeIn(stack.rows[id], time or 1, 1, 0)
	stack.rows[id].fadeInfo.finishedFunc = function() self:RemoveRow(stack, stack.rows[id]) if func then func(row) end end
end

function AnchorsAway:RemoveRow(stack, row)
	stack.shown = stack.shown -1
	self:ClearRow(stack, row.id)
	row:Hide()
	if stack.mode ~= 'add' then
		for k,v in ipairs(stack.rowstack) do 
			if v == row then
				row:ClearAllPoints()
				table.remove(stack.rowstack, k)
				if stack.mode == 'insert' then
					self:Restack(stack)
				end
				break
			end
		end
	end
end

function AnchorsAway:ClearRow(stack, id)
	local row = stack.rows[id]
	if row.event then
		self:CancelScheduledEvent(row.event)
	end
	row.active = false
	if stack.clear then stack.clear(row) end
end

function AnchorsAway:DragStart(stack, culprit) 
	if not stack.db.lock then 
		stack.frame:StartMoving() 
		if culprit then
			culprit.dragging = true
		end
	end
end

function AnchorsAway:DragStop(stack, culprit)
	stack.frame:StopMovingOrSizing()
	if culprit then
		culprit.dragging = false
	end
	if not stack.db.lock then 
		stack.db.pos = { x = stack.frame:GetLeft(), y = stack.frame:GetTop() }
	end
end 

function AnchorsAway:OnRowHide(stack, culprit)
	if culprit.dragging then
		self:DragStop(stack, culprit)
	end
end

function AnchorsAway:NewAnchor(stackname, anchorname, icon, db, dewdrop, index, mode)
	local stack = self:NewStack(stackname, icon, db, index, mode)
	stack.frame = CreateFrame("Frame", "AnchorsAway_"..stackname.."_Anchor", UIParent)
	stack.frame.anchortext = stack.frame:CreateFontString("AnchorsAway_"..stackname.."_AnchorText", "ARTWORK", "GameFontNormal")
	stack.frame:SetMovable(1)
	stack.frame:SetScale(stack.db.scale)
	
	stack.frame:RegisterForDrag("LeftButton")
	stack.frame:SetScript("OnDragStart", function() self:DragStart(stack) end)
	stack.frame:SetScript("OnDragStop", function() self:DragStop(stack) end)

	local anchor = anchorname or stackname
		
	stack.frame.anchortext:ClearAllPoints()
	stack.frame.anchortext:SetAllPoints(stack.frame)
	stack.frame.anchortext:SetJustifyH("CENTER")
	stack.frame.anchortext:SetJustifyV("MIDDLE")
	stack.frame.anchortext:SetText("|cAAAAAAAA"..anchor)
	stack.frame:SetWidth(150)
	stack.frame:SetHeight(20)

	stack.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", stack.db.pos.x or GetScreenWidth()/2, stack.db.pos.y or GetScreenWidth()/2) 	
	
	stack.frame:SetBackdrop({r = 0, g = 0, b = 0, a = 0.9})
	stack.frame:SetBackdropBorderColor(.5, .5, .5, 1)
	
	stack.name = stackname
	stack.anchorname = anchorname
	stack.dewdrop = dewdrop

	if dewdrop then
		stack.opts = self:Opts(stack)
		dewdrop:Register(stack.frame, 'children', function() dewdrop:FeedAceOptionsTable({ type = "group", args = stack.opts}) end, 'cursorX', true, 'cursorY', true)
	end

	stack.frame:Show()
	if stack.db.anchor then
		stack.frame:EnableMouse(1)
		UIFrameFadeIn(stack.frame, 0.5, 0, 1)
	else
		stack.frame:EnableMouse(0)
		stack.frame:SetAlpha(0)
	end
	return stack
end

local hcolor = "|cFF77BBFF"
local specialmenu = "|cFF44EE66"

function AnchorsAway:Opts(stack)
	if stack.opts then return stack.opts end
	local db = stack.db
	local skeleton = {
					header = {
						type = "header",
						icon = stack.icon,
						iconWidth = 24,
						iconHeight = 24,
						name = hcolor..stack.anchorname,
						order = 1					
					},
					anchor = {
						type = "toggle",
						name = L["optAnchor"],
						desc = L["optAnchor"],
						set = function()
							db.anchor = not db.anchor
							stack.frame:EnableMouse(db.anchor)
							if db.anchor then
								if stack.frame:GetAlpha() < 1 then
									UIFrameFadeIn(stack.frame, 0.5, 0, 1)
								end
							elseif stack.frame:GetAlpha() > 0 then
								UIFrameFadeIn(stack.frame, 0.5, 1, 0)
							end
						end,
						get = function() return db.anchor end,
						order = 2,
					},
					lock = {
						type = "toggle",
						name = L["optLock"],
						desc = L["optLock"],
						get = function()
							return db.lock
							end,
						set = function(v)
							db.lock = v
							end,
						order = 4
					},
					spacer = {
						type = "header",
						order = 6
					},
					positioning = {
						type = "group",
						name = L["optPositioning"],
						desc = L["descPositioning"],
						args = {
							offset = {
								type = "header",
								name = hcolor..L["catPosOffset"],
								order = 1
							},
							horiz = {
								type = "range",
								icon = "Interface\\Buttons\\UI-SliderBar-Button-Vertical",
								iconHeight = 24,
								iconWidth = 24,
								name = L["optPosHoriz"],
								desc = L["descPosHoriz"],
								get = function()
									return db.attach.x
									end,
								set = function(v)
									db.attach.x = v
									end,
								min = -20,
								max = 20,
								step = 1,
								order = 2
							},
							vert = {
								type = "range",
								name = L["optPosVert"],
								icon = "Interface\\Buttons\\UI-SliderBar-Button-Horizontal",
								iconHeight = 24,
								iconWidth = 24,
								desc = L["descPosVert"],
								get = function()
									return db.attach.y
									end,
								set = function(v)
									db.attach.y = v
									end,
								min = -20,
								max = 20,
								step = 1,
								order = 3
							},
							spacer = {
								type = "header",
								order = 5
							},
							self = {
								type = "header",
								name = hcolor..L["catPosSelf"],
								order = 10
							},
							spacer2 = {
								type = "header",
								order = 20
							},
							target = {
								type = "header",
								name = hcolor..L["catPosTarget"],
								order = 30
							},
						},
						order = 8
					},
					timeout = {
						type = "range",
						name = L["optTimeout"],
						desc = L["descTimeout"],
						get = function()
							return db.timeout
							end,
						set = function(v)
							db.timeout = v
							end,
						min = 0,
						max = 200,
						step = 5,
						order = 12
					},
					threshold = {
						type = "range",
						name = L["optThreshold"],
						desc = L["descThreshold"],
						get = function()
							return db.threshold
							end,
						set = function(v)
							db.threshold = v
							end,
						min = 1,
						max = 40,
						step = 1,
						order = 14
					},
					scale = {
						type = "range",
						name = UI_SCALE,
						desc = UI_SCALE,
						get = function()
							return db.scale
							end,
						set = function(v)
							db.scale = v
							self:Restack(stack)
							end,
						min = 0.5,
						max = 1.5,
						step = 0.05,
						order = 16
					}
				}
		local selfattach = self:AttachMenu(11, stack, "self")
		local targetattach = self:AttachMenu(31, stack, "target")
		for k, v in pairs(selfattach) do
			skeleton.positioning.args["self"..v.point] = v
		end
		for k, v in pairs(targetattach) do
			skeleton.positioning.args["target"..v.point] = v
		end
		return skeleton
end

function AnchorsAway:AttachMenu(offset, stack, point)
	local points = { "TOPLEFT", "TOP", "TOPRIGHT", "RIGHT", "BOTTOMRIGHT", "BOTTOM", "BOTTOMLEFT", "LEFT" }
	local toggles = { }
	for key, val in pairs(points) do
		local tempval = val
		local tmp = { 
					type = "toggle", 
					name =L["optPos"][tempval], 
					desc = L["optPos"][tempval], 
					isRadio = true,
					checked = variable == tempval,
					set = function(v)
						variable = tempval; 
						stack.db.attach[point] = tempval
						if stack.dewdrop then stack.dewdrop:Refresh(2) end
						self:Restack(stack)
						end,
					get = function()
							return stack.db.attach[point] == tempval
						end,
					point = tempval,
					order = offset + key - 1,
					}
		table.insert(toggles, tmp)
	end
	return toggles
end

local function activate(self, oldLib, oldDeactivate)
	self.stacks = oldLib and oldLib.stacks or {}
	self.uid = oldLib and oldLib.uid or 1
end


-- Spread the voodoo. Thanks to ckk.
do
	local mySort = function(a, b)
		if not a then
			return false
		end
		if not b then
			return true
		end
		
		if type(a) == "string" then
			return string.upper(a) < string.upper(b)
		else
			return a < b
		end
	end

	local mySort_reverse = function(a, b)
		if not b then
			return false
		end
		if not a then
			return true
		end
		
		if type(a) == "string" then
			return string.upper(a) > string.upper(b)
		else
			return a > b
		end
	end

	local current
	local sorts = setmetatable({}, {__index=function(self, sortBy)
		local x = function(a, b)
			if not a or not b then
				return false
			elseif type(current[a][sortBy]) == "string" then
				return string.upper(current[a][sortBy]) < string.upper(current[b][sortBy])
			else
				return current[a][sortBy] < current[b][sortBy]
			end
		end
		self[sortBy] = x
		return x
	end})
	local sorts_reverse = setmetatable({}, {__index=function(self, sortBy)
		local x = function(a, b)
			if not a or not b then
				return false
			elseif type(current[a][sortBy]) == "string" then
				return string.upper(current[a][sortBy]) > string.upper(current[b][sortBy])
			else
				return current[a][sortBy] > current[b][sortBy]
			end
		end
		self[sortBy] = x
		return x
	end})

	local iters; iters = setmetatable({}, {__index=function(self, t)
		local q; q = function(tab)
			local position = t['#'] + 1
			
			local x = t[position]
			if not x then
				for k in pairs(t) do
					t[k] = nil
				end
				iters[t] = q
				return
			end
			
			t['#'] = position
			
			return x, tab[x]
		end
		return q
	end, __mode='k'})

	function iteratetable(tab, key, reverse)
		local t = next(iters) or {}
		local iter = iters[t]
		iters[t] = nil
		for k, v in pairs(tab) do
			table.insert(t, k)
		end
		
		if not key then
			table.sort(t, reverse and mySort_reverse or mySort)
		else
			current = tab
			table.sort(t, reverse and sorts_reverse[key] or sorts[key])
			current = nil
		end
		
		t['#'] = 0
		
		return iter, tab
	end
end

AceLibrary:Register(AnchorsAway, vmajor, vminor, activate)
AnchorsAway = nil