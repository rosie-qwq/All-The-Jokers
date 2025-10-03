local jokerInfo = {   
    key = "in_corruptedjoker",
    pos = { x = 6, y = 2 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { ['tjr_pool_infected'] = true},
    config = { extra = { mult = 3 } },
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_tjr_infected') then
                return true
            end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        SMODS.has_enhancement(context.other_card, 'm_tjr_infected') then
        return {
            mult = card.ability.extra.mult
        }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_infected'), G.C.GREEN, G.C.WHITE, 1)
    end
}
return jokerInfo
