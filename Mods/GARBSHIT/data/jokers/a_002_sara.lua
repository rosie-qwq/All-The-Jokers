return {
 SMODS.Joker {
    key = 'sara',
    loc_txt = {
      name = 'Sara :3',
      text = {
        "On {C:attention}first hand{} of round,",
          "add a permanent copy of",
        "all scored {C:attention}Glass Cards{} to deck",
        "and draw them to {C:attention}hand",
      },
      unlock = {
        "{E:1,s:1.3}?????"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {} },
    rarity = 4,
    atlas = 'GarbJokers',
    pos = { x = 6, y = 0 },
    
    -- soul_pos sets the soul sprite, only used in vanilla for legenedaries and Hologram.
    soul_pos = { x = 0, y = 1 },
    cost = 20,
  
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.m_glass
      return { vars = {  } }
    end,
    
      unlocked = false, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = false, --can it be perishable
      
        add_to_deck = function(self, card)
        check_for_unlock({ type = "discover_sara" })
      end,
  
    calculate = function(self, card, context)
  
      if context.repetition and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 then
                          local card = context.other_card
                          -- if card == context.scoring_hand[no_retrigger] then return false end
                          
                          if card.ability.name == 'Glass Card' then
                              G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                              local _card = copy_card(context.other_card, nil, nil, G.playing_card)
                              _card:add_to_deck()
  
                              G.deck.config.card_limit = G.deck.config.card_limit + 1
                              table.insert(G.playing_cards, _card)
                              G.hand:emplace(_card)
                              _card.states.visible = nil
  
                              G.E_MANAGER:add_event(Event({
                                  func = function()
                                      _card:start_materialize()
                                      return true
                                  end
                              })) 

                              card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = localize('k_copied_ex')})

                              --[[
                              for i = 1, #context.scoring_hand do
                              if card == context.scoring_hand[i] then no_retrigger = i end
                              end
                              ]]--
                              SMODS.calculate_context({playing_card_added = true, cards = {_card}})

                              return {
                                  card = card,
                                  playing_cards_created = {_card}
                                }
        end
      end
    end
  },  
  
  }