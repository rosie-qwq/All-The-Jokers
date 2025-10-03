SMODS.Joker {
	key = 'receipt',
	loc_txt = {
		name = 'Receipt',
		text = {
			"This Joker gains {C:chips}+#1#{} Chips",
			"for every card purchased",
			"in the shop",
			"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
		}
	},
	config = { extra = { chips = 0, chips_mod = 5 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 1, y = 2 },
	cost = 4,
	blueprint_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips_mod, card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.buying_card and context.card ~= card then
			SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_mod",
                message_colour = G.C.CHIPS
            })
		end
        if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
	end
}
