-- Crashout ($7, Rare)
-- When blind is selected, destroys all owned consumables. Gains x0.25 Mult per card destroyed. (Why is streamer so mad?)

SMODS.Joker{
key = 'crashout',
    atlas = 'roffers',
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    perishable_compat = false,
    pos = { x = 4, y = 5 },
    config = { extra = { Xmult = 1, Xmult_mod = .3 } },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult, card.ability.extra.Xmult_mod}}
    end,
    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint then
            if #G.consumeables.cards > 0 then
                card.ability.extra.Xmult = card.ability.extra.Xmult + (#G.consumeables.cards * card.ability.extra.Xmult_mod)
                for i = 1, #G.consumeables.cards do
                    local _card = G.consumeables.cards[i]
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            _card:start_dissolve({HEX("deb1b1")}, nil, 1.6)
                            _card = nil
                            return true;
                        end
                    }))
                end
                return {
                    message = localize("k_roff_crashout_upgrade"),
                    colour = HEX("deb1b1")
                }
            end
        elseif context.joker_main then
            return{
                Xmult = card.ability.extra.Xmult
            }
        end
    end,
    set_badges = function (self, card, badges)
        badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_art'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
        badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_code'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
    end
}
