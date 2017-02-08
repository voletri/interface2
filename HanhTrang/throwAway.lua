
local nTimerId = 0;
local nTimerId1 = 0;
local nState   = 0;
local nTime    = 1/6;   

function AutoAi:SwitchAutoThrowAway()
	if nTimerId == 0 then
		nTimerId = Ui.tbLogic.tbTimer:Register(nTime * Env.GAME_FPS, self.AutoThrowAway, self);
		me.Msg("<color=yellow>Bắt đầu xả rác ra môi trường");
	else
		Timer:Close(nTimerId);
		nTimerId = 0;
		me.Msg("<color=yellow>Người lịch sự nên chọn bán rác,không phải ném :D ！");
	end
end

function AutoAi:AutoThrowAway()
	if me.IsAccountLock() == 1 then
		me.Msg("<color=yellow>Tài khoản đang khóa, chắc trêu :(");
		return 0
	end
	local tbItem = me.FindItemInBags(22,1,41,1)[1] or me.FindItemInBags(22,1,35,1)[1] or me.FindItemInBags(22,1,37,1)[1] or me.FindItemInBags(22,1,39,1)[1] 
		or me.FindItemInBags(22,1,43,1)[1] or me.FindItemInBags(18,1,289,10)[1] or me.FindItemInBags(18,1,289,9)[1] or me.FindItemInBags(18,1,289,8)[1]
		or me.FindItemInBags(18,1,289,7)[1] or me.FindItemInBags(18,1,84,1)[1] or me.FindItemInBags(18,1,252,1)[1]
	if tbItem then
		me.ThrowAway(tbItem.nRoom, tbItem.nX, tbItem.nY);
	else
		Timer:Close(nTimerId);
		nTimerId = 0;
		me.Msg("<color=yellow>Người lịch sự nên chọn bán rác,không phải ném :D ！");
	end
end
