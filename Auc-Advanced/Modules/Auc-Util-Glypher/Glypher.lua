
if not AucAdvanced then return end

local libType, libName = "Util", "Glypher"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill, _TRANS = AucAdvanced.GetModuleLocals()

local tooltip = LibStub("nTipHelper:1")
local timeRemaining
local coFG
local onupdateframe
local INSCRIPTION_SPELLNAME = GetSpellInfo(45357)
local _, _, _, _, _, GLYPH_TYPE = GetItemInfo(42956)
if not GLYPH_TYPE then GLYPH_TYPE = "Glyph" end
print("Localized name of itemType for Glyphs: " .. GLYPH_TYPE)

-- temporary check for Auc-Stat-Glypher
if AucAdvanced.Modules.Stat.Glypher then
    message("For this version of Auc-Util-Glypher, you MUST manually copy (in game) your Auc-Stat-Glypher configuration over to Auc-Util-Glypher, AND disable Auc-Stat-Glypher. The Glypher pricing model is now included in Auc-Util-Glypher.")
    return
end
--
function lib.Processor(callbackType, ...)
    if (callbackType == "config") then
        private.SetupConfigGui(...)
    elseif (callbackType == "tooltip") then
        private.ProcessTooltip(...)
    elseif (callbackType == "configchanged") then
        private.ConfigChanged(...)
        if private.gui then private.gui:Refresh() end
    elseif (callbackType == "auctionui") then
        private.auctionHook() ---When AuctionHouse loads hook the auction function we need
    elseif (callbackType == "scanprogress") then
        private.ScanProgressReceiver(...)
    elseif (callbackType == "scanstats") then
        private.ScanComplete(...)
    end
end

--after Auction House Loads Hook the Window Display event
function private.auctionHook()
    hooksecurefunc("AuctionFrameAuctions_Update", private.storeCurrentAuctions)
end

function private.ScanComplete()
    --need to set last scan time so we can disable the refresh button for 2-5 minutes after doing a scan (to be nice to Blizzard and also to be able to notice when the refresh is actually done
    if private.frame then
        private.frame.refreshButton:Enable()
        private.frame.refreshButton:SetText("Scan Glyphs")
    end
end

function private.ScanProgressReceiver(state, totalAuctions, scannedAuctions, elapsedTime)
    totalAuctions = tonumber(totalAuctions) or 0
    scannedAuctions = tonumber(scannedAuctions) or 0
    elapsedTime = tonumber(elapsedTime) or 0

    --borrowed this from Auc-Util-ScanProgress/ScanProgress.lua
    local numAuctionsPerPage = NUM_AUCTION_ITEMS_PER_PAGE

    -- Prefer the elapsed time which is provided by core and excludes paused time.
    local secondsElapsed = elapsedTime or (time() - private.scanStartTime)

    local auctionsToScan = totalAuctions - scannedAuctions

    local currentPage = math.floor(scannedAuctions / numAuctionsPerPage)

    local totalPages = totalAuctions / numAuctionsPerPage
    if (totalPages - math.floor(totalPages) > 0) then
        totalPages = math.ceil(totalPages)
    else
        totalPages = math.floor(totalPages)
    end

    local auctionsScannedPerSecond = scannedAuctions / secondsElapsed
    local secondsToScanCompletion = auctionsToScan / auctionsScannedPerSecond
    timeRemaining = SecondsToTime(secondsToScanCompletion)
    --print(timeRemaining .. " - " .. secondsToScanCompletion) -- debug to figure out how to eliminate the -hugenumber Sec
    -- and when it's blank, then go back to just "Refresh Glyphs" since scanprogress seems to trigger after scancomplete
    if private.frame then
        if timeRemaining and auctionsScannedPerSecond and secondsElapsed and scannedAuctions and (secondsToScanCompletion > 1) and (secondsToScanCompletion < 600)  then
            private.frame.refreshButton:SetText(timeRemaining)
        else
            private.frame.refreshButton:SetText("Scan Glyphs")
        end
    end


end

function lib.OnLoad()
    default("util.glypher.moneyframeprofit", 35000)
    default("util.glypher.history", 14)
    default("util.glypher.stockdays", 2)
    default("util.glypher.minstock", 0)
    default("util.glypher.mincraft", 1)
    --default("util.glypher.mincraftthreshold", 50)
    default("util.glypher.maxstock", 5)
    --default("util.glypher.minoverstock", 0)
    --default("util.glypher.overstock", 0)
    default("util.glypher.failratio", 30)
    default("util.glypher.makefornew", 2)
    default("util.glypher.herbprice", 8000)
    default("util.glypher.profitAppraiser", 100)
    default("util.glypher.profitBeancounter", 100)
    default("util.glypher.profitMarket", 50)
    default("util.glypher.pricemodel.min1", get("util.glypher.pricemodel.min") or 32500)
    default("util.glypher.pricemodel.min2", get("util.glypher.pricemodel.min") or 35000)
    default("util.glypher.pricemodel.max", 999999)
    default("util.glypher.pricemodel.underpct", 1)
    default("util.glypher.pricemodel.useundercut", true)
    default("util.glypher.pricemodel.undercut", 1)
    default("util.glypher.pricemodel.whitelist", "")
    default("util.glypher.pricemodel.ignoretime", 0)
    default("util.glypher.misc.clearqueue", true)
    default("util.glypher.misc.inktrader", false)
    default("util.glypher.altlist", "")
    default("util.glypher.gvault", "")
    default("util.glypher.inks.found", false)
    default("util.glypher.debugTooltip", false)
    default("util.glypher.makemaxstock", false)
    default("util.glypher.hardminstock", false)


--Check to see if we've got a recent enough version of AucAdvanced
    local rev = AucAdvanced.GetCurrentRevision() or 0
    if rev < 4409 then
        local mess = "Auc-Util-Glypher requires Auctioneer Advanced build >= 4409"
        DEFAULT_CHAT_FRAME:AddMessage(mess,1.0,0.0,0.0)
        mess = "Auc-Util-Glypher will still load, but some features are guaranteed to NOT work"
        DEFAULT_CHAT_FRAME:AddMessage(mess,1.0,0.0,0.0)
    end

    local sideIcon
    if LibStub then
        local SlideBar = LibStub:GetLibrary("SlideBar", true)
        if SlideBar then
            sideIcon = SlideBar.AddButton("Glypher", "Interface\\AddOns\\Auc-Util-Glypher\\Images\\Glypher")
            sideIcon:RegisterForClicks("LeftButtonUp","RightButtonUp") --What type of click you want to respond to
            sideIcon:SetScript("OnClick", private.SlideBarClick) --same function that the addons current minimap button calls
            sideIcon.tip = {
            "Auc-Util-Glypher",
            "Open the glypher gui",
            --"{{Click}} Open the glypher gui",
            --"{{Right-Click}} BUTTON MOUSEOVER CLICK DESCRIPTION IF WANTED",--remove lines if not wanted
            }
        end
    end
    private.sideIcon = sideIcon
end

function lib.CommandHandler(command, ...)
    if (command == "help") then
        print("Help for Glypher - "..libName)
        local line = AucAdvanced.Config.GetCommandLead(libType, libName)
        print(line, "help}} - this", libName, "help")
        print(line, "show}} - show/hide the Glypher UI")
        print(line, "makemaxstock}} - toggle the makemaxstock flag - Warning: advanced users only")
        print(line, "hardminstock}} - toggle the hardminstock flag")
    elseif (command == "show") then
        private.SlideBarClick()
    elseif (command == "makemaxstock") then
        local makemaxstock = get("util.glypher.makemaxstock")
        if makemaxstock then
            set("util.glypher.makemaxstock", false)
            print("makemaxstock is now OFF")
        else
            set("util.glypher.makemaxstock", true)
            print("makemaxstock is now ON")
        end
    elseif (command == "hardminstock") then
        local hardminstock = get("util.glypher.hardminstock")
        if hardminstock then
            set("util.glypher.hardminstock", false)
            print("hardminstock is now OFF")
        else
            set("util.glypher.hardminstock", true)
            print("hardminstock is now ON")
        end
    end
end

function private.SlideBarClick(_, button)
    if private.gui and private.gui:IsShown() then
        AucAdvanced.Settings.Hide()
    else
        AucAdvanced.Settings.Show()
        private.gui:ActivateTab(private.id)
    end
    if not get("util.glypher.inks.found") then
        local mess = "The pricing model feature of Auc-Util-Glypher requires that you to use the 'Get Profitable' function in order to populate it's database."
        DEFAULT_CHAT_FRAME:AddMessage(mess,1.0,0.0,0.0)
    end
end


--[[ Local functions ]]--

local WARN = "|cffffff00"
local ERR = "|cffff0000"
function private.minstockFormat()
    local minstock = get("util.glypher.minstock")
    local mincraft = get("util.glypher.mincraft")
    local maxstock = get("util.glypher.maxstock")
    local makefornew = get("util.glypher.makefornew")
    local fmt = ""
    if (maxstock - minstock) < mincraft then fmt = WARN end -- This is a fairly illogical situation since the actual minstock is going to be maxstock - mincraft
    if makefornew < minstock then fmt = WARN end -- We'd end up making minstock instead
    if minstock > maxstock then fmt = ERR end -- This situation is illogical
    return fmt
end
function private.mincraftFormat()
    local minstock = get("util.glypher.minstock")
    local mincraft = get("util.glypher.mincraft")
    local maxstock = get("util.glypher.maxstock")
    local makefornew = get("util.glypher.makefornew")
    local fmt = ""
    if (maxstock - minstock) < mincraft then fmt = WARN end -- This is a fairly illogical situation since the actual minstock is going to be maxstock - mincraft
    if mincraft > makefornew then fmt = WARN end -- makefornew should be <= mincraft
    if maxstock < mincraft then fmt = ERR end -- In this situation we'd never craft anything at all
    return fmt
end
function private.maxstockFormat()
    local minstock = get("util.glypher.minstock")
    local mincraft = get("util.glypher.mincraft")
    local maxstock = get("util.glypher.maxstock")
    local makefornew = get("util.glypher.makefornew")
    local fmt = ""
    if (maxstock - minstock) < mincraft then fmt = WARN end -- This is a fairly illogical situation since the actual minstock is going to be maxstock - mincraft
    if makefornew > maxstock then fmt = WARN end -- We'd never make the total amount because maxstock is less than makefornew
    if maxstock < minstock then fmt = ERR end -- This situation is illogical
    if maxstock < mincraft then fmt = ERR end -- In this situation we'd never craft anything at all
    return fmt
end
function private.makefornewFormat()
    local minstock = get("util.glypher.minstock")
    local mincraft = get("util.glypher.mincraft")
    local maxstock = get("util.glypher.maxstock")
    local makefornew = get("util.glypher.makefornew")
    local fmt = ""
    if mincraft > makefornew then fmt = WARN end -- makefornew should be <= mincraft
    if makefornew < minstock then fmt = WARN end -- We'd end up making minstock instead
    if makefornew > maxstock then fmt = WARN end -- We'd never make the total amount because maxstock is less than makefornew
    return fmt
end

local frame
function private.SetupConfigGui(gui)
    -- The defaults for the following settings are set in the lib.OnLoad function
    local id = gui:AddTab(libName, libType.." Modules")
    gui:MakeScrollable(id)

    local SelectBox = LibStub:GetLibrary("SelectBox")
    local ScrollSheet = LibStub:GetLibrary("ScrollSheet")
    --Add Drag slot / Item icon
    frame = gui.tabs[id].content
    private.gui = gui
    private.id = id
    private.frame = frame

    frame.SetButtonTooltip = function(text)
        if text and get("util.appraiser.buttontips") then
            GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
            GameTooltip:SetText(text)
        end
    end

    gui:AddHelp(id, "what is Glypher?",
        "What is Glypher?",
        "Glyher is a work-in-progress. Its goal is to assist in managing a profitable glyph-based business." 
    )

    local moreHelp = ""
    local DSa, DSc, DSm
    if not DataStore then
        DSa = true
        DSc = true
        DSm = true
    else
        if not DataStore:IsModuleEnabled("DataStore_Auctions") then
            DSa = true
        end
        if not DataStore:IsModuleEnabled("DataStore_Containers") then
            DSc = true
        end
        if not DataStore:IsModuleEnabled( "DataStore_Mails") then
            DSm = true
        end
    end
    if DSa then
        moreHelp = moreHelp .. "Installing the DataStore_Auctions addon will allow Glypher to see auctions of specified alts.\n\n"
    end
    if DSc then
        moreHelp = moreHelp .. "Installing the DataStore_Containers addon will allow Glypher to see bags and banks of specified alts, as well as an optional guild vault.\n\n"
    end
    if DSm then
        moreHelp = moreHelp .. "Installing the DataStore_Mails addon will allow Glypher to see the mailboxes of specified alts.\n\n"
    end
    if moreHelp ~= "" then
        moreHelp = "Optional DataStore addons can improve your business efficiency by seeing what your glyph-handling alts have:\n\n" .. moreHelp
        gui:AddHelp(id, "More features are available:",
            "More features are available:",
            moreHelp
        )
    end


    gui:AddControl(id, "Subhead", 0, "Glypher: Profitable Glyph Utility")

    gui:AddControl(id, "Subhead", 0, "Glyph creation configuration")

    gui:AddControl(id, "MoneyFrame", 0, 1, "util.glypher.moneyframeprofit", "Minimum profit")
    gui:AddTip(id, "Sets the minimum profit required to queue glyphs to craft.")

    gui:AddControl(id, "Text", 0, 1, "util.glypher.ink", "Restrict ink to")
    gui:AddTip(id, "Restrict glyphs to those requiring this ink. Leave blank to craft all glyphs regardless of ink.")

    gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.history",    1, 31, 1, "Consider sales")
    gui:AddTip(id, "Consider sales you've made on all toons from the last number of days selected.")

    gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.failratio", 0, 500, 1, "expired filter")
    gui:AddTip(id, "The expired:success (slider:1) ratio at which we will not craft glyphs. For failures we go back to the start of BeanCounter history.\nIf set to 0 this feature will be disabled.")

    gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.stockdays", 1, 8, 1, "Days to stock")
    gui:AddTip(id, "Number of days worth of glyphs to stock based upon your considered sales")

    gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.minstock", 0, 40, 1, "%sMin Stock", private.minstockFormat)
    gui:AddTip(id, "Minimum number of each glyph to stock. This must be less than or equal to the Max Stock.")

    gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.mincraft", 1, 40, 1, "%sMin Craft", private.mincraftFormat)
    gui:AddTip(id, "Minimum number of each glyph to craft. Generally this should be less than or equal to the difference between Min Stock and Max Stock")

    --gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.mincraftthreshold", 0, 100, 10, "Min craft %%")
    --gui:AddTip(id, "Threshold for deciding on whether to craft Min Craft or none.")

    gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.maxstock", 1, 40, 1, "%sMax Stock", private.maxstockFormat)
    gui:AddTip(id, "Maximum number of each glyph to stock. This must be greater than or equal to the Min Stock.")

    --gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.minoverstock", 0, 100, 20, "Min overstock %%")
    --gui:AddTip(id, "Minimum percentage of over max stock to allow up to overstock to be made. Set to 0 to disable this feature.")

    --gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.overstock", 0, 60, 1, "Overstock")
    --gui:AddTip(id, "Maximimum stock to allow when Glypher wants to make at least min overstock more than max stock")

    gui:AddControl(id, "MoneyFrame", 0, 1, "util.glypher.herbprice", "Price of single Northrend herb")
    gui:AddTip(id, "Used to calculate the price of Ink of the Sea which can be traded for most other inks.")

    gui:AddControl(id, "Subhead", 0, "New glyph configuration")

    gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.makefornew", 0, 20, 1, "%sMake New", private.makefornewFormat)
    gui:AddTip(id, "Number of glyphs (newly learned or newly profitable) to make when there are zero sales and zero failures in history.")

    gui:AddControl(id, "Subhead", 0, "Glyph Valuation Method")

    local weightWords = "for evaluation of new or previously unprofitable glyphs."

    if AucAdvanced.Modules.Util.Appraiser then
        gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.profitAppraiser", 1, 100, 1, "Current model")
        gui:AddTip(id, "Relative weight for the current pricing model set " .. weightWords)
    else
        gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.profitAppraiser", 1, 100, 1, "|caaaaaaaaCurrent model")
        gui:AddTip(id, "Auc-Util-Appraiser is not enabled, so the current model weighting is disabled")
    end

    gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.profitBeancounter", 1, 100, 1, "Sales history")
    gui:AddTip(id, "Relative weight for the Beancounter sales history, restricted by your consideration period, " .. weightWords)

    gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypher.profitMarket", 1, 100, 1, "Market price")
    gui:AddTip(id, "Relative weight for the Market price " .. weightWords)

    gui:AddControl(id, "Subhead", 0, "Glypher pricing model")

    --gui:AddControl(id, "Subhead", 0, "Minimum Sale Price - 1-Ink Glyphs")
    gui:AddControl(id, "Note", 0, 1, nil, nil, "Minimum Sale Price - 1-Ink Glyphs")
    gui:AddControl(id, "MoneyFrame", 0, 1, "util.glypher.pricemodel.min1")
    gui:AddTip(id, "The price that Glypher will never go below on 1-ink glyphs in order to undercut others")

    gui:AddControl(id, "Note", 0, 1, nil, nil, "Minimum Sale Price - 2-Ink Glyphs")
    gui:AddControl(id, "MoneyFrame", 0, 1, "util.glypher.pricemodel.min2")
    gui:AddTip(id, "The price that Glypher will never go below on 2-ink glyphs in order to undercut others")

    --gui:AddControl(id, "Subhead", 0, "Maximum Sale Price")
    gui:AddControl(id, "Note", 0, 1, nil, nil, "Maximum Sale Price")
    gui:AddControl(id, "MoneyFrame", 0, 1, "util.glypher.pricemodel.max")
    gui:AddTip(id, "The price that Glypher will never go above in order to overcut others")


    gui:AddControl(id, "Note", 0, 1, nil, nil, "Undercut")
    gui:AddControl(id, "Slider", 0, 1, "util.glypher.pricemodel.underpct", 0, 20, 0.1, _TRANS('UCUT_Interface_UndercutMinimum').." %g%%")--Undercut:

    gui:AddControl(id, "Checkbox",   0, 1, "util.glypher.pricemodel.useundercut", _TRANS('UCUT_Interface_UndercutAmount') )--Specify undercut amount by coin value
    gui:AddTip(id, _TRANS('UCUT_HelpTooltip_UndercutAmount') )--Specify the amount to undercut by a specific amount, instead of by a percentage
    --gui:AddControl(id, "Subhead", 0, "Undercut Amount")
    --gui:AddControl(id, "Note", 0, 1, nil, nil, "Undercut Amount")
    gui:AddControl(id, "MoneyFramePinned", 0, 2, "util.glypher.pricemodel.undercut", 1, 99999999, _TRANS('UCUT_Interface_CurrentValue') )--Undercut Amount
    --gui:AddControl(id, "MoneyFrame", 0, 1, "util.glypher.pricemodel.undercut")
    gui:AddTip(id, "The amount that you undercut others")

    --gui:AddControl(id, "Subhead", 0, "Whitelist")
    gui:AddControl(id, "Note", 0, 1, nil, nil, "Whitelist")
    gui:AddControl(id, "Text", 0, 1, "util.glypher.pricemodel.whitelist")
    gui:AddTip(id, "The players to whitelist on undercuts (blank for no whitelist, separarate whitelisted users with a ':')") --eventually have a list to edit

    gui:AddControl(id, "Note", 0, 1, nil, nil, "Ignore Time Left")
    gui:AddControl(id, "Selectbox", 0, 1, {
        {0, "Disable"},
        {1, "30 Minutes"},
        {2, "2 Hours"}
    }, "util.glypher.pricemodel.ignoretime", "Ignore competitor auctions when time left is less than time selected.")
    gui:AddTip(id, "Ignore competitor auctions when time left is less than time selected.")

    gui:AddControl(id, "Subhead", 0, "Misc options")

    gui:AddControl(id, "Checkbox", 0, 1, "util.glypher.misc.clearqueue", "Auto clear skill queue")
    gui:AddTip(id, "Automatically clear the skill queue when 'Get Profit' or 'Add to Skill' are pressed.")

    gui:AddControl(id, "Checkbox", 0, 1, "util.glypher.misc.inktrader", "Use Ink Trader")
    gui:AddTip(id, "Use the ink trader in Dalaran instead of having the skill window recursively queue inks to be made.")

    gui:AddControl(id, "Checkbox", 0, 1, "util.glypher.debugTooltip", "Show debug tooltip")
    gui:AddTip(id, "Show some debugging information in item tooltips.")

    if DataStore then
        gui:AddControl(id, "Subhead", 0, "DataStore Configuration")
        
        gui:AddControl(id, "Note", 0, 1, nil, nil, "Alt list")
        gui:AddControl(id, "Text", 0, 1, "util.glypher.altlist")
        gui:AddTip(id, "List of alts which you use for your glyph business, separate alts with a ':'. Leave blank to disable.")

        gui:AddControl(id, "Note", 0, 1, nil, nil, "Guild")
        gui:AddControl(id, "Text", 0, 1, "util.glypher.gvault")
        gui:AddTip(id, "Guild name for the vault which you use for your glyph business. Leave blank to disable.")    
    end

    frame.refreshButton = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
    frame.refreshButton:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 325, 225)
    frame.refreshButton:SetWidth(110)
    frame.refreshButton:SetText("Scan Glyphs")
    frame.refreshButton:SetScript("OnClick", function() private.refreshAll() end)
    frame.refreshButton:SetScript("OnEnter", function() return frame.SetButtonTooltip("Click to do a category scan on glyphs, refreshing Auctioneers image of all glyphs.") end)
    frame.refreshButton:SetScript("OnLeave", function() return GameTooltip:Hide() end)

    frame.searchButton = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
    frame.searchButton:SetPoint("TOP", frame.refreshButton, "BOTTOM", 0, -5)
    frame.searchButton:SetWidth(110)
    frame.searchButton:SetText("Get Profitable")
    frame.searchButton:SetScript("OnClick", function() private.findGlyphs() end)
    frame.searchButton:SetScript("OnEnter", function() return frame.SetButtonTooltip("Click to get profitable glyphs.") end)
    frame.searchButton:SetScript("OnLeave", function() return GameTooltip:Hide() end)

    frame.skilletButton = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
    frame.skilletButton:SetPoint("TOP", frame.searchButton, "BOTTOM", 0, -5)
    frame.skilletButton:SetWidth(110)
    frame.skilletButton:SetText("Add to Skill")
    frame.skilletButton:SetScript("OnClick", function() private.addtoCraft() end)
    frame.skilletButton:SetScript("OnEnter", function() return frame.SetButtonTooltip("Click to add profitable glyphs from the list to Skillet.") end)
    frame.skilletButton:SetScript("OnLeave", function() return GameTooltip:Hide() end)

    --Create the glyph list results frame
    frame.glypher = CreateFrame("Frame", nil, frame)
    frame.glypher:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 32, edgeSize = 16,
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    })

    frame.glypher:SetBackdropColor(0, 0, 0.0, 0.5)
    frame.glypher:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -20, -138)
    frame.glypher:SetPoint("BOTTOM", frame, "BOTTOM", 0, -135)
    frame.glypher:SetWidth(275)
    frame.glypher:SetHeight(310)

    frame.glypher.sheet = ScrollSheet:Create(frame.glypher, {
        { "Glyph", "TOOLTIP", 150 },
        { "#", "NUMBER", 25 },
        { "Profit", "COIN", 60},
        --{ "index", "TEXT",0 },
        })

    function frame.glypher.sheet.Processor(callback, self, button, column, row, order, curDir, ...)
        if (callback == "OnMouseDownCell")  then

        elseif (callback == "OnClickCell") then

        elseif (callback == "ColumnOrder") then

        elseif (callback == "ColumnWidthSet") then

        elseif (callback == "ColumnWidthReset") then

        elseif (callback == "ColumnSort") then

        elseif (callback == "OnEnterCell")  then
            private.sheetOnEnter(button, row, column)
        elseif (callback == "OnLeaveCell") then
            GameTooltip:Hide()
        end
    end
end

function private.ProcessTooltip(frame, name, link, quality, quantity, cost, additional)
    if not get("util.glypher.debugTooltip") then return end
    if not link then return end
    if not DataStore then return end
    frame:SetColor(0.9, 0.3, 0.3)
    frame:AddLine("Glypher Debugging Data")
    local _, itemId = AucAdvanced.DecodeLink(link)
    local stock, a = private.GetStock(itemId)
    local i, v
    for i, v in ipairs(a) do
        frame:AddLine(v)
    end
    frame:AddLine("Total stock: " .. stock)
    local ink = get("util.glypher.inks."..itemId..".ink") or 0
    local count = get("util.glypher.inks."..itemId..".count") or 0
    frame:AddLine("Ink: " .. ink .. " count: " .. count)

    --the following was mostly just copy/pasted from another section to debug a situation with over-production of glyphs - solved
    local name = UnitName("player")
    local realm = GetRealmName()
    local account = "Default"
    local currentcharacter = format("%s.%s.%s", account, realm, name)
    local altList = get("util.glypher.altlist")
    local itemName = itemId
    local history = get("util.glypher.history") --how far back in beancounter to look, in days
    local HOURS_IN_DAY = 24
    local MINUTES_IN_HOUR = 60;
    local SECONDS_IN_MINUTE = 60;
    local SECONDS_IN_DAY = HOURS_IN_DAY * MINUTES_IN_HOUR * SECONDS_IN_MINUTE;
    local historyTime = time() - (history * SECONDS_IN_DAY)

    local bcSold = 0
    local bcProfit = 0
    if DataStore and DataStore:IsModuleEnabled("DataStore_Auctions") then -- Auctions & Bids
        for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
            if string.find(":" .. name .. ":" .. altList .. ":", ":" .. characterName .. ":") then
                bcSold = bcSold + (BeanCounter.API.getAHSoldFailed(characterName, link, history) or 0)
                bcProfit = bcProfit + (BeanCounter.API.getAHProfit(characterName, itemName, historyTime, time()) or 0)
            end
        end
    else
        bcSold = BeanCounter.API.getAHSoldFailed(UnitName("player"), link, history) or 0
        bcProfit, tmpLow, tmpHigh = BeanCounter.API.getAHProfit(UnitName("player"), itemName, historyTime, time()) or 0
    end
    frame:AddLine("bcSold: " .. bcSold)
    local currentAuctions = stock
    local stockdays = get("util.glypher.stockdays")
    local make = floor(bcSold/history * stockdays + .5) - currentAuctions -- using .9 for rounding because it's best not to miss a sale

    frame:AddLine("Wanting to make " .. make .. " (" .. bcSold .. "/" .. history .. "*" .. stockdays .. " + .5)")
end

function private.sheetOnEnter(button, row, column)
    local link, name, _
    link = private.frame.glypher.sheet.rows[row][column]:GetText() or "FAILED LINK"
    if link:match("^(|c%x+|H.+|h%[.+%])") then
        name = GetItemInfo(link)
    end
    GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
    if private.frame.glypher.sheet.rows[row][column]:IsShown()then --Hide tooltip for hidden cells
        if link and name then
            GameTooltip:SetHyperlink(link)
        end
    end
end

function private.ConfigChanged(setting, value, ...)
--     if setting == "util.glypher.craft" and value then
--         private.addtoCraft()
--         set("util.glypher.craft", nil) --for some reason teh button will not toggle a setting http://jira.norganna.org/browse/CNFG-89
--
--     elseif setting == "util.glypher.getglyphs" and value then
--         private.findGlyphs()
--         set("util.glypher.getglyphs", nil)
--     end
end
function private.findGlyphs()
    if not AuctionFrame or not AuctionFrame:IsVisible() then
        if not DataStore or not DataStore:IsModuleEnabled("DataStore_Auctions") then
            print("Please visit your local auctioneer before using this function.")
            return
        end
    end
    private.data = nil
    private.frame.glypher.sheet:SetData({}, Style)
    if get("util.glypher.misc.clearqueue") then
        if Skillet then
            if Skillet.ClearQueue then
                Skillet:ClearQueue()
            else
                print("Skillet detected but is not Lilsparky's clone of Skillet")
                print("Get Lilsparky's clone of Skillet at http://www.wowace.com/addons/skillet/repositories/lilsparkys-clone/files/")
            end
        end
        if ATSW_DeleteQueue then ATSW_DeleteQueue() end
    end
    if (not coFG) or (coroutine.status(coFG) == "dead") then
        coFG = coroutine.create(private.cofindGlyphs)
        onupdateframe = CreateFrame("frame")

        onupdateframe:SetScript("OnUpdate", function()
            local status, result
            status = coroutine.status(coFG)
            if status ~= "dead" then
                status, result = coroutine.resume(coFG)
                if not status and result then
                    error("Error in search coroutine: "..result.."\n\n{{{Coroutine Stack:}}}\n"..debugstack(coFG));
                end
               end
        end)

                local status, result = coroutine.resume(coFG)
                if not status and result then
                        error("Error in search coroutine: "..result.."\n\n{{{Coroutine Stack:}}}\n"..debugstack(coFG));
                end
        else
                print("coroutine already running: "..coroutine.status(coFG))
        end
        coroutine.resume(coFG)
end
function private.cofindGlyphs()
    private.frame.searchButton:Disable()
    set("util.glypher.inks.found", true)
    local MinimumProfit = get("util.glypher.moneyframeprofit")
    local quality = 2 --no rare quality items
    local history = get("util.glypher.history") --how far back in beancounter to look, in days
    local stockdays = get("util.glypher.stockdays")
    local minstock = get("util.glypher.minstock")
    local hardminstock = get("util.glypher.hardminstock")
    local mincraft = get("util.glypher.mincraft")
    --local mincraftthreshold = get("util.glypher.mincraftthreshold")
    local maxstock = get("util.glypher.maxstock")
    --local minoverstock = get("util.glypher.minoverstock")
    --local overstock = get("util.glypher.overstock")
    local failratio = get("util.glypher.failratio")
    local makefornew = get("util.glypher.makefornew")
    local herbprice = get("util.glypher.herbprice")
    local INK =  get("util.glypher.ink") or ""

    local HOURS_IN_DAY = 24
    local MINUTES_IN_HOUR = 60;
    local SECONDS_IN_MINUTE = 60;
    local SECONDS_IN_DAY = HOURS_IN_DAY * MINUTES_IN_HOUR * SECONDS_IN_MINUTE;
    local historyTime = time() - (history * SECONDS_IN_DAY)
    local qtyInk = 0

    local inkCost
    local resProb = 2.5
    inkCost = ((herbprice * 5) / resProb) * 2 -- 5 herbs divided by the average pigments you get, 2 to make ink of the sea

    if not inkCost then
        print("Error in inkCost - returned nill!!!!!!!")
    else
        print("Ink cost: " .. inkCost)
    end

    if DataStore and not DataStore:IsModuleEnabled("DataStore_Auctions") then
        if not private.auctionCount or not BeanCounter then 
            print("Please visit your local auctioneer before using this function. (auc/BC)")
            private.frame.searchButton:Enable()
            return
        end
    end

    private.data = {}
    private.Display = {}
    local currentSelection = GetTradeSkillLine() -- the "1" in the original code is superfluous -- this function takes no arguments
    if currentSelection ~= INSCRIPTION_SPELLNAME then
        local hasInscription = GetSpellInfo(INSCRIPTION_SPELLNAME)
        if not hasInscription then print("It does not look like this character has INSCRIPTION_SPELLNAME") return end
        CastSpellByName(INSCRIPTION_SPELLNAME) --open trade skill
    end
    --end lilsparky suggested change
    local numTradeSkills = GetNumTradeSkills()
    local name = UnitName("player")
    local realm = GetRealmName()
    local account = "Default"
    local currentcharacter = format("%s.%s.%s", account, realm, name)
    local altList = get("util.glypher.altlist")

    for ID = GetFirstTradeSkill(), GetNumTradeSkills() do
        coroutine.yield()
        local pctDone = 100 - floor((numTradeSkills-ID)/numTradeSkills*100)
        private.frame.searchButton:SetText("(" .. pctDone .. "%)")

        local link = GetTradeSkillItemLink(ID)
        local itemName = GetTradeSkillInfo(ID)
        local linkType,itemId,property,factor = AucAdvanced.DecodeLink(link)
        itemId = tonumber(itemId)

        if itemName:find("Glyph") then
            if link and link:match("^|c%x+|Hitem.+|h%[.*%]") and itemName and select(3, GetItemInfo(link)) <= quality then --if its a craftable line and not a header and lower than our Quality
                local reagentCost = 0
                local addInk = 0
                --Sum the cost of the mats to craft this item, parchment is not considered its really too cheap to matter
                local inkMatch = false --only match inks choosen by user
                for i = 1 ,GetTradeSkillNumReagents(ID) do
                    local inkName, _, count = GetTradeSkillReagentInfo(ID, 1)
                    local link = GetTradeSkillReagentItemLink(ID, i)
                    --local inkPrice = AucAdvanced.API.GetMarketValue(link) or 0
                    local _, _, _, _, Id  = string.find(link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
                    local isVendored,isLimited,itemCost,toSell,buyStack,maxStack = Informant.getItemVendorInfo(Id)
                    if string.find(":43126:43120:43124:37101:43118:43116:39774:39469:43122:", ":" .. Id .. ":") then
                        reagentCost = (reagentCost + (inkCost * count) )
                        addInk = addInk + count
                        set("util.glypher.inks."..itemId..".ink", 43126)
                        set("util.glypher.inks."..itemId..".count", count)
                    elseif Id == 43127 then
                        reagentCost = (reagentCost + (inkCost * count * 10) )
                        addInk = addInk + (count * 10)
                        set("util.glypher.inks."..itemId..".ink", 43127)
                        set("util.glypher.inks."..itemId..".count", count)
                    elseif isVendored then
                        reagentCost = (reagentCost + (itemCost * count) )
                    else
                        print("Not parchment or buyable ink -- " .. link .. "-- need market price")
                    end

                    if INK:match("-") then -- ignore a specific ink
                        local INK = INK:gsub("-","")
                        inkMatch = true
                        if inkName:lower():match(INK:lower()) then
                            inkMatch = false
                        end
                    else
                        if inkName:lower():match(INK:lower()) then
                            inkMatch = true
                        end
                    end
                end

                --We want these local to the loop (at least) because we're zeroing them if there is no price
                local profitAppraiser = get("util.glypher.profitAppraiser")
                local profitMarket = get("util.glypher.profitMarket")
                local profitBeancounter = get("util.glypher.profitBeancounter")

                --local price = AucAdvanced.API.GetMarketValue(link)
                local priceAppraiser = 0
                if AucAdvanced.Modules.Util.Appraiser then
                    priceAppraiser = AucAdvanced.Modules.Util.Appraiser.GetPrice(link, AucAdvanced.GetFaction()) or 0
                end

                if priceAppraiser == 0 then profitAppraiser = 0 end
                local priceMarket = AucAdvanced.API.GetMarketValue(link) or 0
                if priceMarket == 0 then profitMarket = 0 end

                local bcSold = 0
                local bcProfit = 0
                if DataStore and DataStore:IsModuleEnabled("DataStore_Auctions") then -- Auctions & Bids
                       for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
                        if string.find(":" .. name .. ":" .. altList .. ":", ":" .. characterName .. ":") then
                            bcSold = bcSold + (BeanCounter.API.getAHSoldFailed(characterName, link, history) or 0)
                            bcProfit = bcProfit + (BeanCounter.API.getAHProfit(characterName, itemName, historyTime, time()) or 0)
                        end
                    end
                else    
                    bcSold = BeanCounter.API.getAHSoldFailed(UnitName("player"), link, history) or 0
                    bcProfit, tmpLow, tmpHigh = BeanCounter.API.getAHProfit(UnitName("player"), itemName, historyTime, time()) or 0 
                end

                local priceBeancounter
                if bcProfit > 0 and bcSold > 0 then
                    priceBeancounter = floor(bcProfit/bcSold)
                else
                    priceBeancounter = 0
                end
                if priceBeancounter == 0 then profitBeancounter = 0 end
                --evalutate based upon weights
                local profitTotalWeight = profitAppraiser + profitMarket + profitBeancounter
                if profitTotalWeight == 0 then
                    print("profitTotalWeight is 0 - changing to 1")
                    profitTotalWeight = 1
                end
                local worthPrice = floor((priceAppraiser * (profitAppraiser/profitTotalWeight)) + (priceMarket * (profitMarket/profitTotalWeight)) + (priceBeancounter * (profitBeancounter/profitTotalWeight)))

                property = tonumber(property) or 0
                factor = tonumber(factor) or 0
                local data = AucAdvanced.API.QueryImage({
                        itemId = itemId,
                        suffix = property,
                        factor = factor,
                })
                competing = #data
                local buyoutMin = 99999999
                for j = 1, #data do
                        local compet = AucAdvanced.API.UnpackImageItem(data[j])
                        compet.buyoutPrice = (compet.buyoutPrice/compet.stackSize)
                        -- unused -- local postPrice = AucAdvanced.Modules.Util.Appraiser.GetPrice(itemId, serverKey) or 0
                        if compet.buyoutPrice < buyoutMin then
                                buyoutMin = compet.buyoutPrice
                        end
                end

                if worthPrice > buyoutMin then
                    worthPrice = buyoutMin
                end

            --if we match the ink and our profits high enough, check how many we currently have on AH
                if worthPrice and (worthPrice - reagentCost) >= MinimumProfit and inkMatch then
                    local currentAuctions = private.GetStock(itemId)

                    local make = floor(bcSold/history * stockdays + .5) - currentAuctions -- using .9 for rounding because it's best not to miss a sale
                    local failed = 0
                    if DataStore and DataStore:IsModuleEnabled("DataStore_Auctions") then -- Auctions & Bids
                        for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
                               if string.find(":" .. name .. ":" .. altList .. ":", ":" .. characterName .. ":") then
                                local _, characterFailed = BeanCounter.API.getAHSoldFailed(characterName, link)
                                if characterFailed then failed = failed + characterFailed end
                            end
                        end
                    else  
                        local _, characterFailed = BeanCounter.API.getAHSoldFailed(UnitName("player"), link) 
                        if characterFailed then failed = characterFailed end
                    end

                    if bcSold == 0 and failed == 0 and currentAuctions == 0 then
                        make = makefornew
                        local mess = "New glyph: " .. link
                        DEFAULT_CHAT_FRAME:AddMessage(mess,1.0,0.0,0.0)
                    end
                    local makemaxstock = get("util.glypher.makemaxstock")
                    if makemaxstock and (currentAuctions == 0) and (make < maxstock) then make = maxstock end
                    if (make > 0 or hardminstock) and ((make + currentAuctions) < minstock) then make = (minstock - currentAuctions) end
                    if (make > 0) and (make < mincraft) then
                        --if (make >= (mincraft * (mincraftthreshold/100))) or (currentAuctions <  minstock) or (currentAuctions == 0) then
                        --if (currentAuctions < minstock) or (currentAuctions == 0) then
                            make = mincraft
                        --else
                        --    make = 0
                        --end
                    end
                    --if (minoverstock > 0) and (make + currentAuctions) > maxstock and (make + currentAuctions) > (((100+minoverstock)/100)*maxstock) then
                    --    if (make + currentAuctions) > overstock then
                    --        make = (overstock - currentAuctions)
                    --    end
                    --elseif (make + currentAuctions) > maxstock then 
                    if (make + currentAuctions) > maxstock then
                        make = (maxstock - currentAuctions) 
                    end
                    if (make > 0) and (make < mincraft) then make = 0 end -- in this case we can't make mincraft because it would put us over the limit, so let's make none at all (this avoids repeatedly "topping off" stacks)
                    if make > 0 then
                        local failedratio
                        if (bcSold > 0) then failedratio = failed/bcSold else failedratio = failed end
                        --if (bcSold > 0 and failedratio < failratio) or failed == 0 or failratio == 0 then
                        if failedratio < failratio or failed == 0 or failratio == 0 then
                            table.insert(private.data, { ["link"] = link, ["ID"] = ID, ["count"] = make, ["name"] = itemName} )
                            table.insert(private.Display, {link, make, worthPrice - reagentCost} )
                            qtyInk = qtyInk + (addInk * make)    
                        else
                            local mess = "Skipping " .. link .. ": failedratio = " .. failedratio .. " (failed: " .. failed .. " / sold: " .. bcSold .. ")"
                            DEFAULT_CHAT_FRAME:AddMessage(mess,1.0,0.0,0.0)
                        end
                    end
                end
            end
        end
    end

    if get("util.glypher.misc.inktrader") then
        local _, link = GetItemInfo(43126)
        local mess = "You need " .. link .. "x" .. qtyInk .. " to process this queue."
        DEFAULT_CHAT_FRAME:AddMessage(mess,1.0,0.0,0.0)
    end
    private.frame.glypher.sheet:SetData(private.Display, Style)
    private.frame.searchButton:Enable()
    private.frame.searchButton:SetText("Get Profitable")
end
--store the players current auctions
function private.storeCurrentAuctions()
    local count = {}
    local _, totalAuctions = GetNumAuctionItems("owner");

    if totalAuctions > 0 then
        for i = 1, totalAuctions do
            local name, _, c = GetAuctionItemInfo("owner", i)
            if name then
                if not count[name] then
                    count[name] = 0
                end
                count[name] = (count[name]+c)
            end
        end
    end
    private.auctionCount = count
    private.auctionCountRefresh = time()
end


function private.addtoCraft()
    local queueRecurse = not get("util.glypher.misc.inktrader")
    if not private.data then
        print("No glyphs to add to skill.")
        return
    end
    if Skillet and Skillet.QueueAppendCommand and Skillet.ClearQueue then
        if not Skillet.reagentsChanged then Skillet.reagentsChanged = {} end --this required table is nil when we use teh queue
        if not private.data then
            print("Glyph list is empty - use Get Profitable first.")
            return
        end
        if get("util.glypher.misc.clearqueue") then
            if Skillet then Skillet:ClearQueue() end
            if ATSW_DeleteQueue then ATSW_DeleteQueue() end
        end
        for i, glyph in ipairs(private.data) do
            local command = {}
            --index is needed for skillet to properly make use of our  data
            local _, index = Skillet:GetRecipeDataByTradeIndex(45357, glyph.ID)

            command["recipeID"] = index
            command["op"] = "iterate"
            command["count"] = glyph.count
            Skillet:QueueAppendCommand(command, queueRecurse)
        end
        Skillet:UpdateTradeSkillWindow()
        private.data = nil
        private.frame.glypher.sheet:SetData({}, Style)
    elseif ATSW_AddJobRecursive and atsw_preventupdate ~= nil then
        local atsw_tmp = atsw_preventupdate
        atsw_preventupdate = true
        for i, glyph in ipairs(private.data) do
            if queueRecurse then
                ATSW_AddJobRecursive(glyph.name, glyph.count)
            else
                ATSW_AddJobLL(glyph.name, glyph.count)
            end
        end
        atsw_preventupdate = atsw_tmp
        ATSW_ResetPossibleItemCounts();
        ATSWInv_UpdateQueuedItemList();
        ATSWFrame_UpdateQueue();
        ATSWFrame_Update();

        private.data = nil
        private.frame.glypher.sheet:SetData({}, Style)
    elseif ATSW_AddJobRecursive and atsw_preventupdate == nil then
        print("Advanced Trade Skill Window found, but needs to be patched in Interface/AddOns/AdvancedTradeSkillWindow/atsw.lua:")
        print("Change the following line:")
        print("local atsw_preventupdate=false;") 
        print("To:")
        print("atsw_preventupdate=false;")
        print("Then type /reloadui")
        print("---> Using Lilsparky's clone of Skillet instead of ATSW is HIGHLY recommended. <---")
        print("Get Lilsparky's clone of Skillet at http://www.wowace.com/addons/skillet/repositories/lilsparkys-clone/files/")
    else
        print("Lilsparky's clone of Skillet or Advanced Trade Skill Window not found")
        print("Get Lilsparky's clone of Skillet at http://www.wowace.com/addons/skillet/repositories/lilsparkys-clone/files/")
    end
end

function private.refreshAll()
    if not AuctionFrame or not AuctionFrame:IsVisible() then
        print("Please visit your local auctioneer before using this function.")
        return
    end
    private.frame.refreshButton:SetText("Scanning")
    private.frame.refreshButton:Disable()
    AucAdvanced.Scan.StartScan(nil, nil, nil, nil, 5, nil, nil, nil, nil)
end

function lib.GetPrice(link, faction, realm)
    local playerName = UnitName("player")
    local linkType, itemId, property, factor = AucAdvanced.DecodeLink(link)
    local glypherMin1 = get("util.glypher.pricemodel.min1")
    local glypherMin2 = get("util.glypher.pricemodel.min2")
    local glypherMax = get("util.glypher.pricemodel.max")
    local glypherUnderpct = get("util.glypher.pricemodel.underpct")
    local glypherUseundercut = get("util.glypher.pricemodel.useundercut")
    local glypherUndercut = get("util.glypher.pricemodel.undercut")
    local glypherWhitelist = get("util.glypher.pricemodel.whitelist")
    local glypherIgnoretime = get("util.glypher.pricemodel.ignoretime")
    if (linkType ~= "item") then return end
    itemId = tonumber(itemId)
    property = tonumber(property) or 0
    factor = tonumber(factor) or 0
    local data = AucAdvanced.API.QueryImage({
        itemId = itemId,
        suffix = property,
        factor = factor,
    })
    local auctions = #data
    local playerLow = glypherMax * 2
    local competitorLow = glypherMax * 2
    local whitelistLow = glypherMax * 2
    for j = 1, #data do
        local auction = AucAdvanced.API.UnpackImageItem(data[j])
        auction.buyoutPrice = (auction.buyoutPrice/auction.stackSize)
        itemId = auction.itemId
        local ink = get("util.glypher.inks."..itemId..".ink") or 43126
        local count = get("util.glypher.inks."..itemId..".count") or 2
        if ink == 43126 then
            if count == 1 then
                glypherMin = glypherMin1
            elseif count == 2 then
                glypherMin = glypherMin2
            else
                glypherMin = glypherMin2
                --print("Warning: Item " .. itemId .. " has not been scanned by Glypher:Get Profitable Glyphs, assuming for now that 2 inks are required to make.")
                --set("util.glypher.inks."..itemId..".count", 2)
            end
        else
            --print("Cannot find ink type " .. ink .. " for glyph " .. itemId .. " for pricing - check http://forums.norganna.org/8/ for information on an update to Auc-Util-Glypher")
            glypherMin = glypherMin2 -- fallback
        end
        if auction.stackSize == 1 then
            if auction.sellerName == playerName then
                if auction.buyoutPrice < playerLow then
                    playerLow = auction.buyoutPrice
                end
            elseif auction.sellerName ~= "" and string.find(":" .. glypherWhitelist .. ":", ":" .. auction.sellerName .. ":") then
                if auction.buyoutPrice < whitelistLow then
                    if auction.buyoutPrice >= glypherMin then
                        --this if we're in is so that we don't even both with prices below our min
                        whitelistLow = auction.buyoutPrice
                    end
                end
            else
                if auction.timeLeft > glypherIgnoretime then
                    if auction.buyoutPrice < competitorLow then
                        if auction.buyoutPrice >= glypherMin then
                            competitorLow = auction.buyoutPrice
                        end
                    end
                end
            end
        end
    end
    local newPrice = glypherMax
    if glypherUseundercut then
        newPrice = competitorLow - glypherUndercut
    else
        newPrice = floor(competitorLow*((100-glypherUnderpct)/100))
    end
    if newPrice > glypherMax then
        newPrice = glypherMax
    elseif newPrice < glypherMin then
        --what do we do with the new price in this case?
        --ideally we should match the 2nd lowest price minus undercut
        newPrice = glypherMin
    end    
    return newPrice
end

function lib.IsValidAlgorithm(link)
    if link then
        local _, _, _, _, _, itemType, itemSubtype = GetItemInfo(link) 
        if (GLYPH_TYPE == itemType) then
            return true
        end
    else
        return true
    end
    return false
end

function private.GetStock(itemId)
    local stockCount = 0
    local tooltip = {}
    local name = UnitName("player")
    local realm = GetRealmName()
    local account = "Default"
    local currentcharacter = format("%s.%s.%s", account, realm, name)
    local altList = get("util.glypher.altlist")
    local gVault = get("util.glypher.gvault")

    if DataStore and DataStore:IsModuleEnabled("DataStore_Auctions") then -- Auctions & Bids
        for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
            if string.find(":" .. name .. ":" .. altList .. ":", ":" .. characterName .. ":") then
                local add = (DataStore:GetAuctionHouseItemCount(character, itemId) or 0)
                stockCount = stockCount + add
--(DataStore:GetAuctionHouseItemCount(character, itemId) or 0)
                if add > 0 then table.insert(tooltip, "  Auctions " .. characterName .. " = " .. add) end
            end
        end
    else
        if private.auctionCount and BeanCounter then
            stockCount = stockCount + (private.auctionCount[itemName] or 0)
        end
    end
    if DataStore and DataStore:IsModuleEnabled("DataStore_Containers") then -- Bags, Bank, and Guild Bank
        for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
            if string.find(":" .. name .. ":" .. altList .. ":", ":" .. characterName .. ":") then
                local bagCount, bankCount = DataStore:GetContainerItemCount(character, itemId)
                stockCount = stockCount + bagCount + bankCount
                if bagCount > 0 then table.insert(tooltip, "  Bags " .. characterName .. " = " .. bagCount) end
                if bankCount > 0 then table.insert(tooltip, "  Bank " .. characterName .. " = " .. bankCount) end
            end
        end
        if gVault ~= "" then
            local guildKey = account .. "." .. realm .. "." .. gVault
            local guildCount =  DataStore:GetGuildBankItemCount(guildKey, itemId) or 0
            stockCount = stockCount + guildCount    
            if guildCount > 0 then table.insert(tooltip, "  Vault " .. gVault .. " = " .. guildCount) end
        end
    else
        stockCount = stockCount + GetItemCount(itemId, true)
    end
    if DataStore and DataStore:IsModuleEnabled("DataStore_Mails") then -- Mails
        for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
            if string.find(":" .. name .. ":" .. altList .. ":", ":" .. characterName .. ":") then
                local add = (DataStore:GetMailItemCount(character, itemId) or 0)
                stockCount = stockCount + add
--(DataStore:GetAuctionHouseItemCount(character, itemId) or 0)
                if add > 0 then table.insert(tooltip, "  Mail " .. characterName .. " = " .. add) end
            end
        end
    end
    return stockCount, tooltip
end
