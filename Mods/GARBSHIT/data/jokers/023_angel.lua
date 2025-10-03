return {
 SMODS.Joker {
    key = 'angel',
    loc_txt = {
      name = 'The Angel of Salt',
      text = {
      "{C:green}#2# in #3#{} chance to destroy",
      "each scored {C:attention}Stone{} card",
      "This Joker gains {X:mult,C:white} X#4# {} Mult",
      "for card {C:attention}destroyed{} this way",
      "{C:inactive}(Currently {X:mult,C:white} X#1# {} Mult)"
      },
      unlock = {
        "Destroy 5 {E:1,C:attention}Stone{} Cards",
        "at once using {E:1,C:spectral}Immolate{}"
      }
    },
    config = { extra = { Xmult = 1, odds = 4, Xmult_gain = 0.75 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult, G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.Xmult_gain } }
    end,
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 2, y = 4 },
    cost = 7,
  
      unlocked = false, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
  
      check_for_unlock = function(self, args)
        if args.type == "salt" then
          return true
        end
      end,
    
    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play and not context.blueprint then
      local _card = context.other_card
                          if _card.ability.name == 'Stone Card' and pseudorandom('Salt') < G.GAME.probabilities.normal/card.ability.extra.odds then
                            _card.destroyme = true
                            G.E_MANAGER:add_event(Event({
                              func = function()
                                if SMODS.shatters(card) then
                                  _card:shatter()
                                else    
                                _card:start_dissolve(nil, _first_dissolve)
                                end
                                return true
                              end
                            }))
                            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                          if card.ability.extra.Xmult > 1 then
                          return {
                            message = "Absorbed!",
                            card = card,
                          }
                        else
                          return false
                        end
                        end
      end
  
      if context.destroying_card and context.destroying_card.destroyme then
        return{
            remove = true,
        }
    end
  
  
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.Xmult,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
          card = card
        }
      end
  
    end
  },
  
  }