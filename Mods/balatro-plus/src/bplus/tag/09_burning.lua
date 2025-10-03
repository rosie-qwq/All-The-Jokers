return {
  config = { discard = 5 },

  loc_vars = function(self)
    return { vars = { self.config.discard } }
  end,

  apply = function(self, tag, ctx)
    if ctx.type == "round_start_bonus" then
      tag:yep("+", G.C.RED, function()
        ease_discard(self.config.discard, true)
        return true
      end)
      tag.triggered = true
      return true
    end
  end,
}
