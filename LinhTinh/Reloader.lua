
local self = tbReloader;

local tbReloader	= Map.tbReloader or {};
Map.tbReloader		= tbReloader;

local nState = 0;
local nTimerId = 0;
local lenngua =0
local tbParam = {};
local tbGetParam = {};
local uiSayPanel = Ui(Ui.UI_SAYPANEL);
local DuongDan = "interface2\\DeBug\\NhiemVu.txt"
local DuongDan1 = "interface2\\DeBug\\ToaDo.txt"

function tbReloader:OnStart()
	if nState == 0 then
		nState = 1;
		nTimerId = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.OnTimer,self);
	elseif nState == 1 then
		nState = 0;
		Ui.tbLogic.tbTimer:Close(nTimerId);
		nTimerId = 0;
	end
end
function tbReloader:OnTimer()
	if me.nMapId > 0 then
		if lenngua == 0 then
			local function fnDoScript(szFilePath)
				local szFileData	= KFile.ReadTxtFile(szFilePath);
				assert(loadstring(szFileData, szFilePath))();
			end
			local szMainReload = "\\interface2\\LinhTinh\\LenNgua.lua";
				fnDoScript(szMainReload);
			--me.Msg(""..szMainReload.."")
		--	me.Msg("<color=yellow>Hoàn thành reload file "..szMainReload.."");
			lenngua =1;
		elseif lenngua ==1 then
			tbReloader:OnStart()
		end
	
	end
end
function tbReloader:OnSwitch()
		--for i = 0,1 do	
		--	for j = 1,10 do
			--	if  me.GetTask((1001+i),j) > 0 then
				--	me.Msg(""..j..","..i.." = "..(me.GetTask((1001+i),j)).."");
					--local szTex = KFile.ReadTxtFile(DuongDan)
					--local szData = ""..szTex.."----"..j.."="..(me.GetTask((1001),j)).."----" 
					--KFile.WriteFile(DuongDan,szData)
				--end
				--end	
			--end
			--self:NpcXungQuanh()
		tbReloader:ToaDo()
		self:Refresh2();
end

function tbReloader:AppendFile(szTxt, szFN, bCheck, bDate, szCheck)

	if not bCheck then
		bCheck = 0
	end
	if not bDate then
		bDate = 0
	end
	if (not szCheck) or (szCheck == "") then
		szCheck = szTxt
	end
	local szData = KFile.ReadTxtFile(szFN)
	if szData == nil then
		szData = ""
	end
	if (bDate == 1) then
		local szDte = GetLocalDate("%d/%m/%Y")
		if not string.find(szData, szDte) then
			szData = szDte.."\r\n"..szData
		end
	end
	if (bCheck == 1) and string.find(szData, szCheck) then
		return 0
	end
	szData = szTxt.."\r\n"..szData
	KFile.WriteFile(szFN, szData)
	return 1
end

function tbReloader:OnMove()
	-- if me.IsDead() == 1 then	
		-- me.SendClientCmdRevive(0);
		-- return;
	-- end
	-- if me.nFightState ~= 0 then
		-- me.AutoPath(1516,3414);
	-- else
		-- me.AutoPath(1478,3537);
	-- end
	-- if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
		-- me.AnswerQestion(0);
		-- me.AnswerQestion(1);
		-- me.AnswerQestion(1);
		
		-- UiManager:CloseWindow(Ui.UI_SAYPANEL);
	-- end
end

function tbReloader:NpcXungQuanh()
	local tbAroundNpc = KNpc.GetAroundNpcList(me, 200);
	for _, pNpc in ipairs(tbAroundNpc) do	
			if pNpc.nTemplateId > 0 then
			local nX,nY = pNpc.GetMpsPos()
			me.Msg("ID: ".. pNpc.nTemplateId .." - namez: ".. pNpc.szName .." - "..pNpc.nId.."");
			--local szData = ""..pNpc.nTemplateId.."- name :"..pNpc.szName.."" 
		--	tbReloader:AppendFile(szData, DuongDan)
			end	
	end
end
function tbReloader:ToaDo()
	local szData ="";
	--local tbAroundNpc = KNpc.GetAroundNpcList(me, 400);
	--for _, pNpc in ipairs(tbAroundNpc) do	
		--	if pNpc.nTemplateId > 0 then
			--	local nX,nY = pNpc.GetMpsPos()
			--	szData="ID: ".. pNpc.nTemplateId .." - namez: ".. pNpc.szName .." --"..nX.."--"..nY.."";
			--end	
	--end
	local nM, nX, nY = me.GetWorldPos()
	szData=string.format("{%d,%d},",nX,nY)
	tbReloader:AppendFile(szData, DuongDan1)
	me.Msg(""..szData.."")
end
function tbReloader:Refresh()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	local szFileReload = "\\interface\\LinhTinh\\Test.lua";
	me.Msg("Reload "..szFileReload.."");
	fnDoScript(szFileReload);
	me.Msg("<color=yellow>Hoàn thành reload file "..szFileReload.."");
end

function tbReloader:Refresh2()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	local szMainReload = "\\interface2\\LinhTinh\\Reloader.lua";
	fnDoScript(szMainReload);
	me.Msg(""..szMainReload.."")
	--local szMainReload = "\\interface2\\AutoTrade\\AutoTrade.lua";
	--fnDoScript(szMainReload);
	--me.Msg(""..szMainReload.."")
	local szMainReload = "\\interface2\\AutoPK\\giangthanhngt.lua";
	fnDoScript(szMainReload);
	me.Msg(""..szMainReload.."")
	local szMainReload = "\\interface2\\ScriptAuto\\AutoBossQinshihuangling.lua";
	fnDoScript(szMainReload);
	me.Msg(""..szMainReload.."")
	
end

function tbReloader:LenNgua()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	local szFileReload = "\\interface\\LinhTinh\\LenNgua.lua";
	me.Msg("Reload "..szFileReload.."");
	fnDoScript(szFileReload);
	me.Msg("<color=yellow>Hoàn thành reload file "..szFileReload.."");
end

function tbReloader:Init()
	tbReloader.EnterGame_bak	= tbReloader.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		tbReloader.EnterGame_bak(Ui);
		tbReloader:OnEnterGame();
	end
end

function tbReloader:OnEnterGame()
	tbReloader:OnStart()
end

tbReloader:Init();
local tCmd={"Map.tbReloader:OnSwitch()", "GoR", "", "Shift+R", "Shift+R", "GoR"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);