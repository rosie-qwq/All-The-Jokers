local consumableInfo = {
    key = 'in_blight',
    set = 'Tarot',
    atlas = 'ThemedJokersRetriggered_tarots',
    pos = { x = 0, y = 2 },
    unlocked = true,
    discovered = true,
    config = {},   
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,    
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'tjr_pool_infected' })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
        
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_infected'), G.C.GREEN, G.C.WHITE, 1)
    end
}

return consumableInfo