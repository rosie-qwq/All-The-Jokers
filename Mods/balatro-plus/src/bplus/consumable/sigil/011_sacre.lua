return {
  config = { extra = 6 },

  loc_vars = function(self, _, card)
    return { vars = { card.ability.extra } }
  end,

  can_use = function(self, card)
    return G.hand and #G.hand.cards > card.ability.extra and #G.jokers.cards < G.jokers.config.card_limit
  end,

  use = function(self, card)
    local temp_hand = {}
    local destroyed_cards = {}
    for _, v in ipairs(G.hand.cards) do
      temp_hand[#temp_hand + 1] = v
    end
    table.sort(temp_hand, function(a, b)
      return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
    end)
    pseudoshuffle(temp_hand, pseudoseed("c_bplus_sigil_sacre_destroys"))

    for i = 1, card.ability.extra do
      destroyed_cards[#destroyed_cards + 1] = temp_hand[i]
    end

    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.4,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.3, 0.5)
        return true
      end,
    })

    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.1,
      func = function()
        for i = #destroyed_cards, 1, -1 do
          local c = destroyed_cards[i]
          if c.ability.name == G.P_CENTERS.m_glass.name then
            c:shatter()
          else
            c:start_dissolve(nil, i == #destroyed_cards)
          end
        end

        return true
      end,
    })

    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.2,
      func = function()
        SMODS.add_card {
          set = "Joker",
          area = G.jokers,
          rarity = "Rare",
          key_append = "c_bplus_sigil_sacre",
        }
        return true
      end,
    })

    for i = 1, #G.jokers.cards do
      G.jokers.cards[i]:calculate_joker { remove_playing_cards = true, removed = destroyed_cards }
    end
  end,
}
