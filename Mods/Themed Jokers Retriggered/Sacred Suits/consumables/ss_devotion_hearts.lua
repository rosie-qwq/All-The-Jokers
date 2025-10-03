local consumableInfo = {
    key = 'ss_devotion_hearts',
    set = 'Tarot',
    atlas = 'ThemedJokersRetriggered_tarots',
    pos = { x = 1, y = 4 },
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
                
                -- Check if all cards in deck are Hearts
                local all_hearts = true
                if G.playing_cards then
                    for _, playing_card in ipairs(G.playing_cards) do
                        if not playing_card:is_suit("Hearts") then
                            all_hearts = false
                            break
                        end
                    end
                end
                
                -- Check if player has the legendary Hearts joker (Aspect of Passion)
                local has_aspect_passion = false
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.ability.name and string.find(joker.ability.name, 'ss_aspect_passion') then 
                        has_aspect_passion = true 
                        break
                    end
                end
                
                -- If all cards are Hearts and player doesn't have Aspect of Passion, give it
                if all_hearts and not has_aspect_passion then
                    SMODS.add_card({ key = 'j_tjr_ss_aspect_passion' })
                else
                    -- Check if player has all 4 Hearts jokers
                    local has_priest = false
                    local has_cathedral = false
                    local has_crimson_rite = false
                    local has_rosary = false
                    
                    for _, joker in ipairs(G.jokers.cards) do
                        if joker.ability.name and string.find(joker.ability.name, 'ss_priest_hearts') then has_priest = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_cathedral') then has_cathedral = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_crimson_rite') then has_crimson_rite = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_rosary_hearts') then has_rosary = true end
                    end
                    
                    -- If all 4 are present, use normal pool, otherwise use suit-specific pool
                    if has_priest and has_cathedral and has_crimson_rite and has_rosary then
                        SMODS.add_card({ set = 'tjr_pool_sacred_suits' })
                    else
                        SMODS.add_card({ set = 'tjr_pool_sacred_hearts' })
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
        
        return hearts_count > spades_count and hearts_count > clubs_count and hearts_count > diamonds_count
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_sacred_suits'), G.C.WHITE, G.C.GOLD, 1)
    end
}

return consumableInfo
