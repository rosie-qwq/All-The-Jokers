
SMODS.Joker {
	key = 'ws',
	rarity = 2,
	atlas = 'B1999',
	pos = { x = 0, y = 1 },
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { x_mult = 3, check = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { colours = { HEX("638fe1") } } }
	end,
	calculate = function(self, card, context)
        local oldnumbah = G.hand.config.highlighted_limit
		local thing = false
		if context.b1999_play_button then
        for k, v in pairs(G.hand.cards) do
            if v:is_suit("Spades") then
                G.hand.config.highlighted_limit = #G.hand.cards
				G.hand:remove_from_highlighted(v, true)
                G.hand:add_to_highlighted(v, true)
				thing = true
            end
		end
	end
        if context.modify_scoring_hand and context.other_card:is_suit("Spades") and not context.blueprint then
            return {
                add_to_hand = true
            }
        end
        if thing == true then
				G.hand.config.highlighted_limit = oldnumbah
        end
end
}

