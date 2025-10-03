return {
 SMODS.Joker {
    key = 'onibi',
    loc_txt = {
      name = 'Onibi',
      text = {
        "When any {C:attention}Joker{} is sold,",
        "{C:green}#3# in #2#{} chance to create a",
        "{C:spectral}Spectral{} card"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {odds = 4} },
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 2, y = 0 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 5,
      loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult,card.ability.extra.odds, G.GAME.probabilities.normal} }
    end,
      
     calculate = function(self, card, context)
      if context.selling_card and context.card.config.center.set == "Joker" and pseudorandom('ONIBI') < G.GAME.probabilities.normal/card.ability.extra.odds then
          if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                      G.E_MANAGER:add_event(Event({
                          func = (function()
                                  local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'sixth')
                                  card:add_to_deck()
                                  G.consumeables:emplace(card)
                                  G.GAME.consumeable_buffer = 0
                              return true
                          end)}))
                      card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                  end
      end
    end
  },  
  }