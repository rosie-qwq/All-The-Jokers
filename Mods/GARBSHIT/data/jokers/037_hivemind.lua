return {
 SMODS.Joker {
    key = 'hivemind',
    loc_txt = {
      name = 'The Hivemind',
      text = {
        "This Joker gains {X:mult,C:white} X#1# {} Mult",
        "every time an {C:attention}Infected{} card",
        "is destroyed",
        "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
}
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {Xmult = 1, Xmult_gain = 0.5} },
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 3, y = 7},
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 5,
      loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.m_garb_infected
      return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,
      
     calculate = function(self, card, context)
      if context.remove_playing_cards then
        local hive = 0
        for k, v in ipairs(context.removed) do
          if v.ability.name == 'm_garb_infected' then
              hive = hive + 1
          end
        end

        if hive > 0 then
          G.E_MANAGER:add_event(Event({
             func = function()
          G.E_MANAGER:add_event(Event({
             func = function()
                card.ability.extra.Xmult = card.ability.extra.Xmult + hive*card.ability.extra.Xmult_gain
                return true
             end
           }))
         card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult + hive*card.ability.extra.Xmult_gain}}})
         return true
         end
        }))
        end
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