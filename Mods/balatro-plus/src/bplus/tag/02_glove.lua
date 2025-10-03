return {
  config = { hand = 5 },

  loc_vars = function(self)
    return { vars = { self.config.hand } }
  end,

  apply = function(self, tag, ctx)
    if ctx.type == "round_start_bonus" then
      tag:yep("+", G.C.BLUE, function()
        ease_hands_played(self.config.hand, true)
        return true
      end)
      tag.triggered = true
      return true
    end
  end,
}
