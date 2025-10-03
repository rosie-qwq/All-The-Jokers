SMODS.Joker:take_ownership('seance',
	{  config = { extra = { poker_hand = 'Straight Flush' } },
      loc_vars = function(self, info_queue, card)
          return { vars = { localize(card.ability.extra.poker_hand, 'poker_hands') } }
      end,
      calculate = function(self, card, context)
         if context.joker_main and (#G.consumeables.cards + G.GAME.consumeable_buffer) < G.consumeables.config.card_limit and next(context.poker_hands[card.ability.extra.poker_hand]) then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.GAME.ROFF_seance_used = true
            G.E_MANAGER:add_event(Event({func=(
               function()
                  SMODS.add_card{ set = 'Spectral' }
                  G.GAME.consumeable_buffer = 0
                  return true
               end
            )}))
            return {
               colour = G.C.SECONDARY_SET.Spectral,
               message = localize('k_plus_spectral'),
            }
         end
      end,
      in_pool = function(self, card)
         if G.jokers ~= nil then
            for k, v in ipairs(G.jokers.cards) do
               if v.config.center.key == "j_roff_excommunication" then
                  return false
               end
            end
            return true
         end
      end
	},
	true
)

SMODS.Joker {
   key = "excommunication",
   blueprint_compat = true,
   rarity = 2,
   cost = 6,
   atlas = 'roffers',
   pos = { x = 1, y = 8 },
   config = { extra = { Xmult = 1, Xmult_mod = 0.5 } },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
      return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult_mod/5, card.ability.extra.Xmult } }
   end,
   calculate = function(self, card, context)
      if G.consumeables and G.consumeables.cards then
         for i=1, #G.consumeables.cards do
            if G.consumeables.cards[i].config.center.set == 'Spectral' and not G.consumeables.cards[i].edition then
               G.consumeables.cards[i]:set_edition('e_negative')
               return { message = "Phantom!", colour = G.C.DARK_EDITION }
            end
         end
      end
      if G.jokers and G.jokers.cards then
         if G.jokers ~= nil then
            for i=1, #G.jokers.cards do
               if G.jokers.cards[i].config.center.key == "j_seance" then
                  G.jokers.cards[i]:start_dissolve()
                  return { message = "Begone!", colour = G.C.MULT }
               end
            end
         end
      end
      if context.using_consumeable and context.consumeable.ability.set == "Spectral" then
         card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
         return { message = "Appeased!", colour = G.C.MULT }
      end
      if context.selling_card and context.card.ability.set == "Spectral" then
         card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod/5
         return { message = "Banished!", colour = G.C.MULT }
      end
      if context.joker_main then
         return {
            Xmult = card.ability.extra.Xmult
         }
      end
   end,
   in_pool = function(self, card)
      return G.GAME.ROFF_seance_used
   end,
   set_badges = function (self, card, badges)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_art'), ROFF.C.credits.canicao_text, ROFF.C.credits.canicao, 0.8)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_code'), ROFF.C.credits.canicao, ROFF.C.credits.canicao_text, 0.8)
   end
}
