SMODS.Joker {
	key = 'mradio',
	rarity = 1,
	atlas = 'B1999',
	pos = { x = 0, y = 2 },
	cost = 3,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	config = { extra = { chip_procent = 25 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chip_procent } }
	end,
	calculate = function(self, card, context)
		if context.selling_self then
            G.GAME.blind.chips = G.GAME.blind.chips - (G.GAME.blind.chips * (card.ability.extra.chip_procent / 100))
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
	end
}

