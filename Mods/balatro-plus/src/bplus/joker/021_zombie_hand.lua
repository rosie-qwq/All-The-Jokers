return {
  config = { extra = 1 },
  rarity = 1,
  cost = 4,

  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra } }
  end,

  calculate = function(_, card, ctx)
    if ctx.before and G.GAME.current_round.hands_left == 0 then
      return {
        message = localize("k_level_up_ex"),
        level_up = card.ability.extra,
      }
    end
  end,
}
