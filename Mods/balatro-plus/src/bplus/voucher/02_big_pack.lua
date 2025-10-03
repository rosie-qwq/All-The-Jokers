return {
  config = { choose = 1, slot = 1 },
  requires = { "v_bplus_refund" },

  loc_vars = function(self)
    return { vars = { self.config.slot, self.config.choose } }
  end,

  calculate = function(self, card, ctx)
    if ctx.open_booster then
      ctx.card.ability.extra = ctx.card.ability.extra + self.config.slot
      G.GAME.pack_choices = math.min(G.GAME.pack_choices + self.config.choose, ctx.card.ability.extra)
    end
  end,
}
