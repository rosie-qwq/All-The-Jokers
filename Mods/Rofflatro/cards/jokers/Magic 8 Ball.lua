SMODS.Joker{
   key = 'magic8',
   atlas = 'roffers',
   pos = { x = 3, y = 9 },
   rarity = 1,
   cost = 5,
   blueprint_compat = true,
   config = { extra = { odds = 4 } },
   loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = {key = 'roff_favorite', set = 'Other'}
      return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
   end,
   calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play and context.other_card:get_id() == 8 and context.other_card.ability.roff_favorite then
         if pseudorandom('magic_8') < G.GAME.probabilities.normal / card.ability.extra.odds then
            local copied_eight = copy_card(context.other_card, nil, nil, G.playing_card)
            -- increment deck limit
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            -- add the card 
            copied_eight:add_to_deck()
            table.insert(G.playing_cards, copied_eight)
            G.hand:emplace(copied_eight)
            copied_eight.states.visible = nil
            G.E_MANAGER:add_event(Event({
               func = function()
                  copied_eight:start_materialize()
                  return true
               end
            }))
            return {
               message = localize('k_roff_magic8_'..pseudorandom('magic8', 1, 5)),
               func = function() G.E_MANAGER:add_event(Event({ func = function() -- we're doing this for timing btw
                  SMODS.calculate_context({ playing_card_added = true, cards = { copied_eight } })
                  return true
               end })) end
            }
         else
            return {
               message = localize('k_roff_magic8_fail_'..pseudorandom('magic8', 1, 5)),
            }
         end
      end
   end,
   set_badges = function(self, card, badges)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_art'), ROFF.C.credits.canicao_text, ROFF.C.credits.canicao, 0.8)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_code'), ROFF.C.credits.canicao, ROFF.C.credits.canicao_text, 0.8)
   end
}
