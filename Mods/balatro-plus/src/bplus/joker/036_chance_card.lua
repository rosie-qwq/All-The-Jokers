return {
  config = { extra = 4 },
  rarity = 1,
  cost = 4,

  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return { vars = { G.GAME.probabilities.normal, card.ability.extra } }
  end,

  calculate = function(_, card, ctx)
    if
      ctx.repetition
      and ctx.cardarea == G.play
      and pseudorandom("j_bplus_card_chance_retrigger") <= G.GAME.probabilities.normal / card.ability.extra
    then
      return {
        message = localize("k_again_ex"),
        repetitions = 1,
        card = card,
      }
    end
  end,
}
