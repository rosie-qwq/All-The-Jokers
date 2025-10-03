return {
  rarity = 1,
  cost = 5,

  blueprint_compat = true,

  calculate = function(_, card, ctx)
    if ctx.hand_drawn then
      local steel_card
      for _, c in pairs(G.deck.cards) do
        if SMODS.has_enhancement(c, "m_steel") then
          steel_card = c
          break
        end
      end
      if steel_card then
        card_eval_status_text(ctx.blueprint_card or card, "extra", nil, nil, nil, {
          message = localize { type = "variable", key = "k_bplus_draw_ex", vars = { 1 } },
        })
        draw_card(G.deck, G.hand, nil, "up", true, steel_card)
        delay(0.5)
      end
    end
  end,
}
