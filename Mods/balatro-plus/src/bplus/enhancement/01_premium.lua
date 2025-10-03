BPlus.premium_card_base_dollars = -3

function BPlus.calculate_premium_card_dollars()
  local dollars = BPlus.premium_card_base_dollars

  if G.jokers then
    for _, joker in ipairs(G.jokers.cards) do
      local ret = joker:calculate_joker { bplus_premium_card_dollars = true }
      if ret and ret.value then
        dollars = dollars + ret.value
      end
    end
  end

  return dollars
end

function BPlus.premium_card_dollars()
  return G.bplus_premium_card_dollars or BPlus.calculate_premium_card_dollars()
end

return {
  config = { Xmult = 2 },

  loc_vars = function(self)
    local dollars = BPlus.premium_card_dollars()
    return {
      vars = {
        self.config.Xmult,
        dollars < 0 and -dollars or dollars,
        dollars < 0 and "Loss" or "Earn",
      },
    }
  end,

  calculate = function(_, _, ctx)
    if ctx.cardarea == G.play and ctx.main_scoring and not ctx.repetition then
      return { p_dollars = BPlus.premium_card_dollars() }
    end
  end,
}
