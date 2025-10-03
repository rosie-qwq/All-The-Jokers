SMODS.Voucher {
    key = "dumpster_ritual",
    atlas = "Vouchers",
    pos = { x = 2, y = 0 },
    cost = 10,
    config = {
        extra = {
            discard = 2
        }
    },
    unlocked = true,
    available = true,
    requires = {"v_wasteful", "v_recyclomancy"},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discard } }
    end,
    redeem = function(self, card)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discard
        ease_discard(card.ability.extra.discard)
    end
}