SMODS.Voucher {
    key = "big_bang",
    atlas = "Vouchers",
    pos = { x = 3, y = 0 },
    config = {
        extra = {
            ante = 2,
            hand_size = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.ante, card.ability.extra.hand_size } }
    end,
    cost = 10,
    unlocked = true,
    available = true,
    requires = {"hieroglyph", "petroglyph"},
    redeem = function(self, card)
        ease_ante(- card.ability.extra.ante)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.ante
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
}