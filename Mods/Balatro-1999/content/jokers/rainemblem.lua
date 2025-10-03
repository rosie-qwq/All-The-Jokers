SMODS.Joker {
	key = 're',
	rarity = 3,
	atlas = 'B1999',
	pos = { x = 5, y = 1 },
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { x_mult = 4, rain = nil, swap = false } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult, card.ability.extra.rain, card.ability.extra.swap } }
	end,
	calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind:get_type() == 'Boss' and card.ability.extra.swap == false and not context.blueprint then
            card.ability.extra.rain = G.GAME.round_resets.blind_choices.Boss
            card.ability.extra.swap = true
        end
        if context.ending_shop and card.ability.extra.swap == true and not context.blueprint then
            G.GAME.round_resets.blind_choices.Big = card.ability.extra.rain
            G.GAME.round_resets.blind_choices.Boss = card.ability.extra.rain
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
end
}