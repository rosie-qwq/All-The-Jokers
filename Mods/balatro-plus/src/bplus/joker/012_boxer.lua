return {
  config = { hands_above = 2, mult_each_hand = 0.5 },
  rarity = 1,
  cost = 5,

  blueprint_compat = true,

  loc_vars = function(self)
    local above = self.config.hands_above
    local hands = (G.GAME and (G.GAME.current_round and G.GAME.current_round.hands_left) or 0) - above
    if hands < 0 then
      hands = 0
    end
    return { vars = { self.config.mult_each_hand, above, 1 + (hands * self.config.mult_each_hand) } }
  end,

  calculate = function(self, _, ctx)
    if ctx.joker_main then
      local above = self.config.hands_above
      local hands = ((G.GAME and (G.GAME.current_round and G.GAME.current_round.hands_left) or 0) + 1) - above
      if hands < 0 then
        hands = 0
      end

      local xmult = 1 + (hands * self.config.mult_each_hand)
      if xmult > 1 then
        return {
          message = localize { type = "variable", key = "a_xmult", vars = { xmult } },
          Xmult_mod = xmult,
        }
      end
    end
  end,
}
