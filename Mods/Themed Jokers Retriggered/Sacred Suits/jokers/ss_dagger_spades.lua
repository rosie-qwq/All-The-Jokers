local jokerInfo = {   
    key = "ss_dagger_spades",
    pos = { x = 10, y = 4 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { ['tjr_pool_sacred_suits'] = true, ['tjr_pool_sacred_spades'] = true},
    config = {extra = {chips_per_scored = 20, chips_per_held = 20}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_per_scored, card.ability.extra.chips_per_held } }
    end,

    calculate = function(self, card, context)
        -- For scored Spades (when they're played)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Spades") then
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips_per_scored
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
                    card = card
                }
            end
        end
        
        -- For held Spades (at end of round)
        if context.joker_main then
            for _, hand_card in ipairs(G.hand.cards) do
                if hand_card:is_suit("Spades") then
                    hand_card.ability.perma_bonus = hand_card.ability.perma_bonus or 0
                    hand_card.ability.perma_bonus = hand_card.ability.perma_bonus + card.ability.extra.chips_per_held
                end
            end
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_sacred_suits'), G.C.WHITE, G.C.GOLD, 1)
    end
}
return jokerInfo
