local jokerInfo = {   
    key = "ca_general",
    pos = { x = 5, y = 0 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = {extra = {xmult_per_ace = 0.2, xmult_total = 1}},
    pools = { ['tjr_pool_combat_ace'] = true},
    loc_vars = function(self, info_queue, card)
    local aces_in_deck = 0
    if G.deck then
        for _, deck_card in ipairs(G.deck.cards) do
            if deck_card:get_id() == 14 then
                aces_in_deck = aces_in_deck + 1                    
            end
        end
    end
    card.ability.extra.xmult_total = 1 + (aces_in_deck * card.ability.extra.xmult_per_ace)
        return { vars = { card.ability.extra.xmult_per_ace, card.ability.extra.xmult_total } }
    end,
    calculate = function(self, card, context)      

            if context.joker_main then
                local aces_in_deck = 0
                for _, deck_card in ipairs(G.deck.cards) do
                    if deck_card:get_id() == 14 then
                        aces_in_deck = aces_in_deck + 1                    
                    end
                end
      
                card.ability.extra.xmult_total = 1 + (aces_in_deck * card.ability.extra.xmult_per_ace)

                return {
                    xmult = card.ability.extra.xmult_total
                }
            end
        end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_ca'), G.C.GREEN, G.C.WHITE, 1)
    end
}
return jokerInfo
