return {
  config = { extra = 1 },

  loc_vars = function(self, _, card)
    return { vars = { card.ability.extra } }
  end,

  can_use = function(self, card)
    return G.hand and G.GAME.round_resets.hands - card.ability.extra > 0 and #G.hand.highlighted == 1 and G.hand.config.card_limit > 1
  end,

  use = function(self, card)
    local card_to_copy = G.hand.highlighted[1]

    for i, card in ipairs(G.hand.cards) do
      if card ~= card_to_copy then
        local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
        G.E_MANAGER:add_event(Event {
          trigger = "after",
          delay = 0.15,
          func = function()
            card:flip()
            play_sound("card1", percent)
            card:juice_up(0.3, 0.3)
            return true
          end,
        })
      end
    end

    for _, card in ipairs(G.hand.cards) do
      if card ~= card_to_copy then
        G.E_MANAGER:add_event(Event {
          trigger = "after",
          delay = 0.1,
          func = function()
            copy_card(card_to_copy, card)
            return true
          end,
        })
      end
    end

    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.1,
      func = function()
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra
        ease_hands_played(-card.ability.extra, true)
        return true
      end,
    })

    for i, card in ipairs(G.hand.cards) do
      if card ~= card_to_copy then
        local percent = 0.85 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
        G.E_MANAGER:add_event(Event {
          trigger = "after",
          delay = 0.15,
          func = function()
            card:flip()
            play_sound("tarot2", percent, 0.6)
            card:juice_up(0.3, 0.3)
            return true
          end,
        })
      end
    end
  end,
}
