
-----------------------------------------------------
local szCmd = [=[
	AutoAi:JieBao();
]=];
UiShortcutAlias:AddAlias("GM_C2", szCmd);	-- �ȼ���Alt + 3

function AutoAi:JieBao()

	local pTabFile = KIo.OpenTabFile("\\setting\\setting.pak.txt");
	local nHeight = pTabFile.GetHeight();
	for i = 3, nHeight do
		local nFile 	= pTabFile.GetStr(i, 4);
		local szMsg	= KFile.ReadTxtFile(nFile);
		KFile.WriteFile("\\PAK"..nFile, szMsg);
	end
	KIo.CloseTabFile(pTabFile);

	local pTabFile = KIo.OpenTabFile("\\script\\script.pak.txt");
	local nHeight = pTabFile.GetHeight();
	for i = 3, nHeight do
		local nFile 	= pTabFile.GetStr(i, 4);
		local szMsg	= KFile.ReadTxtFile(nFile);
		KFile.WriteFile("\\PAK"..nFile, szMsg);
	end
	KIo.CloseTabFile(pTabFile);

	local pTabFile = KIo.OpenTabFile("\\ui\\ui.pak.txt");
	local nHeight = pTabFile.GetHeight();
	for i = 3, nHeight do
		local nFile 	= pTabFile.GetStr(i, 4);
		local szMsg	= KFile.ReadTxtFile(nFile);
		KFile.WriteFile("\\PAK"..nFile, szMsg);
	end
	KIo.CloseTabFile(pTabFile);
--	me.Msg("���޺ۡ���ʾ:PAK�����ɣ���<color=yellow>-��������--PAK--<color>�ļ��С���Alt+9��");
end

--AutoAi:JieBao();

