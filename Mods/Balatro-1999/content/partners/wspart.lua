Partner_API.Partner{
    key = "ws",
    name = "Windsong",
    unlocked = true,
    discovered = true,
    individual_quips = true,
    pos = {x = 2, y = 0},
    loc_txt = {},
    atlas = "part",
    config = {extra = { mult = 2, held = "held in hand" }},
    link_config = {j_b1999_ws = 1},
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local benefits = false
        card.ability.extra.held = "held in hand"
        card.ability.extra.mult = 2
        if link_level == 1 then
            benefits = true
            card.ability.extra.held = "scored"
            card.ability.extra.mult = 3
        end
        return { vars = { card.ability.extra.mult, card.ability.extra.held } }
    end,
    calculate = function(self, card, context)
        local link_level = self:get_link_level()
        local benefits = false
        card.ability.extra.mult = 2
        card.ability.extra.held = "held in hand"
        if link_level == 1 then
            benefits = true
            card.ability.extra.held = "scored"
            card.ability.extra.mult = 3
        end
		if not context.end_of_round and context.individual and context.cardarea == G.hand and context.other_card:is_suit("Spades") and benefits == false then
            return {
				card = card,
                mult = card.ability.extra.mult
            }
        end
        if not context.end_of_round and context.individual and context.cardarea == G.play and context.other_card:is_suit("Spades") and benefits == true then
            return {
				card = card,
                mult = card.ability.extra.mult
            }
        end
    end
}