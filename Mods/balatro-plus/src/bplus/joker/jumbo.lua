return {
  config = { size_scale = 1.2, Xmult = 2 },
  rarity = 1,
  cost = 5,
  atlas = "Joker",
  prefix_config = {
    atlas = false,
  },

  blueprint_compat = false,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.x_mult } }
  end,

  set_ability = function(self, card)
    if self.discovered or card.bypass_discovery_center then
      card.T.w = card.T.w * self.config.size_scale
      card.T.h = card.T.h * self.config.size_scale
    end
  end,

  load = function(self, card)
    card.T.w = G.CARD_W * self.config.size_scale
    card.T.h = G.CARD_H * self.config.size_scale
  end,

  calculate = function(_, card, ctx)
    if ctx.setting_blind and not ctx.blueprint and not card.getting_sliced and not BPlus.u.has_empty_joker_space() then
      local destroyed
      for i = #G.jokers.cards, 1, -1 do
        local c = G.jokers.cards[i]
        if not BPlus.u.getting_destroyed(c) and c ~= card then
          destroyed = c
          break
        end
      end

      if destroyed then
        destroyed.getting_sliced = true
        G.GAME.joker_buffer = G.GAME.joker_buffer - 1

        G.E_MANAGER:add_event(Event {
          func = function()
            G.GAME.joker_buffer = 0
            card:juice_up(0.7, 0.7)
            destroyed:start_dissolve({ darken(G.C.RED, 0.3) }, nil, 1.7)
            play_sound("slice1", 0.96 + math.random() * 0.1)
            return true
          end,
        })
      end
    end
  end,
}
