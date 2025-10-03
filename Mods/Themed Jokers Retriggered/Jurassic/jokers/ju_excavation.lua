local jokerInfo = {   
    key = "ju_excavation",
    pos = { x = 10, y = 1 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = {},
    pools = { ['tjr_pool_jurassic'] = true},
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return { vars = {} }
    end,
    calculate = function(self, card, context)      
     
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.before and context.main_eval and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            local has_stone_cards = false
            for _, playing_card in ipairs(context.full_hand) do
                if SMODS.has_enhancement(playing_card, 'm_stone') then
                    has_stone_cards = true
                    break
                end
            end
            if not has_stone_cards then
                for _, playing_card in ipairs(context.full_hand) do
                    playing_card:set_ability('m_stone', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            playing_card:juice_up()
                            return true
                        end
                    }))
                end
                                 return {
                     message = "Excavation complete!"
                 }
             end
         end
     end,
     set_badges = function(self, card, badges)
         badges[#badges+1] = create_badge(localize('k_badge_jurassic'), G.C.GREEN, G.C.WHITE, 1)
     end
 }
 return jokerInfo
