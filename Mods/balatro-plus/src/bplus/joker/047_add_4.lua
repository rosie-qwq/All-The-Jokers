return {
  rarity = 1,
  cost = 5,

  blueprint_compat = true,

  calculate = function(_, card, ctx)
    if ctx.first_hand_drawn then
      card_eval_status_text(ctx.blueprint_card or card, "extra", nil, nil, nil, {
        message = localize { type = "variable", key = "k_bplus_draw_ex", vars = { 4 } },
      })
      for _ = 1, 4 do
        draw_card(G.deck, G.hand, nil, "up", true)
      end
    end
  end,
}
