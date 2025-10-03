return {
 SMODS.Joker {
    key = 'black_hole',
    loc_txt = {
      name = 'Event Horizon',
      text = {
        "When a {C:planet}Planet{} card is used,",
        "{C:green}#3# in #2#{} chance to",
        "upgrade every {C:attention}poker hand{}"
      },
      unlock = {
        "Find and use the {E:1,C:spectral}Black Hole{} Card"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {odds = 8} },
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 0, y = 3 },
    
      unlocked = false, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 8,
      loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult,card.ability.extra.odds, G.GAME.probabilities.normal} }
    end,
      
    check_for_unlock = function(self, args)
      if args.type == "black_hole" then
        return true
      end
    end,
  
     calculate = function(self, card, context)
      if context.using_consumeable and context.consumeable.ability.set == 'Planet' and pseudorandom('BlackHole') < G.GAME.probabilities.normal/card.ability.extra.odds then
          update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
              play_sound('tarot1')
              card:juice_up(0.8, 0.5)
              G.TAROT_INTERRUPT_PULSE = true
              return true end }))
          update_hand_text({delay = 0}, {mult = '+', StatusText = true})
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
              play_sound('tarot1')
              card:juice_up(0.8, 0.5)
              return true end }))
          update_hand_text({delay = 0}, {chips = '+', StatusText = true})
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
              play_sound('tarot1')
              card:juice_up(0.8, 0.5)
              G.TAROT_INTERRUPT_PULSE = nil
              return true end }))
          update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
          delay(1.3)
          for k, v in pairs(G.GAME.hands) do
              level_up_hand(self, k, true)
          end
          update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
      end
    end
  },
  
  }