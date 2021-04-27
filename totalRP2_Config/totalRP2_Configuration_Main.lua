-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

function TRP2_Set_Module_Configuration()
	if not TRP2_Module_Configuration then
		TRP2_Module_Configuration = {};
	end
	if not TRP2_Module_Configuration[TRP2_Royaume] then
		TRP2_Module_Configuration[TRP2_Royaume] = {};
	end
	if not TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur] then
		TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur] = {};
	end
end

function TRP2_GetConfigValueFor(varName,default)
	if TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][varName] ~= nil then
		return TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][varName];
	else
		return default;
	end
end

function TRP2_SetConfigValueFor(varName,value)
	if TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur] then
		TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][varName] = value;
	end
end

TRP2_AnchorTab = {
	"ANCHOR_TOPLEFT",
	"ANCHOR_TOP",
	"ANCHOR_TOPRIGHT",
	"ANCHOR_RIGHT",
	"ANCHOR_BOTTOMRIGHT",
	"ANCHOR_BOTTOM",
	"ANCHOR_BOTTOMLEFT",
	"ANCHOR_LEFT",
};

TRP2_ConfigStructTab = {
	{ -- Page General
		["Infos"] = {
			["Titre"] = "TRP2_LOC_PAR_GENERAL";
			["Icon"] = "Interface\\ICONS\\INV_Gizmo_01";
		},
		["Composants"] = {
			{ -- Langue
				["Nom"] = "TRP2ConfigStringLang";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "LANGUAGE";
				["DiffX"] = 0;
				["DiffY"] = -10;
			},
			{ -- Choix langue
				["Nom"] = "TRP2ConfigSliderLangue";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitle";
				["VarName"] = "Langue";
				["DiffX"] = 0;
				["DiffY"] = -20;
				["Default"] = 2;
				["Titre"] = "LANGUAGE";
				["OnChange"] = function(self)
				
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					if value == 1 then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = 1; -- frFR
						TRP2ConfigSliderLangueTexte:SetText("Français");
						if self:IsVisible() then
							StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE.."Cette action nécessite le rechargement de l'interface.\nRecharger maintenant ?");
							TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
								ReloadUI();
							end);
						end
					elseif value == 3 then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = 3; -- esES
						TRP2ConfigSliderLangueTexte:SetText("Castellano");
						if self:IsVisible() then
							StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE.."Debes rea¡cargar la interfaz para aplicar los cambios.\n¿Recargar ya?");
							TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
								ReloadUI();
							end);
						end
					elseif value == 4 then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = 4; -- deDE
						TRP2ConfigSliderLangueTexte:SetText("Deutsch");
						if self:IsVisible() then
							StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE.."Um die Sprache zu ändern muss das Interface neu geladen werden.\nJetzt Neuladen?");
							TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
								ReloadUI();
							end);
						end
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = 2; -- enEN
						TRP2ConfigSliderLangueTexte:SetText("English");
						if self:IsVisible() then
							StaticPopupDialogs["TRP2_CONFIRM_ACTION_NS"].text = TRP2_CTS(TRP2_ENTETE.."You have to reload your interface in order to change the language.\nReload now?");
							TRP2_ShowStaticPopup("TRP2_CONFIRM_ACTION_NS",nil,function()
								ReloadUI();
							end);
						end
					end
				end;
				["SliderMin"] = 1;
				["SliderMax"] = 4;
				["Width"] = 100;
			},
			{ -- DEBUG
				["Nom"] = "TRP2ConfigStringDebug";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_PAR_Debug";
				["DiffX"] = 0;
				["DiffY"] = -20;
			},
			{ -- Check Debug
				["Nom"] = "TRP2ConfigCheckDebug";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "DebugMode";
				["DiffX"] = -40;
				["DiffY"] = -5;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckDebug:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckDebug.VarName] = true;
						TRP2ConfigCheckDebugText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_DebugCheck));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckDebug.VarName] = false;
						TRP2ConfigCheckDebugText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_DebugCheck));
					end
				end;
			},
			{ -- ChatFrame à utiliser pour le debug
				["Nom"] = "TRP2ConfigEditBoxDebugFrame";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "DebugMessageFrame";
				["DiffX"] = 40;
				["DiffY"] = -10;
				["Default"] = "1";
				["Numeric"] = 1;
				["MaxLetters"] = 1;
				["OnChange"] = function(self)
					if getglobal("ChatFrame"..tostring(self:GetText())) then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = self:GetText();
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = "1";
					end
					local nom = GetChatWindowInfo(tonumber(TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName]));
					TRP2_SetTooltipForFrame(TRP2ConfigEditBoxDebugFrame,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_DebugFrame,
						TRP2_LOC_PAR_DebugFrameTT.."\n\n{v}"..TRP2_LOC_PAR_ChoozenFrame.." : {o}"..nom);
					self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_DebugFrame.." {v}("..nom..")");
				end;
			},
			{ -- AIDE
				["Nom"] = "TRP2ConfigStringAide";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_PAR_AideOption";
				["DiffX"] = 0;
				["DiffY"] = -10;
			},
			{ -- Police aide
				["Nom"] = "TRP2ConfigSliderAideTaille";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "AideTaille";
				["DiffX"] = 0;
				["DiffY"] = -20;
				["Default"] = 10;
				["Titre"] = "TRP2_LOC_PAR_AideTaille";
				["OnChange"] = function(self)
				if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderAideTailleTexte:SetText(tostring(value));
					if self:IsVisible() then
						TRP2_RefreshTooltipForFrame(self);
					end
				end;
				["SliderMin"] = 5;
				["SliderMax"] = 20;
				["Width"] = 150;
			},
			{ -- Check Show tips
				["Nom"] = "TRP2ConfigCheckTips";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "ShowTips";
				["DiffX"] = -40;
				["DiffY"] = -5;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTips:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTips.VarName] = true;
						TRP2ConfigCheckTipsText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_TipsCheck));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTips.VarName] = false;
						TRP2ConfigCheckTipsText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_TipsCheck));
					end
				end;
			},
			{ -- Chanel
				["Nom"] = "TRP2ConfigStringChannel";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_PAR_ChannelToUse";
				["DiffX"] = 40;
				["DiffY"] = -5;
			},
			{ -- Check use channel broadcast
				["Nom"] = "TRP2ConfigUseBroadcast";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "UseBroadcast";
				["DiffX"] = -70;
				["DiffY"] = -5;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigUseBroadcast:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigUseBroadcast.VarName] = true;
						TRP2ConfigUseBroadcastText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_UseBroadcast));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigUseBroadcast.VarName] = false;
						TRP2ConfigUseBroadcastText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_UseBroadcast));
					end
				end;
			},
			{ -- Nom du Channel
				["Nom"] = "TRP2ConfigEditBoxChannelToUse";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "ChannelToUse";
				["Titre"] = "TRP2_LOC_PAR_ChannelToUseNom";
				["DiffX"] = 70;
				["DiffY"] = -15;
				["Default"] = "xtensionxtooltip2";
				["OnChange"] = function(self)
					self:SetText(string.gsub(self:GetText(),TRP2_ReservedChar,""));
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = self:GetText();
				end;
			},
			{ -- Check activateexchange
				["Nom"] = "TRP2ConfigCheckActivexc";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "ActivateExchange";
				["DiffX"] = -75;
				["DiffY"] = -5;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckActivexc:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckActivexc.VarName] = true;
						TRP2ConfigCheckActivexcText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ActivateExchange));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckActivexc.VarName] = false;
						TRP2ConfigCheckActivexcText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ActivateExchange));
					end
				end;
			},
			{ -- Autre
				["Nom"] = "TRP2ConfigStringAutre";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "CALENDAR_TYPE_OTHER";
				["DiffX"] = 70;
				["DiffY"] = -10;
			},
			{ -- Check closeCombat
				["Nom"] = "TRP2ConfigCheckCloseCombat";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "CloseOnCombat";
				["DiffX"] = -50;
				["DiffY"] = -5;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckCloseCombat:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckCloseCombat.VarName] = true;
						TRP2ConfigCheckCloseCombatText:SetText(TRP2_CTS("{v}"..TRP2_LOC_CloseCombat));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckCloseCombat.VarName] = false;
						TRP2ConfigCheckCloseCombatText:SetText(TRP2_CTS("{r}"..TRP2_LOC_CloseCombat));
					end
				end;
			},
			{ -- Check Notify
				["Nom"] = "TRP2ConfigCheckNotify";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "NotifyOnNew";
				["DiffX"] = -30;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckNotify:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckNotify.VarName] = true;
						TRP2ConfigCheckNotifyText:SetText(TRP2_CTS("{v}"..TRP2_LOC_Notify));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckNotify.VarName] = false;
						TRP2ConfigCheckNotifyText:SetText(TRP2_CTS("{r}"..TRP2_LOC_Notify));
					end
				end;
			},
			{ -- Map à utiliser
				["Nom"] = "TRP2ConfigEditBoxMapToUse";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "WorldMapToUse";
				["DiffX"] = 80;
				["DiffY"] = -15;
				["Default"] = "WorldMapFrame";
				["OnChange"] = function(self)
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = TRP2_EmptyToNil(self:GetText());
					if getglobal(TRP2_GetConfigValueFor(self.VarName,"WorldMapFrame")) then
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MapToUse.." {v}(Ok)");
					else
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MapToUse.." {r}(Outch!)");
					end
				end;
			},
		},
	},
	{ -- Page Icone
		["Infos"] = {
			["Titre"] = "TRP2_LOC_PAR_ICONE";
			["Icon"] = "Interface\\ICONS\\INV_Misc_Map08";
		},
		["Composants"] = {
			{ -- ICONE PRINCIPALE
				["Nom"] = "TRP2ConfigStringTRPIcon";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_PAR_ICONEMM";
				["DiffX"] = 0;
				["DiffY"] = -20;
			},
			{ -- Rotation Minimap
				["Nom"] = "TRP2ConfigSliderMiniMapIconDegree";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "MiniMapIconDegree";
				["DiffX"] = 0;
				["DiffY"] = -15;
				["Default"] = 210;
				["Titre"] = "TRP2_LOC_PAR_MMRotation";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = TRP2_GetInt(value);
					TRP2_IconePosition();
				end;
				["SliderMin"] = 0;
				["SliderMax"] = 360;
				["Width"] = 150;
			},
			{ -- Position Minimap
				["Nom"] = "TRP2ConfigSliderMiniMapIconPosition";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "MiniMapIconPosition";
				["DiffX"] = 0;
				["DiffY"] = -25;
				["Default"] = 80;
				["Titre"] = "TRP2_LOC_PAR_MMPosition";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = TRP2_GetInt(value);
					TRP2_IconePosition();
				end;
				["SliderMin"] = 0;
				["SliderMax"] = 160;
				["Width"] = 150;
			},
			{ -- Minimap à utiliser
				["Nom"] = "TRP2ConfigEditBoxMiniMapToUse";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "MiniMapToUse";
				["DiffX"] = 0;
				["DiffY"] = -25;
				["Default"] = "Minimap";
				["OnChange"] = function(self)
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = TRP2_EmptyToNil(self:GetText());
					if getglobal(TRP2_GetConfigValueFor(self.VarName,"Minimap")) then
						TRP2_IconePosition();
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MMtoUse.." {v}(Ok)");
					else
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MMtoUse.." {r}(Outch!)");
					end
				end;
			},
			{ -- ICONE PORTRAIT
				["Nom"] = "TRP2ConfigStringRegIcon";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_PAR_ICONEREG";
				["DiffX"] = 0;
				["DiffY"] = -20;
			},
			{ -- X 
				["Nom"] = "TRP2ConfigSliderTargetIconX";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "TargetIconX";
				["DiffX"] = 0;
				["DiffY"] = -15;
				["Default"] = 65;
				["Titre"] = "TRP2_LOC_PAR_ICOTARPOSX";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2_SetTargetIconPosition();
				end;
				["SliderMin"] = 0;
				["SliderMax"] = 400;
				["Width"] = 150;
			},
			{ -- Y
				["Nom"] = "TRP2ConfigSliderTargetIconY";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "TargetIconY";
				["DiffX"] = 0;
				["DiffY"] = -25;
				["Default"] = 210;
				["Titre"] = "TRP2_LOC_PAR_ICOTARPOSY";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2_SetTargetIconPosition();
				end;
				["SliderMin"] = 0;
				["SliderMax"] = 400;
				["Width"] = 150;
			},
			{ -- Frame
				["Nom"] = "TRP2ConfigSliderTargetIconFrame";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "TargetIconFrame";
				["DiffX"] = 0;
				["DiffY"] = -25;
				["Default"] = "TargetFrame";
				["OnChange"] = function(self)
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = TRP2_EmptyToNil(self:GetText());
					if getglobal(TRP2_GetConfigValueFor(self.VarName,"TargetFrame")) then
						TRP2_SetTargetIconPosition();
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MMtoUse.." {v}(Ok)");
					else
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MMtoUse.." {r}(Outch!)");
					end
				end;
			},
			{ -- ICONE Portrait : ETATS
				["Nom"] = "TRP2ConfigStringEtatsIcon";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_PAR_ETATSAFFI";
				["DiffX"] = 0;
				["DiffY"] = -20;
			},
			{ -- X 
				["Nom"] = "TRP2ConfigSliderTargetEtatsX";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "TargetEtatX";
				["DiffX"] = 0;
				["DiffY"] = -15;
				["Default"] = 175;
				["Titre"] = "TRP2_LOC_PAR_ICOTARPOSX";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2_SetTargetEtatPosition();
				end;
				["SliderMin"] = 0;
				["SliderMax"] = 400;
				["Width"] = 150;
			},
			{ -- Y
				["Nom"] = "TRP2ConfigSliderTargetEtatsY";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "TargetEtatY";
				["DiffX"] = 0;
				["DiffY"] = -25;
				["Default"] = 175;
				["Titre"] = "TRP2_LOC_PAR_ICOTARPOSY";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2_SetTargetEtatPosition();
				end;
				["SliderMin"] = 0;
				["SliderMax"] = 400;
				["Width"] = 150;
			},
			{ -- Frame
				["Nom"] = "TRP2ConfigSliderTargetEtatFrame";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "TargetEtatFrame";
				["DiffX"] = 0;
				["DiffY"] = -25;
				["Default"] = "TargetFrame";
				["OnChange"] = function(self)
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = TRP2_EmptyToNil(self:GetText());
					if getglobal(TRP2_GetConfigValueFor(self.VarName,"TargetFrame")) then
						TRP2_SetTargetEtatPosition();
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MMtoUse.." {v}(Ok)");
					else
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MMtoUse.." {r}(Outch!)");
					end
				end;
			},
		},
	},
	{ -- Page Interface
		["Infos"] = {
			["Titre"] = "UIOPTIONS_MENU";
			["Icon"] = "Interface\\ICONS\\INV_Misc_EngGizmos_27";
		},
		["Composants"] = {
			{ -- Raccbar
				["Nom"] = "TRP2ConfigStringRACCBAR";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_RACC";
				["DiffX"] = 0;
				["DiffY"] = -10;
			},
			{ -- Check Affichage
				["Nom"] = "TRP2ConfigCheckAffichageRacc";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "RaccBarShow";
				["DiffX"] = -55;
				["DiffY"] = -10;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckAffichageRacc:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAffichageRacc.VarName] = true;
						TRP2ConfigCheckAffichageRaccText:SetText(TRP2_CTS("{v}"..TRP2_LOC_RACCAFF));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAffichageRacc.VarName] = false;
						TRP2ConfigCheckAffichageRaccText:SetText(TRP2_CTS("{r}"..TRP2_LOC_RACCAFF));
					end
				end;
			},
			{ -- Alpha raccbar
				["Nom"] = "TRP2ConfigSliderAlpharaccbar";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "RaccBarAlpha";
				["DiffX"] = 55;
				["DiffY"] = -20;
				["Default"] = 100;
				["Titre"] = "TRP2_LOC_AlphaRaccBar";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2_RaccBar:SetAlpha(TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName]/100);
					TRP2ConfigSliderAlpharaccbarTexte:SetText(value.."%");
				end;
				["SliderMin"] = 0;
				["SliderMax"] = 100;
				["Width"] = 150;
			},
			{ -- Minimap
				["Nom"] = "TRP2ConfigStringMINIC";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "MINIMAP_LABEL";
				["DiffX"] = 0;
				["DiffY"] = -20;
			},
			{ -- Check Minimap
				["Nom"] = "TRP2ConfigCheckMinimap";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "MinimapShow";
				["DiffX"] = -55;
				["DiffY"] = -10;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckMinimap:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckMinimap.VarName] = true;
						TRP2ConfigCheckMinimapText:SetText(TRP2_CTS("{v}"..TRP2_LOC_MINIMAPOK));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckMinimap.VarName] = false;
						TRP2ConfigCheckMinimapText:SetText(TRP2_CTS("{r}"..TRP2_LOC_MINIMAPOK));
					end
				end;
			},
			{ -- Accrochage
				["Nom"] = "TRP2ConfigStringAnchor";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_ACCROFON";
				["DiffX"] = 55;
				["DiffY"] = -20;
			},
			{ -- Check use chat
				["Nom"] = "TRP2ConfigCheckAnchorChatFrame";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "bAnchorNoChat";
				["DiffX"] = -70;
				["DiffY"] = -10;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckAnchorChatFrame:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAnchorChatFrame.VarName] = true;
						TRP2ConfigCheckAnchorChatFrameText:SetText(TRP2_CTS("{v}"..TRP2_LOC_Achnor_Chat));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAnchorChatFrame.VarName] = false;
						TRP2ConfigCheckAnchorChatFrameText:SetText(TRP2_CTS("{r}"..TRP2_LOC_Achnor_Chat));
					end
				end;
			},
			{ -- Check use parole
				["Nom"] = "TRP2ConfigCheckAnchorSpeack";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "bAnchorNoParoles";
				["DiffX"] = 0;
				["DiffY"] = -5;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckAnchorSpeack:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAnchorSpeack.VarName] = true;
						TRP2ConfigCheckAnchorSpeackText:SetText(TRP2_CTS("{v}"..TRP2_LOC_Achnor_Paroles));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAnchorSpeack.VarName] = false;
						TRP2ConfigCheckAnchorSpeackText:SetText(TRP2_CTS("{r}"..TRP2_LOC_Achnor_Paroles));
					end
				end;
			},
			{ -- Check use emote
				["Nom"] = "TRP2ConfigCheckAnchorEmote";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "bAnchorNoEmote";
				["DiffX"] = 0;
				["DiffY"] = -5;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckAnchorEmote:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAnchorEmote.VarName] = true;
						TRP2ConfigCheckAnchorEmoteText:SetText(TRP2_CTS("{v}"..TRP2_LOC_Achnor_Emote));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAnchorEmote.VarName] = false;
						TRP2ConfigCheckAnchorEmoteText:SetText(TRP2_CTS("{r}"..TRP2_LOC_Achnor_Emote));
					end
				end;
			},
			{ -- Check use itemref
				["Nom"] = "TRP2ConfigCheckAnchorItemRef";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "bAnchorNoItemRef";
				["DiffX"] = 0;
				["DiffY"] = -5;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckAnchorItemRef:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAnchorItemRef.VarName] = true;
						TRP2ConfigCheckAnchorItemRefText:SetText(TRP2_CTS("{v}"..TRP2_LOC_Achnor_ItemRef));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAnchorItemRef.VarName] = false;
						TRP2ConfigCheckAnchorItemRefText:SetText(TRP2_CTS("{r}"..TRP2_LOC_Achnor_ItemRef));
					end
				end;
			},
			{ -- Check use map
				["Nom"] = "TRP2ConfigCheckUseCoord";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "bDontUseCoord";
				["DiffX"] = 0;
				["DiffY"] = -5;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckUseCoord:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckUseCoord.VarName] = true;
						TRP2ConfigCheckUseCoordText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_UseCoord));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckUseCoord.VarName] = false;
						TRP2ConfigCheckUseCoordText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_UseCoord));
					end
				end;
			},
		},
	},
	{ -- Page ChatFrame
		["Infos"] = {
			["Titre"] = "TRP2_LOC_CHATFRAME";
			["Icon"] = "Interface\\ICONS\\Spell_Shadow_SoothingKiss";
		},
		["Composants"] = {
			{ -- ChatFrame à utiliser
				["Nom"] = "TRP2ConfigEditBoxInvFrame";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "InvMessageFrame";
				["DiffX"] = 0;
				["DiffY"] = -15;
				["Default"] = "1";
				["Numeric"] = 1;
				["MaxLetters"] = 1;
				["OnChange"] = function(self)
					if getglobal("ChatFrame"..tostring(self:GetText())) then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = self:GetText();
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = "1";
					end
					local nom = GetChatWindowInfo(tonumber(TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName]));
					TRP2_SetTooltipForFrame(TRP2ConfigEditBoxInvFrame,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_InvFrame,
						TRP2_LOC_PAR_InvFrameTT.."\n\n{v}"..TRP2_LOC_PAR_ChoozenFrame.." : {o}"..nom);
					self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_InvFrame.." {v}("..nom..")");
				end;
			},
			{ -- ChatFrame à utiliser RP
				["Nom"] = "TRP2ConfigEditBoxInvFrameRP";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "InvMessageFrameRP";
				["DiffX"] = 0;
				["DiffY"] = -15;
				["Default"] = "1";
				["Numeric"] = 1;
				["MaxLetters"] = 1;
				["OnChange"] = function(self)
					if getglobal("ChatFrame"..tostring(self:GetText())) then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = self:GetText();
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = "1";
					end
					local nom = GetChatWindowInfo(tonumber(TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName]));
					TRP2_SetTooltipForFrame(TRP2ConfigEditBoxInvFrameRP,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_InvFrameRP,
						TRP2_LOC_PAR_InvFrameRPTT.."\n\n{v}"..TRP2_LOC_PAR_ChoozenFrame.." : {o}"..nom);
					self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_InvFrameRP.." {v}("..nom..")");
				end;
			},
			{ -- Check icone
				["Nom"] = "TRP2ConfigCheckChatIconeBalise";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "ChatIconeBalise";
				["DiffX"] = -70;
				["DiffY"] = -5;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckChatIconeBalise:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatIconeBalise.VarName] = true;
						TRP2ConfigCheckChatIconeBaliseText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_BALIICO));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatIconeBalise.VarName] = false;
						TRP2ConfigCheckChatIconeBaliseText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_BALIICO));
					end
				end;
			},
			{ -- Check no emote yell
				["Nom"] = "TRP2ConfigCheckChatNoEmoteCrier";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "NoEmoteInYell";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckChatNoEmoteCrier:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatNoEmoteCrier.VarName] = true;
						TRP2ConfigCheckChatNoEmoteCrierText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_NoYellingEmote));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatNoEmoteCrier.VarName] = false;
						TRP2ConfigCheckChatNoEmoteCrierText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_NoYellingEmote));
					end
				end;
			},
			{ -- Check no name
				["Nom"] = "TRP2ConfigCheckChatNoName";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "UseNameInChat";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckChatNoName:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatNoName.VarName] = true;
						TRP2ConfigCheckChatNoNameText:SetText(TRP2_CTS("{v}"..TRP2_LOC_NomDeFamille));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatNoName.VarName] = false;
						TRP2ConfigCheckChatNoNameText:SetText(TRP2_CTS("{r}"..TRP2_LOC_NomDeFamille));
					end
				end;
			},
			{ -- Check no title
				["Nom"] = "TRP2ConfigCheckChatNoTitle";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "UseTitleInChat";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckChatNoTitle:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatNoTitle.VarName] = true;
						TRP2ConfigCheckChatNoTitleText:SetText(TRP2_CTS("{v}"..TRP2_LOC_TITRE));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatNoTitle.VarName] = false;
						TRP2ConfigCheckChatNoTitleText:SetText(TRP2_CTS("{r}"..TRP2_LOC_TITRE));
					end
				end;
			},
			{ -- Check no color
				["Nom"] = "TRP2ConfigCheckChatNoColor";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "UseColorInChat";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckChatNoColor:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatNoColor.VarName] = true;
						TRP2ConfigCheckChatNoColorText:SetText(TRP2_CTS("{v}"..TRP2_LOC_COLOR));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatNoColor.VarName] = false;
						TRP2ConfigCheckChatNoColorText:SetText(TRP2_CTS("{r}"..TRP2_LOC_COLOR));
					end
				end;
			},
			{ -- Check OOC Guild
				["Nom"] = "TRP2ConfigCheckChatNoGuild";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "GuildNoIC";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckChatNoGuild:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatNoGuild.VarName] = true;
						TRP2ConfigCheckChatNoGuildText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_GuildIC));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckChatNoGuild.VarName] = false;
						TRP2ConfigCheckChatNoGuildText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_GuildIC));
					end
				end;
			},
			{ -- DETECTEURS
				["Nom"] = "TRP2ConfigStringDetecteurs";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_CHATDETECT";
				["DiffX"] = 70;
				["DiffY"] = -10;
			},
			{ -- HRP Mode
				["Nom"] = "TRP2ConfigSliderHRPMode";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitle";
				["VarName"] = "ColorHRPMode";
				["DiffX"] = 0;
				["DiffY"] = -15;
				["Default"] = 2;
				["Titre"] = "TRP2_LOC_HRPMODE";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						self._onsetting = true
						self:SetValue(self:GetValue())
						value = self:GetValue()     -- cant use original 'value' parameter
						self._onsetting = false
						else return end               -- ignore recursion for actual event handler
						-- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderHRPModeTexte:SetText(TRP2_CTS(TRP2_LOC_HRPMODETab[value]));
						if value == 3 then
						TRP2ConfigEditBoxHRPFRame.disabled = false;
					else
						TRP2ConfigEditBoxHRPFRame.disabled = true;
					end
				end;
				["SliderMin"] = 1;
				["SliderMax"] = 3;
				["Width"] = 150;
			},
			{ -- Frame HRP
				["Nom"] = "TRP2ConfigEditBoxHRPFRame";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "HRPFrame";
				["DiffX"] = 0;
				["DiffY"] = -20;
				["Default"] = "1";
				["OnChange"] = function(self)
					if getglobal("ChatFrame"..tostring(self:GetText())) then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = self:GetText();
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = "1";
					end
					local nom = GetChatWindowInfo(tonumber(TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName]));
					TRP2_SetTooltipForFrame(TRP2ConfigEditBoxHRPFRame,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_HRPMODETab[3],
						TRP2_LOC_PAR_HRPFrameTT.."\n\n{v}"..TRP2_LOC_PAR_ChoozenFrame.." : {o}"..nom);
					self.texte = TRP2_CTS("{o}"..TRP2_LOC_HRPMODETab[3].." {v}("..nom..")");
				end;
			},
			{ -- Emote Mode
				["Nom"] = "TRP2ConfigSliderEmoteMode";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitle";
				["VarName"] = "ColorEmoteMode";
				["DiffX"] = 0;
				["DiffY"] = -20;
				["Default"] = 2;
				["Titre"] = "TRP2_LOC_EMOTEMODE";
				["OnChange"] = function(self)
					   if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderEmoteModeTexte:SetText(TRP2_CTS(TRP2_LOC_EMOTEMODETab[value]));
				end;
				["SliderMin"] = 1;
				["SliderMax"] = 3;
				["Width"] = 150;
			},
			{ -- PNJ Mode
				["Nom"] = "TRP2ConfigSliderPNJMode";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitle";
				["VarName"] = "DetectPipe";
				["DiffX"] = 0;
				["DiffY"] = -25;
				["Default"] = 2;
				["Titre"] = "TRP2_LOC_PNJMODE";
				["OnChange"] = function(self)
				   if not self._onsetting then   -- is single threaded 
					 self._onsetting = true
					 self:SetValue(self:GetValue())
					 value = self:GetValue()     -- cant use original 'value' parameter
					 self._onsetting = false
				   else return end               -- ignore recursion for actual event handler
				   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderPNJModeTexte:SetText(TRP2_CTS(TRP2_LOC_PNJMODETab[value]));
				end;
				["SliderMin"] = 1;
				["SliderMax"] = 2;
				["Width"] = 150;
			},
			{ -- Creations
				["Nom"] = "TRP2ConfigStringCreaChat";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_CREATION";
				["DiffX"] = 0;
				["DiffY"] = -20;
			},
			{ -- Check no paroles
				["Nom"] = "TRP2ConfigCheckCreaNoSpeckEffet";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "NoSpeackingEffect";
				["DiffX"] = -70;
				["DiffY"] = -5;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckCreaNoSpeckEffet:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckCreaNoSpeckEffet.VarName] = true;
						TRP2ConfigCheckCreaNoSpeckEffetText:SetText(TRP2_CTS("{v}"..TRP2_LOC_NODIAL));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckCreaNoSpeckEffet.VarName] = false;
						TRP2ConfigCheckCreaNoSpeckEffetText:SetText(TRP2_CTS("{r}"..TRP2_LOC_NODIAL));
					end
				end;
			},
		},
	},
	{ -- Page Registre
		["Infos"] = {
			["Titre"] = "TRP2_LOC_REGISTRE";
			["Icon"] = "Interface\\ICONS\\INV_Misc_Book_02";
		},
		["Composants"] = {
			{ -- Check notify
				["Nom"] = "TRP2ConfigCheckNotifyNew";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "NotifyNew";
				["DiffX"] = -55;
				["DiffY"] = -15;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckNotifyNew:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckNotifyNew.VarName] = true;
						TRP2ConfigCheckNotifyNewText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_NotifyNew));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckNotifyNew.VarName] = false;
						TRP2ConfigCheckNotifyNewText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_NotifyNew));
					end
				end;
			},
			{ -- Check auto new
				["Nom"] = "TRP2ConfigCheckAutoNew";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "AutoNew";
				["DiffX"] = 0;
				["DiffY"] = -5;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckAutoNew:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAutoNew.VarName] = true;
						TRP2ConfigCheckAutoNewText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_AutoNew));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckAutoNew.VarName] = false;
						TRP2ConfigCheckAutoNewText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_AutoNew));
					end
				end;
			},
			{ -- Check use icon
				["Nom"] = "TRP2ConfigCheckUseIcon";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "UsePlayerIcon";
				["DiffX"] = 0;
				["DiffY"] = -5;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckUseIcon:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckUseIcon.VarName] = true;
						TRP2ConfigCheckUseIconText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_UsePlayerIcon));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckUseIcon.VarName] = false;
						TRP2ConfigCheckUseIconText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_UsePlayerIcon));
					end
				end;
			},
		},
	},
	{ -- Page Tooltips
		["Infos"] = {
			["Titre"] = "TRP2_LOC_ToolTips";
			["Icon"] = "Interface\\ICONS\\INV_Enchant_FormulaGood_01";
		},
		["Composants"] = {
			{ -- Check Tt TRP
				["Nom"] = "TRP2ConfigCheckTTUseTTTRP";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "UseTRPTooltip";
				["DiffX"] = -75;
				["DiffY"] = -10;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTUseTTTRP:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTUseTTTRP.VarName] = true;
						TRP2ConfigCheckTTUseTTTRPText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_TRPTT));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTUseTTTRP.VarName] = false;
						TRP2ConfigCheckTTUseTTTRPText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_TRPTT));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check no tooltip color
				["Nom"] = "TRP2ConfigCheckTooltipNoColor";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "UseColorInTooltip";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTooltipNoColor:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTooltipNoColor.VarName] = true;
						TRP2ConfigCheckTooltipNoColorText:SetText(TRP2_CTS("{v}"..TRP2_LOC_COLOR));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTooltipNoColor.VarName] = false;
						TRP2ConfigCheckTooltipNoColorText:SetText(TRP2_CTS("{r}"..TRP2_LOC_COLOR));
					end
				end;
			},
			{ -- Frame anchor Tt TRP
				["Nom"] = "TRP2ConfigSliderAnchorTTTRP";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "TTAnchors";
				["DiffX"] = 75;
				["DiffY"] = -5;
				["Default"] = "GameTooltip";
				["OnChange"] = function(self)
	
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = TRP2_EmptyToNil(self:GetText());
					if getglobal(TRP2_GetConfigValueFor(self.VarName,"TargetFrame")) then
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MMtoUse.." {v}(Ok)");
						if self:IsVisible() then
							TRP2_MouseOverTooltip("player");
						end
					else
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MMtoUse.." {r}(Outch!)");
					end
				end;
			},
			{ -- Anchor point
				["Nom"] = "TRP2ConfigSliderTTPersoAnchorPoint";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "TTPersoAnchorPoint";
				["DiffX"] = 0;
				["DiffY"] = -15;
				["Default"] = 3;
				["Titre"] = "TRP2_LOC_PAR_AnchorPoint";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
					 self._onsetting = true
					 self:SetValue(self:GetValue())
					 value = self:GetValue()     -- cant use original 'value' parameter
					 self._onsetting = false
				   else return end               -- ignore recursion for actual event handler
				   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderTTPersoAnchorPointTexte:SetText(TRP2_LOC_AnchorTab[value]);
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
				["SliderMin"] = 1;
				["SliderMax"] = 8;
				["Width"] = 150;
			},
			{ -- Check Tt Mount
				["Nom"] = "TRP2ConfigCheckTTUseTTMount";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoMonture";
				["DiffX"] = -75;
				["DiffY"] = -10;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTUseTTMount:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTUseTTMount.VarName] = true;
						TRP2ConfigCheckTTUseTTMountText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_TRPTTMount));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTUseTTMount.VarName] = false;
						TRP2ConfigCheckTTUseTTMountText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_TRPTTMount));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Frame anchor Tt Mount
				["Nom"] = "TRP2ConfigSliderAnchorTTMount";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "TTAnchorsMount";
				["DiffX"] = 75;
				["DiffY"] = -5;
				["Default"] = "TRP2_PersoTooltip";
				["OnChange"] = function(self)
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = TRP2_EmptyToNil(self:GetText());
					if getglobal(TRP2_GetConfigValueFor(self.VarName,"TargetFrame")) then
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MMtoUse.." {v}(Ok)");
						if self:IsVisible() then
							TRP2_MouseOverTooltip("player");
						end
					else
						self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_MMtoUse.." {r}(Outch!)");
					end
				end;
			},
			{ -- Anchor point
				["Nom"] = "TRP2ConfigSliderTTMountAnchorPoint";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "TTMountAnchorPoint";
				["DiffX"] = 0;
				["DiffY"] = -15;
				["Default"] = 3;
				["Titre"] = "TRP2_LOC_PAR_AnchorPoint";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderTTMountAnchorPointTexte:SetText(TRP2_LOC_AnchorTab[value]);
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
				["SliderMin"] = 1;
				["SliderMax"] = 8;
				["Width"] = 150;
			},
			{ -- Check Tt Combat
				["Nom"] = "TRP2ConfigCheckTTUseTTCombat";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "UseTTInCombat";
				["DiffX"] = -75;
				["DiffY"] = -10;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTUseTTCombat:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTUseTTCombat.VarName] = true;
						TRP2ConfigCheckTTUseTTCombatText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_TRPTTInCombat));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTUseTTCombat.VarName] = false;
						TRP2ConfigCheckTTUseTTCombatText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_TRPTTInCombat));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check Tt wow
				["Nom"] = "TRP2ConfigCheckTTHideold";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "HideOldTooltip";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTHideold:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTHideold.VarName] = true;
						TRP2ConfigCheckTTHideoldText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_HideOT));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTHideold.VarName] = false;
						TRP2ConfigCheckTTHideoldText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_HideOT));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Personnages
				["Nom"] = "TRP2ConfigStringTooltipPerso";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_ToolTipPerso";
				["DiffX"] = 75;
				["DiffY"] = -10;
			},
			{ -- Taille titre
				["Nom"] = "TRP2ConfigSliderTTPersoTailleTitre";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "TTPersoTailleTitre";
				["DiffX"] = 0;
				["DiffY"] = -20;
				["Default"] = 16;
				["Titre"] = "TRP2_LOC_PAR_TTPersoTT";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderTTPersoTailleTitreTexte:SetText(value);
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
				["SliderMin"] = 5;
				["SliderMax"] = 30;
				["Width"] = 150;
			},
			{ -- Taille info
				["Nom"] = "TRP2ConfigSliderTTPersoTailleInfo";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "TTPersoTailleInfo";
				["DiffX"] = 0;
				["DiffY"] = -20;
				["Default"] = 12;
				["Titre"] = "TRP2_LOC_PAR_TTPersoTI";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderTTPersoTailleInfoTexte:SetText(value);
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
				["SliderMin"] = 4;
				["SliderMax"] = 20;
				["Width"] = 150;
			},
			{ -- Taille descri
				["Nom"] = "TRP2ConfigSliderTTPersoTailleDescri";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "TTPersoTailleDescri";
				["DiffX"] = 0;
				["DiffY"] = -20;
				["Default"] = 10;
				["Titre"] = "TRP2_LOC_PAR_TTPersoTD";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderTTPersoTailleDescriTexte:SetText(value);
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
				["SliderMin"] = 4;
				["SliderMax"] = 20;
				["Width"] = 150;
			},
			{ -- Couper Descri
				["Nom"] = "TRP2ConfigSliderCouperDescri";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "CouperDescri";
				["DiffX"] = 0;
				["DiffY"] = -20;
				["Default"] = 0;
				["Titre"] = "TRP2_LOC_PAR_CouperApresChat";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					if value ~= 0 then 
						TRP2ConfigSliderCouperDescriTexte:SetText(TRP2_FT(TRP2_LOC_PAR_CutAfterX,tostring(value)));
					else
						TRP2ConfigSliderCouperDescriTexte:SetText(TRP2_LOC_PAR_NoCut);
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
				["SliderMin"] = 0;
				["SliderMax"] = 400;
				["Width"] = 150;
			},
			{ -- Check icones
				["Nom"] = "TRP2ConfigCheckTTPerso_Icones1";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoIcon1";
				["DiffX"] = -55;
				["DiffY"] = -10;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_Icones1:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Icones1.VarName] = true;
						TRP2ConfigCheckTTPerso_Icones1Text:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowIcone));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Icones1.VarName] = false;
						TRP2ConfigCheckTTPerso_Icones1Text:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowIcone));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check rel
				["Nom"] = "TRP2ConfigCheckTTPerso_Reltion";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoRel";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_Reltion:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Reltion.VarName] = true;
						TRP2ConfigCheckTTPerso_ReltionText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowRelIcone));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Reltion.VarName] = false;
						TRP2ConfigCheckTTPerso_ReltionText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowRelIcone));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check titre
				["Nom"] = "TRP2ConfigCheckTTPerso_Titre";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoTitre";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_Titre:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Titre.VarName] = true;
						TRP2ConfigCheckTTPerso_TitreText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_SmallNames));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Titre.VarName] = false;
						TRP2ConfigCheckTTPerso_TitreText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_SmallNames));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check soustitre
				["Nom"] = "TRP2ConfigCheckTTPerso_SousTitre";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoSousTitre";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_SousTitre:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_SousTitre.VarName] = true;
						TRP2ConfigCheckTTPerso_SousTitreText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowAllTitle));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_SousTitre.VarName] = false;
						TRP2ConfigCheckTTPerso_SousTitreText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowAllTitle));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check Classe race level
				["Nom"] = "TRP2ConfigCheckTTPerso_CRLvl";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoCRLvl";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_CRLvl:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_CRLvl.VarName] = true;
						TRP2ConfigCheckTTPerso_CRLvlText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowCRN));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_CRLvl.VarName] = false;
						TRP2ConfigCheckTTPerso_CRLvlText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowCRN));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check royaume
				["Nom"] = "TRP2ConfigCheckTTPerso_Royaume";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoRoyaume";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_Royaume:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Royaume.VarName] = true;
						TRP2ConfigCheckTTPerso_RoyaumeText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowRealm));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Royaume.VarName] = false;
						TRP2ConfigCheckTTPerso_RoyaumeText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowRealm));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check guilde
				["Nom"] = "TRP2ConfigCheckTTPerso_Guilde";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoGuilde";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_Guilde:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Guilde.VarName] = true;
						TRP2ConfigCheckTTPerso_GuildeText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowGuild));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Guilde.VarName] = false;
						TRP2ConfigCheckTTPerso_GuildeText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowGuild));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check Actu
				["Nom"] = "TRP2ConfigCheckTTPerso_Actu";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoActu";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_Actu:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Actu.VarName] = true;
						TRP2ConfigCheckTTPerso_ActuText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowActuinfo));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Actu.VarName] = false;
						TRP2ConfigCheckTTPerso_ActuText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowActuinfo));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check Actu HRP
				["Nom"] = "TRP2ConfigCheckTTPerso_ActuHRP";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoActuHRP";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_ActuHRP:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_ActuHRP.VarName] = true;
						TRP2ConfigCheckTTPerso_ActuHRPText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowActuhrp));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_ActuHRP.VarName] = false;
						TRP2ConfigCheckTTPerso_ActuHRPText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowActuhrp));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check Auras
				["Nom"] = "TRP2ConfigCheckTTPerso_Auras";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoAuras";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_Auras:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Auras.VarName] = true;
						TRP2ConfigCheckTTPerso_AurasText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowEtats));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Auras.VarName] = false;
						TRP2ConfigCheckTTPerso_AurasText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowEtats));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check cible
				["Nom"] = "TRP2ConfigCheckTTPerso_Cible";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoCible";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_Cible:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Cible.VarName] = true;
						TRP2ConfigCheckTTPerso_CibleText:SetText(TRP2_CTS("{v}"..SHOW_TARGET_OF_TARGET_TEXT));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Cible.VarName] = false;
						TRP2ConfigCheckTTPerso_CibleText:SetText(TRP2_CTS("{r}"..SHOW_TARGET_OF_TARGET_TEXT));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check cible
				["Nom"] = "TRP2ConfigCheckTTPerso_Client";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoClient";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_Client:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Client.VarName] = true;
						TRP2ConfigCheckTTPerso_ClientText:SetText(TRP2_CTS("{v}"..TRP2_LOC_SHOWCLIENT));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Client.VarName] = false;
						TRP2ConfigCheckTTPerso_ClientText:SetText(TRP2_CTS("{r}"..TRP2_LOC_SHOWCLIENT));
					end
					if self:IsVisible() then
						TRP2_MouseOverTooltip("player");
					end
				end;
			},
			{ -- Check Notes
				["Nom"] = "TRP2ConfigCheckTTPerso_Notes";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTPersoCompoNotes";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTPerso_Notes:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Notes.VarName] = true;
						TRP2ConfigCheckTTPerso_NotesText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowNotes));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTPerso_Notes.VarName] = false;
						TRP2ConfigCheckTTPerso_NotesText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowNotes));
					end
					if self:IsVisible() and UnitName("target") then
						TRP2_MouseOverTooltip("target");
					end
				end;
			},
			{ -- Couper Notes
				["Nom"] = "TRP2ConfigSliderCouperNotes";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitlePlusAndMinus";
				["VarName"] = "CouperNotes";
				["DiffX"] = 55;
				["DiffY"] = -20;
				["Default"] = 0;
				["Titre"] = "TRP2_LOC_PAR_CouperNotesChat";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					if self:GetValue() ~= 0 then 
						TRP2ConfigSliderCouperNotesTexte:SetText(TRP2_FT(TRP2_LOC_PAR_CutAfterX,tostring(value)));
					else
						TRP2ConfigSliderCouperNotesTexte:SetText(TRP2_LOC_PAR_NoCut);
					end
					if self:IsVisible() and UnitName("target") then
						TRP2_MouseOverTooltip("target");
					end
				end;
				["SliderMin"] = 0;
				["SliderMax"] = 400;
				["Width"] = 150;
			},
			{ -- Objets
				["Nom"] = "TRP2ConfigStringTooltipObjet";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_LOC_TOOLTIP_OBJET";
				["DiffX"] = 0;
				["DiffY"] = -20;
			},
			{ -- Check Valeur
				["Nom"] = "TRP2ConfigCheckTTObjets_Valeur";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTObjetsCompoValeur";
				["DiffX"] = -60;
				["DiffY"] = -5;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTObjets_Valeur:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTObjets_Valeur.VarName] = true;
						TRP2ConfigCheckTTObjets_ValeurText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowValue));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTObjets_Valeur.VarName] = false;
						TRP2ConfigCheckTTObjets_ValeurText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowValue));
					end
				end;
			},
			{ -- Check Poids
				["Nom"] = "TRP2ConfigCheckTTObjets_Poids";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTObjetsCompoPoids";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTObjets_Poids:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTObjets_Poids.VarName] = true;
						TRP2ConfigCheckTTObjets_PoidsText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowWeight));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTObjets_Poids.VarName] = false;
						TRP2ConfigCheckTTObjets_PoidsText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowWeight));
					end
				end;
			},
			{ -- Check Poids
				["Nom"] = "TRP2ConfigCheckTTObjets_Help";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTObjetsCompoHelp";
				["DiffX"] = 0;
				["DiffY"] = 0;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTObjets_Help:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTObjets_Help.VarName] = true;
						TRP2ConfigCheckTTObjets_HelpText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_ShowObjHelp));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTObjets_Help.VarName] = false;
						TRP2ConfigCheckTTObjets_HelpText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_ShowObjHelp));
					end
				end;
			},
			{ -- Familier
				["Nom"] = "TRP2ConfigStringTooltipPet";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "PETS";
				["DiffX"] = 60;
				["DiffY"] = -20;
			},
			{ -- Check Valeur
				["Nom"] = "TRP2ConfigCheckTTFam_Food";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "TTFamFood";
				["DiffX"] = -60;
				["DiffY"] = -5;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckTTFam_Food:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTFam_Food.VarName] = true;
						TRP2ConfigCheckTTFam_FoodText:SetText(TRP2_CTS("{v}"..TRP2_PETDIET));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckTTFam_Food.VarName] = false;
						TRP2ConfigCheckTTFam_FoodText:SetText(TRP2_CTS("{r}"..TRP2_PETDIET));
					end
				end;
			},
		},
	},
	{ -- Page Sound
		["Infos"] = {
			["Titre"] = "SOUND_OPTIONS";
			["Icon"] = "Interface\\ICONS\\INV_Misc_Ear_Human_01";
		},
		["Composants"] = {
			{ -- Check sounds
				["Nom"] = "TRP2ConfigCheckUseSound";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "ActivateSound";
				["DiffX"] = -55;
				["DiffY"] = -5;
				["Default"] = true;
				["OnChange"] = function(self)
					if TRP2ConfigCheckUseSound:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckUseSound.VarName] = true;
						TRP2ConfigCheckUseSoundText:SetText(TRP2_CTS("{v}"..ENABLE_SOUND));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckUseSound.VarName] = false;
						TRP2ConfigCheckUseSoundText:SetText(TRP2_CTS("{r}"..ENABLE_SOUND));
					end
				end;
			},
			{ -- Check soundlog
				["Nom"] = "TRP2ConfigCheckSoundlog";
				["Type"] = "CheckButton";
				["Inherit"] = "TRP2_CheckButtonSmallTemplate";
				["VarName"] = "bSoundLog";
				["DiffX"] = 0;
				["DiffY"] = -5;
				["Default"] = false;
				["OnChange"] = function(self)
					if TRP2ConfigCheckSoundlog:GetChecked() then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckSoundlog.VarName] = true;
						TRP2ConfigCheckSoundlogText:SetText(TRP2_CTS("{v}"..TRP2_LOC_PAR_SoundLog));
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][TRP2ConfigCheckSoundlog.VarName] = false;
						TRP2ConfigCheckSoundlogText:SetText(TRP2_CTS("{r}"..TRP2_LOC_PAR_SoundLog));
					end
				end;
			},
			{ -- ChatFrame à utiliser pour le debug
				["Nom"] = "TRP2ConfigEditBoxSoundLogFrame";
				["Type"] = "EditBox";
				["Inherit"] = "TRP2_EditBoxSmallText";
				["VarName"] = "SoundLogFrame";
				["DiffX"] = 60;
				["DiffY"] = -10;
				["Default"] = "1";
				["Numeric"] = 1;
				["MaxLetters"] = 1;
				["OnChange"] = function(self)
					if getglobal("ChatFrame"..tostring(self:GetText())) then
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = self:GetText();
					else
						TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = "1";
					end
					local nom = GetChatWindowInfo(tonumber(TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName]));
					TRP2_SetTooltipForFrame(TRP2ConfigEditBoxSoundLogFrame,TRP2MainFrame,"RIGHT",-10,-415,TRP2_LOC_PAR_SoundFrame,
						TRP2_LOC_PAR_SoundFrameTT.."\n\n{v}"..TRP2_LOC_PAR_ChoozenFrame.." : {o}"..nom);
					self.texte = TRP2_CTS("{o}"..TRP2_LOC_PAR_SoundFrame.." {v}("..nom..")");
				end;
			},
			
		},
	},
	{ -- Page Security
		["Infos"] = {
			["Titre"] = "TRP2_LOC_CONFIG_SECURITY";
			["Icon"] = "Interface\\ICONS\\Item_pyriumkey";
		},
		["Composants"] = {
			{ -- Access defaut
				["Nom"] = "TRP2ConfigSliderAccessDefaut";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitle";
				["VarName"] = "AccessDefaut";
				["DiffX"] = 0;
				["DiffY"] = -20;
				["Default"] = 3;
				["Titre"] = "TRP2_LOC_PAR_DefautAcces";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderAccessDefautTexte:SetText(TRP2_CTS(TRP2_LOC_AccessTab[value]));
				end;
				["SliderMin"] = 1;
				["SliderMax"] = 4;
				["Width"] = 150;
			},
			{ -- Personnages
				["Nom"] = "TRP2ConfigStringSecuritySeparator";
				["Type"] = "Frame";
				["Inherit"] = "TRP2_ListSeparator";
				["Titre"] = "TRP2_DesBarres";
				["DiffX"] = 0;
				["DiffY"] = -20;
			},
			{ -- Access Hist
				["Nom"] = "TRP2ConfigSliderAccessHisto";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitle";
				["VarName"] = "AccessHisto";
				["DiffX"] = 0;
				["DiffY"] = -20;
				["Default"] = 3;
				["Titre"] = "TRP2_LOC_PAR_DefautHisto";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					_G[self:GetName().."Texte"]:SetText(TRP2_CTS(TRP2_LOC_AccessTab[value]));
				end;
				["SliderMin"] = 1;
				["SliderMax"] = 4;
				["Width"] = 150;
			},
			{ -- Access Son globaux
				["Nom"] = "TRP2ConfigSliderSonsglobauxAcces";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitle";
				["VarName"] = "MinimumForSound";
				["DiffX"] = 0;
				["DiffY"] = -30;
				["Default"] = 3;
				["Titre"] = "TRP2_LOC_AccessLevelSound";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderSonsglobauxAccesTexte:SetText(TRP2_LOC_AccessTab[value]);
				end;
				["SliderMin"] = 1;
				["SliderMax"] = 4;
				["Width"] = 150;
			},
			{ -- Access paroles scripts
				["Nom"] = "TRP2ConfigSliderParolesAcces";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitle";
				["VarName"] = "MinimumForDialog";
				["DiffX"] = 0;
				["DiffY"] = -30;
				["Default"] = 3;
				["Titre"] = "TRP2_LOC_AccessLevelDialog";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderParolesAccesTexte:SetText(TRP2_LOC_AccessTab[value]);
				end;
				["SliderMin"] = 1;
				["SliderMax"] = 4;
				["Width"] = 150;
			},
			{ -- Access LUA scripts
				["Nom"] = "TRP2ConfigSliderScriptsAcces";
				["Type"] = "Slider";
				["Inherit"] = "TRP2_SliderWithTitle";
				["VarName"] = "MinimumForScript";
				["DiffX"] = 0;
				["DiffY"] = -30;
				["Default"] = 4;
				["Titre"] = "TRP2_LOC_AccessLevelScript";
				["OnChange"] = function(self)
					if not self._onsetting then   -- is single threaded 
						 self._onsetting = true
						 self:SetValue(self:GetValue())
						 value = self:GetValue()     -- cant use original 'value' parameter
						 self._onsetting = false
					   else return end               -- ignore recursion for actual event handler
					   -- end fix
					TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][self.VarName] = value;
					TRP2ConfigSliderScriptsAccesTexte:SetText(TRP2_LOC_AccessTab[value]);
				end;
				["SliderMin"] = 1;
				["SliderMax"] = 4;
				["Width"] = 150;
			},
		},
	},
};

function TRP2_ChargerConfigValues()
	table.foreach(TRP2_ConfigStructTab,function(pageNum)
		table.foreach(TRP2_ConfigStructTab[pageNum]["Composants"],function(compoNum)
			local Compo = TRP2_ConfigStructTab[pageNum]["Composants"][compoNum];
			local Widget = getglobal(Compo["Nom"]);
			if Widget and Compo["VarName"] then
				local value = Compo["Default"];
				if TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][Compo["VarName"]] ~= nil then
					value = TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur][Compo["VarName"]];
				end
				if Compo["Type"] == "EditBox" then
					Widget:SetText(value);
				elseif Compo["Type"] == "Slider" then
					Widget:SetValue(value);
				elseif Compo["Type"] == "CheckButton" then
					Widget:SetChecked(value);
					TRP2_PCall(Compo["OnChange"],Widget);
				end
			end
		end);
	end);
end

function TRP2_ConstructConfigFrames()
	
	table.foreach(TRP2_ConfigStructTab,function(pageNum)
		if getglobal("TRP2_ConfigFrameScroll"..pageNum) then
			local Scroll = getglobal("TRP2_ConfigFrameScroll"..pageNum);
			-- Titre et icone
			getglobal("TRP2_ConfigFrameScroll"..pageNum.."Titre"):SetText(TRP2_CTS("{o}".._G[TRP2_ConfigStructTab[pageNum]["Infos"]["Titre"]]));
			TRP2_SetTooltipForFrame(getglobal("TRP2_ConfigFrameOnglet"..pageNum),getglobal("TRP2_ConfigFrameOnglet"..pageNum),"BOTTOM",0,0,"{w}".._G[TRP2_ConfigStructTab[pageNum]["Infos"]["Titre"]]);
			getglobal("TRP2_ConfigFrameOnglet"..pageNum.."Icon"):SetTexture(TRP2_ConfigStructTab[pageNum]["Infos"]["Icon"]);
			-- Composants
			table.foreach(TRP2_ConfigStructTab[pageNum]["Composants"],function(compoNum)
				local Compo = TRP2_ConfigStructTab[pageNum]["Composants"][compoNum];
				local widget = CreateFrame(Compo["Type"],Compo["Nom"],getglobal("TRP2_ConfigFrameScroll"..pageNum.."Frame"),Compo["Inherit"]);
				widget.VarName = Compo["VarName"];
				if compoNum == 1 then
					widget:SetPoint("TOP", getglobal("TRP2_ConfigFrameScroll"..pageNum.."Titre"), "BOTTOM", Compo["DiffX"], Compo["DiffY"]);
				else
					widget:SetPoint("TOP", getglobal(TRP2_ConfigStructTab[pageNum]["Composants"][compoNum-1]["Nom"]), "BOTTOM", Compo["DiffX"], Compo["DiffY"]);
				end
				if Compo["Type"] == "EditBox" then -- Code spécifique aux editBox
					if Compo["Titre"] then
						widget.texte = TRP2_CTS("{o}".._G[Compo["Titre"]]);
					end
					if Compo["OnChange"] then
						widget:SetScript("OnTextChanged",Compo["OnChange"]);
					end
					if Compo["Numeric"] then
						widget:SetNumeric(Compo["Numeric"]);
					end
					if Compo["MaxLetters"] then
						widget:SetMaxLetters(Compo["MaxLetters"]);
					end
				elseif Compo["Type"] == "Slider" then -- Code spécifique aux sliders
					if Compo["Titre"] then
						getglobal(widget:GetName().."Titre"):SetText(TRP2_CTS("{o}".._G[Compo["Titre"]]));
					end
					if Compo["OnChange"] then
						widget:SetScript("OnValueChanged",Compo["OnChange"]);
					end
					if Compo["Width"] then
						widget:SetWidth(Compo["Width"]);
					end
					widget:SetMinMaxValues(Compo["SliderMin"],Compo["SliderMax"]);
				elseif Compo["Type"] == "CheckButton" then -- Code spécifique aux checkbutton
					if Compo["Titre"] then
						getglobal(widget:GetName().."Text"):SetText(TRP2_CTS("{o}".._G[Compo["Titre"]]));
					end
					if Compo["OnChange"] then
						widget:SetScript("OnClick",Compo["OnChange"]);
					end
				elseif Compo["Type"] == "Frame" then -- Code spécifique aux TRP2_ListSeparator
					if Compo["Titre"] then
						getglobal(widget:GetName().."Texte"):SetText(TRP2_CTS("{w}".._G[Compo["Titre"]]));
					end
					if Compo["Font"] then
						getglobal(widget:GetName().."Texte"):SetFontObject(Compo["Font"]);
					end
				end
				widget:Show();
			end);
		else
			TRP2_Error("TRP2_ConfigStructTab : getglobal(\"TRP2_ConfigFrameScroll\"..pageNum) nil");
		end
	end);
end