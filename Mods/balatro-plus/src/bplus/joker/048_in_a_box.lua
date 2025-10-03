return {
  config = { extra = { mult = 10, chips = 50, dollars = 3, x_mult = 2 } },
  rarity = 1,
  cost = 6,

  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return {
      vars = {
        card.ability.extra.mult,
        card.ability.extra.chips,
        card.ability.extra.dollars,
        card.ability.extra.x_mult,
      },
    }
  end,

  calculate = function(_, card, ctx)
    if ctx.joker_main then
      local result = pseudorandom_element({ "mult", "chips", "dollars", "x_mult" }, pseudoseed("j_bplus_in_a_box_result"))
      return {
        [result] = card.ability.extra[result],
      }
    end
  end,
}
