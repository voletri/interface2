
local self = LenNgua;

local LenNgua	= Map.LenNgua or {};
Map.LenNgua		= LenNgua;

function LenNgua:OnSwith()
	Switch([[horse]])
end

local tCmd={"Map.LenNgua:OnSwith()", "LenNgua", "", "C", "C", "LenNgua"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);