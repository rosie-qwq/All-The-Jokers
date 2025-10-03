return {
 SMODS.Joker {
    key = 'eviolite',
    loc_txt = {
      name = 'Eviolite',
      text = {
        "{C:attention}+1{} hand size for each",
        "empty {C:attention}Joker{} slot",
        "{s:0.8}Eviolite included",
        "{C:inactive}(Currently {C:attention}+#1#{C:inactive})"

    }
    },
    config = { extra = { h_size = 0, ini_h_size = 8 } },
    loc_vars = function(self, info_queue, card)
      return {vars = {}}
    end,
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 2, y = 8 },
    cost = 7,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable

    loc_vars = function(self, info_queue, card)
      return { vars = { G.jokers and card.ability.extra.h_size or 5 } }
    end,

    update = function(self, card, dt)
        if card.area and card.area == G.jokers then
            local new_limit = G.jokers.config.card_limit - #G.jokers.cards + #SMODS.find_card("j_garb_eviolite")
            if new_limit ~= card.ability.extra.h_size then
                G.hand:change_size(new_limit - card.ability.extra.h_size)
                card.ability.extra.h_size = new_limit
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end,

  },


   -- LEGENDARIES
   
  }