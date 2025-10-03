SMODS.Joker {
	key = 'pav',
	rarity = 1,
	atlas = 'B1999',
	pos = { x = 1, y = 0 },
	cost = 3,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = { extra = { mult = 0, mult_gain = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,
	calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Joker" and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
	end
}
