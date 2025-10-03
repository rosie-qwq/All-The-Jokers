return {
  config = { chance = 8, x_mult = 2 },
  badge_colour = HEX("56a786"),

  loc_vars = function(_, _, card)
    return {
      vars = { G.GAME.probabilities.normal, card.ability.seal.chance, card.ability.seal.x_mult },
    }
  end,

  calculate = function(_, card, ctx)
    if ctx.main_scoring and ctx.cardarea == G.play then
      if pseudorandom("bplus_green_seal_xmult") < G.GAME.probabilities.normal / card.ability.seal.chance then
        return {
          x_mult = card.ability.seal.x_mult,
          colour = G.C.RED,
          card = card,
        }
      end
    end
  end,
}
