local jokerInfo = {   
    key = "ss_stone_circle",
    pos = { x = 4, y = 4 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { ['tjr_pool_sacred_suits'] = true, ['tjr_pool_sacred_diamonds'] = true},
    config = {extra = {xmult_per_diamond = 0.1, xmult_total = 1}},
    loc_vars = function(self, info_queue, card)
        local diamonds_in_deck = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit("Diamonds") then
                    diamonds_in_deck = diamonds_in_deck + 1                    
                end
            end
        end
        card.ability.extra.xmult_total = 1 + (diamonds_in_deck * card.ability.extra.xmult_per_diamond)
        return { vars = { card.ability.extra.xmult_per_diamond, card.ability.extra.xmult_total } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands["Flush"]) then
            local pure=true
            for _, played_card in ipairs(context.scoring_hand) do
                if not played_card:is_suit("Diamonds") then
                    pure=false
                    break
                end
            end
            if pure then
                local diamonds_in_deck = 0
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:is_suit("Diamonds") then
                        diamonds_in_deck = diamonds_in_deck + 1                    
                    end
                end
                card.ability.extra.xmult_total = 1 + (diamonds_in_deck * card.ability.extra.xmult_per_diamond)
                return {
                    xmult = card.ability.extra.xmult_total
                }
            end            
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_sacred_suits'), G.C.WHITE, G.C.GOLD, 1)
    end
}
return jokerInfo
