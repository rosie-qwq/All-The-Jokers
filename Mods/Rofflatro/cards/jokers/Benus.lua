-- Benus ($3 Common)
-- Earn $3 if played hand contains Three of a Kind
-- Lose $2 if hand doesn't contain Three of a Kind

SMODS.Joker{
    key = 'benus',
    atlas = 'roffers',
    rarity = 1,
    cost = 3,
    pos = { x = 3, y = 1 },
    blueprint_compat = true,
    config = { extra = { dollars = 3, dollars_decrease = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.dollars, card.ability.extra.dollars_decrease}}
    end,
    calculate = function(self, card, context)
        if context.before then
                if next(context.poker_hands['Three of a Kind']) then
                    return { dollars = card.ability.extra.dollars }
                else
                    return { dollars = -card.ability.extra.dollars_decrease } 
                end
            end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
        badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
    end
}
