return {
  config = { extra = 3 },

  loc_vars = function(self, infoq, card)
    infoq[#infoq + 1] = { key = "eternal", set = "Other" }
    infoq[#infoq + 1] = { key = "rental", set = "Other", vars = { G.GAME.rental_rate or 1 } }
    return { vars = { G.GAME.probabilities.normal, card.ability.extra } }
  end,

  can_use = function(self, card)
    for _, joker in ipairs(G.jokers.cards) do
      if not joker.edition and not joker.ability.eternal then
        return true
      end
    end
    return false
  end,

  use = function(self, card)
    local _edition = pseudorandom("c_bplus_sigil_curse_chance") <= G.GAME.probabilities.normal / card.ability.extra
    local compat_jokers = {}
    for _, joker in ipairs(G.jokers.cards) do
      if not joker.edition and not joker.ability.eternal then
        compat_jokers[#compat_jokers + 1] = joker
      end
    end

    local joker = pseudorandom_element(compat_jokers, pseudoseed("c_bplus_sigil_curse_joker"))
    if _edition then
      local edition = BPlus.u.poll_edition("c_bplus_sigil_curse_edition")
      joker:set_edition(edition, true)
    else
      joker:set_eternal(true)
      joker:set_rental(true)
    end
    card:juice_up(0.3, 0.5)
    joker:juice_up(0.2, 0.3)
  end,
}
