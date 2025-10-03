return {
  rarity = 1,
  cost = 5,

  blueprint_compat = false,

  loc_vars = function(_, infoq)
    infoq[#infoq + 1] = G.P_CENTERS.m_glass
  end,

  calculate = function(_, _, ctx)
    if ctx.discard and SMODS.has_enhancement(ctx.other_card, "m_glass") then
      return {
        silent = true,
        remove = true,
      }
    end
  end,
}
