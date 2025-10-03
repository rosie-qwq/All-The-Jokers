return {
  config = { extra = false },
  rarity = 2,
  cost = 6,

  blueprint_compat = false,

  loc_vars = function(_, _, card)
    local main_end = {
      {
        n = G.UIT.C,
        config = { align = "bm", minh = 0.4 },
        nodes = {
          {
            n = G.UIT.C,
            config = {
              align = "m",
              colour = card.ability.extra and G.C.GREEN or G.C.RED,
              r = 0.05,
              padding = 0.06,
            },
            nodes = {
              { n = G.UIT.B, config = { w = 0.1, h = 0.1 } },
              {
                n = G.UIT.T,
                config = {
                  text = card.ability.extra and "active" or "inactive",
                  colour = G.C.UI.TEXT_LIGHT,
                  scale = 0.32 * 0.8,
                },
              },
              { n = G.UIT.B, config = { w = 0.1, h = 0.1 } },
            },
          },
        },
      },
    }
    return { main_end = main_end }
  end,

  calculate = function(_, card, ctx)
    if ctx.before and not card.ability.extra then
      local clubs = 0
      for _, c in ipairs(ctx.full_hand) do
        if c:is_suit("Clubs") then
          clubs = clubs + 1
        end
      end
      if clubs == 4 then
        for k, v in pairs(G.GAME.probabilities) do
          G.GAME.probabilities[k] = v * 4
        end

        card.ability.extra = true
        return {
          message = localize("k_active_ex"),
          colour = G.C.GREEN,
        }
      end
    elseif ctx.end_of_round and G.GAME.blind.boss and not ctx.individual and not ctx.repetition and card.ability.extra then
      for k, v in pairs(G.GAME.probabilities) do
        G.GAME.probabilities[k] = v / 4
      end

      card.ability.extra = false
      return {
        message = localize("k_bplus_inactive_ex"),
        colour = G.C.RED,
      }
    end
  end,
}
