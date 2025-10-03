return {
 SMODS.Consumable {
    key = 'adjustment',
    set = 'Tarot',
    loc_txt = {
      name = 'Adjustment',
      text = {
        "Enhances {C:attention}#1#{}",
        "selected cards to",
        "{C:attention}#2#s"

}
    },
  
    atlas = 'GarbConsumables', pos = { x = 1, y = 1 },
  
      config = {extra = { max_highlighted = 2, enhancement = "Jump Card" }},
      
      loc_vars = function(self, info_queue, card)
          info_queue[#info_queue+1] = G.P_CENTERS.m_garb_jump
          if next(find_joker("j_garb_scopacane")) then
            info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.extra.max_highlighted, card.ability.extra.enhancement}}
            end      
          return { vars = { card.ability.extra.max_highlighted, card.ability.extra.enhancement }}
      end,
  
    can_use = function(self, card)
      if #G.hand.highlighted > 0 and #G.hand.highlighted < card.ability.extra.max_highlighted + 1 then return true else return false end
    end,
  
      use = function(self, card)
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
              play_sound('tarot1')
              card:juice_up(0.3, 0.5)
              return true end }))
          conversionTarot(G.hand.highlighted, 'm_garb_jump')    
          delay(0.6)
          return true
    end
  },

}