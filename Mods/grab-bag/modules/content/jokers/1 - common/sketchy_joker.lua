SMODS.Joker {
	key = 'sketchy_joker',
	loc_txt = {
		name = 'Sketchy Joker',
		text = {
            "This Joker gains {C:chips}+#1#{} Chips",
            "for every {C:attention}#4#{} cards drawn",
            "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips) (#3#/#4#)",
		}
	},
	config = { extra = { chips = 0, chips_mod = 3, draw_tally = 0, draws = 7 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 3, y = 3 },
	cost = 4,
	blueprint_compat = true,
	perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_mod, card.ability.extra.chips, card.ability.extra.draw_tally, card.ability.extra.draws } }
	end,
	calculate = function(self, card, context)
		if context.hand_drawn
		or context.other_drawn
		and not context.blueprint then
			for _, playing_card in ipairs(context.hand_drawn or context.other_drawn) do
				card.ability.extra.draw_tally = card.ability.extra.draw_tally + 1
				if card.ability.extra.draw_tally >= card.ability.extra.draws then
					SMODS.scale_card(card, {
                		ref_table = card.ability.extra,
                		ref_value = "chips",
                		scalar_value = "chips_mod",
                		message_colour = G.C.CHIPS
            		})
					card.ability.extra.draw_tally = card.ability.extra.draw_tally - card.ability.extra.draws
				end
			end
		end
		if context.joker_main then 
			return {
				chips = card.ability.extra.chips
			}
		end
	end
}