
SMODS.Joker {
	key = 'orange',
	rarity = 2,
	atlas = 'B1999',
	no_pool_flag = 'eaten',
	pos = { x = 4, y = 0 },
	cost = 5,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	config = { extra = { eat = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.eat } }
	end,
	calculate = function(self, card, context)
			for i=1, #G.consumeables.cards do
				if context.before and card.ability.extra.eat < 5 and not context.blueprint then
					G.consumeables.cards[i]:start_dissolve()
					card.ability.extra.eat = card.ability.extra.eat + 1
					return {
						message = "Nom",
					}
				end
				if context.before and card.ability.extra.eat >= 5 and not context.blueprint then
					card:juice_up()
					card:set_ability("j_b1999_gun")
					G.GAME.pool_flags.eaten = true
					return {
						message = "Nom",
					}
			end
        end
    end
}

SMODS.Joker {
	key = 'gun',
	rarity = 2,
	atlas = 'B1999',
	yes_pool_flag = "eaten",
	pos = { x = 5, y = 0 },
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { x_mult = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult } }
	end,
	calculate = function(self, card, context)
			if context.joker_main then
				return {
				x_mult_mod = card.ability.extra.x_mult,
				}
			end
	end
}