--cyberdemon--
local tbObject	= Ui.tbLogic.tbObject
local tbBase	= tbObject.tbContClass.base

tbBase.FormatItem = function(self,tbItem)
	local tbObj = {}
	local pItem = tbItem.pItem
	if not pItem then
		return
	end
	tbObj.szBgImage = pItem.szIconImage
	tbObj.szCdSpin  = self.CDSPIN_MEDIUM
	tbObj.szCdFlash = self.CDFLASH_MEDIUM
	tbObj.bShowSubScript = 1
	return tbObj
end

tbBase.ReputeType = function(self, pItem)
	local ns = ""
	if pItem.nLevel == 1 then
		ns = "phù"
	elseif pItem.nLevel == 2 then
		ns = "nón"
	elseif pItem.nLevel == 3 then
		ns = " áo"
	elseif pItem.nLevel == 4 then
		ns = "đai"
	elseif pItem.nLevel == 5 then
		ns = "giày"
	elseif pItem.nLevel == 6 then
		ns = "liên"
	elseif pItem.nLevel == 7 then
		ns = "nhẫn"
	elseif pItem.nLevel == 8 then
		ns = "tay"
	elseif pItem.nLevel == 9 then
		ns = "bội"
	end
	return ns
end

tbBase.BookType = function(self, pItem)
	local ns = ""
	if pItem.nParticular == 1 then
		ns = "đTL"
	elseif pItem.nParticular == 2 then
		ns = "cTL"
	elseif pItem.nParticular == 3 then
		ns = "tTV"
	elseif pItem.nParticular == 4 then
		ns = "cTV"
	elseif pItem.nParticular == 5 then
		ns = "bĐM"
	elseif pItem.nParticular == 6 then
		ns = "tĐM"
	elseif pItem.nParticular == 7 then
		ns = "đNĐ"
	elseif pItem.nParticular == 8 then
		ns = "cNĐ"
	elseif pItem.nParticular == 9 then
		ns = "cNM"
	elseif pItem.nParticular == 10 then
		ns = "bNM"
	elseif pItem.nParticular == 11 then
		ns = "kTY"
	elseif pItem.nParticular == 12 then
		ns = "đTY"
	elseif pItem.nParticular == 13 then
		ns = "cCB"
	elseif pItem.nParticular == 14 then
		ns = "bCB"
	elseif pItem.nParticular == 15 then
		ns = "cTN"
	elseif pItem.nParticular == 16 then
		ns = "mTN"
	elseif pItem.nParticular == 17 then
		ns = "cVĐ"
	elseif pItem.nParticular == 18 then
		ns = "kVĐ"
	elseif pItem.nParticular == 19 then
		ns = "đCL"
	elseif pItem.nParticular == 20 then
		ns = "kCL"
	elseif pItem.nParticular == 21 then
		ns = "cMG"
	elseif pItem.nParticular == 22 then
		ns = "kMG"
	elseif pItem.nParticular == 23 then
		ns = "cĐT"
	elseif pItem.nParticular == 24 then
		ns = "kĐT"
	elseif pItem.nParticular == 25 then
		ns = "kCM"
	elseif pItem.nParticular == 26 then
		ns = "cCM"
	elseif pItem.nParticular == 27 then
		ns = "cTD"
	elseif pItem.nParticular == 28 then
		ns = "kTD"
	end
	return ns
end

tbBase.GemType = function(self, pItem)
	local ns = ""
	if pItem.nParticular == 1 then
		ns = "SLđ"
	elseif pItem.nParticular == 2 then
		ns = "SL%"
	elseif pItem.nParticular == 3 then
		ns = "k木"
	elseif pItem.nParticular == 4 then
		ns = "k金"
	elseif pItem.nParticular == 5 then
		ns = "k水"
	elseif pItem.nParticular == 6 then
		ns = "k土"
	elseif pItem.nParticular == 7 then
		ns = "k火"
	elseif pItem.nParticular == 8 then
		ns = "ktg木"
	elseif pItem.nParticular == 9 then
		ns = "ktg金"
	elseif pItem.nParticular == 10 then
		ns = "ktg水"
	elseif pItem.nParticular == 11 then
		ns = "ktg土"
	elseif pItem.nParticular == 12 then
		ns = "ktg火"
	elseif pItem.nParticular == 13 then
		ns = "ktl木"
	elseif pItem.nParticular == 14 then
		ns = "ktl金"
	elseif pItem.nParticular == 15 then
		ns = "ktl水"
	elseif pItem.nParticular == 16 then
		ns = "ktl土"
	elseif pItem.nParticular == 17 then
		ns = "ktl火"
	elseif pItem.nParticular == 18 then
		ns = "ktgbl"
	elseif pItem.nParticular == 19 then
		ns = "ktlbl"
	elseif pItem.nParticular == 20 then
		ns = "tgbl"
	elseif pItem.nParticular == 21 then
		ns = "tlbl"
	elseif pItem.nParticular == 22 then
		ns = "kTC"
	elseif pItem.nParticular == 23 then
		ns = "木n"
	elseif pItem.nParticular == 24 then
		ns = "金n"
	elseif pItem.nParticular == 25 then
		ns = "水n"
	elseif pItem.nParticular == 26 then
		ns = "土n"
	elseif pItem.nParticular == 27 then
		ns = "火n"
	elseif pItem.nParticular == 28 then
		ns = "木N"
	elseif pItem.nParticular == 29 then
		ns = "金N"
	elseif pItem.nParticular == 30 then
		ns = "水N"
	elseif pItem.nParticular == 31 then
		ns = "土N"
	elseif pItem.nParticular == 32 then
		ns = "火N"
	elseif pItem.nParticular == 33 then
		ns = "tgnh"
	elseif pItem.nParticular == 34 then
		ns = "tlnh"
	elseif pItem.nParticular == 35 then
		ns = "CM"
	elseif pItem.nParticular == 36 then
		ns = "kCM"
	elseif pItem.nParticular == 39 then
		ns = "30"
	elseif pItem.nParticular == 43 then
		ns = "70"
	elseif pItem.nParticular == 44 then
		ns = "90"
	elseif pItem.nParticular == 45 then
		ns = "100"
	elseif pItem.nParticular == 46 then
		ns = "110"
	elseif pItem.nParticular == 47 then
		ns = "120"
	elseif pItem.nParticular == 49 then
		ns = "trung"
	elseif pItem.nParticular == 50 then
		ns = "cao"
	elseif pItem.nParticular == 52 then
		ns = "nhỏ"
	elseif pItem.nParticular == 56 then
		ns = "木n+"
	elseif pItem.nParticular == 57 then
		ns = "金n+"
	elseif pItem.nParticular == 58 then
		ns = "水n+"
	elseif pItem.nParticular == 59 then
		ns = "土n+"
	elseif pItem.nParticular == 60 then
		ns = "火n+"
	elseif pItem.nParticular == 61 then
		ns = "木N+"
	elseif pItem.nParticular == 62 then
		ns = "金N+"
	elseif pItem.nParticular == 63 then
		ns = "水N+"
	elseif pItem.nParticular == 64 then
		ns = "土N+"
	elseif pItem.nParticular == 65 then
		ns = "火N+"
	end
	return ns
end

tbBase.ItemTimeRemain = function(self, pItem)
	local szItTimeRem = ""
	local tbAbsTime = me.GetItemAbsTimeout(pItem)
	if tbAbsTime then
		local itTime = string.format("%04d%02d%02d%02d%02d%s",tbAbsTime[1],tbAbsTime[2],tbAbsTime[3],tbAbsTime[4],tbAbsTime[5],"00")
		local nSec2 = Lib:GetDate2Time(itTime);
		local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"))
		local nSec1 = Lib:GetDate2Time(nDate)
		nSec1 = nSec2 - nSec1
		if nSec1 > 0 then
			if nSec1 > 86400 then
				nSec2 = math.floor(nSec1 / 86400)
				szItTimeRem = nSec2.."d"
				if nSec2 < 2 then
					nSec1 = nSec1 % 86400
					nSec1 = math.floor(nSec1 / 3600)+nSec2*24
					szItTimeRem = nSec1.."h"
				end
			elseif nSec1 > 3600 then
				nSec2 = math.floor(nSec1 / 3600)
				szItTimeRem = nSec2.."h"
				if nSec2 < 2 then
					nSec1 = nSec1 % 3600
					nSec1 = math.floor(nSec1 / 60)+nSec2*60
					szItTimeRem = nSec1.."'"
				end
			elseif nSec1 > 60 then
				nSec1 = math.floor(nSec1 / 60)
				szItTimeRem = nSec1.."'"
			else
				szItTimeRem = nSec1.."s"
			end
		end
	end
	return szItTimeRem
end

function tbBase:CalculateDay(nLastTime, nNowTime)
	local nLastDay 	= Lib:GetLocalDay(nLastTime)
	local nNowDay	= Lib:GetLocalDay(nNowTime)
	local nDays		= nNowDay - nLastDay
	if (nDays < 0) then
		nDays = 0
	end
	return nDays
end

tbBase.UpdateItem = function(self,tbItem, nX, nY)
	local pItem = tbItem.pItem
	local ns = ""
	local szCount = tostring(pItem.nCount)
	local szLvl = tostring(pItem.nLevel)
	local szTR = tbBase:ItemTimeRemain(pItem)
	local nGGI1 = pItem.GetGenInfo(1)
	local nGGI2 = pItem.GetGenInfo(2)
	local nGGI3 = pItem.GetGenInfo(3)

	if pItem.nParticular == 20609 then -- huy chương vinh dự
		ns = "TK"
	elseif pItem.nParticular == 20625 then -- huy chương vinh dự
		ns = "BH"
	elseif pItem.nParticular == 20382 then	-- đá exp
		ns = ""..szLvl
	elseif pItem.nParticular == 20937 then
		ns = "tín"
	elseif pItem.szClass == "modaoshi" or pItem.szClass == "hujiapian" or pItem.szClass == "wuxingshi" then
		ns = ""..szLvl
	elseif pItem.szClass == "dianjingshi" then
		if pItem.nLevel == 1 then
			ns = "vh"
		elseif pItem.nLevel == 2 then
			ns = "?"
		elseif pItem.nLevel == 3 then
			ns = "pv"
		elseif pItem.nLevel == 4 then
			ns = "kt"
		elseif pItem.nLevel == 5 then
			ns = "tđ"
		else
			ns = "?"
		end
	elseif pItem.szClass =="xiang" then
		if pItem.nParticular == 72 then
			ns = "MĐT"
		elseif pItem.nParticular == 73 then
			ns = "HGP"
		elseif pItem.nParticular == 74 then
			ns = "NHT"
		elseif pItem.nParticular == 241 then -- rương linh chi
			ns = "["..nGGI1.."]"
		elseif pItem.nParticular == 716 then -- rương máu?
			ns = "["..nGGI1.."]"
		elseif pItem.nParticular == 1783 then -- rương máu PL
			ns = "["..nGGI1.."]"
		end
	elseif pItem.szClass =="horsexiang_vn" then
		if pItem.nParticular == 20233 then
			ns = "PV"
		end
	elseif pItem.szClass == "vnqkhxpacket" then -- đại lễ bao
		ns = ""..szLvl
	elseif pItem.szClass == "gamefriend" then -- thẻ pet
		if pItem.nParticular == 729 then
			ns = "4"
		elseif pItem.nParticular == 777 then
			ns = "7"
		end
	elseif pItem.szClass == "childpartner" then -- pet
		ns = ""..szLvl+1
	elseif pItem.szClass == "miji_tb" then -- mt pet
		ns = "pet"
	elseif pItem.szClass == "miji_tbEx" then -- mt pet
		ns = "petđb"
	elseif pItem.szClass == "vn_badge_point_scroll" then -- trục cuốn công trạng
		ns = "CT"
	elseif pItem.szClass == "horse_skill_book" then -- sách ngựa
		if pItem.nParticular >= 1 and pItem.nParticular <= 4 then
			ns = "ô1"
		elseif pItem.nParticular >= 7 and pItem.nParticular <= 9 then
			ns = "ô3"
		elseif pItem.nParticular == 10 then
			ns = "ô4"
		elseif pItem.nParticular >= 11 and pItem.nParticular <= 14 then
			ns = "ô5"
		elseif pItem.nParticular >= 15 and pItem.nParticular <= 18 then
			ns = "ô6"
		elseif pItem.nParticular >= 24 and pItem.nParticular <= 28 then
			ns = "ô2"
		elseif pItem.nParticular >= 32 and pItem.nParticular <= 33 then
			ns = "ô7"
		elseif pItem.nParticular >= 34 and pItem.nParticular <= 37 then
			ns = "ô4"
		end
		ns = ns .. "-q" .. szLvl
	elseif pItem.szClass == "chongzhizhenyuan" then -- rương cn
		ns = "CN"
	elseif pItem.szClass == "coin_arm_item" then
		ns = "CN"
	elseif pItem.szClass == "randomitem" then -- rương
		if pItem.nParticular == 252 then
			ns = "TĐLT"
		elseif pItem.nParticular == 20614 then
			ns = "TBL"
		end
	elseif pItem.szClass == "vnlongwenyinbijinnang" then -- rương thiên xu
		ns = "văn"
	elseif pItem.szClass == "vn_tianshubox" then -- rương thiên xu
		ns = "TX"
	elseif pItem.szClass == "vnmibao_canjuanbox" then -- rương bí bảo
		ns = "BB"
	elseif pItem.szClass == "vnawardbox" then
		if pItem.nLevel == 1 then
			ns = "HLVM"
		elseif pItem.nLevel == 2 then
			ns = "BMS"
		elseif pItem.nLevel == 3 then
			ns = "NLHN"
		elseif pItem.nLevel == 4 then
			ns = "?"
		elseif pItem.nLevel == 5 then
			ns = "QD"
		elseif pItem.nLevel == 6 then
			ns = "HK"
		end
	elseif pItem.szClass == "vn_heartmagic_usebind_box_box" then
		ns = "th"
	elseif pItem.szClass == "vn_nsjingbingling" then -- tbl
		if pItem.nLevel == 1 then
			ns = "BH"
		elseif pItem.nLevel == 2 then
			ns = "TK"
		elseif pItem.nLevel == 3 then
			ns = "TD"
		elseif pItem.nLevel == 4 then
			ns = "BĐ"
		elseif pItem.nLevel == 5 then
			ns = "QD"
		end
	elseif pItem.szClass == "panshifu" then -- bàn thạch phủ
		ns = "def"
	elseif pItem.szClass == "voucher" then -- phiếu giảm giá
		if pItem.nLevel == 1 then
			ns = "50%"
		elseif pItem.nLevel == 3 then
			ns = "30%"
		end
	elseif pItem.szClass == "book" then -- mật tịch
		ns = tbBase:BookType(pItem)
	elseif pItem.szClass == "gem" then -- bảo thạch
		ns = tbBase:GemType(pItem)
	elseif pItem.szClass == "addrepute_base" then -- du long lệnh
		ns = tbBase:ReputeType(pItem)
	elseif pItem.szClass == "refineitem" then -- luyện hóa
		if pItem.nParticular == 1 then
			ns = "VU"
		elseif pItem.nParticular == 2 then
			ns = "LĐ"
		elseif pItem.nParticular == 3 then
			ns = "TL"
		elseif pItem.nParticular == 4 then
			ns = "TH"
		end
	elseif pItem.szClass =="jinxi" then -- kim tê
		ns = ""..nGGI1
	elseif pItem.szClass =="jiaxuzhaohuanlingpai" then -- triệu hoán gt
		ns = "["..nGGI1.."]"
	elseif pItem.szClass =="wulingaoshouling" then -- lb cao thủ
		if pItem.nParticular >=219 and pItem.nParticular<=221 then
			ns = "金"
		elseif pItem.nParticular >=222 and pItem.nParticular<=224 then
			ns = "木"
		elseif pItem.nParticular >=225 and pItem.nParticular<=227 then
			ns = "水"
		elseif pItem.nParticular >=228 and pItem.nParticular<=230 then
			ns = "火"
		elseif pItem.nParticular >=231 and pItem.nParticular<=233 then
			ns = "土"
		end
	elseif pItem.szClass == "shengwanglingpai_kin" then
		ns = "GT"
	elseif pItem.szClass == "shengwanglingpai_baihutang" then
		ns = "BH"
	elseif pItem.szClass == "mengpaijingjilingpai" then
		ns = "MP"
	elseif pItem.szClass == "zhanchanglingpai" then
		ns = "TK"
	elseif pItem.szClass == "army_book130" or pItem.szClass == "army_hisbook130" or pItem.szClass == "army_book110" or pItem.szClass == "army_hisbook110" then -- sách qd
		ns = "["..nGGI1.."]"
	elseif pItem.szClass == "army_bag" then
		ns = ""
	elseif pItem.szClass == "army_food" then -- exp qd
		if pItem.nLevel == 1 then
			ns = math.floor((300000 - nGGI1)/1000)
		elseif pItem.nLevel == 2 then
			ns = math.floor((600000 - nGGI1)/1000)
		end
		ns = ns.."K"
	elseif pItem.szClass == "kingame_qianxiang" then -- túi gia tộc
		ns = tostring(me.GetTask(KinGame2.TASK_GROUP_ID, KinGame2.TASK_GOLD_COIN))
	elseif pItem.szClass == "kingame_qiandai" then -- túi gia tộc
		ns = tostring(me.GetTask(KinGame.TASK_GROUP_ID, KinGame.TASK_BAG_ID))
	elseif pItem.szClass == "xoyolu" then -- tiêu dao lục
		ns = XoyoGame.XoyoChallenge:GetGatheredCardNum(me).."c"
	elseif pItem.szClass == "qiankunfu" then -- càn khôn phù
		ns = "["..nGGI1.."]"
	elseif pItem.szClass == "chuansongfu" then -- truyền tống phù
		if nGGI2 > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nGGI2* 1000000 + nGGI3)
			local nSec1 = Lib:GetDate2Time(nDate);
			local nSec2 = Lib:GetDate2Time(nCanDate) + nRelayTime;
			if nSec1 < nSec2 then
				ns = (nSec2 - nSec1).."s"
			end
		end
	elseif pItem.szClass == "travelmedicine" then -- thuốc sv
		ns = tostring(me.GetTask(pItem.GetExtParam(1), pItem.GetExtParam(2)))
	elseif pItem.szClass == "xiulianzhu" then -- tu luyện châu
		local nLastTime = me.GetTask(1023, 1);
		local nNowTime = GetTime();
		local nDays = tbBase:CalculateDay(nLastTime, nNowTime);
		local nRemainTime = nDays * 1.5 + me.GetTask(1023, 2) / 10;
		if (nRemainTime < 0.1) then
			nRemainTime = 0;
		end
		if (nRemainTime > 14) then
			nRemainTime = 14;
		end
		ns = nRemainTime.."h"
	end

	if szTR ~= "" then
		ns = ns.."("..szTR..")"
	end

	if szCount ~= "1" then
		ns = ns.."x"..szCount
	end

	if ns ~= "" then
		ObjGrid_ChangeSubScript(self.szUiGroup, self.szObjGrid, ns, nX, nY);
	end

	local nColor = (me.CanUseItem(pItem) ~= 1) and 0x60ff0000 or 0
	if pItem.IsBind() == 0 then
		nColor = "Hide"
	end
	ObjGrid_ChangeBgColor(self.szUiGroup, self.szObjGrid, nColor, nX, nY);
	ObjGrid_SetTransparency(self.szUiGroup, self.szObjGrid, pItem.szTransparencyIcon, nX, nY);
	local nCdTime = Lib:FrameNum2Ms(GetCdTime(pItem.nCdType));
	if nCdTime > 0 then
		local nCdPass = Lib:FrameNum2Ms(me.GetCdTimePass(pItem.nCdType));
		ObjGrid_PlayCd(self.szUiGroup, self.szObjGrid, nCdTime, nCdPass, nX, nY);
	end
end