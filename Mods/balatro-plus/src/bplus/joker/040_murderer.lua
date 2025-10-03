return {
  config = { extra = 1, Xmult = 1 },
  rarity = 3,
  cost = 9,

  blueprint_compat = true,
  perishable_compat = false,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra, card.ability.x_mult } }
  end,

  calculate = function(_, card, ctx)
    if ctx.bplus_joker_destroyed and not ctx.blueprint and not BPlus.u.getting_destroyed(card) then
      local cards = #ctx.destroyed_cards
      G.E_MANAGER:add_event(Event {
        func = function()
          local xmult = card.ability.x_mult + (cards * card.ability.extra)
          card.ability.x_mult = xmult
          card_eval_status_text(card, "extra", nil, nil, nil, {
            message = localize { type = "variable", key = "a_xmult", vars = { xmult } },
          })
          return true
        end,
      })
    end
  end,
}
