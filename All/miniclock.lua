Ui.UI_MINICLOCK			= "UI_MINICLOCK";
local uiMiniClock		= Ui.tbWnd[Ui.UI_MINICLOCK] or {};	-- 支持重载
uiMiniClock.UIGROUP		= Ui.UI_MINICLOCK;
Ui.tbWnd[Ui.UI_MINICLOCK] = uiMiniClock;
uiMiniClock.TXX_CTRL 	= "TxtCtrl";
uiMiniClock.TXX_TIME 	= "TxtTime";
uiMiniClock.WND_MAIN 	= "Main";
Ui:RegisterNewUiWindow("UI_MINICLOCK", "miniclock", {"a", 780, 594}, {"b", 1013, 762});
uiMiniClock.tbAllModeResolution	= {
	["a"]	= { 780, 594 },
	["b"]	= { 1013, 762 },
};
uiMiniClock.tbTimeStyle	= {
	{"New Style",	"<font=14><color=yellow>%H:%M:%S"},
};

function uiMiniClock:OnEnterGame()
	if (not self.szCurStyle) then
		self:SetStyle(1);
	end
	local function fnOnTimer()
		self:OnTimer();
	end
	Ui.tbLogic.tbTimer:Register(Env.GAME_FPS / 2, fnOnTimer);
	UiManager:OpenWindow(self.UIGROUP);
end

function uiMiniClock:OnOpen()
	TxtEx_SetText(self.UIGROUP, self.TXX_CTRL, "");
end

function uiMiniClock:OnTimer()
	if (self.bTempText ~= 1) then
		local szText	= os.date(self.szCurStyle, GetTime());
		Wnd_SetSize(self.UIGROUP, self.TXX_TIME, 0, 0);
		TxtEx_SetText(self.UIGROUP, self.TXX_TIME, szText);
	end
	local nWidth, nHeight	= Wnd_GetSize(self.UIGROUP, self.TXX_TIME);
	nWidth	= nWidth + 10;
	Wnd_SetSize(self.UIGROUP, self.WND_MAIN, nWidth, nHeight);
	local nCurX, nCurY	= Wnd_GetPos(self.UIGROUP, self.WND_MAIN);
	local tbModeResolution	= self.tbAllModeResolution[GetUiMode()];
	local nNewX	= math.min(math.max(0, nCurX), tbModeResolution[1] - nWidth);
	local nNewY	= math.min(math.max(0, nCurY), tbModeResolution[2] - nHeight);
	Wnd_SetPos(self.UIGROUP, self.WND_MAIN, nNewX, nNewY);
	
end



function uiMiniClock:Init()
	self.EnterGame_bak	= self.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		uiMiniClock:OnEnterGame();
		uiMiniClock.EnterGame_bak(Ui);
	end
end

function uiMiniClock:SetStyle(nIndex)
	self.bTempText	= 0;
	self.szCurStyle	= self.tbTimeStyle[nIndex][2];
end

uiMiniClock:Init();