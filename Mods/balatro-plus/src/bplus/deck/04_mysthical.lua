return {
  apply = function()
    G.GAME.starting_params.boosters_in_shop = G.GAME.starting_params.boosters_in_shop - 1
    change_shop_size(-1)
  end,

  calculate = function(_, _, ctx)
    if ctx.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.E_MANAGER:add_event(Event {
        trigger = "after",
        func = function()
          SMODS.add_card {
            set = "sigil",
            area = G.consumeables,
            key_append = "b_bplus_mysthical_sigil",
            skip_materialize = true,
          }
          play_sound("tarot1")
          G.GAME.consumeable_buffer = 0
          return true
        end,
      })
    end
  end,
}
