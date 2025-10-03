return {
 SMODS.Enhancement {
	key = "royal",
	atlas = "GarbEnhancements",
	pos = {x = 3, y = 0},
	
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
	
	config = {extra = {active = false }},
	
	loc_vars = function(self, info_queue, card)
        return { vars = {  }}
    end,
  
  calculate = function(self, card, context)
    if context.hand_drawn and context.cardarea == G.hand and not card.ability.extra.active then
      G.hand:change_size(1)
      card.ability.extra.active = true
    end

    if context.after then
      if card.ability.extra.active then
        card.ability.extra.active = false
        G.hand:change_size(-1)
      end
      if context.cardarea == G.hand then
        draw_card(G.hand,G.discard, 90, 'up', nil, card)  
      end
    end
  end,

  remove_from_deck = function(self, card, from_debuff)
    if card.ability.extra.active then
      G.hand:change_size(-1)
    end
  end
}
}