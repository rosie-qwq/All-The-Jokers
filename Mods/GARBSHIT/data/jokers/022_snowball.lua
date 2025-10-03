return {
 SMODS.Joker {
    key = 'snowball',
    loc_txt = {
      name = 'Snowball',
      text = {
        "{C:chips}+#1#{} Chips",
      "Amount is {C:attention}doubled{} when",
      "a card is {C:attention}retriggered{}",
      "{C:inactive}(Amount resets each hand){}",
      "{C:inactive}(Last payout: {C:chips}+#2#{} {C:inactive}Chips){}"
      }
    },
    config = { extra = { chips = 5, last_scored = 0 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chips } }
    end,
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 1, y = 4 },
    cost = 7,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      
  loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chips, card.ability.extra.last_scored} }
    end,
    
    calculate = function(self, card, context)
  
      if context.joker_main then
        return {
          chip_mod = card.ability.extra.chips,
          message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
          card = card}
      end
  
      if context.after then
        card.ability.extra.chips = 5
        s_no_retrigger = -1
      end
      
      if context.individual and context.cardarea == G.play then
        local _card = context.other_card
              for i=1, #context.scoring_hand do
                  if context.scoring_hand[i] == _card then
                      if context.scoring_hand[s_no_retrigger] == _card then
                        card.ability.extra.chips = card.ability.extra.chips*2
                        card.ability.extra.last_scored = card.ability.extra.chips
                        if card.ability.extra.chips > 2500 then check_for_unlock({ type = "snowedin" }) end
                        return {
                          message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                          card = card
                        }
                      end
                      s_no_retrigger = i
                  end
                end
            return nil
      end
  
  
    end
  },
  
  }