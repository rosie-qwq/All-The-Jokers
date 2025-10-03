return {
  config = { extra = { chips = 0, scale = 10 } },
  rarity = 3,
  cost = 8,

  perishable_compat = false,
  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra.scale, card.ability.extra.chips } }
  end,

  calculate = function(_, card, ctx)
    if ctx.joker_main and card.ability.extra.chips > 0 then
      return {
        message = localize {
          type = "variable",
          key = "a_chips",
          vars = { card.ability.extra.chips },
        },
        colour = G.C.CHIPS,
        chip_mod = card.ability.extra.chips,
      }
    elseif ctx.bplus_enhance and not ctx.blueprint and ctx.to ~= G.P_CENTERS.c_base then
      card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.scale
    end
  end,
}
