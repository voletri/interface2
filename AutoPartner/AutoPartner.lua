-----Edited by Quốc Huy-----
local tbAutoPartner = Map.tbAutoPartner or {};
Map.tbAutoPartner = tbAutoPartner;


local nGiftTimer
local nSwitch = 0;

local nMaxLevelBind = 2;
local nMaxLevel = 2;

local nSwitchMonitor = 0;
local nMonitorTimer
local nMonitorinterval = 30;
local nBreak = 1;
local nAutoSwitch = 2;

function tbAutoPartner:_Init()
	self.EnterGame_bak	= self.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		tbAutoPartner.EnterGame_bak(Ui);
		tbAutoPartner:OnEnterGame();
	end

	print("autopartner Loaded!");
end

function tbAutoPartner:OnEnterGame()
	self:UpdateAll(2);
end

function tbAutoPartner:UpdateAll(ifsave)
	local tbpartner_setting = Ui:GetClass("partner_setting");
	local tbSetting = tbpartner_setting:Load(tbpartner_setting.DATA_KEY) or {};

	nMaxLevelBind	= tbSetting.nMaxLevelBind or 0;
	nMaxLevel = tbSetting.nMaxLevel or 0;
	nMonitorinterval = tbSetting.nMonitorinterval or 30;

	nBreak = tbSetting.nBreak or 1;
	nAutoSwitch = tbSetting.nAutoSwitch or 2;

	if ifsave == 1 then		
		 me.Msg("Open/Close Auto:");
		return
	elseif ifsave == 2 then
		if nAutoSwitch == 0 then
			if self:CheckCanUpdate() == 0 and nBreak == 1 then
				return
			end
			self:StartMonitor();
		else
			self:StopMonitor();
		end		
		return	
	end
	
	me.Msg(string.format("<color=yellow>Tặng huyền tinh cấp<color> <color=pink>%s <color><color=yellow>là Cao nhất<color>",nMaxLevelBind))
	me.Msg(string.format("<color=yellow>Tặng huyền tinh cấp<color> <color=pink>%s <color><color=yellow>là Thấp nhất<color>",nMaxLevel))
	me.Msg(string.format("<color=yellow>Sau<color> <color=pink>%ss <color><color=yellow>kiểm tra hành trang để tặng quà<color>",nMonitorinterval))
end


function tbAutoPartner:SwitchGift()
	if nSwitch == 0 then
		me.Msg("<color=yellow>Bắt đầu tự động quà tặng");
		if me.nActivePartner >= 0 and me.nActivePartner <= me.nPartnerLimit then

		else
			me.Msg("Không hoạt động đồng hành hoặc vượt quá giới hạn, ngừng hoạt động");
			return
		end
		nSwitch = 1;
		nGiftTimer = Timer:Register(Env.GAME_FPS * 1,self.AutoGift,self);
	else
		nSwitch = 0;
		me.Msg("<color=green>Tắt tự động tặng quà");
		Timer:Close(nGiftTimer);
	end
end

function tbAutoPartner:AutoGift()

	if self:CheckCanUpdate() ~= 1 then
		me.Msg("<color=yellow>Mức độ kỹ năng hiện tại đã Full không thể tiếp tục cho");
		nSwitch = 0;
		Timer:Close(nGiftTimer);
		if nBreak == 1 then
			if nSwitchMonitor == 1 then
				self:SwitchMonitor();
			end
		end
		return;
	end

	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		--local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
		--if string.find(szQuestion, "Quà đặt vào sẽ giúp lĩnh ngộ của đồng hành tăng đến") then
			me.AnswerQestion(0);
			self:CloseAll()
		--end
		return
	end

	if UiManager:WindowVisible(Ui.UI_ITEMGIFT) ~= 1 then
		--Ui(Ui.UI_PARTNER).OnButtonClick(Ui(Ui.UI_PARTNER),"BtnPresent");
		me.CallServerScript({ "PartnerCmd", "SendGift", me.nActivePartner});
		return
	end

	local nFindGift = 0;


	if UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1 then
		UiManager:OpenWindow(Ui.UI_ITEMBOX);
	end
	
for nCont = 1, 11 do
		if Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont] then
			for i = 0, Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nRoom, i, 0);
				if pItem then
					local tbObj =Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].tbObjs[0][i];
					if pItem.szClass == "xuanjing"  then
						if self:CheckCanGift(pItem) == 1 then
							Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont]:UseObj(tbObj,i,0);
							nFindGift = 1;
						end
					end
				end
			end
		end
	end



	if nFindGift == 0 then
		me.Msg("<color=yellow>Không tìm thấy Huyền tinh để tặng");
		self:CloseAll();
		return
	end

	if UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1 then
		local uiItemGift = Ui(Ui.UI_ITEMGIFT)
		uiItemGift.OnButtonClick(uiItemGift,"BtnOk")
	end
end

function tbAutoPartner:CheckCanUpdate()
	local pPartner = me.GetPartner(me.nActivePartner);
	if not pPartner then
		return 0;
	end

	for nIndex = 1, pPartner.nSkillCount do
		if pPartner.GetSkill(nIndex-1).nLevel < 6 then
			return 1;
		end
	end

	return 0;
end

function tbAutoPartner:CloseAll()
	UiManager:CloseWindow(Ui.UI_SAYPANEL);
	UiManager:CloseWindow(Ui.UI_PARTNER);
	UiManager:CloseWindow(Ui.UI_ITEMGIFT);
	UiManager:CloseWindow(Ui.UI_ITEMBOX);
	Timer:Close(nGiftTimer);
	me.Msg("<color=green>Móm quà tự động kết thúc, chờ đợi móm quà tiếp theo");
	nSwitch = 0
end

function tbAutoPartner:SwitchMonitor()
	if nSwitchMonitor == 0 then
		self:StartMonitor()
	else
		self:StopMonitor()
	end
end

function tbAutoPartner:StartMonitor()
	if nSwitchMonitor == 1 then
		return;
	end
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật tự động Tặng Quà Cho Pet");
	nSwitchMonitor = 1
	self:UpdateAll(0);
	nMonitorTimer = Timer:Register(Env.GAME_FPS * nMonitorinterval,self.OnMonitorTime,self);
end

function tbAutoPartner:StopMonitor()
	if nSwitchMonitor == 0 then
		return
	end
	nSwitchMonitor = 0
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Tắt tự động Tặng Quà Cho Pet");
	if nSwitch == 1 then
		nSwitch = 0;
		Timer:Close(nGiftTimer);
	end
	Timer:Close(nMonitorTimer);
end

function tbAutoPartner:OnMonitorTime()
	if nSwitchMonitor == 0 then
		Timer:Close(nMonitorTimer);
		return
	end

	local tbXuanJing = me.FindClassItemInBags("xuanjing");
	if tbXuanJing then
		for i = 1,#tbXuanJing do
			if self:CheckCanGift(tbXuanJing[i].pItem) == 1 then
				self:SwitchGift();
				return
			end
		end
	end

end

function tbAutoPartner:CheckCanGift(pItem)
	if (pItem.IsBind() ~= 1 and tonumber(pItem.nLevel) <= nMaxLevel)
	or (pItem.IsBind() == 1 and tonumber(pItem.nLevel) <= nMaxLevelBind) then
		return 1
	end
	return
end

function tbAutoPartner:OnAutoFight()
	--me.Msg(nAutoSwitch);
	if nAutoSwitch ~= 1 then
		return
	end

	if me.nAutoFightState == 1 then
		if nSwitchMonitor == 0 then
			if self:CheckCanUpdate() == 0 and nBreak == 1 then
				return
			end
			self:StartMonitor()
			nSwitchMonitor = 2
		end
	else
		if nSwitchMonitor == 2 then
			self:StopMonitor();
		end
	end
end

UiNotify:RegistNotify(UiNotify.emCOREEVENT_SYNC_DOING, tbAutoPartner.OnAutoFight,tbAutoPartner);

tbAutoPartner:_Init();

-----------------------------------------------------

local tbpartner_setting			     = Ui:GetClass("partner_setting") or {};

tbpartner_setting.BTN_CLOSE		 			= "BtnClose";
tbpartner_setting.BTN_SAVE         			= "BtnSave";
tbpartner_setting.BTN_EXIT         			= "BtnExit";
tbpartner_setting.SCROLL_MAXLEVELBIND		= "ScrbarMaxLevelBind";      
tbpartner_setting.SCROLL_MAXLEVEL	 		= "ScrbarMaxLevel";      
tbpartner_setting.SCROLL_INTERVAL 			= "ScrbarInterval";		  
tbpartner_setting.TXT_MAXLEVELBIND     		= "TxtMaxLevelBind";    
tbpartner_setting.TXT_MAXLEVEL	  			= "TxtMaxLevel";	
tbpartner_setting.TXT_INTERVAL	  			= "TxtInterval";
tbpartner_setting.BTN_BREAKMONITOR			= "BtnBreakMonitor";
tbpartner_setting.BTN_SWITCHMONITOR 		= "BtnSwitch";
tbpartner_setting.CMB_AUTOSWITCH			= "CmbAutoSwitch";

tbpartner_setting.DATA_KEY					= "autopartner";
tbpartner_setting.tbSetting					= {};

tbpartner_setting.tbAutoSwitch= {"Mở Khi Vào Game","Mở Khi Chiến Đấu","Mở Bằng Tay"}

local self = tbpartner_setting;



function tbpartner_setting:OnOpen()

	ClearComboBoxItem(self.UIGROUP, self.CMB_AUTOSWITCH);
	for i = 1,#self.tbAutoSwitch do
		ComboBoxAddItem(self.UIGROUP, self.CMB_AUTOSWITCH, i, self.tbAutoSwitch[i]);
	end

	self.tbSetting	= tbpartner_setting:Load(self.DATA_KEY) or {};

	if not self.tbSetting.nMaxLevelBind then
		self.tbSetting.nMaxLevelBind = 2;
	end

	if not self.tbSetting.nMaxLevel then
		self.tbSetting.nMaxLevel = 2;
	end

	if not self.tbSetting.nMonitorinterval then
		self.tbSetting.nMonitorinterval = 30;
	end

	if not self.tbSetting.nBreak then
		self.tbSetting.nBreak = 1;
	end

	if not self.tbSetting.nAutoSwitch then
		self.tbSetting.nAutoSwitch = 2;
	end

	Btn_Check(self.UIGROUP, self.BTN_BREAKMONITOR, self.tbSetting.nBreak);
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_MAXLEVELBIND, self.tbSetting.nMaxLevelBind );
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_MAXLEVEL, self.tbSetting.nMaxLevel );
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_INTERVAL,self.tbSetting.nMonitorinterval/5);
	ComboBoxSelectItem(self.UIGROUP, self.CMB_AUTOSWITCH, self.tbSetting.nAutoSwitch);
	self:UpdateLable();
end

function tbpartner_setting:OnClose()

end

function tbpartner_setting:SaveSetting()
    tbpartner_setting:Save(self.DATA_KEY, self.tbSetting);
	Map.tbAutoPartner:UpdateAll(1);
end

function tbpartner_setting:OnButtonClick(szWnd, nParam)
	if szWnd == self.BTN_CLOSE or szWnd == self.BTN_EXIT then
		UiManager:CloseWindow(self.UIGROUP);
		me.Msg("Đóng")
	elseif szWnd == self.BTN_SAVE then
		self:SaveSetting();
		UiManager:CloseWindow(self.UIGROUP);
		me.Msg("Đã lưu")
	elseif szWnd == self.BTN_BREAKMONITOR then
		self.tbSetting.nBreak = nParam;
	elseif szWnd == self.BTN_SWITCHMONITOR then
		self:SaveSetting();
		Map.tbAutoPartner:SwitchMonitor();
	end
end

function tbpartner_setting:OnMenuItemSelected(szWnd, nItemId, nParam)

end

function tbpartner_setting:OnScorllbarPosChanged(szWnd, nParam)
	if szWnd == self.SCROLL_MAXLEVELBIND then
		local nMaxLevelBind = nParam
		self.tbSetting.nMaxLevelBind  = nMaxLevelBind ;
	elseif szWnd == self.SCROLL_MAXLEVEL then
		local nMaxLevel = nParam ;
		self.tbSetting.nMaxLevel = nMaxLevel ;
	elseif szWnd == self.SCROLL_INTERVAL then
	    local nMonitorinterval = nParam ;
		self.tbSetting.nMonitorinterval = nMonitorinterval * 5;
	end
	self:UpdateLable();
end

function tbpartner_setting:OnComboBoxIndexChange(szWnd, nIndex)
	if (szWnd == self.CMB_AUTOSWITCH) then
		self.tbSetting.nAutoSwitch = nIndex;
	end
end

function tbpartner_setting:UpdateLable()
	Txt_SetTxt(self.UIGROUP, self.TXT_MAXLEVELBIND,"Tặng huyền tinh cấp <color=yellow>"..self.tbSetting.nMaxLevelBind.."<color> là cao nhất");
	Txt_SetTxt(self.UIGROUP, self.TXT_MAXLEVEL, "Tặng huyền tinh cấp <color=yellow>"..self.tbSetting.nMaxLevel.."<color> là thấp nhất");
	Txt_SetTxt(self.UIGROUP, self.TXT_INTERVAL, "Sau<color=yellow>"..self.tbSetting.nMonitorinterval.."<color> kiểm tra hành trang để tặng quà");
end


Ui:RegisterNewUiWindow("UI_PARTNER_SETTING", "partner_setting", {"a", 224, 103}, {"b", 336, 187}, {"c", 462, 203}, {"d", 462, 203});


function tbpartner_setting:Save(szKey, tbData)
	self.m_szFilePath="\\user\\AutoPartner\\"..me.szName.."_AutoPartner.dat";
	self.m_tbData = {};
	self.m_tbData[szKey] = tbData;
	print(tbData);
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KIo.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

function tbpartner_setting:Load(key)
	self.m_szFilePath="\\user\\AutoPartner\\"..me.szName.."_AutoPartner.dat";
	self.m_tbData = {};
	print(key);
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if (szData) then
		if self:CheckErrorData(szData) == 1 then  
			self.m_tbData = Lib:Str2Val(szData);
		else
			KIo.WriteFile(self.m_szFilePath, "");
		end
	end
	local tbData = self.m_tbData[key];
	print(self.m_tbData);
	return tbData;
end

function tbpartner_setting:CheckErrorData(szDate)
	if szDate ~= "" then
		if string.find(szDate, "Ptr:") and string.find(szDate, "ClassName:") then
			return 0;
		end
		if (not Lib:CallBack({"Lib:Str2Val", szDate})) then
			return 0;
		end
	end
	return 1;
end

LoadUiGroup(UI_PARTNER_SETTING,"partner_setting.ini");