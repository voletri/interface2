local AutoDSTK = Ui.AutoDSTK or {};
		
local nSwitch = 0;

local nLine;
local tItm, tSay;

function UiManager:DSTKSwitch()
	nSwitch = 1 - nSwitch;
	if nSwitch == 1 then
		nLine = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "AutoBanhKem: Start");
		AutoDSTK:ModifySay();
		tItm = Ui.tbLogic.tbTimer:Register(100, AutoDSTK.OnNPC, self);	
	else
		Ui.tbLogic.tbTimer:Close(tSay);
		Ui.tbLogic.tbTimer:Close(tItm);
		UiManager:OpenWindow("UI_INFOBOARD", "AutoBanhKem: Stop");
	end	
end

function AutoDSTK:ModifySay()
	local uiSayPanel	= Ui(Ui.UI_SAYPANEL);
	AutoDSTK.Say_bak	= AutoDSTK.Say_bak or uiSayPanel.OnOpen;	
	function uiSayPanel:OnOpen(tbParam)
		AutoDSTK.Say_bak(uiSayPanel, tbParam);		
		local function fnOnSay()
			AutoDSTK:OnSay(tbParam);
			return 0;
		end
		tSay = Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
	AutoDSTK.EnterGame_bak	= AutoDSTK.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		AutoDSTK.EnterGame_bak(Ui);
	end
end
		
function AutoDSTK:OnNPC()
	local tbAroundNpc = KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == 6723) then	-- 正是要找的人
			UiManager:OpenWindow("UI_INFOBOARD", "AutoBanhKem: OnNPC");
			AutoAi.SetTargetIndex(pNpc.nIndex);
			return;
		end		
	end
	UiManager:OpenWindow("UI_INFOBOARD", "no NPC");
end

function AutoDSTK:OnSay(tbParam)
	if nSwitch == 0 then
		return;
	end
		
	UiManager:OpenWindow("UI_INFOBOARD", tbParam[1]);

	if (string.find(tbParam[1], "Nhan Như Ngọc")) then
		UiManager:OpenWindow("UI_INFOBOARD", tbParam[2][1]);
		Ui(Ui.UI_SAYPANEL):OnListSel("LstSelectArray", 1);
		return;
	end

	if (string.find(tbParam[1], "mới nhất sôi nổi nhất")) then
		local sLine = nil;
		if (nLine == 1) then
			sLine = "Thu thập Trứng gà";
		else 
			sLine = "Thu thập Bột mì";
		end
		for i, szAns in ipairs(tbParam[2]) do	
			if (string.find(szAns, sLine)) then
				UiManager:OpenWindow("UI_INFOBOARD", szAns);
				Ui(Ui.UI_SAYPANEL):OnListSel("LstSelectArray", i);
				break;
			end
		end
		return;
	end

	if string.find(tbParam[1], "Sự kiện Sinh Nhật Kiếm Thế") then
		local flag = true;
		for i, szAns in ipairs(tbParam[2]) do	
			if (i<7) and not (string.find(szAns, "gray")) then
				UiManager:OpenWindow("UI_INFOBOARD", szAns);	
				Ui(Ui.UI_SAYPANEL):OnListSel("LstSelectArray", i);
				flag = false;
				break;
			end
		end
		if flag == true then
			nLine = nLine + 1;
		end
	end

	if nLine > 2 then
		UiManager:DSTKSwitch();
	end
end

	local tCmd={ "UiManager:DSTKSwitch()", "DSTKSwitch", "", "Shift+R", "Shift+R", "AutoDSTK"};
		AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
		UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
