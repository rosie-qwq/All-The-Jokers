local consumableInfo = {
    key = 'ss_devotion_spades',
    set = 'Tarot',
    atlas = 'ThemedJokersRetriggered_tarots',
    pos = { x = 2, y = 4 },
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
                
                -- Check if all cards in deck are Spades
                local all_spades = true
                if G.playing_cards then
                    for _, playing_card in ipairs(G.playing_cards) do
                        if not playing_card:is_suit("Spades") then
                            all_spades = false
                            break
                        end
                    end
                end
                
                -- Check if player has the legendary Spades joker (Aspect of Silence)
                local has_aspect_silence = false
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.ability.name and string.find(joker.ability.name, 'ss_aspect_silence') then 
                        has_aspect_silence = true 
                        break
                    end
                end
                
                -- If all cards are Spades and player doesn't have Aspect of Silence, give it
                if all_spades and not has_aspect_silence then
                    SMODS.add_card({ key = 'j_tjr_ss_aspect_silence' })
                else
                    -- Check if player has all 4 Spades jokers
                    local has_shaman = false
                    local has_bone_temple = false
                    local has_sacrifice = false
                    local has_dagger = false
                    
                    for _, joker in ipairs(G.jokers.cards) do
                        if joker.ability.name and string.find(joker.ability.name, 'ss_shaman_spades') then has_shaman = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_bone_temple') then has_bone_temple = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_sacrifice') then has_sacrifice = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_dagger_spades') then has_dagger = true end
                    end
                    
                    -- If all 4 are present, use normal pool, otherwise use suit-specific pool
                    if has_shaman and has_bone_temple and has_sacrifice and has_dagger then
                        SMODS.add_card({ set = 'tjr_pool_sacred_suits' })
                    else
                        SMODS.add_card({ set = 'tjr_pool_sacred_spades' })
                    end
                end
                
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
        
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    in_pool = function(self, card)
        local spades_count = 0
        local hearts_count = 0
        local clubs_count = 0
        local diamonds_count = 0
        
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit("Spades") then
                    spades_count = spades_count + 1
                elseif playing_card:is_suit("Hearts") then
                    hearts_count = hearts_count + 1
                elseif playing_card:is_suit("Clubs") then
                    clubs_count = clubs_count + 1
                elseif playing_card:is_suit("Diamonds") then
                    diamonds_count = diamonds_count + 1
                end
            end
        end
        
        return spades_count > hearts_count and spades_count > clubs_count and spades_count > diamonds_count
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_sacred_suits'), G.C.WHITE, G.C.GOLD, 1)
    end
}

return consumableInfo
