return {
 SMODS.Joker {
    key = 'equality',
    loc_txt = {
      name = 'Gender Equality',
      text = {
        "All {C:attention}Queens{} are treated like", 
      "they were {C:attention}Kings{}"
      }
    },
    config = { extra = { chips = 0, chip_gain = 10 } },
    loc_vars = function(self, info_queue, card)
      return { vars = {  } }
    end,
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 4, y = 3 },
    cost = 5,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      
  loc_vars = function(self, info_queue, card)
      return { vars = {  } }
    end
  },
  
    }