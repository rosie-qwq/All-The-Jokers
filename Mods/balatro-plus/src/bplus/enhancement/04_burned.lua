return {
  config = { Xmult = 1.5 },

  loc_vars = function(self)
    return { vars = { self.config.Xmult } }
  end,

  calculate = function(self, card, ctx)
    if ctx.end_of_round and ctx.cardarea == G.hand and not ctx.repetition and ctx.playing_card_end_of_round then
      local left, right
      for i, c in ipairs(ctx.cardarea.cards) do
        if c == card then
          left = ctx.cardarea.cards[i - 1]
          right = ctx.cardarea.cards[i + 1]

          if left and BPlus.u.getting_destroyed(left) then
            left = nil
          end
          if right and BPlus.u.getting_destroyed(right) then
            right = nil
          end
          break
        end
      end

      card.destroyed = true
      card.burned = true
      if left or right then
        card_eval_status_text(card, "extra", nil, nil, nil, {
          message = localize("k_bplus_burn_ex"),
          colour = G.C.ORANGE,
        })

        G.E_MANAGER:add_event(Event {
          trigger = "after",
          func = function()
            if left then
              left:juice_up(0.5, 0.5)
              left:set_ability(self)
            end
            if right then
              right:juice_up(0.5, 0.5)
              right:set_ability(self)
            end
            card:start_dissolve({ G.C.RED, G.C.ORANGE }, nil, 1.6)
            return true
          end,
        })
      end
      delay(0.6)
    end
  end,
}
