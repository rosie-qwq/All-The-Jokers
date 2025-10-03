return {
  config = { voucher = "v_hone", booster_pack = "p_buffoon_jumbo_1", start_dollars = 0 },

  loc_vars = function(self)
    return { vars = { self.config.start_dollars } }
  end,

  apply = function(self)
    G.GAME.starting_params.dollars = self.config.start_dollars
    G.GAME.selected_back.effect.open_pack = true
  end,
}
