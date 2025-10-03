return {
  loc_vars = function(self, infoq)
    infoq[#infoq + 1] = G.P_CENTERS.e_negative
  end,

  can_use = function(self, card)
    local compat = 0
    for _, joker in ipairs(G.jokers.cards) do
      if not joker.ability.eternal and not (joker.edition and joker.edition.negative) then
        compat = compat + 1
      end
    end
    return compat > 0
  end,

  use = function(self, card)
    local rarities = {}
    local destroyed_cards = {}
    play_sound("slice1", 0.96 + math.random() * 0.08)
    for _, joker in ipairs(G.jokers.cards) do
      if not joker.ability.eternal and not (joker.edition and joker.edition.negative) then
        rarities[#rarities + 1] = joker.config.center.rarity
        destroyed_cards[#destroyed_cards + 1] = joker
      end
    end

    BPlus.u.joker_destroyed_trigger(destroyed_cards)
    G.E_MANAGER:add_event(Event {
      func = function()
        for _, joker in ipairs(destroyed_cards) do
          joker:start_dissolve()
        end
        return true
      end,
    })

    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.5,
      func = function()
        play_sound("timpani")
        for _, rarity in ipairs(rarities) do
          SMODS.add_card {
            set = "Joker",
            area = G.jokers,
            legendary = rarity == 4 or nil,
            rarity = rarity ~= 4 and (({ "Common", "Uncommon", "Rare" })[rarity] or rarity) or nil,
            key_append = "c_bplus_sigil_rebirth_joker",
          }
        end
        card:juice_up(0.3, 0.5)
        return true
      end,
    })
  end,
}
