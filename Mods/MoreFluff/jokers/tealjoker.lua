if not mf_config["45 Degree Rotated Tarot Cards"] then
  return nil
end
local joker = {
  name = "Teal Joker",
  config = {
    extra = {x_chips_per = 0.2, teal_tally = 0}
  },
  pos = {x = 4, y = 5},
  rarity = 2,
  cost = 7,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  enhancement_gate = "m_mf_teal",
  demicoloncompat = true,
  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN then
      card.ability.extra.teal_tally = 0
      for k, v in pairs(G.playing_cards) do
        if SMODS.has_enhancement(v, "m_mf_teal") then card.ability.extra.teal_tally = card.ability.extra.teal_tally+1 end
      end
    else
      card.ability.extra.teal_tally = 0
    end
  end,
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_teal

    return {
      vars = { center.ability.extra.x_chips_per, 1 + center.ability.extra.x_chips_per * center.ability.extra.teal_tally }
    }
  end,
  calculate = function(self, card, context)
    if (context.forcetrigger or (context.cardarea == G.jokers and context.joker_main)) and card.ability.extra.teal_tally > 0 then
      return {
        xchips = 1 + card.ability.extra.x_chips_per*card.ability.extra.teal_tally,
      }
    end
  end
}

if JokerDisplay then
  JokerDisplay.Definitions["j_mf_tealjoker"] = {
    text = {
      {
        border_nodes = {
          { text = "X" },
          { ref_table = "card.joker_display_values", ref_value = "xchips", retrigger_type = "exp" },
        },
        border_colour = G.C.CHIPS
      }
    },
    calc_function = function(card)
      card.joker_display_values.xchips = 1 + card.ability.extra.teal_tally * card.ability.extra.x_chips_per
    end,
  }
end

return joker