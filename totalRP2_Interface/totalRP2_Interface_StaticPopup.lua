-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------


function TRP2_UnShade(Frame)
	--Frame:SetAlpha(1);
end

function TRP2_Shade(Frame)
	--Frame:SetAlpha(0.5);
end

function TRP_InitialiseStaticPopup()
	-----------------------
	-- TRP 2 
	-----------------------	
	StaticPopupDialogs["TRP2_INV_DELETE_PLANQUE"] = {
	  text = "",
	  button1 = ACCEPT,
	  button2 = CANCEL,
	  OnShow = function(self)
			TRP2_Shade(TRP2MainFrame);
	  end,
	  OnAccept = function(self)
			TRP2_DeletePlanque(self.trparg1);
	  end,
	  OnHide = function(self)
			getglobal(self:GetName().."EditBox"):SetNumeric(0);
			TRP2_UnShade(TRP2MainFrame);
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1
	};
	
	StaticPopupDialogs["TRP2_JUST_TEXT"] = {
	  text = "",
	  button1 = "OK",
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1
	};
	
	StaticPopupDialogs["TRP2_NOT_ANYMORE"] = {
	  text = "",
	  button1 = "OK",
	  button2 = "Ne plus afficher",
	  OnCancel = function(self, reason)
		TRP2_Module_Interface["AnyID"][self.anyID] = true;
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1
	};
	
	StaticPopupDialogs["TRP2_INV_DELETE_OBJECT"] = {
	  text = "\n\n\n\n\n\n\n",
	  button1 = ACCEPT,
	  button2 = CANCEL,
	  OnShow = function(self)
			TRP2_Shade(TRP2MainFrame);
	  end,
	  OnAccept = function(self)
			TRP2_proceedDeleteObject(self.trparg1,self.trparg2,self.trparg3,self.trparg4);
	  end,
	  OnHide = function(self)
			_G[self:GetName().."EditBox"]:SetNumeric(0);
			TRP2_UnShade(TRP2MainFrame);
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1
	};
	
	StaticPopupDialogs["TRP2_INV_DELETE_OBJECT_AMOUNT"] = {
	  text = "\n\n\n\n\n\n\n\n",
	  button1 = ACCEPT,
	  button2 = CANCEL,
	  OnShow = function(self)
			TRP2_Shade(TRP2MainFrame);
	  end,
	  OnAccept = function(self)
			if TRP2_NilToDefaut(_G[self:GetName().."EditBox"]:GetNumber(),0) > 0 then
				TRP2_proceedDeleteObject(self.trparg1,_G[self:GetName().."EditBox"]:GetNumber(),self.trparg3,self.trparg4);
			end
	  end,
	  OnHide = function(self)
			_G[self:GetName().."EditBox"]:SetNumeric(0);
			TRP2_UnShade(TRP2MainFrame);
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  hasEditBox = 1,
	};
	
	StaticPopupDialogs["TRP2_CONFIRM_ACTION"] = {
	  text = "",
	  button1 = ACCEPT,
	  button2 = CANCEL,
	  OnShow = function(self)
			TRP2_Shade(TRP2MainFrame);
	  end,
	  OnAccept = function(self)
			TRP2_UnShade(TRP2MainFrame);
			TRP2_PCall(self.trparg1,self.trparg2,self.trparg3,self.trparg4);
	  end,
	  OnCancel = function(arg1,arg2)
			TRP2_UnShade(TRP2MainFrame);
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  showAlert = true,
	};
	
	StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"] = {
	  text = "",
	  button1 = ACCEPT,
	  button2 = CANCEL,
	  OnShow = function(self)
	  end,
	  OnAccept = function(self)
			TRP2_PCall(self.trparg1,self.trparg2,self.trparg3,self.trparg4);
	  end,
	  OnCancel = function(arg1,arg2)
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	};
	
	StaticPopupDialogs["TRP2_CONFIRM_YES_NO_CANCEL"] = {
	  text = "",
	  button1 = YES,
	  button2 = CANCEL,
	  button3 = NO,
	  OnShow = function(self)
	  end,
	  OnAccept = function(self)
			TRP2_PCall(self.trparg1);
	  end,
	  OnCancel = function(self)
			TRP2_PCall(self.trparg3);
	  end,
	  OnAlt = function(self)
			TRP2_PCall(self.trparg2);
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  showAlert = true,
	};
	
	StaticPopupDialogs["TRP2_GET_MONTANT_NS"] = {
	  text = "",
	  button1 = ACCEPT,
	  button2 = CANCEL,
	  OnShow = function(self)
	  end,
	  OnAccept = function(self)
			if TRP2_NilToDefaut(_G[self:GetName().."EditBox"]:GetNumber(),0) >= 0 then
				local montant = _G[self:GetName().."EditBox"]:GetNumber();
				TRP2_PCall(self.trparg1,montant,self.trparg2,self.trparg3,self.trparg4);
			end
	  end,
	  OnHide = function(self)
			_G[self:GetName().."EditBox"]:SetNumeric(0);
			TRP2_UnShade(TRP2MainFrame);
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  hasEditBox = 1,
	};

	StaticPopupDialogs["TRP2_GET_Sound"] = {
	  text = "",
	  button1 = ACCEPT,
	  button2 = CANCEL,
	  OnShow = function(self)
	  end,
	  OnAccept = function(self)
			if TRP2_EmptyToNil(getglobal(self:GetName().."EditBox"):GetText()) then
				local text = getglobal(self:GetName().."EditBox"):GetText();
				TRP2_PCall(self.trparg1,text,self.trparg2,self.trparg3,self.trparg4);
			end
	  end,
	  OnHide = function(self)
			TRP2_UnShade(TRP2MainFrame);
	  end,
	  EditBoxOnEnterPressed = function(self)
			if TRP2_EmptyToNil(self:GetText()) then
				TRP2_PlaySound(self:GetText()..".wav");
			end
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  hasEditBox = 1,
	};
	
	StaticPopupDialogs["TRP2_GET_TEXT_NS"] = {
	  text = "",
	  button1 = ACCEPT,
	  button2 = CANCEL,
	  OnShow = function(self)
	  end,
	  OnAccept = function(self)
			if TRP2_EmptyToNil(getglobal(self:GetName().."EditBox"):GetText()) then
				local text = getglobal(self:GetName().."EditBox"):GetText();
				TRP2_PCall(self.trparg1,text,self.trparg2,self.trparg3,self.trparg4);
			end
	  end,
	  OnHide = function(self)
			TRP2_UnShade(TRP2MainFrame);
	  end,
	  enterClicksFirstButton = 1,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  hasEditBox = 1,
	};
	
	StaticPopupDialogs["TRP2_ADD_AURA_TIME"] = {
	  text = "",
	  button1 = ACCEPT,
	  button2 = CANCEL,
	  OnShow = function(self)
			TRP2_Shade(TRP2MainFrame);
	  end,
	  OnAccept = function(self)
			if TRP2_NilToDefaut(_G[self:GetName().."EditBox"]:GetNumber(),0) >= 0 then
				local duree = _G[self:GetName().."EditBox"]:GetNumber();
				TRP2_AddAura(self.trparg2,duree);
			end
	  end,
	  OnHide = function(self)
			_G[self:GetName().."EditBox"]:SetNumeric(0);
			TRP2_UnShade(TRP2MainFrame);
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  hasEditBox = 1,
	};
	
	StaticPopupDialogs["TRP2_ADD_OBJET_AMOUNT"] = {
	  text = "\n\n\n\n\n\n\n\n",
	  button1 = ACCEPT,
	  button2 = CANCEL,
	  OnShow = function(self)
			TRP2_Shade(TRP2MainFrame);
	  end,
	  OnAccept = function(self)
			if TRP2_NilToDefaut(_G[self:GetName().."EditBox"]:GetNumber(),0) > 0 then
				TRP2_InvAddObjet(self.trparg1,nil,nil,_G[self:GetName().."EditBox"]:GetNumber(),nil,nil,true);
			end
	  end,
	  OnHide = function(self)
			_G[self:GetName().."EditBox"]:SetNumeric(0);
			TRP2_UnShade(TRP2MainFrame);
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  hasEditBox = 1,
	};
	
	StaticPopupDialogs["TRP2_OBJET_CREATE_STACK"] = {
	  text = "\n\n\n\n\n\n\n\n",
	  button1 = ACCEPT,
	  button2 = CANCEL,
	  OnShow = function(self)
	  end,
	  OnAccept = function(self)
			if TRP2_NilToDefaut(_G[self:GetName().."EditBox"]:GetNumber(),0) > 0 then
				local nombre = _G[self:GetName().."EditBox"]:GetNumber();
				if nombre and nombre > 0 then
					local slot = TRP2_GetSlotTab(self.trparg1, self.trparg2);
					if slot["Qte"] - nombre <= 0 then
						nombre = slot["Qte"] - 1;
					end
					slot["Qte"] = slot["Qte"] - nombre;
					TRP2_InvAddObjet(slot["ID"],self.trparg2,slot["Charges"],nombre,slot["Lifetime"],slot["Artisant"],false,true);
				end
			end
	  end,
	  OnHide = function(self)
			_G[self:GetName().."EditBox"]:SetNumeric(0);
			TRP2_UnShade(TRP2MainFrame);
	  end,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  hasEditBox = 1,
	};
		
end

function TRP2_ShowStaticPopupAny(popupToShow, anyID)
	if TRP2_GetConfigValueFor("ShowTips",true) and not TRP2_Module_Interface["AnyID"][anyID] then
		local dialog = StaticPopup_Show(popupToShow);
		if dialog then
			dialog.anyID = anyID;
			dialog:ClearAllPoints();
			dialog:SetPoint("CENTER",UIParent,"CENTER");
		end
	end
end

function TRP2_ShowStaticPopup(popuptoshow,AnchorFrame,trparg1,trparg2,trparg3,trparg4,bNumeric,Init,Animation,AnimationText)
	local dialog = StaticPopup_Show(popuptoshow);
    if dialog then
		if trparg1 then
			dialog.trparg1 = trparg1;
		end
		if trparg2 then
			dialog.trparg2 = trparg2;
		end
		if trparg3 then
			dialog.trparg3 = trparg3;
		end
		if trparg4 then
			dialog.trparg4 = trparg4;
		end
		if bNumeric then
			getglobal(dialog:GetName().."EditBox"):SetNumeric(bNumeric);
		else
			getglobal(dialog:GetName().."EditBox"):SetNumeric(0);
		end
		if Init then
			getglobal(dialog:GetName().."EditBox"):SetText(Init);
			getglobal(dialog:GetName().."EditBox"):HighlightText();
		else
			getglobal(dialog:GetName().."EditBox"):SetText("");
		end
		if AnchorFrame then
			dialog:ClearAllPoints();
			--dialog:SetPoint("BOTTOM",AnchorFrame,"TOP",32,-30);
			--dialog:SetParent(AnchorFrame);
			dialog:SetPoint("CENTER",AnchorFrame,"CENTER",10,0);
		else
			dialog:ClearAllPoints();
			--dialog:SetParent(UIParent);
			dialog:SetPoint("CENTER",UIParent,"CENTER");
		end
    end
end