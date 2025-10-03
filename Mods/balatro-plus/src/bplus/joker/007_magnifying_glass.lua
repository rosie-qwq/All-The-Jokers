return {
  rarity = 2,
  cost = 6,

  blueprint_compat = true,

  calculate = function(_, card, ctx)
    if ctx.individual and ctx.cardarea == G.play then
      local id = ctx.other_card:get_id()
      if id == 2 or id == 3 then
        return {
          chips = 3 * (ctx.other_card:get_chip_bonus() + (ctx.other_card.edition and ctx.other_card.edition.chips or 0)),
          card = card,
        }
      end
    end
  end,
}
