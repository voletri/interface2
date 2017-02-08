local AutoEvent = Ui.AutoEvent or {};

local nSwitch = 0;
local nItem = 0;
local pTabFile;

local tSay, sQuest, sAns, nHeight, nAns;
local tItm, iItm, nID1, nID2, nID3, nID4, nItm;
local tNPC, iNPC, nIDNPC, nRange, nNPC;

function UiManager:EventSwitch()
	nSwitch = 1 - nSwitch;
	if nSwitch == 1 then
		nItem = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "Start");
		pTabFile = KIo.OpenTabFile("\\interface2\\ScriptAuto\\AutoEvent.txt");
		if (not pTabFile) then
			UiManager:OpenWindow("UI_INFOBOARD", "no file");
			return;
		end
		UiManager:OpenWindow("UI_INFOBOARD", "auto say");
		AutoEvent:ModifySay();
		nHeight = pTabFile.GetHeight();
		iItm = pTabFile.GetInt(1,2);
		nID1 = pTabFile.GetInt(1,3);
		nID2 = pTabFile.GetInt(1,4);
		nID3 = pTabFile.GetInt(1,5);
		nID4 = pTabFile.GetInt(1,6);
		nItm = pTabFile.GetInt(1,7);
		if (iItm == 1) then
			UiManager:OpenWindow("UI_INFOBOARD", "auto use item delay [" .. nItm .. "ms]");
			tItm = Ui.tbLogic.tbTimer:Register(nItm, AutoEvent.OnUse, self);
		end
		iNPC = pTabFile.GetInt(2,2);
		nIDNPC = pTabFile.GetInt(2,3);
		nRange = pTabFile.GetInt(2,4);
		nNPC = pTabFile.GetInt(2,5);
		if (iNPC == 1) then
			UiManager:OpenWindow("UI_INFOBOARD", "auto NPC delay [" .. nNPC .. "ms]");
			tNPC = Ui.tbLogic.tbTimer:Register(nNPC, AutoEvent.OnNPC, self);
		end
	end
	if nSwitch == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "Stop");
		Ui.tbLogic.tbTimer:Close(tSay);
		Ui.tbLogic.tbTimer:Close(tItm);
		Ui.tbLogic.tbTimer:Close(tNPC);
		if (pTabFile) then
			KIo.CloseTabFile(pTabFile);
		end
	end
end

function AutoEvent:ModifySay()
	local uiSayPanel	= Ui(Ui.UI_SAYPANEL);
	AutoEvent.Say_bak	= AutoEvent.Say_bak or uiSayPanel.OnOpen;
	function uiSayPanel:OnOpen(tbParam)
		AutoEvent.Say_bak(uiSayPanel, tbParam);
		local function fnOnSay()
			AutoEvent:OnSay(tbParam);
			return 0;
		end
		tSay = Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
	AutoEvent.EnterGame_bak	= AutoEvent.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		AutoEvent.EnterGame_bak(Ui);
	end
end

function AutoEvent:OnUse()
	if me.GetItemCountInBags(nID1,nID2,nID3,nID4)>0 then
		local tbFind = me.FindItemInBags(nID1,nID2,nID3,nID4);
		for j, tbItem in pairs(tbFind) do
			UiManager:OpenWindow("UI_INFOBOARD", "using item ("..nID1..","..nID2..","..nID3..","..nID4..")");
			me.UseItem(tbItem.pItem);
			break;
		end
	else
		UiManager:OpenWindow("UI_INFOBOARD", "no item ("..nID1..","..nID2..","..nID3..","..nID4..")");
	end
end

function AutoEvent:OnNPC()
	local tbAroundNpc = KNpc.GetAroundNpcList(me, nRange);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nIDNPC) then	-- 正是要找的人
			UiManager:OpenWindow("UI_INFOBOARD", "target NPC ("..nIDNPC..", "..nRange..")");
			AutoAi.SetTargetIndex(pNpc.nIndex);
			return;
		end
	end
	UiManager:OpenWindow("UI_INFOBOARD", "no NPC ("..nIDNPC..", "..nRange..")");
end

function AutoEvent:OnSay(tbParam)
		if nSwitch == 0 then
			return;
		end
		sAns = nil;
		for j=1,nHeight do
			sQuest = pTabFile.GetStr(j,1);
			if string.find(tbParam[1],sQuest) then
				sAns = pTabFile.GetStr(j+1,1);
				break;
			end
		end
		for i, szAns in ipairs(tbParam[2]) do
			if  string.find(szAns,sAns) and not (string.find(szAns, "gray")) then
				nAns = i;
				break;
			end
		end
		if nAns == nil then
			UiManager:OpenWindow("UI_INFOBOARD", "no ans");
		end
	if (tbParam[2][nAns]) then
		UiManager:OpenWindow("UI_INFOBOARD", sAns);
		Ui(Ui.UI_SAYPANEL):OnListSel("LstSelectArray", nAns);
	end
	nAns = nil;
end

	local tCmd={ "UiManager:EventSwitch()", "EventSwitch", "", "Shift+U", "Shift+U", "AutoEvent"};
		AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
		UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
