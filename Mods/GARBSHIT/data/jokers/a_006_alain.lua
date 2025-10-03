return {
 SMODS.Joker {
    key = 'alain',
    loc_txt = {
      name = 'Alain',
      text = {
        "When hand is played", 
        "creates a {C:planet}Planet{} card",
        "for played {C:attention}poker hand",
        "and a {C:dark_edition}Negative{} of it",
      },
      unlock = {
        "{E:1,s:1.3}?????"
      }
    },
    config = { extra = {} },
    rarity = 4,
    atlas = 'GarbJokers',
    pos = { x = 0, y = 6 },
    soul_pos = { x = 1, y = 6 },
    cost = 20,

    unlocked = false, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable

    add_to_deck = function(self, card)
      check_for_unlock({ type = "discover_alain" })
    end,

    calculate = function(self, card, context)
      if context.after and not context.debuffed_hand then
        G.E_MANAGER:add_event(Event({
          func = function()
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
              if v.config.hand_type == context.scoring_name then
                _planet = v.key
              end
            end
            local _card = SMODS.create_card{key = _planet or "c_jupiter", no_edition = true}
            _card:set_edition('e_negative', true)
            _card:add_to_deck()
            G.consumeables:emplace(_card)
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local _card2 = SMODS.create_card{key = _planet or "c_jupiter", no_edition = true}
            _card2:add_to_deck()
            G.consumeables:emplace(_card2)
            end
            return true
          end
        }))
        return {
          message = localize('k_plus_planet'),
            colour = G.C.PLANET,
            card = card or context.blueprint_card
          }
    end
  end
},
  
}