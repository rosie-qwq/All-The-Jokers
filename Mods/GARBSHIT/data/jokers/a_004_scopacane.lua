return {
 SMODS.Joker {
    key = 'scopacane',
    loc_txt = {
      name = 'Scopacane',
      text = {
      "When hand is played, unleash",
        "the {C:dark_edition}True Arcana{} power of a",
        "random {C:tarot}Tarot{} in consumable area",
        "{C:inactive}(Unleashed {}{C:tarot}Tarots{}{C:inactive} are consumed){}"
      },
      unlock = {
        "{E:1,s:1.3}?????"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {} },
    rarity = 4,
    atlas = 'GarbJokers',
    pos = { x = 5, y = 3 },
    
    -- soul_pos sets the soul sprite, only used in vanilla for legenedaries and Hologram.
    soul_pos = { x = 6, y = 3 },
    cost = 20,
    
      unlocked = false, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = false, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = false, --can it be perishable
      
        add_to_deck = function(self, card)
        check_for_unlock({ type = "discover_scopacane" })
      end,
  
  
     calculate = function(self, card, context)
     
      local tarots = {}
      if context.before then
              for k, v in ipairs(G.consumeables.cards) do 
                if v.ability.set == "Tarot" then
                  tarots[#tarots + 1] = v
                end
              end
                local to_kill = pseudorandom('Scopacane', 1, #tarots)
                if #tarots == 0 then return nil end
  
                ut = tarots[to_kill]
  
                play_sound('garb_scopacane')
                ut:juice_up(0.3, 0.5)

                -- TARGET: Patch your Scopacane effects for custom tarots here

                local fool_c = G.GAME.last_tarot_planet or nil
                if ut.config.center.key == "c_fool" and fool_c ~= "c_fool" and fool_c ~= nil then
                  local _card = SMODS.create_card{key = G.GAME.last_tarot_planet}
                  _card:set_edition('e_negative', true)
                  _card:add_to_deck()
                  G.consumeables:emplace(_card)
                  local _card = SMODS.create_card{key = G.GAME.last_tarot_planet}
                  _card:set_edition('e_negative', true)
                  _card:add_to_deck()
                  G.consumeables:emplace(_card)
                elseif ut.config.center.key == "c_fool" and fool_c == nil then
                  return {
                    focus = ut,
                    message = "Not Copiable!",
                    colour = G.C.PURPLE
                    }
                end
  
                if ut.config.center.key == "c_hermit" then
                  ease_dollars(math.max(0,math.min(G.GAME.dollars, 50)), true)    
                end
  
                if ut.config.center.key == "c_high_priestess" then
                  add_tag(Tag('tag_meteor'))
                end
  
                if ut.config.center.key == "c_emperor" then
                    local _card = SMODS.create_card{set = 'Tarot'}
                    _card:set_edition('e_negative', true)
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    local _card = SMODS.create_card{set = 'Tarot'}
                    _card:set_edition('e_negative', true)
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                end
  
                if ut.config.center.key == "c_wheel_of_fortune" then
                  local eli = {}
                  for k, v in pairs(G.jokers.cards) do
                    if v.ability.set == 'Joker' and (not v.edition) then
                        table.insert(eli, v)
                    end
                  end  
                  if #eli ~= 0 then
                  local chosen = pseudorandom('Scopacane', 1, #eli)
                  alter = eli[chosen]
                    if pseudorandom('Scoparuota') < G.GAME.probabilities.normal/2 then
                      alter:set_edition(poll_edition("Scoparuota", nil, false, true, {"e_negative","e_polychrome"}))
                    else 	
                      ut:start_dissolve(nil, _first_dissolve)
                      return {
                      message = "Nope!",
                      colour = G.C.PURPLE
                      }
                    end
                  else return { message = "Nope!", colour = G.C.PURPLE } end
                end
  
                if ut.config.center.key == "c_temperance" then
                  local sell_cost = 0
                  for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= self and (G.jokers.cards[i].area and G.jokers.cards[i].area == G.jokers) then
                        sell_cost = sell_cost + G.jokers.cards[i].sell_cost
                    end
                  end
                  ease_dollars(sell_cost)
                end
  
                if ut.config.center.key == "c_hanged_man" then
                  for i = 1, #G.hand.cards do
                      local _card = G.hand.cards[i]
                      _card.destroyme = true
                      if SMODS.shatters(card) then
                        _card:shatter()
                      else
                      _card:start_dissolve(nil, _first_dissolve)
                      end
                  end
                end
  
                if ut.config.center.key == "c_strength" then
                  for i = 1, #context.scoring_hand do
                    local _card = context.scoring_hand[i]
                    if _card:is_face() then
                      _card:flip()
                      SMODS.change_base(_card, nil, 'King')
                    else 
                      _card:flip()
                      SMODS.change_base(_card, nil, '10')
                    end
                    _card:juice_up(0.3, 0.5)
                  end
                end
  
                if ut.config.center.key == "c_death" then
                    local _card = context.scoring_hand[#context.scoring_hand]
                    for i = 1, #context.scoring_hand-1 do
                      if i < 3 then
                      _card:flip()
                      copy_card(_card, context.scoring_hand[i])
                      context.scoring_hand[i]:juice_up(0.3, 0.5)
                      end
                    end
                end
  
                if ut.config.center.key == "c_judgement" then
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                  local new_card = SMODS.create_card{set = 'Joker'}
                  new_card:set_edition(poll_edition("Scoparuota", nil, false, true, {"e_negative","e_polychrome"}))
                  new_card:add_to_deck()
                  G.jokers:emplace(new_card)
                  else 	
                    return {
                    message = "Joker Slots Full!",
                    colour = G.C.PURPLE
                    }
                end
                end
  
                local enhancers = {"c_magician", "c_empress", "c_heirophant", "c_lovers", "c_chariot", "c_justice", "c_devil", "c_tower", "c_garb_hunger", "c_garb_hope", "c_garb_adjustment", "c_garb_art"}
                local enhancements = {G.P_CENTERS.m_lucky, G.P_CENTERS.m_mult, G.P_CENTERS.m_bonus, G.P_CENTERS.m_wild, G.P_CENTERS.m_steel, G.P_CENTERS.m_glass, G.P_CENTERS.m_gold, G.P_CENTERS.m_stone, G.P_CENTERS.m_garb_infected, G.P_CENTERS.m_garb_pure, G.P_CENTERS.m_garb_jump, G.P_CENTERS.m_garb_royal}
                for k, v in pairs(enhancers) do
                if ut.config.center.key == v then
                  for i = 1, #context.scoring_hand do
                    local _card = context.scoring_hand[i]
                    _card:flip()
                    _card:juice_up(0.3, 0.5)
                    _card:set_ability(enhancements[k], nil, true)
                    end
                end
                end
                
              local suiters = {"c_star", "c_moon", "c_sun", "c_world"}
              local suites = {"Diamonds", "Clubs", "Hearts", "Spades"}
              for k, v in pairs(suiters) do
                if ut.config.center.key == v then
                  for i = 1, #G.hand.cards do
                    local _card = G.hand.cards[i]
                    _card:flip()
                    _card:juice_up(0.3, 0.5)
                    SMODS.change_base(_card, suites[k], nil)
                  end
                end
              end
  
                G.GAME.last_tarot_planet = ut.config.center.key
                ut:start_dissolve(nil, _first_dissolve)
                card:juice_up(0.3, 0.4)
                return nil 
              end
  
              if context.individual and context.cardarea == G.play then
                  local _card = context.other_card
                  if _card.facing == 'back' then 
                    G.E_MANAGER:add_event(Event({
                      func = function() 
                        for i=1, #context.scoring_hand do
                            if context.scoring_hand[i] == _card then
                              if context.scoring_hand[no_retrigger] == _card then return true end
                                local percent = 0.85 + (i-0.99)/(#context.scoring_hand-0.98)*0.3
                                play_sound('tarot2', percent, 0.6)
                                no_retrigger = i
                                _card:flip()
                              end
                            end
                                  return true
                      end}))
                  end
              end
  
              if context.individual and context.cardarea == G.hand then
                local _card = context.other_card
                if _card.facing == 'back' then 
                  G.E_MANAGER:add_event(Event({
                    func = function() 
                      for i=1, #G.hand.cards do
                          if G.hand.cards[i] == _card then
                              if G.hand.cards[no_retrigger] == _card then return true end
                              local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
                              play_sound('tarot2', percent, 0.6)
                              no_retrigger = i
                              _card:flip()
                            end
                          end
                    return true
                    end}))
                end
            end
  
            if context.destroying_card and context.destroying_card.destroyme then
              return{
                  remove = true,
              }
          end
    end
  },
  
  }