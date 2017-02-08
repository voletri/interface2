local self = GtNPC;

local GtNPC	= Map.GtNPC or {};
Map.GtNPC		= GtNPC;
local uiSayPanel = Ui(Ui.UI_SAYPANEL);

function GtNPC:TalkNPC(Name,nMapId,nX,nY)
	
	local NPCName = self.FindNPCName(Name,200)
	if NPCName then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1 then
			AutoAi.SetTargetIndex(NPCName.nIndex);
		end
	else
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ","..nMapId..","..nX..","..nY..""});
	end
	
end


function GtNPC.FindNPCName(name,dis)
	local tbNpcList = KNpc.GetAroundNpcList(me,dis);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.szName==name then
			return pNpc
		end
	end
end
function GtNPC.FindNPCNamestring(name,dis)
	local tbNpcList = KNpc.GetAroundNpcList(me,dis);
	for _, pNpc in ipairs(tbNpcList) do
		if string.find(pNpc.szName,name) then
			return pNpc
		end
	end
end

function GtNPC.FindNPCId(nTemplateId,dis)
	local tbNpcList = KNpc.GetAroundNpcList(me,dis);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.nTemplateId==nTemplateId then
			return pNpc
		end
	end
end
local tCmd={"UiManager:OpenWindow(Ui.UI_REPOSITORY)", "MoRuongTuXa", "", "Ctrl+R", "Ctrl+R", "MoRuongTuXa"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);