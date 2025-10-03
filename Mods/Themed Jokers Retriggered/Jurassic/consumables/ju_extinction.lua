local consumableInfo = {
    key = 'ju_extinction',
    set = 'Spectral',
    atlas = 'ThemedJokersRetriggered_spectrals',
    pos = { x = 0, y = 1 },
    unlocked = true,
    discovered = true,
    config = {},
    in_pool = function(self, args)
        if G.jokers then
            for _, joker in ipairs(G.jokers.cards or {}) do
                if joker.ability.name and (string.find(joker.ability.name, 'ju_brachiosaurus') or string.find(joker.ability.name, 'ju_trex') or string.find(joker.ability.name, 'ju_mosasaurus') or string.find(joker.ability.name, 'ju_quetzalcoatlus')) then
                    return true
                end
            end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,    
    use = function(self, card, area, copier)
        local dinosaur = G.jokers.highlighted[1]
        if dinosaur.ability.name and string.find(dinosaur.ability.name, 'ju_trex') then
            G.GAME.pool_flags.tjr_rex_extinct = true
            SMODS.destroy_cards(dinosaur)
            SMODS.add_card({ key = "j_tjr_ju_fossil_rex" })
            card:juice_up(0.3, 0.5)
            play_sound('tarot1')
        elseif dinosaur.ability.name and string.find(dinosaur.ability.name, 'ju_quetzalcoatlus') then
            G.GAME.pool_flags.tjr_quetz_extinct = true
            SMODS.destroy_cards(dinosaur)
            SMODS.add_card({ key = "j_tjr_ju_fossil_quetz" })
            card:juice_up(0.3, 0.5)
            play_sound('tarot1')
        elseif dinosaur.ability.name and string.find(dinosaur.ability.name, 'ju_mosasaurus') then
            G.GAME.pool_flags.tjr_mosa_extinct = true
            SMODS.destroy_cards(dinosaur)
            SMODS.add_card({ key = "j_tjr_ju_fossil_mosa" })
            card:juice_up(0.3, 0.5)
            play_sound('tarot1')
        elseif dinosaur.ability.name and string.find(dinosaur.ability.name, 'ju_brachiosaurus') then
            G.GAME.pool_flags.tjr_brachio_extinct = true
            SMODS.destroy_cards(dinosaur)
            SMODS.add_card({ key = "j_tjr_ju_fossil_brachio" })
            card:juice_up(0.3, 0.5)
            play_sound('tarot1')
        end
    end,
        
    can_use = function(self, card)
        if G.jokers then
            if #G.jokers.highlighted == 1 and G.jokers.highlighted[1].ability.name and (string.find(G.jokers.highlighted[1].ability.name, 'ju_brachiosaurus') or string.find(G.jokers.highlighted[1].ability.name, 'ju_trex') or string.find(G.jokers.highlighted[1].ability.name, 'ju_mosasaurus') or string.find(G.jokers.highlighted[1].ability.name, 'ju_quetzalcoatlus')) then
                return true
            end
        end
        return false
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_jurassic'), G.C.GREEN, G.C.WHITE, 1)
    end
}

return consumableInfo
