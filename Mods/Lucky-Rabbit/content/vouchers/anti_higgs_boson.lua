SMODS.Voucher {
    key = "anti_higgs_boson",
    atlas = "Vouchers",
    pos = { x = 2, y = 1 },
    cost = 10,
    unlocked = true,
    available = true,
    requires = {"v_blank", "v_antimatter"},
    redeem = function(self, card)
        if G.GAME.used_vouchers.v_blank then
            G.GAME.used_vouchers.v_blank = false
            G.GAME.used_jokers.v_blank = false
        end
        if G.GAME.used_vouchers.v_antimatter then
            G.GAME.used_vouchers.v_antimatter = false
            G.GAME.used_jokers.v_antimatter = false
        end
        G.E_MANAGER:add_event(Event({func = function()
            if G.jokers then
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            end
        return true end }))
    end,
    draw = function(self, card, layer)
        card.children.center:draw_shader("negative", nil, card.ARGS.send_to_shader)
    end,
}