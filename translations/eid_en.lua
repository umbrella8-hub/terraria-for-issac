local Mod = TFI
local Collectibles = Mod.Collectibles
--local Cards = Mod.Cards
--local Players = Mod.Players
--local Slots = Mod.Slots
--local Pickups = Mod.Pickups

local EIDInfo = {};
EIDInfo.Collectibles = {
    [Collectibles.PanicNecklace.ID] = {
        name = "Mangled Teddy Bear",
        info = "{{BrokenHeart}} +4 Broken Hearts" ..
            "#{{Damage}} Chance to remove a Broken Heart after killing an enemy" ..
            "#{{AngelChance}} Whenever a Broken Hearts is removed, spawns a random Angel Room item" ..
            "#After removing all the Broken Hearts: {{HealingRed}} Full health, {{SoulHeart}} +3 Soul Hearts" ..
            "#When you have no Broken Heart: {{Damage}} +49.5% Damage",
        SeijaNerf = "Killing enemys will not remove the {{BrokenHeart}} Broken Heart"
    },
    [Collectibles.BrainOfConfusion.ID] = {
        name = "Impulse to Destroy",
        info = "{{Battery}} Only spends 3 charges on use" ..
            '#{{Collectible483}} Detonate enemies and traps with "Eye", otherwise display "eye" of all enemies and traps in the room' ..
            '#{{Damage}} Enemies with "Eye" take double the damage' ..
            "#{{Bomb}} If there is no enemy in the room, directly produce an expl osion" ..
            "#!!! Explosion can destroy something usually cannot be destroyed",
        BookOfVirtues = "{{OuterWisp}}{{Wisp}} 1|{{Heart}} 3|{{Damage}} 7" ..
            "#{{ColorPastelBlue}} {{Collectible463}} Sulfuric Acid Tears",
    }
}

EIDInfo.EIDBirthright = {

}

EIDInfo.EIDPlayers = {

}

EIDInfo.EIDCards = {

}

EIDInfo.EIDEntities = {

}

return EIDInfo
