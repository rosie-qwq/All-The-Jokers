SMODS.Joker{
	key = 'sevens',
	atlas = 'roffers',
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 4, y = 4 },
    soul_pos = {x = 0, y = 4},
	config = { extra = { Xmult = 2, odds = 3 } },
	loc_vars = function(self,info_queue,card)
		return {vars = {G.GAME.probabilities.normal or 1, card.ability.extra.odds, card.ability.extra.Xmult}}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 7 then
				if pseudorandom('roff_sevens') <= G.GAME.probabilities.normal / card.ability.extra.odds then 
                return {
                    Xmult = card.ability.extra.Xmult
                }
				else 
					local effects
					SMODS.calculate_context({roff_probability_missed = true}, effects)
				end
            end
        end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
	end
}
