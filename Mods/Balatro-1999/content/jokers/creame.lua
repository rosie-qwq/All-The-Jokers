SpecilReverse("j_ice_cream","j_b1999_creame")

SMODS.Joker {
	key = 'creame',
	rarity = 'b1999_reversed',
	atlas = 'B1999',
	pos = { x = 3, y = 2 },
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = { extra = { chips_gain = 5, chips = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips_gain, card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
			return {
				message = "+" .. card.ability.extra.chips_gain,
				colour = G.C.CHIPS
			}
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
	end
}

