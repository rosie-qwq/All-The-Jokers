return {
 SMODS.Joker {
    key = 'shoot_the_dealer',
    loc_txt = {
      name = "Shoot the Dealer",
      text = {
        "Prevents Death",
        "{C:red}Resets{} deck to a",
        "{C:attention}52-card{} standard deck",
        "{C:red}self-destructs"
      }
    },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = false, --can it be blueprinted/brainstormed/other
      eternal_compat = false, --can it be eternal
      perishable_compat = true, --can it be perishable
  
    config = { extra = { } },
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 6, y = 8 },
    cost = 7,
    loc_vars = function(self, info_queue, card)
      return { vars = { } }
    end,
    
     calculate = function(self, card, context)
      if context.game_over and not context.blueprint then
        check_for_unlock({ type = "shot" })
        G.E_MANAGER:add_event(Event({
          func = function()
            local cards = {}
            for i = 1, #G.playing_cards do
              G.playing_cards[i]:start_dissolve(nil, true)
            end
            local suits = {"H", "D", "S", "C"}
            local ranks = {"T", "2", "3", "4", "5", "6", "7", "8", "9", "A", "J", "Q", "K"}
            for k, v in pairs(suits) do
              for k2, v2 in pairs(ranks) do
                local index = k2 + #ranks * (k-1)
                cards[index] = create_playing_card({
                  front = G.P_CARDS[v .. '_' .. v2],
                  center = G.P_CENTERS.c_base
                }, G.deck, nil, nil, { G.C.RED })
              end
            end
            G.hand_text_area.blind_chips:juice_up()
            G.hand_text_area.game_chips:juice_up()
            play_sound('garb_gunshot')  
            play_sound('tarot1')  
            card:start_dissolve()
            return true
          end
        })) 
      return {
        remove = true,
        message = localize('k_saved_ex'),
        saved = true,
        colour = G.C.RED
      }
      end
    end
  },
  
  
  }