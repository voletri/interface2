local AutoHangNgay = Ui.AutoHangNgay or {};

local tWait, tOnItem, tSay;

local sName;

function AutoHangNgay:HangNgayInit()
	UiManager:OpenWindow("UI_INFOBOARD", "AutoHangNgay: Wait");
	sName = nil;
	tWait = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 3,AutoHangNgay.OnWait,self);
end

function AutoHangNgay:OnWait()
	if (me.szName ~= "") and me.szName ~= sName and me.GetAccountLockState() ~= 1 then

		-- if (me.szName == "slLâmPhong") or (me.szName == "slLiễuNhượcBăng") or (me.szName == "slMộcHàmYên") or (me.szName == "slĐạmĐàiTuyền") or (me.szName == "slĐộcCôBạiThiên") then
		--	AutoHangNgay:HangNgayOff();
		--	return;
		-- end

		sName = me.szName;
		UiManager:OpenWindow("UI_INFOBOARD", "AutoHangNgay: ".. sName);

		if ((os.date("*t").wday > 1) and (me.GetTask(2196, 2) == 0)) then
			me.CallServerScript({"ApplyKinOpenSalary"});
			me.CallServerScript({"ApplyKinGetSalary"});
			UiManager:OpenWindow("UI_INFOBOARD", "AutoHangNgay: NhanLuong");
		end

		Map.QuayVanPhuc:OnSwitch();

		AutoHangNgay:HangNgayOff();
	end
end

function AutoHangNgay:HangNgayOff()
	UiManager:OpenWindow("UI_INFOBOARD", "AutoHangNgay: Stop");

	if (UiManager:WindowVisible(Ui.UI_KIN_GET_SALARY) == 1) then
		UiManager:CloseWindow(Ui.UI_KIN_GET_SALARY);
	end

	if (UiManager:CloseWindow(Ui.UI_JINGHUOFULI) == 1) then
		UiManager:CloseWindow(Ui.UI_JINGHUOFULI);
	end

	Ui.tbLogic.tbTimer:Close(tWait);
	tWait = nil;
end

AutoHangNgay:HangNgayInit();