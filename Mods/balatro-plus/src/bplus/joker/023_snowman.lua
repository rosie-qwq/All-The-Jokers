return {
  config = { extra = { chips = 0, scale = 1 } },
  rarity = 1,
  cost = 4,

  blueprint_compat = true,
  perishable_compat = false,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.scale } }
  end,

  calculate = function(_, card, ctx)
    if not ctx.end_of_round and ctx.individual and ctx.cardarea == G.hand then
      if ctx.other_card.debuff then
        return {
          message = localize("k_debuffed"),
          colour = G.C.RED,
          card = card,
        }
      else
        if not ctx.blueprint then
          card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.scale
        end
        return {
          h_chips = card.ability.extra.chips,
          card = ctx.other_card,
        }
      end
    elseif not ctx.blueprint and ctx.end_of_round and not ctx.individual and not ctx.repetition then
      card.ability.extra.chips = 0
      return {
        message = localize("k_reset"),
        colour = G.C.CHIPS,
      }
    end
  end,
}
