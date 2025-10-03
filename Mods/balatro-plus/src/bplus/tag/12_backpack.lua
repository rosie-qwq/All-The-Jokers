return {
  loc_vars = function(_, infoq)
    infoq[#infoq + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
  end,

  apply = function(self, tag, ctx)
    if ctx.type == "immediate" then
      tag:yep("+", G.C.DARK_EDITION, function()
        for i = 1, #G.consumeables.cards do
          local card = G.consumeables.cards[i]
          G.E_MANAGER:add_event(Event {
            trigger = "after",
            delay = math.max(0.1 - (0.002 * i), 0.01),
            func = function()
              local copy = copy_card(card, nil)
              copy:set_edition({ negative = true }, true)
              copy:add_to_deck()
              G.consumeables:emplace(copy)
              return true
            end,
          })
        end
        return true
      end)
      tag.triggered = true
      return true
    end
  end,
}
