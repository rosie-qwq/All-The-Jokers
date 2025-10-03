return {
  rarity = 1,
  cost = 5,

  blueprint_compat = true,

  ---@param ctx CalcContext
  calculate = function(_, _, ctx)
    if ctx.joker_main then
      local total = 0
      for _, c in ipairs(ctx.full_hand) do
        local id = c:get_id()
        if c.debuff or c:is_face() or id < 2 or id > 10 then
          return
        end
        total = total + id
      end

      return {
        message = localize {
          type = "variable",
          key = "a_mult",
          vars = { total },
        },
        mult_mod = total,
      }
    end
  end,
}
