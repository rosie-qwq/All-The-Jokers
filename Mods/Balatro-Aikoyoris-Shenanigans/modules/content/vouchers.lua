SMODS.Voucher {
    key = "alphabet_soup",
    atlas = 'aikoyoriVouchers', pos = { x = 2, y = 0 } ,
    cost = 10,
    redeem = function (self, card) 
        G.GAME.akyrs_character_stickers_enabled = true
        G.GAME.akyrs_wording_enabled = true
        for _,c in ipairs(G.playing_cards) do
            c:set_sprites(c.config.center,c.config.card)
        end
    end,
    unredeem = function (self, card) 
        G.GAME.akyrs_character_stickers_enabled = false
        G.GAME.akyrs_wording_enabled = false
        for _,c in ipairs(G.playing_cards) do
            c:set_sprites(c.config.center,c.config.card)
        end
    end,
    in_pool = function (self, args)
        return not G.GAME.akyrs_mathematics_enabled
    end
}

SMODS.Voucher {
    key = "crossing_field",
    atlas = 'aikoyoriVouchers', pos = { x = 3, y = 0 } ,
    cost = 10,
    requires = { "v_akyrs_alphabet_soup" },
    redeem = function (self, card) 
        G.GAME.akyrs_letters_mult_enabled = true
    end,
    unredeem = function (self, card) 
        G.GAME.akyrs_letters_mult_enabled = false
    end,
    in_pool = function (self, args)
        return not G.GAME.akyrs_mathematics_enabled
    end
}