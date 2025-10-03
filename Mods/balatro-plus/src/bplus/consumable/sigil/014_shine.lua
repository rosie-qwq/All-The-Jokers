function BPlus.round_vars.shine_sigil_edition(v, init)
  if init then
    return "polychrome"
  end

  return BPlus.u.poll_edition("c_bplus_sigil_shine_edition" .. G.GAME.round_resets.ante, true)
end

return {
  loc_vars = function(_, infoq)
    local edition = G.GAME.current_round.bplus_shine_sigil_edition
    infoq[#infoq + 1] = G.P_CENTERS[edition]
    return { vars = { localize { type = "name_text", key = edition, set = "Edition" } } }
  end,

  can_use = function(self)
    return G.hand and #G.hand.highlighted == 1
  end,

  use = function(self, card)
    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.4,
      func = function()
        G.hand.highlighted[1]:set_edition(G.GAME.current_round.bplus_shine_sigil_edition, true)
        card:juice_up(0.3, 0.5)
        return true
      end,
    })
  end,
}
