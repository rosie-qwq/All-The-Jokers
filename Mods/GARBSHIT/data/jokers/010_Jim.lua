return {
 SMODS.Joker {
    key = 'Jim',
    loc_txt = {
      name = 'Jim',
      text = {
        "{X:mult,C:white} X#1# {} Mult",
        "Fills all free Joker slots with {C:red}Jim{}",
        "{C:inactive}(If one Jim goes away, all Jims go away){}"
      }
    },
  
    config = { extra = {Xmult = 1.5} },
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 6, y = 2 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = false, --can it be eternal
      perishable_compat = true, --can it be perishable
      
      cost = 5,
      loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult } }
    end,
      
     calculate = function(self, card, context)
  
          if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.Xmult,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
        }
      end
    end,
    
    add_to_deck = function(self, card, from_debuff)
  
      G.E_MANAGER:add_event(Event({
          delay = 0.1,
          func = (function()
              if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                  local new_card = SMODS.create_card{key = "j_garb_Jim", no_edition = true}
                  new_card:add_to_deck()
                  G.jokers:emplace(new_card)
              end
              return true
          end)}))
    end,
  
    remove_from_deck = function(self, card, from_debuff)
          local jims = SMODS.find_card("j_garb_Jim")
          local _first_dissolve = nil
  
          for k, v in pairs(jims) do
              if v ~= chosen_joker then 
                  v:start_dissolve(nil, _first_dissolve)
                  _first_dissolve = true
              end
          end
    end
  },
  
  }