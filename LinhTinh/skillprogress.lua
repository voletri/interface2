-----------------------------------------------------
--�ο��ļ���	��	skillprogress.lua
--ԭ�ļ�������	��	tongxuehu@kingsoft.net
--�޸�ʱ��	��	2009-12-05
--��������	��	�Զ��رռ���������
--�޸���		���Ϲ�����
--ע������	���뱣������˵���������ֶ�ԭ���ߺ��޸��ߵ�����
------------------------------------------------------

local tbSkillProgress = Ui(Ui.UI_SKILLPROGRESS);

local PRG_PROGRESS	= "PrgProgress";
local TXT_MSG		= "TxtMsg";
local TXT_PROGRESS	= "TxtProgress";
local nTimerIdToClose = 0;

tbSkillProgress.OnOpen=function(self)
	local nTimerId, nInterval, szMsg = me.GetTimerBar();
	if nInterval and szMsg then
		if nInterval > 0 then
			Txt_SetTxt(self.UIGROUP, TXT_MSG, szMsg);
			Txt_SetTxt(self.UIGROUP, TXT_PROGRESS, "0%");
			Prg_SetTime(self.UIGROUP, PRG_PROGRESS, math.floor(nInterval / Env.GAME_FPS * 1000));
		else
			return 0;
		end
	end
	nTimerIdToClose = Ui.tbLogic.tbTimer:Register(nInterval, self.OnCloseEx, self);
	return 1;
end

tbSkillProgress.OnCloseEx = function(self)
	UiManager:CloseWindow(Ui.UI_SKILLPROGRESS);
end

tbSkillProgress.OnClose = function (self)
	if nTimerIdToClose and nTimerIdToClose > 0 then
		Ui.tbLogic.tbTimer:Close(nTimerIdToClose);
		nTimerIdToClose	= 0;
	end
end
