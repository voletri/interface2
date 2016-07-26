local tbNangDong = Map.tbNangDong or {}
Map.tbNangDong = tbNangDong
local self			= tbNangDong
SpecialEvent.ActiveGift = SpecialEvent.ActiveGift or {}
local ActiveGift = SpecialEvent.ActiveGift;

function tbNangDong:Init()
	if self.nTimerFlag then
		Timer:Close(self.nTimerFlag)		
	end	
	self.nTimerFlag = Timer:Register(Env.GAME_FPS * 3, self.CheckFlag, self);
end

function tbNangDong:CheckFlag()
	for i =1, 5 do
		local bCanGActive = ActiveGift:CheckCanGetAward(1, i);
		local bCanGLogin = ActiveGift:CheckCanGetAward(2, i);
		if bCanGActive == 1 then
			me.CallServerScript({ "GetActiveGiftAward", i});
			me.Msg("<color=yellow>Nhận phần thưởng năng động hôm nay - Rương cấp:<color> <color=green>" .. i .. "<color>");
			break;
		end
		if bCanGLogin == 1 then
			me.CallServerScript({ "GetActiveMonthAward", i});
			me.Msg("<color=yellow>Nhận phần thưởng năng động tháng này - Rương cấp:<color> <color=green>" .. i .. "<color>");
			break;
		end
	end
	
	return;
end

local szCmd = [=[
	Map.tbNangDong:State();
]=];
UiShortcutAlias:AddAlias("GM_S5", szCmd);
self.state = 0
local sTimer = 0
local Can = 0
local Count = 1
local uiSayPanel = Ui(Ui.UI_SAYPANEL)

local tbHoi_Chon = {
{"Mỗi ngày các hiệp sĩ có thể nhận phần thưởng tương ứng dựa vào điểm năng động của bản thân.","<color=yellow>Nhận phần thưởng ",1},
{"Mỗi ngày các hiệp sĩ có thể nhận phần thưởng tương ứng dựa vào điểm năng động của bản thân.","Nhận phần thưởng ",1},
{"Có thể nhận","Nhận phần thưởng",1},
{"Hôm nay đã nhận thưởng năng động","Kết thúc đối thoại",0},
{"Độ năng động hôm nay chưa đủ để nhận thưởng","Kết thúc đối thoại",0},
}

function tbNangDong:State()	
	if self.state == 0 then	
		sTimer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 2,18,self.CheckSayPanel);
		me.Msg("<color=yellow>Tự Nhận thưởng Năng Động <color> Bắt đầu");
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật tự nhận thưởng điểm năng động <bclr><color>");
		--Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Bật tự động <color><bclr> Bắt đầu");
		self.state = 1
	else		
		self.state = 0
		Ui.tbLogic.tbTimer:Close(sTimer);
		me.Msg("<color=white>Tự Nhận thưởng Năng Động <color> Kết thúc");
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự nhận thưởng điểm năng động <bclr><color>");
		--Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=White>Tắt tự động<color><bclr> Kết thúc");
		sTimer = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function tbNangDong.CheckSayPanel()	
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer()
	local nActiveGrade = ActiveGift:GetActiveGrade();
	if self.state == 0 then
		return
	end
	if nActiveGrade < 90 then return end
	if nActiveGrade >= 90 and nActiveGrade < 120 then Can = 1	
	elseif nActiveGrade >= 120 and nActiveGrade < 160 then Can = 2
	elseif nActiveGrade >= 160 and nActiveGrade < 200 then Can = 3
	elseif nActiveGrade >= 200 and nActiveGrade < 235 then Can = 4
	elseif nActiveGrade >= 235 and nActiveGrade < 255 then Can = 5
	elseif nActiveGrade >= 255 and nActiveGrade < 280 then Can = 6
	elseif nActiveGrade == 280 then Can = 7
	end
	if Count <= Can then 
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			for i = 1, table.getn(tbHoi_Chon) do
				if string.find(szQuestion,tbHoi_Chon[i][1]) then
					me.Msg("<color=White>Hỏi : <color>"..szQuestion)		
					for j = 1,table.getn(tbAnswers) do
						if string.find(tbAnswers[j],tbHoi_Chon[i][2]) then								
							if tbHoi_Chon[i][3] == 0 then
								me.Msg("<color=lightgreen>Chúc mừng bạn đã<color> : <color=White> nhận phần thưởng thứ <color> "..Count.." <color=orange>của hoạt động")
								SendChannelMsg("Team", "Độ năng động hiện tại là: ["..nActiveGrade.."] có thể nhận phần thưởng thứ ["..Count.."] của hoạt động")
								Count = Count + 1
								return Ui(Ui.UI_SAYPANEL):OnButtonClick("BtnClose"), Count
							else
								me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[j]))
								return Env.GAME_FPS * 1, me.AnswerQestion(j-1), Ui.tbScrCallUi:CloseWinDow();
							end
						end							
					end
				end
			end
		else
			me.CallServerScript({"GetVnGuiYuanAward"})
		end
	elseif Count > 7 then
		me.Msg("<color=lightgreen>Chúc mừng bạn đã<color> : <color=White> nhận hết phần thưởng của đợt này<color>")
		self.state = 0
	end
end
---------hết-------------
function tbNangDong.Start()
	if tbNangDong.state == 0 then		
		tbNangDong:State()		
	end	
end

function tbNangDong.Stop()
	if tbNangDong.state == 1 then		
		tbNangDong:State()		
	end	
end

function AutoAi:ReLoad_NangDong()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface2\\All\\Nang_Dong.lua")
end
tbNangDong:Init();