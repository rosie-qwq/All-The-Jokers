return {
  config = { reroll_extra_cost = 2 },

  loc_vars = function(self)
    return { vars = { self.config.reroll_extra_cost } }
  end,

  apply = function(self)
    G.GAME.starting_params.reroll_cost = G.GAME.starting_params.reroll_cost + self.config.reroll_extra_cost
  end,
}
