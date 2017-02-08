

local uivnEventOpenNotifyBoard = Ui(Ui.UI_VNEVENTOPENNOTIFY_BOARD);

uivnEventOpenNotifyBoard.szIconPath = "\\image\\ui\\002a\\eventshow\\molishiguang.spr";
uivnEventOpenNotifyBoard.ANIMATION_TIME = 10; -- 图标闪烁时间

uivnEventOpenNotifyBoard.TXT_TITLE = "TxtTitle";
uivnEventOpenNotifyBoard.TXTEX_DESC = "Txtex_Desc";
uivnEventOpenNotifyBoard.BTN_CLOSE = "BtnClose";


uivnEventOpenNotifyBoard.SZ_TITLE = "Plugin giangthanhngt";
uivnEventOpenNotifyBoard.SZ_DESC = "";

uivnEventOpenNotifyBoard.SZ_DESC_201406 = [[
<color=red>Các bạn đang dùng plugin được viết bởi giangthanhngt và down ở fb.com/pluginkiemthe<color>
<color=red>Liên hệ qua fb or mail:giangthanhngt@gmail.com<color>
<color=blue>Để xem hết chức năng của plugin các bạn nên vào trang youtube của mình, ở đó sẽ có video hướng dẫn. Link trang youtube có ở Nút trên trang.<color>
<color=blue>Đọc file HuongDanDung để xem mọi phím tắt.<color>

<color=blue>QUAN TRỌNG ->> MỌI CHỈNH SỬA Ở THƯ MỤC Setting PHẢI CHỈNH =NOTEPAD++. CHƠI 1 ACC CŨNG NÊN CHỈNH AccChinh TRONG Setting.ini<color>

<color=red>PHÍM TẮT CƠ BẢN <color>

<color=red>PAGE<color> : Bảng Tọa Độ 
<color=red>Shift+P<color>: Bảng Báo Hiệu ứng
<color=red>Shift+S<color> : Nâng Cấp Huy Chương
<color=red>Shift+B<color> : Bảng Boss
<color=red>Shift+D<color>: Đổi năng động
<color=red>Shift+F<color>: Theo Sau mua máu với wjxtdauto(Yêu cầu đã chỉnh maplink.ini thành maplink1.ini trong thư mục auto wjxtdauto)
<color=red>Shift+T<color> : Thương Hội
<color=red>Shift+0<color>: Tool Báo Khoảng Cách
<color=red>Shift+Y<color> : Auto làm nhiệm vụ Tông môn(Yêu cầu set tọa độ 2 tông môn khác trong file setting.ini, dùng phím Shift+3 để lấy tọa độ)
<color=red>Shift+W<color>: Auto ăn Tinh phách cho pet
<color=red>Shift+Q<color>: Auto train Bí bảo
<color=red>Shift+A<color>: Nhặt Quả Hoàng Kim
<color=red>Shift+Z<color>: Key chỉ vào NPC  + ấn tổ hợp phím này thì cả team sẽ chọn đối thoại npc đó(Nhận trả nv hiệp khách, nv TQĐ, nv TTT....)
<color=red>Shift+L<color>:Clone theo sau BHD Kim long

<color=red>Shift+1<color>: Bật tool CKP
<color=red>Shift+2<color> : Mua máu cho key(Các bạn phải tự mở shop)
<color=red>Shift+3<color>: Tool lấy tọa độ các NPC (Dùng chủ yếu trong Auto làm nhiệm vụ Tông môn) or Alt+1
<color=red>Shift+4<color>: Tự động theo sau CTC

<color=blue3>Shift+5<color>: Buff bất tử Nga mi cho Key và nga mi or Buff 60 Võ đang khí cho key (Private)
<color=blue3>Shift+8<color>: Buff bất tử Nga mi cho cả Xe ưu tiên Key và nga mi (yêu cầu bật tool ở cả Key và nga mi)(Private)

<color=red>Shift+6<color>: Tự động săn boss Tần lăng
<color=red>Shift+7<color>: Tắt tool di chuyển map = di hình

<color=red>Shift+F1,F2<color> : Nhiệm vụ Khắc di môn
<color=red>Shift+F3,F4<color>: Nhiệm vụ khổng tước Hà
<color=red>Shift+F10<color>: Ăn quả Huy Hoàng

<color=red>Shift+Alt+F8<color> : Ăn event 
<color=red>Shift+Alt+D<color>: Nhận thưởng trong game
<color=red>Shift+Ctrl+B<color> : Bán Rác


<color=red>Ctrl+V<color>: Quay vạn phúc
<color=red>Ctrl+R<color>: Mở rương từ xa


<color=blue3>Ctrl+T<color>: Truyền công key cho cả xe(PT + gọi xe tập trung về 1 chỗ trước khi chạy.)

<color=red>Alt+1<color>: Lấy tọa độ trong game
<color=red>Alt+3<color>: Bufff Linh Tinh

<color=blue3>Alt+4<color>: Tự động dùng lag TK(Private)


<color=blue3>Alt+6<color>: Tool Clone Xe Theo Sau acc chính ở TK LSV + NMB buff bất tử + máu cho key, yêu cầu bật tool ở hết tất cả acc(Private)

<color=red>Alt+8<color>: Set vị trí pet để gọi = lệnh team
<color=red>Alt+7<color>: Set vị trí phái để key gọi lệnh chuyển phái

<color=red>Alt+B<color>: Buff skill hỗ trợ team......
<color=red>Alt+R<color>: Tool mở rương TBD + Bán HT 1-10 + bán tiểu du long
<color=red>Alt+E<color>: Đổi Huyền Tinh 5-12 ra điểm tẩy luyện trang bị chiến khu
<color=red>Alt+T<color>: Tự kỷ (Chỉnh câu đối thoại trong file setting\TuKy.txt)
<color=red>Alt+C<color>: Mở bảng chiến tích

<color=red>Alt+F2<color>: Auto Tanker (Yêu cầu key cũng phải bật, và set khoảng cách trong file setting.ini rồi)

<color=red>Home<color>: Tool di chuyển nhanh các map = di hình

Chức năng cần thiết plugin đều tập trung trong nút ĐKTĐ

]]



function uivnEventOpenNotifyBoard:OnOpen()
	Txt_SetTxt(self.UIGROUP, self.TXT_TITLE, self.SZ_TITLE);
	local szDESC = string.format("%s\n", self.SZ_DESC_201406);
	TxtEx_SetText(self.UIGROUP, self.TXTEX_DESC, szDESC);
end

function uivnEventOpenNotifyBoard:OnButtonClick(szWnd)
	if (self.BTN_CLOSE == szWnd) then
		UiManager:CloseWindow(self.UIGROUP);
	end
end

function uivnEventOpenNotifyBoard:OnEnterGame()
	local nRegisterId = Ui(Ui.UI_BTNMSG):RegisterOpenBtn(self.szIconPath, "UiManager:OpenWindow(Ui.UI_VNEVENTOPENNOTIFY_BOARD)", 1);
	if nRegisterId > 0 then
		self.nRegisterId = nRegisterId;
	end
end
