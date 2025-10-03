SMODS.Joker {
	key = 'door',
	rarity = 1,
	atlas = 'B1999',
	pos = { x = 2, y = 0 },
	cost = 2,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	config = { extra = { x_mult = 2, n = 1, d = 4 } },
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, card.ability.extra.n, card.ability.extra.d, 'door')
		return { vars = { card.ability.extra.x_mult, n, d } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
			x_mult = card.ability.extra.x_mult
			}
		end
		if context.after and SMODS.pseudorandom_probability(card, 'door', card.ability.extra.n, card.ability.extra.d, 'door') then
			card:shatter()
		end
	end
}

