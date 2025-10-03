return {
 SMODS.Joker {
    key = 'snap',
    loc_txt = {
      name = 'The Snap',
      text = {
        "Sell this card to",
        "halve the current",
        "Blind's {C:attention}score",
        "{C:attention}requirement{}",
        "{s:0.7,C:inactive}Currently: {s:0.7,V:1}#1#",
    }
    },
    config = { extra = { difficulty = 0.5 } },
    loc_vars = function(self, info_queue, card)
      local activate_text = 'Inactive'
      local activate_color = G.C.RED
      if G.STATE == G.STATES.SELECTING_HAND then
        activate_text = 'Active'
        activate_color = G.C.GREEN
      end
    
      return {vars = {activate_text,
          colours = {activate_color} }}
    end,
  
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 6, y = 6 },
    cost = 5,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      
      calculate = function(self, card, context)
        if context.selling_self and G.STATE == G.STATES.SELECTING_HAND then
            local create_champion_event = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.8,
                    func = function()
                        if G.hand_text_area.blind_chips then
                            local new_chips = math.floor(G.GAME.blind.chips * card.ability.extra.difficulty)
                            local mod_text = number_format(
                                math.floor(G.GAME.blind.chips * card.ability.extra.difficulty) - G.GAME.blind.chips
                            )
                            G.GAME.blind.chips = new_chips
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    
                            local chips_UI = G.hand_text_area.blind_chips
                            G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                            G.HUD_blind:recalculate()
    
                            attention_text({
                                text = mod_text,
                                scale = 0.8,
                                hold = 0.7,
                                cover = chips_UI.parent,
                                cover_colour = G.C.RED,
                                align = 'cm'
                            })
    
                            chips_UI:juice_up()
    
                            play_sound('chips2')
                        else
                        return false --create_champion_event()
                        end
                        return true
                    end
                }))
            end
            create_champion_event()
            play_sound('garb_snap', 1)
            return {
              message = "Snap!",
              card = card
          }
        end
    end,
  },

  }