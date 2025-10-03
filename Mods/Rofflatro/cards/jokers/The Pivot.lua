SMODS.Joker{
	key = 'pivot',
	atlas = 'roffers',
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 4, y = 3 },
	config = { extra = {
			dollars = 10,
			joker_hand = "High Card",
			joker_hand_count = 0,
			hands_for_payout = 3,
		}
	},
	loc_vars = function(self,info_queue,card)
		return {vars = {card.ability.extra.dollars, card.ability.extra.hands_for_payout}}
	end,
	calculate = function(self,card,context)
		if context.before and context.cardarea == G.jokers and not context.blueprint then
			local tempplayed = 0
			local hand
			for k, v in pairs(G.GAME.hands) do
				if v.played > tempplayed and v.visible then
					tempplayed = v.played
					hand = k
				end
			end
			if context.scoring_name ~= hand then
				if context.scoring_name ~= card.ability.extra.joker_hand then
					card.ability.extra.joker_hand_count = 1 
					card.ability.extra.joker_hand = context.scoring_name
					return {
						message = localize('k_reset')
					}
				else
					card.ability.extra.joker_hand_count = card.ability.extra.joker_hand_count + 1
					if card.ability.extra.joker_hand_count >= 3 then
						return {
							message = localize('k_roff_pivot_active')
						}
					end
				end
			else 
				card.ability.extra.joker_hand_count = 1 
				return {
					message = localize('k_reset')
				}
			end
		end
	end,
	set_badges = function (self, card, badges)
		if card.ability.extra.joker_hand_count >= 3 then 
			badges[#badges+1] = create_badge('Active', G.C.GREEN, G.C.WHITE, 0.8)
		else
			badges[#badges+1] = create_badge('Inactive', G.C.RED, G.C.WHITE, 0.8)
		end
		badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_art'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_code'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
	end,
	calc_dollar_bonus = function(self, card)
		local bonus = card.ability.extra.dollars
		if card.ability.extra.joker_hand_count >= 3 and bonus > 0 then return bonus end
	end


}
