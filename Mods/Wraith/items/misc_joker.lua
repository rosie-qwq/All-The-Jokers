--[[local taxman = {
	key = "taxman",
	name = "wrt-Taxman",
		
	unlocked = true,
	discovered = false,
	eternal_compat = true,
	blueprint_compat = false,
	perishable_compat = false,
		
	atlas = "joke_one",
	config = {extra = {money = 9, Xmult = 3}},
	gameset_config = {
		modest = { extra = {money = 7, Xmult = 2}},
	},
	
	pos = {x = 2, y = 1},
	rarity = 3,
	cost = 10,
	
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.money, card.ability.extra.Xmult}}
	end,
	
	in_pool = function(self)
		if G.GAME.stake >= 8 then
			return true
		else
			return false
		end
	end
}]]

local watercooler = {
	key = "watercooler",
	name = "wrt-Watercooler",
		
	unlocked = false,
	discovered = false,
	eternal_compat = true,
	blueprint_compat = false,
	perishable_compat = true,
		
	atlas = "joke_one",
	config = {extra = {Xmult = 13, mul = 5}},
	gameset_config = {
		modest = {extra = {Xmult = 13, mul = 2}},
		mainline = {extra = {Xmult = 13, mul = 3}},
	},
	
	soul_pos = {x = 4, y = 1},
	pos = {x = 3, y = 1},
	rarity = 4,
	cost = 26,
	
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.Xmult, card.ability.extra.mul}}
	end,
	
	calculate = function(self, card, context)
		if
			(context.end_of_round and G.GAME.blind.boss and G.GAME.blind.name == "The Water" and not context.individual and not context.repetition)
		then
			card.ability.extra.Xmult = lenient_bignum(to_big(card.ability.extra.Xmult) * card.ability.extra.mul)
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = {number_format(card.ability.extra.mul)},
					}),
				})
			return nil, true
		end
	
		if context.joker_main or context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = {number_format(card.ability.extra.Xmult)},
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				colour = G.C.MULT,
			}
		end
	end
}

local light = {
	key = "light",
	name = "wrt-light",
		
	unlocked = true,
	discovered = false,
	eternal_compat = true,
	blueprint_compat = false,
	perishable_compat = true,
		
	atlas = "joke_one",
	config = {extra = {cards = 5, cur = 5, extra = 0.1, Xmult = 1, check = false}},
	
	pos = {x = 0, y = 2},
	rarity = 2,
	cost = 6,
	
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.cards, card.ability.extra.cur, card.ability.extra.extra, card.ability.extra.Xmult}}
	end,
	
	calculate = function(self, card, context)
		if card.ability.extra.cur <= 0 then
			card.ability.extra.cur = card.ability.extra.cards
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.extra
		end
	
		if context.individual and context.cardarea == G.play and not context.blueprint and not context.retrigger_joker then
			card.ability.extra.cur = card.ability.extra.cur - 1
		end
		
		if context.joker_main or context.forcetrigger then
			return {
				x_mult = card.ability.extra.Xmult,
			}
		end
	end
}

local golden = {
	key = "golden",
	name = "wrt-Golden",
		
	unlocked = true,
	discovered = false,
	eternal_compat = true,
	blueprint_compat = true,
	perishable_compat = true,
		
	atlas = "joke_one",
	config = {extra = {money = 1}},
	
	pos = {x = 1, y = 2},
	rarity = 2,
	cost = 9,
	
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.money}}
	end,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			return {
				dollars = lenient_bignum(card.ability.extra.money),
				card = card,
			}
		end
	end
}

return {
	name = "Misc. Jokers",
	items = {
		--taxman,
		watercooler,
		light,
		golden
	},
}