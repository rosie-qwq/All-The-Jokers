local bad_apple = {
    object_type = "Joker",
    order = 84,
    ignore = true,

    key = "bad_apple",
    config = {
      
    },
    rarity = 1,
    pos = { x = 4, y = 3 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
  
    loc_vars = function(self, info_queue, card)
  
    end,
  
    calculate = function(self, card, context)
      
    end
  
}
return { name = {"Jokers"}, items = {bad_apple} }
