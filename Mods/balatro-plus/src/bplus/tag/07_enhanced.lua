return {
  loc_vars = function(_, infoq, tag)
    local mod = tag and tag.ability.bplus_enhanced_tag_mod
    if mod then
      infoq[#infoq + 1] = G.P_CENTERS[mod]
    end
    return {
      vars = {
        mod and localize { type = "name_text", set = "Enhanced", key = mod } or "[enhancement]",
      },
    }
  end,

  set_ability = function(self, tag)
    tag.ability.bplus_enhanced_tag_mod = SMODS.poll_enhancement {
      guaranteed = true,
      type_key = "tag_bplus_enhanced_mod",
    }
  end,

  apply = function(self, tag, ctx)
    if ctx.type == "hand_drawn" and ctx.first_hand then
      tag:yep("+", G.C.PURPLE, function()
        local mod = G.P_CENTERS[tag.ability.bplus_enhanced_tag_mod]
        for _, card in ipairs(G.hand.cards) do
          G.E_MANAGER:add_event(Event {
            trigger = "after",
            delay = 0.1,
            func = function()
              card:flip()
              play_sound("card1")
              card:juice_up(0.3, 0.3)
              return true
            end,
          })
        end

        for _, card in ipairs(G.hand.cards) do
          G.E_MANAGER:add_event(Event {
            trigger = "after",
            delay = 0.2,
            func = function()
              card:set_ability(mod)
              return true
            end,
          })
        end

        for i, card in ipairs(G.hand.cards) do
          local percent = 0.85 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
          G.E_MANAGER:add_event(Event {
            trigger = "after",
            delay = 0.5,
            func = function()
              card:flip()
              play_sound("tarot2", percent, 0.6)
              card:juice_up(0.3, 0.3)
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
