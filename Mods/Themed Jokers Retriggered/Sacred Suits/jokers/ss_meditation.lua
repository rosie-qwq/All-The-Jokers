local jokerInfo = {   
    key = "ss_meditation",
    pos = { x = 14, y = 4 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { ['tjr_pool_sacred_suits'] = true, ['tjr_pool_sacred_clubs'] = true},
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        -- Empty for now
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_sacred_suits'), G.C.WHITE, G.C.GOLD, 1)
    end
}
return jokerInfo
