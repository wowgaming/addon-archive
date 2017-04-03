
function traceback(message)
	print("Error occured during execution of script")
	print("  "..message)
end


local pathsep = [[/]]
if os.execute'uname' ~= 0 then pathsep = [[\]] end

local function files(dirname)
	local dh = assert(os.opendir(dirname))
	return function()
		return dh:read() or assert(dh:close()) and nil
	end
end

print("Scanning plugins folder...")

local output = io.open("Active.xml", "w");
output:write([[<Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/ ..\FrameXML\UI.xsd">]].."\n")

local dirs = {}
local embeddedModules = {}
local active, invalid = 0,0
for fn in files(".") do
	if fn and fn:lower():sub(0,4) == "auc-" then
		local info = os.stat(fn)
		if info and info.dir then
			local fh = io.open(fn..pathsep.."Embed.xml", "r")
			if (fh) then
				active = active + 1
				embeddedModules[active] = fn
				print("  + Activating: "..fn)
			else
				invalid = invalid + 1
				print("  ! Module \""..fn.."\" is not embeddable")
			end
		end
	end
end

output:write("\t<Script>\n\t\tAucAdvanced.EmbeddedModules = {\n")
for index, module in ipairs(embeddedModules) do
	output:write("\t\t\t\""..module.."\",\n")
end
output:write("\t\t}\n\t\t")
output:write([[AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/5.8/Auc-Advanced/Modules/autorun.lua $", "$Rev: 3029 $")]])
output:write("\n\t</Script>\n\n")
for index, module in ipairs(embeddedModules) do
	output:write("\t<Include file=\""..module.."\\Embed.xml\"/>\n");
end
output:write("</Ui>")

print("Activated: "..active.." modules.")
if (invalid > 0) then
	print("WARNING: There were "..invalid.." non-embeddable modules detected.")
	print("Sometimes Auctioneer modules are not embeddable, and need to be installed as normal addons.")
	print("Embeddable modules will have an Embed.xml file in the folder.")
	alert("Warning: Non-embeddable modules detected, please check log!")
else
	sleep(2.5)
	exit()
end

