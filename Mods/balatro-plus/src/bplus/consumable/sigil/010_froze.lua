return {
  config = { extra = 5 },

  loc_vars = function(self, infoq, card)
    infoq[#infoq + 1] = G.P_CENTERS.e_negative
    return { vars = { card.ability.extra } }
  end,

  can_use = function(self)
    local joker = G.jokers.highlighted[1]
    return joker and not joker.edition and not joker.ability.perishable and not joker.ability.bplus_debuffed_by_sigil_froze
  end,

  use = function(self, card)
    local joker = G.jokers.highlighted[1]
    joker.ability.bplus_debuffed_by_sigil_froze = card.ability.extra

    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.2,
      func = function()
        joker:juice_up(0.3, 0.3)
        joker:set_debuff(true)
        card:juice_up(0.3, 0.5)
        play_sound("tarot1")
        return true
      end,
    })
  end,
}
