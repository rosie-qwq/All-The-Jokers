local jokerInfo = {   
    key = "ss_aspect_passion",
    pos = { x = 2, y = 5 },
    soul_pos = { x = 3, y = 5 },
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
            -- Add 2 retriggers for all Hearts cards
            if context.other_card:is_suit("Hearts") then
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
