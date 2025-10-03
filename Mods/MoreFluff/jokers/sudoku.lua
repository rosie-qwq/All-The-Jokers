local joker = {
  name = "Sudoku",
  config = {
    my_x_mult = 5, -- if i just have x_mult smods automatically picks it up. thanks smods!
    extra = {
      0, 0, 0, 0, 0, 0, 0, 0, 0
    }
  },
  pos = {x = 8, y = 7},
  rarity = 2,
  cost = 9,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = true,
  loc_vars = function(self, info_queue, center)
    local funny = function(val) return (val > 0) and G.C.FILTER or G.C.UI.TEXT_INACTIVE end
    return {
      vars = { center.ability.my_x_mult,
        colours = {
          funny(center.ability.extra[1]),funny(center.ability.extra[2]),funny(center.ability.extra[3]),
          funny(center.ability.extra[4]),funny(center.ability.extra[5]),funny(center.ability.extra[6]),
          funny(center.ability.extra[7]),funny(center.ability.extra[8]),funny(center.ability.extra[9]),
        }
      },
    }
  end,
  calculate = function(self, card, context)
    if context.end_of_round and context.cardarea == G.jokers and not context.blueprint and not context.repetition and G.GAME.blind.boss then
      card.ability.extra = {0,0,0,0,0,0,0,0,0}
      return {
        message = localize('k_reset'),
        colour = G.C.RED,
        card = card
      }
    end
    if context.individual and context.cardarea == G.play and not context.blueprint and not context.repetition then
      local rank = context.other_card:get_id()
      if rank == 14 then rank = 1 end

      if rank >= 1 and rank <= 9 then
        if card.ability.extra[rank] == 0 then
          card.ability.extra[rank] = 1
          return {
            message = localize("k_noted_ex")
          }
        end
      end
    end
    if context.cardarea == G.jokers and context.joker_main then
      local okay = true
      for k, v in ipairs(card.ability.extra) do
        if v == 0 then 
          okay = false
          break
        end
      end
      if okay then
        return {
          xmult = card.ability.my_x_mult,
        }
      end
    end
    if context.forcetrigger then
      return {
        xmult = card.ability.my_x_mult,
      }
    end
  end
}

if JokerDisplay then
  JokerDisplay.Definitions["j_mf_sudoku"] = {
    text = {
      {
        border_nodes = {
          { text = "X" },
          { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" },
        },
      }
    },
    reminder_text = {
      { ref_table = "card.joker_display_values", ref_value = "1_on", colour = G.C.FILTER },
      { ref_table = "card.joker_display_values", ref_value = "1_off", colour = G.C.UI.TEXT_INACTIVE },
      { ref_table = "card.joker_display_values", ref_value = "2_on", colour = G.C.FILTER },
      { ref_table = "card.joker_display_values", ref_value = "2_off", colour = G.C.UI.TEXT_INACTIVE },
      { ref_table = "card.joker_display_values", ref_value = "3_on", colour = G.C.FILTER },
      { ref_table = "card.joker_display_values", ref_value = "3_off", colour = G.C.UI.TEXT_INACTIVE },
      { ref_table = "card.joker_display_values", ref_value = "4_on", colour = G.C.FILTER },
      { ref_table = "card.joker_display_values", ref_value = "4_off", colour = G.C.UI.TEXT_INACTIVE },
      { ref_table = "card.joker_display_values", ref_value = "5_on", colour = G.C.FILTER },
      { ref_table = "card.joker_display_values", ref_value = "5_off", colour = G.C.UI.TEXT_INACTIVE },
      { ref_table = "card.joker_display_values", ref_value = "6_on", colour = G.C.FILTER },
      { ref_table = "card.joker_display_values", ref_value = "6_off", colour = G.C.UI.TEXT_INACTIVE },
      { ref_table = "card.joker_display_values", ref_value = "7_on", colour = G.C.FILTER },
      { ref_table = "card.joker_display_values", ref_value = "7_off", colour = G.C.UI.TEXT_INACTIVE },
      { ref_table = "card.joker_display_values", ref_value = "8_on", colour = G.C.FILTER },
      { ref_table = "card.joker_display_values", ref_value = "8_off", colour = G.C.UI.TEXT_INACTIVE },
      { ref_table = "card.joker_display_values", ref_value = "9_on", colour = G.C.FILTER },
      { ref_table = "card.joker_display_values", ref_value = "9_off", colour = G.C.UI.TEXT_INACTIVE },
    },
		calc_function = function(card)
      local okay = true
      for i, v in ipairs(card.ability.extra) do
        local num = i..""
        if i == 1 then num = "A" end
        local on = i.."_on"
        local off = i.."_off"

        card.joker_display_values[on] = (v >= 1) and num or ""
        card.joker_display_values[off] = (v == 0) and num or ""

        if v == 0 then okay = false end
      end
      card.joker_display_values.x_mult = okay and card.ability.my_x_mult or 1
		end,
  }
end

return joker
