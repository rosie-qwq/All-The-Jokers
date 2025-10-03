local consumableInfo = {
    key = 'ss_devotion_clubs',
    set = 'Tarot',
    atlas = 'ThemedJokersRetriggered_tarots',
    pos = { x = 3, y = 4 },
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
                
                -- Check if all cards in deck are Clubs
                local all_clubs = true
                if G.playing_cards then
                    for _, playing_card in ipairs(G.playing_cards) do
                        if not playing_card:is_suit("Clubs") then
                            all_clubs = false
                            break
                        end
                    end
                end
                
                -- Check if player has the legendary Clubs joker (Aspect of Balance)
                local has_aspect_balance = false
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.ability.name and string.find(joker.ability.name, 'ss_aspect_balance') then 
                        has_aspect_balance = true 
                        break
                    end
                end
                
                -- If all cards are Clubs and player doesn't have Aspect of Balance, give it
                if all_clubs and not has_aspect_balance then
                    SMODS.add_card({ key = 'j_tjr_ss_aspect_balance' })
                else
                    -- Check if player has all 4 Clubs jokers
                    local has_monk = false
                    local has_monastery = false
                    local has_meditation = false
                    local has_mala = false
                    
                    for _, joker in ipairs(G.jokers.cards) do
                        if joker.ability.name and string.find(joker.ability.name, 'ss_monk_clubs') then has_monk = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_monastery') then has_monastery = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_meditation') then has_meditation = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_mala_clubs') then has_mala = true end
                    end
                    
                    -- If all 4 are present, use normal pool, otherwise use suit-specific pool
                    if has_monk and has_monastery and has_meditation and has_mala then
                        SMODS.add_card({ set = 'tjr_pool_sacred_suits' })
                    else
                        SMODS.add_card({ set = 'tjr_pool_sacred_clubs' })
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
        
        return clubs_count > spades_count and clubs_count > hearts_count and clubs_count > diamonds_count
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_sacred_suits'), G.C.WHITE, G.C.GOLD, 1)
    end
}

return consumableInfo
