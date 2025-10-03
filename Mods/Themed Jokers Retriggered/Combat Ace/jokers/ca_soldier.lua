local jokerInfo = {   
    key = "ca_soldier",
    pos = { x = 0, y = 0 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = { chips = 35 } },  
    pools = { ['tjr_pool_combat_ace'] = true},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 14) then
            return {                
                chips = card.ability.extra.chips,
                }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_ca'), G.C.GREEN, G.C.WHITE, 1)
    end
}
return jokerInfo