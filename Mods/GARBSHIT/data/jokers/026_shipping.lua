return {
 SMODS.Joker {
    key = 'shipping',
    loc_txt = {
      name = 'Shipping Wall',
      text = {
      "{C:attention}Flush{} of {V:1}#2#{}",
      "becomes",
      "{C:attention}#1#{}",
      "{s:0.8}(Effect adapts to most owned suit)"
      }
    },
    config = { extra = { hand_text = "Matesprit", suit = 'Hearts' } },
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = {set = "Other", key = "quadrant_hands", specific_vars = {card.ability.extra.hand_text}} 
      return { vars = { card.ability.extra.hand_text, localize(card.ability.extra.suit, 'suits_plural'), colours = {G.C.SUITS[card.ability.extra.suit]} } }
    end,
  
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 1, y = 5 },
    cost = 5,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable

    remove_from_deck = function(self, card, context)
    SHIPPINGWALL_HAND = nil
    end,
    
    update = function(self, card, initial, delay_sprites)
    local suits = {
        ['Hearts'] = 0,
        ['Diamonds'] = 0,
        ['Spades'] = 0,
        ['Clubs'] = 0
    }

    local hands = {
      ['Hearts'] = "Matesprit",
      ['Diamonds'] = "Moirail",
      ['Spades'] = "Kismesis",
      ['Clubs'] = "Auspistice"
  }

    if G.playing_cards then
      for i = 1, #G.playing_cards do
              if G.playing_cards[i]:is_suit('Hearts', true) then suits["Hearts"] = suits["Hearts"] + 1
              elseif G.playing_cards[i]:is_suit('Diamonds', true)  then suits["Diamonds"] = suits["Diamonds"] + 1
              elseif G.playing_cards[i]:is_suit('Spades', true)  then suits["Spades"] = suits["Spades"] + 1
              elseif G.playing_cards[i]:is_suit('Clubs', true)  then suits["Clubs"] = suits["Clubs"] + 1 end
      end
    end
    
    local highestnumber = 0
    for k, v in pairs(suits) do
      if v > highestnumber then
        highestnumber = v
        card.ability.extra.suit = k
      end
    end

    if next(find_joker("j_garb_shipping")) then
      SHIPPINGWALL_HAND = hands[card.ability.extra.suit]
    end
    card.ability.extra.hand_text = hands[card.ability.extra.suit]
    end,
  
  },

  }