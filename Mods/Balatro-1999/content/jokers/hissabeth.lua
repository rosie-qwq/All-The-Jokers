
SMODS.Joker {
	key = 'hissabeth',
	rarity = 3,
	atlas = 'B1999',
	pos = { x = 2, y = 3 },
	cost = 8,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { sibling = 0 } },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS["m_b1999_hiss"]
		return { vars = { card.ability.extra.sibling } }
	end,
	calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            card.ability.extra.sibling = card.ability.extra.sibling + 1
            return {
                message = "Hiss!"
            }
        end
        if context.end_of_round and not context.blueprint then
            card.ability.extra.sibling = 0
        end
    end,
    update = function(self, card, dt)
        if G.STATE == G.STATES.HAND_PLAYED then
        if G.jokers.cards[#G.jokers.cards] == card and card.ability.extra.sibling > 0 then
            SMODS.add_card({set = 'Enhanced', enhancement = 'm_b1999_hiss', area = G.hand })
            card.ability.extra.sibling = card.ability.extra.sibling - 1
        end
    end
    end
    }


SMODS.Enhancement {
	key = 'hiss',
	atlas = 'enhance',
	pos = { x = 0, y = 0 },
	config = { bonus = 50 },
    yes_pool_flag = "I like how I can just write random shit here!",
	replace_base_card = true,
	no_collection = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.bonus } }
	end,
	update = function(self, card, dt)
        local versatile = false
        for _, ver_card in ipairs(card.area.highlighted) do
            if ver_card == card then
                versatile = true
                break
            end
        end
        if versatile and card.area == G.hand and not card.debuff then
            versatileIncrease(1)
        end
    end,
	calculate = function(self, card, context)
        if context.end_of_round then
            card:remove()
        end
    end
    }