--cyberdemon--
local tbReplyData	= Map.tbReplyData or {};
Map.tbReplyData		= tbReplyData;
local tbMsgInfo = Ui.tbLogic.tbMsgInfo;
local callStart = 1
local ARStart = 0;
local szMsgReply
local szMsgReply2
local szMsgReply3
local szMsgReply4
local szMsgReply5

tbReplyData.Switch = function(self)
	if ARStart == 0 then 
		ARStart = 1;
		me.Msg("<color=green>Bật tự động trả lời");
		szMsgReply = KFile.ReadTxtFile("\\setting\\talk\\reply.txt");
		szMsgReply2 = KFile.ReadTxtFile("\\setting\\talk\\reply2.txt");
		szMsgReply3 = KFile.ReadTxtFile("\\setting\\talk\\reply3.txt");
		szMsgReply4 = KFile.ReadTxtFile("\\setting\\talk\\reply4.txt");
		szMsgReply5 = KFile.ReadTxtFile("\\setting\\talk\\reply5.txt");
	else
		ARStart = 0;
		me.Msg("<color=green>Tắt tự động trả lời");
	end
end

function tbReplyData:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	tbReplyData.Say_bak	= tbReplyData.Say_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway)
		tbReplyData.Say_bak(Ui(Ui.UI_MSGPAD), szChannelName, szName, szMsg, szGateway);
		local function fnOnSay()
			tbReplyData:OnSay(szChannelName, szName, szMsg, szGateway);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
end

function tbReplyData:OnSay(szChannelName, szSendName, szMsg)
	if (ARStart ~= 0) and (szChannelName == "Personal") then
		local function fnOnSay1()
			ARStart = 1
			return 0;
		end
		ARStart = 0
		Ui.tbLogic.tbTimer:Register(50, fnOnSay1);
		SendChatMsg("/"..szSendName.." "..szMsgReply);
		SendChatMsg("/"..szSendName.." "..szMsgReply2);
		SendChatMsg("/"..szSendName.." "..szMsgReply3);
		SendChatMsg("/"..szSendName.." "..szMsgReply4);
		SendChatMsg("/"..szSendName.." "..szMsgReply5);
	end
end

function tbReplyData:Init()
	tbReplyData:ModifyUi()
end

tbReplyData:Init()