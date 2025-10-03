return {
  loc_vars = function(_, infoq)
    infoq[#infoq + 1] = { set = "Other", key = "bplus_food_jokers" }
  end,

  apply = function(_, tag, ctx)
    if ctx.type == "immediate" then
      tag:yep("+", G.C.ORANGE, function()
        if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
          local card = BPlus.create_food_joker("tag_bplus_dish_joker")
          card:add_to_deck()
          G.jokers:emplace(card)
        end
        return true
      end)
      tag.triggered = true
      return true
    end
  end,
}
