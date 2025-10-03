SMODS.Consumable {
    key = "juggler",
    set = "Silly",
    config = {
        extra = {
            dollars = 10,
            increase = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars + ((G.GAME.juggler_count or 0) * card.ability.extra.increase), card.ability.extra.increase } }
    end,
    atlas = "Consumables",
    pos = {x = 6, y = 0 },
    cost = 5,
    use = function(self, card, context, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            card:juice_up(0.3, 0.5)
            ease_dollars((card.ability.extra.dollars + (G.GAME.juggler_count * card.ability.extra.increase)), true)
            G.GAME.juggler_count = (G.GAME.juggler_count or 0) + 1
            return true end }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}