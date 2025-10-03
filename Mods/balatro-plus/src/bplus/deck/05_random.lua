return {
  config = { min = -2, max = 3 },
  apply = function()
    G.E_MANAGER:add_event(Event {
      func = function()
        local vouchers = {}
        for key, center in pairs(G.P_CENTERS) do
          if center.set == "Voucher" then
            vouchers[#vouchers + 1] = key
          end
        end
        local voucher = get_next_voucher_key()
        G.GAME.used_vouchers[voucher] = true
        G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
        G.E_MANAGER:add_event(Event {
          func = function()
            Card.apply_to_run(nil, G.P_CENTERS[voucher])
            return true
          end,
        })

        SMODS.add_card {
          set = "Joker",
          area = G.jokers,
          rarity = "Common",
          key_append = "b_bplus_random_joker",
        }
        return true
      end,
    })
  end,

  calculate = function(_, back, ctx)
    if ctx.setting_blind then
      local hands = pseudorandom("b_bplus_random_hands", back.effect.config.min, back.effect.config.max)
      if G.GAME.round_resets.hands + hands > 0 then
        local hand_UI = G.HUD:get_UIE_by_ID("hand_UI_count")
        G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + hands
        G.HUD:recalculate()
        attention_text {
          text = "???",
          scale = 0.8,
          hold = 0.7,
          cover = hand_UI.parent,
          cover_colour = G.C.BLUE,
          align = "cm",
        }
        play_sound("chips2")
      end
    end
  end,
}
