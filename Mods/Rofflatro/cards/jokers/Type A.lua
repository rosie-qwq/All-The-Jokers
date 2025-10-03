SMODS.Joker{
	key = 'typeA',
	atlas = 'roffers',
	rarity = 3,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = { x = 2, y = 2 },
	config = { extra = {
			extra = 0.25,
			x_mult = 1,
			handsel = 'Straight Flush'
		}
	},
	loc_vars = function(self,info_queue,card)
		return {vars = {card.ability.extra.extra, card.ability.extra.x_mult, card.ability.extra.handsel}}
	end,
	calculate = function(self,card,context)
		if context.before and next(context.poker_hands[card.ability.extra.handsel]) and not context.blueprint then
			card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.extra
			return {
				message = 'Upgraded!',
				colour = G.C.XMULT,
				card = card
			}
		end
		if context.before and 
			(context.scoring_name == 'High Card' or
			context.scoring_name == 'Pair' or
			context.scoring_name == 'Two Pair' or
			context.scoring_name == 'Three of a Kind')
		and not context.blueprint then
			if card.ability.extra.x_mult > 1 then
				card.ability.extra.x_mult = 1
				return {
					card = card,
					message = localize('k_reset')
				}
			end
		end
		if context.joker_main then
			return {
				Xmult = card.ability.extra.x_mult
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			local _poker_hands = {"Straight Flush", "Four of a Kind", "Full House",}

			if G.GAME.hands['Five of a Kind'].visible then table.insert(_poker_hands, "Five of a Kind") end
			if G.GAME.hands['Flush Five'].visible then table.insert(_poker_hands, "Flush Five") end
			if G.GAME.hands['Flush House'].visible then table.insert(_poker_hands, "Flush House") end

			card.ability.extra.handsel = pseudorandom_element(_poker_hands, pseudoseed('type_A'))
			return {
				message = localize('k_roff_typea_update')
			}
		end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_maxx_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_maxx_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
	end
}
