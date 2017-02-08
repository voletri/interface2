Ui.UI_TOOLS		= "UI_TOOLS";
local uiTools			= Ui.tbWnd[Ui.UI_TOOLS] or {};	
uiTools.UIGROUP		= Ui.UI_TOOLS;
Ui.tbWnd[Ui.UI_TOOLS] = uiTools
-------------
uiTools.BTN_Map11x			="BtnMap11x"
uiTools.BTN_Map10x			="BtnMap10x" 
uiTools.BTN_Map9x			="BtnMap9x"
uiTools.BTN_Map8x			="BtnMap8x"
uiTools.BTN_Map7x			="BtnMap7x"
uiTools.BTN_Map6x			="BtnMap6x"
uiTools.BTN_Map5x			="BtnMap5x"
uiTools.BTN_Map4x			="BtnMap4x" 
uiTools.BTN_Map3x			="BtnMap3x"
uiTools.BTN_Map2x			="BtnMap2x"
uiTools.BTN_Map1x			="BtnMap1x"

local tbTimer 				= Ui.tbLogic.tbTimer;
local self					= uiTools;


Ui:RegisterNewUiWindow("UI_TOOLS", "tools", {"a", 0, 0}, {"b", 50, 0}, {"c", 0, 0}, {"d", 0, 0});


uiTools.Map11x =
{ 
	{" Mông Cổ Vương Đình "},
	{" Nguyệt Nha Tuyền "},
	{" Tàn Tích Cung A Phòng "},
	{" Lương Sơn Bạc "},
	{" Thần Nữ Phong "},
	{" Tàn Tích Dạ Lang "},
	{" Cổ Lãng Dữ "},
	{" Đào Hoa Nguyên "},
};
uiTools.Map10x =
{ 
	{" Mạc Bắc Thảo Nguyên "},
	{" Đôn Hoàng Cổ Thành "},
	{" Hoạt Tử Nhân Mộ "},
	{" Đại Vũ Đài "},
	{" Tam Hiệp Sạn Đạo "},
	{" Xi Vưu Động "},
	{" Tỏa Vân Uyên "},
	{" Phục Lưu Động "},
};
uiTools.Map9x =
{ 
	{" Sắc Lặc Xuyên "},
	{" Gia Du Quan "},
	{" Hoa Sơn "},
	{" Thục Cương Sơn "},
	{" Phong Đô Quỷ Thành "},
	{" Miêu Lĩnh "},
	{" Vũ Di Sơn "},
	{" Vũ Lăng Sơn "},
};
uiTools.Map8x =
{ 
	{" Long Môn Thạch Quật "},
	{" Hoàng Lăng Tây Hạ "},
	{" Hoàng Hạc Lâu "},
	{" Tiến Cúc Động "},
	{" Kiếm Môn Quan "},
	{" Thiên Long Tự "},
	{" Bang Nguyên Bí Động "},
};
uiTools.Map7x =
{ 
	{" Phong Lăng Độ "},
	{" Mê Cung Sa Mạc "},
	{" Kê Quán Động "},
	{" Thục Cương Sơn "},
	{" Kiếm Các Thục Đạo "},
	{" Hoàng Lăng Đoàn Thị "},
	{" Cửu Nghi Khê "},
};
uiTools.Map6x =
{ 
	{" Cư Diên Trạch "},
	{" Phục Ngưu Sơn "},
	{" Hổ Khâu Kiếm Tri "},
	{" Hưởng Thủy Động "},
	{" Điểm Thương Sơn "},
	{" Bành Lãi Cổ Trạch "},
};
uiTools.Map5x =
{ 
	{" Thái Hành Cổ Kính "},
	{" Đại Tán Quan "},
	{" Hán Thủy Cổ Độ "},
	{" Hàn Sơn Cổ Sát "},
	{" Cán Hoa Khê "},
	{" Nhĩ Hải Ma Nham "},
	{" Thái Thạch Cơ "},
};
uiTools.Map4x =
{ 
	{" Tây Tháp Lâm "},
	{" Hoàng Lăng Kim Quốc 2 "},
	{" Mê Cung Băng Huyệt 2 "},
	{" Tây Long Hổ Huyễn Cảnh "},
	{" Giữa Yến Tử Ổ "},
	{" Cửu Lão Động 2 "},
	{" Trong Bách Hoa Trận "},
	{" Tây Bờ Hồ Trúc Lâm "},
	{" Tây Rừng Nguyên Sinh "},
	{" Tây Bắc Lư Vĩ Đãng "},
};
uiTools.Map3x =
{ 
	{" Đông Tháp Lâm "},
	{" Hoàng Lăng Kim Quốc 1 "},
	{" Mê Cung Băng Huyệt 1 "},
	{" Đông Long Hổ Huyễn Cảnh "},
	{" Ngoài Yến Tử Ổ "},
	{" Cửu Lão Động 1 "},
	{" Ngoài Bách Hoa Trận "},
	{" Đông Bờ Hồ Trúc Lâm "},
	{" Đông Rừng Nguyên Sinh "},
	{" Đông Nam Lư Vĩ Đãng "},
};
uiTools.Map2x =
{ 
	{" Cấm Địa Hậu Sơn "},
	{" Cấm Địa Thiên Nhẫn "},
	{" Kiến Tính Phong "},
	{" Thiên Trụ Phong "},
	{" Cô Tô Thủy Tạ "},
	{" Cừu Lão Phong "},
	{" Bách Hoa Cốc "},
	{" Hồ Phỉ Thúy "},
	{" Bộ Lạc Nam Di "},
	{" Thanh Loa Đảo "},
};
uiTools.Map1x =
{ 
	{" Trấn Đông Mộ Viên "},
	{" Trà Mã Cổ Đạo "},
	{" Kỳ Liên Sơn "},
	{" Đồng Quan "},
	{" Hoài Thủy Sa Châu "},
	{" Thục Nam Trúc Hải "},
	{" Nhạc Dương Lâu "},
};




uiTools.OnButtonClick_Bak = uiTools.OnButtonClick;

uiTools.OnButtonClick=function(self,szWnd, nParam)
	if (szWnd == self.BTN_Map11x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		8,
		0,
		self.Map11x[1][1],
		1,
		self.Map11x[2][1],
		2,
		self.Map11x[3][1],
		3,
		self.Map11x[4][1],
		4,
		self.Map11x[5][1],
		5,
		self.Map11x[6][1],
		6,
		self.Map11x[7][1],
		7,
		self.Map11x[8][1],
		8
		);		
	elseif (szWnd == self.BTN_Map10x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		8,
		0,
		self.Map10x[1][1],
		1,
		self.Map10x[2][1],
		2,
		self.Map10x[3][1],
		3,
		self.Map10x[4][1],
		4,
		self.Map10x[5][1],
		5,
		self.Map10x[6][1],
		6,
		self.Map10x[7][1],
		7,
		self.Map10x[8][1],
		8
		);	
    elseif (szWnd == self.BTN_Map9x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		8,
		0,
		self.Map9x[1][1],
		1,
		self.Map9x[2][1],
		2,
		self.Map9x[3][1],
		3,
		self.Map9x[4][1],
		4,
		self.Map9x[5][1],
		5,
		self.Map9x[6][1],
		6,
		self.Map9x[7][1],
		7,
		self.Map9x[8][1],
		8
		);
    elseif (szWnd == self.BTN_Map8x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map8x[1][1],
		1,
		self.Map8x[2][1],
		2,
		self.Map8x[3][1],
		3,
		self.Map8x[4][1],
		4,
		self.Map8x[5][1],
		5,
		self.Map8x[6][1],
		6,
		self.Map8x[7][1],
		7
		);
     elseif (szWnd == self.BTN_Map7x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map7x[1][1],
		1,
		self.Map7x[2][1],
		2,
		self.Map7x[3][1],
		3,
		self.Map7x[4][1],
		4,
		self.Map7x[5][1],
		5,
		self.Map7x[6][1],
		6,
		self.Map7x[7][1],
		7
		);
        elseif (szWnd == self.BTN_Map6x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		6,
		0,
		self.Map6x[1][1],
		1,
		self.Map6x[2][1],
		2,
		self.Map6x[3][1],
		3,
		self.Map6x[4][1],
		4,
		self.Map6x[5][1],
		5,
		self.Map6x[6][1],
		6
		);	
	elseif (szWnd == self.BTN_Map5x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map5x[1][1],
		1,
		self.Map5x[2][1],
		2,
		self.Map5x[3][1],
		3,
		self.Map5x[4][1],
		4,
		self.Map5x[5][1],
		5,
		self.Map5x[6][1],
		6,
		self.Map5x[7][1],
		7
		);
	elseif (szWnd == self.BTN_Map4x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		10,
		0,
		self.Map4x[1][1],
		1,
		self.Map4x[2][1],
		2,
		self.Map4x[3][1],
		3,
		self.Map4x[4][1],
		4,
		self.Map4x[5][1],
		5,
		self.Map4x[6][1],
		6,
		self.Map4x[7][1],
		7,
		self.Map4x[8][1],
		8,
		self.Map4x[9][1],
		9,
		self.Map4x[10][1],
		10
		);
	elseif (szWnd == self.BTN_Map3x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		10,
		0,
		self.Map3x[1][1],
		1,
		self.Map3x[2][1],
		2,
		self.Map3x[3][1],
		3,
		self.Map3x[4][1],
		4,
		self.Map3x[5][1],
		5,
		self.Map3x[6][1],
		6,
		self.Map3x[7][1],
		7,
		self.Map3x[8][1],
		8,
		self.Map3x[9][1],
		9,
		self.Map3x[10][1],
		10
		);
	elseif (szWnd == self.BTN_Map2x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		10,
		0,
		self.Map2x[1][1],
		1,
		self.Map2x[2][1],
		2,
		self.Map2x[3][1],
		3,
		self.Map2x[4][1],
		4,
		self.Map2x[5][1],
		5,
		self.Map2x[6][1],
		6,
		self.Map2x[7][1],
		7,
		self.Map2x[8][1],
		8,
		self.Map2x[9][1],
		9,
		self.Map2x[10][1],
		10
		);
	elseif (szWnd == self.BTN_Map1x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map1x[1][1],
		1,
		self.Map1x[2][1],
		2,
		self.Map1x[3][1],
		3,
		self.Map1x[4][1],
		4,
		self.Map1x[5][1],
		5,
		self.Map1x[6][1],
		6,
		self.Map1x[7][1],
		7
		);
	end
end

uiTools.OnMenuItemSelected=function(self,szWnd, nItemId, nParam)
	if szWnd == self.BTN_Map11x then
			if nItemId==1 then
		Map.GtMapLink:Switch(130)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(131)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(132)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(133)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(134)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(135)	
			elseif nItemId==7 then
        Map.GtMapLink:Switch(136)	              
			elseif nItemId==8 then
        Map.GtMapLink:Switch(137)	         
		   	end
	 end  
	if szWnd == self.BTN_Map10x then
			if nItemId==1 then
		Map.GtMapLink:Switch(122)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(123)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(124)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(125)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(126)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(127)	
			elseif nItemId==7 then
        Map.GtMapLink:Switch(128)	              
			elseif nItemId==8 then
        Map.GtMapLink:Switch(129)	         
		   	end
	 end 
    if szWnd == self.BTN_Map9x then
			if nItemId==1 then
		Map.GtMapLink:Switch(114)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(115)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(116)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(117)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(118)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(119)	
			elseif nItemId==7 then
        Map.GtMapLink:Switch(120)	              
			elseif nItemId==8 then
        Map.GtMapLink:Switch(121)	         
		   	end
	 end
	if szWnd == self.BTN_Map8x then
			if nItemId==1 then
		Map.GtMapLink:Switch(107)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(108)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(109)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(110)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(111)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(112)	
			elseif nItemId==7 then
        Map.GtMapLink:Switch(113)	              
			end
	 end 
	 if szWnd == self.BTN_Map7x then
			if nItemId==1 then
		Map.GtMapLink:Switch(100)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(101)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(102)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(103)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(104)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(105)	
			elseif nItemId==7 then
        Map.GtMapLink:Switch(106)	              
			end
	 end 
	 if szWnd == self.BTN_Map6x then
			if nItemId==1 then
		Map.GtMapLink:Switch(94)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(95)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(96)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(97)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(98)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(99)	
		    end
	 end 
	 if szWnd == self.BTN_Map5x then
			if nItemId==1 then
		Map.GtMapLink:Switch(86)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(87)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(88)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(89)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(90)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(91)	
			elseif nItemId==7 then
        Map.GtMapLink:Switch(92)	              
			end
	 end 
	 if szWnd == self.BTN_Map4x then
			if nItemId==1 then
		Map.GtMapLink:Switch(66)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(67)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(68)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(69)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(70)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(71)	
			elseif nItemId==7 then
        Map.GtMapLink:Switch(72)
			elseif nItemId==8 then
        Map.GtMapLink:Switch(73)	
			elseif nItemId==9 then
        Map.GtMapLink:Switch(74)	
			elseif nItemId==10 then
        Map.GtMapLink:Switch(75)	
			end
	 end
	 if szWnd == self.BTN_Map3x then
			if nItemId==1 then
		Map.GtMapLink:Switch(56)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(57)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(58)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(59)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(60)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(61)	
			elseif nItemId==7 then
        Map.GtMapLink:Switch(62)
			elseif nItemId==8 then
        Map.GtMapLink:Switch(63)	
			elseif nItemId==9 then
        Map.GtMapLink:Switch(64)	
			elseif nItemId==10 then
        Map.GtMapLink:Switch(65)	
			end
	 end
	 if szWnd == self.BTN_Map2x then
			if nItemId==1 then
		Map.GtMapLink:Switch(46)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(47)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(48)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(49)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(50)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(51)	
			elseif nItemId==7 then
        Map.GtMapLink:Switch(52)
			elseif nItemId==8 then
        Map.GtMapLink:Switch(53)	
			elseif nItemId==9 then
        Map.GtMapLink:Switch(54)	
			elseif nItemId==10 then
        Map.GtMapLink:Switch(55)	
			end
	 end
	 if szWnd == self.BTN_Map1x then
			if nItemId==1 then
		Map.GtMapLink:Switch(38)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(43)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(39)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(40)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(41)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(42)	
			elseif nItemId==7 then
        Map.GtMapLink:Switch(45)
		end
	 end
	 if szWnd == self.BTN_Map5 then
			if nItemId==1 then
		Map.GtMapLink:Switch(30)
			elseif nItemId==2 then
        Map.GtMapLink:Switch(31)	
			elseif nItemId==3 then
       	Map.GtMapLink:Switch(32)		
			elseif nItemId==4 then
        Map.GtMapLink:Switch(33)	  
			elseif nItemId==5 then
        Map.GtMapLink:Switch(34)	
			elseif nItemId==6 then
        Map.GtMapLink:Switch(35)	
			elseif nItemId==7 then
        Map.GtMapLink:Switch(36)
			elseif nItemId==8 then
        Map.GtMapLink:Switch(37)	
			end
	 end
end

local tCmd={"UiManager:SwitchWindow(Ui.UI_TOOLS)", "UI_TOOLS", "", "Home", "Home", "UI_TOOLS"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
