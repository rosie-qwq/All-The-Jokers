return {
  config = { extra = 2 },
  rarity = 2,
  cost = 7,

  blueprint_compat = true,

  loc_vars = function(_, infoq, card)
    infoq[#infoq + 1] = G.P_CENTERS.m_bplus_premium
    return { vars = { card.ability.extra } }
  end,

  calculate = function(_, card, ctx)
    if ctx.bplus_premium_card_dollars then
      return { value = card.ability.extra }
    end
  end,
}
