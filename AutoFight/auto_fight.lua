-------------------------------------------------------------------
--File: auto_fight.lua
--Author: luobaohang
--Date: 2009-10-30 19:45:30
--Describe: 挂机脚本
--Date: 23:43 2009-3-31
--Describe: “btssl”
--INDEX: http://www.duowan.com/;http://bbs.duowan.com/
-------------------------------------------------------------------
if not MODULE_GAMECLIENT then
	return
end

Require("\\interface2\\AutoFight\\autofight_setting.lua");

local self = AutoAi;



local OpenJiuXiang = 1;  -- 是否开酒箱
local HuoKai = 0;
local nKpink = 0;
local nCanU = 0;
--此处组队设置已经废弃，请转到耍耍版·系统配置的confirm.lua文件设置

-----------------------------以下信息新手请勿修改--------------------------------

self.bAutoOpenXiulian = 1;		-- 是否自动开启修炼珠，默认开启


self.nX3=3;   			---角色读书时,向右或向左跑开的偏坐标量,若范围比较大,可以将3改小,默认为3个坐标点
self.nY3=3;   			---角色读书时,向上或向下跑开的偏坐标量,若范围比较大,可以将3改小,默认为3个坐标点
self.nJX_Time=20;   	---这里修改金犀修理的耐久条件,数值表示百分比,此时为20%
self.nTalk_on=0;	    ---角色对白开关:1-开启,0-关闭
self.Move_TimeOut=10;   ---移动超时:角色在移动读书时,如果被卡住几秒钟后往反方向跑,默认为10秒
self.life_left = 50;
self.nCounter = 0;
self.nLastLife = 0;
self.nLastMana = 0;
if not self.nLastFood then
	self.nLastFood = 0;
end
self.attack_skill = {}; --攻击技能数组(排前的技能优先使用)
self.auto_fight_pos = {[1] = {}, [2] = {}};	--定点（支持两点来回打怪）
self.attack_point = 1;	-- 1一个定点，2为2个定点
self.auto_pos_index = 0; --第几个定点，等于0则不作定点
self.pick_item_value = 0;
self.eat_life_time = 0;
self.eat_mana_time = 0;
self.auto_move_counter = 0;
self.sleep_counter = 0;
self.no_pick_commonitem = 0;
self.no_mana = 0;
self.ncurmana = 1000;
self.TimeLastFire = 0;
self.TimeLastRead = 0;
self.TimeLastWine = 0;
self.WineUsed = 0; -- 已经喝过的酒
self.bAcceptJoinTeam = 0;
self.bAutoRepair = 0;
self.nPvpMode = 0;
AutoAi.LastRepairTime = 0;
AutoAi.bAutoDrinkWine = 0;
AutoAi.bReleaseUiState = 0;
self.EnhancePick	=0;
self.ObjHuo	=0;
self.ds	=0;
self.ds_move=0;
self.nTime = 5;
self.nRelayTime1 =60;
self.nRelayTime2 =60;
self.nSec0=0;
self.nSec1=0;
self.nSec2=0;
self.nSec3=0;
self.nSec4=0;
self.nSec5=0;
self.nSec6=0;
self.nYe1=0;
self.nYe2=0;
self.nYe3=0;
self.nYe4=0;
self.nYe5=0;
self.nYe6=0;
self.nX1=0;
self.nY1=0;
self.TimeLost=0;
self.IsRead=0;
self.BookNum=0;
self.Move_Time=0;
self.read_now=0;
----------
-- 默认设置
self.tbAutoAiCfg = {
	nAutoFight = 0,
	nUnPickCommonItem = 0,
	nPickValue = 0,
	nLifeRet = 50,
	nSkill1 = 0,
	nSkill2 = 0,
	nSkill3			= 0,
	nSkill4			= 0,
	nSkill5			= 0,
	nSkill6			= 0,
	nAutoRepair = 0,
	nAutoOpenJiuXiang = self.nAutoOpenJiuXiang,
	nAcceptTeam = 0,
	nAutoDrink = 0,
	nPvpMode = 0,
	nAutoObjHuo	=self.ObjHuo,
	nAutoRead=self.ds,
	nAutoRead_Move=self.ds_move,
};

local nWuXingSkill ={283,285,287,289,291};

local nLSkill = {
[0]  = {};    -- 无门派
[1]  = {27,24,21,36,33,29};  -- 少林
[2]  = {47,43,38,56,53,50};         -- 天王
[3]  = {66,62,59,72,69};  -- 唐门
[4]  = {83,80,76,93,90,86};  -- 五毒
[5]  = {107,103,99,96};  -- 峨嵋
[6]  = {125,123,120,117,114,111}; -- 翠烟
[7]  = {134,131,128,845,141,140,137}; -- 丐帮
[8]  = {156,151,149,146,143}; -- 天忍
[9]  = {165,162,159,171,169,167}; -- 武当 
[10]  = {188,181,178,175};  -- 昆仑
[11]  = {205,208,211,202,194,198}; -- 明教
[12]  = {232,229,226,223,217,213}; -- 大理
[13]  = {2805,2804,2803,2825,2823,2821}; -- 古墓
--[14]  = {3053,3047,3041,3033,3028,3015,3013}; -- 逍遥
};

function AutoAi:UpdateCfg(tbAutoAiCfg)
	AutoAi.ProcessHandCommand("auto_fight", tbAutoAiCfg.nAutoFight);
	self.pick_item_value = tbAutoAiCfg.nPickValue * 2;
	self.life_left = tbAutoAiCfg.nLifeRet;
	self.no_pick_commonitem = tbAutoAiCfg.nUnPickCommonItem;
	self.attack_skill[1] = tbAutoAiCfg.nSkill1;
	self.attack_skill[2] = tbAutoAiCfg.nSkill2;
	self.attack_skill[3] = tbAutoAiCfg.nSkill3;
	self.attack_skill[4] = tbAutoAiCfg.nSkill4;
	self.attack_skill[5] = tbAutoAiCfg.nSkill5;
	self.attack_skill[6] = tbAutoAiCfg.nSkill6;
	--self.bAutoOpenJiuXiang = tbAutoAiCfg.nAutoOpenJiuXiang;
	self.bAutoRepair = tbAutoAiCfg.nAutoRepair;
	self.bAcceptJoinTeam = tbAutoAiCfg.nAcceptTeam;
	self.bAutoDrinkWine = tbAutoAiCfg.nAutoDrink;
	self.nPvpMode = tbAutoAiCfg.nPvpMode;
	self.ObjHuo = tbAutoAiCfg.nAutoObjHuo;
	self.ds	= tbAutoAiCfg.nAutoRead;
	self.ds_move=tbAutoAiCfg.nAutoRead_Move;
	self.EnhancePick = tbAutoAiCfg.nAutoEnhancePick;
end

function AutoAi:IsAcceptJoinTeam()
	return self.bAcceptJoinTeam;
end

function AutoAi:KaiJiuXiang()
	if OpenJiuXiang == 0 then
		OpenJiuXiang = 1
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=yellow>Tự mở rương lấy rượu<color>");
	else
		OpenJiuXiang = 0
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Tắt mở rương lấy rượu<color>");
	end
end

function AutoAi:KaiHuo()
	if HuoKai  == 0 then
		HuoKai = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=yellow>Tự dùng TLC<color>");
	else
		HuoKai = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Tắt dùng TLC<color>");
	end
end

function AutoAi:CalcRang()	
	if (self.attack_point == 2) then
		local a = self.auto_fight_pos[1].x;
		local b = self.auto_fight_pos[1].y;
		local c = self.auto_fight_pos[2].x;
		local d = self.auto_fight_pos[2].y;
		if (a and b and c and d)then
			return math.sqrt((a-c) * (a-c) + (b-d) * (b-d)) + self.ACTIVE_RADIUS;
		end
	end
	return 0;
end

function AutoAi:Kpink()
	if nKpink == 0 then
		nKpink = 1
		AutoAi.ProcessHandCommand("auto_pick", 1);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Nhặt đồ nhanh Ctrl+Q");
		
	else
		nKpink = 0
		AutoAi.ProcessHandCommand("auto_pick", me.nAutoFightState);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=BLUE><color=white>Tắt nhặt đồ Ctrl+Q");
	end
end
-- 当捡到篝火时，程序会调用脚本"AutoAi:Gotgouhuo"
function AutoAi:GotGouhuo()
	AutoAi:Pause();
	self.TimeLastFire = GetTime();
	Timer:Register(Env.GAME_FPS * 8, self.DelayResumeAi, self); -- 防止篝火脚本忘了写AutoAi:Resume()
end

function AutoAi:BookInfo()

    if me.nLevel >= 80 and me.nLevel < 110 then

	local tbFind = me.FindItemInBags(20,1,298,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe1=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec1 = Lib:GetDate2Time(nCanDate) + self.nRelayTime1;
		end
	end

	local tbFind = me.FindItemInBags(20,1,299,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe2=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec2 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end

    end



    if me.nLevel >= 110 and me.nLevel < 130 then

	local tbFind = me.FindItemInBags(20,1,544,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe3=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec3 = Lib:GetDate2Time(nCanDate) + self.nRelayTime1;
		end
	end

	local tbFind = me.FindItemInBags(20,1,545,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe4=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec4 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end

    end


    if me.nLevel >= 130 then

	local tbFind = me.FindItemInBags(20,1,809,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe5=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec5 = Lib:GetDate2Time(nCanDate) + self.nRelayTime1;
		end
	end

	local tbFind = me.FindItemInBags(20,1,810,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe6=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec6 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end

    end

	return 1;
end

function AutoAi:Read_book_szbf()
	if me.nLevel >= 80 and me.nLevel < 110 then
		local nBingShuCount = Task.tbArmyCampInstancingManager:GetBingShuReadTimesThisDay(me.nId);
		if (nBingShuCount >= 1) then
			return 1;
		else
			local tbFind = me.FindItemInBags(20,1,298,1);
			for j, tbItem in pairs(tbFind) do
					AutoAi:Pause();
					me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);
					me.UseItem(tbItem.pItem);

					
					if self.nTalk_on==1 then
						me.Msg(string.format("<color=0,255,255>%s<color>",me.szName));
					end
					self.BookNum=1;
					Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
					break;
				--end
			end
		end
	end
end
function AutoAi:Read_book_mjjgs()
	if me.nLevel >= 80 and me.nLevel < 110 then
		local nJiGuanShuCount = Task.tbArmyCampInstancingManager:JiGuanShuReadedTimesThisDay(me.nId);
		if (nJiGuanShuCount >= 1) then
			return 1;
		else
			local tbFind = me.FindItemInBags(20,1,299,1);
			for j, tbItem in pairs(tbFind) do
					AutoAi:Pause();
					me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);
					me.UseItem(tbItem.pItem);

				
					if self.nTalk_on==1 then
						me.Msg(string.format("<color=0,255,255>%s<color>",me.szName));
					end
					self.BookNum=2;
					Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
					break;
				--end
			end
		end
	end
end
function AutoAi:Read_book_ggds()
	if me.nLevel >= 110 and me.nLevel < 130 then
			local tbFind = me.FindItemInBags(20,1,545,1);
			for j, tbItem in pairs(tbFind) do
				AutoAi:Pause();
				me.UseItem(tbItem.pItem);
				me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);

				
				if self.nTalk_on==1 then
					me.Msg(string.format("<color=0,255,255>%s<color>",me.szName));
					me.Msg(string.format("<color=0,255,255>%s<color>",me.szName) .." - -!");
				end
				self.BookNum=4;
				Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
				break;
			--end
		end
	end
end
function AutoAi:Read_book_wmys()
	if me.nLevel >= 110 and me.nLevel < 130 then
		local tbFind = me.FindItemInBags(20,1,544,1);
		for j, tbItem in pairs(tbFind) do
				AutoAi:Pause();
				me.UseItem(tbItem.pItem);
				me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);
			
				if self.nTalk_on==1 then
					me.Msg(string.format("<color=0,255,255>%s<color>",me.szName));
				
				end
				self.BookNum=3;
				Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
				break;
			--end
		end
	end
end
-----------------------以下阿呆添加测试130读书----------------
function AutoAi:Read_book_bfsslj()
	if (me.nLevel >= 130) then
			local tbFind = me.FindItemInBags(20,1,809,1);
			for j, tbItem in pairs(tbFind) do
				AutoAi:Pause();
				me.UseItem(tbItem.pItem);
				me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);
			
				if self.nTalk_on==1 then
					me.Msg(string.format("<color=0,255,255>%s<color>",me.szName) .." - -!");
				end
				self.BookNum=5;
				Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
				break;
			--end
		end
	end
end
function AutoAi:Read_book_qym()
	if (me.nLevel >= 130) then
		local tbFind = me.FindItemInBags(20,1,810,1);
		for j, tbItem in pairs(tbFind) do
				AutoAi:Pause();
				me.UseItem(tbItem.pItem);
				me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);
			
				if self.nTalk_on==1 then
					me.Msg(string.format("<color=0,255,255>%s<color>",me.szName));
	
				end
				self.BookNum=6;
				Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
				break;
			--end
		end
	end
end
function AutoAi:DrinkWine()
	for i,tbWine in pairs(self.WINES) do
		local tbFind = me.FindItemInBags(unpack(tbWine));
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			self.TimeLastWine = GetTime();
			return 1;
		end
	end
end

-- 自动修理
function AutoAi:AutoRepair()
	if self.bAutoRepair ~= 1 then
		return;
	end
	if AutoAi.LastRepairTime + 60 > GetTime() then		-- 每1分钟检查一次是不是要修
		return 0;
	end
	local tbItemIndex = {};
	for i = 0, Item.EQUIPPOS_NUM - 1 do
		local pItem = me.GetItem(Item.ROOM_EQUIP,i,0)
		if pItem and pItem.nCurDur < Item.DUR_MAX / 5 then -- 低于20%耐久就修
			for nLevel, tbJinxi in pairs(self.JINXI) do
				local tbFind = me.FindItemInBags(unpack(tbJinxi));
				for _, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
					self.bReleaseUiState = 1;
   					table.insert(tbItemIndex, pItem.nIndex);
   				end
			end
		end
	end
	me.RepairEquipment(3, #tbItemIndex, tbItemIndex);
	self.LastRepairTime = GetTime();
	Timer:Register(Env.GAME_FPS * 1, self.DelayCloseRepairWnd, self);
end

-- 修理完成后手动关闭 金犀修理窗口
function AutoAi:DelayCloseRepairWnd()
	if self.bReleaseUiState == 1 then
		UiManager:ReleaseUiState(UiManager.UIS_ITEM_REPAIR);
		--UiManager:CloseWindow(Ui.UI_PLAYERPANEL);
		self.bReleaseUiState = 0;
	end

	return 0;
end


-- 自动开酒箱
function AutoAi:AutoOpenJiuXiang()
	if OpenJiuXiang == 0 then
		return;
	end
	local nSkillLevel,nStateType,nEndTime = me.GetSkillState(378);	--酒状态
	if nEndTime and nEndTime > 0 then
--		me.Msg("已经开了酒箱");
		return 0;
	end
	local nSkillLevel = me.GetSkillState(self.FIRE_SKILL_ID);
	if not(nSkillLevel and nSkillLevel > 0) then
--		me.Msg("没火");
		return;
	end
--	me.Msg("自动开酒箱")
	AutoAi:OpenJiuXiang1();
end

function AutoAi:OpenJiuXiang1()
	local tbItem = me.FindItemInBags(18, 1, 189, 1)[1] or me.FindItemInBags(18, 1, 189, 2)[1];
	if not tbItem then
		return;
	end
	local nJiusl = me.GetItemCountInBags(18,1,48,1);
	if nJiusl >= 1 then
		return;
	end
	local pItem = tbItem.pItem;
	local nRemain = pItem.GetExtParam(1) - pItem.GetGenInfo(1);		-- 剩余酒量
	local num = 1;
	if nRemain < num then
		num = nRemain;
	end
	if me.CountFreeBagCell() < num then
		num = me.CountFreeBagCell();
	end
--	me.Msg("remain:"..nRemain.." num:"..num);
	if num <= 0 then
		return ;
	end
	me.UseItem(pItem);
	local function fnselect()
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			me.AnswerQestion(0);	--0为西北旺，1为稻花香，2为女儿红,3为杏花村,4为烧刀子
			local function fninput()
				if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
					me.CallServerScript({ "DlgCmd", "InputNum", tonumber(num) });
					UiManager:CloseWindow(Ui.UI_TEXTINPUT);
					return 0;
				end
			end
			Timer:Register(Env.GAME_FPS * 0.2, fninput);
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			return 0;
		end
	end
	Timer:Register(Env.GAME_FPS * 0.3, fnselect);
end

-- 防止没有收到点燃篝火的消息造成ai锁死
function AutoAi:DelayResumeAi()
	if self.TimeLastFire + 5 <= GetTime() then
		AutoAi.LockAi(0);
	end
	return 0;
end
function AutoAi:OutReadAi()
	if self.TimeLastRead + 3 <= GetTime() then
		AutoAi:BookInfo();
		AutoAi.AiAutoMoveTo(self.auto_fight_pos[1].x,self.auto_fight_pos[1].y);
		AutoAi.LockAi(0);
		self.IsRead=0;
		self.read_now=0;
	end
	return 0;
end

-- 自动喝酒
function AutoAi:AutoDrinkWine()
	if self.bAutoDrinkWine ~= 1 then
		return;
	end
	local nSkillLevel,nStateType,nEndTime,bIsNoClearOnDeath = me.GetSkillState(self.WINE_SKILL_ID);
	if nSkillLevel and nSkillLevel > 0 and nEndTime and nEndTime > 0 and
		self.TimeLastWine + self.TIME_WINE_EFFECT > GetTime() then
		return 0;
	else
		local nSkillLevel,nStateType,nEndTime,bIsNoClearOnDeath = me.GetSkillState(self.FIRE_SKILL_ID);
		if nSkillLevel and nSkillLevel > 0 then
			AutoAi:DrinkWine();
		end
	end
end

-- 自动开修炼珠
function AutoAi:AutoOpenXiuLian()
	if self.bAutoOpenXiulian ~= 1 then
		--me.Msg('not auto open xiulianzhu')
		return;
	end
	local nSkillLevel,nStateType,nEndTime = me.GetSkillState(332);
	if nEndTime and nEndTime > 0 then
		--me.Msg('已经开了修炼珠');
		return 0;
	end
	local nSkillLevel = me.GetSkillState(self.FIRE_SKILL_ID);
	if not(nSkillLevel and nSkillLevel > 0) then
		--me.Msg("没火");
		return;
	end
	--me.Msg('自动开修炼珠')
	AutoAi:OpenXiuLian();
end

function AutoAi:Pause()
	AutoAi.LockAi(1);
end

function AutoAi:Resume(nStatus)
	AutoAi.LockAi(0);
	if nStatus == self.RESUME_GOUHUO_FIRED then
		self.TimeLastFire = GetTime();
		AutoAi:AutoDrinkWine();
	end
end

-- 切换技能
function AutoAi:ChangeSkill()
	local function SwitchHorseBySkill(nSkillId)
		local nLevel = me.GetNpc().GetFightSkillLevel(nSkillId);
		if nLevel == 0 then
			return
		end
		local tbS = KFightSkill.GetSkillInfo(nSkillId, -1);
		if not(tbS) then
			return
		end;
		if tbS.nHorseLimited == 1 and me.GetNpc().IsRideHorse() == 1 then
			Switch("horse")
		end
		if tbS.nHorseLimited == 2 and me.GetNpc().IsRideHorse() == 0 then
			Switch("horse")
		end
	end
	for _, nSkillId in ipairs(self.attack_skill) do
		SwitchHorseBySkill(nSkillId);
		if (AutoAi.GetSkillCostMana(nSkillId) > self.ncurmana) then
			self.no_mana = 1;
		end
		if (me.CanCastSkill(nSkillId) == 1) and (me.CanCastSkillUI(nSkillId) == 1) then
			AutoAi.SetActiveSkill(nSkillId, self.MAX_SKILL_RANGE);
			return;
		end
	end
	-- 默认用左键技能
	SwitchHorseBySkill(me.nLeftSkill)
	if (me.CanCastSkill(me.nLeftSkill) == 1) then
		AutoAi.SetActiveSkill(me.nLeftSkill, self.MAX_SKILL_RANGE);
	end;
end

--初始化活动范
function AutoAi:InitKeepRange()
	local x,y = me.GetNpc().GetMpsPos();
	-- 现在只需保持活动范围，两个定点都设为同一点
	self.auto_fight_pos[1].x = x;
	self.auto_fight_pos[1].y = y;
	self.auto_fight_pos[2].x = x;
	self.auto_fight_pos[2].y = y;
	self.keep_range = self:CalcRang();
	self.auto_pos_index = 1;	--只要设定定点，就把这个设为1
end

function AutoAi:AI_InitAttack(nAttack)
self.nSec0=0;
self.nSec1=0;
self.nSec2=0;
self.nSec3=0;
self.nSec4=0;
self.nSec5=0;   ---阿呆添加测试
self.nSec6=0;   ---阿呆添加测试
self.nYe1=0;
self.nYe2=0;
self.nYe3=0;
self.nYe4=0;
self.nYe5=0;    ---阿呆添加测试
self.nYe6=0;    ---阿呆添加测试
self.nX1=0;
self.nY1=0;
self.TimeLost=0;
self.IsRead=0;
self.BookNum=0;
self.read_now=0;
self.Move_Time=0;
	AutoAi:BookInfo();
	AutoAi.LockAi(0); -- 解锁
	if (nAttack == 1) then
		Log:Ui_SendLog("Tự Động Đánh Quái", 1);
		self:ChangeSkill();
		-- 锁定打怪目标(防止乱跑)清除目标后再以当前点为定点保持活动范围
		if (nTargetIndex == 1) then
			AutoAi.LockAi(nTargetIndex);
		else
			self:InitKeepRange();
		end
		me.AddSkillEffect(self.HEAD_STATE_SKILLID);
		local x,y = me.GetNpc().GetMpsPos();
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
		
		--print("AutoAi- Start Attack");
		--自动下马,如果需要的话
		local tbSkillInfo	= KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
		if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then	-- 此技能必须下马，且当前在马上
			Switch("horse");	-- 下马
		end

	else
		me.RemoveSkillEffect(self.HEAD_STATE_SKILLID);
		
		--print("AutoAi- Stop Attack");
	end
	if nKpink == 0 then
  	      AutoAi.ProcessHandCommand("auto_pick", nAttack);
	end
	AutoAi.ProcessHandCommand("auto_drug", nAttack);
end

--------------------------------------------------------------------------------------------------------

function AutoAi:Reading_one()

	local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	self.nSec0 = Lib:GetDate2Time(nDate);
	if self.nSec0 > self.nSec1 and self.nYe1<10 and (me.nLevel >= 80 and me.nLevel < 110) then
		local tbFind = me.FindItemInBags(20,1,298,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();

			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then
				if nX2<(self.nX1+256*(self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
						
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_szbf();
				end
			else
				if nX2>self.nX1-256*(self.nX3-1) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_szbf();
				end
			end
		end
	end

	if self.nSec0 > self.nSec2 and self.nYe2<10 and (me.nLevel >= 80 and me.nLevel < 110) then
		local tbFind = me.FindItemInBags(20,1,299,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();

			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then
				if nX2<(self.nX1+256*(self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
						
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_mjjgs();
				end
			else-- self.IsRead<0 then
				if nX2>self.nX1-256*(self.nX3-1) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_mjjgs();
				end
			end
		end
	end

	if self.nSec0 > self.nSec3 and self.nYe3<10 and (me.nLevel >= 110 and me.nLevel < 130) then
		local tbFind = me.FindItemInBags(20,1,544,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();
				--self.nX1=self.nX1+256*self.nX3;
			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then
			--me.Msg("-->");
				if nX2<(self.nX1+256*(self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then

					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
					
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_wmys();
				end
			else--if self.IsRead<0 then
				if nX2>self.nX1-256*(self.nX3-1) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_wmys();
				end
			end
		end
	end
	--me.Msg(string.format("%d,%d,%d",self.nSec0,self.nSec4,self.nYe4));
	if self.nSec0 > self.nSec4 and self.nYe4<10 and (me.nLevel >= 110 and me.nLevel < 130) then
	--me.Msg("-->");
		local tbFind = me.FindItemInBags(20,1,545,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();
				--self.nX1=self.nX1+256*self.nX3;
			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then
			--me.Msg("--->");
				if nX2<(self.nX1+(256*self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
				--me.Msg("---->");
					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
					
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_ggds();
				end
			else--if self.IsRead<0 then
				if nX2>self.nX1-(256*self.nX3-1) and  (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_ggds();
				end
			end
		end
	end
--------------------------------------130书阿呆测试添加---------------
	if self.nSec0 > self.nSec5 and self.nYe5<10 and me.nLevel >= 130 then
		local tbFind = me.FindItemInBags(20,1,809,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();
				--self.nX1=self.nX1+256*self.nX3;
			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then

				if nX2<(self.nX1+256*(self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then

					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
					
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_bfsslj();
				end
			else--if self.IsRead<0 then
				if nX2>self.nX1-256*(self.nX3-1) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_bfsslj();
				end
			end
		end
	end

	if self.nSec0 > self.nSec6 and self.nYe6<10 and me.nLevel >= 130 then

		local tbFind = me.FindItemInBags(20,1,810,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();
				--self.nX1=self.nX1+256*self.nX3;
			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then

				if nX2<(self.nX1+(256*self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then

					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
					
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_qym();
				end
			else--if self.IsRead<0 then
				if nX2>self.nX1-(256*self.nX3-1) and  (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_qym();
				end
			end
		end
	end

end

function AutoAi:Reading_two()
	local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	self.nSec0 = Lib:GetDate2Time(nDate);
	if self.nSec0 > self.nSec1 and self.nYe1<10 and (me.nLevel >= 80 and me.nLevel < 110) then
		local tbFind = me.FindItemInBags(20,1,298,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_szbf();
			end
		end
	end

	if self.nSec0 > self.nSec2 and self.nYe2<10 and (me.nLevel >= 80 and me.nLevel < 110) then
		local tbFind = me.FindItemInBags(20,1,299,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_mjjgs();
			end
		end
	end

	if self.nSec0 > self.nSec3 and self.nYe3<10 and (me.nLevel >= 110 and me.nLevel < 130) then
		local tbFind = me.FindItemInBags(20,1,544,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_wmys();
			end
		end
	end

	if self.nSec0 > self.nSec4 and self.nYe4<10 and (me.nLevel >= 110 and me.nLevel < 130) then
		local tbFind = me.FindItemInBags(20,1,545,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_ggds();
			end
		end
	end
	------------以下阿呆添加130读书测试----
	if self.nSec0 > self.nSec5 and self.nYe5<10 and me.nLevel >= 130 then
		local tbFind = me.FindItemInBags(20,1,809,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_bfsslj();
			end
		end
	end

	if self.nSec0 > self.nSec6 and self.nYe6<10 and me.nLevel >= 130 then
		local tbFind = me.FindItemInBags(20,1,810,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_qym();
			end
		end
	end
	return 1;
end

-----------------------------------------------------------------------------

function AutoAi:AI_Normal(nFightMode, nCurLife, nCurMana, nMaxLife, nMaxMana) --Tự Động Đánh Quái时每1/6秒执行
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		--进度条，什么也不做
		return
	end
	-- 检查点斗状态
	if nFightMode == 0 then
		me.AutoFight(0);
		return;
	end
	AutoAi:AutoDrinkWine();
	AutoAi:AutoRepair();
	self.ncurmana = nCurMana;
	local nCurTime = GetTime();
	self.nCounter = self.nCounter + 1; --计时器
	--快死亡了就回城
	if (nCurLife * 100 / nMaxLife < self.LIFE_RETURN) then
		--AutoAi.ReturnCity();
		if self.nPvpMode == 0 then
			--AutoAi.Flee(); -- 逃跑
			----print("AutoAi- Flee...");
		end
	end

	if Ui.tbWnd[Ui.UI_AUTODADAO].nWantedState == 1 then
		self.ACTIVE_RADIUS = 370
		self.ATTACK_RANGE = 370
	elseif Ui(Ui.UI_SERVERSPEED).nFollowState ~= 0 or Map.tbAutoAim.nFollowState ~= 0 then
		if me.nFaction == 1 or me.nFaction == 2 or (me.nFaction == 3 and me.nRouteId == 1) or (me.nFaction == 6 and me.nRouteId == 2) or (me.nFaction == 8 and me.nRouteId == 1) or (me.nFaction == 9 and me.nRouteId == 2) or (me.nFaction == 11 and me.nRouteId == 1) or (me.nFaction == 12 and me.nRouteId == 1) then
			self.ACTIVE_RADIUS = 580
			self.ATTACK_RANGE = 550
		else
			self.ACTIVE_RADIUS = 660
			self.ATTACK_RANGE = 600
		end
	else
		self.ACTIVE_RADIUS = 800		--检测敌人的距离		--可以自行修改
		self.ATTACK_RANGE = 800			--自身挂机范围		--可以自行修改
	end

	local nM = me.nTemplateMapId
	if self.nPvpMode == 0 and nM > 297 then
		local nDD = Ui.tbWnd[Ui.UI_TBMPGUA].nState
		local nGS = Ui(Ui.UI_SERVERSPEED).nFollowState
		local nKT = Map.tbAutoAim.nFollowState
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 35);
		for _, pNpc in ipairs(tbAroundNpc) do
			local szName = pNpc.szName;
			if string.find(szName,"U Minh Lang Vương")
				or pNpc.nTemplateId == 3146
				or pNpc.nTemplateId == 3149
				or pNpc.nTemplateId == 3152
				or pNpc.nTemplateId == 3157
				or pNpc.nTemplateId == 3177
				or pNpc.nTemplateId == 3193
				or pNpc.nTemplateId == 3277
				or pNpc.nTemplateId == 6939
				or (pNpc.nTemplateId == 4212 and ((me.nFaction == 8 and me.nRouteId == 2) or (me.nFaction == 11 and me.nRouteId == 2) or (me.nFaction == 9 and me.nRouteId == 1) or (me.nFaction == 10 and me.nRouteId == 2) or (me.nFaction == 4 and me.nRouteId == 2)))
			then
				if (pNpc.nDoing ~= 10 and pNpc.nDoing ~= 20 and pNpc.nKind ~= 1) then
					AutoAi.SetTargetIndex(pNpc.nIndex);
				end
				break
			end
		end
	end

	if (math.mod(self.nCounter, 18) == 0) and HuoKai == 1 then   -- 3秒检测一次
        	AutoAi:AutoOpenXiuLian();               
	end

	if (math.mod(self.nCounter, 18) == 0) then
		AutoAi:AutoOpenJiuXiang()
	end

	if (math.mod(self.nCounter, 12) == 0) then
		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
			return;
		end
		if self.nPvpMode == 1 then
			return;
		end
		local bChecked = me.GetNpc().IsRideHorse();
		local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
		if (tbSkillInfo.nHorseLimited == 1 and bChecked == 1) then
			Switch([[horse]]);		--马
		end
	end

	--三少纠正怒气攻击影响
	if (math.mod(self.nCounter, 90) == 0) then
		local nLeft = me.nLeftSkill;
		for _, nSkillId in ipairs(nWuXingSkill) do
			if nLeft == nSkillId then --正在用怒气攻击
				if me.CanCastSkill(nSkillId) ~= 1 then--怒已经释放完却未换回左键技能
					for _, nTskill in ipairs(nLSkill[me.nFaction]) do
						if me.IsHaveSkill(nTskill) == 1 then
							me.nLeftSkill = nTskill;
							return;
						end
					end
				end
			end
		end
	end

	local nMapId	= me.nTemplateMapId;
	if not ((nMapId >= 298 and nMapId <= 332) or (nMapId == 273)) then
		if (math.mod(self.nCounter, 6) == 0) and Map.tbAutoAim.nFollowState == 0 and Ui(Ui.UI_SERVERSPEED).nFollowState == 0 then
			if self.ds_move==1 and self.read_now==0 then
				if self.IsRead~=0 then
						self.Move_Time = GetTime();
						self.Move_Time=self.Move_Time+1;
					if math.mod(self.Move_Time,self.Move_TimeOut)==0 then
						self.IsRead=0-self.IsRead;
						self.Move_Time=0;
						
					end
				end
			end
			if self.ds_move==1 then
				self:Reading_one();
			end
		end
	end
	--血不够就补血
	if self.life_left ~= nil then
		if (nCurLife * 100 / nMaxLife < self.life_left) then
			if (self.nCounter - self.eat_life_time > self.EAT_SLEEP) then
				if (AutoAi.Eat(1) == 0) then
					AutoAi.ReturnCity();
					--print("AutoAi- No Red Drug...");
				else
					AutoAi.Eat(1);
				end
				self.eat_life_time = self.nCounter;
			end
		end
	end
	--内不够的时候就喝内
	local bNoMana = nCurMana * 100 / nMaxMana < self.MANA_LEFT;
	if (bNoMana or self.no_mana == 1) then
		if (self.nCounter - self.eat_mana_time > self.EAT_SLEEP) then
			self.no_mana = 0;
			if AutoAi.Eat(2) == 0 then
				--print("AutoAi- No Blue Drug...");
				AutoAi.ReturnCity();
			end
			self.eat_mana_time = self.nCounter;
		end
	end
	-- 检查吃食物
	if (bNoMana or nCurLife * 100 / nMaxLife < 80) then
		if me.IsCDTimeUp(3) == 1 and 0 == AutoAi.Eat(3) then	-- 先吃短效食物
			local nLevel, nState, nTime = me.GetSkillState(self.FOOD_SKILL_ID);
			if (not nTime or nTime < 36) then
				self.nLastFood = nCurTime;
				if 0 == AutoAi.Eat(4) then -- 长效食物
					--print("AutoAi- No Food...");
				end
			end
		end
	end
	--每隔2秒左右判断执行辅助技能，原来是1秒
	if (math.mod(self.nCounter, 12) == 0) then
		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
			--进度条，什么也不做
			return;
		end
		local nSelfIndex = AutoAi.GetSelfIndex();
		for _, nSkillId in ipairs(self.ASSIST_SKILL_LIST[me.nFaction]) do
			local nTempSkillId = (nSkillId == 836) and 873 or nSkillId;--掌峨开836得到的始终是873...
			local nLevel, nState, nTime = me.GetSkillState(nTempSkillId);
			local tbSkillInfo = KFightSkill.GetSkillInfo(nSkillId, -1);
			--不自动释放被动技能,光环技能,技能本身持续时间很短的技能
			local bCanUse = 1;

			if tbSkillInfo then 
				if nSkillId == 497 and me.CanCastSkill(497) == 1 and me.nFaction == 9 and me.nRouteId == 1 then
				
				else
					if(tbSkillInfo.nSkillType ==1) or (tbSkillInfo.nSkillType ==3) or (tbSkillInfo.IsAura == 1) or (tbSkillInfo.nStateTime <= 18) then
						bCanUse = 0;
					end
				end
			end

			if bCanUse == 0 then
				break;
			end

			if ((not nTime or nTime < 36) and me.CanCastSkill(nSkillId) == 1) then
				if (AutoAi.GetSkillCostMana(nSkillId) > nCurMana) then
					self.no_mana = 1;
					break;
				end

				if nSkillId == 497 and me.GetNpc().nDoing == Npc.DO_SIT or nCanU == 1  or me.nTemplateMapId == 343 then
					break;
				end

				local nMyMapId, nMyPosX, nMyPosY	= me.GetWorldPos();
				if nSkillId == 78 or nSkillId == 850 then
					if (me.nTemplateMapId ==557 and nMyPosY < 3780) or UiManager.bstart == 1 or UiManager.bgua == 1 then
						break;
					end
				end

				if nSkillId == 497 then
					if me.nAutoFightState == 1 then
						AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
					end

					UseSkill(497)
					nCanU = 1
					local function myopenD()
						if (me.nAutoFightState ~= 1) then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
							return 0;
						else
							return 0;
						end
					end
					local function CanUse()
						nCanU = 0
						return 0;
					end
					Ui.tbLogic.tbTimer:Register(22, myopenD);
					Ui.tbLogic.tbTimer:Register(540, CanUse);
					return 0;
				else
					AutoAi.AssistSelf(nSkillId);
				end
				self.sleep_counter = 3;
				break;
			end
		end
		AutoAi:ChangeSkill()
	end
	if (math.mod(self.nCounter, 360) == 0) then	--1分钟刷新下入队设置
		Ui(Ui.UI_TEAM):LoadConfig()
	end
end

function AutoAi:AutoFight() --Tự Động Đánh Quái脚本
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		--进度条，什么也不做
		return;
	end
	if self.IsRead~=0 then
		return 1;
	end

	if(me.nRunSpeed == 0) then
		return;
	end

	if (self.sleep_counter > 0) then
		self.sleep_counter = self.sleep_counter - 1;
		return;
	end
	if self.nPvpMode == 1 then
		return;
	end
	local nTargetIndex = 0;
	if self.auto_move_counter <= 0 then
		nTargetIndex = AutoAi.AiFindTarget();
		--注意保持在自已的活动范围内
		if (nTargetIndex > 0 and self.KEEP_RANGE_MODE == 1 and self.auto_pos_index > 0) then
			local cNpc = KNpc.GetByIndex(nTargetIndex);
			local x,y,world = cNpc.GetMpsPos();
			local dx = x - self.auto_fight_pos[self.auto_pos_index].x;
			local dy = y - self.auto_fight_pos[self.auto_pos_index].y;
			if (dx and dy)then
				--如果两定点距离大于self.attack_range则逐渐逼近self.ATTACK_RANGE
				if (self.keep_range and self.keep_range > self.ATTACK_RANGE)then
					self.keep_range = self.keep_range - 50;
				else
					self.keep_range = self.ATTACK_RANGE;
				end
				if (dx * dx + dy * dy > self.keep_range * self.keep_range)then
					nTargetIndex = 0;
				end
			end
		end
		if (nTargetIndex <= 0 and self.auto_pos_index > 0)then
			self.auto_move_counter = 0;
		end
	else
		self.auto_move_counter = self.auto_move_counter - 1;
	end
	if (nTargetIndex > 0) then
		AutoAi.SetTargetIndex(nTargetIndex);
		--print("AutoAi- Set Target", nTargetIndex);

		self:ChangeSkill();
	else
		if self.auto_pos_index <= 0 then
			--print("AutoAi- Auto Move...");
			AutoAi.AiAutoMove();
		else
			local nx = self.auto_fight_pos[self.auto_pos_index].x;
			local ny = self.auto_fight_pos[self.auto_pos_index].y;
			if (nx == nil or ny == nil) then
				self.auto_pos_index = 0;
				return;
			end
			local x,y,world = me.GetNpc().GetMpsPos();
			local dx = x - nx;
			local dy = y - ny;
			if (self.attack_point == 1) then
				-- 在定点范围外走向定点
				if (dx * dx + dy * dy > self.ATTACK_RANGE * self.ATTACK_RANGE * 0) then
					AutoAi.AiAutoMoveTo(nx, ny);
					--print("AutoAi- Auto Move To", nx, ny);
					return;
				else
					AutoAi.Sit();
					if self.ds==1 then
						local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
						self.nSec0 = Lib:GetDate2Time(nDate);
						if (self.nSec0 > self.nSec1 and self.nYe1<10) or (self.nSec0 > self.nSec2 and self.nYe2<10) or (self.nSec0 > self.nSec3 and self.nYe3<10) or (self.nSec0 > self.nSec4 and self.nYe4<10) or (self.nSec0 > self.nSec5 and self.nYe5<10) or (self.nSec0 > self.nSec6 and self.nYe6<10) then
							AutoAi:Reading_two();
						end
					end

				end
			elseif (self.attack_point == 2) then
				if (AutoAi.AiAutoMoveTo(nx, ny) <= 0) then
					self.keep_range = self:CalcRang();
					-- 转向另一点
					if (self.auto_pos_index == 1)then
						self.auto_pos_index = 2;
					else
						self.auto_pos_index = 1;
					end
				end
			end
		end

	end
end

function AutoAi:CheckItemPickable()
	local nNeededMagic = AutoAi:GetNeededMagicStatus(it);
	local nNeededDarkMagic = AutoAi:GetNeededDarkMagicStatus(it);
	if nNeededMagic == 1 or nNeededDarkMagic == 1 then 		--有设定的明,暗属性保留
		return 1;
	end
       --非蓝白装都捡
	if it.nGenre > 16 then
		if self.no_pick_commonitem ~= 1 then
			--print("AutoAi- Pick Item", it.szName);
			return 1;
		end
		return 0;
	end
		--print("AutoAi- Equip Value", it.nStarLevel);
	if it.nStarLevel >= self.pick_item_value then --高于设定星级直接保留不再考虑材料问题
		return 1;
	else                                          --低于设定星级，判断材料，9材料以上保留
		local nGTPCost, tbStuff, tbExp = Item:CalcBreakUpStuff(it);
		if (nGTPCost > 0) and (#tbStuff > 0) then
			for _, tbInfo in ipairs(tbStuff) do
				if  tbInfo.nLevel >7  or (tbInfo.nLevel == 7 and tbInfo.nCount >= 2) then --8级材料或者7及材料多于2个
					return 1;
				end
			end
		end
	end
	--me.Msg("低品级装备自动丢弃！");
	return 0;                                 --星级低，又不能拆好材料，要他何用
end


AutoAi:Init();

local tbAutoFightData = Ui.tbLogic.tbAutoFightData;

function tbAutoFightData:ShortKey()
	Ui(Ui.UI_AUTOFIGHT):LoadSetting();
	if me.nAutoFightState == 0 then
		Ui(Ui.UI_AUTOFIGHT).bAutoFight = 1;
	else
		Ui(Ui.UI_AUTOFIGHT).bAutoFight = 0;
	end
	local tbData =
	{
		nAutoFight		  	= Ui(Ui.UI_AUTOFIGHT).bAutoFight,
		nUnPickCommonItem 	= Ui(Ui.UI_AUTOFIGHT).bPickItem,
		nPickValue		  	= Ui(Ui.UI_AUTOFIGHT).nPickStar,
		nLifeRet		  	= Ui(Ui.UI_AUTOFIGHT).nLifeRet,
		nSkill1			  	= Ui(Ui.UI_AUTOFIGHT).nLeftSkillId,
		nSkill2			  	= Ui(Ui.UI_AUTOFIGHT).nRightSkillId,
		nSkill3			  	= Ui(Ui.UI_AUTOFIGHT).n3SkillId,
		nSkill4			  	= Ui(Ui.UI_AUTOFIGHT).n4SkillId,
		nSkill5			  	= Ui(Ui.UI_AUTOFIGHT).n5SkillId,
		nSkill6			  	= Ui(Ui.UI_AUTOFIGHT).n6SkillId,
		nAutoRepair 	  	= Ui(Ui.UI_AUTOFIGHT).nAutoRepair,
		nAcceptTeam		  	= Ui(Ui.UI_AUTOFIGHT).nAcceptTeam,
		nAutoDrink		  	= Ui(Ui.UI_AUTOFIGHT).nAutoDrink,
		nAutoEnhancePick  	= Ui(Ui.UI_AUTOFIGHT).nAutoEnhancePick,
		nAutoObjHuo			= Ui(Ui.UI_AUTOFIGHT).nAutoObjHuo,
		nAutoRead			= Ui(Ui.UI_AUTOFIGHT).nAutoRead,
		nAutoRead_Move		= Ui(Ui.UI_AUTOFIGHT).nAutoRead_Move,
		nPvpMode 			= Ui(Ui.UI_AUTOFIGHT).nPvpMode,
		tbLeftMed 			= Ui(Ui.UI_AUTOFIGHT).tbLeftMed,
		tbRightMed			= Ui(Ui.UI_AUTOFIGHT).tbRightMed,
	};
	return tbData;
end