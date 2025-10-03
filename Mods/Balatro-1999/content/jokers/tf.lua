

SMODS.Joker {
	key = 'tf',
	rarity = 2,
	atlas = 'B1999',
	pos = { x = 4, y = 1 },
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { teeth = 0, t_word = "Teeth" } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "b1999_tooth_seal", set = 'Other' }
		info_queue[#info_queue + 1] = { key = "deja", set = 'Other' }
		return { vars = { card.ability.extra.teeth, card.ability.extra.t_word } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.teeth < 3 and not context.blueprint then
			card.ability.extra.teeth = card.ability.extra.teeth + 1
		end
        if card.ability.extra.teeth == 1 and not context.blueprint then
        	card.ability.extra.t_word = "Tooth"
        end
		if card.ability.extra.teeth > 1 and not context.blueprint then
        	card.ability.extra.t_word = "Teeth"
		end
		if context.before and card.ability.extra.teeth >= 3 and #context.full_hand == 1 and not context.blueprint then
			G.play.cards[1]:set_seal("b1999_tooth")
			card.ability.extra.teeth = 0
		end
		if card.ability.extra.teeth >= 3 and not context.blueprint then
            local eval = function() return G.STATE == G.STATES.SELECTING_HAND and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
	end
}

SMODS.Seal {
	key = 'tooth',
	atlas = 'seal',
	yes_pool_flag = 'nope',
	badge_colour = HEX('FFFDB5'),
	pos = { x = 0, y = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			return {
				xmult = 1.5
			}
		end
	end
}
