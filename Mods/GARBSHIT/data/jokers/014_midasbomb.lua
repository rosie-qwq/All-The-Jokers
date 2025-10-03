return {
 SMODS.Joker {
    key = 'midasbomb',
    loc_txt = {
      name = 'Midas Bomb',
      text = {
      "Sell this card to",
        "{C:red}destroy{} all {C:attention}Jokers{} and",
        "earn {C:money}7x the sell value{} of all",
        "{C:attention}Jokers{} destroyed this way"
      }
    },
    config = { extra = {value = 0} },
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 2, y = 1 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = false, --can it be blueprinted/brainstormed/other
      eternal_compat = false, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 7,
      loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult } }
    end,
      
     calculate = function(self, card, context)
     
      if context.buying_card then
              card.ability.extra_value = -3
              card:set_cost()
      end
      
      if context.selling_self then
  
              local sell_cost = 0
              local deletable_jokers = {}
              local _first_dissolve = nil
  
              for k, v in pairs(G.jokers.cards) do
                  if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
              end
              
              for i = 1, #G.jokers.cards do
                  if G.jokers.cards[i] ~= self and not G.jokers.cards[i].ability.eternal and (G.jokers.cards[i].area and G.jokers.cards[i].area == G.jokers) then
                      sell_cost = sell_cost + G.jokers.cards[i].sell_cost
                  end
                    end
                  
              for k, v in pairs(deletable_jokers) do
                  if v ~= chosen_joker then 
                      v:start_dissolve(nil, _first_dissolve)
                      _first_dissolve = true
                  end
              end
              
              play_sound('garb_explosion')
              card.ability.extra_value = sell_cost*7 - 3
              card:set_cost()
                  return {
                      message = "Kaboom!",
                      colour = G.C.MONEY
                  }
      end
    end
  },
  
  }