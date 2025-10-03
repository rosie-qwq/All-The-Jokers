return {
 SMODS.Joker {
    key = 'rolling',
    loc_txt = {
      name = 'Rolling Stone',
      text = {
        "Adds one {C:attention}Stone{} card",
        "to deck when",
        "{C:attention}Shop{} is {C:attention}Rerolled{}"
      }
    },
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.m_stone
      return { vars = {  } }
    end,
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 3, y = 0 },
    cost = 7,
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      
    
    calculate = function(self, card, context)
      if context.reroll_shop then
          G.E_MANAGER:add_event(Event({
                      func = function() 
                          if not stone_counter then stone_counter = 1 else stone_counter = stone_counter + 1 end
                          if stone_counter == 25 then check_for_unlock({ type = "rocking" }) end
                          local front = pseudorandom_element(G.P_CARDS, pseudoseed('marb_fr'))
                          G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                          local card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_stone, {playing_card = G.playing_card})
                          card:start_materialize({G.C.SECONDARY_SET.Enhanced})
                          G.deck:emplace(card)
                          table.insert(G.playing_cards, card)
                          return true
                      end}))
          return {
              message = "Stone!",
              colour = G.C.CHIPS,
              playing_cards_created = {true},
              card = card
              }
      end
  
      
    end
  },
  
  }