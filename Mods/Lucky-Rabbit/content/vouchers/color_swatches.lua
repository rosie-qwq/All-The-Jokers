SMODS.Voucher {
    key = "color_swatches",
    atlas = "Vouchers",
    pos = { x = 3, y = 1 },
    cost = 10,
    config = {
        extra = {
            hand_size = 2
        }
    },
    unlocked = true,
    available = true,
    requires = {"v_paint_brush", "v_palette"},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand_size } }
    end,
    redeem = function(self, card)
        G.hand:change_size(card.ability.extra.hand_size)
    end
}