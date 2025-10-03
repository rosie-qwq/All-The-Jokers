return {
  config = { extra = 3 },
  rarity = 2,
  cost = 7,

  blueprint_compat = false,
  eternal_compat = false,
  bplus_food_joker = true,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra } }
  end,

  add_to_deck = function(_, card)
    for k, v in pairs(G.GAME.probabilities) do
      G.GAME.probabilities[k] = v * card.ability.extra
    end
  end,

  remove_from_deck = function(_, card)
    for k, v in pairs(G.GAME.probabilities) do
      G.GAME.probabilities[k] = v / card.ability.extra
    end
  end,

  calculate = function(_, card, ctx)
    if ctx.end_of_round and G.GAME.blind.boss and not ctx.individual and not ctx.repetition then
      if card.ability.extra - 1 <= 1 then
        G.E_MANAGER:add_event(Event {
          func = function()
            play_sound("tarot1")
            card:juice_up(0.3, 0.4)
            card.T.r = -0.2
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event {
              trigger = "after",
              delay = 0.3,
              blockable = false,
              func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
                return true
              end,
            })
            return true
          end,
        })
        return {
          card = card,
          message = localize("k_eaten_ex"),
          colour = G.C.FILTER,
        }
      else
        for k, v in pairs(G.GAME.probabilities) do
          G.GAME.probabilities[k] = v / card.ability.extra
        end
        card.ability.extra = card.ability.extra - 1
        for k, v in pairs(G.GAME.probabilities) do
          G.GAME.probabilities[k] = v * card.ability.extra
        end

        return {
          card = card,
          delay = 0.5,
          message = "-X1",
          colour = G.C.GREEN,
        }
      end
    end
  end,
}
