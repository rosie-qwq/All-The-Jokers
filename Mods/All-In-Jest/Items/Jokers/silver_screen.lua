local silver_screen = {
    object_type = "Joker",
    order = 98,
    ignore = true,

    key = "silver_screen",
    config = {
      
    },
    rarity = 1,
    pos = { x = 18, y = 3 },
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
return { name = {"Jokers"}, items = {silver_screen} }
