local jokerInfo = {   
    key = "ss_aspect_silence",
    pos = { x = 4, y = 5 },
    soul_pos = { x = 5, y = 5 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 4,
    cost = 15,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = {extra = {repetitions = 2}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card then
            -- Add 2 retriggers for all Spades cards
            if context.other_card:is_suit("Spades") then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_sacred_suits'), G.C.WHITE, G.C.GOLD, 1)
    end
}
return jokerInfo
