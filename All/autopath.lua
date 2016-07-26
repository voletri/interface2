local tbAutoPath		= Ui.tbLogic.tbAutoPath or {};	-- 支持重载
Ui.tbLogic.tbAutoPath	= tbAutoPath;


-- 当抵达目的地时
function tbAutoPath:OnFinished()
	me.Msg("膼茫 膽岷縩.");
	
	local tbCallBack	= self.tbCallBack;
	
	self:StopGoto("Finish");
	
	if (tbCallBack and tbCallBack[1]) then
		Lib:CallBack(tbCallBack);
	end
	local bIsOpenAutoF = 0;
	local bIsInDialogNpc = 0;
	local nNpcId = tbCallBack[3];
	
	--针对npc寻路
	if type(nNpcId) == "number" then
		local tbNpcList = KNpc.GetAroundNpcList(me,5,16);
		for _, ptmp in pairs(tbNpcList) do
			if ptmp.nKind == 3 then
				bIsInDialogNpc = 1;
				break;
			end
		end
	end

	--[[不是对话npc或其他寻路情况
	if bIsInDialogNpc == 0 then
		local tbNpcList = KNpc.GetAroundNpcList(me,20);
		for _, ptmp in pairs(tbNpcList) do
			if ptmp.nKind == 0 then
				bIsOpenAutoF = 1;
				break;
			end
		end
	end]]

	if bIsOpenAutoF == 1 then
		local tbDate =Ui.tbLogic.tbAutoFightData:ShortKey();
		tbDate.nAutoFight = 1;
		tbDate.nPvpMode = 0;
		AutoAi:UpdateCfg(tbDate);
	end
end
