

Ui.UI_MINICLOCK			= "UI_MINICLOCK";

local uiMiniClock		= Ui.tbWnd[Ui.UI_MINICLOCK] or {};	-- ÷ß≥÷÷ÿ‘ÿ
uiMiniClock.UIGROUP		= Ui.UI_MINICLOCK;
Ui.tbWnd[Ui.UI_MINICLOCK] = uiMiniClock;

uiMiniClock.TXX_TIME 	= "TxtTime";
uiMiniClock.WND_MAIN 	= "Main";

Ui:RegisterNewUiWindow("UI_MINICLOCK", "miniclock", {"a", 790, 590}, {"b", 1020, 743}, {"c", 1280, 770});

uiMiniClock.tbAllModeResolution	= {
	["a"]	= { 790, 590 },
	["b"]	= { 1020, 743 },
	["c"]	= { 1280, 770 },
};


function uiMiniClock:OnEnterGame()
	
	local function fnOnTimer()
		self:OnTimer();
	end
	Ui.tbLogic.tbTimer:Register(Env.GAME_FPS / 2, fnOnTimer);

	UiManager:OpenWindow(self.UIGROUP);
end

function uiMiniClock:OnOpen()
	
end

function uiMiniClock:OnTimer()
	
	local szText	= os.date("<font=24><bclr=red><color=white>%H:%M:%S", GetTime());
	Wnd_SetSize(self.UIGROUP, self.TXX_TIME, 0, 0);
	TxtEx_SetText(self.UIGROUP, self.TXX_TIME, szText);
	
	
	local nWidth, nHeight	= Wnd_GetSize(self.UIGROUP, self.TXX_TIME);
	Wnd_SetSize(self.UIGROUP, self.WND_MAIN, nWidth, nHeight);
	
	local nCurX, nCurY	= Wnd_GetPos(self.UIGROUP, self.WND_MAIN);
	local tbModeResolution	= self.tbAllModeResolution[GetUiMode()];
	local nNewX	= math.min(math.max(0, nCurX), tbModeResolution[1] - nWidth);
	local nNewY	= math.min(math.max(0, nCurY), tbModeResolution[2] - nHeight);
	Wnd_SetPos(self.UIGROUP, self.WND_MAIN, nNewX, nNewY);
end


function uiMiniClock:_Init()
	self.EnterGame_bak	= self.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		uiMiniClock.EnterGame_bak(Ui);
		uiMiniClock:OnEnterGame();
	end
end

uiMiniClock:_Init();
