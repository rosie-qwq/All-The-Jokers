return {
 SMODS.Joker {
    key = 'SURGE',
    loc_txt = {
      name = 'THE SURGE',
      text = {
        "{X:mult,C:white} X#1# {} MULT",
        "DESTROYS {s:1.2,C:red}ALL JOKERS{} IF CHIPS SCORED",
        "ARE {C:attention}LESS THAN TWO TIMES{} REQUIRED SCORE"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {Xmult = 8} },
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 3, y = 2 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 10,
      loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult } }
    end,
  
     calculate = function(self, card, context)
      if context.joker_main then
          return {
              Xmult_mod = card.ability.extra.Xmult,
              message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
              card = card
          }
      end
      
          if context.end_of_round and to_big(G.GAME.chips) / to_big(G.GAME.blind.chips) < to_big(2) and context.cardarea == G.jokers then 
              local deletable_jokers = {}
              local _first_dissolve = nil
              play_sound('garb_surge', 1, 0.6)
              check_for_unlock({ type = "surged" })
              for k, v in pairs(G.jokers.cards) do
                  if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
              end
              
              for k, v in pairs(deletable_jokers) do
                  if v ~= chosen_joker then 
                      v:start_dissolve(nil, _first_dissolve)
                      _first_dissolve = true
                  end
              end
          return {
              message = "SURGED!",
        card = card
          }
      end
    end
  },
  
  }