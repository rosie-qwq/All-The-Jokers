local jokerInfo = {   
    key = "ss_bone_temple",
    pos = { x = 6, y = 4 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { ['tjr_pool_sacred_suits'] = true, ['tjr_pool_sacred_spades'] = true},
    config = {extra = {xmult_per_spade = 0.1, xmult_total = 1}},
    loc_vars = function(self, info_queue, card)
        local spades_in_deck = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit("Spades") then
                    spades_in_deck = spades_in_deck + 1                    
                end
            end
        end
        card.ability.extra.xmult_total = 1 + (spades_in_deck * card.ability.extra.xmult_per_spade)
        return { vars = { card.ability.extra.xmult_per_spade, card.ability.extra.xmult_total } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands["Flush"]) then
            local pure=true
            for _, played_card in ipairs(context.scoring_hand) do
                if not played_card:is_suit("Spades") then
                    pure=false
                    break
                end
            end
            if pure then
                local spades_in_deck = 0
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:is_suit("Spades") then
                        spades_in_deck = spades_in_deck + 1                    
                    end
                end
                card.ability.extra.xmult_total = 1 + (spades_in_deck * card.ability.extra.xmult_per_spade)
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
