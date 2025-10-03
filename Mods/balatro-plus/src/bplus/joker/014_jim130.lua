return {
  config = { extra = 0.1, Xmult = 1 },
  rarity = 2,
  cost = 6,

  perishable_compat = false,
  blueprint_compat = true,

  loc_vars = function(_, infoq, card)
    infoq[#infoq + 1] = G.P_CENTERS.m_steel
    return { vars = { card.ability.extra, card.ability.x_mult } }
  end,

  calculate = function(_, card, ctx)
    if not ctx.blueprint and ctx.individual and ctx.cardarea == G.play and ctx.other_card.ability.name == G.P_CENTERS.m_steel.name then
      card.ability.x_mult = card.ability.x_mult + card.ability.extra
      card_eval_status_text(card, "jokers", nil, nil, nil, {
        message = localize("k_upgrade_ex"),
        colour = G.C.MULT,
      })
    end
  end,
}
