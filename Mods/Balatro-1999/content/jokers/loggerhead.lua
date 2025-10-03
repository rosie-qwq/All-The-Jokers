SMODS.Joker {
    key = "loggerhead",
    blueprint_compat = true,
    eternal_compat = true,
	perishable_compat = true,
    rarity = 2,
    atlas = 'B1999',
    cost = 5,
    config = { extra = { retriggers = 1 } },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.retriggers } }
	end,
    pos = { x = 3, y = 1 },
    calculate = function(self, card, context)
        for i=1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                local my_pos = i
                    if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == G.jokers.cards[my_pos + 1] and G.STATE ~= G.STATES.HAND_PLAYED then
                        return {
                            repetitions = card.ability.extra.retriggers,
                        }
                    end
                end
    end
end
}