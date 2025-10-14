TFI = RegisterMod("Terraria for Issac", 1)
local Mod = TFI
Mod.Fonts = include("scripts/fonts")
Mod.Version = "0.0.0"
Mod.Language = Options.Language
Mod.NameStr = "试试泰拉瑞亚！"
if Mod.Language ~= "zh" then
    Mod.Language = "en"
    Mod.NameStr = Mod.Name
end

--检查前置mod
local Check = include("scripts/helpers/check")
if not Check then
    return
end

CuerLib:InitMod(Mod, "Terraria_for_Issac")

Mod.IDTable = include("scripts/item_id_table")

local Comps = Mod.CuerLibAddon.ModComponents
function ModItem(name, dataName)
    for key, value in pairs(Mod.IDTable.ZhCollectiblesName) do
        if value == name and Isaac.GetItemIdByName(name) == -1 then
            name = key
            break
        end
    end
    return Comps.ModItem:New(name, dataName);
end

function ModTrinket(name, dataName) return Comps.ModTrinket:New(name, dataName); end

function ModPlayer(name, tainted, dataName) return Comps.ModPlayer:New(name, tainted, dataName); end

function ModCard(name, dataName)
    for key, value in pairs(Mod.IDTable.ZhCardsName) do
        if value == name and Isaac.GetCardIdByName(name) == -1 then
            name = key
            break
        end
    end
    return Comps.ModCard:New(name, dataName)
end

function ModPill(name, dataName) return Comps.ModPill:New(name, dataName); end

function ModChallenge(name, dataName) return Comps.ModChallenge:New(name, dataName); end

function ModPart(name, dataName) return Comps.ModPart:New(name, dataName); end

TFI.Game = Game()
include("scripts/contents")

if Options.Language == 'zh' then
    Mod.ZHInfo = include("translations/zh")
end

if EID then
    include("translations/main")
end
