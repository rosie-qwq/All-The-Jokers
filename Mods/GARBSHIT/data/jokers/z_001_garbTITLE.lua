return {
 SMODS.Joker {
    key = 'garbTITLE',
    loc_txt = {
      name = 'GARB FROM THE HIT GAME GARBSHIT BALATRO',
      text = {
        "{c:red}HOLY SHIIIIIT{}"
      }
    },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
      return { vars = {  } }
    end,

    in_pool = function(self)
      return false
  end,

    rarity = 1,
    atlas = 'GarbJokers',
    pos = { x = 4, y = 0 },
    soul_pos = {x = 5, y = 0},
    cost = 5,
      no_collection = true,
      unlocked = true, 
      discovered = true, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      },

}