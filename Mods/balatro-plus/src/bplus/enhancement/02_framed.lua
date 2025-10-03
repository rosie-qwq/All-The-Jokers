return {
  config = { extra = 2 },

  loc_vars = function(self)
    return { vars = { self.config.extra } }
  end,

  calculate = function(_, card, ctx)
    if ctx.cardarea == G.play and ctx.main_scoring and not ctx.repetition then
      card.ability.perma_bonus = card.ability.perma_bonus + card.ability.extra
    end
  end,
}
