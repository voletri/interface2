

local tbMgr = UiManager;


function tbMgr:OnLButtonDown()
	local tbMouse = Ui.tbLogic.tbMouse;
	if (tbMouse:ThrowAway() == 1) then
		return;
	end

	local nRetCode = 0;

	if self:GetUiState(self.UIS_ACTION_VIEWITEM) == 1 then
		nRetCode = ProcessSelectedNpc(self.emACTION_VIEWITEM);
	elseif self:GetUiState(self.UIS_ACTION_FOLLOW) == 1 then
		nRetCode = ProcessSelectedNpc(self.emACTION_FOLLOW);
	elseif self:GetUiState(self.UIS_ACTION_MAKEFRIEND) == 1 then
		nRetCode = ProcessSelectedNpc(self.emACTION_MAKEFRIEND);
	elseif self:GetUiState(self.UIS_ACTION_TRADE) == 1 then
		nRetCode = ProcessSelectedNpc(self.emACTION_TRADE);
	elseif self:GetUiState(self.UIS_TRADE_PLAYER) == 1 then
	elseif self:GetUiState(self.UIS_TRADE_NPC) == 1 then
	elseif self:GetUiState(self.UIS_STALL_BUY) == 1 then
	elseif self:GetUiState(self.UIS_OFFER_SELL) == 1 then
	elseif self:GetUiState(self.UIS_ACTION_GIFT) == 1 then
	else
		local nNpcIndex	= Mouse_Action()	
		if (self.nAutoSelectNpc ~= 1) then
			UiSelectNpc(nNpcIndex or 0);
		end
		
	end

	if nRetCode == 1 then
		uiPopBar:ReleaseAllAction();
	end

end