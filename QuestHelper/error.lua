QuestHelper_File["error.lua"] = "1.4.1"
QuestHelper_Loadtime["error.lua"] = GetTime()

--[[
  Much of this code is ganked wholesale from Swatter, and is Copyright (C) 2006 Norganna. Licensed under LGPL v3.0.
]]

local debug_output = false
if QuestHelper_File["error.lua"] == "Development Version" then debug_output = true end

QuestHelper_local_version = QuestHelper_File["error.lua"]
QuestHelper_toc_version = GetAddOnMetadata("QuestHelper", "Version")

local origHandler = geterrorhandler()

local QuestHelper_ErrorCatcher = { }

local startup_errors = {}
local completely_started = false
local yelled_at_user = false

local first_error = nil

QuestHelper_Errors = {}

function QuestHelper_ErrorCatcher.TextError(text)
  DEFAULT_CHAT_FRAME:AddMessage(string.format("|cffff8080QuestHelper Error Handler: |r%s", text))
end


-- ganked verbatim from Swatter
function QuestHelper_ErrorCatcher.GetAddOns()
	local addlist = ""
	for i = 1, GetNumAddOns() do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)

		local loaded = IsAddOnLoaded(i)
		if (loaded) then
			if not name then name = "Anonymous" end
			name = name:gsub("[^a-zA-Z0-9]+", "")
			local version = GetAddOnMetadata(i, "Version")
			local class = getglobal(name)
			if not class or type(class)~='table' then class = getglobal(name:lower()) end
			if not class or type(class)~='table' then class = getglobal(name:sub(1,1):upper()..name:sub(2):lower()) end
			if not class or type(class)~='table' then class = getglobal(name:upper()) end
			if class and type(class)=='table' then
				if (class.version) then
					version = class.version
				elseif (class.Version) then
					version = class.Version
				elseif (class.VERSION) then
					version = class.VERSION
				end
			end
			local const = getglobal(name:upper().."_VERSION")
			if (const) then version = const end

			if type(version)=='table' then
        local allstr = true
        for k, v in pairs(version) do
          if type(v) ~= "string" then allstr = false end
        end
        
        if allstr then
          version = table.concat(version,":")
        end
			elseif type(version) == 'function' then
        local yay, v = pcall(version)
        
        if yay then version = v end
      end

			if (version) then
				addlist = addlist.."  "..name..", v"..tostring(version).."\n"
			else
				addlist = addlist.."  "..name.."\n"
			end
		end
	end
	return addlist
end

local error_uniqueness_whitelist = {
  ["count"] = true,
  ["timestamp"] = true,
}

-- here's the logic
function QuestHelper_ErrorCatcher.CondenseErrors()
  if completely_started then
    while next(startup_errors) do
      _, err = next(startup_errors)
      table.remove(startup_errors)
      
      if not QuestHelper_Errors[err.type] then QuestHelper_Errors[err.type] = {} end
      
      local found = false
      
      for _, item in ipairs(QuestHelper_Errors[err.type]) do
        local match = true
        for k, v in pairs(err.dat) do
          if not error_uniqueness_whitelist[k] and item[k] ~= v then match = false break end
        end
        if match then for k, v in pairs(item) do
          if not error_uniqueness_whitelist[k] and err.dat[k] ~= v then match = false break end
        end end
        if match then
          found = true
          item.count = (item.count or 1) + 1
          break
        end
      end
      
      if not found then
        table.insert(QuestHelper_Errors[err.type], err.dat)
      end
    end
  end
end

function QuestHelper_ErrorCatcher_RegisterError(typ, dat)
  table.insert(startup_errors, {type = typ, dat = dat})
  QuestHelper_ErrorCatcher.CondenseErrors()
end

function QuestHelper_ErrorPackage(depth)
  return {
    timestamp = date("%Y-%m-%d %H:%M:%S"),
    local_version = QuestHelper_local_version,
    toc_version = QuestHelper_toc_version,
    game_version = GetBuildInfo(),
    locale = GetLocale(),
    mutation_passes_exceeded = QuestHelper and QuestHelper.mutation_passes_exceeded,
    stack = debugstack(depth or 4, 20, 20),
  }
end

StaticPopupDialogs["QH_EXPLODEY"] = {
	text = "QuestHelper has broken. You may have to restart WoW. Type \"/qh error\" for a detailed error message.",
	button1 = OKAY,
	OnAccept = function(self)
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

function QuestHelper_ErrorCatcher_ExplicitError(loud, o_msg, o_frame, o_stack, ...)
  local msg = o_msg or ""  

  -- We toss it into StartupErrors, and then if we're running properly, we'll merge it into the main DB.
  local terror = QuestHelper_ErrorPackage()
  
  terror.message = msg
  terror.addons = QuestHelper_ErrorCatcher.GetAddOns()
  terror.stack = o_stack or terror.stack
  terror.silent = not loud
  
  QuestHelper_ErrorCatcher_RegisterError("crash", terror)
  
  if first_error and first_error.silent and not first_error.next_loud and not terror.silent then first_error.next_loud = terror first_error.addons = "" end
  if not first_error or first_error.generated then first_error = terror end
  
  QuestHelper_ErrorCatcher.CondenseErrors()

  if (--[[debug_output or]] loud) and not yelled_at_user then
    --print("qhbroken")
    StaticPopupDialogs["QH_EXPLODEY"] = {
      text = "QuestHelper has broken. You may have to restart WoW. Type \"/qh error\" for a detailed error message.",
      button1 = OKAY,
      OnAccept = function(self)
      end,
      timeout = 0,
      whileDead = 1,
      hideOnEscape = 1
    }
    
    StaticPopup_Show("QH_EXPLODEY")
    yelled_at_user = true
  end
end

function QuestHelper_ErrorCatcher_GenerateReport()
  if first_error then return end -- don't need to generate one
  
  local terror = QuestHelper_ErrorPackage()
  
  terror.message = "(Full report)"
  terror.addons = QuestHelper_ErrorCatcher.GetAddOns()
  terror.stack = ""
  terror.silent = "(Full report)"
  terror.generated = true
  
  first_error = terror
end

function QuestHelper_ErrorCatcher.OnError(o_msg, o_frame, o_stack, o_etype, ...)
  local errorize = false
  local loud = false
  if o_msg and string.find(o_msg, "QuestHelper") and not string.find(o_msg, "Cannot find a library with name") then loud = true end
  
  for lin in string.gmatch(debugstack(2, 20, 20), "([^\n]*)") do
    if string.find(lin, "QuestHelper") and not string.find(lin, "QuestHelper\\AstrolabeQH\\DongleStub.lua") then errorize = true end
  end
  
  if string.find(o_msg, "SavedVariables") then errorize, loud = false, false end
  if string.find(o_msg, "C stack overflow") then
    if loud then errorize = true end
    loud = false
  end
  
  if loud then errorize = true end
  
  if errorize then QuestHelper_ErrorCatcher_ExplicitError(loud, o_msg, o_frame, o_stack) end
  
  --[[
  if o_msg and
    (
      (
        string.find(o_msg, "QuestHelper")  -- Obviously we care about our bugs
      )
      or (
        string.find(debugstack(2, 20, 20), "QuestHelper")  -- We're being a little overzealous and catching any bug with "QuestHelper" in the stack. This possibly should be removed, I'm not sure it's ever caught anything interesting.
        and not string.find(o_msg, "Cartographer_POI")  -- Cartographer started throwing ridiculous numbers of errors on startup with QH in the stack, and since we caught stuff with QH in the stack, we decided these errors were ours. Urgh. Disabled.
      )
    )
    and not string.match(o_msg, "WTF\\Account\\.*")  -- Sometimes the WTF file gets corrupted. This isn't our fault, since we weren't involved in writing it, and there's also nothing we can do about it - in fact we can't even retrieve the remnants of the old file. We may as well just ignore it. I suppose we could pop up a little dialog saying "clear some space on your hard drive, dufus" but, meh.
    and not (string.find(o_msg, "Cannot find a library with name") and string.find(debugstack(2, 20, 20), "QuestHelper\\AstrolabeQH\\DongleStub.lua")) -- We're catching errors caused by other people mucking up their dongles. Ughh.
    then
      QuestHelper_ErrorCatcher_ExplicitError(o_msg, o_frame, o_stack)
  end]]
  
  return origHandler(o_msg, o_frame, o_stack, o_etype, unpack(arg or {}))  -- pass it on
end

seterrorhandler(QuestHelper_ErrorCatcher.OnError) -- at this point we can catch errors

function QuestHelper_ErrorCatcher.CompletelyStarted()
  completely_started = true
  
  -- Our old code generated a horrifying number of redundant items. My bad. I considered going and trying to collate them into one chunk, but I think I'm just going to wipe them - it's easier, faster, and should fix some performance issues.
  if not QuestHelper_Errors.version or QuestHelper_Errors.version ~= 1 then
    QuestHelper_Errors = {version = 1}
  end
  
  QuestHelper_ErrorCatcher.CondenseErrors()
end

function QuestHelper_ErrorCatcher_CompletelyStarted()
  QuestHelper_ErrorCatcher.CompletelyStarted()
end



-- and here is the GUI

local QHE_Gui = {}

function QHE_Gui.ErrorUpdate()
  QHE_Gui.ErrorTextinate()
  QHE_Gui.Error.Box:SetText(QHE_Gui.Error.curError)
  QHE_Gui.Error.Scroll:UpdateScrollChildRect()
	QHE_Gui.Error.Box:ClearFocus()
end

function TextinateError(err)
  local tserr = string.format("msg: %s\ntoc: %s\nv: %s\ngame: %s\nlocale: %s\ntimestamp: %s\nmutation: %s\nsilent: %s\n\n%s\naddons:\n%s", err.message, err.toc_version, err.local_version, err.game_version, err.locale, err.timestamp, tostring(err.mutation_passes_exceeded), tostring(err.silent), err.stack, err.addons)
  if err.next_loud then
    tserr = tserr .. "\n\n---- Following loud error\n\n" .. TextinateError(err.next_loud)
  end
  return tserr
end

function QHE_Gui.ErrorTextinate()
  if first_error then
    QHE_Gui.Error.curError = TextinateError(first_error)
  else
    QHE_Gui.Error.curError = "None"
  end
end

function QHE_Gui.ErrorClicked()
	if (QHE_Gui.Error.selected) then return end
	QHE_Gui.Error.Box:HighlightText()
	QHE_Gui.Error.selected = true
end

function QHE_Gui.ErrorDone()
	QHE_Gui.Error:Hide()
end


-- Create our error message frame. Most of this is also ganked from Swatter.
QHE_Gui.Error = CreateFrame("Frame", "QHE_GUIErrorFrame", UIParent)
QHE_Gui.Error:Hide()
QHE_Gui.Error:SetPoint("CENTER", "UIParent", "CENTER")
QHE_Gui.Error:SetFrameStrata("TOOLTIP")
QHE_Gui.Error:SetHeight(300)
QHE_Gui.Error:SetWidth(600)
QHE_Gui.Error:SetBackdrop({
	bgFile = "Interface/Tooltips/ChatBubble-Background",
	edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
	tile = true, tileSize = 32, edgeSize = 32,
	insets = { left = 32, right = 32, top = 32, bottom = 32 }
})
QHE_Gui.Error:SetBackdropColor(0.2,0,0, 1)
QHE_Gui.Error:SetScript("OnShow", QHE_Gui.ErrorShow)
QHE_Gui.Error:SetMovable(true)

QHE_Gui.ProxyFrame = CreateFrame("Frame", "QHE_GuiProxyFrame")
QHE_Gui.ProxyFrame:SetParent(QHE_Gui.Error)
QHE_Gui.ProxyFrame.IsShown = function() return QHE_Gui.Error:IsShown() end
QHE_Gui.ProxyFrame.escCount = 0
QHE_Gui.ProxyFrame.timer = 0
QHE_Gui.ProxyFrame.Hide = (
	function( self )
		local numEscapes = QHE_Gui.numEscapes or 1
		self.escCount = self.escCount + 1
		if ( self.escCount >= numEscapes ) then
			self:GetParent():Hide()
			self.escCount = 0
		end
		if ( self.escCount == 1 ) then
			self.timer = 0
		end
	end
)
QHE_Gui.ProxyFrame:SetScript("OnUpdate",
	function( self, elapsed )
		local timer = self.timer + elapsed
		if ( timer >= 1 ) then
			self.escCount = 0
		end
		self.timer = timer
	end
)
table.insert(UISpecialFrames, "QHE_GuiProxyFrame")

QHE_Gui.Drag = CreateFrame("Button", nil, QHE_Gui.Error)
QHE_Gui.Drag:SetPoint("TOPLEFT", QHE_Gui.Error, "TOPLEFT", 10,-5)
QHE_Gui.Drag:SetPoint("TOPRIGHT", QHE_Gui.Error, "TOPRIGHT", -10,-5)
QHE_Gui.Drag:SetHeight(8)
QHE_Gui.Drag:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")

QHE_Gui.Drag:SetScript("OnMouseDown", function() QHE_Gui.Error:StartMoving() end)
QHE_Gui.Drag:SetScript("OnMouseUp", function() QHE_Gui.Error:StopMovingOrSizing() end)

QHE_Gui.Error.Done = CreateFrame("Button", "", QHE_Gui.Error, "OptionsButtonTemplate")
QHE_Gui.Error.Done:SetText("Close")
QHE_Gui.Error.Done:SetPoint("BOTTOMRIGHT", QHE_Gui.Error, "BOTTOMRIGHT", -10, 10)
QHE_Gui.Error.Done:SetScript("OnClick", QHE_Gui.ErrorDone)

QHE_Gui.Error.Mesg = QHE_Gui.Error:CreateFontString("", "OVERLAY", "GameFontNormalSmall")
QHE_Gui.Error.Mesg:SetJustifyH("LEFT")
QHE_Gui.Error.Mesg:SetPoint("TOPRIGHT", QHE_Gui.Error.Prev, "TOPLEFT", -10, 0)
QHE_Gui.Error.Mesg:SetPoint("LEFT", QHE_Gui.Error, "LEFT", 15, 0)
QHE_Gui.Error.Mesg:SetHeight(20)
QHE_Gui.Error.Mesg:SetText("Select All and Copy the above error message to report this bug.")

QHE_Gui.Error.Scroll = CreateFrame("ScrollFrame", "QHE_GUIErrorInputScroll", QHE_Gui.Error, "UIPanelScrollFrameTemplate")
QHE_Gui.Error.Scroll:SetPoint("TOPLEFT", QHE_Gui.Error, "TOPLEFT", 20, -20)
QHE_Gui.Error.Scroll:SetPoint("RIGHT", QHE_Gui.Error, "RIGHT", -30, 0)
QHE_Gui.Error.Scroll:SetPoint("BOTTOM", QHE_Gui.Error.Done, "TOP", 0, 10)

QHE_Gui.Error.Box = CreateFrame("EditBox", "QHE_GUIErrorEditBox", QHE_Gui.Error.Scroll)
QHE_Gui.Error.Box:SetWidth(500)
QHE_Gui.Error.Box:SetHeight(85)
QHE_Gui.Error.Box:SetMultiLine(true)
QHE_Gui.Error.Box:SetAutoFocus(false)
QHE_Gui.Error.Box:SetFontObject(GameFontHighlight)
QHE_Gui.Error.Box:SetScript("OnEscapePressed", QHE_Gui.ErrorDone)
QHE_Gui.Error.Box:SetScript("OnTextChanged", QHE_Gui.ErrorUpdate)
QHE_Gui.Error.Box:SetScript("OnEditFocusGained", QHE_Gui.ErrorClicked)

QHE_Gui.Error.Scroll:SetScrollChild(QHE_Gui.Error.Box)

function QuestHelper_ErrorCatcher_ReportError()
  QHE_Gui.Error.selected = false
	QHE_Gui.ErrorUpdate()
	QHE_Gui.Error:Show()
end
