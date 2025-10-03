--What Would Doc Do? (Rare) - Gains x0.1 Mult if interest is maxed out at end of round. Resets when failing to reach an interest threshold. (Money is strength. Stop rerolling.)

SMODS.Joker{
	key = 'Doc',
	atlas = 'roffers',
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 4, y = 6 },
	config = { extra = {
			Xmult = 1,
			Xmult_mod = .4
		}
	},
	loc_vars = function(self,info_queue,card)
		return {vars = {card.ability.extra.Xmult_mod, card.ability.extra.Xmult}}
	end,
	calculate = function(self,card,context)

		if context.joker_main then
			return {
				x_mult = card.ability.extra.Xmult
			}
		end
		
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			if not G.GAME.dollar_buffer then
				G.GAME.dollar_buffer = 0
			end

			if to_big(G.GAME.dollars + G.GAME.dollar_buffer) >= to_big(G.GAME.interest_cap) then
				card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.Xmult_mod)
				return {
					message = localize("k_roff_doc_upgrade"),
					colour = G.C.MONEY
				}
			else
				card.ability.extra.Xmult = 1
				return {
					message = localize("k_roff_doc_reset"),
					colour = G.C.PALE_GREEN
				}
			end
		end

	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_code'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
	end
}
