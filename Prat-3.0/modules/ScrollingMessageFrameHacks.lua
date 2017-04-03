Prat:AddModuleToLoad(function() 

	local SMFHax = Prat:NewModule("SMFHax", "AceHook-3.0")
	
	SMFHax.fs_pool = {}
	
	local new, del
	do
		local wipe = wipe
		local cache = setmetatable({}, {__mode='k'})
		function new()
			local t = next(cache)
			if t then
				cache[t] = nil
				return t
			else
				return {}
			end
		end
		function del(t)
			wipe(t)
			cache[t] = true
			return nil
		end
	end
	
	function SMFHax:OnModuleEnable()
	    self:RawHook("ChatFrame_OnUpdate", true)
	end
	
	function SMFHax:OnModuleDisable()
		self:UnhookAll()
	
		self:ClearColumn1()
	end
	
	function SMFHax:ClearColumn1()
		for k,v in pairs(self.fs_pool) do
			for k2, v2 in pairs(v) do
				v2:SetText("")
			end
		end
	
		for k,v in pairs(Prat.HookedFrames) do
			if v:IsShown() then 
				v:Hide()
				v:Show()
			end
		end
	end
	
	function SMFHax:ChatFrame_OnUpdate(this, ...)	
     --   self:ReflowFontStrings(this, ...)

	    if not IsCombatLog(this) then
	        self:SplitFontStrings(this, this:GetRegions())
	    end
	
		self.hooks["ChatFrame_OnUpdate"](this, ...)
	end
	

    -- used for flowing text around a button which is on the frame
    local avoid_frames = {}
    
    -- used for flowing text around a button which is on the frame
    local function intersects_pts(o1t, o1b,  o2t, o2b)
        -- above
        local above = o1t > o2t and o1b > o2t
        -- below
        local below = o1t < o2b and o1b < o2b
        -- either one true and we dont intersect
        return not( above or below )
    end
    
    -- used for flowing text around a button which is on the frame
    local function intersects_line(line, frame)
        return intersects_pts(line:GetTop(), line:GetBottom(), frame:GetTop(), frame:GetBottom())
    end
    
    local function getAvoidFrames(frame)
        local id = frame:GetID()
        local af = avoid_frames[id] 
        if af then 
            return af 
        end

        avoid_frames[id] = {}
        af = avoid_frames[id] 
        af.cfup = _G["ChatFrame"..id.."UpButton"]
        af.cfdown = _G["ChatFrame"..id.."DownButton"]
        af.cfbottom = _G["ChatFrame"..id.."BottomButton"]
        af.cfreminder = _G["ChatFrame"..id.."ScrollDownReminder"]

		if ChatFrameMenuButton:IsShown() then
			af.menu = ChatFrameMenuButton
		end

        return af        
    end

	function SMFHax:SplitFontStrings(this, ...)
	    local fs
		local tmp = new()
	    for n=1,select("#", ...) do
	        local o = select(n, ...)
			if  o and o:GetObjectType() == "FontString" and not o:GetName() then
	            table.insert(tmp, o)
			end
	    end
		local af = getAvoidFrames(this)
		local last, pool
	    for n,o in ipairs(tmp) do
			if not self.fs_pool[this:GetID()] then
				self.fs_pool[this:GetID()] = {}
			end
			pool = self.fs_pool[this:GetID()]
	
			if self.twocolumn then
				if not pool[n] then
					pool[n] = this:CreateFontString(this:GetName().."LeftExtra"..n)
					pool[n]:SetJustifyV("TOP")
		        end
			end


			if o:GetNumPoints() ~= 0 then
				local l = o:GetText()
	
	            fs = pool[n]
				if self.twocolumn then
		            
					fs:ClearAllPoints()
		            o:ClearAllPoints()
				
					if not last then 
						fs:SetPoint("BOTTOMLEFT", this , "BOTTOMLEFT", 0, 0)
					else
						fs:SetPoint("BOTTOMLEFT", last, "TOPLEFT", 0, 0)
					end
					
					fs:SetFont(o:GetFont())
		

					-- /print (select(2,ChatFrame1:GetRegions())):GetText():match("^\124c00000000\124r(.*)")
					last = fs
                    local s
					local e = l:match("^(\124c00000000\124r.*)")
                    if not e then 
                        s, e = l:match("^(.-)(\124c00000000\124r.*)")
                    end
    
                    l = e or l

					if s then fs:SetText(s) elseif not e then fs:SetText("") end
					o:SetText(l)	
		
                    self:ReflowFontString(this, o, fs, "BOTTOMRIGHT", this, "RIGHT", af)
--		            o:SetPoint("BOTTOMLEFT", fs, "BOTTOMRIGHT", 0 , 0)

--		            o:SetPoint("RIGHT", this, "RIGHT", 0 , 0)
				
					-- Ensure proper text wrappring
--					o:SetWidth(o:GetRight()-o:GetLeft())
                else
                    self:ReflowFontString(this, o, this, "DONTCLEAR", this, "RIGHT", af)
				end
	
				if fs then		
					fs:SetHeight(o:GetHeight())
					o:SetJustifyV("TOP")
				end
	
				-- Playerlink hover-fade effect
				if self.overPlayer then
					if l:match("player:"..self.overPlayer) then
						o:SetAlpha(1)
						if not o:IsShown() and o:GetTop() < this:GetTop() then
						    o.restoreTo = 0
							o:Show()
						end
					else
					    if o.restoreTo == 0 then 
							o:Hide()
							o.restoreTo =  nil
						else
							o:SetAlpha(0.50)
							o.restoreTo = 1
						end
					end
				else
				    if o.restoreTo == 0 then 
						o:Hide()
						o.restoreTo = nil
					elseif o.restoreTo == 1 then
						o.restoreTo = nil
						o:SetAlpha(1)
					end
				end
	
				if self.twocolumn then
					fs:SetAlpha(o:GetAlpha())
					fs:SetTextColor(o:GetTextColor())
					fs:SetShadowColor(o:GetShadowColor())
					fs:SetShadowOffset(o:GetShadowOffset())
		
					if fs:GetTop() > this:GetTop() or l:trim():len() == 0 then
						fs:Hide()
					end
		
					if o:GetTop() > this:GetTop() then
						o:Hide()
                    else
                        o:Show()
					end
		
					if o:IsShown() then
						fs:Show()
					else
						fs:Hide()
					end
				end
			end
	    end
	
		del(tmp)
	end
	


    -- flow text around a frame which is also on the chatframe
    function SMFHax:ReflowFontString(frame, fontstring, leftanchor, leftanchorpt, rightanchor, rightanchorpt, avoidframes)
        local found = false
    
        if leftanchorpt and leftanchorpt ~= "DONTCLEAR" then 
            fontstring:ClearAllPoints()

            fontstring:SetPoint("BOTTOMLEFT", leftanchor, leftanchorpt, 0 , 0)
        end

        for k,v in pairs(avoidframes) do
            if v:IsVisible() and intersects_line(fontstring, v) then
                fontstring:SetPoint("RIGHT", v, "LEFT", 0, 0)
                found = true
                break
            end
        end

        if not found then 
            fontstring:SetPoint("RIGHT", rightanchor, rightanchorpt, 0, 0)
        end              

        fontstring:SetWidth(fontstring:GetRight()-fontstring:GetLeft())
        
        if fontstring:GetTop() > frame:GetTop() then
            fontstring:Hide()
        else
            fontstring:Show()
        end                  
    end
	
--	Prat:AddModuleExtension(function() 
--		local module = Prat.Addon:GetModule("Timestamps", true)
--		
--		if not module then return end
--	
--		local L = module.L
--	
--		module.pluginopts["TwoColumnFrames"] = {  
--			twocolumn =  {
--				type = "toggle",
--				name = L["twocolumn_name"],
--				desc = L["twocolumn_desc"],
--				order = 185
--			}
--		}
--	
--	    local orgOME = module.OnModuleEnable
--		function module:OnModuleEnable(...) 
--			orgOME(self, ...)
--	
--			if self.db.profile.twocolumn then
--				SMFHax:Enable()
--				SMFHax.twocolumn = true
--			end
--		end
--
--		function module:PlainTimestampNotAllowed() 
--			return SMFHax.twocolumn
--		end
--	
--		local ovc = module.OnValueChanged
--		function module:OnValueChanged(info, b)
--			ovc(self, info, b)
--	
--			if info[#info] == "twocolumn" then
--				if SMFHax.twocolumn ~= b then
--					SMFHax.twocolumn = b
--					if b then
--						SMFHax:Enable()
--					else
--						SMFHax:ClearColumn1()
--					end
--				end
--			end
--		end
--	end ) -- Module Extension
	
	
--	Prat:AddModuleExtension(function() 
--		local module = Prat.Addon:GetModule("PlayerNames", true)
--		
--		if not module then return end
--	
--		local L = module.L
--		
--		module.pluginopts["HoverHilight"] = {  
--			hoverhilight =  {
--				type = "toggle",
--				name = L["hoverhilight_name"],
--				desc = L["hoverhilight_desc"],
--				order = 230
--			}
--		}
--		
--	
--		local function hoverOnHyperlinkEnter(frame, link, ...)
--			local linktype = link:match("^([^:]+)")
--			if linktype == "player" then
--				SMFHax.overPlayer = link:match("^[^:]+:([^:%]||]+)")
--			end
--		end
--		
--		local function hoverOnHyperlinkLeave(frame, ...)
--			SMFHax.overPlayer = nil
--		end
--	
--		local function hoverHilight(enable)
--			if (enable) then
--				SMFHax:Enable()
--				for k,v in pairs(Prat.HookedFrames) do
--					SMFHax:HookScript(v, "OnHyperlinkEnter", hoverOnHyperlinkEnter)
--					SMFHax:HookScript(v, "OnHyperlinkLeave", hoverOnHyperlinkLeave)
--				end
--			else
--				for k,v in pairs(Prat.HookedFrames) do
--					SMFHax:Unhook(v, "OnHyperlinkEnter")
--					SMFHax:Unhook(v, "OnHyperlinkLeave")
--				end
--			end
--		end
--	
--	    local orgOME = module.OnModuleEnable
--		function module:OnModuleEnable(...) 
--			orgOME(self, ...)
--	
--			if self.db.profile.hoverhilight then
--				hoverHilight(true)
--			end
--		end
--	
--		local ovc = module.OnValueChanged
--		function module:OnValueChanged(info, b)
--			ovc(self, info, b)
--	
--			if info[#info] == "hoverhilight" then
--				hoverHilight(b)
--			end
--		end
--	end ) -- Module Extension

  return
end ) -- Prat:AddModuleToLoad