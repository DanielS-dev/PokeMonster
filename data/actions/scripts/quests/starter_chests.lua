local STARTER_CHEST_STORAGE = 91700

local STARTER_CHESTS = {
    [1700] = {
        pokemon = "Bulbasaur",
        message = "Voce escolheu Bulbasaur!"
    },

    [1701] = {
        pokemon = "Squirtle",
        message = "Voce escolheu Squirtle!"
    },

    [1702] = {
        pokemon = "Charmander",
        message = "Voce escolheu Charmander!"
    }
}

local POKEBALL_ITEMID = 26662

-- posição para onde o player será teleportado
local TELEPORT_POSITION = Position(2217, 2377, 6)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(STARTER_CHEST_STORAGE) == 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja escolheu um bau desta quest.")
        return true
    end

    local chestUid = item:getUniqueId()
    local reward = STARTER_CHESTS[chestUid]

    if not reward then
        player:sendCancelMessage("Este bau nao esta configurado corretamente.")
        return true
    end

    player:addPokemon(reward.pokemon, POKEBALL_ITEMID)
    player:setStorageValue(STARTER_CHEST_STORAGE, 1)

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, reward.message)

    -- efeito na posição atual antes de teleportar
    player:getPosition():sendMagicEffect(CONST_ME_POFF)

    -- teleporta o player
    player:teleportTo(TELEPORT_POSITION)

    -- efeito na nova posição
    TELEPORT_POSITION:sendMagicEffect(CONST_ME_TELEPORT)

    return true
end