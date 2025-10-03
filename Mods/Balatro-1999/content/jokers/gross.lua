SpecilReverse("j_gros_michel","j_b1999_gross")

SMODS.Joker {
	key = 'gross',
	rarity = 'b1999_reversed',
	atlas = 'B1999',
	pos = { x = 5, y = 2 },
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = { extra = { mult = 0, mult_gain = 5, n = 1, d = 2 } },
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, card.ability.extra.n, card.ability.extra.d, 'will')
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, n, d } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and SMODS.pseudorandom_probability(card, 'gross', card.ability.extra.n, card.ability.extra.d, 'gross') and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return {
				message = "+" .. card.ability.extra.mult,
				colour = G.C.MULT
			}
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}