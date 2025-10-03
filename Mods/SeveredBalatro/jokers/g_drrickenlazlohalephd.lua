SMODS.Joker {
	key = "drrickenlazlohalephd",
	config = {
		extra = {
			odds = 4,
			chips = 30,
			mult = 0.15,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.chips,
			card.ability.extra.mult,
		}}
	end,
	rarity = 1,
	atlas = "svrd_atlas",
	pos = { x = 5, y = 1 },
	cost = 4,
	-- unlocked = true,
	-- discovered = true,
	calculate = function(self, card, context)
		if context.individual
			and context.cardarea == G.play
			and not context.other_card.debuff
		then
			if CheckOdds("drrickenlazlohalephd", card.ability.extra.odds, G.GAME.probabilities.normal) then
				return {
					mult = -card.ability.extra.mult,
					message_card = context.other_card,
				}
			else
				return {
					chips = card.ability.extra.chips,
					message_card = context.other_card,
				}
			end
		end
	end
}
