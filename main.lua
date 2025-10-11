local TFI = RegisterMod("Terraria for Issac", 1);
------------------------------------------------------------------------------------------------------------------------------------------------------
-- 从xml中获取道具数据
local ItemID = {
    panicNecklace = Isaac.GetItemIdByName("Panic Necklace"),
};
------------------------------------------------------------------------------------------------------------------------------------------------------
-- EID
local ItemEID = {};
local function EIDAddItem(id, content) -- EID添加内容
    if id then ItemEID[id] = content; end
end
--
EIDAddItem(ItemID.panicNecklace, {
    Name = "恐惧项链",
    Descriptions = "↑{{Damage}} +1攻击力" ..
        "#↓{{Shotspeed}} -0.2弹速"
});
--
if EID then -- 判断玩家是否订阅了EID
    local language = "zh_cn";
    local descriptions = EID.descriptions[language];
    for id, item in pairs(ItemEID) do
        EID:addCollectible(id, item.Descriptions, item.Name, language);
        -- 美德书适配
        if (item.BookOfVirtues and descriptions.bookOfVirtuesWisps) then
            descriptions.bookOfVirtuesWisps[id] = item.BookOfVirtues;
        end
        -- 大胃王适配
        if (item.BingeEater and descriptions.bingeEaterBuffs) then
            descriptions.bingeEaterBuffs[id] = item.BingeEater;
        end
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------
-- 道具函数
function TFI:OnEssentialBalmAdd(player, cacheflag)
    -- 玩家拥有当前道具的数量
    local itemCount = player:GetCollectibleNum(ItemID.panicNecklace);
    -- 如果玩家持有了该道具
    if player:HasCollectible(ItemID.panicNecklace) then
        -- 判断以撒中角色数值的道具堆栈标签
        if cacheflag == CacheFlag.CACHE_DAMAGE then        -- 攻击力堆栈
            player.Damage = player.Damage + 1 * itemCount;
        elseif cacheflag == CacheFlag.CACHE_SHOTSPEED then -- 弹速堆栈
            player.ShotSpeed = player.ShotSpeed - 0.2 * itemCount;
        elseif cacheflag == CacheFlag.CACHE_TEARCOLOR then -- 眼泪颜色
            player.TearColor = Color(0.2, 1.0, 0.2, 1.0);
        end
    end
end

-- 将函数注册到道具堆栈事件上
TFI:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, TFI.OnEssentialBalmAdd);
