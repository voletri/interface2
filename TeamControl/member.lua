
local self = tbMember;
local tbMember	= Map.tbMember or {}; 
Map.tbMember	= tbMember;


local GuessSwitch = 1;
local Guess2Switch = 1;
local TeamLeaderGetBox=0;

local MainPlayer="";

local nLenh1 =0;
local nLenh2 =0;
local nLenh3 =0;
local nTimerIdGoHome =0;
local nTimerIdDotLua =0;
local nGoHome =0;
local nChoseTime=0.6;
local tbMsgInfo = Ui.tbLogic.tbMsgInfo;
local nCheckMap1TimerId=0;
local nCheckMap2TimerId=0;
local nCheckMap3TimerId=0;
local nChose3TimerId=0;
local nAutoTaskTimerId=0;
local i,j,k,a,b,c

function tbMember:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	tbMember.Say_bak	= tbMember.Say_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway)
		tbMember.Say_bak(Ui(Ui.UI_MSGPAD), szChannelName, szName, szMsg, szGateway);
		local function fnOnSay()			
			tbMember:OnSay(szChannelName, szName, szMsg, szGateway);
			return 0;
		end
		Timer:Register(1, fnOnSay);
	end

end

tbMember.Init =function(self)
	self:ModifyUi();
end

function tbMember:OnSay(szChannelName, szName, szMsg, szGateway)	
	local stype
	if   szChannelName=="Team" then
		stype="Đồng Đội"
	elseif  szChannelName=="Tong" then
		stype="Bang"
	elseif  szChannelName=="Friend" then
		stype="Hảo hữu"
	elseif  szChannelName=="Kin" then
		stype="Gia Tộc"
	elseif  szChannelName=="NearBy" then
		stype="Lân cận"
	end
	
	if (GuessSwitch == 0) then
		return;
	end

	
	if string.find(szMsg,"3") and stype=="Đồng Đội" then
		if me.GetMapTemplateId() < 65500 then
		return
		end
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nTemplateId == 4223) then  
				AutoAi.SetTargetIndex(pNpc.nIndex);
				break;
			end
		end
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bắt đầu mở Quang Ảnh Thạch");
	elseif string.find(szMsg,"Luyện.:.Công") and stype=="Đồng Đội" then
		me.nPkModel = Player.emKPK_STATE_PRACTISE;
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=white>Đồng đội gọi bật [Luyện Công]<color>");
		me.Msg("<color=yellow>Đồng đội gọi bật [Luyện Công]<color>")
	end	
	---------------------------He Thong--------------------
	if  string.find(szMsg,"aetudanh") and stype=="Đồng Đội" then	
		if me.nAutoFightState ~= 1 then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");	
		end
	end
	
	if  string.find(szMsg,"aestop") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() > 65500 or Guess2Switch == 1 then
			if me.nAutoFightState == 1 then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		end
		Map.tbAutoAim:AutoFollowStop();
		UiManager:StopBao();
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  string.find(szMsg,"aetheosau") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() > 65500 or Guess2Switch == 1 then
		Map.tbAutoAim:AutoFollowStart();
				return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	------------------Ngac Lua Ha Nguyen------------------------- 
	if  (string.find(szMsg,"aevaonlhn") or string.find(szMsg,"Anh em vào Ngạc Luân Hà Nguyên nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,4,2"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,4,2"});
			return;			
		end
	end
	if  (string.find(szMsg,"aeroinlhn") or string.find(szMsg,"Anh em rời khỏi Ngạc Luân Hà Nguyên nào!!")) and stype=="Đồng Đội" then	
		Map.tbvCTTK:CTTK10Switch();
	end
	if  string.find(szMsg,"Anh em đến Tế Tự Đài nào!!") and stype=="Đồng Đội" then	
		Map.tbvCTC:CTC4Switch();
	end
	if  string.find(szMsg,"Anh em trả bài nào!!") and stype=="Đồng Đội" then	
		Ui.NLHN:State();
	end
	if  string.find(szMsg,"Anh em bắt ngựa nào!!") and stype=="Đồng Đội" then
	Map.AutoQD:OnSwitch();
	end
		-------------------------HLVM------------------------
	if ( string.find(szMsg,"aevaohlvm") or string.find(szMsg,"Anh em Vào HLVM nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,3,2"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,3,2"});
			return;			
		end
	end
	

		----------------------BMS-------------------------
	if ( string.find(szMsg,"aevaobms") or string.find(szMsg,"Anh em Vào BMS nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,2,2"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,2,2"});
			return;
		end
	end
	
		
	if  (string.find(szMsg,"Anh em Rời khỏi BMS nào!!") or string.find(szMsg,"aeroibms")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Bách Man Sơn!");
			return;
		else 
				Map.tbTeamControl:QuitBMS();
		end
	end
	
	
	--------------------------------HPNS-------------------------
	if ( string.find(szMsg,"aevaohspn") or string.find(szMsg,"Anh em Vào HSPN nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,1,2"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,1,2"});
		end
	end
	
	-------------------------------TDC--------------------------
	if  string.find(szMsg,"aevaotdc") and stype=="Đồng Đội" then	
		
Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",23,3237,2"});
		return;
	
	end
	
	if  string.find(szMsg,"aemautdc") and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
			if me.nFaction ~= 9 then
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3234,Nhận thuốc miễn phí hôm nay,1"});
			else
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3234,Nhận thuốc miễn phí hôm nay,3"});
			end
		return;
		else 
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  string.find(szMsg,"aethuongtdc") and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3319,4"});
		--UiManager.tbLinkClass["npcpos"]:OnClick(",0,3319,4,1");
		return;
	else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
	    end
    end

	if  string.find(szMsg,"aedoithe") and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
		Ui(Ui.UI_THEBIBAOTDC):State()
		return;
	else
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		return;
		end
	end

    if  string.find(szMsg,"aedoibac") and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
		Ui(Ui.UI_BACTHUONGHOI):State();
		return;
	else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
	    end
    end
	
	--------máu PL-------	
	if  string.find(szMsg,"aemomau") and stype=="Đồng Đội" then	
	AutoAi:MoRuongThuocPL();
		return;
		
	end
	
	if  string.find(szMsg,"aetramau") and stype=="Đồng Đội" then	
	AutoAi:TraRuongThuocPL();	
		return;
		
	end
	
	--------ma đao thạch-------
	if  (string.find(szMsg,"aecanmdt") or string.find(szMsg, "Anh em cán Lak Ma Đao Thạch cấp 7 nào!!")) and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
		local tbFind = me.FindItemInBags(18,1,66,7); -- ma dao thach c7
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			SendChannelMsg("Team", "Đã cắn Ma Đao Thạch");
		end
	else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
	end
end
	
	--------BHD lien server-------
	if  string.find(szMsg,"aevaobhd") and stype=="Đồng Đội" then	
			if (me.GetMapTemplateId() > 22) and  (me.GetMapTemplateId() < 30) then
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2654,1,1"});
			else
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,2654,1,1"});		
		return;
			end
	end	
	------------------- Lâu Lan Cổ Thành ---------
	if ( string.find(szMsg,"aeroill") or string.find(szMsg,"Anh em Rời khỏi Lâu Lan Cổ thành nào!!")) and stype=="Đồng Đội" then	
		 
				Map.tbvCTTK:CTTK7Switch();
		
	end
	------------ CKP------------
	if  (string.find(szMsg,"aemuackp") or string.find(szMsg,"Anh em mua CKP nào!!")) and stype=="Đồng Đội" then	
		 
				Ui(Ui.UI_tbCKP):State();
		
	end
	------------ Năng động ------------
	if  (string.find(szMsg,"aenangdong") or string.find(szMsg,"Anh em nhận điểm năng động nào!!")) and stype=="Đồng Đội" then	
				Map.tbNangDong:State();
	end
	------------------------
	if ( string.find(szMsg,"aemokhoats") or string.find(szMsg,"Anh em đăng kí mở khóa nguyên liệu thần sa nào!!")) and stype=="Đồng Đội" then
		me.CallServerScript({"ItemCmd", "ApplyDevStuffUnBind"});
	end
	----------- Thần Trùng Trấn-----------
	if  string.find(szMsg,"aelbttt") and stype=="Đồng Đội" then	
		me.CallServerScript({"PlayerCmd", "GetTreasureTimes", 3, 1});		
	end
	if  string.find(szMsg,"aenvttt") and stype=="Đồng Đội" then	
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",2150,9986,[Thế giới]Thần Trùng Tích Xưa"});
	end
	if  string.find(szMsg,"aevaottt") and stype=="Đồng Đội" then	
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",2150,9986,Mời xem! [Mở Thần Trùng Trấn],Vào Thần Trùng Trấn"});
	end
	if  string.find(szMsg,"aethuongttt") and stype=="Đồng Đội" then	
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2625,1"});
	end
	--------------- Thời quang lệnh -------------
	if  (string.find(szMsg,"aelbtql") or string.find(szMsg,"Anh em nhận Lệnh bài TQL nào!!")) and stype=="Đồng Đội" then	
		
		me.CallServerScript({"PlayerCmd", "GetTreasureTimes", 3, 2});		
		
	end
	if  (string.find(szMsg,"aenvtql") or string.find(szMsg,"Anh em nhận nhiệm vụ TQL nào!!")) and stype=="Đồng Đội" then	
		 
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,9615,[Thế giới]Địa cung thần bí"});
		
	end
	if ( string.find(szMsg,"aevaotql") or string.find(szMsg,"Anh em Vào TQL nào!!")) and stype=="Đồng Đội" then	
		 
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,9615,1,1"});
		
	end
	if  (string.find(szMsg,"aeroitql") or string.find(szMsg,"Anh em Rời khỏi TQL nào!!")) and stype=="Đồng Đội" then	
		 
			Map.tbvCTTK:CTTK8Switch();
		
	end
	------------------ VAGT + nhận thưởng ------
	if  string.find(szMsg,"aevaoaigt") and stype=="Đồng Đội" then	
			Map.tbAutoXuyenSon:MaXSSwitch();
		
	end
	
	if  string.find(szMsg,"aedoitien") and stype=="Đồng Đội" then	
		 
				Map.tbAutoXuyenSon:MrXSSwitch();
	end	
	
	if  string.find(szMsg,"aeroiaigt") and stype=="Đồng Đội" then
				Map.tbvCTTK:CTTK6Switch();
			
	end
	
	if  string.find(szMsg,"aevaoldgt") and stype=="Đồng Đội" then	
		Ui(Ui.UI_TULUYENCHAU):State1()
			
	end
	
	if  string.find(szMsg,"aeroildgt") and stype=="Đồng Đội" then	
			me.CallServerScript({"UseUnlimitedTrans", 6}); 
			
	end
	
	if  string.find(szMsg,"Anh em nhận lương nào !!") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			me.CallServerScript({"ApplyKinGetSalary"});
			UiManager:OnButtonClick("zBtnAccept");
		else 
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end	

	if  string.find(szMsg,"aetrongcay") and stype=="Đồng Đội" then	
			Map.tbKinZhongZhi:Switch();
			
	end
		
	if  (string.find(szMsg,"aelothong") or string.find(szMsg,"Anh em lên bem con boss cuối nào!!")) and stype=="Đồng Đội" then	
			Map.tbvCTTK:CTTK9Switch();
			
	end
	---------- trồng cây phúc lộc gia tộc ----------
	if  string.find(szMsg,"aenhatvp") and stype=="Đồng Đội" then	
			Map.tbAutoEgg:AutoPick()
			
	end
	if  string.find(szMsg,"aegiaovp") and stype=="Đồng Đội" then	
			Ui(Ui.UI_CAYPHUCLOC):State();
			
	end
	-----------------báo boss---
	if  string.find(szMsg,"aebaoboss") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			Map.uiDetector:Switch();	
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	------------- vứt nguyên liệu TDC ----------
	if string.find(szMsg,"aevutrac") and stype=="Đồng Đội" then
		if Guess2Switch == 1 then
			AutoAi:SwitchAutoThrowAway3();
			return;
		else
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	-----------------TĐLT-------------------
    if  string.find(szMsg,"aemautd") and stype=="Đồng Đội" then
       Map.tbAutoMau:LayMau2Switch();
	end
	
	if  (string.find(szMsg,"aelaktd") or string.find(szMsg,"laktd")) and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			Ui(Ui.UI_LAKLANHTHO):State();
		else 
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  (string.find(szMsg,"aecanlaktd") or string.find(szMsg, "Anh em cắn Lak TDLT nào!!")) and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
		local tbFind = me.FindItemInBags(18,1,321,1); -- lak tdlt tieu
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			SendChannelMsg("Team", "Đã cắn Lak Tiểu");
		end
		local tbFind = me.FindItemInBags(18,1,322,2); -- lak tdlt trung
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			SendChannelMsg("Team", "Đã cắn Lak Trung");
		end
		local tbFind = me.FindItemInBags(18,1,323,3); -- lak tdlt dai
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			SendChannelMsg("Team", "Đã cắn Lak Đại");
		end
	else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
	end
end

if  string.find(szMsg,"aethuongtd") and stype=="Đồng Đội" then	
				tbMember:ThuongTD();
	end
if  string.find(szMsg,"aenvhk") and stype=="Đồng Đội" then	
	if (me.GetMapTemplateId() == 24) or  (me.GetMapTemplateId() == 29) then	
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,7346,1,1"});
		return;
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,7346,1,1"});
		return;
	end
end	
	if  string.find(szMsg,"aemautk") and stype=="Đồng Đội" then	
		
			tbMember:LayRuongTK();
		
	end
	
	if  string.find(szMsg,"Anh em mở rương máu Tống Kim!!") and stype=="Đồng Đội" then	
		AutoAi:MoRuongThuocPL();
		return;
		else 
	end
	if  string.find(szMsg,"Anh em mở rương máu Phúc Lợi!!") and stype=="Đồng Đội" then	
		AutoAi:MoRuongThuocPL();
		return;
		
	end
	-------------TK-----------
	if  string.find(szMsg,"aevaomc") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
	Map.tbvCTTK:CTTK1Switch()
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
if  string.find(szMsg,"aevaoth") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
	Map.tbvCTTK:CTTK2Switch()
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	-------------------CTC--------------------
	if  (string.find(szMsg,"aedictc") or string.find(szMsg,"Anh em đi CTC!!")) and stype=="Đồng Đội" then	
		if (me.GetMapTemplateId() > 22) and  (me.GetMapTemplateId() < 30) then
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,7137,1"});
		else
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,7137,1"});		
		end	
	end
	
	if  (string.find(szMsg,"aethuongctc") or string.find(szMsg,"Anh em nhận thưởng CTC!!")) and stype=="Lân cận" then	
		if (me.GetMapTemplateId() > 22) and  (me.GetMapTemplateId() < 30) then
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,7137,2,4,1"});
		else
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,7137,2,4,1"});		
		end	
	end
	
	if  (string.find(szMsg,"aevaoctc") or string.find(szMsg,"Anh em vào thiết phù thành!!")) and stype=="Lân cận" then	
		if (me.GetMapTemplateId() > 1608) and  (me.GetMapTemplateId() < 1651) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,7136,1"});
		else
		me.Msg("<color=lightgreen>Bạn không đứng trong Đảo Anh Hùng");
		end	
	end
	
	if  (string.find(szMsg,"aeroictc") or string.find(szMsg,"Anh em rời khỏi thiết phù thành!!")) and stype=="Đồng Đội" then	
		if (me.GetMapTemplateId() > 1608) and  (me.GetMapTemplateId() < 1651) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3698,1"});
		else
		me.Msg("<color=yellow>Bạn không đứng trong Đảo Anh Hùng");
		end	
	end
	
	if  (string.find(szMsg,"aemauctc") or string.find(szMsg,"Anh em lấy máu CTC!!")) and stype=="Đồng Đội" then	
		Map.tbAutoMau:LayMau1Switch();
	end
	
	if  string.find(szMsg,"aetang2") and stype=="Đồng Đội" then	
		Map.tbvCTC:CTC1Switch();
	end
	
	if  string.find(szMsg,"aetang3") and stype=="Đồng Đội" then	
		Map.tbvCTC:CTC2Switch();
	end
	
	-------------------Khắc Di Môn------------
	if ( string.find(szMsg,"aeroikdm") or string.find(szMsg,"Anh em rời bản đồ khắc di môn nào !!")) and stype=="Đồng Đội" then	
		if (me.GetMapTemplateId() == 2148) or  (me.GetMapTemplateId() == 2150) then
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2597,2,2"});
		else
	me.Msg("<color=lightgreen>Bạn không đứng trong Hậu Doanh chiến trường Khắc Di Môn");	
		end	
	end
	
	if  string.find(szMsg,"aelbkdm") and stype=="Đồng Đội" then	
		
			--Map.AutoNvKDM:OnSwitch();
			Map.tbAutoMau:LayMau3Switch();
		
	end
	
	if  string.find(szMsg,"aenvkdm") and stype=="Đồng Đội" then	
		
			Map.AutoNvKDM:OnSwitch();
			--Map.tbAutoMau:LayMau3Switch();
		
	end
	if  string.find(szMsg,"aenvktl") and stype=="Đồng Đội" then	
		Map.tbKhongTuoc:Switch()
	end
	
	--------------thoát game----------
	if  string.find(szMsg,"aethoatgame") and stype=="Đồng Đội" then	
		
			Exit();
		
	end
	--------------- nhiệm vụ tầng lăng--------------
	if  string.find(szMsg,"aenvtl") and stype=="Đồng Đội" then	
		
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",1536,2444,1"});
	end
------LMPK---

if  string.find(szMsg,"aevaoham") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2711"});
				me.CallServerScript({"PlayerCmd", "EnterTreasure"});
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end

if string.find(szMsg,"Đi qua nào !!!") then--diem truyen tong
    local s=szMsg;
    self:OpenPanel();
    Timer:Register(Env.GAME_FPS*nChoseTime,self.Chose);
    end 




	------------mua mau--------------------------------------------
	if  string.find(szMsg,"aemuamau") and stype=="Đồng Đội" then	
		
			tbMember:MuaMau();
		
	end
	
	
	
	if  string.find(szMsg,"aemuathucan") and stype=="Đồng Đội" then	
		
			tbMember:MuaCai1();
		
	end
	---------------------------------------------
	if  string.find(szMsg,"aebuff") and stype=="Đồng Đội" then
	Map.tbAutoAsist:Asistswitch();
	Map.tbAutoAim:AutoFollowStart();
	end
	-------------------------------het---------------------------
	
	----------------------Thần Kí Thạch----------------------------
if  (string.find(szMsg,"aedamot") or string.find(szMsg,"Anh em đập đá 1 cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa1):State();
	end
if  (string.find(szMsg,"aedahai") or string.find(szMsg,"Anh em đập đá 2 cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa2):State()
	end	
if  (string.find(szMsg,"aedaba") or string.find(szMsg,"Anh em đập đá ba cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa3):State()
	end	
if ( string.find(szMsg,"aedabon") or string.find(szMsg,"Anh em đập đá 4 cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa4):State()
	end	
if ( string.find(szMsg,"aedanam") or string.find(szMsg,"Anh em đập đá 5 cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa5):State()
	end	
if  (string.find(szMsg,"aedasau") or string.find(szMsg,"Anh em đập đá 6 cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa6):State()
	end	
	------event trung thu---------------------------
	if  string.find(szMsg,"aenhanbot") and stype=="Đồng Đội" then	
		Ui.tbNhanBot:State();
	end	
	if  string.find(szMsg,"aenhanbanh") and stype=="Đồng Đội" then
		Map.tbvCTC:CTC3Switch();		
	end
	
---------------------
	if  string.find(szMsg,"Chúc các bạn chơi game vui vẻ!!") and stype=="Lân cận" then
		UiManager.OnOpen();	
	end
-------------------
	if  string.find(szMsg,"aevenha") and stype=="Đồng Đội" then
		--me.CallServerScript({"PlayerCmd", "EnterDeYuefang"});
		me.CallServerScript({"UseUnlimitedTrans", 6});
		--Map.Toolngt:OnSwitchDDP();
	end
	--- nvcm
	if  string.find(szMsg,"aenvcm") and stype=="Đồng Đội" then	
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",2261,11017,1"});
	end
	
	--- dot lua
	if  string.find(szMsg,"aedungdotlua") and stype=="Đồng Đội" then
		Ui.tbLogic.tbTimer:Close(nTimerIdDotLua);
		nTimerIdDotLua=0;
		me.CallServerScript({"ApplyAutoEventOnOff"});
		UiManager:CloseWindow(Ui.UI_AUTOEVENTBUT);
	end
	if  string.find(szMsg,"aedotlua") and stype=="Đồng Đội" then
		nTimerIdDotLua=Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1, self.DotLua, self);
	end
	if  string.find(szMsg,"aediham") and stype=="Đồng Đội" then
		Map.tbAutoDiHam:Start_Clock();
	end	
	
	--- nhan luong
	if  string.find(szMsg,"aenhanluong") and stype=="Đồng Đội" then	
		me.CallServerScript({"ApplyKinOpenSalary"});
		me.CallServerScript({"ApplyKinGetSalary"});
	end
	
	--- mo pet
	local AutoOpenPet_Setting = Ui:GetClass("AutoOpenPet");
	local tbSettingOpenPet = AutoOpenPet_Setting:Load(AutoOpenPet_Setting.DATA_KEY) or {};
	if  (string.find(szMsg,"aemopet1") or string.find(szMsg,"pet 1")) and stype=="Đồng Đội" then
		nLenh1 =tbSettingOpenPet.nLenh1 or 0;
		me.CallServerScript({ "PartnerCmd", "CallPartner", nLenh1});
	end	
	if   (string.find(szMsg,"aemopet2") or string.find(szMsg,"pet 2")) and stype=="Đồng Đội" then
		nLenh2 =tbSettingOpenPet.nLenh2 or 0;
		me.CallServerScript({ "PartnerCmd", "CallPartner", nLenh2});
	end	
	if   (string.find(szMsg,"aemopet3") or string.find(szMsg,"pet 3")) and stype=="Đồng Đội" then
		nLenh3 =tbSettingOpenPet.nLenh3 or 0;
		me.CallServerScript({ "PartnerCmd", "CallPartner", nLenh3});
	end
	if  string.find(szMsg,"aenhanda")  and stype=="Đồng Đội" then
		Map.Toolngt:OnSwitchMaiDa();
	end	
	if  string.find(szMsg,"aesuado")  and stype=="Đồng Đội" then
		Map.Toolngt:RepairAll();
		return 1
	end
	if  string.find(szMsg,"aemuakimte")  and stype=="Đồng Đội" then
		Map.Toolngt:OnSwitchMuaKimTe();
		
	end
	
	--- check skill
	
		if  (string.find(szMsg,"aecheckskill")) and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			Map.HoTroPKz:OnSwitch()
		else 
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	-------------Di chuyen Boss 95 -------------------------
	if  (string.find(szMsg,"ae95kim") or string.find(szMsg,"Anh em săn boss kim 95 nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossKim95):State1();
	end
	if  (string.find(szMsg,"ae95moc") or string.find(szMsg,"Anh em săn boss mộc 95 nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossMoc95):State1();
	end
	if  (string.find(szMsg,"ae95thuy") or string.find(szMsg,"Anh em săn boss thủy 95 nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossThuy95):State1();
	end
	if  (string.find(szMsg,"ae95hoa") or string.find(szMsg,"Anh em săn boss hỏa 95 nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossHoa95):State1();
	end
	if  (string.find(szMsg,"ae95tho") or string.find(szMsg,"Anh em săn boss thổ 95 nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossTho95):State1();
	end
	----------------------Di chuyen Boss long hồn -------------------------
	if  (string.find(szMsg,"aelh1") or string.find(szMsg,"Anh em săn boss diêm châu nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossDiemChau):State1();
	end
	if  (string.find(szMsg,"aelh2") or string.find(szMsg,"Anh em săn boss đông hạ nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossDongHa):State1();
	end
	if  (string.find(szMsg,"aelh3") or string.find(szMsg,"Anh em săn boss khắc di nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossKhacDi):State1();
	end
	
	if  (string.find(szMsg,"aelh4") or string.find(szMsg,"Anh em săn boss ngột lạt nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossNgotLat):State1();
	end
	----------------auto mc--------------
	
	if  string.find(szMsg,"aevaokth") and stype=="Đồng Đội" then
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1785,3626"});
	end
	if  string.find(szMsg,"aenvkth") and stype=="Đồng Đội" then
		Ui.tbKhongTuoc:State();
	end
	if  string.find(szMsg,"aekthlen") and stype=="Đồng Đội" then
		Map.KhongTuocTren:Switch();
	end
	if  string.find(szMsg,"aekthduoi") and stype=="Đồng Đội" then
		Map.KhongTuocDuoi:Switch();
	end
	--- auto rieng
	if string.find(szMsg,"aeanqnl") and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbQuyNguyenLenh):State();
	end

	if string.find(szMsg,"aeantnlq") and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbThienNien):State();
	end
end

function tbMember:DotLua()
	if UiManager:WindowVisible(Ui.UI_AUTOEVENTBUT) ~=1 then
		local LTVV =  tbMember.TimNPC_TEN("Lửa trại vui vẻ");
		if LTVV then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1 then
				AutoAi.SetTargetIndex(LTVV.nIndex)
			else	
				me.AnswerQestion(0);
			end	
		else
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",25,1627,3136"});
		end
	else
		Ui.tbLogic.tbTimer:Close(nTimerIdDotLua);
		nTimerIdDotLua=0;
	end	
end
--[[function tbMember:StarGoHomezz()
	nTimerIdGoHome = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1, self.GoHomez, self);
end

function tbMember:StopGoHomezz()
	
	Ui.tbLogic.tbTimer:Close(nTimerIdGoHome);
	nTimerIdGoHome=0;
	
end

function tbMember:GoHomez()
--	me.Msg(""..nGoHome.."");
	if nGoHome == 0 then
		local TTB =  tbMember.TimNPC_TEN("Tưởng Nhất Bình");
		if TTB then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1 then
				AutoAi.SetTargetIndex(TTB.nIndex)
			else
				local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
				for i, tbInfo in ipairs(tbAnswers) do
					if string.find(tbInfo, "Ta muốn rời khỏi chỗ này") then
						me.AnswerQestion(i - 1);
						--self:ShopGoHome();
						nGoHome=1;
						break
					
					end
				end	
			end	
		else
			me.CallServerScript({"PlayerCmd", "EnterDeYuefang"});
		end
	else
		if UiManager:WindowVisible(Ui.UI_SAYPANEL)==1 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			return
		end
		nGoHome=0;
		self:ShopGoHome();
		
	end
end
]]
function tbMember:OpenPanel()
local tbAroundNpc = KNpc.GetAroundNpcList(me, 200);
	for _, pNpc in ipairs(tbAroundNpc) do
		if pNpc.szName=="Điểm truyền tống" then
		AutoAi.SetTargetIndex(pNpc.nIndex)
		end
	end
	return 0;
end

function tbMember:Chose()
local nId = tbMember:GetAroundNpcId(4210)
	if nId then
		return
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and me.GetMapTemplateId() > 65500 then
		me.AnswerQestion(0);
		me.AnswerQestion(0);
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
return 0
end

function tbMember.TimNPC_TEN(name)
	local tbNpcList = KNpc.GetAroundNpcList(me,2000);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.szName == name then
			return pNpc
		end
	end
end



function tbMember:AutoTask()	
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		me.AnswerQestion(0);		
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
	elseif
		UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD);		
		uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept");
	end
end




function tbMember:Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
	   if not nFindLastIndex then
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
		break
	   end
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	   nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end



	local BDStart     = 0;
	local nBDTimerId = 0;
	local nBDTime    = 0.5;
	local nBDState   = 0;
	function tbMember:OnBDTimer()
		if (nBDState == 0) then
		return 0
		end
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
			for _, pNpc in ipairs(tbAroundNpc) do		
				if (pNpc.nTemplateId == 2503) then  	
				AutoAi.SetTargetIndex(pNpc.nIndex)
				me.AnswerQestion(0);
				me.AnswerQestion(0);
				break;
				elseif (pNpc.nTemplateId == 2506) then  	
				AutoAi.SetTargetIndex(pNpc.nIndex)
				me.AnswerQestion(0);
				me.AnswerQestion(0);
				break;
			
				end
			
			
			end
			if  (me.GetMapTemplateId() > 185) or (me.GetMapTemplateId() < 182) then
				tbMember:AutoBD();
				AutoAi.SetTargetIndex(0)
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				end
			end
	end	

function AutoAi:MoRuongThuocTK()
	
	local tbSetting = Map.tbTeamControl:Load(Map.tbTeamControl.DATA_KEY) or {};
	local nFreeNum = tonumber (tbSetting.nFreeBag) or 2
	local nPlanNum = tonumber (tbSetting.nNeedB) or 100; 
	local nCountFree = me.CountFreeBagCell();
	local nDangCo = (me.GetItemCountInBags(17,6,1,2) + me.GetItemCountInBags(17,6,3,2)) ;	
	if ((nCountFree - nFreeNum) > (nPlanNum - nDangCo)) then
		nPlanNum = (nPlanNum - nDangCo);
		else
		nPlanNum = (nCountFree - nFreeNum) ;
	end	
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật Mở rương thuốc TK<color>");
				local tbFind = me.FindItemInBags(18,1,59,1)[1] or me.FindItemInBags(18,1,62,1)[1] or me.FindItemInBags(18,1,56,1)[1] or me.FindItemInBags(18,1,61,1)[1];
	if not tbFind then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>Hành trang không có rương thuốc TK<color>");
	else
		local pItem = tbFind.pItem;
		local g = pItem.nGenre;
		local d = pItem.nDetail;
		local p = pItem.nParticular;
		local l = pItem.nLevel;
		AutoAi:StartMoRuongThuoc(g,d,p,l,nPlanNum);
	end
end

function AutoAi:MoRuongThuocTDC1()
	 
	local tbSetting = Map.tbTeamControl:Load(Map.tbTeamControl.DATA_KEY) or {};
	local nFreeNum = tonumber (tbSetting.nFreeBag) or 2
	local nPlanNum = tonumber (tbSetting.nNeedB) or 100; 
	local nCountFree = me.CountFreeBagCell();
	local nDangCo = me.GetItemCountInBags(17,8,1,3);	
	if ((nCountFree - nFreeNum) > (nPlanNum - nDangCo)) then
		nPlanNum = (nPlanNum - nDangCo);
		else
		nPlanNum = (nCountFree - nFreeNum) ;
	end	
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật Mở rương thuốc Tiêu Dao Cốc<color>");
				local tbFind = me.FindItemInBags(18,1,352,1)[1] or me.FindItemInBags(18,1,352,2)[1] or me.FindItemInBags(18,1,352,3)[1]
							or me.FindItemInBags(18,1,354,1)[1] or me.FindItemInBags(18,1,354,2)[1] or me.FindItemInBags(18,1,354,3)[1]
							or me.FindItemInBags(18,1,59,1)[1] or me.FindItemInBags(18,1,353,2)[1] or me.FindItemInBags(18,1,353,3)[1];
	if not tbFind then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>Hành trang không có rương thuốc Tiêu Dao Cốc<color>");
	else
		local pItem = tbFind.pItem;
		local g = pItem.nGenre;
		local d = pItem.nDetail;
		local p = pItem.nParticular;
		local l = pItem.nLevel;
		AutoAi:StartMoRuongThuoc(g,d,p,l,nPlanNum);
	end
end

function AutoAi:MoRuongThuocTDLT1()
	
	local tbSetting = Map.tbTeamControl:Load(Map.tbTeamControl.DATA_KEY) or {};
	local nFreeNum = tonumber (tbSetting.nFreeBag) or 2
	local nPlanNum = tonumber (tbSetting.nNeedB) or 100; 
	local nCountFree = me.CountFreeBagCell();
	local nDangCo = me.GetItemCountInBags(17,7,1,2);	
	if ((nCountFree - nFreeNum) > (nPlanNum - nDangCo)) then
		nPlanNum = (nPlanNum - nDangCo);
		else
		nPlanNum = (nCountFree - nFreeNum) ;
	end	
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật Mở rương thuốc TDLT<color>");
				local tbFind = me.FindItemInBags(18,1,273,3)[1] or me.FindItemInBags(18,1,273,2)[1] or me.FindItemInBags(18,1,273,1)[1] or me.FindItemInBags(18,1,20111,1)[1] or me.FindItemInBags(18,1,481,1)[1];
	if not tbFind then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>Hành trang không có rương thuốc TDLT/CTC<color>");
	else
		local pItem = tbFind.pItem;
		local g = pItem.nGenre;
		local d = pItem.nDetail;
		local p = pItem.nParticular;
		local l = pItem.nLevel;
		AutoAi:StartMoRuongThuoc(g,d,p,l,nPlanNum);
	end
end

function AutoAi:MoRuongThuocPL()
	local tbSetting = Map.tbTeamControl:Load(Map.tbTeamControl.DATA_KEY) or {};
	local nFreeNum = tonumber (tbSetting.nFreeBag) or 2
	local nPlanNum = tonumber (tbSetting.nNeedB) or 100; 
	local nCountFree = me.CountFreeBagCell(); 
	local nDangCo = (me.GetItemCountInBags(17,13,1,4) + me.GetItemCountInBags(17,13,3,4)) ;	
	if ((nCountFree - nFreeNum) > (nPlanNum - nDangCo)) then
		nPlanNum = (nPlanNum - nDangCo);
		else
		nPlanNum = (nCountFree - nFreeNum) ;
	end	
	local tbFindp	= {1783, 1784, 1785, 20111, 241, 242};
	local tbFindl	= {1, 2, 3, 4, 5};
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật Mở rương thuốc Phúc lợi<color>");
	for _, nFindp in ipairs(tbFindp) do
		for _, nFindl in ipairs(tbFindl) do
			local tbFind = me.FindItemInBags(18,1,nFindp,nFindl)[1];
			if tbFind then
				local pItem = tbFind.pItem;
				local g = pItem.nGenre;
				local d = pItem.nDetail;
				local p = pItem.nParticular;
				local l = pItem.nLevel;
				AutoAi:StartMoRuongThuoc(g,d,p,l,nPlanNum);
			end
		end
	end
end


function AutoAi:TraRuongThuocPL()
	local nPlanNum = (me.GetItemCountInBags(17,13,1,4) + me.GetItemCountInBags(17,13,3,4)) ; 
	local tbFindp	= {1783, 1784, 1785, 241, 242};
	local tbFindl	= {1, 2, 3, 4, 5};
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật trả rương thuốc Phúc lợi<color>");
	for _, nFindp in ipairs(tbFindp) do
		for _, nFindl in ipairs(tbFindl) do
			local tbFind = me.FindItemInBags(18,1,nFindp,nFindl)[1];
			if tbFind then
				local pItem = tbFind.pItem;
				local g = pItem.nGenre;
				local d = pItem.nDetail;
				local p = pItem.nParticular;
				local l = pItem.nLevel;
				AutoAi:StartTraRuongThuoc(g,d,p,l,nPlanNum);
			end
		end
	end
end
	---------------------------------------------bao danh TK----------------------------------------
	function tbMember:AutoBD()
	if nBDState == 0 and (me.GetMapTemplateId() > 181) and (me.GetMapTemplateId() < 186) then 
		nBDState = 1; 
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật chức năng bao danh TK");
		nBDTimerId = Timer:Register(Env.GAME_FPS * nBDTime, self.OnBDTimer, self);
	else
		nBDState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt chức năng bao danh TK");
		Timer:Close(nBDTimerId);
	end
end

function tbMember:AutoBDStart()
	if self.nBDState == 0 then
		tbMember:AutoBD();
	end
end

function tbMember:AutoBDStop()
	if self.nBDState == 1 then
		tbMember:AutoBD();
	end
end
tbMember.GetAroundNpcId = function(self,nTempId)
	local tbAroundNpc	= KNpc.GetAroundNpcList(me,1000);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then
			return pNpc.nIndex
		end
	end
	return
end
-------------------------------


tbMember.ThuongTD=function(self)
	self.nTimerRegisterId	= Ui.tbLogic.tbTimer:Register(20, 1, self.OnTimer_ThuongTD, self);
end

tbMember.OnTimer_ThuongTD = function(self)
	local nId =  tbMember:GetAroundNpcId(3406)
				
	if nId then
		Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
		tbMember:ThuongTD1()
		return 0
	
	else
	tbMember:fnfindNpc(3406,"Quan Lãnh Thổ");
	return 0
	end
end

tbMember.ThuongTD1=function(self)
	
	local nId =  tbMember:GetAroundNpcId(3406) 		
	
	if nId then
		AutoAi.SetTargetIndex(nId);
		
			local function CloseWindow2()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			return 0
			end
		local function fnCloseSay()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				
							me.AnswerQestion(1);
							me.AnswerQestion(0);
							me.AnswerQestion(0);
							--me.AnswerQestion(0);
							--me.AnswerQestion(0);
							--me.AnswerQestion(0);me.AnswerQestion(0);
							--me.AnswerQestion(0);
							--me.AnswerQestion(0);
							--me.AnswerQestion(0);
				
				Ui.tbLogic.tbTimer:Register(20, CloseWindow2);
			return 0;
			end
		end
		Ui.tbLogic.tbTimer:Register(36, fnCloseSay);
	end
end

------------------------------------
tbMember.LayRuongTK=function(self)
	self.nTimerRegisterId	= Ui.tbLogic.tbTimer:Register(20, 1, self.OnTimer_LayRTK, self);
end

tbMember.OnTimer_LayRTK = function(self)
	local nId =  tbMember:GetAroundNpcId(2613) or tbMember:GetAroundNpcId(2614)
				
	if nId then
		Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
		tbMember:LayRuongTK1()
		return 0
	elseif me.GetMapTemplateId() == 182 then
					if me.nFaction ~= 9 then
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",182,2504,6,1"});
					return 0
					else
					Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",182,2504,6,3"});
					return 0
					end
	elseif me.GetMapTemplateId() == 185 then
					if me.nFaction ~= 9 then
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",185,2507,6,1"});
					return 0
					else
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",185,2507,6,3"});
					return 0
						end
	else
	me.Msg("<color=pink>không tìm thấy quan quân nhu tống kim");
	return 0
	end
end




tbMember.LayRuongTK1=function(self)
	
	local nId =  tbMember:GetAroundNpcId(2613) or tbMember:GetAroundNpcId(2614)
	local cId = 0
		if me.nFaction == 9 then
		cId = 2
		end
	
	if nId then
		AutoAi.SetTargetIndex(nId);
		
			local function CloseWindow2()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			return 0
			end
		local function fnCloseSay()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				
							me.AnswerQestion(5);
							me.AnswerQestion(cId);
					
							
					
				Ui.tbLogic.tbTimer:Register(15, CloseWindow2);
			return 0;
			end
		end
		Ui.tbLogic.tbTimer:Register(36, fnCloseSay);
	end
end
----------------------------------------------------------------

tbMember.MuaMau=function(self)
	self.nTimerRegisterId	= Ui.tbLogic.tbTimer:Register(20, 1, self.OnTimer_Mau, self);
end

tbMember.OnTimer_Mau = function(self)
		local nId = tbMember:GetAroundNpcId(3564) or tbMember:GetAroundNpcId(2613) or tbMember:GetAroundNpcId(2614)
				or tbMember:GetAroundNpcId(7373) or tbMember:GetAroundNpcId(2443) or tbMember:GetAroundNpcId(2447) or tbMember:GetAroundNpcId(10036)
				or tbMember:GetAroundNpcId(9674) or tbMember:GetAroundNpcId(3230)
		if nId then
		Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
		tbMember:MuaMau1();
		return 0
	else
		Map.tbMember:fnfindNpc(3564,"Trương Trảm Kinh");
		return
	end
end


function tbMember:MuaMau1()
			local nBac
			local uId = 680
			if me.nFaction == 9 then      --武当 
			uId = 690;  -- 690 五花玉露丸
			end
			local nHPLvId
			local tbSetting = Map.tbTeamControl:Load(Map.tbTeamControl.DATA_KEY) or {};
			local nFreeNum = tonumber (tbSetting.nFreeBag) or 2
			local nCBuyHP = tonumber (tbSetting.nNeedB) or 50
			local nCountFree = me.CountFreeBagCell();	
			local nBacE = 0;			
			local nId = tbMember:GetAroundNpcId(3564) or tbMember:GetAroundNpcId(2613) or tbMember:GetAroundNpcId(2614)
				or tbMember:GetAroundNpcId(7373) or tbMember:GetAroundNpcId(2443) or tbMember:GetAroundNpcId(2447) or tbMember:GetAroundNpcId(10036)
				or tbMember:GetAroundNpcId(9674) or tbMember:GetAroundNpcId(3230)
				if (nCountFree > nFreeNum) then
					if nId   then
						AutoAi.SetTargetIndex(nId);	
						local function fnbuy()
							local nCountHP = (me.GetItemCountInBags(17,1,1,5) + me.GetItemCountInBags(17,3,1,5));
							if nCountHP < nCBuyHP then
								if ((nCountFree - nFreeNum) > (nCBuyHP - nCountHP)) then
									local bOK, szMsg = me.ShopBuyItem(uId, nCBuyHP - nCountHP);
								else
									local bOK, szMsg = me.ShopBuyItem(uId, nCountFree - nFreeNum);
								end
							end
							UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
							if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
							UiManager:CloseWindow(Ui.UI_SHOP);
							end
							
						return 0
						end
						local function CloseWindow3()
							if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
							UiManager:CloseWindow(Ui.UI_SAYPANEL);
							end
						return 0
						end
						local function fnCloseSay3()
							if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
								if (me.GetMapTemplateId() > 187) and (me.GetMapTemplateId() < 196) 
								or (me.GetMapTemplateId() > 262) and (me.GetMapTemplateId() < 272)
								or	(me.GetMapTemplateId() > 289) and (me.GetMapTemplateId() < 298)
								or (me.GetMapTemplateId() > 1634) and (me.GetMapTemplateId() < 1644)
								or (me.GetMapTemplateId() > 19999) and (me.GetMapTemplateId() < 20018)
								then
							
								me.AnswerQestion(1);
								else
								me.AnswerQestion(0);
								end
							
								Ui.tbLogic.tbTimer:Register(15, CloseWindow3);
								Ui.tbLogic.tbTimer:Register(40, fnbuy);
								return 0
							end																			
						end
					Ui.tbLogic.tbTimer:Register(36, fnCloseSay3);
					end
				else 
				me.Msg("<color=pink>Đã có đủ thuốc ,ko cần mua ");
				end
end

-------------------------thức ăn-------------------
tbMember.MuaCai1=function(self)
	self.nTimerRegisterId	= Ui.tbLogic.tbTimer:Register(20, 1, self.OnTimer_Cai, self);
end

tbMember.OnTimer_Cai = function(self)
	local nId = tbMember:GetAroundNpcId(3566) or tbMember:GetAroundNpcId(2613) or tbMember:GetAroundNpcId(2614)
				or tbMember:GetAroundNpcId(7373) or tbMember:GetAroundNpcId(2443) or tbMember:GetAroundNpcId(2447) or tbMember:GetAroundNpcId(10036)
				or tbMember:GetAroundNpcId(9674) or tbMember:GetAroundNpcId(3230)
	if nId then
		Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
		tbMember:MuaCai()
		return 0
	else
	tbMember:fnfindNpc(3566,"Đại lão Bạch");
		return 0;
	end
end




tbMember.MuaCai=function(self)
	print("Bắt đầu mua thức ăn")
	local nId = tbMember:GetAroundNpcId(3566) or tbMember:GetAroundNpcId(2613) or tbMember:GetAroundNpcId(2614)
				or tbMember:GetAroundNpcId(7373) or tbMember:GetAroundNpcId(2443) or tbMember:GetAroundNpcId(2447) or tbMember:GetAroundNpcId(10036)
				or tbMember:GetAroundNpcId(9674) or tbMember:GetAroundNpcId(3230)
	local nCBuyCai = 3
	if nId then
		AutoAi.SetTargetIndex(nId);
		local function fnMaiCai()
		local nCaiLevel,nCaiID
                                if me.nLevel<30 then
									nCaiLevel=1
                                    nCaiID = 821
								end
								if (me.nLevel> 29) and (me.nLevel<50) then
								nCaiLevel=2
                                  nCaiID = 822
								end
								if (me.nLevel> 49) and (me.nLevel<70) then
								nCaiLevel=3
                                 nCaiID = 823
								end
								if (me.nLevel>69) and (me.nLevel < 90) then
								nCaiLevel =4
								nCaiID = 824
								end
								if me.nLevel >= 90 then
								nCaiLevel = 5
								nCaiID = 825
								end
				local nCount_Cai = me.GetItemCountInBags(19,3,1,nCaiLevel);
				if nCount_Cai < nCBuyCai then
				local pItem = KItem.GetItemObj(825);
				local bOK, szMsg = me.ShopBuyItem(nCaiID, nCBuyCai -nCount_Cai);
				end
				UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
				if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
				UiManager:CloseWindow(Ui.UI_SHOP);
				end
		return 0
		end
			local function CloseWindow2()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			return 0
			end
		local function fnCloseSay()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				if (me.GetMapTemplateId() > 187) and (me.GetMapTemplateId() < 196) 
							or (me.GetMapTemplateId() > 262) and (me.GetMapTemplateId() < 272)
							or	(me.GetMapTemplateId() > 289) and (me.GetMapTemplateId() < 298)
							or (me.GetMapTemplateId() > 1634) and (me.GetMapTemplateId() < 1644)
							or (me.GetMapTemplateId() > 19999) and (me.GetMapTemplateId() < 20018)
							then
							me.AnswerQestion(4);
					elseif 	(me.GetMapTemplateId() == 182) or (me.GetMapTemplateId() == 185)	then
							me.AnswerQestion(3);
					elseif 	(me.GetMapTemplateId() == 1536) or (me.GetMapTemplateId() == 1538) then
							me.AnswerQestion(1);
					else 
						me.AnswerQestion(0);
				end	
				Ui.tbLogic.tbTimer:Register(15, CloseWindow2);
				Ui.tbLogic.tbTimer:Register(40, fnMaiCai);
			return 0;
			end
		end
		Ui.tbLogic.tbTimer:Register(36, fnCloseSay);
	end
end

tbMember.GetAroundNpcId = function(self,nTempId)
	local tbAroundNpc	= KNpc.GetAroundNpcList(me,1000);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then
			return pNpc.nIndex
		end
	end
	return
end
tbMember.fnfindNpc = function(self, nNpcId, szName)
	local nMyMapId	= me.GetMapTemplateId();
	local nTargetMapId;
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		nTargetMapId = nMyMapId;
	elseif nCityId then
		nTargetMapId = nCityId
	else
		nTargetMapId = 5
	end
	if (nMyMapId == 556 or nMyMapId == 558 or nMyMapId == 559) and (nNpcId == 3566 or nNpcId == 3564) then 
		nTargetMapId = nMyMapId;
	end

	local nX1, nY1;
	nX1, nY1 = KNpc.ClientGetNpcPos(nTargetMapId, nNpcId);


	local tbPosInfo ={}
	tbPosInfo.szType = "pos"
	tbPosInfo.szLink = szName..","..nTargetMapId..","..nX1..","..nY1
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) or nSetPhu == 0 then	
		Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nTargetMapId,nX=nX1,nY=nY1})
	else
		local tbFind = me.FindItemInBags(unpack({18,1,nSetHTPId,1}));
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			return;
		end
		self.fnfindNpc(nNpcId, szName);
	end	
end

local tCmd={ "Map.tbMember:GuessSwitch()", "GuessSwitch", "", "Alt+M", "Alt+M", "GuessSwitch"};
       AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
       UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	
local tCmd={ "Map.tbMember:Guess2Switch()", "Guess2Switch", "", "Alt+N", "Alt+N", "Guess2Switch"};
       AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
       UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	   

tbMember:Init();