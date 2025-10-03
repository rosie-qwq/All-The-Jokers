return {
 SMODS.Joker {
    key = 'archive',
    loc_txt = {
      name = 'The Archives',
      text = {
        "When {C:attention}Blind{} is selected,",
        "{C:attention}archives{} all {C:attention}Enhanced{} cards",
        "{X:mult,C:white} X#1# {} Mult for each card {C:attention}archived",
        "{s:0.8,C:inactive}(All archived cards are returned",
        "{s:0.8,C:inactive}to deck after hand is played)",
        "{C:inactive}(Currently: {X:mult,C:white} X#2# {}{C:inactive} Mult)"
      }
    },
    config = { extra = { Xmult = 1, Xmult_gain = 0.2 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 2, y = 5 },
    soul_pos = { x = 3, y = 5 },
    cost = 8,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
        
    calculate = function(self, card, context)
    if context.blind and not context.blueprint then
      local hand_count = #G.deck.cards
		  for i = 1, hand_count do
        if G.deck.cards[i].ability.set == 'Enhanced' then
			    draw_card(G.deck, G.garb_archived, i * 100 / hand_count, "up", nil, G.deck.cards[i], 0.035)
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
          archived = true
		    end
      end
        if archived then
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Archived!"})
        end
        local eval = function() return #G.garb_archived.cards > 0 or false end
        juice_card_until(card, eval, true)
    end

    if context.joker_main then
      if card.ability.extra.Xmult > 1 then
      return {
          Xmult_mod = card.ability.extra.Xmult,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
          card = card
        }
      end
    end

    if context.post_joker then
      archived = false
      returned = false
      card.ability.extra.Xmult = 1
      for k, v in pairs(G.garb_archived.cards) do
			  draw_card(G.garb_archived, G.deck, k * 100 / #G.garb_archived.cards, "down", nil, v, 0.035)
        returned = true
      end
      if returned then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Returned!"})
      end
    end
  end
},

}