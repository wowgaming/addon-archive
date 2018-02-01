local core = BankStack
local L = core.L

local link_to_id = core.link_to_id
local encode_bagslot = core.encode_bagslot
local decode_bagslot = core.decode_bagslot
local encode_move = core.encode_move
local moves = core.moves

local bag_ids = core.bag_ids
local bag_stacks = core.bag_stacks
local bag_maxstacks = core.bag_maxstacks

local bagcache_from = {}
local bagcache_to = {}
function core.FillBags(arg)
	local to, from
	if arg and #arg > 2 then
		from, to = string.match(arg, "^([^%s]+)%s+([^%s]+)$")
		from = core.get_group(from)
		to = core.get_group(to)
	end
	if not (from and to) then
		from = core.player_bags
		to = core.bank_bags
	end
	if core.check_for_banks(from) or core.check_for_banks(to) then return end
	
	core.ScanBags()
	for _,bag in ipairs(from) do
		local bagtype = core.IsSpecialtyBag(bag)
		if not bagtype then bagtype = 'Normal' end
		if not bagcache_from[bagtype] then bagcache_from[bagtype] = {} end
		table.insert(bagcache_from[bagtype], bag)
	end
	for _,bag in ipairs(to) do
		local bagtype = core.IsSpecialtyBag(bag)
		if not bagtype then bagtype = 'Normal' end
		if not bagcache_to[bagtype] then bagcache_to[bagtype] = {} end
		table.insert(bagcache_to[bagtype], bag)
	end
	for bagtype, sorted_bags in pairs(bagcache_from) do
		if bagcache_to[bagtype] and #bagcache_to[bagtype] > 0 then
			core.Fill(sorted_bags, bagcache_to[bagtype])
			wipe(bagcache_to[bagtype])
		end
		wipe(sorted_bags)
	end
	core.StartStacking()
end

local empty_slots = {}
function core.Fill(source_bags, target_bags)
	-- source_bags and target_bags are tables ({1,2,3})
	-- Note: assumes that any item can be placed in any bag.
	if core.running then
		core.announce(0, L.already_running, 1, 0, 0)
		return
	end
	--Create a list of empty slots.
	for _, bag, slot in core.IterateBags(target_bags, nil, "deposit") do
		local bagslot = encode_bagslot(bag, slot)
		if (not core.db.ignore[bagslot]) and not bag_ids[bagslot] then
			table.insert(empty_slots, bagslot)
		end
	end
	--Move items from the back of source_bags to the front of target_bags
	for _, bag, slot in core.IterateBags(source_bags, true, "withdraw") do
		if #empty_slots == 0 then break end
		local bagslot = encode_bagslot(bag, slot)
		local target_bag, target_slot = decode_bagslot(empty_slots[1])
		if (not core.db.ignore[bagslot]) and bag_ids[bagslot] and not (core.is_guild_bank_bag(target_bag) and (core.CheckTooltipFor(bag, slot, ITEM_SOULBOUND) or core.CheckTooltipFor(bag, slot, ITEM_CONJURED) or core.CheckTooltipFor(bag, slot, ITEM_BIND_QUEST))) then
			core.AddMove(bagslot, table.remove(empty_slots, 1))
		end
	end
	wipe(empty_slots)
end

SlashCmdList["FILL"] = core.FillBags
SLASH_FILL1 = "/fill"
SLASH_FILL2 = "/fillbags"
