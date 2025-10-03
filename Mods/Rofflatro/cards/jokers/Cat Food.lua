SMODS.Joker{
	key = 'catfood',
	atlas = 'roffers',
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 4, y = 7 },
	config = { extra = { } },
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
		return {vars = {}}
	end,
	calculate = function(self,card,context)
		if context.repetition then
			if context.other_card.ability.effect == "Lucky Card" and not context.other_card.lucky_trigger then --if the card is lucky and didn't proc
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = context.other_card
				}
			end
		end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
	end
}
