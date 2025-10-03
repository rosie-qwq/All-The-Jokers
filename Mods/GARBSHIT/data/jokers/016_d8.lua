return {
 SMODS.Joker {
    key = 'd8',
    loc_txt = {
      name = 'Fluorite Octet',
      text = {
        "If played hand contains an {C:attention}8{},",
        "{C:green}#3# in #2#{} chance to",
        "give {X:mult,C:white} X#1# {} Mult"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {Xmult = 8, odds = 8} },
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 1, y = 3 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 4,
      loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult,card.ability.extra.odds, G.GAME.probabilities.normal} }
    end,
      
     calculate = function(self, card, context)
  
      if context.joker_main then
          local eight = 0
          for i = 1, #context.scoring_hand do
              if context.scoring_hand[i]:get_id() == 8 then
                  eight = 1
              end
          end
          
          if eight == 1 and pseudorandom('HUGE8ITCH') < G.GAME.probabilities.normal/card.ability.extra.odds then 
                                  return {
                    Xmult_mod = card.ability.extra.Xmult,
                                      message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                                      card = card
                                  }
          end
      end
    end
  },
  
  }