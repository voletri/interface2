
local tbAutoAsist	= Map.tbAutoAsist or {};
Map.tbAutoAsist		= tbAutoAsist;
local self = tbAutoAsist
tbAutoAsist.nAsistState = 0;		
tbAutoAsist.nStar = nil
local tbNoticed ={}
local nBF = 0
local szCmd = [=[
	Map.tbAutoAsist:Asistswitch();
]=];
UiShortcutAlias:AddAlias("GM_C3", szCmd);	

function tbAutoAsist:Asistswitch()
	if tbAutoAsist.nAsistState == 0 then 
		tbAutoAsist.nAsistState = 1;
		tbAutoAsist.nStar=Timer:Register(Env.GAME_FPS/2, tbAutoAsist.AutoBuff, tbAutoAsist);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật Tool Tự Buff SKill");
	else
		Timer:Close(tbAutoAsist.nStar);
		tbAutoAsist.nStar = nil;
		tbAutoAsist.nAsistState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<color=pink>Tắt auto buff<color>");
	end
end


function tbAutoAsist:AutoBuff()
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) or
			(Map.ScriptAuto:IsMapLoading()) then
		return
	end
	if  me.nFightState == 0 then
		return
	end
	--[[if me.nFaction == 9 and me.nRouteId ==2 then
		local _, _, nRestTime = me.GetSkillState(854);
		if not nRestTime and tbAutoAsist:CoDich()==1 then
			if me.GetNpc().nIsRideHorse == 1 then
				Switch("horse");
				return;
			end
			UseSkill(854)
		end
	end
	]]
	if me.GetNpc().nDoing == 6 or me.GetNpc().nDoing==4 then
		return
	end
	--me.Msg(string.format("%d-%d",me.nFaction,me.nRouteId))
	nBF = nBF + 1
	if nBF > 10 then
		nBF = 0
		tbNoticed ={}
	end
	local nSkillId = self:GetRunSkillId();
	-- luong nghi kiem phap 854
	if (nSkillId > 0) then
		AutoAi.AssistSelf(nSkillId)
	end
end
function tbAutoAsist:CoDich()
	local tbNpc = SyncNpcInfo();
	local nTmpNPCs = 0
	if tbNpc then
		for i, tbNpcInfo in ipairs(tbNpc) do
			if tbNpcInfo.nType ==7 or tbNpcInfo.nType ==6 or tbNpcInfo.nType ==5 then
				nTmpNPCs = 1
			end
		end	
	end
	return nTmpNPCs
end
function tbAutoAsist:GetRunSkillId()
	local tbAssistSkill	= {115, 132, 177, 230, 180, 838, 697, 26, 46, 55, 161, 783, 191, 835, 850, 836, 78, 2808, 812, 110, 3016, 
	3187, 3192, 3191, 3193, 3188, 3189, 3190,		-- 木宗门
	3213, 3715, 3215, 3713, 3214, 3218, 3216,		-- 火宗门
	3573, 3530, 3579, 3577, 3575 , 3574,
	3480,3481,3482,3483,3484};			-- 土宗门

	for _, nSkillId in ipairs(tbAssistSkill) do
		if (me.CanCastSkill(nSkillId) == 1) then
			--me.Msg(""..nSkillId.."")
			if nSkillId == 836 then
				nSkillId = 873
			end
			local ncctime
			if nSkillId == 850 then
				ncctime = Env.GAME_FPS * 60
			elseif nSkillId == 161 or nSkillId == 783 then
				ncctime = Env.GAME_FPS * 40
			else
				ncctime = 45
			end
			if tbNoticed[nSkillId] then
				return 0
			end
			tbNoticed[nSkillId] = 1

			local _, _, nRestTime = me.GetSkillState(nSkillId);
			if (not nRestTime or nRestTime < ncctime) then			
				return nSkillId;
			end
		end
	end
	return 0;
end
