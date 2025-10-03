return {
  rarity = 1,
  cost = 4,
  config = {
    extra = {
      min = 6,
      max = 12,
      remaining = 4,
      every = 5,
    },
  },

  blueprint_compat = true,

  loc_vars = function(self, _, card)
    return {
      vars = {
        card.ability.extra.min,
        card.ability.extra.max,
        self.config.extra.every,
        localize {
          type = "variable",
          key = card.ability.extra.remaining == 0 and "loyalty_active" or "loyalty_inactive",
          vars = { card.ability.extra.remaining },
        },
      },
    }
  end,

  calculate = function(self, card, ctx)
    if ctx.joker_main then
      if card.ability.extra.remaining == 0 then
        local money = pseudorandom("bplus_treasure_map", card.ability.extra.min, card.ability.extra.max)
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + money
        G.E_MANAGER:add_event(Event {
          func = function()
            G.GAME.dollar_buffer = 0
            return true
          end,
        })

        return {
          -- message = localize("$") .. money,
          dollars = money,
          colour = G.C.MONEY,
        }
      end
    elseif ctx.after and ctx.cardarea == G.jokers and not ctx.blueprint then
      if card.ability.extra.remaining == 0 then
        card.ability.extra.remaining = self.config.extra.every
      end

      card.ability.extra.remaining = card.ability.extra.remaining - 1

      if card.ability.extra.remaining == 0 then
        juice_card_until(card, function(c)
          return c.ability.extra.remaining == 0
        end, true)
      end
    end
  end,
}
