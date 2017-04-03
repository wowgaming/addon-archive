--[[
	Norganna's Tooltip Helper class
	Version: 1.0
	Revision: $Id$
	URL: http://norganna.org/tthelp

	This is a slide-in helper class for the Norganna's AddOns family of AddOns
	It is designed to work with the LibExtraTip tooltip library and provide additional
	information that is useful for the Auctioneer et al AddOns.

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
		This source code is specifically designed to work with World of Warcraft's
		interpreted AddOn system.
		You have an implicit licence to use this code with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

		If you copy this code, please rename it to your own tastes, as this file is
		liable to change without notice and could possibly destroy any code that relies
		on it staying the same.
		We will attempt to avoid this happening where possible (of course).
]]

local MAJOR,MINOR,REVISION = "nTipHelper", 1, 1

--[[-----------------------------------------------------------------

LibStub is a simple versioning stub meant for use in Libraries.
See <http://www.wowwiki.com/LibStub> for more info.
LibStub is hereby placed in the Public Domain.
Credits:
    Kaelten, Cladhaire, ckknight, Mikk, Ammo, Nevcairiel, joshborke

--]]-----------------------------------------------------------------
do
	local LIBSTUB_MAJOR, LIBSTUB_MINOR = "LibStub", 2
	local LibStub = _G[LIBSTUB_MAJOR]

	if not LibStub or LibStub.minor < LIBSTUB_MINOR then
		LibStub = LibStub or {libs = {}, minors = {} }
		_G[LIBSTUB_MAJOR] = LibStub
		LibStub.minor = LIBSTUB_MINOR

		function LibStub:NewLibrary(major, minor)
			assert(type(major) == "string", "Bad argument #2 to `NewLibrary' (string expected)")
			minor = assert(tonumber(strmatch(minor, "%d+")), "Minor version must either be a number or contain a number.")

			local oldminor = self.minors[major]
			if oldminor and oldminor >= minor then return nil end
			self.minors[major], self.libs[major] = minor, self.libs[major] or {}
			return self.libs[major], oldminor
		end

		function LibStub:GetLibrary(major, silent)
			if not self.libs[major] and not silent then
				error(("Cannot find a library instance of %q."):format(tostring(major)), 2)
			end
			return self.libs[major], self.minors[major]
		end

		function LibStub:IterateLibraries() return pairs(self.libs) end
		setmetatable(LibStub, { __call = LibStub.GetLibrary })
	end
end
--[End of LibStub]---------------------------------------------------

local LIBSTRING = MAJOR..":"..MINOR
local lib = LibStub:NewLibrary(LIBSTRING,REVISION)
if not lib then return end

do -- tooltip class definition
	local libTT = LibStub("LibExtraTip-1")
	local MoneyViewClass = LibStub("LibMoneyFrame-1")

	local curFrame = nil
	local asText = false
	local defaultR = 0.7
	local defaultG = 0.7
	local defaultB = 0.7
	local defaultEmbed = false
	local itemData

	local activated = false
	local inLayout = false

	local GOLD="ffd100"
	local SILVER="e6e6e6"
	local COPPER="c8602c"

	local GSC_3 = "|cff%s%d|cff000000.|cff%s%02d|cff000000.|cff%s%02d|r"
	local GSC_2 = "|cff%s%d|cff000000.|cff%s%02d|r"
	local GSC_1 = "|cff%s%d|r"

	local iconpath = "Interface\\MoneyFrame\\UI-"
	local goldicon = "%d|T"..iconpath.."GoldIcon:0|t"
	local silvericon = "%s|T"..iconpath.."SilverIcon:0|t"
	local coppericon = "%s|T"..iconpath.."CopperIcon:0|t"


	local function coins(money, graphic)
		money = math.floor(tonumber(money) or 0)
		local g = math.floor(money / 10000)
		local s = math.floor(money % 10000 / 100)
		local c = money % 100

		if not graphic then
			if g > 0 then
				return GSC_3:format(GOLD, g, SILVER, s, COPPER, c)
			elseif s > 0 then
				return GSC_2:format(SILVER, s, COPPER, c)
			else
				return GSC_1:format(COPPER, c)
			end
		else
			if g > 0 then
				return goldicon:format(g)..silvericon:format("%02d"):format(s)..coppericon:format("%02d"):format(c)
			elseif s > 0  then
				return silvericon:format("%d"):format(s)..coppericon:format("%02d"):format(c)
			else
				return coppericon:format("%d"):format(c)
			end
		end
	end

	local function breakHyperlink(match, matchlen, ...)
		local v
		local n = select("#", ...)
		for i = 2, n do
			v = select(i, ...)
			if (v:sub(1,matchlen) == match) then
				return strsplit(":", v:sub(2))
			end
		end
	end

	function lib:BreakHyperlink(...)
		return breakHyperlink(...)
	end

	function lib:GetFactor(suffix, seed)
		if (suffix < 0 and seed) then
			return bit.band(seed, 65535)
		end
		return 0
	end

	local lastSaneLink, lastSanitized
	function lib:SanitizeLink(link)
		local _
		if not link then
			return
		end
		if type(link) == "number" then
			_, link = GetItemInfo(link)
		end
		if type(link) ~= "string" then
			return
		end
		if lastSanitized and (lastSanitized == link or lastSaneLink == link) then
			return lastSaneLink
		end
		lastSaneLink = string.gsub(link, "(|Hitem:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+):%d+(|h)", "%1:80%2")
		lastSanitized = link
		return lastSaneLink
	end

	function lib:DecodeLink(link, info)
		local lType,id,enchant,gem1,gem2,gem3,gemBonus,suffix,seed,factor
		local vartype = type(link)
		if (vartype == "string") then
			lType,id,enchant,gem1,gem2,gem3,gemBonus,suffix,seed = breakHyperlink("Hitem:", 6, strsplit("|", link))
			if (lType ~= "item") then return end
			id = tonumber(id) or 0
			enchant = tonumber(enchant) or 0
			suffix = tonumber(suffix) or 0
			seed = tonumber(seed) or 0
			factor = lib:GetFactor(suffix, seed)
		elseif (vartype == "number") then
			lType,id, suffix,factor,enchant,seed, gem1,gem2,gem3,gemBonus =
				"item",link, 0,0,0,0, 0,0,0,0
		end
		if info and type(info) == "table" then
			info.itemLink      = link
			info.itemType      = lType
			info.itemId        = id
			info.itemSuffix    = suffix
			info.itemFactor    = factor
			info.itemEnchant   = enchant
			info.itemSeed      = seed
			info.itemGem1      = gem1
			info.itemGem2      = gem2
			info.itemGem3      = gem3
			info.itemGemBonus  = gemBonus
		end
		return lType,id,suffix,factor,enchant,seed,gem1,gem2,gem3,gemBonus
	end

	function lib:GetLinkQuality(link)
		if not link or type(link) ~= "string" then return end
		local color = link:match("(|c%x+)|Hitem:")
		if color then
			local _, hex
			for i = 0, 6 do
				_,_,_, hex = GetItemQualityColor(i)
				if color == hex then return i end
			end
		end
		return -1
	end

	-- Call the given frame's SetHyperlink call
	function lib:ShowItemLink(frame, link, count, additional)
		libTT:SetHyperlinkAndCount(frame, link, count, additional)
	end

	-- Activation function. All client addons should call this when they get ADDON_LOADED
	function lib:Activate()
		if activated then return end
		libTT:RegisterTooltip(GameTooltip)
		libTT:RegisterTooltip(ItemRefTooltip)
		activated = true
	end

	-- Allow client addon to add their callback
	function lib:AddCallback(callback, priority)
		self:Activate() -- We should be activated by now, but make sure.
		libTT:AddCallback(callback, priority)
	end

	-- Accessor functions for the current frame that the tooltip is affecting
	function lib:SetFrame(frame)
		assert(libTT:IsRegistered(frame), "Error, frame is not registered with LibExtraTip in nTipHelper:SetFrame()")

		curFrame = frame
		inLayout = true
	end
	function lib:GetFrame()
		return curFrame
	end
	-- Try to Clear the frame after you've finished using it, this will stop stray reuse
	-- of the tooltip other than at the proper layout time.
	function lib:ClearFrame(tip)
		assert(tip == curFrame, "Error, frame is not the current frame in nTipHelper:ClearFrame()")
		curFrame = nil
		inLayout = false
	end

	-- Accessor functions for the data the tooltip contains
	function lib:SetData(data)
		itemData = data
	end
	function lib:GetData()
		return itemData
	end

	-- Sets the color that the tooltip will use from now on.
	-- (resets to default color between calls to modules)
	function lib:SetColor(r, g, b)
		defaultR = r
		defaultG = g
		defaultB = b
	end

	-- Sets the embed mode that the tooltip will use from now on.
	-- (resets to default mode between calls to modules)
	function lib:SetEmbed(embed)
		defaultEmbed = embed
	end

	-- Sets the money mode that the tooltip will use from now on.
	-- (resets to default mode between calls to modules)
	function lib:SetMoneyAsText(text)
		asText = text
	end

	-- Gets money as colorized text
	function lib:Coins(amount, graphic)
		return coins(amount, graphic)
	end

	--[[
	  Adds a line of text to the tooltip.

	  Supported calling formats:
	  lib:AddLine(text, [rightText | amount], [red, green, blue], [embed])
	]]
	function lib:AddLine(...)
		assert(inLayout, "Error, no tooltip to add line to in nTipHelper:AddLine()")
	
		local left, right, amount, red,green,blue, embed
		local numArgs = select("#", ...)
		local left = ...
		left = tostring(left)

		if numArgs > 1 then
			-- Check if the last arg is a boolean
			local lastArg = select(numArgs, ...)
			if type(lastArg) == "boolean" then
				-- Strip it off
				embed = lastArg
				numArgs = numArgs - 1
			end
		end

		if numArgs > 3 then
			-- Possible that the last 3 numbers are colors
			local r,g,b = select(numArgs-2, ...)

			if type(r)=="number" and type(g)=="number" and type(b)=="number" then
				if r>=0 and r<=1 and g>=0 and g<=1 and b>=0 and b<=1 then
					-- Assumption is that these are colors
					red,green,blue = r,g,b
					numArgs = numArgs - 3
				end
			end
		end

		if numArgs > 1 then
			-- There's a second parameter, if it's a number, it's a money amount
			-- otherwise it's the right-aligned text.
			local secondArg = select(2, ...)
			if type(secondArg) == "number" then
				if asText then
					right = coins(secondArg)
				else
					amount = secondArg
				end
			elseif right ~= nil then
				right = tostring(secondArg)
			end
		end

		red = tonumber(red)
		green = tonumber(green)
		blue = tonumber(blue)

		if red == nil or green == nil or blue == nil then
			-- Not all colors supplied
			red,green,blue = defaultR,defaultG,defaultB
		end
		if embed == nil then
			embed = defaultEmbed
		end
		left = left:gsub("{{", "|cffddeeff"):gsub("}}", "|r")
		if amount then
			libTT:AddMoneyLine(curFrame, left, amount, red, green, blue, embed)
		elseif right then
			libTT:AddDoubleLine(curFrame, left, right, red, green, blue, embed)
		else
			libTT:AddLine(curFrame, left, red, green, blue, embed)
		end
	end

	-- Return the extra information from this tooltip
	function lib:GetExtra()
		assert(inLayout, "Error, no tooltip to get extra info in nTipHelper:Extra()")
		return libTT:GetTooltipAdditional(curFrame)
	end

	function lib:CreateMoney(high, wide, red,green,blue)
		local m = MoneyViewClass:new(high, wide, red,green,blue);
		return m
	end

end -- tooltip class definition

