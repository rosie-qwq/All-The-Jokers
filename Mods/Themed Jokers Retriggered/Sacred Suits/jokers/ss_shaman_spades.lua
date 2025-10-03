local jokerInfo = {   
    key = "ss_shaman_spades",
    pos = { x = 2, y = 4 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { ['tjr_pool_sacred_suits'] = true, ['tjr_pool_sacred_spades'] = true},
    config = {extra = {suit = "Spades", odds = 4}},
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'tjr_wololo' .. G.GAME.round_resets.ante)
        return { vars = { card.ability.extra.suit ,numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then            
                local converted=false
                for _, played_card in ipairs(context.scoring_hand) do
                    if SMODS.pseudorandom_probability(card, 'tjr_wololo' .. G.GAME.round_resets.ante, 1, card.ability.extra.odds) then                
                    if not played_card:is_suit(card.ability.extra.suit) then                        
                        G.E_MANAGER:add_event(Event({
                            delay = 0.4,
                            trigger = 'after', 
                            func = function()
                                if not converted then
                                    play_sound('tjr_wololo')
                                    converted=true
                                end
                                SMODS.change_base(played_card,card.ability.extra.suit)
                                played_card:juice_up(0.3, 0.4)
                                return true                            
                            end
                        }))
                    end
                end            
            end
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_sacred_suits'), G.C.WHITE, G.C.GOLD, 1)
    end
}
return jokerInfo
