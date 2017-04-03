local AddonName, Addon = ...

Addon.AddonPath = "Interface\\Addons\\"..AddonName.."\\"

function Addon:New(pMethodTable, ...)
	local vObject
	
	if type(pMethodTable) ~= "table" then
		error("table expected")
	end
	
	if pMethodTable.New then
		vObject = pMethodTable:New(...)
	else
		vObject = {}
	end
	
	vObject.Inherit = self.Inherit
	vObject.InheritOver = self.InheritOver
	
	vObject:InheritOver(pMethodTable, ...)
	
	return vObject
end

function Addon:InheritOver(pMethodTable, ...)
	for vKey, vValue in pairs(pMethodTable) do
		if self[vKey] then
			if not self.Inherited then
				self.Inherited = {}
			end
			
			self.Inherited[vKey] = self[vKey]
		end
		
		self[vKey] = vValue
	end
	
	if pMethodTable.Construct then
		pMethodTable.Construct(self, ...)
	end
end

function Addon:Inherit(pMethodTable, ...)
	for vKey, vValue in pairs(pMethodTable) do
		if self[vKey] then
			if not self.Inherited then
				self.Inherited = {}
			end
			
			if not self.Inherited[vKey] then
				self.Inherited[vKey] = vValue
			end
		else
			self[vKey] = vValue
		end
	end
	
	if pMethodTable.Construct then
		pMethodTable.Construct(self, ...)
	end
end

function Addon:DuplicateTable(pTable, pRecurse, pDestTable)
	if not pTable then
		return nil
	end
	
	local vTable
	
	if pDestTable then
		if type(pDestTable) ~= "table" then
			error("table expected for pDestTable")
		end
		
		vTable = pDestTable
	else
		vTable = {}
	end
	
	if pRecurse then
		for vKey, vValue in pairs(pTable) do
			if type(vValue) == "table" then
				vTable[vKey] = self:DuplicateTable(vValue, true)
			else
				vTable[vKey] = vValue
			end
		end
	else
		self:CopyTable(vTable, pTable)
	end
	
	return vTable
end

function Addon:CopyTable(pDestTable, pTable)
	for vKey, vValue in pairs(pTable) do
		pDestTable[vKey] = vValue
	end
end

function Addon:EraseTable(pTable)
	for vKey, _ in pairs(pTable) do
		pTable[vKey] = nil
	end
end

function Addon:RecycleTable(pTable)
	if pTable then
		self:EraseTable(pTable)
		return pTable
	else
		return {}
	end
end

function Addon:HookScript(pFrame, pScriptID, pFunction)
	if not pFrame:GetScript(pScriptID) then
		pFrame:SetScript(pScriptID, pFunction)
	else
		pFrame:HookScript(pScriptID, pFunction)
	end
end
