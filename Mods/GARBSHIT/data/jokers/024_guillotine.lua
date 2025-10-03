return {
 SMODS.Joker {
    key = 'guillotine',
    loc_txt = {
      name = 'Guillotine',
      text = {
        "If discard contains {C:attention}exactly{}",
        "{C:attention}1 face{} card, destroy it",
        "and gain {C:mult}+#2#{} Mult{}",
        "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {mult = 0, mult_gain = 3} },
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 6, y = 4 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 4,
      loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,
      
    calculate = function(self, card, context)
     if context.discard and not context.blueprint then
      if #context.full_hand == 1 and context.full_hand[1]:is_face() then
        context.full_hand[1]:start_dissolve(nil, false)
        play_sound('slice1', 0.96+math.random()*0.08)
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
        return {
          remove = true,
          message = 'Upgraded!',
          card = card
        }
      end
     end
  
     if context.selling_card and context.card.config.center_key == "j_baron" and not context.blueprint then
      play_sound('slice1', 0.96+math.random()*0.08)
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
      check_for_unlock({ type = "regicide" })
      return {
        message = 'Upgraded!',
        card = card
      }
    end
   
  
     if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
      }
    end
    
    end
  },
  
  }