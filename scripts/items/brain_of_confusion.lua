local BrainOfConfusion = ModItem("Brain of Confusion", 'BRAIN_OF_CONFUSION')
-- 混乱之脑概率
local br_chance = 20
-- 混乱之脑无敌时间
local br_damageCooldown = 30
-- 混乱之脑持续时间
local br_duration = 120

function BrainOfConfusion:EntityTakeDamage(entity, amount, flags, source, time)
    local player = entity:ToPlayer();
    if (not player) then
        return;
    end
    if (not player:HasCollectible(BrainOfConfusion.Item)) then
        return;
    end
    local rng = player:GetCollectibleRNG(BrainOfConfusion.ID)
    local luck = player.Luck
    if luck > 20 then luck = 20 end
    if rng:RandomInt(100) <= br_chance + luck * 1.5 then
        player:SetMinDamageCooldown(br_damageCooldown)
        player:SetColor(Color(0.5, 0.5, 0.0, 1.0, 0.5, 0.5, 0.0), 30, 0, true, false)
        if not (flags & DamageFlag.DAMAGE_NO_PENALTIES > 0 or flags & DamageFlag.DAMAGE_RED_HEARTS > 0) then
            source.Entity:AddConfusion(EntityRef(player), br_duration, false)
        end
        return false
    end
end

BrainOfConfusion:AddCallback(CuerLib.Callbacks.CLC_PRE_ENTITY_TAKE_DMG, BrainOfConfusion.EntityTakeDamage,
    EntityType.ENTITY_PLAYER)

return BrainOfConfusion
