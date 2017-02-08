-----------------------------------------------------
--�ļ���		��	guttalk.lua
--������		��	tongxuehu@kingsoft.net
--����ʱ��	��	2007-02-06
--��������	��	���پ���Ի� ��塣
--���ߣ����г�
-- ����˹�� 2007/11/15 PM 03:41 �������ּ�ʱ����
------------------------------------------------------

local uiGutTalk = Ui(Ui.UI_GUTTALK)
local tbTimer = Ui.tbLogic.tbTimer;

local IMAGE_PORTRAIT		= "ImgPortrait";
local TEXT_DIALOG		    = "TxtDialog";
local DEFAULT_PORTRAIT		= "";


uiGutTalk.OnButtonClick = function(self ,szWndName, nParam)
	if self.nTimerId ==0 then
		self:ShowNextSentence();
	else
		if self.nTimerId and (self.nTimerId ~= 0) then
			tbTimer:Close(self.nTimerId);
			self.nTimerId = 0;
		end
		Txt_SetTxt(self.UIGROUP, TEXT_DIALOG, self.szOrgText);
	end
end

uiGutTalk.ShowNextSentence = function(self)
	local szPic = "";
	local nMyMap,nMyX, nMyY = me.GetWorldPos();
	szPic, self.szMainText = self:GetNextSentence();
	self.szOrgText = self.szMainText;
	----print(self.szMainText)
	if szPic and self.szMainText then
		Img_SetImage(self.UIGROUP, IMAGE_PORTRAIT, 1, szPic);
		if nMyMap == 25 or nMyMap == 27 or nMyMap == 28 then
			me.Msg("<color=0,255,255>"..self.szOrgText.."<color>");
		end
		tbTimer:Close(self.nTimerId);
		self.nTimerId = 0;
		Txt_SetTxt(self.UIGROUP, TEXT_DIALOG, self.szOrgText);

		if (not self.nTimerId) or (self.nTimerId == 0) then
			local function nextsentense()
				uiGutTalk:OnButtonClick()
			end
			Ui.tbLogic.tbTimer:Register(10, nextsentense);
		end
	else
		UiManager:CloseWindow(self.UIGROUP);
	end
end

