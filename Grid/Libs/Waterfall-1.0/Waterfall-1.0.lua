--[[
Name: Waterfall-1.0
Revision: 129
Author(s): Nargiddley (nargiddley@gmail.com)
Inspired By: Dewdrop by ckknight
Website: http://www.wowace.com/wiki/Waterfall-1.0
Documentation: http://www.wowace.com/wiki/Waterfall-1.0
SVN: http://svn.wowace.com/wowace/trunk/Waterfall-1.0
Description: Gui Configuration Library
License: LGPL 2.1
Dependencies: AceOO-2.0
]]

local MAJOR_VERSION = "Waterfall-1.0"
local MINOR_VERSION = 90000 + 130

local CONTROL_LIMIT = 250
local _

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

if not AceLibrary:HasInstance("AceOO-2.0") then error(MAJOR_VERSION .. " requires AceOO-2.0.") end

local AceOO = AceLibrary("AceOO-2.0")

local Waterfall = {}

local currentframe

local OPTIONS = "Options"
local ARROW = " -> "
local ARE_YOU_SURE = "Are you sure you want to %s?"

if GetLocale() == "zhCN" then
	OPTIONS = "选项"
	ARROW = " -> "
	ARE_YOU_SURE = "你确定要 %s么?"
elseif GetLocale() == "zhTW" then
	OPTIONS = "選項"
	ARROW = " > "
	ARE_YOU_SURE = "你確定要「%s」嗎?"
elseif GetLocale() == "koKR" then
	OPTIONS = "설정"
	ARE_YOU_SURE = "정말 당신은 `%s'|1을;를; 하시겠습니까?"
elseif GetLocale() == "ruRU" then
	OPTIONS = "Опции"
	ARE_YOU_SURE = "Вы уверены что вы хотите %s?"
end

local DEFAULT_CONTROL_WIDTH = 180
--[[
	Passing an AceOO class will get an object of that class from the pool
	You dont need to specify the class when releasing it
	Passing a string will get a table from a named pool
	the string must be passed when releasing tables like this
--]]
local getObj, releaseObj
do
	local objPools = {}
	function getObj(class,...)
		if not objPools[class] then
			objPools[class] = {}
		end
		local newObj = tremove(objPools[class])
		if not newObj then
			if type(class.new) == "function" then
				newObj = class:new(...)
			else
				newObj = {}
			end
		end
		return newObj
	end
	function releaseObj(obj,class)
		if not class then
			class = obj.class
		end
		if not class then error("You must supply a class to release non AceOO objects") end
		if not objPools[class] then
			objPools[class] = {}
		end
		if type(obj.CleanUp) == "function" then
			obj:CleanUp()
		end
		tinsert(objPools[class],obj)
	end
end

--borrowed from Dewdrop-2.0
local function new(...)
	local t = {}
	for i = 1, select('#', ...), 2 do
		local k = select(i, ...)
		if k then
			t[k] = select(i+1, ...)
		else
			break
		end
	end
	return t
end

local tmp
do
	local t = {}
	function tmp(...)
		for k in pairs(t) do
			t[k] = nil
		end
		for i = 1, select('#', ...), 2 do
			local k = select(i, ...)
			if k then
				t[k] = select(i+1, ...)
			else
				break
			end
		end
		return t
	end
end
local tmp2
do
	local t = {}
	function tmp2(...)
		for k in pairs(t) do
			t[k] = nil
		end
		for i = 1, select('#', ...), 2 do
			local k = select(i, ...)
			if k then
				t[k] = select(i+1, ...)
			else
				break
			end
		end
		return t
	end
end

local function getArgs(t, str, num, ...)
	local x = t[str .. num]
	if x == nil then
		return ...
	else
		return x, getArgs(t, str, num + 1, ...)
	end
end

local function confirmPopup(message, func, ...)
	if not StaticPopupDialogs["WATERFALL01_CONFIRM_DIALOG"] then
		StaticPopupDialogs["WATERFALL01_CONFIRM_DIALOG"] = {}
	end
	local t = StaticPopupDialogs["WATERFALL01_CONFIRM_DIALOG"]
	for k in pairs(t) do
		t[k] = nil
	end
	t.text = message
	t.button1 = ACCEPT
	t.button2 = CANCEL
	t.OnAccept = function()
		func(unpack(t))
	end
	for i = 1, select('#', ...) do
		t[i] = select(i, ...) or false
	end
	t.timeout = 0
	t.whileDead = 1
	t.hideOnEscape = 1

	StaticPopup_Show("WATERFALL01_CONFIRM_DIALOG")
end

local function showGameTooltip(this)
	if this.tooltipTitle or this.tooltipText then
		GameTooltip_SetDefaultAnchor(GameTooltip, this.frame or this)
		if this.tooltipTitle then
			GameTooltip:SetText(this.tooltipTitle, 1, 1, 1, 1)
			if this.tooltipText then
				GameTooltip:AddLine(this.tooltipText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			end
		else
			GameTooltip:SetText(this.tooltipText, 1, 1, 1, 1)
		end
		GameTooltip:Show()
	end
end
--end of borrowing

local function parseList(list)
	local token, rest = list:match("([^%s]+)%s+(.+)")
	if not rest then
		return (tonumber(list) or list)
	else
		return (tonumber(token) or token), parseList(rest)
	end
end

local function compareOptions(a,b)
	if not a then
		return true
	end
	if not b then
		return false
	end
	local A, B = a.order or 100, b.order or 100
	if A == B then
		local NameA = a.guiName or a.name or ""
		local NameB = b.guiName or b.name or ""
		return NameA:upper() < NameB:upper()
	end
	if A < 0 then
		if B > 0 then
			return false
		end
	else
		if B < 0 then
			return true
		end
	end
	return A < B
end

function Waterfall:Register(id,...)
	local settings = new(...)

	if settings.aceOptions then
		assert(type(settings.aceOptions) == "table","\"aceOptions\" must be a table")
	else
		assert(type(settings.tree) == "table","\"tree\" must be a table")
		assert(type(settings.children) == "function","\"children\" must be a function")
	end
	if not settings.title then
		settings.title = id
	end

	if settings.treeType == "SECTIONS" then
		settings.hideTreeRoot = true
		settings.treeLevels = 3
	end

	if self.registry[id] then
		self:UnRegister(id)
	end
	self.registry[id] = settings
end

function Waterfall:UnRegister(id)
	self.registry[id] = nil
end

function Waterfall:IsRegistered(id)
	return not not self.registry[id]
end

local function releaseTree(tree)
	for i, v in ipairs(tree) do
		tree[i] = nil
		releaseTree(v)
		releaseObj(v,"table")
	end
	for k, v in pairs(tree) do
		tree[k] = nil
	end
end

local function checkNegatable(attr,handler,param)
	local ret
	if type(attr) == "function" then
		ret = attr(param)
	elseif type(attr) == "string" and handler then
		local neg = attr:match("^~(.+)$")
		if neg then
			attr = neg
		end
		ret = handler[attr](handler,param)
		if neg then
			ret = not ret
		end
	else
		ret = attr
	end
	return ret
end

local function buildAceOptionsTree(tree, status, options, numLevels, path, rootHandler)
	local settings = Waterfall.registry[currentframe.id]
	local handler = options.handler or rootHandler
	local args = options.args
	assert(type(args) == "table",("args must be a table: Current Path:%s"):format(path or "."))
	local root

	if path then
		tree.id = path
		tree.text = options.guiName or options.name or (options.handler and options.handler.name) or path
		tree.name = tree.text
		tree.tooltipTitle = tree.text
		tree.tooltipText = options.desc
		tree.order = options.order
		tree.disabled = checkNegatable(options.disabled, handler, options.passValue)
		tree.handler = handler
		tree.icon = options.icon
		tree.hidden = checkNegatable(options.wfHidden or options.guiHidden or options.hidden,handler, options.passValue)
		local hasOptions
		for k, item in pairs(args) do
			if item.type ~= "group" and item.type ~= "heading" then
				if not checkNegatable(item.wfHidden or item.guiHidden or item.hidden,handler, item.passValue) then
					hasOptions = true
				end
			end
		end
		tree.hasOptions = hasOptions
	else
		releaseTree(tree)
		local hasOptions
		for k, item in pairs(args) do
			if item.type ~= "group" and item.type ~= "heading" then
				hasOptions = true
			end
		end
		if hasOptions then
			root = getObj("table")
			root.text = options.guiName or options.name or (options.handler and options.handler.name) or path
			root.name = tree.text
			root.tooltipTitle = tree.text
			root.tooltipText = options.desc
			root.order = options.order
			root.disabled = checkNegatable(options.disabled, handler, options.passValue)
			root.handler = handler
			root.icon = options.icon
			root.hidden = checkNegatable(options.wfHidden or options.guiHidden or options.hidden,handler, options.passValue)
			root.id = "."
			root.hasOptions = true
			if status['.'] == nil then
				status['.'] = true
			end
			tinsert(tree,root)
			if not settings.hideTreeRoot then
				tree = root
			end
		end
		settings.treeRootShown = hasOptions and not settings.hideTreeRoot
	end

	if not numLevels or numLevels > 1 then
		for k, item in pairs(args) do
			if item.type == "group" then
				local child = getObj("table")
				local nextPath
				if path then
					nextPath = path.."."..k
				else
					nextPath = k
				end
				if numLevels then
					buildAceOptionsTree(child, status, item,numLevels - 1,nextPath, handler)
				else
					buildAceOptionsTree(child, status, item,nil,nextPath, handler)
				end
				tinsert(tree,child)
			end
		end
	end
	sort(tree,compareOptions)
end

local function checkAceOptionsPath(path, options, frame)
	local t = options
	local validpath
	for k in path:gmatch("[^\.]+") do
		if tonumber(k) and t.args[tonumber(k)] then
			k = tonumber(k)
		end
		if t.args and t.args[k] then
			t = t.args[k]
			if validpath then
				validpath = validpath..'.'..k
			else
				validpath = k
			end
		else
			if frame then
				frame:SetSelected(validpath, true)
			end
			break
		end
	end
	return validpath or '.'
end

local function feedFromOptionsTree(paneid, options)
	if not paneid then return end
	local settings = Waterfall.registry[currentframe.id]
	paneid = checkAceOptionsPath(paneid, options, settings.frame)
	local curlevel = 1
	local levels = 1
	for x in paneid:gmatch("[^%.]+") do
		curlevel = curlevel + 1
	end
	if settings.treeLevels == curlevel then
		levels = nil
	end
	if paneid == "." then
		Waterfall:FeedAceOptionsTable(options, nil, levels)
		return options.name or (options.handler and options.handler.name) or OPTIONS
	else
		local crumbs
		if settings.treeRootShown then
			crumbs = options.name or (options.handler and options.handler.name) or OPTIONS
		end
		local t = options
		Waterfall:FeedAceOptionsTable(options,paneid,levels)
		for k in paneid:gmatch("[^\.]+") do
			if tonumber(k) and t.args[tonumber(k)] then
				k = tonumber(k)
			end
			if t.args and t.args[k] then
				t = t.args[k]
				if crumbs then
					crumbs = crumbs..ARROW..(t.guiName or t.name or "")
				else
					crumbs = (t.guiName or t.name or "")
				end
			else
				Waterfall:error("Invalid path \"%s\" for Aceoptions table",paneid)
			end
		end
		return crumbs
	end
end

local old_CloseSpecialWindows

function Waterfall:Open(id, pane)
	if not old_CloseSpecialWindows then
		old_CloseSpecialWindows = CloseSpecialWindows
		CloseSpecialWindows = function()
			local found = old_CloseSpecialWindows()
			return self:CloseAll() or found
		end
	end
	local info = self.registry[id]
	if not info then
		error("You cannot open a waterfall without registering it first")
	end
	--already open
	if info.frame then
		if pane then
			info.frame:SetSelected(pane)
		end
		return
	end
	local frame = getObj(WaterfallFrame)
	frame:SetID(id)
	frame.lib = self
	info.frame = frame
	if info.title then
		frame:SetTitle(info.title)
	end
	local r,g,b = info.colorR or 1, info.colorG or 0.6, info.colorB or 0
	frame:SetColor(r,g,b)

	if info.aceOptions then

		if not info.tree then
			info.tree = {}
		end
		if not info.treestatus then
			info.treestatus = {}
		end
		currentframe = frame
			frame:SetTree(info.tree, info.treestatus, buildAceOptionsTree, info.aceOptions, info.treeLevels)
		currentframe = nil
		frame:SetChildren(feedFromOptionsTree, info.aceOptions)
		if pane then
			frame.treeview:Collapse()
		end
		frame:SetSelected(pane or info.defaultPane or ".")
		frame.treeview:SetType(info.treeType)
	else
		if not info.treestatus then
			info.treestatus = {}
		end
		frame:SetTree(info.tree, info.treestatus)
		frame:SetChildren(info.children)
		if pane or info.defaultPane then
			frame:SetSelected(pane or info.defaultPane)
		end
		frame.treeview:SetType(info.treeType)
	end

	if info.height then
		frame:SetHeight(info.height)
	end
	if info.width then
		frame:SetWidth(info.width)
	end
	frame:Refresh()
	frame:Show()

end

function Waterfall:IsOpen(id)
	return not not self.registry[id].frame
end

function Waterfall:Refresh(id)
	local info = self.registry[id]
	if not info then
		error("You can't refresh a waterfall without registering it first")
	end
	if info.frame then
		info.frame:Refresh()
	end
end

function Waterfall:SetSize(id, width, height)
	local info = self.registry[id]
	if not info then
		error("You refresh open a waterfall without registering it first")
	end
	if info.frame then
		info.frame:SetWidth(width)
		info.frame:SetHeight(height)
	end
end

local function setCommonAttributes(control,info)
	control.width = info.width
	control.height = info.height
	control.noNewLine = info.noNewLine
	control.causesRefresh = info.causesRefresh
	control.fullRefresh = info.fullRefresh
	control.treeRefresh = info.treeRefresh
	control.tooltipTitle = info.tooltipTitle
	control.tooltipText	= info.tooltipText
	control:SetText(info.text or "")
end

function Waterfall:AddControl(...)
	currentframe.controlcount = currentframe.controlcount + 1
	if not currentframe then
		error("AddControl must be called from within a children function")
	end
	local control
	local info = self.registry[currentframe.id]
	local limit = info.controlLimit or CONTROL_LIMIT
	if currentframe.controlcount > limit then
		if currentframe.controlcount == limit + 1 then
			control = getObj(WaterfallLabel)
			control.r = 1
			control.g = 0
			control.b = 0
			control:SetText(("More than %s Controls in current pane....."):format(limit))
			control:Refresh()
			currentframe:AddControl(control)
		end
		return
	end
	local info = tmp2(...)

	if info.type == "label" then
		control = getObj(WaterfallLabel)
		setCommonAttributes(control,info)
		control.justifyH = info.justifyH
		control.r = info.r
		control.g = info.g
		control.b = info.b
		control:Refresh()
	elseif info.type ==  "dragLink" then
		control = getObj(WaterfallDragLink)
		setCommonAttributes(control,info)
		control:SetFunc("set",info.setFunc,getArgs(info,"setArg",1))
		control:SetFunc("get",info.getFunc,getArgs(info,"getArg",1))
		if type(info.disabled) == "function" then
			control:SetFunc("disabled",info.disabled,getArgs(info,"disabledArg",1))
			control.inverseDisabled = info.inverseDisabled
		else
			control.disabled = info.disabled
		end

		control:Refresh()
	elseif info.type == "linklabel" then
		control = getObj(WaterfallLinklabel)
		setCommonAttributes(control,info)
		control.justifyH = info.justifyH
		control.r = info.r
		control.g = info.g
		control.b = info.b

		control:SetFunc("link",info.linkFunc,getArgs(info,"linkArg",1))
		if type(info.disabled) == "function" then
			control:SetFunc("disabled",info.disabled,getArgs(info,"disabledArg",1))
			control.inverseDisabled = info.inverseDisabled
		else
			control.disabled = info.disabled
		end
		control.confirm = info.confirm
		control:Refresh()

	elseif info.type ==  "button" then
		control = getObj(WaterfallButton)
		setCommonAttributes(control,info)
		control:SetFunc("exec",info.execFunc,getArgs(info,"execArg",1))
		if type(info.disabled) == "function" then
			control:SetFunc("disabled",info.disabled,getArgs(info,"disabledArg",1))
			control.inverseDisabled = info.inverseDisabled
		else
			control.disabled = info.disabled
		end
		control.confirm = info.confirm
		control.link = info.link

		control:Refresh()

	elseif info.type ==  "heading" then
		control = getObj(WaterfallHeading)
		control.justifyH = info.justifyH
		setCommonAttributes(control,info)
		control:Refresh()
	elseif info.type ==  "textbox" then
		control = getObj(WaterfallTextBox)
		setCommonAttributes(control,info)
		control:SetFunc("set",info.setFunc,getArgs(info,"setArg",1))
		control:SetFunc("get",info.getFunc,getArgs(info,"getArg",1))
		control:SetFunc("changed",info.changedFunc,getArgs(info,"changedArg",1))
		if type(info.disabled) == "function" then
			control:SetFunc("disabled",info.disabled,getArgs(info,"disabledArg",1))
			control.inverseDisabled = info.inverseDisabled
		else
			control.disabled = info.disabled
		end
		control.toNumber = info.toNumber
		control.parseList = info.parseList
		control.setOnTextChanged = info.setOnTextChanged
		control:SetFunc("validate",info.validateFunc,getArgs(info,"validateArg",1))
		control.validateModifies = info.validateModifies
		control:Refresh()

	elseif info.type ==  "dropdown" then
		control = getObj(WaterfallDropdown)
		setCommonAttributes(control,info)
		control:SetFunc("set",info.setFunc,getArgs(info,"setArg",1))
		control:SetFunc("get",info.getFunc,getArgs(info,"getArg",1))
		if type(info.disabled) == "function" then
			control:SetFunc("disabled",info.disabled,getArgs(info,"disabledArg",1))
			control.inverseDisabled = info.inverseDisabled
		else
			control.disabled = info.disabled
		end
		control.parseList = info.parseList
		control.list = info.list
		control.columns = info.columns
		control.strict = info.strict

		control:Refresh()

	elseif info.type ==  "checkbox" then
		control = getObj(WaterfallCheckBox)
		setCommonAttributes(control,info)
		control:SetChecked(info.checked)
		control.isRadio = info.isRadio
		control:SetFunc("set",info.setFunc,getArgs(info,"setArg",1))
		control:SetFunc("get",info.getFunc,getArgs(info,"getArg",1))
		if type(info.disabled) == "function" then
			control:SetFunc("disabled",info.disabled,getArgs(info,"disabledArg",1))
			control.inverseDisabled = info.inverseDisabled
		else
			control.disabled = info.disabled
		end

		control:Refresh()
	elseif info.type == "slider" then
		control = getObj(WaterfallSlider)
		setCommonAttributes(control,info)
		control:SetFunc("set",info.setFunc,getArgs(info,"setArg",1))
		control:SetFunc("get",info.getFunc,getArgs(info,"getArg",1))
		control.min = info.min
		control.max = info.max
		control.step = info.step
		control.bigStep = info.bigStep or info.step
		control.finalSetOnly = info.finalSetOnly
		if type(info.disabled) == "function" then
			control:SetFunc("disabled",info.disabled,getArgs(info,"disabledArg",1))
			control.inverseDisabled = info.inverseDisabled
		else
			control.disabled = info.disabled
		end
		control:Refresh()
	elseif info.type == "color" then
		control = getObj(WaterfallColorSwatch)
		setCommonAttributes(control,info)
		control:SetFunc("set",info.setFunc,getArgs(info,"setArg",1))
		control:SetFunc("get",info.getFunc,getArgs(info,"getArg",1))
		if type(info.disabled) == "function" then
			control:SetFunc("disabled",info.disabled,getArgs(info,"disabledArg",1))
			control.inverseDisabled = info.inverseDisabled
		else
			control.disabled = info.disabled
		end
		control.hasOpacity = info.hasOpacity
		control.r = info.r
		control.g = info.g
		control.b = info.b
		control.opacity = info.opacity
		control.hasOpacity = info.hasOpacity
		control:Refresh()
	elseif info.type == "keybind" then
		control = getObj(WaterfallKeybinding)
		control:SetText("Binding")
		setCommonAttributes(control,info)
		control:SetFunc("set",info.setFunc,getArgs(info,"setArg",1))
		control:SetFunc("get",info.getFunc,getArgs(info,"getArg",1))
		if type(info.disabled) == "function" then
			control:SetFunc("disabled",info.disabled,getArgs(info,"disabledArg",1))
			control.inverseDisabled = info.inverseDisabled
		else
			control.disabled = info.disabled
		end
		control.keybindingOnly = info.keybindingOnly
		control.keybindingExcept = info.keybindingExcept
		control:Refresh()
	else
		error("Invalid or missing type")
	end
	currentframe:AddControl(control)
end


local function addDisabled(t,disabled,handler,param)
	if disabled then
		if type(disabled) == "function" or type(disabled) == "boolean" then
			tinsert(t,"disabled")
			tinsert(t,disabled)
			if param then
				tinsert(t,"disabledArg1")
				tinsert(t,param)
			end
		elseif type(disabled) == "string" then
			local neg = disabled:match("^~(.+)$")
			if neg then
				disabled = neg
			end
			if handler and handler[disabled] then
				tinsert(t,"disabled")
				tinsert(t,handler[disabled])
				tinsert(t,"disabledArg1")
				tinsert(t,handler)
				if param then
					tinsert(t,"disabledArg2")
					tinsert(t,param)
				end
			end
			if neg then
				tinsert(t,"inverseDisabled")
				tinsert(t,true)
			end
		end
	end
end

local function appendArgs(t,name,start,...)
	local i = start
	local count = 1
	local arg = select(count,...)
	while arg do
		tinsert(t,name.."Arg"..i)
		tinsert(t,arg)
		i = i + 1
		count = count + 1
		arg = select(count,...)
	end
end

local function addFunction(t,name,func,handler,...)
	if type(func) == "function" then
		tinsert(t,name.."Func")
		tinsert(t,func)
		appendArgs(t,name,1,...)
	elseif type(func) == "string" and handler and handler[func] then
		tinsert(t,name.."Func")
		tinsert(t,handler[func])
		tinsert(t,name.."Arg1")
		tinsert(t,handler)
		appendArgs(t,name,2,...)
	end
end

local function validateRange(min,max,step,value)
	value = tonumber(value)
	if step > 0 then
		value = math.floor((value - min) / step + 0.5) * step + min
	end
	if value >= min and value <= max then
		return value
	else
		return nil
	end
end

--[[
	Feeds an ace options table into the right pane, must be called within a "children" function
	  root is the root of your options table, this is important if you use any methods for resolving the handler
	  path is the path into the table seperated by "." e.g. "Items.Compress" to feed the table given by root.args.Items.args.Compress
	  maxLevels is how many sub groups to feed as well, 1 is only the current level 2 will feed sub groups etc. nil assumes no limit
]]
function Waterfall:FeedAceOptionsTable(root,path,maxLevels)
	local feedtmp = getObj("table")
	local feedkeys = getObj("table")
	local tmpargs = getObj("table")

	local t
	local handler = root.handler
	local groupDisabled = checkNegatable(root.disabled,root.handler,root.passValue)
	local passSet
	local passGet
	if root.pass then
		passSet = root.set
		passGet = root.get
	else
		passSet = nil
		passGet = nil
	end
	if path then
		t = root
		for k in path:gmatch("[^\.]+") do
			if tonumber(k) and t.args[tonumber(k)] then
				k = tonumber(k)
			end
			if t.args and t.args[k] then
				t = t.args[k]
				handler = t.handler or handler
				groupDisabled = checkNegatable(t.disabled,handler,t.passValue) or groupDisabled
				if t.pass then
					passSet = t.set
					passGet = t.get
				else
					passSet = nil
					passGet = nil
				end
			else
				self:error("Invalid path \"%s\" for Aceoptions table",path)
			end
		end
	else
		t = root
	end
	if t.type ~= "group" then
		self:error("You must feed an ace options group")
	end
	for k, v in pairs(t.args) do
		tinsert(feedtmp, v)
		feedkeys[v] = k
	end

	table.sort(feedtmp, compareOptions)
	local lastheader
	for i, v in ipairs(feedtmp) do
		--only add headers if they arent immediately followed by a group
		if lastheader then
			if v.type ~= "group" then
				--self:AddControl("type","label","text","","width",80)
				--self:AddControl("type","heading","text",lastheader,"width",DEFAULT_CONTROL_WIDTH,"justifyH","CENTER","noNewLine",true)
				self:AddControl("type","heading","text",lastheader,"width",DEFAULT_CONTROL_WIDTH,"justifyH","CENTER")
			end
			lastheader = nil
		end
		local hidden
		if v.guiHidden ~= nil then
			hidden = v.guiHidden
		elseif v.wfHidden ~= nil then
			hidden = v.wfHidden
		else
			hidden = v.hidden
		end
		hidden = checkNegatable(hidden,v.handler or handler,v.passValue)

		local name = v.guiName or v.name
		if name and ( checkNegatable(v.disabled,v.handler or handler,v.passValue) or groupDisabled ) then
			name = "|cFF808080"..name
		end
		if not hidden then
			if v.type == "toggle" then
				--self:AddControl("type","label","text","","width",80)
				tinsert(tmpargs,"type")
				tinsert(tmpargs,"checkbox")
				--tinsert(tmpargs,"noNewLine")
				--tinsert(tmpargs,true)
				tinsert(tmpargs,"text")
				tinsert(tmpargs,name)
				tinsert(tmpargs,"tooltipTitle")
				tinsert(tmpargs,name)
				tinsert(tmpargs,"tooltipText")
				tinsert(tmpargs,v.desc or false)
				tinsert(tmpargs,"isRadio")
				tinsert(tmpargs,not not v.isRadio)
				if passGet and v.get == nil then
					addFunction(tmpargs,"get",passGet,v.handler or handler,v.passValue or feedkeys[v])
				else
					addFunction(tmpargs,"get",v.get,v.handler or handler,v.passValue)
				end
				if passSet and v.set == nil then
					addFunction(tmpargs,"set",passSet,v.handler or handler,v.passValue or feedkeys[v])
				else
					addFunction(tmpargs,"set",v.set,v.handler or handler,v.passValue)
				end

				addDisabled(tmpargs,groupDisabled or v.disabled,v.handler or handler,v.passValue)
				tinsert(tmpargs,"fullRefresh")
				tinsert(tmpargs,true)
				self:AddControl(unpack(tmpargs))
			elseif v.type == "dragLink" then
				tinsert(tmpargs,"type")
				tinsert(tmpargs,"dragLink")
				tinsert(tmpargs,"text")
				tinsert(tmpargs,name)
				tinsert(tmpargs,"tooltipText")
				tinsert(tmpargs,v.desc or false)
				tinsert(tmpargs,"tooltipTitle")
				local tooltipTitle = "" .. tostring(v.itemId)
				tinsert(tmpargs,tooltipTitle)
				tinsert(tmpargs,"linkInfo")
				tinsert(tmpargs,v.linkInfo or {})
				tinsert(tmpargs,"icon")
				tinsert(tmpargs,v.icon or "")
				tinsert(tmpargs,"iconWidth")
				tinsert(tmpargs,v.iconWidth or WaterfallDragLink.defaultIconSize)
				tinsert(tmpargs,"iconHeight")
				tinsert(tmpargs,v.iconHeight or WaterfallDragLink.defaultIconSize)
				if passGet and v.get == nil then
					addFunction(tmpargs,"get",passGet,v.handler or handler,v.passValue or feedkeys[v])
				else
					addFunction(tmpargs,"get",v.get,v.handler or handler,v.passValue)
				end
				if passSet and v.set == nil then
					addFunction(tmpargs,"set",passSet,v.handler or handler,v.passValue or feedkeys[v])
				else
					addFunction(tmpargs,"set",v.set,v.handler,v.passValue)
				end

				addDisabled(tmpargs,groupDisabled or v.disabled,v.handler or handler,v.passValue)

				self:AddControl(unpack(tmpargs))
			elseif v.type == "group" then
				if not maxLevels or maxLevels > 1 then
					--self:AddControl("type","label","text","","width",80)
					if checkNegatable(v.disabled,v.handler or handler,v.passValue) or groupDisabled then
						name = "|cFF808080"..name
					end
					--self:AddControl("type","heading","text",name,"width",DEFAULT_CONTROL_WIDTH,"justifyH","CENTER","noNewLine",true)
					self:AddControl("type","heading","text",name,"width",DEFAULT_CONTROL_WIDTH,"justifyH","CENTER")
					local nextPath
					local nextMaxLevels
					if path then
						nextPath = path.."."..feedkeys[v]
					else
						nextPath = feedkeys[v]
					end
					if maxLevels then
						nextMaxLevels = maxLevels - 1
					end
					self:FeedAceOptionsTable(root,nextPath,nextMaxLevels)
					self:AddControl("type","heading")
				end
			elseif v.type == "text" then
				if type(v.validate) == "table" then
					if v.multiToggle then
						self:AddControl("type","heading","text",name)
						for key, value in pairs(v.validate) do
							if type(key) == "number" then
								key = value
							end
							self:AddControl("type","label","text","","width",12)
							tinsert(tmpargs,"type")
							tinsert(tmpargs,"checkbox")
							tinsert(tmpargs,"text")
							tinsert(tmpargs,value)
							tinsert(tmpargs,"noNewLine")
							tinsert(tmpargs,true)
							tinsert(tmpargs,"tooltipTitle")
							tinsert(tmpargs,name)
							tinsert(tmpargs,"tooltipText")
							tinsert(tmpargs,value)
							if v.passValue then
								if passGet and v.get == nil then
									addFunction(tmpargs,"get",passGet,v.handler or handler,v.passValue or feedkeys[v],key)
								else
									addFunction(tmpargs,"get",v.get,v.handler or handler,v.passValue,key)
								end
								if passSet and v.set == nil then
									addFunction(tmpargs,"set",passSet,v.handler or handler,v.passValue or feedkeys[v],key)
								else
									addFunction(tmpargs,"set",v.set,v.handler or handler,v.passValue,key)
								end
							else
								if passGet and v.get == nil then
									addFunction(tmpargs,"get",passGet,v.handler or handler,feedkeys[v],key)
								else
									addFunction(tmpargs,"get",v.get,v.handler or handler,key)
								end
								if passSet and v.set == nil then
									addFunction(tmpargs,"set",passSet,v.handler or handler,feedkeys[v],key)
								else
									addFunction(tmpargs,"set",v.set,v.handler or handler,key)
								end
							end

							addDisabled(tmpargs,groupDisabled or v.disabled,v.handler or handler,v.passValue,key)
							tinsert(tmpargs,"fullRefresh")
							tinsert(tmpargs,true)
							self:AddControl(unpack(tmpargs))
							for i = 0,#tmpargs do
								tmpargs[i] = nil
							end
						end
					else
						--self:AddControl("type","label","text",name,"width",80,"justifyH","RIGHT")
						self:AddControl("type","label","text",name)
						tinsert(tmpargs,"type")
						tinsert(tmpargs,"dropdown")
						tinsert(tmpargs,"strict")
						tinsert(tmpargs,true)
						--tinsert(tmpargs,"noNewLine")
						--tinsert(tmpargs,true)
						tinsert(tmpargs,"tooltipTitle")
						tinsert(tmpargs,name)
						tinsert(tmpargs,"tooltipText")
						tinsert(tmpargs,v.desc or false)
						if passGet and v.get == nil then
							addFunction(tmpargs,"get",passGet,v.handler or handler,v.passValue or feedkeys[v])
						else
							addFunction(tmpargs,"get",v.get,v.handler or handler,v.passValue)
						end
						if passSet and v.set == nil then
							addFunction(tmpargs,"set",passSet,v.handler or handler,v.passValue or feedkeys[v])
						else
							addFunction(tmpargs,"set",v.set,v.handler or handler,v.passValue)
						end

						addDisabled(tmpargs,groupDisabled or v.disabled,v.handler or handler,v.passValue)

						tinsert(tmpargs,"list")
						tinsert(tmpargs,v.validate)
						tinsert(tmpargs,"columns")
						tinsert(tmpargs,v.columns)
						tinsert(tmpargs,"parseList")
						tinsert(tmpargs, not not v.input)
						tinsert(tmpargs,"fullRefresh")
						tinsert(tmpargs,true)
						self:AddControl(unpack(tmpargs))
					end
				elseif v.validate == "keybinding" then
					--self:AddControl("type","label","text",name,"width",80,"justifyH","RIGHT")
					self:AddControl("type","label","text",name)
					tinsert(tmpargs,"type")
					tinsert(tmpargs,"keybind")
					--tinsert(tmpargs,"noNewLine")
					--tinsert(tmpargs,true)
					if passGet and v.get == nil then
						addFunction(tmpargs,"get",passGet,v.handler or handler,v.passValue or feedkeys[v])
					else
						addFunction(tmpargs,"get",v.get,v.handler or handler,v.passValue)
					end
					if passSet and v.set == nil then
						addFunction(tmpargs,"set",passSet,v.handler or handler,v.passValue or feedkeys[v])
					else
						addFunction(tmpargs,"set",v.set,v.handler or handler,v.passValue)
					end
					tinsert(tmpargs,"keybindingOnly")
					tinsert(tmpargs,v.keybindingOnly or false)
					tinsert(tmpargs,"keybindingExcept")
					tinsert(tmpargs,v.keybindingExcept or false)
					tinsert(tmpargs,"tooltipTitle")
					tinsert(tmpargs,name)
					tinsert(tmpargs,"tooltipText")
					tinsert(tmpargs,v.desc or false)
					tinsert(tmpargs,"fullRefresh")
					tinsert(tmpargs,true)

					self:AddControl(unpack(tmpargs))
				else
					--self:AddControl("type","label","text",name,"width",80,"justifyH","RIGHT")
					self:AddControl("type","label","text",name)
					tinsert(tmpargs,"type")
					tinsert(tmpargs,"textbox")
					--tinsert(tmpargs,"noNewLine")
					--tinsert(tmpargs,true)
					tinsert(tmpargs,"tooltipTitle")
					tinsert(tmpargs,name)
					tinsert(tmpargs,"tooltipText")
					tinsert(tmpargs,v.desc or false)
					if passGet and v.get == nil then
						addFunction(tmpargs,"get",passGet,v.handler or handler,v.passValue or feedkeys[v])
					else
						addFunction(tmpargs,"get",v.get,v.handler or handler,v.passValue)
					end
					if passSet and v.set == nil then
						addFunction(tmpargs,"set",passSet,v.handler or handler,v.passValue or feedkeys[v])
					else
						addFunction(tmpargs,"set",v.set,v.handler or handler,v.passValue)
					end

					addDisabled(tmpargs,groupDisabled or v.disabled,v.handler or handler,v.passValue)
					tinsert(tmpargs,"parseList")
					tinsert(tmpargs, not not v.input)
					tinsert(tmpargs,"fullRefresh")
					tinsert(tmpargs,true)

					addFunction(tmpargs,"validate",v.validate,v.handler or handler)

					self:AddControl(unpack(tmpargs))
				end
			elseif v.type == "execute" then
				--self:AddControl("type","label","text","","width",80)
				tinsert(tmpargs,"type")
				tinsert(tmpargs,"button")
				--tinsert(tmpargs,"noNewLine")
				--tinsert(tmpargs,true)
				tinsert(tmpargs,"text")
				tinsert(tmpargs,name)
				tinsert(tmpargs,"confirm")
				tinsert(tmpargs, v.confirm or false)
				tinsert(tmpargs,"tooltipTitle")
				tinsert(tmpargs,name)
				tinsert(tmpargs,"tooltipText")
				tinsert(tmpargs,v.desc or false)
				tinsert(tmpargs, "link")
				tinsert(tmpargs,v.link or false)
				addFunction(tmpargs,"exec",v.func,v.handler or handler,v.passValue)

				addDisabled(tmpargs,groupDisabled or v.disabled,v.handler or handler,v.passValue)

				tinsert(tmpargs,"fullRefresh")
				tinsert(tmpargs,true)
				self:AddControl(unpack(tmpargs))
			elseif v.type == "header" then
				if name and ( checkNegatable(v.disabled,v.handler or handler,v.passValue) or groupDisabled ) then
					lastheader = "|cFF808080"..name
				else
					lastheader = name
				end
			elseif v.type == "range" then
				--self:AddControl("type","label","text",name,"width",80,"justifyH","RIGHT")
				self:AddControl("type","label","text",name)
				tinsert(tmpargs,"type")
				tinsert(tmpargs,"slider")
				--tinsert(tmpargs,"noNewLine")
				--tinsert(tmpargs,true)
				local min,max,step
				min = v.min or 0
				max = v.max or 1
				step = v.step or 0
				tinsert(tmpargs,"min")
				tinsert(tmpargs,v.min or 0)
				tinsert(tmpargs,"max")
				tinsert(tmpargs,v.max or 1)
				tinsert(tmpargs,"step")
				tinsert(tmpargs,v.step or 0)
				tinsert(tmpargs,"bigStep")
				tinsert(tmpargs,v.bigStep or v.step or 0)
				tinsert(tmpargs,"finalSetOnly")
				tinsert(tmpargs,v.finalSetOnly or false)
				--if no step is given or there are more than 20 steps possible
				--local complex = step == 0 or ((max - min) / step) > 20
				local complex = true
				tinsert(tmpargs,"text")
				tinsert(tmpargs,"")
				tinsert(tmpargs,"tooltipTitle")
				tinsert(tmpargs,name)
				tinsert(tmpargs,"tooltipText")
				tinsert(tmpargs,v.desc or false)
				if passGet and v.get == nil then
					addFunction(tmpargs,"get",passGet,v.handler or handler,v.passValue or feedkeys[v])
				else
					addFunction(tmpargs,"get",v.get,v.handler or handler,v.passValue)
				end
				if passSet and v.set == nil then
					addFunction(tmpargs,"set",passSet,v.handler or handler,v.passValue or feedkeys[v])
				else
					addFunction(tmpargs,"set",v.set,v.handler or handler,v.passValue)
				end
				addDisabled(tmpargs,groupDisabled or v.disabled,v.handler or handler,v.passValue)

				tinsert(tmpargs,"fullRefresh")
				tinsert(tmpargs,true)
				self:AddControl(unpack(tmpargs))
				if complex then
					tinsert(tmpargs,"type")
					tinsert(tmpargs,"textbox")
					tinsert(tmpargs,"noNewLine")
					tinsert(tmpargs,true)
					tinsert(tmpargs,"toNumber")
					tinsert(tmpargs,true)
					tinsert(tmpargs,"validateModifies")
					tinsert(tmpargs,true)
					tinsert(tmpargs,"width")
					tinsert(tmpargs,60)
					tinsert(tmpargs,"tooltipTitle")
					tinsert(tmpargs,name)
					tinsert(tmpargs,"tooltipText")
					tinsert(tmpargs,v.desc or false)
					if passGet and v.get == nil then
						addFunction(tmpargs,"get",passGet,v.handler or handler,v.passValue or feedkeys[v])
					else
						addFunction(tmpargs,"get",v.get,v.handler or handler,v.passValue)
					end
					if passSet and v.set == nil then
						addFunction(tmpargs,"set",passSet,v.handler or handler,v.passValue or feedkeys[v])
					else
						addFunction(tmpargs,"set",v.set,v.handler or handler,v.passValue)
					end

					addFunction(tmpargs,"validate",validateRange,v.handler or handler,min,max,step)
					addDisabled(tmpargs,groupDisabled or v.disabled,v.handler or handler,v.passValue)

					tinsert(tmpargs,"fullRefresh")
					tinsert(tmpargs,true)
					self:AddControl(unpack(tmpargs))
				end
			elseif v.type == "color" then
				--self:AddControl("type","label","text","","width",80)
				tinsert(tmpargs,"type")
				tinsert(tmpargs,"color")
				--tinsert(tmpargs,"noNewLine")
				--tinsert(tmpargs,true)
				tinsert(tmpargs,"text")
				tinsert(tmpargs,name)
				if passGet and v.get == nil then
					addFunction(tmpargs,"get",passGet,v.handler or handler,v.passValue or feedkeys[v])
				else
					addFunction(tmpargs,"get",v.get,v.handler or handler,v.passValue)
				end
				if passSet and v.set == nil then
					addFunction(tmpargs,"set",passSet,v.handler or handler,v.passValue or feedkeys[v])
				else
					addFunction(tmpargs,"set",v.set,v.handler or handler,v.passValue)
				end
				addDisabled(tmpargs,groupDisabled or v.disabled,v.handler or handler,v.passValue)
				tinsert(tmpargs,"tooltipTitle")
				tinsert(tmpargs,name)
				tinsert(tmpargs,"tooltipText")
				tinsert(tmpargs,v.desc or false)
				tinsert(tmpargs,"hasOpacity")
				tinsert(tmpargs, not not v.hasAlpha)
				self:AddControl(unpack(tmpargs))
			end

			for i = 0,#tmpargs do
				tmpargs[i] = nil
			end
		end
	end
	for i = 0,#feedtmp do
		feedtmp[i] = nil
	end
	for k in pairs(feedkeys) do
		feedkeys[k] = nil
	end

	 releaseObj(feedtmp,"table")
	 releaseObj(feedkeys,"table")
	 releaseObj(tmpargs,"table")
end

function Waterfall:Close(id)
	local info = self.registry[id]
	if not info then
		error("You cannot close a waterfall without registering it first")
	end
	local frame = info.frame
	if frame then
		local OnClose = info.OnClose
		if type(OnClose) == "function" then
			OnClose(id)
		end
		releaseObj(frame)
	end
	info.frame = nil
end

function Waterfall:CloseAll()
	local closed
	for id, v in pairs(self.registry) do
		if v.frame then
			self:Close(id)
			closed = true
		end
	end
	return closed
end

-----------------
-- Gui Classes --
-----------------
local FrameBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 30, bottom = 3 }
}

local PaneBackdrop  = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 23, bottom = 3 }
}

local ControlBackdrop  = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}



-- virtual class to contain frame functions
local FramePassthrough = AceOO.Class()
FramePassthrough.virtual = true

function FramePassthrough.prototype:SetPoint(point,relativeTo,relativePoint,xOffset,yOffset)
	self.frame:SetPoint(point,(relativeTo and relativeTo.frame) or relativeTo,relativePoint,xOffset,yOffset)
end
function FramePassthrough.prototype:SetAllPoints(frame)
	self.frame:SetAllPoints(frame.frame or frame)
end
function FramePassthrough.prototype:SetWidth(...)
	self.frame:SetWidth(...)
end
function FramePassthrough.prototype:SetHeight(...)
	self.frame:SetHeight(...)
end
function FramePassthrough.prototype:SetMinResize(...)
	self.frame:SetMinResize(...)
end
function FramePassthrough.prototype:SetMaxResize(...)
	self.frame:SetMaxResize(...)
end
function FramePassthrough.prototype:ClearAllPoints()
	self.frame:ClearAllPoints()
end
function FramePassthrough.prototype:Show()
	self.frame:Show()
end
function FramePassthrough.prototype:Hide()
	self.frame:Hide()
end
function FramePassthrough.prototype:GetHeight()
	return self.frame:GetHeight()
end
function FramePassthrough.prototype:GetWidth()
	return self.frame:GetWidth()
end

-- Base Class for Gui Controls
local WaterfallControl = AceOO.Class(FramePassthrough)
WaterfallControl.virtual = true

function WaterfallControl.prototype:init(frametype,inherits)
	WaterfallControl.super.prototype.init(self)
	local frame = CreateFrame(frametype or "Frame",nil,nil,inherits)
	self.frame = frame
	frame.obj = self
	frame:SetFrameLevel(10)
	frame:SetFrameStrata("DIALOG")
end

function WaterfallControl.prototype:SetParent(parent)
	self.parent = parent
	self.frame:SetParent(parent.scrollchild)
end

function WaterfallControl.prototype:Refresh()

end

--basic cleanup function, usually overridden
function WaterfallControl.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self.disabled = nil
	self:SetFunc("disabled",nil)
end

function WaterfallControl.prototype:SetFunc(funcType,func,...)
	self[funcType.."Func"] = func
	local i = 1
	while self[funcType.."Arg"..i] do
		self[funcType.."Arg"..i] = nil
		i = i + 1
	end
	i = 1
	local arg = (select(i,...))
	while (select(i,...)) ~= nil do
		self[funcType.."Arg"..i] = arg
		i = i + 1
		arg = (select(i,...))
	end
end

local function Control_OnEnter(this)
	showGameTooltip(this.obj)
end

local function Control_OnLeave(this)
	GameTooltip:Hide()
end

--the main waterfall frame
WaterfallFrame = AceOO.Class(FramePassthrough)
--the right side pane with gui components in it
WaterfallPane = AceOO.Class(FramePassthrough)

--gui components to be placed on the pane
WaterfallLabel = AceOO.Class(WaterfallControl)
WaterfallLinklabel = AceOO.Class(WaterfallControl)
WaterfallCheckBox = AceOO.Class(WaterfallControl)
WaterfallDragLink = AceOO.Class(WaterfallControl)
WaterfallButton = AceOO.Class(WaterfallControl)
WaterfallHeading = AceOO.Class(WaterfallControl)
WaterfallTextBox = AceOO.Class(WaterfallControl)
WaterfallSlider = AceOO.Class(WaterfallControl)
WaterfallColorSwatch = AceOO.Class(WaterfallControl)
WaterfallDropdown = AceOO.Class(WaterfallControl)
WaterfallKeybinding = AceOO.Class(WaterfallControl)

--the left side treeview pane
WaterfallTreeView = AceOO.Class(FramePassthrough)
WaterfallTreeLine = AceOO.Class(FramePassthrough)
WaterfallTreeSection = AceOO.Class(FramePassthrough)

---------------------------
-- Waterfall Frame Class --
---------------------------

local function frameOnClose(this)
	this.obj.lib:Close(this.obj.id)
end

local function closeOnClick(this)
	this.obj:Hide()
end

local function frameOnMouseDown(this)
	this:GetParent():StartMoving()
end

local function frameOnMouseUp(this)
	this:GetParent():StopMovingOrSizing()
end

local function sizerseOnMouseDown(this)
	this:GetParent():StartSizing("BOTTOMRIGHT")
end

local function sizersOnMouseDown(this)
	this:GetParent():StartSizing("BOTTOM")
end

local function sizereOnMouseDown(this)
	this:GetParent():StartSizing("RIGHT")
end

local function sizerOnMouseUp(this)
	this:GetParent():StopMovingOrSizing()
end


function WaterfallFrame.prototype:init()
	WaterfallFrame.super.prototype.init(self)
	local frame = CreateFrame("Frame",nil,UIParent)
	self.frame = frame
	frame.obj = self
	frame:SetWidth(550)
	frame:SetHeight(500)
	frame:SetPoint("CENTER",UIParent,"CENTER",0,0)
	frame:EnableMouse()
	frame:SetMovable(true)
	frame:SetResizable(true)
	frame:SetMinResize(500,300)
	frame:SetFrameLevel(1)
	frame:SetFrameStrata("DIALOG")

	frame:SetBackdrop(FrameBackdrop)
	frame:SetBackdropColor(0,0,0)
	frame:SetScript("OnHide",frameOnClose)

	local titlebar = frame:CreateTexture(nil,"BACKGROUND")
	self.titlebar = titlebar
	local titlebar2 = frame:CreateTexture(nil,"BACKGROUND")
	self.titlebar2 = titlebar2
	local r,g,b = 1, 0.6, 0
	self.colorR = r
	self.colorG = g
	self.colorB = b

	titlebar:SetPoint("TOPLEFT",frame,"TOPLEFT",3,-4)
	titlebar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",-3,-4)
	titlebar:SetHeight(13)

	titlebar2:SetPoint("TOPLEFT",titlebar,"BOTTOMLEFT",0,0)
	titlebar2:SetPoint("TOPRIGHT",titlebar,"BOTTOMRIGHT",0,0)
	titlebar2:SetHeight(13)

	titlebar:SetGradientAlpha("VERTICAL",r*0.6,g*0.6,b*0.6,1,r,g,b,1)
	titlebar:SetTexture(r,g,b,1)
	titlebar2:SetGradientAlpha("VERTICAL",r*0.9,g*0.9,b*0.9,1,r*0.6,g*0.6,b*0.6,1)
	titlebar2:SetTexture(r,g,b,1)

	local closebutton = CreateFrame("Button",nil,frame,"UIPanelCloseButton")
	closebutton:SetScript("OnClick", closeOnClick)
	closebutton:SetPoint("TOPRIGHT",frame,"TOPRIGHT",-2,-2)

	self.closebutton = closebutton
	closebutton.obj = self

	local title = CreateFrame("Frame",nil,frame)
	self.title = title
	title:EnableMouse()
	title:SetScript("OnMouseDown",frameOnMouseDown)
	title:SetScript("OnMouseUp", frameOnMouseUp)


	title:SetPoint("TOPLEFT",titlebar,"TOPLEFT",0,0)
	title:SetPoint("BOTTOMRIGHT",titlebar2,"BOTTOMRIGHT",0,0)

	local titletext = title:CreateFontString(nil,"OVERLAY","QuestTitleFont")
	titletext:SetPoint("TOPLEFT",title,"TOPLEFT",0,0)
	titletext:SetPoint("TOPRIGHT",title,"TOPRIGHT",0,0)
	titletext:SetHeight(26)
	titletext:SetShadowColor(0,0,0)
	titletext:SetShadowOffset(1,-1)
	titletext:SetTextColor(1,1,1)

	self.titletext = titletext

	local sizer_se = CreateFrame("Frame",nil,frame)
	sizer_se:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",0,0)
	sizer_se:SetWidth(25)
	sizer_se:SetHeight(25)
	sizer_se:EnableMouse()
	sizer_se:SetScript("OnMouseDown",sizerseOnMouseDown)
	sizer_se:SetScript("OnMouseUp", sizerOnMouseUp)
	self.sizer_se = sizer_se

	local sizer_s = CreateFrame("Frame",nil,frame)
	sizer_s:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-25,0)
	sizer_s:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",0,0)
	sizer_s:SetHeight(25)
	sizer_s:EnableMouse()
	sizer_s:SetScript("OnMouseDown",sizersOnMouseDown)
	sizer_s:SetScript("OnMouseUp", sizerOnMouseUp)
	self.sizer_s = sizer_s

	local sizer_e = CreateFrame("Frame",nil,frame)
	sizer_e:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",0,25)
	sizer_e:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,0)
	sizer_e:SetWidth(25)
	sizer_e:EnableMouse()
	sizer_e:SetScript("OnMouseDown",sizereOnMouseDown)
	sizer_e:SetScript("OnMouseUp", sizerOnMouseUp)
	self.sizer_e = sizer_e

	local treeview = WaterfallTreeView:new(self)
	self.treeview = treeview
	treeview:SetPoint("TOPLEFT",frame,"TOPLEFT",11,-32)
	treeview:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",11,10)
	treeview:SetWidth(200)
	treeview:SetMinResize(200,0)
	treeview:SetMaxResize(400,10000)

	local mainpane = WaterfallPane:new(self)

	mainpane:SetPoint("TOPLEFT",treeview.frame,"TOPRIGHT",-3,0)
	mainpane:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-10,10)
	self.mainpane = mainpane

end

function WaterfallFrame.prototype:SetColor(r,g,b)
	self.colorR, self.colorG, self.colorB = r,g,b
	local titlebar = self.titlebar
	local titlebar2 = self.titlebar2
	titlebar:SetGradientAlpha("VERTICAL",r*0.6,g*0.6,b*0.6,1,r,g,b,1)
	titlebar:SetTexture(r,g,b,1)
	titlebar2:SetGradientAlpha("VERTICAL",r*0.9,g*0.9,b*0.9,1,r*0.6,g*0.6,b*0.6,1)
	titlebar2:SetTexture(r,g,b,1)
	self.mainpane:SetColor(r,g,b)
end

function WaterfallFrame.prototype:GetColor()
	return self.colorR, self.colorG, self.colorB
end

function WaterfallFrame.prototype:Hide()
	self.frame:Hide()
end

function WaterfallFrame.prototype:Show()
	self.frame:Show()
end

function WaterfallFrame.prototype:SetID(id)
	self.id = id
end

function WaterfallFrame.prototype:ChangePane(newpane)
	self.mainpane:Clear(newpane)
	self.controlcount = 0
	currentframe = self
	if self.children then
		local title = self.children(newpane, self.childrenArg)
		self.mainpane.titletext:SetText(title)
	end
	currentframe = nil
	self.mainpane:DoLayout()
	self.mainpane.paneid = newpane
end

function WaterfallFrame.prototype:SetSelected(id, noupdate)
	self.treeview:SetSelected(id, noupdate)
end

function WaterfallFrame.prototype:SetTitle(title)
	self.titletext:SetText(title)
end

function WaterfallFrame.prototype:SetChildren(children, arg)
	self.children = children
	self.childrenArg = arg
end
function WaterfallFrame.prototype:SetTree(tree, treestatus, func, ...)
	self.treeview:SetContent(tree, treestatus, func, ...)
end

function WaterfallFrame.prototype:AddControl(control)
	self.mainpane:AddControl(control)
end

function WaterfallFrame.prototype:Refresh()
	self.treeview:Refresh()
	self:ChangePane(self.treeview:GetSelected())
end

function WaterfallFrame.prototype:CleanUp()
	self.children = nil
	self.tree = nil
	self.treeview:CleanUp()
	self:ChangePane()
	self:Hide()
end

function WaterfallFrame.prototype:ReAnchorTree()
	self.treeview:SetPoint("TOPLEFT",self.frame,"TOPLEFT",11,-32)
	self.treeview:SetPoint("BOTTOMLEFT",self.frame,"BOTTOMLEFT",11,10)
end
-------------------------
-- WaterfallPane Class --
-------------------------

local function paneOnSizeChanged(this)
	this.obj:SizeChanged()
end
local function paneOnMouseWheel(this,value)
	this.obj:MoveScroll(value)
end
local function paneOnSizeChanged(this)
	this.obj:DoLayout()
end
local function paneOnScrollValueChanged(this,value)
	this.obj:SetScroll(value)
end
local numpanes = 0
function WaterfallPane.prototype:init(parent)
	WaterfallPane.super.prototype.init(self)
	numpanes = numpanes + 1
	self.parent = parent
	local name = "WaterfallPane"..numpanes
	local frame = CreateFrame("Frame",name,parent.frame)
	frame:SetBackdrop(PaneBackdrop)
	frame:SetBackdropBorderColor(0.6, 0.6, 0.6)
	frame:SetBackdropColor(0.1, 0.1, 0.1)
	frame:SetFrameLevel(2)
	frame:SetFrameStrata("DIALOG")
	self.frame = frame
	frame.obj = self
	frame:SetScript("OnSizeChanged",paneOnSizeChanged)

	--local title = CreateFrame("Frame",nil,frame)
	--title:SetPoint("TOPLEFT",frame,"TOPLEFT",4,-4)
	--title:SetPoint("TOPRIGHT",frame,"TOPRIGHT",-4,-4)
	--title:SetHeight(24)
	--title:SetBackdrop(PaneBackdrop)
	--title:SetBackdropColor(0,0,0,0.2)
	--self.title = title

	local scrollframe = CreateFrame("ScrollFrame",nil,frame)
	local scrollchild = CreateFrame("Frame",nil,scrollframe)
	local scrollbar = CreateFrame("Slider",name.."ScrollBar",scrollframe,"UIPanelScrollBarTemplate")
	self.scrollframe = scrollframe
	self.scrollchild = scrollchild
	self.scrollbar = scrollbar

	scrollframe:SetScrollChild(scrollchild)
	scrollframe:SetPoint("TOPLEFT",frame,"TOPLEFT",9,-29)
	scrollframe:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-28,12)
	scrollframe:EnableMouseWheel(true)
	scrollframe:SetScript("OnMouseWheel", paneOnMouseWheel)
	scrollframe:SetScript("OnSizeChanged", paneOnSizeChanged)
	scrollframe.obj = self

	--scrollchild:SetPoint("TOP",scrollframe,"TOP",-20,0)
	--scrollchild:SetPoint("BOTTOMLEFT",scrollframe,"BOTTOMLEFT",0,0)
	scrollchild:SetWidth(400)

	scrollbar:SetPoint("TOPLEFT",scrollframe,"TOPRIGHT",0,-16)
	scrollbar:SetPoint("BOTTOMLEFT",scrollframe,"BOTTOMRIGHT",0,16)
	scrollbar:SetMinMaxValues(0,1000)
	scrollbar:SetValueStep(1)
	scrollbar:SetValue(0)
	scrollbar:SetWidth(16)
	scrollbar:SetScript("OnValueChanged", paneOnScrollValueChanged)
	scrollbar.obj = self
	self.scrollvalue = 0

	local titletext = frame:CreateFontString(nil,"OVERLAY","GameFontNormal")
	titletext:SetPoint("TOPLEFT",frame,"TOPLEFT",8,-5)
	titletext:SetPoint("TOPRIGHT",frame,"TOPRIGHT",-8,-5)
	titletext:SetHeight(16)
	titletext:SetText("")
	titletext:SetTextColor(1,1,1)

	local r,g,b = 1, 0.6, 0
	self.colorR = r
	self.colorG = g
	self.colorB = b
	local titlebar = frame:CreateTexture(nil,"BACKGROUND")
	self.titlebar = titlebar
	local titlebar2 = frame:CreateTexture(nil,"BACKGROUND")
	self.titlebar2 = titlebar2
	titlebar:SetPoint("TOPLEFT",frame,"TOPLEFT",4,-4)
	titlebar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",-4,-4)
	titlebar:SetHeight(10)
	titlebar2:SetPoint("TOPLEFT",titlebar,"BOTTOMLEFT",0,0)
	titlebar2:SetPoint("TOPRIGHT",titlebar,"BOTTOMRIGHT",0,0)
	titlebar2:SetHeight(10)

	titlebar:SetGradientAlpha("VERTICAL",r*0.6,g*0.6,b*0.6,1,r,g,b,1)
	titlebar:SetTexture(r,g,b,1)
	titlebar2:SetGradientAlpha("VERTICAL",r*0.9,g*0.9,b*0.9,1,r*0.6,g*0.6,b*0.6,1)
	titlebar2:SetTexture(r,g,b,1)

	--titletext:SetTextColor(1,1,1)
	self.titletext = titletext

	self.controls = {}
end

function WaterfallPane.prototype:GetID()
	return self.parent.id
end

function WaterfallPane.prototype:SetScroll(value)
	local frame, child = self.scrollframe, self.scrollchild
	local viewheight = frame:GetHeight()
	local height = child:GetHeight()
	local width, viewwidth = frame:GetWidth(), child:GetWidth()
	local offset
	local xOffset = max(0, (width-viewwidth)/2 )
	if viewheight > height then
		offset = 0
	else
		offset = floor((height - viewheight) / 1000.0 * value)
	end
	child:ClearAllPoints()
	child:SetPoint("TOPLEFT",frame,"TOPLEFT",xOffset,offset)
	child.offset = offset

	self.scrollvalue = value
end

--[[
horiz scrolling version
function WaterfallPane.prototype:SetScroll(value)
	local frame, child = self.scrollframe, self.scrollchild
	local viewheight = frame:GetWidth()
	local height = child:GetWidth()
	local offset
	if viewheight > height then
		offset = 0
	else
		offset = floor((height - viewheight) / 1000.0 * value)
	end
	child:ClearAllPoints()
	child:SetPoint("TOPLEFT",frame,"TOPLEFT",-offset,0)
	child:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",-offset,0)
	child.offset = offset

	self.scrollvalue = value
end
]]
function WaterfallPane.prototype:MoveScroll(value)
	local frame, child = self.scrollframe, self.scrollchild
	local height, viewheight = frame:GetHeight(), child:GetHeight()
	if height > viewheight then
		self.scrollbar:Hide()
	else
		self.scrollbar:Show()
		local diff = height - viewheight
		local delta = 1
		if value < 0 then
			delta = -1
		end
		self.scrollbar:SetValue(min(max(self.scrollvalue + delta*(1000/(diff/45)),0), 1000))
	end
end

function WaterfallPane.prototype:SetColor(r,g,b)
	self.colorR, self.colorG, self.colorB = r,g,b
	local titlebar = self.titlebar
	local titlebar2 = self.titlebar2
	titlebar:SetGradientAlpha("VERTICAL",r*0.6,g*0.6,b*0.6,1,r,g,b,1)
	titlebar:SetTexture(r,g,b,1)
	titlebar2:SetGradientAlpha("VERTICAL",r*0.9,g*0.9,b*0.9,1,r*0.6,g*0.6,b*0.6,1)
	titlebar2:SetTexture(r,g,b,1)
end

function WaterfallPane.prototype:Clear(newpane)
	for i = 1, #self.controls do
		releaseObj(self.controls[i])
		self.controls[i] = nil
	end
	if self.paneid ~= newpane then
		self:SetScroll(0)
	end
end

function WaterfallPane.prototype:ClearFocus()
    for i, v in ipairs(self.controls) do
        if v.class == WaterfallTextBox then
            v.frame:ClearFocus()
        end
    end
end

function WaterfallPane.prototype:AddControl(control)
	tinsert(self.controls, control)
	control:SetParent(self)
end

--simple one under the other layout for now
function WaterfallPane.prototype:DoLayout()
	local usedheight = 0
	local maxwidth = 0
	local rowwidth = 1
	local rowheight = 1
	for i, control in ipairs(self.controls) do
			control:ClearAllPoints()
			if i == 1 then
					control:SetPoint("TOPLEFT",self.scrollchild,"TOPLEFT",10,0)
					rowheight = control:GetHeight()
					rowwidth = control:GetWidth() + 10
			else
				if control.noNewLine then
					control:SetPoint("TOPLEFT",self.controls[i-1],"TOPRIGHT",0,0)
					rowheight = max(rowheight,control:GetHeight())
					rowwidth = rowwidth + control:GetWidth()
				else
					usedheight = usedheight + rowheight
					maxwidth = max(rowwidth,maxwidth)
					control:SetPoint("TOPLEFT",self.scrollchild,"TOPLEFT",10,-usedheight)
					rowheight = control:GetHeight()
					rowwidth = control:GetWidth()
				end
			end
			control:Show()
	end
	maxwidth = max(rowwidth,maxwidth)

	self.scrollchild:SetHeight(usedheight+rowheight)
	self.scrollchild:SetWidth(maxwidth+5)

	self:FixScroll()
end

--[[
function WaterfallPane.prototype:DoLayout()
	local colheight = 0
	local sectionheight = 0
	local sectionwidth = 0
	local colwidth = 0
	local usedwidth = 0
	local frameheight = self.scrollchild:GetHeight()
	for i, control in ipairs(self.controls) do
		colheight = colheight + control:GetHeight()
		colwidth = max(colwidth, control:GetWidth())
		control:ClearAllPoints()
		if colheight <= (frameheight - 10) then
			if i == 1 then
				control:SetPoint("TOPLEFT",self.scrollchild,"TOPLEFT",4,0)
			else
				control:SetPoint("TOPLEFT",self.controls[i-1],"BOTTOMLEFT",0,0)
			end
		else
			usedwidth = usedwidth + colwidth + 6
			colwidth = 0
			colheight = 0
			control:SetPoint("TOPLEFT",self.scrollchild,"TOPLEFT",4+usedwidth,0)
		end
		control:Show()
	end
	usedwidth = usedwidth + colwidth

	self.scrollchild:SetWidth(usedwidth)
	self:FixScroll()
end
]]
function WaterfallPane.prototype:SizeChanged()
	self:FixScroll()
end

function WaterfallPane.prototype:FixScroll()
	local frame, child = self.scrollframe, self.scrollchild
	local height, viewheight = frame:GetHeight(), child:GetHeight()
	local width, viewwidth = frame:GetWidth(), child:GetWidth()
	local offset = self.scrollchild.offset
	if not offset then
		offset = 0
	end
	local curvalue = self.scrollbar:GetValue()
	local xOffset = max(0, (width-viewwidth)/2 )
	if viewheight < height then
		self.scrollbar:Hide()
		--self.scrollbar:SetValue(0)
		child:ClearAllPoints()
		child:SetPoint("TOPLEFT",frame,"TOPLEFT",xOffset,0)
		child.offset = 0
	else
		self.scrollbar:Show()
		local value = (offset / (viewheight - height) * 1000)
		if value > 1000 then value = 1000 end
		self.scrollbar:SetValue(value)
		self:SetScroll(value)
		if value < 1000 then
			child:ClearAllPoints()
			child:SetPoint("TOPLEFT",frame,"TOPLEFT",xOffset,offset)
			child.offset = offset
		end
	end
end
--[[
horiz scrolling version
function WaterfallPane.prototype:FixScroll()
	local frame, child = self.scrollframe, self.scrollchild
	local height, viewheight = frame:GetWidth(), child:GetWidth()
	local offset = self.scrollchild.offset
	if not offset then
		offset = 0
	end
	local curvalue = self.scrollbar:GetValue()

	if viewheight < height then
		self.scrollbar:EnableMouse(false)
		self.scrollbar:SetValue(0)
	else
		self.scrollbar:EnableMouse(true)
		local value = (offset / (viewheight - height) * 1000)
		if value > 1000 then value = 1000 end
		self.scrollbar:SetValue(value)
		self:SetScroll(value)
		if value < 1000 then
			child:ClearAllPoints()
			child:SetPoint("TOPLEFT",frame,"TOPLEFT",-offset,0)
			child:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",-offset,0)
			child.offset = offset
		end
	end
end
]]
function WaterfallPane.prototype:Refresh(fullRefresh)
	if fullRefresh then
		self.parent:Refresh()
	else
		for i, control in ipairs(self.controls) do
			control:Refresh()
		end
	end
	self:FixScroll()
end

-----------------
-- Label Class --
-----------------

function WaterfallLabel.prototype:init()
	WaterfallLabel.super.prototype.init(self)
	local frame = self.frame
	local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	self.text = text
	frame.text = text

	text:SetText("Waterfalllabel")
	text:SetJustifyH("LEFT")
	text:SetTextColor(1,1,1)
	frame:SetHeight(24)
	frame:SetWidth(DEFAULT_CONTROL_WIDTH)
	text:SetHeight(16)
	text:SetPoint("LEFT",frame,"LEFT")
end

--fontstrings dont return the correct width untill they have been drawn, wait a frame to set the width
local function labelFixWidth(this)
	if not this.obj.width then
		this:SetWidth(this.text:GetWidth()+3)
	end
	this:SetScript("OnUpdate",nil)
end

function WaterfallLabel.prototype:SetText(text)
	self.text:SetText(text)
	self:Refresh()
end

function WaterfallLabel.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self:SetText("")
end

function WaterfallLabel.prototype:Refresh()
	self.frame:SetHeight(self.height or 16)
	if self.width then
		self.text:ClearAllPoints()
		self.text:SetPoint("LEFT",self.frame,"LEFT")
		self.text:SetPoint("RIGHT",self.frame,"RIGHT")
		self:SetWidth(self.width)
	else
		self.text:ClearAllPoints()
		self.text:SetPoint("LEFT")
		self.frame:SetScript("OnUpdate", labelFixWidth)
	end
	self.text:SetJustifyH(self.justifyH or "LEFT")
	self.text:SetTextColor(self.r or 1, self.g or 1, self.b or 1)
end

-----------------
-- Linklabel Class --
-----------------
local function Linklabel_OnEnter(this)
	local self = this.obj
	if not self.disabled then
		self.highlight:Show()
		showGameTooltip(self)
	end
end

local function Linklabel_OnLeave(this)
	this.obj.highlight:Hide()
	GameTooltip:Hide()
end

local function linkConfirmFunc(self, refresh, full, func, ...)
	func(...)

	if refresh or full then
		self.parent:Refresh(full)
	end
end

local function Linklabel_OnClick(this)
	local self = this.obj
	local func = self.linkFunc
	local confirm = this.obj.confirm

	if func then
		if confirm then
			if type(confirm) == "string" then
				confirmPopup(confirm,linkConfirmFunc,self,self.causesRefresh,self.fullRefresh,func,getArgs(this.obj,"linkArg",1))
			else
				confirmPopup((ARE_YOU_SURE):format(this.obj.text:GetText()),linkConfirmFunc,
					self,self.causesRefresh,self.fullRefresh,func,getArgs(this.obj,"linkArg",1))
			end
		else
			func(getArgs(this.obj,"linkArg",1))
		end
		if self.causesRefresh or self.fullRefresh then
			self.parent:Refresh(self.fullRefresh)
		end
	end
end

function WaterfallLinklabel.prototype:init()
	WaterfallLinklabel.super.prototype.init(self, "Button")
	local frame = self.frame
	local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	self.text = text
	frame.text = text
	frame:SetScript("OnClick", Linklabel_OnClick)
	frame:SetScript("OnEnter", Linklabel_OnEnter)
	frame:SetScript("OnLeave", Linklabel_OnLeave)

	text:SetText("WaterfallLinklabel")
	text:SetJustifyH("LEFT")
	text:SetTextColor(1,1,1)
	frame:SetHeight(24)
	frame:SetWidth(DEFAULT_CONTROL_WIDTH)
	text:SetHeight(16)
	text:SetPoint("LEFT",frame,"LEFT")

	local highlight = frame:CreateTexture(nil, "BACKGROUND")
	self.highlight = highlight
	highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	highlight:SetBlendMode("ADD")
	highlight:SetAllPoints(frame)
	highlight:Hide()

	frame:EnableMouse()
end

function WaterfallLinklabel.prototype:SetText(text)
	self.text:SetText(text)
	self:Refresh()
end

function WaterfallLinklabel.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self:SetText("")
end

function WaterfallLinklabel.prototype:Refresh()
	self.frame:SetHeight(self.height or 16)

	if self.width then
		self.text:ClearAllPoints()
		self.text:SetPoint("LEFT",self.frame,"LEFT")
		self.text:SetPoint("RIGHT",self.frame,"RIGHT")
		self:SetWidth(self.width)
	else
		self.text:ClearAllPoints()
		self.text:SetPoint("LEFT")
		self.frame:SetScript("OnUpdate", labelFixWidth)
	end
	self.text:SetJustifyH(self.justifyH or "LEFT")
	self.text:SetTextColor(self.r or 1, self.g or 1, self.b or 1)
end

function WaterfallLinklabel.prototype:SetColor(r,g,b)
	self.r = r
	self.g = g
	self.b = b
	self:Refresh()
end

-----------------
-- ColorSwatch Class --
-----------------
local tmpt = setmetatable({}, {mode='v'})
local function ColorSwatch_OnClick(this)
	local self = this.obj
	if not self.disabled then
		local func = self.setFunc
		local hasOpacity = self.hasOpacity

		for k in pairs(tmpt) do
			tmpt[k] = nil
		end
		for i = 1, 1000 do
			local x = self['setArg'..i]
			if x == nil then
				break
			else
				tmpt[i] = x
			end
		end
		ColorPickerFrame.func = function()
			if func then
				local r,g,b = ColorPickerFrame:GetColorRGB()
				local a = hasOpacity and 1 - OpacitySliderFrame:GetValue() or nil
				local n = #tmpt
				tmpt[n+1] = r
				tmpt[n+2] = g
				tmpt[n+3] = b
				tmpt[n+4] = a
				func(unpack(tmpt))
				self:SetColor(r,g,b,a)
				tmpt[n+1] = nil
				tmpt[n+2] = nil
				tmpt[n+3] = nil
				tmpt[n+4] = nil
				if self.causesRefresh or self.fullRefresh then
					self.parent:Refresh(self.fullRefresh)
				end
			end
		end
		ColorPickerFrame.hasOpacity = self.hasOpacity
		ColorPickerFrame.opacityFunc = ColorPickerFrame.func
		ColorPickerFrame.opacity = 1 - (self.opacity or 0)
		ColorPickerFrame:SetColorRGB(self.r, self.g, self.b)
		local r, g, b, a = self.r, self.g, self.b, self.opacity
		ColorPickerFrame.cancelFunc = function()
			if func then
				local n = #tmpt
				tmpt[n+1] = r
				tmpt[n+2] = g
				tmpt[n+3] = b
				tmpt[n+4] = a
				func(unpack(tmpt))
				self:SetColor(r,g,b,a)
				for i = 1, n+4 do
					tmpt[i] = nil
				end
			end
		end
		ShowUIPanel(ColorPickerFrame)
	end
end

local function ColorSwatch_OnEnter(this)
	local self = this.obj
	if not self.disabled then
		self.highlight:Show()
		showGameTooltip(self)
	end
end

local function ColorSwatch_OnLeave(this)

	this.obj.highlight:Hide()
	GameTooltip:Hide()
end

function WaterfallColorSwatch.prototype:init()
	WaterfallColorSwatch.super.prototype.init(self,"Button")
	local frame = self.frame

	local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	self.text = text
	text:SetJustifyH("LEFT")
	text:SetTextColor(1,1,1)
	frame:SetHeight(24)
	frame:SetWidth(DEFAULT_CONTROL_WIDTH)
	text:SetHeight(24)
	frame:SetScript("OnClick", ColorSwatch_OnClick)
	frame:SetScript("OnEnter",ColorSwatch_OnEnter)
	frame:SetScript("OnLeave",ColorSwatch_OnLeave)

	local colorSwatch = frame:CreateTexture(nil, "OVERLAY")
	self.colorSwatch = colorSwatch
	colorSwatch:SetWidth(24)
	colorSwatch:SetHeight(24)
	colorSwatch:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
	local texture = frame:CreateTexture(nil, "OVERLAY")
	colorSwatch.texture = texture
	texture:SetTexture(1, 1, 1)
	texture:SetWidth(13.8)
	texture:SetHeight(13.8)
	texture:Show()

	local highlight = frame:CreateTexture(nil, "BACKGROUND")
	self.highlight = highlight
	highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	highlight:SetBlendMode("ADD")
	highlight:SetAllPoints(frame)
	highlight:Hide()

	texture:SetPoint("CENTER", colorSwatch, "CENTER")
	colorSwatch:SetPoint("LEFT", frame, "LEFT", 0, 0)
	text:SetPoint("LEFT",colorSwatch,"RIGHT",2,0)
	text:SetPoint("RIGHT",frame,"RIGHT")
end

function WaterfallColorSwatch.prototype:SetText(text)
	self.text:SetText(text)
end

function WaterfallColorSwatch.prototype:SetColor(r,g,b,a)
	self.r = r
	self.g = g
	self.b = b
	self.opacity = a
	self:Refresh()
end

function WaterfallColorSwatch.prototype:Refresh()
	if self.getFunc then
		self.r, self.g, self.b, self.opacity = self.getFunc(getArgs(self,"getArg",1))
	end
	if self.disabledFunc then
		self.disabled = self.disabledFunc(getArgs(self,"disabledArg",1))
		if self.inverseDisabled then
			self.disabled = not self.disabled
		end
	end
	self.colorSwatch.texture:SetTexture(self.r,self.g,self.b)
	if self.disabled then
		self.text:SetTextColor(0.5,0.5,0.5)
	else
		self.text:SetTextColor(1,1,1)
	end
	if self.width then
		self:SetWidth(self.width)
	else
		self:SetWidth(DEFAULT_CONTROL_WIDTH)
	end
end

function WaterfallColorSwatch.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self:SetText("")
	self:SetFunc("color",nil)
	self.r = nil
	self.g = nil
	self.b = nil
	self.hasOpacity = nil
	self.opacity = nil
	self.disabled = nil
	self:SetFunc("disabled",nil)
end



-----------------
-- Heading Class --
-----------------

function WaterfallHeading.prototype:init()
	WaterfallHeading.super.prototype.init(self)
	local frame = self.frame
	local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormal")
	self.text = text
	frame.text = text

	text:SetJustifyH("LEFT")
	frame:SetHeight(24)
	frame:SetWidth(DEFAULT_CONTROL_WIDTH)
	text:SetHeight(24)
	text:SetPoint("LEFT",frame,"LEFT")
end

function WaterfallHeading.prototype:SetText(text)
	self.text:SetText(text)
	self.frame:SetScript("OnUpdate", labelFixWidth)
end

function WaterfallHeading.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self:SetText("")
end

function WaterfallHeading.prototype:Refresh()
	self.frame:SetHeight(self.height or 16)
	if self.width then
		self.text:ClearAllPoints()
		self.text:SetPoint("LEFT",self.frame,"LEFT")
		self.text:SetPoint("RIGHT",self.frame,"RIGHT")
		self:SetWidth(self.width)
	else
		self.text:ClearAllPoints()
		self.text:SetPoint("LEFT")
		self.frame:SetScript("OnUpdate", labelFixWidth)
	end
	self.text:SetJustifyH(self.justifyH or "LEFT")
end
-----------------
-- CheckBox Class --
-----------------

local function CheckBox_OnEnter(this)
	local self = this.obj
	if not self.disabled then
		self.highlight:Show()
		showGameTooltip(self)
	end
end

local function CheckBox_OnLeave(this)
	local self = this.obj
	if not self.down then
		self.highlight:Hide()
	end
	GameTooltip:Hide()
end

local function CheckBox_OnMouseUp(this)
	local self = this.obj
	if not self.disabled then
		self:ToggleChecked()
		self.text:SetPoint("LEFT",self.check,"RIGHT",0,0)
	end
	self.down = nil
end

local function CheckBox_OnMouseDown(this)
	local self = this.obj
	if not self.disabled then
		self.text:SetPoint("LEFT",self.check,"RIGHT",1,-1)
		self.down = true
	end
end

function WaterfallCheckBox.prototype:init()
	WaterfallCheckBox.super.prototype.init(self,"Button")

	local frame = self.frame
	local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	self.text = text

	frame:SetScript("OnEnter",CheckBox_OnEnter)
	frame:SetScript("OnLeave",CheckBox_OnLeave)
	frame:SetScript("OnMouseUp",CheckBox_OnMouseUp)
	frame:SetScript("OnMouseDown",CheckBox_OnMouseDown)
	frame:EnableMouse()
	local checkbg = frame:CreateTexture(nil,"ARTWORK")
	self.checkbg = checkbg
	checkbg:SetWidth(20)
	checkbg:SetHeight(20)
	checkbg:SetPoint("LEFT",frame,"LEFT",0,0)
	checkbg:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
	local check = frame:CreateTexture(nil,"OVERLAY")
	self.check = check
	check:SetWidth(20)
	check:SetHeight(20)
	check:SetPoint("LEFT",frame,"LEFT",0,0)
	check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")

	self:UpdateCheck()

	local highlight = frame:CreateTexture(nil, "BACKGROUND")
	self.highlight = highlight
	highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	highlight:SetBlendMode("ADD")
	highlight:SetAllPoints(frame)
	highlight:Hide()


	text:SetJustifyH("LEFT")
	text:SetTextColor(1,1,1)
	frame:SetHeight(24)
	frame:SetWidth(DEFAULT_CONTROL_WIDTH)
	text:SetHeight(24)
	text:SetPoint("LEFT",check,"RIGHT",0,0)
end

function WaterfallCheckBox.prototype:UpdateTexture()
	local checkbg = self.checkbg
	local check = self.check
	local highlight = self.highlight

	if self.isRadio then
		checkbg:SetTexture("Interface\\Buttons\\UI-RadioButton")
		checkbg:SetTexCoord(0,0.25,0,1)
		check:SetTexture("Interface\\Buttons\\UI-RadioButton")
		check:SetTexCoord(0.5,0.75,0,1)
		check:SetBlendMode("ADD")
	else
		checkbg:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
		checkbg:SetTexCoord(0,1,0,1)
		check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
		check:SetTexCoord(0,1,0,1)
		check:SetBlendMode("BLEND")
	end
end

function WaterfallCheckBox.prototype:SetText(text)
	self.text:SetText(text)
end

function WaterfallCheckBox.prototype:UpdateCheck()
	if self.checked then
		self.check:Show()
	else
		self.check:Hide()
	end
end

function WaterfallCheckBox.prototype:ToggleChecked()
	self.checked = not self.checked

	if self.setFunc then
		self.setFunc(getArgs(self,"setArg",1,self.checked))
	end

	if self.causesRefresh or self.fullRefresh then
		self.parent:Refresh(self.fullRefresh)
	else
		self:Refresh()
	end
end

function WaterfallCheckBox.prototype:SetChecked(value)
	self.checked = value
	self:UpdateCheck()
end

function WaterfallCheckBox.prototype:GetChecked()
	return self.checked
end

function WaterfallCheckBox.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.highlight:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self:SetText("")
	self:SetChecked(false)
	self:SetFunc("disabled",nil)
	self:SetFunc("get",nil)
	self:SetFunc("set",nil)
	self.isRadio = nil
end

function WaterfallCheckBox.prototype:Refresh()
	if self.getFunc then
		local checked = self.getFunc(getArgs(self,"getArg",1))
		self:SetChecked(checked)
	end
	if self.disabledFunc then
		self.disabled = self.disabledFunc(getArgs(self,"disabledArg",1))
		if self.inverseDisabled then
			self.disabled = not self.disabled
		end
	end
	if self.disabled then
		self.text:SetTextColor(0.5,0.5,0.5)
		SetDesaturation(self.check, true)
	else
		self.text:SetTextColor(1,1,1)
		SetDesaturation(self.check, false)
	end
	if self.width then
		self:SetWidth(self.width)
	else
		self:SetWidth(DEFAULT_CONTROL_WIDTH)
	end
	self:UpdateTexture()
end

-----------------
-- DragLink Class --
-----------------

-- Provides an icon and description of a link based on on its linkInfo.itemType, itemId, itemInfo
-- Dragging onto the linkIcon sets linkInfo.itemType, linkInfo.itemId, linkInfo.itemInfo
-- If linkInfo.itemType == "spell" then linkInfo.spellName, linkInfo.spellRank, linkInfo.spellClass (current player class) are also set
-- Dragging between two DragLink objects will swap their contents

function Waterfall:GetDraggingObject()
	return Waterfall.fromObject
end


function Waterfall:SetDraggingObject(fromObject)
	Waterfall.fromObject = fromObject
end

local function DragLinkOnDragStart(this)
	local fromObject = this.obj
	Waterfall:SetDraggingObject(fromObject)
end

local function DragLinkOnReceiveDrag(this)
	local self = this.obj
	local toObject = this.obj
	local fromObject = Waterfall:GetDraggingObject()
	local refreshNeeded = false
	if (fromObject and fromObject ~= toObject) then
--DEFAULT_CHAT_FRAME:AddMessage("DragLinkOnReceiveDrag toObject " .. tostring(toObject))
		fromObject.itemType, toObject.itemType = toObject.itemType, fromObject.itemType
		fromObject.itemId, toObject.itemId = toObject.itemId, fromObject.itemId
		fromObject.itemInfo, toObject.itemInfo = toObject.itemInfo, fromObject.itemInfo
		fromObject.spellName, toObject.spellName = toObject.spellName, fromObject.spellName
		fromObject.spellRank, toObject.spellRank = toObject.spellRank, fromObject.spellRank
		fromObject.spellClass, toObject.spellClass = toObject.spellClass, fromObject.spellClass
		if fromObject.causesRefresh or fromObject.fullRefresh then
			fromObject.parent:Refresh(fromObject.fullRefresh)
		end
		refreshNeeded = true
	else
		local itemType, itemId, itemInfo = GetCursorInfo()
--DEFAULT_CHAT_FRAME:AddMessage("DragLinkOnReceiveDrag itemType " .. tostring(itemType) .. " itemId " .. tostring(itemId) .. " itemInfo " .. tostring(itemInfo))
		if (itemType == "item" or itemType == "spell" or itemType == "macro") then
			local linkInfo = self.linkInfo
			linkInfo.itemType = itemType
			linkInfo.itemId = itemId
			linkInfo.itemInfo = itemInfo
			if (itemType == "spell") then
				local spellName, spellRank = GetSpellName(itemId, itemInfo)
				linkInfo.spellName = spellName
				linkInfo.spellRank = spellRank
				linkInfo.spellClass = WaterfallDragLink.CLASS
			else
				linkInfo.spellName = nil
				linkInfo.spellRank = nil
				linkInfo.spellClass = nil
			end
--DEFAULT_CHAT_FRAME:AddMessage("DragLinkOnReceiveDrag itemType " .. tostring(itemType) .. " itemId " .. tostring(itemId) .. " itemInfo " .. tostring(itemInfo))
--DEFAULT_CHAT_FRAME:AddMessage("DragLinkOnReceiveDrag self.setFunc " .. tostring(self.setFunc) .. " self.disabled " .. tostring(self.disabled))
			if (self.setFunc and not self.disabled) then
				self.setFunc(getArgs(self,"setArg",1,linkInfo))
			end
			refreshNeeded = true
			ClearCursor()
		end
	end

	if (refreshNeeded) then
		if self.causesRefresh or self.fullRefresh then
			self.parent:Refresh(self.fullRefresh)
		else
			self:Refresh()
		end
	end
	Waterfall:SetDraggingObject(nil)
end

local function DragLinkOnClick(this)
	DragLinkOnReceiveDrag(this)
end

local function DragLinkOnEnter(this)
	local self = this.obj
	local linkInfo = self.linkInfo
	if (linkInfo) then
		if (linkInfo.itemType == "item") then
			GameTooltip:SetOwner(this, "ANCHOR_PRESERVE")
			if (linkInfo.itemId) then
				GameTooltip:SetHyperlink("item:" .. linkInfo.itemId .. ":0:0:0:0:0:0:0")
			else
				GameTooltip:SetHyperlink(tostring(linkInfo.itemInfo))
			end
		elseif (linkInfo.itemType == "spell") then
			if (linkInfo.spellName) then
-- Cannot set this without preserving spell book & spell id.  Even then may be from different class.  So lame.  Awaiting a Blizzard API that doesnt suck.
--				GameTooltip:SetSpell(linkInfo.spellId, linkInfo.spellTab)
				GameTooltip:SetOwner(this, "ANCHOR_PRESERVE")
				GameTooltip:AddLine(linkInfo.spellName, 1, 1, 1)
				local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(linkInfo.spellName)
				if (name) then
					if (powerType == 0) then
						cost = tostring(cost) .. " " .. MANA
					elseif (powerType == 1) then
						cost = tostring(cost) .. " " .. RAGE
					elseif (powerType == 2) then
						cost = tostring(cost) .. " " .. FOCUS
					elseif (powerType == 3) then
						cost = tostring(cost) .. " " .. ENERGY
					elseif (powerType == 4) then
						cost = tostring(cost) .. " " .. HAPPINESS
					end
					local range = ""
					if (maxRange) then
						range = SPELL_RANGE:format(maxRange)
					end
					GameTooltip:AddDoubleLine(cost, range, 1, 1, 1, 1, 1, 1)
					if (castTime and castTime > 0) then
						GameTooltip:AddLine(SPELL_CAST_TIME_SEC:format(castTime), 1, 1, 1)
					else
						GameTooltip:AddLine(SPELL_CAST_TIME_INSTANT, 1, 1, 1)
					end
					if (rank) then
						GameTooltip:AddLine(tostring(rank))
					end
					GameTooltip:Show()
				end
			end
		elseif (linkInfo.itemType == "macro") then
			if (linkInfo.itemId) then
				local name, icon, body = GetMacroInfo(linkInfo.itemId)
				if (name) then
					GameTooltip:SetOwner(this, "ANCHOR_PRESERVE")
					GameTooltip:AddLine(tostring(name), 0.2, 0.8, 0.8, 1)
					GameTooltip:AddTexture(icon)
					GameTooltip:AddLine(tostring(body), 1, 1, 1, 1)
					GameTooltip:Show()
				end
			end
		end
	end
end

local function DragLinkOnLeave(this)
	GameTooltip:Hide()
end

local function DragLinkGetTexture(self)
	local linkInfo = self.linkInfo
	local texture
	if (linkInfo) then
		if (linkInfo.itemType == "item") then
			if (linkInfo.itemId and tonumber(linkInfo.itemId)) then
				_,_,_,_,_,_,_,_,_,texture = GetItemInfo(tonumber(linkInfo.itemId))
				if (texture) then
					return texture
				end
			end
		elseif (linkInfo.itemType == "spell") then
			if (linkInfo.spellName) then
				_, _, texture = GetSpellInfo(linkInfo.spellName)
				if (texture) then
					return texture
				end
			end
		elseif (linkInfo.itemType == "macro") then
			if (linkInfo.itemId) then
				_, texture = GetMacroInfo(linkInfo.itemId)
				if (texture) then
					return texture
				end
			end
		end
	end
	return "Interface\\Icons\\INV_Misc_Gift_01"
end

WaterfallDragLink.defaultIconSize = 36
_, WaterfallDragLink.CLASS = UnitClass("player") -- Use the capitalized english class name

function WaterfallDragLink.prototype:init()
	WaterfallDragLink.super.prototype.init(self, "Button")

	local frame = self.frame
	local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	self.text = text

	frame:SetScript("OnDragStart", DragLinkOnDragStart)
	frame:SetScript("OnReceiveDrag", DragLinkOnReceiveDrag)
	frame:SetScript("OnClick", DragLinkOnClick)
	frame:SetScript("OnEnter", DragLinkOnEnter)
	frame:SetScript("OnLeave", DragLinkOnLeave)

	frame:EnableMouse()
	frame:RegisterForDrag("LeftButton")
	frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	local linkIcon = frame:CreateTexture(nil, "OVERLAY")
	linkIcon:SetWidth(self.iconWidth or WaterfallDragLink.defaultIconSize)
	linkIcon:SetHeight(self.iconHeight or WaterfallDragLink.defaultIconSize)
	linkIcon:SetPoint("LEFT",frame,"LEFT",0,0)
	linkIcon:SetTexture(DragLinkGetTexture(self))
	linkIcon:SetTexCoord(0,1,0,1)
	linkIcon:Show()
	self.linkIcon = linkIcon

	text:SetJustifyH("LEFT")
	text:SetTextColor(1,1,1)

	frame:SetHeight(self.iconHeight or WaterfallDragLink.defaultIconSize + 4)
	frame:SetWidth(DEFAULT_CONTROL_WIDTH)

	text:SetHeight(self.iconHeight or WaterfallDragLink.defaultIconSize + 4)
	text:SetPoint("LEFT",check,"RIGHT",0,0)
end

function WaterfallDragLink.prototype:SetText(text)
	self.text:SetText(text)
end

function WaterfallDragLink.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self:SetText("")
	self:SetFunc("disabled", nil)
	self.linkIcon:Hide()
end

function WaterfallDragLink.prototype:Refresh()
	if self.disabledFunc then
		self.disabled = self.disabledFunc(getArgs(self,"disabledArg",1))
		if self.inverseDisabled then
			self.disabled = not self.disabled
		end
	end
	if self.disabled then
		self.frame:Disable()
	else
		self.frame:Enable()
	end
	if self.width then
		self:SetWidth(self.width)
	else
		self:SetWidth(DEFAULT_CONTROL_WIDTH)
	end
	if (not self.linkIcon) then
		local linkIcon = self.frame:CreateTexture(nil, "OVERLAY")
		linkIcon:SetWidth(self.iconWidth or WaterfallDragLink.defaultIconSize)
		linkIcon:SetHeight(self.iconHeight or WaterfallDragLink.defaultIconSize)
		linkIcon:SetPoint("TOP", self.frame, "TOP", 0, 0)
		linkIcon:SetTexCoord(0,1,0,1)
		linkIcon:Show()
		self.linkIcon = linkIcon
	end
	if self.getFunc then
		self.linkInfo = self.getFunc(getArgs(self,"getArg",1))
	else
		assert(self.linkInfo, "wth?")
	end
	self.linkIcon:SetTexture(DragLinkGetTexture(self))
	self.linkIcon:Show()
	if (self.linkInfo.itemId) then
		self:SetText((self.linkInfo.itemInfo or "") .. " (" .. tostring(self.linkInfo.itemId) .. ")")
	else
		self:SetText("")
	end
--DEFAULT_CHAT_FRAME:AddMessage("WaterfallDragLink.prototype:Refresh texture " .. tostring(DragLinkGetTexture(self)) .. " self.linkInfo.itemId " .. tostring(self.linkInfo.itemId) .. " self.linkInfo.itemInfo " .. tostring(self.linkInfo.itemInfo))
end

-----------------
-- Button Class --
-----------------
local function buttonConfirmFunc(self, refresh, full, func, ...)
	func(...)

	if refresh or full then
		self.parent:Refresh(full)
	end
end

local function Button_OnClick(this)
	local self = this.obj
	local func = self.execFunc
	local confirm = this.obj.confirm
	if func then
		if confirm then
			if type(confirm) == "string" then
				confirmPopup(confirm,buttonConfirmFunc,self,self.causesRefresh,self.fullRefresh,func,getArgs(this.obj,"execArg",1))
			else
				confirmPopup((ARE_YOU_SURE):format(this.obj.frame:GetText()),buttonConfirmFunc,
					self,self.causesRefresh,self.fullRefresh,func,getArgs(this.obj,"execArg",1))
			end
		else
			func(getArgs(this.obj,"execArg",1))
		end
		if self.causesRefresh or self.fullRefresh then
			self.parent:Refresh(self.fullRefresh)
		end
	end
end

local function Control_OnEnter(this)
	if this.obj.link then
		GameTooltip:SetOwner(this, "ANCHOR_PRESERVE")
		GameTooltip:SetHyperlink(this.obj.link)
	else
		showGameTooltip(this.obj)
	end
end

local function Control_OnLeave(this)
	GameTooltip:Hide()
end

function WaterfallButton.prototype:init()
	WaterfallButton.super.prototype.init(self,"Button","UIPanelButtonTemplate")
	local frame = self.frame
	--local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	local text = frame:GetFontString()
	text:SetPoint("LEFT",frame,"LEFT",7,0)
	text:SetPoint("RIGHT",frame,"RIGHT",-7,0)

	frame:SetScript("OnClick",Button_OnClick)
	frame:SetScript("OnEnter",Control_OnEnter)
	frame:SetScript("OnLeave",Control_OnLeave)

	frame:EnableMouse()

	frame:SetHeight(24)
	frame:SetWidth(DEFAULT_CONTROL_WIDTH)

end

function WaterfallButton.prototype:SetText(text)
	self.frame:SetText(text)
end

function WaterfallButton.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self:SetText("")
	self:SetFunc("disabled",nil)
	self:SetFunc("exec",nil)
end

function WaterfallButton.prototype:Refresh()
	if self.disabledFunc then
		self.disabled = self.disabledFunc(getArgs(self,"disabledArg",1))
		if self.inverseDisabled then
			self.disabled = not self.disabled
		end
	end
	if self.disabled then
		self.frame:Disable()
	else
		self.frame:Enable()
	end
	if self.width then
		self:SetWidth(self.width)
	else
		self:SetWidth(DEFAULT_CONTROL_WIDTH)
	end
end

-----------------
-- Keybinding Class --
-----------------

local function Keybinding_OnClick(this, button)
	local self = this.obj

	if button == "LeftButton" or button == "RightButton" then
		if self.waitingForKey then
			this:EnableKeyboard(false)
			self.msgframe:Hide()
			this:UnlockHighlight()
			self.waitingForKey = nil
		else
			this:EnableKeyboard(true)
			self.parent:ClearFocus()
			self.msgframe:Show()
			this:LockHighlight()
			self.waitingForKey = true
		end
	end
end


local function Keybinding_OnKeyDown(this, key)
	local self = this.obj
	if self.waitingForKey then
		local keyPressed = key;
			if keyPressed == "ESCAPE" then
				keyPressed = ""
			else
				if ( keyPressed == "BUTTON1" or keyPressed == "BUTTON2" ) then
					return;
				end
				if ( keyPressed == "UNKNOWN" ) then
					return;
				end
				if ( keyPressed == "SHIFT" or keyPressed == "CTRL" or keyPressed == "ALT") then
					return;
				end
				if ( keyPressed == "LSHIFT" or keyPressed == "LCTRL" or keyPressed == "LALT") then
					return;
				end
				if ( keyPressed == "RSHIFT" or keyPressed == "RCTRL" or keyPressed == "RALT") then
					return;
				end
				if ( IsShiftKeyDown() ) then
					keyPressed = "SHIFT-"..keyPressed;
				end
				if ( IsControlKeyDown() ) then
					keyPressed = "CTRL-"..keyPressed;
				end
				if ( IsAltKeyDown() ) then
					keyPressed = "ALT-"..keyPressed;
				end
			end

		if self.setFunc and not self.disabled then
			local validated = true
			if keyPressed == "" then
				keyPressed = nil
			else
				if self.keybindingOnly and not self.keybindingOnly[keyPressed] then
					validated = false
				end
				if self.keybindingExcept and self.keybindingExcept[keyPressed] then
					validated = false
				end
			end
			if validated then
				self.setFunc(getArgs(self,"setArg",1,keyPressed))
			end
			if self.causesRefresh or self.fullRefresh then
				self.parent:Refresh(self.fullRefresh)
			end
		end
		self:Refresh()

		this:EnableKeyboard(false)
		self.msgframe:Hide()
		this:UnlockHighlight()
		self.waitingForKey = nil
	end
end

local function Keybinding_OnMouseDown(this, button)
	if ( button == "LeftButton" or button == "RightButton" ) then
		return
	elseif ( button == "MiddleButton" ) then
		button = "BUTTON3";
	elseif ( button == "Button4" ) then
		button = "BUTTON4"
	elseif ( button == "Button5" ) then
		button = "BUTTON5"
	end
	Keybinding_OnKeyDown(this, button)
end

local function keybindingMsgFixWidth(this)
	this:SetWidth(this.msg:GetWidth()+10)
	this:SetScript("OnUpdate",nil)
end

function WaterfallKeybinding.prototype:init()
	WaterfallKeybinding.super.prototype.init(self,"Button","UIPanelButtonTemplate")
	local frame = self.frame
	--local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	local text = frame:GetFontString()
	text:SetPoint("LEFT",frame,"LEFT",7,0)
	text:SetPoint("RIGHT",frame,"RIGHT",-7,0)

	frame:SetScript("OnClick",Keybinding_OnClick)
	frame:SetScript("OnKeyDown",Keybinding_OnKeyDown)
	frame:SetScript("OnEnter",Control_OnEnter)
	frame:SetScript("OnLeave",Control_OnLeave)
	frame:SetScript("OnMouseDown",Keybinding_OnMouseDown)
	frame:RegisterForClicks("AnyDown")
	frame:EnableMouse()

	frame:SetHeight(24)
	frame:SetWidth(DEFAULT_CONTROL_WIDTH)

	local msgframe = CreateFrame("Frame",nil,UIParent)
	msgframe:SetHeight(30)
	msgframe:SetBackdrop(ControlBackdrop)
	msgframe:SetBackdropColor(0,0,0)
	msgframe:SetFrameStrata("DIALOG")
	msgframe:SetFrameLevel(20)
	self.msgframe = msgframe
	local msg = msgframe:CreateFontString(nil,"OVERLAY","GameFontNormal")
	msg:SetText("Press a key to bind, ESC to clear the binding or click the button again to cancel")
	msgframe.msg = msg
	msg:SetPoint("TOPLEFT",msgframe,"TOPLEFT",5,-5)
	msgframe:SetScript("OnUpdate", keybindingMsgFixWidth)
	msgframe:SetPoint("TOP",frame,"BOTTOM",0,-2)
	msgframe:Hide()
end

function WaterfallKeybinding.prototype:SetText(text)
	self.frame:SetText(text)
end

function WaterfallKeybinding.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self:SetText("")
	self:SetFunc("disabled",nil)
	self:SetFunc("exec",nil)
	self.waitingForKey = nil
	self.msgframe:Hide()
end

function WaterfallKeybinding.prototype:Refresh()
	if self.getFunc then
		local text = self.getFunc(getArgs(self,"getArg",1))
		self:SetText(text or "")
	end
	if self.disabledFunc then
		self.disabled = self.disabledFunc(getArgs(self,"disabledArg",1))
		if self.inverseDisabled then
			self.disabled = not self.disabled
		end
	end
	if self.disabled then
		self.frame:Disable()
	else
		self.frame:Enable()
	end
	if self.width then
		self:SetWidth(self.width)
	else
		self:SetWidth(DEFAULT_CONTROL_WIDTH)
	end
end

-----------------
-- Slider Class --
-----------------

local function Slider_OnValueChanged(this)
	local self = this.obj
	if not this.setup then
		local func = self.setFunc
		local newvalue
		newvalue = this:GetValue()
		if newvalue ~= self.value and not self.disabled then
			if self.bigStep > 0 then
				self.value = math.floor((newvalue - self.min) / self.bigStep + 0.5) * self.bigStep + self.min
			else
				self.value = newvalue
			end
			if func and not self.isInit then
				if (self.finalSetOnly) then
					self.finalSetValue = self.value
				else
					func(getArgs(this.obj,"setArg",1,self.value))
				end
			end
		end
		if self.value then
			this.obj.valuetext:SetText(math.floor(self.value*10)/10)
		end
	end
end

local function Slider_OnMouseUp(this)
	local self = this.obj
	if (self.finalSetValue) then
		local func = self.setFunc
		if func then
			func(getArgs(this.obj,"setArg",1,self.finalSetValue))
		end
	end
	if self.causesRefresh or self.fullRefresh then
		self.parent:Refresh(self.fullRefresh)
	end
end

local SliderBackdrop  = {
	bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
	edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
	tile = true, tileSize = 8, edgeSize = 8,
	insets = { left = 3, right = 3, top = 6, bottom = 6 }
}

function WaterfallSlider.prototype:init()
	WaterfallSlider.super.prototype.init(self,"Frame")
	local frame = self.frame

	self.slider = CreateFrame("Slider",nil,frame)
	local slider = self.slider
	slider:SetScript("OnEnter",Control_OnEnter)
	slider:SetScript("OnLeave",Control_OnLeave)
	slider:SetScript("OnMouseUp", Slider_OnMouseUp)
	slider.obj = self
	slider:SetOrientation("HORIZONTAL")
	frame:SetWidth(DEFAULT_CONTROL_WIDTH)
	slider:SetHeight(17)
	slider:SetHitRectInsets(0,0,-10,-10)
	slider:SetBackdrop(SliderBackdrop)
	self.text = slider:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
	self.text:SetPoint("TOP",frame,"TOP",0,-2)

	self.lowtext = slider:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	self.lowtext:SetPoint("TOPLEFT",slider,"BOTTOMLEFT",2,3)

	self.hightext = slider:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	self.hightext:SetPoint("TOPRIGHT",slider,"BOTTOMRIGHT",-2,3)

	self.valuetext = slider:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	self.valuetext:SetPoint("TOP",slider,"BOTTOM",0,3)


	slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")

	frame:SetWidth(DEFAULT_CONTROL_WIDTH)
	frame:SetHeight(40)
	slider:SetPoint("TOP",self.text,"BOTTOM",0,0)
	slider:SetPoint("LEFT",frame,"LEFT",0,0)
	slider:SetPoint("RIGHT",frame,"RIGHT",0,0)

	if self.getFunc then
		self.isInit = true
		self.value = self.getFunc(getArgs(self,"getArg",1))
		self.isInit = nil
	end
	slider:SetValue(self.value or 0)
	slider:SetScript("OnValueChanged",Slider_OnValueChanged)

end

function WaterfallSlider.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self:SetText("")
	self:SetFunc("disabled",nil)
	self:SetFunc("get",nil)
	self:SetFunc("set",nil)
	self.min = nil
	self.max = nil
	self.step = nil
	self.value = nil
	self.parent = nil
	self.disabled = nil
end

function WaterfallSlider.prototype:SetText(text)
	self.text:SetText(text)
end

function WaterfallSlider.prototype:Refresh()
	local frame = self.slider
	frame.setup = true
	frame:SetMinMaxValues(self.min or 0,self.max or 100)
	self.lowtext:SetText(self.min or 0)
	self.hightext:SetText(self.max or 100)
	frame:SetValueStep(self.step or 1)
	frame.setup = nil
	if self.getFunc then
		local newvalue
		newvalue = self.getFunc(getArgs(self,"getArg",1))
		if newvalue ~= self.value then
			self.isInit = true
			frame:SetValue(newvalue)
			self.isInit = nil
		end
	end

	if self.disabledFunc then
		self.disabled = self.disabledFunc(getArgs(self,"disabledArg",1))
		if self.inverseDisabled then
			self.disabled = not self.disabled
		end
	end
	if self.disabled then
		self.slider:EnableMouse(false)
		self.text:SetTextColor(.5,.5,.5)
		self.hightext:SetTextColor(.5,.5,.5)
		self.lowtext:SetTextColor(.5,.5,.5)
		self.valuetext:SetTextColor(.5,.5,.5)
	else
		self.slider:EnableMouse(true)
		self.text:SetTextColor(1,1,1)
		self.hightext:SetTextColor(1,1,1)
		self.lowtext:SetTextColor(1,1,1)
		self.valuetext:SetTextColor(1,1,1)
	end

	if self.width then
		self:SetWidth(self.width)
	else
		self:SetWidth(DEFAULT_CONTROL_WIDTH)
	end
end

-------------------
-- TextBox Class --
-------------------

local function TextBox_OnEscapePressed(this)
	this:ClearFocus()
end

local function TextBox_OnEnterPressed(this)
	local self = this.obj
	local value = this:GetText()
	if self.toNumber then
		value = tonumber(value)
		--TODO: same message as a failed validation
		if not value then return end
	end
	if self.setFunc and not self.disabled then
		local validated = true
		if type(self.validateFunc) == "function" then
			validated = self.validateFunc(getArgs(self,"validateArg",1,value))
			if validated and self.validateModifies then
				value = validated
				local setOnTextChanged = self.setOnTextChanged
				self.setOnTextChanged = nil
				this:SetText(value)
				self.setOnTextChanged = setOnTextChanged
			end
		elseif type(self.validateFunc) == "table" then
			validated = self.validateFunc[value]
		end
		--TODO: message for failed validation
		if validated then
			if self.parseList then
				self.setFunc(getArgs(self,"setArg",1,parseList(value)))
			else
				self.setFunc(getArgs(self,"setArg",1,value))
			end
		end
		if self.getFunc == false then
			self:SetText("")
		end
		if self.causesRefresh or self.fullRefresh then
			self.parent:Refresh(self.fullRefresh)
		end
	end
end

local function TextBox_OnTextChanged(this)
	local self = this.obj
	local value = this:GetText()
	if self.setOnTextChanged then
		TextBox_OnEnterPressed(this)
	end
	if self.changedFunc and not self.disabled then
		if self.parseList then
			self.changedFunc(getArgs(self,"changedArg",1,parseList(value)))
		else
			self.changedFunc(getArgs(self,"changedArg",1,value))
		end
	end
end

function WaterfallTextBox.prototype:init()
	WaterfallTextBox.super.prototype.init(self,"EditBox")
	local frame = self.frame
	--local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	--self.text = text
	frame:SetScript("OnEnter",Control_OnEnter)
	frame:SetScript("OnLeave",Control_OnLeave)
	frame:SetFontObject(ChatFontNormal)
	frame:SetScript("OnEscapePressed",TextBox_OnEscapePressed)
	frame:SetScript("OnEnterPressed",TextBox_OnEnterPressed)
	frame:SetScript("OnTextChanged",TextBox_OnTextChanged)
	frame:SetTextInsets(5,5,3,3)
	frame:SetMaxLetters(256)
	frame:SetAutoFocus(false)
	frame:SetHeight(26)
	frame:SetWidth(DEFAULT_CONTROL_WIDTH)
	frame:SetBackdrop(ControlBackdrop)
	frame:SetBackdropColor(0,0,0)
end

local function UglyScrollLeft()
  this:HighlightText(0,1);
  this:Insert(" "..strsub(this:GetText(),1,1));
  this:HighlightText(0,1);
  this:Insert("");
  this:SetScript("OnUpdate", nil);
end

function WaterfallTextBox.prototype:SetText(text)
	self.frame:SetText(text)
	self.frame:SetScript("OnUpdate", UglyScrollLeft);
end

function WaterfallTextBox.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self.setOnTextChanged = nil
	self:SetText("")
	self:SetFunc("disabled",nil)
	self:SetFunc("get",nil)
	self:SetFunc("set",nil)
	self:SetFunc("changed",nil)
end

function WaterfallTextBox.prototype:Refresh()
	if self.getFunc then
		local text = self.getFunc(getArgs(self,"getArg",1))
		if text then
			self:SetText(text)
		end
	end

	if self.disabledFunc then
		self.disabled = self.disabledFunc(getArgs(self,"disabledArg",1))
		if self.inverseDisabled then
			self.disabled = not self.disabled
		end
	end
	if self.disabled then
		self.frame:EnableMouse(false)
		self.frame:ClearFocus()
		self.frame:SetTextColor(0.5,0.5,0.5)
	else
		self.frame:EnableMouse(true)
		self.frame:SetTextColor(1,1,1)
	end
	if self.width then
		self:SetWidth(self.width)
	else
		self:SetWidth(DEFAULT_CONTROL_WIDTH)
	end
end


--------------------
-- DropDown Class --
--------------------

local function Dropdown_OnEnterPressed(this)
	local self = this.obj
	if self.setFunc and not self.disabled then
		local ret
		if self.strict and this.value then
			ret = this.value
		else
			ret = this:GetText()
		end
		if self.parseList then
			self.setFunc(getArgs(self,"setArg",1,parseList(ret)))
		else
			self.setFunc(getArgs(self,"setArg",1,ret))
		end
		if self.causesRefresh or self.fullRefresh then
			self.parent:Refresh(self.fullRefresh)
		end
	end
end

local function Dropdown_TogglePullout(this)
	local self = this.obj
	if self.open then
		self.open = nil
		self.pullout:Hide()
	else
		self.open = true
		self:BuildPullout()
		if self.lines[1] and self.lines[1]:IsShown() then
			self.pullout:Show()
		end
	end
end

local function Dropdown_OnHide(this)
	this.obj.pullout:Hide()
end

local function Dropdown_LineClicked(this)
	local self = this.obj
	self.open = false
	self.pullout:Hide()
	self.editbox:SetText(this.text:GetText())
	self.editbox.value = this.value
	Dropdown_OnEnterPressed(self.editbox)
end

local function Dropdown_LineEnter(this)
	this.highlight:Show()
end

local function Dropdown_LineLeave(this)
	this.highlight:Hide()
end

function WaterfallDropdown.prototype:init()
	WaterfallDropdown.super.prototype.init(self,"Frame")
	local frame = self.frame
	frame.obj = self
	--local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	--self.text = text
	local editbox = CreateFrame("EditBox",nil,frame)
	self.editbox = editbox
	editbox.obj = self
	editbox:SetFontObject(ChatFontNormal)
	editbox:SetScript("OnEscapePressed",TextBox_OnEscapePressed)
	editbox:SetScript("OnEnterPressed",Dropdown_OnEnterPressed)
	frame:SetScript("OnEnter",Control_OnEnter)
	frame:SetScript("OnLeave",Control_OnLeave)
	editbox:SetScript("OnEnter",Control_OnEnter)
	editbox:SetScript("OnLeave",Control_OnLeave)
	editbox:SetTextInsets(5,5,3,3)
	editbox:SetMaxLetters(256)
	editbox:SetAutoFocus(false)
	editbox:SetBackdrop(ControlBackdrop)
	editbox:SetBackdropColor(0,0,0)

	editbox:SetPoint("TOPLEFT",frame,"TOPLEFT",0,0)
	editbox:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-20,0)
	local button = CreateFrame("Button",nil,frame)
	self.button = button
	button.obj = self
	button:SetWidth(24)
	button:SetHeight(24)
	button:SetScript("OnEnter",Control_OnEnter)
	button:SetScript("OnLeave",Control_OnLeave)
	button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	button:GetNormalTexture():SetTexCoord(.09,.91,.09,.91)
	button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
	button:GetPushedTexture():SetTexCoord(.09,.91,.09,.91)
	button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
	button:GetDisabledTexture():SetTexCoord(.09,.91,.09,.91)
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	button:GetHighlightTexture():SetTexCoord(.09,.91,.09,.91)
	button:SetPoint("RIGHT",frame,"RIGHT",0,0)
	button:SetScript("OnClick",Dropdown_TogglePullout)
	frame:SetHeight(26)
	frame:SetWidth(DEFAULT_CONTROL_WIDTH)
	frame:SetScript("OnHide",Dropdown_OnHide)
	local pullout = CreateFrame("Frame",nil,UIParent)
	self.pullout = pullout
	frame:EnableMouse()
	pullout:SetBackdrop(ControlBackdrop)
	pullout:SetBackdropColor(0,0,0)
	pullout:SetFrameStrata("DIALOG")
	pullout:SetFrameLevel(20)
	pullout:SetPoint("TOPLEFT",frame,"BOTTOMLEFT",0,0)
	pullout:SetPoint("TOPRIGHT",frame,"BOTTOMRIGHT",-24,0)
	pullout:SetClampedToScreen(true)
	pullout:Hide()

	self.lines = {}
end

function WaterfallDropdown.prototype:SetText(text)
	self.editbox:SetText(text)
end

function WaterfallDropdown.prototype:CleanUp()
	self.frame:ClearAllPoints()
	self.frame:Hide()
	self.width = nil
	self.height = nil
	self.noNewLine = nil
	self.causesRefresh = nil
	self.fullRefresh = nil
	self.treeRefresh = nil
	self:SetText("")
	self:SetFunc("disabled",nil)
	self:SetFunc("get",nil)
	self:SetFunc("set",nil)
	self.editbox.value = nil
	self.columns = nil
end

function WaterfallDropdown.prototype:Refresh()
	local list = self.list
	if self.getFunc then
		local newval = self.getFunc(getArgs(self,"getArg",1))
		if newval then
			if self.strict then
				if type(list) == "table" then
					local value
					for k, text in pairs(list) do
						if type(k) == "string" then
							value = k
						else
							value = text
						end
						if newval == value then
							self:SetText(text)
							self.editbox.value = value
							break
						end
					end
				elseif type(list) == "function" then
					for i, text, value in list() do
						if newval == value then
							self:SetText(text)
							self.editbox.value = value
							break
						end
					end
				end
			else
				self.editbox:SetText(newval)
				self.editbox.value = newval
			end
		else
			self.editbox:SetText("")
			self.editbox.value = newval
		end
	end

	if self.disabledFunc then
		self.disabled = self.disabledFunc(getArgs(self,"disabledArg",1))
		if self.inverseDisabled then
			self.disabled = not self.disabled
		end
	end
	if self.disabled then
		self.editbox:EnableMouse(false)
		self.editbox:ClearFocus()
		self.editbox:SetTextColor(0.5,0.5,0.5)
		self.button:Disable()
	else
		self.button:Enable()
		if self.strict then
			self.editbox:EnableMouse(false)
			self.editbox:ClearFocus()
			self.editbox:SetTextColor(1,1,1)
		else
			self.editbox:EnableMouse(true)
			self.editbox:SetTextColor(1,1,1)
		end
	end
	if self.width then
		self:SetWidth(self.width)
	else
		self:SetWidth(DEFAULT_CONTROL_WIDTH)
	end
end

local ddsort = {}
function WaterfallDropdown.prototype:BuildPullout()
	local list = self.list
	local lines = self.lines
	local totalheight = 10
	self:ClearPullout()
	if type(list) == "table" then
		for k, v in pairs(list) do
			tinsert(ddsort,k)
		end
		table.sort(ddsort)
		local columns = tonumber(self.columns)
		local columnHeight, columnWidth
		local columnCount = 0
		self.pullout:ClearAllPoints()
		if (columns) then
			columnHeight = math.floor((# ddsort) / columns) + 2
			columnWidth = self.pullout:GetWidth()
			self.pullout:SetPoint("TOPLEFT",self.frame,"BOTTOMRIGHT", -1 * DEFAULT_CONTROL_WIDTH * columns - 24,0)
			self.pullout:SetPoint("TOPRIGHT",self.frame,"BOTTOMRIGHT",-24,0)
		else
			self.pullout:SetPoint("TOPLEFT",self.frame,"BOTTOMRIGHT", -1 * DEFAULT_CONTROL_WIDTH - 24,0)
			self.pullout:SetPoint("TOPRIGHT",self.frame,"BOTTOMRIGHT",-24,0)
			columnHeight = # ddsort + 1
		end
		for i, value in pairs(ddsort) do
			local text = list[value]
			if ((i - 1) % (columnHeight - 1) == 0) then
				columnCount = columnCount + 1
			end
			if (lines[i]) then
				self:UpdateLine(lines[i], math.fmod(i-1, (columnHeight-1)), columnCount)
			else
				lines[i] = self:CreateLine(math.fmod(i-1, (columnHeight-1)), columnCount)
			end
			if i == 1 then
				lines[i]:SetPoint("TOP",self.pullout,"TOP",0,-5)
			else
				if (columns and ((i - 1) % columnHeight == 0)) then
					lines[i]:SetPoint("TOP",self.pullout,"TOP",0,-5)
				else
					lines[i]:SetPoint("TOP",lines[i-1],"BOTTOM",0,0)
				end
			end
			lines[i].text:SetText(text)
			if type(value) == "string" then
				lines[i].value = value
			else
				lines[i].value = text
			end
			if lines[i].value == self.editbox.value and self.getFunc then
				lines[i].check:Show()
			else
				lines[i].check:Hide()
			end
			lines[i]:Show()
		end
		totalheight = totalheight + 17 * (columnHeight-1)
		for k in pairs(ddsort) do
			ddsort[k] = nil
		end
	elseif type(list) == "function" then
		for i, text, value in list() do
			if not lines[i] then
				lines[i] = self:CreateLine()
				if i == 1 then
					lines[i]:SetPoint("TOP",self.pullout,"TOP",0,-5)
				else
					lines[i]:SetPoint("TOP",lines[i-1],"BOTTOM",0,0)
				end
			end
			lines[i].text:SetText(text)
			lines[i].value = value
			lines[i]:Show()
			totalheight = totalheight + 17
		end
	end
	self.pullout:SetHeight(totalheight)
end

function WaterfallDropdown.prototype:ClearPullout()
	if self.lines then
		for i, line in ipairs(self.lines) do
			line.text:SetText("")
			line:Hide()
		end
	end
	self.pullout:SetHeight(10)
	self.pullout:SetWidth(DEFAULT_CONTROL_WIDTH)
end

-- For large list, if specified, 0 based row, 1 based column gives a grid.
function WaterfallDropdown.prototype:CreateLine(row, column)
	local frame = CreateFrame("Button",nil,self.pullout)
	frame.obj = self

	frame.text = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	frame.text:SetTextColor(1,1,1)
	frame.text:SetJustifyH("LEFT")

	frame:SetFrameLevel(25)
	frame:SetFrameStrata("DIALOG")

	local highlight = frame:CreateTexture(nil, "OVERLAY")
	frame.highlight = highlight
	highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	highlight:SetBlendMode("ADD")

	local check = frame:CreateTexture("OVERLAY")
	frame.check = check
	check:SetWidth(16)
	check:SetHeight(16)
	check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")

	frame:SetScript("OnClick",Dropdown_LineClicked)
	frame:SetScript("OnEnter",Dropdown_LineEnter)
	frame:SetScript("OnLeave",Dropdown_LineLeave)
	return self:UpdateLine(frame, row, column)
end


function WaterfallDropdown.prototype:UpdateLine(frame, row, column)
	if (column) then
		frame:SetPoint("TOPLEFT",self.pullout,"TOPLEFT",6 + (column - 1) * DEFAULT_CONTROL_WIDTH,-5 - row*17)
		frame:SetPoint("BOTTOMRIGHT",self.pullout,"TOPLEFT",-6 + column * DEFAULT_CONTROL_WIDTH,-5 - (row+1)*17)
	else
		frame:SetPoint("LEFT",self.pullout,"LEFT",6,0)
		frame:SetPoint("RIGHT",self.pullout,"RIGHT",-6,0)
	end

	frame.text:SetPoint("TOPLEFT",frame,"TOPLEFT",16,0)
	frame.text:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",0,0)

	frame.highlight:SetAllPoints(frame)
	frame.highlight:Hide()

	frame.check:SetPoint("LEFT",frame,"LEFT",0,0)

	return frame
end

-----------------------------
-- WaterfallTreeView Class --
-----------------------------

local function treeviewOnSizeChanged(this)
	this.obj:SizeChanged()
end
local function treeviewOnMouseWheel(this,value)
	this.obj:MoveScroll(value)
end
local function treeviewOnScrollValueChanged(this,value)
	this.obj:SetScroll(value)
end
local function treeviewSizerOnMouseUp(this)
	this:GetParent():StopMovingOrSizing() this.obj.parent:ReAnchorTree()
end

function WaterfallTreeView.prototype:init(parent)
	WaterfallTreeView.super.prototype.init(self)
	--Parent WaterfallFrame Object
	self.parent = parent
	local frame = CreateFrame("Frame",nil,parent.frame)
	frame.obj = self
	local scrollframe = CreateFrame("ScrollFrame",nil,frame)
	local scrollchild = CreateFrame("Frame",nil,scrollframe)
	local scrollbar = CreateFrame("Slider",nil,scrollframe,"UIPanelScrollBarTemplate")
	frame:SetBackdrop(ControlBackdrop)
	frame:SetBackdropBorderColor(0.6, 0.6, 0.6)
	frame:SetBackdropColor(0.1, 0.1, 0.1)
	frame:SetScript("OnSizeChanged", treeviewOnSizeChanged)
	frame:SetFrameLevel(2)
	frame:SetFrameStrata("DIALOG")
	frame:SetResizable(true)

	self.scrollframe = scrollframe
	self.scrollchild = scrollchild
	self.frame = frame
	self.scrollbar = scrollbar

	scrollframe:SetScrollChild(scrollchild)
	scrollframe:SetPoint("TOPLEFT",frame,"TOPLEFT",8,-12)
	scrollframe:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-28,12)
	scrollframe:EnableMouseWheel(true)
	scrollframe:SetScript("OnMouseWheel", treeviewOnMouseWheel)
	scrollframe.obj = self

	scrollchild:SetPoint("TOPLEFT",scrollframe,"TOPLEFT",0,0)
	scrollchild:SetPoint("TOPRIGHT",scrollframe,"TOPRIGHT",0,0)
	scrollchild:SetHeight(400)

	scrollbar:SetPoint("TOPLEFT",scrollframe,"TOPRIGHT",0,-16)
	scrollbar:SetPoint("BOTTOMLEFT",scrollframe,"BOTTOMRIGHT",0,16)
	scrollbar:SetMinMaxValues(0,1000)
	scrollbar:SetValueStep(1)
	scrollbar:SetValue(0)
	scrollbar:SetWidth(16)
	scrollbar:SetScript("OnValueChanged", treeviewOnScrollValueChanged)
	self.scrollvalue = 0
	scrollchild.lines = {}
	self.linetables = {}
	self.sections = {}
	scrollbar.obj = self

	local sizer = CreateFrame("Frame",nil,frame)
	sizer:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,0)
	sizer:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",0,0)
	sizer:SetWidth(7)
	sizer:EnableMouse()
	sizer:SetScript("OnMouseDown",sizereOnMouseDown)
	sizer:SetScript("OnMouseUp", treeviewSizerOnMouseUp)
	self.sizer = sizer
	sizer.obj = self

	self:Refresh()
end

function WaterfallTreeView.prototype:SetScroll(value)
	local frame, child = self.scrollframe, self.scrollchild
	local viewheight = frame:GetHeight()
	local height = child:GetHeight()
	local offset
	if viewheight > height then
		offset = 0
	else
		offset = floor((height - viewheight) / 1000.0 * value)
	end
	child:ClearAllPoints()
	child:SetPoint("TOPLEFT",frame,"TOPLEFT",0,offset)
	child:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,offset)
	child.offset = offset

	self.scrollvalue = value
end

function WaterfallTreeView.prototype:SizeChanged()
	self:FixScroll()
	self.parent:ReAnchorTree()
end

function WaterfallTreeView.prototype:MoveScroll(value)
	local frame, child = self.scrollframe, self.scrollchild
	local height, viewheight = frame:GetHeight(), child:GetHeight()
	if height > viewheight then
		self.scrollbar:Hide()
	else
		self.scrollbar:Show()
		local diff = height - viewheight
		local delta = 1
		if value < 0 then
			delta = -1
		end
		self.scrollbar:SetValue(math.min(math.max(self.scrollvalue + delta*(1000/(diff/45)),0), 1000))
	end
end

function WaterfallTreeView.prototype:FixScroll()
	if self.noFixScroll then return end
	local frame, child = self.scrollframe, self.scrollchild
	local height, viewheight = frame:GetHeight(), child:GetHeight()
	local offset = self.scrollchild.offset
	if not offset then
		offset = 0
	end
	local curvalue = self.scrollbar:GetValue()

	if viewheight < height then
		self.scrollbar:Hide()
		self.scrollbar:SetValue(0)
	else
		self.scrollbar:Show()
		local value = (offset / (viewheight - height) * 1000)
		if value > 1000 then value = 1000 end
		self.scrollbar:SetValue(value)
		self:SetScroll(value)
		if value < 1000 then
			child:ClearAllPoints()
			child:SetPoint("TOPLEFT",frame,"TOPLEFT",0,offset)
			child:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,offset)
			child.offset = offset
		end
	end
end

function WaterfallTreeView.prototype:ToggleExpand(id)
	self.status[id] = not self.status[id]
	self:Refresh()
end

function WaterfallTreeView.prototype:Refresh(noupdate)
	self.noFixScroll = true
	self:Clear()
	if not self.contents then return end
	if self.contentsFunc and not noupdate then
		self.parent.controlcount = 0
		currentframe = self.parent
			self.contentsFunc(self.contents, self.status, getArgs(self, "contentsArg", 1))
		currentframe = nil
	end
	if self.type == "SECTIONS" then
		for i, section in ipairs(self.contents) do
			if not section.hidden then
				self:AddSection(i,section)
			end
		end
		local height = 0
		for i, section in ipairs(self.sections) do
			height = height + section:GetHeight()
		end
		self.scrollchild:SetHeight(height+3)
	else
		local level = 0
		local index = 1
		for i, line in ipairs(self.contents) do
			if not line.hidden then
				index = self:AddLine(index,line,level)
			end
		end
		self.scrollchild:SetHeight(index*16)
	end
	self.noFixScroll = nil
	self:FixScroll()
end

local function isSectionSelected(section, selected)
	if not selected then return end
	if section.id == selected then
		return true
	end
	for i,v in ipairs(section.lines) do
		if i <= section.numlines then
			if v.id == selected then
				return true
			end
		end
	end
end

function WaterfallTreeView.prototype:Collapse()
	for k in pairs(self.status) do
		self.status[k] = false
	end
end

function WaterfallTreeView.prototype:AddSection(index,line)
	local sections = self.sections
	local id = line.id
	if not sections[index] then
		sections[index] = getObj(WaterfallTreeSection,self)
		local section = sections[index]
		section:SetParent(self)
		if index == 1 then
			section:SetPoint("TOPLEFT",self.scrollchild,"TOPLEFT",0,0)
			section:SetPoint("TOPRIGHT",self.scrollchild,"TOPRIGHT",0,0)
		else
			section:SetPoint("TOPLEFT",sections[index-1],"BOTTOMLEFT",0,0)
			section:SetPoint("TOPRIGHT",sections[index-1],"BOTTOMRIGHT",0,0)
		end
	end
	local section = sections[index]
	section:SetText(line.text)
	section:SetID(line.id)
	section:SetTooltipText(line.tooltipTitle,line.tooltipText)
	if self.status[id] == nil then
		self.status[id] = not not line.isOpen
	end

	local handler = line.handler
	local disabled = checkNegatable(line.disabled,handler)
	section.disabled = disabled
	section:SetColor(self.parent:GetColor())
	if line.hasOptions then
		section:AddLine(line.text,line.id,line.id == self.selected,disabled,line.tooltipTitle,line.tooltipText)
	end
	local firstid
	for i, item in ipairs(line) do
		if not item.hidden then
			if not firstid then
				firstid = item.id
			end
			local itemdisabled = checkNegatable(item.disabled,handler)
			section:AddLine(item.text,item.id,item.id == self.selected,itemdisabled or disabled,item.tooltipTitle,item.tooltipText)
		end
	end
	if self.selected == section.id and not line.hasOptions then
		self:SetSelected(firstid)
		return
	end

	if isSectionSelected(section, self.selected) then
		self.status[section.id] = true
	end
	section:SetExpanded(self.status[line.id] and not disabled)
	section:Show()
end

function WaterfallTreeView.prototype:Clear()
	for i, frame in ipairs(self.scrollchild.lines) do
		releaseObj(frame)
		self.scrollchild.lines[i] = nil
	end
	for k in pairs(self.linetables) do
		self.linetables[k] = nil
	end
	for i, section in ipairs(self.sections) do
		releaseObj(section)
		self.sections[i] = nil
	end
	self.numlines = 0
	self.scrollchild:SetHeight(1)
	self:FixScroll()
end

function WaterfallTreeView.prototype:ClearSelection()
	self.selected = nil
end

function WaterfallTreeView.prototype:GetSelected()
	return self.selected
end

function WaterfallTreeView.prototype:SetSelected(lineid, noupdate)
	self.selected = lineid
	self:Refresh(noupdate)
	if not noupdate then
		self.parent:ChangePane(lineid)
	end
end

function WaterfallTreeView.prototype:AddLine(index,line,level,disabled)
	local lines = self.scrollchild.lines
	local text, hasChildren, isSelected, isOpen
	text = line.text or ""
	hasChildren = #line > 0
	local id = line.id
	if self.status[id] == nil then
		self.status[id] = not not line.isOpen
	end
	isOpen = self.status[id] and not disabled
	isSelected = self.selected == id
	if not lines[index] then
		lines[index] = getObj(WaterfallTreeLine)
		lines[index]:SetParent(self)
	end
	local disabled
	if type(line.disabled) == "function" then
		disabled = line.disabled()
	else
		disabled = line.disabled
	end
	lines[index]:Setup(index,id,text,level,hasChildren,isSelected,isOpen,disabled)
	lines[index]:SetTooltipText(line.tooltipTitle,line.tooltipText)
	lines[index]:SetIcon(line.icon)
	self.linetables[index] = line
	index = index + 1
	if isOpen then
		for i, childline in ipairs(line) do
			if not childline.hidden then
				index = self:AddLine(index,childline,level+1)
			end
		end
	end

	return index
end

function WaterfallTreeView.prototype:SetType(type)
	if not type then
		self.type = "TREE"
	else
		self.type = type
	end
end

function WaterfallTreeView.prototype:SetContent(contents, status, func, ...)
	self.contents = contents
	self.status = status
	self.contentsFunc = func
	local i = 1
	while self["contentsArg"..i] do
		self["contentsArg"..i] = nil
		i = i + 1
	end
	i = 1
	local arg = (select(i,...))
	while (select(i,...)) ~= nil do
		self["contentsArg"..i] = arg
		i = i + 1
		arg = (select(i,...))
	end
	self:Refresh()
	self:FixScroll()
end

function WaterfallTreeView.prototype:CleanUp()
	self.contents = nil
	self.selected = nil
	self.contentsFunc = nil
	local i = 1
	while self["contentsArg"..i] do
		self["contentsArg"..i] = nil
		i = i + 1
	end
	self.selected = nil
	self:Refresh()
end

--------------------
-- WaterfallTreeLine Class --
--------------------

local function TreeLine_OnEnter(this)
	if not this.obj.disabled then
		this.highlight:SetAlpha(1)
		this.highlight:Show()
		showGameTooltip(this.obj)
	end
end

local function TreeLine_OnLeave(this)
	if not this.obj.isSelected then
		this.highlight:Hide()
	else
		this.highlight:SetAlpha(0.7)
	end
	GameTooltip:Hide()
end

local function TreeLine_OnClick(this)
	if not this.obj.disabled then
		this.parent:SetSelected(this.obj.id)
	end
end

local function TreeLine_OnExpandClick(this)
	if not this.obj.disabled then
		this.obj.parent:ToggleExpand(this.obj.id)
	end
end

function WaterfallTreeLine.prototype:init()
	WaterfallTreeLine.super.prototype.init(self)
	local frame = CreateFrame("Button",nil,nil)
	self.frame = frame
	local text = frame:CreateFontString(nil,"OVERLAY","GameFontNormal")

	text:SetJustifyH("LEFT")
	text:SetTextColor(1,1,1)
	frame:SetHeight(16)
	frame:EnableMouse(true)
	frame:SetScript("OnEnter",TreeLine_OnEnter)
	frame:SetScript("OnLeave",TreeLine_OnLeave)
	frame:SetScript("OnClick",TreeLine_OnClick)
	frame:SetFrameLevel(10)
	frame:SetFrameStrata("DIALOG")

	local highlight = frame:CreateTexture(nil, "BACKGROUND")
	highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	highlight:SetBlendMode("ADD")
	highlight:SetAllPoints(frame)
	highlight:Hide()

	local expand = CreateFrame("Button",nil,frame)
	expand.obj = self
	expand:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
	expand:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
	expand:SetDisabledTexture("Interface\\Buttons\\UI-PlusButton-Disabled")
	expand:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
	expand:SetScript("OnClick",TreeLine_OnExpandClick)
	expand:SetFrameLevel(21)
	expand:SetWidth(16)
	expand:SetHeight(16)

	local icon = frame:CreateTexture(nil,"OVERLAY")
	icon:SetWidth(16)
	icon:SetHeight(16)
	icon:SetPoint("LEFT",expand,"RIGHT",1,0)
	self.icon = icon


	expand:SetPoint("LEFT",frame,"LEFT",0,0)
	text:SetPoint("LEFT",icon,"RIGHT",0,0)
	text:SetPoint("RIGHT",frame,"RIGHT",0,0)

	frame.obj = self
	frame.text = text
	frame.highlight = highlight
	frame.expand = expand
	self.expand = expand
	self.highlight = highlight
	self.text = text
end

function WaterfallTreeLine.prototype:UpdateExpandButton()
	local expand = self.expand
	if self.hasChildren then
		if self.isOpen then
			expand:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
			expand:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down")
			expand:SetDisabledTexture("Interface\\Buttons\\UI-MinusButton-Disabled")
			expand:Enable()
			expand:SetWidth(16)
		else
			if self.disabled then
				expand:Disable()
			else
				expand:Enable()
			end
			expand:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
			expand:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
			expand:SetDisabledTexture("Interface\\Buttons\\UI-PlusButton-Disabled")

			expand:SetWidth(16)
		end
	else
		expand:SetNormalTexture(nil)
		expand:SetPushedTexture(nil)
		expand:SetDisabledTexture(nil)
		expand:Disable()
		expand:SetWidth(16)
	end
end

function WaterfallTreeLine.prototype:CleanUp()
	self:ClearAllPoints()
	self:Hide()
	self:SetText("")
	self.disabled = nil
	self.handler = nil
	self.name = nil
end

function WaterfallTreeLine.prototype:Setup(index, id, text, level, hasChildren, isSelected, isOpen, disabled)
	self.level = level
	self.hasChildren = hasChildren
	self.isSelected = isSelected
	self.isOpen = isOpen and not disabled
	self.index = index
	self.id = id
	self.disabled = disabled

	self:UpdateExpandButton()

	self.expand:SetPoint("LEFT",self.frame,"LEFT",level*8,0)
	self:SetText(text)
	if disabled then
		self.text:SetTextColor(0.5,0.5,0.5)
	else
		self.text:SetTextColor(1,1,1)
	end
	self.frame:SetPoint("TOPLEFT",self.parent.scrollchild,"TOPLEFT",0,-(index-1)*16)
	self.frame:SetPoint("TOPRIGHT",self.parent.scrollchild,"TOPRIGHT",0,-(index-1)*16)
	if self.isSelected then
		self.highlight:Show()
		self.highlight:SetAlpha(0.7)
	else
		self.highlight:Hide()
	end
	self.frame:Show()
end

function WaterfallTreeLine.prototype:SetIcon(iconpath)
	local icon = self.icon
	if iconpath then
		icon:SetTexture(iconpath)
		icon:SetWidth(16)
	else
		icon:SetTexture(nil)
		icon:SetWidth(1)
	end
end

function WaterfallTreeLine.prototype:SetText(text)
	self.text:SetText(text)
end

function WaterfallTreeLine.prototype:SetTooltipText(title,text)
	self.tooltipTitle = title
	self.tooltipText = text
end

function WaterfallTreeLine.prototype:SetParent(parent)
	self.parent = parent
	self.frame.parent = parent
	self.frame:SetParent(parent.scrollchild)
end

-----------------------
-- TreeSection Class --
-----------------------

local function SectionTitle_OnClick(this)
	local self  = this.obj
	local parent = self.parent
	if not self.disabled then
		local selected = self.parent.selected
		local lines = self.lines
		if self.expanded then
			--search before changing pane, since it will release and reinit this section
			local found
			for i = 1, self.numlines do
				if lines[i].id == selected then
					found = true
				end
			end
			--if expanded close

			-- if one of our children is selected then clear the pane
			if found then
				parent.selected = nil
				parent:ToggleExpand(self.id)
				parent:SetSelected(nil)
			else
				parent:ToggleExpand(self.id)
			end
		else
			--save before changing pane, since it will release and reinit this section
			local newid
			if lines[1] then
				newid = lines[1].id
			end
			parent:ToggleExpand(self.id)
			if newid and not parent.selected then
				parent:SetSelected(newid)
			end
		end
	end
end

local function SectionTitle_OnEnter(this)
	local self = this.obj
	if not self.disabled then
		self.hover = true
		self:UpdateColor()
	end
	showGameTooltip(self)
end

local function SectionTitle_OnLeave(this)
	local self = this.obj
	self.hover = false
	self:UpdateColor()
	GameTooltip:Hide()
end

local function SectionItem_OnEnter(this)
	if not this.disabled then
		this.highlight:SetAlpha(1)
		this.highlight:Show()
		showGameTooltip(this)
	end
end

local function SectionItem_OnClick(this)
	if not this.disabled then
		this.obj.parent:SetSelected(this.id)
	end
end

local function SectionItem_OnLeave(this)
	if not this.isSelected then
		this.highlight:Hide()
	else
		this.highlight:SetAlpha(0.7)
	end
	GameTooltip:Hide()
end

function WaterfallTreeSection.prototype:init(parent)
	WaterfallTreeSection.super.prototype.init(self)

	self.parent = parent
	local frame = CreateFrame("Frame",nil,parent.scrollchild)
	frame.obj = self
	self.frame = frame
	frame:SetBackdrop(PaneBackdrop)
	frame:SetBackdropBorderColor(0.6, 0.6, 0.6)
	frame:SetBackdropColor(0.1, 0.1, 0.1)
	frame:SetFrameLevel(10)
	frame:SetFrameStrata("DIALOG")

	local titletext = frame:CreateFontString(nil,"OVERLAY","GameFontNormal")
	self.titletext = titletext
	titletext:SetPoint("TOPLEFT",frame,"TOPLEFT",0,-5)
	titletext:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,-5)
	titletext:SetHeight(16)
	titletext:SetText("Section")
	titletext:SetTextColor(1,1,1)

	local arrow = frame:CreateTexture(nil,"OVERLAY")
	self.arrow = arrow
	arrow:SetPoint("TOPRIGHT",frame,"TOPRIGHT",-6,-4)
	arrow:SetWidth(20)
	arrow:SetHeight(20)
	arrow:SetTexture("Interface\\MiniMap\\ROTATING-MINIMAPARROW")

	local r,g,b = 1, 0.6, 0
	self.colorR = r
	self.colorG = g
	self.colorB = b
	local titlebar = frame:CreateTexture(nil,"BACKGROUND")
	self.titlebar = titlebar
	local titlebar2 = frame:CreateTexture(nil,"BACKGROUND")
	self.titlebar2 = titlebar2
	titlebar:SetPoint("TOPLEFT",frame,"TOPLEFT",4,-4)
	titlebar:SetPoint("TOPRIGHT",frame,"TOPRIGHT",-4,-4)
	titlebar:SetHeight(10)
	titlebar2:SetPoint("TOPLEFT",titlebar,"BOTTOMLEFT",0,0)
	titlebar2:SetPoint("TOPRIGHT",titlebar,"BOTTOMRIGHT",0,0)
	titlebar2:SetHeight(10)

	titlebar:SetGradientAlpha("VERTICAL",r*0.6,g*0.6,b*0.6,1,r,g,b,1)
	titlebar:SetTexture(r,g,b,1)
	titlebar2:SetGradientAlpha("VERTICAL",r*0.9,g*0.9,b*0.9,1,r*0.6,g*0.6,b*0.6,1)
	titlebar2:SetTexture(r,g,b,1)

	local title = CreateFrame("Button",nil,frame)
	self.title = title
	title:EnableMouse()
	title.obj = self
	title:SetScript("OnClick", SectionTitle_OnClick)
	title:SetScript("OnEnter", SectionTitle_OnEnter)
	title:SetScript("OnLeave", SectionTitle_OnLeave)
	title:SetPoint("TOPLEFT",titlebar,"TOPLEFT",0,0)
	title:SetPoint("BOTTOMRIGHT",titlebar2,"BOTTOMRIGHT",0,0)

	self.lines = {}
	self.numlines = 0

	frame:SetWidth(100)
	frame:SetHeight(100)
	self.expanded = true



	frame:SetPoint("CENTER",UIParent,"CENTER")
end

function WaterfallTreeSection.prototype:SetParent(parent)
	self.parent = parent
	self.frame:SetParent(parent.scrollchild)
end

function WaterfallTreeSection.prototype:UpdateColor()
	local r,g,b
	self.arrow:Show()
	if self.disabled then
		r,g,b = 0.5,0.5,0.5
		self.arrow:Hide()
	elseif self.hover then
		r,g,b = self.colorR+((1-self.colorR)/2), self.colorG+((1-self.colorG)/2), self.colorB+((1-self.colorB)/2)
	else
		r,g,b = self.colorR, self.colorG, self.colorB
	end

	local titlebar = self.titlebar
	local titlebar2 = self.titlebar2
	titlebar:SetGradientAlpha("VERTICAL",r*0.6,g*0.6,b*0.6,1,r,g,b,1)
	titlebar:SetTexture(r,g,b,1)
	titlebar2:SetGradientAlpha("VERTICAL",r*0.9,g*0.9,b*0.9,1,r*0.6,g*0.6,b*0.6,1)
	titlebar2:SetTexture(r,g,b,1)
end

function WaterfallTreeSection.prototype:SetColor(r,g,b)
	if r and g and b then
		self.colorR, self.colorG, self.colorB = r,g,b
	end
	self:UpdateColor()
end

function WaterfallTreeSection.prototype:ToggleExpand()
	self:SetExpanded(not self.expanded)
end

function WaterfallTreeSection.prototype:SetText(text)
	self.titletext:SetText(text)
end


function WaterfallTreeSection.prototype:SetTooltipText(title,text)
	self.tooltipTitle = title
	self.tooltipText = text
end

function WaterfallTreeSection.prototype:SetID(id)
	self.id = id
end

function WaterfallTreeSection.prototype:AddLine(text,id,selected,disabled,tooltipTitle,tooltipText)
	local numlines = self.numlines + 1
	self.numlines = numlines
	local lines = self.lines
	if not lines[numlines] then
		self:CreateLine(numlines)
	end
	local line = lines[numlines]

	line.text:SetText(text)
	line.id = id
	line.disabled = disabled
	line.isSelected = selected
	line.tooltipTitle = tooltipTitle
	line.tooltipText = tooltipText
	if selected then
		line.highlight:SetAlpha(0.7)
		line.highlight:Show()
	else
		line.highlight:Hide()
	end
	if disabled then
		line.text:SetTextColor(0.5,0.5,0.5)
	else
		line.text:SetTextColor(1,1,1)
	end
	line:Show()
	self:FixHeight()
end

function WaterfallTreeSection.prototype:SetExpanded(expanded)
	self.expanded = expanded
	local lines = self.lines
	if self.expanded then
		for i = 1, self.numlines do
			lines[i]:Show()
		end
		self.arrow:SetTexCoord(.18,.85,.15,.82)
	else
		for i = 1, #lines do
			lines[i]:Hide()
		end
		self.arrow:SetTexCoord(.85,.18,.82,.15)
	end
	self:FixHeight()
end

function WaterfallTreeSection.prototype:FixHeight()
	if self.expanded then
		self.frame:SetHeight(33 + self.numlines * 18)
	else
		self.frame:SetHeight(28)
	end
end

function WaterfallTreeSection.prototype:CreateLine(index)
	local frame = self.frame
	self.lines[index] = CreateFrame("Button",nil,frame)
	local line = self.lines[index]
	line.obj = self

	line:SetScript("OnEnter",SectionItem_OnEnter)
	line:SetScript("OnLeave",SectionItem_OnLeave)
	line:SetScript("OnClick",SectionItem_OnClick)

	line:SetPoint("LEFT",frame,"LEFT",5,0)
	line:SetPoint("RIGHT",frame,"RIGHT",-5,0)
	line:SetHeight(16)
	if index == 1 then
		line:SetPoint("TOP",frame,"TOP",0,-28)
	else
		line:SetPoint("TOP",self.lines[index-1],"BOTTOM",0,-2)
	end

	local text = line:CreateFontString(nil,"OVERLAY","GameFontNormal")
	line.text = text
	text:SetAllPoints(line)
	text:SetTextColor(1,1,1)

	local highlight = line:CreateTexture(nil, "BACKGROUND")
	line.highlight = highlight
	highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	highlight:SetBlendMode("ADD")
	highlight:SetAllPoints(line)
	highlight:Hide()
end

function WaterfallTreeSection.prototype:CleanUp()
	for i = 1, #self.lines do
		self.lines[i]:Hide()
	end
	self.numlines = 0
	self.frame:Hide()
	self.frame:ClearAllPoints()
	self.id = nil
	self.disabled = nil
	self.colorR = 1
	self.colorG = 0.6
	self.colorB = 0
end

local function activate(self, oldLib, oldDeactivate)
	if oldLib and oldLib.registry then
		self.registry = oldLib.registry
	else
		self.registry = {}
	end
	if oldDeactivate then
		oldDeactivate(oldLib)
	end
end

AceLibrary:Register(Waterfall, MAJOR_VERSION, MINOR_VERSION, activate)
Waterfall = AceLibrary("Waterfall-1.0")
