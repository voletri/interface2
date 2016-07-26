
--local uiPartner = Ui:GetClass("partner");
local uiPartner = Ui(Ui.UI_PARTNER)

uiPartner.BTN_MONITOR = "BtnMonitor"



uiPartner.OnButtonClick_Bak = uiPartner.OnButtonClick;


function uiPartner:OnButtonClick(szWnd, nParam)
	if (szWnd == self.BTN_MONITOR) then
		UiManager:SwitchWindow(Ui.UI_PARTNER)
		UiManager:SwitchWindow(Ui.UI_PARTNER_SETTING)
	end
	self:OnButtonClick_Bak(szWnd, nParam);
end

--LoadUiGroup(Ui.UI_PARTNER,"partner.ini");