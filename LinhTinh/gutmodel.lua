-----------------------------------------------------
--文件名		：	gutmodel.lua
--创建者		：	tongxuehu@kingsoft.net
--创建时间		：	2007-02-06
--功能描述		：	ui的剧情模式。
------------------------------------------------------
local uiGutModel = Ui(Ui.UI_GUTMODEL);

local IMAGE_HEAD		= "ImgHead";
local IMAGE_FOOT		= "ImgFoot";
local PROGRESS_TIME		= 10;

uiGutModel.Init=function(self)
	self.nLoadCompleted   	= 0;
	self.tbOpeningCallback	= {};
	self.tbEndingCallback	= {};
end

uiGutModel.OnOpen=function(self)
	UiManager:SwitchUiModel(2);
end

uiGutModel.OnClose=function(self)
    UiManager:SwitchUiModel(0);
end

uiGutModel.Opening=function(self)	-- 开幕
    Prg_SetTime(self.UIGROUP, IMAGE_HEAD, PROGRESS_TIME, 0);
    Prg_SetTime(self.UIGROUP, IMAGE_FOOT, PROGRESS_TIME, 0);
end

uiGutModel.Ending=function(self)	-- 谢幕
	Prg_SetTime(self.UIGROUP, IMAGE_HEAD, PROGRESS_TIME, 1);
	Prg_SetTime(self.UIGROUP, IMAGE_FOOT, PROGRESS_TIME, 1);
end

uiGutModel.OnProgressFull=function(self, szWnd)
    if (szWnd == IMAGE_FOOT) then
        if self.nLoadCompleted == 0 then
        	for _, tbCall in ipairs(self.tbOpeningCallback) do
        		Lib:CallBack({ tbCall[2], tbCall[1], tbCall[3] });
        	end
        	self.tbOpeningCallback = {};
            self.nLoadCompleted = 1;
        else
            for _, tbCall in ipairs(self.tbEndingCallback) do
				Lib:CallBack({ tbCall[2], tbCall[1], tbCall[3] });
        	end
        	self.tbEndingCallback = {};
            UiManager:CloseWindow(self.UIGROUP);
            self.nLoadCompleted = 0;
        end 
    end
end

-- 剧情模式的入口函数
uiGutModel.GutBegin=function(self, varTable, varFunc, tbParam)
	if varTable and varFunc then
		table.insert(self.tbOpeningCallback, { varTable, varFunc, tbParam });
	end
--	if UiManager:WindowVisible(self.UIGROUP) ~= 1 then
--		UiManager:OpenWindow(self.UIGROUP);
--		self:Opening();
--	else
		self.nLoadCompleted = 0;
		Prg_SetTime(self.UIGROUP, IMAGE_HEAD, 0);
		self:OnProgressFull(IMAGE_FOOT)		
		Prg_SetTime(self.UIGROUP, IMAGE_FOOT, 0);
--	end
end

uiGutModel.GutEnd=function(self, varTable, varFunc, tbParam)
	if varTable and varFunc then
		table.insert(self.tbEndingCallback, { varTable, varFunc, tbParam });
	end
	self:Ending();
end
