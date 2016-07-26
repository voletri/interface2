Ui.UI_TULUYENCHAU				= "UI_TULUYENCHAU";
local TuLuyenChau			= Ui.tbWnd[Ui.UI_TULUYENCHAU] or {};
TuLuyenChau.UIGROUP			= Ui.UI_TULUYENCHAU;
Ui.tbWnd[Ui.UI_TULUYENCHAU]	= TuLuyenChau

local self			= TuLuyenChau 

self.state = 0
self.state1 = 0


local sTimers = 0
local sTimers1 = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)

local tbHoi_Chon = {
--{"Xin chào, ta có thể giúp gì?","Ta muốn xem các chức năng khác",1},
{"Đặt tay lên cảm thấy khí huyết cuộn dâng.","<color=yellow>Ta muốn mở tu luyện",1},
{"Đặt tay lên cảm thấy khí huyết cuộn dâng.","Ta muốn mở 0.5 giờ.",1},
{"Bạn đã tăng","Kết thúc đối thoại",1},
{"Thời gian tu luyện bạn tích lũy không đủ,","Kết thúc đối thoại",0},
}

function TuLuyenChau.OnTimer()	
	if (self.state == 0) then
		return
	end
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	if TuLuyenChau.Cohang() then
		local tbFind = me.FindItemInBags(18,1,16,1)
		local Count = me.GetItemCountInBags(18,1,16,1)
		for _, tbItem in pairs(tbFind) do
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1 then
				me.UseItem(tbItem.pItem);
			else
				for i = 1,table.getn(tbHoi_Chon) do
					if tbHoi_Chon[i][3] == 0 then
						if string.find(szQuestion,tbHoi_Chon[i][1]) then
							me.Msg(tostring("<color=white>Hỏi : <color>"..szQuestion))
							for k = 1, table.getn(tbAnswers) do
								if string.find(tbAnswers[k],tbHoi_Chon[i][2]) then
									me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[k]))
									return Env.GAME_FPS * 1, me.AnswerQestion(k-1), Ui.tbScrCallUi:CloseWinDow(), TuLuyenChau.Stop();
								end
							end
						end
					elseif tbHoi_Chon[i][3] == 1 then
						if string.find(szQuestion,tbHoi_Chon[i][1]) then
							me.Msg(tostring("<color=white>Hỏi: <color>"..szQuestion))
							for k = 1, table.getn(tbAnswers) do
								if string.find(tbAnswers[k],tbHoi_Chon[i][2]) then
									me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[k]))
									return Env.GAME_FPS * 1, me.AnswerQestion(k-1), Ui.tbScrCallUi:CloseWinDow();
								end
							end
						end
					end
				end
			end						
		end
	else
		return Env.GAME_FPS * 1, Ui.tbScrCallUi:CloseWinDow(), TuLuyenChau.Stop();
	end
end

-------------------------------------------------------------------
function TuLuyenChau:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color> Chuẩn bi vào Lãnh địa gia tộc");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đang trong lãnh địa rồi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function TuLuyenChau.OnTimer1()	
	if (self.state1 == 0) then
		return
	end
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	if me.GetMapTemplateId() < 65500 then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then			
			for i = 1,table.getn(tbAnswers) do
				if string.find(tbAnswers[i],"<color=yellow>Lãnh địa gia tộc") then
					me.Msg(tostring(""..tbAnswers[i]))
					return Env.GAME_FPS * 1, me.AnswerQestion(i-1);
				end					
			end
			for i = 1,table.getn(tbAnswers) do
				if string.find(tbAnswers[i],"Đồng ý") then
					me.Msg(tostring(""..tbAnswers[i]))
					return Env.GAME_FPS * 1, me.AnswerQestion(i-1), Ui.tbScrCallUi:CloseWinDow(), TuLuyenChau.Stop();
				end					
			end
		else
			local tbItem = me.FindItemInBags(18,1,195,1)[1]; -- vo han truyen tong phu
			if tbItem then
			me.UseItem(tbItem.pItem);
			end
		end						
	else
		return Env.GAME_FPS * 1, Ui.tbScrCallUi:CloseWinDow(), TuLuyenChau.Stop();
	end
end

-------------------------------------------------------------------


function TuLuyenChau.Stop()
	if self.state == 1 then		
		TuLuyenChau:State()		
	end	
	
	if self.state1 == 1 then		
		TuLuyenChau:State1()		
	end	
	
end
