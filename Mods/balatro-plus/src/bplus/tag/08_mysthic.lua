return {
  apply = function(_, tag, ctx)
    if ctx.type == "immediate" then
      tag:yep("+", G.C.SECONDARY_SET.sigil, function()
        BPlus.u.open_pack("p_bplus_mysthic_mega", true)
        return true
      end)
      tag.triggered = true
      return true
    end
  end,
}
