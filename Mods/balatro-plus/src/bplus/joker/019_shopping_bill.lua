return {
  config = { extra = 4 },
  rarity = 1,
  cost = 5,

  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return { vars = { G.GAME.probabilities.normal, card.ability.extra } }
  end,

  calculate = function(_, card, ctx)
    if ctx.end_of_round and ctx.individual and ctx.cardarea == G.hand then
      local id = ctx.other_card:get_id()
      if id > 1 and id < 11 and pseudorandom("j_bplus_shopping_bill_money") <= G.GAME.probabilities.normal / card.ability.extra then
        if ctx.other_card.debuff then
          return {
            message = localize("k_debuffed"),
            colour = G.C.RED,
            card = card,
          }
        else
          G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + id
          G.E_MANAGER:add_event(Event {
            func = function()
              G.GAME.dollar_buffer = 0
              return true
            end,
          })
          return {
            dollars = id,
            card = card,
          }
        end
      end
    end
  end,
}
