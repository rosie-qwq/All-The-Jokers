return {
 SMODS.Joker {
    key = 'corrupted',
    loc_txt = {
      name = 'Corrupted Joker',
      text = {
        "Gains or loses",
        "a random amount of {C:chips}Chips{C:chips}",
        "after every hand played",
        "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
      }
    },
    config = { extra = { chips = 0, chip_gain = 10 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chips } }
    end,
    rarity = 1,
    atlas = 'GarbJokers',
    pos = { x = 0, y = 0 },
    cost = 3,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      
  loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain } }
    end,
    
    calculate = function(self, card, context)
      if context.joker_main then
        if card.ability.extra.chips >= 100 then check_for_unlock({ type = "corrupted" }) end
        return {
          chip_mod = card.ability.extra.chips,
          message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
        }
      end
      
      if context.after and not context.blueprint then
          card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
          card.ability.extra.chip_gain = pseudorandom('104420', -20, 20)
      if card.ability.extra.chips <= 0 then card.ability.extra.chips = 0 end
        return {
          message = 'Upgraded?',
          card = card
        }
      end
      
    end
  },
  
  
  }