SMODS.Joker {
	key = "sprinter",
	name = "Sprinter",
	config = { extra = { chips = 0, chips_scale = 75 } },
	rarity = "crp_plentiful",
	atlas = "crp_joker",
	pos = { x = 4, y = 0 },
	cost = 5,
	blueprint_compat = true,
	demicoloncompat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { lenient_bignum(card.ability.extra.chips), lenient_bignum(card.ability.extra.chips_scale) } }
	end,
	calculate = function(self, card, context)
		if (context.joker_main) or context.forcetrigger then
			return {
				chips = lenient_bignum(card.ability.extra.chips),
			}
		end
		if (context.before and next(context.poker_hands["Straight Flush"]) and not context.blueprint) or context.forcetrigger then
			card.ability.extra.chips = lenient_bignum(card.ability.extra.chips) + lenient_bignum(card.ability.extra.chips_scale)
			return {
				message = "Upgraded!",
				colour = G.C.CHIPS,
				
			}
		end
	end,
	in_pool = function(self, args)
		return true, { allow_duplicates = true }
	end,
	crp_credits = {
		idea = { "Poker The Poker" },
		art = { "MarioFan597" },
		code = { "Glitchkat10" },
		custom = { key = "alt", text = "Runner" }
	}
}

SMODS.Joker {
	key = "pennant",
	name = "Pennant",
	config = { extra = { mult = 4 } },
	rarity = "crp_plentiful",
	atlas = "crp_placeholder",
	pos = { x = 2, y = 0 },
	cost = 5,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { lenient_bignum(card.ability.extra.mult) } }
	end,
	calculate = function(self, card, context)
		if (context.joker_main) or context.forcetrigger then
			return {
				mult = lenient_bignum(lenient_bignum(G.GAME.current_round.hands_left) * lenient_bignum(card.ability.extra.mult))
			}
		end
	end,
	crp_credits = {
		idea = { "TheLampster" },
		code = { "wilfredlam0418" },
		custom = { key = "alt", text = "Banner" }
	}			
}
