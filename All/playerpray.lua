------------------------------------------------------
-- 参考文件 ：	\\ui\\script\\window\\playerpray.lua
-- 修改者   ：  小虾米
-- 修改时间 ：	2009-06-23
-- 功能描述 ：	快速祈福。
------------------------------------------------------

local uiPlayerPray = Ui(Ui.UI_PLAYERPRAY);
local fastClick = 0; -- 是否连续点击
local nFirst    = 0; -- 是否首次点击
local nTimerId  = 0;

-- 祈福读秒(金7秒 木3秒 水7秒 火3秒 土5秒)
local PRAY_METAL = 7
local PRAY_WOOD  = 3
local PRAY_WATER = 7
local PRAY_FIRE  = 3
local PRAY_EARTH = 5

local tbAutoPlayerPray	= Map.tbAutoPlayerPray or {};
Map.tbAutoPlayerPray		= tbAutoPlayerPray;

local nPlayerPrayState = 1;

local szCmd = [=[
	Map.tbAutoPlayerPray:PlayerPrayswitch();
]=];
UiShortcutAlias:AddAlias("GM_S3", szCmd);	-- 热键：Ctrl+3

function tbAutoPlayerPray:PlayerPrayswitch()
	if nPlayerPrayState == 0 then
		nPlayerPrayState = 1;
		me.Msg("<color=yellow>Bật tự quay chúc phúc (Ctrl+3)<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật tự quay chúc phúc (Ctrl+3)<color>");
	else
		nPlayerPrayState = 0;
		me.Msg("<color=green>Tắt tự quay chúc phúc (Ctrl+5)<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự quay chúc phúc (Ctrl+3)<color>");
	end
end

-- 祈福读秒偏移量
uiPlayerPray.PRAY_OFFSET_LIST = {
			[1] = {0.5},
			[2] = {0.3},
			[3] = {0.1},
			[4] = {0},
			[5] = {-0.1},
			[6] = {-0.3},
			[7] = {-0.5},
}

-- 更新控制按钮文字(重写此函数)
function uiPlayerPray:UpdateControlButtonTxt()
	if (nPlayerPrayState == 0) then
		return;
	end
	local nAllElement		= me.GetTask(Task.tbPlayerPray.TSKGROUP, Task.tbPlayerPray.TSK_SAVEELEMENT);
	local szMsg	= "";
	if (self.FLAG_HANDMOVE == 1) then
		szMsg = "Dừng";
	else
		local nPrayFlag = Task.tbPlayerPray:CheckAllowPray(me);
		if (nPrayFlag == 0) then
			szMsg = "Bắt đầu";
			local tbElement		= self:GetPrayResultElement();
			local tbAward		= Task.tbPlayerPray:GetAward(me, tbElement);
			local nInDirFlag	= me.GetTask(Task.tbPlayerPray.TSKGROUP, Task.tbPlayerPray.TSK_INDIRAWARDFLAG);
			if (#tbAward <= 0) then
				if (nAllElement > 0) then
					szMsg = "Tiếp tục";
				end
			else
				if (nInDirFlag >= 1) then
					szMsg = "Kết thúc";
				end
			end
		elseif (nPrayFlag > 0) then
			szMsg = "Kết thúc";
		end
	end	
	Btn_SetTxt(self.UIGROUP, self.BTN_CONTROL, szMsg);
	-- START --
	if (szMsg == "Bắt đầu") then
		nFirst = 1;
	elseif (szMsg == "Tiếp tục") then
		self:SetHandMoveState(); -- 开始转动
	elseif (szMsg == "Dừng") then				
		local pTime = self:GetPrayTime();	
		if (fastClick == 1 or nFirst == 1) then
			self:StopPray(); -- 立即停止转动
			nFirst = 0;
			me.Msg("Dừng ngay");
		else
			nTimerId = Ui.tbLogic.tbTimer:Register(pTime * Env.GAME_FPS, self.StopPray); -- 稍后停止转动
			me.Msg("Đang chờ "..pTime.." giây ngừng quay.");
		end
	end	
	-- END --
end

-- 获取祈福五行元素
function uiPlayerPray:GetLastPrayElement()
	local result = 0;
	for i = 1, 5 do
		local nElement = Task.tbPlayerPray:GetPrayElement(me, i);	
		if (nElement <= 0) then
			break;
		end
		result = nElement;
	end		
	return result;
end

-- 获取祈福延迟时间
function uiPlayerPray:GetPrayTime()
	local pTime = 0;
	local result = self:GetLastPrayElement();
	local szMsg = "";
	if (result == 1) then
		pTime = PRAY_METAL; -- 金
		szMsg = "Kim";
	elseif (result == 2) then
		pTime = PRAY_WOOD;  -- 木
		szMsg = "Mộc";
	elseif (result == 3) then
		pTime = PRAY_WATER; -- 水
		szMsg = "Thủy";
	elseif (result == 4) then
		pTime = PRAY_FIRE;  -- 火
		szMsg = "Hỏa";
	else
		pTime = PRAY_EARTH; -- 土
		szMsg = "Thổ";
	end
	if (nFirst == 0) then
		me.Msg("Kết quả:"..szMsg);
	end
	local nResultPoint = self.nEndPoint;
	local nResultMod   = nResultPoint - math.floor(nResultPoint/7) * 7; -- math.floor获得一个数的整数部分
	if (nResultMod == 0) then
		nResultMod = 7;
	end
	local nPrayOffset  = 0;
	-- me.Msg("ResultPoint:"..nResultPoint);
	nPrayOffset = self.PRAY_OFFSET_LIST[nResultMod][1];
	pTime = pTime + nPrayOffset;
	return pTime;
end

-- 停止转动
function uiPlayerPray:StopPray()
	uiPlayerPray:SetHandMoveState();
	if (nTimerId > 0) then
		Ui.tbLogic.tbTimer:Close(nTimerId);
		nTimerId = 0;
	end
end