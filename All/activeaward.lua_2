---- tự nhận thương năng động ----
local tbActiveAward = Map.tbActiveAward or {};
Map.tbActiveAward = tbActiveAward;
SpecialEvent.ActiveGift = SpecialEvent.ActiveGift or {};
local ActiveGift = SpecialEvent.ActiveGift;

function tbActiveAward:Init()
	if self.nTimerFlag then
		Timer:Close(self.nTimerFlag)		
	end
	self.nTimerFlag = Timer:Register(Env.GAME_FPS * 3, self.CheckFlag, self);
end

function tbActiveAward:CheckFlag()
	for i =1, 5 do
		local bCanGActive = ActiveGift:CheckCanGetAward(1, i);
		local bCanGLogin = ActiveGift:CheckCanGetAward(2, i);
		if bCanGActive == 1 then
			me.CallServerScript({ "GetActiveGiftAward", i});
			Ui(Ui.UI_TASKTIPS):Begin("Tự nhận thưởng năng động hôm nay: <color=yellow>Rương cấp " .. i .. "<color>");
			break;
		end
		if bCanGLogin == 1 then
			me.CallServerScript({ "GetActiveMonthAward", i});
			Ui(Ui.UI_TASKTIPS):Begin("Tự nhận thưởng năng động tháng này: <color=yellow>Túi quà cấp " .. i .. "<color>");
			break;
		end
	end
end

tbActiveAward:Init();