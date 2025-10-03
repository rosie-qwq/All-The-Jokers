return {
 SMODS.Joker {
    key = 'backtrack',
    loc_txt = {
      name = 'Backtrack',
      text = {
        "Visit the {C:attention}Shop{}",
        "after a blind is" ,
        "{C:attention}skipped{}",
      }
    },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
      if config.on_card_credits then
        info_queue[#info_queue+1] = {set = "Other", key = "credits", specific_vars = {"lamborghiniofficial"}} 
      end
      return { vars = {  } }
    end,
  
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 2, y = 6 },
    cost = 5,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable

      calculate = function(self, card, context)
        if context.skip_blind then
          return {
            message = 'Backtracked!',
            card = card
          }
        end
      end
  },
 
  }