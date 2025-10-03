Partner_API.Partner{
    key = "fm",
    name = "Familiar Melody",
    unlocked = true,
    discovered = true,
    no_quips = true,
    pos = {x = 1, y = 0},
    loc_txt = {},
    atlas = "part",
    config = {extra = { moxie = 100, moxie_gain = 10, moxie_max = 100, fm1_cost = 50, fm2_cost = 25 }},
    link_config = {j_b1999_fm = 1},
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = 1
        if link_level == 1 then benefits = 2 end
        return { vars = { card.ability.extra.moxie, card.ability.extra.moxie_gain * benefits, card.ability.extra.moxie_max, card.ability.extra.fm1_cost, card.ability.extra.fm2_cost, colours = { HEX("638fe1") } } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.moxie < card.ability.extra.moxie_max then
            local link_level = self:get_link_level()
            local benefits = 1
            if link_level == 1 then benefits = 2 end
            card.ability.extra.moxie = card.ability.extra.moxie + card.ability.extra.moxie_gain * benefits
        end
        if card.ability.extra.moxie > card.ability.extra.moxie_max then
            card.ability.extra.moxie = card.ability.extra.moxie_max
        end
        if context.partner_click and card.ability.extra.moxie >= 50 and G.STATE == G.STATES.SELECTING_HAND and #G.consumeables.cards < G.consumeables.config.card_limit then
            card.ability.extra.moxie = card.ability.extra.moxie - card.ability.extra.fm1_cost
            SMODS.add_card { key = "c_b1999_mel1" }
        end
        if context.partner_R_click and card.ability.extra.moxie >= 25 and G.STATE == G.STATES.SELECTING_HAND and #G.consumeables.cards < G.consumeables.config.card_limit then
            card.ability.extra.moxie = card.ability.extra.moxie - card.ability.extra.fm2_cost
            SMODS.add_card { key = "c_b1999_mel2" }
        end
    end
}

