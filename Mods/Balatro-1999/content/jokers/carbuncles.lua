

SMODS.Joker {
	key = 'car',
	rarity = 2,
	atlas = 'buncles',
	no_pool_flag = 'evo',
	pos = { x = 0, y = 0 },
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { mult = 4, rounds = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.rounds } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { mult = card.ability.extra.mult }
		end
		if context.end_of_round and context.main_eval and card.ability.extra.rounds < 3 then
			card.ability.extra.rounds = card.ability.extra.rounds + 1
		end
		for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
                local my_pos = i
				if my_pos == #G.jokers.cards then
				for i = 1, #G.consumeables.cards do
			if card.ability.extra.rounds == 3 and G.consumeables.cards[i].ability.set == "Tarot" then
					G.consumeables.cards[i]:start_dissolve()
					card:juice_up()
					card:set_ability("j_b1999_carton")
					card.ability.extra.rounds = 0
					return { message = "Carton!"}
			elseif card.ability.extra.rounds == 3 and G.consumeables.cards[i].ability.set == "Planet" then
					G.consumeables.cards[i]:start_dissolve()
					card:juice_up()
					card:set_ability("j_b1999_geo")
					card.ability.extra.rounds = 0
					return { message = "Geometry!"}
			elseif card.ability.extra.rounds == 3 and G.consumeables.cards[i].ability.set == "Spectral" then
					G.consumeables.cards[i]:start_dissolve()
					card:juice_up()
					card:set_ability("j_b1999_refine")
					card.ability.extra.rounds = 0
					return { message = "Refined!"}
				end
			end
		end
		end
		end
    end
}

SMODS.Joker {
	key = 'carton',
	rarity = 2,
	in_pool = function(self)
    return false
	end,
	atlas = 'buncles',
	pos = { x = 1, y = 0 },
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { rounds = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.rounds } }
	end,
	calculate = function(self, card, context)
		if context.b1999_use_card and #G.hand.highlighted >= 1 then
		local leftright = pseudorandom('biggering', 1, 2)
			if leftright == 1 then
				local carded = G.hand.cards[1]
				G.hand:remove_from_highlighted(carded, true)
				G.hand:add_to_highlighted(carded, true)
			return { message = "Bluh!"}
			else
				local carded = G.hand.cards[#G.hand.cards]
				G.hand:remove_from_highlighted(carded, true)
				G.hand:add_to_highlighted(carded, true)
			return { message = "Ruh?"}
			end
		end
    end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.eaten = true
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.eaten = false
	end	
}

SMODS.Joker {
	key = 'geo',
	rarity = 2,
	in_pool = function(self)
    return false
	end,
	atlas = 'buncles',
	pos = { x = 2, y = 0 },
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { n = 1, d = 2 } },
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, card.ability.extra.n, card.ability.extra.d, 'geo')
		return { vars = { n, d } }
	end,
	calculate = function(self, card, context)
		if G.consumeables.cards[1] and context.before and context.main_eval and SMODS.pseudorandom_probability(card, 'geo', card.ability.extra.n, card.ability.extra.d, 'geo') then
			G.consumeables.cards[1]:start_dissolve()
            return {
                level_up = true,
                message = localize('k_level_up_ex')
            }
		elseif G.consumeables.cards[1] and context.before then
			G.consumeables.cards[1]:start_dissolve()
		elseif context.before then
			return{
				level_up = -1,
				message = "Hehe"
			}
		end
    end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.eaten = true
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.eaten = false
	end	
}

SMODS.Joker {
	key = 'refine',
	rarity = 2,
	in_pool = function(self)
    return false
	end,
	atlas = 'buncles',
	pos = { x = 3, y = 0 },
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { x_mult = 1, x_mult_gain = 0.1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult_gain } }
	end,
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == 'Spectral' then
			card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
			return { message = "So refined!"}
		end
		if context.joker_main then
			return { xmult = card.ability.extra.x_mult }
		end
    end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.eaten = true
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.eaten = false
	end	
}

