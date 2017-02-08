local tbCaVang	= Ui.tbCaVang or {};
Ui.tbCaVang	= tbCaVang
local self	= tbCaVang

self.state = 0;

local Dem;
local tTimer, tMod, tSay;

local nDelay = 40; -- thời gian chờ nhảy đếm

local tCmd={"Ui.tbCaVang:State()", "Ui.tbCaVang", "", "Shift+G", "Shift+G", "dmm"};
	 AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	 UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

function tbCaVang:Modify()
	local uiSayPanel = Ui(Ui.UI_SAYPANEL);
	tbCaVang.Say_bak = tbCaVang.Say_bak or uiSayPanel.OnOpen;
	function uiSayPanel:OnOpen(tbParam)
		tbCaVang.Say_bak(uiSayPanel, tbParam);
		local function fnOnSay()
			tbCaVang:OnSay(tbParam);
			return 0;
		end
		tSay = Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end

	tbCaVang.EnterGame_bak	= tbCaVang.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		tbCaVang.EnterGame_bak(Ui);
	end
end

function tbCaVang:State()
	if self.state == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu nhiệm vụ khổng tước hà <color>");
		Dem = 0
		tMod = Ui.tbLogic.tbTimer:Register(1,self.Modify,self);
		tTimer = Ui.tbLogic.tbTimer:Register(nDelay,self.OnTimer,self);
		self.state = 1
	else
		self.state = 0
		Ui.tbLogic.tbTimer:Close(tTimer);
		Ui.tbLogic.tbTimer:Close(tSay);
		Ui.tbLogic.tbTimer:Close(tMod);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Red>Stop<color>");
	end
end

function tbCaVang.DoiThoaiNPC(idNPC)
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == idNPC) then
			AutoAi.SetTargetIndex(pNpc.nIndex)
		end
	end
end

function tbCaVang:OnSay(tbParam)
	if self.state == 0 then
		return;
	end

	UiManager:OpenWindow("UI_INFOBOARD", tbParam[1]);
	local sAns = nil;
	if string.find(tbParam[1], "Xin chào") then
		sAns = "Hoạt động trọng điểm"
	elseif string.find(tbParam[1], "Chỗ ta có những hoạt động") then
		if Dem == 1 then
			sAns = "Tiễn Táo"
		elseif Dem == 2 then
			sAns = "TTVT_"
		elseif Dem == 4 then
			sAns = "Tế Lễ"
		end
	elseif string.find(tbParam[1], "Tiễn Táo Về Trời") then
		if Dem == 1 then
			sAns = "Online 10p"
		elseif Dem == 2 then
			sAns = "70 điểm"
		end
	elseif string.find(tbParam[1], "Tiễn Táo Chầu Trời") then
		sAns = "Tế Lễ"
	end

	if sAns == nil then
		UiManager:OpenWindow("UI_INFOBOARD", "no ans")
		return;
	end

	for i, szAns in ipairs(tbParam[2]) do
		if  string.find(szAns, sAns) then
			if not (string.find(szAns, "gray")) then
				UiManager:OpenWindow("UI_INFOBOARD", sAns);
				Ui(Ui.UI_SAYPANEL):OnListSel("LstSelectArray", i);
			else
				Dem = Dem + 1;
			end
			break;
		end
	end
end

function tbCaVang.OnTimer()
	if self.state == 0 then
		return;
	end

	if UiManager:WindowVisible(Ui.UI_SAYPANEL) then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end

	me.Msg("Dem: " .. Dem)
	local nMapId,nMyPosX,nMyPosY = me.GetWorldPos()

	--- nhan như ngọc
	if Dem == 0 then
		if nMyPosX==1804 and nMyPosY==3494 then
			Dem = 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",24,1804,3494"});
		end
		return;
	end
	if Dem == 1 or Dem == 2 then
		tbCaVang.DoiThoaiNPC(6723);
		return;
	end

	--- táo quân
	if Dem == 3 then
		if nMyPosX==1791 and nMyPosY==3544 then
			Dem = 4
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",24,1791,3544"});
		end
		return;
	end
	if Dem == 4 then
		tbCaVang.DoiThoaiNPC(7246);
		return;
	end

	-- end
	if Dem == 5 then
		tbCaVang:State();
	end

end