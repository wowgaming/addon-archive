--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 3.1.14 (<%codename%>)
	Revision: $Id: GatherMain.lua 754 2008-10-14 04:43:39Z Esamynn $

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
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/release/Gatherer/GatherMain.lua $", "$Rev: 754 $")

Gatherer.Var.Version="3.1.14"
if (Gatherer.Var.Version == "<%".."version%>") then
	Gatherer.Var.Version = "3.1-DEV"
end
Gatherer.Version = Gatherer.Var.Version

Gatherer.AstrolabeVersion = "Astrolabe-0.4"

-- Global variables
Gatherer.Var.NoteUpdateInterval = 0.1
Gatherer.Var.NoteCheckInterval = 5.0
Gatherer.Var.MaxNumNotes = 25
Gatherer.Var.Loaded = false
Gatherer.Var.ClosestCheck = 0.4
Gatherer.Var.RecordFlag = 0
Gatherer.Var.CurrentNode = ""
Gatherer.Var.CurrentAction = ""

Gatherer.Var.InCity = false
Gatherer.Var.MapOpen = false
Gatherer.Var.UpdateWorldMap = -1

Gatherer.Var.Skills = { }
Gatherer.Var.ZoneData = { }
Gatherer.Var.MainMapItem = { }

Gatherer.Var.Closest = {playerC=0,playerZ=0,playerX=0,playerY=0,px=0,py=0,items={},count=0}

Gatherer.Var.LastZone = {}

Gatherer.Var.BorderWidth = 15

Gatherer.Var.StorePosX = 1
Gatherer.Var.StorePosY = 2
Gatherer.Var.StoreCount = 3
Gatherer.Var.StoreHarvested = 4
Gatherer.Var.StoreInspected = 5
Gatherer.Var.StoreSource = 6


StaticPopupDialogs["GATHERER_VERSION_DIALOG"] = {
	text = TEXT(GATHERER_VERSION_WARNING),
	button1 = TEXT(OKAY),
	showAlert = 1,
	timeout = 0,
}



