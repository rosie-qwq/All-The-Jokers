local consumableInfo = {
    key = 'ss_devotion_diamonds',
    set = 'Tarot',
    atlas = 'ThemedJokersRetriggered_tarots',
    pos = { x = 0, y = 4 },
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
                
                -- Check if all cards in deck are Diamonds
                local all_diamonds = true
                if G.playing_cards then
                    for _, playing_card in ipairs(G.playing_cards) do
                        if not playing_card:is_suit("Diamonds") then
                            all_diamonds = false
                            break
                        end
                    end
                end
                
                -- Check if player has the legendary Diamonds joker (Aspect of Growth)
                local has_aspect_growth = false
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.ability.name and string.find(joker.ability.name, 'ss_aspect_growth') then 
                        has_aspect_growth = true 
                        break
                    end
                end
                
                -- If all cards are Diamonds and player doesn't have Aspect of Growth, give it
                if all_diamonds and not has_aspect_growth then
                    SMODS.add_card({ key = 'j_tjr_ss_aspect_growth' })
                else
                    -- Check if player has all 4 Diamonds jokers
                    local has_druid = false
                    local has_stone_circle = false
                    local has_ritual = false
                    local has_staff = false
                    
                    for _, joker in ipairs(G.jokers.cards) do
                        if joker.ability.name and string.find(joker.ability.name, 'ss_druid_diamonds') then has_druid = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_stone_circle') then has_stone_circle = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_ritual') then has_ritual = true end
                        if joker.ability.name and string.find(joker.ability.name, 'ss_staff_diamonds') then has_staff = true end
                    end
                    
                    -- If all 4 are present, use normal pool, otherwise use suit-specific pool
                    if has_druid and has_stone_circle and has_ritual and has_staff then
                        SMODS.add_card({ set = 'tjr_pool_sacred_suits' })
                    else
                        SMODS.add_card({ set = 'tjr_pool_sacred_diamonds' })
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
        
        return diamonds_count > spades_count and diamonds_count > hearts_count and diamonds_count > clubs_count
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_sacred_suits'), G.C.WHITE, G.C.GOLD, 1)
    end
}

return consumableInfo
