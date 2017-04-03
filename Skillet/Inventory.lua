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

]]



-- recursive reagent craftability check
-- not considering alts at the moment
-- does consider queued recipes
function Skillet:InventoryReagentCraftability(reagentID, playerOverride)
	if self.visited[reagentID] then
		return 0, 0			-- we've been here before, so bail out to avoid infinite loop
	end
	
	local player = playerOverride or Skillet.currentPlayer
	
	self.visited[reagentID] = true
	
	
	local recipeSource = self.data.itemRecipeSource[reagentID]
	local numReagentsCrafted = 0
	local numReagentsCraftedBank = 0
	local skillIndexLookup = self.data.skillIndexLookup[player]
	
	if recipeSource then
		for childRecipeID in pairs(recipeSource) do
			local childRecipe = self:GetRecipe(childRecipeID)
			local childSkillIndex = skillIndexLookup[childRecipeID]    				-- only interested in current player for now
				
			if childSkillIndex and childRecipe then
				local numCraftable = 100000
				local numCraftableBank = 100000
				
				for i=1,#childRecipe.reagentData,1 do
					local childReagent = childRecipe.reagentData[i]
					
					local numReagentCraftable, numReagentCraftableBank = self:InventoryReagentCraftability(childReagent.id)
					
					numCraftable = math.min(numCraftable, math.floor(numReagentCraftable/childReagent.numNeeded))
					numCraftableBank = math.min(numCraftableBank, math.floor(numReagentCraftableBank/childReagent.numNeeded))
				end
				
					
				numReagentsCrafted = numReagentsCrafted + numCraftable * childRecipe.numMade
				numReagentsCraftedBank = numReagentsCraftedBank + numCraftableBank * childRecipe.numMade
			end
		end
	end
	
	
	local queued = 0
	
	if self.db.server.reagentsInQueue[player] then
		queued = self.db.server.reagentsInQueue[player][reagentID] or 0
	end
	
	local numInBags, _, numInBank = self:GetInventory(player, reagentID)
	
	local numCraftable = numReagentsCrafted + numInBags + queued
	local numCraftableBank = numReagentsCraftedBank + numInBank + queued
	
	local invCount = 4			-- number of records to keep (1 = bag, 2 = bag/bank, 4 = bag/craftBag/bank/craftBank)
	
	if numInBank == numInBags then
		if numCraftable == numCraftableBank then
			if numCraftable == numInBags then
				invCount = 1
			end
		end
	else
		if numCraftable == numInBags and numCraftableBank == numInBank then
			invCount = 2
		end
	end
	
	
	if invCount == 1 then
		Skillet.db.server.inventoryData[player][reagentID] = tostring(numInBags)
	elseif invCount == 2 then
		Skillet.db.server.inventoryData[player][reagentID] = numInBags.." "..numInBank
	else
		Skillet.db.server.inventoryData[player][reagentID] = numInBags.." "..numCraftable.." "..numInBank.." "..numCraftableBank
	end

	self.visited[reagentID] = false										-- okay to calculate this reagent again

	return numCraftable, numCraftableBank
end


local invscan = 1

function Skillet:InventoryScan(playerOverride)
--DEFAULT_CHAT_FRAME:AddMessage("InventoryScan "..invscan)
invscan = invscan + 1
	local player = playerOverride or self.currentPlayer
	local cachedInventory = self.db.server.inventoryData[player]
		
	local inventoryData = {}
	local numInBags, numInBank
	
	local reagent
	
	if not self.data then self.data = {} end
	
	
	if self.data.itemRecipeUsedIn then
		for reagentID in pairs(self.data.itemRecipeUsedIn) do
		
	--DebugSpam("reagent "..GetItemInfo(reagentID).." "..(inventoryData[reagentID] or "nil"))
						
			if reagentID and not inventoryData[reagentID] then								-- have we calculated this one yet?
				if self.currentPlayer == (UnitName("player")) then							-- if this is the current player, use the api
					numInBags = GetItemCount(reagentID)
					numInBank = GetItemCount(reagentID,true)								-- both bank and bags, actually
				elseif cachedInventory and cachedInventory[reagentID] then										-- otherwise, use the what cached data is available
--[[
					local data = { string.split(" ", cachedInventory[reagentID]) }
					
					if #data == 1 then
						numInBags = data[1]
						numInBank = data[1]
					elseif #data == 2 then
						numInBags = data[1]
						numInBank = data[2]
					else
						numInBags = data[1]
						numInBank = data[3]
					end
]]					
					local a,b,c,d = string.split(" ", cachedInventory[reagentID])
					
					if not b then
						numInBags = a
						numInBank = a
					elseif not c then
						numInBags = a
						numInBank = b
					else
						numInBags = a
						numInBank = c
					end
				else
					numInBags = 0
					numInBank = 0
				end
				
				if numInBags == numInBank then
					inventoryData[reagentID] = tostring(numInBags)							-- if items are all in bags, then leave off bank
				else
					inventoryData[reagentID] = numInBags.." "..numInBank					-- only setting the bags and bank for now (no craftability info)
				end
	--DebugSpam(inventoryData[reagentID])
			end
		end
	end
	 
	self.db.server.inventoryData[player] = inventoryData
	
	
	self.visited = {}							-- this is a simple infinite loop avoidance scheme: basically, don't visit the same node twice
	
	if inventoryData then
		-- now calculate the craftability of these same reagents
		for reagentID,inventory in pairs(inventoryData) do
			self:InventoryReagentCraftability(reagentID, player)
		end
		
		-- remove any reagents that don't show up in our inventory
		for reagentID,inventory in pairs(inventoryData) do
			if inventoryData[reagentID] == 0 or inventoryData[reagentID] == "0" or inventoryData[reagentID] == "0 0" or inventoryData[reagentID] == "0 0 0 0" then
				inventoryData[reagentID] = nil
			end
		end
	end
	
DebugSpam("InventoryScan Complete")
end




-- recipe iteration check: calculate how many times a recipe can be iterated with materials available
-- (not to be confused with the reagent craftability which is designed to determine how many craftable reagents are available for recipe iterations)
function Skillet:InventorySkillIterations(tradeID, skillIndex, playerOverride)
	local player = playerOverride or Skillet.currentPlayer
	local skill = self:GetSkill(player, tradeID, skillIndex)
	local recipe = self:GetRecipe(skill.id)
	
	if recipe and recipe.reagentData then							-- make sure that recipe is in the database before continuing
		local numCraftable = 100000
		local numCraftableVendor = 100000
		local numCraftableBank = 100000
		local numCraftableAlts = 100000
		
		local vendorOnly = true
		
		for i=1,#recipe.reagentData,1 do
			if recipe.reagentData[i].id then
				local reagentID = recipe.reagentData[i].id
				local numNeeded = recipe.reagentData[i].numNeeded
				
				local reagentAvailability = 0
				local reagentAvailabilityBank = 0
				local reagentAvailabilityAlts = 0
				local a,b
				
				a, reagentAvailability, b, reagentAvailabilityBank = self:GetInventory(player, reagentID)

--[[
				if self:VendorSellsReagent(reagentID) then								-- maybe should be an option, but if the item is available at vendors then assume the player could easily get some
					local _,_,_,_,_,_,_,stackSize = GetItemInfo(reagentID)
					local _,_,_,_,_,_,_,stackSizeMade = GetItemInfo(recipe.itemID)
					
					reagentAvailabilityBank = math.max((stackSize or 1), math.floor((stackSizeMade or 1)/recipe.numMade)*numNeeded)
					reagentAvailabilityAlts = reagentAvailabilityBank
				else
					for player in pairs(self.db.server.inventoryData) do
						
						local _,_,_, altBank = self:GetInventory(player, reagentID)
						
						reagentAvailabilityAlts = reagentAvailabilityAlts + (altBank or 0)
					end
				end
]]

				
					
				for player in pairs(self.db.server.inventoryData) do
					local _,_,_, altBank = self:GetInventory(player, reagentID)
					
					reagentAvailabilityAlts = reagentAvailabilityAlts + (altBank or 0)
				end
				
				if self:VendorSellsReagent(reagentID) then											-- if it's available from a vendor, then only worry about bag inventory
					numCraftable = math.min(numCraftable, math.floor(reagentAvailability/numNeeded))
				else
					vendorOnly = false
					
					numCraftable = math.min(numCraftable, math.floor(reagentAvailability/numNeeded))
					numCraftableVendor = math.min(numCraftableVendor, math.floor(reagentAvailability/numNeeded))
					numCraftableBank = math.min(numCraftableBank, math.floor(reagentAvailabilityBank/numNeeded))
					numCraftableAlts = math.min(numCraftableAlts, math.floor(reagentAvailabilityAlts/numNeeded))
				end
				
				
				if (numCraftableAlts == 0) then
					break
				end
				
			else												-- no data means no craftability
				numCraftable = 0
				numCraftableVendor = 0
				numCraftableBank = 0
				numCraftableAlts = 0
				
				self.dataScanned = false						-- mark the data as needing to be rescanned since a reagent id seems corrupt
			end
		end
		
		recipe.vendorOnly = vendorOnly
		

		return math.max(0,numCraftable * recipe.numMade), math.max(0,numCraftableVendor * recipe.numMade), math.max(0,numCraftableBank * recipe.numMade), math.max(0,numCraftableAlts * recipe.numMade)
	else
		DEFAULT_CHAT_FRAME:AddMessage("can't calc craft iterations!")
	end
	
	return 0, 0, 0, 0
end



function Skillet:GetInventory(player, reagentID)
	if player and reagentID then
		if self.db.server.inventoryData[player] and self.db.server.inventoryData[player][reagentID] and type(self.db.server.inventoryData[player][reagentID]) == "string" then
			local data = { string.split(" ", self.db.server.inventoryData[player][reagentID]) }
			
			if #data == 2 then											-- no craftability info yet
				return tonumber(data[1]) or 0, tonumber(data[1]) or 0, tonumber(data[2]) or 0, tonumber(data[2]) or 0
			elseif #data == 1 then
				return tonumber(data[1]) or 0, tonumber(data[1]) or 0, tonumber(data[1]) or 0, tonumber(data[1]) or 0
			else
				return tonumber(data[1]) or 0, tonumber(data[2]) or 0, tonumber(data[3]) or 0, tonumber(data[4]) or 0
			end
		end
	end
	
	return 0, 0, 0, 0			-- bags, bagsCraftable, bank, bankCraftable
end
