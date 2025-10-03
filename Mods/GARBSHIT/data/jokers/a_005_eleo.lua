return {
 SMODS.Joker {
    key = 'eleo',
    loc_txt = {
      name = 'Eleoblade',
      text = {
      "This Joker gains {X:mult,C:white} X#2# {} Mult",
      "every time a {C:attention}Steel{} or {C:attention}Gold{} card's",
      "effect is triggered",
      "{C:inactive}(Currently {X:mult,C:white} X#1# {} {C:inactive}Mult)"
      },
      unlock = {
        "{E:1,s:1.3}?????"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {Xmult = 1, Xmult_gain = 0.2} },
    rarity = 4,
    atlas = 'GarbJokers',
    pos = { x = 3, y = 4 },
    
    -- soul_pos sets the soul sprite, only used in vanilla for legenedaries and Hologram.
    soul_pos = { x = 4, y = 4 },
    cost = 20,
  
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.m_steel
      info_queue[#info_queue+1] = G.P_CENTERS.m_gold
      return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain} }
    end,
  
      unlocked = false, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = false, --can it be perishable
      
      
        add_to_deck = function(self, card)
        check_for_unlock({ type = "discover_eleo" })
      end,
  
  
     calculate = function(self, card, context)
     if context.individual and not context.end_of_round and context.cardarea == G.hand and not context.blueprint then
        local _card = context.other_card
        if _card.config.center == G.P_CENTERS.m_steel and not _card.debuff then
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
          return {
            message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
            card = card
          }
        end
     end
  
     if not context.individual and context.end_of_round and context.cardarea == G.hand and not context.blueprint then
      local _card = context.other_card
      if _card.config.center == G.P_CENTERS.m_gold and not _card.debuff then
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
        for i = 1, #G.hand.cards do
          if _card == G.hand.cards[i] then no_retrigger = i end
        end      
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}})
        return {
          card = card
        }
      end
   end
  
   if context.individual and context.end_of_round and context.cardarea == G.hand and not context.blueprint then
    local _card = context.other_card
    if _card.config.center == G.P_CENTERS.m_gold and not _card.debuff then
        if _card == G.hand.cards[no_retrigger] then 
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}})    
        end
      return {
        card = card
      }
    end
  end
        
        if context.joker_main and card.ability.extra.Xmult > 1 then
          no_retrigger = -1
          return {
            Xmult_mod = card.ability.extra.Xmult,
            message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
            card = card
          }
        end
     end
  },
  
  }