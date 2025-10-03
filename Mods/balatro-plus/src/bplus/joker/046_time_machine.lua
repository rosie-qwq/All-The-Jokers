return {
  config = { extra = -1 },
  rarity = 2,
  cost = 7,

  blueprint_compat = false,
  eternal_compat = false,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra > 0 and "+" .. card.ability.extra or card.ability.extra } }
  end,

  calculate = function(_, card, ctx)
    if ctx.selling_self then
      ease_ante(card.ability.extra)
    elseif ctx.end_of_round and not ctx.repetition and not ctx.individual then
      card.ability.extra = -card.ability.extra
    end
  end,
}
