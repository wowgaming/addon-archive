--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GatherSpecialCases.lua 754 2008-10-14 04:43:39Z Esamynn $

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
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
	
	Special Case Handling
	
	This file handles modifications that need to be made to various data tables
	throughout Gatherer that need to be "hacked up" in some fashion to handle
	Special Case nodes.
	
	THIS FILE SHOULD ALWAYS BE HEAVILY COMMENTED SO THAT IT IS EASY TO UNDERSTAND
	EXACTLY WHAT IS BEING DONE AND WHY!!!
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherSpecialCases.lua $", "$Rev: 754 $")

--[[
	A list of object categories for which all nodes in that category are treated 
	as a single node, both when displayed and when stored.  
]]
local AllNodesInCategoryAreSame = { 
	"TREASURE_POWERCRYST",
}

--[[
	Processing function that does the actual work.  This function nils itself
	out after running, to ensure that it can only ever be run once.  
]]
function Gatherer.SpecialCases.ProcessSpecialCases()
	for _, category in ipairs(AllNodesInCategoryAreSame) do
		local origIds = {}
		-- compile a list of the object ids in this category
		for id, cat in pairs(Gatherer.Categories.ObjectCategories) do
			if ( cat == category ) then
				origIds[id] = cat
				table.insert(origIds, id)
			end
		end
		
		-- abort if there are no nodes in this category
		if ( #origIds > 0 ) then
			-- add an entry to the table to point the category's token, 
			-- when used as an object id, back to the category token
			Gatherer.Categories.ObjectCategories[category] = category
			
			-- change each entry in the Names table that currently
			-- points to a node id in this category to point to the
			-- category token as its "node id"
			local Names = Gatherer.Nodes.Names
			for name, id in pairs(Names) do
				if ( origIds[id] ) then
					Names[name] = category
				end
			end
			
			-- add an entry to the Objects table to define the categories type as 
			-- the same as those of its nodes when the category token is used as 
			-- a node id
			Gatherer.Nodes.Objects[category] = Gatherer.Nodes.Objects[origIds[1]]
			
			-- add each original node id to the ReMappings table for it to be 
			-- re-mapped to using the category token as its new object id
			local ReMappings = Gatherer.Nodes.ReMappings
			for _, nodeId in ipairs(origIds) do
				ReMappings[nodeId] = category
			end
			
			-- add an entry to the pre-defined icons table for this category
			-- use the icon specified for the first node id listed in origIds
			-- because they should all be the same
			Gatherer.Icons[category] = Gatherer.Icons[origIds[1]]
		end
	end
	
	-- nil out this function so that it cannot be called again
	Gatherer.SpecialCases.ProcessSpecialCases = nil
end
