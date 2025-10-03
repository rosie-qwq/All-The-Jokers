return {
 SMODS.Joker {
  key = 'albero',
  loc_txt = {
    name = 'Albero',
    text = {
      "Retrigger all played",
      "{C:attention}enhanced{} cards",
      "{C:attention}#1#{} additional times"
    },
    unlock = {
      "{E:1,s:1.3}?????"
    }
  },
  config = { extra = { retriggers = 2 } },
  rarity = 4,
  atlas = 'GarbJokers',
  pos = { x = 4, y = 7 },
  soul_pos = { x = 5, y = 7 },
  cost = 20,

  unlocked = false, 
  discovered = false, --whether or not it starts discovered
  blueprint_compat = true, --can it be blueprinted/brainstormed/other
  eternal_compat = false, --can it be eternal
  perishable_compat = false, --can it be perishable

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.retriggers } }
  end,

  add_to_deck = function(self, card)
    check_for_unlock({ type = "discover_albero" })
  end,

  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      if context.other_card.ability.set == 'Enhanced' then
        return {
          message = 'Again!',
          message_card = context.blueprint_card or card,
          repetitions = card.ability.extra.retriggers,
          card = context.other_card
        }
      end
    end
  end
},

}