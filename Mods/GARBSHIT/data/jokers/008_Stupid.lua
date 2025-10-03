return {
 SMODS.Joker {
    key = 'Stupid',
    loc_txt = {
      name = 'Stupid Joker',
      text = {
        "Consumes {C:attention}lead{} from Steel Cards",
        "Gains {C:chips}+#2#{} Chips",
        "every time {C:attention}lead{} is consumed",
        "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"	  
      }
    },
    config = { extra = { chips = 0, chip_gain = 25 } },
    rarity = 1,
    atlas = 'GarbJokers',
    pos = { x = 4, y = 2 },
    cost = 3,
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.m_steel
      return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain } }
    end,
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
    calculate = function(self, card, context)
    
      if context.joker_main then
        return {
          chip_mod = card.ability.extra.chips,
          message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
        }
      end
  
      if context.individual and context.cardarea == G.play and not context.blueprint then
                          for i = 1, #context.scoring_hand do
                              local _card = context.other_card
                              if _card.ability.name == 'Steel Card' then
                                  _card:juice_up()
                                  colour = G.C.CHIPS
                                  card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
                                  _card:set_ability(G.P_CENTERS.c_base, G.P_CENTERS.c_steel, true)
                                  return {
                                      message = "lead consumed!",
                                  card = card
                                  }
                              end
                          end
  
      end
  end
  },
  
  }