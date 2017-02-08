local SysMsg_Bak = SysMsg;
function SysMsg(szMsg)
	if (
			string.find(szMsg,"kinh nghiệm") 
		or	string.find(szMsg,"Trạng thái chiến đấu không chính xác!")
		or	string.find(szMsg,"Kỹ năng này chỉ dùng khi di chuyển!")
		or	string.find(szMsg,"Không phải thông báo trang chủ, xin chú ý bảo vệ tài sản.")
		or	string.find(szMsg,"Trị PK quá cao")
		or	string.find(szMsg,"Trần Niên Mỹ Tửu")
		) 
	then
		return;
	else
		SysMsg_Bak(szMsg);
	end
end
