return {
 SMODS.Joker {
    key = 'colorful',
    loc_txt = {
      name = 'Colorful Joker',
      text = {
        "If poker hand contains a",
        "{C:diamonds}Diamond{} card, {C:clubs}Club{} card,",
        "{C:hearts}Heart{} card, and a {C:spades}Spade{} card,",
        "all scoring cards become",
        "{C:dark_edition}Polychrome{} after scoring"
      },
      unlock = {
        "Have the {E:1,C:diamonds}Greedy{}, {E:1,C:hearts}Lusty{},",
        "{E:1,C:spades}Wrathful{} and {E:1,C:clubs}Gluttonous{}",
        "Jokers at the same time"
      }
    },
    config = { extra = {} },
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 0, y = 2 },
    
      unlocked = false, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = false, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 6,
      loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
      return { vars = { } }
    end,
      
    check_for_unlock = function(self, args)
      if args.type == "colorful_jonk" then
        return true
      end
    end,
  
     calculate = function(self, card, context)
     
      if context.after then
                              local suits = {
                                  ['Hearts'] = 0,
                                  ['Diamonds'] = 0,
                                  ['Spades'] = 0,
                                  ['Clubs'] = 0
                              }
                              for i = 1, #context.scoring_hand do
                                  if not SMODS.has_any_suit(context.scoring_hand[i]) then
                                      if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                                      elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                                      elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                                      elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                                  end
                              end
                              for i = 1, #context.scoring_hand do
                                  if SMODS.has_any_suit(context.scoring_hand[i]) then
                                      if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                                      elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                                      elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                                      elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                                  end
                              end
                              if suits["Hearts"] > 0 and
                              suits["Diamonds"] > 0 and
                              suits["Spades"] > 0 and
                              suits["Clubs"] > 0 then
                                  for k, v in ipairs(context.scoring_hand) do
                                  G.E_MANAGER:add_event(Event({
                                      func = function()
                                          v:juice_up()
                                          v:set_edition("e_polychrome", true)
                                          return true
                                      end
                                  }))
                                  delay(0.3)
                                  end
                                  return {
                                  message = "Rainbow!",
                                  colour = G.C.DARK_EDITION,
                                  card = card
        }
                              end
      end
    end
  },
  
  }