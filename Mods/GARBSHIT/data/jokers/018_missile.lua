return {
 SMODS.Joker {
    key = 'missile',
    loc_txt = {
      name = 'Magic Missile',
      text = {
        "{X:mult,C:white} X#1# {} Mult if",
        "played {C:attention}poker hand{}",
        "is a {C:attention}High Card{}"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {Xmult = 3} },
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 5, y = 4 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 4,
      loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult } }
    end,
      
     calculate = function(self, card, context)
         
      if context.joker_main and context.scoring_name == "High Card" then
        -- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".
        return {
          Xmult_mod = card.ability.extra.Xmult,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
        }
      end
    end
  },
  
  }