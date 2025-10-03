SMODS.Joker{
   key = 'nice',
   atlas = 'roffers',
   rarity = 1,
   cost = 6,
   blueprint_compat = true,
   eternal_compat = true,
   pos = { x = 5, y = 8 },
   config = { extra = { mult = 6, chips = 9 } },
   loc_vars = function(self, info_queue, card)
      if card.ability.extra.mult < card.ability.extra.chips then
         return { vars = { '+'..math.min(card.ability.extra.mult, card.ability.extra.chips), '+'..math.max(card.ability.extra.mult, card.ability.extra.chips), "Mult", "Chips",
               colours = { G.C.MULT, G.C.CHIPS, }
            }
         }
      else
         return { vars = { '+'..math.min(card.ability.extra.mult, card.ability.extra.chips), '+'..math.max(card.ability.extra.mult, card.ability.extra.chips), "Chips", "Mult",
               colours = { G.C.CHIPS, G.C.MULT,}
            }
         }
      end
   end,
   calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play and context.other_card:get_id() == 6 then
         if card.ability.extra.mult < card.ability.extra.chips then
            return {
               mult = card.ability.extra.mult
            }
         else
            return {
               chips = card.ability.extra.chips
            }
         end
      elseif context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 9 then
         if card.ability.extra.mult > card.ability.extra.chips then
            return {
               mult = card.ability.extra.mult
            }
         else
            return {
               chips = card.ability.extra.chips
            }
         end
      elseif context.after and context.cardarea == G.jokers and not context.blueprint then
         local nice_mult, nice_chips = card.ability.extra.mult, card.ability.extra.chips
         card.ability.extra.mult = nice_chips
         card.ability.extra.chips = nice_mult
         return {
            message = 'Switch!',
         }
      end
   end,
   set_badges = function(self, card, badges)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_art'), ROFF.C.credits.canicao_text, ROFF.C.credits.canicao, 0.8)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_code'), ROFF.C.credits.canicao, ROFF.C.credits.canicao_text, 0.8)
   end
}
