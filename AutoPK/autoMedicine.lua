
local self = GtAutoMedicine;
local GtAutoMedicine	= Map.GtAutoMedicine or {};
Map.GtAutoMedicine		= GtAutoMedicine;
local INTERVAl_RED	  = Env.GAME_FPS / 3;    -- Env.GAME_FPS = 1s
local INTERVAl_BLUE   = Env.GAME_FPS / 2;    
local nSwithRed =1; ---  =0 la ngung
local nSwithBlue =1
local TimeRed = nil;
local TimeBlue = nil;
local nLifeRet        = 90;         -- % máu          
local nManaLeft       = 30;         -- % Mana      
local nStamina = 30;  
local RED  = {};
local BLUE = {};
local STAMINA = {};
local MEDICINE_Global_Detail = {9, 11, 16, 17, 18, 19, 20};--跨服药类型

local MEDICINE_RED = {
	{17,3,1,6},
	{17,1,1,7},
	{17,1,1,6},
	{17,20002,1,2},
	{17,20000,1,5},
};

local MEDICINE_BLUE = {
	{17,2,1,7},
	{17,2,1,6},	
	
};

local MEDICINE_STAMI = {
	{17,4,1,5},
	
	
};
function GtAutoMedicine:SwithAutoRed()
	--me.Msg(string.format("Bật tool tự động uống máu ,Sinh lực :%d",nLifeRet));
	nSwithRed=0;
	TimeRed = Ui.tbLogic.tbTimer:Register(INTERVAl_RED,GtAutoMedicine.OnEatRedTimer,GtAutoMedicine);
end
function GtAutoMedicine:SwithAutoBlue()
	--me.Msg(string.format("Bật tool tự động uống Mana ,Nội lực : %d",nManaLeft));
	nSwithBlue=0;
	TimeBlue = Ui.tbLogic.tbTimer:Register(INTERVAl_BLUE,GtAutoMedicine.OnEatBlueTimer,GtAutoMedicine);
end
function GtAutoMedicine:OnEatRedTimer()
	if me.nFightState ~= 1 then
		return
	end
	if (me.nCurLife * 100 / me.nMaxLife < nLifeRet)  then	
		for i,tbYAO in pairs(MEDICINE_RED) do
			local tbFind = me.FindItemInBags(unpack(tbYAO));
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
				return;
			end
		end
	end
end

function GtAutoMedicine:OnEatBlueTimer()
	if me.nFightState ~= 1 then
		return
	end

	if (me.nCurMana * 100 / me.nMaxMana < nManaLeft) then			
		for i,tbYAO in pairs(MEDICINE_BLUE) do
			local tbFind = me.FindItemInBags(unpack(tbYAO));
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
				return;
			end
		end
	end
end

function GtAutoMedicine:Init()
	GtAutoMedicine.EnterGame_bak	= GtAutoMedicine.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		GtAutoMedicine.EnterGame_bak(Ui);
		GtAutoMedicine:OnEnterGame();
	end
end

function GtAutoMedicine:OnEnterGame()
	if nSwithRed == 1 then
		GtAutoMedicine:SwithAutoRed()
	end
	if nSwithBlue == 1 then
		GtAutoMedicine:SwithAutoBlue()
	end
end

Map.GtAutoMedicine:Init();
