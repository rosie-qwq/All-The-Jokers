SMODS.Joker{
	key = 'birthday',
	atlas = 'roffers',
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 5, y = 4 },
	config = { extra = { options = 1 } },
	loc_vars = function(self,info_queue,card)
		return {vars = {card.ability.extra.options}}
	end,
	calculate = function(self,card,context)
		if context.open_booster then
			context.card.ability.extra = context.card.ability.extra + 1 
		end
	end,
	set_badges = function (self, card, badges)
		  badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		  badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_code'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
	end
}
