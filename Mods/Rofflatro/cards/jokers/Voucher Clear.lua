SMODS.Joker{
    key = 'voucherclear',
    atlas = 'roffers',
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 1, y = 5 },
    cost = 4,
    calculate = function(self,card,context)
        if G.GAME.round_resets.blind_states.Big == 'Defeated' and G.GAME.round_resets.blind_states.Boss  == 'Upcoming' and context.ending_shop and G.shop_vouchers and not context.blueprint then
            for i = 1, #G.shop_vouchers.cards do
                -- This part destroys the G.shop_vouchers.cards[i].
                play_sound('slice1')
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                        SMODS.remove_pool(G.P_CENTER_POOLS.Voucher, G.shop_vouchers.cards[i].config.center_key)
                        G.shop_vouchers.cards[i]:start_dissolve({HEX("57ecab")}, nil, 1.6)
                        if G.GAME.current_round.voucher.spawn[G.shop_vouchers.cards[i].config.center_key] then
                            G.GAME.current_round.voucher.spawn[G.shop_vouchers.cards[i].config.center_key] = false
                        end
                        G.jokers:remove_card(G.shop_vouchers.cards[i])
                        --G.shop_vouchers.cards[i]:remove()
                        G.shop_vouchers.cards[i] = nil
                        return true;
                    end
                }))
            end
        end
    end,
    set_badges = function (self, card, badges)
        badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
        badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_code'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
    end
}
