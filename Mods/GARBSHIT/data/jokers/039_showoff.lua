return {
 SMODS.Joker {
    key = 'showoff',
    loc_txt = {
      name = 'Showoff',
      text = {
        "If played {C:attention}hand{} causes",
        "the score to {C:attention}catch fire{}",
        "this Joker gains {X:mult,C:white} X#2# {} Mult",
        "{C:inactive}(Currently {X:mult,C:white} X#1# {} {C:inactive}Mult)"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {Xmult = 1, Xmult_gain = 0.5} },
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 6, y = 7 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 6,
      loc_vars = function(self, info_queue, card)
      if config.on_card_credits then
        info_queue[#info_queue+1] = {set = "Other", key = "credits", specific_vars = {"omegaflowey18"}} 
      end
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
    end,
      
      calculate = function(self, card, context)
        if context.after and G.GAME.FLAME_ON then
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
          return {
              card = card,
              message = 'Upgraded!'
          }
        end

      if context.joker_main and card.ability.extra.Xmult > 1 then
        return {
          Xmult_mod = card.ability.extra.Xmult,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
          card = card      
        }
      end
    end

  },

  }