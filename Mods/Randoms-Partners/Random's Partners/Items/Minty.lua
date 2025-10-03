Partner_API.Partner{
    key = "hedonist_joker",
    name = "hedonist_partner",
    unlocked = true,
    discovered = true,
    pos = {x = 0, y = 0},
    loc_txt = {},
    atlas = "miniminty",
    config = {extra = {related_card = "j_hedonist_joker", s_mult = 2, suit = 'minty_3s'}},
     loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.s_mult, localize(card.ability.extra.suit, 'suits_singular') } }
    end,
      calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and context.other_card:is_suit(card.ability.extra.suit) then
            local benefits = 1
            if next(SMODS.find_card("j_hedonist_joker")) then benefits = 4 end
            return {
                mult = card.ability.extra.s_mult*benefits,
                colour = G.C.RED,
                card = card
            }
        end
    end,
    check_for_unlock = function(self, args)
        for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
            if v.key == "j_hedonist_joker" then
                if get_joker_win_sticker(v, true) >= 8 then
                    return true
                end
                break
            end
        end
    end,
}
