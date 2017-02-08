--cyberdemon--
function Item:Tip_Prefix(nState, nEnhStarLevel, szBindType)
	local szPreTip = "";
	if it.IsEquip() == 1 then
		szPreTip = szPreTip..self:Tip_StarLevel(nState, nEnhStarLevel);
		szPreTip = szPreTip..self:Tip_FightPower(nState);
		szPreTip = szPreTip..self:Tip_Value(nState)
		szPreTip = szPreTip..self:Tip_BindInfo(nState, szBindType);
		szPreTip = szPreTip..self:Tip_Changeable(nState)..self:Tip_CanBreakUp(nState);
		-- szPreTip = szPreTip..self:Tip_FixSeries(nState);
		if it.IsZhenYuan() ~= 1 then
			szPreTip = szPreTip..self:Tip_GetRefineLevel();
		end
	else
		if (it.GetStoneType() ~= 0) then
			szPreTip = szPreTip..Item.tbClass["gem"]:Tip_StarLevel();
			szPreTip = szPreTip..self:Tip_FightPower();
		elseif it.szClass == "horse_item" then
			szPreTip = szPreTip..Item.tbClass["horse_item"]:GetPreTip();
		end
		if (it.nGenre == 25 or it.nGenre == 26 or it.nGenre == 27 or it.nGenre == 28) then
			szPreTip = szPreTip..self:Tip_StarLevel(nState, nEnhStarLevel);
			szPreTip = szPreTip..self:Tip_FightPower(nState);
		end
		szPreTip = szPreTip..self:Tip_Value(nState);
		szPreTip = szPreTip..self:Tip_BindInfo(nState, szBindType);
		szPreTip = szPreTip..self:Tip_Changeable(nState);
		if (it.nGenre == 28) then
			szPreTip = szPreTip..self:Tip_CanBreakUp(nState)..self:Tip_GetRefineLevel();
		end
	end
	return szPreTip;
end

function Item:Tip_Value(nState)
	local szTip = "\n";
	local nValue = it.nValue;
	local nOrigin = self:Tip_Origin(nState);
	if it.nEnhTimes == 0 then
		local strValue = string.format("\n<color=blue>Tài phú +%.0f<color>", nValue/10000);
		szTip = strValue.."\n";
	else
		local strValue = string.format("<color=blue>Tài phú gốc: %.0f\nTài phú +%.0f<color>", nOrigin/10000,nValue/10000);
		szTip = strValue.."\n";
	end
	szTip = szTip .. string.format("<color=yellow>ID: %d-%d-%d-%d<color>", it.nGenre,it.nDetail,it.nParticular,it.nLevel) .. "\n";
	szTip = szTip .. "<color=blue>Class: " .. it.szClass .. "<color>\n";
	return szTip;
end

function Item:Tip_Origin(nState)
	local pTempItem = KItem.CreateTempItem(
				it.nGenre,
				it.nDetail,
				it.nParticular,
				it.nLevel,
				it.nSeries,
				0,
				it.nLucky,
				it.GetGenInfo(),
				0,
				it.dwRandSeed,
				it.nIndex
			);
	local nValue = pTempItem.nValue;
	pTempItem.Remove();
	return nValue;
end