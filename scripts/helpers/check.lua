local Mod = TFI
local hasCuerLib = not not CuerLib;
local hasREPENTOGON = not not REPENTOGON;

if not hasCuerLib then
	local Texts = {
		zh = {
			"试试泰拉瑞亚！ 需要前置Mod\"CuerLib\"来运行！",
			"请下载该前置！"
		},
		en = {
			"Terraria for Issac REQUIRES  \"CuerLib\"  TO RUN",
			"INSTALL IT!"
		}
	}

	local font = Mod.Fonts.TeammeatExtended10
	local texts = Texts[Options.Language] or Texts.en
	local color = KColor(1, 0, 0, 1);

	local function PostRender(mod)
		local posX = Isaac.GetScreenWidth() / 2;
		for i, text in ipairs(texts) do
			font:DrawStringUTF8(text, posX - 200, 0 + i * 20, color, 400, true)
		end
	end
	Mod:AddCallback(ModCallbacks.MC_POST_RENDER, PostRender);
end

if not hasREPENTOGON then
	local Texts = {
		["zh"] = {
			"试试泰拉瑞亚！ 需要前置\"REPENTOGON\"来运行！",
			"请下载该前置！"
		},
		["en"] = {
			"Reverie:Make Good Omissions REQUIRES  \"REPENTOGON\"  TO RUN",
			"INSTALL IT!"
		}
	}

	local font = Mod.Fonts.TeammeatExtended10
	local texts = Texts[Options.Language] or Texts["en"]
	local color = KColor(0, 1, 1, 1)

	Mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
		local posX = Isaac.GetScreenWidth() / 2
		local posY = Isaac.GetScreenHeight() / 2
		for i, text in ipairs(texts) do
			font:DrawStringUTF8(text, posX - 200, posY + (i - 1) * 20, color, 400, true)
		end
	end)
end

return hasCuerLib and hasREPENTOGON
