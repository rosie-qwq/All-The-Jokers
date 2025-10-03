SMODS.Voucher {
    key = "buffet",
    atlas = "Vouchers",
    pos = { x = 1, y = 1 },
    cost = 10,
    config = {
        extra = {
            hand = 2
        }
    },
    unlocked = true,
    available = true,
    requires = {"v_grabber", "v_nacho_tong"},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand } }
    end,
    redeem = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hand
        ease_hands_played(card.ability.extra.hand)
    end
}