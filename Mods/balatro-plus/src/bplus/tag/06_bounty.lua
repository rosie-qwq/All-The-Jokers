return {
  config = { reward = 4, bplus_eval_atlas = "bplus_tag" },

  loc_vars = function(self)
    return { vars = { self.config.reward } }
  end,

  apply = function(self, tag, ctx)
    if ctx.type == "eval" then
      tag:yep("+", G.C.MONEY, function()
        return true
      end)
      tag.triggered = true
      return {
        dollars = G.GAME.blind.dollars * self.config.reward,
        condition = localize("ph_bplus_defeat_the_blind"),
        pos = tag.pos,
        tag = tag,
      }
    end
  end,
}
