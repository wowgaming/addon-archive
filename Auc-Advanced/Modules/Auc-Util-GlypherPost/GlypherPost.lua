--[[
	Auctioneer Advanced - Price Level Utility module
	Version: 5.6.4409 (KangaII)
	Revision: $Id: GlypherPost.lua 3882 2008-12-02 16:36:58Z kandoko $
	URL: http://auctioneeraddon.com/

	This is an Auctioneer Advanced module that does something nifty.

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]]
if not AucAdvanced then return end

local libName = "GlypherPost"
local libType = "Util"

local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill, _TRANS = AucAdvanced.GetModuleLocals()

local _, _, _, _, _, GLYPH_TYPE = GetItemInfo(42956)
if not GLYPH_TYPE then GLYPH_TYPE = "Glyph" end


--[[
The following functions are part of the module's exposed methods:
	GetName()         (required) Should return this module's full name
	CommandHandler()  (optional) Slash command handler for this module
	Processor()       (optional) Processes messages sent by Auctioneer
	ScanProcessor()   (optional) Processes items from the scan manager
*	GetPrice()        (required) Returns estimated price for item link
*	GetPriceColumns() (optional) Returns the column names for GetPrice
	OnLoad()          (optional) Receives load message for all modules

	(*) Only implemented in stats modules; util modules do not provide
]]

function lib.GetName()
	return libName
end

function lib.Processor(callbackType, ...)
	if (callbackType == "tooltip") then
		--Called when the tooltip is being drawn.
		lib.ProcessTooltip(...)
	elseif (callbackType == "config") then
		--Called when you should build your Configator tab.
		private.SetupConfigGui(...)
	elseif (callbackType == "listupdate") then
		--Called when the AH Browse screen receives an update.
	elseif (callbackType == "configchanged") then
		--Called when your config options (if Configator) have been changed.
        if private.gui then private.gui:Refresh() end
	end
end

function lib.ProcessTooltip(frame, name, hyperlink, quality, quantity, cost, additional)
	-- In this function, you are afforded the opportunity to add data to the tooltip should you so
	-- desire. You are passed a hyperlink, and it's up to you to determine whether or what you should
	-- display in the tooltip.
end


function lib.OnLoad()
	--This function is called when your variables have been loaded.
	--You should also set your Configator defaults here

	print("AucAdvanced: {{"..libType..":"..libName.."}} loaded!")

private.durations = {
        { 720, _TRANS('APPR_Interface_12Hours')  },--12 hours
        { 1440, _TRANS('APPR_Interface_24Hours')  },--24 hours
        { 2880, _TRANS('APPR_Interface_48Hours')  },--48 hours
}

	default("util.glypherpost.bulk", true)
	default("util.glypherpost.duration", 1440)
	default("util.glypherpost.fixed.bid", 0)
	default("util.glypherpost.fixed.buy", 0)
	default("util.glypherpost.ignore", false)
	default("util.glypherpost.match", false)
	default("util.glypherpost.model", "default")
	default("util.glypherpost.number", 1)
	default("util.glypherpost.numberonly", true)
	default("util.glypherpost.smartonly", false)
	default("util.glypherpost.allowunders", 0)
	default("util.glypherpost.stack", 1)
	default("util.glypherpost.salesbased", false)
	default("util.glypherpost.minpost", 0)
	default("util.glypherpost.maxpost", 4)
	default("util.glypherpost.days", 7)
	default("util.glypherpost.hours", 24)
	default("util.glypherpost.development", false)
	default("util.glypherpost.splitdelay", 100) -- delay for each split in ms
	default("util.glypherpost.spliterrdelay", 250) -- delay for each split in ms AFTER a splitting error


--tshea               local curDurationMins = private.durations[curDurationIdx][1]
                --tshea local curDurationText = private.durations[curDurationIdx][2]

end

--[[ Local functions ]]--

function private.SetupConfigGui(gui)
	-- The defaults for the following settings are set in the lib.OnLoad function
	local id = gui:AddTab(libName)
    local frame = gui.tabs[id].content
    private.gui = gui
    private.id = id
    private.frame = frame

    frame.SetButtonTooltip = function(text)
        if text and get("util.appraiser.buttontips") then
            GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
            GameTooltip:SetText(text)
        end
    end

    gui:AddHelp(id, "what is GlypherPost?",
        "What is GlypherPost?",
        "GlyherPost is a work-in-progress. Its goal is to assist in quickly mass-posting glyphs in an easy-to-configure way."
    )

	gui:MakeScrollable(id)
	gui:AddControl(id, "Header",     0,    libName.." options")

	--gui:AddControl(id, "Checkbox", 0.5, 1, "util.glypherpost.ignore", "Hide glyphs")
    --gui:AddTip(id, "After posting, hide glyphs from Appraiser. Will not affect future GlypherPosts.")
	gui:AddControl(id, "Checkbox", 0.5, 1, "util.glypherpost.bulk", "Enable Batch Posting")
	gui:AddTip(id, "After posting, enable batch posting in Appraiser. Does not affect GlypherPost.")

	--local last = gui:GetLast(id)
	gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypherpost.stack", 1, 20, 1, "%sStack Size", private.stackFormat)
	gui:AddTip(id, "Number of glyphs per stack. This should probably be set to 1.")
	--gui:SetLast(id, last)
    --gui:AddControl(id, "MoneyFramePinned", 0.5, 1, "util.glypherpost.fixed.bid", 0, 101010, "Bid Each")
	--gui:AddTip(id, "Fixed bid amount. You should probably leave this blank.")

	--last = gui:GetLast(id)
	gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypherpost.number", 1, 20, 1, "%sNumber to Post", private.numberFormat)
	gui:AddTip(id, "Number of stacks to post. If you're using sales-based posting, this will be ignored.")
	--gui:SetLast(id,last)
    --gui:AddControl(id, "MoneyFramePinned", 0.5, 1, "util.glypherpost.fixed.buy", 0, 101010, "Buy Each")
    --gui:AddTip(id, "Fixed buy amount. You should probably leave this blank.")

	local last = gui:GetLast(id)
	gui:AddControl(id, "Checkbox", 0, 1, "util.glypherpost.numberonly", "Only")
	gui:AddTip(id, "Have a maximum of the number of stacks selected on the auctionhouse at any time.")
	gui:SetLast(id,last)
	gui:AddControl(id, "Checkbox", 0.125, 1, "util.glypherpost.smartonly", "Smart")
	gui:AddTip(id, "Have a maximum of the number of stacks selected - which you are the lowest priced seller - on the auctionhouse at any time. This could result in more stacks being posted, but you won't have to cancel your undercut auctions to have the lowest-priced auctions. This might require that you stock a lot more glyphs if you use this often.")

	last = gui:GetLast(id)
	gui:AddControl(id, "TinySlider", 0.0625, 1, "util.glypherpost.allowunders", -1, 10, 1, "Allow Competitors: %s", private.allowundersFormat)
	gui:AddTip(id, "Allow posts if X undercutters are below the lowest price you can post at. Setting to -1 disables this feature.")
	gui:SetLast(id,last)
	gui:AddControl(id, "Checkbox", 0.5, 1, "util.glypherpost.match", "Enable price matching")
	gui:AddTip(id, "Enable price matching. If you're using the Glypher pricing model, this will be ignored.")

	--local curDuration = get("util.glypherpost.duration") or 0
    --for i=1, #private.durations do
    --    if (curDuration == private.durations[i][1]) then
            --frame.salebox.duration:SetValue(i)
    --        duration = i
    --        break
    --    end
    --end


	local last = gui:GetLast(id)
	gui:AddControl(id, "Slider", 0, 1, "util.glypherpost.duration", 1, 3, 1, "Duration: %s hours", private.durationFormat)
	gui:AddTip(id, "The number of hours to post for.")
	gui:SetLast(id,last)
	gui:AddControl(id, "Selectbox", 0.5, 1, private.GetExtraPriceModels, "util.glypherpost.model", "Pricing Model")
	gui:AddTip(id, "The pricing model to use for posting.")

	gui:AddControl(id, "Checkbox", 0, 1, "util.glypherpost.salesbased", "Base number of stacks on sales")
	gui:AddTip(id, "Base the number of stacks on your sales history instead of the number configured above.")
	gui:AddControl(id, "NumeriSlider", 0, 2, "util.glypherpost.minpost", 0, 10, 1, "Minimum to Post")
	gui:AddTip(id, "Minimum number of stacks to post.")
	gui:AddControl(id, "NumeriSlider", 0, 2, "util.glypherpost.maxpost", 1, 20, 1, "Maximum to Post")
	gui:AddTip(id, "Maximum number of stacks to post.")
	gui:AddControl(id, "NumeriSlider", 0, 2, "util.glypherpost.days", 1, 28, 1, "Days to Consider")
	gui:AddTip(id, "Number of days of sales history to consider when evaluating how many to post.")
	gui:AddControl(id, "NumeriSlider", 0, 2, "util.glypherpost.hours", 12, 96, 12, "%sHours of Glyphs to Post", private.hoursFormat)
	gui:AddTip(id, "Number of hours worth of anticipated sales to post for.")

--devel
if get("util.glypherpost.development") then
    gui:AddControl(id, "Header",     0,    "Developer-only access to tunable options.")
	gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypherpost.splitdelay", 10, 1000, 10, "Split Delay")
	gui:AddControl(id, "NumeriSlider", 0, 1, "util.glypherpost.spliterrdelay", 20, 2000, 10, "Split Error Delay")
end

--add button

    frame.refreshButton = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
    frame.refreshButton:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 25, -100)
    frame.refreshButton:SetWidth(110)
    frame.refreshButton:SetText("Post Glyphs")
    frame.refreshButton:SetScript("OnClick", function() private.postGlyphs() end)
    frame.refreshButton:SetScript("OnEnter", function() return frame.SetButtonTooltip("Click to post glyphs as configured.") end)
    frame.refreshButton:SetScript("OnLeave", function() return GameTooltip:Hide() end)

end


local WARN = "|cffffff00"
local ERR = "|cffff0000"
local GREY = "|caaaaaaaa"

function private.numberFormat()
	local salesbased = get("util.glypherpost.salesbased")
	if salesbased then
		return GREY
	else
		return ""
	end
end
function private.allowundersFormat()
	local allowunders = get("util.glypherpost.allowunders")
	if allowunders < 0 then
		allowunders = "(disabled)"
	end
	return allowunders
end
		
function private.stackFormat()
	local stack = get("util.glypherpost.stack")
	local format = ""
	if stack > 1 then
		format = WARN
	end
	return format
end
function private.durationHours()
    local duration = get("util.glypherpost.duration")
    local hours = 48
    if duration == 1 then
        hours = 12
    elseif duration == 2 then
        hours = 24
    elseif duration == 3 then
        hours = 48
    end
	return hours
end
function private.durationFormat()
	local duration = get("util.glypherpost.duration")
	local hours = private.durationHours()
	local format = ""
	if hours > get("util.glypherpost.hours") then
		format = WARN
	end
	return format..hours, hours
end

function private.hoursFormat()
	local hours = private.durationHours()
	local format = ""
	if hours > get("util.glypherpost.hours") then
		format = WARN
	end
	return format
end	

local coPG 
local onupdateframe

function private.postGlyphs()
    if (not coPG) or (coroutine.status(coPG) == "dead") then
        coPG = coroutine.create(private.copostGlyphs)
        onupdateframe = CreateFrame("frame")

        onupdateframe:SetScript("OnUpdate", function()
            local status, result
            status = coroutine.status(coPG)
            if status ~= "dead" then
                status, result = coroutine.resume(coPG)
                if not status and result then
                    error("Error in search coroutine: "..result.."\n\n{{{Coroutine Stack:}}}\n"..debugstack(coPG));
                end
               end
        end)

                local status, result = coroutine.resume(coPG)
                if not status and result then
                        error("Error in search coroutine: "..result.."\n\n{{{Coroutine Stack:}}}\n"..debugstack(coPG));
                end
        else
                print("coroutine already running: "..coroutine.status(coPG))
        end
        coroutine.resume(coPG)
end

function private.copostGlyphs()

    if not AuctionFrame or not AuctionFrame:IsVisible() then
        print("Please visit your local auctioneer before using this function.")
        return
    end

	-- before diving into pre-splitting, we're just going to get the basics working
	-- following based on Norg's batch post macro:

	local bulk = get("util.glypherpost.bulk")
	local hours = private.durationHours()
	local duration = hours * 60 -- convert hours to minutes for posting
	local ignore = get("util.glypherpost.ignore")
	local match = get("util.glypherpost.match")
	local model = get("util.glypherpost.model")
	local number = get("util.glypherpost.number")
print("=================== number: " .. number)
	local GPnumber = number
	local numberonly = get("util.glypherpost.numberonly")
	local stack = get("util.glypherpost.stack")

	local salesbased = get("util.glypherpost.salesbased")
    local name = UnitName("player")
    local realm = GetRealmName()
    local account = "Default"
    local days = get("util.glypherpost.days") --how far back in beancounter to look, in days
    local minpost = get("util.glypherpost.minpost")
    local maxpost = get("util.glypherpost.maxpost")
    local days = get("util.glypherpost.days")
    local hours = get("util.glypherpost.hours")
    -- get our sales for 'days' period from bc
    -- use the DataStore list if DataStore is present, otherwise current toon only
    local altlist = get("util.glypher.altlist")

	local smartonly = get("util.glypherpost.smartonly")
	local allowunders = get("util.glypherpost.allowunders") or -1
	--if smartonly then allowunders = -1 end
	if smartonly then numberonly = false end




	local serverKey = AucAdvanced.GetFaction()
    local playerName = UnitName("player")
	local aprframe = AucAdvAppraiserFrame
    local glypherWhitelist = get("util.glypher.pricemodel.whitelist") or "" -- maybe we shouldn't use whitelist in case some users in it aren't ours? tshea
    local glypherIgnoretime = get("util.glypher.pricemodel.ignoretime") or 0
print("Posting glyphs...")
private.Timer("posting start")
	--for pos = 1, #(aprframe.list) do
	for pos = #(aprframe.list), 1, -1 do
		private.Timer("pre-apr-yield")
        coroutine.yield()
		private.Timer("post-apr-yield")
print("pos: " .. pos)
		local item = aprframe.list[pos]
		if item then
			private.Timer("if item")
			local link = item[7]
			local _, _, _, _, _, itemType, itemSubtype = GetItemInfo(link)
			private.Timer("got GetItemInfo")
			local linkType, itemId, property, factor = AucAdvanced.DecodeLink(link)
			private.Timer("got DecodeLink")
		    if (linkType ~= "item") then break end
    		itemId = tonumber(itemId)
    		property = tonumber(property) or 0
    		factor = tonumber(factor) or 0
            -- get the appraised price for our current item for later comparisons
            local buy, bid, _, _, curModel = AucAdvanced.Modules.Util.Appraiser.GetPrice(link, serverKey)
			private.Timer("got GetPrice")
--print("itemid/property/factor: " .. itemId .. "/" .. property .. "/" .. factor)
    		local data = AucAdvanced.API.QueryImage({
        		itemId = itemId,
        		suffix = property,
        		factor = factor,
    		})

			if itemType == GLYPH_TYPE then
				private.Timer("is GLYPH_TYPE")
                local mycurrent = 0 -- current auctions at or lower than our intended buy price
                local cannotmatch = 0
                local auctions = #data
				private.Timer("got #data")
                for j = 1, #data do
					private.Timer("data j: " .. j)
					coroutine.yield()
					private.Timer("data j post-yield")
					if not data[j] then
						print("breaking, data j nil")
						break
					end
                    local auction = AucAdvanced.API.UnpackImageItem(data[j])
					private.Timer("got UnpackiImageItem")
                    auction.buyoutPrice = (auction.buyoutPrice/auction.stackSize)
                    if auction.stackSize <= stack then -- we'll ignore larger stacks
						--print("seller name: " .. auction.sellerName)
						--print("my name: " .. playerName)
                        if auction.sellerName == playerName then -- it's ours
                            if (auction.buyoutPrice/auction.stackSize) <= buy then
                                mycurrent = mycurrent + 1
                            end
                        elseif (auction.buyoutPrice/auction.stackSize) < buy then
                            cannotmatch = cannotmatch + 1
                        end
                        --auction.sellerName
                        --auction.buyoutPrice
                        --auction.stackSize
                    end
                end

				-- set up this item's appraiser settings, backing up the old
				local sig = item[1]

				if salesbased then
--print("salesbased")
					local bcSold = 0
					local bcProfit = 0
					if DataStore and DataStore:IsModuleEnabled("DataStore_Auctions") then -- Auctions & Bids
    					for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
        					if string.find(":" .. name .. ":" .. altlist .. ":", ":" .. characterName .. ":") then
            					bcSold = bcSold + (BeanCounter.API.getAHSoldFailed(characterName, link, days) or 0)
        					end
    					end
					else
    					bcSold = BeanCounter.API.getAHSoldFailed(UnitName("player"), link, days) or 0
					end
					number = floor(bcSold/(days*24)*hours+.5)
					if number < minpost then number = minpost end
					if number > maxpost then number = maxpost end	
                    local failed = 0
                    if DataStore and DataStore:IsModuleEnabled("DataStore_Auctions") then -- Auctions & Bids
                        for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
                           	if string.find(":" .. name .. ":" .. altlist .. ":", ":" .. characterName .. ":") then
                               	local _, characterFailed = BeanCounter.API.getAHSoldFailed(characterName, link)
                                if characterFailed then failed = failed + characterFailed end
                            end
                        end
                    else 
                        local _, characterFailed = BeanCounter.API.getAHSoldFailed(UnitName("player"), link)
                        if characterFailed then failed = characterFailed end
                    end
					if failed < 40 then
						number = maxpost
					end
--print("========== salesbased " .. link .. " = " .. number)
				else
--print("not salesbased")
					local auctioncount = 0
	                if private.auctionCount and BeanCounter then
                        auctioncount = (private.auctionCount[itemName] or 0)
   		            end
--print("auctioncount: " .. auctioncount)
--print("number: " .. GPnumber)
					if numberonly and (auctioncount < (GPnumber * stack)) then
						number = floor(((GPnumber * stack) - auctioncount) / stack)
--print("post: " .. number)
					else
						number = GPnumber
					end
				end	

				if smartonly then
					-- set number to post
					--set("util.appraiser.item."..sig..".numberonly", false) -- set to false because we're going to determine the quantity manually
					--if mycurrent >= number then
						number = number - mycurrent
						if number < 0 then number = 0 end
					--end
				end
				if allowunders >= 0 then
					-- if there are more than allowunders under our current posting price, then set our number to post to zero
--print(link .. ": " .. cannotmatch .. " > " .. allowunders .. " then number = 0")
					if cannotmatch > allowunders then number = 0 end
				end

                local stock = GetItemCount(itemId, false)
                if (number * stack) > stock then
                    number = floor(stock/stack)
                end

				set("util.appraiser.item."..sig..".bulk", bulk)
				set("util.appraiser.item."..sig..".duration", duration)
				set("util.appraiser.item."..sig..".ignore", ignore)
				set("util.appraiser.item."..sig..".match", match)
				set("util.appraiser.item."..sig..".model", model)
				set("util.appraiser.item."..sig..".number", number)
				set("util.appraiser.item."..sig..".numberonly", numberonly)
				set("util.appraiser.item."..sig..".stack", stack)
				if number > 0 then
                    aprframe.PostBySig(sig)
					--print("posted " .. link)
					--print("number: " .. number)
				elseif numberonly then
					set("util.appraiser.item."..sig..".number", GPnumber)
				end
				-- then restore old settings
private.Timer("starting settings restore")
				--for pos = 1, #(settings) do
				--	coroutine.yield()
				--	local setting = settings[pos]
				--	set("util.appraiser.item."..sig.."."..setting,orig[pos])
				--end
private.Timer("ending settings restore")
			end
		end
	end

end

local timertext = "start"
local timer = time()
function private.Timer(newtimertext)
	--local newtimer = time()
	--print(timertext .. "->" .. newtimertext .. ": " .. newtimer-timer)
	--timertext = newtimertext
	--timer = newtimer
end

local itemLink

function private.GetExtraPriceModels(itemLink)
--print("Getting Extra Price Models")
    local vals = {}
    table.insert(vals, {"fixed", _TRANS('APPR_Interface_FixedPrice') })--Fixed price
    table.insert(vals, {"default", _TRANS('APPR_Interface_Default') })--Default
	table.insert(vals, {"market", _TRANS("UCUT_Interface_MarketValue")})--Market value (reusing Undercut's translation)
    local algoList = AucAdvanced.API.GetAlgorithms(itemLink)
    for pos, name in ipairs(algoList) do
        if (name ~= lib.libName) then
            table.insert(vals, {name, _TRANS('APPR_Interface_Stats').." "..name})--Stats:
--print(name .. " -> " .. _TRANS('APPR_Interface_Stats').." "..name) 
        end
    end
    return vals
end

function private.GetNumbers()
	return { {0, "Zero"}, {1, "One"}, {2, "Two"}, {3, "Three"}, {4, "Four"}, {5, "Five"}, {6, "Six"}, {7, "Seven"}, {8, "Eight"}, {9, "Nine"} }
end

function private.Foo()
end

function private.Bar()
end

function private.Baz()
end

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.6/Auc-Advanced/Modules/Auc-Util-GlypherPost/GlypherPost.lua $", "$Rev: 3882 $")
