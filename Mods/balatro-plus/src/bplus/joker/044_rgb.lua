return {
  config = { extra = 24 },
  rarity = 1,

  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra } }
  end,

  calculate = function(_, card, ctx)
    if ctx.joker_main then
      local suits = 0

      for suit, _ in pairs(SMODS.Suits) do
        for _, c in ipairs(ctx.scoring_hand) do
          if c:is_suit(suit) then
            suits = suits + 1
            break
          end
        end
        if suits > 3 then
          return
        end
      end

      if suits == 3 then
        return {
          message = localize { type = "variable", key = "a_mult", vars = { card.ability.extra } },
          mult_mod = card.ability.extra,
          colour = G.C.MULT,
        }
      end
    end
  end,
}
