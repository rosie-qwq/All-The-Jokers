SMODS.Joker {
   key = "engagement",
   blueprint_compat = true,
   rarity = 3,
   cost = 8,
   atlas = 'roffers',
   pos = { x = 2, y = 8 },
   calculate = function(self, card, context)
      if context.end_of_round and context.cardarea == G.jokers and (#G.consumeables.cards + G.GAME.consumeable_buffer) < G.consumeables.config.card_limit and G.consumeables and #G.consumeables.cards == 0 and G.GAME.current_round.hands_left == 0 and G.GAME.current_round.discards_left == 0 then
         G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
         G.E_MANAGER:add_event(Event({func=(
              function()
               SMODS.add_card{ set = 'Spectral' }
               G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
               return true
            end
         )}))
         return {
            colour = G.C.SECONDARY_SET.Spectral,
            message = localize('k_plus_spectral'),
         }
      end
   end,
   set_badges = function (self, card, badges)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_art'), ROFF.C.credits.canicao_text, ROFF.C.credits.canicao, 0.8)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_code'), ROFF.C.credits.canicao, ROFF.C.credits.canicao_text, 0.8)
   end
}
