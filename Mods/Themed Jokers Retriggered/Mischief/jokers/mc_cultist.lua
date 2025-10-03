local jokerInfo = {   
    key = "mc_cultist",
    pos = { x = 4, y = 3 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { 
       ['tjr_pool_mischief'] = true, 
    },
    config = {extra = {xmult_per_piece = 0.5}},
    loc_vars = function(self, info_queue, card)      
        return { vars = { card.ability.extra.xmult_per_piece, 1 + ((G.GAME.pool_flags.tjr_mischief_pieces or 0) * card.ability.extra.xmult_per_piece)} }
    end,
    in_pool = function(self, args) 
        return G.GAME.pool_flags.tjr_mischief_pieces
    end,  
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = 1 + ((G.GAME.pool_flags.tjr_mischief_pieces or 0) * card.ability.extra.xmult_per_piece)
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_mischief'), G.C.PURPLE, G.C.WHITE, 1)
    end
}
return jokerInfo
