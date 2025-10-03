local jokerInfo = {   
    key = "mc_jimbo",
    pos = { x = 5, y = 3 },
    soul_pos = { x = 6, y = 3 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = {extra = {xmult=2, chips_bonus=10, mult_bonus=2, dollar_bonus=1}},
    set_ability = function(self, card, initial)
        card:set_edition("e_negative", true)
    end,
    loc_vars = function(self, info_queue, card)      
        return { vars = { card.ability.extra.xmult, card.ability.extra.chips_bonus, card.ability.extra.mult_bonus, card.ability.extra.dollar_bonus } }
    end,
    in_pool = function(self, args) 
        return false
    end,
    add_to_deck = function(self, card, from_debuff)
        play_sound('tjr_clown_laugh')
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }        
        end

        if context.scoring_hand then
            if context.individual and context.cardarea == G.play then
                local bonuses ={ 'chips', 'mult', 'dollar', 'nothing' }
                local bonus = pseudorandom_element(bonuses, pseudoseed('jimbo'))
                if bonus == 'chips' then
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips_bonus
                elseif bonus == 'mult' then
                    context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                    context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult_bonus
                elseif bonus == 'dollar' then
                    context.other_card.ability.perma_p_dollar = context.other_card.ability.perma_p_dollar or 0
                    context.other_card.ability.perma_p_dollar = context.other_card.ability.perma_p_dollar + card.ability.extra.dollar_bonus
                elseif bonus == 'nothing' then
                    play_sound('tjr_clown_laugh_short')
                end

                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.ATTENTION },
                    card = card
                }
            end
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_badge_mischief'), G.C.PURPLE, G.C.WHITE, 1)
    end
}
return jokerInfo
