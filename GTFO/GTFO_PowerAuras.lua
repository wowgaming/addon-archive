--------------------------------------------------------------------------
-- GTFO_PowerAuras.lua 
--------------------------------------------------------------------------
--[[
GTFO & Power Auras Integration
Author: Zensunim of Malygos

Change Log:
	v2.1
		- Added Power Auras Integration

]]--

function GTFO_DisplayAura(iType)
	GTFO.ShowAlert = true;
	if (iType == 1) then
		if (PowaAuras.AurasByType.GTFOHigh) then
			for index, auraid in ipairs(PowaAuras.AurasByType.GTFOHigh) do
				if (PowaAuras.Auras[auraid]:ShouldShow()) then
					shouldShow, reason = PowaAuras:CheckMultiple(PowaAuras.Auras[auraid], "", nil);
					if (shouldShow) then
						PowaAuras:DisplayAura(auraid);
						if (PowaAuras.Auras[auraid].timerduration == 0) then
							PowaAuras.Auras[auraid].HideRequest = true;
						end
					end   
				end
			end
		end
	elseif (iType == 2) then
		if (PowaAuras.AurasByType.GTFOLow) then
			for index, auraid in ipairs(PowaAuras.AurasByType.GTFOLow) do
				if (PowaAuras.Auras[auraid]:ShouldShow()) then
					shouldShow, reason = PowaAuras:CheckMultiple(PowaAuras.Auras[auraid], "", nil);
					if (shouldShow) then
						PowaAuras:DisplayAura(auraid);
						if (PowaAuras.Auras[auraid].timerduration == 0) then
							PowaAuras.Auras[auraid].HideRequest = true;
						end
					end
				end
			end
		end
	elseif (iType == 3) then
		if (PowaAuras.AurasByType.GTFOFail) then
			for index, auraid in ipairs(PowaAuras.AurasByType.GTFOFail) do
				if (PowaAuras.Auras[auraid]:ShouldShow()) then
					shouldShow, reason = PowaAuras:CheckMultiple(PowaAuras.Auras[auraid], "", nil);
					if (shouldShow) then
						PowaAuras:DisplayAura(auraid);
						if (PowaAuras.Auras[auraid].timerduration == 0) then
							PowaAuras.Auras[auraid].HideRequest = true;
						end
					end
				end
			end
		end
	end
	GTFO.ShowAlert = nil;
end