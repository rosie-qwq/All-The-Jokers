return {
 SMODS.Joker {
    key = 'director',
    loc_txt = {
      name = 'The Director',
      text = {
        "Earn {C:money}$#1#{} for each",
        "{C:rare}Rare{} Joker owned",
        "at end of round",
        "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
      }
    },
    config = { extra = { dollars_gain = 3, dollars = 3 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.dollars_gain, card.ability.extra.dollars }}
    end,
  
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 0, y = 9 },
    cost = 9,

      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = false, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable

    update = function(self, card)
      if G.jokers then 
        local rares = {}
        for k, v in pairs(G.jokers.cards) do
          if v.config.center.rarity == 3 then rares[#rares+1] = 1 end
        end
        card.ability.extra.dollars = #rares * card.ability.extra.dollars_gain
      end
    end,

    calc_dollar_bonus = function(self, card)
      local bonus = card.ability.extra.dollars
      return bonus
    end
  
  },

  }