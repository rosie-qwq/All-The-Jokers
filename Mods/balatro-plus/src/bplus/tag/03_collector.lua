local function calc_money(self)
  local total = self.config.each * (#(G.playing_cards or {}) - self.config.above)
  if total > self.config.max then
    total = self.config.max
  elseif total < 0 then
    total = 0
  end
  return total
end

return {
  config = { above = 50, max = 45, each = 3 },

  loc_vars = function(self)
    return {
      vars = {
        self.config.each,
        self.config.above,
        self.config.max,
        calc_money(self),
      },
    }
  end,

  apply = function(self, tag, ctx)
    if ctx.type == "immediate" then
      local money = calc_money(self)
      if money > 0 then
        tag:yep("+", G.C.MONEY, function()
          ease_dollars(money, true)
          return true
        end)
        tag.triggered = true
        return true
      end
    end
  end,
}
