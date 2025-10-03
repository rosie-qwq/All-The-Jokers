return {
  requires = { "v_bplus_dash" },

  calculate = function(_, _, ctx)
    if ctx.skip_blind then
      local jokers = {}
      for _, joker in ipairs(G.jokers.cards) do
        if not joker.edition then
          jokers[#jokers + 1] = joker
        end
      end

      if next(jokers) then
        local joker = pseudorandom_element(jokers, pseudoseed("v_bplus_rainbow_joker"))
        local edition = BPlus.u.poll_edition("v_bplus_rainbow_edition")
        joker:set_edition(edition, true)
      end
    end
  end,
}
