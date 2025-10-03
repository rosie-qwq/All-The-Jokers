
SMODS.Joker {
	key = 'jokernia',
	rarity = 1,
	atlas = 'B1999',
	pos = { x = 2, y = 1 },
	cost = 4,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { extra_value = 0, value_gain = 9 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra_value, card.ability.extra.value_gain } }
	end,
    add_to_deck = function (self, card, from_debuff)
    end,
	calculate = function(self, card, context)
        if context.b1999_ante_change and not context.blueprint then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.value_gain
            card:set_cost()
            return {
                message = "^$^"
            }
        end
        end
    }