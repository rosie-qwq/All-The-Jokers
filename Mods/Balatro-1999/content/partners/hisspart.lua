Partner_API.Partner{
    key = "hissabeth",
    name = "hissabeth",
    unlocked = true,
    discovered = true,
    no_quips = false,
    pos = {x = 0, y = 1},
    loc_txt = {},
    atlas = "part",
    config = {extra = { hiss = 0, per = "Once" }},
    link_config = {j_b1999_hissabeth = 1},
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = 1
        info_queue[#info_queue + 1] = G.P_CENTERS["m_b1999_hiss"]
        if link_level == 1 then benefits = 2 end
        return { vars = { card.ability.extra.per } } 
    end,
    calculate = function(self, card, context)
        local link_level = self:get_link_level()
        if link_level == 1 then
            card.ability.extra.per = "Twice"
            else
            card.ability.extra.per = "Once"
        end
        if context.setting_blind then
            local benefits = 1
            if link_level == 1 then benefits = 2 end
            card.ability.extra.hiss = 1 * benefits
        end
        if context.partner_click and card.ability.extra.hiss > 0 and G.STATE == G.STATES.SELECTING_HAND then
            card.ability.extra.hiss = card.ability.extra.hiss - 1
            SMODS.add_card({set = 'Enhanced', enhancement = 'm_b1999_hiss', area = G.hand })
        end
        if context.end_of_round then
            card.ability.extra.hiss = 0
        end
    end
}

