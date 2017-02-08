local uiMsgPad = Ui(Ui.UI_MSGPAD)
uiMsgPad.MsgPad_bak = uiMsgPad.MsgPad_bak or uiMsgPad.OnSendMsgToChannel;
function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway, nSpeTitle)
	if string.find(szMsg,"Nội lực không đủ") or string.find(szMsg,"mở Rương Tàng Bảo Đồ") then
		return
	end
	if string.find(szMsg,"Nghe tiếng động") and me.nMapId >=1536 and  me.nMapId <= 1539 and szName~=me.szName and szChannelName~="Kin" then
		SendChannelMsg("Kin",szMsg);
	end
	if szChannelName=="Team" and string.find(szMsg,"Tanker: ")  then	
			local nStart = string.find(szMsg,"<pos=")
			local szTemp = string.sub(szMsg,nStart)
			local tbSplit	= Lib:SplitStr(szTemp, ",");
			--me.Msg(string.format("Chạy đến :%d - %d",tonumber(tbSplit[2]),tonumber(Lib:SplitStr(tbSplit[3],">")[1])))
			Map.AutoTanker.nX =tonumber(tbSplit[2]);
			Map.AutoTanker.nY=tonumber(Lib:SplitStr(tbSplit[3],">")[1]);	
		return
	end
	--[[if string.find(szMsg,"Em Cbi Buff") and szChannelName=="Team" and (not string.find(me.szName,Map.GtSetting.AccChinh)) and Map.GtSetting.AccChinh~="" and Map.AutoTanker.Start==nil then	
		--me.Msg("goi sao deo den")
		local nStart = string.find(szMsg,"<pos=")
		local szTemp = string.sub(szMsg,nStart)
		local tbSplit	= Lib:SplitStr(szTemp, ",");
		--me.Msg(""..Lib:SplitStr(tbSplit[3],">")[1].."--"..tbSplit[2].."--"..string.sub(tbSplit[1],6).."")
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ","..tonumber(string.sub(tbSplit[1],6))..","..tonumber(tbSplit[2])..","..tonumber(Lib:SplitStr(tbSplit[3],">")[1])..""});
	--	Map.tbSuperMapLink:StartGoto({szType = "pos", szLink =szTemp"});
		return
	end
	]]
	if szChannelName=="Team" and string.find(szMsg,"NewTanker:")  then	
			local nStart = string.find(szMsg,":")
			local szTemp = string.sub(szMsg,nStart+1)
			local nStart1 = string.find(szTemp,",")
			local szTemp1 = string.sub(szTemp,nStart1+1)
			local szTemp2 = string.sub(szTemp,0,nStart1-1)
			Map.AutoTanker.CosX = tonumber(szTemp2);
			Map.AutoTanker.SinX = tonumber(szTemp1);
			--me.Msg(string.format("%f |%f",Map.AutoTanker.CosX,Map.AutoTanker.SinX))
		return
	end
	if szName~=me.szName and string.find(szMsg,"cuu sat me") and szChannelName=="Personal" and me.nTeamId >0 then
		local tbMember = me.GetTeamMemberInfo();
		if szName == tbMember[1].szName then
			local pNpc = KNpc.GetByPlayerId(tbMember[1].nPlayerID);
			if pNpc then
				local bSucess = ProcessNpcById(pNpc.dwId, UiManager.emACTION_REVENGE);
			end
		end	
	end
	uiMsgPad.MsgPad_bak(Ui(Ui.UI_MSGPAD), szChannelName, szName, szMsg, szGateway, nSpeTitle)
end
