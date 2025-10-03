return {
 SMODS.Joker {
    key = 'devil_essence',
    loc_txt = {
      name = "Essence of Devil's Deal",
      text = {
        "When {C:attention}Blind{} is selected,",
      "{C:red}destroy{} all {C:red}debuffed{} cards"
      },
      unlock = {
        "Get saved by {E:1,C:attention}Devil's Deal{}"
      }
    },
  
    config = { extra = {} },
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 1, y = 1 },
    
      unlocked = false, 
      unlock_condition = {type = 'devils_deal'},
      discovered = false, --whether or not it starts discovered
      blueprint_compat = false, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 6,
      loc_vars = function(self, info_queue, card)
      return { vars = { } }
    end,
  
    check_for_unlock = function(self, args)
      if args.type == "devils_deal" then
        return true
      end
    end,
  
     calculate = function(self, card, context)
      if context.blind or context.first_hand_drawn then
          local card = context.other_card
              for k, v in pairs(G.playing_cards) do
                  if v.debuff == true then
                      v:start_dissolve(nil, _first_dissolve)
                      _first_dissolve = true
                  end
              end
      end
    end
  },
  
  
  }