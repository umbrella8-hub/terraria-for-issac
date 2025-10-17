local LuckyCoin = ModItem("Lucky Coin", "LUCKY_COIN")

function LuckyCoin:PostPickupInit(pickup, variant, subtype)
    for _, player in pairs(PlayerManager:GetPlayers()) do
        if player:HasCollectible(LuckyCoin.ID) then
            local rng = Isaac.GetPlayer():GetCollectibleRNG(LuckyCoin.ID)
            local luck = player.Luck
            if luck > 30 then luck = 30 end
            if variant == PickupVariant.PICKUP_COIN and rng:RandomInt(100) < 10 + luck * 3 then
                if subtype == CoinSubType.COIN_PENNY then
                    return { variant, CoinSubType.COIN_NICKEL }
                elseif subtype == CoinSubType.COIN_NICKEL then
                    return { variant, CoinSubType.COIN_DIME }
                end
            end
        end
    end
end

LuckyCoin:AddCallback(ModCallbacks.MC_POST_PICKUP_SELECTION, LuckyCoin.PostPickupInit)
return LuckyCoin
