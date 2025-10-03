return {
  config = { extra = 0.1, Xmult = 1 },
  rarity = 1,
  cost = 5,

  perishable_compat = false,
  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra, card.ability.x_mult } }
  end,

  calculate = function(_, card, ctx)
    if not ctx.blueprint and ctx.after and card.ability.x_mult ~= 1 then
      card.ability.x_mult = 1
      return {
        message = localize("k_reset"),
        colour = G.C.MULT,
      }
    elseif not ctx.blueprint and ctx.discard then
      card.ability.x_mult = card.ability.x_mult + card.ability.extra
      return {
        message = localize("k_upgrade_ex"),
        colour = G.C.MULT,
        card = card,
      }
    end
  end,
}
