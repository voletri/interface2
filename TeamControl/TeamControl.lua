----------------------chỉnh sửa bởi Mr.DUY---------------------
Ui.UI_TeamControl = "UI_TeamControl";
local uiTeamControl = Ui.tbWnd[Ui.UI_TeamControl] or {};
uiTeamControl.UIGROUP = Ui.UI_TeamControl;
Ui.tbWnd[Ui.UI_TeamControl] = uiTeamControl;
Map.tbTeamControl		= uiTeamControl;
local self = uiTeamControl;



local eggStart     = 0;
local nPickState   = 0;
local nPickTimerId = 0;
local nPickTime    = 0.3; 
------------------------He Thong-------------------------
local BTNreload								= "Btnreload"
local BTNChatFollow							= "BtnChatFollow"
local BTNChatStartBuff						= "BtnChatStartBuff"
local BTNChatStartPK						= "BtnChatStartPK"
local BTNChatStopPK							= "BtnChatStopPK"
local BTNChatTeam							= "BtnChatTeam"
-----------------------NLHN-----------------------------
local BTNChatNLHN							= "BtnChatNLHN"
-----------------------HLVM-----------------------------
local BTNChatGoHLVM							= "BtnChatGoHLVM"
------------------------BMS-------------------------------
local BTNChatGoBMS							= "BtnChatGoBMS"
------------------------HPNS--------------------------------------
local BTNChatGoHSPN							= "BtnChatGoHSPN"

------------------------Khác---------------------------------------
local BTNChatGoTDC							= "BtnChatGoTDC"
local BTNChatRTDC							= "BtnChatRTDC"
local BTNChatMTDC							= "BtnChatMTDC"
local BTNChatTRAM							= "BtnChatTRAM"
local BTNChatCTC							= "BtnChatCTC"
local BTNChatThanKyThach					= "BtnChatThanKyThach"
local BTNChatThanSa							= "BtnChatThanSa"
local BTNChatBHDserver						= "BtnChatBHDserver"
local BTNChatGhepHT							= "BtnChatGhepHT"
local BTNChatPhoThuyLoi1					= "BtnChatPhoThuyLoi1"
local BTNChatPhoThuyLoi2					= "BtnChatPhoThuyLoi2"
local BTNChatPhoThuyLoi3					= "BtnChatPhoThuyLoi3"
local BTNChatDDP							= "BtnChatDDP"
local BTNChatBVD							= "BtnChatBVD"
local BTNChatRTDLT							= "BtnChatRTDLT"
local BTNChatLuongGT						= "BtnChatLuongGT"
local BTNChatStopTDLT						= "BtnChatStopTDLT"
local BTNChatMauTDLT						= "BtnChatMauTDLT"
local BTNChatThuongTDLT						= "BtnChatThuongTDLT"
local BTNChatLakTDLT						= "BtnChatLakTDLT"
local BTNChatBuLakTDLT						= "BtnChatBuLakTDLT"
local BTNChatBuLak7							= "BtnChatBuLak7"
local BTNChatKDM							= "BtnChatKDM"
local BTNChatLBTQL							= "BtnChatLBTQL"
local BTNChatNVTQL							= "BtnChatNVTQL"
local BTNChatVaoTQL							= "BtnChatVaoTQL"
local BTNChatRoiTQL							= "BtnChatRoiTQL"
local BTNChatRoiLauLan						= "BtnChatRoiLauLan"
local BTNChatCKP							= "BtnChatCKP"
local BTNChatNangDong						= "BtnChatNangDong"
------------------------TongKim-------------------------------------
local BTNChatVaoTH							= "BtnChatVaoTH" --tay ha
local BTNChatVaoMC							= "BtnChatVaoMC"  -- mong co
local BTNChatHD								= "BtnChatHD"
local BTNChatLMPK							= "BtnChatLMPK"
local BTNChatVaoLMPK						= "BtnChatVaoLMPK"
local BTNCHATMAUTK							= "BtnCHATMAUTK"
local BTNCHATRuongTK						= "BtnCHATRUONGTK"
local BTNCHATNVHK							= "BtnCHATNVHK"
local BTNChatBoss							= "BtnChatBoss"
local BTNCHATMUAMAU							= "BtnCHATMUAMAU"
local BTNCHATCAI							= "BtnChatCai"
local BTNChatVaoGiaToc						= "BtnChatVaoGiaToc"
local BTNChatRaGiaToc						= "BtnChatRaGiaToc"
local BTNChatDongTienCo						= "BtnChatDongTienCo"
local BTNChatVaoLanhDia						= "BtnChatVaoLanhDia"
local BTNChatLoThong						= "BtnChatLoThong"
local BTNChatRacTDC							= "BtnChatRacTDC"
-----------------------het-----------------------------------------

self.BTN_SAVE		= "BtnSave";
self.EDT_FREEBAG	= "EdtFreeBag";
self.EDT_NEEDB	= "EdtNeedB";
self.DATA_KEY	= "TeamControlSetting";
self.tbSetting	= {};
self.ChatCTC =
{ 
	{" Đi CTC "},
	{" Vào thành "},
	{" Rời thành "},
	{" Nhận thưởng "},
	{" Lấy máu  "},
	{" Lên tầng 2"},
	{" Lên tầng 3"},
};

self.ChatKDM = 
{
	{" Nhận Quân Lệnh "},
	{" Làm nhiệm vụ "},
	{" Rời khỏi "},
};

self.ChatThanKyThach = 
{
	{" Đập đá 1 cạnh "},
	{" Đập đá 2 cạnh "},
	{" Đập đá 3 cạnh "},
	{" Đập đá 4 cạnh "},
	{" Đập đá 5 cạnh "},
	{" Đập đá 6 cạnh "},
	{" Nhận Đồ mài đá "},
};

self.ChatNLHN = 
{
	{" Vào P.bản "},
	{" Rời khỏi "},
	{" Bắt ngựa "},
	{" Tế Tự Đại "},
	{" Trả lời "},
};
-----------------------

local tbMsgInfo = Ui.tbLogic.tbMsgInfo;

Ui:RegisterNewUiWindow("UI_TeamControl", "TeamControl", {"a", 580, 450}, {"b", 694, 582}, {"c", 855, 645});

function uiTeamControl:Init()

end

function uiTeamControl:OnButtonClick(szWnd)
	if (szWnd == BTNreload) then
		self.ScrReload();
		self:LoadSetting();	
	elseif (szWnd == BTNChatFollow) then
		uiTeamControl:ChatFollow();	
	elseif (szWnd == BTNChatStartBuff) then
		uiTeamControl:ChatStartBuff();
	elseif (szWnd == BTNChatStartPK) then
		uiTeamControl:ChatStartPK();
	elseif (szWnd == BTNChatStopPK) then
		uiTeamControl:ChatStopPK();
	elseif (szWnd == BTNChatTeam) then
		uiTeamControl:ChatTeam();	
	-------------------NLHN-----------------
	elseif (szWnd == BTNChatNLHN) then
		--uiTeamControl:ChatGoNLHN();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		5,
		0,
		self.ChatNLHN[1][1],
		1,
		self.ChatNLHN[2][1],
		2,
		self.ChatNLHN[3][1],
		3,
		self.ChatNLHN[4][1],
		4,
		self.ChatNLHN[5][1],
		5
		);	
	---------------------HLVM------------------		
	elseif (szWnd == BTNChatGoHLVM) then
		uiTeamControl:ChatGoHLVM();
	------------------BMS------------------
	elseif (szWnd == BTNChatGoBMS) then
		uiTeamControl:ChatGoBMS();
	------------------HSPN-----------------
	elseif (szWnd == BTNChatGoHSPN) then
		uiTeamControl:ChatGoHSPN();
			---------------------add-----
	elseif (szWnd == BTNCHATCAI) then
		uiTeamControl:ChatCai();
--------------------Khác----------------------------
	elseif (szWnd == BTNChatGoTDC) then
		uiTeamControl:ChatGoTDC();
	elseif (szWnd == BTNChatRTDC) then
		uiTeamControl:ChatRTDC();
	elseif (szWnd == BTNChatMTDC) then
		uiTeamControl:ChatMTDC();
	elseif (szWnd == BTNChatBHDserver) then
		uiTeamControl:ChatBHDserver();
	elseif (szWnd == BTNChatGhepHT) then
		uiTeamControl:ChatGhepHT();
	elseif (szWnd == BTNChatBVD) then
		uiTeamControl:ChatBVD();
	elseif (szWnd == BTNChatRacTDC) then
		uiTeamControl:ChatRacTDC();	
	elseif (szWnd == BTNChatPhoThuyLoi1) then
		uiTeamControl:ChatPhoThuyLoi1();
	elseif (szWnd == BTNChatPhoThuyLoi2) then
		uiTeamControl:ChatPhoThuyLoi2();
	elseif (szWnd == BTNChatPhoThuyLoi3) then
		uiTeamControl:ChatPhoThuyLoi3();
	elseif (szWnd == BTNChatVaoGiaToc) then
		uiTeamControl:ChatVaoGiaToc();
	elseif (szWnd == BTNChatRaGiaToc) then
		uiTeamControl:ChatRaGiaToc();	
	elseif (szWnd == BTNChatDongTienCo) then
		uiTeamControl:ChatDongTienCo();
	elseif (szWnd == BTNChatVaoLanhDia) then
		uiTeamControl:ChatVaoLanhDia();	
	elseif (szWnd == BTNChatLoThong) then
		uiTeamControl:ChatLoThong();		
	elseif (szWnd == BTNChatRTDLT) then
		uiTeamControl:ChatRTDLT();
	elseif (szWnd == BTNChatLuongGT) then
		uiTeamControl:ChatLuongGT();
	elseif (szWnd == BTNChatStopTDLT) then
		uiTeamControl:ChatStopTDLT();
	elseif (szWnd == BTNChatThuongTDLT) then
		uiTeamControl:ChatThuongTDLT();
	elseif (szWnd == BTNChatMauTDLT) then
		uiTeamControl:ChatMauTDLT();
	elseif (szWnd == BTNChatLakTDLT) then
		uiTeamControl:ChatLakTDLT();	
	elseif (szWnd == BTNChatBuLakTDLT) then
		uiTeamControl:ChatBuLakTDLT();
	elseif (szWnd == BTNChatBuLak7) then
		uiTeamControl:ChatBuLak7();
	elseif (szWnd == BTNChatKDM) then
		--uiTeamControl:ChatKDM();	
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		3,
		0,
		self.ChatKDM[1][1],
		1,
		self.ChatKDM[2][1],
		2,
		self.ChatKDM[3][1],
		3
		);	 
	elseif (szWnd == BTNChatTRAM) then
		uiTeamControl:ChatTRAM();
	elseif (szWnd == BTNChatCTC) then	
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.ChatCTC[1][1],
		1,
		self.ChatCTC[2][1],
		2,
		self.ChatCTC[3][1],
		3,
		self.ChatCTC[4][1],
		4,
		self.ChatCTC[5][1],
		5,
		self.ChatCTC[6][1],
		6,
		self.ChatCTC[7][1],
		7
		);	
	elseif (szWnd == BTNChatThanKyThach) then	
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.ChatThanKyThach[1][1],
		1,
		self.ChatThanKyThach[2][1],
		2,
		self.ChatThanKyThach[3][1],
		3,
		self.ChatThanKyThach[4][1],
		4,
		self.ChatThanKyThach[5][1],
		5,
		self.ChatThanKyThach[6][1],
		6,
		self.ChatThanKyThach[7][1],
		7
		);
------------------------TongKim-----------------------
	elseif (szWnd == BTNChatLBTQL) then
		uiTeamControl:ChatLBTQL();
	elseif (szWnd == BTNChatNVTQL) then
		uiTeamControl:ChatNVTQL();
	elseif (szWnd == BTNChatVaoTQL) then
		uiTeamControl:ChatVaoTQL();
	elseif (szWnd == BTNChatRoiTQL) then
		uiTeamControl:ChatRoiTQL();
	elseif (szWnd == BTNChatRoiLauLan) then
		uiTeamControl:ChatRoiLauLan();
	elseif (szWnd == BTNChatCKP) then
		uiTeamControl:ChatCKP();
	elseif (szWnd == BTNChatNangDong) then
		uiTeamControl:ChatNangDong();
	elseif (szWnd == BTNChatThanSa) then
		uiTeamControl:ChatThanSa();	
	elseif (szWnd == BTNChatLMPK) then
		uiTeamControl:ChatLMPK();
	elseif (szWnd == BTNChatVaoLMPK) then
		uiTeamControl:ChatVaoLMPK();	
	elseif (szWnd == BTNChatVaoMC) then
		uiTeamControl:ChatVaoMC();
	elseif (szWnd == BTNChatVaoTH) then
		uiTeamControl:ChatVaoTH();
	elseif (szWnd == BTNCHATMAUTK) then
		uiTeamControl:ChatMAUTK();
	elseif (szWnd == BTNCHATRuongTK) then
		uiTeamControl:ChatRuongTK() ;
	elseif (szWnd == BTNCHATNVHK) then
		uiTeamControl:ChatNVHK() ;
	elseif (szWnd == BTNChatBoss) then
		uiTeamControl:ChatBoss();	
	elseif (szWnd == BTNCHATMUAMAU) then
		uiTeamControl:ChatMUAMAU() ;
	elseif (szWnd == self.BTN_SAVE) then	
		self:SaveData();	
-----------------------het-------------------------------------		
end
end

-----------popup tra mau--------------------

uiTeamControl.OnMenuItemSelected=function(self,szWnd, nItemId, nParam)
	if szWnd == BTNChatCTC then
			if nItemId==1 then
		SendChannelMsg("Team", "Anh em đi CTC!!");
			elseif nItemId==2 then
        SendChannelMsg("NearBy", "Anh em vào thiết phù thành!!");	
			elseif nItemId==3 then
       	SendChannelMsg("Team", "Anh em rời khỏi thiết phù thành!!");		
			elseif nItemId==4 then
       	SendChannelMsg("NearBy", "Anh em nhận thưởng CTC!!");
			elseif nItemId==5 then
       	SendChannelMsg("Team", "Anh em lấy máu CTC!!");
			elseif nItemId==6 then
       	SendChannelMsg("Team", "Anh em Lên tầng hai nào!!");
			elseif nItemId==7 then
       	SendChannelMsg("Team", "Anh em Lên tầng ba nào!!");
		 	end
	elseif szWnd == BTNChatKDM then
			if nItemId==1 then
		SendChannelMsg("Team", "Anh em nhận Quân Lệnh nào!!");
			elseif nItemId==2 then
        SendChannelMsg("Team", "Anh em làm nhiệm vụ Khắc Di Môn nào!!");	
			elseif nItemId==3 then
       	SendChannelMsg("Team", "Anh em rời bản đồ khắc di môn nào !!");		
			end
	elseif szWnd == BTNChatThanKyThach then
			if nItemId==1 then
		SendChannelMsg("Team", "Anh em đập đá 1 cạnh!!");
			elseif nItemId==2 then
        SendChannelMsg("Team", "Anh em đập đá 2 cạnh!!");	
			elseif nItemId==3 then
       	SendChannelMsg("Team", "Anh em đập đá ba cạnh!!");		
			elseif nItemId==4 then
       	SendChannelMsg("Team", "Anh em đập đá 4 cạnh!!");
			elseif nItemId==5 then
       	SendChannelMsg("Team", "Anh em đập đá 5 cạnh!!");
			elseif nItemId==6 then
       	SendChannelMsg("Team", "Anh em đập đá 6 cạnh!!");
			elseif nItemId==7 then
       	SendChannelMsg("Team", "Anh em Nhận đồ mài đá!!");
		 	end
	elseif szWnd == BTNChatNLHN then
			if nItemId==1 then
		SendChannelMsg("Team", "Anh em vào Ngạc Luân Hà Nguyên nào!!");
			elseif nItemId==2 then
        SendChannelMsg("Team", "Anh em rời khỏi Ngạc Luân Hà Nguyên nào!!");
			elseif nItemId==3 then
        SendChannelMsg("Team", "Anh em bắt ngựa nào!!");
			elseif nItemId==4 then
        SendChannelMsg("Team", "Anh em đến Tế Tự Đài nào!!");
			elseif nItemId==5 then
        SendChannelMsg("Team", "Anh em trả bài nào!!");
			end
	end  
end	 
--------------------------add-------------------------------------


function uiTeamControl:OnOpen()
	self:LoadSetting();
	
	Wnd_SetFocus(self.UIGROUP, self.EDT_NEEDB);
	Wnd_SetFocus(self.UIGROUP, self.EDT_FREEBAG);
	self:UpdateEdit();
end
function uiTeamControl:LoadSetting()
	self.tbSetting	= self:Load(self.DATA_KEY) or {};
	
	if not self.tbSetting.nFreeBag then
		self.tbSetting.nFreeBag = 2;
	end
		if  not self.tbSetting.nNeedBuy then
		self.tbSetting.nNeedBuy =30
		end
	
end
function uiTeamControl:OnEditChange(szWndName, nParam)
	if (szWndName == self.EDT_FREEBAG) then
		local nFNum = Edt_GetInt(self.UIGROUP, self.EDT_FREEBAG);
		if (nFNum == self.tbSetting.nFreeBag) then	
			return;
		end
		if (nFNum < 0) then
			nFNum = 0;
		end
		if (nFNum > 100) then
			nFNum = 99;
		end
		if szFreeBag == "" or nil then
		self.tbSetting.nFreeBag = 2
		end
		self.tbSetting.nFreeBag = nFNum;
		self:UpdateEdit();
	end
	if (szWndName == self.EDT_NEEDB) then
		local nNNum = Edt_GetInt(self.UIGROUP, self.EDT_NEEDB);
		if (nNNum == self.tbSetting.nNeedB) then	
			return;
		end
		if (nNNum < 0) then
			nNNum = 0;
		end
		if (nNNum > 100) then
			nNNum = 99;
		end
		if szNeedB == "" or nil then
		self.tbSetting.nNeedB = 2
		end
		self.tbSetting.nNeedB = nNNum;
		self:UpdateEdit();
	end
end
function uiTeamControl:OnEditEnter(szWnd)
	if (szWnd == self.EDT_FREEBAG) or (szWnd == self.EDT_NEEDBUY) then
		self:OnButtonClick(self.BTN_SAVE, 0);
	end
end
function uiTeamControl:UpdateEdit()
	Edt_SetInt(self.UIGROUP, self.EDT_FREEBAG, self.tbSetting.nFreeBag);
	
	Edt_SetInt(self.UIGROUP, self.EDT_NEEDB, self.tbSetting.nNeedB);
end


function uiTeamControl:SaveData()
	self:Save(self.DATA_KEY, self.tbSetting);
end


function uiTeamControl:Save(szKey, tbData)
	self.m_szFilePath="\\user\\freebag.dat";
	self.m_tbData[szKey] = tbData;
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);

		KIo.WriteFile(self.m_szFilePath, szData);
	
end

function uiTeamControl:Load(key)
	self.m_szFilePath="\\user\\freebag.dat";
	self.m_tbData = {};
	local szData = KIo.ReadTxtFile(self.m_szFilePath);

	if (szData) then
			self.m_tbData = Lib:Str2Val(szData);
	end
	local tbData = self.m_tbData[key];
	return tbData
end
-------------------------------------------------------------------
uiTeamControl.PeepChatMsg =function(self)
	uiTeamControl.OnMsgArrival_bak	= uiTeamControl.OnMsgArrival_bak or UiCallback.OnMsgArrival;
	function uiTeamControl:OnMsgArrival(nChannelID, szSendName, szMsg)
		uiTeamControl:SeeChatMsg(szMsg);
		uiTeamControl.OnMsgArrival_bak(UiCallback, nChannelID, szSendName, szMsg);
	end
end





function uiTeamControl:QAT()
	if (me.GetMapTemplateId() < 65500) then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Ảnh Thạch chỉ hoạt động trong Hải Lăng !<color>");
		return;
	end
	local nPuFire=0;
	if nPuFire == 0 then 
		nPuFire = 1;
		me.Msg("<color=yellow>Tự đếm số mở Quang Ảhh Thạch...<color>");
		SendChannelMsg("NearBy", "Đếm số");	
	end
end
function uiTeamControl:OnSay(szChannelName, szName, szMsg, szGateway)
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
	end
----------
function uiTeamControl:ChatTeam()
UiManager:SwitchWindow(Ui.UI_CONSET);
end
-----------	
---------------------NLHN------------------
function uiTeamControl:ChatGoNLHN()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Vào NLHN nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
------------------ HLVM------------------
function uiTeamControl:ChatNVHLVM()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi nhận nhiệm vụ HLVM nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatBDHLVM()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi báo danh HLVM nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatGoHLVM()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Vào HLVM nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

-------------------------BMS------------------------------
function uiTeamControl:ChatNVBMS()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi nhận nhiệm vụ BMS nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatBDBMS()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi báo danh BMS nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatGoBMS()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Vào BMS nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatQuitBMS()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Rời khỏi BMS nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:QuitBMS()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
end
me.StartAutoPath(1837,2837);
end

-------------------------HSPN----------------------------
function uiTeamControl:ChatNVHSPN()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi nhận nhiệm vụ HSPN nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatBDHSPN()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi báo danh HSPN nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatGoHSPN()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Vào HSPN nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

--------------------------Khac----------------------------
function uiTeamControl:ChatLakTDLT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em nhận Lak TDLT nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatBuLakTDLT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em cắn Lak TDLT nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatBuLak7()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em cán Lak Ma Đao Thạch cấp 7 nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatGoTDC()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào TDC 2 nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatRTDC()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em lấy rương máu TDC nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatMTDC()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em mở rương máu TDC nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatTRAM()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Trả máu Phúc Lợi!!");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatBHDserver()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào BHĐ Liên Server nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatGhepHT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi ghép HT nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatBVD()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em chạy BVĐ nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatLuongGT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em nhận lương nào !!")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

---------- gọi vào Mộng cảnh ----------
function uiTeamControl:ChatPhoThuyLoi1()
if me.GetMapTemplateId() < 225 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào Mộng Cảnh thôi!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiTeamControl:ChatPhoThuyLoi2()
if me.GetMapTemplateId() > 65540 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em rời khỏi Mộng Cảnh thôi!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiTeamControl:ChatPhoThuyLoi3()
if me.GetMapTemplateId() < 30 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh Em ơi Train trong Mộng Cảnh!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiTeamControl:QuitMongCanh()						
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
end
me.StartAutoPath(1600,3200);
--self:ProcessClick(tbPos, ...);
end
-------------- tự vào VAGT và nhận thưởng-----------
function uiTeamControl:ChatVaoGiaToc()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh Em ơi Vào Ải gia tộc chơi đê!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end


function uiTeamControl:ChatDongTienCo()

local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi đổi tiền nào!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl.ChatRaGiaToc()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Xong ải gia tộc rồi ra thôi!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiTeamControl.ChatLoThong()
if me.GetMapTemplateId() > 65000 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em lên bem con boss cuối nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiTeamControl.ChatVaoLanhDia()
if me.GetMapTemplateId() < 30 then
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
	SendChannelMsg("Team", "Anh em vào lãnh địa gia tộc nào !!")
	else
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
else
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
	SendChannelMsg("Team", "Anh em rời khỏi lãnh địa gia tộc nào !!")
	else
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end
end
-------------
function uiTeamControl:ChatRTDLT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em lấy rương máu TDLT nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatThuongTDLT()
if me.GetMapTemplateId() < 255 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Nhận thưởng TDLT mau thôi")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end
-------- báo boss-------
function uiTeamControl:ChatBoss()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em bật/tắt báo boss nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
------------ vứt nguyên liệu TDC-------
function uiTeamControl:ChatRacTDC()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em xả rác nào <pic=94>!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
----------------------------TongKim--------------------------
function uiTeamControl:ChatVaoMC()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào MÔNG CỔ nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatVaoTH()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào TÂY HẠ nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
---------LMKP-------
function uiTeamControl:ChatVaoLMPK()
if me.GetMapTemplateId() < 225 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào Hầm thôi!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiTeamControl:ChatLMPK()
if me.GetMapTemplateId()>65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Đi qua nào !!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end
---------------


function uiTeamControl:ChatRuongTK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em lấy rương máu Tống Kim!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatMAUTK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em mở rương máu Tống Kim!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatMauTDLT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em mở rương máu Phúc Lợi!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatNVHK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em nhan,tra nv hiep khach nao!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatMUAMAU()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi mua máu nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatCai()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi mua thức ăn!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
----------------- Ext---------------
function uiTeamControl:ChatLBTQL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em nhận Lệnh bài TQL nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatNVTQL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em nhận nhiệm vụ TQL nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatVaoTQL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Vào TQL nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatRoiTQL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Rời khỏi TQL nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatRoiLauLan()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Rời khỏi Lâu Lan Cổ thành nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatCKP()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em mua CKP nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatNangDong()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em nhận điểm năng động nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatThanSa()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đăng kí mở khóa nguyên liệu thần sa nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
--------------------------HE THONG------------------------
function uiTeamControl:GetTeamLeader()
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	if nAllotModel and tbMemberList then
    local tLeader = tbMemberList[1];
    local pNpc = KNpc.GetByPlayerId(tLeader.nPlayerID);
    if(not pNpc or pNpc.szName == me.szName) then
    	return nil;
    end
		return pNpc;
	end
end

function uiTeamControl:ChatFollow()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả bật hộ tống");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatStartBuff()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
SendChannelMsg("Team", "Tất cả bật tự buff");
end

function uiTeamControl:ChatStartPK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả bật tự động đánh");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:ChatStopPK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả dừng mọi hoạt động");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiTeamControl:StopAutoFight()
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

function uiTeamControl:StartAutoFight()
	if me.nAutoFightState ~= 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end
---------------tra thuoc---------------------
local uiTextInput = Ui(Ui.UI_TEXTINPUT);
local nTimerId = 0;
local nTraDaoTimerId = 0;
local nLastOpenTime = 0;
local nWaitTime = 5; 

function AutoAi:StartTraRuongThuoc(g,d,p,l,n)
	if nTimerId == 0 then
		me.Msg("Bắt đầu trả ...");
		nTimerId	= Ui.tbLogic.tbTimer:Register(18, AutoAi.TraRuong, AutoAi, g, d, p, l, n);
	end
end

function AutoAi:StopTraRuongThuoc()
	if nMoDaoTimerId > 0 then
		--me.Msg("<color=yellow>Tắt tự mở rương thuốc<color>");
		Ui.tbLogic.tbTimer:Close(nTraDaoTimerId);
		nMoDaoTimerId = 0;
	end
end

function AutoAi:TraRuong(g,d,p,l,n)
	local nCurTime = GetTime();
	local nDiff = nCurTime - nLastOpenTime;
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then		
		return; 
	end
	if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
		me.CallServerScript({ "DlgCmd", "InputNum", n });
		UiManager:CloseWindow(Ui.UI_TEXTINPUT);
	end
	if nLastOpenTime > 0 and nDiff < nWaitTime then
		return; 
	end
	if nLastOpenTime > 0 and nDiff >= nWaitTime then			
		AutoAi:DungTraRuong(); 
		nLastOpenTime = 0;
		return;
	end
	local tbItem = me.FindItemInBags(g,d,p,l)[1];
	if tbItem then
		me.UseItem(tbItem.pItem);
		nLastOpenTime = nCurTime;
		me.AnswerQestion(1);
		Ui.tbLogic.tbTimer:Register(18, AutoAi.CloseSay);
	end
end

function AutoAi:DungTraRuong()
	if nTimerId > 0 then
		me.Msg("Trả hôp đầu ...");
		Ui.tbLogic.tbTimer:Close(nTimerId);
		nTimerId = 0;
	end
end
--------------------trả rương TK -----------------------
function AutoAi:TraRuongThuocTK()
	local nPlanNum = (me.GetItemCountInBags(17,6,1,2) + me.GetItemCountInBags(17,6,3,2)); 
	
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật trả rương thuốc TK<color>");
				local tbFind = me.FindItemInBags(18,1,59,1)[1] or me.FindItemInBags(18,1,61,1)[1] or me.FindItemInBags(18,1,62,1)[1] or me.FindItemInBags(18,1,56,1)[1];
	if not tbFind then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>Hành trang không có rương thuốc TK<color>");
	else
		local pItem = tbFind.pItem;
		local g = pItem.nGenre;
		local d = pItem.nDetail;
		local p = pItem.nParticular;
		local l = pItem.nLevel;
		AutoAi:StartTraRuongThuoc(g,d,p,l,nPlanNum);
	end
end

function AutoAi:TraRuongThuocTDC()
	local nPlanNum = (me.GetItemCountInBags(17,8,1,3) + me.GetItemCountInBags(17,8,3,3)) ; 
	
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật trả rương thuốc TDC<color>");
				local tbFind = me.FindItemInBags(18,1,352,1)[1] or me.FindItemInBags(18,1,352,2)[1] or me.FindItemInBags(18,1,352,3)[1]
							or me.FindItemInBags(18,1,354,1)[1] or me.FindItemInBags(18,1,354,2)[1] or me.FindItemInBags(18,1,354,3)[1]
							or me.FindItemInBags(18,1,59,1)[1] or me.FindItemInBags(18,1,353,2)[1] or me.FindItemInBags(18,1,353,3)[1];
	if not tbFind then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>Hành trang không có rương thuốc TDC<color>");
	else
		local pItem = tbFind.pItem;
		local g = pItem.nGenre;
		local d = pItem.nDetail;
		local p = pItem.nParticular;
		local l = pItem.nLevel;
		AutoAi:StartTraRuongThuoc(g,d,p,l,nPlanNum);
	end
end

function AutoAi:TraRuongThuocTDLT()
	local nPlanNum = ( me.GetItemCountInBags(17,7,1,2) + me.GetItemCountInBags(17,7,3,2)) ; 
	
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật trả rương thuốc TĐLT<color>");
				local tbFind = me.FindItemInBags(18,1,273,2)[1] or me.FindItemInBags(18,1,275,2)[1];
	if not tbFind then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>Hành trang không có rương thuốc TĐLT<color>");
	else
		local pItem = tbFind.pItem;
		local g = pItem.nGenre;
		local d = pItem.nDetail;
		local p = pItem.nParticular;
		local l = pItem.nLevel;
		AutoAi:StartTraRuongThuoc(g,d,p,l,nPlanNum);
	end
end
------------------------------------------

function uiTeamControl:ScrReload()
	UiManager:CloseWindow(Ui.UI_TeamControl)
end

local tCmd={ "UiManager:SwitchWindow(Ui.UI_TeamControl)", "uiTeamControl", "", "Shift+C", "Shift+C", "Dieu khien to doi"};
AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);


LoadUiGroup(Ui.UI_TeamControl, "TeamControl.ini");