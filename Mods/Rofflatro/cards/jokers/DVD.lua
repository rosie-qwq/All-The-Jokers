SMODS.Joker{
	key = 'dvd',
	atlas = 'roffers',
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	perishable_compat = false,
	pos = { x = 1, y = 3 },
	config = { extra = { chips = 0, chip_mod = 4 } },
	loc_vars = function(self,info_queue,card)
		return {vars = { card.ability.extra.chip_mod, card.ability.extra.chips }}
	end,
	calculate = function(self,card,context)
		if context.roff_probability_missed and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			SMODS.calculate_effect({message = localize('k_upgrade_ex')}, card)
		elseif context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
	end
}

SMODS.Enhancement:take_ownership('glass', 
	{
		calculate = function(self, card, context)
			if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
				if pseudorandom('glass') < G.GAME.probabilities.normal/card.ability.extra then
					return { remove = true }
				else
					local effects
					SMODS.calculate_context({roff_probability_missed = true}, effects)
				end
			end
		end,
	},
	true 
)
