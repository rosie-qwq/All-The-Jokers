return {
  config = { extra = 1 },
  rarity = 2,
  cost = 6,

  blueprint_compat = true,

  calculate = function(_, card, ctx)
    if ctx.bplus_discard_repetition then
      return {
        message = localize("k_again_ex"),
        repetitions = card.ability.extra,
        card = card,
      }
    end
  end,
}
