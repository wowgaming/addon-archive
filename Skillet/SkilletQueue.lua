--[[

Skillet: A tradeskill window replacement.
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

local AceEvent = AceLibrary("AceEvent-2.0")

local QUEUE_DEBUG = false

-- iterates through a list of reagentIDs and recalculates craftability
function Skillet:AdjustInventory()
	if self.reagentsChanged then
		for id,v in pairs(self.reagentsChanged) do
			self:InventoryReagentCraftability(id)
		end
	end

	self:CalculateCraftableCounts()
	self.dataScanned = false

	self.reagentsChanged = {}
end


-- this is the simplest command:  iterate recipeID x count
-- this is the only currently implemented queue command
function Skillet:QueueCommandIterate(recipeID, count)
	local newCommand = {}

	newCommand.op = "iterate"
	newCommand.recipeID = recipeID
	newCommand.count = count

	return newCommand
end

-- command to craft "recipeID" until inventory has "count" "itemID"
-- not currently implemented
function Skillet:QueueCommandInventory(recipeID, itemID, count)
	local newCommand = {}

	newCommand.op = "inventory"
	newCommand.recipeID = recipeID
	newCommand.itemID = itemID
	newCommand.count = count

	return newCommand
end

-- command to craft "recipeID" until a certain crafting level has been reached
-- not currently implemented
function Skillet:QueueCommandSkillLevel(recipeID, level)
	local newCommand = {}

	newCommand.op = "skillLevel"
	newCommand.recipeID = recipeID
	newCommand.count = level

	return newCommand
end


-- queue up the command and reserve reagents
function Skillet:QueueAppendCommand(command, queueCraftables)
	local recipe = Skillet:GetRecipe(command.recipeID)

	if recipe and not self.visited[command.recipeID] then
		self.visited[command.recipeID] = true

		local count = command.count
		local reagentsInQueue = self.db.server.reagentsInQueue[Skillet.currentPlayer]
		local reagentsChanged = self.reagentsChanged
		local skillIndexLookup = self.data.skillIndexLookup[Skillet.currentPlayer]

		for i=1,#recipe.reagentData,1 do
			local reagent = recipe.reagentData[i]

			local need = count * reagent.numNeeded
			local _,_,numInBank = Skillet:GetInventory(Skillet.currentPlayer, reagent.id)

			local have = numInBank + (reagentsInQueue[reagent.id] or 0);

			reagentsInQueue[reagent.id] = (reagentsInQueue[reagent.id] or 0) - need;

			reagentsChanged[reagent.id] = true

			if queueCraftables and need > have then
				local recipeSource = self.data.itemRecipeSource[reagent.id]

				if recipeSource then
					for recipeSourceID in pairs(recipeSource) do
						local skillIndex = skillIndexLookup[recipeSourceID]

						if skillIndex then
							command.complex = true						-- identify that this queue has craftable reagent requirements

							local recipeSource = Skillet:GetRecipe(recipeSourceID)

							local newCount = math.ceil((need - have)/recipeSource.numMade)

							local newCommand = self:QueueCommandIterate(recipeSourceID, newCount)

							newCommand.level = (command.level or 0) + 1

							self:QueueAppendCommand(newCommand, queueCraftables)
						end
					end
				end
			end
		end

		reagentsInQueue[recipe.itemID] = (reagentsInQueue[recipe.itemID] or 0) + command.count * recipe.numMade;

		reagentsChanged[recipe.itemID] = true

		Skillet:AddToQueue(command)

		self.visited[command.recipeID] = nil
	end
end


-- command.complex means the queue entry requires additional crafting to take place prior to entering the queue.
-- we can't just increase the # of the first command if it happens to be the same recipe without making sure
-- the additional queue entry doesn't require some additional craftable reagents
function Skillet:AddToQueue(command)
	local queue = self.db.server.queueData[self.currentPlayer]

	if (not command.complex) then		-- we can add this queue entry to any of the other entries
		local added

		for i=1,#queue,1 do
			if queue[i].op == "iterate" and queue[i].recipeID == command.recipeID then
				queue[i].count = queue[i].count + command.count
				added = true
				break
			end
		end

		if not added then
			table.insert(queue, command)
		end
	else
		table.insert(queue, command)
	end

	AceEvent:TriggerEvent("Skillet_Queue_Add")
end



function Skillet:RemoveFromQueue(index)
	local queue = self.db.server.queueData[self.currentPlayer]
	local command = queue[index]
	local reagentsInQueue = self.db.server.reagentsInQueue[Skillet.currentPlayer]
	local reagentsChanged = self.reagentsChanged

	if command.op == "iterate" then
		local recipe = self:GetRecipe(command.recipeID)

		reagentsInQueue[recipe.itemID] = (reagentsInQueue[recipe.itemID] or 0) - recipe.numMade * command.count
		reagentsChanged[recipe.itemID] = true

		for i=1,#recipe.reagentData,1 do
			local reagent = recipe.reagentData[i]

			reagentsInQueue[reagent.id] = (reagentsInQueue[reagent.id] or 0) + reagent.numNeeded * command.count
			reagentsChanged[reagent.id] = true
		end
	end

	table.remove(queue, index)

	self:AdjustInventory()
end


function Skillet:ClearQueue()
DebugSpam("ClearQueue")
	if #self.db.server.queueData[self.currentPlayer]>0 then

		self.db.server.queueData[self.currentPlayer] = {}
		self.db.server.reagentsInQueue[self.currentPlayer] = {}

		self.dataScanned = false

		self:UpdateTradeSkillWindow()
	end
DebugSpam("ClearQueue Complete")

	AceEvent:TriggerEvent("Skillet_Queue_Complete")
end


function Skillet:ProcessQueue()
DebugSpam("PROCESS QUEUE");
	local queue = self.db.server.queueData[self.currentPlayer]
	local command = queue[1]
	local skillIndexLookup = self.data.skillIndexLookup[self.currentPlayer]

	if self.currentPlayer ~= (UnitName("player")) then
DebugSpam("trying to process from an alt!")
		return
	end


	if command then
		if command.op == "iterate" then
			self.queuecasting = true

			local recipe = self:GetRecipe(command.recipeID)

			if self.currentTrade ~= recipe.tradeID then
    			CastSpellByName(self:GetTradeName(recipe.tradeID))					-- switch professions
            end

			self.processingSpell = self:GetRecipeName(command.recipeID)
--DEFAULT_CHAT_FRAME:AddMessage("processing: "..(self.processingSpell or "nil"))

			DoTradeSkill(skillIndexLookup[command.recipeID],command.count)

			return
		else
			DebugSpam("unsupported queue op: "..(command.op or "nil"))
		end
	else
		self.db.server.queueData[self.currentPlayer] = {}
		AceEvent:TriggerEvent("Skillet_Queue_Complete")
	end
end


-- Adds the currently selected number of items to the queue
function Skillet:QueueItems(count)
	local skill = self:GetSkill(self.currentPlayer, self.currentTrade, self.selectedSkill)

	if not skill then return 0 end

	local recipe = self:GetRecipe(skill.id)
	local recipeID = skill.id

	if not count then
		count = skill.numCraftable / (recipe.numMade or 1)

		if count == 0 then
			count = skill.numCraftableVendor / (recipe.numMade or 1)
		end

		if count == 0 then
			count = skill.numCraftableBank / (recipe.numMade or 1)
		end

		if count == 0 then
			count = skill.numCraftableAlts / (recipe.numMade or 1)
		end
	end

	count = math.min(count, 99)

	self.visited = {}

	if count > 0 then
		if self.currentTrade and self.selectedSkill then
			if recipe then
				local queueCommand = self:QueueCommandIterate(recipeID, count)

				self.reagentsChanged = {}
				self:QueueAppendCommand(queueCommand, Skillet.db.profile.queue_craftable_reagents)
				self:AdjustInventory()
			end
		end
	end

--	Skillet:UpdateQueueWindow()
	Skillet:UpdateTradeSkillWindow()
	return count
end

-- Queue the max number of craftable items for the currently selected skill
function Skillet:QueueAllItems()
	local count = self:QueueItems()						-- no argument means queue em all
	self:UpdateNumItemsSlider(0, false)
	return count
end


-- Adds the currently selected number of items to the queue and then starts the queue
function Skillet:CreateItems(count)
	if self:QueueItems(count) > 0 then
		self:ProcessQueue()
	end
end

-- Queue and create the max number of craftable items for the currently selected skill
function Skillet:CreateAllItems()
	if self:QueueAllItems() > 0 then
		self:ProcessQueue()
	end
end


function Skillet:StopCast(spell)
	local spellBeingCast = UnitCastingInfo("player")

if SkilletFrame:IsVisible() then
--	DEFAULT_CHAT_FRAME:AddMessage("StopCast "..(event or "nil"))
--	DEFAULT_CHAT_FRAME:AddMessage("StopCast "..(spellBeingCast or "nocast").." "..(spell or "nopass").." "..(self.processingSpell or "noproc"))
end

	if not self.db.server.queueData then
		self.db.server.queueData = {}
	end


	local queue = self.db.server.queueData[self.currentPlayer]

	if spell == self.processingSpell then
		if event == "UNIT_SPELLCAST_SUCCEEDED" then
			if not queue[1] then
				self.db.server.queueData[self.currentPlayer] = {}
--				AceEvent:TriggerEvent("Skillet_Queue_Complete")
				self.queuecasting = false
				self.processingSpell = nil

				self:UpdateTradeSkillWindow()
				return
--			else
--				if self:GetRecipe(queue[1].recipeID).tradeID == 7411 then
--					self.queuecasting = false
--					self.processingSpell = nil
--				end
			end

			if queue[1].op == "iterate" then
				queue[1].count = queue[1].count - 1
--DEFAULT_CHAT_FRAME:AddMessage("remove 1 from queue")

				if queue[1].count < 1 then
					self.queuecasting = false
					self.processingSpell = nil
					self.reagentsChanged = {}
					self:RemoveFromQueue(1)		-- implied queued reagent inventory adjustment in remove routine
					self:RescanTrade()
--					DEFAULT_CHAT_FRAME:AddMessage("removed queue command")
				end
			end
		else
			self.processingSpell = nil
			self.queuecasting = false
		end

--		DEFAULT_CHAT_FRAME:AddMessage("STOP CAST IS UPDATING WINDOW")

		self:InventoryScan()
		self:UpdateTradeSkillWindow()
	end
end

-- Stop a trade skill currently in prograess. We cannot cancel the current
-- item as that requires a "SpellStopCasting" call which can only be
-- made from secure code. All this does is stop repeating after the current item
function Skillet:CancelCast()
    StopTradeSkillRepeat()
end


-- Removes an item from the queue
function Skillet:RemoveQueuedCommand(queueIndex)
	if queueIndex == 1 then
        self:CancelCast()
    end

	self.reagentsChanged = {}
    self:RemoveFromQueue(queueIndex)

	self:UpdateQueueWindow()
	self:UpdateTradeSkillWindow()
end


-- Rebuilds reagentsInQueue list
function Skillet:ScanQueuedReagents()
DebugSpam("ScanQueuedReagents")
	local reagentsInQueue = {}

	for i,command in pairs(self.db.server.queueData[self.currentPlayer]) do
		if command.op == "iterate" then
			local recipe = self:GetRecipe(command.recipeID)

			if recipe.numMade > 0 then
				reagentsInQueue[recipe.itemID] = command.count * recipe.numMade + (reagentsInQueue[recipe.itemID] or 0)
			end

			for i=1,#recipe.reagentData,1 do
				local reagent = recipe.reagentData[i]

				reagentsInQueue[reagent.id] = (reagentsInQueue[reagent.id] or 0) - reagent.numNeeded * command.count
			end
		end
	end

	self.db.server.reagentsInQueue[self.currentPlayer] = reagentsInQueue
end


-- Returns a table {playername, queues} containing all queued
-- items
function Skillet:GetAllQueues()
    if not self.db.server.queues then
        return {}
    end

    return self.db.server.queues
end

-- Returns the list of queues for the specified player
function Skillet:GetQueues(player)
    assert(tostring(player),"Usage: GetQueues('player_name')")

    if not self.db.server.queues then
        return {}
    end

    if not self.db.server.queues[player] then
        return {}
    end

    return self.db.server.queues[player]
end

-- Returns the list of queues for the current player
function Skillet:GetPlayerQueues()
    return self:GetQueues(self.currentPlayer)
end

--
-- Checks the queued items and calculates how many of each reagent is required.
-- The table of reagents and counts is returned. The will examine the queues for
-- all professions, not just the currently selected on.
--
-- If the player name is not provided, then the queues for all players are checked.
--
-- The returned table contains:
--     name : name of the item
--     link : link for the item
--     count : how many of this item is needed
--     player : comma separated list of players that need the item for their queues
--
function Skillet:ReserveReagentsForQueuedRecipes(playername)
    local list = {}

    for player,playerqueues in pairs(self:GetAllQueues()) do
        -- check the queues for all professions
        if not playername or playername == player then
            for _,queue in pairs(playerqueues) do
                -- this is what we need
                if queue and #queue > 0 then
                    for i=1,#queue,1 do
                    	if (queue[i].op == "iterate") then
                    		local recipe = self:GetRecipe(queue[i].recipeID)
                    		local count = queue[i].count

							for j=1, #recipe.reagentData, 1 do
								local reagent = recipe.reagentData[j]
								local needed = count * reagent.numNeeded

								list[reagentID] = needed
							end
                        end

                    end
                end
            end
        end
    end

	self.reagentsInQueue = list
end
