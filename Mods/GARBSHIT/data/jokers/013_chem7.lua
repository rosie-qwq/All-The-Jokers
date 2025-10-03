return {
 SMODS.Joker {
    key = 'chem7',
    loc_txt = {
      name = 'Chemical Seven',
      text = {
        "Sell this card for {C:money}7${}",
        "If you own 3 copies of",
        "{C:attention}Chemical Seven{}, gain {C:money}#1#${}",
        "{C:red}self-destructs{}",
        "{C:inactive}(This Joker may appear multiple times){}"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {money = 77, value = 6} },
    rarity = 1,
    atlas = 'GarbJokers',
    pos = { x = 4, y = 1 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = false, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 3,
      loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.money } }
    end,
      
      in_pool = function(self)
          return true, { allow_duplicates = true }
      end,
      
     add_to_deck = function(self, card, context)
          card.ability.extra_value = 6
          card:set_cost()
          local chemical7 = SMODS.find_card("j_garb_chem7")
          local _first_dissolve = nil
              
          if #chemical7 == 2 then
              chemical7[#chemical7 + 1] = card
              ease_dollars(card.ability.extra.money)
              
              for k, v in pairs(chemical7) do
                  if v ~= chosen_joker then 
                      v:start_dissolve(nil, _first_dissolve)
                      _first_dissolve = true
                  end
              end
          end
    end
  },
  
  }