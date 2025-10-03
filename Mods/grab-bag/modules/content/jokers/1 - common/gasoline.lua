SMODS.Joker {
	key = 'gasoline',
	loc_txt = {
		name = 'Gasoline',
		text = {
			"Earn {C:money}$#1#{} if played hand",
			"causes score to {C:attention}catch fire{}",
		}
	},
	config = { extra = { dollars = 6 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 3, y = 2 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
    calculate = function(self, card, context)
        if context.final_scoring_step and gb_is_score_on_fire() then
			return {
                dollars = card.ability.extra.dollars
			}
		end
	end
}