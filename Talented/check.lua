local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

local function DisableTalented(s, ...)
	if TalentedFrame then TalentedFrame:Hide() end
	if s:find("%", nil, true) then
		s = s:format(...)
	end
	StaticPopupDialogs.TALENTED_DISABLE = {
		button1 = OKAY,
		text = L["Talented has detected an incompatible change in the talent information that requires an update to Talented. Talented will now Disable itself and reload the user interface so that you can use the default interface."]
			.."|n"..s,
		OnAccept = function()
			DisableAddOn"Talented"
			ReloadUI()
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		interruptCinematic = 1
	}
	StaticPopup_Show"TALENTED_DISABLE"
end

function Talented:CheckSpellData(class)
	if GetNumTalentTabs() < 1 then return end -- postpone checking without failing
	local spelldata, tabdata  = self.spelldata[class], self.tabdata[class]
	local invalid
	if #spelldata > GetNumTalentTabs() then
		print("too many tabs", #spelldata, GetNumTalentTabs())
		invalid = true
		for i = #spelldata, GetNumTalentTabs() + 1, -1 do
			spelldata[i] = nil
		end
	end
	for tab = 1, GetNumTalentTabs() do
		local talents = spelldata[tab]
		if not talents then
			print("missing talents for tab", tab)
			invalid = true
			talents = {}
			spelldata[tab] = talents
		end
		local name, _, _, background = GetTalentTabInfo(tab)
		tabdata[tab].name = name -- no need to mark invalid for these
		tabdata[tab].background = background
		if #talents > GetNumTalents(tab) then
			print("too many talents for tab", tab)
			invalid = true
			for i = #talents, GetNumTalents(tab) + 1, -1 do
				talents[i] = nil
			end
		end
		for index = 1, GetNumTalents(tab) do
			local talent = talents[index]
			if not talent then
				return DisableTalented("%s:%d:%d MISSING TALENT", class, tab, index)
			end
			local name, icon, row, column, _, ranks = GetTalentInfo(tab, index)
			if not name then
				if not talent.inactive then
					print("inactive talent", class, tab, index)
					talent.inactive = true
					invalid = true
				end
			else
				if talent.inactive then
					return DisableTalented("%s:%d:%d NOT INACTIVE", class, tab, index)
				end
				local found
				for _, spell in ipairs(talent.ranks) do
					if GetSpellInfo(spell) == name then found = true break end
				end
				if not found then
					local s, n = pcall(GetSpellInfo, talent.ranks[1])
					return DisableTalented("%s:%d:%d MISMATCHED %d ~= %s", class, tab, index, n or "unknown talent-"..talent.ranks[1], name)
				end
				if row ~= talent.row then
					print("invalid row for talent", tab, index, row, talent.row)
					invalid = true
					talent.row = row
				end
				if column ~= talent.column then
					print("invalid column for talent", tab, index, column, talent.column)
					invalid = true
					talent.column = column
				end
				if ranks > #talent.ranks then
					return DisableTalented("%s:%d:%d MISSING RANKS %d ~= %d", class, tab, index, #talent.ranks, ranks)
				end
				if ranks < #talent.ranks then
					invalid = true
					print("too many ranks for talent", tab, index, ranks, talent.ranks)
					for i = #talent.ranks, ranks + 1, -1 do
						talent.ranks[i] = nil
					end
				end
				local req_row, req_column, _, _, req2 = GetTalentPrereqs(tab, index)
				if req2 then
					print("too many reqs for talent", tab, index, req2)
					invalid = true
				end
				if not req_row then
					if talent.req then
						print("too many req for talent", tab, index)
						invalid = true
						talent.req = nil
					end
				else
					local req = talents[talent.req]
					if not req or req.row ~= req_row or req.column ~= req_column then
						print("invalid req for talent", tab, index, req and req.row, req_row, req and req.column, req_column)
						invalid = true
						-- it requires another pass to get the right talent.
						talent.req = 0
					end
				end
			end
		end
		for index = 1, GetNumTalents(tab) do
			local talent = talents[index]
			if talent.req == 0 then
				local row, column = GetTalentPrereqs(tab, index)
				for j = 1, GetNumTalents(tab) do
					if talents[j].row == row and talents[j].column == column then
						talent.req = j
						break
					end
				end
				assert(talent.req ~= 0)
			end
		end
	end
	if invalid then
		self:Print(L["WARNING: Talented has detected that its talent data is outdated. Talented will work fine for your class for this session but may have issue with other classes. You should update Talented if you can."])
	end
	self.CheckSpellData = nil
end
