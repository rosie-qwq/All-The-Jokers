return {
  config = { card_nominal_mult = 3, destroyed_cards = 26 },

  loc_vars = function(self)
    return { vars = { self.config.destroyed_cards } }
  end,
}
