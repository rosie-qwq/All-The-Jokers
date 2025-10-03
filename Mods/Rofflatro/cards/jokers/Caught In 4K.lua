-- Caught In 4K ($4 Common)
-- +100 Chips for each retrigger on first scored face card 

SMODS.Joker{
    key = '4k',
    atlas = 'roffers',
    rarity = 1,
    cost = 4,
    pos = { x = 5, y = 1 },
    blueprint_compat = true,
    config = { extra = { chips = 70, score_buffer = 1 } },
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.chips}}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            local first_face
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() then first_face = context.scoring_hand[i]; break end -- copied code from photograph
            end
            if context.other_card == first_face then
                if card.ability.extra.score_buffer > 0 and not context.blueprint then
                    card.ability.extra.score_buffer = card.ability.extra.score_buffer - 1
                else
                    return {
                        chips = card.ability.extra.chips
                    }
                end
            end
        elseif context.joker_main then
            card.ability.extra.score_buffer = 1
        end
    end,
    set_badges = function (self, card, badges)
        badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
        badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
    end
}
