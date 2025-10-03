SpecilReverse("j_cavendish","j_b1999_will")

SMODS.Joker {
	key = 'will',
	rarity = 'b1999_reversed',
	atlas = 'B1999',
	pos = { x = 0, y = 3 },
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = { extra = { x_mult = 1, x_mult_gain = 0.5, n = 1, d = 2 } },
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, card.ability.extra.n, card.ability.extra.d, 'will')
		return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult_gain, n, d } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and SMODS.pseudorandom_probability(card, 'will', card.ability.extra.n, card.ability.extra.d, 'will') and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
			return {
				message = "+X" .. card.ability.extra.x_mult_gain,
				colour = G.C.MULT
			}
		end
		if context.joker_main then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
	end
}