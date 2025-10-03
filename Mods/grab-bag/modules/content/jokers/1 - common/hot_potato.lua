SMODS.Joker {
	key = 'hot_potato',
	loc_txt = {
		name = 'Hot Potato',
		text = {
			"When {C:attention}Blind{} is skipped,",
			"this Joker gains {C:mult}+#2#{} Mult",
			"{C:green}#3# in #4# chance{} to {C:red}self-destruct{}",
			"at end of round",
			"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
		}
	},
	config = { extra = { odds = 8, mult = 0, mult_mod = 12 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 7, y = 2 },
	cost = 4,
	blueprint_compat = true,
    eternal_compat = false,
	loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod, new_numerator, new_denominator } }
	end,
	calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'gb_hot_potato', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = 'Cooked!'
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
        if context.skip_blind and not context.blueprint then
			SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "mult_mod",
                message_colour = G.C.MULT
            })
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
			}
        end
	end
}