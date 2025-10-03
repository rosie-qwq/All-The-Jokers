return {
  config = { reward = 8 },

  loc_vars = function(self)
    return { vars = { self.config.reward } }
  end,

  calculate = function(self, _, ctx)
    if ctx.skip_blind then
      ease_dollars(self.config.reward)
    end
  end,
}
