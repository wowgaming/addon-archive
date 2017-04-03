local lib = LibStub("LibItemBonus-2.0")

if not lib._LOADING then return end

local old_OnInitialize = lib.OnInitialize

lib.OnInitialize = function (lib)
	old_OnInitialize(lib)

	local L = lib.patterns

	if not L then
		lib:Print("does not support your locale.")
		L = {
			NAMES = {},
			PATTERNS_SKILL_RATING = {},
			SKILL_NAMES = {},
			PATTERNS_PASSIVE = {},
			SEPARATORS = {},
			GENERIC_PATTERNS = {},
			PATTERNS_GENERIC_LOOKUP = {},
			PATTERNS_GENERIC_STAGE1 = {},
			PATTERNS_GENERIC_STAGE2 = {},
			PATTERNS_OTHER = {},
		}
		lib.patterns = L
		function lib:IsValidName(name)
		end

		local empty = {}
		function lib:GetNameList()
			return empty
		end
		return
	end

	for _, p in ipairs(L.PATTERNS_PASSIVE) do
		if not p.nofinish then
			p.pattern = "^" .. p.pattern .. "$"
		else
			p.pattern = "^" .. p.pattern
			p.nofinish = nil
		end
		assert(p.effect)
	end
	for _, p in ipairs(L.PATTERNS_SKILL_RATING) do
		p.pattern = "^" .. p.pattern .. "$"
	end
	local t = {}
	for k, v in pairs(L.PATTERNS_GENERIC_LOOKUP) do
		local lk = k:lower()
		if t[lk] then
			assert(t[lk] == v)
		else
			t[lk] = v
		end
	end
	L.PATTERNS_GENERIC_LOOKUP = t
	for _, p in ipairs(L.PATTERNS_OTHER) do
		if not p.nofinish then
			p.pattern = "^" .. p.pattern .. "$"
		else
			p.pattern = "^" .. p.pattern
			p.nofinish = nil
		end
		assert(p.effect)
	end

	local bonus_names = {
		WEAPON_MIN = true,
		WEAPON_MAX = true,
		WEAPON_SPEED = true,
	}
	local function add_bonus_names(n)
		if type(n) == "table" then
			for _, name in ipairs(n) do
				add_bonus_names(name)
			end
		else
			bonus_names[n] = true
		end
	end

	for _, v in pairs(L.SKILL_NAMES) do
		add_bonus_names(v)
	end
	for _, v in ipairs(L.PATTERNS_PASSIVE) do
		add_bonus_names(v.effect)
	end
	for _, e in pairs(L.PATTERNS_GENERIC_LOOKUP) do
		add_bonus_names(e)
	end
	for _, v in ipairs(L.PATTERNS_GENERIC_STAGE1) do
		for _, v2 in ipairs(L.PATTERNS_GENERIC_STAGE2) do
			add_bonus_names(v.effect..v2.effect)
		end
	end
	for _, v in ipairs(L.PATTERNS_OTHER) do
		add_bonus_names(v.effect)
	end

	local names = {}
	for n in pairs(bonus_names) do
		names[#names + 1] = n
	end
	table.sort(names)

	function lib:IsValidName(name)
		return bonus_names[name]
	end

	function lib:GetNameList()
		return names
	end

	lib.GetPattern = nil
end

if IsLoggedIn() then
	lib:OnInitialize()
else
	local frame = lib.frame
	local old_handler = frame:GetScript"OnEvent"
	frame:SetScript("OnEvent", function (self)
		lib:OnInitialize()
		self:UnregisterEvent"PLAYER_LOGIN"
		self:SetScript("OnEvent", old_handler)
	end)
	frame:RegisterEvent"PLAYER_LOGIN"
end

lib._LOADING = nil
