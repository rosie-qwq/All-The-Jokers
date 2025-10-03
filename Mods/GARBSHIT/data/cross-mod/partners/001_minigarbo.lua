if not Partner_API then return false else return
{
    Partner_API.Partner{
    key = "minigarbo",
    name = "Mini Garb",
    unlocked = true,
    discovered = true,
    individual_quips = true,
    pos = {x = 0, y = 0},
    soul_pos =  {x = 1, y = 0},
    loc_txt = {},
    atlas = "GarbPartner",
    config = {extra = {related_card = "j_garb_garb777", money = 5, benefits = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.money*card.ability.extra.benefits} }
    end,
    update = function(self, card)
        card.ability.extra.benefits = next(SMODS.find_card(card.ability.extra.related_card)) and 2 or 1
    end,
    calculate = function(self, card, context)
        if context.individual and context.other_card and context.scoring_hand and not context.other_card.debuff and context.other_card.lucky_trigger then
            ease_dollars(card.ability.extra.money*card.ability.extra.benefits)
            card_eval_status_text(card, "extra", nil, nil, nil, {message = localize("$")..card.ability.extra.money*card.ability.extra.benefits, colour = G.C.MONEY})
        end
    end,
}

}
end