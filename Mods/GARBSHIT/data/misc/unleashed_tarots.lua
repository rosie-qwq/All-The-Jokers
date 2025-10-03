return {
SMODS.Consumable:take_ownership("c_fool", {
    loc_vars = function(self, info_queue, card)
      local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
      local last_tarot_planet = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
      local colour = (not fool_c or fool_c.name == 'The Fool') and G.C.RED or G.C.GREEN    
      local main_end = {
        {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
            {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                {n=G.UIT.T, config={text = ' '..last_tarot_planet..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
            }}
        }}
      }
      if not (not fool_c or fool_c.name == 'The Fool' or fool_c == nil) then
      -- info_queue[#info_queue+1] = {set = "Tarot", key = G.GAME.last_tarot_planet, specific_vars = { }} 
      info_queue[#info_queue+1] = G.P_CENTERS[G.GAME.last_tarot_planet]
      end  
      if next(find_joker("j_garb_scopacane")) then
        info_queue[#info_queue+1] = {set = "Other", key = "mega_fool", specific_vars = {last_tarot_planet}} 
      end  
      return { vars = {last_tarot_planet}, main_end = main_end }
    end
  }, true), 

  SMODS.Consumable:take_ownership("c_judgement", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_judgement", specific_vars = {}} 
      info_queue[#info_queue+1] = G.P_CENTERS.e_negative
      info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
      end
      return { vars = {  } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_hermit", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_hermit", specific_vars = {}} 
      end
      return { vars = { card.ability.extra } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_wheel_of_fortune", {
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.e_foil
      info_queue[#info_queue+1] = G.P_CENTERS.e_holo
      info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_wheel_of_fortune", specific_vars = {G.GAME.probabilities.normal}} 
      info_queue[#info_queue+1] = G.P_CENTERS.e_negative
      end
      return { vars = { G.GAME.probabilities.normal ,card.ability.extra } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_death", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_death", specific_vars = {}} 
      end
      return { vars = { card.ability.max_highlighted, card.ability.mod_conv } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_hanged_man", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_hangedman", specific_vars = {}} 
      end
      return { vars = { card.ability.max_highlighted, card.ability.remove_card } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_strength", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_strength", specific_vars = {}} 
      end
      return { vars = { card.ability.max_highlighted, card.ability.mod_conv } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_temperance", {
    loc_vars = function(self, info_queue, card)
        local _money = 0
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    _money = _money + G.jokers.cards[i].sell_cost
                end
            end
        end
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_temperance", specific_vars = {card.ability.extra, math.min(card.ability.extra, _money)}} 
      end
      return { vars = {card.ability.extra, math.min(card.ability.extra, _money)} }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_magician", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv}}}
      end
      info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
      return { vars = { card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv} } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_empress", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv}}} 
      end
      info_queue[#info_queue+1] = G.P_CENTERS.m_mult
      return { vars = { card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv} } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_tower", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv}}} 
      end
      info_queue[#info_queue+1] = G.P_CENTERS.m_stone
      return { vars = { card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv} } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_devil", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv}}} 
      end
      info_queue[#info_queue+1] = G.P_CENTERS.m_gold
      return { vars = { card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv} } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_heirophant", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv}}} 
      end
      info_queue[#info_queue+1] = G.P_CENTERS.m_bonus
      return { vars = { card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv} } }
    end
  }, true),


  SMODS.Consumable:take_ownership("c_lovers", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv}}} 
      end
      info_queue[#info_queue+1] = G.P_CENTERS.m_wild
      return { vars = { card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv} } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_chariot", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv}}} 
      end
      info_queue[#info_queue+1] = G.P_CENTERS.m_steel
      return { vars = { card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv} } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_justice", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_enhance", specific_vars = {card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv}}} 
      end
      info_queue[#info_queue+1] = G.P_CENTERS.m_glass
      return { vars = { card.ability.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv} } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_star", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_suiters", specific_vars = { card.ability.max_highlighted,  localize(card.ability.suit_conv, 'suits_plural'), colours = {G.C.SUITS[card.ability.suit_conv]} }}
      end
      return { vars = { card.ability.max_highlighted,  localize(card.ability.suit_conv, 'suits_plural'), colours = {G.C.SUITS[card.ability.suit_conv]} } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_sun", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_suiters", specific_vars = { card.ability.max_highlighted,  localize(card.ability.suit_conv, 'suits_plural'), colours = {G.C.SUITS[card.ability.suit_conv]} }}
      end
      return { vars = { card.ability.max_highlighted,  localize(card.ability.suit_conv, 'suits_plural'), colours = {G.C.SUITS[card.ability.suit_conv]} } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_moon", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_suiters", specific_vars = { card.ability.max_highlighted,  localize(card.ability.suit_conv, 'suits_plural'), colours = {G.C.SUITS[card.ability.suit_conv]} }}
      end
      return { vars = { card.ability.max_highlighted,  localize(card.ability.suit_conv, 'suits_plural'), colours = {G.C.SUITS[card.ability.suit_conv]} } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_world", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_suiters", specific_vars = { card.ability.max_highlighted,  localize(card.ability.suit_conv, 'suits_plural'), colours = {G.C.SUITS[card.ability.suit_conv]} }}
      end
      return { vars = { card.ability.max_highlighted,  localize(card.ability.suit_conv, 'suits_plural'), colours = {G.C.SUITS[card.ability.suit_conv]} } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_high_priestess", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_priestess", specific_vars = {}}
      info_queue[#info_queue+1] = {set = "Tag", key = "tag_meteor", specific_vars = {}}
      end
      return { vars = { card.ability.planets } }
    end
  }, true),

  SMODS.Consumable:take_ownership("c_emperor", {
    loc_vars = function(self, info_queue, card)
      if next(find_joker("j_garb_scopacane")) then
      info_queue[#info_queue+1] = {set = "Other", key = "mega_emperor", specific_vars = {}}
      end
      return { vars = { card.ability.tarots } }
    end
  }, true),
}