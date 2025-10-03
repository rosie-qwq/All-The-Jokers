local jokerInfo = {   
    key = "in_joker",
    pos = { x = 2, y = 2 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { ['tjr_pool_infected'] = true},
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            TJR.funcs.SpreadInfection(card, TJR.contaigon)
            return {message=localize('k_infected_spread'), colour=G.C.GREEN, card=card}
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_infected'), G.C.GREEN, G.C.WHITE, 1)
    end
}
return jokerInfo