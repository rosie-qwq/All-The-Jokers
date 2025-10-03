SpecilReverse("j_diet_cola","j_b1999_papper")

SMODS.Joker {
	key = 'papper',
	rarity = 'b1999_reversed',
	atlas = 'B1999',
	pos = { x = 1, y = 3 },
	cost = 6,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { pap_round = 0, total_rounds = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.pap_round, card.ability.extra.total_rounds } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
        	card.ability.extra.pap_round = card.ability.extra.pap_round + 1
			return {
				message = "+1"
			}
		end
		if context.end_of_round and card.ability.extra.pap_round == card.ability.extra.total_rounds and not context.blueprint then
			add_tag(B1999.poll_tag("papper",  nil, {}))
			card.ability.extra.pap_round = 0
		end
	end
}
