SMODS.Joker {
	key = 'cyn',
	rarity = 3,
	atlas = 'B1999',
	pos = { x = 1, y = 2 },
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = { extra = { maniac = true, change = false, x_mult = 1, x_mult_gain = 0.25 } },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "cyn", set = 'Other' }
		return { vars = { card.ability.extra.maniac, card.ability.extra.change, card.ability.extra.x_mult, card.ability.extra.x_mult_gain } }
	end,
	calculate = function(self, card, context)
            if G.jokers.cards[1] == card and context.setting_blind then
                card.children.center:set_sprite_pos({x = 1, y = 2 })
                card.ability.extra.maniac = true
                card.ability.extra.change = false
                return {
                message = "Maniac"
                }
	        end
            if G.jokers.cards[#G.jokers.cards] == card and context.setting_blind then
                card.children.center:set_sprite_pos({x = 2, y = 2 })
                card.ability.extra.maniac = false
                card.ability.extra.change = true
                return {
                message = "Changeling"
                }
            end
            if card.ability.extra.maniac == true then
                if context.first_hand_drawn then
                local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
                end
                if context.discard and not context.blueprint and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
                    return {
                    remove = true
                    }
                end
            end
            if card.ability.extra.change == true and context.joker_main and card.ability.extra.x_mult > 1 then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
}