Ui.UI_ToDoiRoi				= "UI_ToDoiRoi";
local ToDoiRoi			= Ui.tbWnd[Ui.UI_ToDoiRoi] or {};
ToDoiRoi.UIGROUP			= Ui.UI_ToDoiRoi;
Ui.tbWnd[Ui.UI_ToDoiRoi]	= ToDoiRoi

local self			= ToDoiRoi 

self.state1 = 0
local sTimers1 = 0
		

local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function ToDoiRoi:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1,18,self.OnTimer1); --2
		--me.Msg("<color=white>Thông báo:<color>Bắt đầu rời tổ đội");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
	--	me.Msg("<color=white>Thông báo:<color> Stop");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function ToDoiRoi.OnTimer1()	
	if (self.state1 == 0) then
		return
	end
	
	local szData = KFile.ReadTxtFile("\\interface2\\Kato\\Acc.txt");
	local ptt = Lib:SplitStr(szData, "\n");
			
		local nhom = ""
		for i=1, #ptt do
			if string.find(ptt[i],me.szName) then
				nhom = ptt[i]
			end
		end
	local pt = Lib:SplitStr(nhom, ",");
	
	--if (not me.nTeamId or me.nTeamId <= 0)
	
	if me.szName == pt[1] then
		ToDoiRoi.Stop();
		return
	end	
	if not me.nTeamId then
		ToDoiRoi.Stop();
	else	
		me.TeamLeave()
		ToDoiRoi.Stop()
	end	
end

-------------------------------------------------------------------

function ToDoiRoi.Stop()
	self.state1 = 1
	ToDoiRoi:State1()		
end
