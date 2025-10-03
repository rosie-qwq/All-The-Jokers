SMODS.Joker{
	key = 'getchips',
	atlas = 'roffers',
	rarity = 3,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 1, y = 7 },
	soul_pos = { x = 0, y = 7 },
	config = { extra = { active = false }},
	loc_vars = function(self,info_queue,card)
		return {vars = {}}
	end,
	calculate = function(self,card,context)

		if context.setting_blind then
			card.ability.extra.active = true
		end
		if context.end_of_round then
			card.ability.extra.active = false -- make sure we're only checking for scoring jokers
		end
	
		if card.ability.extra.active then
			for _, j in ipairs(G.jokers.cards) do
				if j.ability.name ~= 'Blueprint' and j.ability.name ~= 'Brainstorm' and j.ability.blueprint_compat then -- bp effects create infinite feedback loops if we try copy them...
					context.blueprint = nil
					local ret = SMODS.blueprint_effect(card, j, context)
					if ret then
						-- print(inspect(ret))
						local chip_effect = ret.chips or ret.chip_mod
						if chip_effect then
							return {
								chips = chip_effect
							}
						end
					end
				end
			end
		end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
	end
}
