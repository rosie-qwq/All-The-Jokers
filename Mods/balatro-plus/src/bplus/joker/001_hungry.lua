return {
  config = { extra = 0.5, Xmult = 1 },
  rarity = 2,
  cost = 7,

  perishable_compat = false,
  blueprint_compat = true,

  loc_vars = function(_, infoq, card)
    infoq[#infoq + 1] = { set = "Other", key = "bplus_food_jokers" }
    return { vars = { card.ability.extra, card.ability.x_mult } }
  end,

  calculate = function(_, card, ctx)
    if ctx.ending_shop and not ctx.blueprint then
      local destroyed
      for _, joker in ipairs(G.jokers.cards) do
        if joker.config.center.bplus_food_joker then
          joker.getting_sliced = true
          destroyed = joker
          break
        end
      end

      if destroyed then
        BPlus.u.joker_destroyed_trigger { destroyed }
        G.E_MANAGER:add_event(Event {
          func = function()
            play_sound("tarot1")
            destroyed.T.r = -0.2
            destroyed:juice_up(0.3, 0.4)
            destroyed.children.center.pinch.x = true
            destroyed.states.drag.is = true
            card:juice_up(0.4, 0.5)

            G.E_MANAGER:add_event(Event {
              trigger = "after",
              delay = 0.3,
              blockable = false,
              func = function()
                G.jokers:remove_card(destroyed)
                destroyed:remove()
                destroyed = nil
                return true
              end,
            })
            return true
          end,
        })

        card_eval_status_text(destroyed, "jokers", nil, nil, nil, {
          message = localize("k_eaten_ex"),
        })

        card.ability.x_mult = card.ability.x_mult + card.ability.extra

        card_eval_status_text(card, "extra", nil, nil, nil, {
          message = localize { type = "variable", key = "a_xmult", vars = { card.ability.x_mult } },
        })
      end
    end
  end,
}
