SMODS.Joker {
	key = 'anjo',
	rarity = 3,
	atlas = 'B1999',
	pos = { x = 0, y = 0 },
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = { extra = { x_mult = 1, check = 0, x_mult_gain = 0.25, charge = 5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult, card.ability.extra.check, card.ability.extra.x_mult_gain, card.ability.extra.charge } }
	end,
	calculate = function(self, card, context)
		for i=1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                local my_pos = i
					if card.ability.extra.check < card.ability.extra.charge then
					if my_pos and context.other_card == G.jokers.cards[my_pos + 1] and context.post_trigger and not context.blueprint then
						card.ability.extra.check = card.ability.extra.check + 1
						return {
							message = " " .. card.ability.extra.check ,
							colour = G.C.RARITY[4],
						}
					end
					end
					end
					if card.ability.extra.check >= card.ability.extra.charge and not context.blueprint then
						card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
						card.ability.extra.check = 0
						return {
							message = "X" .. card.ability.extra.x_mult_gain .. " gained!"
						}
					end
					if context.joker_main and card.ability.extra.x_mult > 1 then
						return {
						  x_mult_mod = card.ability.extra.x_mult,
						}
					  end
			end
	end
}