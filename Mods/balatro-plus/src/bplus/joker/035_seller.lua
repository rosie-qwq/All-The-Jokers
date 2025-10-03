return {
  rarity = 1,
  cost = 4,

  blueprint_compat = false,

  calc_dollar_bonus = function(_, card)
    local joker
    for i, jkr in ipairs(G.jokers.cards) do
      if jkr == card then
        joker = G.jokers.cards[i + 1]
        break
      end
    end

    if joker and joker.sell_cost > 0 then
      return joker.sell_cost
    end
  end,
}
