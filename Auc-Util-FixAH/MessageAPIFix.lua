--[[
	Auctioneer - Fix for searches not returning to page one in Blizzard code.
	Version: 5.8.4723 (CreepyKangaroo)
	Revision: $Id: Example.lua 3882 2008-12-02 16:36:58Z kandoko $
	URL: http://auctioneeraddon.com/

	This is an Auctioneer module that temporarily patches known errors and issues
	with Blizzard's code.

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

--as of patch 3.2 message()  API has a bad frame reference. This will override with the proper frame reference
if not pcall(message) then
	print("Auctioneer is Patching bad message API introduced in patch 3.2 with a functional message API")
	function message(text)
		if ( not BasicScriptErrors:IsShown() ) then
			BasicScriptErrorsText:SetText(text)
			BasicScriptErrors:Show()
		end
	end
end
BasicScriptErrors:Hide() --pcall will likely make the frame visible if a fix has been put in place so make sure to hide the frame
