local XoyoChallenge = XoyoGame.XoyoChallenge;
local nTimerid;
local tbFind = {};

function XoyoChallenge:AutoUseCard()
	if self:HasXoyoluInBags(me) ~= 1 then
		return;
	end
	tbFind = me.FindClassItemInBags("xoyo_card");
	if tbFind and  #tbFind > 0 then
		for n,tbItem in pairs(tbFind) do
			if tbItem.pItem.nParticular == 314 then
				table.remove(tbFind,n);
			end
			if self:GetCardState(me, tbItem.pItem.SzGDPL()) == 2 then
				table.remove(tbFind,n);
			end
		end
	end
	if not tbFind or #tbFind <= 0 then
		me.Msg("Thẻ không thể dùng");
		return;
	end
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Tự động dùng thẻ TDC");
	nTimerid = Timer:Register(9,self.OnTimer,self);
end

function XoyoChallenge:OnTimer()
	if #tbFind <= 0 then
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>逍遥卡片已经使用完毕");
		me.Msg("Không có thẻ TDC để ăn zz");
		return 0;
	end
	me.UseItem(tbFind[1].pItem);
	table.remove(tbFind,1);
end
