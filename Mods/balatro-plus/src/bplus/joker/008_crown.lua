return {
  config = { extra = 1, Xmult = 1 },
  rarity = 3,
  cost = 10,

  perishable_compat = false,
  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra, card.ability.x_mult } }
  end,

  calculate = function(self, card, ctx)
    if ctx.before and not ctx.blueprint then
      local _, _, _, _, name = G.FUNCS.get_poker_hand_info(G.play.cards)
      if name == "Royal Flush" then
        card.ability.x_mult = card.ability.x_mult + self.config.extra
        return {
          message = localize { type = "variable", key = "a_xmult", vars = { card.ability.x_mult } },
          colour = G.C.ORANGE,
          card = card,
        }
      end
    end
  end,
}
