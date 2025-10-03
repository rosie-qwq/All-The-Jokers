return {
  config = { extra = 6 },
  rarity = 2,
  cost = 6,

  perishable_compat = false,
  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra, card.ability.mult } }
  end,

  calculate = function(_, card, ctx)
    if ctx.joker_main and card.ability.mult > 0 then
      return {
        message = localize { type = "variable", key = "a_mult", vars = { card.ability.mult } },
        mult_mod = card.ability.mult,
        colour = G.C.MULT,
      }
    elseif ctx.after and not ctx.blueprint then
      local destroyed
      for i = #ctx.full_hand, 1, -1 do
        local c = ctx.full_hand[i]
        if not c.removed and not c.shattered and not c.destroyed then
          destroyed = c
          c.destroyed = true
          c.removed = true
          break
        end
      end

      if destroyed then
        card.ability.mult = card.ability.mult + card.ability.extra
        for j = 1, #G.jokers.cards do
          eval_card(G.jokers.cards[j], { cardarea = G.jokers, remove_playing_cards = true, removed = { destroyed } })
        end
        G.E_MANAGER:add_event(Event {
          func = function()
            if SMODS.has_enhancement(destroyed, "m_glass") then
              destroyed:shatter()
            else
              destroyed:start_dissolve()
            end
            return true
          end,
        })
        delay(1)
        return {
          message = localize("k_upgrade_ex"),
          colour = G.C.MULT,
        }
      end
    end
  end,
}
