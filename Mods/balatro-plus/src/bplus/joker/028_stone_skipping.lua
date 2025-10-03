return {
  config = { extra = { scale = 0.1, xmult = 1.1 } },
  rarity = 1,
  cost = 5,

  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra.xmult, card.ability.extra.scale } }
  end,

  calculate = function(self, card, ctx)
    if ctx.individual and ctx.cardarea == G.play and SMODS.has_enhancement(ctx.other_card, "m_stone") then
      local xmult = card.ability.extra.xmult
      if not ctx.blueprint then
        card.ability.extra.xmult = xmult + card.ability.extra.scale
      end
      if xmult > 1 then
        return {
          x_mult = xmult,
          colour = G.C.MULT,
          card = card,
        }
      end
    elseif ctx.after and not ctx.blueprint then
      card.ability.extra.xmult = self.config.extra.xmult
    end
  end,
}
