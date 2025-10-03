local function set_edition(tag, joker)
  local edition = BPlus.u.poll_edition("tag_bplus_glow_edition")
  joker._edition = edition
  tag:yep("+", G.C.DARK_EDITION, function()
    joker:set_edition(edition, true)
    joker._edition = nil
    return true
  end)
  tag.triggered = true
end

return {
  min_ante = 3,

  apply = function(_, tag, ctx)
    if ctx.type == "immediate" then
      local jokers = {}
      for _, j in ipairs(G.jokers.cards) do
        if not j.edition and not j._edition then
          jokers[#jokers + 1] = j
        end
      end

      if next(jokers) then
        local joker = pseudorandom_element(jokers, pseudoseed("tag_bplus_glow_joker"))
        set_edition(tag, joker)
        return true
      end
    elseif ctx.type == "card_added" and ctx.cardarea == G.jokers then
      if not ctx.card.edition and not ctx.card._edition then
        set_edition(tag, ctx.card)
        return true
      end
    end
  end,
}
