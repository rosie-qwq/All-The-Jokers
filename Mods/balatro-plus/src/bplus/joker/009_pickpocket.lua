return {
  config = { extra = 1 },
  rarity = 1,
  cost = 5,

  blueprint_compat = true,

  calculate = function(_, card, ctx)
    if ctx.open_booster then
      G.GAME.pack_choices = G.GAME.pack_choices + card.ability.extra
      card_eval_status_text(ctx.blueprint or card, "jokers", nil, nil, nil, {
        message = localize {
          type = "variable",
          key = "k_bplus_plus_choose_ex",
          vars = { card.ability.extra },
        },
        colour = G.C.ORANGE,
      })
    end
  end,
}
