local consumableInfo = {
    key = 'in_miasma',
    set = 'Spectral',
    atlas = 'ThemedJokersRetriggered_spectrals',
    pos = { x = 0, y = 2 },
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,    
    use = function(self, card, area, copier)
        if G.playing_cards then
            for i=1, 5 do
            TJR.funcs.SpreadInfection(card, TJR.contaigon)
            end
        end
    end,
        
    can_use = function(self, card)
       if G.playing_cards then
        return true
       end
       return false
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_infected'), G.C.GREEN, G.C.WHITE, 1)
    end
}

return consumableInfo