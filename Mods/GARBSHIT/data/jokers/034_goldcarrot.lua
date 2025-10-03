return {
 SMODS.Joker {
    key = 'goldcarrot',
    loc_txt = {
      name = 'Golden Carrot',
      text = {
        "{C:rare}Rare{} Jokers appear",
        "{C:attention}3x{} as often"
    }
    },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
      return {vars = {}}
    end,
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 0, y = 7 },
    cost = 7,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      
  },

  }