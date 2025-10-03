SMODS.Joker{
   key = 'vod_watchers',
   atlas = 'roffers',
   rarity = 3,
   cost = 9,
   blueprint_compat = true,
   eternal_compat = true,
   pos = { x = 2, y = 9 },
   config = { extra = { Xmult = 1, Xmult_mod = 0.19 } },
   loc_vars = function(self,info_queue,card)
      return {vars = {card.ability.extra.Xmult_mod, card.ability.extra.Xmult}}
   end,
   calculate = function(self, card, context)
      if context.before and context.cardarea == G.jokers and not context.blueprint then
         card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
         return {
            message = 'zzz...',
            colour = G.C.MULT,
         }
      elseif context.joker_main then
         return {
            Xmult = card.ability.extra.Xmult
         }
      elseif context.blind_defeated and context.cardarea == G.jokers and not context.blueprint then
         if _G.hand_chips * _G.mult > G.GAME.blind.chips and G.GAME.current_round.hands_played == 1 then
            card.ability.extra.Xmult = 1
            return {
               message = 'Ah!',
               colour = G.C.RED,
               sound = 'timpani'
            }
         end
      end
   end,
   set_badges = function(self, card, badges)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_art'), ROFF.C.credits.canicao_text, ROFF.C.credits.canicao, 0.8)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_code'), ROFF.C.credits.canicao, ROFF.C.credits.canicao_text, 0.8)
   end
}
