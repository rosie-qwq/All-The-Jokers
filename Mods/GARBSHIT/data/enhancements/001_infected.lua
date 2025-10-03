return {
 SMODS.Enhancement {
	key = "infected",
	atlas = "GarbEnhancements",
	pos = {x = 0, y = 0},
	
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
	
	config = {extra = { odds = 4, rounds = 4, mult_gain = 2}},
	
	loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.rounds }}
    end,
	
	calculate = function(self, card, context)    
    if context.cardarea == G.hand and context.main_scoring then
      for i = 1, #G.hand.cards do
        if G.hand.cards[i] == card then
          if G.hand.cards[i-1] and pseudorandom('Virus') < G.GAME.probabilities.normal/card.ability.extra.odds and card.justInfected ~= true then 
            G.hand.cards[i-1]:set_ability(G.P_CENTERS["m_garb_infected"]) 
            play_sound('garb_infect', 0.9 + math.random()*0.1, 0.8)
            G.hand.cards[i-1]:juice_up(0.3, 0.4)
            G.hand.cards[i-1].justInfected = false -- This has no purpose yet, other than having justInfected not be nil, in case i want to use it for something in the future
          end

          if G.hand.cards[i+1] and pseudorandom('Virus') < G.GAME.probabilities.normal/card.ability.extra.odds and card.justinfected ~= true then 
            G.hand.cards[i+1]:set_ability(G.P_CENTERS["m_garb_infected"]) 
            play_sound('garb_infect', 0.9 + math.random()*0.1, 0.8)
            G.hand.cards[i+1]:juice_up(0.3, 0.4)
            G.hand.cards[i+1].justInfected = true
          end
          card.justinfected = false
        end
      end
    end

    if context.end_of_round then
      if not card.triggered then
        card.ability.extra.rounds = card.ability.extra.rounds - 1
        if card.ability.extra.rounds == 0 then
          card.destroyme = true
          card_eval_status_text(G.deck, 'extra', nil, nil, nil, { message = "Destroyed!" })
          card:start_dissolve(nil, _first_dissolve)
				  _first_dissolve = true
        end
      end
      card.triggered = true
    end

    if context.blind then
      card.triggered = false
    end
    
    if context.destroying_card and context.destroying_card.destroyme then return {remove = true} end
  end
},

}