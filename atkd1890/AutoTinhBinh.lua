local AutoTinhBinh = Ui.AutoTinhBinh or {};

local nSwitch = 0;
local nItem;
local tItem, tSay;

function UiManager:TBLSwitch()
	nSwitch = 1-nSwitch;
	if nSwitch == 1 then
		nItem = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "AutoTinhBinh: Start");
		AutoTinhBinh:ModifySay();
		tItem = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 2,AutoTinhBinh.OnItem,self);
	else
		nItem = 6;
		Ui.tbLogic.tbTimer:Close(tSay);
		Ui.tbLogic.tbTimer:Close(tItem);
		UiManager:OpenWindow("UI_INFOBOARD", "AutoTinhBinh: Stop");
	end
end

function AutoTinhBinh:ModifySay()
	me.Msg("AutoTinhBinh : modified");
	local uiSayPanel	= Ui(Ui.UI_SAYPANEL);
	AutoTinhBinh.Say_bak	= AutoTinhBinh.Say_bak or uiSayPanel.OnOpen;	
	function uiSayPanel:OnOpen(tbParam)
		AutoTinhBinh.Say_bak(uiSayPanel, tbParam);		
		local function fnOnSay()
			AutoTinhBinh:OnSay(tbParam);
			return 0;
		end
		tSay = Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
	AutoTinhBinh.EnterGame_bak	= AutoTinhBinh.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		AutoTinhBinh.EnterGame_bak(Ui);
	end
end

function AutoTinhBinh:OnItem()	
	if me.GetItemCountInBags(18,1,20614,1)>0 then
		local tbFind = me.FindItemInBags(18,1,20614,1);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			me.Msg("AutoTinhBinh : box used");
			break;
		end
		return;
	end
	
	if me.GetItemCountInBags(18,1,20614,2)>0 then
		local tbFind = me.FindItemInBags(18,1,20614,2);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			me.Msg("AutoTinhBinh : box used");
			break;
		end
		return;
	end
	
	if (nItem > 5) then
		UiManager:TBLSwitch();
		return;
	end
	
	if me.GetItemCountInBags(18,1,20507,nItem)>0 then
		local tbFind = me.FindItemInBags(18,1,20507,nItem);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			me.Msg("AutoTinhBinh : used " .. nItem);
			break;
		end
	else
		nItem = nItem +1;
	end
end

function AutoTinhBinh:OnSay(tbParam)
	if (nItem > 5) then
		return;
	end

	local nAns = nil;
	for i, szAns in ipairs(tbParam[2]) do
		if string.find(szAns, "Nhận thưởng") and not (string.find(szAns, "gray")) then
			nAns = i;
			break;
		end
	end
	
	if nAns == nil then 
		me.Msg("AutoTinhBinh : grayed " .. nItem);
		nItem = nItem + 1;
		return;
	end
	
	if (tbParam[2][nAns]) then 
		me.Msg("AutoTinhBinh : ok " .. nItem);
		Ui(Ui.UI_SAYPANEL):OnListSel("LstSelectArray", nAns);
	end
end

local tCmd={ "UiManager:TBLSwitch()", "TBLSwitch", "", "Shift+O", "Shift+O", "AutoTinhBinh"};
		AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
		UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
