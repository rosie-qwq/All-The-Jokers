return {
  config = { extra = 3 },

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra } }
  end,

  can_use = function(_, card)
    return G.hand
      and #G.hand.highlighted > 0
      and #G.hand.highlighted <= card.ability.extra
      and #G.hand.cards - #G.hand.highlighted >= #G.hand.highlighted
  end,

  use = function()
    local enhancement = BPlus.u.random_enhancement("c_bplus_sigil_beast_enhancement")
    local seal = BPlus.u.random_seal("c_bplus_sigil_beast_seal")
    local destroyables = {}
    local destroyed_cards = {}
    for _, card in ipairs(G.hand.cards) do
      if not card.highlighted then
        destroyables[#destroyables + 1] = card
      end
    end

    for _ = 1, #G.hand.highlighted do
      local card_to_destroy = pseudorandom_element(destroyables, pseudoseed("c_bplus_sigil_beast_destroy"))
      destroyed_cards[#destroyed_cards + 1] = card_to_destroy
      G.E_MANAGER:add_event(Event {
        trigger = "after",
        func = function()
          if card_to_destroy.ability.name == G.P_CENTERS.m_glass.name then
            card_to_destroy:shatter()
          else
            card_to_destroy:start_dissolve(nil, nil, 1.3)
          end
          play_sound("slice1", 0.96 + math.random() * 0.05)
          return true
        end,
      })
      local i = 1
      for index, card in ipairs(destroyables) do
        if card == card_to_destroy then
          i = index
        end
      end
      table.remove(destroyables, i)
    end

    for _, card in ipairs(G.hand.highlighted) do
      G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0.1,
        func = function()
          card:flip()
          play_sound("card1", percent)
          card:juice_up(0.3, 0.3)
          return true
        end,
      })
    end

    for _, card in ipairs(G.hand.highlighted) do
      G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0.2,
        func = function()
          card:set_seal(seal, nil, true)
          card:set_ability(enhancement)
          return true
        end,
      })
    end

    for i, card in ipairs(G.hand.highlighted) do
      local percent = 0.85 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
      G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0.5,
        func = function()
          card:flip()
          play_sound("tarot2", percent, 0.6)
          card:juice_up(0.3, 0.3)
          return true
        end,
      })
    end

    for i = 1, #G.jokers.cards do
      G.jokers.cards[i]:calculate_joker { remove_playing_cards = true, removed = destroyed_cards }
    end
  end,
}
