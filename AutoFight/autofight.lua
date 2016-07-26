
local uiAutoFight = Ui(Ui.UI_AUTOFIGHT);
local tbSaveData = Ui.tbLogic.tbSaveData;
local tbObject  = Ui.tbLogic.tbObject;
local tbAutoFightData = Ui.tbLogic.tbAutoFightData;

uiAutoFight.BUTTON_CLOSE			= "BtnClose";
uiAutoFight.BUTTON_EXIT				= "BtnExit";
uiAutoFight.BUTTON_SAVE				= "BtnSave";
uiAutoFight.TXX_INFOR				= "TxtExInFor";
uiAutoFight.BUTTON_AUTOFIGHT		= "BtnAutoFight";
uiAutoFight.BUTTON_PICKITEM			= "BtnPickItem";
uiAutoFight.TXT_PICKITEMSTAR		= "TxtPickItemStar";
uiAutoFight.TXT_LIFE				= "TxtLife";
uiAutoFight.OBJ_SkILL				= "ObjSkill";
uiAutoFight.PAGE					= "Page";
uiAutoFight.SCROLL_ITEMSTAR			= "ScrbarItemStar";
uiAutoFight.SCROLL_LIFE				= "ScrbarLife";
uiAutoFight.DATA_KEY				= "AutoFight";
uiAutoFight.OBJ_SkILL_ROW			= 6;
uiAutoFight.OBJ_SkILL_LINE			= 1;
uiAutoFight.BUTTON_TEAM				= "BtnTeam";
uiAutoFight.BUTTON_REPAIR			= "BtnRepair";
uiAutoFight.BUTTON_OPENJIUXIANG		= "BtnOpenJiuXiang";
uiAutoFight.BUTTON_DRINK			= "BtnDrink";
uiAutoFight.BUTTON_JOIN				= "BtnJoin";
--uiAutoFight.BUTTON_SiwanFanhui		= "BtnSiwanFanhui";

uiAutoFight.BUTTON_DUSHU			= "BtnDuShu";
uiAutoFight.BUTTON_DUSHU_MOVE		= "BtnMoveRead";
uiAutoFight.TXX_BUG					= "TxtDuShuBug";
uiAutoFight.BUTTON_XLZ				= "BtnXiuLianZhu";
uiAutoFight.BUTTON_PKfanji			= "BtnPKfanji";

uiAutoFight.BUTTON_PVP_MODE			= "BtnPvpMode";
uiAutoFight.BUTTON_AUTO_MED			= "BtnAutoMed";
uiAutoFight.OBJ_MEDICAMENT			= "ObjMedicament";

uiAutoFight.BUTTON_SW			= "Btnsw";   
uiAutoFight.OBJ_MEDICAMENT_ROW		= 2;
uiAutoFight.OBJ_MEDICAMENT_LINE		= 1;
local tbObjSkillCont = { bShowCd = 0, bUse = 0, bLink = 0, bSwitch = 0};	-- 不显示CD特效，不可使用，不可链接

uiAutoFight.BTN_QINGCHU = "Qingchu";
uiAutoFight.BTN_TBSKILLID = "TbSkillId";
uiAutoFight.BTN_PK0 = "Pk0";
uiAutoFight.BTN_PK1 = "Pk1";

uiAutoFight.Init = function(self)
	self.bAutoFight		= 0;
	self.bPickItem		= 0;
	self.nAcceptTeam	= 0;
	self.nAutoRepair	= 0;
	self.nPickStar		= 2;
	self.nAutoOpenJiuXiang	= 0;
	self.nLifeRet		= 50;
	self.nLeftSkillId	= 0;
	self.nRightSkillId	= 0;
	self.n3SkillId	= 0;
	self.n4SkillId	= 0;
	self.n5SkillId	= 0;
	self.n6SkillId	= 0;
	self.nAutoDrink		= 0;
	self.nAutoFD	=0;
	self.nAutoFDWX =0;
	self.nAutoRead	=0;
	self.nAutoRead_Move=0;
	self.nAutoXLZ	=0;
	self.nJoin	=0;
	self.nDead	=0;
	self.nPKfanji	=0;
	self.tbFightSetting = {};
	self.nPvpMode 		= 0;
	--self.tbLeftMed	= nil;
	--self.tbRightMed	= nil;
end

uiAutoFight.OnCreate = function(self)
	self.tbObjSkillCont = tbObject:RegisterContainer(
		self.UIGROUP,
		self.OBJ_SkILL,
		self.OBJ_SkILL_ROW,
		self.OBJ_SkILL_LINE,
		tbObjSkillCont
	);
	self.tbObjMedicamentCont = tbObject:RegisterContainer(
		self.UIGROUP,
		self.OBJ_MEDICAMENT,
		self.OBJ_MEDICAMENT_ROW,
		self.OBJ_MEDICAMENT_LINE,
		tbObjMedicamentCont
	);
end

uiAutoFight.OnDestroy = function(self)
	tbObject:UnregContainer(self.tbObjSkillCont);
	tbObject:UnregContainer(self.tbObjMedicamentCont);
end

uiAutoFight.OnObjGridSwitch = function(self, szWnd, nX, nY)
	if szWnd == self.OBJ_SkILL then
		if nX == 0 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTOLEFTSKILL");
		elseif nX == 1 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTORIGHTSKILL");
		elseif nX == 2 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTO3SKILL");
		elseif nX == 3 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTO4SKILL");
		elseif nX == 4 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTO5SKILL");
		elseif nX == 5 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTO6SKILL");
		end
	end
end

uiAutoFight.OnOpen=function(self)
	self:Init();
	self:LoadSetting();
	self.bAutoFight = me.nAutoFightState;
	self:UpdateWnd();

end

uiAutoFight.OnButtonClick = function(self, szWnd, nParam)
	if szWnd == self.BUTTON_CLOSE  or szWnd == self.BUTTON_EXIT  then
		UiManager:CloseWindow(self.UIGROUP);

	elseif szWnd == self.BUTTON_SAVE then

		self:SaveData();

		self:UpdateAction();

		UiManager:CloseWindow(self.UIGROUP);

	elseif szWnd == self.BUTTON_AUTOFIGHT then
		self.bAutoFight = nParam;

	elseif szWnd == self.BUTTON_PVP_MODE then
		self.nPvpMode = nParam;

	elseif szWnd == self.BUTTON_AUTO_MED then
		if nParam == 1 then
			self:StartAutoMed();
		elseif nParam == 0 then
			self:StopAutoMed();
		end

	elseif szWnd == self.BUTTON_PICKITEM then
		self.bPickItem = nParam;

	elseif szWnd == self.BUTTON_TEAM then
		self.nAcceptTeam = nParam;

	elseif szWnd == self.BUTTON_REPAIR then
		self.nAutoRepair = nParam;

	elseif szWnd == self.BUTTON_OPENJIUXIANG then
		self.nAutoOpenJiuXiang = nParam;
	elseif szWnd == self.BUTTON_DRINK then
		self.nAutoDrink = nParam;

	elseif szWnd == self.BUTTON_DUSHU then
		self.nAutoRead=nParam;
		self.nAutoRead_Move=0;
		Btn_Check(self.UIGROUP, self.BUTTON_DUSHU_MOVE, 0);

	elseif szWnd == self.BUTTON_DUSHU_MOVE then
		self.nAutoRead_Move=nParam;
		self.nAutoRead=0;
		Btn_Check(self.UIGROUP, self.BUTTON_DUSHU, 0);

	elseif szWnd==self.BUTTON_XLZ then
		self.nAutoXLZ=nParam;

	elseif szWnd==self.BUTTON_JOIN then
		self.nJoin=nParam;

	--elseif szWnd==self.BUTTON_SiwanFanhui then
	--	self.nDead=nParam;
	elseif szWnd == self.BUTTON_PKfanji then
		self.nPKfanji=nParam;
	elseif szWnd == self.BUTTON_SW then
		UiManager:OpenWindow(Ui.UI_NOPICK_SETTING);

	elseif szWnd == self.BTN_QINGCHU then
		uiAutoFight.SaveData(uiAutoFight, "Qingchu")
		self:UpdateAction();
		UiManager:OpenWindow(self.UIGROUP);
	elseif szWnd == self.BTN_TBSKILLID then
		me.Msg(string.format("Skill1=%d 2=%d 3=%d 4=%d 5=%d 6=%d",self.nLeftSkillId,self.nRightSkillId,self.n3SkillId,self.n4SkillId,self.n5SkillId,self.n6SkillId));
	elseif szWnd == self.BTN_PK0 then
		uiAutoFight.SaveData(uiAutoFight, "Pk0")
		self:UpdateAction();
		UiManager:OpenWindow(self.UIGROUP);
	elseif szWnd == self.BTN_PK1 then
		uiAutoFight.SaveData(uiAutoFight, "Pk1")
		self:UpdateAction();
		UiManager:OpenWindow(self.UIGROUP);

	end
end

uiAutoFight.SaveData=function(self, SetSkillId)
	local tbSkillIdPk0 = {
	[0] = {[0] = {1,0,0,0,0,0}}, 		
	[1] = {[1] = {1241,27,24,21,0,0},[2]={821,31,36,33,29,0}}, 
	[2] = {[1] = {823,41,47,43,38,0},[2]={41,56,53,50,0,0}}, 
	[3] = {[1] = {285,69,827,72,74,71},[2]={1246,66,62,59,0,0}}, 
	[4] = {[1] = {831,83,80,76,0,0},[2]={833,93,90,86,0,0}},
	[5] = {[1] = {103,99,96,0,0,0},[2]={837,107,2,0,0,0}}, 
	[6] = {[1] = {117,114,111,0,0,0},[2]={125,123,120,0,0,0}}, 
	[7] = {[1] = {489,134,131,128,0,0},[2]={845,141,140,137,0,0}}, 
	[8] = {[1] = {148,492,847,149,146,143},[2]={155,151,494,156,0,0}}, 
	[9] = {[1] = {165,162,159,0,0,0},[2]={1216,1258,171,169,167,0}}, 
	[10] = {[1] = {181,178,175,3,0,0},[2]={1260,699,192,190,188,0}}, 
	[11] = {[1] = {1261,198,199,202,194,0},[2]={861,211,770,208,205,0}}, 
	[12] = {[1] = {1263,216,223,217,213,0},[2]={865,866,232,229,226,0}}, 
	[13] = {[1] = {2805,2804,2803,0,0,0},[2]={2825,2823,2821,0,0,0}},
--	[14] = {[1] = {3043,3053,3047,3041,0,0},[2]={3017,3022,3028,3033,3015,3013}}, 
	};
	local tbSkillIdPk1 = {
	[0] = {[0] = {1,0,0,0,0,0}},		
	[1] = {[1] = {283,27,24,21,0,0},[2]={283,36,33,29,0,0}}, 
	[2] = {[1] = {283,41,47,43,38,0},[2]={283,41,56,53,50,0}}, 
	[3] = {[1] = {285,69,827,71,74,0},[2]={285,66,62,59,0,0}}, 
	[4] = {[1] = {285,831,83,80,76,0},[2]={285,93,90,86,0,0}}, 
	[5] = {[1] = {103,99,96,0,0,0},[2]={837,107,2,0,0,0}}, 
	[6] = {[1] = {117,114,111,0,0,0},[2]={125,123,120,0,0,0}}, 
	[7] = {[1] = {289,489,134,131,128,0},[2]={289,845,141,140,137,0}}, 
	[8] = {[1] = {289,149,146,143,0,0},[2]={289,151,156,0,0,0}}, 
	[9] = {[1] = {291,165,162,159,0,0},[2]={291,1216,171,169,167,0}},
	[10] = {[1] = {291,181,178,175,0,0},[2]={291,192,190,188,0,0}},
	[11] = {[1] = {285,198,199,202,194,0},[2]={285,211,208,205,0,0}}, 
	[12] = {[1] = {216,223,217,213,0,0},[2]={866,232,229,226,0,0}},
	[13] = {[1] = {291,2805,2804,2803,0,0},[2]={291,2825,2823,2821,0,0}}, 
	--[14] = {[1] = {3053,3047,3041,0,0,0},[2]={3028,3033,3015,3013,0,0}}, 
	};
	if SetSkillId == "Qingchu" then
 		self.nLeftSkillId	= 0;
		self.nRightSkillId	= 0;
		self.n3SkillId	= 0;
		self.n4SkillId	= 0;
		self.n5SkillId	= 0;
		self.n6SkillId	= 0;
	elseif SetSkillId == "Pk0" and #tbSkillIdPk0[me.nFaction][me.nRouteId] == 6 then
 		self.nLeftSkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][1];
		self.nRightSkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][2];
		self.n3SkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][3];
		self.n4SkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][4];
		self.n5SkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][5];
		self.n6SkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][6];
		me.Msg(string.format("Skill:1=%d 2=%d 3=%d 4=%d 5=%d 6=%d",self.nLeftSkillId,self.nRightSkillId,self.n3SkillId,self.n4SkillId,self.n5SkillId,self.n6SkillId));
	elseif SetSkillId == "Pk0" and #tbSkillIdPk0[me.nFaction][me.nRouteId] ~= 6 then
		me.Msg(string.format("#tbSkillIdPk0[%d][%d] ~= 6",me.nFaction,me.nRouteId));
	elseif SetSkillId == "Pk1" and #tbSkillIdPk1[me.nFaction][me.nRouteId] == 6 then
 		self.nLeftSkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][1];
		self.nRightSkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][2];
		self.n3SkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][3];
		self.n4SkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][4];
		self.n5SkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][5];
		self.n6SkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][6];
		me.Msg(string.format("Skill:1=%d 2=%d 3=%d 4=%d 5=%d 6=%d",self.nLeftSkillId,self.nRightSkillId,self.n3SkillId,self.n4SkillId,self.n5SkillId,self.n6SkillId));
	elseif SetSkillId == "Pk1" and #tbSkillIdPk1[me.nFaction][me.nRouteId] ~= 6 then
		me.Msg(string.format("#tbSkillIdPk1[%d][%d] ~= 6",me.nFaction,me.nRouteId));
	end


	if self.tbObjMedicamentCont.tbMedInfo then
		self.tbLeftMed = self.tbObjMedicamentCont.tbMedInfo[1];
		self.tbRightMed= self.tbObjMedicamentCont.tbMedInfo[2];
	end

	self.tbFightSetting =
	{
	nUnPickCommonItem = self.bPickItem,
	nPickValue = self.nPickStar,
	nLifeRet = self.nLifeRet,
	nSkill1 = self.nLeftSkillId,
	nSkill2 = self.nRightSkillId,
	nSkill3 = self.n3SkillId,
	nSkill4 = self.n4SkillId,
	nSkill5 = self.n5SkillId,
	nSkill6 = self.n6SkillId,
	nAutoRepair = self.nAutoRepair,
	nAcceptTeam = self.nAcceptTeam,
	nAutoDrink = self.nAutoDrink,
	nAutoOpenJiuXiang = self.nAutoOpenJiuXiang,
		nPvpMode 			= self.nPvpMode,
		tbLeftMed 			= self.tbLeftMed,
		tbRightMed			= self.tbRightMed,
	nAutoFD=self.nAutoFD,
	nAutoFDWX=self.nAutoFDWX,
	nAutoRead=self.nAutoRead,
	nAutoXLZ=self.nAutoXLZ,
	nAutoRead_Move=self.nAutoRead_Move,
	nJoin=self.nJoin,
	nDead=self.nDead,
	nPKfanji=self.nPKfanji,
	}
	me.SetAutoTarget(self.nPvpMode);
	self:Save(self.DATA_KEY, self.tbFightSetting);
end


uiAutoFight.OnScorllbarPosChanged = function(self, szWnd, nParam)
	if szWnd == self.SCROLL_ITEMSTAR then
		local nStar = nParam;
		self.nPickStar = nStar / 2;
	elseif szWnd == self.SCROLL_LIFE then
		local nLifeRet = nParam * 10;
		self.nLifeRet = nLifeRet;
	end
	self:UpdateLable();
end

uiAutoFight.UpdateLable = function(self)
	Txt_SetTxt(self.UIGROUP, self.TXT_PICKITEMSTAR, "Nhặt trang bị trên"..self.nPickStar.."sao");
	Txt_SetTxt(self.UIGROUP, self.TXT_LIFE, "Khi sinh lực thấp hơn"..self.nLifeRet.."% sẽ dùng thuốc");
end

uiAutoFight.UpdateAction=function(self)				
	local tbAutoAiCfg =
	{
		nAutoFight		  = self.bAutoFight,
		nUnPickCommonItem = self.bPickItem,
		nPickValue		  = self.nPickStar,
		nLifeRet		  = self.nLifeRet,
		nSkill1			  = self.nLeftSkillId,
		nSkill2			  = self.nRightSkillId,
                nSkill3				= self.n3SkillId,
                nSkill4				= self.n4SkillId,
                nSkill5				= self.n5SkillId,
                nSkill6				= self.n6SkillId,
		nAutoRepair 	  = self.nAutoRepair,
		nAutoOpenJiuXiang		= self.nAutoOpenJiuXiang,
		nAcceptTeam		  = self.nAcceptTeam,
		nAutoDrink		  = self.nAutoDrink,
		nAutoFD	=self.nAutoFD,
		nAutoFDWX=self.nAutoFDWX,
		nAutoRead=self.nAutoRead,
		nAutoXLZ=self.nAutoXLZ,
		nJoin=self.nJoin,
		nDead=self.nDead,
		nPKfanji=self.nPKfanji,
		nAutoRead_Move=self.nAutoRead_Move,
		nPvpMode 			= self.nPvpMode,
		tbLeftMed 			= self.tbLeftMed,
		tbRightMed			= self.tbRightMed,
	};
	AutoAi:UpdateCfg(tbAutoAiCfg)
end

uiAutoFight.UpdateWnd = function(self)				
	Btn_Check(self.UIGROUP, self.BUTTON_AUTOFIGHT, self.bAutoFight);
	Btn_Check(self.UIGROUP, self.BUTTON_PICKITEM, self.bPickItem);

	Btn_Check(self.UIGROUP, self.BUTTON_TEAM, self.nAcceptTeam);
	Btn_Check(self.UIGROUP, self.BUTTON_REPAIR, self.nAutoRepair);

	Btn_Check(self.UIGROUP, self.BUTTON_OPENJIUXIANG, self.nAutoOpenJiuXiang);
	Btn_Check(self.UIGROUP, self.BUTTON_DRINK, self.nAutoDrink);

	Btn_Check(self.UIGROUP, self.BUTTON_DUSHU, self.nAutoRead);

	Btn_Check(self.UIGROUP, self.BUTTON_JOIN, self.nJoin);
	--Btn_Check(self.UIGROUP, self.BUTTON_SiwanFanhui, self.nDead);

	Btn_Check(self.UIGROUP, self.BUTTON_PKfanji, self.nPKfanji);
	Btn_Check(self.UIGROUP, self.BUTTON_DUSHU_MOVE, self.nAutoRead_Move);
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_ITEMSTAR, self.nPickStar * 2);
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_LIFE, self.nLifeRet / 10);

	self:UpdateLable();
	self.tbObjSkillCont:ClearObj();
	local tbLeftObj = nil;
	tbLeftObj = {};
	tbLeftObj.nType = Ui.OBJ_FIGHTSKILL;
	tbLeftObj.nSkillId = self.nLeftSkillId
	self.tbObjSkillCont:SetObj(tbLeftObj, 0, 0);

	local tbRightObj = nil;
	tbRightObj = {};
	tbRightObj.nType = Ui.OBJ_FIGHTSKILL;
	tbRightObj.nSkillId = self.nRightSkillId
	self.tbObjSkillCont:SetObj(tbRightObj, 1, 0);

	local tb3Obj = nil;
	tb3Obj = {};
	tb3Obj.nType = Ui.OBJ_FIGHTSKILL;
	tb3Obj.nSkillId = self.n3SkillId
	self.tbObjSkillCont:SetObj(tb3Obj, 2, 0);
	Img_SetImage(self.UIGROUP, "ObjSkill3", 1, tbObject:GetObjImage(tb3Obj));

	local tb4Obj = nil;
	tb4Obj = {};
	tb4Obj.nType = Ui.OBJ_FIGHTSKILL;
	tb4Obj.nSkillId = self.n4SkillId
	self.tbObjSkillCont:SetObj(tb4Obj, 3, 0);
	Img_SetImage(self.UIGROUP, "ObjSkill4", 1, tbObject:GetObjImage(tb4Obj));

	local tb5Obj = nil;
	tb5Obj = {};
	tb5Obj.nType = Ui.OBJ_FIGHTSKILL;
	tb5Obj.nSkillId = self.n5SkillId
	self.tbObjSkillCont:SetObj(tb5Obj, 4, 0);
	Img_SetImage(self.UIGROUP, "ObjSkill5", 1, tbObject:GetObjImage(tb5Obj));

	local tb6Obj = nil;
	tb6Obj = {};
	tb6Obj.nType = Ui.OBJ_FIGHTSKILL;
	tb6Obj.nSkillId = self.n6SkillId
	self.tbObjSkillCont:SetObj(tb6Obj, 5, 0);
	Img_SetImage(self.UIGROUP, "ObjSkill6", 1, tbObject:GetObjImage(tb6Obj));

	Btn_Check(self.UIGROUP, self.BUTTON_PVP_MODE, self.nPvpMode);
	Btn_Check(self.UIGROUP, self.BUTTON_AUTO_MED, self.nAutoMed or 0);

	
	for nPos = 0, 1 do
		local tbObj = self.tbObjMedicamentCont:GetObj(nPos);
		if tbObj and (tbObj.nType == Ui.OBJ_TEMPITEM) then
			self.tbObjMedicamentCont:SetObj(nil, nPos);
			self.tbObjMedicamentCont:DestroyTempItem(tbObj);
		end
	end

	self.tbObjMedicamentCont:ClearObj();

	if self.tbLeftMed then
		local tbLeftMedObj = self.tbObjMedicamentCont:LoadMedObj(self.tbLeftMed);
		self.tbObjMedicamentCont:SetObj(tbLeftMedObj, 0, 0);
	end

	if self.tbRightMed then
		local tbRightMedObj = self.tbObjMedicamentCont:LoadMedObj(self.tbRightMed);
		self.tbObjMedicamentCont:SetObj(tbRightMedObj, 1, 0);
	end
end

uiAutoFight.LoadSetting = function(self)
	--self.tbFightSetting = tbAutoFightData:Load();
	local tbFightSetting = self:Load(self.DATA_KEY)
	if not tbFightSetting then
		tbFightSetting={}
	end
	if tbFightSetting.nUnPickCommonItem then
			self.bPickItem = tbFightSetting.nUnPickCommonItem;
	end
	if tbFightSetting.nPickValue then
		self.nPickStar = tbFightSetting.nPickValue;
	end
	if tbFightSetting.nLifeRet then
		self.nLifeRet = tbFightSetting.nLifeRet;
	end

	if tbFightSetting.nSkill1 then
		self.nLeftSkillId = tbFightSetting.nSkill1;
	end
	if tbFightSetting.nSkill2 then
		self.nRightSkillId = tbFightSetting.nSkill2;
	end
	if tbFightSetting.nSkill3 then
		self.n3SkillId = tbFightSetting.nSkill3;
	end
	if tbFightSetting.nSkill4 then
		self.n4SkillId = tbFightSetting.nSkill4;
	end
	if tbFightSetting.nSkill5 then
		self.n5SkillId = tbFightSetting.nSkill5;
	end
	if tbFightSetting.nSkill6 then
		self.n6SkillId = tbFightSetting.nSkill6;
	end

	if tbFightSetting.nAcceptTeam then
		self.nAcceptTeam = tbFightSetting.nAcceptTeam;
	end

	if tbFightSetting.nAutoRepair then
		self.nAutoRepair = tbFightSetting.nAutoRepair;
	end

	if tbFightSetting.nAutoOpenJiuXiang then
		self.nAutoOpenJiuXiang = tbFightSetting.nAutoOpenJiuXiang;
	end
	if tbFightSetting.nAutoDrink then
		self.nAutoDrink = tbFightSetting.nAutoDrink;
	end

	if tbFightSetting.nPvpMode then
		self.nPvpMode = tbFightSetting.nPvpMode;
	end

	if tbFightSetting.tbLeftMed then
		self.tbLeftMed = tbFightSetting.tbLeftMed;
	end

	if tbFightSetting.tbRightMed then
		self.tbRightMed = tbFightSetting.tbRightMed;
	end

	if tbFightSetting.nAutoRead then
		self.nAutoRead = tbFightSetting.nAutoRead;
	end
	if tbFightSetting.nAutoRead_Move then
		self.nAutoRead_Move = tbFightSetting.nAutoRead_Move;
	end
	if tbFightSetting.nAutoXLZ then
		self.nAutoXLZ = tbFightSetting.nAutoXLZ;
	end
	if tbFightSetting.nJoin then
		self.nJoin = tbFightSetting.nJoin;
	end

	if tbFightSetting.nDead then
		self.nDead = tbFightSetting.nDead;
	end
	if tbFightSetting.nPKfanji then
		self.nPKfanji = tbFightSetting.nPKfanji;

	end
	tbFightSetting =
	{
	nUnPickCommonItem = self.bPickItem,
	nPickValue = self.nPickStar,
	nLifeRet = self.nLifeRet,
	nSkill1 = self.nLeftSkillId,
	nSkill2 = self.nRightSkillId,
	nSkill3 = self.n3SkillId,
	nSkill4 = self.n4SkillId,
	nSkill5 = self.n5SkillId,
	nSkill6 = self.n6SkillId,
	nAcceptTeam = self.nAcceptTeam,
	nAutoRepair = self.nAutoRepair,
	nAutoDrink = self.nAutoDrink,
	nPvpMode	 	= self.nPvpMode;
	tbLeftMed	 	= self.tbLeftMed;
	tbRightMed		= self.tbRightMed;
	nAutoRead=self.nAutoRead,
	nAutoXLZ=self.nAutoXLZ,
	nAutoRead_Move=self.nAutoRead_Move,
	nJoin=self.nJoin,
	nDead=self.nDead,
	nPKfanji=self.nPKfanji,
	nAutoOpenJiuXiang = self.nAutoOpenJiuXiang,
	}


	if self.tbFightSetting then
		self.bPickItem = tbFightSetting.nUnPickCommonItem;
		self.nPickStar =tbFightSetting.nPickValue;
		self.nLifeRet = tbFightSetting.nLifeRet;
		self.nLeftSkillId =tbFightSetting.nSkill1;
		self.nRightSkillId =tbFightSetting.nSkill2;
		self.n3SkillId	= tbFightSetting.nSkill3;
		self.n4SkillId	= tbFightSetting.nSkill4;
		self.n5SkillId	= tbFightSetting.nSkill5;
		self.n6SkillId	= tbFightSetting.nSkill6;
		self.nAutoRepair = tbFightSetting.nAutoRepair;
		self.nAutoOpenJiuXiang = tbFightSetting.nAutoOpenJiuXiang;
		self.nAcceptTeam = tbFightSetting.nAcceptTeam;
		self.nAutoDrink	 =tbFightSetting.nAutoDrink;
		self.nPvpMode	 	= tbFightSetting.nPvpMode;
		self.tbLeftMed	 	= tbFightSetting.tbLeftMed;
		self.tbRightMed		= tbFightSetting.tbRightMed;
		self.nAutoRead=tbFightSetting.nAutoRead;
		self.nAutoXLZ=tbFightSetting.nAutoXLZ;
		self.nAutoRead_Move=tbFightSetting.nAutoRead_Move;
		self.nJoin=tbFightSetting.nJoin;
		self.nDead=tbFightSetting.nDead;
		self.nPKfanji = tbFightSetting.nPKfanji;
	end
end

uiAutoFight.OnClose = function(self)
	self.tbObjSkillCont:ClearObj();
	for nPos = 0, 1 do
		local tbObj = self.tbObjMedicamentCont:GetObj(nPos);
		if tbObj and (tbObj.nType == Ui.OBJ_TEMPITEM) then
			self.tbObjMedicamentCont:SetObj(nil, nPos);
			self.tbObjMedicamentCont:DestroyTempItem(tbObj);
		end
	end

	self.tbObjMedicamentCont:ClearObj();
end

uiAutoFight.UpdateSkill = function(self, nLeftSkillId, nRightSkillId, n3SkillId, n4SkillId, n5SkillId, n6SkillId)
	if nLeftSkillId  and  nLeftSkillId > 0 then
		self.nLeftSkillId = nLeftSkillId;
	end

	if nRightSkillId and nRightSkillId >0 then
		self.nRightSkillId = nRightSkillId;
	end

	if n3SkillId and n3SkillId >0 then
		self.n3SkillId = n3SkillId;
	end

	if n4SkillId and n4SkillId >0 then
		self.n4SkillId = n4SkillId;
	end

	if n5SkillId and n5SkillId >0 then
		self.n5SkillId = n5SkillId;
	end

	if n6SkillId and n6SkillId >0 then
		self.n6SkillId = n6SkillId;
	end
	self:UpdateWnd();
end

uiAutoFight.OnChangeFactionFinished = function(self)
	if UiManager:WindowVisible(Ui.UI_AUTOFIGHT) == 1 then
		self:SaveData();
		tbAutoFightData:OnChangeFactionFinished();
		self:OnOpen();
	else
		tbAutoFightData:OnChangeFactionFinished();
	end
end

uiAutoFight.RegisterEvent = function(self)
	local tbRegEvent =
	{
		{ UiNotify.emCOREEVENT_SYNC_ITEM,self.OnSyncItem},
		{ UiNotify.emCOREEVENT_CHANGE_FACTION_FINISHED,	self.OnChangeFactionFinished},
	};
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjSkillCont:RegisterEvent());
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjMedicamentCont:RegisterEvent());
	return tbRegEvent;
end

uiAutoFight.RegisterMessage = function(self)
	local tbRegMsg = {};
	tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbObjSkillCont:RegisterMessage());
	tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbObjMedicamentCont:RegisterMessage());
	return tbRegMsg;
end

uiAutoFight.Save=function(self,szKey, tbData)
	self.m_szFilePath="\\user\\SettingAutoFight\\"..me.szName..tostring(me.nFaction).."_setting.dat";
	self.m_tbData[szKey] = tbData;
	
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KFile.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

uiAutoFight.Load=function(self,key)
	self.m_szFilePath="\\user\\SettingAutoFight\\"..me.szName..tostring(me.nFaction).."_setting.dat";
	self.m_tbData = {};
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if (szData) then
		if self:CheckErrorData(szData) == 1 then		-- TODO: 这里检测一下user目录里是否被因出错写入了非法 userdata数据
			self.m_tbData = Lib:Str2Val(szData);
		else
			KFile.WriteFile(self.m_szFilePath, "");
		end
	end
	local tbData = self.m_tbData[key];
	return tbData
end

uiAutoFight.CheckErrorData=function(self,szDate)
	if szDate ~= "" then
		if string.find(szDate, "Ptr:") and string.find(szDate, "ClassName:") then
			return 0;
		end
		if (not Lib:CallBack({"Lib:Str2Val", szDate})) then	-- 因文件hashid等问题，无法读取到正确的包外文件
			return 0;
		end
	end
	return 1;
end

local uiSkillTree = Ui(Ui.UI_SKILLTREE);
uiSkillTree.OnOpen_Bak = uiSkillTree.OnOpen_Bak or uiSkillTree.OnOpen
uiSkillTree.OnOpen = function(uiSkillTree, szLeftOrRight)
	if szLeftOrRight == "AUTO3SKILL" then
		uiSkillTree.bAutoFightRightSkill = 2;
		uiSkillTree:UpdateSkill();
		uiSkillTree.bAutoFightModel = 1;
	elseif szLeftOrRight == "AUTO4SKILL" then
		uiSkillTree.bAutoFightRightSkill = 3;
		uiSkillTree:UpdateSkill();
		uiSkillTree.bAutoFightModel = 1;
	elseif szLeftOrRight == "AUTO5SKILL" then
		uiSkillTree.bAutoFightRightSkill = 4;
		uiSkillTree:UpdateSkill();
		uiSkillTree.bAutoFightModel = 1;
	elseif szLeftOrRight == "AUTO6SKILL" then
		uiSkillTree.bAutoFightRightSkill = 5;
		uiSkillTree:UpdateSkill();
		uiSkillTree.bAutoFightModel = 1;
	else
		uiSkillTree.OnOpen_Bak(uiSkillTree, szLeftOrRight)
	end
end

uiSkillTree.OnObjSwitch_Bak = uiSkillTree.OnObjSwitch_Bak or uiSkillTree.OnObjSwitch
uiSkillTree.OnObjSwitch = function(uiSkillTree, szWnd, uGenre, uId, nX, nY)
	if uiSkillTree.bAutoFightModel == 1 then
		local nLeftId, nRightId, n3Id, n4Id, n5Id, n6Id;
		if uiSkillTree.bAutoFightRightSkill == 0 then
			nLeftId = uId;
			nRightId = -1;
			n3Id = -1;
			n4Id = -1;
			n5Id = -1;
			n6Id = -1;
			me.Msg(string.format("nskill1=%s",uId));
		elseif uiSkillTree.bAutoFightRightSkill == 1 then
			nLeftId = -1;
			nRightId = uId;
			n3Id = -1;
			n4Id = -1;
			n5Id = -1;
			n6Id = -1;
			me.Msg(string.format("nskill2=%s",uId));
		elseif uiSkillTree.bAutoFightRightSkill == 2 then
			nLeftId = -1;
			nRightId = -1;
			n3Id = uId;
			n4Id = -1;
			n5Id = -1;
			n6Id = -1;
			me.Msg(string.format("nskill3=%s",uId));
		elseif uiSkillTree.bAutoFightRightSkill == 3 then
			nLeftId = -1;
			nRightId = -1;
			n3Id = -1;
			n4Id = uId;
			n5Id = -1;
			n6Id = -1;
			me.Msg(string.format("nskill4=%s",uId));
		elseif uiSkillTree.bAutoFightRightSkill == 4 then
			nLeftId = -1;
			nRightId = -1;
			n3Id = -1;
			n4Id = -1;
			n5Id = uId;
			n6Id = -1;
			me.Msg(string.format("nskill5=%s",uId));
		elseif uiSkillTree.bAutoFightRightSkill == 5 then
			nLeftId = -1;
			nRightId = -1;
			n3Id = -1;
			n4Id = -1;
			n5Id = -1;
			n6Id = uId;
			me.Msg(string.format("nskill6=%s",uId));
		end
		--UiNotify:OnNotify(UiNotify.emUIEVENT_SELECT_SKILL, nLeftId, nRightId);
		uiAutoFight.UpdateSkill(uiAutoFight, nLeftId, nRightId, n3Id, n4Id, n5Id, n6Id);
		UiManager:CloseWindow(Ui.UI_SKILLTREE);
	else
		uiSkillTree.OnObjSwitch_Bak(uiSkillTree, szWnd, uGenre, uId, nX, nY)
	end

end

LoadUiGroup(Ui.UI_AUTOFIGHT, "autofight.ini");