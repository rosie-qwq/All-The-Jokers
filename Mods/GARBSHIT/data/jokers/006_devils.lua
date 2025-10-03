return {
 SMODS.Joker {
    key = 'devils',
    loc_txt = {
      name = "Devil's Deal",
      text = {
        "Prevents Death",
        "Adds {C:attention}#1#{} {C:mult}Debuffed{} {C:attention}Stone{}",
        "{C:attention}Cards{} to deck",
        "{C:mult}Self-Destructs{}"
      }
    },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
  
    config = { extra = { duds = 66 } },
    rarity = 1,
    atlas = 'GarbJokers',
    pos = { x = 3, y = 1 },
    cost = 3,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.duds } }
    end,
    
     calculate = function(self, card, context)
  
      if context.game_over then
        check_for_unlock({ type = "devils_deal" })
                      G.E_MANAGER:add_event(Event({
                          func = function() 
                              local front = pseudorandom_element(G.P_CARDS, pseudoseed('devil'))
                              G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                              for i = 1, card.ability.extra.duds do
                                  local _card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_stone, {playing_card = G.playing_card})
                                  _card:start_materialize({G.C.SECONDARY_SET.Enhanced})
                                  _card.ability.perma_debuff, _card.debuff = true
                                  G.deck:emplace(_card)
                                  table.insert(G.playing_cards, _card)
                              end
                              return true
                          end
                          
                      })) 
                      G.E_MANAGER:add_event(Event({
                          func = function()
                              G.hand_text_area.blind_chips:juice_up()
                              G.hand_text_area.game_chips:juice_up()
                              play_sound('tarot1')
                              if SMODS.shatters(card) then
                                card:shatter()
                              else  
                              card:start_dissolve()
                              end
                              return true
                          end
                      })) 
                      return {
                          message = localize('k_saved_ex'),
                          saved = true,
                          colour = G.C.RED
                      }
      end
    end
  },
  
  
  }