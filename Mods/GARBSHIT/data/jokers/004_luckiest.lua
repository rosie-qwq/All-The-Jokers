return {
 SMODS.Joker {
    key = 'luckiest',
    loc_txt = {
      name = 'Golden Lucky Cat',
      text = {
        "{C:green}#3# in #2#{} chance for",
        "{C:attention}Lucky{} cards held in hand",
        "to give {C:money}$#1#"
      }
    },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
  
    config = { extra = { money = 20, odds = 15 } },
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 5, y = 1 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
      return { vars = { card.ability.extra.money, card.ability.extra.odds, G.GAME.probabilities.normal } }
    end,
    
     calculate = function(self, card, context)
  
      if context.individual and context.cardarea == G.hand and not context.end_of_round then
        if pseudorandom('Nyanko') < G.GAME.probabilities.normal/card.ability.extra.odds and context.other_card.ability.name == 'Lucky Card' then
          G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
          G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
          return {
            dollars = card.ability.extra.money,
            message_card = context.other_card,
            colour = G.C.MONEY
          }
          end
      end
    end
  },
  
  
  }