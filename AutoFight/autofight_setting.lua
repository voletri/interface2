

if not MODULE_GAMECLIENT then
	return
end

Require("\\script\\player\\define.lua");

local preEnv = _G;	
setfenv(1, AutoAi);	


ASSIST_SKILL_LIST = {
	[preEnv.Player.FACTION_NONE]		= {};		
	[preEnv.Player.FACTION_SHAOLIN]		= {26};		
	[preEnv.Player.FACTION_TIANWANG]	= {46,55};	
	[preEnv.Player.FACTION_TANGMEN]		= {};		
	[preEnv.Player.FACTION_WUDU]		= {78};		
	[preEnv.Player.FACTION_EMEI]		= {835,1249,836,838};		
	[preEnv.Player.FACTION_CUIYAN]		= {115};	
	[preEnv.Player.FACTION_GAIBANG]		= {132,489};	
	[preEnv.Player.FACTION_TIANREN]		= {850};		
	[preEnv.Player.FACTION_WUDANG]		= {161,783};	
	[preEnv.Player.FACTION_KUNLUN]		= {177,180,191,697};
	[preEnv.Player.FACTION_MINGJIAO]	= {};	
	[preEnv.Player.FACTION_DUANSHI]		= {230};	
	[preEnv.Player.FACTION_GUMU]		= {2808};	
	[preEnv.Player.FACTION_XOYO]		= {3016};	
};


ATTACK_RANGE = 800;						
KEEP_RANGE_MODE = 1;					
NPC_AVOID_ATTACK = "" 		
LIFE_RETURN = 0; 							
MANA_LEFT = 40; 							
MAX_SKILL_RANGE = 800;				
FOOD_SKILL_ID=476;	

RESUME_GOUHUO_FIRED = 1; 	
TIME_WINE_EFFECT = 3 * 60; 	
TIME_FIRE_EFFECT = 15 * 60; 

WINES = {
	[1] = {18,1,48,1}, 
	[2] = {18,1,49,1}, 
	[3] = {18,1,50,1}, 
	[4] = {18,1,51,1}, 
	[5] = {18,1,52,1}, 
}
JINXI = {
	[1] = {18,1,2,1}, 
	[2] = {18,1,2,2},
	[3] = {18,1,2,3}, 
	[4] = {18,1,2,4},
	[5] = {18,1,2,5}, 
}
XIULIANZHU			= {18,1,16,1}	
WINE_SKILL_ID		= 378;
FIRE_SKILL_ID		= 377;	
ENHANCE_EXP_SKILL_ID = 332; 


ITEM_PICK_LIST = ""

ITEM_NOPICK_LIST = ""


EAT_SLEEP = 2;			
ACTIVE_RADIUS = 800;	
VISION_RADIUS = 1200;	
NPC_ONLY_ATTACK = ";";	
HEAD_STATE_SKILLID = 94; 


preEnv.setfenv(1, preEnv);	
