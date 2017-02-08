local uiRenascencePanel   = Ui(Ui.UI_RENASCENCEPANEL);

uiRenascencePanel.BTN_HOISINH		= "bthhoisinh";
uiRenascencePanel.BTN_TAKEN_DRUG		= "btnTakenDrug";
uiRenascencePanel.BTN_LOCAL_TREATMENT	= "btnLocalTreatment";
uiRenascencePanel.BTN_GO_HOME			= "btnGoHome";

uiRenascencePanel.OnOpen = function(self)
	Wnd_SetEnable(self.UIGROUP, self.BTN_ACCEPT_CURE, 0);
end

uiRenascencePanel.OnButtonClick = function(self, szWndName, nParam)
	if (me.IsDead() ~= 1) then
		UiManager:CloseWindow(Ui.UI_RENASCENCEPANEL);
		return;
	end
	if (szWndName == self.BTN_LOCAL_TREATMENT) then -- 本地复活
		me.SendClientCmdRevive(1);
	elseif (szWndName == self.BTN_GO_HOME) then --回城
		me.SendClientCmdRevive(0);
	elseif (szWndName == self.BTN_HOISINH) then -- 接受治疗
		if me.IsDead() == 1 then
			Ui.tbLogic.tbTimer:Register(0.5* Env.GAME_FPS, uiRenascencePanel.HoiSinh, uiRenascencePanel);
		end
	end
end
function uiRenascencePanel:HoiSinh()
	--me.Msg("Em dang hoi sinh")
	if me.GetItemCountInBags(18,1,24,1) > 0 then
			if UiManager:WindowVisible(Ui.UI_IBSHOP) == 1 then
				UiManager:CloseWindow(Ui.UI_IBSHOP); 
			end
			me.SendClientCmdRevive(1)
			return 0
		else
			if me.nBindCoin < 50 then
				me.Msg("Hem có đồng khóa để mua")
				return 0
			end
			if Map.Libraries:ByKyCacTran("Cửu Chuyển Tục Mệnh Hoàn",1,3,106,1) then
				return 0.5* Env.GAME_FPS;
			end
		end
end
uiRenascencePanel.WhenGetCure = function(self, nLifeP, nManaP, nStaminaP)
end

uiRenascencePanel.OnPlayerRevival = function(self)
	UiManager:CloseWindow(Ui.UI_RENASCENCEPANEL);
end

uiRenascencePanel.OnPlayerDeath = function(self, szPlayer)
	me.Msg("Đã bị trọng thương!");
	UiManager:OpenWindow(self.UIGROUP);
end

uiRenascencePanel.RegisterEvent = function(self)
	local tbRegEvent = 
	{
		{ UiNotify.emCOREEVENT_PLAYER_DEATH, 	self.OnPlayerDeath },
		{ UiNotify.emCOREEVENT_PLAYER_REVIVE,	self.OnPlayerRevival },
		{ UiNotify.emCOREEVENT_GET_CURE,		self.WhenGetCure },
	};
	return tbRegEvent;
end
