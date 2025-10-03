return {
 SMODS.Joker {
    key = 'garb777',
    loc_txt = {
      name = 'Garb',
      text = {
      "On {C:attention}first hand{} of round,",
        "all listed probabilities are",
        "{C:green}guaranteed"
      },
      unlock = {
        "{E:1,s:1.3}?????"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {} },
    rarity = 4,
    atlas = 'GarbJokers',
    pos = { x = 4, y = 0 },
    
    -- soul_pos sets the soul sprite, only used in vanilla for legenedaries and Hologram.
    soul_pos = { x = 5, y = 0 },
    cost = 20,
    
      unlocked = false, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = false, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = false, --can it be perishable
  
        add_to_deck = function(self, card)
        check_for_unlock({ type = "discover_garb777" })
      end,
  
     calculate = function(self, card, context)
     
      if context.first_hand_drawn and G.GAME.current_round.hands_played == 0 then
              for k, v in pairs(G.GAME.probabilities) do 
                  G.GAME.probabilities[k] = 777777
              end
      end
      
      if context.end_of_round or context.after then
              for k, v in pairs(G.GAME.probabilities) do 
                  G.GAME.probabilities[k] = 1
              end
      end
      
    end,
    
      remove_from_deck = function(self, card, from_debuff)
      -- Adds - instead of +, so they get subtracted when this card is removed.
              for k, v in pairs(G.GAME.probabilities) do 
                  G.GAME.probabilities[k] = 1
              end
    end
  },
  
  }