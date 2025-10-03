local consumableInfo = {
    key = 'ss_vessel',
    set = 'Spectral',
    atlas = 'ThemedJokersRetriggered_spectrals',
    pos = { x = 0, y = 4 },
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        -- Count cards by suit to determine current target
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
        
        -- Determine the most common suit with tie-breaking priority: diamonds > hearts > spades > clubs
        local target_suit = "Clubs" -- Default fallback
        local max_count = clubs_count
        
        if spades_count > max_count then
            target_suit = "Spades"
            max_count = spades_count
        elseif spades_count == max_count and target_suit == "Clubs" then
            target_suit = "Spades" -- Spades beats Clubs in tie
        end
        
        if hearts_count > max_count then
            target_suit = "Hearts"
            max_count = hearts_count
        elseif hearts_count == max_count and (target_suit == "Clubs" or target_suit == "Spades") then
            target_suit = "Hearts" -- Hearts beats Clubs and Spades in tie
        end
        
        if diamonds_count > max_count then
            target_suit = "Diamonds"
            max_count = diamonds_count
        elseif diamonds_count == max_count then
            target_suit = "Diamonds" -- Diamonds beats all in tie
        end
        
        return { vars = { target_suit } }
    end,    
    use = function(self, card, area, copier)
        if G.playing_cards then
            -- Count cards by suit
            local spades_count = 0
            local hearts_count = 0
            local clubs_count = 0
            local diamonds_count = 0
            
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
            
            -- Determine the most common suit with tie-breaking priority: diamonds > hearts > spades > clubs
            local target_suit = "Clubs" -- Default fallback
            local max_count = clubs_count
            
            if spades_count > max_count then
                target_suit = "Spades"
                max_count = spades_count
            elseif spades_count == max_count and target_suit == "Clubs" then
                target_suit = "Spades" -- Spades beats Clubs in tie
            end
            
            if hearts_count > max_count then
                target_suit = "Hearts"
                max_count = hearts_count
            elseif hearts_count == max_count and (target_suit == "Clubs" or target_suit == "Spades") then
                target_suit = "Hearts" -- Hearts beats Clubs and Spades in tie
            end
            
            if diamonds_count > max_count then
                target_suit = "Diamonds"
                max_count = diamonds_count
            elseif diamonds_count == max_count then
                target_suit = "Diamonds" -- Diamonds beats all in tie
            end
            
            -- Convert 5 random cards to the target suit
            local non_target_cards = {}
            for _, deck_card in ipairs(G.playing_cards) do
                if not deck_card:is_suit(target_suit) then
                    table.insert(non_target_cards, deck_card)
                end
            end
            
            for i = 1, 5 do
                if #non_target_cards > 0 then
                    local _card = pseudorandom_element(non_target_cards, pseudoseed('vessel_' .. i))
                    if _card then
                        SMODS.change_base(_card,target_suit)
                        -- Remove the converted card from the list to avoid duplicates
                        for j = #non_target_cards, 1, -1 do
                            if non_target_cards[j] == _card then
                                table.remove(non_target_cards, j)
                                break
                            end
                        end
                    end
                end
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
        badges[#badges+1] = create_badge(localize('k_badge_sacred_suits'), G.C.WHITE, G.C.GOLD, 1)
    end
}

return consumableInfo
