return {
  boss = { min = 4 },
  boss_colour = HEX("821c15"),

  modify_hand = function(_, cards, _, _, mult, chips)
    local triggered = false

    if not G.GAME.blind.disabled then
      for _, card in ipairs(cards) do
        if card.ability.name ~= G.P_CENTERS.c_base.name then
          triggered = true
          card:set_ability(G.P_CENTERS.c_base, nil, true)
          G.E_MANAGER:add_event(Event {
            func = function()
              card:juice_up()
              return true
            end,
          })
        end
      end
    end

    return mult, chips, triggered
  end,
}
