return {
  config = { extra = { flushed = false, chips = 0 } },
  rarity = 2,
  cost = 6,

  perishable_compat = false,
  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra.chips } }
  end,

  calculate = function(_, card, ctx)
    if
      ctx.discard
      and not ctx.blueprint
      and not card.ability.extra.flushed
      and ctx.other_card == ctx.full_hand[#ctx.full_hand]
      and G.FUNCS.get_poker_hand_info(ctx.full_hand) == "Flush"
    then
      card.ability.extra.chips = card.ability.extra.chips + (G.GAME.hands.Flush.chips / 2)
      card.ability.extra.flushed = true

      return {
        message = localize("k_upgrade_ex"),
        card = card,
        colour = G.C.CHIPS,
      }
    elseif ctx.joker_main and card.ability.extra.chips > 0 then
      return {
        message = localize {
          type = "variable",
          key = "a_chips",
          vars = { card.ability.extra.chips },
        },
        chip_mod = card.ability.extra.chips,
        colour = G.C.CHIPS,
      }
    elseif ctx.end_of_round and not ctx.repetition and not ctx.individual and not ctx.blueprint then
      card.ability.extra.flushed = false
    end
  end,
}
