return {
 SMODS.Joker {
    key = 'd20',
    loc_txt = {
      name = 'Critical Roll',
      text = {
        "Gives {X:mult,C:white} X#1# {} Mult every time",
        "a {C:attention}Lucky{} card",
        "{C:green}successfully{} triggers"
      }
    },
  
    config = { extra = {Xmult = 3} },
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 5, y = 2 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 7,
      loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
      return { vars = { card.ability.extra.Xmult } }
    end,
      
     calculate = function(self, card, context)
  
      if context.individual and not context.other_card.debuff and context.other_card.lucky_trigger then
                                  return {
                    Xmult_mod = card.ability.extra.Xmult,
                                      message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                                      card = card
                  }
      end
      
      end
  },
  
  }