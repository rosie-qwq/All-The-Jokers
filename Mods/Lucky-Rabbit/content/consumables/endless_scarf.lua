SMODS.Consumable {
    key = "endless_scarf",
    set = "Silly",
    config = {
        extra = {
            h_size = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size } }
    end,
    atlas = "Consumables",
    pos = {x = 7, y = 1 },
    cost = 5,
    use = function(self, card, area, copier)
        if #G.hand.cards > 1 then
            G.FUNCS.draw_from_deck_to_hand(card.ability.extra.h_size)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            G.hand:change_size(card.ability.extra.h_size)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.h_size
            card:juice_up(0.3, 0.5)
        return true end }))
        delay(0.4)
    end,
    can_use = function(self, card)
        return true
    end
}