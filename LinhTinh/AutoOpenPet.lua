

local AutoOpenPet			     = Ui:GetClass("AutoOpenPet");
local tbSaveData 				       = Ui.tbLogic.tbSaveData;

AutoOpenPet.BTN_CLOSE		    = "BtnClose";
AutoOpenPet.BTN_SAVE         = "BtnSave"; 
AutoOpenPet.BTN_EXIT         = "BtnExit"; 

AutoOpenPet.EDT_Lenh1		= "EdtLenh1";			
AutoOpenPet.EDT_Lenh2		= "EdtLenh2";		
AutoOpenPet.EDT_Lenh3		= "EdtLenh3";		
AutoOpenPet.TXT_Title11		="TxtTitle11";
AutoOpenPet.TXT_Title12		="TxtTitle12";
AutoOpenPet.TXT_Title13		="TxtTitle13";
AutoOpenPet.TXT_Title14		="TxtTitle14";
AutoOpenPet.DATA_KEY			= "AutoOpenPet";
AutoOpenPet.tbSetting		= {};

local self = AutoOpenPet;
--self.tbSetting.nLenh1 =0;
--self.tbSetting.nLenh2 =0;
--self.tbSetting.nLenh3 =0;


function AutoOpenPet:OnOpen()
	self.tbSetting	= AutoOpenPet:Load(self.DATA_KEY) or {};

	
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

function AutoOpenPet:OnClose()

end

function AutoOpenPet:SaveSetting()
	self:GetEdtValue();
	AutoOpenPet:Save(self.DATA_KEY, self.tbSetting);
end

function AutoOpenPet:OnButtonClick(szWnd, nParam)
	if szWnd == self.BTN_CLOSE or szWnd == self.BTN_EXIT then
		UiManager:CloseWindow("UI_AUTO_OPEN_PET");
	elseif szWnd == self.BTN_SAVE then
		self:SaveSetting();
		UiManager:CloseWindow("UI_AUTO_OPEN_PET");
	end
end

function AutoOpenPet:GetEdtValue()
	local szLenh1 = Edt_GetInt(self.UIGROUP, self.EDT_Lenh1)
	if szLenh1 == "" or nil then
		self.tbSetting.nLenh1 = 0
	else
		self.tbSetting.nLenh1 = tonumber(szLenh1)
	end
	if self.tbSetting.nLenh1 > 5 then
		self.tbSetting.nLenh1 = 0
	end

	local szLenh2 = Edt_GetInt(self.UIGROUP, self.EDT_Lenh2)
	if szLenh2 == "" or nil then
		self.tbSetting.nLenh2 = 0
	else
		self.tbSetting.nLenh2 = tonumber(szLenh2)
	end
	if self.tbSetting.nLenh2 > 5 then
		self.tbSetting.nLenh2 = 0
	end

	local szLenh3 = Edt_GetInt(self.UIGROUP, self.EDT_Lenh3)
	if szLenh3 == "" or nil then
		self.tbSetting.nLenh3 = 0
	else
		self.tbSetting.nLenh3 = tonumber(szLenh3)
	end
	if self.tbSetting.nLenh3 > 5 then
		self.tbSetting.nLenh3 = 0
	end
	
end


Ui:RegisterNewUiWindow("UI_AUTO_OPEN_PET", "AutoOpenPet", {"a", 200, 66}, {"b", 515, 320}, {"c", 770,320}, {"d", 770,320});


function AutoOpenPet:Save(szKey, tbData)
	self.m_szFilePath="\\User\\AutoOpenPet\\"..me.szName.."_setting.dat";
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


function AutoOpenPet:Load(key)
	self.m_szFilePath="\\User\\AutoOpenPet\\"..me.szName.."_setting.dat";
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


function AutoOpenPet:CheckErrorData(szDate)
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

function AutoOpenPet:Reload()
    local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface2\\LinhTinh\\AutoOpenPet.lua");
	
  
end


local szCmd = [=[
	UiManager:SwitchWindow(Ui.UI_AUTO_OPEN_PET);
	]=];
	UiShortcutAlias:AddAlias("GM_C8", szCmd);	
