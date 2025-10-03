return {
  config = { extra = 6 },

  loc_vars = function(self, infoq, card)
    return { vars = { G.GAME.probabilities.normal, card.ability.extra } }
  end,

  can_use = function(self, card)
    return #G.consumeables.cards - ((card.edition and card.edition.negative) and 0 or 1) < G.consumeables.config.card_limit
  end,

  use = function(self, card)
    if #G.consumeables.cards >= G.consumeables.config.card_limit then
      return
    end
    if pseudorandom("c_bplus_sigil_blank_create") > G.GAME.probabilities.normal / card.ability.extra then
      return
    end

    play_sound("timpani")
    card:juice_up(0.3, 0.5)

    G.E_MANAGER:add_event(Event {
      delay = 0.5,
      func = function()
        SMODS.add_card {
          set = "sigil",
          area = G.consumeables,
          skip_materialize = true,
          key_append = "c_bplus_sigil_blank_card",
        }
        return true
      end,
    })
  end,

  calculate = function(self, card, ctx)
    if ctx.end_of_round and ctx.cardarea == G.consumeables then
      card.ability.extra = math.max(card.ability.extra - 1, 1)
    end
  end,
}
