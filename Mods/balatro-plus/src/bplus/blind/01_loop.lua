return {
  boss = { min = 2 },
  boss_colour = HEX("57126f"),
  mult = 2.5,

  hand_played = function(self)
    if G.GAME.blind.disabled then
      return
    end

    G.E_MANAGER:add_event(Event {
      delay = 0.5,
      func = function()
        if G.GAME.chips < self.chips then
          G.E_MANAGER:add_event(Event {
            trigger = "ease",
            blocking = false,
            ref_table = G.GAME,
            ref_value = "chips",
            ease_to = 0,
            delay = 0.5,
            func = function(t)
              return math.floor(t)
            end,
          })
          play_area_status_text("Set score to 0!")
        end
        return true
      end,
    })
    return true
  end,
}
