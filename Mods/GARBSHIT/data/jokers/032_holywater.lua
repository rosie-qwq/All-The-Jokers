return {
 SMODS.Joker {
    key = 'holywater',
    loc_txt = {
      name = 'Holy Water',
      text = {
        "If current blind is a {C:attention}Boss Blind{},",
        "scored {C:attention}Pure{} cards",
        "give {X:mult,C:white}X#1#{} Mult"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {Xmult = 1.5} },
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 5, y = 6},
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 5,
      loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.m_garb_pure
      return { vars = { card.ability.extra.Xmult } }
    end,
      
     calculate = function(self, card, context)
     
      if context.individual and context.cardarea == G.play and not context.blueprint and G.GAME.blind.boss then
        if context.other_card.ability.name == 'm_garb_pure' then
        return {
          Xmult_mod = card.ability.extra.Xmult,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
        }
      end
      end
      
    end
  },

  }