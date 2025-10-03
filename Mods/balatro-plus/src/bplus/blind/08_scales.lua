return {
  boss = { min = 2 },
  boss_colour = HEX("51461a"),

  press_play = function(self)
    if G.GAME.blind.disabled then
      return
    end

    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.2,
      func = function()
        for _, card in ipairs(G.hand.cards) do
          G.E_MANAGER:add_event(Event {
            func = function()
              card:juice_up()
              return true
            end,
          })
          ease_dollars(-1)
          delay(0.23)
        end
        return true
      end,
    })
    return true
  end,
}
