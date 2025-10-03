return {
  boss = { min = 2 },
  boss_colour = HEX("a15c2f"),

  drawn_to_hand = function()
    if G.GAME.blind.disabled then
      return
    end

    local card = pseudorandom_element(G.hand.cards, pseudoseed("bl_bplus_hammer_choosen"))
    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.5,
      func = function()
        if card.ability.name == G.P_CENTERS.m_glass.name then
          card:shatter()
        else
          card:start_dissolve()
        end
        G.GAME.blind:wiggle()
        draw_card(G.deck, G.hand, nil, "up", true)
        return true
      end,
    })
    return true
  end,
}
