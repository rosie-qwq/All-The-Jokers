SMODS.Consumable {
    key = "balloons",
    set = "Silly",
    config = {
        extra = {
            mult = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    atlas = "Consumables",
    pos = { x = 7, y = 0 },
    cost = 5,
    use = function(self, card, context, copier)
        
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            delay(0.3)
            for i = 1, #G.hand.cards do
                local hand_card = G.hand.cards[i]
                hand_card:juice_up(0.3,0.5)
                hand_card.ability.perma_bonus = (hand_card.ability.perma_bonus or 0) + hand_card:get_chip_bonus()
                delay(0.1)
            end
            play_sound('timpani')
            return true end }))
    end,
    can_use = function(self, card)
        if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.SMODS_BOOSTER_OPENED then
            return true
        end
    end
}