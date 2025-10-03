return {
 SMODS.Joker {
    key = 'ratboy',
    loc_txt = {
      name = 'Ratboy',
      text = {
        "{C:mult}+#1#{} Mult",
        "Plays a {C:attention}squeaky sound{}",
        "every time a card is",
        "{C:attention}triggered{}"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {mult = 4} },
    rarity = 1,
    atlas = 'GarbJokers',
    pos = { x = 3, y = 3 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 2,
      loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.mult } }
    end,
      
     calculate = function(self, card, context)
     
      if context.individual and context.cardarea == G.play and not context.blueprint then
  
          G.E_MANAGER:add_event(Event({
              func = function()
              play_sound('garb_squeak', 0.8 + math.random()*0.3, 0.8)
                  card:juice_up(0.1, 0.2)
                  return true
              end
          }))
      end
      
      if context.joker_main then
        -- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".
        return {
          mult_mod = card.ability.extra.mult,
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
        }
      end
    end
  },
  
  }