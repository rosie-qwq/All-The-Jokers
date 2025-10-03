return {
  boss = { min = 3 },
  boss_colour = HEX("8da1c2"),

  press_play = function()
    if G.GAME.blind.disabled then
      return
    end

    local card_debuffed = false
    for _, card in ipairs(G.hand.cards) do
      local highlighted = false
      for _, h_card in ipairs(G.hand.highlighted) do
        if card == h_card then
          highlighted = true
          break
        end
      end

      if not highlighted then
        card:set_debuff(true)
        if card.debuff then
          card_debuffed = true
        end
      end
    end
    if card_debuffed then
      play_area_status_text("Card held in hands debuffed!", nil, 0)
    end
    G.GAME.blind.triggered = true
    return true
  end,
}
