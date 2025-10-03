SMODS.Stake {
    key = "outer",
    atlas = "aikoStakes", pos = {x = 1, y = 1},
    sticker_atlas = "aikoStakeStickers", sticker_pos = {x = 1, y = 1},
    applied_stakes = {  },
    modifiers = function ()
        G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
    end
}

SMODS.Stake {
    key = "inner",
    atlas = "aikoStakes", pos = {x = 2, y = 1},
    sticker_atlas = "aikoStakeStickers", sticker_pos = {x = 2, y = 1},
    applied_stakes = {  },
    modifiers = function ()
        G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + 1
    end
}

SMODS.Stake {
    key = "oxidising",
    atlas = "aikoStakes", pos = {x = 0, y = 0},
    sticker_atlas = "aikoStakeStickers", sticker_pos = {x = 0, y = 0},
    applied_stakes = { "white" },
    prefix_config = { applied_stakes = { mod = false } },
    colour = HEX("b74912"),    
    modifiers = function ()
        G.GAME.modifiers.akyrs_spawn_oxidising = true
    end
}