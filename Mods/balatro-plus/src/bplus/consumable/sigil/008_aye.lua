return {
  config = { extra = 2 },

  loc_vars = function(self, _, card)
    return { vars = { card.ability.extra } }
  end,

  can_use = function(self, card)
    return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra
  end,

  use = function(self, card)
    local valid_cards = {}
    local alt_cards = {}
    for _, c in ipairs(G.playing_cards) do
      local highlighted = false
      for _, hc in ipairs(G.hand.highlighted) do
        if c == hc then
          highlighted = true
          break
        end
      end
      if not highlighted then
        alt_cards[#alt_cards + 1] = c
      end
      if c.ability.name ~= G.P_CENTERS.m_stone.name and not highlighted then
        valid_cards[#valid_cards + 1] = c
      end
    end

    if not next(valid_cards) then
      for _, c in ipairs(G.hand.highlighted) do
        valid_cards[#valid_cards + 1] = c
      end
    end

    if not next(valid_cards) then
      valid_cards = alt_cards
    end

    local card_to_copy = pseudorandom_element(valid_cards, pseudoseed("c_bplus_sigil_aye_card"))
    local rank, suit = card_to_copy.base.id, card_to_copy.base.suit

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
          local key = string.sub(suit, 1, 1) .. "_"
          key = key
            .. (
              (rank < 10 and tostring(rank))
              or (rank == 10 and "T")
              or (rank == 11 and "J")
              or (rank == 12 and "Q")
              or (rank == 13 and "K")
              or (rank == 14 and "A")
            )
          card:set_base(G.P_CARDS[key])
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
  end,
}
