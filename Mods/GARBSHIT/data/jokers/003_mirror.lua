return {
 SMODS.Joker {
    -- How the code refers to the joker.
    key = 'mirror',
    -- loc_text is the actual name and description that show in-game for the card.
    loc_txt = {
      name = 'Mirror',
      text = {
        "Inverts {C:chips}Chips{} and {C:mult}Mult{}"
      }
    },
    config = { extra = { chips = 1, mult = 1, temp = 1 } },
  
    -- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
    rarity = 3,
    -- Which atlas key to pull from.
    atlas = 'GarbJokers',
    -- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
    pos = { x = 6, y = 1 },
    -- Cost of card in shop.
    cost = 7,
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = false, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
  
    calculate = function(self, card, context)
    
      if context.joker_main then
        card.ability.extra.temp = mult
        
          G.E_MANAGER:add_event(Event({
              func = function()
                  play_sound('garb_mirrorz', 0.9 + math.random()*0.1, 0.8)
                  card:juice_up(0.3, 0.4)
                  return true
              end
              }))
        return {
          mult_mod = -mult + hand_chips,
          chip_mod = -hand_chips + card.ability.extra.temp,
              message = "Inverted!",
              card = card
        }
      end
    end
  },
  
  }