return {
  config = { money = 2 },

  loc_vars = function(self)
    return { vars = { self.config.money } }
  end,

  calculate = function(self, _, ctx)
    if ctx.skipping_booster then
      local dollars = G.GAME.pack_choices * self.config.money
      print("HERE? ", dollars)
      if dollars > 0 then
        ease_dollars(dollars, true)
      end
    end
  end,
}
