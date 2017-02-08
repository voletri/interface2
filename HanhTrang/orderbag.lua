local bIsSorting = false;
local nTimerId;
local tbCells;
local PAGE2ROOM ={
Item.ROOM_REPOSITORY,
Item.ROOM_EXTREP1,
Item.ROOM_EXTREP2,
Item.ROOM_EXTREP3,
Item.ROOM_EXTREP4,
}
function Player:ItemSort_SortBag()
	Player:ItemSort_Begin(Item.ROOM_EXTBAG1) ;  --从这个背包开始整理，需要从第二个背包开始就改为2
      --  me.Msg("<color=yellow>我要开始整理包包喽,我会很快的<pic=99>~")
end

function Player:ItemSort_SortRepository()
	local tbRepository = Ui(Ui.UI_REPOSITORY);
	Player:ItemSort_Begin(Item.ROOM_REPOSITORY);
	--me.Msg("<color=yellow>开始整理仓库！<pic=23>~")
end

--开始排序
function Player:ItemSort_Begin(nStartContainerId)

	if not bIsSorting then
		bIsSorting = true;
	else
		return;
	end
	self.nSortContainerId = nStartContainerId;
	self.tbSortRule = {self.ItemSort_CompareGenre,self.ItemSort_CompareClass,self.ItemSort_CompareLevel,self.ItemSort_CompareName};
	nTimerId = Timer:Register(0.1 * Env.GAME_FPS, self.ItemSort_OnSort, self);
end

--排序工作结束
function Player:ItemSort_End()
	Timer:Close(nTimerId);
	nTimerId = nil;
	bIsSorting = false;
       -- me.Msg("<color=yellow>我已经整理好啦<pic=23>~")
end

function Player:ItemSort_OnSort()
	--for i = 1,4 do
		--self.nSortContainerId = PAGE2ROOM[i]
		--me.Msg(""..self.nSortContainerId.."")
		tbCells = Player:ItemSort_GetAllCells(self.nSortContainerId);

		if (tbCells[1].nContainerId == Item.ROOM_REPOSITORY) and (UiManager.tbUiState[UiManager.UIS_OPEN_REPOSITORY] == 0 ) then
			Player:ItemSort_End();
			self.nSortContainerId = 0;
		end

		for i = 1, table.getn(tbCells) do
			local pItem1 = me.GetItem(tbCells[i].nContainerId, tbCells[i].nRow, tbCells[i].nColumn);
			local tbItemMVI = {pItemMVI = pItem1, nNum = i};
			for j = i + 1, table.getn(tbCells) do
				local pItem2 = me.GetItem(tbCells[j].nContainerId, tbCells[j].nRow, tbCells[j].nColumn);

				--可以叠加的条件
				if (pItem1 and pItem2) then
					local _, _nTimeOut1 = pItem1.GetTimeOut();
					local _, _nTimeOut2 = pItem2.GetTimeOut();
					if (pItem1.IsStackable() == 1 and _nTimeOut1 == 0) and (pItem2.IsStackable() == 1 and _nTimeOut2 == 0) then
						if (Player:ItemSort_CompareItemName(pItem1,pItem2)) and (pItem1.nCount ~= pItem1.nMaxCount) then
							if (pItem1.IsBind() == pItem2.IsBind()) then
								me.SwitchItem(tbCells[j].nContainerId, tbCells[j].nRow, tbCells[j].nColumn,
									tbCells[i].nContainerId, tbCells[i].nRow, tbCells[i].nColumn);
								return;
							end
						end
					end
				end

				--记录当前item后面优先级最大的item及其所在位置
				if (Player:ItemSort_Compare(tbItemMVI.pItemMVI, pItem2, self.tbSortRule) == -1)	then
					tbItemMVI.pItemMVI = pItem2;
					tbItemMVI.nNum = j;
				end
			end

			--如果当前item的优先级不是最大，与最大优先级交换
			if (tbItemMVI.nNum ~= i) then
				me.SwitchItem(tbCells[i].nContainerId, tbCells[i].nRow, tbCells[i].nColumn,
					tbCells[tbItemMVI.nNum].nContainerId, tbCells[tbItemMVI.nNum].nRow, tbCells[tbItemMVI.nNum].nColumn);
				return;
			end;
		end
	--end
	Player:ItemSort_End();
end
