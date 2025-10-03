SMODS.Voucher {
    key = "extreme_couponing",
    atlas = "Vouchers",
    pos = { x = 5, y = 0 },
    config = {
        extra = {
            slot = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slot } }
    end,
    cost = 10,
    unlocked = true,
    available = true,
    requires = {"v_fmod_coupon"},
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slot
        return true end}))
    end,
}