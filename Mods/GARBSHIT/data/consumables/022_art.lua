return {
 SMODS.Consumable {
    key = 'art',
    set = 'Tarot',
    loc_txt = {
      name = 'Art',
      text = {
        "Enhances {C:attention}#1#{} selected",
        "card into a",
        "{C:attention}#2#"
}
    },
  
    atlas = 'GarbConsumables', pos = { x = 2, y = 1 },
  
      config = {extra = { max_highlighted = 1, enhancement = "Royal Card" }},
      
      loc_vars = function(self, info_queue, card)
          info_queue[#info_queue+1] = G.P_CENTERS.m_garb_royal
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
          conversionTarot(G.hand.highlighted, 'm_garb_royal')    
          delay(0.6)
          return true
    end
  },

  
  }