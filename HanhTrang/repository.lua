

local tbRepository = Ui(Ui.UI_REPOSITORY);

local BTN_SORTITEM = "BtnSortItem"

tbRepository.OnButtonClick_Bak = tbRepository.OnButtonClick
tbRepository.OnButtonClick = function(self, szWnd, nParam)
	tbRepository:OnButtonClick_Bak(szWnd,nParam);
	if (szWnd == BTN_SORTITEM) then
		Player:ItemSort_SortRepository();
	end
end

