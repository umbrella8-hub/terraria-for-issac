local EIDInfoAll = {
    zh_cn = include("translations/eid_zh"),
    en_us = include("translations/eid_en"),
}

if EID then
    for language, EIDInfo in pairs(EIDInfoAll) do
        --道具描述
        local descriptions = EID.descriptions[language];
        descriptions.reverieBelialReplace = {}
        descriptions.BFFSSynergies = descriptions.BFFSSynergies or {};
        for id, des in pairs(EIDInfo.Collectibles) do
            EID:addCollectible(id, des.info, des.name, language)
            --美德书兼容效果描述
            if (des.BookOfVirtues and descriptions.bookOfVirtuesWisps) then
                descriptions.bookOfVirtuesWisps[id] = des.BookOfVirtues;
            end
            --犹大长子权兼容效果描述
            if (des.BookOfBelial and descriptions.bookOfBelialBuffs) then
                descriptions.bookOfBelialBuffs[id] = des.BookOfBelial;
            end
            --犹大长子权效果替换描述
            if (des.BookOfBelialReplace and descriptions.reverieBelialReplace) then
                descriptions.reverieBelialReplace["5.100." .. id] = des.BookOfBelialReplace;
            end
            --大胃王兼容效果描述
            if (des.BingeEater and descriptions.bingeEaterBuffs) then
                descriptions.bingeEaterBuffs[id] = des.BingeEater;
            end
            --好朋友一辈子兼容效果描述
            if (des.BFFs and descriptions.BFFSSynergies) then
                EID:addBFFSCondition(id, des.BFFs, nil, nil, language)
            end
        end
        --长子权描述
        for id, des in pairs(EIDInfo.EIDBirthright) do
            EID:addBirthright(id, des.info, des.name, language);
        end
        --角色信息描述
        for id, des in pairs(EIDInfo.EIDPlayers) do
            EID:addCharacterInfo(id, des.info, des.name, language);
        end
        --卡牌描述
        for id, des in pairs(EIDInfo.EIDCards) do
            EID:addCard(id, des.info, des.name, language);
        end
        --其他实体描述
        if EIDInfo.EIDEntities then
            for _, des in pairs(EIDInfo.EIDEntities) do
                if type(des.info) == "function" then
                    des.info = des.info()
                end
                EID:addEntity(des.Type, des.Variant, des.SubType, des.name, des.info, language)
            end
        end
    end
end
