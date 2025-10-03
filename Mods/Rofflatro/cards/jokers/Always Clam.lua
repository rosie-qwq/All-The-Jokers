SMODS.Joker{
   key = 'clam',
   atlas = 'roffers',
   rarity = 2,
   cost = 7,
   blueprint_compat = true,
   eternal_compat = true,
   pos = { x = 1, y = 9 },
   config = { extra = { chips = 0, chip_mod = 50 } },
   loc_vars = function(self,info_queue,card)
      return {vars = {card.ability.extra.chip_mod, card.ability.extra.chips}}
   end,
   calculate = function(self, card, context)
      if context.after and context.cardarea == G.jokers and not context.blueprint then
         if _G.hand_chips * _G.mult * 4 < G.GAME.blind.chips then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
               message = 'Stay Clam!',
               colour = G.C.CHIPS,
               sound = 'chips2'
            }
         end
      elseif context.joker_main then
         return {
            chips = card.ability.extra.chips
         }
      elseif context.blind_defeated and G.GAME.blind.boss and context.cardarea == G.jokers and not context.blueprint then
         card.ability.extra.chips = 0
         return {
            message = 'Chowder...',
            colour = G.C.RED,
            sound = 'chips2'
         }
      end
   end,
   set_badges = function(self, card, badges)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_art'), ROFF.C.credits.canicao_text, ROFF.C.credits.canicao, 0.8)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_code'), ROFF.C.credits.canicao, ROFF.C.credits.canicao_text, 0.8)
   end
}
