return {
  modify_effect = function(_, _, ctx, effect)
    if ctx.cardarea == G.play and ctx.main_scoring and not ctx.repetition and (effect.mult or effect.chips) then
      local balanced = ((effect.chips or 0) + (effect.mult or 0)) / 2
      if balanced > 0 then
        effect.chips = balanced
        effect.mult = balanced
      end
    end
  end,
}
