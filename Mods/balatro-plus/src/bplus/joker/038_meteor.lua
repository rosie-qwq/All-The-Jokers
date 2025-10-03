local function get_poker_hand()
  local poker_hands = {}
  local total_weight = 0
  for _, handname in ipairs(G.handlist) do
    if G.GAME.hands[handname].visible then
      local weight = G.GAME.hands[handname].played + 1
      total_weight = total_weight + weight
      poker_hands[#poker_hands + 1] = { handname, total_weight }
    end
  end

  local weight = pseudorandom("j_bplus_meteor_hand") * total_weight
  local hand
  for _, h in ipairs(poker_hands) do
    if weight < h[2] then
      hand = h[1]
      break
    end
  end

  return hand
end

return {
  rarity = 1,
  cost = 5,

  blueprint_compat = true,

  calculate = function(_, card, ctx)
    if ctx.setting_blind and not card.getting_sliced then
      local hand = get_poker_hand()
      card_eval_status_text(card, "extra", nil, nil, nil, {
        message = localize("k_level_up_ex"),
        colour = G.C.GREEN,
      })

      update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
        handname = localize(hand, "poker_hands"),
        chips = G.GAME.hands[hand].chips,
        mult = G.GAME.hands[hand].mult,
        level = G.GAME.hands[hand].level,
      })

      level_up_hand(card, hand)

      delay(0.1)
      update_hand_text({ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 }, { mult = 0, chips = 0, handname = "", level = "" })
    end
  end,
}
