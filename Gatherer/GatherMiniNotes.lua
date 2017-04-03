--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GatherMiniNotes.lua 764 2008-10-20 18:05:49Z Esamynn $

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

	Minimap Drawing Routines
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherMiniNotes.lua $", "$Rev: 764 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

-- reference to the Astrolabe mapping library
local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)

local timeDiff = 0
local checkDiff = 0
local numNotesUsed = 0

-- table to store current active Minimap Notes objects
Gatherer.MiniNotes.Notes = {}

function Gatherer.MiniNotes.Show()
	if ( Gatherer.Config.GetSetting("minimap.enable") ) then
		if ( GatherMiniNoteUpdateFrame:IsShown() ) then
			Gatherer.MiniNotes.ForceUpdate()
		else
			GatherMiniNoteUpdateFrame:Show()
		end
	end
end

function Gatherer.MiniNotes.ForceUpdate()
	if ( GatherMiniNoteUpdateFrame:IsShown() ) then
		Gatherer.MiniNotes.UpdateMinimapNotes(0, true)
	end
end

function Gatherer.MiniNotes.Hide()
	GatherMiniNoteUpdateFrame:Hide()
	numNotesUsed = 0
	for i, note in pairs(Gatherer.MiniNotes.Notes) do
		Astrolabe:RemoveIconFromMinimap(note)
	end
end

local function GetMinimapNote( index )
	local note = Gatherer.MiniNotes.Notes[index]
	if not ( note ) then
		note = CreateFrame("Button", "GatherNote"..index, Minimap, "GatherNoteTemplate")
		Gatherer.MiniNotes.Notes[index] = note
		note:SetID(index)
	end
	return note
end

function Gatherer.MiniNotes.UpdateMinimapNotes(timeDelta, force)
	local setting = Gatherer.Config.GetSetting
	
	if ( Astrolabe.WorldMapVisible and (not Astrolabe:GetCurrentPlayerPosition()) ) then
		return
	end
	
	if not ( setting("minimap.enable") ) then
		Gatherer.MiniNotes.Hide()
		return
	end
	
	local updateIcons = false
	local updateNodes = false
	
	if ( force or Gatherer.Command.IsUpdated("minimap.update") ) then
		updateIcons = true
		updateNodes = true
	else
		checkDiff = checkDiff + timeDelta
		timeDiff = timeDiff + timeDelta
		if (checkDiff > Gatherer.Var.NoteCheckInterval) then
			updateNodes = true
			checkDiff = 0
			updateIcons = true
			timeDiff = 0
		
		elseif (timeDiff > Gatherer.Var.NoteUpdateInterval) then
			updateIcons = true
			timeDiff = 0
			
		end
	end
	
	if ( updateNodes ) then
		local c, z, px, py = Gatherer.Util.GetPositionInCurrentZone()
		if ( not (c and z and px and py) ) or ( c <= 0 ) or ( z <= 0 ) then
			Gatherer.MiniNotes.Hide()
			return
		end
		
		local maxDist = setting("minimap.distance", 800)
		local displayNumber = setting("minimap.count", 20)

		local getDist = maxDist
		local getNumber = displayNumber

		if Gatherer_HUD then
			Gatherer_HUD.BeginUpdate()
			getNumber = math.max(displayNumber, 500)
			getDist = math.max(maxDist, setting("plugin.gatherer_hud.yards"))
		end
	
		numNotesUsed = 0
		for i, nodeC,nodeZ, nodeID, nodePos, nodeDist, nodeX,nodeY, nodeCount, gtype, nodeHarvested, nodeInspected, nodeSource
		in Gatherer.Storage.ClosestNodesInfo(c, z, px, py, getNumber, getDist, Gatherer.Config.DisplayFilter_MiniMap) do
			if ( numNotesUsed < displayNumber ) then
				local nodeDist = Astrolabe:ComputeDistance(c,z,px,py, nodeC,nodeZ,nodeX,nodeY)
				if (nodeDist <= maxDist) then
					numNotesUsed = numNotesUsed + 1

					-- need to position and label the corresponding button
					local gatherNote = GetMinimapNote(numNotesUsed)
					gatherNote.id = nodeID
					gatherNote.continent = nodeC
					gatherNote.zone = nodeZ
					gatherNote.index = nodePos
					gatherNote.source = nodeSource
					gatherNote.dist = nodeDist
				
					local result = Astrolabe:PlaceIconOnMinimap(gatherNote, nodeC, nodeZ, nodeX, nodeY)
					-- a non-zero results some failure when adding the icon to the Minimap
					if ( result ~= 0 ) then
						numNotesUsed = numNotesUsed - 1
					end
				end
			end
			if ( Gatherer_HUD and nodeDist <= setting("plugin.gatherer_hud.yards") ) then
				Gatherer_HUD.PlaceIcon(nodeID, nodeC, nodeZ, nodeX, nodeY)
			end
		end
		
		local notes = Gatherer.MiniNotes.Notes
		for i = (numNotesUsed + 1), #(Gatherer.MiniNotes.Notes) do
			Astrolabe:RemoveIconFromMinimap(notes[i]);
		end
	end
	
	if ( updateIcons or updateNodes ) then
		local now = time()
		
		local normSize = setting("minimap.iconsize")
		local normOpac = setting("minimap.opacity") / 100
		local fadeEnab = setting("fade.enable")
		local fadeDist = setting("fade.distance")
		local fadePerc = setting("fade.percent") / 100
		local tracEnab = setting("track.enable")
		local tracCirc = setting("track.circle")
		local tracStyl = setting("track.style")
		local tracCurr = setting("track.current")
		local tracDist = setting("track.distance")
		local tracOpac = setting("track.opacity") / 100
		local inspEnab = setting("inspect.enable")
		local inspTint = setting("inspect.tint")
		local inspDist = setting("inspect.distance")
		local inspPerc = setting("inspect.percent") / 100
		local inspTime = setting("inspect.time")
		local anonEnab = setting("anon.enable")
		local anonTint = setting("anon.tint")
		local anonOpac = setting("anon.opacity") / 100
		local tooltip = setting("minimap.tooltip.enable")
		
		for i = 1, numNotesUsed do
			local gatherNote = GetMinimapNote(i)
			local nodeID = gatherNote.id
			local nodeC = gatherNote.continent
			local nodeZ= gatherNote.zone
			local nodePos = gatherNote.index
			local nodeSource = gatherNote.source
			
			local iconColor = "normal"
			local opacity = normOpac
			local nodeDist = Astrolabe:GetDistanceToIcon(gatherNote)
			
			if ( nodeDist ) then
				local selectedTexture, trimTexture = Gatherer.Util.GetNodeTexture(nodeID)
				
				-- If this icon has not been verified
				if ( anonEnab and nodeSource and (nodeSource ~= 'REQUIRE') and (nodeSource ~= "IMPORTED") ) then
					opacity = anonOpac
					if anonTint then
						iconColor = "red"
					end
				end
				
				-- If node is within tracking distance
				if ( tracEnab and (nodeDist <= tracDist) ) then
					if ( (not tracCurr) or Gatherer.Util.IsNodeTracked(nodeID) ) then
						if (tracCirc) then
							selectedTexture = "Interface\\AddOns\\Gatherer\\Shaded\\"..tracStyl
							trimTexture = false
						end
						opacity = tracOpac
					end
				end
				
				-- If we need to fade the icon (because of great distance)
				if ( fadeEnab ) then
					if nodeDist >= fadeDist then
						opacity = opacity * (1 - fadePerc)
					elseif ( nodeDist > tracDist ) then
						local range = math.max(fadeDist - tracDist, 0)
						local posit = math.min(nodeDist - tracDist, range)
						if (range > 0) then
							opacity = opacity * (1 - ( fadePerc * (posit / range) ))
						end
					end
				end
				
				-- If inspecting is enabled
				if (inspEnab) then
					-- If we are within inspect distance of this item, mark it as inspected
					if (nodeDist < inspDist) then
						Gatherer.Storage.SetNodeInspected(nodeC, nodeZ, nodeID, nodePos)
						if (inspTint) then
							iconColor = "green"
						end
						opacity = normOpac
				
					-- If we've recently seen this node, set its transparency
					else
						local nodeInspected = Gatherer.Storage.GetNodeInspected(nodeC, nodeZ, nodeID, nodePos)
						if (nodeInspected) then
							local delta = math.max(now - nodeInspected, 0)
							if (inspTime > 0) and (delta < inspTime) then
								opacity = opacity * (1 - ( inspPerc * (1 - (delta / inspTime)) ))
							end
						end
					end
				end
				
				-- Set the texture
				gatherNote:SetNormalTexture(selectedTexture)
				gatherNote:SetWidth(normSize)
				gatherNote:SetHeight(normSize)
				
				if (tooltip and not gatherNote:IsMouseEnabled()) then
					gatherNote:EnableMouse(true)
				elseif (not tooltip and gatherNote:IsMouseEnabled()) then
					gatherNote:EnableMouse(false)
				end
				
				local gatherNoteTexture = gatherNote:GetNormalTexture()
				
				-- Check to see if we need to trim the border off
				if (trimTexture) then
					gatherNoteTexture:SetTexCoord(0.08,0.92,0.08,0.92)
				else
					gatherNoteTexture:SetTexCoord(0,1,0,1)
				end
				
				-- If this node is unverified, then make it reddish
				if ( iconColor == "red" ) then
					gatherNoteTexture:SetVertexColor(0.9,0.4,0.4)
				elseif ( iconColor == "green" ) then
					gatherNoteTexture:SetVertexColor(0.4,0.9,0.4)
				elseif ( iconColor == "blue" ) then
					gatherNoteTexture:SetVertexColor(0.4,0.4,0.9)
				else
					gatherNoteTexture:SetVertexColor(1,1,1)
				end
				gatherNoteTexture:SetAlpha(opacity)
			end
		end
	end
end

-- Pass on any node clicks
function Gatherer.MiniNotes.MiniNoteOnClick()
	Minimap_OnClick(Minimap)
end

function Gatherer.MiniNotes.MiniNoteOnEnter(frame)
	local setting = Gatherer.Config.GetSetting
	local tooltip = GameTooltip

	local enabled = setting("minimap.tooltip.enable")
	if (not enabled) then 
		return
	end
	
	local showcount = setting("minimap.tooltip.count")
	local showsource = setting("minimap.tooltip.source")
	local showseen = setting("minimap.tooltip.seen")
	local showdist = setting("minimap.tooltip.distance")
	local showrate = setting("minimap.tooltip.rate")
	
	tooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT")
	
	local id = frame.id
	local name = Gatherer.Util.GetNodeName(id)
	local dist = Astrolabe:GetDistanceToIcon(frame)
	local _, _, count, gType, harvested, inspected, who = Gatherer.Storage.GetNodeInfo(frame.continent, frame.zone, id, frame.index)
	local last = inspected or harvested

	tooltip:ClearLines()
	tooltip:AddLine(name)
	if (count > 0 and showcount) then
		tooltip:AddLine(_tr("NOTE_COUNT", count))
	end
	if (who and showsource) then
		if (who == "REQUIRE") then
			tooltip:AddLine(_tr("NOTE_UNSKILLED"))
		elseif (who == "IMPORTED") then
			tooltip:AddLine(_tr("NOTE_IMPORTED"))
		else
			tooltip:AddLine(_tr("NOTE_SOURCE", who:gsub(",", ", ")))
		end
	end
	if (last and last > 0 and showseen) then
		tooltip:AddLine(_tr("NOTE_LASTVISITED", Gatherer.Util.SecondsToTime(time()-last)))
	end
	if (showdist) then
		tooltip:AddLine(_tr("NOTE_DISTANCE", format("%0.2f", dist)))
	end
	
	if ( showrate ) then
		local num = Gatherer.Config.GetSetting("minimap.tooltip.rate.num")
		Gatherer.Tooltip.AddDropRates(tooltip, id, frame.continent, frame.zone, num)
	end
	tooltip:Show()
end
