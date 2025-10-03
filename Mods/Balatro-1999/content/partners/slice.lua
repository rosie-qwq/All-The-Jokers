Partner_API.Partner{
    key = "slice",
    name = "Orange Slice",
    unlocked = true,
    discovered = true,
    individual_quips = true,
    pos = {x = 0, y = 0},
    loc_txt = {},
    atlas = "part",
    config = {extra = { x_mult = 1, x_mult_gain = 0.25 }},
    link_config = {j_b1999_orange = 1, j_b1999_gun = 2},
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = 1
        if link_level == 1 then benefits = 2 end
        if link_level == 2 then benefits = 3 end
        return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult_gain * benefits } }
    end,
    calculate = function(self, card, context)
				for i=1, #G.consumeables.cards do
                    if context.partner_click and G.STATE == G.STATES.SELECTING_HAND then
                    local link_level = self:get_link_level()
                    local benefits = 1
                    if link_level == 1 then benefits = 2 end
                    if link_level == 2 then benefits = 3 end
					G.consumeables.cards[i]:start_dissolve()
                    card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain * benefits
					return {
                        card = G.consumeables.cards[i],
					}
                end
            end
                if context.joker_main and card.ability.extra.x_mult > 1 then
                    return {
                        message = localize{type = "variable", key = "a_xmult", vars = {card.ability.extra.x_mult}},
                        Xmult_mod = card.ability.extra.x_mult,
                    }
                    end
                if context.after then
                    G.E_MANAGER:add_event(Event({func = function()
                    card.ability.extra.x_mult = 1
                return true end}))
                    end
            end
}
