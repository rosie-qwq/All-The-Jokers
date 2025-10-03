SpecilReverse("j_turtle_bean","j_b1999_kala")

SMODS.Joker {
	key = 'kala',
	rarity = 'b1999_reversed',
	atlas = 'B1999',
	pos = { x = 4, y = 2 },
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = { extra = { turtle_rounds = 0, total_rounds = 3, h_size = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.turtle_rounds, card.ability.extra.total_rounds, card.ability.extra.h_size } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.turtle_rounds = card.ability.extra.turtle_rounds + 1
			if card.ability.extra.turtle_rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
			end
			return {
				message = "" .. card.ability.extra.turtle_rounds
			}
		end
		if context.selling_self and (card.ability.extra.turtle_rounds >= card.ability.extra.total_rounds) and not context.blueprint then
			G.hand:change_size(card.ability.extra.h_size)
		end
	end
}