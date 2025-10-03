return {
  loc_vars = function(self, infoq, card)
    local last_card = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
    local last_card_text = last_card and localize { type = "name_text", key = last_card.key, set = last_card.set } or localize("k_none")
    local colour = (not last_card) and G.C.RED or G.C.GREEN
    if last_card then
      infoq[#infoq + 1] = last_card
    end

    return {
      main_end = {
        {
          n = G.UIT.C,
          config = { align = "bm", padding = 0.02 },
          nodes = {
            {
              n = G.UIT.C,
              config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = " " .. last_card_text .. " ",
                    colour = G.C.UI.TEXT_LIGHT,
                    scale = 0.3,
                    shadow = true,
                  },
                },
              },
            },
          },
        },
      },
    }
  end,

  can_use = function(self, card)
    return #G.consumeables.cards - (card.area == G.consumeables and 1 or 0) > 0 and G.GAME.last_tarot_planet
  end,

  use = function(self, card)
    for _, c in ipairs(G.consumeables.cards) do
      G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0.1,
        func = function()
          c:start_dissolve()
          return true
        end,
      })
    end

    for i = 1, G.consumeables.config.card_limit do
      G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0.2,
        func = function()
          local last_card = create_card("Tarot_Planet", G.consumeables, nil, nil, nil, nil, G.GAME.last_tarot_planet, "c_bplus_sigil_rewind_card")
          last_card:add_to_deck()
          G.consumeables:emplace(last_card)
          card:juice_up(0.3, 0.5)
          return true
        end,
      })
    end
  end,
}
