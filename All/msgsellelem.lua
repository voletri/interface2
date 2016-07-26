
Require("\\ui\\script\\logic\\messagelist.lua")

local tbMsgList = Ui.tbLogic.tbMessageList;

local tbSellElem = {};
tbSellElem.TASK_DATA_BEG_POS		= 33;

function tbSellElem:Init(tbInfo)
	self.pItem = self:CreateLink(tbInfo[1]);
	if (not self.pItem) then
		return;
	end
	
	self.szText = "<" .. self.pItem.szName .. ">";	
	self.szKey, self.szSellerName, self.nOnePrice, self.nCurrency = self:GetElemData3Info(tbInfo[1]);
	if not self.nCurrency then
		print("Không có loại tiền tệ")
		return;
	end
	if not (self.nCurrency == 1 or self.nCurrency == 2) then
		self.nCurrency = nil;
		print("Loại tiền tệ bị lỗi");
		return;
	end
	
	self.IsSystem		= tbInfo[5];
	Setting:SetGlobalObj(nil, nil, self.pItem);
	local _1, _2, szItemNameColor = Item:CalcValueInfo(self.pItem.szClass);
	Setting:RestoreGlobalObj();
	
	local nId		= MessageList_PushBtn(self.tbManager.UIGROUP, self.tbManager.szMessageListName, 0, self.szText, szItemNameColor, "black", 0);
	return nId;
end

function tbSellElem:UpdateItemList(szListName, bSpecial)
	local nItemCountPerPage = KAuction.AuctionGetSearchResultNum() - 1;
	for nItemBarIdx = 0, nItemCountPerPage do
		local rec = KAuction.AuctionGetSearchResultByIndex(nItemBarIdx);
		if ( rec ~= nil ) then
			local nItemIdx		= rec.GetItemIndex()
			local nOnePrice		= rec.GetOneTimeBuyPrice()/10000
			local nCurrency		= rec.GetCurrency()
			local szUnit		= ""
			if nCurrency == 1 then
				szUnit = "bạc"
			end
			local pItem = KItem.GetItemObj(nItemIdx)
			if pItem then
			end
		end
	end
	tbAuctionRoom_UpdItmLst(self, szListName, bSpecial)
end

function tbSellElem:CreateLink(tbParams)
	local tbExtraParams = tbParams;
	local nData3Beg = self:GetElemData3BeginPos();
	for i, szParam in pairs(tbExtraParams) do
		if i < nData3Beg then
			tbExtraParams[i] = tonumber(szParam);
		end
	end
	local tbGenInfo =  { tbExtraParams[15], tbExtraParams[16], tbExtraParams[17], tbExtraParams[18], tbExtraParams[19], tbExtraParams[20], tbExtraParams[21], tbExtraParams[22], tbExtraParams[23], tbExtraParams[24], tbExtraParams[25], tbExtraParams[26] };
	local tbRandomMa = { tbExtraParams[27], tbExtraParams[28], tbExtraParams[29], tbExtraParams[30], tbExtraParams[31], tbExtraParams[32], tbExtraParams[14]};
	local tbTaskData = self:PackageTaskData(tbExtraParams);
	
	local pItem = Ui.tbLogic.tbTempItem:Create(tbExtraParams[2],
		tbExtraParams[3],
		tbExtraParams[4],
		tbExtraParams[5],
		tbExtraParams[6],
		tbExtraParams[7],
		tbExtraParams[8], 
		tbGenInfo,
		tbExtraParams[9],
		tbExtraParams[10],
		-1,
		0,
		tbExtraParams[11],
		tbExtraParams[12],
		tbExtraParams[13],
		tbRandomMa,
		tbTaskData
	);
	return pItem;
end

function tbSellElem:Clear()
	if (self.pItem) then
		Ui.tbLogic.tbTempItem:Destroy(self.pItem);
	end
end

function tbSellElem:GetShowMsg(tbInfo)
	local pItem = self:CreateLink(tbInfo);
	local szTempText = "<" .. pItem.szName .. ">";
	Ui.tbLogic.tbTempItem:Destroy(pItem);
	
	return szTempText;	
end

function tbSellElem:LeftClick()
	local nPrice = self.nOnePrice;
	local szKey = self.szKey;
	local nCurrency = self.nCurrency;
	if (not nPrice) or (not szKey) or (not nCurrency) or self.IsSystem == 0 then
		return;
	end

	local tbObj = nil;
	if (self.pItem) then
		tbObj = {};
		tbObj.nType = Ui.OBJ_ITEM;
		tbObj.pItem = self.pItem;
	end
	local tbApplyMsg = {};
	tbApplyMsg.tgObj = tbObj;
	tbApplyMsg.szObjName = self.pItem.szName;
	if nCurrency == 1 then
		tbApplyMsg.szMsg = "Bạn muốn mua với giá: <color=255,167,0>"..Item:FormatMoney(nPrice).."<color> (Bạc)?";	
	else
		tbApplyMsg.szMsg = "Bạn đồng ý mua giá chót: <color=yellow>"..Item:FormatMoney(nPrice).."(đồng)<color>?";
		tbApplyMsg.szWarmingTxt = "<color=yellow>Chú ý: Tiền đồng sẽ bị trừ<color>";
	end
	tbApplyMsg.szTitle = "Đấu giá vật phẩm";
	tbApplyMsg.nOptCount = 2;
	tbApplyMsg.bObjEdt = 0;				
	tbApplyMsg.bClose = 0;
	function tbApplyMsg:Callback(nOptIndex, msgWnd, Wnd)
		local bOk = 0;
		if (nOptIndex == 2) then
			if 1 == Wnd.nCurrency and me.nCashMoney < Wnd.nOnePrice then
				UiManager:OpenWindow(Ui.UI_INFOBOARD, "Bạn không đủ bạc!");
			elseif 2 == Wnd.nCurrency and me.nCoin < Wnd.nOnePrice then
				UiManager:OpenWindow(Ui.UI_INFOBOARD, "Ngươi không đủ đồng!");
			elseif Wnd.nCurrency ==1 or Wnd.nCurrency == 2 then
				bOk = 1;
			end
			if 1 == bOk then
				Wnd:Buy(Wnd.szKey, tonumber(Wnd.nOnePrice), Wnd.nCurrency);
			end
		end
		if (nOptIndex == 99) then
			Ui.tbLogic.tbTempItem:Destroy(Wnd.pTempItem);
		end
	end
	UiManager:OpenWindow(Ui.UI_MSGBOXWITHOBJ, tbApplyMsg, self);
end

function tbSellElem:Buy(szKey, nOnePrice, nCurrency)
	local tbMsg = {};
	tbMsg.szMsg = "Mua giá chót?";
	tbMsg.nOptCount = 2;
	function tbMsg:Callback(nOptIndex, szKey, nOnePrice)
		if (nOptIndex == 2) then
			KAuction.OnePriceBuyByAdvs(szKey, nOnePrice, nCurrency);
			UiManager:CloseWindow(Ui.UI_MSGBOXWITHOBJ);
		end
	end
	if nCurrency and nCurrency == 2 then
		tbMsg.szMsg = "Có phải bạn muốn mua với giá chót bằng <color=yellow>đồng<color>?"
	else
		tbMsg.szMsg = "Có phải muốn mua với giá chót bằng <color=255,167,0>bạc<color>?"
	end
	UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, szKey, nOnePrice);
end

function tbSellElem:PackageTaskData(tbParams)
	local tbTaskData = {};
	
	local nMainIndex = Item.TASKDATA_MAIN_STONE;
	local nSubIndex = 1;
	local nTaskDataMaxLen = Item:GetItemTaskDataMaxLen();
	for i = 1, nTaskDataMaxLen do	
		if not Item.tbTaskDataLen[nMainIndex] or 
			Item.tbTaskDataLen[nMainIndex] < nSubIndex then
			break;
		end	
		
		local nIndex = self.TASK_DATA_BEG_POS + i - 1;
		tbTaskData = Item:SetItemTaskValue(tbTaskData, nMainIndex, nSubIndex, tbParams[nIndex]);
		nSubIndex = nSubIndex + 1;		

		if (Item.tbTaskDataLen[nMainIndex] < nSubIndex) then
			nMainIndex = nMainIndex + 1;
			nSubIndex = 1;
		end		
	end

	return tbTaskData;
end

function tbSellElem:GetElemData3BeginPos()
	local nTaskDataMaxLen = Item:GetItemTaskDataMaxLen();
	return self.TASK_DATA_BEG_POS + nTaskDataMaxLen;
end

function tbSellElem:GetElemData3Info(tbParams)
	local nDataBeg = self:GetElemData3BeginPos();
	local szKey	= tbParams[nDataBeg+1];		
	local szSellerName 	= tbParams[nDataBeg+2];
	local nOnePrice = tonumber(tbParams[nDataBeg+3]);
	local nCurrency	= tonumber(tbParams[nDataBeg+4]);
	
	return szKey, szSellerName, nOnePrice, nCurrency;
end

tbMsgList:RegisterBaseClass("sell", tbSellElem);
