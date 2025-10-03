local function get_level_up_amount(hand)
  hand = hand or BPlus.u.most_played_poker_hand()
  local amount = 0
  if hand then
    for name, info in pairs(G.GAME.hands) do
      if name ~= hand then
        amount = amount + info.level - 1
      end
    end
  end
  return amount
end

return {
  loc_vars = function(self, _, card)
    return { vars = { get_level_up_amount() } }
  end,

  can_use = function(self, card)
    return get_level_up_amount() > 0
  end,

  use = function(self, card)
    local hand = BPlus.u.most_played_poker_hand()
    local amount = get_level_up_amount(hand)
    update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
      handname = "Other hands",
      chips = "...",
      mult = "...",
      level = "",
    })

    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.2,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.8, 0.5)
        G.TAROT_INTERRUPT_PULSE = true
        return true
      end,
    })

    update_hand_text({ delay = 0 }, { mult = "-", StatusText = true })
    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.9,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.8, 0.5)
        return true
      end,
    })

    update_hand_text({ delay = 0 }, { chips = "-", StatusText = true })
    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.9,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.8, 0.5)
        G.TAROT_INTERRUPT_PULSE = nil
        return true
      end,
    })

    update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "1" })
    delay(1)
    for handname, info in pairs(G.GAME.hands) do
      if handname ~= hand then
        level_up_hand(card, handname, true, -info.level + 1)
      end
    end

    update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.5 }, {
      handname = localize(hand, "poker_hands"),
      chips = G.GAME.hands[hand].chips,
      mult = G.GAME.hands[hand].mult,
      level = G.GAME.hands[hand].level,
    })
    level_up_hand(card, hand, false, amount)

    delay(0.2)
    update_hand_text({ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 }, { mult = 0, chips = 0, handname = "", level = "" })
  end,
}
