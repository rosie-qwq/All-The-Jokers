return {
  config = { extra = 0.25, Xmult = 1 },
  rarity = 2,

  blueprint_compat = true,
  perishable_compat = false,

  loc_vars = function(_, infoq, card)
    infoq[#infoq + 1] = G.P_CENTERS.m_bplus_burned
    return { vars = { card.ability.extra, card.ability.x_mult } }
  end,

  calculate = function(_, card, ctx)
    if ctx.remove_playing_cards and not ctx.blueprint then
      local burned = 0
      for _, c in ipairs(ctx.removed) do
        if SMODS.has_enhancement(c, "m_bplus_burned") and c.burned then
          burned = burned + 1
        end
      end

      if burned > 0 then
        card.ability.x_mult = card.ability.x_mult + (card.ability.extra * burned)
        G.E_MANAGER:add_event(Event {
          func = function()
            card_eval_status_text(card, "extra", nil, nil, nil, {
              message = localize {
                type = "variable",
                key = "a_xmult",
                vars = { card.ability.x_mult },
              },
            })
            return true
          end,
        })
        return nil, true
      end
    end
  end,
}
