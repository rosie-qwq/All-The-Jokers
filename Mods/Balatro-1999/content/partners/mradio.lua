Partner_API.Partner{
    key = "mradio",
    name = "Ms. Radio",
    unlocked = true,
    discovered = true,
    individual_quips = true,
    pos = {x = 3, y = 0},
    loc_txt = {},
    atlas = "part",
    config = {extra = { chip_procent = 5 }},
    link_config = {j_b1999_mradio = 1},
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = 1
        if link_level == 1 then benefits = 2 end
        return { vars = { card.ability.extra.chip_procent * benefits } }
    end,
    calculate = function(self, card, context)
        if context.selling_card then
            local link_level = self:get_link_level()
            local benefits = 1
            if link_level == 1 then benefits = 2 end
            G.GAME.blind.chips = G.GAME.blind.chips - (G.GAME.blind.chips * ((card.ability.extra.chip_procent * benefits) / 100))
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end
}