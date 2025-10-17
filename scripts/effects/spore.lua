local Spore = ModEntity("Spore", "SPORE")

function Spore:findNearestEntity(entities, position)
    local nearestEntity = nil
    local minDistance = math.huge
    for _, entity in ipairs(entities) do
        local distance = entity.Position:Distance(position)
        if distance < minDistance and entity:IsVulnerableEnemy() and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
            minDistance = distance
            nearestEntity = entity
        end
    end
    return nearestEntity
end

local function PostEffectInit(mod, effect)
    effect:GetSprite():SetFrame(math.random(0, 1))
    effect:SetColor(Color(1, 1, 1, 0), -1, 0)
    effect.Timeout = 180
end
Spore:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, PostEffectInit, Spore.Variant)

local function PostEffectUpdate(mod, effect)
    if effect.SubType == 0 then
        local pos = effect.Position
        local hasEnemy = false
        local entities = Isaac.GetRoomEntities()
        for _, ent in ipairs(entities) do
            if ent:IsVulnerableEnemy() and not ent:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
                hasEnemy = true
            end
        end
        if hasEnemy then
            local target = Spore:findNearestEntity(entities, pos)
            if target ~= nil then
                effect.Velocity = (target.Position - pos) / 20
            end
        end
    end

    -- 渐入渐出
    local alpha = 0
    if (effect.Timeout >= 0) then
        alpha = math.min(1, math.min(effect.FrameCount, effect.Timeout) / 3)
        if (effect.Timeout == 0) then
            effect:Remove()
        end
    else
        alpha = math.min(1, effect.FrameCount / 3)
    end
    effect:SetColor(Color(1, 1, 1, alpha), -1, 0)
end
Spore:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, PostEffectUpdate, Spore.Variant)

return Spore
