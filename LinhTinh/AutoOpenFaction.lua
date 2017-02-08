

local AutoOpenFaction			     = Ui:GetClass("AutoOpenFaction");
local tbSaveData 				       = Ui.tbLogic.tbSaveData;

AutoOpenFaction.BTN_CLOSE		    = "BtnClose";
AutoOpenFaction.BTN_SAVE         = "BtnSave"; 
AutoOpenFaction.BTN_EXIT         = "BtnExit"; 

AutoOpenFaction.EDT_Lenh1		= "EdtLenh1";			
AutoOpenFaction.EDT_Lenh2		= "EdtLenh2";		
AutoOpenFaction.EDT_Lenh3		= "EdtLenh3";		
AutoOpenFaction.TXT_Title11		="TxtTitle11";
AutoOpenFaction.TXT_Title12		="TxtTitle12";
AutoOpenFaction.TXT_Title13		="TxtTitle13";
AutoOpenFaction.TXT_Title14		="TxtTitle14";
AutoOpenFaction.DATA_KEY			= "AutoOpenFaction";
AutoOpenFaction.tbSetting		= {};

local self = AutoOpenFaction;
--self.tbSetting.nLenh1 =0;
--self.tbSetting.nLenh2 =0;
--self.tbSetting.nLenh3 =0;


function AutoOpenFaction:OnOpen()
	self.tbSetting	= AutoOpenFaction:Load(self.DATA_KEY) or {};

	
	if not self.tbSetting.nLenh1 then
		self.tbSetting.nLenh1 = 0;
	end

	if not self.tbSetting.nLenh2 then
		self.tbSetting.nLenh2 = 0;
	end
	if not self.tbSetting.nLenh1 then
		self.tbSetting.nLenh3 = 0;
	end
	Edt_SetTxt(self.UIGROUP, self.EDT_Lenh1, self.tbSetting.nLenh1);
	Edt_SetTxt(self.UIGROUP, self.EDT_Lenh2, self.tbSetting.nLenh2);
	Edt_SetTxt(self.UIGROUP, self.EDT_Lenh3, self.tbSetting.nLenh3);
end

function AutoOpenFaction:OnClose()

end

function AutoOpenFaction:SaveSetting()
	self:GetEdtValue();
	AutoOpenFaction:Save(self.DATA_KEY, self.tbSetting);
end

function AutoOpenFaction:OnButtonClick(szWnd, nParam)
	if szWnd == self.BTN_CLOSE or szWnd == self.BTN_EXIT then
		UiManager:CloseWindow("UI_AUTO_OPEN_FACTION");
	elseif szWnd == self.BTN_SAVE then
		self:SaveSetting();
		UiManager:CloseWindow("UI_AUTO_OPEN_FACTION");
	end
end

function AutoOpenFaction:GetEdtValue()
	local szLenh1 = Edt_GetInt(self.UIGROUP, self.EDT_Lenh1)
	if szLenh1 == "" or nil then
		self.tbSetting.nLenh1 = 0
	else
		self.tbSetting.nLenh1 = tonumber(szLenh1)
	end

	local szLenh2 = Edt_GetInt(self.UIGROUP, self.EDT_Lenh2)
	if szLenh2 == "" or nil then
		self.tbSetting.nLenh2 = 0
	else
		self.tbSetting.nLenh2 = tonumber(szLenh2)
	end
	

	local szLenh3 = Edt_GetInt(self.UIGROUP, self.EDT_Lenh3)
	if szLenh3 == "" or nil then
		self.tbSetting.nLenh3 = 0
	else
		self.tbSetting.nLenh3 = tonumber(szLenh3)
	end

	
end


Ui:RegisterNewUiWindow("UI_AUTO_OPEN_FACTION", "AutoOpenFaction", {"a", 200, 66}, {"b", 515, 320}, {"c", 770,320}, {"d", 770,320});


function AutoOpenFaction:Save(szKey, tbData)
	self.m_szFilePath="\\User\\AutoOpenFaction\\"..me.szName.."_setting.dat";
	self.m_tbData = {};
	self.m_tbData[szKey] = tbData;
	print(tbData);
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KFile.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end


function AutoOpenFaction:Load(key)
	self.m_szFilePath="\\User\\AutoOpenFaction\\"..me.szName.."_setting.dat";
	self.m_tbData = {};
	print(key);
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if (szData) then
		if self:CheckErrorData(szData) == 1 then		
			self.m_tbData = Lib:Str2Val(szData);
		else
			KFile.WriteFile(self.m_szFilePath, "");
		end
	end
	local tbData = self.m_tbData[key];
	print(self.m_tbData);
	return tbData;
end


function AutoOpenFaction:CheckErrorData(szDate)
	if szDate ~= "" then
		if string.find(szDate, "Ptr:") and string.find(szDate, "ClassName:") then
			return 0;
		end
		if (not Lib:CallBack({"Lib:Str2Val", szDate})) then	
			return 0;
		end
	end
	return 1;
end

function AutoOpenFaction:Reload()
    local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface2\\LinhTinh\\AutoOpenFaction.lua");
	
  
end


local szCmd = [=[
	UiManager:SwitchWindow(Ui.UI_AUTO_OPEN_FACTION);
	]=];
	UiShortcutAlias:AddAlias("GM_C7", szCmd);	
