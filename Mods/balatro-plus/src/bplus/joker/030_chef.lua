return {
  config = { extra = 1 },
  rarity = 1,
  cost = 4,

  blueprint_compat = true,

  loc_vars = function(_, infoq)
    infoq[#infoq + 1] = { set = "Other", key = "bplus_food_jokers" }
  end,

  calculate = function(_, card, ctx)
    if ctx.setting_blind and not card.getting_sliced then
      local jokers_to_create = math.min(card.ability.extra, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
      if jokers_to_create < 1 then
        return
      end

      local keys = {}
      for key, center in pairs(G.P_CENTERS) do
        if center.bplus_food_joker then
          keys[#keys + 1] = key
        end
      end

      G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
      G.E_MANAGER:add_event(Event {
        func = function()
          for i = 1, jokers_to_create do
            local joker = BPlus.create_food_joker("j_bplus_chef_joker")
            joker:add_to_deck()
            G.jokers:emplace(joker)
            joker:start_materialize()
            G.GAME.joker_buffer = 0
          end
          return true
        end,
      })

      card_eval_status_text(ctx.blueprint_card or card, "extra", nil, nil, nil, {
        message = localize("k_plus_joker"),
        colour = G.C.BLUE,
      })
    end
  end,
}
