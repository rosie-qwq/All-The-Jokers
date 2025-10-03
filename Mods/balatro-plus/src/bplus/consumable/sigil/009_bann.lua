return {
  can_use = function(self)
    return G.hand and #G.hand.highlighted == 1
  end,

  use = function(card)
    local selected = G.hand.highlighted[1]
    local destroys = { selected }
    if selected.ability.name ~= G.P_CENTERS.m_stone.name then
      local id, suit = selected:get_id(), selected.base.suit
      for _, card in ipairs(G.playing_cards) do
        if card:get_id() == id and card:is_suit(suit) then
          destroys[#destroys + 1] = card
        end
      end
    end

    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.1,
      func = function()
        for _, card in ipairs(destroys) do
          if card.ability.name == G.P_CENTERS.m_glass.name then
            card:shatter()
          else
            card:start_dissolve()
          end
        end
        return true
      end,
    })

    for i = 1, #G.jokers.cards do
      G.jokers.cards[i]:calculate_joker { remove_playing_cards = true, removed = destroys }
    end
  end,
}
