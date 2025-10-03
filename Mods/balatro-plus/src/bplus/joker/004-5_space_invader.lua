return {
  rarity = 3,
  cost = 9,

  blueprint_compat = false,

  loc_vars = function(_, infoq)
    infoq[#infoq + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
  end,

  calculate = function(_, _, ctx)
    if ctx.bplus_card_added and ctx.cardarea == G.consumeables and ctx.other_card.config.center.set == "Planet" then
      if (not ctx.other_card.edition) or not ctx.other_card.edition.negative then
        ctx.other_card:set_edition({ negative = true }, true)
      end
    end
  end,
}
