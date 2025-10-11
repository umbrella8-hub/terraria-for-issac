local TFI = RegisterMod("Terraria for Issac", 1);
local game = Game();
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
    Descriptions = "受击后五秒内↑{{Speed}}+0.5移速"
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
-- 玩家注册函数
function TFI:PostPlayerInit(player)
    local numPlayers = game:GetNumPlayers()
    for i = 0, numPlayers do
        local player = Isaac.GetPlayer(i)
        local data = player:GetData();
        -- 恐惧项链计时器
        data.pn_timer = 0;
        -- 恐惧项链开关
        data.pn_bool = 0
        -- 恐惧项链是否已经触发
        data.pn_ed = 0
    end
end

-- 道具函数
function TFI:OnEssentialBalmAdd(player, cacheflag)
    -- 玩家拥有当前道具的数量
    local itemCount = player:GetCollectibleNum(ItemID.panicNecklace);
    -- 如果玩家持有了该道具
    --[[if player:HasCollectible(ItemID.panicNecklace) then
        -- 判断以撒中角色数值的道具堆栈标签
        if cacheflag == CacheFlag.CACHE_DAMAGE then        -- 攻击力堆栈
            player.Damage = player.Damage + 1 * itemCount;
        elseif cacheflag == CacheFlag.CACHE_SHOTSPEED then -- 弹速堆栈
            player.ShotSpeed = player.ShotSpeed - 0.2 * itemCount;
        elseif cacheflag == CacheFlag.CACHE_TEARCOLOR then -- 眼泪颜色
            player.TearColor = Color(0.2, 1.0, 0.2, 1.0);
        end
    end]]
end

-- 受击函数
function TFI:OnEntityGetDamage(player, damount, dflag, dsource, dcountdown)
    local numPlayers = game:GetNumPlayers()
    for i = 0, numPlayers do
        local player = Isaac.GetPlayer(i)
        local data = player:GetData();
        if data.pn_bool == 0 and data.pn_ed == 0 then
            player.MoveSpeed = player.MoveSpeed + 0.5
            data.pn_ed = 1
        end
        data.pn_timer = 300
    end
end

--玩家持有道具帧函数
function TFI:PostPeffectUpdate(player)
    local numPlayers = game:GetNumPlayers()
    for i = 0, numPlayers do
        local player = Isaac.GetPlayer(i)
        local data = player:GetData();
        -- 恐惧项链
        if (player:HasCollectible(ItemID.panicNecklace)) then
            -- 计时器逻辑
            if data.pn_timer > 0 then
                data.pn_timer = data.pn_timer - 1;
                if data.pn_timer > 0 then
                    data.pn_bool = 1
                else
                    data.pn_bool = 0
                end
            else
                data.pn_bool = 0
            end
            -- 效果实现
            if data.pn_bool == 0 and data.pn_ed == 1 then
                player.MoveSpeed = player.MoveSpeed - 0.5
                data.pn_ed = 0
            end
        else
            data.pn_bool = 0
            data.pn_ed = 0
        end
    end
end

TFI:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, TFI.PostPlayerInit);
TFI:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, TFI.OnEssentialBalmAdd);
TFI:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, TFI.OnEntityGetDamage);
TFI:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, TFI.PostPeffectUpdate);
