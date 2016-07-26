local RELOAD 		= UiManager;
local ReloadCH		= {};
local tbAutoPath		= Ui.tbLogic.tbAutoPath or {};
local tbScrCallUi	= Ui.tbScrCallUi or {}; 
Ui.tbScrCallUi	= tbScrCallUi;
local self = tbScrCallUi;
local UiScrCallUi = Ui.tbScrCallUi;

local Reload = 0
local nTimer_TienIch = 0

local filereload = {
"\\interface2\\All\\AutoAimUi.lua",
--"\\interface2\\All\\LenNgua.lua",
--"\\interface2\\Shortcuts\\ScriptLoad.lua",
--"\\interface2\\TienIch\\AutoDoiBacKhoaTHoi.lua",
--"\\interface2\\DiChuyenNangCao\\maplink_ui.lua",
--"\\interface2\\DieuKhienToDoi\\AutoChiLing.lua",
--"\\interface2\\DieuKhienToDoi\\Teamcontrol.lua",
--"\\interface2\\TienIch\\BaoVatDoiTheTDC.lua",
--"\\interface2\\TienIch\\MoTLC.lua",
--"\\interface2\\TienIch\\TuMuaMau.lua",
--"\\interface2\\AutoTrongCayGT\\AutoTrongCay.lua",
--"\\interface2\\AutoTrongCayGT\\TrongCayGiaToc.lua",
--"\\interface2\\AutoMauThucAn\\AutoMauThucAn.lua",
}

local state = 0;
local timer = 0;
local timer1 = 0;
function RELOAD.AutoAlert()
			
end
function RELOAD.AutoAlertGB()
	
end
function RELOAD.dotimer()
	if state == 0 then
		timer = Ui.tbLogic.tbTimer:Register(300,RELOAD.AutoAlert);
		timer1 = Ui.tbLogic.tbTimer:Register(10000,RELOAD.AutoAlertGB);
		state = 1;
	end
	me.Msg("<color=pink>Done");
end

function RELOAD.OnOpen()

	for i = 1,table.getn(filereload) do
		local str = KIo.ReadTxtFile(filereload[i]);
		if str ~= "" then
			assert(loadstring(str,filereload[i]))()
			me.Msg(tostring("<color=red>ReLoad: <color=white>"..filereload[i]))
		else
			me.Msg(tostring("Error:"..filereload[i]))
		end
	end

end

function tbScrCallUi.CloseWinDow()
	if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
		UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
	end
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then	
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end
	if UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1 then
		UiManager:CloseWindow(Ui.UI_REPOSITORY);
	end
end


local szCmd	= [=[
		UiManager.OnOpen();
	]=];
UiShortcutAlias:AddAlias("GM_C5", szCmd);

