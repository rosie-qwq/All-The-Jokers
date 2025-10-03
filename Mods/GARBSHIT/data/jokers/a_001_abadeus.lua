return {
 SMODS.Joker {
    key = 'abadeus',
    loc_txt = {
      name = 'Abadeus',
      text = {
        "If current Blind is a {C:attention}Boss Blind{},",
        "add a random {C:attention}Enhancement{},",
        "{C:attention} Seal{} or {C:attention}Edition{} to each scored card"
      },
      unlock = {
        "{E:1,s:1.3}?????"
      }
    },
      unlocked = false, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
  
    config = { extra = {swag = true} },
    rarity = 4,
    atlas = 'GarbJokers',
    pos = { x = 1, y = 2 },
    
    -- soul_pos sets the soul sprite, only used in vanilla for legenedaries and Hologram.
    soul_pos = { x = 2, y = 2 },
    cost = 20,
    -- SMODS specific function, gives the returned value in dollars at the end of round, double checks that it's greater than 0 before returning.
    
    add_to_deck = function(self, card)
      check_for_unlock({ type = "discover_abadeus" })
    end,
  
      calculate = function(self, card, context)
  
      if context.joker_main and G.GAME.blind.boss then
              for k, v in ipairs(context.scoring_hand) do
                  local _abadeus = pseudorandom('abadeus', 1, 3)
          local triggered = false
                  
                  if _abadeus == 1 and not v.seal and not v.debuff  then
            triggered = true
                      G.E_MANAGER:add_event(Event({
                          func = function()
                              v:juice_up()
                              v:set_seal(SMODS.poll_seal({guaranteed = true}), nil, true)
                              return true
                          end
                      }))
                  end
                  
                  if _abadeus == 2 and not v.edition and not v.debuff then
            triggered = true
                      G.E_MANAGER:add_event(Event({
                          func = function()
                              v:juice_up()
                              v:set_edition(poll_edition("Abadeus", nil, true, true), true, true)
                              return true
                          end
                      }))
                  end
                  
                  if triggered == false and not v.debuff then
                  local new_enhancement = SMODS.poll_enhancement {
                      key = "abadeus",
                      guaranteed = true
                  }
                      G.E_MANAGER:add_event(Event({
                          func = function()
                              v:juice_up()
                              v:set_ability(G.P_CENTERS[new_enhancement])
                              return true
                          end
                      }))
                  end
              end	
          
              G.E_MANAGER:add_event(Event({
                  func = function()
                  play_sound('garb_abadeus1', 0.9 + math.random()*0.1, 0.8)
                      card:juice_up(0.3, 0.4)
                      return true
                  end
              }))
              
              return {
                  message = "Magic!",
                  card = card
              }
      end
    end
    
  },

  }