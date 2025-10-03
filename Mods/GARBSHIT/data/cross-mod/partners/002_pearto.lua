if not Partner_API then return false else return
{
    Partner_API.Partner{
    key = "pearto",
    name = "Pearto",
    unlocked = false,
    discovered = true,
    individual_quips = true,
    pos = {x = 2, y = 0},
    loc_txt = {},
    atlas = "GarbPartner",
    config = {extra = {related_card = "j_garb_teto", Xmult = 1, benefits = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.Xmult+0.5*card.ability.extra.benefits} }
    end,
    update = function(self, card)
        card.ability.extra.benefits = next(SMODS.find_card(card.ability.extra.related_card)) and 2 or 1
    end,
    check_for_unlock = function(self, args)
        if next(SMODS.find_mod("voc_deckall")) or next(SMODS.find_mod("vocalatro")) then
          return true
        end
      end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
          if context.other_card:get_id() == 13 and context.other_card:is_suit("Hearts") then
              return {
              Xmult_mod = card.ability.extra.Xmult + 0.5*card.ability.extra.benefits,
              message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult + 0.5*card.ability.extra.benefits} },
              message_card = context.other_card,
            }
          end
        end
    end,
}

}
end