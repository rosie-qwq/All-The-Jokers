SMODS.Voucher {
    key = "fire_sale",
    atlas = "Vouchers",
    pos = { x = 4, y = 0 },
    config = {
        extra = {
            packs = 1,
            card = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.card, card.ability.extra.packs } }
    end,
    cost = 10,
    unlocked = true,
    available = true,
    requires = {"v_clearance_sale", "v_liquidation"},
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({func = function()
            SMODS.change_booster_limit(card.ability.extra.packs)
            change_shop_size(1)
        return true end}))
    end,
}