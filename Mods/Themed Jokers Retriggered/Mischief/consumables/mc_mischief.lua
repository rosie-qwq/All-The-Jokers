local consumableInfo = {
    key = 'mc_mischief',
    set = 'Tarot',
    atlas = 'ThemedJokersRetriggered_tarots',
    pos = { x = 0, y = 3 },
    unlocked = true,
    discovered = true,
    config = {},
    in_pool = function(self, args)
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,    
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'tjr_pool_mischief' })
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
        badges[#badges+1] = create_badge(localize('k_badge_mischief'), G.C.PURPLE, G.C.WHITE, 1)
    end
}

return consumableInfo
